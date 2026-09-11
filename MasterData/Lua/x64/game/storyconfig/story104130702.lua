return {
	Play413072001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413072001
		arg_1_1.duration_ = 5.57

		local var_1_0 = {
			zh = 4.332999999998,
			ja = 5.565999999998
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
				arg_1_0:Play413072002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F08g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08g")
				var_4_0.name = "F08g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F08g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F08g

				arg_1_1.bgs_.F08g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F08g" then
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

			local var_4_9 = "10022"

			if arg_1_1.actors_["10022"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

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

			local var_4_12 = arg_1_1.actors_["10022"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10022 = var_4_12.localPosition
				var_4_12.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10022", 3)

				for iter_4_4 = 0, var_4_12.childCount - 1 do
					local var_4_13 = var_4_12:GetChild(iter_4_4)

					if var_4_13.name == "split_6" or not string.find(var_4_13.name, "split") then
						var_4_13.gameObject:SetActive(true)
					else
						var_4_13.gameObject:SetActive(false)
					end
				end
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_1_1.time_ - 1.8) / var_4_14)
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -315, -320)
			end

			local var_4_15 = arg_1_1.actors_["10022"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps10022 == nil then
				arg_1_1.var_.actorSpriteComps10022 = var_4_15:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_16 = 2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.actorSpriteComps10022 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								iter_4_6.color = Color.New(Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 0) / var_4_16), Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 0) / var_4_16), (Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 0) / var_4_16)))
							else
								local var_4_17 = Mathf.Lerp(iter_4_6.color.r, 1, (arg_1_1.time_ - 0) / var_4_16)

								iter_4_6.color = Color.New(var_4_17, var_4_17, var_4_17)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 0 + var_4_16 and arg_1_1.time_ < 0 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.actorSpriteComps10022 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10022 = nil
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue10022 = var_4_18.alpha
					arg_1_1.var_.characterEffect10022 = var_4_18
				end

				arg_1_1.var_.alphaOldValue10022 = 0
			end

			local var_4_19 = 0.5

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_19 then
				if arg_1_1.var_.characterEffect10022 then
					arg_1_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10022, 1, (arg_1_1.time_ - 1.8) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_19 and arg_1_1.time_ < 1.8 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect10022 then
				arg_1_1.var_.characterEffect10022.alpha = 1
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

			if 0.366666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.366666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense.awb")

				local var_4_25 = manager.audio:GetAudioName("bgm_activity_3_4_story_crete_intense", "bgm_activity_3_4_story_crete_intense")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_26 = 1.999999999998
			local var_4_27 = 0.3

			if 1.999999999998 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_28 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_28:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_29 = arg_1_1:GetWordFromCfg(413072001)
				local var_4_30 = arg_1_1:FormatText(var_4_29.content)

				arg_1_1.text_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_32 = 12 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 12)

				if (12 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 12)) > 0 and var_4_27 < var_4_32 then
					arg_1_1.talkMaxDuration = var_4_32
					var_4_26 = var_4_26 + 0.3

					if var_4_32 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_26
					end
				end

				arg_1_1.text_.text = var_4_30
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072001", "story_v_out_413072.awb") ~= 0 then
					local var_4_33 = manager.audio:GetVoiceLength("story_v_out_413072", "413072001", "story_v_out_413072.awb") / 1000

					if var_4_33 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_26
					end

					if var_4_29.prefab_name ~= "" and arg_1_1.actors_[var_4_29.prefab_name] ~= nil then
						local var_4_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_29.prefab_name].transform, "story_v_out_413072", "413072001", "story_v_out_413072.awb")

						arg_1_1:RecordAudio("413072001", var_4_34)
						arg_1_1:RecordAudio("413072001", var_4_34)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413072", "413072001", "story_v_out_413072.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413072", "413072001", "story_v_out_413072.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_35 = var_4_26 + 0.3
			local var_4_36 = math.max(var_4_27, arg_1_1.talkMaxDuration)

			if var_4_26 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_35 + var_4_36 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_35) / var_4_36

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_35 + var_4_36 and arg_1_1.time_ < var_4_35 + var_4_36 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10022",
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
	Play413072002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413072002
		arg_9_1.duration_ = 3.1

		local var_9_0 = {
			zh = 1.166,
			ja = 3.1
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
				arg_9_0:Play413072003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.175

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(413072002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 7 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 7)

				if (7 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 7)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072002", "story_v_out_413072.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_413072", "413072002", "story_v_out_413072.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_413072", "413072002", "story_v_out_413072.awb")

						arg_9_1:RecordAudio("413072002", var_12_6)
						arg_9_1:RecordAudio("413072002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413072", "413072002", "story_v_out_413072.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413072", "413072002", "story_v_out_413072.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play413072003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413072003
		arg_13_1.duration_ = 4.3

		local var_13_0 = {
			zh = 3.733,
			ja = 4.3
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
				arg_13_0:Play413072004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10022 = arg_13_1.actors_["10022"].transform.localPosition
				arg_13_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10022", 3)

				for iter_16_0 = 0, arg_13_1.actors_["10022"].transform.childCount - 1 do
					local var_16_0 = arg_13_1.actors_["10022"].transform:GetChild(iter_16_0)

					if var_16_0.name == "split_6" or not string.find(var_16_0.name, "split") then
						var_16_0.gameObject:SetActive(true)
					else
						var_16_0.gameObject:SetActive(false)
					end
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_13_1.time_ - 0) / var_16_1)
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_16_2 = arg_13_1.actors_["10022"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps10022 == nil then
				arg_13_1.var_.actorSpriteComps10022 = var_16_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_3 = 2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.actorSpriteComps10022 then
					for iter_16_1, iter_16_2 in pairs(arg_13_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps10022 then
				for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_16_4 then
						iter_16_4.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps10022 = nil
			end

			local var_16_5 = 0
			local var_16_6 = 0.425

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

				local var_16_7 = arg_13_1:GetWordFromCfg(413072003)
				local var_16_8 = arg_13_1:FormatText(var_16_7.content)

				arg_13_1.text_.text = var_16_8

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 17 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 17)

				if (17 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 17)) > 0 and var_16_6 < var_16_10 then
					arg_13_1.talkMaxDuration = var_16_10

					if var_16_10 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_8
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072003", "story_v_out_413072.awb") ~= 0 then
					local var_16_11 = manager.audio:GetVoiceLength("story_v_out_413072", "413072003", "story_v_out_413072.awb") / 1000

					if var_16_11 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_5
					end

					if var_16_7.prefab_name ~= "" and arg_13_1.actors_[var_16_7.prefab_name] ~= nil then
						local var_16_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_7.prefab_name].transform, "story_v_out_413072", "413072003", "story_v_out_413072.awb")

						arg_13_1:RecordAudio("413072003", var_16_12)
						arg_13_1:RecordAudio("413072003", var_16_12)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413072", "413072003", "story_v_out_413072.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413072", "413072003", "story_v_out_413072.awb")
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
	Play413072004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413072004
		arg_17_1.duration_ = 6.77

		local var_17_0 = {
			zh = 2.633,
			ja = 6.766
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
				arg_17_0:Play413072005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10022"]) and arg_17_1.var_.actorSpriteComps10022 == nil then
				arg_17_1.var_.actorSpriteComps10022 = arg_17_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10022"]) then
				if arg_17_1.var_.actorSpriteComps10022 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_20_1 then
							if arg_17_1.isInRecall_ then
								iter_20_1.color = Color.New(Mathf.Lerp(iter_20_1.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_0), Mathf.Lerp(iter_20_1.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_0), (Mathf.Lerp(iter_20_1.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_0)))
							else
								local var_20_1 = Mathf.Lerp(iter_20_1.color.r, 1, (arg_17_1.time_ - 0) / var_20_0)

								iter_20_1.color = Color.New(var_20_1, var_20_1, var_20_1)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10022"]) and arg_17_1.var_.actorSpriteComps10022 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps10022 = nil
			end

			local var_20_2 = 0
			local var_20_3 = 0.375

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_4 = arg_17_1:GetWordFromCfg(413072004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 15 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 15)

				if (15 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 15)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072004", "story_v_out_413072.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072004", "story_v_out_413072.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_413072", "413072004", "story_v_out_413072.awb")

						arg_17_1:RecordAudio("413072004", var_20_9)
						arg_17_1:RecordAudio("413072004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413072", "413072004", "story_v_out_413072.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413072", "413072004", "story_v_out_413072.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_3, arg_17_1.talkMaxDuration)

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_2) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_2 + var_20_10 and arg_17_1.time_ < var_20_2 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play413072005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413072005
		arg_21_1.duration_ = 5

		local var_21_0 = {
			zh = 2.2,
			ja = 5
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
				arg_21_0:Play413072006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.25

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(413072005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 10 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 10)

				if (10 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 10)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072005", "story_v_out_413072.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_413072", "413072005", "story_v_out_413072.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_413072", "413072005", "story_v_out_413072.awb")

						arg_21_1:RecordAudio("413072005", var_24_6)
						arg_21_1:RecordAudio("413072005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413072", "413072005", "story_v_out_413072.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413072", "413072005", "story_v_out_413072.awb")
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
	Play413072006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413072006
		arg_25_1.duration_ = 5.17

		local var_25_0 = {
			zh = 1.999999999999,
			ja = 5.166
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
				arg_25_0:Play413072007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10022"]) and arg_25_1.var_.actorSpriteComps10022 == nil then
				arg_25_1.var_.actorSpriteComps10022 = arg_25_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_0 = 2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10022"]) then
				if arg_25_1.var_.actorSpriteComps10022 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10022"]) and arg_25_1.var_.actorSpriteComps10022 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_28_3 then
						iter_28_3.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps10022 = nil
			end

			local var_28_2 = 0
			local var_28_3 = 0.175

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[992].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_4 = arg_25_1:GetWordFromCfg(413072006)
				local var_28_5 = arg_25_1:FormatText(var_28_4.content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 7 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 7)

				if (7 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 7)) > 0 and var_28_3 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072006", "story_v_out_413072.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072006", "story_v_out_413072.awb") / 1000

					if var_28_8 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_2
					end

					if var_28_4.prefab_name ~= "" and arg_25_1.actors_[var_28_4.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_4.prefab_name].transform, "story_v_out_413072", "413072006", "story_v_out_413072.awb")

						arg_25_1:RecordAudio("413072006", var_28_9)
						arg_25_1:RecordAudio("413072006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413072", "413072006", "story_v_out_413072.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413072", "413072006", "story_v_out_413072.awb")
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
	Play413072007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413072007
		arg_29_1.duration_ = 11.27

		local var_29_0 = {
			zh = 7.1,
			ja = 11.266
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
				arg_29_0:Play413072008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.bgs_.F08i == nil then
				local var_32_0 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08i")
				var_32_0.name = "F08i"
				var_32_0.transform.parent = arg_29_1.stage_.transform
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_.F08i = var_32_0
			end

			if 2 < arg_29_1.time_ and arg_29_1.time_ <= 2 + arg_32_0 then
				local var_32_1 = arg_29_1.bgs_.F08i

				arg_29_1.bgs_.F08i.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_32_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_2 = var_32_1:GetComponent("SpriteRenderer")

				if var_32_2 and var_32_2.sprite then
					local var_32_3 = 2 * (var_32_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_32_1.transform.localScale = Vector3.New(var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "F08i" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_4 = 4

			if 4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			if arg_29_1.time_ >= var_32_4 + 0.3 and arg_29_1.time_ < var_32_4 + 0.3 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			local var_32_5 = 0

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_6 = 2

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_6 then
				local var_32_7 = Color.New(0, 0, 0)

				var_32_7.a = Mathf.Lerp(0, 1, (arg_29_1.time_ - var_32_5) / var_32_6)
				arg_29_1.mask_.color = var_32_7
			end

			if arg_29_1.time_ >= var_32_5 + var_32_6 and arg_29_1.time_ < var_32_5 + var_32_6 + arg_32_0 then
				local var_32_8 = Color.New(0, 0, 0)

				var_32_8.a = 1
				arg_29_1.mask_.color = var_32_8
			end

			local var_32_9 = 2

			if 2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_10 = 2

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 then
				local var_32_11 = Color.New(0, 0, 0)

				var_32_11.a = Mathf.Lerp(1, 0, (arg_29_1.time_ - var_32_9) / var_32_10)
				arg_29_1.mask_.color = var_32_11
			end

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 then
				local var_32_12 = Color.New(0, 0, 0)

				arg_29_1.mask_.enabled = false
				var_32_12.a = 0
				arg_29_1.mask_.color = var_32_12
			end

			local var_32_13 = arg_29_1.actors_["10022"].transform

			if 1.966 < arg_29_1.time_ and arg_29_1.time_ <= 1.966 + arg_32_0 then
				arg_29_1.var_.moveOldPos10022 = var_32_13.localPosition
				var_32_13.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10022", 7)

				for iter_32_2 = 0, var_32_13.childCount - 1 do
					local var_32_14 = var_32_13:GetChild(iter_32_2)

					if var_32_14.name == "split_3" or not string.find(var_32_14.name, "split") then
						var_32_14.gameObject:SetActive(true)
					else
						var_32_14.gameObject:SetActive(false)
					end
				end
			end

			local var_32_15 = 0.001

			if 1.966 <= arg_29_1.time_ and arg_29_1.time_ < 1.966 + var_32_15 then
				var_32_13.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_29_1.time_ - 1.966) / var_32_15)
			end

			if arg_29_1.time_ >= 1.966 + var_32_15 and arg_29_1.time_ < 1.966 + var_32_15 + arg_32_0 then
				var_32_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_16 = arg_29_1.actors_["10022"]

			if 1.966 < arg_29_1.time_ and arg_29_1.time_ <= 1.966 + arg_32_0 and not isNil(var_32_16) and arg_29_1.var_.actorSpriteComps10022 == nil then
				arg_29_1.var_.actorSpriteComps10022 = var_32_16:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_17 = 0.034

			if 1.966 <= arg_29_1.time_ and arg_29_1.time_ < 1.966 + var_32_17 and not isNil(var_32_16) then
				if arg_29_1.var_.actorSpriteComps10022 then
					for iter_32_3, iter_32_4 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_32_4 then
							if arg_29_1.isInRecall_ then
								iter_32_4.color = Color.New(Mathf.Lerp(iter_32_4.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 1.966) / var_32_17), Mathf.Lerp(iter_32_4.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 1.966) / var_32_17), (Mathf.Lerp(iter_32_4.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 1.966) / var_32_17)))
							else
								local var_32_18 = Mathf.Lerp(iter_32_4.color.r, 1, (arg_29_1.time_ - 1.966) / var_32_17)

								iter_32_4.color = Color.New(var_32_18, var_32_18, var_32_18)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 1.966 + var_32_17 and arg_29_1.time_ < 1.966 + var_32_17 + arg_32_0 and not isNil(var_32_16) and arg_29_1.var_.actorSpriteComps10022 then
				for iter_32_5, iter_32_6 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_32_6 then
						iter_32_6.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10022 = nil
			end

			local var_32_19 = arg_29_1.actors_["10022"]

			if 3.7 < arg_29_1.time_ and arg_29_1.time_ <= 3.7 + arg_32_0 and not isNil(var_32_19) and arg_29_1.var_.actorSpriteComps10022 == nil then
				arg_29_1.var_.actorSpriteComps10022 = var_32_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_20 = 0.034

			if 3.7 <= arg_29_1.time_ and arg_29_1.time_ < 3.7 + var_32_20 and not isNil(var_32_19) then
				if arg_29_1.var_.actorSpriteComps10022 then
					for iter_32_7, iter_32_8 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_32_8 then
							if arg_29_1.isInRecall_ then
								iter_32_8.color = Color.New(Mathf.Lerp(iter_32_8.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 3.7) / var_32_20), Mathf.Lerp(iter_32_8.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 3.7) / var_32_20), (Mathf.Lerp(iter_32_8.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 3.7) / var_32_20)))
							else
								local var_32_21 = Mathf.Lerp(iter_32_8.color.r, 1, (arg_29_1.time_ - 3.7) / var_32_20)

								iter_32_8.color = Color.New(var_32_21, var_32_21, var_32_21)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 3.7 + var_32_20 and arg_29_1.time_ < 3.7 + var_32_20 + arg_32_0 and not isNil(var_32_19) and arg_29_1.var_.actorSpriteComps10022 then
				for iter_32_9, iter_32_10 in pairs(arg_29_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_32_10 then
						iter_32_10.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10022 = nil
			end

			local var_32_22 = arg_29_1.actors_["10022"].transform

			if 3.7 < arg_29_1.time_ and arg_29_1.time_ <= 3.7 + arg_32_0 then
				arg_29_1.var_.moveOldPos10022 = var_32_22.localPosition
				var_32_22.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("10022", 3)

				for iter_32_11 = 0, var_32_22.childCount - 1 do
					local var_32_23 = var_32_22:GetChild(iter_32_11)

					if var_32_23.name == "split_8" or not string.find(var_32_23.name, "split") then
						var_32_23.gameObject:SetActive(true)
					else
						var_32_23.gameObject:SetActive(false)
					end
				end
			end

			local var_32_24 = 0.001

			if 3.7 <= arg_29_1.time_ and arg_29_1.time_ < 3.7 + var_32_24 then
				var_32_22.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_29_1.time_ - 3.7) / var_32_24)
			end

			if arg_29_1.time_ >= 3.7 + var_32_24 and arg_29_1.time_ < 3.7 + var_32_24 + arg_32_0 then
				var_32_22.localPosition = Vector3.New(0, -315, -320)
			end

			if 3.7 < arg_29_1.time_ and arg_29_1.time_ <= 3.7 + arg_32_0 then
				local var_32_25 = arg_29_1.actors_["10022"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_32_25 then
					arg_29_1.var_.alphaOldValue10022 = var_32_25.alpha
					arg_29_1.var_.characterEffect10022 = var_32_25
				end

				arg_29_1.var_.alphaOldValue10022 = 0
			end

			local var_32_26 = 0.3

			if 3.7 <= arg_29_1.time_ and arg_29_1.time_ < 3.7 + var_32_26 then
				if arg_29_1.var_.characterEffect10022 then
					arg_29_1.var_.characterEffect10022.alpha = Mathf.Lerp(arg_29_1.var_.alphaOldValue10022, 1, (arg_29_1.time_ - 3.7) / var_32_26)
				end
			end

			if arg_29_1.time_ >= 3.7 + var_32_26 and arg_29_1.time_ < 3.7 + var_32_26 + arg_32_0 and arg_29_1.var_.characterEffect10022 then
				arg_29_1.var_.characterEffect10022.alpha = 1
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_27 = 4
			local var_32_28 = 0.35

			if 4 < arg_29_1.time_ and arg_29_1.time_ <= var_32_27 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_29 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_29:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_30 = arg_29_1:GetWordFromCfg(413072007)
				local var_32_31 = arg_29_1:FormatText(var_32_30.content)

				arg_29_1.text_.text = var_32_31

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_33 = 14 <= 0 and var_32_28 or var_32_28 * (utf8.len(var_32_31) / 14)

				if (14 <= 0 and var_32_28 or var_32_28 * (utf8.len(var_32_31) / 14)) > 0 and var_32_28 < var_32_33 then
					arg_29_1.talkMaxDuration = var_32_33
					var_32_27 = var_32_27 + 0.3

					if var_32_33 + var_32_27 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_33 + var_32_27
					end
				end

				arg_29_1.text_.text = var_32_31
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072007", "story_v_out_413072.awb") ~= 0 then
					local var_32_34 = manager.audio:GetVoiceLength("story_v_out_413072", "413072007", "story_v_out_413072.awb") / 1000

					if var_32_34 + var_32_27 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_34 + var_32_27
					end

					if var_32_30.prefab_name ~= "" and arg_29_1.actors_[var_32_30.prefab_name] ~= nil then
						local var_32_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_30.prefab_name].transform, "story_v_out_413072", "413072007", "story_v_out_413072.awb")

						arg_29_1:RecordAudio("413072007", var_32_35)
						arg_29_1:RecordAudio("413072007", var_32_35)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_413072", "413072007", "story_v_out_413072.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_413072", "413072007", "story_v_out_413072.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_36 = var_32_27 + 0.3
			local var_32_37 = math.max(var_32_28, arg_29_1.talkMaxDuration)

			if var_32_27 + 0.3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_36 + var_32_37 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_36) / var_32_37

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_36 + var_32_37 and arg_29_1.time_ < var_32_36 + var_32_37 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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
				actorName = "10022",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play413072008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 413072008
		arg_35_1.duration_ = 3.87

		local var_35_0 = {
			zh = 2.566,
			ja = 3.866
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
				arg_35_0:Play413072009(arg_35_1)
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

				local var_38_1 = arg_35_1:GetWordFromCfg(413072008)
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

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072008", "story_v_out_413072.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_out_413072", "413072008", "story_v_out_413072.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_out_413072", "413072008", "story_v_out_413072.awb")

						arg_35_1:RecordAudio("413072008", var_38_6)
						arg_35_1:RecordAudio("413072008", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_413072", "413072008", "story_v_out_413072.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_413072", "413072008", "story_v_out_413072.awb")
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
	Play413072009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 413072009
		arg_39_1.duration_ = 3.77

		local var_39_0 = {
			zh = 2.233,
			ja = 3.766
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
				arg_39_0:Play413072010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.325

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_1 = arg_39_1:GetWordFromCfg(413072009)
				local var_42_2 = arg_39_1:FormatText(var_42_1.content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 13 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 13)

				if (13 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 13)) > 0 and var_42_0 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072009", "story_v_out_413072.awb") ~= 0 then
					local var_42_5 = manager.audio:GetVoiceLength("story_v_out_413072", "413072009", "story_v_out_413072.awb") / 1000

					if var_42_5 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + 0
					end

					if var_42_1.prefab_name ~= "" and arg_39_1.actors_[var_42_1.prefab_name] ~= nil then
						local var_42_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_1.prefab_name].transform, "story_v_out_413072", "413072009", "story_v_out_413072.awb")

						arg_39_1:RecordAudio("413072009", var_42_6)
						arg_39_1:RecordAudio("413072009", var_42_6)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_413072", "413072009", "story_v_out_413072.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_413072", "413072009", "story_v_out_413072.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play413072010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 413072010
		arg_43_1.duration_ = 3.2

		local var_43_0 = {
			zh = 2.666,
			ja = 3.2
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
				arg_43_0:Play413072011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["10022"]) and arg_43_1.var_.actorSpriteComps10022 == nil then
				arg_43_1.var_.actorSpriteComps10022 = arg_43_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_0 = 2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["10022"]) then
				if arg_43_1.var_.actorSpriteComps10022 then
					for iter_46_0, iter_46_1 in pairs(arg_43_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_46_1 then
							if arg_43_1.isInRecall_ then
								iter_46_1.color = Color.New(Mathf.Lerp(iter_46_1.color.r, arg_43_1.hightColor2.r, (arg_43_1.time_ - 0) / var_46_0), Mathf.Lerp(iter_46_1.color.g, arg_43_1.hightColor2.g, (arg_43_1.time_ - 0) / var_46_0), (Mathf.Lerp(iter_46_1.color.b, arg_43_1.hightColor2.b, (arg_43_1.time_ - 0) / var_46_0)))
							else
								local var_46_1 = Mathf.Lerp(iter_46_1.color.r, 0.5, (arg_43_1.time_ - 0) / var_46_0)

								iter_46_1.color = Color.New(var_46_1, var_46_1, var_46_1)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["10022"]) and arg_43_1.var_.actorSpriteComps10022 then
				for iter_46_2, iter_46_3 in pairs(arg_43_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_46_3 then
						iter_46_3.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_43_1.var_.actorSpriteComps10022 = nil
			end

			local var_46_2 = 0
			local var_46_3 = 0.15

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_2 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_4 = arg_43_1:GetWordFromCfg(413072010)
				local var_46_5 = arg_43_1:FormatText(var_46_4.content)

				arg_43_1.text_.text = var_46_5

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_7 = 6 <= 0 and var_46_3 or var_46_3 * (utf8.len(var_46_5) / 6)

				if (6 <= 0 and var_46_3 or var_46_3 * (utf8.len(var_46_5) / 6)) > 0 and var_46_3 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_2 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_2
					end
				end

				arg_43_1.text_.text = var_46_5
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072010", "story_v_out_413072.awb") ~= 0 then
					local var_46_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072010", "story_v_out_413072.awb") / 1000

					if var_46_8 + var_46_2 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_2
					end

					if var_46_4.prefab_name ~= "" and arg_43_1.actors_[var_46_4.prefab_name] ~= nil then
						local var_46_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_4.prefab_name].transform, "story_v_out_413072", "413072010", "story_v_out_413072.awb")

						arg_43_1:RecordAudio("413072010", var_46_9)
						arg_43_1:RecordAudio("413072010", var_46_9)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_413072", "413072010", "story_v_out_413072.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_413072", "413072010", "story_v_out_413072.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_10 = math.max(var_46_3, arg_43_1.talkMaxDuration)

			if var_46_2 <= arg_43_1.time_ and arg_43_1.time_ < var_46_2 + var_46_10 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_2) / var_46_10

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_2 + var_46_10 and arg_43_1.time_ < var_46_2 + var_46_10 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play413072011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 413072011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play413072012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10022 = arg_47_1.actors_["10022"].transform.localPosition
				arg_47_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10022", 7)

				for iter_50_0 = 0, arg_47_1.actors_["10022"].transform.childCount - 1 do
					local var_50_0 = arg_47_1.actors_["10022"].transform:GetChild(iter_50_0)

					if var_50_0.name == "split_2" or not string.find(var_50_0.name, "split") then
						var_50_0.gameObject:SetActive(true)
					else
						var_50_0.gameObject:SetActive(false)
					end
				end
			end

			local var_50_1 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_1 then
				arg_47_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_47_1.time_ - 0) / var_50_1)
			end

			if arg_47_1.time_ >= 0 + var_50_1 and arg_47_1.time_ < 0 + var_50_1 + arg_50_0 then
				arg_47_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_50_2 = 0
			local var_50_3 = 1.45

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_2 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_4 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(413072011).content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_6 = 58 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_4) / 58)

				if (58 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_4) / 58)) > 0 and var_50_3 < var_50_6 then
					arg_47_1.talkMaxDuration = var_50_6

					if var_50_6 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_6 + var_50_2
					end
				end

				arg_47_1.text_.text = var_50_4
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_3, arg_47_1.talkMaxDuration)

			if var_50_2 <= arg_47_1.time_ and arg_47_1.time_ < var_50_2 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_2) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_2 + var_50_7 and arg_47_1.time_ < var_50_2 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
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

		arg_47_1:InitPlayNodeList()
	end,
	Play413072012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 413072012
		arg_51_1.duration_ = 2.87

		local var_51_0 = {
			zh = 1.366,
			ja = 2.866
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
				arg_51_0:Play413072013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.175

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_2")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_1 = arg_51_1:GetWordFromCfg(413072012)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 7 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 7)

				if (7 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 7)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072012", "story_v_out_413072.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_413072", "413072012", "story_v_out_413072.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_413072", "413072012", "story_v_out_413072.awb")

						arg_51_1:RecordAudio("413072012", var_54_6)
						arg_51_1:RecordAudio("413072012", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_413072", "413072012", "story_v_out_413072.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_413072", "413072012", "story_v_out_413072.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play413072013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 413072013
		arg_55_1.duration_ = 2.33

		local var_55_0 = {
			zh = 2.33333333333333,
			ja = 2.03333333333333
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
				arg_55_0:Play413072014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				local var_58_0 = arg_55_1.var_.effect233

				if not arg_55_1.var_.effect233 then
					var_58_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_58_0.name = "233"
					arg_55_1.var_.effect233 = var_58_0
				else
					var_58_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_58_0.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_58_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.633333333333333 < arg_55_1.time_ and arg_55_1.time_ <= 0.633333333333333 + arg_58_0 then
				if arg_55_1.var_.effect233 then
					Object.Destroy(arg_55_1.var_.effect233)

					arg_55_1.var_.effect233 = nil
				end
			end

			local var_58_3 = arg_55_1.actors_["10022"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10022 = var_58_3.localPosition
				var_58_3.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10022", 7)

				for iter_58_0 = 0, var_58_3.childCount - 1 do
					local var_58_4 = var_58_3:GetChild(iter_58_0)

					if var_58_4.name == "split_2" or not string.find(var_58_4.name, "split") then
						var_58_4.gameObject:SetActive(true)
					else
						var_58_4.gameObject:SetActive(false)
					end
				end
			end

			local var_58_5 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_5 then
				var_58_3.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_55_1.time_ - 0) / var_58_5)
			end

			if arg_55_1.time_ >= 0 + var_58_5 and arg_55_1.time_ < 0 + var_58_5 + arg_58_0 then
				var_58_3.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:AudioAction("play", "effect", "se_story_10", "se_story_10_sword02", "")
			end

			local var_58_7 = 0.533333333333333
			local var_58_8 = 0.2

			if 0.533333333333333 < arg_55_1.time_ and arg_55_1.time_ <= var_58_7 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_2")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_9 = arg_55_1:GetWordFromCfg(413072013)
				local var_58_10 = arg_55_1:FormatText(var_58_9.content)

				arg_55_1.text_.text = var_58_10

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_12 = 8 <= 0 and var_58_8 or var_58_8 * (utf8.len(var_58_10) / 8)

				if (8 <= 0 and var_58_8 or var_58_8 * (utf8.len(var_58_10) / 8)) > 0 and var_58_8 < var_58_12 then
					arg_55_1.talkMaxDuration = var_58_12

					if var_58_12 + var_58_7 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_12 + var_58_7
					end
				end

				arg_55_1.text_.text = var_58_10
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072013", "story_v_out_413072.awb") ~= 0 then
					local var_58_13 = manager.audio:GetVoiceLength("story_v_out_413072", "413072013", "story_v_out_413072.awb") / 1000

					if var_58_13 + var_58_7 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_7
					end

					if var_58_9.prefab_name ~= "" and arg_55_1.actors_[var_58_9.prefab_name] ~= nil then
						local var_58_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_9.prefab_name].transform, "story_v_out_413072", "413072013", "story_v_out_413072.awb")

						arg_55_1:RecordAudio("413072013", var_58_14)
						arg_55_1:RecordAudio("413072013", var_58_14)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_413072", "413072013", "story_v_out_413072.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_413072", "413072013", "story_v_out_413072.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_15 = math.max(var_58_8, arg_55_1.talkMaxDuration)

			if var_58_7 <= arg_55_1.time_ and arg_55_1.time_ < var_58_7 + var_58_15 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_7) / var_58_15

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_7 + var_58_15 and arg_55_1.time_ < var_58_7 + var_58_15 + arg_58_0 then
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
	Play413072014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 413072014
		arg_59_1.duration_ = 5.6

		local var_59_0 = {
			zh = 3.966,
			ja = 5.6
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
				arg_59_0:Play413072015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["10022"]) and arg_59_1.var_.actorSpriteComps10022 == nil then
				arg_59_1.var_.actorSpriteComps10022 = arg_59_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_0 = 2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["10022"]) then
				if arg_59_1.var_.actorSpriteComps10022 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_62_1 then
							if arg_59_1.isInRecall_ then
								iter_62_1.color = Color.New(Mathf.Lerp(iter_62_1.color.r, arg_59_1.hightColor2.r, (arg_59_1.time_ - 0) / var_62_0), Mathf.Lerp(iter_62_1.color.g, arg_59_1.hightColor2.g, (arg_59_1.time_ - 0) / var_62_0), (Mathf.Lerp(iter_62_1.color.b, arg_59_1.hightColor2.b, (arg_59_1.time_ - 0) / var_62_0)))
							else
								local var_62_1 = Mathf.Lerp(iter_62_1.color.r, 0.5, (arg_59_1.time_ - 0) / var_62_0)

								iter_62_1.color = Color.New(var_62_1, var_62_1, var_62_1)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["10022"]) and arg_59_1.var_.actorSpriteComps10022 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_62_3 then
						iter_62_3.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_59_1.var_.actorSpriteComps10022 = nil
			end

			local var_62_2 = 0
			local var_62_3 = 0.275

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_4 = arg_59_1:GetWordFromCfg(413072014)
				local var_62_5 = arg_59_1:FormatText(var_62_4.content)

				arg_59_1.text_.text = var_62_5

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_7 = 11 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 11)

				if (11 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 11)) > 0 and var_62_3 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_2
					end
				end

				arg_59_1.text_.text = var_62_5
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072014", "story_v_out_413072.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072014", "story_v_out_413072.awb") / 1000

					if var_62_8 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_2
					end

					if var_62_4.prefab_name ~= "" and arg_59_1.actors_[var_62_4.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_4.prefab_name].transform, "story_v_out_413072", "413072014", "story_v_out_413072.awb")

						arg_59_1:RecordAudio("413072014", var_62_9)
						arg_59_1:RecordAudio("413072014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_413072", "413072014", "story_v_out_413072.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_413072", "413072014", "story_v_out_413072.awb")
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

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play413072015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 413072015
		arg_63_1.duration_ = 5.6

		local var_63_0 = {
			zh = 3,
			ja = 5.6
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
				arg_63_0:Play413072016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos10022 = arg_63_1.actors_["10022"].transform.localPosition
				arg_63_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10022", 3)

				for iter_66_0 = 0, arg_63_1.actors_["10022"].transform.childCount - 1 do
					local var_66_0 = arg_63_1.actors_["10022"].transform:GetChild(iter_66_0)

					if var_66_0.name == "split_8" or not string.find(var_66_0.name, "split") then
						var_66_0.gameObject:SetActive(true)
					else
						var_66_0.gameObject:SetActive(false)
					end
				end
			end

			local var_66_1 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_1 then
				arg_63_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_63_1.time_ - 0) / var_66_1)
			end

			if arg_63_1.time_ >= 0 + var_66_1 and arg_63_1.time_ < 0 + var_66_1 + arg_66_0 then
				arg_63_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_66_2 = arg_63_1.actors_["10022"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.actorSpriteComps10022 == nil then
				arg_63_1.var_.actorSpriteComps10022 = var_66_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_3 = 2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_3 and not isNil(var_66_2) then
				if arg_63_1.var_.actorSpriteComps10022 then
					for iter_66_1, iter_66_2 in pairs(arg_63_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_66_2 then
							if arg_63_1.isInRecall_ then
								iter_66_2.color = Color.New(Mathf.Lerp(iter_66_2.color.r, arg_63_1.hightColor1.r, (arg_63_1.time_ - 0) / var_66_3), Mathf.Lerp(iter_66_2.color.g, arg_63_1.hightColor1.g, (arg_63_1.time_ - 0) / var_66_3), (Mathf.Lerp(iter_66_2.color.b, arg_63_1.hightColor1.b, (arg_63_1.time_ - 0) / var_66_3)))
							else
								local var_66_4 = Mathf.Lerp(iter_66_2.color.r, 1, (arg_63_1.time_ - 0) / var_66_3)

								iter_66_2.color = Color.New(var_66_4, var_66_4, var_66_4)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_3 and arg_63_1.time_ < 0 + var_66_3 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.actorSpriteComps10022 then
				for iter_66_3, iter_66_4 in pairs(arg_63_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_66_4 then
						iter_66_4.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_63_1.var_.actorSpriteComps10022 = nil
			end

			local var_66_5 = 0
			local var_66_6 = 0.45

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
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

				local var_66_7 = arg_63_1:GetWordFromCfg(413072015)
				local var_66_8 = arg_63_1:FormatText(var_66_7.content)

				arg_63_1.text_.text = var_66_8

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_10 = 18 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 18)

				if (18 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 18)) > 0 and var_66_6 < var_66_10 then
					arg_63_1.talkMaxDuration = var_66_10

					if var_66_10 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_5
					end
				end

				arg_63_1.text_.text = var_66_8
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072015", "story_v_out_413072.awb") ~= 0 then
					local var_66_11 = manager.audio:GetVoiceLength("story_v_out_413072", "413072015", "story_v_out_413072.awb") / 1000

					if var_66_11 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_11 + var_66_5
					end

					if var_66_7.prefab_name ~= "" and arg_63_1.actors_[var_66_7.prefab_name] ~= nil then
						local var_66_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_7.prefab_name].transform, "story_v_out_413072", "413072015", "story_v_out_413072.awb")

						arg_63_1:RecordAudio("413072015", var_66_12)
						arg_63_1:RecordAudio("413072015", var_66_12)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_413072", "413072015", "story_v_out_413072.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_413072", "413072015", "story_v_out_413072.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_13 = math.max(var_66_6, arg_63_1.talkMaxDuration)

			if var_66_5 <= arg_63_1.time_ and arg_63_1.time_ < var_66_5 + var_66_13 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_5) / var_66_13

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_5 + var_66_13 and arg_63_1.time_ < var_66_5 + var_66_13 + arg_66_0 then
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
	Play413072016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 413072016
		arg_67_1.duration_ = 12.67

		local var_67_0 = {
			zh = 8.466,
			ja = 12.666
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
				arg_67_0:Play413072017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 1.125

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

				local var_70_1 = arg_67_1:GetWordFromCfg(413072016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 45 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 45)

				if (45 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 45)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072016", "story_v_out_413072.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_413072", "413072016", "story_v_out_413072.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_413072", "413072016", "story_v_out_413072.awb")

						arg_67_1:RecordAudio("413072016", var_70_6)
						arg_67_1:RecordAudio("413072016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_413072", "413072016", "story_v_out_413072.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_413072", "413072016", "story_v_out_413072.awb")
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
	Play413072017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 413072017
		arg_71_1.duration_ = 8.77

		local var_71_0 = {
			zh = 3.966,
			ja = 8.766
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
				arg_71_0:Play413072018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["10022"]) and arg_71_1.var_.actorSpriteComps10022 == nil then
				arg_71_1.var_.actorSpriteComps10022 = arg_71_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_74_0 = 2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["10022"]) then
				if arg_71_1.var_.actorSpriteComps10022 then
					for iter_74_0, iter_74_1 in pairs(arg_71_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_74_1 then
							if arg_71_1.isInRecall_ then
								iter_74_1.color = Color.New(Mathf.Lerp(iter_74_1.color.r, arg_71_1.hightColor2.r, (arg_71_1.time_ - 0) / var_74_0), Mathf.Lerp(iter_74_1.color.g, arg_71_1.hightColor2.g, (arg_71_1.time_ - 0) / var_74_0), (Mathf.Lerp(iter_74_1.color.b, arg_71_1.hightColor2.b, (arg_71_1.time_ - 0) / var_74_0)))
							else
								local var_74_1 = Mathf.Lerp(iter_74_1.color.r, 0.5, (arg_71_1.time_ - 0) / var_74_0)

								iter_74_1.color = Color.New(var_74_1, var_74_1, var_74_1)
							end
						end
					end
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["10022"]) and arg_71_1.var_.actorSpriteComps10022 then
				for iter_74_2, iter_74_3 in pairs(arg_71_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_74_3 then
						iter_74_3.color = arg_71_1.isInRecall_ and (arg_71_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_71_1.var_.actorSpriteComps10022 = nil
			end

			local var_74_2 = 0
			local var_74_3 = 0.45

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_2 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_4 = arg_71_1:GetWordFromCfg(413072017)
				local var_74_5 = arg_71_1:FormatText(var_74_4.content)

				arg_71_1.text_.text = var_74_5

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_7 = 18 <= 0 and var_74_3 or var_74_3 * (utf8.len(var_74_5) / 18)

				if (18 <= 0 and var_74_3 or var_74_3 * (utf8.len(var_74_5) / 18)) > 0 and var_74_3 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_2 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_2
					end
				end

				arg_71_1.text_.text = var_74_5
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072017", "story_v_out_413072.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072017", "story_v_out_413072.awb") / 1000

					if var_74_8 + var_74_2 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_2
					end

					if var_74_4.prefab_name ~= "" and arg_71_1.actors_[var_74_4.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_4.prefab_name].transform, "story_v_out_413072", "413072017", "story_v_out_413072.awb")

						arg_71_1:RecordAudio("413072017", var_74_9)
						arg_71_1:RecordAudio("413072017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_413072", "413072017", "story_v_out_413072.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_413072", "413072017", "story_v_out_413072.awb")
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

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play413072018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 413072018
		arg_75_1.duration_ = 4.9

		local var_75_0 = {
			zh = 2.366,
			ja = 4.9
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
				arg_75_0:Play413072019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10022 = arg_75_1.actors_["10022"].transform.localPosition
				arg_75_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("10022", 3)

				for iter_78_0 = 0, arg_75_1.actors_["10022"].transform.childCount - 1 do
					local var_78_0 = arg_75_1.actors_["10022"].transform:GetChild(iter_78_0)

					if var_78_0.name == "split_6" or not string.find(var_78_0.name, "split") then
						var_78_0.gameObject:SetActive(true)
					else
						var_78_0.gameObject:SetActive(false)
					end
				end
			end

			local var_78_1 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_1 then
				arg_75_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_75_1.time_ - 0) / var_78_1)
			end

			if arg_75_1.time_ >= 0 + var_78_1 and arg_75_1.time_ < 0 + var_78_1 + arg_78_0 then
				arg_75_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_78_2 = arg_75_1.actors_["10022"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps10022 == nil then
				arg_75_1.var_.actorSpriteComps10022 = var_78_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_3 = 2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_3 and not isNil(var_78_2) then
				if arg_75_1.var_.actorSpriteComps10022 then
					for iter_78_1, iter_78_2 in pairs(arg_75_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_78_2 then
							if arg_75_1.isInRecall_ then
								iter_78_2.color = Color.New(Mathf.Lerp(iter_78_2.color.r, arg_75_1.hightColor1.r, (arg_75_1.time_ - 0) / var_78_3), Mathf.Lerp(iter_78_2.color.g, arg_75_1.hightColor1.g, (arg_75_1.time_ - 0) / var_78_3), (Mathf.Lerp(iter_78_2.color.b, arg_75_1.hightColor1.b, (arg_75_1.time_ - 0) / var_78_3)))
							else
								local var_78_4 = Mathf.Lerp(iter_78_2.color.r, 1, (arg_75_1.time_ - 0) / var_78_3)

								iter_78_2.color = Color.New(var_78_4, var_78_4, var_78_4)
							end
						end
					end
				end
			end

			if arg_75_1.time_ >= 0 + var_78_3 and arg_75_1.time_ < 0 + var_78_3 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps10022 then
				for iter_78_3, iter_78_4 in pairs(arg_75_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_78_4 then
						iter_78_4.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_75_1.var_.actorSpriteComps10022 = nil
			end

			local var_78_5 = 0
			local var_78_6 = 0.325

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_7 = arg_75_1:GetWordFromCfg(413072018)
				local var_78_8 = arg_75_1:FormatText(var_78_7.content)

				arg_75_1.text_.text = var_78_8

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_10 = 13 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_8) / 13)

				if (13 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_8) / 13)) > 0 and var_78_6 < var_78_10 then
					arg_75_1.talkMaxDuration = var_78_10

					if var_78_10 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_5
					end
				end

				arg_75_1.text_.text = var_78_8
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072018", "story_v_out_413072.awb") ~= 0 then
					local var_78_11 = manager.audio:GetVoiceLength("story_v_out_413072", "413072018", "story_v_out_413072.awb") / 1000

					if var_78_11 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_11 + var_78_5
					end

					if var_78_7.prefab_name ~= "" and arg_75_1.actors_[var_78_7.prefab_name] ~= nil then
						local var_78_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_7.prefab_name].transform, "story_v_out_413072", "413072018", "story_v_out_413072.awb")

						arg_75_1:RecordAudio("413072018", var_78_12)
						arg_75_1:RecordAudio("413072018", var_78_12)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_413072", "413072018", "story_v_out_413072.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_413072", "413072018", "story_v_out_413072.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_13 = math.max(var_78_6, arg_75_1.talkMaxDuration)

			if var_78_5 <= arg_75_1.time_ and arg_75_1.time_ < var_78_5 + var_78_13 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_5) / var_78_13

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_5 + var_78_13 and arg_75_1.time_ < var_78_5 + var_78_13 + arg_78_0 then
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
	Play413072019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 413072019
		arg_79_1.duration_ = 6.8

		local var_79_0 = {
			zh = 3.866,
			ja = 6.8
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
				arg_79_0:Play413072020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["10022"]) and arg_79_1.var_.actorSpriteComps10022 == nil then
				arg_79_1.var_.actorSpriteComps10022 = arg_79_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_0 = 2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["10022"]) then
				if arg_79_1.var_.actorSpriteComps10022 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_82_1 then
							if arg_79_1.isInRecall_ then
								iter_82_1.color = Color.New(Mathf.Lerp(iter_82_1.color.r, arg_79_1.hightColor2.r, (arg_79_1.time_ - 0) / var_82_0), Mathf.Lerp(iter_82_1.color.g, arg_79_1.hightColor2.g, (arg_79_1.time_ - 0) / var_82_0), (Mathf.Lerp(iter_82_1.color.b, arg_79_1.hightColor2.b, (arg_79_1.time_ - 0) / var_82_0)))
							else
								local var_82_1 = Mathf.Lerp(iter_82_1.color.r, 0.5, (arg_79_1.time_ - 0) / var_82_0)

								iter_82_1.color = Color.New(var_82_1, var_82_1, var_82_1)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["10022"]) and arg_79_1.var_.actorSpriteComps10022 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_82_3 then
						iter_82_3.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_79_1.var_.actorSpriteComps10022 = nil
			end

			local var_82_2 = 0
			local var_82_3 = 0.15

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[995].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10096")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_4 = arg_79_1:GetWordFromCfg(413072019)
				local var_82_5 = arg_79_1:FormatText(var_82_4.content)

				arg_79_1.text_.text = var_82_5

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_7 = 6 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 6)

				if (6 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_5) / 6)) > 0 and var_82_3 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_2
					end
				end

				arg_79_1.text_.text = var_82_5
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072019", "story_v_out_413072.awb") ~= 0 then
					local var_82_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072019", "story_v_out_413072.awb") / 1000

					if var_82_8 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_2
					end

					if var_82_4.prefab_name ~= "" and arg_79_1.actors_[var_82_4.prefab_name] ~= nil then
						local var_82_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_4.prefab_name].transform, "story_v_out_413072", "413072019", "story_v_out_413072.awb")

						arg_79_1:RecordAudio("413072019", var_82_9)
						arg_79_1:RecordAudio("413072019", var_82_9)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_413072", "413072019", "story_v_out_413072.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_413072", "413072019", "story_v_out_413072.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_10 = math.max(var_82_3, arg_79_1.talkMaxDuration)

			if var_82_2 <= arg_79_1.time_ and arg_79_1.time_ < var_82_2 + var_82_10 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_2) / var_82_10

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_2 + var_82_10 and arg_79_1.time_ < var_82_2 + var_82_10 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play413072020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 413072020
		arg_83_1.duration_ = 6.77

		local var_83_0 = {
			zh = 6.633,
			ja = 6.766
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
				arg_83_0:Play413072021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos10022 = arg_83_1.actors_["10022"].transform.localPosition
				arg_83_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("10022", 3)

				for iter_86_0 = 0, arg_83_1.actors_["10022"].transform.childCount - 1 do
					local var_86_0 = arg_83_1.actors_["10022"].transform:GetChild(iter_86_0)

					if var_86_0.name == "split_2" or not string.find(var_86_0.name, "split") then
						var_86_0.gameObject:SetActive(true)
					else
						var_86_0.gameObject:SetActive(false)
					end
				end
			end

			local var_86_1 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_1 then
				arg_83_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_83_1.time_ - 0) / var_86_1)
			end

			if arg_83_1.time_ >= 0 + var_86_1 and arg_83_1.time_ < 0 + var_86_1 + arg_86_0 then
				arg_83_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_86_2 = arg_83_1.actors_["10022"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps10022 == nil then
				arg_83_1.var_.actorSpriteComps10022 = var_86_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_3 = 2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_3 and not isNil(var_86_2) then
				if arg_83_1.var_.actorSpriteComps10022 then
					for iter_86_1, iter_86_2 in pairs(arg_83_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_83_1.time_ >= 0 + var_86_3 and arg_83_1.time_ < 0 + var_86_3 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps10022 then
				for iter_86_3, iter_86_4 in pairs(arg_83_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_86_4 then
						iter_86_4.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_83_1.var_.actorSpriteComps10022 = nil
			end

			local var_86_5 = 0
			local var_86_6 = 0.65

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_7 = arg_83_1:GetWordFromCfg(413072020)
				local var_86_8 = arg_83_1:FormatText(var_86_7.content)

				arg_83_1.text_.text = var_86_8

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_10 = 26 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 26)

				if (26 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 26)) > 0 and var_86_6 < var_86_10 then
					arg_83_1.talkMaxDuration = var_86_10

					if var_86_10 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_5
					end
				end

				arg_83_1.text_.text = var_86_8
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072020", "story_v_out_413072.awb") ~= 0 then
					local var_86_11 = manager.audio:GetVoiceLength("story_v_out_413072", "413072020", "story_v_out_413072.awb") / 1000

					if var_86_11 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_5
					end

					if var_86_7.prefab_name ~= "" and arg_83_1.actors_[var_86_7.prefab_name] ~= nil then
						local var_86_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_7.prefab_name].transform, "story_v_out_413072", "413072020", "story_v_out_413072.awb")

						arg_83_1:RecordAudio("413072020", var_86_12)
						arg_83_1:RecordAudio("413072020", var_86_12)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_413072", "413072020", "story_v_out_413072.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_413072", "413072020", "story_v_out_413072.awb")
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
				actorName = "10022",
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
	Play413072021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 413072021
		arg_87_1.duration_ = 4.8

		local var_87_0 = {
			zh = 2.86666666666667,
			ja = 4.79966666666667
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
				arg_87_0:Play413072022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos10022 = arg_87_1.actors_["10022"].transform.localPosition
				arg_87_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("10022", 7)

				for iter_90_0 = 0, arg_87_1.actors_["10022"].transform.childCount - 1 do
					local var_90_0 = arg_87_1.actors_["10022"].transform:GetChild(iter_90_0)

					if var_90_0.name == "split_2" or not string.find(var_90_0.name, "split") then
						var_90_0.gameObject:SetActive(true)
					else
						var_90_0.gameObject:SetActive(false)
					end
				end
			end

			local var_90_1 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_1 then
				arg_87_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10022, Vector3.New(0, -2000, 0), (arg_87_1.time_ - 0) / var_90_1)
			end

			if arg_87_1.time_ >= 0 + var_90_1 and arg_87_1.time_ < 0 + var_90_1 + arg_90_0 then
				arg_87_1.actors_["10022"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_90_2 = manager.ui.mainCamera.transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.shakeOldPos = var_90_2.localPosition
			end

			local var_90_3 = 0.6

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 then
				local var_90_4, var_90_5 = math.modf((arg_87_1.time_ - 0) / 0.066)

				var_90_2.localPosition = Vector3.New(var_90_5 * 0.13, var_90_5 * 0.13, var_90_5 * 0.13) + arg_87_1.var_.shakeOldPos
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 then
				var_90_2.localPosition = arg_87_1.var_.shakeOldPos
			end

			local var_90_6 = 0

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 then
				arg_87_1.allBtn_.enabled = false
			end

			if arg_87_1.time_ >= var_90_6 + 1.06666666666667 and arg_87_1.time_ < var_90_6 + 1.06666666666667 + arg_90_0 then
				arg_87_1.allBtn_.enabled = true
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_7 = 0.566666666666667
			local var_90_8 = 0.25

			if 0.566666666666667 < arg_87_1.time_ and arg_87_1.time_ <= var_90_7 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_9 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_9:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10022_split_6")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_10 = arg_87_1:GetWordFromCfg(413072021)
				local var_90_11 = arg_87_1:FormatText(var_90_10.content)

				arg_87_1.text_.text = var_90_11

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_13 = 10 <= 0 and var_90_8 or var_90_8 * (utf8.len(var_90_11) / 10)

				if (10 <= 0 and var_90_8 or var_90_8 * (utf8.len(var_90_11) / 10)) > 0 and var_90_8 < var_90_13 then
					arg_87_1.talkMaxDuration = var_90_13
					var_90_7 = var_90_7 + 0.3

					if var_90_13 + var_90_7 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_13 + var_90_7
					end
				end

				arg_87_1.text_.text = var_90_11
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072021", "story_v_out_413072.awb") ~= 0 then
					local var_90_14 = manager.audio:GetVoiceLength("story_v_out_413072", "413072021", "story_v_out_413072.awb") / 1000

					if var_90_14 + var_90_7 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_14 + var_90_7
					end

					if var_90_10.prefab_name ~= "" and arg_87_1.actors_[var_90_10.prefab_name] ~= nil then
						local var_90_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_10.prefab_name].transform, "story_v_out_413072", "413072021", "story_v_out_413072.awb")

						arg_87_1:RecordAudio("413072021", var_90_15)
						arg_87_1:RecordAudio("413072021", var_90_15)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_413072", "413072021", "story_v_out_413072.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_413072", "413072021", "story_v_out_413072.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_16 = var_90_7 + 0.3
			local var_90_17 = math.max(var_90_8, arg_87_1.talkMaxDuration)

			if var_90_7 + 0.3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_16 + var_90_17 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_16) / var_90_17

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_16 + var_90_17 and arg_87_1.time_ < var_90_16 + var_90_17 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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

		arg_87_1:InitPlayNodeList()
	end,
	Play413072022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413072022
		arg_93_1.duration_ = 4.9

		local var_93_0 = {
			zh = 4.633,
			ja = 4.9
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
				arg_93_0:Play413072023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.15

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2123")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:GetWordFromCfg(413072022)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 6 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 6)

				if (6 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 6)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072022", "story_v_out_413072.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_413072", "413072022", "story_v_out_413072.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_413072", "413072022", "story_v_out_413072.awb")

						arg_93_1:RecordAudio("413072022", var_96_6)
						arg_93_1:RecordAudio("413072022", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413072", "413072022", "story_v_out_413072.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413072", "413072022", "story_v_out_413072.awb")
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
	Play413072023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413072023
		arg_97_1.duration_ = 13.07

		local var_97_0 = {
			zh = 6,
			ja = 13.066
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
				arg_97_0:Play413072024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.allBtn_.enabled = false
			end

			if arg_97_1.time_ >= 0 + 0.766666666666667 and arg_97_1.time_ < 0 + 0.766666666666667 + arg_100_0 then
				arg_97_1.allBtn_.enabled = true
			end

			local var_100_0 = 0
			local var_100_1 = 0.575

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[993].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_2 = arg_97_1:GetWordFromCfg(413072023)
				local var_100_3 = arg_97_1:FormatText(var_100_2.content)

				arg_97_1.text_.text = var_100_3

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_5 = 23 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 23)

				if (23 <= 0 and var_100_1 or var_100_1 * (utf8.len(var_100_3) / 23)) > 0 and var_100_1 < var_100_5 then
					arg_97_1.talkMaxDuration = var_100_5

					if var_100_5 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + var_100_0
					end
				end

				arg_97_1.text_.text = var_100_3
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072023", "story_v_out_413072.awb") ~= 0 then
					local var_100_6 = manager.audio:GetVoiceLength("story_v_out_413072", "413072023", "story_v_out_413072.awb") / 1000

					if var_100_6 + var_100_0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_0
					end

					if var_100_2.prefab_name ~= "" and arg_97_1.actors_[var_100_2.prefab_name] ~= nil then
						local var_100_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_2.prefab_name].transform, "story_v_out_413072", "413072023", "story_v_out_413072.awb")

						arg_97_1:RecordAudio("413072023", var_100_7)
						arg_97_1:RecordAudio("413072023", var_100_7)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_413072", "413072023", "story_v_out_413072.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_413072", "413072023", "story_v_out_413072.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_8 = math.max(var_100_1, arg_97_1.talkMaxDuration)

			if var_100_0 <= arg_97_1.time_ and arg_97_1.time_ < var_100_0 + var_100_8 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_0) / var_100_8

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_0 + var_100_8 and arg_97_1.time_ < var_100_0 + var_100_8 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play413072024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413072024
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play413072025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10022 = arg_101_1.actors_["10022"].transform.localPosition
				arg_101_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("10022", 0)

				for iter_104_0 = 0, arg_101_1.actors_["10022"].transform.childCount - 1 do
					local var_104_0 = arg_101_1.actors_["10022"].transform:GetChild(iter_104_0)

					if var_104_0.name == "" or not string.find(var_104_0.name, "split") then
						var_104_0.gameObject:SetActive(true)
					else
						var_104_0.gameObject:SetActive(false)
					end
				end
			end

			local var_104_1 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_1 then
				arg_101_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_101_1.time_ - 0) / var_104_1)
			end

			if arg_101_1.time_ >= 0 + var_104_1 and arg_101_1.time_ < 0 + var_104_1 + arg_104_0 then
				arg_101_1.actors_["10022"].transform.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_104_2 = arg_101_1.actors_["10022"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps10022 == nil then
				arg_101_1.var_.actorSpriteComps10022 = var_104_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_3 = 2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.actorSpriteComps10022 then
					for iter_104_1, iter_104_2 in pairs(arg_101_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.actorSpriteComps10022 then
				for iter_104_3, iter_104_4 in pairs(arg_101_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_104_4 then
						iter_104_4.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps10022 = nil
			end

			if 0.034 < arg_101_1.time_ and arg_101_1.time_ <= 0.034 + arg_104_0 then
				arg_101_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_sizzle", "")
			end

			if 1 < arg_101_1.time_ and arg_101_1.time_ <= 1 + arg_104_0 then
				arg_101_1:AudioAction("play", "effect", "se_story_121_00", "se_story_121_00_suppress01_break", "")
			end

			local var_104_7 = 0
			local var_104_8 = 1.775

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_7 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_9 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(413072024).content)

				arg_101_1.text_.text = var_104_9

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 65 <= 0 and var_104_8 or var_104_8 * (utf8.len(var_104_9) / 65)

				if (65 <= 0 and var_104_8 or var_104_8 * (utf8.len(var_104_9) / 65)) > 0 and var_104_8 < var_104_11 then
					arg_101_1.talkMaxDuration = var_104_11

					if var_104_11 + var_104_7 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_7
					end
				end

				arg_101_1.text_.text = var_104_9
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_8, arg_101_1.talkMaxDuration)

			if var_104_7 <= arg_101_1.time_ and arg_101_1.time_ < var_104_7 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_7) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_7 + var_104_12 and arg_101_1.time_ < var_104_7 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play413072025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 413072025
		arg_105_1.duration_ = 4.6

		local var_105_0 = {
			zh = 4.6,
			ja = 3.933
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
				arg_105_0:Play413072026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10022 = arg_105_1.actors_["10022"].transform.localPosition
				arg_105_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("10022", 3)

				for iter_108_0 = 0, arg_105_1.actors_["10022"].transform.childCount - 1 do
					local var_108_0 = arg_105_1.actors_["10022"].transform:GetChild(iter_108_0)

					if var_108_0.name == "split_6" or not string.find(var_108_0.name, "split") then
						var_108_0.gameObject:SetActive(true)
					else
						var_108_0.gameObject:SetActive(false)
					end
				end
			end

			local var_108_1 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_1 then
				arg_105_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10022, Vector3.New(0, -315, -320), (arg_105_1.time_ - 0) / var_108_1)
			end

			if arg_105_1.time_ >= 0 + var_108_1 and arg_105_1.time_ < 0 + var_108_1 + arg_108_0 then
				arg_105_1.actors_["10022"].transform.localPosition = Vector3.New(0, -315, -320)
			end

			local var_108_2 = arg_105_1.actors_["10022"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps10022 == nil then
				arg_105_1.var_.actorSpriteComps10022 = var_108_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_3 = 2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_3 and not isNil(var_108_2) then
				if arg_105_1.var_.actorSpriteComps10022 then
					for iter_108_1, iter_108_2 in pairs(arg_105_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_105_1.time_ >= 0 + var_108_3 and arg_105_1.time_ < 0 + var_108_3 + arg_108_0 and not isNil(var_108_2) and arg_105_1.var_.actorSpriteComps10022 then
				for iter_108_3, iter_108_4 in pairs(arg_105_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_108_4 then
						iter_108_4.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_105_1.var_.actorSpriteComps10022 = nil
			end

			local var_108_5 = 0
			local var_108_6 = 0.575

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_7 = arg_105_1:GetWordFromCfg(413072025)
				local var_108_8 = arg_105_1:FormatText(var_108_7.content)

				arg_105_1.text_.text = var_108_8

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_10 = 23 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_8) / 23)

				if (23 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_8) / 23)) > 0 and var_108_6 < var_108_10 then
					arg_105_1.talkMaxDuration = var_108_10

					if var_108_10 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_5
					end
				end

				arg_105_1.text_.text = var_108_8
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072025", "story_v_out_413072.awb") ~= 0 then
					local var_108_11 = manager.audio:GetVoiceLength("story_v_out_413072", "413072025", "story_v_out_413072.awb") / 1000

					if var_108_11 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_5
					end

					if var_108_7.prefab_name ~= "" and arg_105_1.actors_[var_108_7.prefab_name] ~= nil then
						local var_108_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_7.prefab_name].transform, "story_v_out_413072", "413072025", "story_v_out_413072.awb")

						arg_105_1:RecordAudio("413072025", var_108_12)
						arg_105_1:RecordAudio("413072025", var_108_12)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_413072", "413072025", "story_v_out_413072.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_413072", "413072025", "story_v_out_413072.awb")
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
				actorName = "10022",
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
	Play413072026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 413072026
		arg_109_1.duration_ = 3.43

		local var_109_0 = {
			zh = 2.9,
			ja = 3.433
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
				arg_109_0:Play413072027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0.8 < arg_109_1.time_ and arg_109_1.time_ <= 0.8 + arg_112_0 then
				arg_109_1:AudioAction("play", "effect", "minigame_activity_3_4", "minigame_activity_3_4_battle_bullet_30", "")
			end

			local var_112_1 = 0
			local var_112_2 = 0.375

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_3 = arg_109_1:GetWordFromCfg(413072026)
				local var_112_4 = arg_109_1:FormatText(var_112_3.content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_6 = 15 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_4) / 15)

				if (15 <= 0 and var_112_2 or var_112_2 * (utf8.len(var_112_4) / 15)) > 0 and var_112_2 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_1
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072026", "story_v_out_413072.awb") ~= 0 then
					local var_112_7 = manager.audio:GetVoiceLength("story_v_out_413072", "413072026", "story_v_out_413072.awb") / 1000

					if var_112_7 + var_112_1 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_1
					end

					if var_112_3.prefab_name ~= "" and arg_109_1.actors_[var_112_3.prefab_name] ~= nil then
						local var_112_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_3.prefab_name].transform, "story_v_out_413072", "413072026", "story_v_out_413072.awb")

						arg_109_1:RecordAudio("413072026", var_112_8)
						arg_109_1:RecordAudio("413072026", var_112_8)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_413072", "413072026", "story_v_out_413072.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_413072", "413072026", "story_v_out_413072.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_9 = math.max(var_112_2, arg_109_1.talkMaxDuration)

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_9 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_1) / var_112_9

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_1 + var_112_9 and arg_109_1.time_ < var_112_1 + var_112_9 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play413072027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413072027
		arg_113_1.duration_ = 3.1

		local var_113_0 = {
			zh = 2.933,
			ja = 3.1
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
				arg_113_0:Play413072028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0.275

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[614].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_1 = arg_113_1:GetWordFromCfg(413072027)
				local var_116_2 = arg_113_1:FormatText(var_116_1.content)

				arg_113_1.text_.text = var_116_2

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 11 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 11)

				if (11 <= 0 and var_116_0 or var_116_0 * (utf8.len(var_116_2) / 11)) > 0 and var_116_0 < var_116_4 then
					arg_113_1.talkMaxDuration = var_116_4

					if var_116_4 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_4 + 0
					end
				end

				arg_113_1.text_.text = var_116_2
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072027", "story_v_out_413072.awb") ~= 0 then
					local var_116_5 = manager.audio:GetVoiceLength("story_v_out_413072", "413072027", "story_v_out_413072.awb") / 1000

					if var_116_5 + 0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_5 + 0
					end

					if var_116_1.prefab_name ~= "" and arg_113_1.actors_[var_116_1.prefab_name] ~= nil then
						local var_116_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_1.prefab_name].transform, "story_v_out_413072", "413072027", "story_v_out_413072.awb")

						arg_113_1:RecordAudio("413072027", var_116_6)
						arg_113_1:RecordAudio("413072027", var_116_6)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_413072", "413072027", "story_v_out_413072.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_413072", "413072027", "story_v_out_413072.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_0, arg_113_1.talkMaxDuration)

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - 0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play413072028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 413072028
		arg_117_1.duration_ = 6

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play413072029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_9000

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10022 = arg_117_1.actors_["10022"].transform.localPosition
				arg_117_1.actors_["10022"].transform.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10022", 0)

				for iter_120_0 = 0, arg_117_1.actors_["10022"].transform.childCount - 1 do
					local var_120_0 = arg_117_1.actors_["10022"].transform:GetChild(iter_120_0)

					if var_120_0.name == "" or not string.find(var_120_0.name, "split") then
						var_120_0.gameObject:SetActive(true)
					else
						var_120_0.gameObject:SetActive(false)
					end
				end
			end

			local var_120_1 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 then
				arg_117_1.actors_["10022"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10022, Vector3.New(-5000, -315, -320), (arg_117_1.time_ - 0) / var_120_1)
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 then
				arg_117_1.actors_["10022"].transform.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_120_2 = arg_117_1.actors_["10022"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps10022 == nil then
				arg_117_1.var_.actorSpriteComps10022 = var_120_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_3 = 2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_3 and not isNil(var_120_2) then
				if arg_117_1.var_.actorSpriteComps10022 then
					for iter_120_1, iter_120_2 in pairs(arg_117_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_117_1.time_ >= 0 + var_120_3 and arg_117_1.time_ < 0 + var_120_3 + arg_120_0 and not isNil(var_120_2) and arg_117_1.var_.actorSpriteComps10022 then
				for iter_120_3, iter_120_4 in pairs(arg_117_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_120_4 then
						iter_120_4.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps10022 = nil
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				local var_120_5 = arg_117_1.var_.effectliren1

				if not arg_117_1.var_.effectliren1 then
					var_120_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_02"), manager.ui.mainCamera.transform)
					var_120_5.name = "liren1"
					arg_117_1.var_.effectliren1 = var_120_5
				else
					var_120_5.transform:SetParent(var_120_9000)
				end

				var_120_5.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_120_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_117_1.time_ and arg_117_1.time_ <= 1 + arg_120_0 then
				if arg_117_1.var_.effectliren1 then
					Object.Destroy(arg_117_1.var_.effectliren1)

					arg_117_1.var_.effectliren1 = nil
				end
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:AudioAction("play", "effect", "c_10079", "c_10079_bullet_7", "")
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_9 = 1
			local var_120_10 = 1.675

			if 1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_9 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_11 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_11:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_12 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(413072028).content)

				arg_117_1.text_.text = var_120_12

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_14 = 67 <= 0 and var_120_10 or var_120_10 * (utf8.len(var_120_12) / 67)

				if (67 <= 0 and var_120_10 or var_120_10 * (utf8.len(var_120_12) / 67)) > 0 and var_120_10 < var_120_14 then
					arg_117_1.talkMaxDuration = var_120_14
					var_120_9 = var_120_9 + 0.3

					if var_120_14 + var_120_9 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_14 + var_120_9
					end
				end

				arg_117_1.text_.text = var_120_12
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_15 = var_120_9 + 0.3
			local var_120_16 = math.max(var_120_10, arg_117_1.talkMaxDuration)

			if var_120_9 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_16 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_15) / var_120_16

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_15 + var_120_16 and arg_117_1.time_ < var_120_15 + var_120_16 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play413072029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 413072029
		arg_123_1.duration_ = 8.5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play413072030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_9000

			if arg_123_1.bgs_.F10g == nil then
				local var_126_0 = Object.Instantiate(arg_123_1.paintGo_)

				var_126_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F10g")
				var_126_0.name = "F10g"
				var_126_0.transform.parent = arg_123_1.stage_.transform
				var_126_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.bgs_.F10g = var_126_0
			end

			if 1.5 < arg_123_1.time_ and arg_123_1.time_ <= 1.5 + arg_126_0 then
				local var_126_1 = arg_123_1.bgs_.F10g

				arg_123_1.bgs_.F10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_126_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_126_2 = var_126_1:GetComponent("SpriteRenderer")

				if var_126_2 and var_126_2.sprite then
					local var_126_3 = 2 * (var_126_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_126_1.transform.localScale = Vector3.New(var_126_3 / var_126_2.sprite.bounds.size.y < var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x and var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x or var_126_3 / var_126_2.sprite.bounds.size.y, var_126_3 / var_126_2.sprite.bounds.size.y < var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x and var_126_3 * manager.ui.mainCameraCom_.aspect / var_126_2.sprite.bounds.size.x or var_126_3 / var_126_2.sprite.bounds.size.y, 0)
				end

				for iter_126_0, iter_126_1 in pairs(arg_123_1.bgs_) do
					if iter_126_0 ~= "F10g" then
						iter_126_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_126_4 = 3.5

			if 3.5 < arg_123_1.time_ and arg_123_1.time_ <= var_126_4 + arg_126_0 then
				arg_123_1.allBtn_.enabled = false
			end

			if arg_123_1.time_ >= var_126_4 + 0.3 and arg_123_1.time_ < var_126_4 + 0.3 + arg_126_0 then
				arg_123_1.allBtn_.enabled = true
			end

			local var_126_5 = 0

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_6 = 1.500000000002

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_6 then
				local var_126_7 = Color.New(0, 0, 0)

				var_126_7.a = Mathf.Lerp(0, 1, (arg_123_1.time_ - var_126_5) / var_126_6)
				arg_123_1.mask_.color = var_126_7
			end

			if arg_123_1.time_ >= var_126_5 + var_126_6 and arg_123_1.time_ < var_126_5 + var_126_6 + arg_126_0 then
				local var_126_8 = Color.New(0, 0, 0)

				var_126_8.a = 1
				arg_123_1.mask_.color = var_126_8
			end

			local var_126_9 = 1.500000000001

			if 1.500000000001 < arg_123_1.time_ and arg_123_1.time_ <= var_126_9 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_10 = 2

			if var_126_9 <= arg_123_1.time_ and arg_123_1.time_ < var_126_9 + var_126_10 then
				local var_126_11 = Color.New(0.4185208, 0.4279335, 0.5377358)

				var_126_11.a = Mathf.Lerp(1, 0, (arg_123_1.time_ - var_126_9) / var_126_10)
				arg_123_1.mask_.color = var_126_11
			end

			if arg_123_1.time_ >= var_126_9 + var_126_10 and arg_123_1.time_ < var_126_9 + var_126_10 + arg_126_0 then
				local var_126_12 = Color.New(0.4185208, 0.4279335, 0.5377358)

				arg_123_1.mask_.enabled = false
				var_126_12.a = 0
				arg_123_1.mask_.color = var_126_12
			end

			local var_126_13 = manager.ui.mainCamera.transform

			if 1.500000000002 < arg_123_1.time_ and arg_123_1.time_ <= 1.500000000002 + arg_126_0 then
				arg_123_1.var_.shakeOldPos = var_126_13.localPosition
			end

			local var_126_14 = 0.999999999999

			if 1.500000000002 <= arg_123_1.time_ and arg_123_1.time_ < 1.500000000002 + var_126_14 then
				local var_126_15, var_126_16 = math.modf((arg_123_1.time_ - 1.500000000002) / 0.066)

				var_126_13.localPosition = Vector3.New(var_126_16 * 0.13, var_126_16 * 0.13, var_126_16 * 0.13) + arg_123_1.var_.shakeOldPos
			end

			if arg_123_1.time_ >= 1.500000000002 + var_126_14 and arg_123_1.time_ < 1.500000000002 + var_126_14 + arg_126_0 then
				var_126_13.localPosition = arg_123_1.var_.shakeOldPos
			end

			if 1.500000000001 < arg_123_1.time_ and arg_123_1.time_ <= 1.500000000001 + arg_126_0 then
				local var_126_17 = arg_123_1.var_.effectchuanyu1

				if not arg_123_1.var_.effectchuanyu1 then
					var_126_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_raindrop"), manager.ui.mainCamera.transform)
					var_126_17.name = "chuanyu1"
					arg_123_1.var_.effectchuanyu1 = var_126_17
				else
					var_126_17.transform:SetParent(var_126_9000)
				end

				var_126_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_126_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.866666666666667 < arg_123_1.time_ and arg_123_1.time_ <= 0.866666666666667 + arg_126_0 then
				arg_123_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_wave", "")
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_20 = 3.5
			local var_126_21 = 0.9

			if 3.5 < arg_123_1.time_ and arg_123_1.time_ <= var_126_20 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_22 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_22:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_23 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(413072029).content)

				arg_123_1.text_.text = var_126_23

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_25 = 36 <= 0 and var_126_21 or var_126_21 * (utf8.len(var_126_23) / 36)

				if (36 <= 0 and var_126_21 or var_126_21 * (utf8.len(var_126_23) / 36)) > 0 and var_126_21 < var_126_25 then
					arg_123_1.talkMaxDuration = var_126_25
					var_126_20 = var_126_20 + 0.3

					if var_126_25 + var_126_20 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_25 + var_126_20
					end
				end

				arg_123_1.text_.text = var_126_23
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_26 = var_126_20 + 0.3
			local var_126_27 = math.max(var_126_21, arg_123_1.talkMaxDuration)

			if var_126_20 + 0.3 <= arg_123_1.time_ and arg_123_1.time_ < var_126_26 + var_126_27 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_26) / var_126_27

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_26 + var_126_27 and arg_123_1.time_ < var_126_26 + var_126_27 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play413072030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 413072030
		arg_129_1.duration_ = 3.97

		local var_129_0 = {
			zh = 3.96633333333333,
			ja = 3.89933333333333
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
				arg_129_0:Play413072031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if arg_129_1.actors_["10093"] == nil then
				local var_132_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

				if not isNil(var_132_0) then
					local var_132_1 = Object.Instantiate(var_132_0, arg_129_1.canvasGo_.transform)

					var_132_1.transform:SetSiblingIndex(1)

					var_132_1.name = "10093"
					var_132_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_129_1.actors_["10093"] = var_132_1

					if arg_129_1.isInRecall_ then
						for iter_132_0, iter_132_1 in ipairs((var_132_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_132_1.color = arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_132_2 = arg_129_1.actors_["10093"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10093 = var_132_2.localPosition
				var_132_2.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10093", 3)

				for iter_132_2 = 0, var_132_2.childCount - 1 do
					local var_132_3 = var_132_2:GetChild(iter_132_2)

					if var_132_3.name == "split_3" or not string.find(var_132_3.name, "split") then
						var_132_3.gameObject:SetActive(true)
					else
						var_132_3.gameObject:SetActive(false)
					end
				end
			end

			local var_132_4 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				var_132_2.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_129_1.time_ - 0) / var_132_4)
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				var_132_2.localPosition = Vector3.New(0, -345, -245)
			end

			local var_132_5 = arg_129_1.actors_["10093"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.actorSpriteComps10093 == nil then
				arg_129_1.var_.actorSpriteComps10093 = var_132_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_6 = 2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_6 and not isNil(var_132_5) then
				if arg_129_1.var_.actorSpriteComps10093 then
					for iter_132_3, iter_132_4 in pairs(arg_129_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_132_4 then
							if arg_129_1.isInRecall_ then
								iter_132_4.color = Color.New(Mathf.Lerp(iter_132_4.color.r, arg_129_1.hightColor1.r, (arg_129_1.time_ - 0) / var_132_6), Mathf.Lerp(iter_132_4.color.g, arg_129_1.hightColor1.g, (arg_129_1.time_ - 0) / var_132_6), (Mathf.Lerp(iter_132_4.color.b, arg_129_1.hightColor1.b, (arg_129_1.time_ - 0) / var_132_6)))
							else
								local var_132_7 = Mathf.Lerp(iter_132_4.color.r, 1, (arg_129_1.time_ - 0) / var_132_6)

								iter_132_4.color = Color.New(var_132_7, var_132_7, var_132_7)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_6 and arg_129_1.time_ < 0 + var_132_6 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.actorSpriteComps10093 then
				for iter_132_5, iter_132_6 in pairs(arg_129_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_132_6 then
						iter_132_6.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps10093 = nil
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				local var_132_8 = arg_129_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_132_8 then
					arg_129_1.var_.alphaOldValue10093 = var_132_8.alpha
					arg_129_1.var_.characterEffect10093 = var_132_8
				end

				arg_129_1.var_.alphaOldValue10093 = 0
			end

			local var_132_9 = 0.5

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_9 then
				if arg_129_1.var_.characterEffect10093 then
					arg_129_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_129_1.var_.alphaOldValue10093, 1, (arg_129_1.time_ - 0) / var_132_9)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_9 and arg_129_1.time_ < 0 + var_132_9 + arg_132_0 and arg_129_1.var_.characterEffect10093 then
				arg_129_1.var_.characterEffect10093.alpha = 1
			end

			local var_132_10 = 0.333333333333333
			local var_132_11 = 0.3

			if 0.333333333333333 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_12 = arg_129_1:GetWordFromCfg(413072030)
				local var_132_13 = arg_129_1:FormatText(var_132_12.content)

				arg_129_1.text_.text = var_132_13

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_15 = 12 <= 0 and var_132_11 or var_132_11 * (utf8.len(var_132_13) / 12)

				if (12 <= 0 and var_132_11 or var_132_11 * (utf8.len(var_132_13) / 12)) > 0 and var_132_11 < var_132_15 then
					arg_129_1.talkMaxDuration = var_132_15

					if var_132_15 + var_132_10 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_15 + var_132_10
					end
				end

				arg_129_1.text_.text = var_132_13
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072030", "story_v_out_413072.awb") ~= 0 then
					local var_132_16 = manager.audio:GetVoiceLength("story_v_out_413072", "413072030", "story_v_out_413072.awb") / 1000

					if var_132_16 + var_132_10 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_16 + var_132_10
					end

					if var_132_12.prefab_name ~= "" and arg_129_1.actors_[var_132_12.prefab_name] ~= nil then
						local var_132_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_12.prefab_name].transform, "story_v_out_413072", "413072030", "story_v_out_413072.awb")

						arg_129_1:RecordAudio("413072030", var_132_17)
						arg_129_1:RecordAudio("413072030", var_132_17)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_413072", "413072030", "story_v_out_413072.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_413072", "413072030", "story_v_out_413072.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_18 = math.max(var_132_11, arg_129_1.talkMaxDuration)

			if var_132_10 <= arg_129_1.time_ and arg_129_1.time_ < var_132_10 + var_132_18 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_10) / var_132_18

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_10 + var_132_18 and arg_129_1.time_ < var_132_10 + var_132_18 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	Play413072031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 413072031
		arg_133_1.duration_ = 5.3

		local var_133_0 = {
			zh = 5.3,
			ja = 2.9
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
				arg_133_0:Play413072032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0.475

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_1 = arg_133_1:GetWordFromCfg(413072031)
				local var_136_2 = arg_133_1:FormatText(var_136_1.content)

				arg_133_1.text_.text = var_136_2

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 19 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 19)

				if (19 <= 0 and var_136_0 or var_136_0 * (utf8.len(var_136_2) / 19)) > 0 and var_136_0 < var_136_4 then
					arg_133_1.talkMaxDuration = var_136_4

					if var_136_4 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_4 + 0
					end
				end

				arg_133_1.text_.text = var_136_2
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072031", "story_v_out_413072.awb") ~= 0 then
					local var_136_5 = manager.audio:GetVoiceLength("story_v_out_413072", "413072031", "story_v_out_413072.awb") / 1000

					if var_136_5 + 0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_5 + 0
					end

					if var_136_1.prefab_name ~= "" and arg_133_1.actors_[var_136_1.prefab_name] ~= nil then
						local var_136_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_1.prefab_name].transform, "story_v_out_413072", "413072031", "story_v_out_413072.awb")

						arg_133_1:RecordAudio("413072031", var_136_6)
						arg_133_1:RecordAudio("413072031", var_136_6)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_413072", "413072031", "story_v_out_413072.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_413072", "413072031", "story_v_out_413072.awb")
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
	Play413072032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 413072032
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play413072033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(arg_137_1.actors_["10093"]) and arg_137_1.var_.actorSpriteComps10093 == nil then
				arg_137_1.var_.actorSpriteComps10093 = arg_137_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_0 = 2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 and not isNil(arg_137_1.actors_["10093"]) then
				if arg_137_1.var_.actorSpriteComps10093 then
					for iter_140_0, iter_140_1 in pairs(arg_137_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_140_1 then
							if arg_137_1.isInRecall_ then
								iter_140_1.color = Color.New(Mathf.Lerp(iter_140_1.color.r, arg_137_1.hightColor2.r, (arg_137_1.time_ - 0) / var_140_0), Mathf.Lerp(iter_140_1.color.g, arg_137_1.hightColor2.g, (arg_137_1.time_ - 0) / var_140_0), (Mathf.Lerp(iter_140_1.color.b, arg_137_1.hightColor2.b, (arg_137_1.time_ - 0) / var_140_0)))
							else
								local var_140_1 = Mathf.Lerp(iter_140_1.color.r, 0.5, (arg_137_1.time_ - 0) / var_140_0)

								iter_140_1.color = Color.New(var_140_1, var_140_1, var_140_1)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 and not isNil(arg_137_1.actors_["10093"]) and arg_137_1.var_.actorSpriteComps10093 then
				for iter_140_2, iter_140_3 in pairs(arg_137_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_140_3 then
						iter_140_3.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_137_1.var_.actorSpriteComps10093 = nil
			end

			local var_140_2 = 0
			local var_140_3 = 0.975

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_2 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_4 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(413072032).content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_6 = 39 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 39)

				if (39 <= 0 and var_140_3 or var_140_3 * (utf8.len(var_140_4) / 39)) > 0 and var_140_3 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_2 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_2
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_3, arg_137_1.talkMaxDuration)

			if var_140_2 <= arg_137_1.time_ and arg_137_1.time_ < var_140_2 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_2) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_2 + var_140_7 and arg_137_1.time_ < var_140_2 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play413072033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 413072033
		arg_141_1.duration_ = 3.7

		local var_141_0 = {
			zh = 3.7,
			ja = 3.533
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
				arg_141_0:Play413072034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10093 = arg_141_1.actors_["10093"].transform.localPosition
				arg_141_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10093", 3)

				for iter_144_0 = 0, arg_141_1.actors_["10093"].transform.childCount - 1 do
					local var_144_0 = arg_141_1.actors_["10093"].transform:GetChild(iter_144_0)

					if var_144_0.name == "split_1" or not string.find(var_144_0.name, "split") then
						var_144_0.gameObject:SetActive(true)
					else
						var_144_0.gameObject:SetActive(false)
					end
				end
			end

			local var_144_1 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 then
				arg_141_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_141_1.time_ - 0) / var_144_1)
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_144_2 = arg_141_1.actors_["10093"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps10093 == nil then
				arg_141_1.var_.actorSpriteComps10093 = var_144_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_3 = 2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_3 and not isNil(var_144_2) then
				if arg_141_1.var_.actorSpriteComps10093 then
					for iter_144_1, iter_144_2 in pairs(arg_141_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_141_1.time_ >= 0 + var_144_3 and arg_141_1.time_ < 0 + var_144_3 + arg_144_0 and not isNil(var_144_2) and arg_141_1.var_.actorSpriteComps10093 then
				for iter_144_3, iter_144_4 in pairs(arg_141_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_144_4 then
						iter_144_4.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_141_1.var_.actorSpriteComps10093 = nil
			end

			local var_144_5 = 0
			local var_144_6 = 0.35

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_7 = arg_141_1:GetWordFromCfg(413072033)
				local var_144_8 = arg_141_1:FormatText(var_144_7.content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 14 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 14)

				if (14 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 14)) > 0 and var_144_6 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072033", "story_v_out_413072.awb") ~= 0 then
					local var_144_11 = manager.audio:GetVoiceLength("story_v_out_413072", "413072033", "story_v_out_413072.awb") / 1000

					if var_144_11 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_5
					end

					if var_144_7.prefab_name ~= "" and arg_141_1.actors_[var_144_7.prefab_name] ~= nil then
						local var_144_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_7.prefab_name].transform, "story_v_out_413072", "413072033", "story_v_out_413072.awb")

						arg_141_1:RecordAudio("413072033", var_144_12)
						arg_141_1:RecordAudio("413072033", var_144_12)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_413072", "413072033", "story_v_out_413072.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_413072", "413072033", "story_v_out_413072.awb")
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
				actorName = "10093",
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
	Play413072034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 413072034
		arg_145_1.duration_ = 2.47

		local var_145_0 = {
			zh = 2.1,
			ja = 2.466
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
				arg_145_0:Play413072035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(arg_145_1.actors_["10093"]) and arg_145_1.var_.actorSpriteComps10093 == nil then
				arg_145_1.var_.actorSpriteComps10093 = arg_145_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_0 = 2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 and not isNil(arg_145_1.actors_["10093"]) then
				if arg_145_1.var_.actorSpriteComps10093 then
					for iter_148_0, iter_148_1 in pairs(arg_145_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_148_1 then
							if arg_145_1.isInRecall_ then
								iter_148_1.color = Color.New(Mathf.Lerp(iter_148_1.color.r, arg_145_1.hightColor2.r, (arg_145_1.time_ - 0) / var_148_0), Mathf.Lerp(iter_148_1.color.g, arg_145_1.hightColor2.g, (arg_145_1.time_ - 0) / var_148_0), (Mathf.Lerp(iter_148_1.color.b, arg_145_1.hightColor2.b, (arg_145_1.time_ - 0) / var_148_0)))
							else
								local var_148_1 = Mathf.Lerp(iter_148_1.color.r, 0.5, (arg_145_1.time_ - 0) / var_148_0)

								iter_148_1.color = Color.New(var_148_1, var_148_1, var_148_1)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 and not isNil(arg_145_1.actors_["10093"]) and arg_145_1.var_.actorSpriteComps10093 then
				for iter_148_2, iter_148_3 in pairs(arg_145_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_148_3 then
						iter_148_3.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_145_1.var_.actorSpriteComps10093 = nil
			end

			local var_148_2 = 0
			local var_148_3 = 0.225

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_2 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[994].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_4 = arg_145_1:GetWordFromCfg(413072034)
				local var_148_5 = arg_145_1:FormatText(var_148_4.content)

				arg_145_1.text_.text = var_148_5

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_7 = 9 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_5) / 9)

				if (9 <= 0 and var_148_3 or var_148_3 * (utf8.len(var_148_5) / 9)) > 0 and var_148_3 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_2
					end
				end

				arg_145_1.text_.text = var_148_5
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072034", "story_v_out_413072.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072034", "story_v_out_413072.awb") / 1000

					if var_148_8 + var_148_2 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_2
					end

					if var_148_4.prefab_name ~= "" and arg_145_1.actors_[var_148_4.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_4.prefab_name].transform, "story_v_out_413072", "413072034", "story_v_out_413072.awb")

						arg_145_1:RecordAudio("413072034", var_148_9)
						arg_145_1:RecordAudio("413072034", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_413072", "413072034", "story_v_out_413072.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_413072", "413072034", "story_v_out_413072.awb")
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
	Play413072035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 413072035
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play413072036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos10093 = arg_149_1.actors_["10093"].transform.localPosition
				arg_149_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_149_1:CheckSpriteTmpPos("10093", 7)

				for iter_152_0 = 0, arg_149_1.actors_["10093"].transform.childCount - 1 do
					local var_152_0 = arg_149_1.actors_["10093"].transform:GetChild(iter_152_0)

					if var_152_0.name == "" or not string.find(var_152_0.name, "split") then
						var_152_0.gameObject:SetActive(true)
					else
						var_152_0.gameObject:SetActive(false)
					end
				end
			end

			local var_152_1 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_1 then
				arg_149_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_149_1.time_ - 0) / var_152_1)
			end

			if arg_149_1.time_ >= 0 + var_152_1 and arg_149_1.time_ < 0 + var_152_1 + arg_152_0 then
				arg_149_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_wave", "")
			end

			local var_152_3 = 0
			local var_152_4 = 1.075

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_3 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_5 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(413072035).content)

				arg_149_1.text_.text = var_152_5

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_7 = 43 <= 0 and var_152_4 or var_152_4 * (utf8.len(var_152_5) / 43)

				if (43 <= 0 and var_152_4 or var_152_4 * (utf8.len(var_152_5) / 43)) > 0 and var_152_4 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_3 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_3
					end
				end

				arg_149_1.text_.text = var_152_5
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_8 = math.max(var_152_4, arg_149_1.talkMaxDuration)

			if var_152_3 <= arg_149_1.time_ and arg_149_1.time_ < var_152_3 + var_152_8 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_3) / var_152_8

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_3 + var_152_8 and arg_149_1.time_ < var_152_3 + var_152_8 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
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

		arg_149_1:InitPlayNodeList()
	end,
	Play413072036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 413072036
		arg_153_1.duration_ = 4.07

		local var_153_0 = {
			zh = 3.433,
			ja = 4.066
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
				arg_153_0:Play413072037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10093 = arg_153_1.actors_["10093"].transform.localPosition
				arg_153_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10093", 3)

				for iter_156_0 = 0, arg_153_1.actors_["10093"].transform.childCount - 1 do
					local var_156_0 = arg_153_1.actors_["10093"].transform:GetChild(iter_156_0)

					if var_156_0.name == "split_3" or not string.find(var_156_0.name, "split") then
						var_156_0.gameObject:SetActive(true)
					else
						var_156_0.gameObject:SetActive(false)
					end
				end
			end

			local var_156_1 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_1 then
				arg_153_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_153_1.time_ - 0) / var_156_1)
			end

			if arg_153_1.time_ >= 0 + var_156_1 and arg_153_1.time_ < 0 + var_156_1 + arg_156_0 then
				arg_153_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_156_2 = arg_153_1.actors_["10093"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps10093 == nil then
				arg_153_1.var_.actorSpriteComps10093 = var_156_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_3 = 2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_3 and not isNil(var_156_2) then
				if arg_153_1.var_.actorSpriteComps10093 then
					for iter_156_1, iter_156_2 in pairs(arg_153_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_156_2 then
							if arg_153_1.isInRecall_ then
								iter_156_2.color = Color.New(Mathf.Lerp(iter_156_2.color.r, arg_153_1.hightColor1.r, (arg_153_1.time_ - 0) / var_156_3), Mathf.Lerp(iter_156_2.color.g, arg_153_1.hightColor1.g, (arg_153_1.time_ - 0) / var_156_3), (Mathf.Lerp(iter_156_2.color.b, arg_153_1.hightColor1.b, (arg_153_1.time_ - 0) / var_156_3)))
							else
								local var_156_4 = Mathf.Lerp(iter_156_2.color.r, 1, (arg_153_1.time_ - 0) / var_156_3)

								iter_156_2.color = Color.New(var_156_4, var_156_4, var_156_4)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_3 and arg_153_1.time_ < 0 + var_156_3 + arg_156_0 and not isNil(var_156_2) and arg_153_1.var_.actorSpriteComps10093 then
				for iter_156_3, iter_156_4 in pairs(arg_153_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_156_4 then
						iter_156_4.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps10093 = nil
			end

			local var_156_5 = 0
			local var_156_6 = 0.4

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_7 = arg_153_1:GetWordFromCfg(413072036)
				local var_156_8 = arg_153_1:FormatText(var_156_7.content)

				arg_153_1.text_.text = var_156_8

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_10 = 16 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 16)

				if (16 <= 0 and var_156_6 or var_156_6 * (utf8.len(var_156_8) / 16)) > 0 and var_156_6 < var_156_10 then
					arg_153_1.talkMaxDuration = var_156_10

					if var_156_10 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_5
					end
				end

				arg_153_1.text_.text = var_156_8
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072036", "story_v_out_413072.awb") ~= 0 then
					local var_156_11 = manager.audio:GetVoiceLength("story_v_out_413072", "413072036", "story_v_out_413072.awb") / 1000

					if var_156_11 + var_156_5 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_11 + var_156_5
					end

					if var_156_7.prefab_name ~= "" and arg_153_1.actors_[var_156_7.prefab_name] ~= nil then
						local var_156_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_7.prefab_name].transform, "story_v_out_413072", "413072036", "story_v_out_413072.awb")

						arg_153_1:RecordAudio("413072036", var_156_12)
						arg_153_1:RecordAudio("413072036", var_156_12)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_413072", "413072036", "story_v_out_413072.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_413072", "413072036", "story_v_out_413072.awb")
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
				actorName = "10093",
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
	Play413072037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 413072037
		arg_157_1.duration_ = 7.93

		local var_157_0 = {
			zh = 7.933,
			ja = 7.5
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
				arg_157_0:Play413072038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_9000

			if arg_157_1.actors_["10092"] == nil then
				local var_160_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_160_0) then
					local var_160_1 = Object.Instantiate(var_160_0, arg_157_1.canvasGo_.transform)

					var_160_1.transform:SetSiblingIndex(1)

					var_160_1.name = "10092"
					var_160_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_157_1.actors_["10092"] = var_160_1

					if arg_157_1.isInRecall_ then
						for iter_160_0, iter_160_1 in ipairs((var_160_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_160_1.color = arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_160_2 = arg_157_1.actors_["10092"].transform

			if 2 < arg_157_1.time_ and arg_157_1.time_ <= 2 + arg_160_0 then
				arg_157_1.var_.moveOldPos10092 = var_160_2.localPosition
				var_160_2.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10092", 3)

				for iter_160_2 = 0, var_160_2.childCount - 1 do
					local var_160_3 = var_160_2:GetChild(iter_160_2)

					if var_160_3.name == "" or not string.find(var_160_3.name, "split") then
						var_160_3.gameObject:SetActive(true)
					else
						var_160_3.gameObject:SetActive(false)
					end
				end
			end

			local var_160_4 = 0.001

			if 2 <= arg_157_1.time_ and arg_157_1.time_ < 2 + var_160_4 then
				var_160_2.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_157_1.time_ - 2) / var_160_4)
			end

			if arg_157_1.time_ >= 2 + var_160_4 and arg_157_1.time_ < 2 + var_160_4 + arg_160_0 then
				var_160_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_160_5 = arg_157_1.actors_["10093"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10093 = var_160_5.localPosition
				var_160_5.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10093", 7)

				for iter_160_3 = 0, var_160_5.childCount - 1 do
					local var_160_6 = var_160_5:GetChild(iter_160_3)

					if var_160_6.name == "" or not string.find(var_160_6.name, "split") then
						var_160_6.gameObject:SetActive(true)
					else
						var_160_6.gameObject:SetActive(false)
					end
				end
			end

			local var_160_7 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_7 then
				var_160_5.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_157_1.time_ - 0) / var_160_7)
			end

			if arg_157_1.time_ >= 0 + var_160_7 and arg_157_1.time_ < 0 + var_160_7 + arg_160_0 then
				var_160_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_160_8 = arg_157_1.actors_["10092"]

			if 2 < arg_157_1.time_ and arg_157_1.time_ <= 2 + arg_160_0 and not isNil(var_160_8) and arg_157_1.var_.actorSpriteComps10092 == nil then
				arg_157_1.var_.actorSpriteComps10092 = var_160_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_9 = 2

			if 2 <= arg_157_1.time_ and arg_157_1.time_ < 2 + var_160_9 and not isNil(var_160_8) then
				if arg_157_1.var_.actorSpriteComps10092 then
					for iter_160_4, iter_160_5 in pairs(arg_157_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_160_5 then
							if arg_157_1.isInRecall_ then
								iter_160_5.color = Color.New(Mathf.Lerp(iter_160_5.color.r, arg_157_1.hightColor1.r, (arg_157_1.time_ - 2) / var_160_9), Mathf.Lerp(iter_160_5.color.g, arg_157_1.hightColor1.g, (arg_157_1.time_ - 2) / var_160_9), (Mathf.Lerp(iter_160_5.color.b, arg_157_1.hightColor1.b, (arg_157_1.time_ - 2) / var_160_9)))
							else
								local var_160_10 = Mathf.Lerp(iter_160_5.color.r, 1, (arg_157_1.time_ - 2) / var_160_9)

								iter_160_5.color = Color.New(var_160_10, var_160_10, var_160_10)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 2 + var_160_9 and arg_157_1.time_ < 2 + var_160_9 + arg_160_0 and not isNil(var_160_8) and arg_157_1.var_.actorSpriteComps10092 then
				for iter_160_6, iter_160_7 in pairs(arg_157_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_160_7 then
						iter_160_7.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_157_1.var_.actorSpriteComps10092 = nil
			end

			local var_160_11 = arg_157_1.actors_["10093"]

			if 2 < arg_157_1.time_ and arg_157_1.time_ <= 2 + arg_160_0 and not isNil(var_160_11) and arg_157_1.var_.actorSpriteComps10093 == nil then
				arg_157_1.var_.actorSpriteComps10093 = var_160_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_12 = 2

			if 2 <= arg_157_1.time_ and arg_157_1.time_ < 2 + var_160_12 and not isNil(var_160_11) then
				if arg_157_1.var_.actorSpriteComps10093 then
					for iter_160_8, iter_160_9 in pairs(arg_157_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_160_9 then
							if arg_157_1.isInRecall_ then
								iter_160_9.color = Color.New(Mathf.Lerp(iter_160_9.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 2) / var_160_12), Mathf.Lerp(iter_160_9.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 2) / var_160_12), (Mathf.Lerp(iter_160_9.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 2) / var_160_12)))
							else
								local var_160_13 = Mathf.Lerp(iter_160_9.color.r, 0.5, (arg_157_1.time_ - 2) / var_160_12)

								iter_160_9.color = Color.New(var_160_13, var_160_13, var_160_13)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 2 + var_160_12 and arg_157_1.time_ < 2 + var_160_12 + arg_160_0 and not isNil(var_160_11) and arg_157_1.var_.actorSpriteComps10093 then
				for iter_160_10, iter_160_11 in pairs(arg_157_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_160_11 then
						iter_160_11.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps10093 = nil
			end

			if 2 < arg_157_1.time_ and arg_157_1.time_ <= 2 + arg_160_0 then
				local var_160_14 = arg_157_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_160_14 then
					arg_157_1.var_.alphaOldValue10092 = var_160_14.alpha
					arg_157_1.var_.characterEffect10092 = var_160_14
				end

				arg_157_1.var_.alphaOldValue10092 = 0
			end

			local var_160_15 = 0.3

			if 2 <= arg_157_1.time_ and arg_157_1.time_ < 2 + var_160_15 then
				if arg_157_1.var_.characterEffect10092 then
					arg_157_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_157_1.var_.alphaOldValue10092, 1, (arg_157_1.time_ - 2) / var_160_15)
				end
			end

			if arg_157_1.time_ >= 2 + var_160_15 and arg_157_1.time_ < 2 + var_160_15 + arg_160_0 and arg_157_1.var_.characterEffect10092 then
				arg_157_1.var_.characterEffect10092.alpha = 1
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				if arg_157_1.var_.effectchuanyu1 then
					Object.Destroy(arg_157_1.var_.effectchuanyu1)

					arg_157_1.var_.effectchuanyu1 = nil
				end
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				local var_160_17 = arg_157_1.var_.effect233

				if not arg_157_1.var_.effect233 then
					var_160_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_160_17.name = "233"
					arg_157_1.var_.effect233 = var_160_17
				else
					var_160_17.transform:SetParent(var_160_9000)
				end

				var_160_17.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_160_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.633333333333333 < arg_157_1.time_ and arg_157_1.time_ <= 0.633333333333333 + arg_160_0 then
				if arg_157_1.var_.effect233 then
					Object.Destroy(arg_157_1.var_.effect233)

					arg_157_1.var_.effect233 = nil
				end
			end

			local var_160_20 = 0

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_20 + arg_160_0 then
				arg_157_1.allBtn_.enabled = false
			end

			if arg_157_1.time_ >= var_160_20 + 2 and arg_157_1.time_ < var_160_20 + 2 + arg_160_0 then
				arg_157_1.allBtn_.enabled = true
			end

			local var_160_21 = manager.ui.mainCamera.transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.shakeOldPos = var_160_21.localPosition
			end

			local var_160_22 = 0.6

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_22 then
				local var_160_23, var_160_24 = math.modf((arg_157_1.time_ - 0) / 0.066)

				var_160_21.localPosition = Vector3.New(var_160_24 * 0.13, var_160_24 * 0.13, var_160_24 * 0.13) + arg_157_1.var_.shakeOldPos
			end

			if arg_157_1.time_ >= 0 + var_160_22 and arg_157_1.time_ < 0 + var_160_22 + arg_160_0 then
				var_160_21.localPosition = arg_157_1.var_.shakeOldPos
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_25 = 2
			local var_160_26 = 0.7

			if 2 < arg_157_1.time_ and arg_157_1.time_ <= var_160_25 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_27 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_27:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_28 = arg_157_1:GetWordFromCfg(413072037)
				local var_160_29 = arg_157_1:FormatText(var_160_28.content)

				arg_157_1.text_.text = var_160_29

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_31 = 28 <= 0 and var_160_26 or var_160_26 * (utf8.len(var_160_29) / 28)

				if (28 <= 0 and var_160_26 or var_160_26 * (utf8.len(var_160_29) / 28)) > 0 and var_160_26 < var_160_31 then
					arg_157_1.talkMaxDuration = var_160_31
					var_160_25 = var_160_25 + 0.3

					if var_160_31 + var_160_25 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_31 + var_160_25
					end
				end

				arg_157_1.text_.text = var_160_29
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072037", "story_v_out_413072.awb") ~= 0 then
					local var_160_32 = manager.audio:GetVoiceLength("story_v_out_413072", "413072037", "story_v_out_413072.awb") / 1000

					if var_160_32 + var_160_25 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_32 + var_160_25
					end

					if var_160_28.prefab_name ~= "" and arg_157_1.actors_[var_160_28.prefab_name] ~= nil then
						local var_160_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_28.prefab_name].transform, "story_v_out_413072", "413072037", "story_v_out_413072.awb")

						arg_157_1:RecordAudio("413072037", var_160_33)
						arg_157_1:RecordAudio("413072037", var_160_33)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_413072", "413072037", "story_v_out_413072.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_413072", "413072037", "story_v_out_413072.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_34 = var_160_25 + 0.3
			local var_160_35 = math.max(var_160_26, arg_157_1.talkMaxDuration)

			if var_160_25 + 0.3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_34 + var_160_35 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_34) / var_160_35

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_34 + var_160_35 and arg_157_1.time_ < var_160_34 + var_160_35 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
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

		arg_157_1:InitPlayNodeList()
	end,
	Play413072038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 413072038
		arg_163_1.duration_ = 2.93

		local var_163_0 = {
			zh = 1,
			ja = 2.933
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
				arg_163_0:Play413072039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0.125

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_1 = arg_163_1:GetWordFromCfg(413072038)
				local var_166_2 = arg_163_1:FormatText(var_166_1.content)

				arg_163_1.text_.text = var_166_2

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 5 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 5)

				if (5 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 5)) > 0 and var_166_0 < var_166_4 then
					arg_163_1.talkMaxDuration = var_166_4

					if var_166_4 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_4 + 0
					end
				end

				arg_163_1.text_.text = var_166_2
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072038", "story_v_out_413072.awb") ~= 0 then
					local var_166_5 = manager.audio:GetVoiceLength("story_v_out_413072", "413072038", "story_v_out_413072.awb") / 1000

					if var_166_5 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + 0
					end

					if var_166_1.prefab_name ~= "" and arg_163_1.actors_[var_166_1.prefab_name] ~= nil then
						local var_166_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_1.prefab_name].transform, "story_v_out_413072", "413072038", "story_v_out_413072.awb")

						arg_163_1:RecordAudio("413072038", var_166_6)
						arg_163_1:RecordAudio("413072038", var_166_6)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_413072", "413072038", "story_v_out_413072.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_413072", "413072038", "story_v_out_413072.awb")
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
	Play413072039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 413072039
		arg_167_1.duration_ = 3.67

		local var_167_0 = {
			zh = 3.1,
			ja = 3.666
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
				arg_167_0:Play413072040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10092 = arg_167_1.actors_["10092"].transform.localPosition
				arg_167_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10092", 4)

				for iter_170_0 = 0, arg_167_1.actors_["10092"].transform.childCount - 1 do
					local var_170_0 = arg_167_1.actors_["10092"].transform:GetChild(iter_170_0)

					if var_170_0.name == "" or not string.find(var_170_0.name, "split") then
						var_170_0.gameObject:SetActive(true)
					else
						var_170_0.gameObject:SetActive(false)
					end
				end
			end

			local var_170_1 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_1 then
				arg_167_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_167_1.time_ - 0) / var_170_1)
			end

			if arg_167_1.time_ >= 0 + var_170_1 and arg_167_1.time_ < 0 + var_170_1 + arg_170_0 then
				arg_167_1.actors_["10092"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_170_2 = arg_167_1.actors_["10093"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10093 = var_170_2.localPosition
				var_170_2.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10093", 2)

				for iter_170_1 = 0, var_170_2.childCount - 1 do
					local var_170_3 = var_170_2:GetChild(iter_170_1)

					if var_170_3.name == "split_1" or not string.find(var_170_3.name, "split") then
						var_170_3.gameObject:SetActive(true)
					else
						var_170_3.gameObject:SetActive(false)
					end
				end
			end

			local var_170_4 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				var_170_2.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_167_1.time_ - 0) / var_170_4)
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				var_170_2.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_170_5 = arg_167_1.actors_["10092"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.actorSpriteComps10092 == nil then
				arg_167_1.var_.actorSpriteComps10092 = var_170_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_6 = 2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_6 and not isNil(var_170_5) then
				if arg_167_1.var_.actorSpriteComps10092 then
					for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_170_3 then
							if arg_167_1.isInRecall_ then
								iter_170_3.color = Color.New(Mathf.Lerp(iter_170_3.color.r, arg_167_1.hightColor2.r, (arg_167_1.time_ - 0) / var_170_6), Mathf.Lerp(iter_170_3.color.g, arg_167_1.hightColor2.g, (arg_167_1.time_ - 0) / var_170_6), (Mathf.Lerp(iter_170_3.color.b, arg_167_1.hightColor2.b, (arg_167_1.time_ - 0) / var_170_6)))
							else
								local var_170_7 = Mathf.Lerp(iter_170_3.color.r, 0.5, (arg_167_1.time_ - 0) / var_170_6)

								iter_170_3.color = Color.New(var_170_7, var_170_7, var_170_7)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_6 and arg_167_1.time_ < 0 + var_170_6 + arg_170_0 and not isNil(var_170_5) and arg_167_1.var_.actorSpriteComps10092 then
				for iter_170_4, iter_170_5 in pairs(arg_167_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_170_5 then
						iter_170_5.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps10092 = nil
			end

			local var_170_8 = arg_167_1.actors_["10093"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.actorSpriteComps10093 == nil then
				arg_167_1.var_.actorSpriteComps10093 = var_170_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_9 = 2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_9 and not isNil(var_170_8) then
				if arg_167_1.var_.actorSpriteComps10093 then
					for iter_170_6, iter_170_7 in pairs(arg_167_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_170_7 then
							if arg_167_1.isInRecall_ then
								iter_170_7.color = Color.New(Mathf.Lerp(iter_170_7.color.r, arg_167_1.hightColor1.r, (arg_167_1.time_ - 0) / var_170_9), Mathf.Lerp(iter_170_7.color.g, arg_167_1.hightColor1.g, (arg_167_1.time_ - 0) / var_170_9), (Mathf.Lerp(iter_170_7.color.b, arg_167_1.hightColor1.b, (arg_167_1.time_ - 0) / var_170_9)))
							else
								local var_170_10 = Mathf.Lerp(iter_170_7.color.r, 1, (arg_167_1.time_ - 0) / var_170_9)

								iter_170_7.color = Color.New(var_170_10, var_170_10, var_170_10)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 0 + var_170_9 and arg_167_1.time_ < 0 + var_170_9 + arg_170_0 and not isNil(var_170_8) and arg_167_1.var_.actorSpriteComps10093 then
				for iter_170_8, iter_170_9 in pairs(arg_167_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_170_9 then
						iter_170_9.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps10093 = nil
			end

			local var_170_11 = 0
			local var_170_12 = 0.3

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_11 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_13 = arg_167_1:GetWordFromCfg(413072039)
				local var_170_14 = arg_167_1:FormatText(var_170_13.content)

				arg_167_1.text_.text = var_170_14

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_16 = 12 <= 0 and var_170_12 or var_170_12 * (utf8.len(var_170_14) / 12)

				if (12 <= 0 and var_170_12 or var_170_12 * (utf8.len(var_170_14) / 12)) > 0 and var_170_12 < var_170_16 then
					arg_167_1.talkMaxDuration = var_170_16

					if var_170_16 + var_170_11 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_16 + var_170_11
					end
				end

				arg_167_1.text_.text = var_170_14
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072039", "story_v_out_413072.awb") ~= 0 then
					local var_170_17 = manager.audio:GetVoiceLength("story_v_out_413072", "413072039", "story_v_out_413072.awb") / 1000

					if var_170_17 + var_170_11 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_17 + var_170_11
					end

					if var_170_13.prefab_name ~= "" and arg_167_1.actors_[var_170_13.prefab_name] ~= nil then
						local var_170_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_13.prefab_name].transform, "story_v_out_413072", "413072039", "story_v_out_413072.awb")

						arg_167_1:RecordAudio("413072039", var_170_18)
						arg_167_1:RecordAudio("413072039", var_170_18)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_413072", "413072039", "story_v_out_413072.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_413072", "413072039", "story_v_out_413072.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_19 = math.max(var_170_12, arg_167_1.talkMaxDuration)

			if var_170_11 <= arg_167_1.time_ and arg_167_1.time_ < var_170_11 + var_170_19 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_11) / var_170_19

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_11 + var_170_19 and arg_167_1.time_ < var_170_11 + var_170_19 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
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

		arg_167_1:InitPlayNodeList()
	end,
	Play413072040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 413072040
		arg_171_1.duration_ = 7.27

		local var_171_0 = {
			zh = 3.466,
			ja = 7.266
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
				arg_171_0:Play413072041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10092 = arg_171_1.actors_["10092"].transform.localPosition
				arg_171_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10092", 4)

				for iter_174_0 = 0, arg_171_1.actors_["10092"].transform.childCount - 1 do
					local var_174_0 = arg_171_1.actors_["10092"].transform:GetChild(iter_174_0)

					if var_174_0.name == "" or not string.find(var_174_0.name, "split") then
						var_174_0.gameObject:SetActive(true)
					else
						var_174_0.gameObject:SetActive(false)
					end
				end
			end

			local var_174_1 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 then
				arg_171_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_171_1.time_ - 0) / var_174_1)
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 then
				arg_171_1.actors_["10092"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_174_2 = arg_171_1.actors_["10093"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10093 = var_174_2.localPosition
				var_174_2.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10093", 2)

				for iter_174_1 = 0, var_174_2.childCount - 1 do
					local var_174_3 = var_174_2:GetChild(iter_174_1)

					if var_174_3.name == "" or not string.find(var_174_3.name, "split") then
						var_174_3.gameObject:SetActive(true)
					else
						var_174_3.gameObject:SetActive(false)
					end
				end
			end

			local var_174_4 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				var_174_2.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_171_1.time_ - 0) / var_174_4)
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				var_174_2.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_174_5 = arg_171_1.actors_["10092"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.actorSpriteComps10092 == nil then
				arg_171_1.var_.actorSpriteComps10092 = var_174_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_6 = 2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_6 and not isNil(var_174_5) then
				if arg_171_1.var_.actorSpriteComps10092 then
					for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_174_3 then
							if arg_171_1.isInRecall_ then
								iter_174_3.color = Color.New(Mathf.Lerp(iter_174_3.color.r, arg_171_1.hightColor1.r, (arg_171_1.time_ - 0) / var_174_6), Mathf.Lerp(iter_174_3.color.g, arg_171_1.hightColor1.g, (arg_171_1.time_ - 0) / var_174_6), (Mathf.Lerp(iter_174_3.color.b, arg_171_1.hightColor1.b, (arg_171_1.time_ - 0) / var_174_6)))
							else
								local var_174_7 = Mathf.Lerp(iter_174_3.color.r, 1, (arg_171_1.time_ - 0) / var_174_6)

								iter_174_3.color = Color.New(var_174_7, var_174_7, var_174_7)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_6 and arg_171_1.time_ < 0 + var_174_6 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.actorSpriteComps10092 then
				for iter_174_4, iter_174_5 in pairs(arg_171_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_174_5 then
						iter_174_5.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps10092 = nil
			end

			local var_174_8 = arg_171_1.actors_["10093"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_8) and arg_171_1.var_.actorSpriteComps10093 == nil then
				arg_171_1.var_.actorSpriteComps10093 = var_174_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_9 = 2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_9 and not isNil(var_174_8) then
				if arg_171_1.var_.actorSpriteComps10093 then
					for iter_174_6, iter_174_7 in pairs(arg_171_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_174_7 then
							if arg_171_1.isInRecall_ then
								iter_174_7.color = Color.New(Mathf.Lerp(iter_174_7.color.r, arg_171_1.hightColor2.r, (arg_171_1.time_ - 0) / var_174_9), Mathf.Lerp(iter_174_7.color.g, arg_171_1.hightColor2.g, (arg_171_1.time_ - 0) / var_174_9), (Mathf.Lerp(iter_174_7.color.b, arg_171_1.hightColor2.b, (arg_171_1.time_ - 0) / var_174_9)))
							else
								local var_174_10 = Mathf.Lerp(iter_174_7.color.r, 0.5, (arg_171_1.time_ - 0) / var_174_9)

								iter_174_7.color = Color.New(var_174_10, var_174_10, var_174_10)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_9 and arg_171_1.time_ < 0 + var_174_9 + arg_174_0 and not isNil(var_174_8) and arg_171_1.var_.actorSpriteComps10093 then
				for iter_174_8, iter_174_9 in pairs(arg_171_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_174_9 then
						iter_174_9.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_171_1.var_.actorSpriteComps10093 = nil
			end

			local var_174_11 = 0
			local var_174_12 = 0.325

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_11 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_13 = arg_171_1:GetWordFromCfg(413072040)
				local var_174_14 = arg_171_1:FormatText(var_174_13.content)

				arg_171_1.text_.text = var_174_14

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_16 = 13 <= 0 and var_174_12 or var_174_12 * (utf8.len(var_174_14) / 13)

				if (13 <= 0 and var_174_12 or var_174_12 * (utf8.len(var_174_14) / 13)) > 0 and var_174_12 < var_174_16 then
					arg_171_1.talkMaxDuration = var_174_16

					if var_174_16 + var_174_11 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_16 + var_174_11
					end
				end

				arg_171_1.text_.text = var_174_14
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072040", "story_v_out_413072.awb") ~= 0 then
					local var_174_17 = manager.audio:GetVoiceLength("story_v_out_413072", "413072040", "story_v_out_413072.awb") / 1000

					if var_174_17 + var_174_11 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_17 + var_174_11
					end

					if var_174_13.prefab_name ~= "" and arg_171_1.actors_[var_174_13.prefab_name] ~= nil then
						local var_174_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_13.prefab_name].transform, "story_v_out_413072", "413072040", "story_v_out_413072.awb")

						arg_171_1:RecordAudio("413072040", var_174_18)
						arg_171_1:RecordAudio("413072040", var_174_18)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_413072", "413072040", "story_v_out_413072.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_413072", "413072040", "story_v_out_413072.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_19 = math.max(var_174_12, arg_171_1.talkMaxDuration)

			if var_174_11 <= arg_171_1.time_ and arg_171_1.time_ < var_174_11 + var_174_19 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_11) / var_174_19

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_11 + var_174_19 and arg_171_1.time_ < var_174_11 + var_174_19 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play413072041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 413072041
		arg_175_1.duration_ = 5.4

		local var_175_0 = {
			zh = 3.033,
			ja = 5.4
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
				arg_175_0:Play413072042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.375

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:GetWordFromCfg(413072041)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 15 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 15)

				if (15 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 15)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072041", "story_v_out_413072.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_413072", "413072041", "story_v_out_413072.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_413072", "413072041", "story_v_out_413072.awb")

						arg_175_1:RecordAudio("413072041", var_178_6)
						arg_175_1:RecordAudio("413072041", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_413072", "413072041", "story_v_out_413072.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_413072", "413072041", "story_v_out_413072.awb")
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
	Play413072042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 413072042
		arg_179_1.duration_ = 6.17

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play413072043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0.3 < arg_179_1.time_ and arg_179_1.time_ <= 0.3 + arg_182_0 then
				arg_179_1.var_.moveOldPos10092 = arg_179_1.actors_["10092"].transform.localPosition
				arg_179_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10092", 0)

				for iter_182_0 = 0, arg_179_1.actors_["10092"].transform.childCount - 1 do
					local var_182_0 = arg_179_1.actors_["10092"].transform:GetChild(iter_182_0)

					if var_182_0.name == "" or not string.find(var_182_0.name, "split") then
						var_182_0.gameObject:SetActive(true)
					else
						var_182_0.gameObject:SetActive(false)
					end
				end
			end

			local var_182_1 = 0.001

			if 0.3 <= arg_179_1.time_ and arg_179_1.time_ < 0.3 + var_182_1 then
				arg_179_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10092, Vector3.New(-5000, -315, -320), (arg_179_1.time_ - 0.3) / var_182_1)
			end

			if arg_179_1.time_ >= 0.3 + var_182_1 and arg_179_1.time_ < 0.3 + var_182_1 + arg_182_0 then
				arg_179_1.actors_["10092"].transform.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_182_2 = arg_179_1.actors_["10093"].transform

			if 0.3 < arg_179_1.time_ and arg_179_1.time_ <= 0.3 + arg_182_0 then
				arg_179_1.var_.moveOldPos10093 = var_182_2.localPosition
				var_182_2.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("10093", 0)

				for iter_182_1 = 0, var_182_2.childCount - 1 do
					local var_182_3 = var_182_2:GetChild(iter_182_1)

					if var_182_3.name == "" or not string.find(var_182_3.name, "split") then
						var_182_3.gameObject:SetActive(true)
					else
						var_182_3.gameObject:SetActive(false)
					end
				end
			end

			local var_182_4 = 0.001

			if 0.3 <= arg_179_1.time_ and arg_179_1.time_ < 0.3 + var_182_4 then
				var_182_2.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10093, Vector3.New(-5000, -345, -245), (arg_179_1.time_ - 0.3) / var_182_4)
			end

			if arg_179_1.time_ >= 0.3 + var_182_4 and arg_179_1.time_ < 0.3 + var_182_4 + arg_182_0 then
				var_182_2.localPosition = Vector3.New(-5000, -345, -245)
			end

			local var_182_5 = arg_179_1.actors_["10092"]

			if 0.3 < arg_179_1.time_ and arg_179_1.time_ <= 0.3 + arg_182_0 and not isNil(var_182_5) and arg_179_1.var_.actorSpriteComps10092 == nil then
				arg_179_1.var_.actorSpriteComps10092 = var_182_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_6 = 0.034

			if 0.3 <= arg_179_1.time_ and arg_179_1.time_ < 0.3 + var_182_6 and not isNil(var_182_5) then
				if arg_179_1.var_.actorSpriteComps10092 then
					for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_182_3 then
							if arg_179_1.isInRecall_ then
								iter_182_3.color = Color.New(Mathf.Lerp(iter_182_3.color.r, arg_179_1.hightColor2.r, (arg_179_1.time_ - 0.3) / var_182_6), Mathf.Lerp(iter_182_3.color.g, arg_179_1.hightColor2.g, (arg_179_1.time_ - 0.3) / var_182_6), (Mathf.Lerp(iter_182_3.color.b, arg_179_1.hightColor2.b, (arg_179_1.time_ - 0.3) / var_182_6)))
							else
								local var_182_7 = Mathf.Lerp(iter_182_3.color.r, 0.5, (arg_179_1.time_ - 0.3) / var_182_6)

								iter_182_3.color = Color.New(var_182_7, var_182_7, var_182_7)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0.3 + var_182_6 and arg_179_1.time_ < 0.3 + var_182_6 + arg_182_0 and not isNil(var_182_5) and arg_179_1.var_.actorSpriteComps10092 then
				for iter_182_4, iter_182_5 in pairs(arg_179_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_182_5 then
						iter_182_5.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps10092 = nil
			end

			local var_182_8 = arg_179_1.actors_["10093"]

			if 0.3 < arg_179_1.time_ and arg_179_1.time_ <= 0.3 + arg_182_0 and not isNil(var_182_8) and arg_179_1.var_.actorSpriteComps10093 == nil then
				arg_179_1.var_.actorSpriteComps10093 = var_182_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_9 = 0.034

			if 0.3 <= arg_179_1.time_ and arg_179_1.time_ < 0.3 + var_182_9 and not isNil(var_182_8) then
				if arg_179_1.var_.actorSpriteComps10093 then
					for iter_182_6, iter_182_7 in pairs(arg_179_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_182_7 then
							if arg_179_1.isInRecall_ then
								iter_182_7.color = Color.New(Mathf.Lerp(iter_182_7.color.r, arg_179_1.hightColor2.r, (arg_179_1.time_ - 0.3) / var_182_9), Mathf.Lerp(iter_182_7.color.g, arg_179_1.hightColor2.g, (arg_179_1.time_ - 0.3) / var_182_9), (Mathf.Lerp(iter_182_7.color.b, arg_179_1.hightColor2.b, (arg_179_1.time_ - 0.3) / var_182_9)))
							else
								local var_182_10 = Mathf.Lerp(iter_182_7.color.r, 0.5, (arg_179_1.time_ - 0.3) / var_182_9)

								iter_182_7.color = Color.New(var_182_10, var_182_10, var_182_10)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0.3 + var_182_9 and arg_179_1.time_ < 0.3 + var_182_9 + arg_182_0 and not isNil(var_182_8) and arg_179_1.var_.actorSpriteComps10093 then
				for iter_182_8, iter_182_9 in pairs(arg_179_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_182_9 then
						iter_182_9.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps10093 = nil
			end

			local var_182_11 = 0.3

			if 0.3 < arg_179_1.time_ and arg_179_1.time_ <= var_182_11 + arg_182_0 then
				arg_179_1.mask_.enabled = true
				arg_179_1.mask_.raycastTarget = false

				arg_179_1:SetGaussion(false)
			end

			local var_182_12 = 1

			if var_182_11 <= arg_179_1.time_ and arg_179_1.time_ < var_182_11 + var_182_12 then
				local var_182_13 = Color.New(1, 1, 1)

				var_182_13.a = Mathf.Lerp(1, 0, (arg_179_1.time_ - var_182_11) / var_182_12)
				arg_179_1.mask_.color = var_182_13
			end

			if arg_179_1.time_ >= var_182_11 + var_182_12 and arg_179_1.time_ < var_182_11 + var_182_12 + arg_182_0 then
				local var_182_14 = Color.New(1, 1, 1)

				arg_179_1.mask_.enabled = false
				var_182_14.a = 0
				arg_179_1.mask_.color = var_182_14
			end

			local var_182_15 = 0

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_15 + arg_182_0 then
				arg_179_1.allBtn_.enabled = false
			end

			if arg_179_1.time_ >= var_182_15 + 0.833333333333333 and arg_179_1.time_ < var_182_15 + 0.833333333333333 + arg_182_0 then
				arg_179_1.allBtn_.enabled = true
			end

			if 0.366666666666667 < arg_179_1.time_ and arg_179_1.time_ <= 0.366666666666667 + arg_182_0 then
				arg_179_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_explosionfar", "")
			end

			if arg_179_1.frameCnt_ <= 1 then
				arg_179_1.dialog_:SetActive(false)
			end

			local var_182_17 = 1.16666666666667
			local var_182_18 = 1.775

			if 1.16666666666667 < arg_179_1.time_ and arg_179_1.time_ <= var_182_17 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0

				arg_179_1.dialog_:SetActive(true)

				arg_179_1.dialogCg_.alpha = 0

				local var_182_19 = LeanTween.value(arg_179_1.dialog_, 0, 1, 0.3)

				var_182_19:setOnUpdate(LuaHelper.FloatAction(function(arg_183_0)
					arg_179_1.dialogCg_.alpha = arg_183_0
				end))
				var_182_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_179_1.dialog_)
					var_182_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_179_1.duration_ = arg_179_1.duration_ + 0.3

				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_20 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(413072042).content)

				arg_179_1.text_.text = var_182_20

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_22 = 71 <= 0 and var_182_18 or var_182_18 * (utf8.len(var_182_20) / 71)

				if (71 <= 0 and var_182_18 or var_182_18 * (utf8.len(var_182_20) / 71)) > 0 and var_182_18 < var_182_22 then
					arg_179_1.talkMaxDuration = var_182_22
					var_182_17 = var_182_17 + 0.3

					if var_182_22 + var_182_17 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_22 + var_182_17
					end
				end

				arg_179_1.text_.text = var_182_20
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_23 = var_182_17 + 0.3
			local var_182_24 = math.max(var_182_18, arg_179_1.talkMaxDuration)

			if var_182_17 + 0.3 <= arg_179_1.time_ and arg_179_1.time_ < var_182_23 + var_182_24 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_23) / var_182_24

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_23 + var_182_24 and arg_179_1.time_ < var_182_23 + var_182_24 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play413072043 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 413072043
		arg_185_1.duration_ = 4.33

		local var_185_0 = {
			zh = 4.333,
			ja = 4.133
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
				arg_185_0:Play413072044(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.6

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, true)
				arg_185_1.iconController_:SetSelectedState("hero")

				arg_185_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_185_1.callingController_:SetSelectedState("normal")

				arg_185_1.keyicon_.color = Color.New(1, 1, 1)
				arg_185_1.icon_.color = Color.New(1, 1, 1)

				local var_188_1 = arg_185_1:GetWordFromCfg(413072043)
				local var_188_2 = arg_185_1:FormatText(var_188_1.content)

				arg_185_1.text_.text = var_188_2

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 24 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 24)

				if (24 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_2) / 24)) > 0 and var_188_0 < var_188_4 then
					arg_185_1.talkMaxDuration = var_188_4

					if var_188_4 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_4 + 0
					end
				end

				arg_185_1.text_.text = var_188_2
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072043", "story_v_out_413072.awb") ~= 0 then
					local var_188_5 = manager.audio:GetVoiceLength("story_v_out_413072", "413072043", "story_v_out_413072.awb") / 1000

					if var_188_5 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_5 + 0
					end

					if var_188_1.prefab_name ~= "" and arg_185_1.actors_[var_188_1.prefab_name] ~= nil then
						local var_188_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_1.prefab_name].transform, "story_v_out_413072", "413072043", "story_v_out_413072.awb")

						arg_185_1:RecordAudio("413072043", var_188_6)
						arg_185_1:RecordAudio("413072043", var_188_6)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_413072", "413072043", "story_v_out_413072.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_413072", "413072043", "story_v_out_413072.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_7 and arg_185_1.time_ < 0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play413072044 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 413072044
		arg_189_1.duration_ = 3.63

		local var_189_0 = {
			zh = 3.266,
			ja = 3.633
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
				arg_189_0:Play413072045(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10092 = arg_189_1.actors_["10092"].transform.localPosition
				arg_189_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10092", 3)

				for iter_192_0 = 0, arg_189_1.actors_["10092"].transform.childCount - 1 do
					local var_192_0 = arg_189_1.actors_["10092"].transform:GetChild(iter_192_0)

					if var_192_0.name == "split_1_1" or not string.find(var_192_0.name, "split") then
						var_192_0.gameObject:SetActive(true)
					else
						var_192_0.gameObject:SetActive(false)
					end
				end
			end

			local var_192_1 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_1 then
				arg_189_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_189_1.time_ - 0) / var_192_1)
			end

			if arg_189_1.time_ >= 0 + var_192_1 and arg_189_1.time_ < 0 + var_192_1 + arg_192_0 then
				arg_189_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_192_2 = arg_189_1.actors_["10092"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.actorSpriteComps10092 == nil then
				arg_189_1.var_.actorSpriteComps10092 = var_192_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_3 = 2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.actorSpriteComps10092 then
					for iter_192_1, iter_192_2 in pairs(arg_189_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_192_2 then
							if arg_189_1.isInRecall_ then
								iter_192_2.color = Color.New(Mathf.Lerp(iter_192_2.color.r, arg_189_1.hightColor1.r, (arg_189_1.time_ - 0) / var_192_3), Mathf.Lerp(iter_192_2.color.g, arg_189_1.hightColor1.g, (arg_189_1.time_ - 0) / var_192_3), (Mathf.Lerp(iter_192_2.color.b, arg_189_1.hightColor1.b, (arg_189_1.time_ - 0) / var_192_3)))
							else
								local var_192_4 = Mathf.Lerp(iter_192_2.color.r, 1, (arg_189_1.time_ - 0) / var_192_3)

								iter_192_2.color = Color.New(var_192_4, var_192_4, var_192_4)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.actorSpriteComps10092 then
				for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_192_4 then
						iter_192_4.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_189_1.var_.actorSpriteComps10092 = nil
			end

			local var_192_5 = 0
			local var_192_6 = 0.425

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_7 = arg_189_1:GetWordFromCfg(413072044)
				local var_192_8 = arg_189_1:FormatText(var_192_7.content)

				arg_189_1.text_.text = var_192_8

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_10 = 17 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 17)

				if (17 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 17)) > 0 and var_192_6 < var_192_10 then
					arg_189_1.talkMaxDuration = var_192_10

					if var_192_10 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_5
					end
				end

				arg_189_1.text_.text = var_192_8
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072044", "story_v_out_413072.awb") ~= 0 then
					local var_192_11 = manager.audio:GetVoiceLength("story_v_out_413072", "413072044", "story_v_out_413072.awb") / 1000

					if var_192_11 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_5
					end

					if var_192_7.prefab_name ~= "" and arg_189_1.actors_[var_192_7.prefab_name] ~= nil then
						local var_192_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_7.prefab_name].transform, "story_v_out_413072", "413072044", "story_v_out_413072.awb")

						arg_189_1:RecordAudio("413072044", var_192_12)
						arg_189_1:RecordAudio("413072044", var_192_12)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_413072", "413072044", "story_v_out_413072.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_413072", "413072044", "story_v_out_413072.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_13 = math.max(var_192_6, arg_189_1.talkMaxDuration)

			if var_192_5 <= arg_189_1.time_ and arg_189_1.time_ < var_192_5 + var_192_13 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_5) / var_192_13

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_5 + var_192_13 and arg_189_1.time_ < var_192_5 + var_192_13 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
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

		arg_189_1:InitPlayNodeList()
	end,
	Play413072045 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 413072045
		arg_193_1.duration_ = 4.6

		local var_193_0 = {
			zh = 4.533,
			ja = 4.6
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play413072046(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10092 = arg_193_1.actors_["10092"].transform.localPosition
				arg_193_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10092", 3)

				for iter_196_0 = 0, arg_193_1.actors_["10092"].transform.childCount - 1 do
					local var_196_0 = arg_193_1.actors_["10092"].transform:GetChild(iter_196_0)

					if var_196_0.name == "split_1_1" or not string.find(var_196_0.name, "split") then
						var_196_0.gameObject:SetActive(true)
					else
						var_196_0.gameObject:SetActive(false)
					end
				end
			end

			local var_196_1 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_1 then
				arg_193_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_193_1.time_ - 0) / var_196_1)
			end

			if arg_193_1.time_ >= 0 + var_196_1 and arg_193_1.time_ < 0 + var_196_1 + arg_196_0 then
				arg_193_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_196_2 = arg_193_1.actors_["10092"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps10092 == nil then
				arg_193_1.var_.actorSpriteComps10092 = var_196_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_3 = 2

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.actorSpriteComps10092 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_196_2 then
							if arg_193_1.isInRecall_ then
								iter_196_2.color = Color.New(Mathf.Lerp(iter_196_2.color.r, arg_193_1.hightColor2.r, (arg_193_1.time_ - 0) / var_196_3), Mathf.Lerp(iter_196_2.color.g, arg_193_1.hightColor2.g, (arg_193_1.time_ - 0) / var_196_3), (Mathf.Lerp(iter_196_2.color.b, arg_193_1.hightColor2.b, (arg_193_1.time_ - 0) / var_196_3)))
							else
								local var_196_4 = Mathf.Lerp(iter_196_2.color.r, 0.5, (arg_193_1.time_ - 0) / var_196_3)

								iter_196_2.color = Color.New(var_196_4, var_196_4, var_196_4)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps10092 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_196_4 then
						iter_196_4.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps10092 = nil
			end

			local var_196_5 = 0
			local var_196_6 = 0.55

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_7 = arg_193_1:GetWordFromCfg(413072045)
				local var_196_8 = arg_193_1:FormatText(var_196_7.content)

				arg_193_1.text_.text = var_196_8

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_10 = 22 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 22)

				if (22 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 22)) > 0 and var_196_6 < var_196_10 then
					arg_193_1.talkMaxDuration = var_196_10

					if var_196_10 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_5
					end
				end

				arg_193_1.text_.text = var_196_8
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072045", "story_v_out_413072.awb") ~= 0 then
					local var_196_11 = manager.audio:GetVoiceLength("story_v_out_413072", "413072045", "story_v_out_413072.awb") / 1000

					if var_196_11 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_11 + var_196_5
					end

					if var_196_7.prefab_name ~= "" and arg_193_1.actors_[var_196_7.prefab_name] ~= nil then
						local var_196_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_7.prefab_name].transform, "story_v_out_413072", "413072045", "story_v_out_413072.awb")

						arg_193_1:RecordAudio("413072045", var_196_12)
						arg_193_1:RecordAudio("413072045", var_196_12)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_413072", "413072045", "story_v_out_413072.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_413072", "413072045", "story_v_out_413072.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_13 = math.max(var_196_6, arg_193_1.talkMaxDuration)

			if var_196_5 <= arg_193_1.time_ and arg_193_1.time_ < var_196_5 + var_196_13 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_5) / var_196_13

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_5 + var_196_13 and arg_193_1.time_ < var_196_5 + var_196_13 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
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

		arg_193_1:InitPlayNodeList()
	end,
	Play413072046 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 413072046
		arg_197_1.duration_ = 3.87

		local var_197_0 = {
			zh = 3.5,
			ja = 3.866
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play413072047(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10093 = arg_197_1.actors_["10093"].transform.localPosition
				arg_197_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10093", 2)

				for iter_200_0 = 0, arg_197_1.actors_["10093"].transform.childCount - 1 do
					local var_200_0 = arg_197_1.actors_["10093"].transform:GetChild(iter_200_0)

					if var_200_0.name == "" or not string.find(var_200_0.name, "split") then
						var_200_0.gameObject:SetActive(true)
					else
						var_200_0.gameObject:SetActive(false)
					end
				end
			end

			local var_200_1 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_1 then
				arg_197_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_197_1.time_ - 0) / var_200_1)
			end

			if arg_197_1.time_ >= 0 + var_200_1 and arg_197_1.time_ < 0 + var_200_1 + arg_200_0 then
				arg_197_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_200_2 = arg_197_1.actors_["10093"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps10093 == nil then
				arg_197_1.var_.actorSpriteComps10093 = var_200_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_200_3 = 2

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.actorSpriteComps10093 then
					for iter_200_1, iter_200_2 in pairs(arg_197_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_200_2 then
							if arg_197_1.isInRecall_ then
								iter_200_2.color = Color.New(Mathf.Lerp(iter_200_2.color.r, arg_197_1.hightColor1.r, (arg_197_1.time_ - 0) / var_200_3), Mathf.Lerp(iter_200_2.color.g, arg_197_1.hightColor1.g, (arg_197_1.time_ - 0) / var_200_3), (Mathf.Lerp(iter_200_2.color.b, arg_197_1.hightColor1.b, (arg_197_1.time_ - 0) / var_200_3)))
							else
								local var_200_4 = Mathf.Lerp(iter_200_2.color.r, 1, (arg_197_1.time_ - 0) / var_200_3)

								iter_200_2.color = Color.New(var_200_4, var_200_4, var_200_4)
							end
						end
					end
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.actorSpriteComps10093 then
				for iter_200_3, iter_200_4 in pairs(arg_197_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_200_4 then
						iter_200_4.color = arg_197_1.isInRecall_ and (arg_197_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_197_1.var_.actorSpriteComps10093 = nil
			end

			local var_200_5 = arg_197_1.actors_["10092"].transform

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10092 = var_200_5.localPosition
				var_200_5.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("10092", 4)

				for iter_200_5 = 0, var_200_5.childCount - 1 do
					local var_200_6 = var_200_5:GetChild(iter_200_5)

					if var_200_6.name == "split_1_1" or not string.find(var_200_6.name, "split") then
						var_200_6.gameObject:SetActive(true)
					else
						var_200_6.gameObject:SetActive(false)
					end
				end
			end

			local var_200_7 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				var_200_5.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_197_1.time_ - 0) / var_200_7)
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				var_200_5.localPosition = Vector3.New(390, -300, -295)
			end

			local var_200_8 = 0
			local var_200_9 = 0.525

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_10 = arg_197_1:GetWordFromCfg(413072046)
				local var_200_11 = arg_197_1:FormatText(var_200_10.content)

				arg_197_1.text_.text = var_200_11

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_13 = 21 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_11) / 21)

				if (21 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_11) / 21)) > 0 and var_200_9 < var_200_13 then
					arg_197_1.talkMaxDuration = var_200_13

					if var_200_13 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_13 + var_200_8
					end
				end

				arg_197_1.text_.text = var_200_11
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072046", "story_v_out_413072.awb") ~= 0 then
					local var_200_14 = manager.audio:GetVoiceLength("story_v_out_413072", "413072046", "story_v_out_413072.awb") / 1000

					if var_200_14 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_14 + var_200_8
					end

					if var_200_10.prefab_name ~= "" and arg_197_1.actors_[var_200_10.prefab_name] ~= nil then
						local var_200_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_10.prefab_name].transform, "story_v_out_413072", "413072046", "story_v_out_413072.awb")

						arg_197_1:RecordAudio("413072046", var_200_15)
						arg_197_1:RecordAudio("413072046", var_200_15)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_413072", "413072046", "story_v_out_413072.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_413072", "413072046", "story_v_out_413072.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_16 = math.max(var_200_9, arg_197_1.talkMaxDuration)

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_16 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_8) / var_200_16

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_8 + var_200_16 and arg_197_1.time_ < var_200_8 + var_200_16 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
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

		arg_197_1:InitPlayNodeList()
	end,
	Play413072047 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 413072047
		arg_201_1.duration_ = 6.87

		local var_201_0 = {
			zh = 6.866,
			ja = 5.866
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
				arg_201_0:Play413072048(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["10092"]) and arg_201_1.var_.actorSpriteComps10092 == nil then
				arg_201_1.var_.actorSpriteComps10092 = arg_201_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_0 = 2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["10092"]) then
				if arg_201_1.var_.actorSpriteComps10092 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_204_1 then
							if arg_201_1.isInRecall_ then
								iter_204_1.color = Color.New(Mathf.Lerp(iter_204_1.color.r, arg_201_1.hightColor1.r, (arg_201_1.time_ - 0) / var_204_0), Mathf.Lerp(iter_204_1.color.g, arg_201_1.hightColor1.g, (arg_201_1.time_ - 0) / var_204_0), (Mathf.Lerp(iter_204_1.color.b, arg_201_1.hightColor1.b, (arg_201_1.time_ - 0) / var_204_0)))
							else
								local var_204_1 = Mathf.Lerp(iter_204_1.color.r, 1, (arg_201_1.time_ - 0) / var_204_0)

								iter_204_1.color = Color.New(var_204_1, var_204_1, var_204_1)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["10092"]) and arg_201_1.var_.actorSpriteComps10092 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_204_3 then
						iter_204_3.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_201_1.var_.actorSpriteComps10092 = nil
			end

			local var_204_2 = arg_201_1.actors_["10093"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps10093 == nil then
				arg_201_1.var_.actorSpriteComps10093 = var_204_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_3 = 2

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 and not isNil(var_204_2) then
				if arg_201_1.var_.actorSpriteComps10093 then
					for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_204_5 then
							if arg_201_1.isInRecall_ then
								iter_204_5.color = Color.New(Mathf.Lerp(iter_204_5.color.r, arg_201_1.hightColor2.r, (arg_201_1.time_ - 0) / var_204_3), Mathf.Lerp(iter_204_5.color.g, arg_201_1.hightColor2.g, (arg_201_1.time_ - 0) / var_204_3), (Mathf.Lerp(iter_204_5.color.b, arg_201_1.hightColor2.b, (arg_201_1.time_ - 0) / var_204_3)))
							else
								local var_204_4 = Mathf.Lerp(iter_204_5.color.r, 0.5, (arg_201_1.time_ - 0) / var_204_3)

								iter_204_5.color = Color.New(var_204_4, var_204_4, var_204_4)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps10093 then
				for iter_204_6, iter_204_7 in pairs(arg_201_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_204_7 then
						iter_204_7.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_201_1.var_.actorSpriteComps10093 = nil
			end

			local var_204_5 = 0
			local var_204_6 = 0.875

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_7 = arg_201_1:GetWordFromCfg(413072047)
				local var_204_8 = arg_201_1:FormatText(var_204_7.content)

				arg_201_1.text_.text = var_204_8

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_10 = 35 <= 0 and var_204_6 or var_204_6 * (utf8.len(var_204_8) / 35)

				if (35 <= 0 and var_204_6 or var_204_6 * (utf8.len(var_204_8) / 35)) > 0 and var_204_6 < var_204_10 then
					arg_201_1.talkMaxDuration = var_204_10

					if var_204_10 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_5
					end
				end

				arg_201_1.text_.text = var_204_8
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072047", "story_v_out_413072.awb") ~= 0 then
					local var_204_11 = manager.audio:GetVoiceLength("story_v_out_413072", "413072047", "story_v_out_413072.awb") / 1000

					if var_204_11 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_11 + var_204_5
					end

					if var_204_7.prefab_name ~= "" and arg_201_1.actors_[var_204_7.prefab_name] ~= nil then
						local var_204_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_7.prefab_name].transform, "story_v_out_413072", "413072047", "story_v_out_413072.awb")

						arg_201_1:RecordAudio("413072047", var_204_12)
						arg_201_1:RecordAudio("413072047", var_204_12)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_413072", "413072047", "story_v_out_413072.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_413072", "413072047", "story_v_out_413072.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_13 = math.max(var_204_6, arg_201_1.talkMaxDuration)

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_13 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_5) / var_204_13

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_5 + var_204_13 and arg_201_1.time_ < var_204_5 + var_204_13 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play413072048 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 413072048
		arg_205_1.duration_ = 9.63

		local var_205_0 = {
			zh = 5.833,
			ja = 9.633
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
				arg_205_0:Play413072049(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0.7

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_1 = arg_205_1:GetWordFromCfg(413072048)
				local var_208_2 = arg_205_1:FormatText(var_208_1.content)

				arg_205_1.text_.text = var_208_2

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_4 = 28 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 28)

				if (28 <= 0 and var_208_0 or var_208_0 * (utf8.len(var_208_2) / 28)) > 0 and var_208_0 < var_208_4 then
					arg_205_1.talkMaxDuration = var_208_4

					if var_208_4 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_4 + 0
					end
				end

				arg_205_1.text_.text = var_208_2
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072048", "story_v_out_413072.awb") ~= 0 then
					local var_208_5 = manager.audio:GetVoiceLength("story_v_out_413072", "413072048", "story_v_out_413072.awb") / 1000

					if var_208_5 + 0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_5 + 0
					end

					if var_208_1.prefab_name ~= "" and arg_205_1.actors_[var_208_1.prefab_name] ~= nil then
						local var_208_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_1.prefab_name].transform, "story_v_out_413072", "413072048", "story_v_out_413072.awb")

						arg_205_1:RecordAudio("413072048", var_208_6)
						arg_205_1:RecordAudio("413072048", var_208_6)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_413072", "413072048", "story_v_out_413072.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_413072", "413072048", "story_v_out_413072.awb")
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
	Play413072049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 413072049
		arg_209_1.duration_ = 4.23

		local var_209_0 = {
			zh = 4.233,
			ja = 3.1
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
				arg_209_0:Play413072050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos10093 = arg_209_1.actors_["10093"].transform.localPosition
				arg_209_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10093", 2)

				for iter_212_0 = 0, arg_209_1.actors_["10093"].transform.childCount - 1 do
					local var_212_0 = arg_209_1.actors_["10093"].transform:GetChild(iter_212_0)

					if var_212_0.name == "split_6" or not string.find(var_212_0.name, "split") then
						var_212_0.gameObject:SetActive(true)
					else
						var_212_0.gameObject:SetActive(false)
					end
				end
			end

			local var_212_1 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_1 then
				arg_209_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_209_1.time_ - 0) / var_212_1)
			end

			if arg_209_1.time_ >= 0 + var_212_1 and arg_209_1.time_ < 0 + var_212_1 + arg_212_0 then
				arg_209_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_212_2 = arg_209_1.actors_["10092"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.actorSpriteComps10092 == nil then
				arg_209_1.var_.actorSpriteComps10092 = var_212_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_3 = 2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_3 and not isNil(var_212_2) then
				if arg_209_1.var_.actorSpriteComps10092 then
					for iter_212_1, iter_212_2 in pairs(arg_209_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_212_2 then
							if arg_209_1.isInRecall_ then
								iter_212_2.color = Color.New(Mathf.Lerp(iter_212_2.color.r, arg_209_1.hightColor2.r, (arg_209_1.time_ - 0) / var_212_3), Mathf.Lerp(iter_212_2.color.g, arg_209_1.hightColor2.g, (arg_209_1.time_ - 0) / var_212_3), (Mathf.Lerp(iter_212_2.color.b, arg_209_1.hightColor2.b, (arg_209_1.time_ - 0) / var_212_3)))
							else
								local var_212_4 = Mathf.Lerp(iter_212_2.color.r, 0.5, (arg_209_1.time_ - 0) / var_212_3)

								iter_212_2.color = Color.New(var_212_4, var_212_4, var_212_4)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_3 and arg_209_1.time_ < 0 + var_212_3 + arg_212_0 and not isNil(var_212_2) and arg_209_1.var_.actorSpriteComps10092 then
				for iter_212_3, iter_212_4 in pairs(arg_209_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_212_4 then
						iter_212_4.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_209_1.var_.actorSpriteComps10092 = nil
			end

			local var_212_5 = arg_209_1.actors_["10093"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.actorSpriteComps10093 == nil then
				arg_209_1.var_.actorSpriteComps10093 = var_212_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_6 = 2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_6 and not isNil(var_212_5) then
				if arg_209_1.var_.actorSpriteComps10093 then
					for iter_212_5, iter_212_6 in pairs(arg_209_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_212_6 then
							if arg_209_1.isInRecall_ then
								iter_212_6.color = Color.New(Mathf.Lerp(iter_212_6.color.r, arg_209_1.hightColor1.r, (arg_209_1.time_ - 0) / var_212_6), Mathf.Lerp(iter_212_6.color.g, arg_209_1.hightColor1.g, (arg_209_1.time_ - 0) / var_212_6), (Mathf.Lerp(iter_212_6.color.b, arg_209_1.hightColor1.b, (arg_209_1.time_ - 0) / var_212_6)))
							else
								local var_212_7 = Mathf.Lerp(iter_212_6.color.r, 1, (arg_209_1.time_ - 0) / var_212_6)

								iter_212_6.color = Color.New(var_212_7, var_212_7, var_212_7)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_6 and arg_209_1.time_ < 0 + var_212_6 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.actorSpriteComps10093 then
				for iter_212_7, iter_212_8 in pairs(arg_209_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_212_8 then
						iter_212_8.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_209_1.var_.actorSpriteComps10093 = nil
			end

			local var_212_8 = 0
			local var_212_9 = 0.4

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_8 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_10 = arg_209_1:GetWordFromCfg(413072049)
				local var_212_11 = arg_209_1:FormatText(var_212_10.content)

				arg_209_1.text_.text = var_212_11

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_13 = 16 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 16)

				if (16 <= 0 and var_212_9 or var_212_9 * (utf8.len(var_212_11) / 16)) > 0 and var_212_9 < var_212_13 then
					arg_209_1.talkMaxDuration = var_212_13

					if var_212_13 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_13 + var_212_8
					end
				end

				arg_209_1.text_.text = var_212_11
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072049", "story_v_out_413072.awb") ~= 0 then
					local var_212_14 = manager.audio:GetVoiceLength("story_v_out_413072", "413072049", "story_v_out_413072.awb") / 1000

					if var_212_14 + var_212_8 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_14 + var_212_8
					end

					if var_212_10.prefab_name ~= "" and arg_209_1.actors_[var_212_10.prefab_name] ~= nil then
						local var_212_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_10.prefab_name].transform, "story_v_out_413072", "413072049", "story_v_out_413072.awb")

						arg_209_1:RecordAudio("413072049", var_212_15)
						arg_209_1:RecordAudio("413072049", var_212_15)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_413072", "413072049", "story_v_out_413072.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_413072", "413072049", "story_v_out_413072.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_16 = math.max(var_212_9, arg_209_1.talkMaxDuration)

			if var_212_8 <= arg_209_1.time_ and arg_209_1.time_ < var_212_8 + var_212_16 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_8) / var_212_16

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_8 + var_212_16 and arg_209_1.time_ < var_212_8 + var_212_16 + arg_212_0 then
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
	Play413072050 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 413072050
		arg_213_1.duration_ = 6.87

		local var_213_0 = {
			zh = 5.166,
			ja = 6.866
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
				arg_213_0:Play413072051(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["10092"]) and arg_213_1.var_.actorSpriteComps10092 == nil then
				arg_213_1.var_.actorSpriteComps10092 = arg_213_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_0 = 2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["10092"]) then
				if arg_213_1.var_.actorSpriteComps10092 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_216_1 then
							if arg_213_1.isInRecall_ then
								iter_216_1.color = Color.New(Mathf.Lerp(iter_216_1.color.r, arg_213_1.hightColor1.r, (arg_213_1.time_ - 0) / var_216_0), Mathf.Lerp(iter_216_1.color.g, arg_213_1.hightColor1.g, (arg_213_1.time_ - 0) / var_216_0), (Mathf.Lerp(iter_216_1.color.b, arg_213_1.hightColor1.b, (arg_213_1.time_ - 0) / var_216_0)))
							else
								local var_216_1 = Mathf.Lerp(iter_216_1.color.r, 1, (arg_213_1.time_ - 0) / var_216_0)

								iter_216_1.color = Color.New(var_216_1, var_216_1, var_216_1)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["10092"]) and arg_213_1.var_.actorSpriteComps10092 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_216_3 then
						iter_216_3.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_213_1.var_.actorSpriteComps10092 = nil
			end

			local var_216_2 = arg_213_1.actors_["10093"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps10093 == nil then
				arg_213_1.var_.actorSpriteComps10093 = var_216_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_3 = 2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_3 and not isNil(var_216_2) then
				if arg_213_1.var_.actorSpriteComps10093 then
					for iter_216_4, iter_216_5 in pairs(arg_213_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_216_5 then
							if arg_213_1.isInRecall_ then
								iter_216_5.color = Color.New(Mathf.Lerp(iter_216_5.color.r, arg_213_1.hightColor2.r, (arg_213_1.time_ - 0) / var_216_3), Mathf.Lerp(iter_216_5.color.g, arg_213_1.hightColor2.g, (arg_213_1.time_ - 0) / var_216_3), (Mathf.Lerp(iter_216_5.color.b, arg_213_1.hightColor2.b, (arg_213_1.time_ - 0) / var_216_3)))
							else
								local var_216_4 = Mathf.Lerp(iter_216_5.color.r, 0.5, (arg_213_1.time_ - 0) / var_216_3)

								iter_216_5.color = Color.New(var_216_4, var_216_4, var_216_4)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_3 and arg_213_1.time_ < 0 + var_216_3 + arg_216_0 and not isNil(var_216_2) and arg_213_1.var_.actorSpriteComps10093 then
				for iter_216_6, iter_216_7 in pairs(arg_213_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_216_7 then
						iter_216_7.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_213_1.var_.actorSpriteComps10093 = nil
			end

			local var_216_5 = arg_213_1.actors_["10092"].transform

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos10092 = var_216_5.localPosition
				var_216_5.localScale = Vector3.New(1, 1, 1)

				arg_213_1:CheckSpriteTmpPos("10092", 4)

				for iter_216_8 = 0, var_216_5.childCount - 1 do
					local var_216_6 = var_216_5:GetChild(iter_216_8)

					if var_216_6.name == "split_2" or not string.find(var_216_6.name, "split") then
						var_216_6.gameObject:SetActive(true)
					else
						var_216_6.gameObject:SetActive(false)
					end
				end
			end

			local var_216_7 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 then
				var_216_5.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_213_1.time_ - 0) / var_216_7)
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 then
				var_216_5.localPosition = Vector3.New(390, -300, -295)
			end

			local var_216_8 = 0
			local var_216_9 = 0.675

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_10 = arg_213_1:GetWordFromCfg(413072050)
				local var_216_11 = arg_213_1:FormatText(var_216_10.content)

				arg_213_1.text_.text = var_216_11

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_13 = 27 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 27)

				if (27 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_11) / 27)) > 0 and var_216_9 < var_216_13 then
					arg_213_1.talkMaxDuration = var_216_13

					if var_216_13 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_13 + var_216_8
					end
				end

				arg_213_1.text_.text = var_216_11
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072050", "story_v_out_413072.awb") ~= 0 then
					local var_216_14 = manager.audio:GetVoiceLength("story_v_out_413072", "413072050", "story_v_out_413072.awb") / 1000

					if var_216_14 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_14 + var_216_8
					end

					if var_216_10.prefab_name ~= "" and arg_213_1.actors_[var_216_10.prefab_name] ~= nil then
						local var_216_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_10.prefab_name].transform, "story_v_out_413072", "413072050", "story_v_out_413072.awb")

						arg_213_1:RecordAudio("413072050", var_216_15)
						arg_213_1:RecordAudio("413072050", var_216_15)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_413072", "413072050", "story_v_out_413072.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_413072", "413072050", "story_v_out_413072.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_16 = math.max(var_216_9, arg_213_1.talkMaxDuration)

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_16 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_8) / var_216_16

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_8 + var_216_16 and arg_213_1.time_ < var_216_8 + var_216_16 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
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

		arg_213_1:InitPlayNodeList()
	end,
	Play413072051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 413072051
		arg_217_1.duration_ = 5.13

		local var_217_0 = {
			zh = 3.733,
			ja = 5.133
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
				arg_217_0:Play413072052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.525

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:GetWordFromCfg(413072051)
				local var_220_2 = arg_217_1:FormatText(var_220_1.content)

				arg_217_1.text_.text = var_220_2

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 21 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 21)

				if (21 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_2) / 21)) > 0 and var_220_0 < var_220_4 then
					arg_217_1.talkMaxDuration = var_220_4

					if var_220_4 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_4 + 0
					end
				end

				arg_217_1.text_.text = var_220_2
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072051", "story_v_out_413072.awb") ~= 0 then
					local var_220_5 = manager.audio:GetVoiceLength("story_v_out_413072", "413072051", "story_v_out_413072.awb") / 1000

					if var_220_5 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_5 + 0
					end

					if var_220_1.prefab_name ~= "" and arg_217_1.actors_[var_220_1.prefab_name] ~= nil then
						local var_220_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_1.prefab_name].transform, "story_v_out_413072", "413072051", "story_v_out_413072.awb")

						arg_217_1:RecordAudio("413072051", var_220_6)
						arg_217_1:RecordAudio("413072051", var_220_6)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_413072", "413072051", "story_v_out_413072.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_413072", "413072051", "story_v_out_413072.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_7 and arg_217_1.time_ < 0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play413072052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 413072052
		arg_221_1.duration_ = 4.33

		local var_221_0 = {
			zh = 4.333,
			ja = 2.5
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play413072053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos10093 = arg_221_1.actors_["10093"].transform.localPosition
				arg_221_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10093", 2)

				for iter_224_0 = 0, arg_221_1.actors_["10093"].transform.childCount - 1 do
					local var_224_0 = arg_221_1.actors_["10093"].transform:GetChild(iter_224_0)

					if var_224_0.name == "split_6" or not string.find(var_224_0.name, "split") then
						var_224_0.gameObject:SetActive(true)
					else
						var_224_0.gameObject:SetActive(false)
					end
				end
			end

			local var_224_1 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_1 then
				arg_221_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_221_1.time_ - 0) / var_224_1)
			end

			if arg_221_1.time_ >= 0 + var_224_1 and arg_221_1.time_ < 0 + var_224_1 + arg_224_0 then
				arg_221_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_224_2 = arg_221_1.actors_["10092"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps10092 == nil then
				arg_221_1.var_.actorSpriteComps10092 = var_224_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_3 = 2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_3 and not isNil(var_224_2) then
				if arg_221_1.var_.actorSpriteComps10092 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_224_2 then
							if arg_221_1.isInRecall_ then
								iter_224_2.color = Color.New(Mathf.Lerp(iter_224_2.color.r, arg_221_1.hightColor2.r, (arg_221_1.time_ - 0) / var_224_3), Mathf.Lerp(iter_224_2.color.g, arg_221_1.hightColor2.g, (arg_221_1.time_ - 0) / var_224_3), (Mathf.Lerp(iter_224_2.color.b, arg_221_1.hightColor2.b, (arg_221_1.time_ - 0) / var_224_3)))
							else
								local var_224_4 = Mathf.Lerp(iter_224_2.color.r, 0.5, (arg_221_1.time_ - 0) / var_224_3)

								iter_224_2.color = Color.New(var_224_4, var_224_4, var_224_4)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_3 and arg_221_1.time_ < 0 + var_224_3 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps10092 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_224_4 then
						iter_224_4.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_221_1.var_.actorSpriteComps10092 = nil
			end

			local var_224_5 = arg_221_1.actors_["10093"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_5) and arg_221_1.var_.actorSpriteComps10093 == nil then
				arg_221_1.var_.actorSpriteComps10093 = var_224_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_6 = 2

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_6 and not isNil(var_224_5) then
				if arg_221_1.var_.actorSpriteComps10093 then
					for iter_224_5, iter_224_6 in pairs(arg_221_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_224_6 then
							if arg_221_1.isInRecall_ then
								iter_224_6.color = Color.New(Mathf.Lerp(iter_224_6.color.r, arg_221_1.hightColor1.r, (arg_221_1.time_ - 0) / var_224_6), Mathf.Lerp(iter_224_6.color.g, arg_221_1.hightColor1.g, (arg_221_1.time_ - 0) / var_224_6), (Mathf.Lerp(iter_224_6.color.b, arg_221_1.hightColor1.b, (arg_221_1.time_ - 0) / var_224_6)))
							else
								local var_224_7 = Mathf.Lerp(iter_224_6.color.r, 1, (arg_221_1.time_ - 0) / var_224_6)

								iter_224_6.color = Color.New(var_224_7, var_224_7, var_224_7)
							end
						end
					end
				end
			end

			if arg_221_1.time_ >= 0 + var_224_6 and arg_221_1.time_ < 0 + var_224_6 + arg_224_0 and not isNil(var_224_5) and arg_221_1.var_.actorSpriteComps10093 then
				for iter_224_7, iter_224_8 in pairs(arg_221_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_224_8 then
						iter_224_8.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_221_1.var_.actorSpriteComps10093 = nil
			end

			local var_224_8 = 0
			local var_224_9 = 0.45

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_10 = arg_221_1:GetWordFromCfg(413072052)
				local var_224_11 = arg_221_1:FormatText(var_224_10.content)

				arg_221_1.text_.text = var_224_11

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_13 = 18 <= 0 and var_224_9 or var_224_9 * (utf8.len(var_224_11) / 18)

				if (18 <= 0 and var_224_9 or var_224_9 * (utf8.len(var_224_11) / 18)) > 0 and var_224_9 < var_224_13 then
					arg_221_1.talkMaxDuration = var_224_13

					if var_224_13 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_8
					end
				end

				arg_221_1.text_.text = var_224_11
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072052", "story_v_out_413072.awb") ~= 0 then
					local var_224_14 = manager.audio:GetVoiceLength("story_v_out_413072", "413072052", "story_v_out_413072.awb") / 1000

					if var_224_14 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_14 + var_224_8
					end

					if var_224_10.prefab_name ~= "" and arg_221_1.actors_[var_224_10.prefab_name] ~= nil then
						local var_224_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_10.prefab_name].transform, "story_v_out_413072", "413072052", "story_v_out_413072.awb")

						arg_221_1:RecordAudio("413072052", var_224_15)
						arg_221_1:RecordAudio("413072052", var_224_15)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_413072", "413072052", "story_v_out_413072.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_413072", "413072052", "story_v_out_413072.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_16 = math.max(var_224_9, arg_221_1.talkMaxDuration)

			if var_224_8 <= arg_221_1.time_ and arg_221_1.time_ < var_224_8 + var_224_16 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_8) / var_224_16

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_8 + var_224_16 and arg_221_1.time_ < var_224_8 + var_224_16 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
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

		arg_221_1:InitPlayNodeList()
	end,
	Play413072053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 413072053
		arg_225_1.duration_ = 7.57

		local var_225_0 = {
			zh = 5.9,
			ja = 7.566
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
				arg_225_0:Play413072054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10092 = arg_225_1.actors_["10092"].transform.localPosition
				arg_225_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10092", 7)

				for iter_228_0 = 0, arg_225_1.actors_["10092"].transform.childCount - 1 do
					local var_228_0 = arg_225_1.actors_["10092"].transform:GetChild(iter_228_0)

					if var_228_0.name == "" or not string.find(var_228_0.name, "split") then
						var_228_0.gameObject:SetActive(true)
					else
						var_228_0.gameObject:SetActive(false)
					end
				end
			end

			local var_228_1 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_1 then
				arg_225_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10092, Vector3.New(0, -2000, 0), (arg_225_1.time_ - 0) / var_228_1)
			end

			if arg_225_1.time_ >= 0 + var_228_1 and arg_225_1.time_ < 0 + var_228_1 + arg_228_0 then
				arg_225_1.actors_["10092"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_228_2 = arg_225_1.actors_["10093"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10093 = var_228_2.localPosition
				var_228_2.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10093", 0)

				for iter_228_1 = 0, var_228_2.childCount - 1 do
					local var_228_3 = var_228_2:GetChild(iter_228_1)

					if var_228_3.name == "" or not string.find(var_228_3.name, "split") then
						var_228_3.gameObject:SetActive(true)
					else
						var_228_3.gameObject:SetActive(false)
					end
				end
			end

			local var_228_4 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_4 then
				var_228_2.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10093, Vector3.New(-5000, -345, -245), (arg_225_1.time_ - 0) / var_228_4)
			end

			if arg_225_1.time_ >= 0 + var_228_4 and arg_225_1.time_ < 0 + var_228_4 + arg_228_0 then
				var_228_2.localPosition = Vector3.New(-5000, -345, -245)
			end

			local var_228_5 = "10094"

			if arg_225_1.actors_["10094"] == nil then
				local var_228_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10094")

				if not isNil(var_228_6) then
					local var_228_7 = Object.Instantiate(var_228_6, arg_225_1.canvasGo_.transform)

					var_228_7.transform:SetSiblingIndex(1)

					var_228_7.name = var_228_5
					var_228_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_225_1.actors_[var_228_5] = var_228_7

					if arg_225_1.isInRecall_ then
						for iter_228_2, iter_228_3 in ipairs((var_228_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_228_3.color = arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_228_8 = arg_225_1.actors_["10094"].transform

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos10094 = var_228_8.localPosition
				var_228_8.localScale = Vector3.New(1, 1, 1)

				arg_225_1:CheckSpriteTmpPos("10094", 3)

				for iter_228_4 = 0, var_228_8.childCount - 1 do
					local var_228_9 = var_228_8:GetChild(iter_228_4)

					if var_228_9.name == "split_1" or not string.find(var_228_9.name, "split") then
						var_228_9.gameObject:SetActive(true)
					else
						var_228_9.gameObject:SetActive(false)
					end
				end
			end

			local var_228_10 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_10 then
				var_228_8.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_225_1.time_ - 0) / var_228_10)
			end

			if arg_225_1.time_ >= 0 + var_228_10 and arg_225_1.time_ < 0 + var_228_10 + arg_228_0 then
				var_228_8.localPosition = Vector3.New(0, -340, -414)
			end

			local var_228_11 = arg_225_1.actors_["10092"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_11) and arg_225_1.var_.actorSpriteComps10092 == nil then
				arg_225_1.var_.actorSpriteComps10092 = var_228_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_12 = 2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_12 and not isNil(var_228_11) then
				if arg_225_1.var_.actorSpriteComps10092 then
					for iter_228_5, iter_228_6 in pairs(arg_225_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_228_6 then
							if arg_225_1.isInRecall_ then
								iter_228_6.color = Color.New(Mathf.Lerp(iter_228_6.color.r, arg_225_1.hightColor2.r, (arg_225_1.time_ - 0) / var_228_12), Mathf.Lerp(iter_228_6.color.g, arg_225_1.hightColor2.g, (arg_225_1.time_ - 0) / var_228_12), (Mathf.Lerp(iter_228_6.color.b, arg_225_1.hightColor2.b, (arg_225_1.time_ - 0) / var_228_12)))
							else
								local var_228_13 = Mathf.Lerp(iter_228_6.color.r, 0.5, (arg_225_1.time_ - 0) / var_228_12)

								iter_228_6.color = Color.New(var_228_13, var_228_13, var_228_13)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_12 and arg_225_1.time_ < 0 + var_228_12 + arg_228_0 and not isNil(var_228_11) and arg_225_1.var_.actorSpriteComps10092 then
				for iter_228_7, iter_228_8 in pairs(arg_225_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_228_8 then
						iter_228_8.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_225_1.var_.actorSpriteComps10092 = nil
			end

			local var_228_14 = arg_225_1.actors_["10093"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_14) and arg_225_1.var_.actorSpriteComps10093 == nil then
				arg_225_1.var_.actorSpriteComps10093 = var_228_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_15 = 2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_15 and not isNil(var_228_14) then
				if arg_225_1.var_.actorSpriteComps10093 then
					for iter_228_9, iter_228_10 in pairs(arg_225_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_228_10 then
							if arg_225_1.isInRecall_ then
								iter_228_10.color = Color.New(Mathf.Lerp(iter_228_10.color.r, arg_225_1.hightColor2.r, (arg_225_1.time_ - 0) / var_228_15), Mathf.Lerp(iter_228_10.color.g, arg_225_1.hightColor2.g, (arg_225_1.time_ - 0) / var_228_15), (Mathf.Lerp(iter_228_10.color.b, arg_225_1.hightColor2.b, (arg_225_1.time_ - 0) / var_228_15)))
							else
								local var_228_16 = Mathf.Lerp(iter_228_10.color.r, 0.5, (arg_225_1.time_ - 0) / var_228_15)

								iter_228_10.color = Color.New(var_228_16, var_228_16, var_228_16)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_15 and arg_225_1.time_ < 0 + var_228_15 + arg_228_0 and not isNil(var_228_14) and arg_225_1.var_.actorSpriteComps10093 then
				for iter_228_11, iter_228_12 in pairs(arg_225_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_228_12 then
						iter_228_12.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_225_1.var_.actorSpriteComps10093 = nil
			end

			local var_228_17 = arg_225_1.actors_["10094"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_17) and arg_225_1.var_.actorSpriteComps10094 == nil then
				arg_225_1.var_.actorSpriteComps10094 = var_228_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_18 = 2

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_18 and not isNil(var_228_17) then
				if arg_225_1.var_.actorSpriteComps10094 then
					for iter_228_13, iter_228_14 in pairs(arg_225_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_228_14 then
							if arg_225_1.isInRecall_ then
								iter_228_14.color = Color.New(Mathf.Lerp(iter_228_14.color.r, arg_225_1.hightColor1.r, (arg_225_1.time_ - 0) / var_228_18), Mathf.Lerp(iter_228_14.color.g, arg_225_1.hightColor1.g, (arg_225_1.time_ - 0) / var_228_18), (Mathf.Lerp(iter_228_14.color.b, arg_225_1.hightColor1.b, (arg_225_1.time_ - 0) / var_228_18)))
							else
								local var_228_19 = Mathf.Lerp(iter_228_14.color.r, 1, (arg_225_1.time_ - 0) / var_228_18)

								iter_228_14.color = Color.New(var_228_19, var_228_19, var_228_19)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_18 and arg_225_1.time_ < 0 + var_228_18 + arg_228_0 and not isNil(var_228_17) and arg_225_1.var_.actorSpriteComps10094 then
				for iter_228_15, iter_228_16 in pairs(arg_225_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_228_16 then
						iter_228_16.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_225_1.var_.actorSpriteComps10094 = nil
			end

			local var_228_20 = 0
			local var_228_21 = 0.575

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_20 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_22 = arg_225_1:GetWordFromCfg(413072053)
				local var_228_23 = arg_225_1:FormatText(var_228_22.content)

				arg_225_1.text_.text = var_228_23

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_25 = 23 <= 0 and var_228_21 or var_228_21 * (utf8.len(var_228_23) / 23)

				if (23 <= 0 and var_228_21 or var_228_21 * (utf8.len(var_228_23) / 23)) > 0 and var_228_21 < var_228_25 then
					arg_225_1.talkMaxDuration = var_228_25

					if var_228_25 + var_228_20 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_25 + var_228_20
					end
				end

				arg_225_1.text_.text = var_228_23
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072053", "story_v_out_413072.awb") ~= 0 then
					local var_228_26 = manager.audio:GetVoiceLength("story_v_out_413072", "413072053", "story_v_out_413072.awb") / 1000

					if var_228_26 + var_228_20 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_26 + var_228_20
					end

					if var_228_22.prefab_name ~= "" and arg_225_1.actors_[var_228_22.prefab_name] ~= nil then
						local var_228_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_22.prefab_name].transform, "story_v_out_413072", "413072053", "story_v_out_413072.awb")

						arg_225_1:RecordAudio("413072053", var_228_27)
						arg_225_1:RecordAudio("413072053", var_228_27)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_413072", "413072053", "story_v_out_413072.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_413072", "413072053", "story_v_out_413072.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_28 = math.max(var_228_21, arg_225_1.talkMaxDuration)

			if var_228_20 <= arg_225_1.time_ and arg_225_1.time_ < var_228_20 + var_228_28 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_20) / var_228_28

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_20 + var_228_28 and arg_225_1.time_ < var_228_20 + var_228_28 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
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
				actorName = "10094",
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
	Play413072054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 413072054
		arg_229_1.duration_ = 6.8

		local var_229_0 = {
			zh = 3.3,
			ja = 6.8
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
				arg_229_0:Play413072055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["10094"]) and arg_229_1.var_.actorSpriteComps10094 == nil then
				arg_229_1.var_.actorSpriteComps10094 = arg_229_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_0 = 2

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["10094"]) then
				if arg_229_1.var_.actorSpriteComps10094 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_232_1 then
							if arg_229_1.isInRecall_ then
								iter_232_1.color = Color.New(Mathf.Lerp(iter_232_1.color.r, arg_229_1.hightColor2.r, (arg_229_1.time_ - 0) / var_232_0), Mathf.Lerp(iter_232_1.color.g, arg_229_1.hightColor2.g, (arg_229_1.time_ - 0) / var_232_0), (Mathf.Lerp(iter_232_1.color.b, arg_229_1.hightColor2.b, (arg_229_1.time_ - 0) / var_232_0)))
							else
								local var_232_1 = Mathf.Lerp(iter_232_1.color.r, 0.5, (arg_229_1.time_ - 0) / var_232_0)

								iter_232_1.color = Color.New(var_232_1, var_232_1, var_232_1)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["10094"]) and arg_229_1.var_.actorSpriteComps10094 then
				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_232_3 then
						iter_232_3.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_229_1.var_.actorSpriteComps10094 = nil
			end

			local var_232_2 = 0
			local var_232_3 = 0.4

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[994].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_4 = arg_229_1:GetWordFromCfg(413072054)
				local var_232_5 = arg_229_1:FormatText(var_232_4.content)

				arg_229_1.text_.text = var_232_5

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_7 = 16 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 16)

				if (16 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_5) / 16)) > 0 and var_232_3 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_2
					end
				end

				arg_229_1.text_.text = var_232_5
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072054", "story_v_out_413072.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072054", "story_v_out_413072.awb") / 1000

					if var_232_8 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_2
					end

					if var_232_4.prefab_name ~= "" and arg_229_1.actors_[var_232_4.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_4.prefab_name].transform, "story_v_out_413072", "413072054", "story_v_out_413072.awb")

						arg_229_1:RecordAudio("413072054", var_232_9)
						arg_229_1:RecordAudio("413072054", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_413072", "413072054", "story_v_out_413072.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_413072", "413072054", "story_v_out_413072.awb")
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

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play413072055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 413072055
		arg_233_1.duration_ = 4.23

		local var_233_0 = {
			zh = 4.233,
			ja = 3.266
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play413072056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos10094 = arg_233_1.actors_["10094"].transform.localPosition
				arg_233_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10094", 7)

				for iter_236_0 = 0, arg_233_1.actors_["10094"].transform.childCount - 1 do
					local var_236_0 = arg_233_1.actors_["10094"].transform:GetChild(iter_236_0)

					if var_236_0.name == "" or not string.find(var_236_0.name, "split") then
						var_236_0.gameObject:SetActive(true)
					else
						var_236_0.gameObject:SetActive(false)
					end
				end
			end

			local var_236_1 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_1 then
				arg_233_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10094, Vector3.New(0, -2000, -180), (arg_233_1.time_ - 0) / var_236_1)
			end

			if arg_233_1.time_ >= 0 + var_236_1 and arg_233_1.time_ < 0 + var_236_1 + arg_236_0 then
				arg_233_1.actors_["10094"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_236_2 = arg_233_1.actors_["10093"].transform

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.var_.moveOldPos10093 = var_236_2.localPosition
				var_236_2.localScale = Vector3.New(1, 1, 1)

				arg_233_1:CheckSpriteTmpPos("10093", 3)

				for iter_236_1 = 0, var_236_2.childCount - 1 do
					local var_236_3 = var_236_2:GetChild(iter_236_1)

					if var_236_3.name == "split_4" or not string.find(var_236_3.name, "split") then
						var_236_3.gameObject:SetActive(true)
					else
						var_236_3.gameObject:SetActive(false)
					end
				end
			end

			local var_236_4 = 0.001

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				var_236_2.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_233_1.time_ - 0) / var_236_4)
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				var_236_2.localPosition = Vector3.New(0, -345, -245)
			end

			local var_236_5 = arg_233_1.actors_["10094"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.actorSpriteComps10094 == nil then
				arg_233_1.var_.actorSpriteComps10094 = var_236_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_6 = 2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_6 and not isNil(var_236_5) then
				if arg_233_1.var_.actorSpriteComps10094 then
					for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_236_3 then
							if arg_233_1.isInRecall_ then
								iter_236_3.color = Color.New(Mathf.Lerp(iter_236_3.color.r, arg_233_1.hightColor2.r, (arg_233_1.time_ - 0) / var_236_6), Mathf.Lerp(iter_236_3.color.g, arg_233_1.hightColor2.g, (arg_233_1.time_ - 0) / var_236_6), (Mathf.Lerp(iter_236_3.color.b, arg_233_1.hightColor2.b, (arg_233_1.time_ - 0) / var_236_6)))
							else
								local var_236_7 = Mathf.Lerp(iter_236_3.color.r, 0.5, (arg_233_1.time_ - 0) / var_236_6)

								iter_236_3.color = Color.New(var_236_7, var_236_7, var_236_7)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= 0 + var_236_6 and arg_233_1.time_ < 0 + var_236_6 + arg_236_0 and not isNil(var_236_5) and arg_233_1.var_.actorSpriteComps10094 then
				for iter_236_4, iter_236_5 in pairs(arg_233_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_236_5 then
						iter_236_5.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_233_1.var_.actorSpriteComps10094 = nil
			end

			local var_236_8 = arg_233_1.actors_["10093"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_8) and arg_233_1.var_.actorSpriteComps10093 == nil then
				arg_233_1.var_.actorSpriteComps10093 = var_236_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_9 = 2

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_9 and not isNil(var_236_8) then
				if arg_233_1.var_.actorSpriteComps10093 then
					for iter_236_6, iter_236_7 in pairs(arg_233_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_236_7 then
							if arg_233_1.isInRecall_ then
								iter_236_7.color = Color.New(Mathf.Lerp(iter_236_7.color.r, arg_233_1.hightColor1.r, (arg_233_1.time_ - 0) / var_236_9), Mathf.Lerp(iter_236_7.color.g, arg_233_1.hightColor1.g, (arg_233_1.time_ - 0) / var_236_9), (Mathf.Lerp(iter_236_7.color.b, arg_233_1.hightColor1.b, (arg_233_1.time_ - 0) / var_236_9)))
							else
								local var_236_10 = Mathf.Lerp(iter_236_7.color.r, 1, (arg_233_1.time_ - 0) / var_236_9)

								iter_236_7.color = Color.New(var_236_10, var_236_10, var_236_10)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= 0 + var_236_9 and arg_233_1.time_ < 0 + var_236_9 + arg_236_0 and not isNil(var_236_8) and arg_233_1.var_.actorSpriteComps10093 then
				for iter_236_8, iter_236_9 in pairs(arg_233_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_236_9 then
						iter_236_9.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_233_1.var_.actorSpriteComps10093 = nil
			end

			local var_236_11 = 0
			local var_236_12 = 0.45

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_11 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_13 = arg_233_1:GetWordFromCfg(413072055)
				local var_236_14 = arg_233_1:FormatText(var_236_13.content)

				arg_233_1.text_.text = var_236_14

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_16 = 18 <= 0 and var_236_12 or var_236_12 * (utf8.len(var_236_14) / 18)

				if (18 <= 0 and var_236_12 or var_236_12 * (utf8.len(var_236_14) / 18)) > 0 and var_236_12 < var_236_16 then
					arg_233_1.talkMaxDuration = var_236_16

					if var_236_16 + var_236_11 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_16 + var_236_11
					end
				end

				arg_233_1.text_.text = var_236_14
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072055", "story_v_out_413072.awb") ~= 0 then
					local var_236_17 = manager.audio:GetVoiceLength("story_v_out_413072", "413072055", "story_v_out_413072.awb") / 1000

					if var_236_17 + var_236_11 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_17 + var_236_11
					end

					if var_236_13.prefab_name ~= "" and arg_233_1.actors_[var_236_13.prefab_name] ~= nil then
						local var_236_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_13.prefab_name].transform, "story_v_out_413072", "413072055", "story_v_out_413072.awb")

						arg_233_1:RecordAudio("413072055", var_236_18)
						arg_233_1:RecordAudio("413072055", var_236_18)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_413072", "413072055", "story_v_out_413072.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_413072", "413072055", "story_v_out_413072.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_19 = math.max(var_236_12, arg_233_1.talkMaxDuration)

			if var_236_11 <= arg_233_1.time_ and arg_233_1.time_ < var_236_11 + var_236_19 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_11) / var_236_19

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_11 + var_236_19 and arg_233_1.time_ < var_236_11 + var_236_19 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
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
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play413072056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 413072056
		arg_237_1.duration_ = 6.73

		local var_237_0 = {
			zh = 4.366,
			ja = 6.733
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play413072057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos10093 = arg_237_1.actors_["10093"].transform.localPosition
				arg_237_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10093", 7)

				for iter_240_0 = 0, arg_237_1.actors_["10093"].transform.childCount - 1 do
					local var_240_0 = arg_237_1.actors_["10093"].transform:GetChild(iter_240_0)

					if var_240_0.name == "" or not string.find(var_240_0.name, "split") then
						var_240_0.gameObject:SetActive(true)
					else
						var_240_0.gameObject:SetActive(false)
					end
				end
			end

			local var_240_1 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_1 then
				arg_237_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_237_1.time_ - 0) / var_240_1)
			end

			if arg_237_1.time_ >= 0 + var_240_1 and arg_237_1.time_ < 0 + var_240_1 + arg_240_0 then
				arg_237_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_240_2 = arg_237_1.actors_["10093"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.actorSpriteComps10093 == nil then
				arg_237_1.var_.actorSpriteComps10093 = var_240_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_3 = 2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_3 and not isNil(var_240_2) then
				if arg_237_1.var_.actorSpriteComps10093 then
					for iter_240_1, iter_240_2 in pairs(arg_237_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_240_2 then
							if arg_237_1.isInRecall_ then
								iter_240_2.color = Color.New(Mathf.Lerp(iter_240_2.color.r, arg_237_1.hightColor2.r, (arg_237_1.time_ - 0) / var_240_3), Mathf.Lerp(iter_240_2.color.g, arg_237_1.hightColor2.g, (arg_237_1.time_ - 0) / var_240_3), (Mathf.Lerp(iter_240_2.color.b, arg_237_1.hightColor2.b, (arg_237_1.time_ - 0) / var_240_3)))
							else
								local var_240_4 = Mathf.Lerp(iter_240_2.color.r, 0.5, (arg_237_1.time_ - 0) / var_240_3)

								iter_240_2.color = Color.New(var_240_4, var_240_4, var_240_4)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_3 and arg_237_1.time_ < 0 + var_240_3 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.actorSpriteComps10093 then
				for iter_240_3, iter_240_4 in pairs(arg_237_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_240_4 then
						iter_240_4.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_237_1.var_.actorSpriteComps10093 = nil
			end

			local var_240_5 = arg_237_1.actors_["10094"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.actorSpriteComps10094 == nil then
				arg_237_1.var_.actorSpriteComps10094 = var_240_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_6 = 2

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_6 and not isNil(var_240_5) then
				if arg_237_1.var_.actorSpriteComps10094 then
					for iter_240_5, iter_240_6 in pairs(arg_237_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_240_6 then
							if arg_237_1.isInRecall_ then
								iter_240_6.color = Color.New(Mathf.Lerp(iter_240_6.color.r, arg_237_1.hightColor1.r, (arg_237_1.time_ - 0) / var_240_6), Mathf.Lerp(iter_240_6.color.g, arg_237_1.hightColor1.g, (arg_237_1.time_ - 0) / var_240_6), (Mathf.Lerp(iter_240_6.color.b, arg_237_1.hightColor1.b, (arg_237_1.time_ - 0) / var_240_6)))
							else
								local var_240_7 = Mathf.Lerp(iter_240_6.color.r, 1, (arg_237_1.time_ - 0) / var_240_6)

								iter_240_6.color = Color.New(var_240_7, var_240_7, var_240_7)
							end
						end
					end
				end
			end

			if arg_237_1.time_ >= 0 + var_240_6 and arg_237_1.time_ < 0 + var_240_6 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.actorSpriteComps10094 then
				for iter_240_7, iter_240_8 in pairs(arg_237_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_240_8 then
						iter_240_8.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_237_1.var_.actorSpriteComps10094 = nil
			end

			local var_240_8 = arg_237_1.actors_["10094"].transform

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos10094 = var_240_8.localPosition
				var_240_8.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10094", 3)

				for iter_240_9 = 0, var_240_8.childCount - 1 do
					local var_240_9 = var_240_8:GetChild(iter_240_9)

					if var_240_9.name == "" or not string.find(var_240_9.name, "split") then
						var_240_9.gameObject:SetActive(true)
					else
						var_240_9.gameObject:SetActive(false)
					end
				end
			end

			local var_240_10 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_10 then
				var_240_8.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10094, Vector3.New(0, -340, -414), (arg_237_1.time_ - 0) / var_240_10)
			end

			if arg_237_1.time_ >= 0 + var_240_10 and arg_237_1.time_ < 0 + var_240_10 + arg_240_0 then
				var_240_8.localPosition = Vector3.New(0, -340, -414)
			end

			local var_240_11 = 0
			local var_240_12 = 0.55

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_11 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_13 = arg_237_1:GetWordFromCfg(413072056)
				local var_240_14 = arg_237_1:FormatText(var_240_13.content)

				arg_237_1.text_.text = var_240_14

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_16 = 22 <= 0 and var_240_12 or var_240_12 * (utf8.len(var_240_14) / 22)

				if (22 <= 0 and var_240_12 or var_240_12 * (utf8.len(var_240_14) / 22)) > 0 and var_240_12 < var_240_16 then
					arg_237_1.talkMaxDuration = var_240_16

					if var_240_16 + var_240_11 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_16 + var_240_11
					end
				end

				arg_237_1.text_.text = var_240_14
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072056", "story_v_out_413072.awb") ~= 0 then
					local var_240_17 = manager.audio:GetVoiceLength("story_v_out_413072", "413072056", "story_v_out_413072.awb") / 1000

					if var_240_17 + var_240_11 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_17 + var_240_11
					end

					if var_240_13.prefab_name ~= "" and arg_237_1.actors_[var_240_13.prefab_name] ~= nil then
						local var_240_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_13.prefab_name].transform, "story_v_out_413072", "413072056", "story_v_out_413072.awb")

						arg_237_1:RecordAudio("413072056", var_240_18)
						arg_237_1:RecordAudio("413072056", var_240_18)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_413072", "413072056", "story_v_out_413072.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_413072", "413072056", "story_v_out_413072.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_19 = math.max(var_240_12, arg_237_1.talkMaxDuration)

			if var_240_11 <= arg_237_1.time_ and arg_237_1.time_ < var_240_11 + var_240_19 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_11) / var_240_19

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_11 + var_240_19 and arg_237_1.time_ < var_240_11 + var_240_19 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
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
				actorName = "10094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play413072057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 413072057
		arg_241_1.duration_ = 3.87

		local var_241_0 = {
			zh = 1.933,
			ja = 3.866
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play413072058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0.275

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_1 = arg_241_1:GetWordFromCfg(413072057)
				local var_244_2 = arg_241_1:FormatText(var_244_1.content)

				arg_241_1.text_.text = var_244_2

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_4 = 11 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 11)

				if (11 <= 0 and var_244_0 or var_244_0 * (utf8.len(var_244_2) / 11)) > 0 and var_244_0 < var_244_4 then
					arg_241_1.talkMaxDuration = var_244_4

					if var_244_4 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_4 + 0
					end
				end

				arg_241_1.text_.text = var_244_2
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072057", "story_v_out_413072.awb") ~= 0 then
					local var_244_5 = manager.audio:GetVoiceLength("story_v_out_413072", "413072057", "story_v_out_413072.awb") / 1000

					if var_244_5 + 0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_5 + 0
					end

					if var_244_1.prefab_name ~= "" and arg_241_1.actors_[var_244_1.prefab_name] ~= nil then
						local var_244_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_1.prefab_name].transform, "story_v_out_413072", "413072057", "story_v_out_413072.awb")

						arg_241_1:RecordAudio("413072057", var_244_6)
						arg_241_1:RecordAudio("413072057", var_244_6)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_413072", "413072057", "story_v_out_413072.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_413072", "413072057", "story_v_out_413072.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_7 = math.max(var_244_0, arg_241_1.talkMaxDuration)

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_7 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - 0) / var_244_7

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= 0 + var_244_7 and arg_241_1.time_ < 0 + var_244_7 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play413072058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 413072058
		arg_245_1.duration_ = 5.7

		local var_245_0 = {
			zh = 3.866,
			ja = 5.7
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play413072059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["10094"]) and arg_245_1.var_.actorSpriteComps10094 == nil then
				arg_245_1.var_.actorSpriteComps10094 = arg_245_1.actors_["10094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_248_0 = 2

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["10094"]) then
				if arg_245_1.var_.actorSpriteComps10094 then
					for iter_248_0, iter_248_1 in pairs(arg_245_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_248_1 then
							if arg_245_1.isInRecall_ then
								iter_248_1.color = Color.New(Mathf.Lerp(iter_248_1.color.r, arg_245_1.hightColor2.r, (arg_245_1.time_ - 0) / var_248_0), Mathf.Lerp(iter_248_1.color.g, arg_245_1.hightColor2.g, (arg_245_1.time_ - 0) / var_248_0), (Mathf.Lerp(iter_248_1.color.b, arg_245_1.hightColor2.b, (arg_245_1.time_ - 0) / var_248_0)))
							else
								local var_248_1 = Mathf.Lerp(iter_248_1.color.r, 0.5, (arg_245_1.time_ - 0) / var_248_0)

								iter_248_1.color = Color.New(var_248_1, var_248_1, var_248_1)
							end
						end
					end
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["10094"]) and arg_245_1.var_.actorSpriteComps10094 then
				for iter_248_2, iter_248_3 in pairs(arg_245_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_248_3 then
						iter_248_3.color = arg_245_1.isInRecall_ and (arg_245_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_245_1.var_.actorSpriteComps10094 = nil
			end

			local var_248_2 = 0
			local var_248_3 = 0.45

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_2 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[998].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightwoman1")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_4 = arg_245_1:GetWordFromCfg(413072058)
				local var_248_5 = arg_245_1:FormatText(var_248_4.content)

				arg_245_1.text_.text = var_248_5

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_7 = 18 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_5) / 18)

				if (18 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_5) / 18)) > 0 and var_248_3 < var_248_7 then
					arg_245_1.talkMaxDuration = var_248_7

					if var_248_7 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_2
					end
				end

				arg_245_1.text_.text = var_248_5
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072058", "story_v_out_413072.awb") ~= 0 then
					local var_248_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072058", "story_v_out_413072.awb") / 1000

					if var_248_8 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_8 + var_248_2
					end

					if var_248_4.prefab_name ~= "" and arg_245_1.actors_[var_248_4.prefab_name] ~= nil then
						local var_248_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_4.prefab_name].transform, "story_v_out_413072", "413072058", "story_v_out_413072.awb")

						arg_245_1:RecordAudio("413072058", var_248_9)
						arg_245_1:RecordAudio("413072058", var_248_9)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_413072", "413072058", "story_v_out_413072.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_413072", "413072058", "story_v_out_413072.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_10 = math.max(var_248_3, arg_245_1.talkMaxDuration)

			if var_248_2 <= arg_245_1.time_ and arg_245_1.time_ < var_248_2 + var_248_10 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_2) / var_248_10

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_2 + var_248_10 and arg_245_1.time_ < var_248_2 + var_248_10 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play413072059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 413072059
		arg_249_1.duration_ = 10.93

		local var_249_0 = {
			zh = 4.933,
			ja = 10.933
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play413072060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos10094 = arg_249_1.actors_["10094"].transform.localPosition
				arg_249_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10094", 7)

				for iter_252_0 = 0, arg_249_1.actors_["10094"].transform.childCount - 1 do
					local var_252_0 = arg_249_1.actors_["10094"].transform:GetChild(iter_252_0)

					if var_252_0.name == "" or not string.find(var_252_0.name, "split") then
						var_252_0.gameObject:SetActive(true)
					else
						var_252_0.gameObject:SetActive(false)
					end
				end
			end

			local var_252_1 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_1 then
				arg_249_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10094, Vector3.New(0, -2000, -180), (arg_249_1.time_ - 0) / var_252_1)
			end

			if arg_249_1.time_ >= 0 + var_252_1 and arg_249_1.time_ < 0 + var_252_1 + arg_252_0 then
				arg_249_1.actors_["10094"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_252_2 = arg_249_1.actors_["10092"].transform

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos10092 = var_252_2.localPosition
				var_252_2.localScale = Vector3.New(1, 1, 1)

				arg_249_1:CheckSpriteTmpPos("10092", 3)

				for iter_252_1 = 0, var_252_2.childCount - 1 do
					local var_252_3 = var_252_2:GetChild(iter_252_1)

					if var_252_3.name == "" or not string.find(var_252_3.name, "split") then
						var_252_3.gameObject:SetActive(true)
					else
						var_252_3.gameObject:SetActive(false)
					end
				end
			end

			local var_252_4 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_4 then
				var_252_2.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_249_1.time_ - 0) / var_252_4)
			end

			if arg_249_1.time_ >= 0 + var_252_4 and arg_249_1.time_ < 0 + var_252_4 + arg_252_0 then
				var_252_2.localPosition = Vector3.New(0, -300, -295)
			end

			local var_252_5 = arg_249_1.actors_["10094"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.actorSpriteComps10094 == nil then
				arg_249_1.var_.actorSpriteComps10094 = var_252_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_6 = 2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_6 and not isNil(var_252_5) then
				if arg_249_1.var_.actorSpriteComps10094 then
					for iter_252_2, iter_252_3 in pairs(arg_249_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_252_3 then
							if arg_249_1.isInRecall_ then
								iter_252_3.color = Color.New(Mathf.Lerp(iter_252_3.color.r, arg_249_1.hightColor2.r, (arg_249_1.time_ - 0) / var_252_6), Mathf.Lerp(iter_252_3.color.g, arg_249_1.hightColor2.g, (arg_249_1.time_ - 0) / var_252_6), (Mathf.Lerp(iter_252_3.color.b, arg_249_1.hightColor2.b, (arg_249_1.time_ - 0) / var_252_6)))
							else
								local var_252_7 = Mathf.Lerp(iter_252_3.color.r, 0.5, (arg_249_1.time_ - 0) / var_252_6)

								iter_252_3.color = Color.New(var_252_7, var_252_7, var_252_7)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_6 and arg_249_1.time_ < 0 + var_252_6 + arg_252_0 and not isNil(var_252_5) and arg_249_1.var_.actorSpriteComps10094 then
				for iter_252_4, iter_252_5 in pairs(arg_249_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_252_5 then
						iter_252_5.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_249_1.var_.actorSpriteComps10094 = nil
			end

			local var_252_8 = arg_249_1.actors_["10092"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_8) and arg_249_1.var_.actorSpriteComps10092 == nil then
				arg_249_1.var_.actorSpriteComps10092 = var_252_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_252_9 = 2

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_9 and not isNil(var_252_8) then
				if arg_249_1.var_.actorSpriteComps10092 then
					for iter_252_6, iter_252_7 in pairs(arg_249_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_252_7 then
							if arg_249_1.isInRecall_ then
								iter_252_7.color = Color.New(Mathf.Lerp(iter_252_7.color.r, arg_249_1.hightColor1.r, (arg_249_1.time_ - 0) / var_252_9), Mathf.Lerp(iter_252_7.color.g, arg_249_1.hightColor1.g, (arg_249_1.time_ - 0) / var_252_9), (Mathf.Lerp(iter_252_7.color.b, arg_249_1.hightColor1.b, (arg_249_1.time_ - 0) / var_252_9)))
							else
								local var_252_10 = Mathf.Lerp(iter_252_7.color.r, 1, (arg_249_1.time_ - 0) / var_252_9)

								iter_252_7.color = Color.New(var_252_10, var_252_10, var_252_10)
							end
						end
					end
				end
			end

			if arg_249_1.time_ >= 0 + var_252_9 and arg_249_1.time_ < 0 + var_252_9 + arg_252_0 and not isNil(var_252_8) and arg_249_1.var_.actorSpriteComps10092 then
				for iter_252_8, iter_252_9 in pairs(arg_249_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_252_9 then
						iter_252_9.color = arg_249_1.isInRecall_ and (arg_249_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_249_1.var_.actorSpriteComps10092 = nil
			end

			local var_252_11 = 0
			local var_252_12 = 0.75

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_11 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_13 = arg_249_1:GetWordFromCfg(413072059)
				local var_252_14 = arg_249_1:FormatText(var_252_13.content)

				arg_249_1.text_.text = var_252_14

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_16 = 30 <= 0 and var_252_12 or var_252_12 * (utf8.len(var_252_14) / 30)

				if (30 <= 0 and var_252_12 or var_252_12 * (utf8.len(var_252_14) / 30)) > 0 and var_252_12 < var_252_16 then
					arg_249_1.talkMaxDuration = var_252_16

					if var_252_16 + var_252_11 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_16 + var_252_11
					end
				end

				arg_249_1.text_.text = var_252_14
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072059", "story_v_out_413072.awb") ~= 0 then
					local var_252_17 = manager.audio:GetVoiceLength("story_v_out_413072", "413072059", "story_v_out_413072.awb") / 1000

					if var_252_17 + var_252_11 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_17 + var_252_11
					end

					if var_252_13.prefab_name ~= "" and arg_249_1.actors_[var_252_13.prefab_name] ~= nil then
						local var_252_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_13.prefab_name].transform, "story_v_out_413072", "413072059", "story_v_out_413072.awb")

						arg_249_1:RecordAudio("413072059", var_252_18)
						arg_249_1:RecordAudio("413072059", var_252_18)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_413072", "413072059", "story_v_out_413072.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_413072", "413072059", "story_v_out_413072.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_19 = math.max(var_252_12, arg_249_1.talkMaxDuration)

			if var_252_11 <= arg_249_1.time_ and arg_249_1.time_ < var_252_11 + var_252_19 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_11) / var_252_19

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_11 + var_252_19 and arg_249_1.time_ < var_252_11 + var_252_19 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_249_1:InitPlayNodeList()
	end,
	Play413072060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 413072060
		arg_253_1.duration_ = 6.2

		local var_253_0 = {
			zh = 4.9,
			ja = 6.2
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play413072061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0.625

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:GetWordFromCfg(413072060)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 25 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 25)

				if (25 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 25)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072060", "story_v_out_413072.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_out_413072", "413072060", "story_v_out_413072.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_out_413072", "413072060", "story_v_out_413072.awb")

						arg_253_1:RecordAudio("413072060", var_256_6)
						arg_253_1:RecordAudio("413072060", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_413072", "413072060", "story_v_out_413072.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_413072", "413072060", "story_v_out_413072.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play413072061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 413072061
		arg_257_1.duration_ = 7.57

		local var_257_0 = {
			zh = 5.633,
			ja = 7.566
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play413072062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.var_.moveOldPos10092 = arg_257_1.actors_["10092"].transform.localPosition
				arg_257_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_257_1:CheckSpriteTmpPos("10092", 3)

				for iter_260_0 = 0, arg_257_1.actors_["10092"].transform.childCount - 1 do
					local var_260_0 = arg_257_1.actors_["10092"].transform:GetChild(iter_260_0)

					if var_260_0.name == "split_2" or not string.find(var_260_0.name, "split") then
						var_260_0.gameObject:SetActive(true)
					else
						var_260_0.gameObject:SetActive(false)
					end
				end
			end

			local var_260_1 = 0.001

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_1 then
				arg_257_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_257_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_257_1.time_ - 0) / var_260_1)
			end

			if arg_257_1.time_ >= 0 + var_260_1 and arg_257_1.time_ < 0 + var_260_1 + arg_260_0 then
				arg_257_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_260_2 = 0
			local var_260_3 = 0.775

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_4 = arg_257_1:GetWordFromCfg(413072061)
				local var_260_5 = arg_257_1:FormatText(var_260_4.content)

				arg_257_1.text_.text = var_260_5

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_7 = 31 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_5) / 31)

				if (31 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_5) / 31)) > 0 and var_260_3 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_2
					end
				end

				arg_257_1.text_.text = var_260_5
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072061", "story_v_out_413072.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_413072", "413072061", "story_v_out_413072.awb") / 1000

					if var_260_8 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_2
					end

					if var_260_4.prefab_name ~= "" and arg_257_1.actors_[var_260_4.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_4.prefab_name].transform, "story_v_out_413072", "413072061", "story_v_out_413072.awb")

						arg_257_1:RecordAudio("413072061", var_260_9)
						arg_257_1:RecordAudio("413072061", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_413072", "413072061", "story_v_out_413072.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_413072", "413072061", "story_v_out_413072.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = math.max(var_260_3, arg_257_1.talkMaxDuration)

			if var_260_2 <= arg_257_1.time_ and arg_257_1.time_ < var_260_2 + var_260_10 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_2) / var_260_10

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_2 + var_260_10 and arg_257_1.time_ < var_260_2 + var_260_10 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {
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

		arg_257_1:InitPlayNodeList()
	end,
	Play413072062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 413072062
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play413072063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos10092 = arg_261_1.actors_["10092"].transform.localPosition
				arg_261_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10092", 0)

				for iter_264_0 = 0, arg_261_1.actors_["10092"].transform.childCount - 1 do
					local var_264_0 = arg_261_1.actors_["10092"].transform:GetChild(iter_264_0)

					if var_264_0.name == "" or not string.find(var_264_0.name, "split") then
						var_264_0.gameObject:SetActive(true)
					else
						var_264_0.gameObject:SetActive(false)
					end
				end
			end

			local var_264_1 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_1 then
				arg_261_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10092, Vector3.New(-5000, -315, -320), (arg_261_1.time_ - 0) / var_264_1)
			end

			if arg_261_1.time_ >= 0 + var_264_1 and arg_261_1.time_ < 0 + var_264_1 + arg_264_0 then
				arg_261_1.actors_["10092"].transform.localPosition = Vector3.New(-5000, -315, -320)
			end

			local var_264_2 = arg_261_1.actors_["10092"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps10092 == nil then
				arg_261_1.var_.actorSpriteComps10092 = var_264_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_3 = 2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 and not isNil(var_264_2) then
				if arg_261_1.var_.actorSpriteComps10092 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_264_2 then
							if arg_261_1.isInRecall_ then
								iter_264_2.color = Color.New(Mathf.Lerp(iter_264_2.color.r, arg_261_1.hightColor2.r, (arg_261_1.time_ - 0) / var_264_3), Mathf.Lerp(iter_264_2.color.g, arg_261_1.hightColor2.g, (arg_261_1.time_ - 0) / var_264_3), (Mathf.Lerp(iter_264_2.color.b, arg_261_1.hightColor2.b, (arg_261_1.time_ - 0) / var_264_3)))
							else
								local var_264_4 = Mathf.Lerp(iter_264_2.color.r, 0.5, (arg_261_1.time_ - 0) / var_264_3)

								iter_264_2.color = Color.New(var_264_4, var_264_4, var_264_4)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps10092 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_264_4 then
						iter_264_4.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_261_1.var_.actorSpriteComps10092 = nil
			end

			local var_264_5 = 0
			local var_264_6 = 1.7

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_7 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(413072062).content)

				arg_261_1.text_.text = var_264_7

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_9 = 68 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_7) / 68)

				if (68 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_7) / 68)) > 0 and var_264_6 < var_264_9 then
					arg_261_1.talkMaxDuration = var_264_9

					if var_264_9 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_9 + var_264_5
					end
				end

				arg_261_1.text_.text = var_264_7
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_10 = math.max(var_264_6, arg_261_1.talkMaxDuration)

			if var_264_5 <= arg_261_1.time_ and arg_261_1.time_ < var_264_5 + var_264_10 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_5) / var_264_10

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_5 + var_264_10 and arg_261_1.time_ < var_264_5 + var_264_10 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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

		arg_261_1:InitPlayNodeList()
	end,
	Play413072063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 413072063
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play413072064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 1.425

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_1 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(413072063).content)

				arg_265_1.text_.text = var_268_1

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_3 = 57 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 57)

				if (57 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_1) / 57)) > 0 and var_268_0 < var_268_3 then
					arg_265_1.talkMaxDuration = var_268_3

					if var_268_3 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_3 + 0
					end
				end

				arg_265_1.text_.text = var_268_1
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_4 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_4 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_4

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_4 and arg_265_1.time_ < 0 + var_268_4 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play413072064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 413072064
		arg_269_1.duration_ = 12.27

		local var_269_0 = {
			zh = 6.066,
			ja = 12.266
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
				arg_269_0:Play413072065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.var_.moveOldPos10092 = arg_269_1.actors_["10092"].transform.localPosition
				arg_269_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_269_1:CheckSpriteTmpPos("10092", 4)

				for iter_272_0 = 0, arg_269_1.actors_["10092"].transform.childCount - 1 do
					local var_272_0 = arg_269_1.actors_["10092"].transform:GetChild(iter_272_0)

					if var_272_0.name == "split_1_1" or not string.find(var_272_0.name, "split") then
						var_272_0.gameObject:SetActive(true)
					else
						var_272_0.gameObject:SetActive(false)
					end
				end
			end

			local var_272_1 = 0.001

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_1 then
				arg_269_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos10092, Vector3.New(390, -300, -295), (arg_269_1.time_ - 0) / var_272_1)
			end

			if arg_269_1.time_ >= 0 + var_272_1 and arg_269_1.time_ < 0 + var_272_1 + arg_272_0 then
				arg_269_1.actors_["10092"].transform.localPosition = Vector3.New(390, -300, -295)
			end

			local var_272_2 = arg_269_1.actors_["10092"]

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps10092 == nil then
				arg_269_1.var_.actorSpriteComps10092 = var_272_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_3 = 2

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_3 and not isNil(var_272_2) then
				if arg_269_1.var_.actorSpriteComps10092 then
					for iter_272_1, iter_272_2 in pairs(arg_269_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_272_2 then
							if arg_269_1.isInRecall_ then
								iter_272_2.color = Color.New(Mathf.Lerp(iter_272_2.color.r, arg_269_1.hightColor1.r, (arg_269_1.time_ - 0) / var_272_3), Mathf.Lerp(iter_272_2.color.g, arg_269_1.hightColor1.g, (arg_269_1.time_ - 0) / var_272_3), (Mathf.Lerp(iter_272_2.color.b, arg_269_1.hightColor1.b, (arg_269_1.time_ - 0) / var_272_3)))
							else
								local var_272_4 = Mathf.Lerp(iter_272_2.color.r, 1, (arg_269_1.time_ - 0) / var_272_3)

								iter_272_2.color = Color.New(var_272_4, var_272_4, var_272_4)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_3 and arg_269_1.time_ < 0 + var_272_3 + arg_272_0 and not isNil(var_272_2) and arg_269_1.var_.actorSpriteComps10092 then
				for iter_272_3, iter_272_4 in pairs(arg_269_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_272_4 then
						iter_272_4.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_269_1.var_.actorSpriteComps10092 = nil
			end

			local var_272_5 = 0
			local var_272_6 = 0.775

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_5 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_7 = arg_269_1:GetWordFromCfg(413072064)
				local var_272_8 = arg_269_1:FormatText(var_272_7.content)

				arg_269_1.text_.text = var_272_8

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_10 = 31 <= 0 and var_272_6 or var_272_6 * (utf8.len(var_272_8) / 31)

				if (31 <= 0 and var_272_6 or var_272_6 * (utf8.len(var_272_8) / 31)) > 0 and var_272_6 < var_272_10 then
					arg_269_1.talkMaxDuration = var_272_10

					if var_272_10 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_10 + var_272_5
					end
				end

				arg_269_1.text_.text = var_272_8
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072064", "story_v_out_413072.awb") ~= 0 then
					local var_272_11 = manager.audio:GetVoiceLength("story_v_out_413072", "413072064", "story_v_out_413072.awb") / 1000

					if var_272_11 + var_272_5 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_11 + var_272_5
					end

					if var_272_7.prefab_name ~= "" and arg_269_1.actors_[var_272_7.prefab_name] ~= nil then
						local var_272_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_7.prefab_name].transform, "story_v_out_413072", "413072064", "story_v_out_413072.awb")

						arg_269_1:RecordAudio("413072064", var_272_12)
						arg_269_1:RecordAudio("413072064", var_272_12)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_413072", "413072064", "story_v_out_413072.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_413072", "413072064", "story_v_out_413072.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_13 = math.max(var_272_6, arg_269_1.talkMaxDuration)

			if var_272_5 <= arg_269_1.time_ and arg_269_1.time_ < var_272_5 + var_272_13 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_5) / var_272_13

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_5 + var_272_13 and arg_269_1.time_ < var_272_5 + var_272_13 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
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

		arg_269_1:InitPlayNodeList()
	end,
	Play413072065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 413072065
		arg_273_1.duration_ = 2.83

		local var_273_0 = {
			zh = 2.266,
			ja = 2.833
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
				arg_273_0:Play413072066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10094 = arg_273_1.actors_["10094"].transform.localPosition
				arg_273_1.actors_["10094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("10094", 2)

				for iter_276_0 = 0, arg_273_1.actors_["10094"].transform.childCount - 1 do
					local var_276_0 = arg_273_1.actors_["10094"].transform:GetChild(iter_276_0)

					if var_276_0.name == "" or not string.find(var_276_0.name, "split") then
						var_276_0.gameObject:SetActive(true)
					else
						var_276_0.gameObject:SetActive(false)
					end
				end
			end

			local var_276_1 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_1 then
				arg_273_1.actors_["10094"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10094, Vector3.New(-390, -340, -414), (arg_273_1.time_ - 0) / var_276_1)
			end

			if arg_273_1.time_ >= 0 + var_276_1 and arg_273_1.time_ < 0 + var_276_1 + arg_276_0 then
				arg_273_1.actors_["10094"].transform.localPosition = Vector3.New(-390, -340, -414)
			end

			local var_276_2 = arg_273_1.actors_["10092"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps10092 == nil then
				arg_273_1.var_.actorSpriteComps10092 = var_276_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_3 = 2

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_3 and not isNil(var_276_2) then
				if arg_273_1.var_.actorSpriteComps10092 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps10092:ToTable()) do
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

			if arg_273_1.time_ >= 0 + var_276_3 and arg_273_1.time_ < 0 + var_276_3 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps10092 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_276_4 then
						iter_276_4.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_273_1.var_.actorSpriteComps10092 = nil
			end

			local var_276_5 = arg_273_1.actors_["10094"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_5) and arg_273_1.var_.actorSpriteComps10094 == nil then
				arg_273_1.var_.actorSpriteComps10094 = var_276_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_6 = 2

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_6 and not isNil(var_276_5) then
				if arg_273_1.var_.actorSpriteComps10094 then
					for iter_276_5, iter_276_6 in pairs(arg_273_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_276_6 then
							if arg_273_1.isInRecall_ then
								iter_276_6.color = Color.New(Mathf.Lerp(iter_276_6.color.r, arg_273_1.hightColor1.r, (arg_273_1.time_ - 0) / var_276_6), Mathf.Lerp(iter_276_6.color.g, arg_273_1.hightColor1.g, (arg_273_1.time_ - 0) / var_276_6), (Mathf.Lerp(iter_276_6.color.b, arg_273_1.hightColor1.b, (arg_273_1.time_ - 0) / var_276_6)))
							else
								local var_276_7 = Mathf.Lerp(iter_276_6.color.r, 1, (arg_273_1.time_ - 0) / var_276_6)

								iter_276_6.color = Color.New(var_276_7, var_276_7, var_276_7)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= 0 + var_276_6 and arg_273_1.time_ < 0 + var_276_6 + arg_276_0 and not isNil(var_276_5) and arg_273_1.var_.actorSpriteComps10094 then
				for iter_276_7, iter_276_8 in pairs(arg_273_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_276_8 then
						iter_276_8.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_273_1.var_.actorSpriteComps10094 = nil
			end

			local var_276_8 = 0
			local var_276_9 = 0.275

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_8 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[259].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_10 = arg_273_1:GetWordFromCfg(413072065)
				local var_276_11 = arg_273_1:FormatText(var_276_10.content)

				arg_273_1.text_.text = var_276_11

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_13 = 11 <= 0 and var_276_9 or var_276_9 * (utf8.len(var_276_11) / 11)

				if (11 <= 0 and var_276_9 or var_276_9 * (utf8.len(var_276_11) / 11)) > 0 and var_276_9 < var_276_13 then
					arg_273_1.talkMaxDuration = var_276_13

					if var_276_13 + var_276_8 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_13 + var_276_8
					end
				end

				arg_273_1.text_.text = var_276_11
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072065", "story_v_out_413072.awb") ~= 0 then
					local var_276_14 = manager.audio:GetVoiceLength("story_v_out_413072", "413072065", "story_v_out_413072.awb") / 1000

					if var_276_14 + var_276_8 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_14 + var_276_8
					end

					if var_276_10.prefab_name ~= "" and arg_273_1.actors_[var_276_10.prefab_name] ~= nil then
						local var_276_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_10.prefab_name].transform, "story_v_out_413072", "413072065", "story_v_out_413072.awb")

						arg_273_1:RecordAudio("413072065", var_276_15)
						arg_273_1:RecordAudio("413072065", var_276_15)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_413072", "413072065", "story_v_out_413072.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_413072", "413072065", "story_v_out_413072.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_16 = math.max(var_276_9, arg_273_1.talkMaxDuration)

			if var_276_8 <= arg_273_1.time_ and arg_273_1.time_ < var_276_8 + var_276_16 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_8) / var_276_16

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_8 + var_276_16 and arg_273_1.time_ < var_276_8 + var_276_16 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
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

		arg_273_1:InitPlayNodeList()
	end,
	Play413072066 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 413072066
		arg_277_1.duration_ = 9.33

		local var_277_0 = {
			zh = 5.8,
			ja = 9.333
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
				arg_277_0:Play413072067(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["10092"]) and arg_277_1.var_.actorSpriteComps10092 == nil then
				arg_277_1.var_.actorSpriteComps10092 = arg_277_1.actors_["10092"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_0 = 2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["10092"]) then
				if arg_277_1.var_.actorSpriteComps10092 then
					for iter_280_0, iter_280_1 in pairs(arg_277_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_280_1 then
							if arg_277_1.isInRecall_ then
								iter_280_1.color = Color.New(Mathf.Lerp(iter_280_1.color.r, arg_277_1.hightColor1.r, (arg_277_1.time_ - 0) / var_280_0), Mathf.Lerp(iter_280_1.color.g, arg_277_1.hightColor1.g, (arg_277_1.time_ - 0) / var_280_0), (Mathf.Lerp(iter_280_1.color.b, arg_277_1.hightColor1.b, (arg_277_1.time_ - 0) / var_280_0)))
							else
								local var_280_1 = Mathf.Lerp(iter_280_1.color.r, 1, (arg_277_1.time_ - 0) / var_280_0)

								iter_280_1.color = Color.New(var_280_1, var_280_1, var_280_1)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["10092"]) and arg_277_1.var_.actorSpriteComps10092 then
				for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_280_3 then
						iter_280_3.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_277_1.var_.actorSpriteComps10092 = nil
			end

			local var_280_2 = arg_277_1.actors_["10094"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps10094 == nil then
				arg_277_1.var_.actorSpriteComps10094 = var_280_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_3 = 2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 and not isNil(var_280_2) then
				if arg_277_1.var_.actorSpriteComps10094 then
					for iter_280_4, iter_280_5 in pairs(arg_277_1.var_.actorSpriteComps10094:ToTable()) do
						if iter_280_5 then
							if arg_277_1.isInRecall_ then
								iter_280_5.color = Color.New(Mathf.Lerp(iter_280_5.color.r, arg_277_1.hightColor2.r, (arg_277_1.time_ - 0) / var_280_3), Mathf.Lerp(iter_280_5.color.g, arg_277_1.hightColor2.g, (arg_277_1.time_ - 0) / var_280_3), (Mathf.Lerp(iter_280_5.color.b, arg_277_1.hightColor2.b, (arg_277_1.time_ - 0) / var_280_3)))
							else
								local var_280_4 = Mathf.Lerp(iter_280_5.color.r, 0.5, (arg_277_1.time_ - 0) / var_280_3)

								iter_280_5.color = Color.New(var_280_4, var_280_4, var_280_4)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps10094 then
				for iter_280_6, iter_280_7 in pairs(arg_277_1.var_.actorSpriteComps10094:ToTable()) do
					if iter_280_7 then
						iter_280_7.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_277_1.var_.actorSpriteComps10094 = nil
			end

			local var_280_5 = 0
			local var_280_6 = 0.8

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_5 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_7 = arg_277_1:GetWordFromCfg(413072066)
				local var_280_8 = arg_277_1:FormatText(var_280_7.content)

				arg_277_1.text_.text = var_280_8

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_10 = 32 <= 0 and var_280_6 or var_280_6 * (utf8.len(var_280_8) / 32)

				if (32 <= 0 and var_280_6 or var_280_6 * (utf8.len(var_280_8) / 32)) > 0 and var_280_6 < var_280_10 then
					arg_277_1.talkMaxDuration = var_280_10

					if var_280_10 + var_280_5 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_5
					end
				end

				arg_277_1.text_.text = var_280_8
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072066", "story_v_out_413072.awb") ~= 0 then
					local var_280_11 = manager.audio:GetVoiceLength("story_v_out_413072", "413072066", "story_v_out_413072.awb") / 1000

					if var_280_11 + var_280_5 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_11 + var_280_5
					end

					if var_280_7.prefab_name ~= "" and arg_277_1.actors_[var_280_7.prefab_name] ~= nil then
						local var_280_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_7.prefab_name].transform, "story_v_out_413072", "413072066", "story_v_out_413072.awb")

						arg_277_1:RecordAudio("413072066", var_280_12)
						arg_277_1:RecordAudio("413072066", var_280_12)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_413072", "413072066", "story_v_out_413072.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_413072", "413072066", "story_v_out_413072.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_13 = math.max(var_280_6, arg_277_1.talkMaxDuration)

			if var_280_5 <= arg_277_1.time_ and arg_277_1.time_ < var_280_5 + var_280_13 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_5) / var_280_13

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_5 + var_280_13 and arg_277_1.time_ < var_280_5 + var_280_13 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play413072067 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 413072067
		arg_281_1.duration_ = 5.23

		local var_281_0 = {
			zh = 4.066,
			ja = 5.233
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
			arg_281_1.auto_ = false
		end

		function arg_281_1.playNext_(arg_283_0)
			arg_281_1.onStoryFinished_()
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.35

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_1 = arg_281_1:GetWordFromCfg(413072067)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 14 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 14)

				if (14 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 14)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413072", "413072067", "story_v_out_413072.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_out_413072", "413072067", "story_v_out_413072.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_out_413072", "413072067", "story_v_out_413072.awb")

						arg_281_1:RecordAudio("413072067", var_284_6)
						arg_281_1:RecordAudio("413072067", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_413072", "413072067", "story_v_out_413072.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_413072", "413072067", "story_v_out_413072.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F08g",
		"TextureConfig/Background/F08i",
		"TextureConfig/Background/F10g"
	},
	voices = {
		"story_v_out_413072.awb"
	}
}
