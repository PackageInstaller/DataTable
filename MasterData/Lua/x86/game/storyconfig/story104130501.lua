return {
	Play413051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413051001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play413051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F08f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08f")
				var_4_0.name = "F08f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F08f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F08f

				arg_1_1.bgs_.F08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F08f" then
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

			if 0.4 < arg_1_1.time_ and arg_1_1.time_ <= 0.4 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

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
			local var_4_16 = 1.375

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

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(413051001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 55 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 55)

				if (55 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 55)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play413051002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413051002
		arg_9_1.duration_ = 5.67

		local var_9_0 = {
			zh = 3.5,
			ja = 5.666
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
				arg_9_0:Play413051003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10092"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "10092"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["10092"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["10092"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10092 = var_12_2.localPosition
				var_12_2.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10092", 3)

				for iter_12_2 = 0, var_12_2.childCount - 1 do
					local var_12_3 = var_12_2:GetChild(iter_12_2)

					if var_12_3.name == "split_8" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_9_1.time_ - 0) / var_12_4)
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_12_5 = arg_9_1.actors_["10092"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps10092 == nil then
				arg_9_1.var_.actorSpriteComps10092 = var_12_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_6 = 2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.actorSpriteComps10092 then
					for iter_12_3, iter_12_4 in pairs(arg_9_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.actorSpriteComps10092 then
				for iter_12_5, iter_12_6 in pairs(arg_9_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_12_6 then
						iter_12_6.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_9_1.var_.actorSpriteComps10092 = nil
			end

			local var_12_8 = 0
			local var_12_9 = 0.4

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
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

				local var_12_10 = arg_9_1:GetWordFromCfg(413051002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 16 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 16)

				if (16 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 16)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051002", "story_v_out_413051.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051002", "story_v_out_413051.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_413051", "413051002", "story_v_out_413051.awb")

						arg_9_1:RecordAudio("413051002", var_12_15)
						arg_9_1:RecordAudio("413051002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413051", "413051002", "story_v_out_413051.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413051", "413051002", "story_v_out_413051.awb")
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
	Play413051003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413051003
		arg_13_1.duration_ = 5.4

		local var_13_0 = {
			zh = 2.7,
			ja = 5.4
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
				arg_13_0:Play413051004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10092 = arg_13_1.actors_["10092"].transform.localPosition
				arg_13_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10092", 0)

				for iter_16_0 = 0, arg_13_1.actors_["10092"].transform.childCount - 1 do
					local var_16_0 = arg_13_1.actors_["10092"].transform:GetChild(iter_16_0)

					if var_16_0.name == "" or not string.find(var_16_0.name, "split") then
						var_16_0.gameObject:SetActive(true)
					else
						var_16_0.gameObject:SetActive(false)
					end
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_13_1.time_ - 0) / var_16_1)
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_16_2 = "10097"

			if arg_13_1.actors_["10097"] == nil then
				local var_16_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10097")

				if not isNil(var_16_3) then
					local var_16_4 = Object.Instantiate(var_16_3, arg_13_1.canvasGo_.transform)

					var_16_4.transform:SetSiblingIndex(1)

					var_16_4.name = var_16_2
					var_16_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_[var_16_2] = var_16_4

					if arg_13_1.isInRecall_ then
						for iter_16_1, iter_16_2 in ipairs((var_16_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_16_2.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_5 = arg_13_1.actors_["10097"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10097 = var_16_5.localPosition
				var_16_5.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10097", 3)

				for iter_16_3 = 0, var_16_5.childCount - 1 do
					local var_16_6 = var_16_5:GetChild(iter_16_3)

					if var_16_6.name == "" or not string.find(var_16_6.name, "split") then
						var_16_6.gameObject:SetActive(true)
					else
						var_16_6.gameObject:SetActive(false)
					end
				end
			end

			local var_16_7 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_13_1.time_ - 0) / var_16_7)
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -350, -180)
			end

			local var_16_8 = arg_13_1.actors_["10092"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.actorSpriteComps10092 == nil then
				arg_13_1.var_.actorSpriteComps10092 = var_16_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_9 = 2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 and not isNil(var_16_8) then
				if arg_13_1.var_.actorSpriteComps10092 then
					for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_16_5 then
							if arg_13_1.isInRecall_ then
								iter_16_5.color = Color.New(Mathf.Lerp(iter_16_5.color.r, arg_13_1.hightColor2.r, (arg_13_1.time_ - 0) / var_16_9), Mathf.Lerp(iter_16_5.color.g, arg_13_1.hightColor2.g, (arg_13_1.time_ - 0) / var_16_9), (Mathf.Lerp(iter_16_5.color.b, arg_13_1.hightColor2.b, (arg_13_1.time_ - 0) / var_16_9)))
							else
								local var_16_10 = Mathf.Lerp(iter_16_5.color.r, 0.5, (arg_13_1.time_ - 0) / var_16_9)

								iter_16_5.color = Color.New(var_16_10, var_16_10, var_16_10)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.actorSpriteComps10092 then
				for iter_16_6, iter_16_7 in pairs(arg_13_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_16_7 then
						iter_16_7.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps10092 = nil
			end

			local var_16_11 = arg_13_1.actors_["10097"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.actorSpriteComps10097 == nil then
				arg_13_1.var_.actorSpriteComps10097 = var_16_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_12 = 2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_12 and not isNil(var_16_11) then
				if arg_13_1.var_.actorSpriteComps10097 then
					for iter_16_8, iter_16_9 in pairs(arg_13_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_16_9 then
							if arg_13_1.isInRecall_ then
								iter_16_9.color = Color.New(Mathf.Lerp(iter_16_9.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_12), Mathf.Lerp(iter_16_9.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_12), (Mathf.Lerp(iter_16_9.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_12)))
							else
								local var_16_13 = Mathf.Lerp(iter_16_9.color.r, 1, (arg_13_1.time_ - 0) / var_16_12)

								iter_16_9.color = Color.New(var_16_13, var_16_13, var_16_13)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_12 and arg_13_1.time_ < 0 + var_16_12 + arg_16_0 and not isNil(var_16_11) and arg_13_1.var_.actorSpriteComps10097 then
				for iter_16_10, iter_16_11 in pairs(arg_13_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_16_11 then
						iter_16_11.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps10097 = nil
			end

			local var_16_14 = 0
			local var_16_15 = 0.275

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_16 = arg_13_1:GetWordFromCfg(413051003)
				local var_16_17 = arg_13_1:FormatText(var_16_16.content)

				arg_13_1.text_.text = var_16_17

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_19 = 11 <= 0 and var_16_15 or var_16_15 * (utf8.len(var_16_17) / 11)

				if (11 <= 0 and var_16_15 or var_16_15 * (utf8.len(var_16_17) / 11)) > 0 and var_16_15 < var_16_19 then
					arg_13_1.talkMaxDuration = var_16_19

					if var_16_19 + var_16_14 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_19 + var_16_14
					end
				end

				arg_13_1.text_.text = var_16_17
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051003", "story_v_out_413051.awb") ~= 0 then
					local var_16_20 = manager.audio:GetVoiceLength("story_v_out_413051", "413051003", "story_v_out_413051.awb") / 1000

					if var_16_20 + var_16_14 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_20 + var_16_14
					end

					if var_16_16.prefab_name ~= "" and arg_13_1.actors_[var_16_16.prefab_name] ~= nil then
						local var_16_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_16.prefab_name].transform, "story_v_out_413051", "413051003", "story_v_out_413051.awb")

						arg_13_1:RecordAudio("413051003", var_16_21)
						arg_13_1:RecordAudio("413051003", var_16_21)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413051", "413051003", "story_v_out_413051.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413051", "413051003", "story_v_out_413051.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_22 = math.max(var_16_15, arg_13_1.talkMaxDuration)

			if var_16_14 <= arg_13_1.time_ and arg_13_1.time_ < var_16_14 + var_16_22 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_14) / var_16_22

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_14 + var_16_22 and arg_13_1.time_ < var_16_14 + var_16_22 + arg_16_0 then
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
			},
			{
				assetPath = "",
				actorName = "10097",
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
	Play413051004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413051004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play413051005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10097 = arg_17_1.actors_["10097"].transform.localPosition
				arg_17_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10097", 3)

				for iter_20_0 = 0, arg_17_1.actors_["10097"].transform.childCount - 1 do
					local var_20_0 = arg_17_1.actors_["10097"].transform:GetChild(iter_20_0)

					if var_20_0.name == "" or not string.find(var_20_0.name, "split") then
						var_20_0.gameObject:SetActive(true)
					else
						var_20_0.gameObject:SetActive(false)
					end
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_17_1.time_ - 0) / var_20_1)
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_20_2 = arg_17_1.actors_["10097"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10097 == nil then
				arg_17_1.var_.actorSpriteComps10097 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps10097 then
					for iter_20_1, iter_20_2 in pairs(arg_17_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_20_2 then
							if arg_17_1.isInRecall_ then
								iter_20_2.color = Color.New(Mathf.Lerp(iter_20_2.color.r, arg_17_1.hightColor2.r, (arg_17_1.time_ - 0) / var_20_3), Mathf.Lerp(iter_20_2.color.g, arg_17_1.hightColor2.g, (arg_17_1.time_ - 0) / var_20_3), (Mathf.Lerp(iter_20_2.color.b, arg_17_1.hightColor2.b, (arg_17_1.time_ - 0) / var_20_3)))
							else
								local var_20_4 = Mathf.Lerp(iter_20_2.color.r, 0.5, (arg_17_1.time_ - 0) / var_20_3)

								iter_20_2.color = Color.New(var_20_4, var_20_4, var_20_4)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10097 then
				for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_20_4 then
						iter_20_4.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps10097 = nil
			end

			local var_20_5 = 0
			local var_20_6 = 1.25

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(413051004).content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 50 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_7) / 50)

				if (50 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_7) / 50)) > 0 and var_20_6 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_6, arg_17_1.talkMaxDuration)

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_5) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_5 + var_20_10 and arg_17_1.time_ < var_20_5 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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
	Play413051005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413051005
		arg_21_1.duration_ = 7.97

		local var_21_0 = {
			zh = 6.9,
			ja = 7.966
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
				arg_21_0:Play413051006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10097 = arg_21_1.actors_["10097"].transform.localPosition
				arg_21_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10097", 3)

				for iter_24_0 = 0, arg_21_1.actors_["10097"].transform.childCount - 1 do
					local var_24_0 = arg_21_1.actors_["10097"].transform:GetChild(iter_24_0)

					if var_24_0.name == "" or not string.find(var_24_0.name, "split") then
						var_24_0.gameObject:SetActive(true)
					else
						var_24_0.gameObject:SetActive(false)
					end
				end
			end

			local var_24_1 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 then
				arg_21_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_21_1.time_ - 0) / var_24_1)
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 then
				arg_21_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_24_2 = arg_21_1.actors_["10097"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10097 == nil then
				arg_21_1.var_.actorSpriteComps10097 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps10097 then
					for iter_24_1, iter_24_2 in pairs(arg_21_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_24_2 then
							if arg_21_1.isInRecall_ then
								iter_24_2.color = Color.New(Mathf.Lerp(iter_24_2.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_3), Mathf.Lerp(iter_24_2.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_3), (Mathf.Lerp(iter_24_2.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_3)))
							else
								local var_24_4 = Mathf.Lerp(iter_24_2.color.r, 1, (arg_21_1.time_ - 0) / var_24_3)

								iter_24_2.color = Color.New(var_24_4, var_24_4, var_24_4)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10097 then
				for iter_24_3, iter_24_4 in pairs(arg_21_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_24_4 then
						iter_24_4.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps10097 = nil
			end

			local var_24_5 = 0
			local var_24_6 = 0.7

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(413051005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 28 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 28)

				if (28 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 28)) > 0 and var_24_6 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051005", "story_v_out_413051.awb") ~= 0 then
					local var_24_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051005", "story_v_out_413051.awb") / 1000

					if var_24_11 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_5
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_413051", "413051005", "story_v_out_413051.awb")

						arg_21_1:RecordAudio("413051005", var_24_12)
						arg_21_1:RecordAudio("413051005", var_24_12)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413051", "413051005", "story_v_out_413051.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413051", "413051005", "story_v_out_413051.awb")
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

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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
	Play413051006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413051006
		arg_25_1.duration_ = 6.8

		local var_25_0 = {
			zh = 6.8,
			ja = 2.533
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
				arg_25_0:Play413051007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.675

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(413051006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 27 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 27)

				if (27 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 27)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051006", "story_v_out_413051.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051006", "story_v_out_413051.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_413051", "413051006", "story_v_out_413051.awb")

						arg_25_1:RecordAudio("413051006", var_28_6)
						arg_25_1:RecordAudio("413051006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413051", "413051006", "story_v_out_413051.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413051", "413051006", "story_v_out_413051.awb")
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
	Play413051007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413051007
		arg_29_1.duration_ = 8.77

		local var_29_0 = {
			zh = 6.166,
			ja = 8.766
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
				arg_29_0:Play413051008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.55

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(413051007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 22 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 22)

				if (22 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 22)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051007", "story_v_out_413051.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051007", "story_v_out_413051.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_413051", "413051007", "story_v_out_413051.awb")

						arg_29_1:RecordAudio("413051007", var_32_6)
						arg_29_1:RecordAudio("413051007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413051", "413051007", "story_v_out_413051.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413051", "413051007", "story_v_out_413051.awb")
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
	Play413051008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413051008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play413051009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10097 = arg_33_1.actors_["10097"].transform.localPosition
				arg_33_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10097", 3)

				for iter_36_0 = 0, arg_33_1.actors_["10097"].transform.childCount - 1 do
					local var_36_0 = arg_33_1.actors_["10097"].transform:GetChild(iter_36_0)

					if var_36_0.name == "" or not string.find(var_36_0.name, "split") then
						var_36_0.gameObject:SetActive(true)
					else
						var_36_0.gameObject:SetActive(false)
					end
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_36_2 = arg_33_1.actors_["10097"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps10097 == nil then
				arg_33_1.var_.actorSpriteComps10097 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps10097 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_36_2 then
							if arg_33_1.isInRecall_ then
								iter_36_2.color = Color.New(Mathf.Lerp(iter_36_2.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_3), Mathf.Lerp(iter_36_2.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_3), (Mathf.Lerp(iter_36_2.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_3)))
							else
								local var_36_4 = Mathf.Lerp(iter_36_2.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_3)

								iter_36_2.color = Color.New(var_36_4, var_36_4, var_36_4)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps10097 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_36_4 then
						iter_36_4.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps10097 = nil
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_36_7 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_33_1.bgmTxt_.text ~= var_36_7 and arg_33_1.bgmTxt_.text ~= "" then
						if arg_33_1.bgmTxt2_.text ~= "" then
							arg_33_1.bgmTxt_.text = arg_33_1.bgmTxt2_.text
						end

						arg_33_1.bgmTxt2_.text = var_36_7

						arg_33_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_33_1.bgmTxt_.text = var_36_7
						arg_33_1.bgmTxt2_.text = var_36_7
					end

					if arg_33_1.bgmTimer then
						arg_33_1.bgmTimer:Stop()

						arg_33_1.bgmTimer = nil
					end

					if arg_33_1.settingData.show_music_name == 1 then
						arg_33_1.musicController:SetSelectedState("show")
						arg_33_1.musicAnimator_:Play("open", 0, 0)

						if arg_33_1.settingData.music_time ~= 0 then
							arg_33_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_33_1.settingData.music_time), function()
								if arg_33_1 == nil or isNil(arg_33_1.bgmTxt_) then
									return
								end

								arg_33_1.musicController:SetSelectedState("hide")
								arg_33_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.366666666666667 < arg_33_1.time_ and arg_33_1.time_ <= 0.366666666666667 + arg_36_0 then
				arg_33_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_36_10 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if "" ~= "" then
					if arg_33_1.bgmTxt_.text ~= var_36_10 and arg_33_1.bgmTxt_.text ~= "" then
						if arg_33_1.bgmTxt2_.text ~= "" then
							arg_33_1.bgmTxt_.text = arg_33_1.bgmTxt2_.text
						end

						arg_33_1.bgmTxt2_.text = var_36_10

						arg_33_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_33_1.bgmTxt_.text = var_36_10
						arg_33_1.bgmTxt2_.text = var_36_10
					end

					if arg_33_1.bgmTimer then
						arg_33_1.bgmTimer:Stop()

						arg_33_1.bgmTimer = nil
					end

					if arg_33_1.settingData.show_music_name == 1 then
						arg_33_1.musicController:SetSelectedState("show")
						arg_33_1.musicAnimator_:Play("open", 0, 0)

						if arg_33_1.settingData.music_time ~= 0 then
							arg_33_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_33_1.settingData.music_time), function()
								if arg_33_1 == nil or isNil(arg_33_1.bgmTxt_) then
									return
								end

								arg_33_1.musicController:SetSelectedState("hide")
								arg_33_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_36_11 = 0
			local var_36_12 = 1

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_11 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_13 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(413051008).content)

				arg_33_1.text_.text = var_36_13

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_15 = 40 <= 0 and var_36_12 or var_36_12 * (utf8.len(var_36_13) / 40)

				if (40 <= 0 and var_36_12 or var_36_12 * (utf8.len(var_36_13) / 40)) > 0 and var_36_12 < var_36_15 then
					arg_33_1.talkMaxDuration = var_36_15

					if var_36_15 + var_36_11 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_15 + var_36_11
					end
				end

				arg_33_1.text_.text = var_36_13
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_12, arg_33_1.talkMaxDuration)

			if var_36_11 <= arg_33_1.time_ and arg_33_1.time_ < var_36_11 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_11) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_11 + var_36_16 and arg_33_1.time_ < var_36_11 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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
	Play413051009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 413051009
		arg_39_1.duration_ = 6.43

		local var_39_0 = {
			zh = 4.033,
			ja = 6.433
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play413051010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos10097 = arg_39_1.actors_["10097"].transform.localPosition
				arg_39_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("10097", 0)

				for iter_42_0 = 0, arg_39_1.actors_["10097"].transform.childCount - 1 do
					local var_42_0 = arg_39_1.actors_["10097"].transform:GetChild(iter_42_0)

					if var_42_0.name == "" or not string.find(var_42_0.name, "split") then
						var_42_0.gameObject:SetActive(true)
					else
						var_42_0.gameObject:SetActive(false)
					end
				end
			end

			local var_42_1 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_1 then
				arg_39_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10097, Vector3.New(-1500, -350, -180), (arg_39_1.time_ - 0) / var_42_1)
			end

			if arg_39_1.time_ >= 0 + var_42_1 and arg_39_1.time_ < 0 + var_42_1 + arg_42_0 then
				arg_39_1.actors_["10097"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_42_2 = arg_39_1.actors_["10092"].transform

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos10092 = var_42_2.localPosition
				var_42_2.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("10092", 3)

				for iter_42_1 = 0, var_42_2.childCount - 1 do
					local var_42_3 = var_42_2:GetChild(iter_42_1)

					if var_42_3.name == "split_5" or not string.find(var_42_3.name, "split") then
						var_42_3.gameObject:SetActive(true)
					else
						var_42_3.gameObject:SetActive(false)
					end
				end
			end

			local var_42_4 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				var_42_2.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_39_1.time_ - 0) / var_42_4)
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				var_42_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_42_5 = arg_39_1.actors_["10097"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_5) and arg_39_1.var_.actorSpriteComps10097 == nil then
				arg_39_1.var_.actorSpriteComps10097 = var_42_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_6 = 2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_6 and not isNil(var_42_5) then
				if arg_39_1.var_.actorSpriteComps10097 then
					for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_42_3 then
							if arg_39_1.isInRecall_ then
								iter_42_3.color = Color.New(Mathf.Lerp(iter_42_3.color.r, arg_39_1.hightColor2.r, (arg_39_1.time_ - 0) / var_42_6), Mathf.Lerp(iter_42_3.color.g, arg_39_1.hightColor2.g, (arg_39_1.time_ - 0) / var_42_6), (Mathf.Lerp(iter_42_3.color.b, arg_39_1.hightColor2.b, (arg_39_1.time_ - 0) / var_42_6)))
							else
								local var_42_7 = Mathf.Lerp(iter_42_3.color.r, 0.5, (arg_39_1.time_ - 0) / var_42_6)

								iter_42_3.color = Color.New(var_42_7, var_42_7, var_42_7)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= 0 + var_42_6 and arg_39_1.time_ < 0 + var_42_6 + arg_42_0 and not isNil(var_42_5) and arg_39_1.var_.actorSpriteComps10097 then
				for iter_42_4, iter_42_5 in pairs(arg_39_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_42_5 then
						iter_42_5.color = arg_39_1.isInRecall_ and (arg_39_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_39_1.var_.actorSpriteComps10097 = nil
			end

			local var_42_8 = arg_39_1.actors_["10092"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_8) and arg_39_1.var_.actorSpriteComps10092 == nil then
				arg_39_1.var_.actorSpriteComps10092 = var_42_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_9 = 2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_9 and not isNil(var_42_8) then
				if arg_39_1.var_.actorSpriteComps10092 then
					for iter_42_6, iter_42_7 in pairs(arg_39_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_42_7 then
							if arg_39_1.isInRecall_ then
								iter_42_7.color = Color.New(Mathf.Lerp(iter_42_7.color.r, arg_39_1.hightColor1.r, (arg_39_1.time_ - 0) / var_42_9), Mathf.Lerp(iter_42_7.color.g, arg_39_1.hightColor1.g, (arg_39_1.time_ - 0) / var_42_9), (Mathf.Lerp(iter_42_7.color.b, arg_39_1.hightColor1.b, (arg_39_1.time_ - 0) / var_42_9)))
							else
								local var_42_10 = Mathf.Lerp(iter_42_7.color.r, 1, (arg_39_1.time_ - 0) / var_42_9)

								iter_42_7.color = Color.New(var_42_10, var_42_10, var_42_10)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= 0 + var_42_9 and arg_39_1.time_ < 0 + var_42_9 + arg_42_0 and not isNil(var_42_8) and arg_39_1.var_.actorSpriteComps10092 then
				for iter_42_8, iter_42_9 in pairs(arg_39_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_42_9 then
						iter_42_9.color = arg_39_1.isInRecall_ and (arg_39_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_39_1.var_.actorSpriteComps10092 = nil
			end

			local var_42_11 = 0
			local var_42_12 = 0.5

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_11 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_13 = arg_39_1:GetWordFromCfg(413051009)
				local var_42_14 = arg_39_1:FormatText(var_42_13.content)

				arg_39_1.text_.text = var_42_14

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_16 = 20 <= 0 and var_42_12 or var_42_12 * (utf8.len(var_42_14) / 20)

				if (20 <= 0 and var_42_12 or var_42_12 * (utf8.len(var_42_14) / 20)) > 0 and var_42_12 < var_42_16 then
					arg_39_1.talkMaxDuration = var_42_16

					if var_42_16 + var_42_11 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_16 + var_42_11
					end
				end

				arg_39_1.text_.text = var_42_14
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051009", "story_v_out_413051.awb") ~= 0 then
					local var_42_17 = manager.audio:GetVoiceLength("story_v_out_413051", "413051009", "story_v_out_413051.awb") / 1000

					if var_42_17 + var_42_11 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_17 + var_42_11
					end

					if var_42_13.prefab_name ~= "" and arg_39_1.actors_[var_42_13.prefab_name] ~= nil then
						local var_42_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_13.prefab_name].transform, "story_v_out_413051", "413051009", "story_v_out_413051.awb")

						arg_39_1:RecordAudio("413051009", var_42_18)
						arg_39_1:RecordAudio("413051009", var_42_18)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_413051", "413051009", "story_v_out_413051.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_413051", "413051009", "story_v_out_413051.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_19 = math.max(var_42_12, arg_39_1.talkMaxDuration)

			if var_42_11 <= arg_39_1.time_ and arg_39_1.time_ < var_42_11 + var_42_19 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_11) / var_42_19

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_11 + var_42_19 and arg_39_1.time_ < var_42_11 + var_42_19 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_39_1:InitPlayNodeList()
	end,
	Play413051010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 413051010
		arg_43_1.duration_ = 5.17

		local var_43_0 = {
			zh = 4.733,
			ja = 5.166
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
				arg_43_0:Play413051011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.575

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:GetWordFromCfg(413051010)
				local var_46_2 = arg_43_1:FormatText(var_46_1.content)

				arg_43_1.text_.text = var_46_2

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_4 = 23 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 23)

				if (23 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_2) / 23)) > 0 and var_46_0 < var_46_4 then
					arg_43_1.talkMaxDuration = var_46_4

					if var_46_4 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_4 + 0
					end
				end

				arg_43_1.text_.text = var_46_2
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051010", "story_v_out_413051.awb") ~= 0 then
					local var_46_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051010", "story_v_out_413051.awb") / 1000

					if var_46_5 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + 0
					end

					if var_46_1.prefab_name ~= "" and arg_43_1.actors_[var_46_1.prefab_name] ~= nil then
						local var_46_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_1.prefab_name].transform, "story_v_out_413051", "413051010", "story_v_out_413051.awb")

						arg_43_1:RecordAudio("413051010", var_46_6)
						arg_43_1:RecordAudio("413051010", var_46_6)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_413051", "413051010", "story_v_out_413051.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_413051", "413051010", "story_v_out_413051.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_7 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_7 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_7

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_7 and arg_43_1.time_ < 0 + var_46_7 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play413051011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 413051011
		arg_47_1.duration_ = 8.27

		local var_47_0 = {
			zh = 2.766,
			ja = 8.266
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play413051012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.3

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_1 = arg_47_1:GetWordFromCfg(413051011)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 12 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 12)

				if (12 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 12)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051011", "story_v_out_413051.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051011", "story_v_out_413051.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_413051", "413051011", "story_v_out_413051.awb")

						arg_47_1:RecordAudio("413051011", var_50_6)
						arg_47_1:RecordAudio("413051011", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_413051", "413051011", "story_v_out_413051.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_413051", "413051011", "story_v_out_413051.awb")
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
	Play413051012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 413051012
		arg_51_1.duration_ = 10.57

		local var_51_0 = {
			zh = 5.833,
			ja = 10.566
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play413051013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos10092 = arg_51_1.actors_["10092"].transform.localPosition
				arg_51_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("10092", 7)

				for iter_54_0 = 0, arg_51_1.actors_["10092"].transform.childCount - 1 do
					local var_54_0 = arg_51_1.actors_["10092"].transform:GetChild(iter_54_0)

					if var_54_0.name == "" or not string.find(var_54_0.name, "split") then
						var_54_0.gameObject:SetActive(true)
					else
						var_54_0.gameObject:SetActive(false)
					end
				end
			end

			local var_54_1 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_1 then
				arg_51_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_51_1.time_ - 0) / var_54_1)
			end

			if arg_51_1.time_ >= 0 + var_54_1 and arg_51_1.time_ < 0 + var_54_1 + arg_54_0 then
				arg_51_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_54_2 = arg_51_1.actors_["10097"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos10097 = var_54_2.localPosition
				var_54_2.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("10097", 3)

				for iter_54_1 = 0, var_54_2.childCount - 1 do
					local var_54_3 = var_54_2:GetChild(iter_54_1)

					if var_54_3.name == "split_2" or not string.find(var_54_3.name, "split") then
						var_54_3.gameObject:SetActive(true)
					else
						var_54_3.gameObject:SetActive(false)
					end
				end
			end

			local var_54_4 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				var_54_2.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_51_1.time_ - 0) / var_54_4)
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				var_54_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_54_5 = arg_51_1.actors_["10092"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.actorSpriteComps10092 == nil then
				arg_51_1.var_.actorSpriteComps10092 = var_54_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_6 = 2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_6 and not isNil(var_54_5) then
				if arg_51_1.var_.actorSpriteComps10092 then
					for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_54_3 then
							if arg_51_1.isInRecall_ then
								iter_54_3.color = Color.New(Mathf.Lerp(iter_54_3.color.r, arg_51_1.hightColor2.r, (arg_51_1.time_ - 0) / var_54_6), Mathf.Lerp(iter_54_3.color.g, arg_51_1.hightColor2.g, (arg_51_1.time_ - 0) / var_54_6), (Mathf.Lerp(iter_54_3.color.b, arg_51_1.hightColor2.b, (arg_51_1.time_ - 0) / var_54_6)))
							else
								local var_54_7 = Mathf.Lerp(iter_54_3.color.r, 0.5, (arg_51_1.time_ - 0) / var_54_6)

								iter_54_3.color = Color.New(var_54_7, var_54_7, var_54_7)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_6 and arg_51_1.time_ < 0 + var_54_6 + arg_54_0 and not isNil(var_54_5) and arg_51_1.var_.actorSpriteComps10092 then
				for iter_54_4, iter_54_5 in pairs(arg_51_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_54_5 then
						iter_54_5.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_51_1.var_.actorSpriteComps10092 = nil
			end

			local var_54_8 = arg_51_1.actors_["10097"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_8) and arg_51_1.var_.actorSpriteComps10097 == nil then
				arg_51_1.var_.actorSpriteComps10097 = var_54_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_9 = 2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_9 and not isNil(var_54_8) then
				if arg_51_1.var_.actorSpriteComps10097 then
					for iter_54_6, iter_54_7 in pairs(arg_51_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_54_7 then
							if arg_51_1.isInRecall_ then
								iter_54_7.color = Color.New(Mathf.Lerp(iter_54_7.color.r, arg_51_1.hightColor1.r, (arg_51_1.time_ - 0) / var_54_9), Mathf.Lerp(iter_54_7.color.g, arg_51_1.hightColor1.g, (arg_51_1.time_ - 0) / var_54_9), (Mathf.Lerp(iter_54_7.color.b, arg_51_1.hightColor1.b, (arg_51_1.time_ - 0) / var_54_9)))
							else
								local var_54_10 = Mathf.Lerp(iter_54_7.color.r, 1, (arg_51_1.time_ - 0) / var_54_9)

								iter_54_7.color = Color.New(var_54_10, var_54_10, var_54_10)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_9 and arg_51_1.time_ < 0 + var_54_9 + arg_54_0 and not isNil(var_54_8) and arg_51_1.var_.actorSpriteComps10097 then
				for iter_54_8, iter_54_9 in pairs(arg_51_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_54_9 then
						iter_54_9.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_51_1.var_.actorSpriteComps10097 = nil
			end

			local var_54_11 = 0
			local var_54_12 = 0.5

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_11 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_13 = arg_51_1:GetWordFromCfg(413051012)
				local var_54_14 = arg_51_1:FormatText(var_54_13.content)

				arg_51_1.text_.text = var_54_14

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_16 = 20 <= 0 and var_54_12 or var_54_12 * (utf8.len(var_54_14) / 20)

				if (20 <= 0 and var_54_12 or var_54_12 * (utf8.len(var_54_14) / 20)) > 0 and var_54_12 < var_54_16 then
					arg_51_1.talkMaxDuration = var_54_16

					if var_54_16 + var_54_11 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_16 + var_54_11
					end
				end

				arg_51_1.text_.text = var_54_14
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051012", "story_v_out_413051.awb") ~= 0 then
					local var_54_17 = manager.audio:GetVoiceLength("story_v_out_413051", "413051012", "story_v_out_413051.awb") / 1000

					if var_54_17 + var_54_11 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_17 + var_54_11
					end

					if var_54_13.prefab_name ~= "" and arg_51_1.actors_[var_54_13.prefab_name] ~= nil then
						local var_54_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_13.prefab_name].transform, "story_v_out_413051", "413051012", "story_v_out_413051.awb")

						arg_51_1:RecordAudio("413051012", var_54_18)
						arg_51_1:RecordAudio("413051012", var_54_18)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_413051", "413051012", "story_v_out_413051.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_413051", "413051012", "story_v_out_413051.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_19 = math.max(var_54_12, arg_51_1.talkMaxDuration)

			if var_54_11 <= arg_51_1.time_ and arg_51_1.time_ < var_54_11 + var_54_19 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_11) / var_54_19

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_11 + var_54_19 and arg_51_1.time_ < var_54_11 + var_54_19 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
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
				actorName = "10097",
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
	Play413051013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 413051013
		arg_55_1.duration_ = 17.1

		local var_55_0 = {
			zh = 7.1,
			ja = 17.1
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
				arg_55_0:Play413051014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10097 = arg_55_1.actors_["10097"].transform.localPosition
				arg_55_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10097", 7)

				for iter_58_0 = 0, arg_55_1.actors_["10097"].transform.childCount - 1 do
					local var_58_0 = arg_55_1.actors_["10097"].transform:GetChild(iter_58_0)

					if var_58_0.name == "" or not string.find(var_58_0.name, "split") then
						var_58_0.gameObject:SetActive(true)
					else
						var_58_0.gameObject:SetActive(false)
					end
				end
			end

			local var_58_1 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_1 then
				arg_55_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10097, Vector3.New(0, -2000, -180), (arg_55_1.time_ - 0) / var_58_1)
			end

			if arg_55_1.time_ >= 0 + var_58_1 and arg_55_1.time_ < 0 + var_58_1 + arg_58_0 then
				arg_55_1.actors_["10097"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_58_2 = arg_55_1.actors_["10092"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10092 = var_58_2.localPosition
				var_58_2.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10092", 3)

				for iter_58_1 = 0, var_58_2.childCount - 1 do
					local var_58_3 = var_58_2:GetChild(iter_58_1)

					if var_58_3.name == "split_8" or not string.find(var_58_3.name, "split") then
						var_58_3.gameObject:SetActive(true)
					else
						var_58_3.gameObject:SetActive(false)
					end
				end
			end

			local var_58_4 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				var_58_2.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_55_1.time_ - 0) / var_58_4)
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				var_58_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_58_5 = arg_55_1.actors_["10097"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_5) and arg_55_1.var_.actorSpriteComps10097 == nil then
				arg_55_1.var_.actorSpriteComps10097 = var_58_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_6 = 2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_6 and not isNil(var_58_5) then
				if arg_55_1.var_.actorSpriteComps10097 then
					for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_58_3 then
							if arg_55_1.isInRecall_ then
								iter_58_3.color = Color.New(Mathf.Lerp(iter_58_3.color.r, arg_55_1.hightColor2.r, (arg_55_1.time_ - 0) / var_58_6), Mathf.Lerp(iter_58_3.color.g, arg_55_1.hightColor2.g, (arg_55_1.time_ - 0) / var_58_6), (Mathf.Lerp(iter_58_3.color.b, arg_55_1.hightColor2.b, (arg_55_1.time_ - 0) / var_58_6)))
							else
								local var_58_7 = Mathf.Lerp(iter_58_3.color.r, 0.5, (arg_55_1.time_ - 0) / var_58_6)

								iter_58_3.color = Color.New(var_58_7, var_58_7, var_58_7)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_6 and arg_55_1.time_ < 0 + var_58_6 + arg_58_0 and not isNil(var_58_5) and arg_55_1.var_.actorSpriteComps10097 then
				for iter_58_4, iter_58_5 in pairs(arg_55_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_58_5 then
						iter_58_5.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_55_1.var_.actorSpriteComps10097 = nil
			end

			local var_58_8 = arg_55_1.actors_["10092"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_8) and arg_55_1.var_.actorSpriteComps10092 == nil then
				arg_55_1.var_.actorSpriteComps10092 = var_58_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_9 = 2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_9 and not isNil(var_58_8) then
				if arg_55_1.var_.actorSpriteComps10092 then
					for iter_58_6, iter_58_7 in pairs(arg_55_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_58_7 then
							if arg_55_1.isInRecall_ then
								iter_58_7.color = Color.New(Mathf.Lerp(iter_58_7.color.r, arg_55_1.hightColor1.r, (arg_55_1.time_ - 0) / var_58_9), Mathf.Lerp(iter_58_7.color.g, arg_55_1.hightColor1.g, (arg_55_1.time_ - 0) / var_58_9), (Mathf.Lerp(iter_58_7.color.b, arg_55_1.hightColor1.b, (arg_55_1.time_ - 0) / var_58_9)))
							else
								local var_58_10 = Mathf.Lerp(iter_58_7.color.r, 1, (arg_55_1.time_ - 0) / var_58_9)

								iter_58_7.color = Color.New(var_58_10, var_58_10, var_58_10)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_9 and arg_55_1.time_ < 0 + var_58_9 + arg_58_0 and not isNil(var_58_8) and arg_55_1.var_.actorSpriteComps10092 then
				for iter_58_8, iter_58_9 in pairs(arg_55_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_58_9 then
						iter_58_9.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_55_1.var_.actorSpriteComps10092 = nil
			end

			local var_58_11 = 0
			local var_58_12 = 0.925

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_11 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_13 = arg_55_1:GetWordFromCfg(413051013)
				local var_58_14 = arg_55_1:FormatText(var_58_13.content)

				arg_55_1.text_.text = var_58_14

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_16 = 37 <= 0 and var_58_12 or var_58_12 * (utf8.len(var_58_14) / 37)

				if (37 <= 0 and var_58_12 or var_58_12 * (utf8.len(var_58_14) / 37)) > 0 and var_58_12 < var_58_16 then
					arg_55_1.talkMaxDuration = var_58_16

					if var_58_16 + var_58_11 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_16 + var_58_11
					end
				end

				arg_55_1.text_.text = var_58_14
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051013", "story_v_out_413051.awb") ~= 0 then
					local var_58_17 = manager.audio:GetVoiceLength("story_v_out_413051", "413051013", "story_v_out_413051.awb") / 1000

					if var_58_17 + var_58_11 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_17 + var_58_11
					end

					if var_58_13.prefab_name ~= "" and arg_55_1.actors_[var_58_13.prefab_name] ~= nil then
						local var_58_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_13.prefab_name].transform, "story_v_out_413051", "413051013", "story_v_out_413051.awb")

						arg_55_1:RecordAudio("413051013", var_58_18)
						arg_55_1:RecordAudio("413051013", var_58_18)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_413051", "413051013", "story_v_out_413051.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_413051", "413051013", "story_v_out_413051.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_19 = math.max(var_58_12, arg_55_1.talkMaxDuration)

			if var_58_11 <= arg_55_1.time_ and arg_55_1.time_ < var_58_11 + var_58_19 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_11) / var_58_19

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_11 + var_58_19 and arg_55_1.time_ < var_58_11 + var_58_19 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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

		arg_55_1:InitPlayNodeList()
	end,
	Play413051014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 413051014
		arg_59_1.duration_ = 20.03

		local var_59_0 = {
			zh = 8.333,
			ja = 20.033
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
				arg_59_0:Play413051015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10092 = arg_59_1.actors_["10092"].transform.localPosition
				arg_59_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("10092", 7)

				for iter_62_0 = 0, arg_59_1.actors_["10092"].transform.childCount - 1 do
					local var_62_0 = arg_59_1.actors_["10092"].transform:GetChild(iter_62_0)

					if var_62_0.name == "" or not string.find(var_62_0.name, "split") then
						var_62_0.gameObject:SetActive(true)
					else
						var_62_0.gameObject:SetActive(false)
					end
				end
			end

			local var_62_1 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_1 then
				arg_59_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_59_1.time_ - 0) / var_62_1)
			end

			if arg_59_1.time_ >= 0 + var_62_1 and arg_59_1.time_ < 0 + var_62_1 + arg_62_0 then
				arg_59_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_62_2 = arg_59_1.actors_["10097"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10097 = var_62_2.localPosition
				var_62_2.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("10097", 3)

				for iter_62_1 = 0, var_62_2.childCount - 1 do
					local var_62_3 = var_62_2:GetChild(iter_62_1)

					if var_62_3.name == "" or not string.find(var_62_3.name, "split") then
						var_62_3.gameObject:SetActive(true)
					else
						var_62_3.gameObject:SetActive(false)
					end
				end
			end

			local var_62_4 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				var_62_2.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_59_1.time_ - 0) / var_62_4)
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				var_62_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_62_5 = arg_59_1.actors_["10092"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_5) and arg_59_1.var_.actorSpriteComps10092 == nil then
				arg_59_1.var_.actorSpriteComps10092 = var_62_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_6 = 2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_6 and not isNil(var_62_5) then
				if arg_59_1.var_.actorSpriteComps10092 then
					for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_62_3 then
							if arg_59_1.isInRecall_ then
								iter_62_3.color = Color.New(Mathf.Lerp(iter_62_3.color.r, arg_59_1.hightColor2.r, (arg_59_1.time_ - 0) / var_62_6), Mathf.Lerp(iter_62_3.color.g, arg_59_1.hightColor2.g, (arg_59_1.time_ - 0) / var_62_6), (Mathf.Lerp(iter_62_3.color.b, arg_59_1.hightColor2.b, (arg_59_1.time_ - 0) / var_62_6)))
							else
								local var_62_7 = Mathf.Lerp(iter_62_3.color.r, 0.5, (arg_59_1.time_ - 0) / var_62_6)

								iter_62_3.color = Color.New(var_62_7, var_62_7, var_62_7)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= 0 + var_62_6 and arg_59_1.time_ < 0 + var_62_6 + arg_62_0 and not isNil(var_62_5) and arg_59_1.var_.actorSpriteComps10092 then
				for iter_62_4, iter_62_5 in pairs(arg_59_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_62_5 then
						iter_62_5.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_59_1.var_.actorSpriteComps10092 = nil
			end

			local var_62_8 = arg_59_1.actors_["10097"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_8) and arg_59_1.var_.actorSpriteComps10097 == nil then
				arg_59_1.var_.actorSpriteComps10097 = var_62_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_9 = 2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_9 and not isNil(var_62_8) then
				if arg_59_1.var_.actorSpriteComps10097 then
					for iter_62_6, iter_62_7 in pairs(arg_59_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_62_7 then
							if arg_59_1.isInRecall_ then
								iter_62_7.color = Color.New(Mathf.Lerp(iter_62_7.color.r, arg_59_1.hightColor1.r, (arg_59_1.time_ - 0) / var_62_9), Mathf.Lerp(iter_62_7.color.g, arg_59_1.hightColor1.g, (arg_59_1.time_ - 0) / var_62_9), (Mathf.Lerp(iter_62_7.color.b, arg_59_1.hightColor1.b, (arg_59_1.time_ - 0) / var_62_9)))
							else
								local var_62_10 = Mathf.Lerp(iter_62_7.color.r, 1, (arg_59_1.time_ - 0) / var_62_9)

								iter_62_7.color = Color.New(var_62_10, var_62_10, var_62_10)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= 0 + var_62_9 and arg_59_1.time_ < 0 + var_62_9 + arg_62_0 and not isNil(var_62_8) and arg_59_1.var_.actorSpriteComps10097 then
				for iter_62_8, iter_62_9 in pairs(arg_59_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_62_9 then
						iter_62_9.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_59_1.var_.actorSpriteComps10097 = nil
			end

			local var_62_11 = 0
			local var_62_12 = 0.675

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_11 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_13 = arg_59_1:GetWordFromCfg(413051014)
				local var_62_14 = arg_59_1:FormatText(var_62_13.content)

				arg_59_1.text_.text = var_62_14

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_16 = 27 <= 0 and var_62_12 or var_62_12 * (utf8.len(var_62_14) / 27)

				if (27 <= 0 and var_62_12 or var_62_12 * (utf8.len(var_62_14) / 27)) > 0 and var_62_12 < var_62_16 then
					arg_59_1.talkMaxDuration = var_62_16

					if var_62_16 + var_62_11 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_16 + var_62_11
					end
				end

				arg_59_1.text_.text = var_62_14
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051014", "story_v_out_413051.awb") ~= 0 then
					local var_62_17 = manager.audio:GetVoiceLength("story_v_out_413051", "413051014", "story_v_out_413051.awb") / 1000

					if var_62_17 + var_62_11 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_17 + var_62_11
					end

					if var_62_13.prefab_name ~= "" and arg_59_1.actors_[var_62_13.prefab_name] ~= nil then
						local var_62_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_13.prefab_name].transform, "story_v_out_413051", "413051014", "story_v_out_413051.awb")

						arg_59_1:RecordAudio("413051014", var_62_18)
						arg_59_1:RecordAudio("413051014", var_62_18)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_413051", "413051014", "story_v_out_413051.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_413051", "413051014", "story_v_out_413051.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_19 = math.max(var_62_12, arg_59_1.talkMaxDuration)

			if var_62_11 <= arg_59_1.time_ and arg_59_1.time_ < var_62_11 + var_62_19 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_11) / var_62_19

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_11 + var_62_19 and arg_59_1.time_ < var_62_11 + var_62_19 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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
				actorName = "10097",
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
	Play413051015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 413051015
		arg_63_1.duration_ = 8.5

		local var_63_0 = {
			zh = 3.3,
			ja = 8.5
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
				arg_63_0:Play413051016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos10092 = arg_63_1.actors_["10092"].transform.localPosition
				arg_63_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10092", 0)

				for iter_66_0 = 0, arg_63_1.actors_["10092"].transform.childCount - 1 do
					local var_66_0 = arg_63_1.actors_["10092"].transform:GetChild(iter_66_0)

					if var_66_0.name == "" or not string.find(var_66_0.name, "split") then
						var_66_0.gameObject:SetActive(true)
					else
						var_66_0.gameObject:SetActive(false)
					end
				end
			end

			local var_66_1 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_1 then
				arg_63_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_63_1.time_ - 0) / var_66_1)
			end

			if arg_63_1.time_ >= 0 + var_66_1 and arg_63_1.time_ < 0 + var_66_1 + arg_66_0 then
				arg_63_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_66_2 = arg_63_1.actors_["10097"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos10097 = var_66_2.localPosition
				var_66_2.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10097", 0)

				for iter_66_1 = 0, var_66_2.childCount - 1 do
					local var_66_3 = var_66_2:GetChild(iter_66_1)

					if var_66_3.name == "" or not string.find(var_66_3.name, "split") then
						var_66_3.gameObject:SetActive(true)
					else
						var_66_3.gameObject:SetActive(false)
					end
				end
			end

			local var_66_4 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				var_66_2.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10097, Vector3.New(-1500, -350, -180), (arg_63_1.time_ - 0) / var_66_4)
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				var_66_2.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_66_5 = "10094"

			if arg_63_1.actors_["10094"] == nil then
				local var_66_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_66_6) then
					local var_66_7 = Object.Instantiate(var_66_6, arg_63_1.canvasGo_.transform)

					var_66_7.transform:SetSiblingIndex(1)

					var_66_7.name = var_66_5
					var_66_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_63_1.actors_[var_66_5] = var_66_7

					if arg_63_1.isInRecall_ then
						for iter_66_2, iter_66_3 in ipairs((var_66_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_66_3.color = arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_66_8 = arg_63_1.actors_["10094"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos10094 = var_66_8.localPosition
				var_66_8.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10094", 3)

				for iter_66_4 = 0, var_66_8.childCount - 1 do
					local var_66_9 = var_66_8:GetChild(iter_66_4)

					if var_66_9.name == "" or not string.find(var_66_9.name, "split") then
						var_66_9.gameObject:SetActive(true)
					else
						var_66_9.gameObject:SetActive(false)
					end
				end
			end

			local var_66_10 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_10 then
				var_66_8.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_63_1.time_ - 0) / var_66_10)
			end

			if arg_63_1.time_ >= 0 + var_66_10 and arg_63_1.time_ < 0 + var_66_10 + arg_66_0 then
				var_66_8.localPosition = Vector3.New(0, -340, -414)
			end

			local var_66_11 = arg_63_1.actors_["10092"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_11) and arg_63_1.var_.actorSpriteComps10092 == nil then
				arg_63_1.var_.actorSpriteComps10092 = var_66_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_12 = 2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_12 and not isNil(var_66_11) then
				if arg_63_1.var_.actorSpriteComps10092 then
					for iter_66_5, iter_66_6 in pairs(arg_63_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_66_6 then
							if arg_63_1.isInRecall_ then
								iter_66_6.color = Color.New(Mathf.Lerp(iter_66_6.color.r, arg_63_1.hightColor2.r, (arg_63_1.time_ - 0) / var_66_12), Mathf.Lerp(iter_66_6.color.g, arg_63_1.hightColor2.g, (arg_63_1.time_ - 0) / var_66_12), (Mathf.Lerp(iter_66_6.color.b, arg_63_1.hightColor2.b, (arg_63_1.time_ - 0) / var_66_12)))
							else
								local var_66_13 = Mathf.Lerp(iter_66_6.color.r, 0.5, (arg_63_1.time_ - 0) / var_66_12)

								iter_66_6.color = Color.New(var_66_13, var_66_13, var_66_13)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_12 and arg_63_1.time_ < 0 + var_66_12 + arg_66_0 and not isNil(var_66_11) and arg_63_1.var_.actorSpriteComps10092 then
				for iter_66_7, iter_66_8 in pairs(arg_63_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_66_8 then
						iter_66_8.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_63_1.var_.actorSpriteComps10092 = nil
			end

			local var_66_14 = arg_63_1.actors_["10097"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_14) and arg_63_1.var_.actorSpriteComps10097 == nil then
				arg_63_1.var_.actorSpriteComps10097 = var_66_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_15 = 2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_15 and not isNil(var_66_14) then
				if arg_63_1.var_.actorSpriteComps10097 then
					for iter_66_9, iter_66_10 in pairs(arg_63_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_66_10 then
							if arg_63_1.isInRecall_ then
								iter_66_10.color = Color.New(Mathf.Lerp(iter_66_10.color.r, arg_63_1.hightColor2.r, (arg_63_1.time_ - 0) / var_66_15), Mathf.Lerp(iter_66_10.color.g, arg_63_1.hightColor2.g, (arg_63_1.time_ - 0) / var_66_15), (Mathf.Lerp(iter_66_10.color.b, arg_63_1.hightColor2.b, (arg_63_1.time_ - 0) / var_66_15)))
							else
								local var_66_16 = Mathf.Lerp(iter_66_10.color.r, 0.5, (arg_63_1.time_ - 0) / var_66_15)

								iter_66_10.color = Color.New(var_66_16, var_66_16, var_66_16)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_15 and arg_63_1.time_ < 0 + var_66_15 + arg_66_0 and not isNil(var_66_14) and arg_63_1.var_.actorSpriteComps10097 then
				for iter_66_11, iter_66_12 in pairs(arg_63_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_66_12 then
						iter_66_12.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_63_1.var_.actorSpriteComps10097 = nil
			end

			local var_66_17 = arg_63_1.actors_["10094"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_17) and arg_63_1.var_.actorSpriteComps10094 == nil then
				arg_63_1.var_.actorSpriteComps10094 = var_66_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_18 = 2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_18 and not isNil(var_66_17) then
				if arg_63_1.var_.actorSpriteComps10094 then
					for iter_66_13, iter_66_14 in pairs(arg_63_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_66_14 then
							if arg_63_1.isInRecall_ then
								iter_66_14.color = Color.New(Mathf.Lerp(iter_66_14.color.r, arg_63_1.hightColor1.r, (arg_63_1.time_ - 0) / var_66_18), Mathf.Lerp(iter_66_14.color.g, arg_63_1.hightColor1.g, (arg_63_1.time_ - 0) / var_66_18), (Mathf.Lerp(iter_66_14.color.b, arg_63_1.hightColor1.b, (arg_63_1.time_ - 0) / var_66_18)))
							else
								local var_66_19 = Mathf.Lerp(iter_66_14.color.r, 1, (arg_63_1.time_ - 0) / var_66_18)

								iter_66_14.color = Color.New(var_66_19, var_66_19, var_66_19)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_18 and arg_63_1.time_ < 0 + var_66_18 + arg_66_0 and not isNil(var_66_17) and arg_63_1.var_.actorSpriteComps10094 then
				for iter_66_15, iter_66_16 in pairs(arg_63_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_66_16 then
						iter_66_16.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_63_1.var_.actorSpriteComps10094 = nil
			end

			local var_66_20 = 0
			local var_66_21 = 0.35

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_20 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_22 = arg_63_1:GetWordFromCfg(413051015)
				local var_66_23 = arg_63_1:FormatText(var_66_22.content)

				arg_63_1.text_.text = var_66_23

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_25 = 14 <= 0 and var_66_21 or var_66_21 * (utf8.len(var_66_23) / 14)

				if (14 <= 0 and var_66_21 or var_66_21 * (utf8.len(var_66_23) / 14)) > 0 and var_66_21 < var_66_25 then
					arg_63_1.talkMaxDuration = var_66_25

					if var_66_25 + var_66_20 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_25 + var_66_20
					end
				end

				arg_63_1.text_.text = var_66_23
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051015", "story_v_out_413051.awb") ~= 0 then
					local var_66_26 = manager.audio:GetVoiceLength("story_v_out_413051", "413051015", "story_v_out_413051.awb") / 1000

					if var_66_26 + var_66_20 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_26 + var_66_20
					end

					if var_66_22.prefab_name ~= "" and arg_63_1.actors_[var_66_22.prefab_name] ~= nil then
						local var_66_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_22.prefab_name].transform, "story_v_out_413051", "413051015", "story_v_out_413051.awb")

						arg_63_1:RecordAudio("413051015", var_66_27)
						arg_63_1:RecordAudio("413051015", var_66_27)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_413051", "413051015", "story_v_out_413051.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_413051", "413051015", "story_v_out_413051.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_28 = math.max(var_66_21, arg_63_1.talkMaxDuration)

			if var_66_20 <= arg_63_1.time_ and arg_63_1.time_ < var_66_20 + var_66_28 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_20) / var_66_28

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_20 + var_66_28 and arg_63_1.time_ < var_66_20 + var_66_28 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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
				actorName = "10097",
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

		arg_63_1:InitPlayNodeList()
	end,
	Play413051016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 413051016
		arg_67_1.duration_ = 13.7

		local var_67_0 = {
			zh = 7.4,
			ja = 13.7
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
				arg_67_0:Play413051017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.825

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:GetWordFromCfg(413051016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 33 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 33)

				if (33 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 33)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051016", "story_v_out_413051.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051016", "story_v_out_413051.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_413051", "413051016", "story_v_out_413051.awb")

						arg_67_1:RecordAudio("413051016", var_70_6)
						arg_67_1:RecordAudio("413051016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_413051", "413051016", "story_v_out_413051.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_413051", "413051016", "story_v_out_413051.awb")
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
	Play413051017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 413051017
		arg_71_1.duration_ = 5.53

		local var_71_0 = {
			zh = 5.533,
			ja = 3.5
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
				arg_71_0:Play413051018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos10094 = arg_71_1.actors_["10094"].transform.localPosition
				arg_71_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("10094", 7)

				for iter_74_0 = 0, arg_71_1.actors_["10094"].transform.childCount - 1 do
					local var_74_0 = arg_71_1.actors_["10094"].transform:GetChild(iter_74_0)

					if var_74_0.name == "" or not string.find(var_74_0.name, "split") then
						var_74_0.gameObject:SetActive(true)
					else
						var_74_0.gameObject:SetActive(false)
					end
				end
			end

			local var_74_1 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_1 then
				arg_71_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_71_1.time_ - 0) / var_74_1)
			end

			if arg_71_1.time_ >= 0 + var_74_1 and arg_71_1.time_ < 0 + var_74_1 + arg_74_0 then
				arg_71_1.actors_["10094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_74_2 = arg_71_1.actors_["10097"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos10097 = var_74_2.localPosition
				var_74_2.localScale = Vector3.New(1, 1, 1)

				arg_71_1:CheckSpriteTmpPos("10097", 3)

				for iter_74_1 = 0, var_74_2.childCount - 1 do
					local var_74_3 = var_74_2:GetChild(iter_74_1)

					if var_74_3.name == "" or not string.find(var_74_3.name, "split") then
						var_74_3.gameObject:SetActive(true)
					else
						var_74_3.gameObject:SetActive(false)
					end
				end
			end

			local var_74_4 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_4 then
				var_74_2.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_71_1.time_ - 0) / var_74_4)
			end

			if arg_71_1.time_ >= 0 + var_74_4 and arg_71_1.time_ < 0 + var_74_4 + arg_74_0 then
				var_74_2.localPosition = Vector3.New(0, -350, -180)
			end

			local var_74_5 = arg_71_1.actors_["10094"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_5) and arg_71_1.var_.actorSpriteComps10094 == nil then
				arg_71_1.var_.actorSpriteComps10094 = var_74_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_6 = 2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_6 and not isNil(var_74_5) then
				if arg_71_1.var_.actorSpriteComps10094 then
					for iter_74_2, iter_74_3 in pairs(arg_71_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_74_3 then
							if arg_71_1.isInRecall_ then
								iter_74_3.color = Color.New(Mathf.Lerp(iter_74_3.color.r, arg_71_1.hightColor2.r, (arg_71_1.time_ - 0) / var_74_6), Mathf.Lerp(iter_74_3.color.g, arg_71_1.hightColor2.g, (arg_71_1.time_ - 0) / var_74_6), (Mathf.Lerp(iter_74_3.color.b, arg_71_1.hightColor2.b, (arg_71_1.time_ - 0) / var_74_6)))
							else
								local var_74_7 = Mathf.Lerp(iter_74_3.color.r, 0.5, (arg_71_1.time_ - 0) / var_74_6)

								iter_74_3.color = Color.New(var_74_7, var_74_7, var_74_7)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= 0 + var_74_6 and arg_71_1.time_ < 0 + var_74_6 + arg_74_0 and not isNil(var_74_5) and arg_71_1.var_.actorSpriteComps10094 then
				for iter_74_4, iter_74_5 in pairs(arg_71_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_74_5 then
						iter_74_5.color = arg_71_1.isInRecall_ and (arg_71_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_71_1.var_.actorSpriteComps10094 = nil
			end

			local var_74_8 = arg_71_1.actors_["10097"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_8) and arg_71_1.var_.actorSpriteComps10097 == nil then
				arg_71_1.var_.actorSpriteComps10097 = var_74_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_9 = 2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_9 and not isNil(var_74_8) then
				if arg_71_1.var_.actorSpriteComps10097 then
					for iter_74_6, iter_74_7 in pairs(arg_71_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_74_7 then
							if arg_71_1.isInRecall_ then
								iter_74_7.color = Color.New(Mathf.Lerp(iter_74_7.color.r, arg_71_1.hightColor1.r, (arg_71_1.time_ - 0) / var_74_9), Mathf.Lerp(iter_74_7.color.g, arg_71_1.hightColor1.g, (arg_71_1.time_ - 0) / var_74_9), (Mathf.Lerp(iter_74_7.color.b, arg_71_1.hightColor1.b, (arg_71_1.time_ - 0) / var_74_9)))
							else
								local var_74_10 = Mathf.Lerp(iter_74_7.color.r, 1, (arg_71_1.time_ - 0) / var_74_9)

								iter_74_7.color = Color.New(var_74_10, var_74_10, var_74_10)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= 0 + var_74_9 and arg_71_1.time_ < 0 + var_74_9 + arg_74_0 and not isNil(var_74_8) and arg_71_1.var_.actorSpriteComps10097 then
				for iter_74_8, iter_74_9 in pairs(arg_71_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_74_9 then
						iter_74_9.color = arg_71_1.isInRecall_ and (arg_71_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_71_1.var_.actorSpriteComps10097 = nil
			end

			local var_74_11 = 0
			local var_74_12 = 0.65

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_11 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_13 = arg_71_1:GetWordFromCfg(413051017)
				local var_74_14 = arg_71_1:FormatText(var_74_13.content)

				arg_71_1.text_.text = var_74_14

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_16 = 26 <= 0 and var_74_12 or var_74_12 * (utf8.len(var_74_14) / 26)

				if (26 <= 0 and var_74_12 or var_74_12 * (utf8.len(var_74_14) / 26)) > 0 and var_74_12 < var_74_16 then
					arg_71_1.talkMaxDuration = var_74_16

					if var_74_16 + var_74_11 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_16 + var_74_11
					end
				end

				arg_71_1.text_.text = var_74_14
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051017", "story_v_out_413051.awb") ~= 0 then
					local var_74_17 = manager.audio:GetVoiceLength("story_v_out_413051", "413051017", "story_v_out_413051.awb") / 1000

					if var_74_17 + var_74_11 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_17 + var_74_11
					end

					if var_74_13.prefab_name ~= "" and arg_71_1.actors_[var_74_13.prefab_name] ~= nil then
						local var_74_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_13.prefab_name].transform, "story_v_out_413051", "413051017", "story_v_out_413051.awb")

						arg_71_1:RecordAudio("413051017", var_74_18)
						arg_71_1:RecordAudio("413051017", var_74_18)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_413051", "413051017", "story_v_out_413051.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_413051", "413051017", "story_v_out_413051.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_19 = math.max(var_74_12, arg_71_1.talkMaxDuration)

			if var_74_11 <= arg_71_1.time_ and arg_71_1.time_ < var_74_11 + var_74_19 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_11) / var_74_19

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_11 + var_74_19 and arg_71_1.time_ < var_74_11 + var_74_19 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
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
				actorName = "10097",
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
	Play413051018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 413051018
		arg_75_1.duration_ = 8.2

		local var_75_0 = {
			zh = 8.2,
			ja = 8.066
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
				arg_75_0:Play413051019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.675

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:GetWordFromCfg(413051018)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 27 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 27)

				if (27 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 27)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051018", "story_v_out_413051.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051018", "story_v_out_413051.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_out_413051", "413051018", "story_v_out_413051.awb")

						arg_75_1:RecordAudio("413051018", var_78_6)
						arg_75_1:RecordAudio("413051018", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_413051", "413051018", "story_v_out_413051.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_413051", "413051018", "story_v_out_413051.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play413051019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 413051019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play413051020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10097 = arg_79_1.actors_["10097"].transform.localPosition
				arg_79_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10097", 7)

				for iter_82_0 = 0, arg_79_1.actors_["10097"].transform.childCount - 1 do
					local var_82_0 = arg_79_1.actors_["10097"].transform:GetChild(iter_82_0)

					if var_82_0.name == "" or not string.find(var_82_0.name, "split") then
						var_82_0.gameObject:SetActive(true)
					else
						var_82_0.gameObject:SetActive(false)
					end
				end
			end

			local var_82_1 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 then
				arg_79_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10097, Vector3.New(0, -2000, -180), (arg_79_1.time_ - 0) / var_82_1)
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 then
				arg_79_1.actors_["10097"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_82_2 = arg_79_1.actors_["10097"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.actorSpriteComps10097 == nil then
				arg_79_1.var_.actorSpriteComps10097 = var_82_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_3 = 2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 and not isNil(var_82_2) then
				if arg_79_1.var_.actorSpriteComps10097 then
					for iter_82_1, iter_82_2 in pairs(arg_79_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_82_2 then
							if arg_79_1.isInRecall_ then
								iter_82_2.color = Color.New(Mathf.Lerp(iter_82_2.color.r, arg_79_1.hightColor2.r, (arg_79_1.time_ - 0) / var_82_3), Mathf.Lerp(iter_82_2.color.g, arg_79_1.hightColor2.g, (arg_79_1.time_ - 0) / var_82_3), (Mathf.Lerp(iter_82_2.color.b, arg_79_1.hightColor2.b, (arg_79_1.time_ - 0) / var_82_3)))
							else
								local var_82_4 = Mathf.Lerp(iter_82_2.color.r, 0.5, (arg_79_1.time_ - 0) / var_82_3)

								iter_82_2.color = Color.New(var_82_4, var_82_4, var_82_4)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.actorSpriteComps10097 then
				for iter_82_3, iter_82_4 in pairs(arg_79_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_82_4 then
						iter_82_4.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_79_1.var_.actorSpriteComps10097 = nil
			end

			local var_82_5 = 0
			local var_82_6 = 1

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_7 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(413051019).content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 40 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_7) / 40)

				if (40 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_7) / 40)) > 0 and var_82_6 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_5
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_6, arg_79_1.talkMaxDuration)

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_5) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_5 + var_82_10 and arg_79_1.time_ < var_82_5 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
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
	Play413051020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 413051020
		arg_83_1.duration_ = 8.67

		local var_83_0 = {
			zh = 5.033,
			ja = 8.666
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play413051021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos10092 = arg_83_1.actors_["10092"].transform.localPosition
				arg_83_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("10092", 3)

				for iter_86_0 = 0, arg_83_1.actors_["10092"].transform.childCount - 1 do
					local var_86_0 = arg_83_1.actors_["10092"].transform:GetChild(iter_86_0)

					if var_86_0.name == "split_8" or not string.find(var_86_0.name, "split") then
						var_86_0.gameObject:SetActive(true)
					else
						var_86_0.gameObject:SetActive(false)
					end
				end
			end

			local var_86_1 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_1 then
				arg_83_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_83_1.time_ - 0) / var_86_1)
			end

			if arg_83_1.time_ >= 0 + var_86_1 and arg_83_1.time_ < 0 + var_86_1 + arg_86_0 then
				arg_83_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_86_2 = arg_83_1.actors_["10092"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps10092 == nil then
				arg_83_1.var_.actorSpriteComps10092 = var_86_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_3 = 2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_3 and not isNil(var_86_2) then
				if arg_83_1.var_.actorSpriteComps10092 then
					for iter_86_1, iter_86_2 in pairs(arg_83_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_86_2 then
							if arg_83_1.isInRecall_ then
								iter_86_2.color = Color.New(Mathf.Lerp(iter_86_2.color.r, arg_83_1.hightColor1.r, (arg_83_1.time_ - 0) / var_86_3), Mathf.Lerp(iter_86_2.color.g, arg_83_1.hightColor1.g, (arg_83_1.time_ - 0) / var_86_3), (Mathf.Lerp(iter_86_2.color.b, arg_83_1.hightColor1.b, (arg_83_1.time_ - 0) / var_86_3)))
							else
								local var_86_4 = Mathf.Lerp(iter_86_2.color.r, 1, (arg_83_1.time_ - 0) / var_86_3)

								iter_86_2.color = Color.New(var_86_4, var_86_4, var_86_4)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= 0 + var_86_3 and arg_83_1.time_ < 0 + var_86_3 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps10092 then
				for iter_86_3, iter_86_4 in pairs(arg_83_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_86_4 then
						iter_86_4.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_83_1.var_.actorSpriteComps10092 = nil
			end

			local var_86_5 = 0
			local var_86_6 = 0.575

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_7 = arg_83_1:GetWordFromCfg(413051020)
				local var_86_8 = arg_83_1:FormatText(var_86_7.content)

				arg_83_1.text_.text = var_86_8

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_10 = 23 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 23)

				if (23 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 23)) > 0 and var_86_6 < var_86_10 then
					arg_83_1.talkMaxDuration = var_86_10

					if var_86_10 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_5
					end
				end

				arg_83_1.text_.text = var_86_8
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051020", "story_v_out_413051.awb") ~= 0 then
					local var_86_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051020", "story_v_out_413051.awb") / 1000

					if var_86_11 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_5
					end

					if var_86_7.prefab_name ~= "" and arg_83_1.actors_[var_86_7.prefab_name] ~= nil then
						local var_86_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_7.prefab_name].transform, "story_v_out_413051", "413051020", "story_v_out_413051.awb")

						arg_83_1:RecordAudio("413051020", var_86_12)
						arg_83_1:RecordAudio("413051020", var_86_12)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_413051", "413051020", "story_v_out_413051.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_413051", "413051020", "story_v_out_413051.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_13 = math.max(var_86_6, arg_83_1.talkMaxDuration)

			if var_86_5 <= arg_83_1.time_ and arg_83_1.time_ < var_86_5 + var_86_13 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_5) / var_86_13

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_5 + var_86_13 and arg_83_1.time_ < var_86_5 + var_86_13 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
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

		arg_83_1:InitPlayNodeList()
	end,
	Play413051021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 413051021
		arg_87_1.duration_ = 6.87

		local var_87_0 = {
			zh = 6.866,
			ja = 5.866
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
				arg_87_0:Play413051022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0.9

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:GetWordFromCfg(413051021)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 36 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 36)

				if (36 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 36)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051021", "story_v_out_413051.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051021", "story_v_out_413051.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_out_413051", "413051021", "story_v_out_413051.awb")

						arg_87_1:RecordAudio("413051021", var_90_6)
						arg_87_1:RecordAudio("413051021", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_413051", "413051021", "story_v_out_413051.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_413051", "413051021", "story_v_out_413051.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_7 = math.max(var_90_0, arg_87_1.talkMaxDuration)

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - 0) / var_90_7

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play413051022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 413051022
		arg_91_1.duration_ = 12.3

		local var_91_0 = {
			zh = 8.666,
			ja = 12.3
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
				arg_91_0:Play413051023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.95

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

				local var_94_1 = arg_91_1:GetWordFromCfg(413051022)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 38 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 38)

				if (38 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 38)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051022", "story_v_out_413051.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051022", "story_v_out_413051.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_out_413051", "413051022", "story_v_out_413051.awb")

						arg_91_1:RecordAudio("413051022", var_94_6)
						arg_91_1:RecordAudio("413051022", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_413051", "413051022", "story_v_out_413051.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_413051", "413051022", "story_v_out_413051.awb")
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
	Play413051023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 413051023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play413051024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10092 = arg_95_1.actors_["10092"].transform.localPosition
				arg_95_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10092", 7)

				for iter_98_0 = 0, arg_95_1.actors_["10092"].transform.childCount - 1 do
					local var_98_0 = arg_95_1.actors_["10092"].transform:GetChild(iter_98_0)

					if var_98_0.name == "" or not string.find(var_98_0.name, "split") then
						var_98_0.gameObject:SetActive(true)
					else
						var_98_0.gameObject:SetActive(false)
					end
				end
			end

			local var_98_1 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_1 then
				arg_95_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_95_1.time_ - 0) / var_98_1)
			end

			if arg_95_1.time_ >= 0 + var_98_1 and arg_95_1.time_ < 0 + var_98_1 + arg_98_0 then
				arg_95_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_98_2 = arg_95_1.actors_["10097"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.actorSpriteComps10097 == nil then
				arg_95_1.var_.actorSpriteComps10097 = var_98_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_3 = 2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_3 and not isNil(var_98_2) then
				if arg_95_1.var_.actorSpriteComps10097 then
					for iter_98_1, iter_98_2 in pairs(arg_95_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_98_2 then
							if arg_95_1.isInRecall_ then
								iter_98_2.color = Color.New(Mathf.Lerp(iter_98_2.color.r, arg_95_1.hightColor2.r, (arg_95_1.time_ - 0) / var_98_3), Mathf.Lerp(iter_98_2.color.g, arg_95_1.hightColor2.g, (arg_95_1.time_ - 0) / var_98_3), (Mathf.Lerp(iter_98_2.color.b, arg_95_1.hightColor2.b, (arg_95_1.time_ - 0) / var_98_3)))
							else
								local var_98_4 = Mathf.Lerp(iter_98_2.color.r, 0.5, (arg_95_1.time_ - 0) / var_98_3)

								iter_98_2.color = Color.New(var_98_4, var_98_4, var_98_4)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= 0 + var_98_3 and arg_95_1.time_ < 0 + var_98_3 + arg_98_0 and not isNil(var_98_2) and arg_95_1.var_.actorSpriteComps10097 then
				for iter_98_3, iter_98_4 in pairs(arg_95_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_98_4 then
						iter_98_4.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_95_1.var_.actorSpriteComps10097 = nil
			end

			local var_98_5 = 0
			local var_98_6 = 0.75

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_7 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(413051023).content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 30 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_7) / 30)

				if (30 <= 0 and var_98_6 or var_98_6 * (utf8.len(var_98_7) / 30)) > 0 and var_98_6 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_5 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_5
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_6, arg_95_1.talkMaxDuration)

			if var_98_5 <= arg_95_1.time_ and arg_95_1.time_ < var_98_5 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_5) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_5 + var_98_10 and arg_95_1.time_ < var_98_5 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play413051024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 413051024
		arg_99_1.duration_ = 7.17

		local var_99_0 = {
			zh = 7.166,
			ja = 5.166
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
				arg_99_0:Play413051025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10097 = arg_99_1.actors_["10097"].transform.localPosition
				arg_99_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("10097", 3)

				for iter_102_0 = 0, arg_99_1.actors_["10097"].transform.childCount - 1 do
					local var_102_0 = arg_99_1.actors_["10097"].transform:GetChild(iter_102_0)

					if var_102_0.name == "split_2" or not string.find(var_102_0.name, "split") then
						var_102_0.gameObject:SetActive(true)
					else
						var_102_0.gameObject:SetActive(false)
					end
				end
			end

			local var_102_1 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_1 then
				arg_99_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_99_1.time_ - 0) / var_102_1)
			end

			if arg_99_1.time_ >= 0 + var_102_1 and arg_99_1.time_ < 0 + var_102_1 + arg_102_0 then
				arg_99_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_102_2 = arg_99_1.actors_["10097"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_2) and arg_99_1.var_.actorSpriteComps10097 == nil then
				arg_99_1.var_.actorSpriteComps10097 = var_102_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_3 = 2

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_3 and not isNil(var_102_2) then
				if arg_99_1.var_.actorSpriteComps10097 then
					for iter_102_1, iter_102_2 in pairs(arg_99_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_102_2 then
							if arg_99_1.isInRecall_ then
								iter_102_2.color = Color.New(Mathf.Lerp(iter_102_2.color.r, arg_99_1.hightColor1.r, (arg_99_1.time_ - 0) / var_102_3), Mathf.Lerp(iter_102_2.color.g, arg_99_1.hightColor1.g, (arg_99_1.time_ - 0) / var_102_3), (Mathf.Lerp(iter_102_2.color.b, arg_99_1.hightColor1.b, (arg_99_1.time_ - 0) / var_102_3)))
							else
								local var_102_4 = Mathf.Lerp(iter_102_2.color.r, 1, (arg_99_1.time_ - 0) / var_102_3)

								iter_102_2.color = Color.New(var_102_4, var_102_4, var_102_4)
							end
						end
					end
				end
			end

			if arg_99_1.time_ >= 0 + var_102_3 and arg_99_1.time_ < 0 + var_102_3 + arg_102_0 and not isNil(var_102_2) and arg_99_1.var_.actorSpriteComps10097 then
				for iter_102_3, iter_102_4 in pairs(arg_99_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_102_4 then
						iter_102_4.color = arg_99_1.isInRecall_ and (arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_99_1.var_.actorSpriteComps10097 = nil
			end

			local var_102_5 = 0
			local var_102_6 = 0.4

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_7 = arg_99_1:GetWordFromCfg(413051024)
				local var_102_8 = arg_99_1:FormatText(var_102_7.content)

				arg_99_1.text_.text = var_102_8

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_10 = 16 <= 0 and var_102_6 or var_102_6 * (utf8.len(var_102_8) / 16)

				if (16 <= 0 and var_102_6 or var_102_6 * (utf8.len(var_102_8) / 16)) > 0 and var_102_6 < var_102_10 then
					arg_99_1.talkMaxDuration = var_102_10

					if var_102_10 + var_102_5 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_5
					end
				end

				arg_99_1.text_.text = var_102_8
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051024", "story_v_out_413051.awb") ~= 0 then
					local var_102_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051024", "story_v_out_413051.awb") / 1000

					if var_102_11 + var_102_5 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_11 + var_102_5
					end

					if var_102_7.prefab_name ~= "" and arg_99_1.actors_[var_102_7.prefab_name] ~= nil then
						local var_102_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_7.prefab_name].transform, "story_v_out_413051", "413051024", "story_v_out_413051.awb")

						arg_99_1:RecordAudio("413051024", var_102_12)
						arg_99_1:RecordAudio("413051024", var_102_12)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_413051", "413051024", "story_v_out_413051.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_413051", "413051024", "story_v_out_413051.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_13 = math.max(var_102_6, arg_99_1.talkMaxDuration)

			if var_102_5 <= arg_99_1.time_ and arg_99_1.time_ < var_102_5 + var_102_13 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_5) / var_102_13

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_5 + var_102_13 and arg_99_1.time_ < var_102_5 + var_102_13 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play413051025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 413051025
		arg_103_1.duration_ = 10.93

		local var_103_0 = {
			zh = 10.932999999999,
			ja = 9.865999999999
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
				arg_103_0:Play413051026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if arg_103_1.bgs_.F10f == nil then
				local var_106_0 = Object.Instantiate(arg_103_1.paintGo_)

				var_106_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F10f")
				var_106_0.name = "F10f"
				var_106_0.transform.parent = arg_103_1.stage_.transform
				var_106_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_103_1.bgs_.F10f = var_106_0
			end

			if 2 < arg_103_1.time_ and arg_103_1.time_ <= 2 + arg_106_0 then
				local var_106_1 = arg_103_1.bgs_.F10f

				arg_103_1.bgs_.F10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_106_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_106_2 = var_106_1:GetComponent("SpriteRenderer")

				if var_106_2 and var_106_2.sprite then
					local var_106_3 = 2 * (var_106_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_106_1.transform.localScale = Vector3.New(var_106_3 / var_106_2.sprite.bounds.size.y < var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x and var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x or var_106_3 / var_106_2.sprite.bounds.size.y, var_106_3 / var_106_2.sprite.bounds.size.y < var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x and var_106_3 * manager.ui.mainCameraCom_.aspect / var_106_2.sprite.bounds.size.x or var_106_3 / var_106_2.sprite.bounds.size.y, 0)
				end

				for iter_106_0, iter_106_1 in pairs(arg_103_1.bgs_) do
					if iter_106_0 ~= "F10f" then
						iter_106_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_106_4 = 3.999999999999

			if 3.999999999999 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.allBtn_.enabled = false
			end

			if arg_103_1.time_ >= var_106_4 + 0.3 and arg_103_1.time_ < var_106_4 + 0.3 + arg_106_0 then
				arg_103_1.allBtn_.enabled = true
			end

			local var_106_5 = 0

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_6 = 2

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_6 then
				local var_106_7 = Color.New(0, 0, 0)

				var_106_7.a = Mathf.Lerp(0, 1, (arg_103_1.time_ - var_106_5) / var_106_6)
				arg_103_1.mask_.color = var_106_7
			end

			if arg_103_1.time_ >= var_106_5 + var_106_6 and arg_103_1.time_ < var_106_5 + var_106_6 + arg_106_0 then
				local var_106_8 = Color.New(0, 0, 0)

				var_106_8.a = 1
				arg_103_1.mask_.color = var_106_8
			end

			local var_106_9 = 2

			if 2 < arg_103_1.time_ and arg_103_1.time_ <= var_106_9 + arg_106_0 then
				arg_103_1.mask_.enabled = true
				arg_103_1.mask_.raycastTarget = true

				arg_103_1:SetGaussion(false)
			end

			local var_106_10 = 2

			if var_106_9 <= arg_103_1.time_ and arg_103_1.time_ < var_106_9 + var_106_10 then
				local var_106_11 = Color.New(0, 0, 0)

				var_106_11.a = Mathf.Lerp(1, 0, (arg_103_1.time_ - var_106_9) / var_106_10)
				arg_103_1.mask_.color = var_106_11
			end

			if arg_103_1.time_ >= var_106_9 + var_106_10 and arg_103_1.time_ < var_106_9 + var_106_10 + arg_106_0 then
				local var_106_12 = Color.New(0, 0, 0)

				arg_103_1.mask_.enabled = false
				var_106_12.a = 0
				arg_103_1.mask_.color = var_106_12
			end

			local var_106_13 = arg_103_1.actors_["10097"].transform

			if 1.966 < arg_103_1.time_ and arg_103_1.time_ <= 1.966 + arg_106_0 then
				arg_103_1.var_.moveOldPos10097 = var_106_13.localPosition
				var_106_13.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("10097", 0)

				for iter_106_2 = 0, var_106_13.childCount - 1 do
					local var_106_14 = var_106_13:GetChild(iter_106_2)

					if var_106_14.name == "" or not string.find(var_106_14.name, "split") then
						var_106_14.gameObject:SetActive(true)
					else
						var_106_14.gameObject:SetActive(false)
					end
				end
			end

			local var_106_15 = 0.001

			if 1.966 <= arg_103_1.time_ and arg_103_1.time_ < 1.966 + var_106_15 then
				var_106_13.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10097, Vector3.New(-1500, -350, -180), (arg_103_1.time_ - 1.966) / var_106_15)
			end

			if arg_103_1.time_ >= 1.966 + var_106_15 and arg_103_1.time_ < 1.966 + var_106_15 + arg_106_0 then
				var_106_13.localPosition = Vector3.New(-1500, -350, -180)
			end

			local var_106_16 = arg_103_1.actors_["10097"]

			if 1.966 < arg_103_1.time_ and arg_103_1.time_ <= 1.966 + arg_106_0 and not isNil(var_106_16) and arg_103_1.var_.actorSpriteComps10097 == nil then
				arg_103_1.var_.actorSpriteComps10097 = var_106_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_17 = 0.034

			if 1.966 <= arg_103_1.time_ and arg_103_1.time_ < 1.966 + var_106_17 and not isNil(var_106_16) then
				if arg_103_1.var_.actorSpriteComps10097 then
					for iter_106_3, iter_106_4 in pairs(arg_103_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_106_4 then
							if arg_103_1.isInRecall_ then
								iter_106_4.color = Color.New(Mathf.Lerp(iter_106_4.color.r, arg_103_1.hightColor2.r, (arg_103_1.time_ - 1.966) / var_106_17), Mathf.Lerp(iter_106_4.color.g, arg_103_1.hightColor2.g, (arg_103_1.time_ - 1.966) / var_106_17), (Mathf.Lerp(iter_106_4.color.b, arg_103_1.hightColor2.b, (arg_103_1.time_ - 1.966) / var_106_17)))
							else
								local var_106_18 = Mathf.Lerp(iter_106_4.color.r, 0.5, (arg_103_1.time_ - 1.966) / var_106_17)

								iter_106_4.color = Color.New(var_106_18, var_106_18, var_106_18)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 1.966 + var_106_17 and arg_103_1.time_ < 1.966 + var_106_17 + arg_106_0 and not isNil(var_106_16) and arg_103_1.var_.actorSpriteComps10097 then
				for iter_106_5, iter_106_6 in pairs(arg_103_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_106_6 then
						iter_106_6.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_103_1.var_.actorSpriteComps10097 = nil
			end

			if arg_103_1.frameCnt_ <= 1 then
				arg_103_1.dialog_:SetActive(false)
			end

			local var_106_19 = 3.999999999999
			local var_106_20 = 1

			if 3.999999999999 < arg_103_1.time_ and arg_103_1.time_ <= var_106_19 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0

				arg_103_1.dialog_:SetActive(true)

				arg_103_1.dialogCg_.alpha = 0

				local var_106_21 = LeanTween.value(arg_103_1.dialog_, 0, 1, 0.3)

				var_106_21:setOnUpdate(LuaHelper.FloatAction(function(arg_107_0)
					arg_103_1.dialogCg_.alpha = arg_107_0
				end))
				var_106_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_103_1.dialog_)
					var_106_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_103_1.duration_ = arg_103_1.duration_ + 0.3

				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_22 = arg_103_1:GetWordFromCfg(413051025)
				local var_106_23 = arg_103_1:FormatText(var_106_22.content)

				arg_103_1.text_.text = var_106_23

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_25 = 40 <= 0 and var_106_20 or var_106_20 * (utf8.len(var_106_23) / 40)

				if (40 <= 0 and var_106_20 or var_106_20 * (utf8.len(var_106_23) / 40)) > 0 and var_106_20 < var_106_25 then
					arg_103_1.talkMaxDuration = var_106_25
					var_106_19 = var_106_19 + 0.3

					if var_106_25 + var_106_19 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_25 + var_106_19
					end
				end

				arg_103_1.text_.text = var_106_23
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051025", "story_v_out_413051.awb") ~= 0 then
					local var_106_26 = manager.audio:GetVoiceLength("story_v_out_413051", "413051025", "story_v_out_413051.awb") / 1000

					if var_106_26 + var_106_19 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_26 + var_106_19
					end

					if var_106_22.prefab_name ~= "" and arg_103_1.actors_[var_106_22.prefab_name] ~= nil then
						local var_106_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_22.prefab_name].transform, "story_v_out_413051", "413051025", "story_v_out_413051.awb")

						arg_103_1:RecordAudio("413051025", var_106_27)
						arg_103_1:RecordAudio("413051025", var_106_27)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_413051", "413051025", "story_v_out_413051.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_413051", "413051025", "story_v_out_413051.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_28 = var_106_19 + 0.3
			local var_106_29 = math.max(var_106_20, arg_103_1.talkMaxDuration)

			if var_106_19 + 0.3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_28 + var_106_29 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_28) / var_106_29

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_28 + var_106_29 and arg_103_1.time_ < var_106_28 + var_106_29 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play413051026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413051026
		arg_109_1.duration_ = 7.77

		local var_109_0 = {
			zh = 6.466,
			ja = 7.766
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
				arg_109_0:Play413051027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.875

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_1 = arg_109_1:GetWordFromCfg(413051026)
				local var_112_2 = arg_109_1:FormatText(var_112_1.content)

				arg_109_1.text_.text = var_112_2

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_4 = 35 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 35)

				if (35 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_2) / 35)) > 0 and var_112_0 < var_112_4 then
					arg_109_1.talkMaxDuration = var_112_4

					if var_112_4 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_4 + 0
					end
				end

				arg_109_1.text_.text = var_112_2
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051026", "story_v_out_413051.awb") ~= 0 then
					local var_112_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051026", "story_v_out_413051.awb") / 1000

					if var_112_5 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_5 + 0
					end

					if var_112_1.prefab_name ~= "" and arg_109_1.actors_[var_112_1.prefab_name] ~= nil then
						local var_112_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_1.prefab_name].transform, "story_v_out_413051", "413051026", "story_v_out_413051.awb")

						arg_109_1:RecordAudio("413051026", var_112_6)
						arg_109_1:RecordAudio("413051026", var_112_6)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_413051", "413051026", "story_v_out_413051.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_413051", "413051026", "story_v_out_413051.awb")
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
	Play413051027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413051027
		arg_113_1.duration_ = 2

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play413051028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10094 = arg_113_1.actors_["10094"].transform.localPosition
				arg_113_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10094", 3)

				for iter_116_0 = 0, arg_113_1.actors_["10094"].transform.childCount - 1 do
					local var_116_0 = arg_113_1.actors_["10094"].transform:GetChild(iter_116_0)

					if var_116_0.name == "" or not string.find(var_116_0.name, "split") then
						var_116_0.gameObject:SetActive(true)
					else
						var_116_0.gameObject:SetActive(false)
					end
				end
			end

			local var_116_1 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 then
				arg_113_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_113_1.time_ - 0) / var_116_1)
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 then
				arg_113_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_116_2 = arg_113_1.actors_["10094"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps10094 == nil then
				arg_113_1.var_.actorSpriteComps10094 = var_116_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_3 = 2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.actorSpriteComps10094 then
					for iter_116_1, iter_116_2 in pairs(arg_113_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_116_2 then
							if arg_113_1.isInRecall_ then
								iter_116_2.color = Color.New(Mathf.Lerp(iter_116_2.color.r, arg_113_1.hightColor1.r, (arg_113_1.time_ - 0) / var_116_3), Mathf.Lerp(iter_116_2.color.g, arg_113_1.hightColor1.g, (arg_113_1.time_ - 0) / var_116_3), (Mathf.Lerp(iter_116_2.color.b, arg_113_1.hightColor1.b, (arg_113_1.time_ - 0) / var_116_3)))
							else
								local var_116_4 = Mathf.Lerp(iter_116_2.color.r, 1, (arg_113_1.time_ - 0) / var_116_3)

								iter_116_2.color = Color.New(var_116_4, var_116_4, var_116_4)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps10094 then
				for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_116_4 then
						iter_116_4.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_113_1.var_.actorSpriteComps10094 = nil
			end

			local var_116_5 = 0
			local var_116_6 = 0.2

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_7 = arg_113_1:GetWordFromCfg(413051027)
				local var_116_8 = arg_113_1:FormatText(var_116_7.content)

				arg_113_1.text_.text = var_116_8

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_10 = 8 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_8) / 8)

				if (8 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_8) / 8)) > 0 and var_116_6 < var_116_10 then
					arg_113_1.talkMaxDuration = var_116_10

					if var_116_10 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_5
					end
				end

				arg_113_1.text_.text = var_116_8
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051027", "story_v_out_413051.awb") ~= 0 then
					local var_116_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051027", "story_v_out_413051.awb") / 1000

					if var_116_11 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_5
					end

					if var_116_7.prefab_name ~= "" and arg_113_1.actors_[var_116_7.prefab_name] ~= nil then
						local var_116_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_7.prefab_name].transform, "story_v_out_413051", "413051027", "story_v_out_413051.awb")

						arg_113_1:RecordAudio("413051027", var_116_12)
						arg_113_1:RecordAudio("413051027", var_116_12)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_413051", "413051027", "story_v_out_413051.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_413051", "413051027", "story_v_out_413051.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_13 = math.max(var_116_6, arg_113_1.talkMaxDuration)

			if var_116_5 <= arg_113_1.time_ and arg_113_1.time_ < var_116_5 + var_116_13 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_5) / var_116_13

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_5 + var_116_13 and arg_113_1.time_ < var_116_5 + var_116_13 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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

		arg_113_1:InitPlayNodeList()
	end,
	Play413051028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 413051028
		arg_117_1.duration_ = 7.83

		local var_117_0 = {
			zh = 7.833,
			ja = 6.6
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play413051029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10094 = arg_117_1.actors_["10094"].transform.localPosition
				arg_117_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10094", 3)

				for iter_120_0 = 0, arg_117_1.actors_["10094"].transform.childCount - 1 do
					local var_120_0 = arg_117_1.actors_["10094"].transform:GetChild(iter_120_0)

					if var_120_0.name == "" or not string.find(var_120_0.name, "split") then
						var_120_0.gameObject:SetActive(true)
					else
						var_120_0.gameObject:SetActive(false)
					end
				end
			end

			local var_120_1 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 then
				arg_117_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_117_1.time_ - 0) / var_120_1)
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 then
				arg_117_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_120_2 = arg_117_1.actors_["10094"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps10094 == nil then
				arg_117_1.var_.actorSpriteComps10094 = var_120_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_3 = 2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.actorSpriteComps10094 then
					for iter_120_1, iter_120_2 in pairs(arg_117_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_120_2 then
							if arg_117_1.isInRecall_ then
								iter_120_2.color = Color.New(Mathf.Lerp(iter_120_2.color.r, arg_117_1.hightColor2.r, (arg_117_1.time_ - 0) / var_120_3), Mathf.Lerp(iter_120_2.color.g, arg_117_1.hightColor2.g, (arg_117_1.time_ - 0) / var_120_3), (Mathf.Lerp(iter_120_2.color.b, arg_117_1.hightColor2.b, (arg_117_1.time_ - 0) / var_120_3)))
							else
								local var_120_4 = Mathf.Lerp(iter_120_2.color.r, 0.5, (arg_117_1.time_ - 0) / var_120_3)

								iter_120_2.color = Color.New(var_120_4, var_120_4, var_120_4)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps10094 then
				for iter_120_3, iter_120_4 in pairs(arg_117_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_120_4 then
						iter_120_4.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps10094 = nil
			end

			local var_120_5 = 0
			local var_120_6 = 1.125

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_7 = arg_117_1:GetWordFromCfg(413051028)
				local var_120_8 = arg_117_1:FormatText(var_120_7.content)

				arg_117_1.text_.text = var_120_8

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_10 = 45 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_8) / 45)

				if (45 <= 0 and var_120_6 or var_120_6 * (utf8.len(var_120_8) / 45)) > 0 and var_120_6 < var_120_10 then
					arg_117_1.talkMaxDuration = var_120_10

					if var_120_10 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_10 + var_120_5
					end
				end

				arg_117_1.text_.text = var_120_8
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051028", "story_v_out_413051.awb") ~= 0 then
					local var_120_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051028", "story_v_out_413051.awb") / 1000

					if var_120_11 + var_120_5 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_5
					end

					if var_120_7.prefab_name ~= "" and arg_117_1.actors_[var_120_7.prefab_name] ~= nil then
						local var_120_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_7.prefab_name].transform, "story_v_out_413051", "413051028", "story_v_out_413051.awb")

						arg_117_1:RecordAudio("413051028", var_120_12)
						arg_117_1:RecordAudio("413051028", var_120_12)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_413051", "413051028", "story_v_out_413051.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_413051", "413051028", "story_v_out_413051.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_13 = math.max(var_120_6, arg_117_1.talkMaxDuration)

			if var_120_5 <= arg_117_1.time_ and arg_117_1.time_ < var_120_5 + var_120_13 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_5) / var_120_13

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_5 + var_120_13 and arg_117_1.time_ < var_120_5 + var_120_13 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play413051029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 413051029
		arg_121_1.duration_ = 13.97

		local var_121_0 = {
			zh = 6,
			ja = 13.966
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play413051030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0.775

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_1 = arg_121_1:GetWordFromCfg(413051029)
				local var_124_2 = arg_121_1:FormatText(var_124_1.content)

				arg_121_1.text_.text = var_124_2

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_4 = 31 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 31)

				if (31 <= 0 and var_124_0 or var_124_0 * (utf8.len(var_124_2) / 31)) > 0 and var_124_0 < var_124_4 then
					arg_121_1.talkMaxDuration = var_124_4

					if var_124_4 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_4 + 0
					end
				end

				arg_121_1.text_.text = var_124_2
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051029", "story_v_out_413051.awb") ~= 0 then
					local var_124_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051029", "story_v_out_413051.awb") / 1000

					if var_124_5 + 0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_5 + 0
					end

					if var_124_1.prefab_name ~= "" and arg_121_1.actors_[var_124_1.prefab_name] ~= nil then
						local var_124_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_1.prefab_name].transform, "story_v_out_413051", "413051029", "story_v_out_413051.awb")

						arg_121_1:RecordAudio("413051029", var_124_6)
						arg_121_1:RecordAudio("413051029", var_124_6)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_413051", "413051029", "story_v_out_413051.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_413051", "413051029", "story_v_out_413051.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_0, arg_121_1.talkMaxDuration)

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - 0) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play413051030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 413051030
		arg_125_1.duration_ = 4.43

		local var_125_0 = {
			zh = 3.8,
			ja = 4.433
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play413051031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0.55

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_1 = arg_125_1:GetWordFromCfg(413051030)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 22 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 22)

				if (22 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 22)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051030", "story_v_out_413051.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051030", "story_v_out_413051.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_413051", "413051030", "story_v_out_413051.awb")

						arg_125_1:RecordAudio("413051030", var_128_6)
						arg_125_1:RecordAudio("413051030", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_413051", "413051030", "story_v_out_413051.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_413051", "413051030", "story_v_out_413051.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_7 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_7 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_7

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_7 and arg_125_1.time_ < 0 + var_128_7 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play413051031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 413051031
		arg_129_1.duration_ = 8.77

		local var_129_0 = {
			zh = 8.066,
			ja = 8.766
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
				arg_129_0:Play413051032(arg_129_1)
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

			local var_132_3 = 2

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

			local var_132_5 = 0
			local var_132_6 = 0.825

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
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

				local var_132_7 = arg_129_1:GetWordFromCfg(413051031)
				local var_132_8 = arg_129_1:FormatText(var_132_7.content)

				arg_129_1.text_.text = var_132_8

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 33 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_8) / 33)

				if (33 <= 0 and var_132_6 or var_132_6 * (utf8.len(var_132_8) / 33)) > 0 and var_132_6 < var_132_10 then
					arg_129_1.talkMaxDuration = var_132_10

					if var_132_10 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_10 + var_132_5
					end
				end

				arg_129_1.text_.text = var_132_8
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051031", "story_v_out_413051.awb") ~= 0 then
					local var_132_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051031", "story_v_out_413051.awb") / 1000

					if var_132_11 + var_132_5 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_5
					end

					if var_132_7.prefab_name ~= "" and arg_129_1.actors_[var_132_7.prefab_name] ~= nil then
						local var_132_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_7.prefab_name].transform, "story_v_out_413051", "413051031", "story_v_out_413051.awb")

						arg_129_1:RecordAudio("413051031", var_132_12)
						arg_129_1:RecordAudio("413051031", var_132_12)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_413051", "413051031", "story_v_out_413051.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_413051", "413051031", "story_v_out_413051.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_13 = math.max(var_132_6, arg_129_1.talkMaxDuration)

			if var_132_5 <= arg_129_1.time_ and arg_129_1.time_ < var_132_5 + var_132_13 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_5) / var_132_13

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_5 + var_132_13 and arg_129_1.time_ < var_132_5 + var_132_13 + arg_132_0 then
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
	Play413051032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 413051032
		arg_133_1.duration_ = 2.4

		local var_133_0 = {
			zh = 1.999999999999,
			ja = 2.4
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play413051033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10094 = arg_133_1.actors_["10094"].transform.localPosition
				arg_133_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10094", 3)

				for iter_136_0 = 0, arg_133_1.actors_["10094"].transform.childCount - 1 do
					local var_136_0 = arg_133_1.actors_["10094"].transform:GetChild(iter_136_0)

					if var_136_0.name == "" or not string.find(var_136_0.name, "split") then
						var_136_0.gameObject:SetActive(true)
					else
						var_136_0.gameObject:SetActive(false)
					end
				end
			end

			local var_136_1 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 then
				arg_133_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_133_1.time_ - 0) / var_136_1)
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 then
				arg_133_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_136_2 = arg_133_1.actors_["10094"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps10094 == nil then
				arg_133_1.var_.actorSpriteComps10094 = var_136_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_3 = 2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.actorSpriteComps10094 then
					for iter_136_1, iter_136_2 in pairs(arg_133_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_136_2 then
							if arg_133_1.isInRecall_ then
								iter_136_2.color = Color.New(Mathf.Lerp(iter_136_2.color.r, arg_133_1.hightColor2.r, (arg_133_1.time_ - 0) / var_136_3), Mathf.Lerp(iter_136_2.color.g, arg_133_1.hightColor2.g, (arg_133_1.time_ - 0) / var_136_3), (Mathf.Lerp(iter_136_2.color.b, arg_133_1.hightColor2.b, (arg_133_1.time_ - 0) / var_136_3)))
							else
								local var_136_4 = Mathf.Lerp(iter_136_2.color.r, 0.5, (arg_133_1.time_ - 0) / var_136_3)

								iter_136_2.color = Color.New(var_136_4, var_136_4, var_136_4)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps10094 then
				for iter_136_3, iter_136_4 in pairs(arg_133_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_136_4 then
						iter_136_4.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_133_1.var_.actorSpriteComps10094 = nil
			end

			local var_136_5 = 0
			local var_136_6 = 0.125

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_7 = arg_133_1:GetWordFromCfg(413051032)
				local var_136_8 = arg_133_1:FormatText(var_136_7.content)

				arg_133_1.text_.text = var_136_8

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_10 = 5 <= 0 and var_136_6 or var_136_6 * (utf8.len(var_136_8) / 5)

				if (5 <= 0 and var_136_6 or var_136_6 * (utf8.len(var_136_8) / 5)) > 0 and var_136_6 < var_136_10 then
					arg_133_1.talkMaxDuration = var_136_10

					if var_136_10 + var_136_5 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_10 + var_136_5
					end
				end

				arg_133_1.text_.text = var_136_8
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051032", "story_v_out_413051.awb") ~= 0 then
					local var_136_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051032", "story_v_out_413051.awb") / 1000

					if var_136_11 + var_136_5 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_5
					end

					if var_136_7.prefab_name ~= "" and arg_133_1.actors_[var_136_7.prefab_name] ~= nil then
						local var_136_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_7.prefab_name].transform, "story_v_out_413051", "413051032", "story_v_out_413051.awb")

						arg_133_1:RecordAudio("413051032", var_136_12)
						arg_133_1:RecordAudio("413051032", var_136_12)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_413051", "413051032", "story_v_out_413051.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_413051", "413051032", "story_v_out_413051.awb")
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
				actorName = "10094",
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
	Play413051033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 413051033
		arg_137_1.duration_ = 6.17

		local var_137_0 = {
			zh = 2.866,
			ja = 6.166
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
				arg_137_0:Play413051034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10094 = arg_137_1.actors_["10094"].transform.localPosition
				arg_137_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10094", 3)

				for iter_140_0 = 0, arg_137_1.actors_["10094"].transform.childCount - 1 do
					local var_140_0 = arg_137_1.actors_["10094"].transform:GetChild(iter_140_0)

					if var_140_0.name == "" or not string.find(var_140_0.name, "split") then
						var_140_0.gameObject:SetActive(true)
					else
						var_140_0.gameObject:SetActive(false)
					end
				end
			end

			local var_140_1 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 then
				arg_137_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_137_1.time_ - 0) / var_140_1)
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 then
				arg_137_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_140_2 = arg_137_1.actors_["10094"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps10094 == nil then
				arg_137_1.var_.actorSpriteComps10094 = var_140_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_3 = 2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.actorSpriteComps10094 then
					for iter_140_1, iter_140_2 in pairs(arg_137_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_140_2 then
							if arg_137_1.isInRecall_ then
								iter_140_2.color = Color.New(Mathf.Lerp(iter_140_2.color.r, arg_137_1.hightColor1.r, (arg_137_1.time_ - 0) / var_140_3), Mathf.Lerp(iter_140_2.color.g, arg_137_1.hightColor1.g, (arg_137_1.time_ - 0) / var_140_3), (Mathf.Lerp(iter_140_2.color.b, arg_137_1.hightColor1.b, (arg_137_1.time_ - 0) / var_140_3)))
							else
								local var_140_4 = Mathf.Lerp(iter_140_2.color.r, 1, (arg_137_1.time_ - 0) / var_140_3)

								iter_140_2.color = Color.New(var_140_4, var_140_4, var_140_4)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps10094 then
				for iter_140_3, iter_140_4 in pairs(arg_137_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_140_4 then
						iter_140_4.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_137_1.var_.actorSpriteComps10094 = nil
			end

			local var_140_5 = 0
			local var_140_6 = 0.275

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_7 = arg_137_1:GetWordFromCfg(413051033)
				local var_140_8 = arg_137_1:FormatText(var_140_7.content)

				arg_137_1.text_.text = var_140_8

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_10 = 11 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 11)

				if (11 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 11)) > 0 and var_140_6 < var_140_10 then
					arg_137_1.talkMaxDuration = var_140_10

					if var_140_10 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_5
					end
				end

				arg_137_1.text_.text = var_140_8
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051033", "story_v_out_413051.awb") ~= 0 then
					local var_140_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051033", "story_v_out_413051.awb") / 1000

					if var_140_11 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_5
					end

					if var_140_7.prefab_name ~= "" and arg_137_1.actors_[var_140_7.prefab_name] ~= nil then
						local var_140_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_7.prefab_name].transform, "story_v_out_413051", "413051033", "story_v_out_413051.awb")

						arg_137_1:RecordAudio("413051033", var_140_12)
						arg_137_1:RecordAudio("413051033", var_140_12)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_413051", "413051033", "story_v_out_413051.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_413051", "413051033", "story_v_out_413051.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_13 = math.max(var_140_6, arg_137_1.talkMaxDuration)

			if var_140_5 <= arg_137_1.time_ and arg_137_1.time_ < var_140_5 + var_140_13 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_5) / var_140_13

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_5 + var_140_13 and arg_137_1.time_ < var_140_5 + var_140_13 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
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

		arg_137_1:InitPlayNodeList()
	end,
	Play413051034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 413051034
		arg_141_1.duration_ = 8.47

		local var_141_0 = {
			zh = 5.666,
			ja = 8.466
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
				arg_141_0:Play413051035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10094 = arg_141_1.actors_["10094"].transform.localPosition
				arg_141_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10094", 3)

				for iter_144_0 = 0, arg_141_1.actors_["10094"].transform.childCount - 1 do
					local var_144_0 = arg_141_1.actors_["10094"].transform:GetChild(iter_144_0)

					if var_144_0.name == "" or not string.find(var_144_0.name, "split") then
						var_144_0.gameObject:SetActive(true)
					else
						var_144_0.gameObject:SetActive(false)
					end
				end
			end

			local var_144_1 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 then
				arg_141_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_141_1.time_ - 0) / var_144_1)
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_144_2 = arg_141_1.actors_["10094"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps10094 == nil then
				arg_141_1.var_.actorSpriteComps10094 = var_144_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_3 = 2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.actorSpriteComps10094 then
					for iter_144_1, iter_144_2 in pairs(arg_141_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_144_2 then
							if arg_141_1.isInRecall_ then
								iter_144_2.color = Color.New(Mathf.Lerp(iter_144_2.color.r, arg_141_1.hightColor2.r, (arg_141_1.time_ - 0) / var_144_3), Mathf.Lerp(iter_144_2.color.g, arg_141_1.hightColor2.g, (arg_141_1.time_ - 0) / var_144_3), (Mathf.Lerp(iter_144_2.color.b, arg_141_1.hightColor2.b, (arg_141_1.time_ - 0) / var_144_3)))
							else
								local var_144_4 = Mathf.Lerp(iter_144_2.color.r, 0.5, (arg_141_1.time_ - 0) / var_144_3)

								iter_144_2.color = Color.New(var_144_4, var_144_4, var_144_4)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps10094 then
				for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_144_4 then
						iter_144_4.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_141_1.var_.actorSpriteComps10094 = nil
			end

			local var_144_5 = 0
			local var_144_6 = 0.6

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_7 = arg_141_1:GetWordFromCfg(413051034)
				local var_144_8 = arg_141_1:FormatText(var_144_7.content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 24 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 24)

				if (24 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 24)) > 0 and var_144_6 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051034", "story_v_out_413051.awb") ~= 0 then
					local var_144_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051034", "story_v_out_413051.awb") / 1000

					if var_144_11 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_5
					end

					if var_144_7.prefab_name ~= "" and arg_141_1.actors_[var_144_7.prefab_name] ~= nil then
						local var_144_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_7.prefab_name].transform, "story_v_out_413051", "413051034", "story_v_out_413051.awb")

						arg_141_1:RecordAudio("413051034", var_144_12)
						arg_141_1:RecordAudio("413051034", var_144_12)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_413051", "413051034", "story_v_out_413051.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_413051", "413051034", "story_v_out_413051.awb")
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
				actorName = "10094",
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
	Play413051035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 413051035
		arg_145_1.duration_ = 14.57

		local var_145_0 = {
			zh = 7.366,
			ja = 14.566
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
				arg_145_0:Play413051036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.9

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:GetWordFromCfg(413051035)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 36 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 36)

				if (36 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 36)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051035", "story_v_out_413051.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051035", "story_v_out_413051.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_413051", "413051035", "story_v_out_413051.awb")

						arg_145_1:RecordAudio("413051035", var_148_6)
						arg_145_1:RecordAudio("413051035", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_413051", "413051035", "story_v_out_413051.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_413051", "413051035", "story_v_out_413051.awb")
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
	Play413051036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 413051036
		arg_149_1.duration_ = 7

		local var_149_0 = {
			zh = 3.066,
			ja = 7
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
				arg_149_0:Play413051037(arg_149_1)
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
			local var_152_6 = 0.35

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

				local var_152_7 = arg_149_1:GetWordFromCfg(413051036)
				local var_152_8 = arg_149_1:FormatText(var_152_7.content)

				arg_149_1.text_.text = var_152_8

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_10 = 14 <= 0 and var_152_6 or var_152_6 * (utf8.len(var_152_8) / 14)

				if (14 <= 0 and var_152_6 or var_152_6 * (utf8.len(var_152_8) / 14)) > 0 and var_152_6 < var_152_10 then
					arg_149_1.talkMaxDuration = var_152_10

					if var_152_10 + var_152_5 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_5
					end
				end

				arg_149_1.text_.text = var_152_8
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051036", "story_v_out_413051.awb") ~= 0 then
					local var_152_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051036", "story_v_out_413051.awb") / 1000

					if var_152_11 + var_152_5 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_5
					end

					if var_152_7.prefab_name ~= "" and arg_149_1.actors_[var_152_7.prefab_name] ~= nil then
						local var_152_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_7.prefab_name].transform, "story_v_out_413051", "413051036", "story_v_out_413051.awb")

						arg_149_1:RecordAudio("413051036", var_152_12)
						arg_149_1:RecordAudio("413051036", var_152_12)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_413051", "413051036", "story_v_out_413051.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_413051", "413051036", "story_v_out_413051.awb")
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
	Play413051037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 413051037
		arg_153_1.duration_ = 5.67

		local var_153_0 = {
			zh = 3.1,
			ja = 5.666
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
				arg_153_0:Play413051038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10094 = arg_153_1.actors_["10094"].transform.localPosition
				arg_153_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10094", 3)

				for iter_156_0 = 0, arg_153_1.actors_["10094"].transform.childCount - 1 do
					local var_156_0 = arg_153_1.actors_["10094"].transform:GetChild(iter_156_0)

					if var_156_0.name == "" or not string.find(var_156_0.name, "split") then
						var_156_0.gameObject:SetActive(true)
					else
						var_156_0.gameObject:SetActive(false)
					end
				end
			end

			local var_156_1 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_1 then
				arg_153_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_153_1.time_ - 0) / var_156_1)
			end

			if arg_153_1.time_ >= 0 + var_156_1 and arg_153_1.time_ < 0 + var_156_1 + arg_156_0 then
				arg_153_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_156_2 = arg_153_1.actors_["10094"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps10094 == nil then
				arg_153_1.var_.actorSpriteComps10094 = var_156_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_3 = 2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.actorSpriteComps10094 then
					for iter_156_1, iter_156_2 in pairs(arg_153_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_156_2 then
							if arg_153_1.isInRecall_ then
								iter_156_2.color = Color.New(Mathf.Lerp(iter_156_2.color.r, arg_153_1.hightColor2.r, (arg_153_1.time_ - 0) / var_156_3), Mathf.Lerp(iter_156_2.color.g, arg_153_1.hightColor2.g, (arg_153_1.time_ - 0) / var_156_3), (Mathf.Lerp(iter_156_2.color.b, arg_153_1.hightColor2.b, (arg_153_1.time_ - 0) / var_156_3)))
							else
								local var_156_4 = Mathf.Lerp(iter_156_2.color.r, 0.5, (arg_153_1.time_ - 0) / var_156_3)

								iter_156_2.color = Color.New(var_156_4, var_156_4, var_156_4)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps10094 then
				for iter_156_3, iter_156_4 in pairs(arg_153_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_156_4 then
						iter_156_4.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_153_1.var_.actorSpriteComps10094 = nil
			end

			local var_156_5 = 0
			local var_156_6 = 0.35

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_7 = arg_153_1:GetWordFromCfg(413051037)
				local var_156_8 = arg_153_1:FormatText(var_156_7.content)

				arg_153_1.text_.text = var_156_8

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_10 = 14 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 14)

				if (14 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 14)) > 0 and var_156_6 < var_156_10 then
					arg_153_1.talkMaxDuration = var_156_10

					if var_156_10 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_5
					end
				end

				arg_153_1.text_.text = var_156_8
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051037", "story_v_out_413051.awb") ~= 0 then
					local var_156_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051037", "story_v_out_413051.awb") / 1000

					if var_156_11 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_5
					end

					if var_156_7.prefab_name ~= "" and arg_153_1.actors_[var_156_7.prefab_name] ~= nil then
						local var_156_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_7.prefab_name].transform, "story_v_out_413051", "413051037", "story_v_out_413051.awb")

						arg_153_1:RecordAudio("413051037", var_156_12)
						arg_153_1:RecordAudio("413051037", var_156_12)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_413051", "413051037", "story_v_out_413051.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_413051", "413051037", "story_v_out_413051.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_13 = math.max(var_156_6, arg_153_1.talkMaxDuration)

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_13 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_5) / var_156_13

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_5 + var_156_13 and arg_153_1.time_ < var_156_5 + var_156_13 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
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

		arg_153_1:InitPlayNodeList()
	end,
	Play413051038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 413051038
		arg_157_1.duration_ = 14.1

		local var_157_0 = {
			zh = 11.9,
			ja = 14.1
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
				arg_157_0:Play413051039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if arg_157_1.bgs_.F08l == nil then
				local var_160_0 = Object.Instantiate(arg_157_1.paintGo_)

				var_160_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08l")
				var_160_0.name = "F08l"
				var_160_0.transform.parent = arg_157_1.stage_.transform
				var_160_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.bgs_.F08l = var_160_0
			end

			if 2 < arg_157_1.time_ and arg_157_1.time_ <= 2 + arg_160_0 then
				local var_160_1 = arg_157_1.bgs_.F08l

				arg_157_1.bgs_.F08l.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_160_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_160_2 = var_160_1:GetComponent("SpriteRenderer")

				if var_160_2 and var_160_2.sprite then
					local var_160_3 = 2 * (var_160_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_160_1.transform.localScale = Vector3.New(var_160_3 / var_160_2.sprite.bounds.size.y < var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x and var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x or var_160_3 / var_160_2.sprite.bounds.size.y, var_160_3 / var_160_2.sprite.bounds.size.y < var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x and var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x or var_160_3 / var_160_2.sprite.bounds.size.y, 0)
				end

				for iter_160_0, iter_160_1 in pairs(arg_157_1.bgs_) do
					if iter_160_0 ~= "F08l" then
						iter_160_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_160_4 = 3.999999999999

			if 3.999999999999 < arg_157_1.time_ and arg_157_1.time_ <= var_160_4 + arg_160_0 then
				arg_157_1.allBtn_.enabled = false
			end

			if arg_157_1.time_ >= var_160_4 + 0.3 and arg_157_1.time_ < var_160_4 + 0.3 + arg_160_0 then
				arg_157_1.allBtn_.enabled = true
			end

			local var_160_5 = 0

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_5 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_6 = 2

			if var_160_5 <= arg_157_1.time_ and arg_157_1.time_ < var_160_5 + var_160_6 then
				local var_160_7 = Color.New(0, 0, 0)

				var_160_7.a = Mathf.Lerp(0, 1, (arg_157_1.time_ - var_160_5) / var_160_6)
				arg_157_1.mask_.color = var_160_7
			end

			if arg_157_1.time_ >= var_160_5 + var_160_6 and arg_157_1.time_ < var_160_5 + var_160_6 + arg_160_0 then
				local var_160_8 = Color.New(0, 0, 0)

				var_160_8.a = 1
				arg_157_1.mask_.color = var_160_8
			end

			local var_160_9 = 2

			if 2 < arg_157_1.time_ and arg_157_1.time_ <= var_160_9 + arg_160_0 then
				arg_157_1.mask_.enabled = true
				arg_157_1.mask_.raycastTarget = true

				arg_157_1:SetGaussion(false)
			end

			local var_160_10 = 2

			if var_160_9 <= arg_157_1.time_ and arg_157_1.time_ < var_160_9 + var_160_10 then
				local var_160_11 = Color.New(0, 0, 0)

				var_160_11.a = Mathf.Lerp(1, 0, (arg_157_1.time_ - var_160_9) / var_160_10)
				arg_157_1.mask_.color = var_160_11
			end

			if arg_157_1.time_ >= var_160_9 + var_160_10 and arg_157_1.time_ < var_160_9 + var_160_10 + arg_160_0 then
				local var_160_12 = Color.New(0, 0, 0)

				arg_157_1.mask_.enabled = false
				var_160_12.a = 0
				arg_157_1.mask_.color = var_160_12
			end

			local var_160_13 = arg_157_1.actors_["10094"].transform

			if 1.966 < arg_157_1.time_ and arg_157_1.time_ <= 1.966 + arg_160_0 then
				arg_157_1.var_.moveOldPos10094 = var_160_13.localPosition
				var_160_13.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10094", 7)

				for iter_160_2 = 0, var_160_13.childCount - 1 do
					local var_160_14 = var_160_13:GetChild(iter_160_2)

					if var_160_14.name == "" or not string.find(var_160_14.name, "split") then
						var_160_14.gameObject:SetActive(true)
					else
						var_160_14.gameObject:SetActive(false)
					end
				end
			end

			local var_160_15 = 0.001

			if 1.966 <= arg_157_1.time_ and arg_157_1.time_ < 1.966 + var_160_15 then
				var_160_13.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_157_1.time_ - 1.966) / var_160_15)
			end

			if arg_157_1.time_ >= 1.966 + var_160_15 and arg_157_1.time_ < 1.966 + var_160_15 + arg_160_0 then
				var_160_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_160_16 = "10098"

			if arg_157_1.actors_["10098"] == nil then
				local var_160_17 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10098")

				if not isNil(var_160_17) then
					local var_160_18 = Object.Instantiate(var_160_17, arg_157_1.canvasGo_.transform)

					var_160_18.transform:SetSiblingIndex(1)

					var_160_18.name = var_160_16
					var_160_18.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_157_1.actors_[var_160_16] = var_160_18

					if arg_157_1.isInRecall_ then
						for iter_160_3, iter_160_4 in ipairs((var_160_18:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_160_4.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_160_19 = arg_157_1.actors_["10098"].transform

			if 3.8 < arg_157_1.time_ and arg_157_1.time_ <= 3.8 + arg_160_0 then
				arg_157_1.var_.moveOldPos10098 = var_160_19.localPosition
				var_160_19.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10098", 3)

				for iter_160_5 = 0, var_160_19.childCount - 1 do
					local var_160_20 = var_160_19:GetChild(iter_160_5)

					if var_160_20.name == "split_2" or not string.find(var_160_20.name, "split") then
						var_160_20.gameObject:SetActive(true)
					else
						var_160_20.gameObject:SetActive(false)
					end
				end
			end

			local var_160_21 = 0.001

			if 3.8 <= arg_157_1.time_ and arg_157_1.time_ < 3.8 + var_160_21 then
				var_160_19.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10098, Vector3.New(0, -345, -300), (arg_157_1.time_ - 3.8) / var_160_21)
			end

			if arg_157_1.time_ >= 3.8 + var_160_21 and arg_157_1.time_ < 3.8 + var_160_21 + arg_160_0 then
				var_160_19.localPosition = Vector3.New(0, -345, -300)
			end

			local var_160_22 = arg_157_1.actors_["10094"]

			if 1.966 < arg_157_1.time_ and arg_157_1.time_ <= 1.966 + arg_160_0 and not isNil(var_160_22) and arg_157_1.var_.actorSpriteComps10094 == nil then
				arg_157_1.var_.actorSpriteComps10094 = var_160_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_23 = 0.034

			if 1.966 <= arg_157_1.time_ and arg_157_1.time_ < 1.966 + var_160_23 and not isNil(var_160_22) then
				if arg_157_1.var_.actorSpriteComps10094 then
					for iter_160_6, iter_160_7 in pairs(arg_157_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_160_7 then
							if arg_157_1.isInRecall_ then
								iter_160_7.color = Color.New(Mathf.Lerp(iter_160_7.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 1.966) / var_160_23), Mathf.Lerp(iter_160_7.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 1.966) / var_160_23), (Mathf.Lerp(iter_160_7.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 1.966) / var_160_23)))
							else
								local var_160_24 = Mathf.Lerp(iter_160_7.color.r, 0.5, (arg_157_1.time_ - 1.966) / var_160_23)

								iter_160_7.color = Color.New(var_160_24, var_160_24, var_160_24)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 1.966 + var_160_23 and arg_157_1.time_ < 1.966 + var_160_23 + arg_160_0 and not isNil(var_160_22) and arg_157_1.var_.actorSpriteComps10094 then
				for iter_160_8, iter_160_9 in pairs(arg_157_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_160_9 then
						iter_160_9.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps10094 = nil
			end

			local var_160_25 = arg_157_1.actors_["10098"]

			if 3.8 < arg_157_1.time_ and arg_157_1.time_ <= 3.8 + arg_160_0 and not isNil(var_160_25) and arg_157_1.var_.actorSpriteComps10098 == nil then
				arg_157_1.var_.actorSpriteComps10098 = var_160_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_26 = 0.2

			if 3.8 <= arg_157_1.time_ and arg_157_1.time_ < 3.8 + var_160_26 and not isNil(var_160_25) then
				if arg_157_1.var_.actorSpriteComps10098 then
					for iter_160_10, iter_160_11 in pairs(arg_157_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_160_11 then
							if arg_157_1.isInRecall_ then
								iter_160_11.color = Color.New(Mathf.Lerp(iter_160_11.color.r, arg_157_1.hightColor1.r, (arg_157_1.time_ - 3.8) / var_160_26), Mathf.Lerp(iter_160_11.color.g, arg_157_1.hightColor1.g, (arg_157_1.time_ - 3.8) / var_160_26), (Mathf.Lerp(iter_160_11.color.b, arg_157_1.hightColor1.b, (arg_157_1.time_ - 3.8) / var_160_26)))
							else
								local var_160_27 = Mathf.Lerp(iter_160_11.color.r, 1, (arg_157_1.time_ - 3.8) / var_160_26)

								iter_160_11.color = Color.New(var_160_27, var_160_27, var_160_27)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 3.8 + var_160_26 and arg_157_1.time_ < 3.8 + var_160_26 + arg_160_0 and not isNil(var_160_25) and arg_157_1.var_.actorSpriteComps10098 then
				for iter_160_12, iter_160_13 in pairs(arg_157_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_160_13 then
						iter_160_13.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_157_1.var_.actorSpriteComps10098 = nil
			end

			if 3.8 < arg_157_1.time_ and arg_157_1.time_ <= 3.8 + arg_160_0 then
				local var_160_28 = arg_157_1.actors_["10098"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_160_28 then
					arg_157_1.var_.alphaOldValue10098 = var_160_28.alpha
					arg_157_1.var_.characterEffect10098 = var_160_28
				end

				arg_157_1.var_.alphaOldValue10098 = 0
			end

			local var_160_29 = 0.2

			if 3.8 <= arg_157_1.time_ and arg_157_1.time_ < 3.8 + var_160_29 then
				if arg_157_1.var_.characterEffect10098 then
					arg_157_1.var_.characterEffect10098.alpha = Mathf.Lerp(arg_157_1.var_.alphaOldValue10098, 1, (arg_157_1.time_ - 3.8) / var_160_29)
				end
			end

			if arg_157_1.time_ >= 3.8 + var_160_29 and arg_157_1.time_ < 3.8 + var_160_29 + arg_160_0 and arg_157_1.var_.characterEffect10098 then
				arg_157_1.var_.characterEffect10098.alpha = 1
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_30 = 4
			local var_160_31 = 0.775

			if 4 < arg_157_1.time_ and arg_157_1.time_ <= var_160_30 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_32 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_32:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_33 = arg_157_1:GetWordFromCfg(413051038)
				local var_160_34 = arg_157_1:FormatText(var_160_33.content)

				arg_157_1.text_.text = var_160_34

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_36 = 31 <= 0 and var_160_31 or var_160_31 * (utf8.len(var_160_34) / 31)

				if (31 <= 0 and var_160_31 or var_160_31 * (utf8.len(var_160_34) / 31)) > 0 and var_160_31 < var_160_36 then
					arg_157_1.talkMaxDuration = var_160_36
					var_160_30 = var_160_30 + 0.3

					if var_160_36 + var_160_30 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_36 + var_160_30
					end
				end

				arg_157_1.text_.text = var_160_34
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051038", "story_v_out_413051.awb") ~= 0 then
					local var_160_37 = manager.audio:GetVoiceLength("story_v_out_413051", "413051038", "story_v_out_413051.awb") / 1000

					if var_160_37 + var_160_30 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_37 + var_160_30
					end

					if var_160_33.prefab_name ~= "" and arg_157_1.actors_[var_160_33.prefab_name] ~= nil then
						local var_160_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_33.prefab_name].transform, "story_v_out_413051", "413051038", "story_v_out_413051.awb")

						arg_157_1:RecordAudio("413051038", var_160_38)
						arg_157_1:RecordAudio("413051038", var_160_38)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_413051", "413051038", "story_v_out_413051.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_413051", "413051038", "story_v_out_413051.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_39 = var_160_30 + 0.3
			local var_160_40 = math.max(var_160_31, arg_157_1.talkMaxDuration)

			if var_160_30 + 0.3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_39 + var_160_40 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_39) / var_160_40

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_39 + var_160_40 and arg_157_1.time_ < var_160_39 + var_160_40 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
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
				actorName = "10098",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play413051039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 413051039
		arg_163_1.duration_ = 2

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play413051040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["10098"]) and arg_163_1.var_.actorSpriteComps10098 == nil then
				arg_163_1.var_.actorSpriteComps10098 = arg_163_1.actors_["10098"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_0 = 2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["10098"]) then
				if arg_163_1.var_.actorSpriteComps10098 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								iter_166_1.color = Color.New(Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor2.r, (arg_163_1.time_ - 0) / var_166_0), Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor2.g, (arg_163_1.time_ - 0) / var_166_0), (Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor2.b, (arg_163_1.time_ - 0) / var_166_0)))
							else
								local var_166_1 = Mathf.Lerp(iter_166_1.color.r, 0.5, (arg_163_1.time_ - 0) / var_166_0)

								iter_166_1.color = Color.New(var_166_1, var_166_1, var_166_1)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["10098"]) and arg_163_1.var_.actorSpriteComps10098 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_166_3 then
						iter_166_3.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_163_1.var_.actorSpriteComps10098 = nil
			end

			local var_166_2 = 0
			local var_166_3 = 0.1

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_4 = arg_163_1:GetWordFromCfg(413051039)
				local var_166_5 = arg_163_1:FormatText(var_166_4.content)

				arg_163_1.text_.text = var_166_5

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_7 = 4 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 4)

				if (4 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 4)) > 0 and var_166_3 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_2
					end
				end

				arg_163_1.text_.text = var_166_5
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051039", "story_v_out_413051.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_413051", "413051039", "story_v_out_413051.awb") / 1000

					if var_166_8 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_2
					end

					if var_166_4.prefab_name ~= "" and arg_163_1.actors_[var_166_4.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_4.prefab_name].transform, "story_v_out_413051", "413051039", "story_v_out_413051.awb")

						arg_163_1:RecordAudio("413051039", var_166_9)
						arg_163_1:RecordAudio("413051039", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_413051", "413051039", "story_v_out_413051.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_413051", "413051039", "story_v_out_413051.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_3, arg_163_1.talkMaxDuration)

			if var_166_2 <= arg_163_1.time_ and arg_163_1.time_ < var_166_2 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_2) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_2 + var_166_10 and arg_163_1.time_ < var_166_2 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play413051040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 413051040
		arg_167_1.duration_ = 2.07

		local var_167_0 = {
			zh = 1.999999999999,
			ja = 2.066
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
				arg_167_0:Play413051041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10098 = arg_167_1.actors_["10098"].transform.localPosition
				arg_167_1.actors_["10098"].transform.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10098", 3)

				for iter_170_0 = 0, arg_167_1.actors_["10098"].transform.childCount - 1 do
					local var_170_0 = arg_167_1.actors_["10098"].transform:GetChild(iter_170_0)

					if var_170_0.name == "split_3" or not string.find(var_170_0.name, "split") then
						var_170_0.gameObject:SetActive(true)
					else
						var_170_0.gameObject:SetActive(false)
					end
				end
			end

			local var_170_1 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_1 then
				arg_167_1.actors_["10098"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10098, Vector3.New(0, -345, -300), (arg_167_1.time_ - 0) / var_170_1)
			end

			if arg_167_1.time_ >= 0 + var_170_1 and arg_167_1.time_ < 0 + var_170_1 + arg_170_0 then
				arg_167_1.actors_["10098"].transform.localPosition = Vector3.New(0, -345, -300)
			end

			local var_170_2 = arg_167_1.actors_["10098"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps10098 == nil then
				arg_167_1.var_.actorSpriteComps10098 = var_170_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_3 = 2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 and not isNil(var_170_2) then
				if arg_167_1.var_.actorSpriteComps10098 then
					for iter_170_1, iter_170_2 in pairs(arg_167_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_170_2 then
							if arg_167_1.isInRecall_ then
								iter_170_2.color = Color.New(Mathf.Lerp(iter_170_2.color.r, arg_167_1.hightColor1.r, (arg_167_1.time_ - 0) / var_170_3), Mathf.Lerp(iter_170_2.color.g, arg_167_1.hightColor1.g, (arg_167_1.time_ - 0) / var_170_3), (Mathf.Lerp(iter_170_2.color.b, arg_167_1.hightColor1.b, (arg_167_1.time_ - 0) / var_170_3)))
							else
								local var_170_4 = Mathf.Lerp(iter_170_2.color.r, 1, (arg_167_1.time_ - 0) / var_170_3)

								iter_170_2.color = Color.New(var_170_4, var_170_4, var_170_4)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.actorSpriteComps10098 then
				for iter_170_3, iter_170_4 in pairs(arg_167_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_170_4 then
						iter_170_4.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps10098 = nil
			end

			local var_170_5 = 0
			local var_170_6 = 0.15

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_7 = arg_167_1:GetWordFromCfg(413051040)
				local var_170_8 = arg_167_1:FormatText(var_170_7.content)

				arg_167_1.text_.text = var_170_8

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_10 = 6 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_8) / 6)

				if (6 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_8) / 6)) > 0 and var_170_6 < var_170_10 then
					arg_167_1.talkMaxDuration = var_170_10

					if var_170_10 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_10 + var_170_5
					end
				end

				arg_167_1.text_.text = var_170_8
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051040", "story_v_out_413051.awb") ~= 0 then
					local var_170_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051040", "story_v_out_413051.awb") / 1000

					if var_170_11 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_11 + var_170_5
					end

					if var_170_7.prefab_name ~= "" and arg_167_1.actors_[var_170_7.prefab_name] ~= nil then
						local var_170_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_7.prefab_name].transform, "story_v_out_413051", "413051040", "story_v_out_413051.awb")

						arg_167_1:RecordAudio("413051040", var_170_12)
						arg_167_1:RecordAudio("413051040", var_170_12)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_413051", "413051040", "story_v_out_413051.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_413051", "413051040", "story_v_out_413051.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_13 = math.max(var_170_6, arg_167_1.talkMaxDuration)

			if var_170_5 <= arg_167_1.time_ and arg_167_1.time_ < var_170_5 + var_170_13 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_5) / var_170_13

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_5 + var_170_13 and arg_167_1.time_ < var_170_5 + var_170_13 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10098",
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
	Play413051041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 413051041
		arg_171_1.duration_ = 3.93

		local var_171_0 = {
			zh = 3.7,
			ja = 3.933
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
				arg_171_0:Play413051042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["10098"]) and arg_171_1.var_.actorSpriteComps10098 == nil then
				arg_171_1.var_.actorSpriteComps10098 = arg_171_1.actors_["10098"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_0 = 2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["10098"]) then
				if arg_171_1.var_.actorSpriteComps10098 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_174_1 then
							if arg_171_1.isInRecall_ then
								iter_174_1.color = Color.New(Mathf.Lerp(iter_174_1.color.r, arg_171_1.hightColor2.r, (arg_171_1.time_ - 0) / var_174_0), Mathf.Lerp(iter_174_1.color.g, arg_171_1.hightColor2.g, (arg_171_1.time_ - 0) / var_174_0), (Mathf.Lerp(iter_174_1.color.b, arg_171_1.hightColor2.b, (arg_171_1.time_ - 0) / var_174_0)))
							else
								local var_174_1 = Mathf.Lerp(iter_174_1.color.r, 0.5, (arg_171_1.time_ - 0) / var_174_0)

								iter_174_1.color = Color.New(var_174_1, var_174_1, var_174_1)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["10098"]) and arg_171_1.var_.actorSpriteComps10098 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_174_3 then
						iter_174_3.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_171_1.var_.actorSpriteComps10098 = nil
			end

			local var_174_2 = 0
			local var_174_3 = 0.5

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_2 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_4 = arg_171_1:GetWordFromCfg(413051041)
				local var_174_5 = arg_171_1:FormatText(var_174_4.content)

				arg_171_1.text_.text = var_174_5

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_7 = 20 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 20)

				if (20 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 20)) > 0 and var_174_3 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_2
					end
				end

				arg_171_1.text_.text = var_174_5
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051041", "story_v_out_413051.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_413051", "413051041", "story_v_out_413051.awb") / 1000

					if var_174_8 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_2
					end

					if var_174_4.prefab_name ~= "" and arg_171_1.actors_[var_174_4.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_4.prefab_name].transform, "story_v_out_413051", "413051041", "story_v_out_413051.awb")

						arg_171_1:RecordAudio("413051041", var_174_9)
						arg_171_1:RecordAudio("413051041", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_413051", "413051041", "story_v_out_413051.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_413051", "413051041", "story_v_out_413051.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_3, arg_171_1.talkMaxDuration)

			if var_174_2 <= arg_171_1.time_ and arg_171_1.time_ < var_174_2 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_2) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_2 + var_174_10 and arg_171_1.time_ < var_174_2 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play413051042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 413051042
		arg_175_1.duration_ = 4.63

		local var_175_0 = {
			zh = 4.43266666666667,
			ja = 4.63266666666667
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
				arg_175_0:Play413051043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0.566666666666667 < arg_175_1.time_ and arg_175_1.time_ <= 0.566666666666667 + arg_178_0 then
				arg_175_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_178_0 = 0.6

			if 0.566666666666667 <= arg_175_1.time_ and arg_175_1.time_ < 0.566666666666667 + var_178_0 then
				local var_178_1, var_178_2 = math.modf((arg_175_1.time_ - 0.566666666666667) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_178_2 * 0.13, var_178_2 * 0.13, var_178_2 * 0.13) + arg_175_1.var_.shakeOldPos
			end

			if arg_175_1.time_ >= 0.566666666666667 + var_178_0 and arg_175_1.time_ < 0.566666666666667 + var_178_0 + arg_178_0 then
				manager.ui.mainCamera.transform.localPosition = arg_175_1.var_.shakeOldPos
			end

			local var_178_3 = 0

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_3 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			if arg_175_1.time_ >= var_178_3 + 1.16666666666667 and arg_175_1.time_ < var_178_3 + 1.16666666666667 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end

			local var_178_4 = arg_175_1.actors_["10098"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10098 = var_178_4.localPosition
				var_178_4.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10098", 0)

				for iter_178_0 = 0, var_178_4.childCount - 1 do
					local var_178_5 = var_178_4:GetChild(iter_178_0)

					if var_178_5.name == "split_3" or not string.find(var_178_5.name, "split") then
						var_178_5.gameObject:SetActive(true)
					else
						var_178_5.gameObject:SetActive(false)
					end
				end
			end

			local var_178_6 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_6 then
				var_178_4.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10098, Vector3.New(-5000, -345, -300), (arg_175_1.time_ - 0) / var_178_6)
			end

			if arg_175_1.time_ >= 0 + var_178_6 and arg_175_1.time_ < 0 + var_178_6 + arg_178_0 then
				var_178_4.localPosition = Vector3.New(-5000, -345, -300)
			end

			if arg_175_1.frameCnt_ <= 1 then
				arg_175_1.dialog_:SetActive(false)
			end

			local var_178_7 = 0.766666666666666
			local var_178_8 = 0.4

			if 0.766666666666666 < arg_175_1.time_ and arg_175_1.time_ <= var_178_7 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0

				arg_175_1.dialog_:SetActive(true)

				arg_175_1.dialogCg_.alpha = 0

				local var_178_9 = LeanTween.value(arg_175_1.dialog_, 0, 1, 0.3)

				var_178_9:setOnUpdate(LuaHelper.FloatAction(function(arg_179_0)
					arg_175_1.dialogCg_.alpha = arg_179_0
				end))
				var_178_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_175_1.dialog_)
					var_178_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_175_1.duration_ = arg_175_1.duration_ + 0.3

				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_10 = arg_175_1:GetWordFromCfg(413051042)
				local var_178_11 = arg_175_1:FormatText(var_178_10.content)

				arg_175_1.text_.text = var_178_11

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_13 = 16 <= 0 and var_178_8 or var_178_8 * (utf8.len(var_178_11) / 16)

				if (16 <= 0 and var_178_8 or var_178_8 * (utf8.len(var_178_11) / 16)) > 0 and var_178_8 < var_178_13 then
					arg_175_1.talkMaxDuration = var_178_13
					var_178_7 = var_178_7 + 0.3

					if var_178_13 + var_178_7 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_13 + var_178_7
					end
				end

				arg_175_1.text_.text = var_178_11
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051042", "story_v_out_413051.awb") ~= 0 then
					local var_178_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051042", "story_v_out_413051.awb") / 1000

					if var_178_14 + var_178_7 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_7
					end

					if var_178_10.prefab_name ~= "" and arg_175_1.actors_[var_178_10.prefab_name] ~= nil then
						local var_178_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_10.prefab_name].transform, "story_v_out_413051", "413051042", "story_v_out_413051.awb")

						arg_175_1:RecordAudio("413051042", var_178_15)
						arg_175_1:RecordAudio("413051042", var_178_15)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_413051", "413051042", "story_v_out_413051.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_413051", "413051042", "story_v_out_413051.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_16 = var_178_7 + 0.3
			local var_178_17 = math.max(var_178_8, arg_175_1.talkMaxDuration)

			if var_178_7 + 0.3 <= arg_175_1.time_ and arg_175_1.time_ < var_178_16 + var_178_17 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_16) / var_178_17

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_16 + var_178_17 and arg_175_1.time_ < var_178_16 + var_178_17 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10098",
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
	Play413051043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 413051043
		arg_181_1.duration_ = 9.7

		local var_181_0 = {
			zh = 5.732999999999,
			ja = 9.699999999999
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
				arg_181_0:Play413051044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if arg_181_1.bgs_.F08i == nil then
				local var_184_0 = Object.Instantiate(arg_181_1.paintGo_)

				var_184_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08i")
				var_184_0.name = "F08i"
				var_184_0.transform.parent = arg_181_1.stage_.transform
				var_184_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_181_1.bgs_.F08i = var_184_0
			end

			if 1.999999999999 < arg_181_1.time_ and arg_181_1.time_ <= 1.999999999999 + arg_184_0 then
				local var_184_1 = arg_181_1.bgs_.F08i

				arg_181_1.bgs_.F08i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_184_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_184_2 = var_184_1:GetComponent("SpriteRenderer")

				if var_184_2 and var_184_2.sprite then
					local var_184_3 = 2 * (var_184_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_184_1.transform.localScale = Vector3.New(var_184_3 / var_184_2.sprite.bounds.size.y < var_184_3 * manager.ui.mainCameraCom_.aspect / var_184_2.sprite.bounds.size.x and var_184_3 * manager.ui.mainCameraCom_.aspect / var_184_2.sprite.bounds.size.x or var_184_3 / var_184_2.sprite.bounds.size.y, var_184_3 / var_184_2.sprite.bounds.size.y < var_184_3 * manager.ui.mainCameraCom_.aspect / var_184_2.sprite.bounds.size.x and var_184_3 * manager.ui.mainCameraCom_.aspect / var_184_2.sprite.bounds.size.x or var_184_3 / var_184_2.sprite.bounds.size.y, 0)
				end

				for iter_184_0, iter_184_1 in pairs(arg_181_1.bgs_) do
					if iter_184_0 ~= "F08i" then
						iter_184_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_184_4 = 3.999999999999

			if 3.999999999999 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.allBtn_.enabled = false
			end

			if arg_181_1.time_ >= var_184_4 + 0.3 and arg_181_1.time_ < var_184_4 + 0.3 + arg_184_0 then
				arg_181_1.allBtn_.enabled = true
			end

			local var_184_5 = 0

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_6 = 2

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_6 then
				local var_184_7 = Color.New(0, 0, 0)

				var_184_7.a = Mathf.Lerp(0, 1, (arg_181_1.time_ - var_184_5) / var_184_6)
				arg_181_1.mask_.color = var_184_7
			end

			if arg_181_1.time_ >= var_184_5 + var_184_6 and arg_181_1.time_ < var_184_5 + var_184_6 + arg_184_0 then
				local var_184_8 = Color.New(0, 0, 0)

				var_184_8.a = 1
				arg_181_1.mask_.color = var_184_8
			end

			local var_184_9 = 2

			if 2 < arg_181_1.time_ and arg_181_1.time_ <= var_184_9 + arg_184_0 then
				arg_181_1.mask_.enabled = true
				arg_181_1.mask_.raycastTarget = true

				arg_181_1:SetGaussion(false)
			end

			local var_184_10 = 2

			if var_184_9 <= arg_181_1.time_ and arg_181_1.time_ < var_184_9 + var_184_10 then
				local var_184_11 = Color.New(0, 0, 0)

				var_184_11.a = Mathf.Lerp(1, 0, (arg_181_1.time_ - var_184_9) / var_184_10)
				arg_181_1.mask_.color = var_184_11
			end

			if arg_181_1.time_ >= var_184_9 + var_184_10 and arg_181_1.time_ < var_184_9 + var_184_10 + arg_184_0 then
				local var_184_12 = Color.New(0, 0, 0)

				arg_181_1.mask_.enabled = false
				var_184_12.a = 0
				arg_181_1.mask_.color = var_184_12
			end

			if arg_181_1.frameCnt_ <= 1 then
				arg_181_1.dialog_:SetActive(false)
			end

			local var_184_13 = 3.999999999999
			local var_184_14 = 0.2

			if 3.999999999999 < arg_181_1.time_ and arg_181_1.time_ <= var_184_13 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0

				arg_181_1.dialog_:SetActive(true)

				arg_181_1.dialogCg_.alpha = 0

				local var_184_15 = LeanTween.value(arg_181_1.dialog_, 0, 1, 0.3)

				var_184_15:setOnUpdate(LuaHelper.FloatAction(function(arg_185_0)
					arg_181_1.dialogCg_.alpha = arg_185_0
				end))
				var_184_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_181_1.dialog_)
					var_184_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_181_1.duration_ = arg_181_1.duration_ + 0.3

				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10098_split_4")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_16 = arg_181_1:GetWordFromCfg(413051043)
				local var_184_17 = arg_181_1:FormatText(var_184_16.content)

				arg_181_1.text_.text = var_184_17

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_19 = 8 <= 0 and var_184_14 or var_184_14 * (utf8.len(var_184_17) / 8)

				if (8 <= 0 and var_184_14 or var_184_14 * (utf8.len(var_184_17) / 8)) > 0 and var_184_14 < var_184_19 then
					arg_181_1.talkMaxDuration = var_184_19
					var_184_13 = var_184_13 + 0.3

					if var_184_19 + var_184_13 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_19 + var_184_13
					end
				end

				arg_181_1.text_.text = var_184_17
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051043", "story_v_out_413051.awb") ~= 0 then
					local var_184_20 = manager.audio:GetVoiceLength("story_v_out_413051", "413051043", "story_v_out_413051.awb") / 1000

					if var_184_20 + var_184_13 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_20 + var_184_13
					end

					if var_184_16.prefab_name ~= "" and arg_181_1.actors_[var_184_16.prefab_name] ~= nil then
						local var_184_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_16.prefab_name].transform, "story_v_out_413051", "413051043", "story_v_out_413051.awb")

						arg_181_1:RecordAudio("413051043", var_184_21)
						arg_181_1:RecordAudio("413051043", var_184_21)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_413051", "413051043", "story_v_out_413051.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_413051", "413051043", "story_v_out_413051.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_22 = var_184_13 + 0.3
			local var_184_23 = math.max(var_184_14, arg_181_1.talkMaxDuration)

			if var_184_13 + 0.3 <= arg_181_1.time_ and arg_181_1.time_ < var_184_22 + var_184_23 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_22) / var_184_23

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_22 + var_184_23 and arg_181_1.time_ < var_184_22 + var_184_23 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play413051044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 413051044
		arg_187_1.duration_ = 4.7

		local var_187_0 = {
			zh = 4.166,
			ja = 4.7
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
				arg_187_0:Play413051045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.375

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10098_split_4")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_1 = arg_187_1:GetWordFromCfg(413051044)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 15 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 15)

				if (15 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 15)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051044", "story_v_out_413051.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051044", "story_v_out_413051.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_413051", "413051044", "story_v_out_413051.awb")

						arg_187_1:RecordAudio("413051044", var_190_6)
						arg_187_1:RecordAudio("413051044", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_413051", "413051044", "story_v_out_413051.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_413051", "413051044", "story_v_out_413051.awb")
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
	Play413051045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 413051045
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play413051046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 1.125

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, false)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(413051045).content)

				arg_191_1.text_.text = var_194_1

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_3 = 45 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 45)

				if (45 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_1) / 45)) > 0 and var_194_0 < var_194_3 then
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
	Play413051046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 413051046
		arg_195_1.duration_ = 5.6

		local var_195_0 = {
			zh = 3.4,
			ja = 5.6
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
				arg_195_0:Play413051047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0.375

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_1 = arg_195_1:GetWordFromCfg(413051046)
				local var_198_2 = arg_195_1:FormatText(var_198_1.content)

				arg_195_1.text_.text = var_198_2

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_4 = 15 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 15)

				if (15 <= 0 and var_198_0 or var_198_0 * (utf8.len(var_198_2) / 15)) > 0 and var_198_0 < var_198_4 then
					arg_195_1.talkMaxDuration = var_198_4

					if var_198_4 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_4 + 0
					end
				end

				arg_195_1.text_.text = var_198_2
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051046", "story_v_out_413051.awb") ~= 0 then
					local var_198_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051046", "story_v_out_413051.awb") / 1000

					if var_198_5 + 0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + 0
					end

					if var_198_1.prefab_name ~= "" and arg_195_1.actors_[var_198_1.prefab_name] ~= nil then
						local var_198_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_1.prefab_name].transform, "story_v_out_413051", "413051046", "story_v_out_413051.awb")

						arg_195_1:RecordAudio("413051046", var_198_6)
						arg_195_1:RecordAudio("413051046", var_198_6)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_413051", "413051046", "story_v_out_413051.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_413051", "413051046", "story_v_out_413051.awb")
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
	Play413051047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 413051047
		arg_199_1.duration_ = 8.07

		local var_199_0 = {
			zh = 2.8,
			ja = 8.066
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
				arg_199_0:Play413051048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10098 = arg_199_1.actors_["10098"].transform.localPosition
				arg_199_1.actors_["10098"].transform.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("10098", 3)

				for iter_202_0 = 0, arg_199_1.actors_["10098"].transform.childCount - 1 do
					local var_202_0 = arg_199_1.actors_["10098"].transform:GetChild(iter_202_0)

					if var_202_0.name == "split_4" or not string.find(var_202_0.name, "split") then
						var_202_0.gameObject:SetActive(true)
					else
						var_202_0.gameObject:SetActive(false)
					end
				end
			end

			local var_202_1 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_1 then
				arg_199_1.actors_["10098"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10098, Vector3.New(0, -345, -300), (arg_199_1.time_ - 0) / var_202_1)
			end

			if arg_199_1.time_ >= 0 + var_202_1 and arg_199_1.time_ < 0 + var_202_1 + arg_202_0 then
				arg_199_1.actors_["10098"].transform.localPosition = Vector3.New(0, -345, -300)
			end

			local var_202_2 = arg_199_1.actors_["10098"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps10098 == nil then
				arg_199_1.var_.actorSpriteComps10098 = var_202_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_3 = 2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.actorSpriteComps10098 then
					for iter_202_1, iter_202_2 in pairs(arg_199_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_202_2 then
							if arg_199_1.isInRecall_ then
								iter_202_2.color = Color.New(Mathf.Lerp(iter_202_2.color.r, arg_199_1.hightColor1.r, (arg_199_1.time_ - 0) / var_202_3), Mathf.Lerp(iter_202_2.color.g, arg_199_1.hightColor1.g, (arg_199_1.time_ - 0) / var_202_3), (Mathf.Lerp(iter_202_2.color.b, arg_199_1.hightColor1.b, (arg_199_1.time_ - 0) / var_202_3)))
							else
								local var_202_4 = Mathf.Lerp(iter_202_2.color.r, 1, (arg_199_1.time_ - 0) / var_202_3)

								iter_202_2.color = Color.New(var_202_4, var_202_4, var_202_4)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps10098 then
				for iter_202_3, iter_202_4 in pairs(arg_199_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_202_4 then
						iter_202_4.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_199_1.var_.actorSpriteComps10098 = nil
			end

			local var_202_5 = 0
			local var_202_6 = 0.275

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_7 = arg_199_1:GetWordFromCfg(413051047)
				local var_202_8 = arg_199_1:FormatText(var_202_7.content)

				arg_199_1.text_.text = var_202_8

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_10 = 11 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 11)

				if (11 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_8) / 11)) > 0 and var_202_6 < var_202_10 then
					arg_199_1.talkMaxDuration = var_202_10

					if var_202_10 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_5
					end
				end

				arg_199_1.text_.text = var_202_8
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051047", "story_v_out_413051.awb") ~= 0 then
					local var_202_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051047", "story_v_out_413051.awb") / 1000

					if var_202_11 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_11 + var_202_5
					end

					if var_202_7.prefab_name ~= "" and arg_199_1.actors_[var_202_7.prefab_name] ~= nil then
						local var_202_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_7.prefab_name].transform, "story_v_out_413051", "413051047", "story_v_out_413051.awb")

						arg_199_1:RecordAudio("413051047", var_202_12)
						arg_199_1:RecordAudio("413051047", var_202_12)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_413051", "413051047", "story_v_out_413051.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_413051", "413051047", "story_v_out_413051.awb")
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

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10098",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play413051048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 413051048
		arg_203_1.duration_ = 4.1

		local var_203_0 = {
			zh = 3.6,
			ja = 4.1
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play413051049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.5

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:GetWordFromCfg(413051048)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 20 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 20)

				if (20 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 20)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051048", "story_v_out_413051.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051048", "story_v_out_413051.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_413051", "413051048", "story_v_out_413051.awb")

						arg_203_1:RecordAudio("413051048", var_206_6)
						arg_203_1:RecordAudio("413051048", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_413051", "413051048", "story_v_out_413051.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_413051", "413051048", "story_v_out_413051.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play413051049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 413051049
		arg_207_1.duration_ = 4.1

		local var_207_0 = {
			zh = 2.633,
			ja = 4.1
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
				arg_207_0:Play413051050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["10098"]) and arg_207_1.var_.actorSpriteComps10098 == nil then
				arg_207_1.var_.actorSpriteComps10098 = arg_207_1.actors_["10098"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_0 = 2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["10098"]) then
				if arg_207_1.var_.actorSpriteComps10098 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_210_1 then
							if arg_207_1.isInRecall_ then
								iter_210_1.color = Color.New(Mathf.Lerp(iter_210_1.color.r, arg_207_1.hightColor2.r, (arg_207_1.time_ - 0) / var_210_0), Mathf.Lerp(iter_210_1.color.g, arg_207_1.hightColor2.g, (arg_207_1.time_ - 0) / var_210_0), (Mathf.Lerp(iter_210_1.color.b, arg_207_1.hightColor2.b, (arg_207_1.time_ - 0) / var_210_0)))
							else
								local var_210_1 = Mathf.Lerp(iter_210_1.color.r, 0.5, (arg_207_1.time_ - 0) / var_210_0)

								iter_210_1.color = Color.New(var_210_1, var_210_1, var_210_1)
							end
						end
					end
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["10098"]) and arg_207_1.var_.actorSpriteComps10098 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_210_3 then
						iter_210_3.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_207_1.var_.actorSpriteComps10098 = nil
			end

			local var_210_2 = 0
			local var_210_3 = 0.3

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_2 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, true)
				arg_207_1.iconController_:SetSelectedState("hero")

				arg_207_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_207_1.callingController_:SetSelectedState("normal")

				arg_207_1.keyicon_.color = Color.New(1, 1, 1)
				arg_207_1.icon_.color = Color.New(1, 1, 1)

				local var_210_4 = arg_207_1:GetWordFromCfg(413051049)
				local var_210_5 = arg_207_1:FormatText(var_210_4.content)

				arg_207_1.text_.text = var_210_5

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_7 = 12 <= 0 and var_210_3 or var_210_3 * (utf8.len(var_210_5) / 12)

				if (12 <= 0 and var_210_3 or var_210_3 * (utf8.len(var_210_5) / 12)) > 0 and var_210_3 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_2 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_2
					end
				end

				arg_207_1.text_.text = var_210_5
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051049", "story_v_out_413051.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_413051", "413051049", "story_v_out_413051.awb") / 1000

					if var_210_8 + var_210_2 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_2
					end

					if var_210_4.prefab_name ~= "" and arg_207_1.actors_[var_210_4.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_4.prefab_name].transform, "story_v_out_413051", "413051049", "story_v_out_413051.awb")

						arg_207_1:RecordAudio("413051049", var_210_9)
						arg_207_1:RecordAudio("413051049", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_413051", "413051049", "story_v_out_413051.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_413051", "413051049", "story_v_out_413051.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_3, arg_207_1.talkMaxDuration)

			if var_210_2 <= arg_207_1.time_ and arg_207_1.time_ < var_210_2 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_2) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_2 + var_210_10 and arg_207_1.time_ < var_210_2 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play413051050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 413051050
		arg_211_1.duration_ = 4.43

		local var_211_0 = {
			zh = 4.433,
			ja = 3.266
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
				arg_211_0:Play413051051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["10098"]) and arg_211_1.var_.actorSpriteComps10098 == nil then
				arg_211_1.var_.actorSpriteComps10098 = arg_211_1.actors_["10098"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_0 = 2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["10098"]) then
				if arg_211_1.var_.actorSpriteComps10098 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps10098:ToTable()) do
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

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["10098"]) and arg_211_1.var_.actorSpriteComps10098 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_214_3 then
						iter_214_3.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_211_1.var_.actorSpriteComps10098 = nil
			end

			local var_214_2 = 0
			local var_214_3 = 0.475

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_2 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_4 = arg_211_1:GetWordFromCfg(413051050)
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

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051050", "story_v_out_413051.awb") ~= 0 then
					local var_214_8 = manager.audio:GetVoiceLength("story_v_out_413051", "413051050", "story_v_out_413051.awb") / 1000

					if var_214_8 + var_214_2 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_8 + var_214_2
					end

					if var_214_4.prefab_name ~= "" and arg_211_1.actors_[var_214_4.prefab_name] ~= nil then
						local var_214_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_4.prefab_name].transform, "story_v_out_413051", "413051050", "story_v_out_413051.awb")

						arg_211_1:RecordAudio("413051050", var_214_9)
						arg_211_1:RecordAudio("413051050", var_214_9)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_413051", "413051050", "story_v_out_413051.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_413051", "413051050", "story_v_out_413051.awb")
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
	Play413051051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 413051051
		arg_215_1.duration_ = 6.1

		local var_215_0 = {
			zh = 5.166,
			ja = 6.1
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
				arg_215_0:Play413051052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.6

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_1 = arg_215_1:GetWordFromCfg(413051051)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.text_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_4 = 24 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 24)

				if (24 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_2) / 24)) > 0 and var_218_0 < var_218_4 then
					arg_215_1.talkMaxDuration = var_218_4

					if var_218_4 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_4 + 0
					end
				end

				arg_215_1.text_.text = var_218_2
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051051", "story_v_out_413051.awb") ~= 0 then
					local var_218_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051051", "story_v_out_413051.awb") / 1000

					if var_218_5 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + 0
					end

					if var_218_1.prefab_name ~= "" and arg_215_1.actors_[var_218_1.prefab_name] ~= nil then
						local var_218_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_1.prefab_name].transform, "story_v_out_413051", "413051051", "story_v_out_413051.awb")

						arg_215_1:RecordAudio("413051051", var_218_6)
						arg_215_1:RecordAudio("413051051", var_218_6)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_413051", "413051051", "story_v_out_413051.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_413051", "413051051", "story_v_out_413051.awb")
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
	Play413051052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 413051052
		arg_219_1.duration_ = 5.7

		local var_219_0 = {
			zh = 3.3,
			ja = 5.7
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
				arg_219_0:Play413051053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos10098 = arg_219_1.actors_["10098"].transform.localPosition
				arg_219_1.actors_["10098"].transform.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("10098", 3)

				for iter_222_0 = 0, arg_219_1.actors_["10098"].transform.childCount - 1 do
					local var_222_0 = arg_219_1.actors_["10098"].transform:GetChild(iter_222_0)

					if var_222_0.name == "split_2" or not string.find(var_222_0.name, "split") then
						var_222_0.gameObject:SetActive(true)
					else
						var_222_0.gameObject:SetActive(false)
					end
				end
			end

			local var_222_1 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_1 then
				arg_219_1.actors_["10098"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10098, Vector3.New(0, -345, -300), (arg_219_1.time_ - 0) / var_222_1)
			end

			if arg_219_1.time_ >= 0 + var_222_1 and arg_219_1.time_ < 0 + var_222_1 + arg_222_0 then
				arg_219_1.actors_["10098"].transform.localPosition = Vector3.New(0, -345, -300)
			end

			local var_222_2 = 0
			local var_222_3 = 0.35

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[1003].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_4 = arg_219_1:GetWordFromCfg(413051052)
				local var_222_5 = arg_219_1:FormatText(var_222_4.content)

				arg_219_1.text_.text = var_222_5

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_7 = 14 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 14)

				if (14 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 14)) > 0 and var_222_3 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_2
					end
				end

				arg_219_1.text_.text = var_222_5
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051052", "story_v_out_413051.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_413051", "413051052", "story_v_out_413051.awb") / 1000

					if var_222_8 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_2
					end

					if var_222_4.prefab_name ~= "" and arg_219_1.actors_[var_222_4.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_4.prefab_name].transform, "story_v_out_413051", "413051052", "story_v_out_413051.awb")

						arg_219_1:RecordAudio("413051052", var_222_9)
						arg_219_1:RecordAudio("413051052", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_413051", "413051052", "story_v_out_413051.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_413051", "413051052", "story_v_out_413051.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_3, arg_219_1.talkMaxDuration)

			if var_222_2 <= arg_219_1.time_ and arg_219_1.time_ < var_222_2 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_2) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_2 + var_222_10 and arg_219_1.time_ < var_222_2 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10098",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play413051053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 413051053
		arg_223_1.duration_ = 7.47

		local var_223_0 = {
			zh = 4.566,
			ja = 7.466
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
				arg_223_0:Play413051054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["10098"]) and arg_223_1.var_.actorSpriteComps10098 == nil then
				arg_223_1.var_.actorSpriteComps10098 = arg_223_1.actors_["10098"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_0 = 2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["10098"]) then
				if arg_223_1.var_.actorSpriteComps10098 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_226_1 then
							if arg_223_1.isInRecall_ then
								iter_226_1.color = Color.New(Mathf.Lerp(iter_226_1.color.r, arg_223_1.hightColor2.r, (arg_223_1.time_ - 0) / var_226_0), Mathf.Lerp(iter_226_1.color.g, arg_223_1.hightColor2.g, (arg_223_1.time_ - 0) / var_226_0), (Mathf.Lerp(iter_226_1.color.b, arg_223_1.hightColor2.b, (arg_223_1.time_ - 0) / var_226_0)))
							else
								local var_226_1 = Mathf.Lerp(iter_226_1.color.r, 0.5, (arg_223_1.time_ - 0) / var_226_0)

								iter_226_1.color = Color.New(var_226_1, var_226_1, var_226_1)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["10098"]) and arg_223_1.var_.actorSpriteComps10098 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_226_3 then
						iter_226_3.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_223_1.var_.actorSpriteComps10098 = nil
			end

			local var_226_2 = 0
			local var_226_3 = 0.675

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_2 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, true)
				arg_223_1.iconController_:SetSelectedState("hero")

				arg_223_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_223_1.callingController_:SetSelectedState("normal")

				arg_223_1.keyicon_.color = Color.New(1, 1, 1)
				arg_223_1.icon_.color = Color.New(1, 1, 1)

				local var_226_4 = arg_223_1:GetWordFromCfg(413051053)
				local var_226_5 = arg_223_1:FormatText(var_226_4.content)

				arg_223_1.text_.text = var_226_5

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_7 = 27 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_5) / 27)

				if (27 <= 0 and var_226_3 or var_226_3 * (utf8.len(var_226_5) / 27)) > 0 and var_226_3 < var_226_7 then
					arg_223_1.talkMaxDuration = var_226_7

					if var_226_7 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_7 + var_226_2
					end
				end

				arg_223_1.text_.text = var_226_5
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051053", "story_v_out_413051.awb") ~= 0 then
					local var_226_8 = manager.audio:GetVoiceLength("story_v_out_413051", "413051053", "story_v_out_413051.awb") / 1000

					if var_226_8 + var_226_2 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_8 + var_226_2
					end

					if var_226_4.prefab_name ~= "" and arg_223_1.actors_[var_226_4.prefab_name] ~= nil then
						local var_226_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_4.prefab_name].transform, "story_v_out_413051", "413051053", "story_v_out_413051.awb")

						arg_223_1:RecordAudio("413051053", var_226_9)
						arg_223_1:RecordAudio("413051053", var_226_9)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_413051", "413051053", "story_v_out_413051.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_413051", "413051053", "story_v_out_413051.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_10 = math.max(var_226_3, arg_223_1.talkMaxDuration)

			if var_226_2 <= arg_223_1.time_ and arg_223_1.time_ < var_226_2 + var_226_10 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_2) / var_226_10

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_2 + var_226_10 and arg_223_1.time_ < var_226_2 + var_226_10 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play413051054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 413051054
		arg_227_1.duration_ = 6.4

		local var_227_0 = {
			zh = 5.799999999999,
			ja = 6.4
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
				arg_227_0:Play413051055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if arg_227_1.bgs_.ST71a == nil then
				local var_230_0 = Object.Instantiate(arg_227_1.paintGo_)

				var_230_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST71a")
				var_230_0.name = "ST71a"
				var_230_0.transform.parent = arg_227_1.stage_.transform
				var_230_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_227_1.bgs_.ST71a = var_230_0
			end

			if 2 < arg_227_1.time_ and arg_227_1.time_ <= 2 + arg_230_0 then
				local var_230_1 = arg_227_1.bgs_.ST71a

				arg_227_1.bgs_.ST71a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_230_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_230_2 = var_230_1:GetComponent("SpriteRenderer")

				if var_230_2 and var_230_2.sprite then
					local var_230_3 = 2 * (var_230_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_230_1.transform.localScale = Vector3.New(var_230_3 / var_230_2.sprite.bounds.size.y < var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x and var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x or var_230_3 / var_230_2.sprite.bounds.size.y, var_230_3 / var_230_2.sprite.bounds.size.y < var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x and var_230_3 * manager.ui.mainCameraCom_.aspect / var_230_2.sprite.bounds.size.x or var_230_3 / var_230_2.sprite.bounds.size.y, 0)
				end

				for iter_230_0, iter_230_1 in pairs(arg_227_1.bgs_) do
					if iter_230_0 ~= "ST71a" then
						iter_230_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_230_4 = 4

			if 4 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1.allBtn_.enabled = false
			end

			if arg_227_1.time_ >= var_230_4 + 0.3 and arg_227_1.time_ < var_230_4 + 0.3 + arg_230_0 then
				arg_227_1.allBtn_.enabled = true
			end

			local var_230_5 = 0

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_5 + arg_230_0 then
				arg_227_1.mask_.enabled = true
				arg_227_1.mask_.raycastTarget = true

				arg_227_1:SetGaussion(false)
			end

			local var_230_6 = 2

			if var_230_5 <= arg_227_1.time_ and arg_227_1.time_ < var_230_5 + var_230_6 then
				local var_230_7 = Color.New(0, 0, 0)

				var_230_7.a = Mathf.Lerp(0, 1, (arg_227_1.time_ - var_230_5) / var_230_6)
				arg_227_1.mask_.color = var_230_7
			end

			if arg_227_1.time_ >= var_230_5 + var_230_6 and arg_227_1.time_ < var_230_5 + var_230_6 + arg_230_0 then
				local var_230_8 = Color.New(0, 0, 0)

				var_230_8.a = 1
				arg_227_1.mask_.color = var_230_8
			end

			local var_230_9 = 2

			if 2 < arg_227_1.time_ and arg_227_1.time_ <= var_230_9 + arg_230_0 then
				arg_227_1.mask_.enabled = true
				arg_227_1.mask_.raycastTarget = true

				arg_227_1:SetGaussion(false)
			end

			local var_230_10 = 2

			if var_230_9 <= arg_227_1.time_ and arg_227_1.time_ < var_230_9 + var_230_10 then
				local var_230_11 = Color.New(0, 0, 0)

				var_230_11.a = Mathf.Lerp(1, 0, (arg_227_1.time_ - var_230_9) / var_230_10)
				arg_227_1.mask_.color = var_230_11
			end

			if arg_227_1.time_ >= var_230_9 + var_230_10 and arg_227_1.time_ < var_230_9 + var_230_10 + arg_230_0 then
				local var_230_12 = Color.New(0, 0, 0)

				arg_227_1.mask_.enabled = false
				var_230_12.a = 0
				arg_227_1.mask_.color = var_230_12
			end

			local var_230_13 = arg_227_1.actors_["10098"].transform

			if 1.966 < arg_227_1.time_ and arg_227_1.time_ <= 1.966 + arg_230_0 then
				arg_227_1.var_.moveOldPos10098 = var_230_13.localPosition
				var_230_13.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("10098", 7)

				for iter_230_2 = 0, var_230_13.childCount - 1 do
					local var_230_14 = var_230_13:GetChild(iter_230_2)

					if var_230_14.name == "" or not string.find(var_230_14.name, "split") then
						var_230_14.gameObject:SetActive(true)
					else
						var_230_14.gameObject:SetActive(false)
					end
				end
			end

			local var_230_15 = 0.001

			if 1.966 <= arg_227_1.time_ and arg_227_1.time_ < 1.966 + var_230_15 then
				var_230_13.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10098, Vector3.New(0, -2000, -180), (arg_227_1.time_ - 1.966) / var_230_15)
			end

			if arg_227_1.time_ >= 1.966 + var_230_15 and arg_227_1.time_ < 1.966 + var_230_15 + arg_230_0 then
				var_230_13.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_230_16 = "10093"

			if arg_227_1.actors_["10093"] == nil then
				local var_230_17 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_230_17) then
					local var_230_18 = Object.Instantiate(var_230_17, arg_227_1.canvasGo_.transform)

					var_230_18.transform:SetSiblingIndex(1)

					var_230_18.name = var_230_16
					var_230_18.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_227_1.actors_[var_230_16] = var_230_18

					if arg_227_1.isInRecall_ then
						for iter_230_3, iter_230_4 in ipairs((var_230_18:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_230_4.color = arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_230_19 = arg_227_1.actors_["10093"].transform

			if 3.8 < arg_227_1.time_ and arg_227_1.time_ <= 3.8 + arg_230_0 then
				arg_227_1.var_.moveOldPos10093 = var_230_19.localPosition
				var_230_19.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("10093", 4)

				for iter_230_5 = 0, var_230_19.childCount - 1 do
					local var_230_20 = var_230_19:GetChild(iter_230_5)

					if var_230_20.name == "split_4" or not string.find(var_230_20.name, "split") then
						var_230_20.gameObject:SetActive(true)
					else
						var_230_20.gameObject:SetActive(false)
					end
				end
			end

			local var_230_21 = 0.001

			if 3.8 <= arg_227_1.time_ and arg_227_1.time_ < 3.8 + var_230_21 then
				var_230_19.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_227_1.time_ - 3.8) / var_230_21)
			end

			if arg_227_1.time_ >= 3.8 + var_230_21 and arg_227_1.time_ < 3.8 + var_230_21 + arg_230_0 then
				var_230_19.localPosition = Vector3.New(390, -345, -245)
			end

			local var_230_22 = arg_227_1.actors_["10098"]

			if 1.98333333333333 < arg_227_1.time_ and arg_227_1.time_ <= 1.98333333333333 + arg_230_0 and not isNil(var_230_22) and arg_227_1.var_.actorSpriteComps10098 == nil then
				arg_227_1.var_.actorSpriteComps10098 = var_230_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_23 = 0.0166666666666667

			if 1.98333333333333 <= arg_227_1.time_ and arg_227_1.time_ < 1.98333333333333 + var_230_23 and not isNil(var_230_22) then
				if arg_227_1.var_.actorSpriteComps10098 then
					for iter_230_6, iter_230_7 in pairs(arg_227_1.var_.actorSpriteComps10098:ToTable()) do
						if iter_230_7 then
							if arg_227_1.isInRecall_ then
								iter_230_7.color = Color.New(Mathf.Lerp(iter_230_7.color.r, arg_227_1.hightColor2.r, (arg_227_1.time_ - 1.98333333333333) / var_230_23), Mathf.Lerp(iter_230_7.color.g, arg_227_1.hightColor2.g, (arg_227_1.time_ - 1.98333333333333) / var_230_23), (Mathf.Lerp(iter_230_7.color.b, arg_227_1.hightColor2.b, (arg_227_1.time_ - 1.98333333333333) / var_230_23)))
							else
								local var_230_24 = Mathf.Lerp(iter_230_7.color.r, 0.5, (arg_227_1.time_ - 1.98333333333333) / var_230_23)

								iter_230_7.color = Color.New(var_230_24, var_230_24, var_230_24)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 1.98333333333333 + var_230_23 and arg_227_1.time_ < 1.98333333333333 + var_230_23 + arg_230_0 and not isNil(var_230_22) and arg_227_1.var_.actorSpriteComps10098 then
				for iter_230_8, iter_230_9 in pairs(arg_227_1.var_.actorSpriteComps10098:ToTable()) do
					if iter_230_9 then
						iter_230_9.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_227_1.var_.actorSpriteComps10098 = nil
			end

			local var_230_25 = arg_227_1.actors_["10093"]

			if 3.8 < arg_227_1.time_ and arg_227_1.time_ <= 3.8 + arg_230_0 and not isNil(var_230_25) and arg_227_1.var_.actorSpriteComps10093 == nil then
				arg_227_1.var_.actorSpriteComps10093 = var_230_25:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_26 = 0.2

			if 3.8 <= arg_227_1.time_ and arg_227_1.time_ < 3.8 + var_230_26 and not isNil(var_230_25) then
				if arg_227_1.var_.actorSpriteComps10093 then
					for iter_230_10, iter_230_11 in pairs(arg_227_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_230_11 then
							if arg_227_1.isInRecall_ then
								iter_230_11.color = Color.New(Mathf.Lerp(iter_230_11.color.r, arg_227_1.hightColor1.r, (arg_227_1.time_ - 3.8) / var_230_26), Mathf.Lerp(iter_230_11.color.g, arg_227_1.hightColor1.g, (arg_227_1.time_ - 3.8) / var_230_26), (Mathf.Lerp(iter_230_11.color.b, arg_227_1.hightColor1.b, (arg_227_1.time_ - 3.8) / var_230_26)))
							else
								local var_230_27 = Mathf.Lerp(iter_230_11.color.r, 1, (arg_227_1.time_ - 3.8) / var_230_26)

								iter_230_11.color = Color.New(var_230_27, var_230_27, var_230_27)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 3.8 + var_230_26 and arg_227_1.time_ < 3.8 + var_230_26 + arg_230_0 and not isNil(var_230_25) and arg_227_1.var_.actorSpriteComps10093 then
				for iter_230_12, iter_230_13 in pairs(arg_227_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_230_13 then
						iter_230_13.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_227_1.var_.actorSpriteComps10093 = nil
			end

			if 3.8 < arg_227_1.time_ and arg_227_1.time_ <= 3.8 + arg_230_0 then
				local var_230_28 = arg_227_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_230_28 then
					arg_227_1.var_.alphaOldValue10093 = var_230_28.alpha
					arg_227_1.var_.characterEffect10093 = var_230_28
				end

				arg_227_1.var_.alphaOldValue10093 = 0
			end

			local var_230_29 = 0.5

			if 3.8 <= arg_227_1.time_ and arg_227_1.time_ < 3.8 + var_230_29 then
				if arg_227_1.var_.characterEffect10093 then
					arg_227_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_227_1.var_.alphaOldValue10093, 1, (arg_227_1.time_ - 3.8) / var_230_29)
				end
			end

			if arg_227_1.time_ >= 3.8 + var_230_29 and arg_227_1.time_ < 3.8 + var_230_29 + arg_230_0 and arg_227_1.var_.characterEffect10093 then
				arg_227_1.var_.characterEffect10093.alpha = 1
			end

			if 2 < arg_227_1.time_ and arg_227_1.time_ <= 2 + arg_230_0 then
				arg_227_1:AudioAction("play", "music", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")

				local var_230_32 = manager.audio:GetAudioName("bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad")

				if "" ~= "" then
					if arg_227_1.bgmTxt_.text ~= var_230_32 and arg_227_1.bgmTxt_.text ~= "" then
						if arg_227_1.bgmTxt2_.text ~= "" then
							arg_227_1.bgmTxt_.text = arg_227_1.bgmTxt2_.text
						end

						arg_227_1.bgmTxt2_.text = var_230_32

						arg_227_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_227_1.bgmTxt_.text = var_230_32
						arg_227_1.bgmTxt2_.text = var_230_32
					end

					if arg_227_1.bgmTimer then
						arg_227_1.bgmTimer:Stop()

						arg_227_1.bgmTimer = nil
					end

					if arg_227_1.settingData.show_music_name == 1 then
						arg_227_1.musicController:SetSelectedState("show")
						arg_227_1.musicAnimator_:Play("open", 0, 0)

						if arg_227_1.settingData.music_time ~= 0 then
							arg_227_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_227_1.settingData.music_time), function()
								if arg_227_1 == nil or isNil(arg_227_1.bgmTxt_) then
									return
								end

								arg_227_1.musicController:SetSelectedState("hide")
								arg_227_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_227_1.frameCnt_ <= 1 then
				arg_227_1.dialog_:SetActive(false)
			end

			local var_230_33 = 4
			local var_230_34 = 0.175

			if 4 < arg_227_1.time_ and arg_227_1.time_ <= var_230_33 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0

				arg_227_1.dialog_:SetActive(true)

				arg_227_1.dialogCg_.alpha = 0

				local var_230_35 = LeanTween.value(arg_227_1.dialog_, 0, 1, 0.3)

				var_230_35:setOnUpdate(LuaHelper.FloatAction(function(arg_232_0)
					arg_227_1.dialogCg_.alpha = arg_232_0
				end))
				var_230_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_227_1.dialog_)
					var_230_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_227_1.duration_ = arg_227_1.duration_ + 0.3

				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_36 = arg_227_1:GetWordFromCfg(413051054)
				local var_230_37 = arg_227_1:FormatText(var_230_36.content)

				arg_227_1.text_.text = var_230_37

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_39 = 7 <= 0 and var_230_34 or var_230_34 * (utf8.len(var_230_37) / 7)

				if (7 <= 0 and var_230_34 or var_230_34 * (utf8.len(var_230_37) / 7)) > 0 and var_230_34 < var_230_39 then
					arg_227_1.talkMaxDuration = var_230_39
					var_230_33 = var_230_33 + 0.3

					if var_230_39 + var_230_33 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_39 + var_230_33
					end
				end

				arg_227_1.text_.text = var_230_37
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051054", "story_v_out_413051.awb") ~= 0 then
					local var_230_40 = manager.audio:GetVoiceLength("story_v_out_413051", "413051054", "story_v_out_413051.awb") / 1000

					if var_230_40 + var_230_33 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_40 + var_230_33
					end

					if var_230_36.prefab_name ~= "" and arg_227_1.actors_[var_230_36.prefab_name] ~= nil then
						local var_230_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_36.prefab_name].transform, "story_v_out_413051", "413051054", "story_v_out_413051.awb")

						arg_227_1:RecordAudio("413051054", var_230_41)
						arg_227_1:RecordAudio("413051054", var_230_41)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_413051", "413051054", "story_v_out_413051.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_413051", "413051054", "story_v_out_413051.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_42 = var_230_33 + 0.3
			local var_230_43 = math.max(var_230_34, arg_227_1.talkMaxDuration)

			if var_230_33 + 0.3 <= arg_227_1.time_ and arg_227_1.time_ < var_230_42 + var_230_43 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_42) / var_230_43

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_42 + var_230_43 and arg_227_1.time_ < var_230_42 + var_230_43 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10098",
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

		arg_227_1:InitPlayNodeList()
	end,
	Play413051055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 413051055
		arg_234_1.duration_ = 6.3

		local var_234_0 = {
			zh = 5.1,
			ja = 6.3
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play413051056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if arg_234_1.actors_["10022"] == nil then
				local var_237_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_237_0) then
					local var_237_1 = Object.Instantiate(var_237_0, arg_234_1.canvasGo_.transform)

					var_237_1.transform:SetSiblingIndex(1)

					var_237_1.name = "10022"
					var_237_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_234_1.actors_["10022"] = var_237_1

					if arg_234_1.isInRecall_ then
						for iter_237_0, iter_237_1 in ipairs((var_237_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_237_1.color = arg_234_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_237_2 = arg_234_1.actors_["10022"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos10022 = var_237_2.localPosition
				var_237_2.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("10022", 2)

				for iter_237_2 = 0, var_237_2.childCount - 1 do
					local var_237_3 = var_237_2:GetChild(iter_237_2)

					if var_237_3.name == "split_6" or not string.find(var_237_3.name, "split") then
						var_237_3.gameObject:SetActive(true)
					else
						var_237_3.gameObject:SetActive(false)
					end
				end
			end

			local var_237_4 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 then
				var_237_2.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_234_1.time_ - 0) / var_237_4)
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 then
				var_237_2.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_237_5 = arg_234_1.actors_["10093"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_5) and arg_234_1.var_.actorSpriteComps10093 == nil then
				arg_234_1.var_.actorSpriteComps10093 = var_237_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_6 = 2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_6 and not isNil(var_237_5) then
				if arg_234_1.var_.actorSpriteComps10093 then
					for iter_237_3, iter_237_4 in pairs(arg_234_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_237_4 then
							if arg_234_1.isInRecall_ then
								iter_237_4.color = Color.New(Mathf.Lerp(iter_237_4.color.r, arg_234_1.hightColor2.r, (arg_234_1.time_ - 0) / var_237_6), Mathf.Lerp(iter_237_4.color.g, arg_234_1.hightColor2.g, (arg_234_1.time_ - 0) / var_237_6), (Mathf.Lerp(iter_237_4.color.b, arg_234_1.hightColor2.b, (arg_234_1.time_ - 0) / var_237_6)))
							else
								local var_237_7 = Mathf.Lerp(iter_237_4.color.r, 0.5, (arg_234_1.time_ - 0) / var_237_6)

								iter_237_4.color = Color.New(var_237_7, var_237_7, var_237_7)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= 0 + var_237_6 and arg_234_1.time_ < 0 + var_237_6 + arg_237_0 and not isNil(var_237_5) and arg_234_1.var_.actorSpriteComps10093 then
				for iter_237_5, iter_237_6 in pairs(arg_234_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_237_6 then
						iter_237_6.color = arg_234_1.isInRecall_ and (arg_234_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_234_1.var_.actorSpriteComps10093 = nil
			end

			local var_237_8 = arg_234_1.actors_["10022"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_8) and arg_234_1.var_.actorSpriteComps10022 == nil then
				arg_234_1.var_.actorSpriteComps10022 = var_237_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_9 = 2

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_9 and not isNil(var_237_8) then
				if arg_234_1.var_.actorSpriteComps10022 then
					for iter_237_7, iter_237_8 in pairs(arg_234_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_237_8 then
							if arg_234_1.isInRecall_ then
								iter_237_8.color = Color.New(Mathf.Lerp(iter_237_8.color.r, arg_234_1.hightColor1.r, (arg_234_1.time_ - 0) / var_237_9), Mathf.Lerp(iter_237_8.color.g, arg_234_1.hightColor1.g, (arg_234_1.time_ - 0) / var_237_9), (Mathf.Lerp(iter_237_8.color.b, arg_234_1.hightColor1.b, (arg_234_1.time_ - 0) / var_237_9)))
							else
								local var_237_10 = Mathf.Lerp(iter_237_8.color.r, 1, (arg_234_1.time_ - 0) / var_237_9)

								iter_237_8.color = Color.New(var_237_10, var_237_10, var_237_10)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= 0 + var_237_9 and arg_234_1.time_ < 0 + var_237_9 + arg_237_0 and not isNil(var_237_8) and arg_234_1.var_.actorSpriteComps10022 then
				for iter_237_9, iter_237_10 in pairs(arg_234_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_237_10 then
						iter_237_10.color = arg_234_1.isInRecall_ and (arg_234_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_234_1.var_.actorSpriteComps10022 = nil
			end

			local var_237_11 = arg_234_1.actors_["10093"].transform

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos10093 = var_237_11.localPosition
				var_237_11.localScale = Vector3.New(1, 1, 1)

				arg_234_1:CheckSpriteTmpPos("10093", 4)

				for iter_237_11 = 0, var_237_11.childCount - 1 do
					local var_237_12 = var_237_11:GetChild(iter_237_11)

					if var_237_12.name == "split_4" or not string.find(var_237_12.name, "split") then
						var_237_12.gameObject:SetActive(true)
					else
						var_237_12.gameObject:SetActive(false)
					end
				end
			end

			local var_237_13 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_13 then
				var_237_11.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_234_1.time_ - 0) / var_237_13)
			end

			if arg_234_1.time_ >= 0 + var_237_13 and arg_234_1.time_ < 0 + var_237_13 + arg_237_0 then
				var_237_11.localPosition = Vector3.New(390, -345, -245)
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				local var_237_14 = arg_234_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_237_14 then
					arg_234_1.var_.alphaOldValue10022 = var_237_14.alpha
					arg_234_1.var_.characterEffect10022 = var_237_14
				end

				arg_234_1.var_.alphaOldValue10022 = 0
			end

			local var_237_15 = 0.5

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_15 then
				if arg_234_1.var_.characterEffect10022 then
					arg_234_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_234_1.var_.alphaOldValue10022, 1, (arg_234_1.time_ - 0) / var_237_15)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_15 and arg_234_1.time_ < 0 + var_237_15 + arg_237_0 and arg_234_1.var_.characterEffect10022 then
				arg_234_1.var_.characterEffect10022.alpha = 1
			end

			local var_237_16 = 0
			local var_237_17 = 0.45

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_16 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_18 = arg_234_1:GetWordFromCfg(413051055)
				local var_237_19 = arg_234_1:FormatText(var_237_18.content)

				arg_234_1.text_.text = var_237_19

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_21 = 18 <= 0 and var_237_17 or var_237_17 * (utf8.len(var_237_19) / 18)

				if (18 <= 0 and var_237_17 or var_237_17 * (utf8.len(var_237_19) / 18)) > 0 and var_237_17 < var_237_21 then
					arg_234_1.talkMaxDuration = var_237_21

					if var_237_21 + var_237_16 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_21 + var_237_16
					end
				end

				arg_234_1.text_.text = var_237_19
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051055", "story_v_out_413051.awb") ~= 0 then
					local var_237_22 = manager.audio:GetVoiceLength("story_v_out_413051", "413051055", "story_v_out_413051.awb") / 1000

					if var_237_22 + var_237_16 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_22 + var_237_16
					end

					if var_237_18.prefab_name ~= "" and arg_234_1.actors_[var_237_18.prefab_name] ~= nil then
						local var_237_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_18.prefab_name].transform, "story_v_out_413051", "413051055", "story_v_out_413051.awb")

						arg_234_1:RecordAudio("413051055", var_237_23)
						arg_234_1:RecordAudio("413051055", var_237_23)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_413051", "413051055", "story_v_out_413051.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_413051", "413051055", "story_v_out_413051.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_24 = math.max(var_237_17, arg_234_1.talkMaxDuration)

			if var_237_16 <= arg_234_1.time_ and arg_234_1.time_ < var_237_16 + var_237_24 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_16) / var_237_24

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_16 + var_237_24 and arg_234_1.time_ < var_237_16 + var_237_24 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
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
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play413051056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 413051056
		arg_238_1.duration_ = 4.23

		local var_238_0 = {
			zh = 3,
			ja = 4.233
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play413051057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos10093 = arg_238_1.actors_["10093"].transform.localPosition
				arg_238_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("10093", 4)

				for iter_241_0 = 0, arg_238_1.actors_["10093"].transform.childCount - 1 do
					local var_241_0 = arg_238_1.actors_["10093"].transform:GetChild(iter_241_0)

					if var_241_0.name == "split_6" or not string.find(var_241_0.name, "split") then
						var_241_0.gameObject:SetActive(true)
					else
						var_241_0.gameObject:SetActive(false)
					end
				end
			end

			local var_241_1 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_1 then
				arg_238_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_238_1.time_ - 0) / var_241_1)
			end

			if arg_238_1.time_ >= 0 + var_241_1 and arg_238_1.time_ < 0 + var_241_1 + arg_241_0 then
				arg_238_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_241_2 = arg_238_1.actors_["10022"].transform

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos10022 = var_241_2.localPosition
				var_241_2.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("10022", 2)

				for iter_241_1 = 0, var_241_2.childCount - 1 do
					local var_241_3 = var_241_2:GetChild(iter_241_1)

					if var_241_3.name == "" or not string.find(var_241_3.name, "split") then
						var_241_3.gameObject:SetActive(true)
					else
						var_241_3.gameObject:SetActive(false)
					end
				end
			end

			local var_241_4 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_4 then
				var_241_2.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_238_1.time_ - 0) / var_241_4)
			end

			if arg_238_1.time_ >= 0 + var_241_4 and arg_238_1.time_ < 0 + var_241_4 + arg_241_0 then
				var_241_2.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_241_5 = arg_238_1.actors_["10093"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_5) and arg_238_1.var_.actorSpriteComps10093 == nil then
				arg_238_1.var_.actorSpriteComps10093 = var_241_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_6 = 2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_6 and not isNil(var_241_5) then
				if arg_238_1.var_.actorSpriteComps10093 then
					for iter_241_2, iter_241_3 in pairs(arg_238_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_241_3 then
							if arg_238_1.isInRecall_ then
								iter_241_3.color = Color.New(Mathf.Lerp(iter_241_3.color.r, arg_238_1.hightColor1.r, (arg_238_1.time_ - 0) / var_241_6), Mathf.Lerp(iter_241_3.color.g, arg_238_1.hightColor1.g, (arg_238_1.time_ - 0) / var_241_6), (Mathf.Lerp(iter_241_3.color.b, arg_238_1.hightColor1.b, (arg_238_1.time_ - 0) / var_241_6)))
							else
								local var_241_7 = Mathf.Lerp(iter_241_3.color.r, 1, (arg_238_1.time_ - 0) / var_241_6)

								iter_241_3.color = Color.New(var_241_7, var_241_7, var_241_7)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= 0 + var_241_6 and arg_238_1.time_ < 0 + var_241_6 + arg_241_0 and not isNil(var_241_5) and arg_238_1.var_.actorSpriteComps10093 then
				for iter_241_4, iter_241_5 in pairs(arg_238_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_241_5 then
						iter_241_5.color = arg_238_1.isInRecall_ and (arg_238_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_238_1.var_.actorSpriteComps10093 = nil
			end

			local var_241_8 = arg_238_1.actors_["10022"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_8) and arg_238_1.var_.actorSpriteComps10022 == nil then
				arg_238_1.var_.actorSpriteComps10022 = var_241_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_9 = 2

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_9 and not isNil(var_241_8) then
				if arg_238_1.var_.actorSpriteComps10022 then
					for iter_241_6, iter_241_7 in pairs(arg_238_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_241_7 then
							if arg_238_1.isInRecall_ then
								iter_241_7.color = Color.New(Mathf.Lerp(iter_241_7.color.r, arg_238_1.hightColor2.r, (arg_238_1.time_ - 0) / var_241_9), Mathf.Lerp(iter_241_7.color.g, arg_238_1.hightColor2.g, (arg_238_1.time_ - 0) / var_241_9), (Mathf.Lerp(iter_241_7.color.b, arg_238_1.hightColor2.b, (arg_238_1.time_ - 0) / var_241_9)))
							else
								local var_241_10 = Mathf.Lerp(iter_241_7.color.r, 0.5, (arg_238_1.time_ - 0) / var_241_9)

								iter_241_7.color = Color.New(var_241_10, var_241_10, var_241_10)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= 0 + var_241_9 and arg_238_1.time_ < 0 + var_241_9 + arg_241_0 and not isNil(var_241_8) and arg_238_1.var_.actorSpriteComps10022 then
				for iter_241_8, iter_241_9 in pairs(arg_238_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_241_9 then
						iter_241_9.color = arg_238_1.isInRecall_ and (arg_238_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_238_1.var_.actorSpriteComps10022 = nil
			end

			local var_241_11 = 0
			local var_241_12 = 0.3

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_11 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_13 = arg_238_1:GetWordFromCfg(413051056)
				local var_241_14 = arg_238_1:FormatText(var_241_13.content)

				arg_238_1.text_.text = var_241_14

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_16 = 12 <= 0 and var_241_12 or var_241_12 * (utf8.len(var_241_14) / 12)

				if (12 <= 0 and var_241_12 or var_241_12 * (utf8.len(var_241_14) / 12)) > 0 and var_241_12 < var_241_16 then
					arg_238_1.talkMaxDuration = var_241_16

					if var_241_16 + var_241_11 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_16 + var_241_11
					end
				end

				arg_238_1.text_.text = var_241_14
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051056", "story_v_out_413051.awb") ~= 0 then
					local var_241_17 = manager.audio:GetVoiceLength("story_v_out_413051", "413051056", "story_v_out_413051.awb") / 1000

					if var_241_17 + var_241_11 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_17 + var_241_11
					end

					if var_241_13.prefab_name ~= "" and arg_238_1.actors_[var_241_13.prefab_name] ~= nil then
						local var_241_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_13.prefab_name].transform, "story_v_out_413051", "413051056", "story_v_out_413051.awb")

						arg_238_1:RecordAudio("413051056", var_241_18)
						arg_238_1:RecordAudio("413051056", var_241_18)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_413051", "413051056", "story_v_out_413051.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_413051", "413051056", "story_v_out_413051.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_19 = math.max(var_241_12, arg_238_1.talkMaxDuration)

			if var_241_11 <= arg_238_1.time_ and arg_238_1.time_ < var_241_11 + var_241_19 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_11) / var_241_19

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_11 + var_241_19 and arg_238_1.time_ < var_241_11 + var_241_19 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
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

		arg_238_1:InitPlayNodeList()
	end,
	Play413051057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 413051057
		arg_242_1.duration_ = 3.73

		local var_242_0 = {
			zh = 1.999999999999,
			ja = 3.733
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
				arg_242_0:Play413051058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos10022 = arg_242_1.actors_["10022"].transform.localPosition
				arg_242_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("10022", 2)

				for iter_245_0 = 0, arg_242_1.actors_["10022"].transform.childCount - 1 do
					local var_245_0 = arg_242_1.actors_["10022"].transform:GetChild(iter_245_0)

					if var_245_0.name == "split_2" or not string.find(var_245_0.name, "split") then
						var_245_0.gameObject:SetActive(true)
					else
						var_245_0.gameObject:SetActive(false)
					end
				end
			end

			local var_245_1 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_1 then
				arg_242_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_242_1.time_ - 0) / var_245_1)
			end

			if arg_242_1.time_ >= 0 + var_245_1 and arg_242_1.time_ < 0 + var_245_1 + arg_245_0 then
				arg_242_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_245_2 = arg_242_1.actors_["10093"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_2) and arg_242_1.var_.actorSpriteComps10093 == nil then
				arg_242_1.var_.actorSpriteComps10093 = var_245_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_3 = 2

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_3 and not isNil(var_245_2) then
				if arg_242_1.var_.actorSpriteComps10093 then
					for iter_245_1, iter_245_2 in pairs(arg_242_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_245_2 then
							if arg_242_1.isInRecall_ then
								iter_245_2.color = Color.New(Mathf.Lerp(iter_245_2.color.r, arg_242_1.hightColor2.r, (arg_242_1.time_ - 0) / var_245_3), Mathf.Lerp(iter_245_2.color.g, arg_242_1.hightColor2.g, (arg_242_1.time_ - 0) / var_245_3), (Mathf.Lerp(iter_245_2.color.b, arg_242_1.hightColor2.b, (arg_242_1.time_ - 0) / var_245_3)))
							else
								local var_245_4 = Mathf.Lerp(iter_245_2.color.r, 0.5, (arg_242_1.time_ - 0) / var_245_3)

								iter_245_2.color = Color.New(var_245_4, var_245_4, var_245_4)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= 0 + var_245_3 and arg_242_1.time_ < 0 + var_245_3 + arg_245_0 and not isNil(var_245_2) and arg_242_1.var_.actorSpriteComps10093 then
				for iter_245_3, iter_245_4 in pairs(arg_242_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_245_4 then
						iter_245_4.color = arg_242_1.isInRecall_ and (arg_242_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_242_1.var_.actorSpriteComps10093 = nil
			end

			local var_245_5 = arg_242_1.actors_["10022"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_5) and arg_242_1.var_.actorSpriteComps10022 == nil then
				arg_242_1.var_.actorSpriteComps10022 = var_245_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_6 = 2

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_6 and not isNil(var_245_5) then
				if arg_242_1.var_.actorSpriteComps10022 then
					for iter_245_5, iter_245_6 in pairs(arg_242_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_245_6 then
							if arg_242_1.isInRecall_ then
								iter_245_6.color = Color.New(Mathf.Lerp(iter_245_6.color.r, arg_242_1.hightColor1.r, (arg_242_1.time_ - 0) / var_245_6), Mathf.Lerp(iter_245_6.color.g, arg_242_1.hightColor1.g, (arg_242_1.time_ - 0) / var_245_6), (Mathf.Lerp(iter_245_6.color.b, arg_242_1.hightColor1.b, (arg_242_1.time_ - 0) / var_245_6)))
							else
								local var_245_7 = Mathf.Lerp(iter_245_6.color.r, 1, (arg_242_1.time_ - 0) / var_245_6)

								iter_245_6.color = Color.New(var_245_7, var_245_7, var_245_7)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= 0 + var_245_6 and arg_242_1.time_ < 0 + var_245_6 + arg_245_0 and not isNil(var_245_5) and arg_242_1.var_.actorSpriteComps10022 then
				for iter_245_7, iter_245_8 in pairs(arg_242_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_245_8 then
						iter_245_8.color = arg_242_1.isInRecall_ and (arg_242_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_242_1.var_.actorSpriteComps10022 = nil
			end

			local var_245_8 = 0
			local var_245_9 = 0.15

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_8 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_10 = arg_242_1:GetWordFromCfg(413051057)
				local var_245_11 = arg_242_1:FormatText(var_245_10.content)

				arg_242_1.text_.text = var_245_11

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_13 = 6 <= 0 and var_245_9 or var_245_9 * (utf8.len(var_245_11) / 6)

				if (6 <= 0 and var_245_9 or var_245_9 * (utf8.len(var_245_11) / 6)) > 0 and var_245_9 < var_245_13 then
					arg_242_1.talkMaxDuration = var_245_13

					if var_245_13 + var_245_8 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_13 + var_245_8
					end
				end

				arg_242_1.text_.text = var_245_11
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051057", "story_v_out_413051.awb") ~= 0 then
					local var_245_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051057", "story_v_out_413051.awb") / 1000

					if var_245_14 + var_245_8 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_14 + var_245_8
					end

					if var_245_10.prefab_name ~= "" and arg_242_1.actors_[var_245_10.prefab_name] ~= nil then
						local var_245_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_10.prefab_name].transform, "story_v_out_413051", "413051057", "story_v_out_413051.awb")

						arg_242_1:RecordAudio("413051057", var_245_15)
						arg_242_1:RecordAudio("413051057", var_245_15)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_413051", "413051057", "story_v_out_413051.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_413051", "413051057", "story_v_out_413051.awb")
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
				actorName = "10022",
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
	Play413051058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 413051058
		arg_246_1.duration_ = 8.37

		local var_246_0 = {
			zh = 3.766,
			ja = 8.366
		}
		local var_246_1 = manager.audio:GetLocalizationFlag()

		if var_246_0[var_246_1] ~= nil then
			arg_246_1.duration_ = var_246_0[var_246_1]
		end

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play413051059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos10093 = arg_246_1.actors_["10093"].transform.localPosition
				arg_246_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_246_1:CheckSpriteTmpPos("10093", 4)

				for iter_249_0 = 0, arg_246_1.actors_["10093"].transform.childCount - 1 do
					local var_249_0 = arg_246_1.actors_["10093"].transform:GetChild(iter_249_0)

					if var_249_0.name == "split_5" or not string.find(var_249_0.name, "split") then
						var_249_0.gameObject:SetActive(true)
					else
						var_249_0.gameObject:SetActive(false)
					end
				end
			end

			local var_249_1 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_1 then
				arg_246_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_246_1.time_ - 0) / var_249_1)
			end

			if arg_246_1.time_ >= 0 + var_249_1 and arg_246_1.time_ < 0 + var_249_1 + arg_249_0 then
				arg_246_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_249_2 = arg_246_1.actors_["10093"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_2) and arg_246_1.var_.actorSpriteComps10093 == nil then
				arg_246_1.var_.actorSpriteComps10093 = var_249_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_3 = 2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_3 and not isNil(var_249_2) then
				if arg_246_1.var_.actorSpriteComps10093 then
					for iter_249_1, iter_249_2 in pairs(arg_246_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_249_2 then
							if arg_246_1.isInRecall_ then
								iter_249_2.color = Color.New(Mathf.Lerp(iter_249_2.color.r, arg_246_1.hightColor1.r, (arg_246_1.time_ - 0) / var_249_3), Mathf.Lerp(iter_249_2.color.g, arg_246_1.hightColor1.g, (arg_246_1.time_ - 0) / var_249_3), (Mathf.Lerp(iter_249_2.color.b, arg_246_1.hightColor1.b, (arg_246_1.time_ - 0) / var_249_3)))
							else
								local var_249_4 = Mathf.Lerp(iter_249_2.color.r, 1, (arg_246_1.time_ - 0) / var_249_3)

								iter_249_2.color = Color.New(var_249_4, var_249_4, var_249_4)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= 0 + var_249_3 and arg_246_1.time_ < 0 + var_249_3 + arg_249_0 and not isNil(var_249_2) and arg_246_1.var_.actorSpriteComps10093 then
				for iter_249_3, iter_249_4 in pairs(arg_246_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_249_4 then
						iter_249_4.color = arg_246_1.isInRecall_ and (arg_246_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_246_1.var_.actorSpriteComps10093 = nil
			end

			local var_249_5 = arg_246_1.actors_["10022"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_5) and arg_246_1.var_.actorSpriteComps10022 == nil then
				arg_246_1.var_.actorSpriteComps10022 = var_249_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_6 = 2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_6 and not isNil(var_249_5) then
				if arg_246_1.var_.actorSpriteComps10022 then
					for iter_249_5, iter_249_6 in pairs(arg_246_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_249_6 then
							if arg_246_1.isInRecall_ then
								iter_249_6.color = Color.New(Mathf.Lerp(iter_249_6.color.r, arg_246_1.hightColor2.r, (arg_246_1.time_ - 0) / var_249_6), Mathf.Lerp(iter_249_6.color.g, arg_246_1.hightColor2.g, (arg_246_1.time_ - 0) / var_249_6), (Mathf.Lerp(iter_249_6.color.b, arg_246_1.hightColor2.b, (arg_246_1.time_ - 0) / var_249_6)))
							else
								local var_249_7 = Mathf.Lerp(iter_249_6.color.r, 0.5, (arg_246_1.time_ - 0) / var_249_6)

								iter_249_6.color = Color.New(var_249_7, var_249_7, var_249_7)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= 0 + var_249_6 and arg_246_1.time_ < 0 + var_249_6 + arg_249_0 and not isNil(var_249_5) and arg_246_1.var_.actorSpriteComps10022 then
				for iter_249_7, iter_249_8 in pairs(arg_246_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_249_8 then
						iter_249_8.color = arg_246_1.isInRecall_ and (arg_246_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_246_1.var_.actorSpriteComps10022 = nil
			end

			local var_249_8 = 0
			local var_249_9 = 0.325

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_8 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_10 = arg_246_1:GetWordFromCfg(413051058)
				local var_249_11 = arg_246_1:FormatText(var_249_10.content)

				arg_246_1.text_.text = var_249_11

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_13 = 13 <= 0 and var_249_9 or var_249_9 * (utf8.len(var_249_11) / 13)

				if (13 <= 0 and var_249_9 or var_249_9 * (utf8.len(var_249_11) / 13)) > 0 and var_249_9 < var_249_13 then
					arg_246_1.talkMaxDuration = var_249_13

					if var_249_13 + var_249_8 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_13 + var_249_8
					end
				end

				arg_246_1.text_.text = var_249_11
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051058", "story_v_out_413051.awb") ~= 0 then
					local var_249_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051058", "story_v_out_413051.awb") / 1000

					if var_249_14 + var_249_8 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_14 + var_249_8
					end

					if var_249_10.prefab_name ~= "" and arg_246_1.actors_[var_249_10.prefab_name] ~= nil then
						local var_249_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_10.prefab_name].transform, "story_v_out_413051", "413051058", "story_v_out_413051.awb")

						arg_246_1:RecordAudio("413051058", var_249_15)
						arg_246_1:RecordAudio("413051058", var_249_15)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_413051", "413051058", "story_v_out_413051.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_413051", "413051058", "story_v_out_413051.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_16 = math.max(var_249_9, arg_246_1.talkMaxDuration)

			if var_249_8 <= arg_246_1.time_ and arg_246_1.time_ < var_249_8 + var_249_16 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_8) / var_249_16

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_8 + var_249_16 and arg_246_1.time_ < var_249_8 + var_249_16 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
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

		arg_246_1:InitPlayNodeList()
	end,
	Play413051059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 413051059
		arg_250_1.duration_ = 6.4

		local var_250_0 = {
			zh = 3.933,
			ja = 6.4
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
				arg_250_0:Play413051060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos10022 = arg_250_1.actors_["10022"].transform.localPosition
				arg_250_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_250_1:CheckSpriteTmpPos("10022", 2)

				for iter_253_0 = 0, arg_250_1.actors_["10022"].transform.childCount - 1 do
					local var_253_0 = arg_250_1.actors_["10022"].transform:GetChild(iter_253_0)

					if var_253_0.name == "split_8" or not string.find(var_253_0.name, "split") then
						var_253_0.gameObject:SetActive(true)
					else
						var_253_0.gameObject:SetActive(false)
					end
				end
			end

			local var_253_1 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_1 then
				arg_250_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_250_1.time_ - 0) / var_253_1)
			end

			if arg_250_1.time_ >= 0 + var_253_1 and arg_250_1.time_ < 0 + var_253_1 + arg_253_0 then
				arg_250_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_253_2 = arg_250_1.actors_["10093"]

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(var_253_2) and arg_250_1.var_.actorSpriteComps10093 == nil then
				arg_250_1.var_.actorSpriteComps10093 = var_253_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_3 = 2

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_3 and not isNil(var_253_2) then
				if arg_250_1.var_.actorSpriteComps10093 then
					for iter_253_1, iter_253_2 in pairs(arg_250_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_253_2 then
							if arg_250_1.isInRecall_ then
								iter_253_2.color = Color.New(Mathf.Lerp(iter_253_2.color.r, arg_250_1.hightColor2.r, (arg_250_1.time_ - 0) / var_253_3), Mathf.Lerp(iter_253_2.color.g, arg_250_1.hightColor2.g, (arg_250_1.time_ - 0) / var_253_3), (Mathf.Lerp(iter_253_2.color.b, arg_250_1.hightColor2.b, (arg_250_1.time_ - 0) / var_253_3)))
							else
								local var_253_4 = Mathf.Lerp(iter_253_2.color.r, 0.5, (arg_250_1.time_ - 0) / var_253_3)

								iter_253_2.color = Color.New(var_253_4, var_253_4, var_253_4)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= 0 + var_253_3 and arg_250_1.time_ < 0 + var_253_3 + arg_253_0 and not isNil(var_253_2) and arg_250_1.var_.actorSpriteComps10093 then
				for iter_253_3, iter_253_4 in pairs(arg_250_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_253_4 then
						iter_253_4.color = arg_250_1.isInRecall_ and (arg_250_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_250_1.var_.actorSpriteComps10093 = nil
			end

			local var_253_5 = arg_250_1.actors_["10022"]

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(var_253_5) and arg_250_1.var_.actorSpriteComps10022 == nil then
				arg_250_1.var_.actorSpriteComps10022 = var_253_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_6 = 2

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_6 and not isNil(var_253_5) then
				if arg_250_1.var_.actorSpriteComps10022 then
					for iter_253_5, iter_253_6 in pairs(arg_250_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_253_6 then
							if arg_250_1.isInRecall_ then
								iter_253_6.color = Color.New(Mathf.Lerp(iter_253_6.color.r, arg_250_1.hightColor1.r, (arg_250_1.time_ - 0) / var_253_6), Mathf.Lerp(iter_253_6.color.g, arg_250_1.hightColor1.g, (arg_250_1.time_ - 0) / var_253_6), (Mathf.Lerp(iter_253_6.color.b, arg_250_1.hightColor1.b, (arg_250_1.time_ - 0) / var_253_6)))
							else
								local var_253_7 = Mathf.Lerp(iter_253_6.color.r, 1, (arg_250_1.time_ - 0) / var_253_6)

								iter_253_6.color = Color.New(var_253_7, var_253_7, var_253_7)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= 0 + var_253_6 and arg_250_1.time_ < 0 + var_253_6 + arg_253_0 and not isNil(var_253_5) and arg_250_1.var_.actorSpriteComps10022 then
				for iter_253_7, iter_253_8 in pairs(arg_250_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_253_8 then
						iter_253_8.color = arg_250_1.isInRecall_ and (arg_250_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_250_1.var_.actorSpriteComps10022 = nil
			end

			local var_253_8 = 0
			local var_253_9 = 0.525

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_8 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_10 = arg_250_1:GetWordFromCfg(413051059)
				local var_253_11 = arg_250_1:FormatText(var_253_10.content)

				arg_250_1.text_.text = var_253_11

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_13 = 21 <= 0 and var_253_9 or var_253_9 * (utf8.len(var_253_11) / 21)

				if (21 <= 0 and var_253_9 or var_253_9 * (utf8.len(var_253_11) / 21)) > 0 and var_253_9 < var_253_13 then
					arg_250_1.talkMaxDuration = var_253_13

					if var_253_13 + var_253_8 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_13 + var_253_8
					end
				end

				arg_250_1.text_.text = var_253_11
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051059", "story_v_out_413051.awb") ~= 0 then
					local var_253_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051059", "story_v_out_413051.awb") / 1000

					if var_253_14 + var_253_8 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_14 + var_253_8
					end

					if var_253_10.prefab_name ~= "" and arg_250_1.actors_[var_253_10.prefab_name] ~= nil then
						local var_253_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_10.prefab_name].transform, "story_v_out_413051", "413051059", "story_v_out_413051.awb")

						arg_250_1:RecordAudio("413051059", var_253_15)
						arg_250_1:RecordAudio("413051059", var_253_15)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_413051", "413051059", "story_v_out_413051.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_413051", "413051059", "story_v_out_413051.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_16 = math.max(var_253_9, arg_250_1.talkMaxDuration)

			if var_253_8 <= arg_250_1.time_ and arg_250_1.time_ < var_253_8 + var_253_16 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_8) / var_253_16

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_8 + var_253_16 and arg_250_1.time_ < var_253_8 + var_253_16 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
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

		arg_250_1:InitPlayNodeList()
	end,
	Play413051060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 413051060
		arg_254_1.duration_ = 6

		local var_254_0 = {
			zh = 5.5,
			ja = 6
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
				arg_254_0:Play413051061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = 0.75

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_1 = arg_254_1:GetWordFromCfg(413051060)
				local var_257_2 = arg_254_1:FormatText(var_257_1.content)

				arg_254_1.text_.text = var_257_2

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_4 = 30 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_2) / 30)

				if (30 <= 0 and var_257_0 or var_257_0 * (utf8.len(var_257_2) / 30)) > 0 and var_257_0 < var_257_4 then
					arg_254_1.talkMaxDuration = var_257_4

					if var_257_4 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_4 + 0
					end
				end

				arg_254_1.text_.text = var_257_2
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051060", "story_v_out_413051.awb") ~= 0 then
					local var_257_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051060", "story_v_out_413051.awb") / 1000

					if var_257_5 + 0 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_5 + 0
					end

					if var_257_1.prefab_name ~= "" and arg_254_1.actors_[var_257_1.prefab_name] ~= nil then
						local var_257_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_1.prefab_name].transform, "story_v_out_413051", "413051060", "story_v_out_413051.awb")

						arg_254_1:RecordAudio("413051060", var_257_6)
						arg_254_1:RecordAudio("413051060", var_257_6)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_413051", "413051060", "story_v_out_413051.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_413051", "413051060", "story_v_out_413051.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_7 = math.max(var_257_0, arg_254_1.talkMaxDuration)

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_7 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - 0) / var_257_7

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= 0 + var_257_7 and arg_254_1.time_ < 0 + var_257_7 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play413051061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 413051061
		arg_258_1.duration_ = 7.83

		local var_258_0 = {
			zh = 7.833,
			ja = 7.133
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
				arg_258_0:Play413051062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos10093 = arg_258_1.actors_["10093"].transform.localPosition
				arg_258_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("10093", 4)

				for iter_261_0 = 0, arg_258_1.actors_["10093"].transform.childCount - 1 do
					local var_261_0 = arg_258_1.actors_["10093"].transform:GetChild(iter_261_0)

					if var_261_0.name == "split_4" or not string.find(var_261_0.name, "split") then
						var_261_0.gameObject:SetActive(true)
					else
						var_261_0.gameObject:SetActive(false)
					end
				end
			end

			local var_261_1 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_1 then
				arg_258_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_258_1.time_ - 0) / var_261_1)
			end

			if arg_258_1.time_ >= 0 + var_261_1 and arg_258_1.time_ < 0 + var_261_1 + arg_261_0 then
				arg_258_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_261_2 = arg_258_1.actors_["10093"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_2) and arg_258_1.var_.actorSpriteComps10093 == nil then
				arg_258_1.var_.actorSpriteComps10093 = var_261_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_3 = 2

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_3 and not isNil(var_261_2) then
				if arg_258_1.var_.actorSpriteComps10093 then
					for iter_261_1, iter_261_2 in pairs(arg_258_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_261_2 then
							if arg_258_1.isInRecall_ then
								iter_261_2.color = Color.New(Mathf.Lerp(iter_261_2.color.r, arg_258_1.hightColor1.r, (arg_258_1.time_ - 0) / var_261_3), Mathf.Lerp(iter_261_2.color.g, arg_258_1.hightColor1.g, (arg_258_1.time_ - 0) / var_261_3), (Mathf.Lerp(iter_261_2.color.b, arg_258_1.hightColor1.b, (arg_258_1.time_ - 0) / var_261_3)))
							else
								local var_261_4 = Mathf.Lerp(iter_261_2.color.r, 1, (arg_258_1.time_ - 0) / var_261_3)

								iter_261_2.color = Color.New(var_261_4, var_261_4, var_261_4)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= 0 + var_261_3 and arg_258_1.time_ < 0 + var_261_3 + arg_261_0 and not isNil(var_261_2) and arg_258_1.var_.actorSpriteComps10093 then
				for iter_261_3, iter_261_4 in pairs(arg_258_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_261_4 then
						iter_261_4.color = arg_258_1.isInRecall_ and (arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_258_1.var_.actorSpriteComps10093 = nil
			end

			local var_261_5 = arg_258_1.actors_["10022"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_5) and arg_258_1.var_.actorSpriteComps10022 == nil then
				arg_258_1.var_.actorSpriteComps10022 = var_261_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_6 = 2

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_6 and not isNil(var_261_5) then
				if arg_258_1.var_.actorSpriteComps10022 then
					for iter_261_5, iter_261_6 in pairs(arg_258_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_261_6 then
							if arg_258_1.isInRecall_ then
								iter_261_6.color = Color.New(Mathf.Lerp(iter_261_6.color.r, arg_258_1.hightColor2.r, (arg_258_1.time_ - 0) / var_261_6), Mathf.Lerp(iter_261_6.color.g, arg_258_1.hightColor2.g, (arg_258_1.time_ - 0) / var_261_6), (Mathf.Lerp(iter_261_6.color.b, arg_258_1.hightColor2.b, (arg_258_1.time_ - 0) / var_261_6)))
							else
								local var_261_7 = Mathf.Lerp(iter_261_6.color.r, 0.5, (arg_258_1.time_ - 0) / var_261_6)

								iter_261_6.color = Color.New(var_261_7, var_261_7, var_261_7)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= 0 + var_261_6 and arg_258_1.time_ < 0 + var_261_6 + arg_261_0 and not isNil(var_261_5) and arg_258_1.var_.actorSpriteComps10022 then
				for iter_261_7, iter_261_8 in pairs(arg_258_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_261_8 then
						iter_261_8.color = arg_258_1.isInRecall_ and (arg_258_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_258_1.var_.actorSpriteComps10022 = nil
			end

			local var_261_8 = 0
			local var_261_9 = 0.725

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_8 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_10 = arg_258_1:GetWordFromCfg(413051061)
				local var_261_11 = arg_258_1:FormatText(var_261_10.content)

				arg_258_1.text_.text = var_261_11

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_13 = 29 <= 0 and var_261_9 or var_261_9 * (utf8.len(var_261_11) / 29)

				if (29 <= 0 and var_261_9 or var_261_9 * (utf8.len(var_261_11) / 29)) > 0 and var_261_9 < var_261_13 then
					arg_258_1.talkMaxDuration = var_261_13

					if var_261_13 + var_261_8 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_13 + var_261_8
					end
				end

				arg_258_1.text_.text = var_261_11
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051061", "story_v_out_413051.awb") ~= 0 then
					local var_261_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051061", "story_v_out_413051.awb") / 1000

					if var_261_14 + var_261_8 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_14 + var_261_8
					end

					if var_261_10.prefab_name ~= "" and arg_258_1.actors_[var_261_10.prefab_name] ~= nil then
						local var_261_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_10.prefab_name].transform, "story_v_out_413051", "413051061", "story_v_out_413051.awb")

						arg_258_1:RecordAudio("413051061", var_261_15)
						arg_258_1:RecordAudio("413051061", var_261_15)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_413051", "413051061", "story_v_out_413051.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_413051", "413051061", "story_v_out_413051.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_16 = math.max(var_261_9, arg_258_1.talkMaxDuration)

			if var_261_8 <= arg_258_1.time_ and arg_258_1.time_ < var_261_8 + var_261_16 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_8) / var_261_16

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_8 + var_261_16 and arg_258_1.time_ < var_261_8 + var_261_16 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
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

		arg_258_1:InitPlayNodeList()
	end,
	Play413051062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 413051062
		arg_262_1.duration_ = 5.2

		local var_262_0 = {
			zh = 2.033,
			ja = 5.2
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play413051063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos10093 = arg_262_1.actors_["10093"].transform.localPosition
				arg_262_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("10093", 4)

				for iter_265_0 = 0, arg_262_1.actors_["10093"].transform.childCount - 1 do
					local var_265_0 = arg_262_1.actors_["10093"].transform:GetChild(iter_265_0)

					if var_265_0.name == "split_3" or not string.find(var_265_0.name, "split") then
						var_265_0.gameObject:SetActive(true)
					else
						var_265_0.gameObject:SetActive(false)
					end
				end
			end

			local var_265_1 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_1 then
				arg_262_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_262_1.time_ - 0) / var_265_1)
			end

			if arg_262_1.time_ >= 0 + var_265_1 and arg_262_1.time_ < 0 + var_265_1 + arg_265_0 then
				arg_262_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_265_2 = 0
			local var_265_3 = 0.25

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_2 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_4 = arg_262_1:GetWordFromCfg(413051062)
				local var_265_5 = arg_262_1:FormatText(var_265_4.content)

				arg_262_1.text_.text = var_265_5

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_7 = 10 <= 0 and var_265_3 or var_265_3 * (utf8.len(var_265_5) / 10)

				if (10 <= 0 and var_265_3 or var_265_3 * (utf8.len(var_265_5) / 10)) > 0 and var_265_3 < var_265_7 then
					arg_262_1.talkMaxDuration = var_265_7

					if var_265_7 + var_265_2 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_7 + var_265_2
					end
				end

				arg_262_1.text_.text = var_265_5
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051062", "story_v_out_413051.awb") ~= 0 then
					local var_265_8 = manager.audio:GetVoiceLength("story_v_out_413051", "413051062", "story_v_out_413051.awb") / 1000

					if var_265_8 + var_265_2 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_8 + var_265_2
					end

					if var_265_4.prefab_name ~= "" and arg_262_1.actors_[var_265_4.prefab_name] ~= nil then
						local var_265_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_4.prefab_name].transform, "story_v_out_413051", "413051062", "story_v_out_413051.awb")

						arg_262_1:RecordAudio("413051062", var_265_9)
						arg_262_1:RecordAudio("413051062", var_265_9)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_413051", "413051062", "story_v_out_413051.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_413051", "413051062", "story_v_out_413051.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_10 = math.max(var_265_3, arg_262_1.talkMaxDuration)

			if var_265_2 <= arg_262_1.time_ and arg_262_1.time_ < var_265_2 + var_265_10 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_2) / var_265_10

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_2 + var_265_10 and arg_262_1.time_ < var_265_2 + var_265_10 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
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

		arg_262_1:InitPlayNodeList()
	end,
	Play413051063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 413051063
		arg_266_1.duration_ = 6.53

		local var_266_0 = {
			zh = 5.066,
			ja = 6.533
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
				arg_266_0:Play413051064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos10022 = arg_266_1.actors_["10022"].transform.localPosition
				arg_266_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_266_1:CheckSpriteTmpPos("10022", 2)

				for iter_269_0 = 0, arg_266_1.actors_["10022"].transform.childCount - 1 do
					local var_269_0 = arg_266_1.actors_["10022"].transform:GetChild(iter_269_0)

					if var_269_0.name == "split_3" or not string.find(var_269_0.name, "split") then
						var_269_0.gameObject:SetActive(true)
					else
						var_269_0.gameObject:SetActive(false)
					end
				end
			end

			local var_269_1 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_1 then
				arg_266_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_266_1.time_ - 0) / var_269_1)
			end

			if arg_266_1.time_ >= 0 + var_269_1 and arg_266_1.time_ < 0 + var_269_1 + arg_269_0 then
				arg_266_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_269_2 = arg_266_1.actors_["10093"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_2) and arg_266_1.var_.actorSpriteComps10093 == nil then
				arg_266_1.var_.actorSpriteComps10093 = var_269_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_3 = 2

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_3 and not isNil(var_269_2) then
				if arg_266_1.var_.actorSpriteComps10093 then
					for iter_269_1, iter_269_2 in pairs(arg_266_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_269_2 then
							if arg_266_1.isInRecall_ then
								iter_269_2.color = Color.New(Mathf.Lerp(iter_269_2.color.r, arg_266_1.hightColor2.r, (arg_266_1.time_ - 0) / var_269_3), Mathf.Lerp(iter_269_2.color.g, arg_266_1.hightColor2.g, (arg_266_1.time_ - 0) / var_269_3), (Mathf.Lerp(iter_269_2.color.b, arg_266_1.hightColor2.b, (arg_266_1.time_ - 0) / var_269_3)))
							else
								local var_269_4 = Mathf.Lerp(iter_269_2.color.r, 0.5, (arg_266_1.time_ - 0) / var_269_3)

								iter_269_2.color = Color.New(var_269_4, var_269_4, var_269_4)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= 0 + var_269_3 and arg_266_1.time_ < 0 + var_269_3 + arg_269_0 and not isNil(var_269_2) and arg_266_1.var_.actorSpriteComps10093 then
				for iter_269_3, iter_269_4 in pairs(arg_266_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_269_4 then
						iter_269_4.color = arg_266_1.isInRecall_ and (arg_266_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_266_1.var_.actorSpriteComps10093 = nil
			end

			local var_269_5 = arg_266_1.actors_["10022"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_5) and arg_266_1.var_.actorSpriteComps10022 == nil then
				arg_266_1.var_.actorSpriteComps10022 = var_269_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_269_6 = 2

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_6 and not isNil(var_269_5) then
				if arg_266_1.var_.actorSpriteComps10022 then
					for iter_269_5, iter_269_6 in pairs(arg_266_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_269_6 then
							if arg_266_1.isInRecall_ then
								iter_269_6.color = Color.New(Mathf.Lerp(iter_269_6.color.r, arg_266_1.hightColor1.r, (arg_266_1.time_ - 0) / var_269_6), Mathf.Lerp(iter_269_6.color.g, arg_266_1.hightColor1.g, (arg_266_1.time_ - 0) / var_269_6), (Mathf.Lerp(iter_269_6.color.b, arg_266_1.hightColor1.b, (arg_266_1.time_ - 0) / var_269_6)))
							else
								local var_269_7 = Mathf.Lerp(iter_269_6.color.r, 1, (arg_266_1.time_ - 0) / var_269_6)

								iter_269_6.color = Color.New(var_269_7, var_269_7, var_269_7)
							end
						end
					end
				end
			end

			if arg_266_1.time_ >= 0 + var_269_6 and arg_266_1.time_ < 0 + var_269_6 + arg_269_0 and not isNil(var_269_5) and arg_266_1.var_.actorSpriteComps10022 then
				for iter_269_7, iter_269_8 in pairs(arg_266_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_269_8 then
						iter_269_8.color = arg_266_1.isInRecall_ and (arg_266_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_266_1.var_.actorSpriteComps10022 = nil
			end

			local var_269_8 = 0
			local var_269_9 = 0.65

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_8 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_10 = arg_266_1:GetWordFromCfg(413051063)
				local var_269_11 = arg_266_1:FormatText(var_269_10.content)

				arg_266_1.text_.text = var_269_11

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_13 = 26 <= 0 and var_269_9 or var_269_9 * (utf8.len(var_269_11) / 26)

				if (26 <= 0 and var_269_9 or var_269_9 * (utf8.len(var_269_11) / 26)) > 0 and var_269_9 < var_269_13 then
					arg_266_1.talkMaxDuration = var_269_13

					if var_269_13 + var_269_8 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_13 + var_269_8
					end
				end

				arg_266_1.text_.text = var_269_11
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051063", "story_v_out_413051.awb") ~= 0 then
					local var_269_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051063", "story_v_out_413051.awb") / 1000

					if var_269_14 + var_269_8 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_14 + var_269_8
					end

					if var_269_10.prefab_name ~= "" and arg_266_1.actors_[var_269_10.prefab_name] ~= nil then
						local var_269_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_10.prefab_name].transform, "story_v_out_413051", "413051063", "story_v_out_413051.awb")

						arg_266_1:RecordAudio("413051063", var_269_15)
						arg_266_1:RecordAudio("413051063", var_269_15)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_413051", "413051063", "story_v_out_413051.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_413051", "413051063", "story_v_out_413051.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_16 = math.max(var_269_9, arg_266_1.talkMaxDuration)

			if var_269_8 <= arg_266_1.time_ and arg_266_1.time_ < var_269_8 + var_269_16 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_8) / var_269_16

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_8 + var_269_16 and arg_266_1.time_ < var_269_8 + var_269_16 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
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

		arg_266_1:InitPlayNodeList()
	end,
	Play413051064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 413051064
		arg_270_1.duration_ = 6.43

		local var_270_0 = {
			zh = 6.433,
			ja = 5.7
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play413051065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos10093 = arg_270_1.actors_["10093"].transform.localPosition
				arg_270_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("10093", 4)

				for iter_273_0 = 0, arg_270_1.actors_["10093"].transform.childCount - 1 do
					local var_273_0 = arg_270_1.actors_["10093"].transform:GetChild(iter_273_0)

					if var_273_0.name == "split_4" or not string.find(var_273_0.name, "split") then
						var_273_0.gameObject:SetActive(true)
					else
						var_273_0.gameObject:SetActive(false)
					end
				end
			end

			local var_273_1 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_1 then
				arg_270_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_270_1.time_ - 0) / var_273_1)
			end

			if arg_270_1.time_ >= 0 + var_273_1 and arg_270_1.time_ < 0 + var_273_1 + arg_273_0 then
				arg_270_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_273_2 = arg_270_1.actors_["10093"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.actorSpriteComps10093 == nil then
				arg_270_1.var_.actorSpriteComps10093 = var_273_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_3 = 2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_3 and not isNil(var_273_2) then
				if arg_270_1.var_.actorSpriteComps10093 then
					for iter_273_1, iter_273_2 in pairs(arg_270_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_273_2 then
							if arg_270_1.isInRecall_ then
								iter_273_2.color = Color.New(Mathf.Lerp(iter_273_2.color.r, arg_270_1.hightColor1.r, (arg_270_1.time_ - 0) / var_273_3), Mathf.Lerp(iter_273_2.color.g, arg_270_1.hightColor1.g, (arg_270_1.time_ - 0) / var_273_3), (Mathf.Lerp(iter_273_2.color.b, arg_270_1.hightColor1.b, (arg_270_1.time_ - 0) / var_273_3)))
							else
								local var_273_4 = Mathf.Lerp(iter_273_2.color.r, 1, (arg_270_1.time_ - 0) / var_273_3)

								iter_273_2.color = Color.New(var_273_4, var_273_4, var_273_4)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= 0 + var_273_3 and arg_270_1.time_ < 0 + var_273_3 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.actorSpriteComps10093 then
				for iter_273_3, iter_273_4 in pairs(arg_270_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_273_4 then
						iter_273_4.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_270_1.var_.actorSpriteComps10093 = nil
			end

			local var_273_5 = arg_270_1.actors_["10022"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_5) and arg_270_1.var_.actorSpriteComps10022 == nil then
				arg_270_1.var_.actorSpriteComps10022 = var_273_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_6 = 2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_6 and not isNil(var_273_5) then
				if arg_270_1.var_.actorSpriteComps10022 then
					for iter_273_5, iter_273_6 in pairs(arg_270_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_273_6 then
							if arg_270_1.isInRecall_ then
								iter_273_6.color = Color.New(Mathf.Lerp(iter_273_6.color.r, arg_270_1.hightColor2.r, (arg_270_1.time_ - 0) / var_273_6), Mathf.Lerp(iter_273_6.color.g, arg_270_1.hightColor2.g, (arg_270_1.time_ - 0) / var_273_6), (Mathf.Lerp(iter_273_6.color.b, arg_270_1.hightColor2.b, (arg_270_1.time_ - 0) / var_273_6)))
							else
								local var_273_7 = Mathf.Lerp(iter_273_6.color.r, 0.5, (arg_270_1.time_ - 0) / var_273_6)

								iter_273_6.color = Color.New(var_273_7, var_273_7, var_273_7)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= 0 + var_273_6 and arg_270_1.time_ < 0 + var_273_6 + arg_273_0 and not isNil(var_273_5) and arg_270_1.var_.actorSpriteComps10022 then
				for iter_273_7, iter_273_8 in pairs(arg_270_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_273_8 then
						iter_273_8.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_270_1.var_.actorSpriteComps10022 = nil
			end

			local var_273_8 = 0
			local var_273_9 = 0.525

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_8 + arg_273_0 then
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

				local var_273_10 = arg_270_1:GetWordFromCfg(413051064)
				local var_273_11 = arg_270_1:FormatText(var_273_10.content)

				arg_270_1.text_.text = var_273_11

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_13 = 21 <= 0 and var_273_9 or var_273_9 * (utf8.len(var_273_11) / 21)

				if (21 <= 0 and var_273_9 or var_273_9 * (utf8.len(var_273_11) / 21)) > 0 and var_273_9 < var_273_13 then
					arg_270_1.talkMaxDuration = var_273_13

					if var_273_13 + var_273_8 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_13 + var_273_8
					end
				end

				arg_270_1.text_.text = var_273_11
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051064", "story_v_out_413051.awb") ~= 0 then
					local var_273_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051064", "story_v_out_413051.awb") / 1000

					if var_273_14 + var_273_8 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_14 + var_273_8
					end

					if var_273_10.prefab_name ~= "" and arg_270_1.actors_[var_273_10.prefab_name] ~= nil then
						local var_273_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_10.prefab_name].transform, "story_v_out_413051", "413051064", "story_v_out_413051.awb")

						arg_270_1:RecordAudio("413051064", var_273_15)
						arg_270_1:RecordAudio("413051064", var_273_15)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_413051", "413051064", "story_v_out_413051.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_413051", "413051064", "story_v_out_413051.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_16 = math.max(var_273_9, arg_270_1.talkMaxDuration)

			if var_273_8 <= arg_270_1.time_ and arg_270_1.time_ < var_273_8 + var_273_16 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_8) / var_273_16

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_8 + var_273_16 and arg_270_1.time_ < var_273_8 + var_273_16 + arg_273_0 then
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
	Play413051065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 413051065
		arg_274_1.duration_ = 8.6

		local var_274_0 = {
			zh = 4.733,
			ja = 8.6
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
				arg_274_0:Play413051066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos10022 = arg_274_1.actors_["10022"].transform.localPosition
				arg_274_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("10022", 2)

				for iter_277_0 = 0, arg_274_1.actors_["10022"].transform.childCount - 1 do
					local var_277_0 = arg_274_1.actors_["10022"].transform:GetChild(iter_277_0)

					if var_277_0.name == "split_8" or not string.find(var_277_0.name, "split") then
						var_277_0.gameObject:SetActive(true)
					else
						var_277_0.gameObject:SetActive(false)
					end
				end
			end

			local var_277_1 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_1 then
				arg_274_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_274_1.time_ - 0) / var_277_1)
			end

			if arg_274_1.time_ >= 0 + var_277_1 and arg_274_1.time_ < 0 + var_277_1 + arg_277_0 then
				arg_274_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_277_2 = arg_274_1.actors_["10093"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_2) and arg_274_1.var_.actorSpriteComps10093 == nil then
				arg_274_1.var_.actorSpriteComps10093 = var_277_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_3 = 2

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_3 and not isNil(var_277_2) then
				if arg_274_1.var_.actorSpriteComps10093 then
					for iter_277_1, iter_277_2 in pairs(arg_274_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_277_2 then
							if arg_274_1.isInRecall_ then
								iter_277_2.color = Color.New(Mathf.Lerp(iter_277_2.color.r, arg_274_1.hightColor2.r, (arg_274_1.time_ - 0) / var_277_3), Mathf.Lerp(iter_277_2.color.g, arg_274_1.hightColor2.g, (arg_274_1.time_ - 0) / var_277_3), (Mathf.Lerp(iter_277_2.color.b, arg_274_1.hightColor2.b, (arg_274_1.time_ - 0) / var_277_3)))
							else
								local var_277_4 = Mathf.Lerp(iter_277_2.color.r, 0.5, (arg_274_1.time_ - 0) / var_277_3)

								iter_277_2.color = Color.New(var_277_4, var_277_4, var_277_4)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= 0 + var_277_3 and arg_274_1.time_ < 0 + var_277_3 + arg_277_0 and not isNil(var_277_2) and arg_274_1.var_.actorSpriteComps10093 then
				for iter_277_3, iter_277_4 in pairs(arg_274_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_277_4 then
						iter_277_4.color = arg_274_1.isInRecall_ and (arg_274_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_274_1.var_.actorSpriteComps10093 = nil
			end

			local var_277_5 = arg_274_1.actors_["10022"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_5) and arg_274_1.var_.actorSpriteComps10022 == nil then
				arg_274_1.var_.actorSpriteComps10022 = var_277_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_6 = 2

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_6 and not isNil(var_277_5) then
				if arg_274_1.var_.actorSpriteComps10022 then
					for iter_277_5, iter_277_6 in pairs(arg_274_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_277_6 then
							if arg_274_1.isInRecall_ then
								iter_277_6.color = Color.New(Mathf.Lerp(iter_277_6.color.r, arg_274_1.hightColor1.r, (arg_274_1.time_ - 0) / var_277_6), Mathf.Lerp(iter_277_6.color.g, arg_274_1.hightColor1.g, (arg_274_1.time_ - 0) / var_277_6), (Mathf.Lerp(iter_277_6.color.b, arg_274_1.hightColor1.b, (arg_274_1.time_ - 0) / var_277_6)))
							else
								local var_277_7 = Mathf.Lerp(iter_277_6.color.r, 1, (arg_274_1.time_ - 0) / var_277_6)

								iter_277_6.color = Color.New(var_277_7, var_277_7, var_277_7)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= 0 + var_277_6 and arg_274_1.time_ < 0 + var_277_6 + arg_277_0 and not isNil(var_277_5) and arg_274_1.var_.actorSpriteComps10022 then
				for iter_277_7, iter_277_8 in pairs(arg_274_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_277_8 then
						iter_277_8.color = arg_274_1.isInRecall_ and (arg_274_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_274_1.var_.actorSpriteComps10022 = nil
			end

			local var_277_8 = 0
			local var_277_9 = 0.475

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_8 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_10 = arg_274_1:GetWordFromCfg(413051065)
				local var_277_11 = arg_274_1:FormatText(var_277_10.content)

				arg_274_1.text_.text = var_277_11

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_13 = 19 <= 0 and var_277_9 or var_277_9 * (utf8.len(var_277_11) / 19)

				if (19 <= 0 and var_277_9 or var_277_9 * (utf8.len(var_277_11) / 19)) > 0 and var_277_9 < var_277_13 then
					arg_274_1.talkMaxDuration = var_277_13

					if var_277_13 + var_277_8 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_13 + var_277_8
					end
				end

				arg_274_1.text_.text = var_277_11
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051065", "story_v_out_413051.awb") ~= 0 then
					local var_277_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051065", "story_v_out_413051.awb") / 1000

					if var_277_14 + var_277_8 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_14 + var_277_8
					end

					if var_277_10.prefab_name ~= "" and arg_274_1.actors_[var_277_10.prefab_name] ~= nil then
						local var_277_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_10.prefab_name].transform, "story_v_out_413051", "413051065", "story_v_out_413051.awb")

						arg_274_1:RecordAudio("413051065", var_277_15)
						arg_274_1:RecordAudio("413051065", var_277_15)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_413051", "413051065", "story_v_out_413051.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_413051", "413051065", "story_v_out_413051.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_16 = math.max(var_277_9, arg_274_1.talkMaxDuration)

			if var_277_8 <= arg_274_1.time_ and arg_274_1.time_ < var_277_8 + var_277_16 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_8) / var_277_16

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_8 + var_277_16 and arg_274_1.time_ < var_277_8 + var_277_16 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
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

		arg_274_1:InitPlayNodeList()
	end,
	Play413051066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 413051066
		arg_278_1.duration_ = 4.23

		local var_278_0 = {
			zh = 4,
			ja = 4.233
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
				arg_278_0:Play413051067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos10093 = arg_278_1.actors_["10093"].transform.localPosition
				arg_278_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_278_1:CheckSpriteTmpPos("10093", 4)

				for iter_281_0 = 0, arg_278_1.actors_["10093"].transform.childCount - 1 do
					local var_281_0 = arg_278_1.actors_["10093"].transform:GetChild(iter_281_0)

					if var_281_0.name == "split_6" or not string.find(var_281_0.name, "split") then
						var_281_0.gameObject:SetActive(true)
					else
						var_281_0.gameObject:SetActive(false)
					end
				end
			end

			local var_281_1 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_1 then
				arg_278_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_278_1.time_ - 0) / var_281_1)
			end

			if arg_278_1.time_ >= 0 + var_281_1 and arg_278_1.time_ < 0 + var_281_1 + arg_281_0 then
				arg_278_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_281_2 = arg_278_1.actors_["10093"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_2) and arg_278_1.var_.actorSpriteComps10093 == nil then
				arg_278_1.var_.actorSpriteComps10093 = var_281_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_3 = 2

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_3 and not isNil(var_281_2) then
				if arg_278_1.var_.actorSpriteComps10093 then
					for iter_281_1, iter_281_2 in pairs(arg_278_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_281_2 then
							if arg_278_1.isInRecall_ then
								iter_281_2.color = Color.New(Mathf.Lerp(iter_281_2.color.r, arg_278_1.hightColor1.r, (arg_278_1.time_ - 0) / var_281_3), Mathf.Lerp(iter_281_2.color.g, arg_278_1.hightColor1.g, (arg_278_1.time_ - 0) / var_281_3), (Mathf.Lerp(iter_281_2.color.b, arg_278_1.hightColor1.b, (arg_278_1.time_ - 0) / var_281_3)))
							else
								local var_281_4 = Mathf.Lerp(iter_281_2.color.r, 1, (arg_278_1.time_ - 0) / var_281_3)

								iter_281_2.color = Color.New(var_281_4, var_281_4, var_281_4)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= 0 + var_281_3 and arg_278_1.time_ < 0 + var_281_3 + arg_281_0 and not isNil(var_281_2) and arg_278_1.var_.actorSpriteComps10093 then
				for iter_281_3, iter_281_4 in pairs(arg_278_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_281_4 then
						iter_281_4.color = arg_278_1.isInRecall_ and (arg_278_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_278_1.var_.actorSpriteComps10093 = nil
			end

			local var_281_5 = arg_278_1.actors_["10022"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_5) and arg_278_1.var_.actorSpriteComps10022 == nil then
				arg_278_1.var_.actorSpriteComps10022 = var_281_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_6 = 2

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_6 and not isNil(var_281_5) then
				if arg_278_1.var_.actorSpriteComps10022 then
					for iter_281_5, iter_281_6 in pairs(arg_278_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_281_6 then
							if arg_278_1.isInRecall_ then
								iter_281_6.color = Color.New(Mathf.Lerp(iter_281_6.color.r, arg_278_1.hightColor2.r, (arg_278_1.time_ - 0) / var_281_6), Mathf.Lerp(iter_281_6.color.g, arg_278_1.hightColor2.g, (arg_278_1.time_ - 0) / var_281_6), (Mathf.Lerp(iter_281_6.color.b, arg_278_1.hightColor2.b, (arg_278_1.time_ - 0) / var_281_6)))
							else
								local var_281_7 = Mathf.Lerp(iter_281_6.color.r, 0.5, (arg_278_1.time_ - 0) / var_281_6)

								iter_281_6.color = Color.New(var_281_7, var_281_7, var_281_7)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= 0 + var_281_6 and arg_278_1.time_ < 0 + var_281_6 + arg_281_0 and not isNil(var_281_5) and arg_278_1.var_.actorSpriteComps10022 then
				for iter_281_7, iter_281_8 in pairs(arg_278_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_281_8 then
						iter_281_8.color = arg_278_1.isInRecall_ and (arg_278_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_278_1.var_.actorSpriteComps10022 = nil
			end

			local var_281_8 = 0
			local var_281_9 = 0.425

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_8 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_10 = arg_278_1:GetWordFromCfg(413051066)
				local var_281_11 = arg_278_1:FormatText(var_281_10.content)

				arg_278_1.text_.text = var_281_11

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_13 = 17 <= 0 and var_281_9 or var_281_9 * (utf8.len(var_281_11) / 17)

				if (17 <= 0 and var_281_9 or var_281_9 * (utf8.len(var_281_11) / 17)) > 0 and var_281_9 < var_281_13 then
					arg_278_1.talkMaxDuration = var_281_13

					if var_281_13 + var_281_8 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_13 + var_281_8
					end
				end

				arg_278_1.text_.text = var_281_11
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051066", "story_v_out_413051.awb") ~= 0 then
					local var_281_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051066", "story_v_out_413051.awb") / 1000

					if var_281_14 + var_281_8 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_14 + var_281_8
					end

					if var_281_10.prefab_name ~= "" and arg_278_1.actors_[var_281_10.prefab_name] ~= nil then
						local var_281_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_10.prefab_name].transform, "story_v_out_413051", "413051066", "story_v_out_413051.awb")

						arg_278_1:RecordAudio("413051066", var_281_15)
						arg_278_1:RecordAudio("413051066", var_281_15)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_413051", "413051066", "story_v_out_413051.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_413051", "413051066", "story_v_out_413051.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_16 = math.max(var_281_9, arg_278_1.talkMaxDuration)

			if var_281_8 <= arg_278_1.time_ and arg_278_1.time_ < var_281_8 + var_281_16 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_8) / var_281_16

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_8 + var_281_16 and arg_278_1.time_ < var_281_8 + var_281_16 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
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

		arg_278_1:InitPlayNodeList()
	end,
	Play413051067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 413051067
		arg_282_1.duration_ = 14.9

		local var_282_0 = {
			zh = 6.4,
			ja = 14.9
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
				arg_282_0:Play413051068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos10022 = arg_282_1.actors_["10022"].transform.localPosition
				arg_282_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("10022", 2)

				for iter_285_0 = 0, arg_282_1.actors_["10022"].transform.childCount - 1 do
					local var_285_0 = arg_282_1.actors_["10022"].transform:GetChild(iter_285_0)

					if var_285_0.name == "split_6" or not string.find(var_285_0.name, "split") then
						var_285_0.gameObject:SetActive(true)
					else
						var_285_0.gameObject:SetActive(false)
					end
				end
			end

			local var_285_1 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_1 then
				arg_282_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_282_1.time_ - 0) / var_285_1)
			end

			if arg_282_1.time_ >= 0 + var_285_1 and arg_282_1.time_ < 0 + var_285_1 + arg_285_0 then
				arg_282_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_285_2 = arg_282_1.actors_["10093"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_2) and arg_282_1.var_.actorSpriteComps10093 == nil then
				arg_282_1.var_.actorSpriteComps10093 = var_285_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_3 = 2

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_3 and not isNil(var_285_2) then
				if arg_282_1.var_.actorSpriteComps10093 then
					for iter_285_1, iter_285_2 in pairs(arg_282_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_285_2 then
							if arg_282_1.isInRecall_ then
								iter_285_2.color = Color.New(Mathf.Lerp(iter_285_2.color.r, arg_282_1.hightColor2.r, (arg_282_1.time_ - 0) / var_285_3), Mathf.Lerp(iter_285_2.color.g, arg_282_1.hightColor2.g, (arg_282_1.time_ - 0) / var_285_3), (Mathf.Lerp(iter_285_2.color.b, arg_282_1.hightColor2.b, (arg_282_1.time_ - 0) / var_285_3)))
							else
								local var_285_4 = Mathf.Lerp(iter_285_2.color.r, 0.5, (arg_282_1.time_ - 0) / var_285_3)

								iter_285_2.color = Color.New(var_285_4, var_285_4, var_285_4)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= 0 + var_285_3 and arg_282_1.time_ < 0 + var_285_3 + arg_285_0 and not isNil(var_285_2) and arg_282_1.var_.actorSpriteComps10093 then
				for iter_285_3, iter_285_4 in pairs(arg_282_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_285_4 then
						iter_285_4.color = arg_282_1.isInRecall_ and (arg_282_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_282_1.var_.actorSpriteComps10093 = nil
			end

			local var_285_5 = arg_282_1.actors_["10022"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_5) and arg_282_1.var_.actorSpriteComps10022 == nil then
				arg_282_1.var_.actorSpriteComps10022 = var_285_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_6 = 2

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_6 and not isNil(var_285_5) then
				if arg_282_1.var_.actorSpriteComps10022 then
					for iter_285_5, iter_285_6 in pairs(arg_282_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_285_6 then
							if arg_282_1.isInRecall_ then
								iter_285_6.color = Color.New(Mathf.Lerp(iter_285_6.color.r, arg_282_1.hightColor1.r, (arg_282_1.time_ - 0) / var_285_6), Mathf.Lerp(iter_285_6.color.g, arg_282_1.hightColor1.g, (arg_282_1.time_ - 0) / var_285_6), (Mathf.Lerp(iter_285_6.color.b, arg_282_1.hightColor1.b, (arg_282_1.time_ - 0) / var_285_6)))
							else
								local var_285_7 = Mathf.Lerp(iter_285_6.color.r, 1, (arg_282_1.time_ - 0) / var_285_6)

								iter_285_6.color = Color.New(var_285_7, var_285_7, var_285_7)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= 0 + var_285_6 and arg_282_1.time_ < 0 + var_285_6 + arg_285_0 and not isNil(var_285_5) and arg_282_1.var_.actorSpriteComps10022 then
				for iter_285_7, iter_285_8 in pairs(arg_282_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_285_8 then
						iter_285_8.color = arg_282_1.isInRecall_ and (arg_282_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_282_1.var_.actorSpriteComps10022 = nil
			end

			local var_285_8 = 0
			local var_285_9 = 0.675

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_8 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_10 = arg_282_1:GetWordFromCfg(413051067)
				local var_285_11 = arg_282_1:FormatText(var_285_10.content)

				arg_282_1.text_.text = var_285_11

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_13 = 27 <= 0 and var_285_9 or var_285_9 * (utf8.len(var_285_11) / 27)

				if (27 <= 0 and var_285_9 or var_285_9 * (utf8.len(var_285_11) / 27)) > 0 and var_285_9 < var_285_13 then
					arg_282_1.talkMaxDuration = var_285_13

					if var_285_13 + var_285_8 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_13 + var_285_8
					end
				end

				arg_282_1.text_.text = var_285_11
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051067", "story_v_out_413051.awb") ~= 0 then
					local var_285_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051067", "story_v_out_413051.awb") / 1000

					if var_285_14 + var_285_8 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_14 + var_285_8
					end

					if var_285_10.prefab_name ~= "" and arg_282_1.actors_[var_285_10.prefab_name] ~= nil then
						local var_285_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_10.prefab_name].transform, "story_v_out_413051", "413051067", "story_v_out_413051.awb")

						arg_282_1:RecordAudio("413051067", var_285_15)
						arg_282_1:RecordAudio("413051067", var_285_15)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_413051", "413051067", "story_v_out_413051.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_413051", "413051067", "story_v_out_413051.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_16 = math.max(var_285_9, arg_282_1.talkMaxDuration)

			if var_285_8 <= arg_282_1.time_ and arg_282_1.time_ < var_285_8 + var_285_16 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_8) / var_285_16

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_8 + var_285_16 and arg_282_1.time_ < var_285_8 + var_285_16 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
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

		arg_282_1:InitPlayNodeList()
	end,
	Play413051068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 413051068
		arg_286_1.duration_ = 5.07

		local var_286_0 = {
			zh = 4.03333333333333,
			ja = 5.06633333333333
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
				arg_286_0:Play413051069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos10093 = arg_286_1.actors_["10093"].transform.localPosition
				arg_286_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("10093", 7)

				for iter_289_0 = 0, arg_286_1.actors_["10093"].transform.childCount - 1 do
					local var_289_0 = arg_286_1.actors_["10093"].transform:GetChild(iter_289_0)

					if var_289_0.name == "split_1" or not string.find(var_289_0.name, "split") then
						var_289_0.gameObject:SetActive(true)
					else
						var_289_0.gameObject:SetActive(false)
					end
				end
			end

			local var_289_1 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_1 then
				arg_286_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_286_1.time_ - 0) / var_289_1)
			end

			if arg_286_1.time_ >= 0 + var_289_1 and arg_286_1.time_ < 0 + var_289_1 + arg_289_0 then
				arg_286_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_289_2 = arg_286_1.actors_["10022"].transform

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos10022 = var_289_2.localPosition
				var_289_2.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("10022", 7)

				for iter_289_1 = 0, var_289_2.childCount - 1 do
					local var_289_3 = var_289_2:GetChild(iter_289_1)

					if var_289_3.name == "" or not string.find(var_289_3.name, "split") then
						var_289_3.gameObject:SetActive(true)
					else
						var_289_3.gameObject:SetActive(false)
					end
				end
			end

			local var_289_4 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_4 then
				var_289_2.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_286_1.time_ - 0) / var_289_4)
			end

			if arg_286_1.time_ >= 0 + var_289_4 and arg_286_1.time_ < 0 + var_289_4 + arg_289_0 then
				var_289_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_289_5 = arg_286_1.actors_["10092"].transform

			if 1 < arg_286_1.time_ and arg_286_1.time_ <= 1 + arg_289_0 then
				arg_286_1.var_.moveOldPos10092 = var_289_5.localPosition
				var_289_5.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("10092", 3)

				for iter_289_2 = 0, var_289_5.childCount - 1 do
					local var_289_6 = var_289_5:GetChild(iter_289_2)

					if var_289_6.name == "split_1_1" or not string.find(var_289_6.name, "split") then
						var_289_6.gameObject:SetActive(true)
					else
						var_289_6.gameObject:SetActive(false)
					end
				end
			end

			local var_289_7 = 0.001

			if 1 <= arg_286_1.time_ and arg_286_1.time_ < 1 + var_289_7 then
				var_289_5.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_286_1.time_ - 1) / var_289_7)
			end

			if arg_286_1.time_ >= 1 + var_289_7 and arg_286_1.time_ < 1 + var_289_7 + arg_289_0 then
				var_289_5.localPosition = Vector3.New(0, -300, -295)
			end

			local var_289_8 = arg_286_1.actors_["10093"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_8) and arg_286_1.var_.actorSpriteComps10093 == nil then
				arg_286_1.var_.actorSpriteComps10093 = var_289_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_9 = 2

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_9 and not isNil(var_289_8) then
				if arg_286_1.var_.actorSpriteComps10093 then
					for iter_289_3, iter_289_4 in pairs(arg_286_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_289_4 then
							if arg_286_1.isInRecall_ then
								iter_289_4.color = Color.New(Mathf.Lerp(iter_289_4.color.r, arg_286_1.hightColor2.r, (arg_286_1.time_ - 0) / var_289_9), Mathf.Lerp(iter_289_4.color.g, arg_286_1.hightColor2.g, (arg_286_1.time_ - 0) / var_289_9), (Mathf.Lerp(iter_289_4.color.b, arg_286_1.hightColor2.b, (arg_286_1.time_ - 0) / var_289_9)))
							else
								local var_289_10 = Mathf.Lerp(iter_289_4.color.r, 0.5, (arg_286_1.time_ - 0) / var_289_9)

								iter_289_4.color = Color.New(var_289_10, var_289_10, var_289_10)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= 0 + var_289_9 and arg_286_1.time_ < 0 + var_289_9 + arg_289_0 and not isNil(var_289_8) and arg_286_1.var_.actorSpriteComps10093 then
				for iter_289_5, iter_289_6 in pairs(arg_286_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_289_6 then
						iter_289_6.color = arg_286_1.isInRecall_ and (arg_286_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_286_1.var_.actorSpriteComps10093 = nil
			end

			local var_289_11 = arg_286_1.actors_["10022"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_11) and arg_286_1.var_.actorSpriteComps10022 == nil then
				arg_286_1.var_.actorSpriteComps10022 = var_289_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_12 = 2

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_12 and not isNil(var_289_11) then
				if arg_286_1.var_.actorSpriteComps10022 then
					for iter_289_7, iter_289_8 in pairs(arg_286_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_289_8 then
							if arg_286_1.isInRecall_ then
								iter_289_8.color = Color.New(Mathf.Lerp(iter_289_8.color.r, arg_286_1.hightColor2.r, (arg_286_1.time_ - 0) / var_289_12), Mathf.Lerp(iter_289_8.color.g, arg_286_1.hightColor2.g, (arg_286_1.time_ - 0) / var_289_12), (Mathf.Lerp(iter_289_8.color.b, arg_286_1.hightColor2.b, (arg_286_1.time_ - 0) / var_289_12)))
							else
								local var_289_13 = Mathf.Lerp(iter_289_8.color.r, 0.5, (arg_286_1.time_ - 0) / var_289_12)

								iter_289_8.color = Color.New(var_289_13, var_289_13, var_289_13)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= 0 + var_289_12 and arg_286_1.time_ < 0 + var_289_12 + arg_289_0 and not isNil(var_289_11) and arg_286_1.var_.actorSpriteComps10022 then
				for iter_289_9, iter_289_10 in pairs(arg_286_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_289_10 then
						iter_289_10.color = arg_286_1.isInRecall_ and (arg_286_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_286_1.var_.actorSpriteComps10022 = nil
			end

			local var_289_14 = arg_286_1.actors_["10092"]

			if 0.833333333333333 < arg_286_1.time_ and arg_286_1.time_ <= 0.833333333333333 + arg_289_0 and not isNil(var_289_14) and arg_286_1.var_.actorSpriteComps10092 == nil then
				arg_286_1.var_.actorSpriteComps10092 = var_289_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_15 = 2

			if 0.833333333333333 <= arg_286_1.time_ and arg_286_1.time_ < 0.833333333333333 + var_289_15 and not isNil(var_289_14) then
				if arg_286_1.var_.actorSpriteComps10092 then
					for iter_289_11, iter_289_12 in pairs(arg_286_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_289_12 then
							if arg_286_1.isInRecall_ then
								iter_289_12.color = Color.New(Mathf.Lerp(iter_289_12.color.r, arg_286_1.hightColor1.r, (arg_286_1.time_ - 0.833333333333333) / var_289_15), Mathf.Lerp(iter_289_12.color.g, arg_286_1.hightColor1.g, (arg_286_1.time_ - 0.833333333333333) / var_289_15), (Mathf.Lerp(iter_289_12.color.b, arg_286_1.hightColor1.b, (arg_286_1.time_ - 0.833333333333333) / var_289_15)))
							else
								local var_289_16 = Mathf.Lerp(iter_289_12.color.r, 1, (arg_286_1.time_ - 0.833333333333333) / var_289_15)

								iter_289_12.color = Color.New(var_289_16, var_289_16, var_289_16)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= 0.833333333333333 + var_289_15 and arg_286_1.time_ < 0.833333333333333 + var_289_15 + arg_289_0 and not isNil(var_289_14) and arg_286_1.var_.actorSpriteComps10092 then
				for iter_289_13, iter_289_14 in pairs(arg_286_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_289_14 then
						iter_289_14.color = arg_286_1.isInRecall_ and (arg_286_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_286_1.var_.actorSpriteComps10092 = nil
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:AudioAction("play", "effect", "se_story_activity_1_4_3", "se_story_activity_1_4_3_door", "")
			end

			local var_289_18 = 0

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_18 + arg_289_0 then
				arg_286_1.allBtn_.enabled = false
			end

			if arg_286_1.time_ >= var_289_18 + 0.833333333333333 and arg_286_1.time_ < var_289_18 + 0.833333333333333 + arg_289_0 then
				arg_286_1.allBtn_.enabled = true
			end

			if 1 < arg_286_1.time_ and arg_286_1.time_ <= 1 + arg_289_0 then
				local var_289_19 = arg_286_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_289_19 then
					arg_286_1.var_.alphaOldValue10092 = var_289_19.alpha
					arg_286_1.var_.characterEffect10092 = var_289_19
				end

				arg_286_1.var_.alphaOldValue10092 = 0
			end

			local var_289_20 = 0.433333333333333

			if 1 <= arg_286_1.time_ and arg_286_1.time_ < 1 + var_289_20 then
				if arg_286_1.var_.characterEffect10092 then
					arg_286_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_286_1.var_.alphaOldValue10092, 1, (arg_286_1.time_ - 1) / var_289_20)
				end
			end

			if arg_286_1.time_ >= 1 + var_289_20 and arg_286_1.time_ < 1 + var_289_20 + arg_289_0 and arg_286_1.var_.characterEffect10092 then
				arg_286_1.var_.characterEffect10092.alpha = 1
			end

			if arg_286_1.frameCnt_ <= 1 then
				arg_286_1.dialog_:SetActive(false)
			end

			local var_289_21 = 1.43333333333333
			local var_289_22 = 0.275

			if 1.43333333333333 < arg_286_1.time_ and arg_286_1.time_ <= var_289_21 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0

				arg_286_1.dialog_:SetActive(true)

				arg_286_1.dialogCg_.alpha = 0

				local var_289_23 = LeanTween.value(arg_286_1.dialog_, 0, 1, 0.3)

				var_289_23:setOnUpdate(LuaHelper.FloatAction(function(arg_290_0)
					arg_286_1.dialogCg_.alpha = arg_290_0
				end))
				var_289_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_286_1.dialog_)
					var_289_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_286_1.duration_ = arg_286_1.duration_ + 0.3

				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_24 = arg_286_1:GetWordFromCfg(413051068)
				local var_289_25 = arg_286_1:FormatText(var_289_24.content)

				arg_286_1.text_.text = var_289_25

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_27 = 11 <= 0 and var_289_22 or var_289_22 * (utf8.len(var_289_25) / 11)

				if (11 <= 0 and var_289_22 or var_289_22 * (utf8.len(var_289_25) / 11)) > 0 and var_289_22 < var_289_27 then
					arg_286_1.talkMaxDuration = var_289_27
					var_289_21 = var_289_21 + 0.3

					if var_289_27 + var_289_21 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_27 + var_289_21
					end
				end

				arg_286_1.text_.text = var_289_25
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051068", "story_v_out_413051.awb") ~= 0 then
					local var_289_28 = manager.audio:GetVoiceLength("story_v_out_413051", "413051068", "story_v_out_413051.awb") / 1000

					if var_289_28 + var_289_21 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_28 + var_289_21
					end

					if var_289_24.prefab_name ~= "" and arg_286_1.actors_[var_289_24.prefab_name] ~= nil then
						local var_289_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_24.prefab_name].transform, "story_v_out_413051", "413051068", "story_v_out_413051.awb")

						arg_286_1:RecordAudio("413051068", var_289_29)
						arg_286_1:RecordAudio("413051068", var_289_29)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_413051", "413051068", "story_v_out_413051.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_413051", "413051068", "story_v_out_413051.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_30 = var_289_21 + 0.3
			local var_289_31 = math.max(var_289_22, arg_286_1.talkMaxDuration)

			if var_289_21 + 0.3 <= arg_286_1.time_ and arg_286_1.time_ < var_289_30 + var_289_31 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_30) / var_289_31

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_30 + var_289_31 and arg_286_1.time_ < var_289_30 + var_289_31 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play413051069 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 413051069
		arg_292_1.duration_ = 3.5

		local var_292_0 = {
			zh = 2.966,
			ja = 3.5
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
				arg_292_0:Play413051070(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos10092 = arg_292_1.actors_["10092"].transform.localPosition
				arg_292_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_292_1:CheckSpriteTmpPos("10092", 4)

				for iter_295_0 = 0, arg_292_1.actors_["10092"].transform.childCount - 1 do
					local var_295_0 = arg_292_1.actors_["10092"].transform:GetChild(iter_295_0)

					if var_295_0.name == "split_1_1" or not string.find(var_295_0.name, "split") then
						var_295_0.gameObject:SetActive(true)
					else
						var_295_0.gameObject:SetActive(false)
					end
				end
			end

			local var_295_1 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_1 then
				arg_292_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_292_1.time_ - 0) / var_295_1)
			end

			if arg_292_1.time_ >= 0 + var_295_1 and arg_292_1.time_ < 0 + var_295_1 + arg_295_0 then
				arg_292_1.actors_["10092"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_295_2 = arg_292_1.actors_["10092"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_2) and arg_292_1.var_.actorSpriteComps10092 == nil then
				arg_292_1.var_.actorSpriteComps10092 = var_295_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_3 = 2

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_3 and not isNil(var_295_2) then
				if arg_292_1.var_.actorSpriteComps10092 then
					for iter_295_1, iter_295_2 in pairs(arg_292_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_295_2 then
							if arg_292_1.isInRecall_ then
								iter_295_2.color = Color.New(Mathf.Lerp(iter_295_2.color.r, arg_292_1.hightColor2.r, (arg_292_1.time_ - 0) / var_295_3), Mathf.Lerp(iter_295_2.color.g, arg_292_1.hightColor2.g, (arg_292_1.time_ - 0) / var_295_3), (Mathf.Lerp(iter_295_2.color.b, arg_292_1.hightColor2.b, (arg_292_1.time_ - 0) / var_295_3)))
							else
								local var_295_4 = Mathf.Lerp(iter_295_2.color.r, 0.5, (arg_292_1.time_ - 0) / var_295_3)

								iter_295_2.color = Color.New(var_295_4, var_295_4, var_295_4)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= 0 + var_295_3 and arg_292_1.time_ < 0 + var_295_3 + arg_295_0 and not isNil(var_295_2) and arg_292_1.var_.actorSpriteComps10092 then
				for iter_295_3, iter_295_4 in pairs(arg_292_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_295_4 then
						iter_295_4.color = arg_292_1.isInRecall_ and (arg_292_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_292_1.var_.actorSpriteComps10092 = nil
			end

			local var_295_5 = arg_292_1.actors_["10022"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_5) and arg_292_1.var_.actorSpriteComps10022 == nil then
				arg_292_1.var_.actorSpriteComps10022 = var_295_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_295_6 = 2

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_6 and not isNil(var_295_5) then
				if arg_292_1.var_.actorSpriteComps10022 then
					for iter_295_5, iter_295_6 in pairs(arg_292_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_295_6 then
							if arg_292_1.isInRecall_ then
								iter_295_6.color = Color.New(Mathf.Lerp(iter_295_6.color.r, arg_292_1.hightColor1.r, (arg_292_1.time_ - 0) / var_295_6), Mathf.Lerp(iter_295_6.color.g, arg_292_1.hightColor1.g, (arg_292_1.time_ - 0) / var_295_6), (Mathf.Lerp(iter_295_6.color.b, arg_292_1.hightColor1.b, (arg_292_1.time_ - 0) / var_295_6)))
							else
								local var_295_7 = Mathf.Lerp(iter_295_6.color.r, 1, (arg_292_1.time_ - 0) / var_295_6)

								iter_295_6.color = Color.New(var_295_7, var_295_7, var_295_7)
							end
						end
					end
				end
			end

			if arg_292_1.time_ >= 0 + var_295_6 and arg_292_1.time_ < 0 + var_295_6 + arg_295_0 and not isNil(var_295_5) and arg_292_1.var_.actorSpriteComps10022 then
				for iter_295_7, iter_295_8 in pairs(arg_292_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_295_8 then
						iter_295_8.color = arg_292_1.isInRecall_ and (arg_292_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_292_1.var_.actorSpriteComps10022 = nil
			end

			local var_295_8 = arg_292_1.actors_["10022"].transform

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos10022 = var_295_8.localPosition
				var_295_8.localScale = Vector3.New(1, 1, 1)

				arg_292_1:CheckSpriteTmpPos("10022", 2)

				for iter_295_9 = 0, var_295_8.childCount - 1 do
					local var_295_9 = var_295_8:GetChild(iter_295_9)

					if var_295_9.name == "split_8" or not string.find(var_295_9.name, "split") then
						var_295_9.gameObject:SetActive(true)
					else
						var_295_9.gameObject:SetActive(false)
					end
				end
			end

			local var_295_10 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_10 then
				var_295_8.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_292_1.time_ - 0) / var_295_10)
			end

			if arg_292_1.time_ >= 0 + var_295_10 and arg_292_1.time_ < 0 + var_295_10 + arg_295_0 then
				var_295_8.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_295_11 = 0
			local var_295_12 = 0.275

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_11 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_13 = arg_292_1:GetWordFromCfg(413051069)
				local var_295_14 = arg_292_1:FormatText(var_295_13.content)

				arg_292_1.text_.text = var_295_14

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_16 = 11 <= 0 and var_295_12 or var_295_12 * (utf8.len(var_295_14) / 11)

				if (11 <= 0 and var_295_12 or var_295_12 * (utf8.len(var_295_14) / 11)) > 0 and var_295_12 < var_295_16 then
					arg_292_1.talkMaxDuration = var_295_16

					if var_295_16 + var_295_11 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_16 + var_295_11
					end
				end

				arg_292_1.text_.text = var_295_14
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051069", "story_v_out_413051.awb") ~= 0 then
					local var_295_17 = manager.audio:GetVoiceLength("story_v_out_413051", "413051069", "story_v_out_413051.awb") / 1000

					if var_295_17 + var_295_11 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_17 + var_295_11
					end

					if var_295_13.prefab_name ~= "" and arg_292_1.actors_[var_295_13.prefab_name] ~= nil then
						local var_295_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_13.prefab_name].transform, "story_v_out_413051", "413051069", "story_v_out_413051.awb")

						arg_292_1:RecordAudio("413051069", var_295_18)
						arg_292_1:RecordAudio("413051069", var_295_18)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_413051", "413051069", "story_v_out_413051.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_413051", "413051069", "story_v_out_413051.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_19 = math.max(var_295_12, arg_292_1.talkMaxDuration)

			if var_295_11 <= arg_292_1.time_ and arg_292_1.time_ < var_295_11 + var_295_19 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_11) / var_295_19

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_11 + var_295_19 and arg_292_1.time_ < var_295_11 + var_295_19 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
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
				actorName = "10022",
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
	Play413051070 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 413051070
		arg_296_1.duration_ = 5.73

		local var_296_0 = {
			zh = 3.766,
			ja = 5.733
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
				arg_296_0:Play413051071(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos10092 = arg_296_1.actors_["10092"].transform.localPosition
				arg_296_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_296_1:CheckSpriteTmpPos("10092", 4)

				for iter_299_0 = 0, arg_296_1.actors_["10092"].transform.childCount - 1 do
					local var_299_0 = arg_296_1.actors_["10092"].transform:GetChild(iter_299_0)

					if var_299_0.name == "" or not string.find(var_299_0.name, "split") then
						var_299_0.gameObject:SetActive(true)
					else
						var_299_0.gameObject:SetActive(false)
					end
				end
			end

			local var_299_1 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_1 then
				arg_296_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_296_1.time_ - 0) / var_299_1)
			end

			if arg_296_1.time_ >= 0 + var_299_1 and arg_296_1.time_ < 0 + var_299_1 + arg_299_0 then
				arg_296_1.actors_["10092"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_299_2 = arg_296_1.actors_["10092"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_2) and arg_296_1.var_.actorSpriteComps10092 == nil then
				arg_296_1.var_.actorSpriteComps10092 = var_299_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_3 = 2

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_3 and not isNil(var_299_2) then
				if arg_296_1.var_.actorSpriteComps10092 then
					for iter_299_1, iter_299_2 in pairs(arg_296_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_299_2 then
							if arg_296_1.isInRecall_ then
								iter_299_2.color = Color.New(Mathf.Lerp(iter_299_2.color.r, arg_296_1.hightColor1.r, (arg_296_1.time_ - 0) / var_299_3), Mathf.Lerp(iter_299_2.color.g, arg_296_1.hightColor1.g, (arg_296_1.time_ - 0) / var_299_3), (Mathf.Lerp(iter_299_2.color.b, arg_296_1.hightColor1.b, (arg_296_1.time_ - 0) / var_299_3)))
							else
								local var_299_4 = Mathf.Lerp(iter_299_2.color.r, 1, (arg_296_1.time_ - 0) / var_299_3)

								iter_299_2.color = Color.New(var_299_4, var_299_4, var_299_4)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= 0 + var_299_3 and arg_296_1.time_ < 0 + var_299_3 + arg_299_0 and not isNil(var_299_2) and arg_296_1.var_.actorSpriteComps10092 then
				for iter_299_3, iter_299_4 in pairs(arg_296_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_299_4 then
						iter_299_4.color = arg_296_1.isInRecall_ and (arg_296_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_296_1.var_.actorSpriteComps10092 = nil
			end

			local var_299_5 = arg_296_1.actors_["10022"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_5) and arg_296_1.var_.actorSpriteComps10022 == nil then
				arg_296_1.var_.actorSpriteComps10022 = var_299_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_299_6 = 2

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_6 and not isNil(var_299_5) then
				if arg_296_1.var_.actorSpriteComps10022 then
					for iter_299_5, iter_299_6 in pairs(arg_296_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_299_6 then
							if arg_296_1.isInRecall_ then
								iter_299_6.color = Color.New(Mathf.Lerp(iter_299_6.color.r, arg_296_1.hightColor2.r, (arg_296_1.time_ - 0) / var_299_6), Mathf.Lerp(iter_299_6.color.g, arg_296_1.hightColor2.g, (arg_296_1.time_ - 0) / var_299_6), (Mathf.Lerp(iter_299_6.color.b, arg_296_1.hightColor2.b, (arg_296_1.time_ - 0) / var_299_6)))
							else
								local var_299_7 = Mathf.Lerp(iter_299_6.color.r, 0.5, (arg_296_1.time_ - 0) / var_299_6)

								iter_299_6.color = Color.New(var_299_7, var_299_7, var_299_7)
							end
						end
					end
				end
			end

			if arg_296_1.time_ >= 0 + var_299_6 and arg_296_1.time_ < 0 + var_299_6 + arg_299_0 and not isNil(var_299_5) and arg_296_1.var_.actorSpriteComps10022 then
				for iter_299_7, iter_299_8 in pairs(arg_296_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_299_8 then
						iter_299_8.color = arg_296_1.isInRecall_ and (arg_296_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_296_1.var_.actorSpriteComps10022 = nil
			end

			local var_299_8 = 0
			local var_299_9 = 0.425

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_8 + arg_299_0 then
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

				local var_299_10 = arg_296_1:GetWordFromCfg(413051070)
				local var_299_11 = arg_296_1:FormatText(var_299_10.content)

				arg_296_1.text_.text = var_299_11

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_13 = 17 <= 0 and var_299_9 or var_299_9 * (utf8.len(var_299_11) / 17)

				if (17 <= 0 and var_299_9 or var_299_9 * (utf8.len(var_299_11) / 17)) > 0 and var_299_9 < var_299_13 then
					arg_296_1.talkMaxDuration = var_299_13

					if var_299_13 + var_299_8 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_13 + var_299_8
					end
				end

				arg_296_1.text_.text = var_299_11
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051070", "story_v_out_413051.awb") ~= 0 then
					local var_299_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051070", "story_v_out_413051.awb") / 1000

					if var_299_14 + var_299_8 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_14 + var_299_8
					end

					if var_299_10.prefab_name ~= "" and arg_296_1.actors_[var_299_10.prefab_name] ~= nil then
						local var_299_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_10.prefab_name].transform, "story_v_out_413051", "413051070", "story_v_out_413051.awb")

						arg_296_1:RecordAudio("413051070", var_299_15)
						arg_296_1:RecordAudio("413051070", var_299_15)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_413051", "413051070", "story_v_out_413051.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_413051", "413051070", "story_v_out_413051.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_16 = math.max(var_299_9, arg_296_1.talkMaxDuration)

			if var_299_8 <= arg_296_1.time_ and arg_296_1.time_ < var_299_8 + var_299_16 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_8) / var_299_16

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_8 + var_299_16 and arg_296_1.time_ < var_299_8 + var_299_16 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
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

		arg_296_1:InitPlayNodeList()
	end,
	Play413051071 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 413051071
		arg_300_1.duration_ = 11.6

		local var_300_0 = {
			zh = 11.6,
			ja = 11.466
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
				arg_300_0:Play413051072(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos10022 = arg_300_1.actors_["10022"].transform.localPosition
				arg_300_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_300_1:CheckSpriteTmpPos("10022", 2)

				for iter_303_0 = 0, arg_300_1.actors_["10022"].transform.childCount - 1 do
					local var_303_0 = arg_300_1.actors_["10022"].transform:GetChild(iter_303_0)

					if var_303_0.name == "split_8" or not string.find(var_303_0.name, "split") then
						var_303_0.gameObject:SetActive(true)
					else
						var_303_0.gameObject:SetActive(false)
					end
				end
			end

			local var_303_1 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_1 then
				arg_300_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_300_1.time_ - 0) / var_303_1)
			end

			if arg_300_1.time_ >= 0 + var_303_1 and arg_300_1.time_ < 0 + var_303_1 + arg_303_0 then
				arg_300_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_303_2 = arg_300_1.actors_["10092"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_2) and arg_300_1.var_.actorSpriteComps10092 == nil then
				arg_300_1.var_.actorSpriteComps10092 = var_303_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_3 = 2

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_3 and not isNil(var_303_2) then
				if arg_300_1.var_.actorSpriteComps10092 then
					for iter_303_1, iter_303_2 in pairs(arg_300_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_303_2 then
							if arg_300_1.isInRecall_ then
								iter_303_2.color = Color.New(Mathf.Lerp(iter_303_2.color.r, arg_300_1.hightColor2.r, (arg_300_1.time_ - 0) / var_303_3), Mathf.Lerp(iter_303_2.color.g, arg_300_1.hightColor2.g, (arg_300_1.time_ - 0) / var_303_3), (Mathf.Lerp(iter_303_2.color.b, arg_300_1.hightColor2.b, (arg_300_1.time_ - 0) / var_303_3)))
							else
								local var_303_4 = Mathf.Lerp(iter_303_2.color.r, 0.5, (arg_300_1.time_ - 0) / var_303_3)

								iter_303_2.color = Color.New(var_303_4, var_303_4, var_303_4)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= 0 + var_303_3 and arg_300_1.time_ < 0 + var_303_3 + arg_303_0 and not isNil(var_303_2) and arg_300_1.var_.actorSpriteComps10092 then
				for iter_303_3, iter_303_4 in pairs(arg_300_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_303_4 then
						iter_303_4.color = arg_300_1.isInRecall_ and (arg_300_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_300_1.var_.actorSpriteComps10092 = nil
			end

			local var_303_5 = arg_300_1.actors_["10022"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_5) and arg_300_1.var_.actorSpriteComps10022 == nil then
				arg_300_1.var_.actorSpriteComps10022 = var_303_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_303_6 = 2

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_6 and not isNil(var_303_5) then
				if arg_300_1.var_.actorSpriteComps10022 then
					for iter_303_5, iter_303_6 in pairs(arg_300_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_303_6 then
							if arg_300_1.isInRecall_ then
								iter_303_6.color = Color.New(Mathf.Lerp(iter_303_6.color.r, arg_300_1.hightColor1.r, (arg_300_1.time_ - 0) / var_303_6), Mathf.Lerp(iter_303_6.color.g, arg_300_1.hightColor1.g, (arg_300_1.time_ - 0) / var_303_6), (Mathf.Lerp(iter_303_6.color.b, arg_300_1.hightColor1.b, (arg_300_1.time_ - 0) / var_303_6)))
							else
								local var_303_7 = Mathf.Lerp(iter_303_6.color.r, 1, (arg_300_1.time_ - 0) / var_303_6)

								iter_303_6.color = Color.New(var_303_7, var_303_7, var_303_7)
							end
						end
					end
				end
			end

			if arg_300_1.time_ >= 0 + var_303_6 and arg_300_1.time_ < 0 + var_303_6 + arg_303_0 and not isNil(var_303_5) and arg_300_1.var_.actorSpriteComps10022 then
				for iter_303_7, iter_303_8 in pairs(arg_300_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_303_8 then
						iter_303_8.color = arg_300_1.isInRecall_ and (arg_300_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_300_1.var_.actorSpriteComps10022 = nil
			end

			local var_303_8 = 0
			local var_303_9 = 1.05

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_8 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_10 = arg_300_1:GetWordFromCfg(413051071)
				local var_303_11 = arg_300_1:FormatText(var_303_10.content)

				arg_300_1.text_.text = var_303_11

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_13 = 42 <= 0 and var_303_9 or var_303_9 * (utf8.len(var_303_11) / 42)

				if (42 <= 0 and var_303_9 or var_303_9 * (utf8.len(var_303_11) / 42)) > 0 and var_303_9 < var_303_13 then
					arg_300_1.talkMaxDuration = var_303_13

					if var_303_13 + var_303_8 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_13 + var_303_8
					end
				end

				arg_300_1.text_.text = var_303_11
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051071", "story_v_out_413051.awb") ~= 0 then
					local var_303_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051071", "story_v_out_413051.awb") / 1000

					if var_303_14 + var_303_8 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_14 + var_303_8
					end

					if var_303_10.prefab_name ~= "" and arg_300_1.actors_[var_303_10.prefab_name] ~= nil then
						local var_303_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_10.prefab_name].transform, "story_v_out_413051", "413051071", "story_v_out_413051.awb")

						arg_300_1:RecordAudio("413051071", var_303_15)
						arg_300_1:RecordAudio("413051071", var_303_15)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_413051", "413051071", "story_v_out_413051.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_413051", "413051071", "story_v_out_413051.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_16 = math.max(var_303_9, arg_300_1.talkMaxDuration)

			if var_303_8 <= arg_300_1.time_ and arg_300_1.time_ < var_303_8 + var_303_16 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_8) / var_303_16

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_8 + var_303_16 and arg_300_1.time_ < var_303_8 + var_303_16 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
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

		arg_300_1:InitPlayNodeList()
	end,
	Play413051072 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 413051072
		arg_304_1.duration_ = 7.6

		local var_304_0 = {
			zh = 6.4,
			ja = 7.6
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
				arg_304_0:Play413051073(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos10092 = arg_304_1.actors_["10092"].transform.localPosition
				arg_304_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_304_1:CheckSpriteTmpPos("10092", 4)

				for iter_307_0 = 0, arg_304_1.actors_["10092"].transform.childCount - 1 do
					local var_307_0 = arg_304_1.actors_["10092"].transform:GetChild(iter_307_0)

					if var_307_0.name == "split_2" or not string.find(var_307_0.name, "split") then
						var_307_0.gameObject:SetActive(true)
					else
						var_307_0.gameObject:SetActive(false)
					end
				end
			end

			local var_307_1 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_1 then
				arg_304_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_304_1.time_ - 0) / var_307_1)
			end

			if arg_304_1.time_ >= 0 + var_307_1 and arg_304_1.time_ < 0 + var_307_1 + arg_307_0 then
				arg_304_1.actors_["10092"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_307_2 = arg_304_1.actors_["10092"]

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(var_307_2) and arg_304_1.var_.actorSpriteComps10092 == nil then
				arg_304_1.var_.actorSpriteComps10092 = var_307_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_307_3 = 2

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_3 and not isNil(var_307_2) then
				if arg_304_1.var_.actorSpriteComps10092 then
					for iter_307_1, iter_307_2 in pairs(arg_304_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_307_2 then
							if arg_304_1.isInRecall_ then
								iter_307_2.color = Color.New(Mathf.Lerp(iter_307_2.color.r, arg_304_1.hightColor1.r, (arg_304_1.time_ - 0) / var_307_3), Mathf.Lerp(iter_307_2.color.g, arg_304_1.hightColor1.g, (arg_304_1.time_ - 0) / var_307_3), (Mathf.Lerp(iter_307_2.color.b, arg_304_1.hightColor1.b, (arg_304_1.time_ - 0) / var_307_3)))
							else
								local var_307_4 = Mathf.Lerp(iter_307_2.color.r, 1, (arg_304_1.time_ - 0) / var_307_3)

								iter_307_2.color = Color.New(var_307_4, var_307_4, var_307_4)
							end
						end
					end
				end
			end

			if arg_304_1.time_ >= 0 + var_307_3 and arg_304_1.time_ < 0 + var_307_3 + arg_307_0 and not isNil(var_307_2) and arg_304_1.var_.actorSpriteComps10092 then
				for iter_307_3, iter_307_4 in pairs(arg_304_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_307_4 then
						iter_307_4.color = arg_304_1.isInRecall_ and (arg_304_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_304_1.var_.actorSpriteComps10092 = nil
			end

			local var_307_5 = arg_304_1.actors_["10022"]

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(var_307_5) and arg_304_1.var_.actorSpriteComps10022 == nil then
				arg_304_1.var_.actorSpriteComps10022 = var_307_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_307_6 = 2

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_6 and not isNil(var_307_5) then
				if arg_304_1.var_.actorSpriteComps10022 then
					for iter_307_5, iter_307_6 in pairs(arg_304_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_307_6 then
							if arg_304_1.isInRecall_ then
								iter_307_6.color = Color.New(Mathf.Lerp(iter_307_6.color.r, arg_304_1.hightColor2.r, (arg_304_1.time_ - 0) / var_307_6), Mathf.Lerp(iter_307_6.color.g, arg_304_1.hightColor2.g, (arg_304_1.time_ - 0) / var_307_6), (Mathf.Lerp(iter_307_6.color.b, arg_304_1.hightColor2.b, (arg_304_1.time_ - 0) / var_307_6)))
							else
								local var_307_7 = Mathf.Lerp(iter_307_6.color.r, 0.5, (arg_304_1.time_ - 0) / var_307_6)

								iter_307_6.color = Color.New(var_307_7, var_307_7, var_307_7)
							end
						end
					end
				end
			end

			if arg_304_1.time_ >= 0 + var_307_6 and arg_304_1.time_ < 0 + var_307_6 + arg_307_0 and not isNil(var_307_5) and arg_304_1.var_.actorSpriteComps10022 then
				for iter_307_7, iter_307_8 in pairs(arg_304_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_307_8 then
						iter_307_8.color = arg_304_1.isInRecall_ and (arg_304_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_304_1.var_.actorSpriteComps10022 = nil
			end

			local var_307_8 = 0
			local var_307_9 = 0.725

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_8 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_10 = arg_304_1:GetWordFromCfg(413051072)
				local var_307_11 = arg_304_1:FormatText(var_307_10.content)

				arg_304_1.text_.text = var_307_11

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_13 = 29 <= 0 and var_307_9 or var_307_9 * (utf8.len(var_307_11) / 29)

				if (29 <= 0 and var_307_9 or var_307_9 * (utf8.len(var_307_11) / 29)) > 0 and var_307_9 < var_307_13 then
					arg_304_1.talkMaxDuration = var_307_13

					if var_307_13 + var_307_8 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_13 + var_307_8
					end
				end

				arg_304_1.text_.text = var_307_11
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051072", "story_v_out_413051.awb") ~= 0 then
					local var_307_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051072", "story_v_out_413051.awb") / 1000

					if var_307_14 + var_307_8 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_14 + var_307_8
					end

					if var_307_10.prefab_name ~= "" and arg_304_1.actors_[var_307_10.prefab_name] ~= nil then
						local var_307_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_10.prefab_name].transform, "story_v_out_413051", "413051072", "story_v_out_413051.awb")

						arg_304_1:RecordAudio("413051072", var_307_15)
						arg_304_1:RecordAudio("413051072", var_307_15)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_413051", "413051072", "story_v_out_413051.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_413051", "413051072", "story_v_out_413051.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_16 = math.max(var_307_9, arg_304_1.talkMaxDuration)

			if var_307_8 <= arg_304_1.time_ and arg_304_1.time_ < var_307_8 + var_307_16 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_8) / var_307_16

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_8 + var_307_16 and arg_304_1.time_ < var_307_8 + var_307_16 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
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

		arg_304_1:InitPlayNodeList()
	end,
	Play413051073 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 413051073
		arg_308_1.duration_ = 5.33

		local var_308_0 = {
			zh = 2.5,
			ja = 5.333
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
				arg_308_0:Play413051074(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos10022 = arg_308_1.actors_["10022"].transform.localPosition
				arg_308_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_308_1:CheckSpriteTmpPos("10022", 2)

				for iter_311_0 = 0, arg_308_1.actors_["10022"].transform.childCount - 1 do
					local var_311_0 = arg_308_1.actors_["10022"].transform:GetChild(iter_311_0)

					if var_311_0.name == "split_1" or not string.find(var_311_0.name, "split") then
						var_311_0.gameObject:SetActive(true)
					else
						var_311_0.gameObject:SetActive(false)
					end
				end
			end

			local var_311_1 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_1 then
				arg_308_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_308_1.time_ - 0) / var_311_1)
			end

			if arg_308_1.time_ >= 0 + var_311_1 and arg_308_1.time_ < 0 + var_311_1 + arg_311_0 then
				arg_308_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_311_2 = arg_308_1.actors_["10092"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_2) and arg_308_1.var_.actorSpriteComps10092 == nil then
				arg_308_1.var_.actorSpriteComps10092 = var_311_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_3 = 2

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_3 and not isNil(var_311_2) then
				if arg_308_1.var_.actorSpriteComps10092 then
					for iter_311_1, iter_311_2 in pairs(arg_308_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_311_2 then
							if arg_308_1.isInRecall_ then
								iter_311_2.color = Color.New(Mathf.Lerp(iter_311_2.color.r, arg_308_1.hightColor2.r, (arg_308_1.time_ - 0) / var_311_3), Mathf.Lerp(iter_311_2.color.g, arg_308_1.hightColor2.g, (arg_308_1.time_ - 0) / var_311_3), (Mathf.Lerp(iter_311_2.color.b, arg_308_1.hightColor2.b, (arg_308_1.time_ - 0) / var_311_3)))
							else
								local var_311_4 = Mathf.Lerp(iter_311_2.color.r, 0.5, (arg_308_1.time_ - 0) / var_311_3)

								iter_311_2.color = Color.New(var_311_4, var_311_4, var_311_4)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= 0 + var_311_3 and arg_308_1.time_ < 0 + var_311_3 + arg_311_0 and not isNil(var_311_2) and arg_308_1.var_.actorSpriteComps10092 then
				for iter_311_3, iter_311_4 in pairs(arg_308_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_311_4 then
						iter_311_4.color = arg_308_1.isInRecall_ and (arg_308_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_308_1.var_.actorSpriteComps10092 = nil
			end

			local var_311_5 = arg_308_1.actors_["10022"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_5) and arg_308_1.var_.actorSpriteComps10022 == nil then
				arg_308_1.var_.actorSpriteComps10022 = var_311_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_311_6 = 2

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_6 and not isNil(var_311_5) then
				if arg_308_1.var_.actorSpriteComps10022 then
					for iter_311_5, iter_311_6 in pairs(arg_308_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_311_6 then
							if arg_308_1.isInRecall_ then
								iter_311_6.color = Color.New(Mathf.Lerp(iter_311_6.color.r, arg_308_1.hightColor1.r, (arg_308_1.time_ - 0) / var_311_6), Mathf.Lerp(iter_311_6.color.g, arg_308_1.hightColor1.g, (arg_308_1.time_ - 0) / var_311_6), (Mathf.Lerp(iter_311_6.color.b, arg_308_1.hightColor1.b, (arg_308_1.time_ - 0) / var_311_6)))
							else
								local var_311_7 = Mathf.Lerp(iter_311_6.color.r, 1, (arg_308_1.time_ - 0) / var_311_6)

								iter_311_6.color = Color.New(var_311_7, var_311_7, var_311_7)
							end
						end
					end
				end
			end

			if arg_308_1.time_ >= 0 + var_311_6 and arg_308_1.time_ < 0 + var_311_6 + arg_311_0 and not isNil(var_311_5) and arg_308_1.var_.actorSpriteComps10022 then
				for iter_311_7, iter_311_8 in pairs(arg_308_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_311_8 then
						iter_311_8.color = arg_308_1.isInRecall_ and (arg_308_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_308_1.var_.actorSpriteComps10022 = nil
			end

			local var_311_8 = 0
			local var_311_9 = 0.3

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_8 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_10 = arg_308_1:GetWordFromCfg(413051073)
				local var_311_11 = arg_308_1:FormatText(var_311_10.content)

				arg_308_1.text_.text = var_311_11

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_13 = 12 <= 0 and var_311_9 or var_311_9 * (utf8.len(var_311_11) / 12)

				if (12 <= 0 and var_311_9 or var_311_9 * (utf8.len(var_311_11) / 12)) > 0 and var_311_9 < var_311_13 then
					arg_308_1.talkMaxDuration = var_311_13

					if var_311_13 + var_311_8 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_13 + var_311_8
					end
				end

				arg_308_1.text_.text = var_311_11
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051073", "story_v_out_413051.awb") ~= 0 then
					local var_311_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051073", "story_v_out_413051.awb") / 1000

					if var_311_14 + var_311_8 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_14 + var_311_8
					end

					if var_311_10.prefab_name ~= "" and arg_308_1.actors_[var_311_10.prefab_name] ~= nil then
						local var_311_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_10.prefab_name].transform, "story_v_out_413051", "413051073", "story_v_out_413051.awb")

						arg_308_1:RecordAudio("413051073", var_311_15)
						arg_308_1:RecordAudio("413051073", var_311_15)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_413051", "413051073", "story_v_out_413051.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_413051", "413051073", "story_v_out_413051.awb")
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
				actorName = "10022",
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
	Play413051074 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 413051074
		arg_312_1.duration_ = 10.5

		local var_312_0 = {
			zh = 8,
			ja = 10.5
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
				arg_312_0:Play413051075(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos10092 = arg_312_1.actors_["10092"].transform.localPosition
				arg_312_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_312_1:CheckSpriteTmpPos("10092", 4)

				for iter_315_0 = 0, arg_312_1.actors_["10092"].transform.childCount - 1 do
					local var_315_0 = arg_312_1.actors_["10092"].transform:GetChild(iter_315_0)

					if var_315_0.name == "" or not string.find(var_315_0.name, "split") then
						var_315_0.gameObject:SetActive(true)
					else
						var_315_0.gameObject:SetActive(false)
					end
				end
			end

			local var_315_1 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_1 then
				arg_312_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_312_1.time_ - 0) / var_315_1)
			end

			if arg_312_1.time_ >= 0 + var_315_1 and arg_312_1.time_ < 0 + var_315_1 + arg_315_0 then
				arg_312_1.actors_["10092"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_315_2 = arg_312_1.actors_["10092"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_2) and arg_312_1.var_.actorSpriteComps10092 == nil then
				arg_312_1.var_.actorSpriteComps10092 = var_315_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_3 = 2

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_3 and not isNil(var_315_2) then
				if arg_312_1.var_.actorSpriteComps10092 then
					for iter_315_1, iter_315_2 in pairs(arg_312_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_312_1.time_ >= 0 + var_315_3 and arg_312_1.time_ < 0 + var_315_3 + arg_315_0 and not isNil(var_315_2) and arg_312_1.var_.actorSpriteComps10092 then
				for iter_315_3, iter_315_4 in pairs(arg_312_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_315_4 then
						iter_315_4.color = arg_312_1.isInRecall_ and (arg_312_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_312_1.var_.actorSpriteComps10092 = nil
			end

			local var_315_5 = arg_312_1.actors_["10022"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_5) and arg_312_1.var_.actorSpriteComps10022 == nil then
				arg_312_1.var_.actorSpriteComps10022 = var_315_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_315_6 = 2

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_6 and not isNil(var_315_5) then
				if arg_312_1.var_.actorSpriteComps10022 then
					for iter_315_5, iter_315_6 in pairs(arg_312_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_312_1.time_ >= 0 + var_315_6 and arg_312_1.time_ < 0 + var_315_6 + arg_315_0 and not isNil(var_315_5) and arg_312_1.var_.actorSpriteComps10022 then
				for iter_315_7, iter_315_8 in pairs(arg_312_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_315_8 then
						iter_315_8.color = arg_312_1.isInRecall_ and (arg_312_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_312_1.var_.actorSpriteComps10022 = nil
			end

			local var_315_8 = 0
			local var_315_9 = 1.025

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_8 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_10 = arg_312_1:GetWordFromCfg(413051074)
				local var_315_11 = arg_312_1:FormatText(var_315_10.content)

				arg_312_1.text_.text = var_315_11

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_13 = 41 <= 0 and var_315_9 or var_315_9 * (utf8.len(var_315_11) / 41)

				if (41 <= 0 and var_315_9 or var_315_9 * (utf8.len(var_315_11) / 41)) > 0 and var_315_9 < var_315_13 then
					arg_312_1.talkMaxDuration = var_315_13

					if var_315_13 + var_315_8 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_13 + var_315_8
					end
				end

				arg_312_1.text_.text = var_315_11
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051074", "story_v_out_413051.awb") ~= 0 then
					local var_315_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051074", "story_v_out_413051.awb") / 1000

					if var_315_14 + var_315_8 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_14 + var_315_8
					end

					if var_315_10.prefab_name ~= "" and arg_312_1.actors_[var_315_10.prefab_name] ~= nil then
						local var_315_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_10.prefab_name].transform, "story_v_out_413051", "413051074", "story_v_out_413051.awb")

						arg_312_1:RecordAudio("413051074", var_315_15)
						arg_312_1:RecordAudio("413051074", var_315_15)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_413051", "413051074", "story_v_out_413051.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_413051", "413051074", "story_v_out_413051.awb")
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
				actorName = "10092",
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
	Play413051075 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 413051075
		arg_316_1.duration_ = 4.43

		local var_316_0 = {
			zh = 4.433,
			ja = 3.9
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
				arg_316_0:Play413051076(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos10092 = arg_316_1.actors_["10092"].transform.localPosition
				arg_316_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_316_1:CheckSpriteTmpPos("10092", 7)

				for iter_319_0 = 0, arg_316_1.actors_["10092"].transform.childCount - 1 do
					local var_319_0 = arg_316_1.actors_["10092"].transform:GetChild(iter_319_0)

					if var_319_0.name == "" or not string.find(var_319_0.name, "split") then
						var_319_0.gameObject:SetActive(true)
					else
						var_319_0.gameObject:SetActive(false)
					end
				end
			end

			local var_319_1 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_1 then
				arg_316_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_316_1.time_ - 0) / var_319_1)
			end

			if arg_316_1.time_ >= 0 + var_319_1 and arg_316_1.time_ < 0 + var_319_1 + arg_319_0 then
				arg_316_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_319_2 = arg_316_1.actors_["10022"].transform

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos10022 = var_319_2.localPosition
				var_319_2.localScale = Vector3.New(1, 1, 1)

				arg_316_1:CheckSpriteTmpPos("10022", 7)

				for iter_319_1 = 0, var_319_2.childCount - 1 do
					local var_319_3 = var_319_2:GetChild(iter_319_1)

					if var_319_3.name == "" or not string.find(var_319_3.name, "split") then
						var_319_3.gameObject:SetActive(true)
					else
						var_319_3.gameObject:SetActive(false)
					end
				end
			end

			local var_319_4 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_4 then
				var_319_2.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_316_1.time_ - 0) / var_319_4)
			end

			if arg_316_1.time_ >= 0 + var_319_4 and arg_316_1.time_ < 0 + var_319_4 + arg_319_0 then
				var_319_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_319_5 = arg_316_1.actors_["10093"].transform

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.var_.moveOldPos10093 = var_319_5.localPosition
				var_319_5.localScale = Vector3.New(1, 1, 1)

				arg_316_1:CheckSpriteTmpPos("10093", 3)

				for iter_319_2 = 0, var_319_5.childCount - 1 do
					local var_319_6 = var_319_5:GetChild(iter_319_2)

					if var_319_6.name == "split_6" or not string.find(var_319_6.name, "split") then
						var_319_6.gameObject:SetActive(true)
					else
						var_319_6.gameObject:SetActive(false)
					end
				end
			end

			local var_319_7 = 0.001

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_7 then
				var_319_5.localPosition = Vector3.Lerp(arg_316_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_316_1.time_ - 0) / var_319_7)
			end

			if arg_316_1.time_ >= 0 + var_319_7 and arg_316_1.time_ < 0 + var_319_7 + arg_319_0 then
				var_319_5.localPosition = Vector3.New(0, -345, -245)
			end

			local var_319_8 = arg_316_1.actors_["10092"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_8) and arg_316_1.var_.actorSpriteComps10092 == nil then
				arg_316_1.var_.actorSpriteComps10092 = var_319_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_9 = 2

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_9 and not isNil(var_319_8) then
				if arg_316_1.var_.actorSpriteComps10092 then
					for iter_319_3, iter_319_4 in pairs(arg_316_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_319_4 then
							if arg_316_1.isInRecall_ then
								iter_319_4.color = Color.New(Mathf.Lerp(iter_319_4.color.r, arg_316_1.hightColor2.r, (arg_316_1.time_ - 0) / var_319_9), Mathf.Lerp(iter_319_4.color.g, arg_316_1.hightColor2.g, (arg_316_1.time_ - 0) / var_319_9), (Mathf.Lerp(iter_319_4.color.b, arg_316_1.hightColor2.b, (arg_316_1.time_ - 0) / var_319_9)))
							else
								local var_319_10 = Mathf.Lerp(iter_319_4.color.r, 0.5, (arg_316_1.time_ - 0) / var_319_9)

								iter_319_4.color = Color.New(var_319_10, var_319_10, var_319_10)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= 0 + var_319_9 and arg_316_1.time_ < 0 + var_319_9 + arg_319_0 and not isNil(var_319_8) and arg_316_1.var_.actorSpriteComps10092 then
				for iter_319_5, iter_319_6 in pairs(arg_316_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_319_6 then
						iter_319_6.color = arg_316_1.isInRecall_ and (arg_316_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_316_1.var_.actorSpriteComps10092 = nil
			end

			local var_319_11 = arg_316_1.actors_["10022"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_11) and arg_316_1.var_.actorSpriteComps10022 == nil then
				arg_316_1.var_.actorSpriteComps10022 = var_319_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_12 = 2

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_12 and not isNil(var_319_11) then
				if arg_316_1.var_.actorSpriteComps10022 then
					for iter_319_7, iter_319_8 in pairs(arg_316_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_319_8 then
							if arg_316_1.isInRecall_ then
								iter_319_8.color = Color.New(Mathf.Lerp(iter_319_8.color.r, arg_316_1.hightColor2.r, (arg_316_1.time_ - 0) / var_319_12), Mathf.Lerp(iter_319_8.color.g, arg_316_1.hightColor2.g, (arg_316_1.time_ - 0) / var_319_12), (Mathf.Lerp(iter_319_8.color.b, arg_316_1.hightColor2.b, (arg_316_1.time_ - 0) / var_319_12)))
							else
								local var_319_13 = Mathf.Lerp(iter_319_8.color.r, 0.5, (arg_316_1.time_ - 0) / var_319_12)

								iter_319_8.color = Color.New(var_319_13, var_319_13, var_319_13)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= 0 + var_319_12 and arg_316_1.time_ < 0 + var_319_12 + arg_319_0 and not isNil(var_319_11) and arg_316_1.var_.actorSpriteComps10022 then
				for iter_319_9, iter_319_10 in pairs(arg_316_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_319_10 then
						iter_319_10.color = arg_316_1.isInRecall_ and (arg_316_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_316_1.var_.actorSpriteComps10022 = nil
			end

			local var_319_14 = arg_316_1.actors_["10093"]

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(var_319_14) and arg_316_1.var_.actorSpriteComps10093 == nil then
				arg_316_1.var_.actorSpriteComps10093 = var_319_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_319_15 = 2

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_15 and not isNil(var_319_14) then
				if arg_316_1.var_.actorSpriteComps10093 then
					for iter_319_11, iter_319_12 in pairs(arg_316_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_319_12 then
							if arg_316_1.isInRecall_ then
								iter_319_12.color = Color.New(Mathf.Lerp(iter_319_12.color.r, arg_316_1.hightColor1.r, (arg_316_1.time_ - 0) / var_319_15), Mathf.Lerp(iter_319_12.color.g, arg_316_1.hightColor1.g, (arg_316_1.time_ - 0) / var_319_15), (Mathf.Lerp(iter_319_12.color.b, arg_316_1.hightColor1.b, (arg_316_1.time_ - 0) / var_319_15)))
							else
								local var_319_16 = Mathf.Lerp(iter_319_12.color.r, 1, (arg_316_1.time_ - 0) / var_319_15)

								iter_319_12.color = Color.New(var_319_16, var_319_16, var_319_16)
							end
						end
					end
				end
			end

			if arg_316_1.time_ >= 0 + var_319_15 and arg_316_1.time_ < 0 + var_319_15 + arg_319_0 and not isNil(var_319_14) and arg_316_1.var_.actorSpriteComps10093 then
				for iter_319_13, iter_319_14 in pairs(arg_316_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_319_14 then
						iter_319_14.color = arg_316_1.isInRecall_ and (arg_316_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_316_1.var_.actorSpriteComps10093 = nil
			end

			local var_319_17 = 0
			local var_319_18 = 0.575

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_17 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_19 = arg_316_1:GetWordFromCfg(413051075)
				local var_319_20 = arg_316_1:FormatText(var_319_19.content)

				arg_316_1.text_.text = var_319_20

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_22 = 23 <= 0 and var_319_18 or var_319_18 * (utf8.len(var_319_20) / 23)

				if (23 <= 0 and var_319_18 or var_319_18 * (utf8.len(var_319_20) / 23)) > 0 and var_319_18 < var_319_22 then
					arg_316_1.talkMaxDuration = var_319_22

					if var_319_22 + var_319_17 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_22 + var_319_17
					end
				end

				arg_316_1.text_.text = var_319_20
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051075", "story_v_out_413051.awb") ~= 0 then
					local var_319_23 = manager.audio:GetVoiceLength("story_v_out_413051", "413051075", "story_v_out_413051.awb") / 1000

					if var_319_23 + var_319_17 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_23 + var_319_17
					end

					if var_319_19.prefab_name ~= "" and arg_316_1.actors_[var_319_19.prefab_name] ~= nil then
						local var_319_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_19.prefab_name].transform, "story_v_out_413051", "413051075", "story_v_out_413051.awb")

						arg_316_1:RecordAudio("413051075", var_319_24)
						arg_316_1:RecordAudio("413051075", var_319_24)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_413051", "413051075", "story_v_out_413051.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_413051", "413051075", "story_v_out_413051.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_25 = math.max(var_319_18, arg_316_1.talkMaxDuration)

			if var_319_17 <= arg_316_1.time_ and arg_316_1.time_ < var_319_17 + var_319_25 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_17) / var_319_25

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_17 + var_319_25 and arg_316_1.time_ < var_319_17 + var_319_25 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {
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
				actorName = "10093",
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
	Play413051076 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 413051076
		arg_320_1.duration_ = 10.4

		local var_320_0 = {
			zh = 8.766,
			ja = 10.4
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
				arg_320_0:Play413051077(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.moveOldPos10093 = arg_320_1.actors_["10093"].transform.localPosition
				arg_320_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_320_1:CheckSpriteTmpPos("10093", 4)

				for iter_323_0 = 0, arg_320_1.actors_["10093"].transform.childCount - 1 do
					local var_323_0 = arg_320_1.actors_["10093"].transform:GetChild(iter_323_0)

					if var_323_0.name == "split_6" or not string.find(var_323_0.name, "split") then
						var_323_0.gameObject:SetActive(true)
					else
						var_323_0.gameObject:SetActive(false)
					end
				end
			end

			local var_323_1 = 0.001

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_1 then
				arg_320_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_320_1.time_ - 0) / var_323_1)
			end

			if arg_320_1.time_ >= 0 + var_323_1 and arg_320_1.time_ < 0 + var_323_1 + arg_323_0 then
				arg_320_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_323_2 = arg_320_1.actors_["10092"].transform

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.moveOldPos10092 = var_323_2.localPosition
				var_323_2.localScale = Vector3.New(1, 1, 1)

				arg_320_1:CheckSpriteTmpPos("10092", 2)

				for iter_323_1 = 0, var_323_2.childCount - 1 do
					local var_323_3 = var_323_2:GetChild(iter_323_1)

					if var_323_3.name == "" or not string.find(var_323_3.name, "split") then
						var_323_3.gameObject:SetActive(true)
					else
						var_323_3.gameObject:SetActive(false)
					end
				end
			end

			local var_323_4 = 0.001

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_4 then
				var_323_2.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_320_1.time_ - 0) / var_323_4)
			end

			if arg_320_1.time_ >= 0 + var_323_4 and arg_320_1.time_ < 0 + var_323_4 + arg_323_0 then
				var_323_2.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_323_5 = arg_320_1.actors_["10093"]

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(var_323_5) and arg_320_1.var_.actorSpriteComps10093 == nil then
				arg_320_1.var_.actorSpriteComps10093 = var_323_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_323_6 = 2

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_6 and not isNil(var_323_5) then
				if arg_320_1.var_.actorSpriteComps10093 then
					for iter_323_2, iter_323_3 in pairs(arg_320_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_323_3 then
							if arg_320_1.isInRecall_ then
								iter_323_3.color = Color.New(Mathf.Lerp(iter_323_3.color.r, arg_320_1.hightColor2.r, (arg_320_1.time_ - 0) / var_323_6), Mathf.Lerp(iter_323_3.color.g, arg_320_1.hightColor2.g, (arg_320_1.time_ - 0) / var_323_6), (Mathf.Lerp(iter_323_3.color.b, arg_320_1.hightColor2.b, (arg_320_1.time_ - 0) / var_323_6)))
							else
								local var_323_7 = Mathf.Lerp(iter_323_3.color.r, 0.5, (arg_320_1.time_ - 0) / var_323_6)

								iter_323_3.color = Color.New(var_323_7, var_323_7, var_323_7)
							end
						end
					end
				end
			end

			if arg_320_1.time_ >= 0 + var_323_6 and arg_320_1.time_ < 0 + var_323_6 + arg_323_0 and not isNil(var_323_5) and arg_320_1.var_.actorSpriteComps10093 then
				for iter_323_4, iter_323_5 in pairs(arg_320_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_323_5 then
						iter_323_5.color = arg_320_1.isInRecall_ and (arg_320_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_320_1.var_.actorSpriteComps10093 = nil
			end

			local var_323_8 = arg_320_1.actors_["10092"]

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(var_323_8) and arg_320_1.var_.actorSpriteComps10092 == nil then
				arg_320_1.var_.actorSpriteComps10092 = var_323_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_323_9 = 2

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_9 and not isNil(var_323_8) then
				if arg_320_1.var_.actorSpriteComps10092 then
					for iter_323_6, iter_323_7 in pairs(arg_320_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_323_7 then
							if arg_320_1.isInRecall_ then
								iter_323_7.color = Color.New(Mathf.Lerp(iter_323_7.color.r, arg_320_1.hightColor1.r, (arg_320_1.time_ - 0) / var_323_9), Mathf.Lerp(iter_323_7.color.g, arg_320_1.hightColor1.g, (arg_320_1.time_ - 0) / var_323_9), (Mathf.Lerp(iter_323_7.color.b, arg_320_1.hightColor1.b, (arg_320_1.time_ - 0) / var_323_9)))
							else
								local var_323_10 = Mathf.Lerp(iter_323_7.color.r, 1, (arg_320_1.time_ - 0) / var_323_9)

								iter_323_7.color = Color.New(var_323_10, var_323_10, var_323_10)
							end
						end
					end
				end
			end

			if arg_320_1.time_ >= 0 + var_323_9 and arg_320_1.time_ < 0 + var_323_9 + arg_323_0 and not isNil(var_323_8) and arg_320_1.var_.actorSpriteComps10092 then
				for iter_323_8, iter_323_9 in pairs(arg_320_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_323_9 then
						iter_323_9.color = arg_320_1.isInRecall_ and (arg_320_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_320_1.var_.actorSpriteComps10092 = nil
			end

			local var_323_11 = 0
			local var_323_12 = 1.125

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_11 + arg_323_0 then
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

				local var_323_13 = arg_320_1:GetWordFromCfg(413051076)
				local var_323_14 = arg_320_1:FormatText(var_323_13.content)

				arg_320_1.text_.text = var_323_14

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_16 = 45 <= 0 and var_323_12 or var_323_12 * (utf8.len(var_323_14) / 45)

				if (45 <= 0 and var_323_12 or var_323_12 * (utf8.len(var_323_14) / 45)) > 0 and var_323_12 < var_323_16 then
					arg_320_1.talkMaxDuration = var_323_16

					if var_323_16 + var_323_11 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_16 + var_323_11
					end
				end

				arg_320_1.text_.text = var_323_14
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051076", "story_v_out_413051.awb") ~= 0 then
					local var_323_17 = manager.audio:GetVoiceLength("story_v_out_413051", "413051076", "story_v_out_413051.awb") / 1000

					if var_323_17 + var_323_11 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_17 + var_323_11
					end

					if var_323_13.prefab_name ~= "" and arg_320_1.actors_[var_323_13.prefab_name] ~= nil then
						local var_323_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_13.prefab_name].transform, "story_v_out_413051", "413051076", "story_v_out_413051.awb")

						arg_320_1:RecordAudio("413051076", var_323_18)
						arg_320_1:RecordAudio("413051076", var_323_18)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_413051", "413051076", "story_v_out_413051.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_413051", "413051076", "story_v_out_413051.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_19 = math.max(var_323_12, arg_320_1.talkMaxDuration)

			if var_323_11 <= arg_320_1.time_ and arg_320_1.time_ < var_323_11 + var_323_19 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_11) / var_323_19

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_11 + var_323_19 and arg_320_1.time_ < var_323_11 + var_323_19 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
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

		arg_320_1:InitPlayNodeList()
	end,
	Play413051077 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 413051077
		arg_324_1.duration_ = 5.2

		local var_324_0 = {
			zh = 5.2,
			ja = 4.8
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
				arg_324_0:Play413051078(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(arg_324_1.actors_["10092"]) and arg_324_1.var_.actorSpriteComps10092 == nil then
				arg_324_1.var_.actorSpriteComps10092 = arg_324_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_327_0 = 2

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 and not isNil(arg_324_1.actors_["10092"]) then
				if arg_324_1.var_.actorSpriteComps10092 then
					for iter_327_0, iter_327_1 in pairs(arg_324_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_327_1 then
							if arg_324_1.isInRecall_ then
								iter_327_1.color = Color.New(Mathf.Lerp(iter_327_1.color.r, arg_324_1.hightColor2.r, (arg_324_1.time_ - 0) / var_327_0), Mathf.Lerp(iter_327_1.color.g, arg_324_1.hightColor2.g, (arg_324_1.time_ - 0) / var_327_0), (Mathf.Lerp(iter_327_1.color.b, arg_324_1.hightColor2.b, (arg_324_1.time_ - 0) / var_327_0)))
							else
								local var_327_1 = Mathf.Lerp(iter_327_1.color.r, 0.5, (arg_324_1.time_ - 0) / var_327_0)

								iter_327_1.color = Color.New(var_327_1, var_327_1, var_327_1)
							end
						end
					end
				end
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 and not isNil(arg_324_1.actors_["10092"]) and arg_324_1.var_.actorSpriteComps10092 then
				for iter_327_2, iter_327_3 in pairs(arg_324_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_327_3 then
						iter_327_3.color = arg_324_1.isInRecall_ and (arg_324_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_324_1.var_.actorSpriteComps10092 = nil
			end

			local var_327_2 = arg_324_1.actors_["10093"]

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(var_327_2) and arg_324_1.var_.actorSpriteComps10093 == nil then
				arg_324_1.var_.actorSpriteComps10093 = var_327_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_327_3 = 2

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_3 and not isNil(var_327_2) then
				if arg_324_1.var_.actorSpriteComps10093 then
					for iter_327_4, iter_327_5 in pairs(arg_324_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_327_5 then
							if arg_324_1.isInRecall_ then
								iter_327_5.color = Color.New(Mathf.Lerp(iter_327_5.color.r, arg_324_1.hightColor1.r, (arg_324_1.time_ - 0) / var_327_3), Mathf.Lerp(iter_327_5.color.g, arg_324_1.hightColor1.g, (arg_324_1.time_ - 0) / var_327_3), (Mathf.Lerp(iter_327_5.color.b, arg_324_1.hightColor1.b, (arg_324_1.time_ - 0) / var_327_3)))
							else
								local var_327_4 = Mathf.Lerp(iter_327_5.color.r, 1, (arg_324_1.time_ - 0) / var_327_3)

								iter_327_5.color = Color.New(var_327_4, var_327_4, var_327_4)
							end
						end
					end
				end
			end

			if arg_324_1.time_ >= 0 + var_327_3 and arg_324_1.time_ < 0 + var_327_3 + arg_327_0 and not isNil(var_327_2) and arg_324_1.var_.actorSpriteComps10093 then
				for iter_327_6, iter_327_7 in pairs(arg_324_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_327_7 then
						iter_327_7.color = arg_324_1.isInRecall_ and (arg_324_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_324_1.var_.actorSpriteComps10093 = nil
			end

			local var_327_5 = 0
			local var_327_6 = 0.675

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_5 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_7 = arg_324_1:GetWordFromCfg(413051077)
				local var_327_8 = arg_324_1:FormatText(var_327_7.content)

				arg_324_1.text_.text = var_327_8

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_10 = 27 <= 0 and var_327_6 or var_327_6 * (utf8.len(var_327_8) / 27)

				if (27 <= 0 and var_327_6 or var_327_6 * (utf8.len(var_327_8) / 27)) > 0 and var_327_6 < var_327_10 then
					arg_324_1.talkMaxDuration = var_327_10

					if var_327_10 + var_327_5 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_10 + var_327_5
					end
				end

				arg_324_1.text_.text = var_327_8
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051077", "story_v_out_413051.awb") ~= 0 then
					local var_327_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051077", "story_v_out_413051.awb") / 1000

					if var_327_11 + var_327_5 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_11 + var_327_5
					end

					if var_327_7.prefab_name ~= "" and arg_324_1.actors_[var_327_7.prefab_name] ~= nil then
						local var_327_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_7.prefab_name].transform, "story_v_out_413051", "413051077", "story_v_out_413051.awb")

						arg_324_1:RecordAudio("413051077", var_327_12)
						arg_324_1:RecordAudio("413051077", var_327_12)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_413051", "413051077", "story_v_out_413051.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_413051", "413051077", "story_v_out_413051.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_13 = math.max(var_327_6, arg_324_1.talkMaxDuration)

			if var_327_5 <= arg_324_1.time_ and arg_324_1.time_ < var_327_5 + var_327_13 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_5) / var_327_13

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_5 + var_327_13 and arg_324_1.time_ < var_327_5 + var_327_13 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play413051078 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 413051078
		arg_328_1.duration_ = 14.03

		local var_328_0 = {
			zh = 7.6,
			ja = 14.033
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
				arg_328_0:Play413051079(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(arg_328_1.actors_["10093"]) and arg_328_1.var_.actorSpriteComps10093 == nil then
				arg_328_1.var_.actorSpriteComps10093 = arg_328_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_331_0 = 2

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_0 and not isNil(arg_328_1.actors_["10093"]) then
				if arg_328_1.var_.actorSpriteComps10093 then
					for iter_331_0, iter_331_1 in pairs(arg_328_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_331_1 then
							if arg_328_1.isInRecall_ then
								iter_331_1.color = Color.New(Mathf.Lerp(iter_331_1.color.r, arg_328_1.hightColor2.r, (arg_328_1.time_ - 0) / var_331_0), Mathf.Lerp(iter_331_1.color.g, arg_328_1.hightColor2.g, (arg_328_1.time_ - 0) / var_331_0), (Mathf.Lerp(iter_331_1.color.b, arg_328_1.hightColor2.b, (arg_328_1.time_ - 0) / var_331_0)))
							else
								local var_331_1 = Mathf.Lerp(iter_331_1.color.r, 0.5, (arg_328_1.time_ - 0) / var_331_0)

								iter_331_1.color = Color.New(var_331_1, var_331_1, var_331_1)
							end
						end
					end
				end
			end

			if arg_328_1.time_ >= 0 + var_331_0 and arg_328_1.time_ < 0 + var_331_0 + arg_331_0 and not isNil(arg_328_1.actors_["10093"]) and arg_328_1.var_.actorSpriteComps10093 then
				for iter_331_2, iter_331_3 in pairs(arg_328_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_331_3 then
						iter_331_3.color = arg_328_1.isInRecall_ and (arg_328_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_328_1.var_.actorSpriteComps10093 = nil
			end

			local var_331_2 = arg_328_1.actors_["10092"]

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 and not isNil(var_331_2) and arg_328_1.var_.actorSpriteComps10092 == nil then
				arg_328_1.var_.actorSpriteComps10092 = var_331_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_331_3 = 2

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_3 and not isNil(var_331_2) then
				if arg_328_1.var_.actorSpriteComps10092 then
					for iter_331_4, iter_331_5 in pairs(arg_328_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_331_5 then
							if arg_328_1.isInRecall_ then
								iter_331_5.color = Color.New(Mathf.Lerp(iter_331_5.color.r, arg_328_1.hightColor1.r, (arg_328_1.time_ - 0) / var_331_3), Mathf.Lerp(iter_331_5.color.g, arg_328_1.hightColor1.g, (arg_328_1.time_ - 0) / var_331_3), (Mathf.Lerp(iter_331_5.color.b, arg_328_1.hightColor1.b, (arg_328_1.time_ - 0) / var_331_3)))
							else
								local var_331_4 = Mathf.Lerp(iter_331_5.color.r, 1, (arg_328_1.time_ - 0) / var_331_3)

								iter_331_5.color = Color.New(var_331_4, var_331_4, var_331_4)
							end
						end
					end
				end
			end

			if arg_328_1.time_ >= 0 + var_331_3 and arg_328_1.time_ < 0 + var_331_3 + arg_331_0 and not isNil(var_331_2) and arg_328_1.var_.actorSpriteComps10092 then
				for iter_331_6, iter_331_7 in pairs(arg_328_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_331_7 then
						iter_331_7.color = arg_328_1.isInRecall_ and (arg_328_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_328_1.var_.actorSpriteComps10092 = nil
			end

			local var_331_5 = 0
			local var_331_6 = 1.05

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_5 + arg_331_0 then
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

				local var_331_7 = arg_328_1:GetWordFromCfg(413051078)
				local var_331_8 = arg_328_1:FormatText(var_331_7.content)

				arg_328_1.text_.text = var_331_8

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_10 = 42 <= 0 and var_331_6 or var_331_6 * (utf8.len(var_331_8) / 42)

				if (42 <= 0 and var_331_6 or var_331_6 * (utf8.len(var_331_8) / 42)) > 0 and var_331_6 < var_331_10 then
					arg_328_1.talkMaxDuration = var_331_10

					if var_331_10 + var_331_5 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_10 + var_331_5
					end
				end

				arg_328_1.text_.text = var_331_8
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051078", "story_v_out_413051.awb") ~= 0 then
					local var_331_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051078", "story_v_out_413051.awb") / 1000

					if var_331_11 + var_331_5 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_11 + var_331_5
					end

					if var_331_7.prefab_name ~= "" and arg_328_1.actors_[var_331_7.prefab_name] ~= nil then
						local var_331_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_7.prefab_name].transform, "story_v_out_413051", "413051078", "story_v_out_413051.awb")

						arg_328_1:RecordAudio("413051078", var_331_12)
						arg_328_1:RecordAudio("413051078", var_331_12)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_413051", "413051078", "story_v_out_413051.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_413051", "413051078", "story_v_out_413051.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_13 = math.max(var_331_6, arg_328_1.talkMaxDuration)

			if var_331_5 <= arg_328_1.time_ and arg_328_1.time_ < var_331_5 + var_331_13 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_5) / var_331_13

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_5 + var_331_13 and arg_328_1.time_ < var_331_5 + var_331_13 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play413051079 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 413051079
		arg_332_1.duration_ = 7.33

		local var_332_0 = {
			zh = 4.066,
			ja = 7.333
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
				arg_332_0:Play413051080(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos10093 = arg_332_1.actors_["10093"].transform.localPosition
				arg_332_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_332_1:CheckSpriteTmpPos("10093", 4)

				for iter_335_0 = 0, arg_332_1.actors_["10093"].transform.childCount - 1 do
					local var_335_0 = arg_332_1.actors_["10093"].transform:GetChild(iter_335_0)

					if var_335_0.name == "split_4" or not string.find(var_335_0.name, "split") then
						var_335_0.gameObject:SetActive(true)
					else
						var_335_0.gameObject:SetActive(false)
					end
				end
			end

			local var_335_1 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_1 then
				arg_332_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_332_1.time_ - 0) / var_335_1)
			end

			if arg_332_1.time_ >= 0 + var_335_1 and arg_332_1.time_ < 0 + var_335_1 + arg_335_0 then
				arg_332_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_335_2 = arg_332_1.actors_["10092"]

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(var_335_2) and arg_332_1.var_.actorSpriteComps10092 == nil then
				arg_332_1.var_.actorSpriteComps10092 = var_335_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_335_3 = 2

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_3 and not isNil(var_335_2) then
				if arg_332_1.var_.actorSpriteComps10092 then
					for iter_335_1, iter_335_2 in pairs(arg_332_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_335_2 then
							if arg_332_1.isInRecall_ then
								iter_335_2.color = Color.New(Mathf.Lerp(iter_335_2.color.r, arg_332_1.hightColor2.r, (arg_332_1.time_ - 0) / var_335_3), Mathf.Lerp(iter_335_2.color.g, arg_332_1.hightColor2.g, (arg_332_1.time_ - 0) / var_335_3), (Mathf.Lerp(iter_335_2.color.b, arg_332_1.hightColor2.b, (arg_332_1.time_ - 0) / var_335_3)))
							else
								local var_335_4 = Mathf.Lerp(iter_335_2.color.r, 0.5, (arg_332_1.time_ - 0) / var_335_3)

								iter_335_2.color = Color.New(var_335_4, var_335_4, var_335_4)
							end
						end
					end
				end
			end

			if arg_332_1.time_ >= 0 + var_335_3 and arg_332_1.time_ < 0 + var_335_3 + arg_335_0 and not isNil(var_335_2) and arg_332_1.var_.actorSpriteComps10092 then
				for iter_335_3, iter_335_4 in pairs(arg_332_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_335_4 then
						iter_335_4.color = arg_332_1.isInRecall_ and (arg_332_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_332_1.var_.actorSpriteComps10092 = nil
			end

			local var_335_5 = arg_332_1.actors_["10093"]

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(var_335_5) and arg_332_1.var_.actorSpriteComps10093 == nil then
				arg_332_1.var_.actorSpriteComps10093 = var_335_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_335_6 = 2

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_6 and not isNil(var_335_5) then
				if arg_332_1.var_.actorSpriteComps10093 then
					for iter_335_5, iter_335_6 in pairs(arg_332_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_335_6 then
							if arg_332_1.isInRecall_ then
								iter_335_6.color = Color.New(Mathf.Lerp(iter_335_6.color.r, arg_332_1.hightColor1.r, (arg_332_1.time_ - 0) / var_335_6), Mathf.Lerp(iter_335_6.color.g, arg_332_1.hightColor1.g, (arg_332_1.time_ - 0) / var_335_6), (Mathf.Lerp(iter_335_6.color.b, arg_332_1.hightColor1.b, (arg_332_1.time_ - 0) / var_335_6)))
							else
								local var_335_7 = Mathf.Lerp(iter_335_6.color.r, 1, (arg_332_1.time_ - 0) / var_335_6)

								iter_335_6.color = Color.New(var_335_7, var_335_7, var_335_7)
							end
						end
					end
				end
			end

			if arg_332_1.time_ >= 0 + var_335_6 and arg_332_1.time_ < 0 + var_335_6 + arg_335_0 and not isNil(var_335_5) and arg_332_1.var_.actorSpriteComps10093 then
				for iter_335_7, iter_335_8 in pairs(arg_332_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_335_8 then
						iter_335_8.color = arg_332_1.isInRecall_ and (arg_332_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_332_1.var_.actorSpriteComps10093 = nil
			end

			local var_335_8 = 0
			local var_335_9 = 0.375

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_8 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_10 = arg_332_1:GetWordFromCfg(413051079)
				local var_335_11 = arg_332_1:FormatText(var_335_10.content)

				arg_332_1.text_.text = var_335_11

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_13 = 15 <= 0 and var_335_9 or var_335_9 * (utf8.len(var_335_11) / 15)

				if (15 <= 0 and var_335_9 or var_335_9 * (utf8.len(var_335_11) / 15)) > 0 and var_335_9 < var_335_13 then
					arg_332_1.talkMaxDuration = var_335_13

					if var_335_13 + var_335_8 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_13 + var_335_8
					end
				end

				arg_332_1.text_.text = var_335_11
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051079", "story_v_out_413051.awb") ~= 0 then
					local var_335_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051079", "story_v_out_413051.awb") / 1000

					if var_335_14 + var_335_8 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_14 + var_335_8
					end

					if var_335_10.prefab_name ~= "" and arg_332_1.actors_[var_335_10.prefab_name] ~= nil then
						local var_335_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_10.prefab_name].transform, "story_v_out_413051", "413051079", "story_v_out_413051.awb")

						arg_332_1:RecordAudio("413051079", var_335_15)
						arg_332_1:RecordAudio("413051079", var_335_15)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_413051", "413051079", "story_v_out_413051.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_413051", "413051079", "story_v_out_413051.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_16 = math.max(var_335_9, arg_332_1.talkMaxDuration)

			if var_335_8 <= arg_332_1.time_ and arg_332_1.time_ < var_335_8 + var_335_16 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_8) / var_335_16

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_8 + var_335_16 and arg_332_1.time_ < var_335_8 + var_335_16 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
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

		arg_332_1:InitPlayNodeList()
	end,
	Play413051080 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 413051080
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play413051081(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos10092 = arg_336_1.actors_["10092"].transform.localPosition
				arg_336_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_336_1:CheckSpriteTmpPos("10092", 0)

				for iter_339_0 = 0, arg_336_1.actors_["10092"].transform.childCount - 1 do
					local var_339_0 = arg_336_1.actors_["10092"].transform:GetChild(iter_339_0)

					if var_339_0.name == "" or not string.find(var_339_0.name, "split") then
						var_339_0.gameObject:SetActive(true)
					else
						var_339_0.gameObject:SetActive(false)
					end
				end
			end

			local var_339_1 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_1 then
				arg_336_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_336_1.time_ - 0) / var_339_1)
			end

			if arg_336_1.time_ >= 0 + var_339_1 and arg_336_1.time_ < 0 + var_339_1 + arg_339_0 then
				arg_336_1.actors_["10092"].transform.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_339_2 = arg_336_1.actors_["10093"].transform

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos10093 = var_339_2.localPosition
				var_339_2.localScale = Vector3.New(1, 1, 1)

				arg_336_1:CheckSpriteTmpPos("10093", 0)

				for iter_339_1 = 0, var_339_2.childCount - 1 do
					local var_339_3 = var_339_2:GetChild(iter_339_1)

					if var_339_3.name == "" or not string.find(var_339_3.name, "split") then
						var_339_3.gameObject:SetActive(true)
					else
						var_339_3.gameObject:SetActive(false)
					end
				end
			end

			local var_339_4 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_4 then
				var_339_2.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos10093, Vector3.New(-5000, -345, -245), (arg_336_1.time_ - 0) / var_339_4)
			end

			if arg_336_1.time_ >= 0 + var_339_4 and arg_336_1.time_ < 0 + var_339_4 + arg_339_0 then
				var_339_2.localPosition = Vector3.New(-5000, -345, -245)
			end

			local var_339_5 = arg_336_1.actors_["10092"]

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(var_339_5) and arg_336_1.var_.actorSpriteComps10092 == nil then
				arg_336_1.var_.actorSpriteComps10092 = var_339_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_339_6 = 2

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_6 and not isNil(var_339_5) then
				if arg_336_1.var_.actorSpriteComps10092 then
					for iter_339_2, iter_339_3 in pairs(arg_336_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_339_3 then
							if arg_336_1.isInRecall_ then
								iter_339_3.color = Color.New(Mathf.Lerp(iter_339_3.color.r, arg_336_1.hightColor2.r, (arg_336_1.time_ - 0) / var_339_6), Mathf.Lerp(iter_339_3.color.g, arg_336_1.hightColor2.g, (arg_336_1.time_ - 0) / var_339_6), (Mathf.Lerp(iter_339_3.color.b, arg_336_1.hightColor2.b, (arg_336_1.time_ - 0) / var_339_6)))
							else
								local var_339_7 = Mathf.Lerp(iter_339_3.color.r, 0.5, (arg_336_1.time_ - 0) / var_339_6)

								iter_339_3.color = Color.New(var_339_7, var_339_7, var_339_7)
							end
						end
					end
				end
			end

			if arg_336_1.time_ >= 0 + var_339_6 and arg_336_1.time_ < 0 + var_339_6 + arg_339_0 and not isNil(var_339_5) and arg_336_1.var_.actorSpriteComps10092 then
				for iter_339_4, iter_339_5 in pairs(arg_336_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_339_5 then
						iter_339_5.color = arg_336_1.isInRecall_ and (arg_336_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_336_1.var_.actorSpriteComps10092 = nil
			end

			local var_339_8 = arg_336_1.actors_["10093"]

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(var_339_8) and arg_336_1.var_.actorSpriteComps10093 == nil then
				arg_336_1.var_.actorSpriteComps10093 = var_339_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_339_9 = 2

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_9 and not isNil(var_339_8) then
				if arg_336_1.var_.actorSpriteComps10093 then
					for iter_339_6, iter_339_7 in pairs(arg_336_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_339_7 then
							if arg_336_1.isInRecall_ then
								iter_339_7.color = Color.New(Mathf.Lerp(iter_339_7.color.r, arg_336_1.hightColor2.r, (arg_336_1.time_ - 0) / var_339_9), Mathf.Lerp(iter_339_7.color.g, arg_336_1.hightColor2.g, (arg_336_1.time_ - 0) / var_339_9), (Mathf.Lerp(iter_339_7.color.b, arg_336_1.hightColor2.b, (arg_336_1.time_ - 0) / var_339_9)))
							else
								local var_339_10 = Mathf.Lerp(iter_339_7.color.r, 0.5, (arg_336_1.time_ - 0) / var_339_9)

								iter_339_7.color = Color.New(var_339_10, var_339_10, var_339_10)
							end
						end
					end
				end
			end

			if arg_336_1.time_ >= 0 + var_339_9 and arg_336_1.time_ < 0 + var_339_9 + arg_339_0 and not isNil(var_339_8) and arg_336_1.var_.actorSpriteComps10093 then
				for iter_339_8, iter_339_9 in pairs(arg_336_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_339_9 then
						iter_339_9.color = arg_336_1.isInRecall_ and (arg_336_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_336_1.var_.actorSpriteComps10093 = nil
			end

			local var_339_11 = 0
			local var_339_12 = 1.025

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_11 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, false)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_13 = arg_336_1:FormatText(arg_336_1:GetWordFromCfg(413051080).content)

				arg_336_1.text_.text = var_339_13

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_15 = 41 <= 0 and var_339_12 or var_339_12 * (utf8.len(var_339_13) / 41)

				if (41 <= 0 and var_339_12 or var_339_12 * (utf8.len(var_339_13) / 41)) > 0 and var_339_12 < var_339_15 then
					arg_336_1.talkMaxDuration = var_339_15

					if var_339_15 + var_339_11 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_15 + var_339_11
					end
				end

				arg_336_1.text_.text = var_339_13
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_16 = math.max(var_339_12, arg_336_1.talkMaxDuration)

			if var_339_11 <= arg_336_1.time_ and arg_336_1.time_ < var_339_11 + var_339_16 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_11) / var_339_16

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_11 + var_339_16 and arg_336_1.time_ < var_339_11 + var_339_16 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
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

		arg_336_1:InitPlayNodeList()
	end,
	Play413051081 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 413051081
		arg_340_1.duration_ = 9.37

		local var_340_0 = {
			zh = 6.466,
			ja = 9.366
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
				arg_340_0:Play413051082(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.var_.moveOldPos10094 = arg_340_1.actors_["10094"].transform.localPosition
				arg_340_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_340_1:CheckSpriteTmpPos("10094", 4)

				for iter_343_0 = 0, arg_340_1.actors_["10094"].transform.childCount - 1 do
					local var_343_0 = arg_340_1.actors_["10094"].transform:GetChild(iter_343_0)

					if var_343_0.name == "" or not string.find(var_343_0.name, "split") then
						var_343_0.gameObject:SetActive(true)
					else
						var_343_0.gameObject:SetActive(false)
					end
				end
			end

			local var_343_1 = 0.001

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_1 then
				arg_340_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_340_1.time_ - 0) / var_343_1)
			end

			if arg_340_1.time_ >= 0 + var_343_1 and arg_340_1.time_ < 0 + var_343_1 + arg_343_0 then
				arg_340_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_343_2 = arg_340_1.actors_["10094"]

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(var_343_2) and arg_340_1.var_.actorSpriteComps10094 == nil then
				arg_340_1.var_.actorSpriteComps10094 = var_343_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_343_3 = 2

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_3 and not isNil(var_343_2) then
				if arg_340_1.var_.actorSpriteComps10094 then
					for iter_343_1, iter_343_2 in pairs(arg_340_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_343_2 then
							if arg_340_1.isInRecall_ then
								iter_343_2.color = Color.New(Mathf.Lerp(iter_343_2.color.r, arg_340_1.hightColor1.r, (arg_340_1.time_ - 0) / var_343_3), Mathf.Lerp(iter_343_2.color.g, arg_340_1.hightColor1.g, (arg_340_1.time_ - 0) / var_343_3), (Mathf.Lerp(iter_343_2.color.b, arg_340_1.hightColor1.b, (arg_340_1.time_ - 0) / var_343_3)))
							else
								local var_343_4 = Mathf.Lerp(iter_343_2.color.r, 1, (arg_340_1.time_ - 0) / var_343_3)

								iter_343_2.color = Color.New(var_343_4, var_343_4, var_343_4)
							end
						end
					end
				end
			end

			if arg_340_1.time_ >= 0 + var_343_3 and arg_340_1.time_ < 0 + var_343_3 + arg_343_0 and not isNil(var_343_2) and arg_340_1.var_.actorSpriteComps10094 then
				for iter_343_3, iter_343_4 in pairs(arg_340_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_343_4 then
						iter_343_4.color = arg_340_1.isInRecall_ and (arg_340_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_340_1.var_.actorSpriteComps10094 = nil
			end

			local var_343_5 = 0
			local var_343_6 = 0.575

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_5 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_7 = arg_340_1:GetWordFromCfg(413051081)
				local var_343_8 = arg_340_1:FormatText(var_343_7.content)

				arg_340_1.text_.text = var_343_8

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_10 = 23 <= 0 and var_343_6 or var_343_6 * (utf8.len(var_343_8) / 23)

				if (23 <= 0 and var_343_6 or var_343_6 * (utf8.len(var_343_8) / 23)) > 0 and var_343_6 < var_343_10 then
					arg_340_1.talkMaxDuration = var_343_10

					if var_343_10 + var_343_5 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_10 + var_343_5
					end
				end

				arg_340_1.text_.text = var_343_8
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051081", "story_v_out_413051.awb") ~= 0 then
					local var_343_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051081", "story_v_out_413051.awb") / 1000

					if var_343_11 + var_343_5 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_11 + var_343_5
					end

					if var_343_7.prefab_name ~= "" and arg_340_1.actors_[var_343_7.prefab_name] ~= nil then
						local var_343_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_7.prefab_name].transform, "story_v_out_413051", "413051081", "story_v_out_413051.awb")

						arg_340_1:RecordAudio("413051081", var_343_12)
						arg_340_1:RecordAudio("413051081", var_343_12)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_413051", "413051081", "story_v_out_413051.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_413051", "413051081", "story_v_out_413051.awb")
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

		arg_340_1.nodeConfigList_ = {
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

		arg_340_1:InitPlayNodeList()
	end,
	Play413051082 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 413051082
		arg_344_1.duration_ = 4.93

		local var_344_0 = {
			zh = 3.866,
			ja = 4.933
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
				arg_344_0:Play413051083(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.var_.moveOldPos10094 = arg_344_1.actors_["10094"].transform.localPosition
				arg_344_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_344_1:CheckSpriteTmpPos("10094", 4)

				for iter_347_0 = 0, arg_344_1.actors_["10094"].transform.childCount - 1 do
					local var_347_0 = arg_344_1.actors_["10094"].transform:GetChild(iter_347_0)

					if var_347_0.name == "" or not string.find(var_347_0.name, "split") then
						var_347_0.gameObject:SetActive(true)
					else
						var_347_0.gameObject:SetActive(false)
					end
				end
			end

			local var_347_1 = 0.001

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_1 then
				arg_344_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos10094, Vector3.New(390, -340, -414), (arg_344_1.time_ - 0) / var_347_1)
			end

			if arg_344_1.time_ >= 0 + var_347_1 and arg_344_1.time_ < 0 + var_347_1 + arg_347_0 then
				arg_344_1.actors_["10094"].transform.localPosition = Vector3.New(390, -340, -414)
			end

			local var_347_2 = arg_344_1.actors_["10022"].transform

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.var_.moveOldPos10022 = var_347_2.localPosition
				var_347_2.localScale = Vector3.New(1, 1, 1)

				arg_344_1:CheckSpriteTmpPos("10022", 2)

				for iter_347_1 = 0, var_347_2.childCount - 1 do
					local var_347_3 = var_347_2:GetChild(iter_347_1)

					if var_347_3.name == "" or not string.find(var_347_3.name, "split") then
						var_347_3.gameObject:SetActive(true)
					else
						var_347_3.gameObject:SetActive(false)
					end
				end
			end

			local var_347_4 = 0.001

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_4 then
				var_347_2.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_344_1.time_ - 0) / var_347_4)
			end

			if arg_344_1.time_ >= 0 + var_347_4 and arg_344_1.time_ < 0 + var_347_4 + arg_347_0 then
				var_347_2.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_347_5 = arg_344_1.actors_["10094"]

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(var_347_5) and arg_344_1.var_.actorSpriteComps10094 == nil then
				arg_344_1.var_.actorSpriteComps10094 = var_347_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_347_6 = 2

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_6 and not isNil(var_347_5) then
				if arg_344_1.var_.actorSpriteComps10094 then
					for iter_347_2, iter_347_3 in pairs(arg_344_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_347_3 then
							if arg_344_1.isInRecall_ then
								iter_347_3.color = Color.New(Mathf.Lerp(iter_347_3.color.r, arg_344_1.hightColor2.r, (arg_344_1.time_ - 0) / var_347_6), Mathf.Lerp(iter_347_3.color.g, arg_344_1.hightColor2.g, (arg_344_1.time_ - 0) / var_347_6), (Mathf.Lerp(iter_347_3.color.b, arg_344_1.hightColor2.b, (arg_344_1.time_ - 0) / var_347_6)))
							else
								local var_347_7 = Mathf.Lerp(iter_347_3.color.r, 0.5, (arg_344_1.time_ - 0) / var_347_6)

								iter_347_3.color = Color.New(var_347_7, var_347_7, var_347_7)
							end
						end
					end
				end
			end

			if arg_344_1.time_ >= 0 + var_347_6 and arg_344_1.time_ < 0 + var_347_6 + arg_347_0 and not isNil(var_347_5) and arg_344_1.var_.actorSpriteComps10094 then
				for iter_347_4, iter_347_5 in pairs(arg_344_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_347_5 then
						iter_347_5.color = arg_344_1.isInRecall_ and (arg_344_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_344_1.var_.actorSpriteComps10094 = nil
			end

			local var_347_8 = arg_344_1.actors_["10022"]

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(var_347_8) and arg_344_1.var_.actorSpriteComps10022 == nil then
				arg_344_1.var_.actorSpriteComps10022 = var_347_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_347_9 = 2

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_9 and not isNil(var_347_8) then
				if arg_344_1.var_.actorSpriteComps10022 then
					for iter_347_6, iter_347_7 in pairs(arg_344_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_347_7 then
							if arg_344_1.isInRecall_ then
								iter_347_7.color = Color.New(Mathf.Lerp(iter_347_7.color.r, arg_344_1.hightColor1.r, (arg_344_1.time_ - 0) / var_347_9), Mathf.Lerp(iter_347_7.color.g, arg_344_1.hightColor1.g, (arg_344_1.time_ - 0) / var_347_9), (Mathf.Lerp(iter_347_7.color.b, arg_344_1.hightColor1.b, (arg_344_1.time_ - 0) / var_347_9)))
							else
								local var_347_10 = Mathf.Lerp(iter_347_7.color.r, 1, (arg_344_1.time_ - 0) / var_347_9)

								iter_347_7.color = Color.New(var_347_10, var_347_10, var_347_10)
							end
						end
					end
				end
			end

			if arg_344_1.time_ >= 0 + var_347_9 and arg_344_1.time_ < 0 + var_347_9 + arg_347_0 and not isNil(var_347_8) and arg_344_1.var_.actorSpriteComps10022 then
				for iter_347_8, iter_347_9 in pairs(arg_344_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_347_9 then
						iter_347_9.color = arg_344_1.isInRecall_ and (arg_344_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_344_1.var_.actorSpriteComps10022 = nil
			end

			local var_347_11 = 0
			local var_347_12 = 0.425

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_11 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_13 = arg_344_1:GetWordFromCfg(413051082)
				local var_347_14 = arg_344_1:FormatText(var_347_13.content)

				arg_344_1.text_.text = var_347_14

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_16 = 17 <= 0 and var_347_12 or var_347_12 * (utf8.len(var_347_14) / 17)

				if (17 <= 0 and var_347_12 or var_347_12 * (utf8.len(var_347_14) / 17)) > 0 and var_347_12 < var_347_16 then
					arg_344_1.talkMaxDuration = var_347_16

					if var_347_16 + var_347_11 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_16 + var_347_11
					end
				end

				arg_344_1.text_.text = var_347_14
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051082", "story_v_out_413051.awb") ~= 0 then
					local var_347_17 = manager.audio:GetVoiceLength("story_v_out_413051", "413051082", "story_v_out_413051.awb") / 1000

					if var_347_17 + var_347_11 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_17 + var_347_11
					end

					if var_347_13.prefab_name ~= "" and arg_344_1.actors_[var_347_13.prefab_name] ~= nil then
						local var_347_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_13.prefab_name].transform, "story_v_out_413051", "413051082", "story_v_out_413051.awb")

						arg_344_1:RecordAudio("413051082", var_347_18)
						arg_344_1:RecordAudio("413051082", var_347_18)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_413051", "413051082", "story_v_out_413051.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_413051", "413051082", "story_v_out_413051.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_19 = math.max(var_347_12, arg_344_1.talkMaxDuration)

			if var_347_11 <= arg_344_1.time_ and arg_344_1.time_ < var_347_11 + var_347_19 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_11) / var_347_19

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_11 + var_347_19 and arg_344_1.time_ < var_347_11 + var_347_19 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
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

		arg_344_1:InitPlayNodeList()
	end,
	Play413051083 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 413051083
		arg_348_1.duration_ = 7.27

		local var_348_0 = {
			zh = 5.166,
			ja = 7.266
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
				arg_348_0:Play413051084(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(arg_348_1.actors_["10094"]) and arg_348_1.var_.actorSpriteComps10094 == nil then
				arg_348_1.var_.actorSpriteComps10094 = arg_348_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_351_0 = 2

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_0 and not isNil(arg_348_1.actors_["10094"]) then
				if arg_348_1.var_.actorSpriteComps10094 then
					for iter_351_0, iter_351_1 in pairs(arg_348_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_351_1 then
							if arg_348_1.isInRecall_ then
								iter_351_1.color = Color.New(Mathf.Lerp(iter_351_1.color.r, arg_348_1.hightColor1.r, (arg_348_1.time_ - 0) / var_351_0), Mathf.Lerp(iter_351_1.color.g, arg_348_1.hightColor1.g, (arg_348_1.time_ - 0) / var_351_0), (Mathf.Lerp(iter_351_1.color.b, arg_348_1.hightColor1.b, (arg_348_1.time_ - 0) / var_351_0)))
							else
								local var_351_1 = Mathf.Lerp(iter_351_1.color.r, 1, (arg_348_1.time_ - 0) / var_351_0)

								iter_351_1.color = Color.New(var_351_1, var_351_1, var_351_1)
							end
						end
					end
				end
			end

			if arg_348_1.time_ >= 0 + var_351_0 and arg_348_1.time_ < 0 + var_351_0 + arg_351_0 and not isNil(arg_348_1.actors_["10094"]) and arg_348_1.var_.actorSpriteComps10094 then
				for iter_351_2, iter_351_3 in pairs(arg_348_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_351_3 then
						iter_351_3.color = arg_348_1.isInRecall_ and (arg_348_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_348_1.var_.actorSpriteComps10094 = nil
			end

			local var_351_2 = arg_348_1.actors_["10022"]

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 and not isNil(var_351_2) and arg_348_1.var_.actorSpriteComps10022 == nil then
				arg_348_1.var_.actorSpriteComps10022 = var_351_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_351_3 = 2

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_3 and not isNil(var_351_2) then
				if arg_348_1.var_.actorSpriteComps10022 then
					for iter_351_4, iter_351_5 in pairs(arg_348_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_351_5 then
							if arg_348_1.isInRecall_ then
								iter_351_5.color = Color.New(Mathf.Lerp(iter_351_5.color.r, arg_348_1.hightColor2.r, (arg_348_1.time_ - 0) / var_351_3), Mathf.Lerp(iter_351_5.color.g, arg_348_1.hightColor2.g, (arg_348_1.time_ - 0) / var_351_3), (Mathf.Lerp(iter_351_5.color.b, arg_348_1.hightColor2.b, (arg_348_1.time_ - 0) / var_351_3)))
							else
								local var_351_4 = Mathf.Lerp(iter_351_5.color.r, 0.5, (arg_348_1.time_ - 0) / var_351_3)

								iter_351_5.color = Color.New(var_351_4, var_351_4, var_351_4)
							end
						end
					end
				end
			end

			if arg_348_1.time_ >= 0 + var_351_3 and arg_348_1.time_ < 0 + var_351_3 + arg_351_0 and not isNil(var_351_2) and arg_348_1.var_.actorSpriteComps10022 then
				for iter_351_6, iter_351_7 in pairs(arg_348_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_351_7 then
						iter_351_7.color = arg_348_1.isInRecall_ and (arg_348_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_348_1.var_.actorSpriteComps10022 = nil
			end

			local var_351_5 = 0
			local var_351_6 = 0.5

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_5 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_7 = arg_348_1:GetWordFromCfg(413051083)
				local var_351_8 = arg_348_1:FormatText(var_351_7.content)

				arg_348_1.text_.text = var_351_8

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_10 = 20 <= 0 and var_351_6 or var_351_6 * (utf8.len(var_351_8) / 20)

				if (20 <= 0 and var_351_6 or var_351_6 * (utf8.len(var_351_8) / 20)) > 0 and var_351_6 < var_351_10 then
					arg_348_1.talkMaxDuration = var_351_10

					if var_351_10 + var_351_5 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_10 + var_351_5
					end
				end

				arg_348_1.text_.text = var_351_8
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051083", "story_v_out_413051.awb") ~= 0 then
					local var_351_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051083", "story_v_out_413051.awb") / 1000

					if var_351_11 + var_351_5 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_11 + var_351_5
					end

					if var_351_7.prefab_name ~= "" and arg_348_1.actors_[var_351_7.prefab_name] ~= nil then
						local var_351_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_7.prefab_name].transform, "story_v_out_413051", "413051083", "story_v_out_413051.awb")

						arg_348_1:RecordAudio("413051083", var_351_12)
						arg_348_1:RecordAudio("413051083", var_351_12)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_413051", "413051083", "story_v_out_413051.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_413051", "413051083", "story_v_out_413051.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_13 = math.max(var_351_6, arg_348_1.talkMaxDuration)

			if var_351_5 <= arg_348_1.time_ and arg_348_1.time_ < var_351_5 + var_351_13 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_5) / var_351_13

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_5 + var_351_13 and arg_348_1.time_ < var_351_5 + var_351_13 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play413051084 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 413051084
		arg_352_1.duration_ = 10.1

		local var_352_0 = {
			zh = 6.433,
			ja = 10.1
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
				arg_352_0:Play413051085(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0.65

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_1 = arg_352_1:GetWordFromCfg(413051084)
				local var_355_2 = arg_352_1:FormatText(var_355_1.content)

				arg_352_1.text_.text = var_355_2

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_4 = 26 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_2) / 26)

				if (26 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_2) / 26)) > 0 and var_355_0 < var_355_4 then
					arg_352_1.talkMaxDuration = var_355_4

					if var_355_4 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_4 + 0
					end
				end

				arg_352_1.text_.text = var_355_2
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051084", "story_v_out_413051.awb") ~= 0 then
					local var_355_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051084", "story_v_out_413051.awb") / 1000

					if var_355_5 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_5 + 0
					end

					if var_355_1.prefab_name ~= "" and arg_352_1.actors_[var_355_1.prefab_name] ~= nil then
						local var_355_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_1.prefab_name].transform, "story_v_out_413051", "413051084", "story_v_out_413051.awb")

						arg_352_1:RecordAudio("413051084", var_355_6)
						arg_352_1:RecordAudio("413051084", var_355_6)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_413051", "413051084", "story_v_out_413051.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_413051", "413051084", "story_v_out_413051.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_7 = math.max(var_355_0, arg_352_1.talkMaxDuration)

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_7 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - 0) / var_355_7

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= 0 + var_355_7 and arg_352_1.time_ < 0 + var_355_7 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play413051085 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 413051085
		arg_356_1.duration_ = 2

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play413051086(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.var_.moveOldPos10022 = arg_356_1.actors_["10022"].transform.localPosition
				arg_356_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_356_1:CheckSpriteTmpPos("10022", 2)

				for iter_359_0 = 0, arg_356_1.actors_["10022"].transform.childCount - 1 do
					local var_359_0 = arg_356_1.actors_["10022"].transform:GetChild(iter_359_0)

					if var_359_0.name == "split_3" or not string.find(var_359_0.name, "split") then
						var_359_0.gameObject:SetActive(true)
					else
						var_359_0.gameObject:SetActive(false)
					end
				end
			end

			local var_359_1 = 0.001

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_1 then
				arg_356_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPos10022, Vector3.New(-390, -315, -320), (arg_356_1.time_ - 0) / var_359_1)
			end

			if arg_356_1.time_ >= 0 + var_359_1 and arg_356_1.time_ < 0 + var_359_1 + arg_359_0 then
				arg_356_1.actors_["10022"].transform.localPosition = Vector3.New(-390, -315, -320)
			end

			local var_359_2 = arg_356_1.actors_["10094"]

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(var_359_2) and arg_356_1.var_.actorSpriteComps10094 == nil then
				arg_356_1.var_.actorSpriteComps10094 = var_359_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_359_3 = 2

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_3 and not isNil(var_359_2) then
				if arg_356_1.var_.actorSpriteComps10094 then
					for iter_359_1, iter_359_2 in pairs(arg_356_1.var_.actorSpriteComps10094:ToTable()) do
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

			if arg_356_1.time_ >= 0 + var_359_3 and arg_356_1.time_ < 0 + var_359_3 + arg_359_0 and not isNil(var_359_2) and arg_356_1.var_.actorSpriteComps10094 then
				for iter_359_3, iter_359_4 in pairs(arg_356_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_359_4 then
						iter_359_4.color = arg_356_1.isInRecall_ and (arg_356_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_356_1.var_.actorSpriteComps10094 = nil
			end

			local var_359_5 = arg_356_1.actors_["10022"]

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 and not isNil(var_359_5) and arg_356_1.var_.actorSpriteComps10022 == nil then
				arg_356_1.var_.actorSpriteComps10022 = var_359_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_359_6 = 2

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_6 and not isNil(var_359_5) then
				if arg_356_1.var_.actorSpriteComps10022 then
					for iter_359_5, iter_359_6 in pairs(arg_356_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_356_1.time_ >= 0 + var_359_6 and arg_356_1.time_ < 0 + var_359_6 + arg_359_0 and not isNil(var_359_5) and arg_356_1.var_.actorSpriteComps10022 then
				for iter_359_7, iter_359_8 in pairs(arg_356_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_359_8 then
						iter_359_8.color = arg_356_1.isInRecall_ and (arg_356_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_356_1.var_.actorSpriteComps10022 = nil
			end

			local var_359_8 = 0
			local var_359_9 = 0.05

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_8 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				arg_356_1.leftNameTxt_.text = arg_356_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_10 = arg_356_1:GetWordFromCfg(413051085)
				local var_359_11 = arg_356_1:FormatText(var_359_10.content)

				arg_356_1.text_.text = var_359_11

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_13 = 2 <= 0 and var_359_9 or var_359_9 * (utf8.len(var_359_11) / 2)

				if (2 <= 0 and var_359_9 or var_359_9 * (utf8.len(var_359_11) / 2)) > 0 and var_359_9 < var_359_13 then
					arg_356_1.talkMaxDuration = var_359_13

					if var_359_13 + var_359_8 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_13 + var_359_8
					end
				end

				arg_356_1.text_.text = var_359_11
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051085", "story_v_out_413051.awb") ~= 0 then
					local var_359_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051085", "story_v_out_413051.awb") / 1000

					if var_359_14 + var_359_8 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_14 + var_359_8
					end

					if var_359_10.prefab_name ~= "" and arg_356_1.actors_[var_359_10.prefab_name] ~= nil then
						local var_359_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_10.prefab_name].transform, "story_v_out_413051", "413051085", "story_v_out_413051.awb")

						arg_356_1:RecordAudio("413051085", var_359_15)
						arg_356_1:RecordAudio("413051085", var_359_15)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_413051", "413051085", "story_v_out_413051.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_413051", "413051085", "story_v_out_413051.awb")
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
				actorName = "10022",
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
	Play413051086 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 413051086
		arg_360_1.duration_ = 5.53

		local var_360_0 = {
			zh = 3.366,
			ja = 5.533
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
				arg_360_0:Play413051087(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.var_.moveOldPos10094 = arg_360_1.actors_["10094"].transform.localPosition
				arg_360_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_360_1:CheckSpriteTmpPos("10094", 7)

				for iter_363_0 = 0, arg_360_1.actors_["10094"].transform.childCount - 1 do
					local var_363_0 = arg_360_1.actors_["10094"].transform:GetChild(iter_363_0)

					if var_363_0.name == "" or not string.find(var_363_0.name, "split") then
						var_363_0.gameObject:SetActive(true)
					else
						var_363_0.gameObject:SetActive(false)
					end
				end
			end

			local var_363_1 = 0.001

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_1 then
				arg_360_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_360_1.time_ - 0) / var_363_1)
			end

			if arg_360_1.time_ >= 0 + var_363_1 and arg_360_1.time_ < 0 + var_363_1 + arg_363_0 then
				arg_360_1.actors_["10094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_363_2 = arg_360_1.actors_["10022"].transform

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.var_.moveOldPos10022 = var_363_2.localPosition
				var_363_2.localScale = Vector3.New(1, 1, 1)

				arg_360_1:CheckSpriteTmpPos("10022", 7)

				for iter_363_1 = 0, var_363_2.childCount - 1 do
					local var_363_3 = var_363_2:GetChild(iter_363_1)

					if var_363_3.name == "" or not string.find(var_363_3.name, "split") then
						var_363_3.gameObject:SetActive(true)
					else
						var_363_3.gameObject:SetActive(false)
					end
				end
			end

			local var_363_4 = 0.001

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_4 then
				var_363_2.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_360_1.time_ - 0) / var_363_4)
			end

			if arg_360_1.time_ >= 0 + var_363_4 and arg_360_1.time_ < 0 + var_363_4 + arg_363_0 then
				var_363_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_363_5 = arg_360_1.actors_["10092"].transform

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.var_.moveOldPos10092 = var_363_5.localPosition
				var_363_5.localScale = Vector3.New(1, 1, 1)

				arg_360_1:CheckSpriteTmpPos("10092", 3)

				for iter_363_2 = 0, var_363_5.childCount - 1 do
					local var_363_6 = var_363_5:GetChild(iter_363_2)

					if var_363_6.name == "" or not string.find(var_363_6.name, "split") then
						var_363_6.gameObject:SetActive(true)
					else
						var_363_6.gameObject:SetActive(false)
					end
				end
			end

			local var_363_7 = 0.001

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_7 then
				var_363_5.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_360_1.time_ - 0) / var_363_7)
			end

			if arg_360_1.time_ >= 0 + var_363_7 and arg_360_1.time_ < 0 + var_363_7 + arg_363_0 then
				var_363_5.localPosition = Vector3.New(0, -300, -295)
			end

			local var_363_8 = arg_360_1.actors_["10092"]

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(var_363_8) and arg_360_1.var_.actorSpriteComps10092 == nil then
				arg_360_1.var_.actorSpriteComps10092 = var_363_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_363_9 = 2

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_9 and not isNil(var_363_8) then
				if arg_360_1.var_.actorSpriteComps10092 then
					for iter_363_3, iter_363_4 in pairs(arg_360_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_363_4 then
							if arg_360_1.isInRecall_ then
								iter_363_4.color = Color.New(Mathf.Lerp(iter_363_4.color.r, arg_360_1.hightColor1.r, (arg_360_1.time_ - 0) / var_363_9), Mathf.Lerp(iter_363_4.color.g, arg_360_1.hightColor1.g, (arg_360_1.time_ - 0) / var_363_9), (Mathf.Lerp(iter_363_4.color.b, arg_360_1.hightColor1.b, (arg_360_1.time_ - 0) / var_363_9)))
							else
								local var_363_10 = Mathf.Lerp(iter_363_4.color.r, 1, (arg_360_1.time_ - 0) / var_363_9)

								iter_363_4.color = Color.New(var_363_10, var_363_10, var_363_10)
							end
						end
					end
				end
			end

			if arg_360_1.time_ >= 0 + var_363_9 and arg_360_1.time_ < 0 + var_363_9 + arg_363_0 and not isNil(var_363_8) and arg_360_1.var_.actorSpriteComps10092 then
				for iter_363_5, iter_363_6 in pairs(arg_360_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_363_6 then
						iter_363_6.color = arg_360_1.isInRecall_ and (arg_360_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_360_1.var_.actorSpriteComps10092 = nil
			end

			local var_363_11 = arg_360_1.actors_["10022"]

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(var_363_11) and arg_360_1.var_.actorSpriteComps10022 == nil then
				arg_360_1.var_.actorSpriteComps10022 = var_363_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_363_12 = 2

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_12 and not isNil(var_363_11) then
				if arg_360_1.var_.actorSpriteComps10022 then
					for iter_363_7, iter_363_8 in pairs(arg_360_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_363_8 then
							if arg_360_1.isInRecall_ then
								iter_363_8.color = Color.New(Mathf.Lerp(iter_363_8.color.r, arg_360_1.hightColor2.r, (arg_360_1.time_ - 0) / var_363_12), Mathf.Lerp(iter_363_8.color.g, arg_360_1.hightColor2.g, (arg_360_1.time_ - 0) / var_363_12), (Mathf.Lerp(iter_363_8.color.b, arg_360_1.hightColor2.b, (arg_360_1.time_ - 0) / var_363_12)))
							else
								local var_363_13 = Mathf.Lerp(iter_363_8.color.r, 0.5, (arg_360_1.time_ - 0) / var_363_12)

								iter_363_8.color = Color.New(var_363_13, var_363_13, var_363_13)
							end
						end
					end
				end
			end

			if arg_360_1.time_ >= 0 + var_363_12 and arg_360_1.time_ < 0 + var_363_12 + arg_363_0 and not isNil(var_363_11) and arg_360_1.var_.actorSpriteComps10022 then
				for iter_363_9, iter_363_10 in pairs(arg_360_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_363_10 then
						iter_363_10.color = arg_360_1.isInRecall_ and (arg_360_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_360_1.var_.actorSpriteComps10022 = nil
			end

			local var_363_14 = arg_360_1.actors_["10092"]

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 and not isNil(var_363_14) and arg_360_1.var_.actorSpriteComps10092 == nil then
				arg_360_1.var_.actorSpriteComps10092 = var_363_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_363_15 = 2

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_15 and not isNil(var_363_14) then
				if arg_360_1.var_.actorSpriteComps10092 then
					for iter_363_11, iter_363_12 in pairs(arg_360_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_363_12 then
							if arg_360_1.isInRecall_ then
								iter_363_12.color = Color.New(Mathf.Lerp(iter_363_12.color.r, arg_360_1.hightColor1.r, (arg_360_1.time_ - 0) / var_363_15), Mathf.Lerp(iter_363_12.color.g, arg_360_1.hightColor1.g, (arg_360_1.time_ - 0) / var_363_15), (Mathf.Lerp(iter_363_12.color.b, arg_360_1.hightColor1.b, (arg_360_1.time_ - 0) / var_363_15)))
							else
								local var_363_16 = Mathf.Lerp(iter_363_12.color.r, 1, (arg_360_1.time_ - 0) / var_363_15)

								iter_363_12.color = Color.New(var_363_16, var_363_16, var_363_16)
							end
						end
					end
				end
			end

			if arg_360_1.time_ >= 0 + var_363_15 and arg_360_1.time_ < 0 + var_363_15 + arg_363_0 and not isNil(var_363_14) and arg_360_1.var_.actorSpriteComps10092 then
				for iter_363_13, iter_363_14 in pairs(arg_360_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_363_14 then
						iter_363_14.color = arg_360_1.isInRecall_ and (arg_360_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_360_1.var_.actorSpriteComps10092 = nil
			end

			local var_363_17 = 0
			local var_363_18 = 0.45

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_17 + arg_363_0 then
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

				local var_363_19 = arg_360_1:GetWordFromCfg(413051086)
				local var_363_20 = arg_360_1:FormatText(var_363_19.content)

				arg_360_1.text_.text = var_363_20

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_22 = 18 <= 0 and var_363_18 or var_363_18 * (utf8.len(var_363_20) / 18)

				if (18 <= 0 and var_363_18 or var_363_18 * (utf8.len(var_363_20) / 18)) > 0 and var_363_18 < var_363_22 then
					arg_360_1.talkMaxDuration = var_363_22

					if var_363_22 + var_363_17 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_22 + var_363_17
					end
				end

				arg_360_1.text_.text = var_363_20
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051086", "story_v_out_413051.awb") ~= 0 then
					local var_363_23 = manager.audio:GetVoiceLength("story_v_out_413051", "413051086", "story_v_out_413051.awb") / 1000

					if var_363_23 + var_363_17 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_23 + var_363_17
					end

					if var_363_19.prefab_name ~= "" and arg_360_1.actors_[var_363_19.prefab_name] ~= nil then
						local var_363_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_19.prefab_name].transform, "story_v_out_413051", "413051086", "story_v_out_413051.awb")

						arg_360_1:RecordAudio("413051086", var_363_24)
						arg_360_1:RecordAudio("413051086", var_363_24)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_413051", "413051086", "story_v_out_413051.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_413051", "413051086", "story_v_out_413051.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_25 = math.max(var_363_18, arg_360_1.talkMaxDuration)

			if var_363_17 <= arg_360_1.time_ and arg_360_1.time_ < var_363_17 + var_363_25 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_17) / var_363_25

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_17 + var_363_25 and arg_360_1.time_ < var_363_17 + var_363_25 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {
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

		arg_360_1:InitPlayNodeList()
	end,
	Play413051087 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 413051087
		arg_364_1.duration_ = 10.07

		local var_364_0 = {
			zh = 7.1,
			ja = 10.066
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
				arg_364_0:Play413051088(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.var_.moveOldPos10022 = arg_364_1.actors_["10022"].transform.localPosition
				arg_364_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_364_1:CheckSpriteTmpPos("10022", 3)

				for iter_367_0 = 0, arg_364_1.actors_["10022"].transform.childCount - 1 do
					local var_367_0 = arg_364_1.actors_["10022"].transform:GetChild(iter_367_0)

					if var_367_0.name == "split_3" or not string.find(var_367_0.name, "split") then
						var_367_0.gameObject:SetActive(true)
					else
						var_367_0.gameObject:SetActive(false)
					end
				end
			end

			local var_367_1 = 0.001

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_1 then
				arg_364_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_364_1.time_ - 0) / var_367_1)
			end

			if arg_364_1.time_ >= 0 + var_367_1 and arg_364_1.time_ < 0 + var_367_1 + arg_367_0 then
				arg_364_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_367_2 = arg_364_1.actors_["10092"].transform

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.var_.moveOldPos10092 = var_367_2.localPosition
				var_367_2.localScale = Vector3.New(1, 1, 1)

				arg_364_1:CheckSpriteTmpPos("10092", 7)

				for iter_367_1 = 0, var_367_2.childCount - 1 do
					local var_367_3 = var_367_2:GetChild(iter_367_1)

					if var_367_3.name == "split_4" or not string.find(var_367_3.name, "split") then
						var_367_3.gameObject:SetActive(true)
					else
						var_367_3.gameObject:SetActive(false)
					end
				end
			end

			local var_367_4 = 0.001

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_4 then
				var_367_2.localPosition = Vector3.Lerp(arg_364_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_364_1.time_ - 0) / var_367_4)
			end

			if arg_364_1.time_ >= 0 + var_367_4 and arg_364_1.time_ < 0 + var_367_4 + arg_367_0 then
				var_367_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_367_5 = arg_364_1.actors_["10022"]

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(var_367_5) and arg_364_1.var_.actorSpriteComps10022 == nil then
				arg_364_1.var_.actorSpriteComps10022 = var_367_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_367_6 = 2

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_6 and not isNil(var_367_5) then
				if arg_364_1.var_.actorSpriteComps10022 then
					for iter_367_2, iter_367_3 in pairs(arg_364_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_367_3 then
							if arg_364_1.isInRecall_ then
								iter_367_3.color = Color.New(Mathf.Lerp(iter_367_3.color.r, arg_364_1.hightColor1.r, (arg_364_1.time_ - 0) / var_367_6), Mathf.Lerp(iter_367_3.color.g, arg_364_1.hightColor1.g, (arg_364_1.time_ - 0) / var_367_6), (Mathf.Lerp(iter_367_3.color.b, arg_364_1.hightColor1.b, (arg_364_1.time_ - 0) / var_367_6)))
							else
								local var_367_7 = Mathf.Lerp(iter_367_3.color.r, 1, (arg_364_1.time_ - 0) / var_367_6)

								iter_367_3.color = Color.New(var_367_7, var_367_7, var_367_7)
							end
						end
					end
				end
			end

			if arg_364_1.time_ >= 0 + var_367_6 and arg_364_1.time_ < 0 + var_367_6 + arg_367_0 and not isNil(var_367_5) and arg_364_1.var_.actorSpriteComps10022 then
				for iter_367_4, iter_367_5 in pairs(arg_364_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_367_5 then
						iter_367_5.color = arg_364_1.isInRecall_ and (arg_364_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_364_1.var_.actorSpriteComps10022 = nil
			end

			local var_367_8 = arg_364_1.actors_["10092"]

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 and not isNil(var_367_8) and arg_364_1.var_.actorSpriteComps10092 == nil then
				arg_364_1.var_.actorSpriteComps10092 = var_367_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_367_9 = 2

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_9 and not isNil(var_367_8) then
				if arg_364_1.var_.actorSpriteComps10092 then
					for iter_367_6, iter_367_7 in pairs(arg_364_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_367_7 then
							if arg_364_1.isInRecall_ then
								iter_367_7.color = Color.New(Mathf.Lerp(iter_367_7.color.r, arg_364_1.hightColor2.r, (arg_364_1.time_ - 0) / var_367_9), Mathf.Lerp(iter_367_7.color.g, arg_364_1.hightColor2.g, (arg_364_1.time_ - 0) / var_367_9), (Mathf.Lerp(iter_367_7.color.b, arg_364_1.hightColor2.b, (arg_364_1.time_ - 0) / var_367_9)))
							else
								local var_367_10 = Mathf.Lerp(iter_367_7.color.r, 0.5, (arg_364_1.time_ - 0) / var_367_9)

								iter_367_7.color = Color.New(var_367_10, var_367_10, var_367_10)
							end
						end
					end
				end
			end

			if arg_364_1.time_ >= 0 + var_367_9 and arg_364_1.time_ < 0 + var_367_9 + arg_367_0 and not isNil(var_367_8) and arg_364_1.var_.actorSpriteComps10092 then
				for iter_367_8, iter_367_9 in pairs(arg_364_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_367_9 then
						iter_367_9.color = arg_364_1.isInRecall_ and (arg_364_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_364_1.var_.actorSpriteComps10092 = nil
			end

			local var_367_11 = 0
			local var_367_12 = 0.675

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_11 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_13 = arg_364_1:GetWordFromCfg(413051087)
				local var_367_14 = arg_364_1:FormatText(var_367_13.content)

				arg_364_1.text_.text = var_367_14

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_16 = 27 <= 0 and var_367_12 or var_367_12 * (utf8.len(var_367_14) / 27)

				if (27 <= 0 and var_367_12 or var_367_12 * (utf8.len(var_367_14) / 27)) > 0 and var_367_12 < var_367_16 then
					arg_364_1.talkMaxDuration = var_367_16

					if var_367_16 + var_367_11 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_16 + var_367_11
					end
				end

				arg_364_1.text_.text = var_367_14
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051087", "story_v_out_413051.awb") ~= 0 then
					local var_367_17 = manager.audio:GetVoiceLength("story_v_out_413051", "413051087", "story_v_out_413051.awb") / 1000

					if var_367_17 + var_367_11 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_17 + var_367_11
					end

					if var_367_13.prefab_name ~= "" and arg_364_1.actors_[var_367_13.prefab_name] ~= nil then
						local var_367_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_13.prefab_name].transform, "story_v_out_413051", "413051087", "story_v_out_413051.awb")

						arg_364_1:RecordAudio("413051087", var_367_18)
						arg_364_1:RecordAudio("413051087", var_367_18)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_413051", "413051087", "story_v_out_413051.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_413051", "413051087", "story_v_out_413051.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_19 = math.max(var_367_12, arg_364_1.talkMaxDuration)

			if var_367_11 <= arg_364_1.time_ and arg_364_1.time_ < var_367_11 + var_367_19 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_11) / var_367_19

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_11 + var_367_19 and arg_364_1.time_ < var_367_11 + var_367_19 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {
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
			}
		}

		arg_364_1:InitPlayNodeList()
	end,
	Play413051088 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 413051088
		arg_368_1.duration_ = 5.5

		local var_368_0 = {
			zh = 3.8,
			ja = 5.5
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play413051089(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.var_.moveOldPos10094 = arg_368_1.actors_["10094"].transform.localPosition
				arg_368_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_368_1:CheckSpriteTmpPos("10094", 3)

				for iter_371_0 = 0, arg_368_1.actors_["10094"].transform.childCount - 1 do
					local var_371_0 = arg_368_1.actors_["10094"].transform:GetChild(iter_371_0)

					if var_371_0.name == "" or not string.find(var_371_0.name, "split") then
						var_371_0.gameObject:SetActive(true)
					else
						var_371_0.gameObject:SetActive(false)
					end
				end
			end

			local var_371_1 = 0.001

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_1 then
				arg_368_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_368_1.time_ - 0) / var_371_1)
			end

			if arg_368_1.time_ >= 0 + var_371_1 and arg_368_1.time_ < 0 + var_371_1 + arg_371_0 then
				arg_368_1.actors_["10094"].transform.localPosition = Vector3.New(0, -340, -414)
			end

			local var_371_2 = arg_368_1.actors_["10022"].transform

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.var_.moveOldPos10022 = var_371_2.localPosition
				var_371_2.localScale = Vector3.New(1, 1, 1)

				arg_368_1:CheckSpriteTmpPos("10022", 0)

				for iter_371_1 = 0, var_371_2.childCount - 1 do
					local var_371_3 = var_371_2:GetChild(iter_371_1)

					if var_371_3.name == "" or not string.find(var_371_3.name, "split") then
						var_371_3.gameObject:SetActive(true)
					else
						var_371_3.gameObject:SetActive(false)
					end
				end
			end

			local var_371_4 = 0.001

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_4 then
				var_371_2.localPosition = Vector3.Lerp(arg_368_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_368_1.time_ - 0) / var_371_4)
			end

			if arg_368_1.time_ >= 0 + var_371_4 and arg_368_1.time_ < 0 + var_371_4 + arg_371_0 then
				var_371_2.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_371_5 = arg_368_1.actors_["10094"]

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(var_371_5) and arg_368_1.var_.actorSpriteComps10094 == nil then
				arg_368_1.var_.actorSpriteComps10094 = var_371_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_371_6 = 2

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_6 and not isNil(var_371_5) then
				if arg_368_1.var_.actorSpriteComps10094 then
					for iter_371_2, iter_371_3 in pairs(arg_368_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_371_3 then
							if arg_368_1.isInRecall_ then
								iter_371_3.color = Color.New(Mathf.Lerp(iter_371_3.color.r, arg_368_1.hightColor1.r, (arg_368_1.time_ - 0) / var_371_6), Mathf.Lerp(iter_371_3.color.g, arg_368_1.hightColor1.g, (arg_368_1.time_ - 0) / var_371_6), (Mathf.Lerp(iter_371_3.color.b, arg_368_1.hightColor1.b, (arg_368_1.time_ - 0) / var_371_6)))
							else
								local var_371_7 = Mathf.Lerp(iter_371_3.color.r, 1, (arg_368_1.time_ - 0) / var_371_6)

								iter_371_3.color = Color.New(var_371_7, var_371_7, var_371_7)
							end
						end
					end
				end
			end

			if arg_368_1.time_ >= 0 + var_371_6 and arg_368_1.time_ < 0 + var_371_6 + arg_371_0 and not isNil(var_371_5) and arg_368_1.var_.actorSpriteComps10094 then
				for iter_371_4, iter_371_5 in pairs(arg_368_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_371_5 then
						iter_371_5.color = arg_368_1.isInRecall_ and (arg_368_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_368_1.var_.actorSpriteComps10094 = nil
			end

			local var_371_8 = arg_368_1.actors_["10022"]

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 and not isNil(var_371_8) and arg_368_1.var_.actorSpriteComps10022 == nil then
				arg_368_1.var_.actorSpriteComps10022 = var_371_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_371_9 = 2

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_9 and not isNil(var_371_8) then
				if arg_368_1.var_.actorSpriteComps10022 then
					for iter_371_6, iter_371_7 in pairs(arg_368_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_371_7 then
							if arg_368_1.isInRecall_ then
								iter_371_7.color = Color.New(Mathf.Lerp(iter_371_7.color.r, arg_368_1.hightColor2.r, (arg_368_1.time_ - 0) / var_371_9), Mathf.Lerp(iter_371_7.color.g, arg_368_1.hightColor2.g, (arg_368_1.time_ - 0) / var_371_9), (Mathf.Lerp(iter_371_7.color.b, arg_368_1.hightColor2.b, (arg_368_1.time_ - 0) / var_371_9)))
							else
								local var_371_10 = Mathf.Lerp(iter_371_7.color.r, 0.5, (arg_368_1.time_ - 0) / var_371_9)

								iter_371_7.color = Color.New(var_371_10, var_371_10, var_371_10)
							end
						end
					end
				end
			end

			if arg_368_1.time_ >= 0 + var_371_9 and arg_368_1.time_ < 0 + var_371_9 + arg_371_0 and not isNil(var_371_8) and arg_368_1.var_.actorSpriteComps10022 then
				for iter_371_8, iter_371_9 in pairs(arg_368_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_371_9 then
						iter_371_9.color = arg_368_1.isInRecall_ and (arg_368_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_368_1.var_.actorSpriteComps10022 = nil
			end

			local var_371_11 = 0
			local var_371_12 = 0.475

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_11 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_13 = arg_368_1:GetWordFromCfg(413051088)
				local var_371_14 = arg_368_1:FormatText(var_371_13.content)

				arg_368_1.text_.text = var_371_14

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_16 = 19 <= 0 and var_371_12 or var_371_12 * (utf8.len(var_371_14) / 19)

				if (19 <= 0 and var_371_12 or var_371_12 * (utf8.len(var_371_14) / 19)) > 0 and var_371_12 < var_371_16 then
					arg_368_1.talkMaxDuration = var_371_16

					if var_371_16 + var_371_11 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_16 + var_371_11
					end
				end

				arg_368_1.text_.text = var_371_14
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051088", "story_v_out_413051.awb") ~= 0 then
					local var_371_17 = manager.audio:GetVoiceLength("story_v_out_413051", "413051088", "story_v_out_413051.awb") / 1000

					if var_371_17 + var_371_11 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_17 + var_371_11
					end

					if var_371_13.prefab_name ~= "" and arg_368_1.actors_[var_371_13.prefab_name] ~= nil then
						local var_371_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_13.prefab_name].transform, "story_v_out_413051", "413051088", "story_v_out_413051.awb")

						arg_368_1:RecordAudio("413051088", var_371_18)
						arg_368_1:RecordAudio("413051088", var_371_18)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_413051", "413051088", "story_v_out_413051.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_413051", "413051088", "story_v_out_413051.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_19 = math.max(var_371_12, arg_368_1.talkMaxDuration)

			if var_371_11 <= arg_368_1.time_ and arg_368_1.time_ < var_371_11 + var_371_19 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_11) / var_371_19

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_11 + var_371_19 and arg_368_1.time_ < var_371_11 + var_371_19 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {
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

		arg_368_1:InitPlayNodeList()
	end,
	Play413051089 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 413051089
		arg_372_1.duration_ = 3.1

		local var_372_0 = {
			zh = 3.1,
			ja = 2.766
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play413051090(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0.325

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_1 = arg_372_1:GetWordFromCfg(413051089)
				local var_375_2 = arg_372_1:FormatText(var_375_1.content)

				arg_372_1.text_.text = var_375_2

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_4 = 13 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_2) / 13)

				if (13 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_2) / 13)) > 0 and var_375_0 < var_375_4 then
					arg_372_1.talkMaxDuration = var_375_4

					if var_375_4 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_4 + 0
					end
				end

				arg_372_1.text_.text = var_375_2
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051089", "story_v_out_413051.awb") ~= 0 then
					local var_375_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051089", "story_v_out_413051.awb") / 1000

					if var_375_5 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_5 + 0
					end

					if var_375_1.prefab_name ~= "" and arg_372_1.actors_[var_375_1.prefab_name] ~= nil then
						local var_375_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_1.prefab_name].transform, "story_v_out_413051", "413051089", "story_v_out_413051.awb")

						arg_372_1:RecordAudio("413051089", var_375_6)
						arg_372_1:RecordAudio("413051089", var_375_6)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_413051", "413051089", "story_v_out_413051.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_413051", "413051089", "story_v_out_413051.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_7 = math.max(var_375_0, arg_372_1.talkMaxDuration)

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_7 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - 0) / var_375_7

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= 0 + var_375_7 and arg_372_1.time_ < 0 + var_375_7 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play413051090 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 413051090
		arg_376_1.duration_ = 4.5

		local var_376_0 = {
			zh = 4.5,
			ja = 4.166
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
				arg_376_0:Play413051091(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.var_.moveOldPos10022 = arg_376_1.actors_["10022"].transform.localPosition
				arg_376_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_376_1:CheckSpriteTmpPos("10022", 3)

				for iter_379_0 = 0, arg_376_1.actors_["10022"].transform.childCount - 1 do
					local var_379_0 = arg_376_1.actors_["10022"].transform:GetChild(iter_379_0)

					if var_379_0.name == "split_3" or not string.find(var_379_0.name, "split") then
						var_379_0.gameObject:SetActive(true)
					else
						var_379_0.gameObject:SetActive(false)
					end
				end
			end

			local var_379_1 = 0.001

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_1 then
				arg_376_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_376_1.time_ - 0) / var_379_1)
			end

			if arg_376_1.time_ >= 0 + var_379_1 and arg_376_1.time_ < 0 + var_379_1 + arg_379_0 then
				arg_376_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_379_2 = arg_376_1.actors_["10094"].transform

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.var_.moveOldPos10094 = var_379_2.localPosition
				var_379_2.localScale = Vector3.New(1, 1, 1)

				arg_376_1:CheckSpriteTmpPos("10094", 7)

				for iter_379_1 = 0, var_379_2.childCount - 1 do
					local var_379_3 = var_379_2:GetChild(iter_379_1)

					if var_379_3.name == "" or not string.find(var_379_3.name, "split") then
						var_379_3.gameObject:SetActive(true)
					else
						var_379_3.gameObject:SetActive(false)
					end
				end
			end

			local var_379_4 = 0.001

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_4 then
				var_379_2.localPosition = Vector3.Lerp(arg_376_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_376_1.time_ - 0) / var_379_4)
			end

			if arg_376_1.time_ >= 0 + var_379_4 and arg_376_1.time_ < 0 + var_379_4 + arg_379_0 then
				var_379_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_379_5 = arg_376_1.actors_["10022"]

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(var_379_5) and arg_376_1.var_.actorSpriteComps10022 == nil then
				arg_376_1.var_.actorSpriteComps10022 = var_379_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_379_6 = 2

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_6 and not isNil(var_379_5) then
				if arg_376_1.var_.actorSpriteComps10022 then
					for iter_379_2, iter_379_3 in pairs(arg_376_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_379_3 then
							if arg_376_1.isInRecall_ then
								iter_379_3.color = Color.New(Mathf.Lerp(iter_379_3.color.r, arg_376_1.hightColor1.r, (arg_376_1.time_ - 0) / var_379_6), Mathf.Lerp(iter_379_3.color.g, arg_376_1.hightColor1.g, (arg_376_1.time_ - 0) / var_379_6), (Mathf.Lerp(iter_379_3.color.b, arg_376_1.hightColor1.b, (arg_376_1.time_ - 0) / var_379_6)))
							else
								local var_379_7 = Mathf.Lerp(iter_379_3.color.r, 1, (arg_376_1.time_ - 0) / var_379_6)

								iter_379_3.color = Color.New(var_379_7, var_379_7, var_379_7)
							end
						end
					end
				end
			end

			if arg_376_1.time_ >= 0 + var_379_6 and arg_376_1.time_ < 0 + var_379_6 + arg_379_0 and not isNil(var_379_5) and arg_376_1.var_.actorSpriteComps10022 then
				for iter_379_4, iter_379_5 in pairs(arg_376_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_379_5 then
						iter_379_5.color = arg_376_1.isInRecall_ and (arg_376_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_376_1.var_.actorSpriteComps10022 = nil
			end

			local var_379_8 = arg_376_1.actors_["10094"]

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 and not isNil(var_379_8) and arg_376_1.var_.actorSpriteComps10094 == nil then
				arg_376_1.var_.actorSpriteComps10094 = var_379_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_379_9 = 2

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_9 and not isNil(var_379_8) then
				if arg_376_1.var_.actorSpriteComps10094 then
					for iter_379_6, iter_379_7 in pairs(arg_376_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_379_7 then
							if arg_376_1.isInRecall_ then
								iter_379_7.color = Color.New(Mathf.Lerp(iter_379_7.color.r, arg_376_1.hightColor2.r, (arg_376_1.time_ - 0) / var_379_9), Mathf.Lerp(iter_379_7.color.g, arg_376_1.hightColor2.g, (arg_376_1.time_ - 0) / var_379_9), (Mathf.Lerp(iter_379_7.color.b, arg_376_1.hightColor2.b, (arg_376_1.time_ - 0) / var_379_9)))
							else
								local var_379_10 = Mathf.Lerp(iter_379_7.color.r, 0.5, (arg_376_1.time_ - 0) / var_379_9)

								iter_379_7.color = Color.New(var_379_10, var_379_10, var_379_10)
							end
						end
					end
				end
			end

			if arg_376_1.time_ >= 0 + var_379_9 and arg_376_1.time_ < 0 + var_379_9 + arg_379_0 and not isNil(var_379_8) and arg_376_1.var_.actorSpriteComps10094 then
				for iter_379_8, iter_379_9 in pairs(arg_376_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_379_9 then
						iter_379_9.color = arg_376_1.isInRecall_ and (arg_376_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_376_1.var_.actorSpriteComps10094 = nil
			end

			local var_379_11 = 0
			local var_379_12 = 0.475

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_11 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_13 = arg_376_1:GetWordFromCfg(413051090)
				local var_379_14 = arg_376_1:FormatText(var_379_13.content)

				arg_376_1.text_.text = var_379_14

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_16 = 19 <= 0 and var_379_12 or var_379_12 * (utf8.len(var_379_14) / 19)

				if (19 <= 0 and var_379_12 or var_379_12 * (utf8.len(var_379_14) / 19)) > 0 and var_379_12 < var_379_16 then
					arg_376_1.talkMaxDuration = var_379_16

					if var_379_16 + var_379_11 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_16 + var_379_11
					end
				end

				arg_376_1.text_.text = var_379_14
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051090", "story_v_out_413051.awb") ~= 0 then
					local var_379_17 = manager.audio:GetVoiceLength("story_v_out_413051", "413051090", "story_v_out_413051.awb") / 1000

					if var_379_17 + var_379_11 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_17 + var_379_11
					end

					if var_379_13.prefab_name ~= "" and arg_376_1.actors_[var_379_13.prefab_name] ~= nil then
						local var_379_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_13.prefab_name].transform, "story_v_out_413051", "413051090", "story_v_out_413051.awb")

						arg_376_1:RecordAudio("413051090", var_379_18)
						arg_376_1:RecordAudio("413051090", var_379_18)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_413051", "413051090", "story_v_out_413051.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_413051", "413051090", "story_v_out_413051.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_19 = math.max(var_379_12, arg_376_1.talkMaxDuration)

			if var_379_11 <= arg_376_1.time_ and arg_376_1.time_ < var_379_11 + var_379_19 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_11) / var_379_19

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_11 + var_379_19 and arg_376_1.time_ < var_379_11 + var_379_19 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {
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

		arg_376_1:InitPlayNodeList()
	end,
	Play413051091 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 413051091
		arg_380_1.duration_ = 5.5

		local var_380_0 = {
			zh = 5.5,
			ja = 3.933
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
				arg_380_0:Play413051092(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.var_.moveOldPos10092 = arg_380_1.actors_["10092"].transform.localPosition
				arg_380_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_380_1:CheckSpriteTmpPos("10092", 2)

				for iter_383_0 = 0, arg_380_1.actors_["10092"].transform.childCount - 1 do
					local var_383_0 = arg_380_1.actors_["10092"].transform:GetChild(iter_383_0)

					if var_383_0.name == "split_1_1" or not string.find(var_383_0.name, "split") then
						var_383_0.gameObject:SetActive(true)
					else
						var_383_0.gameObject:SetActive(false)
					end
				end
			end

			local var_383_1 = 0.001

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_1 then
				arg_380_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos10092, Vector3.New(-389.49, -300, -295), (arg_380_1.time_ - 0) / var_383_1)
			end

			if arg_380_1.time_ >= 0 + var_383_1 and arg_380_1.time_ < 0 + var_383_1 + arg_383_0 then
				arg_380_1.actors_["10092"].transform.localPosition = Vector3.New(-389.49, -300, -295)
			end

			local var_383_2 = arg_380_1.actors_["10022"].transform

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.var_.moveOldPos10022 = var_383_2.localPosition
				var_383_2.localScale = Vector3.New(1, 1, 1)

				arg_380_1:CheckSpriteTmpPos("10022", 7)

				for iter_383_1 = 0, var_383_2.childCount - 1 do
					local var_383_3 = var_383_2:GetChild(iter_383_1)

					if var_383_3.name == "" or not string.find(var_383_3.name, "split") then
						var_383_3.gameObject:SetActive(true)
					else
						var_383_3.gameObject:SetActive(false)
					end
				end
			end

			local var_383_4 = 0.001

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_4 then
				var_383_2.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_380_1.time_ - 0) / var_383_4)
			end

			if arg_380_1.time_ >= 0 + var_383_4 and arg_380_1.time_ < 0 + var_383_4 + arg_383_0 then
				var_383_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_383_5 = arg_380_1.actors_["10092"]

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(var_383_5) and arg_380_1.var_.actorSpriteComps10092 == nil then
				arg_380_1.var_.actorSpriteComps10092 = var_383_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_383_6 = 2

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_6 and not isNil(var_383_5) then
				if arg_380_1.var_.actorSpriteComps10092 then
					for iter_383_2, iter_383_3 in pairs(arg_380_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_383_3 then
							if arg_380_1.isInRecall_ then
								iter_383_3.color = Color.New(Mathf.Lerp(iter_383_3.color.r, arg_380_1.hightColor1.r, (arg_380_1.time_ - 0) / var_383_6), Mathf.Lerp(iter_383_3.color.g, arg_380_1.hightColor1.g, (arg_380_1.time_ - 0) / var_383_6), (Mathf.Lerp(iter_383_3.color.b, arg_380_1.hightColor1.b, (arg_380_1.time_ - 0) / var_383_6)))
							else
								local var_383_7 = Mathf.Lerp(iter_383_3.color.r, 1, (arg_380_1.time_ - 0) / var_383_6)

								iter_383_3.color = Color.New(var_383_7, var_383_7, var_383_7)
							end
						end
					end
				end
			end

			if arg_380_1.time_ >= 0 + var_383_6 and arg_380_1.time_ < 0 + var_383_6 + arg_383_0 and not isNil(var_383_5) and arg_380_1.var_.actorSpriteComps10092 then
				for iter_383_4, iter_383_5 in pairs(arg_380_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_383_5 then
						iter_383_5.color = arg_380_1.isInRecall_ and (arg_380_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_380_1.var_.actorSpriteComps10092 = nil
			end

			local var_383_8 = arg_380_1.actors_["10022"]

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 and not isNil(var_383_8) and arg_380_1.var_.actorSpriteComps10022 == nil then
				arg_380_1.var_.actorSpriteComps10022 = var_383_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_383_9 = 2

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_9 and not isNil(var_383_8) then
				if arg_380_1.var_.actorSpriteComps10022 then
					for iter_383_6, iter_383_7 in pairs(arg_380_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_383_7 then
							if arg_380_1.isInRecall_ then
								iter_383_7.color = Color.New(Mathf.Lerp(iter_383_7.color.r, arg_380_1.hightColor2.r, (arg_380_1.time_ - 0) / var_383_9), Mathf.Lerp(iter_383_7.color.g, arg_380_1.hightColor2.g, (arg_380_1.time_ - 0) / var_383_9), (Mathf.Lerp(iter_383_7.color.b, arg_380_1.hightColor2.b, (arg_380_1.time_ - 0) / var_383_9)))
							else
								local var_383_10 = Mathf.Lerp(iter_383_7.color.r, 0.5, (arg_380_1.time_ - 0) / var_383_9)

								iter_383_7.color = Color.New(var_383_10, var_383_10, var_383_10)
							end
						end
					end
				end
			end

			if arg_380_1.time_ >= 0 + var_383_9 and arg_380_1.time_ < 0 + var_383_9 + arg_383_0 and not isNil(var_383_8) and arg_380_1.var_.actorSpriteComps10022 then
				for iter_383_8, iter_383_9 in pairs(arg_380_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_383_9 then
						iter_383_9.color = arg_380_1.isInRecall_ and (arg_380_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_380_1.var_.actorSpriteComps10022 = nil
			end

			local var_383_11 = 0
			local var_383_12 = 0.825

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_11 + arg_383_0 then
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

				local var_383_13 = arg_380_1:GetWordFromCfg(413051091)
				local var_383_14 = arg_380_1:FormatText(var_383_13.content)

				arg_380_1.text_.text = var_383_14

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_16 = 33 <= 0 and var_383_12 or var_383_12 * (utf8.len(var_383_14) / 33)

				if (33 <= 0 and var_383_12 or var_383_12 * (utf8.len(var_383_14) / 33)) > 0 and var_383_12 < var_383_16 then
					arg_380_1.talkMaxDuration = var_383_16

					if var_383_16 + var_383_11 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_16 + var_383_11
					end
				end

				arg_380_1.text_.text = var_383_14
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051091", "story_v_out_413051.awb") ~= 0 then
					local var_383_17 = manager.audio:GetVoiceLength("story_v_out_413051", "413051091", "story_v_out_413051.awb") / 1000

					if var_383_17 + var_383_11 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_17 + var_383_11
					end

					if var_383_13.prefab_name ~= "" and arg_380_1.actors_[var_383_13.prefab_name] ~= nil then
						local var_383_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_13.prefab_name].transform, "story_v_out_413051", "413051091", "story_v_out_413051.awb")

						arg_380_1:RecordAudio("413051091", var_383_18)
						arg_380_1:RecordAudio("413051091", var_383_18)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_413051", "413051091", "story_v_out_413051.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_413051", "413051091", "story_v_out_413051.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_19 = math.max(var_383_12, arg_380_1.talkMaxDuration)

			if var_383_11 <= arg_380_1.time_ and arg_380_1.time_ < var_383_11 + var_383_19 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_11) / var_383_19

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_11 + var_383_19 and arg_380_1.time_ < var_383_11 + var_383_19 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play413051092 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 413051092
		arg_384_1.duration_ = 13.07

		local var_384_0 = {
			zh = 9.233,
			ja = 13.066
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
				arg_384_0:Play413051093(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 1.25

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

				local var_387_1 = arg_384_1:GetWordFromCfg(413051092)
				local var_387_2 = arg_384_1:FormatText(var_387_1.content)

				arg_384_1.text_.text = var_387_2

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_4 = 50 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_2) / 50)

				if (50 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_2) / 50)) > 0 and var_387_0 < var_387_4 then
					arg_384_1.talkMaxDuration = var_387_4

					if var_387_4 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_4 + 0
					end
				end

				arg_384_1.text_.text = var_387_2
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051092", "story_v_out_413051.awb") ~= 0 then
					local var_387_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051092", "story_v_out_413051.awb") / 1000

					if var_387_5 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_5 + 0
					end

					if var_387_1.prefab_name ~= "" and arg_384_1.actors_[var_387_1.prefab_name] ~= nil then
						local var_387_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_1.prefab_name].transform, "story_v_out_413051", "413051092", "story_v_out_413051.awb")

						arg_384_1:RecordAudio("413051092", var_387_6)
						arg_384_1:RecordAudio("413051092", var_387_6)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_413051", "413051092", "story_v_out_413051.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_413051", "413051092", "story_v_out_413051.awb")
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
	Play413051093 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 413051093
		arg_388_1.duration_ = 7.4

		local var_388_0 = {
			zh = 4.433,
			ja = 7.4
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
				arg_388_0:Play413051094(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(arg_388_1.actors_["10022"]) and arg_388_1.var_.actorSpriteComps10022 == nil then
				arg_388_1.var_.actorSpriteComps10022 = arg_388_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_0 = 2

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_0 and not isNil(arg_388_1.actors_["10022"]) then
				if arg_388_1.var_.actorSpriteComps10022 then
					for iter_391_0, iter_391_1 in pairs(arg_388_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_388_1.time_ >= 0 + var_391_0 and arg_388_1.time_ < 0 + var_391_0 + arg_391_0 and not isNil(arg_388_1.actors_["10022"]) and arg_388_1.var_.actorSpriteComps10022 then
				for iter_391_2, iter_391_3 in pairs(arg_388_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_391_3 then
						iter_391_3.color = arg_388_1.isInRecall_ and (arg_388_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_388_1.var_.actorSpriteComps10022 = nil
			end

			local var_391_2 = arg_388_1.actors_["10092"]

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 and not isNil(var_391_2) and arg_388_1.var_.actorSpriteComps10092 == nil then
				arg_388_1.var_.actorSpriteComps10092 = var_391_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_391_3 = 2

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_3 and not isNil(var_391_2) then
				if arg_388_1.var_.actorSpriteComps10092 then
					for iter_391_4, iter_391_5 in pairs(arg_388_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_391_5 then
							if arg_388_1.isInRecall_ then
								iter_391_5.color = Color.New(Mathf.Lerp(iter_391_5.color.r, arg_388_1.hightColor2.r, (arg_388_1.time_ - 0) / var_391_3), Mathf.Lerp(iter_391_5.color.g, arg_388_1.hightColor2.g, (arg_388_1.time_ - 0) / var_391_3), (Mathf.Lerp(iter_391_5.color.b, arg_388_1.hightColor2.b, (arg_388_1.time_ - 0) / var_391_3)))
							else
								local var_391_4 = Mathf.Lerp(iter_391_5.color.r, 0.5, (arg_388_1.time_ - 0) / var_391_3)

								iter_391_5.color = Color.New(var_391_4, var_391_4, var_391_4)
							end
						end
					end
				end
			end

			if arg_388_1.time_ >= 0 + var_391_3 and arg_388_1.time_ < 0 + var_391_3 + arg_391_0 and not isNil(var_391_2) and arg_388_1.var_.actorSpriteComps10092 then
				for iter_391_6, iter_391_7 in pairs(arg_388_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_391_7 then
						iter_391_7.color = arg_388_1.isInRecall_ and (arg_388_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_388_1.var_.actorSpriteComps10092 = nil
			end

			local var_391_5 = arg_388_1.actors_["10022"].transform

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.var_.moveOldPos10022 = var_391_5.localPosition
				var_391_5.localScale = Vector3.New(1, 1, 1)

				arg_388_1:CheckSpriteTmpPos("10022", 4)

				for iter_391_8 = 0, var_391_5.childCount - 1 do
					local var_391_6 = var_391_5:GetChild(iter_391_8)

					if var_391_6.name == "split_6" or not string.find(var_391_6.name, "split") then
						var_391_6.gameObject:SetActive(true)
					else
						var_391_6.gameObject:SetActive(false)
					end
				end
			end

			local var_391_7 = 0.001

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_7 then
				var_391_5.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_388_1.time_ - 0) / var_391_7)
			end

			if arg_388_1.time_ >= 0 + var_391_7 and arg_388_1.time_ < 0 + var_391_7 + arg_391_0 then
				var_391_5.localPosition = Vector3.New(390, -315, -320)
			end

			local var_391_8 = 0
			local var_391_9 = 0.575

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_8 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_10 = arg_388_1:GetWordFromCfg(413051093)
				local var_391_11 = arg_388_1:FormatText(var_391_10.content)

				arg_388_1.text_.text = var_391_11

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_13 = 23 <= 0 and var_391_9 or var_391_9 * (utf8.len(var_391_11) / 23)

				if (23 <= 0 and var_391_9 or var_391_9 * (utf8.len(var_391_11) / 23)) > 0 and var_391_9 < var_391_13 then
					arg_388_1.talkMaxDuration = var_391_13

					if var_391_13 + var_391_8 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_13 + var_391_8
					end
				end

				arg_388_1.text_.text = var_391_11
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051093", "story_v_out_413051.awb") ~= 0 then
					local var_391_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051093", "story_v_out_413051.awb") / 1000

					if var_391_14 + var_391_8 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_14 + var_391_8
					end

					if var_391_10.prefab_name ~= "" and arg_388_1.actors_[var_391_10.prefab_name] ~= nil then
						local var_391_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_10.prefab_name].transform, "story_v_out_413051", "413051093", "story_v_out_413051.awb")

						arg_388_1:RecordAudio("413051093", var_391_15)
						arg_388_1:RecordAudio("413051093", var_391_15)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_413051", "413051093", "story_v_out_413051.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_413051", "413051093", "story_v_out_413051.awb")
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
				actorName = "10022",
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
	Play413051094 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 413051094
		arg_392_1.duration_ = 9.07

		local var_392_0 = {
			zh = 5.366,
			ja = 9.066
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
				arg_392_0:Play413051095(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 and not isNil(arg_392_1.actors_["10022"]) and arg_392_1.var_.actorSpriteComps10022 == nil then
				arg_392_1.var_.actorSpriteComps10022 = arg_392_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_395_0 = 2

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_0 and not isNil(arg_392_1.actors_["10022"]) then
				if arg_392_1.var_.actorSpriteComps10022 then
					for iter_395_0, iter_395_1 in pairs(arg_392_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_392_1.time_ >= 0 + var_395_0 and arg_392_1.time_ < 0 + var_395_0 + arg_395_0 and not isNil(arg_392_1.actors_["10022"]) and arg_392_1.var_.actorSpriteComps10022 then
				for iter_395_2, iter_395_3 in pairs(arg_392_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_395_3 then
						iter_395_3.color = arg_392_1.isInRecall_ and (arg_392_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_392_1.var_.actorSpriteComps10022 = nil
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

			local var_395_5 = 0
			local var_395_6 = 0.7

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_5 + arg_395_0 then
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

				local var_395_7 = arg_392_1:GetWordFromCfg(413051094)
				local var_395_8 = arg_392_1:FormatText(var_395_7.content)

				arg_392_1.text_.text = var_395_8

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_10 = 28 <= 0 and var_395_6 or var_395_6 * (utf8.len(var_395_8) / 28)

				if (28 <= 0 and var_395_6 or var_395_6 * (utf8.len(var_395_8) / 28)) > 0 and var_395_6 < var_395_10 then
					arg_392_1.talkMaxDuration = var_395_10

					if var_395_10 + var_395_5 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_10 + var_395_5
					end
				end

				arg_392_1.text_.text = var_395_8
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051094", "story_v_out_413051.awb") ~= 0 then
					local var_395_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051094", "story_v_out_413051.awb") / 1000

					if var_395_11 + var_395_5 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_11 + var_395_5
					end

					if var_395_7.prefab_name ~= "" and arg_392_1.actors_[var_395_7.prefab_name] ~= nil then
						local var_395_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_7.prefab_name].transform, "story_v_out_413051", "413051094", "story_v_out_413051.awb")

						arg_392_1:RecordAudio("413051094", var_395_12)
						arg_392_1:RecordAudio("413051094", var_395_12)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_413051", "413051094", "story_v_out_413051.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_413051", "413051094", "story_v_out_413051.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_13 = math.max(var_395_6, arg_392_1.talkMaxDuration)

			if var_395_5 <= arg_392_1.time_ and arg_392_1.time_ < var_395_5 + var_395_13 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_5) / var_395_13

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_5 + var_395_13 and arg_392_1.time_ < var_395_5 + var_395_13 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play413051095 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 413051095
		arg_396_1.duration_ = 4.9

		local var_396_0 = {
			zh = 1.999999999999,
			ja = 4.9
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
				arg_396_0:Play413051096(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(arg_396_1.actors_["10022"]) and arg_396_1.var_.actorSpriteComps10022 == nil then
				arg_396_1.var_.actorSpriteComps10022 = arg_396_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_399_0 = 2

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_0 and not isNil(arg_396_1.actors_["10022"]) then
				if arg_396_1.var_.actorSpriteComps10022 then
					for iter_399_0, iter_399_1 in pairs(arg_396_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_399_1 then
							if arg_396_1.isInRecall_ then
								iter_399_1.color = Color.New(Mathf.Lerp(iter_399_1.color.r, arg_396_1.hightColor1.r, (arg_396_1.time_ - 0) / var_399_0), Mathf.Lerp(iter_399_1.color.g, arg_396_1.hightColor1.g, (arg_396_1.time_ - 0) / var_399_0), (Mathf.Lerp(iter_399_1.color.b, arg_396_1.hightColor1.b, (arg_396_1.time_ - 0) / var_399_0)))
							else
								local var_399_1 = Mathf.Lerp(iter_399_1.color.r, 1, (arg_396_1.time_ - 0) / var_399_0)

								iter_399_1.color = Color.New(var_399_1, var_399_1, var_399_1)
							end
						end
					end
				end
			end

			if arg_396_1.time_ >= 0 + var_399_0 and arg_396_1.time_ < 0 + var_399_0 + arg_399_0 and not isNil(arg_396_1.actors_["10022"]) and arg_396_1.var_.actorSpriteComps10022 then
				for iter_399_2, iter_399_3 in pairs(arg_396_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_399_3 then
						iter_399_3.color = arg_396_1.isInRecall_ and (arg_396_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_396_1.var_.actorSpriteComps10022 = nil
			end

			local var_399_2 = arg_396_1.actors_["10092"]

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 and not isNil(var_399_2) and arg_396_1.var_.actorSpriteComps10092 == nil then
				arg_396_1.var_.actorSpriteComps10092 = var_399_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_399_3 = 2

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_3 and not isNil(var_399_2) then
				if arg_396_1.var_.actorSpriteComps10092 then
					for iter_399_4, iter_399_5 in pairs(arg_396_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_399_5 then
							if arg_396_1.isInRecall_ then
								iter_399_5.color = Color.New(Mathf.Lerp(iter_399_5.color.r, arg_396_1.hightColor2.r, (arg_396_1.time_ - 0) / var_399_3), Mathf.Lerp(iter_399_5.color.g, arg_396_1.hightColor2.g, (arg_396_1.time_ - 0) / var_399_3), (Mathf.Lerp(iter_399_5.color.b, arg_396_1.hightColor2.b, (arg_396_1.time_ - 0) / var_399_3)))
							else
								local var_399_4 = Mathf.Lerp(iter_399_5.color.r, 0.5, (arg_396_1.time_ - 0) / var_399_3)

								iter_399_5.color = Color.New(var_399_4, var_399_4, var_399_4)
							end
						end
					end
				end
			end

			if arg_396_1.time_ >= 0 + var_399_3 and arg_396_1.time_ < 0 + var_399_3 + arg_399_0 and not isNil(var_399_2) and arg_396_1.var_.actorSpriteComps10092 then
				for iter_399_6, iter_399_7 in pairs(arg_396_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_399_7 then
						iter_399_7.color = arg_396_1.isInRecall_ and (arg_396_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_396_1.var_.actorSpriteComps10092 = nil
			end

			local var_399_5 = 0
			local var_399_6 = 0.275

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_5 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_7 = arg_396_1:GetWordFromCfg(413051095)
				local var_399_8 = arg_396_1:FormatText(var_399_7.content)

				arg_396_1.text_.text = var_399_8

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_10 = 11 <= 0 and var_399_6 or var_399_6 * (utf8.len(var_399_8) / 11)

				if (11 <= 0 and var_399_6 or var_399_6 * (utf8.len(var_399_8) / 11)) > 0 and var_399_6 < var_399_10 then
					arg_396_1.talkMaxDuration = var_399_10

					if var_399_10 + var_399_5 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_10 + var_399_5
					end
				end

				arg_396_1.text_.text = var_399_8
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051095", "story_v_out_413051.awb") ~= 0 then
					local var_399_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051095", "story_v_out_413051.awb") / 1000

					if var_399_11 + var_399_5 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_11 + var_399_5
					end

					if var_399_7.prefab_name ~= "" and arg_396_1.actors_[var_399_7.prefab_name] ~= nil then
						local var_399_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_7.prefab_name].transform, "story_v_out_413051", "413051095", "story_v_out_413051.awb")

						arg_396_1:RecordAudio("413051095", var_399_12)
						arg_396_1:RecordAudio("413051095", var_399_12)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_413051", "413051095", "story_v_out_413051.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_413051", "413051095", "story_v_out_413051.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_13 = math.max(var_399_6, arg_396_1.talkMaxDuration)

			if var_399_5 <= arg_396_1.time_ and arg_396_1.time_ < var_399_5 + var_399_13 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_5) / var_399_13

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_5 + var_399_13 and arg_396_1.time_ < var_399_5 + var_399_13 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play413051096 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 413051096
		arg_400_1.duration_ = 3.03

		local var_400_0 = {
			zh = 3.033,
			ja = 1.999999999999
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
				arg_400_0:Play413051097(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.var_.moveOldPos10022 = arg_400_1.actors_["10022"].transform.localPosition
				arg_400_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_400_1:CheckSpriteTmpPos("10022", 0)

				for iter_403_0 = 0, arg_400_1.actors_["10022"].transform.childCount - 1 do
					local var_403_0 = arg_400_1.actors_["10022"].transform:GetChild(iter_403_0)

					if var_403_0.name == "" or not string.find(var_403_0.name, "split") then
						var_403_0.gameObject:SetActive(true)
					else
						var_403_0.gameObject:SetActive(false)
					end
				end
			end

			local var_403_1 = 0.001

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_1 then
				arg_400_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_400_1.time_ - 0) / var_403_1)
			end

			if arg_400_1.time_ >= 0 + var_403_1 and arg_400_1.time_ < 0 + var_403_1 + arg_403_0 then
				arg_400_1.actors_["10022"].transform.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_403_2 = arg_400_1.actors_["10092"].transform

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.var_.moveOldPos10092 = var_403_2.localPosition
				var_403_2.localScale = Vector3.New(1, 1, 1)

				arg_400_1:CheckSpriteTmpPos("10092", 0)

				for iter_403_1 = 0, var_403_2.childCount - 1 do
					local var_403_3 = var_403_2:GetChild(iter_403_1)

					if var_403_3.name == "" or not string.find(var_403_3.name, "split") then
						var_403_3.gameObject:SetActive(true)
					else
						var_403_3.gameObject:SetActive(false)
					end
				end
			end

			local var_403_4 = 0.001

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_4 then
				var_403_2.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos10092, Vector3.New(0, -5000, 0), (arg_400_1.time_ - 0) / var_403_4)
			end

			if arg_400_1.time_ >= 0 + var_403_4 and arg_400_1.time_ < 0 + var_403_4 + arg_403_0 then
				var_403_2.localPosition = Vector3.New(0, -5000, 0)
			end

			local var_403_5 = arg_400_1.actors_["10094"].transform

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.var_.moveOldPos10094 = var_403_5.localPosition
				var_403_5.localScale = Vector3.New(1, 1, 1)

				arg_400_1:CheckSpriteTmpPos("10094", 3)

				for iter_403_2 = 0, var_403_5.childCount - 1 do
					local var_403_6 = var_403_5:GetChild(iter_403_2)

					if var_403_6.name == "" or not string.find(var_403_6.name, "split") then
						var_403_6.gameObject:SetActive(true)
					else
						var_403_6.gameObject:SetActive(false)
					end
				end
			end

			local var_403_7 = 0.001

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_7 then
				var_403_5.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_400_1.time_ - 0) / var_403_7)
			end

			if arg_400_1.time_ >= 0 + var_403_7 and arg_400_1.time_ < 0 + var_403_7 + arg_403_0 then
				var_403_5.localPosition = Vector3.New(0, -340, -414)
			end

			local var_403_8 = arg_400_1.actors_["10022"]

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(var_403_8) and arg_400_1.var_.actorSpriteComps10022 == nil then
				arg_400_1.var_.actorSpriteComps10022 = var_403_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_403_9 = 2

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_9 and not isNil(var_403_8) then
				if arg_400_1.var_.actorSpriteComps10022 then
					for iter_403_3, iter_403_4 in pairs(arg_400_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_403_4 then
							if arg_400_1.isInRecall_ then
								iter_403_4.color = Color.New(Mathf.Lerp(iter_403_4.color.r, arg_400_1.hightColor2.r, (arg_400_1.time_ - 0) / var_403_9), Mathf.Lerp(iter_403_4.color.g, arg_400_1.hightColor2.g, (arg_400_1.time_ - 0) / var_403_9), (Mathf.Lerp(iter_403_4.color.b, arg_400_1.hightColor2.b, (arg_400_1.time_ - 0) / var_403_9)))
							else
								local var_403_10 = Mathf.Lerp(iter_403_4.color.r, 0.5, (arg_400_1.time_ - 0) / var_403_9)

								iter_403_4.color = Color.New(var_403_10, var_403_10, var_403_10)
							end
						end
					end
				end
			end

			if arg_400_1.time_ >= 0 + var_403_9 and arg_400_1.time_ < 0 + var_403_9 + arg_403_0 and not isNil(var_403_8) and arg_400_1.var_.actorSpriteComps10022 then
				for iter_403_5, iter_403_6 in pairs(arg_400_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_403_6 then
						iter_403_6.color = arg_400_1.isInRecall_ and (arg_400_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_400_1.var_.actorSpriteComps10022 = nil
			end

			local var_403_11 = arg_400_1.actors_["10092"]

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(var_403_11) and arg_400_1.var_.actorSpriteComps10092 == nil then
				arg_400_1.var_.actorSpriteComps10092 = var_403_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_403_12 = 2

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_12 and not isNil(var_403_11) then
				if arg_400_1.var_.actorSpriteComps10092 then
					for iter_403_7, iter_403_8 in pairs(arg_400_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_403_8 then
							if arg_400_1.isInRecall_ then
								iter_403_8.color = Color.New(Mathf.Lerp(iter_403_8.color.r, arg_400_1.hightColor2.r, (arg_400_1.time_ - 0) / var_403_12), Mathf.Lerp(iter_403_8.color.g, arg_400_1.hightColor2.g, (arg_400_1.time_ - 0) / var_403_12), (Mathf.Lerp(iter_403_8.color.b, arg_400_1.hightColor2.b, (arg_400_1.time_ - 0) / var_403_12)))
							else
								local var_403_13 = Mathf.Lerp(iter_403_8.color.r, 0.5, (arg_400_1.time_ - 0) / var_403_12)

								iter_403_8.color = Color.New(var_403_13, var_403_13, var_403_13)
							end
						end
					end
				end
			end

			if arg_400_1.time_ >= 0 + var_403_12 and arg_400_1.time_ < 0 + var_403_12 + arg_403_0 and not isNil(var_403_11) and arg_400_1.var_.actorSpriteComps10092 then
				for iter_403_9, iter_403_10 in pairs(arg_400_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_403_10 then
						iter_403_10.color = arg_400_1.isInRecall_ and (arg_400_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_400_1.var_.actorSpriteComps10092 = nil
			end

			local var_403_14 = arg_400_1.actors_["10094"]

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 and not isNil(var_403_14) and arg_400_1.var_.actorSpriteComps10094 == nil then
				arg_400_1.var_.actorSpriteComps10094 = var_403_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_403_15 = 2

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_15 and not isNil(var_403_14) then
				if arg_400_1.var_.actorSpriteComps10094 then
					for iter_403_11, iter_403_12 in pairs(arg_400_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_403_12 then
							if arg_400_1.isInRecall_ then
								iter_403_12.color = Color.New(Mathf.Lerp(iter_403_12.color.r, arg_400_1.hightColor1.r, (arg_400_1.time_ - 0) / var_403_15), Mathf.Lerp(iter_403_12.color.g, arg_400_1.hightColor1.g, (arg_400_1.time_ - 0) / var_403_15), (Mathf.Lerp(iter_403_12.color.b, arg_400_1.hightColor1.b, (arg_400_1.time_ - 0) / var_403_15)))
							else
								local var_403_16 = Mathf.Lerp(iter_403_12.color.r, 1, (arg_400_1.time_ - 0) / var_403_15)

								iter_403_12.color = Color.New(var_403_16, var_403_16, var_403_16)
							end
						end
					end
				end
			end

			if arg_400_1.time_ >= 0 + var_403_15 and arg_400_1.time_ < 0 + var_403_15 + arg_403_0 and not isNil(var_403_14) and arg_400_1.var_.actorSpriteComps10094 then
				for iter_403_13, iter_403_14 in pairs(arg_400_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_403_14 then
						iter_403_14.color = arg_400_1.isInRecall_ and (arg_400_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_400_1.var_.actorSpriteComps10094 = nil
			end

			local var_403_17 = 0
			local var_403_18 = 0.325

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= var_403_17 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_19 = arg_400_1:GetWordFromCfg(413051096)
				local var_403_20 = arg_400_1:FormatText(var_403_19.content)

				arg_400_1.text_.text = var_403_20

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_22 = 13 <= 0 and var_403_18 or var_403_18 * (utf8.len(var_403_20) / 13)

				if (13 <= 0 and var_403_18 or var_403_18 * (utf8.len(var_403_20) / 13)) > 0 and var_403_18 < var_403_22 then
					arg_400_1.talkMaxDuration = var_403_22

					if var_403_22 + var_403_17 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_22 + var_403_17
					end
				end

				arg_400_1.text_.text = var_403_20
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051096", "story_v_out_413051.awb") ~= 0 then
					local var_403_23 = manager.audio:GetVoiceLength("story_v_out_413051", "413051096", "story_v_out_413051.awb") / 1000

					if var_403_23 + var_403_17 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_23 + var_403_17
					end

					if var_403_19.prefab_name ~= "" and arg_400_1.actors_[var_403_19.prefab_name] ~= nil then
						local var_403_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_19.prefab_name].transform, "story_v_out_413051", "413051096", "story_v_out_413051.awb")

						arg_400_1:RecordAudio("413051096", var_403_24)
						arg_400_1:RecordAudio("413051096", var_403_24)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_413051", "413051096", "story_v_out_413051.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_413051", "413051096", "story_v_out_413051.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_25 = math.max(var_403_18, arg_400_1.talkMaxDuration)

			if var_403_17 <= arg_400_1.time_ and arg_400_1.time_ < var_403_17 + var_403_25 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_17) / var_403_25

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_17 + var_403_25 and arg_400_1.time_ < var_403_17 + var_403_25 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
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

		arg_400_1:InitPlayNodeList()
	end,
	Play413051097 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 413051097
		arg_404_1.duration_ = 5.43

		local var_404_0 = {
			zh = 5.433,
			ja = 5.233
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
				arg_404_0:Play413051098(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0.5

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_1 = arg_404_1:GetWordFromCfg(413051097)
				local var_407_2 = arg_404_1:FormatText(var_407_1.content)

				arg_404_1.text_.text = var_407_2

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_4 = 20 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 20)

				if (20 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 20)) > 0 and var_407_0 < var_407_4 then
					arg_404_1.talkMaxDuration = var_407_4

					if var_407_4 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_4 + 0
					end
				end

				arg_404_1.text_.text = var_407_2
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051097", "story_v_out_413051.awb") ~= 0 then
					local var_407_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051097", "story_v_out_413051.awb") / 1000

					if var_407_5 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_5 + 0
					end

					if var_407_1.prefab_name ~= "" and arg_404_1.actors_[var_407_1.prefab_name] ~= nil then
						local var_407_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_1.prefab_name].transform, "story_v_out_413051", "413051097", "story_v_out_413051.awb")

						arg_404_1:RecordAudio("413051097", var_407_6)
						arg_404_1:RecordAudio("413051097", var_407_6)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_413051", "413051097", "story_v_out_413051.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_413051", "413051097", "story_v_out_413051.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_0, arg_404_1.talkMaxDuration)

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - 0) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= 0 + var_407_7 and arg_404_1.time_ < 0 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play413051098 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 413051098
		arg_408_1.duration_ = 4.57

		local var_408_0 = {
			zh = 3.633,
			ja = 4.566
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
				arg_408_0:Play413051099(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.var_.moveOldPos10022 = arg_408_1.actors_["10022"].transform.localPosition
				arg_408_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_408_1:CheckSpriteTmpPos("10022", 3)

				for iter_411_0 = 0, arg_408_1.actors_["10022"].transform.childCount - 1 do
					local var_411_0 = arg_408_1.actors_["10022"].transform:GetChild(iter_411_0)

					if var_411_0.name == "split_3" or not string.find(var_411_0.name, "split") then
						var_411_0.gameObject:SetActive(true)
					else
						var_411_0.gameObject:SetActive(false)
					end
				end
			end

			local var_411_1 = 0.001

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_1 then
				arg_408_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_408_1.time_ - 0) / var_411_1)
			end

			if arg_408_1.time_ >= 0 + var_411_1 and arg_408_1.time_ < 0 + var_411_1 + arg_411_0 then
				arg_408_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_411_2 = arg_408_1.actors_["10094"].transform

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.var_.moveOldPos10094 = var_411_2.localPosition
				var_411_2.localScale = Vector3.New(1, 1, 1)

				arg_408_1:CheckSpriteTmpPos("10094", 7)

				for iter_411_1 = 0, var_411_2.childCount - 1 do
					local var_411_3 = var_411_2:GetChild(iter_411_1)

					if var_411_3.name == "" or not string.find(var_411_3.name, "split") then
						var_411_3.gameObject:SetActive(true)
					else
						var_411_3.gameObject:SetActive(false)
					end
				end
			end

			local var_411_4 = 0.001

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_4 then
				var_411_2.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos10094, Vector3.New(0, -2000, 0), (arg_408_1.time_ - 0) / var_411_4)
			end

			if arg_408_1.time_ >= 0 + var_411_4 and arg_408_1.time_ < 0 + var_411_4 + arg_411_0 then
				var_411_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_411_5 = arg_408_1.actors_["10022"]

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(var_411_5) and arg_408_1.var_.actorSpriteComps10022 == nil then
				arg_408_1.var_.actorSpriteComps10022 = var_411_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_411_6 = 2

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_6 and not isNil(var_411_5) then
				if arg_408_1.var_.actorSpriteComps10022 then
					for iter_411_2, iter_411_3 in pairs(arg_408_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_411_3 then
							if arg_408_1.isInRecall_ then
								iter_411_3.color = Color.New(Mathf.Lerp(iter_411_3.color.r, arg_408_1.hightColor1.r, (arg_408_1.time_ - 0) / var_411_6), Mathf.Lerp(iter_411_3.color.g, arg_408_1.hightColor1.g, (arg_408_1.time_ - 0) / var_411_6), (Mathf.Lerp(iter_411_3.color.b, arg_408_1.hightColor1.b, (arg_408_1.time_ - 0) / var_411_6)))
							else
								local var_411_7 = Mathf.Lerp(iter_411_3.color.r, 1, (arg_408_1.time_ - 0) / var_411_6)

								iter_411_3.color = Color.New(var_411_7, var_411_7, var_411_7)
							end
						end
					end
				end
			end

			if arg_408_1.time_ >= 0 + var_411_6 and arg_408_1.time_ < 0 + var_411_6 + arg_411_0 and not isNil(var_411_5) and arg_408_1.var_.actorSpriteComps10022 then
				for iter_411_4, iter_411_5 in pairs(arg_408_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_411_5 then
						iter_411_5.color = arg_408_1.isInRecall_ and (arg_408_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_408_1.var_.actorSpriteComps10022 = nil
			end

			local var_411_8 = arg_408_1.actors_["10094"]

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 and not isNil(var_411_8) and arg_408_1.var_.actorSpriteComps10094 == nil then
				arg_408_1.var_.actorSpriteComps10094 = var_411_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_411_9 = 2

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_9 and not isNil(var_411_8) then
				if arg_408_1.var_.actorSpriteComps10094 then
					for iter_411_6, iter_411_7 in pairs(arg_408_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_411_7 then
							if arg_408_1.isInRecall_ then
								iter_411_7.color = Color.New(Mathf.Lerp(iter_411_7.color.r, arg_408_1.hightColor2.r, (arg_408_1.time_ - 0) / var_411_9), Mathf.Lerp(iter_411_7.color.g, arg_408_1.hightColor2.g, (arg_408_1.time_ - 0) / var_411_9), (Mathf.Lerp(iter_411_7.color.b, arg_408_1.hightColor2.b, (arg_408_1.time_ - 0) / var_411_9)))
							else
								local var_411_10 = Mathf.Lerp(iter_411_7.color.r, 0.5, (arg_408_1.time_ - 0) / var_411_9)

								iter_411_7.color = Color.New(var_411_10, var_411_10, var_411_10)
							end
						end
					end
				end
			end

			if arg_408_1.time_ >= 0 + var_411_9 and arg_408_1.time_ < 0 + var_411_9 + arg_411_0 and not isNil(var_411_8) and arg_408_1.var_.actorSpriteComps10094 then
				for iter_411_8, iter_411_9 in pairs(arg_408_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_411_9 then
						iter_411_9.color = arg_408_1.isInRecall_ and (arg_408_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_408_1.var_.actorSpriteComps10094 = nil
			end

			local var_411_11 = 0
			local var_411_12 = 0.225

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_11 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_13 = arg_408_1:GetWordFromCfg(413051098)
				local var_411_14 = arg_408_1:FormatText(var_411_13.content)

				arg_408_1.text_.text = var_411_14

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_16 = 9 <= 0 and var_411_12 or var_411_12 * (utf8.len(var_411_14) / 9)

				if (9 <= 0 and var_411_12 or var_411_12 * (utf8.len(var_411_14) / 9)) > 0 and var_411_12 < var_411_16 then
					arg_408_1.talkMaxDuration = var_411_16

					if var_411_16 + var_411_11 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_16 + var_411_11
					end
				end

				arg_408_1.text_.text = var_411_14
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051098", "story_v_out_413051.awb") ~= 0 then
					local var_411_17 = manager.audio:GetVoiceLength("story_v_out_413051", "413051098", "story_v_out_413051.awb") / 1000

					if var_411_17 + var_411_11 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_17 + var_411_11
					end

					if var_411_13.prefab_name ~= "" and arg_408_1.actors_[var_411_13.prefab_name] ~= nil then
						local var_411_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_13.prefab_name].transform, "story_v_out_413051", "413051098", "story_v_out_413051.awb")

						arg_408_1:RecordAudio("413051098", var_411_18)
						arg_408_1:RecordAudio("413051098", var_411_18)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_413051", "413051098", "story_v_out_413051.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_413051", "413051098", "story_v_out_413051.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_19 = math.max(var_411_12, arg_408_1.talkMaxDuration)

			if var_411_11 <= arg_408_1.time_ and arg_408_1.time_ < var_411_11 + var_411_19 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_11) / var_411_19

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_11 + var_411_19 and arg_408_1.time_ < var_411_11 + var_411_19 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
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

		arg_408_1:InitPlayNodeList()
	end,
	Play413051099 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 413051099
		arg_412_1.duration_ = 8.07

		local var_412_0 = {
			zh = 8.066,
			ja = 6.066
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
				arg_412_0:Play413051100(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.moveOldPos10093 = arg_412_1.actors_["10093"].transform.localPosition
				arg_412_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_412_1:CheckSpriteTmpPos("10093", 2)

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
				arg_412_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_412_1.time_ - 0) / var_415_1)
			end

			if arg_412_1.time_ >= 0 + var_415_1 and arg_412_1.time_ < 0 + var_415_1 + arg_415_0 then
				arg_412_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_415_2 = arg_412_1.actors_["10022"]

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(var_415_2) and arg_412_1.var_.actorSpriteComps10022 == nil then
				arg_412_1.var_.actorSpriteComps10022 = var_415_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_3 = 2

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_3 and not isNil(var_415_2) then
				if arg_412_1.var_.actorSpriteComps10022 then
					for iter_415_1, iter_415_2 in pairs(arg_412_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_415_2 then
							if arg_412_1.isInRecall_ then
								iter_415_2.color = Color.New(Mathf.Lerp(iter_415_2.color.r, arg_412_1.hightColor2.r, (arg_412_1.time_ - 0) / var_415_3), Mathf.Lerp(iter_415_2.color.g, arg_412_1.hightColor2.g, (arg_412_1.time_ - 0) / var_415_3), (Mathf.Lerp(iter_415_2.color.b, arg_412_1.hightColor2.b, (arg_412_1.time_ - 0) / var_415_3)))
							else
								local var_415_4 = Mathf.Lerp(iter_415_2.color.r, 0.5, (arg_412_1.time_ - 0) / var_415_3)

								iter_415_2.color = Color.New(var_415_4, var_415_4, var_415_4)
							end
						end
					end
				end
			end

			if arg_412_1.time_ >= 0 + var_415_3 and arg_412_1.time_ < 0 + var_415_3 + arg_415_0 and not isNil(var_415_2) and arg_412_1.var_.actorSpriteComps10022 then
				for iter_415_3, iter_415_4 in pairs(arg_412_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_415_4 then
						iter_415_4.color = arg_412_1.isInRecall_ and (arg_412_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_412_1.var_.actorSpriteComps10022 = nil
			end

			local var_415_5 = arg_412_1.actors_["10093"]

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(var_415_5) and arg_412_1.var_.actorSpriteComps10093 == nil then
				arg_412_1.var_.actorSpriteComps10093 = var_415_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_6 = 2

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_6 and not isNil(var_415_5) then
				if arg_412_1.var_.actorSpriteComps10093 then
					for iter_415_5, iter_415_6 in pairs(arg_412_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_415_6 then
							if arg_412_1.isInRecall_ then
								iter_415_6.color = Color.New(Mathf.Lerp(iter_415_6.color.r, arg_412_1.hightColor1.r, (arg_412_1.time_ - 0) / var_415_6), Mathf.Lerp(iter_415_6.color.g, arg_412_1.hightColor1.g, (arg_412_1.time_ - 0) / var_415_6), (Mathf.Lerp(iter_415_6.color.b, arg_412_1.hightColor1.b, (arg_412_1.time_ - 0) / var_415_6)))
							else
								local var_415_7 = Mathf.Lerp(iter_415_6.color.r, 1, (arg_412_1.time_ - 0) / var_415_6)

								iter_415_6.color = Color.New(var_415_7, var_415_7, var_415_7)
							end
						end
					end
				end
			end

			if arg_412_1.time_ >= 0 + var_415_6 and arg_412_1.time_ < 0 + var_415_6 + arg_415_0 and not isNil(var_415_5) and arg_412_1.var_.actorSpriteComps10093 then
				for iter_415_7, iter_415_8 in pairs(arg_412_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_415_8 then
						iter_415_8.color = arg_412_1.isInRecall_ and (arg_412_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_412_1.var_.actorSpriteComps10093 = nil
			end

			local var_415_8 = arg_412_1.actors_["10022"].transform

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.var_.moveOldPos10022 = var_415_8.localPosition
				var_415_8.localScale = Vector3.New(1, 1, 1)

				arg_412_1:CheckSpriteTmpPos("10022", 4)

				for iter_415_9 = 0, var_415_8.childCount - 1 do
					local var_415_9 = var_415_8:GetChild(iter_415_9)

					if var_415_9.name == "split_3" or not string.find(var_415_9.name, "split") then
						var_415_9.gameObject:SetActive(true)
					else
						var_415_9.gameObject:SetActive(false)
					end
				end
			end

			local var_415_10 = 0.001

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_10 then
				var_415_8.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_412_1.time_ - 0) / var_415_10)
			end

			if arg_412_1.time_ >= 0 + var_415_10 and arg_412_1.time_ < 0 + var_415_10 + arg_415_0 then
				var_415_8.localPosition = Vector3.New(390, -315, -320)
			end

			local var_415_11 = 0
			local var_415_12 = 0.75

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_11 + arg_415_0 then
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

				local var_415_13 = arg_412_1:GetWordFromCfg(413051099)
				local var_415_14 = arg_412_1:FormatText(var_415_13.content)

				arg_412_1.text_.text = var_415_14

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_16 = 30 <= 0 and var_415_12 or var_415_12 * (utf8.len(var_415_14) / 30)

				if (30 <= 0 and var_415_12 or var_415_12 * (utf8.len(var_415_14) / 30)) > 0 and var_415_12 < var_415_16 then
					arg_412_1.talkMaxDuration = var_415_16

					if var_415_16 + var_415_11 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_16 + var_415_11
					end
				end

				arg_412_1.text_.text = var_415_14
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051099", "story_v_out_413051.awb") ~= 0 then
					local var_415_17 = manager.audio:GetVoiceLength("story_v_out_413051", "413051099", "story_v_out_413051.awb") / 1000

					if var_415_17 + var_415_11 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_17 + var_415_11
					end

					if var_415_13.prefab_name ~= "" and arg_412_1.actors_[var_415_13.prefab_name] ~= nil then
						local var_415_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_13.prefab_name].transform, "story_v_out_413051", "413051099", "story_v_out_413051.awb")

						arg_412_1:RecordAudio("413051099", var_415_18)
						arg_412_1:RecordAudio("413051099", var_415_18)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_413051", "413051099", "story_v_out_413051.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_413051", "413051099", "story_v_out_413051.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_19 = math.max(var_415_12, arg_412_1.talkMaxDuration)

			if var_415_11 <= arg_412_1.time_ and arg_412_1.time_ < var_415_11 + var_415_19 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_11) / var_415_19

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_11 + var_415_19 and arg_412_1.time_ < var_415_11 + var_415_19 + arg_415_0 then
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

		arg_412_1:InitPlayNodeList()
	end,
	Play413051100 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 413051100
		arg_416_1.duration_ = 4.8

		local var_416_0 = {
			zh = 3.266,
			ja = 4.8
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
				arg_416_0:Play413051101(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.var_.moveOldPos10022 = arg_416_1.actors_["10022"].transform.localPosition
				arg_416_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_416_1:CheckSpriteTmpPos("10022", 4)

				for iter_419_0 = 0, arg_416_1.actors_["10022"].transform.childCount - 1 do
					local var_419_0 = arg_416_1.actors_["10022"].transform:GetChild(iter_419_0)

					if var_419_0.name == "split_8" or not string.find(var_419_0.name, "split") then
						var_419_0.gameObject:SetActive(true)
					else
						var_419_0.gameObject:SetActive(false)
					end
				end
			end

			local var_419_1 = 0.001

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_1 then
				arg_416_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos10022, Vector3.New(390, -315, -320), (arg_416_1.time_ - 0) / var_419_1)
			end

			if arg_416_1.time_ >= 0 + var_419_1 and arg_416_1.time_ < 0 + var_419_1 + arg_419_0 then
				arg_416_1.actors_["10022"].transform.localPosition = Vector3.New(390, -315, -320)
			end

			local var_419_2 = arg_416_1.actors_["10022"]

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(var_419_2) and arg_416_1.var_.actorSpriteComps10022 == nil then
				arg_416_1.var_.actorSpriteComps10022 = var_419_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_3 = 2

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_3 and not isNil(var_419_2) then
				if arg_416_1.var_.actorSpriteComps10022 then
					for iter_419_1, iter_419_2 in pairs(arg_416_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_416_1.time_ >= 0 + var_419_3 and arg_416_1.time_ < 0 + var_419_3 + arg_419_0 and not isNil(var_419_2) and arg_416_1.var_.actorSpriteComps10022 then
				for iter_419_3, iter_419_4 in pairs(arg_416_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_419_4 then
						iter_419_4.color = arg_416_1.isInRecall_ and (arg_416_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_416_1.var_.actorSpriteComps10022 = nil
			end

			local var_419_5 = arg_416_1.actors_["10093"]

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(var_419_5) and arg_416_1.var_.actorSpriteComps10093 == nil then
				arg_416_1.var_.actorSpriteComps10093 = var_419_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_6 = 2

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_6 and not isNil(var_419_5) then
				if arg_416_1.var_.actorSpriteComps10093 then
					for iter_419_5, iter_419_6 in pairs(arg_416_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_416_1.time_ >= 0 + var_419_6 and arg_416_1.time_ < 0 + var_419_6 + arg_419_0 and not isNil(var_419_5) and arg_416_1.var_.actorSpriteComps10093 then
				for iter_419_7, iter_419_8 in pairs(arg_416_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_419_8 then
						iter_419_8.color = arg_416_1.isInRecall_ and (arg_416_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_416_1.var_.actorSpriteComps10093 = nil
			end

			local var_419_8 = 0
			local var_419_9 = 0.4

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_8 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_10 = arg_416_1:GetWordFromCfg(413051100)
				local var_419_11 = arg_416_1:FormatText(var_419_10.content)

				arg_416_1.text_.text = var_419_11

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_13 = 16 <= 0 and var_419_9 or var_419_9 * (utf8.len(var_419_11) / 16)

				if (16 <= 0 and var_419_9 or var_419_9 * (utf8.len(var_419_11) / 16)) > 0 and var_419_9 < var_419_13 then
					arg_416_1.talkMaxDuration = var_419_13

					if var_419_13 + var_419_8 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_13 + var_419_8
					end
				end

				arg_416_1.text_.text = var_419_11
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051100", "story_v_out_413051.awb") ~= 0 then
					local var_419_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051100", "story_v_out_413051.awb") / 1000

					if var_419_14 + var_419_8 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_14 + var_419_8
					end

					if var_419_10.prefab_name ~= "" and arg_416_1.actors_[var_419_10.prefab_name] ~= nil then
						local var_419_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_10.prefab_name].transform, "story_v_out_413051", "413051100", "story_v_out_413051.awb")

						arg_416_1:RecordAudio("413051100", var_419_15)
						arg_416_1:RecordAudio("413051100", var_419_15)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_413051", "413051100", "story_v_out_413051.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_413051", "413051100", "story_v_out_413051.awb")
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
				actorName = "10022",
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
	Play413051101 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 413051101
		arg_420_1.duration_ = 5.57

		local var_420_0 = {
			zh = 5.566,
			ja = 5.2
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
				arg_420_0:Play413051102(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(arg_420_1.actors_["10022"]) and arg_420_1.var_.actorSpriteComps10022 == nil then
				arg_420_1.var_.actorSpriteComps10022 = arg_420_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_423_0 = 2

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 and not isNil(arg_420_1.actors_["10022"]) then
				if arg_420_1.var_.actorSpriteComps10022 then
					for iter_423_0, iter_423_1 in pairs(arg_420_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_423_1 then
							if arg_420_1.isInRecall_ then
								iter_423_1.color = Color.New(Mathf.Lerp(iter_423_1.color.r, arg_420_1.hightColor2.r, (arg_420_1.time_ - 0) / var_423_0), Mathf.Lerp(iter_423_1.color.g, arg_420_1.hightColor2.g, (arg_420_1.time_ - 0) / var_423_0), (Mathf.Lerp(iter_423_1.color.b, arg_420_1.hightColor2.b, (arg_420_1.time_ - 0) / var_423_0)))
							else
								local var_423_1 = Mathf.Lerp(iter_423_1.color.r, 0.5, (arg_420_1.time_ - 0) / var_423_0)

								iter_423_1.color = Color.New(var_423_1, var_423_1, var_423_1)
							end
						end
					end
				end
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 and not isNil(arg_420_1.actors_["10022"]) and arg_420_1.var_.actorSpriteComps10022 then
				for iter_423_2, iter_423_3 in pairs(arg_420_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_423_3 then
						iter_423_3.color = arg_420_1.isInRecall_ and (arg_420_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_420_1.var_.actorSpriteComps10022 = nil
			end

			local var_423_2 = arg_420_1.actors_["10093"]

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(var_423_2) and arg_420_1.var_.actorSpriteComps10093 == nil then
				arg_420_1.var_.actorSpriteComps10093 = var_423_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_423_3 = 2

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_3 and not isNil(var_423_2) then
				if arg_420_1.var_.actorSpriteComps10093 then
					for iter_423_4, iter_423_5 in pairs(arg_420_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_423_5 then
							if arg_420_1.isInRecall_ then
								iter_423_5.color = Color.New(Mathf.Lerp(iter_423_5.color.r, arg_420_1.hightColor1.r, (arg_420_1.time_ - 0) / var_423_3), Mathf.Lerp(iter_423_5.color.g, arg_420_1.hightColor1.g, (arg_420_1.time_ - 0) / var_423_3), (Mathf.Lerp(iter_423_5.color.b, arg_420_1.hightColor1.b, (arg_420_1.time_ - 0) / var_423_3)))
							else
								local var_423_4 = Mathf.Lerp(iter_423_5.color.r, 1, (arg_420_1.time_ - 0) / var_423_3)

								iter_423_5.color = Color.New(var_423_4, var_423_4, var_423_4)
							end
						end
					end
				end
			end

			if arg_420_1.time_ >= 0 + var_423_3 and arg_420_1.time_ < 0 + var_423_3 + arg_423_0 and not isNil(var_423_2) and arg_420_1.var_.actorSpriteComps10093 then
				for iter_423_6, iter_423_7 in pairs(arg_420_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_423_7 then
						iter_423_7.color = arg_420_1.isInRecall_ and (arg_420_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_420_1.var_.actorSpriteComps10093 = nil
			end

			local var_423_5 = arg_420_1.actors_["10093"].transform

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.moveOldPos10093 = var_423_5.localPosition
				var_423_5.localScale = Vector3.New(1, 1, 1)

				arg_420_1:CheckSpriteTmpPos("10093", 2)

				for iter_423_8 = 0, var_423_5.childCount - 1 do
					local var_423_6 = var_423_5:GetChild(iter_423_8)

					if var_423_6.name == "split_6" or not string.find(var_423_6.name, "split") then
						var_423_6.gameObject:SetActive(true)
					else
						var_423_6.gameObject:SetActive(false)
					end
				end
			end

			local var_423_7 = 0.001

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_7 then
				var_423_5.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_420_1.time_ - 0) / var_423_7)
			end

			if arg_420_1.time_ >= 0 + var_423_7 and arg_420_1.time_ < 0 + var_423_7 + arg_423_0 then
				var_423_5.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_423_8 = 0
			local var_423_9 = 0.775

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_8 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_10 = arg_420_1:GetWordFromCfg(413051101)
				local var_423_11 = arg_420_1:FormatText(var_423_10.content)

				arg_420_1.text_.text = var_423_11

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_13 = 31 <= 0 and var_423_9 or var_423_9 * (utf8.len(var_423_11) / 31)

				if (31 <= 0 and var_423_9 or var_423_9 * (utf8.len(var_423_11) / 31)) > 0 and var_423_9 < var_423_13 then
					arg_420_1.talkMaxDuration = var_423_13

					if var_423_13 + var_423_8 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_13 + var_423_8
					end
				end

				arg_420_1.text_.text = var_423_11
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051101", "story_v_out_413051.awb") ~= 0 then
					local var_423_14 = manager.audio:GetVoiceLength("story_v_out_413051", "413051101", "story_v_out_413051.awb") / 1000

					if var_423_14 + var_423_8 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_14 + var_423_8
					end

					if var_423_10.prefab_name ~= "" and arg_420_1.actors_[var_423_10.prefab_name] ~= nil then
						local var_423_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_10.prefab_name].transform, "story_v_out_413051", "413051101", "story_v_out_413051.awb")

						arg_420_1:RecordAudio("413051101", var_423_15)
						arg_420_1:RecordAudio("413051101", var_423_15)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_413051", "413051101", "story_v_out_413051.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_413051", "413051101", "story_v_out_413051.awb")
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
				actorName = "10093",
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
	Play413051102 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 413051102
		arg_424_1.duration_ = 10

		local var_424_0 = {
			zh = 10,
			ja = 8.966
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
				arg_424_0:Play413051103(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.var_.moveOldPos10093 = arg_424_1.actors_["10093"].transform.localPosition
				arg_424_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_424_1:CheckSpriteTmpPos("10093", 2)

				for iter_427_0 = 0, arg_424_1.actors_["10093"].transform.childCount - 1 do
					local var_427_0 = arg_424_1.actors_["10093"].transform:GetChild(iter_427_0)

					if var_427_0.name == "split_1" or not string.find(var_427_0.name, "split") then
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

			local var_427_2 = 0
			local var_427_3 = 1.275

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_2 + arg_427_0 then
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

				local var_427_4 = arg_424_1:GetWordFromCfg(413051102)
				local var_427_5 = arg_424_1:FormatText(var_427_4.content)

				arg_424_1.text_.text = var_427_5

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_7 = 51 <= 0 and var_427_3 or var_427_3 * (utf8.len(var_427_5) / 51)

				if (51 <= 0 and var_427_3 or var_427_3 * (utf8.len(var_427_5) / 51)) > 0 and var_427_3 < var_427_7 then
					arg_424_1.talkMaxDuration = var_427_7

					if var_427_7 + var_427_2 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_7 + var_427_2
					end
				end

				arg_424_1.text_.text = var_427_5
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051102", "story_v_out_413051.awb") ~= 0 then
					local var_427_8 = manager.audio:GetVoiceLength("story_v_out_413051", "413051102", "story_v_out_413051.awb") / 1000

					if var_427_8 + var_427_2 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_8 + var_427_2
					end

					if var_427_4.prefab_name ~= "" and arg_424_1.actors_[var_427_4.prefab_name] ~= nil then
						local var_427_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_4.prefab_name].transform, "story_v_out_413051", "413051102", "story_v_out_413051.awb")

						arg_424_1:RecordAudio("413051102", var_427_9)
						arg_424_1:RecordAudio("413051102", var_427_9)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_413051", "413051102", "story_v_out_413051.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_413051", "413051102", "story_v_out_413051.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_10 = math.max(var_427_3, arg_424_1.talkMaxDuration)

			if var_427_2 <= arg_424_1.time_ and arg_424_1.time_ < var_427_2 + var_427_10 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_2) / var_427_10

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_2 + var_427_10 and arg_424_1.time_ < var_427_2 + var_427_10 + arg_427_0 then
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
	Play413051103 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 413051103
		arg_428_1.duration_ = 7.6

		local var_428_0 = {
			zh = 3.566,
			ja = 7.6
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
				arg_428_0:Play413051104(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0.325

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_1 = arg_428_1:GetWordFromCfg(413051103)
				local var_431_2 = arg_428_1:FormatText(var_431_1.content)

				arg_428_1.text_.text = var_431_2

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_4 = 13 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_2) / 13)

				if (13 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_2) / 13)) > 0 and var_431_0 < var_431_4 then
					arg_428_1.talkMaxDuration = var_431_4

					if var_431_4 + 0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_4 + 0
					end
				end

				arg_428_1.text_.text = var_431_2
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051103", "story_v_out_413051.awb") ~= 0 then
					local var_431_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051103", "story_v_out_413051.awb") / 1000

					if var_431_5 + 0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_5 + 0
					end

					if var_431_1.prefab_name ~= "" and arg_428_1.actors_[var_431_1.prefab_name] ~= nil then
						local var_431_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_1.prefab_name].transform, "story_v_out_413051", "413051103", "story_v_out_413051.awb")

						arg_428_1:RecordAudio("413051103", var_431_6)
						arg_428_1:RecordAudio("413051103", var_431_6)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_413051", "413051103", "story_v_out_413051.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_413051", "413051103", "story_v_out_413051.awb")
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
	Play413051104 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 413051104
		arg_432_1.duration_ = 8.1

		local var_432_0 = {
			zh = 4.2,
			ja = 8.1
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
				arg_432_0:Play413051105(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.var_.moveOldPos10022 = arg_432_1.actors_["10022"].transform.localPosition
				arg_432_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_432_1:CheckSpriteTmpPos("10022", 7)

				for iter_435_0 = 0, arg_432_1.actors_["10022"].transform.childCount - 1 do
					local var_435_0 = arg_432_1.actors_["10022"].transform:GetChild(iter_435_0)

					if var_435_0.name == "" or not string.find(var_435_0.name, "split") then
						var_435_0.gameObject:SetActive(true)
					else
						var_435_0.gameObject:SetActive(false)
					end
				end
			end

			local var_435_1 = 0.001

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_1 then
				arg_432_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_432_1.time_ - 0) / var_435_1)
			end

			if arg_432_1.time_ >= 0 + var_435_1 and arg_432_1.time_ < 0 + var_435_1 + arg_435_0 then
				arg_432_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_435_2 = arg_432_1.actors_["10093"].transform

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.var_.moveOldPos10093 = var_435_2.localPosition
				var_435_2.localScale = Vector3.New(1, 1, 1)

				arg_432_1:CheckSpriteTmpPos("10093", 7)

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
				var_435_2.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_432_1.time_ - 0) / var_435_4)
			end

			if arg_432_1.time_ >= 0 + var_435_4 and arg_432_1.time_ < 0 + var_435_4 + arg_435_0 then
				var_435_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_435_5 = arg_432_1.actors_["10092"].transform

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.var_.moveOldPos10092 = var_435_5.localPosition
				var_435_5.localScale = Vector3.New(1, 1, 1)

				arg_432_1:CheckSpriteTmpPos("10092", 3)

				for iter_435_2 = 0, var_435_5.childCount - 1 do
					local var_435_6 = var_435_5:GetChild(iter_435_2)

					if var_435_6.name == "split_2" or not string.find(var_435_6.name, "split") then
						var_435_6.gameObject:SetActive(true)
					else
						var_435_6.gameObject:SetActive(false)
					end
				end
			end

			local var_435_7 = 0.001

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_7 then
				var_435_5.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_432_1.time_ - 0) / var_435_7)
			end

			if arg_432_1.time_ >= 0 + var_435_7 and arg_432_1.time_ < 0 + var_435_7 + arg_435_0 then
				var_435_5.localPosition = Vector3.New(0, -300, -295)
			end

			local var_435_8 = arg_432_1.actors_["10022"]

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(var_435_8) and arg_432_1.var_.actorSpriteComps10022 == nil then
				arg_432_1.var_.actorSpriteComps10022 = var_435_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_9 = 2

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_9 and not isNil(var_435_8) then
				if arg_432_1.var_.actorSpriteComps10022 then
					for iter_435_3, iter_435_4 in pairs(arg_432_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_435_4 then
							if arg_432_1.isInRecall_ then
								iter_435_4.color = Color.New(Mathf.Lerp(iter_435_4.color.r, arg_432_1.hightColor2.r, (arg_432_1.time_ - 0) / var_435_9), Mathf.Lerp(iter_435_4.color.g, arg_432_1.hightColor2.g, (arg_432_1.time_ - 0) / var_435_9), (Mathf.Lerp(iter_435_4.color.b, arg_432_1.hightColor2.b, (arg_432_1.time_ - 0) / var_435_9)))
							else
								local var_435_10 = Mathf.Lerp(iter_435_4.color.r, 0.5, (arg_432_1.time_ - 0) / var_435_9)

								iter_435_4.color = Color.New(var_435_10, var_435_10, var_435_10)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= 0 + var_435_9 and arg_432_1.time_ < 0 + var_435_9 + arg_435_0 and not isNil(var_435_8) and arg_432_1.var_.actorSpriteComps10022 then
				for iter_435_5, iter_435_6 in pairs(arg_432_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_435_6 then
						iter_435_6.color = arg_432_1.isInRecall_ and (arg_432_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_432_1.var_.actorSpriteComps10022 = nil
			end

			local var_435_11 = arg_432_1.actors_["10093"]

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(var_435_11) and arg_432_1.var_.actorSpriteComps10093 == nil then
				arg_432_1.var_.actorSpriteComps10093 = var_435_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_12 = 2

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_12 and not isNil(var_435_11) then
				if arg_432_1.var_.actorSpriteComps10093 then
					for iter_435_7, iter_435_8 in pairs(arg_432_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_435_8 then
							if arg_432_1.isInRecall_ then
								iter_435_8.color = Color.New(Mathf.Lerp(iter_435_8.color.r, arg_432_1.hightColor2.r, (arg_432_1.time_ - 0) / var_435_12), Mathf.Lerp(iter_435_8.color.g, arg_432_1.hightColor2.g, (arg_432_1.time_ - 0) / var_435_12), (Mathf.Lerp(iter_435_8.color.b, arg_432_1.hightColor2.b, (arg_432_1.time_ - 0) / var_435_12)))
							else
								local var_435_13 = Mathf.Lerp(iter_435_8.color.r, 0.5, (arg_432_1.time_ - 0) / var_435_12)

								iter_435_8.color = Color.New(var_435_13, var_435_13, var_435_13)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= 0 + var_435_12 and arg_432_1.time_ < 0 + var_435_12 + arg_435_0 and not isNil(var_435_11) and arg_432_1.var_.actorSpriteComps10093 then
				for iter_435_9, iter_435_10 in pairs(arg_432_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_435_10 then
						iter_435_10.color = arg_432_1.isInRecall_ and (arg_432_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_432_1.var_.actorSpriteComps10093 = nil
			end

			local var_435_14 = arg_432_1.actors_["10092"]

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(var_435_14) and arg_432_1.var_.actorSpriteComps10092 == nil then
				arg_432_1.var_.actorSpriteComps10092 = var_435_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_15 = 2

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_15 and not isNil(var_435_14) then
				if arg_432_1.var_.actorSpriteComps10092 then
					for iter_435_11, iter_435_12 in pairs(arg_432_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_435_12 then
							if arg_432_1.isInRecall_ then
								iter_435_12.color = Color.New(Mathf.Lerp(iter_435_12.color.r, arg_432_1.hightColor1.r, (arg_432_1.time_ - 0) / var_435_15), Mathf.Lerp(iter_435_12.color.g, arg_432_1.hightColor1.g, (arg_432_1.time_ - 0) / var_435_15), (Mathf.Lerp(iter_435_12.color.b, arg_432_1.hightColor1.b, (arg_432_1.time_ - 0) / var_435_15)))
							else
								local var_435_16 = Mathf.Lerp(iter_435_12.color.r, 1, (arg_432_1.time_ - 0) / var_435_15)

								iter_435_12.color = Color.New(var_435_16, var_435_16, var_435_16)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= 0 + var_435_15 and arg_432_1.time_ < 0 + var_435_15 + arg_435_0 and not isNil(var_435_14) and arg_432_1.var_.actorSpriteComps10092 then
				for iter_435_13, iter_435_14 in pairs(arg_432_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_435_14 then
						iter_435_14.color = arg_432_1.isInRecall_ and (arg_432_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_432_1.var_.actorSpriteComps10092 = nil
			end

			local var_435_17 = 0
			local var_435_18 = 0.375

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_17 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_19 = arg_432_1:GetWordFromCfg(413051104)
				local var_435_20 = arg_432_1:FormatText(var_435_19.content)

				arg_432_1.text_.text = var_435_20

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_22 = 15 <= 0 and var_435_18 or var_435_18 * (utf8.len(var_435_20) / 15)

				if (15 <= 0 and var_435_18 or var_435_18 * (utf8.len(var_435_20) / 15)) > 0 and var_435_18 < var_435_22 then
					arg_432_1.talkMaxDuration = var_435_22

					if var_435_22 + var_435_17 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_22 + var_435_17
					end
				end

				arg_432_1.text_.text = var_435_20
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051104", "story_v_out_413051.awb") ~= 0 then
					local var_435_23 = manager.audio:GetVoiceLength("story_v_out_413051", "413051104", "story_v_out_413051.awb") / 1000

					if var_435_23 + var_435_17 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_23 + var_435_17
					end

					if var_435_19.prefab_name ~= "" and arg_432_1.actors_[var_435_19.prefab_name] ~= nil then
						local var_435_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_19.prefab_name].transform, "story_v_out_413051", "413051104", "story_v_out_413051.awb")

						arg_432_1:RecordAudio("413051104", var_435_24)
						arg_432_1:RecordAudio("413051104", var_435_24)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_413051", "413051104", "story_v_out_413051.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_413051", "413051104", "story_v_out_413051.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_25 = math.max(var_435_18, arg_432_1.talkMaxDuration)

			if var_435_17 <= arg_432_1.time_ and arg_432_1.time_ < var_435_17 + var_435_25 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_17) / var_435_25

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_17 + var_435_25 and arg_432_1.time_ < var_435_17 + var_435_25 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
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

		arg_432_1:InitPlayNodeList()
	end,
	Play413051105 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 413051105
		arg_436_1.duration_ = 8.6

		local var_436_0 = {
			zh = 4.5,
			ja = 8.6
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
				arg_436_0:Play413051106(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = 0.6

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
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

				local var_439_1 = arg_436_1:GetWordFromCfg(413051105)
				local var_439_2 = arg_436_1:FormatText(var_439_1.content)

				arg_436_1.text_.text = var_439_2

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_4 = 24 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_2) / 24)

				if (24 <= 0 and var_439_0 or var_439_0 * (utf8.len(var_439_2) / 24)) > 0 and var_439_0 < var_439_4 then
					arg_436_1.talkMaxDuration = var_439_4

					if var_439_4 + 0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_4 + 0
					end
				end

				arg_436_1.text_.text = var_439_2
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051105", "story_v_out_413051.awb") ~= 0 then
					local var_439_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051105", "story_v_out_413051.awb") / 1000

					if var_439_5 + 0 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_5 + 0
					end

					if var_439_1.prefab_name ~= "" and arg_436_1.actors_[var_439_1.prefab_name] ~= nil then
						local var_439_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_1.prefab_name].transform, "story_v_out_413051", "413051105", "story_v_out_413051.awb")

						arg_436_1:RecordAudio("413051105", var_439_6)
						arg_436_1:RecordAudio("413051105", var_439_6)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_out_413051", "413051105", "story_v_out_413051.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_out_413051", "413051105", "story_v_out_413051.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_7 = math.max(var_439_0, arg_436_1.talkMaxDuration)

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_7 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - 0) / var_439_7

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= 0 + var_439_7 and arg_436_1.time_ < 0 + var_439_7 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play413051106 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 413051106
		arg_440_1.duration_ = 6.47

		local var_440_0 = {
			zh = 5.733,
			ja = 6.466
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
				arg_440_0:Play413051107(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos10093 = arg_440_1.actors_["10093"].transform.localPosition
				arg_440_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_440_1:CheckSpriteTmpPos("10093", 3)

				for iter_443_0 = 0, arg_440_1.actors_["10093"].transform.childCount - 1 do
					local var_443_0 = arg_440_1.actors_["10093"].transform:GetChild(iter_443_0)

					if var_443_0.name == "split_4" or not string.find(var_443_0.name, "split") then
						var_443_0.gameObject:SetActive(true)
					else
						var_443_0.gameObject:SetActive(false)
					end
				end
			end

			local var_443_1 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_1 then
				arg_440_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_440_1.time_ - 0) / var_443_1)
			end

			if arg_440_1.time_ >= 0 + var_443_1 and arg_440_1.time_ < 0 + var_443_1 + arg_443_0 then
				arg_440_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_443_2 = arg_440_1.actors_["10092"].transform

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.var_.moveOldPos10092 = var_443_2.localPosition
				var_443_2.localScale = Vector3.New(1, 1, 1)

				arg_440_1:CheckSpriteTmpPos("10092", 7)

				for iter_443_1 = 0, var_443_2.childCount - 1 do
					local var_443_3 = var_443_2:GetChild(iter_443_1)

					if var_443_3.name == "split_6" or not string.find(var_443_3.name, "split") then
						var_443_3.gameObject:SetActive(true)
					else
						var_443_3.gameObject:SetActive(false)
					end
				end
			end

			local var_443_4 = 0.001

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_4 then
				var_443_2.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_440_1.time_ - 0) / var_443_4)
			end

			if arg_440_1.time_ >= 0 + var_443_4 and arg_440_1.time_ < 0 + var_443_4 + arg_443_0 then
				var_443_2.localPosition = Vector3.New(0, -2000, 0)
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

			local var_443_8 = arg_440_1.actors_["10092"]

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 and not isNil(var_443_8) and arg_440_1.var_.actorSpriteComps10092 == nil then
				arg_440_1.var_.actorSpriteComps10092 = var_443_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_443_9 = 2

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_9 and not isNil(var_443_8) then
				if arg_440_1.var_.actorSpriteComps10092 then
					for iter_443_6, iter_443_7 in pairs(arg_440_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_440_1.time_ >= 0 + var_443_9 and arg_440_1.time_ < 0 + var_443_9 + arg_443_0 and not isNil(var_443_8) and arg_440_1.var_.actorSpriteComps10092 then
				for iter_443_8, iter_443_9 in pairs(arg_440_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_443_9 then
						iter_443_9.color = arg_440_1.isInRecall_ and (arg_440_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_440_1.var_.actorSpriteComps10092 = nil
			end

			local var_443_11 = 0
			local var_443_12 = 0.625

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

				local var_443_13 = arg_440_1:GetWordFromCfg(413051106)
				local var_443_14 = arg_440_1:FormatText(var_443_13.content)

				arg_440_1.text_.text = var_443_14

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_16 = 25 <= 0 and var_443_12 or var_443_12 * (utf8.len(var_443_14) / 25)

				if (25 <= 0 and var_443_12 or var_443_12 * (utf8.len(var_443_14) / 25)) > 0 and var_443_12 < var_443_16 then
					arg_440_1.talkMaxDuration = var_443_16

					if var_443_16 + var_443_11 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_16 + var_443_11
					end
				end

				arg_440_1.text_.text = var_443_14
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051106", "story_v_out_413051.awb") ~= 0 then
					local var_443_17 = manager.audio:GetVoiceLength("story_v_out_413051", "413051106", "story_v_out_413051.awb") / 1000

					if var_443_17 + var_443_11 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_17 + var_443_11
					end

					if var_443_13.prefab_name ~= "" and arg_440_1.actors_[var_443_13.prefab_name] ~= nil then
						local var_443_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_13.prefab_name].transform, "story_v_out_413051", "413051106", "story_v_out_413051.awb")

						arg_440_1:RecordAudio("413051106", var_443_18)
						arg_440_1:RecordAudio("413051106", var_443_18)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_413051", "413051106", "story_v_out_413051.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_413051", "413051106", "story_v_out_413051.awb")
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
				actorName = "10092",
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
	Play413051107 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 413051107
		arg_444_1.duration_ = 8.73

		local var_444_0 = {
			zh = 6.633,
			ja = 8.733
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
				arg_444_0:Play413051108(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.var_.moveOldPos10022 = arg_444_1.actors_["10022"].transform.localPosition
				arg_444_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_444_1:CheckSpriteTmpPos("10022", 3)

				for iter_447_0 = 0, arg_444_1.actors_["10022"].transform.childCount - 1 do
					local var_447_0 = arg_444_1.actors_["10022"].transform:GetChild(iter_447_0)

					if var_447_0.name == "split_6" or not string.find(var_447_0.name, "split") then
						var_447_0.gameObject:SetActive(true)
					else
						var_447_0.gameObject:SetActive(false)
					end
				end
			end

			local var_447_1 = 0.001

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_1 then
				arg_444_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_444_1.time_ - 0) / var_447_1)
			end

			if arg_444_1.time_ >= 0 + var_447_1 and arg_444_1.time_ < 0 + var_447_1 + arg_447_0 then
				arg_444_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_447_2 = arg_444_1.actors_["10022"]

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 and not isNil(var_447_2) and arg_444_1.var_.actorSpriteComps10022 == nil then
				arg_444_1.var_.actorSpriteComps10022 = var_447_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_447_3 = 2

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_3 and not isNil(var_447_2) then
				if arg_444_1.var_.actorSpriteComps10022 then
					for iter_447_1, iter_447_2 in pairs(arg_444_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_444_1.time_ >= 0 + var_447_3 and arg_444_1.time_ < 0 + var_447_3 + arg_447_0 and not isNil(var_447_2) and arg_444_1.var_.actorSpriteComps10022 then
				for iter_447_3, iter_447_4 in pairs(arg_444_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_447_4 then
						iter_447_4.color = arg_444_1.isInRecall_ and (arg_444_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_444_1.var_.actorSpriteComps10022 = nil
			end

			local var_447_5 = 0
			local var_447_6 = 0.75

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_5 + arg_447_0 then
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

				local var_447_7 = arg_444_1:GetWordFromCfg(413051107)
				local var_447_8 = arg_444_1:FormatText(var_447_7.content)

				arg_444_1.text_.text = var_447_8

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_10 = 30 <= 0 and var_447_6 or var_447_6 * (utf8.len(var_447_8) / 30)

				if (30 <= 0 and var_447_6 or var_447_6 * (utf8.len(var_447_8) / 30)) > 0 and var_447_6 < var_447_10 then
					arg_444_1.talkMaxDuration = var_447_10

					if var_447_10 + var_447_5 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_10 + var_447_5
					end
				end

				arg_444_1.text_.text = var_447_8
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051107", "story_v_out_413051.awb") ~= 0 then
					local var_447_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051107", "story_v_out_413051.awb") / 1000

					if var_447_11 + var_447_5 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_11 + var_447_5
					end

					if var_447_7.prefab_name ~= "" and arg_444_1.actors_[var_447_7.prefab_name] ~= nil then
						local var_447_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_7.prefab_name].transform, "story_v_out_413051", "413051107", "story_v_out_413051.awb")

						arg_444_1:RecordAudio("413051107", var_447_12)
						arg_444_1:RecordAudio("413051107", var_447_12)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_out_413051", "413051107", "story_v_out_413051.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_out_413051", "413051107", "story_v_out_413051.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_13 = math.max(var_447_6, arg_444_1.talkMaxDuration)

			if var_447_5 <= arg_444_1.time_ and arg_444_1.time_ < var_447_5 + var_447_13 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_5) / var_447_13

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_5 + var_447_13 and arg_444_1.time_ < var_447_5 + var_447_13 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
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
	Play413051108 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 413051108
		arg_448_1.duration_ = 6.73

		local var_448_0 = {
			zh = 6.1,
			ja = 6.733
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
				arg_448_0:Play413051109(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			if 2 < arg_448_1.time_ and arg_448_1.time_ <= 2 + arg_451_0 then
				local var_451_0 = arg_448_1.bgs_.F08i

				arg_448_1.bgs_.F08i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_451_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_451_1 = var_451_0:GetComponent("SpriteRenderer")

				if var_451_1 and var_451_1.sprite then
					local var_451_2 = 2 * (var_451_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_451_0.transform.localScale = Vector3.New(var_451_2 / var_451_1.sprite.bounds.size.y < var_451_2 * manager.ui.mainCameraCom_.aspect / var_451_1.sprite.bounds.size.x and var_451_2 * manager.ui.mainCameraCom_.aspect / var_451_1.sprite.bounds.size.x or var_451_2 / var_451_1.sprite.bounds.size.y, var_451_2 / var_451_1.sprite.bounds.size.y < var_451_2 * manager.ui.mainCameraCom_.aspect / var_451_1.sprite.bounds.size.x and var_451_2 * manager.ui.mainCameraCom_.aspect / var_451_1.sprite.bounds.size.x or var_451_2 / var_451_1.sprite.bounds.size.y, 0)
				end

				for iter_451_0, iter_451_1 in pairs(arg_448_1.bgs_) do
					if iter_451_0 ~= "F08i" then
						iter_451_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_451_3 = 4

			if 4 < arg_448_1.time_ and arg_448_1.time_ <= var_451_3 + arg_451_0 then
				arg_448_1.allBtn_.enabled = false
			end

			if arg_448_1.time_ >= var_451_3 + 0.3 and arg_448_1.time_ < var_451_3 + 0.3 + arg_451_0 then
				arg_448_1.allBtn_.enabled = true
			end

			local var_451_4 = 0

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= var_451_4 + arg_451_0 then
				arg_448_1.mask_.enabled = true
				arg_448_1.mask_.raycastTarget = true

				arg_448_1:SetGaussion(false)
			end

			local var_451_5 = 2

			if var_451_4 <= arg_448_1.time_ and arg_448_1.time_ < var_451_4 + var_451_5 then
				local var_451_6 = Color.New(0, 0, 0)

				var_451_6.a = Mathf.Lerp(0, 1, (arg_448_1.time_ - var_451_4) / var_451_5)
				arg_448_1.mask_.color = var_451_6
			end

			if arg_448_1.time_ >= var_451_4 + var_451_5 and arg_448_1.time_ < var_451_4 + var_451_5 + arg_451_0 then
				local var_451_7 = Color.New(0, 0, 0)

				var_451_7.a = 1
				arg_448_1.mask_.color = var_451_7
			end

			local var_451_8 = 2

			if 2 < arg_448_1.time_ and arg_448_1.time_ <= var_451_8 + arg_451_0 then
				arg_448_1.mask_.enabled = true
				arg_448_1.mask_.raycastTarget = true

				arg_448_1:SetGaussion(false)
			end

			local var_451_9 = 2

			if var_451_8 <= arg_448_1.time_ and arg_448_1.time_ < var_451_8 + var_451_9 then
				local var_451_10 = Color.New(0, 0, 0)

				var_451_10.a = Mathf.Lerp(1, 0, (arg_448_1.time_ - var_451_8) / var_451_9)
				arg_448_1.mask_.color = var_451_10
			end

			if arg_448_1.time_ >= var_451_8 + var_451_9 and arg_448_1.time_ < var_451_8 + var_451_9 + arg_451_0 then
				local var_451_11 = Color.New(0, 0, 0)

				arg_448_1.mask_.enabled = false
				var_451_11.a = 0
				arg_448_1.mask_.color = var_451_11
			end

			local var_451_12 = arg_448_1.actors_["10022"].transform

			if 1.966 < arg_448_1.time_ and arg_448_1.time_ <= 1.966 + arg_451_0 then
				arg_448_1.var_.moveOldPos10022 = var_451_12.localPosition
				var_451_12.localScale = Vector3.New(1, 1, 1)

				arg_448_1:CheckSpriteTmpPos("10022", 0)

				for iter_451_2 = 0, var_451_12.childCount - 1 do
					local var_451_13 = var_451_12:GetChild(iter_451_2)

					if var_451_13.name == "" or not string.find(var_451_13.name, "split") then
						var_451_13.gameObject:SetActive(true)
					else
						var_451_13.gameObject:SetActive(false)
					end
				end
			end

			local var_451_14 = 0.001

			if 1.966 <= arg_448_1.time_ and arg_448_1.time_ < 1.966 + var_451_14 then
				var_451_12.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_448_1.time_ - 1.966) / var_451_14)
			end

			if arg_448_1.time_ >= 1.966 + var_451_14 and arg_448_1.time_ < 1.966 + var_451_14 + arg_451_0 then
				var_451_12.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_451_15 = "10096"

			if arg_448_1.actors_["10096"] == nil then
				local var_451_16 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10096")

				if not isNil(var_451_16) then
					local var_451_17 = Object.Instantiate(var_451_16, arg_448_1.canvasGo_.transform)

					var_451_17.transform:SetSiblingIndex(1)

					var_451_17.name = var_451_15
					var_451_17.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_448_1.actors_[var_451_15] = var_451_17

					if arg_448_1.isInRecall_ then
						for iter_451_3, iter_451_4 in ipairs((var_451_17:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_451_4.color = arg_448_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_451_18 = arg_448_1.actors_["10096"].transform

			if 3.8 < arg_448_1.time_ and arg_448_1.time_ <= 3.8 + arg_451_0 then
				arg_448_1.var_.moveOldPos10096 = var_451_18.localPosition
				var_451_18.localScale = Vector3.New(1, 1, 1)

				arg_448_1:CheckSpriteTmpPos("10096", 2)

				for iter_451_5 = 0, var_451_18.childCount - 1 do
					local var_451_19 = var_451_18:GetChild(iter_451_5)

					if var_451_19.name == "" or not string.find(var_451_19.name, "split") then
						var_451_19.gameObject:SetActive(true)
					else
						var_451_19.gameObject:SetActive(false)
					end
				end
			end

			local var_451_20 = 0.001

			if 3.8 <= arg_448_1.time_ and arg_448_1.time_ < 3.8 + var_451_20 then
				var_451_18.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos10096, Vector3.New(-390, -350, -210), (arg_448_1.time_ - 3.8) / var_451_20)
			end

			if arg_448_1.time_ >= 3.8 + var_451_20 and arg_448_1.time_ < 3.8 + var_451_20 + arg_451_0 then
				var_451_18.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_451_21 = arg_448_1.actors_["10022"]

			if 1.966 < arg_448_1.time_ and arg_448_1.time_ <= 1.966 + arg_451_0 and not isNil(var_451_21) and arg_448_1.var_.actorSpriteComps10022 == nil then
				arg_448_1.var_.actorSpriteComps10022 = var_451_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_22 = 0.034

			if 1.966 <= arg_448_1.time_ and arg_448_1.time_ < 1.966 + var_451_22 and not isNil(var_451_21) then
				if arg_448_1.var_.actorSpriteComps10022 then
					for iter_451_6, iter_451_7 in pairs(arg_448_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_451_7 then
							if arg_448_1.isInRecall_ then
								iter_451_7.color = Color.New(Mathf.Lerp(iter_451_7.color.r, arg_448_1.hightColor2.r, (arg_448_1.time_ - 1.966) / var_451_22), Mathf.Lerp(iter_451_7.color.g, arg_448_1.hightColor2.g, (arg_448_1.time_ - 1.966) / var_451_22), (Mathf.Lerp(iter_451_7.color.b, arg_448_1.hightColor2.b, (arg_448_1.time_ - 1.966) / var_451_22)))
							else
								local var_451_23 = Mathf.Lerp(iter_451_7.color.r, 0.5, (arg_448_1.time_ - 1.966) / var_451_22)

								iter_451_7.color = Color.New(var_451_23, var_451_23, var_451_23)
							end
						end
					end
				end
			end

			if arg_448_1.time_ >= 1.966 + var_451_22 and arg_448_1.time_ < 1.966 + var_451_22 + arg_451_0 and not isNil(var_451_21) and arg_448_1.var_.actorSpriteComps10022 then
				for iter_451_8, iter_451_9 in pairs(arg_448_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_451_9 then
						iter_451_9.color = arg_448_1.isInRecall_ and (arg_448_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_448_1.var_.actorSpriteComps10022 = nil
			end

			local var_451_24 = arg_448_1.actors_["10096"]

			if 3.8 < arg_448_1.time_ and arg_448_1.time_ <= 3.8 + arg_451_0 and not isNil(var_451_24) and arg_448_1.var_.actorSpriteComps10096 == nil then
				arg_448_1.var_.actorSpriteComps10096 = var_451_24:GetComponentsInChildren(typeof(Image), true)
			end

			local var_451_25 = 2

			if 3.8 <= arg_448_1.time_ and arg_448_1.time_ < 3.8 + var_451_25 and not isNil(var_451_24) then
				if arg_448_1.var_.actorSpriteComps10096 then
					for iter_451_10, iter_451_11 in pairs(arg_448_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_451_11 then
							if arg_448_1.isInRecall_ then
								iter_451_11.color = Color.New(Mathf.Lerp(iter_451_11.color.r, arg_448_1.hightColor1.r, (arg_448_1.time_ - 3.8) / var_451_25), Mathf.Lerp(iter_451_11.color.g, arg_448_1.hightColor1.g, (arg_448_1.time_ - 3.8) / var_451_25), (Mathf.Lerp(iter_451_11.color.b, arg_448_1.hightColor1.b, (arg_448_1.time_ - 3.8) / var_451_25)))
							else
								local var_451_26 = Mathf.Lerp(iter_451_11.color.r, 1, (arg_448_1.time_ - 3.8) / var_451_25)

								iter_451_11.color = Color.New(var_451_26, var_451_26, var_451_26)
							end
						end
					end
				end
			end

			if arg_448_1.time_ >= 3.8 + var_451_25 and arg_448_1.time_ < 3.8 + var_451_25 + arg_451_0 and not isNil(var_451_24) and arg_448_1.var_.actorSpriteComps10096 then
				for iter_451_12, iter_451_13 in pairs(arg_448_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_451_13 then
						iter_451_13.color = arg_448_1.isInRecall_ and (arg_448_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_448_1.var_.actorSpriteComps10096 = nil
			end

			if 3.8 < arg_448_1.time_ and arg_448_1.time_ <= 3.8 + arg_451_0 then
				local var_451_27 = arg_448_1.actors_["10096"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_451_27 then
					arg_448_1.var_.alphaOldValue10096 = var_451_27.alpha
					arg_448_1.var_.characterEffect10096 = var_451_27
				end

				arg_448_1.var_.alphaOldValue10096 = 0
			end

			local var_451_28 = 0.5

			if 3.8 <= arg_448_1.time_ and arg_448_1.time_ < 3.8 + var_451_28 then
				if arg_448_1.var_.characterEffect10096 then
					arg_448_1.var_.characterEffect10096.alpha = Mathf.Lerp(arg_448_1.var_.alphaOldValue10096, 1, (arg_448_1.time_ - 3.8) / var_451_28)
				end
			end

			if arg_448_1.time_ >= 3.8 + var_451_28 and arg_448_1.time_ < 3.8 + var_451_28 + arg_451_0 and arg_448_1.var_.characterEffect10096 then
				arg_448_1.var_.characterEffect10096.alpha = 1
			end

			if 1.966 < arg_448_1.time_ and arg_448_1.time_ <= 1.966 + arg_451_0 then
				arg_448_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_451_31 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_448_1.bgmTxt_.text ~= var_451_31 and arg_448_1.bgmTxt_.text ~= "" then
						if arg_448_1.bgmTxt2_.text ~= "" then
							arg_448_1.bgmTxt_.text = arg_448_1.bgmTxt2_.text
						end

						arg_448_1.bgmTxt2_.text = var_451_31

						arg_448_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_448_1.bgmTxt_.text = var_451_31
						arg_448_1.bgmTxt2_.text = var_451_31
					end

					if arg_448_1.bgmTimer then
						arg_448_1.bgmTimer:Stop()

						arg_448_1.bgmTimer = nil
					end

					if arg_448_1.settingData.show_music_name == 1 then
						arg_448_1.musicController:SetSelectedState("show")
						arg_448_1.musicAnimator_:Play("open", 0, 0)

						if arg_448_1.settingData.music_time ~= 0 then
							arg_448_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_448_1.settingData.music_time), function()
								if arg_448_1 == nil or isNil(arg_448_1.bgmTxt_) then
									return
								end

								arg_448_1.musicController:SetSelectedState("hide")
								arg_448_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_448_1.frameCnt_ <= 1 then
				arg_448_1.dialog_:SetActive(false)
			end

			local var_451_32 = 4
			local var_451_33 = 0.125

			if 4 < arg_448_1.time_ and arg_448_1.time_ <= var_451_32 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0

				arg_448_1.dialog_:SetActive(true)

				arg_448_1.dialogCg_.alpha = 0

				local var_451_34 = LeanTween.value(arg_448_1.dialog_, 0, 1, 0.3)

				var_451_34:setOnUpdate(LuaHelper.FloatAction(function(arg_453_0)
					arg_448_1.dialogCg_.alpha = arg_453_0
				end))
				var_451_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_448_1.dialog_)
					var_451_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_448_1.duration_ = arg_448_1.duration_ + 0.3

				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_35 = arg_448_1:GetWordFromCfg(413051108)
				local var_451_36 = arg_448_1:FormatText(var_451_35.content)

				arg_448_1.text_.text = var_451_36

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_38 = 5 <= 0 and var_451_33 or var_451_33 * (utf8.len(var_451_36) / 5)

				if (5 <= 0 and var_451_33 or var_451_33 * (utf8.len(var_451_36) / 5)) > 0 and var_451_33 < var_451_38 then
					arg_448_1.talkMaxDuration = var_451_38
					var_451_32 = var_451_32 + 0.3

					if var_451_38 + var_451_32 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_38 + var_451_32
					end
				end

				arg_448_1.text_.text = var_451_36
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051108", "story_v_out_413051.awb") ~= 0 then
					local var_451_39 = manager.audio:GetVoiceLength("story_v_out_413051", "413051108", "story_v_out_413051.awb") / 1000

					if var_451_39 + var_451_32 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_39 + var_451_32
					end

					if var_451_35.prefab_name ~= "" and arg_448_1.actors_[var_451_35.prefab_name] ~= nil then
						local var_451_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_35.prefab_name].transform, "story_v_out_413051", "413051108", "story_v_out_413051.awb")

						arg_448_1:RecordAudio("413051108", var_451_40)
						arg_448_1:RecordAudio("413051108", var_451_40)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_413051", "413051108", "story_v_out_413051.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_413051", "413051108", "story_v_out_413051.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_41 = var_451_32 + 0.3
			local var_451_42 = math.max(var_451_33, arg_448_1.talkMaxDuration)

			if var_451_32 + 0.3 <= arg_448_1.time_ and arg_448_1.time_ < var_451_41 + var_451_42 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_41) / var_451_42

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_41 + var_451_42 and arg_448_1.time_ < var_451_41 + var_451_42 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
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
				actorName = "10096",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_448_1:InitPlayNodeList()
	end,
	Play413051109 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 413051109
		arg_455_1.duration_ = 5.6

		local var_455_0 = {
			zh = 4.866,
			ja = 5.6
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play413051110(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.var_.moveOldPos10096 = arg_455_1.actors_["10096"].transform.localPosition
				arg_455_1.actors_["10096"].transform.localScale = Vector3.New(1, 1, 1)

				arg_455_1:CheckSpriteTmpPos("10096", 2)

				for iter_458_0 = 0, arg_455_1.actors_["10096"].transform.childCount - 1 do
					local var_458_0 = arg_455_1.actors_["10096"].transform:GetChild(iter_458_0)

					if var_458_0.name == "" or not string.find(var_458_0.name, "split") then
						var_458_0.gameObject:SetActive(true)
					else
						var_458_0.gameObject:SetActive(false)
					end
				end
			end

			local var_458_1 = 0.001

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_1 then
				arg_455_1.actors_["10096"].transform.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos10096, Vector3.New(-390, -350, -210), (arg_455_1.time_ - 0) / var_458_1)
			end

			if arg_455_1.time_ >= 0 + var_458_1 and arg_455_1.time_ < 0 + var_458_1 + arg_458_0 then
				arg_455_1.actors_["10096"].transform.localPosition = Vector3.New(-390, -350, -210)
			end

			local var_458_2 = "10095"

			if arg_455_1.actors_["10095"] == nil then
				local var_458_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10095")

				if not isNil(var_458_3) then
					local var_458_4 = Object.Instantiate(var_458_3, arg_455_1.canvasGo_.transform)

					var_458_4.transform:SetSiblingIndex(1)

					var_458_4.name = var_458_2
					var_458_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_455_1.actors_[var_458_2] = var_458_4

					if arg_455_1.isInRecall_ then
						for iter_458_1, iter_458_2 in ipairs((var_458_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_458_2.color = arg_455_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_458_5 = arg_455_1.actors_["10095"].transform

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				arg_455_1.var_.moveOldPos10095 = var_458_5.localPosition
				var_458_5.localScale = Vector3.New(1, 1, 1)

				arg_455_1:CheckSpriteTmpPos("10095", 4)

				for iter_458_3 = 0, var_458_5.childCount - 1 do
					local var_458_6 = var_458_5:GetChild(iter_458_3)

					if var_458_6.name == "" or not string.find(var_458_6.name, "split") then
						var_458_6.gameObject:SetActive(true)
					else
						var_458_6.gameObject:SetActive(false)
					end
				end
			end

			local var_458_7 = 0.001

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_7 then
				var_458_5.localPosition = Vector3.Lerp(arg_455_1.var_.moveOldPos10095, Vector3.New(390, -405, -10), (arg_455_1.time_ - 0) / var_458_7)
			end

			if arg_455_1.time_ >= 0 + var_458_7 and arg_455_1.time_ < 0 + var_458_7 + arg_458_0 then
				var_458_5.localPosition = Vector3.New(390, -405, -10)
			end

			local var_458_8 = arg_455_1.actors_["10096"]

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(var_458_8) and arg_455_1.var_.actorSpriteComps10096 == nil then
				arg_455_1.var_.actorSpriteComps10096 = var_458_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_458_9 = 2

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_9 and not isNil(var_458_8) then
				if arg_455_1.var_.actorSpriteComps10096 then
					for iter_458_4, iter_458_5 in pairs(arg_455_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_458_5 then
							if arg_455_1.isInRecall_ then
								iter_458_5.color = Color.New(Mathf.Lerp(iter_458_5.color.r, arg_455_1.hightColor2.r, (arg_455_1.time_ - 0) / var_458_9), Mathf.Lerp(iter_458_5.color.g, arg_455_1.hightColor2.g, (arg_455_1.time_ - 0) / var_458_9), (Mathf.Lerp(iter_458_5.color.b, arg_455_1.hightColor2.b, (arg_455_1.time_ - 0) / var_458_9)))
							else
								local var_458_10 = Mathf.Lerp(iter_458_5.color.r, 0.5, (arg_455_1.time_ - 0) / var_458_9)

								iter_458_5.color = Color.New(var_458_10, var_458_10, var_458_10)
							end
						end
					end
				end
			end

			if arg_455_1.time_ >= 0 + var_458_9 and arg_455_1.time_ < 0 + var_458_9 + arg_458_0 and not isNil(var_458_8) and arg_455_1.var_.actorSpriteComps10096 then
				for iter_458_6, iter_458_7 in pairs(arg_455_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_458_7 then
						iter_458_7.color = arg_455_1.isInRecall_ and (arg_455_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_455_1.var_.actorSpriteComps10096 = nil
			end

			local var_458_11 = arg_455_1.actors_["10095"]

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 and not isNil(var_458_11) and arg_455_1.var_.actorSpriteComps10095 == nil then
				arg_455_1.var_.actorSpriteComps10095 = var_458_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_458_12 = 2

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_12 and not isNil(var_458_11) then
				if arg_455_1.var_.actorSpriteComps10095 then
					for iter_458_8, iter_458_9 in pairs(arg_455_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_458_9 then
							if arg_455_1.isInRecall_ then
								iter_458_9.color = Color.New(Mathf.Lerp(iter_458_9.color.r, arg_455_1.hightColor1.r, (arg_455_1.time_ - 0) / var_458_12), Mathf.Lerp(iter_458_9.color.g, arg_455_1.hightColor1.g, (arg_455_1.time_ - 0) / var_458_12), (Mathf.Lerp(iter_458_9.color.b, arg_455_1.hightColor1.b, (arg_455_1.time_ - 0) / var_458_12)))
							else
								local var_458_13 = Mathf.Lerp(iter_458_9.color.r, 1, (arg_455_1.time_ - 0) / var_458_12)

								iter_458_9.color = Color.New(var_458_13, var_458_13, var_458_13)
							end
						end
					end
				end
			end

			if arg_455_1.time_ >= 0 + var_458_12 and arg_455_1.time_ < 0 + var_458_12 + arg_458_0 and not isNil(var_458_11) and arg_455_1.var_.actorSpriteComps10095 then
				for iter_458_10, iter_458_11 in pairs(arg_455_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_458_11 then
						iter_458_11.color = arg_455_1.isInRecall_ and (arg_455_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_455_1.var_.actorSpriteComps10095 = nil
			end

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= 0 + arg_458_0 then
				local var_458_14 = arg_455_1.actors_["10095"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_458_14 then
					arg_455_1.var_.alphaOldValue10095 = var_458_14.alpha
					arg_455_1.var_.characterEffect10095 = var_458_14
				end

				arg_455_1.var_.alphaOldValue10095 = 0
			end

			local var_458_15 = 0.5

			if 0 <= arg_455_1.time_ and arg_455_1.time_ < 0 + var_458_15 then
				if arg_455_1.var_.characterEffect10095 then
					arg_455_1.var_.characterEffect10095.alpha = Mathf.Lerp(arg_455_1.var_.alphaOldValue10095, 1, (arg_455_1.time_ - 0) / var_458_15)
				end
			end

			if arg_455_1.time_ >= 0 + var_458_15 and arg_455_1.time_ < 0 + var_458_15 + arg_458_0 and arg_455_1.var_.characterEffect10095 then
				arg_455_1.var_.characterEffect10095.alpha = 1
			end

			local var_458_16 = 0
			local var_458_17 = 0.325

			if 0 < arg_455_1.time_ and arg_455_1.time_ <= var_458_16 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				arg_455_1.leftNameTxt_.text = arg_455_1:FormatText(StoryNameCfg[1002].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, false)
				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_18 = arg_455_1:GetWordFromCfg(413051109)
				local var_458_19 = arg_455_1:FormatText(var_458_18.content)

				arg_455_1.text_.text = var_458_19

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_21 = 13 <= 0 and var_458_17 or var_458_17 * (utf8.len(var_458_19) / 13)

				if (13 <= 0 and var_458_17 or var_458_17 * (utf8.len(var_458_19) / 13)) > 0 and var_458_17 < var_458_21 then
					arg_455_1.talkMaxDuration = var_458_21

					if var_458_21 + var_458_16 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_21 + var_458_16
					end
				end

				arg_455_1.text_.text = var_458_19
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051109", "story_v_out_413051.awb") ~= 0 then
					local var_458_22 = manager.audio:GetVoiceLength("story_v_out_413051", "413051109", "story_v_out_413051.awb") / 1000

					if var_458_22 + var_458_16 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_22 + var_458_16
					end

					if var_458_18.prefab_name ~= "" and arg_455_1.actors_[var_458_18.prefab_name] ~= nil then
						local var_458_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_18.prefab_name].transform, "story_v_out_413051", "413051109", "story_v_out_413051.awb")

						arg_455_1:RecordAudio("413051109", var_458_23)
						arg_455_1:RecordAudio("413051109", var_458_23)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_413051", "413051109", "story_v_out_413051.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_413051", "413051109", "story_v_out_413051.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_24 = math.max(var_458_17, arg_455_1.talkMaxDuration)

			if var_458_16 <= arg_455_1.time_ and arg_455_1.time_ < var_458_16 + var_458_24 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_16) / var_458_24

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_16 + var_458_24 and arg_455_1.time_ < var_458_16 + var_458_24 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end

		arg_455_1.nodeConfigList_ = {
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
				actorName = "10095",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_455_1:InitPlayNodeList()
	end,
	Play413051110 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 413051110
		arg_459_1.duration_ = 12.8

		local var_459_0 = {
			zh = 5.7,
			ja = 12.8
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play413051111(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(arg_459_1.actors_["10096"]) and arg_459_1.var_.actorSpriteComps10096 == nil then
				arg_459_1.var_.actorSpriteComps10096 = arg_459_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_462_0 = 2

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_0 and not isNil(arg_459_1.actors_["10096"]) then
				if arg_459_1.var_.actorSpriteComps10096 then
					for iter_462_0, iter_462_1 in pairs(arg_459_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_462_1 then
							if arg_459_1.isInRecall_ then
								iter_462_1.color = Color.New(Mathf.Lerp(iter_462_1.color.r, arg_459_1.hightColor1.r, (arg_459_1.time_ - 0) / var_462_0), Mathf.Lerp(iter_462_1.color.g, arg_459_1.hightColor1.g, (arg_459_1.time_ - 0) / var_462_0), (Mathf.Lerp(iter_462_1.color.b, arg_459_1.hightColor1.b, (arg_459_1.time_ - 0) / var_462_0)))
							else
								local var_462_1 = Mathf.Lerp(iter_462_1.color.r, 1, (arg_459_1.time_ - 0) / var_462_0)

								iter_462_1.color = Color.New(var_462_1, var_462_1, var_462_1)
							end
						end
					end
				end
			end

			if arg_459_1.time_ >= 0 + var_462_0 and arg_459_1.time_ < 0 + var_462_0 + arg_462_0 and not isNil(arg_459_1.actors_["10096"]) and arg_459_1.var_.actorSpriteComps10096 then
				for iter_462_2, iter_462_3 in pairs(arg_459_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_462_3 then
						iter_462_3.color = arg_459_1.isInRecall_ and (arg_459_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_459_1.var_.actorSpriteComps10096 = nil
			end

			local var_462_2 = arg_459_1.actors_["10095"]

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= 0 + arg_462_0 and not isNil(var_462_2) and arg_459_1.var_.actorSpriteComps10095 == nil then
				arg_459_1.var_.actorSpriteComps10095 = var_462_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_462_3 = 2

			if 0 <= arg_459_1.time_ and arg_459_1.time_ < 0 + var_462_3 and not isNil(var_462_2) then
				if arg_459_1.var_.actorSpriteComps10095 then
					for iter_462_4, iter_462_5 in pairs(arg_459_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_462_5 then
							if arg_459_1.isInRecall_ then
								iter_462_5.color = Color.New(Mathf.Lerp(iter_462_5.color.r, arg_459_1.hightColor2.r, (arg_459_1.time_ - 0) / var_462_3), Mathf.Lerp(iter_462_5.color.g, arg_459_1.hightColor2.g, (arg_459_1.time_ - 0) / var_462_3), (Mathf.Lerp(iter_462_5.color.b, arg_459_1.hightColor2.b, (arg_459_1.time_ - 0) / var_462_3)))
							else
								local var_462_4 = Mathf.Lerp(iter_462_5.color.r, 0.5, (arg_459_1.time_ - 0) / var_462_3)

								iter_462_5.color = Color.New(var_462_4, var_462_4, var_462_4)
							end
						end
					end
				end
			end

			if arg_459_1.time_ >= 0 + var_462_3 and arg_459_1.time_ < 0 + var_462_3 + arg_462_0 and not isNil(var_462_2) and arg_459_1.var_.actorSpriteComps10095 then
				for iter_462_6, iter_462_7 in pairs(arg_459_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_462_7 then
						iter_462_7.color = arg_459_1.isInRecall_ and (arg_459_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_459_1.var_.actorSpriteComps10095 = nil
			end

			local var_462_5 = 0
			local var_462_6 = 0.55

			if 0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_5 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				arg_459_1.leftNameTxt_.text = arg_459_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, false)
				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_7 = arg_459_1:GetWordFromCfg(413051110)
				local var_462_8 = arg_459_1:FormatText(var_462_7.content)

				arg_459_1.text_.text = var_462_8

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_10 = 22 <= 0 and var_462_6 or var_462_6 * (utf8.len(var_462_8) / 22)

				if (22 <= 0 and var_462_6 or var_462_6 * (utf8.len(var_462_8) / 22)) > 0 and var_462_6 < var_462_10 then
					arg_459_1.talkMaxDuration = var_462_10

					if var_462_10 + var_462_5 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_10 + var_462_5
					end
				end

				arg_459_1.text_.text = var_462_8
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051110", "story_v_out_413051.awb") ~= 0 then
					local var_462_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051110", "story_v_out_413051.awb") / 1000

					if var_462_11 + var_462_5 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_11 + var_462_5
					end

					if var_462_7.prefab_name ~= "" and arg_459_1.actors_[var_462_7.prefab_name] ~= nil then
						local var_462_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_7.prefab_name].transform, "story_v_out_413051", "413051110", "story_v_out_413051.awb")

						arg_459_1:RecordAudio("413051110", var_462_12)
						arg_459_1:RecordAudio("413051110", var_462_12)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_413051", "413051110", "story_v_out_413051.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_413051", "413051110", "story_v_out_413051.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_13 = math.max(var_462_6, arg_459_1.talkMaxDuration)

			if var_462_5 <= arg_459_1.time_ and arg_459_1.time_ < var_462_5 + var_462_13 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_5) / var_462_13

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_5 + var_462_13 and arg_459_1.time_ < var_462_5 + var_462_13 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end

		arg_459_1.nodeConfigList_ = {}

		arg_459_1:InitPlayNodeList()
	end,
	Play413051111 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 413051111
		arg_463_1.duration_ = 3.07

		local var_463_0 = {
			zh = 2.366,
			ja = 3.066
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play413051112(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(arg_463_1.actors_["10096"]) and arg_463_1.var_.actorSpriteComps10096 == nil then
				arg_463_1.var_.actorSpriteComps10096 = arg_463_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_466_0 = 2

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_0 and not isNil(arg_463_1.actors_["10096"]) then
				if arg_463_1.var_.actorSpriteComps10096 then
					for iter_466_0, iter_466_1 in pairs(arg_463_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_466_1 then
							if arg_463_1.isInRecall_ then
								iter_466_1.color = Color.New(Mathf.Lerp(iter_466_1.color.r, arg_463_1.hightColor2.r, (arg_463_1.time_ - 0) / var_466_0), Mathf.Lerp(iter_466_1.color.g, arg_463_1.hightColor2.g, (arg_463_1.time_ - 0) / var_466_0), (Mathf.Lerp(iter_466_1.color.b, arg_463_1.hightColor2.b, (arg_463_1.time_ - 0) / var_466_0)))
							else
								local var_466_1 = Mathf.Lerp(iter_466_1.color.r, 0.5, (arg_463_1.time_ - 0) / var_466_0)

								iter_466_1.color = Color.New(var_466_1, var_466_1, var_466_1)
							end
						end
					end
				end
			end

			if arg_463_1.time_ >= 0 + var_466_0 and arg_463_1.time_ < 0 + var_466_0 + arg_466_0 and not isNil(arg_463_1.actors_["10096"]) and arg_463_1.var_.actorSpriteComps10096 then
				for iter_466_2, iter_466_3 in pairs(arg_463_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_466_3 then
						iter_466_3.color = arg_463_1.isInRecall_ and (arg_463_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_463_1.var_.actorSpriteComps10096 = nil
			end

			local var_466_2 = arg_463_1.actors_["10095"]

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= 0 + arg_466_0 and not isNil(var_466_2) and arg_463_1.var_.actorSpriteComps10095 == nil then
				arg_463_1.var_.actorSpriteComps10095 = var_466_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_466_3 = 2

			if 0 <= arg_463_1.time_ and arg_463_1.time_ < 0 + var_466_3 and not isNil(var_466_2) then
				if arg_463_1.var_.actorSpriteComps10095 then
					for iter_466_4, iter_466_5 in pairs(arg_463_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_466_5 then
							if arg_463_1.isInRecall_ then
								iter_466_5.color = Color.New(Mathf.Lerp(iter_466_5.color.r, arg_463_1.hightColor1.r, (arg_463_1.time_ - 0) / var_466_3), Mathf.Lerp(iter_466_5.color.g, arg_463_1.hightColor1.g, (arg_463_1.time_ - 0) / var_466_3), (Mathf.Lerp(iter_466_5.color.b, arg_463_1.hightColor1.b, (arg_463_1.time_ - 0) / var_466_3)))
							else
								local var_466_4 = Mathf.Lerp(iter_466_5.color.r, 1, (arg_463_1.time_ - 0) / var_466_3)

								iter_466_5.color = Color.New(var_466_4, var_466_4, var_466_4)
							end
						end
					end
				end
			end

			if arg_463_1.time_ >= 0 + var_466_3 and arg_463_1.time_ < 0 + var_466_3 + arg_466_0 and not isNil(var_466_2) and arg_463_1.var_.actorSpriteComps10095 then
				for iter_466_6, iter_466_7 in pairs(arg_463_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_466_7 then
						iter_466_7.color = arg_463_1.isInRecall_ and (arg_463_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_463_1.var_.actorSpriteComps10095 = nil
			end

			local var_466_5 = 0
			local var_466_6 = 0.15

			if 0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_5 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				arg_463_1.leftNameTxt_.text = arg_463_1:FormatText(StoryNameCfg[1002].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_7 = arg_463_1:GetWordFromCfg(413051111)
				local var_466_8 = arg_463_1:FormatText(var_466_7.content)

				arg_463_1.text_.text = var_466_8

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_10 = 6 <= 0 and var_466_6 or var_466_6 * (utf8.len(var_466_8) / 6)

				if (6 <= 0 and var_466_6 or var_466_6 * (utf8.len(var_466_8) / 6)) > 0 and var_466_6 < var_466_10 then
					arg_463_1.talkMaxDuration = var_466_10

					if var_466_10 + var_466_5 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_10 + var_466_5
					end
				end

				arg_463_1.text_.text = var_466_8
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051111", "story_v_out_413051.awb") ~= 0 then
					local var_466_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051111", "story_v_out_413051.awb") / 1000

					if var_466_11 + var_466_5 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_11 + var_466_5
					end

					if var_466_7.prefab_name ~= "" and arg_463_1.actors_[var_466_7.prefab_name] ~= nil then
						local var_466_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_7.prefab_name].transform, "story_v_out_413051", "413051111", "story_v_out_413051.awb")

						arg_463_1:RecordAudio("413051111", var_466_12)
						arg_463_1:RecordAudio("413051111", var_466_12)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_413051", "413051111", "story_v_out_413051.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_413051", "413051111", "story_v_out_413051.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_13 = math.max(var_466_6, arg_463_1.talkMaxDuration)

			if var_466_5 <= arg_463_1.time_ and arg_463_1.time_ < var_466_5 + var_466_13 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_5) / var_466_13

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_5 + var_466_13 and arg_463_1.time_ < var_466_5 + var_466_13 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play413051112 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 413051112
		arg_467_1.duration_ = 11.37

		local var_467_0 = {
			zh = 6.833,
			ja = 11.366
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play413051113(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(arg_467_1.actors_["10096"]) and arg_467_1.var_.actorSpriteComps10096 == nil then
				arg_467_1.var_.actorSpriteComps10096 = arg_467_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_470_0 = 2

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_0 and not isNil(arg_467_1.actors_["10096"]) then
				if arg_467_1.var_.actorSpriteComps10096 then
					for iter_470_0, iter_470_1 in pairs(arg_467_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_470_1 then
							if arg_467_1.isInRecall_ then
								iter_470_1.color = Color.New(Mathf.Lerp(iter_470_1.color.r, arg_467_1.hightColor1.r, (arg_467_1.time_ - 0) / var_470_0), Mathf.Lerp(iter_470_1.color.g, arg_467_1.hightColor1.g, (arg_467_1.time_ - 0) / var_470_0), (Mathf.Lerp(iter_470_1.color.b, arg_467_1.hightColor1.b, (arg_467_1.time_ - 0) / var_470_0)))
							else
								local var_470_1 = Mathf.Lerp(iter_470_1.color.r, 1, (arg_467_1.time_ - 0) / var_470_0)

								iter_470_1.color = Color.New(var_470_1, var_470_1, var_470_1)
							end
						end
					end
				end
			end

			if arg_467_1.time_ >= 0 + var_470_0 and arg_467_1.time_ < 0 + var_470_0 + arg_470_0 and not isNil(arg_467_1.actors_["10096"]) and arg_467_1.var_.actorSpriteComps10096 then
				for iter_470_2, iter_470_3 in pairs(arg_467_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_470_3 then
						iter_470_3.color = arg_467_1.isInRecall_ and (arg_467_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_467_1.var_.actorSpriteComps10096 = nil
			end

			local var_470_2 = arg_467_1.actors_["10095"]

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= 0 + arg_470_0 and not isNil(var_470_2) and arg_467_1.var_.actorSpriteComps10095 == nil then
				arg_467_1.var_.actorSpriteComps10095 = var_470_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_470_3 = 2

			if 0 <= arg_467_1.time_ and arg_467_1.time_ < 0 + var_470_3 and not isNil(var_470_2) then
				if arg_467_1.var_.actorSpriteComps10095 then
					for iter_470_4, iter_470_5 in pairs(arg_467_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_470_5 then
							if arg_467_1.isInRecall_ then
								iter_470_5.color = Color.New(Mathf.Lerp(iter_470_5.color.r, arg_467_1.hightColor2.r, (arg_467_1.time_ - 0) / var_470_3), Mathf.Lerp(iter_470_5.color.g, arg_467_1.hightColor2.g, (arg_467_1.time_ - 0) / var_470_3), (Mathf.Lerp(iter_470_5.color.b, arg_467_1.hightColor2.b, (arg_467_1.time_ - 0) / var_470_3)))
							else
								local var_470_4 = Mathf.Lerp(iter_470_5.color.r, 0.5, (arg_467_1.time_ - 0) / var_470_3)

								iter_470_5.color = Color.New(var_470_4, var_470_4, var_470_4)
							end
						end
					end
				end
			end

			if arg_467_1.time_ >= 0 + var_470_3 and arg_467_1.time_ < 0 + var_470_3 + arg_470_0 and not isNil(var_470_2) and arg_467_1.var_.actorSpriteComps10095 then
				for iter_470_6, iter_470_7 in pairs(arg_467_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_470_7 then
						iter_470_7.color = arg_467_1.isInRecall_ and (arg_467_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_467_1.var_.actorSpriteComps10095 = nil
			end

			local var_470_5 = 0
			local var_470_6 = 0.6

			if 0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_5 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				arg_467_1.leftNameTxt_.text = arg_467_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_7 = arg_467_1:GetWordFromCfg(413051112)
				local var_470_8 = arg_467_1:FormatText(var_470_7.content)

				arg_467_1.text_.text = var_470_8

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_10 = 24 <= 0 and var_470_6 or var_470_6 * (utf8.len(var_470_8) / 24)

				if (24 <= 0 and var_470_6 or var_470_6 * (utf8.len(var_470_8) / 24)) > 0 and var_470_6 < var_470_10 then
					arg_467_1.talkMaxDuration = var_470_10

					if var_470_10 + var_470_5 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_10 + var_470_5
					end
				end

				arg_467_1.text_.text = var_470_8
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051112", "story_v_out_413051.awb") ~= 0 then
					local var_470_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051112", "story_v_out_413051.awb") / 1000

					if var_470_11 + var_470_5 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_11 + var_470_5
					end

					if var_470_7.prefab_name ~= "" and arg_467_1.actors_[var_470_7.prefab_name] ~= nil then
						local var_470_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_7.prefab_name].transform, "story_v_out_413051", "413051112", "story_v_out_413051.awb")

						arg_467_1:RecordAudio("413051112", var_470_12)
						arg_467_1:RecordAudio("413051112", var_470_12)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_413051", "413051112", "story_v_out_413051.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_413051", "413051112", "story_v_out_413051.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_13 = math.max(var_470_6, arg_467_1.talkMaxDuration)

			if var_470_5 <= arg_467_1.time_ and arg_467_1.time_ < var_470_5 + var_470_13 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_5) / var_470_13

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_5 + var_470_13 and arg_467_1.time_ < var_470_5 + var_470_13 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play413051113 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 413051113
		arg_471_1.duration_ = 14.13

		local var_471_0 = {
			zh = 8.633,
			ja = 14.133
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play413051114(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(arg_471_1.actors_["10096"]) and arg_471_1.var_.actorSpriteComps10096 == nil then
				arg_471_1.var_.actorSpriteComps10096 = arg_471_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_474_0 = 2

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_0 and not isNil(arg_471_1.actors_["10096"]) then
				if arg_471_1.var_.actorSpriteComps10096 then
					for iter_474_0, iter_474_1 in pairs(arg_471_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_474_1 then
							if arg_471_1.isInRecall_ then
								iter_474_1.color = Color.New(Mathf.Lerp(iter_474_1.color.r, arg_471_1.hightColor2.r, (arg_471_1.time_ - 0) / var_474_0), Mathf.Lerp(iter_474_1.color.g, arg_471_1.hightColor2.g, (arg_471_1.time_ - 0) / var_474_0), (Mathf.Lerp(iter_474_1.color.b, arg_471_1.hightColor2.b, (arg_471_1.time_ - 0) / var_474_0)))
							else
								local var_474_1 = Mathf.Lerp(iter_474_1.color.r, 0.5, (arg_471_1.time_ - 0) / var_474_0)

								iter_474_1.color = Color.New(var_474_1, var_474_1, var_474_1)
							end
						end
					end
				end
			end

			if arg_471_1.time_ >= 0 + var_474_0 and arg_471_1.time_ < 0 + var_474_0 + arg_474_0 and not isNil(arg_471_1.actors_["10096"]) and arg_471_1.var_.actorSpriteComps10096 then
				for iter_474_2, iter_474_3 in pairs(arg_471_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_474_3 then
						iter_474_3.color = arg_471_1.isInRecall_ and (arg_471_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_471_1.var_.actorSpriteComps10096 = nil
			end

			local var_474_2 = arg_471_1.actors_["10095"]

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= 0 + arg_474_0 and not isNil(var_474_2) and arg_471_1.var_.actorSpriteComps10095 == nil then
				arg_471_1.var_.actorSpriteComps10095 = var_474_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_474_3 = 2

			if 0 <= arg_471_1.time_ and arg_471_1.time_ < 0 + var_474_3 and not isNil(var_474_2) then
				if arg_471_1.var_.actorSpriteComps10095 then
					for iter_474_4, iter_474_5 in pairs(arg_471_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_474_5 then
							if arg_471_1.isInRecall_ then
								iter_474_5.color = Color.New(Mathf.Lerp(iter_474_5.color.r, arg_471_1.hightColor1.r, (arg_471_1.time_ - 0) / var_474_3), Mathf.Lerp(iter_474_5.color.g, arg_471_1.hightColor1.g, (arg_471_1.time_ - 0) / var_474_3), (Mathf.Lerp(iter_474_5.color.b, arg_471_1.hightColor1.b, (arg_471_1.time_ - 0) / var_474_3)))
							else
								local var_474_4 = Mathf.Lerp(iter_474_5.color.r, 1, (arg_471_1.time_ - 0) / var_474_3)

								iter_474_5.color = Color.New(var_474_4, var_474_4, var_474_4)
							end
						end
					end
				end
			end

			if arg_471_1.time_ >= 0 + var_474_3 and arg_471_1.time_ < 0 + var_474_3 + arg_474_0 and not isNil(var_474_2) and arg_471_1.var_.actorSpriteComps10095 then
				for iter_474_6, iter_474_7 in pairs(arg_471_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_474_7 then
						iter_474_7.color = arg_471_1.isInRecall_ and (arg_471_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_471_1.var_.actorSpriteComps10095 = nil
			end

			local var_474_5 = 0
			local var_474_6 = 0.825

			if 0 < arg_471_1.time_ and arg_471_1.time_ <= var_474_5 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				arg_471_1.leftNameTxt_.text = arg_471_1:FormatText(StoryNameCfg[1002].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_7 = arg_471_1:GetWordFromCfg(413051113)
				local var_474_8 = arg_471_1:FormatText(var_474_7.content)

				arg_471_1.text_.text = var_474_8

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_10 = 33 <= 0 and var_474_6 or var_474_6 * (utf8.len(var_474_8) / 33)

				if (33 <= 0 and var_474_6 or var_474_6 * (utf8.len(var_474_8) / 33)) > 0 and var_474_6 < var_474_10 then
					arg_471_1.talkMaxDuration = var_474_10

					if var_474_10 + var_474_5 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_10 + var_474_5
					end
				end

				arg_471_1.text_.text = var_474_8
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051113", "story_v_out_413051.awb") ~= 0 then
					local var_474_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051113", "story_v_out_413051.awb") / 1000

					if var_474_11 + var_474_5 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_11 + var_474_5
					end

					if var_474_7.prefab_name ~= "" and arg_471_1.actors_[var_474_7.prefab_name] ~= nil then
						local var_474_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_7.prefab_name].transform, "story_v_out_413051", "413051113", "story_v_out_413051.awb")

						arg_471_1:RecordAudio("413051113", var_474_12)
						arg_471_1:RecordAudio("413051113", var_474_12)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_413051", "413051113", "story_v_out_413051.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_413051", "413051113", "story_v_out_413051.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_13 = math.max(var_474_6, arg_471_1.talkMaxDuration)

			if var_474_5 <= arg_471_1.time_ and arg_471_1.time_ < var_474_5 + var_474_13 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_5) / var_474_13

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_5 + var_474_13 and arg_471_1.time_ < var_474_5 + var_474_13 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {}

		arg_471_1:InitPlayNodeList()
	end,
	Play413051114 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 413051114
		arg_475_1.duration_ = 11.23

		local var_475_0 = {
			zh = 6.2,
			ja = 11.233
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
				arg_475_0:Play413051115(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(arg_475_1.actors_["10096"]) and arg_475_1.var_.actorSpriteComps10096 == nil then
				arg_475_1.var_.actorSpriteComps10096 = arg_475_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_478_0 = 2

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_0 and not isNil(arg_475_1.actors_["10096"]) then
				if arg_475_1.var_.actorSpriteComps10096 then
					for iter_478_0, iter_478_1 in pairs(arg_475_1.var_.actorSpriteComps10096:ToTable()) do
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

			if arg_475_1.time_ >= 0 + var_478_0 and arg_475_1.time_ < 0 + var_478_0 + arg_478_0 and not isNil(arg_475_1.actors_["10096"]) and arg_475_1.var_.actorSpriteComps10096 then
				for iter_478_2, iter_478_3 in pairs(arg_475_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_478_3 then
						iter_478_3.color = arg_475_1.isInRecall_ and (arg_475_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_475_1.var_.actorSpriteComps10096 = nil
			end

			local var_478_2 = arg_475_1.actors_["10095"]

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= 0 + arg_478_0 and not isNil(var_478_2) and arg_475_1.var_.actorSpriteComps10095 == nil then
				arg_475_1.var_.actorSpriteComps10095 = var_478_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_478_3 = 2

			if 0 <= arg_475_1.time_ and arg_475_1.time_ < 0 + var_478_3 and not isNil(var_478_2) then
				if arg_475_1.var_.actorSpriteComps10095 then
					for iter_478_4, iter_478_5 in pairs(arg_475_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_478_5 then
							if arg_475_1.isInRecall_ then
								iter_478_5.color = Color.New(Mathf.Lerp(iter_478_5.color.r, arg_475_1.hightColor2.r, (arg_475_1.time_ - 0) / var_478_3), Mathf.Lerp(iter_478_5.color.g, arg_475_1.hightColor2.g, (arg_475_1.time_ - 0) / var_478_3), (Mathf.Lerp(iter_478_5.color.b, arg_475_1.hightColor2.b, (arg_475_1.time_ - 0) / var_478_3)))
							else
								local var_478_4 = Mathf.Lerp(iter_478_5.color.r, 0.5, (arg_475_1.time_ - 0) / var_478_3)

								iter_478_5.color = Color.New(var_478_4, var_478_4, var_478_4)
							end
						end
					end
				end
			end

			if arg_475_1.time_ >= 0 + var_478_3 and arg_475_1.time_ < 0 + var_478_3 + arg_478_0 and not isNil(var_478_2) and arg_475_1.var_.actorSpriteComps10095 then
				for iter_478_6, iter_478_7 in pairs(arg_475_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_478_7 then
						iter_478_7.color = arg_475_1.isInRecall_ and (arg_475_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_475_1.var_.actorSpriteComps10095 = nil
			end

			local var_478_5 = 0
			local var_478_6 = 0.6

			if 0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_5 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				arg_475_1.leftNameTxt_.text = arg_475_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_7 = arg_475_1:GetWordFromCfg(413051114)
				local var_478_8 = arg_475_1:FormatText(var_478_7.content)

				arg_475_1.text_.text = var_478_8

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_10 = 24 <= 0 and var_478_6 or var_478_6 * (utf8.len(var_478_8) / 24)

				if (24 <= 0 and var_478_6 or var_478_6 * (utf8.len(var_478_8) / 24)) > 0 and var_478_6 < var_478_10 then
					arg_475_1.talkMaxDuration = var_478_10

					if var_478_10 + var_478_5 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_10 + var_478_5
					end
				end

				arg_475_1.text_.text = var_478_8
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051114", "story_v_out_413051.awb") ~= 0 then
					local var_478_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051114", "story_v_out_413051.awb") / 1000

					if var_478_11 + var_478_5 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_11 + var_478_5
					end

					if var_478_7.prefab_name ~= "" and arg_475_1.actors_[var_478_7.prefab_name] ~= nil then
						local var_478_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_7.prefab_name].transform, "story_v_out_413051", "413051114", "story_v_out_413051.awb")

						arg_475_1:RecordAudio("413051114", var_478_12)
						arg_475_1:RecordAudio("413051114", var_478_12)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_413051", "413051114", "story_v_out_413051.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_413051", "413051114", "story_v_out_413051.awb")
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

		arg_475_1.nodeConfigList_ = {}

		arg_475_1:InitPlayNodeList()
	end,
	Play413051115 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 413051115
		arg_479_1.duration_ = 8.07

		local var_479_0 = {
			zh = 5.133,
			ja = 8.066
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
				arg_479_0:Play413051116(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(arg_479_1.actors_["10096"]) and arg_479_1.var_.actorSpriteComps10096 == nil then
				arg_479_1.var_.actorSpriteComps10096 = arg_479_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_482_0 = 2

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_0 and not isNil(arg_479_1.actors_["10096"]) then
				if arg_479_1.var_.actorSpriteComps10096 then
					for iter_482_0, iter_482_1 in pairs(arg_479_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_482_1 then
							if arg_479_1.isInRecall_ then
								iter_482_1.color = Color.New(Mathf.Lerp(iter_482_1.color.r, arg_479_1.hightColor2.r, (arg_479_1.time_ - 0) / var_482_0), Mathf.Lerp(iter_482_1.color.g, arg_479_1.hightColor2.g, (arg_479_1.time_ - 0) / var_482_0), (Mathf.Lerp(iter_482_1.color.b, arg_479_1.hightColor2.b, (arg_479_1.time_ - 0) / var_482_0)))
							else
								local var_482_1 = Mathf.Lerp(iter_482_1.color.r, 0.5, (arg_479_1.time_ - 0) / var_482_0)

								iter_482_1.color = Color.New(var_482_1, var_482_1, var_482_1)
							end
						end
					end
				end
			end

			if arg_479_1.time_ >= 0 + var_482_0 and arg_479_1.time_ < 0 + var_482_0 + arg_482_0 and not isNil(arg_479_1.actors_["10096"]) and arg_479_1.var_.actorSpriteComps10096 then
				for iter_482_2, iter_482_3 in pairs(arg_479_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_482_3 then
						iter_482_3.color = arg_479_1.isInRecall_ and (arg_479_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_479_1.var_.actorSpriteComps10096 = nil
			end

			local var_482_2 = arg_479_1.actors_["10095"]

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= 0 + arg_482_0 and not isNil(var_482_2) and arg_479_1.var_.actorSpriteComps10095 == nil then
				arg_479_1.var_.actorSpriteComps10095 = var_482_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_482_3 = 2

			if 0 <= arg_479_1.time_ and arg_479_1.time_ < 0 + var_482_3 and not isNil(var_482_2) then
				if arg_479_1.var_.actorSpriteComps10095 then
					for iter_482_4, iter_482_5 in pairs(arg_479_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_482_5 then
							if arg_479_1.isInRecall_ then
								iter_482_5.color = Color.New(Mathf.Lerp(iter_482_5.color.r, arg_479_1.hightColor1.r, (arg_479_1.time_ - 0) / var_482_3), Mathf.Lerp(iter_482_5.color.g, arg_479_1.hightColor1.g, (arg_479_1.time_ - 0) / var_482_3), (Mathf.Lerp(iter_482_5.color.b, arg_479_1.hightColor1.b, (arg_479_1.time_ - 0) / var_482_3)))
							else
								local var_482_4 = Mathf.Lerp(iter_482_5.color.r, 1, (arg_479_1.time_ - 0) / var_482_3)

								iter_482_5.color = Color.New(var_482_4, var_482_4, var_482_4)
							end
						end
					end
				end
			end

			if arg_479_1.time_ >= 0 + var_482_3 and arg_479_1.time_ < 0 + var_482_3 + arg_482_0 and not isNil(var_482_2) and arg_479_1.var_.actorSpriteComps10095 then
				for iter_482_6, iter_482_7 in pairs(arg_479_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_482_7 then
						iter_482_7.color = arg_479_1.isInRecall_ and (arg_479_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_479_1.var_.actorSpriteComps10095 = nil
			end

			local var_482_5 = 0
			local var_482_6 = 0.45

			if 0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_5 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				arg_479_1.leftNameTxt_.text = arg_479_1:FormatText(StoryNameCfg[1002].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_7 = arg_479_1:GetWordFromCfg(413051115)
				local var_482_8 = arg_479_1:FormatText(var_482_7.content)

				arg_479_1.text_.text = var_482_8

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_10 = 18 <= 0 and var_482_6 or var_482_6 * (utf8.len(var_482_8) / 18)

				if (18 <= 0 and var_482_6 or var_482_6 * (utf8.len(var_482_8) / 18)) > 0 and var_482_6 < var_482_10 then
					arg_479_1.talkMaxDuration = var_482_10

					if var_482_10 + var_482_5 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_10 + var_482_5
					end
				end

				arg_479_1.text_.text = var_482_8
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051115", "story_v_out_413051.awb") ~= 0 then
					local var_482_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051115", "story_v_out_413051.awb") / 1000

					if var_482_11 + var_482_5 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_11 + var_482_5
					end

					if var_482_7.prefab_name ~= "" and arg_479_1.actors_[var_482_7.prefab_name] ~= nil then
						local var_482_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_7.prefab_name].transform, "story_v_out_413051", "413051115", "story_v_out_413051.awb")

						arg_479_1:RecordAudio("413051115", var_482_12)
						arg_479_1:RecordAudio("413051115", var_482_12)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_413051", "413051115", "story_v_out_413051.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_413051", "413051115", "story_v_out_413051.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_13 = math.max(var_482_6, arg_479_1.talkMaxDuration)

			if var_482_5 <= arg_479_1.time_ and arg_479_1.time_ < var_482_5 + var_482_13 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_5) / var_482_13

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_5 + var_482_13 and arg_479_1.time_ < var_482_5 + var_482_13 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end

		arg_479_1.nodeConfigList_ = {}

		arg_479_1:InitPlayNodeList()
	end,
	Play413051116 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 413051116
		arg_483_1.duration_ = 17.9

		local var_483_0 = {
			zh = 7.866,
			ja = 17.9
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play413051117(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(arg_483_1.actors_["10096"]) and arg_483_1.var_.actorSpriteComps10096 == nil then
				arg_483_1.var_.actorSpriteComps10096 = arg_483_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_486_0 = 2

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_0 and not isNil(arg_483_1.actors_["10096"]) then
				if arg_483_1.var_.actorSpriteComps10096 then
					for iter_486_0, iter_486_1 in pairs(arg_483_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_486_1 then
							if arg_483_1.isInRecall_ then
								iter_486_1.color = Color.New(Mathf.Lerp(iter_486_1.color.r, arg_483_1.hightColor1.r, (arg_483_1.time_ - 0) / var_486_0), Mathf.Lerp(iter_486_1.color.g, arg_483_1.hightColor1.g, (arg_483_1.time_ - 0) / var_486_0), (Mathf.Lerp(iter_486_1.color.b, arg_483_1.hightColor1.b, (arg_483_1.time_ - 0) / var_486_0)))
							else
								local var_486_1 = Mathf.Lerp(iter_486_1.color.r, 1, (arg_483_1.time_ - 0) / var_486_0)

								iter_486_1.color = Color.New(var_486_1, var_486_1, var_486_1)
							end
						end
					end
				end
			end

			if arg_483_1.time_ >= 0 + var_486_0 and arg_483_1.time_ < 0 + var_486_0 + arg_486_0 and not isNil(arg_483_1.actors_["10096"]) and arg_483_1.var_.actorSpriteComps10096 then
				for iter_486_2, iter_486_3 in pairs(arg_483_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_486_3 then
						iter_486_3.color = arg_483_1.isInRecall_ and (arg_483_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_483_1.var_.actorSpriteComps10096 = nil
			end

			local var_486_2 = arg_483_1.actors_["10095"]

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= 0 + arg_486_0 and not isNil(var_486_2) and arg_483_1.var_.actorSpriteComps10095 == nil then
				arg_483_1.var_.actorSpriteComps10095 = var_486_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_486_3 = 2

			if 0 <= arg_483_1.time_ and arg_483_1.time_ < 0 + var_486_3 and not isNil(var_486_2) then
				if arg_483_1.var_.actorSpriteComps10095 then
					for iter_486_4, iter_486_5 in pairs(arg_483_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_486_5 then
							if arg_483_1.isInRecall_ then
								iter_486_5.color = Color.New(Mathf.Lerp(iter_486_5.color.r, arg_483_1.hightColor2.r, (arg_483_1.time_ - 0) / var_486_3), Mathf.Lerp(iter_486_5.color.g, arg_483_1.hightColor2.g, (arg_483_1.time_ - 0) / var_486_3), (Mathf.Lerp(iter_486_5.color.b, arg_483_1.hightColor2.b, (arg_483_1.time_ - 0) / var_486_3)))
							else
								local var_486_4 = Mathf.Lerp(iter_486_5.color.r, 0.5, (arg_483_1.time_ - 0) / var_486_3)

								iter_486_5.color = Color.New(var_486_4, var_486_4, var_486_4)
							end
						end
					end
				end
			end

			if arg_483_1.time_ >= 0 + var_486_3 and arg_483_1.time_ < 0 + var_486_3 + arg_486_0 and not isNil(var_486_2) and arg_483_1.var_.actorSpriteComps10095 then
				for iter_486_6, iter_486_7 in pairs(arg_483_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_486_7 then
						iter_486_7.color = arg_483_1.isInRecall_ and (arg_483_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_483_1.var_.actorSpriteComps10095 = nil
			end

			local var_486_5 = 0
			local var_486_6 = 0.825

			if 0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_5 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				arg_483_1.leftNameTxt_.text = arg_483_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, false)
				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_7 = arg_483_1:GetWordFromCfg(413051116)
				local var_486_8 = arg_483_1:FormatText(var_486_7.content)

				arg_483_1.text_.text = var_486_8

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_10 = 33 <= 0 and var_486_6 or var_486_6 * (utf8.len(var_486_8) / 33)

				if (33 <= 0 and var_486_6 or var_486_6 * (utf8.len(var_486_8) / 33)) > 0 and var_486_6 < var_486_10 then
					arg_483_1.talkMaxDuration = var_486_10

					if var_486_10 + var_486_5 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_10 + var_486_5
					end
				end

				arg_483_1.text_.text = var_486_8
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051116", "story_v_out_413051.awb") ~= 0 then
					local var_486_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051116", "story_v_out_413051.awb") / 1000

					if var_486_11 + var_486_5 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_11 + var_486_5
					end

					if var_486_7.prefab_name ~= "" and arg_483_1.actors_[var_486_7.prefab_name] ~= nil then
						local var_486_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_7.prefab_name].transform, "story_v_out_413051", "413051116", "story_v_out_413051.awb")

						arg_483_1:RecordAudio("413051116", var_486_12)
						arg_483_1:RecordAudio("413051116", var_486_12)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_413051", "413051116", "story_v_out_413051.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_413051", "413051116", "story_v_out_413051.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_13 = math.max(var_486_6, arg_483_1.talkMaxDuration)

			if var_486_5 <= arg_483_1.time_ and arg_483_1.time_ < var_486_5 + var_486_13 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_5) / var_486_13

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_5 + var_486_13 and arg_483_1.time_ < var_486_5 + var_486_13 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end

		arg_483_1.nodeConfigList_ = {}

		arg_483_1:InitPlayNodeList()
	end,
	Play413051117 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 413051117
		arg_487_1.duration_ = 18.07

		local var_487_0 = {
			zh = 7.133,
			ja = 18.066
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
				arg_487_0:Play413051118(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0.6

			if 0 < arg_487_1.time_ and arg_487_1.time_ <= 0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				arg_487_1.leftNameTxt_.text = arg_487_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_1 = arg_487_1:GetWordFromCfg(413051117)
				local var_490_2 = arg_487_1:FormatText(var_490_1.content)

				arg_487_1.text_.text = var_490_2

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_4 = 24 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_2) / 24)

				if (24 <= 0 and var_490_0 or var_490_0 * (utf8.len(var_490_2) / 24)) > 0 and var_490_0 < var_490_4 then
					arg_487_1.talkMaxDuration = var_490_4

					if var_490_4 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_4 + 0
					end
				end

				arg_487_1.text_.text = var_490_2
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051117", "story_v_out_413051.awb") ~= 0 then
					local var_490_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051117", "story_v_out_413051.awb") / 1000

					if var_490_5 + 0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_5 + 0
					end

					if var_490_1.prefab_name ~= "" and arg_487_1.actors_[var_490_1.prefab_name] ~= nil then
						local var_490_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_1.prefab_name].transform, "story_v_out_413051", "413051117", "story_v_out_413051.awb")

						arg_487_1:RecordAudio("413051117", var_490_6)
						arg_487_1:RecordAudio("413051117", var_490_6)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_413051", "413051117", "story_v_out_413051.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_413051", "413051117", "story_v_out_413051.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_7 = math.max(var_490_0, arg_487_1.talkMaxDuration)

			if 0 <= arg_487_1.time_ and arg_487_1.time_ < 0 + var_490_7 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - 0) / var_490_7

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= 0 + var_490_7 and arg_487_1.time_ < 0 + var_490_7 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play413051118 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 413051118
		arg_491_1.duration_ = 9.2

		local var_491_0 = {
			zh = 5.1,
			ja = 9.2
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
				arg_491_0:Play413051119(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(arg_491_1.actors_["10096"]) and arg_491_1.var_.actorSpriteComps10096 == nil then
				arg_491_1.var_.actorSpriteComps10096 = arg_491_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_494_0 = 2

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_0 and not isNil(arg_491_1.actors_["10096"]) then
				if arg_491_1.var_.actorSpriteComps10096 then
					for iter_494_0, iter_494_1 in pairs(arg_491_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_494_1 then
							if arg_491_1.isInRecall_ then
								iter_494_1.color = Color.New(Mathf.Lerp(iter_494_1.color.r, arg_491_1.hightColor2.r, (arg_491_1.time_ - 0) / var_494_0), Mathf.Lerp(iter_494_1.color.g, arg_491_1.hightColor2.g, (arg_491_1.time_ - 0) / var_494_0), (Mathf.Lerp(iter_494_1.color.b, arg_491_1.hightColor2.b, (arg_491_1.time_ - 0) / var_494_0)))
							else
								local var_494_1 = Mathf.Lerp(iter_494_1.color.r, 0.5, (arg_491_1.time_ - 0) / var_494_0)

								iter_494_1.color = Color.New(var_494_1, var_494_1, var_494_1)
							end
						end
					end
				end
			end

			if arg_491_1.time_ >= 0 + var_494_0 and arg_491_1.time_ < 0 + var_494_0 + arg_494_0 and not isNil(arg_491_1.actors_["10096"]) and arg_491_1.var_.actorSpriteComps10096 then
				for iter_494_2, iter_494_3 in pairs(arg_491_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_494_3 then
						iter_494_3.color = arg_491_1.isInRecall_ and (arg_491_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_491_1.var_.actorSpriteComps10096 = nil
			end

			local var_494_2 = arg_491_1.actors_["10095"]

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= 0 + arg_494_0 and not isNil(var_494_2) and arg_491_1.var_.actorSpriteComps10095 == nil then
				arg_491_1.var_.actorSpriteComps10095 = var_494_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_494_3 = 2

			if 0 <= arg_491_1.time_ and arg_491_1.time_ < 0 + var_494_3 and not isNil(var_494_2) then
				if arg_491_1.var_.actorSpriteComps10095 then
					for iter_494_4, iter_494_5 in pairs(arg_491_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_494_5 then
							if arg_491_1.isInRecall_ then
								iter_494_5.color = Color.New(Mathf.Lerp(iter_494_5.color.r, arg_491_1.hightColor1.r, (arg_491_1.time_ - 0) / var_494_3), Mathf.Lerp(iter_494_5.color.g, arg_491_1.hightColor1.g, (arg_491_1.time_ - 0) / var_494_3), (Mathf.Lerp(iter_494_5.color.b, arg_491_1.hightColor1.b, (arg_491_1.time_ - 0) / var_494_3)))
							else
								local var_494_4 = Mathf.Lerp(iter_494_5.color.r, 1, (arg_491_1.time_ - 0) / var_494_3)

								iter_494_5.color = Color.New(var_494_4, var_494_4, var_494_4)
							end
						end
					end
				end
			end

			if arg_491_1.time_ >= 0 + var_494_3 and arg_491_1.time_ < 0 + var_494_3 + arg_494_0 and not isNil(var_494_2) and arg_491_1.var_.actorSpriteComps10095 then
				for iter_494_6, iter_494_7 in pairs(arg_491_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_494_7 then
						iter_494_7.color = arg_491_1.isInRecall_ and (arg_491_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_491_1.var_.actorSpriteComps10095 = nil
			end

			local var_494_5 = 0
			local var_494_6 = 0.4

			if 0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_5 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				arg_491_1.leftNameTxt_.text = arg_491_1:FormatText(StoryNameCfg[1002].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_7 = arg_491_1:GetWordFromCfg(413051118)
				local var_494_8 = arg_491_1:FormatText(var_494_7.content)

				arg_491_1.text_.text = var_494_8

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_10 = 16 <= 0 and var_494_6 or var_494_6 * (utf8.len(var_494_8) / 16)

				if (16 <= 0 and var_494_6 or var_494_6 * (utf8.len(var_494_8) / 16)) > 0 and var_494_6 < var_494_10 then
					arg_491_1.talkMaxDuration = var_494_10

					if var_494_10 + var_494_5 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_10 + var_494_5
					end
				end

				arg_491_1.text_.text = var_494_8
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051118", "story_v_out_413051.awb") ~= 0 then
					local var_494_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051118", "story_v_out_413051.awb") / 1000

					if var_494_11 + var_494_5 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_11 + var_494_5
					end

					if var_494_7.prefab_name ~= "" and arg_491_1.actors_[var_494_7.prefab_name] ~= nil then
						local var_494_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_7.prefab_name].transform, "story_v_out_413051", "413051118", "story_v_out_413051.awb")

						arg_491_1:RecordAudio("413051118", var_494_12)
						arg_491_1:RecordAudio("413051118", var_494_12)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_413051", "413051118", "story_v_out_413051.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_413051", "413051118", "story_v_out_413051.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_13 = math.max(var_494_6, arg_491_1.talkMaxDuration)

			if var_494_5 <= arg_491_1.time_ and arg_491_1.time_ < var_494_5 + var_494_13 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_5) / var_494_13

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_5 + var_494_13 and arg_491_1.time_ < var_494_5 + var_494_13 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play413051119 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 413051119
		arg_495_1.duration_ = 6.7

		local var_495_0 = {
			zh = 3.433,
			ja = 6.7
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
				arg_495_0:Play413051120(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(arg_495_1.actors_["10096"]) and arg_495_1.var_.actorSpriteComps10096 == nil then
				arg_495_1.var_.actorSpriteComps10096 = arg_495_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_498_0 = 2

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_0 and not isNil(arg_495_1.actors_["10096"]) then
				if arg_495_1.var_.actorSpriteComps10096 then
					for iter_498_0, iter_498_1 in pairs(arg_495_1.var_.actorSpriteComps10096:ToTable()) do
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

			if arg_495_1.time_ >= 0 + var_498_0 and arg_495_1.time_ < 0 + var_498_0 + arg_498_0 and not isNil(arg_495_1.actors_["10096"]) and arg_495_1.var_.actorSpriteComps10096 then
				for iter_498_2, iter_498_3 in pairs(arg_495_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_498_3 then
						iter_498_3.color = arg_495_1.isInRecall_ and (arg_495_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_495_1.var_.actorSpriteComps10096 = nil
			end

			local var_498_2 = arg_495_1.actors_["10095"]

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 and not isNil(var_498_2) and arg_495_1.var_.actorSpriteComps10095 == nil then
				arg_495_1.var_.actorSpriteComps10095 = var_498_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_498_3 = 2

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_3 and not isNil(var_498_2) then
				if arg_495_1.var_.actorSpriteComps10095 then
					for iter_498_4, iter_498_5 in pairs(arg_495_1.var_.actorSpriteComps10095:ToTable()) do
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

			if arg_495_1.time_ >= 0 + var_498_3 and arg_495_1.time_ < 0 + var_498_3 + arg_498_0 and not isNil(var_498_2) and arg_495_1.var_.actorSpriteComps10095 then
				for iter_498_6, iter_498_7 in pairs(arg_495_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_498_7 then
						iter_498_7.color = arg_495_1.isInRecall_ and (arg_495_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_495_1.var_.actorSpriteComps10095 = nil
			end

			local var_498_5 = 0
			local var_498_6 = 0.175

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_5 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_7 = arg_495_1:GetWordFromCfg(413051119)
				local var_498_8 = arg_495_1:FormatText(var_498_7.content)

				arg_495_1.text_.text = var_498_8

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_10 = 7 <= 0 and var_498_6 or var_498_6 * (utf8.len(var_498_8) / 7)

				if (7 <= 0 and var_498_6 or var_498_6 * (utf8.len(var_498_8) / 7)) > 0 and var_498_6 < var_498_10 then
					arg_495_1.talkMaxDuration = var_498_10

					if var_498_10 + var_498_5 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_10 + var_498_5
					end
				end

				arg_495_1.text_.text = var_498_8
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051119", "story_v_out_413051.awb") ~= 0 then
					local var_498_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051119", "story_v_out_413051.awb") / 1000

					if var_498_11 + var_498_5 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_11 + var_498_5
					end

					if var_498_7.prefab_name ~= "" and arg_495_1.actors_[var_498_7.prefab_name] ~= nil then
						local var_498_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_7.prefab_name].transform, "story_v_out_413051", "413051119", "story_v_out_413051.awb")

						arg_495_1:RecordAudio("413051119", var_498_12)
						arg_495_1:RecordAudio("413051119", var_498_12)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_413051", "413051119", "story_v_out_413051.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_413051", "413051119", "story_v_out_413051.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_13 = math.max(var_498_6, arg_495_1.talkMaxDuration)

			if var_498_5 <= arg_495_1.time_ and arg_495_1.time_ < var_498_5 + var_498_13 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_5) / var_498_13

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_5 + var_498_13 and arg_495_1.time_ < var_498_5 + var_498_13 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play413051120 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 413051120
		arg_499_1.duration_ = 8.2

		local var_499_0 = {
			zh = 6.066,
			ja = 8.2
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
				arg_499_0:Play413051121(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(arg_499_1.actors_["10096"]) and arg_499_1.var_.actorSpriteComps10096 == nil then
				arg_499_1.var_.actorSpriteComps10096 = arg_499_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_502_0 = 2

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 and not isNil(arg_499_1.actors_["10096"]) then
				if arg_499_1.var_.actorSpriteComps10096 then
					for iter_502_0, iter_502_1 in pairs(arg_499_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_502_1 then
							if arg_499_1.isInRecall_ then
								iter_502_1.color = Color.New(Mathf.Lerp(iter_502_1.color.r, arg_499_1.hightColor2.r, (arg_499_1.time_ - 0) / var_502_0), Mathf.Lerp(iter_502_1.color.g, arg_499_1.hightColor2.g, (arg_499_1.time_ - 0) / var_502_0), (Mathf.Lerp(iter_502_1.color.b, arg_499_1.hightColor2.b, (arg_499_1.time_ - 0) / var_502_0)))
							else
								local var_502_1 = Mathf.Lerp(iter_502_1.color.r, 0.5, (arg_499_1.time_ - 0) / var_502_0)

								iter_502_1.color = Color.New(var_502_1, var_502_1, var_502_1)
							end
						end
					end
				end
			end

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 and not isNil(arg_499_1.actors_["10096"]) and arg_499_1.var_.actorSpriteComps10096 then
				for iter_502_2, iter_502_3 in pairs(arg_499_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_502_3 then
						iter_502_3.color = arg_499_1.isInRecall_ and (arg_499_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_499_1.var_.actorSpriteComps10096 = nil
			end

			local var_502_2 = arg_499_1.actors_["10095"]

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(var_502_2) and arg_499_1.var_.actorSpriteComps10095 == nil then
				arg_499_1.var_.actorSpriteComps10095 = var_502_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_502_3 = 2

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_3 and not isNil(var_502_2) then
				if arg_499_1.var_.actorSpriteComps10095 then
					for iter_502_4, iter_502_5 in pairs(arg_499_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_502_5 then
							if arg_499_1.isInRecall_ then
								iter_502_5.color = Color.New(Mathf.Lerp(iter_502_5.color.r, arg_499_1.hightColor1.r, (arg_499_1.time_ - 0) / var_502_3), Mathf.Lerp(iter_502_5.color.g, arg_499_1.hightColor1.g, (arg_499_1.time_ - 0) / var_502_3), (Mathf.Lerp(iter_502_5.color.b, arg_499_1.hightColor1.b, (arg_499_1.time_ - 0) / var_502_3)))
							else
								local var_502_4 = Mathf.Lerp(iter_502_5.color.r, 1, (arg_499_1.time_ - 0) / var_502_3)

								iter_502_5.color = Color.New(var_502_4, var_502_4, var_502_4)
							end
						end
					end
				end
			end

			if arg_499_1.time_ >= 0 + var_502_3 and arg_499_1.time_ < 0 + var_502_3 + arg_502_0 and not isNil(var_502_2) and arg_499_1.var_.actorSpriteComps10095 then
				for iter_502_6, iter_502_7 in pairs(arg_499_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_502_7 then
						iter_502_7.color = arg_499_1.isInRecall_ and (arg_499_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_499_1.var_.actorSpriteComps10095 = nil
			end

			local var_502_5 = 0
			local var_502_6 = 0.625

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_5 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[1002].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_7 = arg_499_1:GetWordFromCfg(413051120)
				local var_502_8 = arg_499_1:FormatText(var_502_7.content)

				arg_499_1.text_.text = var_502_8

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_10 = 25 <= 0 and var_502_6 or var_502_6 * (utf8.len(var_502_8) / 25)

				if (25 <= 0 and var_502_6 or var_502_6 * (utf8.len(var_502_8) / 25)) > 0 and var_502_6 < var_502_10 then
					arg_499_1.talkMaxDuration = var_502_10

					if var_502_10 + var_502_5 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_10 + var_502_5
					end
				end

				arg_499_1.text_.text = var_502_8
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051120", "story_v_out_413051.awb") ~= 0 then
					local var_502_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051120", "story_v_out_413051.awb") / 1000

					if var_502_11 + var_502_5 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_11 + var_502_5
					end

					if var_502_7.prefab_name ~= "" and arg_499_1.actors_[var_502_7.prefab_name] ~= nil then
						local var_502_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_7.prefab_name].transform, "story_v_out_413051", "413051120", "story_v_out_413051.awb")

						arg_499_1:RecordAudio("413051120", var_502_12)
						arg_499_1:RecordAudio("413051120", var_502_12)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_413051", "413051120", "story_v_out_413051.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_413051", "413051120", "story_v_out_413051.awb")
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
	Play413051121 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 413051121
		arg_503_1.duration_ = 12.77

		local var_503_0 = {
			zh = 6.733,
			ja = 12.766
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
				arg_503_0:Play413051122(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = 0.65

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[1002].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_1 = arg_503_1:GetWordFromCfg(413051121)
				local var_506_2 = arg_503_1:FormatText(var_506_1.content)

				arg_503_1.text_.text = var_506_2

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_4 = 26 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_2) / 26)

				if (26 <= 0 and var_506_0 or var_506_0 * (utf8.len(var_506_2) / 26)) > 0 and var_506_0 < var_506_4 then
					arg_503_1.talkMaxDuration = var_506_4

					if var_506_4 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_4 + 0
					end
				end

				arg_503_1.text_.text = var_506_2
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051121", "story_v_out_413051.awb") ~= 0 then
					local var_506_5 = manager.audio:GetVoiceLength("story_v_out_413051", "413051121", "story_v_out_413051.awb") / 1000

					if var_506_5 + 0 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_5 + 0
					end

					if var_506_1.prefab_name ~= "" and arg_503_1.actors_[var_506_1.prefab_name] ~= nil then
						local var_506_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_1.prefab_name].transform, "story_v_out_413051", "413051121", "story_v_out_413051.awb")

						arg_503_1:RecordAudio("413051121", var_506_6)
						arg_503_1:RecordAudio("413051121", var_506_6)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_413051", "413051121", "story_v_out_413051.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_413051", "413051121", "story_v_out_413051.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_7 = math.max(var_506_0, arg_503_1.talkMaxDuration)

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_7 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - 0) / var_506_7

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= 0 + var_506_7 and arg_503_1.time_ < 0 + var_506_7 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play413051122 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 413051122
		arg_507_1.duration_ = 10.53

		local var_507_0 = {
			zh = 2.266,
			ja = 10.533
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
			arg_507_1.auto_ = false
		end

		function arg_507_1.playNext_(arg_509_0)
			arg_507_1.onStoryFinished_()
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(arg_507_1.actors_["10096"]) and arg_507_1.var_.actorSpriteComps10096 == nil then
				arg_507_1.var_.actorSpriteComps10096 = arg_507_1.actors_["10096"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_510_0 = 2

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 and not isNil(arg_507_1.actors_["10096"]) then
				if arg_507_1.var_.actorSpriteComps10096 then
					for iter_510_0, iter_510_1 in pairs(arg_507_1.var_.actorSpriteComps10096:ToTable()) do
						if iter_510_1 then
							if arg_507_1.isInRecall_ then
								iter_510_1.color = Color.New(Mathf.Lerp(iter_510_1.color.r, arg_507_1.hightColor1.r, (arg_507_1.time_ - 0) / var_510_0), Mathf.Lerp(iter_510_1.color.g, arg_507_1.hightColor1.g, (arg_507_1.time_ - 0) / var_510_0), (Mathf.Lerp(iter_510_1.color.b, arg_507_1.hightColor1.b, (arg_507_1.time_ - 0) / var_510_0)))
							else
								local var_510_1 = Mathf.Lerp(iter_510_1.color.r, 1, (arg_507_1.time_ - 0) / var_510_0)

								iter_510_1.color = Color.New(var_510_1, var_510_1, var_510_1)
							end
						end
					end
				end
			end

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 and not isNil(arg_507_1.actors_["10096"]) and arg_507_1.var_.actorSpriteComps10096 then
				for iter_510_2, iter_510_3 in pairs(arg_507_1.var_.actorSpriteComps10096:ToTable()) do
					if iter_510_3 then
						iter_510_3.color = arg_507_1.isInRecall_ and (arg_507_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_507_1.var_.actorSpriteComps10096 = nil
			end

			local var_510_2 = arg_507_1.actors_["10095"]

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(var_510_2) and arg_507_1.var_.actorSpriteComps10095 == nil then
				arg_507_1.var_.actorSpriteComps10095 = var_510_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_510_3 = 2

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_3 and not isNil(var_510_2) then
				if arg_507_1.var_.actorSpriteComps10095 then
					for iter_510_4, iter_510_5 in pairs(arg_507_1.var_.actorSpriteComps10095:ToTable()) do
						if iter_510_5 then
							if arg_507_1.isInRecall_ then
								iter_510_5.color = Color.New(Mathf.Lerp(iter_510_5.color.r, arg_507_1.hightColor2.r, (arg_507_1.time_ - 0) / var_510_3), Mathf.Lerp(iter_510_5.color.g, arg_507_1.hightColor2.g, (arg_507_1.time_ - 0) / var_510_3), (Mathf.Lerp(iter_510_5.color.b, arg_507_1.hightColor2.b, (arg_507_1.time_ - 0) / var_510_3)))
							else
								local var_510_4 = Mathf.Lerp(iter_510_5.color.r, 0.5, (arg_507_1.time_ - 0) / var_510_3)

								iter_510_5.color = Color.New(var_510_4, var_510_4, var_510_4)
							end
						end
					end
				end
			end

			if arg_507_1.time_ >= 0 + var_510_3 and arg_507_1.time_ < 0 + var_510_3 + arg_510_0 and not isNil(var_510_2) and arg_507_1.var_.actorSpriteComps10095 then
				for iter_510_6, iter_510_7 in pairs(arg_507_1.var_.actorSpriteComps10095:ToTable()) do
					if iter_510_7 then
						iter_510_7.color = arg_507_1.isInRecall_ and (arg_507_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_507_1.var_.actorSpriteComps10095 = nil
			end

			local var_510_5 = 0
			local var_510_6 = 0.225

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_5 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_7 = arg_507_1:GetWordFromCfg(413051122)
				local var_510_8 = arg_507_1:FormatText(var_510_7.content)

				arg_507_1.text_.text = var_510_8

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_10 = 9 <= 0 and var_510_6 or var_510_6 * (utf8.len(var_510_8) / 9)

				if (9 <= 0 and var_510_6 or var_510_6 * (utf8.len(var_510_8) / 9)) > 0 and var_510_6 < var_510_10 then
					arg_507_1.talkMaxDuration = var_510_10

					if var_510_10 + var_510_5 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_10 + var_510_5
					end
				end

				arg_507_1.text_.text = var_510_8
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413051", "413051122", "story_v_out_413051.awb") ~= 0 then
					local var_510_11 = manager.audio:GetVoiceLength("story_v_out_413051", "413051122", "story_v_out_413051.awb") / 1000

					if var_510_11 + var_510_5 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_11 + var_510_5
					end

					if var_510_7.prefab_name ~= "" and arg_507_1.actors_[var_510_7.prefab_name] ~= nil then
						local var_510_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_7.prefab_name].transform, "story_v_out_413051", "413051122", "story_v_out_413051.awb")

						arg_507_1:RecordAudio("413051122", var_510_12)
						arg_507_1:RecordAudio("413051122", var_510_12)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_413051", "413051122", "story_v_out_413051.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_413051", "413051122", "story_v_out_413051.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_13 = math.max(var_510_6, arg_507_1.talkMaxDuration)

			if var_510_5 <= arg_507_1.time_ and arg_507_1.time_ < var_510_5 + var_510_13 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_5) / var_510_13

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_5 + var_510_13 and arg_507_1.time_ < var_510_5 + var_510_13 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {}

		arg_507_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F08f",
		"TextureConfig/Background/F10f",
		"TextureConfig/Background/F08l",
		"TextureConfig/Background/F08i",
		"TextureConfig/Background/ST71a"
	},
	voices = {
		"story_v_out_413051.awb"
	}
}
