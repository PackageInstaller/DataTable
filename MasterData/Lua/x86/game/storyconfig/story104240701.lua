return {
	Play424071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 424071001
		arg_1_1.duration_ = 8.6

		local var_1_0 = {
			zh = 6.433,
			ja = 8.6
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
				arg_1_0:Play424071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST0115a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0115a")
				var_4_0.name = "ST0115a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0115a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0115a

				arg_1_1.bgs_.ST0115a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0115a" then
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

			local var_4_9 = "1047"

			if arg_1_1.actors_["1047"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1047")

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

			local var_4_12 = arg_1_1.actors_["1047"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1047 = var_4_12.localPosition
				var_4_12.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1047", 3)

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
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_1_1.time_ - 1.8) / var_4_14)
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:SetSpriteNiuquEffect("1047", true)
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				local var_4_16 = arg_1_1.actors_["1047"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_16 then
					arg_1_1.var_.alphaOldValue1047 = var_4_16.alpha
					arg_1_1.var_.characterEffect1047 = var_4_16
				end
			end

			local var_4_17 = 0.034

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_17 then
				if arg_1_1.var_.characterEffect1047 then
					arg_1_1.var_.characterEffect1047.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue1047, 0.6, (arg_1_1.time_ - 1.8) / var_4_17)
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_17 and arg_1_1.time_ < 1.8 + var_4_17 + arg_4_0 and arg_1_1.var_.characterEffect1047 then
				arg_1_1.var_.characterEffect1047.alpha = 0.6
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily")

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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_146", "se_story_146_wind02", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 2
			local var_4_26 = 0.45

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(424071001)
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

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071001", "story_v_out_424071.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_424071", "424071001", "story_v_out_424071.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_424071", "424071001", "story_v_out_424071.awb")

						arg_1_1:RecordAudio("424071001", var_4_33)
						arg_1_1:RecordAudio("424071001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_424071", "424071001", "story_v_out_424071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_424071", "424071001", "story_v_out_424071.awb")
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
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play424071002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 424071002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play424071003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.55

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
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

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(424071002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 22 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 22)

				if (22 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 22)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play424071003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 424071003
		arg_13_1.duration_ = 3.43

		local var_13_0 = {
			zh = 1.8,
			ja = 3.433
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
				arg_13_0:Play424071004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1047 = arg_13_1.actors_["1047"].transform.localPosition
				arg_13_1.actors_["1047"].transform.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1047", 3)

				for iter_16_0 = 0, arg_13_1.actors_["1047"].transform.childCount - 1 do
					local var_16_0 = arg_13_1.actors_["1047"].transform:GetChild(iter_16_0)

					if var_16_0.name == "split_2" or not string.find(var_16_0.name, "split") then
						var_16_0.gameObject:SetActive(true)
					else
						var_16_0.gameObject:SetActive(false)
					end
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["1047"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_13_1.time_ - 0) / var_16_1)
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["1047"].transform.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_16_2 = 0
			local var_16_3 = 0.225

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_4 = arg_13_1:GetWordFromCfg(424071003)
				local var_16_5 = arg_13_1:FormatText(var_16_4.content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 9 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 9)

				if (9 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 9)) > 0 and var_16_3 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_2
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071003", "story_v_out_424071.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071003", "story_v_out_424071.awb") / 1000

					if var_16_8 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_2
					end

					if var_16_4.prefab_name ~= "" and arg_13_1.actors_[var_16_4.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_4.prefab_name].transform, "story_v_out_424071", "424071003", "story_v_out_424071.awb")

						arg_13_1:RecordAudio("424071003", var_16_9)
						arg_13_1:RecordAudio("424071003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_424071", "424071003", "story_v_out_424071.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_424071", "424071003", "story_v_out_424071.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_10 = math.max(var_16_3, arg_13_1.talkMaxDuration)

			if var_16_2 <= arg_13_1.time_ and arg_13_1.time_ < var_16_2 + var_16_10 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_2) / var_16_10

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_2 + var_16_10 and arg_13_1.time_ < var_16_2 + var_16_10 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play424071004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 424071004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play424071005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0.825

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
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

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(424071004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 33 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 33)

				if (33 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 33)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play424071005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 424071005
		arg_21_1.duration_ = 6.47

		local var_21_0 = {
			zh = 3.3,
			ja = 6.466
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
				arg_21_0:Play424071006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.325

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(424071005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 13 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 13)

				if (13 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 13)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071005", "story_v_out_424071.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071005", "story_v_out_424071.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_424071", "424071005", "story_v_out_424071.awb")

						arg_21_1:RecordAudio("424071005", var_24_6)
						arg_21_1:RecordAudio("424071005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_424071", "424071005", "story_v_out_424071.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_424071", "424071005", "story_v_out_424071.awb")
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
	Play424071006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 424071006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play424071007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.425

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(424071006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 17 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 17)

				if (17 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 17)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play424071007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 424071007
		arg_29_1.duration_ = 10.67

		local var_29_0 = {
			zh = 5.533,
			ja = 10.666
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
				arg_29_0:Play424071008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1047 = arg_29_1.actors_["1047"].transform.localPosition
				arg_29_1.actors_["1047"].transform.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1047", 3)

				for iter_32_0 = 0, arg_29_1.actors_["1047"].transform.childCount - 1 do
					local var_32_0 = arg_29_1.actors_["1047"].transform:GetChild(iter_32_0)

					if var_32_0.name == "split_4" or not string.find(var_32_0.name, "split") then
						var_32_0.gameObject:SetActive(true)
					else
						var_32_0.gameObject:SetActive(false)
					end
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["1047"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_29_1.time_ - 0) / var_32_1)
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["1047"].transform.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_32_2 = 0
			local var_32_3 = 0.675

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_4 = arg_29_1:GetWordFromCfg(424071007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 27 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 27)

				if (27 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 27)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071007", "story_v_out_424071.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071007", "story_v_out_424071.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_424071", "424071007", "story_v_out_424071.awb")

						arg_29_1:RecordAudio("424071007", var_32_9)
						arg_29_1:RecordAudio("424071007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_424071", "424071007", "story_v_out_424071.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_424071", "424071007", "story_v_out_424071.awb")
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
				actorName = "1047",
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
	Play424071008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 424071008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play424071009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.275

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
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

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(424071008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 11 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 11)

				if (11 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 11)) > 0 and var_36_0 < var_36_3 then
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
	Play424071009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 424071009
		arg_37_1.duration_ = 4.63

		local var_37_0 = {
			zh = 4.5,
			ja = 4.633
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
				arg_37_0:Play424071010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1047 = arg_37_1.actors_["1047"].transform.localPosition
				arg_37_1.actors_["1047"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1047", 3)

				for iter_40_0 = 0, arg_37_1.actors_["1047"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["1047"].transform:GetChild(iter_40_0)

					if var_40_0.name == "split_1" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["1047"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["1047"].transform.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_40_2 = 0
			local var_40_3 = 0.4

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(424071009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 16 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 16)

				if (16 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 16)) > 0 and var_40_3 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071009", "story_v_out_424071.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071009", "story_v_out_424071.awb") / 1000

					if var_40_8 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_2
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_out_424071", "424071009", "story_v_out_424071.awb")

						arg_37_1:RecordAudio("424071009", var_40_9)
						arg_37_1:RecordAudio("424071009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_424071", "424071009", "story_v_out_424071.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_424071", "424071009", "story_v_out_424071.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_10 and arg_37_1.time_ < var_40_2 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play424071010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 424071010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play424071011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 1.55

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(424071010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 62 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 62)

				if (62 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 62)) > 0 and var_44_0 < var_44_3 then
					arg_41_1.talkMaxDuration = var_44_3

					if var_44_3 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_3 + 0
					end
				end

				arg_41_1.text_.text = var_44_1
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_4 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_4

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play424071011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 424071011
		arg_45_1.duration_ = 4.93

		local var_45_0 = {
			zh = 3.866,
			ja = 4.933
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
				arg_45_0:Play424071012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1047 = arg_45_1.actors_["1047"].transform.localPosition
				arg_45_1.actors_["1047"].transform.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1047", 3)

				for iter_48_0 = 0, arg_45_1.actors_["1047"].transform.childCount - 1 do
					local var_48_0 = arg_45_1.actors_["1047"].transform:GetChild(iter_48_0)

					if var_48_0.name == "split_7" or not string.find(var_48_0.name, "split") then
						var_48_0.gameObject:SetActive(true)
					else
						var_48_0.gameObject:SetActive(false)
					end
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["1047"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_45_1.time_ - 0) / var_48_1)
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["1047"].transform.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_48_2 = 0
			local var_48_3 = 0.35

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:GetWordFromCfg(424071011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 14 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 14)

				if (14 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_5) / 14)) > 0 and var_48_3 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071011", "story_v_out_424071.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071011", "story_v_out_424071.awb") / 1000

					if var_48_8 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_2
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_424071", "424071011", "story_v_out_424071.awb")

						arg_45_1:RecordAudio("424071011", var_48_9)
						arg_45_1:RecordAudio("424071011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_424071", "424071011", "story_v_out_424071.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_424071", "424071011", "story_v_out_424071.awb")
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

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play424071012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 424071012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play424071013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.25

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(424071012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 10 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 10)

				if (10 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 10)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play424071013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 424071013
		arg_53_1.duration_ = 4.6

		local var_53_0 = {
			zh = 2.933,
			ja = 4.6
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
				arg_53_0:Play424071014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos1047 = arg_53_1.actors_["1047"].transform.localPosition
				arg_53_1.actors_["1047"].transform.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("1047", 3)

				for iter_56_0 = 0, arg_53_1.actors_["1047"].transform.childCount - 1 do
					local var_56_0 = arg_53_1.actors_["1047"].transform:GetChild(iter_56_0)

					if var_56_0.name == "split_1" or not string.find(var_56_0.name, "split") then
						var_56_0.gameObject:SetActive(true)
					else
						var_56_0.gameObject:SetActive(false)
					end
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["1047"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_53_1.time_ - 0) / var_56_1)
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["1047"].transform.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_56_2 = 0
			local var_56_3 = 0.375

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(424071013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 15 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 15)

				if (15 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 15)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071013", "story_v_out_424071.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071013", "story_v_out_424071.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_424071", "424071013", "story_v_out_424071.awb")

						arg_53_1:RecordAudio("424071013", var_56_9)
						arg_53_1:RecordAudio("424071013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_424071", "424071013", "story_v_out_424071.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_424071", "424071013", "story_v_out_424071.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play424071014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 424071014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play424071015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1047 = arg_57_1.actors_["1047"].transform.localPosition
				arg_57_1.actors_["1047"].transform.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1047", 7)

				for iter_60_0 = 0, arg_57_1.actors_["1047"].transform.childCount - 1 do
					local var_60_0 = arg_57_1.actors_["1047"].transform:GetChild(iter_60_0)

					if var_60_0.name == "" or not string.find(var_60_0.name, "split") then
						var_60_0.gameObject:SetActive(true)
					else
						var_60_0.gameObject:SetActive(false)
					end
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["1047"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1047, Vector3.New(0, -2000, 0), (arg_57_1.time_ - 0) / var_60_1)
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["1047"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_60_2 = "1034"

			if arg_57_1.actors_["1034"] == nil then
				local var_60_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_60_3) then
					local var_60_4 = Object.Instantiate(var_60_3, arg_57_1.canvasGo_.transform)

					var_60_4.transform:SetSiblingIndex(1)

					var_60_4.name = var_60_2
					var_60_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_57_1.actors_[var_60_2] = var_60_4

					if arg_57_1.isInRecall_ then
						for iter_60_1, iter_60_2 in ipairs((var_60_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_60_2.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:SetSpriteNiuquEffect("1034", false)
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				local var_60_6 = arg_57_1.actors_["1034"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_60_6 then
					arg_57_1.var_.alphaOldValue1034 = var_60_6.alpha
					arg_57_1.var_.characterEffect1034 = var_60_6
				end

				arg_57_1.var_.alphaOldValue1034 = 0
			end

			local var_60_7 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				if arg_57_1.var_.characterEffect1034 then
					arg_57_1.var_.characterEffect1034.alpha = Mathf.Lerp(arg_57_1.var_.alphaOldValue1034, 1, (arg_57_1.time_ - 0) / var_60_7)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 and arg_57_1.var_.characterEffect1034 then
				arg_57_1.var_.characterEffect1034.alpha = 1
			end

			local var_60_8 = 0
			local var_60_9 = 0.575

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_10 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(424071014).content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_12 = 23 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_10) / 23)

				if (23 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_10) / 23)) > 0 and var_60_9 < var_60_12 then
					arg_57_1.talkMaxDuration = var_60_12

					if var_60_12 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_12 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_10
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_13 and arg_57_1.time_ < var_60_8 + var_60_13 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
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
	Play424071015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 424071015
		arg_61_1.duration_ = 1.4

		local var_61_0 = {
			zh = 1.266,
			ja = 1.4
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
				arg_61_0:Play424071016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if arg_61_1.actors_["1094"] == nil then
				local var_64_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1094")

				if not isNil(var_64_0) then
					local var_64_1 = Object.Instantiate(var_64_0, arg_61_1.canvasGo_.transform)

					var_64_1.transform:SetSiblingIndex(1)

					var_64_1.name = "1094"
					var_64_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_61_1.actors_["1094"] = var_64_1

					if arg_61_1.isInRecall_ then
						for iter_64_0, iter_64_1 in ipairs((var_64_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_64_1.color = arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_64_2 = arg_61_1.actors_["1094"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps1094 == nil then
				arg_61_1.var_.actorSpriteComps1094 = var_64_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_3 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.actorSpriteComps1094 then
					for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_64_3 then
							if arg_61_1.isInRecall_ then
								iter_64_3.color = Color.New(Mathf.Lerp(iter_64_3.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_3), Mathf.Lerp(iter_64_3.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_3), (Mathf.Lerp(iter_64_3.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_3)))
							else
								local var_64_4 = Mathf.Lerp(iter_64_3.color.r, 1, (arg_61_1.time_ - 0) / var_64_3)

								iter_64_3.color = Color.New(var_64_4, var_64_4, var_64_4)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.actorSpriteComps1094 then
				for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_64_5 then
						iter_64_5.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps1094 = nil
			end

			local var_64_5 = arg_61_1.actors_["1094"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1094 = var_64_5.localPosition
				var_64_5.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1094", 3)

				for iter_64_6 = 0, var_64_5.childCount - 1 do
					local var_64_6 = var_64_5:GetChild(iter_64_6)

					if var_64_6.name == "" or not string.find(var_64_6.name, "split") then
						var_64_6.gameObject:SetActive(true)
					else
						var_64_6.gameObject:SetActive(false)
					end
				end
			end

			local var_64_7 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				var_64_5.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_61_1.time_ - 0) / var_64_7)
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				var_64_5.localPosition = Vector3.New(0, -335, -230)
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				local var_64_8 = arg_61_1.actors_["1094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_64_8 then
					arg_61_1.var_.alphaOldValue1094 = var_64_8.alpha
					arg_61_1.var_.characterEffect1094 = var_64_8
				end

				arg_61_1.var_.alphaOldValue1094 = 0
			end

			local var_64_9 = 0.6

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_9 then
				if arg_61_1.var_.characterEffect1094 then
					arg_61_1.var_.characterEffect1094.alpha = Mathf.Lerp(arg_61_1.var_.alphaOldValue1094, 1, (arg_61_1.time_ - 0) / var_64_9)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_9 and arg_61_1.time_ < 0 + var_64_9 + arg_64_0 and arg_61_1.var_.characterEffect1094 then
				arg_61_1.var_.characterEffect1094.alpha = 1
			end

			local var_64_10 = 0
			local var_64_11 = 0.1

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_12 = arg_61_1:GetWordFromCfg(424071015)
				local var_64_13 = arg_61_1:FormatText(var_64_12.content)

				arg_61_1.text_.text = var_64_13

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_15 = 4 <= 0 and var_64_11 or var_64_11 * (utf8.len(var_64_13) / 4)

				if (4 <= 0 and var_64_11 or var_64_11 * (utf8.len(var_64_13) / 4)) > 0 and var_64_11 < var_64_15 then
					arg_61_1.talkMaxDuration = var_64_15

					if var_64_15 + var_64_10 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_15 + var_64_10
					end
				end

				arg_61_1.text_.text = var_64_13
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071015", "story_v_out_424071.awb") ~= 0 then
					local var_64_16 = manager.audio:GetVoiceLength("story_v_out_424071", "424071015", "story_v_out_424071.awb") / 1000

					if var_64_16 + var_64_10 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_16 + var_64_10
					end

					if var_64_12.prefab_name ~= "" and arg_61_1.actors_[var_64_12.prefab_name] ~= nil then
						local var_64_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_12.prefab_name].transform, "story_v_out_424071", "424071015", "story_v_out_424071.awb")

						arg_61_1:RecordAudio("424071015", var_64_17)
						arg_61_1:RecordAudio("424071015", var_64_17)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_424071", "424071015", "story_v_out_424071.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_424071", "424071015", "story_v_out_424071.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_18 = math.max(var_64_11, arg_61_1.talkMaxDuration)

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_18 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_10) / var_64_18

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_10 + var_64_18 and arg_61_1.time_ < var_64_10 + var_64_18 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424071016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 424071016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play424071017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1094"]) and arg_65_1.var_.actorSpriteComps1094 == nil then
				arg_65_1.var_.actorSpriteComps1094 = arg_65_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1094"]) then
				if arg_65_1.var_.actorSpriteComps1094 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1094"]) and arg_65_1.var_.actorSpriteComps1094 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps1094 = nil
			end

			local var_68_2 = 0
			local var_68_3 = 1.65

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_2 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_4 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(424071016).content)

				arg_65_1.text_.text = var_68_4

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_6 = 66 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_4) / 66)

				if (66 <= 0 and var_68_3 or var_68_3 * (utf8.len(var_68_4) / 66)) > 0 and var_68_3 < var_68_6 then
					arg_65_1.talkMaxDuration = var_68_6

					if var_68_6 + var_68_2 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_6 + var_68_2
					end
				end

				arg_65_1.text_.text = var_68_4
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_3, arg_65_1.talkMaxDuration)

			if var_68_2 <= arg_65_1.time_ and arg_65_1.time_ < var_68_2 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_2) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_2 + var_68_7 and arg_65_1.time_ < var_68_2 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play424071017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 424071017
		arg_69_1.duration_ = 4.6

		local var_69_0 = {
			zh = 4.066,
			ja = 4.6
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
				arg_69_0:Play424071018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1094"]) and arg_69_1.var_.actorSpriteComps1094 == nil then
				arg_69_1.var_.actorSpriteComps1094 = arg_69_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1094"]) then
				if arg_69_1.var_.actorSpriteComps1094 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1094"]) and arg_69_1.var_.actorSpriteComps1094 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_72_3 then
						iter_72_3.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps1094 = nil
			end

			local var_72_2 = arg_69_1.actors_["1094"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1094 = var_72_2.localPosition
				var_72_2.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1094", 3)

				for iter_72_4 = 0, var_72_2.childCount - 1 do
					local var_72_3 = var_72_2:GetChild(iter_72_4)

					if var_72_3.name == "" or not string.find(var_72_3.name, "split") then
						var_72_3.gameObject:SetActive(true)
					else
						var_72_3.gameObject:SetActive(false)
					end
				end
			end

			local var_72_4 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				var_72_2.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_69_1.time_ - 0) / var_72_4)
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				var_72_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_72_5 = 0
			local var_72_6 = 0.325

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_7 = arg_69_1:GetWordFromCfg(424071017)
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

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071017", "story_v_out_424071.awb") ~= 0 then
					local var_72_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071017", "story_v_out_424071.awb") / 1000

					if var_72_11 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_5
					end

					if var_72_7.prefab_name ~= "" and arg_69_1.actors_[var_72_7.prefab_name] ~= nil then
						local var_72_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_7.prefab_name].transform, "story_v_out_424071", "424071017", "story_v_out_424071.awb")

						arg_69_1:RecordAudio("424071017", var_72_12)
						arg_69_1:RecordAudio("424071017", var_72_12)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_424071", "424071017", "story_v_out_424071.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_424071", "424071017", "story_v_out_424071.awb")
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
				actorName = "1094",
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
	Play424071018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 424071018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play424071019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1094"]) and arg_73_1.var_.actorSpriteComps1094 == nil then
				arg_73_1.var_.actorSpriteComps1094 = arg_73_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1094"]) then
				if arg_73_1.var_.actorSpriteComps1094 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1094"]) and arg_73_1.var_.actorSpriteComps1094 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps1094 = nil
			end

			local var_76_2 = 0
			local var_76_3 = 0.475

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

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_4 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(424071018).content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 19 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 19)

				if (19 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 19)) > 0 and var_76_3 < var_76_6 then
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
	Play424071019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 424071019
		arg_77_1.duration_ = 1.37

		local var_77_0 = {
			zh = 0.999999999999,
			ja = 1.366
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
				arg_77_0:Play424071020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1094"]) and arg_77_1.var_.actorSpriteComps1094 == nil then
				arg_77_1.var_.actorSpriteComps1094 = arg_77_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1094"]) then
				if arg_77_1.var_.actorSpriteComps1094 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								iter_80_1.color = Color.New(Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_0), Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_0), (Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_0)))
							else
								local var_80_1 = Mathf.Lerp(iter_80_1.color.r, 1, (arg_77_1.time_ - 0) / var_80_0)

								iter_80_1.color = Color.New(var_80_1, var_80_1, var_80_1)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1094"]) and arg_77_1.var_.actorSpriteComps1094 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_80_3 then
						iter_80_3.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps1094 = nil
			end

			local var_80_2 = arg_77_1.actors_["1094"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1094 = var_80_2.localPosition
				var_80_2.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1094", 3)

				for iter_80_4 = 0, var_80_2.childCount - 1 do
					local var_80_3 = var_80_2:GetChild(iter_80_4)

					if var_80_3.name == "split_2" then
						var_80_3:SetAsLastSibling()
						var_80_3.gameObject:SetActive(true)

						arg_77_1.var_.actorSpriteSplit1094 = var_80_3.gameObject:GetComponent(typeof(Image))

						arg_77_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_80_4 = 0.5

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				var_80_2.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_77_1.time_ - 0) / var_80_4)

				if arg_77_1.var_.actorSpriteSplit1094 ~= nil then
					arg_77_1.var_.actorSpriteSplit1094:SetAlpha((arg_77_1.time_ - 0) / var_80_4)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				var_80_2.localPosition = Vector3.New(0, -335, -230)

				if arg_77_1.var_.actorSpriteSplit1094 ~= nil then
					arg_77_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_80_5 = 0
			local var_80_6 = 0.05

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_7 = arg_77_1:GetWordFromCfg(424071019)
				local var_80_8 = arg_77_1:FormatText(var_80_7.content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 2 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 2)

				if (2 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 2)) > 0 and var_80_6 < var_80_10 then
					arg_77_1.talkMaxDuration = var_80_10

					if var_80_10 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071019", "story_v_out_424071.awb") ~= 0 then
					local var_80_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071019", "story_v_out_424071.awb") / 1000

					if var_80_11 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_5
					end

					if var_80_7.prefab_name ~= "" and arg_77_1.actors_[var_80_7.prefab_name] ~= nil then
						local var_80_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_7.prefab_name].transform, "story_v_out_424071", "424071019", "story_v_out_424071.awb")

						arg_77_1:RecordAudio("424071019", var_80_12)
						arg_77_1:RecordAudio("424071019", var_80_12)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_424071", "424071019", "story_v_out_424071.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_424071", "424071019", "story_v_out_424071.awb")
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
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play424071020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 424071020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play424071021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1094"]) and arg_81_1.var_.actorSpriteComps1094 == nil then
				arg_81_1.var_.actorSpriteComps1094 = arg_81_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1094"]) then
				if arg_81_1.var_.actorSpriteComps1094 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1094"]) and arg_81_1.var_.actorSpriteComps1094 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_84_3 then
						iter_84_3.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps1094 = nil
			end

			local var_84_2 = arg_81_1.actors_["1094"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1094 = var_84_2.localPosition
				var_84_2.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1094", 7)

				for iter_84_4 = 0, var_84_2.childCount - 1 do
					local var_84_3 = var_84_2:GetChild(iter_84_4)

					if var_84_3.name == "" or not string.find(var_84_3.name, "split") then
						var_84_3.gameObject:SetActive(true)
					else
						var_84_3.gameObject:SetActive(false)
					end
				end
			end

			local var_84_4 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				var_84_2.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_81_1.time_ - 0) / var_84_4)
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				var_84_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_84_5 = 0
			local var_84_6 = 1.1

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_7 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(424071020).content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 44 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_7) / 44)

				if (44 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_7) / 44)) > 0 and var_84_6 < var_84_9 then
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

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424071021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 424071021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play424071022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.35

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(424071021).content)

				arg_85_1.text_.text = var_88_1

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_3 = 14 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 14)

				if (14 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_1) / 14)) > 0 and var_88_0 < var_88_3 then
					arg_85_1.talkMaxDuration = var_88_3

					if var_88_3 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_3 + 0
					end
				end

				arg_85_1.text_.text = var_88_1
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_4 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_4

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play424071022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 424071022
		arg_89_1.duration_ = 1.33

		local var_89_0 = {
			zh = 1.3,
			ja = 1.333
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
				arg_89_0:Play424071023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1094"]) and arg_89_1.var_.actorSpriteComps1094 == nil then
				arg_89_1.var_.actorSpriteComps1094 = arg_89_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_92_0 = 0.2

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1094"]) then
				if arg_89_1.var_.actorSpriteComps1094 then
					for iter_92_0, iter_92_1 in pairs(arg_89_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1094"]) and arg_89_1.var_.actorSpriteComps1094 then
				for iter_92_2, iter_92_3 in pairs(arg_89_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_92_3 then
						iter_92_3.color = arg_89_1.isInRecall_ and (arg_89_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_89_1.var_.actorSpriteComps1094 = nil
			end

			local var_92_2 = arg_89_1.actors_["1094"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1094 = var_92_2.localPosition
				var_92_2.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1094", 3)

				for iter_92_4 = 0, var_92_2.childCount - 1 do
					local var_92_3 = var_92_2:GetChild(iter_92_4)

					if var_92_3.name == "" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				var_92_2.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_89_1.time_ - 0) / var_92_4)
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				var_92_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_92_5 = 0
			local var_92_6 = 0.15

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_7 = arg_89_1:GetWordFromCfg(424071022)
				local var_92_8 = arg_89_1:FormatText(var_92_7.content)

				arg_89_1.text_.text = var_92_8

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_10 = 6 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_8) / 6)

				if (6 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_8) / 6)) > 0 and var_92_6 < var_92_10 then
					arg_89_1.talkMaxDuration = var_92_10

					if var_92_10 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_10 + var_92_5
					end
				end

				arg_89_1.text_.text = var_92_8
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071022", "story_v_out_424071.awb") ~= 0 then
					local var_92_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071022", "story_v_out_424071.awb") / 1000

					if var_92_11 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_5
					end

					if var_92_7.prefab_name ~= "" and arg_89_1.actors_[var_92_7.prefab_name] ~= nil then
						local var_92_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_7.prefab_name].transform, "story_v_out_424071", "424071022", "story_v_out_424071.awb")

						arg_89_1:RecordAudio("424071022", var_92_12)
						arg_89_1:RecordAudio("424071022", var_92_12)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_424071", "424071022", "story_v_out_424071.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_424071", "424071022", "story_v_out_424071.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_13 = math.max(var_92_6, arg_89_1.talkMaxDuration)

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_13 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_5) / var_92_13

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_5 + var_92_13 and arg_89_1.time_ < var_92_5 + var_92_13 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424071023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 424071023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play424071024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1094"]) and arg_93_1.var_.actorSpriteComps1094 == nil then
				arg_93_1.var_.actorSpriteComps1094 = arg_93_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_0 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1094"]) then
				if arg_93_1.var_.actorSpriteComps1094 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1094"]) and arg_93_1.var_.actorSpriteComps1094 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_96_3 then
						iter_96_3.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_93_1.var_.actorSpriteComps1094 = nil
			end

			local var_96_2 = 0
			local var_96_3 = 0.4

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_4 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(424071023).content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_6 = 16 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_4) / 16)

				if (16 <= 0 and var_96_3 or var_96_3 * (utf8.len(var_96_4) / 16)) > 0 and var_96_3 < var_96_6 then
					arg_93_1.talkMaxDuration = var_96_6

					if var_96_6 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_6 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_7 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_7 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_7

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_7 and arg_93_1.time_ < var_96_2 + var_96_7 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play424071024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 424071024
		arg_97_1.duration_ = 8.8

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play424071025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_9001
			local var_100_9000

			if 1.966 < arg_97_1.time_ and arg_97_1.time_ <= 1.966 + arg_100_0 then
				arg_97_1.var_.moveOldPos1094 = arg_97_1.actors_["1094"].transform.localPosition
				arg_97_1.actors_["1094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1094", 7)

				for iter_100_0 = 0, arg_97_1.actors_["1094"].transform.childCount - 1 do
					local var_100_0 = arg_97_1.actors_["1094"].transform:GetChild(iter_100_0)

					if var_100_0.name == "" or not string.find(var_100_0.name, "split") then
						var_100_0.gameObject:SetActive(true)
					else
						var_100_0.gameObject:SetActive(false)
					end
				end
			end

			local var_100_1 = 0.001

			if 1.966 <= arg_97_1.time_ and arg_97_1.time_ < 1.966 + var_100_1 then
				arg_97_1.actors_["1094"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_97_1.time_ - 1.966) / var_100_1)
			end

			if arg_97_1.time_ >= 1.966 + var_100_1 and arg_97_1.time_ < 1.966 + var_100_1 + arg_100_0 then
				arg_97_1.actors_["1094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_100_2 = 0

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_3 = 2

			if var_100_2 <= arg_97_1.time_ and arg_97_1.time_ < var_100_2 + var_100_3 then
				local var_100_4 = Color.New(0, 0, 0)

				var_100_4.a = Mathf.Lerp(0, 1, (arg_97_1.time_ - var_100_2) / var_100_3)
				arg_97_1.mask_.color = var_100_4
			end

			if arg_97_1.time_ >= var_100_2 + var_100_3 and arg_97_1.time_ < var_100_2 + var_100_3 + arg_100_0 then
				local var_100_5 = Color.New(0, 0, 0)

				var_100_5.a = 1
				arg_97_1.mask_.color = var_100_5
			end

			local var_100_6 = 2

			if 2 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.mask_.enabled = true
				arg_97_1.mask_.raycastTarget = true

				arg_97_1:SetGaussion(false)
			end

			local var_100_7 = 2

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_7 then
				local var_100_8 = Color.New(0, 0, 0)

				var_100_8.a = Mathf.Lerp(1, 0, (arg_97_1.time_ - var_100_6) / var_100_7)
				arg_97_1.mask_.color = var_100_8
			end

			if arg_97_1.time_ >= var_100_6 + var_100_7 and arg_97_1.time_ < var_100_6 + var_100_7 + arg_100_0 then
				local var_100_9 = Color.New(0, 0, 0)

				arg_97_1.mask_.enabled = false
				var_100_9.a = 0
				arg_97_1.mask_.color = var_100_9
			end

			if 2 < arg_97_1.time_ and arg_97_1.time_ <= 2 + arg_100_0 then
				local var_100_10 = arg_97_1.var_.effectshanshangxiaowusleep1

				if not arg_97_1.var_.effectshanshangxiaowusleep1 then
					var_100_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), manager.ui.mainCamera.transform)
					var_100_10.name = "shanshangxiaowusleep1"
					arg_97_1.var_.effectshanshangxiaowusleep1 = var_100_10
				else
					var_100_10.transform:SetParent(var_100_9001)
				end

				var_100_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_100_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_100_10.transform.localScale = Vector3.New(var_100_10.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_100_10.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_100_10.transform.localScale.z)
			end

			if 2 < arg_97_1.time_ and arg_97_1.time_ <= 2 + arg_100_0 then
				local var_100_12 = arg_97_1.var_.effectshanshangxiaowusleep2

				if not arg_97_1.var_.effectshanshangxiaowusleep2 then
					var_100_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavymax_ui"), manager.ui.mainCamera.transform)
					var_100_12.name = "shanshangxiaowusleep2"
					arg_97_1.var_.effectshanshangxiaowusleep2 = var_100_12
				else
					var_100_12.transform:SetParent(var_100_9000)
				end

				var_100_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_100_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_100_12.transform.localScale = Vector3.New(var_100_12.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_100_12.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_100_12.transform.localScale.z)
			end

			if 3.9 < arg_97_1.time_ and arg_97_1.time_ <= 3.9 + arg_100_0 then
				arg_97_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_foley_cloth", "")
			end

			if arg_97_1.frameCnt_ <= 1 then
				arg_97_1.dialog_:SetActive(false)
			end

			local var_100_15 = 3.8
			local var_100_16 = 1.575

			if 3.8 < arg_97_1.time_ and arg_97_1.time_ <= var_100_15 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0

				arg_97_1.dialog_:SetActive(true)

				arg_97_1.dialogCg_.alpha = 0

				local var_100_17 = LeanTween.value(arg_97_1.dialog_, 0, 1, 0.3)

				var_100_17:setOnUpdate(LuaHelper.FloatAction(function(arg_101_0)
					arg_97_1.dialogCg_.alpha = arg_101_0
				end))
				var_100_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_97_1.dialog_)
					var_100_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_97_1.duration_ = arg_97_1.duration_ + 0.3

				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_18 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(424071024).content)

				arg_97_1.text_.text = var_100_18

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_20 = 63 <= 0 and var_100_16 or var_100_16 * (utf8.len(var_100_18) / 63)

				if (63 <= 0 and var_100_16 or var_100_16 * (utf8.len(var_100_18) / 63)) > 0 and var_100_16 < var_100_20 then
					arg_97_1.talkMaxDuration = var_100_20
					var_100_15 = var_100_15 + 0.3

					if var_100_20 + var_100_15 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_20 + var_100_15
					end
				end

				arg_97_1.text_.text = var_100_18
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_21 = var_100_15 + 0.3
			local var_100_22 = math.max(var_100_16, arg_97_1.talkMaxDuration)

			if var_100_15 + 0.3 <= arg_97_1.time_ and arg_97_1.time_ < var_100_21 + var_100_22 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_21) / var_100_22

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_21 + var_100_22 and arg_97_1.time_ < var_100_21 + var_100_22 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play424071025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 424071025
		arg_103_1.duration_ = 4.33

		local var_103_0 = {
			zh = 2.633,
			ja = 4.333
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
				arg_103_0:Play424071026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0.175

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_1 = arg_103_1:GetWordFromCfg(424071025)
				local var_106_2 = arg_103_1:FormatText(var_106_1.content)

				arg_103_1.text_.text = var_106_2

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 7 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 7)

				if (7 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 7)) > 0 and var_106_0 < var_106_4 then
					arg_103_1.talkMaxDuration = var_106_4

					if var_106_4 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_4 + 0
					end
				end

				arg_103_1.text_.text = var_106_2
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071025", "story_v_out_424071.awb") ~= 0 then
					local var_106_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071025", "story_v_out_424071.awb") / 1000

					if var_106_5 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + 0
					end

					if var_106_1.prefab_name ~= "" and arg_103_1.actors_[var_106_1.prefab_name] ~= nil then
						local var_106_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_1.prefab_name].transform, "story_v_out_424071", "424071025", "story_v_out_424071.awb")

						arg_103_1:RecordAudio("424071025", var_106_6)
						arg_103_1:RecordAudio("424071025", var_106_6)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_424071", "424071025", "story_v_out_424071.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_424071", "424071025", "story_v_out_424071.awb")
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
	Play424071026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 424071026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play424071027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 1.425

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_1 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(424071026).content)

				arg_107_1.text_.text = var_110_1

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_3 = 57 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 57)

				if (57 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 57)) > 0 and var_110_0 < var_110_3 then
					arg_107_1.talkMaxDuration = var_110_3

					if var_110_3 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_3 + 0
					end
				end

				arg_107_1.text_.text = var_110_1
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_4 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_4

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play424071027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 424071027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play424071028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.2

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
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

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(424071027).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 8 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 8)

				if (8 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 8)) > 0 and var_114_0 < var_114_3 then
					arg_111_1.talkMaxDuration = var_114_3

					if var_114_3 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_3 + 0
					end
				end

				arg_111_1.text_.text = var_114_1
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_4 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_4

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play424071028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 424071028
		arg_115_1.duration_ = 4.57

		local var_115_0 = {
			zh = 3.1,
			ja = 4.566
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
				arg_115_0:Play424071029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.275

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_1 = arg_115_1:GetWordFromCfg(424071028)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 11 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 11)

				if (11 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 11)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071028", "story_v_out_424071.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071028", "story_v_out_424071.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_out_424071", "424071028", "story_v_out_424071.awb")

						arg_115_1:RecordAudio("424071028", var_118_6)
						arg_115_1:RecordAudio("424071028", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_424071", "424071028", "story_v_out_424071.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_424071", "424071028", "story_v_out_424071.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_7 = math.max(var_118_0, arg_115_1.talkMaxDuration)

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_7 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - 0) / var_118_7

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= 0 + var_118_7 and arg_115_1.time_ < 0 + var_118_7 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play424071029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 424071029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play424071030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.125

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, true)
				arg_119_1.iconController_:SetSelectedState("hero")

				arg_119_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_119_1.callingController_:SetSelectedState("normal")

				arg_119_1.keyicon_.color = Color.New(1, 1, 1)
				arg_119_1.icon_.color = Color.New(1, 1, 1)

				local var_122_1 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(424071029).content)

				arg_119_1.text_.text = var_122_1

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_3 = 5 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 5)

				if (5 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_1) / 5)) > 0 and var_122_0 < var_122_3 then
					arg_119_1.talkMaxDuration = var_122_3

					if var_122_3 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_3 + 0
					end
				end

				arg_119_1.text_.text = var_122_1
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_4 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_4 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_4

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_4 and arg_119_1.time_ < 0 + var_122_4 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play424071030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 424071030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play424071031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.65

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(424071030).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 26 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 26)

				if (26 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 26)) > 0 and var_126_0 < var_126_3 then
					arg_123_1.talkMaxDuration = var_126_3

					if var_126_3 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_3 + 0
					end
				end

				arg_123_1.text_.text = var_126_1
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_4 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_4

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play424071031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 424071031
		arg_127_1.duration_ = 3.5

		local var_127_0 = {
			zh = 3.033,
			ja = 3.5
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
				arg_127_0:Play424071032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.2

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_1 = arg_127_1:GetWordFromCfg(424071031)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 8 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 8)

				if (8 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 8)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071031", "story_v_out_424071.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071031", "story_v_out_424071.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_out_424071", "424071031", "story_v_out_424071.awb")

						arg_127_1:RecordAudio("424071031", var_130_6)
						arg_127_1:RecordAudio("424071031", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_424071", "424071031", "story_v_out_424071.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_424071", "424071031", "story_v_out_424071.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play424071032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 424071032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play424071033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.325

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

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(424071032).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 13 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 13)

				if (13 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 13)) > 0 and var_134_0 < var_134_3 then
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
	Play424071033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 424071033
		arg_135_1.duration_ = 1.63

		local var_135_0 = {
			zh = 1.466,
			ja = 1.633
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
				arg_135_0:Play424071034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.1

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_1 = arg_135_1:GetWordFromCfg(424071033)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 4 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 4)

				if (4 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 4)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071033", "story_v_out_424071.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071033", "story_v_out_424071.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_out_424071", "424071033", "story_v_out_424071.awb")

						arg_135_1:RecordAudio("424071033", var_138_6)
						arg_135_1:RecordAudio("424071033", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_424071", "424071033", "story_v_out_424071.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_424071", "424071033", "story_v_out_424071.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play424071034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 424071034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play424071035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.125

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_1 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(424071034).content)

				arg_139_1.text_.text = var_142_1

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_3 = 5 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 5)

				if (5 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_1) / 5)) > 0 and var_142_0 < var_142_3 then
					arg_139_1.talkMaxDuration = var_142_3

					if var_142_3 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_3 + 0
					end
				end

				arg_139_1.text_.text = var_142_1
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_4 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_4

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play424071035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 424071035
		arg_143_1.duration_ = 9

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play424071036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if arg_143_1.bgs_.STblack == nil then
				local var_146_0 = Object.Instantiate(arg_143_1.paintGo_)

				var_146_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_146_0.name = "STblack"
				var_146_0.transform.parent = arg_143_1.stage_.transform
				var_146_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_143_1.bgs_.STblack = var_146_0
			end

			if 2 < arg_143_1.time_ and arg_143_1.time_ <= 2 + arg_146_0 then
				local var_146_1 = arg_143_1.bgs_.STblack

				arg_143_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_146_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_146_2 = var_146_1:GetComponent("SpriteRenderer")

				if var_146_2 and var_146_2.sprite then
					local var_146_3 = 2 * (var_146_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_146_1.transform.localScale = Vector3.New(var_146_3 / var_146_2.sprite.bounds.size.y < var_146_3 * manager.ui.mainCameraCom_.aspect / var_146_2.sprite.bounds.size.x and var_146_3 * manager.ui.mainCameraCom_.aspect / var_146_2.sprite.bounds.size.x or var_146_3 / var_146_2.sprite.bounds.size.y, var_146_3 / var_146_2.sprite.bounds.size.y < var_146_3 * manager.ui.mainCameraCom_.aspect / var_146_2.sprite.bounds.size.x and var_146_3 * manager.ui.mainCameraCom_.aspect / var_146_2.sprite.bounds.size.x or var_146_3 / var_146_2.sprite.bounds.size.y, 0)
				end

				for iter_146_0, iter_146_1 in pairs(arg_143_1.bgs_) do
					if iter_146_0 ~= "STblack" then
						iter_146_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_146_4 = 4

			if 4 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.allBtn_.enabled = false
			end

			if arg_143_1.time_ >= var_146_4 + 0.3 and arg_143_1.time_ < var_146_4 + 0.3 + arg_146_0 then
				arg_143_1.allBtn_.enabled = true
			end

			local var_146_5 = 0

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 then
				arg_143_1.mask_.enabled = true
				arg_143_1.mask_.raycastTarget = true

				arg_143_1:SetGaussion(false)
			end

			local var_146_6 = 2

			if var_146_5 <= arg_143_1.time_ and arg_143_1.time_ < var_146_5 + var_146_6 then
				local var_146_7 = Color.New(0, 0, 0)

				var_146_7.a = Mathf.Lerp(0, 1, (arg_143_1.time_ - var_146_5) / var_146_6)
				arg_143_1.mask_.color = var_146_7
			end

			if arg_143_1.time_ >= var_146_5 + var_146_6 and arg_143_1.time_ < var_146_5 + var_146_6 + arg_146_0 then
				local var_146_8 = Color.New(0, 0, 0)

				var_146_8.a = 1
				arg_143_1.mask_.color = var_146_8
			end

			local var_146_9 = 2

			if 2 < arg_143_1.time_ and arg_143_1.time_ <= var_146_9 + arg_146_0 then
				arg_143_1.mask_.enabled = true
				arg_143_1.mask_.raycastTarget = true

				arg_143_1:SetGaussion(false)
			end

			local var_146_10 = 2

			if var_146_9 <= arg_143_1.time_ and arg_143_1.time_ < var_146_9 + var_146_10 then
				local var_146_11 = Color.New(0, 0, 0)

				var_146_11.a = Mathf.Lerp(1, 0, (arg_143_1.time_ - var_146_9) / var_146_10)
				arg_143_1.mask_.color = var_146_11
			end

			if arg_143_1.time_ >= var_146_9 + var_146_10 and arg_143_1.time_ < var_146_9 + var_146_10 + arg_146_0 then
				local var_146_12 = Color.New(0, 0, 0)

				arg_143_1.mask_.enabled = false
				var_146_12.a = 0
				arg_143_1.mask_.color = var_146_12
			end

			if arg_143_1.frameCnt_ <= 1 then
				arg_143_1.dialog_:SetActive(false)
			end

			local var_146_13 = 4
			local var_146_14 = 0.675

			if 4 < arg_143_1.time_ and arg_143_1.time_ <= var_146_13 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0

				arg_143_1.dialog_:SetActive(true)

				arg_143_1.dialogCg_.alpha = 0

				local var_146_15 = LeanTween.value(arg_143_1.dialog_, 0, 1, 0.3)

				var_146_15:setOnUpdate(LuaHelper.FloatAction(function(arg_147_0)
					arg_143_1.dialogCg_.alpha = arg_147_0
				end))
				var_146_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_143_1.dialog_)
					var_146_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_143_1.duration_ = arg_143_1.duration_ + 0.3

				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_16 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(424071035).content)

				arg_143_1.text_.text = var_146_16

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_18 = 27 <= 0 and var_146_14 or var_146_14 * (utf8.len(var_146_16) / 27)

				if (27 <= 0 and var_146_14 or var_146_14 * (utf8.len(var_146_16) / 27)) > 0 and var_146_14 < var_146_18 then
					arg_143_1.talkMaxDuration = var_146_18
					var_146_13 = var_146_13 + 0.3

					if var_146_18 + var_146_13 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_18 + var_146_13
					end
				end

				arg_143_1.text_.text = var_146_16
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_19 = var_146_13 + 0.3
			local var_146_20 = math.max(var_146_14, arg_143_1.talkMaxDuration)

			if var_146_13 + 0.3 <= arg_143_1.time_ and arg_143_1.time_ < var_146_19 + var_146_20 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_19) / var_146_20

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_19 + var_146_20 and arg_143_1.time_ < var_146_19 + var_146_20 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play424071036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 424071036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play424071037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 1.275

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(424071036).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 51 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 51)

				if (51 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 51)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play424071037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 424071037
		arg_153_1.duration_ = 5.37

		local var_153_0 = {
			zh = 1.6,
			ja = 5.366
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
				arg_153_0:Play424071038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0.125

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_1 = arg_153_1:GetWordFromCfg(424071037)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 5 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 5)

				if (5 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 5)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071037", "story_v_out_424071.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071037", "story_v_out_424071.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_424071", "424071037", "story_v_out_424071.awb")

						arg_153_1:RecordAudio("424071037", var_156_6)
						arg_153_1:RecordAudio("424071037", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_424071", "424071037", "story_v_out_424071.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_424071", "424071037", "story_v_out_424071.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play424071038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 424071038
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play424071039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.85

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(424071038).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 34 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 34)

				if (34 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 34)) > 0 and var_160_0 < var_160_3 then
					arg_157_1.talkMaxDuration = var_160_3

					if var_160_3 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_3 + 0
					end
				end

				arg_157_1.text_.text = var_160_1
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_4 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_4

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play424071039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 424071039
		arg_161_1.duration_ = 7

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play424071040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				local var_164_0 = arg_161_1.bgs_.ST0115a

				arg_161_1.bgs_.ST0115a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_164_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_164_1 = var_164_0:GetComponent("SpriteRenderer")

				if var_164_1 and var_164_1.sprite then
					local var_164_2 = 2 * (var_164_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_164_0.transform.localScale = Vector3.New(var_164_2 / var_164_1.sprite.bounds.size.y < var_164_2 * manager.ui.mainCameraCom_.aspect / var_164_1.sprite.bounds.size.x and var_164_2 * manager.ui.mainCameraCom_.aspect / var_164_1.sprite.bounds.size.x or var_164_2 / var_164_1.sprite.bounds.size.y, var_164_2 / var_164_1.sprite.bounds.size.y < var_164_2 * manager.ui.mainCameraCom_.aspect / var_164_1.sprite.bounds.size.x and var_164_2 * manager.ui.mainCameraCom_.aspect / var_164_1.sprite.bounds.size.x or var_164_2 / var_164_1.sprite.bounds.size.y, 0)
				end

				for iter_164_0, iter_164_1 in pairs(arg_161_1.bgs_) do
					if iter_164_0 ~= "ST0115a" then
						iter_164_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_164_3 = 2

			if 2 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 then
				arg_161_1.allBtn_.enabled = false
			end

			if arg_161_1.time_ >= var_164_3 + 0.3 and arg_161_1.time_ < var_164_3 + 0.3 + arg_164_0 then
				arg_161_1.allBtn_.enabled = true
			end

			local var_164_4 = 0

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_4 + arg_164_0 then
				arg_161_1.mask_.enabled = true
				arg_161_1.mask_.raycastTarget = true

				arg_161_1:SetGaussion(false)
			end

			local var_164_5 = 2

			if var_164_4 <= arg_161_1.time_ and arg_161_1.time_ < var_164_4 + var_164_5 then
				local var_164_6 = Color.New(0, 0, 0)

				var_164_6.a = Mathf.Lerp(1, 0, (arg_161_1.time_ - var_164_4) / var_164_5)
				arg_161_1.mask_.color = var_164_6
			end

			if arg_161_1.time_ >= var_164_4 + var_164_5 and arg_161_1.time_ < var_164_4 + var_164_5 + arg_164_0 then
				local var_164_7 = Color.New(0, 0, 0)

				arg_161_1.mask_.enabled = false
				var_164_7.a = 0
				arg_161_1.mask_.color = var_164_7
			end

			if arg_161_1.frameCnt_ <= 1 then
				arg_161_1.dialog_:SetActive(false)
			end

			local var_164_8 = 2
			local var_164_9 = 0.225

			if 2 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0

				arg_161_1.dialog_:SetActive(true)

				arg_161_1.dialogCg_.alpha = 0

				local var_164_10 = LeanTween.value(arg_161_1.dialog_, 0, 1, 0.3)

				var_164_10:setOnUpdate(LuaHelper.FloatAction(function(arg_165_0)
					arg_161_1.dialogCg_.alpha = arg_165_0
				end))
				var_164_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_161_1.dialog_)
					var_164_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_161_1.duration_ = arg_161_1.duration_ + 0.3

				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, true)
				arg_161_1.iconController_:SetSelectedState("hero")

				arg_161_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_161_1.callingController_:SetSelectedState("normal")

				arg_161_1.keyicon_.color = Color.New(1, 1, 1)
				arg_161_1.icon_.color = Color.New(1, 1, 1)

				local var_164_11 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(424071039).content)

				arg_161_1.text_.text = var_164_11

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_13 = 9 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 9)

				if (9 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 9)) > 0 and var_164_9 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13
					var_164_8 = var_164_8 + 0.3

					if var_164_13 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_8
					end
				end

				arg_161_1.text_.text = var_164_11
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_14 = var_164_8 + 0.3
			local var_164_15 = math.max(var_164_9, arg_161_1.talkMaxDuration)

			if var_164_8 + 0.3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_14 + var_164_15 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_14) / var_164_15

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_14 + var_164_15 and arg_161_1.time_ < var_164_14 + var_164_15 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play424071040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 424071040
		arg_167_1.duration_ = 1.47

		local var_167_0 = {
			zh = 1.366,
			ja = 1.466
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
				arg_167_0:Play424071041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.075

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_1 = arg_167_1:GetWordFromCfg(424071040)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 3 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 3)

				if (3 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 3)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071040", "story_v_out_424071.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071040", "story_v_out_424071.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_424071", "424071040", "story_v_out_424071.awb")

						arg_167_1:RecordAudio("424071040", var_170_6)
						arg_167_1:RecordAudio("424071040", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_424071", "424071040", "story_v_out_424071.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_424071", "424071040", "story_v_out_424071.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play424071041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 424071041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play424071042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.275

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_1 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(424071041).content)

				arg_171_1.text_.text = var_174_1

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_3 = 11 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 11)

				if (11 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_1) / 11)) > 0 and var_174_0 < var_174_3 then
					arg_171_1.talkMaxDuration = var_174_3

					if var_174_3 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_3 + 0
					end
				end

				arg_171_1.text_.text = var_174_1
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_4 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_4

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play424071042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 424071042
		arg_175_1.duration_ = 8.7

		local var_175_0 = {
			zh = 5.333,
			ja = 8.7
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
				arg_175_0:Play424071043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.475

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:GetWordFromCfg(424071042)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 19 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 19)

				if (19 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 19)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071042", "story_v_out_424071.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071042", "story_v_out_424071.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_424071", "424071042", "story_v_out_424071.awb")

						arg_175_1:RecordAudio("424071042", var_178_6)
						arg_175_1:RecordAudio("424071042", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_424071", "424071042", "story_v_out_424071.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_424071", "424071042", "story_v_out_424071.awb")
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
	Play424071043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 424071043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play424071044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.7

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(424071043).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 28 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 28)

				if (28 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 28)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play424071044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 424071044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play424071045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 1.075

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_1 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(424071044).content)

				arg_183_1.text_.text = var_186_1

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_3 = 43 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 43)

				if (43 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_1) / 43)) > 0 and var_186_0 < var_186_3 then
					arg_183_1.talkMaxDuration = var_186_3

					if var_186_3 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_3 + 0
					end
				end

				arg_183_1.text_.text = var_186_1
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_4 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_4

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play424071045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 424071045
		arg_187_1.duration_ = 1.4

		local var_187_0 = {
			zh = 1.366,
			ja = 1.4
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play424071046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.125

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_1 = arg_187_1:GetWordFromCfg(424071045)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 5 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 5)

				if (5 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 5)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071045", "story_v_out_424071.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071045", "story_v_out_424071.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_424071", "424071045", "story_v_out_424071.awb")

						arg_187_1:RecordAudio("424071045", var_190_6)
						arg_187_1:RecordAudio("424071045", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_424071", "424071045", "story_v_out_424071.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_424071", "424071045", "story_v_out_424071.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_7 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_7

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play424071046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 424071046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play424071047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0.05

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(424071046).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 2 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 2)

				if (2 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 2)) > 0 and var_194_0 < var_194_3 then
					arg_191_1.talkMaxDuration = var_194_3

					if var_194_3 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_3 + 0
					end
				end

				arg_191_1.text_.text = var_194_1
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_4 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_4

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play424071047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 424071047
		arg_195_1.duration_ = 2.4

		local var_195_0 = {
			zh = 2.4,
			ja = 1.3
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
				arg_195_0:Play424071048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.175

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1094")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:GetWordFromCfg(424071047)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 7 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 7)

				if (7 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 7)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071047", "story_v_out_424071.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071047", "story_v_out_424071.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_424071", "424071047", "story_v_out_424071.awb")

						arg_195_1:RecordAudio("424071047", var_198_6)
						arg_195_1:RecordAudio("424071047", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_424071", "424071047", "story_v_out_424071.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_424071", "424071047", "story_v_out_424071.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_7 = math.max(var_198_0, arg_195_1.talkMaxDuration)

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - 0) / var_198_7

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play424071048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 424071048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play424071049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_202_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_199_1.bgmTxt_.text ~= var_202_2 and arg_199_1.bgmTxt_.text ~= "" then
						if arg_199_1.bgmTxt2_.text ~= "" then
							arg_199_1.bgmTxt_.text = arg_199_1.bgmTxt2_.text
						end

						arg_199_1.bgmTxt2_.text = var_202_2

						arg_199_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_199_1.bgmTxt_.text = var_202_2
						arg_199_1.bgmTxt2_.text = var_202_2
					end

					if arg_199_1.bgmTimer then
						arg_199_1.bgmTimer:Stop()

						arg_199_1.bgmTimer = nil
					end

					if arg_199_1.settingData.show_music_name == 1 then
						arg_199_1.musicController:SetSelectedState("show")
						arg_199_1.musicAnimator_:Play("open", 0, 0)

						if arg_199_1.settingData.music_time ~= 0 then
							arg_199_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_199_1.settingData.music_time), function()
								if arg_199_1 == nil or isNil(arg_199_1.bgmTxt_) then
									return
								end

								arg_199_1.musicController:SetSelectedState("hide")
								arg_199_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_202_3 = 0
			local var_202_4 = 0.6

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_3 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_5 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(424071048).content)

				arg_199_1.text_.text = var_202_5

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_7 = 24 <= 0 and var_202_4 or var_202_4 * (utf8.len(var_202_5) / 24)

				if (24 <= 0 and var_202_4 or var_202_4 * (utf8.len(var_202_5) / 24)) > 0 and var_202_4 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_3 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_3
					end
				end

				arg_199_1.text_.text = var_202_5
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_8 = math.max(var_202_4, arg_199_1.talkMaxDuration)

			if var_202_3 <= arg_199_1.time_ and arg_199_1.time_ < var_202_3 + var_202_8 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_3) / var_202_8

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_3 + var_202_8 and arg_199_1.time_ < var_202_3 + var_202_8 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play424071049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 424071049
		arg_204_1.duration_ = 9

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play424071050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if arg_204_1.bgs_.I11r == nil then
				local var_207_0 = Object.Instantiate(arg_204_1.paintGo_)

				var_207_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11r")
				var_207_0.name = "I11r"
				var_207_0.transform.parent = arg_204_1.stage_.transform
				var_207_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_204_1.bgs_.I11r = var_207_0
			end

			if 2 < arg_204_1.time_ and arg_204_1.time_ <= 2 + arg_207_0 then
				local var_207_1 = arg_204_1.bgs_.I11r

				arg_204_1.bgs_.I11r.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_207_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_207_2 = var_207_1:GetComponent("SpriteRenderer")

				if var_207_2 and var_207_2.sprite then
					local var_207_3 = 2 * (var_207_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_207_1.transform.localScale = Vector3.New(var_207_3 / var_207_2.sprite.bounds.size.y < var_207_3 * manager.ui.mainCameraCom_.aspect / var_207_2.sprite.bounds.size.x and var_207_3 * manager.ui.mainCameraCom_.aspect / var_207_2.sprite.bounds.size.x or var_207_3 / var_207_2.sprite.bounds.size.y, var_207_3 / var_207_2.sprite.bounds.size.y < var_207_3 * manager.ui.mainCameraCom_.aspect / var_207_2.sprite.bounds.size.x and var_207_3 * manager.ui.mainCameraCom_.aspect / var_207_2.sprite.bounds.size.x or var_207_3 / var_207_2.sprite.bounds.size.y, 0)
				end

				for iter_207_0, iter_207_1 in pairs(arg_204_1.bgs_) do
					if iter_207_0 ~= "I11r" then
						iter_207_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_207_4 = 4

			if 4 < arg_204_1.time_ and arg_204_1.time_ <= var_207_4 + arg_207_0 then
				arg_204_1.allBtn_.enabled = false
			end

			if arg_204_1.time_ >= var_207_4 + 0.3 and arg_204_1.time_ < var_207_4 + 0.3 + arg_207_0 then
				arg_204_1.allBtn_.enabled = true
			end

			local var_207_5 = 0

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_5 + arg_207_0 then
				arg_204_1.mask_.enabled = true
				arg_204_1.mask_.raycastTarget = true

				arg_204_1:SetGaussion(false)
			end

			local var_207_6 = 2

			if var_207_5 <= arg_204_1.time_ and arg_204_1.time_ < var_207_5 + var_207_6 then
				local var_207_7 = Color.New(0, 0, 0)

				var_207_7.a = Mathf.Lerp(0, 1, (arg_204_1.time_ - var_207_5) / var_207_6)
				arg_204_1.mask_.color = var_207_7
			end

			if arg_204_1.time_ >= var_207_5 + var_207_6 and arg_204_1.time_ < var_207_5 + var_207_6 + arg_207_0 then
				local var_207_8 = Color.New(0, 0, 0)

				var_207_8.a = 1
				arg_204_1.mask_.color = var_207_8
			end

			local var_207_9 = 2

			if 2 < arg_204_1.time_ and arg_204_1.time_ <= var_207_9 + arg_207_0 then
				arg_204_1.mask_.enabled = true
				arg_204_1.mask_.raycastTarget = true

				arg_204_1:SetGaussion(false)
			end

			local var_207_10 = 2

			if var_207_9 <= arg_204_1.time_ and arg_204_1.time_ < var_207_9 + var_207_10 then
				local var_207_11 = Color.New(0, 0, 0)

				var_207_11.a = Mathf.Lerp(1, 0, (arg_204_1.time_ - var_207_9) / var_207_10)
				arg_204_1.mask_.color = var_207_11
			end

			if arg_204_1.time_ >= var_207_9 + var_207_10 and arg_204_1.time_ < var_207_9 + var_207_10 + arg_207_0 then
				local var_207_12 = Color.New(0, 0, 0)

				arg_204_1.mask_.enabled = false
				var_207_12.a = 0
				arg_204_1.mask_.color = var_207_12
			end

			if 0.166666666666667 < arg_204_1.time_ and arg_204_1.time_ <= 0.166666666666667 + arg_207_0 then
				arg_204_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_207_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_204_1.bgmTxt_.text ~= var_207_15 and arg_204_1.bgmTxt_.text ~= "" then
						if arg_204_1.bgmTxt2_.text ~= "" then
							arg_204_1.bgmTxt_.text = arg_204_1.bgmTxt2_.text
						end

						arg_204_1.bgmTxt2_.text = var_207_15

						arg_204_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_204_1.bgmTxt_.text = var_207_15
						arg_204_1.bgmTxt2_.text = var_207_15
					end

					if arg_204_1.bgmTimer then
						arg_204_1.bgmTimer:Stop()

						arg_204_1.bgmTimer = nil
					end

					if arg_204_1.settingData.show_music_name == 1 then
						arg_204_1.musicController:SetSelectedState("show")
						arg_204_1.musicAnimator_:Play("open", 0, 0)

						if arg_204_1.settingData.music_time ~= 0 then
							arg_204_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_204_1.settingData.music_time), function()
								if arg_204_1 == nil or isNil(arg_204_1.bgmTxt_) then
									return
								end

								arg_204_1.musicController:SetSelectedState("hide")
								arg_204_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.7 < arg_204_1.time_ and arg_204_1.time_ <= 1.7 + arg_207_0 then
				arg_204_1:AudioAction("play", "music", "bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily.awb")

				local var_207_18 = manager.audio:GetAudioName("bgm_activity_4_6_story_daily", "bgm_activity_4_6_story_daily")

				if "" ~= "" then
					if arg_204_1.bgmTxt_.text ~= var_207_18 and arg_204_1.bgmTxt_.text ~= "" then
						if arg_204_1.bgmTxt2_.text ~= "" then
							arg_204_1.bgmTxt_.text = arg_204_1.bgmTxt2_.text
						end

						arg_204_1.bgmTxt2_.text = var_207_18

						arg_204_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_204_1.bgmTxt_.text = var_207_18
						arg_204_1.bgmTxt2_.text = var_207_18
					end

					if arg_204_1.bgmTimer then
						arg_204_1.bgmTimer:Stop()

						arg_204_1.bgmTimer = nil
					end

					if arg_204_1.settingData.show_music_name == 1 then
						arg_204_1.musicController:SetSelectedState("show")
						arg_204_1.musicAnimator_:Play("open", 0, 0)

						if arg_204_1.settingData.music_time ~= 0 then
							arg_204_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_204_1.settingData.music_time), function()
								if arg_204_1 == nil or isNil(arg_204_1.bgmTxt_) then
									return
								end

								arg_204_1.musicController:SetSelectedState("hide")
								arg_204_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.7 < arg_204_1.time_ and arg_204_1.time_ <= 1.7 + arg_207_0 then
				arg_204_1:AudioAction("play", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if 0.166666666666667 < arg_204_1.time_ and arg_204_1.time_ <= 0.166666666666667 + arg_207_0 then
				arg_204_1:AudioAction("stop", "effect", "se_story_146", "se_story_146_wind02", "")
			end

			if 2 < arg_204_1.time_ and arg_204_1.time_ <= 2 + arg_207_0 then
				if arg_204_1.var_.effectshanshangxiaowusleep2 then
					Object.Destroy(arg_204_1.var_.effectshanshangxiaowusleep2)

					arg_204_1.var_.effectshanshangxiaowusleep2 = nil
				end
			end

			if 2 < arg_204_1.time_ and arg_204_1.time_ <= 2 + arg_207_0 then
				if arg_204_1.var_.effectshanshangxiaowusleep1 then
					Object.Destroy(arg_204_1.var_.effectshanshangxiaowusleep1)

					arg_204_1.var_.effectshanshangxiaowusleep1 = nil
				end
			end

			if arg_204_1.frameCnt_ <= 1 then
				arg_204_1.dialog_:SetActive(false)
			end

			local var_207_23 = 4
			local var_207_24 = 1.35

			if 4 < arg_204_1.time_ and arg_204_1.time_ <= var_207_23 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0

				arg_204_1.dialog_:SetActive(true)

				arg_204_1.dialogCg_.alpha = 0

				local var_207_25 = LeanTween.value(arg_204_1.dialog_, 0, 1, 0.3)

				var_207_25:setOnUpdate(LuaHelper.FloatAction(function(arg_210_0)
					arg_204_1.dialogCg_.alpha = arg_210_0
				end))
				var_207_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_204_1.dialog_)
					var_207_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_204_1.duration_ = arg_204_1.duration_ + 0.3

				SetActive(arg_204_1.leftNameGo_, false)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_26 = arg_204_1:FormatText(arg_204_1:GetWordFromCfg(424071049).content)

				arg_204_1.text_.text = var_207_26

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_28 = 54 <= 0 and var_207_24 or var_207_24 * (utf8.len(var_207_26) / 54)

				if (54 <= 0 and var_207_24 or var_207_24 * (utf8.len(var_207_26) / 54)) > 0 and var_207_24 < var_207_28 then
					arg_204_1.talkMaxDuration = var_207_28
					var_207_23 = var_207_23 + 0.3

					if var_207_28 + var_207_23 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_28 + var_207_23
					end
				end

				arg_204_1.text_.text = var_207_26
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)
				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_29 = var_207_23 + 0.3
			local var_207_30 = math.max(var_207_24, arg_204_1.talkMaxDuration)

			if var_207_23 + 0.3 <= arg_204_1.time_ and arg_204_1.time_ < var_207_29 + var_207_30 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_29) / var_207_30

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_29 + var_207_30 and arg_204_1.time_ < var_207_29 + var_207_30 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play424071050 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 424071050
		arg_212_1.duration_ = 2.37

		local var_212_0 = {
			zh = 1.533,
			ja = 2.366
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
				arg_212_0:Play424071051(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["1094"]) and arg_212_1.var_.actorSpriteComps1094 == nil then
				arg_212_1.var_.actorSpriteComps1094 = arg_212_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_0 = 0.2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["1094"]) then
				if arg_212_1.var_.actorSpriteComps1094 then
					for iter_215_0, iter_215_1 in pairs(arg_212_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_215_1 then
							if arg_212_1.isInRecall_ then
								iter_215_1.color = Color.New(Mathf.Lerp(iter_215_1.color.r, arg_212_1.hightColor1.r, (arg_212_1.time_ - 0) / var_215_0), Mathf.Lerp(iter_215_1.color.g, arg_212_1.hightColor1.g, (arg_212_1.time_ - 0) / var_215_0), (Mathf.Lerp(iter_215_1.color.b, arg_212_1.hightColor1.b, (arg_212_1.time_ - 0) / var_215_0)))
							else
								local var_215_1 = Mathf.Lerp(iter_215_1.color.r, 1, (arg_212_1.time_ - 0) / var_215_0)

								iter_215_1.color = Color.New(var_215_1, var_215_1, var_215_1)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["1094"]) and arg_212_1.var_.actorSpriteComps1094 then
				for iter_215_2, iter_215_3 in pairs(arg_212_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_215_3 then
						iter_215_3.color = arg_212_1.isInRecall_ and (arg_212_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_212_1.var_.actorSpriteComps1094 = nil
			end

			local var_215_2 = arg_212_1.actors_["1094"].transform

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1094 = var_215_2.localPosition
				var_215_2.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("1094", 3)

				for iter_215_4 = 0, var_215_2.childCount - 1 do
					local var_215_3 = var_215_2:GetChild(iter_215_4)

					if var_215_3.name == "split_4" or not string.find(var_215_3.name, "split") then
						var_215_3.gameObject:SetActive(true)
					else
						var_215_3.gameObject:SetActive(false)
					end
				end
			end

			local var_215_4 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_4 then
				var_215_2.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_212_1.time_ - 0) / var_215_4)
			end

			if arg_212_1.time_ >= 0 + var_215_4 and arg_212_1.time_ < 0 + var_215_4 + arg_215_0 then
				var_215_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_215_5 = 0
			local var_215_6 = 0.2

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_5 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_7 = arg_212_1:GetWordFromCfg(424071050)
				local var_215_8 = arg_212_1:FormatText(var_215_7.content)

				arg_212_1.text_.text = var_215_8

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_10 = 8 <= 0 and var_215_6 or var_215_6 * (utf8.len(var_215_8) / 8)

				if (8 <= 0 and var_215_6 or var_215_6 * (utf8.len(var_215_8) / 8)) > 0 and var_215_6 < var_215_10 then
					arg_212_1.talkMaxDuration = var_215_10

					if var_215_10 + var_215_5 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_10 + var_215_5
					end
				end

				arg_212_1.text_.text = var_215_8
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071050", "story_v_out_424071.awb") ~= 0 then
					local var_215_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071050", "story_v_out_424071.awb") / 1000

					if var_215_11 + var_215_5 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_11 + var_215_5
					end

					if var_215_7.prefab_name ~= "" and arg_212_1.actors_[var_215_7.prefab_name] ~= nil then
						local var_215_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_7.prefab_name].transform, "story_v_out_424071", "424071050", "story_v_out_424071.awb")

						arg_212_1:RecordAudio("424071050", var_215_12)
						arg_212_1:RecordAudio("424071050", var_215_12)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_424071", "424071050", "story_v_out_424071.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_424071", "424071050", "story_v_out_424071.awb")
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

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play424071051 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 424071051
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play424071052(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["1094"]) and arg_216_1.var_.actorSpriteComps1094 == nil then
				arg_216_1.var_.actorSpriteComps1094 = arg_216_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_0 = 0.2

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["1094"]) then
				if arg_216_1.var_.actorSpriteComps1094 then
					for iter_219_0, iter_219_1 in pairs(arg_216_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_219_1 then
							if arg_216_1.isInRecall_ then
								iter_219_1.color = Color.New(Mathf.Lerp(iter_219_1.color.r, arg_216_1.hightColor2.r, (arg_216_1.time_ - 0) / var_219_0), Mathf.Lerp(iter_219_1.color.g, arg_216_1.hightColor2.g, (arg_216_1.time_ - 0) / var_219_0), (Mathf.Lerp(iter_219_1.color.b, arg_216_1.hightColor2.b, (arg_216_1.time_ - 0) / var_219_0)))
							else
								local var_219_1 = Mathf.Lerp(iter_219_1.color.r, 0.5, (arg_216_1.time_ - 0) / var_219_0)

								iter_219_1.color = Color.New(var_219_1, var_219_1, var_219_1)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["1094"]) and arg_216_1.var_.actorSpriteComps1094 then
				for iter_219_2, iter_219_3 in pairs(arg_216_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_219_3 then
						iter_219_3.color = arg_216_1.isInRecall_ and (arg_216_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_216_1.var_.actorSpriteComps1094 = nil
			end

			local var_219_2 = 0
			local var_219_3 = 1.25

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_2 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, true)
				arg_216_1.iconController_:SetSelectedState("hero")

				arg_216_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_216_1.callingController_:SetSelectedState("normal")

				arg_216_1.keyicon_.color = Color.New(1, 1, 1)
				arg_216_1.icon_.color = Color.New(1, 1, 1)

				local var_219_4 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(424071051).content)

				arg_216_1.text_.text = var_219_4

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_6 = 50 <= 0 and var_219_3 or var_219_3 * (utf8.len(var_219_4) / 50)

				if (50 <= 0 and var_219_3 or var_219_3 * (utf8.len(var_219_4) / 50)) > 0 and var_219_3 < var_219_6 then
					arg_216_1.talkMaxDuration = var_219_6

					if var_219_6 + var_219_2 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_6 + var_219_2
					end
				end

				arg_216_1.text_.text = var_219_4
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_7 = math.max(var_219_3, arg_216_1.talkMaxDuration)

			if var_219_2 <= arg_216_1.time_ and arg_216_1.time_ < var_219_2 + var_219_7 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_2) / var_219_7

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_2 + var_219_7 and arg_216_1.time_ < var_219_2 + var_219_7 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play424071052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 424071052
		arg_220_1.duration_ = 3.53

		local var_220_0 = {
			zh = 2.7,
			ja = 3.533
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
				arg_220_0:Play424071053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0.375

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, true)
				arg_220_1.iconController_:SetSelectedState("hero")

				arg_220_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_220_1.callingController_:SetSelectedState("normal")

				arg_220_1.keyicon_.color = Color.New(1, 1, 1)
				arg_220_1.icon_.color = Color.New(1, 1, 1)

				local var_223_1 = arg_220_1:GetWordFromCfg(424071052)
				local var_223_2 = arg_220_1:FormatText(var_223_1.content)

				arg_220_1.text_.text = var_223_2

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_4 = 15 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_2) / 15)

				if (15 <= 0 and var_223_0 or var_223_0 * (utf8.len(var_223_2) / 15)) > 0 and var_223_0 < var_223_4 then
					arg_220_1.talkMaxDuration = var_223_4

					if var_223_4 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_4 + 0
					end
				end

				arg_220_1.text_.text = var_223_2
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071052", "story_v_out_424071.awb") ~= 0 then
					local var_223_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071052", "story_v_out_424071.awb") / 1000

					if var_223_5 + 0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_5 + 0
					end

					if var_223_1.prefab_name ~= "" and arg_220_1.actors_[var_223_1.prefab_name] ~= nil then
						local var_223_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_1.prefab_name].transform, "story_v_out_424071", "424071052", "story_v_out_424071.awb")

						arg_220_1:RecordAudio("424071052", var_223_6)
						arg_220_1:RecordAudio("424071052", var_223_6)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_424071", "424071052", "story_v_out_424071.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_424071", "424071052", "story_v_out_424071.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_7 = math.max(var_223_0, arg_220_1.talkMaxDuration)

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_7 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - 0) / var_223_7

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= 0 + var_223_7 and arg_220_1.time_ < 0 + var_223_7 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play424071053 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 424071053
		arg_224_1.duration_ = 2.47

		local var_224_0 = {
			zh = 2.466,
			ja = 2.433
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
				arg_224_0:Play424071054(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["1094"]) and arg_224_1.var_.actorSpriteComps1094 == nil then
				arg_224_1.var_.actorSpriteComps1094 = arg_224_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_0 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["1094"]) then
				if arg_224_1.var_.actorSpriteComps1094 then
					for iter_227_0, iter_227_1 in pairs(arg_224_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_227_1 then
							if arg_224_1.isInRecall_ then
								iter_227_1.color = Color.New(Mathf.Lerp(iter_227_1.color.r, arg_224_1.hightColor1.r, (arg_224_1.time_ - 0) / var_227_0), Mathf.Lerp(iter_227_1.color.g, arg_224_1.hightColor1.g, (arg_224_1.time_ - 0) / var_227_0), (Mathf.Lerp(iter_227_1.color.b, arg_224_1.hightColor1.b, (arg_224_1.time_ - 0) / var_227_0)))
							else
								local var_227_1 = Mathf.Lerp(iter_227_1.color.r, 1, (arg_224_1.time_ - 0) / var_227_0)

								iter_227_1.color = Color.New(var_227_1, var_227_1, var_227_1)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["1094"]) and arg_224_1.var_.actorSpriteComps1094 then
				for iter_227_2, iter_227_3 in pairs(arg_224_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_227_3 then
						iter_227_3.color = arg_224_1.isInRecall_ and (arg_224_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_224_1.var_.actorSpriteComps1094 = nil
			end

			local var_227_2 = arg_224_1.actors_["1094"].transform

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos1094 = var_227_2.localPosition
				var_227_2.localScale = Vector3.New(1, 1, 1)

				arg_224_1:CheckSpriteTmpPos("1094", 3)

				for iter_227_4 = 0, var_227_2.childCount - 1 do
					local var_227_3 = var_227_2:GetChild(iter_227_4)

					if var_227_3.name == "" then
						var_227_3:SetAsLastSibling()
						var_227_3.gameObject:SetActive(true)

						arg_224_1.var_.actorSpriteSplit1094 = var_227_3.gameObject:GetComponent(typeof(Image))

						arg_224_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_227_4 = 0.5

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_4 then
				var_227_2.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_224_1.time_ - 0) / var_227_4)

				if arg_224_1.var_.actorSpriteSplit1094 ~= nil then
					arg_224_1.var_.actorSpriteSplit1094:SetAlpha((arg_224_1.time_ - 0) / var_227_4)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_4 and arg_224_1.time_ < 0 + var_227_4 + arg_227_0 then
				var_227_2.localPosition = Vector3.New(0, -335, -230)

				if arg_224_1.var_.actorSpriteSplit1094 ~= nil then
					arg_224_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_227_5 = 0
			local var_227_6 = 0.2

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_5 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_7 = arg_224_1:GetWordFromCfg(424071053)
				local var_227_8 = arg_224_1:FormatText(var_227_7.content)

				arg_224_1.text_.text = var_227_8

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_10 = 8 <= 0 and var_227_6 or var_227_6 * (utf8.len(var_227_8) / 8)

				if (8 <= 0 and var_227_6 or var_227_6 * (utf8.len(var_227_8) / 8)) > 0 and var_227_6 < var_227_10 then
					arg_224_1.talkMaxDuration = var_227_10

					if var_227_10 + var_227_5 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_10 + var_227_5
					end
				end

				arg_224_1.text_.text = var_227_8
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071053", "story_v_out_424071.awb") ~= 0 then
					local var_227_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071053", "story_v_out_424071.awb") / 1000

					if var_227_11 + var_227_5 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_11 + var_227_5
					end

					if var_227_7.prefab_name ~= "" and arg_224_1.actors_[var_227_7.prefab_name] ~= nil then
						local var_227_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_7.prefab_name].transform, "story_v_out_424071", "424071053", "story_v_out_424071.awb")

						arg_224_1:RecordAudio("424071053", var_227_12)
						arg_224_1:RecordAudio("424071053", var_227_12)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_424071", "424071053", "story_v_out_424071.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_424071", "424071053", "story_v_out_424071.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_13 = math.max(var_227_6, arg_224_1.talkMaxDuration)

			if var_227_5 <= arg_224_1.time_ and arg_224_1.time_ < var_227_5 + var_227_13 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_5) / var_227_13

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_5 + var_227_13 and arg_224_1.time_ < var_227_5 + var_227_13 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_224_1:InitPlayNodeList()
	end,
	Play424071054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 424071054
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play424071055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["1094"]) and arg_228_1.var_.actorSpriteComps1094 == nil then
				arg_228_1.var_.actorSpriteComps1094 = arg_228_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_231_0 = 0.2

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["1094"]) then
				if arg_228_1.var_.actorSpriteComps1094 then
					for iter_231_0, iter_231_1 in pairs(arg_228_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_231_1 then
							if arg_228_1.isInRecall_ then
								iter_231_1.color = Color.New(Mathf.Lerp(iter_231_1.color.r, arg_228_1.hightColor2.r, (arg_228_1.time_ - 0) / var_231_0), Mathf.Lerp(iter_231_1.color.g, arg_228_1.hightColor2.g, (arg_228_1.time_ - 0) / var_231_0), (Mathf.Lerp(iter_231_1.color.b, arg_228_1.hightColor2.b, (arg_228_1.time_ - 0) / var_231_0)))
							else
								local var_231_1 = Mathf.Lerp(iter_231_1.color.r, 0.5, (arg_228_1.time_ - 0) / var_231_0)

								iter_231_1.color = Color.New(var_231_1, var_231_1, var_231_1)
							end
						end
					end
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["1094"]) and arg_228_1.var_.actorSpriteComps1094 then
				for iter_231_2, iter_231_3 in pairs(arg_228_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_231_3 then
						iter_231_3.color = arg_228_1.isInRecall_ and (arg_228_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_228_1.var_.actorSpriteComps1094 = nil
			end

			local var_231_2 = 0
			local var_231_3 = 0.725

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_2 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_4 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(424071054).content)

				arg_228_1.text_.text = var_231_4

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_6 = 29 <= 0 and var_231_3 or var_231_3 * (utf8.len(var_231_4) / 29)

				if (29 <= 0 and var_231_3 or var_231_3 * (utf8.len(var_231_4) / 29)) > 0 and var_231_3 < var_231_6 then
					arg_228_1.talkMaxDuration = var_231_6

					if var_231_6 + var_231_2 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_6 + var_231_2
					end
				end

				arg_228_1.text_.text = var_231_4
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_7 = math.max(var_231_3, arg_228_1.talkMaxDuration)

			if var_231_2 <= arg_228_1.time_ and arg_228_1.time_ < var_231_2 + var_231_7 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_2) / var_231_7

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_2 + var_231_7 and arg_228_1.time_ < var_231_2 + var_231_7 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play424071055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 424071055
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play424071056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1094 = arg_232_1.actors_["1094"].transform.localPosition
				arg_232_1.actors_["1094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_232_1:CheckSpriteTmpPos("1094", 7)

				for iter_235_0 = 0, arg_232_1.actors_["1094"].transform.childCount - 1 do
					local var_235_0 = arg_232_1.actors_["1094"].transform:GetChild(iter_235_0)

					if var_235_0.name == "" or not string.find(var_235_0.name, "split") then
						var_235_0.gameObject:SetActive(true)
					else
						var_235_0.gameObject:SetActive(false)
					end
				end
			end

			local var_235_1 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_1 then
				arg_232_1.actors_["1094"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_232_1.time_ - 0) / var_235_1)
			end

			if arg_232_1.time_ >= 0 + var_235_1 and arg_232_1.time_ < 0 + var_235_1 + arg_235_0 then
				arg_232_1.actors_["1094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_235_2 = 0
			local var_235_3 = 1.3

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_2 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_4 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(424071055).content)

				arg_232_1.text_.text = var_235_4

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_6 = 52 <= 0 and var_235_3 or var_235_3 * (utf8.len(var_235_4) / 52)

				if (52 <= 0 and var_235_3 or var_235_3 * (utf8.len(var_235_4) / 52)) > 0 and var_235_3 < var_235_6 then
					arg_232_1.talkMaxDuration = var_235_6

					if var_235_6 + var_235_2 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_6 + var_235_2
					end
				end

				arg_232_1.text_.text = var_235_4
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_7 = math.max(var_235_3, arg_232_1.talkMaxDuration)

			if var_235_2 <= arg_232_1.time_ and arg_232_1.time_ < var_235_2 + var_235_7 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_2) / var_235_7

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_2 + var_235_7 and arg_232_1.time_ < var_235_2 + var_235_7 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424071056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 424071056
		arg_236_1.duration_ = 9

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play424071057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if arg_236_1.bgs_.ST0115 == nil then
				local var_239_0 = Object.Instantiate(arg_236_1.paintGo_)

				var_239_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0115")
				var_239_0.name = "ST0115"
				var_239_0.transform.parent = arg_236_1.stage_.transform
				var_239_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_236_1.bgs_.ST0115 = var_239_0
			end

			if 2 < arg_236_1.time_ and arg_236_1.time_ <= 2 + arg_239_0 then
				local var_239_1 = arg_236_1.bgs_.ST0115

				arg_236_1.bgs_.ST0115.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_239_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_239_2 = var_239_1:GetComponent("SpriteRenderer")

				if var_239_2 and var_239_2.sprite then
					local var_239_3 = 2 * (var_239_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_239_1.transform.localScale = Vector3.New(var_239_3 / var_239_2.sprite.bounds.size.y < var_239_3 * manager.ui.mainCameraCom_.aspect / var_239_2.sprite.bounds.size.x and var_239_3 * manager.ui.mainCameraCom_.aspect / var_239_2.sprite.bounds.size.x or var_239_3 / var_239_2.sprite.bounds.size.y, var_239_3 / var_239_2.sprite.bounds.size.y < var_239_3 * manager.ui.mainCameraCom_.aspect / var_239_2.sprite.bounds.size.x and var_239_3 * manager.ui.mainCameraCom_.aspect / var_239_2.sprite.bounds.size.x or var_239_3 / var_239_2.sprite.bounds.size.y, 0)
				end

				for iter_239_0, iter_239_1 in pairs(arg_236_1.bgs_) do
					if iter_239_0 ~= "ST0115" then
						iter_239_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_239_4 = 4

			if 4 < arg_236_1.time_ and arg_236_1.time_ <= var_239_4 + arg_239_0 then
				arg_236_1.allBtn_.enabled = false
			end

			if arg_236_1.time_ >= var_239_4 + 0.3 and arg_236_1.time_ < var_239_4 + 0.3 + arg_239_0 then
				arg_236_1.allBtn_.enabled = true
			end

			local var_239_5 = 0

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_5 + arg_239_0 then
				arg_236_1.mask_.enabled = true
				arg_236_1.mask_.raycastTarget = true

				arg_236_1:SetGaussion(false)
			end

			local var_239_6 = 2

			if var_239_5 <= arg_236_1.time_ and arg_236_1.time_ < var_239_5 + var_239_6 then
				local var_239_7 = Color.New(0, 0, 0)

				var_239_7.a = Mathf.Lerp(0, 1, (arg_236_1.time_ - var_239_5) / var_239_6)
				arg_236_1.mask_.color = var_239_7
			end

			if arg_236_1.time_ >= var_239_5 + var_239_6 and arg_236_1.time_ < var_239_5 + var_239_6 + arg_239_0 then
				local var_239_8 = Color.New(0, 0, 0)

				var_239_8.a = 1
				arg_236_1.mask_.color = var_239_8
			end

			local var_239_9 = 2

			if 2 < arg_236_1.time_ and arg_236_1.time_ <= var_239_9 + arg_239_0 then
				arg_236_1.mask_.enabled = true
				arg_236_1.mask_.raycastTarget = true

				arg_236_1:SetGaussion(false)
			end

			local var_239_10 = 2

			if var_239_9 <= arg_236_1.time_ and arg_236_1.time_ < var_239_9 + var_239_10 then
				local var_239_11 = Color.New(0, 0, 0)

				var_239_11.a = Mathf.Lerp(1, 0, (arg_236_1.time_ - var_239_9) / var_239_10)
				arg_236_1.mask_.color = var_239_11
			end

			if arg_236_1.time_ >= var_239_9 + var_239_10 and arg_236_1.time_ < var_239_9 + var_239_10 + arg_239_0 then
				local var_239_12 = Color.New(0, 0, 0)

				arg_236_1.mask_.enabled = false
				var_239_12.a = 0
				arg_236_1.mask_.color = var_239_12
			end

			if 0.233333333333333 < arg_236_1.time_ and arg_236_1.time_ <= 0.233333333333333 + arg_239_0 then
				arg_236_1:AudioAction("stop", "effect", "se_story_133", "se_story_133_sea", "")
			end

			if 1.7 < arg_236_1.time_ and arg_236_1.time_ <= 1.7 + arg_239_0 then
				arg_236_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_room01", "")
			end

			if arg_236_1.frameCnt_ <= 1 then
				arg_236_1.dialog_:SetActive(false)
			end

			local var_239_15 = 4
			local var_239_16 = 0.375

			if 4 < arg_236_1.time_ and arg_236_1.time_ <= var_239_15 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0

				arg_236_1.dialog_:SetActive(true)

				arg_236_1.dialogCg_.alpha = 0

				local var_239_17 = LeanTween.value(arg_236_1.dialog_, 0, 1, 0.3)

				var_239_17:setOnUpdate(LuaHelper.FloatAction(function(arg_240_0)
					arg_236_1.dialogCg_.alpha = arg_240_0
				end))
				var_239_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_236_1.dialog_)
					var_239_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_236_1.duration_ = arg_236_1.duration_ + 0.3

				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_18 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(424071056).content)

				arg_236_1.text_.text = var_239_18

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_20 = 15 <= 0 and var_239_16 or var_239_16 * (utf8.len(var_239_18) / 15)

				if (15 <= 0 and var_239_16 or var_239_16 * (utf8.len(var_239_18) / 15)) > 0 and var_239_16 < var_239_20 then
					arg_236_1.talkMaxDuration = var_239_20
					var_239_15 = var_239_15 + 0.3

					if var_239_20 + var_239_15 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_20 + var_239_15
					end
				end

				arg_236_1.text_.text = var_239_18
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_21 = var_239_15 + 0.3
			local var_239_22 = math.max(var_239_16, arg_236_1.talkMaxDuration)

			if var_239_15 + 0.3 <= arg_236_1.time_ and arg_236_1.time_ < var_239_21 + var_239_22 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_21) / var_239_22

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_21 + var_239_22 and arg_236_1.time_ < var_239_21 + var_239_22 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play424071057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 424071057
		arg_242_1.duration_ = 12

		local var_242_0 = {
			zh = 8.133,
			ja = 12
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play424071058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if arg_242_1.actors_["10155"] == nil then
				local var_245_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10155")

				if not isNil(var_245_0) then
					local var_245_1 = Object.Instantiate(var_245_0, arg_242_1.canvasGo_.transform)

					var_245_1.transform:SetSiblingIndex(1)

					var_245_1.name = "10155"
					var_245_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_242_1.actors_["10155"] = var_245_1

					if arg_242_1.isInRecall_ then
						for iter_245_0, iter_245_1 in ipairs((var_245_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_245_1.color = arg_242_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_245_2 = arg_242_1.actors_["10155"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_2) and arg_242_1.var_.actorSpriteComps10155 == nil then
				arg_242_1.var_.actorSpriteComps10155 = var_245_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_3 = 0.2

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_3 and not isNil(var_245_2) then
				if arg_242_1.var_.actorSpriteComps10155 then
					for iter_245_2, iter_245_3 in pairs(arg_242_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_245_3 then
							if arg_242_1.isInRecall_ then
								iter_245_3.color = Color.New(Mathf.Lerp(iter_245_3.color.r, arg_242_1.hightColor1.r, (arg_242_1.time_ - 0) / var_245_3), Mathf.Lerp(iter_245_3.color.g, arg_242_1.hightColor1.g, (arg_242_1.time_ - 0) / var_245_3), (Mathf.Lerp(iter_245_3.color.b, arg_242_1.hightColor1.b, (arg_242_1.time_ - 0) / var_245_3)))
							else
								local var_245_4 = Mathf.Lerp(iter_245_3.color.r, 1, (arg_242_1.time_ - 0) / var_245_3)

								iter_245_3.color = Color.New(var_245_4, var_245_4, var_245_4)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= 0 + var_245_3 and arg_242_1.time_ < 0 + var_245_3 + arg_245_0 and not isNil(var_245_2) and arg_242_1.var_.actorSpriteComps10155 then
				for iter_245_4, iter_245_5 in pairs(arg_242_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_245_5 then
						iter_245_5.color = arg_242_1.isInRecall_ and (arg_242_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_242_1.var_.actorSpriteComps10155 = nil
			end

			local var_245_5 = arg_242_1.actors_["10155"].transform

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos10155 = var_245_5.localPosition
				var_245_5.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("10155", 3)

				for iter_245_6 = 0, var_245_5.childCount - 1 do
					local var_245_6 = var_245_5:GetChild(iter_245_6)

					if var_245_6.name == "split_5" or not string.find(var_245_6.name, "split") then
						var_245_6.gameObject:SetActive(true)
					else
						var_245_6.gameObject:SetActive(false)
					end
				end
			end

			local var_245_7 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_7 then
				var_245_5.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10155, Vector3.New(-40, -390, -250), (arg_242_1.time_ - 0) / var_245_7)
			end

			if arg_242_1.time_ >= 0 + var_245_7 and arg_242_1.time_ < 0 + var_245_7 + arg_245_0 then
				var_245_5.localPosition = Vector3.New(-40, -390, -250)
			end

			local var_245_8 = 0
			local var_245_9 = 0.75

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_8 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_10 = arg_242_1:GetWordFromCfg(424071057)
				local var_245_11 = arg_242_1:FormatText(var_245_10.content)

				arg_242_1.text_.text = var_245_11

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_13 = 30 <= 0 and var_245_9 or var_245_9 * (utf8.len(var_245_11) / 30)

				if (30 <= 0 and var_245_9 or var_245_9 * (utf8.len(var_245_11) / 30)) > 0 and var_245_9 < var_245_13 then
					arg_242_1.talkMaxDuration = var_245_13

					if var_245_13 + var_245_8 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_13 + var_245_8
					end
				end

				arg_242_1.text_.text = var_245_11
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071057", "story_v_out_424071.awb") ~= 0 then
					local var_245_14 = manager.audio:GetVoiceLength("story_v_out_424071", "424071057", "story_v_out_424071.awb") / 1000

					if var_245_14 + var_245_8 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_14 + var_245_8
					end

					if var_245_10.prefab_name ~= "" and arg_242_1.actors_[var_245_10.prefab_name] ~= nil then
						local var_245_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_10.prefab_name].transform, "story_v_out_424071", "424071057", "story_v_out_424071.awb")

						arg_242_1:RecordAudio("424071057", var_245_15)
						arg_242_1:RecordAudio("424071057", var_245_15)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_424071", "424071057", "story_v_out_424071.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_424071", "424071057", "story_v_out_424071.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_16 = math.max(var_245_9, arg_242_1.talkMaxDuration)

			if var_245_8 <= arg_242_1.time_ and arg_242_1.time_ < var_245_8 + var_245_16 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_8) / var_245_16

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_8 + var_245_16 and arg_242_1.time_ < var_245_8 + var_245_16 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play424071058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 424071058
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play424071059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["10155"]) and arg_246_1.var_.actorSpriteComps10155 == nil then
				arg_246_1.var_.actorSpriteComps10155 = arg_246_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_0 = 0.2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["10155"]) then
				if arg_246_1.var_.actorSpriteComps10155 then
					for iter_249_0, iter_249_1 in pairs(arg_246_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_249_1 then
							if arg_246_1.isInRecall_ then
								iter_249_1.color = Color.New(Mathf.Lerp(iter_249_1.color.r, arg_246_1.hightColor2.r, (arg_246_1.time_ - 0) / var_249_0), Mathf.Lerp(iter_249_1.color.g, arg_246_1.hightColor2.g, (arg_246_1.time_ - 0) / var_249_0), (Mathf.Lerp(iter_249_1.color.b, arg_246_1.hightColor2.b, (arg_246_1.time_ - 0) / var_249_0)))
							else
								local var_249_1 = Mathf.Lerp(iter_249_1.color.r, 0.5, (arg_246_1.time_ - 0) / var_249_0)

								iter_249_1.color = Color.New(var_249_1, var_249_1, var_249_1)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["10155"]) and arg_246_1.var_.actorSpriteComps10155 then
				for iter_249_2, iter_249_3 in pairs(arg_246_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_249_3 then
						iter_249_3.color = arg_246_1.isInRecall_ and (arg_246_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_246_1.var_.actorSpriteComps10155 = nil
			end

			local var_249_2 = 0
			local var_249_3 = 0.85

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_2 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_4 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(424071058).content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_6 = 34 <= 0 and var_249_3 or var_249_3 * (utf8.len(var_249_4) / 34)

				if (34 <= 0 and var_249_3 or var_249_3 * (utf8.len(var_249_4) / 34)) > 0 and var_249_3 < var_249_6 then
					arg_246_1.talkMaxDuration = var_249_6

					if var_249_6 + var_249_2 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_6 + var_249_2
					end
				end

				arg_246_1.text_.text = var_249_4
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_7 = math.max(var_249_3, arg_246_1.talkMaxDuration)

			if var_249_2 <= arg_246_1.time_ and arg_246_1.time_ < var_249_2 + var_249_7 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_2) / var_249_7

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_2 + var_249_7 and arg_246_1.time_ < var_249_2 + var_249_7 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play424071059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 424071059
		arg_250_1.duration_ = 14.97

		local var_250_0 = {
			zh = 7.233,
			ja = 14.966
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
				arg_250_0:Play424071060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["10155"]) and arg_250_1.var_.actorSpriteComps10155 == nil then
				arg_250_1.var_.actorSpriteComps10155 = arg_250_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_0 = 0.2

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["10155"]) then
				if arg_250_1.var_.actorSpriteComps10155 then
					for iter_253_0, iter_253_1 in pairs(arg_250_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_253_1 then
							if arg_250_1.isInRecall_ then
								iter_253_1.color = Color.New(Mathf.Lerp(iter_253_1.color.r, arg_250_1.hightColor1.r, (arg_250_1.time_ - 0) / var_253_0), Mathf.Lerp(iter_253_1.color.g, arg_250_1.hightColor1.g, (arg_250_1.time_ - 0) / var_253_0), (Mathf.Lerp(iter_253_1.color.b, arg_250_1.hightColor1.b, (arg_250_1.time_ - 0) / var_253_0)))
							else
								local var_253_1 = Mathf.Lerp(iter_253_1.color.r, 1, (arg_250_1.time_ - 0) / var_253_0)

								iter_253_1.color = Color.New(var_253_1, var_253_1, var_253_1)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["10155"]) and arg_250_1.var_.actorSpriteComps10155 then
				for iter_253_2, iter_253_3 in pairs(arg_250_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_253_3 then
						iter_253_3.color = arg_250_1.isInRecall_ and (arg_250_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_250_1.var_.actorSpriteComps10155 = nil
			end

			local var_253_2 = arg_250_1.actors_["10155"].transform

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos10155 = var_253_2.localPosition
				var_253_2.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("10155", 3)

				for iter_253_4 = 0, var_253_2.childCount - 1 do
					local var_253_3 = var_253_2:GetChild(iter_253_4)

					if var_253_3.name == "split_1" then
						var_253_3:SetAsLastSibling()
						var_253_3.gameObject:SetActive(true)

						arg_250_1.var_.actorSpriteSplit10155 = var_253_3.gameObject:GetComponent(typeof(Image))

						arg_250_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_253_4 = 0.5

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_4 then
				var_253_2.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10155, Vector3.New(-40, -390, -250), (arg_250_1.time_ - 0) / var_253_4)

				if arg_250_1.var_.actorSpriteSplit10155 ~= nil then
					arg_250_1.var_.actorSpriteSplit10155:SetAlpha((arg_250_1.time_ - 0) / var_253_4)
				end
			end

			if arg_250_1.time_ >= 0 + var_253_4 and arg_250_1.time_ < 0 + var_253_4 + arg_253_0 then
				var_253_2.localPosition = Vector3.New(-40, -390, -250)

				if arg_250_1.var_.actorSpriteSplit10155 ~= nil then
					arg_250_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_253_5 = 0
			local var_253_6 = 0.9

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_5 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_7 = arg_250_1:GetWordFromCfg(424071059)
				local var_253_8 = arg_250_1:FormatText(var_253_7.content)

				arg_250_1.text_.text = var_253_8

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_10 = 36 <= 0 and var_253_6 or var_253_6 * (utf8.len(var_253_8) / 36)

				if (36 <= 0 and var_253_6 or var_253_6 * (utf8.len(var_253_8) / 36)) > 0 and var_253_6 < var_253_10 then
					arg_250_1.talkMaxDuration = var_253_10

					if var_253_10 + var_253_5 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_10 + var_253_5
					end
				end

				arg_250_1.text_.text = var_253_8
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071059", "story_v_out_424071.awb") ~= 0 then
					local var_253_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071059", "story_v_out_424071.awb") / 1000

					if var_253_11 + var_253_5 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_11 + var_253_5
					end

					if var_253_7.prefab_name ~= "" and arg_250_1.actors_[var_253_7.prefab_name] ~= nil then
						local var_253_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_7.prefab_name].transform, "story_v_out_424071", "424071059", "story_v_out_424071.awb")

						arg_250_1:RecordAudio("424071059", var_253_12)
						arg_250_1:RecordAudio("424071059", var_253_12)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_424071", "424071059", "story_v_out_424071.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_424071", "424071059", "story_v_out_424071.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_13 = math.max(var_253_6, arg_250_1.talkMaxDuration)

			if var_253_5 <= arg_250_1.time_ and arg_250_1.time_ < var_253_5 + var_253_13 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_5) / var_253_13

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_5 + var_253_13 and arg_250_1.time_ < var_253_5 + var_253_13 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_250_1:InitPlayNodeList()
	end,
	Play424071060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 424071060
		arg_254_1.duration_ = 3.27

		local var_254_0 = {
			zh = 2.333,
			ja = 3.266
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play424071061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["1094"]) and arg_254_1.var_.actorSpriteComps1094 == nil then
				arg_254_1.var_.actorSpriteComps1094 = arg_254_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_0 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["1094"]) then
				if arg_254_1.var_.actorSpriteComps1094 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_257_1 then
							if arg_254_1.isInRecall_ then
								iter_257_1.color = Color.New(Mathf.Lerp(iter_257_1.color.r, arg_254_1.hightColor1.r, (arg_254_1.time_ - 0) / var_257_0), Mathf.Lerp(iter_257_1.color.g, arg_254_1.hightColor1.g, (arg_254_1.time_ - 0) / var_257_0), (Mathf.Lerp(iter_257_1.color.b, arg_254_1.hightColor1.b, (arg_254_1.time_ - 0) / var_257_0)))
							else
								local var_257_1 = Mathf.Lerp(iter_257_1.color.r, 1, (arg_254_1.time_ - 0) / var_257_0)

								iter_257_1.color = Color.New(var_257_1, var_257_1, var_257_1)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["1094"]) and arg_254_1.var_.actorSpriteComps1094 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_257_3 then
						iter_257_3.color = arg_254_1.isInRecall_ and (arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_254_1.var_.actorSpriteComps1094 = nil
			end

			local var_257_2 = arg_254_1.actors_["10155"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_2) and arg_254_1.var_.actorSpriteComps10155 == nil then
				arg_254_1.var_.actorSpriteComps10155 = var_257_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_3 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_3 and not isNil(var_257_2) then
				if arg_254_1.var_.actorSpriteComps10155 then
					for iter_257_4, iter_257_5 in pairs(arg_254_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_257_5 then
							if arg_254_1.isInRecall_ then
								iter_257_5.color = Color.New(Mathf.Lerp(iter_257_5.color.r, arg_254_1.hightColor2.r, (arg_254_1.time_ - 0) / var_257_3), Mathf.Lerp(iter_257_5.color.g, arg_254_1.hightColor2.g, (arg_254_1.time_ - 0) / var_257_3), (Mathf.Lerp(iter_257_5.color.b, arg_254_1.hightColor2.b, (arg_254_1.time_ - 0) / var_257_3)))
							else
								local var_257_4 = Mathf.Lerp(iter_257_5.color.r, 0.5, (arg_254_1.time_ - 0) / var_257_3)

								iter_257_5.color = Color.New(var_257_4, var_257_4, var_257_4)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= 0 + var_257_3 and arg_254_1.time_ < 0 + var_257_3 + arg_257_0 and not isNil(var_257_2) and arg_254_1.var_.actorSpriteComps10155 then
				for iter_257_6, iter_257_7 in pairs(arg_254_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_257_7 then
						iter_257_7.color = arg_254_1.isInRecall_ and (arg_254_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_254_1.var_.actorSpriteComps10155 = nil
			end

			local var_257_5 = arg_254_1.actors_["1094"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1094 = var_257_5.localPosition
				var_257_5.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("1094", 4)

				for iter_257_8 = 0, var_257_5.childCount - 1 do
					local var_257_6 = var_257_5:GetChild(iter_257_8)

					if var_257_6.name == "split_1" or not string.find(var_257_6.name, "split") then
						var_257_6.gameObject:SetActive(true)
					else
						var_257_6.gameObject:SetActive(false)
					end
				end
			end

			local var_257_7 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_7 then
				var_257_5.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_254_1.time_ - 0) / var_257_7)
			end

			if arg_254_1.time_ >= 0 + var_257_7 and arg_254_1.time_ < 0 + var_257_7 + arg_257_0 then
				var_257_5.localPosition = Vector3.New(470, -335, -230)
			end

			local var_257_8 = arg_254_1.actors_["10155"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos10155 = var_257_8.localPosition
				var_257_8.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("10155", 2)

				for iter_257_9 = 0, var_257_8.childCount - 1 do
					local var_257_9 = var_257_8:GetChild(iter_257_9)

					if var_257_9.name == "split_1" or not string.find(var_257_9.name, "split") then
						var_257_9.gameObject:SetActive(true)
					else
						var_257_9.gameObject:SetActive(false)
					end
				end
			end

			local var_257_10 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_10 then
				var_257_8.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_254_1.time_ - 0) / var_257_10)
			end

			if arg_254_1.time_ >= 0 + var_257_10 and arg_254_1.time_ < 0 + var_257_10 + arg_257_0 then
				var_257_8.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_257_11 = 0
			local var_257_12 = 0.275

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_11 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_13 = arg_254_1:GetWordFromCfg(424071060)
				local var_257_14 = arg_254_1:FormatText(var_257_13.content)

				arg_254_1.text_.text = var_257_14

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_16 = 11 <= 0 and var_257_12 or var_257_12 * (utf8.len(var_257_14) / 11)

				if (11 <= 0 and var_257_12 or var_257_12 * (utf8.len(var_257_14) / 11)) > 0 and var_257_12 < var_257_16 then
					arg_254_1.talkMaxDuration = var_257_16

					if var_257_16 + var_257_11 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_16 + var_257_11
					end
				end

				arg_254_1.text_.text = var_257_14
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071060", "story_v_out_424071.awb") ~= 0 then
					local var_257_17 = manager.audio:GetVoiceLength("story_v_out_424071", "424071060", "story_v_out_424071.awb") / 1000

					if var_257_17 + var_257_11 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_17 + var_257_11
					end

					if var_257_13.prefab_name ~= "" and arg_254_1.actors_[var_257_13.prefab_name] ~= nil then
						local var_257_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_13.prefab_name].transform, "story_v_out_424071", "424071060", "story_v_out_424071.awb")

						arg_254_1:RecordAudio("424071060", var_257_18)
						arg_254_1:RecordAudio("424071060", var_257_18)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_424071", "424071060", "story_v_out_424071.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_424071", "424071060", "story_v_out_424071.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_19 = math.max(var_257_12, arg_254_1.talkMaxDuration)

			if var_257_11 <= arg_254_1.time_ and arg_254_1.time_ < var_257_11 + var_257_19 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_11) / var_257_19

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_11 + var_257_19 and arg_254_1.time_ < var_257_11 + var_257_19 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play424071061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 424071061
		arg_258_1.duration_ = 4.47

		local var_258_0 = {
			zh = 3.133,
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
				arg_258_0:Play424071062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["1094"]) and arg_258_1.var_.actorSpriteComps1094 == nil then
				arg_258_1.var_.actorSpriteComps1094 = arg_258_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_0 = 0.2

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["1094"]) then
				if arg_258_1.var_.actorSpriteComps1094 then
					for iter_261_0, iter_261_1 in pairs(arg_258_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_261_1 then
							if arg_258_1.isInRecall_ then
								iter_261_1.color = Color.New(Mathf.Lerp(iter_261_1.color.r, arg_258_1.hightColor2.r, (arg_258_1.time_ - 0) / var_261_0), Mathf.Lerp(iter_261_1.color.g, arg_258_1.hightColor2.g, (arg_258_1.time_ - 0) / var_261_0), (Mathf.Lerp(iter_261_1.color.b, arg_258_1.hightColor2.b, (arg_258_1.time_ - 0) / var_261_0)))
							else
								local var_261_1 = Mathf.Lerp(iter_261_1.color.r, 0.5, (arg_258_1.time_ - 0) / var_261_0)

								iter_261_1.color = Color.New(var_261_1, var_261_1, var_261_1)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["1094"]) and arg_258_1.var_.actorSpriteComps1094 then
				for iter_261_2, iter_261_3 in pairs(arg_258_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_261_3 then
						iter_261_3.color = arg_258_1.isInRecall_ and (arg_258_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_258_1.var_.actorSpriteComps1094 = nil
			end

			local var_261_2 = 0
			local var_261_3 = 0.425

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_2 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_4 = arg_258_1:GetWordFromCfg(424071061)
				local var_261_5 = arg_258_1:FormatText(var_261_4.content)

				arg_258_1.text_.text = var_261_5

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_7 = 17 <= 0 and var_261_3 or var_261_3 * (utf8.len(var_261_5) / 17)

				if (17 <= 0 and var_261_3 or var_261_3 * (utf8.len(var_261_5) / 17)) > 0 and var_261_3 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_2 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_2
					end
				end

				arg_258_1.text_.text = var_261_5
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071061", "story_v_out_424071.awb") ~= 0 then
					local var_261_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071061", "story_v_out_424071.awb") / 1000

					if var_261_8 + var_261_2 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_8 + var_261_2
					end

					if var_261_4.prefab_name ~= "" and arg_258_1.actors_[var_261_4.prefab_name] ~= nil then
						local var_261_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_4.prefab_name].transform, "story_v_out_424071", "424071061", "story_v_out_424071.awb")

						arg_258_1:RecordAudio("424071061", var_261_9)
						arg_258_1:RecordAudio("424071061", var_261_9)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_424071", "424071061", "story_v_out_424071.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_424071", "424071061", "story_v_out_424071.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_10 = math.max(var_261_3, arg_258_1.talkMaxDuration)

			if var_261_2 <= arg_258_1.time_ and arg_258_1.time_ < var_261_2 + var_261_10 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_2) / var_261_10

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_2 + var_261_10 and arg_258_1.time_ < var_261_2 + var_261_10 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play424071062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 424071062
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play424071063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 1.15

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_1 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(424071062).content)

				arg_262_1.text_.text = var_265_1

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_3 = 46 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 46)

				if (46 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_1) / 46)) > 0 and var_265_0 < var_265_3 then
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
	Play424071063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 424071063
		arg_266_1.duration_ = 5.3

		local var_266_0 = {
			zh = 4.1,
			ja = 5.3
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
				arg_266_0:Play424071064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["10155"]) and arg_266_1.var_.actorSpriteComps10155 == nil then
				arg_266_1.var_.actorSpriteComps10155 = arg_266_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_0 = 0.2

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["10155"]) then
				if arg_266_1.var_.actorSpriteComps10155 then
					for iter_269_0, iter_269_1 in pairs(arg_266_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_269_1 then
							if arg_266_1.isInRecall_ then
								iter_269_1.color = Color.New(Mathf.Lerp(iter_269_1.color.r, arg_266_1.hightColor1.r, (arg_266_1.time_ - 0) / var_269_0), Mathf.Lerp(iter_269_1.color.g, arg_266_1.hightColor1.g, (arg_266_1.time_ - 0) / var_269_0), (Mathf.Lerp(iter_269_1.color.b, arg_266_1.hightColor1.b, (arg_266_1.time_ - 0) / var_269_0)))
							else
								local var_269_1 = Mathf.Lerp(iter_269_1.color.r, 1, (arg_266_1.time_ - 0) / var_269_0)

								iter_269_1.color = Color.New(var_269_1, var_269_1, var_269_1)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["10155"]) and arg_266_1.var_.actorSpriteComps10155 then
				for iter_269_2, iter_269_3 in pairs(arg_266_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_269_3 then
						iter_269_3.color = arg_266_1.isInRecall_ and (arg_266_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_266_1.var_.actorSpriteComps10155 = nil
			end

			local var_269_2 = arg_266_1.actors_["10155"].transform

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos10155 = var_269_2.localPosition
				var_269_2.localScale = Vector3.New(1, 1, 1)

				arg_266_1:CheckSpriteTmpPos("10155", 2)

				for iter_269_4 = 0, var_269_2.childCount - 1 do
					local var_269_3 = var_269_2:GetChild(iter_269_4)

					if var_269_3.name == "" or not string.find(var_269_3.name, "split") then
						var_269_3.gameObject:SetActive(true)
					else
						var_269_3.gameObject:SetActive(false)
					end
				end
			end

			local var_269_4 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_4 then
				var_269_2.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_266_1.time_ - 0) / var_269_4)
			end

			if arg_266_1.time_ >= 0 + var_269_4 and arg_266_1.time_ < 0 + var_269_4 + arg_269_0 then
				var_269_2.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_269_5 = 0
			local var_269_6 = 0.525

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_5 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_7 = arg_266_1:GetWordFromCfg(424071063)
				local var_269_8 = arg_266_1:FormatText(var_269_7.content)

				arg_266_1.text_.text = var_269_8

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_10 = 21 <= 0 and var_269_6 or var_269_6 * (utf8.len(var_269_8) / 21)

				if (21 <= 0 and var_269_6 or var_269_6 * (utf8.len(var_269_8) / 21)) > 0 and var_269_6 < var_269_10 then
					arg_266_1.talkMaxDuration = var_269_10

					if var_269_10 + var_269_5 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_10 + var_269_5
					end
				end

				arg_266_1.text_.text = var_269_8
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071063", "story_v_out_424071.awb") ~= 0 then
					local var_269_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071063", "story_v_out_424071.awb") / 1000

					if var_269_11 + var_269_5 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_11 + var_269_5
					end

					if var_269_7.prefab_name ~= "" and arg_266_1.actors_[var_269_7.prefab_name] ~= nil then
						local var_269_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_7.prefab_name].transform, "story_v_out_424071", "424071063", "story_v_out_424071.awb")

						arg_266_1:RecordAudio("424071063", var_269_12)
						arg_266_1:RecordAudio("424071063", var_269_12)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_424071", "424071063", "story_v_out_424071.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_424071", "424071063", "story_v_out_424071.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_13 = math.max(var_269_6, arg_266_1.talkMaxDuration)

			if var_269_5 <= arg_266_1.time_ and arg_266_1.time_ < var_269_5 + var_269_13 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_5) / var_269_13

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_5 + var_269_13 and arg_266_1.time_ < var_269_5 + var_269_13 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play424071064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 424071064
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play424071065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["10155"]) and arg_270_1.var_.actorSpriteComps10155 == nil then
				arg_270_1.var_.actorSpriteComps10155 = arg_270_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_0 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["10155"]) then
				if arg_270_1.var_.actorSpriteComps10155 then
					for iter_273_0, iter_273_1 in pairs(arg_270_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_273_1 then
							if arg_270_1.isInRecall_ then
								iter_273_1.color = Color.New(Mathf.Lerp(iter_273_1.color.r, arg_270_1.hightColor2.r, (arg_270_1.time_ - 0) / var_273_0), Mathf.Lerp(iter_273_1.color.g, arg_270_1.hightColor2.g, (arg_270_1.time_ - 0) / var_273_0), (Mathf.Lerp(iter_273_1.color.b, arg_270_1.hightColor2.b, (arg_270_1.time_ - 0) / var_273_0)))
							else
								local var_273_1 = Mathf.Lerp(iter_273_1.color.r, 0.5, (arg_270_1.time_ - 0) / var_273_0)

								iter_273_1.color = Color.New(var_273_1, var_273_1, var_273_1)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["10155"]) and arg_270_1.var_.actorSpriteComps10155 then
				for iter_273_2, iter_273_3 in pairs(arg_270_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_273_3 then
						iter_273_3.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_270_1.var_.actorSpriteComps10155 = nil
			end

			local var_273_2 = 0
			local var_273_3 = 0.525

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_2 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_4 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(424071064).content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_6 = 21 <= 0 and var_273_3 or var_273_3 * (utf8.len(var_273_4) / 21)

				if (21 <= 0 and var_273_3 or var_273_3 * (utf8.len(var_273_4) / 21)) > 0 and var_273_3 < var_273_6 then
					arg_270_1.talkMaxDuration = var_273_6

					if var_273_6 + var_273_2 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_6 + var_273_2
					end
				end

				arg_270_1.text_.text = var_273_4
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_7 = math.max(var_273_3, arg_270_1.talkMaxDuration)

			if var_273_2 <= arg_270_1.time_ and arg_270_1.time_ < var_273_2 + var_273_7 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_2) / var_273_7

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_2 + var_273_7 and arg_270_1.time_ < var_273_2 + var_273_7 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play424071065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 424071065
		arg_274_1.duration_ = 4.57

		local var_274_0 = {
			zh = 2.7,
			ja = 4.566
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
				arg_274_0:Play424071066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["10155"]) and arg_274_1.var_.actorSpriteComps10155 == nil then
				arg_274_1.var_.actorSpriteComps10155 = arg_274_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_0 = 0.2

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["10155"]) then
				if arg_274_1.var_.actorSpriteComps10155 then
					for iter_277_0, iter_277_1 in pairs(arg_274_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_277_1 then
							if arg_274_1.isInRecall_ then
								iter_277_1.color = Color.New(Mathf.Lerp(iter_277_1.color.r, arg_274_1.hightColor1.r, (arg_274_1.time_ - 0) / var_277_0), Mathf.Lerp(iter_277_1.color.g, arg_274_1.hightColor1.g, (arg_274_1.time_ - 0) / var_277_0), (Mathf.Lerp(iter_277_1.color.b, arg_274_1.hightColor1.b, (arg_274_1.time_ - 0) / var_277_0)))
							else
								local var_277_1 = Mathf.Lerp(iter_277_1.color.r, 1, (arg_274_1.time_ - 0) / var_277_0)

								iter_277_1.color = Color.New(var_277_1, var_277_1, var_277_1)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["10155"]) and arg_274_1.var_.actorSpriteComps10155 then
				for iter_277_2, iter_277_3 in pairs(arg_274_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_277_3 then
						iter_277_3.color = arg_274_1.isInRecall_ and (arg_274_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_274_1.var_.actorSpriteComps10155 = nil
			end

			local var_277_2 = arg_274_1.actors_["10155"].transform

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos10155 = var_277_2.localPosition
				var_277_2.localScale = Vector3.New(1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("10155", 2)

				for iter_277_4 = 0, var_277_2.childCount - 1 do
					local var_277_3 = var_277_2:GetChild(iter_277_4)

					if var_277_3.name == "split_4" then
						var_277_3:SetAsLastSibling()
						var_277_3.gameObject:SetActive(true)

						arg_274_1.var_.actorSpriteSplit10155 = var_277_3.gameObject:GetComponent(typeof(Image))

						arg_274_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_277_4 = 0.5

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_4 then
				var_277_2.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_274_1.time_ - 0) / var_277_4)

				if arg_274_1.var_.actorSpriteSplit10155 ~= nil then
					arg_274_1.var_.actorSpriteSplit10155:SetAlpha((arg_274_1.time_ - 0) / var_277_4)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_4 and arg_274_1.time_ < 0 + var_277_4 + arg_277_0 then
				var_277_2.localPosition = Vector3.New(-410, -390, -250)

				if arg_274_1.var_.actorSpriteSplit10155 ~= nil then
					arg_274_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_277_5 = 0
			local var_277_6 = 0.325

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_5 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_7 = arg_274_1:GetWordFromCfg(424071065)
				local var_277_8 = arg_274_1:FormatText(var_277_7.content)

				arg_274_1.text_.text = var_277_8

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_10 = 13 <= 0 and var_277_6 or var_277_6 * (utf8.len(var_277_8) / 13)

				if (13 <= 0 and var_277_6 or var_277_6 * (utf8.len(var_277_8) / 13)) > 0 and var_277_6 < var_277_10 then
					arg_274_1.talkMaxDuration = var_277_10

					if var_277_10 + var_277_5 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_10 + var_277_5
					end
				end

				arg_274_1.text_.text = var_277_8
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071065", "story_v_out_424071.awb") ~= 0 then
					local var_277_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071065", "story_v_out_424071.awb") / 1000

					if var_277_11 + var_277_5 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_11 + var_277_5
					end

					if var_277_7.prefab_name ~= "" and arg_274_1.actors_[var_277_7.prefab_name] ~= nil then
						local var_277_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_7.prefab_name].transform, "story_v_out_424071", "424071065", "story_v_out_424071.awb")

						arg_274_1:RecordAudio("424071065", var_277_12)
						arg_274_1:RecordAudio("424071065", var_277_12)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_424071", "424071065", "story_v_out_424071.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_424071", "424071065", "story_v_out_424071.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_13 = math.max(var_277_6, arg_274_1.talkMaxDuration)

			if var_277_5 <= arg_274_1.time_ and arg_274_1.time_ < var_277_5 + var_277_13 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_5) / var_277_13

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_5 + var_277_13 and arg_274_1.time_ < var_277_5 + var_277_13 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play424071066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 424071066
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play424071067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(arg_278_1.actors_["10155"]) and arg_278_1.var_.actorSpriteComps10155 == nil then
				arg_278_1.var_.actorSpriteComps10155 = arg_278_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_0 = 0.2

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 and not isNil(arg_278_1.actors_["10155"]) then
				if arg_278_1.var_.actorSpriteComps10155 then
					for iter_281_0, iter_281_1 in pairs(arg_278_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_281_1 then
							if arg_278_1.isInRecall_ then
								iter_281_1.color = Color.New(Mathf.Lerp(iter_281_1.color.r, arg_278_1.hightColor2.r, (arg_278_1.time_ - 0) / var_281_0), Mathf.Lerp(iter_281_1.color.g, arg_278_1.hightColor2.g, (arg_278_1.time_ - 0) / var_281_0), (Mathf.Lerp(iter_281_1.color.b, arg_278_1.hightColor2.b, (arg_278_1.time_ - 0) / var_281_0)))
							else
								local var_281_1 = Mathf.Lerp(iter_281_1.color.r, 0.5, (arg_278_1.time_ - 0) / var_281_0)

								iter_281_1.color = Color.New(var_281_1, var_281_1, var_281_1)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 and not isNil(arg_278_1.actors_["10155"]) and arg_278_1.var_.actorSpriteComps10155 then
				for iter_281_2, iter_281_3 in pairs(arg_278_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_281_3 then
						iter_281_3.color = arg_278_1.isInRecall_ and (arg_278_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_278_1.var_.actorSpriteComps10155 = nil
			end

			local var_281_2 = 0
			local var_281_3 = 0.65

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_2 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_4 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(424071066).content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_6 = 26 <= 0 and var_281_3 or var_281_3 * (utf8.len(var_281_4) / 26)

				if (26 <= 0 and var_281_3 or var_281_3 * (utf8.len(var_281_4) / 26)) > 0 and var_281_3 < var_281_6 then
					arg_278_1.talkMaxDuration = var_281_6

					if var_281_6 + var_281_2 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_6 + var_281_2
					end
				end

				arg_278_1.text_.text = var_281_4
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_7 = math.max(var_281_3, arg_278_1.talkMaxDuration)

			if var_281_2 <= arg_278_1.time_ and arg_278_1.time_ < var_281_2 + var_281_7 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_2) / var_281_7

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_2 + var_281_7 and arg_278_1.time_ < var_281_2 + var_281_7 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play424071067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 424071067
		arg_282_1.duration_ = 6.3

		local var_282_0 = {
			zh = 6.3,
			ja = 5.4
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
				arg_282_0:Play424071068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(arg_282_1.actors_["10155"]) and arg_282_1.var_.actorSpriteComps10155 == nil then
				arg_282_1.var_.actorSpriteComps10155 = arg_282_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_0 = 0.2

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 and not isNil(arg_282_1.actors_["10155"]) then
				if arg_282_1.var_.actorSpriteComps10155 then
					for iter_285_0, iter_285_1 in pairs(arg_282_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_285_1 then
							if arg_282_1.isInRecall_ then
								iter_285_1.color = Color.New(Mathf.Lerp(iter_285_1.color.r, arg_282_1.hightColor1.r, (arg_282_1.time_ - 0) / var_285_0), Mathf.Lerp(iter_285_1.color.g, arg_282_1.hightColor1.g, (arg_282_1.time_ - 0) / var_285_0), (Mathf.Lerp(iter_285_1.color.b, arg_282_1.hightColor1.b, (arg_282_1.time_ - 0) / var_285_0)))
							else
								local var_285_1 = Mathf.Lerp(iter_285_1.color.r, 1, (arg_282_1.time_ - 0) / var_285_0)

								iter_285_1.color = Color.New(var_285_1, var_285_1, var_285_1)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 and not isNil(arg_282_1.actors_["10155"]) and arg_282_1.var_.actorSpriteComps10155 then
				for iter_285_2, iter_285_3 in pairs(arg_282_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_285_3 then
						iter_285_3.color = arg_282_1.isInRecall_ and (arg_282_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_282_1.var_.actorSpriteComps10155 = nil
			end

			local var_285_2 = arg_282_1.actors_["10155"].transform

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos10155 = var_285_2.localPosition
				var_285_2.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("10155", 2)

				for iter_285_4 = 0, var_285_2.childCount - 1 do
					local var_285_3 = var_285_2:GetChild(iter_285_4)

					if var_285_3.name == "split_1" then
						var_285_3:SetAsLastSibling()
						var_285_3.gameObject:SetActive(true)

						arg_282_1.var_.actorSpriteSplit10155 = var_285_3.gameObject:GetComponent(typeof(Image))

						arg_282_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_285_4 = 0.5

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_4 then
				var_285_2.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_282_1.time_ - 0) / var_285_4)

				if arg_282_1.var_.actorSpriteSplit10155 ~= nil then
					arg_282_1.var_.actorSpriteSplit10155:SetAlpha((arg_282_1.time_ - 0) / var_285_4)
				end
			end

			if arg_282_1.time_ >= 0 + var_285_4 and arg_282_1.time_ < 0 + var_285_4 + arg_285_0 then
				var_285_2.localPosition = Vector3.New(-410, -390, -250)

				if arg_282_1.var_.actorSpriteSplit10155 ~= nil then
					arg_282_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_285_5 = 0
			local var_285_6 = 0.55

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_5 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_7 = arg_282_1:GetWordFromCfg(424071067)
				local var_285_8 = arg_282_1:FormatText(var_285_7.content)

				arg_282_1.text_.text = var_285_8

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_10 = 22 <= 0 and var_285_6 or var_285_6 * (utf8.len(var_285_8) / 22)

				if (22 <= 0 and var_285_6 or var_285_6 * (utf8.len(var_285_8) / 22)) > 0 and var_285_6 < var_285_10 then
					arg_282_1.talkMaxDuration = var_285_10

					if var_285_10 + var_285_5 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_10 + var_285_5
					end
				end

				arg_282_1.text_.text = var_285_8
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071067", "story_v_out_424071.awb") ~= 0 then
					local var_285_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071067", "story_v_out_424071.awb") / 1000

					if var_285_11 + var_285_5 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_11 + var_285_5
					end

					if var_285_7.prefab_name ~= "" and arg_282_1.actors_[var_285_7.prefab_name] ~= nil then
						local var_285_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_7.prefab_name].transform, "story_v_out_424071", "424071067", "story_v_out_424071.awb")

						arg_282_1:RecordAudio("424071067", var_285_12)
						arg_282_1:RecordAudio("424071067", var_285_12)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_424071", "424071067", "story_v_out_424071.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_424071", "424071067", "story_v_out_424071.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_13 = math.max(var_285_6, arg_282_1.talkMaxDuration)

			if var_285_5 <= arg_282_1.time_ and arg_282_1.time_ < var_285_5 + var_285_13 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_5) / var_285_13

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_5 + var_285_13 and arg_282_1.time_ < var_285_5 + var_285_13 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play424071068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 424071068
		arg_286_1.duration_ = 2.2

		local var_286_0 = {
			zh = 1.5,
			ja = 2.2
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
				arg_286_0:Play424071069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(arg_286_1.actors_["1094"]) and arg_286_1.var_.actorSpriteComps1094 == nil then
				arg_286_1.var_.actorSpriteComps1094 = arg_286_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_0 = 0.2

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 and not isNil(arg_286_1.actors_["1094"]) then
				if arg_286_1.var_.actorSpriteComps1094 then
					for iter_289_0, iter_289_1 in pairs(arg_286_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_289_1 then
							if arg_286_1.isInRecall_ then
								iter_289_1.color = Color.New(Mathf.Lerp(iter_289_1.color.r, arg_286_1.hightColor1.r, (arg_286_1.time_ - 0) / var_289_0), Mathf.Lerp(iter_289_1.color.g, arg_286_1.hightColor1.g, (arg_286_1.time_ - 0) / var_289_0), (Mathf.Lerp(iter_289_1.color.b, arg_286_1.hightColor1.b, (arg_286_1.time_ - 0) / var_289_0)))
							else
								local var_289_1 = Mathf.Lerp(iter_289_1.color.r, 1, (arg_286_1.time_ - 0) / var_289_0)

								iter_289_1.color = Color.New(var_289_1, var_289_1, var_289_1)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 and not isNil(arg_286_1.actors_["1094"]) and arg_286_1.var_.actorSpriteComps1094 then
				for iter_289_2, iter_289_3 in pairs(arg_286_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_289_3 then
						iter_289_3.color = arg_286_1.isInRecall_ and (arg_286_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_286_1.var_.actorSpriteComps1094 = nil
			end

			local var_289_2 = arg_286_1.actors_["10155"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_2) and arg_286_1.var_.actorSpriteComps10155 == nil then
				arg_286_1.var_.actorSpriteComps10155 = var_289_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_3 = 0.2

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_3 and not isNil(var_289_2) then
				if arg_286_1.var_.actorSpriteComps10155 then
					for iter_289_4, iter_289_5 in pairs(arg_286_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_289_5 then
							if arg_286_1.isInRecall_ then
								iter_289_5.color = Color.New(Mathf.Lerp(iter_289_5.color.r, arg_286_1.hightColor2.r, (arg_286_1.time_ - 0) / var_289_3), Mathf.Lerp(iter_289_5.color.g, arg_286_1.hightColor2.g, (arg_286_1.time_ - 0) / var_289_3), (Mathf.Lerp(iter_289_5.color.b, arg_286_1.hightColor2.b, (arg_286_1.time_ - 0) / var_289_3)))
							else
								local var_289_4 = Mathf.Lerp(iter_289_5.color.r, 0.5, (arg_286_1.time_ - 0) / var_289_3)

								iter_289_5.color = Color.New(var_289_4, var_289_4, var_289_4)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= 0 + var_289_3 and arg_286_1.time_ < 0 + var_289_3 + arg_289_0 and not isNil(var_289_2) and arg_286_1.var_.actorSpriteComps10155 then
				for iter_289_6, iter_289_7 in pairs(arg_286_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_289_7 then
						iter_289_7.color = arg_286_1.isInRecall_ and (arg_286_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_286_1.var_.actorSpriteComps10155 = nil
			end

			local var_289_5 = arg_286_1.actors_["1094"].transform

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos1094 = var_289_5.localPosition
				var_289_5.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("1094", 4)

				for iter_289_8 = 0, var_289_5.childCount - 1 do
					local var_289_6 = var_289_5:GetChild(iter_289_8)

					if var_289_6.name == "" or not string.find(var_289_6.name, "split") then
						var_289_6.gameObject:SetActive(true)
					else
						var_289_6.gameObject:SetActive(false)
					end
				end
			end

			local var_289_7 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_7 then
				var_289_5.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_286_1.time_ - 0) / var_289_7)
			end

			if arg_286_1.time_ >= 0 + var_289_7 and arg_286_1.time_ < 0 + var_289_7 + arg_289_0 then
				var_289_5.localPosition = Vector3.New(470, -335, -230)
			end

			local var_289_8 = 0
			local var_289_9 = 0.125

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_8 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_10 = arg_286_1:GetWordFromCfg(424071068)
				local var_289_11 = arg_286_1:FormatText(var_289_10.content)

				arg_286_1.text_.text = var_289_11

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_13 = 5 <= 0 and var_289_9 or var_289_9 * (utf8.len(var_289_11) / 5)

				if (5 <= 0 and var_289_9 or var_289_9 * (utf8.len(var_289_11) / 5)) > 0 and var_289_9 < var_289_13 then
					arg_286_1.talkMaxDuration = var_289_13

					if var_289_13 + var_289_8 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_13 + var_289_8
					end
				end

				arg_286_1.text_.text = var_289_11
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071068", "story_v_out_424071.awb") ~= 0 then
					local var_289_14 = manager.audio:GetVoiceLength("story_v_out_424071", "424071068", "story_v_out_424071.awb") / 1000

					if var_289_14 + var_289_8 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_14 + var_289_8
					end

					if var_289_10.prefab_name ~= "" and arg_286_1.actors_[var_289_10.prefab_name] ~= nil then
						local var_289_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_10.prefab_name].transform, "story_v_out_424071", "424071068", "story_v_out_424071.awb")

						arg_286_1:RecordAudio("424071068", var_289_15)
						arg_286_1:RecordAudio("424071068", var_289_15)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_424071", "424071068", "story_v_out_424071.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_424071", "424071068", "story_v_out_424071.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_16 = math.max(var_289_9, arg_286_1.talkMaxDuration)

			if var_289_8 <= arg_286_1.time_ and arg_286_1.time_ < var_289_8 + var_289_16 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_8) / var_289_16

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_8 + var_289_16 and arg_286_1.time_ < var_289_8 + var_289_16 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play424071069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 424071069
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play424071070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["1094"]) and arg_290_1.var_.actorSpriteComps1094 == nil then
				arg_290_1.var_.actorSpriteComps1094 = arg_290_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_0 = 0.2

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["1094"]) then
				if arg_290_1.var_.actorSpriteComps1094 then
					for iter_293_0, iter_293_1 in pairs(arg_290_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_293_1 then
							if arg_290_1.isInRecall_ then
								iter_293_1.color = Color.New(Mathf.Lerp(iter_293_1.color.r, arg_290_1.hightColor2.r, (arg_290_1.time_ - 0) / var_293_0), Mathf.Lerp(iter_293_1.color.g, arg_290_1.hightColor2.g, (arg_290_1.time_ - 0) / var_293_0), (Mathf.Lerp(iter_293_1.color.b, arg_290_1.hightColor2.b, (arg_290_1.time_ - 0) / var_293_0)))
							else
								local var_293_1 = Mathf.Lerp(iter_293_1.color.r, 0.5, (arg_290_1.time_ - 0) / var_293_0)

								iter_293_1.color = Color.New(var_293_1, var_293_1, var_293_1)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["1094"]) and arg_290_1.var_.actorSpriteComps1094 then
				for iter_293_2, iter_293_3 in pairs(arg_290_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_293_3 then
						iter_293_3.color = arg_290_1.isInRecall_ and (arg_290_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_290_1.var_.actorSpriteComps1094 = nil
			end

			local var_293_2 = 0
			local var_293_3 = 1.3

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_2 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, true)
				arg_290_1.iconController_:SetSelectedState("hero")

				arg_290_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_290_1.callingController_:SetSelectedState("normal")

				arg_290_1.keyicon_.color = Color.New(1, 1, 1)
				arg_290_1.icon_.color = Color.New(1, 1, 1)

				local var_293_4 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(424071069).content)

				arg_290_1.text_.text = var_293_4

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_6 = 52 <= 0 and var_293_3 or var_293_3 * (utf8.len(var_293_4) / 52)

				if (52 <= 0 and var_293_3 or var_293_3 * (utf8.len(var_293_4) / 52)) > 0 and var_293_3 < var_293_6 then
					arg_290_1.talkMaxDuration = var_293_6

					if var_293_6 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_6 + var_293_2
					end
				end

				arg_290_1.text_.text = var_293_4
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_7 = math.max(var_293_3, arg_290_1.talkMaxDuration)

			if var_293_2 <= arg_290_1.time_ and arg_290_1.time_ < var_293_2 + var_293_7 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_2) / var_293_7

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_2 + var_293_7 and arg_290_1.time_ < var_293_2 + var_293_7 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play424071070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 424071070
		arg_294_1.duration_ = 4.73

		local var_294_0 = {
			zh = 3.066,
			ja = 4.733
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play424071071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = 0.325

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_1 = arg_294_1:GetWordFromCfg(424071070)
				local var_297_2 = arg_294_1:FormatText(var_297_1.content)

				arg_294_1.text_.text = var_297_2

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_4 = 13 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 13)

				if (13 <= 0 and var_297_0 or var_297_0 * (utf8.len(var_297_2) / 13)) > 0 and var_297_0 < var_297_4 then
					arg_294_1.talkMaxDuration = var_297_4

					if var_297_4 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_4 + 0
					end
				end

				arg_294_1.text_.text = var_297_2
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071070", "story_v_out_424071.awb") ~= 0 then
					local var_297_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071070", "story_v_out_424071.awb") / 1000

					if var_297_5 + 0 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + 0
					end

					if var_297_1.prefab_name ~= "" and arg_294_1.actors_[var_297_1.prefab_name] ~= nil then
						local var_297_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_1.prefab_name].transform, "story_v_out_424071", "424071070", "story_v_out_424071.awb")

						arg_294_1:RecordAudio("424071070", var_297_6)
						arg_294_1:RecordAudio("424071070", var_297_6)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_424071", "424071070", "story_v_out_424071.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_424071", "424071070", "story_v_out_424071.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_7 = math.max(var_297_0, arg_294_1.talkMaxDuration)

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_7 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - 0) / var_297_7

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= 0 + var_297_7 and arg_294_1.time_ < 0 + var_297_7 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play424071071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 424071071
		arg_298_1.duration_ = 6.63

		local var_298_0 = {
			zh = 2.033,
			ja = 6.633
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play424071072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(arg_298_1.actors_["10155"]) and arg_298_1.var_.actorSpriteComps10155 == nil then
				arg_298_1.var_.actorSpriteComps10155 = arg_298_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_0 = 0.2

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 and not isNil(arg_298_1.actors_["10155"]) then
				if arg_298_1.var_.actorSpriteComps10155 then
					for iter_301_0, iter_301_1 in pairs(arg_298_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_301_1 then
							if arg_298_1.isInRecall_ then
								iter_301_1.color = Color.New(Mathf.Lerp(iter_301_1.color.r, arg_298_1.hightColor1.r, (arg_298_1.time_ - 0) / var_301_0), Mathf.Lerp(iter_301_1.color.g, arg_298_1.hightColor1.g, (arg_298_1.time_ - 0) / var_301_0), (Mathf.Lerp(iter_301_1.color.b, arg_298_1.hightColor1.b, (arg_298_1.time_ - 0) / var_301_0)))
							else
								local var_301_1 = Mathf.Lerp(iter_301_1.color.r, 1, (arg_298_1.time_ - 0) / var_301_0)

								iter_301_1.color = Color.New(var_301_1, var_301_1, var_301_1)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 and not isNil(arg_298_1.actors_["10155"]) and arg_298_1.var_.actorSpriteComps10155 then
				for iter_301_2, iter_301_3 in pairs(arg_298_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_301_3 then
						iter_301_3.color = arg_298_1.isInRecall_ and (arg_298_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_298_1.var_.actorSpriteComps10155 = nil
			end

			local var_301_2 = arg_298_1.actors_["10155"].transform

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos10155 = var_301_2.localPosition
				var_301_2.localScale = Vector3.New(1, 1, 1)

				arg_298_1:CheckSpriteTmpPos("10155", 2)

				for iter_301_4 = 0, var_301_2.childCount - 1 do
					local var_301_3 = var_301_2:GetChild(iter_301_4)

					if var_301_3.name == "split_4" then
						var_301_3:SetAsLastSibling()
						var_301_3.gameObject:SetActive(true)

						arg_298_1.var_.actorSpriteSplit10155 = var_301_3.gameObject:GetComponent(typeof(Image))

						arg_298_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_301_4 = 0.5

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 then
				var_301_2.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_298_1.time_ - 0) / var_301_4)

				if arg_298_1.var_.actorSpriteSplit10155 ~= nil then
					arg_298_1.var_.actorSpriteSplit10155:SetAlpha((arg_298_1.time_ - 0) / var_301_4)
				end
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 then
				var_301_2.localPosition = Vector3.New(-410, -390, -250)

				if arg_298_1.var_.actorSpriteSplit10155 ~= nil then
					arg_298_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_301_5 = 0
			local var_301_6 = 0.325

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_5 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_7 = arg_298_1:GetWordFromCfg(424071071)
				local var_301_8 = arg_298_1:FormatText(var_301_7.content)

				arg_298_1.text_.text = var_301_8

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_10 = 13 <= 0 and var_301_6 or var_301_6 * (utf8.len(var_301_8) / 13)

				if (13 <= 0 and var_301_6 or var_301_6 * (utf8.len(var_301_8) / 13)) > 0 and var_301_6 < var_301_10 then
					arg_298_1.talkMaxDuration = var_301_10

					if var_301_10 + var_301_5 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_10 + var_301_5
					end
				end

				arg_298_1.text_.text = var_301_8
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071071", "story_v_out_424071.awb") ~= 0 then
					local var_301_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071071", "story_v_out_424071.awb") / 1000

					if var_301_11 + var_301_5 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_11 + var_301_5
					end

					if var_301_7.prefab_name ~= "" and arg_298_1.actors_[var_301_7.prefab_name] ~= nil then
						local var_301_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_7.prefab_name].transform, "story_v_out_424071", "424071071", "story_v_out_424071.awb")

						arg_298_1:RecordAudio("424071071", var_301_12)
						arg_298_1:RecordAudio("424071071", var_301_12)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_424071", "424071071", "story_v_out_424071.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_424071", "424071071", "story_v_out_424071.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_13 = math.max(var_301_6, arg_298_1.talkMaxDuration)

			if var_301_5 <= arg_298_1.time_ and arg_298_1.time_ < var_301_5 + var_301_13 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_5) / var_301_13

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_5 + var_301_13 and arg_298_1.time_ < var_301_5 + var_301_13 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play424071072 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 424071072
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play424071073(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(arg_302_1.actors_["10155"]) and arg_302_1.var_.actorSpriteComps10155 == nil then
				arg_302_1.var_.actorSpriteComps10155 = arg_302_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_0 = 0.2

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 and not isNil(arg_302_1.actors_["10155"]) then
				if arg_302_1.var_.actorSpriteComps10155 then
					for iter_305_0, iter_305_1 in pairs(arg_302_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_305_1 then
							if arg_302_1.isInRecall_ then
								iter_305_1.color = Color.New(Mathf.Lerp(iter_305_1.color.r, arg_302_1.hightColor2.r, (arg_302_1.time_ - 0) / var_305_0), Mathf.Lerp(iter_305_1.color.g, arg_302_1.hightColor2.g, (arg_302_1.time_ - 0) / var_305_0), (Mathf.Lerp(iter_305_1.color.b, arg_302_1.hightColor2.b, (arg_302_1.time_ - 0) / var_305_0)))
							else
								local var_305_1 = Mathf.Lerp(iter_305_1.color.r, 0.5, (arg_302_1.time_ - 0) / var_305_0)

								iter_305_1.color = Color.New(var_305_1, var_305_1, var_305_1)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 and not isNil(arg_302_1.actors_["10155"]) and arg_302_1.var_.actorSpriteComps10155 then
				for iter_305_2, iter_305_3 in pairs(arg_302_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_305_3 then
						iter_305_3.color = arg_302_1.isInRecall_ and (arg_302_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_302_1.var_.actorSpriteComps10155 = nil
			end

			local var_305_2 = 0
			local var_305_3 = 0.95

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_2 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_4 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(424071072).content)

				arg_302_1.text_.text = var_305_4

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_6 = 38 <= 0 and var_305_3 or var_305_3 * (utf8.len(var_305_4) / 38)

				if (38 <= 0 and var_305_3 or var_305_3 * (utf8.len(var_305_4) / 38)) > 0 and var_305_3 < var_305_6 then
					arg_302_1.talkMaxDuration = var_305_6

					if var_305_6 + var_305_2 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_6 + var_305_2
					end
				end

				arg_302_1.text_.text = var_305_4
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_7 = math.max(var_305_3, arg_302_1.talkMaxDuration)

			if var_305_2 <= arg_302_1.time_ and arg_302_1.time_ < var_305_2 + var_305_7 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_2) / var_305_7

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_2 + var_305_7 and arg_302_1.time_ < var_305_2 + var_305_7 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play424071073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 424071073
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play424071074(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 1.225

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_1 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(424071073).content)

				arg_306_1.text_.text = var_309_1

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_3 = 49 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_1) / 49)

				if (49 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_1) / 49)) > 0 and var_309_0 < var_309_3 then
					arg_306_1.talkMaxDuration = var_309_3

					if var_309_3 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_3 + 0
					end
				end

				arg_306_1.text_.text = var_309_1
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_4 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_4 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_4

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_4 and arg_306_1.time_ < 0 + var_309_4 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play424071074 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 424071074
		arg_310_1.duration_ = 10.2

		local var_310_0 = {
			zh = 5.966,
			ja = 10.2
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play424071075(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["10155"]) and arg_310_1.var_.actorSpriteComps10155 == nil then
				arg_310_1.var_.actorSpriteComps10155 = arg_310_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_0 = 0.2

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["10155"]) then
				if arg_310_1.var_.actorSpriteComps10155 then
					for iter_313_0, iter_313_1 in pairs(arg_310_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_313_1 then
							if arg_310_1.isInRecall_ then
								iter_313_1.color = Color.New(Mathf.Lerp(iter_313_1.color.r, arg_310_1.hightColor1.r, (arg_310_1.time_ - 0) / var_313_0), Mathf.Lerp(iter_313_1.color.g, arg_310_1.hightColor1.g, (arg_310_1.time_ - 0) / var_313_0), (Mathf.Lerp(iter_313_1.color.b, arg_310_1.hightColor1.b, (arg_310_1.time_ - 0) / var_313_0)))
							else
								local var_313_1 = Mathf.Lerp(iter_313_1.color.r, 1, (arg_310_1.time_ - 0) / var_313_0)

								iter_313_1.color = Color.New(var_313_1, var_313_1, var_313_1)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["10155"]) and arg_310_1.var_.actorSpriteComps10155 then
				for iter_313_2, iter_313_3 in pairs(arg_310_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_313_3 then
						iter_313_3.color = arg_310_1.isInRecall_ and (arg_310_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_310_1.var_.actorSpriteComps10155 = nil
			end

			local var_313_2 = arg_310_1.actors_["10155"].transform

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.moveOldPos10155 = var_313_2.localPosition
				var_313_2.localScale = Vector3.New(1, 1, 1)

				arg_310_1:CheckSpriteTmpPos("10155", 2)

				for iter_313_4 = 0, var_313_2.childCount - 1 do
					local var_313_3 = var_313_2:GetChild(iter_313_4)

					if var_313_3.name == "split_3" then
						var_313_3:SetAsLastSibling()
						var_313_3.gameObject:SetActive(true)

						arg_310_1.var_.actorSpriteSplit10155 = var_313_3.gameObject:GetComponent(typeof(Image))

						arg_310_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_313_4 = 0.5

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_4 then
				var_313_2.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_310_1.time_ - 0) / var_313_4)

				if arg_310_1.var_.actorSpriteSplit10155 ~= nil then
					arg_310_1.var_.actorSpriteSplit10155:SetAlpha((arg_310_1.time_ - 0) / var_313_4)
				end
			end

			if arg_310_1.time_ >= 0 + var_313_4 and arg_310_1.time_ < 0 + var_313_4 + arg_313_0 then
				var_313_2.localPosition = Vector3.New(-410, -390, -250)

				if arg_310_1.var_.actorSpriteSplit10155 ~= nil then
					arg_310_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_313_5 = 0
			local var_313_6 = 0.725

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_5 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_7 = arg_310_1:GetWordFromCfg(424071074)
				local var_313_8 = arg_310_1:FormatText(var_313_7.content)

				arg_310_1.text_.text = var_313_8

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_10 = 29 <= 0 and var_313_6 or var_313_6 * (utf8.len(var_313_8) / 29)

				if (29 <= 0 and var_313_6 or var_313_6 * (utf8.len(var_313_8) / 29)) > 0 and var_313_6 < var_313_10 then
					arg_310_1.talkMaxDuration = var_313_10

					if var_313_10 + var_313_5 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_10 + var_313_5
					end
				end

				arg_310_1.text_.text = var_313_8
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071074", "story_v_out_424071.awb") ~= 0 then
					local var_313_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071074", "story_v_out_424071.awb") / 1000

					if var_313_11 + var_313_5 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_11 + var_313_5
					end

					if var_313_7.prefab_name ~= "" and arg_310_1.actors_[var_313_7.prefab_name] ~= nil then
						local var_313_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_7.prefab_name].transform, "story_v_out_424071", "424071074", "story_v_out_424071.awb")

						arg_310_1:RecordAudio("424071074", var_313_12)
						arg_310_1:RecordAudio("424071074", var_313_12)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_424071", "424071074", "story_v_out_424071.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_424071", "424071074", "story_v_out_424071.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_13 = math.max(var_313_6, arg_310_1.talkMaxDuration)

			if var_313_5 <= arg_310_1.time_ and arg_310_1.time_ < var_313_5 + var_313_13 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_5) / var_313_13

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_5 + var_313_13 and arg_310_1.time_ < var_313_5 + var_313_13 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_310_1:InitPlayNodeList()
	end,
	Play424071075 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 424071075
		arg_314_1.duration_ = 5

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play424071076(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["10155"]) and arg_314_1.var_.actorSpriteComps10155 == nil then
				arg_314_1.var_.actorSpriteComps10155 = arg_314_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_0 = 0.2

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["10155"]) then
				if arg_314_1.var_.actorSpriteComps10155 then
					for iter_317_0, iter_317_1 in pairs(arg_314_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_317_1 then
							if arg_314_1.isInRecall_ then
								iter_317_1.color = Color.New(Mathf.Lerp(iter_317_1.color.r, arg_314_1.hightColor2.r, (arg_314_1.time_ - 0) / var_317_0), Mathf.Lerp(iter_317_1.color.g, arg_314_1.hightColor2.g, (arg_314_1.time_ - 0) / var_317_0), (Mathf.Lerp(iter_317_1.color.b, arg_314_1.hightColor2.b, (arg_314_1.time_ - 0) / var_317_0)))
							else
								local var_317_1 = Mathf.Lerp(iter_317_1.color.r, 0.5, (arg_314_1.time_ - 0) / var_317_0)

								iter_317_1.color = Color.New(var_317_1, var_317_1, var_317_1)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["10155"]) and arg_314_1.var_.actorSpriteComps10155 then
				for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_317_3 then
						iter_317_3.color = arg_314_1.isInRecall_ and (arg_314_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_314_1.var_.actorSpriteComps10155 = nil
			end

			local var_317_2 = 0
			local var_317_3 = 1.425

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_2 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_4 = arg_314_1:FormatText(arg_314_1:GetWordFromCfg(424071075).content)

				arg_314_1.text_.text = var_317_4

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_6 = 57 <= 0 and var_317_3 or var_317_3 * (utf8.len(var_317_4) / 57)

				if (57 <= 0 and var_317_3 or var_317_3 * (utf8.len(var_317_4) / 57)) > 0 and var_317_3 < var_317_6 then
					arg_314_1.talkMaxDuration = var_317_6

					if var_317_6 + var_317_2 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_6 + var_317_2
					end
				end

				arg_314_1.text_.text = var_317_4
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)
				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_7 = math.max(var_317_3, arg_314_1.talkMaxDuration)

			if var_317_2 <= arg_314_1.time_ and arg_314_1.time_ < var_317_2 + var_317_7 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_2) / var_317_7

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_2 + var_317_7 and arg_314_1.time_ < var_317_2 + var_317_7 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play424071076 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 424071076
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play424071077(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 1.5

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, true)
				arg_318_1.iconController_:SetSelectedState("hero")

				arg_318_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_318_1.callingController_:SetSelectedState("normal")

				arg_318_1.keyicon_.color = Color.New(1, 1, 1)
				arg_318_1.icon_.color = Color.New(1, 1, 1)

				local var_321_1 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(424071076).content)

				arg_318_1.text_.text = var_321_1

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_3 = 60 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 60)

				if (60 <= 0 and var_321_0 or var_321_0 * (utf8.len(var_321_1) / 60)) > 0 and var_321_0 < var_321_3 then
					arg_318_1.talkMaxDuration = var_321_3

					if var_321_3 + 0 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_3 + 0
					end
				end

				arg_318_1.text_.text = var_321_1
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_4 = math.max(var_321_0, arg_318_1.talkMaxDuration)

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_4 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - 0) / var_321_4

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= 0 + var_321_4 and arg_318_1.time_ < 0 + var_321_4 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play424071077 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 424071077
		arg_322_1.duration_ = 12.77

		local var_322_0 = {
			zh = 6.033,
			ja = 12.766
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
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play424071078(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["10155"]) and arg_322_1.var_.actorSpriteComps10155 == nil then
				arg_322_1.var_.actorSpriteComps10155 = arg_322_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_325_0 = 0.2

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["10155"]) then
				if arg_322_1.var_.actorSpriteComps10155 then
					for iter_325_0, iter_325_1 in pairs(arg_322_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_325_1 then
							if arg_322_1.isInRecall_ then
								iter_325_1.color = Color.New(Mathf.Lerp(iter_325_1.color.r, arg_322_1.hightColor1.r, (arg_322_1.time_ - 0) / var_325_0), Mathf.Lerp(iter_325_1.color.g, arg_322_1.hightColor1.g, (arg_322_1.time_ - 0) / var_325_0), (Mathf.Lerp(iter_325_1.color.b, arg_322_1.hightColor1.b, (arg_322_1.time_ - 0) / var_325_0)))
							else
								local var_325_1 = Mathf.Lerp(iter_325_1.color.r, 1, (arg_322_1.time_ - 0) / var_325_0)

								iter_325_1.color = Color.New(var_325_1, var_325_1, var_325_1)
							end
						end
					end
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["10155"]) and arg_322_1.var_.actorSpriteComps10155 then
				for iter_325_2, iter_325_3 in pairs(arg_322_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_325_3 then
						iter_325_3.color = arg_322_1.isInRecall_ and (arg_322_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_322_1.var_.actorSpriteComps10155 = nil
			end

			local var_325_2 = arg_322_1.actors_["10155"].transform

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.var_.moveOldPos10155 = var_325_2.localPosition
				var_325_2.localScale = Vector3.New(1, 1, 1)

				arg_322_1:CheckSpriteTmpPos("10155", 2)

				for iter_325_4 = 0, var_325_2.childCount - 1 do
					local var_325_3 = var_325_2:GetChild(iter_325_4)

					if var_325_3.name == "split_4" then
						var_325_3:SetAsLastSibling()
						var_325_3.gameObject:SetActive(true)

						arg_322_1.var_.actorSpriteSplit10155 = var_325_3.gameObject:GetComponent(typeof(Image))

						arg_322_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_325_4 = 0.5

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_4 then
				var_325_2.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_322_1.time_ - 0) / var_325_4)

				if arg_322_1.var_.actorSpriteSplit10155 ~= nil then
					arg_322_1.var_.actorSpriteSplit10155:SetAlpha((arg_322_1.time_ - 0) / var_325_4)
				end
			end

			if arg_322_1.time_ >= 0 + var_325_4 and arg_322_1.time_ < 0 + var_325_4 + arg_325_0 then
				var_325_2.localPosition = Vector3.New(-410, -390, -250)

				if arg_322_1.var_.actorSpriteSplit10155 ~= nil then
					arg_322_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_325_5 = 0
			local var_325_6 = 0.65

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_5 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				arg_322_1.leftNameTxt_.text = arg_322_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_7 = arg_322_1:GetWordFromCfg(424071077)
				local var_325_8 = arg_322_1:FormatText(var_325_7.content)

				arg_322_1.text_.text = var_325_8

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_10 = 26 <= 0 and var_325_6 or var_325_6 * (utf8.len(var_325_8) / 26)

				if (26 <= 0 and var_325_6 or var_325_6 * (utf8.len(var_325_8) / 26)) > 0 and var_325_6 < var_325_10 then
					arg_322_1.talkMaxDuration = var_325_10

					if var_325_10 + var_325_5 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_10 + var_325_5
					end
				end

				arg_322_1.text_.text = var_325_8
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071077", "story_v_out_424071.awb") ~= 0 then
					local var_325_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071077", "story_v_out_424071.awb") / 1000

					if var_325_11 + var_325_5 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_11 + var_325_5
					end

					if var_325_7.prefab_name ~= "" and arg_322_1.actors_[var_325_7.prefab_name] ~= nil then
						local var_325_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_7.prefab_name].transform, "story_v_out_424071", "424071077", "story_v_out_424071.awb")

						arg_322_1:RecordAudio("424071077", var_325_12)
						arg_322_1:RecordAudio("424071077", var_325_12)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_424071", "424071077", "story_v_out_424071.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_424071", "424071077", "story_v_out_424071.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_13 = math.max(var_325_6, arg_322_1.talkMaxDuration)

			if var_325_5 <= arg_322_1.time_ and arg_322_1.time_ < var_325_5 + var_325_13 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_5) / var_325_13

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_5 + var_325_13 and arg_322_1.time_ < var_325_5 + var_325_13 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play424071078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 424071078
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play424071079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 and not isNil(arg_326_1.actors_["10155"]) and arg_326_1.var_.actorSpriteComps10155 == nil then
				arg_326_1.var_.actorSpriteComps10155 = arg_326_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_329_0 = 0.2

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_0 and not isNil(arg_326_1.actors_["10155"]) then
				if arg_326_1.var_.actorSpriteComps10155 then
					for iter_329_0, iter_329_1 in pairs(arg_326_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_329_1 then
							if arg_326_1.isInRecall_ then
								iter_329_1.color = Color.New(Mathf.Lerp(iter_329_1.color.r, arg_326_1.hightColor2.r, (arg_326_1.time_ - 0) / var_329_0), Mathf.Lerp(iter_329_1.color.g, arg_326_1.hightColor2.g, (arg_326_1.time_ - 0) / var_329_0), (Mathf.Lerp(iter_329_1.color.b, arg_326_1.hightColor2.b, (arg_326_1.time_ - 0) / var_329_0)))
							else
								local var_329_1 = Mathf.Lerp(iter_329_1.color.r, 0.5, (arg_326_1.time_ - 0) / var_329_0)

								iter_329_1.color = Color.New(var_329_1, var_329_1, var_329_1)
							end
						end
					end
				end
			end

			if arg_326_1.time_ >= 0 + var_329_0 and arg_326_1.time_ < 0 + var_329_0 + arg_329_0 and not isNil(arg_326_1.actors_["10155"]) and arg_326_1.var_.actorSpriteComps10155 then
				for iter_329_2, iter_329_3 in pairs(arg_326_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_329_3 then
						iter_329_3.color = arg_326_1.isInRecall_ and (arg_326_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_326_1.var_.actorSpriteComps10155 = nil
			end

			local var_329_2 = 0
			local var_329_3 = 1.275

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= var_329_2 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				arg_326_1.leftNameTxt_.text = arg_326_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, true)
				arg_326_1.iconController_:SetSelectedState("hero")

				arg_326_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_326_1.callingController_:SetSelectedState("normal")

				arg_326_1.keyicon_.color = Color.New(1, 1, 1)
				arg_326_1.icon_.color = Color.New(1, 1, 1)

				local var_329_4 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(424071078).content)

				arg_326_1.text_.text = var_329_4

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_6 = 51 <= 0 and var_329_3 or var_329_3 * (utf8.len(var_329_4) / 51)

				if (51 <= 0 and var_329_3 or var_329_3 * (utf8.len(var_329_4) / 51)) > 0 and var_329_3 < var_329_6 then
					arg_326_1.talkMaxDuration = var_329_6

					if var_329_6 + var_329_2 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_6 + var_329_2
					end
				end

				arg_326_1.text_.text = var_329_4
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_7 = math.max(var_329_3, arg_326_1.talkMaxDuration)

			if var_329_2 <= arg_326_1.time_ and arg_326_1.time_ < var_329_2 + var_329_7 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_2) / var_329_7

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_2 + var_329_7 and arg_326_1.time_ < var_329_2 + var_329_7 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play424071079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 424071079
		arg_330_1.duration_ = 10.6

		local var_330_0 = {
			zh = 9,
			ja = 10.6
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play424071080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["10155"]) and arg_330_1.var_.actorSpriteComps10155 == nil then
				arg_330_1.var_.actorSpriteComps10155 = arg_330_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_0 = 0.2

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["10155"]) then
				if arg_330_1.var_.actorSpriteComps10155 then
					for iter_333_0, iter_333_1 in pairs(arg_330_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_333_1 then
							if arg_330_1.isInRecall_ then
								iter_333_1.color = Color.New(Mathf.Lerp(iter_333_1.color.r, arg_330_1.hightColor1.r, (arg_330_1.time_ - 0) / var_333_0), Mathf.Lerp(iter_333_1.color.g, arg_330_1.hightColor1.g, (arg_330_1.time_ - 0) / var_333_0), (Mathf.Lerp(iter_333_1.color.b, arg_330_1.hightColor1.b, (arg_330_1.time_ - 0) / var_333_0)))
							else
								local var_333_1 = Mathf.Lerp(iter_333_1.color.r, 1, (arg_330_1.time_ - 0) / var_333_0)

								iter_333_1.color = Color.New(var_333_1, var_333_1, var_333_1)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["10155"]) and arg_330_1.var_.actorSpriteComps10155 then
				for iter_333_2, iter_333_3 in pairs(arg_330_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_333_3 then
						iter_333_3.color = arg_330_1.isInRecall_ and (arg_330_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_330_1.var_.actorSpriteComps10155 = nil
			end

			local var_333_2 = arg_330_1.actors_["10155"].transform

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.var_.moveOldPos10155 = var_333_2.localPosition
				var_333_2.localScale = Vector3.New(1, 1, 1)

				arg_330_1:CheckSpriteTmpPos("10155", 2)

				for iter_333_4 = 0, var_333_2.childCount - 1 do
					local var_333_3 = var_333_2:GetChild(iter_333_4)

					if var_333_3.name == "split_1" then
						var_333_3:SetAsLastSibling()
						var_333_3.gameObject:SetActive(true)

						arg_330_1.var_.actorSpriteSplit10155 = var_333_3.gameObject:GetComponent(typeof(Image))

						arg_330_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_333_4 = 0.5

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_4 then
				var_333_2.localPosition = Vector3.Lerp(arg_330_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_330_1.time_ - 0) / var_333_4)

				if arg_330_1.var_.actorSpriteSplit10155 ~= nil then
					arg_330_1.var_.actorSpriteSplit10155:SetAlpha((arg_330_1.time_ - 0) / var_333_4)
				end
			end

			if arg_330_1.time_ >= 0 + var_333_4 and arg_330_1.time_ < 0 + var_333_4 + arg_333_0 then
				var_333_2.localPosition = Vector3.New(-410, -390, -250)

				if arg_330_1.var_.actorSpriteSplit10155 ~= nil then
					arg_330_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_333_5 = 0
			local var_333_6 = 0.775

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_5 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_7 = arg_330_1:GetWordFromCfg(424071079)
				local var_333_8 = arg_330_1:FormatText(var_333_7.content)

				arg_330_1.text_.text = var_333_8

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_10 = 31 <= 0 and var_333_6 or var_333_6 * (utf8.len(var_333_8) / 31)

				if (31 <= 0 and var_333_6 or var_333_6 * (utf8.len(var_333_8) / 31)) > 0 and var_333_6 < var_333_10 then
					arg_330_1.talkMaxDuration = var_333_10

					if var_333_10 + var_333_5 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_10 + var_333_5
					end
				end

				arg_330_1.text_.text = var_333_8
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071079", "story_v_out_424071.awb") ~= 0 then
					local var_333_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071079", "story_v_out_424071.awb") / 1000

					if var_333_11 + var_333_5 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_11 + var_333_5
					end

					if var_333_7.prefab_name ~= "" and arg_330_1.actors_[var_333_7.prefab_name] ~= nil then
						local var_333_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_7.prefab_name].transform, "story_v_out_424071", "424071079", "story_v_out_424071.awb")

						arg_330_1:RecordAudio("424071079", var_333_12)
						arg_330_1:RecordAudio("424071079", var_333_12)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_424071", "424071079", "story_v_out_424071.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_424071", "424071079", "story_v_out_424071.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_13 = math.max(var_333_6, arg_330_1.talkMaxDuration)

			if var_333_5 <= arg_330_1.time_ and arg_330_1.time_ < var_333_5 + var_333_13 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_5) / var_333_13

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_5 + var_333_13 and arg_330_1.time_ < var_333_5 + var_333_13 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_330_1:InitPlayNodeList()
	end,
	Play424071080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 424071080
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play424071081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["10155"]) and arg_334_1.var_.actorSpriteComps10155 == nil then
				arg_334_1.var_.actorSpriteComps10155 = arg_334_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_0 = 0.2

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["10155"]) then
				if arg_334_1.var_.actorSpriteComps10155 then
					for iter_337_0, iter_337_1 in pairs(arg_334_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_337_1 then
							if arg_334_1.isInRecall_ then
								iter_337_1.color = Color.New(Mathf.Lerp(iter_337_1.color.r, arg_334_1.hightColor2.r, (arg_334_1.time_ - 0) / var_337_0), Mathf.Lerp(iter_337_1.color.g, arg_334_1.hightColor2.g, (arg_334_1.time_ - 0) / var_337_0), (Mathf.Lerp(iter_337_1.color.b, arg_334_1.hightColor2.b, (arg_334_1.time_ - 0) / var_337_0)))
							else
								local var_337_1 = Mathf.Lerp(iter_337_1.color.r, 0.5, (arg_334_1.time_ - 0) / var_337_0)

								iter_337_1.color = Color.New(var_337_1, var_337_1, var_337_1)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["10155"]) and arg_334_1.var_.actorSpriteComps10155 then
				for iter_337_2, iter_337_3 in pairs(arg_334_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_337_3 then
						iter_337_3.color = arg_334_1.isInRecall_ and (arg_334_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_334_1.var_.actorSpriteComps10155 = nil
			end

			local var_337_2 = 0
			local var_337_3 = 0.825

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_2 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, true)
				arg_334_1.iconController_:SetSelectedState("hero")

				arg_334_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_334_1.callingController_:SetSelectedState("normal")

				arg_334_1.keyicon_.color = Color.New(1, 1, 1)
				arg_334_1.icon_.color = Color.New(1, 1, 1)

				local var_337_4 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(424071080).content)

				arg_334_1.text_.text = var_337_4

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_6 = 33 <= 0 and var_337_3 or var_337_3 * (utf8.len(var_337_4) / 33)

				if (33 <= 0 and var_337_3 or var_337_3 * (utf8.len(var_337_4) / 33)) > 0 and var_337_3 < var_337_6 then
					arg_334_1.talkMaxDuration = var_337_6

					if var_337_6 + var_337_2 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_6 + var_337_2
					end
				end

				arg_334_1.text_.text = var_337_4
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_7 = math.max(var_337_3, arg_334_1.talkMaxDuration)

			if var_337_2 <= arg_334_1.time_ and arg_334_1.time_ < var_337_2 + var_337_7 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_2) / var_337_7

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_2 + var_337_7 and arg_334_1.time_ < var_337_2 + var_337_7 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play424071081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 424071081
		arg_338_1.duration_ = 4.6

		local var_338_0 = {
			zh = 3.3,
			ja = 4.6
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play424071082(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["1094"]) and arg_338_1.var_.actorSpriteComps1094 == nil then
				arg_338_1.var_.actorSpriteComps1094 = arg_338_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_0 = 0.2

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["1094"]) then
				if arg_338_1.var_.actorSpriteComps1094 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_341_1 then
							if arg_338_1.isInRecall_ then
								iter_341_1.color = Color.New(Mathf.Lerp(iter_341_1.color.r, arg_338_1.hightColor1.r, (arg_338_1.time_ - 0) / var_341_0), Mathf.Lerp(iter_341_1.color.g, arg_338_1.hightColor1.g, (arg_338_1.time_ - 0) / var_341_0), (Mathf.Lerp(iter_341_1.color.b, arg_338_1.hightColor1.b, (arg_338_1.time_ - 0) / var_341_0)))
							else
								local var_341_1 = Mathf.Lerp(iter_341_1.color.r, 1, (arg_338_1.time_ - 0) / var_341_0)

								iter_341_1.color = Color.New(var_341_1, var_341_1, var_341_1)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["1094"]) and arg_338_1.var_.actorSpriteComps1094 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_341_3 then
						iter_341_3.color = arg_338_1.isInRecall_ and (arg_338_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_338_1.var_.actorSpriteComps1094 = nil
			end

			local var_341_2 = arg_338_1.actors_["1094"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos1094 = var_341_2.localPosition
				var_341_2.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("1094", 4)

				for iter_341_4 = 0, var_341_2.childCount - 1 do
					local var_341_3 = var_341_2:GetChild(iter_341_4)

					if var_341_3.name == "" or not string.find(var_341_3.name, "split") then
						var_341_3.gameObject:SetActive(true)
					else
						var_341_3.gameObject:SetActive(false)
					end
				end
			end

			local var_341_4 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_4 then
				var_341_2.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_338_1.time_ - 0) / var_341_4)
			end

			if arg_338_1.time_ >= 0 + var_341_4 and arg_338_1.time_ < 0 + var_341_4 + arg_341_0 then
				var_341_2.localPosition = Vector3.New(470, -335, -230)
			end

			local var_341_5 = 0
			local var_341_6 = 0.4

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_5 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_7 = arg_338_1:GetWordFromCfg(424071081)
				local var_341_8 = arg_338_1:FormatText(var_341_7.content)

				arg_338_1.text_.text = var_341_8

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_10 = 16 <= 0 and var_341_6 or var_341_6 * (utf8.len(var_341_8) / 16)

				if (16 <= 0 and var_341_6 or var_341_6 * (utf8.len(var_341_8) / 16)) > 0 and var_341_6 < var_341_10 then
					arg_338_1.talkMaxDuration = var_341_10

					if var_341_10 + var_341_5 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_10 + var_341_5
					end
				end

				arg_338_1.text_.text = var_341_8
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071081", "story_v_out_424071.awb") ~= 0 then
					local var_341_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071081", "story_v_out_424071.awb") / 1000

					if var_341_11 + var_341_5 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_11 + var_341_5
					end

					if var_341_7.prefab_name ~= "" and arg_338_1.actors_[var_341_7.prefab_name] ~= nil then
						local var_341_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_7.prefab_name].transform, "story_v_out_424071", "424071081", "story_v_out_424071.awb")

						arg_338_1:RecordAudio("424071081", var_341_12)
						arg_338_1:RecordAudio("424071081", var_341_12)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_424071", "424071081", "story_v_out_424071.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_424071", "424071081", "story_v_out_424071.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_13 = math.max(var_341_6, arg_338_1.talkMaxDuration)

			if var_341_5 <= arg_338_1.time_ and arg_338_1.time_ < var_341_5 + var_341_13 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_5) / var_341_13

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_5 + var_341_13 and arg_338_1.time_ < var_341_5 + var_341_13 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play424071082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 424071082
		arg_342_1.duration_ = 6.93

		local var_342_0 = {
			zh = 3.633,
			ja = 6.933
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play424071083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["10155"]) and arg_342_1.var_.actorSpriteComps10155 == nil then
				arg_342_1.var_.actorSpriteComps10155 = arg_342_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_0 = 0.2

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["10155"]) then
				if arg_342_1.var_.actorSpriteComps10155 then
					for iter_345_0, iter_345_1 in pairs(arg_342_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_345_1 then
							if arg_342_1.isInRecall_ then
								iter_345_1.color = Color.New(Mathf.Lerp(iter_345_1.color.r, arg_342_1.hightColor1.r, (arg_342_1.time_ - 0) / var_345_0), Mathf.Lerp(iter_345_1.color.g, arg_342_1.hightColor1.g, (arg_342_1.time_ - 0) / var_345_0), (Mathf.Lerp(iter_345_1.color.b, arg_342_1.hightColor1.b, (arg_342_1.time_ - 0) / var_345_0)))
							else
								local var_345_1 = Mathf.Lerp(iter_345_1.color.r, 1, (arg_342_1.time_ - 0) / var_345_0)

								iter_345_1.color = Color.New(var_345_1, var_345_1, var_345_1)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["10155"]) and arg_342_1.var_.actorSpriteComps10155 then
				for iter_345_2, iter_345_3 in pairs(arg_342_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_345_3 then
						iter_345_3.color = arg_342_1.isInRecall_ and (arg_342_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_342_1.var_.actorSpriteComps10155 = nil
			end

			local var_345_2 = arg_342_1.actors_["1094"]

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(var_345_2) and arg_342_1.var_.actorSpriteComps1094 == nil then
				arg_342_1.var_.actorSpriteComps1094 = var_345_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_3 = 0.2

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_3 and not isNil(var_345_2) then
				if arg_342_1.var_.actorSpriteComps1094 then
					for iter_345_4, iter_345_5 in pairs(arg_342_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_345_5 then
							if arg_342_1.isInRecall_ then
								iter_345_5.color = Color.New(Mathf.Lerp(iter_345_5.color.r, arg_342_1.hightColor2.r, (arg_342_1.time_ - 0) / var_345_3), Mathf.Lerp(iter_345_5.color.g, arg_342_1.hightColor2.g, (arg_342_1.time_ - 0) / var_345_3), (Mathf.Lerp(iter_345_5.color.b, arg_342_1.hightColor2.b, (arg_342_1.time_ - 0) / var_345_3)))
							else
								local var_345_4 = Mathf.Lerp(iter_345_5.color.r, 0.5, (arg_342_1.time_ - 0) / var_345_3)

								iter_345_5.color = Color.New(var_345_4, var_345_4, var_345_4)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= 0 + var_345_3 and arg_342_1.time_ < 0 + var_345_3 + arg_345_0 and not isNil(var_345_2) and arg_342_1.var_.actorSpriteComps1094 then
				for iter_345_6, iter_345_7 in pairs(arg_342_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_345_7 then
						iter_345_7.color = arg_342_1.isInRecall_ and (arg_342_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_342_1.var_.actorSpriteComps1094 = nil
			end

			local var_345_5 = arg_342_1.actors_["10155"].transform

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos10155 = var_345_5.localPosition
				var_345_5.localScale = Vector3.New(1, 1, 1)

				arg_342_1:CheckSpriteTmpPos("10155", 2)

				for iter_345_8 = 0, var_345_5.childCount - 1 do
					local var_345_6 = var_345_5:GetChild(iter_345_8)

					if var_345_6.name == "split_2" then
						var_345_6:SetAsLastSibling()
						var_345_6.gameObject:SetActive(true)

						arg_342_1.var_.actorSpriteSplit10155 = var_345_6.gameObject:GetComponent(typeof(Image))

						arg_342_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_345_7 = 0.5

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_7 then
				var_345_5.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_342_1.time_ - 0) / var_345_7)

				if arg_342_1.var_.actorSpriteSplit10155 ~= nil then
					arg_342_1.var_.actorSpriteSplit10155:SetAlpha((arg_342_1.time_ - 0) / var_345_7)
				end
			end

			if arg_342_1.time_ >= 0 + var_345_7 and arg_342_1.time_ < 0 + var_345_7 + arg_345_0 then
				var_345_5.localPosition = Vector3.New(-410, -390, -250)

				if arg_342_1.var_.actorSpriteSplit10155 ~= nil then
					arg_342_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_345_8 = 0
			local var_345_9 = 0.425

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_8 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_10 = arg_342_1:GetWordFromCfg(424071082)
				local var_345_11 = arg_342_1:FormatText(var_345_10.content)

				arg_342_1.text_.text = var_345_11

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_13 = 17 <= 0 and var_345_9 or var_345_9 * (utf8.len(var_345_11) / 17)

				if (17 <= 0 and var_345_9 or var_345_9 * (utf8.len(var_345_11) / 17)) > 0 and var_345_9 < var_345_13 then
					arg_342_1.talkMaxDuration = var_345_13

					if var_345_13 + var_345_8 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_13 + var_345_8
					end
				end

				arg_342_1.text_.text = var_345_11
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071082", "story_v_out_424071.awb") ~= 0 then
					local var_345_14 = manager.audio:GetVoiceLength("story_v_out_424071", "424071082", "story_v_out_424071.awb") / 1000

					if var_345_14 + var_345_8 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_14 + var_345_8
					end

					if var_345_10.prefab_name ~= "" and arg_342_1.actors_[var_345_10.prefab_name] ~= nil then
						local var_345_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_10.prefab_name].transform, "story_v_out_424071", "424071082", "story_v_out_424071.awb")

						arg_342_1:RecordAudio("424071082", var_345_15)
						arg_342_1:RecordAudio("424071082", var_345_15)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_424071", "424071082", "story_v_out_424071.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_424071", "424071082", "story_v_out_424071.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_16 = math.max(var_345_9, arg_342_1.talkMaxDuration)

			if var_345_8 <= arg_342_1.time_ and arg_342_1.time_ < var_345_8 + var_345_16 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_8) / var_345_16

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_8 + var_345_16 and arg_342_1.time_ < var_345_8 + var_345_16 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play424071083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 424071083
		arg_346_1.duration_ = 6.67

		local var_346_0 = {
			zh = 5.4,
			ja = 6.666
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play424071084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["10155"]) and arg_346_1.var_.actorSpriteComps10155 == nil then
				arg_346_1.var_.actorSpriteComps10155 = arg_346_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_0 = 0.2

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["10155"]) then
				if arg_346_1.var_.actorSpriteComps10155 then
					for iter_349_0, iter_349_1 in pairs(arg_346_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_349_1 then
							if arg_346_1.isInRecall_ then
								iter_349_1.color = Color.New(Mathf.Lerp(iter_349_1.color.r, arg_346_1.hightColor2.r, (arg_346_1.time_ - 0) / var_349_0), Mathf.Lerp(iter_349_1.color.g, arg_346_1.hightColor2.g, (arg_346_1.time_ - 0) / var_349_0), (Mathf.Lerp(iter_349_1.color.b, arg_346_1.hightColor2.b, (arg_346_1.time_ - 0) / var_349_0)))
							else
								local var_349_1 = Mathf.Lerp(iter_349_1.color.r, 0.5, (arg_346_1.time_ - 0) / var_349_0)

								iter_349_1.color = Color.New(var_349_1, var_349_1, var_349_1)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["10155"]) and arg_346_1.var_.actorSpriteComps10155 then
				for iter_349_2, iter_349_3 in pairs(arg_346_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_349_3 then
						iter_349_3.color = arg_346_1.isInRecall_ and (arg_346_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_346_1.var_.actorSpriteComps10155 = nil
			end

			local var_349_2 = 0
			local var_349_3 = 0.725

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_2 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, true)
				arg_346_1.iconController_:SetSelectedState("hero")

				arg_346_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_346_1.callingController_:SetSelectedState("normal")

				arg_346_1.keyicon_.color = Color.New(1, 1, 1)
				arg_346_1.icon_.color = Color.New(1, 1, 1)

				local var_349_4 = arg_346_1:GetWordFromCfg(424071083)
				local var_349_5 = arg_346_1:FormatText(var_349_4.content)

				arg_346_1.text_.text = var_349_5

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_7 = 29 <= 0 and var_349_3 or var_349_3 * (utf8.len(var_349_5) / 29)

				if (29 <= 0 and var_349_3 or var_349_3 * (utf8.len(var_349_5) / 29)) > 0 and var_349_3 < var_349_7 then
					arg_346_1.talkMaxDuration = var_349_7

					if var_349_7 + var_349_2 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_7 + var_349_2
					end
				end

				arg_346_1.text_.text = var_349_5
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071083", "story_v_out_424071.awb") ~= 0 then
					local var_349_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071083", "story_v_out_424071.awb") / 1000

					if var_349_8 + var_349_2 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_8 + var_349_2
					end

					if var_349_4.prefab_name ~= "" and arg_346_1.actors_[var_349_4.prefab_name] ~= nil then
						local var_349_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_4.prefab_name].transform, "story_v_out_424071", "424071083", "story_v_out_424071.awb")

						arg_346_1:RecordAudio("424071083", var_349_9)
						arg_346_1:RecordAudio("424071083", var_349_9)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_424071", "424071083", "story_v_out_424071.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_424071", "424071083", "story_v_out_424071.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_10 = math.max(var_349_3, arg_346_1.talkMaxDuration)

			if var_349_2 <= arg_346_1.time_ and arg_346_1.time_ < var_349_2 + var_349_10 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_2) / var_349_10

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_2 + var_349_10 and arg_346_1.time_ < var_349_2 + var_349_10 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play424071084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 424071084
		arg_350_1.duration_ = 12.03

		local var_350_0 = {
			zh = 6.133,
			ja = 12.033
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play424071085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["10155"]) and arg_350_1.var_.actorSpriteComps10155 == nil then
				arg_350_1.var_.actorSpriteComps10155 = arg_350_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_0 = 0.2

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["10155"]) then
				if arg_350_1.var_.actorSpriteComps10155 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								iter_353_1.color = Color.New(Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor1.r, (arg_350_1.time_ - 0) / var_353_0), Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor1.g, (arg_350_1.time_ - 0) / var_353_0), (Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor1.b, (arg_350_1.time_ - 0) / var_353_0)))
							else
								local var_353_1 = Mathf.Lerp(iter_353_1.color.r, 1, (arg_350_1.time_ - 0) / var_353_0)

								iter_353_1.color = Color.New(var_353_1, var_353_1, var_353_1)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["10155"]) and arg_350_1.var_.actorSpriteComps10155 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_353_3 then
						iter_353_3.color = arg_350_1.isInRecall_ and (arg_350_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_350_1.var_.actorSpriteComps10155 = nil
			end

			local var_353_2 = arg_350_1.actors_["10155"].transform

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 then
				arg_350_1.var_.moveOldPos10155 = var_353_2.localPosition
				var_353_2.localScale = Vector3.New(1, 1, 1)

				arg_350_1:CheckSpriteTmpPos("10155", 2)

				for iter_353_4 = 0, var_353_2.childCount - 1 do
					local var_353_3 = var_353_2:GetChild(iter_353_4)

					if var_353_3.name == "split_1" then
						var_353_3:SetAsLastSibling()
						var_353_3.gameObject:SetActive(true)

						arg_350_1.var_.actorSpriteSplit10155 = var_353_3.gameObject:GetComponent(typeof(Image))

						arg_350_1.var_.actorSpriteSplit10155:SetAlpha(0)
					end
				end
			end

			local var_353_4 = 0.5

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_4 then
				var_353_2.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_350_1.time_ - 0) / var_353_4)

				if arg_350_1.var_.actorSpriteSplit10155 ~= nil then
					arg_350_1.var_.actorSpriteSplit10155:SetAlpha((arg_350_1.time_ - 0) / var_353_4)
				end
			end

			if arg_350_1.time_ >= 0 + var_353_4 and arg_350_1.time_ < 0 + var_353_4 + arg_353_0 then
				var_353_2.localPosition = Vector3.New(-410, -390, -250)

				if arg_350_1.var_.actorSpriteSplit10155 ~= nil then
					arg_350_1.var_.actorSpriteSplit10155:SetAlpha(1)
				end
			end

			local var_353_5 = 0
			local var_353_6 = 0.675

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_5 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_7 = arg_350_1:GetWordFromCfg(424071084)
				local var_353_8 = arg_350_1:FormatText(var_353_7.content)

				arg_350_1.text_.text = var_353_8

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_10 = 27 <= 0 and var_353_6 or var_353_6 * (utf8.len(var_353_8) / 27)

				if (27 <= 0 and var_353_6 or var_353_6 * (utf8.len(var_353_8) / 27)) > 0 and var_353_6 < var_353_10 then
					arg_350_1.talkMaxDuration = var_353_10

					if var_353_10 + var_353_5 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_10 + var_353_5
					end
				end

				arg_350_1.text_.text = var_353_8
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071084", "story_v_out_424071.awb") ~= 0 then
					local var_353_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071084", "story_v_out_424071.awb") / 1000

					if var_353_11 + var_353_5 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_11 + var_353_5
					end

					if var_353_7.prefab_name ~= "" and arg_350_1.actors_[var_353_7.prefab_name] ~= nil then
						local var_353_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_7.prefab_name].transform, "story_v_out_424071", "424071084", "story_v_out_424071.awb")

						arg_350_1:RecordAudio("424071084", var_353_12)
						arg_350_1:RecordAudio("424071084", var_353_12)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_424071", "424071084", "story_v_out_424071.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_424071", "424071084", "story_v_out_424071.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_13 = math.max(var_353_6, arg_350_1.talkMaxDuration)

			if var_353_5 <= arg_350_1.time_ and arg_350_1.time_ < var_353_5 + var_353_13 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_5) / var_353_13

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_5 + var_353_13 and arg_350_1.time_ < var_353_5 + var_353_13 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_350_1:InitPlayNodeList()
	end,
	Play424071085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 424071085
		arg_354_1.duration_ = 6.73

		local var_354_0 = {
			zh = 2.966,
			ja = 6.733
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play424071086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos10155 = arg_354_1.actors_["10155"].transform.localPosition
				arg_354_1.actors_["10155"].transform.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("10155", 2)

				for iter_357_0 = 0, arg_354_1.actors_["10155"].transform.childCount - 1 do
					local var_357_0 = arg_354_1.actors_["10155"].transform:GetChild(iter_357_0)

					if var_357_0.name == "" or not string.find(var_357_0.name, "split") then
						var_357_0.gameObject:SetActive(true)
					else
						var_357_0.gameObject:SetActive(false)
					end
				end
			end

			local var_357_1 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_1 then
				arg_354_1.actors_["10155"].transform.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_354_1.time_ - 0) / var_357_1)
			end

			if arg_354_1.time_ >= 0 + var_357_1 and arg_354_1.time_ < 0 + var_357_1 + arg_357_0 then
				arg_354_1.actors_["10155"].transform.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_357_2 = 0
			local var_357_3 = 0.475

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_2 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_4 = arg_354_1:GetWordFromCfg(424071085)
				local var_357_5 = arg_354_1:FormatText(var_357_4.content)

				arg_354_1.text_.text = var_357_5

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_7 = 19 <= 0 and var_357_3 or var_357_3 * (utf8.len(var_357_5) / 19)

				if (19 <= 0 and var_357_3 or var_357_3 * (utf8.len(var_357_5) / 19)) > 0 and var_357_3 < var_357_7 then
					arg_354_1.talkMaxDuration = var_357_7

					if var_357_7 + var_357_2 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_7 + var_357_2
					end
				end

				arg_354_1.text_.text = var_357_5
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071085", "story_v_out_424071.awb") ~= 0 then
					local var_357_8 = manager.audio:GetVoiceLength("story_v_out_424071", "424071085", "story_v_out_424071.awb") / 1000

					if var_357_8 + var_357_2 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_8 + var_357_2
					end

					if var_357_4.prefab_name ~= "" and arg_354_1.actors_[var_357_4.prefab_name] ~= nil then
						local var_357_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_4.prefab_name].transform, "story_v_out_424071", "424071085", "story_v_out_424071.awb")

						arg_354_1:RecordAudio("424071085", var_357_9)
						arg_354_1:RecordAudio("424071085", var_357_9)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_424071", "424071085", "story_v_out_424071.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_424071", "424071085", "story_v_out_424071.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_10 = math.max(var_357_3, arg_354_1.talkMaxDuration)

			if var_357_2 <= arg_354_1.time_ and arg_354_1.time_ < var_357_2 + var_357_10 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_2) / var_357_10

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_2 + var_357_10 and arg_354_1.time_ < var_357_2 + var_357_10 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play424071086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 424071086
		arg_358_1.duration_ = 1

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play424071087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(arg_358_1.actors_["1094"]) and arg_358_1.var_.actorSpriteComps1094 == nil then
				arg_358_1.var_.actorSpriteComps1094 = arg_358_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_0 = 0.2

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_0 and not isNil(arg_358_1.actors_["1094"]) then
				if arg_358_1.var_.actorSpriteComps1094 then
					for iter_361_0, iter_361_1 in pairs(arg_358_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_361_1 then
							if arg_358_1.isInRecall_ then
								iter_361_1.color = Color.New(Mathf.Lerp(iter_361_1.color.r, arg_358_1.hightColor1.r, (arg_358_1.time_ - 0) / var_361_0), Mathf.Lerp(iter_361_1.color.g, arg_358_1.hightColor1.g, (arg_358_1.time_ - 0) / var_361_0), (Mathf.Lerp(iter_361_1.color.b, arg_358_1.hightColor1.b, (arg_358_1.time_ - 0) / var_361_0)))
							else
								local var_361_1 = Mathf.Lerp(iter_361_1.color.r, 1, (arg_358_1.time_ - 0) / var_361_0)

								iter_361_1.color = Color.New(var_361_1, var_361_1, var_361_1)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= 0 + var_361_0 and arg_358_1.time_ < 0 + var_361_0 + arg_361_0 and not isNil(arg_358_1.actors_["1094"]) and arg_358_1.var_.actorSpriteComps1094 then
				for iter_361_2, iter_361_3 in pairs(arg_358_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_361_3 then
						iter_361_3.color = arg_358_1.isInRecall_ and (arg_358_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_358_1.var_.actorSpriteComps1094 = nil
			end

			local var_361_2 = arg_358_1.actors_["10155"]

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 and not isNil(var_361_2) and arg_358_1.var_.actorSpriteComps10155 == nil then
				arg_358_1.var_.actorSpriteComps10155 = var_361_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_361_3 = 0.2

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_3 and not isNil(var_361_2) then
				if arg_358_1.var_.actorSpriteComps10155 then
					for iter_361_4, iter_361_5 in pairs(arg_358_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_361_5 then
							if arg_358_1.isInRecall_ then
								iter_361_5.color = Color.New(Mathf.Lerp(iter_361_5.color.r, arg_358_1.hightColor2.r, (arg_358_1.time_ - 0) / var_361_3), Mathf.Lerp(iter_361_5.color.g, arg_358_1.hightColor2.g, (arg_358_1.time_ - 0) / var_361_3), (Mathf.Lerp(iter_361_5.color.b, arg_358_1.hightColor2.b, (arg_358_1.time_ - 0) / var_361_3)))
							else
								local var_361_4 = Mathf.Lerp(iter_361_5.color.r, 0.5, (arg_358_1.time_ - 0) / var_361_3)

								iter_361_5.color = Color.New(var_361_4, var_361_4, var_361_4)
							end
						end
					end
				end
			end

			if arg_358_1.time_ >= 0 + var_361_3 and arg_358_1.time_ < 0 + var_361_3 + arg_361_0 and not isNil(var_361_2) and arg_358_1.var_.actorSpriteComps10155 then
				for iter_361_6, iter_361_7 in pairs(arg_358_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_361_7 then
						iter_361_7.color = arg_358_1.isInRecall_ and (arg_358_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_358_1.var_.actorSpriteComps10155 = nil
			end

			local var_361_5 = arg_358_1.actors_["1094"].transform

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.var_.moveOldPos1094 = var_361_5.localPosition
				var_361_5.localScale = Vector3.New(1, 1, 1)

				arg_358_1:CheckSpriteTmpPos("1094", 4)

				for iter_361_8 = 0, var_361_5.childCount - 1 do
					local var_361_6 = var_361_5:GetChild(iter_361_8)

					if var_361_6.name == "" or not string.find(var_361_6.name, "split") then
						var_361_6.gameObject:SetActive(true)
					else
						var_361_6.gameObject:SetActive(false)
					end
				end
			end

			local var_361_7 = 0.001

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_7 then
				var_361_5.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_358_1.time_ - 0) / var_361_7)
			end

			if arg_358_1.time_ >= 0 + var_361_7 and arg_358_1.time_ < 0 + var_361_7 + arg_361_0 then
				var_361_5.localPosition = Vector3.New(470, -335, -230)
			end

			local var_361_8 = 0
			local var_361_9 = 0.05

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= var_361_8 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, true)

				arg_358_1.leftNameTxt_.text = arg_358_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_358_1.leftNameTxt_.transform)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1.leftNameTxt_.text)
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_10 = arg_358_1:GetWordFromCfg(424071086)
				local var_361_11 = arg_358_1:FormatText(var_361_10.content)

				arg_358_1.text_.text = var_361_11

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_13 = 2 <= 0 and var_361_9 or var_361_9 * (utf8.len(var_361_11) / 2)

				if (2 <= 0 and var_361_9 or var_361_9 * (utf8.len(var_361_11) / 2)) > 0 and var_361_9 < var_361_13 then
					arg_358_1.talkMaxDuration = var_361_13

					if var_361_13 + var_361_8 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_13 + var_361_8
					end
				end

				arg_358_1.text_.text = var_361_11
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071086", "story_v_out_424071.awb") ~= 0 then
					local var_361_14 = manager.audio:GetVoiceLength("story_v_out_424071", "424071086", "story_v_out_424071.awb") / 1000

					if var_361_14 + var_361_8 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_14 + var_361_8
					end

					if var_361_10.prefab_name ~= "" and arg_358_1.actors_[var_361_10.prefab_name] ~= nil then
						local var_361_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_358_1.actors_[var_361_10.prefab_name].transform, "story_v_out_424071", "424071086", "story_v_out_424071.awb")

						arg_358_1:RecordAudio("424071086", var_361_15)
						arg_358_1:RecordAudio("424071086", var_361_15)
					else
						arg_358_1:AudioAction("play", "voice", "story_v_out_424071", "424071086", "story_v_out_424071.awb")
					end

					arg_358_1:RecordHistoryTalkVoice("story_v_out_424071", "424071086", "story_v_out_424071.awb")
				end

				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_16 = math.max(var_361_9, arg_358_1.talkMaxDuration)

			if var_361_8 <= arg_358_1.time_ and arg_358_1.time_ < var_361_8 + var_361_16 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_8) / var_361_16

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_8 + var_361_16 and arg_358_1.time_ < var_361_8 + var_361_16 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play424071087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 424071087
		arg_362_1.duration_ = 24.77

		local var_362_0 = {
			zh = 11.133,
			ja = 24.766
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play424071088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["10155"]) and arg_362_1.var_.actorSpriteComps10155 == nil then
				arg_362_1.var_.actorSpriteComps10155 = arg_362_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_0 = 0.2

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["10155"]) then
				if arg_362_1.var_.actorSpriteComps10155 then
					for iter_365_0, iter_365_1 in pairs(arg_362_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_365_1 then
							if arg_362_1.isInRecall_ then
								iter_365_1.color = Color.New(Mathf.Lerp(iter_365_1.color.r, arg_362_1.hightColor1.r, (arg_362_1.time_ - 0) / var_365_0), Mathf.Lerp(iter_365_1.color.g, arg_362_1.hightColor1.g, (arg_362_1.time_ - 0) / var_365_0), (Mathf.Lerp(iter_365_1.color.b, arg_362_1.hightColor1.b, (arg_362_1.time_ - 0) / var_365_0)))
							else
								local var_365_1 = Mathf.Lerp(iter_365_1.color.r, 1, (arg_362_1.time_ - 0) / var_365_0)

								iter_365_1.color = Color.New(var_365_1, var_365_1, var_365_1)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["10155"]) and arg_362_1.var_.actorSpriteComps10155 then
				for iter_365_2, iter_365_3 in pairs(arg_362_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_365_3 then
						iter_365_3.color = arg_362_1.isInRecall_ and (arg_362_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_362_1.var_.actorSpriteComps10155 = nil
			end

			local var_365_2 = arg_362_1.actors_["1094"]

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(var_365_2) and arg_362_1.var_.actorSpriteComps1094 == nil then
				arg_362_1.var_.actorSpriteComps1094 = var_365_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_365_3 = 0.2

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_3 and not isNil(var_365_2) then
				if arg_362_1.var_.actorSpriteComps1094 then
					for iter_365_4, iter_365_5 in pairs(arg_362_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_365_5 then
							if arg_362_1.isInRecall_ then
								iter_365_5.color = Color.New(Mathf.Lerp(iter_365_5.color.r, arg_362_1.hightColor2.r, (arg_362_1.time_ - 0) / var_365_3), Mathf.Lerp(iter_365_5.color.g, arg_362_1.hightColor2.g, (arg_362_1.time_ - 0) / var_365_3), (Mathf.Lerp(iter_365_5.color.b, arg_362_1.hightColor2.b, (arg_362_1.time_ - 0) / var_365_3)))
							else
								local var_365_4 = Mathf.Lerp(iter_365_5.color.r, 0.5, (arg_362_1.time_ - 0) / var_365_3)

								iter_365_5.color = Color.New(var_365_4, var_365_4, var_365_4)
							end
						end
					end
				end
			end

			if arg_362_1.time_ >= 0 + var_365_3 and arg_362_1.time_ < 0 + var_365_3 + arg_365_0 and not isNil(var_365_2) and arg_362_1.var_.actorSpriteComps1094 then
				for iter_365_6, iter_365_7 in pairs(arg_362_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_365_7 then
						iter_365_7.color = arg_362_1.isInRecall_ and (arg_362_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_362_1.var_.actorSpriteComps1094 = nil
			end

			local var_365_5 = arg_362_1.actors_["10155"].transform

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos10155 = var_365_5.localPosition
				var_365_5.localScale = Vector3.New(1, 1, 1)

				arg_362_1:CheckSpriteTmpPos("10155", 2)

				for iter_365_8 = 0, var_365_5.childCount - 1 do
					local var_365_6 = var_365_5:GetChild(iter_365_8)

					if var_365_6.name == "" or not string.find(var_365_6.name, "split") then
						var_365_6.gameObject:SetActive(true)
					else
						var_365_6.gameObject:SetActive(false)
					end
				end
			end

			local var_365_7 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_7 then
				var_365_5.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_362_1.time_ - 0) / var_365_7)
			end

			if arg_362_1.time_ >= 0 + var_365_7 and arg_362_1.time_ < 0 + var_365_7 + arg_365_0 then
				var_365_5.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_365_8 = 0
			local var_365_9 = 1.275

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_8 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_10 = arg_362_1:GetWordFromCfg(424071087)
				local var_365_11 = arg_362_1:FormatText(var_365_10.content)

				arg_362_1.text_.text = var_365_11

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_13 = 51 <= 0 and var_365_9 or var_365_9 * (utf8.len(var_365_11) / 51)

				if (51 <= 0 and var_365_9 or var_365_9 * (utf8.len(var_365_11) / 51)) > 0 and var_365_9 < var_365_13 then
					arg_362_1.talkMaxDuration = var_365_13

					if var_365_13 + var_365_8 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_13 + var_365_8
					end
				end

				arg_362_1.text_.text = var_365_11
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071087", "story_v_out_424071.awb") ~= 0 then
					local var_365_14 = manager.audio:GetVoiceLength("story_v_out_424071", "424071087", "story_v_out_424071.awb") / 1000

					if var_365_14 + var_365_8 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_14 + var_365_8
					end

					if var_365_10.prefab_name ~= "" and arg_362_1.actors_[var_365_10.prefab_name] ~= nil then
						local var_365_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_10.prefab_name].transform, "story_v_out_424071", "424071087", "story_v_out_424071.awb")

						arg_362_1:RecordAudio("424071087", var_365_15)
						arg_362_1:RecordAudio("424071087", var_365_15)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_424071", "424071087", "story_v_out_424071.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_424071", "424071087", "story_v_out_424071.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_16 = math.max(var_365_9, arg_362_1.talkMaxDuration)

			if var_365_8 <= arg_362_1.time_ and arg_362_1.time_ < var_365_8 + var_365_16 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_8) / var_365_16

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_8 + var_365_16 and arg_362_1.time_ < var_365_8 + var_365_16 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play424071088 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 424071088
		arg_366_1.duration_ = 1.17

		local var_366_0 = {
			zh = 1.166,
			ja = 0.999999999999
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play424071089(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["1094"]) and arg_366_1.var_.actorSpriteComps1094 == nil then
				arg_366_1.var_.actorSpriteComps1094 = arg_366_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_0 = 0.2

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["1094"]) then
				if arg_366_1.var_.actorSpriteComps1094 then
					for iter_369_0, iter_369_1 in pairs(arg_366_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_369_1 then
							if arg_366_1.isInRecall_ then
								iter_369_1.color = Color.New(Mathf.Lerp(iter_369_1.color.r, arg_366_1.hightColor1.r, (arg_366_1.time_ - 0) / var_369_0), Mathf.Lerp(iter_369_1.color.g, arg_366_1.hightColor1.g, (arg_366_1.time_ - 0) / var_369_0), (Mathf.Lerp(iter_369_1.color.b, arg_366_1.hightColor1.b, (arg_366_1.time_ - 0) / var_369_0)))
							else
								local var_369_1 = Mathf.Lerp(iter_369_1.color.r, 1, (arg_366_1.time_ - 0) / var_369_0)

								iter_369_1.color = Color.New(var_369_1, var_369_1, var_369_1)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["1094"]) and arg_366_1.var_.actorSpriteComps1094 then
				for iter_369_2, iter_369_3 in pairs(arg_366_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_369_3 then
						iter_369_3.color = arg_366_1.isInRecall_ and (arg_366_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_366_1.var_.actorSpriteComps1094 = nil
			end

			local var_369_2 = arg_366_1.actors_["10155"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_2) and arg_366_1.var_.actorSpriteComps10155 == nil then
				arg_366_1.var_.actorSpriteComps10155 = var_369_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_369_3 = 0.2

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_3 and not isNil(var_369_2) then
				if arg_366_1.var_.actorSpriteComps10155 then
					for iter_369_4, iter_369_5 in pairs(arg_366_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_369_5 then
							if arg_366_1.isInRecall_ then
								iter_369_5.color = Color.New(Mathf.Lerp(iter_369_5.color.r, arg_366_1.hightColor2.r, (arg_366_1.time_ - 0) / var_369_3), Mathf.Lerp(iter_369_5.color.g, arg_366_1.hightColor2.g, (arg_366_1.time_ - 0) / var_369_3), (Mathf.Lerp(iter_369_5.color.b, arg_366_1.hightColor2.b, (arg_366_1.time_ - 0) / var_369_3)))
							else
								local var_369_4 = Mathf.Lerp(iter_369_5.color.r, 0.5, (arg_366_1.time_ - 0) / var_369_3)

								iter_369_5.color = Color.New(var_369_4, var_369_4, var_369_4)
							end
						end
					end
				end
			end

			if arg_366_1.time_ >= 0 + var_369_3 and arg_366_1.time_ < 0 + var_369_3 + arg_369_0 and not isNil(var_369_2) and arg_366_1.var_.actorSpriteComps10155 then
				for iter_369_6, iter_369_7 in pairs(arg_366_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_369_7 then
						iter_369_7.color = arg_366_1.isInRecall_ and (arg_366_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_366_1.var_.actorSpriteComps10155 = nil
			end

			local var_369_5 = arg_366_1.actors_["1094"].transform

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos1094 = var_369_5.localPosition
				var_369_5.localScale = Vector3.New(1, 1, 1)

				arg_366_1:CheckSpriteTmpPos("1094", 4)

				for iter_369_8 = 0, var_369_5.childCount - 1 do
					local var_369_6 = var_369_5:GetChild(iter_369_8)

					if var_369_6.name == "split_2" or not string.find(var_369_6.name, "split") then
						var_369_6.gameObject:SetActive(true)
					else
						var_369_6.gameObject:SetActive(false)
					end
				end
			end

			local var_369_7 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_7 then
				var_369_5.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_366_1.time_ - 0) / var_369_7)
			end

			if arg_366_1.time_ >= 0 + var_369_7 and arg_366_1.time_ < 0 + var_369_7 + arg_369_0 then
				var_369_5.localPosition = Vector3.New(470, -335, -230)
			end

			local var_369_8 = 0
			local var_369_9 = 0.1

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_8 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_10 = arg_366_1:GetWordFromCfg(424071088)
				local var_369_11 = arg_366_1:FormatText(var_369_10.content)

				arg_366_1.text_.text = var_369_11

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_13 = 4 <= 0 and var_369_9 or var_369_9 * (utf8.len(var_369_11) / 4)

				if (4 <= 0 and var_369_9 or var_369_9 * (utf8.len(var_369_11) / 4)) > 0 and var_369_9 < var_369_13 then
					arg_366_1.talkMaxDuration = var_369_13

					if var_369_13 + var_369_8 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_13 + var_369_8
					end
				end

				arg_366_1.text_.text = var_369_11
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071088", "story_v_out_424071.awb") ~= 0 then
					local var_369_14 = manager.audio:GetVoiceLength("story_v_out_424071", "424071088", "story_v_out_424071.awb") / 1000

					if var_369_14 + var_369_8 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_14 + var_369_8
					end

					if var_369_10.prefab_name ~= "" and arg_366_1.actors_[var_369_10.prefab_name] ~= nil then
						local var_369_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_10.prefab_name].transform, "story_v_out_424071", "424071088", "story_v_out_424071.awb")

						arg_366_1:RecordAudio("424071088", var_369_15)
						arg_366_1:RecordAudio("424071088", var_369_15)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_424071", "424071088", "story_v_out_424071.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_424071", "424071088", "story_v_out_424071.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_16 = math.max(var_369_9, arg_366_1.talkMaxDuration)

			if var_369_8 <= arg_366_1.time_ and arg_366_1.time_ < var_369_8 + var_369_16 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_8) / var_369_16

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_8 + var_369_16 and arg_366_1.time_ < var_369_8 + var_369_16 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play424071089 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 424071089
		arg_370_1.duration_ = 4.27

		local var_370_0 = {
			zh = 1.5,
			ja = 4.266
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play424071090(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["10155"]) and arg_370_1.var_.actorSpriteComps10155 == nil then
				arg_370_1.var_.actorSpriteComps10155 = arg_370_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_0 = 0.2

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["10155"]) then
				if arg_370_1.var_.actorSpriteComps10155 then
					for iter_373_0, iter_373_1 in pairs(arg_370_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_373_1 then
							if arg_370_1.isInRecall_ then
								iter_373_1.color = Color.New(Mathf.Lerp(iter_373_1.color.r, arg_370_1.hightColor1.r, (arg_370_1.time_ - 0) / var_373_0), Mathf.Lerp(iter_373_1.color.g, arg_370_1.hightColor1.g, (arg_370_1.time_ - 0) / var_373_0), (Mathf.Lerp(iter_373_1.color.b, arg_370_1.hightColor1.b, (arg_370_1.time_ - 0) / var_373_0)))
							else
								local var_373_1 = Mathf.Lerp(iter_373_1.color.r, 1, (arg_370_1.time_ - 0) / var_373_0)

								iter_373_1.color = Color.New(var_373_1, var_373_1, var_373_1)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["10155"]) and arg_370_1.var_.actorSpriteComps10155 then
				for iter_373_2, iter_373_3 in pairs(arg_370_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_373_3 then
						iter_373_3.color = arg_370_1.isInRecall_ and (arg_370_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_370_1.var_.actorSpriteComps10155 = nil
			end

			local var_373_2 = arg_370_1.actors_["1094"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.actorSpriteComps1094 == nil then
				arg_370_1.var_.actorSpriteComps1094 = var_373_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_373_3 = 0.2

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_3 and not isNil(var_373_2) then
				if arg_370_1.var_.actorSpriteComps1094 then
					for iter_373_4, iter_373_5 in pairs(arg_370_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_373_5 then
							if arg_370_1.isInRecall_ then
								iter_373_5.color = Color.New(Mathf.Lerp(iter_373_5.color.r, arg_370_1.hightColor2.r, (arg_370_1.time_ - 0) / var_373_3), Mathf.Lerp(iter_373_5.color.g, arg_370_1.hightColor2.g, (arg_370_1.time_ - 0) / var_373_3), (Mathf.Lerp(iter_373_5.color.b, arg_370_1.hightColor2.b, (arg_370_1.time_ - 0) / var_373_3)))
							else
								local var_373_4 = Mathf.Lerp(iter_373_5.color.r, 0.5, (arg_370_1.time_ - 0) / var_373_3)

								iter_373_5.color = Color.New(var_373_4, var_373_4, var_373_4)
							end
						end
					end
				end
			end

			if arg_370_1.time_ >= 0 + var_373_3 and arg_370_1.time_ < 0 + var_373_3 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.actorSpriteComps1094 then
				for iter_373_6, iter_373_7 in pairs(arg_370_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_373_7 then
						iter_373_7.color = arg_370_1.isInRecall_ and (arg_370_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_370_1.var_.actorSpriteComps1094 = nil
			end

			local var_373_5 = arg_370_1.actors_["10155"].transform

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.var_.moveOldPos10155 = var_373_5.localPosition
				var_373_5.localScale = Vector3.New(1, 1, 1)

				arg_370_1:CheckSpriteTmpPos("10155", 2)

				for iter_373_8 = 0, var_373_5.childCount - 1 do
					local var_373_6 = var_373_5:GetChild(iter_373_8)

					if var_373_6.name == "" or not string.find(var_373_6.name, "split") then
						var_373_6.gameObject:SetActive(true)
					else
						var_373_6.gameObject:SetActive(false)
					end
				end
			end

			local var_373_7 = 0.001

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_7 then
				var_373_5.localPosition = Vector3.Lerp(arg_370_1.var_.moveOldPos10155, Vector3.New(-410, -390, -250), (arg_370_1.time_ - 0) / var_373_7)
			end

			if arg_370_1.time_ >= 0 + var_373_7 and arg_370_1.time_ < 0 + var_373_7 + arg_373_0 then
				var_373_5.localPosition = Vector3.New(-410, -390, -250)
			end

			local var_373_8 = 0
			local var_373_9 = 0.2

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_8 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[1391].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_10 = arg_370_1:GetWordFromCfg(424071089)
				local var_373_11 = arg_370_1:FormatText(var_373_10.content)

				arg_370_1.text_.text = var_373_11

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_13 = 8 <= 0 and var_373_9 or var_373_9 * (utf8.len(var_373_11) / 8)

				if (8 <= 0 and var_373_9 or var_373_9 * (utf8.len(var_373_11) / 8)) > 0 and var_373_9 < var_373_13 then
					arg_370_1.talkMaxDuration = var_373_13

					if var_373_13 + var_373_8 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_13 + var_373_8
					end
				end

				arg_370_1.text_.text = var_373_11
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071089", "story_v_out_424071.awb") ~= 0 then
					local var_373_14 = manager.audio:GetVoiceLength("story_v_out_424071", "424071089", "story_v_out_424071.awb") / 1000

					if var_373_14 + var_373_8 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_14 + var_373_8
					end

					if var_373_10.prefab_name ~= "" and arg_370_1.actors_[var_373_10.prefab_name] ~= nil then
						local var_373_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_10.prefab_name].transform, "story_v_out_424071", "424071089", "story_v_out_424071.awb")

						arg_370_1:RecordAudio("424071089", var_373_15)
						arg_370_1:RecordAudio("424071089", var_373_15)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_424071", "424071089", "story_v_out_424071.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_424071", "424071089", "story_v_out_424071.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_16 = math.max(var_373_9, arg_370_1.talkMaxDuration)

			if var_373_8 <= arg_370_1.time_ and arg_370_1.time_ < var_373_8 + var_373_16 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_8) / var_373_16

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_8 + var_373_16 and arg_370_1.time_ < var_373_8 + var_373_16 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_370_1:InitPlayNodeList()
	end,
	Play424071090 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 424071090
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play424071091(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(arg_374_1.actors_["10155"]) and arg_374_1.var_.actorSpriteComps10155 == nil then
				arg_374_1.var_.actorSpriteComps10155 = arg_374_1.actors_["10155"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_377_0 = 0.2

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 and not isNil(arg_374_1.actors_["10155"]) then
				if arg_374_1.var_.actorSpriteComps10155 then
					for iter_377_0, iter_377_1 in pairs(arg_374_1.var_.actorSpriteComps10155:ToTable()) do
						if iter_377_1 then
							if arg_374_1.isInRecall_ then
								iter_377_1.color = Color.New(Mathf.Lerp(iter_377_1.color.r, arg_374_1.hightColor2.r, (arg_374_1.time_ - 0) / var_377_0), Mathf.Lerp(iter_377_1.color.g, arg_374_1.hightColor2.g, (arg_374_1.time_ - 0) / var_377_0), (Mathf.Lerp(iter_377_1.color.b, arg_374_1.hightColor2.b, (arg_374_1.time_ - 0) / var_377_0)))
							else
								local var_377_1 = Mathf.Lerp(iter_377_1.color.r, 0.5, (arg_374_1.time_ - 0) / var_377_0)

								iter_377_1.color = Color.New(var_377_1, var_377_1, var_377_1)
							end
						end
					end
				end
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 and not isNil(arg_374_1.actors_["10155"]) and arg_374_1.var_.actorSpriteComps10155 then
				for iter_377_2, iter_377_3 in pairs(arg_374_1.var_.actorSpriteComps10155:ToTable()) do
					if iter_377_3 then
						iter_377_3.color = arg_374_1.isInRecall_ and (arg_374_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_374_1.var_.actorSpriteComps10155 = nil
			end

			local var_377_2 = arg_374_1.actors_["10155"].transform

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPos10155 = var_377_2.localPosition
				var_377_2.localScale = Vector3.New(1, 1, 1)

				arg_374_1:CheckSpriteTmpPos("10155", 7)

				for iter_377_4 = 0, var_377_2.childCount - 1 do
					local var_377_3 = var_377_2:GetChild(iter_377_4)

					if var_377_3.name == "" or not string.find(var_377_3.name, "split") then
						var_377_3.gameObject:SetActive(true)
					else
						var_377_3.gameObject:SetActive(false)
					end
				end
			end

			local var_377_4 = 0.001

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_4 then
				var_377_2.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos10155, Vector3.New(0, -2000, 0), (arg_374_1.time_ - 0) / var_377_4)
			end

			if arg_374_1.time_ >= 0 + var_377_4 and arg_374_1.time_ < 0 + var_377_4 + arg_377_0 then
				var_377_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_377_5 = arg_374_1.actors_["1094"].transform

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.var_.moveOldPos1094 = var_377_5.localPosition
				var_377_5.localScale = Vector3.New(1, 1, 1)

				arg_374_1:CheckSpriteTmpPos("1094", 7)

				for iter_377_5 = 0, var_377_5.childCount - 1 do
					local var_377_6 = var_377_5:GetChild(iter_377_5)

					if var_377_6.name == "" or not string.find(var_377_6.name, "split") then
						var_377_6.gameObject:SetActive(true)
					else
						var_377_6.gameObject:SetActive(false)
					end
				end
			end

			local var_377_7 = 0.001

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_7 then
				var_377_5.localPosition = Vector3.Lerp(arg_374_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_374_1.time_ - 0) / var_377_7)
			end

			if arg_374_1.time_ >= 0 + var_377_7 and arg_374_1.time_ < 0 + var_377_7 + arg_377_0 then
				var_377_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.034 < arg_374_1.time_ and arg_374_1.time_ <= 0.034 + arg_377_0 then
				arg_374_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_clap", "")
			end

			local var_377_9 = 0
			local var_377_10 = 0.825

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_9 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_11 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(424071090).content)

				arg_374_1.text_.text = var_377_11

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_13 = 33 <= 0 and var_377_10 or var_377_10 * (utf8.len(var_377_11) / 33)

				if (33 <= 0 and var_377_10 or var_377_10 * (utf8.len(var_377_11) / 33)) > 0 and var_377_10 < var_377_13 then
					arg_374_1.talkMaxDuration = var_377_13

					if var_377_13 + var_377_9 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_13 + var_377_9
					end
				end

				arg_374_1.text_.text = var_377_11
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_14 = math.max(var_377_10, arg_374_1.talkMaxDuration)

			if var_377_9 <= arg_374_1.time_ and arg_374_1.time_ < var_377_9 + var_377_14 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_9) / var_377_14

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_9 + var_377_14 and arg_374_1.time_ < var_377_9 + var_377_14 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10155",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_374_1:InitPlayNodeList()
	end,
	Play424071091 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 424071091
		arg_378_1.duration_ = 10.3

		local var_378_0 = {
			zh = 7.766,
			ja = 10.3
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play424071092(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 2 < arg_378_1.time_ and arg_378_1.time_ <= 2 + arg_381_0 then
				local var_381_0 = arg_378_1.bgs_.I11r

				arg_378_1.bgs_.I11r.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_381_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_381_1 = var_381_0:GetComponent("SpriteRenderer")

				if var_381_1 and var_381_1.sprite then
					local var_381_2 = 2 * (var_381_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_381_0.transform.localScale = Vector3.New(var_381_2 / var_381_1.sprite.bounds.size.y < var_381_2 * manager.ui.mainCameraCom_.aspect / var_381_1.sprite.bounds.size.x and var_381_2 * manager.ui.mainCameraCom_.aspect / var_381_1.sprite.bounds.size.x or var_381_2 / var_381_1.sprite.bounds.size.y, var_381_2 / var_381_1.sprite.bounds.size.y < var_381_2 * manager.ui.mainCameraCom_.aspect / var_381_1.sprite.bounds.size.x and var_381_2 * manager.ui.mainCameraCom_.aspect / var_381_1.sprite.bounds.size.x or var_381_2 / var_381_1.sprite.bounds.size.y, 0)
				end

				for iter_381_0, iter_381_1 in pairs(arg_378_1.bgs_) do
					if iter_381_0 ~= "I11r" then
						iter_381_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_381_3 = 4

			if 4 < arg_378_1.time_ and arg_378_1.time_ <= var_381_3 + arg_381_0 then
				arg_378_1.allBtn_.enabled = false
			end

			if arg_378_1.time_ >= var_381_3 + 0.3 and arg_378_1.time_ < var_381_3 + 0.3 + arg_381_0 then
				arg_378_1.allBtn_.enabled = true
			end

			local var_381_4 = 0

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_4 + arg_381_0 then
				arg_378_1.mask_.enabled = true
				arg_378_1.mask_.raycastTarget = true

				arg_378_1:SetGaussion(false)
			end

			local var_381_5 = 2

			if var_381_4 <= arg_378_1.time_ and arg_378_1.time_ < var_381_4 + var_381_5 then
				local var_381_6 = Color.New(0, 0, 0)

				var_381_6.a = Mathf.Lerp(0, 1, (arg_378_1.time_ - var_381_4) / var_381_5)
				arg_378_1.mask_.color = var_381_6
			end

			if arg_378_1.time_ >= var_381_4 + var_381_5 and arg_378_1.time_ < var_381_4 + var_381_5 + arg_381_0 then
				local var_381_7 = Color.New(0, 0, 0)

				var_381_7.a = 1
				arg_378_1.mask_.color = var_381_7
			end

			local var_381_8 = 2

			if 2 < arg_378_1.time_ and arg_378_1.time_ <= var_381_8 + arg_381_0 then
				arg_378_1.mask_.enabled = true
				arg_378_1.mask_.raycastTarget = true

				arg_378_1:SetGaussion(false)
			end

			local var_381_9 = 2

			if var_381_8 <= arg_378_1.time_ and arg_378_1.time_ < var_381_8 + var_381_9 then
				local var_381_10 = Color.New(0, 0, 0)

				var_381_10.a = Mathf.Lerp(1, 0, (arg_378_1.time_ - var_381_8) / var_381_9)
				arg_378_1.mask_.color = var_381_10
			end

			if arg_378_1.time_ >= var_381_8 + var_381_9 and arg_378_1.time_ < var_381_8 + var_381_9 + arg_381_0 then
				local var_381_11 = Color.New(0, 0, 0)

				arg_378_1.mask_.enabled = false
				var_381_11.a = 0
				arg_378_1.mask_.color = var_381_11
			end

			if 0.133333333333333 < arg_378_1.time_ and arg_378_1.time_ <= 0.133333333333333 + arg_381_0 then
				arg_378_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_room01", "")
			end

			if 1.76666666666667 < arg_378_1.time_ and arg_378_1.time_ <= 1.76666666666667 + arg_381_0 then
				arg_378_1:AudioAction("play", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if arg_378_1.frameCnt_ <= 1 then
				arg_378_1.dialog_:SetActive(false)
			end

			local var_381_14 = 4
			local var_381_15 = 0.45

			if 4 < arg_378_1.time_ and arg_378_1.time_ <= var_381_14 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0

				arg_378_1.dialog_:SetActive(true)

				arg_378_1.dialogCg_.alpha = 0

				local var_381_16 = LeanTween.value(arg_378_1.dialog_, 0, 1, 0.3)

				var_381_16:setOnUpdate(LuaHelper.FloatAction(function(arg_382_0)
					arg_378_1.dialogCg_.alpha = arg_382_0
				end))
				var_381_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_378_1.dialog_)
					var_381_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_378_1.duration_ = arg_378_1.duration_ + 0.3

				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, true)
				arg_378_1.iconController_:SetSelectedState("hero")

				arg_378_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_378_1.callingController_:SetSelectedState("normal")

				arg_378_1.keyicon_.color = Color.New(1, 1, 1)
				arg_378_1.icon_.color = Color.New(1, 1, 1)

				local var_381_17 = arg_378_1:GetWordFromCfg(424071091)
				local var_381_18 = arg_378_1:FormatText(var_381_17.content)

				arg_378_1.text_.text = var_381_18

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_20 = 18 <= 0 and var_381_15 or var_381_15 * (utf8.len(var_381_18) / 18)

				if (18 <= 0 and var_381_15 or var_381_15 * (utf8.len(var_381_18) / 18)) > 0 and var_381_15 < var_381_20 then
					arg_378_1.talkMaxDuration = var_381_20
					var_381_14 = var_381_14 + 0.3

					if var_381_20 + var_381_14 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_20 + var_381_14
					end
				end

				arg_378_1.text_.text = var_381_18
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071091", "story_v_out_424071.awb") ~= 0 then
					local var_381_21 = manager.audio:GetVoiceLength("story_v_out_424071", "424071091", "story_v_out_424071.awb") / 1000

					if var_381_21 + var_381_14 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_21 + var_381_14
					end

					if var_381_17.prefab_name ~= "" and arg_378_1.actors_[var_381_17.prefab_name] ~= nil then
						local var_381_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_17.prefab_name].transform, "story_v_out_424071", "424071091", "story_v_out_424071.awb")

						arg_378_1:RecordAudio("424071091", var_381_22)
						arg_378_1:RecordAudio("424071091", var_381_22)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_424071", "424071091", "story_v_out_424071.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_424071", "424071091", "story_v_out_424071.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_23 = var_381_14 + 0.3
			local var_381_24 = math.max(var_381_15, arg_378_1.talkMaxDuration)

			if var_381_14 + 0.3 <= arg_378_1.time_ and arg_378_1.time_ < var_381_23 + var_381_24 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_23) / var_381_24

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_23 + var_381_24 and arg_378_1.time_ < var_381_23 + var_381_24 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play424071092 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 424071092
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play424071093(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0.875

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_1 = arg_384_1:FormatText(arg_384_1:GetWordFromCfg(424071092).content)

				arg_384_1.text_.text = var_387_1

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_3 = 35 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_1) / 35)

				if (35 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_1) / 35)) > 0 and var_387_0 < var_387_3 then
					arg_384_1.talkMaxDuration = var_387_3

					if var_387_3 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_3 + 0
					end
				end

				arg_384_1.text_.text = var_387_1
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_4 = math.max(var_387_0, arg_384_1.talkMaxDuration)

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_4 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - 0) / var_387_4

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= 0 + var_387_4 and arg_384_1.time_ < 0 + var_387_4 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play424071093 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 424071093
		arg_388_1.duration_ = 3.5

		local var_388_0 = {
			zh = 2.1,
			ja = 3.5
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
				arg_388_0:Play424071094(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(arg_388_1.actors_["1094"]) and arg_388_1.var_.actorSpriteComps1094 == nil then
				arg_388_1.var_.actorSpriteComps1094 = arg_388_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_0 = 0.2

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 and not isNil(arg_388_1.actors_["1094"]) then
				if arg_388_1.var_.actorSpriteComps1094 then
					for iter_391_0, iter_391_1 in pairs(arg_388_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_391_1 then
							if arg_388_1.isInRecall_ then
								iter_391_1.color = Color.New(Mathf.Lerp(iter_391_1.color.r, arg_388_1.hightColor1.r, (arg_388_1.time_ - 0) / var_391_0), Mathf.Lerp(iter_391_1.color.g, arg_388_1.hightColor1.g, (arg_388_1.time_ - 0) / var_391_0), (Mathf.Lerp(iter_391_1.color.b, arg_388_1.hightColor1.b, (arg_388_1.time_ - 0) / var_391_0)))
							else
								local var_391_1 = Mathf.Lerp(iter_391_1.color.r, 1, (arg_388_1.time_ - 0) / var_391_0)

								iter_391_1.color = Color.New(var_391_1, var_391_1, var_391_1)
							end
						end
					end
				end
			end

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 and not isNil(arg_388_1.actors_["1094"]) and arg_388_1.var_.actorSpriteComps1094 then
				for iter_391_2, iter_391_3 in pairs(arg_388_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_391_3 then
						iter_391_3.color = arg_388_1.isInRecall_ and (arg_388_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_388_1.var_.actorSpriteComps1094 = nil
			end

			local var_391_2 = arg_388_1.actors_["1094"].transform

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos1094 = var_391_2.localPosition
				var_391_2.localScale = Vector3.New(1, 1, 1)

				arg_388_1:CheckSpriteTmpPos("1094", 3)

				for iter_391_4 = 0, var_391_2.childCount - 1 do
					local var_391_3 = var_391_2:GetChild(iter_391_4)

					if var_391_3.name == "split_4" then
						var_391_3:SetAsLastSibling()
						var_391_3.gameObject:SetActive(true)

						arg_388_1.var_.actorSpriteSplit1094 = var_391_3.gameObject:GetComponent(typeof(Image))

						arg_388_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_391_4 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_4 then
				var_391_2.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_388_1.time_ - 0) / var_391_4)

				if arg_388_1.var_.actorSpriteSplit1094 ~= nil then
					arg_388_1.var_.actorSpriteSplit1094:SetAlpha((arg_388_1.time_ - 0) / var_391_4)
				end
			end

			if arg_388_1.time_ >= 0 + var_391_4 and arg_388_1.time_ < 0 + var_391_4 + arg_391_0 then
				var_391_2.localPosition = Vector3.New(0, -335, -230)

				if arg_388_1.var_.actorSpriteSplit1094 ~= nil then
					arg_388_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_391_5 = 0
			local var_391_6 = 0.25

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_5 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_7 = arg_388_1:GetWordFromCfg(424071093)
				local var_391_8 = arg_388_1:FormatText(var_391_7.content)

				arg_388_1.text_.text = var_391_8

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_10 = 10 <= 0 and var_391_6 or var_391_6 * (utf8.len(var_391_8) / 10)

				if (10 <= 0 and var_391_6 or var_391_6 * (utf8.len(var_391_8) / 10)) > 0 and var_391_6 < var_391_10 then
					arg_388_1.talkMaxDuration = var_391_10

					if var_391_10 + var_391_5 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_10 + var_391_5
					end
				end

				arg_388_1.text_.text = var_391_8
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071093", "story_v_out_424071.awb") ~= 0 then
					local var_391_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071093", "story_v_out_424071.awb") / 1000

					if var_391_11 + var_391_5 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_11 + var_391_5
					end

					if var_391_7.prefab_name ~= "" and arg_388_1.actors_[var_391_7.prefab_name] ~= nil then
						local var_391_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_7.prefab_name].transform, "story_v_out_424071", "424071093", "story_v_out_424071.awb")

						arg_388_1:RecordAudio("424071093", var_391_12)
						arg_388_1:RecordAudio("424071093", var_391_12)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_424071", "424071093", "story_v_out_424071.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_424071", "424071093", "story_v_out_424071.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_13 = math.max(var_391_6, arg_388_1.talkMaxDuration)

			if var_391_5 <= arg_388_1.time_ and arg_388_1.time_ < var_391_5 + var_391_13 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_5) / var_391_13

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_5 + var_391_13 and arg_388_1.time_ < var_391_5 + var_391_13 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play424071094 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 424071094
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play424071095(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(arg_392_1.actors_["1094"]) and arg_392_1.var_.actorSpriteComps1094 == nil then
				arg_392_1.var_.actorSpriteComps1094 = arg_392_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_395_0 = 0.2

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 and not isNil(arg_392_1.actors_["1094"]) then
				if arg_392_1.var_.actorSpriteComps1094 then
					for iter_395_0, iter_395_1 in pairs(arg_392_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 and not isNil(arg_392_1.actors_["1094"]) and arg_392_1.var_.actorSpriteComps1094 then
				for iter_395_2, iter_395_3 in pairs(arg_392_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_395_3 then
						iter_395_3.color = arg_392_1.isInRecall_ and (arg_392_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_392_1.var_.actorSpriteComps1094 = nil
			end

			local var_395_2 = 0
			local var_395_3 = 0.475

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_2 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_4 = arg_392_1:FormatText(arg_392_1:GetWordFromCfg(424071094).content)

				arg_392_1.text_.text = var_395_4

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_6 = 19 <= 0 and var_395_3 or var_395_3 * (utf8.len(var_395_4) / 19)

				if (19 <= 0 and var_395_3 or var_395_3 * (utf8.len(var_395_4) / 19)) > 0 and var_395_3 < var_395_6 then
					arg_392_1.talkMaxDuration = var_395_6

					if var_395_6 + var_395_2 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_6 + var_395_2
					end
				end

				arg_392_1.text_.text = var_395_4
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_7 = math.max(var_395_3, arg_392_1.talkMaxDuration)

			if var_395_2 <= arg_392_1.time_ and arg_392_1.time_ < var_395_2 + var_395_7 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_2) / var_395_7

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_2 + var_395_7 and arg_392_1.time_ < var_395_2 + var_395_7 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play424071095 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 424071095
		arg_396_1.duration_ = 5

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play424071096(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.var_.moveOldPos1094 = arg_396_1.actors_["1094"].transform.localPosition
				arg_396_1.actors_["1094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_396_1:CheckSpriteTmpPos("1094", 7)

				for iter_399_0 = 0, arg_396_1.actors_["1094"].transform.childCount - 1 do
					local var_399_0 = arg_396_1.actors_["1094"].transform:GetChild(iter_399_0)

					if var_399_0.name == "" or not string.find(var_399_0.name, "split") then
						var_399_0.gameObject:SetActive(true)
					else
						var_399_0.gameObject:SetActive(false)
					end
				end
			end

			local var_399_1 = 0.001

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_1 then
				arg_396_1.actors_["1094"].transform.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_396_1.time_ - 0) / var_399_1)
			end

			if arg_396_1.time_ >= 0 + var_399_1 and arg_396_1.time_ < 0 + var_399_1 + arg_399_0 then
				arg_396_1.actors_["1094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.034 < arg_396_1.time_ and arg_396_1.time_ <= 0.034 + arg_399_0 then
				arg_396_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_vibrate", "")
			end

			local var_399_3 = 0
			local var_399_4 = 1.1

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_3 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, false)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_5 = arg_396_1:FormatText(arg_396_1:GetWordFromCfg(424071095).content)

				arg_396_1.text_.text = var_399_5

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_7 = 44 <= 0 and var_399_4 or var_399_4 * (utf8.len(var_399_5) / 44)

				if (44 <= 0 and var_399_4 or var_399_4 * (utf8.len(var_399_5) / 44)) > 0 and var_399_4 < var_399_7 then
					arg_396_1.talkMaxDuration = var_399_7

					if var_399_7 + var_399_3 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_7 + var_399_3
					end
				end

				arg_396_1.text_.text = var_399_5
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)
				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_8 = math.max(var_399_4, arg_396_1.talkMaxDuration)

			if var_399_3 <= arg_396_1.time_ and arg_396_1.time_ < var_399_3 + var_399_8 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_3) / var_399_8

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_3 + var_399_8 and arg_396_1.time_ < var_399_3 + var_399_8 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
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
	Play424071096 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 424071096
		arg_400_1.duration_ = 5.7

		local var_400_0 = {
			zh = 3.733,
			ja = 5.7
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
				arg_400_0:Play424071097(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if arg_400_1.actors_["1037"] == nil then
				local var_403_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1037")

				if not isNil(var_403_0) then
					local var_403_1 = Object.Instantiate(var_403_0, arg_400_1.canvasGo_.transform)

					var_403_1.transform:SetSiblingIndex(1)

					var_403_1.name = "1037"
					var_403_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_400_1.actors_["1037"] = var_403_1

					if arg_400_1.isInRecall_ then
						for iter_403_0, iter_403_1 in ipairs((var_403_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_403_1.color = arg_400_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_403_2 = arg_400_1.actors_["1037"]

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(var_403_2) and arg_400_1.var_.actorSpriteComps1037 == nil then
				arg_400_1.var_.actorSpriteComps1037 = var_403_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_403_3 = 0.2

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_3 and not isNil(var_403_2) then
				if arg_400_1.var_.actorSpriteComps1037 then
					for iter_403_2, iter_403_3 in pairs(arg_400_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_403_3 then
							if arg_400_1.isInRecall_ then
								iter_403_3.color = Color.New(Mathf.Lerp(iter_403_3.color.r, arg_400_1.hightColor1.r, (arg_400_1.time_ - 0) / var_403_3), Mathf.Lerp(iter_403_3.color.g, arg_400_1.hightColor1.g, (arg_400_1.time_ - 0) / var_403_3), (Mathf.Lerp(iter_403_3.color.b, arg_400_1.hightColor1.b, (arg_400_1.time_ - 0) / var_403_3)))
							else
								local var_403_4 = Mathf.Lerp(iter_403_3.color.r, 1, (arg_400_1.time_ - 0) / var_403_3)

								iter_403_3.color = Color.New(var_403_4, var_403_4, var_403_4)
							end
						end
					end
				end
			end

			if arg_400_1.time_ >= 0 + var_403_3 and arg_400_1.time_ < 0 + var_403_3 + arg_403_0 and not isNil(var_403_2) and arg_400_1.var_.actorSpriteComps1037 then
				for iter_403_4, iter_403_5 in pairs(arg_400_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_403_5 then
						iter_403_5.color = arg_400_1.isInRecall_ and (arg_400_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_400_1.var_.actorSpriteComps1037 = nil
			end

			local var_403_5 = 0
			local var_403_6 = 0.5

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_5 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_1")

				arg_400_1.callingController_:SetSelectedState("calling")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_7 = arg_400_1:GetWordFromCfg(424071096)
				local var_403_8 = arg_400_1:FormatText(var_403_7.content)

				arg_400_1.text_.text = var_403_8

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_10 = 20 <= 0 and var_403_6 or var_403_6 * (utf8.len(var_403_8) / 20)

				if (20 <= 0 and var_403_6 or var_403_6 * (utf8.len(var_403_8) / 20)) > 0 and var_403_6 < var_403_10 then
					arg_400_1.talkMaxDuration = var_403_10

					if var_403_10 + var_403_5 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_10 + var_403_5
					end
				end

				arg_400_1.text_.text = var_403_8
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071096", "story_v_out_424071.awb") ~= 0 then
					local var_403_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071096", "story_v_out_424071.awb") / 1000

					if var_403_11 + var_403_5 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_11 + var_403_5
					end

					if var_403_7.prefab_name ~= "" and arg_400_1.actors_[var_403_7.prefab_name] ~= nil then
						local var_403_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_7.prefab_name].transform, "story_v_out_424071", "424071096", "story_v_out_424071.awb")

						arg_400_1:RecordAudio("424071096", var_403_12)
						arg_400_1:RecordAudio("424071096", var_403_12)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_424071", "424071096", "story_v_out_424071.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_424071", "424071096", "story_v_out_424071.awb")
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
	Play424071097 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 424071097
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play424071098(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 and not isNil(arg_404_1.actors_["1037"]) and arg_404_1.var_.actorSpriteComps1037 == nil then
				arg_404_1.var_.actorSpriteComps1037 = arg_404_1.actors_["1037"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_407_0 = 0.2

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_0 and not isNil(arg_404_1.actors_["1037"]) then
				if arg_404_1.var_.actorSpriteComps1037 then
					for iter_407_0, iter_407_1 in pairs(arg_404_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_407_1 then
							if arg_404_1.isInRecall_ then
								iter_407_1.color = Color.New(Mathf.Lerp(iter_407_1.color.r, arg_404_1.hightColor2.r, (arg_404_1.time_ - 0) / var_407_0), Mathf.Lerp(iter_407_1.color.g, arg_404_1.hightColor2.g, (arg_404_1.time_ - 0) / var_407_0), (Mathf.Lerp(iter_407_1.color.b, arg_404_1.hightColor2.b, (arg_404_1.time_ - 0) / var_407_0)))
							else
								local var_407_1 = Mathf.Lerp(iter_407_1.color.r, 0.5, (arg_404_1.time_ - 0) / var_407_0)

								iter_407_1.color = Color.New(var_407_1, var_407_1, var_407_1)
							end
						end
					end
				end
			end

			if arg_404_1.time_ >= 0 + var_407_0 and arg_404_1.time_ < 0 + var_407_0 + arg_407_0 and not isNil(arg_404_1.actors_["1037"]) and arg_404_1.var_.actorSpriteComps1037 then
				for iter_407_2, iter_407_3 in pairs(arg_404_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_407_3 then
						iter_407_3.color = arg_404_1.isInRecall_ and (arg_404_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_404_1.var_.actorSpriteComps1037 = nil
			end

			local var_407_2 = 0
			local var_407_3 = 0.275

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_2 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, true)
				arg_404_1.iconController_:SetSelectedState("hero")

				arg_404_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_404_1.callingController_:SetSelectedState("normal")

				arg_404_1.keyicon_.color = Color.New(1, 1, 1)
				arg_404_1.icon_.color = Color.New(1, 1, 1)

				local var_407_4 = arg_404_1:FormatText(arg_404_1:GetWordFromCfg(424071097).content)

				arg_404_1.text_.text = var_407_4

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_6 = 11 <= 0 and var_407_3 or var_407_3 * (utf8.len(var_407_4) / 11)

				if (11 <= 0 and var_407_3 or var_407_3 * (utf8.len(var_407_4) / 11)) > 0 and var_407_3 < var_407_6 then
					arg_404_1.talkMaxDuration = var_407_6

					if var_407_6 + var_407_2 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_6 + var_407_2
					end
				end

				arg_404_1.text_.text = var_407_4
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_3, arg_404_1.talkMaxDuration)

			if var_407_2 <= arg_404_1.time_ and arg_404_1.time_ < var_407_2 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_2) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_2 + var_407_7 and arg_404_1.time_ < var_407_2 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play424071098 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 424071098
		arg_408_1.duration_ = 7.53

		local var_408_0 = {
			zh = 5.8,
			ja = 7.533
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
				arg_408_0:Play424071099(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0.7

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, true)
				arg_408_1.iconController_:SetSelectedState("hero")

				arg_408_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_5")

				arg_408_1.callingController_:SetSelectedState("calling")

				arg_408_1.keyicon_.color = Color.New(1, 1, 1)
				arg_408_1.icon_.color = Color.New(1, 1, 1)

				local var_411_1 = arg_408_1:GetWordFromCfg(424071098)
				local var_411_2 = arg_408_1:FormatText(var_411_1.content)

				arg_408_1.text_.text = var_411_2

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_4 = 28 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_2) / 28)

				if (28 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_2) / 28)) > 0 and var_411_0 < var_411_4 then
					arg_408_1.talkMaxDuration = var_411_4

					if var_411_4 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_4 + 0
					end
				end

				arg_408_1.text_.text = var_411_2
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071098", "story_v_out_424071.awb") ~= 0 then
					local var_411_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071098", "story_v_out_424071.awb") / 1000

					if var_411_5 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_5 + 0
					end

					if var_411_1.prefab_name ~= "" and arg_408_1.actors_[var_411_1.prefab_name] ~= nil then
						local var_411_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_1.prefab_name].transform, "story_v_out_424071", "424071098", "story_v_out_424071.awb")

						arg_408_1:RecordAudio("424071098", var_411_6)
						arg_408_1:RecordAudio("424071098", var_411_6)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_424071", "424071098", "story_v_out_424071.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_424071", "424071098", "story_v_out_424071.awb")
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
	Play424071099 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 424071099
		arg_412_1.duration_ = 11.3

		local var_412_0 = {
			zh = 8.833,
			ja = 11.3
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
				arg_412_0:Play424071100(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 1.05

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_6")

				arg_412_1.callingController_:SetSelectedState("calling")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_1 = arg_412_1:GetWordFromCfg(424071099)
				local var_415_2 = arg_412_1:FormatText(var_415_1.content)

				arg_412_1.text_.text = var_415_2

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_4 = 42 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_2) / 42)

				if (42 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_2) / 42)) > 0 and var_415_0 < var_415_4 then
					arg_412_1.talkMaxDuration = var_415_4

					if var_415_4 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_4 + 0
					end
				end

				arg_412_1.text_.text = var_415_2
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071099", "story_v_out_424071.awb") ~= 0 then
					local var_415_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071099", "story_v_out_424071.awb") / 1000

					if var_415_5 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_5 + 0
					end

					if var_415_1.prefab_name ~= "" and arg_412_1.actors_[var_415_1.prefab_name] ~= nil then
						local var_415_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_1.prefab_name].transform, "story_v_out_424071", "424071099", "story_v_out_424071.awb")

						arg_412_1:RecordAudio("424071099", var_415_6)
						arg_412_1:RecordAudio("424071099", var_415_6)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_424071", "424071099", "story_v_out_424071.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_424071", "424071099", "story_v_out_424071.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_7 = math.max(var_415_0, arg_412_1.talkMaxDuration)

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_7 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - 0) / var_415_7

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= 0 + var_415_7 and arg_412_1.time_ < 0 + var_415_7 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play424071100 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 424071100
		arg_416_1.duration_ = 12.8

		local var_416_0 = {
			zh = 11.033,
			ja = 12.8
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
				arg_416_0:Play424071101(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 1.35

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, true)
				arg_416_1.iconController_:SetSelectedState("hero")

				arg_416_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_6")

				arg_416_1.callingController_:SetSelectedState("calling")

				arg_416_1.keyicon_.color = Color.New(1, 1, 1)
				arg_416_1.icon_.color = Color.New(1, 1, 1)

				local var_419_1 = arg_416_1:GetWordFromCfg(424071100)
				local var_419_2 = arg_416_1:FormatText(var_419_1.content)

				arg_416_1.text_.text = var_419_2

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_4 = 54 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 54)

				if (54 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 54)) > 0 and var_419_0 < var_419_4 then
					arg_416_1.talkMaxDuration = var_419_4

					if var_419_4 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_4 + 0
					end
				end

				arg_416_1.text_.text = var_419_2
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071100", "story_v_out_424071.awb") ~= 0 then
					local var_419_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071100", "story_v_out_424071.awb") / 1000

					if var_419_5 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_5 + 0
					end

					if var_419_1.prefab_name ~= "" and arg_416_1.actors_[var_419_1.prefab_name] ~= nil then
						local var_419_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_1.prefab_name].transform, "story_v_out_424071", "424071100", "story_v_out_424071.awb")

						arg_416_1:RecordAudio("424071100", var_419_6)
						arg_416_1:RecordAudio("424071100", var_419_6)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_424071", "424071100", "story_v_out_424071.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_424071", "424071100", "story_v_out_424071.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_7 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_7 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_7

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_7 and arg_416_1.time_ < 0 + var_419_7 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play424071101 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 424071101
		arg_420_1.duration_ = 8.5

		local var_420_0 = {
			zh = 8.5,
			ja = 8.033
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
				arg_420_0:Play424071102(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = 0.95

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, true)
				arg_420_1.iconController_:SetSelectedState("hero")

				arg_420_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_4")

				arg_420_1.callingController_:SetSelectedState("calling")

				arg_420_1.keyicon_.color = Color.New(1, 1, 1)
				arg_420_1.icon_.color = Color.New(1, 1, 1)

				local var_423_1 = arg_420_1:GetWordFromCfg(424071101)
				local var_423_2 = arg_420_1:FormatText(var_423_1.content)

				arg_420_1.text_.text = var_423_2

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_4 = 38 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_2) / 38)

				if (38 <= 0 and var_423_0 or var_423_0 * (utf8.len(var_423_2) / 38)) > 0 and var_423_0 < var_423_4 then
					arg_420_1.talkMaxDuration = var_423_4

					if var_423_4 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_4 + 0
					end
				end

				arg_420_1.text_.text = var_423_2
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071101", "story_v_out_424071.awb") ~= 0 then
					local var_423_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071101", "story_v_out_424071.awb") / 1000

					if var_423_5 + 0 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_5 + 0
					end

					if var_423_1.prefab_name ~= "" and arg_420_1.actors_[var_423_1.prefab_name] ~= nil then
						local var_423_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_1.prefab_name].transform, "story_v_out_424071", "424071101", "story_v_out_424071.awb")

						arg_420_1:RecordAudio("424071101", var_423_6)
						arg_420_1:RecordAudio("424071101", var_423_6)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_424071", "424071101", "story_v_out_424071.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_424071", "424071101", "story_v_out_424071.awb")
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
	Play424071102 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 424071102
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play424071103(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0.55

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, true)
				arg_424_1.iconController_:SetSelectedState("hero")

				arg_424_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_424_1.callingController_:SetSelectedState("normal")

				arg_424_1.keyicon_.color = Color.New(1, 1, 1)
				arg_424_1.icon_.color = Color.New(1, 1, 1)

				local var_427_1 = arg_424_1:FormatText(arg_424_1:GetWordFromCfg(424071102).content)

				arg_424_1.text_.text = var_427_1

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_3 = 22 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_1) / 22)

				if (22 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_1) / 22)) > 0 and var_427_0 < var_427_3 then
					arg_424_1.talkMaxDuration = var_427_3

					if var_427_3 + 0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_3 + 0
					end
				end

				arg_424_1.text_.text = var_427_1
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_4 = math.max(var_427_0, arg_424_1.talkMaxDuration)

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_4 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - 0) / var_427_4

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= 0 + var_427_4 and arg_424_1.time_ < 0 + var_427_4 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play424071103 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 424071103
		arg_428_1.duration_ = 5.83

		local var_428_0 = {
			zh = 4.6,
			ja = 5.833
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
				arg_428_0:Play424071104(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0.575

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037_split_1")

				arg_428_1.callingController_:SetSelectedState("calling")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_1 = arg_428_1:GetWordFromCfg(424071103)
				local var_431_2 = arg_428_1:FormatText(var_431_1.content)

				arg_428_1.text_.text = var_431_2

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_4 = 23 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_2) / 23)

				if (23 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_2) / 23)) > 0 and var_431_0 < var_431_4 then
					arg_428_1.talkMaxDuration = var_431_4

					if var_431_4 + 0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_4 + 0
					end
				end

				arg_428_1.text_.text = var_431_2
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071103", "story_v_out_424071.awb") ~= 0 then
					local var_431_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071103", "story_v_out_424071.awb") / 1000

					if var_431_5 + 0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_5 + 0
					end

					if var_431_1.prefab_name ~= "" and arg_428_1.actors_[var_431_1.prefab_name] ~= nil then
						local var_431_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_1.prefab_name].transform, "story_v_out_424071", "424071103", "story_v_out_424071.awb")

						arg_428_1:RecordAudio("424071103", var_431_6)
						arg_428_1:RecordAudio("424071103", var_431_6)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_424071", "424071103", "story_v_out_424071.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_424071", "424071103", "story_v_out_424071.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_7 = math.max(var_431_0, arg_428_1.talkMaxDuration)

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_7 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - 0) / var_431_7

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= 0 + var_431_7 and arg_428_1.time_ < 0 + var_431_7 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play424071104 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 424071104
		arg_432_1.duration_ = 5

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play424071105(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0.175

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, true)
				arg_432_1.iconController_:SetSelectedState("hero")

				arg_432_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_432_1.callingController_:SetSelectedState("normal")

				arg_432_1.keyicon_.color = Color.New(1, 1, 1)
				arg_432_1.icon_.color = Color.New(1, 1, 1)

				local var_435_1 = arg_432_1:FormatText(arg_432_1:GetWordFromCfg(424071104).content)

				arg_432_1.text_.text = var_435_1

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_3 = 7 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_1) / 7)

				if (7 <= 0 and var_435_0 or var_435_0 * (utf8.len(var_435_1) / 7)) > 0 and var_435_0 < var_435_3 then
					arg_432_1.talkMaxDuration = var_435_3

					if var_435_3 + 0 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_3 + 0
					end
				end

				arg_432_1.text_.text = var_435_1
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)
				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_4 = math.max(var_435_0, arg_432_1.talkMaxDuration)

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_4 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - 0) / var_435_4

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= 0 + var_435_4 and arg_432_1.time_ < 0 + var_435_4 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play424071105 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 424071105
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play424071106(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if arg_436_1.actors_["1111"] == nil then
				local var_439_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1111")

				if not isNil(var_439_0) then
					local var_439_1 = Object.Instantiate(var_439_0, arg_436_1.canvasGo_.transform)

					var_439_1.transform:SetSiblingIndex(1)

					var_439_1.name = "1111"
					var_439_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_436_1.actors_["1111"] = var_439_1

					if arg_436_1.isInRecall_ then
						for iter_439_0, iter_439_1 in ipairs((var_439_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_439_1.color = arg_436_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_439_2 = arg_436_1.actors_["1111"].transform

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				arg_436_1.var_.moveOldPos1111 = var_439_2.localPosition
				var_439_2.localScale = Vector3.New(1, 1, 1)

				arg_436_1:CheckSpriteTmpPos("1111", 7)

				for iter_439_2 = 0, var_439_2.childCount - 1 do
					local var_439_3 = var_439_2:GetChild(iter_439_2)

					if var_439_3.name == "" or not string.find(var_439_3.name, "split") then
						var_439_3.gameObject:SetActive(true)
					else
						var_439_3.gameObject:SetActive(false)
					end
				end
			end

			local var_439_4 = 0.001

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_4 then
				var_439_2.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos1111, Vector3.New(0, -2000, -350), (arg_436_1.time_ - 0) / var_439_4)
			end

			if arg_436_1.time_ >= 0 + var_439_4 and arg_436_1.time_ < 0 + var_439_4 + arg_439_0 then
				var_439_2.localPosition = Vector3.New(0, -2000, -350)
			end

			local var_439_5 = 0
			local var_439_6 = 0.575

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_5 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				arg_436_1.leftNameTxt_.text = arg_436_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, true)
				arg_436_1.iconController_:SetSelectedState("hero")

				arg_436_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_436_1.callingController_:SetSelectedState("normal")

				arg_436_1.keyicon_.color = Color.New(1, 1, 1)
				arg_436_1.icon_.color = Color.New(1, 1, 1)

				local var_439_7 = arg_436_1:FormatText(arg_436_1:GetWordFromCfg(424071105).content)

				arg_436_1.text_.text = var_439_7

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_9 = 23 <= 0 and var_439_6 or var_439_6 * (utf8.len(var_439_7) / 23)

				if (23 <= 0 and var_439_6 or var_439_6 * (utf8.len(var_439_7) / 23)) > 0 and var_439_6 < var_439_9 then
					arg_436_1.talkMaxDuration = var_439_9

					if var_439_9 + var_439_5 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_9 + var_439_5
					end
				end

				arg_436_1.text_.text = var_439_7
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_10 = math.max(var_439_6, arg_436_1.talkMaxDuration)

			if var_439_5 <= arg_436_1.time_ and arg_436_1.time_ < var_439_5 + var_439_10 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_5) / var_439_10

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_5 + var_439_10 and arg_436_1.time_ < var_439_5 + var_439_10 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111",
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
	Play424071106 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 424071106
		arg_440_1.duration_ = 5.4

		local var_440_0 = {
			zh = 3.1,
			ja = 5.4
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
				arg_440_0:Play424071107(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = 0.4

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, true)
				arg_440_1.iconController_:SetSelectedState("hero")

				arg_440_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_440_1.callingController_:SetSelectedState("normal")

				arg_440_1.keyicon_.color = Color.New(1, 1, 1)
				arg_440_1.icon_.color = Color.New(1, 1, 1)

				local var_443_1 = arg_440_1:GetWordFromCfg(424071106)
				local var_443_2 = arg_440_1:FormatText(var_443_1.content)

				arg_440_1.text_.text = var_443_2

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_4 = 16 <= 0 and var_443_0 or var_443_0 * (utf8.len(var_443_2) / 16)

				if (16 <= 0 and var_443_0 or var_443_0 * (utf8.len(var_443_2) / 16)) > 0 and var_443_0 < var_443_4 then
					arg_440_1.talkMaxDuration = var_443_4

					if var_443_4 + 0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_4 + 0
					end
				end

				arg_440_1.text_.text = var_443_2
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071106", "story_v_out_424071.awb") ~= 0 then
					local var_443_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071106", "story_v_out_424071.awb") / 1000

					if var_443_5 + 0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_5 + 0
					end

					if var_443_1.prefab_name ~= "" and arg_440_1.actors_[var_443_1.prefab_name] ~= nil then
						local var_443_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_1.prefab_name].transform, "story_v_out_424071", "424071106", "story_v_out_424071.awb")

						arg_440_1:RecordAudio("424071106", var_443_6)
						arg_440_1:RecordAudio("424071106", var_443_6)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_424071", "424071106", "story_v_out_424071.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_424071", "424071106", "story_v_out_424071.awb")
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
	Play424071107 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 424071107
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play424071108(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 1.4

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				arg_444_1.leftNameTxt_.text = arg_444_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, true)
				arg_444_1.iconController_:SetSelectedState("hero")

				arg_444_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_444_1.callingController_:SetSelectedState("normal")

				arg_444_1.keyicon_.color = Color.New(1, 1, 1)
				arg_444_1.icon_.color = Color.New(1, 1, 1)

				local var_447_1 = arg_444_1:FormatText(arg_444_1:GetWordFromCfg(424071107).content)

				arg_444_1.text_.text = var_447_1

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_3 = 56 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_1) / 56)

				if (56 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_1) / 56)) > 0 and var_447_0 < var_447_3 then
					arg_444_1.talkMaxDuration = var_447_3

					if var_447_3 + 0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_3 + 0
					end
				end

				arg_444_1.text_.text = var_447_1
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_4 = math.max(var_447_0, arg_444_1.talkMaxDuration)

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_4 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - 0) / var_447_4

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= 0 + var_447_4 and arg_444_1.time_ < 0 + var_447_4 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play424071108 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 424071108
		arg_448_1.duration_ = 2.77

		local var_448_0 = {
			zh = 2.066,
			ja = 2.766
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
				arg_448_0:Play424071109(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0.3

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, true)
				arg_448_1.iconController_:SetSelectedState("hero")

				arg_448_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_448_1.callingController_:SetSelectedState("normal")

				arg_448_1.keyicon_.color = Color.New(1, 1, 1)
				arg_448_1.icon_.color = Color.New(1, 1, 1)

				local var_451_1 = arg_448_1:GetWordFromCfg(424071108)
				local var_451_2 = arg_448_1:FormatText(var_451_1.content)

				arg_448_1.text_.text = var_451_2

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_4 = 12 <= 0 and var_451_0 or var_451_0 * (utf8.len(var_451_2) / 12)

				if (12 <= 0 and var_451_0 or var_451_0 * (utf8.len(var_451_2) / 12)) > 0 and var_451_0 < var_451_4 then
					arg_448_1.talkMaxDuration = var_451_4

					if var_451_4 + 0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_4 + 0
					end
				end

				arg_448_1.text_.text = var_451_2
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071108", "story_v_out_424071.awb") ~= 0 then
					local var_451_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071108", "story_v_out_424071.awb") / 1000

					if var_451_5 + 0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_5 + 0
					end

					if var_451_1.prefab_name ~= "" and arg_448_1.actors_[var_451_1.prefab_name] ~= nil then
						local var_451_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_1.prefab_name].transform, "story_v_out_424071", "424071108", "story_v_out_424071.awb")

						arg_448_1:RecordAudio("424071108", var_451_6)
						arg_448_1:RecordAudio("424071108", var_451_6)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_424071", "424071108", "story_v_out_424071.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_424071", "424071108", "story_v_out_424071.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_7 = math.max(var_451_0, arg_448_1.talkMaxDuration)

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_7 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - 0) / var_451_7

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= 0 + var_451_7 and arg_448_1.time_ < 0 + var_451_7 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play424071109 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 424071109
		arg_452_1.duration_ = 5

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play424071110(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = 1.2

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, true)
				arg_452_1.iconController_:SetSelectedState("hero")

				arg_452_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_452_1.callingController_:SetSelectedState("normal")

				arg_452_1.keyicon_.color = Color.New(1, 1, 1)
				arg_452_1.icon_.color = Color.New(1, 1, 1)

				local var_455_1 = arg_452_1:FormatText(arg_452_1:GetWordFromCfg(424071109).content)

				arg_452_1.text_.text = var_455_1

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_3 = 48 <= 0 and var_455_0 or var_455_0 * (utf8.len(var_455_1) / 48)

				if (48 <= 0 and var_455_0 or var_455_0 * (utf8.len(var_455_1) / 48)) > 0 and var_455_0 < var_455_3 then
					arg_452_1.talkMaxDuration = var_455_3

					if var_455_3 + 0 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_3 + 0
					end
				end

				arg_452_1.text_.text = var_455_1
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)
				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_4 = math.max(var_455_0, arg_452_1.talkMaxDuration)

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_4 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - 0) / var_455_4

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= 0 + var_455_4 and arg_452_1.time_ < 0 + var_455_4 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {}

		arg_452_1:InitPlayNodeList()
	end,
	Play424071110 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 424071110
		arg_456_1.duration_ = 4.13

		local var_456_0 = {
			zh = 3.533,
			ja = 4.133
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
				arg_456_0:Play424071111(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 and not isNil(arg_456_1.actors_["1094"]) and arg_456_1.var_.actorSpriteComps1094 == nil then
				arg_456_1.var_.actorSpriteComps1094 = arg_456_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_459_0 = 0.2

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_0 and not isNil(arg_456_1.actors_["1094"]) then
				if arg_456_1.var_.actorSpriteComps1094 then
					for iter_459_0, iter_459_1 in pairs(arg_456_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_456_1.time_ >= 0 + var_459_0 and arg_456_1.time_ < 0 + var_459_0 + arg_459_0 and not isNil(arg_456_1.actors_["1094"]) and arg_456_1.var_.actorSpriteComps1094 then
				for iter_459_2, iter_459_3 in pairs(arg_456_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_459_3 then
						iter_459_3.color = arg_456_1.isInRecall_ and (arg_456_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_456_1.var_.actorSpriteComps1094 = nil
			end

			local var_459_2 = arg_456_1.actors_["1094"].transform

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= 0 + arg_459_0 then
				arg_456_1.var_.moveOldPos1094 = var_459_2.localPosition
				var_459_2.localScale = Vector3.New(1, 1, 1)

				arg_456_1:CheckSpriteTmpPos("1094", 3)

				for iter_459_4 = 0, var_459_2.childCount - 1 do
					local var_459_3 = var_459_2:GetChild(iter_459_4)

					if var_459_3.name == "" or not string.find(var_459_3.name, "split") then
						var_459_3.gameObject:SetActive(true)
					else
						var_459_3.gameObject:SetActive(false)
					end
				end
			end

			local var_459_4 = 0.001

			if 0 <= arg_456_1.time_ and arg_456_1.time_ < 0 + var_459_4 then
				var_459_2.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_456_1.time_ - 0) / var_459_4)
			end

			if arg_456_1.time_ >= 0 + var_459_4 and arg_456_1.time_ < 0 + var_459_4 + arg_459_0 then
				var_459_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_459_5 = 0
			local var_459_6 = 0.3

			if 0 < arg_456_1.time_ and arg_456_1.time_ <= var_459_5 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, true)

				arg_456_1.leftNameTxt_.text = arg_456_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_456_1.leftNameTxt_.transform)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1.leftNameTxt_.text)
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_7 = arg_456_1:GetWordFromCfg(424071110)
				local var_459_8 = arg_456_1:FormatText(var_459_7.content)

				arg_456_1.text_.text = var_459_8

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_10 = 12 <= 0 and var_459_6 or var_459_6 * (utf8.len(var_459_8) / 12)

				if (12 <= 0 and var_459_6 or var_459_6 * (utf8.len(var_459_8) / 12)) > 0 and var_459_6 < var_459_10 then
					arg_456_1.talkMaxDuration = var_459_10

					if var_459_10 + var_459_5 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_10 + var_459_5
					end
				end

				arg_456_1.text_.text = var_459_8
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071110", "story_v_out_424071.awb") ~= 0 then
					local var_459_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071110", "story_v_out_424071.awb") / 1000

					if var_459_11 + var_459_5 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_11 + var_459_5
					end

					if var_459_7.prefab_name ~= "" and arg_456_1.actors_[var_459_7.prefab_name] ~= nil then
						local var_459_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_456_1.actors_[var_459_7.prefab_name].transform, "story_v_out_424071", "424071110", "story_v_out_424071.awb")

						arg_456_1:RecordAudio("424071110", var_459_12)
						arg_456_1:RecordAudio("424071110", var_459_12)
					else
						arg_456_1:AudioAction("play", "voice", "story_v_out_424071", "424071110", "story_v_out_424071.awb")
					end

					arg_456_1:RecordHistoryTalkVoice("story_v_out_424071", "424071110", "story_v_out_424071.awb")
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
				actorName = "1094",
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
	Play424071111 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 424071111
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play424071112(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			if 0 < arg_460_1.time_ and arg_460_1.time_ <= 0 + arg_463_0 and not isNil(arg_460_1.actors_["1094"]) and arg_460_1.var_.actorSpriteComps1094 == nil then
				arg_460_1.var_.actorSpriteComps1094 = arg_460_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_463_0 = 0.2

			if 0 <= arg_460_1.time_ and arg_460_1.time_ < 0 + var_463_0 and not isNil(arg_460_1.actors_["1094"]) then
				if arg_460_1.var_.actorSpriteComps1094 then
					for iter_463_0, iter_463_1 in pairs(arg_460_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_463_1 then
							if arg_460_1.isInRecall_ then
								iter_463_1.color = Color.New(Mathf.Lerp(iter_463_1.color.r, arg_460_1.hightColor2.r, (arg_460_1.time_ - 0) / var_463_0), Mathf.Lerp(iter_463_1.color.g, arg_460_1.hightColor2.g, (arg_460_1.time_ - 0) / var_463_0), (Mathf.Lerp(iter_463_1.color.b, arg_460_1.hightColor2.b, (arg_460_1.time_ - 0) / var_463_0)))
							else
								local var_463_1 = Mathf.Lerp(iter_463_1.color.r, 0.5, (arg_460_1.time_ - 0) / var_463_0)

								iter_463_1.color = Color.New(var_463_1, var_463_1, var_463_1)
							end
						end
					end
				end
			end

			if arg_460_1.time_ >= 0 + var_463_0 and arg_460_1.time_ < 0 + var_463_0 + arg_463_0 and not isNil(arg_460_1.actors_["1094"]) and arg_460_1.var_.actorSpriteComps1094 then
				for iter_463_2, iter_463_3 in pairs(arg_460_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_463_3 then
						iter_463_3.color = arg_460_1.isInRecall_ and (arg_460_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_460_1.var_.actorSpriteComps1094 = nil
			end

			local var_463_2 = 0
			local var_463_3 = 0.55

			if 0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_2 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, true)

				arg_460_1.leftNameTxt_.text = arg_460_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_460_1.leftNameTxt_.transform)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1.leftNameTxt_.text)
				SetActive(arg_460_1.iconTrs_.gameObject, true)
				arg_460_1.iconController_:SetSelectedState("hero")

				arg_460_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_460_1.callingController_:SetSelectedState("normal")

				arg_460_1.keyicon_.color = Color.New(1, 1, 1)
				arg_460_1.icon_.color = Color.New(1, 1, 1)

				local var_463_4 = arg_460_1:FormatText(arg_460_1:GetWordFromCfg(424071111).content)

				arg_460_1.text_.text = var_463_4

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_6 = 22 <= 0 and var_463_3 or var_463_3 * (utf8.len(var_463_4) / 22)

				if (22 <= 0 and var_463_3 or var_463_3 * (utf8.len(var_463_4) / 22)) > 0 and var_463_3 < var_463_6 then
					arg_460_1.talkMaxDuration = var_463_6

					if var_463_6 + var_463_2 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_6 + var_463_2
					end
				end

				arg_460_1.text_.text = var_463_4
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_7 = math.max(var_463_3, arg_460_1.talkMaxDuration)

			if var_463_2 <= arg_460_1.time_ and arg_460_1.time_ < var_463_2 + var_463_7 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_2) / var_463_7

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_2 + var_463_7 and arg_460_1.time_ < var_463_2 + var_463_7 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play424071112 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 424071112
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play424071113(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = 0.85

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, true)
				arg_464_1.iconController_:SetSelectedState("hero")

				arg_464_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_464_1.callingController_:SetSelectedState("normal")

				arg_464_1.keyicon_.color = Color.New(1, 1, 1)
				arg_464_1.icon_.color = Color.New(1, 1, 1)

				local var_467_1 = arg_464_1:FormatText(arg_464_1:GetWordFromCfg(424071112).content)

				arg_464_1.text_.text = var_467_1

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_3 = 34 <= 0 and var_467_0 or var_467_0 * (utf8.len(var_467_1) / 34)

				if (34 <= 0 and var_467_0 or var_467_0 * (utf8.len(var_467_1) / 34)) > 0 and var_467_0 < var_467_3 then
					arg_464_1.talkMaxDuration = var_467_3

					if var_467_3 + 0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_3 + 0
					end
				end

				arg_464_1.text_.text = var_467_1
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_4 = math.max(var_467_0, arg_464_1.talkMaxDuration)

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_4 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - 0) / var_467_4

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= 0 + var_467_4 and arg_464_1.time_ < 0 + var_467_4 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	Play424071113 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 424071113
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play424071114(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			local var_471_0 = 0.7

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, false)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_468_1.iconTrs_.gameObject, false)
				arg_468_1.callingController_:SetSelectedState("normal")

				local var_471_1 = arg_468_1:FormatText(arg_468_1:GetWordFromCfg(424071113).content)

				arg_468_1.text_.text = var_471_1

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_3 = 28 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_1) / 28)

				if (28 <= 0 and var_471_0 or var_471_0 * (utf8.len(var_471_1) / 28)) > 0 and var_471_0 < var_471_3 then
					arg_468_1.talkMaxDuration = var_471_3

					if var_471_3 + 0 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_3 + 0
					end
				end

				arg_468_1.text_.text = var_471_1
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_4 = math.max(var_471_0, arg_468_1.talkMaxDuration)

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_4 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - 0) / var_471_4

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= 0 + var_471_4 and arg_468_1.time_ < 0 + var_471_4 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play424071114 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 424071114
		arg_472_1.duration_ = 5.1

		local var_472_0 = {
			zh = 3.766,
			ja = 5.1
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
				arg_472_0:Play424071115(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			local var_475_0 = 0.475

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, true)
				arg_472_1.iconController_:SetSelectedState("hero")

				arg_472_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_472_1.callingController_:SetSelectedState("normal")

				arg_472_1.keyicon_.color = Color.New(1, 1, 1)
				arg_472_1.icon_.color = Color.New(1, 1, 1)

				local var_475_1 = arg_472_1:GetWordFromCfg(424071114)
				local var_475_2 = arg_472_1:FormatText(var_475_1.content)

				arg_472_1.text_.text = var_475_2

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_4 = 19 <= 0 and var_475_0 or var_475_0 * (utf8.len(var_475_2) / 19)

				if (19 <= 0 and var_475_0 or var_475_0 * (utf8.len(var_475_2) / 19)) > 0 and var_475_0 < var_475_4 then
					arg_472_1.talkMaxDuration = var_475_4

					if var_475_4 + 0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_4 + 0
					end
				end

				arg_472_1.text_.text = var_475_2
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071114", "story_v_out_424071.awb") ~= 0 then
					local var_475_5 = manager.audio:GetVoiceLength("story_v_out_424071", "424071114", "story_v_out_424071.awb") / 1000

					if var_475_5 + 0 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_5 + 0
					end

					if var_475_1.prefab_name ~= "" and arg_472_1.actors_[var_475_1.prefab_name] ~= nil then
						local var_475_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_1.prefab_name].transform, "story_v_out_424071", "424071114", "story_v_out_424071.awb")

						arg_472_1:RecordAudio("424071114", var_475_6)
						arg_472_1:RecordAudio("424071114", var_475_6)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_424071", "424071114", "story_v_out_424071.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_424071", "424071114", "story_v_out_424071.awb")
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
	Play424071115 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 424071115
		arg_476_1.duration_ = 5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play424071116(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_0 = 0.7

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0
				arg_476_1.dialogCg_.alpha = 1

				arg_476_1.dialog_:SetActive(true)
				SetActive(arg_476_1.leftNameGo_, true)

				arg_476_1.leftNameTxt_.text = arg_476_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_476_1.leftNameTxt_.transform)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1.leftNameTxt_.text)
				SetActive(arg_476_1.iconTrs_.gameObject, true)
				arg_476_1.iconController_:SetSelectedState("hero")

				arg_476_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_476_1.callingController_:SetSelectedState("normal")

				arg_476_1.keyicon_.color = Color.New(1, 1, 1)
				arg_476_1.icon_.color = Color.New(1, 1, 1)

				local var_479_1 = arg_476_1:FormatText(arg_476_1:GetWordFromCfg(424071115).content)

				arg_476_1.text_.text = var_479_1

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_3 = 28 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_1) / 28)

				if (28 <= 0 and var_479_0 or var_479_0 * (utf8.len(var_479_1) / 28)) > 0 and var_479_0 < var_479_3 then
					arg_476_1.talkMaxDuration = var_479_3

					if var_479_3 + 0 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_3 + 0
					end
				end

				arg_476_1.text_.text = var_479_1
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_4 = math.max(var_479_0, arg_476_1.talkMaxDuration)

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_4 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - 0) / var_479_4

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= 0 + var_479_4 and arg_476_1.time_ < 0 + var_479_4 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {}

		arg_476_1:InitPlayNodeList()
	end,
	Play424071116 = function(arg_480_0, arg_480_1)
		arg_480_1.time_ = 0
		arg_480_1.frameCnt_ = 0
		arg_480_1.state_ = "playing"
		arg_480_1.curTalkId_ = 424071116
		arg_480_1.duration_ = 1.4

		SetActive(arg_480_1.tipsGo_, false)

		function arg_480_1.onSingleLineFinish_()
			arg_480_1.onSingleLineUpdate_ = nil
			arg_480_1.onSingleLineFinish_ = nil
			arg_480_1.state_ = "waiting"
		end

		function arg_480_1.playNext_(arg_482_0)
			if arg_482_0 == 1 then
				arg_480_0:Play424071117(arg_480_1)
			end
		end

		function arg_480_1.onSingleLineUpdate_(arg_483_0)
			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 then
				arg_480_1.var_.moveOldPos1094 = arg_480_1.actors_["1094"].transform.localPosition
				arg_480_1.actors_["1094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_480_1:CheckSpriteTmpPos("1094", 3)

				for iter_483_0 = 0, arg_480_1.actors_["1094"].transform.childCount - 1 do
					local var_483_0 = arg_480_1.actors_["1094"].transform:GetChild(iter_483_0)

					if var_483_0.name == "split_4" then
						var_483_0:SetAsLastSibling()
						var_483_0.gameObject:SetActive(true)

						arg_480_1.var_.actorSpriteSplit1094 = var_483_0.gameObject:GetComponent(typeof(Image))

						arg_480_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_483_1 = 0.5

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_1 then
				arg_480_1.actors_["1094"].transform.localPosition = Vector3.Lerp(arg_480_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_480_1.time_ - 0) / var_483_1)

				if arg_480_1.var_.actorSpriteSplit1094 ~= nil then
					arg_480_1.var_.actorSpriteSplit1094:SetAlpha((arg_480_1.time_ - 0) / var_483_1)
				end
			end

			if arg_480_1.time_ >= 0 + var_483_1 and arg_480_1.time_ < 0 + var_483_1 + arg_483_0 then
				arg_480_1.actors_["1094"].transform.localPosition = Vector3.New(0, -335, -230)

				if arg_480_1.var_.actorSpriteSplit1094 ~= nil then
					arg_480_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_483_2 = arg_480_1.actors_["1094"]

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= 0 + arg_483_0 and not isNil(var_483_2) and arg_480_1.var_.actorSpriteComps1094 == nil then
				arg_480_1.var_.actorSpriteComps1094 = var_483_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_483_3 = 0.2

			if 0 <= arg_480_1.time_ and arg_480_1.time_ < 0 + var_483_3 and not isNil(var_483_2) then
				if arg_480_1.var_.actorSpriteComps1094 then
					for iter_483_1, iter_483_2 in pairs(arg_480_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_483_2 then
							if arg_480_1.isInRecall_ then
								iter_483_2.color = Color.New(Mathf.Lerp(iter_483_2.color.r, arg_480_1.hightColor1.r, (arg_480_1.time_ - 0) / var_483_3), Mathf.Lerp(iter_483_2.color.g, arg_480_1.hightColor1.g, (arg_480_1.time_ - 0) / var_483_3), (Mathf.Lerp(iter_483_2.color.b, arg_480_1.hightColor1.b, (arg_480_1.time_ - 0) / var_483_3)))
							else
								local var_483_4 = Mathf.Lerp(iter_483_2.color.r, 1, (arg_480_1.time_ - 0) / var_483_3)

								iter_483_2.color = Color.New(var_483_4, var_483_4, var_483_4)
							end
						end
					end
				end
			end

			if arg_480_1.time_ >= 0 + var_483_3 and arg_480_1.time_ < 0 + var_483_3 + arg_483_0 and not isNil(var_483_2) and arg_480_1.var_.actorSpriteComps1094 then
				for iter_483_3, iter_483_4 in pairs(arg_480_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_483_4 then
						iter_483_4.color = arg_480_1.isInRecall_ and (arg_480_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_480_1.var_.actorSpriteComps1094 = nil
			end

			local var_483_5 = 0
			local var_483_6 = 0.075

			if 0 < arg_480_1.time_ and arg_480_1.time_ <= var_483_5 + arg_483_0 then
				arg_480_1.talkMaxDuration = 0
				arg_480_1.dialogCg_.alpha = 1

				arg_480_1.dialog_:SetActive(true)
				SetActive(arg_480_1.leftNameGo_, true)

				arg_480_1.leftNameTxt_.text = arg_480_1:FormatText(StoryNameCfg[1403].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_480_1.leftNameTxt_.transform)

				arg_480_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_480_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_480_1:RecordName(arg_480_1.leftNameTxt_.text)
				SetActive(arg_480_1.iconTrs_.gameObject, true)
				arg_480_1.iconController_:SetSelectedState("hero")

				arg_480_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_480_1.callingController_:SetSelectedState("normal")

				arg_480_1.keyicon_.color = Color.New(1, 1, 1)
				arg_480_1.icon_.color = Color.New(1, 1, 1)

				local var_483_7 = arg_480_1:GetWordFromCfg(424071116)
				local var_483_8 = arg_480_1:FormatText(var_483_7.content)

				arg_480_1.text_.text = var_483_8

				LuaForUtil.ClearLinePrefixSymbol(arg_480_1.text_)

				local var_483_10 = 3 <= 0 and var_483_6 or var_483_6 * (utf8.len(var_483_8) / 3)

				if (3 <= 0 and var_483_6 or var_483_6 * (utf8.len(var_483_8) / 3)) > 0 and var_483_6 < var_483_10 then
					arg_480_1.talkMaxDuration = var_483_10

					if var_483_10 + var_483_5 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_10 + var_483_5
					end
				end

				arg_480_1.text_.text = var_483_8
				arg_480_1.typewritter.percent = 0

				arg_480_1.typewritter:SetDirty()
				arg_480_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424071", "424071116", "story_v_out_424071.awb") ~= 0 then
					local var_483_11 = manager.audio:GetVoiceLength("story_v_out_424071", "424071116", "story_v_out_424071.awb") / 1000

					if var_483_11 + var_483_5 > arg_480_1.duration_ then
						arg_480_1.duration_ = var_483_11 + var_483_5
					end

					if var_483_7.prefab_name ~= "" and arg_480_1.actors_[var_483_7.prefab_name] ~= nil then
						local var_483_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_480_1.actors_[var_483_7.prefab_name].transform, "story_v_out_424071", "424071116", "story_v_out_424071.awb")

						arg_480_1:RecordAudio("424071116", var_483_12)
						arg_480_1:RecordAudio("424071116", var_483_12)
					else
						arg_480_1:AudioAction("play", "voice", "story_v_out_424071", "424071116", "story_v_out_424071.awb")
					end

					arg_480_1:RecordHistoryTalkVoice("story_v_out_424071", "424071116", "story_v_out_424071.awb")
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

		arg_480_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_480_1:InitPlayNodeList()
	end,
	Play424071117 = function(arg_484_0, arg_484_1)
		arg_484_1.time_ = 0
		arg_484_1.frameCnt_ = 0
		arg_484_1.state_ = "playing"
		arg_484_1.curTalkId_ = 424071117
		arg_484_1.duration_ = 5

		SetActive(arg_484_1.tipsGo_, false)

		function arg_484_1.onSingleLineFinish_()
			arg_484_1.onSingleLineUpdate_ = nil
			arg_484_1.onSingleLineFinish_ = nil
			arg_484_1.state_ = "waiting"
			arg_484_1.auto_ = false
		end

		function arg_484_1.playNext_(arg_486_0)
			arg_484_1.onStoryFinished_()
		end

		function arg_484_1.onSingleLineUpdate_(arg_487_0)
			if 0 < arg_484_1.time_ and arg_484_1.time_ <= 0 + arg_487_0 and not isNil(arg_484_1.actors_["1094"]) and arg_484_1.var_.actorSpriteComps1094 == nil then
				arg_484_1.var_.actorSpriteComps1094 = arg_484_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_487_0 = 0.2

			if 0 <= arg_484_1.time_ and arg_484_1.time_ < 0 + var_487_0 and not isNil(arg_484_1.actors_["1094"]) then
				if arg_484_1.var_.actorSpriteComps1094 then
					for iter_487_0, iter_487_1 in pairs(arg_484_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_484_1.time_ >= 0 + var_487_0 and arg_484_1.time_ < 0 + var_487_0 + arg_487_0 and not isNil(arg_484_1.actors_["1094"]) and arg_484_1.var_.actorSpriteComps1094 then
				for iter_487_2, iter_487_3 in pairs(arg_484_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_487_3 then
						iter_487_3.color = arg_484_1.isInRecall_ and (arg_484_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_484_1.var_.actorSpriteComps1094 = nil
			end

			local var_487_2 = 0
			local var_487_3 = 0.425

			if 0 < arg_484_1.time_ and arg_484_1.time_ <= var_487_2 + arg_487_0 then
				arg_484_1.talkMaxDuration = 0
				arg_484_1.dialogCg_.alpha = 1

				arg_484_1.dialog_:SetActive(true)
				SetActive(arg_484_1.leftNameGo_, true)

				arg_484_1.leftNameTxt_.text = arg_484_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_484_1.leftNameTxt_.transform)

				arg_484_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_484_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_484_1:RecordName(arg_484_1.leftNameTxt_.text)
				SetActive(arg_484_1.iconTrs_.gameObject, true)
				arg_484_1.iconController_:SetSelectedState("hero")

				arg_484_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_484_1.callingController_:SetSelectedState("normal")

				arg_484_1.keyicon_.color = Color.New(1, 1, 1)
				arg_484_1.icon_.color = Color.New(1, 1, 1)

				local var_487_4 = arg_484_1:FormatText(arg_484_1:GetWordFromCfg(424071117).content)

				arg_484_1.text_.text = var_487_4

				LuaForUtil.ClearLinePrefixSymbol(arg_484_1.text_)

				local var_487_6 = 17 <= 0 and var_487_3 or var_487_3 * (utf8.len(var_487_4) / 17)

				if (17 <= 0 and var_487_3 or var_487_3 * (utf8.len(var_487_4) / 17)) > 0 and var_487_3 < var_487_6 then
					arg_484_1.talkMaxDuration = var_487_6

					if var_487_6 + var_487_2 > arg_484_1.duration_ then
						arg_484_1.duration_ = var_487_6 + var_487_2
					end
				end

				arg_484_1.text_.text = var_487_4
				arg_484_1.typewritter.percent = 0

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(false)
				arg_484_1:RecordContent(arg_484_1.text_.text)
			end

			local var_487_7 = math.max(var_487_3, arg_484_1.talkMaxDuration)

			if var_487_2 <= arg_484_1.time_ and arg_484_1.time_ < var_487_2 + var_487_7 then
				arg_484_1.typewritter.percent = (arg_484_1.time_ - var_487_2) / var_487_7

				arg_484_1.typewritter:SetDirty()
			end

			if arg_484_1.time_ >= var_487_2 + var_487_7 and arg_484_1.time_ < var_487_2 + var_487_7 + arg_487_0 then
				arg_484_1.typewritter.percent = 1

				arg_484_1.typewritter:SetDirty()
				arg_484_1:ShowNextGo(true)
			end
		end

		arg_484_1.nodeConfigList_ = {}

		arg_484_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST0115a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/I11r",
		"TextureConfig/Background/ST0115"
	},
	voices = {
		"story_v_out_424071.awb"
	}
}
