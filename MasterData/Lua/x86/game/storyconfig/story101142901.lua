return {
	Play114291001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114291001
		arg_1_1.duration_ = 9.7

		local var_1_0 = {
			ja = 9.7,
			ko = 5.5,
			zh = 6.9,
			en = 6.133
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
				arg_1_0:Play114291002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST26 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST26")
				var_4_0.name = "ST26"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST26 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST26

				arg_1_1.bgs_.ST26.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST26" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = "10016"

			if arg_1_1.actors_["10016"] == nil then
				local var_4_9 = Object.Instantiate(arg_1_1.imageGo_, arg_1_1.canvasGo_.transform)

				var_4_9.transform:SetSiblingIndex(1)

				var_4_9.name = var_4_8

				local var_4_10 = var_4_9:GetComponent(typeof(Image))

				var_4_10.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10016")

				var_4_10:SetNativeSize()

				var_4_9.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_1_1.actors_[var_4_8] = var_4_9
			end

			local var_4_11 = arg_1_1.actors_["10016"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10016 = var_4_11.localPosition
				var_4_11.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10016", 2)
			end

			local var_4_12 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_12 then
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10016, Vector3.New(-390, -350, -180), (arg_1_1.time_ - 1.8) / var_4_12)
			end

			if arg_1_1.time_ >= 1.8 + var_4_12 and arg_1_1.time_ < 1.8 + var_4_12 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_4_13 = arg_1_1.actors_["10016"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_13) then
				local var_4_14 = var_4_13:GetComponent("Image")

				if var_4_14 then
					arg_1_1.var_.highlightMatValue10016 = var_4_14
				end
			end

			local var_4_15 = 0.034

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 and not isNil(var_4_13) then
				if arg_1_1.var_.highlightMatValue10016 then
					local var_4_16 = Mathf.Lerp(0.5, 1, (arg_1_1.time_ - 1.8) / var_4_15)

					arg_1_1.var_.highlightMatValue10016.color.r = var_4_16
					arg_1_1.var_.highlightMatValue10016.color.g = var_4_16
					arg_1_1.var_.highlightMatValue10016.color.b = var_4_16
					arg_1_1.var_.highlightMatValue10016.color = arg_1_1.var_.highlightMatValue10016.color
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.highlightMatValue10016 then
				var_4_13.transform:SetSiblingIndex(1)

				arg_1_1.var_.highlightMatValue10016.color.r = 1
				arg_1_1.var_.highlightMatValue10016.color.g = 1
				arg_1_1.var_.highlightMatValue10016.color.b = 1
				arg_1_1.var_.highlightMatValue10016.color = arg_1_1.var_.highlightMatValue10016.color
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				local var_4_17 = arg_1_1.actors_["10016"]:GetComponent("Image")

				if var_4_17 then
					arg_1_1.var_.alphaMatValue10016 = var_4_17
					arg_1_1.var_.alphaOldValue10016 = var_4_17.color.a
				end

				arg_1_1.var_.alphaOldValue10016 = 0
			end

			local var_4_18 = 0.5

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_18 then
				if arg_1_1.var_.alphaMatValue10016 then
					arg_1_1.var_.alphaMatValue10016.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValue10016, 1, (arg_1_1.time_ - 1.8) / var_4_18)
					arg_1_1.var_.alphaMatValue10016.color = arg_1_1.var_.alphaMatValue10016.color
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_18 and arg_1_1.time_ < 1.8 + var_4_18 + arg_4_0 and arg_1_1.var_.alphaMatValue10016 then
				arg_1_1.var_.alphaMatValue10016.color.a = 1
				arg_1_1.var_.alphaMatValue10016.color = arg_1_1.var_.alphaMatValue10016.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_21 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_21 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_21

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_21
						arg_1_1.bgmTxt2_.text = var_4_21
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_24 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_24

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_24
						arg_1_1.bgmTxt2_.text = var_4_24
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

			local var_4_25 = 2
			local var_4_26 = 0.475

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(114291001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 19 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 19)

				if (19 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 19)) > 0 and var_4_26 < var_4_31 then
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

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291001", "story_v_out_114291.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_114291", "114291001", "story_v_out_114291.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_114291", "114291001", "story_v_out_114291.awb")

						arg_1_1:RecordAudio("114291001", var_4_33)
						arg_1_1:RecordAudio("114291001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_114291", "114291001", "story_v_out_114291.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_114291", "114291001", "story_v_out_114291.awb")
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
				actorName = "10016",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play114291002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114291002
		arg_9_1.duration_ = 9.13

		local var_9_0 = {
			ja = 9.133,
			ko = 8.8,
			zh = 6.166,
			en = 5.233
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
				arg_9_0:Play114291003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10020"] == nil then
				local var_12_0 = Object.Instantiate(arg_9_1.imageGo_, arg_9_1.canvasGo_.transform)

				var_12_0.transform:SetSiblingIndex(1)

				var_12_0.name = "10020"

				local var_12_1 = var_12_0:GetComponent(typeof(Image))

				var_12_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10020")

				var_12_1:SetNativeSize()

				var_12_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_9_1.actors_["10020"] = var_12_0
			end

			local var_12_2 = arg_9_1.actors_["10020"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10020 = var_12_2.localPosition
				var_12_2.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10020", 4)
			end

			local var_12_3 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_3 then
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10020, Vector3.New(390, -350, -180), (arg_9_1.time_ - 0) / var_12_3)
			end

			if arg_9_1.time_ >= 0 + var_12_3 and arg_9_1.time_ < 0 + var_12_3 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_12_4 = arg_9_1.actors_["10016"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_4) then
				local var_12_5 = var_12_4:GetComponent("Image")

				if var_12_5 then
					arg_9_1.var_.highlightMatValue10016 = var_12_5
				end
			end

			local var_12_6 = 0.034

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_4) then
				if arg_9_1.var_.highlightMatValue10016 then
					local var_12_7 = Mathf.Lerp(1, 0.5, (arg_9_1.time_ - 0) / var_12_6)

					arg_9_1.var_.highlightMatValue10016.color.r = var_12_7
					arg_9_1.var_.highlightMatValue10016.color.g = var_12_7
					arg_9_1.var_.highlightMatValue10016.color.b = var_12_7
					arg_9_1.var_.highlightMatValue10016.color = arg_9_1.var_.highlightMatValue10016.color
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_4) and arg_9_1.var_.highlightMatValue10016 then
				arg_9_1.var_.highlightMatValue10016.color.r = 0.5
				arg_9_1.var_.highlightMatValue10016.color.g = 0.5
				arg_9_1.var_.highlightMatValue10016.color.b = 0.5
				arg_9_1.var_.highlightMatValue10016.color = arg_9_1.var_.highlightMatValue10016.color
			end

			local var_12_8 = arg_9_1.actors_["10020"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_8) then
				local var_12_9 = var_12_8:GetComponent("Image")

				if var_12_9 then
					arg_9_1.var_.highlightMatValue10020 = var_12_9
				end
			end

			local var_12_10 = 0.034

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_10 and not isNil(var_12_8) then
				if arg_9_1.var_.highlightMatValue10020 then
					local var_12_11 = Mathf.Lerp(0.5, 1, (arg_9_1.time_ - 0) / var_12_10)

					arg_9_1.var_.highlightMatValue10020.color.r = var_12_11
					arg_9_1.var_.highlightMatValue10020.color.g = var_12_11
					arg_9_1.var_.highlightMatValue10020.color.b = var_12_11
					arg_9_1.var_.highlightMatValue10020.color = arg_9_1.var_.highlightMatValue10020.color
				end
			end

			if arg_9_1.time_ >= 0 + var_12_10 and arg_9_1.time_ < 0 + var_12_10 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.highlightMatValue10020 then
				var_12_8.transform:SetSiblingIndex(1)

				arg_9_1.var_.highlightMatValue10020.color.r = 1
				arg_9_1.var_.highlightMatValue10020.color.g = 1
				arg_9_1.var_.highlightMatValue10020.color.b = 1
				arg_9_1.var_.highlightMatValue10020.color = arg_9_1.var_.highlightMatValue10020.color
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_12 = arg_9_1.actors_["10020"]:GetComponent("Image")

				if var_12_12 then
					arg_9_1.var_.alphaMatValue10020 = var_12_12
					arg_9_1.var_.alphaOldValue10020 = var_12_12.color.a
				end

				arg_9_1.var_.alphaOldValue10020 = 0
			end

			local var_12_13 = 0.5

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_13 then
				if arg_9_1.var_.alphaMatValue10020 then
					arg_9_1.var_.alphaMatValue10020.color.a = Mathf.Lerp(arg_9_1.var_.alphaOldValue10020, 1, (arg_9_1.time_ - 0) / var_12_13)
					arg_9_1.var_.alphaMatValue10020.color = arg_9_1.var_.alphaMatValue10020.color
				end
			end

			if arg_9_1.time_ >= 0 + var_12_13 and arg_9_1.time_ < 0 + var_12_13 + arg_12_0 and arg_9_1.var_.alphaMatValue10020 then
				arg_9_1.var_.alphaMatValue10020.color.a = 1
				arg_9_1.var_.alphaMatValue10020.color = arg_9_1.var_.alphaMatValue10020.color
			end

			local var_12_14 = 0
			local var_12_15 = 0.675

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_14 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_16 = arg_9_1:GetWordFromCfg(114291002)
				local var_12_17 = arg_9_1:FormatText(var_12_16.content)

				arg_9_1.text_.text = var_12_17

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_19 = 27 <= 0 and var_12_15 or var_12_15 * (utf8.len(var_12_17) / 27)

				if (27 <= 0 and var_12_15 or var_12_15 * (utf8.len(var_12_17) / 27)) > 0 and var_12_15 < var_12_19 then
					arg_9_1.talkMaxDuration = var_12_19

					if var_12_19 + var_12_14 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_19 + var_12_14
					end
				end

				arg_9_1.text_.text = var_12_17
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291002", "story_v_out_114291.awb") ~= 0 then
					local var_12_20 = manager.audio:GetVoiceLength("story_v_out_114291", "114291002", "story_v_out_114291.awb") / 1000

					if var_12_20 + var_12_14 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_20 + var_12_14
					end

					if var_12_16.prefab_name ~= "" and arg_9_1.actors_[var_12_16.prefab_name] ~= nil then
						local var_12_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_16.prefab_name].transform, "story_v_out_114291", "114291002", "story_v_out_114291.awb")

						arg_9_1:RecordAudio("114291002", var_12_21)
						arg_9_1:RecordAudio("114291002", var_12_21)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_114291", "114291002", "story_v_out_114291.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_114291", "114291002", "story_v_out_114291.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_22 = math.max(var_12_15, arg_9_1.talkMaxDuration)

			if var_12_14 <= arg_9_1.time_ and arg_9_1.time_ < var_12_14 + var_12_22 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_14) / var_12_22

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_14 + var_12_22 and arg_9_1.time_ < var_12_14 + var_12_22 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10020",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play114291003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114291003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play114291004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10020"]) then
				local var_16_0 = arg_13_1.actors_["10020"]:GetComponent("Image")

				if var_16_0 then
					arg_13_1.var_.highlightMatValue10020 = var_16_0
				end
			end

			local var_16_1 = 0.034

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 and not isNil(arg_13_1.actors_["10020"]) then
				if arg_13_1.var_.highlightMatValue10020 then
					local var_16_2 = Mathf.Lerp(1, 0.5, (arg_13_1.time_ - 0) / var_16_1)

					arg_13_1.var_.highlightMatValue10020.color.r = var_16_2
					arg_13_1.var_.highlightMatValue10020.color.g = var_16_2
					arg_13_1.var_.highlightMatValue10020.color.b = var_16_2
					arg_13_1.var_.highlightMatValue10020.color = arg_13_1.var_.highlightMatValue10020.color
				end
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 and not isNil(arg_13_1.actors_["10020"]) and arg_13_1.var_.highlightMatValue10020 then
				arg_13_1.var_.highlightMatValue10020.color.r = 0.5
				arg_13_1.var_.highlightMatValue10020.color.g = 0.5
				arg_13_1.var_.highlightMatValue10020.color.b = 0.5
				arg_13_1.var_.highlightMatValue10020.color = arg_13_1.var_.highlightMatValue10020.color
			end

			local var_16_3 = 0
			local var_16_4 = 1.2

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_3 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_5 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(114291003).content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 48 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_5) / 48)

				if (48 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_5) / 48)) > 0 and var_16_4 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_3 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_3
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_4, arg_13_1.talkMaxDuration)

			if var_16_3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_3 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_3) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_3 + var_16_8 and arg_13_1.time_ < var_16_3 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play114291004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114291004
		arg_17_1.duration_ = 16.27

		local var_17_0 = {
			ja = 16.266,
			ko = 10.7,
			zh = 13.933,
			en = 13.666
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
				arg_17_0:Play114291005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10016"]) then
				local var_20_0 = arg_17_1.actors_["10016"]:GetComponent("Image")

				if var_20_0 then
					arg_17_1.var_.highlightMatValue10016 = var_20_0
				end
			end

			local var_20_1 = 0.034

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 and not isNil(arg_17_1.actors_["10016"]) then
				if arg_17_1.var_.highlightMatValue10016 then
					local var_20_2 = Mathf.Lerp(0.5, 1, (arg_17_1.time_ - 0) / var_20_1)

					arg_17_1.var_.highlightMatValue10016.color.r = var_20_2
					arg_17_1.var_.highlightMatValue10016.color.g = var_20_2
					arg_17_1.var_.highlightMatValue10016.color.b = var_20_2
					arg_17_1.var_.highlightMatValue10016.color = arg_17_1.var_.highlightMatValue10016.color
				end
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 and not isNil(arg_17_1.actors_["10016"]) and arg_17_1.var_.highlightMatValue10016 then
				arg_17_1.actors_["10016"].transform:SetSiblingIndex(1)

				arg_17_1.var_.highlightMatValue10016.color.r = 1
				arg_17_1.var_.highlightMatValue10016.color.g = 1
				arg_17_1.var_.highlightMatValue10016.color.b = 1
				arg_17_1.var_.highlightMatValue10016.color = arg_17_1.var_.highlightMatValue10016.color
			end

			local var_20_3 = 0
			local var_20_4 = 1.275

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_3 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_5 = arg_17_1:GetWordFromCfg(114291004)
				local var_20_6 = arg_17_1:FormatText(var_20_5.content)

				arg_17_1.text_.text = var_20_6

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_8 = 51 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_6) / 51)

				if (51 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_6) / 51)) > 0 and var_20_4 < var_20_8 then
					arg_17_1.talkMaxDuration = var_20_8

					if var_20_8 + var_20_3 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_3
					end
				end

				arg_17_1.text_.text = var_20_6
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291004", "story_v_out_114291.awb") ~= 0 then
					local var_20_9 = manager.audio:GetVoiceLength("story_v_out_114291", "114291004", "story_v_out_114291.awb") / 1000

					if var_20_9 + var_20_3 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_3
					end

					if var_20_5.prefab_name ~= "" and arg_17_1.actors_[var_20_5.prefab_name] ~= nil then
						local var_20_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_5.prefab_name].transform, "story_v_out_114291", "114291004", "story_v_out_114291.awb")

						arg_17_1:RecordAudio("114291004", var_20_10)
						arg_17_1:RecordAudio("114291004", var_20_10)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_114291", "114291004", "story_v_out_114291.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_114291", "114291004", "story_v_out_114291.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_11 = math.max(var_20_4, arg_17_1.talkMaxDuration)

			if var_20_3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_3 + var_20_11 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_3) / var_20_11

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_3 + var_20_11 and arg_17_1.time_ < var_20_3 + var_20_11 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play114291005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114291005
		arg_21_1.duration_ = 10.93

		local var_21_0 = {
			ja = 10.933,
			ko = 10.266,
			zh = 8.833,
			en = 10.9
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
				arg_21_0:Play114291006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10016"]) then
				local var_24_0 = arg_21_1.actors_["10016"]:GetComponent("Image")

				if var_24_0 then
					arg_21_1.var_.highlightMatValue10016 = var_24_0
				end
			end

			local var_24_1 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_1 and not isNil(arg_21_1.actors_["10016"]) then
				if arg_21_1.var_.highlightMatValue10016 then
					local var_24_2 = Mathf.Lerp(1, 0.5, (arg_21_1.time_ - 0) / var_24_1)

					arg_21_1.var_.highlightMatValue10016.color.r = var_24_2
					arg_21_1.var_.highlightMatValue10016.color.g = var_24_2
					arg_21_1.var_.highlightMatValue10016.color.b = var_24_2
					arg_21_1.var_.highlightMatValue10016.color = arg_21_1.var_.highlightMatValue10016.color
				end
			end

			if arg_21_1.time_ >= 0 + var_24_1 and arg_21_1.time_ < 0 + var_24_1 + arg_24_0 and not isNil(arg_21_1.actors_["10016"]) and arg_21_1.var_.highlightMatValue10016 then
				arg_21_1.var_.highlightMatValue10016.color.r = 0.5
				arg_21_1.var_.highlightMatValue10016.color.g = 0.5
				arg_21_1.var_.highlightMatValue10016.color.b = 0.5
				arg_21_1.var_.highlightMatValue10016.color = arg_21_1.var_.highlightMatValue10016.color
			end

			local var_24_3 = arg_21_1.actors_["10020"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_3) then
				local var_24_4 = var_24_3:GetComponent("Image")

				if var_24_4 then
					arg_21_1.var_.highlightMatValue10020 = var_24_4
				end
			end

			local var_24_5 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_5 and not isNil(var_24_3) then
				if arg_21_1.var_.highlightMatValue10020 then
					local var_24_6 = Mathf.Lerp(0.5, 1, (arg_21_1.time_ - 0) / var_24_5)

					arg_21_1.var_.highlightMatValue10020.color.r = var_24_6
					arg_21_1.var_.highlightMatValue10020.color.g = var_24_6
					arg_21_1.var_.highlightMatValue10020.color.b = var_24_6
					arg_21_1.var_.highlightMatValue10020.color = arg_21_1.var_.highlightMatValue10020.color
				end
			end

			if arg_21_1.time_ >= 0 + var_24_5 and arg_21_1.time_ < 0 + var_24_5 + arg_24_0 and not isNil(var_24_3) and arg_21_1.var_.highlightMatValue10020 then
				var_24_3.transform:SetSiblingIndex(1)

				arg_21_1.var_.highlightMatValue10020.color.r = 1
				arg_21_1.var_.highlightMatValue10020.color.g = 1
				arg_21_1.var_.highlightMatValue10020.color.b = 1
				arg_21_1.var_.highlightMatValue10020.color = arg_21_1.var_.highlightMatValue10020.color
			end

			local var_24_7 = 0
			local var_24_8 = 0.7

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_7 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_9 = arg_21_1:GetWordFromCfg(114291005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_12 = 28 <= 0 and var_24_8 or var_24_8 * (utf8.len(var_24_10) / 28)

				if (28 <= 0 and var_24_8 or var_24_8 * (utf8.len(var_24_10) / 28)) > 0 and var_24_8 < var_24_12 then
					arg_21_1.talkMaxDuration = var_24_12

					if var_24_12 + var_24_7 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_7
					end
				end

				arg_21_1.text_.text = var_24_10
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291005", "story_v_out_114291.awb") ~= 0 then
					local var_24_13 = manager.audio:GetVoiceLength("story_v_out_114291", "114291005", "story_v_out_114291.awb") / 1000

					if var_24_13 + var_24_7 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_7
					end

					if var_24_9.prefab_name ~= "" and arg_21_1.actors_[var_24_9.prefab_name] ~= nil then
						local var_24_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_9.prefab_name].transform, "story_v_out_114291", "114291005", "story_v_out_114291.awb")

						arg_21_1:RecordAudio("114291005", var_24_14)
						arg_21_1:RecordAudio("114291005", var_24_14)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_114291", "114291005", "story_v_out_114291.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_114291", "114291005", "story_v_out_114291.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_15 = math.max(var_24_8, arg_21_1.talkMaxDuration)

			if var_24_7 <= arg_21_1.time_ and arg_21_1.time_ < var_24_7 + var_24_15 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_7) / var_24_15

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_7 + var_24_15 and arg_21_1.time_ < var_24_7 + var_24_15 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play114291006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114291006
		arg_25_1.duration_ = 12.7

		local var_25_0 = {
			ja = 12.7,
			ko = 9.433,
			zh = 10.766,
			en = 8.166
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
				arg_25_0:Play114291007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10016"]) then
				local var_28_0 = arg_25_1.actors_["10016"]:GetComponent("Image")

				if var_28_0 then
					arg_25_1.var_.highlightMatValue10016 = var_28_0
				end
			end

			local var_28_1 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 and not isNil(arg_25_1.actors_["10016"]) then
				if arg_25_1.var_.highlightMatValue10016 then
					local var_28_2 = Mathf.Lerp(0.5, 1, (arg_25_1.time_ - 0) / var_28_1)

					arg_25_1.var_.highlightMatValue10016.color.r = var_28_2
					arg_25_1.var_.highlightMatValue10016.color.g = var_28_2
					arg_25_1.var_.highlightMatValue10016.color.b = var_28_2
					arg_25_1.var_.highlightMatValue10016.color = arg_25_1.var_.highlightMatValue10016.color
				end
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 and not isNil(arg_25_1.actors_["10016"]) and arg_25_1.var_.highlightMatValue10016 then
				arg_25_1.actors_["10016"].transform:SetSiblingIndex(1)

				arg_25_1.var_.highlightMatValue10016.color.r = 1
				arg_25_1.var_.highlightMatValue10016.color.g = 1
				arg_25_1.var_.highlightMatValue10016.color.b = 1
				arg_25_1.var_.highlightMatValue10016.color = arg_25_1.var_.highlightMatValue10016.color
			end

			local var_28_3 = arg_25_1.actors_["10020"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_3) then
				local var_28_4 = var_28_3:GetComponent("Image")

				if var_28_4 then
					arg_25_1.var_.highlightMatValue10020 = var_28_4
				end
			end

			local var_28_5 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_5 and not isNil(var_28_3) then
				if arg_25_1.var_.highlightMatValue10020 then
					local var_28_6 = Mathf.Lerp(1, 0.5, (arg_25_1.time_ - 0) / var_28_5)

					arg_25_1.var_.highlightMatValue10020.color.r = var_28_6
					arg_25_1.var_.highlightMatValue10020.color.g = var_28_6
					arg_25_1.var_.highlightMatValue10020.color.b = var_28_6
					arg_25_1.var_.highlightMatValue10020.color = arg_25_1.var_.highlightMatValue10020.color
				end
			end

			if arg_25_1.time_ >= 0 + var_28_5 and arg_25_1.time_ < 0 + var_28_5 + arg_28_0 and not isNil(var_28_3) and arg_25_1.var_.highlightMatValue10020 then
				arg_25_1.var_.highlightMatValue10020.color.r = 0.5
				arg_25_1.var_.highlightMatValue10020.color.g = 0.5
				arg_25_1.var_.highlightMatValue10020.color.b = 0.5
				arg_25_1.var_.highlightMatValue10020.color = arg_25_1.var_.highlightMatValue10020.color
			end

			local var_28_7 = 0
			local var_28_8 = 0.95

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_9 = arg_25_1:GetWordFromCfg(114291006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_12 = 38 <= 0 and var_28_8 or var_28_8 * (utf8.len(var_28_10) / 38)

				if (38 <= 0 and var_28_8 or var_28_8 * (utf8.len(var_28_10) / 38)) > 0 and var_28_8 < var_28_12 then
					arg_25_1.talkMaxDuration = var_28_12

					if var_28_12 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_7
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291006", "story_v_out_114291.awb") ~= 0 then
					local var_28_13 = manager.audio:GetVoiceLength("story_v_out_114291", "114291006", "story_v_out_114291.awb") / 1000

					if var_28_13 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_7
					end

					if var_28_9.prefab_name ~= "" and arg_25_1.actors_[var_28_9.prefab_name] ~= nil then
						local var_28_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_9.prefab_name].transform, "story_v_out_114291", "114291006", "story_v_out_114291.awb")

						arg_25_1:RecordAudio("114291006", var_28_14)
						arg_25_1:RecordAudio("114291006", var_28_14)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_114291", "114291006", "story_v_out_114291.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_114291", "114291006", "story_v_out_114291.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_15 = math.max(var_28_8, arg_25_1.talkMaxDuration)

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_15 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_7) / var_28_15

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_7 + var_28_15 and arg_25_1.time_ < var_28_7 + var_28_15 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play114291007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114291007
		arg_29_1.duration_ = 5.9

		local var_29_0 = {
			ja = 5.9,
			ko = 4.333,
			zh = 3.366,
			en = 2.9
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
				arg_29_0:Play114291008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10016"]) then
				local var_32_0 = arg_29_1.actors_["10016"]:GetComponent("Image")

				if var_32_0 then
					arg_29_1.var_.highlightMatValue10016 = var_32_0
				end
			end

			local var_32_1 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 and not isNil(arg_29_1.actors_["10016"]) then
				if arg_29_1.var_.highlightMatValue10016 then
					local var_32_2 = Mathf.Lerp(1, 0.5, (arg_29_1.time_ - 0) / var_32_1)

					arg_29_1.var_.highlightMatValue10016.color.r = var_32_2
					arg_29_1.var_.highlightMatValue10016.color.g = var_32_2
					arg_29_1.var_.highlightMatValue10016.color.b = var_32_2
					arg_29_1.var_.highlightMatValue10016.color = arg_29_1.var_.highlightMatValue10016.color
				end
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 and not isNil(arg_29_1.actors_["10016"]) and arg_29_1.var_.highlightMatValue10016 then
				arg_29_1.var_.highlightMatValue10016.color.r = 0.5
				arg_29_1.var_.highlightMatValue10016.color.g = 0.5
				arg_29_1.var_.highlightMatValue10016.color.b = 0.5
				arg_29_1.var_.highlightMatValue10016.color = arg_29_1.var_.highlightMatValue10016.color
			end

			local var_32_3 = arg_29_1.actors_["10020"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_3) then
				local var_32_4 = var_32_3:GetComponent("Image")

				if var_32_4 then
					arg_29_1.var_.highlightMatValue10020 = var_32_4
				end
			end

			local var_32_5 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_5 and not isNil(var_32_3) then
				if arg_29_1.var_.highlightMatValue10020 then
					local var_32_6 = Mathf.Lerp(0.5, 1, (arg_29_1.time_ - 0) / var_32_5)

					arg_29_1.var_.highlightMatValue10020.color.r = var_32_6
					arg_29_1.var_.highlightMatValue10020.color.g = var_32_6
					arg_29_1.var_.highlightMatValue10020.color.b = var_32_6
					arg_29_1.var_.highlightMatValue10020.color = arg_29_1.var_.highlightMatValue10020.color
				end
			end

			if arg_29_1.time_ >= 0 + var_32_5 and arg_29_1.time_ < 0 + var_32_5 + arg_32_0 and not isNil(var_32_3) and arg_29_1.var_.highlightMatValue10020 then
				var_32_3.transform:SetSiblingIndex(1)

				arg_29_1.var_.highlightMatValue10020.color.r = 1
				arg_29_1.var_.highlightMatValue10020.color.g = 1
				arg_29_1.var_.highlightMatValue10020.color.b = 1
				arg_29_1.var_.highlightMatValue10020.color = arg_29_1.var_.highlightMatValue10020.color
			end

			local var_32_7 = 0
			local var_32_8 = 0.35

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_9 = arg_29_1:GetWordFromCfg(114291007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_12 = 14 <= 0 and var_32_8 or var_32_8 * (utf8.len(var_32_10) / 14)

				if (14 <= 0 and var_32_8 or var_32_8 * (utf8.len(var_32_10) / 14)) > 0 and var_32_8 < var_32_12 then
					arg_29_1.talkMaxDuration = var_32_12

					if var_32_12 + var_32_7 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_7
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291007", "story_v_out_114291.awb") ~= 0 then
					local var_32_13 = manager.audio:GetVoiceLength("story_v_out_114291", "114291007", "story_v_out_114291.awb") / 1000

					if var_32_13 + var_32_7 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_7
					end

					if var_32_9.prefab_name ~= "" and arg_29_1.actors_[var_32_9.prefab_name] ~= nil then
						local var_32_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_9.prefab_name].transform, "story_v_out_114291", "114291007", "story_v_out_114291.awb")

						arg_29_1:RecordAudio("114291007", var_32_14)
						arg_29_1:RecordAudio("114291007", var_32_14)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_114291", "114291007", "story_v_out_114291.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_114291", "114291007", "story_v_out_114291.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_15 = math.max(var_32_8, arg_29_1.talkMaxDuration)

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_15 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_7) / var_32_15

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_7 + var_32_15 and arg_29_1.time_ < var_32_7 + var_32_15 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play114291008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114291008
		arg_33_1.duration_ = 17.6

		local var_33_0 = {
			ja = 13.233,
			ko = 15.9,
			zh = 16.033,
			en = 17.6
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
				arg_33_0:Play114291009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10016"]) then
				local var_36_0 = arg_33_1.actors_["10016"]:GetComponent("Image")

				if var_36_0 then
					arg_33_1.var_.highlightMatValue10016 = var_36_0
				end
			end

			local var_36_1 = 0.034

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 and not isNil(arg_33_1.actors_["10016"]) then
				if arg_33_1.var_.highlightMatValue10016 then
					local var_36_2 = Mathf.Lerp(0.5, 1, (arg_33_1.time_ - 0) / var_36_1)

					arg_33_1.var_.highlightMatValue10016.color.r = var_36_2
					arg_33_1.var_.highlightMatValue10016.color.g = var_36_2
					arg_33_1.var_.highlightMatValue10016.color.b = var_36_2
					arg_33_1.var_.highlightMatValue10016.color = arg_33_1.var_.highlightMatValue10016.color
				end
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 and not isNil(arg_33_1.actors_["10016"]) and arg_33_1.var_.highlightMatValue10016 then
				arg_33_1.actors_["10016"].transform:SetSiblingIndex(1)

				arg_33_1.var_.highlightMatValue10016.color.r = 1
				arg_33_1.var_.highlightMatValue10016.color.g = 1
				arg_33_1.var_.highlightMatValue10016.color.b = 1
				arg_33_1.var_.highlightMatValue10016.color = arg_33_1.var_.highlightMatValue10016.color
			end

			local var_36_3 = arg_33_1.actors_["10020"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_3) then
				local var_36_4 = var_36_3:GetComponent("Image")

				if var_36_4 then
					arg_33_1.var_.highlightMatValue10020 = var_36_4
				end
			end

			local var_36_5 = 0.034

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 and not isNil(var_36_3) then
				if arg_33_1.var_.highlightMatValue10020 then
					local var_36_6 = Mathf.Lerp(1, 0.5, (arg_33_1.time_ - 0) / var_36_5)

					arg_33_1.var_.highlightMatValue10020.color.r = var_36_6
					arg_33_1.var_.highlightMatValue10020.color.g = var_36_6
					arg_33_1.var_.highlightMatValue10020.color.b = var_36_6
					arg_33_1.var_.highlightMatValue10020.color = arg_33_1.var_.highlightMatValue10020.color
				end
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.highlightMatValue10020 then
				arg_33_1.var_.highlightMatValue10020.color.r = 0.5
				arg_33_1.var_.highlightMatValue10020.color.g = 0.5
				arg_33_1.var_.highlightMatValue10020.color.b = 0.5
				arg_33_1.var_.highlightMatValue10020.color = arg_33_1.var_.highlightMatValue10020.color
			end

			local var_36_7 = 0
			local var_36_8 = 1.325

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_9 = arg_33_1:GetWordFromCfg(114291008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_12 = 53 <= 0 and var_36_8 or var_36_8 * (utf8.len(var_36_10) / 53)

				if (53 <= 0 and var_36_8 or var_36_8 * (utf8.len(var_36_10) / 53)) > 0 and var_36_8 < var_36_12 then
					arg_33_1.talkMaxDuration = var_36_12

					if var_36_12 + var_36_7 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_7
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291008", "story_v_out_114291.awb") ~= 0 then
					local var_36_13 = manager.audio:GetVoiceLength("story_v_out_114291", "114291008", "story_v_out_114291.awb") / 1000

					if var_36_13 + var_36_7 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_7
					end

					if var_36_9.prefab_name ~= "" and arg_33_1.actors_[var_36_9.prefab_name] ~= nil then
						local var_36_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_9.prefab_name].transform, "story_v_out_114291", "114291008", "story_v_out_114291.awb")

						arg_33_1:RecordAudio("114291008", var_36_14)
						arg_33_1:RecordAudio("114291008", var_36_14)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_114291", "114291008", "story_v_out_114291.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_114291", "114291008", "story_v_out_114291.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_15 = math.max(var_36_8, arg_33_1.talkMaxDuration)

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_15 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_7) / var_36_15

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_7 + var_36_15 and arg_33_1.time_ < var_36_7 + var_36_15 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play114291009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114291009
		arg_37_1.duration_ = 12.33

		local var_37_0 = {
			ja = 6.666,
			ko = 12.3,
			zh = 12.333,
			en = 9.866
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
				arg_37_0:Play114291010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["10016"]) then
				local var_40_0 = arg_37_1.actors_["10016"]:GetComponent("Image")

				if var_40_0 then
					arg_37_1.var_.highlightMatValue10016 = var_40_0
				end
			end

			local var_40_1 = 0.034

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 and not isNil(arg_37_1.actors_["10016"]) then
				if arg_37_1.var_.highlightMatValue10016 then
					local var_40_2 = Mathf.Lerp(1, 0.5, (arg_37_1.time_ - 0) / var_40_1)

					arg_37_1.var_.highlightMatValue10016.color.r = var_40_2
					arg_37_1.var_.highlightMatValue10016.color.g = var_40_2
					arg_37_1.var_.highlightMatValue10016.color.b = var_40_2
					arg_37_1.var_.highlightMatValue10016.color = arg_37_1.var_.highlightMatValue10016.color
				end
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 and not isNil(arg_37_1.actors_["10016"]) and arg_37_1.var_.highlightMatValue10016 then
				arg_37_1.var_.highlightMatValue10016.color.r = 0.5
				arg_37_1.var_.highlightMatValue10016.color.g = 0.5
				arg_37_1.var_.highlightMatValue10016.color.b = 0.5
				arg_37_1.var_.highlightMatValue10016.color = arg_37_1.var_.highlightMatValue10016.color
			end

			local var_40_3 = arg_37_1.actors_["10020"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_3) then
				local var_40_4 = var_40_3:GetComponent("Image")

				if var_40_4 then
					arg_37_1.var_.highlightMatValue10020 = var_40_4
				end
			end

			local var_40_5 = 0.034

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_5 and not isNil(var_40_3) then
				if arg_37_1.var_.highlightMatValue10020 then
					local var_40_6 = Mathf.Lerp(0.5, 1, (arg_37_1.time_ - 0) / var_40_5)

					arg_37_1.var_.highlightMatValue10020.color.r = var_40_6
					arg_37_1.var_.highlightMatValue10020.color.g = var_40_6
					arg_37_1.var_.highlightMatValue10020.color.b = var_40_6
					arg_37_1.var_.highlightMatValue10020.color = arg_37_1.var_.highlightMatValue10020.color
				end
			end

			if arg_37_1.time_ >= 0 + var_40_5 and arg_37_1.time_ < 0 + var_40_5 + arg_40_0 and not isNil(var_40_3) and arg_37_1.var_.highlightMatValue10020 then
				var_40_3.transform:SetSiblingIndex(1)

				arg_37_1.var_.highlightMatValue10020.color.r = 1
				arg_37_1.var_.highlightMatValue10020.color.g = 1
				arg_37_1.var_.highlightMatValue10020.color.b = 1
				arg_37_1.var_.highlightMatValue10020.color = arg_37_1.var_.highlightMatValue10020.color
			end

			local var_40_7 = 0
			local var_40_8 = 1.15

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_9 = arg_37_1:GetWordFromCfg(114291009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_12 = 46 <= 0 and var_40_8 or var_40_8 * (utf8.len(var_40_10) / 46)

				if (46 <= 0 and var_40_8 or var_40_8 * (utf8.len(var_40_10) / 46)) > 0 and var_40_8 < var_40_12 then
					arg_37_1.talkMaxDuration = var_40_12

					if var_40_12 + var_40_7 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_7
					end
				end

				arg_37_1.text_.text = var_40_10
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291009", "story_v_out_114291.awb") ~= 0 then
					local var_40_13 = manager.audio:GetVoiceLength("story_v_out_114291", "114291009", "story_v_out_114291.awb") / 1000

					if var_40_13 + var_40_7 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_7
					end

					if var_40_9.prefab_name ~= "" and arg_37_1.actors_[var_40_9.prefab_name] ~= nil then
						local var_40_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_9.prefab_name].transform, "story_v_out_114291", "114291009", "story_v_out_114291.awb")

						arg_37_1:RecordAudio("114291009", var_40_14)
						arg_37_1:RecordAudio("114291009", var_40_14)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_114291", "114291009", "story_v_out_114291.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_114291", "114291009", "story_v_out_114291.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_15 = math.max(var_40_8, arg_37_1.talkMaxDuration)

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_15 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_7) / var_40_15

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_7 + var_40_15 and arg_37_1.time_ < var_40_7 + var_40_15 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play114291010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114291010
		arg_41_1.duration_ = 6.33

		local var_41_0 = {
			ja = 6.333,
			ko = 5.2,
			zh = 3.866,
			en = 3.466
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
				arg_41_0:Play114291011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.425

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:GetWordFromCfg(114291010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 17 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 17)

				if (17 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 17)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291010", "story_v_out_114291.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_114291", "114291010", "story_v_out_114291.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_114291", "114291010", "story_v_out_114291.awb")

						arg_41_1:RecordAudio("114291010", var_44_6)
						arg_41_1:RecordAudio("114291010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_114291", "114291010", "story_v_out_114291.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_114291", "114291010", "story_v_out_114291.awb")
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
	Play114291011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114291011
		arg_45_1.duration_ = 3.37

		local var_45_0 = {
			ja = 3.366,
			ko = 2.5,
			zh = 3,
			en = 2.666
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
				arg_45_0:Play114291012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10016"]) then
				local var_48_0 = arg_45_1.actors_["10016"]:GetComponent("Image")

				if var_48_0 then
					arg_45_1.var_.highlightMatValue10016 = var_48_0
				end
			end

			local var_48_1 = 0.034

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 and not isNil(arg_45_1.actors_["10016"]) then
				if arg_45_1.var_.highlightMatValue10016 then
					local var_48_2 = Mathf.Lerp(0.5, 1, (arg_45_1.time_ - 0) / var_48_1)

					arg_45_1.var_.highlightMatValue10016.color.r = var_48_2
					arg_45_1.var_.highlightMatValue10016.color.g = var_48_2
					arg_45_1.var_.highlightMatValue10016.color.b = var_48_2
					arg_45_1.var_.highlightMatValue10016.color = arg_45_1.var_.highlightMatValue10016.color
				end
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 and not isNil(arg_45_1.actors_["10016"]) and arg_45_1.var_.highlightMatValue10016 then
				arg_45_1.actors_["10016"].transform:SetSiblingIndex(1)

				arg_45_1.var_.highlightMatValue10016.color.r = 1
				arg_45_1.var_.highlightMatValue10016.color.g = 1
				arg_45_1.var_.highlightMatValue10016.color.b = 1
				arg_45_1.var_.highlightMatValue10016.color = arg_45_1.var_.highlightMatValue10016.color
			end

			local var_48_3 = arg_45_1.actors_["10020"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_3) then
				local var_48_4 = var_48_3:GetComponent("Image")

				if var_48_4 then
					arg_45_1.var_.highlightMatValue10020 = var_48_4
				end
			end

			local var_48_5 = 0.034

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 and not isNil(var_48_3) then
				if arg_45_1.var_.highlightMatValue10020 then
					local var_48_6 = Mathf.Lerp(1, 0.5, (arg_45_1.time_ - 0) / var_48_5)

					arg_45_1.var_.highlightMatValue10020.color.r = var_48_6
					arg_45_1.var_.highlightMatValue10020.color.g = var_48_6
					arg_45_1.var_.highlightMatValue10020.color.b = var_48_6
					arg_45_1.var_.highlightMatValue10020.color = arg_45_1.var_.highlightMatValue10020.color
				end
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 and not isNil(var_48_3) and arg_45_1.var_.highlightMatValue10020 then
				arg_45_1.var_.highlightMatValue10020.color.r = 0.5
				arg_45_1.var_.highlightMatValue10020.color.g = 0.5
				arg_45_1.var_.highlightMatValue10020.color.b = 0.5
				arg_45_1.var_.highlightMatValue10020.color = arg_45_1.var_.highlightMatValue10020.color
			end

			local var_48_7 = 0
			local var_48_8 = 0.175

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_9 = arg_45_1:GetWordFromCfg(114291011)
				local var_48_10 = arg_45_1:FormatText(var_48_9.content)

				arg_45_1.text_.text = var_48_10

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_12 = 7 <= 0 and var_48_8 or var_48_8 * (utf8.len(var_48_10) / 7)

				if (7 <= 0 and var_48_8 or var_48_8 * (utf8.len(var_48_10) / 7)) > 0 and var_48_8 < var_48_12 then
					arg_45_1.talkMaxDuration = var_48_12

					if var_48_12 + var_48_7 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_7
					end
				end

				arg_45_1.text_.text = var_48_10
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291011", "story_v_out_114291.awb") ~= 0 then
					local var_48_13 = manager.audio:GetVoiceLength("story_v_out_114291", "114291011", "story_v_out_114291.awb") / 1000

					if var_48_13 + var_48_7 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_7
					end

					if var_48_9.prefab_name ~= "" and arg_45_1.actors_[var_48_9.prefab_name] ~= nil then
						local var_48_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_9.prefab_name].transform, "story_v_out_114291", "114291011", "story_v_out_114291.awb")

						arg_45_1:RecordAudio("114291011", var_48_14)
						arg_45_1:RecordAudio("114291011", var_48_14)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_114291", "114291011", "story_v_out_114291.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_114291", "114291011", "story_v_out_114291.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_15 = math.max(var_48_8, arg_45_1.talkMaxDuration)

			if var_48_7 <= arg_45_1.time_ and arg_45_1.time_ < var_48_7 + var_48_15 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_7) / var_48_15

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_7 + var_48_15 and arg_45_1.time_ < var_48_7 + var_48_15 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play114291012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114291012
		arg_49_1.duration_ = 17.43

		local var_49_0 = {
			ja = 17.433,
			ko = 16,
			zh = 15.533,
			en = 15.833
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
				arg_49_0:Play114291013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if arg_49_1.bgs_.OM0503 == nil then
				local var_52_0 = Object.Instantiate(arg_49_1.paintGo_)

				var_52_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "OM0503")
				var_52_0.name = "OM0503"
				var_52_0.transform.parent = arg_49_1.stage_.transform
				var_52_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_49_1.bgs_.OM0503 = var_52_0
			end

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= 2 + arg_52_0 then
				local var_52_1 = arg_49_1.bgs_.OM0503

				arg_49_1.bgs_.OM0503.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_52_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_52_2 = var_52_1:GetComponent("SpriteRenderer")

				if var_52_2 and var_52_2.sprite then
					local var_52_3 = 2 * (var_52_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_52_1.transform.localScale = Vector3.New(var_52_3 / var_52_2.sprite.bounds.size.y < var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x and var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x or var_52_3 / var_52_2.sprite.bounds.size.y, var_52_3 / var_52_2.sprite.bounds.size.y < var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x and var_52_3 * manager.ui.mainCameraCom_.aspect / var_52_2.sprite.bounds.size.x or var_52_3 / var_52_2.sprite.bounds.size.y, 0)
				end

				for iter_52_0, iter_52_1 in pairs(arg_49_1.bgs_) do
					if iter_52_0 ~= "OM0503" then
						iter_52_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_52_4 = 0

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_5 = 2

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_5 then
				local var_52_6 = Color.New(0, 0, 0)

				var_52_6.a = Mathf.Lerp(0, 1, (arg_49_1.time_ - var_52_4) / var_52_5)
				arg_49_1.mask_.color = var_52_6
			end

			if arg_49_1.time_ >= var_52_4 + var_52_5 and arg_49_1.time_ < var_52_4 + var_52_5 + arg_52_0 then
				local var_52_7 = Color.New(0, 0, 0)

				var_52_7.a = 1
				arg_49_1.mask_.color = var_52_7
			end

			local var_52_8 = 2

			if 2 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_9 = 2

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 then
				local var_52_10 = Color.New(0, 0, 0)

				var_52_10.a = Mathf.Lerp(1, 0, (arg_49_1.time_ - var_52_8) / var_52_9)
				arg_49_1.mask_.color = var_52_10
			end

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 then
				local var_52_11 = Color.New(0, 0, 0)

				arg_49_1.mask_.enabled = false
				var_52_11.a = 0
				arg_49_1.mask_.color = var_52_11
			end

			if 1.5 < arg_49_1.time_ and arg_49_1.time_ <= 1.5 + arg_52_0 then
				local var_52_12 = arg_49_1.actors_["10020"]:GetComponent("Image")

				if var_52_12 then
					arg_49_1.var_.alphaMatValue10020 = var_52_12
					arg_49_1.var_.alphaOldValue10020 = var_52_12.color.a
				end

				arg_49_1.var_.alphaOldValue10020 = 1
			end

			local var_52_13 = 0.5

			if 1.5 <= arg_49_1.time_ and arg_49_1.time_ < 1.5 + var_52_13 then
				if arg_49_1.var_.alphaMatValue10020 then
					arg_49_1.var_.alphaMatValue10020.color.a = Mathf.Lerp(arg_49_1.var_.alphaOldValue10020, 0, (arg_49_1.time_ - 1.5) / var_52_13)
					arg_49_1.var_.alphaMatValue10020.color = arg_49_1.var_.alphaMatValue10020.color
				end
			end

			if arg_49_1.time_ >= 1.5 + var_52_13 and arg_49_1.time_ < 1.5 + var_52_13 + arg_52_0 and arg_49_1.var_.alphaMatValue10020 then
				arg_49_1.var_.alphaMatValue10020.color.a = 0
				arg_49_1.var_.alphaMatValue10020.color = arg_49_1.var_.alphaMatValue10020.color
			end

			if 1.5 < arg_49_1.time_ and arg_49_1.time_ <= 1.5 + arg_52_0 then
				local var_52_14 = arg_49_1.actors_["10016"]:GetComponent("Image")

				if var_52_14 then
					arg_49_1.var_.alphaMatValue10016 = var_52_14
					arg_49_1.var_.alphaOldValue10016 = var_52_14.color.a
				end

				arg_49_1.var_.alphaOldValue10016 = 1
			end

			local var_52_15 = 0.5

			if 1.5 <= arg_49_1.time_ and arg_49_1.time_ < 1.5 + var_52_15 then
				if arg_49_1.var_.alphaMatValue10016 then
					arg_49_1.var_.alphaMatValue10016.color.a = Mathf.Lerp(arg_49_1.var_.alphaOldValue10016, 0, (arg_49_1.time_ - 1.5) / var_52_15)
					arg_49_1.var_.alphaMatValue10016.color = arg_49_1.var_.alphaMatValue10016.color
				end
			end

			if arg_49_1.time_ >= 1.5 + var_52_15 and arg_49_1.time_ < 1.5 + var_52_15 + arg_52_0 and arg_49_1.var_.alphaMatValue10016 then
				arg_49_1.var_.alphaMatValue10016.color.a = 0
				arg_49_1.var_.alphaMatValue10016.color = arg_49_1.var_.alphaMatValue10016.color
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_16 = 4
			local var_52_17 = 1.075

			if 4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_16 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_18 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_18:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_19 = arg_49_1:GetWordFromCfg(114291012)
				local var_52_20 = arg_49_1:FormatText(var_52_19.content)

				arg_49_1.text_.text = var_52_20

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_22 = 43 <= 0 and var_52_17 or var_52_17 * (utf8.len(var_52_20) / 43)

				if (43 <= 0 and var_52_17 or var_52_17 * (utf8.len(var_52_20) / 43)) > 0 and var_52_17 < var_52_22 then
					arg_49_1.talkMaxDuration = var_52_22
					var_52_16 = var_52_16 + 0.3

					if var_52_22 + var_52_16 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_22 + var_52_16
					end
				end

				arg_49_1.text_.text = var_52_20
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291012", "story_v_out_114291.awb") ~= 0 then
					local var_52_23 = manager.audio:GetVoiceLength("story_v_out_114291", "114291012", "story_v_out_114291.awb") / 1000

					if var_52_23 + var_52_16 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_23 + var_52_16
					end

					if var_52_19.prefab_name ~= "" and arg_49_1.actors_[var_52_19.prefab_name] ~= nil then
						local var_52_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_19.prefab_name].transform, "story_v_out_114291", "114291012", "story_v_out_114291.awb")

						arg_49_1:RecordAudio("114291012", var_52_24)
						arg_49_1:RecordAudio("114291012", var_52_24)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_114291", "114291012", "story_v_out_114291.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_114291", "114291012", "story_v_out_114291.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_25 = var_52_16 + 0.3
			local var_52_26 = math.max(var_52_17, arg_49_1.talkMaxDuration)

			if var_52_16 + 0.3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_25 + var_52_26 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_25) / var_52_26

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_25 + var_52_26 and arg_49_1.time_ < var_52_25 + var_52_26 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play114291013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 114291013
		arg_55_1.duration_ = 19.7

		local var_55_0 = {
			ja = 16.1,
			ko = 18.333,
			zh = 19.7,
			en = 18.433
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
				arg_55_0:Play114291014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 1.575

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_1 = arg_55_1:GetWordFromCfg(114291013)
				local var_58_2 = arg_55_1:FormatText(var_58_1.content)

				arg_55_1.text_.text = var_58_2

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 63 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 63)

				if (63 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_2) / 63)) > 0 and var_58_0 < var_58_4 then
					arg_55_1.talkMaxDuration = var_58_4

					if var_58_4 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_4 + 0
					end
				end

				arg_55_1.text_.text = var_58_2
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291013", "story_v_out_114291.awb") ~= 0 then
					local var_58_5 = manager.audio:GetVoiceLength("story_v_out_114291", "114291013", "story_v_out_114291.awb") / 1000

					if var_58_5 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + 0
					end

					if var_58_1.prefab_name ~= "" and arg_55_1.actors_[var_58_1.prefab_name] ~= nil then
						local var_58_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_1.prefab_name].transform, "story_v_out_114291", "114291013", "story_v_out_114291.awb")

						arg_55_1:RecordAudio("114291013", var_58_6)
						arg_55_1:RecordAudio("114291013", var_58_6)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_114291", "114291013", "story_v_out_114291.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_114291", "114291013", "story_v_out_114291.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play114291014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 114291014
		arg_59_1.duration_ = 22.9

		local var_59_0 = {
			ja = 22.9,
			ko = 16.6,
			zh = 18.733,
			en = 19.966
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
				arg_59_0:Play114291015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 1.825

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_1 = arg_59_1:GetWordFromCfg(114291014)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 74 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 74)

				if (74 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 74)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291014", "story_v_out_114291.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_out_114291", "114291014", "story_v_out_114291.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_out_114291", "114291014", "story_v_out_114291.awb")

						arg_59_1:RecordAudio("114291014", var_62_6)
						arg_59_1:RecordAudio("114291014", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_114291", "114291014", "story_v_out_114291.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_114291", "114291014", "story_v_out_114291.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play114291015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 114291015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play114291016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 1.475

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(114291015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 59 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 59)

				if (59 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 59)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play114291016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 114291016
		arg_67_1.duration_ = 26.2

		local var_67_0 = {
			ja = 26.2,
			ko = 21.9,
			zh = 18.7,
			en = 22.933
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
				arg_67_0:Play114291017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 1.8

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_1 = arg_67_1:GetWordFromCfg(114291016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 72 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 72)

				if (72 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 72)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291016", "story_v_out_114291.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_114291", "114291016", "story_v_out_114291.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_114291", "114291016", "story_v_out_114291.awb")

						arg_67_1:RecordAudio("114291016", var_70_6)
						arg_67_1:RecordAudio("114291016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_114291", "114291016", "story_v_out_114291.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_114291", "114291016", "story_v_out_114291.awb")
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
	Play114291017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 114291017
		arg_71_1.duration_ = 22.27

		local var_71_0 = {
			ja = 22.266,
			ko = 17.7,
			zh = 14.966,
			en = 15.766
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
				arg_71_0:Play114291018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 1.45

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_1 = arg_71_1:GetWordFromCfg(114291017)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 58 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 58)

				if (58 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 58)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291017", "story_v_out_114291.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_114291", "114291017", "story_v_out_114291.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_114291", "114291017", "story_v_out_114291.awb")

						arg_71_1:RecordAudio("114291017", var_74_6)
						arg_71_1:RecordAudio("114291017", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_114291", "114291017", "story_v_out_114291.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_114291", "114291017", "story_v_out_114291.awb")
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
	Play114291018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 114291018
		arg_75_1.duration_ = 16.63

		local var_75_0 = {
			ja = 13.366,
			ko = 14.466,
			zh = 16.466,
			en = 16.633
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
				arg_75_0:Play114291019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 1.475

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:GetWordFromCfg(114291018)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 59 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 59)

				if (59 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 59)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291018", "story_v_out_114291.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_out_114291", "114291018", "story_v_out_114291.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_out_114291", "114291018", "story_v_out_114291.awb")

						arg_75_1:RecordAudio("114291018", var_78_6)
						arg_75_1:RecordAudio("114291018", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_114291", "114291018", "story_v_out_114291.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_114291", "114291018", "story_v_out_114291.awb")
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
	Play114291019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 114291019
		arg_79_1.duration_ = 8.1

		local var_79_0 = {
			ja = 8.1,
			ko = 7.733,
			zh = 6.5,
			en = 7.566
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play114291020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0.675

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_1 = arg_79_1:GetWordFromCfg(114291019)
				local var_82_2 = arg_79_1:FormatText(var_82_1.content)

				arg_79_1.text_.text = var_82_2

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 27 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 27)

				if (27 <= 0 and var_82_0 or var_82_0 * (utf8.len(var_82_2) / 27)) > 0 and var_82_0 < var_82_4 then
					arg_79_1.talkMaxDuration = var_82_4

					if var_82_4 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_4 + 0
					end
				end

				arg_79_1.text_.text = var_82_2
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291019", "story_v_out_114291.awb") ~= 0 then
					local var_82_5 = manager.audio:GetVoiceLength("story_v_out_114291", "114291019", "story_v_out_114291.awb") / 1000

					if var_82_5 + 0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + 0
					end

					if var_82_1.prefab_name ~= "" and arg_79_1.actors_[var_82_1.prefab_name] ~= nil then
						local var_82_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_1.prefab_name].transform, "story_v_out_114291", "114291019", "story_v_out_114291.awb")

						arg_79_1:RecordAudio("114291019", var_82_6)
						arg_79_1:RecordAudio("114291019", var_82_6)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_114291", "114291019", "story_v_out_114291.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_114291", "114291019", "story_v_out_114291.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_0, arg_79_1.talkMaxDuration)

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - 0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play114291020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 114291020
		arg_83_1.duration_ = 8.27

		local var_83_0 = {
			ja = 8.266,
			ko = 6.933,
			zh = 7.1,
			en = 7.133
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
				arg_83_0:Play114291021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0.525

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:GetWordFromCfg(114291020)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 21 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 21)

				if (21 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 21)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291020", "story_v_out_114291.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_114291", "114291020", "story_v_out_114291.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_114291", "114291020", "story_v_out_114291.awb")

						arg_83_1:RecordAudio("114291020", var_86_6)
						arg_83_1:RecordAudio("114291020", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_114291", "114291020", "story_v_out_114291.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_114291", "114291020", "story_v_out_114291.awb")
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
	Play114291021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 114291021
		arg_87_1.duration_ = 24

		local var_87_0 = {
			ja = 24,
			ko = 11.6,
			zh = 16.4,
			en = 17.833
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
				arg_87_0:Play114291022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 1.325

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_1 = arg_87_1:GetWordFromCfg(114291021)
				local var_90_2 = arg_87_1:FormatText(var_90_1.content)

				arg_87_1.text_.text = var_90_2

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_4 = 53 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 53)

				if (53 <= 0 and var_90_0 or var_90_0 * (utf8.len(var_90_2) / 53)) > 0 and var_90_0 < var_90_4 then
					arg_87_1.talkMaxDuration = var_90_4

					if var_90_4 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_4 + 0
					end
				end

				arg_87_1.text_.text = var_90_2
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291021", "story_v_out_114291.awb") ~= 0 then
					local var_90_5 = manager.audio:GetVoiceLength("story_v_out_114291", "114291021", "story_v_out_114291.awb") / 1000

					if var_90_5 + 0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + 0
					end

					if var_90_1.prefab_name ~= "" and arg_87_1.actors_[var_90_1.prefab_name] ~= nil then
						local var_90_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_1.prefab_name].transform, "story_v_out_114291", "114291021", "story_v_out_114291.awb")

						arg_87_1:RecordAudio("114291021", var_90_6)
						arg_87_1:RecordAudio("114291021", var_90_6)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_114291", "114291021", "story_v_out_114291.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_114291", "114291021", "story_v_out_114291.awb")
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
	Play114291022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 114291022
		arg_91_1.duration_ = 19.17

		local var_91_0 = {
			ja = 19.166,
			ko = 14.7,
			zh = 19.1,
			en = 14.766
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
				arg_91_0:Play114291023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 1.125

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:GetWordFromCfg(114291022)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 45 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 45)

				if (45 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 45)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291022", "story_v_out_114291.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_out_114291", "114291022", "story_v_out_114291.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_out_114291", "114291022", "story_v_out_114291.awb")

						arg_91_1:RecordAudio("114291022", var_94_6)
						arg_91_1:RecordAudio("114291022", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_114291", "114291022", "story_v_out_114291.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_114291", "114291022", "story_v_out_114291.awb")
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
	Play114291023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 114291023
		arg_95_1.duration_ = 9

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play114291024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 2 < arg_95_1.time_ and arg_95_1.time_ <= 2 + arg_98_0 then
				local var_98_0 = arg_95_1.bgs_.ST26

				arg_95_1.bgs_.ST26.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_98_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_98_1 = var_98_0:GetComponent("SpriteRenderer")

				if var_98_1 and var_98_1.sprite then
					local var_98_2 = 2 * (var_98_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_98_0.transform.localScale = Vector3.New(var_98_2 / var_98_1.sprite.bounds.size.y < var_98_2 * manager.ui.mainCameraCom_.aspect / var_98_1.sprite.bounds.size.x and var_98_2 * manager.ui.mainCameraCom_.aspect / var_98_1.sprite.bounds.size.x or var_98_2 / var_98_1.sprite.bounds.size.y, var_98_2 / var_98_1.sprite.bounds.size.y < var_98_2 * manager.ui.mainCameraCom_.aspect / var_98_1.sprite.bounds.size.x and var_98_2 * manager.ui.mainCameraCom_.aspect / var_98_1.sprite.bounds.size.x or var_98_2 / var_98_1.sprite.bounds.size.y, 0)
				end

				for iter_98_0, iter_98_1 in pairs(arg_95_1.bgs_) do
					if iter_98_0 ~= "ST26" then
						iter_98_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_98_3 = 0

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_3 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_4 = 2

			if var_98_3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_3 + var_98_4 then
				local var_98_5 = Color.New(0, 0, 0)

				var_98_5.a = Mathf.Lerp(0, 1, (arg_95_1.time_ - var_98_3) / var_98_4)
				arg_95_1.mask_.color = var_98_5
			end

			if arg_95_1.time_ >= var_98_3 + var_98_4 and arg_95_1.time_ < var_98_3 + var_98_4 + arg_98_0 then
				local var_98_6 = Color.New(0, 0, 0)

				var_98_6.a = 1
				arg_95_1.mask_.color = var_98_6
			end

			local var_98_7 = 2

			if 2 < arg_95_1.time_ and arg_95_1.time_ <= var_98_7 + arg_98_0 then
				arg_95_1.mask_.enabled = true
				arg_95_1.mask_.raycastTarget = true

				arg_95_1:SetGaussion(false)
			end

			local var_98_8 = 2

			if var_98_7 <= arg_95_1.time_ and arg_95_1.time_ < var_98_7 + var_98_8 then
				local var_98_9 = Color.New(0, 0, 0)

				var_98_9.a = Mathf.Lerp(1, 0, (arg_95_1.time_ - var_98_7) / var_98_8)
				arg_95_1.mask_.color = var_98_9
			end

			if arg_95_1.time_ >= var_98_7 + var_98_8 and arg_95_1.time_ < var_98_7 + var_98_8 + arg_98_0 then
				local var_98_10 = Color.New(0, 0, 0)

				arg_95_1.mask_.enabled = false
				var_98_10.a = 0
				arg_95_1.mask_.color = var_98_10
			end

			if arg_95_1.frameCnt_ <= 1 then
				arg_95_1.dialog_:SetActive(false)
			end

			local var_98_11 = 4
			local var_98_12 = 0.05

			if 4 < arg_95_1.time_ and arg_95_1.time_ <= var_98_11 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0

				arg_95_1.dialog_:SetActive(true)

				arg_95_1.dialogCg_.alpha = 0

				local var_98_13 = LeanTween.value(arg_95_1.dialog_, 0, 1, 0.3)

				var_98_13:setOnUpdate(LuaHelper.FloatAction(function(arg_99_0)
					arg_95_1.dialogCg_.alpha = arg_99_0
				end))
				var_98_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_95_1.dialog_)
					var_98_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_95_1.duration_ = arg_95_1.duration_ + 0.3

				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_14 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(114291023).content)

				arg_95_1.text_.text = var_98_14

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_16 = 2 <= 0 and var_98_12 or var_98_12 * (utf8.len(var_98_14) / 2)

				if (2 <= 0 and var_98_12 or var_98_12 * (utf8.len(var_98_14) / 2)) > 0 and var_98_12 < var_98_16 then
					arg_95_1.talkMaxDuration = var_98_16
					var_98_11 = var_98_11 + 0.3

					if var_98_16 + var_98_11 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_16 + var_98_11
					end
				end

				arg_95_1.text_.text = var_98_14
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_17 = var_98_11 + 0.3
			local var_98_18 = math.max(var_98_12, arg_95_1.talkMaxDuration)

			if var_98_11 + 0.3 <= arg_95_1.time_ and arg_95_1.time_ < var_98_17 + var_98_18 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_17) / var_98_18

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_17 + var_98_18 and arg_95_1.time_ < var_98_17 + var_98_18 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play114291024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 114291024
		arg_101_1.duration_ = 1.63

		local var_101_0 = {
			ja = 1.633,
			ko = 1.566,
			zh = 1.066,
			en = 1.333
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
				arg_101_0:Play114291025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if arg_101_1.actors_["10015"] == nil then
				local var_104_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10015")

				if not isNil(var_104_0) then
					local var_104_1 = Object.Instantiate(var_104_0, arg_101_1.canvasGo_.transform)

					var_104_1.transform:SetSiblingIndex(1)

					var_104_1.name = "10015"
					var_104_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_101_1.actors_["10015"] = var_104_1

					if arg_101_1.isInRecall_ then
						for iter_104_0, iter_104_1 in ipairs((var_104_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_104_1.color = arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_104_2 = arg_101_1.actors_["10015"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10015 = var_104_2.localPosition
				var_104_2.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10015", 4)

				for iter_104_2 = 0, var_104_2.childCount - 1 do
					local var_104_3 = var_104_2:GetChild(iter_104_2)

					if var_104_3.name == "split_1" or not string.find(var_104_3.name, "split") then
						var_104_3.gameObject:SetActive(true)
					else
						var_104_3.gameObject:SetActive(false)
					end
				end
			end

			local var_104_4 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				var_104_2.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_101_1.time_ - 0) / var_104_4)
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				var_104_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_104_5 = arg_101_1.actors_["10015"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.actorSpriteComps10015 == nil then
				arg_101_1.var_.actorSpriteComps10015 = var_104_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_6 = 0.034

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_6 and not isNil(var_104_5) then
				if arg_101_1.var_.actorSpriteComps10015 then
					for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_104_4 then
							if arg_101_1.isInRecall_ then
								iter_104_4.color = Color.New(Mathf.Lerp(iter_104_4.color.r, arg_101_1.hightColor1.r, (arg_101_1.time_ - 0) / var_104_6), Mathf.Lerp(iter_104_4.color.g, arg_101_1.hightColor1.g, (arg_101_1.time_ - 0) / var_104_6), (Mathf.Lerp(iter_104_4.color.b, arg_101_1.hightColor1.b, (arg_101_1.time_ - 0) / var_104_6)))
							else
								local var_104_7 = Mathf.Lerp(iter_104_4.color.r, 1, (arg_101_1.time_ - 0) / var_104_6)

								iter_104_4.color = Color.New(var_104_7, var_104_7, var_104_7)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_6 and arg_101_1.time_ < 0 + var_104_6 + arg_104_0 and not isNil(var_104_5) and arg_101_1.var_.actorSpriteComps10015 then
				for iter_104_5, iter_104_6 in pairs(arg_101_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_104_6 then
						iter_104_6.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_101_1.var_.actorSpriteComps10015 = nil
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				local var_104_8 = arg_101_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_104_8 then
					arg_101_1.var_.alphaOldValue10015 = var_104_8.alpha
					arg_101_1.var_.characterEffect10015 = var_104_8
				end

				arg_101_1.var_.alphaOldValue10015 = 0
			end

			local var_104_9 = 0.5

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_9 then
				if arg_101_1.var_.characterEffect10015 then
					arg_101_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_101_1.var_.alphaOldValue10015, 1, (arg_101_1.time_ - 0) / var_104_9)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_9 and arg_101_1.time_ < 0 + var_104_9 + arg_104_0 and arg_101_1.var_.characterEffect10015 then
				arg_101_1.var_.characterEffect10015.alpha = 1
			end

			local var_104_10 = 0
			local var_104_11 = 0.1

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_12 = arg_101_1:GetWordFromCfg(114291024)
				local var_104_13 = arg_101_1:FormatText(var_104_12.content)

				arg_101_1.text_.text = var_104_13

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_15 = 4 <= 0 and var_104_11 or var_104_11 * (utf8.len(var_104_13) / 4)

				if (4 <= 0 and var_104_11 or var_104_11 * (utf8.len(var_104_13) / 4)) > 0 and var_104_11 < var_104_15 then
					arg_101_1.talkMaxDuration = var_104_15

					if var_104_15 + var_104_10 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_15 + var_104_10
					end
				end

				arg_101_1.text_.text = var_104_13
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291024", "story_v_out_114291.awb") ~= 0 then
					local var_104_16 = manager.audio:GetVoiceLength("story_v_out_114291", "114291024", "story_v_out_114291.awb") / 1000

					if var_104_16 + var_104_10 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_16 + var_104_10
					end

					if var_104_12.prefab_name ~= "" and arg_101_1.actors_[var_104_12.prefab_name] ~= nil then
						local var_104_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_12.prefab_name].transform, "story_v_out_114291", "114291024", "story_v_out_114291.awb")

						arg_101_1:RecordAudio("114291024", var_104_17)
						arg_101_1:RecordAudio("114291024", var_104_17)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_114291", "114291024", "story_v_out_114291.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_114291", "114291024", "story_v_out_114291.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_18 = math.max(var_104_11, arg_101_1.talkMaxDuration)

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_18 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_10) / var_104_18

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_10 + var_104_18 and arg_101_1.time_ < var_104_10 + var_104_18 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
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
	Play114291025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 114291025
		arg_105_1.duration_ = 7.73

		local var_105_0 = {
			ja = 7.5,
			ko = 7.1,
			zh = 7.733,
			en = 6.8
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
				arg_105_0:Play114291026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10016 = arg_105_1.actors_["10016"].transform.localPosition
				arg_105_1.actors_["10016"].transform.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10016", 2)
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["10016"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10016, Vector3.New(-390, -350, -180), (arg_105_1.time_ - 0) / var_108_0)
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["10016"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_108_1 = arg_105_1.actors_["10015"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.actorSpriteComps10015 == nil then
				arg_105_1.var_.actorSpriteComps10015 = var_108_1:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_2 = 0.034

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.actorSpriteComps10015 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								iter_108_1.color = Color.New(Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor2.r, (arg_105_1.time_ - 0) / var_108_2), Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor2.g, (arg_105_1.time_ - 0) / var_108_2), (Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor2.b, (arg_105_1.time_ - 0) / var_108_2)))
							else
								local var_108_3 = Mathf.Lerp(iter_108_1.color.r, 0.5, (arg_105_1.time_ - 0) / var_108_2)

								iter_108_1.color = Color.New(var_108_3, var_108_3, var_108_3)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.actorSpriteComps10015 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_108_3 then
						iter_108_3.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_105_1.var_.actorSpriteComps10015 = nil
			end

			local var_108_4 = arg_105_1.actors_["10016"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_4) then
				local var_108_5 = var_108_4:GetComponent("Image")

				if var_108_5 then
					arg_105_1.var_.highlightMatValue10016 = var_108_5
				end
			end

			local var_108_6 = 0.034

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_6 and not isNil(var_108_4) then
				if arg_105_1.var_.highlightMatValue10016 then
					local var_108_7 = Mathf.Lerp(0.5, 1, (arg_105_1.time_ - 0) / var_108_6)

					arg_105_1.var_.highlightMatValue10016.color.r = var_108_7
					arg_105_1.var_.highlightMatValue10016.color.g = var_108_7
					arg_105_1.var_.highlightMatValue10016.color.b = var_108_7
					arg_105_1.var_.highlightMatValue10016.color = arg_105_1.var_.highlightMatValue10016.color
				end
			end

			if arg_105_1.time_ >= 0 + var_108_6 and arg_105_1.time_ < 0 + var_108_6 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.highlightMatValue10016 then
				var_108_4.transform:SetSiblingIndex(1)

				arg_105_1.var_.highlightMatValue10016.color.r = 1
				arg_105_1.var_.highlightMatValue10016.color.g = 1
				arg_105_1.var_.highlightMatValue10016.color.b = 1
				arg_105_1.var_.highlightMatValue10016.color = arg_105_1.var_.highlightMatValue10016.color
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				local var_108_8 = arg_105_1.actors_["10016"]:GetComponent("Image")

				if var_108_8 then
					arg_105_1.var_.alphaMatValue10016 = var_108_8
					arg_105_1.var_.alphaOldValue10016 = var_108_8.color.a
				end

				arg_105_1.var_.alphaOldValue10016 = 0
			end

			local var_108_9 = 0.5

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_9 then
				if arg_105_1.var_.alphaMatValue10016 then
					arg_105_1.var_.alphaMatValue10016.color.a = Mathf.Lerp(arg_105_1.var_.alphaOldValue10016, 1, (arg_105_1.time_ - 0) / var_108_9)
					arg_105_1.var_.alphaMatValue10016.color = arg_105_1.var_.alphaMatValue10016.color
				end
			end

			if arg_105_1.time_ >= 0 + var_108_9 and arg_105_1.time_ < 0 + var_108_9 + arg_108_0 and arg_105_1.var_.alphaMatValue10016 then
				arg_105_1.var_.alphaMatValue10016.color.a = 1
				arg_105_1.var_.alphaMatValue10016.color = arg_105_1.var_.alphaMatValue10016.color
			end

			local var_108_10 = 0
			local var_108_11 = 0.625

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_12 = arg_105_1:GetWordFromCfg(114291025)
				local var_108_13 = arg_105_1:FormatText(var_108_12.content)

				arg_105_1.text_.text = var_108_13

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_15 = 25 <= 0 and var_108_11 or var_108_11 * (utf8.len(var_108_13) / 25)

				if (25 <= 0 and var_108_11 or var_108_11 * (utf8.len(var_108_13) / 25)) > 0 and var_108_11 < var_108_15 then
					arg_105_1.talkMaxDuration = var_108_15

					if var_108_15 + var_108_10 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_15 + var_108_10
					end
				end

				arg_105_1.text_.text = var_108_13
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291025", "story_v_out_114291.awb") ~= 0 then
					local var_108_16 = manager.audio:GetVoiceLength("story_v_out_114291", "114291025", "story_v_out_114291.awb") / 1000

					if var_108_16 + var_108_10 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_16 + var_108_10
					end

					if var_108_12.prefab_name ~= "" and arg_105_1.actors_[var_108_12.prefab_name] ~= nil then
						local var_108_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_12.prefab_name].transform, "story_v_out_114291", "114291025", "story_v_out_114291.awb")

						arg_105_1:RecordAudio("114291025", var_108_17)
						arg_105_1:RecordAudio("114291025", var_108_17)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_114291", "114291025", "story_v_out_114291.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_114291", "114291025", "story_v_out_114291.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_18 = math.max(var_108_11, arg_105_1.talkMaxDuration)

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_18 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_10) / var_108_18

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_10 + var_108_18 and arg_105_1.time_ < var_108_10 + var_108_18 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10016",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play114291026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 114291026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play114291027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10016"]) then
				local var_112_0 = arg_109_1.actors_["10016"]:GetComponent("Image")

				if var_112_0 then
					arg_109_1.var_.highlightMatValue10016 = var_112_0
				end
			end

			local var_112_1 = 0.034

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_1 and not isNil(arg_109_1.actors_["10016"]) then
				if arg_109_1.var_.highlightMatValue10016 then
					local var_112_2 = Mathf.Lerp(1, 0.5, (arg_109_1.time_ - 0) / var_112_1)

					arg_109_1.var_.highlightMatValue10016.color.r = var_112_2
					arg_109_1.var_.highlightMatValue10016.color.g = var_112_2
					arg_109_1.var_.highlightMatValue10016.color.b = var_112_2
					arg_109_1.var_.highlightMatValue10016.color = arg_109_1.var_.highlightMatValue10016.color
				end
			end

			if arg_109_1.time_ >= 0 + var_112_1 and arg_109_1.time_ < 0 + var_112_1 + arg_112_0 and not isNil(arg_109_1.actors_["10016"]) and arg_109_1.var_.highlightMatValue10016 then
				arg_109_1.var_.highlightMatValue10016.color.r = 0.5
				arg_109_1.var_.highlightMatValue10016.color.g = 0.5
				arg_109_1.var_.highlightMatValue10016.color.b = 0.5
				arg_109_1.var_.highlightMatValue10016.color = arg_109_1.var_.highlightMatValue10016.color
			end

			local var_112_3 = 0
			local var_112_4 = 1.2

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_5 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(114291026).content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 48 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 48)

				if (48 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 48)) > 0 and var_112_4 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_3
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_4, arg_109_1.talkMaxDuration)

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_3) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_3 + var_112_8 and arg_109_1.time_ < var_112_3 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play114291027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 114291027
		arg_113_1.duration_ = 9.93

		local var_113_0 = {
			ja = 5.966,
			ko = 9.933,
			zh = 7.7,
			en = 7.5
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play114291028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10015 = arg_113_1.actors_["10015"].transform.localPosition
				arg_113_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10015", 4)

				for iter_116_0 = 0, arg_113_1.actors_["10015"].transform.childCount - 1 do
					local var_116_0 = arg_113_1.actors_["10015"].transform:GetChild(iter_116_0)

					if var_116_0.name == "split_2" or not string.find(var_116_0.name, "split") then
						var_116_0.gameObject:SetActive(true)
					else
						var_116_0.gameObject:SetActive(false)
					end
				end
			end

			local var_116_1 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 then
				arg_113_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_113_1.time_ - 0) / var_116_1)
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 then
				arg_113_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_116_2 = arg_113_1.actors_["10015"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps10015 == nil then
				arg_113_1.var_.actorSpriteComps10015 = var_116_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_3 = 0.034

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.actorSpriteComps10015 then
					for iter_116_1, iter_116_2 in pairs(arg_113_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.actorSpriteComps10015 then
				for iter_116_3, iter_116_4 in pairs(arg_113_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_116_4 then
						iter_116_4.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_113_1.var_.actorSpriteComps10015 = nil
			end

			local var_116_5 = 0
			local var_116_6 = 0.7

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_7 = arg_113_1:GetWordFromCfg(114291027)
				local var_116_8 = arg_113_1:FormatText(var_116_7.content)

				arg_113_1.text_.text = var_116_8

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_10 = 28 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_8) / 28)

				if (28 <= 0 and var_116_6 or var_116_6 * (utf8.len(var_116_8) / 28)) > 0 and var_116_6 < var_116_10 then
					arg_113_1.talkMaxDuration = var_116_10

					if var_116_10 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_5
					end
				end

				arg_113_1.text_.text = var_116_8
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291027", "story_v_out_114291.awb") ~= 0 then
					local var_116_11 = manager.audio:GetVoiceLength("story_v_out_114291", "114291027", "story_v_out_114291.awb") / 1000

					if var_116_11 + var_116_5 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_5
					end

					if var_116_7.prefab_name ~= "" and arg_113_1.actors_[var_116_7.prefab_name] ~= nil then
						local var_116_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_7.prefab_name].transform, "story_v_out_114291", "114291027", "story_v_out_114291.awb")

						arg_113_1:RecordAudio("114291027", var_116_12)
						arg_113_1:RecordAudio("114291027", var_116_12)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_114291", "114291027", "story_v_out_114291.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_114291", "114291027", "story_v_out_114291.awb")
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
				actorName = "10015",
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
	Play114291028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 114291028
		arg_117_1.duration_ = 14.63

		local var_117_0 = {
			ja = 14.633,
			ko = 9.733,
			zh = 9.9,
			en = 9.4
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
				arg_117_0:Play114291029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["10015"]) and arg_117_1.var_.actorSpriteComps10015 == nil then
				arg_117_1.var_.actorSpriteComps10015 = arg_117_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_0 = 0.034

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["10015"]) then
				if arg_117_1.var_.actorSpriteComps10015 then
					for iter_120_0, iter_120_1 in pairs(arg_117_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_120_1 then
							if arg_117_1.isInRecall_ then
								iter_120_1.color = Color.New(Mathf.Lerp(iter_120_1.color.r, arg_117_1.hightColor2.r, (arg_117_1.time_ - 0) / var_120_0), Mathf.Lerp(iter_120_1.color.g, arg_117_1.hightColor2.g, (arg_117_1.time_ - 0) / var_120_0), (Mathf.Lerp(iter_120_1.color.b, arg_117_1.hightColor2.b, (arg_117_1.time_ - 0) / var_120_0)))
							else
								local var_120_1 = Mathf.Lerp(iter_120_1.color.r, 0.5, (arg_117_1.time_ - 0) / var_120_0)

								iter_120_1.color = Color.New(var_120_1, var_120_1, var_120_1)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["10015"]) and arg_117_1.var_.actorSpriteComps10015 then
				for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_120_3 then
						iter_120_3.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps10015 = nil
			end

			local var_120_2 = arg_117_1.actors_["10016"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) then
				local var_120_3 = var_120_2:GetComponent("Image")

				if var_120_3 then
					arg_117_1.var_.highlightMatValue10016 = var_120_3
				end
			end

			local var_120_4 = 0.034

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 and not isNil(var_120_2) then
				if arg_117_1.var_.highlightMatValue10016 then
					local var_120_5 = Mathf.Lerp(0.5, 1, (arg_117_1.time_ - 0) / var_120_4)

					arg_117_1.var_.highlightMatValue10016.color.r = var_120_5
					arg_117_1.var_.highlightMatValue10016.color.g = var_120_5
					arg_117_1.var_.highlightMatValue10016.color.b = var_120_5
					arg_117_1.var_.highlightMatValue10016.color = arg_117_1.var_.highlightMatValue10016.color
				end
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.highlightMatValue10016 then
				var_120_2.transform:SetSiblingIndex(1)

				arg_117_1.var_.highlightMatValue10016.color.r = 1
				arg_117_1.var_.highlightMatValue10016.color.g = 1
				arg_117_1.var_.highlightMatValue10016.color.b = 1
				arg_117_1.var_.highlightMatValue10016.color = arg_117_1.var_.highlightMatValue10016.color
			end

			local var_120_6 = 0
			local var_120_7 = 0.875

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:GetWordFromCfg(114291028)
				local var_120_9 = arg_117_1:FormatText(var_120_8.content)

				arg_117_1.text_.text = var_120_9

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 35 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 35)

				if (35 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 35)) > 0 and var_120_7 < var_120_11 then
					arg_117_1.talkMaxDuration = var_120_11

					if var_120_11 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_9
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291028", "story_v_out_114291.awb") ~= 0 then
					local var_120_12 = manager.audio:GetVoiceLength("story_v_out_114291", "114291028", "story_v_out_114291.awb") / 1000

					if var_120_12 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_6
					end

					if var_120_8.prefab_name ~= "" and arg_117_1.actors_[var_120_8.prefab_name] ~= nil then
						local var_120_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_8.prefab_name].transform, "story_v_out_114291", "114291028", "story_v_out_114291.awb")

						arg_117_1:RecordAudio("114291028", var_120_13)
						arg_117_1:RecordAudio("114291028", var_120_13)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_114291", "114291028", "story_v_out_114291.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_114291", "114291028", "story_v_out_114291.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_14 and arg_117_1.time_ < var_120_6 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play114291029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 114291029
		arg_121_1.duration_ = 10.1

		local var_121_0 = {
			ja = 6.8,
			ko = 8.566,
			zh = 10.1,
			en = 7.233
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
				arg_121_0:Play114291030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10015 = arg_121_1.actors_["10015"].transform.localPosition
				arg_121_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10015", 4)

				for iter_124_0 = 0, arg_121_1.actors_["10015"].transform.childCount - 1 do
					local var_124_0 = arg_121_1.actors_["10015"].transform:GetChild(iter_124_0)

					if var_124_0.name == "split_1" or not string.find(var_124_0.name, "split") then
						var_124_0.gameObject:SetActive(true)
					else
						var_124_0.gameObject:SetActive(false)
					end
				end
			end

			local var_124_1 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 then
				arg_121_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_121_1.time_ - 0) / var_124_1)
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 then
				arg_121_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_124_2 = arg_121_1.actors_["10015"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.actorSpriteComps10015 == nil then
				arg_121_1.var_.actorSpriteComps10015 = var_124_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_3 = 0.034

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.actorSpriteComps10015 then
					for iter_124_1, iter_124_2 in pairs(arg_121_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_124_2 then
							if arg_121_1.isInRecall_ then
								iter_124_2.color = Color.New(Mathf.Lerp(iter_124_2.color.r, arg_121_1.hightColor1.r, (arg_121_1.time_ - 0) / var_124_3), Mathf.Lerp(iter_124_2.color.g, arg_121_1.hightColor1.g, (arg_121_1.time_ - 0) / var_124_3), (Mathf.Lerp(iter_124_2.color.b, arg_121_1.hightColor1.b, (arg_121_1.time_ - 0) / var_124_3)))
							else
								local var_124_4 = Mathf.Lerp(iter_124_2.color.r, 1, (arg_121_1.time_ - 0) / var_124_3)

								iter_124_2.color = Color.New(var_124_4, var_124_4, var_124_4)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.actorSpriteComps10015 then
				for iter_124_3, iter_124_4 in pairs(arg_121_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_124_4 then
						iter_124_4.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_121_1.var_.actorSpriteComps10015 = nil
			end

			local var_124_5 = arg_121_1.actors_["10016"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_5) then
				local var_124_6 = var_124_5:GetComponent("Image")

				if var_124_6 then
					arg_121_1.var_.highlightMatValue10016 = var_124_6
				end
			end

			local var_124_7 = 0.034

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_7 and not isNil(var_124_5) then
				if arg_121_1.var_.highlightMatValue10016 then
					local var_124_8 = Mathf.Lerp(1, 0.5, (arg_121_1.time_ - 0) / var_124_7)

					arg_121_1.var_.highlightMatValue10016.color.r = var_124_8
					arg_121_1.var_.highlightMatValue10016.color.g = var_124_8
					arg_121_1.var_.highlightMatValue10016.color.b = var_124_8
					arg_121_1.var_.highlightMatValue10016.color = arg_121_1.var_.highlightMatValue10016.color
				end
			end

			if arg_121_1.time_ >= 0 + var_124_7 and arg_121_1.time_ < 0 + var_124_7 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.highlightMatValue10016 then
				arg_121_1.var_.highlightMatValue10016.color.r = 0.5
				arg_121_1.var_.highlightMatValue10016.color.g = 0.5
				arg_121_1.var_.highlightMatValue10016.color.b = 0.5
				arg_121_1.var_.highlightMatValue10016.color = arg_121_1.var_.highlightMatValue10016.color
			end

			local var_124_9 = 0
			local var_124_10 = 0.925

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_11 = arg_121_1:GetWordFromCfg(114291029)
				local var_124_12 = arg_121_1:FormatText(var_124_11.content)

				arg_121_1.text_.text = var_124_12

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_14 = 37 <= 0 and var_124_10 or var_124_10 * (utf8.len(var_124_12) / 37)

				if (37 <= 0 and var_124_10 or var_124_10 * (utf8.len(var_124_12) / 37)) > 0 and var_124_10 < var_124_14 then
					arg_121_1.talkMaxDuration = var_124_14

					if var_124_14 + var_124_9 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_14 + var_124_9
					end
				end

				arg_121_1.text_.text = var_124_12
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291029", "story_v_out_114291.awb") ~= 0 then
					local var_124_15 = manager.audio:GetVoiceLength("story_v_out_114291", "114291029", "story_v_out_114291.awb") / 1000

					if var_124_15 + var_124_9 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_15 + var_124_9
					end

					if var_124_11.prefab_name ~= "" and arg_121_1.actors_[var_124_11.prefab_name] ~= nil then
						local var_124_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_11.prefab_name].transform, "story_v_out_114291", "114291029", "story_v_out_114291.awb")

						arg_121_1:RecordAudio("114291029", var_124_16)
						arg_121_1:RecordAudio("114291029", var_124_16)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_114291", "114291029", "story_v_out_114291.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_114291", "114291029", "story_v_out_114291.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_17 = math.max(var_124_10, arg_121_1.talkMaxDuration)

			if var_124_9 <= arg_121_1.time_ and arg_121_1.time_ < var_124_9 + var_124_17 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_9) / var_124_17

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_9 + var_124_17 and arg_121_1.time_ < var_124_9 + var_124_17 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play114291030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 114291030
		arg_125_1.duration_ = 2.1

		local var_125_0 = {
			ja = 1.633,
			ko = 2.1,
			zh = 1.233,
			en = 1
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
				arg_125_0:Play114291031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["10015"]) and arg_125_1.var_.actorSpriteComps10015 == nil then
				arg_125_1.var_.actorSpriteComps10015 = arg_125_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_128_0 = 0.034

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["10015"]) then
				if arg_125_1.var_.actorSpriteComps10015 then
					for iter_128_0, iter_128_1 in pairs(arg_125_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_128_1 then
							if arg_125_1.isInRecall_ then
								iter_128_1.color = Color.New(Mathf.Lerp(iter_128_1.color.r, arg_125_1.hightColor2.r, (arg_125_1.time_ - 0) / var_128_0), Mathf.Lerp(iter_128_1.color.g, arg_125_1.hightColor2.g, (arg_125_1.time_ - 0) / var_128_0), (Mathf.Lerp(iter_128_1.color.b, arg_125_1.hightColor2.b, (arg_125_1.time_ - 0) / var_128_0)))
							else
								local var_128_1 = Mathf.Lerp(iter_128_1.color.r, 0.5, (arg_125_1.time_ - 0) / var_128_0)

								iter_128_1.color = Color.New(var_128_1, var_128_1, var_128_1)
							end
						end
					end
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["10015"]) and arg_125_1.var_.actorSpriteComps10015 then
				for iter_128_2, iter_128_3 in pairs(arg_125_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_128_3 then
						iter_128_3.color = arg_125_1.isInRecall_ and (arg_125_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_125_1.var_.actorSpriteComps10015 = nil
			end

			local var_128_2 = arg_125_1.actors_["10016"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_2) then
				local var_128_3 = var_128_2:GetComponent("Image")

				if var_128_3 then
					arg_125_1.var_.highlightMatValue10016 = var_128_3
				end
			end

			local var_128_4 = 0.034

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 and not isNil(var_128_2) then
				if arg_125_1.var_.highlightMatValue10016 then
					local var_128_5 = Mathf.Lerp(0.5, 1, (arg_125_1.time_ - 0) / var_128_4)

					arg_125_1.var_.highlightMatValue10016.color.r = var_128_5
					arg_125_1.var_.highlightMatValue10016.color.g = var_128_5
					arg_125_1.var_.highlightMatValue10016.color.b = var_128_5
					arg_125_1.var_.highlightMatValue10016.color = arg_125_1.var_.highlightMatValue10016.color
				end
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 and not isNil(var_128_2) and arg_125_1.var_.highlightMatValue10016 then
				var_128_2.transform:SetSiblingIndex(1)

				arg_125_1.var_.highlightMatValue10016.color.r = 1
				arg_125_1.var_.highlightMatValue10016.color.g = 1
				arg_125_1.var_.highlightMatValue10016.color.b = 1
				arg_125_1.var_.highlightMatValue10016.color = arg_125_1.var_.highlightMatValue10016.color
			end

			local var_128_6 = 0
			local var_128_7 = 0.075

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_8 = arg_125_1:GetWordFromCfg(114291030)
				local var_128_9 = arg_125_1:FormatText(var_128_8.content)

				arg_125_1.text_.text = var_128_9

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_11 = 3 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_9) / 3)

				if (3 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_9) / 3)) > 0 and var_128_7 < var_128_11 then
					arg_125_1.talkMaxDuration = var_128_11

					if var_128_11 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_11 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_9
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291030", "story_v_out_114291.awb") ~= 0 then
					local var_128_12 = manager.audio:GetVoiceLength("story_v_out_114291", "114291030", "story_v_out_114291.awb") / 1000

					if var_128_12 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_12 + var_128_6
					end

					if var_128_8.prefab_name ~= "" and arg_125_1.actors_[var_128_8.prefab_name] ~= nil then
						local var_128_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_8.prefab_name].transform, "story_v_out_114291", "114291030", "story_v_out_114291.awb")

						arg_125_1:RecordAudio("114291030", var_128_13)
						arg_125_1:RecordAudio("114291030", var_128_13)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_114291", "114291030", "story_v_out_114291.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_114291", "114291030", "story_v_out_114291.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_14 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_14 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_14

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_14 and arg_125_1.time_ < var_128_6 + var_128_14 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play114291031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 114291031
		arg_129_1.duration_ = 3.73

		local var_129_0 = {
			ja = 3.733,
			ko = 3.2,
			zh = 3.333,
			en = 1.866
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
				arg_129_0:Play114291032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(arg_129_1.actors_["10015"]) and arg_129_1.var_.actorSpriteComps10015 == nil then
				arg_129_1.var_.actorSpriteComps10015 = arg_129_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_0 = 0.034

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 and not isNil(arg_129_1.actors_["10015"]) then
				if arg_129_1.var_.actorSpriteComps10015 then
					for iter_132_0, iter_132_1 in pairs(arg_129_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_132_1 then
							if arg_129_1.isInRecall_ then
								iter_132_1.color = Color.New(Mathf.Lerp(iter_132_1.color.r, arg_129_1.hightColor1.r, (arg_129_1.time_ - 0) / var_132_0), Mathf.Lerp(iter_132_1.color.g, arg_129_1.hightColor1.g, (arg_129_1.time_ - 0) / var_132_0), (Mathf.Lerp(iter_132_1.color.b, arg_129_1.hightColor1.b, (arg_129_1.time_ - 0) / var_132_0)))
							else
								local var_132_1 = Mathf.Lerp(iter_132_1.color.r, 1, (arg_129_1.time_ - 0) / var_132_0)

								iter_132_1.color = Color.New(var_132_1, var_132_1, var_132_1)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 and not isNil(arg_129_1.actors_["10015"]) and arg_129_1.var_.actorSpriteComps10015 then
				for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_132_3 then
						iter_132_3.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps10015 = nil
			end

			local var_132_2 = arg_129_1.actors_["10016"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_2) then
				local var_132_3 = var_132_2:GetComponent("Image")

				if var_132_3 then
					arg_129_1.var_.highlightMatValue10016 = var_132_3
				end
			end

			local var_132_4 = 0.034

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 and not isNil(var_132_2) then
				if arg_129_1.var_.highlightMatValue10016 then
					local var_132_5 = Mathf.Lerp(1, 0.5, (arg_129_1.time_ - 0) / var_132_4)

					arg_129_1.var_.highlightMatValue10016.color.r = var_132_5
					arg_129_1.var_.highlightMatValue10016.color.g = var_132_5
					arg_129_1.var_.highlightMatValue10016.color.b = var_132_5
					arg_129_1.var_.highlightMatValue10016.color = arg_129_1.var_.highlightMatValue10016.color
				end
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 and not isNil(var_132_2) and arg_129_1.var_.highlightMatValue10016 then
				arg_129_1.var_.highlightMatValue10016.color.r = 0.5
				arg_129_1.var_.highlightMatValue10016.color.g = 0.5
				arg_129_1.var_.highlightMatValue10016.color.b = 0.5
				arg_129_1.var_.highlightMatValue10016.color = arg_129_1.var_.highlightMatValue10016.color
			end

			local var_132_6 = 0
			local var_132_7 = 0.25

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:GetWordFromCfg(114291031)
				local var_132_9 = arg_129_1:FormatText(var_132_8.content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 10 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_9) / 10)

				if (10 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_9) / 10)) > 0 and var_132_7 < var_132_11 then
					arg_129_1.talkMaxDuration = var_132_11

					if var_132_11 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_9
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291031", "story_v_out_114291.awb") ~= 0 then
					local var_132_12 = manager.audio:GetVoiceLength("story_v_out_114291", "114291031", "story_v_out_114291.awb") / 1000

					if var_132_12 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_6
					end

					if var_132_8.prefab_name ~= "" and arg_129_1.actors_[var_132_8.prefab_name] ~= nil then
						local var_132_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_8.prefab_name].transform, "story_v_out_114291", "114291031", "story_v_out_114291.awb")

						arg_129_1:RecordAudio("114291031", var_132_13)
						arg_129_1:RecordAudio("114291031", var_132_13)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_114291", "114291031", "story_v_out_114291.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_114291", "114291031", "story_v_out_114291.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_14 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_14 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_14

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_14 and arg_129_1.time_ < var_132_6 + var_132_14 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play114291032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 114291032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play114291033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(arg_133_1.actors_["10015"]) and arg_133_1.var_.actorSpriteComps10015 == nil then
				arg_133_1.var_.actorSpriteComps10015 = arg_133_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_0 = 0.034

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 and not isNil(arg_133_1.actors_["10015"]) then
				if arg_133_1.var_.actorSpriteComps10015 then
					for iter_136_0, iter_136_1 in pairs(arg_133_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 and not isNil(arg_133_1.actors_["10015"]) and arg_133_1.var_.actorSpriteComps10015 then
				for iter_136_2, iter_136_3 in pairs(arg_133_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_136_3 then
						iter_136_3.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_133_1.var_.actorSpriteComps10015 = nil
			end

			local var_136_2 = 0
			local var_136_3 = 0.8

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

				local var_136_4 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(114291032).content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_6 = 32 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_4) / 32)

				if (32 <= 0 and var_136_3 or var_136_3 * (utf8.len(var_136_4) / 32)) > 0 and var_136_3 < var_136_6 then
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
	Play114291033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 114291033
		arg_137_1.duration_ = 4.1

		local var_137_0 = {
			ja = 4.1,
			ko = 3,
			zh = 2.133,
			en = 2.933
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
				arg_137_0:Play114291034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["10015"]) and arg_137_1.var_.actorSpriteComps10015 == nil then
				arg_137_1.var_.actorSpriteComps10015 = arg_137_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_0 = 0.034

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["10015"]) then
				if arg_137_1.var_.actorSpriteComps10015 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								iter_140_1.color = Color.New(Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor1.r, (arg_137_1.time_ - 0) / var_140_0), Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor1.g, (arg_137_1.time_ - 0) / var_140_0), (Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor1.b, (arg_137_1.time_ - 0) / var_140_0)))
							else
								local var_140_1 = Mathf.Lerp(iter_140_1.color.r, 1, (arg_137_1.time_ - 0) / var_140_0)

								iter_140_1.color = Color.New(var_140_1, var_140_1, var_140_1)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["10015"]) and arg_137_1.var_.actorSpriteComps10015 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_140_3 then
						iter_140_3.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_137_1.var_.actorSpriteComps10015 = nil
			end

			local var_140_2 = arg_137_1.actors_["10015"].transform

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10015 = var_140_2.localPosition
				var_140_2.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10015", 4)

				for iter_140_4 = 0, var_140_2.childCount - 1 do
					local var_140_3 = var_140_2:GetChild(iter_140_4)

					if var_140_3.name == "split_5" or not string.find(var_140_3.name, "split") then
						var_140_3.gameObject:SetActive(true)
					else
						var_140_3.gameObject:SetActive(false)
					end
				end
			end

			local var_140_4 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_4 then
				var_140_2.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_137_1.time_ - 0) / var_140_4)
			end

			if arg_137_1.time_ >= 0 + var_140_4 and arg_137_1.time_ < 0 + var_140_4 + arg_140_0 then
				var_140_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_140_5 = 0
			local var_140_6 = 0.2

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_7 = arg_137_1:GetWordFromCfg(114291033)
				local var_140_8 = arg_137_1:FormatText(var_140_7.content)

				arg_137_1.text_.text = var_140_8

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_10 = 8 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 8)

				if (8 <= 0 and var_140_6 or var_140_6 * (utf8.len(var_140_8) / 8)) > 0 and var_140_6 < var_140_10 then
					arg_137_1.talkMaxDuration = var_140_10

					if var_140_10 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_5
					end
				end

				arg_137_1.text_.text = var_140_8
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291033", "story_v_out_114291.awb") ~= 0 then
					local var_140_11 = manager.audio:GetVoiceLength("story_v_out_114291", "114291033", "story_v_out_114291.awb") / 1000

					if var_140_11 + var_140_5 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_5
					end

					if var_140_7.prefab_name ~= "" and arg_137_1.actors_[var_140_7.prefab_name] ~= nil then
						local var_140_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_7.prefab_name].transform, "story_v_out_114291", "114291033", "story_v_out_114291.awb")

						arg_137_1:RecordAudio("114291033", var_140_12)
						arg_137_1:RecordAudio("114291033", var_140_12)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_114291", "114291033", "story_v_out_114291.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_114291", "114291033", "story_v_out_114291.awb")
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
				actorName = "10015",
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
	Play114291034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 114291034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play114291035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["10015"]) and arg_141_1.var_.actorSpriteComps10015 == nil then
				arg_141_1.var_.actorSpriteComps10015 = arg_141_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_0 = 0.034

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["10015"]) then
				if arg_141_1.var_.actorSpriteComps10015 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								iter_144_1.color = Color.New(Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor2.r, (arg_141_1.time_ - 0) / var_144_0), Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor2.g, (arg_141_1.time_ - 0) / var_144_0), (Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor2.b, (arg_141_1.time_ - 0) / var_144_0)))
							else
								local var_144_1 = Mathf.Lerp(iter_144_1.color.r, 0.5, (arg_141_1.time_ - 0) / var_144_0)

								iter_144_1.color = Color.New(var_144_1, var_144_1, var_144_1)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["10015"]) and arg_141_1.var_.actorSpriteComps10015 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_144_3 then
						iter_144_3.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_141_1.var_.actorSpriteComps10015 = nil
			end

			local var_144_2 = 0
			local var_144_3 = 1.85

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_2 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_4 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(114291034).content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_6 = 74 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_4) / 74)

				if (74 <= 0 and var_144_3 or var_144_3 * (utf8.len(var_144_4) / 74)) > 0 and var_144_3 < var_144_6 then
					arg_141_1.talkMaxDuration = var_144_6

					if var_144_6 + var_144_2 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_2
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_7 = math.max(var_144_3, arg_141_1.talkMaxDuration)

			if var_144_2 <= arg_141_1.time_ and arg_141_1.time_ < var_144_2 + var_144_7 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_2) / var_144_7

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_2 + var_144_7 and arg_141_1.time_ < var_144_2 + var_144_7 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play114291035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 114291035
		arg_145_1.duration_ = 14.33

		local var_145_0 = {
			ja = 14.333,
			ko = 11.033,
			zh = 10.033,
			en = 9.9
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
				arg_145_0:Play114291036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["10015"]) and arg_145_1.var_.actorSpriteComps10015 == nil then
				arg_145_1.var_.actorSpriteComps10015 = arg_145_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_0 = 0.034

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["10015"]) then
				if arg_145_1.var_.actorSpriteComps10015 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_148_1 then
							if arg_145_1.isInRecall_ then
								iter_148_1.color = Color.New(Mathf.Lerp(iter_148_1.color.r, arg_145_1.hightColor1.r, (arg_145_1.time_ - 0) / var_148_0), Mathf.Lerp(iter_148_1.color.g, arg_145_1.hightColor1.g, (arg_145_1.time_ - 0) / var_148_0), (Mathf.Lerp(iter_148_1.color.b, arg_145_1.hightColor1.b, (arg_145_1.time_ - 0) / var_148_0)))
							else
								local var_148_1 = Mathf.Lerp(iter_148_1.color.r, 1, (arg_145_1.time_ - 0) / var_148_0)

								iter_148_1.color = Color.New(var_148_1, var_148_1, var_148_1)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["10015"]) and arg_145_1.var_.actorSpriteComps10015 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_148_3 then
						iter_148_3.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_145_1.var_.actorSpriteComps10015 = nil
			end

			local var_148_2 = 0
			local var_148_3 = 1.15

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_4 = arg_145_1:GetWordFromCfg(114291035)
				local var_148_5 = arg_145_1:FormatText(var_148_4.content)

				arg_145_1.text_.text = var_148_5

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 46 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_5) / 46)

				if (46 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_5) / 46)) > 0 and var_148_3 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_2
					end
				end

				arg_145_1.text_.text = var_148_5
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291035", "story_v_out_114291.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_114291", "114291035", "story_v_out_114291.awb") / 1000

					if var_148_8 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_2
					end

					if var_148_4.prefab_name ~= "" and arg_145_1.actors_[var_148_4.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_4.prefab_name].transform, "story_v_out_114291", "114291035", "story_v_out_114291.awb")

						arg_145_1:RecordAudio("114291035", var_148_9)
						arg_145_1:RecordAudio("114291035", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_114291", "114291035", "story_v_out_114291.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_114291", "114291035", "story_v_out_114291.awb")
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
	Play114291036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 114291036
		arg_149_1.duration_ = 9.97

		local var_149_0 = {
			ja = 8.133,
			ko = 5.333,
			zh = 9.966,
			en = 7.333
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
				arg_149_0:Play114291037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["10015"]) and arg_149_1.var_.actorSpriteComps10015 == nil then
				arg_149_1.var_.actorSpriteComps10015 = arg_149_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_0 = 0.034

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["10015"]) then
				if arg_149_1.var_.actorSpriteComps10015 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_152_1 then
							if arg_149_1.isInRecall_ then
								iter_152_1.color = Color.New(Mathf.Lerp(iter_152_1.color.r, arg_149_1.hightColor2.r, (arg_149_1.time_ - 0) / var_152_0), Mathf.Lerp(iter_152_1.color.g, arg_149_1.hightColor2.g, (arg_149_1.time_ - 0) / var_152_0), (Mathf.Lerp(iter_152_1.color.b, arg_149_1.hightColor2.b, (arg_149_1.time_ - 0) / var_152_0)))
							else
								local var_152_1 = Mathf.Lerp(iter_152_1.color.r, 0.5, (arg_149_1.time_ - 0) / var_152_0)

								iter_152_1.color = Color.New(var_152_1, var_152_1, var_152_1)
							end
						end
					end
				end
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["10015"]) and arg_149_1.var_.actorSpriteComps10015 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_152_3 then
						iter_152_3.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_149_1.var_.actorSpriteComps10015 = nil
			end

			local var_152_2 = arg_149_1.actors_["10016"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_2) then
				local var_152_3 = var_152_2:GetComponent("Image")

				if var_152_3 then
					arg_149_1.var_.highlightMatValue10016 = var_152_3
				end
			end

			local var_152_4 = 0.034

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 and not isNil(var_152_2) then
				if arg_149_1.var_.highlightMatValue10016 then
					local var_152_5 = Mathf.Lerp(0.5, 1, (arg_149_1.time_ - 0) / var_152_4)

					arg_149_1.var_.highlightMatValue10016.color.r = var_152_5
					arg_149_1.var_.highlightMatValue10016.color.g = var_152_5
					arg_149_1.var_.highlightMatValue10016.color.b = var_152_5
					arg_149_1.var_.highlightMatValue10016.color = arg_149_1.var_.highlightMatValue10016.color
				end
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 and not isNil(var_152_2) and arg_149_1.var_.highlightMatValue10016 then
				var_152_2.transform:SetSiblingIndex(1)

				arg_149_1.var_.highlightMatValue10016.color.r = 1
				arg_149_1.var_.highlightMatValue10016.color.g = 1
				arg_149_1.var_.highlightMatValue10016.color.b = 1
				arg_149_1.var_.highlightMatValue10016.color = arg_149_1.var_.highlightMatValue10016.color
			end

			local var_152_6 = 0
			local var_152_7 = 0.625

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_8 = arg_149_1:GetWordFromCfg(114291036)
				local var_152_9 = arg_149_1:FormatText(var_152_8.content)

				arg_149_1.text_.text = var_152_9

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 25 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 25)

				if (25 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 25)) > 0 and var_152_7 < var_152_11 then
					arg_149_1.talkMaxDuration = var_152_11

					if var_152_11 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_9
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291036", "story_v_out_114291.awb") ~= 0 then
					local var_152_12 = manager.audio:GetVoiceLength("story_v_out_114291", "114291036", "story_v_out_114291.awb") / 1000

					if var_152_12 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_12 + var_152_6
					end

					if var_152_8.prefab_name ~= "" and arg_149_1.actors_[var_152_8.prefab_name] ~= nil then
						local var_152_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_8.prefab_name].transform, "story_v_out_114291", "114291036", "story_v_out_114291.awb")

						arg_149_1:RecordAudio("114291036", var_152_13)
						arg_149_1:RecordAudio("114291036", var_152_13)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_114291", "114291036", "story_v_out_114291.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_114291", "114291036", "story_v_out_114291.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_14 = math.max(var_152_7, arg_149_1.talkMaxDuration)

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_14 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_6) / var_152_14

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_6 + var_152_14 and arg_149_1.time_ < var_152_6 + var_152_14 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play114291037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 114291037
		arg_153_1.duration_ = 11.07

		local var_153_0 = {
			ja = 11.066,
			ko = 10.6,
			zh = 10.4,
			en = 10.9
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
				arg_153_0:Play114291038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["10015"]) and arg_153_1.var_.actorSpriteComps10015 == nil then
				arg_153_1.var_.actorSpriteComps10015 = arg_153_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_0 = 0.034

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["10015"]) then
				if arg_153_1.var_.actorSpriteComps10015 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["10015"]) and arg_153_1.var_.actorSpriteComps10015 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_156_3 then
						iter_156_3.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps10015 = nil
			end

			local var_156_2 = arg_153_1.actors_["10016"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) then
				local var_156_3 = var_156_2:GetComponent("Image")

				if var_156_3 then
					arg_153_1.var_.highlightMatValue10016 = var_156_3
				end
			end

			local var_156_4 = 0.034

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_4 and not isNil(var_156_2) then
				if arg_153_1.var_.highlightMatValue10016 then
					local var_156_5 = Mathf.Lerp(1, 0.5, (arg_153_1.time_ - 0) / var_156_4)

					arg_153_1.var_.highlightMatValue10016.color.r = var_156_5
					arg_153_1.var_.highlightMatValue10016.color.g = var_156_5
					arg_153_1.var_.highlightMatValue10016.color.b = var_156_5
					arg_153_1.var_.highlightMatValue10016.color = arg_153_1.var_.highlightMatValue10016.color
				end
			end

			if arg_153_1.time_ >= 0 + var_156_4 and arg_153_1.time_ < 0 + var_156_4 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.highlightMatValue10016 then
				arg_153_1.var_.highlightMatValue10016.color.r = 0.5
				arg_153_1.var_.highlightMatValue10016.color.g = 0.5
				arg_153_1.var_.highlightMatValue10016.color.b = 0.5
				arg_153_1.var_.highlightMatValue10016.color = arg_153_1.var_.highlightMatValue10016.color
			end

			local var_156_6 = arg_153_1.actors_["10015"].transform

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10015 = var_156_6.localPosition
				var_156_6.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10015", 4)

				for iter_156_4 = 0, var_156_6.childCount - 1 do
					local var_156_7 = var_156_6:GetChild(iter_156_4)

					if var_156_7.name == "split_1" or not string.find(var_156_7.name, "split") then
						var_156_7.gameObject:SetActive(true)
					else
						var_156_7.gameObject:SetActive(false)
					end
				end
			end

			local var_156_8 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_8 then
				var_156_6.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_153_1.time_ - 0) / var_156_8)
			end

			if arg_153_1.time_ >= 0 + var_156_8 and arg_153_1.time_ < 0 + var_156_8 + arg_156_0 then
				var_156_6.localPosition = Vector3.New(390, -350, -180)
			end

			local var_156_9 = 0
			local var_156_10 = 1.175

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_9 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_11 = arg_153_1:GetWordFromCfg(114291037)
				local var_156_12 = arg_153_1:FormatText(var_156_11.content)

				arg_153_1.text_.text = var_156_12

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_14 = 47 <= 0 and var_156_10 or var_156_10 * (utf8.len(var_156_12) / 47)

				if (47 <= 0 and var_156_10 or var_156_10 * (utf8.len(var_156_12) / 47)) > 0 and var_156_10 < var_156_14 then
					arg_153_1.talkMaxDuration = var_156_14

					if var_156_14 + var_156_9 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_14 + var_156_9
					end
				end

				arg_153_1.text_.text = var_156_12
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291037", "story_v_out_114291.awb") ~= 0 then
					local var_156_15 = manager.audio:GetVoiceLength("story_v_out_114291", "114291037", "story_v_out_114291.awb") / 1000

					if var_156_15 + var_156_9 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_15 + var_156_9
					end

					if var_156_11.prefab_name ~= "" and arg_153_1.actors_[var_156_11.prefab_name] ~= nil then
						local var_156_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_11.prefab_name].transform, "story_v_out_114291", "114291037", "story_v_out_114291.awb")

						arg_153_1:RecordAudio("114291037", var_156_16)
						arg_153_1:RecordAudio("114291037", var_156_16)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_114291", "114291037", "story_v_out_114291.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_114291", "114291037", "story_v_out_114291.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_17 = math.max(var_156_10, arg_153_1.talkMaxDuration)

			if var_156_9 <= arg_153_1.time_ and arg_153_1.time_ < var_156_9 + var_156_17 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_9) / var_156_17

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_9 + var_156_17 and arg_153_1.time_ < var_156_9 + var_156_17 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
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
	Play114291038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 114291038
		arg_157_1.duration_ = 16.73

		local var_157_0 = {
			ja = 6.566,
			ko = 16.733,
			zh = 12.8,
			en = 11.133
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
				arg_157_0:Play114291039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 1.425

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_1 = arg_157_1:GetWordFromCfg(114291038)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.text_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 57 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 57)

				if (57 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_2) / 57)) > 0 and var_160_0 < var_160_4 then
					arg_157_1.talkMaxDuration = var_160_4

					if var_160_4 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_4 + 0
					end
				end

				arg_157_1.text_.text = var_160_2
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291038", "story_v_out_114291.awb") ~= 0 then
					local var_160_5 = manager.audio:GetVoiceLength("story_v_out_114291", "114291038", "story_v_out_114291.awb") / 1000

					if var_160_5 + 0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + 0
					end

					if var_160_1.prefab_name ~= "" and arg_157_1.actors_[var_160_1.prefab_name] ~= nil then
						local var_160_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_1.prefab_name].transform, "story_v_out_114291", "114291038", "story_v_out_114291.awb")

						arg_157_1:RecordAudio("114291038", var_160_6)
						arg_157_1:RecordAudio("114291038", var_160_6)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_114291", "114291038", "story_v_out_114291.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_114291", "114291038", "story_v_out_114291.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_0, arg_157_1.talkMaxDuration)

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - 0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play114291039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 114291039
		arg_161_1.duration_ = 18.1

		local var_161_0 = {
			ja = 5.3,
			ko = 14.866,
			zh = 18.1,
			en = 13.2
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
				arg_161_0:Play114291040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.9

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:GetWordFromCfg(114291039)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.text_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_4 = 76 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 76)

				if (76 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_2) / 76)) > 0 and var_164_0 < var_164_4 then
					arg_161_1.talkMaxDuration = var_164_4

					if var_164_4 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_4 + 0
					end
				end

				arg_161_1.text_.text = var_164_2
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291039", "story_v_out_114291.awb") ~= 0 then
					local var_164_5 = manager.audio:GetVoiceLength("story_v_out_114291", "114291039", "story_v_out_114291.awb") / 1000

					if var_164_5 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_5 + 0
					end

					if var_164_1.prefab_name ~= "" and arg_161_1.actors_[var_164_1.prefab_name] ~= nil then
						local var_164_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_1.prefab_name].transform, "story_v_out_114291", "114291039", "story_v_out_114291.awb")

						arg_161_1:RecordAudio("114291039", var_164_6)
						arg_161_1:RecordAudio("114291039", var_164_6)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_114291", "114291039", "story_v_out_114291.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_114291", "114291039", "story_v_out_114291.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_7 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_7 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_7

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_7 and arg_161_1.time_ < 0 + var_164_7 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play114291040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 114291040
		arg_165_1.duration_ = 4.3

		local var_165_0 = {
			ja = 3.7,
			ko = 3.966,
			zh = 4.3,
			en = 4.2
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
				arg_165_0:Play114291041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(arg_165_1.actors_["10015"]) and arg_165_1.var_.actorSpriteComps10015 == nil then
				arg_165_1.var_.actorSpriteComps10015 = arg_165_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_0 = 0.034

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 and not isNil(arg_165_1.actors_["10015"]) then
				if arg_165_1.var_.actorSpriteComps10015 then
					for iter_168_0, iter_168_1 in pairs(arg_165_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_168_1 then
							if arg_165_1.isInRecall_ then
								iter_168_1.color = Color.New(Mathf.Lerp(iter_168_1.color.r, arg_165_1.hightColor2.r, (arg_165_1.time_ - 0) / var_168_0), Mathf.Lerp(iter_168_1.color.g, arg_165_1.hightColor2.g, (arg_165_1.time_ - 0) / var_168_0), (Mathf.Lerp(iter_168_1.color.b, arg_165_1.hightColor2.b, (arg_165_1.time_ - 0) / var_168_0)))
							else
								local var_168_1 = Mathf.Lerp(iter_168_1.color.r, 0.5, (arg_165_1.time_ - 0) / var_168_0)

								iter_168_1.color = Color.New(var_168_1, var_168_1, var_168_1)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 and not isNil(arg_165_1.actors_["10015"]) and arg_165_1.var_.actorSpriteComps10015 then
				for iter_168_2, iter_168_3 in pairs(arg_165_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_168_3 then
						iter_168_3.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_165_1.var_.actorSpriteComps10015 = nil
			end

			local var_168_2 = arg_165_1.actors_["10016"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_2) then
				local var_168_3 = var_168_2:GetComponent("Image")

				if var_168_3 then
					arg_165_1.var_.highlightMatValue10016 = var_168_3
				end
			end

			local var_168_4 = 0.034

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 and not isNil(var_168_2) then
				if arg_165_1.var_.highlightMatValue10016 then
					local var_168_5 = Mathf.Lerp(0.5, 1, (arg_165_1.time_ - 0) / var_168_4)

					arg_165_1.var_.highlightMatValue10016.color.r = var_168_5
					arg_165_1.var_.highlightMatValue10016.color.g = var_168_5
					arg_165_1.var_.highlightMatValue10016.color.b = var_168_5
					arg_165_1.var_.highlightMatValue10016.color = arg_165_1.var_.highlightMatValue10016.color
				end
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 and not isNil(var_168_2) and arg_165_1.var_.highlightMatValue10016 then
				var_168_2.transform:SetSiblingIndex(1)

				arg_165_1.var_.highlightMatValue10016.color.r = 1
				arg_165_1.var_.highlightMatValue10016.color.g = 1
				arg_165_1.var_.highlightMatValue10016.color.b = 1
				arg_165_1.var_.highlightMatValue10016.color = arg_165_1.var_.highlightMatValue10016.color
			end

			local var_168_6 = 0
			local var_168_7 = 0.3

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:GetWordFromCfg(114291040)
				local var_168_9 = arg_165_1:FormatText(var_168_8.content)

				arg_165_1.text_.text = var_168_9

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_11 = 12 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_9) / 12)

				if (12 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_9) / 12)) > 0 and var_168_7 < var_168_11 then
					arg_165_1.talkMaxDuration = var_168_11

					if var_168_11 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_11 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_9
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291040", "story_v_out_114291.awb") ~= 0 then
					local var_168_12 = manager.audio:GetVoiceLength("story_v_out_114291", "114291040", "story_v_out_114291.awb") / 1000

					if var_168_12 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_12 + var_168_6
					end

					if var_168_8.prefab_name ~= "" and arg_165_1.actors_[var_168_8.prefab_name] ~= nil then
						local var_168_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_8.prefab_name].transform, "story_v_out_114291", "114291040", "story_v_out_114291.awb")

						arg_165_1:RecordAudio("114291040", var_168_13)
						arg_165_1:RecordAudio("114291040", var_168_13)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_114291", "114291040", "story_v_out_114291.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_114291", "114291040", "story_v_out_114291.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_14 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_14 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_14

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_14 and arg_165_1.time_ < var_168_6 + var_168_14 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play114291041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 114291041
		arg_169_1.duration_ = 3.87

		local var_169_0 = {
			ja = 3.7,
			ko = 3.1,
			zh = 3.233,
			en = 3.866
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
				arg_169_0:Play114291042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10015 = arg_169_1.actors_["10015"].transform.localPosition
				arg_169_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10015", 4)

				for iter_172_0 = 0, arg_169_1.actors_["10015"].transform.childCount - 1 do
					local var_172_0 = arg_169_1.actors_["10015"].transform:GetChild(iter_172_0)

					if var_172_0.name == "split_4" or not string.find(var_172_0.name, "split") then
						var_172_0.gameObject:SetActive(true)
					else
						var_172_0.gameObject:SetActive(false)
					end
				end
			end

			local var_172_1 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_1 then
				arg_169_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_169_1.time_ - 0) / var_172_1)
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 then
				arg_169_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_172_2 = arg_169_1.actors_["10015"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps10015 == nil then
				arg_169_1.var_.actorSpriteComps10015 = var_172_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_3 = 0.034

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 and not isNil(var_172_2) then
				if arg_169_1.var_.actorSpriteComps10015 then
					for iter_172_1, iter_172_2 in pairs(arg_169_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_172_2 then
							if arg_169_1.isInRecall_ then
								iter_172_2.color = Color.New(Mathf.Lerp(iter_172_2.color.r, arg_169_1.hightColor1.r, (arg_169_1.time_ - 0) / var_172_3), Mathf.Lerp(iter_172_2.color.g, arg_169_1.hightColor1.g, (arg_169_1.time_ - 0) / var_172_3), (Mathf.Lerp(iter_172_2.color.b, arg_169_1.hightColor1.b, (arg_169_1.time_ - 0) / var_172_3)))
							else
								local var_172_4 = Mathf.Lerp(iter_172_2.color.r, 1, (arg_169_1.time_ - 0) / var_172_3)

								iter_172_2.color = Color.New(var_172_4, var_172_4, var_172_4)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps10015 then
				for iter_172_3, iter_172_4 in pairs(arg_169_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_172_4 then
						iter_172_4.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_169_1.var_.actorSpriteComps10015 = nil
			end

			local var_172_5 = arg_169_1.actors_["10016"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_5) then
				local var_172_6 = var_172_5:GetComponent("Image")

				if var_172_6 then
					arg_169_1.var_.highlightMatValue10016 = var_172_6
				end
			end

			local var_172_7 = 0.034

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_7 and not isNil(var_172_5) then
				if arg_169_1.var_.highlightMatValue10016 then
					local var_172_8 = Mathf.Lerp(1, 0.5, (arg_169_1.time_ - 0) / var_172_7)

					arg_169_1.var_.highlightMatValue10016.color.r = var_172_8
					arg_169_1.var_.highlightMatValue10016.color.g = var_172_8
					arg_169_1.var_.highlightMatValue10016.color.b = var_172_8
					arg_169_1.var_.highlightMatValue10016.color = arg_169_1.var_.highlightMatValue10016.color
				end
			end

			if arg_169_1.time_ >= 0 + var_172_7 and arg_169_1.time_ < 0 + var_172_7 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.highlightMatValue10016 then
				arg_169_1.var_.highlightMatValue10016.color.r = 0.5
				arg_169_1.var_.highlightMatValue10016.color.g = 0.5
				arg_169_1.var_.highlightMatValue10016.color.b = 0.5
				arg_169_1.var_.highlightMatValue10016.color = arg_169_1.var_.highlightMatValue10016.color
			end

			local var_172_9 = 0
			local var_172_10 = 0.35

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_9 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_11 = arg_169_1:GetWordFromCfg(114291041)
				local var_172_12 = arg_169_1:FormatText(var_172_11.content)

				arg_169_1.text_.text = var_172_12

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_14 = 14 <= 0 and var_172_10 or var_172_10 * (utf8.len(var_172_12) / 14)

				if (14 <= 0 and var_172_10 or var_172_10 * (utf8.len(var_172_12) / 14)) > 0 and var_172_10 < var_172_14 then
					arg_169_1.talkMaxDuration = var_172_14

					if var_172_14 + var_172_9 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_14 + var_172_9
					end
				end

				arg_169_1.text_.text = var_172_12
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291041", "story_v_out_114291.awb") ~= 0 then
					local var_172_15 = manager.audio:GetVoiceLength("story_v_out_114291", "114291041", "story_v_out_114291.awb") / 1000

					if var_172_15 + var_172_9 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_15 + var_172_9
					end

					if var_172_11.prefab_name ~= "" and arg_169_1.actors_[var_172_11.prefab_name] ~= nil then
						local var_172_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_11.prefab_name].transform, "story_v_out_114291", "114291041", "story_v_out_114291.awb")

						arg_169_1:RecordAudio("114291041", var_172_16)
						arg_169_1:RecordAudio("114291041", var_172_16)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_114291", "114291041", "story_v_out_114291.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_114291", "114291041", "story_v_out_114291.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_17 = math.max(var_172_10, arg_169_1.talkMaxDuration)

			if var_172_9 <= arg_169_1.time_ and arg_169_1.time_ < var_172_9 + var_172_17 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_9) / var_172_17

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_9 + var_172_17 and arg_169_1.time_ < var_172_9 + var_172_17 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play114291042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 114291042
		arg_173_1.duration_ = 3.23

		local var_173_0 = {
			ja = 3.233,
			ko = 1.5,
			zh = 1.433,
			en = 2.533
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
				arg_173_0:Play114291043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["10015"]) and arg_173_1.var_.actorSpriteComps10015 == nil then
				arg_173_1.var_.actorSpriteComps10015 = arg_173_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_0 = 0.034

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["10015"]) then
				if arg_173_1.var_.actorSpriteComps10015 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["10015"]) and arg_173_1.var_.actorSpriteComps10015 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_176_3 then
						iter_176_3.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_173_1.var_.actorSpriteComps10015 = nil
			end

			local var_176_2 = arg_173_1.actors_["10016"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) then
				local var_176_3 = var_176_2:GetComponent("Image")

				if var_176_3 then
					arg_173_1.var_.highlightMatValue10016 = var_176_3
				end
			end

			local var_176_4 = 0.034

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_4 and not isNil(var_176_2) then
				if arg_173_1.var_.highlightMatValue10016 then
					local var_176_5 = Mathf.Lerp(0.5, 1, (arg_173_1.time_ - 0) / var_176_4)

					arg_173_1.var_.highlightMatValue10016.color.r = var_176_5
					arg_173_1.var_.highlightMatValue10016.color.g = var_176_5
					arg_173_1.var_.highlightMatValue10016.color.b = var_176_5
					arg_173_1.var_.highlightMatValue10016.color = arg_173_1.var_.highlightMatValue10016.color
				end
			end

			if arg_173_1.time_ >= 0 + var_176_4 and arg_173_1.time_ < 0 + var_176_4 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.highlightMatValue10016 then
				var_176_2.transform:SetSiblingIndex(1)

				arg_173_1.var_.highlightMatValue10016.color.r = 1
				arg_173_1.var_.highlightMatValue10016.color.g = 1
				arg_173_1.var_.highlightMatValue10016.color.b = 1
				arg_173_1.var_.highlightMatValue10016.color = arg_173_1.var_.highlightMatValue10016.color
			end

			local var_176_6 = 0
			local var_176_7 = 0.15

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_6 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_8 = arg_173_1:GetWordFromCfg(114291042)
				local var_176_9 = arg_173_1:FormatText(var_176_8.content)

				arg_173_1.text_.text = var_176_9

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_11 = 6 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 6)

				if (6 <= 0 and var_176_7 or var_176_7 * (utf8.len(var_176_9) / 6)) > 0 and var_176_7 < var_176_11 then
					arg_173_1.talkMaxDuration = var_176_11

					if var_176_11 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_11 + var_176_6
					end
				end

				arg_173_1.text_.text = var_176_9
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291042", "story_v_out_114291.awb") ~= 0 then
					local var_176_12 = manager.audio:GetVoiceLength("story_v_out_114291", "114291042", "story_v_out_114291.awb") / 1000

					if var_176_12 + var_176_6 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_12 + var_176_6
					end

					if var_176_8.prefab_name ~= "" and arg_173_1.actors_[var_176_8.prefab_name] ~= nil then
						local var_176_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_8.prefab_name].transform, "story_v_out_114291", "114291042", "story_v_out_114291.awb")

						arg_173_1:RecordAudio("114291042", var_176_13)
						arg_173_1:RecordAudio("114291042", var_176_13)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_114291", "114291042", "story_v_out_114291.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_114291", "114291042", "story_v_out_114291.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_14 = math.max(var_176_7, arg_173_1.talkMaxDuration)

			if var_176_6 <= arg_173_1.time_ and arg_173_1.time_ < var_176_6 + var_176_14 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_6) / var_176_14

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_6 + var_176_14 and arg_173_1.time_ < var_176_6 + var_176_14 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play114291043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 114291043
		arg_177_1.duration_ = 10.13

		local var_177_0 = {
			ja = 7.233,
			ko = 9.066,
			zh = 9.066,
			en = 10.133
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
				arg_177_0:Play114291044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos10015 = arg_177_1.actors_["10015"].transform.localPosition
				arg_177_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_177_1:CheckSpriteTmpPos("10015", 4)

				for iter_180_0 = 0, arg_177_1.actors_["10015"].transform.childCount - 1 do
					local var_180_0 = arg_177_1.actors_["10015"].transform:GetChild(iter_180_0)

					if var_180_0.name == "split_1" or not string.find(var_180_0.name, "split") then
						var_180_0.gameObject:SetActive(true)
					else
						var_180_0.gameObject:SetActive(false)
					end
				end
			end

			local var_180_1 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_1 then
				arg_177_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_177_1.time_ - 0) / var_180_1)
			end

			if arg_177_1.time_ >= 0 + var_180_1 and arg_177_1.time_ < 0 + var_180_1 + arg_180_0 then
				arg_177_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_180_2 = arg_177_1.actors_["10015"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps10015 == nil then
				arg_177_1.var_.actorSpriteComps10015 = var_180_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_180_3 = 0.034

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_3 and not isNil(var_180_2) then
				if arg_177_1.var_.actorSpriteComps10015 then
					for iter_180_1, iter_180_2 in pairs(arg_177_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_180_2 then
							if arg_177_1.isInRecall_ then
								iter_180_2.color = Color.New(Mathf.Lerp(iter_180_2.color.r, arg_177_1.hightColor1.r, (arg_177_1.time_ - 0) / var_180_3), Mathf.Lerp(iter_180_2.color.g, arg_177_1.hightColor1.g, (arg_177_1.time_ - 0) / var_180_3), (Mathf.Lerp(iter_180_2.color.b, arg_177_1.hightColor1.b, (arg_177_1.time_ - 0) / var_180_3)))
							else
								local var_180_4 = Mathf.Lerp(iter_180_2.color.r, 1, (arg_177_1.time_ - 0) / var_180_3)

								iter_180_2.color = Color.New(var_180_4, var_180_4, var_180_4)
							end
						end
					end
				end
			end

			if arg_177_1.time_ >= 0 + var_180_3 and arg_177_1.time_ < 0 + var_180_3 + arg_180_0 and not isNil(var_180_2) and arg_177_1.var_.actorSpriteComps10015 then
				for iter_180_3, iter_180_4 in pairs(arg_177_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_180_4 then
						iter_180_4.color = arg_177_1.isInRecall_ and (arg_177_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_177_1.var_.actorSpriteComps10015 = nil
			end

			local var_180_5 = arg_177_1.actors_["10016"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_5) then
				local var_180_6 = var_180_5:GetComponent("Image")

				if var_180_6 then
					arg_177_1.var_.highlightMatValue10016 = var_180_6
				end
			end

			local var_180_7 = 0.034

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 and not isNil(var_180_5) then
				if arg_177_1.var_.highlightMatValue10016 then
					local var_180_8 = Mathf.Lerp(1, 0.5, (arg_177_1.time_ - 0) / var_180_7)

					arg_177_1.var_.highlightMatValue10016.color.r = var_180_8
					arg_177_1.var_.highlightMatValue10016.color.g = var_180_8
					arg_177_1.var_.highlightMatValue10016.color.b = var_180_8
					arg_177_1.var_.highlightMatValue10016.color = arg_177_1.var_.highlightMatValue10016.color
				end
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 and not isNil(var_180_5) and arg_177_1.var_.highlightMatValue10016 then
				arg_177_1.var_.highlightMatValue10016.color.r = 0.5
				arg_177_1.var_.highlightMatValue10016.color.g = 0.5
				arg_177_1.var_.highlightMatValue10016.color.b = 0.5
				arg_177_1.var_.highlightMatValue10016.color = arg_177_1.var_.highlightMatValue10016.color
			end

			local var_180_9 = 0
			local var_180_10 = 0.8

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_11 = arg_177_1:GetWordFromCfg(114291043)
				local var_180_12 = arg_177_1:FormatText(var_180_11.content)

				arg_177_1.text_.text = var_180_12

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_14 = 32 <= 0 and var_180_10 or var_180_10 * (utf8.len(var_180_12) / 32)

				if (32 <= 0 and var_180_10 or var_180_10 * (utf8.len(var_180_12) / 32)) > 0 and var_180_10 < var_180_14 then
					arg_177_1.talkMaxDuration = var_180_14

					if var_180_14 + var_180_9 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_14 + var_180_9
					end
				end

				arg_177_1.text_.text = var_180_12
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291043", "story_v_out_114291.awb") ~= 0 then
					local var_180_15 = manager.audio:GetVoiceLength("story_v_out_114291", "114291043", "story_v_out_114291.awb") / 1000

					if var_180_15 + var_180_9 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_15 + var_180_9
					end

					if var_180_11.prefab_name ~= "" and arg_177_1.actors_[var_180_11.prefab_name] ~= nil then
						local var_180_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_11.prefab_name].transform, "story_v_out_114291", "114291043", "story_v_out_114291.awb")

						arg_177_1:RecordAudio("114291043", var_180_16)
						arg_177_1:RecordAudio("114291043", var_180_16)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_114291", "114291043", "story_v_out_114291.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_114291", "114291043", "story_v_out_114291.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_17 = math.max(var_180_10, arg_177_1.talkMaxDuration)

			if var_180_9 <= arg_177_1.time_ and arg_177_1.time_ < var_180_9 + var_180_17 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_9) / var_180_17

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_9 + var_180_17 and arg_177_1.time_ < var_180_9 + var_180_17 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play114291044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 114291044
		arg_181_1.duration_ = 9.73

		local var_181_0 = {
			ja = 9.2,
			ko = 6.1,
			zh = 6.933,
			en = 9.733
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
				arg_181_0:Play114291045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["10015"]) and arg_181_1.var_.actorSpriteComps10015 == nil then
				arg_181_1.var_.actorSpriteComps10015 = arg_181_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_184_0 = 0.034

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["10015"]) then
				if arg_181_1.var_.actorSpriteComps10015 then
					for iter_184_0, iter_184_1 in pairs(arg_181_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["10015"]) and arg_181_1.var_.actorSpriteComps10015 then
				for iter_184_2, iter_184_3 in pairs(arg_181_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_184_3 then
						iter_184_3.color = arg_181_1.isInRecall_ and (arg_181_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_181_1.var_.actorSpriteComps10015 = nil
			end

			local var_184_2 = arg_181_1.actors_["10016"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_2) then
				local var_184_3 = var_184_2:GetComponent("Image")

				if var_184_3 then
					arg_181_1.var_.highlightMatValue10016 = var_184_3
				end
			end

			local var_184_4 = 0.034

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 and not isNil(var_184_2) then
				if arg_181_1.var_.highlightMatValue10016 then
					local var_184_5 = Mathf.Lerp(0.5, 1, (arg_181_1.time_ - 0) / var_184_4)

					arg_181_1.var_.highlightMatValue10016.color.r = var_184_5
					arg_181_1.var_.highlightMatValue10016.color.g = var_184_5
					arg_181_1.var_.highlightMatValue10016.color.b = var_184_5
					arg_181_1.var_.highlightMatValue10016.color = arg_181_1.var_.highlightMatValue10016.color
				end
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 and not isNil(var_184_2) and arg_181_1.var_.highlightMatValue10016 then
				var_184_2.transform:SetSiblingIndex(1)

				arg_181_1.var_.highlightMatValue10016.color.r = 1
				arg_181_1.var_.highlightMatValue10016.color.g = 1
				arg_181_1.var_.highlightMatValue10016.color.b = 1
				arg_181_1.var_.highlightMatValue10016.color = arg_181_1.var_.highlightMatValue10016.color
			end

			local var_184_6 = 0
			local var_184_7 = 0.45

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_6 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_8 = arg_181_1:GetWordFromCfg(114291044)
				local var_184_9 = arg_181_1:FormatText(var_184_8.content)

				arg_181_1.text_.text = var_184_9

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_11 = 18 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_9) / 18)

				if (18 <= 0 and var_184_7 or var_184_7 * (utf8.len(var_184_9) / 18)) > 0 and var_184_7 < var_184_11 then
					arg_181_1.talkMaxDuration = var_184_11

					if var_184_11 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_11 + var_184_6
					end
				end

				arg_181_1.text_.text = var_184_9
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291044", "story_v_out_114291.awb") ~= 0 then
					local var_184_12 = manager.audio:GetVoiceLength("story_v_out_114291", "114291044", "story_v_out_114291.awb") / 1000

					if var_184_12 + var_184_6 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_12 + var_184_6
					end

					if var_184_8.prefab_name ~= "" and arg_181_1.actors_[var_184_8.prefab_name] ~= nil then
						local var_184_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_8.prefab_name].transform, "story_v_out_114291", "114291044", "story_v_out_114291.awb")

						arg_181_1:RecordAudio("114291044", var_184_13)
						arg_181_1:RecordAudio("114291044", var_184_13)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_114291", "114291044", "story_v_out_114291.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_114291", "114291044", "story_v_out_114291.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_14 = math.max(var_184_7, arg_181_1.talkMaxDuration)

			if var_184_6 <= arg_181_1.time_ and arg_181_1.time_ < var_184_6 + var_184_14 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_6) / var_184_14

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_6 + var_184_14 and arg_181_1.time_ < var_184_6 + var_184_14 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play114291045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 114291045
		arg_185_1.duration_ = 3.27

		local var_185_0 = {
			ja = 3.266,
			ko = 1.8,
			zh = 2.133,
			en = 1.866
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
				arg_185_0:Play114291046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10015 = arg_185_1.actors_["10015"].transform.localPosition
				arg_185_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10015", 4)

				for iter_188_0 = 0, arg_185_1.actors_["10015"].transform.childCount - 1 do
					local var_188_0 = arg_185_1.actors_["10015"].transform:GetChild(iter_188_0)

					if var_188_0.name == "split_2" or not string.find(var_188_0.name, "split") then
						var_188_0.gameObject:SetActive(true)
					else
						var_188_0.gameObject:SetActive(false)
					end
				end
			end

			local var_188_1 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_185_1.time_ - 0) / var_188_1)
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_188_2 = arg_185_1.actors_["10015"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps10015 == nil then
				arg_185_1.var_.actorSpriteComps10015 = var_188_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_3 = 0.034

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_3 and not isNil(var_188_2) then
				if arg_185_1.var_.actorSpriteComps10015 then
					for iter_188_1, iter_188_2 in pairs(arg_185_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_188_2 then
							if arg_185_1.isInRecall_ then
								iter_188_2.color = Color.New(Mathf.Lerp(iter_188_2.color.r, arg_185_1.hightColor1.r, (arg_185_1.time_ - 0) / var_188_3), Mathf.Lerp(iter_188_2.color.g, arg_185_1.hightColor1.g, (arg_185_1.time_ - 0) / var_188_3), (Mathf.Lerp(iter_188_2.color.b, arg_185_1.hightColor1.b, (arg_185_1.time_ - 0) / var_188_3)))
							else
								local var_188_4 = Mathf.Lerp(iter_188_2.color.r, 1, (arg_185_1.time_ - 0) / var_188_3)

								iter_188_2.color = Color.New(var_188_4, var_188_4, var_188_4)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_3 and arg_185_1.time_ < 0 + var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps10015 then
				for iter_188_3, iter_188_4 in pairs(arg_185_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_188_4 then
						iter_188_4.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_185_1.var_.actorSpriteComps10015 = nil
			end

			local var_188_5 = arg_185_1.actors_["10016"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_5) then
				local var_188_6 = var_188_5:GetComponent("Image")

				if var_188_6 then
					arg_185_1.var_.highlightMatValue10016 = var_188_6
				end
			end

			local var_188_7 = 0.034

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 and not isNil(var_188_5) then
				if arg_185_1.var_.highlightMatValue10016 then
					local var_188_8 = Mathf.Lerp(1, 0.5, (arg_185_1.time_ - 0) / var_188_7)

					arg_185_1.var_.highlightMatValue10016.color.r = var_188_8
					arg_185_1.var_.highlightMatValue10016.color.g = var_188_8
					arg_185_1.var_.highlightMatValue10016.color.b = var_188_8
					arg_185_1.var_.highlightMatValue10016.color = arg_185_1.var_.highlightMatValue10016.color
				end
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.highlightMatValue10016 then
				arg_185_1.var_.highlightMatValue10016.color.r = 0.5
				arg_185_1.var_.highlightMatValue10016.color.g = 0.5
				arg_185_1.var_.highlightMatValue10016.color.b = 0.5
				arg_185_1.var_.highlightMatValue10016.color = arg_185_1.var_.highlightMatValue10016.color
			end

			local var_188_9 = 0
			local var_188_10 = 0.225

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_9 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_11 = arg_185_1:GetWordFromCfg(114291045)
				local var_188_12 = arg_185_1:FormatText(var_188_11.content)

				arg_185_1.text_.text = var_188_12

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_14 = 9 <= 0 and var_188_10 or var_188_10 * (utf8.len(var_188_12) / 9)

				if (9 <= 0 and var_188_10 or var_188_10 * (utf8.len(var_188_12) / 9)) > 0 and var_188_10 < var_188_14 then
					arg_185_1.talkMaxDuration = var_188_14

					if var_188_14 + var_188_9 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_9
					end
				end

				arg_185_1.text_.text = var_188_12
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291045", "story_v_out_114291.awb") ~= 0 then
					local var_188_15 = manager.audio:GetVoiceLength("story_v_out_114291", "114291045", "story_v_out_114291.awb") / 1000

					if var_188_15 + var_188_9 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_15 + var_188_9
					end

					if var_188_11.prefab_name ~= "" and arg_185_1.actors_[var_188_11.prefab_name] ~= nil then
						local var_188_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_11.prefab_name].transform, "story_v_out_114291", "114291045", "story_v_out_114291.awb")

						arg_185_1:RecordAudio("114291045", var_188_16)
						arg_185_1:RecordAudio("114291045", var_188_16)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_114291", "114291045", "story_v_out_114291.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_114291", "114291045", "story_v_out_114291.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_17 = math.max(var_188_10, arg_185_1.talkMaxDuration)

			if var_188_9 <= arg_185_1.time_ and arg_185_1.time_ < var_188_9 + var_188_17 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_9) / var_188_17

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_9 + var_188_17 and arg_185_1.time_ < var_188_9 + var_188_17 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play114291046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 114291046
		arg_189_1.duration_ = 4.13

		local var_189_0 = {
			ja = 3.266,
			ko = 1.2,
			zh = 1.433,
			en = 4.133
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
				arg_189_0:Play114291047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10016 = arg_189_1.actors_["10016"].transform.localPosition
				arg_189_1.actors_["10016"].transform.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10016", 3)
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["10016"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10016, Vector3.New(0, -350, -180), (arg_189_1.time_ - 0) / var_192_0)
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["10016"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_192_1 = arg_189_1.actors_["10016"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_1) then
				local var_192_2 = var_192_1:GetComponent("Image")

				if var_192_2 then
					arg_189_1.var_.highlightMatValue10016 = var_192_2
				end
			end

			local var_192_3 = 0.034

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_1) then
				if arg_189_1.var_.highlightMatValue10016 then
					local var_192_4 = Mathf.Lerp(0.5, 1, (arg_189_1.time_ - 0) / var_192_3)

					arg_189_1.var_.highlightMatValue10016.color.r = var_192_4
					arg_189_1.var_.highlightMatValue10016.color.g = var_192_4
					arg_189_1.var_.highlightMatValue10016.color.b = var_192_4
					arg_189_1.var_.highlightMatValue10016.color = arg_189_1.var_.highlightMatValue10016.color
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_1) and arg_189_1.var_.highlightMatValue10016 then
				var_192_1.transform:SetSiblingIndex(1)

				arg_189_1.var_.highlightMatValue10016.color.r = 1
				arg_189_1.var_.highlightMatValue10016.color.g = 1
				arg_189_1.var_.highlightMatValue10016.color.b = 1
				arg_189_1.var_.highlightMatValue10016.color = arg_189_1.var_.highlightMatValue10016.color
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				local var_192_5 = arg_189_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_192_5 then
					arg_189_1.var_.alphaOldValue10015 = var_192_5.alpha
					arg_189_1.var_.characterEffect10015 = var_192_5
				end

				arg_189_1.var_.alphaOldValue10015 = 1
			end

			local var_192_6 = 0.5

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_6 then
				if arg_189_1.var_.characterEffect10015 then
					arg_189_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_189_1.var_.alphaOldValue10015, 0, (arg_189_1.time_ - 0) / var_192_6)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_6 and arg_189_1.time_ < 0 + var_192_6 + arg_192_0 and arg_189_1.var_.characterEffect10015 then
				arg_189_1.var_.characterEffect10015.alpha = 0
			end

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				local var_192_7 = arg_189_1.actors_["10016"]:GetComponent("Image")

				if var_192_7 then
					arg_189_1.var_.alphaMatValue10016 = var_192_7
					arg_189_1.var_.alphaOldValue10016 = var_192_7.color.a
				end

				arg_189_1.var_.alphaOldValue10016 = 0
			end

			local var_192_8 = 0.5

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_8 then
				if arg_189_1.var_.alphaMatValue10016 then
					arg_189_1.var_.alphaMatValue10016.color.a = Mathf.Lerp(arg_189_1.var_.alphaOldValue10016, 1, (arg_189_1.time_ - 0) / var_192_8)
					arg_189_1.var_.alphaMatValue10016.color = arg_189_1.var_.alphaMatValue10016.color
				end
			end

			if arg_189_1.time_ >= 0 + var_192_8 and arg_189_1.time_ < 0 + var_192_8 + arg_192_0 and arg_189_1.var_.alphaMatValue10016 then
				arg_189_1.var_.alphaMatValue10016.color.a = 1
				arg_189_1.var_.alphaMatValue10016.color = arg_189_1.var_.alphaMatValue10016.color
			end

			local var_192_9 = 0
			local var_192_10 = 0.05

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_9 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_11 = arg_189_1:GetWordFromCfg(114291046)
				local var_192_12 = arg_189_1:FormatText(var_192_11.content)

				arg_189_1.text_.text = var_192_12

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_14 = 2 <= 0 and var_192_10 or var_192_10 * (utf8.len(var_192_12) / 2)

				if (2 <= 0 and var_192_10 or var_192_10 * (utf8.len(var_192_12) / 2)) > 0 and var_192_10 < var_192_14 then
					arg_189_1.talkMaxDuration = var_192_14

					if var_192_14 + var_192_9 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_14 + var_192_9
					end
				end

				arg_189_1.text_.text = var_192_12
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291046", "story_v_out_114291.awb") ~= 0 then
					local var_192_15 = manager.audio:GetVoiceLength("story_v_out_114291", "114291046", "story_v_out_114291.awb") / 1000

					if var_192_15 + var_192_9 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_15 + var_192_9
					end

					if var_192_11.prefab_name ~= "" and arg_189_1.actors_[var_192_11.prefab_name] ~= nil then
						local var_192_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_11.prefab_name].transform, "story_v_out_114291", "114291046", "story_v_out_114291.awb")

						arg_189_1:RecordAudio("114291046", var_192_16)
						arg_189_1:RecordAudio("114291046", var_192_16)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_114291", "114291046", "story_v_out_114291.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_114291", "114291046", "story_v_out_114291.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_17 = math.max(var_192_10, arg_189_1.talkMaxDuration)

			if var_192_9 <= arg_189_1.time_ and arg_189_1.time_ < var_192_9 + var_192_17 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_9) / var_192_17

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_9 + var_192_17 and arg_189_1.time_ < var_192_9 + var_192_17 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10016",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play114291047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 114291047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play114291048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				local var_196_0 = arg_193_1.actors_["10016"]:GetComponent("Image")

				if var_196_0 then
					arg_193_1.var_.alphaMatValue10016 = var_196_0
					arg_193_1.var_.alphaOldValue10016 = var_196_0.color.a
				end

				arg_193_1.var_.alphaOldValue10016 = 1
			end

			local var_196_1 = 0.5

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_1 then
				if arg_193_1.var_.alphaMatValue10016 then
					arg_193_1.var_.alphaMatValue10016.color.a = Mathf.Lerp(arg_193_1.var_.alphaOldValue10016, 0, (arg_193_1.time_ - 0) / var_196_1)
					arg_193_1.var_.alphaMatValue10016.color = arg_193_1.var_.alphaMatValue10016.color
				end
			end

			if arg_193_1.time_ >= 0 + var_196_1 and arg_193_1.time_ < 0 + var_196_1 + arg_196_0 and arg_193_1.var_.alphaMatValue10016 then
				arg_193_1.var_.alphaMatValue10016.color.a = 0
				arg_193_1.var_.alphaMatValue10016.color = arg_193_1.var_.alphaMatValue10016.color
			end

			local var_196_2 = 0
			local var_196_3 = 1.125

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_2 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, false)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_4 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(114291047).content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_6 = 45 <= 0 and var_196_3 or var_196_3 * (utf8.len(var_196_4) / 45)

				if (45 <= 0 and var_196_3 or var_196_3 * (utf8.len(var_196_4) / 45)) > 0 and var_196_3 < var_196_6 then
					arg_193_1.talkMaxDuration = var_196_6

					if var_196_6 + var_196_2 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_6 + var_196_2
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_7 = math.max(var_196_3, arg_193_1.talkMaxDuration)

			if var_196_2 <= arg_193_1.time_ and arg_193_1.time_ < var_196_2 + var_196_7 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_2) / var_196_7

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_2 + var_196_7 and arg_193_1.time_ < var_196_2 + var_196_7 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play114291048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 114291048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play114291049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.55

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(114291048).content)

				arg_197_1.text_.text = var_200_1

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_3 = 22 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 22)

				if (22 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_1) / 22)) > 0 and var_200_0 < var_200_3 then
					arg_197_1.talkMaxDuration = var_200_3

					if var_200_3 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_3 + 0
					end
				end

				arg_197_1.text_.text = var_200_1
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_4 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_4

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play114291049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 114291049
		arg_201_1.duration_ = 12.7

		local var_201_0 = {
			ja = 12.7,
			ko = 8.733,
			zh = 6.5,
			en = 6.566
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
				arg_201_0:Play114291050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10015 = arg_201_1.actors_["10015"].transform.localPosition
				arg_201_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10015", 4)

				for iter_204_0 = 0, arg_201_1.actors_["10015"].transform.childCount - 1 do
					local var_204_0 = arg_201_1.actors_["10015"].transform:GetChild(iter_204_0)

					if var_204_0.name == "split_1" or not string.find(var_204_0.name, "split") then
						var_204_0.gameObject:SetActive(true)
					else
						var_204_0.gameObject:SetActive(false)
					end
				end
			end

			local var_204_1 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_1 then
				arg_201_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_201_1.time_ - 0) / var_204_1)
			end

			if arg_201_1.time_ >= 0 + var_204_1 and arg_201_1.time_ < 0 + var_204_1 + arg_204_0 then
				arg_201_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_204_2 = arg_201_1.actors_["10016"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10016 = var_204_2.localPosition
				var_204_2.localScale = Vector3.New(1, 1, 1)

				arg_201_1:CheckSpriteTmpPos("10016", 2)
			end

			local var_204_3 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 then
				var_204_2.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10016, Vector3.New(-390, -350, -180), (arg_201_1.time_ - 0) / var_204_3)
			end

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 then
				var_204_2.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_204_4 = arg_201_1.actors_["10015"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.actorSpriteComps10015 == nil then
				arg_201_1.var_.actorSpriteComps10015 = var_204_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_5 = 0.034

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_5 and not isNil(var_204_4) then
				if arg_201_1.var_.actorSpriteComps10015 then
					for iter_204_1, iter_204_2 in pairs(arg_201_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_204_2 then
							if arg_201_1.isInRecall_ then
								iter_204_2.color = Color.New(Mathf.Lerp(iter_204_2.color.r, arg_201_1.hightColor1.r, (arg_201_1.time_ - 0) / var_204_5), Mathf.Lerp(iter_204_2.color.g, arg_201_1.hightColor1.g, (arg_201_1.time_ - 0) / var_204_5), (Mathf.Lerp(iter_204_2.color.b, arg_201_1.hightColor1.b, (arg_201_1.time_ - 0) / var_204_5)))
							else
								local var_204_6 = Mathf.Lerp(iter_204_2.color.r, 1, (arg_201_1.time_ - 0) / var_204_5)

								iter_204_2.color = Color.New(var_204_6, var_204_6, var_204_6)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_5 and arg_201_1.time_ < 0 + var_204_5 + arg_204_0 and not isNil(var_204_4) and arg_201_1.var_.actorSpriteComps10015 then
				for iter_204_3, iter_204_4 in pairs(arg_201_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_204_4 then
						iter_204_4.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_201_1.var_.actorSpriteComps10015 = nil
			end

			local var_204_7 = arg_201_1.actors_["10016"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_7) then
				local var_204_8 = var_204_7:GetComponent("Image")

				if var_204_8 then
					arg_201_1.var_.highlightMatValue10016 = var_204_8
				end
			end

			local var_204_9 = 0.034

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_9 and not isNil(var_204_7) then
				if arg_201_1.var_.highlightMatValue10016 then
					local var_204_10 = Mathf.Lerp(1, 0.5, (arg_201_1.time_ - 0) / var_204_9)

					arg_201_1.var_.highlightMatValue10016.color.r = var_204_10
					arg_201_1.var_.highlightMatValue10016.color.g = var_204_10
					arg_201_1.var_.highlightMatValue10016.color.b = var_204_10
					arg_201_1.var_.highlightMatValue10016.color = arg_201_1.var_.highlightMatValue10016.color
				end
			end

			if arg_201_1.time_ >= 0 + var_204_9 and arg_201_1.time_ < 0 + var_204_9 + arg_204_0 and not isNil(var_204_7) and arg_201_1.var_.highlightMatValue10016 then
				arg_201_1.var_.highlightMatValue10016.color.r = 0.5
				arg_201_1.var_.highlightMatValue10016.color.g = 0.5
				arg_201_1.var_.highlightMatValue10016.color.b = 0.5
				arg_201_1.var_.highlightMatValue10016.color = arg_201_1.var_.highlightMatValue10016.color
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				local var_204_11 = arg_201_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_204_11 then
					arg_201_1.var_.alphaOldValue10015 = var_204_11.alpha
					arg_201_1.var_.characterEffect10015 = var_204_11
				end

				arg_201_1.var_.alphaOldValue10015 = 0
			end

			local var_204_12 = 0.5

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_12 then
				if arg_201_1.var_.characterEffect10015 then
					arg_201_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_201_1.var_.alphaOldValue10015, 1, (arg_201_1.time_ - 0) / var_204_12)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_12 and arg_201_1.time_ < 0 + var_204_12 + arg_204_0 and arg_201_1.var_.characterEffect10015 then
				arg_201_1.var_.characterEffect10015.alpha = 1
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				local var_204_13 = arg_201_1.actors_["10016"]:GetComponent("Image")

				if var_204_13 then
					arg_201_1.var_.alphaMatValue10016 = var_204_13
					arg_201_1.var_.alphaOldValue10016 = var_204_13.color.a
				end

				arg_201_1.var_.alphaOldValue10016 = 0
			end

			local var_204_14 = 0.5

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_14 then
				if arg_201_1.var_.alphaMatValue10016 then
					arg_201_1.var_.alphaMatValue10016.color.a = Mathf.Lerp(arg_201_1.var_.alphaOldValue10016, 1, (arg_201_1.time_ - 0) / var_204_14)
					arg_201_1.var_.alphaMatValue10016.color = arg_201_1.var_.alphaMatValue10016.color
				end
			end

			if arg_201_1.time_ >= 0 + var_204_14 and arg_201_1.time_ < 0 + var_204_14 + arg_204_0 and arg_201_1.var_.alphaMatValue10016 then
				arg_201_1.var_.alphaMatValue10016.color.a = 1
				arg_201_1.var_.alphaMatValue10016.color = arg_201_1.var_.alphaMatValue10016.color
			end

			local var_204_15 = 0
			local var_204_16 = 0.7

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_15 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_17 = arg_201_1:GetWordFromCfg(114291049)
				local var_204_18 = arg_201_1:FormatText(var_204_17.content)

				arg_201_1.text_.text = var_204_18

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_20 = 28 <= 0 and var_204_16 or var_204_16 * (utf8.len(var_204_18) / 28)

				if (28 <= 0 and var_204_16 or var_204_16 * (utf8.len(var_204_18) / 28)) > 0 and var_204_16 < var_204_20 then
					arg_201_1.talkMaxDuration = var_204_20

					if var_204_20 + var_204_15 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_20 + var_204_15
					end
				end

				arg_201_1.text_.text = var_204_18
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291049", "story_v_out_114291.awb") ~= 0 then
					local var_204_21 = manager.audio:GetVoiceLength("story_v_out_114291", "114291049", "story_v_out_114291.awb") / 1000

					if var_204_21 + var_204_15 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_21 + var_204_15
					end

					if var_204_17.prefab_name ~= "" and arg_201_1.actors_[var_204_17.prefab_name] ~= nil then
						local var_204_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_17.prefab_name].transform, "story_v_out_114291", "114291049", "story_v_out_114291.awb")

						arg_201_1:RecordAudio("114291049", var_204_22)
						arg_201_1:RecordAudio("114291049", var_204_22)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_114291", "114291049", "story_v_out_114291.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_114291", "114291049", "story_v_out_114291.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_23 = math.max(var_204_16, arg_201_1.talkMaxDuration)

			if var_204_15 <= arg_201_1.time_ and arg_201_1.time_ < var_204_15 + var_204_23 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_15) / var_204_23

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_15 + var_204_23 and arg_201_1.time_ < var_204_15 + var_204_23 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10016",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play114291050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 114291050
		arg_205_1.duration_ = 21.43

		local var_205_0 = {
			ja = 17.6,
			ko = 19.266,
			zh = 16.6,
			en = 21.433
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
			arg_205_1.auto_ = false
		end

		function arg_205_1.playNext_(arg_207_0)
			arg_205_1.onStoryFinished_()
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos10015 = arg_205_1.actors_["10015"].transform.localPosition
				arg_205_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("10015", 4)

				for iter_208_0 = 0, arg_205_1.actors_["10015"].transform.childCount - 1 do
					local var_208_0 = arg_205_1.actors_["10015"].transform:GetChild(iter_208_0)

					if var_208_0.name == "split_2" or not string.find(var_208_0.name, "split") then
						var_208_0.gameObject:SetActive(true)
					else
						var_208_0.gameObject:SetActive(false)
					end
				end
			end

			local var_208_1 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_1 then
				arg_205_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_205_1.time_ - 0) / var_208_1)
			end

			if arg_205_1.time_ >= 0 + var_208_1 and arg_205_1.time_ < 0 + var_208_1 + arg_208_0 then
				arg_205_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_208_2 = arg_205_1.actors_["10015"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps10015 == nil then
				arg_205_1.var_.actorSpriteComps10015 = var_208_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_3 = 0.034

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 and not isNil(var_208_2) then
				if arg_205_1.var_.actorSpriteComps10015 then
					for iter_208_1, iter_208_2 in pairs(arg_205_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_208_2 then
							if arg_205_1.isInRecall_ then
								iter_208_2.color = Color.New(Mathf.Lerp(iter_208_2.color.r, arg_205_1.hightColor1.r, (arg_205_1.time_ - 0) / var_208_3), Mathf.Lerp(iter_208_2.color.g, arg_205_1.hightColor1.g, (arg_205_1.time_ - 0) / var_208_3), (Mathf.Lerp(iter_208_2.color.b, arg_205_1.hightColor1.b, (arg_205_1.time_ - 0) / var_208_3)))
							else
								local var_208_4 = Mathf.Lerp(iter_208_2.color.r, 1, (arg_205_1.time_ - 0) / var_208_3)

								iter_208_2.color = Color.New(var_208_4, var_208_4, var_208_4)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.actorSpriteComps10015 then
				for iter_208_3, iter_208_4 in pairs(arg_205_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_208_4 then
						iter_208_4.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_205_1.var_.actorSpriteComps10015 = nil
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				local var_208_5 = arg_205_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_208_5 then
					arg_205_1.var_.alphaOldValue10015 = var_208_5.alpha
					arg_205_1.var_.characterEffect10015 = var_208_5
				end

				arg_205_1.var_.alphaOldValue10015 = 0
			end

			local var_208_6 = 0.0166666666666667

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_6 then
				if arg_205_1.var_.characterEffect10015 then
					arg_205_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_205_1.var_.alphaOldValue10015, 1, (arg_205_1.time_ - 0) / var_208_6)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_6 and arg_205_1.time_ < 0 + var_208_6 + arg_208_0 and arg_205_1.var_.characterEffect10015 then
				arg_205_1.var_.characterEffect10015.alpha = 1
			end

			local var_208_7 = 0
			local var_208_8 = 1.575

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_7 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_9 = arg_205_1:GetWordFromCfg(114291050)
				local var_208_10 = arg_205_1:FormatText(var_208_9.content)

				arg_205_1.text_.text = var_208_10

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_12 = 63 <= 0 and var_208_8 or var_208_8 * (utf8.len(var_208_10) / 63)

				if (63 <= 0 and var_208_8 or var_208_8 * (utf8.len(var_208_10) / 63)) > 0 and var_208_8 < var_208_12 then
					arg_205_1.talkMaxDuration = var_208_12

					if var_208_12 + var_208_7 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_12 + var_208_7
					end
				end

				arg_205_1.text_.text = var_208_10
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114291", "114291050", "story_v_out_114291.awb") ~= 0 then
					local var_208_13 = manager.audio:GetVoiceLength("story_v_out_114291", "114291050", "story_v_out_114291.awb") / 1000

					if var_208_13 + var_208_7 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_13 + var_208_7
					end

					if var_208_9.prefab_name ~= "" and arg_205_1.actors_[var_208_9.prefab_name] ~= nil then
						local var_208_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_9.prefab_name].transform, "story_v_out_114291", "114291050", "story_v_out_114291.awb")

						arg_205_1:RecordAudio("114291050", var_208_14)
						arg_205_1:RecordAudio("114291050", var_208_14)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_114291", "114291050", "story_v_out_114291.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_114291", "114291050", "story_v_out_114291.awb")
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
				actorName = "10015",
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
	assets = {
		"TextureConfig/Background/ST26",
		"TextureConfig/Background/OM0503"
	},
	voices = {
		"story_v_out_114291.awb"
	}
}
