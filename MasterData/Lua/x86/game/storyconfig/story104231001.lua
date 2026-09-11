return {
	Play423101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423101001
		arg_1_1.duration_ = 10.73

		local var_1_0 = {
			zh = 6.3,
			ja = 10.733
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
				arg_1_0:Play423101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I25h == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I25h")
				var_4_0.name = "I25h"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I25h = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I25h

				arg_1_1.bgs_.I25h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I25h" then
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

			local var_4_9 = "10148"

			if arg_1_1.actors_["10148"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10148")

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

			local var_4_12 = arg_1_1.actors_["10148"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps10148 == nil then
				arg_1_1.var_.actorSpriteComps10148 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps10148 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.8) / var_4_13), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.8) / var_4_13), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.8) / var_4_13)))
							else
								local var_4_14 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 1.8) / var_4_13)

								iter_4_5.color = Color.New(var_4_14, var_4_14, var_4_14)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps10148 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10148 = nil
			end

			local var_4_15 = arg_1_1.actors_["10148"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10148 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10148", 3)

				for iter_4_8 = 0, var_4_15.childCount - 1 do
					local var_4_16 = var_4_15:GetChild(iter_4_8)

					if var_4_16.name == "split_1" or not string.find(var_4_16.name, "split") then
						var_4_16.gameObject:SetActive(true)
					else
						var_4_16.gameObject:SetActive(false)
					end
				end
			end

			local var_4_17 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_17 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_1_1.time_ - 1.8) / var_4_17)
			end

			if arg_1_1.time_ >= 1.8 + var_4_17 and arg_1_1.time_ < 1.8 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(0, -350, -270)
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

			if 0.500666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.500666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street")

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

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 2
			local var_4_26 = 0.7

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(423101001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 28 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 28)

				if (28 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 28)) > 0 and var_4_26 < var_4_31 then
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

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101001", "story_v_out_423101.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_423101", "423101001", "story_v_out_423101.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_423101", "423101001", "story_v_out_423101.awb")

						arg_1_1:RecordAudio("423101001", var_4_33)
						arg_1_1:RecordAudio("423101001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423101", "423101001", "story_v_out_423101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423101", "423101001", "story_v_out_423101.awb")
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
				actorName = "10148",
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
	Play423101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423101002
		arg_9_1.duration_ = 13.2

		local var_9_0 = {
			zh = 9.1,
			ja = 13.2
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
				arg_9_0:Play423101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10148 = arg_9_1.actors_["10148"].transform.localPosition
				arg_9_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10148", 3)

				for iter_12_0 = 0, arg_9_1.actors_["10148"].transform.childCount - 1 do
					local var_12_0 = arg_9_1.actors_["10148"].transform:GetChild(iter_12_0)

					if var_12_0.name == "split_3" or not string.find(var_12_0.name, "split") then
						var_12_0.gameObject:SetActive(true)
					else
						var_12_0.gameObject:SetActive(false)
					end
				end
			end

			local var_12_1 = 0.1

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_1 then
				arg_9_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_9_1.time_ - 0) / var_12_1)
			end

			if arg_9_1.time_ >= 0 + var_12_1 and arg_9_1.time_ < 0 + var_12_1 + arg_12_0 then
				arg_9_1.actors_["10148"].transform.localPosition = Vector3.New(0, -350, -270)
			end

			local var_12_2 = 0
			local var_12_3 = 1.225

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_2 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_4 = arg_9_1:GetWordFromCfg(423101002)
				local var_12_5 = arg_9_1:FormatText(var_12_4.content)

				arg_9_1.text_.text = var_12_5

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_7 = 49 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_5) / 49)

				if (49 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_5) / 49)) > 0 and var_12_3 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_2
					end
				end

				arg_9_1.text_.text = var_12_5
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101002", "story_v_out_423101.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101002", "story_v_out_423101.awb") / 1000

					if var_12_8 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_2
					end

					if var_12_4.prefab_name ~= "" and arg_9_1.actors_[var_12_4.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_4.prefab_name].transform, "story_v_out_423101", "423101002", "story_v_out_423101.awb")

						arg_9_1:RecordAudio("423101002", var_12_9)
						arg_9_1:RecordAudio("423101002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_423101", "423101002", "story_v_out_423101.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_423101", "423101002", "story_v_out_423101.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_3, arg_9_1.talkMaxDuration)

			if var_12_2 <= arg_9_1.time_ and arg_9_1.time_ < var_12_2 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_2) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_2 + var_12_10 and arg_9_1.time_ < var_12_2 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play423101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 423101003
		arg_13_1.duration_ = 8

		local var_13_0 = {
			zh = 6,
			ja = 8
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
				arg_13_0:Play423101004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10148 = arg_13_1.actors_["10148"].transform.localPosition
				arg_13_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10148", 3)

				for iter_16_0 = 0, arg_13_1.actors_["10148"].transform.childCount - 1 do
					local var_16_0 = arg_13_1.actors_["10148"].transform:GetChild(iter_16_0)

					if var_16_0.name == "split_1" or not string.find(var_16_0.name, "split") then
						var_16_0.gameObject:SetActive(true)
					else
						var_16_0.gameObject:SetActive(false)
					end
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_13_1.time_ - 0) / var_16_1)
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["10148"].transform.localPosition = Vector3.New(0, -350, -270)
			end

			local var_16_2 = 0
			local var_16_3 = 0.675

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_4 = arg_13_1:GetWordFromCfg(423101003)
				local var_16_5 = arg_13_1:FormatText(var_16_4.content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 27 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 27)

				if (27 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 27)) > 0 and var_16_3 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_2
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101003", "story_v_out_423101.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101003", "story_v_out_423101.awb") / 1000

					if var_16_8 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_2
					end

					if var_16_4.prefab_name ~= "" and arg_13_1.actors_[var_16_4.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_4.prefab_name].transform, "story_v_out_423101", "423101003", "story_v_out_423101.awb")

						arg_13_1:RecordAudio("423101003", var_16_9)
						arg_13_1:RecordAudio("423101003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_423101", "423101003", "story_v_out_423101.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_423101", "423101003", "story_v_out_423101.awb")
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
				actorName = "10148",
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
	Play423101004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 423101004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play423101005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10148"]) and arg_17_1.var_.actorSpriteComps10148 == nil then
				arg_17_1.var_.actorSpriteComps10148 = arg_17_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10148"]) then
				if arg_17_1.var_.actorSpriteComps10148 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10148"]) and arg_17_1.var_.actorSpriteComps10148 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps10148 = nil
			end

			local var_20_2 = arg_17_1.actors_["10148"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10148 = var_20_2.localPosition
				var_20_2.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10148", 7)

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
				var_20_2.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10148, Vector3.New(0, -2000, 0), (arg_17_1.time_ - 0) / var_20_4)
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_20_5 = 0
			local var_20_6 = 1.775

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

				local var_20_7 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(423101004).content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 71 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_7) / 71)

				if (71 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_7) / 71)) > 0 and var_20_6 < var_20_9 then
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
				actorName = "10148",
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
	Play423101005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 423101005
		arg_21_1.duration_ = 7.87

		local var_21_0 = {
			zh = 7.866,
			ja = 6.8
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
				arg_21_0:Play423101006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10148"]) and arg_21_1.var_.actorSpriteComps10148 == nil then
				arg_21_1.var_.actorSpriteComps10148 = arg_21_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10148"]) then
				if arg_21_1.var_.actorSpriteComps10148 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								iter_24_1.color = Color.New(Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_0), Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_0), (Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_0)))
							else
								local var_24_1 = Mathf.Lerp(iter_24_1.color.r, 1, (arg_21_1.time_ - 0) / var_24_0)

								iter_24_1.color = Color.New(var_24_1, var_24_1, var_24_1)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10148"]) and arg_21_1.var_.actorSpriteComps10148 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps10148 = nil
			end

			local var_24_2 = arg_21_1.actors_["10148"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10148 = var_24_2.localPosition
				var_24_2.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("10148", 3)

				for iter_24_4 = 0, var_24_2.childCount - 1 do
					local var_24_3 = var_24_2:GetChild(iter_24_4)

					if var_24_3.name == "split_4" or not string.find(var_24_3.name, "split") then
						var_24_3.gameObject:SetActive(true)
					else
						var_24_3.gameObject:SetActive(false)
					end
				end
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_2.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_21_1.time_ - 0) / var_24_4)
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_2.localPosition = Vector3.New(0, -350, -270)
			end

			local var_24_5 = 0
			local var_24_6 = 0.8

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(423101005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 32 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 32)

				if (32 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 32)) > 0 and var_24_6 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101005", "story_v_out_423101.awb") ~= 0 then
					local var_24_11 = manager.audio:GetVoiceLength("story_v_out_423101", "423101005", "story_v_out_423101.awb") / 1000

					if var_24_11 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_5
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_423101", "423101005", "story_v_out_423101.awb")

						arg_21_1:RecordAudio("423101005", var_24_12)
						arg_21_1:RecordAudio("423101005", var_24_12)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_423101", "423101005", "story_v_out_423101.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_423101", "423101005", "story_v_out_423101.awb")
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
				actorName = "10148",
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
	Play423101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 423101006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play423101007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10148"]) and arg_25_1.var_.actorSpriteComps10148 == nil then
				arg_25_1.var_.actorSpriteComps10148 = arg_25_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_0 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10148"]) then
				if arg_25_1.var_.actorSpriteComps10148 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_28_1 then
							if arg_25_1.isInRecall_ then
								iter_28_1.color = Color.New(Mathf.Lerp(iter_28_1.color.r, arg_25_1.hightColor2.r, (arg_25_1.time_ - 0) / var_28_0), Mathf.Lerp(iter_28_1.color.g, arg_25_1.hightColor2.g, (arg_25_1.time_ - 0) / var_28_0), (Mathf.Lerp(iter_28_1.color.b, arg_25_1.hightColor2.b, (arg_25_1.time_ - 0) / var_28_0)))
							else
								local var_28_1 = Mathf.Lerp(iter_28_1.color.r, 0.5, (arg_25_1.time_ - 0) / var_28_0)

								iter_28_1.color = Color.New(var_28_1, var_28_1, var_28_1)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10148"]) and arg_25_1.var_.actorSpriteComps10148 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_28_3 then
						iter_28_3.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps10148 = nil
			end

			local var_28_2 = 0
			local var_28_3 = 0.675

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
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

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_4 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(423101006).content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 27 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_4) / 27)

				if (27 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_4) / 27)) > 0 and var_28_3 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_3, arg_25_1.talkMaxDuration)

			if var_28_2 <= arg_25_1.time_ and arg_25_1.time_ < var_28_2 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_2) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_2 + var_28_7 and arg_25_1.time_ < var_28_2 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play423101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 423101007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play423101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.85

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(423101007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 34 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 34)

				if (34 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 34)) > 0 and var_32_0 < var_32_3 then
					arg_29_1.talkMaxDuration = var_32_3

					if var_32_3 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_3 + 0
					end
				end

				arg_29_1.text_.text = var_32_1
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_4 = math.max(var_32_0, arg_29_1.talkMaxDuration)

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - 0) / var_32_4

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play423101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 423101008
		arg_33_1.duration_ = 12.1

		local var_33_0 = {
			zh = 8.066,
			ja = 12.1
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
				arg_33_0:Play423101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10148"]) and arg_33_1.var_.actorSpriteComps10148 == nil then
				arg_33_1.var_.actorSpriteComps10148 = arg_33_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10148"]) then
				if arg_33_1.var_.actorSpriteComps10148 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								iter_36_1.color = Color.New(Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_0), Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_0), (Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_0)))
							else
								local var_36_1 = Mathf.Lerp(iter_36_1.color.r, 1, (arg_33_1.time_ - 0) / var_36_0)

								iter_36_1.color = Color.New(var_36_1, var_36_1, var_36_1)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10148"]) and arg_33_1.var_.actorSpriteComps10148 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps10148 = nil
			end

			local var_36_2 = arg_33_1.actors_["10148"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10148 = var_36_2.localPosition
				var_36_2.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10148", 3)

				for iter_36_4 = 0, var_36_2.childCount - 1 do
					local var_36_3 = var_36_2:GetChild(iter_36_4)

					if var_36_3.name == "" or not string.find(var_36_3.name, "split") then
						var_36_3.gameObject:SetActive(true)
					else
						var_36_3.gameObject:SetActive(false)
					end
				end
			end

			local var_36_4 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				var_36_2.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_33_1.time_ - 0) / var_36_4)
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				var_36_2.localPosition = Vector3.New(0, -350, -270)
			end

			local var_36_5 = 0
			local var_36_6 = 1.05

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_7 = arg_33_1:GetWordFromCfg(423101008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 42 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 42)

				if (42 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 42)) > 0 and var_36_6 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101008", "story_v_out_423101.awb") ~= 0 then
					local var_36_11 = manager.audio:GetVoiceLength("story_v_out_423101", "423101008", "story_v_out_423101.awb") / 1000

					if var_36_11 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_5
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_423101", "423101008", "story_v_out_423101.awb")

						arg_33_1:RecordAudio("423101008", var_36_12)
						arg_33_1:RecordAudio("423101008", var_36_12)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_423101", "423101008", "story_v_out_423101.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_423101", "423101008", "story_v_out_423101.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_13 = math.max(var_36_6, arg_33_1.talkMaxDuration)

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_13 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_5) / var_36_13

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_5 + var_36_13 and arg_33_1.time_ < var_36_5 + var_36_13 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423101009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 423101009
		arg_37_1.duration_ = 6.6

		local var_37_0 = {
			zh = 5.466,
			ja = 6.6
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
				arg_37_0:Play423101010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.825

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_1 = arg_37_1:GetWordFromCfg(423101009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 33 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 33)

				if (33 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 33)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101009", "story_v_out_423101.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101009", "story_v_out_423101.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_423101", "423101009", "story_v_out_423101.awb")

						arg_37_1:RecordAudio("423101009", var_40_6)
						arg_37_1:RecordAudio("423101009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_423101", "423101009", "story_v_out_423101.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_423101", "423101009", "story_v_out_423101.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_0, arg_37_1.talkMaxDuration)

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - 0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play423101010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 423101010
		arg_41_1.duration_ = 9.7

		local var_41_0 = {
			zh = 5.4,
			ja = 9.7
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
				arg_41_0:Play423101011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10148 = arg_41_1.actors_["10148"].transform.localPosition
				arg_41_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10148", 3)

				for iter_44_0 = 0, arg_41_1.actors_["10148"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["10148"].transform:GetChild(iter_44_0)

					if var_44_0.name == "split_2" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["10148"].transform.localPosition = Vector3.New(0, -350, -270)
			end

			local var_44_2 = 0
			local var_44_3 = 0.65

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_4 = arg_41_1:GetWordFromCfg(423101010)
				local var_44_5 = arg_41_1:FormatText(var_44_4.content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 26 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 26)

				if (26 <= 0 and var_44_3 or var_44_3 * (utf8.len(var_44_5) / 26)) > 0 and var_44_3 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_2
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101010", "story_v_out_423101.awb") ~= 0 then
					local var_44_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101010", "story_v_out_423101.awb") / 1000

					if var_44_8 + var_44_2 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_8 + var_44_2
					end

					if var_44_4.prefab_name ~= "" and arg_41_1.actors_[var_44_4.prefab_name] ~= nil then
						local var_44_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_4.prefab_name].transform, "story_v_out_423101", "423101010", "story_v_out_423101.awb")

						arg_41_1:RecordAudio("423101010", var_44_9)
						arg_41_1:RecordAudio("423101010", var_44_9)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_423101", "423101010", "story_v_out_423101.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_423101", "423101010", "story_v_out_423101.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_3, arg_41_1.talkMaxDuration)

			if var_44_2 <= arg_41_1.time_ and arg_41_1.time_ < var_44_2 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_2) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_2 + var_44_10 and arg_41_1.time_ < var_44_2 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423101011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 423101011
		arg_45_1.duration_ = 7.53

		local var_45_0 = {
			zh = 5.966,
			ja = 7.533
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
				arg_45_0:Play423101012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 2 < arg_45_1.time_ and arg_45_1.time_ <= 2 + arg_48_0 then
				local var_48_0 = arg_45_1.bgs_.I25h

				arg_45_1.bgs_.I25h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_48_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_48_1 = var_48_0:GetComponent("SpriteRenderer")

				if var_48_1 and var_48_1.sprite then
					local var_48_2 = 2 * (var_48_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_48_0.transform.localScale = Vector3.New(var_48_2 / var_48_1.sprite.bounds.size.y < var_48_2 * manager.ui.mainCameraCom_.aspect / var_48_1.sprite.bounds.size.x and var_48_2 * manager.ui.mainCameraCom_.aspect / var_48_1.sprite.bounds.size.x or var_48_2 / var_48_1.sprite.bounds.size.y, var_48_2 / var_48_1.sprite.bounds.size.y < var_48_2 * manager.ui.mainCameraCom_.aspect / var_48_1.sprite.bounds.size.x and var_48_2 * manager.ui.mainCameraCom_.aspect / var_48_1.sprite.bounds.size.x or var_48_2 / var_48_1.sprite.bounds.size.y, 0)
				end

				for iter_48_0, iter_48_1 in pairs(arg_45_1.bgs_) do
					if iter_48_0 ~= "I25h" then
						iter_48_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_48_3 = 4

			if 4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_3 + arg_48_0 then
				arg_45_1.allBtn_.enabled = false
			end

			if arg_45_1.time_ >= var_48_3 + 0.3 and arg_45_1.time_ < var_48_3 + 0.3 + arg_48_0 then
				arg_45_1.allBtn_.enabled = true
			end

			local var_48_4 = 0

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_5 = 2

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_5 then
				local var_48_6 = Color.New(0, 0, 0)

				var_48_6.a = Mathf.Lerp(0, 1, (arg_45_1.time_ - var_48_4) / var_48_5)
				arg_45_1.mask_.color = var_48_6
			end

			if arg_45_1.time_ >= var_48_4 + var_48_5 and arg_45_1.time_ < var_48_4 + var_48_5 + arg_48_0 then
				local var_48_7 = Color.New(0, 0, 0)

				var_48_7.a = 1
				arg_45_1.mask_.color = var_48_7
			end

			local var_48_8 = 2

			if 2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.mask_.enabled = true
				arg_45_1.mask_.raycastTarget = true

				arg_45_1:SetGaussion(false)
			end

			local var_48_9 = 2

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_9 then
				local var_48_10 = Color.New(0, 0, 0)

				var_48_10.a = Mathf.Lerp(1, 0, (arg_45_1.time_ - var_48_8) / var_48_9)
				arg_45_1.mask_.color = var_48_10
			end

			if arg_45_1.time_ >= var_48_8 + var_48_9 and arg_45_1.time_ < var_48_8 + var_48_9 + arg_48_0 then
				local var_48_11 = Color.New(0, 0, 0)

				arg_45_1.mask_.enabled = false
				var_48_11.a = 0
				arg_45_1.mask_.color = var_48_11
			end

			local var_48_12 = arg_45_1.actors_["10148"].transform

			if 4 < arg_45_1.time_ and arg_45_1.time_ <= 4 + arg_48_0 then
				arg_45_1.var_.moveOldPos10148 = var_48_12.localPosition
				var_48_12.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10148", 3)

				for iter_48_2 = 0, var_48_12.childCount - 1 do
					local var_48_13 = var_48_12:GetChild(iter_48_2)

					if var_48_13.name == "" or not string.find(var_48_13.name, "split") then
						var_48_13.gameObject:SetActive(true)
					else
						var_48_13.gameObject:SetActive(false)
					end
				end
			end

			local var_48_14 = 0.001

			if 4 <= arg_45_1.time_ and arg_45_1.time_ < 4 + var_48_14 then
				var_48_12.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10148, Vector3.New(0, -350, -270), (arg_45_1.time_ - 4) / var_48_14)
			end

			if arg_45_1.time_ >= 4 + var_48_14 and arg_45_1.time_ < 4 + var_48_14 + arg_48_0 then
				var_48_12.localPosition = Vector3.New(0, -350, -270)
			end

			local var_48_15 = arg_45_1.actors_["10148"].transform

			if 1.966 < arg_45_1.time_ and arg_45_1.time_ <= 1.966 + arg_48_0 then
				arg_45_1.var_.moveOldPos10148 = var_48_15.localPosition
				var_48_15.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10148", 7)

				for iter_48_3 = 0, var_48_15.childCount - 1 do
					local var_48_16 = var_48_15:GetChild(iter_48_3)

					if var_48_16.name == "" or not string.find(var_48_16.name, "split") then
						var_48_16.gameObject:SetActive(true)
					else
						var_48_16.gameObject:SetActive(false)
					end
				end
			end

			local var_48_17 = 0.001

			if 1.966 <= arg_45_1.time_ and arg_45_1.time_ < 1.966 + var_48_17 then
				var_48_15.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10148, Vector3.New(0, -2000, 0), (arg_45_1.time_ - 1.966) / var_48_17)
			end

			if arg_45_1.time_ >= 1.966 + var_48_17 and arg_45_1.time_ < 1.966 + var_48_17 + arg_48_0 then
				var_48_15.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_45_1.frameCnt_ <= 1 then
				arg_45_1.dialog_:SetActive(false)
			end

			local var_48_18 = 4
			local var_48_19 = 0.175

			if 4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_18 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0

				arg_45_1.dialog_:SetActive(true)

				arg_45_1.dialogCg_.alpha = 0

				local var_48_20 = LeanTween.value(arg_45_1.dialog_, 0, 1, 0.3)

				var_48_20:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_45_1.dialogCg_.alpha = arg_49_0
				end))
				var_48_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_45_1.dialog_)
					var_48_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_45_1.duration_ = arg_45_1.duration_ + 0.3

				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_21 = arg_45_1:GetWordFromCfg(423101011)
				local var_48_22 = arg_45_1:FormatText(var_48_21.content)

				arg_45_1.text_.text = var_48_22

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_24 = 7 <= 0 and var_48_19 or var_48_19 * (utf8.len(var_48_22) / 7)

				if (7 <= 0 and var_48_19 or var_48_19 * (utf8.len(var_48_22) / 7)) > 0 and var_48_19 < var_48_24 then
					arg_45_1.talkMaxDuration = var_48_24
					var_48_18 = var_48_18 + 0.3

					if var_48_24 + var_48_18 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_24 + var_48_18
					end
				end

				arg_45_1.text_.text = var_48_22
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101011", "story_v_out_423101.awb") ~= 0 then
					local var_48_25 = manager.audio:GetVoiceLength("story_v_out_423101", "423101011", "story_v_out_423101.awb") / 1000

					if var_48_25 + var_48_18 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_25 + var_48_18
					end

					if var_48_21.prefab_name ~= "" and arg_45_1.actors_[var_48_21.prefab_name] ~= nil then
						local var_48_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_21.prefab_name].transform, "story_v_out_423101", "423101011", "story_v_out_423101.awb")

						arg_45_1:RecordAudio("423101011", var_48_26)
						arg_45_1:RecordAudio("423101011", var_48_26)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_423101", "423101011", "story_v_out_423101.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_423101", "423101011", "story_v_out_423101.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_27 = var_48_18 + 0.3
			local var_48_28 = math.max(var_48_19, arg_45_1.talkMaxDuration)

			if var_48_18 + 0.3 <= arg_45_1.time_ and arg_45_1.time_ < var_48_27 + var_48_28 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_27) / var_48_28

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_27 + var_48_28 and arg_45_1.time_ < var_48_27 + var_48_28 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play423101012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 423101012
		arg_51_1.duration_ = 7.6

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play423101013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_9000

			if 0.466 < arg_51_1.time_ and arg_51_1.time_ <= 0.466 + arg_54_0 then
				arg_51_1.var_.moveOldPos10148 = arg_51_1.actors_["10148"].transform.localPosition
				arg_51_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("10148", 7)

				for iter_54_0 = 0, arg_51_1.actors_["10148"].transform.childCount - 1 do
					local var_54_0 = arg_51_1.actors_["10148"].transform:GetChild(iter_54_0)

					if var_54_0.name == "" or not string.find(var_54_0.name, "split") then
						var_54_0.gameObject:SetActive(true)
					else
						var_54_0.gameObject:SetActive(false)
					end
				end
			end

			local var_54_1 = 0.001

			if 0.466 <= arg_51_1.time_ and arg_51_1.time_ < 0.466 + var_54_1 then
				arg_51_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10148, Vector3.New(0, -2000, 0), (arg_51_1.time_ - 0.466) / var_54_1)
			end

			if arg_51_1.time_ >= 0.466 + var_54_1 and arg_51_1.time_ < 0.466 + var_54_1 + arg_54_0 then
				arg_51_1.actors_["10148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_54_2 = 0

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_2 + arg_54_0 then
				arg_51_1.mask_.enabled = true
				arg_51_1.mask_.raycastTarget = true

				arg_51_1:SetGaussion(false)
			end

			local var_54_3 = 0.5

			if var_54_2 <= arg_51_1.time_ and arg_51_1.time_ < var_54_2 + var_54_3 then
				local var_54_4 = Color.New(1, 1, 1)

				var_54_4.a = Mathf.Lerp(0, 1, (arg_51_1.time_ - var_54_2) / var_54_3)
				arg_51_1.mask_.color = var_54_4
			end

			if arg_51_1.time_ >= var_54_2 + var_54_3 and arg_51_1.time_ < var_54_2 + var_54_3 + arg_54_0 then
				local var_54_5 = Color.New(1, 1, 1)

				var_54_5.a = 1
				arg_51_1.mask_.color = var_54_5
			end

			local var_54_6 = 0.5

			if 0.5 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				arg_51_1.mask_.enabled = true
				arg_51_1.mask_.raycastTarget = true

				arg_51_1:SetGaussion(false)
			end

			local var_54_7 = 0.5

			if var_54_6 <= arg_51_1.time_ and arg_51_1.time_ < var_54_6 + var_54_7 then
				local var_54_8 = Color.New(1, 1, 1)

				var_54_8.a = Mathf.Lerp(1, 0, (arg_51_1.time_ - var_54_6) / var_54_7)
				arg_51_1.mask_.color = var_54_8
			end

			if arg_51_1.time_ >= var_54_6 + var_54_7 and arg_51_1.time_ < var_54_6 + var_54_7 + arg_54_0 then
				local var_54_9 = Color.New(1, 1, 1)

				arg_51_1.mask_.enabled = false
				var_54_9.a = 0
				arg_51_1.mask_.color = var_54_9
			end

			if 1 < arg_51_1.time_ and arg_51_1.time_ <= 1 + arg_54_0 then
				local var_54_10 = arg_51_1.var_.effectdianyingkaipai1

				if not arg_51_1.var_.effectdianyingkaipai1 then
					var_54_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_moviemask"), manager.ui.mainCamera.transform)
					var_54_10.name = "dianyingkaipai1"
					arg_51_1.var_.effectdianyingkaipai1 = var_54_10
				else
					var_54_10.transform:SetParent(var_54_9000)
				end

				var_54_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_54_10.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_54_12 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_54_13 = var_54_10.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_54_1, iter_54_2 in ipairs((var_54_13:ToTable())) do
					iter_54_2.transform.localScale = Vector3.New(iter_54_2.transform.localScale.x / var_54_12 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_54_13 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_54_2.transform.localScale.y / var_54_12, iter_54_2.transform.localScale.z)
				end
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_54_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_51_1.bgmTxt_.text ~= var_54_17 and arg_51_1.bgmTxt_.text ~= "" then
						if arg_51_1.bgmTxt2_.text ~= "" then
							arg_51_1.bgmTxt_.text = arg_51_1.bgmTxt2_.text
						end

						arg_51_1.bgmTxt2_.text = var_54_17

						arg_51_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_51_1.bgmTxt_.text = var_54_17
						arg_51_1.bgmTxt2_.text = var_54_17
					end

					if arg_51_1.bgmTimer then
						arg_51_1.bgmTimer:Stop()

						arg_51_1.bgmTimer = nil
					end

					if arg_51_1.settingData.show_music_name == 1 then
						arg_51_1.musicController:SetSelectedState("show")
						arg_51_1.musicAnimator_:Play("open", 0, 0)

						if arg_51_1.settingData.music_time ~= 0 then
							arg_51_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_51_1.settingData.music_time), function()
								if arg_51_1 == nil or isNil(arg_51_1.bgmTxt_) then
									return
								end

								arg_51_1.musicController:SetSelectedState("hide")
								arg_51_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.500666666666667 < arg_51_1.time_ and arg_51_1.time_ <= 0.500666666666667 + arg_54_0 then
				arg_51_1:AudioAction("play", "music", "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous.awb")

				local var_54_20 = manager.audio:GetAudioName("bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous")

				if "" ~= "" then
					if arg_51_1.bgmTxt_.text ~= var_54_20 and arg_51_1.bgmTxt_.text ~= "" then
						if arg_51_1.bgmTxt2_.text ~= "" then
							arg_51_1.bgmTxt_.text = arg_51_1.bgmTxt2_.text
						end

						arg_51_1.bgmTxt2_.text = var_54_20

						arg_51_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_51_1.bgmTxt_.text = var_54_20
						arg_51_1.bgmTxt2_.text = var_54_20
					end

					if arg_51_1.bgmTimer then
						arg_51_1.bgmTimer:Stop()

						arg_51_1.bgmTimer = nil
					end

					if arg_51_1.settingData.show_music_name == 1 then
						arg_51_1.musicController:SetSelectedState("show")
						arg_51_1.musicAnimator_:Play("open", 0, 0)

						if arg_51_1.settingData.music_time ~= 0 then
							arg_51_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_51_1.settingData.music_time), function()
								if arg_51_1 == nil or isNil(arg_51_1.bgmTxt_) then
									return
								end

								arg_51_1.musicController:SetSelectedState("hide")
								arg_51_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.133333333333333 < arg_51_1.time_ and arg_51_1.time_ <= 0.133333333333333 + arg_54_0 then
				arg_51_1:AudioAction("play", "effect", "se_story_144", "se_story_144_clap04", "")
			end

			if arg_51_1.frameCnt_ <= 1 then
				arg_51_1.dialog_:SetActive(false)
			end

			local var_54_22 = 2.6
			local var_54_23 = 1.875

			if 2.6 < arg_51_1.time_ and arg_51_1.time_ <= var_54_22 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0

				arg_51_1.dialog_:SetActive(true)

				arg_51_1.dialogCg_.alpha = 0

				local var_54_24 = LeanTween.value(arg_51_1.dialog_, 0, 1, 0.3)

				var_54_24:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_51_1.dialogCg_.alpha = arg_57_0
				end))
				var_54_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_51_1.dialog_)
					var_54_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_51_1.duration_ = arg_51_1.duration_ + 0.3

				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_25 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(423101012).content)

				arg_51_1.text_.text = var_54_25

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_27 = 75 <= 0 and var_54_23 or var_54_23 * (utf8.len(var_54_25) / 75)

				if (75 <= 0 and var_54_23 or var_54_23 * (utf8.len(var_54_25) / 75)) > 0 and var_54_23 < var_54_27 then
					arg_51_1.talkMaxDuration = var_54_27
					var_54_22 = var_54_22 + 0.3

					if var_54_27 + var_54_22 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_27 + var_54_22
					end
				end

				arg_51_1.text_.text = var_54_25
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_28 = var_54_22 + 0.3
			local var_54_29 = math.max(var_54_23, arg_51_1.talkMaxDuration)

			if var_54_22 + 0.3 <= arg_51_1.time_ and arg_51_1.time_ < var_54_28 + var_54_29 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_28) / var_54_29

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_28 + var_54_29 and arg_51_1.time_ < var_54_28 + var_54_29 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.466,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play423101013 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 423101013
		arg_59_1.duration_ = 8.63

		local var_59_0 = {
			zh = 6.2,
			ja = 8.633
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
				arg_59_0:Play423101014(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0.166666666666667 < arg_59_1.time_ and arg_59_1.time_ <= 0.166666666666667 + arg_62_0 then
				arg_59_1:AudioAction("play", "effect", "se_story_side_1067", "se_story_1067_horse01", "")
			end

			local var_62_1 = 0
			local var_62_2 = 0.6

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[1343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:GetWordFromCfg(423101013)
				local var_62_4 = arg_59_1:FormatText(var_62_3.content)

				arg_59_1.text_.text = var_62_4

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_6 = 24 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_4) / 24)

				if (24 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_4) / 24)) > 0 and var_62_2 < var_62_6 then
					arg_59_1.talkMaxDuration = var_62_6

					if var_62_6 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_1
					end
				end

				arg_59_1.text_.text = var_62_4
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101013", "story_v_out_423101.awb") ~= 0 then
					local var_62_7 = manager.audio:GetVoiceLength("story_v_out_423101", "423101013", "story_v_out_423101.awb") / 1000

					if var_62_7 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_1
					end

					if var_62_3.prefab_name ~= "" and arg_59_1.actors_[var_62_3.prefab_name] ~= nil then
						local var_62_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_3.prefab_name].transform, "story_v_out_423101", "423101013", "story_v_out_423101.awb")

						arg_59_1:RecordAudio("423101013", var_62_8)
						arg_59_1:RecordAudio("423101013", var_62_8)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_423101", "423101013", "story_v_out_423101.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_423101", "423101013", "story_v_out_423101.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_9 = math.max(var_62_2, arg_59_1.talkMaxDuration)

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_9 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_1) / var_62_9

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_1 + var_62_9 and arg_59_1.time_ < var_62_1 + var_62_9 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play423101014 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 423101014
		arg_63_1.duration_ = 5.43

		local var_63_0 = {
			zh = 4.433,
			ja = 5.433
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
				arg_63_0:Play423101015(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.525

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[1343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:GetWordFromCfg(423101014)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 21 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 21)

				if (21 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 21)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101014", "story_v_out_423101.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101014", "story_v_out_423101.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_423101", "423101014", "story_v_out_423101.awb")

						arg_63_1:RecordAudio("423101014", var_66_6)
						arg_63_1:RecordAudio("423101014", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_423101", "423101014", "story_v_out_423101.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_423101", "423101014", "story_v_out_423101.awb")
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
	Play423101015 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 423101015
		arg_67_1.duration_ = 7.9

		local var_67_0 = {
			zh = 7.133,
			ja = 7.9
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
				arg_67_0:Play423101016(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.6

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[1344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:GetWordFromCfg(423101015)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 24 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 24)

				if (24 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 24)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101015", "story_v_out_423101.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101015", "story_v_out_423101.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_423101", "423101015", "story_v_out_423101.awb")

						arg_67_1:RecordAudio("423101015", var_70_6)
						arg_67_1:RecordAudio("423101015", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_423101", "423101015", "story_v_out_423101.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_423101", "423101015", "story_v_out_423101.awb")
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
	Play423101016 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 423101016
		arg_71_1.duration_ = 5.73

		local var_71_0 = {
			zh = 4.2,
			ja = 5.733
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
				arg_71_0:Play423101017(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0.4

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[1343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_1 = arg_71_1:GetWordFromCfg(423101016)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 16 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 16)

				if (16 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 16)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101016", "story_v_out_423101.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101016", "story_v_out_423101.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_423101", "423101016", "story_v_out_423101.awb")

						arg_71_1:RecordAudio("423101016", var_74_6)
						arg_71_1:RecordAudio("423101016", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_423101", "423101016", "story_v_out_423101.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_423101", "423101016", "story_v_out_423101.awb")
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
	Play423101017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 423101017
		arg_75_1.duration_ = 8.23

		local var_75_0 = {
			zh = 5.333,
			ja = 8.233
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
				arg_75_0:Play423101018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.475

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[1344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_1 = arg_75_1:GetWordFromCfg(423101017)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 19 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 19)

				if (19 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 19)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101017", "story_v_out_423101.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101017", "story_v_out_423101.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_out_423101", "423101017", "story_v_out_423101.awb")

						arg_75_1:RecordAudio("423101017", var_78_6)
						arg_75_1:RecordAudio("423101017", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_423101", "423101017", "story_v_out_423101.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_423101", "423101017", "story_v_out_423101.awb")
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
	Play423101018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 423101018
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play423101019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 1.4

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_1 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(423101018).content)

				arg_79_1.text_.text = var_82_1

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_3 = 56 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 56)

				if (56 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_1) / 56)) > 0 and var_82_0 < var_82_3 then
					arg_79_1.talkMaxDuration = var_82_3

					if var_82_3 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_3 + 0
					end
				end

				arg_79_1.text_.text = var_82_1
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_4 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_4

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play423101019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 423101019
		arg_83_1.duration_ = 13.6

		local var_83_0 = {
			zh = 8.566,
			ja = 13.6
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
				arg_83_0:Play423101020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.8

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[1344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_1 = arg_83_1:GetWordFromCfg(423101019)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 32 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 32)

				if (32 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 32)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101019", "story_v_out_423101.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101019", "story_v_out_423101.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_423101", "423101019", "story_v_out_423101.awb")

						arg_83_1:RecordAudio("423101019", var_86_6)
						arg_83_1:RecordAudio("423101019", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_423101", "423101019", "story_v_out_423101.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_423101", "423101019", "story_v_out_423101.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play423101020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 423101020
		arg_87_1.duration_ = 11.03

		local var_87_0 = {
			zh = 7.9,
			ja = 11.033
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
				arg_87_0:Play423101021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if arg_87_1.actors_["1083"] == nil then
				local var_90_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

				if not isNil(var_90_0) then
					local var_90_1 = Object.Instantiate(var_90_0, arg_87_1.canvasGo_.transform)

					var_90_1.transform:SetSiblingIndex(1)

					var_90_1.name = "1083"
					var_90_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_87_1.actors_["1083"] = var_90_1

					if arg_87_1.isInRecall_ then
						for iter_90_0, iter_90_1 in ipairs((var_90_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_90_1.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_90_2 = arg_87_1.actors_["1083"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.actorSpriteComps1083 == nil then
				arg_87_1.var_.actorSpriteComps1083 = var_90_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_3 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 and not isNil(var_90_2) then
				if arg_87_1.var_.actorSpriteComps1083 then
					for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_90_3 then
							if arg_87_1.isInRecall_ then
								iter_90_3.color = Color.New(Mathf.Lerp(iter_90_3.color.r, arg_87_1.hightColor1.r, (arg_87_1.time_ - 0) / var_90_3), Mathf.Lerp(iter_90_3.color.g, arg_87_1.hightColor1.g, (arg_87_1.time_ - 0) / var_90_3), (Mathf.Lerp(iter_90_3.color.b, arg_87_1.hightColor1.b, (arg_87_1.time_ - 0) / var_90_3)))
							else
								local var_90_4 = Mathf.Lerp(iter_90_3.color.r, 1, (arg_87_1.time_ - 0) / var_90_3)

								iter_90_3.color = Color.New(var_90_4, var_90_4, var_90_4)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.actorSpriteComps1083 then
				for iter_90_4, iter_90_5 in pairs(arg_87_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_90_5 then
						iter_90_5.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_87_1.var_.actorSpriteComps1083 = nil
			end

			local var_90_5 = arg_87_1.actors_["1083"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1083 = var_90_5.localPosition
				var_90_5.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("1083", 3)

				for iter_90_6 = 0, var_90_5.childCount - 1 do
					local var_90_6 = var_90_5:GetChild(iter_90_6)

					if var_90_6.name == "split_7" or not string.find(var_90_6.name, "split") then
						var_90_6.gameObject:SetActive(true)
					else
						var_90_6.gameObject:SetActive(false)
					end
				end
			end

			local var_90_7 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				var_90_5.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_87_1.time_ - 0) / var_90_7)
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				var_90_5.localPosition = Vector3.New(-50, -345, -345)
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				local var_90_8 = arg_87_1.actors_["1083"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_90_8 then
					arg_87_1.var_.alphaOldValue1083 = var_90_8.alpha
					arg_87_1.var_.characterEffect1083 = var_90_8
				end

				arg_87_1.var_.alphaOldValue1083 = 0
			end

			local var_90_9 = 0.5

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_9 then
				if arg_87_1.var_.characterEffect1083 then
					arg_87_1.var_.characterEffect1083.alpha = Mathf.Lerp(arg_87_1.var_.alphaOldValue1083, 1, (arg_87_1.time_ - 0) / var_90_9)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_9 and arg_87_1.time_ < 0 + var_90_9 + arg_90_0 and arg_87_1.var_.characterEffect1083 then
				arg_87_1.var_.characterEffect1083.alpha = 1
			end

			local var_90_10 = 0
			local var_90_11 = 0.85

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[1345].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_12 = arg_87_1:GetWordFromCfg(423101020)
				local var_90_13 = arg_87_1:FormatText(var_90_12.content)

				arg_87_1.text_.text = var_90_13

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_15 = 34 <= 0 and var_90_11 or var_90_11 * (utf8.len(var_90_13) / 34)

				if (34 <= 0 and var_90_11 or var_90_11 * (utf8.len(var_90_13) / 34)) > 0 and var_90_11 < var_90_15 then
					arg_87_1.talkMaxDuration = var_90_15

					if var_90_15 + var_90_10 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_15 + var_90_10
					end
				end

				arg_87_1.text_.text = var_90_13
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101020", "story_v_out_423101.awb") ~= 0 then
					local var_90_16 = manager.audio:GetVoiceLength("story_v_out_423101", "423101020", "story_v_out_423101.awb") / 1000

					if var_90_16 + var_90_10 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_16 + var_90_10
					end

					if var_90_12.prefab_name ~= "" and arg_87_1.actors_[var_90_12.prefab_name] ~= nil then
						local var_90_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_12.prefab_name].transform, "story_v_out_423101", "423101020", "story_v_out_423101.awb")

						arg_87_1:RecordAudio("423101020", var_90_17)
						arg_87_1:RecordAudio("423101020", var_90_17)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_423101", "423101020", "story_v_out_423101.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_423101", "423101020", "story_v_out_423101.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_18 = math.max(var_90_11, arg_87_1.talkMaxDuration)

			if var_90_10 <= arg_87_1.time_ and arg_87_1.time_ < var_90_10 + var_90_18 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_10) / var_90_18

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_10 + var_90_18 and arg_87_1.time_ < var_90_10 + var_90_18 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play423101021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 423101021
		arg_91_1.duration_ = 5.63

		local var_91_0 = {
			zh = 4.266,
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
				arg_91_0:Play423101022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1083 = arg_91_1.actors_["1083"].transform.localPosition
				arg_91_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("1083", 3)

				for iter_94_0 = 0, arg_91_1.actors_["1083"].transform.childCount - 1 do
					local var_94_0 = arg_91_1.actors_["1083"].transform:GetChild(iter_94_0)

					if var_94_0.name == "split_8" or not string.find(var_94_0.name, "split") then
						var_94_0.gameObject:SetActive(true)
					else
						var_94_0.gameObject:SetActive(false)
					end
				end
			end

			local var_94_1 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_1 then
				arg_91_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_91_1.time_ - 0) / var_94_1)
			end

			if arg_91_1.time_ >= 0 + var_94_1 and arg_91_1.time_ < 0 + var_94_1 + arg_94_0 then
				arg_91_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_94_2 = 0
			local var_94_3 = 0.525

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_2 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[1345].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_4 = arg_91_1:GetWordFromCfg(423101021)
				local var_94_5 = arg_91_1:FormatText(var_94_4.content)

				arg_91_1.text_.text = var_94_5

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_7 = 21 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_5) / 21)

				if (21 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_5) / 21)) > 0 and var_94_3 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_2
					end
				end

				arg_91_1.text_.text = var_94_5
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101021", "story_v_out_423101.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101021", "story_v_out_423101.awb") / 1000

					if var_94_8 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_2
					end

					if var_94_4.prefab_name ~= "" and arg_91_1.actors_[var_94_4.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_4.prefab_name].transform, "story_v_out_423101", "423101021", "story_v_out_423101.awb")

						arg_91_1:RecordAudio("423101021", var_94_9)
						arg_91_1:RecordAudio("423101021", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_423101", "423101021", "story_v_out_423101.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_423101", "423101021", "story_v_out_423101.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_3, arg_91_1.talkMaxDuration)

			if var_94_2 <= arg_91_1.time_ and arg_91_1.time_ < var_94_2 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_2) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_2 + var_94_10 and arg_91_1.time_ < var_94_2 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play423101022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 423101022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play423101023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1083"]) and arg_95_1.var_.actorSpriteComps1083 == nil then
				arg_95_1.var_.actorSpriteComps1083 = arg_95_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_0 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1083"]) then
				if arg_95_1.var_.actorSpriteComps1083 then
					for iter_98_0, iter_98_1 in pairs(arg_95_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1083"]) and arg_95_1.var_.actorSpriteComps1083 then
				for iter_98_2, iter_98_3 in pairs(arg_95_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_98_3 then
						iter_98_3.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_95_1.var_.actorSpriteComps1083 = nil
			end

			local var_98_2 = arg_95_1.actors_["1083"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1083 = var_98_2.localPosition
				var_98_2.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("1083", 7)

				for iter_98_4 = 0, var_98_2.childCount - 1 do
					local var_98_3 = var_98_2:GetChild(iter_98_4)

					if var_98_3.name == "" or not string.find(var_98_3.name, "split") then
						var_98_3.gameObject:SetActive(true)
					else
						var_98_3.gameObject:SetActive(false)
					end
				end
			end

			local var_98_4 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				var_98_2.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_95_1.time_ - 0) / var_98_4)
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				var_98_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.166666666666667 < arg_95_1.time_ and arg_95_1.time_ <= 0.166666666666667 + arg_98_0 then
				arg_95_1:AudioAction("play", "effect", "se_story_side_1067", "se_story_1067_horse02", "")
			end

			local var_98_6 = 0
			local var_98_7 = 1.825

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_8 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(423101022).content)

				arg_95_1.text_.text = var_98_8

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_10 = 73 <= 0 and var_98_7 or var_98_7 * (utf8.len(var_98_8) / 73)

				if (73 <= 0 and var_98_7 or var_98_7 * (utf8.len(var_98_8) / 73)) > 0 and var_98_7 < var_98_10 then
					arg_95_1.talkMaxDuration = var_98_10

					if var_98_10 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_8
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_11 = math.max(var_98_7, arg_95_1.talkMaxDuration)

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_11 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_6) / var_98_11

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_6 + var_98_11 and arg_95_1.time_ < var_98_6 + var_98_11 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423101023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 423101023
		arg_99_1.duration_ = 14.27

		local var_99_0 = {
			zh = 11.333,
			ja = 14.266
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
				arg_99_0:Play423101024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 1.15

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[1343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_1 = arg_99_1:GetWordFromCfg(423101023)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 46 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 46)

				if (46 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 46)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101023", "story_v_out_423101.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101023", "story_v_out_423101.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_423101", "423101023", "story_v_out_423101.awb")

						arg_99_1:RecordAudio("423101023", var_102_6)
						arg_99_1:RecordAudio("423101023", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_423101", "423101023", "story_v_out_423101.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_423101", "423101023", "story_v_out_423101.awb")
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
	Play423101024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 423101024
		arg_103_1.duration_ = 11.13

		local var_103_0 = {
			zh = 10.2,
			ja = 11.133
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
				arg_103_0:Play423101025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1083"]) and arg_103_1.var_.actorSpriteComps1083 == nil then
				arg_103_1.var_.actorSpriteComps1083 = arg_103_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_0 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1083"]) then
				if arg_103_1.var_.actorSpriteComps1083 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_106_1 then
							if arg_103_1.isInRecall_ then
								iter_106_1.color = Color.New(Mathf.Lerp(iter_106_1.color.r, arg_103_1.hightColor1.r, (arg_103_1.time_ - 0) / var_106_0), Mathf.Lerp(iter_106_1.color.g, arg_103_1.hightColor1.g, (arg_103_1.time_ - 0) / var_106_0), (Mathf.Lerp(iter_106_1.color.b, arg_103_1.hightColor1.b, (arg_103_1.time_ - 0) / var_106_0)))
							else
								local var_106_1 = Mathf.Lerp(iter_106_1.color.r, 1, (arg_103_1.time_ - 0) / var_106_0)

								iter_106_1.color = Color.New(var_106_1, var_106_1, var_106_1)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1083"]) and arg_103_1.var_.actorSpriteComps1083 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_106_3 then
						iter_106_3.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_103_1.var_.actorSpriteComps1083 = nil
			end

			local var_106_2 = arg_103_1.actors_["1083"].transform

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1083 = var_106_2.localPosition
				var_106_2.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("1083", 3)

				for iter_106_4 = 0, var_106_2.childCount - 1 do
					local var_106_3 = var_106_2:GetChild(iter_106_4)

					if var_106_3.name == "" or not string.find(var_106_3.name, "split") then
						var_106_3.gameObject:SetActive(true)
					else
						var_106_3.gameObject:SetActive(false)
					end
				end
			end

			local var_106_4 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				var_106_2.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_103_1.time_ - 0) / var_106_4)
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				var_106_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_106_5 = 0
			local var_106_6 = 1.1

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[1345].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_7 = arg_103_1:GetWordFromCfg(423101024)
				local var_106_8 = arg_103_1:FormatText(var_106_7.content)

				arg_103_1.text_.text = var_106_8

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 44 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 44)

				if (44 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 44)) > 0 and var_106_6 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_5
					end
				end

				arg_103_1.text_.text = var_106_8
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101024", "story_v_out_423101.awb") ~= 0 then
					local var_106_11 = manager.audio:GetVoiceLength("story_v_out_423101", "423101024", "story_v_out_423101.awb") / 1000

					if var_106_11 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_11 + var_106_5
					end

					if var_106_7.prefab_name ~= "" and arg_103_1.actors_[var_106_7.prefab_name] ~= nil then
						local var_106_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_7.prefab_name].transform, "story_v_out_423101", "423101024", "story_v_out_423101.awb")

						arg_103_1:RecordAudio("423101024", var_106_12)
						arg_103_1:RecordAudio("423101024", var_106_12)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_423101", "423101024", "story_v_out_423101.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_423101", "423101024", "story_v_out_423101.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_13 = math.max(var_106_6, arg_103_1.talkMaxDuration)

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_13 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_5) / var_106_13

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_5 + var_106_13 and arg_103_1.time_ < var_106_5 + var_106_13 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play423101025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 423101025
		arg_107_1.duration_ = 10.53

		local var_107_0 = {
			zh = 9.433,
			ja = 10.533
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
				arg_107_0:Play423101026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1083 = arg_107_1.actors_["1083"].transform.localPosition
				arg_107_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("1083", 3)

				for iter_110_0 = 0, arg_107_1.actors_["1083"].transform.childCount - 1 do
					local var_110_0 = arg_107_1.actors_["1083"].transform:GetChild(iter_110_0)

					if var_110_0.name == "split_7" or not string.find(var_110_0.name, "split") then
						var_110_0.gameObject:SetActive(true)
					else
						var_110_0.gameObject:SetActive(false)
					end
				end
			end

			local var_110_1 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_1 then
				arg_107_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_107_1.time_ - 0) / var_110_1)
			end

			if arg_107_1.time_ >= 0 + var_110_1 and arg_107_1.time_ < 0 + var_110_1 + arg_110_0 then
				arg_107_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_110_2 = 0
			local var_110_3 = 1.05

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_2 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[1345].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_4 = arg_107_1:GetWordFromCfg(423101025)
				local var_110_5 = arg_107_1:FormatText(var_110_4.content)

				arg_107_1.text_.text = var_110_5

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_7 = 42 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_5) / 42)

				if (42 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_5) / 42)) > 0 and var_110_3 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_2
					end
				end

				arg_107_1.text_.text = var_110_5
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101025", "story_v_out_423101.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101025", "story_v_out_423101.awb") / 1000

					if var_110_8 + var_110_2 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_2
					end

					if var_110_4.prefab_name ~= "" and arg_107_1.actors_[var_110_4.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_4.prefab_name].transform, "story_v_out_423101", "423101025", "story_v_out_423101.awb")

						arg_107_1:RecordAudio("423101025", var_110_9)
						arg_107_1:RecordAudio("423101025", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_423101", "423101025", "story_v_out_423101.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_423101", "423101025", "story_v_out_423101.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_3, arg_107_1.talkMaxDuration)

			if var_110_2 <= arg_107_1.time_ and arg_107_1.time_ < var_110_2 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_2) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_2 + var_110_10 and arg_107_1.time_ < var_110_2 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423101026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 423101026
		arg_111_1.duration_ = 13.73

		local var_111_0 = {
			zh = 8.5,
			ja = 13.733
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
				arg_111_0:Play423101027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1083"]) and arg_111_1.var_.actorSpriteComps1083 == nil then
				arg_111_1.var_.actorSpriteComps1083 = arg_111_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_0 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1083"]) then
				if arg_111_1.var_.actorSpriteComps1083 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1083"]) and arg_111_1.var_.actorSpriteComps1083 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_114_3 then
						iter_114_3.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_111_1.var_.actorSpriteComps1083 = nil
			end

			local var_114_2 = 0
			local var_114_3 = 0.925

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[1343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, true)
				arg_111_1.iconController_:SetSelectedState("hero")

				arg_111_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_111_1.callingController_:SetSelectedState("normal")

				arg_111_1.keyicon_.color = Color.New(1, 1, 1)
				arg_111_1.icon_.color = Color.New(1, 1, 1)

				local var_114_4 = arg_111_1:GetWordFromCfg(423101026)
				local var_114_5 = arg_111_1:FormatText(var_114_4.content)

				arg_111_1.text_.text = var_114_5

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 37 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 37)

				if (37 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 37)) > 0 and var_114_3 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_5
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101026", "story_v_out_423101.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101026", "story_v_out_423101.awb") / 1000

					if var_114_8 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_2
					end

					if var_114_4.prefab_name ~= "" and arg_111_1.actors_[var_114_4.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_4.prefab_name].transform, "story_v_out_423101", "423101026", "story_v_out_423101.awb")

						arg_111_1:RecordAudio("423101026", var_114_9)
						arg_111_1:RecordAudio("423101026", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_423101", "423101026", "story_v_out_423101.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_423101", "423101026", "story_v_out_423101.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_10 and arg_111_1.time_ < var_114_2 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play423101027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 423101027
		arg_115_1.duration_ = 5.13

		local var_115_0 = {
			zh = 5.133,
			ja = 4.833
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
				arg_115_0:Play423101028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.4

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[1343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_1 = arg_115_1:GetWordFromCfg(423101027)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 16 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 16)

				if (16 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 16)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101027", "story_v_out_423101.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101027", "story_v_out_423101.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_out_423101", "423101027", "story_v_out_423101.awb")

						arg_115_1:RecordAudio("423101027", var_118_6)
						arg_115_1:RecordAudio("423101027", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_423101", "423101027", "story_v_out_423101.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_423101", "423101027", "story_v_out_423101.awb")
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
	Play423101028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 423101028
		arg_119_1.duration_ = 9

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play423101029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if arg_119_1.bgs_.SS2303 == nil then
				local var_122_0 = Object.Instantiate(arg_119_1.paintGo_)

				var_122_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2303")
				var_122_0.name = "SS2303"
				var_122_0.transform.parent = arg_119_1.stage_.transform
				var_122_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_119_1.bgs_.SS2303 = var_122_0
			end

			if 2 < arg_119_1.time_ and arg_119_1.time_ <= 2 + arg_122_0 then
				local var_122_1 = arg_119_1.bgs_.SS2303

				arg_119_1.bgs_.SS2303.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_122_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_122_2 = var_122_1:GetComponent("SpriteRenderer")

				if var_122_2 and var_122_2.sprite then
					local var_122_3 = 2 * (var_122_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_122_1.transform.localScale = Vector3.New(var_122_3 / var_122_2.sprite.bounds.size.y < var_122_3 * manager.ui.mainCameraCom_.aspect / var_122_2.sprite.bounds.size.x and var_122_3 * manager.ui.mainCameraCom_.aspect / var_122_2.sprite.bounds.size.x or var_122_3 / var_122_2.sprite.bounds.size.y, var_122_3 / var_122_2.sprite.bounds.size.y < var_122_3 * manager.ui.mainCameraCom_.aspect / var_122_2.sprite.bounds.size.x and var_122_3 * manager.ui.mainCameraCom_.aspect / var_122_2.sprite.bounds.size.x or var_122_3 / var_122_2.sprite.bounds.size.y, 0)
				end

				for iter_122_0, iter_122_1 in pairs(arg_119_1.bgs_) do
					if iter_122_0 ~= "SS2303" then
						iter_122_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_122_4 = 4

			if 4 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.allBtn_.enabled = false
			end

			if arg_119_1.time_ >= var_122_4 + 0.3 and arg_119_1.time_ < var_122_4 + 0.3 + arg_122_0 then
				arg_119_1.allBtn_.enabled = true
			end

			local var_122_5 = 0

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_6 = 2

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_6 then
				local var_122_7 = Color.New(0, 0, 0)

				var_122_7.a = Mathf.Lerp(0, 1, (arg_119_1.time_ - var_122_5) / var_122_6)
				arg_119_1.mask_.color = var_122_7
			end

			if arg_119_1.time_ >= var_122_5 + var_122_6 and arg_119_1.time_ < var_122_5 + var_122_6 + arg_122_0 then
				local var_122_8 = Color.New(0, 0, 0)

				var_122_8.a = 1
				arg_119_1.mask_.color = var_122_8
			end

			local var_122_9 = 2

			if 2 < arg_119_1.time_ and arg_119_1.time_ <= var_122_9 + arg_122_0 then
				arg_119_1.mask_.enabled = true
				arg_119_1.mask_.raycastTarget = true

				arg_119_1:SetGaussion(false)
			end

			local var_122_10 = 2

			if var_122_9 <= arg_119_1.time_ and arg_119_1.time_ < var_122_9 + var_122_10 then
				local var_122_11 = Color.New(0, 0, 0)

				var_122_11.a = Mathf.Lerp(1, 0, (arg_119_1.time_ - var_122_9) / var_122_10)
				arg_119_1.mask_.color = var_122_11
			end

			if arg_119_1.time_ >= var_122_9 + var_122_10 and arg_119_1.time_ < var_122_9 + var_122_10 + arg_122_0 then
				local var_122_12 = Color.New(0, 0, 0)

				arg_119_1.mask_.enabled = false
				var_122_12.a = 0
				arg_119_1.mask_.color = var_122_12
			end

			local var_122_13 = arg_119_1.actors_["1083"].transform

			if 1.966 < arg_119_1.time_ and arg_119_1.time_ <= 1.966 + arg_122_0 then
				arg_119_1.var_.moveOldPos1083 = var_122_13.localPosition
				var_122_13.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1083", 7)

				for iter_122_2 = 0, var_122_13.childCount - 1 do
					local var_122_14 = var_122_13:GetChild(iter_122_2)

					if var_122_14.name == "" or not string.find(var_122_14.name, "split") then
						var_122_14.gameObject:SetActive(true)
					else
						var_122_14.gameObject:SetActive(false)
					end
				end
			end

			local var_122_15 = 0.001

			if 1.966 <= arg_119_1.time_ and arg_119_1.time_ < 1.966 + var_122_15 then
				var_122_13.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_119_1.time_ - 1.966) / var_122_15)
			end

			if arg_119_1.time_ >= 1.966 + var_122_15 and arg_119_1.time_ < 1.966 + var_122_15 + arg_122_0 then
				var_122_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_122_16 = arg_119_1.bgs_.SS2303.transform

			if 1.9 < arg_119_1.time_ and arg_119_1.time_ <= 1.9 + arg_122_0 then
				arg_119_1.var_.moveOldPosSS2303 = var_122_16.localPosition
			end

			local var_122_17 = 0.1

			if 1.9 <= arg_119_1.time_ and arg_119_1.time_ < 1.9 + var_122_17 then
				var_122_16.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPosSS2303, Vector3.New(0, 0, 5), (arg_119_1.time_ - 1.9) / var_122_17)
			end

			if arg_119_1.time_ >= 1.9 + var_122_17 and arg_119_1.time_ < 1.9 + var_122_17 + arg_122_0 then
				var_122_16.localPosition = Vector3.New(0, 0, 5)
			end

			local var_122_18 = arg_119_1.bgs_.SS2303.transform

			if 2 < arg_119_1.time_ and arg_119_1.time_ <= 2 + arg_122_0 then
				arg_119_1.var_.moveOldPosSS2303 = var_122_18.localPosition
			end

			local var_122_19 = 3.2

			if 2 <= arg_119_1.time_ and arg_119_1.time_ < 2 + var_122_19 then
				var_122_18.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPosSS2303, Vector3.New(0, 0, 5.5), (arg_119_1.time_ - 2) / var_122_19)
			end

			if arg_119_1.time_ >= 2 + var_122_19 and arg_119_1.time_ < 2 + var_122_19 + arg_122_0 then
				var_122_18.localPosition = Vector3.New(0, 0, 5.5)
			end

			if 1.9 < arg_119_1.time_ and arg_119_1.time_ <= 1.9 + arg_122_0 then
				if arg_119_1.var_.effectdianyingkaipai1 then
					Object.Destroy(arg_119_1.var_.effectdianyingkaipai1)

					arg_119_1.var_.effectdianyingkaipai1 = nil
				end
			end

			if 1.46666666666667 < arg_119_1.time_ and arg_119_1.time_ <= 1.46666666666667 + arg_122_0 then
				arg_119_1:AudioAction("play", "effect", "se_story_side_1022", "se_story_side_1022_crowd", "")
			end

			if 2.83546070172451 < arg_119_1.time_ and arg_119_1.time_ <= 2.83546070172451 + arg_122_0 then
				arg_119_1:AudioAction("play", "effect", "se_story_144", "se_story_144_bell02", "")
			end

			if arg_119_1.frameCnt_ <= 1 then
				arg_119_1.dialog_:SetActive(false)
			end

			local var_122_23 = 4
			local var_122_24 = 1.825

			if 4 < arg_119_1.time_ and arg_119_1.time_ <= var_122_23 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0

				arg_119_1.dialog_:SetActive(true)

				arg_119_1.dialogCg_.alpha = 0

				local var_122_25 = LeanTween.value(arg_119_1.dialog_, 0, 1, 0.3)

				var_122_25:setOnUpdate(LuaHelper.FloatAction(function(arg_123_0)
					arg_119_1.dialogCg_.alpha = arg_123_0
				end))
				var_122_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_119_1.dialog_)
					var_122_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_119_1.duration_ = arg_119_1.duration_ + 0.3

				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_26 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(423101028).content)

				arg_119_1.text_.text = var_122_26

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_28 = 73 <= 0 and var_122_24 or var_122_24 * (utf8.len(var_122_26) / 73)

				if (73 <= 0 and var_122_24 or var_122_24 * (utf8.len(var_122_26) / 73)) > 0 and var_122_24 < var_122_28 then
					arg_119_1.talkMaxDuration = var_122_28
					var_122_23 = var_122_23 + 0.3

					if var_122_28 + var_122_23 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_28 + var_122_23
					end
				end

				arg_119_1.text_.text = var_122_26
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_29 = var_122_23 + 0.3
			local var_122_30 = math.max(var_122_24, arg_119_1.talkMaxDuration)

			if var_122_23 + 0.3 <= arg_119_1.time_ and arg_119_1.time_ < var_122_29 + var_122_30 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_29) / var_122_30

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_29 + var_122_30 and arg_119_1.time_ < var_122_29 + var_122_30 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "SS2303",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS2303",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.2,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play423101029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 423101029
		arg_125_1.duration_ = 18.17

		local var_125_0 = {
			zh = 13.366,
			ja = 18.166
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
				arg_125_0:Play423101030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 1.225

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:GetWordFromCfg(423101029)
				local var_128_2 = arg_125_1:FormatText(var_128_1.content)

				arg_125_1.text_.text = var_128_2

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_4 = 49 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 49)

				if (49 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_2) / 49)) > 0 and var_128_0 < var_128_4 then
					arg_125_1.talkMaxDuration = var_128_4

					if var_128_4 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_4 + 0
					end
				end

				arg_125_1.text_.text = var_128_2
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101029", "story_v_out_423101.awb") ~= 0 then
					local var_128_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101029", "story_v_out_423101.awb") / 1000

					if var_128_5 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + 0
					end

					if var_128_1.prefab_name ~= "" and arg_125_1.actors_[var_128_1.prefab_name] ~= nil then
						local var_128_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_1.prefab_name].transform, "story_v_out_423101", "423101029", "story_v_out_423101.awb")

						arg_125_1:RecordAudio("423101029", var_128_6)
						arg_125_1:RecordAudio("423101029", var_128_6)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_423101", "423101029", "story_v_out_423101.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_423101", "423101029", "story_v_out_423101.awb")
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
	Play423101030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 423101030
		arg_129_1.duration_ = 12.8

		local var_129_0 = {
			zh = 9,
			ja = 12.8
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
				arg_129_0:Play423101031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 1

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_1 = arg_129_1:GetWordFromCfg(423101030)
				local var_132_2 = arg_129_1:FormatText(var_132_1.content)

				arg_129_1.text_.text = var_132_2

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 40 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 40)

				if (40 <= 0 and var_132_0 or var_132_0 * (utf8.len(var_132_2) / 40)) > 0 and var_132_0 < var_132_4 then
					arg_129_1.talkMaxDuration = var_132_4

					if var_132_4 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_4 + 0
					end
				end

				arg_129_1.text_.text = var_132_2
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101030", "story_v_out_423101.awb") ~= 0 then
					local var_132_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101030", "story_v_out_423101.awb") / 1000

					if var_132_5 + 0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_5 + 0
					end

					if var_132_1.prefab_name ~= "" and arg_129_1.actors_[var_132_1.prefab_name] ~= nil then
						local var_132_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_1.prefab_name].transform, "story_v_out_423101", "423101030", "story_v_out_423101.awb")

						arg_129_1:RecordAudio("423101030", var_132_6)
						arg_129_1:RecordAudio("423101030", var_132_6)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_423101", "423101030", "story_v_out_423101.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_423101", "423101030", "story_v_out_423101.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_0, arg_129_1.talkMaxDuration)

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - 0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= 0 + var_132_7 and arg_129_1.time_ < 0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play423101031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 423101031
		arg_133_1.duration_ = 5.63

		local var_133_0 = {
			zh = 5.633,
			ja = 4.533
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
				arg_133_0:Play423101032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.525

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1345].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1083_split_3")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_1 = arg_133_1:GetWordFromCfg(423101031)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 21 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 21)

				if (21 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 21)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101031", "story_v_out_423101.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101031", "story_v_out_423101.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_423101", "423101031", "story_v_out_423101.awb")

						arg_133_1:RecordAudio("423101031", var_136_6)
						arg_133_1:RecordAudio("423101031", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_423101", "423101031", "story_v_out_423101.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_423101", "423101031", "story_v_out_423101.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_0, arg_133_1.talkMaxDuration)

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - 0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= 0 + var_136_7 and arg_133_1.time_ < 0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play423101032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 423101032
		arg_137_1.duration_ = 16.6

		local var_137_0 = {
			zh = 11.333,
			ja = 16.6
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
				arg_137_0:Play423101033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 1.3

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_1 = arg_137_1:GetWordFromCfg(423101032)
				local var_140_2 = arg_137_1:FormatText(var_140_1.content)

				arg_137_1.text_.text = var_140_2

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 52 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 52)

				if (52 <= 0 and var_140_0 or var_140_0 * (utf8.len(var_140_2) / 52)) > 0 and var_140_0 < var_140_4 then
					arg_137_1.talkMaxDuration = var_140_4

					if var_140_4 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_4 + 0
					end
				end

				arg_137_1.text_.text = var_140_2
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101032", "story_v_out_423101.awb") ~= 0 then
					local var_140_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101032", "story_v_out_423101.awb") / 1000

					if var_140_5 + 0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_5 + 0
					end

					if var_140_1.prefab_name ~= "" and arg_137_1.actors_[var_140_1.prefab_name] ~= nil then
						local var_140_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_1.prefab_name].transform, "story_v_out_423101", "423101032", "story_v_out_423101.awb")

						arg_137_1:RecordAudio("423101032", var_140_6)
						arg_137_1:RecordAudio("423101032", var_140_6)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_423101", "423101032", "story_v_out_423101.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_423101", "423101032", "story_v_out_423101.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_0, arg_137_1.talkMaxDuration)

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - 0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= 0 + var_140_7 and arg_137_1.time_ < 0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play423101033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 423101033
		arg_141_1.duration_ = 12.57

		local var_141_0 = {
			zh = 9.7,
			ja = 12.566
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
				arg_141_0:Play423101034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 1.05

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_1 = arg_141_1:GetWordFromCfg(423101033)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.text_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_4 = 42 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 42)

				if (42 <= 0 and var_144_0 or var_144_0 * (utf8.len(var_144_2) / 42)) > 0 and var_144_0 < var_144_4 then
					arg_141_1.talkMaxDuration = var_144_4

					if var_144_4 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_4 + 0
					end
				end

				arg_141_1.text_.text = var_144_2
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101033", "story_v_out_423101.awb") ~= 0 then
					local var_144_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101033", "story_v_out_423101.awb") / 1000

					if var_144_5 + 0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + 0
					end

					if var_144_1.prefab_name ~= "" and arg_141_1.actors_[var_144_1.prefab_name] ~= nil then
						local var_144_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_1.prefab_name].transform, "story_v_out_423101", "423101033", "story_v_out_423101.awb")

						arg_141_1:RecordAudio("423101033", var_144_6)
						arg_141_1:RecordAudio("423101033", var_144_6)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_423101", "423101033", "story_v_out_423101.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_423101", "423101033", "story_v_out_423101.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_0, arg_141_1.talkMaxDuration)

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - 0) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= 0 + var_144_7 and arg_141_1.time_ < 0 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play423101034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 423101034
		arg_145_1.duration_ = 3.73

		local var_145_0 = {
			zh = 3.7,
			ja = 3.733
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
				arg_145_0:Play423101035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.275

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1346].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:GetWordFromCfg(423101034)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 11 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 11)

				if (11 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 11)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101034", "story_v_out_423101.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101034", "story_v_out_423101.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_423101", "423101034", "story_v_out_423101.awb")

						arg_145_1:RecordAudio("423101034", var_148_6)
						arg_145_1:RecordAudio("423101034", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_423101", "423101034", "story_v_out_423101.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_423101", "423101034", "story_v_out_423101.awb")
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
	Play423101035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 423101035
		arg_149_1.duration_ = 6.3

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play423101036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0.266666666666667 < arg_149_1.time_ and arg_149_1.time_ <= 0.266666666666667 + arg_152_0 then
				arg_149_1.mask_.enabled = true
				arg_149_1.mask_.raycastTarget = true

				arg_149_1:SetGaussion(false)
			end

			local var_152_0 = 1.033333

			if 0.266666666666667 <= arg_149_1.time_ and arg_149_1.time_ < 0.266666666666667 + var_152_0 then
				local var_152_1 = Color.New(1, 1, 1)

				var_152_1.a = Mathf.Lerp(1, 0, (arg_149_1.time_ - 0.266666666666667) / var_152_0)
				arg_149_1.mask_.color = var_152_1
			end

			if arg_149_1.time_ >= 0.266666666666667 + var_152_0 and arg_149_1.time_ < 0.266666666666667 + var_152_0 + arg_152_0 then
				local var_152_2 = Color.New(1, 1, 1)

				arg_149_1.mask_.enabled = false
				var_152_2.a = 0
				arg_149_1.mask_.color = var_152_2
			end

			local var_152_3 = manager.ui.mainCamera.transform

			if 0.266666666666667 < arg_149_1.time_ and arg_149_1.time_ <= 0.266666666666667 + arg_152_0 then
				arg_149_1.var_.shakeOldPos = var_152_3.localPosition
			end

			local var_152_4 = 0.6

			if 0.266666666666667 <= arg_149_1.time_ and arg_149_1.time_ < 0.266666666666667 + var_152_4 then
				local var_152_5, var_152_6 = math.modf((arg_149_1.time_ - 0.266666666666667) / 0.066)

				var_152_3.localPosition = Vector3.New(var_152_6 * 0.13, var_152_6 * 0.13, var_152_6 * 0.13) + arg_149_1.var_.shakeOldPos
			end

			if arg_149_1.time_ >= 0.266666666666667 + var_152_4 and arg_149_1.time_ < 0.266666666666667 + var_152_4 + arg_152_0 then
				var_152_3.localPosition = arg_149_1.var_.shakeOldPos
			end

			if 0.266666666666667 < arg_149_1.time_ and arg_149_1.time_ <= 0.266666666666667 + arg_152_0 then
				local var_152_7 = arg_149_1.bgs_.SS2303

				arg_149_1.bgs_.SS2303.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_152_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_152_8 = var_152_7:GetComponent("SpriteRenderer")

				if var_152_8 and var_152_8.sprite then
					local var_152_9 = 2 * (var_152_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_152_7.transform.localScale = Vector3.New(var_152_9 / var_152_8.sprite.bounds.size.y < var_152_9 * manager.ui.mainCameraCom_.aspect / var_152_8.sprite.bounds.size.x and var_152_9 * manager.ui.mainCameraCom_.aspect / var_152_8.sprite.bounds.size.x or var_152_9 / var_152_8.sprite.bounds.size.y, var_152_9 / var_152_8.sprite.bounds.size.y < var_152_9 * manager.ui.mainCameraCom_.aspect / var_152_8.sprite.bounds.size.x and var_152_9 * manager.ui.mainCameraCom_.aspect / var_152_8.sprite.bounds.size.x or var_152_9 / var_152_8.sprite.bounds.size.y, 0)
				end

				for iter_152_0, iter_152_1 in pairs(arg_149_1.bgs_) do
					if iter_152_0 ~= "SS2303" then
						iter_152_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_152_10 = 0

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				arg_149_1.allBtn_.enabled = false
			end

			if arg_149_1.time_ >= var_152_10 + 0.266666666666667 and arg_149_1.time_ < var_152_10 + 0.266666666666667 + arg_152_0 then
				arg_149_1.allBtn_.enabled = true
			end

			if 0.266666666666667 < arg_149_1.time_ and arg_149_1.time_ <= 0.266666666666667 + arg_152_0 then
				arg_149_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun", "")
			end

			local var_152_12 = 1.29999966666667
			local var_152_13 = 1.625

			if 1.29999966666667 < arg_149_1.time_ and arg_149_1.time_ <= var_152_12 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_14 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(423101035).content)

				arg_149_1.text_.text = var_152_14

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_16 = 65 <= 0 and var_152_13 or var_152_13 * (utf8.len(var_152_14) / 65)

				if (65 <= 0 and var_152_13 or var_152_13 * (utf8.len(var_152_14) / 65)) > 0 and var_152_13 < var_152_16 then
					arg_149_1.talkMaxDuration = var_152_16

					if var_152_16 + var_152_12 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_16 + var_152_12
					end
				end

				arg_149_1.text_.text = var_152_14
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_17 = math.max(var_152_13, arg_149_1.talkMaxDuration)

			if var_152_12 <= arg_149_1.time_ and arg_149_1.time_ < var_152_12 + var_152_17 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_12) / var_152_17

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_12 + var_152_17 and arg_149_1.time_ < var_152_12 + var_152_17 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play423101036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 423101036
		arg_153_1.duration_ = 5.1

		local var_153_0 = {
			zh = 3.366,
			ja = 5.1
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
				arg_153_0:Play423101037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0.133333333333333 < arg_153_1.time_ and arg_153_1.time_ <= 0.133333333333333 + arg_156_0 then
				arg_153_1:AudioAction("play", "effect", "se_story_144", "se_story_144_bell03", "")
			end

			local var_156_1 = 0
			local var_156_2 = 0.4

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpaa")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_3 = arg_153_1:GetWordFromCfg(423101036)
				local var_156_4 = arg_153_1:FormatText(var_156_3.content)

				arg_153_1.text_.text = var_156_4

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_6 = 16 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_4) / 16)

				if (16 <= 0 and var_156_2 or var_156_2 * (utf8.len(var_156_4) / 16)) > 0 and var_156_2 < var_156_6 then
					arg_153_1.talkMaxDuration = var_156_6

					if var_156_6 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_1
					end
				end

				arg_153_1.text_.text = var_156_4
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101036", "story_v_out_423101.awb") ~= 0 then
					local var_156_7 = manager.audio:GetVoiceLength("story_v_out_423101", "423101036", "story_v_out_423101.awb") / 1000

					if var_156_7 + var_156_1 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_1
					end

					if var_156_3.prefab_name ~= "" and arg_153_1.actors_[var_156_3.prefab_name] ~= nil then
						local var_156_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_3.prefab_name].transform, "story_v_out_423101", "423101036", "story_v_out_423101.awb")

						arg_153_1:RecordAudio("423101036", var_156_8)
						arg_153_1:RecordAudio("423101036", var_156_8)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_423101", "423101036", "story_v_out_423101.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_423101", "423101036", "story_v_out_423101.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_9 = math.max(var_156_2, arg_153_1.talkMaxDuration)

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_9 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_1) / var_156_9

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_1 + var_156_9 and arg_153_1.time_ < var_156_1 + var_156_9 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play423101037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 423101037
		arg_157_1.duration_ = 17

		local var_157_0 = {
			zh = 8.866,
			ja = 17
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
				arg_157_0:Play423101038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if arg_157_1.bgs_.L08g == nil then
				local var_160_0 = Object.Instantiate(arg_157_1.paintGo_)

				var_160_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L08g")
				var_160_0.name = "L08g"
				var_160_0.transform.parent = arg_157_1.stage_.transform
				var_160_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_157_1.bgs_.L08g = var_160_0
			end

			if 2 < arg_157_1.time_ and arg_157_1.time_ <= 2 + arg_160_0 then
				local var_160_1 = arg_157_1.bgs_.L08g

				arg_157_1.bgs_.L08g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_160_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_160_2 = var_160_1:GetComponent("SpriteRenderer")

				if var_160_2 and var_160_2.sprite then
					local var_160_3 = 2 * (var_160_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_160_1.transform.localScale = Vector3.New(var_160_3 / var_160_2.sprite.bounds.size.y < var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x and var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x or var_160_3 / var_160_2.sprite.bounds.size.y, var_160_3 / var_160_2.sprite.bounds.size.y < var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x and var_160_3 * manager.ui.mainCameraCom_.aspect / var_160_2.sprite.bounds.size.x or var_160_3 / var_160_2.sprite.bounds.size.y, 0)
				end

				for iter_160_0, iter_160_1 in pairs(arg_157_1.bgs_) do
					if iter_160_0 ~= "L08g" then
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

			if 0.1 < arg_157_1.time_ and arg_157_1.time_ <= 0.1 + arg_160_0 then
				arg_157_1:AudioAction("stop", "effect", "se_story_side_1022", "se_story_side_1022_crowd", "")
			end

			if 1.6 < arg_157_1.time_ and arg_157_1.time_ <= 1.6 + arg_160_0 then
				arg_157_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drain", "")
			end

			if 0.1 < arg_157_1.time_ and arg_157_1.time_ <= 0.1 + arg_160_0 then
				arg_157_1:AudioAction("stop", "effect", "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_16 = 4
			local var_160_17 = 0.575

			if 4 < arg_157_1.time_ and arg_157_1.time_ <= var_160_16 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_18 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_18:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1346].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_19 = arg_157_1:GetWordFromCfg(423101037)
				local var_160_20 = arg_157_1:FormatText(var_160_19.content)

				arg_157_1.text_.text = var_160_20

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_22 = 23 <= 0 and var_160_17 or var_160_17 * (utf8.len(var_160_20) / 23)

				if (23 <= 0 and var_160_17 or var_160_17 * (utf8.len(var_160_20) / 23)) > 0 and var_160_17 < var_160_22 then
					arg_157_1.talkMaxDuration = var_160_22
					var_160_16 = var_160_16 + 0.3

					if var_160_22 + var_160_16 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_22 + var_160_16
					end
				end

				arg_157_1.text_.text = var_160_20
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101037", "story_v_out_423101.awb") ~= 0 then
					local var_160_23 = manager.audio:GetVoiceLength("story_v_out_423101", "423101037", "story_v_out_423101.awb") / 1000

					if var_160_23 + var_160_16 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_23 + var_160_16
					end

					if var_160_19.prefab_name ~= "" and arg_157_1.actors_[var_160_19.prefab_name] ~= nil then
						local var_160_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_19.prefab_name].transform, "story_v_out_423101", "423101037", "story_v_out_423101.awb")

						arg_157_1:RecordAudio("423101037", var_160_24)
						arg_157_1:RecordAudio("423101037", var_160_24)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_423101", "423101037", "story_v_out_423101.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_423101", "423101037", "story_v_out_423101.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_25 = var_160_16 + 0.3
			local var_160_26 = math.max(var_160_17, arg_157_1.talkMaxDuration)

			if var_160_16 + 0.3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_25 + var_160_26 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_25) / var_160_26

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_25 + var_160_26 and arg_157_1.time_ < var_160_25 + var_160_26 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play423101038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 423101038
		arg_163_1.duration_ = 4.6

		local var_163_0 = {
			zh = 1.866,
			ja = 4.6
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
				arg_163_0:Play423101039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.225

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[1345].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1083_split_7")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_1 = arg_163_1:GetWordFromCfg(423101038)
				local var_166_2 = arg_163_1:FormatText(var_166_1.content)

				arg_163_1.text_.text = var_166_2

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 9 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 9)

				if (9 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 9)) > 0 and var_166_0 < var_166_4 then
					arg_163_1.talkMaxDuration = var_166_4

					if var_166_4 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_4 + 0
					end
				end

				arg_163_1.text_.text = var_166_2
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101038", "story_v_out_423101.awb") ~= 0 then
					local var_166_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101038", "story_v_out_423101.awb") / 1000

					if var_166_5 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + 0
					end

					if var_166_1.prefab_name ~= "" and arg_163_1.actors_[var_166_1.prefab_name] ~= nil then
						local var_166_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_1.prefab_name].transform, "story_v_out_423101", "423101038", "story_v_out_423101.awb")

						arg_163_1:RecordAudio("423101038", var_166_6)
						arg_163_1:RecordAudio("423101038", var_166_6)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_423101", "423101038", "story_v_out_423101.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_423101", "423101038", "story_v_out_423101.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play423101039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 423101039
		arg_167_1.duration_ = 8.6

		local var_167_0 = {
			zh = 8.533,
			ja = 8.6
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
				arg_167_0:Play423101040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1083"]) and arg_167_1.var_.actorSpriteComps1083 == nil then
				arg_167_1.var_.actorSpriteComps1083 = arg_167_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_0 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1083"]) then
				if arg_167_1.var_.actorSpriteComps1083 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1083"]) and arg_167_1.var_.actorSpriteComps1083 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_170_3 then
						iter_170_3.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps1083 = nil
			end

			local var_170_2 = 0
			local var_170_3 = 0.725

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_2 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1343].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_4 = arg_167_1:GetWordFromCfg(423101039)
				local var_170_5 = arg_167_1:FormatText(var_170_4.content)

				arg_167_1.text_.text = var_170_5

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_7 = 29 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 29)

				if (29 <= 0 and var_170_3 or var_170_3 * (utf8.len(var_170_5) / 29)) > 0 and var_170_3 < var_170_7 then
					arg_167_1.talkMaxDuration = var_170_7

					if var_170_7 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_7 + var_170_2
					end
				end

				arg_167_1.text_.text = var_170_5
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101039", "story_v_out_423101.awb") ~= 0 then
					local var_170_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101039", "story_v_out_423101.awb") / 1000

					if var_170_8 + var_170_2 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_2
					end

					if var_170_4.prefab_name ~= "" and arg_167_1.actors_[var_170_4.prefab_name] ~= nil then
						local var_170_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_4.prefab_name].transform, "story_v_out_423101", "423101039", "story_v_out_423101.awb")

						arg_167_1:RecordAudio("423101039", var_170_9)
						arg_167_1:RecordAudio("423101039", var_170_9)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_423101", "423101039", "story_v_out_423101.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_423101", "423101039", "story_v_out_423101.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_3, arg_167_1.talkMaxDuration)

			if var_170_2 <= arg_167_1.time_ and arg_167_1.time_ < var_170_2 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_2) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_2 + var_170_10 and arg_167_1.time_ < var_170_2 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play423101040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 423101040
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play423101041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos1083 = arg_171_1.actors_["1083"].transform.localPosition
				arg_171_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("1083", 7)

				for iter_174_0 = 0, arg_171_1.actors_["1083"].transform.childCount - 1 do
					local var_174_0 = arg_171_1.actors_["1083"].transform:GetChild(iter_174_0)

					if var_174_0.name == "" or not string.find(var_174_0.name, "split") then
						var_174_0.gameObject:SetActive(true)
					else
						var_174_0.gameObject:SetActive(false)
					end
				end
			end

			local var_174_1 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 then
				arg_171_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_171_1.time_ - 0) / var_174_1)
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 then
				arg_171_1.actors_["1083"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.034 < arg_171_1.time_ and arg_171_1.time_ <= 0.034 + arg_174_0 then
				arg_171_1:AudioAction("play", "effect", "se_story_144", "se_story_144_horse", "")
			end

			local var_174_3 = 0
			local var_174_4 = 1.6

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_3 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, false)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_5 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(423101040).content)

				arg_171_1.text_.text = var_174_5

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_7 = 64 <= 0 and var_174_4 or var_174_4 * (utf8.len(var_174_5) / 64)

				if (64 <= 0 and var_174_4 or var_174_4 * (utf8.len(var_174_5) / 64)) > 0 and var_174_4 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_3 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_3
					end
				end

				arg_171_1.text_.text = var_174_5
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_8 = math.max(var_174_4, arg_171_1.talkMaxDuration)

			if var_174_3 <= arg_171_1.time_ and arg_171_1.time_ < var_174_3 + var_174_8 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_3) / var_174_8

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_3 + var_174_8 and arg_171_1.time_ < var_174_3 + var_174_8 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423101041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 423101041
		arg_175_1.duration_ = 10.47

		local var_175_0 = {
			zh = 6,
			ja = 10.466
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
				arg_175_0:Play423101042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if arg_175_1.actors_["10146"] == nil then
				local var_178_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10146")

				if not isNil(var_178_0) then
					local var_178_1 = Object.Instantiate(var_178_0, arg_175_1.canvasGo_.transform)

					var_178_1.transform:SetSiblingIndex(1)

					var_178_1.name = "10146"
					var_178_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_175_1.actors_["10146"] = var_178_1

					if arg_175_1.isInRecall_ then
						for iter_178_0, iter_178_1 in ipairs((var_178_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_178_1.color = arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_178_2 = arg_175_1.actors_["10146"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps10146 == nil then
				arg_175_1.var_.actorSpriteComps10146 = var_178_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_3 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 and not isNil(var_178_2) then
				if arg_175_1.var_.actorSpriteComps10146 then
					for iter_178_2, iter_178_3 in pairs(arg_175_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_178_3 then
							if arg_175_1.isInRecall_ then
								iter_178_3.color = Color.New(Mathf.Lerp(iter_178_3.color.r, arg_175_1.hightColor1.r, (arg_175_1.time_ - 0) / var_178_3), Mathf.Lerp(iter_178_3.color.g, arg_175_1.hightColor1.g, (arg_175_1.time_ - 0) / var_178_3), (Mathf.Lerp(iter_178_3.color.b, arg_175_1.hightColor1.b, (arg_175_1.time_ - 0) / var_178_3)))
							else
								local var_178_4 = Mathf.Lerp(iter_178_3.color.r, 1, (arg_175_1.time_ - 0) / var_178_3)

								iter_178_3.color = Color.New(var_178_4, var_178_4, var_178_4)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps10146 then
				for iter_178_4, iter_178_5 in pairs(arg_175_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_178_5 then
						iter_178_5.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_175_1.var_.actorSpriteComps10146 = nil
			end

			local var_178_5 = arg_175_1.actors_["10146"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10146 = var_178_5.localPosition
				var_178_5.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("10146", 3)

				for iter_178_6 = 0, var_178_5.childCount - 1 do
					local var_178_6 = var_178_5:GetChild(iter_178_6)

					if var_178_6.name == "split_6" or not string.find(var_178_6.name, "split") then
						var_178_6.gameObject:SetActive(true)
					else
						var_178_6.gameObject:SetActive(false)
					end
				end
			end

			local var_178_7 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				var_178_5.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_175_1.time_ - 0) / var_178_7)
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				var_178_5.localPosition = Vector3.New(0, -350, -320)
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				local var_178_8 = arg_175_1.actors_["10146"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_178_8 then
					arg_175_1.var_.alphaOldValue10146 = var_178_8.alpha
					arg_175_1.var_.characterEffect10146 = var_178_8
				end

				arg_175_1.var_.alphaOldValue10146 = 0
			end

			local var_178_9 = 0.5

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_9 then
				if arg_175_1.var_.characterEffect10146 then
					arg_175_1.var_.characterEffect10146.alpha = Mathf.Lerp(arg_175_1.var_.alphaOldValue10146, 1, (arg_175_1.time_ - 0) / var_178_9)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_9 and arg_175_1.time_ < 0 + var_178_9 + arg_178_0 and arg_175_1.var_.characterEffect10146 then
				arg_175_1.var_.characterEffect10146.alpha = 1
			end

			local var_178_10 = 0
			local var_178_11 = 0.725

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_12 = arg_175_1:GetWordFromCfg(423101041)
				local var_178_13 = arg_175_1:FormatText(var_178_12.content)

				arg_175_1.text_.text = var_178_13

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_15 = 29 <= 0 and var_178_11 or var_178_11 * (utf8.len(var_178_13) / 29)

				if (29 <= 0 and var_178_11 or var_178_11 * (utf8.len(var_178_13) / 29)) > 0 and var_178_11 < var_178_15 then
					arg_175_1.talkMaxDuration = var_178_15

					if var_178_15 + var_178_10 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_15 + var_178_10
					end
				end

				arg_175_1.text_.text = var_178_13
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101041", "story_v_out_423101.awb") ~= 0 then
					local var_178_16 = manager.audio:GetVoiceLength("story_v_out_423101", "423101041", "story_v_out_423101.awb") / 1000

					if var_178_16 + var_178_10 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_16 + var_178_10
					end

					if var_178_12.prefab_name ~= "" and arg_175_1.actors_[var_178_12.prefab_name] ~= nil then
						local var_178_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_12.prefab_name].transform, "story_v_out_423101", "423101041", "story_v_out_423101.awb")

						arg_175_1:RecordAudio("423101041", var_178_17)
						arg_175_1:RecordAudio("423101041", var_178_17)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_423101", "423101041", "story_v_out_423101.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_423101", "423101041", "story_v_out_423101.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_18 = math.max(var_178_11, arg_175_1.talkMaxDuration)

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_18 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_10) / var_178_18

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_10 + var_178_18 and arg_175_1.time_ < var_178_10 + var_178_18 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
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
	Play423101042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 423101042
		arg_179_1.duration_ = 14.8

		local var_179_0 = {
			zh = 9.7,
			ja = 14.8
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
				arg_179_0:Play423101043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0.5 < arg_179_1.time_ and arg_179_1.time_ <= 0.5 + arg_182_0 then
				arg_179_1.var_.moveOldPos10146 = arg_179_1.actors_["10146"].transform.localPosition
				arg_179_1.actors_["10146"].transform.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10146", 3)

				for iter_182_0 = 0, arg_179_1.actors_["10146"].transform.childCount - 1 do
					local var_182_0 = arg_179_1.actors_["10146"].transform:GetChild(iter_182_0)

					if var_182_0.name == "" or not string.find(var_182_0.name, "split") then
						var_182_0.gameObject:SetActive(true)
					else
						var_182_0.gameObject:SetActive(false)
					end
				end
			end

			local var_182_1 = 0.001

			if 0.5 <= arg_179_1.time_ and arg_179_1.time_ < 0.5 + var_182_1 then
				arg_179_1.actors_["10146"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_179_1.time_ - 0.5) / var_182_1)
			end

			if arg_179_1.time_ >= 0.5 + var_182_1 and arg_179_1.time_ < 0.5 + var_182_1 + arg_182_0 then
				arg_179_1.actors_["10146"].transform.localPosition = Vector3.New(0, -350, -320)
			end

			local var_182_2 = 0

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.allBtn_.enabled = false
			end

			if arg_179_1.time_ >= var_182_2 + 0.5 and arg_179_1.time_ < var_182_2 + 0.5 + arg_182_0 then
				arg_179_1.allBtn_.enabled = true
			end

			local var_182_3 = 0
			local var_182_4 = 1

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_3 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_5 = arg_179_1:GetWordFromCfg(423101042)
				local var_182_6 = arg_179_1:FormatText(var_182_5.content)

				arg_179_1.text_.text = var_182_6

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_8 = 40 <= 0 and var_182_4 or var_182_4 * (utf8.len(var_182_6) / 40)

				if (40 <= 0 and var_182_4 or var_182_4 * (utf8.len(var_182_6) / 40)) > 0 and var_182_4 < var_182_8 then
					arg_179_1.talkMaxDuration = var_182_8

					if var_182_8 + var_182_3 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_3
					end
				end

				arg_179_1.text_.text = var_182_6
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101042", "story_v_out_423101.awb") ~= 0 then
					local var_182_9 = manager.audio:GetVoiceLength("story_v_out_423101", "423101042", "story_v_out_423101.awb") / 1000

					if var_182_9 + var_182_3 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_3
					end

					if var_182_5.prefab_name ~= "" and arg_179_1.actors_[var_182_5.prefab_name] ~= nil then
						local var_182_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_5.prefab_name].transform, "story_v_out_423101", "423101042", "story_v_out_423101.awb")

						arg_179_1:RecordAudio("423101042", var_182_10)
						arg_179_1:RecordAudio("423101042", var_182_10)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_423101", "423101042", "story_v_out_423101.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_423101", "423101042", "story_v_out_423101.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_11 = math.max(var_182_4, arg_179_1.talkMaxDuration)

			if var_182_3 <= arg_179_1.time_ and arg_179_1.time_ < var_182_3 + var_182_11 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_3) / var_182_11

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_3 + var_182_11 and arg_179_1.time_ < var_182_3 + var_182_11 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play423101043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 423101043
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play423101044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["10146"]) and arg_183_1.var_.actorSpriteComps10146 == nil then
				arg_183_1.var_.actorSpriteComps10146 = arg_183_1.actors_["10146"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_0 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["10146"]) then
				if arg_183_1.var_.actorSpriteComps10146 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_186_1 then
							if arg_183_1.isInRecall_ then
								iter_186_1.color = Color.New(Mathf.Lerp(iter_186_1.color.r, arg_183_1.hightColor2.r, (arg_183_1.time_ - 0) / var_186_0), Mathf.Lerp(iter_186_1.color.g, arg_183_1.hightColor2.g, (arg_183_1.time_ - 0) / var_186_0), (Mathf.Lerp(iter_186_1.color.b, arg_183_1.hightColor2.b, (arg_183_1.time_ - 0) / var_186_0)))
							else
								local var_186_1 = Mathf.Lerp(iter_186_1.color.r, 0.5, (arg_183_1.time_ - 0) / var_186_0)

								iter_186_1.color = Color.New(var_186_1, var_186_1, var_186_1)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["10146"]) and arg_183_1.var_.actorSpriteComps10146 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_186_3 then
						iter_186_3.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_183_1.var_.actorSpriteComps10146 = nil
			end

			local var_186_2 = arg_183_1.actors_["10146"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10146 = var_186_2.localPosition
				var_186_2.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10146", 7)

				for iter_186_4 = 0, var_186_2.childCount - 1 do
					local var_186_3 = var_186_2:GetChild(iter_186_4)

					if var_186_3.name == "" or not string.find(var_186_3.name, "split") then
						var_186_3.gameObject:SetActive(true)
					else
						var_186_3.gameObject:SetActive(false)
					end
				end
			end

			local var_186_4 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				var_186_2.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10146, Vector3.New(0, -2000, 0), (arg_183_1.time_ - 0) / var_186_4)
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				var_186_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_186_5 = 0
			local var_186_6 = 1.275

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_5 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_7 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(423101043).content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 51 <= 0 and var_186_6 or var_186_6 * (utf8.len(var_186_7) / 51)

				if (51 <= 0 and var_186_6 or var_186_6 * (utf8.len(var_186_7) / 51)) > 0 and var_186_6 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_5 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_5
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_6, arg_183_1.talkMaxDuration)

			if var_186_5 <= arg_183_1.time_ and arg_183_1.time_ < var_186_5 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_5) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_5 + var_186_10 and arg_183_1.time_ < var_186_5 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
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
	Play423101044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 423101044
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play423101045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 1.05

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(423101044).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 42 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 42)

				if (42 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 42)) > 0 and var_190_0 < var_190_3 then
					arg_187_1.talkMaxDuration = var_190_3

					if var_190_3 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_3 + 0
					end
				end

				arg_187_1.text_.text = var_190_1
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_4 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_4

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play423101045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 423101045
		arg_191_1.duration_ = 4.97

		local var_191_0 = {
			zh = 4.5,
			ja = 4.966
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
				arg_191_0:Play423101046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["10146"]) and arg_191_1.var_.actorSpriteComps10146 == nil then
				arg_191_1.var_.actorSpriteComps10146 = arg_191_1.actors_["10146"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_0 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["10146"]) then
				if arg_191_1.var_.actorSpriteComps10146 then
					for iter_194_0, iter_194_1 in pairs(arg_191_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_194_1 then
							if arg_191_1.isInRecall_ then
								iter_194_1.color = Color.New(Mathf.Lerp(iter_194_1.color.r, arg_191_1.hightColor1.r, (arg_191_1.time_ - 0) / var_194_0), Mathf.Lerp(iter_194_1.color.g, arg_191_1.hightColor1.g, (arg_191_1.time_ - 0) / var_194_0), (Mathf.Lerp(iter_194_1.color.b, arg_191_1.hightColor1.b, (arg_191_1.time_ - 0) / var_194_0)))
							else
								local var_194_1 = Mathf.Lerp(iter_194_1.color.r, 1, (arg_191_1.time_ - 0) / var_194_0)

								iter_194_1.color = Color.New(var_194_1, var_194_1, var_194_1)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["10146"]) and arg_191_1.var_.actorSpriteComps10146 then
				for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_194_3 then
						iter_194_3.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_191_1.var_.actorSpriteComps10146 = nil
			end

			local var_194_2 = arg_191_1.actors_["10146"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10146 = var_194_2.localPosition
				var_194_2.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10146", 3)

				for iter_194_4 = 0, var_194_2.childCount - 1 do
					local var_194_3 = var_194_2:GetChild(iter_194_4)

					if var_194_3.name == "" or not string.find(var_194_3.name, "split") then
						var_194_3.gameObject:SetActive(true)
					else
						var_194_3.gameObject:SetActive(false)
					end
				end
			end

			local var_194_4 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_4 then
				var_194_2.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_191_1.time_ - 0) / var_194_4)
			end

			if arg_191_1.time_ >= 0 + var_194_4 and arg_191_1.time_ < 0 + var_194_4 + arg_194_0 then
				var_194_2.localPosition = Vector3.New(0, -350, -320)
			end

			local var_194_5 = 0
			local var_194_6 = 0.3

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_7 = arg_191_1:GetWordFromCfg(423101045)
				local var_194_8 = arg_191_1:FormatText(var_194_7.content)

				arg_191_1.text_.text = var_194_8

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_10 = 12 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_8) / 12)

				if (12 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_8) / 12)) > 0 and var_194_6 < var_194_10 then
					arg_191_1.talkMaxDuration = var_194_10

					if var_194_10 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_5
					end
				end

				arg_191_1.text_.text = var_194_8
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101045", "story_v_out_423101.awb") ~= 0 then
					local var_194_11 = manager.audio:GetVoiceLength("story_v_out_423101", "423101045", "story_v_out_423101.awb") / 1000

					if var_194_11 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_11 + var_194_5
					end

					if var_194_7.prefab_name ~= "" and arg_191_1.actors_[var_194_7.prefab_name] ~= nil then
						local var_194_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_7.prefab_name].transform, "story_v_out_423101", "423101045", "story_v_out_423101.awb")

						arg_191_1:RecordAudio("423101045", var_194_12)
						arg_191_1:RecordAudio("423101045", var_194_12)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_423101", "423101045", "story_v_out_423101.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_423101", "423101045", "story_v_out_423101.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_13 = math.max(var_194_6, arg_191_1.talkMaxDuration)

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_13 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_5) / var_194_13

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_5 + var_194_13 and arg_191_1.time_ < var_194_5 + var_194_13 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
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
	Play423101046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 423101046
		arg_195_1.duration_ = 7.23

		local var_195_0 = {
			zh = 6.5326667,
			ja = 7.2326667
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
				arg_195_0:Play423101047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if arg_195_1.bgs_.STblack == nil then
				local var_198_0 = Object.Instantiate(arg_195_1.paintGo_)

				var_198_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_198_0.name = "STblack"
				var_198_0.transform.parent = arg_195_1.stage_.transform
				var_198_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_195_1.bgs_.STblack = var_198_0
			end

			if 0.5666667 < arg_195_1.time_ and arg_195_1.time_ <= 0.5666667 + arg_198_0 then
				local var_198_1 = arg_195_1.bgs_.STblack

				arg_195_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_198_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_198_2 = var_198_1:GetComponent("SpriteRenderer")

				if var_198_2 and var_198_2.sprite then
					local var_198_3 = 2 * (var_198_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_198_1.transform.localScale = Vector3.New(var_198_3 / var_198_2.sprite.bounds.size.y < var_198_3 * manager.ui.mainCameraCom_.aspect / var_198_2.sprite.bounds.size.x and var_198_3 * manager.ui.mainCameraCom_.aspect / var_198_2.sprite.bounds.size.x or var_198_3 / var_198_2.sprite.bounds.size.y, var_198_3 / var_198_2.sprite.bounds.size.y < var_198_3 * manager.ui.mainCameraCom_.aspect / var_198_2.sprite.bounds.size.x and var_198_3 * manager.ui.mainCameraCom_.aspect / var_198_2.sprite.bounds.size.x or var_198_3 / var_198_2.sprite.bounds.size.y, 0)
				end

				for iter_198_0, iter_198_1 in pairs(arg_195_1.bgs_) do
					if iter_198_0 ~= "STblack" then
						iter_198_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_198_4 = 0

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.mask_.enabled = true
				arg_195_1.mask_.raycastTarget = true

				arg_195_1:SetGaussion(false)
			end

			local var_198_5 = 0.366666666666667

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_5 then
				local var_198_6 = Color.New(1, 1, 1)

				var_198_6.a = Mathf.Lerp(1, 0, (arg_195_1.time_ - var_198_4) / var_198_5)
				arg_195_1.mask_.color = var_198_6
			end

			if arg_195_1.time_ >= var_198_4 + var_198_5 and arg_195_1.time_ < var_198_4 + var_198_5 + arg_198_0 then
				local var_198_7 = Color.New(1, 1, 1)

				arg_195_1.mask_.enabled = false
				var_198_7.a = 0
				arg_195_1.mask_.color = var_198_7
			end

			local var_198_8 = 0.366666666666667

			if 0.366666666666667 < arg_195_1.time_ and arg_195_1.time_ <= var_198_8 + arg_198_0 then
				arg_195_1.mask_.enabled = true
				arg_195_1.mask_.raycastTarget = true

				arg_195_1:SetGaussion(false)
			end

			local var_198_9 = 0.1

			if var_198_8 <= arg_195_1.time_ and arg_195_1.time_ < var_198_8 + var_198_9 then
				local var_198_10 = Color.New(1, 1, 1)

				var_198_10.a = Mathf.Lerp(1, 0, (arg_195_1.time_ - var_198_8) / var_198_9)
				arg_195_1.mask_.color = var_198_10
			end

			if arg_195_1.time_ >= var_198_8 + var_198_9 and arg_195_1.time_ < var_198_8 + var_198_9 + arg_198_0 then
				local var_198_11 = Color.New(1, 1, 1)

				arg_195_1.mask_.enabled = false
				var_198_11.a = 0
				arg_195_1.mask_.color = var_198_11
			end

			local var_198_12 = 0.5666667

			if 0.5666667 < arg_195_1.time_ and arg_195_1.time_ <= var_198_12 + arg_198_0 then
				arg_195_1.mask_.enabled = true
				arg_195_1.mask_.raycastTarget = true

				arg_195_1:SetGaussion(false)
			end

			local var_198_13 = 0.1

			if var_198_12 <= arg_195_1.time_ and arg_195_1.time_ < var_198_12 + var_198_13 then
				local var_198_14 = Color.New(1, 1, 1)

				var_198_14.a = Mathf.Lerp(1, 0, (arg_195_1.time_ - var_198_12) / var_198_13)
				arg_195_1.mask_.color = var_198_14
			end

			if arg_195_1.time_ >= var_198_12 + var_198_13 and arg_195_1.time_ < var_198_12 + var_198_13 + arg_198_0 then
				local var_198_15 = Color.New(1, 1, 1)

				arg_195_1.mask_.enabled = false
				var_198_15.a = 0
				arg_195_1.mask_.color = var_198_15
			end

			local var_198_16 = arg_195_1.actors_["10146"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10146 = var_198_16.localPosition
				var_198_16.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10146", 7)

				for iter_198_2 = 0, var_198_16.childCount - 1 do
					local var_198_17 = var_198_16:GetChild(iter_198_2)

					if var_198_17.name == "" or not string.find(var_198_17.name, "split") then
						var_198_17.gameObject:SetActive(true)
					else
						var_198_17.gameObject:SetActive(false)
					end
				end
			end

			local var_198_18 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_18 then
				var_198_16.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10146, Vector3.New(0, -2000, 0), (arg_195_1.time_ - 0) / var_198_18)
			end

			if arg_195_1.time_ >= 0 + var_198_18 and arg_195_1.time_ < 0 + var_198_18 + arg_198_0 then
				var_198_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_19 = 0

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_19 + arg_198_0 then
				arg_195_1.allBtn_.enabled = false
			end

			if arg_195_1.time_ >= var_198_19 + 0.833333333333333 and arg_195_1.time_ < var_198_19 + 0.833333333333333 + arg_198_0 then
				arg_195_1.allBtn_.enabled = true
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:AudioAction("play", "effect", "se_story_144", "se_story_144_metal02", "")
			end

			if arg_195_1.frameCnt_ <= 1 then
				arg_195_1.dialog_:SetActive(false)
			end

			local var_198_21 = 0.6666667
			local var_198_22 = 0.35

			if 0.6666667 < arg_195_1.time_ and arg_195_1.time_ <= var_198_21 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0

				arg_195_1.dialog_:SetActive(true)

				arg_195_1.dialogCg_.alpha = 0

				local var_198_23 = LeanTween.value(arg_195_1.dialog_, 0, 1, 0.3)

				var_198_23:setOnUpdate(LuaHelper.FloatAction(function(arg_199_0)
					arg_195_1.dialogCg_.alpha = arg_199_0
				end))
				var_198_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_195_1.dialog_)
					var_198_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_195_1.duration_ = arg_195_1.duration_ + 0.3

				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10146_split_5")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_24 = arg_195_1:GetWordFromCfg(423101046)
				local var_198_25 = arg_195_1:FormatText(var_198_24.content)

				arg_195_1.text_.text = var_198_25

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_27 = 14 <= 0 and var_198_22 or var_198_22 * (utf8.len(var_198_25) / 14)

				if (14 <= 0 and var_198_22 or var_198_22 * (utf8.len(var_198_25) / 14)) > 0 and var_198_22 < var_198_27 then
					arg_195_1.talkMaxDuration = var_198_27
					var_198_21 = var_198_21 + 0.3

					if var_198_27 + var_198_21 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_27 + var_198_21
					end
				end

				arg_195_1.text_.text = var_198_25
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101046", "story_v_out_423101.awb") ~= 0 then
					local var_198_28 = manager.audio:GetVoiceLength("story_v_out_423101", "423101046", "story_v_out_423101.awb") / 1000

					if var_198_28 + var_198_21 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_28 + var_198_21
					end

					if var_198_24.prefab_name ~= "" and arg_195_1.actors_[var_198_24.prefab_name] ~= nil then
						local var_198_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_24.prefab_name].transform, "story_v_out_423101", "423101046", "story_v_out_423101.awb")

						arg_195_1:RecordAudio("423101046", var_198_29)
						arg_195_1:RecordAudio("423101046", var_198_29)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_423101", "423101046", "story_v_out_423101.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_423101", "423101046", "story_v_out_423101.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_30 = var_198_21 + 0.3
			local var_198_31 = math.max(var_198_22, arg_195_1.talkMaxDuration)

			if var_198_21 + 0.3 <= arg_195_1.time_ and arg_195_1.time_ < var_198_30 + var_198_31 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_30) / var_198_31

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_30 + var_198_31 and arg_195_1.time_ < var_198_30 + var_198_31 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
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
	Play423101047 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 423101047
		arg_201_1.duration_ = 6.33

		local var_201_0 = {
			zh = 5.433,
			ja = 6.333
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
				arg_201_0:Play423101048(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.65

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10146_split_3")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_1 = arg_201_1:GetWordFromCfg(423101047)
				local var_204_2 = arg_201_1:FormatText(var_204_1.content)

				arg_201_1.text_.text = var_204_2

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_4 = 26 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 26)

				if (26 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_2) / 26)) > 0 and var_204_0 < var_204_4 then
					arg_201_1.talkMaxDuration = var_204_4

					if var_204_4 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_4 + 0
					end
				end

				arg_201_1.text_.text = var_204_2
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101047", "story_v_out_423101.awb") ~= 0 then
					local var_204_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101047", "story_v_out_423101.awb") / 1000

					if var_204_5 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_5 + 0
					end

					if var_204_1.prefab_name ~= "" and arg_201_1.actors_[var_204_1.prefab_name] ~= nil then
						local var_204_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_1.prefab_name].transform, "story_v_out_423101", "423101047", "story_v_out_423101.awb")

						arg_201_1:RecordAudio("423101047", var_204_6)
						arg_201_1:RecordAudio("423101047", var_204_6)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_423101", "423101047", "story_v_out_423101.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_423101", "423101047", "story_v_out_423101.awb")
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
	Play423101048 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 423101048
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play423101049(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 1.225

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(423101048).content)

				arg_205_1.text_.text = var_208_1

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_3 = 49 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 49)

				if (49 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_1) / 49)) > 0 and var_208_0 < var_208_3 then
					arg_205_1.talkMaxDuration = var_208_3

					if var_208_3 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_3 + 0
					end
				end

				arg_205_1.text_.text = var_208_1
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_4 = math.max(var_208_0, arg_205_1.talkMaxDuration)

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - 0) / var_208_4

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play423101049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 423101049
		arg_209_1.duration_ = 7.7

		local var_209_0 = {
			zh = 3.966,
			ja = 7.7
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
				arg_209_0:Play423101050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["10146"]) and arg_209_1.var_.actorSpriteComps10146 == nil then
				arg_209_1.var_.actorSpriteComps10146 = arg_209_1.actors_["10146"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_0 = 0.2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["10146"]) then
				if arg_209_1.var_.actorSpriteComps10146 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_212_1 then
							if arg_209_1.isInRecall_ then
								iter_212_1.color = Color.New(Mathf.Lerp(iter_212_1.color.r, arg_209_1.hightColor1.r, (arg_209_1.time_ - 0) / var_212_0), Mathf.Lerp(iter_212_1.color.g, arg_209_1.hightColor1.g, (arg_209_1.time_ - 0) / var_212_0), (Mathf.Lerp(iter_212_1.color.b, arg_209_1.hightColor1.b, (arg_209_1.time_ - 0) / var_212_0)))
							else
								local var_212_1 = Mathf.Lerp(iter_212_1.color.r, 1, (arg_209_1.time_ - 0) / var_212_0)

								iter_212_1.color = Color.New(var_212_1, var_212_1, var_212_1)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["10146"]) and arg_209_1.var_.actorSpriteComps10146 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_212_3 then
						iter_212_3.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_209_1.var_.actorSpriteComps10146 = nil
			end

			local var_212_2 = arg_209_1.actors_["10146"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos10146 = var_212_2.localPosition
				var_212_2.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10146", 3)

				for iter_212_4 = 0, var_212_2.childCount - 1 do
					local var_212_3 = var_212_2:GetChild(iter_212_4)

					if var_212_3.name == "split_3" or not string.find(var_212_3.name, "split") then
						var_212_3.gameObject:SetActive(true)
					else
						var_212_3.gameObject:SetActive(false)
					end
				end
			end

			local var_212_4 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				var_212_2.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_209_1.time_ - 0) / var_212_4)
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				var_212_2.localPosition = Vector3.New(0, -350, -320)
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				local var_212_5 = arg_209_1.actors_["10146"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_212_5 then
					arg_209_1.var_.alphaOldValue10146 = var_212_5.alpha
					arg_209_1.var_.characterEffect10146 = var_212_5
				end

				arg_209_1.var_.alphaOldValue10146 = 0
			end

			local var_212_6 = 0.5

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_6 then
				if arg_209_1.var_.characterEffect10146 then
					arg_209_1.var_.characterEffect10146.alpha = Mathf.Lerp(arg_209_1.var_.alphaOldValue10146, 1, (arg_209_1.time_ - 0) / var_212_6)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_6 and arg_209_1.time_ < 0 + var_212_6 + arg_212_0 and arg_209_1.var_.characterEffect10146 then
				arg_209_1.var_.characterEffect10146.alpha = 1
			end

			local var_212_7 = 0
			local var_212_8 = 0.425

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_7 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_9 = arg_209_1:GetWordFromCfg(423101049)
				local var_212_10 = arg_209_1:FormatText(var_212_9.content)

				arg_209_1.text_.text = var_212_10

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_12 = 17 <= 0 and var_212_8 or var_212_8 * (utf8.len(var_212_10) / 17)

				if (17 <= 0 and var_212_8 or var_212_8 * (utf8.len(var_212_10) / 17)) > 0 and var_212_8 < var_212_12 then
					arg_209_1.talkMaxDuration = var_212_12

					if var_212_12 + var_212_7 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_12 + var_212_7
					end
				end

				arg_209_1.text_.text = var_212_10
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101049", "story_v_out_423101.awb") ~= 0 then
					local var_212_13 = manager.audio:GetVoiceLength("story_v_out_423101", "423101049", "story_v_out_423101.awb") / 1000

					if var_212_13 + var_212_7 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_7
					end

					if var_212_9.prefab_name ~= "" and arg_209_1.actors_[var_212_9.prefab_name] ~= nil then
						local var_212_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_9.prefab_name].transform, "story_v_out_423101", "423101049", "story_v_out_423101.awb")

						arg_209_1:RecordAudio("423101049", var_212_14)
						arg_209_1:RecordAudio("423101049", var_212_14)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_423101", "423101049", "story_v_out_423101.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_423101", "423101049", "story_v_out_423101.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_15 = math.max(var_212_8, arg_209_1.talkMaxDuration)

			if var_212_7 <= arg_209_1.time_ and arg_209_1.time_ < var_212_7 + var_212_15 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_7) / var_212_15

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_7 + var_212_15 and arg_209_1.time_ < var_212_7 + var_212_15 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
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
	Play423101050 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 423101050
		arg_213_1.duration_ = 7.77

		local var_213_0 = {
			zh = 7.366,
			ja = 7.766
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
				arg_213_0:Play423101051(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0.7

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_1 = arg_213_1:GetWordFromCfg(423101050)
				local var_216_2 = arg_213_1:FormatText(var_216_1.content)

				arg_213_1.text_.text = var_216_2

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_4 = 28 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 28)

				if (28 <= 0 and var_216_0 or var_216_0 * (utf8.len(var_216_2) / 28)) > 0 and var_216_0 < var_216_4 then
					arg_213_1.talkMaxDuration = var_216_4

					if var_216_4 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_4 + 0
					end
				end

				arg_213_1.text_.text = var_216_2
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101050", "story_v_out_423101.awb") ~= 0 then
					local var_216_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101050", "story_v_out_423101.awb") / 1000

					if var_216_5 + 0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_5 + 0
					end

					if var_216_1.prefab_name ~= "" and arg_213_1.actors_[var_216_1.prefab_name] ~= nil then
						local var_216_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_1.prefab_name].transform, "story_v_out_423101", "423101050", "story_v_out_423101.awb")

						arg_213_1:RecordAudio("423101050", var_216_6)
						arg_213_1:RecordAudio("423101050", var_216_6)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_423101", "423101050", "story_v_out_423101.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_423101", "423101050", "story_v_out_423101.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_0, arg_213_1.talkMaxDuration)

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - 0) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play423101051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 423101051
		arg_217_1.duration_ = 5.7

		local var_217_0 = {
			zh = 5.2,
			ja = 5.7
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
				arg_217_0:Play423101052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos10146 = arg_217_1.actors_["10146"].transform.localPosition
				arg_217_1.actors_["10146"].transform.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("10146", 3)

				for iter_220_0 = 0, arg_217_1.actors_["10146"].transform.childCount - 1 do
					local var_220_0 = arg_217_1.actors_["10146"].transform:GetChild(iter_220_0)

					if var_220_0.name == "split_5" or not string.find(var_220_0.name, "split") then
						var_220_0.gameObject:SetActive(true)
					else
						var_220_0.gameObject:SetActive(false)
					end
				end
			end

			local var_220_1 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_1 then
				arg_217_1.actors_["10146"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_217_1.time_ - 0) / var_220_1)
			end

			if arg_217_1.time_ >= 0 + var_220_1 and arg_217_1.time_ < 0 + var_220_1 + arg_220_0 then
				arg_217_1.actors_["10146"].transform.localPosition = Vector3.New(0, -350, -320)
			end

			local var_220_2 = manager.ui.mainCamera.transform

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.shakeOldPos = var_220_2.localPosition
			end

			local var_220_3 = 0.6

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_3 then
				local var_220_4, var_220_5 = math.modf((arg_217_1.time_ - 0) / 0.066)

				var_220_2.localPosition = Vector3.New(var_220_5 * 0.13, var_220_5 * 0.13, var_220_5 * 0.13) + arg_217_1.var_.shakeOldPos
			end

			if arg_217_1.time_ >= 0 + var_220_3 and arg_217_1.time_ < 0 + var_220_3 + arg_220_0 then
				var_220_2.localPosition = arg_217_1.var_.shakeOldPos
			end

			local var_220_6 = 0

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_6 + arg_220_0 then
				arg_217_1.allBtn_.enabled = false
			end

			if arg_217_1.time_ >= var_220_6 + 0.6 and arg_217_1.time_ < var_220_6 + 0.6 + arg_220_0 then
				arg_217_1.allBtn_.enabled = true
			end

			if 0.034 < arg_217_1.time_ and arg_217_1.time_ <= 0.034 + arg_220_0 then
				arg_217_1:AudioAction("play", "effect", "se_story_144", "se_story_144_saw", "")
			end

			local var_220_8 = 0
			local var_220_9 = 0.4

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_8 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_10 = arg_217_1:GetWordFromCfg(423101051)
				local var_220_11 = arg_217_1:FormatText(var_220_10.content)

				arg_217_1.text_.text = var_220_11

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_13 = 16 <= 0 and var_220_9 or var_220_9 * (utf8.len(var_220_11) / 16)

				if (16 <= 0 and var_220_9 or var_220_9 * (utf8.len(var_220_11) / 16)) > 0 and var_220_9 < var_220_13 then
					arg_217_1.talkMaxDuration = var_220_13

					if var_220_13 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_13 + var_220_8
					end
				end

				arg_217_1.text_.text = var_220_11
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101051", "story_v_out_423101.awb") ~= 0 then
					local var_220_14 = manager.audio:GetVoiceLength("story_v_out_423101", "423101051", "story_v_out_423101.awb") / 1000

					if var_220_14 + var_220_8 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_14 + var_220_8
					end

					if var_220_10.prefab_name ~= "" and arg_217_1.actors_[var_220_10.prefab_name] ~= nil then
						local var_220_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_10.prefab_name].transform, "story_v_out_423101", "423101051", "story_v_out_423101.awb")

						arg_217_1:RecordAudio("423101051", var_220_15)
						arg_217_1:RecordAudio("423101051", var_220_15)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_423101", "423101051", "story_v_out_423101.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_423101", "423101051", "story_v_out_423101.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_16 = math.max(var_220_9, arg_217_1.talkMaxDuration)

			if var_220_8 <= arg_217_1.time_ and arg_217_1.time_ < var_220_8 + var_220_16 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_8) / var_220_16

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_8 + var_220_16 and arg_217_1.time_ < var_220_8 + var_220_16 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play423101052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 423101052
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play423101053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["10146"]) and arg_221_1.var_.actorSpriteComps10146 == nil then
				arg_221_1.var_.actorSpriteComps10146 = arg_221_1.actors_["10146"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_0 = 0.2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["10146"]) then
				if arg_221_1.var_.actorSpriteComps10146 then
					for iter_224_0, iter_224_1 in pairs(arg_221_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_224_1 then
							if arg_221_1.isInRecall_ then
								iter_224_1.color = Color.New(Mathf.Lerp(iter_224_1.color.r, arg_221_1.hightColor2.r, (arg_221_1.time_ - 0) / var_224_0), Mathf.Lerp(iter_224_1.color.g, arg_221_1.hightColor2.g, (arg_221_1.time_ - 0) / var_224_0), (Mathf.Lerp(iter_224_1.color.b, arg_221_1.hightColor2.b, (arg_221_1.time_ - 0) / var_224_0)))
							else
								local var_224_1 = Mathf.Lerp(iter_224_1.color.r, 0.5, (arg_221_1.time_ - 0) / var_224_0)

								iter_224_1.color = Color.New(var_224_1, var_224_1, var_224_1)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["10146"]) and arg_221_1.var_.actorSpriteComps10146 then
				for iter_224_2, iter_224_3 in pairs(arg_221_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_224_3 then
						iter_224_3.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_221_1.var_.actorSpriteComps10146 = nil
			end

			local var_224_2 = arg_221_1.actors_["10146"].transform

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos10146 = var_224_2.localPosition
				var_224_2.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10146", 7)

				for iter_224_4 = 0, var_224_2.childCount - 1 do
					local var_224_3 = var_224_2:GetChild(iter_224_4)

					if var_224_3.name == "" or not string.find(var_224_3.name, "split") then
						var_224_3.gameObject:SetActive(true)
					else
						var_224_3.gameObject:SetActive(false)
					end
				end
			end

			local var_224_4 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 then
				var_224_2.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10146, Vector3.New(0, -2000, 0), (arg_221_1.time_ - 0) / var_224_4)
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 then
				var_224_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.866666666666667 < arg_221_1.time_ and arg_221_1.time_ <= 0.866666666666667 + arg_224_0 then
				arg_221_1:AudioAction("play", "effect", "se_story_4", "se_story_4_arm_2", "")
			end

			local var_224_6 = 0
			local var_224_7 = 1.7

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_6 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_8 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(423101052).content)

				arg_221_1.text_.text = var_224_8

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_10 = 68 <= 0 and var_224_7 or var_224_7 * (utf8.len(var_224_8) / 68)

				if (68 <= 0 and var_224_7 or var_224_7 * (utf8.len(var_224_8) / 68)) > 0 and var_224_7 < var_224_10 then
					arg_221_1.talkMaxDuration = var_224_10

					if var_224_10 + var_224_6 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_10 + var_224_6
					end
				end

				arg_221_1.text_.text = var_224_8
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_11 = math.max(var_224_7, arg_221_1.talkMaxDuration)

			if var_224_6 <= arg_221_1.time_ and arg_221_1.time_ < var_224_6 + var_224_11 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_6) / var_224_11

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_6 + var_224_11 and arg_221_1.time_ < var_224_6 + var_224_11 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play423101053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 423101053
		arg_225_1.duration_ = 15.67

		local var_225_0 = {
			zh = 11.6,
			ja = 15.666
		}
		local var_225_1 = manager.audio:GetLocalizationFlag()

		if var_225_0[var_225_1] ~= nil then
			arg_225_1.duration_ = var_225_0[var_225_1]
		end

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play423101054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["10146"]) and arg_225_1.var_.actorSpriteComps10146 == nil then
				arg_225_1.var_.actorSpriteComps10146 = arg_225_1.actors_["10146"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_0 = 0.2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["10146"]) then
				if arg_225_1.var_.actorSpriteComps10146 then
					for iter_228_0, iter_228_1 in pairs(arg_225_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_228_1 then
							if arg_225_1.isInRecall_ then
								iter_228_1.color = Color.New(Mathf.Lerp(iter_228_1.color.r, arg_225_1.hightColor1.r, (arg_225_1.time_ - 0) / var_228_0), Mathf.Lerp(iter_228_1.color.g, arg_225_1.hightColor1.g, (arg_225_1.time_ - 0) / var_228_0), (Mathf.Lerp(iter_228_1.color.b, arg_225_1.hightColor1.b, (arg_225_1.time_ - 0) / var_228_0)))
							else
								local var_228_1 = Mathf.Lerp(iter_228_1.color.r, 1, (arg_225_1.time_ - 0) / var_228_0)

								iter_228_1.color = Color.New(var_228_1, var_228_1, var_228_1)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["10146"]) and arg_225_1.var_.actorSpriteComps10146 then
				for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_228_3 then
						iter_228_3.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_225_1.var_.actorSpriteComps10146 = nil
			end

			local var_228_2 = arg_225_1.actors_["10146"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10146 = var_228_2.localPosition
				var_228_2.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10146", 3)

				for iter_228_4 = 0, var_228_2.childCount - 1 do
					local var_228_3 = var_228_2:GetChild(iter_228_4)

					if var_228_3.name == "split_3" or not string.find(var_228_3.name, "split") then
						var_228_3.gameObject:SetActive(true)
					else
						var_228_3.gameObject:SetActive(false)
					end
				end
			end

			local var_228_4 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				var_228_2.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_225_1.time_ - 0) / var_228_4)
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				var_228_2.localPosition = Vector3.New(0, -350, -320)
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				local var_228_5 = arg_225_1.actors_["10146"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_228_5 then
					arg_225_1.var_.alphaOldValue10146 = var_228_5.alpha
					arg_225_1.var_.characterEffect10146 = var_228_5
				end

				arg_225_1.var_.alphaOldValue10146 = 0
			end

			local var_228_6 = 1

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_6 then
				if arg_225_1.var_.characterEffect10146 then
					arg_225_1.var_.characterEffect10146.alpha = Mathf.Lerp(arg_225_1.var_.alphaOldValue10146, 1, (arg_225_1.time_ - 0) / var_228_6)
				end
			end

			if arg_225_1.time_ >= 0 + var_228_6 and arg_225_1.time_ < 0 + var_228_6 + arg_228_0 and arg_225_1.var_.characterEffect10146 then
				arg_225_1.var_.characterEffect10146.alpha = 1
			end

			if 0.666666666666667 < arg_225_1.time_ and arg_225_1.time_ <= 0.666666666666667 + arg_228_0 then
				arg_225_1:AudioAction("play", "effect", "se_story_144", "se_story_144_saw", "")
			end

			local var_228_8 = 0
			local var_228_9 = 0.875

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_8 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_10 = arg_225_1:GetWordFromCfg(423101053)
				local var_228_11 = arg_225_1:FormatText(var_228_10.content)

				arg_225_1.text_.text = var_228_11

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_13 = 35 <= 0 and var_228_9 or var_228_9 * (utf8.len(var_228_11) / 35)

				if (35 <= 0 and var_228_9 or var_228_9 * (utf8.len(var_228_11) / 35)) > 0 and var_228_9 < var_228_13 then
					arg_225_1.talkMaxDuration = var_228_13

					if var_228_13 + var_228_8 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_8
					end
				end

				arg_225_1.text_.text = var_228_11
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101053", "story_v_out_423101.awb") ~= 0 then
					local var_228_14 = manager.audio:GetVoiceLength("story_v_out_423101", "423101053", "story_v_out_423101.awb") / 1000

					if var_228_14 + var_228_8 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_14 + var_228_8
					end

					if var_228_10.prefab_name ~= "" and arg_225_1.actors_[var_228_10.prefab_name] ~= nil then
						local var_228_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_10.prefab_name].transform, "story_v_out_423101", "423101053", "story_v_out_423101.awb")

						arg_225_1:RecordAudio("423101053", var_228_15)
						arg_225_1:RecordAudio("423101053", var_228_15)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_423101", "423101053", "story_v_out_423101.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_423101", "423101053", "story_v_out_423101.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_16 = math.max(var_228_9, arg_225_1.talkMaxDuration)

			if var_228_8 <= arg_225_1.time_ and arg_225_1.time_ < var_228_8 + var_228_16 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_8) / var_228_16

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_8 + var_228_16 and arg_225_1.time_ < var_228_8 + var_228_16 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play423101054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 423101054
		arg_229_1.duration_ = 10.93

		local var_229_0 = {
			zh = 7.9,
			ja = 10.933
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play423101055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos10146 = arg_229_1.actors_["10146"].transform.localPosition
				arg_229_1.actors_["10146"].transform.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("10146", 3)

				for iter_232_0 = 0, arg_229_1.actors_["10146"].transform.childCount - 1 do
					local var_232_0 = arg_229_1.actors_["10146"].transform:GetChild(iter_232_0)

					if var_232_0.name == "split_3" or not string.find(var_232_0.name, "split") then
						var_232_0.gameObject:SetActive(true)
					else
						var_232_0.gameObject:SetActive(false)
					end
				end
			end

			local var_232_1 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_1 then
				arg_229_1.actors_["10146"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_229_1.time_ - 0) / var_232_1)
			end

			if arg_229_1.time_ >= 0 + var_232_1 and arg_229_1.time_ < 0 + var_232_1 + arg_232_0 then
				arg_229_1.actors_["10146"].transform.localPosition = Vector3.New(0, -350, -320)
			end

			local var_232_2 = 0
			local var_232_3 = 0.8

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_4 = arg_229_1:GetWordFromCfg(423101054)
				local var_232_5 = arg_229_1:FormatText(var_232_4.content)

				arg_229_1.text_.text = var_232_5

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_7 = 32 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 32)

				if (32 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 32)) > 0 and var_232_3 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_2
					end
				end

				arg_229_1.text_.text = var_232_5
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101054", "story_v_out_423101.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101054", "story_v_out_423101.awb") / 1000

					if var_232_8 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_2
					end

					if var_232_4.prefab_name ~= "" and arg_229_1.actors_[var_232_4.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_4.prefab_name].transform, "story_v_out_423101", "423101054", "story_v_out_423101.awb")

						arg_229_1:RecordAudio("423101054", var_232_9)
						arg_229_1:RecordAudio("423101054", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_423101", "423101054", "story_v_out_423101.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_423101", "423101054", "story_v_out_423101.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_3, arg_229_1.talkMaxDuration)

			if var_232_2 <= arg_229_1.time_ and arg_229_1.time_ < var_232_2 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_2) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_2 + var_232_10 and arg_229_1.time_ < var_232_2 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play423101055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 423101055
		arg_233_1.duration_ = 11.97

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play423101056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_9001
			local var_236_9000

			if arg_233_1.bgs_.SS2303a == nil then
				local var_236_0 = Object.Instantiate(arg_233_1.paintGo_)

				var_236_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2303a")
				var_236_0.name = "SS2303a"
				var_236_0.transform.parent = arg_233_1.stage_.transform
				var_236_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.bgs_.SS2303a = var_236_0
			end

			if 1 < arg_233_1.time_ and arg_233_1.time_ <= 1 + arg_236_0 then
				local var_236_1 = arg_233_1.bgs_.SS2303a

				arg_233_1.bgs_.SS2303a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_236_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_2 = var_236_1:GetComponent("SpriteRenderer")

				if var_236_2 and var_236_2.sprite then
					local var_236_3 = 2 * (var_236_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_236_1.transform.localScale = Vector3.New(var_236_3 / var_236_2.sprite.bounds.size.y < var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x and var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x or var_236_3 / var_236_2.sprite.bounds.size.y, var_236_3 / var_236_2.sprite.bounds.size.y < var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x and var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x or var_236_3 / var_236_2.sprite.bounds.size.y, 0)
				end

				for iter_236_0, iter_236_1 in pairs(arg_233_1.bgs_) do
					if iter_236_0 ~= "SS2303a" then
						iter_236_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_236_4 = 3

			if 3 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.allBtn_.enabled = false
			end

			if arg_233_1.time_ >= var_236_4 + 0.3 and arg_233_1.time_ < var_236_4 + 0.3 + arg_236_0 then
				arg_233_1.allBtn_.enabled = true
			end

			local var_236_5 = 0

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_6 = 1

			if var_236_5 <= arg_233_1.time_ and arg_233_1.time_ < var_236_5 + var_236_6 then
				local var_236_7 = Color.New(0, 0, 0)

				var_236_7.a = Mathf.Lerp(0, 1, (arg_233_1.time_ - var_236_5) / var_236_6)
				arg_233_1.mask_.color = var_236_7
			end

			if arg_233_1.time_ >= var_236_5 + var_236_6 and arg_233_1.time_ < var_236_5 + var_236_6 + arg_236_0 then
				local var_236_8 = Color.New(0, 0, 0)

				var_236_8.a = 1
				arg_233_1.mask_.color = var_236_8
			end

			local var_236_9 = 1

			if 1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_9 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_10 = 2

			if var_236_9 <= arg_233_1.time_ and arg_233_1.time_ < var_236_9 + var_236_10 then
				local var_236_11 = Color.New(0, 0, 0)

				var_236_11.a = Mathf.Lerp(1, 0, (arg_233_1.time_ - var_236_9) / var_236_10)
				arg_233_1.mask_.color = var_236_11
			end

			if arg_233_1.time_ >= var_236_9 + var_236_10 and arg_233_1.time_ < var_236_9 + var_236_10 + arg_236_0 then
				local var_236_12 = Color.New(0, 0, 0)

				arg_233_1.mask_.enabled = false
				var_236_12.a = 0
				arg_233_1.mask_.color = var_236_12
			end

			local var_236_13 = arg_233_1.actors_["10146"]

			if 0.966 < arg_233_1.time_ and arg_233_1.time_ <= 0.966 + arg_236_0 and not isNil(var_236_13) and arg_233_1.var_.actorSpriteComps10146 == nil then
				arg_233_1.var_.actorSpriteComps10146 = var_236_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_14 = 0.034

			if 0.966 <= arg_233_1.time_ and arg_233_1.time_ < 0.966 + var_236_14 and not isNil(var_236_13) then
				if arg_233_1.var_.actorSpriteComps10146 then
					for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_236_3 then
							if arg_233_1.isInRecall_ then
								iter_236_3.color = Color.New(Mathf.Lerp(iter_236_3.color.r, arg_233_1.hightColor2.r, (arg_233_1.time_ - 0.966) / var_236_14), Mathf.Lerp(iter_236_3.color.g, arg_233_1.hightColor2.g, (arg_233_1.time_ - 0.966) / var_236_14), (Mathf.Lerp(iter_236_3.color.b, arg_233_1.hightColor2.b, (arg_233_1.time_ - 0.966) / var_236_14)))
							else
								local var_236_15 = Mathf.Lerp(iter_236_3.color.r, 0.5, (arg_233_1.time_ - 0.966) / var_236_14)

								iter_236_3.color = Color.New(var_236_15, var_236_15, var_236_15)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= 0.966 + var_236_14 and arg_233_1.time_ < 0.966 + var_236_14 + arg_236_0 and not isNil(var_236_13) and arg_233_1.var_.actorSpriteComps10146 then
				for iter_236_4, iter_236_5 in pairs(arg_233_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_236_5 then
						iter_236_5.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_233_1.var_.actorSpriteComps10146 = nil
			end

			local var_236_16 = arg_233_1.actors_["10146"].transform

			if 0.966 < arg_233_1.time_ and arg_233_1.time_ <= 0.966 + arg_236_0 then
				arg_233_1.var_.moveOldPos10146 = var_236_16.localPosition
				var_236_16.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10146", 7)

				for iter_236_6 = 0, var_236_16.childCount - 1 do
					local var_236_17 = var_236_16:GetChild(iter_236_6)

					if var_236_17.name == "" or not string.find(var_236_17.name, "split") then
						var_236_17.gameObject:SetActive(true)
					else
						var_236_17.gameObject:SetActive(false)
					end
				end
			end

			local var_236_18 = 0.001

			if 0.966 <= arg_233_1.time_ and arg_233_1.time_ < 0.966 + var_236_18 then
				var_236_16.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10146, Vector3.New(0, -2000, 0), (arg_233_1.time_ - 0.966) / var_236_18)
			end

			if arg_233_1.time_ >= 0.966 + var_236_18 and arg_233_1.time_ < 0.966 + var_236_18 + arg_236_0 then
				var_236_16.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1 < arg_233_1.time_ and arg_233_1.time_ <= 1 + arg_236_0 then
				local var_236_19 = arg_233_1.var_.effectmatichentu1

				if not arg_233_1.var_.effectmatichentu1 then
					var_236_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_236_19.name = "matichentu1"
					arg_233_1.var_.effectmatichentu1 = var_236_19
				else
					var_236_19.transform:SetParent(var_236_9001)
				end

				var_236_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_236_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_233_1.time_ and arg_233_1.time_ <= 1 + arg_236_0 then
				local var_236_21 = arg_233_1.var_.effectmatichentu2

				if not arg_233_1.var_.effectmatichentu2 then
					var_236_21 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust_1"), manager.ui.mainCamera.transform)
					var_236_21.name = "matichentu2"
					arg_233_1.var_.effectmatichentu2 = var_236_21
				else
					var_236_21.transform:SetParent(var_236_9000)
				end

				var_236_21.transform.localPosition = Vector3.New(0, 0, 0)
				var_236_21.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_236_23 = manager.ui.mainCamera.transform

			if 1 < arg_233_1.time_ and arg_233_1.time_ <= 1 + arg_236_0 then
				arg_233_1.var_.shakeOldPos = var_236_23.localPosition
			end

			local var_236_24 = 1

			if 1 <= arg_233_1.time_ and arg_233_1.time_ < 1 + var_236_24 then
				local var_236_25, var_236_26 = math.modf((arg_233_1.time_ - 1) / 0.066)

				var_236_23.localPosition = Vector3.New(var_236_26 * 0.02, var_236_26 * 0.02, var_236_26 * 0.02) + arg_233_1.var_.shakeOldPos
			end

			if arg_233_1.time_ >= 1 + var_236_24 and arg_233_1.time_ < 1 + var_236_24 + arg_236_0 then
				var_236_23.localPosition = arg_233_1.var_.shakeOldPos
			end

			if 1.1 < arg_233_1.time_ and arg_233_1.time_ <= 1.1 + arg_236_0 then
				arg_233_1:AudioAction("play", "effect", "se_story_side_1067", "se_story_1067_horse01", "")
			end

			if 0.1 < arg_233_1.time_ and arg_233_1.time_ <= 0.1 + arg_236_0 then
				arg_233_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_drain", "")
			end

			if 0.566666666666667 < arg_233_1.time_ and arg_233_1.time_ <= 0.566666666666667 + arg_236_0 then
				arg_233_1:AudioAction("play", "effect", "se_story_side_1022", "se_story_side_1022_crowd", "")
			end

			if 0.566666666666667 < arg_233_1.time_ and arg_233_1.time_ <= 0.566666666666667 + arg_236_0 then
				arg_233_1:AudioAction("play", "effect", "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_31 = 3
			local var_236_32 = 0.85

			if 3 < arg_233_1.time_ and arg_233_1.time_ <= var_236_31 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_33 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_33:setOnUpdate(LuaHelper.FloatAction(function(arg_237_0)
					arg_233_1.dialogCg_.alpha = arg_237_0
				end))
				var_236_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[1326].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_34 = arg_233_1:GetWordFromCfg(423101055)
				local var_236_35 = arg_233_1:FormatText(var_236_34.content)

				arg_233_1.text_.text = var_236_35

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_37 = 34 <= 0 and var_236_32 or var_236_32 * (utf8.len(var_236_35) / 34)

				if (34 <= 0 and var_236_32 or var_236_32 * (utf8.len(var_236_35) / 34)) > 0 and var_236_32 < var_236_37 then
					arg_233_1.talkMaxDuration = var_236_37
					var_236_31 = var_236_31 + 0.3

					if var_236_37 + var_236_31 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_37 + var_236_31
					end
				end

				arg_233_1.text_.text = var_236_35
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101055", "story_v_out_423101.awb") ~= 0 then
					local var_236_38 = manager.audio:GetVoiceLength("story_v_out_423101", "423101055", "story_v_out_423101.awb") / 1000

					if var_236_38 + var_236_31 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_38 + var_236_31
					end

					if var_236_34.prefab_name ~= "" and arg_233_1.actors_[var_236_34.prefab_name] ~= nil then
						local var_236_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_34.prefab_name].transform, "story_v_out_423101", "423101055", "story_v_out_423101.awb")

						arg_233_1:RecordAudio("423101055", var_236_39)
						arg_233_1:RecordAudio("423101055", var_236_39)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_423101", "423101055", "story_v_out_423101.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_423101", "423101055", "story_v_out_423101.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_40 = var_236_31 + 0.3
			local var_236_41 = math.max(var_236_32, arg_233_1.talkMaxDuration)

			if var_236_31 + 0.3 <= arg_233_1.time_ and arg_233_1.time_ < var_236_40 + var_236_41 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_40) / var_236_41

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_40 + var_236_41 and arg_233_1.time_ < var_236_40 + var_236_41 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play423101056 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 423101056
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play423101057(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 2.025

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(423101056).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 81 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 81)

				if (81 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 81)) > 0 and var_242_0 < var_242_3 then
					arg_239_1.talkMaxDuration = var_242_3

					if var_242_3 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_3 + 0
					end
				end

				arg_239_1.text_.text = var_242_1
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_4 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_4 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_4

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_4 and arg_239_1.time_ < 0 + var_242_4 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play423101057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 423101057
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play423101058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0.3

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_1 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(423101057).content)

				arg_243_1.text_.text = var_246_1

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_3 = 12 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 12)

				if (12 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_1) / 12)) > 0 and var_246_0 < var_246_3 then
					arg_243_1.talkMaxDuration = var_246_3

					if var_246_3 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_3 + 0
					end
				end

				arg_243_1.text_.text = var_246_1
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_4 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_4

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play423101058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 423101058
		arg_247_1.duration_ = 11.3

		local var_247_0 = {
			zh = 7.266,
			ja = 11.3
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
				arg_247_0:Play423101059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0.85

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10148_split_1")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_1 = arg_247_1:GetWordFromCfg(423101058)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 34 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 34)

				if (34 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 34)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101058", "story_v_out_423101.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101058", "story_v_out_423101.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_423101", "423101058", "story_v_out_423101.awb")

						arg_247_1:RecordAudio("423101058", var_250_6)
						arg_247_1:RecordAudio("423101058", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_423101", "423101058", "story_v_out_423101.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_423101", "423101058", "story_v_out_423101.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_7 = math.max(var_250_0, arg_247_1.talkMaxDuration)

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_7 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - 0) / var_250_7

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= 0 + var_250_7 and arg_247_1.time_ < 0 + var_250_7 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play423101059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 423101059
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play423101060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["10148"]) and arg_251_1.var_.actorSpriteComps10148 == nil then
				arg_251_1.var_.actorSpriteComps10148 = arg_251_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_0 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["10148"]) then
				if arg_251_1.var_.actorSpriteComps10148 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["10148"]) and arg_251_1.var_.actorSpriteComps10148 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_254_3 then
						iter_254_3.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_251_1.var_.actorSpriteComps10148 = nil
			end

			local var_254_2 = 0
			local var_254_3 = 0.7

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_2 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_4 = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(423101059).content)

				arg_251_1.text_.text = var_254_4

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_6 = 28 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_4) / 28)

				if (28 <= 0 and var_254_3 or var_254_3 * (utf8.len(var_254_4) / 28)) > 0 and var_254_3 < var_254_6 then
					arg_251_1.talkMaxDuration = var_254_6

					if var_254_6 + var_254_2 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_6 + var_254_2
					end
				end

				arg_251_1.text_.text = var_254_4
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_7 = math.max(var_254_3, arg_251_1.talkMaxDuration)

			if var_254_2 <= arg_251_1.time_ and arg_251_1.time_ < var_254_2 + var_254_7 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_2) / var_254_7

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_2 + var_254_7 and arg_251_1.time_ < var_254_2 + var_254_7 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play423101060 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 423101060
		arg_255_1.duration_ = 16.73

		local var_255_0 = {
			zh = 10.866,
			ja = 16.733
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
				arg_255_0:Play423101061(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 1.125

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10148_split_1")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_1 = arg_255_1:GetWordFromCfg(423101060)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 45 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 45)

				if (45 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 45)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101060", "story_v_out_423101.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101060", "story_v_out_423101.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_423101", "423101060", "story_v_out_423101.awb")

						arg_255_1:RecordAudio("423101060", var_258_6)
						arg_255_1:RecordAudio("423101060", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_423101", "423101060", "story_v_out_423101.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_423101", "423101060", "story_v_out_423101.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_7 = math.max(var_258_0, arg_255_1.talkMaxDuration)

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - 0) / var_258_7

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play423101061 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 423101061
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play423101062(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["10148"]) and arg_259_1.var_.actorSpriteComps10148 == nil then
				arg_259_1.var_.actorSpriteComps10148 = arg_259_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_0 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["10148"]) then
				if arg_259_1.var_.actorSpriteComps10148 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["10148"]) and arg_259_1.var_.actorSpriteComps10148 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_262_3 then
						iter_262_3.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_259_1.var_.actorSpriteComps10148 = nil
			end

			local var_262_2 = 0
			local var_262_3 = 0.3

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_2 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, true)
				arg_259_1.iconController_:SetSelectedState("hero")

				arg_259_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_259_1.callingController_:SetSelectedState("normal")

				arg_259_1.keyicon_.color = Color.New(1, 1, 1)
				arg_259_1.icon_.color = Color.New(1, 1, 1)

				local var_262_4 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(423101061).content)

				arg_259_1.text_.text = var_262_4

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_6 = 12 <= 0 and var_262_3 or var_262_3 * (utf8.len(var_262_4) / 12)

				if (12 <= 0 and var_262_3 or var_262_3 * (utf8.len(var_262_4) / 12)) > 0 and var_262_3 < var_262_6 then
					arg_259_1.talkMaxDuration = var_262_6

					if var_262_6 + var_262_2 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_6 + var_262_2
					end
				end

				arg_259_1.text_.text = var_262_4
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_3, arg_259_1.talkMaxDuration)

			if var_262_2 <= arg_259_1.time_ and arg_259_1.time_ < var_262_2 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_2) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_2 + var_262_7 and arg_259_1.time_ < var_262_2 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play423101062 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 423101062
		arg_263_1.duration_ = 9

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play423101063(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 1.999999999999 < arg_263_1.time_ and arg_263_1.time_ <= 1.999999999999 + arg_266_0 then
				local var_266_0 = arg_263_1.bgs_.I25h

				arg_263_1.bgs_.I25h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_266_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_266_1 = var_266_0:GetComponent("SpriteRenderer")

				if var_266_1 and var_266_1.sprite then
					local var_266_2 = 2 * (var_266_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_266_0.transform.localScale = Vector3.New(var_266_2 / var_266_1.sprite.bounds.size.y < var_266_2 * manager.ui.mainCameraCom_.aspect / var_266_1.sprite.bounds.size.x and var_266_2 * manager.ui.mainCameraCom_.aspect / var_266_1.sprite.bounds.size.x or var_266_2 / var_266_1.sprite.bounds.size.y, var_266_2 / var_266_1.sprite.bounds.size.y < var_266_2 * manager.ui.mainCameraCom_.aspect / var_266_1.sprite.bounds.size.x and var_266_2 * manager.ui.mainCameraCom_.aspect / var_266_1.sprite.bounds.size.x or var_266_2 / var_266_1.sprite.bounds.size.y, 0)
				end

				for iter_266_0, iter_266_1 in pairs(arg_263_1.bgs_) do
					if iter_266_0 ~= "I25h" then
						iter_266_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_266_3 = 4

			if 4 < arg_263_1.time_ and arg_263_1.time_ <= var_266_3 + arg_266_0 then
				arg_263_1.allBtn_.enabled = false
			end

			if arg_263_1.time_ >= var_266_3 + 0.3 and arg_263_1.time_ < var_266_3 + 0.3 + arg_266_0 then
				arg_263_1.allBtn_.enabled = true
			end

			local var_266_4 = 0

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_5 = 2

			if var_266_4 <= arg_263_1.time_ and arg_263_1.time_ < var_266_4 + var_266_5 then
				local var_266_6 = Color.New(0, 0, 0)

				var_266_6.a = Mathf.Lerp(0, 1, (arg_263_1.time_ - var_266_4) / var_266_5)
				arg_263_1.mask_.color = var_266_6
			end

			if arg_263_1.time_ >= var_266_4 + var_266_5 and arg_263_1.time_ < var_266_4 + var_266_5 + arg_266_0 then
				local var_266_7 = Color.New(0, 0, 0)

				var_266_7.a = 1
				arg_263_1.mask_.color = var_266_7
			end

			local var_266_8 = 2

			if 2 < arg_263_1.time_ and arg_263_1.time_ <= var_266_8 + arg_266_0 then
				arg_263_1.mask_.enabled = true
				arg_263_1.mask_.raycastTarget = true

				arg_263_1:SetGaussion(false)
			end

			local var_266_9 = 2

			if var_266_8 <= arg_263_1.time_ and arg_263_1.time_ < var_266_8 + var_266_9 then
				local var_266_10 = Color.New(0, 0, 0)

				var_266_10.a = Mathf.Lerp(1, 0, (arg_263_1.time_ - var_266_8) / var_266_9)
				arg_263_1.mask_.color = var_266_10
			end

			if arg_263_1.time_ >= var_266_8 + var_266_9 and arg_263_1.time_ < var_266_8 + var_266_9 + arg_266_0 then
				local var_266_11 = Color.New(0, 0, 0)

				arg_263_1.mask_.enabled = false
				var_266_11.a = 0
				arg_263_1.mask_.color = var_266_11
			end

			local var_266_12 = arg_263_1.actors_["10148"].transform

			if 1.966 < arg_263_1.time_ and arg_263_1.time_ <= 1.966 + arg_266_0 then
				arg_263_1.var_.moveOldPos10148 = var_266_12.localPosition
				var_266_12.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("10148", 7)

				for iter_266_2 = 0, var_266_12.childCount - 1 do
					local var_266_13 = var_266_12:GetChild(iter_266_2)

					if var_266_13.name == "" or not string.find(var_266_13.name, "split") then
						var_266_13.gameObject:SetActive(true)
					else
						var_266_13.gameObject:SetActive(false)
					end
				end
			end

			local var_266_14 = 0.001

			if 1.966 <= arg_263_1.time_ and arg_263_1.time_ < 1.966 + var_266_14 then
				var_266_12.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10148, Vector3.New(0, -2000, 0), (arg_263_1.time_ - 1.966) / var_266_14)
			end

			if arg_263_1.time_ >= 1.966 + var_266_14 and arg_263_1.time_ < 1.966 + var_266_14 + arg_266_0 then
				var_266_12.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_263_1.frameCnt_ <= 1 then
				arg_263_1.dialog_:SetActive(false)
			end

			local var_266_15 = 4
			local var_266_16 = 1.55

			if 4 < arg_263_1.time_ and arg_263_1.time_ <= var_266_15 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0

				arg_263_1.dialog_:SetActive(true)

				arg_263_1.dialogCg_.alpha = 0

				local var_266_17 = LeanTween.value(arg_263_1.dialog_, 0, 1, 0.3)

				var_266_17:setOnUpdate(LuaHelper.FloatAction(function(arg_267_0)
					arg_263_1.dialogCg_.alpha = arg_267_0
				end))
				var_266_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_263_1.dialog_)
					var_266_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_263_1.duration_ = arg_263_1.duration_ + 0.3

				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_18 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(423101062).content)

				arg_263_1.text_.text = var_266_18

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_20 = 62 <= 0 and var_266_16 or var_266_16 * (utf8.len(var_266_18) / 62)

				if (62 <= 0 and var_266_16 or var_266_16 * (utf8.len(var_266_18) / 62)) > 0 and var_266_16 < var_266_20 then
					arg_263_1.talkMaxDuration = var_266_20
					var_266_15 = var_266_15 + 0.3

					if var_266_20 + var_266_15 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_20 + var_266_15
					end
				end

				arg_263_1.text_.text = var_266_18
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_21 = var_266_15 + 0.3
			local var_266_22 = math.max(var_266_16, arg_263_1.talkMaxDuration)

			if var_266_15 + 0.3 <= arg_263_1.time_ and arg_263_1.time_ < var_266_21 + var_266_22 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_21) / var_266_22

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_21 + var_266_22 and arg_263_1.time_ < var_266_21 + var_266_22 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
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
	Play423101063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 423101063
		arg_269_1.duration_ = 1.63

		local var_269_0 = {
			zh = 1.633,
			ja = 1.433
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
				arg_269_0:Play423101064(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos1083 = arg_269_1.actors_["1083"].transform.localPosition
				arg_269_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("1083", 2)

				for iter_272_0 = 0, arg_269_1.actors_["1083"].transform.childCount - 1 do
					local var_272_0 = arg_269_1.actors_["1083"].transform:GetChild(iter_272_0)

					if var_272_0.name == "split_6" or not string.find(var_272_0.name, "split") then
						var_272_0.gameObject:SetActive(true)
					else
						var_272_0.gameObject:SetActive(false)
					end
				end
			end

			local var_272_1 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_1 then
				arg_269_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1083, Vector3.New(-440, -345, -345), (arg_269_1.time_ - 0) / var_272_1)
			end

			if arg_269_1.time_ >= 0 + var_272_1 and arg_269_1.time_ < 0 + var_272_1 + arg_272_0 then
				arg_269_1.actors_["1083"].transform.localPosition = Vector3.New(-440, -345, -345)
			end

			local var_272_2 = arg_269_1.actors_["10148"].transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos10148 = var_272_2.localPosition
				var_272_2.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("10148", 4)

				for iter_272_1 = 0, var_272_2.childCount - 1 do
					local var_272_3 = var_272_2:GetChild(iter_272_1)

					if var_272_3.name == "split_5" or not string.find(var_272_3.name, "split") then
						var_272_3.gameObject:SetActive(true)
					else
						var_272_3.gameObject:SetActive(false)
					end
				end
			end

			local var_272_4 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_4 then
				var_272_2.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10148, Vector3.New(390, -350, -270), (arg_269_1.time_ - 0) / var_272_4)
			end

			if arg_269_1.time_ >= 0 + var_272_4 and arg_269_1.time_ < 0 + var_272_4 + arg_272_0 then
				var_272_2.localPosition = Vector3.New(390, -350, -270)
			end

			local var_272_5 = arg_269_1.actors_["1083"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_5) and arg_269_1.var_.actorSpriteComps1083 == nil then
				arg_269_1.var_.actorSpriteComps1083 = var_272_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_6 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_6 and not isNil(var_272_5) then
				if arg_269_1.var_.actorSpriteComps1083 then
					for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_272_3 then
							if arg_269_1.isInRecall_ then
								iter_272_3.color = Color.New(Mathf.Lerp(iter_272_3.color.r, arg_269_1.hightColor1.r, (arg_269_1.time_ - 0) / var_272_6), Mathf.Lerp(iter_272_3.color.g, arg_269_1.hightColor1.g, (arg_269_1.time_ - 0) / var_272_6), (Mathf.Lerp(iter_272_3.color.b, arg_269_1.hightColor1.b, (arg_269_1.time_ - 0) / var_272_6)))
							else
								local var_272_7 = Mathf.Lerp(iter_272_3.color.r, 1, (arg_269_1.time_ - 0) / var_272_6)

								iter_272_3.color = Color.New(var_272_7, var_272_7, var_272_7)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_6 and arg_269_1.time_ < 0 + var_272_6 + arg_272_0 and not isNil(var_272_5) and arg_269_1.var_.actorSpriteComps1083 then
				for iter_272_4, iter_272_5 in pairs(arg_269_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_272_5 then
						iter_272_5.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_269_1.var_.actorSpriteComps1083 = nil
			end

			local var_272_8 = arg_269_1.actors_["10148"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_8) and arg_269_1.var_.actorSpriteComps10148 == nil then
				arg_269_1.var_.actorSpriteComps10148 = var_272_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_9 = 0.2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_9 and not isNil(var_272_8) then
				if arg_269_1.var_.actorSpriteComps10148 then
					for iter_272_6, iter_272_7 in pairs(arg_269_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_272_7 then
							if arg_269_1.isInRecall_ then
								iter_272_7.color = Color.New(Mathf.Lerp(iter_272_7.color.r, arg_269_1.hightColor1.r, (arg_269_1.time_ - 0) / var_272_9), Mathf.Lerp(iter_272_7.color.g, arg_269_1.hightColor1.g, (arg_269_1.time_ - 0) / var_272_9), (Mathf.Lerp(iter_272_7.color.b, arg_269_1.hightColor1.b, (arg_269_1.time_ - 0) / var_272_9)))
							else
								local var_272_10 = Mathf.Lerp(iter_272_7.color.r, 1, (arg_269_1.time_ - 0) / var_272_9)

								iter_272_7.color = Color.New(var_272_10, var_272_10, var_272_10)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_9 and arg_269_1.time_ < 0 + var_272_9 + arg_272_0 and not isNil(var_272_8) and arg_269_1.var_.actorSpriteComps10148 then
				for iter_272_8, iter_272_9 in pairs(arg_269_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_272_9 then
						iter_272_9.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_269_1.var_.actorSpriteComps10148 = nil
			end

			local var_272_11 = manager.ui.mainCamera.transform

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.shakeOldPos = var_272_11.localPosition
			end

			local var_272_12 = 0.6

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_12 then
				local var_272_13, var_272_14 = math.modf((arg_269_1.time_ - 0) / 0.066)

				var_272_11.localPosition = Vector3.New(var_272_14 * 0.02, var_272_14 * 0.02, var_272_14 * 0.02) + arg_269_1.var_.shakeOldPos
			end

			if arg_269_1.time_ >= 0 + var_272_12 and arg_269_1.time_ < 0 + var_272_12 + arg_272_0 then
				var_272_11.localPosition = arg_269_1.var_.shakeOldPos
			end

			local var_272_15 = 0
			local var_272_16 = 0.125

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_15 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[1347].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_17 = arg_269_1:GetWordFromCfg(423101063)
				local var_272_18 = arg_269_1:FormatText(var_272_17.content)

				arg_269_1.text_.text = var_272_18

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_20 = 5 <= 0 and var_272_16 or var_272_16 * (utf8.len(var_272_18) / 5)

				if (5 <= 0 and var_272_16 or var_272_16 * (utf8.len(var_272_18) / 5)) > 0 and var_272_16 < var_272_20 then
					arg_269_1.talkMaxDuration = var_272_20

					if var_272_20 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_20 + var_272_15
					end
				end

				arg_269_1.text_.text = var_272_18
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101063", "story_v_out_423101.awb") ~= 0 then
					local var_272_21 = manager.audio:GetVoiceLength("story_v_out_423101", "423101063", "story_v_out_423101.awb") / 1000

					if var_272_21 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_21 + var_272_15
					end

					if var_272_17.prefab_name ~= "" and arg_269_1.actors_[var_272_17.prefab_name] ~= nil then
						local var_272_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_17.prefab_name].transform, "story_v_out_423101", "423101063", "story_v_out_423101.awb")

						arg_269_1:RecordAudio("423101063", var_272_22)
						arg_269_1:RecordAudio("423101063", var_272_22)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_423101", "423101063", "story_v_out_423101.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_423101", "423101063", "story_v_out_423101.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_23 = math.max(var_272_16, arg_269_1.talkMaxDuration)

			if var_272_15 <= arg_269_1.time_ and arg_269_1.time_ < var_272_15 + var_272_23 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_15) / var_272_23

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_15 + var_272_23 and arg_269_1.time_ < var_272_15 + var_272_23 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_269_1:InitPlayNodeList()
	end,
	Play423101064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 423101064
		arg_273_1.duration_ = 11.47

		local var_273_0 = {
			zh = 5.833,
			ja = 11.466
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play423101065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10148 = arg_273_1.actors_["10148"].transform.localPosition
				arg_273_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("10148", 4)

				for iter_276_0 = 0, arg_273_1.actors_["10148"].transform.childCount - 1 do
					local var_276_0 = arg_273_1.actors_["10148"].transform:GetChild(iter_276_0)

					if var_276_0.name == "split_3" or not string.find(var_276_0.name, "split") then
						var_276_0.gameObject:SetActive(true)
					else
						var_276_0.gameObject:SetActive(false)
					end
				end
			end

			local var_276_1 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_1 then
				arg_273_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10148, Vector3.New(390, -350, -270), (arg_273_1.time_ - 0) / var_276_1)
			end

			if arg_273_1.time_ >= 0 + var_276_1 and arg_273_1.time_ < 0 + var_276_1 + arg_276_0 then
				arg_273_1.actors_["10148"].transform.localPosition = Vector3.New(390, -350, -270)
			end

			local var_276_2 = arg_273_1.actors_["1083"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps1083 == nil then
				arg_273_1.var_.actorSpriteComps1083 = var_276_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_3 = 0.2

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_3 and not isNil(var_276_2) then
				if arg_273_1.var_.actorSpriteComps1083 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_276_2 then
							if arg_273_1.isInRecall_ then
								iter_276_2.color = Color.New(Mathf.Lerp(iter_276_2.color.r, arg_273_1.hightColor2.r, (arg_273_1.time_ - 0) / var_276_3), Mathf.Lerp(iter_276_2.color.g, arg_273_1.hightColor2.g, (arg_273_1.time_ - 0) / var_276_3), (Mathf.Lerp(iter_276_2.color.b, arg_273_1.hightColor2.b, (arg_273_1.time_ - 0) / var_276_3)))
							else
								local var_276_4 = Mathf.Lerp(iter_276_2.color.r, 0.5, (arg_273_1.time_ - 0) / var_276_3)

								iter_276_2.color = Color.New(var_276_4, var_276_4, var_276_4)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= 0 + var_276_3 and arg_273_1.time_ < 0 + var_276_3 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps1083 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_276_4 then
						iter_276_4.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_273_1.var_.actorSpriteComps1083 = nil
			end

			if 0.166666666666667 < arg_273_1.time_ and arg_273_1.time_ <= 0.166666666666667 + arg_276_0 then
				arg_273_1:AudioAction("play", "effect", "se_story_144", "se_story_144_clap", "")
			end

			local var_276_6 = 0
			local var_276_7 = 0.675

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[1331].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_8 = arg_273_1:GetWordFromCfg(423101064)
				local var_276_9 = arg_273_1:FormatText(var_276_8.content)

				arg_273_1.text_.text = var_276_9

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 27 <= 0 and var_276_7 or var_276_7 * (utf8.len(var_276_9) / 27)

				if (27 <= 0 and var_276_7 or var_276_7 * (utf8.len(var_276_9) / 27)) > 0 and var_276_7 < var_276_11 then
					arg_273_1.talkMaxDuration = var_276_11

					if var_276_11 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_11 + var_276_6
					end
				end

				arg_273_1.text_.text = var_276_9
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101064", "story_v_out_423101.awb") ~= 0 then
					local var_276_12 = manager.audio:GetVoiceLength("story_v_out_423101", "423101064", "story_v_out_423101.awb") / 1000

					if var_276_12 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_12 + var_276_6
					end

					if var_276_8.prefab_name ~= "" and arg_273_1.actors_[var_276_8.prefab_name] ~= nil then
						local var_276_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_8.prefab_name].transform, "story_v_out_423101", "423101064", "story_v_out_423101.awb")

						arg_273_1:RecordAudio("423101064", var_276_13)
						arg_273_1:RecordAudio("423101064", var_276_13)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_423101", "423101064", "story_v_out_423101.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_423101", "423101064", "story_v_out_423101.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_14 = math.max(var_276_7, arg_273_1.talkMaxDuration)

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_14 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_6) / var_276_14

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_6 + var_276_14 and arg_273_1.time_ < var_276_6 + var_276_14 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play423101065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 423101065
		arg_277_1.duration_ = 7.97

		local var_277_0 = {
			zh = 6.533,
			ja = 7.966
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
				arg_277_0:Play423101066(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["10148"]) and arg_277_1.var_.actorSpriteComps10148 == nil then
				arg_277_1.var_.actorSpriteComps10148 = arg_277_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_0 = 0.2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["10148"]) then
				if arg_277_1.var_.actorSpriteComps10148 then
					for iter_280_0, iter_280_1 in pairs(arg_277_1.var_.actorSpriteComps10148:ToTable()) do
						if iter_280_1 then
							if arg_277_1.isInRecall_ then
								iter_280_1.color = Color.New(Mathf.Lerp(iter_280_1.color.r, arg_277_1.hightColor2.r, (arg_277_1.time_ - 0) / var_280_0), Mathf.Lerp(iter_280_1.color.g, arg_277_1.hightColor2.g, (arg_277_1.time_ - 0) / var_280_0), (Mathf.Lerp(iter_280_1.color.b, arg_277_1.hightColor2.b, (arg_277_1.time_ - 0) / var_280_0)))
							else
								local var_280_1 = Mathf.Lerp(iter_280_1.color.r, 0.5, (arg_277_1.time_ - 0) / var_280_0)

								iter_280_1.color = Color.New(var_280_1, var_280_1, var_280_1)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["10148"]) and arg_277_1.var_.actorSpriteComps10148 then
				for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_280_3 then
						iter_280_3.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_277_1.var_.actorSpriteComps10148 = nil
			end

			local var_280_2 = 0
			local var_280_3 = 0.95

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_2 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[1327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_4 = arg_277_1:GetWordFromCfg(423101065)
				local var_280_5 = arg_277_1:FormatText(var_280_4.content)

				arg_277_1.text_.text = var_280_5

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_7 = 38 <= 0 and var_280_3 or var_280_3 * (utf8.len(var_280_5) / 38)

				if (38 <= 0 and var_280_3 or var_280_3 * (utf8.len(var_280_5) / 38)) > 0 and var_280_3 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_2
					end
				end

				arg_277_1.text_.text = var_280_5
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101065", "story_v_out_423101.awb") ~= 0 then
					local var_280_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101065", "story_v_out_423101.awb") / 1000

					if var_280_8 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_2
					end

					if var_280_4.prefab_name ~= "" and arg_277_1.actors_[var_280_4.prefab_name] ~= nil then
						local var_280_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_4.prefab_name].transform, "story_v_out_423101", "423101065", "story_v_out_423101.awb")

						arg_277_1:RecordAudio("423101065", var_280_9)
						arg_277_1:RecordAudio("423101065", var_280_9)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_423101", "423101065", "story_v_out_423101.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_423101", "423101065", "story_v_out_423101.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_10 = math.max(var_280_3, arg_277_1.talkMaxDuration)

			if var_280_2 <= arg_277_1.time_ and arg_277_1.time_ < var_280_2 + var_280_10 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_2) / var_280_10

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_2 + var_280_10 and arg_277_1.time_ < var_280_2 + var_280_10 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play423101066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 423101066
		arg_281_1.duration_ = 7.07

		local var_281_0 = {
			zh = 5.433,
			ja = 7.066
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play423101067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["10148"]) and arg_281_1.var_.actorSpriteComps10148 == nil then
				arg_281_1.var_.actorSpriteComps10148 = arg_281_1.actors_["10148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_0 = 0.2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["10148"]) then
				if arg_281_1.var_.actorSpriteComps10148 then
					for iter_284_0, iter_284_1 in pairs(arg_281_1.var_.actorSpriteComps10148:ToTable()) do
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

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["10148"]) and arg_281_1.var_.actorSpriteComps10148 then
				for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps10148:ToTable()) do
					if iter_284_3 then
						iter_284_3.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_281_1.var_.actorSpriteComps10148 = nil
			end

			local var_284_2 = 0
			local var_284_3 = 0.725

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[1327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_officeladyb")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_4 = arg_281_1:GetWordFromCfg(423101066)
				local var_284_5 = arg_281_1:FormatText(var_284_4.content)

				arg_281_1.text_.text = var_284_5

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_7 = 29 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_5) / 29)

				if (29 <= 0 and var_284_3 or var_284_3 * (utf8.len(var_284_5) / 29)) > 0 and var_284_3 < var_284_7 then
					arg_281_1.talkMaxDuration = var_284_7

					if var_284_7 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_7 + var_284_2
					end
				end

				arg_281_1.text_.text = var_284_5
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101066", "story_v_out_423101.awb") ~= 0 then
					local var_284_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101066", "story_v_out_423101.awb") / 1000

					if var_284_8 + var_284_2 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_2
					end

					if var_284_4.prefab_name ~= "" and arg_281_1.actors_[var_284_4.prefab_name] ~= nil then
						local var_284_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_4.prefab_name].transform, "story_v_out_423101", "423101066", "story_v_out_423101.awb")

						arg_281_1:RecordAudio("423101066", var_284_9)
						arg_281_1:RecordAudio("423101066", var_284_9)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_423101", "423101066", "story_v_out_423101.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_423101", "423101066", "story_v_out_423101.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_10 = math.max(var_284_3, arg_281_1.talkMaxDuration)

			if var_284_2 <= arg_281_1.time_ and arg_281_1.time_ < var_284_2 + var_284_10 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_2) / var_284_10

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_2 + var_284_10 and arg_281_1.time_ < var_284_2 + var_284_10 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play423101067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 423101067
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play423101068(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos10148 = arg_285_1.actors_["10148"].transform.localPosition
				arg_285_1.actors_["10148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("10148", 7)

				for iter_288_0 = 0, arg_285_1.actors_["10148"].transform.childCount - 1 do
					local var_288_0 = arg_285_1.actors_["10148"].transform:GetChild(iter_288_0)

					if var_288_0.name == "" or not string.find(var_288_0.name, "split") then
						var_288_0.gameObject:SetActive(true)
					else
						var_288_0.gameObject:SetActive(false)
					end
				end
			end

			local var_288_1 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_1 then
				arg_285_1.actors_["10148"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10148, Vector3.New(0, -2000, 0), (arg_285_1.time_ - 0) / var_288_1)
			end

			if arg_285_1.time_ >= 0 + var_288_1 and arg_285_1.time_ < 0 + var_288_1 + arg_288_0 then
				arg_285_1.actors_["10148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_288_2 = arg_285_1.actors_["1083"].transform

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos1083 = var_288_2.localPosition
				var_288_2.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("1083", 7)

				for iter_288_1 = 0, var_288_2.childCount - 1 do
					local var_288_3 = var_288_2:GetChild(iter_288_1)

					if var_288_3.name == "" or not string.find(var_288_3.name, "split") then
						var_288_3.gameObject:SetActive(true)
					else
						var_288_3.gameObject:SetActive(false)
					end
				end
			end

			local var_288_4 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				var_288_2.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_285_1.time_ - 0) / var_288_4)
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				var_288_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_288_5 = 0
			local var_288_6 = 1.625

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_7 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(423101067).content)

				arg_285_1.text_.text = var_288_7

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_9 = 65 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_7) / 65)

				if (65 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_7) / 65)) > 0 and var_288_6 < var_288_9 then
					arg_285_1.talkMaxDuration = var_288_9

					if var_288_9 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_9 + var_288_5
					end
				end

				arg_285_1.text_.text = var_288_7
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_10 = math.max(var_288_6, arg_285_1.talkMaxDuration)

			if var_288_5 <= arg_285_1.time_ and arg_285_1.time_ < var_288_5 + var_288_10 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_5) / var_288_10

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_5 + var_288_10 and arg_285_1.time_ < var_288_5 + var_288_10 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1083",
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
	Play423101068 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 423101068
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play423101069(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.575

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(423101068).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 23 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 23)

				if (23 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 23)) > 0 and var_292_0 < var_292_3 then
					arg_289_1.talkMaxDuration = var_292_3

					if var_292_3 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_3 + 0
					end
				end

				arg_289_1.text_.text = var_292_1
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_4 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_4

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play423101069 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 423101069
		arg_293_1.duration_ = 2.57

		local var_293_0 = {
			zh = 1.7,
			ja = 2.566
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play423101070(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1083"]) and arg_293_1.var_.actorSpriteComps1083 == nil then
				arg_293_1.var_.actorSpriteComps1083 = arg_293_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_0 = 0.2

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1083"]) then
				if arg_293_1.var_.actorSpriteComps1083 then
					for iter_296_0, iter_296_1 in pairs(arg_293_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_296_1 then
							if arg_293_1.isInRecall_ then
								iter_296_1.color = Color.New(Mathf.Lerp(iter_296_1.color.r, arg_293_1.hightColor1.r, (arg_293_1.time_ - 0) / var_296_0), Mathf.Lerp(iter_296_1.color.g, arg_293_1.hightColor1.g, (arg_293_1.time_ - 0) / var_296_0), (Mathf.Lerp(iter_296_1.color.b, arg_293_1.hightColor1.b, (arg_293_1.time_ - 0) / var_296_0)))
							else
								local var_296_1 = Mathf.Lerp(iter_296_1.color.r, 1, (arg_293_1.time_ - 0) / var_296_0)

								iter_296_1.color = Color.New(var_296_1, var_296_1, var_296_1)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1083"]) and arg_293_1.var_.actorSpriteComps1083 then
				for iter_296_2, iter_296_3 in pairs(arg_293_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_296_3 then
						iter_296_3.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_293_1.var_.actorSpriteComps1083 = nil
			end

			local var_296_2 = arg_293_1.actors_["1083"].transform

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.var_.moveOldPos1083 = var_296_2.localPosition
				var_296_2.localScale = Vector3.New(1, 1, 1)

				arg_293_1:CheckSpriteTmpPos("1083", 3)

				for iter_296_4 = 0, var_296_2.childCount - 1 do
					local var_296_3 = var_296_2:GetChild(iter_296_4)

					if var_296_3.name == "split_7" or not string.find(var_296_3.name, "split") then
						var_296_3.gameObject:SetActive(true)
					else
						var_296_3.gameObject:SetActive(false)
					end
				end
			end

			local var_296_4 = 0.001

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				var_296_2.localPosition = Vector3.Lerp(arg_293_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_293_1.time_ - 0) / var_296_4)
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				var_296_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_296_5 = 0
			local var_296_6 = 0.25

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_5 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_7 = arg_293_1:GetWordFromCfg(423101069)
				local var_296_8 = arg_293_1:FormatText(var_296_7.content)

				arg_293_1.text_.text = var_296_8

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_10 = 10 <= 0 and var_296_6 or var_296_6 * (utf8.len(var_296_8) / 10)

				if (10 <= 0 and var_296_6 or var_296_6 * (utf8.len(var_296_8) / 10)) > 0 and var_296_6 < var_296_10 then
					arg_293_1.talkMaxDuration = var_296_10

					if var_296_10 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_5
					end
				end

				arg_293_1.text_.text = var_296_8
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101069", "story_v_out_423101.awb") ~= 0 then
					local var_296_11 = manager.audio:GetVoiceLength("story_v_out_423101", "423101069", "story_v_out_423101.awb") / 1000

					if var_296_11 + var_296_5 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_11 + var_296_5
					end

					if var_296_7.prefab_name ~= "" and arg_293_1.actors_[var_296_7.prefab_name] ~= nil then
						local var_296_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_7.prefab_name].transform, "story_v_out_423101", "423101069", "story_v_out_423101.awb")

						arg_293_1:RecordAudio("423101069", var_296_12)
						arg_293_1:RecordAudio("423101069", var_296_12)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_423101", "423101069", "story_v_out_423101.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_423101", "423101069", "story_v_out_423101.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_13 = math.max(var_296_6, arg_293_1.talkMaxDuration)

			if var_296_5 <= arg_293_1.time_ and arg_293_1.time_ < var_296_5 + var_296_13 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_5) / var_296_13

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_5 + var_296_13 and arg_293_1.time_ < var_296_5 + var_296_13 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_293_1:InitPlayNodeList()
	end,
	Play423101070 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 423101070
		arg_297_1.duration_ = 3.93

		local var_297_0 = {
			zh = 3.933,
			ja = 3.7
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play423101071(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.var_.moveOldPos1083 = arg_297_1.actors_["1083"].transform.localPosition
				arg_297_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_297_1:CheckSpriteTmpPos("1083", 3)

				for iter_300_0 = 0, arg_297_1.actors_["1083"].transform.childCount - 1 do
					local var_300_0 = arg_297_1.actors_["1083"].transform:GetChild(iter_300_0)

					if var_300_0.name == "split_7" or not string.find(var_300_0.name, "split") then
						var_300_0.gameObject:SetActive(true)
					else
						var_300_0.gameObject:SetActive(false)
					end
				end
			end

			local var_300_1 = 0.001

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_1 then
				arg_297_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_297_1.time_ - 0) / var_300_1)
			end

			if arg_297_1.time_ >= 0 + var_300_1 and arg_297_1.time_ < 0 + var_300_1 + arg_300_0 then
				arg_297_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_300_2 = 0
			local var_300_3 = 0.475

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_4 = arg_297_1:GetWordFromCfg(423101070)
				local var_300_5 = arg_297_1:FormatText(var_300_4.content)

				arg_297_1.text_.text = var_300_5

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_7 = 19 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 19)

				if (19 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 19)) > 0 and var_300_3 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_2
					end
				end

				arg_297_1.text_.text = var_300_5
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101070", "story_v_out_423101.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101070", "story_v_out_423101.awb") / 1000

					if var_300_8 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_2
					end

					if var_300_4.prefab_name ~= "" and arg_297_1.actors_[var_300_4.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_4.prefab_name].transform, "story_v_out_423101", "423101070", "story_v_out_423101.awb")

						arg_297_1:RecordAudio("423101070", var_300_9)
						arg_297_1:RecordAudio("423101070", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_423101", "423101070", "story_v_out_423101.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_423101", "423101070", "story_v_out_423101.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_10 = math.max(var_300_3, arg_297_1.talkMaxDuration)

			if var_300_2 <= arg_297_1.time_ and arg_297_1.time_ < var_300_2 + var_300_10 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_2) / var_300_10

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_2 + var_300_10 and arg_297_1.time_ < var_300_2 + var_300_10 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play423101071 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 423101071
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play423101072(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1083"]) and arg_301_1.var_.actorSpriteComps1083 == nil then
				arg_301_1.var_.actorSpriteComps1083 = arg_301_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_0 = 0.2

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1083"]) then
				if arg_301_1.var_.actorSpriteComps1083 then
					for iter_304_0, iter_304_1 in pairs(arg_301_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_304_1 then
							if arg_301_1.isInRecall_ then
								iter_304_1.color = Color.New(Mathf.Lerp(iter_304_1.color.r, arg_301_1.hightColor2.r, (arg_301_1.time_ - 0) / var_304_0), Mathf.Lerp(iter_304_1.color.g, arg_301_1.hightColor2.g, (arg_301_1.time_ - 0) / var_304_0), (Mathf.Lerp(iter_304_1.color.b, arg_301_1.hightColor2.b, (arg_301_1.time_ - 0) / var_304_0)))
							else
								local var_304_1 = Mathf.Lerp(iter_304_1.color.r, 0.5, (arg_301_1.time_ - 0) / var_304_0)

								iter_304_1.color = Color.New(var_304_1, var_304_1, var_304_1)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1083"]) and arg_301_1.var_.actorSpriteComps1083 then
				for iter_304_2, iter_304_3 in pairs(arg_301_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_304_3 then
						iter_304_3.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_301_1.var_.actorSpriteComps1083 = nil
			end

			local var_304_2 = arg_301_1.actors_["1083"].transform

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1.var_.moveOldPos1083 = var_304_2.localPosition
				var_304_2.localScale = Vector3.New(1, 1, 1)

				arg_301_1:CheckSpriteTmpPos("1083", 7)

				for iter_304_4 = 0, var_304_2.childCount - 1 do
					local var_304_3 = var_304_2:GetChild(iter_304_4)

					if var_304_3.name == "" or not string.find(var_304_3.name, "split") then
						var_304_3.gameObject:SetActive(true)
					else
						var_304_3.gameObject:SetActive(false)
					end
				end
			end

			local var_304_4 = 0.001

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_4 then
				var_304_2.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_301_1.time_ - 0) / var_304_4)
			end

			if arg_301_1.time_ >= 0 + var_304_4 and arg_301_1.time_ < 0 + var_304_4 + arg_304_0 then
				var_304_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.466666666666667 < arg_301_1.time_ and arg_301_1.time_ <= 0.466666666666667 + arg_304_0 then
				arg_301_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_motorcycle03", "")
			end

			local var_304_6 = 0
			local var_304_7 = 1.775

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_6 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, false)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_8 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(423101071).content)

				arg_301_1.text_.text = var_304_8

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_10 = 71 <= 0 and var_304_7 or var_304_7 * (utf8.len(var_304_8) / 71)

				if (71 <= 0 and var_304_7 or var_304_7 * (utf8.len(var_304_8) / 71)) > 0 and var_304_7 < var_304_10 then
					arg_301_1.talkMaxDuration = var_304_10

					if var_304_10 + var_304_6 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_6
					end
				end

				arg_301_1.text_.text = var_304_8
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_11 = math.max(var_304_7, arg_301_1.talkMaxDuration)

			if var_304_6 <= arg_301_1.time_ and arg_301_1.time_ < var_304_6 + var_304_11 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_6) / var_304_11

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_6 + var_304_11 and arg_301_1.time_ < var_304_6 + var_304_11 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_301_1:InitPlayNodeList()
	end,
	Play423101072 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 423101072
		arg_305_1.duration_ = 8.1

		local var_305_0 = {
			zh = 5.932999999999,
			ja = 8.099999999999
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
				arg_305_0:Play423101073(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_9000

			if arg_305_1.bgs_.ST0113 == nil then
				local var_308_0 = Object.Instantiate(arg_305_1.paintGo_)

				var_308_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0113")
				var_308_0.name = "ST0113"
				var_308_0.transform.parent = arg_305_1.stage_.transform
				var_308_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_305_1.bgs_.ST0113 = var_308_0
			end

			if 2 < arg_305_1.time_ and arg_305_1.time_ <= 2 + arg_308_0 then
				local var_308_1 = arg_305_1.bgs_.ST0113

				arg_305_1.bgs_.ST0113.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_308_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_308_2 = var_308_1:GetComponent("SpriteRenderer")

				if var_308_2 and var_308_2.sprite then
					local var_308_3 = 2 * (var_308_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_308_1.transform.localScale = Vector3.New(var_308_3 / var_308_2.sprite.bounds.size.y < var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x and var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x or var_308_3 / var_308_2.sprite.bounds.size.y, var_308_3 / var_308_2.sprite.bounds.size.y < var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x and var_308_3 * manager.ui.mainCameraCom_.aspect / var_308_2.sprite.bounds.size.x or var_308_3 / var_308_2.sprite.bounds.size.y, 0)
				end

				for iter_308_0, iter_308_1 in pairs(arg_305_1.bgs_) do
					if iter_308_0 ~= "ST0113" then
						iter_308_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_308_4 = 3.999999999999

			if 3.999999999999 < arg_305_1.time_ and arg_305_1.time_ <= var_308_4 + arg_308_0 then
				arg_305_1.allBtn_.enabled = false
			end

			if arg_305_1.time_ >= var_308_4 + 0.3 and arg_305_1.time_ < var_308_4 + 0.3 + arg_308_0 then
				arg_305_1.allBtn_.enabled = true
			end

			local var_308_5 = 0

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_5 + arg_308_0 then
				arg_305_1.mask_.enabled = true
				arg_305_1.mask_.raycastTarget = true

				arg_305_1:SetGaussion(false)
			end

			local var_308_6 = 2

			if var_308_5 <= arg_305_1.time_ and arg_305_1.time_ < var_308_5 + var_308_6 then
				local var_308_7 = Color.New(0, 0, 0)

				var_308_7.a = Mathf.Lerp(0, 1, (arg_305_1.time_ - var_308_5) / var_308_6)
				arg_305_1.mask_.color = var_308_7
			end

			if arg_305_1.time_ >= var_308_5 + var_308_6 and arg_305_1.time_ < var_308_5 + var_308_6 + arg_308_0 then
				local var_308_8 = Color.New(0, 0, 0)

				var_308_8.a = 1
				arg_305_1.mask_.color = var_308_8
			end

			local var_308_9 = 2

			if 2 < arg_305_1.time_ and arg_305_1.time_ <= var_308_9 + arg_308_0 then
				arg_305_1.mask_.enabled = true
				arg_305_1.mask_.raycastTarget = true

				arg_305_1:SetGaussion(false)
			end

			local var_308_10 = 2

			if var_308_9 <= arg_305_1.time_ and arg_305_1.time_ < var_308_9 + var_308_10 then
				local var_308_11 = Color.New(0, 0, 0)

				var_308_11.a = Mathf.Lerp(1, 0, (arg_305_1.time_ - var_308_9) / var_308_10)
				arg_305_1.mask_.color = var_308_11
			end

			if arg_305_1.time_ >= var_308_9 + var_308_10 and arg_305_1.time_ < var_308_9 + var_308_10 + arg_308_0 then
				local var_308_12 = Color.New(0, 0, 0)

				arg_305_1.mask_.enabled = false
				var_308_12.a = 0
				arg_305_1.mask_.color = var_308_12
			end

			local var_308_13 = arg_305_1.actors_["1083"]

			if 3.8 < arg_305_1.time_ and arg_305_1.time_ <= 3.8 + arg_308_0 and not isNil(var_308_13) and arg_305_1.var_.actorSpriteComps1083 == nil then
				arg_305_1.var_.actorSpriteComps1083 = var_308_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_14 = 0.2

			if 3.8 <= arg_305_1.time_ and arg_305_1.time_ < 3.8 + var_308_14 and not isNil(var_308_13) then
				if arg_305_1.var_.actorSpriteComps1083 then
					for iter_308_2, iter_308_3 in pairs(arg_305_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_308_3 then
							if arg_305_1.isInRecall_ then
								iter_308_3.color = Color.New(Mathf.Lerp(iter_308_3.color.r, arg_305_1.hightColor1.r, (arg_305_1.time_ - 3.8) / var_308_14), Mathf.Lerp(iter_308_3.color.g, arg_305_1.hightColor1.g, (arg_305_1.time_ - 3.8) / var_308_14), (Mathf.Lerp(iter_308_3.color.b, arg_305_1.hightColor1.b, (arg_305_1.time_ - 3.8) / var_308_14)))
							else
								local var_308_15 = Mathf.Lerp(iter_308_3.color.r, 1, (arg_305_1.time_ - 3.8) / var_308_14)

								iter_308_3.color = Color.New(var_308_15, var_308_15, var_308_15)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= 3.8 + var_308_14 and arg_305_1.time_ < 3.8 + var_308_14 + arg_308_0 and not isNil(var_308_13) and arg_305_1.var_.actorSpriteComps1083 then
				for iter_308_4, iter_308_5 in pairs(arg_305_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_308_5 then
						iter_308_5.color = arg_305_1.isInRecall_ and (arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_305_1.var_.actorSpriteComps1083 = nil
			end

			local var_308_16 = arg_305_1.actors_["1083"].transform

			if 3.8 < arg_305_1.time_ and arg_305_1.time_ <= 3.8 + arg_308_0 then
				arg_305_1.var_.moveOldPos1083 = var_308_16.localPosition
				var_308_16.localScale = Vector3.New(1, 1, 1)

				arg_305_1:CheckSpriteTmpPos("1083", 3)

				for iter_308_6 = 0, var_308_16.childCount - 1 do
					local var_308_17 = var_308_16:GetChild(iter_308_6)

					if var_308_17.name == "split_7" or not string.find(var_308_17.name, "split") then
						var_308_17.gameObject:SetActive(true)
					else
						var_308_17.gameObject:SetActive(false)
					end
				end
			end

			local var_308_18 = 0.001

			if 3.8 <= arg_305_1.time_ and arg_305_1.time_ < 3.8 + var_308_18 then
				var_308_16.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_305_1.time_ - 3.8) / var_308_18)
			end

			if arg_305_1.time_ >= 3.8 + var_308_18 and arg_305_1.time_ < 3.8 + var_308_18 + arg_308_0 then
				var_308_16.localPosition = Vector3.New(-50, -345, -345)
			end

			if 2 < arg_305_1.time_ and arg_305_1.time_ <= 2 + arg_308_0 then
				local var_308_19 = arg_305_1.var_.effectaishimoturoche1

				if not arg_305_1.var_.effectaishimoturoche1 then
					var_308_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), manager.ui.mainCamera.transform)
					var_308_19.name = "aishimoturoche1"
					arg_305_1.var_.effectaishimoturoche1 = var_308_19
				else
					var_308_19.transform:SetParent(var_308_9000)
				end

				var_308_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_308_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.8 < arg_305_1.time_ and arg_305_1.time_ <= 3.8 + arg_308_0 then
				local var_308_21 = arg_305_1.actors_["1083"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_308_21 then
					arg_305_1.var_.alphaOldValue1083 = var_308_21.alpha
					arg_305_1.var_.characterEffect1083 = var_308_21
				end

				arg_305_1.var_.alphaOldValue1083 = 0
			end

			local var_308_22 = 0.5

			if 3.8 <= arg_305_1.time_ and arg_305_1.time_ < 3.8 + var_308_22 then
				if arg_305_1.var_.characterEffect1083 then
					arg_305_1.var_.characterEffect1083.alpha = Mathf.Lerp(arg_305_1.var_.alphaOldValue1083, 1, (arg_305_1.time_ - 3.8) / var_308_22)
				end
			end

			if arg_305_1.time_ >= 3.8 + var_308_22 and arg_305_1.time_ < 3.8 + var_308_22 + arg_308_0 and arg_305_1.var_.characterEffect1083 then
				arg_305_1.var_.characterEffect1083.alpha = 1
			end

			if 0.166666666666667 < arg_305_1.time_ and arg_305_1.time_ <= 0.166666666666667 + arg_308_0 then
				arg_305_1:AudioAction("stop", "effect", "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			if 1.53333333333333 < arg_305_1.time_ and arg_305_1.time_ <= 1.53333333333333 + arg_308_0 then
				arg_305_1:AudioAction("play", "effect", "se_story_side_1028", "se_story_side_1028_storm_loop", "")
			end

			if 0.166666666666667 < arg_305_1.time_ and arg_305_1.time_ <= 0.166666666666667 + arg_308_0 then
				arg_305_1:AudioAction("stop", "effect", "se_story_side_1022", "se_story_side_1022_crowd", "")
			end

			if arg_305_1.frameCnt_ <= 1 then
				arg_305_1.dialog_:SetActive(false)
			end

			local var_308_26 = 3.999999999999
			local var_308_27 = 0.225

			if 3.999999999999 < arg_305_1.time_ and arg_305_1.time_ <= var_308_26 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0

				arg_305_1.dialog_:SetActive(true)

				arg_305_1.dialogCg_.alpha = 0

				local var_308_28 = LeanTween.value(arg_305_1.dialog_, 0, 1, 0.3)

				var_308_28:setOnUpdate(LuaHelper.FloatAction(function(arg_309_0)
					arg_305_1.dialogCg_.alpha = arg_309_0
				end))
				var_308_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_305_1.dialog_)
					var_308_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_305_1.duration_ = arg_305_1.duration_ + 0.3

				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_29 = arg_305_1:GetWordFromCfg(423101072)
				local var_308_30 = arg_305_1:FormatText(var_308_29.content)

				arg_305_1.text_.text = var_308_30

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_32 = 9 <= 0 and var_308_27 or var_308_27 * (utf8.len(var_308_30) / 9)

				if (9 <= 0 and var_308_27 or var_308_27 * (utf8.len(var_308_30) / 9)) > 0 and var_308_27 < var_308_32 then
					arg_305_1.talkMaxDuration = var_308_32
					var_308_26 = var_308_26 + 0.3

					if var_308_32 + var_308_26 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_32 + var_308_26
					end
				end

				arg_305_1.text_.text = var_308_30
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101072", "story_v_out_423101.awb") ~= 0 then
					local var_308_33 = manager.audio:GetVoiceLength("story_v_out_423101", "423101072", "story_v_out_423101.awb") / 1000

					if var_308_33 + var_308_26 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_33 + var_308_26
					end

					if var_308_29.prefab_name ~= "" and arg_305_1.actors_[var_308_29.prefab_name] ~= nil then
						local var_308_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_29.prefab_name].transform, "story_v_out_423101", "423101072", "story_v_out_423101.awb")

						arg_305_1:RecordAudio("423101072", var_308_34)
						arg_305_1:RecordAudio("423101072", var_308_34)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_423101", "423101072", "story_v_out_423101.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_423101", "423101072", "story_v_out_423101.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_35 = var_308_26 + 0.3
			local var_308_36 = math.max(var_308_27, arg_305_1.talkMaxDuration)

			if var_308_26 + 0.3 <= arg_305_1.time_ and arg_305_1.time_ < var_308_35 + var_308_36 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_35) / var_308_36

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_35 + var_308_36 and arg_305_1.time_ < var_308_35 + var_308_36 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_305_1:InitPlayNodeList()
	end,
	Play423101073 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 423101073
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play423101074(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["1083"]) and arg_311_1.var_.actorSpriteComps1083 == nil then
				arg_311_1.var_.actorSpriteComps1083 = arg_311_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_0 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["1083"]) then
				if arg_311_1.var_.actorSpriteComps1083 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_314_1 then
							if arg_311_1.isInRecall_ then
								iter_314_1.color = Color.New(Mathf.Lerp(iter_314_1.color.r, arg_311_1.hightColor2.r, (arg_311_1.time_ - 0) / var_314_0), Mathf.Lerp(iter_314_1.color.g, arg_311_1.hightColor2.g, (arg_311_1.time_ - 0) / var_314_0), (Mathf.Lerp(iter_314_1.color.b, arg_311_1.hightColor2.b, (arg_311_1.time_ - 0) / var_314_0)))
							else
								local var_314_1 = Mathf.Lerp(iter_314_1.color.r, 0.5, (arg_311_1.time_ - 0) / var_314_0)

								iter_314_1.color = Color.New(var_314_1, var_314_1, var_314_1)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["1083"]) and arg_311_1.var_.actorSpriteComps1083 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_314_3 then
						iter_314_3.color = arg_311_1.isInRecall_ and (arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_311_1.var_.actorSpriteComps1083 = nil
			end

			local var_314_2 = 0
			local var_314_3 = 0.65

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_2 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, true)
				arg_311_1.iconController_:SetSelectedState("hero")

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_4 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(423101073).content)

				arg_311_1.text_.text = var_314_4

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_6 = 26 <= 0 and var_314_3 or var_314_3 * (utf8.len(var_314_4) / 26)

				if (26 <= 0 and var_314_3 or var_314_3 * (utf8.len(var_314_4) / 26)) > 0 and var_314_3 < var_314_6 then
					arg_311_1.talkMaxDuration = var_314_6

					if var_314_6 + var_314_2 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_6 + var_314_2
					end
				end

				arg_311_1.text_.text = var_314_4
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_3, arg_311_1.talkMaxDuration)

			if var_314_2 <= arg_311_1.time_ and arg_311_1.time_ < var_314_2 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_2) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_2 + var_314_7 and arg_311_1.time_ < var_314_2 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play423101074 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 423101074
		arg_315_1.duration_ = 4.6

		local var_315_0 = {
			zh = 2.8,
			ja = 4.6
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play423101075(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1083"]) and arg_315_1.var_.actorSpriteComps1083 == nil then
				arg_315_1.var_.actorSpriteComps1083 = arg_315_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_0 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1083"]) then
				if arg_315_1.var_.actorSpriteComps1083 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_318_1 then
							if arg_315_1.isInRecall_ then
								iter_318_1.color = Color.New(Mathf.Lerp(iter_318_1.color.r, arg_315_1.hightColor1.r, (arg_315_1.time_ - 0) / var_318_0), Mathf.Lerp(iter_318_1.color.g, arg_315_1.hightColor1.g, (arg_315_1.time_ - 0) / var_318_0), (Mathf.Lerp(iter_318_1.color.b, arg_315_1.hightColor1.b, (arg_315_1.time_ - 0) / var_318_0)))
							else
								local var_318_1 = Mathf.Lerp(iter_318_1.color.r, 1, (arg_315_1.time_ - 0) / var_318_0)

								iter_318_1.color = Color.New(var_318_1, var_318_1, var_318_1)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1083"]) and arg_315_1.var_.actorSpriteComps1083 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_318_3 then
						iter_318_3.color = arg_315_1.isInRecall_ and (arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_315_1.var_.actorSpriteComps1083 = nil
			end

			local var_318_2 = arg_315_1.actors_["1083"].transform

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos1083 = var_318_2.localPosition
				var_318_2.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("1083", 3)

				for iter_318_4 = 0, var_318_2.childCount - 1 do
					local var_318_3 = var_318_2:GetChild(iter_318_4)

					if var_318_3.name == "split_2" or not string.find(var_318_3.name, "split") then
						var_318_3.gameObject:SetActive(true)
					else
						var_318_3.gameObject:SetActive(false)
					end
				end
			end

			local var_318_4 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_4 then
				var_318_2.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_315_1.time_ - 0) / var_318_4)
			end

			if arg_315_1.time_ >= 0 + var_318_4 and arg_315_1.time_ < 0 + var_318_4 + arg_318_0 then
				var_318_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_318_5 = 0
			local var_318_6 = 0.35

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_5 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_7 = arg_315_1:GetWordFromCfg(423101074)
				local var_318_8 = arg_315_1:FormatText(var_318_7.content)

				arg_315_1.text_.text = var_318_8

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_10 = 14 <= 0 and var_318_6 or var_318_6 * (utf8.len(var_318_8) / 14)

				if (14 <= 0 and var_318_6 or var_318_6 * (utf8.len(var_318_8) / 14)) > 0 and var_318_6 < var_318_10 then
					arg_315_1.talkMaxDuration = var_318_10

					if var_318_10 + var_318_5 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_10 + var_318_5
					end
				end

				arg_315_1.text_.text = var_318_8
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101074", "story_v_out_423101.awb") ~= 0 then
					local var_318_11 = manager.audio:GetVoiceLength("story_v_out_423101", "423101074", "story_v_out_423101.awb") / 1000

					if var_318_11 + var_318_5 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_11 + var_318_5
					end

					if var_318_7.prefab_name ~= "" and arg_315_1.actors_[var_318_7.prefab_name] ~= nil then
						local var_318_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_7.prefab_name].transform, "story_v_out_423101", "423101074", "story_v_out_423101.awb")

						arg_315_1:RecordAudio("423101074", var_318_12)
						arg_315_1:RecordAudio("423101074", var_318_12)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_423101", "423101074", "story_v_out_423101.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_423101", "423101074", "story_v_out_423101.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_13 = math.max(var_318_6, arg_315_1.talkMaxDuration)

			if var_318_5 <= arg_315_1.time_ and arg_315_1.time_ < var_318_5 + var_318_13 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_5) / var_318_13

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_5 + var_318_13 and arg_315_1.time_ < var_318_5 + var_318_13 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_315_1:InitPlayNodeList()
	end,
	Play423101075 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 423101075
		arg_319_1.duration_ = 13.2

		local var_319_0 = {
			zh = 8.9,
			ja = 13.2
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play423101076(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos1083 = arg_319_1.actors_["1083"].transform.localPosition
				arg_319_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("1083", 3)

				for iter_322_0 = 0, arg_319_1.actors_["1083"].transform.childCount - 1 do
					local var_322_0 = arg_319_1.actors_["1083"].transform:GetChild(iter_322_0)

					if var_322_0.name == "" or not string.find(var_322_0.name, "split") then
						var_322_0.gameObject:SetActive(true)
					else
						var_322_0.gameObject:SetActive(false)
					end
				end
			end

			local var_322_1 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_1 then
				arg_319_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_319_1.time_ - 0) / var_322_1)
			end

			if arg_319_1.time_ >= 0 + var_322_1 and arg_319_1.time_ < 0 + var_322_1 + arg_322_0 then
				arg_319_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_322_2 = 0
			local var_322_3 = 1.025

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_2 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_4 = arg_319_1:GetWordFromCfg(423101075)
				local var_322_5 = arg_319_1:FormatText(var_322_4.content)

				arg_319_1.text_.text = var_322_5

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_7 = 41 <= 0 and var_322_3 or var_322_3 * (utf8.len(var_322_5) / 41)

				if (41 <= 0 and var_322_3 or var_322_3 * (utf8.len(var_322_5) / 41)) > 0 and var_322_3 < var_322_7 then
					arg_319_1.talkMaxDuration = var_322_7

					if var_322_7 + var_322_2 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_7 + var_322_2
					end
				end

				arg_319_1.text_.text = var_322_5
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101075", "story_v_out_423101.awb") ~= 0 then
					local var_322_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101075", "story_v_out_423101.awb") / 1000

					if var_322_8 + var_322_2 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_8 + var_322_2
					end

					if var_322_4.prefab_name ~= "" and arg_319_1.actors_[var_322_4.prefab_name] ~= nil then
						local var_322_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_4.prefab_name].transform, "story_v_out_423101", "423101075", "story_v_out_423101.awb")

						arg_319_1:RecordAudio("423101075", var_322_9)
						arg_319_1:RecordAudio("423101075", var_322_9)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_423101", "423101075", "story_v_out_423101.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_423101", "423101075", "story_v_out_423101.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_10 = math.max(var_322_3, arg_319_1.talkMaxDuration)

			if var_322_2 <= arg_319_1.time_ and arg_319_1.time_ < var_322_2 + var_322_10 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_2) / var_322_10

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_2 + var_322_10 and arg_319_1.time_ < var_322_2 + var_322_10 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_319_1:InitPlayNodeList()
	end,
	Play423101076 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 423101076
		arg_323_1.duration_ = 5.9

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play423101077(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["1083"]) and arg_323_1.var_.actorSpriteComps1083 == nil then
				arg_323_1.var_.actorSpriteComps1083 = arg_323_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_0 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["1083"]) then
				if arg_323_1.var_.actorSpriteComps1083 then
					for iter_326_0, iter_326_1 in pairs(arg_323_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_326_1 then
							if arg_323_1.isInRecall_ then
								iter_326_1.color = Color.New(Mathf.Lerp(iter_326_1.color.r, arg_323_1.hightColor2.r, (arg_323_1.time_ - 0) / var_326_0), Mathf.Lerp(iter_326_1.color.g, arg_323_1.hightColor2.g, (arg_323_1.time_ - 0) / var_326_0), (Mathf.Lerp(iter_326_1.color.b, arg_323_1.hightColor2.b, (arg_323_1.time_ - 0) / var_326_0)))
							else
								local var_326_1 = Mathf.Lerp(iter_326_1.color.r, 0.5, (arg_323_1.time_ - 0) / var_326_0)

								iter_326_1.color = Color.New(var_326_1, var_326_1, var_326_1)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["1083"]) and arg_323_1.var_.actorSpriteComps1083 then
				for iter_326_2, iter_326_3 in pairs(arg_323_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_326_3 then
						iter_326_3.color = arg_323_1.isInRecall_ and (arg_323_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_323_1.var_.actorSpriteComps1083 = nil
			end

			local var_326_2 = arg_323_1.actors_["1083"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos1083 = var_326_2.localPosition
				var_326_2.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("1083", 7)

				for iter_326_4 = 0, var_326_2.childCount - 1 do
					local var_326_3 = var_326_2:GetChild(iter_326_4)

					if var_326_3.name == "" or not string.find(var_326_3.name, "split") then
						var_326_3.gameObject:SetActive(true)
					else
						var_326_3.gameObject:SetActive(false)
					end
				end
			end

			local var_326_4 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_4 then
				var_326_2.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_323_1.time_ - 0) / var_326_4)
			end

			if arg_323_1.time_ >= 0 + var_326_4 and arg_323_1.time_ < 0 + var_326_4 + arg_326_0 then
				var_326_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_326_5 = arg_323_1.bgs_.ST0113.transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPosST0113 = var_326_5.localPosition
			end

			local var_326_6 = 1.36666666666667

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_6 then
				var_326_5.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPosST0113, Vector3.New(0, 1, 9), (arg_323_1.time_ - 0) / var_326_6)
			end

			if arg_323_1.time_ >= 0 + var_326_6 and arg_323_1.time_ < 0 + var_326_6 + arg_326_0 then
				var_326_5.localPosition = Vector3.New(0, 1, 9)
			end

			local var_326_7 = 0.9
			local var_326_8 = 1.625

			if 0.9 < arg_323_1.time_ and arg_323_1.time_ <= var_326_7 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, false)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_9 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(423101076).content)

				arg_323_1.text_.text = var_326_9

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_11 = 65 <= 0 and var_326_8 or var_326_8 * (utf8.len(var_326_9) / 65)

				if (65 <= 0 and var_326_8 or var_326_8 * (utf8.len(var_326_9) / 65)) > 0 and var_326_8 < var_326_11 then
					arg_323_1.talkMaxDuration = var_326_11

					if var_326_11 + var_326_7 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_11 + var_326_7
					end
				end

				arg_323_1.text_.text = var_326_9
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_12 = math.max(var_326_8, arg_323_1.talkMaxDuration)

			if var_326_7 <= arg_323_1.time_ and arg_323_1.time_ < var_326_7 + var_326_12 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_7) / var_326_12

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_7 + var_326_12 and arg_323_1.time_ < var_326_7 + var_326_12 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "ST0113",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.36666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.easeOutQuad
				}
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play423101077 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 423101077
		arg_327_1.duration_ = 10.1

		local var_327_0 = {
			zh = 6.933,
			ja = 10.1
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play423101078(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0.725

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_327_1.callingController_:SetSelectedState("normal")

				arg_327_1.keyicon_.color = Color.New(1, 1, 1)
				arg_327_1.icon_.color = Color.New(1, 1, 1)

				local var_330_1 = arg_327_1:GetWordFromCfg(423101077)
				local var_330_2 = arg_327_1:FormatText(var_330_1.content)

				arg_327_1.text_.text = var_330_2

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_4 = 29 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 29)

				if (29 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 29)) > 0 and var_330_0 < var_330_4 then
					arg_327_1.talkMaxDuration = var_330_4

					if var_330_4 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_4 + 0
					end
				end

				arg_327_1.text_.text = var_330_2
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101077", "story_v_out_423101.awb") ~= 0 then
					local var_330_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101077", "story_v_out_423101.awb") / 1000

					if var_330_5 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + 0
					end

					if var_330_1.prefab_name ~= "" and arg_327_1.actors_[var_330_1.prefab_name] ~= nil then
						local var_330_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_1.prefab_name].transform, "story_v_out_423101", "423101077", "story_v_out_423101.awb")

						arg_327_1:RecordAudio("423101077", var_330_6)
						arg_327_1:RecordAudio("423101077", var_330_6)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_423101", "423101077", "story_v_out_423101.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_423101", "423101077", "story_v_out_423101.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_7 = math.max(var_330_0, arg_327_1.talkMaxDuration)

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_7 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - 0) / var_330_7

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= 0 + var_330_7 and arg_327_1.time_ < 0 + var_330_7 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play423101078 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 423101078
		arg_331_1.duration_ = 6.23

		local var_331_0 = {
			zh = 5,
			ja = 6.233
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play423101079(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["1083"]) and arg_331_1.var_.actorSpriteComps1083 == nil then
				arg_331_1.var_.actorSpriteComps1083 = arg_331_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_0 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["1083"]) then
				if arg_331_1.var_.actorSpriteComps1083 then
					for iter_334_0, iter_334_1 in pairs(arg_331_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_334_1 then
							if arg_331_1.isInRecall_ then
								iter_334_1.color = Color.New(Mathf.Lerp(iter_334_1.color.r, arg_331_1.hightColor1.r, (arg_331_1.time_ - 0) / var_334_0), Mathf.Lerp(iter_334_1.color.g, arg_331_1.hightColor1.g, (arg_331_1.time_ - 0) / var_334_0), (Mathf.Lerp(iter_334_1.color.b, arg_331_1.hightColor1.b, (arg_331_1.time_ - 0) / var_334_0)))
							else
								local var_334_1 = Mathf.Lerp(iter_334_1.color.r, 1, (arg_331_1.time_ - 0) / var_334_0)

								iter_334_1.color = Color.New(var_334_1, var_334_1, var_334_1)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["1083"]) and arg_331_1.var_.actorSpriteComps1083 then
				for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_334_3 then
						iter_334_3.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_331_1.var_.actorSpriteComps1083 = nil
			end

			local var_334_2 = arg_331_1.actors_["1083"].transform

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos1083 = var_334_2.localPosition
				var_334_2.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("1083", 3)

				for iter_334_4 = 0, var_334_2.childCount - 1 do
					local var_334_3 = var_334_2:GetChild(iter_334_4)

					if var_334_3.name == "split_7" or not string.find(var_334_3.name, "split") then
						var_334_3.gameObject:SetActive(true)
					else
						var_334_3.gameObject:SetActive(false)
					end
				end
			end

			local var_334_4 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_4 then
				var_334_2.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_331_1.time_ - 0) / var_334_4)
			end

			if arg_331_1.time_ >= 0 + var_334_4 and arg_331_1.time_ < 0 + var_334_4 + arg_334_0 then
				var_334_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_334_5 = 0
			local var_334_6 = 0.675

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_5 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_7 = arg_331_1:GetWordFromCfg(423101078)
				local var_334_8 = arg_331_1:FormatText(var_334_7.content)

				arg_331_1.text_.text = var_334_8

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_10 = 27 <= 0 and var_334_6 or var_334_6 * (utf8.len(var_334_8) / 27)

				if (27 <= 0 and var_334_6 or var_334_6 * (utf8.len(var_334_8) / 27)) > 0 and var_334_6 < var_334_10 then
					arg_331_1.talkMaxDuration = var_334_10

					if var_334_10 + var_334_5 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_10 + var_334_5
					end
				end

				arg_331_1.text_.text = var_334_8
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101078", "story_v_out_423101.awb") ~= 0 then
					local var_334_11 = manager.audio:GetVoiceLength("story_v_out_423101", "423101078", "story_v_out_423101.awb") / 1000

					if var_334_11 + var_334_5 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_11 + var_334_5
					end

					if var_334_7.prefab_name ~= "" and arg_331_1.actors_[var_334_7.prefab_name] ~= nil then
						local var_334_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_7.prefab_name].transform, "story_v_out_423101", "423101078", "story_v_out_423101.awb")

						arg_331_1:RecordAudio("423101078", var_334_12)
						arg_331_1:RecordAudio("423101078", var_334_12)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_423101", "423101078", "story_v_out_423101.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_423101", "423101078", "story_v_out_423101.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_13 = math.max(var_334_6, arg_331_1.talkMaxDuration)

			if var_334_5 <= arg_331_1.time_ and arg_331_1.time_ < var_334_5 + var_334_13 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_5) / var_334_13

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_5 + var_334_13 and arg_331_1.time_ < var_334_5 + var_334_13 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play423101079 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 423101079
		arg_335_1.duration_ = 7.9

		local var_335_0 = {
			zh = 7.233,
			ja = 7.9
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play423101080(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["1083"]) and arg_335_1.var_.actorSpriteComps1083 == nil then
				arg_335_1.var_.actorSpriteComps1083 = arg_335_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_0 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["1083"]) then
				if arg_335_1.var_.actorSpriteComps1083 then
					for iter_338_0, iter_338_1 in pairs(arg_335_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_338_1 then
							if arg_335_1.isInRecall_ then
								iter_338_1.color = Color.New(Mathf.Lerp(iter_338_1.color.r, arg_335_1.hightColor2.r, (arg_335_1.time_ - 0) / var_338_0), Mathf.Lerp(iter_338_1.color.g, arg_335_1.hightColor2.g, (arg_335_1.time_ - 0) / var_338_0), (Mathf.Lerp(iter_338_1.color.b, arg_335_1.hightColor2.b, (arg_335_1.time_ - 0) / var_338_0)))
							else
								local var_338_1 = Mathf.Lerp(iter_338_1.color.r, 0.5, (arg_335_1.time_ - 0) / var_338_0)

								iter_338_1.color = Color.New(var_338_1, var_338_1, var_338_1)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["1083"]) and arg_335_1.var_.actorSpriteComps1083 then
				for iter_338_2, iter_338_3 in pairs(arg_335_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_338_3 then
						iter_338_3.color = arg_335_1.isInRecall_ and (arg_335_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_335_1.var_.actorSpriteComps1083 = nil
			end

			if 0.166666666666667 < arg_335_1.time_ and arg_335_1.time_ <= 0.166666666666667 + arg_338_0 then
				arg_335_1:AudioAction("play", "effect", "se_story_140", "se_story_140_gun01", "")
			end

			if 1.86666666666667 < arg_335_1.time_ and arg_335_1.time_ <= 1.86666666666667 + arg_338_0 then
				arg_335_1:AudioAction("play", "effect", "se_story_140", "se_story_140_gun01", "")
			end

			local var_338_4 = 0
			local var_338_5 = 0.925

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_4 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_6 = arg_335_1:GetWordFromCfg(423101079)
				local var_338_7 = arg_335_1:FormatText(var_338_6.content)

				arg_335_1.text_.text = var_338_7

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_9 = 37 <= 0 and var_338_5 or var_338_5 * (utf8.len(var_338_7) / 37)

				if (37 <= 0 and var_338_5 or var_338_5 * (utf8.len(var_338_7) / 37)) > 0 and var_338_5 < var_338_9 then
					arg_335_1.talkMaxDuration = var_338_9

					if var_338_9 + var_338_4 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_9 + var_338_4
					end
				end

				arg_335_1.text_.text = var_338_7
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101079", "story_v_out_423101.awb") ~= 0 then
					local var_338_10 = manager.audio:GetVoiceLength("story_v_out_423101", "423101079", "story_v_out_423101.awb") / 1000

					if var_338_10 + var_338_4 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_10 + var_338_4
					end

					if var_338_6.prefab_name ~= "" and arg_335_1.actors_[var_338_6.prefab_name] ~= nil then
						local var_338_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_6.prefab_name].transform, "story_v_out_423101", "423101079", "story_v_out_423101.awb")

						arg_335_1:RecordAudio("423101079", var_338_11)
						arg_335_1:RecordAudio("423101079", var_338_11)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_423101", "423101079", "story_v_out_423101.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_423101", "423101079", "story_v_out_423101.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_12 = math.max(var_338_5, arg_335_1.talkMaxDuration)

			if var_338_4 <= arg_335_1.time_ and arg_335_1.time_ < var_338_4 + var_338_12 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_4) / var_338_12

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_4 + var_338_12 and arg_335_1.time_ < var_338_4 + var_338_12 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play423101080 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 423101080
		arg_339_1.duration_ = 9.23

		local var_339_0 = {
			zh = 5.666,
			ja = 9.233
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play423101081(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0.75

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_1 = arg_339_1:GetWordFromCfg(423101080)
				local var_342_2 = arg_339_1:FormatText(var_342_1.content)

				arg_339_1.text_.text = var_342_2

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_4 = 30 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 30)

				if (30 <= 0 and var_342_0 or var_342_0 * (utf8.len(var_342_2) / 30)) > 0 and var_342_0 < var_342_4 then
					arg_339_1.talkMaxDuration = var_342_4

					if var_342_4 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_4 + 0
					end
				end

				arg_339_1.text_.text = var_342_2
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101080", "story_v_out_423101.awb") ~= 0 then
					local var_342_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101080", "story_v_out_423101.awb") / 1000

					if var_342_5 + 0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_5 + 0
					end

					if var_342_1.prefab_name ~= "" and arg_339_1.actors_[var_342_1.prefab_name] ~= nil then
						local var_342_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_1.prefab_name].transform, "story_v_out_423101", "423101080", "story_v_out_423101.awb")

						arg_339_1:RecordAudio("423101080", var_342_6)
						arg_339_1:RecordAudio("423101080", var_342_6)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_423101", "423101080", "story_v_out_423101.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_423101", "423101080", "story_v_out_423101.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_7 = math.max(var_342_0, arg_339_1.talkMaxDuration)

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_7 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - 0) / var_342_7

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= 0 + var_342_7 and arg_339_1.time_ < 0 + var_342_7 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play423101081 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 423101081
		arg_343_1.duration_ = 4.37

		local var_343_0 = {
			zh = 4.366,
			ja = 3.933
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play423101082(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1083"]) and arg_343_1.var_.actorSpriteComps1083 == nil then
				arg_343_1.var_.actorSpriteComps1083 = arg_343_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_0 = 0.2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1083"]) then
				if arg_343_1.var_.actorSpriteComps1083 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_346_1 then
							if arg_343_1.isInRecall_ then
								iter_346_1.color = Color.New(Mathf.Lerp(iter_346_1.color.r, arg_343_1.hightColor1.r, (arg_343_1.time_ - 0) / var_346_0), Mathf.Lerp(iter_346_1.color.g, arg_343_1.hightColor1.g, (arg_343_1.time_ - 0) / var_346_0), (Mathf.Lerp(iter_346_1.color.b, arg_343_1.hightColor1.b, (arg_343_1.time_ - 0) / var_346_0)))
							else
								local var_346_1 = Mathf.Lerp(iter_346_1.color.r, 1, (arg_343_1.time_ - 0) / var_346_0)

								iter_346_1.color = Color.New(var_346_1, var_346_1, var_346_1)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1083"]) and arg_343_1.var_.actorSpriteComps1083 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_346_3 then
						iter_346_3.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_343_1.var_.actorSpriteComps1083 = nil
			end

			local var_346_2 = arg_343_1.actors_["1083"].transform

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos1083 = var_346_2.localPosition
				var_346_2.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("1083", 3)

				for iter_346_4 = 0, var_346_2.childCount - 1 do
					local var_346_3 = var_346_2:GetChild(iter_346_4)

					if var_346_3.name == "" or not string.find(var_346_3.name, "split") then
						var_346_3.gameObject:SetActive(true)
					else
						var_346_3.gameObject:SetActive(false)
					end
				end
			end

			local var_346_4 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 then
				var_346_2.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_343_1.time_ - 0) / var_346_4)
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 then
				var_346_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_346_5 = 0
			local var_346_6 = 0.475

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_5 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_7 = arg_343_1:GetWordFromCfg(423101081)
				local var_346_8 = arg_343_1:FormatText(var_346_7.content)

				arg_343_1.text_.text = var_346_8

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_10 = 19 <= 0 and var_346_6 or var_346_6 * (utf8.len(var_346_8) / 19)

				if (19 <= 0 and var_346_6 or var_346_6 * (utf8.len(var_346_8) / 19)) > 0 and var_346_6 < var_346_10 then
					arg_343_1.talkMaxDuration = var_346_10

					if var_346_10 + var_346_5 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_10 + var_346_5
					end
				end

				arg_343_1.text_.text = var_346_8
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101081", "story_v_out_423101.awb") ~= 0 then
					local var_346_11 = manager.audio:GetVoiceLength("story_v_out_423101", "423101081", "story_v_out_423101.awb") / 1000

					if var_346_11 + var_346_5 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_11 + var_346_5
					end

					if var_346_7.prefab_name ~= "" and arg_343_1.actors_[var_346_7.prefab_name] ~= nil then
						local var_346_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_7.prefab_name].transform, "story_v_out_423101", "423101081", "story_v_out_423101.awb")

						arg_343_1:RecordAudio("423101081", var_346_12)
						arg_343_1:RecordAudio("423101081", var_346_12)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_423101", "423101081", "story_v_out_423101.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_423101", "423101081", "story_v_out_423101.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_13 = math.max(var_346_6, arg_343_1.talkMaxDuration)

			if var_346_5 <= arg_343_1.time_ and arg_343_1.time_ < var_346_5 + var_346_13 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_5) / var_346_13

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_5 + var_346_13 and arg_343_1.time_ < var_346_5 + var_346_13 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play423101082 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 423101082
		arg_347_1.duration_ = 2.6

		local var_347_0 = {
			zh = 2.6,
			ja = 2.566
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play423101083(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["1083"]) and arg_347_1.var_.actorSpriteComps1083 == nil then
				arg_347_1.var_.actorSpriteComps1083 = arg_347_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_0 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["1083"]) then
				if arg_347_1.var_.actorSpriteComps1083 then
					for iter_350_0, iter_350_1 in pairs(arg_347_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_350_1 then
							if arg_347_1.isInRecall_ then
								iter_350_1.color = Color.New(Mathf.Lerp(iter_350_1.color.r, arg_347_1.hightColor2.r, (arg_347_1.time_ - 0) / var_350_0), Mathf.Lerp(iter_350_1.color.g, arg_347_1.hightColor2.g, (arg_347_1.time_ - 0) / var_350_0), (Mathf.Lerp(iter_350_1.color.b, arg_347_1.hightColor2.b, (arg_347_1.time_ - 0) / var_350_0)))
							else
								local var_350_1 = Mathf.Lerp(iter_350_1.color.r, 0.5, (arg_347_1.time_ - 0) / var_350_0)

								iter_350_1.color = Color.New(var_350_1, var_350_1, var_350_1)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["1083"]) and arg_347_1.var_.actorSpriteComps1083 then
				for iter_350_2, iter_350_3 in pairs(arg_347_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_350_3 then
						iter_350_3.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_347_1.var_.actorSpriteComps1083 = nil
			end

			local var_350_2 = 0
			local var_350_3 = 0.3

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_2 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, true)
				arg_347_1.iconController_:SetSelectedState("hero")

				arg_347_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_347_1.callingController_:SetSelectedState("normal")

				arg_347_1.keyicon_.color = Color.New(1, 1, 1)
				arg_347_1.icon_.color = Color.New(1, 1, 1)

				local var_350_4 = arg_347_1:GetWordFromCfg(423101082)
				local var_350_5 = arg_347_1:FormatText(var_350_4.content)

				arg_347_1.text_.text = var_350_5

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_7 = 12 <= 0 and var_350_3 or var_350_3 * (utf8.len(var_350_5) / 12)

				if (12 <= 0 and var_350_3 or var_350_3 * (utf8.len(var_350_5) / 12)) > 0 and var_350_3 < var_350_7 then
					arg_347_1.talkMaxDuration = var_350_7

					if var_350_7 + var_350_2 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_2
					end
				end

				arg_347_1.text_.text = var_350_5
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101082", "story_v_out_423101.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101082", "story_v_out_423101.awb") / 1000

					if var_350_8 + var_350_2 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_2
					end

					if var_350_4.prefab_name ~= "" and arg_347_1.actors_[var_350_4.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_4.prefab_name].transform, "story_v_out_423101", "423101082", "story_v_out_423101.awb")

						arg_347_1:RecordAudio("423101082", var_350_9)
						arg_347_1:RecordAudio("423101082", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_423101", "423101082", "story_v_out_423101.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_423101", "423101082", "story_v_out_423101.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_10 = math.max(var_350_3, arg_347_1.talkMaxDuration)

			if var_350_2 <= arg_347_1.time_ and arg_347_1.time_ < var_350_2 + var_350_10 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_2) / var_350_10

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_2 + var_350_10 and arg_347_1.time_ < var_350_2 + var_350_10 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play423101083 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 423101083
		arg_351_1.duration_ = 7

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play423101084(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_9000

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				local var_354_0 = arg_351_1.bgs_.I25h

				arg_351_1.bgs_.I25h.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_354_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_354_1 = var_354_0:GetComponent("SpriteRenderer")

				if var_354_1 and var_354_1.sprite then
					local var_354_2 = 2 * (var_354_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_354_0.transform.localScale = Vector3.New(var_354_2 / var_354_1.sprite.bounds.size.y < var_354_2 * manager.ui.mainCameraCom_.aspect / var_354_1.sprite.bounds.size.x and var_354_2 * manager.ui.mainCameraCom_.aspect / var_354_1.sprite.bounds.size.x or var_354_2 / var_354_1.sprite.bounds.size.y, var_354_2 / var_354_1.sprite.bounds.size.y < var_354_2 * manager.ui.mainCameraCom_.aspect / var_354_1.sprite.bounds.size.x and var_354_2 * manager.ui.mainCameraCom_.aspect / var_354_1.sprite.bounds.size.x or var_354_2 / var_354_1.sprite.bounds.size.y, 0)
				end

				for iter_354_0, iter_354_1 in pairs(arg_351_1.bgs_) do
					if iter_354_0 ~= "I25h" then
						iter_354_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_354_3 = 2

			if 2 < arg_351_1.time_ and arg_351_1.time_ <= var_354_3 + arg_354_0 then
				arg_351_1.allBtn_.enabled = false
			end

			if arg_351_1.time_ >= var_354_3 + 0.3 and arg_351_1.time_ < var_354_3 + 0.3 + arg_354_0 then
				arg_351_1.allBtn_.enabled = true
			end

			local var_354_4 = 0

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1.mask_.enabled = true
				arg_351_1.mask_.raycastTarget = true

				arg_351_1:SetGaussion(false)
			end

			local var_354_5 = 0.4

			if var_354_4 <= arg_351_1.time_ and arg_351_1.time_ < var_354_4 + var_354_5 then
				local var_354_6 = Color.New(1, 1, 1)

				var_354_6.a = Mathf.Lerp(1, 0, (arg_351_1.time_ - var_354_4) / var_354_5)
				arg_351_1.mask_.color = var_354_6
			end

			if arg_351_1.time_ >= var_354_4 + var_354_5 and arg_351_1.time_ < var_354_4 + var_354_5 + arg_354_0 then
				local var_354_7 = Color.New(1, 1, 1)

				arg_351_1.mask_.enabled = false
				var_354_7.a = 0
				arg_351_1.mask_.color = var_354_7
			end

			local var_354_8 = arg_351_1.actors_["1083"].transform

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos1083 = var_354_8.localPosition
				var_354_8.localScale = Vector3.New(1, 1, 1)

				arg_351_1:CheckSpriteTmpPos("1083", 7)

				for iter_354_2 = 0, var_354_8.childCount - 1 do
					local var_354_9 = var_354_8:GetChild(iter_354_2)

					if var_354_9.name == "" or not string.find(var_354_9.name, "split") then
						var_354_9.gameObject:SetActive(true)
					else
						var_354_9.gameObject:SetActive(false)
					end
				end
			end

			local var_354_10 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_10 then
				var_354_8.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_351_1.time_ - 0) / var_354_10)
			end

			if arg_351_1.time_ >= 0 + var_354_10 and arg_351_1.time_ < 0 + var_354_10 + arg_354_0 then
				var_354_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_354_11 = manager.ui.mainCamera.transform

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.shakeOldPos = var_354_11.localPosition
			end

			local var_354_12 = 0.6

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_12 then
				local var_354_13, var_354_14 = math.modf((arg_351_1.time_ - 0) / 0.066)

				var_354_11.localPosition = Vector3.New(var_354_14 * 0.13, var_354_14 * 0.13, var_354_14 * 0.13) + arg_351_1.var_.shakeOldPos
			end

			if arg_351_1.time_ >= 0 + var_354_12 and arg_351_1.time_ < 0 + var_354_12 + arg_354_0 then
				var_354_11.localPosition = arg_351_1.var_.shakeOldPos
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				local var_354_15 = arg_351_1.var_.effectmotuozhuangche

				if not arg_351_1.var_.effectmotuozhuangche then
					var_354_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_354_15.name = "motuozhuangche"
					arg_351_1.var_.effectmotuozhuangche = var_354_15
				else
					var_354_15.transform:SetParent(var_354_9000)
				end

				var_354_15.transform.localPosition = Vector3.New(0, 0, 0)
				var_354_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.5 < arg_351_1.time_ and arg_351_1.time_ <= 1.5 + arg_354_0 then
				if arg_351_1.var_.effectmotuozhuangche then
					Object.Destroy(arg_351_1.var_.effectmotuozhuangche)

					arg_351_1.var_.effectmotuozhuangche = nil
				end
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				if arg_351_1.var_.effectaishimoturoche1 then
					Object.Destroy(arg_351_1.var_.effectaishimoturoche1)

					arg_351_1.var_.effectaishimoturoche1 = nil
				end
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:AudioAction("play", "effect", "se_story_144", "se_story_144_impact", "")
			end

			if 0.034 < arg_351_1.time_ and arg_351_1.time_ <= 0.034 + arg_354_0 then
				arg_351_1:AudioAction("stop", "effect", "se_story_side_1028", "se_story_side_1028_storm_loop", "")
			end

			if 0.294969900045544 < arg_351_1.time_ and arg_351_1.time_ <= 0.294969900045544 + arg_354_0 then
				arg_351_1:AudioAction("play", "effect", "minigame_activity_2_2", "minigame_activity_2_2_pt_loop02", "")
			end

			if arg_351_1.frameCnt_ <= 1 then
				arg_351_1.dialog_:SetActive(false)
			end

			local var_354_22 = 2
			local var_354_23 = 1.85

			if 2 < arg_351_1.time_ and arg_351_1.time_ <= var_354_22 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0

				arg_351_1.dialog_:SetActive(true)

				arg_351_1.dialogCg_.alpha = 0

				local var_354_24 = LeanTween.value(arg_351_1.dialog_, 0, 1, 0.3)

				var_354_24:setOnUpdate(LuaHelper.FloatAction(function(arg_355_0)
					arg_351_1.dialogCg_.alpha = arg_355_0
				end))
				var_354_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_351_1.dialog_)
					var_354_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_351_1.duration_ = arg_351_1.duration_ + 0.3

				SetActive(arg_351_1.leftNameGo_, false)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_25 = arg_351_1:FormatText(arg_351_1:GetWordFromCfg(423101083).content)

				arg_351_1.text_.text = var_354_25

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_27 = 74 <= 0 and var_354_23 or var_354_23 * (utf8.len(var_354_25) / 74)

				if (74 <= 0 and var_354_23 or var_354_23 * (utf8.len(var_354_25) / 74)) > 0 and var_354_23 < var_354_27 then
					arg_351_1.talkMaxDuration = var_354_27
					var_354_22 = var_354_22 + 0.3

					if var_354_27 + var_354_22 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_27 + var_354_22
					end
				end

				arg_351_1.text_.text = var_354_25
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)
				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_28 = var_354_22 + 0.3
			local var_354_29 = math.max(var_354_23, arg_351_1.talkMaxDuration)

			if var_354_22 + 0.3 <= arg_351_1.time_ and arg_351_1.time_ < var_354_28 + var_354_29 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_28) / var_354_29

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_28 + var_354_29 and arg_351_1.time_ < var_354_28 + var_354_29 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play423101084 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 423101084
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play423101085(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = 1.475

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_1 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(423101084).content)

				arg_357_1.text_.text = var_360_1

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_3 = 59 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_1) / 59)

				if (59 <= 0 and var_360_0 or var_360_0 * (utf8.len(var_360_1) / 59)) > 0 and var_360_0 < var_360_3 then
					arg_357_1.talkMaxDuration = var_360_3

					if var_360_3 + 0 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_3 + 0
					end
				end

				arg_357_1.text_.text = var_360_1
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_4 = math.max(var_360_0, arg_357_1.talkMaxDuration)

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_4 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - 0) / var_360_4

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= 0 + var_360_4 and arg_357_1.time_ < 0 + var_360_4 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play423101085 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 423101085
		arg_361_1.duration_ = 4.43

		local var_361_0 = {
			zh = 4.433,
			ja = 3.066
		}
		local var_361_1 = manager.audio:GetLocalizationFlag()

		if var_361_0[var_361_1] ~= nil then
			arg_361_1.duration_ = var_361_0[var_361_1]
		end

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play423101086(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0.275

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[1336].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, true)
				arg_361_1.iconController_:SetSelectedState("hero")

				arg_361_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_361_1.callingController_:SetSelectedState("normal")

				arg_361_1.keyicon_.color = Color.New(1, 1, 1)
				arg_361_1.icon_.color = Color.New(1, 1, 1)

				local var_364_1 = arg_361_1:GetWordFromCfg(423101085)
				local var_364_2 = arg_361_1:FormatText(var_364_1.content)

				arg_361_1.text_.text = var_364_2

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_4 = 11 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_2) / 11)

				if (11 <= 0 and var_364_0 or var_364_0 * (utf8.len(var_364_2) / 11)) > 0 and var_364_0 < var_364_4 then
					arg_361_1.talkMaxDuration = var_364_4

					if var_364_4 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_4 + 0
					end
				end

				arg_361_1.text_.text = var_364_2
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101085", "story_v_out_423101.awb") ~= 0 then
					local var_364_5 = manager.audio:GetVoiceLength("story_v_out_423101", "423101085", "story_v_out_423101.awb") / 1000

					if var_364_5 + 0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + 0
					end

					if var_364_1.prefab_name ~= "" and arg_361_1.actors_[var_364_1.prefab_name] ~= nil then
						local var_364_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_1.prefab_name].transform, "story_v_out_423101", "423101085", "story_v_out_423101.awb")

						arg_361_1:RecordAudio("423101085", var_364_6)
						arg_361_1:RecordAudio("423101085", var_364_6)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_423101", "423101085", "story_v_out_423101.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_423101", "423101085", "story_v_out_423101.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_7 = math.max(var_364_0, arg_361_1.talkMaxDuration)

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_7 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - 0) / var_364_7

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= 0 + var_364_7 and arg_361_1.time_ < 0 + var_364_7 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play423101086 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 423101086
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play423101087(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0.45

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_1 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(423101086).content)

				arg_365_1.text_.text = var_368_1

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_3 = 18 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 18)

				if (18 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_1) / 18)) > 0 and var_368_0 < var_368_3 then
					arg_365_1.talkMaxDuration = var_368_3

					if var_368_3 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_3 + 0
					end
				end

				arg_365_1.text_.text = var_368_1
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_4 = math.max(var_368_0, arg_365_1.talkMaxDuration)

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_4 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - 0) / var_368_4

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= 0 + var_368_4 and arg_365_1.time_ < 0 + var_368_4 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play423101087 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 423101087
		arg_369_1.duration_ = 7.93

		local var_369_0 = {
			zh = 7.933,
			ja = 5.366
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
				arg_369_0:Play423101088(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["1083"]) and arg_369_1.var_.actorSpriteComps1083 == nil then
				arg_369_1.var_.actorSpriteComps1083 = arg_369_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_0 = 0.2

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["1083"]) then
				if arg_369_1.var_.actorSpriteComps1083 then
					for iter_372_0, iter_372_1 in pairs(arg_369_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_372_1 then
							if arg_369_1.isInRecall_ then
								iter_372_1.color = Color.New(Mathf.Lerp(iter_372_1.color.r, arg_369_1.hightColor1.r, (arg_369_1.time_ - 0) / var_372_0), Mathf.Lerp(iter_372_1.color.g, arg_369_1.hightColor1.g, (arg_369_1.time_ - 0) / var_372_0), (Mathf.Lerp(iter_372_1.color.b, arg_369_1.hightColor1.b, (arg_369_1.time_ - 0) / var_372_0)))
							else
								local var_372_1 = Mathf.Lerp(iter_372_1.color.r, 1, (arg_369_1.time_ - 0) / var_372_0)

								iter_372_1.color = Color.New(var_372_1, var_372_1, var_372_1)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["1083"]) and arg_369_1.var_.actorSpriteComps1083 then
				for iter_372_2, iter_372_3 in pairs(arg_369_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_372_3 then
						iter_372_3.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_369_1.var_.actorSpriteComps1083 = nil
			end

			local var_372_2 = arg_369_1.actors_["1083"].transform

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos1083 = var_372_2.localPosition
				var_372_2.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("1083", 3)

				for iter_372_4 = 0, var_372_2.childCount - 1 do
					local var_372_3 = var_372_2:GetChild(iter_372_4)

					if var_372_3.name == "split_2" or not string.find(var_372_3.name, "split") then
						var_372_3.gameObject:SetActive(true)
					else
						var_372_3.gameObject:SetActive(false)
					end
				end
			end

			local var_372_4 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_4 then
				var_372_2.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_369_1.time_ - 0) / var_372_4)
			end

			if arg_369_1.time_ >= 0 + var_372_4 and arg_369_1.time_ < 0 + var_372_4 + arg_372_0 then
				var_372_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_372_5 = 0
			local var_372_6 = 0.9

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_5 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_7 = arg_369_1:GetWordFromCfg(423101087)
				local var_372_8 = arg_369_1:FormatText(var_372_7.content)

				arg_369_1.text_.text = var_372_8

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_10 = 36 <= 0 and var_372_6 or var_372_6 * (utf8.len(var_372_8) / 36)

				if (36 <= 0 and var_372_6 or var_372_6 * (utf8.len(var_372_8) / 36)) > 0 and var_372_6 < var_372_10 then
					arg_369_1.talkMaxDuration = var_372_10

					if var_372_10 + var_372_5 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_10 + var_372_5
					end
				end

				arg_369_1.text_.text = var_372_8
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101087", "story_v_out_423101.awb") ~= 0 then
					local var_372_11 = manager.audio:GetVoiceLength("story_v_out_423101", "423101087", "story_v_out_423101.awb") / 1000

					if var_372_11 + var_372_5 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_11 + var_372_5
					end

					if var_372_7.prefab_name ~= "" and arg_369_1.actors_[var_372_7.prefab_name] ~= nil then
						local var_372_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_7.prefab_name].transform, "story_v_out_423101", "423101087", "story_v_out_423101.awb")

						arg_369_1:RecordAudio("423101087", var_372_12)
						arg_369_1:RecordAudio("423101087", var_372_12)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_423101", "423101087", "story_v_out_423101.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_423101", "423101087", "story_v_out_423101.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_13 = math.max(var_372_6, arg_369_1.talkMaxDuration)

			if var_372_5 <= arg_369_1.time_ and arg_369_1.time_ < var_372_5 + var_372_13 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_5) / var_372_13

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_5 + var_372_13 and arg_369_1.time_ < var_372_5 + var_372_13 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_369_1:InitPlayNodeList()
	end,
	Play423101088 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 423101088
		arg_373_1.duration_ = 5.7

		local var_373_0 = {
			zh = 4.333,
			ja = 5.7
		}
		local var_373_1 = manager.audio:GetLocalizationFlag()

		if var_373_0[var_373_1] ~= nil then
			arg_373_1.duration_ = var_373_0[var_373_1]
		end

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
			arg_373_1.auto_ = false
		end

		function arg_373_1.playNext_(arg_375_0)
			arg_373_1.onStoryFinished_()
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos1083 = arg_373_1.actors_["1083"].transform.localPosition
				arg_373_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("1083", 3)

				for iter_376_0 = 0, arg_373_1.actors_["1083"].transform.childCount - 1 do
					local var_376_0 = arg_373_1.actors_["1083"].transform:GetChild(iter_376_0)

					if var_376_0.name == "split_7" or not string.find(var_376_0.name, "split") then
						var_376_0.gameObject:SetActive(true)
					else
						var_376_0.gameObject:SetActive(false)
					end
				end
			end

			local var_376_1 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_1 then
				arg_373_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_373_1.time_ - 0) / var_376_1)
			end

			if arg_373_1.time_ >= 0 + var_376_1 and arg_373_1.time_ < 0 + var_376_1 + arg_376_0 then
				arg_373_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_376_2 = 0
			local var_376_3 = 0.45

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_2 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_4 = arg_373_1:GetWordFromCfg(423101088)
				local var_376_5 = arg_373_1:FormatText(var_376_4.content)

				arg_373_1.text_.text = var_376_5

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_7 = 18 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 18)

				if (18 <= 0 and var_376_3 or var_376_3 * (utf8.len(var_376_5) / 18)) > 0 and var_376_3 < var_376_7 then
					arg_373_1.talkMaxDuration = var_376_7

					if var_376_7 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_7 + var_376_2
					end
				end

				arg_373_1.text_.text = var_376_5
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423101", "423101088", "story_v_out_423101.awb") ~= 0 then
					local var_376_8 = manager.audio:GetVoiceLength("story_v_out_423101", "423101088", "story_v_out_423101.awb") / 1000

					if var_376_8 + var_376_2 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_8 + var_376_2
					end

					if var_376_4.prefab_name ~= "" and arg_373_1.actors_[var_376_4.prefab_name] ~= nil then
						local var_376_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_4.prefab_name].transform, "story_v_out_423101", "423101088", "story_v_out_423101.awb")

						arg_373_1:RecordAudio("423101088", var_376_9)
						arg_373_1:RecordAudio("423101088", var_376_9)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_423101", "423101088", "story_v_out_423101.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_423101", "423101088", "story_v_out_423101.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_10 = math.max(var_376_3, arg_373_1.talkMaxDuration)

			if var_376_2 <= arg_373_1.time_ and arg_373_1.time_ < var_376_2 + var_376_10 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_2) / var_376_10

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_2 + var_376_10 and arg_373_1.time_ < var_376_2 + var_376_10 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_373_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I25h",
		"TextureConfig/Background/SS2303",
		"TextureConfig/Background/L08g",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/SS2303a",
		"TextureConfig/Background/ST0113"
	},
	voices = {
		"story_v_out_423101.awb"
	}
}
