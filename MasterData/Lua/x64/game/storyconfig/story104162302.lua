return {
	Play416232001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416232001
		arg_1_1.duration_ = 6.8

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play416232002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F09f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F09f")
				var_4_0.name = "F09f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F09f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F09f

				arg_1_1.bgs_.F09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F09f" then
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

			if 0.466666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.466666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_8_story_tide_battle", "bgm_activity_3_8_story_tide_battle")

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

			if 0.8 < arg_1_1.time_ and arg_1_1.time_ <= 0.8 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_138", "se_story_138_lasergun", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 1.8
			local var_4_17 = 1.4

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(416232001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 56 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 56)

				if (56 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 56)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play416232002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 416232002
		arg_9_1.duration_ = 4.6

		local var_9_0 = {
			zh = 3.266,
			ja = 4.6
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
				arg_9_0:Play416232003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10127"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10127")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "10127"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["10127"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["10127"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps10127 == nil then
				arg_9_1.var_.actorSpriteComps10127 = var_12_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_3 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_3 and not isNil(var_12_2) then
				if arg_9_1.var_.actorSpriteComps10127 then
					for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_12_3 then
							if arg_9_1.isInRecall_ then
								iter_12_3.color = Color.New(Mathf.Lerp(iter_12_3.color.r, arg_9_1.hightColor1.r, (arg_9_1.time_ - 0) / var_12_3), Mathf.Lerp(iter_12_3.color.g, arg_9_1.hightColor1.g, (arg_9_1.time_ - 0) / var_12_3), (Mathf.Lerp(iter_12_3.color.b, arg_9_1.hightColor1.b, (arg_9_1.time_ - 0) / var_12_3)))
							else
								local var_12_4 = Mathf.Lerp(iter_12_3.color.r, 1, (arg_9_1.time_ - 0) / var_12_3)

								iter_12_3.color = Color.New(var_12_4, var_12_4, var_12_4)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_3 and arg_9_1.time_ < 0 + var_12_3 + arg_12_0 and not isNil(var_12_2) and arg_9_1.var_.actorSpriteComps10127 then
				for iter_12_4, iter_12_5 in pairs(arg_9_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_12_5 then
						iter_12_5.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps10127 = nil
			end

			local var_12_5 = arg_9_1.actors_["10127"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10127 = var_12_5.localPosition
				var_12_5.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10127", 2)

				for iter_12_6 = 0, var_12_5.childCount - 1 do
					local var_12_6 = var_12_5:GetChild(iter_12_6)

					if var_12_6.name == "" or not string.find(var_12_6.name, "split") then
						var_12_6.gameObject:SetActive(true)
					else
						var_12_6.gameObject:SetActive(false)
					end
				end
			end

			local var_12_7 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10127, Vector3.New(-390, -387.4, -316.5), (arg_9_1.time_ - 0) / var_12_7)
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_12_8 = 0
			local var_12_9 = 0.475

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(416232002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 19 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 19)

				if (19 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 19)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232002", "story_v_out_416232.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_416232", "416232002", "story_v_out_416232.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_416232", "416232002", "story_v_out_416232.awb")

						arg_9_1:RecordAudio("416232002", var_12_15)
						arg_9_1:RecordAudio("416232002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_416232", "416232002", "story_v_out_416232.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_416232", "416232002", "story_v_out_416232.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
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
	Play416232003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 416232003
		arg_13_1.duration_ = 3.43

		local var_13_0 = {
			zh = 2.9,
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
				arg_13_0:Play416232004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["10122"] == nil then
				local var_16_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10122")

				if not isNil(var_16_0) then
					local var_16_1 = Object.Instantiate(var_16_0, arg_13_1.canvasGo_.transform)

					var_16_1.transform:SetSiblingIndex(1)

					var_16_1.name = "10122"
					var_16_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_["10122"] = var_16_1

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs((var_16_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_2 = arg_13_1.actors_["10122"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps10122 == nil then
				arg_13_1.var_.actorSpriteComps10122 = var_16_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_3 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.actorSpriteComps10122 then
					for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_16_3 then
							if arg_13_1.isInRecall_ then
								iter_16_3.color = Color.New(Mathf.Lerp(iter_16_3.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_3), Mathf.Lerp(iter_16_3.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_3), (Mathf.Lerp(iter_16_3.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_3)))
							else
								local var_16_4 = Mathf.Lerp(iter_16_3.color.r, 1, (arg_13_1.time_ - 0) / var_16_3)

								iter_16_3.color = Color.New(var_16_4, var_16_4, var_16_4)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps10122 then
				for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_16_5 then
						iter_16_5.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps10122 = nil
			end

			local var_16_5 = arg_13_1.actors_["10127"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps10127 == nil then
				arg_13_1.var_.actorSpriteComps10127 = var_16_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.actorSpriteComps10127 then
					for iter_16_6, iter_16_7 in pairs(arg_13_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_16_7 then
							if arg_13_1.isInRecall_ then
								iter_16_7.color = Color.New(Mathf.Lerp(iter_16_7.color.r, arg_13_1.hightColor2.r, (arg_13_1.time_ - 0) / var_16_6), Mathf.Lerp(iter_16_7.color.g, arg_13_1.hightColor2.g, (arg_13_1.time_ - 0) / var_16_6), (Mathf.Lerp(iter_16_7.color.b, arg_13_1.hightColor2.b, (arg_13_1.time_ - 0) / var_16_6)))
							else
								local var_16_7 = Mathf.Lerp(iter_16_7.color.r, 0.5, (arg_13_1.time_ - 0) / var_16_6)

								iter_16_7.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps10127 then
				for iter_16_8, iter_16_9 in pairs(arg_13_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_16_9 then
						iter_16_9.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps10127 = nil
			end

			local var_16_8 = arg_13_1.actors_["10122"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10122 = var_16_8.localPosition
				var_16_8.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10122", 4)

				for iter_16_10 = 0, var_16_8.childCount - 1 do
					local var_16_9 = var_16_8:GetChild(iter_16_10)

					if var_16_9.name == "" or not string.find(var_16_9.name, "split") then
						var_16_9.gameObject:SetActive(true)
					else
						var_16_9.gameObject:SetActive(false)
					end
				end
			end

			local var_16_10 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_10 then
				var_16_8.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10122, Vector3.New(390, -380, -100), (arg_13_1.time_ - 0) / var_16_10)
			end

			if arg_13_1.time_ >= 0 + var_16_10 and arg_13_1.time_ < 0 + var_16_10 + arg_16_0 then
				var_16_8.localPosition = Vector3.New(390, -380, -100)
			end

			local var_16_11 = 0
			local var_16_12 = 0.35

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_13 = arg_13_1:GetWordFromCfg(416232003)
				local var_16_14 = arg_13_1:FormatText(var_16_13.content)

				arg_13_1.text_.text = var_16_14

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_16 = 14 <= 0 and var_16_12 or var_16_12 * (utf8.len(var_16_14) / 14)

				if (14 <= 0 and var_16_12 or var_16_12 * (utf8.len(var_16_14) / 14)) > 0 and var_16_12 < var_16_16 then
					arg_13_1.talkMaxDuration = var_16_16

					if var_16_16 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_11
					end
				end

				arg_13_1.text_.text = var_16_14
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232003", "story_v_out_416232.awb") ~= 0 then
					local var_16_17 = manager.audio:GetVoiceLength("story_v_out_416232", "416232003", "story_v_out_416232.awb") / 1000

					if var_16_17 + var_16_11 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_11
					end

					if var_16_13.prefab_name ~= "" and arg_13_1.actors_[var_16_13.prefab_name] ~= nil then
						local var_16_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_13.prefab_name].transform, "story_v_out_416232", "416232003", "story_v_out_416232.awb")

						arg_13_1:RecordAudio("416232003", var_16_18)
						arg_13_1:RecordAudio("416232003", var_16_18)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_416232", "416232003", "story_v_out_416232.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_416232", "416232003", "story_v_out_416232.awb")
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
				actorName = "10122",
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
	Play416232004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 416232004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play416232005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10122"]) and arg_17_1.var_.actorSpriteComps10122 == nil then
				arg_17_1.var_.actorSpriteComps10122 = arg_17_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10122"]) then
				if arg_17_1.var_.actorSpriteComps10122 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								iter_20_1.color = Color.New(Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_0), Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_0), (Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_0)))
							else
								local var_20_1 = Mathf.Lerp(iter_20_1.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_0)

								iter_20_1.color = Color.New(var_20_1, var_20_1, var_20_1)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10122"]) and arg_17_1.var_.actorSpriteComps10122 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps10122 = nil
			end

			local var_20_2 = arg_17_1.actors_["10122"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10122 = var_20_2.localPosition
				var_20_2.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10122", 7)

				for iter_20_4 = 0, var_20_2.childCount - 1 do
					local var_20_3 = var_20_2:GetChild(iter_20_4)

					if var_20_3.name == "" or not string.find(var_20_3.name, "split") then
						var_20_3.gameObject:SetActive(true)
					else
						var_20_3.gameObject:SetActive(false)
					end
				end
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_2.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10122, Vector3.New(0, -2000, 0), (arg_17_1.time_ - 0) / var_20_4)
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_20_5 = arg_17_1.actors_["10127"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10127 = var_20_5.localPosition
				var_20_5.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10127", 7)

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
				var_20_5.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10127, Vector3.New(0, -2000, 0), (arg_17_1.time_ - 0) / var_20_7)
			end

			if arg_17_1.time_ >= 0 + var_20_7 and arg_17_1.time_ < 0 + var_20_7 + arg_20_0 then
				var_20_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_20_8 = 0
			local var_20_9 = 1.525

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

				local var_20_10 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(416232004).content)

				arg_17_1.text_.text = var_20_10

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_12 = 61 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_10) / 61)

				if (61 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_10) / 61)) > 0 and var_20_9 < var_20_12 then
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
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10127",
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
	Play416232005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 416232005
		arg_21_1.duration_ = 5.4

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play416232006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_24_0 = 0.4

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				local var_24_1, var_24_2 = math.modf((arg_21_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_24_2 * 0.13, var_24_2 * 0.13, var_24_2 * 0.13) + arg_21_1.var_.shakeOldPos
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				manager.ui.mainCamera.transform.localPosition = arg_21_1.var_.shakeOldPos
			end

			local var_24_3 = 0

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_3 + arg_24_0 then
				arg_21_1.allBtn_.enabled = false
			end

			if arg_21_1.time_ >= var_24_3 + 0.7 and arg_21_1.time_ < var_24_3 + 0.7 + arg_24_0 then
				arg_21_1.allBtn_.enabled = true
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:AudioAction("play", "effect", "se_story_15", "se_story_15_gun02", "")
			end

			if 1.9 < arg_21_1.time_ and arg_21_1.time_ <= 1.9 + arg_24_0 then
				arg_21_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_explosion", "")
			end

			if arg_21_1.frameCnt_ <= 1 then
				arg_21_1.dialog_:SetActive(false)
			end

			local var_24_6 = 0.4
			local var_24_7 = 1.15

			if 0.4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0

				arg_21_1.dialog_:SetActive(true)

				arg_21_1.dialogCg_.alpha = 0

				local var_24_8 = LeanTween.value(arg_21_1.dialog_, 0, 1, 0.3)

				var_24_8:setOnUpdate(LuaHelper.FloatAction(function(arg_25_0)
					arg_21_1.dialogCg_.alpha = arg_25_0
				end))
				var_24_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_21_1.dialog_)
					var_24_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_21_1.duration_ = arg_21_1.duration_ + 0.3

				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_9 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(416232005).content)

				arg_21_1.text_.text = var_24_9

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 46 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_9) / 46)

				if (46 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_9) / 46)) > 0 and var_24_7 < var_24_11 then
					arg_21_1.talkMaxDuration = var_24_11
					var_24_6 = var_24_6 + 0.3

					if var_24_11 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_9
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = var_24_6 + 0.3
			local var_24_13 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 + 0.3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_13 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_12) / var_24_13

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_12 + var_24_13 and arg_21_1.time_ < var_24_12 + var_24_13 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play416232006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 416232006
		arg_27_1.duration_ = 12.7

		local var_27_0 = {
			zh = 12.7,
			ja = 10.2
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play416232007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0.625

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_1 = arg_27_1:GetWordFromCfg(416232006)
				local var_30_2 = arg_27_1:FormatText(var_30_1.content)

				arg_27_1.text_.text = var_30_2

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_4 = 25 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 25)

				if (25 <= 0 and var_30_0 or var_30_0 * (utf8.len(var_30_2) / 25)) > 0 and var_30_0 < var_30_4 then
					arg_27_1.talkMaxDuration = var_30_4

					if var_30_4 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_4 + 0
					end
				end

				arg_27_1.text_.text = var_30_2
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232006", "story_v_out_416232.awb") ~= 0 then
					local var_30_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232006", "story_v_out_416232.awb") / 1000

					if var_30_5 + 0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_5 + 0
					end

					if var_30_1.prefab_name ~= "" and arg_27_1.actors_[var_30_1.prefab_name] ~= nil then
						local var_30_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_1.prefab_name].transform, "story_v_out_416232", "416232006", "story_v_out_416232.awb")

						arg_27_1:RecordAudio("416232006", var_30_6)
						arg_27_1:RecordAudio("416232006", var_30_6)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_416232", "416232006", "story_v_out_416232.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_416232", "416232006", "story_v_out_416232.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_7 = math.max(var_30_0, arg_27_1.talkMaxDuration)

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_7 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - 0) / var_30_7

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= 0 + var_30_7 and arg_27_1.time_ < 0 + var_30_7 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play416232007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 416232007
		arg_31_1.duration_ = 2.73

		local var_31_0 = {
			zh = 2.733,
			ja = 2.133
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
				arg_31_0:Play416232008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0.325

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, true)
				arg_31_1.iconController_:SetSelectedState("hero")

				arg_31_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10122_split_3")

				arg_31_1.callingController_:SetSelectedState("normal")

				arg_31_1.keyicon_.color = Color.New(1, 1, 1)
				arg_31_1.icon_.color = Color.New(1, 1, 1)

				local var_34_1 = arg_31_1:GetWordFromCfg(416232007)
				local var_34_2 = arg_31_1:FormatText(var_34_1.content)

				arg_31_1.text_.text = var_34_2

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_4 = 13 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 13)

				if (13 <= 0 and var_34_0 or var_34_0 * (utf8.len(var_34_2) / 13)) > 0 and var_34_0 < var_34_4 then
					arg_31_1.talkMaxDuration = var_34_4

					if var_34_4 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_4 + 0
					end
				end

				arg_31_1.text_.text = var_34_2
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232007", "story_v_out_416232.awb") ~= 0 then
					local var_34_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232007", "story_v_out_416232.awb") / 1000

					if var_34_5 + 0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + 0
					end

					if var_34_1.prefab_name ~= "" and arg_31_1.actors_[var_34_1.prefab_name] ~= nil then
						local var_34_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_1.prefab_name].transform, "story_v_out_416232", "416232007", "story_v_out_416232.awb")

						arg_31_1:RecordAudio("416232007", var_34_6)
						arg_31_1:RecordAudio("416232007", var_34_6)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_416232", "416232007", "story_v_out_416232.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_416232", "416232007", "story_v_out_416232.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_7 = math.max(var_34_0, arg_31_1.talkMaxDuration)

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_7 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - 0) / var_34_7

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= 0 + var_34_7 and arg_31_1.time_ < 0 + var_34_7 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play416232008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 416232008
		arg_35_1.duration_ = 5.83

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play416232009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if arg_35_1.actors_["10109"] == nil then
				local var_38_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10109")

				if not isNil(var_38_0) then
					local var_38_1 = Object.Instantiate(var_38_0, arg_35_1.canvasGo_.transform)

					var_38_1.transform:SetSiblingIndex(1)

					var_38_1.name = "10109"
					var_38_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_35_1.actors_["10109"] = var_38_1

					if arg_35_1.isInRecall_ then
						for iter_38_0, iter_38_1 in ipairs((var_38_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_38_1.color = arg_35_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_38_2 = arg_35_1.actors_["10109"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos10109 = var_38_2.localPosition
				var_38_2.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("10109", 7)

				for iter_38_2 = 0, var_38_2.childCount - 1 do
					local var_38_3 = var_38_2:GetChild(iter_38_2)

					if var_38_3.name == "" or not string.find(var_38_3.name, "split") then
						var_38_3.gameObject:SetActive(true)
					else
						var_38_3.gameObject:SetActive(false)
					end
				end
			end

			local var_38_4 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				var_38_2.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos10109, Vector3.New(0, -2000, 0), (arg_35_1.time_ - 0) / var_38_4)
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				var_38_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_38_5 = 0

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_5 + arg_38_0 then
				arg_35_1.mask_.enabled = true
				arg_35_1.mask_.raycastTarget = true

				arg_35_1:SetGaussion(false)
			end

			local var_38_6 = 0.366666666666667

			if var_38_5 <= arg_35_1.time_ and arg_35_1.time_ < var_38_5 + var_38_6 then
				local var_38_7 = Color.New(1, 1, 1)

				var_38_7.a = Mathf.Lerp(0, 1, (arg_35_1.time_ - var_38_5) / var_38_6)
				arg_35_1.mask_.color = var_38_7
			end

			if arg_35_1.time_ >= var_38_5 + var_38_6 and arg_35_1.time_ < var_38_5 + var_38_6 + arg_38_0 then
				local var_38_8 = Color.New(1, 1, 1)

				var_38_8.a = 1
				arg_35_1.mask_.color = var_38_8
			end

			local var_38_9 = 0.2

			if 0.2 < arg_35_1.time_ and arg_35_1.time_ <= var_38_9 + arg_38_0 then
				arg_35_1.mask_.enabled = true
				arg_35_1.mask_.raycastTarget = true

				arg_35_1:SetGaussion(false)
			end

			local var_38_10 = 0.466666666666667

			if var_38_9 <= arg_35_1.time_ and arg_35_1.time_ < var_38_9 + var_38_10 then
				local var_38_11 = Color.New(1, 1, 1)

				var_38_11.a = Mathf.Lerp(1, 0, (arg_35_1.time_ - var_38_9) / var_38_10)
				arg_35_1.mask_.color = var_38_11
			end

			if arg_35_1.time_ >= var_38_9 + var_38_10 and arg_35_1.time_ < var_38_9 + var_38_10 + arg_38_0 then
				local var_38_12 = Color.New(1, 1, 1)

				arg_35_1.mask_.enabled = false
				var_38_12.a = 0
				arg_35_1.mask_.color = var_38_12
			end

			if 0.933333333333333 < arg_35_1.time_ and arg_35_1.time_ <= 0.933333333333333 + arg_38_0 then
				arg_35_1:AudioAction("play", "effect", "se_story_9", "se_story_9_shoot", "")
			end

			if 1.556 < arg_35_1.time_ and arg_35_1.time_ <= 1.556 + arg_38_0 then
				arg_35_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_explosion", "")
			end

			if 0.8 < arg_35_1.time_ and arg_35_1.time_ <= 0.8 + arg_38_0 then
				arg_35_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_laser", "")
			end

			if arg_35_1.frameCnt_ <= 1 then
				arg_35_1.dialog_:SetActive(false)
			end

			local var_38_16 = 0.833333333333333
			local var_38_17 = 1.275

			if 0.833333333333333 < arg_35_1.time_ and arg_35_1.time_ <= var_38_16 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0

				arg_35_1.dialog_:SetActive(true)

				arg_35_1.dialogCg_.alpha = 0

				local var_38_18 = LeanTween.value(arg_35_1.dialog_, 0, 1, 0.3)

				var_38_18:setOnUpdate(LuaHelper.FloatAction(function(arg_39_0)
					arg_35_1.dialogCg_.alpha = arg_39_0
				end))
				var_38_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_35_1.dialog_)
					var_38_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_35_1.duration_ = arg_35_1.duration_ + 0.3

				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_19 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(416232008).content)

				arg_35_1.text_.text = var_38_19

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_21 = 51 <= 0 and var_38_17 or var_38_17 * (utf8.len(var_38_19) / 51)

				if (51 <= 0 and var_38_17 or var_38_17 * (utf8.len(var_38_19) / 51)) > 0 and var_38_17 < var_38_21 then
					arg_35_1.talkMaxDuration = var_38_21
					var_38_16 = var_38_16 + 0.3

					if var_38_21 + var_38_16 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_21 + var_38_16
					end
				end

				arg_35_1.text_.text = var_38_19
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_22 = var_38_16 + 0.3
			local var_38_23 = math.max(var_38_17, arg_35_1.talkMaxDuration)

			if var_38_16 + 0.3 <= arg_35_1.time_ and arg_35_1.time_ < var_38_22 + var_38_23 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_22) / var_38_23

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_22 + var_38_23 and arg_35_1.time_ < var_38_22 + var_38_23 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10109",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play416232009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 416232009
		arg_41_1.duration_ = 5.47

		local var_41_0 = {
			zh = 5.466,
			ja = 4.366
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
				arg_41_0:Play416232010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.525

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_1 = arg_41_1:GetWordFromCfg(416232009)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 21 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 21)

				if (21 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 21)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232009", "story_v_out_416232.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232009", "story_v_out_416232.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_416232", "416232009", "story_v_out_416232.awb")

						arg_41_1:RecordAudio("416232009", var_44_6)
						arg_41_1:RecordAudio("416232009", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_416232", "416232009", "story_v_out_416232.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_416232", "416232009", "story_v_out_416232.awb")
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
	Play416232010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 416232010
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play416232011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.925

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(416232010).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 37 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 37)

				if (37 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 37)) > 0 and var_48_0 < var_48_3 then
					arg_45_1.talkMaxDuration = var_48_3

					if var_48_3 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_3 + 0
					end
				end

				arg_45_1.text_.text = var_48_1
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_4 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_4

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play416232011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 416232011
		arg_49_1.duration_ = 5.9

		local var_49_0 = {
			zh = 3.233,
			ja = 5.9
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
				arg_49_0:Play416232012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.375

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_3")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(416232011)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 15 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 15)

				if (15 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 15)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232011", "story_v_out_416232.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232011", "story_v_out_416232.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_416232", "416232011", "story_v_out_416232.awb")

						arg_49_1:RecordAudio("416232011", var_52_6)
						arg_49_1:RecordAudio("416232011", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_416232", "416232011", "story_v_out_416232.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_416232", "416232011", "story_v_out_416232.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play416232012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 416232012
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play416232013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.325

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(416232012).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 53 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 53)

				if (53 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 53)) > 0 and var_56_0 < var_56_3 then
					arg_53_1.talkMaxDuration = var_56_3

					if var_56_3 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_3 + 0
					end
				end

				arg_53_1.text_.text = var_56_1
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_4 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_4 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_4

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_4 and arg_53_1.time_ < 0 + var_56_4 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play416232013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 416232013
		arg_57_1.duration_ = 5.63

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play416232014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_9000

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				local var_60_0 = arg_57_1.var_.effect144

				if not arg_57_1.var_.effect144 then
					var_60_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_60_0.name = "144"
					arg_57_1.var_.effect144 = var_60_0
				else
					var_60_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_60_0.transform.localPosition = Vector3.New(0, 0, 0.66)
				var_60_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_60_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_60_0, iter_60_1 in ipairs((var_60_0.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_60_1.transform.localScale = Vector3.New(iter_60_1.transform.localScale.x / var_60_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_60_1.transform.localScale.y / var_60_2, iter_60_1.transform.localScale.z)
				end
			end

			if 0.833333333333333 < arg_57_1.time_ and arg_57_1.time_ <= 0.833333333333333 + arg_60_0 then
				if arg_57_1.var_.effect144 then
					Object.Destroy(arg_57_1.var_.effect144)

					arg_57_1.var_.effect144 = nil
				end
			end

			if 0.166666666666667 < arg_57_1.time_ and arg_57_1.time_ <= 0.166666666666667 + arg_60_0 then
				local var_60_5 = arg_57_1.var_.effect778

				if not arg_57_1.var_.effect778 then
					var_60_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_60_5.name = "778"
					arg_57_1.var_.effect778 = var_60_5
				else
					var_60_5.transform:SetParent(var_60_9000)
				end

				var_60_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_60_5.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_60_7 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_60_2, iter_60_3 in ipairs((var_60_5.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_60_3.transform.localScale = Vector3.New(iter_60_3.transform.localScale.x / var_60_7 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_60_3.transform.localScale.y / var_60_7, iter_60_3.transform.localScale.z)
				end
			end

			if 0.5 < arg_57_1.time_ and arg_57_1.time_ <= 0.5 + arg_60_0 then
				if arg_57_1.var_.effect778 then
					Object.Destroy(arg_57_1.var_.effect778)

					arg_57_1.var_.effect778 = nil
				end
			end

			local var_60_10 = 0

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			if arg_57_1.time_ >= var_60_10 + 1.16666666666667 and arg_57_1.time_ < var_60_10 + 1.16666666666667 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:AudioAction("play", "effect", "se_story_127", "se_story_127_dart", "")
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_12 = 0.633333333332
			local var_60_13 = 1.05

			if 0.633333333332 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_14 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_14:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_15 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(416232013).content)

				arg_57_1.text_.text = var_60_15

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_17 = 42 <= 0 and var_60_13 or var_60_13 * (utf8.len(var_60_15) / 42)

				if (42 <= 0 and var_60_13 or var_60_13 * (utf8.len(var_60_15) / 42)) > 0 and var_60_13 < var_60_17 then
					arg_57_1.talkMaxDuration = var_60_17
					var_60_12 = var_60_12 + 0.3

					if var_60_17 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_17 + var_60_12
					end
				end

				arg_57_1.text_.text = var_60_15
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_18 = var_60_12 + 0.3
			local var_60_19 = math.max(var_60_13, arg_57_1.talkMaxDuration)

			if var_60_12 + 0.3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_18 + var_60_19 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_18) / var_60_19

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_18 + var_60_19 and arg_57_1.time_ < var_60_18 + var_60_19 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play416232014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 416232014
		arg_63_1.duration_ = 9.73

		local var_63_0 = {
			zh = 9.5,
			ja = 9.733
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
				arg_63_0:Play416232015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.75

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_3")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:GetWordFromCfg(416232014)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 30 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 30)

				if (30 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 30)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232014", "story_v_out_416232.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232014", "story_v_out_416232.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_416232", "416232014", "story_v_out_416232.awb")

						arg_63_1:RecordAudio("416232014", var_66_6)
						arg_63_1:RecordAudio("416232014", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_416232", "416232014", "story_v_out_416232.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_416232", "416232014", "story_v_out_416232.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play416232015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 416232015
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play416232016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.825

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(416232015).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 33 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 33)

				if (33 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 33)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play416232016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 416232016
		arg_71_1.duration_ = 7.6

		local var_71_0 = {
			zh = 5.9,
			ja = 7.6
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
				arg_71_0:Play416232017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0.625 < arg_71_1.time_ and arg_71_1.time_ <= 0.625 + arg_74_0 then
				local var_74_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_74_0 then
					var_74_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_74_0.radialBlurScale = 0
					var_74_0.radialBlurGradient = 1
					var_74_0.radialBlurIntensity = 1

					if nil then
						var_74_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_74_1 = 1.04166666666667

			if 0.625 <= arg_71_1.time_ and arg_71_1.time_ < 0.625 + var_74_1 then
				local var_74_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_74_2 then
					var_74_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_74_2.radialBlurScale = Mathf.Lerp(0, 0, (arg_71_1.time_ - 0.625) / var_74_1)
					var_74_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_71_1.time_ - 0.625) / var_74_1)
					var_74_2.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_71_1.time_ - 0.625) / var_74_1)
				end
			end

			if arg_71_1.time_ >= 0.625 + var_74_1 and arg_71_1.time_ < 0.625 + var_74_1 + arg_74_0 then
				local var_74_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_74_3 then
					var_74_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_74_3.radialBlurScale = 0
					var_74_3.radialBlurGradient = 1
					var_74_3.radialBlurIntensity = 1
				end
			end

			local var_74_4 = 0

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.allBtn_.enabled = false
			end

			if arg_71_1.time_ >= var_74_4 + 1.66666666666667 and arg_71_1.time_ < var_74_4 + 1.66666666666667 + arg_74_0 then
				arg_71_1.allBtn_.enabled = true
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			local var_74_6 = 0
			local var_74_7 = 0.625

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_5")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_8 = arg_71_1:GetWordFromCfg(416232016)
				local var_74_9 = arg_71_1:FormatText(var_74_8.content)

				arg_71_1.text_.text = var_74_9

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 25 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 25)

				if (25 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 25)) > 0 and var_74_7 < var_74_11 then
					arg_71_1.talkMaxDuration = var_74_11

					if var_74_11 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_9
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232016", "story_v_out_416232.awb") ~= 0 then
					local var_74_12 = manager.audio:GetVoiceLength("story_v_out_416232", "416232016", "story_v_out_416232.awb") / 1000

					if var_74_12 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_6
					end

					if var_74_8.prefab_name ~= "" and arg_71_1.actors_[var_74_8.prefab_name] ~= nil then
						local var_74_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_8.prefab_name].transform, "story_v_out_416232", "416232016", "story_v_out_416232.awb")

						arg_71_1:RecordAudio("416232016", var_74_13)
						arg_71_1:RecordAudio("416232016", var_74_13)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_416232", "416232016", "story_v_out_416232.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_416232", "416232016", "story_v_out_416232.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_14 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_14 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_14

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_14 and arg_71_1.time_ < var_74_6 + var_74_14 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play416232017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 416232017
		arg_75_1.duration_ = 12.07

		local var_75_0 = {
			zh = 6.866,
			ja = 12.066
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play416232018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if arg_75_1.bgs_.STblack == nil then
				local var_78_0 = Object.Instantiate(arg_75_1.paintGo_)

				var_78_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_78_0.name = "STblack"
				var_78_0.transform.parent = arg_75_1.stage_.transform
				var_78_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.bgs_.STblack = var_78_0
			end

			if 1.2 < arg_75_1.time_ and arg_75_1.time_ <= 1.2 + arg_78_0 then
				local var_78_1 = arg_75_1.bgs_.STblack

				arg_75_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_78_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_78_2 = var_78_1:GetComponent("SpriteRenderer")

				if var_78_2 and var_78_2.sprite then
					local var_78_3 = 2 * (var_78_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_78_1.transform.localScale = Vector3.New(var_78_3 / var_78_2.sprite.bounds.size.y < var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x and var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x or var_78_3 / var_78_2.sprite.bounds.size.y, var_78_3 / var_78_2.sprite.bounds.size.y < var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x and var_78_3 * manager.ui.mainCameraCom_.aspect / var_78_2.sprite.bounds.size.x or var_78_3 / var_78_2.sprite.bounds.size.y, 0)
				end

				for iter_78_0, iter_78_1 in pairs(arg_75_1.bgs_) do
					if iter_78_0 ~= "STblack" then
						iter_78_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_78_4 = 1.2

			if 1.2 < arg_75_1.time_ and arg_75_1.time_ <= var_78_4 + arg_78_0 then
				arg_75_1.allBtn_.enabled = false
			end

			if arg_75_1.time_ >= var_78_4 + 0.3 and arg_75_1.time_ < var_78_4 + 0.3 + arg_78_0 then
				arg_75_1.allBtn_.enabled = true
			end

			local var_78_5 = 0

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_6 = 1.2

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_6 then
				local var_78_7 = Color.New(0, 0, 0)

				var_78_7.a = Mathf.Lerp(0, 1, (arg_75_1.time_ - var_78_5) / var_78_6)
				arg_75_1.mask_.color = var_78_7
			end

			if arg_75_1.time_ >= var_78_5 + var_78_6 and arg_75_1.time_ < var_78_5 + var_78_6 + arg_78_0 then
				local var_78_8 = Color.New(0, 0, 0)

				var_78_8.a = 1
				arg_75_1.mask_.color = var_78_8
			end

			local var_78_9 = 1.2

			if 1.2 < arg_75_1.time_ and arg_75_1.time_ <= var_78_9 + arg_78_0 then
				arg_75_1.mask_.enabled = true
				arg_75_1.mask_.raycastTarget = true

				arg_75_1:SetGaussion(false)
			end

			local var_78_10 = 1.36666666666667

			if var_78_9 <= arg_75_1.time_ and arg_75_1.time_ < var_78_9 + var_78_10 then
				local var_78_11 = Color.New(0, 0, 0)

				var_78_11.a = Mathf.Lerp(1, 0, (arg_75_1.time_ - var_78_9) / var_78_10)
				arg_75_1.mask_.color = var_78_11
			end

			if arg_75_1.time_ >= var_78_9 + var_78_10 and arg_75_1.time_ < var_78_9 + var_78_10 + arg_78_0 then
				local var_78_12 = Color.New(0, 0, 0)

				arg_75_1.mask_.enabled = false
				var_78_12.a = 0
				arg_75_1.mask_.color = var_78_12
			end

			local var_78_13

			if 1.2 < arg_75_1.time_ and arg_75_1.time_ <= 1.2 + arg_78_0 then
				local var_78_14 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_78_14 then
					var_78_14.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_78_14.radialBlurScale = 0
					var_78_14.radialBlurGradient = 1
					var_78_14.radialBlurIntensity = 1

					if var_78_13 then
						var_78_14.radialBlurTarget = var_78_13.transform
					end
				end
			end

			local var_78_15 = 1.04166666666667

			if 1.2 <= arg_75_1.time_ and arg_75_1.time_ < 1.2 + var_78_15 then
				local var_78_16 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_78_16 then
					var_78_16.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_78_16.radialBlurScale = Mathf.Lerp(0, 0, (arg_75_1.time_ - 1.2) / var_78_15)
					var_78_16.radialBlurGradient = Mathf.Lerp(1, 1, (arg_75_1.time_ - 1.2) / var_78_15)
					var_78_16.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_75_1.time_ - 1.2) / var_78_15)
				end
			end

			if arg_75_1.time_ >= 1.2 + var_78_15 and arg_75_1.time_ < 1.2 + var_78_15 + arg_78_0 then
				local var_78_17 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_78_17 then
					var_78_17.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.Disabled
					var_78_17.radialBlurScale = 0
					var_78_17.radialBlurGradient = 1
					var_78_17.radialBlurIntensity = 1
				end
			end

			if arg_75_1.frameCnt_ <= 1 then
				arg_75_1.dialog_:SetActive(false)
			end

			local var_78_18 = 2.1
			local var_78_19 = 0.3

			if 2.1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_18 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0

				arg_75_1.dialog_:SetActive(true)

				arg_75_1.dialogCg_.alpha = 0

				local var_78_20 = LeanTween.value(arg_75_1.dialog_, 0, 1, 0.3)

				var_78_20:setOnUpdate(LuaHelper.FloatAction(function(arg_79_0)
					arg_75_1.dialogCg_.alpha = arg_79_0
				end))
				var_78_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_75_1.dialog_)
					var_78_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_75_1.duration_ = arg_75_1.duration_ + 0.3

				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_21 = arg_75_1:GetWordFromCfg(416232017)
				local var_78_22 = arg_75_1:FormatText(var_78_21.content)

				arg_75_1.text_.text = var_78_22

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_24 = 12 <= 0 and var_78_19 or var_78_19 * (utf8.len(var_78_22) / 12)

				if (12 <= 0 and var_78_19 or var_78_19 * (utf8.len(var_78_22) / 12)) > 0 and var_78_19 < var_78_24 then
					arg_75_1.talkMaxDuration = var_78_24
					var_78_18 = var_78_18 + 0.3

					if var_78_24 + var_78_18 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_24 + var_78_18
					end
				end

				arg_75_1.text_.text = var_78_22
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232017", "story_v_out_416232.awb") ~= 0 then
					local var_78_25 = manager.audio:GetVoiceLength("story_v_out_416232", "416232017", "story_v_out_416232.awb") / 1000

					if var_78_25 + var_78_18 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_25 + var_78_18
					end

					if var_78_21.prefab_name ~= "" and arg_75_1.actors_[var_78_21.prefab_name] ~= nil then
						local var_78_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_21.prefab_name].transform, "story_v_out_416232", "416232017", "story_v_out_416232.awb")

						arg_75_1:RecordAudio("416232017", var_78_26)
						arg_75_1:RecordAudio("416232017", var_78_26)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_416232", "416232017", "story_v_out_416232.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_416232", "416232017", "story_v_out_416232.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_27 = var_78_18 + 0.3
			local var_78_28 = math.max(var_78_19, arg_75_1.talkMaxDuration)

			if var_78_18 + 0.3 <= arg_75_1.time_ and arg_75_1.time_ < var_78_27 + var_78_28 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_27) / var_78_28

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_27 + var_78_28 and arg_75_1.time_ < var_78_27 + var_78_28 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play416232018 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 416232018
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play416232019(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 1.775

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_1 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(416232018).content)

				arg_81_1.text_.text = var_84_1

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_3 = 71 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 71)

				if (71 <= 0 and var_84_0 or var_84_0 * (utf8.len(var_84_1) / 71)) > 0 and var_84_0 < var_84_3 then
					arg_81_1.talkMaxDuration = var_84_3

					if var_84_3 + 0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_3 + 0
					end
				end

				arg_81_1.text_.text = var_84_1
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_4 = math.max(var_84_0, arg_81_1.talkMaxDuration)

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_4 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - 0) / var_84_4

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= 0 + var_84_4 and arg_81_1.time_ < 0 + var_84_4 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play416232019 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 416232019
		arg_85_1.duration_ = 6.7

		local var_85_0 = {
			zh = 6.7,
			ja = 6.633
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
				arg_85_0:Play416232020(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:AudioAction("stop", "effect", "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			local var_88_1 = 0
			local var_88_2 = 0.6

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_3 = arg_85_1:GetWordFromCfg(416232019)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_6 = 24 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 24)

				if (24 <= 0 and var_88_2 or var_88_2 * (utf8.len(var_88_4) / 24)) > 0 and var_88_2 < var_88_6 then
					arg_85_1.talkMaxDuration = var_88_6

					if var_88_6 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_6 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232019", "story_v_out_416232.awb") ~= 0 then
					local var_88_7 = manager.audio:GetVoiceLength("story_v_out_416232", "416232019", "story_v_out_416232.awb") / 1000

					if var_88_7 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_1
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_416232", "416232019", "story_v_out_416232.awb")

						arg_85_1:RecordAudio("416232019", var_88_8)
						arg_85_1:RecordAudio("416232019", var_88_8)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_416232", "416232019", "story_v_out_416232.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_416232", "416232019", "story_v_out_416232.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_9 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_9 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_9

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_9 and arg_85_1.time_ < var_88_1 + var_88_9 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play416232020 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 416232020
		arg_89_1.duration_ = 9.27

		local var_89_0 = {
			zh = 4.533,
			ja = 9.266
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
				arg_89_0:Play416232021(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.425

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:GetWordFromCfg(416232020)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 17 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 17)

				if (17 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 17)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232020", "story_v_out_416232.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232020", "story_v_out_416232.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_416232", "416232020", "story_v_out_416232.awb")

						arg_89_1:RecordAudio("416232020", var_92_6)
						arg_89_1:RecordAudio("416232020", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_416232", "416232020", "story_v_out_416232.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_416232", "416232020", "story_v_out_416232.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_7 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_7 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_7

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_7 and arg_89_1.time_ < 0 + var_92_7 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play416232021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 416232021
		arg_93_1.duration_ = 9.9

		local var_93_0 = {
			zh = 9.9,
			ja = 6.166
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
				arg_93_0:Play416232022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.65

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:GetWordFromCfg(416232021)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 26 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 26)

				if (26 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 26)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232021", "story_v_out_416232.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232021", "story_v_out_416232.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_416232", "416232021", "story_v_out_416232.awb")

						arg_93_1:RecordAudio("416232021", var_96_6)
						arg_93_1:RecordAudio("416232021", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_416232", "416232021", "story_v_out_416232.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_416232", "416232021", "story_v_out_416232.awb")
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
	Play416232022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 416232022
		arg_97_1.duration_ = 5.8

		local var_97_0 = {
			zh = 5.666,
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
				arg_97_0:Play416232023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.4

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_1 = arg_97_1:GetWordFromCfg(416232022)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 16 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 16)

				if (16 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 16)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232022", "story_v_out_416232.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232022", "story_v_out_416232.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_416232", "416232022", "story_v_out_416232.awb")

						arg_97_1:RecordAudio("416232022", var_100_6)
						arg_97_1:RecordAudio("416232022", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_416232", "416232022", "story_v_out_416232.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_416232", "416232022", "story_v_out_416232.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play416232023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 416232023
		arg_101_1.duration_ = 10.5

		local var_101_0 = {
			zh = 7.766,
			ja = 10.5
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
				arg_101_0:Play416232024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0.866666666666667 < arg_101_1.time_ and arg_101_1.time_ <= 0.866666666666667 + arg_104_0 then
				local var_104_0 = arg_101_1.bgs_.F09f

				arg_101_1.bgs_.F09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_104_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_1 = var_104_0:GetComponent("SpriteRenderer")

				if var_104_1 and var_104_1.sprite then
					local var_104_2 = 2 * (var_104_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_104_0.transform.localScale = Vector3.New(var_104_2 / var_104_1.sprite.bounds.size.y < var_104_2 * manager.ui.mainCameraCom_.aspect / var_104_1.sprite.bounds.size.x and var_104_2 * manager.ui.mainCameraCom_.aspect / var_104_1.sprite.bounds.size.x or var_104_2 / var_104_1.sprite.bounds.size.y, var_104_2 / var_104_1.sprite.bounds.size.y < var_104_2 * manager.ui.mainCameraCom_.aspect / var_104_1.sprite.bounds.size.x and var_104_2 * manager.ui.mainCameraCom_.aspect / var_104_1.sprite.bounds.size.x or var_104_2 / var_104_1.sprite.bounds.size.y, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "F09f" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_3 = 0.866666666666667

			if 0.866666666666667 < arg_101_1.time_ and arg_101_1.time_ <= var_104_3 + arg_104_0 then
				arg_101_1.allBtn_.enabled = false
			end

			if arg_101_1.time_ >= var_104_3 + 0.3 and arg_101_1.time_ < var_104_3 + 0.3 + arg_104_0 then
				arg_101_1.allBtn_.enabled = true
			end

			local var_104_4 = 0

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_5 = 0.866666666666667

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_5 then
				local var_104_6 = Color.New(0, 0, 0)

				var_104_6.a = Mathf.Lerp(0, 1, (arg_101_1.time_ - var_104_4) / var_104_5)
				arg_101_1.mask_.color = var_104_6
			end

			if arg_101_1.time_ >= var_104_4 + var_104_5 and arg_101_1.time_ < var_104_4 + var_104_5 + arg_104_0 then
				local var_104_7 = Color.New(0, 0, 0)

				var_104_7.a = 1
				arg_101_1.mask_.color = var_104_7
			end

			local var_104_8 = 0.866666666666667

			if 0.866666666666667 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_9 = 1.76666666666667

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_9 then
				local var_104_10 = Color.New(0, 0, 0)

				var_104_10.a = Mathf.Lerp(1, 0, (arg_101_1.time_ - var_104_8) / var_104_9)
				arg_101_1.mask_.color = var_104_10
			end

			if arg_101_1.time_ >= var_104_8 + var_104_9 and arg_101_1.time_ < var_104_8 + var_104_9 + arg_104_0 then
				local var_104_11 = Color.New(0, 0, 0)

				arg_101_1.mask_.enabled = false
				var_104_11.a = 0
				arg_101_1.mask_.color = var_104_11
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_12 = 2.3
			local var_104_13 = 0.45

			if 2.3 < arg_101_1.time_ and arg_101_1.time_ <= var_104_12 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_14 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_14:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_3")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_15 = arg_101_1:GetWordFromCfg(416232023)
				local var_104_16 = arg_101_1:FormatText(var_104_15.content)

				arg_101_1.text_.text = var_104_16

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_18 = 18 <= 0 and var_104_13 or var_104_13 * (utf8.len(var_104_16) / 18)

				if (18 <= 0 and var_104_13 or var_104_13 * (utf8.len(var_104_16) / 18)) > 0 and var_104_13 < var_104_18 then
					arg_101_1.talkMaxDuration = var_104_18
					var_104_12 = var_104_12 + 0.3

					if var_104_18 + var_104_12 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_18 + var_104_12
					end
				end

				arg_101_1.text_.text = var_104_16
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232023", "story_v_out_416232.awb") ~= 0 then
					local var_104_19 = manager.audio:GetVoiceLength("story_v_out_416232", "416232023", "story_v_out_416232.awb") / 1000

					if var_104_19 + var_104_12 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_19 + var_104_12
					end

					if var_104_15.prefab_name ~= "" and arg_101_1.actors_[var_104_15.prefab_name] ~= nil then
						local var_104_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_15.prefab_name].transform, "story_v_out_416232", "416232023", "story_v_out_416232.awb")

						arg_101_1:RecordAudio("416232023", var_104_20)
						arg_101_1:RecordAudio("416232023", var_104_20)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_416232", "416232023", "story_v_out_416232.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_416232", "416232023", "story_v_out_416232.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_21 = var_104_12 + 0.3
			local var_104_22 = math.max(var_104_13, arg_101_1.talkMaxDuration)

			if var_104_12 + 0.3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_21 + var_104_22 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_21) / var_104_22

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_21 + var_104_22 and arg_101_1.time_ < var_104_21 + var_104_22 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play416232024 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 416232024
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play416232025(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10127 = arg_107_1.actors_["10127"].transform.localPosition
				arg_107_1.actors_["10127"].transform.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10127", 7)

				for iter_110_0 = 0, arg_107_1.actors_["10127"].transform.childCount - 1 do
					local var_110_0 = arg_107_1.actors_["10127"].transform:GetChild(iter_110_0)

					if var_110_0.name == "" or not string.find(var_110_0.name, "split") then
						var_110_0.gameObject:SetActive(true)
					else
						var_110_0.gameObject:SetActive(false)
					end
				end
			end

			local var_110_1 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_1 then
				arg_107_1.actors_["10127"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10127, Vector3.New(0, -2000, 0), (arg_107_1.time_ - 0) / var_110_1)
			end

			if arg_107_1.time_ >= 0 + var_110_1 and arg_107_1.time_ < 0 + var_110_1 + arg_110_0 then
				arg_107_1.actors_["10127"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_110_2 = 0
			local var_110_3 = 1.3

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_2 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_4 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(416232024).content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_6 = 52 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_4) / 52)

				if (52 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_4) / 52)) > 0 and var_110_3 < var_110_6 then
					arg_107_1.talkMaxDuration = var_110_6

					if var_110_6 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_6 + var_110_2
					end
				end

				arg_107_1.text_.text = var_110_4
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_3, arg_107_1.talkMaxDuration)

			if var_110_2 <= arg_107_1.time_ and arg_107_1.time_ < var_110_2 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_2) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_2 + var_110_7 and arg_107_1.time_ < var_110_2 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play416232025 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 416232025
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play416232026(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 1.475

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(416232025).content)

				arg_111_1.text_.text = var_114_1

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_3 = 60 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 60)

				if (60 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_1) / 60)) > 0 and var_114_0 < var_114_3 then
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
	Play416232026 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 416232026
		arg_115_1.duration_ = 7.63

		local var_115_0 = {
			zh = 6.7,
			ja = 7.633
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
				arg_115_0:Play416232027(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["10127"]) and arg_115_1.var_.actorSpriteComps10127 == nil then
				arg_115_1.var_.actorSpriteComps10127 = arg_115_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_0 = 0.2

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["10127"]) then
				if arg_115_1.var_.actorSpriteComps10127 then
					for iter_118_0, iter_118_1 in pairs(arg_115_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["10127"]) and arg_115_1.var_.actorSpriteComps10127 then
				for iter_118_2, iter_118_3 in pairs(arg_115_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_118_3 then
						iter_118_3.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_115_1.var_.actorSpriteComps10127 = nil
			end

			local var_118_2 = arg_115_1.actors_["10127"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10127 = var_118_2.localPosition
				var_118_2.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10127", 3)

				for iter_118_4 = 0, var_118_2.childCount - 1 do
					local var_118_3 = var_118_2:GetChild(iter_118_4)

					if var_118_3.name == "split_1" or not string.find(var_118_3.name, "split") then
						var_118_3.gameObject:SetActive(true)
					else
						var_118_3.gameObject:SetActive(false)
					end
				end
			end

			local var_118_4 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_4 then
				var_118_2.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10127, Vector3.New(0, -387.4, -316.5), (arg_115_1.time_ - 0) / var_118_4)
			end

			if arg_115_1.time_ >= 0 + var_118_4 and arg_115_1.time_ < 0 + var_118_4 + arg_118_0 then
				var_118_2.localPosition = Vector3.New(0, -387.4, -316.5)
			end

			local var_118_5 = 0
			local var_118_6 = 0.65

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_7 = arg_115_1:GetWordFromCfg(416232026)
				local var_118_8 = arg_115_1:FormatText(var_118_7.content)

				arg_115_1.text_.text = var_118_8

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_10 = 26 <= 0 and var_118_6 or var_118_6 * (utf8.len(var_118_8) / 26)

				if (26 <= 0 and var_118_6 or var_118_6 * (utf8.len(var_118_8) / 26)) > 0 and var_118_6 < var_118_10 then
					arg_115_1.talkMaxDuration = var_118_10

					if var_118_10 + var_118_5 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_10 + var_118_5
					end
				end

				arg_115_1.text_.text = var_118_8
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232026", "story_v_out_416232.awb") ~= 0 then
					local var_118_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232026", "story_v_out_416232.awb") / 1000

					if var_118_11 + var_118_5 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_11 + var_118_5
					end

					if var_118_7.prefab_name ~= "" and arg_115_1.actors_[var_118_7.prefab_name] ~= nil then
						local var_118_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_7.prefab_name].transform, "story_v_out_416232", "416232026", "story_v_out_416232.awb")

						arg_115_1:RecordAudio("416232026", var_118_12)
						arg_115_1:RecordAudio("416232026", var_118_12)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_416232", "416232026", "story_v_out_416232.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_416232", "416232026", "story_v_out_416232.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_13 = math.max(var_118_6, arg_115_1.talkMaxDuration)

			if var_118_5 <= arg_115_1.time_ and arg_115_1.time_ < var_118_5 + var_118_13 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_5) / var_118_13

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_5 + var_118_13 and arg_115_1.time_ < var_118_5 + var_118_13 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
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
	Play416232027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 416232027
		arg_119_1.duration_ = 9

		local var_119_0 = {
			zh = 5.733,
			ja = 9
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
				arg_119_0:Play416232028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.475

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_1 = arg_119_1:GetWordFromCfg(416232027)
				local var_122_2 = arg_119_1:FormatText(var_122_1.content)

				arg_119_1.text_.text = var_122_2

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 19 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 19)

				if (19 <= 0 and var_122_0 or var_122_0 * (utf8.len(var_122_2) / 19)) > 0 and var_122_0 < var_122_4 then
					arg_119_1.talkMaxDuration = var_122_4

					if var_122_4 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_4 + 0
					end
				end

				arg_119_1.text_.text = var_122_2
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232027", "story_v_out_416232.awb") ~= 0 then
					local var_122_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232027", "story_v_out_416232.awb") / 1000

					if var_122_5 + 0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + 0
					end

					if var_122_1.prefab_name ~= "" and arg_119_1.actors_[var_122_1.prefab_name] ~= nil then
						local var_122_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_1.prefab_name].transform, "story_v_out_416232", "416232027", "story_v_out_416232.awb")

						arg_119_1:RecordAudio("416232027", var_122_6)
						arg_119_1:RecordAudio("416232027", var_122_6)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_416232", "416232027", "story_v_out_416232.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_416232", "416232027", "story_v_out_416232.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_0, arg_119_1.talkMaxDuration)

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - 0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play416232028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 416232028
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play416232029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["10127"]) and arg_123_1.var_.actorSpriteComps10127 == nil then
				arg_123_1.var_.actorSpriteComps10127 = arg_123_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_0 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["10127"]) then
				if arg_123_1.var_.actorSpriteComps10127 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["10127"]) and arg_123_1.var_.actorSpriteComps10127 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_126_3 then
						iter_126_3.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps10127 = nil
			end

			local var_126_2 = arg_123_1.actors_["10127"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10127 = var_126_2.localPosition
				var_126_2.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10127", 7)

				for iter_126_4 = 0, var_126_2.childCount - 1 do
					local var_126_3 = var_126_2:GetChild(iter_126_4)

					if var_126_3.name == "" or not string.find(var_126_3.name, "split") then
						var_126_3.gameObject:SetActive(true)
					else
						var_126_3.gameObject:SetActive(false)
					end
				end
			end

			local var_126_4 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				var_126_2.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10127, Vector3.New(0, -2000, 0), (arg_123_1.time_ - 0) / var_126_4)
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				var_126_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_126_5 = 0
			local var_126_6 = 1.625

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_7 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(416232028).content)

				arg_123_1.text_.text = var_126_7

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_9 = 65 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_7) / 65)

				if (65 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_7) / 65)) > 0 and var_126_6 < var_126_9 then
					arg_123_1.talkMaxDuration = var_126_9

					if var_126_9 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_5
					end
				end

				arg_123_1.text_.text = var_126_7
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_6, arg_123_1.talkMaxDuration)

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_5) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_5 + var_126_10 and arg_123_1.time_ < var_126_5 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
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
	Play416232029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 416232029
		arg_127_1.duration_ = 3.67

		local var_127_0 = {
			zh = 3.233,
			ja = 3.666
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
				arg_127_0:Play416232030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.225

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_6")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_1 = arg_127_1:GetWordFromCfg(416232029)
				local var_130_2 = arg_127_1:FormatText(var_130_1.content)

				arg_127_1.text_.text = var_130_2

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_4 = 9 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 9)

				if (9 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_2) / 9)) > 0 and var_130_0 < var_130_4 then
					arg_127_1.talkMaxDuration = var_130_4

					if var_130_4 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_4 + 0
					end
				end

				arg_127_1.text_.text = var_130_2
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232029", "story_v_out_416232.awb") ~= 0 then
					local var_130_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232029", "story_v_out_416232.awb") / 1000

					if var_130_5 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_5 + 0
					end

					if var_130_1.prefab_name ~= "" and arg_127_1.actors_[var_130_1.prefab_name] ~= nil then
						local var_130_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_1.prefab_name].transform, "story_v_out_416232", "416232029", "story_v_out_416232.awb")

						arg_127_1:RecordAudio("416232029", var_130_6)
						arg_127_1:RecordAudio("416232029", var_130_6)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_416232", "416232029", "story_v_out_416232.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_416232", "416232029", "story_v_out_416232.awb")
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
	Play416232030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 416232030
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play416232031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 1

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(416232030).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 40 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 40)

				if (40 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 40)) > 0 and var_134_0 < var_134_3 then
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
	Play416232031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 416232031
		arg_135_1.duration_ = 10

		local var_135_0 = {
			zh = 6.233,
			ja = 10
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
				arg_135_0:Play416232032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.425

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_1 = arg_135_1:GetWordFromCfg(416232031)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 17 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 17)

				if (17 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 17)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232031", "story_v_out_416232.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232031", "story_v_out_416232.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_out_416232", "416232031", "story_v_out_416232.awb")

						arg_135_1:RecordAudio("416232031", var_138_6)
						arg_135_1:RecordAudio("416232031", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_416232", "416232031", "story_v_out_416232.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_416232", "416232031", "story_v_out_416232.awb")
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
	Play416232032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 416232032
		arg_139_1.duration_ = 5.9

		local var_139_0 = {
			zh = 2.3,
			ja = 5.9
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
				arg_139_0:Play416232033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0.25

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_1")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_1 = arg_139_1:GetWordFromCfg(416232032)
				local var_142_2 = arg_139_1:FormatText(var_142_1.content)

				arg_139_1.text_.text = var_142_2

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_4 = 10 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 10)

				if (10 <= 0 and var_142_0 or var_142_0 * (utf8.len(var_142_2) / 10)) > 0 and var_142_0 < var_142_4 then
					arg_139_1.talkMaxDuration = var_142_4

					if var_142_4 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_4 + 0
					end
				end

				arg_139_1.text_.text = var_142_2
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232032", "story_v_out_416232.awb") ~= 0 then
					local var_142_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232032", "story_v_out_416232.awb") / 1000

					if var_142_5 + 0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_5 + 0
					end

					if var_142_1.prefab_name ~= "" and arg_139_1.actors_[var_142_1.prefab_name] ~= nil then
						local var_142_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_1.prefab_name].transform, "story_v_out_416232", "416232032", "story_v_out_416232.awb")

						arg_139_1:RecordAudio("416232032", var_142_6)
						arg_139_1:RecordAudio("416232032", var_142_6)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_416232", "416232032", "story_v_out_416232.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_416232", "416232032", "story_v_out_416232.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_0, arg_139_1.talkMaxDuration)

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - 0) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play416232033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 416232033
		arg_143_1.duration_ = 6.9

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play416232034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				local var_146_0 = arg_143_1.var_.effect799

				if not arg_143_1.var_.effect799 then
					var_146_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_146_0.name = "799"
					arg_143_1.var_.effect799 = var_146_0
				else
					var_146_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_146_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_146_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_146_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_146_0, iter_146_1 in ipairs((var_146_0.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_146_1.transform.localScale = Vector3.New(iter_146_1.transform.localScale.x / var_146_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_146_1.transform.localScale.y / var_146_2, iter_146_1.transform.localScale.z)
				end
			end

			if 2.09166666666667 < arg_143_1.time_ and arg_143_1.time_ <= 2.09166666666667 + arg_146_0 then
				if arg_143_1.var_.effect799 then
					Object.Destroy(arg_143_1.var_.effect799)

					arg_143_1.var_.effect799 = nil
				end
			end

			local var_146_5 = 0.5

			if 0.5 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 then
				arg_143_1.mask_.enabled = true
				arg_143_1.mask_.raycastTarget = true

				arg_143_1:SetGaussion(false)
			end

			local var_146_6 = 0.633333333333333

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

			local var_146_9 = 1.13333333333333

			if 1.13333333333333 < arg_143_1.time_ and arg_143_1.time_ <= var_146_9 + arg_146_0 then
				arg_143_1.mask_.enabled = true
				arg_143_1.mask_.raycastTarget = true

				arg_143_1:SetGaussion(false)
			end

			local var_146_10 = 1.5

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

			if 1.13333333333333 < arg_143_1.time_ and arg_143_1.time_ <= 1.13333333333333 + arg_146_0 then
				local var_146_13 = arg_143_1.bgs_.STblack

				arg_143_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_146_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_146_14 = var_146_13:GetComponent("SpriteRenderer")

				if var_146_14 and var_146_14.sprite then
					local var_146_15 = 2 * (var_146_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_146_13.transform.localScale = Vector3.New(var_146_15 / var_146_14.sprite.bounds.size.y < var_146_15 * manager.ui.mainCameraCom_.aspect / var_146_14.sprite.bounds.size.x and var_146_15 * manager.ui.mainCameraCom_.aspect / var_146_14.sprite.bounds.size.x or var_146_15 / var_146_14.sprite.bounds.size.y, var_146_15 / var_146_14.sprite.bounds.size.y < var_146_15 * manager.ui.mainCameraCom_.aspect / var_146_14.sprite.bounds.size.x and var_146_15 * manager.ui.mainCameraCom_.aspect / var_146_14.sprite.bounds.size.x or var_146_15 / var_146_14.sprite.bounds.size.y, 0)
				end

				for iter_146_2, iter_146_3 in pairs(arg_143_1.bgs_) do
					if iter_146_2 ~= "STblack" then
						iter_146_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.85833333333333 < arg_143_1.time_ and arg_143_1.time_ <= 1.85833333333333 + arg_146_0 then
				arg_143_1:AudioAction("play", "effect", "se_story_139", "se_story_139_lasergun", "")
			end

			if arg_143_1.frameCnt_ <= 1 then
				arg_143_1.dialog_:SetActive(false)
			end

			local var_146_17 = 1.9
			local var_146_18 = 1.325

			if 1.9 < arg_143_1.time_ and arg_143_1.time_ <= var_146_17 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0

				arg_143_1.dialog_:SetActive(true)

				arg_143_1.dialogCg_.alpha = 0

				local var_146_19 = LeanTween.value(arg_143_1.dialog_, 0, 1, 0.3)

				var_146_19:setOnUpdate(LuaHelper.FloatAction(function(arg_147_0)
					arg_143_1.dialogCg_.alpha = arg_147_0
				end))
				var_146_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_143_1.dialog_)
					var_146_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_143_1.duration_ = arg_143_1.duration_ + 0.3

				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_20 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(416232033).content)

				arg_143_1.text_.text = var_146_20

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_22 = 53 <= 0 and var_146_18 or var_146_18 * (utf8.len(var_146_20) / 53)

				if (53 <= 0 and var_146_18 or var_146_18 * (utf8.len(var_146_20) / 53)) > 0 and var_146_18 < var_146_22 then
					arg_143_1.talkMaxDuration = var_146_22
					var_146_17 = var_146_17 + 0.3

					if var_146_22 + var_146_17 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_22 + var_146_17
					end
				end

				arg_143_1.text_.text = var_146_20
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_23 = var_146_17 + 0.3
			local var_146_24 = math.max(var_146_18, arg_143_1.talkMaxDuration)

			if var_146_17 + 0.3 <= arg_143_1.time_ and arg_143_1.time_ < var_146_23 + var_146_24 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_23) / var_146_24

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_23 + var_146_24 and arg_143_1.time_ < var_146_23 + var_146_24 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play416232034 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 416232034
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play416232035(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 1.325

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

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(416232034).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 53 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 53)

				if (53 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 53)) > 0 and var_152_0 < var_152_3 then
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
	Play416232035 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 416232035
		arg_153_1.duration_ = 5.73

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play416232036(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if arg_153_1.bgs_.STwhite == nil then
				local var_156_0 = Object.Instantiate(arg_153_1.paintGo_)

				var_156_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_156_0.name = "STwhite"
				var_156_0.transform.parent = arg_153_1.stage_.transform
				var_156_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_153_1.bgs_.STwhite = var_156_0
			end

			if 1.26666666666667 < arg_153_1.time_ and arg_153_1.time_ <= 1.26666666666667 + arg_156_0 then
				local var_156_1 = arg_153_1.bgs_.STwhite

				arg_153_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_156_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_156_2 = var_156_1:GetComponent("SpriteRenderer")

				if var_156_2 and var_156_2.sprite then
					local var_156_3 = 2 * (var_156_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_156_1.transform.localScale = Vector3.New(var_156_3 / var_156_2.sprite.bounds.size.y < var_156_3 * manager.ui.mainCameraCom_.aspect / var_156_2.sprite.bounds.size.x and var_156_3 * manager.ui.mainCameraCom_.aspect / var_156_2.sprite.bounds.size.x or var_156_3 / var_156_2.sprite.bounds.size.y, var_156_3 / var_156_2.sprite.bounds.size.y < var_156_3 * manager.ui.mainCameraCom_.aspect / var_156_2.sprite.bounds.size.x and var_156_3 * manager.ui.mainCameraCom_.aspect / var_156_2.sprite.bounds.size.x or var_156_3 / var_156_2.sprite.bounds.size.y, 0)
				end

				for iter_156_0, iter_156_1 in pairs(arg_153_1.bgs_) do
					if iter_156_0 ~= "STwhite" then
						iter_156_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_156_4 = 1.26666666666667

			if 1.26666666666667 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.allBtn_.enabled = false
			end

			if arg_153_1.time_ >= var_156_4 + 0.3 and arg_153_1.time_ < var_156_4 + 0.3 + arg_156_0 then
				arg_153_1.allBtn_.enabled = true
			end

			local var_156_5 = 0

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_6 = 1.3

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_6 then
				local var_156_7 = Color.New(0, 0, 0)

				var_156_7.a = Mathf.Lerp(0, 1, (arg_153_1.time_ - var_156_5) / var_156_6)
				arg_153_1.mask_.color = var_156_7
			end

			if arg_153_1.time_ >= var_156_5 + var_156_6 and arg_153_1.time_ < var_156_5 + var_156_6 + arg_156_0 then
				local var_156_8 = Color.New(0, 0, 0)

				var_156_8.a = 1
				arg_153_1.mask_.color = var_156_8
			end

			local var_156_9 = 1.3

			if 1.3 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 then
				arg_153_1.mask_.enabled = true
				arg_153_1.mask_.raycastTarget = true

				arg_153_1:SetGaussion(false)
			end

			local var_156_10 = 2

			if var_156_9 <= arg_153_1.time_ and arg_153_1.time_ < var_156_9 + var_156_10 then
				local var_156_11 = Color.New(0, 0, 0)

				var_156_11.a = Mathf.Lerp(1, 0, (arg_153_1.time_ - var_156_9) / var_156_10)
				arg_153_1.mask_.color = var_156_11
			end

			if arg_153_1.time_ >= var_156_9 + var_156_10 and arg_153_1.time_ < var_156_9 + var_156_10 + arg_156_0 then
				local var_156_12 = Color.New(0, 0, 0)

				arg_153_1.mask_.enabled = false
				var_156_12.a = 0
				arg_153_1.mask_.color = var_156_12
			end

			local var_156_13 = arg_153_1.actors_["10127"]

			if 1.26666666666667 < arg_153_1.time_ and arg_153_1.time_ <= 1.26666666666667 + arg_156_0 and not isNil(var_156_13) and arg_153_1.var_.actorSpriteComps10127 == nil then
				arg_153_1.var_.actorSpriteComps10127 = var_156_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_14 = 0.2

			if 1.26666666666667 <= arg_153_1.time_ and arg_153_1.time_ < 1.26666666666667 + var_156_14 and not isNil(var_156_13) then
				if arg_153_1.var_.actorSpriteComps10127 then
					for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_156_3 then
							if arg_153_1.isInRecall_ then
								iter_156_3.color = Color.New(Mathf.Lerp(iter_156_3.color.r, arg_153_1.hightColor1.r, (arg_153_1.time_ - 1.26666666666667) / var_156_14), Mathf.Lerp(iter_156_3.color.g, arg_153_1.hightColor1.g, (arg_153_1.time_ - 1.26666666666667) / var_156_14), (Mathf.Lerp(iter_156_3.color.b, arg_153_1.hightColor1.b, (arg_153_1.time_ - 1.26666666666667) / var_156_14)))
							else
								local var_156_15 = Mathf.Lerp(iter_156_3.color.r, 1, (arg_153_1.time_ - 1.26666666666667) / var_156_14)

								iter_156_3.color = Color.New(var_156_15, var_156_15, var_156_15)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 1.26666666666667 + var_156_14 and arg_153_1.time_ < 1.26666666666667 + var_156_14 + arg_156_0 and not isNil(var_156_13) and arg_153_1.var_.actorSpriteComps10127 then
				for iter_156_4, iter_156_5 in pairs(arg_153_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_156_5 then
						iter_156_5.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps10127 = nil
			end

			if 1.26666666666667 < arg_153_1.time_ and arg_153_1.time_ <= 1.26666666666667 + arg_156_0 then
				arg_153_1.fswbg_:SetActive(true)
				arg_153_1.dialog_:SetActive(false)

				arg_153_1.fswtw_.percent = 0
				arg_153_1.fswt_.text = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(416232035).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.fswt_)

				arg_153_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_153_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_153_1.fswtw_:SetDirty()

				arg_153_1.typewritterCharCountI18N = 0

				SetActive(arg_153_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_153_1:ShowNextGo(false)
			end

			local var_156_16 = 2.03333333333333

			if 2.03333333333333 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 then
				arg_153_1.var_.oldValueTypewriter = arg_153_1.fswtw_.percent

				SetActive(arg_153_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_153_1:ShowNextGo(false)
			end

			local var_156_17 = 10
			local var_156_18 = 0.666666666666667
			local var_156_19, var_156_20 = arg_153_1:GetPercentByPara(arg_153_1:FormatText(arg_153_1:GetWordFromCfg(416232035).content), 1)

			if var_156_16 < arg_153_1.time_ and arg_153_1.time_ <= var_156_16 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				local var_156_21 = var_156_17 <= 0 and var_156_18 or var_156_18 * ((var_156_20 - arg_153_1.typewritterCharCountI18N) / var_156_17)

				if (var_156_17 <= 0 and var_156_18 or var_156_18 * ((var_156_20 - arg_153_1.typewritterCharCountI18N) / var_156_17)) > 0 and var_156_18 < var_156_21 then
					arg_153_1.talkMaxDuration = var_156_21

					if var_156_21 + var_156_16 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_21 + var_156_16
					end
				end
			end

			local var_156_22 = math.max(0.666666666666667, arg_153_1.talkMaxDuration)

			if var_156_16 <= arg_153_1.time_ and arg_153_1.time_ < var_156_16 + var_156_22 then
				arg_153_1.fswtw_.percent = Mathf.Lerp(arg_153_1.var_.oldValueTypewriter, var_156_19, (arg_153_1.time_ - var_156_16) / var_156_22)
				arg_153_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_153_1.fswtw_:SetDirty()
			end

			if arg_153_1.time_ >= var_156_16 + var_156_22 and arg_153_1.time_ < var_156_16 + var_156_22 + arg_156_0 then
				arg_153_1.fswtw_.percent = var_156_19

				arg_153_1.fswtw_:SetDirty()
				arg_153_1:ShowNextGo(true)

				arg_153_1.typewritterCharCountI18N = var_156_20
			end

			local var_156_23 = 2.3

			if 2.3 < arg_153_1.time_ and arg_153_1.time_ <= var_156_23 + arg_156_0 then
				arg_153_1.var_.oldValueTypewriter = arg_153_1.fswtw_.percent

				SetActive(arg_153_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_153_1:ShowNextGo(false)
			end

			local var_156_24 = 0
			local var_156_25 = 0
			local var_156_26, var_156_27 = arg_153_1:GetPercentByPara(arg_153_1:FormatText(arg_153_1:GetWordFromCfg(416232035).content), 1)

			if var_156_23 < arg_153_1.time_ and arg_153_1.time_ <= var_156_23 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				local var_156_28 = var_156_24 <= 0 and var_156_25 or var_156_25 * ((var_156_27 - arg_153_1.typewritterCharCountI18N) / var_156_24)

				if (var_156_24 <= 0 and var_156_25 or var_156_25 * ((var_156_27 - arg_153_1.typewritterCharCountI18N) / var_156_24)) > 0 and var_156_25 < var_156_28 then
					arg_153_1.talkMaxDuration = var_156_28

					if var_156_28 + var_156_23 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_28 + var_156_23
					end
				end
			end

			local var_156_29 = math.max(0, arg_153_1.talkMaxDuration)

			if var_156_23 <= arg_153_1.time_ and arg_153_1.time_ < var_156_23 + var_156_29 then
				arg_153_1.fswtw_.percent = Mathf.Lerp(arg_153_1.var_.oldValueTypewriter, var_156_26, (arg_153_1.time_ - var_156_23) / var_156_29)
				arg_153_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_153_1.fswtw_:SetDirty()
			end

			if arg_153_1.time_ >= var_156_23 + var_156_29 and arg_153_1.time_ < var_156_23 + var_156_29 + arg_156_0 then
				arg_153_1.fswtw_.percent = var_156_26

				arg_153_1.fswtw_:SetDirty()
				arg_153_1:ShowNextGo(true)

				arg_153_1.typewritterCharCountI18N = var_156_27
			end

			if 1.28333333333333 < arg_153_1.time_ and arg_153_1.time_ <= 1.28333333333333 + arg_156_0 then
				local var_156_30 = arg_153_1.fswbg_.transform:Find("textbox/adapt/content") or arg_153_1.fswbg_.transform:Find("textbox/content")
				local var_156_31 = arg_153_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_156_32 = var_156_30:GetComponent("RectTransform")

				var_156_30:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_156_32.offsetMin = Vector2.New(0, 0)
				var_156_32.offsetMax = Vector2.New(0, -53.2)
			end

			local var_156_33 = 1.86666666666667
			local var_156_34 = manager.audio:GetVoiceLength("story_v_out_416232", "416232035", "") / 1000

			if var_156_34 > 0 and 3.866 < var_156_34 and var_156_34 + var_156_33 > arg_153_1.duration_ then
				arg_153_1.duration_ = var_156_34 + var_156_33
			end

			if var_156_33 < arg_153_1.time_ and arg_153_1.time_ <= var_156_33 + arg_156_0 then
				arg_153_1:AudioAction("play", "voice", "story_v_out_416232", "416232035", "")
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play416232036 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 416232036
		arg_157_1.duration_ = 8.39

		local var_157_0 = {
			zh = 7.25766666666667,
			ja = 8.39166666666667
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play416232037(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 1.66666666666667 < arg_157_1.time_ and arg_157_1.time_ <= 1.66666666666667 + arg_160_0 then
				local var_160_0 = arg_157_1.bgs_.F09f

				arg_157_1.bgs_.F09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_160_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_160_1 = var_160_0:GetComponent("SpriteRenderer")

				if var_160_1 and var_160_1.sprite then
					local var_160_2 = 2 * (var_160_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_160_0.transform.localScale = Vector3.New(var_160_2 / var_160_1.sprite.bounds.size.y < var_160_2 * manager.ui.mainCameraCom_.aspect / var_160_1.sprite.bounds.size.x and var_160_2 * manager.ui.mainCameraCom_.aspect / var_160_1.sprite.bounds.size.x or var_160_2 / var_160_1.sprite.bounds.size.y, var_160_2 / var_160_1.sprite.bounds.size.y < var_160_2 * manager.ui.mainCameraCom_.aspect / var_160_1.sprite.bounds.size.x and var_160_2 * manager.ui.mainCameraCom_.aspect / var_160_1.sprite.bounds.size.x or var_160_2 / var_160_1.sprite.bounds.size.y, 0)
				end

				for iter_160_0, iter_160_1 in pairs(arg_157_1.bgs_) do
					if iter_160_0 ~= "F09f" then
						iter_160_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_160_3 = 1.66666666666667

			if 1.66666666666667 < arg_157_1.time_ and arg_157_1.time_ <= var_160_3 + arg_160_0 then
				arg_157_1.allBtn_.enabled = false
			end

			if arg_157_1.time_ >= var_160_3 + 0.3 and arg_157_1.time_ < var_160_3 + 0.3 + arg_160_0 then
				arg_157_1.allBtn_.enabled = true
			end

			local var_160_4 = 0

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_5 = 1.66666666666667

			if var_160_4 <= arg_157_1.time_ and arg_157_1.time_ < var_160_4 + var_160_5 then
				local var_160_6 = Color.New(0, 0, 0)

				var_160_6.a = Mathf.Lerp(0, 1, (arg_157_1.time_ - var_160_4) / var_160_5)
				arg_157_1.mask_.color = var_160_6
			end

			if arg_157_1.time_ >= var_160_4 + var_160_5 and arg_157_1.time_ < var_160_4 + var_160_5 + arg_160_0 then
				local var_160_7 = Color.New(0, 0, 0)

				var_160_7.a = 1
				arg_157_1.mask_.color = var_160_7
			end

			local var_160_8 = 1.66666666666667

			if 1.66666666666667 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_9 = 2

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_9 then
				local var_160_10 = Color.New(0, 0, 0)

				var_160_10.a = Mathf.Lerp(1, 0, (arg_157_1.time_ - var_160_8) / var_160_9)
				arg_157_1.mask_.color = var_160_10
			end

			if arg_157_1.time_ >= var_160_8 + var_160_9 and arg_157_1.time_ < var_160_8 + var_160_9 + arg_160_0 then
				local var_160_11 = Color.New(0, 0, 0)

				arg_157_1.mask_.enabled = false
				var_160_11.a = 0
				arg_157_1.mask_.color = var_160_11
			end

			local var_160_12 = "1028"

			if arg_157_1.actors_["1028"] == nil then
				local var_160_13 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_160_13) then
					local var_160_14 = Object.Instantiate(var_160_13, arg_157_1.canvasGo_.transform)

					var_160_14.transform:SetSiblingIndex(1)

					var_160_14.name = var_160_12
					var_160_14.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_157_1.actors_[var_160_12] = var_160_14

					if arg_157_1.isInRecall_ then
						for iter_160_2, iter_160_3 in ipairs((var_160_14:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_160_3.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_160_15 = arg_157_1.actors_["1028"]

			if 3.09166666666667 < arg_157_1.time_ and arg_157_1.time_ <= 3.09166666666667 + arg_160_0 and not isNil(var_160_15) and arg_157_1.var_.actorSpriteComps1028 == nil then
				arg_157_1.var_.actorSpriteComps1028 = var_160_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_16 = 0.2

			if 3.09166666666667 <= arg_157_1.time_ and arg_157_1.time_ < 3.09166666666667 + var_160_16 and not isNil(var_160_15) then
				if arg_157_1.var_.actorSpriteComps1028 then
					for iter_160_4, iter_160_5 in pairs(arg_157_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_160_5 then
							if arg_157_1.isInRecall_ then
								iter_160_5.color = Color.New(Mathf.Lerp(iter_160_5.color.r, arg_157_1.hightColor1.r, (arg_157_1.time_ - 3.09166666666667) / var_160_16), Mathf.Lerp(iter_160_5.color.g, arg_157_1.hightColor1.g, (arg_157_1.time_ - 3.09166666666667) / var_160_16), (Mathf.Lerp(iter_160_5.color.b, arg_157_1.hightColor1.b, (arg_157_1.time_ - 3.09166666666667) / var_160_16)))
							else
								local var_160_17 = Mathf.Lerp(iter_160_5.color.r, 1, (arg_157_1.time_ - 3.09166666666667) / var_160_16)

								iter_160_5.color = Color.New(var_160_17, var_160_17, var_160_17)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 3.09166666666667 + var_160_16 and arg_157_1.time_ < 3.09166666666667 + var_160_16 + arg_160_0 and not isNil(var_160_15) and arg_157_1.var_.actorSpriteComps1028 then
				for iter_160_6, iter_160_7 in pairs(arg_157_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_160_7 then
						iter_160_7.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_157_1.var_.actorSpriteComps1028 = nil
			end

			local var_160_18 = arg_157_1.actors_["10127"]

			if 3.09166666666667 < arg_157_1.time_ and arg_157_1.time_ <= 3.09166666666667 + arg_160_0 and not isNil(var_160_18) and arg_157_1.var_.actorSpriteComps10127 == nil then
				arg_157_1.var_.actorSpriteComps10127 = var_160_18:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_19 = 0.2

			if 3.09166666666667 <= arg_157_1.time_ and arg_157_1.time_ < 3.09166666666667 + var_160_19 and not isNil(var_160_18) then
				if arg_157_1.var_.actorSpriteComps10127 then
					for iter_160_8, iter_160_9 in pairs(arg_157_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_160_9 then
							if arg_157_1.isInRecall_ then
								iter_160_9.color = Color.New(Mathf.Lerp(iter_160_9.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 3.09166666666667) / var_160_19), Mathf.Lerp(iter_160_9.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 3.09166666666667) / var_160_19), (Mathf.Lerp(iter_160_9.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 3.09166666666667) / var_160_19)))
							else
								local var_160_20 = Mathf.Lerp(iter_160_9.color.r, 0.5, (arg_157_1.time_ - 3.09166666666667) / var_160_19)

								iter_160_9.color = Color.New(var_160_20, var_160_20, var_160_20)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 3.09166666666667 + var_160_19 and arg_157_1.time_ < 3.09166666666667 + var_160_19 + arg_160_0 and not isNil(var_160_18) and arg_157_1.var_.actorSpriteComps10127 then
				for iter_160_10, iter_160_11 in pairs(arg_157_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_160_11 then
						iter_160_11.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps10127 = nil
			end

			local var_160_21 = arg_157_1.actors_["1028"].transform

			if 3.09166666666667 < arg_157_1.time_ and arg_157_1.time_ <= 3.09166666666667 + arg_160_0 then
				arg_157_1.var_.moveOldPos1028 = var_160_21.localPosition
				var_160_21.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("1028", 2)

				for iter_160_12 = 0, var_160_21.childCount - 1 do
					local var_160_22 = var_160_21:GetChild(iter_160_12)

					if var_160_22.name == "" or not string.find(var_160_22.name, "split") then
						var_160_22.gameObject:SetActive(true)
					else
						var_160_22.gameObject:SetActive(false)
					end
				end
			end

			local var_160_23 = 0.001

			if 3.09166666666667 <= arg_157_1.time_ and arg_157_1.time_ < 3.09166666666667 + var_160_23 then
				var_160_21.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_157_1.time_ - 3.09166666666667) / var_160_23)
			end

			if arg_157_1.time_ >= 3.09166666666667 + var_160_23 and arg_157_1.time_ < 3.09166666666667 + var_160_23 + arg_160_0 then
				var_160_21.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			if 1.66666666666667 < arg_157_1.time_ and arg_157_1.time_ <= 1.66666666666667 + arg_160_0 then
				arg_157_1.fswbg_:SetActive(false)
				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_157_1:ShowNextGo(false)
			end

			if 1.68333333333333 < arg_157_1.time_ and arg_157_1.time_ <= 1.68333333333333 + arg_160_0 then
				arg_157_1.fswbg_:SetActive(false)
				arg_157_1.dialog_:SetActive(false)
				SetActive(arg_157_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_157_1:ShowNextGo(false)
			end

			local var_160_24 = 2.7

			if 2.7 < arg_157_1.time_ and arg_157_1.time_ <= var_160_24 + arg_160_0 then
				arg_157_1.var_.oldValueTypewriter = arg_157_1.fswtw_.percent

				SetActive(arg_157_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_157_1:ShowNextGo(false)
			end

			local var_160_25 = 0
			local var_160_26 = 0
			local var_160_27, var_160_28 = arg_157_1:GetPercentByPara(arg_157_1:FormatText(arg_157_1:GetWordFromCfg(416232035).content), 1)

			if var_160_24 < arg_157_1.time_ and arg_157_1.time_ <= var_160_24 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				local var_160_29 = var_160_25 <= 0 and var_160_26 or var_160_26 * ((var_160_28 - arg_157_1.typewritterCharCountI18N) / var_160_25)

				if (var_160_25 <= 0 and var_160_26 or var_160_26 * ((var_160_28 - arg_157_1.typewritterCharCountI18N) / var_160_25)) > 0 and var_160_26 < var_160_29 then
					arg_157_1.talkMaxDuration = var_160_29

					if var_160_29 + var_160_24 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_29 + var_160_24
					end
				end
			end

			local var_160_30 = math.max(0, arg_157_1.talkMaxDuration)

			if var_160_24 <= arg_157_1.time_ and arg_157_1.time_ < var_160_24 + var_160_30 then
				arg_157_1.fswtw_.percent = Mathf.Lerp(arg_157_1.var_.oldValueTypewriter, var_160_27, (arg_157_1.time_ - var_160_24) / var_160_30)
				arg_157_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_157_1.fswtw_:SetDirty()
			end

			if arg_157_1.time_ >= var_160_24 + var_160_30 and arg_157_1.time_ < var_160_24 + var_160_30 + arg_160_0 then
				arg_157_1.fswtw_.percent = var_160_27

				arg_157_1.fswtw_:SetDirty()
				arg_157_1:ShowNextGo(true)

				arg_157_1.typewritterCharCountI18N = var_160_28
			end

			if 3.05833333333333 < arg_157_1.time_ and arg_157_1.time_ <= 3.05833333333333 + arg_160_0 then
				local var_160_31 = arg_157_1.actors_["1028"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_160_31 then
					arg_157_1.var_.alphaOldValue1028 = var_160_31.alpha
					arg_157_1.var_.characterEffect1028 = var_160_31
				end

				arg_157_1.var_.alphaOldValue1028 = 0
			end

			local var_160_32 = 0.233333333333333

			if 3.05833333333333 <= arg_157_1.time_ and arg_157_1.time_ < 3.05833333333333 + var_160_32 then
				if arg_157_1.var_.characterEffect1028 then
					arg_157_1.var_.characterEffect1028.alpha = Mathf.Lerp(arg_157_1.var_.alphaOldValue1028, 1, (arg_157_1.time_ - 3.05833333333333) / var_160_32)
				end
			end

			if arg_157_1.time_ >= 3.05833333333333 + var_160_32 and arg_157_1.time_ < 3.05833333333333 + var_160_32 + arg_160_0 and arg_157_1.var_.characterEffect1028 then
				arg_157_1.var_.characterEffect1028.alpha = 1
			end

			local var_160_33 = 1.66666666666667

			arg_157_1.isInRecall_ = true

			if var_160_33 < arg_157_1.time_ and arg_157_1.time_ <= var_160_33 + arg_160_0 then
				arg_157_1.screenFilterGo_:SetActive(true)

				arg_157_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_157_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_157_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_160_13, iter_160_14 in pairs(arg_157_1.actors_) do
					for iter_160_15, iter_160_16 in ipairs((iter_160_14:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_160_16.color = iter_160_16.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_160_34 = 0.0166666666666667

			if var_160_33 <= arg_157_1.time_ and arg_157_1.time_ < var_160_33 + var_160_34 then
				arg_157_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_157_1.time_ - var_160_33) / var_160_34)
			end

			if arg_157_1.time_ >= var_160_33 + var_160_34 and arg_157_1.time_ < var_160_33 + var_160_34 + arg_160_0 then
				arg_157_1.screenFilterEffect_.weight = 1
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_35 = 3.49166666666667
			local var_160_36 = 0.375

			if 3.49166666666667 < arg_157_1.time_ and arg_157_1.time_ <= var_160_35 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_37 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_37:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_38 = arg_157_1:GetWordFromCfg(416232036)
				local var_160_39 = arg_157_1:FormatText(var_160_38.content)

				arg_157_1.text_.text = var_160_39

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_41 = 15 <= 0 and var_160_36 or var_160_36 * (utf8.len(var_160_39) / 15)

				if (15 <= 0 and var_160_36 or var_160_36 * (utf8.len(var_160_39) / 15)) > 0 and var_160_36 < var_160_41 then
					arg_157_1.talkMaxDuration = var_160_41
					var_160_35 = var_160_35 + 0.3

					if var_160_41 + var_160_35 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_41 + var_160_35
					end
				end

				arg_157_1.text_.text = var_160_39
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232036", "story_v_out_416232.awb") ~= 0 then
					local var_160_42 = manager.audio:GetVoiceLength("story_v_out_416232", "416232036", "story_v_out_416232.awb") / 1000

					if var_160_42 + var_160_35 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_42 + var_160_35
					end

					if var_160_38.prefab_name ~= "" and arg_157_1.actors_[var_160_38.prefab_name] ~= nil then
						local var_160_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_38.prefab_name].transform, "story_v_out_416232", "416232036", "story_v_out_416232.awb")

						arg_157_1:RecordAudio("416232036", var_160_43)
						arg_157_1:RecordAudio("416232036", var_160_43)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_416232", "416232036", "story_v_out_416232.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_416232", "416232036", "story_v_out_416232.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_44 = var_160_35 + 0.3
			local var_160_45 = math.max(var_160_36, arg_157_1.talkMaxDuration)

			if var_160_35 + 0.3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_44 + var_160_45 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_44) / var_160_45

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_44 + var_160_45 and arg_157_1.time_ < var_160_44 + var_160_45 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.09166666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play416232037 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 416232037
		arg_163_1.duration_ = 7.33

		local var_163_0 = {
			zh = 4.666,
			ja = 7.333
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
				arg_163_0:Play416232038(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if arg_163_1.actors_["1086"] == nil then
				local var_166_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_166_0) then
					local var_166_1 = Object.Instantiate(var_166_0, arg_163_1.canvasGo_.transform)

					var_166_1.transform:SetSiblingIndex(1)

					var_166_1.name = "1086"
					var_166_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_163_1.actors_["1086"] = var_166_1

					if arg_163_1.isInRecall_ then
						for iter_166_0, iter_166_1 in ipairs((var_166_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_166_1.color = arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_166_2 = arg_163_1.actors_["1086"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps1086 == nil then
				arg_163_1.var_.actorSpriteComps1086 = var_166_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_3 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.actorSpriteComps1086 then
					for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_166_3 then
							if arg_163_1.isInRecall_ then
								iter_166_3.color = Color.New(Mathf.Lerp(iter_166_3.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 0) / var_166_3), Mathf.Lerp(iter_166_3.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 0) / var_166_3), (Mathf.Lerp(iter_166_3.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 0) / var_166_3)))
							else
								local var_166_4 = Mathf.Lerp(iter_166_3.color.r, 1, (arg_163_1.time_ - 0) / var_166_3)

								iter_166_3.color = Color.New(var_166_4, var_166_4, var_166_4)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps1086 then
				for iter_166_4, iter_166_5 in pairs(arg_163_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_166_5 then
						iter_166_5.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps1086 = nil
			end

			local var_166_5 = arg_163_1.actors_["1028"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_5) and arg_163_1.var_.actorSpriteComps1028 == nil then
				arg_163_1.var_.actorSpriteComps1028 = var_166_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_6 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_6 and not isNil(var_166_5) then
				if arg_163_1.var_.actorSpriteComps1028 then
					for iter_166_6, iter_166_7 in pairs(arg_163_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_166_7 then
							if arg_163_1.isInRecall_ then
								iter_166_7.color = Color.New(Mathf.Lerp(iter_166_7.color.r, arg_163_1.hightColor2.r, (arg_163_1.time_ - 0) / var_166_6), Mathf.Lerp(iter_166_7.color.g, arg_163_1.hightColor2.g, (arg_163_1.time_ - 0) / var_166_6), (Mathf.Lerp(iter_166_7.color.b, arg_163_1.hightColor2.b, (arg_163_1.time_ - 0) / var_166_6)))
							else
								local var_166_7 = Mathf.Lerp(iter_166_7.color.r, 0.5, (arg_163_1.time_ - 0) / var_166_6)

								iter_166_7.color = Color.New(var_166_7, var_166_7, var_166_7)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_6 and arg_163_1.time_ < 0 + var_166_6 + arg_166_0 and not isNil(var_166_5) and arg_163_1.var_.actorSpriteComps1028 then
				for iter_166_8, iter_166_9 in pairs(arg_163_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_166_9 then
						iter_166_9.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_163_1.var_.actorSpriteComps1028 = nil
			end

			local var_166_8 = arg_163_1.actors_["1086"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1086 = var_166_8.localPosition
				var_166_8.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1086", 4)

				for iter_166_10 = 0, var_166_8.childCount - 1 do
					local var_166_9 = var_166_8:GetChild(iter_166_10)

					if var_166_9.name == "" or not string.find(var_166_9.name, "split") then
						var_166_9.gameObject:SetActive(true)
					else
						var_166_9.gameObject:SetActive(false)
					end
				end
			end

			local var_166_10 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_10 then
				var_166_8.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_163_1.time_ - 0) / var_166_10)
			end

			if arg_163_1.time_ >= 0 + var_166_10 and arg_163_1.time_ < 0 + var_166_10 + arg_166_0 then
				var_166_8.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_166_11 = 0
			local var_166_12 = 0.575

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_11 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_13 = arg_163_1:GetWordFromCfg(416232037)
				local var_166_14 = arg_163_1:FormatText(var_166_13.content)

				arg_163_1.text_.text = var_166_14

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_16 = 23 <= 0 and var_166_12 or var_166_12 * (utf8.len(var_166_14) / 23)

				if (23 <= 0 and var_166_12 or var_166_12 * (utf8.len(var_166_14) / 23)) > 0 and var_166_12 < var_166_16 then
					arg_163_1.talkMaxDuration = var_166_16

					if var_166_16 + var_166_11 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_16 + var_166_11
					end
				end

				arg_163_1.text_.text = var_166_14
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232037", "story_v_out_416232.awb") ~= 0 then
					local var_166_17 = manager.audio:GetVoiceLength("story_v_out_416232", "416232037", "story_v_out_416232.awb") / 1000

					if var_166_17 + var_166_11 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_17 + var_166_11
					end

					if var_166_13.prefab_name ~= "" and arg_163_1.actors_[var_166_13.prefab_name] ~= nil then
						local var_166_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_13.prefab_name].transform, "story_v_out_416232", "416232037", "story_v_out_416232.awb")

						arg_163_1:RecordAudio("416232037", var_166_18)
						arg_163_1:RecordAudio("416232037", var_166_18)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_416232", "416232037", "story_v_out_416232.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_416232", "416232037", "story_v_out_416232.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_19 = math.max(var_166_12, arg_163_1.talkMaxDuration)

			if var_166_11 <= arg_163_1.time_ and arg_163_1.time_ < var_166_11 + var_166_19 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_11) / var_166_19

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_11 + var_166_19 and arg_163_1.time_ < var_166_11 + var_166_19 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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
	Play416232038 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 416232038
		arg_167_1.duration_ = 9.73

		local var_167_0 = {
			zh = 4.233,
			ja = 9.733
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
				arg_167_0:Play416232039(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.55

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:GetWordFromCfg(416232038)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 22 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 22)

				if (22 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 22)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232038", "story_v_out_416232.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232038", "story_v_out_416232.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_416232", "416232038", "story_v_out_416232.awb")

						arg_167_1:RecordAudio("416232038", var_170_6)
						arg_167_1:RecordAudio("416232038", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_416232", "416232038", "story_v_out_416232.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_416232", "416232038", "story_v_out_416232.awb")
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
	Play416232039 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 416232039
		arg_171_1.duration_ = 10.2

		local var_171_0 = {
			zh = 7.133,
			ja = 10.2
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
				arg_171_0:Play416232040(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0.825

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_1 = arg_171_1:GetWordFromCfg(416232039)
				local var_174_2 = arg_171_1:FormatText(var_174_1.content)

				arg_171_1.text_.text = var_174_2

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_4 = 33 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 33)

				if (33 <= 0 and var_174_0 or var_174_0 * (utf8.len(var_174_2) / 33)) > 0 and var_174_0 < var_174_4 then
					arg_171_1.talkMaxDuration = var_174_4

					if var_174_4 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_4 + 0
					end
				end

				arg_171_1.text_.text = var_174_2
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232039", "story_v_out_416232.awb") ~= 0 then
					local var_174_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232039", "story_v_out_416232.awb") / 1000

					if var_174_5 + 0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + 0
					end

					if var_174_1.prefab_name ~= "" and arg_171_1.actors_[var_174_1.prefab_name] ~= nil then
						local var_174_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_1.prefab_name].transform, "story_v_out_416232", "416232039", "story_v_out_416232.awb")

						arg_171_1:RecordAudio("416232039", var_174_6)
						arg_171_1:RecordAudio("416232039", var_174_6)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_416232", "416232039", "story_v_out_416232.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_416232", "416232039", "story_v_out_416232.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_7 = math.max(var_174_0, arg_171_1.talkMaxDuration)

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_7 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - 0) / var_174_7

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= 0 + var_174_7 and arg_171_1.time_ < 0 + var_174_7 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play416232040 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 416232040
		arg_175_1.duration_ = 8.63

		local var_175_0 = {
			zh = 7.366,
			ja = 8.633
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
				arg_175_0:Play416232041(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1086 = arg_175_1.actors_["1086"].transform.localPosition
				arg_175_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("1086", 4)

				for iter_178_0 = 0, arg_175_1.actors_["1086"].transform.childCount - 1 do
					local var_178_0 = arg_175_1.actors_["1086"].transform:GetChild(iter_178_0)

					if var_178_0.name == "split_6" or not string.find(var_178_0.name, "split") then
						var_178_0.gameObject:SetActive(true)
					else
						var_178_0.gameObject:SetActive(false)
					end
				end
			end

			local var_178_1 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_1 then
				arg_175_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_175_1.time_ - 0) / var_178_1)
			end

			if arg_175_1.time_ >= 0 + var_178_1 and arg_175_1.time_ < 0 + var_178_1 + arg_178_0 then
				arg_175_1.actors_["1086"].transform.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_178_2 = 0
			local var_178_3 = 0.875

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_2 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_4 = arg_175_1:GetWordFromCfg(416232040)
				local var_178_5 = arg_175_1:FormatText(var_178_4.content)

				arg_175_1.text_.text = var_178_5

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_7 = 35 <= 0 and var_178_3 or var_178_3 * (utf8.len(var_178_5) / 35)

				if (35 <= 0 and var_178_3 or var_178_3 * (utf8.len(var_178_5) / 35)) > 0 and var_178_3 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_2 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_2
					end
				end

				arg_175_1.text_.text = var_178_5
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232040", "story_v_out_416232.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232040", "story_v_out_416232.awb") / 1000

					if var_178_8 + var_178_2 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_2
					end

					if var_178_4.prefab_name ~= "" and arg_175_1.actors_[var_178_4.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_4.prefab_name].transform, "story_v_out_416232", "416232040", "story_v_out_416232.awb")

						arg_175_1:RecordAudio("416232040", var_178_9)
						arg_175_1:RecordAudio("416232040", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_416232", "416232040", "story_v_out_416232.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_416232", "416232040", "story_v_out_416232.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_10 = math.max(var_178_3, arg_175_1.talkMaxDuration)

			if var_178_2 <= arg_175_1.time_ and arg_175_1.time_ < var_178_2 + var_178_10 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_2) / var_178_10

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_2 + var_178_10 and arg_175_1.time_ < var_178_2 + var_178_10 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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
	Play416232041 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 416232041
		arg_179_1.duration_ = 7.5

		local var_179_0 = {
			zh = 6.3,
			ja = 7.5
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
				arg_179_0:Play416232042(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["10127"]) and arg_179_1.var_.actorSpriteComps10127 == nil then
				arg_179_1.var_.actorSpriteComps10127 = arg_179_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_0 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["10127"]) then
				if arg_179_1.var_.actorSpriteComps10127 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								iter_182_1.color = Color.New(Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor1.r, (arg_179_1.time_ - 0) / var_182_0), Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor1.g, (arg_179_1.time_ - 0) / var_182_0), (Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor1.b, (arg_179_1.time_ - 0) / var_182_0)))
							else
								local var_182_1 = Mathf.Lerp(iter_182_1.color.r, 1, (arg_179_1.time_ - 0) / var_182_0)

								iter_182_1.color = Color.New(var_182_1, var_182_1, var_182_1)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["10127"]) and arg_179_1.var_.actorSpriteComps10127 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_182_3 then
						iter_182_3.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_179_1.var_.actorSpriteComps10127 = nil
			end

			local var_182_2 = arg_179_1.actors_["1086"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps1086 == nil then
				arg_179_1.var_.actorSpriteComps1086 = var_182_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_3 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_3 and not isNil(var_182_2) then
				if arg_179_1.var_.actorSpriteComps1086 then
					for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_182_5 then
							if arg_179_1.isInRecall_ then
								iter_182_5.color = Color.New(Mathf.Lerp(iter_182_5.color.r, arg_179_1.hightColor2.r, (arg_179_1.time_ - 0) / var_182_3), Mathf.Lerp(iter_182_5.color.g, arg_179_1.hightColor2.g, (arg_179_1.time_ - 0) / var_182_3), (Mathf.Lerp(iter_182_5.color.b, arg_179_1.hightColor2.b, (arg_179_1.time_ - 0) / var_182_3)))
							else
								local var_182_4 = Mathf.Lerp(iter_182_5.color.r, 0.5, (arg_179_1.time_ - 0) / var_182_3)

								iter_182_5.color = Color.New(var_182_4, var_182_4, var_182_4)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_3 and arg_179_1.time_ < 0 + var_182_3 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.actorSpriteComps1086 then
				for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_182_7 then
						iter_182_7.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps1086 = nil
			end

			local var_182_5 = arg_179_1.actors_["1028"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1028 = var_182_5.localPosition
				var_182_5.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("1028", 7)

				for iter_182_8 = 0, var_182_5.childCount - 1 do
					local var_182_6 = var_182_5:GetChild(iter_182_8)

					if var_182_6.name == "" or not string.find(var_182_6.name, "split") then
						var_182_6.gameObject:SetActive(true)
					else
						var_182_6.gameObject:SetActive(false)
					end
				end
			end

			local var_182_7 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				var_182_5.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_179_1.time_ - 0) / var_182_7)
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				var_182_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_182_8 = arg_179_1.actors_["10127"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10127 = var_182_8.localPosition
				var_182_8.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10127", 2)

				for iter_182_9 = 0, var_182_8.childCount - 1 do
					local var_182_9 = var_182_8:GetChild(iter_182_9)

					if var_182_9.name == "" or not string.find(var_182_9.name, "split") then
						var_182_9.gameObject:SetActive(true)
					else
						var_182_9.gameObject:SetActive(false)
					end
				end
			end

			local var_182_10 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_10 then
				var_182_8.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10127, Vector3.New(-390, -387.4, -316.5), (arg_179_1.time_ - 0) / var_182_10)
			end

			if arg_179_1.time_ >= 0 + var_182_10 and arg_179_1.time_ < 0 + var_182_10 + arg_182_0 then
				var_182_8.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_182_11 = 0
			local var_182_12 = 0.825

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_11 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_13 = arg_179_1:GetWordFromCfg(416232041)
				local var_182_14 = arg_179_1:FormatText(var_182_13.content)

				arg_179_1.text_.text = var_182_14

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_16 = 34 <= 0 and var_182_12 or var_182_12 * (utf8.len(var_182_14) / 34)

				if (34 <= 0 and var_182_12 or var_182_12 * (utf8.len(var_182_14) / 34)) > 0 and var_182_12 < var_182_16 then
					arg_179_1.talkMaxDuration = var_182_16

					if var_182_16 + var_182_11 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_16 + var_182_11
					end
				end

				arg_179_1.text_.text = var_182_14
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232041", "story_v_out_416232.awb") ~= 0 then
					local var_182_17 = manager.audio:GetVoiceLength("story_v_out_416232", "416232041", "story_v_out_416232.awb") / 1000

					if var_182_17 + var_182_11 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_17 + var_182_11
					end

					if var_182_13.prefab_name ~= "" and arg_179_1.actors_[var_182_13.prefab_name] ~= nil then
						local var_182_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_13.prefab_name].transform, "story_v_out_416232", "416232041", "story_v_out_416232.awb")

						arg_179_1:RecordAudio("416232041", var_182_18)
						arg_179_1:RecordAudio("416232041", var_182_18)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_416232", "416232041", "story_v_out_416232.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_416232", "416232041", "story_v_out_416232.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_19 = math.max(var_182_12, arg_179_1.talkMaxDuration)

			if var_182_11 <= arg_179_1.time_ and arg_179_1.time_ < var_182_11 + var_182_19 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_11) / var_182_19

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_11 + var_182_19 and arg_179_1.time_ < var_182_11 + var_182_19 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10127",
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
	Play416232042 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 416232042
		arg_183_1.duration_ = 7.87

		local var_183_0 = {
			zh = 4.7,
			ja = 7.866
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play416232043(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.725

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:GetWordFromCfg(416232042)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 29 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 29)

				if (29 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 29)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232042", "story_v_out_416232.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232042", "story_v_out_416232.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_416232", "416232042", "story_v_out_416232.awb")

						arg_183_1:RecordAudio("416232042", var_186_6)
						arg_183_1:RecordAudio("416232042", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_416232", "416232042", "story_v_out_416232.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_416232", "416232042", "story_v_out_416232.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_7 = math.max(var_186_0, arg_183_1.talkMaxDuration)

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_7 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - 0) / var_186_7

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= 0 + var_186_7 and arg_183_1.time_ < 0 + var_186_7 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play416232043 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 416232043
		arg_187_1.duration_ = 4.5

		local var_187_0 = {
			zh = 4.5,
			ja = 3.8
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
				arg_187_0:Play416232044(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["1086"]) and arg_187_1.var_.actorSpriteComps1086 == nil then
				arg_187_1.var_.actorSpriteComps1086 = arg_187_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_0 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["1086"]) then
				if arg_187_1.var_.actorSpriteComps1086 then
					for iter_190_0, iter_190_1 in pairs(arg_187_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_190_1 then
							if arg_187_1.isInRecall_ then
								iter_190_1.color = Color.New(Mathf.Lerp(iter_190_1.color.r, arg_187_1.hightColor1.r, (arg_187_1.time_ - 0) / var_190_0), Mathf.Lerp(iter_190_1.color.g, arg_187_1.hightColor1.g, (arg_187_1.time_ - 0) / var_190_0), (Mathf.Lerp(iter_190_1.color.b, arg_187_1.hightColor1.b, (arg_187_1.time_ - 0) / var_190_0)))
							else
								local var_190_1 = Mathf.Lerp(iter_190_1.color.r, 1, (arg_187_1.time_ - 0) / var_190_0)

								iter_190_1.color = Color.New(var_190_1, var_190_1, var_190_1)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["1086"]) and arg_187_1.var_.actorSpriteComps1086 then
				for iter_190_2, iter_190_3 in pairs(arg_187_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_190_3 then
						iter_190_3.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_187_1.var_.actorSpriteComps1086 = nil
			end

			local var_190_2 = arg_187_1.actors_["10127"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.actorSpriteComps10127 == nil then
				arg_187_1.var_.actorSpriteComps10127 = var_190_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_3 = 0.2

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_3 and not isNil(var_190_2) then
				if arg_187_1.var_.actorSpriteComps10127 then
					for iter_190_4, iter_190_5 in pairs(arg_187_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_190_5 then
							if arg_187_1.isInRecall_ then
								iter_190_5.color = Color.New(Mathf.Lerp(iter_190_5.color.r, arg_187_1.hightColor2.r, (arg_187_1.time_ - 0) / var_190_3), Mathf.Lerp(iter_190_5.color.g, arg_187_1.hightColor2.g, (arg_187_1.time_ - 0) / var_190_3), (Mathf.Lerp(iter_190_5.color.b, arg_187_1.hightColor2.b, (arg_187_1.time_ - 0) / var_190_3)))
							else
								local var_190_4 = Mathf.Lerp(iter_190_5.color.r, 0.5, (arg_187_1.time_ - 0) / var_190_3)

								iter_190_5.color = Color.New(var_190_4, var_190_4, var_190_4)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_3 and arg_187_1.time_ < 0 + var_190_3 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.actorSpriteComps10127 then
				for iter_190_6, iter_190_7 in pairs(arg_187_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_190_7 then
						iter_190_7.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_187_1.var_.actorSpriteComps10127 = nil
			end

			local var_190_5 = 0
			local var_190_6 = 0.575

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_5 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_7 = arg_187_1:GetWordFromCfg(416232043)
				local var_190_8 = arg_187_1:FormatText(var_190_7.content)

				arg_187_1.text_.text = var_190_8

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_10 = 23 <= 0 and var_190_6 or var_190_6 * (utf8.len(var_190_8) / 23)

				if (23 <= 0 and var_190_6 or var_190_6 * (utf8.len(var_190_8) / 23)) > 0 and var_190_6 < var_190_10 then
					arg_187_1.talkMaxDuration = var_190_10

					if var_190_10 + var_190_5 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_5
					end
				end

				arg_187_1.text_.text = var_190_8
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232043", "story_v_out_416232.awb") ~= 0 then
					local var_190_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232043", "story_v_out_416232.awb") / 1000

					if var_190_11 + var_190_5 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_11 + var_190_5
					end

					if var_190_7.prefab_name ~= "" and arg_187_1.actors_[var_190_7.prefab_name] ~= nil then
						local var_190_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_7.prefab_name].transform, "story_v_out_416232", "416232043", "story_v_out_416232.awb")

						arg_187_1:RecordAudio("416232043", var_190_12)
						arg_187_1:RecordAudio("416232043", var_190_12)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_416232", "416232043", "story_v_out_416232.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_416232", "416232043", "story_v_out_416232.awb")
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

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play416232044 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 416232044
		arg_191_1.duration_ = 2.9

		local var_191_0 = {
			zh = 2.9,
			ja = 2
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play416232045(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1086 = arg_191_1.actors_["1086"].transform.localPosition
				arg_191_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("1086", 4)

				for iter_194_0 = 0, arg_191_1.actors_["1086"].transform.childCount - 1 do
					local var_194_0 = arg_191_1.actors_["1086"].transform:GetChild(iter_194_0)

					if var_194_0.name == "" or not string.find(var_194_0.name, "split") then
						var_194_0.gameObject:SetActive(true)
					else
						var_194_0.gameObject:SetActive(false)
					end
				end
			end

			local var_194_1 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_1 then
				arg_191_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_191_1.time_ - 0) / var_194_1)
			end

			if arg_191_1.time_ >= 0 + var_194_1 and arg_191_1.time_ < 0 + var_194_1 + arg_194_0 then
				arg_191_1.actors_["1086"].transform.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_194_2 = 0
			local var_194_3 = 0.325

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_4 = arg_191_1:GetWordFromCfg(416232044)
				local var_194_5 = arg_191_1:FormatText(var_194_4.content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_7 = 13 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 13)

				if (13 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 13)) > 0 and var_194_3 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_2
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232044", "story_v_out_416232.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232044", "story_v_out_416232.awb") / 1000

					if var_194_8 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_2
					end

					if var_194_4.prefab_name ~= "" and arg_191_1.actors_[var_194_4.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_4.prefab_name].transform, "story_v_out_416232", "416232044", "story_v_out_416232.awb")

						arg_191_1:RecordAudio("416232044", var_194_9)
						arg_191_1:RecordAudio("416232044", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_416232", "416232044", "story_v_out_416232.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_416232", "416232044", "story_v_out_416232.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_3, arg_191_1.talkMaxDuration)

			if var_194_2 <= arg_191_1.time_ and arg_191_1.time_ < var_194_2 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_2) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_2 + var_194_10 and arg_191_1.time_ < var_194_2 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
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
	Play416232045 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 416232045
		arg_195_1.duration_ = 6.7

		local var_195_0 = {
			zh = 3.9,
			ja = 6.7
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
				arg_195_0:Play416232046(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1028"]) and arg_195_1.var_.actorSpriteComps1028 == nil then
				arg_195_1.var_.actorSpriteComps1028 = arg_195_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_0 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1028"]) then
				if arg_195_1.var_.actorSpriteComps1028 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_198_1 then
							if arg_195_1.isInRecall_ then
								iter_198_1.color = Color.New(Mathf.Lerp(iter_198_1.color.r, arg_195_1.hightColor1.r, (arg_195_1.time_ - 0) / var_198_0), Mathf.Lerp(iter_198_1.color.g, arg_195_1.hightColor1.g, (arg_195_1.time_ - 0) / var_198_0), (Mathf.Lerp(iter_198_1.color.b, arg_195_1.hightColor1.b, (arg_195_1.time_ - 0) / var_198_0)))
							else
								local var_198_1 = Mathf.Lerp(iter_198_1.color.r, 1, (arg_195_1.time_ - 0) / var_198_0)

								iter_198_1.color = Color.New(var_198_1, var_198_1, var_198_1)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1028"]) and arg_195_1.var_.actorSpriteComps1028 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_198_3 then
						iter_198_3.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_195_1.var_.actorSpriteComps1028 = nil
			end

			local var_198_2 = arg_195_1.actors_["1086"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps1086 == nil then
				arg_195_1.var_.actorSpriteComps1086 = var_198_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_3 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_3 and not isNil(var_198_2) then
				if arg_195_1.var_.actorSpriteComps1086 then
					for iter_198_4, iter_198_5 in pairs(arg_195_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_198_5 then
							if arg_195_1.isInRecall_ then
								iter_198_5.color = Color.New(Mathf.Lerp(iter_198_5.color.r, arg_195_1.hightColor2.r, (arg_195_1.time_ - 0) / var_198_3), Mathf.Lerp(iter_198_5.color.g, arg_195_1.hightColor2.g, (arg_195_1.time_ - 0) / var_198_3), (Mathf.Lerp(iter_198_5.color.b, arg_195_1.hightColor2.b, (arg_195_1.time_ - 0) / var_198_3)))
							else
								local var_198_4 = Mathf.Lerp(iter_198_5.color.r, 0.5, (arg_195_1.time_ - 0) / var_198_3)

								iter_198_5.color = Color.New(var_198_4, var_198_4, var_198_4)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_3 and arg_195_1.time_ < 0 + var_198_3 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps1086 then
				for iter_198_6, iter_198_7 in pairs(arg_195_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_198_7 then
						iter_198_7.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_195_1.var_.actorSpriteComps1086 = nil
			end

			local var_198_5 = arg_195_1.actors_["10127"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10127 = var_198_5.localPosition
				var_198_5.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10127", 7)

				for iter_198_8 = 0, var_198_5.childCount - 1 do
					local var_198_6 = var_198_5:GetChild(iter_198_8)

					if var_198_6.name == "" or not string.find(var_198_6.name, "split") then
						var_198_6.gameObject:SetActive(true)
					else
						var_198_6.gameObject:SetActive(false)
					end
				end
			end

			local var_198_7 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_7 then
				var_198_5.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10127, Vector3.New(0, -2000, 0), (arg_195_1.time_ - 0) / var_198_7)
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				var_198_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_8 = arg_195_1.actors_["1028"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1028 = var_198_8.localPosition
				var_198_8.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1028", 2)

				for iter_198_9 = 0, var_198_8.childCount - 1 do
					local var_198_9 = var_198_8:GetChild(iter_198_9)

					if var_198_9.name == "" or not string.find(var_198_9.name, "split") then
						var_198_9.gameObject:SetActive(true)
					else
						var_198_9.gameObject:SetActive(false)
					end
				end
			end

			local var_198_10 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_10 then
				var_198_8.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_195_1.time_ - 0) / var_198_10)
			end

			if arg_195_1.time_ >= 0 + var_198_10 and arg_195_1.time_ < 0 + var_198_10 + arg_198_0 then
				var_198_8.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_198_11 = 0
			local var_198_12 = 0.475

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_11 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_13 = arg_195_1:GetWordFromCfg(416232045)
				local var_198_14 = arg_195_1:FormatText(var_198_13.content)

				arg_195_1.text_.text = var_198_14

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_16 = 19 <= 0 and var_198_12 or var_198_12 * (utf8.len(var_198_14) / 19)

				if (19 <= 0 and var_198_12 or var_198_12 * (utf8.len(var_198_14) / 19)) > 0 and var_198_12 < var_198_16 then
					arg_195_1.talkMaxDuration = var_198_16

					if var_198_16 + var_198_11 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_16 + var_198_11
					end
				end

				arg_195_1.text_.text = var_198_14
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232045", "story_v_out_416232.awb") ~= 0 then
					local var_198_17 = manager.audio:GetVoiceLength("story_v_out_416232", "416232045", "story_v_out_416232.awb") / 1000

					if var_198_17 + var_198_11 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_17 + var_198_11
					end

					if var_198_13.prefab_name ~= "" and arg_195_1.actors_[var_198_13.prefab_name] ~= nil then
						local var_198_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_13.prefab_name].transform, "story_v_out_416232", "416232045", "story_v_out_416232.awb")

						arg_195_1:RecordAudio("416232045", var_198_18)
						arg_195_1:RecordAudio("416232045", var_198_18)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_416232", "416232045", "story_v_out_416232.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_416232", "416232045", "story_v_out_416232.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_19 = math.max(var_198_12, arg_195_1.talkMaxDuration)

			if var_198_11 <= arg_195_1.time_ and arg_195_1.time_ < var_198_11 + var_198_19 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_11) / var_198_19

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_11 + var_198_19 and arg_195_1.time_ < var_198_11 + var_198_19 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play416232046 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 416232046
		arg_199_1.duration_ = 5.53

		local var_199_0 = {
			zh = 4,
			ja = 5.533
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play416232047(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["1086"]) and arg_199_1.var_.actorSpriteComps1086 == nil then
				arg_199_1.var_.actorSpriteComps1086 = arg_199_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_0 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["1086"]) then
				if arg_199_1.var_.actorSpriteComps1086 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								iter_202_1.color = Color.New(Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor1.r, (arg_199_1.time_ - 0) / var_202_0), Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor1.g, (arg_199_1.time_ - 0) / var_202_0), (Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor1.b, (arg_199_1.time_ - 0) / var_202_0)))
							else
								local var_202_1 = Mathf.Lerp(iter_202_1.color.r, 1, (arg_199_1.time_ - 0) / var_202_0)

								iter_202_1.color = Color.New(var_202_1, var_202_1, var_202_1)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["1086"]) and arg_199_1.var_.actorSpriteComps1086 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_202_3 then
						iter_202_3.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_199_1.var_.actorSpriteComps1086 = nil
			end

			local var_202_2 = arg_199_1.actors_["1028"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps1028 == nil then
				arg_199_1.var_.actorSpriteComps1028 = var_202_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_3 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.actorSpriteComps1028 then
					for iter_202_4, iter_202_5 in pairs(arg_199_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_202_5 then
							if arg_199_1.isInRecall_ then
								iter_202_5.color = Color.New(Mathf.Lerp(iter_202_5.color.r, arg_199_1.hightColor2.r, (arg_199_1.time_ - 0) / var_202_3), Mathf.Lerp(iter_202_5.color.g, arg_199_1.hightColor2.g, (arg_199_1.time_ - 0) / var_202_3), (Mathf.Lerp(iter_202_5.color.b, arg_199_1.hightColor2.b, (arg_199_1.time_ - 0) / var_202_3)))
							else
								local var_202_4 = Mathf.Lerp(iter_202_5.color.r, 0.5, (arg_199_1.time_ - 0) / var_202_3)

								iter_202_5.color = Color.New(var_202_4, var_202_4, var_202_4)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps1028 then
				for iter_202_6, iter_202_7 in pairs(arg_199_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_202_7 then
						iter_202_7.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_199_1.var_.actorSpriteComps1028 = nil
			end

			local var_202_5 = 0
			local var_202_6 = 0.4

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_7 = arg_199_1:GetWordFromCfg(416232046)
				local var_202_8 = arg_199_1:FormatText(var_202_7.content)

				arg_199_1.text_.text = var_202_8

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_10 = 16 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 16)

				if (16 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 16)) > 0 and var_202_6 < var_202_10 then
					arg_199_1.talkMaxDuration = var_202_10

					if var_202_10 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_5
					end
				end

				arg_199_1.text_.text = var_202_8
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232046", "story_v_out_416232.awb") ~= 0 then
					local var_202_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232046", "story_v_out_416232.awb") / 1000

					if var_202_11 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_11 + var_202_5
					end

					if var_202_7.prefab_name ~= "" and arg_199_1.actors_[var_202_7.prefab_name] ~= nil then
						local var_202_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_7.prefab_name].transform, "story_v_out_416232", "416232046", "story_v_out_416232.awb")

						arg_199_1:RecordAudio("416232046", var_202_12)
						arg_199_1:RecordAudio("416232046", var_202_12)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_416232", "416232046", "story_v_out_416232.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_416232", "416232046", "story_v_out_416232.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_13 = math.max(var_202_6, arg_199_1.talkMaxDuration)

			if var_202_5 <= arg_199_1.time_ and arg_199_1.time_ < var_202_5 + var_202_13 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_5) / var_202_13

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_5 + var_202_13 and arg_199_1.time_ < var_202_5 + var_202_13 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play416232047 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 416232047
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play416232048(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["1086"]) and arg_203_1.var_.actorSpriteComps1086 == nil then
				arg_203_1.var_.actorSpriteComps1086 = arg_203_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_0 = 0.2

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["1086"]) then
				if arg_203_1.var_.actorSpriteComps1086 then
					for iter_206_0, iter_206_1 in pairs(arg_203_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_206_1 then
							if arg_203_1.isInRecall_ then
								iter_206_1.color = Color.New(Mathf.Lerp(iter_206_1.color.r, arg_203_1.hightColor2.r, (arg_203_1.time_ - 0) / var_206_0), Mathf.Lerp(iter_206_1.color.g, arg_203_1.hightColor2.g, (arg_203_1.time_ - 0) / var_206_0), (Mathf.Lerp(iter_206_1.color.b, arg_203_1.hightColor2.b, (arg_203_1.time_ - 0) / var_206_0)))
							else
								local var_206_1 = Mathf.Lerp(iter_206_1.color.r, 0.5, (arg_203_1.time_ - 0) / var_206_0)

								iter_206_1.color = Color.New(var_206_1, var_206_1, var_206_1)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["1086"]) and arg_203_1.var_.actorSpriteComps1086 then
				for iter_206_2, iter_206_3 in pairs(arg_203_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_206_3 then
						iter_206_3.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_203_1.var_.actorSpriteComps1086 = nil
			end

			local var_206_2 = arg_203_1.actors_["1028"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1028 = var_206_2.localPosition
				var_206_2.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1028", 7)

				for iter_206_4 = 0, var_206_2.childCount - 1 do
					local var_206_3 = var_206_2:GetChild(iter_206_4)

					if var_206_3.name == "" or not string.find(var_206_3.name, "split") then
						var_206_3.gameObject:SetActive(true)
					else
						var_206_3.gameObject:SetActive(false)
					end
				end
			end

			local var_206_4 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				var_206_2.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_203_1.time_ - 0) / var_206_4)
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
				var_206_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_206_5 = arg_203_1.actors_["1086"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1086 = var_206_5.localPosition
				var_206_5.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1086", 7)

				for iter_206_5 = 0, var_206_5.childCount - 1 do
					local var_206_6 = var_206_5:GetChild(iter_206_5)

					if var_206_6.name == "" or not string.find(var_206_6.name, "split") then
						var_206_6.gameObject:SetActive(true)
					else
						var_206_6.gameObject:SetActive(false)
					end
				end
			end

			local var_206_7 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				var_206_5.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_203_1.time_ - 0) / var_206_7)
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				var_206_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_206_8 = 0
			local var_206_9 = 0.825

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_10 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(416232047).content)

				arg_203_1.text_.text = var_206_10

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_12 = 33 <= 0 and var_206_9 or var_206_9 * (utf8.len(var_206_10) / 33)

				if (33 <= 0 and var_206_9 or var_206_9 * (utf8.len(var_206_10) / 33)) > 0 and var_206_9 < var_206_12 then
					arg_203_1.talkMaxDuration = var_206_12

					if var_206_12 + var_206_8 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_12 + var_206_8
					end
				end

				arg_203_1.text_.text = var_206_10
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_13 = math.max(var_206_9, arg_203_1.talkMaxDuration)

			if var_206_8 <= arg_203_1.time_ and arg_203_1.time_ < var_206_8 + var_206_13 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_8) / var_206_13

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_8 + var_206_13 and arg_203_1.time_ < var_206_8 + var_206_13 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play416232048 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 416232048
		arg_207_1.duration_ = 6.5

		local var_207_0 = {
			zh = 3.2,
			ja = 6.5
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
				arg_207_0:Play416232049(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["10122"]) and arg_207_1.var_.actorSpriteComps10122 == nil then
				arg_207_1.var_.actorSpriteComps10122 = arg_207_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_0 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["10122"]) then
				if arg_207_1.var_.actorSpriteComps10122 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_210_1 then
							if arg_207_1.isInRecall_ then
								iter_210_1.color = Color.New(Mathf.Lerp(iter_210_1.color.r, arg_207_1.hightColor1.r, (arg_207_1.time_ - 0) / var_210_0), Mathf.Lerp(iter_210_1.color.g, arg_207_1.hightColor1.g, (arg_207_1.time_ - 0) / var_210_0), (Mathf.Lerp(iter_210_1.color.b, arg_207_1.hightColor1.b, (arg_207_1.time_ - 0) / var_210_0)))
							else
								local var_210_1 = Mathf.Lerp(iter_210_1.color.r, 1, (arg_207_1.time_ - 0) / var_210_0)

								iter_210_1.color = Color.New(var_210_1, var_210_1, var_210_1)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["10122"]) and arg_207_1.var_.actorSpriteComps10122 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_210_3 then
						iter_210_3.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_207_1.var_.actorSpriteComps10122 = nil
			end

			local var_210_2 = arg_207_1.actors_["10122"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos10122 = var_210_2.localPosition
				var_210_2.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("10122", 2)

				for iter_210_4 = 0, var_210_2.childCount - 1 do
					local var_210_3 = var_210_2:GetChild(iter_210_4)

					if var_210_3.name == "split_5" or not string.find(var_210_3.name, "split") then
						var_210_3.gameObject:SetActive(true)
					else
						var_210_3.gameObject:SetActive(false)
					end
				end
			end

			local var_210_4 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 then
				var_210_2.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10122, Vector3.New(-390, -380, -100), (arg_207_1.time_ - 0) / var_210_4)
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 then
				var_210_2.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_210_5 = 0
			local var_210_6 = 0.375

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_5 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_7 = arg_207_1:GetWordFromCfg(416232048)
				local var_210_8 = arg_207_1:FormatText(var_210_7.content)

				arg_207_1.text_.text = var_210_8

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_10 = 15 <= 0 and var_210_6 or var_210_6 * (utf8.len(var_210_8) / 15)

				if (15 <= 0 and var_210_6 or var_210_6 * (utf8.len(var_210_8) / 15)) > 0 and var_210_6 < var_210_10 then
					arg_207_1.talkMaxDuration = var_210_10

					if var_210_10 + var_210_5 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_10 + var_210_5
					end
				end

				arg_207_1.text_.text = var_210_8
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232048", "story_v_out_416232.awb") ~= 0 then
					local var_210_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232048", "story_v_out_416232.awb") / 1000

					if var_210_11 + var_210_5 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_11 + var_210_5
					end

					if var_210_7.prefab_name ~= "" and arg_207_1.actors_[var_210_7.prefab_name] ~= nil then
						local var_210_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_7.prefab_name].transform, "story_v_out_416232", "416232048", "story_v_out_416232.awb")

						arg_207_1:RecordAudio("416232048", var_210_12)
						arg_207_1:RecordAudio("416232048", var_210_12)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_416232", "416232048", "story_v_out_416232.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_416232", "416232048", "story_v_out_416232.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_13 = math.max(var_210_6, arg_207_1.talkMaxDuration)

			if var_210_5 <= arg_207_1.time_ and arg_207_1.time_ < var_210_5 + var_210_13 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_5) / var_210_13

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_5 + var_210_13 and arg_207_1.time_ < var_210_5 + var_210_13 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
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
	Play416232049 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 416232049
		arg_211_1.duration_ = 5.2

		local var_211_0 = {
			zh = 3,
			ja = 5.2
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
				arg_211_0:Play416232050(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["10127"]) and arg_211_1.var_.actorSpriteComps10127 == nil then
				arg_211_1.var_.actorSpriteComps10127 = arg_211_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_0 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["10127"]) then
				if arg_211_1.var_.actorSpriteComps10127 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_214_1 then
							if arg_211_1.isInRecall_ then
								iter_214_1.color = Color.New(Mathf.Lerp(iter_214_1.color.r, arg_211_1.hightColor1.r, (arg_211_1.time_ - 0) / var_214_0), Mathf.Lerp(iter_214_1.color.g, arg_211_1.hightColor1.g, (arg_211_1.time_ - 0) / var_214_0), (Mathf.Lerp(iter_214_1.color.b, arg_211_1.hightColor1.b, (arg_211_1.time_ - 0) / var_214_0)))
							else
								local var_214_1 = Mathf.Lerp(iter_214_1.color.r, 1, (arg_211_1.time_ - 0) / var_214_0)

								iter_214_1.color = Color.New(var_214_1, var_214_1, var_214_1)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["10127"]) and arg_211_1.var_.actorSpriteComps10127 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_214_3 then
						iter_214_3.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_211_1.var_.actorSpriteComps10127 = nil
			end

			local var_214_2 = arg_211_1.actors_["10122"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.actorSpriteComps10122 == nil then
				arg_211_1.var_.actorSpriteComps10122 = var_214_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_3 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_3 and not isNil(var_214_2) then
				if arg_211_1.var_.actorSpriteComps10122 then
					for iter_214_4, iter_214_5 in pairs(arg_211_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_214_5 then
							if arg_211_1.isInRecall_ then
								iter_214_5.color = Color.New(Mathf.Lerp(iter_214_5.color.r, arg_211_1.hightColor2.r, (arg_211_1.time_ - 0) / var_214_3), Mathf.Lerp(iter_214_5.color.g, arg_211_1.hightColor2.g, (arg_211_1.time_ - 0) / var_214_3), (Mathf.Lerp(iter_214_5.color.b, arg_211_1.hightColor2.b, (arg_211_1.time_ - 0) / var_214_3)))
							else
								local var_214_4 = Mathf.Lerp(iter_214_5.color.r, 0.5, (arg_211_1.time_ - 0) / var_214_3)

								iter_214_5.color = Color.New(var_214_4, var_214_4, var_214_4)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_3 and arg_211_1.time_ < 0 + var_214_3 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.actorSpriteComps10122 then
				for iter_214_6, iter_214_7 in pairs(arg_211_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_214_7 then
						iter_214_7.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_211_1.var_.actorSpriteComps10122 = nil
			end

			local var_214_5 = arg_211_1.actors_["10127"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos10127 = var_214_5.localPosition
				var_214_5.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("10127", 4)

				for iter_214_8 = 0, var_214_5.childCount - 1 do
					local var_214_6 = var_214_5:GetChild(iter_214_8)

					if var_214_6.name == "" or not string.find(var_214_6.name, "split") then
						var_214_6.gameObject:SetActive(true)
					else
						var_214_6.gameObject:SetActive(false)
					end
				end
			end

			local var_214_7 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_7 then
				var_214_5.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10127, Vector3.New(345, -387.4, -316.5), (arg_211_1.time_ - 0) / var_214_7)
			end

			if arg_211_1.time_ >= 0 + var_214_7 and arg_211_1.time_ < 0 + var_214_7 + arg_214_0 then
				var_214_5.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_214_8 = 0
			local var_214_9 = 0.425

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_8 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_10 = arg_211_1:GetWordFromCfg(416232049)
				local var_214_11 = arg_211_1:FormatText(var_214_10.content)

				arg_211_1.text_.text = var_214_11

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_13 = 17 <= 0 and var_214_9 or var_214_9 * (utf8.len(var_214_11) / 17)

				if (17 <= 0 and var_214_9 or var_214_9 * (utf8.len(var_214_11) / 17)) > 0 and var_214_9 < var_214_13 then
					arg_211_1.talkMaxDuration = var_214_13

					if var_214_13 + var_214_8 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_13 + var_214_8
					end
				end

				arg_211_1.text_.text = var_214_11
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232049", "story_v_out_416232.awb") ~= 0 then
					local var_214_14 = manager.audio:GetVoiceLength("story_v_out_416232", "416232049", "story_v_out_416232.awb") / 1000

					if var_214_14 + var_214_8 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_14 + var_214_8
					end

					if var_214_10.prefab_name ~= "" and arg_211_1.actors_[var_214_10.prefab_name] ~= nil then
						local var_214_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_10.prefab_name].transform, "story_v_out_416232", "416232049", "story_v_out_416232.awb")

						arg_211_1:RecordAudio("416232049", var_214_15)
						arg_211_1:RecordAudio("416232049", var_214_15)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_416232", "416232049", "story_v_out_416232.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_416232", "416232049", "story_v_out_416232.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_16 = math.max(var_214_9, arg_211_1.talkMaxDuration)

			if var_214_8 <= arg_211_1.time_ and arg_211_1.time_ < var_214_8 + var_214_16 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_8) / var_214_16

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_8 + var_214_16 and arg_211_1.time_ < var_214_8 + var_214_16 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play416232050 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 416232050
		arg_215_1.duration_ = 4.63

		local var_215_0 = {
			zh = 4.633,
			ja = 4.6
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
				arg_215_0:Play416232051(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["10122"]) and arg_215_1.var_.actorSpriteComps10122 == nil then
				arg_215_1.var_.actorSpriteComps10122 = arg_215_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_0 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["10122"]) then
				if arg_215_1.var_.actorSpriteComps10122 then
					for iter_218_0, iter_218_1 in pairs(arg_215_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_218_1 then
							if arg_215_1.isInRecall_ then
								iter_218_1.color = Color.New(Mathf.Lerp(iter_218_1.color.r, arg_215_1.hightColor1.r, (arg_215_1.time_ - 0) / var_218_0), Mathf.Lerp(iter_218_1.color.g, arg_215_1.hightColor1.g, (arg_215_1.time_ - 0) / var_218_0), (Mathf.Lerp(iter_218_1.color.b, arg_215_1.hightColor1.b, (arg_215_1.time_ - 0) / var_218_0)))
							else
								local var_218_1 = Mathf.Lerp(iter_218_1.color.r, 1, (arg_215_1.time_ - 0) / var_218_0)

								iter_218_1.color = Color.New(var_218_1, var_218_1, var_218_1)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["10122"]) and arg_215_1.var_.actorSpriteComps10122 then
				for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_218_3 then
						iter_218_3.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_215_1.var_.actorSpriteComps10122 = nil
			end

			local var_218_2 = arg_215_1.actors_["10127"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.actorSpriteComps10127 == nil then
				arg_215_1.var_.actorSpriteComps10127 = var_218_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_3 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_3 and not isNil(var_218_2) then
				if arg_215_1.var_.actorSpriteComps10127 then
					for iter_218_4, iter_218_5 in pairs(arg_215_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_218_5 then
							if arg_215_1.isInRecall_ then
								iter_218_5.color = Color.New(Mathf.Lerp(iter_218_5.color.r, arg_215_1.hightColor2.r, (arg_215_1.time_ - 0) / var_218_3), Mathf.Lerp(iter_218_5.color.g, arg_215_1.hightColor2.g, (arg_215_1.time_ - 0) / var_218_3), (Mathf.Lerp(iter_218_5.color.b, arg_215_1.hightColor2.b, (arg_215_1.time_ - 0) / var_218_3)))
							else
								local var_218_4 = Mathf.Lerp(iter_218_5.color.r, 0.5, (arg_215_1.time_ - 0) / var_218_3)

								iter_218_5.color = Color.New(var_218_4, var_218_4, var_218_4)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= 0 + var_218_3 and arg_215_1.time_ < 0 + var_218_3 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.actorSpriteComps10127 then
				for iter_218_6, iter_218_7 in pairs(arg_215_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_218_7 then
						iter_218_7.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_215_1.var_.actorSpriteComps10127 = nil
			end

			local var_218_5 = arg_215_1.actors_["10122"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos10122 = var_218_5.localPosition
				var_218_5.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("10122", 2)

				for iter_218_8 = 0, var_218_5.childCount - 1 do
					local var_218_6 = var_218_5:GetChild(iter_218_8)

					if var_218_6.name == "split_4" or not string.find(var_218_6.name, "split") then
						var_218_6.gameObject:SetActive(true)
					else
						var_218_6.gameObject:SetActive(false)
					end
				end
			end

			local var_218_7 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_7 then
				var_218_5.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10122, Vector3.New(-390, -380, -100), (arg_215_1.time_ - 0) / var_218_7)
			end

			if arg_215_1.time_ >= 0 + var_218_7 and arg_215_1.time_ < 0 + var_218_7 + arg_218_0 then
				var_218_5.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_218_8 = 0
			local var_218_9 = 0.55

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_8 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_10 = arg_215_1:GetWordFromCfg(416232050)
				local var_218_11 = arg_215_1:FormatText(var_218_10.content)

				arg_215_1.text_.text = var_218_11

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_13 = 22 <= 0 and var_218_9 or var_218_9 * (utf8.len(var_218_11) / 22)

				if (22 <= 0 and var_218_9 or var_218_9 * (utf8.len(var_218_11) / 22)) > 0 and var_218_9 < var_218_13 then
					arg_215_1.talkMaxDuration = var_218_13

					if var_218_13 + var_218_8 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_13 + var_218_8
					end
				end

				arg_215_1.text_.text = var_218_11
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232050", "story_v_out_416232.awb") ~= 0 then
					local var_218_14 = manager.audio:GetVoiceLength("story_v_out_416232", "416232050", "story_v_out_416232.awb") / 1000

					if var_218_14 + var_218_8 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_14 + var_218_8
					end

					if var_218_10.prefab_name ~= "" and arg_215_1.actors_[var_218_10.prefab_name] ~= nil then
						local var_218_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_10.prefab_name].transform, "story_v_out_416232", "416232050", "story_v_out_416232.awb")

						arg_215_1:RecordAudio("416232050", var_218_15)
						arg_215_1:RecordAudio("416232050", var_218_15)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_416232", "416232050", "story_v_out_416232.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_416232", "416232050", "story_v_out_416232.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_16 = math.max(var_218_9, arg_215_1.talkMaxDuration)

			if var_218_8 <= arg_215_1.time_ and arg_215_1.time_ < var_218_8 + var_218_16 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_8) / var_218_16

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_8 + var_218_16 and arg_215_1.time_ < var_218_8 + var_218_16 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play416232051 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 416232051
		arg_219_1.duration_ = 6.63

		local var_219_0 = {
			zh = 6.633,
			ja = 6.566
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
				arg_219_0:Play416232052(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.65

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:GetWordFromCfg(416232051)
				local var_222_2 = arg_219_1:FormatText(var_222_1.content)

				arg_219_1.text_.text = var_222_2

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 26 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 26)

				if (26 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 26)) > 0 and var_222_0 < var_222_4 then
					arg_219_1.talkMaxDuration = var_222_4

					if var_222_4 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_4 + 0
					end
				end

				arg_219_1.text_.text = var_222_2
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232051", "story_v_out_416232.awb") ~= 0 then
					local var_222_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232051", "story_v_out_416232.awb") / 1000

					if var_222_5 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + 0
					end

					if var_222_1.prefab_name ~= "" and arg_219_1.actors_[var_222_1.prefab_name] ~= nil then
						local var_222_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_1.prefab_name].transform, "story_v_out_416232", "416232051", "story_v_out_416232.awb")

						arg_219_1:RecordAudio("416232051", var_222_6)
						arg_219_1:RecordAudio("416232051", var_222_6)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_416232", "416232051", "story_v_out_416232.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_416232", "416232051", "story_v_out_416232.awb")
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
	Play416232052 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 416232052
		arg_223_1.duration_ = 8.57

		local var_223_0 = {
			zh = 3.8,
			ja = 8.566
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
				arg_223_0:Play416232053(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["10127"]) and arg_223_1.var_.actorSpriteComps10127 == nil then
				arg_223_1.var_.actorSpriteComps10127 = arg_223_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_0 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["10127"]) then
				if arg_223_1.var_.actorSpriteComps10127 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["10127"]) and arg_223_1.var_.actorSpriteComps10127 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_226_3 then
						iter_226_3.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_223_1.var_.actorSpriteComps10127 = nil
			end

			local var_226_2 = arg_223_1.actors_["10122"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.actorSpriteComps10122 == nil then
				arg_223_1.var_.actorSpriteComps10122 = var_226_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_3 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_3 and not isNil(var_226_2) then
				if arg_223_1.var_.actorSpriteComps10122 then
					for iter_226_4, iter_226_5 in pairs(arg_223_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_226_5 then
							if arg_223_1.isInRecall_ then
								iter_226_5.color = Color.New(Mathf.Lerp(iter_226_5.color.r, arg_223_1.hightColor2.r, (arg_223_1.time_ - 0) / var_226_3), Mathf.Lerp(iter_226_5.color.g, arg_223_1.hightColor2.g, (arg_223_1.time_ - 0) / var_226_3), (Mathf.Lerp(iter_226_5.color.b, arg_223_1.hightColor2.b, (arg_223_1.time_ - 0) / var_226_3)))
							else
								local var_226_4 = Mathf.Lerp(iter_226_5.color.r, 0.5, (arg_223_1.time_ - 0) / var_226_3)

								iter_226_5.color = Color.New(var_226_4, var_226_4, var_226_4)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_3 and arg_223_1.time_ < 0 + var_226_3 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.actorSpriteComps10122 then
				for iter_226_6, iter_226_7 in pairs(arg_223_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_226_7 then
						iter_226_7.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_223_1.var_.actorSpriteComps10122 = nil
			end

			local var_226_5 = 0
			local var_226_6 = 0.55

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_7 = arg_223_1:GetWordFromCfg(416232052)
				local var_226_8 = arg_223_1:FormatText(var_226_7.content)

				arg_223_1.text_.text = var_226_8

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_10 = 22 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 22)

				if (22 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 22)) > 0 and var_226_6 < var_226_10 then
					arg_223_1.talkMaxDuration = var_226_10

					if var_226_10 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_5
					end
				end

				arg_223_1.text_.text = var_226_8
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232052", "story_v_out_416232.awb") ~= 0 then
					local var_226_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232052", "story_v_out_416232.awb") / 1000

					if var_226_11 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_11 + var_226_5
					end

					if var_226_7.prefab_name ~= "" and arg_223_1.actors_[var_226_7.prefab_name] ~= nil then
						local var_226_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_7.prefab_name].transform, "story_v_out_416232", "416232052", "story_v_out_416232.awb")

						arg_223_1:RecordAudio("416232052", var_226_12)
						arg_223_1:RecordAudio("416232052", var_226_12)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_416232", "416232052", "story_v_out_416232.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_416232", "416232052", "story_v_out_416232.awb")
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

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play416232053 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 416232053
		arg_227_1.duration_ = 5.47

		local var_227_0 = {
			zh = 5.4,
			ja = 5.466
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
				arg_227_0:Play416232054(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["10122"]) and arg_227_1.var_.actorSpriteComps10122 == nil then
				arg_227_1.var_.actorSpriteComps10122 = arg_227_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_0 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["10122"]) then
				if arg_227_1.var_.actorSpriteComps10122 then
					for iter_230_0, iter_230_1 in pairs(arg_227_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_230_1 then
							if arg_227_1.isInRecall_ then
								iter_230_1.color = Color.New(Mathf.Lerp(iter_230_1.color.r, arg_227_1.hightColor1.r, (arg_227_1.time_ - 0) / var_230_0), Mathf.Lerp(iter_230_1.color.g, arg_227_1.hightColor1.g, (arg_227_1.time_ - 0) / var_230_0), (Mathf.Lerp(iter_230_1.color.b, arg_227_1.hightColor1.b, (arg_227_1.time_ - 0) / var_230_0)))
							else
								local var_230_1 = Mathf.Lerp(iter_230_1.color.r, 1, (arg_227_1.time_ - 0) / var_230_0)

								iter_230_1.color = Color.New(var_230_1, var_230_1, var_230_1)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["10122"]) and arg_227_1.var_.actorSpriteComps10122 then
				for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_230_3 then
						iter_230_3.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_227_1.var_.actorSpriteComps10122 = nil
			end

			local var_230_2 = arg_227_1.actors_["10127"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_2) and arg_227_1.var_.actorSpriteComps10127 == nil then
				arg_227_1.var_.actorSpriteComps10127 = var_230_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_3 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_3 and not isNil(var_230_2) then
				if arg_227_1.var_.actorSpriteComps10127 then
					for iter_230_4, iter_230_5 in pairs(arg_227_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_230_5 then
							if arg_227_1.isInRecall_ then
								iter_230_5.color = Color.New(Mathf.Lerp(iter_230_5.color.r, arg_227_1.hightColor2.r, (arg_227_1.time_ - 0) / var_230_3), Mathf.Lerp(iter_230_5.color.g, arg_227_1.hightColor2.g, (arg_227_1.time_ - 0) / var_230_3), (Mathf.Lerp(iter_230_5.color.b, arg_227_1.hightColor2.b, (arg_227_1.time_ - 0) / var_230_3)))
							else
								local var_230_4 = Mathf.Lerp(iter_230_5.color.r, 0.5, (arg_227_1.time_ - 0) / var_230_3)

								iter_230_5.color = Color.New(var_230_4, var_230_4, var_230_4)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 0 + var_230_3 and arg_227_1.time_ < 0 + var_230_3 + arg_230_0 and not isNil(var_230_2) and arg_227_1.var_.actorSpriteComps10127 then
				for iter_230_6, iter_230_7 in pairs(arg_227_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_230_7 then
						iter_230_7.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_227_1.var_.actorSpriteComps10127 = nil
			end

			local var_230_5 = 0
			local var_230_6 = 0.675

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_5 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_7 = arg_227_1:GetWordFromCfg(416232053)
				local var_230_8 = arg_227_1:FormatText(var_230_7.content)

				arg_227_1.text_.text = var_230_8

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_10 = 27 <= 0 and var_230_6 or var_230_6 * (utf8.len(var_230_8) / 27)

				if (27 <= 0 and var_230_6 or var_230_6 * (utf8.len(var_230_8) / 27)) > 0 and var_230_6 < var_230_10 then
					arg_227_1.talkMaxDuration = var_230_10

					if var_230_10 + var_230_5 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_10 + var_230_5
					end
				end

				arg_227_1.text_.text = var_230_8
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232053", "story_v_out_416232.awb") ~= 0 then
					local var_230_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232053", "story_v_out_416232.awb") / 1000

					if var_230_11 + var_230_5 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_11 + var_230_5
					end

					if var_230_7.prefab_name ~= "" and arg_227_1.actors_[var_230_7.prefab_name] ~= nil then
						local var_230_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_7.prefab_name].transform, "story_v_out_416232", "416232053", "story_v_out_416232.awb")

						arg_227_1:RecordAudio("416232053", var_230_12)
						arg_227_1:RecordAudio("416232053", var_230_12)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_416232", "416232053", "story_v_out_416232.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_416232", "416232053", "story_v_out_416232.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_13 = math.max(var_230_6, arg_227_1.talkMaxDuration)

			if var_230_5 <= arg_227_1.time_ and arg_227_1.time_ < var_230_5 + var_230_13 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_5) / var_230_13

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_5 + var_230_13 and arg_227_1.time_ < var_230_5 + var_230_13 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play416232054 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 416232054
		arg_231_1.duration_ = 6.4

		local var_231_0 = {
			zh = 4.4,
			ja = 6.4
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
				arg_231_0:Play416232055(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10122 = arg_231_1.actors_["10122"].transform.localPosition
				arg_231_1.actors_["10122"].transform.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10122", 2)

				for iter_234_0 = 0, arg_231_1.actors_["10122"].transform.childCount - 1 do
					local var_234_0 = arg_231_1.actors_["10122"].transform:GetChild(iter_234_0)

					if var_234_0.name == "split_4" or not string.find(var_234_0.name, "split") then
						var_234_0.gameObject:SetActive(true)
					else
						var_234_0.gameObject:SetActive(false)
					end
				end
			end

			local var_234_1 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_1 then
				arg_231_1.actors_["10122"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10122, Vector3.New(-390, -380, -100), (arg_231_1.time_ - 0) / var_234_1)
			end

			if arg_231_1.time_ >= 0 + var_234_1 and arg_231_1.time_ < 0 + var_234_1 + arg_234_0 then
				arg_231_1.actors_["10122"].transform.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_234_2 = 0
			local var_234_3 = 0.375

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_2 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_4 = arg_231_1:GetWordFromCfg(416232054)
				local var_234_5 = arg_231_1:FormatText(var_234_4.content)

				arg_231_1.text_.text = var_234_5

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_7 = 15 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_5) / 15)

				if (15 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_5) / 15)) > 0 and var_234_3 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_2
					end
				end

				arg_231_1.text_.text = var_234_5
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232054", "story_v_out_416232.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232054", "story_v_out_416232.awb") / 1000

					if var_234_8 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_2
					end

					if var_234_4.prefab_name ~= "" and arg_231_1.actors_[var_234_4.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_4.prefab_name].transform, "story_v_out_416232", "416232054", "story_v_out_416232.awb")

						arg_231_1:RecordAudio("416232054", var_234_9)
						arg_231_1:RecordAudio("416232054", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_416232", "416232054", "story_v_out_416232.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_416232", "416232054", "story_v_out_416232.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_3, arg_231_1.talkMaxDuration)

			if var_234_2 <= arg_231_1.time_ and arg_231_1.time_ < var_234_2 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_2) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_2 + var_234_10 and arg_231_1.time_ < var_234_2 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play416232055 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 416232055
		arg_235_1.duration_ = 6.1

		local var_235_0 = {
			zh = 5.233,
			ja = 6.1
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
				arg_235_0:Play416232056(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["10127"]) and arg_235_1.var_.actorSpriteComps10127 == nil then
				arg_235_1.var_.actorSpriteComps10127 = arg_235_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_0 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["10127"]) then
				if arg_235_1.var_.actorSpriteComps10127 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["10127"]) and arg_235_1.var_.actorSpriteComps10127 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_238_3 then
						iter_238_3.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_235_1.var_.actorSpriteComps10127 = nil
			end

			local var_238_2 = arg_235_1.actors_["10122"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.actorSpriteComps10122 == nil then
				arg_235_1.var_.actorSpriteComps10122 = var_238_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_3 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_3 and not isNil(var_238_2) then
				if arg_235_1.var_.actorSpriteComps10122 then
					for iter_238_4, iter_238_5 in pairs(arg_235_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_238_5 then
							if arg_235_1.isInRecall_ then
								iter_238_5.color = Color.New(Mathf.Lerp(iter_238_5.color.r, arg_235_1.hightColor2.r, (arg_235_1.time_ - 0) / var_238_3), Mathf.Lerp(iter_238_5.color.g, arg_235_1.hightColor2.g, (arg_235_1.time_ - 0) / var_238_3), (Mathf.Lerp(iter_238_5.color.b, arg_235_1.hightColor2.b, (arg_235_1.time_ - 0) / var_238_3)))
							else
								local var_238_4 = Mathf.Lerp(iter_238_5.color.r, 0.5, (arg_235_1.time_ - 0) / var_238_3)

								iter_238_5.color = Color.New(var_238_4, var_238_4, var_238_4)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_3 and arg_235_1.time_ < 0 + var_238_3 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.actorSpriteComps10122 then
				for iter_238_6, iter_238_7 in pairs(arg_235_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_238_7 then
						iter_238_7.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_235_1.var_.actorSpriteComps10122 = nil
			end

			local var_238_5 = 0
			local var_238_6 = 0.675

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_5 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_7 = arg_235_1:GetWordFromCfg(416232055)
				local var_238_8 = arg_235_1:FormatText(var_238_7.content)

				arg_235_1.text_.text = var_238_8

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_10 = 27 <= 0 and var_238_6 or var_238_6 * (utf8.len(var_238_8) / 27)

				if (27 <= 0 and var_238_6 or var_238_6 * (utf8.len(var_238_8) / 27)) > 0 and var_238_6 < var_238_10 then
					arg_235_1.talkMaxDuration = var_238_10

					if var_238_10 + var_238_5 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_5
					end
				end

				arg_235_1.text_.text = var_238_8
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232055", "story_v_out_416232.awb") ~= 0 then
					local var_238_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232055", "story_v_out_416232.awb") / 1000

					if var_238_11 + var_238_5 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_11 + var_238_5
					end

					if var_238_7.prefab_name ~= "" and arg_235_1.actors_[var_238_7.prefab_name] ~= nil then
						local var_238_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_7.prefab_name].transform, "story_v_out_416232", "416232055", "story_v_out_416232.awb")

						arg_235_1:RecordAudio("416232055", var_238_12)
						arg_235_1:RecordAudio("416232055", var_238_12)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_416232", "416232055", "story_v_out_416232.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_416232", "416232055", "story_v_out_416232.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_13 = math.max(var_238_6, arg_235_1.talkMaxDuration)

			if var_238_5 <= arg_235_1.time_ and arg_235_1.time_ < var_238_5 + var_238_13 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_5) / var_238_13

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_5 + var_238_13 and arg_235_1.time_ < var_238_5 + var_238_13 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play416232056 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 416232056
		arg_239_1.duration_ = 8.93

		local var_239_0 = {
			zh = 5.666,
			ja = 8.933
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
				arg_239_0:Play416232057(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.8

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:GetWordFromCfg(416232056)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 32 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 32)

				if (32 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 32)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232056", "story_v_out_416232.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232056", "story_v_out_416232.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_416232", "416232056", "story_v_out_416232.awb")

						arg_239_1:RecordAudio("416232056", var_242_6)
						arg_239_1:RecordAudio("416232056", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_416232", "416232056", "story_v_out_416232.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_416232", "416232056", "story_v_out_416232.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_7 and arg_239_1.time_ < 0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play416232057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 416232057
		arg_243_1.duration_ = 5.73

		local var_243_0 = {
			zh = 3.766,
			ja = 5.733
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
				arg_243_0:Play416232058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["10122"]) and arg_243_1.var_.actorSpriteComps10122 == nil then
				arg_243_1.var_.actorSpriteComps10122 = arg_243_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_0 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["10122"]) then
				if arg_243_1.var_.actorSpriteComps10122 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_246_1 then
							if arg_243_1.isInRecall_ then
								iter_246_1.color = Color.New(Mathf.Lerp(iter_246_1.color.r, arg_243_1.hightColor1.r, (arg_243_1.time_ - 0) / var_246_0), Mathf.Lerp(iter_246_1.color.g, arg_243_1.hightColor1.g, (arg_243_1.time_ - 0) / var_246_0), (Mathf.Lerp(iter_246_1.color.b, arg_243_1.hightColor1.b, (arg_243_1.time_ - 0) / var_246_0)))
							else
								local var_246_1 = Mathf.Lerp(iter_246_1.color.r, 1, (arg_243_1.time_ - 0) / var_246_0)

								iter_246_1.color = Color.New(var_246_1, var_246_1, var_246_1)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["10122"]) and arg_243_1.var_.actorSpriteComps10122 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_246_3 then
						iter_246_3.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_243_1.var_.actorSpriteComps10122 = nil
			end

			local var_246_2 = arg_243_1.actors_["10127"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.actorSpriteComps10127 == nil then
				arg_243_1.var_.actorSpriteComps10127 = var_246_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_3 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_3 and not isNil(var_246_2) then
				if arg_243_1.var_.actorSpriteComps10127 then
					for iter_246_4, iter_246_5 in pairs(arg_243_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_246_5 then
							if arg_243_1.isInRecall_ then
								iter_246_5.color = Color.New(Mathf.Lerp(iter_246_5.color.r, arg_243_1.hightColor2.r, (arg_243_1.time_ - 0) / var_246_3), Mathf.Lerp(iter_246_5.color.g, arg_243_1.hightColor2.g, (arg_243_1.time_ - 0) / var_246_3), (Mathf.Lerp(iter_246_5.color.b, arg_243_1.hightColor2.b, (arg_243_1.time_ - 0) / var_246_3)))
							else
								local var_246_4 = Mathf.Lerp(iter_246_5.color.r, 0.5, (arg_243_1.time_ - 0) / var_246_3)

								iter_246_5.color = Color.New(var_246_4, var_246_4, var_246_4)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_3 and arg_243_1.time_ < 0 + var_246_3 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.actorSpriteComps10127 then
				for iter_246_6, iter_246_7 in pairs(arg_243_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_246_7 then
						iter_246_7.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_243_1.var_.actorSpriteComps10127 = nil
			end

			local var_246_5 = 0
			local var_246_6 = 0.4

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_5 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_7 = arg_243_1:GetWordFromCfg(416232057)
				local var_246_8 = arg_243_1:FormatText(var_246_7.content)

				arg_243_1.text_.text = var_246_8

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_10 = 16 <= 0 and var_246_6 or var_246_6 * (utf8.len(var_246_8) / 16)

				if (16 <= 0 and var_246_6 or var_246_6 * (utf8.len(var_246_8) / 16)) > 0 and var_246_6 < var_246_10 then
					arg_243_1.talkMaxDuration = var_246_10

					if var_246_10 + var_246_5 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_5
					end
				end

				arg_243_1.text_.text = var_246_8
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232057", "story_v_out_416232.awb") ~= 0 then
					local var_246_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232057", "story_v_out_416232.awb") / 1000

					if var_246_11 + var_246_5 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_11 + var_246_5
					end

					if var_246_7.prefab_name ~= "" and arg_243_1.actors_[var_246_7.prefab_name] ~= nil then
						local var_246_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_7.prefab_name].transform, "story_v_out_416232", "416232057", "story_v_out_416232.awb")

						arg_243_1:RecordAudio("416232057", var_246_12)
						arg_243_1:RecordAudio("416232057", var_246_12)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_416232", "416232057", "story_v_out_416232.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_416232", "416232057", "story_v_out_416232.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_13 = math.max(var_246_6, arg_243_1.talkMaxDuration)

			if var_246_5 <= arg_243_1.time_ and arg_243_1.time_ < var_246_5 + var_246_13 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_5) / var_246_13

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_5 + var_246_13 and arg_243_1.time_ < var_246_5 + var_246_13 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play416232058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 416232058
		arg_247_1.duration_ = 10.87

		local var_247_0 = {
			zh = 7.633,
			ja = 10.866
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
				arg_247_0:Play416232059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["10127"]) and arg_247_1.var_.actorSpriteComps10127 == nil then
				arg_247_1.var_.actorSpriteComps10127 = arg_247_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_0 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["10127"]) then
				if arg_247_1.var_.actorSpriteComps10127 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["10127"]) and arg_247_1.var_.actorSpriteComps10127 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_250_3 then
						iter_250_3.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_247_1.var_.actorSpriteComps10127 = nil
			end

			local var_250_2 = arg_247_1.actors_["10122"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_2) and arg_247_1.var_.actorSpriteComps10122 == nil then
				arg_247_1.var_.actorSpriteComps10122 = var_250_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_3 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_3 and not isNil(var_250_2) then
				if arg_247_1.var_.actorSpriteComps10122 then
					for iter_250_4, iter_250_5 in pairs(arg_247_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_250_5 then
							if arg_247_1.isInRecall_ then
								iter_250_5.color = Color.New(Mathf.Lerp(iter_250_5.color.r, arg_247_1.hightColor2.r, (arg_247_1.time_ - 0) / var_250_3), Mathf.Lerp(iter_250_5.color.g, arg_247_1.hightColor2.g, (arg_247_1.time_ - 0) / var_250_3), (Mathf.Lerp(iter_250_5.color.b, arg_247_1.hightColor2.b, (arg_247_1.time_ - 0) / var_250_3)))
							else
								local var_250_4 = Mathf.Lerp(iter_250_5.color.r, 0.5, (arg_247_1.time_ - 0) / var_250_3)

								iter_250_5.color = Color.New(var_250_4, var_250_4, var_250_4)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 0 + var_250_3 and arg_247_1.time_ < 0 + var_250_3 + arg_250_0 and not isNil(var_250_2) and arg_247_1.var_.actorSpriteComps10122 then
				for iter_250_6, iter_250_7 in pairs(arg_247_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_250_7 then
						iter_250_7.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_247_1.var_.actorSpriteComps10122 = nil
			end

			local var_250_5 = arg_247_1.actors_["10127"].transform

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10127 = var_250_5.localPosition
				var_250_5.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10127", 4)

				for iter_250_8 = 0, var_250_5.childCount - 1 do
					local var_250_6 = var_250_5:GetChild(iter_250_8)

					if var_250_6.name == "" or not string.find(var_250_6.name, "split") then
						var_250_6.gameObject:SetActive(true)
					else
						var_250_6.gameObject:SetActive(false)
					end
				end
			end

			local var_250_7 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 then
				var_250_5.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10127, Vector3.New(345, -387.4, -316.5), (arg_247_1.time_ - 0) / var_250_7)
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 then
				var_250_5.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_250_8 = 0
			local var_250_9 = 0.95

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_8 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_10 = arg_247_1:GetWordFromCfg(416232058)
				local var_250_11 = arg_247_1:FormatText(var_250_10.content)

				arg_247_1.text_.text = var_250_11

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_13 = 38 <= 0 and var_250_9 or var_250_9 * (utf8.len(var_250_11) / 38)

				if (38 <= 0 and var_250_9 or var_250_9 * (utf8.len(var_250_11) / 38)) > 0 and var_250_9 < var_250_13 then
					arg_247_1.talkMaxDuration = var_250_13

					if var_250_13 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_13 + var_250_8
					end
				end

				arg_247_1.text_.text = var_250_11
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232058", "story_v_out_416232.awb") ~= 0 then
					local var_250_14 = manager.audio:GetVoiceLength("story_v_out_416232", "416232058", "story_v_out_416232.awb") / 1000

					if var_250_14 + var_250_8 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_14 + var_250_8
					end

					if var_250_10.prefab_name ~= "" and arg_247_1.actors_[var_250_10.prefab_name] ~= nil then
						local var_250_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_10.prefab_name].transform, "story_v_out_416232", "416232058", "story_v_out_416232.awb")

						arg_247_1:RecordAudio("416232058", var_250_15)
						arg_247_1:RecordAudio("416232058", var_250_15)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_416232", "416232058", "story_v_out_416232.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_416232", "416232058", "story_v_out_416232.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_16 = math.max(var_250_9, arg_247_1.talkMaxDuration)

			if var_250_8 <= arg_247_1.time_ and arg_247_1.time_ < var_250_8 + var_250_16 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_8) / var_250_16

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_8 + var_250_16 and arg_247_1.time_ < var_250_8 + var_250_16 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
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
	Play416232059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 416232059
		arg_251_1.duration_ = 11.53

		local var_251_0 = {
			zh = 7.566,
			ja = 11.533
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
				arg_251_0:Play416232060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.8

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_1 = arg_251_1:GetWordFromCfg(416232059)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 32 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 32)

				if (32 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 32)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232059", "story_v_out_416232.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232059", "story_v_out_416232.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_416232", "416232059", "story_v_out_416232.awb")

						arg_251_1:RecordAudio("416232059", var_254_6)
						arg_251_1:RecordAudio("416232059", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_416232", "416232059", "story_v_out_416232.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_416232", "416232059", "story_v_out_416232.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_0, arg_251_1.talkMaxDuration)

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - 0) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= 0 + var_254_7 and arg_251_1.time_ < 0 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play416232060 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 416232060
		arg_255_1.duration_ = 3

		local var_255_0 = {
			zh = 3,
			ja = 2.666
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
				arg_255_0:Play416232061(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["10122"]) and arg_255_1.var_.actorSpriteComps10122 == nil then
				arg_255_1.var_.actorSpriteComps10122 = arg_255_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_0 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["10122"]) then
				if arg_255_1.var_.actorSpriteComps10122 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["10122"]) and arg_255_1.var_.actorSpriteComps10122 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_258_3 then
						iter_258_3.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_255_1.var_.actorSpriteComps10122 = nil
			end

			local var_258_2 = arg_255_1.actors_["10127"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_2) and arg_255_1.var_.actorSpriteComps10127 == nil then
				arg_255_1.var_.actorSpriteComps10127 = var_258_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_3 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_3 and not isNil(var_258_2) then
				if arg_255_1.var_.actorSpriteComps10127 then
					for iter_258_4, iter_258_5 in pairs(arg_255_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_258_5 then
							if arg_255_1.isInRecall_ then
								iter_258_5.color = Color.New(Mathf.Lerp(iter_258_5.color.r, arg_255_1.hightColor2.r, (arg_255_1.time_ - 0) / var_258_3), Mathf.Lerp(iter_258_5.color.g, arg_255_1.hightColor2.g, (arg_255_1.time_ - 0) / var_258_3), (Mathf.Lerp(iter_258_5.color.b, arg_255_1.hightColor2.b, (arg_255_1.time_ - 0) / var_258_3)))
							else
								local var_258_4 = Mathf.Lerp(iter_258_5.color.r, 0.5, (arg_255_1.time_ - 0) / var_258_3)

								iter_258_5.color = Color.New(var_258_4, var_258_4, var_258_4)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_3 and arg_255_1.time_ < 0 + var_258_3 + arg_258_0 and not isNil(var_258_2) and arg_255_1.var_.actorSpriteComps10127 then
				for iter_258_6, iter_258_7 in pairs(arg_255_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_258_7 then
						iter_258_7.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_255_1.var_.actorSpriteComps10127 = nil
			end

			local var_258_5 = 0
			local var_258_6 = 0.275

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_7 = arg_255_1:GetWordFromCfg(416232060)
				local var_258_8 = arg_255_1:FormatText(var_258_7.content)

				arg_255_1.text_.text = var_258_8

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_10 = 11 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 11)

				if (11 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 11)) > 0 and var_258_6 < var_258_10 then
					arg_255_1.talkMaxDuration = var_258_10

					if var_258_10 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_5
					end
				end

				arg_255_1.text_.text = var_258_8
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232060", "story_v_out_416232.awb") ~= 0 then
					local var_258_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232060", "story_v_out_416232.awb") / 1000

					if var_258_11 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_11 + var_258_5
					end

					if var_258_7.prefab_name ~= "" and arg_255_1.actors_[var_258_7.prefab_name] ~= nil then
						local var_258_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_7.prefab_name].transform, "story_v_out_416232", "416232060", "story_v_out_416232.awb")

						arg_255_1:RecordAudio("416232060", var_258_12)
						arg_255_1:RecordAudio("416232060", var_258_12)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_416232", "416232060", "story_v_out_416232.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_416232", "416232060", "story_v_out_416232.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_13 = math.max(var_258_6, arg_255_1.talkMaxDuration)

			if var_258_5 <= arg_255_1.time_ and arg_255_1.time_ < var_258_5 + var_258_13 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_5) / var_258_13

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_5 + var_258_13 and arg_255_1.time_ < var_258_5 + var_258_13 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play416232061 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 416232061
		arg_259_1.duration_ = 6.53

		local var_259_0 = {
			zh = 3.966,
			ja = 6.533
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
				arg_259_0:Play416232062(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["10127"]) and arg_259_1.var_.actorSpriteComps10127 == nil then
				arg_259_1.var_.actorSpriteComps10127 = arg_259_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_0 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["10127"]) then
				if arg_259_1.var_.actorSpriteComps10127 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								iter_262_1.color = Color.New(Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor1.r, (arg_259_1.time_ - 0) / var_262_0), Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor1.g, (arg_259_1.time_ - 0) / var_262_0), (Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor1.b, (arg_259_1.time_ - 0) / var_262_0)))
							else
								local var_262_1 = Mathf.Lerp(iter_262_1.color.r, 1, (arg_259_1.time_ - 0) / var_262_0)

								iter_262_1.color = Color.New(var_262_1, var_262_1, var_262_1)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["10127"]) and arg_259_1.var_.actorSpriteComps10127 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_262_3 then
						iter_262_3.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_259_1.var_.actorSpriteComps10127 = nil
			end

			local var_262_2 = arg_259_1.actors_["10122"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.actorSpriteComps10122 == nil then
				arg_259_1.var_.actorSpriteComps10122 = var_262_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_3 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_3 and not isNil(var_262_2) then
				if arg_259_1.var_.actorSpriteComps10122 then
					for iter_262_4, iter_262_5 in pairs(arg_259_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_262_5 then
							if arg_259_1.isInRecall_ then
								iter_262_5.color = Color.New(Mathf.Lerp(iter_262_5.color.r, arg_259_1.hightColor2.r, (arg_259_1.time_ - 0) / var_262_3), Mathf.Lerp(iter_262_5.color.g, arg_259_1.hightColor2.g, (arg_259_1.time_ - 0) / var_262_3), (Mathf.Lerp(iter_262_5.color.b, arg_259_1.hightColor2.b, (arg_259_1.time_ - 0) / var_262_3)))
							else
								local var_262_4 = Mathf.Lerp(iter_262_5.color.r, 0.5, (arg_259_1.time_ - 0) / var_262_3)

								iter_262_5.color = Color.New(var_262_4, var_262_4, var_262_4)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_3 and arg_259_1.time_ < 0 + var_262_3 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.actorSpriteComps10122 then
				for iter_262_6, iter_262_7 in pairs(arg_259_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_262_7 then
						iter_262_7.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_259_1.var_.actorSpriteComps10122 = nil
			end

			local var_262_5 = arg_259_1.actors_["10127"].transform

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos10127 = var_262_5.localPosition
				var_262_5.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("10127", 4)

				for iter_262_8 = 0, var_262_5.childCount - 1 do
					local var_262_6 = var_262_5:GetChild(iter_262_8)

					if var_262_6.name == "split_2" or not string.find(var_262_6.name, "split") then
						var_262_6.gameObject:SetActive(true)
					else
						var_262_6.gameObject:SetActive(false)
					end
				end
			end

			local var_262_7 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_7 then
				var_262_5.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10127, Vector3.New(345, -387.4, -316.5), (arg_259_1.time_ - 0) / var_262_7)
			end

			if arg_259_1.time_ >= 0 + var_262_7 and arg_259_1.time_ < 0 + var_262_7 + arg_262_0 then
				var_262_5.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_262_8 = 0
			local var_262_9 = 0.575

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_8 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_10 = arg_259_1:GetWordFromCfg(416232061)
				local var_262_11 = arg_259_1:FormatText(var_262_10.content)

				arg_259_1.text_.text = var_262_11

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_13 = 23 <= 0 and var_262_9 or var_262_9 * (utf8.len(var_262_11) / 23)

				if (23 <= 0 and var_262_9 or var_262_9 * (utf8.len(var_262_11) / 23)) > 0 and var_262_9 < var_262_13 then
					arg_259_1.talkMaxDuration = var_262_13

					if var_262_13 + var_262_8 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_13 + var_262_8
					end
				end

				arg_259_1.text_.text = var_262_11
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232061", "story_v_out_416232.awb") ~= 0 then
					local var_262_14 = manager.audio:GetVoiceLength("story_v_out_416232", "416232061", "story_v_out_416232.awb") / 1000

					if var_262_14 + var_262_8 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_14 + var_262_8
					end

					if var_262_10.prefab_name ~= "" and arg_259_1.actors_[var_262_10.prefab_name] ~= nil then
						local var_262_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_10.prefab_name].transform, "story_v_out_416232", "416232061", "story_v_out_416232.awb")

						arg_259_1:RecordAudio("416232061", var_262_15)
						arg_259_1:RecordAudio("416232061", var_262_15)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_416232", "416232061", "story_v_out_416232.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_416232", "416232061", "story_v_out_416232.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_16 = math.max(var_262_9, arg_259_1.talkMaxDuration)

			if var_262_8 <= arg_259_1.time_ and arg_259_1.time_ < var_262_8 + var_262_16 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_8) / var_262_16

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_8 + var_262_16 and arg_259_1.time_ < var_262_8 + var_262_16 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
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
	Play416232062 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 416232062
		arg_263_1.duration_ = 8.37

		local var_263_0 = {
			zh = 4.633,
			ja = 8.366
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
				arg_263_0:Play416232063(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(arg_263_1.actors_["10122"]) and arg_263_1.var_.actorSpriteComps10122 == nil then
				arg_263_1.var_.actorSpriteComps10122 = arg_263_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_0 = 0.2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 and not isNil(arg_263_1.actors_["10122"]) then
				if arg_263_1.var_.actorSpriteComps10122 then
					for iter_266_0, iter_266_1 in pairs(arg_263_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_266_1 then
							if arg_263_1.isInRecall_ then
								iter_266_1.color = Color.New(Mathf.Lerp(iter_266_1.color.r, arg_263_1.hightColor1.r, (arg_263_1.time_ - 0) / var_266_0), Mathf.Lerp(iter_266_1.color.g, arg_263_1.hightColor1.g, (arg_263_1.time_ - 0) / var_266_0), (Mathf.Lerp(iter_266_1.color.b, arg_263_1.hightColor1.b, (arg_263_1.time_ - 0) / var_266_0)))
							else
								local var_266_1 = Mathf.Lerp(iter_266_1.color.r, 1, (arg_263_1.time_ - 0) / var_266_0)

								iter_266_1.color = Color.New(var_266_1, var_266_1, var_266_1)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 and not isNil(arg_263_1.actors_["10122"]) and arg_263_1.var_.actorSpriteComps10122 then
				for iter_266_2, iter_266_3 in pairs(arg_263_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_266_3 then
						iter_266_3.color = arg_263_1.isInRecall_ and (arg_263_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_263_1.var_.actorSpriteComps10122 = nil
			end

			local var_266_2 = arg_263_1.actors_["10127"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_2) and arg_263_1.var_.actorSpriteComps10127 == nil then
				arg_263_1.var_.actorSpriteComps10127 = var_266_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_3 = 0.2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_3 and not isNil(var_266_2) then
				if arg_263_1.var_.actorSpriteComps10127 then
					for iter_266_4, iter_266_5 in pairs(arg_263_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_266_5 then
							if arg_263_1.isInRecall_ then
								iter_266_5.color = Color.New(Mathf.Lerp(iter_266_5.color.r, arg_263_1.hightColor2.r, (arg_263_1.time_ - 0) / var_266_3), Mathf.Lerp(iter_266_5.color.g, arg_263_1.hightColor2.g, (arg_263_1.time_ - 0) / var_266_3), (Mathf.Lerp(iter_266_5.color.b, arg_263_1.hightColor2.b, (arg_263_1.time_ - 0) / var_266_3)))
							else
								local var_266_4 = Mathf.Lerp(iter_266_5.color.r, 0.5, (arg_263_1.time_ - 0) / var_266_3)

								iter_266_5.color = Color.New(var_266_4, var_266_4, var_266_4)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= 0 + var_266_3 and arg_263_1.time_ < 0 + var_266_3 + arg_266_0 and not isNil(var_266_2) and arg_263_1.var_.actorSpriteComps10127 then
				for iter_266_6, iter_266_7 in pairs(arg_263_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_266_7 then
						iter_266_7.color = arg_263_1.isInRecall_ and (arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_263_1.var_.actorSpriteComps10127 = nil
			end

			local var_266_5 = arg_263_1.actors_["10122"].transform

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos10122 = var_266_5.localPosition
				var_266_5.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("10122", 2)

				for iter_266_8 = 0, var_266_5.childCount - 1 do
					local var_266_6 = var_266_5:GetChild(iter_266_8)

					if var_266_6.name == "split_4" or not string.find(var_266_6.name, "split") then
						var_266_6.gameObject:SetActive(true)
					else
						var_266_6.gameObject:SetActive(false)
					end
				end
			end

			local var_266_7 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_7 then
				var_266_5.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10122, Vector3.New(-390, -380, -100), (arg_263_1.time_ - 0) / var_266_7)
			end

			if arg_263_1.time_ >= 0 + var_266_7 and arg_263_1.time_ < 0 + var_266_7 + arg_266_0 then
				var_266_5.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_266_8 = 0
			local var_266_9 = 0.375

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_8 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_10 = arg_263_1:GetWordFromCfg(416232062)
				local var_266_11 = arg_263_1:FormatText(var_266_10.content)

				arg_263_1.text_.text = var_266_11

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_13 = 15 <= 0 and var_266_9 or var_266_9 * (utf8.len(var_266_11) / 15)

				if (15 <= 0 and var_266_9 or var_266_9 * (utf8.len(var_266_11) / 15)) > 0 and var_266_9 < var_266_13 then
					arg_263_1.talkMaxDuration = var_266_13

					if var_266_13 + var_266_8 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_13 + var_266_8
					end
				end

				arg_263_1.text_.text = var_266_11
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232062", "story_v_out_416232.awb") ~= 0 then
					local var_266_14 = manager.audio:GetVoiceLength("story_v_out_416232", "416232062", "story_v_out_416232.awb") / 1000

					if var_266_14 + var_266_8 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_14 + var_266_8
					end

					if var_266_10.prefab_name ~= "" and arg_263_1.actors_[var_266_10.prefab_name] ~= nil then
						local var_266_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_10.prefab_name].transform, "story_v_out_416232", "416232062", "story_v_out_416232.awb")

						arg_263_1:RecordAudio("416232062", var_266_15)
						arg_263_1:RecordAudio("416232062", var_266_15)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_416232", "416232062", "story_v_out_416232.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_416232", "416232062", "story_v_out_416232.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_16 = math.max(var_266_9, arg_263_1.talkMaxDuration)

			if var_266_8 <= arg_263_1.time_ and arg_263_1.time_ < var_266_8 + var_266_16 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_8) / var_266_16

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_8 + var_266_16 and arg_263_1.time_ < var_266_8 + var_266_16 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play416232063 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 416232063
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play416232064(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["10122"]) and arg_267_1.var_.actorSpriteComps10122 == nil then
				arg_267_1.var_.actorSpriteComps10122 = arg_267_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_0 = 0.2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["10122"]) then
				if arg_267_1.var_.actorSpriteComps10122 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								iter_270_1.color = Color.New(Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor2.r, (arg_267_1.time_ - 0) / var_270_0), Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor2.g, (arg_267_1.time_ - 0) / var_270_0), (Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor2.b, (arg_267_1.time_ - 0) / var_270_0)))
							else
								local var_270_1 = Mathf.Lerp(iter_270_1.color.r, 0.5, (arg_267_1.time_ - 0) / var_270_0)

								iter_270_1.color = Color.New(var_270_1, var_270_1, var_270_1)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["10122"]) and arg_267_1.var_.actorSpriteComps10122 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_270_3 then
						iter_270_3.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_267_1.var_.actorSpriteComps10122 = nil
			end

			local var_270_2 = 0
			local var_270_3 = 0.8

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_2 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_4 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(416232063).content)

				arg_267_1.text_.text = var_270_4

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_6 = 32 <= 0 and var_270_3 or var_270_3 * (utf8.len(var_270_4) / 32)

				if (32 <= 0 and var_270_3 or var_270_3 * (utf8.len(var_270_4) / 32)) > 0 and var_270_3 < var_270_6 then
					arg_267_1.talkMaxDuration = var_270_6

					if var_270_6 + var_270_2 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_6 + var_270_2
					end
				end

				arg_267_1.text_.text = var_270_4
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_3, arg_267_1.talkMaxDuration)

			if var_270_2 <= arg_267_1.time_ and arg_267_1.time_ < var_270_2 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_2) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_2 + var_270_7 and arg_267_1.time_ < var_270_2 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play416232064 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 416232064
		arg_271_1.duration_ = 6.27

		local var_271_0 = {
			zh = 5,
			ja = 6.266
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play416232065(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["10127"]) and arg_271_1.var_.actorSpriteComps10127 == nil then
				arg_271_1.var_.actorSpriteComps10127 = arg_271_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_0 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["10127"]) then
				if arg_271_1.var_.actorSpriteComps10127 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_274_1 then
							if arg_271_1.isInRecall_ then
								iter_274_1.color = Color.New(Mathf.Lerp(iter_274_1.color.r, arg_271_1.hightColor1.r, (arg_271_1.time_ - 0) / var_274_0), Mathf.Lerp(iter_274_1.color.g, arg_271_1.hightColor1.g, (arg_271_1.time_ - 0) / var_274_0), (Mathf.Lerp(iter_274_1.color.b, arg_271_1.hightColor1.b, (arg_271_1.time_ - 0) / var_274_0)))
							else
								local var_274_1 = Mathf.Lerp(iter_274_1.color.r, 1, (arg_271_1.time_ - 0) / var_274_0)

								iter_274_1.color = Color.New(var_274_1, var_274_1, var_274_1)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["10127"]) and arg_271_1.var_.actorSpriteComps10127 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_274_3 then
						iter_274_3.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_271_1.var_.actorSpriteComps10127 = nil
			end

			local var_274_2 = 0
			local var_274_3 = 0.65

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_2 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_4 = arg_271_1:GetWordFromCfg(416232064)
				local var_274_5 = arg_271_1:FormatText(var_274_4.content)

				arg_271_1.text_.text = var_274_5

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_7 = 26 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_5) / 26)

				if (26 <= 0 and var_274_3 or var_274_3 * (utf8.len(var_274_5) / 26)) > 0 and var_274_3 < var_274_7 then
					arg_271_1.talkMaxDuration = var_274_7

					if var_274_7 + var_274_2 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_7 + var_274_2
					end
				end

				arg_271_1.text_.text = var_274_5
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232064", "story_v_out_416232.awb") ~= 0 then
					local var_274_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232064", "story_v_out_416232.awb") / 1000

					if var_274_8 + var_274_2 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_8 + var_274_2
					end

					if var_274_4.prefab_name ~= "" and arg_271_1.actors_[var_274_4.prefab_name] ~= nil then
						local var_274_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_4.prefab_name].transform, "story_v_out_416232", "416232064", "story_v_out_416232.awb")

						arg_271_1:RecordAudio("416232064", var_274_9)
						arg_271_1:RecordAudio("416232064", var_274_9)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_416232", "416232064", "story_v_out_416232.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_416232", "416232064", "story_v_out_416232.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_10 = math.max(var_274_3, arg_271_1.talkMaxDuration)

			if var_274_2 <= arg_271_1.time_ and arg_271_1.time_ < var_274_2 + var_274_10 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_2) / var_274_10

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_2 + var_274_10 and arg_271_1.time_ < var_274_2 + var_274_10 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play416232065 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 416232065
		arg_275_1.duration_ = 5.87

		local var_275_0 = {
			zh = 4.8,
			ja = 5.866
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
				arg_275_0:Play416232066(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos10127 = arg_275_1.actors_["10127"].transform.localPosition
				arg_275_1.actors_["10127"].transform.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("10127", 4)

				for iter_278_0 = 0, arg_275_1.actors_["10127"].transform.childCount - 1 do
					local var_278_0 = arg_275_1.actors_["10127"].transform:GetChild(iter_278_0)

					if var_278_0.name == "" or not string.find(var_278_0.name, "split") then
						var_278_0.gameObject:SetActive(true)
					else
						var_278_0.gameObject:SetActive(false)
					end
				end
			end

			local var_278_1 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_1 then
				arg_275_1.actors_["10127"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10127, Vector3.New(345, -387.4, -316.5), (arg_275_1.time_ - 0) / var_278_1)
			end

			if arg_275_1.time_ >= 0 + var_278_1 and arg_275_1.time_ < 0 + var_278_1 + arg_278_0 then
				arg_275_1.actors_["10127"].transform.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_278_2 = 0
			local var_278_3 = 0.575

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_2 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_4 = arg_275_1:GetWordFromCfg(416232065)
				local var_278_5 = arg_275_1:FormatText(var_278_4.content)

				arg_275_1.text_.text = var_278_5

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_7 = 23 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_5) / 23)

				if (23 <= 0 and var_278_3 or var_278_3 * (utf8.len(var_278_5) / 23)) > 0 and var_278_3 < var_278_7 then
					arg_275_1.talkMaxDuration = var_278_7

					if var_278_7 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_7 + var_278_2
					end
				end

				arg_275_1.text_.text = var_278_5
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232065", "story_v_out_416232.awb") ~= 0 then
					local var_278_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232065", "story_v_out_416232.awb") / 1000

					if var_278_8 + var_278_2 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_8 + var_278_2
					end

					if var_278_4.prefab_name ~= "" and arg_275_1.actors_[var_278_4.prefab_name] ~= nil then
						local var_278_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_4.prefab_name].transform, "story_v_out_416232", "416232065", "story_v_out_416232.awb")

						arg_275_1:RecordAudio("416232065", var_278_9)
						arg_275_1:RecordAudio("416232065", var_278_9)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_416232", "416232065", "story_v_out_416232.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_416232", "416232065", "story_v_out_416232.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_10 = math.max(var_278_3, arg_275_1.talkMaxDuration)

			if var_278_2 <= arg_275_1.time_ and arg_275_1.time_ < var_278_2 + var_278_10 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_2) / var_278_10

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_2 + var_278_10 and arg_275_1.time_ < var_278_2 + var_278_10 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
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
	Play416232066 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 416232066
		arg_279_1.duration_ = 6.97

		local var_279_0 = {
			zh = 3.866,
			ja = 6.966
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
				arg_279_0:Play416232067(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["10122"]) and arg_279_1.var_.actorSpriteComps10122 == nil then
				arg_279_1.var_.actorSpriteComps10122 = arg_279_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_0 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["10122"]) then
				if arg_279_1.var_.actorSpriteComps10122 then
					for iter_282_0, iter_282_1 in pairs(arg_279_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["10122"]) and arg_279_1.var_.actorSpriteComps10122 then
				for iter_282_2, iter_282_3 in pairs(arg_279_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_282_3 then
						iter_282_3.color = arg_279_1.isInRecall_ and (arg_279_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_279_1.var_.actorSpriteComps10122 = nil
			end

			local var_282_2 = arg_279_1.actors_["10127"]

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(var_282_2) and arg_279_1.var_.actorSpriteComps10127 == nil then
				arg_279_1.var_.actorSpriteComps10127 = var_282_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_282_3 = 0.2

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_3 and not isNil(var_282_2) then
				if arg_279_1.var_.actorSpriteComps10127 then
					for iter_282_4, iter_282_5 in pairs(arg_279_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_279_1.time_ >= 0 + var_282_3 and arg_279_1.time_ < 0 + var_282_3 + arg_282_0 and not isNil(var_282_2) and arg_279_1.var_.actorSpriteComps10127 then
				for iter_282_6, iter_282_7 in pairs(arg_279_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_282_7 then
						iter_282_7.color = arg_279_1.isInRecall_ and (arg_279_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_279_1.var_.actorSpriteComps10127 = nil
			end

			local var_282_5 = 0
			local var_282_6 = 0.45

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_7 = arg_279_1:GetWordFromCfg(416232066)
				local var_282_8 = arg_279_1:FormatText(var_282_7.content)

				arg_279_1.text_.text = var_282_8

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_10 = 18 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_8) / 18)

				if (18 <= 0 and var_282_6 or var_282_6 * (utf8.len(var_282_8) / 18)) > 0 and var_282_6 < var_282_10 then
					arg_279_1.talkMaxDuration = var_282_10

					if var_282_10 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_10 + var_282_5
					end
				end

				arg_279_1.text_.text = var_282_8
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232066", "story_v_out_416232.awb") ~= 0 then
					local var_282_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232066", "story_v_out_416232.awb") / 1000

					if var_282_11 + var_282_5 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_11 + var_282_5
					end

					if var_282_7.prefab_name ~= "" and arg_279_1.actors_[var_282_7.prefab_name] ~= nil then
						local var_282_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_7.prefab_name].transform, "story_v_out_416232", "416232066", "story_v_out_416232.awb")

						arg_279_1:RecordAudio("416232066", var_282_12)
						arg_279_1:RecordAudio("416232066", var_282_12)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_416232", "416232066", "story_v_out_416232.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_416232", "416232066", "story_v_out_416232.awb")
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
	Play416232067 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 416232067
		arg_283_1.duration_ = 8.9

		local var_283_0 = {
			zh = 4.566,
			ja = 8.9
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
				arg_283_0:Play416232068(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos10122 = arg_283_1.actors_["10122"].transform.localPosition
				arg_283_1.actors_["10122"].transform.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("10122", 2)

				for iter_286_0 = 0, arg_283_1.actors_["10122"].transform.childCount - 1 do
					local var_286_0 = arg_283_1.actors_["10122"].transform:GetChild(iter_286_0)

					if var_286_0.name == "split_1" or not string.find(var_286_0.name, "split") then
						var_286_0.gameObject:SetActive(true)
					else
						var_286_0.gameObject:SetActive(false)
					end
				end
			end

			local var_286_1 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_1 then
				arg_283_1.actors_["10122"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10122, Vector3.New(-390, -380, -100), (arg_283_1.time_ - 0) / var_286_1)
			end

			if arg_283_1.time_ >= 0 + var_286_1 and arg_283_1.time_ < 0 + var_286_1 + arg_286_0 then
				arg_283_1.actors_["10122"].transform.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_286_2 = 0
			local var_286_3 = 0.475

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_2 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_4 = arg_283_1:GetWordFromCfg(416232067)
				local var_286_5 = arg_283_1:FormatText(var_286_4.content)

				arg_283_1.text_.text = var_286_5

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_7 = 19 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_5) / 19)

				if (19 <= 0 and var_286_3 or var_286_3 * (utf8.len(var_286_5) / 19)) > 0 and var_286_3 < var_286_7 then
					arg_283_1.talkMaxDuration = var_286_7

					if var_286_7 + var_286_2 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_7 + var_286_2
					end
				end

				arg_283_1.text_.text = var_286_5
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232067", "story_v_out_416232.awb") ~= 0 then
					local var_286_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232067", "story_v_out_416232.awb") / 1000

					if var_286_8 + var_286_2 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_8 + var_286_2
					end

					if var_286_4.prefab_name ~= "" and arg_283_1.actors_[var_286_4.prefab_name] ~= nil then
						local var_286_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_4.prefab_name].transform, "story_v_out_416232", "416232067", "story_v_out_416232.awb")

						arg_283_1:RecordAudio("416232067", var_286_9)
						arg_283_1:RecordAudio("416232067", var_286_9)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_416232", "416232067", "story_v_out_416232.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_416232", "416232067", "story_v_out_416232.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_10 = math.max(var_286_3, arg_283_1.talkMaxDuration)

			if var_286_2 <= arg_283_1.time_ and arg_283_1.time_ < var_286_2 + var_286_10 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_2) / var_286_10

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_2 + var_286_10 and arg_283_1.time_ < var_286_2 + var_286_10 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play416232068 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 416232068
		arg_287_1.duration_ = 1.7

		local var_287_0 = {
			zh = 1,
			ja = 1.7
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play416232069(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(arg_287_1.actors_["10127"]) and arg_287_1.var_.actorSpriteComps10127 == nil then
				arg_287_1.var_.actorSpriteComps10127 = arg_287_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_0 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 and not isNil(arg_287_1.actors_["10127"]) then
				if arg_287_1.var_.actorSpriteComps10127 then
					for iter_290_0, iter_290_1 in pairs(arg_287_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 and not isNil(arg_287_1.actors_["10127"]) and arg_287_1.var_.actorSpriteComps10127 then
				for iter_290_2, iter_290_3 in pairs(arg_287_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_290_3 then
						iter_290_3.color = arg_287_1.isInRecall_ and (arg_287_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_287_1.var_.actorSpriteComps10127 = nil
			end

			local var_290_2 = arg_287_1.actors_["10122"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_2) and arg_287_1.var_.actorSpriteComps10122 == nil then
				arg_287_1.var_.actorSpriteComps10122 = var_290_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_290_3 = 0.2

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_3 and not isNil(var_290_2) then
				if arg_287_1.var_.actorSpriteComps10122 then
					for iter_290_4, iter_290_5 in pairs(arg_287_1.var_.actorSpriteComps10122:ToTable()) do
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

			if arg_287_1.time_ >= 0 + var_290_3 and arg_287_1.time_ < 0 + var_290_3 + arg_290_0 and not isNil(var_290_2) and arg_287_1.var_.actorSpriteComps10122 then
				for iter_290_6, iter_290_7 in pairs(arg_287_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_290_7 then
						iter_290_7.color = arg_287_1.isInRecall_ and (arg_287_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_287_1.var_.actorSpriteComps10122 = nil
			end

			local var_290_5 = arg_287_1.actors_["10127"].transform

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos10127 = var_290_5.localPosition
				var_290_5.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("10127", 4)

				for iter_290_8 = 0, var_290_5.childCount - 1 do
					local var_290_6 = var_290_5:GetChild(iter_290_8)

					if var_290_6.name == "split_2" or not string.find(var_290_6.name, "split") then
						var_290_6.gameObject:SetActive(true)
					else
						var_290_6.gameObject:SetActive(false)
					end
				end
			end

			local var_290_7 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 then
				var_290_5.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10127, Vector3.New(345, -387.4, -316.5), (arg_287_1.time_ - 0) / var_290_7)
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 then
				var_290_5.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_290_8 = 0
			local var_290_9 = 0.125

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_8 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_10 = arg_287_1:GetWordFromCfg(416232068)
				local var_290_11 = arg_287_1:FormatText(var_290_10.content)

				arg_287_1.text_.text = var_290_11

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_13 = 5 <= 0 and var_290_9 or var_290_9 * (utf8.len(var_290_11) / 5)

				if (5 <= 0 and var_290_9 or var_290_9 * (utf8.len(var_290_11) / 5)) > 0 and var_290_9 < var_290_13 then
					arg_287_1.talkMaxDuration = var_290_13

					if var_290_13 + var_290_8 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_13 + var_290_8
					end
				end

				arg_287_1.text_.text = var_290_11
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232068", "story_v_out_416232.awb") ~= 0 then
					local var_290_14 = manager.audio:GetVoiceLength("story_v_out_416232", "416232068", "story_v_out_416232.awb") / 1000

					if var_290_14 + var_290_8 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_14 + var_290_8
					end

					if var_290_10.prefab_name ~= "" and arg_287_1.actors_[var_290_10.prefab_name] ~= nil then
						local var_290_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_10.prefab_name].transform, "story_v_out_416232", "416232068", "story_v_out_416232.awb")

						arg_287_1:RecordAudio("416232068", var_290_15)
						arg_287_1:RecordAudio("416232068", var_290_15)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_416232", "416232068", "story_v_out_416232.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_416232", "416232068", "story_v_out_416232.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_16 = math.max(var_290_9, arg_287_1.talkMaxDuration)

			if var_290_8 <= arg_287_1.time_ and arg_287_1.time_ < var_290_8 + var_290_16 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_8) / var_290_16

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_8 + var_290_16 and arg_287_1.time_ < var_290_8 + var_290_16 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play416232069 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 416232069
		arg_291_1.duration_ = 6.43

		local var_291_0 = {
			zh = 4.333,
			ja = 6.433
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
				arg_291_0:Play416232070(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["1028"]) and arg_291_1.var_.actorSpriteComps1028 == nil then
				arg_291_1.var_.actorSpriteComps1028 = arg_291_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_0 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["1028"]) then
				if arg_291_1.var_.actorSpriteComps1028 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["1028"]) and arg_291_1.var_.actorSpriteComps1028 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_294_3 then
						iter_294_3.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_291_1.var_.actorSpriteComps1028 = nil
			end

			local var_294_2 = arg_291_1.actors_["10127"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.actorSpriteComps10127 == nil then
				arg_291_1.var_.actorSpriteComps10127 = var_294_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_3 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_3 and not isNil(var_294_2) then
				if arg_291_1.var_.actorSpriteComps10127 then
					for iter_294_4, iter_294_5 in pairs(arg_291_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_291_1.time_ >= 0 + var_294_3 and arg_291_1.time_ < 0 + var_294_3 + arg_294_0 and not isNil(var_294_2) and arg_291_1.var_.actorSpriteComps10127 then
				for iter_294_6, iter_294_7 in pairs(arg_291_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_294_7 then
						iter_294_7.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_291_1.var_.actorSpriteComps10127 = nil
			end

			local var_294_5 = arg_291_1.actors_["10127"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos10127 = var_294_5.localPosition
				var_294_5.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("10127", 7)

				for iter_294_8 = 0, var_294_5.childCount - 1 do
					local var_294_6 = var_294_5:GetChild(iter_294_8)

					if var_294_6.name == "" or not string.find(var_294_6.name, "split") then
						var_294_6.gameObject:SetActive(true)
					else
						var_294_6.gameObject:SetActive(false)
					end
				end
			end

			local var_294_7 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_7 then
				var_294_5.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10127, Vector3.New(0, -2000, 0), (arg_291_1.time_ - 0) / var_294_7)
			end

			if arg_291_1.time_ >= 0 + var_294_7 and arg_291_1.time_ < 0 + var_294_7 + arg_294_0 then
				var_294_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_294_8 = arg_291_1.actors_["10122"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos10122 = var_294_8.localPosition
				var_294_8.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("10122", 7)

				for iter_294_9 = 0, var_294_8.childCount - 1 do
					local var_294_9 = var_294_8:GetChild(iter_294_9)

					if var_294_9.name == "" or not string.find(var_294_9.name, "split") then
						var_294_9.gameObject:SetActive(true)
					else
						var_294_9.gameObject:SetActive(false)
					end
				end
			end

			local var_294_10 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_10 then
				var_294_8.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10122, Vector3.New(0, -2000, 0), (arg_291_1.time_ - 0) / var_294_10)
			end

			if arg_291_1.time_ >= 0 + var_294_10 and arg_291_1.time_ < 0 + var_294_10 + arg_294_0 then
				var_294_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_294_11 = arg_291_1.actors_["1028"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1028 = var_294_11.localPosition
				var_294_11.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("1028", 3)

				for iter_294_10 = 0, var_294_11.childCount - 1 do
					local var_294_12 = var_294_11:GetChild(iter_294_10)

					if var_294_12.name == "split_6" or not string.find(var_294_12.name, "split") then
						var_294_12.gameObject:SetActive(true)
					else
						var_294_12.gameObject:SetActive(false)
					end
				end
			end

			local var_294_13 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_13 then
				var_294_11.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_291_1.time_ - 0) / var_294_13)
			end

			if arg_291_1.time_ >= 0 + var_294_13 and arg_291_1.time_ < 0 + var_294_13 + arg_294_0 then
				var_294_11.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_294_14 = 0
			local var_294_15 = 0.425

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_14 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_16 = arg_291_1:GetWordFromCfg(416232069)
				local var_294_17 = arg_291_1:FormatText(var_294_16.content)

				arg_291_1.text_.text = var_294_17

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_19 = 17 <= 0 and var_294_15 or var_294_15 * (utf8.len(var_294_17) / 17)

				if (17 <= 0 and var_294_15 or var_294_15 * (utf8.len(var_294_17) / 17)) > 0 and var_294_15 < var_294_19 then
					arg_291_1.talkMaxDuration = var_294_19

					if var_294_19 + var_294_14 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_19 + var_294_14
					end
				end

				arg_291_1.text_.text = var_294_17
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232069", "story_v_out_416232.awb") ~= 0 then
					local var_294_20 = manager.audio:GetVoiceLength("story_v_out_416232", "416232069", "story_v_out_416232.awb") / 1000

					if var_294_20 + var_294_14 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_20 + var_294_14
					end

					if var_294_16.prefab_name ~= "" and arg_291_1.actors_[var_294_16.prefab_name] ~= nil then
						local var_294_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_16.prefab_name].transform, "story_v_out_416232", "416232069", "story_v_out_416232.awb")

						arg_291_1:RecordAudio("416232069", var_294_21)
						arg_291_1:RecordAudio("416232069", var_294_21)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_416232", "416232069", "story_v_out_416232.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_416232", "416232069", "story_v_out_416232.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_22 = math.max(var_294_15, arg_291_1.talkMaxDuration)

			if var_294_14 <= arg_291_1.time_ and arg_291_1.time_ < var_294_14 + var_294_22 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_14) / var_294_22

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_14 + var_294_22 and arg_291_1.time_ < var_294_14 + var_294_22 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play416232070 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 416232070
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play416232071(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos1028 = arg_295_1.actors_["1028"].transform.localPosition
				arg_295_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("1028", 7)

				for iter_298_0 = 0, arg_295_1.actors_["1028"].transform.childCount - 1 do
					local var_298_0 = arg_295_1.actors_["1028"].transform:GetChild(iter_298_0)

					if var_298_0.name == "" or not string.find(var_298_0.name, "split") then
						var_298_0.gameObject:SetActive(true)
					else
						var_298_0.gameObject:SetActive(false)
					end
				end
			end

			local var_298_1 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_1 then
				arg_295_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_295_1.time_ - 0) / var_298_1)
			end

			if arg_295_1.time_ >= 0 + var_298_1 and arg_295_1.time_ < 0 + var_298_1 + arg_298_0 then
				arg_295_1.actors_["1028"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.05 < arg_295_1.time_ and arg_295_1.time_ <= 0.05 + arg_298_0 then
				arg_295_1:AudioAction("play", "effect", "se_story_138", "se_story_138_clap", "")
			end

			local var_298_3 = 0
			local var_298_4 = 1.05

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_3 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_5 = arg_295_1:FormatText(arg_295_1:GetWordFromCfg(416232070).content)

				arg_295_1.text_.text = var_298_5

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_7 = 42 <= 0 and var_298_4 or var_298_4 * (utf8.len(var_298_5) / 42)

				if (42 <= 0 and var_298_4 or var_298_4 * (utf8.len(var_298_5) / 42)) > 0 and var_298_4 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_3 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_3
					end
				end

				arg_295_1.text_.text = var_298_5
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_8 = math.max(var_298_4, arg_295_1.talkMaxDuration)

			if var_298_3 <= arg_295_1.time_ and arg_295_1.time_ < var_298_3 + var_298_8 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_3) / var_298_8

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_3 + var_298_8 and arg_295_1.time_ < var_298_3 + var_298_8 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
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
	Play416232071 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 416232071
		arg_299_1.duration_ = 4.67

		local var_299_0 = {
			zh = 2.766,
			ja = 4.666
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
				arg_299_0:Play416232072(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["1028"]) and arg_299_1.var_.actorSpriteComps1028 == nil then
				arg_299_1.var_.actorSpriteComps1028 = arg_299_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_0 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["1028"]) then
				if arg_299_1.var_.actorSpriteComps1028 then
					for iter_302_0, iter_302_1 in pairs(arg_299_1.var_.actorSpriteComps1028:ToTable()) do
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

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["1028"]) and arg_299_1.var_.actorSpriteComps1028 then
				for iter_302_2, iter_302_3 in pairs(arg_299_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_302_3 then
						iter_302_3.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_299_1.var_.actorSpriteComps1028 = nil
			end

			local var_302_2 = arg_299_1.actors_["1028"].transform

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos1028 = var_302_2.localPosition
				var_302_2.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("1028", 3)

				for iter_302_4 = 0, var_302_2.childCount - 1 do
					local var_302_3 = var_302_2:GetChild(iter_302_4)

					if var_302_3.name == "" or not string.find(var_302_3.name, "split") then
						var_302_3.gameObject:SetActive(true)
					else
						var_302_3.gameObject:SetActive(false)
					end
				end
			end

			local var_302_4 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				var_302_2.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_299_1.time_ - 0) / var_302_4)
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				var_302_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_302_5 = 0
			local var_302_6 = 0.35

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_5 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_7 = arg_299_1:GetWordFromCfg(416232071)
				local var_302_8 = arg_299_1:FormatText(var_302_7.content)

				arg_299_1.text_.text = var_302_8

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_10 = 14 <= 0 and var_302_6 or var_302_6 * (utf8.len(var_302_8) / 14)

				if (14 <= 0 and var_302_6 or var_302_6 * (utf8.len(var_302_8) / 14)) > 0 and var_302_6 < var_302_10 then
					arg_299_1.talkMaxDuration = var_302_10

					if var_302_10 + var_302_5 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_10 + var_302_5
					end
				end

				arg_299_1.text_.text = var_302_8
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232071", "story_v_out_416232.awb") ~= 0 then
					local var_302_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232071", "story_v_out_416232.awb") / 1000

					if var_302_11 + var_302_5 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_11 + var_302_5
					end

					if var_302_7.prefab_name ~= "" and arg_299_1.actors_[var_302_7.prefab_name] ~= nil then
						local var_302_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_7.prefab_name].transform, "story_v_out_416232", "416232071", "story_v_out_416232.awb")

						arg_299_1:RecordAudio("416232071", var_302_12)
						arg_299_1:RecordAudio("416232071", var_302_12)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_416232", "416232071", "story_v_out_416232.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_416232", "416232071", "story_v_out_416232.awb")
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

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play416232072 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 416232072
		arg_303_1.duration_ = 4.27

		local var_303_0 = {
			zh = 4.233,
			ja = 4.266
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
				arg_303_0:Play416232073(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(arg_303_1.actors_["1086"]) and arg_303_1.var_.actorSpriteComps1086 == nil then
				arg_303_1.var_.actorSpriteComps1086 = arg_303_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_0 = 0.2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_0 and not isNil(arg_303_1.actors_["1086"]) then
				if arg_303_1.var_.actorSpriteComps1086 then
					for iter_306_0, iter_306_1 in pairs(arg_303_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_306_1 then
							if arg_303_1.isInRecall_ then
								iter_306_1.color = Color.New(Mathf.Lerp(iter_306_1.color.r, arg_303_1.hightColor1.r, (arg_303_1.time_ - 0) / var_306_0), Mathf.Lerp(iter_306_1.color.g, arg_303_1.hightColor1.g, (arg_303_1.time_ - 0) / var_306_0), (Mathf.Lerp(iter_306_1.color.b, arg_303_1.hightColor1.b, (arg_303_1.time_ - 0) / var_306_0)))
							else
								local var_306_1 = Mathf.Lerp(iter_306_1.color.r, 1, (arg_303_1.time_ - 0) / var_306_0)

								iter_306_1.color = Color.New(var_306_1, var_306_1, var_306_1)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= 0 + var_306_0 and arg_303_1.time_ < 0 + var_306_0 + arg_306_0 and not isNil(arg_303_1.actors_["1086"]) and arg_303_1.var_.actorSpriteComps1086 then
				for iter_306_2, iter_306_3 in pairs(arg_303_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_306_3 then
						iter_306_3.color = arg_303_1.isInRecall_ and (arg_303_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_303_1.var_.actorSpriteComps1086 = nil
			end

			local var_306_2 = arg_303_1.actors_["1028"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_2) and arg_303_1.var_.actorSpriteComps1028 == nil then
				arg_303_1.var_.actorSpriteComps1028 = var_306_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_3 = 0.2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_3 and not isNil(var_306_2) then
				if arg_303_1.var_.actorSpriteComps1028 then
					for iter_306_4, iter_306_5 in pairs(arg_303_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_306_5 then
							if arg_303_1.isInRecall_ then
								iter_306_5.color = Color.New(Mathf.Lerp(iter_306_5.color.r, arg_303_1.hightColor2.r, (arg_303_1.time_ - 0) / var_306_3), Mathf.Lerp(iter_306_5.color.g, arg_303_1.hightColor2.g, (arg_303_1.time_ - 0) / var_306_3), (Mathf.Lerp(iter_306_5.color.b, arg_303_1.hightColor2.b, (arg_303_1.time_ - 0) / var_306_3)))
							else
								local var_306_4 = Mathf.Lerp(iter_306_5.color.r, 0.5, (arg_303_1.time_ - 0) / var_306_3)

								iter_306_5.color = Color.New(var_306_4, var_306_4, var_306_4)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= 0 + var_306_3 and arg_303_1.time_ < 0 + var_306_3 + arg_306_0 and not isNil(var_306_2) and arg_303_1.var_.actorSpriteComps1028 then
				for iter_306_6, iter_306_7 in pairs(arg_303_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_306_7 then
						iter_306_7.color = arg_303_1.isInRecall_ and (arg_303_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_303_1.var_.actorSpriteComps1028 = nil
			end

			local var_306_5 = arg_303_1.actors_["1028"].transform

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1028 = var_306_5.localPosition
				var_306_5.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("1028", 7)

				for iter_306_8 = 0, var_306_5.childCount - 1 do
					local var_306_6 = var_306_5:GetChild(iter_306_8)

					if var_306_6.name == "" or not string.find(var_306_6.name, "split") then
						var_306_6.gameObject:SetActive(true)
					else
						var_306_6.gameObject:SetActive(false)
					end
				end
			end

			local var_306_7 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_7 then
				var_306_5.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_303_1.time_ - 0) / var_306_7)
			end

			if arg_303_1.time_ >= 0 + var_306_7 and arg_303_1.time_ < 0 + var_306_7 + arg_306_0 then
				var_306_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_306_8 = arg_303_1.actors_["1086"].transform

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos1086 = var_306_8.localPosition
				var_306_8.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("1086", 3)

				for iter_306_9 = 0, var_306_8.childCount - 1 do
					local var_306_9 = var_306_8:GetChild(iter_306_9)

					if var_306_9.name == "" or not string.find(var_306_9.name, "split") then
						var_306_9.gameObject:SetActive(true)
					else
						var_306_9.gameObject:SetActive(false)
					end
				end
			end

			local var_306_10 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_10 then
				var_306_8.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_303_1.time_ - 0) / var_306_10)
			end

			if arg_303_1.time_ >= 0 + var_306_10 and arg_303_1.time_ < 0 + var_306_10 + arg_306_0 then
				var_306_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_306_11 = 0
			local var_306_12 = 0.475

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_11 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_13 = arg_303_1:GetWordFromCfg(416232072)
				local var_306_14 = arg_303_1:FormatText(var_306_13.content)

				arg_303_1.text_.text = var_306_14

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_16 = 19 <= 0 and var_306_12 or var_306_12 * (utf8.len(var_306_14) / 19)

				if (19 <= 0 and var_306_12 or var_306_12 * (utf8.len(var_306_14) / 19)) > 0 and var_306_12 < var_306_16 then
					arg_303_1.talkMaxDuration = var_306_16

					if var_306_16 + var_306_11 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_16 + var_306_11
					end
				end

				arg_303_1.text_.text = var_306_14
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232072", "story_v_out_416232.awb") ~= 0 then
					local var_306_17 = manager.audio:GetVoiceLength("story_v_out_416232", "416232072", "story_v_out_416232.awb") / 1000

					if var_306_17 + var_306_11 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_17 + var_306_11
					end

					if var_306_13.prefab_name ~= "" and arg_303_1.actors_[var_306_13.prefab_name] ~= nil then
						local var_306_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_13.prefab_name].transform, "story_v_out_416232", "416232072", "story_v_out_416232.awb")

						arg_303_1:RecordAudio("416232072", var_306_18)
						arg_303_1:RecordAudio("416232072", var_306_18)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_416232", "416232072", "story_v_out_416232.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_416232", "416232072", "story_v_out_416232.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_19 = math.max(var_306_12, arg_303_1.talkMaxDuration)

			if var_306_11 <= arg_303_1.time_ and arg_303_1.time_ < var_306_11 + var_306_19 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_11) / var_306_19

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_11 + var_306_19 and arg_303_1.time_ < var_306_11 + var_306_19 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
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
	Play416232073 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 416232073
		arg_307_1.duration_ = 9.63

		local var_307_0 = {
			zh = 5.466,
			ja = 9.633
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
				arg_307_0:Play416232074(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["10127"]) and arg_307_1.var_.actorSpriteComps10127 == nil then
				arg_307_1.var_.actorSpriteComps10127 = arg_307_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_0 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["10127"]) then
				if arg_307_1.var_.actorSpriteComps10127 then
					for iter_310_0, iter_310_1 in pairs(arg_307_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["10127"]) and arg_307_1.var_.actorSpriteComps10127 then
				for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_310_3 then
						iter_310_3.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_307_1.var_.actorSpriteComps10127 = nil
			end

			local var_310_2 = arg_307_1.actors_["1086"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_2) and arg_307_1.var_.actorSpriteComps1086 == nil then
				arg_307_1.var_.actorSpriteComps1086 = var_310_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_3 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_3 and not isNil(var_310_2) then
				if arg_307_1.var_.actorSpriteComps1086 then
					for iter_310_4, iter_310_5 in pairs(arg_307_1.var_.actorSpriteComps1086:ToTable()) do
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

			if arg_307_1.time_ >= 0 + var_310_3 and arg_307_1.time_ < 0 + var_310_3 + arg_310_0 and not isNil(var_310_2) and arg_307_1.var_.actorSpriteComps1086 then
				for iter_310_6, iter_310_7 in pairs(arg_307_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_310_7 then
						iter_310_7.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_307_1.var_.actorSpriteComps1086 = nil
			end

			local var_310_5 = arg_307_1.actors_["1086"].transform

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1086 = var_310_5.localPosition
				var_310_5.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("1086", 7)

				for iter_310_8 = 0, var_310_5.childCount - 1 do
					local var_310_6 = var_310_5:GetChild(iter_310_8)

					if var_310_6.name == "" or not string.find(var_310_6.name, "split") then
						var_310_6.gameObject:SetActive(true)
					else
						var_310_6.gameObject:SetActive(false)
					end
				end
			end

			local var_310_7 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_7 then
				var_310_5.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_307_1.time_ - 0) / var_310_7)
			end

			if arg_307_1.time_ >= 0 + var_310_7 and arg_307_1.time_ < 0 + var_310_7 + arg_310_0 then
				var_310_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_310_8 = arg_307_1.actors_["10127"].transform

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos10127 = var_310_8.localPosition
				var_310_8.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("10127", 3)

				for iter_310_9 = 0, var_310_8.childCount - 1 do
					local var_310_9 = var_310_8:GetChild(iter_310_9)

					if var_310_9.name == "" or not string.find(var_310_9.name, "split") then
						var_310_9.gameObject:SetActive(true)
					else
						var_310_9.gameObject:SetActive(false)
					end
				end
			end

			local var_310_10 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_10 then
				var_310_8.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos10127, Vector3.New(0, -387.4, -316.5), (arg_307_1.time_ - 0) / var_310_10)
			end

			if arg_307_1.time_ >= 0 + var_310_10 and arg_307_1.time_ < 0 + var_310_10 + arg_310_0 then
				var_310_8.localPosition = Vector3.New(0, -387.4, -316.5)
			end

			local var_310_11 = 0
			local var_310_12 = 0.575

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_11 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_13 = arg_307_1:GetWordFromCfg(416232073)
				local var_310_14 = arg_307_1:FormatText(var_310_13.content)

				arg_307_1.text_.text = var_310_14

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_16 = 23 <= 0 and var_310_12 or var_310_12 * (utf8.len(var_310_14) / 23)

				if (23 <= 0 and var_310_12 or var_310_12 * (utf8.len(var_310_14) / 23)) > 0 and var_310_12 < var_310_16 then
					arg_307_1.talkMaxDuration = var_310_16

					if var_310_16 + var_310_11 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_16 + var_310_11
					end
				end

				arg_307_1.text_.text = var_310_14
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232073", "story_v_out_416232.awb") ~= 0 then
					local var_310_17 = manager.audio:GetVoiceLength("story_v_out_416232", "416232073", "story_v_out_416232.awb") / 1000

					if var_310_17 + var_310_11 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_17 + var_310_11
					end

					if var_310_13.prefab_name ~= "" and arg_307_1.actors_[var_310_13.prefab_name] ~= nil then
						local var_310_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_13.prefab_name].transform, "story_v_out_416232", "416232073", "story_v_out_416232.awb")

						arg_307_1:RecordAudio("416232073", var_310_18)
						arg_307_1:RecordAudio("416232073", var_310_18)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_416232", "416232073", "story_v_out_416232.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_416232", "416232073", "story_v_out_416232.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_19 = math.max(var_310_12, arg_307_1.talkMaxDuration)

			if var_310_11 <= arg_307_1.time_ and arg_307_1.time_ < var_310_11 + var_310_19 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_11) / var_310_19

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_11 + var_310_19 and arg_307_1.time_ < var_310_11 + var_310_19 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play416232074 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 416232074
		arg_311_1.duration_ = 9.2

		local var_311_0 = {
			zh = 4.63266666666667,
			ja = 9.19966666666667
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
				arg_311_0:Play416232075(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if arg_311_1.bgs_.SS1610 == nil then
				local var_314_0 = Object.Instantiate(arg_311_1.paintGo_)

				var_314_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS1610")
				var_314_0.name = "SS1610"
				var_314_0.transform.parent = arg_311_1.stage_.transform
				var_314_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_311_1.bgs_.SS1610 = var_314_0
			end

			if 1.15 < arg_311_1.time_ and arg_311_1.time_ <= 1.15 + arg_314_0 then
				local var_314_1 = arg_311_1.bgs_.SS1610

				arg_311_1.bgs_.SS1610.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_314_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_314_2 = var_314_1:GetComponent("SpriteRenderer")

				if var_314_2 and var_314_2.sprite then
					local var_314_3 = 2 * (var_314_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_314_1.transform.localScale = Vector3.New(var_314_3 / var_314_2.sprite.bounds.size.y < var_314_3 * manager.ui.mainCameraCom_.aspect / var_314_2.sprite.bounds.size.x and var_314_3 * manager.ui.mainCameraCom_.aspect / var_314_2.sprite.bounds.size.x or var_314_3 / var_314_2.sprite.bounds.size.y, var_314_3 / var_314_2.sprite.bounds.size.y < var_314_3 * manager.ui.mainCameraCom_.aspect / var_314_2.sprite.bounds.size.x and var_314_3 * manager.ui.mainCameraCom_.aspect / var_314_2.sprite.bounds.size.x or var_314_3 / var_314_2.sprite.bounds.size.y, 0)
				end

				for iter_314_0, iter_314_1 in pairs(arg_311_1.bgs_) do
					if iter_314_0 ~= "SS1610" then
						iter_314_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_314_4 = 1.16666666666667

			if 1.16666666666667 < arg_311_1.time_ and arg_311_1.time_ <= var_314_4 + arg_314_0 then
				arg_311_1.allBtn_.enabled = false
			end

			if arg_311_1.time_ >= var_314_4 + 0.3 and arg_311_1.time_ < var_314_4 + 0.3 + arg_314_0 then
				arg_311_1.allBtn_.enabled = true
			end

			local var_314_5 = 0

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 then
				arg_311_1.mask_.enabled = true
				arg_311_1.mask_.raycastTarget = true

				arg_311_1:SetGaussion(false)
			end

			local var_314_6 = 1.16666666666667

			if var_314_5 <= arg_311_1.time_ and arg_311_1.time_ < var_314_5 + var_314_6 then
				local var_314_7 = Color.New(0, 0, 0)

				var_314_7.a = Mathf.Lerp(0, 1, (arg_311_1.time_ - var_314_5) / var_314_6)
				arg_311_1.mask_.color = var_314_7
			end

			if arg_311_1.time_ >= var_314_5 + var_314_6 and arg_311_1.time_ < var_314_5 + var_314_6 + arg_314_0 then
				local var_314_8 = Color.New(0, 0, 0)

				var_314_8.a = 1
				arg_311_1.mask_.color = var_314_8
			end

			local var_314_9 = 1.16666666666667

			if 1.16666666666667 < arg_311_1.time_ and arg_311_1.time_ <= var_314_9 + arg_314_0 then
				arg_311_1.mask_.enabled = true
				arg_311_1.mask_.raycastTarget = true

				arg_311_1:SetGaussion(false)
			end

			local var_314_10 = 1.825

			if var_314_9 <= arg_311_1.time_ and arg_311_1.time_ < var_314_9 + var_314_10 then
				local var_314_11 = Color.New(0, 0, 0)

				var_314_11.a = Mathf.Lerp(1, 0, (arg_311_1.time_ - var_314_9) / var_314_10)
				arg_311_1.mask_.color = var_314_11
			end

			if arg_311_1.time_ >= var_314_9 + var_314_10 and arg_311_1.time_ < var_314_9 + var_314_10 + arg_314_0 then
				local var_314_12 = Color.New(0, 0, 0)

				arg_311_1.mask_.enabled = false
				var_314_12.a = 0
				arg_311_1.mask_.color = var_314_12
			end

			local var_314_13 = arg_311_1.actors_["10127"].transform

			if 1.16666666666667 < arg_311_1.time_ and arg_311_1.time_ <= 1.16666666666667 + arg_314_0 then
				arg_311_1.var_.moveOldPos10127 = var_314_13.localPosition
				var_314_13.localScale = Vector3.New(1, 1, 1)

				arg_311_1:CheckSpriteTmpPos("10127", 7)

				for iter_314_2 = 0, var_314_13.childCount - 1 do
					local var_314_14 = var_314_13:GetChild(iter_314_2)

					if var_314_14.name == "" or not string.find(var_314_14.name, "split") then
						var_314_14.gameObject:SetActive(true)
					else
						var_314_14.gameObject:SetActive(false)
					end
				end
			end

			local var_314_15 = 0.001

			if 1.16666666666667 <= arg_311_1.time_ and arg_311_1.time_ < 1.16666666666667 + var_314_15 then
				var_314_13.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos10127, Vector3.New(0, -2000, 0), (arg_311_1.time_ - 1.16666666666667) / var_314_15)
			end

			if arg_311_1.time_ >= 1.16666666666667 + var_314_15 and arg_311_1.time_ < 1.16666666666667 + var_314_15 + arg_314_0 then
				var_314_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_314_16 = 1.16666666666667

			arg_311_1.isInRecall_ = false

			if var_314_16 < arg_311_1.time_ and arg_311_1.time_ <= var_314_16 + arg_314_0 then
				arg_311_1.screenFilterGo_:SetActive(false)

				for iter_314_3, iter_314_4 in pairs(arg_311_1.actors_) do
					for iter_314_5, iter_314_6 in ipairs((iter_314_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_314_6.color = iter_314_6.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_314_17 = 0.034

			if var_314_16 <= arg_311_1.time_ and arg_311_1.time_ < var_314_16 + var_314_17 then
				arg_311_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_311_1.time_ - var_314_16) / var_314_17)
			end

			if arg_311_1.time_ >= var_314_16 + var_314_17 and arg_311_1.time_ < var_314_16 + var_314_17 + arg_314_0 then
				arg_311_1.screenFilterEffect_.weight = 0
			end

			local var_314_18 = arg_311_1.bgs_.SS1610.transform

			if 1.16666666666667 < arg_311_1.time_ and arg_311_1.time_ <= 1.16666666666667 + arg_314_0 then
				arg_311_1.var_.moveOldPosSS1610 = var_314_18.localPosition
			end

			local var_314_19 = 0.001

			if 1.16666666666667 <= arg_311_1.time_ and arg_311_1.time_ < 1.16666666666667 + var_314_19 then
				var_314_18.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPosSS1610, Vector3.New(8, 1, 8), (arg_311_1.time_ - 1.16666666666667) / var_314_19)
			end

			if arg_311_1.time_ >= 1.16666666666667 + var_314_19 and arg_311_1.time_ < 1.16666666666667 + var_314_19 + arg_314_0 then
				var_314_18.localPosition = Vector3.New(8, 1, 8)
			end

			local var_314_20 = arg_311_1.bgs_.SS1610.transform

			if 1.20066666666667 < arg_311_1.time_ and arg_311_1.time_ <= 1.20066666666667 + arg_314_0 then
				arg_311_1.var_.moveOldPosSS1610 = var_314_20.localPosition
			end

			local var_314_21 = 2.39933333333333

			if 1.20066666666667 <= arg_311_1.time_ and arg_311_1.time_ < 1.20066666666667 + var_314_21 then
				var_314_20.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPosSS1610, Vector3.New(8, 1, 9), (arg_311_1.time_ - 1.20066666666667) / var_314_21)
			end

			if arg_311_1.time_ >= 1.20066666666667 + var_314_21 and arg_311_1.time_ < 1.20066666666667 + var_314_21 + arg_314_0 then
				var_314_20.localPosition = Vector3.New(8, 1, 9)
			end

			local var_314_22 = 2.86666666666667

			if 2.86666666666667 < arg_311_1.time_ and arg_311_1.time_ <= var_314_22 + arg_314_0 then
				arg_311_1.allBtn_.enabled = false
			end

			if arg_311_1.time_ >= var_314_22 + 0.733333333333333 and arg_311_1.time_ < var_314_22 + 0.733333333333333 + arg_314_0 then
				arg_311_1.allBtn_.enabled = true
			end

			if arg_311_1.frameCnt_ <= 1 then
				arg_311_1.dialog_:SetActive(false)
			end

			local var_314_23 = 2.86666666666667
			local var_314_24 = 0.125

			if 2.86666666666667 < arg_311_1.time_ and arg_311_1.time_ <= var_314_23 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0

				arg_311_1.dialog_:SetActive(true)

				arg_311_1.dialogCg_.alpha = 0

				local var_314_25 = LeanTween.value(arg_311_1.dialog_, 0, 1, 0.3)

				var_314_25:setOnUpdate(LuaHelper.FloatAction(function(arg_315_0)
					arg_311_1.dialogCg_.alpha = arg_315_0
				end))
				var_314_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_311_1.dialog_)
					var_314_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_311_1.duration_ = arg_311_1.duration_ + 0.3

				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_26 = arg_311_1:GetWordFromCfg(416232074)
				local var_314_27 = arg_311_1:FormatText(var_314_26.content)

				arg_311_1.text_.text = var_314_27

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_29 = 5 <= 0 and var_314_24 or var_314_24 * (utf8.len(var_314_27) / 5)

				if (5 <= 0 and var_314_24 or var_314_24 * (utf8.len(var_314_27) / 5)) > 0 and var_314_24 < var_314_29 then
					arg_311_1.talkMaxDuration = var_314_29
					var_314_23 = var_314_23 + 0.3

					if var_314_29 + var_314_23 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_29 + var_314_23
					end
				end

				arg_311_1.text_.text = var_314_27
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232074", "story_v_out_416232.awb") ~= 0 then
					local var_314_30 = manager.audio:GetVoiceLength("story_v_out_416232", "416232074", "story_v_out_416232.awb") / 1000

					if var_314_30 + var_314_23 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_30 + var_314_23
					end

					if var_314_26.prefab_name ~= "" and arg_311_1.actors_[var_314_26.prefab_name] ~= nil then
						local var_314_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_26.prefab_name].transform, "story_v_out_416232", "416232074", "story_v_out_416232.awb")

						arg_311_1:RecordAudio("416232074", var_314_31)
						arg_311_1:RecordAudio("416232074", var_314_31)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_416232", "416232074", "story_v_out_416232.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_416232", "416232074", "story_v_out_416232.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_32 = var_314_23 + 0.3
			local var_314_33 = math.max(var_314_24, arg_311_1.talkMaxDuration)

			if var_314_23 + 0.3 <= arg_311_1.time_ and arg_311_1.time_ < var_314_32 + var_314_33 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_32) / var_314_33

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_32 + var_314_33 and arg_311_1.time_ < var_314_32 + var_314_33 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "SS1610",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.16666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1610",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.39933333333333,
				className = "StoryMoveNode",
				startTime = 1.20066666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play416232075 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 416232075
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play416232076(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 1.5

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, false)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_1 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(416232075).content)

				arg_317_1.text_.text = var_320_1

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_3 = 60 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 60)

				if (60 <= 0 and var_320_0 or var_320_0 * (utf8.len(var_320_1) / 60)) > 0 and var_320_0 < var_320_3 then
					arg_317_1.talkMaxDuration = var_320_3

					if var_320_3 + 0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_3 + 0
					end
				end

				arg_317_1.text_.text = var_320_1
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_4 = math.max(var_320_0, arg_317_1.talkMaxDuration)

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_4 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - 0) / var_320_4

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= 0 + var_320_4 and arg_317_1.time_ < 0 + var_320_4 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play416232076 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 416232076
		arg_321_1.duration_ = 5.1

		local var_321_0 = {
			zh = 3.3,
			ja = 5.1
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play416232077(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.225

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_1 = arg_321_1:GetWordFromCfg(416232076)
				local var_324_2 = arg_321_1:FormatText(var_324_1.content)

				arg_321_1.text_.text = var_324_2

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 9 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 9)

				if (9 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 9)) > 0 and var_324_0 < var_324_4 then
					arg_321_1.talkMaxDuration = var_324_4

					if var_324_4 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_4 + 0
					end
				end

				arg_321_1.text_.text = var_324_2
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232076", "story_v_out_416232.awb") ~= 0 then
					local var_324_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232076", "story_v_out_416232.awb") / 1000

					if var_324_5 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + 0
					end

					if var_324_1.prefab_name ~= "" and arg_321_1.actors_[var_324_1.prefab_name] ~= nil then
						local var_324_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_1.prefab_name].transform, "story_v_out_416232", "416232076", "story_v_out_416232.awb")

						arg_321_1:RecordAudio("416232076", var_324_6)
						arg_321_1:RecordAudio("416232076", var_324_6)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_416232", "416232076", "story_v_out_416232.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_416232", "416232076", "story_v_out_416232.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_7 and arg_321_1.time_ < 0 + var_324_7 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play416232077 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 416232077
		arg_325_1.duration_ = 10.2

		local var_325_0 = {
			zh = 4.9,
			ja = 10.2
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play416232078(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.375

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_1 = arg_325_1:GetWordFromCfg(416232077)
				local var_328_2 = arg_325_1:FormatText(var_328_1.content)

				arg_325_1.text_.text = var_328_2

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 15 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 15)

				if (15 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 15)) > 0 and var_328_0 < var_328_4 then
					arg_325_1.talkMaxDuration = var_328_4

					if var_328_4 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_4 + 0
					end
				end

				arg_325_1.text_.text = var_328_2
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232077", "story_v_out_416232.awb") ~= 0 then
					local var_328_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232077", "story_v_out_416232.awb") / 1000

					if var_328_5 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + 0
					end

					if var_328_1.prefab_name ~= "" and arg_325_1.actors_[var_328_1.prefab_name] ~= nil then
						local var_328_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_1.prefab_name].transform, "story_v_out_416232", "416232077", "story_v_out_416232.awb")

						arg_325_1:RecordAudio("416232077", var_328_6)
						arg_325_1:RecordAudio("416232077", var_328_6)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_416232", "416232077", "story_v_out_416232.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_416232", "416232077", "story_v_out_416232.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play416232078 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 416232078
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play416232079(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 1.35

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_1 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(416232078).content)

				arg_329_1.text_.text = var_332_1

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_3 = 54 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 54)

				if (54 <= 0 and var_332_0 or var_332_0 * (utf8.len(var_332_1) / 54)) > 0 and var_332_0 < var_332_3 then
					arg_329_1.talkMaxDuration = var_332_3

					if var_332_3 + 0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_3 + 0
					end
				end

				arg_329_1.text_.text = var_332_1
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_4 = math.max(var_332_0, arg_329_1.talkMaxDuration)

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_4 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - 0) / var_332_4

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= 0 + var_332_4 and arg_329_1.time_ < 0 + var_332_4 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play416232079 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 416232079
		arg_333_1.duration_ = 13.6

		local var_333_0 = {
			zh = 7.966,
			ja = 13.6
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play416232080(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0.475

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_1 = arg_333_1:GetWordFromCfg(416232079)
				local var_336_2 = arg_333_1:FormatText(var_336_1.content)

				arg_333_1.text_.text = var_336_2

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_4 = 19 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 19)

				if (19 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 19)) > 0 and var_336_0 < var_336_4 then
					arg_333_1.talkMaxDuration = var_336_4

					if var_336_4 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_4 + 0
					end
				end

				arg_333_1.text_.text = var_336_2
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232079", "story_v_out_416232.awb") ~= 0 then
					local var_336_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232079", "story_v_out_416232.awb") / 1000

					if var_336_5 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + 0
					end

					if var_336_1.prefab_name ~= "" and arg_333_1.actors_[var_336_1.prefab_name] ~= nil then
						local var_336_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_1.prefab_name].transform, "story_v_out_416232", "416232079", "story_v_out_416232.awb")

						arg_333_1:RecordAudio("416232079", var_336_6)
						arg_333_1:RecordAudio("416232079", var_336_6)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_416232", "416232079", "story_v_out_416232.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_416232", "416232079", "story_v_out_416232.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_7 = math.max(var_336_0, arg_333_1.talkMaxDuration)

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_7 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - 0) / var_336_7

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= 0 + var_336_7 and arg_333_1.time_ < 0 + var_336_7 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play416232080 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 416232080
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play416232081(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 1.15

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_1 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(416232080).content)

				arg_337_1.text_.text = var_340_1

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_3 = 46 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 46)

				if (46 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 46)) > 0 and var_340_0 < var_340_3 then
					arg_337_1.talkMaxDuration = var_340_3

					if var_340_3 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_3 + 0
					end
				end

				arg_337_1.text_.text = var_340_1
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_4 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_4

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play416232081 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 416232081
		arg_341_1.duration_ = 10.2

		local var_341_0 = {
			zh = 7.166,
			ja = 10.2
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play416232082(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 0.525

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_1 = arg_341_1:GetWordFromCfg(416232081)
				local var_344_2 = arg_341_1:FormatText(var_344_1.content)

				arg_341_1.text_.text = var_344_2

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_4 = 21 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 21)

				if (21 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_2) / 21)) > 0 and var_344_0 < var_344_4 then
					arg_341_1.talkMaxDuration = var_344_4

					if var_344_4 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_4 + 0
					end
				end

				arg_341_1.text_.text = var_344_2
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232081", "story_v_out_416232.awb") ~= 0 then
					local var_344_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232081", "story_v_out_416232.awb") / 1000

					if var_344_5 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_5 + 0
					end

					if var_344_1.prefab_name ~= "" and arg_341_1.actors_[var_344_1.prefab_name] ~= nil then
						local var_344_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_1.prefab_name].transform, "story_v_out_416232", "416232081", "story_v_out_416232.awb")

						arg_341_1:RecordAudio("416232081", var_344_6)
						arg_341_1:RecordAudio("416232081", var_344_6)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_416232", "416232081", "story_v_out_416232.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_416232", "416232081", "story_v_out_416232.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_7 = math.max(var_344_0, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_7 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - 0) / var_344_7

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_7 and arg_341_1.time_ < 0 + var_344_7 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play416232082 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 416232082
		arg_345_1.duration_ = 8.27

		local var_345_0 = {
			zh = 7.9,
			ja = 8.266
		}
		local var_345_1 = manager.audio:GetLocalizationFlag()

		if var_345_0[var_345_1] ~= nil then
			arg_345_1.duration_ = var_345_0[var_345_1]
		end

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play416232083(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0.5 < arg_345_1.time_ and arg_345_1.time_ <= 0.5 + arg_348_0 then
				local var_348_0 = arg_345_1.var_.effect778

				if not arg_345_1.var_.effect778 then
					var_348_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_348_0.name = "778"
					arg_345_1.var_.effect778 = var_348_0
				else
					var_348_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_348_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_348_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.26666666666667 < arg_345_1.time_ and arg_345_1.time_ <= 1.26666666666667 + arg_348_0 then
				if arg_345_1.var_.effect778 then
					Object.Destroy(arg_345_1.var_.effect778)

					arg_345_1.var_.effect778 = nil
				end
			end

			local var_348_3 = 0

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_3 + arg_348_0 then
				arg_345_1.allBtn_.enabled = false
			end

			if arg_345_1.time_ >= var_348_3 + 1.73333333333333 and arg_345_1.time_ < var_348_3 + 1.73333333333333 + arg_348_0 then
				arg_345_1.allBtn_.enabled = true
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:AudioAction("play", "effect", "se_story_139", "se_story_2_stun_loop", "")
			end

			local var_348_5 = 0
			local var_348_6 = 0.625

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_5 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_7 = arg_345_1:GetWordFromCfg(416232082)
				local var_348_8 = arg_345_1:FormatText(var_348_7.content)

				arg_345_1.text_.text = var_348_8

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_10 = 25 <= 0 and var_348_6 or var_348_6 * (utf8.len(var_348_8) / 25)

				if (25 <= 0 and var_348_6 or var_348_6 * (utf8.len(var_348_8) / 25)) > 0 and var_348_6 < var_348_10 then
					arg_345_1.talkMaxDuration = var_348_10

					if var_348_10 + var_348_5 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_10 + var_348_5
					end
				end

				arg_345_1.text_.text = var_348_8
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232082", "story_v_out_416232.awb") ~= 0 then
					local var_348_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232082", "story_v_out_416232.awb") / 1000

					if var_348_11 + var_348_5 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_11 + var_348_5
					end

					if var_348_7.prefab_name ~= "" and arg_345_1.actors_[var_348_7.prefab_name] ~= nil then
						local var_348_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_7.prefab_name].transform, "story_v_out_416232", "416232082", "story_v_out_416232.awb")

						arg_345_1:RecordAudio("416232082", var_348_12)
						arg_345_1:RecordAudio("416232082", var_348_12)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_416232", "416232082", "story_v_out_416232.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_416232", "416232082", "story_v_out_416232.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_13 = math.max(var_348_6, arg_345_1.talkMaxDuration)

			if var_348_5 <= arg_345_1.time_ and arg_345_1.time_ < var_348_5 + var_348_13 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_5) / var_348_13

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_5 + var_348_13 and arg_345_1.time_ < var_348_5 + var_348_13 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play416232083 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 416232083
		arg_349_1.duration_ = 7.5

		local var_349_0 = {
			zh = 5.7,
			ja = 7.5
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play416232084(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0.525

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_1 = arg_349_1:GetWordFromCfg(416232083)
				local var_352_2 = arg_349_1:FormatText(var_352_1.content)

				arg_349_1.text_.text = var_352_2

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_4 = 21 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_2) / 21)

				if (21 <= 0 and var_352_0 or var_352_0 * (utf8.len(var_352_2) / 21)) > 0 and var_352_0 < var_352_4 then
					arg_349_1.talkMaxDuration = var_352_4

					if var_352_4 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_4 + 0
					end
				end

				arg_349_1.text_.text = var_352_2
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232083", "story_v_out_416232.awb") ~= 0 then
					local var_352_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232083", "story_v_out_416232.awb") / 1000

					if var_352_5 + 0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_5 + 0
					end

					if var_352_1.prefab_name ~= "" and arg_349_1.actors_[var_352_1.prefab_name] ~= nil then
						local var_352_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_1.prefab_name].transform, "story_v_out_416232", "416232083", "story_v_out_416232.awb")

						arg_349_1:RecordAudio("416232083", var_352_6)
						arg_349_1:RecordAudio("416232083", var_352_6)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_416232", "416232083", "story_v_out_416232.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_416232", "416232083", "story_v_out_416232.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_7 = math.max(var_352_0, arg_349_1.talkMaxDuration)

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_7 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - 0) / var_352_7

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= 0 + var_352_7 and arg_349_1.time_ < 0 + var_352_7 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play416232084 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 416232084
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play416232085(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 1.2

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, false)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_1 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(416232084).content)

				arg_353_1.text_.text = var_356_1

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_3 = 48 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 48)

				if (48 <= 0 and var_356_0 or var_356_0 * (utf8.len(var_356_1) / 48)) > 0 and var_356_0 < var_356_3 then
					arg_353_1.talkMaxDuration = var_356_3

					if var_356_3 + 0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_3 + 0
					end
				end

				arg_353_1.text_.text = var_356_1
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_4 = math.max(var_356_0, arg_353_1.talkMaxDuration)

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_4 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - 0) / var_356_4

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= 0 + var_356_4 and arg_353_1.time_ < 0 + var_356_4 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play416232085 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 416232085
		arg_357_1.duration_ = 10.6

		local var_357_0 = {
			zh = 9.2,
			ja = 10.6
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play416232086(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 0.6

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_1 = arg_357_1:GetWordFromCfg(416232085)
				local var_360_2 = arg_357_1:FormatText(var_360_1.content)

				arg_357_1.text_.text = var_360_2

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_4 = 24 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_2) / 24)

				if (24 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_2) / 24)) > 0 and var_360_0 < var_360_4 then
					arg_357_1.talkMaxDuration = var_360_4

					if var_360_4 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_4 + 0
					end
				end

				arg_357_1.text_.text = var_360_2
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232085", "story_v_out_416232.awb") ~= 0 then
					local var_360_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232085", "story_v_out_416232.awb") / 1000

					if var_360_5 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_5 + 0
					end

					if var_360_1.prefab_name ~= "" and arg_357_1.actors_[var_360_1.prefab_name] ~= nil then
						local var_360_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_1.prefab_name].transform, "story_v_out_416232", "416232085", "story_v_out_416232.awb")

						arg_357_1:RecordAudio("416232085", var_360_6)
						arg_357_1:RecordAudio("416232085", var_360_6)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_416232", "416232085", "story_v_out_416232.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_416232", "416232085", "story_v_out_416232.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_7 = math.max(var_360_0, arg_357_1.talkMaxDuration)

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_7 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - 0) / var_360_7

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= 0 + var_360_7 and arg_357_1.time_ < 0 + var_360_7 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play416232086 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 416232086
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play416232087(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.allBtn_.enabled = false
			end

			if arg_361_1.time_ >= 0 + 2.23333333333333 and arg_361_1.time_ < 0 + 2.23333333333333 + arg_364_0 then
				arg_361_1.allBtn_.enabled = true
			end

			local var_364_0 = 0
			local var_364_1 = 1.45

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_2 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(416232086).content)

				arg_361_1.text_.text = var_364_2

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_4 = 58 <= 0 and var_364_1 or var_364_1 * (utf8.len(var_364_2) / 58)

				if (58 <= 0 and var_364_1 or var_364_1 * (utf8.len(var_364_2) / 58)) > 0 and var_364_1 < var_364_4 then
					arg_361_1.talkMaxDuration = var_364_4

					if var_364_4 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_4 + var_364_0
					end
				end

				arg_361_1.text_.text = var_364_2
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_5 = math.max(var_364_1, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_5 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_0) / var_364_5

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_5 and arg_361_1.time_ < var_364_0 + var_364_5 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play416232087 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 416232087
		arg_365_1.duration_ = 11.1

		local var_365_0 = {
			zh = 6.1,
			ja = 11.1
		}
		local var_365_1 = manager.audio:GetLocalizationFlag()

		if var_365_0[var_365_1] ~= nil then
			arg_365_1.duration_ = var_365_0[var_365_1]
		end

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play416232088(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0.475

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_1 = arg_365_1:GetWordFromCfg(416232087)
				local var_368_2 = arg_365_1:FormatText(var_368_1.content)

				arg_365_1.text_.text = var_368_2

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_4 = 19 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 19)

				if (19 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 19)) > 0 and var_368_0 < var_368_4 then
					arg_365_1.talkMaxDuration = var_368_4

					if var_368_4 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_4 + 0
					end
				end

				arg_365_1.text_.text = var_368_2
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232087", "story_v_out_416232.awb") ~= 0 then
					local var_368_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232087", "story_v_out_416232.awb") / 1000

					if var_368_5 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + 0
					end

					if var_368_1.prefab_name ~= "" and arg_365_1.actors_[var_368_1.prefab_name] ~= nil then
						local var_368_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_1.prefab_name].transform, "story_v_out_416232", "416232087", "story_v_out_416232.awb")

						arg_365_1:RecordAudio("416232087", var_368_6)
						arg_365_1:RecordAudio("416232087", var_368_6)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_416232", "416232087", "story_v_out_416232.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_416232", "416232087", "story_v_out_416232.awb")
				end

				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_7 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_7 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_7

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_7 and arg_365_1.time_ < 0 + var_368_7 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play416232088 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 416232088
		arg_369_1.duration_ = 4.4

		local var_369_0 = {
			zh = 4.399999999999,
			ja = 3.132999999999
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
				arg_369_0:Play416232089(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.mask_.enabled = true
				arg_369_1.mask_.raycastTarget = true

				arg_369_1:SetGaussion(false)
			end

			local var_372_0 = 0.6

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 then
				local var_372_1 = Color.New(1, 1, 1)

				var_372_1.a = Mathf.Lerp(1, 0, (arg_369_1.time_ - 0) / var_372_0)
				arg_369_1.mask_.color = var_372_1
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 then
				local var_372_2 = Color.New(1, 1, 1)

				arg_369_1.mask_.enabled = false
				var_372_2.a = 0
				arg_369_1.mask_.color = var_372_2
			end

			local var_372_3 = manager.ui.mainCamera.transform

			if 0.208333333333333 < arg_369_1.time_ and arg_369_1.time_ <= 0.208333333333333 + arg_372_0 then
				arg_369_1.var_.shakeOldPos = var_372_3.localPosition
			end

			local var_372_4 = 0.666666666666667

			if 0.208333333333333 <= arg_369_1.time_ and arg_369_1.time_ < 0.208333333333333 + var_372_4 then
				local var_372_5, var_372_6 = math.modf((arg_369_1.time_ - 0.208333333333333) / 0.066)

				var_372_3.localPosition = Vector3.New(var_372_6 * 0.13, var_372_6 * 0.13, var_372_6 * 0.13) + arg_369_1.var_.shakeOldPos
			end

			if arg_369_1.time_ >= 0.208333333333333 + var_372_4 and arg_369_1.time_ < 0.208333333333333 + var_372_4 + arg_372_0 then
				var_372_3.localPosition = arg_369_1.var_.shakeOldPos
			end

			local var_372_7 = 0

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_7 + arg_372_0 then
				arg_369_1.allBtn_.enabled = false
			end

			if arg_369_1.time_ >= var_372_7 + 0.875 and arg_369_1.time_ < var_372_7 + 0.875 + arg_372_0 then
				arg_369_1.allBtn_.enabled = true
			end

			if arg_369_1.frameCnt_ <= 1 then
				arg_369_1.dialog_:SetActive(false)
			end

			local var_372_8 = 0.999999999999
			local var_372_9 = 0.275

			if 0.999999999999 < arg_369_1.time_ and arg_369_1.time_ <= var_372_8 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0

				arg_369_1.dialog_:SetActive(true)

				arg_369_1.dialogCg_.alpha = 0

				local var_372_10 = LeanTween.value(arg_369_1.dialog_, 0, 1, 0.3)

				var_372_10:setOnUpdate(LuaHelper.FloatAction(function(arg_373_0)
					arg_369_1.dialogCg_.alpha = arg_373_0
				end))
				var_372_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_369_1.dialog_)
					var_372_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_369_1.duration_ = arg_369_1.duration_ + 0.3

				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_11 = arg_369_1:GetWordFromCfg(416232088)
				local var_372_12 = arg_369_1:FormatText(var_372_11.content)

				arg_369_1.text_.text = var_372_12

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_14 = 11 <= 0 and var_372_9 or var_372_9 * (utf8.len(var_372_12) / 11)

				if (11 <= 0 and var_372_9 or var_372_9 * (utf8.len(var_372_12) / 11)) > 0 and var_372_9 < var_372_14 then
					arg_369_1.talkMaxDuration = var_372_14
					var_372_8 = var_372_8 + 0.3

					if var_372_14 + var_372_8 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_14 + var_372_8
					end
				end

				arg_369_1.text_.text = var_372_12
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232088", "story_v_out_416232.awb") ~= 0 then
					local var_372_15 = manager.audio:GetVoiceLength("story_v_out_416232", "416232088", "story_v_out_416232.awb") / 1000

					if var_372_15 + var_372_8 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_15 + var_372_8
					end

					if var_372_11.prefab_name ~= "" and arg_369_1.actors_[var_372_11.prefab_name] ~= nil then
						local var_372_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_11.prefab_name].transform, "story_v_out_416232", "416232088", "story_v_out_416232.awb")

						arg_369_1:RecordAudio("416232088", var_372_16)
						arg_369_1:RecordAudio("416232088", var_372_16)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_416232", "416232088", "story_v_out_416232.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_416232", "416232088", "story_v_out_416232.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_17 = var_372_8 + 0.3
			local var_372_18 = math.max(var_372_9, arg_369_1.talkMaxDuration)

			if var_372_8 + 0.3 <= arg_369_1.time_ and arg_369_1.time_ < var_372_17 + var_372_18 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_17) / var_372_18

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_17 + var_372_18 and arg_369_1.time_ < var_372_17 + var_372_18 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play416232089 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 416232089
		arg_375_1.duration_ = 7.13

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play416232090(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_9001
			local var_378_9000

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPosSS1610 = arg_375_1.bgs_.SS1610.transform.localPosition
			end

			local var_378_0 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 then
				arg_375_1.bgs_.SS1610.transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPosSS1610, Vector3.New(8, 1, 10), (arg_375_1.time_ - 0) / var_378_0)
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 then
				arg_375_1.bgs_.SS1610.transform.localPosition = Vector3.New(8, 1, 10)
			end

			local var_378_1 = arg_375_1.bgs_.SS1610.transform

			if 0.0166666666666667 < arg_375_1.time_ and arg_375_1.time_ <= 0.0166666666666667 + arg_378_0 then
				arg_375_1.var_.moveOldPosSS1610 = var_378_1.localPosition
			end

			local var_378_2 = 2.41666666666667

			if 0.0166666666666667 <= arg_375_1.time_ and arg_375_1.time_ < 0.0166666666666667 + var_378_2 then
				var_378_1.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPosSS1610, Vector3.New(-5.84, 1, 10), (arg_375_1.time_ - 0.0166666666666667) / var_378_2)
			end

			if arg_375_1.time_ >= 0.0166666666666667 + var_378_2 and arg_375_1.time_ < 0.0166666666666667 + var_378_2 + arg_378_0 then
				var_378_1.localPosition = Vector3.New(-5.84, 1, 10)
			end

			if 0.5 < arg_375_1.time_ and arg_375_1.time_ <= 0.5 + arg_378_0 then
				local var_378_3 = arg_375_1.var_.effect116

				if not arg_375_1.var_.effect116 then
					var_378_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), manager.ui.mainCamera.transform)
					var_378_3.name = "116"
					arg_375_1.var_.effect116 = var_378_3
				else
					var_378_3.transform:SetParent(var_378_9001)
				end

				var_378_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_378_3.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_378_5 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_378_0, iter_378_1 in ipairs((var_378_3.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_378_1.transform.localScale = Vector3.New(iter_378_1.transform.localScale.x / var_378_5 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_378_1.transform.localScale.y / var_378_5, iter_378_1.transform.localScale.z)
				end
			end

			if 1.1 < arg_375_1.time_ and arg_375_1.time_ <= 1.1 + arg_378_0 then
				if arg_375_1.var_.effect116 then
					Object.Destroy(arg_375_1.var_.effect116)

					arg_375_1.var_.effect116 = nil
				end
			end

			local var_378_8 = 0

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_8 + arg_378_0 then
				arg_375_1.allBtn_.enabled = false
			end

			if arg_375_1.time_ >= var_378_8 + 3.13333333333333 and arg_375_1.time_ < var_378_8 + 3.13333333333333 + arg_378_0 then
				arg_375_1.allBtn_.enabled = true
			end

			if 0.933333333333334 < arg_375_1.time_ and arg_375_1.time_ <= 0.933333333333334 + arg_378_0 then
				local var_378_9 = arg_375_1.var_.effect118

				if not arg_375_1.var_.effect118 then
					var_378_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), manager.ui.mainCamera.transform)
					var_378_9.name = "118"
					arg_375_1.var_.effect118 = var_378_9
				else
					var_378_9.transform:SetParent(var_378_9000)
				end

				var_378_9.transform.localPosition = Vector3.New(-0.55, 0.42, 0)
				var_378_9.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_378_11 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_378_2, iter_378_3 in ipairs((var_378_9.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_378_3.transform.localScale = Vector3.New(iter_378_3.transform.localScale.x / var_378_11 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_378_3.transform.localScale.y / var_378_11, iter_378_3.transform.localScale.z)
				end
			end

			if 1.53333333333333 < arg_375_1.time_ and arg_375_1.time_ <= 1.53333333333333 + arg_378_0 then
				if arg_375_1.var_.effect118 then
					Object.Destroy(arg_375_1.var_.effect118)

					arg_375_1.var_.effect118 = nil
				end
			end

			local var_378_14 = 1.4

			if 1.4 < arg_375_1.time_ and arg_375_1.time_ <= var_378_14 + arg_378_0 then
				arg_375_1.mask_.enabled = true
				arg_375_1.mask_.raycastTarget = true

				arg_375_1:SetGaussion(false)
			end

			local var_378_15 = 0.466666666666667

			if var_378_14 <= arg_375_1.time_ and arg_375_1.time_ < var_378_14 + var_378_15 then
				local var_378_16 = Color.New(1, 1, 1)

				var_378_16.a = Mathf.Lerp(1, 0, (arg_375_1.time_ - var_378_14) / var_378_15)
				arg_375_1.mask_.color = var_378_16
			end

			if arg_375_1.time_ >= var_378_14 + var_378_15 and arg_375_1.time_ < var_378_14 + var_378_15 + arg_378_0 then
				local var_378_17 = Color.New(1, 1, 1)

				arg_375_1.mask_.enabled = false
				var_378_17.a = 0
				arg_375_1.mask_.color = var_378_17
			end

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1:AudioAction("stop", "effect", "se_story_139", "se_story_2_stun_loop", "")
			end

			if 1.43333333333333 < arg_375_1.time_ and arg_375_1.time_ <= 1.43333333333333 + arg_378_0 then
				arg_375_1:AudioAction("play", "effect", "se_story_123_01", "se_story_123_01_explosion", "")
			end

			if 0.5 < arg_375_1.time_ and arg_375_1.time_ <= 0.5 + arg_378_0 then
				arg_375_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_thunder", "")
			end

			if arg_375_1.frameCnt_ <= 1 then
				arg_375_1.dialog_:SetActive(false)
			end

			local var_378_21 = 2.13333333333333
			local var_378_22 = 1.6

			if 2.13333333333333 < arg_375_1.time_ and arg_375_1.time_ <= var_378_21 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0

				arg_375_1.dialog_:SetActive(true)

				arg_375_1.dialogCg_.alpha = 0

				local var_378_23 = LeanTween.value(arg_375_1.dialog_, 0, 1, 0.3)

				var_378_23:setOnUpdate(LuaHelper.FloatAction(function(arg_379_0)
					arg_375_1.dialogCg_.alpha = arg_379_0
				end))
				var_378_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_375_1.dialog_)
					var_378_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_375_1.duration_ = arg_375_1.duration_ + 0.3

				SetActive(arg_375_1.leftNameGo_, false)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_24 = arg_375_1:FormatText(arg_375_1:GetWordFromCfg(416232089).content)

				arg_375_1.text_.text = var_378_24

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_26 = 64 <= 0 and var_378_22 or var_378_22 * (utf8.len(var_378_24) / 64)

				if (64 <= 0 and var_378_22 or var_378_22 * (utf8.len(var_378_24) / 64)) > 0 and var_378_22 < var_378_26 then
					arg_375_1.talkMaxDuration = var_378_26
					var_378_21 = var_378_21 + 0.3

					if var_378_26 + var_378_21 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_26 + var_378_21
					end
				end

				arg_375_1.text_.text = var_378_24
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)
				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_27 = var_378_21 + 0.3
			local var_378_28 = math.max(var_378_22, arg_375_1.talkMaxDuration)

			if var_378_21 + 0.3 <= arg_375_1.time_ and arg_375_1.time_ < var_378_27 + var_378_28 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_27) / var_378_28

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_27 + var_378_28 and arg_375_1.time_ < var_378_27 + var_378_28 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS1610",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS1610",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.41666666666667,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play416232090 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 416232090
		arg_381_1.duration_ = 3.13

		local var_381_0 = {
			zh = 2.133,
			ja = 3.133
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
				arg_381_0:Play416232091(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = 0.275

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_1 = arg_381_1:GetWordFromCfg(416232090)
				local var_384_2 = arg_381_1:FormatText(var_384_1.content)

				arg_381_1.text_.text = var_384_2

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_4 = 11 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 11)

				if (11 <= 0 and var_384_0 or var_384_0 * (utf8.len(var_384_2) / 11)) > 0 and var_384_0 < var_384_4 then
					arg_381_1.talkMaxDuration = var_384_4

					if var_384_4 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_4 + 0
					end
				end

				arg_381_1.text_.text = var_384_2
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232090", "story_v_out_416232.awb") ~= 0 then
					local var_384_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232090", "story_v_out_416232.awb") / 1000

					if var_384_5 + 0 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_5 + 0
					end

					if var_384_1.prefab_name ~= "" and arg_381_1.actors_[var_384_1.prefab_name] ~= nil then
						local var_384_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_1.prefab_name].transform, "story_v_out_416232", "416232090", "story_v_out_416232.awb")

						arg_381_1:RecordAudio("416232090", var_384_6)
						arg_381_1:RecordAudio("416232090", var_384_6)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_416232", "416232090", "story_v_out_416232.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_416232", "416232090", "story_v_out_416232.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_7 = math.max(var_384_0, arg_381_1.talkMaxDuration)

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_7 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - 0) / var_384_7

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= 0 + var_384_7 and arg_381_1.time_ < 0 + var_384_7 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play416232091 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 416232091
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play416232092(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0.1 < arg_385_1.time_ and arg_385_1.time_ <= 0.1 + arg_388_0 then
				arg_385_1:AudioAction("play", "effect", "se_story_139", "se_story_139_thunderenergy", "")
			end

			local var_388_1 = 0
			local var_388_2 = 1.325

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, false)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_3 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(416232091).content)

				arg_385_1.text_.text = var_388_3

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_5 = 53 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 53)

				if (53 <= 0 and var_388_2 or var_388_2 * (utf8.len(var_388_3) / 53)) > 0 and var_388_2 < var_388_5 then
					arg_385_1.talkMaxDuration = var_388_5

					if var_388_5 + var_388_1 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + var_388_1
					end
				end

				arg_385_1.text_.text = var_388_3
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_6 = math.max(var_388_2, arg_385_1.talkMaxDuration)

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_6 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_1) / var_388_6

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_1 + var_388_6 and arg_385_1.time_ < var_388_1 + var_388_6 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play416232092 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 416232092
		arg_389_1.duration_ = 1.9

		local var_389_0 = {
			zh = 1.9,
			ja = 1.566
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
				arg_389_0:Play416232093(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["1028"]) and arg_389_1.var_.actorSpriteComps1028 == nil then
				arg_389_1.var_.actorSpriteComps1028 = arg_389_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_0 = 0.2

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["1028"]) then
				if arg_389_1.var_.actorSpriteComps1028 then
					for iter_392_0, iter_392_1 in pairs(arg_389_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_392_1 then
							if arg_389_1.isInRecall_ then
								iter_392_1.color = Color.New(Mathf.Lerp(iter_392_1.color.r, arg_389_1.hightColor1.r, (arg_389_1.time_ - 0) / var_392_0), Mathf.Lerp(iter_392_1.color.g, arg_389_1.hightColor1.g, (arg_389_1.time_ - 0) / var_392_0), (Mathf.Lerp(iter_392_1.color.b, arg_389_1.hightColor1.b, (arg_389_1.time_ - 0) / var_392_0)))
							else
								local var_392_1 = Mathf.Lerp(iter_392_1.color.r, 1, (arg_389_1.time_ - 0) / var_392_0)

								iter_392_1.color = Color.New(var_392_1, var_392_1, var_392_1)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1028"]) and arg_389_1.var_.actorSpriteComps1028 then
				for iter_392_2, iter_392_3 in pairs(arg_389_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_392_3 then
						iter_392_3.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_389_1.var_.actorSpriteComps1028 = nil
			end

			local var_392_2 = 0
			local var_392_3 = 0.15

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_2 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_4 = arg_389_1:GetWordFromCfg(416232092)
				local var_392_5 = arg_389_1:FormatText(var_392_4.content)

				arg_389_1.text_.text = var_392_5

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_7 = 6 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_5) / 6)

				if (6 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_5) / 6)) > 0 and var_392_3 < var_392_7 then
					arg_389_1.talkMaxDuration = var_392_7

					if var_392_7 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_7 + var_392_2
					end
				end

				arg_389_1.text_.text = var_392_5
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232092", "story_v_out_416232.awb") ~= 0 then
					local var_392_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232092", "story_v_out_416232.awb") / 1000

					if var_392_8 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_8 + var_392_2
					end

					if var_392_4.prefab_name ~= "" and arg_389_1.actors_[var_392_4.prefab_name] ~= nil then
						local var_392_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_4.prefab_name].transform, "story_v_out_416232", "416232092", "story_v_out_416232.awb")

						arg_389_1:RecordAudio("416232092", var_392_9)
						arg_389_1:RecordAudio("416232092", var_392_9)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_416232", "416232092", "story_v_out_416232.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_416232", "416232092", "story_v_out_416232.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_10 = math.max(var_392_3, arg_389_1.talkMaxDuration)

			if var_392_2 <= arg_389_1.time_ and arg_389_1.time_ < var_392_2 + var_392_10 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_2) / var_392_10

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_2 + var_392_10 and arg_389_1.time_ < var_392_2 + var_392_10 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play416232093 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 416232093
		arg_393_1.duration_ = 3.77

		local var_393_0 = {
			zh = 2.33266666666667,
			ja = 3.76666666666667
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play416232094(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				local var_396_0 = arg_393_1.bgs_.STwhite

				arg_393_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_396_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_396_1 = var_396_0:GetComponent("SpriteRenderer")

				if var_396_1 and var_396_1.sprite then
					local var_396_2 = 2 * (var_396_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_396_0.transform.localScale = Vector3.New(var_396_2 / var_396_1.sprite.bounds.size.y < var_396_2 * manager.ui.mainCameraCom_.aspect / var_396_1.sprite.bounds.size.x and var_396_2 * manager.ui.mainCameraCom_.aspect / var_396_1.sprite.bounds.size.x or var_396_2 / var_396_1.sprite.bounds.size.y, var_396_2 / var_396_1.sprite.bounds.size.y < var_396_2 * manager.ui.mainCameraCom_.aspect / var_396_1.sprite.bounds.size.x and var_396_2 * manager.ui.mainCameraCom_.aspect / var_396_1.sprite.bounds.size.x or var_396_2 / var_396_1.sprite.bounds.size.y, 0)
				end

				for iter_396_0, iter_396_1 in pairs(arg_393_1.bgs_) do
					if iter_396_0 ~= "STwhite" then
						iter_396_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_396_3 = 0

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_3 + arg_396_0 then
				arg_393_1.allBtn_.enabled = false
			end

			if arg_393_1.time_ >= var_396_3 + 0.3 and arg_393_1.time_ < var_396_3 + 0.3 + arg_396_0 then
				arg_393_1.allBtn_.enabled = true
			end

			local var_396_4 = 0

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_4 + arg_396_0 then
				arg_393_1.mask_.enabled = true
				arg_393_1.mask_.raycastTarget = true

				arg_393_1:SetGaussion(false)
			end

			local var_396_5 = 1.63333333333333

			if var_396_4 <= arg_393_1.time_ and arg_393_1.time_ < var_396_4 + var_396_5 then
				local var_396_6 = Color.New(0, 0, 0)

				var_396_6.a = Mathf.Lerp(1, 0, (arg_393_1.time_ - var_396_4) / var_396_5)
				arg_393_1.mask_.color = var_396_6
			end

			if arg_393_1.time_ >= var_396_4 + var_396_5 and arg_393_1.time_ < var_396_4 + var_396_5 + arg_396_0 then
				local var_396_7 = Color.New(0, 0, 0)

				arg_393_1.mask_.enabled = false
				var_396_7.a = 0
				arg_393_1.mask_.color = var_396_7
			end

			local var_396_8 = arg_393_1.actors_["1028"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_8) and arg_393_1.var_.actorSpriteComps1028 == nil then
				arg_393_1.var_.actorSpriteComps1028 = var_396_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_9 = 0.2

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_9 and not isNil(var_396_8) then
				if arg_393_1.var_.actorSpriteComps1028 then
					for iter_396_2, iter_396_3 in pairs(arg_393_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_396_3 then
							if arg_393_1.isInRecall_ then
								iter_396_3.color = Color.New(Mathf.Lerp(iter_396_3.color.r, arg_393_1.hightColor1.r, (arg_393_1.time_ - 0) / var_396_9), Mathf.Lerp(iter_396_3.color.g, arg_393_1.hightColor1.g, (arg_393_1.time_ - 0) / var_396_9), (Mathf.Lerp(iter_396_3.color.b, arg_393_1.hightColor1.b, (arg_393_1.time_ - 0) / var_396_9)))
							else
								local var_396_10 = Mathf.Lerp(iter_396_3.color.r, 1, (arg_393_1.time_ - 0) / var_396_9)

								iter_396_3.color = Color.New(var_396_10, var_396_10, var_396_10)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= 0 + var_396_9 and arg_393_1.time_ < 0 + var_396_9 + arg_396_0 and not isNil(var_396_8) and arg_393_1.var_.actorSpriteComps1028 then
				for iter_396_4, iter_396_5 in pairs(arg_393_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_396_5 then
						iter_396_5.color = arg_393_1.isInRecall_ and (arg_393_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_393_1.var_.actorSpriteComps1028 = nil
			end

			if arg_393_1.frameCnt_ <= 1 then
				arg_393_1.dialog_:SetActive(false)
			end

			local var_396_11 = 0.566666666666667
			local var_396_12 = 0.125

			if 0.566666666666667 < arg_393_1.time_ and arg_393_1.time_ <= var_396_11 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0

				arg_393_1.dialog_:SetActive(true)

				arg_393_1.dialogCg_.alpha = 0

				local var_396_13 = LeanTween.value(arg_393_1.dialog_, 0, 1, 0.3)

				var_396_13:setOnUpdate(LuaHelper.FloatAction(function(arg_397_0)
					arg_393_1.dialogCg_.alpha = arg_397_0
				end))
				var_396_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_393_1.dialog_)
					var_396_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_393_1.duration_ = arg_393_1.duration_ + 0.3

				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, true)
				arg_393_1.iconController_:SetSelectedState("hero")

				arg_393_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028_split_3")

				arg_393_1.callingController_:SetSelectedState("normal")

				arg_393_1.keyicon_.color = Color.New(1, 1, 1)
				arg_393_1.icon_.color = Color.New(1, 1, 1)

				local var_396_14 = arg_393_1:GetWordFromCfg(416232093)
				local var_396_15 = arg_393_1:FormatText(var_396_14.content)

				arg_393_1.text_.text = var_396_15

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_17 = 5 <= 0 and var_396_12 or var_396_12 * (utf8.len(var_396_15) / 5)

				if (5 <= 0 and var_396_12 or var_396_12 * (utf8.len(var_396_15) / 5)) > 0 and var_396_12 < var_396_17 then
					arg_393_1.talkMaxDuration = var_396_17
					var_396_11 = var_396_11 + 0.3

					if var_396_17 + var_396_11 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_17 + var_396_11
					end
				end

				arg_393_1.text_.text = var_396_15
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232093", "story_v_out_416232.awb") ~= 0 then
					local var_396_18 = manager.audio:GetVoiceLength("story_v_out_416232", "416232093", "story_v_out_416232.awb") / 1000

					if var_396_18 + var_396_11 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_18 + var_396_11
					end

					if var_396_14.prefab_name ~= "" and arg_393_1.actors_[var_396_14.prefab_name] ~= nil then
						local var_396_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_14.prefab_name].transform, "story_v_out_416232", "416232093", "story_v_out_416232.awb")

						arg_393_1:RecordAudio("416232093", var_396_19)
						arg_393_1:RecordAudio("416232093", var_396_19)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_416232", "416232093", "story_v_out_416232.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_416232", "416232093", "story_v_out_416232.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_20 = var_396_11 + 0.3
			local var_396_21 = math.max(var_396_12, arg_393_1.talkMaxDuration)

			if var_396_11 + 0.3 <= arg_393_1.time_ and arg_393_1.time_ < var_396_20 + var_396_21 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_20) / var_396_21

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_20 + var_396_21 and arg_393_1.time_ < var_396_20 + var_396_21 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play416232094 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 416232094
		arg_399_1.duration_ = 5

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play416232095(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0.0249999999999999 < arg_399_1.time_ and arg_399_1.time_ <= 0.0249999999999999 + arg_402_0 then
				arg_399_1:AudioAction("play", "effect", "se_story_139", "se_story_139_thunderskill", "")
			end

			local var_402_1 = 0
			local var_402_2 = 1.025

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, false)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_3 = arg_399_1:FormatText(arg_399_1:GetWordFromCfg(416232094).content)

				arg_399_1.text_.text = var_402_3

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 41 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 41)

				if (41 <= 0 and var_402_2 or var_402_2 * (utf8.len(var_402_3) / 41)) > 0 and var_402_2 < var_402_5 then
					arg_399_1.talkMaxDuration = var_402_5

					if var_402_5 + var_402_1 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_5 + var_402_1
					end
				end

				arg_399_1.text_.text = var_402_3
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)
				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_6 = math.max(var_402_2, arg_399_1.talkMaxDuration)

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_6 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_1) / var_402_6

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_1 + var_402_6 and arg_399_1.time_ < var_402_1 + var_402_6 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play416232095 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 416232095
		arg_403_1.duration_ = 9.9

		local var_403_0 = {
			zh = 8.066,
			ja = 9.9
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play416232096(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 2.5 < arg_403_1.time_ and arg_403_1.time_ <= 2.5 + arg_406_0 then
				local var_406_0 = arg_403_1.bgs_.F09f

				arg_403_1.bgs_.F09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_406_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_406_1 = var_406_0:GetComponent("SpriteRenderer")

				if var_406_1 and var_406_1.sprite then
					local var_406_2 = 2 * (var_406_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_406_0.transform.localScale = Vector3.New(var_406_2 / var_406_1.sprite.bounds.size.y < var_406_2 * manager.ui.mainCameraCom_.aspect / var_406_1.sprite.bounds.size.x and var_406_2 * manager.ui.mainCameraCom_.aspect / var_406_1.sprite.bounds.size.x or var_406_2 / var_406_1.sprite.bounds.size.y, var_406_2 / var_406_1.sprite.bounds.size.y < var_406_2 * manager.ui.mainCameraCom_.aspect / var_406_1.sprite.bounds.size.x and var_406_2 * manager.ui.mainCameraCom_.aspect / var_406_1.sprite.bounds.size.x or var_406_2 / var_406_1.sprite.bounds.size.y, 0)
				end

				for iter_406_0, iter_406_1 in pairs(arg_403_1.bgs_) do
					if iter_406_0 ~= "F09f" then
						iter_406_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_406_3 = 2.5

			if 2.5 < arg_403_1.time_ and arg_403_1.time_ <= var_406_3 + arg_406_0 then
				arg_403_1.allBtn_.enabled = false
			end

			if arg_403_1.time_ >= var_406_3 + 0.3 and arg_403_1.time_ < var_406_3 + 0.3 + arg_406_0 then
				arg_403_1.allBtn_.enabled = true
			end

			local var_406_4 = 0

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_4 + arg_406_0 then
				arg_403_1.mask_.enabled = true
				arg_403_1.mask_.raycastTarget = true

				arg_403_1:SetGaussion(false)
			end

			local var_406_5 = 2.5

			if var_406_4 <= arg_403_1.time_ and arg_403_1.time_ < var_406_4 + var_406_5 then
				local var_406_6 = Color.New(0, 0, 0)

				var_406_6.a = Mathf.Lerp(0, 1, (arg_403_1.time_ - var_406_4) / var_406_5)
				arg_403_1.mask_.color = var_406_6
			end

			if arg_403_1.time_ >= var_406_4 + var_406_5 and arg_403_1.time_ < var_406_4 + var_406_5 + arg_406_0 then
				local var_406_7 = Color.New(0, 0, 0)

				var_406_7.a = 1
				arg_403_1.mask_.color = var_406_7
			end

			local var_406_8 = 2.5

			if 2.5 < arg_403_1.time_ and arg_403_1.time_ <= var_406_8 + arg_406_0 then
				arg_403_1.mask_.enabled = true
				arg_403_1.mask_.raycastTarget = true

				arg_403_1:SetGaussion(false)
			end

			local var_406_9 = 2

			if var_406_8 <= arg_403_1.time_ and arg_403_1.time_ < var_406_8 + var_406_9 then
				local var_406_10 = Color.New(0, 0, 0)

				var_406_10.a = Mathf.Lerp(1, 0, (arg_403_1.time_ - var_406_8) / var_406_9)
				arg_403_1.mask_.color = var_406_10
			end

			if arg_403_1.time_ >= var_406_8 + var_406_9 and arg_403_1.time_ < var_406_8 + var_406_9 + arg_406_0 then
				local var_406_11 = Color.New(0, 0, 0)

				arg_403_1.mask_.enabled = false
				var_406_11.a = 0
				arg_403_1.mask_.color = var_406_11
			end

			if 0.733333333333333 < arg_403_1.time_ and arg_403_1.time_ <= 0.733333333333333 + arg_406_0 then
				arg_403_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_406_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_403_1.bgmTxt_.text ~= var_406_14 and arg_403_1.bgmTxt_.text ~= "" then
						if arg_403_1.bgmTxt2_.text ~= "" then
							arg_403_1.bgmTxt_.text = arg_403_1.bgmTxt2_.text
						end

						arg_403_1.bgmTxt2_.text = var_406_14

						arg_403_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_403_1.bgmTxt_.text = var_406_14
						arg_403_1.bgmTxt2_.text = var_406_14
					end

					if arg_403_1.bgmTimer then
						arg_403_1.bgmTimer:Stop()

						arg_403_1.bgmTimer = nil
					end

					if arg_403_1.settingData.show_music_name == 1 then
						arg_403_1.musicController:SetSelectedState("show")
						arg_403_1.musicAnimator_:Play("open", 0, 0)

						if arg_403_1.settingData.music_time ~= 0 then
							arg_403_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_403_1.settingData.music_time), function()
								if arg_403_1 == nil or isNil(arg_403_1.bgmTxt_) then
									return
								end

								arg_403_1.musicController:SetSelectedState("hide")
								arg_403_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.2 < arg_403_1.time_ and arg_403_1.time_ <= 1.2 + arg_406_0 then
				arg_403_1:AudioAction("play", "music", "bgm_activity_3_4_story_seabed", "bgm_activity_3_4_story_seabed", "bgm_activity_3_4_story_seabed.awb")

				local var_406_17 = manager.audio:GetAudioName("bgm_activity_3_4_story_seabed", "bgm_activity_3_4_story_seabed")

				if "" ~= "" then
					if arg_403_1.bgmTxt_.text ~= var_406_17 and arg_403_1.bgmTxt_.text ~= "" then
						if arg_403_1.bgmTxt2_.text ~= "" then
							arg_403_1.bgmTxt_.text = arg_403_1.bgmTxt2_.text
						end

						arg_403_1.bgmTxt2_.text = var_406_17

						arg_403_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_403_1.bgmTxt_.text = var_406_17
						arg_403_1.bgmTxt2_.text = var_406_17
					end

					if arg_403_1.bgmTimer then
						arg_403_1.bgmTimer:Stop()

						arg_403_1.bgmTimer = nil
					end

					if arg_403_1.settingData.show_music_name == 1 then
						arg_403_1.musicController:SetSelectedState("show")
						arg_403_1.musicAnimator_:Play("open", 0, 0)

						if arg_403_1.settingData.music_time ~= 0 then
							arg_403_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_403_1.settingData.music_time), function()
								if arg_403_1 == nil or isNil(arg_403_1.bgmTxt_) then
									return
								end

								arg_403_1.musicController:SetSelectedState("hide")
								arg_403_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_403_1.frameCnt_ <= 1 then
				arg_403_1.dialog_:SetActive(false)
			end

			local var_406_18 = 4.5
			local var_406_19 = 0.2

			if 4.5 < arg_403_1.time_ and arg_403_1.time_ <= var_406_18 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0

				arg_403_1.dialog_:SetActive(true)

				arg_403_1.dialogCg_.alpha = 0

				local var_406_20 = LeanTween.value(arg_403_1.dialog_, 0, 1, 0.3)

				var_406_20:setOnUpdate(LuaHelper.FloatAction(function(arg_409_0)
					arg_403_1.dialogCg_.alpha = arg_409_0
				end))
				var_406_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_403_1.dialog_)
					var_406_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_403_1.duration_ = arg_403_1.duration_ + 0.3

				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, true)
				arg_403_1.iconController_:SetSelectedState("hero")

				arg_403_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10127_split_5")

				arg_403_1.callingController_:SetSelectedState("normal")

				arg_403_1.keyicon_.color = Color.New(1, 1, 1)
				arg_403_1.icon_.color = Color.New(1, 1, 1)

				local var_406_21 = arg_403_1:GetWordFromCfg(416232095)
				local var_406_22 = arg_403_1:FormatText(var_406_21.content)

				arg_403_1.text_.text = var_406_22

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_24 = 8 <= 0 and var_406_19 or var_406_19 * (utf8.len(var_406_22) / 8)

				if (8 <= 0 and var_406_19 or var_406_19 * (utf8.len(var_406_22) / 8)) > 0 and var_406_19 < var_406_24 then
					arg_403_1.talkMaxDuration = var_406_24
					var_406_18 = var_406_18 + 0.3

					if var_406_24 + var_406_18 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_24 + var_406_18
					end
				end

				arg_403_1.text_.text = var_406_22
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232095", "story_v_out_416232.awb") ~= 0 then
					local var_406_25 = manager.audio:GetVoiceLength("story_v_out_416232", "416232095", "story_v_out_416232.awb") / 1000

					if var_406_25 + var_406_18 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_25 + var_406_18
					end

					if var_406_21.prefab_name ~= "" and arg_403_1.actors_[var_406_21.prefab_name] ~= nil then
						local var_406_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_21.prefab_name].transform, "story_v_out_416232", "416232095", "story_v_out_416232.awb")

						arg_403_1:RecordAudio("416232095", var_406_26)
						arg_403_1:RecordAudio("416232095", var_406_26)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_416232", "416232095", "story_v_out_416232.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_416232", "416232095", "story_v_out_416232.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_27 = var_406_18 + 0.3
			local var_406_28 = math.max(var_406_19, arg_403_1.talkMaxDuration)

			if var_406_18 + 0.3 <= arg_403_1.time_ and arg_403_1.time_ < var_406_27 + var_406_28 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_27) / var_406_28

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_27 + var_406_28 and arg_403_1.time_ < var_406_27 + var_406_28 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play416232096 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 416232096
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play416232097(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 1.3

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_1 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(416232096).content)

				arg_411_1.text_.text = var_414_1

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_3 = 52 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 52)

				if (52 <= 0 and var_414_0 or var_414_0 * (utf8.len(var_414_1) / 52)) > 0 and var_414_0 < var_414_3 then
					arg_411_1.talkMaxDuration = var_414_3

					if var_414_3 + 0 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_3 + 0
					end
				end

				arg_411_1.text_.text = var_414_1
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_4 = math.max(var_414_0, arg_411_1.talkMaxDuration)

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_4 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - 0) / var_414_4

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= 0 + var_414_4 and arg_411_1.time_ < 0 + var_414_4 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play416232097 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 416232097
		arg_415_1.duration_ = 4.37

		local var_415_0 = {
			zh = 4.3,
			ja = 4.366
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play416232098(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(arg_415_1.actors_["1028"]) and arg_415_1.var_.actorSpriteComps1028 == nil then
				arg_415_1.var_.actorSpriteComps1028 = arg_415_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_0 = 0.2

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 and not isNil(arg_415_1.actors_["1028"]) then
				if arg_415_1.var_.actorSpriteComps1028 then
					for iter_418_0, iter_418_1 in pairs(arg_415_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_418_1 then
							if arg_415_1.isInRecall_ then
								iter_418_1.color = Color.New(Mathf.Lerp(iter_418_1.color.r, arg_415_1.hightColor1.r, (arg_415_1.time_ - 0) / var_418_0), Mathf.Lerp(iter_418_1.color.g, arg_415_1.hightColor1.g, (arg_415_1.time_ - 0) / var_418_0), (Mathf.Lerp(iter_418_1.color.b, arg_415_1.hightColor1.b, (arg_415_1.time_ - 0) / var_418_0)))
							else
								local var_418_1 = Mathf.Lerp(iter_418_1.color.r, 1, (arg_415_1.time_ - 0) / var_418_0)

								iter_418_1.color = Color.New(var_418_1, var_418_1, var_418_1)
							end
						end
					end
				end
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 and not isNil(arg_415_1.actors_["1028"]) and arg_415_1.var_.actorSpriteComps1028 then
				for iter_418_2, iter_418_3 in pairs(arg_415_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_418_3 then
						iter_418_3.color = arg_415_1.isInRecall_ and (arg_415_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_415_1.var_.actorSpriteComps1028 = nil
			end

			local var_418_2 = arg_415_1.actors_["1028"].transform

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.var_.moveOldPos1028 = var_418_2.localPosition
				var_418_2.localScale = Vector3.New(1, 1, 1)

				arg_415_1:CheckSpriteTmpPos("1028", 3)

				for iter_418_4 = 0, var_418_2.childCount - 1 do
					local var_418_3 = var_418_2:GetChild(iter_418_4)

					if var_418_3.name == "split_2" or not string.find(var_418_3.name, "split") then
						var_418_3.gameObject:SetActive(true)
					else
						var_418_3.gameObject:SetActive(false)
					end
				end
			end

			local var_418_4 = 0.001

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_4 then
				var_418_2.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_415_1.time_ - 0) / var_418_4)
			end

			if arg_415_1.time_ >= 0 + var_418_4 and arg_415_1.time_ < 0 + var_418_4 + arg_418_0 then
				var_418_2.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_418_5 = 0
			local var_418_6 = 0.55

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_5 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_7 = arg_415_1:GetWordFromCfg(416232097)
				local var_418_8 = arg_415_1:FormatText(var_418_7.content)

				arg_415_1.text_.text = var_418_8

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_10 = 22 <= 0 and var_418_6 or var_418_6 * (utf8.len(var_418_8) / 22)

				if (22 <= 0 and var_418_6 or var_418_6 * (utf8.len(var_418_8) / 22)) > 0 and var_418_6 < var_418_10 then
					arg_415_1.talkMaxDuration = var_418_10

					if var_418_10 + var_418_5 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_10 + var_418_5
					end
				end

				arg_415_1.text_.text = var_418_8
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232097", "story_v_out_416232.awb") ~= 0 then
					local var_418_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232097", "story_v_out_416232.awb") / 1000

					if var_418_11 + var_418_5 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_11 + var_418_5
					end

					if var_418_7.prefab_name ~= "" and arg_415_1.actors_[var_418_7.prefab_name] ~= nil then
						local var_418_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_7.prefab_name].transform, "story_v_out_416232", "416232097", "story_v_out_416232.awb")

						arg_415_1:RecordAudio("416232097", var_418_12)
						arg_415_1:RecordAudio("416232097", var_418_12)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_416232", "416232097", "story_v_out_416232.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_416232", "416232097", "story_v_out_416232.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_13 = math.max(var_418_6, arg_415_1.talkMaxDuration)

			if var_418_5 <= arg_415_1.time_ and arg_415_1.time_ < var_418_5 + var_418_13 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_5) / var_418_13

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_5 + var_418_13 and arg_415_1.time_ < var_418_5 + var_418_13 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play416232098 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 416232098
		arg_419_1.duration_ = 2.43

		local var_419_0 = {
			zh = 2.266,
			ja = 2.433
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play416232099(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0.1

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_1 = arg_419_1:GetWordFromCfg(416232098)
				local var_422_2 = arg_419_1:FormatText(var_422_1.content)

				arg_419_1.text_.text = var_422_2

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_4 = 4 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 4)

				if (4 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 4)) > 0 and var_422_0 < var_422_4 then
					arg_419_1.talkMaxDuration = var_422_4

					if var_422_4 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_4 + 0
					end
				end

				arg_419_1.text_.text = var_422_2
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232098", "story_v_out_416232.awb") ~= 0 then
					local var_422_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232098", "story_v_out_416232.awb") / 1000

					if var_422_5 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + 0
					end

					if var_422_1.prefab_name ~= "" and arg_419_1.actors_[var_422_1.prefab_name] ~= nil then
						local var_422_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_1.prefab_name].transform, "story_v_out_416232", "416232098", "story_v_out_416232.awb")

						arg_419_1:RecordAudio("416232098", var_422_6)
						arg_419_1:RecordAudio("416232098", var_422_6)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_416232", "416232098", "story_v_out_416232.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_416232", "416232098", "story_v_out_416232.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_7 = math.max(var_422_0, arg_419_1.talkMaxDuration)

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_7 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - 0) / var_422_7

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= 0 + var_422_7 and arg_419_1.time_ < 0 + var_422_7 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play416232099 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 416232099
		arg_423_1.duration_ = 8.5

		local var_423_0 = {
			zh = 8.433,
			ja = 8.5
		}
		local var_423_1 = manager.audio:GetLocalizationFlag()

		if var_423_0[var_423_1] ~= nil then
			arg_423_1.duration_ = var_423_0[var_423_1]
		end

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play416232100(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["1028"]) and arg_423_1.var_.actorSpriteComps1028 == nil then
				arg_423_1.var_.actorSpriteComps1028 = arg_423_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_426_0 = 0.2

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["1028"]) then
				if arg_423_1.var_.actorSpriteComps1028 then
					for iter_426_0, iter_426_1 in pairs(arg_423_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_426_1 then
							if arg_423_1.isInRecall_ then
								iter_426_1.color = Color.New(Mathf.Lerp(iter_426_1.color.r, arg_423_1.hightColor2.r, (arg_423_1.time_ - 0) / var_426_0), Mathf.Lerp(iter_426_1.color.g, arg_423_1.hightColor2.g, (arg_423_1.time_ - 0) / var_426_0), (Mathf.Lerp(iter_426_1.color.b, arg_423_1.hightColor2.b, (arg_423_1.time_ - 0) / var_426_0)))
							else
								local var_426_1 = Mathf.Lerp(iter_426_1.color.r, 0.5, (arg_423_1.time_ - 0) / var_426_0)

								iter_426_1.color = Color.New(var_426_1, var_426_1, var_426_1)
							end
						end
					end
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["1028"]) and arg_423_1.var_.actorSpriteComps1028 then
				for iter_426_2, iter_426_3 in pairs(arg_423_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_426_3 then
						iter_426_3.color = arg_423_1.isInRecall_ and (arg_423_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_423_1.var_.actorSpriteComps1028 = nil
			end

			local var_426_2 = 0
			local var_426_3 = 0.425

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_2 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, true)
				arg_423_1.iconController_:SetSelectedState("hero")

				arg_423_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_423_1.callingController_:SetSelectedState("normal")

				arg_423_1.keyicon_.color = Color.New(1, 1, 1)
				arg_423_1.icon_.color = Color.New(1, 1, 1)

				local var_426_4 = arg_423_1:GetWordFromCfg(416232099)
				local var_426_5 = arg_423_1:FormatText(var_426_4.content)

				arg_423_1.text_.text = var_426_5

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_7 = 17 <= 0 and var_426_3 or var_426_3 * (utf8.len(var_426_5) / 17)

				if (17 <= 0 and var_426_3 or var_426_3 * (utf8.len(var_426_5) / 17)) > 0 and var_426_3 < var_426_7 then
					arg_423_1.talkMaxDuration = var_426_7

					if var_426_7 + var_426_2 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_2
					end
				end

				arg_423_1.text_.text = var_426_5
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232099", "story_v_out_416232.awb") ~= 0 then
					local var_426_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232099", "story_v_out_416232.awb") / 1000

					if var_426_8 + var_426_2 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_8 + var_426_2
					end

					if var_426_4.prefab_name ~= "" and arg_423_1.actors_[var_426_4.prefab_name] ~= nil then
						local var_426_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_4.prefab_name].transform, "story_v_out_416232", "416232099", "story_v_out_416232.awb")

						arg_423_1:RecordAudio("416232099", var_426_9)
						arg_423_1:RecordAudio("416232099", var_426_9)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_416232", "416232099", "story_v_out_416232.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_416232", "416232099", "story_v_out_416232.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_10 = math.max(var_426_3, arg_423_1.talkMaxDuration)

			if var_426_2 <= arg_423_1.time_ and arg_423_1.time_ < var_426_2 + var_426_10 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_2) / var_426_10

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_2 + var_426_10 and arg_423_1.time_ < var_426_2 + var_426_10 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play416232100 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 416232100
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play416232101(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(arg_427_1.actors_["10109"]) and arg_427_1.var_.actorSpriteComps10109 == nil then
				arg_427_1.var_.actorSpriteComps10109 = arg_427_1.actors_["10109"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_430_0 = 0.2

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_0 and not isNil(arg_427_1.actors_["10109"]) then
				if arg_427_1.var_.actorSpriteComps10109 then
					for iter_430_0, iter_430_1 in pairs(arg_427_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_430_1 then
							if arg_427_1.isInRecall_ then
								iter_430_1.color = Color.New(Mathf.Lerp(iter_430_1.color.r, arg_427_1.hightColor2.r, (arg_427_1.time_ - 0) / var_430_0), Mathf.Lerp(iter_430_1.color.g, arg_427_1.hightColor2.g, (arg_427_1.time_ - 0) / var_430_0), (Mathf.Lerp(iter_430_1.color.b, arg_427_1.hightColor2.b, (arg_427_1.time_ - 0) / var_430_0)))
							else
								local var_430_1 = Mathf.Lerp(iter_430_1.color.r, 0.5, (arg_427_1.time_ - 0) / var_430_0)

								iter_430_1.color = Color.New(var_430_1, var_430_1, var_430_1)
							end
						end
					end
				end
			end

			if arg_427_1.time_ >= 0 + var_430_0 and arg_427_1.time_ < 0 + var_430_0 + arg_430_0 and not isNil(arg_427_1.actors_["10109"]) and arg_427_1.var_.actorSpriteComps10109 then
				for iter_430_2, iter_430_3 in pairs(arg_427_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_430_3 then
						iter_430_3.color = arg_427_1.isInRecall_ and (arg_427_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_427_1.var_.actorSpriteComps10109 = nil
			end

			local var_430_2 = arg_427_1.actors_["1028"].transform

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos1028 = var_430_2.localPosition
				var_430_2.localScale = Vector3.New(1, 1, 1)

				arg_427_1:CheckSpriteTmpPos("1028", 7)

				for iter_430_4 = 0, var_430_2.childCount - 1 do
					local var_430_3 = var_430_2:GetChild(iter_430_4)

					if var_430_3.name == "" or not string.find(var_430_3.name, "split") then
						var_430_3.gameObject:SetActive(true)
					else
						var_430_3.gameObject:SetActive(false)
					end
				end
			end

			local var_430_4 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_4 then
				var_430_2.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_427_1.time_ - 0) / var_430_4)
			end

			if arg_427_1.time_ >= 0 + var_430_4 and arg_427_1.time_ < 0 + var_430_4 + arg_430_0 then
				var_430_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.2 < arg_427_1.time_ and arg_427_1.time_ <= 0.2 + arg_430_0 then
				arg_427_1:AudioAction("play", "effect", "se_story_16", "se_story_16_thunder", "")
			end

			local var_430_6 = 0
			local var_430_7 = 1.525

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_6 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_8 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(416232100).content)

				arg_427_1.text_.text = var_430_8

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_10 = 61 <= 0 and var_430_7 or var_430_7 * (utf8.len(var_430_8) / 61)

				if (61 <= 0 and var_430_7 or var_430_7 * (utf8.len(var_430_8) / 61)) > 0 and var_430_7 < var_430_10 then
					arg_427_1.talkMaxDuration = var_430_10

					if var_430_10 + var_430_6 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_10 + var_430_6
					end
				end

				arg_427_1.text_.text = var_430_8
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_11 = math.max(var_430_7, arg_427_1.talkMaxDuration)

			if var_430_6 <= arg_427_1.time_ and arg_427_1.time_ < var_430_6 + var_430_11 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_6) / var_430_11

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_6 + var_430_11 and arg_427_1.time_ < var_430_6 + var_430_11 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_427_1:InitPlayNodeList()
	end,
	Play416232101 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 416232101
		arg_431_1.duration_ = 7.23

		local var_431_0 = {
			zh = 5.133,
			ja = 7.233
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play416232102(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 and not isNil(arg_431_1.actors_["10109"]) and arg_431_1.var_.actorSpriteComps10109 == nil then
				arg_431_1.var_.actorSpriteComps10109 = arg_431_1.actors_["10109"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_434_0 = 0.2

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 and not isNil(arg_431_1.actors_["10109"]) then
				if arg_431_1.var_.actorSpriteComps10109 then
					for iter_434_0, iter_434_1 in pairs(arg_431_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_434_1 then
							if arg_431_1.isInRecall_ then
								iter_434_1.color = Color.New(Mathf.Lerp(iter_434_1.color.r, arg_431_1.hightColor1.r, (arg_431_1.time_ - 0) / var_434_0), Mathf.Lerp(iter_434_1.color.g, arg_431_1.hightColor1.g, (arg_431_1.time_ - 0) / var_434_0), (Mathf.Lerp(iter_434_1.color.b, arg_431_1.hightColor1.b, (arg_431_1.time_ - 0) / var_434_0)))
							else
								local var_434_1 = Mathf.Lerp(iter_434_1.color.r, 1, (arg_431_1.time_ - 0) / var_434_0)

								iter_434_1.color = Color.New(var_434_1, var_434_1, var_434_1)
							end
						end
					end
				end
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 and not isNil(arg_431_1.actors_["10109"]) and arg_431_1.var_.actorSpriteComps10109 then
				for iter_434_2, iter_434_3 in pairs(arg_431_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_434_3 then
						iter_434_3.color = arg_431_1.isInRecall_ and (arg_431_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_431_1.var_.actorSpriteComps10109 = nil
			end

			local var_434_2 = 0
			local var_434_3 = 0.175

			if 0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_2 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				arg_431_1.leftNameTxt_.text = arg_431_1:FormatText(StoryNameCfg[1093].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4044")

				arg_431_1.callingController_:SetSelectedState("normal")

				arg_431_1.keyicon_.color = Color.New(1, 1, 1)
				arg_431_1.icon_.color = Color.New(1, 1, 1)

				local var_434_4 = arg_431_1:GetWordFromCfg(416232101)
				local var_434_5 = arg_431_1:FormatText(var_434_4.content)

				arg_431_1.text_.text = var_434_5

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_7 = 7 <= 0 and var_434_3 or var_434_3 * (utf8.len(var_434_5) / 7)

				if (7 <= 0 and var_434_3 or var_434_3 * (utf8.len(var_434_5) / 7)) > 0 and var_434_3 < var_434_7 then
					arg_431_1.talkMaxDuration = var_434_7

					if var_434_7 + var_434_2 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_7 + var_434_2
					end
				end

				arg_431_1.text_.text = var_434_5
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232101", "story_v_out_416232.awb") ~= 0 then
					local var_434_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232101", "story_v_out_416232.awb") / 1000

					if var_434_8 + var_434_2 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_8 + var_434_2
					end

					if var_434_4.prefab_name ~= "" and arg_431_1.actors_[var_434_4.prefab_name] ~= nil then
						local var_434_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_4.prefab_name].transform, "story_v_out_416232", "416232101", "story_v_out_416232.awb")

						arg_431_1:RecordAudio("416232101", var_434_9)
						arg_431_1:RecordAudio("416232101", var_434_9)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_416232", "416232101", "story_v_out_416232.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_416232", "416232101", "story_v_out_416232.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_10 = math.max(var_434_3, arg_431_1.talkMaxDuration)

			if var_434_2 <= arg_431_1.time_ and arg_431_1.time_ < var_434_2 + var_434_10 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_2) / var_434_10

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_2 + var_434_10 and arg_431_1.time_ < var_434_2 + var_434_10 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play416232102 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 416232102
		arg_435_1.duration_ = 4.87

		local var_435_0 = {
			zh = 4.4,
			ja = 4.866
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play416232103(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(arg_435_1.actors_["1028"]) and arg_435_1.var_.actorSpriteComps1028 == nil then
				arg_435_1.var_.actorSpriteComps1028 = arg_435_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_438_0 = 0.2

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_0 and not isNil(arg_435_1.actors_["1028"]) then
				if arg_435_1.var_.actorSpriteComps1028 then
					for iter_438_0, iter_438_1 in pairs(arg_435_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_438_1 then
							if arg_435_1.isInRecall_ then
								iter_438_1.color = Color.New(Mathf.Lerp(iter_438_1.color.r, arg_435_1.hightColor1.r, (arg_435_1.time_ - 0) / var_438_0), Mathf.Lerp(iter_438_1.color.g, arg_435_1.hightColor1.g, (arg_435_1.time_ - 0) / var_438_0), (Mathf.Lerp(iter_438_1.color.b, arg_435_1.hightColor1.b, (arg_435_1.time_ - 0) / var_438_0)))
							else
								local var_438_1 = Mathf.Lerp(iter_438_1.color.r, 1, (arg_435_1.time_ - 0) / var_438_0)

								iter_438_1.color = Color.New(var_438_1, var_438_1, var_438_1)
							end
						end
					end
				end
			end

			if arg_435_1.time_ >= 0 + var_438_0 and arg_435_1.time_ < 0 + var_438_0 + arg_438_0 and not isNil(arg_435_1.actors_["1028"]) and arg_435_1.var_.actorSpriteComps1028 then
				for iter_438_2, iter_438_3 in pairs(arg_435_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_438_3 then
						iter_438_3.color = arg_435_1.isInRecall_ and (arg_435_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_435_1.var_.actorSpriteComps1028 = nil
			end

			local var_438_2 = arg_435_1.actors_["10109"]

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 and not isNil(var_438_2) and arg_435_1.var_.actorSpriteComps10109 == nil then
				arg_435_1.var_.actorSpriteComps10109 = var_438_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_438_3 = 0.2

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_3 and not isNil(var_438_2) then
				if arg_435_1.var_.actorSpriteComps10109 then
					for iter_438_4, iter_438_5 in pairs(arg_435_1.var_.actorSpriteComps10109:ToTable()) do
						if iter_438_5 then
							if arg_435_1.isInRecall_ then
								iter_438_5.color = Color.New(Mathf.Lerp(iter_438_5.color.r, arg_435_1.hightColor2.r, (arg_435_1.time_ - 0) / var_438_3), Mathf.Lerp(iter_438_5.color.g, arg_435_1.hightColor2.g, (arg_435_1.time_ - 0) / var_438_3), (Mathf.Lerp(iter_438_5.color.b, arg_435_1.hightColor2.b, (arg_435_1.time_ - 0) / var_438_3)))
							else
								local var_438_4 = Mathf.Lerp(iter_438_5.color.r, 0.5, (arg_435_1.time_ - 0) / var_438_3)

								iter_438_5.color = Color.New(var_438_4, var_438_4, var_438_4)
							end
						end
					end
				end
			end

			if arg_435_1.time_ >= 0 + var_438_3 and arg_435_1.time_ < 0 + var_438_3 + arg_438_0 and not isNil(var_438_2) and arg_435_1.var_.actorSpriteComps10109 then
				for iter_438_6, iter_438_7 in pairs(arg_435_1.var_.actorSpriteComps10109:ToTable()) do
					if iter_438_7 then
						iter_438_7.color = arg_435_1.isInRecall_ and (arg_435_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_435_1.var_.actorSpriteComps10109 = nil
			end

			local var_438_5 = arg_435_1.actors_["1028"].transform

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= 0 + arg_438_0 then
				arg_435_1.var_.moveOldPos1028 = var_438_5.localPosition
				var_438_5.localScale = Vector3.New(1, 1, 1)

				arg_435_1:CheckSpriteTmpPos("1028", 2)

				for iter_438_8 = 0, var_438_5.childCount - 1 do
					local var_438_6 = var_438_5:GetChild(iter_438_8)

					if var_438_6.name == "" or not string.find(var_438_6.name, "split") then
						var_438_6.gameObject:SetActive(true)
					else
						var_438_6.gameObject:SetActive(false)
					end
				end
			end

			local var_438_7 = 0.001

			if 0 <= arg_435_1.time_ and arg_435_1.time_ < 0 + var_438_7 then
				var_438_5.localPosition = Vector3.Lerp(arg_435_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_435_1.time_ - 0) / var_438_7)
			end

			if arg_435_1.time_ >= 0 + var_438_7 and arg_435_1.time_ < 0 + var_438_7 + arg_438_0 then
				var_438_5.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_438_8 = 0
			local var_438_9 = 0.375

			if 0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_8 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				arg_435_1.leftNameTxt_.text = arg_435_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, false)
				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_10 = arg_435_1:GetWordFromCfg(416232102)
				local var_438_11 = arg_435_1:FormatText(var_438_10.content)

				arg_435_1.text_.text = var_438_11

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_13 = 15 <= 0 and var_438_9 or var_438_9 * (utf8.len(var_438_11) / 15)

				if (15 <= 0 and var_438_9 or var_438_9 * (utf8.len(var_438_11) / 15)) > 0 and var_438_9 < var_438_13 then
					arg_435_1.talkMaxDuration = var_438_13

					if var_438_13 + var_438_8 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_13 + var_438_8
					end
				end

				arg_435_1.text_.text = var_438_11
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232102", "story_v_out_416232.awb") ~= 0 then
					local var_438_14 = manager.audio:GetVoiceLength("story_v_out_416232", "416232102", "story_v_out_416232.awb") / 1000

					if var_438_14 + var_438_8 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_14 + var_438_8
					end

					if var_438_10.prefab_name ~= "" and arg_435_1.actors_[var_438_10.prefab_name] ~= nil then
						local var_438_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_10.prefab_name].transform, "story_v_out_416232", "416232102", "story_v_out_416232.awb")

						arg_435_1:RecordAudio("416232102", var_438_15)
						arg_435_1:RecordAudio("416232102", var_438_15)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_416232", "416232102", "story_v_out_416232.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_416232", "416232102", "story_v_out_416232.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_16 = math.max(var_438_9, arg_435_1.talkMaxDuration)

			if var_438_8 <= arg_435_1.time_ and arg_435_1.time_ < var_438_8 + var_438_16 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_8) / var_438_16

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_8 + var_438_16 and arg_435_1.time_ < var_438_8 + var_438_16 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_435_1:InitPlayNodeList()
	end,
	Play416232103 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 416232103
		arg_439_1.duration_ = 6.2

		local var_439_0 = {
			zh = 4.666,
			ja = 6.2
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play416232104(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(arg_439_1.actors_["10127"]) and arg_439_1.var_.actorSpriteComps10127 == nil then
				arg_439_1.var_.actorSpriteComps10127 = arg_439_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_442_0 = 0.2

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_0 and not isNil(arg_439_1.actors_["10127"]) then
				if arg_439_1.var_.actorSpriteComps10127 then
					for iter_442_0, iter_442_1 in pairs(arg_439_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_442_1 then
							if arg_439_1.isInRecall_ then
								iter_442_1.color = Color.New(Mathf.Lerp(iter_442_1.color.r, arg_439_1.hightColor1.r, (arg_439_1.time_ - 0) / var_442_0), Mathf.Lerp(iter_442_1.color.g, arg_439_1.hightColor1.g, (arg_439_1.time_ - 0) / var_442_0), (Mathf.Lerp(iter_442_1.color.b, arg_439_1.hightColor1.b, (arg_439_1.time_ - 0) / var_442_0)))
							else
								local var_442_1 = Mathf.Lerp(iter_442_1.color.r, 1, (arg_439_1.time_ - 0) / var_442_0)

								iter_442_1.color = Color.New(var_442_1, var_442_1, var_442_1)
							end
						end
					end
				end
			end

			if arg_439_1.time_ >= 0 + var_442_0 and arg_439_1.time_ < 0 + var_442_0 + arg_442_0 and not isNil(arg_439_1.actors_["10127"]) and arg_439_1.var_.actorSpriteComps10127 then
				for iter_442_2, iter_442_3 in pairs(arg_439_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_442_3 then
						iter_442_3.color = arg_439_1.isInRecall_ and (arg_439_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_439_1.var_.actorSpriteComps10127 = nil
			end

			local var_442_2 = arg_439_1.actors_["1028"]

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 and not isNil(var_442_2) and arg_439_1.var_.actorSpriteComps1028 == nil then
				arg_439_1.var_.actorSpriteComps1028 = var_442_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_442_3 = 0.2

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_3 and not isNil(var_442_2) then
				if arg_439_1.var_.actorSpriteComps1028 then
					for iter_442_4, iter_442_5 in pairs(arg_439_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_442_5 then
							if arg_439_1.isInRecall_ then
								iter_442_5.color = Color.New(Mathf.Lerp(iter_442_5.color.r, arg_439_1.hightColor2.r, (arg_439_1.time_ - 0) / var_442_3), Mathf.Lerp(iter_442_5.color.g, arg_439_1.hightColor2.g, (arg_439_1.time_ - 0) / var_442_3), (Mathf.Lerp(iter_442_5.color.b, arg_439_1.hightColor2.b, (arg_439_1.time_ - 0) / var_442_3)))
							else
								local var_442_4 = Mathf.Lerp(iter_442_5.color.r, 0.5, (arg_439_1.time_ - 0) / var_442_3)

								iter_442_5.color = Color.New(var_442_4, var_442_4, var_442_4)
							end
						end
					end
				end
			end

			if arg_439_1.time_ >= 0 + var_442_3 and arg_439_1.time_ < 0 + var_442_3 + arg_442_0 and not isNil(var_442_2) and arg_439_1.var_.actorSpriteComps1028 then
				for iter_442_6, iter_442_7 in pairs(arg_439_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_442_7 then
						iter_442_7.color = arg_439_1.isInRecall_ and (arg_439_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_439_1.var_.actorSpriteComps1028 = nil
			end

			local var_442_5 = arg_439_1.actors_["10127"].transform

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= 0 + arg_442_0 then
				arg_439_1.var_.moveOldPos10127 = var_442_5.localPosition
				var_442_5.localScale = Vector3.New(1, 1, 1)

				arg_439_1:CheckSpriteTmpPos("10127", 4)

				for iter_442_8 = 0, var_442_5.childCount - 1 do
					local var_442_6 = var_442_5:GetChild(iter_442_8)

					if var_442_6.name == "split_5" or not string.find(var_442_6.name, "split") then
						var_442_6.gameObject:SetActive(true)
					else
						var_442_6.gameObject:SetActive(false)
					end
				end
			end

			local var_442_7 = 0.001

			if 0 <= arg_439_1.time_ and arg_439_1.time_ < 0 + var_442_7 then
				var_442_5.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos10127, Vector3.New(345, -387.4, -316.5), (arg_439_1.time_ - 0) / var_442_7)
			end

			if arg_439_1.time_ >= 0 + var_442_7 and arg_439_1.time_ < 0 + var_442_7 + arg_442_0 then
				var_442_5.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_442_8 = 0
			local var_442_9 = 0.45

			if 0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_8 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				arg_439_1.leftNameTxt_.text = arg_439_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_10 = arg_439_1:GetWordFromCfg(416232103)
				local var_442_11 = arg_439_1:FormatText(var_442_10.content)

				arg_439_1.text_.text = var_442_11

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_13 = 18 <= 0 and var_442_9 or var_442_9 * (utf8.len(var_442_11) / 18)

				if (18 <= 0 and var_442_9 or var_442_9 * (utf8.len(var_442_11) / 18)) > 0 and var_442_9 < var_442_13 then
					arg_439_1.talkMaxDuration = var_442_13

					if var_442_13 + var_442_8 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_13 + var_442_8
					end
				end

				arg_439_1.text_.text = var_442_11
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232103", "story_v_out_416232.awb") ~= 0 then
					local var_442_14 = manager.audio:GetVoiceLength("story_v_out_416232", "416232103", "story_v_out_416232.awb") / 1000

					if var_442_14 + var_442_8 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_14 + var_442_8
					end

					if var_442_10.prefab_name ~= "" and arg_439_1.actors_[var_442_10.prefab_name] ~= nil then
						local var_442_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_10.prefab_name].transform, "story_v_out_416232", "416232103", "story_v_out_416232.awb")

						arg_439_1:RecordAudio("416232103", var_442_15)
						arg_439_1:RecordAudio("416232103", var_442_15)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_416232", "416232103", "story_v_out_416232.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_416232", "416232103", "story_v_out_416232.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_16 = math.max(var_442_9, arg_439_1.talkMaxDuration)

			if var_442_8 <= arg_439_1.time_ and arg_439_1.time_ < var_442_8 + var_442_16 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_8) / var_442_16

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_8 + var_442_16 and arg_439_1.time_ < var_442_8 + var_442_16 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_439_1:InitPlayNodeList()
	end,
	Play416232104 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 416232104
		arg_443_1.duration_ = 3.63

		local var_443_0 = {
			zh = 2.16666666666667,
			ja = 3.63266666666667
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play416232105(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			if 0 < arg_443_1.time_ and arg_443_1.time_ <= 0 + arg_446_0 and not isNil(arg_443_1.actors_["10127"]) and arg_443_1.var_.actorSpriteComps10127 == nil then
				arg_443_1.var_.actorSpriteComps10127 = arg_443_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_446_0 = 0.2

			if 0 <= arg_443_1.time_ and arg_443_1.time_ < 0 + var_446_0 and not isNil(arg_443_1.actors_["10127"]) then
				if arg_443_1.var_.actorSpriteComps10127 then
					for iter_446_0, iter_446_1 in pairs(arg_443_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_446_1 then
							if arg_443_1.isInRecall_ then
								iter_446_1.color = Color.New(Mathf.Lerp(iter_446_1.color.r, arg_443_1.hightColor2.r, (arg_443_1.time_ - 0) / var_446_0), Mathf.Lerp(iter_446_1.color.g, arg_443_1.hightColor2.g, (arg_443_1.time_ - 0) / var_446_0), (Mathf.Lerp(iter_446_1.color.b, arg_443_1.hightColor2.b, (arg_443_1.time_ - 0) / var_446_0)))
							else
								local var_446_1 = Mathf.Lerp(iter_446_1.color.r, 0.5, (arg_443_1.time_ - 0) / var_446_0)

								iter_446_1.color = Color.New(var_446_1, var_446_1, var_446_1)
							end
						end
					end
				end
			end

			if arg_443_1.time_ >= 0 + var_446_0 and arg_443_1.time_ < 0 + var_446_0 + arg_446_0 and not isNil(arg_443_1.actors_["10127"]) and arg_443_1.var_.actorSpriteComps10127 then
				for iter_446_2, iter_446_3 in pairs(arg_443_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_446_3 then
						iter_446_3.color = arg_443_1.isInRecall_ and (arg_443_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_443_1.var_.actorSpriteComps10127 = nil
			end

			local var_446_2 = 0

			if 0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_2 + arg_446_0 then
				arg_443_1.allBtn_.enabled = false
			end

			if arg_443_1.time_ >= var_446_2 + 0.466666666666667 and arg_443_1.time_ < var_446_2 + 0.466666666666667 + arg_446_0 then
				arg_443_1.allBtn_.enabled = true
			end

			if arg_443_1.frameCnt_ <= 1 then
				arg_443_1.dialog_:SetActive(false)
			end

			local var_446_3 = 0.466666666666667
			local var_446_4 = 0.2

			if 0.466666666666667 < arg_443_1.time_ and arg_443_1.time_ <= var_446_3 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0

				arg_443_1.dialog_:SetActive(true)

				arg_443_1.dialogCg_.alpha = 0

				local var_446_5 = LeanTween.value(arg_443_1.dialog_, 0, 1, 0.3)

				var_446_5:setOnUpdate(LuaHelper.FloatAction(function(arg_447_0)
					arg_443_1.dialogCg_.alpha = arg_447_0
				end))
				var_446_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_443_1.dialog_)
					var_446_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_443_1.duration_ = arg_443_1.duration_ + 0.3

				SetActive(arg_443_1.leftNameGo_, true)

				arg_443_1.leftNameTxt_.text = arg_443_1:FormatText(StoryNameCfg[254].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_443_1.callingController_:SetSelectedState("calling")

				arg_443_1.keyicon_.color = Color.New(1, 1, 1)
				arg_443_1.icon_.color = Color.New(1, 1, 1)

				local var_446_6 = arg_443_1:GetWordFromCfg(416232104)
				local var_446_7 = arg_443_1:FormatText(var_446_6.content)

				arg_443_1.text_.text = var_446_7

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_9 = 8 <= 0 and var_446_4 or var_446_4 * (utf8.len(var_446_7) / 8)

				if (8 <= 0 and var_446_4 or var_446_4 * (utf8.len(var_446_7) / 8)) > 0 and var_446_4 < var_446_9 then
					arg_443_1.talkMaxDuration = var_446_9
					var_446_3 = var_446_3 + 0.3

					if var_446_9 + var_446_3 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_9 + var_446_3
					end
				end

				arg_443_1.text_.text = var_446_7
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232104", "story_v_out_416232.awb") ~= 0 then
					local var_446_10 = manager.audio:GetVoiceLength("story_v_out_416232", "416232104", "story_v_out_416232.awb") / 1000

					if var_446_10 + var_446_3 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_10 + var_446_3
					end

					if var_446_6.prefab_name ~= "" and arg_443_1.actors_[var_446_6.prefab_name] ~= nil then
						local var_446_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_6.prefab_name].transform, "story_v_out_416232", "416232104", "story_v_out_416232.awb")

						arg_443_1:RecordAudio("416232104", var_446_11)
						arg_443_1:RecordAudio("416232104", var_446_11)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_416232", "416232104", "story_v_out_416232.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_416232", "416232104", "story_v_out_416232.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_12 = var_446_3 + 0.3
			local var_446_13 = math.max(var_446_4, arg_443_1.talkMaxDuration)

			if var_446_3 + 0.3 <= arg_443_1.time_ and arg_443_1.time_ < var_446_12 + var_446_13 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_12) / var_446_13

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_12 + var_446_13 and arg_443_1.time_ < var_446_12 + var_446_13 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end

		arg_443_1.nodeConfigList_ = {}

		arg_443_1:InitPlayNodeList()
	end,
	Play416232105 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 416232105
		arg_449_1.duration_ = 3.67

		local var_449_0 = {
			zh = 3.666,
			ja = 3.633
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play416232106(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["10127"]) and arg_449_1.var_.actorSpriteComps10127 == nil then
				arg_449_1.var_.actorSpriteComps10127 = arg_449_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_452_0 = 0.2

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["10127"]) then
				if arg_449_1.var_.actorSpriteComps10127 then
					for iter_452_0, iter_452_1 in pairs(arg_449_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_452_1 then
							if arg_449_1.isInRecall_ then
								iter_452_1.color = Color.New(Mathf.Lerp(iter_452_1.color.r, arg_449_1.hightColor1.r, (arg_449_1.time_ - 0) / var_452_0), Mathf.Lerp(iter_452_1.color.g, arg_449_1.hightColor1.g, (arg_449_1.time_ - 0) / var_452_0), (Mathf.Lerp(iter_452_1.color.b, arg_449_1.hightColor1.b, (arg_449_1.time_ - 0) / var_452_0)))
							else
								local var_452_1 = Mathf.Lerp(iter_452_1.color.r, 1, (arg_449_1.time_ - 0) / var_452_0)

								iter_452_1.color = Color.New(var_452_1, var_452_1, var_452_1)
							end
						end
					end
				end
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["10127"]) and arg_449_1.var_.actorSpriteComps10127 then
				for iter_452_2, iter_452_3 in pairs(arg_449_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_452_3 then
						iter_452_3.color = arg_449_1.isInRecall_ and (arg_449_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_449_1.var_.actorSpriteComps10127 = nil
			end

			local var_452_2 = arg_449_1.actors_["10127"].transform

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos10127 = var_452_2.localPosition
				var_452_2.localScale = Vector3.New(1, 1, 1)

				arg_449_1:CheckSpriteTmpPos("10127", 4)

				for iter_452_4 = 0, var_452_2.childCount - 1 do
					local var_452_3 = var_452_2:GetChild(iter_452_4)

					if var_452_3.name == "split_1" or not string.find(var_452_3.name, "split") then
						var_452_3.gameObject:SetActive(true)
					else
						var_452_3.gameObject:SetActive(false)
					end
				end
			end

			local var_452_4 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_4 then
				var_452_2.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos10127, Vector3.New(345, -387.4, -316.5), (arg_449_1.time_ - 0) / var_452_4)
			end

			if arg_449_1.time_ >= 0 + var_452_4 and arg_449_1.time_ < 0 + var_452_4 + arg_452_0 then
				var_452_2.localPosition = Vector3.New(345, -387.4, -316.5)
			end

			local var_452_5 = 0
			local var_452_6 = 0.25

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_5 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_7 = arg_449_1:GetWordFromCfg(416232105)
				local var_452_8 = arg_449_1:FormatText(var_452_7.content)

				arg_449_1.text_.text = var_452_8

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_10 = 10 <= 0 and var_452_6 or var_452_6 * (utf8.len(var_452_8) / 10)

				if (10 <= 0 and var_452_6 or var_452_6 * (utf8.len(var_452_8) / 10)) > 0 and var_452_6 < var_452_10 then
					arg_449_1.talkMaxDuration = var_452_10

					if var_452_10 + var_452_5 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_10 + var_452_5
					end
				end

				arg_449_1.text_.text = var_452_8
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232105", "story_v_out_416232.awb") ~= 0 then
					local var_452_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232105", "story_v_out_416232.awb") / 1000

					if var_452_11 + var_452_5 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_11 + var_452_5
					end

					if var_452_7.prefab_name ~= "" and arg_449_1.actors_[var_452_7.prefab_name] ~= nil then
						local var_452_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_7.prefab_name].transform, "story_v_out_416232", "416232105", "story_v_out_416232.awb")

						arg_449_1:RecordAudio("416232105", var_452_12)
						arg_449_1:RecordAudio("416232105", var_452_12)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_416232", "416232105", "story_v_out_416232.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_416232", "416232105", "story_v_out_416232.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_13 = math.max(var_452_6, arg_449_1.talkMaxDuration)

			if var_452_5 <= arg_449_1.time_ and arg_449_1.time_ < var_452_5 + var_452_13 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_5) / var_452_13

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_5 + var_452_13 and arg_449_1.time_ < var_452_5 + var_452_13 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play416232106 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 416232106
		arg_453_1.duration_ = 5.63

		local var_453_0 = {
			zh = 4.6,
			ja = 5.633
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play416232107(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(arg_453_1.actors_["10127"]) and arg_453_1.var_.actorSpriteComps10127 == nil then
				arg_453_1.var_.actorSpriteComps10127 = arg_453_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_456_0 = 0.2

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 and not isNil(arg_453_1.actors_["10127"]) then
				if arg_453_1.var_.actorSpriteComps10127 then
					for iter_456_0, iter_456_1 in pairs(arg_453_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_456_1 then
							if arg_453_1.isInRecall_ then
								iter_456_1.color = Color.New(Mathf.Lerp(iter_456_1.color.r, arg_453_1.hightColor2.r, (arg_453_1.time_ - 0) / var_456_0), Mathf.Lerp(iter_456_1.color.g, arg_453_1.hightColor2.g, (arg_453_1.time_ - 0) / var_456_0), (Mathf.Lerp(iter_456_1.color.b, arg_453_1.hightColor2.b, (arg_453_1.time_ - 0) / var_456_0)))
							else
								local var_456_1 = Mathf.Lerp(iter_456_1.color.r, 0.5, (arg_453_1.time_ - 0) / var_456_0)

								iter_456_1.color = Color.New(var_456_1, var_456_1, var_456_1)
							end
						end
					end
				end
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 and not isNil(arg_453_1.actors_["10127"]) and arg_453_1.var_.actorSpriteComps10127 then
				for iter_456_2, iter_456_3 in pairs(arg_453_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_456_3 then
						iter_456_3.color = arg_453_1.isInRecall_ and (arg_453_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_453_1.var_.actorSpriteComps10127 = nil
			end

			local var_456_2 = 0
			local var_456_3 = 0.575

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_2 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[254].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_453_1.callingController_:SetSelectedState("calling")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_4 = arg_453_1:GetWordFromCfg(416232106)
				local var_456_5 = arg_453_1:FormatText(var_456_4.content)

				arg_453_1.text_.text = var_456_5

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_7 = 23 <= 0 and var_456_3 or var_456_3 * (utf8.len(var_456_5) / 23)

				if (23 <= 0 and var_456_3 or var_456_3 * (utf8.len(var_456_5) / 23)) > 0 and var_456_3 < var_456_7 then
					arg_453_1.talkMaxDuration = var_456_7

					if var_456_7 + var_456_2 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_7 + var_456_2
					end
				end

				arg_453_1.text_.text = var_456_5
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232106", "story_v_out_416232.awb") ~= 0 then
					local var_456_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232106", "story_v_out_416232.awb") / 1000

					if var_456_8 + var_456_2 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_8 + var_456_2
					end

					if var_456_4.prefab_name ~= "" and arg_453_1.actors_[var_456_4.prefab_name] ~= nil then
						local var_456_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_4.prefab_name].transform, "story_v_out_416232", "416232106", "story_v_out_416232.awb")

						arg_453_1:RecordAudio("416232106", var_456_9)
						arg_453_1:RecordAudio("416232106", var_456_9)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_416232", "416232106", "story_v_out_416232.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_416232", "416232106", "story_v_out_416232.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_10 = math.max(var_456_3, arg_453_1.talkMaxDuration)

			if var_456_2 <= arg_453_1.time_ and arg_453_1.time_ < var_456_2 + var_456_10 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_2) / var_456_10

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_2 + var_456_10 and arg_453_1.time_ < var_456_2 + var_456_10 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play416232107 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 416232107
		arg_457_1.duration_ = 4.03

		local var_457_0 = {
			zh = 3.4,
			ja = 4.033
		}
		local var_457_1 = manager.audio:GetLocalizationFlag()

		if var_457_0[var_457_1] ~= nil then
			arg_457_1.duration_ = var_457_0[var_457_1]
		end

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play416232108(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0.525

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[254].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_457_1.callingController_:SetSelectedState("calling")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_1 = arg_457_1:GetWordFromCfg(416232107)
				local var_460_2 = arg_457_1:FormatText(var_460_1.content)

				arg_457_1.text_.text = var_460_2

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_4 = 21 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 21)

				if (21 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 21)) > 0 and var_460_0 < var_460_4 then
					arg_457_1.talkMaxDuration = var_460_4

					if var_460_4 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_4 + 0
					end
				end

				arg_457_1.text_.text = var_460_2
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232107", "story_v_out_416232.awb") ~= 0 then
					local var_460_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232107", "story_v_out_416232.awb") / 1000

					if var_460_5 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + 0
					end

					if var_460_1.prefab_name ~= "" and arg_457_1.actors_[var_460_1.prefab_name] ~= nil then
						local var_460_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_1.prefab_name].transform, "story_v_out_416232", "416232107", "story_v_out_416232.awb")

						arg_457_1:RecordAudio("416232107", var_460_6)
						arg_457_1:RecordAudio("416232107", var_460_6)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_416232", "416232107", "story_v_out_416232.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_416232", "416232107", "story_v_out_416232.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_7 = math.max(var_460_0, arg_457_1.talkMaxDuration)

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_7 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - 0) / var_460_7

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= 0 + var_460_7 and arg_457_1.time_ < 0 + var_460_7 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play416232108 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 416232108
		arg_461_1.duration_ = 5.7

		local var_461_0 = {
			zh = 3.9,
			ja = 5.7
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play416232109(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["10127"]) and arg_461_1.var_.actorSpriteComps10127 == nil then
				arg_461_1.var_.actorSpriteComps10127 = arg_461_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_464_0 = 0.2

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["10127"]) then
				if arg_461_1.var_.actorSpriteComps10127 then
					for iter_464_0, iter_464_1 in pairs(arg_461_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_464_1 then
							if arg_461_1.isInRecall_ then
								iter_464_1.color = Color.New(Mathf.Lerp(iter_464_1.color.r, arg_461_1.hightColor1.r, (arg_461_1.time_ - 0) / var_464_0), Mathf.Lerp(iter_464_1.color.g, arg_461_1.hightColor1.g, (arg_461_1.time_ - 0) / var_464_0), (Mathf.Lerp(iter_464_1.color.b, arg_461_1.hightColor1.b, (arg_461_1.time_ - 0) / var_464_0)))
							else
								local var_464_1 = Mathf.Lerp(iter_464_1.color.r, 1, (arg_461_1.time_ - 0) / var_464_0)

								iter_464_1.color = Color.New(var_464_1, var_464_1, var_464_1)
							end
						end
					end
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["10127"]) and arg_461_1.var_.actorSpriteComps10127 then
				for iter_464_2, iter_464_3 in pairs(arg_461_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_464_3 then
						iter_464_3.color = arg_461_1.isInRecall_ and (arg_461_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_461_1.var_.actorSpriteComps10127 = nil
			end

			local var_464_2 = 0
			local var_464_3 = 0.375

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_2 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_4 = arg_461_1:GetWordFromCfg(416232108)
				local var_464_5 = arg_461_1:FormatText(var_464_4.content)

				arg_461_1.text_.text = var_464_5

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_7 = 15 <= 0 and var_464_3 or var_464_3 * (utf8.len(var_464_5) / 15)

				if (15 <= 0 and var_464_3 or var_464_3 * (utf8.len(var_464_5) / 15)) > 0 and var_464_3 < var_464_7 then
					arg_461_1.talkMaxDuration = var_464_7

					if var_464_7 + var_464_2 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_7 + var_464_2
					end
				end

				arg_461_1.text_.text = var_464_5
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232108", "story_v_out_416232.awb") ~= 0 then
					local var_464_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232108", "story_v_out_416232.awb") / 1000

					if var_464_8 + var_464_2 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_8 + var_464_2
					end

					if var_464_4.prefab_name ~= "" and arg_461_1.actors_[var_464_4.prefab_name] ~= nil then
						local var_464_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_4.prefab_name].transform, "story_v_out_416232", "416232108", "story_v_out_416232.awb")

						arg_461_1:RecordAudio("416232108", var_464_9)
						arg_461_1:RecordAudio("416232108", var_464_9)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_416232", "416232108", "story_v_out_416232.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_416232", "416232108", "story_v_out_416232.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_10 = math.max(var_464_3, arg_461_1.talkMaxDuration)

			if var_464_2 <= arg_461_1.time_ and arg_461_1.time_ < var_464_2 + var_464_10 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_2) / var_464_10

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_2 + var_464_10 and arg_461_1.time_ < var_464_2 + var_464_10 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play416232109 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 416232109
		arg_465_1.duration_ = 6.83

		local var_465_0 = {
			zh = 5.666,
			ja = 6.833
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play416232110(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(arg_465_1.actors_["10127"]) and arg_465_1.var_.actorSpriteComps10127 == nil then
				arg_465_1.var_.actorSpriteComps10127 = arg_465_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_468_0 = 0.2

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 and not isNil(arg_465_1.actors_["10127"]) then
				if arg_465_1.var_.actorSpriteComps10127 then
					for iter_468_0, iter_468_1 in pairs(arg_465_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_468_1 then
							if arg_465_1.isInRecall_ then
								iter_468_1.color = Color.New(Mathf.Lerp(iter_468_1.color.r, arg_465_1.hightColor2.r, (arg_465_1.time_ - 0) / var_468_0), Mathf.Lerp(iter_468_1.color.g, arg_465_1.hightColor2.g, (arg_465_1.time_ - 0) / var_468_0), (Mathf.Lerp(iter_468_1.color.b, arg_465_1.hightColor2.b, (arg_465_1.time_ - 0) / var_468_0)))
							else
								local var_468_1 = Mathf.Lerp(iter_468_1.color.r, 0.5, (arg_465_1.time_ - 0) / var_468_0)

								iter_468_1.color = Color.New(var_468_1, var_468_1, var_468_1)
							end
						end
					end
				end
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 and not isNil(arg_465_1.actors_["10127"]) and arg_465_1.var_.actorSpriteComps10127 then
				for iter_468_2, iter_468_3 in pairs(arg_465_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_468_3 then
						iter_468_3.color = arg_465_1.isInRecall_ and (arg_465_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_465_1.var_.actorSpriteComps10127 = nil
			end

			local var_468_2 = 0
			local var_468_3 = 0.75

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_2 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[254].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10120")

				arg_465_1.callingController_:SetSelectedState("calling")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_4 = arg_465_1:GetWordFromCfg(416232109)
				local var_468_5 = arg_465_1:FormatText(var_468_4.content)

				arg_465_1.text_.text = var_468_5

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_7 = 30 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_5) / 30)

				if (30 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_5) / 30)) > 0 and var_468_3 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_2 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_2
					end
				end

				arg_465_1.text_.text = var_468_5
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232109", "story_v_out_416232.awb") ~= 0 then
					local var_468_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232109", "story_v_out_416232.awb") / 1000

					if var_468_8 + var_468_2 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_8 + var_468_2
					end

					if var_468_4.prefab_name ~= "" and arg_465_1.actors_[var_468_4.prefab_name] ~= nil then
						local var_468_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_4.prefab_name].transform, "story_v_out_416232", "416232109", "story_v_out_416232.awb")

						arg_465_1:RecordAudio("416232109", var_468_9)
						arg_465_1:RecordAudio("416232109", var_468_9)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_416232", "416232109", "story_v_out_416232.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_416232", "416232109", "story_v_out_416232.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_10 = math.max(var_468_3, arg_465_1.talkMaxDuration)

			if var_468_2 <= arg_465_1.time_ and arg_465_1.time_ < var_468_2 + var_468_10 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_2) / var_468_10

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_2 + var_468_10 and arg_465_1.time_ < var_468_2 + var_468_10 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play416232110 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 416232110
		arg_469_1.duration_ = 7.8

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play416232111(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 1.2 < arg_469_1.time_ and arg_469_1.time_ <= 1.2 + arg_472_0 then
				local var_472_0 = arg_469_1.bgs_.F09f

				arg_469_1.bgs_.F09f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_472_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_472_1 = var_472_0:GetComponent("SpriteRenderer")

				if var_472_1 and var_472_1.sprite then
					local var_472_2 = 2 * (var_472_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_472_0.transform.localScale = Vector3.New(var_472_2 / var_472_1.sprite.bounds.size.y < var_472_2 * manager.ui.mainCameraCom_.aspect / var_472_1.sprite.bounds.size.x and var_472_2 * manager.ui.mainCameraCom_.aspect / var_472_1.sprite.bounds.size.x or var_472_2 / var_472_1.sprite.bounds.size.y, var_472_2 / var_472_1.sprite.bounds.size.y < var_472_2 * manager.ui.mainCameraCom_.aspect / var_472_1.sprite.bounds.size.x and var_472_2 * manager.ui.mainCameraCom_.aspect / var_472_1.sprite.bounds.size.x or var_472_2 / var_472_1.sprite.bounds.size.y, 0)
				end

				for iter_472_0, iter_472_1 in pairs(arg_469_1.bgs_) do
					if iter_472_0 ~= "F09f" then
						iter_472_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_472_3 = 1.2

			if 1.2 < arg_469_1.time_ and arg_469_1.time_ <= var_472_3 + arg_472_0 then
				arg_469_1.allBtn_.enabled = false
			end

			if arg_469_1.time_ >= var_472_3 + 0.3 and arg_469_1.time_ < var_472_3 + 0.3 + arg_472_0 then
				arg_469_1.allBtn_.enabled = true
			end

			local var_472_4 = 0

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_4 + arg_472_0 then
				arg_469_1.mask_.enabled = true
				arg_469_1.mask_.raycastTarget = true

				arg_469_1:SetGaussion(false)
			end

			local var_472_5 = 1.2

			if var_472_4 <= arg_469_1.time_ and arg_469_1.time_ < var_472_4 + var_472_5 then
				local var_472_6 = Color.New(0, 0, 0)

				var_472_6.a = Mathf.Lerp(0, 1, (arg_469_1.time_ - var_472_4) / var_472_5)
				arg_469_1.mask_.color = var_472_6
			end

			if arg_469_1.time_ >= var_472_4 + var_472_5 and arg_469_1.time_ < var_472_4 + var_472_5 + arg_472_0 then
				local var_472_7 = Color.New(0, 0, 0)

				var_472_7.a = 1
				arg_469_1.mask_.color = var_472_7
			end

			local var_472_8 = 1.2

			if 1.2 < arg_469_1.time_ and arg_469_1.time_ <= var_472_8 + arg_472_0 then
				arg_469_1.mask_.enabled = true
				arg_469_1.mask_.raycastTarget = true

				arg_469_1:SetGaussion(false)
			end

			local var_472_9 = 2

			if var_472_8 <= arg_469_1.time_ and arg_469_1.time_ < var_472_8 + var_472_9 then
				local var_472_10 = Color.New(0, 0, 0)

				var_472_10.a = Mathf.Lerp(1, 0, (arg_469_1.time_ - var_472_8) / var_472_9)
				arg_469_1.mask_.color = var_472_10
			end

			if arg_469_1.time_ >= var_472_8 + var_472_9 and arg_469_1.time_ < var_472_8 + var_472_9 + arg_472_0 then
				local var_472_11 = Color.New(0, 0, 0)

				arg_469_1.mask_.enabled = false
				var_472_11.a = 0
				arg_469_1.mask_.color = var_472_11
			end

			local var_472_12 = arg_469_1.actors_["1028"].transform

			if 1.2 < arg_469_1.time_ and arg_469_1.time_ <= 1.2 + arg_472_0 then
				arg_469_1.var_.moveOldPos1028 = var_472_12.localPosition
				var_472_12.localScale = Vector3.New(1, 1, 1)

				arg_469_1:CheckSpriteTmpPos("1028", 7)

				for iter_472_2 = 0, var_472_12.childCount - 1 do
					local var_472_13 = var_472_12:GetChild(iter_472_2)

					if var_472_13.name == "" or not string.find(var_472_13.name, "split") then
						var_472_13.gameObject:SetActive(true)
					else
						var_472_13.gameObject:SetActive(false)
					end
				end
			end

			local var_472_14 = 0.001

			if 1.2 <= arg_469_1.time_ and arg_469_1.time_ < 1.2 + var_472_14 then
				var_472_12.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_469_1.time_ - 1.2) / var_472_14)
			end

			if arg_469_1.time_ >= 1.2 + var_472_14 and arg_469_1.time_ < 1.2 + var_472_14 + arg_472_0 then
				var_472_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_472_15 = arg_469_1.actors_["10127"].transform

			if 1.2 < arg_469_1.time_ and arg_469_1.time_ <= 1.2 + arg_472_0 then
				arg_469_1.var_.moveOldPos10127 = var_472_15.localPosition
				var_472_15.localScale = Vector3.New(1, 1, 1)

				arg_469_1:CheckSpriteTmpPos("10127", 7)

				for iter_472_3 = 0, var_472_15.childCount - 1 do
					local var_472_16 = var_472_15:GetChild(iter_472_3)

					if var_472_16.name == "" or not string.find(var_472_16.name, "split") then
						var_472_16.gameObject:SetActive(true)
					else
						var_472_16.gameObject:SetActive(false)
					end
				end
			end

			local var_472_17 = 0.001

			if 1.2 <= arg_469_1.time_ and arg_469_1.time_ < 1.2 + var_472_17 then
				var_472_15.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos10127, Vector3.New(0, -2000, 0), (arg_469_1.time_ - 1.2) / var_472_17)
			end

			if arg_469_1.time_ >= 1.2 + var_472_17 and arg_469_1.time_ < 1.2 + var_472_17 + arg_472_0 then
				var_472_15.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_469_1.frameCnt_ <= 1 then
				arg_469_1.dialog_:SetActive(false)
			end

			local var_472_18 = 2.8
			local var_472_19 = 1.25

			if 2.8 < arg_469_1.time_ and arg_469_1.time_ <= var_472_18 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0

				arg_469_1.dialog_:SetActive(true)

				arg_469_1.dialogCg_.alpha = 0

				local var_472_20 = LeanTween.value(arg_469_1.dialog_, 0, 1, 0.3)

				var_472_20:setOnUpdate(LuaHelper.FloatAction(function(arg_473_0)
					arg_469_1.dialogCg_.alpha = arg_473_0
				end))
				var_472_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_469_1.dialog_)
					var_472_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_469_1.duration_ = arg_469_1.duration_ + 0.3

				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_21 = arg_469_1:FormatText(arg_469_1:GetWordFromCfg(416232110).content)

				arg_469_1.text_.text = var_472_21

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_23 = 50 <= 0 and var_472_19 or var_472_19 * (utf8.len(var_472_21) / 50)

				if (50 <= 0 and var_472_19 or var_472_19 * (utf8.len(var_472_21) / 50)) > 0 and var_472_19 < var_472_23 then
					arg_469_1.talkMaxDuration = var_472_23
					var_472_18 = var_472_18 + 0.3

					if var_472_23 + var_472_18 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_23 + var_472_18
					end
				end

				arg_469_1.text_.text = var_472_21
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_24 = var_472_18 + 0.3
			local var_472_25 = math.max(var_472_19, arg_469_1.talkMaxDuration)

			if var_472_18 + 0.3 <= arg_469_1.time_ and arg_469_1.time_ < var_472_24 + var_472_25 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_24) / var_472_25

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_24 + var_472_25 and arg_469_1.time_ < var_472_24 + var_472_25 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_469_1:InitPlayNodeList()
	end,
	Play416232111 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 416232111
		arg_475_1.duration_ = 6.33

		local var_475_0 = {
			zh = 4.6,
			ja = 6.333
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play416232112(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(arg_475_1.actors_["10122"]) and arg_475_1.var_.actorSpriteComps10122 == nil then
				arg_475_1.var_.actorSpriteComps10122 = arg_475_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_478_0 = 0.2

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 and not isNil(arg_475_1.actors_["10122"]) then
				if arg_475_1.var_.actorSpriteComps10122 then
					for iter_478_0, iter_478_1 in pairs(arg_475_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_478_1 then
							if arg_475_1.isInRecall_ then
								iter_478_1.color = Color.New(Mathf.Lerp(iter_478_1.color.r, arg_475_1.hightColor1.r, (arg_475_1.time_ - 0) / var_478_0), Mathf.Lerp(iter_478_1.color.g, arg_475_1.hightColor1.g, (arg_475_1.time_ - 0) / var_478_0), (Mathf.Lerp(iter_478_1.color.b, arg_475_1.hightColor1.b, (arg_475_1.time_ - 0) / var_478_0)))
							else
								local var_478_1 = Mathf.Lerp(iter_478_1.color.r, 1, (arg_475_1.time_ - 0) / var_478_0)

								iter_478_1.color = Color.New(var_478_1, var_478_1, var_478_1)
							end
						end
					end
				end
			end

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 and not isNil(arg_475_1.actors_["10122"]) and arg_475_1.var_.actorSpriteComps10122 then
				for iter_478_2, iter_478_3 in pairs(arg_475_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_478_3 then
						iter_478_3.color = arg_475_1.isInRecall_ and (arg_475_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_475_1.var_.actorSpriteComps10122 = nil
			end

			local var_478_2 = arg_475_1.actors_["10122"].transform

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 then
				arg_475_1.var_.moveOldPos10122 = var_478_2.localPosition
				var_478_2.localScale = Vector3.New(1, 1, 1)

				arg_475_1:CheckSpriteTmpPos("10122", 3)

				for iter_478_4 = 0, var_478_2.childCount - 1 do
					local var_478_3 = var_478_2:GetChild(iter_478_4)

					if var_478_3.name == "" or not string.find(var_478_3.name, "split") then
						var_478_3.gameObject:SetActive(true)
					else
						var_478_3.gameObject:SetActive(false)
					end
				end
			end

			local var_478_4 = 0.001

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_4 then
				var_478_2.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos10122, Vector3.New(0, -380, -100), (arg_475_1.time_ - 0) / var_478_4)
			end

			if arg_475_1.time_ >= 0 + var_478_4 and arg_475_1.time_ < 0 + var_478_4 + arg_478_0 then
				var_478_2.localPosition = Vector3.New(0, -380, -100)
			end

			local var_478_5 = 0
			local var_478_6 = 0.525

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_5 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_7 = arg_475_1:GetWordFromCfg(416232111)
				local var_478_8 = arg_475_1:FormatText(var_478_7.content)

				arg_475_1.text_.text = var_478_8

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_10 = 21 <= 0 and var_478_6 or var_478_6 * (utf8.len(var_478_8) / 21)

				if (21 <= 0 and var_478_6 or var_478_6 * (utf8.len(var_478_8) / 21)) > 0 and var_478_6 < var_478_10 then
					arg_475_1.talkMaxDuration = var_478_10

					if var_478_10 + var_478_5 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_10 + var_478_5
					end
				end

				arg_475_1.text_.text = var_478_8
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232111", "story_v_out_416232.awb") ~= 0 then
					local var_478_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232111", "story_v_out_416232.awb") / 1000

					if var_478_11 + var_478_5 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_11 + var_478_5
					end

					if var_478_7.prefab_name ~= "" and arg_475_1.actors_[var_478_7.prefab_name] ~= nil then
						local var_478_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_7.prefab_name].transform, "story_v_out_416232", "416232111", "story_v_out_416232.awb")

						arg_475_1:RecordAudio("416232111", var_478_12)
						arg_475_1:RecordAudio("416232111", var_478_12)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_416232", "416232111", "story_v_out_416232.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_416232", "416232111", "story_v_out_416232.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_13 = math.max(var_478_6, arg_475_1.talkMaxDuration)

			if var_478_5 <= arg_475_1.time_ and arg_475_1.time_ < var_478_5 + var_478_13 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_5) / var_478_13

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_5 + var_478_13 and arg_475_1.time_ < var_478_5 + var_478_13 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_475_1:InitPlayNodeList()
	end,
	Play416232112 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 416232112
		arg_479_1.duration_ = 2.67

		local var_479_0 = {
			zh = 1.866,
			ja = 2.666
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play416232113(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(arg_479_1.actors_["1086"]) and arg_479_1.var_.actorSpriteComps1086 == nil then
				arg_479_1.var_.actorSpriteComps1086 = arg_479_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_482_0 = 0.2

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 and not isNil(arg_479_1.actors_["1086"]) then
				if arg_479_1.var_.actorSpriteComps1086 then
					for iter_482_0, iter_482_1 in pairs(arg_479_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_482_1 then
							if arg_479_1.isInRecall_ then
								iter_482_1.color = Color.New(Mathf.Lerp(iter_482_1.color.r, arg_479_1.hightColor1.r, (arg_479_1.time_ - 0) / var_482_0), Mathf.Lerp(iter_482_1.color.g, arg_479_1.hightColor1.g, (arg_479_1.time_ - 0) / var_482_0), (Mathf.Lerp(iter_482_1.color.b, arg_479_1.hightColor1.b, (arg_479_1.time_ - 0) / var_482_0)))
							else
								local var_482_1 = Mathf.Lerp(iter_482_1.color.r, 1, (arg_479_1.time_ - 0) / var_482_0)

								iter_482_1.color = Color.New(var_482_1, var_482_1, var_482_1)
							end
						end
					end
				end
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 and not isNil(arg_479_1.actors_["1086"]) and arg_479_1.var_.actorSpriteComps1086 then
				for iter_482_2, iter_482_3 in pairs(arg_479_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_482_3 then
						iter_482_3.color = arg_479_1.isInRecall_ and (arg_479_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_479_1.var_.actorSpriteComps1086 = nil
			end

			local var_482_2 = arg_479_1.actors_["10122"]

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(var_482_2) and arg_479_1.var_.actorSpriteComps10122 == nil then
				arg_479_1.var_.actorSpriteComps10122 = var_482_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_482_3 = 0.2

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_3 and not isNil(var_482_2) then
				if arg_479_1.var_.actorSpriteComps10122 then
					for iter_482_4, iter_482_5 in pairs(arg_479_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_482_5 then
							if arg_479_1.isInRecall_ then
								iter_482_5.color = Color.New(Mathf.Lerp(iter_482_5.color.r, arg_479_1.hightColor2.r, (arg_479_1.time_ - 0) / var_482_3), Mathf.Lerp(iter_482_5.color.g, arg_479_1.hightColor2.g, (arg_479_1.time_ - 0) / var_482_3), (Mathf.Lerp(iter_482_5.color.b, arg_479_1.hightColor2.b, (arg_479_1.time_ - 0) / var_482_3)))
							else
								local var_482_4 = Mathf.Lerp(iter_482_5.color.r, 0.5, (arg_479_1.time_ - 0) / var_482_3)

								iter_482_5.color = Color.New(var_482_4, var_482_4, var_482_4)
							end
						end
					end
				end
			end

			if arg_479_1.time_ >= 0 + var_482_3 and arg_479_1.time_ < 0 + var_482_3 + arg_482_0 and not isNil(var_482_2) and arg_479_1.var_.actorSpriteComps10122 then
				for iter_482_6, iter_482_7 in pairs(arg_479_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_482_7 then
						iter_482_7.color = arg_479_1.isInRecall_ and (arg_479_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_479_1.var_.actorSpriteComps10122 = nil
			end

			local var_482_5 = arg_479_1.actors_["10122"].transform

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.var_.moveOldPos10122 = var_482_5.localPosition
				var_482_5.localScale = Vector3.New(1, 1, 1)

				arg_479_1:CheckSpriteTmpPos("10122", 7)

				for iter_482_8 = 0, var_482_5.childCount - 1 do
					local var_482_6 = var_482_5:GetChild(iter_482_8)

					if var_482_6.name == "" or not string.find(var_482_6.name, "split") then
						var_482_6.gameObject:SetActive(true)
					else
						var_482_6.gameObject:SetActive(false)
					end
				end
			end

			local var_482_7 = 0.001

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_7 then
				var_482_5.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos10122, Vector3.New(0, -2000, 0), (arg_479_1.time_ - 0) / var_482_7)
			end

			if arg_479_1.time_ >= 0 + var_482_7 and arg_479_1.time_ < 0 + var_482_7 + arg_482_0 then
				var_482_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_482_8 = arg_479_1.actors_["1086"].transform

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 then
				arg_479_1.var_.moveOldPos1086 = var_482_8.localPosition
				var_482_8.localScale = Vector3.New(1, 1, 1)

				arg_479_1:CheckSpriteTmpPos("1086", 3)

				for iter_482_9 = 0, var_482_8.childCount - 1 do
					local var_482_9 = var_482_8:GetChild(iter_482_9)

					if var_482_9.name == "" or not string.find(var_482_9.name, "split") then
						var_482_9.gameObject:SetActive(true)
					else
						var_482_9.gameObject:SetActive(false)
					end
				end
			end

			local var_482_10 = 0.001

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_10 then
				var_482_8.localPosition = Vector3.Lerp(arg_479_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_479_1.time_ - 0) / var_482_10)
			end

			if arg_479_1.time_ >= 0 + var_482_10 and arg_479_1.time_ < 0 + var_482_10 + arg_482_0 then
				var_482_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_482_11 = 0
			local var_482_12 = 0.2

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_11 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_13 = arg_479_1:GetWordFromCfg(416232112)
				local var_482_14 = arg_479_1:FormatText(var_482_13.content)

				arg_479_1.text_.text = var_482_14

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_16 = 8 <= 0 and var_482_12 or var_482_12 * (utf8.len(var_482_14) / 8)

				if (8 <= 0 and var_482_12 or var_482_12 * (utf8.len(var_482_14) / 8)) > 0 and var_482_12 < var_482_16 then
					arg_479_1.talkMaxDuration = var_482_16

					if var_482_16 + var_482_11 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_16 + var_482_11
					end
				end

				arg_479_1.text_.text = var_482_14
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232112", "story_v_out_416232.awb") ~= 0 then
					local var_482_17 = manager.audio:GetVoiceLength("story_v_out_416232", "416232112", "story_v_out_416232.awb") / 1000

					if var_482_17 + var_482_11 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_17 + var_482_11
					end

					if var_482_13.prefab_name ~= "" and arg_479_1.actors_[var_482_13.prefab_name] ~= nil then
						local var_482_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_13.prefab_name].transform, "story_v_out_416232", "416232112", "story_v_out_416232.awb")

						arg_479_1:RecordAudio("416232112", var_482_18)
						arg_479_1:RecordAudio("416232112", var_482_18)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_416232", "416232112", "story_v_out_416232.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_416232", "416232112", "story_v_out_416232.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_19 = math.max(var_482_12, arg_479_1.talkMaxDuration)

			if var_482_11 <= arg_479_1.time_ and arg_479_1.time_ < var_482_11 + var_482_19 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_11) / var_482_19

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_11 + var_482_19 and arg_479_1.time_ < var_482_11 + var_482_19 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_479_1:InitPlayNodeList()
	end,
	Play416232113 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 416232113
		arg_483_1.duration_ = 5

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play416232114(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(arg_483_1.actors_["1086"]) and arg_483_1.var_.actorSpriteComps1086 == nil then
				arg_483_1.var_.actorSpriteComps1086 = arg_483_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_486_0 = 0.2

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 and not isNil(arg_483_1.actors_["1086"]) then
				if arg_483_1.var_.actorSpriteComps1086 then
					for iter_486_0, iter_486_1 in pairs(arg_483_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_486_1 then
							if arg_483_1.isInRecall_ then
								iter_486_1.color = Color.New(Mathf.Lerp(iter_486_1.color.r, arg_483_1.hightColor2.r, (arg_483_1.time_ - 0) / var_486_0), Mathf.Lerp(iter_486_1.color.g, arg_483_1.hightColor2.g, (arg_483_1.time_ - 0) / var_486_0), (Mathf.Lerp(iter_486_1.color.b, arg_483_1.hightColor2.b, (arg_483_1.time_ - 0) / var_486_0)))
							else
								local var_486_1 = Mathf.Lerp(iter_486_1.color.r, 0.5, (arg_483_1.time_ - 0) / var_486_0)

								iter_486_1.color = Color.New(var_486_1, var_486_1, var_486_1)
							end
						end
					end
				end
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 and not isNil(arg_483_1.actors_["1086"]) and arg_483_1.var_.actorSpriteComps1086 then
				for iter_486_2, iter_486_3 in pairs(arg_483_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_486_3 then
						iter_486_3.color = arg_483_1.isInRecall_ and (arg_483_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_483_1.var_.actorSpriteComps1086 = nil
			end

			local var_486_2 = arg_483_1.actors_["1086"].transform

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 then
				arg_483_1.var_.moveOldPos1086 = var_486_2.localPosition
				var_486_2.localScale = Vector3.New(1, 1, 1)

				arg_483_1:CheckSpriteTmpPos("1086", 7)

				for iter_486_4 = 0, var_486_2.childCount - 1 do
					local var_486_3 = var_486_2:GetChild(iter_486_4)

					if var_486_3.name == "" or not string.find(var_486_3.name, "split") then
						var_486_3.gameObject:SetActive(true)
					else
						var_486_3.gameObject:SetActive(false)
					end
				end
			end

			local var_486_4 = 0.001

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_4 then
				var_486_2.localPosition = Vector3.Lerp(arg_483_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_483_1.time_ - 0) / var_486_4)
			end

			if arg_483_1.time_ >= 0 + var_486_4 and arg_483_1.time_ < 0 + var_486_4 + arg_486_0 then
				var_486_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_486_5 = 0
			local var_486_6 = 1.275

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_5 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, false)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_7 = arg_483_1:FormatText(arg_483_1:GetWordFromCfg(416232113).content)

				arg_483_1.text_.text = var_486_7

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_9 = 51 <= 0 and var_486_6 or var_486_6 * (utf8.len(var_486_7) / 51)

				if (51 <= 0 and var_486_6 or var_486_6 * (utf8.len(var_486_7) / 51)) > 0 and var_486_6 < var_486_9 then
					arg_483_1.talkMaxDuration = var_486_9

					if var_486_9 + var_486_5 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_9 + var_486_5
					end
				end

				arg_483_1.text_.text = var_486_7
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)
				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_10 = math.max(var_486_6, arg_483_1.talkMaxDuration)

			if var_486_5 <= arg_483_1.time_ and arg_483_1.time_ < var_486_5 + var_486_10 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_5) / var_486_10

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_5 + var_486_10 and arg_483_1.time_ < var_486_5 + var_486_10 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_483_1:InitPlayNodeList()
	end,
	Play416232114 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 416232114
		arg_487_1.duration_ = 6.87

		local var_487_0 = {
			zh = 3.8,
			ja = 6.866
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play416232115(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 and not isNil(arg_487_1.actors_["10122"]) and arg_487_1.var_.actorSpriteComps10122 == nil then
				arg_487_1.var_.actorSpriteComps10122 = arg_487_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_490_0 = 0.2

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_0 and not isNil(arg_487_1.actors_["10122"]) then
				if arg_487_1.var_.actorSpriteComps10122 then
					for iter_490_0, iter_490_1 in pairs(arg_487_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_490_1 then
							if arg_487_1.isInRecall_ then
								iter_490_1.color = Color.New(Mathf.Lerp(iter_490_1.color.r, arg_487_1.hightColor1.r, (arg_487_1.time_ - 0) / var_490_0), Mathf.Lerp(iter_490_1.color.g, arg_487_1.hightColor1.g, (arg_487_1.time_ - 0) / var_490_0), (Mathf.Lerp(iter_490_1.color.b, arg_487_1.hightColor1.b, (arg_487_1.time_ - 0) / var_490_0)))
							else
								local var_490_1 = Mathf.Lerp(iter_490_1.color.r, 1, (arg_487_1.time_ - 0) / var_490_0)

								iter_490_1.color = Color.New(var_490_1, var_490_1, var_490_1)
							end
						end
					end
				end
			end

			if arg_487_1.time_ >= 0 + var_490_0 and arg_487_1.time_ < 0 + var_490_0 + arg_490_0 and not isNil(arg_487_1.actors_["10122"]) and arg_487_1.var_.actorSpriteComps10122 then
				for iter_490_2, iter_490_3 in pairs(arg_487_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_490_3 then
						iter_490_3.color = arg_487_1.isInRecall_ and (arg_487_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_487_1.var_.actorSpriteComps10122 = nil
			end

			local var_490_2 = arg_487_1.actors_["10122"].transform

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.var_.moveOldPos10122 = var_490_2.localPosition
				var_490_2.localScale = Vector3.New(1, 1, 1)

				arg_487_1:CheckSpriteTmpPos("10122", 2)

				for iter_490_4 = 0, var_490_2.childCount - 1 do
					local var_490_3 = var_490_2:GetChild(iter_490_4)

					if var_490_3.name == "" or not string.find(var_490_3.name, "split") then
						var_490_3.gameObject:SetActive(true)
					else
						var_490_3.gameObject:SetActive(false)
					end
				end
			end

			local var_490_4 = 0.001

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_4 then
				var_490_2.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos10122, Vector3.New(-390, -380, -100), (arg_487_1.time_ - 0) / var_490_4)
			end

			if arg_487_1.time_ >= 0 + var_490_4 and arg_487_1.time_ < 0 + var_490_4 + arg_490_0 then
				var_490_2.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_490_5 = 0
			local var_490_6 = 0.5

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_5 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_7 = arg_487_1:GetWordFromCfg(416232114)
				local var_490_8 = arg_487_1:FormatText(var_490_7.content)

				arg_487_1.text_.text = var_490_8

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_10 = 20 <= 0 and var_490_6 or var_490_6 * (utf8.len(var_490_8) / 20)

				if (20 <= 0 and var_490_6 or var_490_6 * (utf8.len(var_490_8) / 20)) > 0 and var_490_6 < var_490_10 then
					arg_487_1.talkMaxDuration = var_490_10

					if var_490_10 + var_490_5 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_10 + var_490_5
					end
				end

				arg_487_1.text_.text = var_490_8
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232114", "story_v_out_416232.awb") ~= 0 then
					local var_490_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232114", "story_v_out_416232.awb") / 1000

					if var_490_11 + var_490_5 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_11 + var_490_5
					end

					if var_490_7.prefab_name ~= "" and arg_487_1.actors_[var_490_7.prefab_name] ~= nil then
						local var_490_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_7.prefab_name].transform, "story_v_out_416232", "416232114", "story_v_out_416232.awb")

						arg_487_1:RecordAudio("416232114", var_490_12)
						arg_487_1:RecordAudio("416232114", var_490_12)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_416232", "416232114", "story_v_out_416232.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_416232", "416232114", "story_v_out_416232.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_13 = math.max(var_490_6, arg_487_1.talkMaxDuration)

			if var_490_5 <= arg_487_1.time_ and arg_487_1.time_ < var_490_5 + var_490_13 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_5) / var_490_13

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_5 + var_490_13 and arg_487_1.time_ < var_490_5 + var_490_13 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_487_1:InitPlayNodeList()
	end,
	Play416232115 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 416232115
		arg_491_1.duration_ = 8.63

		local var_491_0 = {
			zh = 5.5,
			ja = 8.633
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play416232116(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(arg_491_1.actors_["1086"]) and arg_491_1.var_.actorSpriteComps1086 == nil then
				arg_491_1.var_.actorSpriteComps1086 = arg_491_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_494_0 = 0.2

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 and not isNil(arg_491_1.actors_["1086"]) then
				if arg_491_1.var_.actorSpriteComps1086 then
					for iter_494_0, iter_494_1 in pairs(arg_491_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_494_1 then
							if arg_491_1.isInRecall_ then
								iter_494_1.color = Color.New(Mathf.Lerp(iter_494_1.color.r, arg_491_1.hightColor1.r, (arg_491_1.time_ - 0) / var_494_0), Mathf.Lerp(iter_494_1.color.g, arg_491_1.hightColor1.g, (arg_491_1.time_ - 0) / var_494_0), (Mathf.Lerp(iter_494_1.color.b, arg_491_1.hightColor1.b, (arg_491_1.time_ - 0) / var_494_0)))
							else
								local var_494_1 = Mathf.Lerp(iter_494_1.color.r, 1, (arg_491_1.time_ - 0) / var_494_0)

								iter_494_1.color = Color.New(var_494_1, var_494_1, var_494_1)
							end
						end
					end
				end
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 and not isNil(arg_491_1.actors_["1086"]) and arg_491_1.var_.actorSpriteComps1086 then
				for iter_494_2, iter_494_3 in pairs(arg_491_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_494_3 then
						iter_494_3.color = arg_491_1.isInRecall_ and (arg_491_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_491_1.var_.actorSpriteComps1086 = nil
			end

			local var_494_2 = arg_491_1.actors_["10122"]

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(var_494_2) and arg_491_1.var_.actorSpriteComps10122 == nil then
				arg_491_1.var_.actorSpriteComps10122 = var_494_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_494_3 = 0.2

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_3 and not isNil(var_494_2) then
				if arg_491_1.var_.actorSpriteComps10122 then
					for iter_494_4, iter_494_5 in pairs(arg_491_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_494_5 then
							if arg_491_1.isInRecall_ then
								iter_494_5.color = Color.New(Mathf.Lerp(iter_494_5.color.r, arg_491_1.hightColor2.r, (arg_491_1.time_ - 0) / var_494_3), Mathf.Lerp(iter_494_5.color.g, arg_491_1.hightColor2.g, (arg_491_1.time_ - 0) / var_494_3), (Mathf.Lerp(iter_494_5.color.b, arg_491_1.hightColor2.b, (arg_491_1.time_ - 0) / var_494_3)))
							else
								local var_494_4 = Mathf.Lerp(iter_494_5.color.r, 0.5, (arg_491_1.time_ - 0) / var_494_3)

								iter_494_5.color = Color.New(var_494_4, var_494_4, var_494_4)
							end
						end
					end
				end
			end

			if arg_491_1.time_ >= 0 + var_494_3 and arg_491_1.time_ < 0 + var_494_3 + arg_494_0 and not isNil(var_494_2) and arg_491_1.var_.actorSpriteComps10122 then
				for iter_494_6, iter_494_7 in pairs(arg_491_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_494_7 then
						iter_494_7.color = arg_491_1.isInRecall_ and (arg_491_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_491_1.var_.actorSpriteComps10122 = nil
			end

			local var_494_5 = arg_491_1.actors_["1086"].transform

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 then
				arg_491_1.var_.moveOldPos1086 = var_494_5.localPosition
				var_494_5.localScale = Vector3.New(1, 1, 1)

				arg_491_1:CheckSpriteTmpPos("1086", 4)

				for iter_494_8 = 0, var_494_5.childCount - 1 do
					local var_494_6 = var_494_5:GetChild(iter_494_8)

					if var_494_6.name == "" or not string.find(var_494_6.name, "split") then
						var_494_6.gameObject:SetActive(true)
					else
						var_494_6.gameObject:SetActive(false)
					end
				end
			end

			local var_494_7 = 0.001

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_7 then
				var_494_5.localPosition = Vector3.Lerp(arg_491_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_491_1.time_ - 0) / var_494_7)
			end

			if arg_491_1.time_ >= 0 + var_494_7 and arg_491_1.time_ < 0 + var_494_7 + arg_494_0 then
				var_494_5.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_494_8 = 0
			local var_494_9 = 0.65

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_8 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_10 = arg_491_1:GetWordFromCfg(416232115)
				local var_494_11 = arg_491_1:FormatText(var_494_10.content)

				arg_491_1.text_.text = var_494_11

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_13 = 26 <= 0 and var_494_9 or var_494_9 * (utf8.len(var_494_11) / 26)

				if (26 <= 0 and var_494_9 or var_494_9 * (utf8.len(var_494_11) / 26)) > 0 and var_494_9 < var_494_13 then
					arg_491_1.talkMaxDuration = var_494_13

					if var_494_13 + var_494_8 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_13 + var_494_8
					end
				end

				arg_491_1.text_.text = var_494_11
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232115", "story_v_out_416232.awb") ~= 0 then
					local var_494_14 = manager.audio:GetVoiceLength("story_v_out_416232", "416232115", "story_v_out_416232.awb") / 1000

					if var_494_14 + var_494_8 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_14 + var_494_8
					end

					if var_494_10.prefab_name ~= "" and arg_491_1.actors_[var_494_10.prefab_name] ~= nil then
						local var_494_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_10.prefab_name].transform, "story_v_out_416232", "416232115", "story_v_out_416232.awb")

						arg_491_1:RecordAudio("416232115", var_494_15)
						arg_491_1:RecordAudio("416232115", var_494_15)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_416232", "416232115", "story_v_out_416232.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_416232", "416232115", "story_v_out_416232.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_16 = math.max(var_494_9, arg_491_1.talkMaxDuration)

			if var_494_8 <= arg_491_1.time_ and arg_491_1.time_ < var_494_8 + var_494_16 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_8) / var_494_16

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_8 + var_494_16 and arg_491_1.time_ < var_494_8 + var_494_16 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_491_1:InitPlayNodeList()
	end,
	Play416232116 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 416232116
		arg_495_1.duration_ = 3.23

		local var_495_0 = {
			zh = 3.233,
			ja = 2.866
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play416232117(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(arg_495_1.actors_["10122"]) and arg_495_1.var_.actorSpriteComps10122 == nil then
				arg_495_1.var_.actorSpriteComps10122 = arg_495_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_498_0 = 0.2

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 and not isNil(arg_495_1.actors_["10122"]) then
				if arg_495_1.var_.actorSpriteComps10122 then
					for iter_498_0, iter_498_1 in pairs(arg_495_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_498_1 then
							if arg_495_1.isInRecall_ then
								iter_498_1.color = Color.New(Mathf.Lerp(iter_498_1.color.r, arg_495_1.hightColor1.r, (arg_495_1.time_ - 0) / var_498_0), Mathf.Lerp(iter_498_1.color.g, arg_495_1.hightColor1.g, (arg_495_1.time_ - 0) / var_498_0), (Mathf.Lerp(iter_498_1.color.b, arg_495_1.hightColor1.b, (arg_495_1.time_ - 0) / var_498_0)))
							else
								local var_498_1 = Mathf.Lerp(iter_498_1.color.r, 1, (arg_495_1.time_ - 0) / var_498_0)

								iter_498_1.color = Color.New(var_498_1, var_498_1, var_498_1)
							end
						end
					end
				end
			end

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 and not isNil(arg_495_1.actors_["10122"]) and arg_495_1.var_.actorSpriteComps10122 then
				for iter_498_2, iter_498_3 in pairs(arg_495_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_498_3 then
						iter_498_3.color = arg_495_1.isInRecall_ and (arg_495_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_495_1.var_.actorSpriteComps10122 = nil
			end

			local var_498_2 = arg_495_1.actors_["1086"]

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(var_498_2) and arg_495_1.var_.actorSpriteComps1086 == nil then
				arg_495_1.var_.actorSpriteComps1086 = var_498_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_498_3 = 0.2

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_3 and not isNil(var_498_2) then
				if arg_495_1.var_.actorSpriteComps1086 then
					for iter_498_4, iter_498_5 in pairs(arg_495_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_498_5 then
							if arg_495_1.isInRecall_ then
								iter_498_5.color = Color.New(Mathf.Lerp(iter_498_5.color.r, arg_495_1.hightColor2.r, (arg_495_1.time_ - 0) / var_498_3), Mathf.Lerp(iter_498_5.color.g, arg_495_1.hightColor2.g, (arg_495_1.time_ - 0) / var_498_3), (Mathf.Lerp(iter_498_5.color.b, arg_495_1.hightColor2.b, (arg_495_1.time_ - 0) / var_498_3)))
							else
								local var_498_4 = Mathf.Lerp(iter_498_5.color.r, 0.5, (arg_495_1.time_ - 0) / var_498_3)

								iter_498_5.color = Color.New(var_498_4, var_498_4, var_498_4)
							end
						end
					end
				end
			end

			if arg_495_1.time_ >= 0 + var_498_3 and arg_495_1.time_ < 0 + var_498_3 + arg_498_0 and not isNil(var_498_2) and arg_495_1.var_.actorSpriteComps1086 then
				for iter_498_6, iter_498_7 in pairs(arg_495_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_498_7 then
						iter_498_7.color = arg_495_1.isInRecall_ and (arg_495_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_495_1.var_.actorSpriteComps1086 = nil
			end

			local var_498_5 = arg_495_1.actors_["10122"].transform

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.var_.moveOldPos10122 = var_498_5.localPosition
				var_498_5.localScale = Vector3.New(1, 1, 1)

				arg_495_1:CheckSpriteTmpPos("10122", 2)

				for iter_498_8 = 0, var_498_5.childCount - 1 do
					local var_498_6 = var_498_5:GetChild(iter_498_8)

					if var_498_6.name == "split_2" or not string.find(var_498_6.name, "split") then
						var_498_6.gameObject:SetActive(true)
					else
						var_498_6.gameObject:SetActive(false)
					end
				end
			end

			local var_498_7 = 0.001

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_7 then
				var_498_5.localPosition = Vector3.Lerp(arg_495_1.var_.moveOldPos10122, Vector3.New(-390, -380, -100), (arg_495_1.time_ - 0) / var_498_7)
			end

			if arg_495_1.time_ >= 0 + var_498_7 and arg_495_1.time_ < 0 + var_498_7 + arg_498_0 then
				var_498_5.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_498_8 = 0
			local var_498_9 = 0.4

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_8 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_10 = arg_495_1:GetWordFromCfg(416232116)
				local var_498_11 = arg_495_1:FormatText(var_498_10.content)

				arg_495_1.text_.text = var_498_11

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_13 = 16 <= 0 and var_498_9 or var_498_9 * (utf8.len(var_498_11) / 16)

				if (16 <= 0 and var_498_9 or var_498_9 * (utf8.len(var_498_11) / 16)) > 0 and var_498_9 < var_498_13 then
					arg_495_1.talkMaxDuration = var_498_13

					if var_498_13 + var_498_8 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_13 + var_498_8
					end
				end

				arg_495_1.text_.text = var_498_11
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232116", "story_v_out_416232.awb") ~= 0 then
					local var_498_14 = manager.audio:GetVoiceLength("story_v_out_416232", "416232116", "story_v_out_416232.awb") / 1000

					if var_498_14 + var_498_8 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_14 + var_498_8
					end

					if var_498_10.prefab_name ~= "" and arg_495_1.actors_[var_498_10.prefab_name] ~= nil then
						local var_498_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_10.prefab_name].transform, "story_v_out_416232", "416232116", "story_v_out_416232.awb")

						arg_495_1:RecordAudio("416232116", var_498_15)
						arg_495_1:RecordAudio("416232116", var_498_15)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_416232", "416232116", "story_v_out_416232.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_416232", "416232116", "story_v_out_416232.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_16 = math.max(var_498_9, arg_495_1.talkMaxDuration)

			if var_498_8 <= arg_495_1.time_ and arg_495_1.time_ < var_498_8 + var_498_16 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_8) / var_498_16

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_8 + var_498_16 and arg_495_1.time_ < var_498_8 + var_498_16 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_495_1:InitPlayNodeList()
	end,
	Play416232117 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 416232117
		arg_499_1.duration_ = 6.43

		local var_499_0 = {
			zh = 2.766,
			ja = 6.433
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play416232118(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(arg_499_1.actors_["1086"]) and arg_499_1.var_.actorSpriteComps1086 == nil then
				arg_499_1.var_.actorSpriteComps1086 = arg_499_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_502_0 = 0.2

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 and not isNil(arg_499_1.actors_["1086"]) then
				if arg_499_1.var_.actorSpriteComps1086 then
					for iter_502_0, iter_502_1 in pairs(arg_499_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_502_1 then
							if arg_499_1.isInRecall_ then
								iter_502_1.color = Color.New(Mathf.Lerp(iter_502_1.color.r, arg_499_1.hightColor1.r, (arg_499_1.time_ - 0) / var_502_0), Mathf.Lerp(iter_502_1.color.g, arg_499_1.hightColor1.g, (arg_499_1.time_ - 0) / var_502_0), (Mathf.Lerp(iter_502_1.color.b, arg_499_1.hightColor1.b, (arg_499_1.time_ - 0) / var_502_0)))
							else
								local var_502_1 = Mathf.Lerp(iter_502_1.color.r, 1, (arg_499_1.time_ - 0) / var_502_0)

								iter_502_1.color = Color.New(var_502_1, var_502_1, var_502_1)
							end
						end
					end
				end
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 and not isNil(arg_499_1.actors_["1086"]) and arg_499_1.var_.actorSpriteComps1086 then
				for iter_502_2, iter_502_3 in pairs(arg_499_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_502_3 then
						iter_502_3.color = arg_499_1.isInRecall_ and (arg_499_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_499_1.var_.actorSpriteComps1086 = nil
			end

			local var_502_2 = arg_499_1.actors_["10122"]

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(var_502_2) and arg_499_1.var_.actorSpriteComps10122 == nil then
				arg_499_1.var_.actorSpriteComps10122 = var_502_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_502_3 = 0.2

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_3 and not isNil(var_502_2) then
				if arg_499_1.var_.actorSpriteComps10122 then
					for iter_502_4, iter_502_5 in pairs(arg_499_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_502_5 then
							if arg_499_1.isInRecall_ then
								iter_502_5.color = Color.New(Mathf.Lerp(iter_502_5.color.r, arg_499_1.hightColor2.r, (arg_499_1.time_ - 0) / var_502_3), Mathf.Lerp(iter_502_5.color.g, arg_499_1.hightColor2.g, (arg_499_1.time_ - 0) / var_502_3), (Mathf.Lerp(iter_502_5.color.b, arg_499_1.hightColor2.b, (arg_499_1.time_ - 0) / var_502_3)))
							else
								local var_502_4 = Mathf.Lerp(iter_502_5.color.r, 0.5, (arg_499_1.time_ - 0) / var_502_3)

								iter_502_5.color = Color.New(var_502_4, var_502_4, var_502_4)
							end
						end
					end
				end
			end

			if arg_499_1.time_ >= 0 + var_502_3 and arg_499_1.time_ < 0 + var_502_3 + arg_502_0 and not isNil(var_502_2) and arg_499_1.var_.actorSpriteComps10122 then
				for iter_502_6, iter_502_7 in pairs(arg_499_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_502_7 then
						iter_502_7.color = arg_499_1.isInRecall_ and (arg_499_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_499_1.var_.actorSpriteComps10122 = nil
			end

			local var_502_5 = 0
			local var_502_6 = 0.325

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_5 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_7 = arg_499_1:GetWordFromCfg(416232117)
				local var_502_8 = arg_499_1:FormatText(var_502_7.content)

				arg_499_1.text_.text = var_502_8

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_10 = 13 <= 0 and var_502_6 or var_502_6 * (utf8.len(var_502_8) / 13)

				if (13 <= 0 and var_502_6 or var_502_6 * (utf8.len(var_502_8) / 13)) > 0 and var_502_6 < var_502_10 then
					arg_499_1.talkMaxDuration = var_502_10

					if var_502_10 + var_502_5 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_10 + var_502_5
					end
				end

				arg_499_1.text_.text = var_502_8
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232117", "story_v_out_416232.awb") ~= 0 then
					local var_502_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232117", "story_v_out_416232.awb") / 1000

					if var_502_11 + var_502_5 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_11 + var_502_5
					end

					if var_502_7.prefab_name ~= "" and arg_499_1.actors_[var_502_7.prefab_name] ~= nil then
						local var_502_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_7.prefab_name].transform, "story_v_out_416232", "416232117", "story_v_out_416232.awb")

						arg_499_1:RecordAudio("416232117", var_502_12)
						arg_499_1:RecordAudio("416232117", var_502_12)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_416232", "416232117", "story_v_out_416232.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_416232", "416232117", "story_v_out_416232.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_13 = math.max(var_502_6, arg_499_1.talkMaxDuration)

			if var_502_5 <= arg_499_1.time_ and arg_499_1.time_ < var_502_5 + var_502_13 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_5) / var_502_13

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_5 + var_502_13 and arg_499_1.time_ < var_502_5 + var_502_13 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {}

		arg_499_1:InitPlayNodeList()
	end,
	Play416232118 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 416232118
		arg_503_1.duration_ = 6.67

		local var_503_0 = {
			zh = 6.666,
			ja = 4.133
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play416232119(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(arg_503_1.actors_["10122"]) and arg_503_1.var_.actorSpriteComps10122 == nil then
				arg_503_1.var_.actorSpriteComps10122 = arg_503_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_506_0 = 0.2

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 and not isNil(arg_503_1.actors_["10122"]) then
				if arg_503_1.var_.actorSpriteComps10122 then
					for iter_506_0, iter_506_1 in pairs(arg_503_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_506_1 then
							if arg_503_1.isInRecall_ then
								iter_506_1.color = Color.New(Mathf.Lerp(iter_506_1.color.r, arg_503_1.hightColor1.r, (arg_503_1.time_ - 0) / var_506_0), Mathf.Lerp(iter_506_1.color.g, arg_503_1.hightColor1.g, (arg_503_1.time_ - 0) / var_506_0), (Mathf.Lerp(iter_506_1.color.b, arg_503_1.hightColor1.b, (arg_503_1.time_ - 0) / var_506_0)))
							else
								local var_506_1 = Mathf.Lerp(iter_506_1.color.r, 1, (arg_503_1.time_ - 0) / var_506_0)

								iter_506_1.color = Color.New(var_506_1, var_506_1, var_506_1)
							end
						end
					end
				end
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 and not isNil(arg_503_1.actors_["10122"]) and arg_503_1.var_.actorSpriteComps10122 then
				for iter_506_2, iter_506_3 in pairs(arg_503_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_506_3 then
						iter_506_3.color = arg_503_1.isInRecall_ and (arg_503_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_503_1.var_.actorSpriteComps10122 = nil
			end

			local var_506_2 = arg_503_1.actors_["1086"]

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(var_506_2) and arg_503_1.var_.actorSpriteComps1086 == nil then
				arg_503_1.var_.actorSpriteComps1086 = var_506_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_506_3 = 0.2

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_3 and not isNil(var_506_2) then
				if arg_503_1.var_.actorSpriteComps1086 then
					for iter_506_4, iter_506_5 in pairs(arg_503_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_506_5 then
							if arg_503_1.isInRecall_ then
								iter_506_5.color = Color.New(Mathf.Lerp(iter_506_5.color.r, arg_503_1.hightColor2.r, (arg_503_1.time_ - 0) / var_506_3), Mathf.Lerp(iter_506_5.color.g, arg_503_1.hightColor2.g, (arg_503_1.time_ - 0) / var_506_3), (Mathf.Lerp(iter_506_5.color.b, arg_503_1.hightColor2.b, (arg_503_1.time_ - 0) / var_506_3)))
							else
								local var_506_4 = Mathf.Lerp(iter_506_5.color.r, 0.5, (arg_503_1.time_ - 0) / var_506_3)

								iter_506_5.color = Color.New(var_506_4, var_506_4, var_506_4)
							end
						end
					end
				end
			end

			if arg_503_1.time_ >= 0 + var_506_3 and arg_503_1.time_ < 0 + var_506_3 + arg_506_0 and not isNil(var_506_2) and arg_503_1.var_.actorSpriteComps1086 then
				for iter_506_6, iter_506_7 in pairs(arg_503_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_506_7 then
						iter_506_7.color = arg_503_1.isInRecall_ and (arg_503_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_503_1.var_.actorSpriteComps1086 = nil
			end

			local var_506_5 = arg_503_1.actors_["10122"].transform

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.var_.moveOldPos10122 = var_506_5.localPosition
				var_506_5.localScale = Vector3.New(1, 1, 1)

				arg_503_1:CheckSpriteTmpPos("10122", 2)

				for iter_506_8 = 0, var_506_5.childCount - 1 do
					local var_506_6 = var_506_5:GetChild(iter_506_8)

					if var_506_6.name == "" or not string.find(var_506_6.name, "split") then
						var_506_6.gameObject:SetActive(true)
					else
						var_506_6.gameObject:SetActive(false)
					end
				end
			end

			local var_506_7 = 0.001

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_7 then
				var_506_5.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos10122, Vector3.New(-390, -380, -100), (arg_503_1.time_ - 0) / var_506_7)
			end

			if arg_503_1.time_ >= 0 + var_506_7 and arg_503_1.time_ < 0 + var_506_7 + arg_506_0 then
				var_506_5.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_506_8 = 0
			local var_506_9 = 0.775

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_8 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_10 = arg_503_1:GetWordFromCfg(416232118)
				local var_506_11 = arg_503_1:FormatText(var_506_10.content)

				arg_503_1.text_.text = var_506_11

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_13 = 31 <= 0 and var_506_9 or var_506_9 * (utf8.len(var_506_11) / 31)

				if (31 <= 0 and var_506_9 or var_506_9 * (utf8.len(var_506_11) / 31)) > 0 and var_506_9 < var_506_13 then
					arg_503_1.talkMaxDuration = var_506_13

					if var_506_13 + var_506_8 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_13 + var_506_8
					end
				end

				arg_503_1.text_.text = var_506_11
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232118", "story_v_out_416232.awb") ~= 0 then
					local var_506_14 = manager.audio:GetVoiceLength("story_v_out_416232", "416232118", "story_v_out_416232.awb") / 1000

					if var_506_14 + var_506_8 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_14 + var_506_8
					end

					if var_506_10.prefab_name ~= "" and arg_503_1.actors_[var_506_10.prefab_name] ~= nil then
						local var_506_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_10.prefab_name].transform, "story_v_out_416232", "416232118", "story_v_out_416232.awb")

						arg_503_1:RecordAudio("416232118", var_506_15)
						arg_503_1:RecordAudio("416232118", var_506_15)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_416232", "416232118", "story_v_out_416232.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_416232", "416232118", "story_v_out_416232.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_16 = math.max(var_506_9, arg_503_1.talkMaxDuration)

			if var_506_8 <= arg_503_1.time_ and arg_503_1.time_ < var_506_8 + var_506_16 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_8) / var_506_16

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_8 + var_506_16 and arg_503_1.time_ < var_506_8 + var_506_16 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_503_1:InitPlayNodeList()
	end,
	Play416232119 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 416232119
		arg_507_1.duration_ = 5

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play416232120(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(arg_507_1.actors_["10122"]) and arg_507_1.var_.actorSpriteComps10122 == nil then
				arg_507_1.var_.actorSpriteComps10122 = arg_507_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_510_0 = 0.2

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 and not isNil(arg_507_1.actors_["10122"]) then
				if arg_507_1.var_.actorSpriteComps10122 then
					for iter_510_0, iter_510_1 in pairs(arg_507_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_510_1 then
							if arg_507_1.isInRecall_ then
								iter_510_1.color = Color.New(Mathf.Lerp(iter_510_1.color.r, arg_507_1.hightColor2.r, (arg_507_1.time_ - 0) / var_510_0), Mathf.Lerp(iter_510_1.color.g, arg_507_1.hightColor2.g, (arg_507_1.time_ - 0) / var_510_0), (Mathf.Lerp(iter_510_1.color.b, arg_507_1.hightColor2.b, (arg_507_1.time_ - 0) / var_510_0)))
							else
								local var_510_1 = Mathf.Lerp(iter_510_1.color.r, 0.5, (arg_507_1.time_ - 0) / var_510_0)

								iter_510_1.color = Color.New(var_510_1, var_510_1, var_510_1)
							end
						end
					end
				end
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 and not isNil(arg_507_1.actors_["10122"]) and arg_507_1.var_.actorSpriteComps10122 then
				for iter_510_2, iter_510_3 in pairs(arg_507_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_510_3 then
						iter_510_3.color = arg_507_1.isInRecall_ and (arg_507_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_507_1.var_.actorSpriteComps10122 = nil
			end

			local var_510_2 = 0
			local var_510_3 = 0.75

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_2 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, false)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_4 = arg_507_1:FormatText(arg_507_1:GetWordFromCfg(416232119).content)

				arg_507_1.text_.text = var_510_4

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_6 = 30 <= 0 and var_510_3 or var_510_3 * (utf8.len(var_510_4) / 30)

				if (30 <= 0 and var_510_3 or var_510_3 * (utf8.len(var_510_4) / 30)) > 0 and var_510_3 < var_510_6 then
					arg_507_1.talkMaxDuration = var_510_6

					if var_510_6 + var_510_2 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_6 + var_510_2
					end
				end

				arg_507_1.text_.text = var_510_4
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)
				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_7 = math.max(var_510_3, arg_507_1.talkMaxDuration)

			if var_510_2 <= arg_507_1.time_ and arg_507_1.time_ < var_510_2 + var_510_7 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_2) / var_510_7

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_2 + var_510_7 and arg_507_1.time_ < var_510_2 + var_510_7 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	Play416232120 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 416232120
		arg_511_1.duration_ = 9.53

		local var_511_0 = {
			zh = 5.933,
			ja = 9.533
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play416232121(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(arg_511_1.actors_["1086"]) and arg_511_1.var_.actorSpriteComps1086 == nil then
				arg_511_1.var_.actorSpriteComps1086 = arg_511_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_514_0 = 0.2

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 and not isNil(arg_511_1.actors_["1086"]) then
				if arg_511_1.var_.actorSpriteComps1086 then
					for iter_514_0, iter_514_1 in pairs(arg_511_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_514_1 then
							if arg_511_1.isInRecall_ then
								iter_514_1.color = Color.New(Mathf.Lerp(iter_514_1.color.r, arg_511_1.hightColor1.r, (arg_511_1.time_ - 0) / var_514_0), Mathf.Lerp(iter_514_1.color.g, arg_511_1.hightColor1.g, (arg_511_1.time_ - 0) / var_514_0), (Mathf.Lerp(iter_514_1.color.b, arg_511_1.hightColor1.b, (arg_511_1.time_ - 0) / var_514_0)))
							else
								local var_514_1 = Mathf.Lerp(iter_514_1.color.r, 1, (arg_511_1.time_ - 0) / var_514_0)

								iter_514_1.color = Color.New(var_514_1, var_514_1, var_514_1)
							end
						end
					end
				end
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 and not isNil(arg_511_1.actors_["1086"]) and arg_511_1.var_.actorSpriteComps1086 then
				for iter_514_2, iter_514_3 in pairs(arg_511_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_514_3 then
						iter_514_3.color = arg_511_1.isInRecall_ and (arg_511_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_511_1.var_.actorSpriteComps1086 = nil
			end

			local var_514_2 = 0
			local var_514_3 = 0.75

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_2 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_4 = arg_511_1:GetWordFromCfg(416232120)
				local var_514_5 = arg_511_1:FormatText(var_514_4.content)

				arg_511_1.text_.text = var_514_5

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_7 = 30 <= 0 and var_514_3 or var_514_3 * (utf8.len(var_514_5) / 30)

				if (30 <= 0 and var_514_3 or var_514_3 * (utf8.len(var_514_5) / 30)) > 0 and var_514_3 < var_514_7 then
					arg_511_1.talkMaxDuration = var_514_7

					if var_514_7 + var_514_2 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_7 + var_514_2
					end
				end

				arg_511_1.text_.text = var_514_5
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232120", "story_v_out_416232.awb") ~= 0 then
					local var_514_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232120", "story_v_out_416232.awb") / 1000

					if var_514_8 + var_514_2 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_8 + var_514_2
					end

					if var_514_4.prefab_name ~= "" and arg_511_1.actors_[var_514_4.prefab_name] ~= nil then
						local var_514_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_4.prefab_name].transform, "story_v_out_416232", "416232120", "story_v_out_416232.awb")

						arg_511_1:RecordAudio("416232120", var_514_9)
						arg_511_1:RecordAudio("416232120", var_514_9)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_416232", "416232120", "story_v_out_416232.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_416232", "416232120", "story_v_out_416232.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_10 = math.max(var_514_3, arg_511_1.talkMaxDuration)

			if var_514_2 <= arg_511_1.time_ and arg_511_1.time_ < var_514_2 + var_514_10 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_2) / var_514_10

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_2 + var_514_10 and arg_511_1.time_ < var_514_2 + var_514_10 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play416232121 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 416232121
		arg_515_1.duration_ = 5.5

		local var_515_0 = {
			zh = 5.5,
			ja = 4.7
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play416232122(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(arg_515_1.actors_["10122"]) and arg_515_1.var_.actorSpriteComps10122 == nil then
				arg_515_1.var_.actorSpriteComps10122 = arg_515_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_518_0 = 0.2

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 and not isNil(arg_515_1.actors_["10122"]) then
				if arg_515_1.var_.actorSpriteComps10122 then
					for iter_518_0, iter_518_1 in pairs(arg_515_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_518_1 then
							if arg_515_1.isInRecall_ then
								iter_518_1.color = Color.New(Mathf.Lerp(iter_518_1.color.r, arg_515_1.hightColor1.r, (arg_515_1.time_ - 0) / var_518_0), Mathf.Lerp(iter_518_1.color.g, arg_515_1.hightColor1.g, (arg_515_1.time_ - 0) / var_518_0), (Mathf.Lerp(iter_518_1.color.b, arg_515_1.hightColor1.b, (arg_515_1.time_ - 0) / var_518_0)))
							else
								local var_518_1 = Mathf.Lerp(iter_518_1.color.r, 1, (arg_515_1.time_ - 0) / var_518_0)

								iter_518_1.color = Color.New(var_518_1, var_518_1, var_518_1)
							end
						end
					end
				end
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 and not isNil(arg_515_1.actors_["10122"]) and arg_515_1.var_.actorSpriteComps10122 then
				for iter_518_2, iter_518_3 in pairs(arg_515_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_518_3 then
						iter_518_3.color = arg_515_1.isInRecall_ and (arg_515_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_515_1.var_.actorSpriteComps10122 = nil
			end

			local var_518_2 = arg_515_1.actors_["1086"]

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(var_518_2) and arg_515_1.var_.actorSpriteComps1086 == nil then
				arg_515_1.var_.actorSpriteComps1086 = var_518_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_518_3 = 0.2

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_3 and not isNil(var_518_2) then
				if arg_515_1.var_.actorSpriteComps1086 then
					for iter_518_4, iter_518_5 in pairs(arg_515_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_518_5 then
							if arg_515_1.isInRecall_ then
								iter_518_5.color = Color.New(Mathf.Lerp(iter_518_5.color.r, arg_515_1.hightColor2.r, (arg_515_1.time_ - 0) / var_518_3), Mathf.Lerp(iter_518_5.color.g, arg_515_1.hightColor2.g, (arg_515_1.time_ - 0) / var_518_3), (Mathf.Lerp(iter_518_5.color.b, arg_515_1.hightColor2.b, (arg_515_1.time_ - 0) / var_518_3)))
							else
								local var_518_4 = Mathf.Lerp(iter_518_5.color.r, 0.5, (arg_515_1.time_ - 0) / var_518_3)

								iter_518_5.color = Color.New(var_518_4, var_518_4, var_518_4)
							end
						end
					end
				end
			end

			if arg_515_1.time_ >= 0 + var_518_3 and arg_515_1.time_ < 0 + var_518_3 + arg_518_0 and not isNil(var_518_2) and arg_515_1.var_.actorSpriteComps1086 then
				for iter_518_6, iter_518_7 in pairs(arg_515_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_518_7 then
						iter_518_7.color = arg_515_1.isInRecall_ and (arg_515_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_515_1.var_.actorSpriteComps1086 = nil
			end

			local var_518_5 = arg_515_1.actors_["10122"].transform

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos10122 = var_518_5.localPosition
				var_518_5.localScale = Vector3.New(1, 1, 1)

				arg_515_1:CheckSpriteTmpPos("10122", 2)

				for iter_518_8 = 0, var_518_5.childCount - 1 do
					local var_518_6 = var_518_5:GetChild(iter_518_8)

					if var_518_6.name == "split_4" or not string.find(var_518_6.name, "split") then
						var_518_6.gameObject:SetActive(true)
					else
						var_518_6.gameObject:SetActive(false)
					end
				end
			end

			local var_518_7 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_7 then
				var_518_5.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos10122, Vector3.New(-390, -380, -100), (arg_515_1.time_ - 0) / var_518_7)
			end

			if arg_515_1.time_ >= 0 + var_518_7 and arg_515_1.time_ < 0 + var_518_7 + arg_518_0 then
				var_518_5.localPosition = Vector3.New(-390, -380, -100)
			end

			local var_518_8 = 0
			local var_518_9 = 0.575

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_8 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_10 = arg_515_1:GetWordFromCfg(416232121)
				local var_518_11 = arg_515_1:FormatText(var_518_10.content)

				arg_515_1.text_.text = var_518_11

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_13 = 23 <= 0 and var_518_9 or var_518_9 * (utf8.len(var_518_11) / 23)

				if (23 <= 0 and var_518_9 or var_518_9 * (utf8.len(var_518_11) / 23)) > 0 and var_518_9 < var_518_13 then
					arg_515_1.talkMaxDuration = var_518_13

					if var_518_13 + var_518_8 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_13 + var_518_8
					end
				end

				arg_515_1.text_.text = var_518_11
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232121", "story_v_out_416232.awb") ~= 0 then
					local var_518_14 = manager.audio:GetVoiceLength("story_v_out_416232", "416232121", "story_v_out_416232.awb") / 1000

					if var_518_14 + var_518_8 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_14 + var_518_8
					end

					if var_518_10.prefab_name ~= "" and arg_515_1.actors_[var_518_10.prefab_name] ~= nil then
						local var_518_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_10.prefab_name].transform, "story_v_out_416232", "416232121", "story_v_out_416232.awb")

						arg_515_1:RecordAudio("416232121", var_518_15)
						arg_515_1:RecordAudio("416232121", var_518_15)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_416232", "416232121", "story_v_out_416232.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_416232", "416232121", "story_v_out_416232.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_16 = math.max(var_518_9, arg_515_1.talkMaxDuration)

			if var_518_8 <= arg_515_1.time_ and arg_515_1.time_ < var_518_8 + var_518_16 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_8) / var_518_16

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_8 + var_518_16 and arg_515_1.time_ < var_518_8 + var_518_16 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_515_1:InitPlayNodeList()
	end,
	Play416232122 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 416232122
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play416232123(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(arg_519_1.actors_["10122"]) and arg_519_1.var_.actorSpriteComps10122 == nil then
				arg_519_1.var_.actorSpriteComps10122 = arg_519_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_522_0 = 0.2

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 and not isNil(arg_519_1.actors_["10122"]) then
				if arg_519_1.var_.actorSpriteComps10122 then
					for iter_522_0, iter_522_1 in pairs(arg_519_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_522_1 then
							if arg_519_1.isInRecall_ then
								iter_522_1.color = Color.New(Mathf.Lerp(iter_522_1.color.r, arg_519_1.hightColor2.r, (arg_519_1.time_ - 0) / var_522_0), Mathf.Lerp(iter_522_1.color.g, arg_519_1.hightColor2.g, (arg_519_1.time_ - 0) / var_522_0), (Mathf.Lerp(iter_522_1.color.b, arg_519_1.hightColor2.b, (arg_519_1.time_ - 0) / var_522_0)))
							else
								local var_522_1 = Mathf.Lerp(iter_522_1.color.r, 0.5, (arg_519_1.time_ - 0) / var_522_0)

								iter_522_1.color = Color.New(var_522_1, var_522_1, var_522_1)
							end
						end
					end
				end
			end

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 and not isNil(arg_519_1.actors_["10122"]) and arg_519_1.var_.actorSpriteComps10122 then
				for iter_522_2, iter_522_3 in pairs(arg_519_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_522_3 then
						iter_522_3.color = arg_519_1.isInRecall_ and (arg_519_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_519_1.var_.actorSpriteComps10122 = nil
			end

			local var_522_2 = arg_519_1.actors_["10122"].transform

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos10122 = var_522_2.localPosition
				var_522_2.localScale = Vector3.New(1, 1, 1)

				arg_519_1:CheckSpriteTmpPos("10122", 7)

				for iter_522_4 = 0, var_522_2.childCount - 1 do
					local var_522_3 = var_522_2:GetChild(iter_522_4)

					if var_522_3.name == "" or not string.find(var_522_3.name, "split") then
						var_522_3.gameObject:SetActive(true)
					else
						var_522_3.gameObject:SetActive(false)
					end
				end
			end

			local var_522_4 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_4 then
				var_522_2.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10122, Vector3.New(0, -2000, 0), (arg_519_1.time_ - 0) / var_522_4)
			end

			if arg_519_1.time_ >= 0 + var_522_4 and arg_519_1.time_ < 0 + var_522_4 + arg_522_0 then
				var_522_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_522_5 = arg_519_1.actors_["1086"].transform

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos1086 = var_522_5.localPosition
				var_522_5.localScale = Vector3.New(1, 1, 1)

				arg_519_1:CheckSpriteTmpPos("1086", 7)

				for iter_522_5 = 0, var_522_5.childCount - 1 do
					local var_522_6 = var_522_5:GetChild(iter_522_5)

					if var_522_6.name == "" or not string.find(var_522_6.name, "split") then
						var_522_6.gameObject:SetActive(true)
					else
						var_522_6.gameObject:SetActive(false)
					end
				end
			end

			local var_522_7 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_7 then
				var_522_5.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_519_1.time_ - 0) / var_522_7)
			end

			if arg_519_1.time_ >= 0 + var_522_7 and arg_519_1.time_ < 0 + var_522_7 + arg_522_0 then
				var_522_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_522_8 = 0
			local var_522_9 = 0.775

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_8 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, false)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_10 = arg_519_1:FormatText(arg_519_1:GetWordFromCfg(416232122).content)

				arg_519_1.text_.text = var_522_10

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_12 = 31 <= 0 and var_522_9 or var_522_9 * (utf8.len(var_522_10) / 31)

				if (31 <= 0 and var_522_9 or var_522_9 * (utf8.len(var_522_10) / 31)) > 0 and var_522_9 < var_522_12 then
					arg_519_1.talkMaxDuration = var_522_12

					if var_522_12 + var_522_8 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_12 + var_522_8
					end
				end

				arg_519_1.text_.text = var_522_10
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_13 = math.max(var_522_9, arg_519_1.talkMaxDuration)

			if var_522_8 <= arg_519_1.time_ and arg_519_1.time_ < var_522_8 + var_522_13 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_8) / var_522_13

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_8 + var_522_13 and arg_519_1.time_ < var_522_8 + var_522_13 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_519_1:InitPlayNodeList()
	end,
	Play416232123 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 416232123
		arg_523_1.duration_ = 10.23

		local var_523_0 = {
			zh = 4.866,
			ja = 10.233
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play416232124(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(arg_523_1.actors_["1086"]) and arg_523_1.var_.actorSpriteComps1086 == nil then
				arg_523_1.var_.actorSpriteComps1086 = arg_523_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_526_0 = 0.2

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_0 and not isNil(arg_523_1.actors_["1086"]) then
				if arg_523_1.var_.actorSpriteComps1086 then
					for iter_526_0, iter_526_1 in pairs(arg_523_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_526_1 then
							if arg_523_1.isInRecall_ then
								iter_526_1.color = Color.New(Mathf.Lerp(iter_526_1.color.r, arg_523_1.hightColor1.r, (arg_523_1.time_ - 0) / var_526_0), Mathf.Lerp(iter_526_1.color.g, arg_523_1.hightColor1.g, (arg_523_1.time_ - 0) / var_526_0), (Mathf.Lerp(iter_526_1.color.b, arg_523_1.hightColor1.b, (arg_523_1.time_ - 0) / var_526_0)))
							else
								local var_526_1 = Mathf.Lerp(iter_526_1.color.r, 1, (arg_523_1.time_ - 0) / var_526_0)

								iter_526_1.color = Color.New(var_526_1, var_526_1, var_526_1)
							end
						end
					end
				end
			end

			if arg_523_1.time_ >= 0 + var_526_0 and arg_523_1.time_ < 0 + var_526_0 + arg_526_0 and not isNil(arg_523_1.actors_["1086"]) and arg_523_1.var_.actorSpriteComps1086 then
				for iter_526_2, iter_526_3 in pairs(arg_523_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_526_3 then
						iter_526_3.color = arg_523_1.isInRecall_ and (arg_523_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_523_1.var_.actorSpriteComps1086 = nil
			end

			local var_526_2 = arg_523_1.actors_["1086"].transform

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.var_.moveOldPos1086 = var_526_2.localPosition
				var_526_2.localScale = Vector3.New(1, 1, 1)

				arg_523_1:CheckSpriteTmpPos("1086", 3)

				for iter_526_4 = 0, var_526_2.childCount - 1 do
					local var_526_3 = var_526_2:GetChild(iter_526_4)

					if var_526_3.name == "split_6" or not string.find(var_526_3.name, "split") then
						var_526_3.gameObject:SetActive(true)
					else
						var_526_3.gameObject:SetActive(false)
					end
				end
			end

			local var_526_4 = 0.001

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_4 then
				var_526_2.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_523_1.time_ - 0) / var_526_4)
			end

			if arg_523_1.time_ >= 0 + var_526_4 and arg_523_1.time_ < 0 + var_526_4 + arg_526_0 then
				var_526_2.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_526_5 = 0
			local var_526_6 = 0.675

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_5 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_7 = arg_523_1:GetWordFromCfg(416232123)
				local var_526_8 = arg_523_1:FormatText(var_526_7.content)

				arg_523_1.text_.text = var_526_8

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_10 = 27 <= 0 and var_526_6 or var_526_6 * (utf8.len(var_526_8) / 27)

				if (27 <= 0 and var_526_6 or var_526_6 * (utf8.len(var_526_8) / 27)) > 0 and var_526_6 < var_526_10 then
					arg_523_1.talkMaxDuration = var_526_10

					if var_526_10 + var_526_5 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_10 + var_526_5
					end
				end

				arg_523_1.text_.text = var_526_8
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232123", "story_v_out_416232.awb") ~= 0 then
					local var_526_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232123", "story_v_out_416232.awb") / 1000

					if var_526_11 + var_526_5 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_11 + var_526_5
					end

					if var_526_7.prefab_name ~= "" and arg_523_1.actors_[var_526_7.prefab_name] ~= nil then
						local var_526_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_7.prefab_name].transform, "story_v_out_416232", "416232123", "story_v_out_416232.awb")

						arg_523_1:RecordAudio("416232123", var_526_12)
						arg_523_1:RecordAudio("416232123", var_526_12)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_416232", "416232123", "story_v_out_416232.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_416232", "416232123", "story_v_out_416232.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_13 = math.max(var_526_6, arg_523_1.talkMaxDuration)

			if var_526_5 <= arg_523_1.time_ and arg_523_1.time_ < var_526_5 + var_526_13 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_5) / var_526_13

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_5 + var_526_13 and arg_523_1.time_ < var_526_5 + var_526_13 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_523_1:InitPlayNodeList()
	end,
	Play416232124 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 416232124
		arg_527_1.duration_ = 4.53

		local var_527_0 = {
			zh = 3.666,
			ja = 4.533
		}
		local var_527_1 = manager.audio:GetLocalizationFlag()

		if var_527_0[var_527_1] ~= nil then
			arg_527_1.duration_ = var_527_0[var_527_1]
		end

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play416232125(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0.225

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_1 = arg_527_1:GetWordFromCfg(416232124)
				local var_530_2 = arg_527_1:FormatText(var_530_1.content)

				arg_527_1.text_.text = var_530_2

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_4 = 9 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_2) / 9)

				if (9 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_2) / 9)) > 0 and var_530_0 < var_530_4 then
					arg_527_1.talkMaxDuration = var_530_4

					if var_530_4 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_4 + 0
					end
				end

				arg_527_1.text_.text = var_530_2
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232124", "story_v_out_416232.awb") ~= 0 then
					local var_530_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232124", "story_v_out_416232.awb") / 1000

					if var_530_5 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_5 + 0
					end

					if var_530_1.prefab_name ~= "" and arg_527_1.actors_[var_530_1.prefab_name] ~= nil then
						local var_530_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_1.prefab_name].transform, "story_v_out_416232", "416232124", "story_v_out_416232.awb")

						arg_527_1:RecordAudio("416232124", var_530_6)
						arg_527_1:RecordAudio("416232124", var_530_6)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_416232", "416232124", "story_v_out_416232.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_416232", "416232124", "story_v_out_416232.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_7 = math.max(var_530_0, arg_527_1.talkMaxDuration)

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_7 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - 0) / var_530_7

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= 0 + var_530_7 and arg_527_1.time_ < 0 + var_530_7 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play416232125 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 416232125
		arg_531_1.duration_ = 7.03

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play416232126(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.mask_.enabled = true
				arg_531_1.mask_.raycastTarget = true

				arg_531_1:SetGaussion(false)
			end

			local var_534_0 = 1.034

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 then
				local var_534_1 = Color.New(0, 0, 0)

				var_534_1.a = Mathf.Lerp(0, 1, (arg_531_1.time_ - 0) / var_534_0)
				arg_531_1.mask_.color = var_534_1
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 then
				local var_534_2 = Color.New(0, 0, 0)

				var_534_2.a = 1
				arg_531_1.mask_.color = var_534_2
			end

			local var_534_3 = 1.034

			if 1.034 < arg_531_1.time_ and arg_531_1.time_ <= var_534_3 + arg_534_0 then
				arg_531_1.mask_.enabled = true
				arg_531_1.mask_.raycastTarget = true

				arg_531_1:SetGaussion(false)
			end

			local var_534_4 = 1

			if var_534_3 <= arg_531_1.time_ and arg_531_1.time_ < var_534_3 + var_534_4 then
				local var_534_5 = Color.New(0, 0, 0)

				var_534_5.a = Mathf.Lerp(1, 0, (arg_531_1.time_ - var_534_3) / var_534_4)
				arg_531_1.mask_.color = var_534_5
			end

			if arg_531_1.time_ >= var_534_3 + var_534_4 and arg_531_1.time_ < var_534_3 + var_534_4 + arg_534_0 then
				local var_534_6 = Color.New(0, 0, 0)

				arg_531_1.mask_.enabled = false
				var_534_6.a = 0
				arg_531_1.mask_.color = var_534_6
			end

			local var_534_7 = manager.ui.mainCamera.transform

			if 1.034 < arg_531_1.time_ and arg_531_1.time_ <= 1.034 + arg_534_0 then
				arg_531_1.var_.shakeOldPos = var_534_7.localPosition
			end

			local var_534_8 = 0.666666666666667

			if 1.034 <= arg_531_1.time_ and arg_531_1.time_ < 1.034 + var_534_8 then
				local var_534_9, var_534_10 = math.modf((arg_531_1.time_ - 1.034) / 0.066)

				var_534_7.localPosition = Vector3.New(var_534_10 * 0.13, var_534_10 * 0.13, var_534_10 * 0.13) + arg_531_1.var_.shakeOldPos
			end

			if arg_531_1.time_ >= 1.034 + var_534_8 and arg_531_1.time_ < 1.034 + var_534_8 + arg_534_0 then
				var_534_7.localPosition = arg_531_1.var_.shakeOldPos
			end

			local var_534_11 = 0

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_11 + arg_534_0 then
				arg_531_1.allBtn_.enabled = false
			end

			if arg_531_1.time_ >= var_534_11 + 1.16666666666667 and arg_531_1.time_ < var_534_11 + 1.16666666666667 + arg_534_0 then
				arg_531_1.allBtn_.enabled = true
			end

			local var_534_12 = arg_531_1.actors_["1086"].transform

			if 1 < arg_531_1.time_ and arg_531_1.time_ <= 1 + arg_534_0 then
				arg_531_1.var_.moveOldPos1086 = var_534_12.localPosition
				var_534_12.localScale = Vector3.New(1, 1, 1)

				arg_531_1:CheckSpriteTmpPos("1086", 7)

				for iter_534_0 = 0, var_534_12.childCount - 1 do
					local var_534_13 = var_534_12:GetChild(iter_534_0)

					if var_534_13.name == "" or not string.find(var_534_13.name, "split") then
						var_534_13.gameObject:SetActive(true)
					else
						var_534_13.gameObject:SetActive(false)
					end
				end
			end

			local var_534_14 = 0.001

			if 1 <= arg_531_1.time_ and arg_531_1.time_ < 1 + var_534_14 then
				var_534_12.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_531_1.time_ - 1) / var_534_14)
			end

			if arg_531_1.time_ >= 1 + var_534_14 and arg_531_1.time_ < 1 + var_534_14 + arg_534_0 then
				var_534_12.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1:AudioAction("play", "effect", "se_story_130", "se_story_130__factorystartup", "")
			end

			if arg_531_1.frameCnt_ <= 1 then
				arg_531_1.dialog_:SetActive(false)
			end

			local var_534_16 = 2.034
			local var_534_17 = 1.475

			if 2.034 < arg_531_1.time_ and arg_531_1.time_ <= var_534_16 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0

				arg_531_1.dialog_:SetActive(true)

				arg_531_1.dialogCg_.alpha = 0

				local var_534_18 = LeanTween.value(arg_531_1.dialog_, 0, 1, 0.3)

				var_534_18:setOnUpdate(LuaHelper.FloatAction(function(arg_535_0)
					arg_531_1.dialogCg_.alpha = arg_535_0
				end))
				var_534_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_531_1.dialog_)
					var_534_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_531_1.duration_ = arg_531_1.duration_ + 0.3

				SetActive(arg_531_1.leftNameGo_, false)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_19 = arg_531_1:FormatText(arg_531_1:GetWordFromCfg(416232125).content)

				arg_531_1.text_.text = var_534_19

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_21 = 59 <= 0 and var_534_17 or var_534_17 * (utf8.len(var_534_19) / 59)

				if (59 <= 0 and var_534_17 or var_534_17 * (utf8.len(var_534_19) / 59)) > 0 and var_534_17 < var_534_21 then
					arg_531_1.talkMaxDuration = var_534_21
					var_534_16 = var_534_16 + 0.3

					if var_534_21 + var_534_16 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_21 + var_534_16
					end
				end

				arg_531_1.text_.text = var_534_19
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_22 = var_534_16 + 0.3
			local var_534_23 = math.max(var_534_17, arg_531_1.talkMaxDuration)

			if var_534_16 + 0.3 <= arg_531_1.time_ and arg_531_1.time_ < var_534_22 + var_534_23 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_22) / var_534_23

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_22 + var_534_23 and arg_531_1.time_ < var_534_22 + var_534_23 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play416232126 = function(arg_537_0, arg_537_1)
		arg_537_1.time_ = 0
		arg_537_1.frameCnt_ = 0
		arg_537_1.state_ = "playing"
		arg_537_1.curTalkId_ = 416232126
		arg_537_1.duration_ = 9.37

		local var_537_0 = {
			zh = 9.366,
			ja = 8.2
		}
		local var_537_1 = manager.audio:GetLocalizationFlag()

		if var_537_0[var_537_1] ~= nil then
			arg_537_1.duration_ = var_537_0[var_537_1]
		end

		SetActive(arg_537_1.tipsGo_, false)

		function arg_537_1.onSingleLineFinish_()
			arg_537_1.onSingleLineUpdate_ = nil
			arg_537_1.onSingleLineFinish_ = nil
			arg_537_1.state_ = "waiting"
		end

		function arg_537_1.playNext_(arg_539_0)
			if arg_539_0 == 1 then
				arg_537_0:Play416232127(arg_537_1)
			end
		end

		function arg_537_1.onSingleLineUpdate_(arg_540_0)
			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 and not isNil(arg_537_1.actors_["1086"]) and arg_537_1.var_.actorSpriteComps1086 == nil then
				arg_537_1.var_.actorSpriteComps1086 = arg_537_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_540_0 = 0.2

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_0 and not isNil(arg_537_1.actors_["1086"]) then
				if arg_537_1.var_.actorSpriteComps1086 then
					for iter_540_0, iter_540_1 in pairs(arg_537_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_540_1 then
							if arg_537_1.isInRecall_ then
								iter_540_1.color = Color.New(Mathf.Lerp(iter_540_1.color.r, arg_537_1.hightColor1.r, (arg_537_1.time_ - 0) / var_540_0), Mathf.Lerp(iter_540_1.color.g, arg_537_1.hightColor1.g, (arg_537_1.time_ - 0) / var_540_0), (Mathf.Lerp(iter_540_1.color.b, arg_537_1.hightColor1.b, (arg_537_1.time_ - 0) / var_540_0)))
							else
								local var_540_1 = Mathf.Lerp(iter_540_1.color.r, 1, (arg_537_1.time_ - 0) / var_540_0)

								iter_540_1.color = Color.New(var_540_1, var_540_1, var_540_1)
							end
						end
					end
				end
			end

			if arg_537_1.time_ >= 0 + var_540_0 and arg_537_1.time_ < 0 + var_540_0 + arg_540_0 and not isNil(arg_537_1.actors_["1086"]) and arg_537_1.var_.actorSpriteComps1086 then
				for iter_540_2, iter_540_3 in pairs(arg_537_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_540_3 then
						iter_540_3.color = arg_537_1.isInRecall_ and (arg_537_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_537_1.var_.actorSpriteComps1086 = nil
			end

			local var_540_2 = arg_537_1.actors_["1086"].transform

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= 0 + arg_540_0 then
				arg_537_1.var_.moveOldPos1086 = var_540_2.localPosition
				var_540_2.localScale = Vector3.New(1, 1, 1)

				arg_537_1:CheckSpriteTmpPos("1086", 3)

				for iter_540_4 = 0, var_540_2.childCount - 1 do
					local var_540_3 = var_540_2:GetChild(iter_540_4)

					if var_540_3.name == "split_1" or not string.find(var_540_3.name, "split") then
						var_540_3.gameObject:SetActive(true)
					else
						var_540_3.gameObject:SetActive(false)
					end
				end
			end

			local var_540_4 = 0.001

			if 0 <= arg_537_1.time_ and arg_537_1.time_ < 0 + var_540_4 then
				var_540_2.localPosition = Vector3.Lerp(arg_537_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_537_1.time_ - 0) / var_540_4)
			end

			if arg_537_1.time_ >= 0 + var_540_4 and arg_537_1.time_ < 0 + var_540_4 + arg_540_0 then
				var_540_2.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_540_5 = 0
			local var_540_6 = 0.65

			if 0 < arg_537_1.time_ and arg_537_1.time_ <= var_540_5 + arg_540_0 then
				arg_537_1.talkMaxDuration = 0
				arg_537_1.dialogCg_.alpha = 1

				arg_537_1.dialog_:SetActive(true)
				SetActive(arg_537_1.leftNameGo_, true)

				arg_537_1.leftNameTxt_.text = arg_537_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_537_1.leftNameTxt_.transform)

				arg_537_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_537_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_537_1:RecordName(arg_537_1.leftNameTxt_.text)
				SetActive(arg_537_1.iconTrs_.gameObject, false)
				arg_537_1.callingController_:SetSelectedState("normal")

				local var_540_7 = arg_537_1:GetWordFromCfg(416232126)
				local var_540_8 = arg_537_1:FormatText(var_540_7.content)

				arg_537_1.text_.text = var_540_8

				LuaForUtil.ClearLinePrefixSymbol(arg_537_1.text_)

				local var_540_10 = 26 <= 0 and var_540_6 or var_540_6 * (utf8.len(var_540_8) / 26)

				if (26 <= 0 and var_540_6 or var_540_6 * (utf8.len(var_540_8) / 26)) > 0 and var_540_6 < var_540_10 then
					arg_537_1.talkMaxDuration = var_540_10

					if var_540_10 + var_540_5 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_10 + var_540_5
					end
				end

				arg_537_1.text_.text = var_540_8
				arg_537_1.typewritter.percent = 0

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232126", "story_v_out_416232.awb") ~= 0 then
					local var_540_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232126", "story_v_out_416232.awb") / 1000

					if var_540_11 + var_540_5 > arg_537_1.duration_ then
						arg_537_1.duration_ = var_540_11 + var_540_5
					end

					if var_540_7.prefab_name ~= "" and arg_537_1.actors_[var_540_7.prefab_name] ~= nil then
						local var_540_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_537_1.actors_[var_540_7.prefab_name].transform, "story_v_out_416232", "416232126", "story_v_out_416232.awb")

						arg_537_1:RecordAudio("416232126", var_540_12)
						arg_537_1:RecordAudio("416232126", var_540_12)
					else
						arg_537_1:AudioAction("play", "voice", "story_v_out_416232", "416232126", "story_v_out_416232.awb")
					end

					arg_537_1:RecordHistoryTalkVoice("story_v_out_416232", "416232126", "story_v_out_416232.awb")
				end

				arg_537_1:RecordContent(arg_537_1.text_.text)
			end

			local var_540_13 = math.max(var_540_6, arg_537_1.talkMaxDuration)

			if var_540_5 <= arg_537_1.time_ and arg_537_1.time_ < var_540_5 + var_540_13 then
				arg_537_1.typewritter.percent = (arg_537_1.time_ - var_540_5) / var_540_13

				arg_537_1.typewritter:SetDirty()
			end

			if arg_537_1.time_ >= var_540_5 + var_540_13 and arg_537_1.time_ < var_540_5 + var_540_13 + arg_540_0 then
				arg_537_1.typewritter.percent = 1

				arg_537_1.typewritter:SetDirty()
				arg_537_1:ShowNextGo(true)
			end
		end

		arg_537_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_537_1:InitPlayNodeList()
	end,
	Play416232127 = function(arg_541_0, arg_541_1)
		arg_541_1.time_ = 0
		arg_541_1.frameCnt_ = 0
		arg_541_1.state_ = "playing"
		arg_541_1.curTalkId_ = 416232127
		arg_541_1.duration_ = 6.6

		local var_541_0 = {
			zh = 5,
			ja = 6.6
		}
		local var_541_1 = manager.audio:GetLocalizationFlag()

		if var_541_0[var_541_1] ~= nil then
			arg_541_1.duration_ = var_541_0[var_541_1]
		end

		SetActive(arg_541_1.tipsGo_, false)

		function arg_541_1.onSingleLineFinish_()
			arg_541_1.onSingleLineUpdate_ = nil
			arg_541_1.onSingleLineFinish_ = nil
			arg_541_1.state_ = "waiting"
		end

		function arg_541_1.playNext_(arg_543_0)
			if arg_543_0 == 1 then
				arg_541_0:Play416232128(arg_541_1)
			end
		end

		function arg_541_1.onSingleLineUpdate_(arg_544_0)
			if 0 < arg_541_1.time_ and arg_541_1.time_ <= 0 + arg_544_0 and not isNil(arg_541_1.actors_["1086"]) and arg_541_1.var_.actorSpriteComps1086 == nil then
				arg_541_1.var_.actorSpriteComps1086 = arg_541_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_544_0 = 0.2

			if 0 <= arg_541_1.time_ and arg_541_1.time_ < 0 + var_544_0 and not isNil(arg_541_1.actors_["1086"]) then
				if arg_541_1.var_.actorSpriteComps1086 then
					for iter_544_0, iter_544_1 in pairs(arg_541_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_544_1 then
							if arg_541_1.isInRecall_ then
								iter_544_1.color = Color.New(Mathf.Lerp(iter_544_1.color.r, arg_541_1.hightColor2.r, (arg_541_1.time_ - 0) / var_544_0), Mathf.Lerp(iter_544_1.color.g, arg_541_1.hightColor2.g, (arg_541_1.time_ - 0) / var_544_0), (Mathf.Lerp(iter_544_1.color.b, arg_541_1.hightColor2.b, (arg_541_1.time_ - 0) / var_544_0)))
							else
								local var_544_1 = Mathf.Lerp(iter_544_1.color.r, 0.5, (arg_541_1.time_ - 0) / var_544_0)

								iter_544_1.color = Color.New(var_544_1, var_544_1, var_544_1)
							end
						end
					end
				end
			end

			if arg_541_1.time_ >= 0 + var_544_0 and arg_541_1.time_ < 0 + var_544_0 + arg_544_0 and not isNil(arg_541_1.actors_["1086"]) and arg_541_1.var_.actorSpriteComps1086 then
				for iter_544_2, iter_544_3 in pairs(arg_541_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_544_3 then
						iter_544_3.color = arg_541_1.isInRecall_ and (arg_541_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_541_1.var_.actorSpriteComps1086 = nil
			end

			local var_544_2 = 0
			local var_544_3 = 0.45

			if 0 < arg_541_1.time_ and arg_541_1.time_ <= var_544_2 + arg_544_0 then
				arg_541_1.talkMaxDuration = 0
				arg_541_1.dialogCg_.alpha = 1

				arg_541_1.dialog_:SetActive(true)
				SetActive(arg_541_1.leftNameGo_, true)

				arg_541_1.leftNameTxt_.text = arg_541_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_541_1.leftNameTxt_.transform)

				arg_541_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_541_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_541_1:RecordName(arg_541_1.leftNameTxt_.text)
				SetActive(arg_541_1.iconTrs_.gameObject, true)
				arg_541_1.iconController_:SetSelectedState("hero")

				arg_541_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10054_split_1")

				arg_541_1.callingController_:SetSelectedState("calling")

				arg_541_1.keyicon_.color = Color.New(1, 1, 1)
				arg_541_1.icon_.color = Color.New(1, 1, 1)

				local var_544_4 = arg_541_1:GetWordFromCfg(416232127)
				local var_544_5 = arg_541_1:FormatText(var_544_4.content)

				arg_541_1.text_.text = var_544_5

				LuaForUtil.ClearLinePrefixSymbol(arg_541_1.text_)

				local var_544_7 = 18 <= 0 and var_544_3 or var_544_3 * (utf8.len(var_544_5) / 18)

				if (18 <= 0 and var_544_3 or var_544_3 * (utf8.len(var_544_5) / 18)) > 0 and var_544_3 < var_544_7 then
					arg_541_1.talkMaxDuration = var_544_7

					if var_544_7 + var_544_2 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_7 + var_544_2
					end
				end

				arg_541_1.text_.text = var_544_5
				arg_541_1.typewritter.percent = 0

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232127", "story_v_out_416232.awb") ~= 0 then
					local var_544_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232127", "story_v_out_416232.awb") / 1000

					if var_544_8 + var_544_2 > arg_541_1.duration_ then
						arg_541_1.duration_ = var_544_8 + var_544_2
					end

					if var_544_4.prefab_name ~= "" and arg_541_1.actors_[var_544_4.prefab_name] ~= nil then
						local var_544_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_541_1.actors_[var_544_4.prefab_name].transform, "story_v_out_416232", "416232127", "story_v_out_416232.awb")

						arg_541_1:RecordAudio("416232127", var_544_9)
						arg_541_1:RecordAudio("416232127", var_544_9)
					else
						arg_541_1:AudioAction("play", "voice", "story_v_out_416232", "416232127", "story_v_out_416232.awb")
					end

					arg_541_1:RecordHistoryTalkVoice("story_v_out_416232", "416232127", "story_v_out_416232.awb")
				end

				arg_541_1:RecordContent(arg_541_1.text_.text)
			end

			local var_544_10 = math.max(var_544_3, arg_541_1.talkMaxDuration)

			if var_544_2 <= arg_541_1.time_ and arg_541_1.time_ < var_544_2 + var_544_10 then
				arg_541_1.typewritter.percent = (arg_541_1.time_ - var_544_2) / var_544_10

				arg_541_1.typewritter:SetDirty()
			end

			if arg_541_1.time_ >= var_544_2 + var_544_10 and arg_541_1.time_ < var_544_2 + var_544_10 + arg_544_0 then
				arg_541_1.typewritter.percent = 1

				arg_541_1.typewritter:SetDirty()
				arg_541_1:ShowNextGo(true)
			end
		end

		arg_541_1.nodeConfigList_ = {}

		arg_541_1:InitPlayNodeList()
	end,
	Play416232128 = function(arg_545_0, arg_545_1)
		arg_545_1.time_ = 0
		arg_545_1.frameCnt_ = 0
		arg_545_1.state_ = "playing"
		arg_545_1.curTalkId_ = 416232128
		arg_545_1.duration_ = 14

		local var_545_0 = {
			zh = 6.966,
			ja = 14
		}
		local var_545_1 = manager.audio:GetLocalizationFlag()

		if var_545_0[var_545_1] ~= nil then
			arg_545_1.duration_ = var_545_0[var_545_1]
		end

		SetActive(arg_545_1.tipsGo_, false)

		function arg_545_1.onSingleLineFinish_()
			arg_545_1.onSingleLineUpdate_ = nil
			arg_545_1.onSingleLineFinish_ = nil
			arg_545_1.state_ = "waiting"
		end

		function arg_545_1.playNext_(arg_547_0)
			if arg_547_0 == 1 then
				arg_545_0:Play416232129(arg_545_1)
			end
		end

		function arg_545_1.onSingleLineUpdate_(arg_548_0)
			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(arg_545_1.actors_["1086"]) and arg_545_1.var_.actorSpriteComps1086 == nil then
				arg_545_1.var_.actorSpriteComps1086 = arg_545_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_548_0 = 0.2

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_0 and not isNil(arg_545_1.actors_["1086"]) then
				if arg_545_1.var_.actorSpriteComps1086 then
					for iter_548_0, iter_548_1 in pairs(arg_545_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_548_1 then
							if arg_545_1.isInRecall_ then
								iter_548_1.color = Color.New(Mathf.Lerp(iter_548_1.color.r, arg_545_1.hightColor1.r, (arg_545_1.time_ - 0) / var_548_0), Mathf.Lerp(iter_548_1.color.g, arg_545_1.hightColor1.g, (arg_545_1.time_ - 0) / var_548_0), (Mathf.Lerp(iter_548_1.color.b, arg_545_1.hightColor1.b, (arg_545_1.time_ - 0) / var_548_0)))
							else
								local var_548_1 = Mathf.Lerp(iter_548_1.color.r, 1, (arg_545_1.time_ - 0) / var_548_0)

								iter_548_1.color = Color.New(var_548_1, var_548_1, var_548_1)
							end
						end
					end
				end
			end

			if arg_545_1.time_ >= 0 + var_548_0 and arg_545_1.time_ < 0 + var_548_0 + arg_548_0 and not isNil(arg_545_1.actors_["1086"]) and arg_545_1.var_.actorSpriteComps1086 then
				for iter_548_2, iter_548_3 in pairs(arg_545_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_548_3 then
						iter_548_3.color = arg_545_1.isInRecall_ and (arg_545_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_545_1.var_.actorSpriteComps1086 = nil
			end

			local var_548_2 = "10054"

			if arg_545_1.actors_["10054"] == nil then
				local var_548_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10054")

				if not isNil(var_548_3) then
					local var_548_4 = Object.Instantiate(var_548_3, arg_545_1.canvasGo_.transform)

					var_548_4.transform:SetSiblingIndex(1)

					var_548_4.name = var_548_2
					var_548_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_545_1.actors_[var_548_2] = var_548_4

					if arg_545_1.isInRecall_ then
						for iter_548_4, iter_548_5 in ipairs((var_548_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_548_5.color = arg_545_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_548_5 = arg_545_1.actors_["10054"]

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 and not isNil(var_548_5) and arg_545_1.var_.actorSpriteComps10054 == nil then
				arg_545_1.var_.actorSpriteComps10054 = var_548_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_548_6 = 0.2

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_6 and not isNil(var_548_5) then
				if arg_545_1.var_.actorSpriteComps10054 then
					for iter_548_6, iter_548_7 in pairs(arg_545_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_548_7 then
							if arg_545_1.isInRecall_ then
								iter_548_7.color = Color.New(Mathf.Lerp(iter_548_7.color.r, arg_545_1.hightColor2.r, (arg_545_1.time_ - 0) / var_548_6), Mathf.Lerp(iter_548_7.color.g, arg_545_1.hightColor2.g, (arg_545_1.time_ - 0) / var_548_6), (Mathf.Lerp(iter_548_7.color.b, arg_545_1.hightColor2.b, (arg_545_1.time_ - 0) / var_548_6)))
							else
								local var_548_7 = Mathf.Lerp(iter_548_7.color.r, 0.5, (arg_545_1.time_ - 0) / var_548_6)

								iter_548_7.color = Color.New(var_548_7, var_548_7, var_548_7)
							end
						end
					end
				end
			end

			if arg_545_1.time_ >= 0 + var_548_6 and arg_545_1.time_ < 0 + var_548_6 + arg_548_0 and not isNil(var_548_5) and arg_545_1.var_.actorSpriteComps10054 then
				for iter_548_8, iter_548_9 in pairs(arg_545_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_548_9 then
						iter_548_9.color = arg_545_1.isInRecall_ and (arg_545_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_545_1.var_.actorSpriteComps10054 = nil
			end

			local var_548_8 = arg_545_1.actors_["1086"].transform

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= 0 + arg_548_0 then
				arg_545_1.var_.moveOldPos1086 = var_548_8.localPosition
				var_548_8.localScale = Vector3.New(1, 1, 1)

				arg_545_1:CheckSpriteTmpPos("1086", 3)

				for iter_548_10 = 0, var_548_8.childCount - 1 do
					local var_548_9 = var_548_8:GetChild(iter_548_10)

					if var_548_9.name == "split_5" or not string.find(var_548_9.name, "split") then
						var_548_9.gameObject:SetActive(true)
					else
						var_548_9.gameObject:SetActive(false)
					end
				end
			end

			local var_548_10 = 0.001

			if 0 <= arg_545_1.time_ and arg_545_1.time_ < 0 + var_548_10 then
				var_548_8.localPosition = Vector3.Lerp(arg_545_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_545_1.time_ - 0) / var_548_10)
			end

			if arg_545_1.time_ >= 0 + var_548_10 and arg_545_1.time_ < 0 + var_548_10 + arg_548_0 then
				var_548_8.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_548_11 = 0
			local var_548_12 = 0.65

			if 0 < arg_545_1.time_ and arg_545_1.time_ <= var_548_11 + arg_548_0 then
				arg_545_1.talkMaxDuration = 0
				arg_545_1.dialogCg_.alpha = 1

				arg_545_1.dialog_:SetActive(true)
				SetActive(arg_545_1.leftNameGo_, true)

				arg_545_1.leftNameTxt_.text = arg_545_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_545_1.leftNameTxt_.transform)

				arg_545_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_545_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_545_1:RecordName(arg_545_1.leftNameTxt_.text)
				SetActive(arg_545_1.iconTrs_.gameObject, false)
				arg_545_1.callingController_:SetSelectedState("normal")

				local var_548_13 = arg_545_1:GetWordFromCfg(416232128)
				local var_548_14 = arg_545_1:FormatText(var_548_13.content)

				arg_545_1.text_.text = var_548_14

				LuaForUtil.ClearLinePrefixSymbol(arg_545_1.text_)

				local var_548_16 = 26 <= 0 and var_548_12 or var_548_12 * (utf8.len(var_548_14) / 26)

				if (26 <= 0 and var_548_12 or var_548_12 * (utf8.len(var_548_14) / 26)) > 0 and var_548_12 < var_548_16 then
					arg_545_1.talkMaxDuration = var_548_16

					if var_548_16 + var_548_11 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_16 + var_548_11
					end
				end

				arg_545_1.text_.text = var_548_14
				arg_545_1.typewritter.percent = 0

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232128", "story_v_out_416232.awb") ~= 0 then
					local var_548_17 = manager.audio:GetVoiceLength("story_v_out_416232", "416232128", "story_v_out_416232.awb") / 1000

					if var_548_17 + var_548_11 > arg_545_1.duration_ then
						arg_545_1.duration_ = var_548_17 + var_548_11
					end

					if var_548_13.prefab_name ~= "" and arg_545_1.actors_[var_548_13.prefab_name] ~= nil then
						local var_548_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_545_1.actors_[var_548_13.prefab_name].transform, "story_v_out_416232", "416232128", "story_v_out_416232.awb")

						arg_545_1:RecordAudio("416232128", var_548_18)
						arg_545_1:RecordAudio("416232128", var_548_18)
					else
						arg_545_1:AudioAction("play", "voice", "story_v_out_416232", "416232128", "story_v_out_416232.awb")
					end

					arg_545_1:RecordHistoryTalkVoice("story_v_out_416232", "416232128", "story_v_out_416232.awb")
				end

				arg_545_1:RecordContent(arg_545_1.text_.text)
			end

			local var_548_19 = math.max(var_548_12, arg_545_1.talkMaxDuration)

			if var_548_11 <= arg_545_1.time_ and arg_545_1.time_ < var_548_11 + var_548_19 then
				arg_545_1.typewritter.percent = (arg_545_1.time_ - var_548_11) / var_548_19

				arg_545_1.typewritter:SetDirty()
			end

			if arg_545_1.time_ >= var_548_11 + var_548_19 and arg_545_1.time_ < var_548_11 + var_548_19 + arg_548_0 then
				arg_545_1.typewritter.percent = 1

				arg_545_1.typewritter:SetDirty()
				arg_545_1:ShowNextGo(true)
			end
		end

		arg_545_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_545_1:InitPlayNodeList()
	end,
	Play416232129 = function(arg_549_0, arg_549_1)
		arg_549_1.time_ = 0
		arg_549_1.frameCnt_ = 0
		arg_549_1.state_ = "playing"
		arg_549_1.curTalkId_ = 416232129
		arg_549_1.duration_ = 3.77

		local var_549_0 = {
			zh = 3.766,
			ja = 2.7
		}
		local var_549_1 = manager.audio:GetLocalizationFlag()

		if var_549_0[var_549_1] ~= nil then
			arg_549_1.duration_ = var_549_0[var_549_1]
		end

		SetActive(arg_549_1.tipsGo_, false)

		function arg_549_1.onSingleLineFinish_()
			arg_549_1.onSingleLineUpdate_ = nil
			arg_549_1.onSingleLineFinish_ = nil
			arg_549_1.state_ = "waiting"
		end

		function arg_549_1.playNext_(arg_551_0)
			if arg_551_0 == 1 then
				arg_549_0:Play416232130(arg_549_1)
			end
		end

		function arg_549_1.onSingleLineUpdate_(arg_552_0)
			local var_552_0 = 0.4

			if 0 < arg_549_1.time_ and arg_549_1.time_ <= 0 + arg_552_0 then
				arg_549_1.talkMaxDuration = 0
				arg_549_1.dialogCg_.alpha = 1

				arg_549_1.dialog_:SetActive(true)
				SetActive(arg_549_1.leftNameGo_, true)

				arg_549_1.leftNameTxt_.text = arg_549_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_549_1.leftNameTxt_.transform)

				arg_549_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_549_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_549_1:RecordName(arg_549_1.leftNameTxt_.text)
				SetActive(arg_549_1.iconTrs_.gameObject, false)
				arg_549_1.callingController_:SetSelectedState("normal")

				local var_552_1 = arg_549_1:GetWordFromCfg(416232129)
				local var_552_2 = arg_549_1:FormatText(var_552_1.content)

				arg_549_1.text_.text = var_552_2

				LuaForUtil.ClearLinePrefixSymbol(arg_549_1.text_)

				local var_552_4 = 16 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_2) / 16)

				if (16 <= 0 and var_552_0 or var_552_0 * (utf8.len(var_552_2) / 16)) > 0 and var_552_0 < var_552_4 then
					arg_549_1.talkMaxDuration = var_552_4

					if var_552_4 + 0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_4 + 0
					end
				end

				arg_549_1.text_.text = var_552_2
				arg_549_1.typewritter.percent = 0

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232129", "story_v_out_416232.awb") ~= 0 then
					local var_552_5 = manager.audio:GetVoiceLength("story_v_out_416232", "416232129", "story_v_out_416232.awb") / 1000

					if var_552_5 + 0 > arg_549_1.duration_ then
						arg_549_1.duration_ = var_552_5 + 0
					end

					if var_552_1.prefab_name ~= "" and arg_549_1.actors_[var_552_1.prefab_name] ~= nil then
						local var_552_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_549_1.actors_[var_552_1.prefab_name].transform, "story_v_out_416232", "416232129", "story_v_out_416232.awb")

						arg_549_1:RecordAudio("416232129", var_552_6)
						arg_549_1:RecordAudio("416232129", var_552_6)
					else
						arg_549_1:AudioAction("play", "voice", "story_v_out_416232", "416232129", "story_v_out_416232.awb")
					end

					arg_549_1:RecordHistoryTalkVoice("story_v_out_416232", "416232129", "story_v_out_416232.awb")
				end

				arg_549_1:RecordContent(arg_549_1.text_.text)
			end

			local var_552_7 = math.max(var_552_0, arg_549_1.talkMaxDuration)

			if 0 <= arg_549_1.time_ and arg_549_1.time_ < 0 + var_552_7 then
				arg_549_1.typewritter.percent = (arg_549_1.time_ - 0) / var_552_7

				arg_549_1.typewritter:SetDirty()
			end

			if arg_549_1.time_ >= 0 + var_552_7 and arg_549_1.time_ < 0 + var_552_7 + arg_552_0 then
				arg_549_1.typewritter.percent = 1

				arg_549_1.typewritter:SetDirty()
				arg_549_1:ShowNextGo(true)
			end
		end

		arg_549_1.nodeConfigList_ = {}

		arg_549_1:InitPlayNodeList()
	end,
	Play416232130 = function(arg_553_0, arg_553_1)
		arg_553_1.time_ = 0
		arg_553_1.frameCnt_ = 0
		arg_553_1.state_ = "playing"
		arg_553_1.curTalkId_ = 416232130
		arg_553_1.duration_ = 2.77

		local var_553_0 = {
			zh = 2.766,
			ja = 1.9
		}
		local var_553_1 = manager.audio:GetLocalizationFlag()

		if var_553_0[var_553_1] ~= nil then
			arg_553_1.duration_ = var_553_0[var_553_1]
		end

		SetActive(arg_553_1.tipsGo_, false)

		function arg_553_1.onSingleLineFinish_()
			arg_553_1.onSingleLineUpdate_ = nil
			arg_553_1.onSingleLineFinish_ = nil
			arg_553_1.state_ = "waiting"
		end

		function arg_553_1.playNext_(arg_555_0)
			if arg_555_0 == 1 then
				arg_553_0:Play416232131(arg_553_1)
			end
		end

		function arg_553_1.onSingleLineUpdate_(arg_556_0)
			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(arg_553_1.actors_["10122"]) and arg_553_1.var_.actorSpriteComps10122 == nil then
				arg_553_1.var_.actorSpriteComps10122 = arg_553_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_556_0 = 0.2

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_0 and not isNil(arg_553_1.actors_["10122"]) then
				if arg_553_1.var_.actorSpriteComps10122 then
					for iter_556_0, iter_556_1 in pairs(arg_553_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_556_1 then
							if arg_553_1.isInRecall_ then
								iter_556_1.color = Color.New(Mathf.Lerp(iter_556_1.color.r, arg_553_1.hightColor1.r, (arg_553_1.time_ - 0) / var_556_0), Mathf.Lerp(iter_556_1.color.g, arg_553_1.hightColor1.g, (arg_553_1.time_ - 0) / var_556_0), (Mathf.Lerp(iter_556_1.color.b, arg_553_1.hightColor1.b, (arg_553_1.time_ - 0) / var_556_0)))
							else
								local var_556_1 = Mathf.Lerp(iter_556_1.color.r, 1, (arg_553_1.time_ - 0) / var_556_0)

								iter_556_1.color = Color.New(var_556_1, var_556_1, var_556_1)
							end
						end
					end
				end
			end

			if arg_553_1.time_ >= 0 + var_556_0 and arg_553_1.time_ < 0 + var_556_0 + arg_556_0 and not isNil(arg_553_1.actors_["10122"]) and arg_553_1.var_.actorSpriteComps10122 then
				for iter_556_2, iter_556_3 in pairs(arg_553_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_556_3 then
						iter_556_3.color = arg_553_1.isInRecall_ and (arg_553_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_553_1.var_.actorSpriteComps10122 = nil
			end

			local var_556_2 = arg_553_1.actors_["1086"]

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 and not isNil(var_556_2) and arg_553_1.var_.actorSpriteComps1086 == nil then
				arg_553_1.var_.actorSpriteComps1086 = var_556_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_556_3 = 0.2

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_3 and not isNil(var_556_2) then
				if arg_553_1.var_.actorSpriteComps1086 then
					for iter_556_4, iter_556_5 in pairs(arg_553_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_556_5 then
							if arg_553_1.isInRecall_ then
								iter_556_5.color = Color.New(Mathf.Lerp(iter_556_5.color.r, arg_553_1.hightColor2.r, (arg_553_1.time_ - 0) / var_556_3), Mathf.Lerp(iter_556_5.color.g, arg_553_1.hightColor2.g, (arg_553_1.time_ - 0) / var_556_3), (Mathf.Lerp(iter_556_5.color.b, arg_553_1.hightColor2.b, (arg_553_1.time_ - 0) / var_556_3)))
							else
								local var_556_4 = Mathf.Lerp(iter_556_5.color.r, 0.5, (arg_553_1.time_ - 0) / var_556_3)

								iter_556_5.color = Color.New(var_556_4, var_556_4, var_556_4)
							end
						end
					end
				end
			end

			if arg_553_1.time_ >= 0 + var_556_3 and arg_553_1.time_ < 0 + var_556_3 + arg_556_0 and not isNil(var_556_2) and arg_553_1.var_.actorSpriteComps1086 then
				for iter_556_6, iter_556_7 in pairs(arg_553_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_556_7 then
						iter_556_7.color = arg_553_1.isInRecall_ and (arg_553_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_553_1.var_.actorSpriteComps1086 = nil
			end

			local var_556_5 = arg_553_1.actors_["1086"].transform

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.var_.moveOldPos1086 = var_556_5.localPosition
				var_556_5.localScale = Vector3.New(1, 1, 1)

				arg_553_1:CheckSpriteTmpPos("1086", 7)

				for iter_556_8 = 0, var_556_5.childCount - 1 do
					local var_556_6 = var_556_5:GetChild(iter_556_8)

					if var_556_6.name == "" or not string.find(var_556_6.name, "split") then
						var_556_6.gameObject:SetActive(true)
					else
						var_556_6.gameObject:SetActive(false)
					end
				end
			end

			local var_556_7 = 0.001

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_7 then
				var_556_5.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_553_1.time_ - 0) / var_556_7)
			end

			if arg_553_1.time_ >= 0 + var_556_7 and arg_553_1.time_ < 0 + var_556_7 + arg_556_0 then
				var_556_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_556_8 = arg_553_1.actors_["10122"].transform

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= 0 + arg_556_0 then
				arg_553_1.var_.moveOldPos10122 = var_556_8.localPosition
				var_556_8.localScale = Vector3.New(1, 1, 1)

				arg_553_1:CheckSpriteTmpPos("10122", 3)

				for iter_556_9 = 0, var_556_8.childCount - 1 do
					local var_556_9 = var_556_8:GetChild(iter_556_9)

					if var_556_9.name == "" or not string.find(var_556_9.name, "split") then
						var_556_9.gameObject:SetActive(true)
					else
						var_556_9.gameObject:SetActive(false)
					end
				end
			end

			local var_556_10 = 0.001

			if 0 <= arg_553_1.time_ and arg_553_1.time_ < 0 + var_556_10 then
				var_556_8.localPosition = Vector3.Lerp(arg_553_1.var_.moveOldPos10122, Vector3.New(0, -380, -100), (arg_553_1.time_ - 0) / var_556_10)
			end

			if arg_553_1.time_ >= 0 + var_556_10 and arg_553_1.time_ < 0 + var_556_10 + arg_556_0 then
				var_556_8.localPosition = Vector3.New(0, -380, -100)
			end

			local var_556_11 = 0
			local var_556_12 = 0.25

			if 0 < arg_553_1.time_ and arg_553_1.time_ <= var_556_11 + arg_556_0 then
				arg_553_1.talkMaxDuration = 0
				arg_553_1.dialogCg_.alpha = 1

				arg_553_1.dialog_:SetActive(true)
				SetActive(arg_553_1.leftNameGo_, true)

				arg_553_1.leftNameTxt_.text = arg_553_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_553_1.leftNameTxt_.transform)

				arg_553_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_553_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_553_1:RecordName(arg_553_1.leftNameTxt_.text)
				SetActive(arg_553_1.iconTrs_.gameObject, false)
				arg_553_1.callingController_:SetSelectedState("normal")

				local var_556_13 = arg_553_1:GetWordFromCfg(416232130)
				local var_556_14 = arg_553_1:FormatText(var_556_13.content)

				arg_553_1.text_.text = var_556_14

				LuaForUtil.ClearLinePrefixSymbol(arg_553_1.text_)

				local var_556_16 = 10 <= 0 and var_556_12 or var_556_12 * (utf8.len(var_556_14) / 10)

				if (10 <= 0 and var_556_12 or var_556_12 * (utf8.len(var_556_14) / 10)) > 0 and var_556_12 < var_556_16 then
					arg_553_1.talkMaxDuration = var_556_16

					if var_556_16 + var_556_11 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_16 + var_556_11
					end
				end

				arg_553_1.text_.text = var_556_14
				arg_553_1.typewritter.percent = 0

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232130", "story_v_out_416232.awb") ~= 0 then
					local var_556_17 = manager.audio:GetVoiceLength("story_v_out_416232", "416232130", "story_v_out_416232.awb") / 1000

					if var_556_17 + var_556_11 > arg_553_1.duration_ then
						arg_553_1.duration_ = var_556_17 + var_556_11
					end

					if var_556_13.prefab_name ~= "" and arg_553_1.actors_[var_556_13.prefab_name] ~= nil then
						local var_556_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_553_1.actors_[var_556_13.prefab_name].transform, "story_v_out_416232", "416232130", "story_v_out_416232.awb")

						arg_553_1:RecordAudio("416232130", var_556_18)
						arg_553_1:RecordAudio("416232130", var_556_18)
					else
						arg_553_1:AudioAction("play", "voice", "story_v_out_416232", "416232130", "story_v_out_416232.awb")
					end

					arg_553_1:RecordHistoryTalkVoice("story_v_out_416232", "416232130", "story_v_out_416232.awb")
				end

				arg_553_1:RecordContent(arg_553_1.text_.text)
			end

			local var_556_19 = math.max(var_556_12, arg_553_1.talkMaxDuration)

			if var_556_11 <= arg_553_1.time_ and arg_553_1.time_ < var_556_11 + var_556_19 then
				arg_553_1.typewritter.percent = (arg_553_1.time_ - var_556_11) / var_556_19

				arg_553_1.typewritter:SetDirty()
			end

			if arg_553_1.time_ >= var_556_11 + var_556_19 and arg_553_1.time_ < var_556_11 + var_556_19 + arg_556_0 then
				arg_553_1.typewritter.percent = 1

				arg_553_1.typewritter:SetDirty()
				arg_553_1:ShowNextGo(true)
			end
		end

		arg_553_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_553_1:InitPlayNodeList()
	end,
	Play416232131 = function(arg_557_0, arg_557_1)
		arg_557_1.time_ = 0
		arg_557_1.frameCnt_ = 0
		arg_557_1.state_ = "playing"
		arg_557_1.curTalkId_ = 416232131
		arg_557_1.duration_ = 5.07

		local var_557_0 = {
			zh = 5,
			ja = 5.066
		}
		local var_557_1 = manager.audio:GetLocalizationFlag()

		if var_557_0[var_557_1] ~= nil then
			arg_557_1.duration_ = var_557_0[var_557_1]
		end

		SetActive(arg_557_1.tipsGo_, false)

		function arg_557_1.onSingleLineFinish_()
			arg_557_1.onSingleLineUpdate_ = nil
			arg_557_1.onSingleLineFinish_ = nil
			arg_557_1.state_ = "waiting"
		end

		function arg_557_1.playNext_(arg_559_0)
			if arg_559_0 == 1 then
				arg_557_0:Play416232132(arg_557_1)
			end
		end

		function arg_557_1.onSingleLineUpdate_(arg_560_0)
			if 0 < arg_557_1.time_ and arg_557_1.time_ <= 0 + arg_560_0 and not isNil(arg_557_1.actors_["10122"]) and arg_557_1.var_.actorSpriteComps10122 == nil then
				arg_557_1.var_.actorSpriteComps10122 = arg_557_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_560_0 = 0.2

			if 0 <= arg_557_1.time_ and arg_557_1.time_ < 0 + var_560_0 and not isNil(arg_557_1.actors_["10122"]) then
				if arg_557_1.var_.actorSpriteComps10122 then
					for iter_560_0, iter_560_1 in pairs(arg_557_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_560_1 then
							if arg_557_1.isInRecall_ then
								iter_560_1.color = Color.New(Mathf.Lerp(iter_560_1.color.r, arg_557_1.hightColor2.r, (arg_557_1.time_ - 0) / var_560_0), Mathf.Lerp(iter_560_1.color.g, arg_557_1.hightColor2.g, (arg_557_1.time_ - 0) / var_560_0), (Mathf.Lerp(iter_560_1.color.b, arg_557_1.hightColor2.b, (arg_557_1.time_ - 0) / var_560_0)))
							else
								local var_560_1 = Mathf.Lerp(iter_560_1.color.r, 0.5, (arg_557_1.time_ - 0) / var_560_0)

								iter_560_1.color = Color.New(var_560_1, var_560_1, var_560_1)
							end
						end
					end
				end
			end

			if arg_557_1.time_ >= 0 + var_560_0 and arg_557_1.time_ < 0 + var_560_0 + arg_560_0 and not isNil(arg_557_1.actors_["10122"]) and arg_557_1.var_.actorSpriteComps10122 then
				for iter_560_2, iter_560_3 in pairs(arg_557_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_560_3 then
						iter_560_3.color = arg_557_1.isInRecall_ and (arg_557_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_557_1.var_.actorSpriteComps10122 = nil
			end

			local var_560_2 = 0
			local var_560_3 = 0.35

			if 0 < arg_557_1.time_ and arg_557_1.time_ <= var_560_2 + arg_560_0 then
				arg_557_1.talkMaxDuration = 0
				arg_557_1.dialogCg_.alpha = 1

				arg_557_1.dialog_:SetActive(true)
				SetActive(arg_557_1.leftNameGo_, true)

				arg_557_1.leftNameTxt_.text = arg_557_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_557_1.leftNameTxt_.transform)

				arg_557_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_557_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_557_1:RecordName(arg_557_1.leftNameTxt_.text)
				SetActive(arg_557_1.iconTrs_.gameObject, true)
				arg_557_1.iconController_:SetSelectedState("hero")

				arg_557_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1086_split_5")

				arg_557_1.callingController_:SetSelectedState("normal")

				arg_557_1.keyicon_.color = Color.New(1, 1, 1)
				arg_557_1.icon_.color = Color.New(1, 1, 1)

				local var_560_4 = arg_557_1:GetWordFromCfg(416232131)
				local var_560_5 = arg_557_1:FormatText(var_560_4.content)

				arg_557_1.text_.text = var_560_5

				LuaForUtil.ClearLinePrefixSymbol(arg_557_1.text_)

				local var_560_7 = 14 <= 0 and var_560_3 or var_560_3 * (utf8.len(var_560_5) / 14)

				if (14 <= 0 and var_560_3 or var_560_3 * (utf8.len(var_560_5) / 14)) > 0 and var_560_3 < var_560_7 then
					arg_557_1.talkMaxDuration = var_560_7

					if var_560_7 + var_560_2 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_7 + var_560_2
					end
				end

				arg_557_1.text_.text = var_560_5
				arg_557_1.typewritter.percent = 0

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232131", "story_v_out_416232.awb") ~= 0 then
					local var_560_8 = manager.audio:GetVoiceLength("story_v_out_416232", "416232131", "story_v_out_416232.awb") / 1000

					if var_560_8 + var_560_2 > arg_557_1.duration_ then
						arg_557_1.duration_ = var_560_8 + var_560_2
					end

					if var_560_4.prefab_name ~= "" and arg_557_1.actors_[var_560_4.prefab_name] ~= nil then
						local var_560_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_557_1.actors_[var_560_4.prefab_name].transform, "story_v_out_416232", "416232131", "story_v_out_416232.awb")

						arg_557_1:RecordAudio("416232131", var_560_9)
						arg_557_1:RecordAudio("416232131", var_560_9)
					else
						arg_557_1:AudioAction("play", "voice", "story_v_out_416232", "416232131", "story_v_out_416232.awb")
					end

					arg_557_1:RecordHistoryTalkVoice("story_v_out_416232", "416232131", "story_v_out_416232.awb")
				end

				arg_557_1:RecordContent(arg_557_1.text_.text)
			end

			local var_560_10 = math.max(var_560_3, arg_557_1.talkMaxDuration)

			if var_560_2 <= arg_557_1.time_ and arg_557_1.time_ < var_560_2 + var_560_10 then
				arg_557_1.typewritter.percent = (arg_557_1.time_ - var_560_2) / var_560_10

				arg_557_1.typewritter:SetDirty()
			end

			if arg_557_1.time_ >= var_560_2 + var_560_10 and arg_557_1.time_ < var_560_2 + var_560_10 + arg_560_0 then
				arg_557_1.typewritter.percent = 1

				arg_557_1.typewritter:SetDirty()
				arg_557_1:ShowNextGo(true)
			end
		end

		arg_557_1.nodeConfigList_ = {}

		arg_557_1:InitPlayNodeList()
	end,
	Play416232132 = function(arg_561_0, arg_561_1)
		arg_561_1.time_ = 0
		arg_561_1.frameCnt_ = 0
		arg_561_1.state_ = "playing"
		arg_561_1.curTalkId_ = 416232132
		arg_561_1.duration_ = 4.6

		local var_561_0 = {
			zh = 2.233,
			ja = 4.6
		}
		local var_561_1 = manager.audio:GetLocalizationFlag()

		if var_561_0[var_561_1] ~= nil then
			arg_561_1.duration_ = var_561_0[var_561_1]
		end

		SetActive(arg_561_1.tipsGo_, false)

		function arg_561_1.onSingleLineFinish_()
			arg_561_1.onSingleLineUpdate_ = nil
			arg_561_1.onSingleLineFinish_ = nil
			arg_561_1.state_ = "waiting"
			arg_561_1.auto_ = false
		end

		function arg_561_1.playNext_(arg_563_0)
			arg_561_1.onStoryFinished_()
		end

		function arg_561_1.onSingleLineUpdate_(arg_564_0)
			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 and not isNil(arg_561_1.actors_["10122"]) and arg_561_1.var_.actorSpriteComps10122 == nil then
				arg_561_1.var_.actorSpriteComps10122 = arg_561_1.actors_["10122"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_564_0 = 0.2

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_0 and not isNil(arg_561_1.actors_["10122"]) then
				if arg_561_1.var_.actorSpriteComps10122 then
					for iter_564_0, iter_564_1 in pairs(arg_561_1.var_.actorSpriteComps10122:ToTable()) do
						if iter_564_1 then
							if arg_561_1.isInRecall_ then
								iter_564_1.color = Color.New(Mathf.Lerp(iter_564_1.color.r, arg_561_1.hightColor1.r, (arg_561_1.time_ - 0) / var_564_0), Mathf.Lerp(iter_564_1.color.g, arg_561_1.hightColor1.g, (arg_561_1.time_ - 0) / var_564_0), (Mathf.Lerp(iter_564_1.color.b, arg_561_1.hightColor1.b, (arg_561_1.time_ - 0) / var_564_0)))
							else
								local var_564_1 = Mathf.Lerp(iter_564_1.color.r, 1, (arg_561_1.time_ - 0) / var_564_0)

								iter_564_1.color = Color.New(var_564_1, var_564_1, var_564_1)
							end
						end
					end
				end
			end

			if arg_561_1.time_ >= 0 + var_564_0 and arg_561_1.time_ < 0 + var_564_0 + arg_564_0 and not isNil(arg_561_1.actors_["10122"]) and arg_561_1.var_.actorSpriteComps10122 then
				for iter_564_2, iter_564_3 in pairs(arg_561_1.var_.actorSpriteComps10122:ToTable()) do
					if iter_564_3 then
						iter_564_3.color = arg_561_1.isInRecall_ and (arg_561_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_561_1.var_.actorSpriteComps10122 = nil
			end

			local var_564_2 = arg_561_1.actors_["10122"].transform

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= 0 + arg_564_0 then
				arg_561_1.var_.moveOldPos10122 = var_564_2.localPosition
				var_564_2.localScale = Vector3.New(1, 1, 1)

				arg_561_1:CheckSpriteTmpPos("10122", 3)

				for iter_564_4 = 0, var_564_2.childCount - 1 do
					local var_564_3 = var_564_2:GetChild(iter_564_4)

					if var_564_3.name == "split_5" or not string.find(var_564_3.name, "split") then
						var_564_3.gameObject:SetActive(true)
					else
						var_564_3.gameObject:SetActive(false)
					end
				end
			end

			local var_564_4 = 0.001

			if 0 <= arg_561_1.time_ and arg_561_1.time_ < 0 + var_564_4 then
				var_564_2.localPosition = Vector3.Lerp(arg_561_1.var_.moveOldPos10122, Vector3.New(0, -380, -100), (arg_561_1.time_ - 0) / var_564_4)
			end

			if arg_561_1.time_ >= 0 + var_564_4 and arg_561_1.time_ < 0 + var_564_4 + arg_564_0 then
				var_564_2.localPosition = Vector3.New(0, -380, -100)
			end

			local var_564_5 = 0
			local var_564_6 = 0.2

			if 0 < arg_561_1.time_ and arg_561_1.time_ <= var_564_5 + arg_564_0 then
				arg_561_1.talkMaxDuration = 0
				arg_561_1.dialogCg_.alpha = 1

				arg_561_1.dialog_:SetActive(true)
				SetActive(arg_561_1.leftNameGo_, true)

				arg_561_1.leftNameTxt_.text = arg_561_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_561_1.leftNameTxt_.transform)

				arg_561_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_561_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_561_1:RecordName(arg_561_1.leftNameTxt_.text)
				SetActive(arg_561_1.iconTrs_.gameObject, false)
				arg_561_1.callingController_:SetSelectedState("normal")

				local var_564_7 = arg_561_1:GetWordFromCfg(416232132)
				local var_564_8 = arg_561_1:FormatText(var_564_7.content)

				arg_561_1.text_.text = var_564_8

				LuaForUtil.ClearLinePrefixSymbol(arg_561_1.text_)

				local var_564_10 = 8 <= 0 and var_564_6 or var_564_6 * (utf8.len(var_564_8) / 8)

				if (8 <= 0 and var_564_6 or var_564_6 * (utf8.len(var_564_8) / 8)) > 0 and var_564_6 < var_564_10 then
					arg_561_1.talkMaxDuration = var_564_10

					if var_564_10 + var_564_5 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_10 + var_564_5
					end
				end

				arg_561_1.text_.text = var_564_8
				arg_561_1.typewritter.percent = 0

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416232", "416232132", "story_v_out_416232.awb") ~= 0 then
					local var_564_11 = manager.audio:GetVoiceLength("story_v_out_416232", "416232132", "story_v_out_416232.awb") / 1000

					if var_564_11 + var_564_5 > arg_561_1.duration_ then
						arg_561_1.duration_ = var_564_11 + var_564_5
					end

					if var_564_7.prefab_name ~= "" and arg_561_1.actors_[var_564_7.prefab_name] ~= nil then
						local var_564_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_561_1.actors_[var_564_7.prefab_name].transform, "story_v_out_416232", "416232132", "story_v_out_416232.awb")

						arg_561_1:RecordAudio("416232132", var_564_12)
						arg_561_1:RecordAudio("416232132", var_564_12)
					else
						arg_561_1:AudioAction("play", "voice", "story_v_out_416232", "416232132", "story_v_out_416232.awb")
					end

					arg_561_1:RecordHistoryTalkVoice("story_v_out_416232", "416232132", "story_v_out_416232.awb")
				end

				arg_561_1:RecordContent(arg_561_1.text_.text)
			end

			local var_564_13 = math.max(var_564_6, arg_561_1.talkMaxDuration)

			if var_564_5 <= arg_561_1.time_ and arg_561_1.time_ < var_564_5 + var_564_13 then
				arg_561_1.typewritter.percent = (arg_561_1.time_ - var_564_5) / var_564_13

				arg_561_1.typewritter:SetDirty()
			end

			if arg_561_1.time_ >= var_564_5 + var_564_13 and arg_561_1.time_ < var_564_5 + var_564_13 + arg_564_0 then
				arg_561_1.typewritter.percent = 1

				arg_561_1.typewritter:SetDirty()
				arg_561_1:ShowNextGo(true)
			end
		end

		arg_561_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10122",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_561_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F09f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/SS1610"
	},
	voices = {
		"story_v_out_416232.awb"
	}
}
