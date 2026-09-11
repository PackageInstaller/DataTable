return {
	Play418111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 418111001
		arg_1_1.duration_ = 6.37

		local var_1_0 = {
			ja = 6.36666666666667,
			CriLanguages = 5.23266666666667,
			zh = 5.23266666666667
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
				arg_1_0:Play418111002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.SS1802 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1802")
				var_4_0.name = "SS1802"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.SS1802 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.SS1802

				arg_1_1.bgs_.SS1802.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "SS1802" then
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

			local var_4_9 = "1095"

			if arg_1_1.actors_["1095"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1095")

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

			local var_4_12 = arg_1_1.actors_["1095"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1095 == nil then
				arg_1_1.var_.actorSpriteComps1095 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps1095 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1095:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 0) / var_4_13), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 0) / var_4_13), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 0) / var_4_13)))
							else
								local var_4_14 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 0) / var_4_13)

								iter_4_5.color = Color.New(var_4_14, var_4_14, var_4_14)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 0 + var_4_13 and arg_1_1.time_ < 0 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1095 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1095 = nil
			end

			local var_4_15 = arg_1_1.bgs_.SS1802.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosSS1802 = var_4_15.localPosition
			end

			local var_4_16 = 0.0666666666666667

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_16 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosSS1802, Vector3.New(0, 1, 9), (arg_1_1.time_ - 0) / var_4_16)
			end

			if arg_1_1.time_ >= 0 + var_4_16 and arg_1_1.time_ < 0 + var_4_16 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(0, 1, 9)
			end

			local var_4_17 = arg_1_1.bgs_.SS1802.transform

			if 0.0666666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.0666666666666667 + arg_4_0 then
				arg_1_1.var_.moveOldPosSS1802 = var_4_17.localPosition
			end

			local var_4_18 = 1.9

			if 0.0666666666666667 <= arg_1_1.time_ and arg_1_1.time_ < 0.0666666666666667 + var_4_18 then
				var_4_17.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosSS1802, Vector3.New(0, 1, 10), (arg_1_1.time_ - 0.0666666666666667) / var_4_18)
			end

			if arg_1_1.time_ >= 0.0666666666666667 + var_4_18 and arg_1_1.time_ < 0.0666666666666667 + var_4_18 + arg_4_0 then
				var_4_17.localPosition = Vector3.New(0, 1, 10)
			end

			if 0.05 < arg_1_1.time_ and arg_1_1.time_ <= 0.05 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_street", "")
			end

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_4_0_story_citong_daily", "bgm_activity_4_0_story_citong_daily")

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_23 = arg_1_1.var_.effect444

				if not arg_1_1.var_.effect444 then
					var_4_23 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_out"), manager.ui.mainCamera.transform)
					var_4_23.name = "444"
					arg_1_1.var_.effect444 = var_4_23
				else
					var_4_23.transform:SetParent(var_4_9000)
				end

				var_4_23.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_23.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 1.86666666666667
			local var_4_26 = 0.45

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_27:setOnUpdate(nil):setOnComplete(nil)
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

				local var_4_28 = arg_1_1:GetWordFromCfg(418111001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 18 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 18)

				if (18 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 18)) > 0 and var_4_26 < var_4_31 then
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

				if manager.audio:GetVoiceLength("story_v_side_old_418111", "418111001", "story_v_side_old_418111.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_side_old_418111", "418111001", "story_v_side_old_418111.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_side_old_418111", "418111001", "story_v_side_old_418111.awb")

						arg_1_1:RecordAudio("418111001", var_4_33)
						arg_1_1:RecordAudio("418111001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_old_418111", "418111001", "story_v_side_old_418111.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_old_418111", "418111001", "story_v_side_old_418111.awb")
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
				actorName = "SS1802",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0666666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1802",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.9,
				className = "StoryMoveNode",
				startTime = 0.0666666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play418111002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 418111002
		arg_8_1.duration_ = 9.37

		local var_8_0 = {
			ja = 9.366,
			CriLanguages = 7.733,
			zh = 7.733
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
				arg_8_0:Play418111003(arg_8_1)
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

			local var_11_5 = arg_8_1.actors_["1095"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.actorSpriteComps1095 == nil then
				arg_8_1.var_.actorSpriteComps1095 = var_11_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_6 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_6 and not isNil(var_11_5) then
				if arg_8_1.var_.actorSpriteComps1095 then
					for iter_11_6, iter_11_7 in pairs(arg_8_1.var_.actorSpriteComps1095:ToTable()) do
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

			if arg_8_1.time_ >= 0 + var_11_6 and arg_8_1.time_ < 0 + var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.actorSpriteComps1095 then
				for iter_11_8, iter_11_9 in pairs(arg_8_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_11_9 then
						iter_11_9.color = arg_8_1.isInRecall_ and (arg_8_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_8_1.var_.actorSpriteComps1095 = nil
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				if arg_8_1.var_.effect444 then
					Object.Destroy(arg_8_1.var_.effect444)

					arg_8_1.var_.effect444 = nil
				end
			end

			local var_11_9 = 0
			local var_11_10 = 0.975

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_9 + arg_11_0 then
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

				local var_11_11 = arg_8_1:GetWordFromCfg(418111002)
				local var_11_12 = arg_8_1:FormatText(var_11_11.content)

				arg_8_1.text_.text = var_11_12

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_14 = 39 <= 0 and var_11_10 or var_11_10 * (utf8.len(var_11_12) / 39)

				if (39 <= 0 and var_11_10 or var_11_10 * (utf8.len(var_11_12) / 39)) > 0 and var_11_10 < var_11_14 then
					arg_8_1.talkMaxDuration = var_11_14

					if var_11_14 + var_11_9 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_9
					end
				end

				arg_8_1.text_.text = var_11_12
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418111", "418111002", "story_v_side_old_418111.awb") ~= 0 then
					local var_11_15 = manager.audio:GetVoiceLength("story_v_side_old_418111", "418111002", "story_v_side_old_418111.awb") / 1000

					if var_11_15 + var_11_9 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_15 + var_11_9
					end

					if var_11_11.prefab_name ~= "" and arg_8_1.actors_[var_11_11.prefab_name] ~= nil then
						local var_11_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_11.prefab_name].transform, "story_v_side_old_418111", "418111002", "story_v_side_old_418111.awb")

						arg_8_1:RecordAudio("418111002", var_11_16)
						arg_8_1:RecordAudio("418111002", var_11_16)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_side_old_418111", "418111002", "story_v_side_old_418111.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_side_old_418111", "418111002", "story_v_side_old_418111.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_17 = math.max(var_11_10, arg_8_1.talkMaxDuration)

			if var_11_9 <= arg_8_1.time_ and arg_8_1.time_ < var_11_9 + var_11_17 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_9) / var_11_17

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_9 + var_11_17 and arg_8_1.time_ < var_11_9 + var_11_17 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play418111003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 418111003
		arg_12_1.duration_ = 5.7

		local var_12_0 = {
			ja = 5.7,
			CriLanguages = 4.566,
			zh = 4.566
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
				arg_12_0:Play418111004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.575

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_1 = arg_12_1:GetWordFromCfg(418111003)
				local var_15_2 = arg_12_1:FormatText(var_15_1.content)

				arg_12_1.text_.text = var_15_2

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_4 = 23 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 23)

				if (23 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_2) / 23)) > 0 and var_15_0 < var_15_4 then
					arg_12_1.talkMaxDuration = var_15_4

					if var_15_4 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_4 + 0
					end
				end

				arg_12_1.text_.text = var_15_2
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418111", "418111003", "story_v_side_old_418111.awb") ~= 0 then
					local var_15_5 = manager.audio:GetVoiceLength("story_v_side_old_418111", "418111003", "story_v_side_old_418111.awb") / 1000

					if var_15_5 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + 0
					end

					if var_15_1.prefab_name ~= "" and arg_12_1.actors_[var_15_1.prefab_name] ~= nil then
						local var_15_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_1.prefab_name].transform, "story_v_side_old_418111", "418111003", "story_v_side_old_418111.awb")

						arg_12_1:RecordAudio("418111003", var_15_6)
						arg_12_1:RecordAudio("418111003", var_15_6)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_side_old_418111", "418111003", "story_v_side_old_418111.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_side_old_418111", "418111003", "story_v_side_old_418111.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_7 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_7

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play418111004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 418111004
		arg_16_1.duration_ = 7.33

		local var_16_0 = {
			ja = 7.333,
			CriLanguages = 6.7,
			zh = 6.7
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
				arg_16_0:Play418111005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.875

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
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

				local var_19_1 = arg_16_1:GetWordFromCfg(418111004)
				local var_19_2 = arg_16_1:FormatText(var_19_1.content)

				arg_16_1.text_.text = var_19_2

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_4 = 35 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 35)

				if (35 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_2) / 35)) > 0 and var_19_0 < var_19_4 then
					arg_16_1.talkMaxDuration = var_19_4

					if var_19_4 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_4 + 0
					end
				end

				arg_16_1.text_.text = var_19_2
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418111", "418111004", "story_v_side_old_418111.awb") ~= 0 then
					local var_19_5 = manager.audio:GetVoiceLength("story_v_side_old_418111", "418111004", "story_v_side_old_418111.awb") / 1000

					if var_19_5 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + 0
					end

					if var_19_1.prefab_name ~= "" and arg_16_1.actors_[var_19_1.prefab_name] ~= nil then
						local var_19_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_1.prefab_name].transform, "story_v_side_old_418111", "418111004", "story_v_side_old_418111.awb")

						arg_16_1:RecordAudio("418111004", var_19_6)
						arg_16_1:RecordAudio("418111004", var_19_6)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_side_old_418111", "418111004", "story_v_side_old_418111.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_side_old_418111", "418111004", "story_v_side_old_418111.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play418111005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 418111005
		arg_20_1.duration_ = 8.53

		local var_20_0 = {
			ja = 8.533,
			CriLanguages = 6.3,
			zh = 6.3
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
				arg_20_0:Play418111006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1095"]) and arg_20_1.var_.actorSpriteComps1095 == nil then
				arg_20_1.var_.actorSpriteComps1095 = arg_20_1.actors_["1095"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_0 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1095"]) then
				if arg_20_1.var_.actorSpriteComps1095 then
					for iter_23_0, iter_23_1 in pairs(arg_20_1.var_.actorSpriteComps1095:ToTable()) do
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

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1095"]) and arg_20_1.var_.actorSpriteComps1095 then
				for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_23_3 then
						iter_23_3.color = arg_20_1.isInRecall_ and (arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_20_1.var_.actorSpriteComps1095 = nil
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
			local var_23_6 = 0.775

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

				local var_23_7 = arg_20_1:GetWordFromCfg(418111005)
				local var_23_8 = arg_20_1:FormatText(var_23_7.content)

				arg_20_1.text_.text = var_23_8

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_10 = 31 <= 0 and var_23_6 or var_23_6 * (utf8.len(var_23_8) / 31)

				if (31 <= 0 and var_23_6 or var_23_6 * (utf8.len(var_23_8) / 31)) > 0 and var_23_6 < var_23_10 then
					arg_20_1.talkMaxDuration = var_23_10

					if var_23_10 + var_23_5 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_5
					end
				end

				arg_20_1.text_.text = var_23_8
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418111", "418111005", "story_v_side_old_418111.awb") ~= 0 then
					local var_23_11 = manager.audio:GetVoiceLength("story_v_side_old_418111", "418111005", "story_v_side_old_418111.awb") / 1000

					if var_23_11 + var_23_5 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_11 + var_23_5
					end

					if var_23_7.prefab_name ~= "" and arg_20_1.actors_[var_23_7.prefab_name] ~= nil then
						local var_23_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_7.prefab_name].transform, "story_v_side_old_418111", "418111005", "story_v_side_old_418111.awb")

						arg_20_1:RecordAudio("418111005", var_23_12)
						arg_20_1:RecordAudio("418111005", var_23_12)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_side_old_418111", "418111005", "story_v_side_old_418111.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_side_old_418111", "418111005", "story_v_side_old_418111.awb")
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
	Play418111006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 418111006
		arg_24_1.duration_ = 7.33

		local var_24_0 = {
			ja = 6.466,
			CriLanguages = 7.333,
			zh = 7.333
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
				arg_24_0:Play418111007(arg_24_1)
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

			local var_27_2 = arg_24_1.actors_["1095"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.actorSpriteComps1095 == nil then
				arg_24_1.var_.actorSpriteComps1095 = var_27_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_3 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_3 and not isNil(var_27_2) then
				if arg_24_1.var_.actorSpriteComps1095 then
					for iter_27_4, iter_27_5 in pairs(arg_24_1.var_.actorSpriteComps1095:ToTable()) do
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

			if arg_24_1.time_ >= 0 + var_27_3 and arg_24_1.time_ < 0 + var_27_3 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.actorSpriteComps1095 then
				for iter_27_6, iter_27_7 in pairs(arg_24_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_27_7 then
						iter_27_7.color = arg_24_1.isInRecall_ and (arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_24_1.var_.actorSpriteComps1095 = nil
			end

			local var_27_5 = 0
			local var_27_6 = 0.85

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

				local var_27_7 = arg_24_1:GetWordFromCfg(418111006)
				local var_27_8 = arg_24_1:FormatText(var_27_7.content)

				arg_24_1.text_.text = var_27_8

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_10 = 34 <= 0 and var_27_6 or var_27_6 * (utf8.len(var_27_8) / 34)

				if (34 <= 0 and var_27_6 or var_27_6 * (utf8.len(var_27_8) / 34)) > 0 and var_27_6 < var_27_10 then
					arg_24_1.talkMaxDuration = var_27_10

					if var_27_10 + var_27_5 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_5
					end
				end

				arg_24_1.text_.text = var_27_8
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418111", "418111006", "story_v_side_old_418111.awb") ~= 0 then
					local var_27_11 = manager.audio:GetVoiceLength("story_v_side_old_418111", "418111006", "story_v_side_old_418111.awb") / 1000

					if var_27_11 + var_27_5 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_11 + var_27_5
					end

					if var_27_7.prefab_name ~= "" and arg_24_1.actors_[var_27_7.prefab_name] ~= nil then
						local var_27_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_7.prefab_name].transform, "story_v_side_old_418111", "418111006", "story_v_side_old_418111.awb")

						arg_24_1:RecordAudio("418111006", var_27_12)
						arg_24_1:RecordAudio("418111006", var_27_12)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_side_old_418111", "418111006", "story_v_side_old_418111.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_side_old_418111", "418111006", "story_v_side_old_418111.awb")
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
	Play418111007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 418111007
		arg_28_1.duration_ = 6.8

		local var_28_0 = {
			ja = 6.8,
			CriLanguages = 5.966,
			zh = 5.966
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
				arg_28_0:Play418111008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.8

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

				local var_31_1 = arg_28_1:GetWordFromCfg(418111007)
				local var_31_2 = arg_28_1:FormatText(var_31_1.content)

				arg_28_1.text_.text = var_31_2

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_4 = 32 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 32)

				if (32 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_2) / 32)) > 0 and var_31_0 < var_31_4 then
					arg_28_1.talkMaxDuration = var_31_4

					if var_31_4 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_4 + 0
					end
				end

				arg_28_1.text_.text = var_31_2
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418111", "418111007", "story_v_side_old_418111.awb") ~= 0 then
					local var_31_5 = manager.audio:GetVoiceLength("story_v_side_old_418111", "418111007", "story_v_side_old_418111.awb") / 1000

					if var_31_5 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + 0
					end

					if var_31_1.prefab_name ~= "" and arg_28_1.actors_[var_31_1.prefab_name] ~= nil then
						local var_31_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_1.prefab_name].transform, "story_v_side_old_418111", "418111007", "story_v_side_old_418111.awb")

						arg_28_1:RecordAudio("418111007", var_31_6)
						arg_28_1:RecordAudio("418111007", var_31_6)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_side_old_418111", "418111007", "story_v_side_old_418111.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_side_old_418111", "418111007", "story_v_side_old_418111.awb")
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
	Play418111008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 418111008
		arg_32_1.duration_ = 4.7

		local var_32_0 = {
			ja = 4.033,
			CriLanguages = 4.7,
			zh = 4.7
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
				arg_32_0:Play418111009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.425

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_1 = arg_32_1:GetWordFromCfg(418111008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 17 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 17)

				if (17 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 17)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418111", "418111008", "story_v_side_old_418111.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_side_old_418111", "418111008", "story_v_side_old_418111.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_side_old_418111", "418111008", "story_v_side_old_418111.awb")

						arg_32_1:RecordAudio("418111008", var_35_6)
						arg_32_1:RecordAudio("418111008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_side_old_418111", "418111008", "story_v_side_old_418111.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_side_old_418111", "418111008", "story_v_side_old_418111.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play418111009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 418111009
		arg_36_1.duration_ = 4.8

		local var_36_0 = {
			ja = 4.8,
			CriLanguages = 4.6,
			zh = 4.6
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
				arg_36_0:Play418111010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1095"]) and arg_36_1.var_.actorSpriteComps1095 == nil then
				arg_36_1.var_.actorSpriteComps1095 = arg_36_1.actors_["1095"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_0 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1095"]) then
				if arg_36_1.var_.actorSpriteComps1095 then
					for iter_39_0, iter_39_1 in pairs(arg_36_1.var_.actorSpriteComps1095:ToTable()) do
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

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1095"]) and arg_36_1.var_.actorSpriteComps1095 then
				for iter_39_2, iter_39_3 in pairs(arg_36_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_39_3 then
						iter_39_3.color = arg_36_1.isInRecall_ and (arg_36_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_36_1.var_.actorSpriteComps1095 = nil
			end

			local var_39_2 = arg_36_1.actors_["10135"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.actorSpriteComps10135 == nil then
				arg_36_1.var_.actorSpriteComps10135 = var_39_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_39_3 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.actorSpriteComps10135 then
					for iter_39_4, iter_39_5 in pairs(arg_36_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.actorSpriteComps10135 then
				for iter_39_6, iter_39_7 in pairs(arg_36_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_39_7 then
						iter_39_7.color = arg_36_1.isInRecall_ and (arg_36_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_36_1.var_.actorSpriteComps10135 = nil
			end

			local var_39_5 = 0
			local var_39_6 = 0.625

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 then
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

				local var_39_7 = arg_36_1:GetWordFromCfg(418111009)
				local var_39_8 = arg_36_1:FormatText(var_39_7.content)

				arg_36_1.text_.text = var_39_8

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_10 = 25 <= 0 and var_39_6 or var_39_6 * (utf8.len(var_39_8) / 25)

				if (25 <= 0 and var_39_6 or var_39_6 * (utf8.len(var_39_8) / 25)) > 0 and var_39_6 < var_39_10 then
					arg_36_1.talkMaxDuration = var_39_10

					if var_39_10 + var_39_5 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_5
					end
				end

				arg_36_1.text_.text = var_39_8
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418111", "418111009", "story_v_side_old_418111.awb") ~= 0 then
					local var_39_11 = manager.audio:GetVoiceLength("story_v_side_old_418111", "418111009", "story_v_side_old_418111.awb") / 1000

					if var_39_11 + var_39_5 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_11 + var_39_5
					end

					if var_39_7.prefab_name ~= "" and arg_36_1.actors_[var_39_7.prefab_name] ~= nil then
						local var_39_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_7.prefab_name].transform, "story_v_side_old_418111", "418111009", "story_v_side_old_418111.awb")

						arg_36_1:RecordAudio("418111009", var_39_12)
						arg_36_1:RecordAudio("418111009", var_39_12)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_side_old_418111", "418111009", "story_v_side_old_418111.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_side_old_418111", "418111009", "story_v_side_old_418111.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_13 = math.max(var_39_6, arg_36_1.talkMaxDuration)

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_13 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_5) / var_39_13

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_5 + var_39_13 and arg_36_1.time_ < var_39_5 + var_39_13 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play418111010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 418111010
		arg_40_1.duration_ = 6.13

		local var_40_0 = {
			ja = 6.133,
			CriLanguages = 5.8,
			zh = 5.8
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
				arg_40_0:Play418111011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["10135"]) and arg_40_1.var_.actorSpriteComps10135 == nil then
				arg_40_1.var_.actorSpriteComps10135 = arg_40_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_0 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["10135"]) then
				if arg_40_1.var_.actorSpriteComps10135 then
					for iter_43_0, iter_43_1 in pairs(arg_40_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["10135"]) and arg_40_1.var_.actorSpriteComps10135 then
				for iter_43_2, iter_43_3 in pairs(arg_40_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_43_3 then
						iter_43_3.color = arg_40_1.isInRecall_ and (arg_40_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_40_1.var_.actorSpriteComps10135 = nil
			end

			local var_43_2 = arg_40_1.actors_["1095"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.actorSpriteComps1095 == nil then
				arg_40_1.var_.actorSpriteComps1095 = var_43_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_43_3 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.actorSpriteComps1095 then
					for iter_43_4, iter_43_5 in pairs(arg_40_1.var_.actorSpriteComps1095:ToTable()) do
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

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.actorSpriteComps1095 then
				for iter_43_6, iter_43_7 in pairs(arg_40_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_43_7 then
						iter_43_7.color = arg_40_1.isInRecall_ and (arg_40_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_40_1.var_.actorSpriteComps1095 = nil
			end

			local var_43_5 = 0
			local var_43_6 = 0.7

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_7 = arg_40_1:GetWordFromCfg(418111010)
				local var_43_8 = arg_40_1:FormatText(var_43_7.content)

				arg_40_1.text_.text = var_43_8

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_10 = 28 <= 0 and var_43_6 or var_43_6 * (utf8.len(var_43_8) / 28)

				if (28 <= 0 and var_43_6 or var_43_6 * (utf8.len(var_43_8) / 28)) > 0 and var_43_6 < var_43_10 then
					arg_40_1.talkMaxDuration = var_43_10

					if var_43_10 + var_43_5 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_5
					end
				end

				arg_40_1.text_.text = var_43_8
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418111", "418111010", "story_v_side_old_418111.awb") ~= 0 then
					local var_43_11 = manager.audio:GetVoiceLength("story_v_side_old_418111", "418111010", "story_v_side_old_418111.awb") / 1000

					if var_43_11 + var_43_5 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_11 + var_43_5
					end

					if var_43_7.prefab_name ~= "" and arg_40_1.actors_[var_43_7.prefab_name] ~= nil then
						local var_43_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_7.prefab_name].transform, "story_v_side_old_418111", "418111010", "story_v_side_old_418111.awb")

						arg_40_1:RecordAudio("418111010", var_43_12)
						arg_40_1:RecordAudio("418111010", var_43_12)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_side_old_418111", "418111010", "story_v_side_old_418111.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_side_old_418111", "418111010", "story_v_side_old_418111.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_13 = math.max(var_43_6, arg_40_1.talkMaxDuration)

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_13 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_5) / var_43_13

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_5 + var_43_13 and arg_40_1.time_ < var_43_5 + var_43_13 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play418111011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 418111011
		arg_44_1.duration_ = 3.03

		local var_44_0 = {
			ja = 2.9,
			CriLanguages = 3.033,
			zh = 3.033
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
				arg_44_0:Play418111012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.35

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
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

				local var_47_1 = arg_44_1:GetWordFromCfg(418111011)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 14 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 14)

				if (14 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 14)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418111", "418111011", "story_v_side_old_418111.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_side_old_418111", "418111011", "story_v_side_old_418111.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_side_old_418111", "418111011", "story_v_side_old_418111.awb")

						arg_44_1:RecordAudio("418111011", var_47_6)
						arg_44_1:RecordAudio("418111011", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_side_old_418111", "418111011", "story_v_side_old_418111.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_side_old_418111", "418111011", "story_v_side_old_418111.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play418111012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 418111012
		arg_48_1.duration_ = 1.33

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play418111013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1095"]) and arg_48_1.var_.actorSpriteComps1095 == nil then
				arg_48_1.var_.actorSpriteComps1095 = arg_48_1.actors_["1095"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_0 = 0.2

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1095"]) then
				if arg_48_1.var_.actorSpriteComps1095 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps1095:ToTable()) do
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

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1095"]) and arg_48_1.var_.actorSpriteComps1095 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_51_3 then
						iter_51_3.color = arg_48_1.isInRecall_ and (arg_48_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_48_1.var_.actorSpriteComps1095 = nil
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

			local var_51_5 = 0
			local var_51_6 = 0.125

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_7 = arg_48_1:GetWordFromCfg(418111012)
				local var_51_8 = arg_48_1:FormatText(var_51_7.content)

				arg_48_1.text_.text = var_51_8

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_10 = 5 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_8) / 5)

				if (5 <= 0 and var_51_6 or var_51_6 * (utf8.len(var_51_8) / 5)) > 0 and var_51_6 < var_51_10 then
					arg_48_1.talkMaxDuration = var_51_10

					if var_51_10 + var_51_5 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_5
					end
				end

				arg_48_1.text_.text = var_51_8
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418111", "418111012", "story_v_side_old_418111.awb") ~= 0 then
					local var_51_11 = manager.audio:GetVoiceLength("story_v_side_old_418111", "418111012", "story_v_side_old_418111.awb") / 1000

					if var_51_11 + var_51_5 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_11 + var_51_5
					end

					if var_51_7.prefab_name ~= "" and arg_48_1.actors_[var_51_7.prefab_name] ~= nil then
						local var_51_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_7.prefab_name].transform, "story_v_side_old_418111", "418111012", "story_v_side_old_418111.awb")

						arg_48_1:RecordAudio("418111012", var_51_12)
						arg_48_1:RecordAudio("418111012", var_51_12)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_side_old_418111", "418111012", "story_v_side_old_418111.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_side_old_418111", "418111012", "story_v_side_old_418111.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_13 = math.max(var_51_6, arg_48_1.talkMaxDuration)

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_13 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_5) / var_51_13

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_5 + var_51_13 and arg_48_1.time_ < var_51_5 + var_51_13 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play418111013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 418111013
		arg_52_1.duration_ = 3.27

		local var_52_0 = {
			ja = 3.133,
			CriLanguages = 3.266,
			zh = 3.266
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
				arg_52_0:Play418111014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["10135"]) and arg_52_1.var_.actorSpriteComps10135 == nil then
				arg_52_1.var_.actorSpriteComps10135 = arg_52_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_0 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["10135"]) then
				if arg_52_1.var_.actorSpriteComps10135 then
					for iter_55_0, iter_55_1 in pairs(arg_52_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["10135"]) and arg_52_1.var_.actorSpriteComps10135 then
				for iter_55_2, iter_55_3 in pairs(arg_52_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_55_3 then
						iter_55_3.color = arg_52_1.isInRecall_ and (arg_52_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_52_1.var_.actorSpriteComps10135 = nil
			end

			local var_55_2 = arg_52_1.actors_["1095"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.actorSpriteComps1095 == nil then
				arg_52_1.var_.actorSpriteComps1095 = var_55_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_55_3 = 0.2

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.actorSpriteComps1095 then
					for iter_55_4, iter_55_5 in pairs(arg_52_1.var_.actorSpriteComps1095:ToTable()) do
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

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.actorSpriteComps1095 then
				for iter_55_6, iter_55_7 in pairs(arg_52_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_55_7 then
						iter_55_7.color = arg_52_1.isInRecall_ and (arg_52_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_52_1.var_.actorSpriteComps1095 = nil
			end

			local var_55_5 = 0
			local var_55_6 = 0.4

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_7 = arg_52_1:GetWordFromCfg(418111013)
				local var_55_8 = arg_52_1:FormatText(var_55_7.content)

				arg_52_1.text_.text = var_55_8

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_10 = 16 <= 0 and var_55_6 or var_55_6 * (utf8.len(var_55_8) / 16)

				if (16 <= 0 and var_55_6 or var_55_6 * (utf8.len(var_55_8) / 16)) > 0 and var_55_6 < var_55_10 then
					arg_52_1.talkMaxDuration = var_55_10

					if var_55_10 + var_55_5 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_5
					end
				end

				arg_52_1.text_.text = var_55_8
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418111", "418111013", "story_v_side_old_418111.awb") ~= 0 then
					local var_55_11 = manager.audio:GetVoiceLength("story_v_side_old_418111", "418111013", "story_v_side_old_418111.awb") / 1000

					if var_55_11 + var_55_5 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_11 + var_55_5
					end

					if var_55_7.prefab_name ~= "" and arg_52_1.actors_[var_55_7.prefab_name] ~= nil then
						local var_55_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_7.prefab_name].transform, "story_v_side_old_418111", "418111013", "story_v_side_old_418111.awb")

						arg_52_1:RecordAudio("418111013", var_55_12)
						arg_52_1:RecordAudio("418111013", var_55_12)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_side_old_418111", "418111013", "story_v_side_old_418111.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_side_old_418111", "418111013", "story_v_side_old_418111.awb")
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
	Play418111014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 418111014
		arg_56_1.duration_ = 7.9

		local var_56_0 = {
			ja = 7.9,
			CriLanguages = 6.5,
			zh = 6.5
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
				arg_56_0:Play418111015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1095"]) and arg_56_1.var_.actorSpriteComps1095 == nil then
				arg_56_1.var_.actorSpriteComps1095 = arg_56_1.actors_["1095"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_0 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1095"]) then
				if arg_56_1.var_.actorSpriteComps1095 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps1095:ToTable()) do
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

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1095"]) and arg_56_1.var_.actorSpriteComps1095 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_59_3 then
						iter_59_3.color = arg_56_1.isInRecall_ and (arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_56_1.var_.actorSpriteComps1095 = nil
			end

			local var_59_2 = arg_56_1.actors_["10135"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.actorSpriteComps10135 == nil then
				arg_56_1.var_.actorSpriteComps10135 = var_59_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_3 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.actorSpriteComps10135 then
					for iter_59_4, iter_59_5 in pairs(arg_56_1.var_.actorSpriteComps10135:ToTable()) do
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

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.actorSpriteComps10135 then
				for iter_59_6, iter_59_7 in pairs(arg_56_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_59_7 then
						iter_59_7.color = arg_56_1.isInRecall_ and (arg_56_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_56_1.var_.actorSpriteComps10135 = nil
			end

			local var_59_5 = arg_56_1.bgs_.SS1802.transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPosSS1802 = var_59_5.localPosition
			end

			local var_59_6 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_6 then
				var_59_5.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPosSS1802, Vector3.New(0, 1, 10), (arg_56_1.time_ - 0) / var_59_6)
			end

			if arg_56_1.time_ >= 0 + var_59_6 and arg_56_1.time_ < 0 + var_59_6 + arg_59_0 then
				var_59_5.localPosition = Vector3.New(0, 1, 10)
			end

			local var_59_7 = arg_56_1.bgs_.SS1802.transform

			if 0.0166666666666667 < arg_56_1.time_ and arg_56_1.time_ <= 0.0166666666666667 + arg_59_0 then
				arg_56_1.var_.moveOldPosSS1802 = var_59_7.localPosition
			end

			local var_59_8 = 2.08333333333333

			if 0.0166666666666667 <= arg_56_1.time_ and arg_56_1.time_ < 0.0166666666666667 + var_59_8 then
				var_59_7.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPosSS1802, Vector3.New(0, 0.55, 7.9), (arg_56_1.time_ - 0.0166666666666667) / var_59_8)
			end

			if arg_56_1.time_ >= 0.0166666666666667 + var_59_8 and arg_56_1.time_ < 0.0166666666666667 + var_59_8 + arg_59_0 then
				var_59_7.localPosition = Vector3.New(0, 0.55, 7.9)
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_9 = 1.6
			local var_59_10 = 0.4

			if 1.6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_11 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_11:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_12 = arg_56_1:GetWordFromCfg(418111014)
				local var_59_13 = arg_56_1:FormatText(var_59_12.content)

				arg_56_1.text_.text = var_59_13

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_15 = 16 <= 0 and var_59_10 or var_59_10 * (utf8.len(var_59_13) / 16)

				if (16 <= 0 and var_59_10 or var_59_10 * (utf8.len(var_59_13) / 16)) > 0 and var_59_10 < var_59_15 then
					arg_56_1.talkMaxDuration = var_59_15
					var_59_9 = var_59_9 + 0.3

					if var_59_15 + var_59_9 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_15 + var_59_9
					end
				end

				arg_56_1.text_.text = var_59_13
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418111", "418111014", "story_v_side_old_418111.awb") ~= 0 then
					local var_59_16 = manager.audio:GetVoiceLength("story_v_side_old_418111", "418111014", "story_v_side_old_418111.awb") / 1000

					if var_59_16 + var_59_9 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_16 + var_59_9
					end

					if var_59_12.prefab_name ~= "" and arg_56_1.actors_[var_59_12.prefab_name] ~= nil then
						local var_59_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_12.prefab_name].transform, "story_v_side_old_418111", "418111014", "story_v_side_old_418111.awb")

						arg_56_1:RecordAudio("418111014", var_59_17)
						arg_56_1:RecordAudio("418111014", var_59_17)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_side_old_418111", "418111014", "story_v_side_old_418111.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_side_old_418111", "418111014", "story_v_side_old_418111.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_18 = var_59_9 + 0.3
			local var_59_19 = math.max(var_59_10, arg_56_1.talkMaxDuration)

			if var_59_9 + 0.3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_18 + var_59_19 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_18) / var_59_19

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_18 + var_59_19 and arg_56_1.time_ < var_59_18 + var_59_19 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1802",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1802",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.08333333333333,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play418111015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 418111015
		arg_62_1.duration_ = 19.47

		local var_62_0 = {
			ja = 19.466,
			CriLanguages = 12.133,
			zh = 12.133
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play418111016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 1.525

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_1 = arg_62_1:GetWordFromCfg(418111015)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 61 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 61)

				if (61 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 61)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418111", "418111015", "story_v_side_old_418111.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_side_old_418111", "418111015", "story_v_side_old_418111.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_side_old_418111", "418111015", "story_v_side_old_418111.awb")

						arg_62_1:RecordAudio("418111015", var_65_6)
						arg_62_1:RecordAudio("418111015", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_side_old_418111", "418111015", "story_v_side_old_418111.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_side_old_418111", "418111015", "story_v_side_old_418111.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play418111016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 418111016
		arg_66_1.duration_ = 11.47

		local var_66_0 = {
			ja = 11.466,
			CriLanguages = 9.233,
			zh = 9.233
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play418111017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["10135"]) and arg_66_1.var_.actorSpriteComps10135 == nil then
				arg_66_1.var_.actorSpriteComps10135 = arg_66_1.actors_["10135"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_0 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["10135"]) then
				if arg_66_1.var_.actorSpriteComps10135 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_69_1 then
							if arg_66_1.isInRecall_ then
								iter_69_1.color = Color.New(Mathf.Lerp(iter_69_1.color.r, arg_66_1.hightColor1.r, (arg_66_1.time_ - 0) / var_69_0), Mathf.Lerp(iter_69_1.color.g, arg_66_1.hightColor1.g, (arg_66_1.time_ - 0) / var_69_0), (Mathf.Lerp(iter_69_1.color.b, arg_66_1.hightColor1.b, (arg_66_1.time_ - 0) / var_69_0)))
							else
								local var_69_1 = Mathf.Lerp(iter_69_1.color.r, 1, (arg_66_1.time_ - 0) / var_69_0)

								iter_69_1.color = Color.New(var_69_1, var_69_1, var_69_1)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["10135"]) and arg_66_1.var_.actorSpriteComps10135 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_69_3 then
						iter_69_3.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_66_1.var_.actorSpriteComps10135 = nil
			end

			local var_69_2 = arg_66_1.actors_["1095"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.actorSpriteComps1095 == nil then
				arg_66_1.var_.actorSpriteComps1095 = var_69_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_3 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_3 and not isNil(var_69_2) then
				if arg_66_1.var_.actorSpriteComps1095 then
					for iter_69_4, iter_69_5 in pairs(arg_66_1.var_.actorSpriteComps1095:ToTable()) do
						if iter_69_5 then
							if arg_66_1.isInRecall_ then
								iter_69_5.color = Color.New(Mathf.Lerp(iter_69_5.color.r, arg_66_1.hightColor2.r, (arg_66_1.time_ - 0) / var_69_3), Mathf.Lerp(iter_69_5.color.g, arg_66_1.hightColor2.g, (arg_66_1.time_ - 0) / var_69_3), (Mathf.Lerp(iter_69_5.color.b, arg_66_1.hightColor2.b, (arg_66_1.time_ - 0) / var_69_3)))
							else
								local var_69_4 = Mathf.Lerp(iter_69_5.color.r, 0.5, (arg_66_1.time_ - 0) / var_69_3)

								iter_69_5.color = Color.New(var_69_4, var_69_4, var_69_4)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= 0 + var_69_3 and arg_66_1.time_ < 0 + var_69_3 + arg_69_0 and not isNil(var_69_2) and arg_66_1.var_.actorSpriteComps1095 then
				for iter_69_6, iter_69_7 in pairs(arg_66_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_69_7 then
						iter_69_7.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_66_1.var_.actorSpriteComps1095 = nil
			end

			local var_69_5 = 0
			local var_69_6 = 1

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1187].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_7 = arg_66_1:GetWordFromCfg(418111016)
				local var_69_8 = arg_66_1:FormatText(var_69_7.content)

				arg_66_1.text_.text = var_69_8

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_10 = 40 <= 0 and var_69_6 or var_69_6 * (utf8.len(var_69_8) / 40)

				if (40 <= 0 and var_69_6 or var_69_6 * (utf8.len(var_69_8) / 40)) > 0 and var_69_6 < var_69_10 then
					arg_66_1.talkMaxDuration = var_69_10

					if var_69_10 + var_69_5 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_10 + var_69_5
					end
				end

				arg_66_1.text_.text = var_69_8
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418111", "418111016", "story_v_side_old_418111.awb") ~= 0 then
					local var_69_11 = manager.audio:GetVoiceLength("story_v_side_old_418111", "418111016", "story_v_side_old_418111.awb") / 1000

					if var_69_11 + var_69_5 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_11 + var_69_5
					end

					if var_69_7.prefab_name ~= "" and arg_66_1.actors_[var_69_7.prefab_name] ~= nil then
						local var_69_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_7.prefab_name].transform, "story_v_side_old_418111", "418111016", "story_v_side_old_418111.awb")

						arg_66_1:RecordAudio("418111016", var_69_12)
						arg_66_1:RecordAudio("418111016", var_69_12)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_side_old_418111", "418111016", "story_v_side_old_418111.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_side_old_418111", "418111016", "story_v_side_old_418111.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_13 = math.max(var_69_6, arg_66_1.talkMaxDuration)

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_13 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_5) / var_69_13

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_5 + var_69_13 and arg_66_1.time_ < var_69_5 + var_69_13 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play418111017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 418111017
		arg_70_1.duration_ = 4

		local var_70_0 = {
			ja = 4,
			CriLanguages = 2.066,
			zh = 2.066
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
			arg_70_1.auto_ = false
		end

		function arg_70_1.playNext_(arg_72_0)
			arg_70_1.onStoryFinished_()
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1095"]) and arg_70_1.var_.actorSpriteComps1095 == nil then
				arg_70_1.var_.actorSpriteComps1095 = arg_70_1.actors_["1095"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_0 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1095"]) then
				if arg_70_1.var_.actorSpriteComps1095 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps1095:ToTable()) do
						if iter_73_1 then
							if arg_70_1.isInRecall_ then
								iter_73_1.color = Color.New(Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor1.r, (arg_70_1.time_ - 0) / var_73_0), Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor1.g, (arg_70_1.time_ - 0) / var_73_0), (Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor1.b, (arg_70_1.time_ - 0) / var_73_0)))
							else
								local var_73_1 = Mathf.Lerp(iter_73_1.color.r, 1, (arg_70_1.time_ - 0) / var_73_0)

								iter_73_1.color = Color.New(var_73_1, var_73_1, var_73_1)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1095"]) and arg_70_1.var_.actorSpriteComps1095 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps1095:ToTable()) do
					if iter_73_3 then
						iter_73_3.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_70_1.var_.actorSpriteComps1095 = nil
			end

			local var_73_2 = arg_70_1.actors_["10135"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.actorSpriteComps10135 == nil then
				arg_70_1.var_.actorSpriteComps10135 = var_73_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_3 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_3 and not isNil(var_73_2) then
				if arg_70_1.var_.actorSpriteComps10135 then
					for iter_73_4, iter_73_5 in pairs(arg_70_1.var_.actorSpriteComps10135:ToTable()) do
						if iter_73_5 then
							if arg_70_1.isInRecall_ then
								iter_73_5.color = Color.New(Mathf.Lerp(iter_73_5.color.r, arg_70_1.hightColor2.r, (arg_70_1.time_ - 0) / var_73_3), Mathf.Lerp(iter_73_5.color.g, arg_70_1.hightColor2.g, (arg_70_1.time_ - 0) / var_73_3), (Mathf.Lerp(iter_73_5.color.b, arg_70_1.hightColor2.b, (arg_70_1.time_ - 0) / var_73_3)))
							else
								local var_73_4 = Mathf.Lerp(iter_73_5.color.r, 0.5, (arg_70_1.time_ - 0) / var_73_3)

								iter_73_5.color = Color.New(var_73_4, var_73_4, var_73_4)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= 0 + var_73_3 and arg_70_1.time_ < 0 + var_73_3 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.actorSpriteComps10135 then
				for iter_73_6, iter_73_7 in pairs(arg_70_1.var_.actorSpriteComps10135:ToTable()) do
					if iter_73_7 then
						iter_73_7.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_70_1.var_.actorSpriteComps10135 = nil
			end

			local var_73_5 = 0
			local var_73_6 = 0.2

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[380].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_7 = arg_70_1:GetWordFromCfg(418111017)
				local var_73_8 = arg_70_1:FormatText(var_73_7.content)

				arg_70_1.text_.text = var_73_8

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_10 = 8 <= 0 and var_73_6 or var_73_6 * (utf8.len(var_73_8) / 8)

				if (8 <= 0 and var_73_6 or var_73_6 * (utf8.len(var_73_8) / 8)) > 0 and var_73_6 < var_73_10 then
					arg_70_1.talkMaxDuration = var_73_10

					if var_73_10 + var_73_5 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_10 + var_73_5
					end
				end

				arg_70_1.text_.text = var_73_8
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_418111", "418111017", "story_v_side_old_418111.awb") ~= 0 then
					local var_73_11 = manager.audio:GetVoiceLength("story_v_side_old_418111", "418111017", "story_v_side_old_418111.awb") / 1000

					if var_73_11 + var_73_5 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_11 + var_73_5
					end

					if var_73_7.prefab_name ~= "" and arg_70_1.actors_[var_73_7.prefab_name] ~= nil then
						local var_73_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_7.prefab_name].transform, "story_v_side_old_418111", "418111017", "story_v_side_old_418111.awb")

						arg_70_1:RecordAudio("418111017", var_73_12)
						arg_70_1:RecordAudio("418111017", var_73_12)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_side_old_418111", "418111017", "story_v_side_old_418111.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_side_old_418111", "418111017", "story_v_side_old_418111.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_13 = math.max(var_73_6, arg_70_1.talkMaxDuration)

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_13 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_5) / var_73_13

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_5 + var_73_13 and arg_70_1.time_ < var_73_5 + var_73_13 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/SS1802"
	},
	voices = {
		"story_v_side_old_418111.awb"
	}
}
