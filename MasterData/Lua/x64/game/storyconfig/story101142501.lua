return {
	Play114251001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114251001
		arg_1_1.duration_ = 11.83

		local var_1_0 = {
			ja = 7.099999999999,
			ko = 10.232999999999,
			zh = 10.332999999999,
			en = 11.832999999999
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
				arg_1_0:Play114251002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST25 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST25")
				var_4_0.name = "ST25"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST25 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST25

				arg_1_1.bgs_.ST25.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST25" then
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

			local var_4_8 = "10018"

			if arg_1_1.actors_["10018"] == nil then
				local var_4_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10018")

				if not isNil(var_4_9) then
					local var_4_10 = Object.Instantiate(var_4_9, arg_1_1.canvasGo_.transform)

					var_4_10.transform:SetSiblingIndex(1)

					var_4_10.name = var_4_8
					var_4_10.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_1_1.actors_[var_4_8] = var_4_10

					if arg_1_1.isInRecall_ then
						for iter_4_2, iter_4_3 in ipairs((var_4_10:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_4_3.color = arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_4_11 = arg_1_1.actors_["10018"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10018 = var_4_11.localPosition
				var_4_11.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10018", 2)

				for iter_4_4 = 0, var_4_11.childCount - 1 do
					local var_4_12 = var_4_11:GetChild(iter_4_4)

					if var_4_12.name == "split_1" or not string.find(var_4_12.name, "split") then
						var_4_12.gameObject:SetActive(true)
					else
						var_4_12.gameObject:SetActive(false)
					end
				end
			end

			local var_4_13 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 then
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (arg_1_1.time_ - 1.8) / var_4_13)
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_4_14 = arg_1_1.actors_["10018"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.actorSpriteComps10018 == nil then
				arg_1_1.var_.actorSpriteComps10018 = var_4_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_15 = 0.034

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.actorSpriteComps10018 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								iter_4_6.color = Color.New(Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.8) / var_4_15), Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.8) / var_4_15), (Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.8) / var_4_15)))
							else
								local var_4_16 = Mathf.Lerp(iter_4_6.color.r, 1, (arg_1_1.time_ - 1.8) / var_4_15)

								iter_4_6.color = Color.New(var_4_16, var_4_16, var_4_16)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.actorSpriteComps10018 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10018 = nil
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				local var_4_17 = arg_1_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_17 then
					arg_1_1.var_.alphaOldValue10018 = var_4_17.alpha
					arg_1_1.var_.characterEffect10018 = var_4_17
				end

				arg_1_1.var_.alphaOldValue10018 = 0
			end

			local var_4_18 = 0.5

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_18 then
				if arg_1_1.var_.characterEffect10018 then
					arg_1_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10018, 1, (arg_1_1.time_ - 1.8) / var_4_18)
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_18 and arg_1_1.time_ < 1.8 + var_4_18 + arg_4_0 and arg_1_1.var_.characterEffect10018 then
				arg_1_1.var_.characterEffect10018.alpha = 1
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

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

			local var_4_25 = 1.999999999999
			local var_4_26 = 0.85

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(114251001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 34 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 34)

				if (34 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 34)) > 0 and var_4_26 < var_4_31 then
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251001", "story_v_out_114251.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_114251", "114251001", "story_v_out_114251.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_114251", "114251001", "story_v_out_114251.awb")

						arg_1_1:RecordAudio("114251001", var_4_33)
						arg_1_1:RecordAudio("114251001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_114251", "114251001", "story_v_out_114251.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_114251", "114251001", "story_v_out_114251.awb")
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
				actorName = "10018",
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
	Play114251002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114251002
		arg_9_1.duration_ = 7.5

		local var_9_0 = {
			ja = 7.5,
			ko = 5.333,
			zh = 6.366,
			en = 6.166
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
				arg_9_0:Play114251003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.775

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(114251002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 31 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 31)

				if (31 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 31)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251002", "story_v_out_114251.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_114251", "114251002", "story_v_out_114251.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_114251", "114251002", "story_v_out_114251.awb")

						arg_9_1:RecordAudio("114251002", var_12_6)
						arg_9_1:RecordAudio("114251002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_114251", "114251002", "story_v_out_114251.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_114251", "114251002", "story_v_out_114251.awb")
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
	Play114251003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114251003
		arg_13_1.duration_ = 8.87

		local var_13_0 = {
			ja = 7.466,
			ko = 8.833,
			zh = 8.866,
			en = 6.666
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
				arg_13_0:Play114251004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["10015"] == nil then
				local var_16_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10015")

				if not isNil(var_16_0) then
					local var_16_1 = Object.Instantiate(var_16_0, arg_13_1.canvasGo_.transform)

					var_16_1.transform:SetSiblingIndex(1)

					var_16_1.name = "10015"
					var_16_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_["10015"] = var_16_1

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs((var_16_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_2 = arg_13_1.actors_["10015"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10015 = var_16_2.localPosition
				var_16_2.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10015", 4)

				for iter_16_2 = 0, var_16_2.childCount - 1 do
					local var_16_3 = var_16_2:GetChild(iter_16_2)

					if var_16_3.name == "split_1" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_2.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_13_1.time_ - 0) / var_16_4)
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_16_5 = arg_13_1.actors_["10018"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps10018 == nil then
				arg_13_1.var_.actorSpriteComps10018 = var_16_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_6 = 0.034

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.actorSpriteComps10018 then
					for iter_16_3, iter_16_4 in pairs(arg_13_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_16_4 then
							if arg_13_1.isInRecall_ then
								iter_16_4.color = Color.New(Mathf.Lerp(iter_16_4.color.r, arg_13_1.hightColor2.r, (arg_13_1.time_ - 0) / var_16_6), Mathf.Lerp(iter_16_4.color.g, arg_13_1.hightColor2.g, (arg_13_1.time_ - 0) / var_16_6), (Mathf.Lerp(iter_16_4.color.b, arg_13_1.hightColor2.b, (arg_13_1.time_ - 0) / var_16_6)))
							else
								local var_16_7 = Mathf.Lerp(iter_16_4.color.r, 0.5, (arg_13_1.time_ - 0) / var_16_6)

								iter_16_4.color = Color.New(var_16_7, var_16_7, var_16_7)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.actorSpriteComps10018 then
				for iter_16_5, iter_16_6 in pairs(arg_13_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_16_6 then
						iter_16_6.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps10018 = nil
			end

			local var_16_8 = arg_13_1.actors_["10015"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.actorSpriteComps10015 == nil then
				arg_13_1.var_.actorSpriteComps10015 = var_16_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_9 = 0.034

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 and not isNil(var_16_8) then
				if arg_13_1.var_.actorSpriteComps10015 then
					for iter_16_7, iter_16_8 in pairs(arg_13_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_16_8 then
							if arg_13_1.isInRecall_ then
								iter_16_8.color = Color.New(Mathf.Lerp(iter_16_8.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_9), Mathf.Lerp(iter_16_8.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_9), (Mathf.Lerp(iter_16_8.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_9)))
							else
								local var_16_10 = Mathf.Lerp(iter_16_8.color.r, 1, (arg_13_1.time_ - 0) / var_16_9)

								iter_16_8.color = Color.New(var_16_10, var_16_10, var_16_10)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 and not isNil(var_16_8) and arg_13_1.var_.actorSpriteComps10015 then
				for iter_16_9, iter_16_10 in pairs(arg_13_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_16_10 then
						iter_16_10.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps10015 = nil
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				local var_16_11 = arg_13_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_11 then
					arg_13_1.var_.alphaOldValue10015 = var_16_11.alpha
					arg_13_1.var_.characterEffect10015 = var_16_11
				end

				arg_13_1.var_.alphaOldValue10015 = 0
			end

			local var_16_12 = 0.5

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_12 then
				if arg_13_1.var_.characterEffect10015 then
					arg_13_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_13_1.var_.alphaOldValue10015, 1, (arg_13_1.time_ - 0) / var_16_12)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_12 and arg_13_1.time_ < 0 + var_16_12 + arg_16_0 and arg_13_1.var_.characterEffect10015 then
				arg_13_1.var_.characterEffect10015.alpha = 1
			end

			local var_16_13 = 0
			local var_16_14 = 0.9

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_13 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_15 = arg_13_1:GetWordFromCfg(114251003)
				local var_16_16 = arg_13_1:FormatText(var_16_15.content)

				arg_13_1.text_.text = var_16_16

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_18 = 35 <= 0 and var_16_14 or var_16_14 * (utf8.len(var_16_16) / 35)

				if (35 <= 0 and var_16_14 or var_16_14 * (utf8.len(var_16_16) / 35)) > 0 and var_16_14 < var_16_18 then
					arg_13_1.talkMaxDuration = var_16_18

					if var_16_18 + var_16_13 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_13
					end
				end

				arg_13_1.text_.text = var_16_16
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251003", "story_v_out_114251.awb") ~= 0 then
					local var_16_19 = manager.audio:GetVoiceLength("story_v_out_114251", "114251003", "story_v_out_114251.awb") / 1000

					if var_16_19 + var_16_13 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_19 + var_16_13
					end

					if var_16_15.prefab_name ~= "" and arg_13_1.actors_[var_16_15.prefab_name] ~= nil then
						local var_16_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_15.prefab_name].transform, "story_v_out_114251", "114251003", "story_v_out_114251.awb")

						arg_13_1:RecordAudio("114251003", var_16_20)
						arg_13_1:RecordAudio("114251003", var_16_20)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_114251", "114251003", "story_v_out_114251.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_114251", "114251003", "story_v_out_114251.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_21 = math.max(var_16_14, arg_13_1.talkMaxDuration)

			if var_16_13 <= arg_13_1.time_ and arg_13_1.time_ < var_16_13 + var_16_21 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_13) / var_16_21

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_13 + var_16_21 and arg_13_1.time_ < var_16_13 + var_16_21 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play114251004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114251004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play114251005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10015"]) and arg_17_1.var_.actorSpriteComps10015 == nil then
				arg_17_1.var_.actorSpriteComps10015 = arg_17_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 0.034

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10015"]) then
				if arg_17_1.var_.actorSpriteComps10015 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10015"]) and arg_17_1.var_.actorSpriteComps10015 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps10015 = nil
			end

			local var_20_2 = 0
			local var_20_3 = 0.9

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_4 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(114251004).content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 36 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_4) / 36)

				if (36 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_4) / 36)) > 0 and var_20_3 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_3, arg_17_1.talkMaxDuration)

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_2) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_2 + var_20_7 and arg_17_1.time_ < var_20_2 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play114251005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114251005
		arg_21_1.duration_ = 7

		local var_21_0 = {
			ja = 7,
			ko = 2.666,
			zh = 2.466,
			en = 2.8
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
				arg_21_0:Play114251006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10018"]) and arg_21_1.var_.actorSpriteComps10018 == nil then
				arg_21_1.var_.actorSpriteComps10018 = arg_21_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10018"]) then
				if arg_21_1.var_.actorSpriteComps10018 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10018"]) and arg_21_1.var_.actorSpriteComps10018 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps10018 = nil
			end

			local var_24_2 = arg_21_1.actors_["10015"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10015 == nil then
				arg_21_1.var_.actorSpriteComps10015 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps10015 then
					for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_24_5 then
							if arg_21_1.isInRecall_ then
								iter_24_5.color = Color.New(Mathf.Lerp(iter_24_5.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_3), Mathf.Lerp(iter_24_5.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_3), (Mathf.Lerp(iter_24_5.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_3)))
							else
								local var_24_4 = Mathf.Lerp(iter_24_5.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_3)

								iter_24_5.color = Color.New(var_24_4, var_24_4, var_24_4)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps10015 then
				for iter_24_6, iter_24_7 in pairs(arg_21_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_24_7 then
						iter_24_7.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps10015 = nil
			end

			local var_24_5 = 0
			local var_24_6 = 0.275

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(114251005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 11 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 11)

				if (11 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 11)) > 0 and var_24_6 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251005", "story_v_out_114251.awb") ~= 0 then
					local var_24_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251005", "story_v_out_114251.awb") / 1000

					if var_24_11 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_5
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_114251", "114251005", "story_v_out_114251.awb")

						arg_21_1:RecordAudio("114251005", var_24_12)
						arg_21_1:RecordAudio("114251005", var_24_12)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_114251", "114251005", "story_v_out_114251.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_114251", "114251005", "story_v_out_114251.awb")
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

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play114251006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114251006
		arg_25_1.duration_ = 1.67

		local var_25_0 = {
			ja = 1.166,
			ko = 1.666,
			zh = 1.366,
			en = 1.433
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
				arg_25_0:Play114251007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10018"]) and arg_25_1.var_.actorSpriteComps10018 == nil then
				arg_25_1.var_.actorSpriteComps10018 = arg_25_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_0 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10018"]) then
				if arg_25_1.var_.actorSpriteComps10018 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10018"]) and arg_25_1.var_.actorSpriteComps10018 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_28_3 then
						iter_28_3.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps10018 = nil
			end

			local var_28_2 = arg_25_1.actors_["10015"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10015 == nil then
				arg_25_1.var_.actorSpriteComps10015 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps10015 then
					for iter_28_4, iter_28_5 in pairs(arg_25_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_28_5 then
							if arg_25_1.isInRecall_ then
								iter_28_5.color = Color.New(Mathf.Lerp(iter_28_5.color.r, arg_25_1.hightColor1.r, (arg_25_1.time_ - 0) / var_28_3), Mathf.Lerp(iter_28_5.color.g, arg_25_1.hightColor1.g, (arg_25_1.time_ - 0) / var_28_3), (Mathf.Lerp(iter_28_5.color.b, arg_25_1.hightColor1.b, (arg_25_1.time_ - 0) / var_28_3)))
							else
								local var_28_4 = Mathf.Lerp(iter_28_5.color.r, 1, (arg_25_1.time_ - 0) / var_28_3)

								iter_28_5.color = Color.New(var_28_4, var_28_4, var_28_4)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10015 then
				for iter_28_6, iter_28_7 in pairs(arg_25_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_28_7 then
						iter_28_7.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps10015 = nil
			end

			local var_28_5 = arg_25_1.actors_["10015"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10015 = var_28_5.localPosition
				var_28_5.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10015", 4)

				for iter_28_8 = 0, var_28_5.childCount - 1 do
					local var_28_6 = var_28_5:GetChild(iter_28_8)

					if var_28_6.name == "split_5" or not string.find(var_28_6.name, "split") then
						var_28_6.gameObject:SetActive(true)
					else
						var_28_6.gameObject:SetActive(false)
					end
				end
			end

			local var_28_7 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_25_1.time_ - 0) / var_28_7)
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(390, -350, -180)
			end

			local var_28_8 = 0
			local var_28_9 = 0.075

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(114251006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 3 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 3)

				if (3 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 3)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251006", "story_v_out_114251.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_114251", "114251006", "story_v_out_114251.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_114251", "114251006", "story_v_out_114251.awb")

						arg_25_1:RecordAudio("114251006", var_28_15)
						arg_25_1:RecordAudio("114251006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_114251", "114251006", "story_v_out_114251.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_114251", "114251006", "story_v_out_114251.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_16 and arg_25_1.time_ < var_28_8 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play114251007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114251007
		arg_29_1.duration_ = 7.47

		local var_29_0 = {
			ja = 7.366,
			ko = 7.266,
			zh = 6.633,
			en = 7.466
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
				arg_29_0:Play114251008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10018"]) and arg_29_1.var_.actorSpriteComps10018 == nil then
				arg_29_1.var_.actorSpriteComps10018 = arg_29_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10018"]) then
				if arg_29_1.var_.actorSpriteComps10018 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								iter_32_1.color = Color.New(Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 0) / var_32_0), Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 0) / var_32_0), (Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 0) / var_32_0)))
							else
								local var_32_1 = Mathf.Lerp(iter_32_1.color.r, 1, (arg_29_1.time_ - 0) / var_32_0)

								iter_32_1.color = Color.New(var_32_1, var_32_1, var_32_1)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10018"]) and arg_29_1.var_.actorSpriteComps10018 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps10018 = nil
			end

			local var_32_2 = arg_29_1.actors_["10015"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10015 == nil then
				arg_29_1.var_.actorSpriteComps10015 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps10015 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_32_5 then
							if arg_29_1.isInRecall_ then
								iter_32_5.color = Color.New(Mathf.Lerp(iter_32_5.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_3), Mathf.Lerp(iter_32_5.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_3), (Mathf.Lerp(iter_32_5.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_3)))
							else
								local var_32_4 = Mathf.Lerp(iter_32_5.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_3)

								iter_32_5.color = Color.New(var_32_4, var_32_4, var_32_4)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps10015 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_32_7 then
						iter_32_7.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps10015 = nil
			end

			local var_32_5 = 0
			local var_32_6 = 0.8

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(114251007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 32 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 32)

				if (32 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 32)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251007", "story_v_out_114251.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251007", "story_v_out_114251.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_114251", "114251007", "story_v_out_114251.awb")

						arg_29_1:RecordAudio("114251007", var_32_12)
						arg_29_1:RecordAudio("114251007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_114251", "114251007", "story_v_out_114251.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_114251", "114251007", "story_v_out_114251.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_13 = math.max(var_32_6, arg_29_1.talkMaxDuration)

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_13 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_5) / var_32_13

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_5 + var_32_13 and arg_29_1.time_ < var_32_5 + var_32_13 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play114251008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114251008
		arg_33_1.duration_ = 9.33

		local var_33_0 = {
			ja = 9.266,
			ko = 9.333,
			zh = 8.366,
			en = 8
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
				arg_33_0:Play114251009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				local var_36_0 = arg_33_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_36_0 then
					arg_33_1.var_.alphaOldValue10015 = var_36_0.alpha
					arg_33_1.var_.characterEffect10015 = var_36_0
				end

				arg_33_1.var_.alphaOldValue10015 = 1
			end

			local var_36_1 = 0.5

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				if arg_33_1.var_.characterEffect10015 then
					arg_33_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_33_1.var_.alphaOldValue10015, 0, (arg_33_1.time_ - 0) / var_36_1)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 and arg_33_1.var_.characterEffect10015 then
				arg_33_1.var_.characterEffect10015.alpha = 0
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				local var_36_2 = arg_33_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_36_2 then
					arg_33_1.var_.alphaOldValue10018 = var_36_2.alpha
					arg_33_1.var_.characterEffect10018 = var_36_2
				end

				arg_33_1.var_.alphaOldValue10018 = 1
			end

			local var_36_3 = 0.5

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 then
				if arg_33_1.var_.characterEffect10018 then
					arg_33_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_33_1.var_.alphaOldValue10018, 0, (arg_33_1.time_ - 0) / var_36_3)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and arg_33_1.var_.characterEffect10018 then
				arg_33_1.var_.characterEffect10018.alpha = 0
			end

			local var_36_4 = 0
			local var_36_5 = 0.95

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_6 = arg_33_1:GetWordFromCfg(114251008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 38 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 38)

				if (38 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 38)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251008", "story_v_out_114251.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_114251", "114251008", "story_v_out_114251.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_out_114251", "114251008", "story_v_out_114251.awb")

						arg_33_1:RecordAudio("114251008", var_36_11)
						arg_33_1:RecordAudio("114251008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_114251", "114251008", "story_v_out_114251.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_114251", "114251008", "story_v_out_114251.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_12 and arg_33_1.time_ < var_36_4 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play114251009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114251009
		arg_37_1.duration_ = 8.67

		local var_37_0 = {
			ja = 8.366,
			ko = 8.666,
			zh = 8.333,
			en = 8.666
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
				arg_37_0:Play114251010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.975

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:GetWordFromCfg(114251009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 39 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 39)

				if (39 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 39)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251009", "story_v_out_114251.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_114251", "114251009", "story_v_out_114251.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_114251", "114251009", "story_v_out_114251.awb")

						arg_37_1:RecordAudio("114251009", var_40_6)
						arg_37_1:RecordAudio("114251009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_114251", "114251009", "story_v_out_114251.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_114251", "114251009", "story_v_out_114251.awb")
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
	Play114251010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114251010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play114251011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 1.1

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(114251010).content)

				arg_41_1.text_.text = var_44_1

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_3 = 44 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 44)

				if (44 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_1) / 44)) > 0 and var_44_0 < var_44_3 then
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
	Play114251011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114251011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play114251012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.1

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

				local var_48_1 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(114251011).content)

				arg_45_1.text_.text = var_48_1

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_3 = 44 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 44)

				if (44 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_1) / 44)) > 0 and var_48_0 < var_48_3 then
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
	Play114251012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114251012
		arg_49_1.duration_ = 8.7

		local var_49_0 = {
			ja = 8.7,
			ko = 7.133,
			zh = 5.933,
			en = 8.066
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
				arg_49_0:Play114251013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.725

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(114251012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 29 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 29)

				if (29 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 29)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251012", "story_v_out_114251.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_114251", "114251012", "story_v_out_114251.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_114251", "114251012", "story_v_out_114251.awb")

						arg_49_1:RecordAudio("114251012", var_52_6)
						arg_49_1:RecordAudio("114251012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_114251", "114251012", "story_v_out_114251.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_114251", "114251012", "story_v_out_114251.awb")
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
	Play114251013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114251013
		arg_53_1.duration_ = 4.57

		local var_53_0 = {
			ja = 4.166,
			ko = 4.5,
			zh = 4.3,
			en = 4.566
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
				arg_53_0:Play114251014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.45

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_1 = arg_53_1:GetWordFromCfg(114251013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 18 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 18)

				if (18 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 18)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251013", "story_v_out_114251.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_114251", "114251013", "story_v_out_114251.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_114251", "114251013", "story_v_out_114251.awb")

						arg_53_1:RecordAudio("114251013", var_56_6)
						arg_53_1:RecordAudio("114251013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_114251", "114251013", "story_v_out_114251.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_114251", "114251013", "story_v_out_114251.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play114251014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114251014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play114251015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_60_0 = 0.6

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				local var_60_1, var_60_2 = math.modf((arg_57_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_60_2 * 0.13, var_60_2 * 0.13, var_60_2 * 0.13) + arg_57_1.var_.shakeOldPos
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				manager.ui.mainCamera.transform.localPosition = arg_57_1.var_.shakeOldPos
			end

			local var_60_3 = 0

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_3 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			if arg_57_1.time_ >= var_60_3 + 0.6 and arg_57_1.time_ < var_60_3 + 0.6 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			local var_60_4 = 0
			local var_60_5 = 1.3

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(114251014).content)

				arg_57_1.text_.text = var_60_6

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_8 = 51 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_6) / 51)

				if (51 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_6) / 51)) > 0 and var_60_5 < var_60_8 then
					arg_57_1.talkMaxDuration = var_60_8

					if var_60_8 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_6
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_9 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_9 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_9

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_9 and arg_57_1.time_ < var_60_4 + var_60_9 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play114251015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114251015
		arg_61_1.duration_ = 7.17

		local var_61_0 = {
			ja = 7.166,
			ko = 3.533,
			zh = 3.733,
			en = 3.266
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
				arg_61_0:Play114251016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10018 = arg_61_1.actors_["10018"].transform.localPosition
				arg_61_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10018", 2)

				for iter_64_0 = 0, arg_61_1.actors_["10018"].transform.childCount - 1 do
					local var_64_0 = arg_61_1.actors_["10018"].transform:GetChild(iter_64_0)

					if var_64_0.name == "split_1" or not string.find(var_64_0.name, "split") then
						var_64_0.gameObject:SetActive(true)
					else
						var_64_0.gameObject:SetActive(false)
					end
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (arg_61_1.time_ - 0) / var_64_1)
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["10018"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_64_2 = arg_61_1.actors_["10015"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10015 = var_64_2.localPosition
				var_64_2.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10015", 4)

				for iter_64_1 = 0, var_64_2.childCount - 1 do
					local var_64_3 = var_64_2:GetChild(iter_64_1)

					if var_64_3.name == "split_1" or not string.find(var_64_3.name, "split") then
						var_64_3.gameObject:SetActive(true)
					else
						var_64_3.gameObject:SetActive(false)
					end
				end
			end

			local var_64_4 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				var_64_2.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_61_1.time_ - 0) / var_64_4)
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				var_64_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_64_5 = arg_61_1.actors_["10018"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.actorSpriteComps10018 == nil then
				arg_61_1.var_.actorSpriteComps10018 = var_64_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_6 = 0.034

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_6 and not isNil(var_64_5) then
				if arg_61_1.var_.actorSpriteComps10018 then
					for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_64_3 then
							if arg_61_1.isInRecall_ then
								iter_64_3.color = Color.New(Mathf.Lerp(iter_64_3.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_6), Mathf.Lerp(iter_64_3.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_6), (Mathf.Lerp(iter_64_3.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_6)))
							else
								local var_64_7 = Mathf.Lerp(iter_64_3.color.r, 1, (arg_61_1.time_ - 0) / var_64_6)

								iter_64_3.color = Color.New(var_64_7, var_64_7, var_64_7)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_6 and arg_61_1.time_ < 0 + var_64_6 + arg_64_0 and not isNil(var_64_5) and arg_61_1.var_.actorSpriteComps10018 then
				for iter_64_4, iter_64_5 in pairs(arg_61_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_64_5 then
						iter_64_5.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps10018 = nil
			end

			local var_64_8 = arg_61_1.actors_["10015"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10015 == nil then
				arg_61_1.var_.actorSpriteComps10015 = var_64_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_9 = 0.034

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_9 and not isNil(var_64_8) then
				if arg_61_1.var_.actorSpriteComps10015 then
					for iter_64_6, iter_64_7 in pairs(arg_61_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_64_7 then
							if arg_61_1.isInRecall_ then
								iter_64_7.color = Color.New(Mathf.Lerp(iter_64_7.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_9), Mathf.Lerp(iter_64_7.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_9), (Mathf.Lerp(iter_64_7.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_9)))
							else
								local var_64_10 = Mathf.Lerp(iter_64_7.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_9)

								iter_64_7.color = Color.New(var_64_10, var_64_10, var_64_10)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_9 and arg_61_1.time_ < 0 + var_64_9 + arg_64_0 and not isNil(var_64_8) and arg_61_1.var_.actorSpriteComps10015 then
				for iter_64_8, iter_64_9 in pairs(arg_61_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_64_9 then
						iter_64_9.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps10015 = nil
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				local var_64_11 = arg_61_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_64_11 then
					arg_61_1.var_.alphaOldValue10018 = var_64_11.alpha
					arg_61_1.var_.characterEffect10018 = var_64_11
				end

				arg_61_1.var_.alphaOldValue10018 = 0
			end

			local var_64_12 = 0.5

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_12 then
				if arg_61_1.var_.characterEffect10018 then
					arg_61_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_61_1.var_.alphaOldValue10018, 1, (arg_61_1.time_ - 0) / var_64_12)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_12 and arg_61_1.time_ < 0 + var_64_12 + arg_64_0 and arg_61_1.var_.characterEffect10018 then
				arg_61_1.var_.characterEffect10018.alpha = 1
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				local var_64_13 = arg_61_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_64_13 then
					arg_61_1.var_.alphaOldValue10015 = var_64_13.alpha
					arg_61_1.var_.characterEffect10015 = var_64_13
				end

				arg_61_1.var_.alphaOldValue10015 = 0
			end

			local var_64_14 = 0.5

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_14 then
				if arg_61_1.var_.characterEffect10015 then
					arg_61_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_61_1.var_.alphaOldValue10015, 1, (arg_61_1.time_ - 0) / var_64_14)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_14 and arg_61_1.time_ < 0 + var_64_14 + arg_64_0 and arg_61_1.var_.characterEffect10015 then
				arg_61_1.var_.characterEffect10015.alpha = 1
			end

			local var_64_15 = 0
			local var_64_16 = 0.4

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_15 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_17 = arg_61_1:GetWordFromCfg(114251015)
				local var_64_18 = arg_61_1:FormatText(var_64_17.content)

				arg_61_1.text_.text = var_64_18

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_20 = 16 <= 0 and var_64_16 or var_64_16 * (utf8.len(var_64_18) / 16)

				if (16 <= 0 and var_64_16 or var_64_16 * (utf8.len(var_64_18) / 16)) > 0 and var_64_16 < var_64_20 then
					arg_61_1.talkMaxDuration = var_64_20

					if var_64_20 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_20 + var_64_15
					end
				end

				arg_61_1.text_.text = var_64_18
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251015", "story_v_out_114251.awb") ~= 0 then
					local var_64_21 = manager.audio:GetVoiceLength("story_v_out_114251", "114251015", "story_v_out_114251.awb") / 1000

					if var_64_21 + var_64_15 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_21 + var_64_15
					end

					if var_64_17.prefab_name ~= "" and arg_61_1.actors_[var_64_17.prefab_name] ~= nil then
						local var_64_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_17.prefab_name].transform, "story_v_out_114251", "114251015", "story_v_out_114251.awb")

						arg_61_1:RecordAudio("114251015", var_64_22)
						arg_61_1:RecordAudio("114251015", var_64_22)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_114251", "114251015", "story_v_out_114251.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_114251", "114251015", "story_v_out_114251.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_23 = math.max(var_64_16, arg_61_1.talkMaxDuration)

			if var_64_15 <= arg_61_1.time_ and arg_61_1.time_ < var_64_15 + var_64_23 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_15) / var_64_23

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_15 + var_64_23 and arg_61_1.time_ < var_64_15 + var_64_23 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_61_1:InitPlayNodeList()
	end,
	Play114251016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114251016
		arg_65_1.duration_ = 8.87

		local var_65_0 = {
			ja = 4.2,
			ko = 8.866,
			zh = 7.9,
			en = 5.233
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
				arg_65_0:Play114251017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10015 = arg_65_1.actors_["10015"].transform.localPosition
				arg_65_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10015", 4)

				for iter_68_0 = 0, arg_65_1.actors_["10015"].transform.childCount - 1 do
					local var_68_0 = arg_65_1.actors_["10015"].transform:GetChild(iter_68_0)

					if var_68_0.name == "split_1" or not string.find(var_68_0.name, "split") then
						var_68_0.gameObject:SetActive(true)
					else
						var_68_0.gameObject:SetActive(false)
					end
				end
			end

			local var_68_1 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_1 then
				arg_65_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_65_1.time_ - 0) / var_68_1)
			end

			if arg_65_1.time_ >= 0 + var_68_1 and arg_65_1.time_ < 0 + var_68_1 + arg_68_0 then
				arg_65_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_68_2 = arg_65_1.actors_["10018"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10018 == nil then
				arg_65_1.var_.actorSpriteComps10018 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 0.034

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps10018 then
					for iter_68_1, iter_68_2 in pairs(arg_65_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_68_2 then
							if arg_65_1.isInRecall_ then
								iter_68_2.color = Color.New(Mathf.Lerp(iter_68_2.color.r, arg_65_1.hightColor2.r, (arg_65_1.time_ - 0) / var_68_3), Mathf.Lerp(iter_68_2.color.g, arg_65_1.hightColor2.g, (arg_65_1.time_ - 0) / var_68_3), (Mathf.Lerp(iter_68_2.color.b, arg_65_1.hightColor2.b, (arg_65_1.time_ - 0) / var_68_3)))
							else
								local var_68_4 = Mathf.Lerp(iter_68_2.color.r, 0.5, (arg_65_1.time_ - 0) / var_68_3)

								iter_68_2.color = Color.New(var_68_4, var_68_4, var_68_4)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps10018 then
				for iter_68_3, iter_68_4 in pairs(arg_65_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_68_4 then
						iter_68_4.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps10018 = nil
			end

			local var_68_5 = arg_65_1.actors_["10015"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.actorSpriteComps10015 == nil then
				arg_65_1.var_.actorSpriteComps10015 = var_68_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_6 = 0.034

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_6 and not isNil(var_68_5) then
				if arg_65_1.var_.actorSpriteComps10015 then
					for iter_68_5, iter_68_6 in pairs(arg_65_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_68_6 then
							if arg_65_1.isInRecall_ then
								iter_68_6.color = Color.New(Mathf.Lerp(iter_68_6.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_6), Mathf.Lerp(iter_68_6.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_6), (Mathf.Lerp(iter_68_6.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_6)))
							else
								local var_68_7 = Mathf.Lerp(iter_68_6.color.r, 1, (arg_65_1.time_ - 0) / var_68_6)

								iter_68_6.color = Color.New(var_68_7, var_68_7, var_68_7)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_6 and arg_65_1.time_ < 0 + var_68_6 + arg_68_0 and not isNil(var_68_5) and arg_65_1.var_.actorSpriteComps10015 then
				for iter_68_7, iter_68_8 in pairs(arg_65_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_68_8 then
						iter_68_8.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10015 = nil
			end

			local var_68_8 = 0
			local var_68_9 = 0.725

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_10 = arg_65_1:GetWordFromCfg(114251016)
				local var_68_11 = arg_65_1:FormatText(var_68_10.content)

				arg_65_1.text_.text = var_68_11

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 29 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 29)

				if (29 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 29)) > 0 and var_68_9 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_11
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251016", "story_v_out_114251.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_114251", "114251016", "story_v_out_114251.awb") / 1000

					if var_68_14 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_8
					end

					if var_68_10.prefab_name ~= "" and arg_65_1.actors_[var_68_10.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_10.prefab_name].transform, "story_v_out_114251", "114251016", "story_v_out_114251.awb")

						arg_65_1:RecordAudio("114251016", var_68_15)
						arg_65_1:RecordAudio("114251016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_114251", "114251016", "story_v_out_114251.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_114251", "114251016", "story_v_out_114251.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_16 and arg_65_1.time_ < var_68_8 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play114251017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114251017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play114251018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				local var_72_0 = arg_69_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_72_0 then
					arg_69_1.var_.alphaOldValue10015 = var_72_0.alpha
					arg_69_1.var_.characterEffect10015 = var_72_0
				end

				arg_69_1.var_.alphaOldValue10015 = 1
			end

			local var_72_1 = 0.5

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				if arg_69_1.var_.characterEffect10015 then
					arg_69_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_69_1.var_.alphaOldValue10015, 0, (arg_69_1.time_ - 0) / var_72_1)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 and arg_69_1.var_.characterEffect10015 then
				arg_69_1.var_.characterEffect10015.alpha = 0
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				local var_72_2 = arg_69_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_72_2 then
					arg_69_1.var_.alphaOldValue10018 = var_72_2.alpha
					arg_69_1.var_.characterEffect10018 = var_72_2
				end

				arg_69_1.var_.alphaOldValue10018 = 1
			end

			local var_72_3 = 0.5

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 then
				if arg_69_1.var_.characterEffect10018 then
					arg_69_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_69_1.var_.alphaOldValue10018, 0, (arg_69_1.time_ - 0) / var_72_3)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and arg_69_1.var_.characterEffect10018 then
				arg_69_1.var_.characterEffect10018.alpha = 0
			end

			local var_72_4 = 0
			local var_72_5 = 1.625

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(114251017).content)

				arg_69_1.text_.text = var_72_6

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_8 = 64 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_6) / 64)

				if (64 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_6) / 64)) > 0 and var_72_5 < var_72_8 then
					arg_69_1.talkMaxDuration = var_72_8

					if var_72_8 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_6
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_9 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_9 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_9

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_9 and arg_69_1.time_ < var_72_4 + var_72_9 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play114251018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114251018
		arg_73_1.duration_ = 3.8

		local var_73_0 = {
			ja = 3.8,
			ko = 2.1,
			zh = 3.1,
			en = 2.133
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
				arg_73_0:Play114251019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10015 = arg_73_1.actors_["10015"].transform.localPosition
				arg_73_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10015", 4)

				for iter_76_0 = 0, arg_73_1.actors_["10015"].transform.childCount - 1 do
					local var_76_0 = arg_73_1.actors_["10015"].transform:GetChild(iter_76_0)

					if var_76_0.name == "split_1" or not string.find(var_76_0.name, "split") then
						var_76_0.gameObject:SetActive(true)
					else
						var_76_0.gameObject:SetActive(false)
					end
				end
			end

			local var_76_1 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_1 then
				arg_73_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_73_1.time_ - 0) / var_76_1)
			end

			if arg_73_1.time_ >= 0 + var_76_1 and arg_73_1.time_ < 0 + var_76_1 + arg_76_0 then
				arg_73_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_76_2 = arg_73_1.actors_["10015"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps10015 == nil then
				arg_73_1.var_.actorSpriteComps10015 = var_76_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_3 = 0.034

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.actorSpriteComps10015 then
					for iter_76_1, iter_76_2 in pairs(arg_73_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_76_2 then
							if arg_73_1.isInRecall_ then
								iter_76_2.color = Color.New(Mathf.Lerp(iter_76_2.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 0) / var_76_3), Mathf.Lerp(iter_76_2.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 0) / var_76_3), (Mathf.Lerp(iter_76_2.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 0) / var_76_3)))
							else
								local var_76_4 = Mathf.Lerp(iter_76_2.color.r, 1, (arg_73_1.time_ - 0) / var_76_3)

								iter_76_2.color = Color.New(var_76_4, var_76_4, var_76_4)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps10015 then
				for iter_76_3, iter_76_4 in pairs(arg_73_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_76_4 then
						iter_76_4.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps10015 = nil
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				local var_76_5 = arg_73_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_76_5 then
					arg_73_1.var_.alphaOldValue10015 = var_76_5.alpha
					arg_73_1.var_.characterEffect10015 = var_76_5
				end

				arg_73_1.var_.alphaOldValue10015 = 0
			end

			local var_76_6 = 0.5

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_6 then
				if arg_73_1.var_.characterEffect10015 then
					arg_73_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_73_1.var_.alphaOldValue10015, 1, (arg_73_1.time_ - 0) / var_76_6)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_6 and arg_73_1.time_ < 0 + var_76_6 + arg_76_0 and arg_73_1.var_.characterEffect10015 then
				arg_73_1.var_.characterEffect10015.alpha = 1
			end

			local var_76_7 = 0
			local var_76_8 = 0.325

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_7 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_9 = arg_73_1:GetWordFromCfg(114251018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_12 = 13 <= 0 and var_76_8 or var_76_8 * (utf8.len(var_76_10) / 13)

				if (13 <= 0 and var_76_8 or var_76_8 * (utf8.len(var_76_10) / 13)) > 0 and var_76_8 < var_76_12 then
					arg_73_1.talkMaxDuration = var_76_12

					if var_76_12 + var_76_7 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_12 + var_76_7
					end
				end

				arg_73_1.text_.text = var_76_10
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251018", "story_v_out_114251.awb") ~= 0 then
					local var_76_13 = manager.audio:GetVoiceLength("story_v_out_114251", "114251018", "story_v_out_114251.awb") / 1000

					if var_76_13 + var_76_7 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_7
					end

					if var_76_9.prefab_name ~= "" and arg_73_1.actors_[var_76_9.prefab_name] ~= nil then
						local var_76_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_9.prefab_name].transform, "story_v_out_114251", "114251018", "story_v_out_114251.awb")

						arg_73_1:RecordAudio("114251018", var_76_14)
						arg_73_1:RecordAudio("114251018", var_76_14)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_114251", "114251018", "story_v_out_114251.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_114251", "114251018", "story_v_out_114251.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_15 = math.max(var_76_8, arg_73_1.talkMaxDuration)

			if var_76_7 <= arg_73_1.time_ and arg_73_1.time_ < var_76_7 + var_76_15 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_7) / var_76_15

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_7 + var_76_15 and arg_73_1.time_ < var_76_7 + var_76_15 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play114251019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114251019
		arg_77_1.duration_ = 4.1

		local var_77_0 = {
			ja = 4.1,
			ko = 3.633,
			zh = 3.433,
			en = 3.2
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
				arg_77_0:Play114251020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10018 = arg_77_1.actors_["10018"].transform.localPosition
				arg_77_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10018", 2)

				for iter_80_0 = 0, arg_77_1.actors_["10018"].transform.childCount - 1 do
					local var_80_0 = arg_77_1.actors_["10018"].transform:GetChild(iter_80_0)

					if var_80_0.name == "split_2" or not string.find(var_80_0.name, "split") then
						var_80_0.gameObject:SetActive(true)
					else
						var_80_0.gameObject:SetActive(false)
					end
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (arg_77_1.time_ - 0) / var_80_1)
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["10018"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_80_2 = arg_77_1.actors_["10018"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10018 == nil then
				arg_77_1.var_.actorSpriteComps10018 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 0.034

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps10018 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_80_2 then
							if arg_77_1.isInRecall_ then
								iter_80_2.color = Color.New(Mathf.Lerp(iter_80_2.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_3), Mathf.Lerp(iter_80_2.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_3), (Mathf.Lerp(iter_80_2.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_3)))
							else
								local var_80_4 = Mathf.Lerp(iter_80_2.color.r, 1, (arg_77_1.time_ - 0) / var_80_3)

								iter_80_2.color = Color.New(var_80_4, var_80_4, var_80_4)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10018 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_80_4 then
						iter_80_4.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps10018 = nil
			end

			local var_80_5 = arg_77_1.actors_["10015"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.actorSpriteComps10015 == nil then
				arg_77_1.var_.actorSpriteComps10015 = var_80_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_6 = 0.034

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_6 and not isNil(var_80_5) then
				if arg_77_1.var_.actorSpriteComps10015 then
					for iter_80_5, iter_80_6 in pairs(arg_77_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_80_6 then
							if arg_77_1.isInRecall_ then
								iter_80_6.color = Color.New(Mathf.Lerp(iter_80_6.color.r, arg_77_1.hightColor2.r, (arg_77_1.time_ - 0) / var_80_6), Mathf.Lerp(iter_80_6.color.g, arg_77_1.hightColor2.g, (arg_77_1.time_ - 0) / var_80_6), (Mathf.Lerp(iter_80_6.color.b, arg_77_1.hightColor2.b, (arg_77_1.time_ - 0) / var_80_6)))
							else
								local var_80_7 = Mathf.Lerp(iter_80_6.color.r, 0.5, (arg_77_1.time_ - 0) / var_80_6)

								iter_80_6.color = Color.New(var_80_7, var_80_7, var_80_7)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_6 and arg_77_1.time_ < 0 + var_80_6 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.actorSpriteComps10015 then
				for iter_80_7, iter_80_8 in pairs(arg_77_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_80_8 then
						iter_80_8.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps10015 = nil
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				local var_80_8 = arg_77_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_80_8 then
					arg_77_1.var_.alphaOldValue10018 = var_80_8.alpha
					arg_77_1.var_.characterEffect10018 = var_80_8
				end

				arg_77_1.var_.alphaOldValue10018 = 0
			end

			local var_80_9 = 0.5

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_9 then
				if arg_77_1.var_.characterEffect10018 then
					arg_77_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_77_1.var_.alphaOldValue10018, 1, (arg_77_1.time_ - 0) / var_80_9)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_9 and arg_77_1.time_ < 0 + var_80_9 + arg_80_0 and arg_77_1.var_.characterEffect10018 then
				arg_77_1.var_.characterEffect10018.alpha = 1
			end

			local var_80_10 = 0
			local var_80_11 = 0.35

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_12 = arg_77_1:GetWordFromCfg(114251019)
				local var_80_13 = arg_77_1:FormatText(var_80_12.content)

				arg_77_1.text_.text = var_80_13

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_15 = 14 <= 0 and var_80_11 or var_80_11 * (utf8.len(var_80_13) / 14)

				if (14 <= 0 and var_80_11 or var_80_11 * (utf8.len(var_80_13) / 14)) > 0 and var_80_11 < var_80_15 then
					arg_77_1.talkMaxDuration = var_80_15

					if var_80_15 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_15 + var_80_10
					end
				end

				arg_77_1.text_.text = var_80_13
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251019", "story_v_out_114251.awb") ~= 0 then
					local var_80_16 = manager.audio:GetVoiceLength("story_v_out_114251", "114251019", "story_v_out_114251.awb") / 1000

					if var_80_16 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_16 + var_80_10
					end

					if var_80_12.prefab_name ~= "" and arg_77_1.actors_[var_80_12.prefab_name] ~= nil then
						local var_80_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_12.prefab_name].transform, "story_v_out_114251", "114251019", "story_v_out_114251.awb")

						arg_77_1:RecordAudio("114251019", var_80_17)
						arg_77_1:RecordAudio("114251019", var_80_17)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_114251", "114251019", "story_v_out_114251.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_114251", "114251019", "story_v_out_114251.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_18 = math.max(var_80_11, arg_77_1.talkMaxDuration)

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_18 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_10) / var_80_18

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_10 + var_80_18 and arg_77_1.time_ < var_80_10 + var_80_18 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114251020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114251020
		arg_81_1.duration_ = 9.13

		local var_81_0 = {
			ja = 9.133,
			ko = 6.533,
			zh = 7.366,
			en = 7.333
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play114251021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10015"]) and arg_81_1.var_.actorSpriteComps10015 == nil then
				arg_81_1.var_.actorSpriteComps10015 = arg_81_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_0 = 0.034

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10015"]) then
				if arg_81_1.var_.actorSpriteComps10015 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_84_1 then
							if arg_81_1.isInRecall_ then
								iter_84_1.color = Color.New(Mathf.Lerp(iter_84_1.color.r, arg_81_1.hightColor1.r, (arg_81_1.time_ - 0) / var_84_0), Mathf.Lerp(iter_84_1.color.g, arg_81_1.hightColor1.g, (arg_81_1.time_ - 0) / var_84_0), (Mathf.Lerp(iter_84_1.color.b, arg_81_1.hightColor1.b, (arg_81_1.time_ - 0) / var_84_0)))
							else
								local var_84_1 = Mathf.Lerp(iter_84_1.color.r, 1, (arg_81_1.time_ - 0) / var_84_0)

								iter_84_1.color = Color.New(var_84_1, var_84_1, var_84_1)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10015"]) and arg_81_1.var_.actorSpriteComps10015 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_84_3 then
						iter_84_3.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps10015 = nil
			end

			local var_84_2 = arg_81_1.actors_["10018"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10018 == nil then
				arg_81_1.var_.actorSpriteComps10018 = var_84_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_3 = 0.034

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.actorSpriteComps10018 then
					for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_84_5 then
							if arg_81_1.isInRecall_ then
								iter_84_5.color = Color.New(Mathf.Lerp(iter_84_5.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_3), Mathf.Lerp(iter_84_5.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_3), (Mathf.Lerp(iter_84_5.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_3)))
							else
								local var_84_4 = Mathf.Lerp(iter_84_5.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_3)

								iter_84_5.color = Color.New(var_84_4, var_84_4, var_84_4)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10018 then
				for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_84_7 then
						iter_84_7.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10018 = nil
			end

			local var_84_5 = 0
			local var_84_6 = 0.725

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_7 = arg_81_1:GetWordFromCfg(114251020)
				local var_84_8 = arg_81_1:FormatText(var_84_7.content)

				arg_81_1.text_.text = var_84_8

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_10 = 29 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_8) / 29)

				if (29 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_8) / 29)) > 0 and var_84_6 < var_84_10 then
					arg_81_1.talkMaxDuration = var_84_10

					if var_84_10 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_5
					end
				end

				arg_81_1.text_.text = var_84_8
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251020", "story_v_out_114251.awb") ~= 0 then
					local var_84_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251020", "story_v_out_114251.awb") / 1000

					if var_84_11 + var_84_5 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_11 + var_84_5
					end

					if var_84_7.prefab_name ~= "" and arg_81_1.actors_[var_84_7.prefab_name] ~= nil then
						local var_84_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_7.prefab_name].transform, "story_v_out_114251", "114251020", "story_v_out_114251.awb")

						arg_81_1:RecordAudio("114251020", var_84_12)
						arg_81_1:RecordAudio("114251020", var_84_12)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_114251", "114251020", "story_v_out_114251.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_114251", "114251020", "story_v_out_114251.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_13 = math.max(var_84_6, arg_81_1.talkMaxDuration)

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_13 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_5) / var_84_13

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_5 + var_84_13 and arg_81_1.time_ < var_84_5 + var_84_13 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play114251021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114251021
		arg_85_1.duration_ = 8.45

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play114251022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 1.966 < arg_85_1.time_ and arg_85_1.time_ <= 1.966 + arg_88_0 then
				arg_85_1.var_.moveOldPos10018 = arg_85_1.actors_["10018"].transform.localPosition
				arg_85_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10018", 7)

				for iter_88_0 = 0, arg_85_1.actors_["10018"].transform.childCount - 1 do
					local var_88_0 = arg_85_1.actors_["10018"].transform:GetChild(iter_88_0)

					if var_88_0.name == "split_2" or not string.find(var_88_0.name, "split") then
						var_88_0.gameObject:SetActive(true)
					else
						var_88_0.gameObject:SetActive(false)
					end
				end
			end

			local var_88_1 = 0.001

			if 1.966 <= arg_85_1.time_ and arg_85_1.time_ < 1.966 + var_88_1 then
				arg_85_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10018, Vector3.New(0, -2000, -180), (arg_85_1.time_ - 1.966) / var_88_1)
			end

			if arg_85_1.time_ >= 1.966 + var_88_1 and arg_85_1.time_ < 1.966 + var_88_1 + arg_88_0 then
				arg_85_1.actors_["10018"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_88_2 = arg_85_1.actors_["10015"].transform

			if 1.966 < arg_85_1.time_ and arg_85_1.time_ <= 1.966 + arg_88_0 then
				arg_85_1.var_.moveOldPos10015 = var_88_2.localPosition
				var_88_2.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("10015", 7)

				for iter_88_1 = 0, var_88_2.childCount - 1 do
					local var_88_3 = var_88_2:GetChild(iter_88_1)

					if var_88_3.name == "split_1" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if 1.966 <= arg_85_1.time_ and arg_85_1.time_ < 1.966 + var_88_4 then
				var_88_2.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos10015, Vector3.New(0, -2000, 450), (arg_85_1.time_ - 1.966) / var_88_4)
			end

			if arg_85_1.time_ >= 1.966 + var_88_4 and arg_85_1.time_ < 1.966 + var_88_4 + arg_88_0 then
				var_88_2.localPosition = Vector3.New(0, -2000, 450)
			end

			local var_88_5 = "ST24"

			if arg_85_1.bgs_.ST24 == nil then
				local var_88_6 = Object.Instantiate(arg_85_1.paintGo_)

				var_88_6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_88_5)
				var_88_6.name = var_88_5
				var_88_6.transform.parent = arg_85_1.stage_.transform
				var_88_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_85_1.bgs_[var_88_5] = var_88_6
			end

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= 2 + arg_88_0 then
				local var_88_7 = arg_85_1.bgs_.ST24

				arg_85_1.bgs_.ST24.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_88_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_88_8 = var_88_7:GetComponent("SpriteRenderer")

				if var_88_8 and var_88_8.sprite then
					local var_88_9 = 2 * (var_88_7.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_88_7.transform.localScale = Vector3.New(var_88_9 / var_88_8.sprite.bounds.size.y < var_88_9 * manager.ui.mainCameraCom_.aspect / var_88_8.sprite.bounds.size.x and var_88_9 * manager.ui.mainCameraCom_.aspect / var_88_8.sprite.bounds.size.x or var_88_9 / var_88_8.sprite.bounds.size.y, var_88_9 / var_88_8.sprite.bounds.size.y < var_88_9 * manager.ui.mainCameraCom_.aspect / var_88_8.sprite.bounds.size.x and var_88_9 * manager.ui.mainCameraCom_.aspect / var_88_8.sprite.bounds.size.x or var_88_9 / var_88_8.sprite.bounds.size.y, 0)
				end

				for iter_88_2, iter_88_3 in pairs(arg_85_1.bgs_) do
					if iter_88_2 ~= "ST24" then
						iter_88_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_88_10 = 0

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_11 = 2

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 then
				local var_88_12 = Color.New(0, 0, 0)

				var_88_12.a = Mathf.Lerp(0, 1, (arg_85_1.time_ - var_88_10) / var_88_11)
				arg_85_1.mask_.color = var_88_12
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 then
				local var_88_13 = Color.New(0, 0, 0)

				var_88_13.a = 1
				arg_85_1.mask_.color = var_88_13
			end

			local var_88_14 = 2

			if 2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_14 + arg_88_0 then
				arg_85_1.mask_.enabled = true
				arg_85_1.mask_.raycastTarget = true

				arg_85_1:SetGaussion(false)
			end

			local var_88_15 = 2

			if var_88_14 <= arg_85_1.time_ and arg_85_1.time_ < var_88_14 + var_88_15 then
				local var_88_16 = Color.New(0, 0, 0)

				var_88_16.a = Mathf.Lerp(1, 0, (arg_85_1.time_ - var_88_14) / var_88_15)
				arg_85_1.mask_.color = var_88_16
			end

			if arg_85_1.time_ >= var_88_14 + var_88_15 and arg_85_1.time_ < var_88_14 + var_88_15 + arg_88_0 then
				local var_88_17 = Color.New(0, 0, 0)

				arg_85_1.mask_.enabled = false
				var_88_17.a = 0
				arg_85_1.mask_.color = var_88_17
			end

			if 1 < arg_85_1.time_ and arg_85_1.time_ <= 1 + arg_88_0 then
				arg_85_1:AudioAction("play", "effect", "se_story_activity_1_4_3", "se_story_activity_1_4_3_door", "")
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_19 = 3.45
			local var_88_20 = 0.55

			if 3.45 < arg_85_1.time_ and arg_85_1.time_ <= var_88_19 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_21 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_21:setOnUpdate(LuaHelper.FloatAction(function(arg_89_0)
					arg_85_1.dialogCg_.alpha = arg_89_0
				end))
				var_88_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_22 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(114251021).content)

				arg_85_1.text_.text = var_88_22

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_24 = 22 <= 0 and var_88_20 or var_88_20 * (utf8.len(var_88_22) / 22)

				if (22 <= 0 and var_88_20 or var_88_20 * (utf8.len(var_88_22) / 22)) > 0 and var_88_20 < var_88_24 then
					arg_85_1.talkMaxDuration = var_88_24
					var_88_19 = var_88_19 + 0.3

					if var_88_24 + var_88_19 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_24 + var_88_19
					end
				end

				arg_85_1.text_.text = var_88_22
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = var_88_19 + 0.3
			local var_88_26 = math.max(var_88_20, arg_85_1.talkMaxDuration)

			if var_88_19 + 0.3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_25 + var_88_26 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_25) / var_88_26

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_25 + var_88_26 and arg_85_1.time_ < var_88_25 + var_88_26 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play114251022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 114251022
		arg_91_1.duration_ = 3

		local var_91_0 = {
			ja = 3,
			ko = 1.9,
			zh = 1.7,
			en = 1.533
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
				arg_91_0:Play114251023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10018 = arg_91_1.actors_["10018"].transform.localPosition
				arg_91_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10018", 2)

				for iter_94_0 = 0, arg_91_1.actors_["10018"].transform.childCount - 1 do
					local var_94_0 = arg_91_1.actors_["10018"].transform:GetChild(iter_94_0)

					if var_94_0.name == "split_1" or not string.find(var_94_0.name, "split") then
						var_94_0.gameObject:SetActive(true)
					else
						var_94_0.gameObject:SetActive(false)
					end
				end
			end

			local var_94_1 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_1 then
				arg_91_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (arg_91_1.time_ - 0) / var_94_1)
			end

			if arg_91_1.time_ >= 0 + var_94_1 and arg_91_1.time_ < 0 + var_94_1 + arg_94_0 then
				arg_91_1.actors_["10018"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_94_2 = arg_91_1.actors_["10015"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10015 = var_94_2.localPosition
				var_94_2.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("10015", 4)

				for iter_94_1 = 0, var_94_2.childCount - 1 do
					local var_94_3 = var_94_2:GetChild(iter_94_1)

					if var_94_3.name == "split_5" or not string.find(var_94_3.name, "split") then
						var_94_3.gameObject:SetActive(true)
					else
						var_94_3.gameObject:SetActive(false)
					end
				end
			end

			local var_94_4 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				var_94_2.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_91_1.time_ - 0) / var_94_4)
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				var_94_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_94_5 = arg_91_1.actors_["10018"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_5) and arg_91_1.var_.actorSpriteComps10018 == nil then
				arg_91_1.var_.actorSpriteComps10018 = var_94_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_6 = 0.034

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_6 and not isNil(var_94_5) then
				if arg_91_1.var_.actorSpriteComps10018 then
					for iter_94_2, iter_94_3 in pairs(arg_91_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_94_3 then
							if arg_91_1.isInRecall_ then
								iter_94_3.color = Color.New(Mathf.Lerp(iter_94_3.color.r, arg_91_1.hightColor2.r, (arg_91_1.time_ - 0) / var_94_6), Mathf.Lerp(iter_94_3.color.g, arg_91_1.hightColor2.g, (arg_91_1.time_ - 0) / var_94_6), (Mathf.Lerp(iter_94_3.color.b, arg_91_1.hightColor2.b, (arg_91_1.time_ - 0) / var_94_6)))
							else
								local var_94_7 = Mathf.Lerp(iter_94_3.color.r, 0.5, (arg_91_1.time_ - 0) / var_94_6)

								iter_94_3.color = Color.New(var_94_7, var_94_7, var_94_7)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_6 and arg_91_1.time_ < 0 + var_94_6 + arg_94_0 and not isNil(var_94_5) and arg_91_1.var_.actorSpriteComps10018 then
				for iter_94_4, iter_94_5 in pairs(arg_91_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_94_5 then
						iter_94_5.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_91_1.var_.actorSpriteComps10018 = nil
			end

			local var_94_8 = arg_91_1.actors_["10015"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_8) and arg_91_1.var_.actorSpriteComps10015 == nil then
				arg_91_1.var_.actorSpriteComps10015 = var_94_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_9 = 0.034

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_9 and not isNil(var_94_8) then
				if arg_91_1.var_.actorSpriteComps10015 then
					for iter_94_6, iter_94_7 in pairs(arg_91_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_94_7 then
							if arg_91_1.isInRecall_ then
								iter_94_7.color = Color.New(Mathf.Lerp(iter_94_7.color.r, arg_91_1.hightColor1.r, (arg_91_1.time_ - 0) / var_94_9), Mathf.Lerp(iter_94_7.color.g, arg_91_1.hightColor1.g, (arg_91_1.time_ - 0) / var_94_9), (Mathf.Lerp(iter_94_7.color.b, arg_91_1.hightColor1.b, (arg_91_1.time_ - 0) / var_94_9)))
							else
								local var_94_10 = Mathf.Lerp(iter_94_7.color.r, 1, (arg_91_1.time_ - 0) / var_94_9)

								iter_94_7.color = Color.New(var_94_10, var_94_10, var_94_10)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_9 and arg_91_1.time_ < 0 + var_94_9 + arg_94_0 and not isNil(var_94_8) and arg_91_1.var_.actorSpriteComps10015 then
				for iter_94_8, iter_94_9 in pairs(arg_91_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_94_9 then
						iter_94_9.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_91_1.var_.actorSpriteComps10015 = nil
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				local var_94_11 = arg_91_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_94_11 then
					arg_91_1.var_.alphaOldValue10015 = var_94_11.alpha
					arg_91_1.var_.characterEffect10015 = var_94_11
				end

				arg_91_1.var_.alphaOldValue10015 = 0
			end

			local var_94_12 = 0.5

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_12 then
				if arg_91_1.var_.characterEffect10015 then
					arg_91_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_91_1.var_.alphaOldValue10015, 1, (arg_91_1.time_ - 0) / var_94_12)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_12 and arg_91_1.time_ < 0 + var_94_12 + arg_94_0 and arg_91_1.var_.characterEffect10015 then
				arg_91_1.var_.characterEffect10015.alpha = 1
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				local var_94_13 = arg_91_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_94_13 then
					arg_91_1.var_.alphaOldValue10018 = var_94_13.alpha
					arg_91_1.var_.characterEffect10018 = var_94_13
				end

				arg_91_1.var_.alphaOldValue10018 = 0
			end

			local var_94_14 = 0.5

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_14 then
				if arg_91_1.var_.characterEffect10018 then
					arg_91_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_91_1.var_.alphaOldValue10018, 1, (arg_91_1.time_ - 0) / var_94_14)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_14 and arg_91_1.time_ < 0 + var_94_14 + arg_94_0 and arg_91_1.var_.characterEffect10018 then
				arg_91_1.var_.characterEffect10018.alpha = 1
			end

			local var_94_15 = 0
			local var_94_16 = 0.125

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_15 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_17 = arg_91_1:GetWordFromCfg(114251022)
				local var_94_18 = arg_91_1:FormatText(var_94_17.content)

				arg_91_1.text_.text = var_94_18

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_20 = 5 <= 0 and var_94_16 or var_94_16 * (utf8.len(var_94_18) / 5)

				if (5 <= 0 and var_94_16 or var_94_16 * (utf8.len(var_94_18) / 5)) > 0 and var_94_16 < var_94_20 then
					arg_91_1.talkMaxDuration = var_94_20

					if var_94_20 + var_94_15 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_20 + var_94_15
					end
				end

				arg_91_1.text_.text = var_94_18
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251022", "story_v_out_114251.awb") ~= 0 then
					local var_94_21 = manager.audio:GetVoiceLength("story_v_out_114251", "114251022", "story_v_out_114251.awb") / 1000

					if var_94_21 + var_94_15 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_21 + var_94_15
					end

					if var_94_17.prefab_name ~= "" and arg_91_1.actors_[var_94_17.prefab_name] ~= nil then
						local var_94_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_17.prefab_name].transform, "story_v_out_114251", "114251022", "story_v_out_114251.awb")

						arg_91_1:RecordAudio("114251022", var_94_22)
						arg_91_1:RecordAudio("114251022", var_94_22)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_114251", "114251022", "story_v_out_114251.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_114251", "114251022", "story_v_out_114251.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_23 = math.max(var_94_16, arg_91_1.talkMaxDuration)

			if var_94_15 <= arg_91_1.time_ and arg_91_1.time_ < var_94_15 + var_94_23 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_15) / var_94_23

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_15 + var_94_23 and arg_91_1.time_ < var_94_15 + var_94_23 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_91_1:InitPlayNodeList()
	end,
	Play114251023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 114251023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play114251024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["10015"]) and arg_95_1.var_.actorSpriteComps10015 == nil then
				arg_95_1.var_.actorSpriteComps10015 = arg_95_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_0 = 0.034

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["10015"]) then
				if arg_95_1.var_.actorSpriteComps10015 then
					for iter_98_0, iter_98_1 in pairs(arg_95_1.var_.actorSpriteComps10015:ToTable()) do
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

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["10015"]) and arg_95_1.var_.actorSpriteComps10015 then
				for iter_98_2, iter_98_3 in pairs(arg_95_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_98_3 then
						iter_98_3.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_95_1.var_.actorSpriteComps10015 = nil
			end

			local var_98_2 = 0
			local var_98_3 = 0.65

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_2 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_4 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(114251023).content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_6 = 26 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_4) / 26)

				if (26 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_4) / 26)) > 0 and var_98_3 < var_98_6 then
					arg_95_1.talkMaxDuration = var_98_6

					if var_98_6 + var_98_2 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_6 + var_98_2
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_3, arg_95_1.talkMaxDuration)

			if var_98_2 <= arg_95_1.time_ and arg_95_1.time_ < var_98_2 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_2) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_2 + var_98_7 and arg_95_1.time_ < var_98_2 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play114251024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 114251024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play114251025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 1.1

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(114251024).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 43 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 43)

				if (43 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 43)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play114251025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 114251025
		arg_103_1.duration_ = 3.5

		local var_103_0 = {
			ja = 1.833,
			ko = 2.866,
			zh = 3.166,
			en = 3.5
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
				arg_103_0:Play114251026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["10018"]) and arg_103_1.var_.actorSpriteComps10018 == nil then
				arg_103_1.var_.actorSpriteComps10018 = arg_103_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_0 = 0.034

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["10018"]) then
				if arg_103_1.var_.actorSpriteComps10018 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["10018"]) and arg_103_1.var_.actorSpriteComps10018 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_106_3 then
						iter_106_3.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_103_1.var_.actorSpriteComps10018 = nil
			end

			local var_106_2 = 0
			local var_106_3 = 0.275

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_2 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_4 = arg_103_1:GetWordFromCfg(114251025)
				local var_106_5 = arg_103_1:FormatText(var_106_4.content)

				arg_103_1.text_.text = var_106_5

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_7 = 11 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 11)

				if (11 <= 0 and var_106_3 or var_106_3 * (utf8.len(var_106_5) / 11)) > 0 and var_106_3 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_2
					end
				end

				arg_103_1.text_.text = var_106_5
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251025", "story_v_out_114251.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251025", "story_v_out_114251.awb") / 1000

					if var_106_8 + var_106_2 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_2
					end

					if var_106_4.prefab_name ~= "" and arg_103_1.actors_[var_106_4.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_4.prefab_name].transform, "story_v_out_114251", "114251025", "story_v_out_114251.awb")

						arg_103_1:RecordAudio("114251025", var_106_9)
						arg_103_1:RecordAudio("114251025", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_114251", "114251025", "story_v_out_114251.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_114251", "114251025", "story_v_out_114251.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_3, arg_103_1.talkMaxDuration)

			if var_106_2 <= arg_103_1.time_ and arg_103_1.time_ < var_106_2 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_2) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_2 + var_106_10 and arg_103_1.time_ < var_106_2 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play114251026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 114251026
		arg_107_1.duration_ = 9.53

		local var_107_0 = {
			ja = 9.533,
			ko = 5.233,
			zh = 5.033,
			en = 3.5
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
				arg_107_0:Play114251027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["10018"]) and arg_107_1.var_.actorSpriteComps10018 == nil then
				arg_107_1.var_.actorSpriteComps10018 = arg_107_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_0 = 0.034

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["10018"]) then
				if arg_107_1.var_.actorSpriteComps10018 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_110_1 then
							if arg_107_1.isInRecall_ then
								iter_110_1.color = Color.New(Mathf.Lerp(iter_110_1.color.r, arg_107_1.hightColor2.r, (arg_107_1.time_ - 0) / var_110_0), Mathf.Lerp(iter_110_1.color.g, arg_107_1.hightColor2.g, (arg_107_1.time_ - 0) / var_110_0), (Mathf.Lerp(iter_110_1.color.b, arg_107_1.hightColor2.b, (arg_107_1.time_ - 0) / var_110_0)))
							else
								local var_110_1 = Mathf.Lerp(iter_110_1.color.r, 0.5, (arg_107_1.time_ - 0) / var_110_0)

								iter_110_1.color = Color.New(var_110_1, var_110_1, var_110_1)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["10018"]) and arg_107_1.var_.actorSpriteComps10018 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_110_3 then
						iter_110_3.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_107_1.var_.actorSpriteComps10018 = nil
			end

			local var_110_2 = arg_107_1.actors_["10015"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.actorSpriteComps10015 == nil then
				arg_107_1.var_.actorSpriteComps10015 = var_110_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_3 = 0.034

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_3 and not isNil(var_110_2) then
				if arg_107_1.var_.actorSpriteComps10015 then
					for iter_110_4, iter_110_5 in pairs(arg_107_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_110_5 then
							if arg_107_1.isInRecall_ then
								iter_110_5.color = Color.New(Mathf.Lerp(iter_110_5.color.r, arg_107_1.hightColor1.r, (arg_107_1.time_ - 0) / var_110_3), Mathf.Lerp(iter_110_5.color.g, arg_107_1.hightColor1.g, (arg_107_1.time_ - 0) / var_110_3), (Mathf.Lerp(iter_110_5.color.b, arg_107_1.hightColor1.b, (arg_107_1.time_ - 0) / var_110_3)))
							else
								local var_110_4 = Mathf.Lerp(iter_110_5.color.r, 1, (arg_107_1.time_ - 0) / var_110_3)

								iter_110_5.color = Color.New(var_110_4, var_110_4, var_110_4)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_3 and arg_107_1.time_ < 0 + var_110_3 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.actorSpriteComps10015 then
				for iter_110_6, iter_110_7 in pairs(arg_107_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_110_7 then
						iter_110_7.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_107_1.var_.actorSpriteComps10015 = nil
			end

			local var_110_5 = 0
			local var_110_6 = 0.45

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_7 = arg_107_1:GetWordFromCfg(114251026)
				local var_110_8 = arg_107_1:FormatText(var_110_7.content)

				arg_107_1.text_.text = var_110_8

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_10 = 18 <= 0 and var_110_6 or var_110_6 * (utf8.len(var_110_8) / 18)

				if (18 <= 0 and var_110_6 or var_110_6 * (utf8.len(var_110_8) / 18)) > 0 and var_110_6 < var_110_10 then
					arg_107_1.talkMaxDuration = var_110_10

					if var_110_10 + var_110_5 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_5
					end
				end

				arg_107_1.text_.text = var_110_8
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251026", "story_v_out_114251.awb") ~= 0 then
					local var_110_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251026", "story_v_out_114251.awb") / 1000

					if var_110_11 + var_110_5 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_11 + var_110_5
					end

					if var_110_7.prefab_name ~= "" and arg_107_1.actors_[var_110_7.prefab_name] ~= nil then
						local var_110_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_7.prefab_name].transform, "story_v_out_114251", "114251026", "story_v_out_114251.awb")

						arg_107_1:RecordAudio("114251026", var_110_12)
						arg_107_1:RecordAudio("114251026", var_110_12)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_114251", "114251026", "story_v_out_114251.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_114251", "114251026", "story_v_out_114251.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_13 = math.max(var_110_6, arg_107_1.talkMaxDuration)

			if var_110_5 <= arg_107_1.time_ and arg_107_1.time_ < var_110_5 + var_110_13 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_5) / var_110_13

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_5 + var_110_13 and arg_107_1.time_ < var_110_5 + var_110_13 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play114251027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 114251027
		arg_111_1.duration_ = 11.9

		local var_111_0 = {
			ja = 11.366,
			ko = 11.3,
			zh = 11.9,
			en = 11.8
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
				arg_111_0:Play114251028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["10018"]) and arg_111_1.var_.actorSpriteComps10018 == nil then
				arg_111_1.var_.actorSpriteComps10018 = arg_111_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_0 = 0.034

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["10018"]) then
				if arg_111_1.var_.actorSpriteComps10018 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								iter_114_1.color = Color.New(Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor1.r, (arg_111_1.time_ - 0) / var_114_0), Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor1.g, (arg_111_1.time_ - 0) / var_114_0), (Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor1.b, (arg_111_1.time_ - 0) / var_114_0)))
							else
								local var_114_1 = Mathf.Lerp(iter_114_1.color.r, 1, (arg_111_1.time_ - 0) / var_114_0)

								iter_114_1.color = Color.New(var_114_1, var_114_1, var_114_1)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["10018"]) and arg_111_1.var_.actorSpriteComps10018 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_114_3 then
						iter_114_3.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_111_1.var_.actorSpriteComps10018 = nil
			end

			local var_114_2 = arg_111_1.actors_["10015"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps10015 == nil then
				arg_111_1.var_.actorSpriteComps10015 = var_114_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_3 = 0.034

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_3 and not isNil(var_114_2) then
				if arg_111_1.var_.actorSpriteComps10015 then
					for iter_114_4, iter_114_5 in pairs(arg_111_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_114_5 then
							if arg_111_1.isInRecall_ then
								iter_114_5.color = Color.New(Mathf.Lerp(iter_114_5.color.r, arg_111_1.hightColor2.r, (arg_111_1.time_ - 0) / var_114_3), Mathf.Lerp(iter_114_5.color.g, arg_111_1.hightColor2.g, (arg_111_1.time_ - 0) / var_114_3), (Mathf.Lerp(iter_114_5.color.b, arg_111_1.hightColor2.b, (arg_111_1.time_ - 0) / var_114_3)))
							else
								local var_114_4 = Mathf.Lerp(iter_114_5.color.r, 0.5, (arg_111_1.time_ - 0) / var_114_3)

								iter_114_5.color = Color.New(var_114_4, var_114_4, var_114_4)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_3 and arg_111_1.time_ < 0 + var_114_3 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps10015 then
				for iter_114_6, iter_114_7 in pairs(arg_111_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_114_7 then
						iter_114_7.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_111_1.var_.actorSpriteComps10015 = nil
			end

			local var_114_5 = 0
			local var_114_6 = 1.15

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_7 = arg_111_1:GetWordFromCfg(114251027)
				local var_114_8 = arg_111_1:FormatText(var_114_7.content)

				arg_111_1.text_.text = var_114_8

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_10 = 46 <= 0 and var_114_6 or var_114_6 * (utf8.len(var_114_8) / 46)

				if (46 <= 0 and var_114_6 or var_114_6 * (utf8.len(var_114_8) / 46)) > 0 and var_114_6 < var_114_10 then
					arg_111_1.talkMaxDuration = var_114_10

					if var_114_10 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_5
					end
				end

				arg_111_1.text_.text = var_114_8
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251027", "story_v_out_114251.awb") ~= 0 then
					local var_114_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251027", "story_v_out_114251.awb") / 1000

					if var_114_11 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_5
					end

					if var_114_7.prefab_name ~= "" and arg_111_1.actors_[var_114_7.prefab_name] ~= nil then
						local var_114_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_7.prefab_name].transform, "story_v_out_114251", "114251027", "story_v_out_114251.awb")

						arg_111_1:RecordAudio("114251027", var_114_12)
						arg_111_1:RecordAudio("114251027", var_114_12)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_114251", "114251027", "story_v_out_114251.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_114251", "114251027", "story_v_out_114251.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_13 = math.max(var_114_6, arg_111_1.talkMaxDuration)

			if var_114_5 <= arg_111_1.time_ and arg_111_1.time_ < var_114_5 + var_114_13 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_5) / var_114_13

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_5 + var_114_13 and arg_111_1.time_ < var_114_5 + var_114_13 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play114251028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 114251028
		arg_115_1.duration_ = 9.6

		local var_115_0 = {
			ja = 9.6,
			ko = 9.133,
			zh = 9.066,
			en = 9.4
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
				arg_115_0:Play114251029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.975

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:GetWordFromCfg(114251028)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 39 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 39)

				if (39 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 39)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251028", "story_v_out_114251.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_out_114251", "114251028", "story_v_out_114251.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_out_114251", "114251028", "story_v_out_114251.awb")

						arg_115_1:RecordAudio("114251028", var_118_6)
						arg_115_1:RecordAudio("114251028", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_114251", "114251028", "story_v_out_114251.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_114251", "114251028", "story_v_out_114251.awb")
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
	Play114251029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 114251029
		arg_119_1.duration_ = 4.73

		local var_119_0 = {
			ja = 4.233,
			ko = 3.966,
			zh = 4.1,
			en = 4.733
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
				arg_119_0:Play114251030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(arg_119_1.actors_["10015"]) and arg_119_1.var_.actorSpriteComps10015 == nil then
				arg_119_1.var_.actorSpriteComps10015 = arg_119_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_0 = 0.034

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 and not isNil(arg_119_1.actors_["10015"]) then
				if arg_119_1.var_.actorSpriteComps10015 then
					for iter_122_0, iter_122_1 in pairs(arg_119_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_122_1 then
							if arg_119_1.isInRecall_ then
								iter_122_1.color = Color.New(Mathf.Lerp(iter_122_1.color.r, arg_119_1.hightColor1.r, (arg_119_1.time_ - 0) / var_122_0), Mathf.Lerp(iter_122_1.color.g, arg_119_1.hightColor1.g, (arg_119_1.time_ - 0) / var_122_0), (Mathf.Lerp(iter_122_1.color.b, arg_119_1.hightColor1.b, (arg_119_1.time_ - 0) / var_122_0)))
							else
								local var_122_1 = Mathf.Lerp(iter_122_1.color.r, 1, (arg_119_1.time_ - 0) / var_122_0)

								iter_122_1.color = Color.New(var_122_1, var_122_1, var_122_1)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 and not isNil(arg_119_1.actors_["10015"]) and arg_119_1.var_.actorSpriteComps10015 then
				for iter_122_2, iter_122_3 in pairs(arg_119_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_122_3 then
						iter_122_3.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps10015 = nil
			end

			local var_122_2 = arg_119_1.actors_["10018"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10018 == nil then
				arg_119_1.var_.actorSpriteComps10018 = var_122_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_3 = 0.034

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.actorSpriteComps10018 then
					for iter_122_4, iter_122_5 in pairs(arg_119_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_122_5 then
							if arg_119_1.isInRecall_ then
								iter_122_5.color = Color.New(Mathf.Lerp(iter_122_5.color.r, arg_119_1.hightColor2.r, (arg_119_1.time_ - 0) / var_122_3), Mathf.Lerp(iter_122_5.color.g, arg_119_1.hightColor2.g, (arg_119_1.time_ - 0) / var_122_3), (Mathf.Lerp(iter_122_5.color.b, arg_119_1.hightColor2.b, (arg_119_1.time_ - 0) / var_122_3)))
							else
								local var_122_4 = Mathf.Lerp(iter_122_5.color.r, 0.5, (arg_119_1.time_ - 0) / var_122_3)

								iter_122_5.color = Color.New(var_122_4, var_122_4, var_122_4)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps10018 then
				for iter_122_6, iter_122_7 in pairs(arg_119_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_122_7 then
						iter_122_7.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_119_1.var_.actorSpriteComps10018 = nil
			end

			local var_122_5 = 0
			local var_122_6 = 0.475

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_7 = arg_119_1:GetWordFromCfg(114251029)
				local var_122_8 = arg_119_1:FormatText(var_122_7.content)

				arg_119_1.text_.text = var_122_8

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_10 = 19 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 19)

				if (19 <= 0 and var_122_6 or var_122_6 * (utf8.len(var_122_8) / 19)) > 0 and var_122_6 < var_122_10 then
					arg_119_1.talkMaxDuration = var_122_10

					if var_122_10 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_5
					end
				end

				arg_119_1.text_.text = var_122_8
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251029", "story_v_out_114251.awb") ~= 0 then
					local var_122_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251029", "story_v_out_114251.awb") / 1000

					if var_122_11 + var_122_5 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_5
					end

					if var_122_7.prefab_name ~= "" and arg_119_1.actors_[var_122_7.prefab_name] ~= nil then
						local var_122_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_7.prefab_name].transform, "story_v_out_114251", "114251029", "story_v_out_114251.awb")

						arg_119_1:RecordAudio("114251029", var_122_12)
						arg_119_1:RecordAudio("114251029", var_122_12)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_114251", "114251029", "story_v_out_114251.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_114251", "114251029", "story_v_out_114251.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_13 = math.max(var_122_6, arg_119_1.talkMaxDuration)

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_13 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_5) / var_122_13

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_5 + var_122_13 and arg_119_1.time_ < var_122_5 + var_122_13 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play114251030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 114251030
		arg_123_1.duration_ = 4.7

		local var_123_0 = {
			ja = 4.7,
			ko = 3.566,
			zh = 3.833,
			en = 3.733
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play114251031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["10018"]) and arg_123_1.var_.actorSpriteComps10018 == nil then
				arg_123_1.var_.actorSpriteComps10018 = arg_123_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_0 = 0.034

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["10018"]) then
				if arg_123_1.var_.actorSpriteComps10018 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								iter_126_1.color = Color.New(Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor1.r, (arg_123_1.time_ - 0) / var_126_0), Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor1.g, (arg_123_1.time_ - 0) / var_126_0), (Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor1.b, (arg_123_1.time_ - 0) / var_126_0)))
							else
								local var_126_1 = Mathf.Lerp(iter_126_1.color.r, 1, (arg_123_1.time_ - 0) / var_126_0)

								iter_126_1.color = Color.New(var_126_1, var_126_1, var_126_1)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["10018"]) and arg_123_1.var_.actorSpriteComps10018 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_126_3 then
						iter_126_3.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_123_1.var_.actorSpriteComps10018 = nil
			end

			local var_126_2 = arg_123_1.actors_["10015"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps10015 == nil then
				arg_123_1.var_.actorSpriteComps10015 = var_126_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_3 = 0.034

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.actorSpriteComps10015 then
					for iter_126_4, iter_126_5 in pairs(arg_123_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_126_5 then
							if arg_123_1.isInRecall_ then
								iter_126_5.color = Color.New(Mathf.Lerp(iter_126_5.color.r, arg_123_1.hightColor2.r, (arg_123_1.time_ - 0) / var_126_3), Mathf.Lerp(iter_126_5.color.g, arg_123_1.hightColor2.g, (arg_123_1.time_ - 0) / var_126_3), (Mathf.Lerp(iter_126_5.color.b, arg_123_1.hightColor2.b, (arg_123_1.time_ - 0) / var_126_3)))
							else
								local var_126_4 = Mathf.Lerp(iter_126_5.color.r, 0.5, (arg_123_1.time_ - 0) / var_126_3)

								iter_126_5.color = Color.New(var_126_4, var_126_4, var_126_4)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps10015 then
				for iter_126_6, iter_126_7 in pairs(arg_123_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_126_7 then
						iter_126_7.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps10015 = nil
			end

			local var_126_5 = 0
			local var_126_6 = 0.375

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_7 = arg_123_1:GetWordFromCfg(114251030)
				local var_126_8 = arg_123_1:FormatText(var_126_7.content)

				arg_123_1.text_.text = var_126_8

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_10 = 15 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_8) / 15)

				if (15 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_8) / 15)) > 0 and var_126_6 < var_126_10 then
					arg_123_1.talkMaxDuration = var_126_10

					if var_126_10 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_5
					end
				end

				arg_123_1.text_.text = var_126_8
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251030", "story_v_out_114251.awb") ~= 0 then
					local var_126_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251030", "story_v_out_114251.awb") / 1000

					if var_126_11 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_11 + var_126_5
					end

					if var_126_7.prefab_name ~= "" and arg_123_1.actors_[var_126_7.prefab_name] ~= nil then
						local var_126_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_7.prefab_name].transform, "story_v_out_114251", "114251030", "story_v_out_114251.awb")

						arg_123_1:RecordAudio("114251030", var_126_12)
						arg_123_1:RecordAudio("114251030", var_126_12)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_114251", "114251030", "story_v_out_114251.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_114251", "114251030", "story_v_out_114251.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_13 = math.max(var_126_6, arg_123_1.talkMaxDuration)

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_13 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_5) / var_126_13

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_5 + var_126_13 and arg_123_1.time_ < var_126_5 + var_126_13 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play114251031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 114251031
		arg_127_1.duration_ = 2.87

		local var_127_0 = {
			ja = 2.866,
			ko = 1.633,
			zh = 2.333,
			en = 1.833
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
				arg_127_0:Play114251032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10015 = arg_127_1.actors_["10015"].transform.localPosition
				arg_127_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10015", 4)

				for iter_130_0 = 0, arg_127_1.actors_["10015"].transform.childCount - 1 do
					local var_130_0 = arg_127_1.actors_["10015"].transform:GetChild(iter_130_0)

					if var_130_0.name == "split_1" or not string.find(var_130_0.name, "split") then
						var_130_0.gameObject:SetActive(true)
					else
						var_130_0.gameObject:SetActive(false)
					end
				end
			end

			local var_130_1 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_1 then
				arg_127_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_127_1.time_ - 0) / var_130_1)
			end

			if arg_127_1.time_ >= 0 + var_130_1 and arg_127_1.time_ < 0 + var_130_1 + arg_130_0 then
				arg_127_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_130_2 = arg_127_1.actors_["10018"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps10018 == nil then
				arg_127_1.var_.actorSpriteComps10018 = var_130_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_3 = 0.034

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_3 and not isNil(var_130_2) then
				if arg_127_1.var_.actorSpriteComps10018 then
					for iter_130_1, iter_130_2 in pairs(arg_127_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_130_2 then
							if arg_127_1.isInRecall_ then
								iter_130_2.color = Color.New(Mathf.Lerp(iter_130_2.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_3), Mathf.Lerp(iter_130_2.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_3), (Mathf.Lerp(iter_130_2.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_3)))
							else
								local var_130_4 = Mathf.Lerp(iter_130_2.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_3)

								iter_130_2.color = Color.New(var_130_4, var_130_4, var_130_4)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_3 and arg_127_1.time_ < 0 + var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps10018 then
				for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_130_4 then
						iter_130_4.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps10018 = nil
			end

			local var_130_5 = arg_127_1.actors_["10015"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.actorSpriteComps10015 == nil then
				arg_127_1.var_.actorSpriteComps10015 = var_130_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_6 = 0.034

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_6 and not isNil(var_130_5) then
				if arg_127_1.var_.actorSpriteComps10015 then
					for iter_130_5, iter_130_6 in pairs(arg_127_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_130_6 then
							if arg_127_1.isInRecall_ then
								iter_130_6.color = Color.New(Mathf.Lerp(iter_130_6.color.r, arg_127_1.hightColor1.r, (arg_127_1.time_ - 0) / var_130_6), Mathf.Lerp(iter_130_6.color.g, arg_127_1.hightColor1.g, (arg_127_1.time_ - 0) / var_130_6), (Mathf.Lerp(iter_130_6.color.b, arg_127_1.hightColor1.b, (arg_127_1.time_ - 0) / var_130_6)))
							else
								local var_130_7 = Mathf.Lerp(iter_130_6.color.r, 1, (arg_127_1.time_ - 0) / var_130_6)

								iter_130_6.color = Color.New(var_130_7, var_130_7, var_130_7)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_6 and arg_127_1.time_ < 0 + var_130_6 + arg_130_0 and not isNil(var_130_5) and arg_127_1.var_.actorSpriteComps10015 then
				for iter_130_7, iter_130_8 in pairs(arg_127_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_130_8 then
						iter_130_8.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps10015 = nil
			end

			local var_130_8 = 0
			local var_130_9 = 0.225

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_10 = arg_127_1:GetWordFromCfg(114251031)
				local var_130_11 = arg_127_1:FormatText(var_130_10.content)

				arg_127_1.text_.text = var_130_11

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_13 = 9 <= 0 and var_130_9 or var_130_9 * (utf8.len(var_130_11) / 9)

				if (9 <= 0 and var_130_9 or var_130_9 * (utf8.len(var_130_11) / 9)) > 0 and var_130_9 < var_130_13 then
					arg_127_1.talkMaxDuration = var_130_13

					if var_130_13 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_8
					end
				end

				arg_127_1.text_.text = var_130_11
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251031", "story_v_out_114251.awb") ~= 0 then
					local var_130_14 = manager.audio:GetVoiceLength("story_v_out_114251", "114251031", "story_v_out_114251.awb") / 1000

					if var_130_14 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_14 + var_130_8
					end

					if var_130_10.prefab_name ~= "" and arg_127_1.actors_[var_130_10.prefab_name] ~= nil then
						local var_130_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_10.prefab_name].transform, "story_v_out_114251", "114251031", "story_v_out_114251.awb")

						arg_127_1:RecordAudio("114251031", var_130_15)
						arg_127_1:RecordAudio("114251031", var_130_15)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_114251", "114251031", "story_v_out_114251.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_114251", "114251031", "story_v_out_114251.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_16 = math.max(var_130_9, arg_127_1.talkMaxDuration)

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_16 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_8) / var_130_16

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_8 + var_130_16 and arg_127_1.time_ < var_130_8 + var_130_16 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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

		arg_127_1:InitPlayNodeList()
	end,
	Play114251032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 114251032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play114251033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["10015"]) and arg_131_1.var_.actorSpriteComps10015 == nil then
				arg_131_1.var_.actorSpriteComps10015 = arg_131_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_0 = 0.034

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["10015"]) then
				if arg_131_1.var_.actorSpriteComps10015 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_134_1 then
							if arg_131_1.isInRecall_ then
								iter_134_1.color = Color.New(Mathf.Lerp(iter_134_1.color.r, arg_131_1.hightColor2.r, (arg_131_1.time_ - 0) / var_134_0), Mathf.Lerp(iter_134_1.color.g, arg_131_1.hightColor2.g, (arg_131_1.time_ - 0) / var_134_0), (Mathf.Lerp(iter_134_1.color.b, arg_131_1.hightColor2.b, (arg_131_1.time_ - 0) / var_134_0)))
							else
								local var_134_1 = Mathf.Lerp(iter_134_1.color.r, 0.5, (arg_131_1.time_ - 0) / var_134_0)

								iter_134_1.color = Color.New(var_134_1, var_134_1, var_134_1)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["10015"]) and arg_131_1.var_.actorSpriteComps10015 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_134_3 then
						iter_134_3.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_131_1.var_.actorSpriteComps10015 = nil
			end

			local var_134_2 = 0
			local var_134_3 = 0.4

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_4 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(114251032).content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_6 = 16 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_4) / 16)

				if (16 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_4) / 16)) > 0 and var_134_3 < var_134_6 then
					arg_131_1.talkMaxDuration = var_134_6

					if var_134_6 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_6 + var_134_2
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_3, arg_131_1.talkMaxDuration)

			if var_134_2 <= arg_131_1.time_ and arg_131_1.time_ < var_134_2 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_2) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_2 + var_134_7 and arg_131_1.time_ < var_134_2 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play114251033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 114251033
		arg_135_1.duration_ = 12.73

		local var_135_0 = {
			ja = 12.166,
			ko = 11.8,
			zh = 11.433,
			en = 12.733
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
				arg_135_0:Play114251034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10018 = arg_135_1.actors_["10018"].transform.localPosition
				arg_135_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10018", 2)

				for iter_138_0 = 0, arg_135_1.actors_["10018"].transform.childCount - 1 do
					local var_138_0 = arg_135_1.actors_["10018"].transform:GetChild(iter_138_0)

					if var_138_0.name == "split_2" or not string.find(var_138_0.name, "split") then
						var_138_0.gameObject:SetActive(true)
					else
						var_138_0.gameObject:SetActive(false)
					end
				end
			end

			local var_138_1 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_1 then
				arg_135_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (arg_135_1.time_ - 0) / var_138_1)
			end

			if arg_135_1.time_ >= 0 + var_138_1 and arg_135_1.time_ < 0 + var_138_1 + arg_138_0 then
				arg_135_1.actors_["10018"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_138_2 = arg_135_1.actors_["10018"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps10018 == nil then
				arg_135_1.var_.actorSpriteComps10018 = var_138_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_3 = 0.034

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.actorSpriteComps10018 then
					for iter_138_1, iter_138_2 in pairs(arg_135_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_138_2 then
							if arg_135_1.isInRecall_ then
								iter_138_2.color = Color.New(Mathf.Lerp(iter_138_2.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_3), Mathf.Lerp(iter_138_2.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_3), (Mathf.Lerp(iter_138_2.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_3)))
							else
								local var_138_4 = Mathf.Lerp(iter_138_2.color.r, 1, (arg_135_1.time_ - 0) / var_138_3)

								iter_138_2.color = Color.New(var_138_4, var_138_4, var_138_4)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps10018 then
				for iter_138_3, iter_138_4 in pairs(arg_135_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_138_4 then
						iter_138_4.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps10018 = nil
			end

			local var_138_5 = 0
			local var_138_6 = 1.3

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_7 = arg_135_1:GetWordFromCfg(114251033)
				local var_138_8 = arg_135_1:FormatText(var_138_7.content)

				arg_135_1.text_.text = var_138_8

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_10 = 52 <= 0 and var_138_6 or var_138_6 * (utf8.len(var_138_8) / 52)

				if (52 <= 0 and var_138_6 or var_138_6 * (utf8.len(var_138_8) / 52)) > 0 and var_138_6 < var_138_10 then
					arg_135_1.talkMaxDuration = var_138_10

					if var_138_10 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_5
					end
				end

				arg_135_1.text_.text = var_138_8
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251033", "story_v_out_114251.awb") ~= 0 then
					local var_138_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251033", "story_v_out_114251.awb") / 1000

					if var_138_11 + var_138_5 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_11 + var_138_5
					end

					if var_138_7.prefab_name ~= "" and arg_135_1.actors_[var_138_7.prefab_name] ~= nil then
						local var_138_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_7.prefab_name].transform, "story_v_out_114251", "114251033", "story_v_out_114251.awb")

						arg_135_1:RecordAudio("114251033", var_138_12)
						arg_135_1:RecordAudio("114251033", var_138_12)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_114251", "114251033", "story_v_out_114251.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_114251", "114251033", "story_v_out_114251.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_13 = math.max(var_138_6, arg_135_1.talkMaxDuration)

			if var_138_5 <= arg_135_1.time_ and arg_135_1.time_ < var_138_5 + var_138_13 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_5) / var_138_13

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_5 + var_138_13 and arg_135_1.time_ < var_138_5 + var_138_13 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play114251034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 114251034
		arg_139_1.duration_ = 6.9

		local var_139_0 = {
			ja = 6.066,
			ko = 6.833,
			zh = 5.7,
			en = 6.9
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
				arg_139_0:Play114251035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10015 = arg_139_1.actors_["10015"].transform.localPosition
				arg_139_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("10015", 4)

				for iter_142_0 = 0, arg_139_1.actors_["10015"].transform.childCount - 1 do
					local var_142_0 = arg_139_1.actors_["10015"].transform:GetChild(iter_142_0)

					if var_142_0.name == "split_1" or not string.find(var_142_0.name, "split") then
						var_142_0.gameObject:SetActive(true)
					else
						var_142_0.gameObject:SetActive(false)
					end
				end
			end

			local var_142_1 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_1 then
				arg_139_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_139_1.time_ - 0) / var_142_1)
			end

			if arg_139_1.time_ >= 0 + var_142_1 and arg_139_1.time_ < 0 + var_142_1 + arg_142_0 then
				arg_139_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_142_2 = arg_139_1.actors_["10018"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps10018 == nil then
				arg_139_1.var_.actorSpriteComps10018 = var_142_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_3 = 0.034

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_3 and not isNil(var_142_2) then
				if arg_139_1.var_.actorSpriteComps10018 then
					for iter_142_1, iter_142_2 in pairs(arg_139_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_142_2 then
							if arg_139_1.isInRecall_ then
								iter_142_2.color = Color.New(Mathf.Lerp(iter_142_2.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_3), Mathf.Lerp(iter_142_2.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_3), (Mathf.Lerp(iter_142_2.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_3)))
							else
								local var_142_4 = Mathf.Lerp(iter_142_2.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_3)

								iter_142_2.color = Color.New(var_142_4, var_142_4, var_142_4)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_3 and arg_139_1.time_ < 0 + var_142_3 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps10018 then
				for iter_142_3, iter_142_4 in pairs(arg_139_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_142_4 then
						iter_142_4.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps10018 = nil
			end

			local var_142_5 = arg_139_1.actors_["10015"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.actorSpriteComps10015 == nil then
				arg_139_1.var_.actorSpriteComps10015 = var_142_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_6 = 0.034

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_6 and not isNil(var_142_5) then
				if arg_139_1.var_.actorSpriteComps10015 then
					for iter_142_5, iter_142_6 in pairs(arg_139_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_142_6 then
							if arg_139_1.isInRecall_ then
								iter_142_6.color = Color.New(Mathf.Lerp(iter_142_6.color.r, arg_139_1.hightColor1.r, (arg_139_1.time_ - 0) / var_142_6), Mathf.Lerp(iter_142_6.color.g, arg_139_1.hightColor1.g, (arg_139_1.time_ - 0) / var_142_6), (Mathf.Lerp(iter_142_6.color.b, arg_139_1.hightColor1.b, (arg_139_1.time_ - 0) / var_142_6)))
							else
								local var_142_7 = Mathf.Lerp(iter_142_6.color.r, 1, (arg_139_1.time_ - 0) / var_142_6)

								iter_142_6.color = Color.New(var_142_7, var_142_7, var_142_7)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_6 and arg_139_1.time_ < 0 + var_142_6 + arg_142_0 and not isNil(var_142_5) and arg_139_1.var_.actorSpriteComps10015 then
				for iter_142_7, iter_142_8 in pairs(arg_139_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_142_8 then
						iter_142_8.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps10015 = nil
			end

			local var_142_8 = 0
			local var_142_9 = 0.65

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(114251034)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 26 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 26)

				if (26 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 26)) > 0 and var_142_9 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251034", "story_v_out_114251.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_114251", "114251034", "story_v_out_114251.awb") / 1000

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end

					if var_142_10.prefab_name ~= "" and arg_139_1.actors_[var_142_10.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_10.prefab_name].transform, "story_v_out_114251", "114251034", "story_v_out_114251.awb")

						arg_139_1:RecordAudio("114251034", var_142_15)
						arg_139_1:RecordAudio("114251034", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_114251", "114251034", "story_v_out_114251.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_114251", "114251034", "story_v_out_114251.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_9, arg_139_1.talkMaxDuration)

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_8) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_8 + var_142_16 and arg_139_1.time_ < var_142_8 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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

		arg_139_1:InitPlayNodeList()
	end,
	Play114251035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 114251035
		arg_143_1.duration_ = 9.37

		local var_143_0 = {
			ja = 9.366,
			ko = 6.733,
			zh = 4.966,
			en = 5.333
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play114251036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0.55

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_1 = arg_143_1:GetWordFromCfg(114251035)
				local var_146_2 = arg_143_1:FormatText(var_146_1.content)

				arg_143_1.text_.text = var_146_2

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_4 = 22 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 22)

				if (22 <= 0 and var_146_0 or var_146_0 * (utf8.len(var_146_2) / 22)) > 0 and var_146_0 < var_146_4 then
					arg_143_1.talkMaxDuration = var_146_4

					if var_146_4 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_4 + 0
					end
				end

				arg_143_1.text_.text = var_146_2
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251035", "story_v_out_114251.awb") ~= 0 then
					local var_146_5 = manager.audio:GetVoiceLength("story_v_out_114251", "114251035", "story_v_out_114251.awb") / 1000

					if var_146_5 + 0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + 0
					end

					if var_146_1.prefab_name ~= "" and arg_143_1.actors_[var_146_1.prefab_name] ~= nil then
						local var_146_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_1.prefab_name].transform, "story_v_out_114251", "114251035", "story_v_out_114251.awb")

						arg_143_1:RecordAudio("114251035", var_146_6)
						arg_143_1:RecordAudio("114251035", var_146_6)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_114251", "114251035", "story_v_out_114251.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_114251", "114251035", "story_v_out_114251.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_7 = math.max(var_146_0, arg_143_1.talkMaxDuration)

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - 0) / var_146_7

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play114251036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 114251036
		arg_147_1.duration_ = 7.17

		local var_147_0 = {
			ja = 4.566,
			ko = 6.466,
			zh = 5.7,
			en = 7.166
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play114251037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["10018"]) and arg_147_1.var_.actorSpriteComps10018 == nil then
				arg_147_1.var_.actorSpriteComps10018 = arg_147_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_0 = 0.034

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["10018"]) then
				if arg_147_1.var_.actorSpriteComps10018 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_150_1 then
							if arg_147_1.isInRecall_ then
								iter_150_1.color = Color.New(Mathf.Lerp(iter_150_1.color.r, arg_147_1.hightColor1.r, (arg_147_1.time_ - 0) / var_150_0), Mathf.Lerp(iter_150_1.color.g, arg_147_1.hightColor1.g, (arg_147_1.time_ - 0) / var_150_0), (Mathf.Lerp(iter_150_1.color.b, arg_147_1.hightColor1.b, (arg_147_1.time_ - 0) / var_150_0)))
							else
								local var_150_1 = Mathf.Lerp(iter_150_1.color.r, 1, (arg_147_1.time_ - 0) / var_150_0)

								iter_150_1.color = Color.New(var_150_1, var_150_1, var_150_1)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["10018"]) and arg_147_1.var_.actorSpriteComps10018 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_150_3 then
						iter_150_3.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps10018 = nil
			end

			local var_150_2 = arg_147_1.actors_["10015"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps10015 == nil then
				arg_147_1.var_.actorSpriteComps10015 = var_150_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_3 = 0.034

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 and not isNil(var_150_2) then
				if arg_147_1.var_.actorSpriteComps10015 then
					for iter_150_4, iter_150_5 in pairs(arg_147_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_150_5 then
							if arg_147_1.isInRecall_ then
								iter_150_5.color = Color.New(Mathf.Lerp(iter_150_5.color.r, arg_147_1.hightColor2.r, (arg_147_1.time_ - 0) / var_150_3), Mathf.Lerp(iter_150_5.color.g, arg_147_1.hightColor2.g, (arg_147_1.time_ - 0) / var_150_3), (Mathf.Lerp(iter_150_5.color.b, arg_147_1.hightColor2.b, (arg_147_1.time_ - 0) / var_150_3)))
							else
								local var_150_4 = Mathf.Lerp(iter_150_5.color.r, 0.5, (arg_147_1.time_ - 0) / var_150_3)

								iter_150_5.color = Color.New(var_150_4, var_150_4, var_150_4)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps10015 then
				for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_150_7 then
						iter_150_7.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_147_1.var_.actorSpriteComps10015 = nil
			end

			local var_150_5 = 0
			local var_150_6 = 0.45

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_7 = arg_147_1:GetWordFromCfg(114251036)
				local var_150_8 = arg_147_1:FormatText(var_150_7.content)

				arg_147_1.text_.text = var_150_8

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_10 = 18 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_8) / 18)

				if (18 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_8) / 18)) > 0 and var_150_6 < var_150_10 then
					arg_147_1.talkMaxDuration = var_150_10

					if var_150_10 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_5
					end
				end

				arg_147_1.text_.text = var_150_8
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251036", "story_v_out_114251.awb") ~= 0 then
					local var_150_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251036", "story_v_out_114251.awb") / 1000

					if var_150_11 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_11 + var_150_5
					end

					if var_150_7.prefab_name ~= "" and arg_147_1.actors_[var_150_7.prefab_name] ~= nil then
						local var_150_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_7.prefab_name].transform, "story_v_out_114251", "114251036", "story_v_out_114251.awb")

						arg_147_1:RecordAudio("114251036", var_150_12)
						arg_147_1:RecordAudio("114251036", var_150_12)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_114251", "114251036", "story_v_out_114251.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_114251", "114251036", "story_v_out_114251.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_13 = math.max(var_150_6, arg_147_1.talkMaxDuration)

			if var_150_5 <= arg_147_1.time_ and arg_147_1.time_ < var_150_5 + var_150_13 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_5) / var_150_13

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_5 + var_150_13 and arg_147_1.time_ < var_150_5 + var_150_13 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play114251037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 114251037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play114251038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["10018"]) and arg_151_1.var_.actorSpriteComps10018 == nil then
				arg_151_1.var_.actorSpriteComps10018 = arg_151_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_0 = 0.034

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["10018"]) then
				if arg_151_1.var_.actorSpriteComps10018 then
					for iter_154_0, iter_154_1 in pairs(arg_151_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_154_1 then
							if arg_151_1.isInRecall_ then
								iter_154_1.color = Color.New(Mathf.Lerp(iter_154_1.color.r, arg_151_1.hightColor2.r, (arg_151_1.time_ - 0) / var_154_0), Mathf.Lerp(iter_154_1.color.g, arg_151_1.hightColor2.g, (arg_151_1.time_ - 0) / var_154_0), (Mathf.Lerp(iter_154_1.color.b, arg_151_1.hightColor2.b, (arg_151_1.time_ - 0) / var_154_0)))
							else
								local var_154_1 = Mathf.Lerp(iter_154_1.color.r, 0.5, (arg_151_1.time_ - 0) / var_154_0)

								iter_154_1.color = Color.New(var_154_1, var_154_1, var_154_1)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["10018"]) and arg_151_1.var_.actorSpriteComps10018 then
				for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_154_3 then
						iter_154_3.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps10018 = nil
			end

			local var_154_2 = 0
			local var_154_3 = 0.8

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_4 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(114251037).content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_6 = 32 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_4) / 32)

				if (32 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_4) / 32)) > 0 and var_154_3 < var_154_6 then
					arg_151_1.talkMaxDuration = var_154_6

					if var_154_6 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_6 + var_154_2
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_3, arg_151_1.talkMaxDuration)

			if var_154_2 <= arg_151_1.time_ and arg_151_1.time_ < var_154_2 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_2) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_2 + var_154_7 and arg_151_1.time_ < var_154_2 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play114251038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 114251038
		arg_155_1.duration_ = 3.5

		local var_155_0 = {
			ja = 3.5,
			ko = 1.7,
			zh = 2.8,
			en = 1.7
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play114251039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10015 = arg_155_1.actors_["10015"].transform.localPosition
				arg_155_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10015", 4)

				for iter_158_0 = 0, arg_155_1.actors_["10015"].transform.childCount - 1 do
					local var_158_0 = arg_155_1.actors_["10015"].transform:GetChild(iter_158_0)

					if var_158_0.name == "split_5" or not string.find(var_158_0.name, "split") then
						var_158_0.gameObject:SetActive(true)
					else
						var_158_0.gameObject:SetActive(false)
					end
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_155_1.time_ - 0) / var_158_1)
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_158_2 = arg_155_1.actors_["10015"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10015 == nil then
				arg_155_1.var_.actorSpriteComps10015 = var_158_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_3 = 0.034

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.actorSpriteComps10015 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_158_2 then
							if arg_155_1.isInRecall_ then
								iter_158_2.color = Color.New(Mathf.Lerp(iter_158_2.color.r, arg_155_1.hightColor1.r, (arg_155_1.time_ - 0) / var_158_3), Mathf.Lerp(iter_158_2.color.g, arg_155_1.hightColor1.g, (arg_155_1.time_ - 0) / var_158_3), (Mathf.Lerp(iter_158_2.color.b, arg_155_1.hightColor1.b, (arg_155_1.time_ - 0) / var_158_3)))
							else
								local var_158_4 = Mathf.Lerp(iter_158_2.color.r, 1, (arg_155_1.time_ - 0) / var_158_3)

								iter_158_2.color = Color.New(var_158_4, var_158_4, var_158_4)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps10015 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_158_4 then
						iter_158_4.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_155_1.var_.actorSpriteComps10015 = nil
			end

			local var_158_5 = 0
			local var_158_6 = 0.225

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_7 = arg_155_1:GetWordFromCfg(114251038)
				local var_158_8 = arg_155_1:FormatText(var_158_7.content)

				arg_155_1.text_.text = var_158_8

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_10 = 9 <= 0 and var_158_6 or var_158_6 * (utf8.len(var_158_8) / 9)

				if (9 <= 0 and var_158_6 or var_158_6 * (utf8.len(var_158_8) / 9)) > 0 and var_158_6 < var_158_10 then
					arg_155_1.talkMaxDuration = var_158_10

					if var_158_10 + var_158_5 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_5
					end
				end

				arg_155_1.text_.text = var_158_8
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251038", "story_v_out_114251.awb") ~= 0 then
					local var_158_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251038", "story_v_out_114251.awb") / 1000

					if var_158_11 + var_158_5 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_11 + var_158_5
					end

					if var_158_7.prefab_name ~= "" and arg_155_1.actors_[var_158_7.prefab_name] ~= nil then
						local var_158_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_7.prefab_name].transform, "story_v_out_114251", "114251038", "story_v_out_114251.awb")

						arg_155_1:RecordAudio("114251038", var_158_12)
						arg_155_1:RecordAudio("114251038", var_158_12)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_114251", "114251038", "story_v_out_114251.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_114251", "114251038", "story_v_out_114251.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_13 = math.max(var_158_6, arg_155_1.talkMaxDuration)

			if var_158_5 <= arg_155_1.time_ and arg_155_1.time_ < var_158_5 + var_158_13 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_5) / var_158_13

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_5 + var_158_13 and arg_155_1.time_ < var_158_5 + var_158_13 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play114251039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 114251039
		arg_159_1.duration_ = 9

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play114251040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if arg_159_1.bgs_.ST24a == nil then
				local var_162_0 = Object.Instantiate(arg_159_1.paintGo_)

				var_162_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST24a")
				var_162_0.name = "ST24a"
				var_162_0.transform.parent = arg_159_1.stage_.transform
				var_162_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_159_1.bgs_.ST24a = var_162_0
			end

			if 2 < arg_159_1.time_ and arg_159_1.time_ <= 2 + arg_162_0 then
				local var_162_1 = arg_159_1.bgs_.ST24a

				arg_159_1.bgs_.ST24a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_162_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_162_2 = var_162_1:GetComponent("SpriteRenderer")

				if var_162_2 and var_162_2.sprite then
					local var_162_3 = 2 * (var_162_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_162_1.transform.localScale = Vector3.New(var_162_3 / var_162_2.sprite.bounds.size.y < var_162_3 * manager.ui.mainCameraCom_.aspect / var_162_2.sprite.bounds.size.x and var_162_3 * manager.ui.mainCameraCom_.aspect / var_162_2.sprite.bounds.size.x or var_162_3 / var_162_2.sprite.bounds.size.y, var_162_3 / var_162_2.sprite.bounds.size.y < var_162_3 * manager.ui.mainCameraCom_.aspect / var_162_2.sprite.bounds.size.x and var_162_3 * manager.ui.mainCameraCom_.aspect / var_162_2.sprite.bounds.size.x or var_162_3 / var_162_2.sprite.bounds.size.y, 0)
				end

				for iter_162_0, iter_162_1 in pairs(arg_159_1.bgs_) do
					if iter_162_0 ~= "ST24a" then
						iter_162_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_162_4 = 0

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.mask_.enabled = true
				arg_159_1.mask_.raycastTarget = true

				arg_159_1:SetGaussion(false)
			end

			local var_162_5 = 2

			if var_162_4 <= arg_159_1.time_ and arg_159_1.time_ < var_162_4 + var_162_5 then
				local var_162_6 = Color.New(0, 0, 0)

				var_162_6.a = Mathf.Lerp(0, 1, (arg_159_1.time_ - var_162_4) / var_162_5)
				arg_159_1.mask_.color = var_162_6
			end

			if arg_159_1.time_ >= var_162_4 + var_162_5 and arg_159_1.time_ < var_162_4 + var_162_5 + arg_162_0 then
				local var_162_7 = Color.New(0, 0, 0)

				var_162_7.a = 1
				arg_159_1.mask_.color = var_162_7
			end

			local var_162_8 = 2

			if 2 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
				arg_159_1.mask_.enabled = true
				arg_159_1.mask_.raycastTarget = true

				arg_159_1:SetGaussion(false)
			end

			local var_162_9 = 2

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_9 then
				local var_162_10 = Color.New(0, 0, 0)

				var_162_10.a = Mathf.Lerp(1, 0, (arg_159_1.time_ - var_162_8) / var_162_9)
				arg_159_1.mask_.color = var_162_10
			end

			if arg_159_1.time_ >= var_162_8 + var_162_9 and arg_159_1.time_ < var_162_8 + var_162_9 + arg_162_0 then
				local var_162_11 = Color.New(0, 0, 0)

				arg_159_1.mask_.enabled = false
				var_162_11.a = 0
				arg_159_1.mask_.color = var_162_11
			end

			local var_162_12 = arg_159_1.actors_["10018"].transform

			if 1.966 < arg_159_1.time_ and arg_159_1.time_ <= 1.966 + arg_162_0 then
				arg_159_1.var_.moveOldPos10018 = var_162_12.localPosition
				var_162_12.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10018", 7)

				for iter_162_2 = 0, var_162_12.childCount - 1 do
					local var_162_13 = var_162_12:GetChild(iter_162_2)

					if var_162_13.name == "split_2" or not string.find(var_162_13.name, "split") then
						var_162_13.gameObject:SetActive(true)
					else
						var_162_13.gameObject:SetActive(false)
					end
				end
			end

			local var_162_14 = 0.001

			if 1.966 <= arg_159_1.time_ and arg_159_1.time_ < 1.966 + var_162_14 then
				var_162_12.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10018, Vector3.New(0, -2000, -180), (arg_159_1.time_ - 1.966) / var_162_14)
			end

			if arg_159_1.time_ >= 1.966 + var_162_14 and arg_159_1.time_ < 1.966 + var_162_14 + arg_162_0 then
				var_162_12.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_162_15 = arg_159_1.actors_["10015"].transform

			if 1.966 < arg_159_1.time_ and arg_159_1.time_ <= 1.966 + arg_162_0 then
				arg_159_1.var_.moveOldPos10015 = var_162_15.localPosition
				var_162_15.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10015", 7)

				for iter_162_3 = 0, var_162_15.childCount - 1 do
					local var_162_16 = var_162_15:GetChild(iter_162_3)

					if var_162_16.name == "split_5" or not string.find(var_162_16.name, "split") then
						var_162_16.gameObject:SetActive(true)
					else
						var_162_16.gameObject:SetActive(false)
					end
				end
			end

			local var_162_17 = 0.001

			if 1.966 <= arg_159_1.time_ and arg_159_1.time_ < 1.966 + var_162_17 then
				var_162_15.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10015, Vector3.New(0, -2000, 450), (arg_159_1.time_ - 1.966) / var_162_17)
			end

			if arg_159_1.time_ >= 1.966 + var_162_17 and arg_159_1.time_ < 1.966 + var_162_17 + arg_162_0 then
				var_162_15.localPosition = Vector3.New(0, -2000, 450)
			end

			if arg_159_1.frameCnt_ <= 1 then
				arg_159_1.dialog_:SetActive(false)
			end

			local var_162_18 = 4
			local var_162_19 = 0.05

			if 4 < arg_159_1.time_ and arg_159_1.time_ <= var_162_18 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0

				arg_159_1.dialog_:SetActive(true)

				arg_159_1.dialogCg_.alpha = 0

				local var_162_20 = LeanTween.value(arg_159_1.dialog_, 0, 1, 0.3)

				var_162_20:setOnUpdate(LuaHelper.FloatAction(function(arg_163_0)
					arg_159_1.dialogCg_.alpha = arg_163_0
				end))
				var_162_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_159_1.dialog_)
					var_162_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_159_1.duration_ = arg_159_1.duration_ + 0.3

				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_21 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(114251039).content)

				arg_159_1.text_.text = var_162_21

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_23 = 2 <= 0 and var_162_19 or var_162_19 * (utf8.len(var_162_21) / 2)

				if (2 <= 0 and var_162_19 or var_162_19 * (utf8.len(var_162_21) / 2)) > 0 and var_162_19 < var_162_23 then
					arg_159_1.talkMaxDuration = var_162_23
					var_162_18 = var_162_18 + 0.3

					if var_162_23 + var_162_18 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_23 + var_162_18
					end
				end

				arg_159_1.text_.text = var_162_21
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_24 = var_162_18 + 0.3
			local var_162_25 = math.max(var_162_19, arg_159_1.talkMaxDuration)

			if var_162_18 + 0.3 <= arg_159_1.time_ and arg_159_1.time_ < var_162_24 + var_162_25 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_24) / var_162_25

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_24 + var_162_25 and arg_159_1.time_ < var_162_24 + var_162_25 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10015",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play114251040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 114251040
		arg_165_1.duration_ = 8.3

		local var_165_0 = {
			ja = 8.3,
			ko = 6.5,
			zh = 6.6,
			en = 6.266
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
				arg_165_0:Play114251041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if arg_165_1.actors_["10021"] == nil then
				local var_168_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10021")

				if not isNil(var_168_0) then
					local var_168_1 = Object.Instantiate(var_168_0, arg_165_1.canvasGo_.transform)

					var_168_1.transform:SetSiblingIndex(1)

					var_168_1.name = "10021"
					var_168_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_165_1.actors_["10021"] = var_168_1

					if arg_165_1.isInRecall_ then
						for iter_168_0, iter_168_1 in ipairs((var_168_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_168_1.color = arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_168_2 = arg_165_1.actors_["10021"].transform

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10021 = var_168_2.localPosition
				var_168_2.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("10021", 2)

				for iter_168_2 = 0, var_168_2.childCount - 1 do
					local var_168_3 = var_168_2:GetChild(iter_168_2)

					if var_168_3.name == "split_1" or not string.find(var_168_3.name, "split") then
						var_168_3.gameObject:SetActive(true)
					else
						var_168_3.gameObject:SetActive(false)
					end
				end
			end

			local var_168_4 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				var_168_2.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10021, Vector3.New(-390, -350, -180), (arg_165_1.time_ - 0) / var_168_4)
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				var_168_2.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_168_5 = arg_165_1.actors_["10021"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.actorSpriteComps10021 == nil then
				arg_165_1.var_.actorSpriteComps10021 = var_168_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_168_6 = 0.034

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_6 and not isNil(var_168_5) then
				if arg_165_1.var_.actorSpriteComps10021 then
					for iter_168_3, iter_168_4 in pairs(arg_165_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_168_4 then
							if arg_165_1.isInRecall_ then
								iter_168_4.color = Color.New(Mathf.Lerp(iter_168_4.color.r, arg_165_1.hightColor1.r, (arg_165_1.time_ - 0) / var_168_6), Mathf.Lerp(iter_168_4.color.g, arg_165_1.hightColor1.g, (arg_165_1.time_ - 0) / var_168_6), (Mathf.Lerp(iter_168_4.color.b, arg_165_1.hightColor1.b, (arg_165_1.time_ - 0) / var_168_6)))
							else
								local var_168_7 = Mathf.Lerp(iter_168_4.color.r, 1, (arg_165_1.time_ - 0) / var_168_6)

								iter_168_4.color = Color.New(var_168_7, var_168_7, var_168_7)
							end
						end
					end
				end
			end

			if arg_165_1.time_ >= 0 + var_168_6 and arg_165_1.time_ < 0 + var_168_6 + arg_168_0 and not isNil(var_168_5) and arg_165_1.var_.actorSpriteComps10021 then
				for iter_168_5, iter_168_6 in pairs(arg_165_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_168_6 then
						iter_168_6.color = arg_165_1.isInRecall_ and (arg_165_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_165_1.var_.actorSpriteComps10021 = nil
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				local var_168_8 = arg_165_1.actors_["10021"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_168_8 then
					arg_165_1.var_.alphaOldValue10021 = var_168_8.alpha
					arg_165_1.var_.characterEffect10021 = var_168_8
				end

				arg_165_1.var_.alphaOldValue10021 = 0
			end

			local var_168_9 = 0.5

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_9 then
				if arg_165_1.var_.characterEffect10021 then
					arg_165_1.var_.characterEffect10021.alpha = Mathf.Lerp(arg_165_1.var_.alphaOldValue10021, 1, (arg_165_1.time_ - 0) / var_168_9)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_9 and arg_165_1.time_ < 0 + var_168_9 + arg_168_0 and arg_165_1.var_.characterEffect10021 then
				arg_165_1.var_.characterEffect10021.alpha = 1
			end

			local var_168_10 = 0
			local var_168_11 = 0.775

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 then
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

				local var_168_12 = arg_165_1:GetWordFromCfg(114251040)
				local var_168_13 = arg_165_1:FormatText(var_168_12.content)

				arg_165_1.text_.text = var_168_13

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_15 = 30 <= 0 and var_168_11 or var_168_11 * (utf8.len(var_168_13) / 30)

				if (30 <= 0 and var_168_11 or var_168_11 * (utf8.len(var_168_13) / 30)) > 0 and var_168_11 < var_168_15 then
					arg_165_1.talkMaxDuration = var_168_15

					if var_168_15 + var_168_10 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_15 + var_168_10
					end
				end

				arg_165_1.text_.text = var_168_13
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251040", "story_v_out_114251.awb") ~= 0 then
					local var_168_16 = manager.audio:GetVoiceLength("story_v_out_114251", "114251040", "story_v_out_114251.awb") / 1000

					if var_168_16 + var_168_10 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_16 + var_168_10
					end

					if var_168_12.prefab_name ~= "" and arg_165_1.actors_[var_168_12.prefab_name] ~= nil then
						local var_168_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_12.prefab_name].transform, "story_v_out_114251", "114251040", "story_v_out_114251.awb")

						arg_165_1:RecordAudio("114251040", var_168_17)
						arg_165_1:RecordAudio("114251040", var_168_17)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_114251", "114251040", "story_v_out_114251.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_114251", "114251040", "story_v_out_114251.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_18 = math.max(var_168_11, arg_165_1.talkMaxDuration)

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_18 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_10) / var_168_18

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_10 + var_168_18 and arg_165_1.time_ < var_168_10 + var_168_18 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10021",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play114251041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 114251041
		arg_169_1.duration_ = 11

		local var_169_0 = {
			ja = 11,
			ko = 9.3,
			zh = 7.8,
			en = 10.666
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
				arg_169_0:Play114251042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10018 = arg_169_1.actors_["10018"].transform.localPosition
				arg_169_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10018", 4)

				for iter_172_0 = 0, arg_169_1.actors_["10018"].transform.childCount - 1 do
					local var_172_0 = arg_169_1.actors_["10018"].transform:GetChild(iter_172_0)

					if var_172_0.name == "split_1" or not string.find(var_172_0.name, "split") then
						var_172_0.gameObject:SetActive(true)
					else
						var_172_0.gameObject:SetActive(false)
					end
				end
			end

			local var_172_1 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_1 then
				arg_169_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10018, Vector3.New(390, -350, -180), (arg_169_1.time_ - 0) / var_172_1)
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 then
				arg_169_1.actors_["10018"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_172_2 = arg_169_1.actors_["10021"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps10021 == nil then
				arg_169_1.var_.actorSpriteComps10021 = var_172_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_3 = 0.034

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_3 and not isNil(var_172_2) then
				if arg_169_1.var_.actorSpriteComps10021 then
					for iter_172_1, iter_172_2 in pairs(arg_169_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_172_2 then
							if arg_169_1.isInRecall_ then
								iter_172_2.color = Color.New(Mathf.Lerp(iter_172_2.color.r, arg_169_1.hightColor2.r, (arg_169_1.time_ - 0) / var_172_3), Mathf.Lerp(iter_172_2.color.g, arg_169_1.hightColor2.g, (arg_169_1.time_ - 0) / var_172_3), (Mathf.Lerp(iter_172_2.color.b, arg_169_1.hightColor2.b, (arg_169_1.time_ - 0) / var_172_3)))
							else
								local var_172_4 = Mathf.Lerp(iter_172_2.color.r, 0.5, (arg_169_1.time_ - 0) / var_172_3)

								iter_172_2.color = Color.New(var_172_4, var_172_4, var_172_4)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_3 and arg_169_1.time_ < 0 + var_172_3 + arg_172_0 and not isNil(var_172_2) and arg_169_1.var_.actorSpriteComps10021 then
				for iter_172_3, iter_172_4 in pairs(arg_169_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_172_4 then
						iter_172_4.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_169_1.var_.actorSpriteComps10021 = nil
			end

			local var_172_5 = arg_169_1.actors_["10018"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.actorSpriteComps10018 == nil then
				arg_169_1.var_.actorSpriteComps10018 = var_172_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_6 = 0.034

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_6 and not isNil(var_172_5) then
				if arg_169_1.var_.actorSpriteComps10018 then
					for iter_172_5, iter_172_6 in pairs(arg_169_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_172_6 then
							if arg_169_1.isInRecall_ then
								iter_172_6.color = Color.New(Mathf.Lerp(iter_172_6.color.r, arg_169_1.hightColor1.r, (arg_169_1.time_ - 0) / var_172_6), Mathf.Lerp(iter_172_6.color.g, arg_169_1.hightColor1.g, (arg_169_1.time_ - 0) / var_172_6), (Mathf.Lerp(iter_172_6.color.b, arg_169_1.hightColor1.b, (arg_169_1.time_ - 0) / var_172_6)))
							else
								local var_172_7 = Mathf.Lerp(iter_172_6.color.r, 1, (arg_169_1.time_ - 0) / var_172_6)

								iter_172_6.color = Color.New(var_172_7, var_172_7, var_172_7)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_6 and arg_169_1.time_ < 0 + var_172_6 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.actorSpriteComps10018 then
				for iter_172_7, iter_172_8 in pairs(arg_169_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_172_8 then
						iter_172_8.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_169_1.var_.actorSpriteComps10018 = nil
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				local var_172_8 = arg_169_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_172_8 then
					arg_169_1.var_.alphaOldValue10018 = var_172_8.alpha
					arg_169_1.var_.characterEffect10018 = var_172_8
				end

				arg_169_1.var_.alphaOldValue10018 = 0
			end

			local var_172_9 = 0.5

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_9 then
				if arg_169_1.var_.characterEffect10018 then
					arg_169_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_169_1.var_.alphaOldValue10018, 1, (arg_169_1.time_ - 0) / var_172_9)
				end
			end

			if arg_169_1.time_ >= 0 + var_172_9 and arg_169_1.time_ < 0 + var_172_9 + arg_172_0 and arg_169_1.var_.characterEffect10018 then
				arg_169_1.var_.characterEffect10018.alpha = 1
			end

			local var_172_10 = 0
			local var_172_11 = 1.025

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_12 = arg_169_1:GetWordFromCfg(114251041)
				local var_172_13 = arg_169_1:FormatText(var_172_12.content)

				arg_169_1.text_.text = var_172_13

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_15 = 41 <= 0 and var_172_11 or var_172_11 * (utf8.len(var_172_13) / 41)

				if (41 <= 0 and var_172_11 or var_172_11 * (utf8.len(var_172_13) / 41)) > 0 and var_172_11 < var_172_15 then
					arg_169_1.talkMaxDuration = var_172_15

					if var_172_15 + var_172_10 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_15 + var_172_10
					end
				end

				arg_169_1.text_.text = var_172_13
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251041", "story_v_out_114251.awb") ~= 0 then
					local var_172_16 = manager.audio:GetVoiceLength("story_v_out_114251", "114251041", "story_v_out_114251.awb") / 1000

					if var_172_16 + var_172_10 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_16 + var_172_10
					end

					if var_172_12.prefab_name ~= "" and arg_169_1.actors_[var_172_12.prefab_name] ~= nil then
						local var_172_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_12.prefab_name].transform, "story_v_out_114251", "114251041", "story_v_out_114251.awb")

						arg_169_1:RecordAudio("114251041", var_172_17)
						arg_169_1:RecordAudio("114251041", var_172_17)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_114251", "114251041", "story_v_out_114251.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_114251", "114251041", "story_v_out_114251.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_18 = math.max(var_172_11, arg_169_1.talkMaxDuration)

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_18 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_10) / var_172_18

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_10 + var_172_18 and arg_169_1.time_ < var_172_10 + var_172_18 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114251042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 114251042
		arg_173_1.duration_ = 3.63

		local var_173_0 = {
			ja = 3.066,
			ko = 1.766,
			zh = 2.033,
			en = 3.633
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
				arg_173_0:Play114251043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(arg_173_1.actors_["10021"]) and arg_173_1.var_.actorSpriteComps10021 == nil then
				arg_173_1.var_.actorSpriteComps10021 = arg_173_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_0 = 0.034

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 and not isNil(arg_173_1.actors_["10021"]) then
				if arg_173_1.var_.actorSpriteComps10021 then
					for iter_176_0, iter_176_1 in pairs(arg_173_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_176_1 then
							if arg_173_1.isInRecall_ then
								iter_176_1.color = Color.New(Mathf.Lerp(iter_176_1.color.r, arg_173_1.hightColor1.r, (arg_173_1.time_ - 0) / var_176_0), Mathf.Lerp(iter_176_1.color.g, arg_173_1.hightColor1.g, (arg_173_1.time_ - 0) / var_176_0), (Mathf.Lerp(iter_176_1.color.b, arg_173_1.hightColor1.b, (arg_173_1.time_ - 0) / var_176_0)))
							else
								local var_176_1 = Mathf.Lerp(iter_176_1.color.r, 1, (arg_173_1.time_ - 0) / var_176_0)

								iter_176_1.color = Color.New(var_176_1, var_176_1, var_176_1)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 and not isNil(arg_173_1.actors_["10021"]) and arg_173_1.var_.actorSpriteComps10021 then
				for iter_176_2, iter_176_3 in pairs(arg_173_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_176_3 then
						iter_176_3.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_173_1.var_.actorSpriteComps10021 = nil
			end

			local var_176_2 = arg_173_1.actors_["10018"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps10018 == nil then
				arg_173_1.var_.actorSpriteComps10018 = var_176_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_3 = 0.034

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.actorSpriteComps10018 then
					for iter_176_4, iter_176_5 in pairs(arg_173_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_176_5 then
							if arg_173_1.isInRecall_ then
								iter_176_5.color = Color.New(Mathf.Lerp(iter_176_5.color.r, arg_173_1.hightColor2.r, (arg_173_1.time_ - 0) / var_176_3), Mathf.Lerp(iter_176_5.color.g, arg_173_1.hightColor2.g, (arg_173_1.time_ - 0) / var_176_3), (Mathf.Lerp(iter_176_5.color.b, arg_173_1.hightColor2.b, (arg_173_1.time_ - 0) / var_176_3)))
							else
								local var_176_4 = Mathf.Lerp(iter_176_5.color.r, 0.5, (arg_173_1.time_ - 0) / var_176_3)

								iter_176_5.color = Color.New(var_176_4, var_176_4, var_176_4)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps10018 then
				for iter_176_6, iter_176_7 in pairs(arg_173_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_176_7 then
						iter_176_7.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_173_1.var_.actorSpriteComps10018 = nil
			end

			local var_176_5 = 0
			local var_176_6 = 0.225

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 then
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

				local var_176_7 = arg_173_1:GetWordFromCfg(114251042)
				local var_176_8 = arg_173_1:FormatText(var_176_7.content)

				arg_173_1.text_.text = var_176_8

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_10 = 9 <= 0 and var_176_6 or var_176_6 * (utf8.len(var_176_8) / 9)

				if (9 <= 0 and var_176_6 or var_176_6 * (utf8.len(var_176_8) / 9)) > 0 and var_176_6 < var_176_10 then
					arg_173_1.talkMaxDuration = var_176_10

					if var_176_10 + var_176_5 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_5
					end
				end

				arg_173_1.text_.text = var_176_8
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251042", "story_v_out_114251.awb") ~= 0 then
					local var_176_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251042", "story_v_out_114251.awb") / 1000

					if var_176_11 + var_176_5 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_11 + var_176_5
					end

					if var_176_7.prefab_name ~= "" and arg_173_1.actors_[var_176_7.prefab_name] ~= nil then
						local var_176_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_7.prefab_name].transform, "story_v_out_114251", "114251042", "story_v_out_114251.awb")

						arg_173_1:RecordAudio("114251042", var_176_12)
						arg_173_1:RecordAudio("114251042", var_176_12)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_114251", "114251042", "story_v_out_114251.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_114251", "114251042", "story_v_out_114251.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_13 = math.max(var_176_6, arg_173_1.talkMaxDuration)

			if var_176_5 <= arg_173_1.time_ and arg_173_1.time_ < var_176_5 + var_176_13 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_5) / var_176_13

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_5 + var_176_13 and arg_173_1.time_ < var_176_5 + var_176_13 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play114251043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 114251043
		arg_177_1.duration_ = 9.2

		local var_177_0 = {
			ja = 7.866,
			ko = 8.733,
			zh = 9.2,
			en = 8.4
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
				arg_177_0:Play114251044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 1.225

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:GetWordFromCfg(114251043)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 49 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 49)

				if (49 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 49)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251043", "story_v_out_114251.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_114251", "114251043", "story_v_out_114251.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_114251", "114251043", "story_v_out_114251.awb")

						arg_177_1:RecordAudio("114251043", var_180_6)
						arg_177_1:RecordAudio("114251043", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_114251", "114251043", "story_v_out_114251.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_114251", "114251043", "story_v_out_114251.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_0, arg_177_1.talkMaxDuration)

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - 0) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= 0 + var_180_7 and arg_177_1.time_ < 0 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play114251044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 114251044
		arg_181_1.duration_ = 9.4

		local var_181_0 = {
			ja = 6.066,
			ko = 8.666,
			zh = 8.9,
			en = 9.4
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
				arg_181_0:Play114251045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 1.05

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
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

				local var_184_1 = arg_181_1:GetWordFromCfg(114251044)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 42 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 42)

				if (42 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 42)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251044", "story_v_out_114251.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_114251", "114251044", "story_v_out_114251.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_114251", "114251044", "story_v_out_114251.awb")

						arg_181_1:RecordAudio("114251044", var_184_6)
						arg_181_1:RecordAudio("114251044", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_114251", "114251044", "story_v_out_114251.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_114251", "114251044", "story_v_out_114251.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play114251045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 114251045
		arg_185_1.duration_ = 5.43

		local var_185_0 = {
			ja = 5.433,
			ko = 2.366,
			zh = 4.033,
			en = 3.633
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
				arg_185_0:Play114251046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10018 = arg_185_1.actors_["10018"].transform.localPosition
				arg_185_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10018", 4)

				for iter_188_0 = 0, arg_185_1.actors_["10018"].transform.childCount - 1 do
					local var_188_0 = arg_185_1.actors_["10018"].transform:GetChild(iter_188_0)

					if var_188_0.name == "split_2" or not string.find(var_188_0.name, "split") then
						var_188_0.gameObject:SetActive(true)
					else
						var_188_0.gameObject:SetActive(false)
					end
				end
			end

			local var_188_1 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10018, Vector3.New(390, -350, -180), (arg_185_1.time_ - 0) / var_188_1)
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["10018"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_188_2 = arg_185_1.actors_["10021"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps10021 == nil then
				arg_185_1.var_.actorSpriteComps10021 = var_188_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_3 = 0.034

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_3 and not isNil(var_188_2) then
				if arg_185_1.var_.actorSpriteComps10021 then
					for iter_188_1, iter_188_2 in pairs(arg_185_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_188_2 then
							if arg_185_1.isInRecall_ then
								iter_188_2.color = Color.New(Mathf.Lerp(iter_188_2.color.r, arg_185_1.hightColor2.r, (arg_185_1.time_ - 0) / var_188_3), Mathf.Lerp(iter_188_2.color.g, arg_185_1.hightColor2.g, (arg_185_1.time_ - 0) / var_188_3), (Mathf.Lerp(iter_188_2.color.b, arg_185_1.hightColor2.b, (arg_185_1.time_ - 0) / var_188_3)))
							else
								local var_188_4 = Mathf.Lerp(iter_188_2.color.r, 0.5, (arg_185_1.time_ - 0) / var_188_3)

								iter_188_2.color = Color.New(var_188_4, var_188_4, var_188_4)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_3 and arg_185_1.time_ < 0 + var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps10021 then
				for iter_188_3, iter_188_4 in pairs(arg_185_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_188_4 then
						iter_188_4.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_185_1.var_.actorSpriteComps10021 = nil
			end

			local var_188_5 = arg_185_1.actors_["10018"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.actorSpriteComps10018 == nil then
				arg_185_1.var_.actorSpriteComps10018 = var_188_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_6 = 0.034

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_6 and not isNil(var_188_5) then
				if arg_185_1.var_.actorSpriteComps10018 then
					for iter_188_5, iter_188_6 in pairs(arg_185_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_188_6 then
							if arg_185_1.isInRecall_ then
								iter_188_6.color = Color.New(Mathf.Lerp(iter_188_6.color.r, arg_185_1.hightColor1.r, (arg_185_1.time_ - 0) / var_188_6), Mathf.Lerp(iter_188_6.color.g, arg_185_1.hightColor1.g, (arg_185_1.time_ - 0) / var_188_6), (Mathf.Lerp(iter_188_6.color.b, arg_185_1.hightColor1.b, (arg_185_1.time_ - 0) / var_188_6)))
							else
								local var_188_7 = Mathf.Lerp(iter_188_6.color.r, 1, (arg_185_1.time_ - 0) / var_188_6)

								iter_188_6.color = Color.New(var_188_7, var_188_7, var_188_7)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_6 and arg_185_1.time_ < 0 + var_188_6 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.actorSpriteComps10018 then
				for iter_188_7, iter_188_8 in pairs(arg_185_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_188_8 then
						iter_188_8.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_185_1.var_.actorSpriteComps10018 = nil
			end

			local var_188_8 = 0
			local var_188_9 = 0.25

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(114251045)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 10 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 10)

				if (10 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 10)) > 0 and var_188_9 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251045", "story_v_out_114251.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_114251", "114251045", "story_v_out_114251.awb") / 1000

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end

					if var_188_10.prefab_name ~= "" and arg_185_1.actors_[var_188_10.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_10.prefab_name].transform, "story_v_out_114251", "114251045", "story_v_out_114251.awb")

						arg_185_1:RecordAudio("114251045", var_188_15)
						arg_185_1:RecordAudio("114251045", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_114251", "114251045", "story_v_out_114251.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_114251", "114251045", "story_v_out_114251.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_16 = math.max(var_188_9, arg_185_1.talkMaxDuration)

			if var_188_8 <= arg_185_1.time_ and arg_185_1.time_ < var_188_8 + var_188_16 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_8) / var_188_16

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_8 + var_188_16 and arg_185_1.time_ < var_188_8 + var_188_16 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114251046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 114251046
		arg_189_1.duration_ = 8.97

		local var_189_0 = {
			ja = 4.1,
			ko = 6.2,
			zh = 8.966,
			en = 5.933
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
				arg_189_0:Play114251047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10018 = arg_189_1.actors_["10018"].transform.localPosition
				arg_189_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10018", 4)

				for iter_192_0 = 0, arg_189_1.actors_["10018"].transform.childCount - 1 do
					local var_192_0 = arg_189_1.actors_["10018"].transform:GetChild(iter_192_0)

					if var_192_0.name == "split_1" or not string.find(var_192_0.name, "split") then
						var_192_0.gameObject:SetActive(true)
					else
						var_192_0.gameObject:SetActive(false)
					end
				end
			end

			local var_192_1 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_1 then
				arg_189_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10018, Vector3.New(390, -350, -180), (arg_189_1.time_ - 0) / var_192_1)
			end

			if arg_189_1.time_ >= 0 + var_192_1 and arg_189_1.time_ < 0 + var_192_1 + arg_192_0 then
				arg_189_1.actors_["10018"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_192_2 = arg_189_1.actors_["10018"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.actorSpriteComps10018 == nil then
				arg_189_1.var_.actorSpriteComps10018 = var_192_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_3 = 0.034

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 and not isNil(var_192_2) then
				if arg_189_1.var_.actorSpriteComps10018 then
					for iter_192_1, iter_192_2 in pairs(arg_189_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 and not isNil(var_192_2) and arg_189_1.var_.actorSpriteComps10018 then
				for iter_192_3, iter_192_4 in pairs(arg_189_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_192_4 then
						iter_192_4.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_189_1.var_.actorSpriteComps10018 = nil
			end

			local var_192_5 = 0
			local var_192_6 = 0.575

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_5 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_7 = arg_189_1:GetWordFromCfg(114251046)
				local var_192_8 = arg_189_1:FormatText(var_192_7.content)

				arg_189_1.text_.text = var_192_8

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_10 = 23 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 23)

				if (23 <= 0 and var_192_6 or var_192_6 * (utf8.len(var_192_8) / 23)) > 0 and var_192_6 < var_192_10 then
					arg_189_1.talkMaxDuration = var_192_10

					if var_192_10 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_10 + var_192_5
					end
				end

				arg_189_1.text_.text = var_192_8
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251046", "story_v_out_114251.awb") ~= 0 then
					local var_192_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251046", "story_v_out_114251.awb") / 1000

					if var_192_11 + var_192_5 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_5
					end

					if var_192_7.prefab_name ~= "" and arg_189_1.actors_[var_192_7.prefab_name] ~= nil then
						local var_192_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_7.prefab_name].transform, "story_v_out_114251", "114251046", "story_v_out_114251.awb")

						arg_189_1:RecordAudio("114251046", var_192_12)
						arg_189_1:RecordAudio("114251046", var_192_12)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_114251", "114251046", "story_v_out_114251.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_114251", "114251046", "story_v_out_114251.awb")
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
				actorName = "10018",
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
	Play114251047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 114251047
		arg_193_1.duration_ = 7.37

		local var_193_0 = {
			ja = 6.9,
			ko = 5.833,
			zh = 7.366,
			en = 6.2
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
				arg_193_0:Play114251048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(arg_193_1.actors_["10021"]) and arg_193_1.var_.actorSpriteComps10021 == nil then
				arg_193_1.var_.actorSpriteComps10021 = arg_193_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_0 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 and not isNil(arg_193_1.actors_["10021"]) then
				if arg_193_1.var_.actorSpriteComps10021 then
					for iter_196_0, iter_196_1 in pairs(arg_193_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_196_1 then
							if arg_193_1.isInRecall_ then
								iter_196_1.color = Color.New(Mathf.Lerp(iter_196_1.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0) / var_196_0), Mathf.Lerp(iter_196_1.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0) / var_196_0), (Mathf.Lerp(iter_196_1.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0) / var_196_0)))
							else
								local var_196_1 = Mathf.Lerp(iter_196_1.color.r, 1, (arg_193_1.time_ - 0) / var_196_0)

								iter_196_1.color = Color.New(var_196_1, var_196_1, var_196_1)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 and not isNil(arg_193_1.actors_["10021"]) and arg_193_1.var_.actorSpriteComps10021 then
				for iter_196_2, iter_196_3 in pairs(arg_193_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_196_3 then
						iter_196_3.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps10021 = nil
			end

			local var_196_2 = arg_193_1.actors_["10018"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps10018 == nil then
				arg_193_1.var_.actorSpriteComps10018 = var_196_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_3 = 0.034

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.actorSpriteComps10018 then
					for iter_196_4, iter_196_5 in pairs(arg_193_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_196_5 then
							if arg_193_1.isInRecall_ then
								iter_196_5.color = Color.New(Mathf.Lerp(iter_196_5.color.r, arg_193_1.hightColor2.r, (arg_193_1.time_ - 0) / var_196_3), Mathf.Lerp(iter_196_5.color.g, arg_193_1.hightColor2.g, (arg_193_1.time_ - 0) / var_196_3), (Mathf.Lerp(iter_196_5.color.b, arg_193_1.hightColor2.b, (arg_193_1.time_ - 0) / var_196_3)))
							else
								local var_196_4 = Mathf.Lerp(iter_196_5.color.r, 0.5, (arg_193_1.time_ - 0) / var_196_3)

								iter_196_5.color = Color.New(var_196_4, var_196_4, var_196_4)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0 + var_196_3 and arg_193_1.time_ < 0 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps10018 then
				for iter_196_6, iter_196_7 in pairs(arg_193_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_196_7 then
						iter_196_7.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_193_1.var_.actorSpriteComps10018 = nil
			end

			local var_196_5 = 0
			local var_196_6 = 0.875

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_5 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_7 = arg_193_1:GetWordFromCfg(114251047)
				local var_196_8 = arg_193_1:FormatText(var_196_7.content)

				arg_193_1.text_.text = var_196_8

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_10 = 35 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 35)

				if (35 <= 0 and var_196_6 or var_196_6 * (utf8.len(var_196_8) / 35)) > 0 and var_196_6 < var_196_10 then
					arg_193_1.talkMaxDuration = var_196_10

					if var_196_10 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_5
					end
				end

				arg_193_1.text_.text = var_196_8
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251047", "story_v_out_114251.awb") ~= 0 then
					local var_196_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251047", "story_v_out_114251.awb") / 1000

					if var_196_11 + var_196_5 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_11 + var_196_5
					end

					if var_196_7.prefab_name ~= "" and arg_193_1.actors_[var_196_7.prefab_name] ~= nil then
						local var_196_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_7.prefab_name].transform, "story_v_out_114251", "114251047", "story_v_out_114251.awb")

						arg_193_1:RecordAudio("114251047", var_196_12)
						arg_193_1:RecordAudio("114251047", var_196_12)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_114251", "114251047", "story_v_out_114251.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_114251", "114251047", "story_v_out_114251.awb")
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

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play114251048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 114251048
		arg_197_1.duration_ = 8.3

		local var_197_0 = {
			ja = 8.3,
			ko = 4.8,
			zh = 5.733,
			en = 6.133
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
				arg_197_0:Play114251049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0.675

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_1 = arg_197_1:GetWordFromCfg(114251048)
				local var_200_2 = arg_197_1:FormatText(var_200_1.content)

				arg_197_1.text_.text = var_200_2

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_4 = 27 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 27)

				if (27 <= 0 and var_200_0 or var_200_0 * (utf8.len(var_200_2) / 27)) > 0 and var_200_0 < var_200_4 then
					arg_197_1.talkMaxDuration = var_200_4

					if var_200_4 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_4 + 0
					end
				end

				arg_197_1.text_.text = var_200_2
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251048", "story_v_out_114251.awb") ~= 0 then
					local var_200_5 = manager.audio:GetVoiceLength("story_v_out_114251", "114251048", "story_v_out_114251.awb") / 1000

					if var_200_5 + 0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_5 + 0
					end

					if var_200_1.prefab_name ~= "" and arg_197_1.actors_[var_200_1.prefab_name] ~= nil then
						local var_200_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_1.prefab_name].transform, "story_v_out_114251", "114251048", "story_v_out_114251.awb")

						arg_197_1:RecordAudio("114251048", var_200_6)
						arg_197_1:RecordAudio("114251048", var_200_6)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_114251", "114251048", "story_v_out_114251.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_114251", "114251048", "story_v_out_114251.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_7 = math.max(var_200_0, arg_197_1.talkMaxDuration)

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - 0) / var_200_7

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play114251049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 114251049
		arg_201_1.duration_ = 8.3

		local var_201_0 = {
			ja = 8.3,
			ko = 5.4,
			zh = 5.233,
			en = 4.8
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
				arg_201_0:Play114251050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["10021"]) and arg_201_1.var_.actorSpriteComps10021 == nil then
				arg_201_1.var_.actorSpriteComps10021 = arg_201_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_0 = 0.034

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["10021"]) then
				if arg_201_1.var_.actorSpriteComps10021 then
					for iter_204_0, iter_204_1 in pairs(arg_201_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_204_1 then
							if arg_201_1.isInRecall_ then
								iter_204_1.color = Color.New(Mathf.Lerp(iter_204_1.color.r, arg_201_1.hightColor2.r, (arg_201_1.time_ - 0) / var_204_0), Mathf.Lerp(iter_204_1.color.g, arg_201_1.hightColor2.g, (arg_201_1.time_ - 0) / var_204_0), (Mathf.Lerp(iter_204_1.color.b, arg_201_1.hightColor2.b, (arg_201_1.time_ - 0) / var_204_0)))
							else
								local var_204_1 = Mathf.Lerp(iter_204_1.color.r, 0.5, (arg_201_1.time_ - 0) / var_204_0)

								iter_204_1.color = Color.New(var_204_1, var_204_1, var_204_1)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["10021"]) and arg_201_1.var_.actorSpriteComps10021 then
				for iter_204_2, iter_204_3 in pairs(arg_201_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_204_3 then
						iter_204_3.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_201_1.var_.actorSpriteComps10021 = nil
			end

			local var_204_2 = arg_201_1.actors_["10018"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps10018 == nil then
				arg_201_1.var_.actorSpriteComps10018 = var_204_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_204_3 = 0.034

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 and not isNil(var_204_2) then
				if arg_201_1.var_.actorSpriteComps10018 then
					for iter_204_4, iter_204_5 in pairs(arg_201_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_204_5 then
							if arg_201_1.isInRecall_ then
								iter_204_5.color = Color.New(Mathf.Lerp(iter_204_5.color.r, arg_201_1.hightColor1.r, (arg_201_1.time_ - 0) / var_204_3), Mathf.Lerp(iter_204_5.color.g, arg_201_1.hightColor1.g, (arg_201_1.time_ - 0) / var_204_3), (Mathf.Lerp(iter_204_5.color.b, arg_201_1.hightColor1.b, (arg_201_1.time_ - 0) / var_204_3)))
							else
								local var_204_4 = Mathf.Lerp(iter_204_5.color.r, 1, (arg_201_1.time_ - 0) / var_204_3)

								iter_204_5.color = Color.New(var_204_4, var_204_4, var_204_4)
							end
						end
					end
				end
			end

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.actorSpriteComps10018 then
				for iter_204_6, iter_204_7 in pairs(arg_201_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_204_7 then
						iter_204_7.color = arg_201_1.isInRecall_ and (arg_201_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_201_1.var_.actorSpriteComps10018 = nil
			end

			local var_204_5 = 0
			local var_204_6 = 0.675

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_7 = arg_201_1:GetWordFromCfg(114251049)
				local var_204_8 = arg_201_1:FormatText(var_204_7.content)

				arg_201_1.text_.text = var_204_8

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_10 = 27 <= 0 and var_204_6 or var_204_6 * (utf8.len(var_204_8) / 27)

				if (27 <= 0 and var_204_6 or var_204_6 * (utf8.len(var_204_8) / 27)) > 0 and var_204_6 < var_204_10 then
					arg_201_1.talkMaxDuration = var_204_10

					if var_204_10 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_10 + var_204_5
					end
				end

				arg_201_1.text_.text = var_204_8
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251049", "story_v_out_114251.awb") ~= 0 then
					local var_204_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251049", "story_v_out_114251.awb") / 1000

					if var_204_11 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_11 + var_204_5
					end

					if var_204_7.prefab_name ~= "" and arg_201_1.actors_[var_204_7.prefab_name] ~= nil then
						local var_204_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_7.prefab_name].transform, "story_v_out_114251", "114251049", "story_v_out_114251.awb")

						arg_201_1:RecordAudio("114251049", var_204_12)
						arg_201_1:RecordAudio("114251049", var_204_12)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_114251", "114251049", "story_v_out_114251.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_114251", "114251049", "story_v_out_114251.awb")
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
	Play114251050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 114251050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play114251051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["10018"]) and arg_205_1.var_.actorSpriteComps10018 == nil then
				arg_205_1.var_.actorSpriteComps10018 = arg_205_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_208_0 = 0.034

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["10018"]) then
				if arg_205_1.var_.actorSpriteComps10018 then
					for iter_208_0, iter_208_1 in pairs(arg_205_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_208_1 then
							if arg_205_1.isInRecall_ then
								iter_208_1.color = Color.New(Mathf.Lerp(iter_208_1.color.r, arg_205_1.hightColor2.r, (arg_205_1.time_ - 0) / var_208_0), Mathf.Lerp(iter_208_1.color.g, arg_205_1.hightColor2.g, (arg_205_1.time_ - 0) / var_208_0), (Mathf.Lerp(iter_208_1.color.b, arg_205_1.hightColor2.b, (arg_205_1.time_ - 0) / var_208_0)))
							else
								local var_208_1 = Mathf.Lerp(iter_208_1.color.r, 0.5, (arg_205_1.time_ - 0) / var_208_0)

								iter_208_1.color = Color.New(var_208_1, var_208_1, var_208_1)
							end
						end
					end
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["10018"]) and arg_205_1.var_.actorSpriteComps10018 then
				for iter_208_2, iter_208_3 in pairs(arg_205_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_208_3 then
						iter_208_3.color = arg_205_1.isInRecall_ and (arg_205_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_205_1.var_.actorSpriteComps10018 = nil
			end

			local var_208_2 = 0
			local var_208_3 = 1.1

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_2 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_4 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(114251050).content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_6 = 44 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_4) / 44)

				if (44 <= 0 and var_208_3 or var_208_3 * (utf8.len(var_208_4) / 44)) > 0 and var_208_3 < var_208_6 then
					arg_205_1.talkMaxDuration = var_208_6

					if var_208_6 + var_208_2 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_6 + var_208_2
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_7 = math.max(var_208_3, arg_205_1.talkMaxDuration)

			if var_208_2 <= arg_205_1.time_ and arg_205_1.time_ < var_208_2 + var_208_7 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_2) / var_208_7

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_2 + var_208_7 and arg_205_1.time_ < var_208_2 + var_208_7 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play114251051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 114251051
		arg_209_1.duration_ = 1.9

		local var_209_0 = {
			ja = 1.233,
			ko = 1.9,
			zh = 0.999999999999,
			en = 1.6
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
				arg_209_0:Play114251052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["10021"]) and arg_209_1.var_.actorSpriteComps10021 == nil then
				arg_209_1.var_.actorSpriteComps10021 = arg_209_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_0 = 0.034

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["10021"]) then
				if arg_209_1.var_.actorSpriteComps10021 then
					for iter_212_0, iter_212_1 in pairs(arg_209_1.var_.actorSpriteComps10021:ToTable()) do
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

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["10021"]) and arg_209_1.var_.actorSpriteComps10021 then
				for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_212_3 then
						iter_212_3.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_209_1.var_.actorSpriteComps10021 = nil
			end

			local var_212_2 = 0
			local var_212_3 = 0.05

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_2 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_4 = arg_209_1:GetWordFromCfg(114251051)
				local var_212_5 = arg_209_1:FormatText(var_212_4.content)

				arg_209_1.text_.text = var_212_5

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_7 = 2 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_5) / 2)

				if (2 <= 0 and var_212_3 or var_212_3 * (utf8.len(var_212_5) / 2)) > 0 and var_212_3 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_2
					end
				end

				arg_209_1.text_.text = var_212_5
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251051", "story_v_out_114251.awb") ~= 0 then
					local var_212_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251051", "story_v_out_114251.awb") / 1000

					if var_212_8 + var_212_2 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_8 + var_212_2
					end

					if var_212_4.prefab_name ~= "" and arg_209_1.actors_[var_212_4.prefab_name] ~= nil then
						local var_212_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_4.prefab_name].transform, "story_v_out_114251", "114251051", "story_v_out_114251.awb")

						arg_209_1:RecordAudio("114251051", var_212_9)
						arg_209_1:RecordAudio("114251051", var_212_9)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_114251", "114251051", "story_v_out_114251.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_114251", "114251051", "story_v_out_114251.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_10 = math.max(var_212_3, arg_209_1.talkMaxDuration)

			if var_212_2 <= arg_209_1.time_ and arg_209_1.time_ < var_212_2 + var_212_10 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_2) / var_212_10

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_2 + var_212_10 and arg_209_1.time_ < var_212_2 + var_212_10 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play114251052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 114251052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play114251053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["10021"]) and arg_213_1.var_.actorSpriteComps10021 == nil then
				arg_213_1.var_.actorSpriteComps10021 = arg_213_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_0 = 0.034

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["10021"]) then
				if arg_213_1.var_.actorSpriteComps10021 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_216_1 then
							if arg_213_1.isInRecall_ then
								iter_216_1.color = Color.New(Mathf.Lerp(iter_216_1.color.r, arg_213_1.hightColor2.r, (arg_213_1.time_ - 0) / var_216_0), Mathf.Lerp(iter_216_1.color.g, arg_213_1.hightColor2.g, (arg_213_1.time_ - 0) / var_216_0), (Mathf.Lerp(iter_216_1.color.b, arg_213_1.hightColor2.b, (arg_213_1.time_ - 0) / var_216_0)))
							else
								local var_216_1 = Mathf.Lerp(iter_216_1.color.r, 0.5, (arg_213_1.time_ - 0) / var_216_0)

								iter_216_1.color = Color.New(var_216_1, var_216_1, var_216_1)
							end
						end
					end
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["10021"]) and arg_213_1.var_.actorSpriteComps10021 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_216_3 then
						iter_216_3.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_213_1.var_.actorSpriteComps10021 = nil
			end

			local var_216_2 = 0
			local var_216_3 = 0.825

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_2 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_4 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(114251052).content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_6 = 33 <= 0 and var_216_3 or var_216_3 * (utf8.len(var_216_4) / 33)

				if (33 <= 0 and var_216_3 or var_216_3 * (utf8.len(var_216_4) / 33)) > 0 and var_216_3 < var_216_6 then
					arg_213_1.talkMaxDuration = var_216_6

					if var_216_6 + var_216_2 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_2
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_3, arg_213_1.talkMaxDuration)

			if var_216_2 <= arg_213_1.time_ and arg_213_1.time_ < var_216_2 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_2) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_2 + var_216_7 and arg_213_1.time_ < var_216_2 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play114251053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 114251053
		arg_217_1.duration_ = 7.33

		local var_217_0 = {
			ja = 6.1,
			ko = 7.333,
			zh = 7.266,
			en = 6.533
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
				arg_217_0:Play114251054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["10021"]) and arg_217_1.var_.actorSpriteComps10021 == nil then
				arg_217_1.var_.actorSpriteComps10021 = arg_217_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_0 = 0.034

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["10021"]) then
				if arg_217_1.var_.actorSpriteComps10021 then
					for iter_220_0, iter_220_1 in pairs(arg_217_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_220_1 then
							if arg_217_1.isInRecall_ then
								iter_220_1.color = Color.New(Mathf.Lerp(iter_220_1.color.r, arg_217_1.hightColor1.r, (arg_217_1.time_ - 0) / var_220_0), Mathf.Lerp(iter_220_1.color.g, arg_217_1.hightColor1.g, (arg_217_1.time_ - 0) / var_220_0), (Mathf.Lerp(iter_220_1.color.b, arg_217_1.hightColor1.b, (arg_217_1.time_ - 0) / var_220_0)))
							else
								local var_220_1 = Mathf.Lerp(iter_220_1.color.r, 1, (arg_217_1.time_ - 0) / var_220_0)

								iter_220_1.color = Color.New(var_220_1, var_220_1, var_220_1)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["10021"]) and arg_217_1.var_.actorSpriteComps10021 then
				for iter_220_2, iter_220_3 in pairs(arg_217_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_220_3 then
						iter_220_3.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_217_1.var_.actorSpriteComps10021 = nil
			end

			local var_220_2 = 0
			local var_220_3 = 0.725

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_2 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_4 = arg_217_1:GetWordFromCfg(114251053)
				local var_220_5 = arg_217_1:FormatText(var_220_4.content)

				arg_217_1.text_.text = var_220_5

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_7 = 28 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_5) / 28)

				if (28 <= 0 and var_220_3 or var_220_3 * (utf8.len(var_220_5) / 28)) > 0 and var_220_3 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_2
					end
				end

				arg_217_1.text_.text = var_220_5
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251053", "story_v_out_114251.awb") ~= 0 then
					local var_220_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251053", "story_v_out_114251.awb") / 1000

					if var_220_8 + var_220_2 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_8 + var_220_2
					end

					if var_220_4.prefab_name ~= "" and arg_217_1.actors_[var_220_4.prefab_name] ~= nil then
						local var_220_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_4.prefab_name].transform, "story_v_out_114251", "114251053", "story_v_out_114251.awb")

						arg_217_1:RecordAudio("114251053", var_220_9)
						arg_217_1:RecordAudio("114251053", var_220_9)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_114251", "114251053", "story_v_out_114251.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_114251", "114251053", "story_v_out_114251.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_10 = math.max(var_220_3, arg_217_1.talkMaxDuration)

			if var_220_2 <= arg_217_1.time_ and arg_217_1.time_ < var_220_2 + var_220_10 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_2) / var_220_10

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_2 + var_220_10 and arg_217_1.time_ < var_220_2 + var_220_10 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play114251054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 114251054
		arg_221_1.duration_ = 10.07

		local var_221_0 = {
			ja = 10.066,
			ko = 7.366,
			zh = 6.233,
			en = 6.2
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
				arg_221_0:Play114251055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.var_.moveOldPos10018 = arg_221_1.actors_["10018"].transform.localPosition
				arg_221_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_221_1:CheckSpriteTmpPos("10018", 4)

				for iter_224_0 = 0, arg_221_1.actors_["10018"].transform.childCount - 1 do
					local var_224_0 = arg_221_1.actors_["10018"].transform:GetChild(iter_224_0)

					if var_224_0.name == "split_4" or not string.find(var_224_0.name, "split") then
						var_224_0.gameObject:SetActive(true)
					else
						var_224_0.gameObject:SetActive(false)
					end
				end
			end

			local var_224_1 = 0.001

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_1 then
				arg_221_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10018, Vector3.New(390, -350, -180), (arg_221_1.time_ - 0) / var_224_1)
			end

			if arg_221_1.time_ >= 0 + var_224_1 and arg_221_1.time_ < 0 + var_224_1 + arg_224_0 then
				arg_221_1.actors_["10018"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_224_2 = arg_221_1.actors_["10021"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps10021 == nil then
				arg_221_1.var_.actorSpriteComps10021 = var_224_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_3 = 0.034

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_3 and not isNil(var_224_2) then
				if arg_221_1.var_.actorSpriteComps10021 then
					for iter_224_1, iter_224_2 in pairs(arg_221_1.var_.actorSpriteComps10021:ToTable()) do
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

			if arg_221_1.time_ >= 0 + var_224_3 and arg_221_1.time_ < 0 + var_224_3 + arg_224_0 and not isNil(var_224_2) and arg_221_1.var_.actorSpriteComps10021 then
				for iter_224_3, iter_224_4 in pairs(arg_221_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_224_4 then
						iter_224_4.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_221_1.var_.actorSpriteComps10021 = nil
			end

			local var_224_5 = arg_221_1.actors_["10018"]

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(var_224_5) and arg_221_1.var_.actorSpriteComps10018 == nil then
				arg_221_1.var_.actorSpriteComps10018 = var_224_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_224_6 = 0.034

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_6 and not isNil(var_224_5) then
				if arg_221_1.var_.actorSpriteComps10018 then
					for iter_224_5, iter_224_6 in pairs(arg_221_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_221_1.time_ >= 0 + var_224_6 and arg_221_1.time_ < 0 + var_224_6 + arg_224_0 and not isNil(var_224_5) and arg_221_1.var_.actorSpriteComps10018 then
				for iter_224_7, iter_224_8 in pairs(arg_221_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_224_8 then
						iter_224_8.color = arg_221_1.isInRecall_ and (arg_221_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_221_1.var_.actorSpriteComps10018 = nil
			end

			local var_224_8 = 0
			local var_224_9 = 0.75

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_8 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_10 = arg_221_1:GetWordFromCfg(114251054)
				local var_224_11 = arg_221_1:FormatText(var_224_10.content)

				arg_221_1.text_.text = var_224_11

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_13 = 30 <= 0 and var_224_9 or var_224_9 * (utf8.len(var_224_11) / 30)

				if (30 <= 0 and var_224_9 or var_224_9 * (utf8.len(var_224_11) / 30)) > 0 and var_224_9 < var_224_13 then
					arg_221_1.talkMaxDuration = var_224_13

					if var_224_13 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_13 + var_224_8
					end
				end

				arg_221_1.text_.text = var_224_11
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251054", "story_v_out_114251.awb") ~= 0 then
					local var_224_14 = manager.audio:GetVoiceLength("story_v_out_114251", "114251054", "story_v_out_114251.awb") / 1000

					if var_224_14 + var_224_8 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_14 + var_224_8
					end

					if var_224_10.prefab_name ~= "" and arg_221_1.actors_[var_224_10.prefab_name] ~= nil then
						local var_224_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_10.prefab_name].transform, "story_v_out_114251", "114251054", "story_v_out_114251.awb")

						arg_221_1:RecordAudio("114251054", var_224_15)
						arg_221_1:RecordAudio("114251054", var_224_15)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_114251", "114251054", "story_v_out_114251.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_114251", "114251054", "story_v_out_114251.awb")
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
				actorName = "10018",
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
	Play114251055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 114251055
		arg_225_1.duration_ = 6.97

		local var_225_0 = {
			ja = 6.966,
			ko = 4.833,
			zh = 2.966,
			en = 3
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
				arg_225_0:Play114251056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["10021"]) and arg_225_1.var_.actorSpriteComps10021 == nil then
				arg_225_1.var_.actorSpriteComps10021 = arg_225_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_0 = 0.034

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["10021"]) then
				if arg_225_1.var_.actorSpriteComps10021 then
					for iter_228_0, iter_228_1 in pairs(arg_225_1.var_.actorSpriteComps10021:ToTable()) do
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

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["10021"]) and arg_225_1.var_.actorSpriteComps10021 then
				for iter_228_2, iter_228_3 in pairs(arg_225_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_228_3 then
						iter_228_3.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_225_1.var_.actorSpriteComps10021 = nil
			end

			local var_228_2 = arg_225_1.actors_["10018"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_2) and arg_225_1.var_.actorSpriteComps10018 == nil then
				arg_225_1.var_.actorSpriteComps10018 = var_228_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_228_3 = 0.034

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_3 and not isNil(var_228_2) then
				if arg_225_1.var_.actorSpriteComps10018 then
					for iter_228_4, iter_228_5 in pairs(arg_225_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_228_5 then
							if arg_225_1.isInRecall_ then
								iter_228_5.color = Color.New(Mathf.Lerp(iter_228_5.color.r, arg_225_1.hightColor2.r, (arg_225_1.time_ - 0) / var_228_3), Mathf.Lerp(iter_228_5.color.g, arg_225_1.hightColor2.g, (arg_225_1.time_ - 0) / var_228_3), (Mathf.Lerp(iter_228_5.color.b, arg_225_1.hightColor2.b, (arg_225_1.time_ - 0) / var_228_3)))
							else
								local var_228_4 = Mathf.Lerp(iter_228_5.color.r, 0.5, (arg_225_1.time_ - 0) / var_228_3)

								iter_228_5.color = Color.New(var_228_4, var_228_4, var_228_4)
							end
						end
					end
				end
			end

			if arg_225_1.time_ >= 0 + var_228_3 and arg_225_1.time_ < 0 + var_228_3 + arg_228_0 and not isNil(var_228_2) and arg_225_1.var_.actorSpriteComps10018 then
				for iter_228_6, iter_228_7 in pairs(arg_225_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_228_7 then
						iter_228_7.color = arg_225_1.isInRecall_ and (arg_225_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_225_1.var_.actorSpriteComps10018 = nil
			end

			local var_228_5 = 0
			local var_228_6 = 0.35

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_5 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_7 = arg_225_1:GetWordFromCfg(114251055)
				local var_228_8 = arg_225_1:FormatText(var_228_7.content)

				arg_225_1.text_.text = var_228_8

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_10 = 14 <= 0 and var_228_6 or var_228_6 * (utf8.len(var_228_8) / 14)

				if (14 <= 0 and var_228_6 or var_228_6 * (utf8.len(var_228_8) / 14)) > 0 and var_228_6 < var_228_10 then
					arg_225_1.talkMaxDuration = var_228_10

					if var_228_10 + var_228_5 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_10 + var_228_5
					end
				end

				arg_225_1.text_.text = var_228_8
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251055", "story_v_out_114251.awb") ~= 0 then
					local var_228_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251055", "story_v_out_114251.awb") / 1000

					if var_228_11 + var_228_5 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_11 + var_228_5
					end

					if var_228_7.prefab_name ~= "" and arg_225_1.actors_[var_228_7.prefab_name] ~= nil then
						local var_228_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_7.prefab_name].transform, "story_v_out_114251", "114251055", "story_v_out_114251.awb")

						arg_225_1:RecordAudio("114251055", var_228_12)
						arg_225_1:RecordAudio("114251055", var_228_12)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_114251", "114251055", "story_v_out_114251.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_114251", "114251055", "story_v_out_114251.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_13 = math.max(var_228_6, arg_225_1.talkMaxDuration)

			if var_228_5 <= arg_225_1.time_ and arg_225_1.time_ < var_228_5 + var_228_13 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_5) / var_228_13

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_5 + var_228_13 and arg_225_1.time_ < var_228_5 + var_228_13 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play114251056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 114251056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play114251057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["10021"]) and arg_229_1.var_.actorSpriteComps10021 == nil then
				arg_229_1.var_.actorSpriteComps10021 = arg_229_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_0 = 0.034

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["10021"]) then
				if arg_229_1.var_.actorSpriteComps10021 then
					for iter_232_0, iter_232_1 in pairs(arg_229_1.var_.actorSpriteComps10021:ToTable()) do
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

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["10021"]) and arg_229_1.var_.actorSpriteComps10021 then
				for iter_232_2, iter_232_3 in pairs(arg_229_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_232_3 then
						iter_232_3.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_229_1.var_.actorSpriteComps10021 = nil
			end

			local var_232_2 = 0
			local var_232_3 = 0.7

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_2 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_4 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(114251056).content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_6 = 28 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_4) / 28)

				if (28 <= 0 and var_232_3 or var_232_3 * (utf8.len(var_232_4) / 28)) > 0 and var_232_3 < var_232_6 then
					arg_229_1.talkMaxDuration = var_232_6

					if var_232_6 + var_232_2 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_6 + var_232_2
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_7 = math.max(var_232_3, arg_229_1.talkMaxDuration)

			if var_232_2 <= arg_229_1.time_ and arg_229_1.time_ < var_232_2 + var_232_7 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_2) / var_232_7

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_2 + var_232_7 and arg_229_1.time_ < var_232_2 + var_232_7 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play114251057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 114251057
		arg_233_1.duration_ = 11.93

		local var_233_0 = {
			ja = 11.933,
			ko = 8.866,
			zh = 9.266,
			en = 8.9
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
				arg_233_0:Play114251058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["10021"]) and arg_233_1.var_.actorSpriteComps10021 == nil then
				arg_233_1.var_.actorSpriteComps10021 = arg_233_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_236_0 = 0.034

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["10021"]) then
				if arg_233_1.var_.actorSpriteComps10021 then
					for iter_236_0, iter_236_1 in pairs(arg_233_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_236_1 then
							if arg_233_1.isInRecall_ then
								iter_236_1.color = Color.New(Mathf.Lerp(iter_236_1.color.r, arg_233_1.hightColor1.r, (arg_233_1.time_ - 0) / var_236_0), Mathf.Lerp(iter_236_1.color.g, arg_233_1.hightColor1.g, (arg_233_1.time_ - 0) / var_236_0), (Mathf.Lerp(iter_236_1.color.b, arg_233_1.hightColor1.b, (arg_233_1.time_ - 0) / var_236_0)))
							else
								local var_236_1 = Mathf.Lerp(iter_236_1.color.r, 1, (arg_233_1.time_ - 0) / var_236_0)

								iter_236_1.color = Color.New(var_236_1, var_236_1, var_236_1)
							end
						end
					end
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["10021"]) and arg_233_1.var_.actorSpriteComps10021 then
				for iter_236_2, iter_236_3 in pairs(arg_233_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_236_3 then
						iter_236_3.color = arg_233_1.isInRecall_ and (arg_233_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_233_1.var_.actorSpriteComps10021 = nil
			end

			local var_236_2 = 0
			local var_236_3 = 1.125

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_2 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_4 = arg_233_1:GetWordFromCfg(114251057)
				local var_236_5 = arg_233_1:FormatText(var_236_4.content)

				arg_233_1.text_.text = var_236_5

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_7 = 45 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 45)

				if (45 <= 0 and var_236_3 or var_236_3 * (utf8.len(var_236_5) / 45)) > 0 and var_236_3 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_2
					end
				end

				arg_233_1.text_.text = var_236_5
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251057", "story_v_out_114251.awb") ~= 0 then
					local var_236_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251057", "story_v_out_114251.awb") / 1000

					if var_236_8 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_2
					end

					if var_236_4.prefab_name ~= "" and arg_233_1.actors_[var_236_4.prefab_name] ~= nil then
						local var_236_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_4.prefab_name].transform, "story_v_out_114251", "114251057", "story_v_out_114251.awb")

						arg_233_1:RecordAudio("114251057", var_236_9)
						arg_233_1:RecordAudio("114251057", var_236_9)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_114251", "114251057", "story_v_out_114251.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_114251", "114251057", "story_v_out_114251.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_10 = math.max(var_236_3, arg_233_1.talkMaxDuration)

			if var_236_2 <= arg_233_1.time_ and arg_233_1.time_ < var_236_2 + var_236_10 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_2) / var_236_10

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_2 + var_236_10 and arg_233_1.time_ < var_236_2 + var_236_10 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play114251058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 114251058
		arg_237_1.duration_ = 8.27

		local var_237_0 = {
			ja = 6.5,
			ko = 6.733,
			zh = 8.266,
			en = 6.933
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
				arg_237_0:Play114251059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos10018 = arg_237_1.actors_["10018"].transform.localPosition
				arg_237_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_237_1:CheckSpriteTmpPos("10018", 4)

				for iter_240_0 = 0, arg_237_1.actors_["10018"].transform.childCount - 1 do
					local var_240_0 = arg_237_1.actors_["10018"].transform:GetChild(iter_240_0)

					if var_240_0.name == "split_4" or not string.find(var_240_0.name, "split") then
						var_240_0.gameObject:SetActive(true)
					else
						var_240_0.gameObject:SetActive(false)
					end
				end
			end

			local var_240_1 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_1 then
				arg_237_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10018, Vector3.New(390, -350, -180), (arg_237_1.time_ - 0) / var_240_1)
			end

			if arg_237_1.time_ >= 0 + var_240_1 and arg_237_1.time_ < 0 + var_240_1 + arg_240_0 then
				arg_237_1.actors_["10018"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_240_2 = arg_237_1.actors_["10021"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.actorSpriteComps10021 == nil then
				arg_237_1.var_.actorSpriteComps10021 = var_240_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_3 = 0.034

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_3 and not isNil(var_240_2) then
				if arg_237_1.var_.actorSpriteComps10021 then
					for iter_240_1, iter_240_2 in pairs(arg_237_1.var_.actorSpriteComps10021:ToTable()) do
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

			if arg_237_1.time_ >= 0 + var_240_3 and arg_237_1.time_ < 0 + var_240_3 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.actorSpriteComps10021 then
				for iter_240_3, iter_240_4 in pairs(arg_237_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_240_4 then
						iter_240_4.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_237_1.var_.actorSpriteComps10021 = nil
			end

			local var_240_5 = arg_237_1.actors_["10018"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.actorSpriteComps10018 == nil then
				arg_237_1.var_.actorSpriteComps10018 = var_240_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_240_6 = 0.034

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_6 and not isNil(var_240_5) then
				if arg_237_1.var_.actorSpriteComps10018 then
					for iter_240_5, iter_240_6 in pairs(arg_237_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_237_1.time_ >= 0 + var_240_6 and arg_237_1.time_ < 0 + var_240_6 + arg_240_0 and not isNil(var_240_5) and arg_237_1.var_.actorSpriteComps10018 then
				for iter_240_7, iter_240_8 in pairs(arg_237_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_240_8 then
						iter_240_8.color = arg_237_1.isInRecall_ and (arg_237_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_237_1.var_.actorSpriteComps10018 = nil
			end

			local var_240_8 = 0
			local var_240_9 = 0.75

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_8 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_10 = arg_237_1:GetWordFromCfg(114251058)
				local var_240_11 = arg_237_1:FormatText(var_240_10.content)

				arg_237_1.text_.text = var_240_11

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_13 = 30 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 30)

				if (30 <= 0 and var_240_9 or var_240_9 * (utf8.len(var_240_11) / 30)) > 0 and var_240_9 < var_240_13 then
					arg_237_1.talkMaxDuration = var_240_13

					if var_240_13 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_13 + var_240_8
					end
				end

				arg_237_1.text_.text = var_240_11
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251058", "story_v_out_114251.awb") ~= 0 then
					local var_240_14 = manager.audio:GetVoiceLength("story_v_out_114251", "114251058", "story_v_out_114251.awb") / 1000

					if var_240_14 + var_240_8 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_14 + var_240_8
					end

					if var_240_10.prefab_name ~= "" and arg_237_1.actors_[var_240_10.prefab_name] ~= nil then
						local var_240_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_10.prefab_name].transform, "story_v_out_114251", "114251058", "story_v_out_114251.awb")

						arg_237_1:RecordAudio("114251058", var_240_15)
						arg_237_1:RecordAudio("114251058", var_240_15)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_114251", "114251058", "story_v_out_114251.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_114251", "114251058", "story_v_out_114251.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_16 = math.max(var_240_9, arg_237_1.talkMaxDuration)

			if var_240_8 <= arg_237_1.time_ and arg_237_1.time_ < var_240_8 + var_240_16 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_8) / var_240_16

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_8 + var_240_16 and arg_237_1.time_ < var_240_8 + var_240_16 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114251059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 114251059
		arg_241_1.duration_ = 9.33

		local var_241_0 = {
			ja = 9.333,
			ko = 8.1,
			zh = 7.366,
			en = 7.933
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
				arg_241_0:Play114251060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["10021"]) and arg_241_1.var_.actorSpriteComps10021 == nil then
				arg_241_1.var_.actorSpriteComps10021 = arg_241_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_0 = 0.034

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["10021"]) then
				if arg_241_1.var_.actorSpriteComps10021 then
					for iter_244_0, iter_244_1 in pairs(arg_241_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_244_1 then
							if arg_241_1.isInRecall_ then
								iter_244_1.color = Color.New(Mathf.Lerp(iter_244_1.color.r, arg_241_1.hightColor1.r, (arg_241_1.time_ - 0) / var_244_0), Mathf.Lerp(iter_244_1.color.g, arg_241_1.hightColor1.g, (arg_241_1.time_ - 0) / var_244_0), (Mathf.Lerp(iter_244_1.color.b, arg_241_1.hightColor1.b, (arg_241_1.time_ - 0) / var_244_0)))
							else
								local var_244_1 = Mathf.Lerp(iter_244_1.color.r, 1, (arg_241_1.time_ - 0) / var_244_0)

								iter_244_1.color = Color.New(var_244_1, var_244_1, var_244_1)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["10021"]) and arg_241_1.var_.actorSpriteComps10021 then
				for iter_244_2, iter_244_3 in pairs(arg_241_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_244_3 then
						iter_244_3.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_241_1.var_.actorSpriteComps10021 = nil
			end

			local var_244_2 = arg_241_1.actors_["10018"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.actorSpriteComps10018 == nil then
				arg_241_1.var_.actorSpriteComps10018 = var_244_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_244_3 = 0.034

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_3 and not isNil(var_244_2) then
				if arg_241_1.var_.actorSpriteComps10018 then
					for iter_244_4, iter_244_5 in pairs(arg_241_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_244_5 then
							if arg_241_1.isInRecall_ then
								iter_244_5.color = Color.New(Mathf.Lerp(iter_244_5.color.r, arg_241_1.hightColor2.r, (arg_241_1.time_ - 0) / var_244_3), Mathf.Lerp(iter_244_5.color.g, arg_241_1.hightColor2.g, (arg_241_1.time_ - 0) / var_244_3), (Mathf.Lerp(iter_244_5.color.b, arg_241_1.hightColor2.b, (arg_241_1.time_ - 0) / var_244_3)))
							else
								local var_244_4 = Mathf.Lerp(iter_244_5.color.r, 0.5, (arg_241_1.time_ - 0) / var_244_3)

								iter_244_5.color = Color.New(var_244_4, var_244_4, var_244_4)
							end
						end
					end
				end
			end

			if arg_241_1.time_ >= 0 + var_244_3 and arg_241_1.time_ < 0 + var_244_3 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.actorSpriteComps10018 then
				for iter_244_6, iter_244_7 in pairs(arg_241_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_244_7 then
						iter_244_7.color = arg_241_1.isInRecall_ and (arg_241_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_241_1.var_.actorSpriteComps10018 = nil
			end

			local var_244_5 = 0
			local var_244_6 = 0.95

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_7 = arg_241_1:GetWordFromCfg(114251059)
				local var_244_8 = arg_241_1:FormatText(var_244_7.content)

				arg_241_1.text_.text = var_244_8

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_10 = 37 <= 0 and var_244_6 or var_244_6 * (utf8.len(var_244_8) / 37)

				if (37 <= 0 and var_244_6 or var_244_6 * (utf8.len(var_244_8) / 37)) > 0 and var_244_6 < var_244_10 then
					arg_241_1.talkMaxDuration = var_244_10

					if var_244_10 + var_244_5 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_10 + var_244_5
					end
				end

				arg_241_1.text_.text = var_244_8
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251059", "story_v_out_114251.awb") ~= 0 then
					local var_244_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251059", "story_v_out_114251.awb") / 1000

					if var_244_11 + var_244_5 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_11 + var_244_5
					end

					if var_244_7.prefab_name ~= "" and arg_241_1.actors_[var_244_7.prefab_name] ~= nil then
						local var_244_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_7.prefab_name].transform, "story_v_out_114251", "114251059", "story_v_out_114251.awb")

						arg_241_1:RecordAudio("114251059", var_244_12)
						arg_241_1:RecordAudio("114251059", var_244_12)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_114251", "114251059", "story_v_out_114251.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_114251", "114251059", "story_v_out_114251.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_13 = math.max(var_244_6, arg_241_1.talkMaxDuration)

			if var_244_5 <= arg_241_1.time_ and arg_241_1.time_ < var_244_5 + var_244_13 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_5) / var_244_13

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_5 + var_244_13 and arg_241_1.time_ < var_244_5 + var_244_13 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play114251060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 114251060
		arg_245_1.duration_ = 12.57

		local var_245_0 = {
			ja = 12.566,
			ko = 6.966,
			zh = 7.4,
			en = 6.4
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
				arg_245_0:Play114251061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0.975

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:GetWordFromCfg(114251060)
				local var_248_2 = arg_245_1:FormatText(var_248_1.content)

				arg_245_1.text_.text = var_248_2

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 38 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 38)

				if (38 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_2) / 38)) > 0 and var_248_0 < var_248_4 then
					arg_245_1.talkMaxDuration = var_248_4

					if var_248_4 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_4 + 0
					end
				end

				arg_245_1.text_.text = var_248_2
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251060", "story_v_out_114251.awb") ~= 0 then
					local var_248_5 = manager.audio:GetVoiceLength("story_v_out_114251", "114251060", "story_v_out_114251.awb") / 1000

					if var_248_5 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + 0
					end

					if var_248_1.prefab_name ~= "" and arg_245_1.actors_[var_248_1.prefab_name] ~= nil then
						local var_248_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_1.prefab_name].transform, "story_v_out_114251", "114251060", "story_v_out_114251.awb")

						arg_245_1:RecordAudio("114251060", var_248_6)
						arg_245_1:RecordAudio("114251060", var_248_6)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_114251", "114251060", "story_v_out_114251.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_114251", "114251060", "story_v_out_114251.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_7 and arg_245_1.time_ < 0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play114251061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 114251061
		arg_249_1.duration_ = 18.1

		local var_249_0 = {
			ja = 15.766,
			ko = 11.066,
			zh = 11.133,
			en = 18.1
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
				arg_249_0:Play114251062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 1.375

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_1 = arg_249_1:GetWordFromCfg(114251061)
				local var_252_2 = arg_249_1:FormatText(var_252_1.content)

				arg_249_1.text_.text = var_252_2

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 54 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 54)

				if (54 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 54)) > 0 and var_252_0 < var_252_4 then
					arg_249_1.talkMaxDuration = var_252_4

					if var_252_4 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_4 + 0
					end
				end

				arg_249_1.text_.text = var_252_2
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251061", "story_v_out_114251.awb") ~= 0 then
					local var_252_5 = manager.audio:GetVoiceLength("story_v_out_114251", "114251061", "story_v_out_114251.awb") / 1000

					if var_252_5 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + 0
					end

					if var_252_1.prefab_name ~= "" and arg_249_1.actors_[var_252_1.prefab_name] ~= nil then
						local var_252_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_1.prefab_name].transform, "story_v_out_114251", "114251061", "story_v_out_114251.awb")

						arg_249_1:RecordAudio("114251061", var_252_6)
						arg_249_1:RecordAudio("114251061", var_252_6)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_114251", "114251061", "story_v_out_114251.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_114251", "114251061", "story_v_out_114251.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play114251062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 114251062
		arg_253_1.duration_ = 6.73

		local var_253_0 = {
			ja = 6.733,
			ko = 3.033,
			zh = 2.766,
			en = 3.666
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
				arg_253_0:Play114251063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(arg_253_1.actors_["10021"]) and arg_253_1.var_.actorSpriteComps10021 == nil then
				arg_253_1.var_.actorSpriteComps10021 = arg_253_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_0 = 0.034

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 and not isNil(arg_253_1.actors_["10021"]) then
				if arg_253_1.var_.actorSpriteComps10021 then
					for iter_256_0, iter_256_1 in pairs(arg_253_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_256_1 then
							if arg_253_1.isInRecall_ then
								iter_256_1.color = Color.New(Mathf.Lerp(iter_256_1.color.r, arg_253_1.hightColor2.r, (arg_253_1.time_ - 0) / var_256_0), Mathf.Lerp(iter_256_1.color.g, arg_253_1.hightColor2.g, (arg_253_1.time_ - 0) / var_256_0), (Mathf.Lerp(iter_256_1.color.b, arg_253_1.hightColor2.b, (arg_253_1.time_ - 0) / var_256_0)))
							else
								local var_256_1 = Mathf.Lerp(iter_256_1.color.r, 0.5, (arg_253_1.time_ - 0) / var_256_0)

								iter_256_1.color = Color.New(var_256_1, var_256_1, var_256_1)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 and not isNil(arg_253_1.actors_["10021"]) and arg_253_1.var_.actorSpriteComps10021 then
				for iter_256_2, iter_256_3 in pairs(arg_253_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_256_3 then
						iter_256_3.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_253_1.var_.actorSpriteComps10021 = nil
			end

			local var_256_2 = arg_253_1.actors_["10018"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps10018 == nil then
				arg_253_1.var_.actorSpriteComps10018 = var_256_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_256_3 = 0.034

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_3 and not isNil(var_256_2) then
				if arg_253_1.var_.actorSpriteComps10018 then
					for iter_256_4, iter_256_5 in pairs(arg_253_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_256_5 then
							if arg_253_1.isInRecall_ then
								iter_256_5.color = Color.New(Mathf.Lerp(iter_256_5.color.r, arg_253_1.hightColor1.r, (arg_253_1.time_ - 0) / var_256_3), Mathf.Lerp(iter_256_5.color.g, arg_253_1.hightColor1.g, (arg_253_1.time_ - 0) / var_256_3), (Mathf.Lerp(iter_256_5.color.b, arg_253_1.hightColor1.b, (arg_253_1.time_ - 0) / var_256_3)))
							else
								local var_256_4 = Mathf.Lerp(iter_256_5.color.r, 1, (arg_253_1.time_ - 0) / var_256_3)

								iter_256_5.color = Color.New(var_256_4, var_256_4, var_256_4)
							end
						end
					end
				end
			end

			if arg_253_1.time_ >= 0 + var_256_3 and arg_253_1.time_ < 0 + var_256_3 + arg_256_0 and not isNil(var_256_2) and arg_253_1.var_.actorSpriteComps10018 then
				for iter_256_6, iter_256_7 in pairs(arg_253_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_256_7 then
						iter_256_7.color = arg_253_1.isInRecall_ and (arg_253_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_253_1.var_.actorSpriteComps10018 = nil
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				local var_256_5 = arg_253_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_256_5 then
					arg_253_1.var_.alphaOldValue10018 = var_256_5.alpha
					arg_253_1.var_.characterEffect10018 = var_256_5
				end

				arg_253_1.var_.alphaOldValue10018 = 0
			end

			local var_256_6 = 0.0166666666666667

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_6 then
				if arg_253_1.var_.characterEffect10018 then
					arg_253_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_253_1.var_.alphaOldValue10018, 1, (arg_253_1.time_ - 0) / var_256_6)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_6 and arg_253_1.time_ < 0 + var_256_6 + arg_256_0 and arg_253_1.var_.characterEffect10018 then
				arg_253_1.var_.characterEffect10018.alpha = 1
			end

			local var_256_7 = 0
			local var_256_8 = 0.2

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_7 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_9 = arg_253_1:GetWordFromCfg(114251062)
				local var_256_10 = arg_253_1:FormatText(var_256_9.content)

				arg_253_1.text_.text = var_256_10

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_12 = 8 <= 0 and var_256_8 or var_256_8 * (utf8.len(var_256_10) / 8)

				if (8 <= 0 and var_256_8 or var_256_8 * (utf8.len(var_256_10) / 8)) > 0 and var_256_8 < var_256_12 then
					arg_253_1.talkMaxDuration = var_256_12

					if var_256_12 + var_256_7 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_12 + var_256_7
					end
				end

				arg_253_1.text_.text = var_256_10
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251062", "story_v_out_114251.awb") ~= 0 then
					local var_256_13 = manager.audio:GetVoiceLength("story_v_out_114251", "114251062", "story_v_out_114251.awb") / 1000

					if var_256_13 + var_256_7 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_7
					end

					if var_256_9.prefab_name ~= "" and arg_253_1.actors_[var_256_9.prefab_name] ~= nil then
						local var_256_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_9.prefab_name].transform, "story_v_out_114251", "114251062", "story_v_out_114251.awb")

						arg_253_1:RecordAudio("114251062", var_256_14)
						arg_253_1:RecordAudio("114251062", var_256_14)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_114251", "114251062", "story_v_out_114251.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_114251", "114251062", "story_v_out_114251.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_15 = math.max(var_256_8, arg_253_1.talkMaxDuration)

			if var_256_7 <= arg_253_1.time_ and arg_253_1.time_ < var_256_7 + var_256_15 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_7) / var_256_15

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_7 + var_256_15 and arg_253_1.time_ < var_256_7 + var_256_15 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play114251063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 114251063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play114251064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["10018"]) and arg_257_1.var_.actorSpriteComps10018 == nil then
				arg_257_1.var_.actorSpriteComps10018 = arg_257_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_260_0 = 0.034

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["10018"]) then
				if arg_257_1.var_.actorSpriteComps10018 then
					for iter_260_0, iter_260_1 in pairs(arg_257_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_260_1 then
							if arg_257_1.isInRecall_ then
								iter_260_1.color = Color.New(Mathf.Lerp(iter_260_1.color.r, arg_257_1.hightColor2.r, (arg_257_1.time_ - 0) / var_260_0), Mathf.Lerp(iter_260_1.color.g, arg_257_1.hightColor2.g, (arg_257_1.time_ - 0) / var_260_0), (Mathf.Lerp(iter_260_1.color.b, arg_257_1.hightColor2.b, (arg_257_1.time_ - 0) / var_260_0)))
							else
								local var_260_1 = Mathf.Lerp(iter_260_1.color.r, 0.5, (arg_257_1.time_ - 0) / var_260_0)

								iter_260_1.color = Color.New(var_260_1, var_260_1, var_260_1)
							end
						end
					end
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["10018"]) and arg_257_1.var_.actorSpriteComps10018 then
				for iter_260_2, iter_260_3 in pairs(arg_257_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_260_3 then
						iter_260_3.color = arg_257_1.isInRecall_ and (arg_257_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_257_1.var_.actorSpriteComps10018 = nil
			end

			local var_260_2 = 0
			local var_260_3 = 0.525

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_2 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, false)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_4 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(114251063).content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_6 = 21 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_4) / 21)

				if (21 <= 0 and var_260_3 or var_260_3 * (utf8.len(var_260_4) / 21)) > 0 and var_260_3 < var_260_6 then
					arg_257_1.talkMaxDuration = var_260_6

					if var_260_6 + var_260_2 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_6 + var_260_2
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_3, arg_257_1.talkMaxDuration)

			if var_260_2 <= arg_257_1.time_ and arg_257_1.time_ < var_260_2 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_2) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_2 + var_260_7 and arg_257_1.time_ < var_260_2 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play114251064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 114251064
		arg_261_1.duration_ = 3.93

		local var_261_0 = {
			ja = 2.3,
			ko = 2.966,
			zh = 2.633,
			en = 3.933
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play114251065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.var_.moveOldPos10018 = arg_261_1.actors_["10018"].transform.localPosition
				arg_261_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_261_1:CheckSpriteTmpPos("10018", 4)

				for iter_264_0 = 0, arg_261_1.actors_["10018"].transform.childCount - 1 do
					local var_264_0 = arg_261_1.actors_["10018"].transform:GetChild(iter_264_0)

					if var_264_0.name == "split_2" or not string.find(var_264_0.name, "split") then
						var_264_0.gameObject:SetActive(true)
					else
						var_264_0.gameObject:SetActive(false)
					end
				end
			end

			local var_264_1 = 0.001

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_1 then
				arg_261_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10018, Vector3.New(390, -350, -180), (arg_261_1.time_ - 0) / var_264_1)
			end

			if arg_261_1.time_ >= 0 + var_264_1 and arg_261_1.time_ < 0 + var_264_1 + arg_264_0 then
				arg_261_1.actors_["10018"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_264_2 = arg_261_1.actors_["10018"]

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps10018 == nil then
				arg_261_1.var_.actorSpriteComps10018 = var_264_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_264_3 = 0.034

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_3 and not isNil(var_264_2) then
				if arg_261_1.var_.actorSpriteComps10018 then
					for iter_264_1, iter_264_2 in pairs(arg_261_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_264_2 then
							if arg_261_1.isInRecall_ then
								iter_264_2.color = Color.New(Mathf.Lerp(iter_264_2.color.r, arg_261_1.hightColor1.r, (arg_261_1.time_ - 0) / var_264_3), Mathf.Lerp(iter_264_2.color.g, arg_261_1.hightColor1.g, (arg_261_1.time_ - 0) / var_264_3), (Mathf.Lerp(iter_264_2.color.b, arg_261_1.hightColor1.b, (arg_261_1.time_ - 0) / var_264_3)))
							else
								local var_264_4 = Mathf.Lerp(iter_264_2.color.r, 1, (arg_261_1.time_ - 0) / var_264_3)

								iter_264_2.color = Color.New(var_264_4, var_264_4, var_264_4)
							end
						end
					end
				end
			end

			if arg_261_1.time_ >= 0 + var_264_3 and arg_261_1.time_ < 0 + var_264_3 + arg_264_0 and not isNil(var_264_2) and arg_261_1.var_.actorSpriteComps10018 then
				for iter_264_3, iter_264_4 in pairs(arg_261_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_264_4 then
						iter_264_4.color = arg_261_1.isInRecall_ and (arg_261_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_261_1.var_.actorSpriteComps10018 = nil
			end

			local var_264_5 = 0
			local var_264_6 = 0.325

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_5 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_7 = arg_261_1:GetWordFromCfg(114251064)
				local var_264_8 = arg_261_1:FormatText(var_264_7.content)

				arg_261_1.text_.text = var_264_8

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_10 = 13 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_8) / 13)

				if (13 <= 0 and var_264_6 or var_264_6 * (utf8.len(var_264_8) / 13)) > 0 and var_264_6 < var_264_10 then
					arg_261_1.talkMaxDuration = var_264_10

					if var_264_10 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_10 + var_264_5
					end
				end

				arg_261_1.text_.text = var_264_8
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251064", "story_v_out_114251.awb") ~= 0 then
					local var_264_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251064", "story_v_out_114251.awb") / 1000

					if var_264_11 + var_264_5 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_11 + var_264_5
					end

					if var_264_7.prefab_name ~= "" and arg_261_1.actors_[var_264_7.prefab_name] ~= nil then
						local var_264_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_7.prefab_name].transform, "story_v_out_114251", "114251064", "story_v_out_114251.awb")

						arg_261_1:RecordAudio("114251064", var_264_12)
						arg_261_1:RecordAudio("114251064", var_264_12)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_114251", "114251064", "story_v_out_114251.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_114251", "114251064", "story_v_out_114251.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_13 = math.max(var_264_6, arg_261_1.talkMaxDuration)

			if var_264_5 <= arg_261_1.time_ and arg_261_1.time_ < var_264_5 + var_264_13 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_5) / var_264_13

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_5 + var_264_13 and arg_261_1.time_ < var_264_5 + var_264_13 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114251065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 114251065
		arg_265_1.duration_ = 2.23

		local var_265_0 = {
			ja = 1.7,
			ko = 1.4,
			zh = 2.233,
			en = 1.433
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play114251066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["10021"]) and arg_265_1.var_.actorSpriteComps10021 == nil then
				arg_265_1.var_.actorSpriteComps10021 = arg_265_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_0 = 0.034

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["10021"]) then
				if arg_265_1.var_.actorSpriteComps10021 then
					for iter_268_0, iter_268_1 in pairs(arg_265_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_268_1 then
							if arg_265_1.isInRecall_ then
								iter_268_1.color = Color.New(Mathf.Lerp(iter_268_1.color.r, arg_265_1.hightColor1.r, (arg_265_1.time_ - 0) / var_268_0), Mathf.Lerp(iter_268_1.color.g, arg_265_1.hightColor1.g, (arg_265_1.time_ - 0) / var_268_0), (Mathf.Lerp(iter_268_1.color.b, arg_265_1.hightColor1.b, (arg_265_1.time_ - 0) / var_268_0)))
							else
								local var_268_1 = Mathf.Lerp(iter_268_1.color.r, 1, (arg_265_1.time_ - 0) / var_268_0)

								iter_268_1.color = Color.New(var_268_1, var_268_1, var_268_1)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["10021"]) and arg_265_1.var_.actorSpriteComps10021 then
				for iter_268_2, iter_268_3 in pairs(arg_265_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_268_3 then
						iter_268_3.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_265_1.var_.actorSpriteComps10021 = nil
			end

			local var_268_2 = arg_265_1.actors_["10018"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps10018 == nil then
				arg_265_1.var_.actorSpriteComps10018 = var_268_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_268_3 = 0.034

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_3 and not isNil(var_268_2) then
				if arg_265_1.var_.actorSpriteComps10018 then
					for iter_268_4, iter_268_5 in pairs(arg_265_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_268_5 then
							if arg_265_1.isInRecall_ then
								iter_268_5.color = Color.New(Mathf.Lerp(iter_268_5.color.r, arg_265_1.hightColor2.r, (arg_265_1.time_ - 0) / var_268_3), Mathf.Lerp(iter_268_5.color.g, arg_265_1.hightColor2.g, (arg_265_1.time_ - 0) / var_268_3), (Mathf.Lerp(iter_268_5.color.b, arg_265_1.hightColor2.b, (arg_265_1.time_ - 0) / var_268_3)))
							else
								local var_268_4 = Mathf.Lerp(iter_268_5.color.r, 0.5, (arg_265_1.time_ - 0) / var_268_3)

								iter_268_5.color = Color.New(var_268_4, var_268_4, var_268_4)
							end
						end
					end
				end
			end

			if arg_265_1.time_ >= 0 + var_268_3 and arg_265_1.time_ < 0 + var_268_3 + arg_268_0 and not isNil(var_268_2) and arg_265_1.var_.actorSpriteComps10018 then
				for iter_268_6, iter_268_7 in pairs(arg_265_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_268_7 then
						iter_268_7.color = arg_265_1.isInRecall_ and (arg_265_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_265_1.var_.actorSpriteComps10018 = nil
			end

			local var_268_5 = 0
			local var_268_6 = 0.15

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_5 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_7 = arg_265_1:GetWordFromCfg(114251065)
				local var_268_8 = arg_265_1:FormatText(var_268_7.content)

				arg_265_1.text_.text = var_268_8

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_10 = 6 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_8) / 6)

				if (6 <= 0 and var_268_6 or var_268_6 * (utf8.len(var_268_8) / 6)) > 0 and var_268_6 < var_268_10 then
					arg_265_1.talkMaxDuration = var_268_10

					if var_268_10 + var_268_5 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_5
					end
				end

				arg_265_1.text_.text = var_268_8
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251065", "story_v_out_114251.awb") ~= 0 then
					local var_268_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251065", "story_v_out_114251.awb") / 1000

					if var_268_11 + var_268_5 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_11 + var_268_5
					end

					if var_268_7.prefab_name ~= "" and arg_265_1.actors_[var_268_7.prefab_name] ~= nil then
						local var_268_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_7.prefab_name].transform, "story_v_out_114251", "114251065", "story_v_out_114251.awb")

						arg_265_1:RecordAudio("114251065", var_268_12)
						arg_265_1:RecordAudio("114251065", var_268_12)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_114251", "114251065", "story_v_out_114251.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_114251", "114251065", "story_v_out_114251.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_13 = math.max(var_268_6, arg_265_1.talkMaxDuration)

			if var_268_5 <= arg_265_1.time_ and arg_265_1.time_ < var_268_5 + var_268_13 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_5) / var_268_13

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_5 + var_268_13 and arg_265_1.time_ < var_268_5 + var_268_13 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play114251066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 114251066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play114251067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["10021"]) and arg_269_1.var_.actorSpriteComps10021 == nil then
				arg_269_1.var_.actorSpriteComps10021 = arg_269_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_272_0 = 0.034

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["10021"]) then
				if arg_269_1.var_.actorSpriteComps10021 then
					for iter_272_0, iter_272_1 in pairs(arg_269_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_272_1 then
							if arg_269_1.isInRecall_ then
								iter_272_1.color = Color.New(Mathf.Lerp(iter_272_1.color.r, arg_269_1.hightColor2.r, (arg_269_1.time_ - 0) / var_272_0), Mathf.Lerp(iter_272_1.color.g, arg_269_1.hightColor2.g, (arg_269_1.time_ - 0) / var_272_0), (Mathf.Lerp(iter_272_1.color.b, arg_269_1.hightColor2.b, (arg_269_1.time_ - 0) / var_272_0)))
							else
								local var_272_1 = Mathf.Lerp(iter_272_1.color.r, 0.5, (arg_269_1.time_ - 0) / var_272_0)

								iter_272_1.color = Color.New(var_272_1, var_272_1, var_272_1)
							end
						end
					end
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["10021"]) and arg_269_1.var_.actorSpriteComps10021 then
				for iter_272_2, iter_272_3 in pairs(arg_269_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_272_3 then
						iter_272_3.color = arg_269_1.isInRecall_ and (arg_269_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_269_1.var_.actorSpriteComps10021 = nil
			end

			local var_272_2 = 0
			local var_272_3 = 0.875

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_2 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_4 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(114251066).content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_6 = 35 <= 0 and var_272_3 or var_272_3 * (utf8.len(var_272_4) / 35)

				if (35 <= 0 and var_272_3 or var_272_3 * (utf8.len(var_272_4) / 35)) > 0 and var_272_3 < var_272_6 then
					arg_269_1.talkMaxDuration = var_272_6

					if var_272_6 + var_272_2 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_6 + var_272_2
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_7 = math.max(var_272_3, arg_269_1.talkMaxDuration)

			if var_272_2 <= arg_269_1.time_ and arg_269_1.time_ < var_272_2 + var_272_7 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_2) / var_272_7

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_2 + var_272_7 and arg_269_1.time_ < var_272_2 + var_272_7 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play114251067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 114251067
		arg_273_1.duration_ = 2.03

		local var_273_0 = {
			ja = 1.5,
			ko = 1.566,
			zh = 1.433,
			en = 2.033
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
				arg_273_0:Play114251068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10018 = arg_273_1.actors_["10018"].transform.localPosition
				arg_273_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_273_1:CheckSpriteTmpPos("10018", 4)

				for iter_276_0 = 0, arg_273_1.actors_["10018"].transform.childCount - 1 do
					local var_276_0 = arg_273_1.actors_["10018"].transform:GetChild(iter_276_0)

					if var_276_0.name == "split_1" or not string.find(var_276_0.name, "split") then
						var_276_0.gameObject:SetActive(true)
					else
						var_276_0.gameObject:SetActive(false)
					end
				end
			end

			local var_276_1 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_1 then
				arg_273_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10018, Vector3.New(390, -350, -180), (arg_273_1.time_ - 0) / var_276_1)
			end

			if arg_273_1.time_ >= 0 + var_276_1 and arg_273_1.time_ < 0 + var_276_1 + arg_276_0 then
				arg_273_1.actors_["10018"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_276_2 = arg_273_1.actors_["10018"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps10018 == nil then
				arg_273_1.var_.actorSpriteComps10018 = var_276_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_276_3 = 0.034

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_3 and not isNil(var_276_2) then
				if arg_273_1.var_.actorSpriteComps10018 then
					for iter_276_1, iter_276_2 in pairs(arg_273_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_276_2 then
							if arg_273_1.isInRecall_ then
								iter_276_2.color = Color.New(Mathf.Lerp(iter_276_2.color.r, arg_273_1.hightColor1.r, (arg_273_1.time_ - 0) / var_276_3), Mathf.Lerp(iter_276_2.color.g, arg_273_1.hightColor1.g, (arg_273_1.time_ - 0) / var_276_3), (Mathf.Lerp(iter_276_2.color.b, arg_273_1.hightColor1.b, (arg_273_1.time_ - 0) / var_276_3)))
							else
								local var_276_4 = Mathf.Lerp(iter_276_2.color.r, 1, (arg_273_1.time_ - 0) / var_276_3)

								iter_276_2.color = Color.New(var_276_4, var_276_4, var_276_4)
							end
						end
					end
				end
			end

			if arg_273_1.time_ >= 0 + var_276_3 and arg_273_1.time_ < 0 + var_276_3 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.actorSpriteComps10018 then
				for iter_276_3, iter_276_4 in pairs(arg_273_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_276_4 then
						iter_276_4.color = arg_273_1.isInRecall_ and (arg_273_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_273_1.var_.actorSpriteComps10018 = nil
			end

			local var_276_5 = 0
			local var_276_6 = 0.1

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_5 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_7 = arg_273_1:GetWordFromCfg(114251067)
				local var_276_8 = arg_273_1:FormatText(var_276_7.content)

				arg_273_1.text_.text = var_276_8

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_10 = 4 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_8) / 4)

				if (4 <= 0 and var_276_6 or var_276_6 * (utf8.len(var_276_8) / 4)) > 0 and var_276_6 < var_276_10 then
					arg_273_1.talkMaxDuration = var_276_10

					if var_276_10 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_5
					end
				end

				arg_273_1.text_.text = var_276_8
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251067", "story_v_out_114251.awb") ~= 0 then
					local var_276_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251067", "story_v_out_114251.awb") / 1000

					if var_276_11 + var_276_5 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_11 + var_276_5
					end

					if var_276_7.prefab_name ~= "" and arg_273_1.actors_[var_276_7.prefab_name] ~= nil then
						local var_276_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_7.prefab_name].transform, "story_v_out_114251", "114251067", "story_v_out_114251.awb")

						arg_273_1:RecordAudio("114251067", var_276_12)
						arg_273_1:RecordAudio("114251067", var_276_12)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_114251", "114251067", "story_v_out_114251.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_114251", "114251067", "story_v_out_114251.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_13 = math.max(var_276_6, arg_273_1.talkMaxDuration)

			if var_276_5 <= arg_273_1.time_ and arg_273_1.time_ < var_276_5 + var_276_13 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_5) / var_276_13

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_5 + var_276_13 and arg_273_1.time_ < var_276_5 + var_276_13 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
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
	Play114251068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 114251068
		arg_277_1.duration_ = 5.07

		local var_277_0 = {
			ja = 3.433,
			ko = 4.1,
			zh = 4.766,
			en = 5.066
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
				arg_277_0:Play114251069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["10018"]) and arg_277_1.var_.actorSpriteComps10018 == nil then
				arg_277_1.var_.actorSpriteComps10018 = arg_277_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_0 = 0.034

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["10018"]) then
				if arg_277_1.var_.actorSpriteComps10018 then
					for iter_280_0, iter_280_1 in pairs(arg_277_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["10018"]) and arg_277_1.var_.actorSpriteComps10018 then
				for iter_280_2, iter_280_3 in pairs(arg_277_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_280_3 then
						iter_280_3.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_277_1.var_.actorSpriteComps10018 = nil
			end

			local var_280_2 = 0
			local var_280_3 = 0.525

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_2 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_4 = arg_277_1:GetWordFromCfg(114251068)
				local var_280_5 = arg_277_1:FormatText(var_280_4.content)

				arg_277_1.text_.text = var_280_5

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_7 = 21 <= 0 and var_280_3 or var_280_3 * (utf8.len(var_280_5) / 21)

				if (21 <= 0 and var_280_3 or var_280_3 * (utf8.len(var_280_5) / 21)) > 0 and var_280_3 < var_280_7 then
					arg_277_1.talkMaxDuration = var_280_7

					if var_280_7 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_7 + var_280_2
					end
				end

				arg_277_1.text_.text = var_280_5
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251068", "story_v_out_114251.awb") ~= 0 then
					local var_280_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251068", "story_v_out_114251.awb") / 1000

					if var_280_8 + var_280_2 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_2
					end

					if var_280_4.prefab_name ~= "" and arg_277_1.actors_[var_280_4.prefab_name] ~= nil then
						local var_280_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_4.prefab_name].transform, "story_v_out_114251", "114251068", "story_v_out_114251.awb")

						arg_277_1:RecordAudio("114251068", var_280_9)
						arg_277_1:RecordAudio("114251068", var_280_9)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_114251", "114251068", "story_v_out_114251.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_114251", "114251068", "story_v_out_114251.awb")
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
	Play114251069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 114251069
		arg_281_1.duration_ = 4.83

		local var_281_0 = {
			ja = 3.333,
			ko = 4.133,
			zh = 4.833,
			en = 3.3
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
				arg_281_0:Play114251070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["10021"]) and arg_281_1.var_.actorSpriteComps10021 == nil then
				arg_281_1.var_.actorSpriteComps10021 = arg_281_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_0 = 0.034

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["10021"]) then
				if arg_281_1.var_.actorSpriteComps10021 then
					for iter_284_0, iter_284_1 in pairs(arg_281_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_284_1 then
							if arg_281_1.isInRecall_ then
								iter_284_1.color = Color.New(Mathf.Lerp(iter_284_1.color.r, arg_281_1.hightColor1.r, (arg_281_1.time_ - 0) / var_284_0), Mathf.Lerp(iter_284_1.color.g, arg_281_1.hightColor1.g, (arg_281_1.time_ - 0) / var_284_0), (Mathf.Lerp(iter_284_1.color.b, arg_281_1.hightColor1.b, (arg_281_1.time_ - 0) / var_284_0)))
							else
								local var_284_1 = Mathf.Lerp(iter_284_1.color.r, 1, (arg_281_1.time_ - 0) / var_284_0)

								iter_284_1.color = Color.New(var_284_1, var_284_1, var_284_1)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["10021"]) and arg_281_1.var_.actorSpriteComps10021 then
				for iter_284_2, iter_284_3 in pairs(arg_281_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_284_3 then
						iter_284_3.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_281_1.var_.actorSpriteComps10021 = nil
			end

			local var_284_2 = arg_281_1.actors_["10018"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps10018 == nil then
				arg_281_1.var_.actorSpriteComps10018 = var_284_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_3 = 0.034

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.actorSpriteComps10018 then
					for iter_284_4, iter_284_5 in pairs(arg_281_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_284_5 then
							if arg_281_1.isInRecall_ then
								iter_284_5.color = Color.New(Mathf.Lerp(iter_284_5.color.r, arg_281_1.hightColor2.r, (arg_281_1.time_ - 0) / var_284_3), Mathf.Lerp(iter_284_5.color.g, arg_281_1.hightColor2.g, (arg_281_1.time_ - 0) / var_284_3), (Mathf.Lerp(iter_284_5.color.b, arg_281_1.hightColor2.b, (arg_281_1.time_ - 0) / var_284_3)))
							else
								local var_284_4 = Mathf.Lerp(iter_284_5.color.r, 0.5, (arg_281_1.time_ - 0) / var_284_3)

								iter_284_5.color = Color.New(var_284_4, var_284_4, var_284_4)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps10018 then
				for iter_284_6, iter_284_7 in pairs(arg_281_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_284_7 then
						iter_284_7.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_281_1.var_.actorSpriteComps10018 = nil
			end

			local var_284_5 = 0
			local var_284_6 = 0.375

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_5 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_7 = arg_281_1:GetWordFromCfg(114251069)
				local var_284_8 = arg_281_1:FormatText(var_284_7.content)

				arg_281_1.text_.text = var_284_8

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_10 = 15 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 15)

				if (15 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 15)) > 0 and var_284_6 < var_284_10 then
					arg_281_1.talkMaxDuration = var_284_10

					if var_284_10 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_5
					end
				end

				arg_281_1.text_.text = var_284_8
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251069", "story_v_out_114251.awb") ~= 0 then
					local var_284_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251069", "story_v_out_114251.awb") / 1000

					if var_284_11 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_11 + var_284_5
					end

					if var_284_7.prefab_name ~= "" and arg_281_1.actors_[var_284_7.prefab_name] ~= nil then
						local var_284_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_7.prefab_name].transform, "story_v_out_114251", "114251069", "story_v_out_114251.awb")

						arg_281_1:RecordAudio("114251069", var_284_12)
						arg_281_1:RecordAudio("114251069", var_284_12)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_114251", "114251069", "story_v_out_114251.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_114251", "114251069", "story_v_out_114251.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_13 = math.max(var_284_6, arg_281_1.talkMaxDuration)

			if var_284_5 <= arg_281_1.time_ and arg_281_1.time_ < var_284_5 + var_284_13 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_5) / var_284_13

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_5 + var_284_13 and arg_281_1.time_ < var_284_5 + var_284_13 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play114251070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 114251070
		arg_285_1.duration_ = 4.47

		local var_285_0 = {
			ja = 3.566,
			ko = 3.766,
			zh = 4.466,
			en = 4.166
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play114251071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["10021"]) and arg_285_1.var_.actorSpriteComps10021 == nil then
				arg_285_1.var_.actorSpriteComps10021 = arg_285_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_0 = 0.034

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["10021"]) then
				if arg_285_1.var_.actorSpriteComps10021 then
					for iter_288_0, iter_288_1 in pairs(arg_285_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_288_1 then
							if arg_285_1.isInRecall_ then
								iter_288_1.color = Color.New(Mathf.Lerp(iter_288_1.color.r, arg_285_1.hightColor2.r, (arg_285_1.time_ - 0) / var_288_0), Mathf.Lerp(iter_288_1.color.g, arg_285_1.hightColor2.g, (arg_285_1.time_ - 0) / var_288_0), (Mathf.Lerp(iter_288_1.color.b, arg_285_1.hightColor2.b, (arg_285_1.time_ - 0) / var_288_0)))
							else
								local var_288_1 = Mathf.Lerp(iter_288_1.color.r, 0.5, (arg_285_1.time_ - 0) / var_288_0)

								iter_288_1.color = Color.New(var_288_1, var_288_1, var_288_1)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["10021"]) and arg_285_1.var_.actorSpriteComps10021 then
				for iter_288_2, iter_288_3 in pairs(arg_285_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_288_3 then
						iter_288_3.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_285_1.var_.actorSpriteComps10021 = nil
			end

			local var_288_2 = arg_285_1.actors_["10018"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.actorSpriteComps10018 == nil then
				arg_285_1.var_.actorSpriteComps10018 = var_288_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_3 = 0.034

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 and not isNil(var_288_2) then
				if arg_285_1.var_.actorSpriteComps10018 then
					for iter_288_4, iter_288_5 in pairs(arg_285_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_288_5 then
							if arg_285_1.isInRecall_ then
								iter_288_5.color = Color.New(Mathf.Lerp(iter_288_5.color.r, arg_285_1.hightColor1.r, (arg_285_1.time_ - 0) / var_288_3), Mathf.Lerp(iter_288_5.color.g, arg_285_1.hightColor1.g, (arg_285_1.time_ - 0) / var_288_3), (Mathf.Lerp(iter_288_5.color.b, arg_285_1.hightColor1.b, (arg_285_1.time_ - 0) / var_288_3)))
							else
								local var_288_4 = Mathf.Lerp(iter_288_5.color.r, 1, (arg_285_1.time_ - 0) / var_288_3)

								iter_288_5.color = Color.New(var_288_4, var_288_4, var_288_4)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.actorSpriteComps10018 then
				for iter_288_6, iter_288_7 in pairs(arg_285_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_288_7 then
						iter_288_7.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_285_1.var_.actorSpriteComps10018 = nil
			end

			local var_288_5 = 0
			local var_288_6 = 0.4

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_7 = arg_285_1:GetWordFromCfg(114251070)
				local var_288_8 = arg_285_1:FormatText(var_288_7.content)

				arg_285_1.text_.text = var_288_8

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_10 = 16 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_8) / 16)

				if (16 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_8) / 16)) > 0 and var_288_6 < var_288_10 then
					arg_285_1.talkMaxDuration = var_288_10

					if var_288_10 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_5
					end
				end

				arg_285_1.text_.text = var_288_8
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251070", "story_v_out_114251.awb") ~= 0 then
					local var_288_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251070", "story_v_out_114251.awb") / 1000

					if var_288_11 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_11 + var_288_5
					end

					if var_288_7.prefab_name ~= "" and arg_285_1.actors_[var_288_7.prefab_name] ~= nil then
						local var_288_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_7.prefab_name].transform, "story_v_out_114251", "114251070", "story_v_out_114251.awb")

						arg_285_1:RecordAudio("114251070", var_288_12)
						arg_285_1:RecordAudio("114251070", var_288_12)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_114251", "114251070", "story_v_out_114251.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_114251", "114251070", "story_v_out_114251.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_13 = math.max(var_288_6, arg_285_1.talkMaxDuration)

			if var_288_5 <= arg_285_1.time_ and arg_285_1.time_ < var_288_5 + var_288_13 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_5) / var_288_13

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_5 + var_288_13 and arg_285_1.time_ < var_288_5 + var_288_13 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play114251071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 114251071
		arg_289_1.duration_ = 2.5

		local var_289_0 = {
			ja = 2.5,
			ko = 1.533,
			zh = 1.3,
			en = 0.999999999999
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play114251072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["10021"]) and arg_289_1.var_.actorSpriteComps10021 == nil then
				arg_289_1.var_.actorSpriteComps10021 = arg_289_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_0 = 0.034

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["10021"]) then
				if arg_289_1.var_.actorSpriteComps10021 then
					for iter_292_0, iter_292_1 in pairs(arg_289_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_292_1 then
							if arg_289_1.isInRecall_ then
								iter_292_1.color = Color.New(Mathf.Lerp(iter_292_1.color.r, arg_289_1.hightColor1.r, (arg_289_1.time_ - 0) / var_292_0), Mathf.Lerp(iter_292_1.color.g, arg_289_1.hightColor1.g, (arg_289_1.time_ - 0) / var_292_0), (Mathf.Lerp(iter_292_1.color.b, arg_289_1.hightColor1.b, (arg_289_1.time_ - 0) / var_292_0)))
							else
								local var_292_1 = Mathf.Lerp(iter_292_1.color.r, 1, (arg_289_1.time_ - 0) / var_292_0)

								iter_292_1.color = Color.New(var_292_1, var_292_1, var_292_1)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["10021"]) and arg_289_1.var_.actorSpriteComps10021 then
				for iter_292_2, iter_292_3 in pairs(arg_289_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_292_3 then
						iter_292_3.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_289_1.var_.actorSpriteComps10021 = nil
			end

			local var_292_2 = arg_289_1.actors_["10018"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps10018 == nil then
				arg_289_1.var_.actorSpriteComps10018 = var_292_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_3 = 0.034

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_3 and not isNil(var_292_2) then
				if arg_289_1.var_.actorSpriteComps10018 then
					for iter_292_4, iter_292_5 in pairs(arg_289_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_292_5 then
							if arg_289_1.isInRecall_ then
								iter_292_5.color = Color.New(Mathf.Lerp(iter_292_5.color.r, arg_289_1.hightColor2.r, (arg_289_1.time_ - 0) / var_292_3), Mathf.Lerp(iter_292_5.color.g, arg_289_1.hightColor2.g, (arg_289_1.time_ - 0) / var_292_3), (Mathf.Lerp(iter_292_5.color.b, arg_289_1.hightColor2.b, (arg_289_1.time_ - 0) / var_292_3)))
							else
								local var_292_4 = Mathf.Lerp(iter_292_5.color.r, 0.5, (arg_289_1.time_ - 0) / var_292_3)

								iter_292_5.color = Color.New(var_292_4, var_292_4, var_292_4)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= 0 + var_292_3 and arg_289_1.time_ < 0 + var_292_3 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps10018 then
				for iter_292_6, iter_292_7 in pairs(arg_289_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_292_7 then
						iter_292_7.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_289_1.var_.actorSpriteComps10018 = nil
			end

			local var_292_5 = 0
			local var_292_6 = 0.125

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_7 = arg_289_1:GetWordFromCfg(114251071)
				local var_292_8 = arg_289_1:FormatText(var_292_7.content)

				arg_289_1.text_.text = var_292_8

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_10 = 5 <= 0 and var_292_6 or var_292_6 * (utf8.len(var_292_8) / 5)

				if (5 <= 0 and var_292_6 or var_292_6 * (utf8.len(var_292_8) / 5)) > 0 and var_292_6 < var_292_10 then
					arg_289_1.talkMaxDuration = var_292_10

					if var_292_10 + var_292_5 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_10 + var_292_5
					end
				end

				arg_289_1.text_.text = var_292_8
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251071", "story_v_out_114251.awb") ~= 0 then
					local var_292_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251071", "story_v_out_114251.awb") / 1000

					if var_292_11 + var_292_5 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_11 + var_292_5
					end

					if var_292_7.prefab_name ~= "" and arg_289_1.actors_[var_292_7.prefab_name] ~= nil then
						local var_292_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_7.prefab_name].transform, "story_v_out_114251", "114251071", "story_v_out_114251.awb")

						arg_289_1:RecordAudio("114251071", var_292_12)
						arg_289_1:RecordAudio("114251071", var_292_12)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_114251", "114251071", "story_v_out_114251.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_114251", "114251071", "story_v_out_114251.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_13 = math.max(var_292_6, arg_289_1.talkMaxDuration)

			if var_292_5 <= arg_289_1.time_ and arg_289_1.time_ < var_292_5 + var_292_13 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_5) / var_292_13

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_5 + var_292_13 and arg_289_1.time_ < var_292_5 + var_292_13 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play114251072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 114251072
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play114251073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["10021"]) and arg_293_1.var_.actorSpriteComps10021 == nil then
				arg_293_1.var_.actorSpriteComps10021 = arg_293_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_296_0 = 0.034

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["10021"]) then
				if arg_293_1.var_.actorSpriteComps10021 then
					for iter_296_0, iter_296_1 in pairs(arg_293_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_296_1 then
							if arg_293_1.isInRecall_ then
								iter_296_1.color = Color.New(Mathf.Lerp(iter_296_1.color.r, arg_293_1.hightColor2.r, (arg_293_1.time_ - 0) / var_296_0), Mathf.Lerp(iter_296_1.color.g, arg_293_1.hightColor2.g, (arg_293_1.time_ - 0) / var_296_0), (Mathf.Lerp(iter_296_1.color.b, arg_293_1.hightColor2.b, (arg_293_1.time_ - 0) / var_296_0)))
							else
								local var_296_1 = Mathf.Lerp(iter_296_1.color.r, 0.5, (arg_293_1.time_ - 0) / var_296_0)

								iter_296_1.color = Color.New(var_296_1, var_296_1, var_296_1)
							end
						end
					end
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["10021"]) and arg_293_1.var_.actorSpriteComps10021 then
				for iter_296_2, iter_296_3 in pairs(arg_293_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_296_3 then
						iter_296_3.color = arg_293_1.isInRecall_ and (arg_293_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_293_1.var_.actorSpriteComps10021 = nil
			end

			local var_296_2 = 0
			local var_296_3 = 0.775

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_2 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_4 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(114251072).content)

				arg_293_1.text_.text = var_296_4

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_6 = 31 <= 0 and var_296_3 or var_296_3 * (utf8.len(var_296_4) / 31)

				if (31 <= 0 and var_296_3 or var_296_3 * (utf8.len(var_296_4) / 31)) > 0 and var_296_3 < var_296_6 then
					arg_293_1.talkMaxDuration = var_296_6

					if var_296_6 + var_296_2 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_6 + var_296_2
					end
				end

				arg_293_1.text_.text = var_296_4
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_7 = math.max(var_296_3, arg_293_1.talkMaxDuration)

			if var_296_2 <= arg_293_1.time_ and arg_293_1.time_ < var_296_2 + var_296_7 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_2) / var_296_7

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_2 + var_296_7 and arg_293_1.time_ < var_296_2 + var_296_7 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play114251073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 114251073
		arg_297_1.duration_ = 16.67

		local var_297_0 = {
			ja = 11.833,
			ko = 12.2,
			zh = 16.1,
			en = 16.666
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
				arg_297_0:Play114251074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["10018"]) and arg_297_1.var_.actorSpriteComps10018 == nil then
				arg_297_1.var_.actorSpriteComps10018 = arg_297_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_300_0 = 0.034

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["10018"]) then
				if arg_297_1.var_.actorSpriteComps10018 then
					for iter_300_0, iter_300_1 in pairs(arg_297_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_300_1 then
							if arg_297_1.isInRecall_ then
								iter_300_1.color = Color.New(Mathf.Lerp(iter_300_1.color.r, arg_297_1.hightColor1.r, (arg_297_1.time_ - 0) / var_300_0), Mathf.Lerp(iter_300_1.color.g, arg_297_1.hightColor1.g, (arg_297_1.time_ - 0) / var_300_0), (Mathf.Lerp(iter_300_1.color.b, arg_297_1.hightColor1.b, (arg_297_1.time_ - 0) / var_300_0)))
							else
								local var_300_1 = Mathf.Lerp(iter_300_1.color.r, 1, (arg_297_1.time_ - 0) / var_300_0)

								iter_300_1.color = Color.New(var_300_1, var_300_1, var_300_1)
							end
						end
					end
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["10018"]) and arg_297_1.var_.actorSpriteComps10018 then
				for iter_300_2, iter_300_3 in pairs(arg_297_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_300_3 then
						iter_300_3.color = arg_297_1.isInRecall_ and (arg_297_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_297_1.var_.actorSpriteComps10018 = nil
			end

			local var_300_2 = 0
			local var_300_3 = 1.65

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_2 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_4 = arg_297_1:GetWordFromCfg(114251073)
				local var_300_5 = arg_297_1:FormatText(var_300_4.content)

				arg_297_1.text_.text = var_300_5

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_7 = 65 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 65)

				if (65 <= 0 and var_300_3 or var_300_3 * (utf8.len(var_300_5) / 65)) > 0 and var_300_3 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_2
					end
				end

				arg_297_1.text_.text = var_300_5
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251073", "story_v_out_114251.awb") ~= 0 then
					local var_300_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251073", "story_v_out_114251.awb") / 1000

					if var_300_8 + var_300_2 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_2
					end

					if var_300_4.prefab_name ~= "" and arg_297_1.actors_[var_300_4.prefab_name] ~= nil then
						local var_300_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_4.prefab_name].transform, "story_v_out_114251", "114251073", "story_v_out_114251.awb")

						arg_297_1:RecordAudio("114251073", var_300_9)
						arg_297_1:RecordAudio("114251073", var_300_9)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_114251", "114251073", "story_v_out_114251.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_114251", "114251073", "story_v_out_114251.awb")
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

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play114251074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 114251074
		arg_301_1.duration_ = 5.87

		local var_301_0 = {
			ja = 5.866,
			ko = 2.533,
			zh = 2.766,
			en = 2.066
		}
		local var_301_1 = manager.audio:GetLocalizationFlag()

		if var_301_0[var_301_1] ~= nil then
			arg_301_1.duration_ = var_301_0[var_301_1]
		end

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play114251075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["10021"]) and arg_301_1.var_.actorSpriteComps10021 == nil then
				arg_301_1.var_.actorSpriteComps10021 = arg_301_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_0 = 0.034

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["10021"]) then
				if arg_301_1.var_.actorSpriteComps10021 then
					for iter_304_0, iter_304_1 in pairs(arg_301_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_304_1 then
							if arg_301_1.isInRecall_ then
								iter_304_1.color = Color.New(Mathf.Lerp(iter_304_1.color.r, arg_301_1.hightColor1.r, (arg_301_1.time_ - 0) / var_304_0), Mathf.Lerp(iter_304_1.color.g, arg_301_1.hightColor1.g, (arg_301_1.time_ - 0) / var_304_0), (Mathf.Lerp(iter_304_1.color.b, arg_301_1.hightColor1.b, (arg_301_1.time_ - 0) / var_304_0)))
							else
								local var_304_1 = Mathf.Lerp(iter_304_1.color.r, 1, (arg_301_1.time_ - 0) / var_304_0)

								iter_304_1.color = Color.New(var_304_1, var_304_1, var_304_1)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["10021"]) and arg_301_1.var_.actorSpriteComps10021 then
				for iter_304_2, iter_304_3 in pairs(arg_301_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_304_3 then
						iter_304_3.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_301_1.var_.actorSpriteComps10021 = nil
			end

			local var_304_2 = arg_301_1.actors_["10018"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.actorSpriteComps10018 == nil then
				arg_301_1.var_.actorSpriteComps10018 = var_304_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_304_3 = 0.034

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_3 and not isNil(var_304_2) then
				if arg_301_1.var_.actorSpriteComps10018 then
					for iter_304_4, iter_304_5 in pairs(arg_301_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_304_5 then
							if arg_301_1.isInRecall_ then
								iter_304_5.color = Color.New(Mathf.Lerp(iter_304_5.color.r, arg_301_1.hightColor2.r, (arg_301_1.time_ - 0) / var_304_3), Mathf.Lerp(iter_304_5.color.g, arg_301_1.hightColor2.g, (arg_301_1.time_ - 0) / var_304_3), (Mathf.Lerp(iter_304_5.color.b, arg_301_1.hightColor2.b, (arg_301_1.time_ - 0) / var_304_3)))
							else
								local var_304_4 = Mathf.Lerp(iter_304_5.color.r, 0.5, (arg_301_1.time_ - 0) / var_304_3)

								iter_304_5.color = Color.New(var_304_4, var_304_4, var_304_4)
							end
						end
					end
				end
			end

			if arg_301_1.time_ >= 0 + var_304_3 and arg_301_1.time_ < 0 + var_304_3 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.actorSpriteComps10018 then
				for iter_304_6, iter_304_7 in pairs(arg_301_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_304_7 then
						iter_304_7.color = arg_301_1.isInRecall_ and (arg_301_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_301_1.var_.actorSpriteComps10018 = nil
			end

			local var_304_5 = 0
			local var_304_6 = 0.3

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_5 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_7 = arg_301_1:GetWordFromCfg(114251074)
				local var_304_8 = arg_301_1:FormatText(var_304_7.content)

				arg_301_1.text_.text = var_304_8

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_10 = 12 <= 0 and var_304_6 or var_304_6 * (utf8.len(var_304_8) / 12)

				if (12 <= 0 and var_304_6 or var_304_6 * (utf8.len(var_304_8) / 12)) > 0 and var_304_6 < var_304_10 then
					arg_301_1.talkMaxDuration = var_304_10

					if var_304_10 + var_304_5 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_10 + var_304_5
					end
				end

				arg_301_1.text_.text = var_304_8
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251074", "story_v_out_114251.awb") ~= 0 then
					local var_304_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251074", "story_v_out_114251.awb") / 1000

					if var_304_11 + var_304_5 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_11 + var_304_5
					end

					if var_304_7.prefab_name ~= "" and arg_301_1.actors_[var_304_7.prefab_name] ~= nil then
						local var_304_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_7.prefab_name].transform, "story_v_out_114251", "114251074", "story_v_out_114251.awb")

						arg_301_1:RecordAudio("114251074", var_304_12)
						arg_301_1:RecordAudio("114251074", var_304_12)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_out_114251", "114251074", "story_v_out_114251.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_out_114251", "114251074", "story_v_out_114251.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_13 = math.max(var_304_6, arg_301_1.talkMaxDuration)

			if var_304_5 <= arg_301_1.time_ and arg_301_1.time_ < var_304_5 + var_304_13 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_5) / var_304_13

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_5 + var_304_13 and arg_301_1.time_ < var_304_5 + var_304_13 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play114251075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 114251075
		arg_305_1.duration_ = 11.57

		local var_305_0 = {
			ja = 8.8,
			ko = 10.266,
			zh = 11.566,
			en = 8.633
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
				arg_305_0:Play114251076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(arg_305_1.actors_["10021"]) and arg_305_1.var_.actorSpriteComps10021 == nil then
				arg_305_1.var_.actorSpriteComps10021 = arg_305_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_0 = 0.034

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_0 and not isNil(arg_305_1.actors_["10021"]) then
				if arg_305_1.var_.actorSpriteComps10021 then
					for iter_308_0, iter_308_1 in pairs(arg_305_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_308_1 then
							if arg_305_1.isInRecall_ then
								iter_308_1.color = Color.New(Mathf.Lerp(iter_308_1.color.r, arg_305_1.hightColor2.r, (arg_305_1.time_ - 0) / var_308_0), Mathf.Lerp(iter_308_1.color.g, arg_305_1.hightColor2.g, (arg_305_1.time_ - 0) / var_308_0), (Mathf.Lerp(iter_308_1.color.b, arg_305_1.hightColor2.b, (arg_305_1.time_ - 0) / var_308_0)))
							else
								local var_308_1 = Mathf.Lerp(iter_308_1.color.r, 0.5, (arg_305_1.time_ - 0) / var_308_0)

								iter_308_1.color = Color.New(var_308_1, var_308_1, var_308_1)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= 0 + var_308_0 and arg_305_1.time_ < 0 + var_308_0 + arg_308_0 and not isNil(arg_305_1.actors_["10021"]) and arg_305_1.var_.actorSpriteComps10021 then
				for iter_308_2, iter_308_3 in pairs(arg_305_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_308_3 then
						iter_308_3.color = arg_305_1.isInRecall_ and (arg_305_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_305_1.var_.actorSpriteComps10021 = nil
			end

			local var_308_2 = arg_305_1.actors_["10018"]

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.actorSpriteComps10018 == nil then
				arg_305_1.var_.actorSpriteComps10018 = var_308_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_308_3 = 0.034

			if 0 <= arg_305_1.time_ and arg_305_1.time_ < 0 + var_308_3 and not isNil(var_308_2) then
				if arg_305_1.var_.actorSpriteComps10018 then
					for iter_308_4, iter_308_5 in pairs(arg_305_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_308_5 then
							if arg_305_1.isInRecall_ then
								iter_308_5.color = Color.New(Mathf.Lerp(iter_308_5.color.r, arg_305_1.hightColor1.r, (arg_305_1.time_ - 0) / var_308_3), Mathf.Lerp(iter_308_5.color.g, arg_305_1.hightColor1.g, (arg_305_1.time_ - 0) / var_308_3), (Mathf.Lerp(iter_308_5.color.b, arg_305_1.hightColor1.b, (arg_305_1.time_ - 0) / var_308_3)))
							else
								local var_308_4 = Mathf.Lerp(iter_308_5.color.r, 1, (arg_305_1.time_ - 0) / var_308_3)

								iter_308_5.color = Color.New(var_308_4, var_308_4, var_308_4)
							end
						end
					end
				end
			end

			if arg_305_1.time_ >= 0 + var_308_3 and arg_305_1.time_ < 0 + var_308_3 + arg_308_0 and not isNil(var_308_2) and arg_305_1.var_.actorSpriteComps10018 then
				for iter_308_6, iter_308_7 in pairs(arg_305_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_308_7 then
						iter_308_7.color = arg_305_1.isInRecall_ and (arg_305_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_305_1.var_.actorSpriteComps10018 = nil
			end

			local var_308_5 = 0
			local var_308_6 = 1.05

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_5 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_7 = arg_305_1:GetWordFromCfg(114251075)
				local var_308_8 = arg_305_1:FormatText(var_308_7.content)

				arg_305_1.text_.text = var_308_8

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_10 = 42 <= 0 and var_308_6 or var_308_6 * (utf8.len(var_308_8) / 42)

				if (42 <= 0 and var_308_6 or var_308_6 * (utf8.len(var_308_8) / 42)) > 0 and var_308_6 < var_308_10 then
					arg_305_1.talkMaxDuration = var_308_10

					if var_308_10 + var_308_5 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_10 + var_308_5
					end
				end

				arg_305_1.text_.text = var_308_8
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251075", "story_v_out_114251.awb") ~= 0 then
					local var_308_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251075", "story_v_out_114251.awb") / 1000

					if var_308_11 + var_308_5 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_11 + var_308_5
					end

					if var_308_7.prefab_name ~= "" and arg_305_1.actors_[var_308_7.prefab_name] ~= nil then
						local var_308_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_305_1.actors_[var_308_7.prefab_name].transform, "story_v_out_114251", "114251075", "story_v_out_114251.awb")

						arg_305_1:RecordAudio("114251075", var_308_12)
						arg_305_1:RecordAudio("114251075", var_308_12)
					else
						arg_305_1:AudioAction("play", "voice", "story_v_out_114251", "114251075", "story_v_out_114251.awb")
					end

					arg_305_1:RecordHistoryTalkVoice("story_v_out_114251", "114251075", "story_v_out_114251.awb")
				end

				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_13 = math.max(var_308_6, arg_305_1.talkMaxDuration)

			if var_308_5 <= arg_305_1.time_ and arg_305_1.time_ < var_308_5 + var_308_13 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_5) / var_308_13

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_5 + var_308_13 and arg_305_1.time_ < var_308_5 + var_308_13 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play114251076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 114251076
		arg_309_1.duration_ = 4.23

		local var_309_0 = {
			ja = 4.233,
			ko = 3.033,
			zh = 3,
			en = 3.733
		}
		local var_309_1 = manager.audio:GetLocalizationFlag()

		if var_309_0[var_309_1] ~= nil then
			arg_309_1.duration_ = var_309_0[var_309_1]
		end

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play114251077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(arg_309_1.actors_["10021"]) and arg_309_1.var_.actorSpriteComps10021 == nil then
				arg_309_1.var_.actorSpriteComps10021 = arg_309_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_0 = 0.034

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_0 and not isNil(arg_309_1.actors_["10021"]) then
				if arg_309_1.var_.actorSpriteComps10021 then
					for iter_312_0, iter_312_1 in pairs(arg_309_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_312_1 then
							if arg_309_1.isInRecall_ then
								iter_312_1.color = Color.New(Mathf.Lerp(iter_312_1.color.r, arg_309_1.hightColor1.r, (arg_309_1.time_ - 0) / var_312_0), Mathf.Lerp(iter_312_1.color.g, arg_309_1.hightColor1.g, (arg_309_1.time_ - 0) / var_312_0), (Mathf.Lerp(iter_312_1.color.b, arg_309_1.hightColor1.b, (arg_309_1.time_ - 0) / var_312_0)))
							else
								local var_312_1 = Mathf.Lerp(iter_312_1.color.r, 1, (arg_309_1.time_ - 0) / var_312_0)

								iter_312_1.color = Color.New(var_312_1, var_312_1, var_312_1)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= 0 + var_312_0 and arg_309_1.time_ < 0 + var_312_0 + arg_312_0 and not isNil(arg_309_1.actors_["10021"]) and arg_309_1.var_.actorSpriteComps10021 then
				for iter_312_2, iter_312_3 in pairs(arg_309_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_312_3 then
						iter_312_3.color = arg_309_1.isInRecall_ and (arg_309_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_309_1.var_.actorSpriteComps10021 = nil
			end

			local var_312_2 = arg_309_1.actors_["10018"]

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.actorSpriteComps10018 == nil then
				arg_309_1.var_.actorSpriteComps10018 = var_312_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_312_3 = 0.034

			if 0 <= arg_309_1.time_ and arg_309_1.time_ < 0 + var_312_3 and not isNil(var_312_2) then
				if arg_309_1.var_.actorSpriteComps10018 then
					for iter_312_4, iter_312_5 in pairs(arg_309_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_312_5 then
							if arg_309_1.isInRecall_ then
								iter_312_5.color = Color.New(Mathf.Lerp(iter_312_5.color.r, arg_309_1.hightColor2.r, (arg_309_1.time_ - 0) / var_312_3), Mathf.Lerp(iter_312_5.color.g, arg_309_1.hightColor2.g, (arg_309_1.time_ - 0) / var_312_3), (Mathf.Lerp(iter_312_5.color.b, arg_309_1.hightColor2.b, (arg_309_1.time_ - 0) / var_312_3)))
							else
								local var_312_4 = Mathf.Lerp(iter_312_5.color.r, 0.5, (arg_309_1.time_ - 0) / var_312_3)

								iter_312_5.color = Color.New(var_312_4, var_312_4, var_312_4)
							end
						end
					end
				end
			end

			if arg_309_1.time_ >= 0 + var_312_3 and arg_309_1.time_ < 0 + var_312_3 + arg_312_0 and not isNil(var_312_2) and arg_309_1.var_.actorSpriteComps10018 then
				for iter_312_6, iter_312_7 in pairs(arg_309_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_312_7 then
						iter_312_7.color = arg_309_1.isInRecall_ and (arg_309_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_309_1.var_.actorSpriteComps10018 = nil
			end

			local var_312_5 = 0
			local var_312_6 = 0.3

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_5 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_7 = arg_309_1:GetWordFromCfg(114251076)
				local var_312_8 = arg_309_1:FormatText(var_312_7.content)

				arg_309_1.text_.text = var_312_8

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_10 = 12 <= 0 and var_312_6 or var_312_6 * (utf8.len(var_312_8) / 12)

				if (12 <= 0 and var_312_6 or var_312_6 * (utf8.len(var_312_8) / 12)) > 0 and var_312_6 < var_312_10 then
					arg_309_1.talkMaxDuration = var_312_10

					if var_312_10 + var_312_5 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_10 + var_312_5
					end
				end

				arg_309_1.text_.text = var_312_8
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251076", "story_v_out_114251.awb") ~= 0 then
					local var_312_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251076", "story_v_out_114251.awb") / 1000

					if var_312_11 + var_312_5 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_11 + var_312_5
					end

					if var_312_7.prefab_name ~= "" and arg_309_1.actors_[var_312_7.prefab_name] ~= nil then
						local var_312_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_309_1.actors_[var_312_7.prefab_name].transform, "story_v_out_114251", "114251076", "story_v_out_114251.awb")

						arg_309_1:RecordAudio("114251076", var_312_12)
						arg_309_1:RecordAudio("114251076", var_312_12)
					else
						arg_309_1:AudioAction("play", "voice", "story_v_out_114251", "114251076", "story_v_out_114251.awb")
					end

					arg_309_1:RecordHistoryTalkVoice("story_v_out_114251", "114251076", "story_v_out_114251.awb")
				end

				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_13 = math.max(var_312_6, arg_309_1.talkMaxDuration)

			if var_312_5 <= arg_309_1.time_ and arg_309_1.time_ < var_312_5 + var_312_13 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_5) / var_312_13

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_5 + var_312_13 and arg_309_1.time_ < var_312_5 + var_312_13 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play114251077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 114251077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play114251078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["10021"]) and arg_313_1.var_.actorSpriteComps10021 == nil then
				arg_313_1.var_.actorSpriteComps10021 = arg_313_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_316_0 = 0.034

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["10021"]) then
				if arg_313_1.var_.actorSpriteComps10021 then
					for iter_316_0, iter_316_1 in pairs(arg_313_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_316_1 then
							if arg_313_1.isInRecall_ then
								iter_316_1.color = Color.New(Mathf.Lerp(iter_316_1.color.r, arg_313_1.hightColor2.r, (arg_313_1.time_ - 0) / var_316_0), Mathf.Lerp(iter_316_1.color.g, arg_313_1.hightColor2.g, (arg_313_1.time_ - 0) / var_316_0), (Mathf.Lerp(iter_316_1.color.b, arg_313_1.hightColor2.b, (arg_313_1.time_ - 0) / var_316_0)))
							else
								local var_316_1 = Mathf.Lerp(iter_316_1.color.r, 0.5, (arg_313_1.time_ - 0) / var_316_0)

								iter_316_1.color = Color.New(var_316_1, var_316_1, var_316_1)
							end
						end
					end
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["10021"]) and arg_313_1.var_.actorSpriteComps10021 then
				for iter_316_2, iter_316_3 in pairs(arg_313_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_316_3 then
						iter_316_3.color = arg_313_1.isInRecall_ and (arg_313_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_313_1.var_.actorSpriteComps10021 = nil
			end

			local var_316_2 = 0
			local var_316_3 = 0.8

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_2 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_4 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(114251077).content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_6 = 32 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_4) / 32)

				if (32 <= 0 and var_316_3 or var_316_3 * (utf8.len(var_316_4) / 32)) > 0 and var_316_3 < var_316_6 then
					arg_313_1.talkMaxDuration = var_316_6

					if var_316_6 + var_316_2 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_6 + var_316_2
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_7 = math.max(var_316_3, arg_313_1.talkMaxDuration)

			if var_316_2 <= arg_313_1.time_ and arg_313_1.time_ < var_316_2 + var_316_7 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_2) / var_316_7

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_2 + var_316_7 and arg_313_1.time_ < var_316_2 + var_316_7 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play114251078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 114251078
		arg_317_1.duration_ = 12.93

		local var_317_0 = {
			ja = 9.966,
			ko = 12.933,
			zh = 12.466,
			en = 10.966
		}
		local var_317_1 = manager.audio:GetLocalizationFlag()

		if var_317_0[var_317_1] ~= nil then
			arg_317_1.duration_ = var_317_0[var_317_1]
		end

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play114251079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["10018"]) and arg_317_1.var_.actorSpriteComps10018 == nil then
				arg_317_1.var_.actorSpriteComps10018 = arg_317_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_320_0 = 0.034

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["10018"]) then
				if arg_317_1.var_.actorSpriteComps10018 then
					for iter_320_0, iter_320_1 in pairs(arg_317_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_320_1 then
							if arg_317_1.isInRecall_ then
								iter_320_1.color = Color.New(Mathf.Lerp(iter_320_1.color.r, arg_317_1.hightColor1.r, (arg_317_1.time_ - 0) / var_320_0), Mathf.Lerp(iter_320_1.color.g, arg_317_1.hightColor1.g, (arg_317_1.time_ - 0) / var_320_0), (Mathf.Lerp(iter_320_1.color.b, arg_317_1.hightColor1.b, (arg_317_1.time_ - 0) / var_320_0)))
							else
								local var_320_1 = Mathf.Lerp(iter_320_1.color.r, 1, (arg_317_1.time_ - 0) / var_320_0)

								iter_320_1.color = Color.New(var_320_1, var_320_1, var_320_1)
							end
						end
					end
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["10018"]) and arg_317_1.var_.actorSpriteComps10018 then
				for iter_320_2, iter_320_3 in pairs(arg_317_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_320_3 then
						iter_320_3.color = arg_317_1.isInRecall_ and (arg_317_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_317_1.var_.actorSpriteComps10018 = nil
			end

			local var_320_2 = 0
			local var_320_3 = 1.3

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_2 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_4 = arg_317_1:GetWordFromCfg(114251078)
				local var_320_5 = arg_317_1:FormatText(var_320_4.content)

				arg_317_1.text_.text = var_320_5

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_7 = 52 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_5) / 52)

				if (52 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_5) / 52)) > 0 and var_320_3 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_2
					end
				end

				arg_317_1.text_.text = var_320_5
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251078", "story_v_out_114251.awb") ~= 0 then
					local var_320_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251078", "story_v_out_114251.awb") / 1000

					if var_320_8 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_8 + var_320_2
					end

					if var_320_4.prefab_name ~= "" and arg_317_1.actors_[var_320_4.prefab_name] ~= nil then
						local var_320_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_4.prefab_name].transform, "story_v_out_114251", "114251078", "story_v_out_114251.awb")

						arg_317_1:RecordAudio("114251078", var_320_9)
						arg_317_1:RecordAudio("114251078", var_320_9)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_out_114251", "114251078", "story_v_out_114251.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_out_114251", "114251078", "story_v_out_114251.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_10 = math.max(var_320_3, arg_317_1.talkMaxDuration)

			if var_320_2 <= arg_317_1.time_ and arg_317_1.time_ < var_320_2 + var_320_10 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_2) / var_320_10

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_2 + var_320_10 and arg_317_1.time_ < var_320_2 + var_320_10 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play114251079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 114251079
		arg_321_1.duration_ = 5.43

		local var_321_0 = {
			ja = 5.433,
			ko = 3.4,
			zh = 3.333,
			en = 3.1
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
				arg_321_0:Play114251080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["10021"]) and arg_321_1.var_.actorSpriteComps10021 == nil then
				arg_321_1.var_.actorSpriteComps10021 = arg_321_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_0 = 0.034

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["10021"]) then
				if arg_321_1.var_.actorSpriteComps10021 then
					for iter_324_0, iter_324_1 in pairs(arg_321_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_324_1 then
							if arg_321_1.isInRecall_ then
								iter_324_1.color = Color.New(Mathf.Lerp(iter_324_1.color.r, arg_321_1.hightColor1.r, (arg_321_1.time_ - 0) / var_324_0), Mathf.Lerp(iter_324_1.color.g, arg_321_1.hightColor1.g, (arg_321_1.time_ - 0) / var_324_0), (Mathf.Lerp(iter_324_1.color.b, arg_321_1.hightColor1.b, (arg_321_1.time_ - 0) / var_324_0)))
							else
								local var_324_1 = Mathf.Lerp(iter_324_1.color.r, 1, (arg_321_1.time_ - 0) / var_324_0)

								iter_324_1.color = Color.New(var_324_1, var_324_1, var_324_1)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["10021"]) and arg_321_1.var_.actorSpriteComps10021 then
				for iter_324_2, iter_324_3 in pairs(arg_321_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_324_3 then
						iter_324_3.color = arg_321_1.isInRecall_ and (arg_321_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_321_1.var_.actorSpriteComps10021 = nil
			end

			local var_324_2 = arg_321_1.actors_["10018"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_2) and arg_321_1.var_.actorSpriteComps10018 == nil then
				arg_321_1.var_.actorSpriteComps10018 = var_324_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_324_3 = 0.034

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_3 and not isNil(var_324_2) then
				if arg_321_1.var_.actorSpriteComps10018 then
					for iter_324_4, iter_324_5 in pairs(arg_321_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_324_5 then
							if arg_321_1.isInRecall_ then
								iter_324_5.color = Color.New(Mathf.Lerp(iter_324_5.color.r, arg_321_1.hightColor2.r, (arg_321_1.time_ - 0) / var_324_3), Mathf.Lerp(iter_324_5.color.g, arg_321_1.hightColor2.g, (arg_321_1.time_ - 0) / var_324_3), (Mathf.Lerp(iter_324_5.color.b, arg_321_1.hightColor2.b, (arg_321_1.time_ - 0) / var_324_3)))
							else
								local var_324_4 = Mathf.Lerp(iter_324_5.color.r, 0.5, (arg_321_1.time_ - 0) / var_324_3)

								iter_324_5.color = Color.New(var_324_4, var_324_4, var_324_4)
							end
						end
					end
				end
			end

			if arg_321_1.time_ >= 0 + var_324_3 and arg_321_1.time_ < 0 + var_324_3 + arg_324_0 and not isNil(var_324_2) and arg_321_1.var_.actorSpriteComps10018 then
				for iter_324_6, iter_324_7 in pairs(arg_321_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_324_7 then
						iter_324_7.color = arg_321_1.isInRecall_ and (arg_321_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_321_1.var_.actorSpriteComps10018 = nil
			end

			local var_324_5 = 0
			local var_324_6 = 0.35

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_5 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_7 = arg_321_1:GetWordFromCfg(114251079)
				local var_324_8 = arg_321_1:FormatText(var_324_7.content)

				arg_321_1.text_.text = var_324_8

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_10 = 14 <= 0 and var_324_6 or var_324_6 * (utf8.len(var_324_8) / 14)

				if (14 <= 0 and var_324_6 or var_324_6 * (utf8.len(var_324_8) / 14)) > 0 and var_324_6 < var_324_10 then
					arg_321_1.talkMaxDuration = var_324_10

					if var_324_10 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_10 + var_324_5
					end
				end

				arg_321_1.text_.text = var_324_8
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251079", "story_v_out_114251.awb") ~= 0 then
					local var_324_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251079", "story_v_out_114251.awb") / 1000

					if var_324_11 + var_324_5 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_11 + var_324_5
					end

					if var_324_7.prefab_name ~= "" and arg_321_1.actors_[var_324_7.prefab_name] ~= nil then
						local var_324_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_7.prefab_name].transform, "story_v_out_114251", "114251079", "story_v_out_114251.awb")

						arg_321_1:RecordAudio("114251079", var_324_12)
						arg_321_1:RecordAudio("114251079", var_324_12)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_114251", "114251079", "story_v_out_114251.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_114251", "114251079", "story_v_out_114251.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_13 = math.max(var_324_6, arg_321_1.talkMaxDuration)

			if var_324_5 <= arg_321_1.time_ and arg_321_1.time_ < var_324_5 + var_324_13 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_5) / var_324_13

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_5 + var_324_13 and arg_321_1.time_ < var_324_5 + var_324_13 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play114251080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 114251080
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play114251081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 and not isNil(arg_325_1.actors_["10021"]) and arg_325_1.var_.actorSpriteComps10021 == nil then
				arg_325_1.var_.actorSpriteComps10021 = arg_325_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_328_0 = 0.034

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_0 and not isNil(arg_325_1.actors_["10021"]) then
				if arg_325_1.var_.actorSpriteComps10021 then
					for iter_328_0, iter_328_1 in pairs(arg_325_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_328_1 then
							if arg_325_1.isInRecall_ then
								iter_328_1.color = Color.New(Mathf.Lerp(iter_328_1.color.r, arg_325_1.hightColor2.r, (arg_325_1.time_ - 0) / var_328_0), Mathf.Lerp(iter_328_1.color.g, arg_325_1.hightColor2.g, (arg_325_1.time_ - 0) / var_328_0), (Mathf.Lerp(iter_328_1.color.b, arg_325_1.hightColor2.b, (arg_325_1.time_ - 0) / var_328_0)))
							else
								local var_328_1 = Mathf.Lerp(iter_328_1.color.r, 0.5, (arg_325_1.time_ - 0) / var_328_0)

								iter_328_1.color = Color.New(var_328_1, var_328_1, var_328_1)
							end
						end
					end
				end
			end

			if arg_325_1.time_ >= 0 + var_328_0 and arg_325_1.time_ < 0 + var_328_0 + arg_328_0 and not isNil(arg_325_1.actors_["10021"]) and arg_325_1.var_.actorSpriteComps10021 then
				for iter_328_2, iter_328_3 in pairs(arg_325_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_328_3 then
						iter_328_3.color = arg_325_1.isInRecall_ and (arg_325_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_325_1.var_.actorSpriteComps10021 = nil
			end

			local var_328_2 = 0
			local var_328_3 = 0.375

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_2 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_4 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(114251080).content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_6 = 15 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_4) / 15)

				if (15 <= 0 and var_328_3 or var_328_3 * (utf8.len(var_328_4) / 15)) > 0 and var_328_3 < var_328_6 then
					arg_325_1.talkMaxDuration = var_328_6

					if var_328_6 + var_328_2 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_6 + var_328_2
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_3, arg_325_1.talkMaxDuration)

			if var_328_2 <= arg_325_1.time_ and arg_325_1.time_ < var_328_2 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_2) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_2 + var_328_7 and arg_325_1.time_ < var_328_2 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play114251081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 114251081
		arg_329_1.duration_ = 4.23

		local var_329_0 = {
			ja = 3.666,
			ko = 4.233,
			zh = 2.966,
			en = 4.233
		}
		local var_329_1 = manager.audio:GetLocalizationFlag()

		if var_329_0[var_329_1] ~= nil then
			arg_329_1.duration_ = var_329_0[var_329_1]
		end

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play114251082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["10021"]) and arg_329_1.var_.actorSpriteComps10021 == nil then
				arg_329_1.var_.actorSpriteComps10021 = arg_329_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_332_0 = 0.034

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["10021"]) then
				if arg_329_1.var_.actorSpriteComps10021 then
					for iter_332_0, iter_332_1 in pairs(arg_329_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_332_1 then
							if arg_329_1.isInRecall_ then
								iter_332_1.color = Color.New(Mathf.Lerp(iter_332_1.color.r, arg_329_1.hightColor1.r, (arg_329_1.time_ - 0) / var_332_0), Mathf.Lerp(iter_332_1.color.g, arg_329_1.hightColor1.g, (arg_329_1.time_ - 0) / var_332_0), (Mathf.Lerp(iter_332_1.color.b, arg_329_1.hightColor1.b, (arg_329_1.time_ - 0) / var_332_0)))
							else
								local var_332_1 = Mathf.Lerp(iter_332_1.color.r, 1, (arg_329_1.time_ - 0) / var_332_0)

								iter_332_1.color = Color.New(var_332_1, var_332_1, var_332_1)
							end
						end
					end
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["10021"]) and arg_329_1.var_.actorSpriteComps10021 then
				for iter_332_2, iter_332_3 in pairs(arg_329_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_332_3 then
						iter_332_3.color = arg_329_1.isInRecall_ and (arg_329_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_329_1.var_.actorSpriteComps10021 = nil
			end

			local var_332_2 = 0
			local var_332_3 = 0.45

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_2 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_4 = arg_329_1:GetWordFromCfg(114251081)
				local var_332_5 = arg_329_1:FormatText(var_332_4.content)

				arg_329_1.text_.text = var_332_5

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_7 = 18 <= 0 and var_332_3 or var_332_3 * (utf8.len(var_332_5) / 18)

				if (18 <= 0 and var_332_3 or var_332_3 * (utf8.len(var_332_5) / 18)) > 0 and var_332_3 < var_332_7 then
					arg_329_1.talkMaxDuration = var_332_7

					if var_332_7 + var_332_2 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_2
					end
				end

				arg_329_1.text_.text = var_332_5
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251081", "story_v_out_114251.awb") ~= 0 then
					local var_332_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251081", "story_v_out_114251.awb") / 1000

					if var_332_8 + var_332_2 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_8 + var_332_2
					end

					if var_332_4.prefab_name ~= "" and arg_329_1.actors_[var_332_4.prefab_name] ~= nil then
						local var_332_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_329_1.actors_[var_332_4.prefab_name].transform, "story_v_out_114251", "114251081", "story_v_out_114251.awb")

						arg_329_1:RecordAudio("114251081", var_332_9)
						arg_329_1:RecordAudio("114251081", var_332_9)
					else
						arg_329_1:AudioAction("play", "voice", "story_v_out_114251", "114251081", "story_v_out_114251.awb")
					end

					arg_329_1:RecordHistoryTalkVoice("story_v_out_114251", "114251081", "story_v_out_114251.awb")
				end

				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_10 = math.max(var_332_3, arg_329_1.talkMaxDuration)

			if var_332_2 <= arg_329_1.time_ and arg_329_1.time_ < var_332_2 + var_332_10 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_2) / var_332_10

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_2 + var_332_10 and arg_329_1.time_ < var_332_2 + var_332_10 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play114251082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 114251082
		arg_333_1.duration_ = 5.2

		local var_333_0 = {
			ja = 4.766,
			ko = 3.1,
			zh = 5.2,
			en = 4.733
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
				arg_333_0:Play114251083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["10021"]) and arg_333_1.var_.actorSpriteComps10021 == nil then
				arg_333_1.var_.actorSpriteComps10021 = arg_333_1.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_0 = 0.034

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["10021"]) then
				if arg_333_1.var_.actorSpriteComps10021 then
					for iter_336_0, iter_336_1 in pairs(arg_333_1.var_.actorSpriteComps10021:ToTable()) do
						if iter_336_1 then
							if arg_333_1.isInRecall_ then
								iter_336_1.color = Color.New(Mathf.Lerp(iter_336_1.color.r, arg_333_1.hightColor2.r, (arg_333_1.time_ - 0) / var_336_0), Mathf.Lerp(iter_336_1.color.g, arg_333_1.hightColor2.g, (arg_333_1.time_ - 0) / var_336_0), (Mathf.Lerp(iter_336_1.color.b, arg_333_1.hightColor2.b, (arg_333_1.time_ - 0) / var_336_0)))
							else
								local var_336_1 = Mathf.Lerp(iter_336_1.color.r, 0.5, (arg_333_1.time_ - 0) / var_336_0)

								iter_336_1.color = Color.New(var_336_1, var_336_1, var_336_1)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["10021"]) and arg_333_1.var_.actorSpriteComps10021 then
				for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps10021:ToTable()) do
					if iter_336_3 then
						iter_336_3.color = arg_333_1.isInRecall_ and (arg_333_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_333_1.var_.actorSpriteComps10021 = nil
			end

			local var_336_2 = arg_333_1.actors_["10018"]

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.actorSpriteComps10018 == nil then
				arg_333_1.var_.actorSpriteComps10018 = var_336_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_3 = 0.034

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_3 and not isNil(var_336_2) then
				if arg_333_1.var_.actorSpriteComps10018 then
					for iter_336_4, iter_336_5 in pairs(arg_333_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_336_5 then
							if arg_333_1.isInRecall_ then
								iter_336_5.color = Color.New(Mathf.Lerp(iter_336_5.color.r, arg_333_1.hightColor1.r, (arg_333_1.time_ - 0) / var_336_3), Mathf.Lerp(iter_336_5.color.g, arg_333_1.hightColor1.g, (arg_333_1.time_ - 0) / var_336_3), (Mathf.Lerp(iter_336_5.color.b, arg_333_1.hightColor1.b, (arg_333_1.time_ - 0) / var_336_3)))
							else
								local var_336_4 = Mathf.Lerp(iter_336_5.color.r, 1, (arg_333_1.time_ - 0) / var_336_3)

								iter_336_5.color = Color.New(var_336_4, var_336_4, var_336_4)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= 0 + var_336_3 and arg_333_1.time_ < 0 + var_336_3 + arg_336_0 and not isNil(var_336_2) and arg_333_1.var_.actorSpriteComps10018 then
				for iter_336_6, iter_336_7 in pairs(arg_333_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_336_7 then
						iter_336_7.color = arg_333_1.isInRecall_ and (arg_333_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_333_1.var_.actorSpriteComps10018 = nil
			end

			local var_336_5 = 0
			local var_336_6 = 0.25

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_5 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_7 = arg_333_1:GetWordFromCfg(114251082)
				local var_336_8 = arg_333_1:FormatText(var_336_7.content)

				arg_333_1.text_.text = var_336_8

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_10 = 10 <= 0 and var_336_6 or var_336_6 * (utf8.len(var_336_8) / 10)

				if (10 <= 0 and var_336_6 or var_336_6 * (utf8.len(var_336_8) / 10)) > 0 and var_336_6 < var_336_10 then
					arg_333_1.talkMaxDuration = var_336_10

					if var_336_10 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_5
					end
				end

				arg_333_1.text_.text = var_336_8
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251082", "story_v_out_114251.awb") ~= 0 then
					local var_336_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251082", "story_v_out_114251.awb") / 1000

					if var_336_11 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_11 + var_336_5
					end

					if var_336_7.prefab_name ~= "" and arg_333_1.actors_[var_336_7.prefab_name] ~= nil then
						local var_336_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_7.prefab_name].transform, "story_v_out_114251", "114251082", "story_v_out_114251.awb")

						arg_333_1:RecordAudio("114251082", var_336_12)
						arg_333_1:RecordAudio("114251082", var_336_12)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_114251", "114251082", "story_v_out_114251.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_114251", "114251082", "story_v_out_114251.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_13 = math.max(var_336_6, arg_333_1.talkMaxDuration)

			if var_336_5 <= arg_333_1.time_ and arg_333_1.time_ < var_336_5 + var_336_13 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_5) / var_336_13

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_5 + var_336_13 and arg_333_1.time_ < var_336_5 + var_336_13 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play114251083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 114251083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play114251084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				local var_340_0 = arg_337_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_340_0 then
					arg_337_1.var_.alphaOldValue10018 = var_340_0.alpha
					arg_337_1.var_.characterEffect10018 = var_340_0
				end

				arg_337_1.var_.alphaOldValue10018 = 1
			end

			local var_340_1 = 0.5

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_1 then
				if arg_337_1.var_.characterEffect10018 then
					arg_337_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_337_1.var_.alphaOldValue10018, 0, (arg_337_1.time_ - 0) / var_340_1)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_1 and arg_337_1.time_ < 0 + var_340_1 + arg_340_0 and arg_337_1.var_.characterEffect10018 then
				arg_337_1.var_.characterEffect10018.alpha = 0
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				local var_340_2 = arg_337_1.actors_["10021"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_340_2 then
					arg_337_1.var_.alphaOldValue10021 = var_340_2.alpha
					arg_337_1.var_.characterEffect10021 = var_340_2
				end

				arg_337_1.var_.alphaOldValue10021 = 1
			end

			local var_340_3 = 0.5

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_3 then
				if arg_337_1.var_.characterEffect10021 then
					arg_337_1.var_.characterEffect10021.alpha = Mathf.Lerp(arg_337_1.var_.alphaOldValue10021, 0, (arg_337_1.time_ - 0) / var_340_3)
				end
			end

			if arg_337_1.time_ >= 0 + var_340_3 and arg_337_1.time_ < 0 + var_340_3 + arg_340_0 and arg_337_1.var_.characterEffect10021 then
				arg_337_1.var_.characterEffect10021.alpha = 0
			end

			local var_340_4 = 0
			local var_340_5 = 0.925

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_4 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_6 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(114251083).content)

				arg_337_1.text_.text = var_340_6

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_8 = 37 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_6) / 37)

				if (37 <= 0 and var_340_5 or var_340_5 * (utf8.len(var_340_6) / 37)) > 0 and var_340_5 < var_340_8 then
					arg_337_1.talkMaxDuration = var_340_8

					if var_340_8 + var_340_4 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_8 + var_340_4
					end
				end

				arg_337_1.text_.text = var_340_6
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_9 = math.max(var_340_5, arg_337_1.talkMaxDuration)

			if var_340_4 <= arg_337_1.time_ and arg_337_1.time_ < var_340_4 + var_340_9 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_4) / var_340_9

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_4 + var_340_9 and arg_337_1.time_ < var_340_4 + var_340_9 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play114251084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 114251084
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play114251085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = 1.3

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_1 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(114251084).content)

				arg_341_1.text_.text = var_344_1

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_3 = 51 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 51)

				if (51 <= 0 and var_344_0 or var_344_0 * (utf8.len(var_344_1) / 51)) > 0 and var_344_0 < var_344_3 then
					arg_341_1.talkMaxDuration = var_344_3

					if var_344_3 + 0 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_3 + 0
					end
				end

				arg_341_1.text_.text = var_344_1
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_4 = math.max(var_344_0, arg_341_1.talkMaxDuration)

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_4 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - 0) / var_344_4

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= 0 + var_344_4 and arg_341_1.time_ < 0 + var_344_4 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play114251085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 114251085
		arg_345_1.duration_ = 4.3

		local var_345_0 = {
			ja = 3.133,
			ko = 3.6,
			zh = 4,
			en = 4.3
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
				arg_345_0:Play114251086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos10018 = arg_345_1.actors_["10018"].transform.localPosition
				arg_345_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("10018", 3)

				for iter_348_0 = 0, arg_345_1.actors_["10018"].transform.childCount - 1 do
					local var_348_0 = arg_345_1.actors_["10018"].transform:GetChild(iter_348_0)

					if var_348_0.name == "split_2" or not string.find(var_348_0.name, "split") then
						var_348_0.gameObject:SetActive(true)
					else
						var_348_0.gameObject:SetActive(false)
					end
				end
			end

			local var_348_1 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_1 then
				arg_345_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10018, Vector3.New(0, -350, -180), (arg_345_1.time_ - 0) / var_348_1)
			end

			if arg_345_1.time_ >= 0 + var_348_1 and arg_345_1.time_ < 0 + var_348_1 + arg_348_0 then
				arg_345_1.actors_["10018"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_348_2 = arg_345_1.actors_["10018"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_2) and arg_345_1.var_.actorSpriteComps10018 == nil then
				arg_345_1.var_.actorSpriteComps10018 = var_348_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_3 = 0.034

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_3 and not isNil(var_348_2) then
				if arg_345_1.var_.actorSpriteComps10018 then
					for iter_348_1, iter_348_2 in pairs(arg_345_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_348_2 then
							if arg_345_1.isInRecall_ then
								iter_348_2.color = Color.New(Mathf.Lerp(iter_348_2.color.r, arg_345_1.hightColor1.r, (arg_345_1.time_ - 0) / var_348_3), Mathf.Lerp(iter_348_2.color.g, arg_345_1.hightColor1.g, (arg_345_1.time_ - 0) / var_348_3), (Mathf.Lerp(iter_348_2.color.b, arg_345_1.hightColor1.b, (arg_345_1.time_ - 0) / var_348_3)))
							else
								local var_348_4 = Mathf.Lerp(iter_348_2.color.r, 1, (arg_345_1.time_ - 0) / var_348_3)

								iter_348_2.color = Color.New(var_348_4, var_348_4, var_348_4)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= 0 + var_348_3 and arg_345_1.time_ < 0 + var_348_3 + arg_348_0 and not isNil(var_348_2) and arg_345_1.var_.actorSpriteComps10018 then
				for iter_348_3, iter_348_4 in pairs(arg_345_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_348_4 then
						iter_348_4.color = arg_345_1.isInRecall_ and (arg_345_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_345_1.var_.actorSpriteComps10018 = nil
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				local var_348_5 = arg_345_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_348_5 then
					arg_345_1.var_.alphaOldValue10018 = var_348_5.alpha
					arg_345_1.var_.characterEffect10018 = var_348_5
				end

				arg_345_1.var_.alphaOldValue10018 = 0
			end

			local var_348_6 = 0.5

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_6 then
				if arg_345_1.var_.characterEffect10018 then
					arg_345_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_345_1.var_.alphaOldValue10018, 1, (arg_345_1.time_ - 0) / var_348_6)
				end
			end

			if arg_345_1.time_ >= 0 + var_348_6 and arg_345_1.time_ < 0 + var_348_6 + arg_348_0 and arg_345_1.var_.characterEffect10018 then
				arg_345_1.var_.characterEffect10018.alpha = 1
			end

			local var_348_7 = 0
			local var_348_8 = 0.3

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_7 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_9 = arg_345_1:GetWordFromCfg(114251085)
				local var_348_10 = arg_345_1:FormatText(var_348_9.content)

				arg_345_1.text_.text = var_348_10

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_12 = 12 <= 0 and var_348_8 or var_348_8 * (utf8.len(var_348_10) / 12)

				if (12 <= 0 and var_348_8 or var_348_8 * (utf8.len(var_348_10) / 12)) > 0 and var_348_8 < var_348_12 then
					arg_345_1.talkMaxDuration = var_348_12

					if var_348_12 + var_348_7 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_12 + var_348_7
					end
				end

				arg_345_1.text_.text = var_348_10
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251085", "story_v_out_114251.awb") ~= 0 then
					local var_348_13 = manager.audio:GetVoiceLength("story_v_out_114251", "114251085", "story_v_out_114251.awb") / 1000

					if var_348_13 + var_348_7 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_13 + var_348_7
					end

					if var_348_9.prefab_name ~= "" and arg_345_1.actors_[var_348_9.prefab_name] ~= nil then
						local var_348_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_9.prefab_name].transform, "story_v_out_114251", "114251085", "story_v_out_114251.awb")

						arg_345_1:RecordAudio("114251085", var_348_14)
						arg_345_1:RecordAudio("114251085", var_348_14)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_114251", "114251085", "story_v_out_114251.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_114251", "114251085", "story_v_out_114251.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_15 = math.max(var_348_8, arg_345_1.talkMaxDuration)

			if var_348_7 <= arg_345_1.time_ and arg_345_1.time_ < var_348_7 + var_348_15 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_7) / var_348_15

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_7 + var_348_15 and arg_345_1.time_ < var_348_7 + var_348_15 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_345_1:InitPlayNodeList()
	end,
	Play114251086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 114251086
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play114251087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["10018"]) and arg_349_1.var_.actorSpriteComps10018 == nil then
				arg_349_1.var_.actorSpriteComps10018 = arg_349_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_0 = 0.034

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["10018"]) then
				if arg_349_1.var_.actorSpriteComps10018 then
					for iter_352_0, iter_352_1 in pairs(arg_349_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_352_1 then
							if arg_349_1.isInRecall_ then
								iter_352_1.color = Color.New(Mathf.Lerp(iter_352_1.color.r, arg_349_1.hightColor2.r, (arg_349_1.time_ - 0) / var_352_0), Mathf.Lerp(iter_352_1.color.g, arg_349_1.hightColor2.g, (arg_349_1.time_ - 0) / var_352_0), (Mathf.Lerp(iter_352_1.color.b, arg_349_1.hightColor2.b, (arg_349_1.time_ - 0) / var_352_0)))
							else
								local var_352_1 = Mathf.Lerp(iter_352_1.color.r, 0.5, (arg_349_1.time_ - 0) / var_352_0)

								iter_352_1.color = Color.New(var_352_1, var_352_1, var_352_1)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["10018"]) and arg_349_1.var_.actorSpriteComps10018 then
				for iter_352_2, iter_352_3 in pairs(arg_349_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_352_3 then
						iter_352_3.color = arg_349_1.isInRecall_ and (arg_349_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_349_1.var_.actorSpriteComps10018 = nil
			end

			local var_352_2 = 0
			local var_352_3 = 2.3

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_2 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, false)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_4 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(114251086).content)

				arg_349_1.text_.text = var_352_4

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_6 = 92 <= 0 and var_352_3 or var_352_3 * (utf8.len(var_352_4) / 92)

				if (92 <= 0 and var_352_3 or var_352_3 * (utf8.len(var_352_4) / 92)) > 0 and var_352_3 < var_352_6 then
					arg_349_1.talkMaxDuration = var_352_6

					if var_352_6 + var_352_2 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_6 + var_352_2
					end
				end

				arg_349_1.text_.text = var_352_4
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_7 = math.max(var_352_3, arg_349_1.talkMaxDuration)

			if var_352_2 <= arg_349_1.time_ and arg_349_1.time_ < var_352_2 + var_352_7 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_2) / var_352_7

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_2 + var_352_7 and arg_349_1.time_ < var_352_2 + var_352_7 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play114251087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 114251087
		arg_353_1.duration_ = 3.67

		local var_353_0 = {
			ja = 2.833,
			ko = 3.666,
			zh = 3.466,
			en = 3.166
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play114251088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos10018 = arg_353_1.actors_["10018"].transform.localPosition
				arg_353_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_353_1:CheckSpriteTmpPos("10018", 3)

				for iter_356_0 = 0, arg_353_1.actors_["10018"].transform.childCount - 1 do
					local var_356_0 = arg_353_1.actors_["10018"].transform:GetChild(iter_356_0)

					if var_356_0.name == "split_1" or not string.find(var_356_0.name, "split") then
						var_356_0.gameObject:SetActive(true)
					else
						var_356_0.gameObject:SetActive(false)
					end
				end
			end

			local var_356_1 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_1 then
				arg_353_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos10018, Vector3.New(0, -350, -180), (arg_353_1.time_ - 0) / var_356_1)
			end

			if arg_353_1.time_ >= 0 + var_356_1 and arg_353_1.time_ < 0 + var_356_1 + arg_356_0 then
				arg_353_1.actors_["10018"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_356_2 = arg_353_1.actors_["10018"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.actorSpriteComps10018 == nil then
				arg_353_1.var_.actorSpriteComps10018 = var_356_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_3 = 0.034

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_3 and not isNil(var_356_2) then
				if arg_353_1.var_.actorSpriteComps10018 then
					for iter_356_1, iter_356_2 in pairs(arg_353_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_356_2 then
							if arg_353_1.isInRecall_ then
								iter_356_2.color = Color.New(Mathf.Lerp(iter_356_2.color.r, arg_353_1.hightColor1.r, (arg_353_1.time_ - 0) / var_356_3), Mathf.Lerp(iter_356_2.color.g, arg_353_1.hightColor1.g, (arg_353_1.time_ - 0) / var_356_3), (Mathf.Lerp(iter_356_2.color.b, arg_353_1.hightColor1.b, (arg_353_1.time_ - 0) / var_356_3)))
							else
								local var_356_4 = Mathf.Lerp(iter_356_2.color.r, 1, (arg_353_1.time_ - 0) / var_356_3)

								iter_356_2.color = Color.New(var_356_4, var_356_4, var_356_4)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= 0 + var_356_3 and arg_353_1.time_ < 0 + var_356_3 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.actorSpriteComps10018 then
				for iter_356_3, iter_356_4 in pairs(arg_353_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_356_4 then
						iter_356_4.color = arg_353_1.isInRecall_ and (arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_353_1.var_.actorSpriteComps10018 = nil
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				local var_356_5 = arg_353_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_356_5 then
					arg_353_1.var_.alphaOldValue10018 = var_356_5.alpha
					arg_353_1.var_.characterEffect10018 = var_356_5
				end

				arg_353_1.var_.alphaOldValue10018 = 0
			end

			local var_356_6 = 0.0166666666666667

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_6 then
				if arg_353_1.var_.characterEffect10018 then
					arg_353_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_353_1.var_.alphaOldValue10018, 1, (arg_353_1.time_ - 0) / var_356_6)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_6 and arg_353_1.time_ < 0 + var_356_6 + arg_356_0 and arg_353_1.var_.characterEffect10018 then
				arg_353_1.var_.characterEffect10018.alpha = 1
			end

			local var_356_7 = 0
			local var_356_8 = 0.275

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_7 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_9 = arg_353_1:GetWordFromCfg(114251087)
				local var_356_10 = arg_353_1:FormatText(var_356_9.content)

				arg_353_1.text_.text = var_356_10

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_12 = 11 <= 0 and var_356_8 or var_356_8 * (utf8.len(var_356_10) / 11)

				if (11 <= 0 and var_356_8 or var_356_8 * (utf8.len(var_356_10) / 11)) > 0 and var_356_8 < var_356_12 then
					arg_353_1.talkMaxDuration = var_356_12

					if var_356_12 + var_356_7 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_12 + var_356_7
					end
				end

				arg_353_1.text_.text = var_356_10
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251087", "story_v_out_114251.awb") ~= 0 then
					local var_356_13 = manager.audio:GetVoiceLength("story_v_out_114251", "114251087", "story_v_out_114251.awb") / 1000

					if var_356_13 + var_356_7 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_13 + var_356_7
					end

					if var_356_9.prefab_name ~= "" and arg_353_1.actors_[var_356_9.prefab_name] ~= nil then
						local var_356_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_9.prefab_name].transform, "story_v_out_114251", "114251087", "story_v_out_114251.awb")

						arg_353_1:RecordAudio("114251087", var_356_14)
						arg_353_1:RecordAudio("114251087", var_356_14)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_114251", "114251087", "story_v_out_114251.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_114251", "114251087", "story_v_out_114251.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_15 = math.max(var_356_8, arg_353_1.talkMaxDuration)

			if var_356_7 <= arg_353_1.time_ and arg_353_1.time_ < var_356_7 + var_356_15 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_7) / var_356_15

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_7 + var_356_15 and arg_353_1.time_ < var_356_7 + var_356_15 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play114251088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 114251088
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play114251089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["10018"]) and arg_357_1.var_.actorSpriteComps10018 == nil then
				arg_357_1.var_.actorSpriteComps10018 = arg_357_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_0 = 0.034

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["10018"]) then
				if arg_357_1.var_.actorSpriteComps10018 then
					for iter_360_0, iter_360_1 in pairs(arg_357_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_360_1 then
							if arg_357_1.isInRecall_ then
								iter_360_1.color = Color.New(Mathf.Lerp(iter_360_1.color.r, arg_357_1.hightColor2.r, (arg_357_1.time_ - 0) / var_360_0), Mathf.Lerp(iter_360_1.color.g, arg_357_1.hightColor2.g, (arg_357_1.time_ - 0) / var_360_0), (Mathf.Lerp(iter_360_1.color.b, arg_357_1.hightColor2.b, (arg_357_1.time_ - 0) / var_360_0)))
							else
								local var_360_1 = Mathf.Lerp(iter_360_1.color.r, 0.5, (arg_357_1.time_ - 0) / var_360_0)

								iter_360_1.color = Color.New(var_360_1, var_360_1, var_360_1)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["10018"]) and arg_357_1.var_.actorSpriteComps10018 then
				for iter_360_2, iter_360_3 in pairs(arg_357_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_360_3 then
						iter_360_3.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_357_1.var_.actorSpriteComps10018 = nil
			end

			local var_360_2 = 0
			local var_360_3 = 0.7

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_2 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_4 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(114251088).content)

				arg_357_1.text_.text = var_360_4

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_6 = 28 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_4) / 28)

				if (28 <= 0 and var_360_3 or var_360_3 * (utf8.len(var_360_4) / 28)) > 0 and var_360_3 < var_360_6 then
					arg_357_1.talkMaxDuration = var_360_6

					if var_360_6 + var_360_2 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_6 + var_360_2
					end
				end

				arg_357_1.text_.text = var_360_4
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_7 = math.max(var_360_3, arg_357_1.talkMaxDuration)

			if var_360_2 <= arg_357_1.time_ and arg_357_1.time_ < var_360_2 + var_360_7 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_2) / var_360_7

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_2 + var_360_7 and arg_357_1.time_ < var_360_2 + var_360_7 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play114251089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 114251089
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play114251090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				local var_364_0 = arg_361_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_364_0 then
					arg_361_1.var_.alphaOldValue10018 = var_364_0.alpha
					arg_361_1.var_.characterEffect10018 = var_364_0
				end

				arg_361_1.var_.alphaOldValue10018 = 1
			end

			local var_364_1 = 0.5

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_1 then
				if arg_361_1.var_.characterEffect10018 then
					arg_361_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_361_1.var_.alphaOldValue10018, 0, (arg_361_1.time_ - 0) / var_364_1)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_1 and arg_361_1.time_ < 0 + var_364_1 + arg_364_0 and arg_361_1.var_.characterEffect10018 then
				arg_361_1.var_.characterEffect10018.alpha = 0
			end

			local var_364_2 = 0
			local var_364_3 = 1.075

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_2 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_4 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(114251089).content)

				arg_361_1.text_.text = var_364_4

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_6 = 43 <= 0 and var_364_3 or var_364_3 * (utf8.len(var_364_4) / 43)

				if (43 <= 0 and var_364_3 or var_364_3 * (utf8.len(var_364_4) / 43)) > 0 and var_364_3 < var_364_6 then
					arg_361_1.talkMaxDuration = var_364_6

					if var_364_6 + var_364_2 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_6 + var_364_2
					end
				end

				arg_361_1.text_.text = var_364_4
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_7 = math.max(var_364_3, arg_361_1.talkMaxDuration)

			if var_364_2 <= arg_361_1.time_ and arg_361_1.time_ < var_364_2 + var_364_7 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_2) / var_364_7

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_2 + var_364_7 and arg_361_1.time_ < var_364_2 + var_364_7 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play114251090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 114251090
		arg_365_1.duration_ = 15.5

		local var_365_0 = {
			ja = 15.5,
			ko = 2.8,
			zh = 3.933,
			en = 2.7
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
				arg_365_0:Play114251091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0.25

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10021")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_1 = arg_365_1:GetWordFromCfg(114251090)
				local var_368_2 = arg_365_1:FormatText(var_368_1.content)

				arg_365_1.text_.text = var_368_2

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_4 = 10 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 10)

				if (10 <= 0 and var_368_0 or var_368_0 * (utf8.len(var_368_2) / 10)) > 0 and var_368_0 < var_368_4 then
					arg_365_1.talkMaxDuration = var_368_4

					if var_368_4 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_4 + 0
					end
				end

				arg_365_1.text_.text = var_368_2
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251090", "story_v_out_114251.awb") ~= 0 then
					local var_368_5 = manager.audio:GetVoiceLength("story_v_out_114251", "114251090", "story_v_out_114251.awb") / 1000

					if var_368_5 + 0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_5 + 0
					end

					if var_368_1.prefab_name ~= "" and arg_365_1.actors_[var_368_1.prefab_name] ~= nil then
						local var_368_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_365_1.actors_[var_368_1.prefab_name].transform, "story_v_out_114251", "114251090", "story_v_out_114251.awb")

						arg_365_1:RecordAudio("114251090", var_368_6)
						arg_365_1:RecordAudio("114251090", var_368_6)
					else
						arg_365_1:AudioAction("play", "voice", "story_v_out_114251", "114251090", "story_v_out_114251.awb")
					end

					arg_365_1:RecordHistoryTalkVoice("story_v_out_114251", "114251090", "story_v_out_114251.awb")
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
	Play114251091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 114251091
		arg_369_1.duration_ = 2.33

		local var_369_0 = {
			ja = 2.333,
			ko = 1.533,
			zh = 0.999999999999,
			en = 1.233
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
				arg_369_0:Play114251092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["10018"]) and arg_369_1.var_.actorSpriteComps10018 == nil then
				arg_369_1.var_.actorSpriteComps10018 = arg_369_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_0 = 0.034

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["10018"]) then
				if arg_369_1.var_.actorSpriteComps10018 then
					for iter_372_0, iter_372_1 in pairs(arg_369_1.var_.actorSpriteComps10018:ToTable()) do
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

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["10018"]) and arg_369_1.var_.actorSpriteComps10018 then
				for iter_372_2, iter_372_3 in pairs(arg_369_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_372_3 then
						iter_372_3.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_369_1.var_.actorSpriteComps10018 = nil
			end

			local var_372_2 = 0
			local var_372_3 = 0.05

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_2 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, true)
				arg_369_1.iconController_:SetSelectedState("hero")

				arg_369_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				arg_369_1.callingController_:SetSelectedState("normal")

				arg_369_1.keyicon_.color = Color.New(1, 1, 1)
				arg_369_1.icon_.color = Color.New(1, 1, 1)

				local var_372_4 = arg_369_1:GetWordFromCfg(114251091)
				local var_372_5 = arg_369_1:FormatText(var_372_4.content)

				arg_369_1.text_.text = var_372_5

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_7 = 2 <= 0 and var_372_3 or var_372_3 * (utf8.len(var_372_5) / 2)

				if (2 <= 0 and var_372_3 or var_372_3 * (utf8.len(var_372_5) / 2)) > 0 and var_372_3 < var_372_7 then
					arg_369_1.talkMaxDuration = var_372_7

					if var_372_7 + var_372_2 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_7 + var_372_2
					end
				end

				arg_369_1.text_.text = var_372_5
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251091", "story_v_out_114251.awb") ~= 0 then
					local var_372_8 = manager.audio:GetVoiceLength("story_v_out_114251", "114251091", "story_v_out_114251.awb") / 1000

					if var_372_8 + var_372_2 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_8 + var_372_2
					end

					if var_372_4.prefab_name ~= "" and arg_369_1.actors_[var_372_4.prefab_name] ~= nil then
						local var_372_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_4.prefab_name].transform, "story_v_out_114251", "114251091", "story_v_out_114251.awb")

						arg_369_1:RecordAudio("114251091", var_372_9)
						arg_369_1:RecordAudio("114251091", var_372_9)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_114251", "114251091", "story_v_out_114251.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_114251", "114251091", "story_v_out_114251.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_10 = math.max(var_372_3, arg_369_1.talkMaxDuration)

			if var_372_2 <= arg_369_1.time_ and arg_369_1.time_ < var_372_2 + var_372_10 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_2) / var_372_10

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_2 + var_372_10 and arg_369_1.time_ < var_372_2 + var_372_10 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play114251092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 114251092
		arg_373_1.duration_ = 6.13

		local var_373_0 = {
			ja = 4.633,
			ko = 6.133,
			zh = 5.9,
			en = 5.6
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
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play114251093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0.6

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, true)
				arg_373_1.iconController_:SetSelectedState("hero")

				arg_373_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				arg_373_1.callingController_:SetSelectedState("normal")

				arg_373_1.keyicon_.color = Color.New(1, 1, 1)
				arg_373_1.icon_.color = Color.New(1, 1, 1)

				local var_376_1 = arg_373_1:GetWordFromCfg(114251092)
				local var_376_2 = arg_373_1:FormatText(var_376_1.content)

				arg_373_1.text_.text = var_376_2

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_4 = 24 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_2) / 24)

				if (24 <= 0 and var_376_0 or var_376_0 * (utf8.len(var_376_2) / 24)) > 0 and var_376_0 < var_376_4 then
					arg_373_1.talkMaxDuration = var_376_4

					if var_376_4 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_4 + 0
					end
				end

				arg_373_1.text_.text = var_376_2
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251092", "story_v_out_114251.awb") ~= 0 then
					local var_376_5 = manager.audio:GetVoiceLength("story_v_out_114251", "114251092", "story_v_out_114251.awb") / 1000

					if var_376_5 + 0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_5 + 0
					end

					if var_376_1.prefab_name ~= "" and arg_373_1.actors_[var_376_1.prefab_name] ~= nil then
						local var_376_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_1.prefab_name].transform, "story_v_out_114251", "114251092", "story_v_out_114251.awb")

						arg_373_1:RecordAudio("114251092", var_376_6)
						arg_373_1:RecordAudio("114251092", var_376_6)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_114251", "114251092", "story_v_out_114251.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_114251", "114251092", "story_v_out_114251.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_7 = math.max(var_376_0, arg_373_1.talkMaxDuration)

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_7 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - 0) / var_376_7

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= 0 + var_376_7 and arg_373_1.time_ < 0 + var_376_7 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play114251093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 114251093
		arg_377_1.duration_ = 18.2

		local var_377_0 = {
			ja = 16.2,
			ko = 17.633,
			zh = 16.7,
			en = 18.2
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play114251094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 1.999999999999 < arg_377_1.time_ and arg_377_1.time_ <= 1.999999999999 + arg_380_0 then
				local var_380_0 = arg_377_1.bgs_.ST24

				arg_377_1.bgs_.ST24.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_380_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_380_1 = var_380_0:GetComponent("SpriteRenderer")

				if var_380_1 and var_380_1.sprite then
					local var_380_2 = 2 * (var_380_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_380_0.transform.localScale = Vector3.New(var_380_2 / var_380_1.sprite.bounds.size.y < var_380_2 * manager.ui.mainCameraCom_.aspect / var_380_1.sprite.bounds.size.x and var_380_2 * manager.ui.mainCameraCom_.aspect / var_380_1.sprite.bounds.size.x or var_380_2 / var_380_1.sprite.bounds.size.y, var_380_2 / var_380_1.sprite.bounds.size.y < var_380_2 * manager.ui.mainCameraCom_.aspect / var_380_1.sprite.bounds.size.x and var_380_2 * manager.ui.mainCameraCom_.aspect / var_380_1.sprite.bounds.size.x or var_380_2 / var_380_1.sprite.bounds.size.y, 0)
				end

				for iter_380_0, iter_380_1 in pairs(arg_377_1.bgs_) do
					if iter_380_0 ~= "ST24" then
						iter_380_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_380_3 = 0

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_3 + arg_380_0 then
				arg_377_1.mask_.enabled = true
				arg_377_1.mask_.raycastTarget = true

				arg_377_1:SetGaussion(false)
			end

			local var_380_4 = 2

			if var_380_3 <= arg_377_1.time_ and arg_377_1.time_ < var_380_3 + var_380_4 then
				local var_380_5 = Color.New(0, 0, 0)

				var_380_5.a = Mathf.Lerp(0, 1, (arg_377_1.time_ - var_380_3) / var_380_4)
				arg_377_1.mask_.color = var_380_5
			end

			if arg_377_1.time_ >= var_380_3 + var_380_4 and arg_377_1.time_ < var_380_3 + var_380_4 + arg_380_0 then
				local var_380_6 = Color.New(0, 0, 0)

				var_380_6.a = 1
				arg_377_1.mask_.color = var_380_6
			end

			local var_380_7 = 2

			if 2 < arg_377_1.time_ and arg_377_1.time_ <= var_380_7 + arg_380_0 then
				arg_377_1.mask_.enabled = true
				arg_377_1.mask_.raycastTarget = true

				arg_377_1:SetGaussion(false)
			end

			local var_380_8 = 2

			if var_380_7 <= arg_377_1.time_ and arg_377_1.time_ < var_380_7 + var_380_8 then
				local var_380_9 = Color.New(0, 0, 0)

				var_380_9.a = Mathf.Lerp(1, 0, (arg_377_1.time_ - var_380_7) / var_380_8)
				arg_377_1.mask_.color = var_380_9
			end

			if arg_377_1.time_ >= var_380_7 + var_380_8 and arg_377_1.time_ < var_380_7 + var_380_8 + arg_380_0 then
				local var_380_10 = Color.New(0, 0, 0)

				arg_377_1.mask_.enabled = false
				var_380_10.a = 0
				arg_377_1.mask_.color = var_380_10
			end

			local var_380_11 = arg_377_1.actors_["10018"].transform

			if 3.8 < arg_377_1.time_ and arg_377_1.time_ <= 3.8 + arg_380_0 then
				arg_377_1.var_.moveOldPos10018 = var_380_11.localPosition
				var_380_11.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("10018", 2)

				for iter_380_2 = 0, var_380_11.childCount - 1 do
					local var_380_12 = var_380_11:GetChild(iter_380_2)

					if var_380_12.name == "split_1" or not string.find(var_380_12.name, "split") then
						var_380_12.gameObject:SetActive(true)
					else
						var_380_12.gameObject:SetActive(false)
					end
				end
			end

			local var_380_13 = 0.001

			if 3.8 <= arg_377_1.time_ and arg_377_1.time_ < 3.8 + var_380_13 then
				var_380_11.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (arg_377_1.time_ - 3.8) / var_380_13)
			end

			if arg_377_1.time_ >= 3.8 + var_380_13 and arg_377_1.time_ < 3.8 + var_380_13 + arg_380_0 then
				var_380_11.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_380_14 = arg_377_1.actors_["10018"].transform

			if 1.966 < arg_377_1.time_ and arg_377_1.time_ <= 1.966 + arg_380_0 then
				arg_377_1.var_.moveOldPos10018 = var_380_14.localPosition
				var_380_14.localScale = Vector3.New(1, 1, 1)

				arg_377_1:CheckSpriteTmpPos("10018", 7)

				for iter_380_3 = 0, var_380_14.childCount - 1 do
					local var_380_15 = var_380_14:GetChild(iter_380_3)

					if var_380_15.name == "split_1" or not string.find(var_380_15.name, "split") then
						var_380_15.gameObject:SetActive(true)
					else
						var_380_15.gameObject:SetActive(false)
					end
				end
			end

			local var_380_16 = 0.001

			if 1.966 <= arg_377_1.time_ and arg_377_1.time_ < 1.966 + var_380_16 then
				var_380_14.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos10018, Vector3.New(0, -2000, -180), (arg_377_1.time_ - 1.966) / var_380_16)
			end

			if arg_377_1.time_ >= 1.966 + var_380_16 and arg_377_1.time_ < 1.966 + var_380_16 + arg_380_0 then
				var_380_14.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_380_17 = arg_377_1.actors_["10018"]

			if 3.8 < arg_377_1.time_ and arg_377_1.time_ <= 3.8 + arg_380_0 and not isNil(var_380_17) and arg_377_1.var_.actorSpriteComps10018 == nil then
				arg_377_1.var_.actorSpriteComps10018 = var_380_17:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_18 = 0.034

			if 3.8 <= arg_377_1.time_ and arg_377_1.time_ < 3.8 + var_380_18 and not isNil(var_380_17) then
				if arg_377_1.var_.actorSpriteComps10018 then
					for iter_380_4, iter_380_5 in pairs(arg_377_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_380_5 then
							if arg_377_1.isInRecall_ then
								iter_380_5.color = Color.New(Mathf.Lerp(iter_380_5.color.r, arg_377_1.hightColor1.r, (arg_377_1.time_ - 3.8) / var_380_18), Mathf.Lerp(iter_380_5.color.g, arg_377_1.hightColor1.g, (arg_377_1.time_ - 3.8) / var_380_18), (Mathf.Lerp(iter_380_5.color.b, arg_377_1.hightColor1.b, (arg_377_1.time_ - 3.8) / var_380_18)))
							else
								local var_380_19 = Mathf.Lerp(iter_380_5.color.r, 1, (arg_377_1.time_ - 3.8) / var_380_18)

								iter_380_5.color = Color.New(var_380_19, var_380_19, var_380_19)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= 3.8 + var_380_18 and arg_377_1.time_ < 3.8 + var_380_18 + arg_380_0 and not isNil(var_380_17) and arg_377_1.var_.actorSpriteComps10018 then
				for iter_380_6, iter_380_7 in pairs(arg_377_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_380_7 then
						iter_380_7.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_377_1.var_.actorSpriteComps10018 = nil
			end

			if 3.8 < arg_377_1.time_ and arg_377_1.time_ <= 3.8 + arg_380_0 then
				local var_380_20 = arg_377_1.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_380_20 then
					arg_377_1.var_.alphaOldValue10018 = var_380_20.alpha
					arg_377_1.var_.characterEffect10018 = var_380_20
				end

				arg_377_1.var_.alphaOldValue10018 = 0
			end

			local var_380_21 = 0.5

			if 3.8 <= arg_377_1.time_ and arg_377_1.time_ < 3.8 + var_380_21 then
				if arg_377_1.var_.characterEffect10018 then
					arg_377_1.var_.characterEffect10018.alpha = Mathf.Lerp(arg_377_1.var_.alphaOldValue10018, 1, (arg_377_1.time_ - 3.8) / var_380_21)
				end
			end

			if arg_377_1.time_ >= 3.8 + var_380_21 and arg_377_1.time_ < 3.8 + var_380_21 + arg_380_0 and arg_377_1.var_.characterEffect10018 then
				arg_377_1.var_.characterEffect10018.alpha = 1
			end

			if arg_377_1.frameCnt_ <= 1 then
				arg_377_1.dialog_:SetActive(false)
			end

			local var_380_22 = 4
			local var_380_23 = 1.225

			if 4 < arg_377_1.time_ and arg_377_1.time_ <= var_380_22 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0

				arg_377_1.dialog_:SetActive(true)

				arg_377_1.dialogCg_.alpha = 0

				local var_380_24 = LeanTween.value(arg_377_1.dialog_, 0, 1, 0.3)

				var_380_24:setOnUpdate(LuaHelper.FloatAction(function(arg_381_0)
					arg_377_1.dialogCg_.alpha = arg_381_0
				end))
				var_380_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_377_1.dialog_)
					var_380_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_377_1.duration_ = arg_377_1.duration_ + 0.3

				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_25 = arg_377_1:GetWordFromCfg(114251093)
				local var_380_26 = arg_377_1:FormatText(var_380_25.content)

				arg_377_1.text_.text = var_380_26

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_28 = 49 <= 0 and var_380_23 or var_380_23 * (utf8.len(var_380_26) / 49)

				if (49 <= 0 and var_380_23 or var_380_23 * (utf8.len(var_380_26) / 49)) > 0 and var_380_23 < var_380_28 then
					arg_377_1.talkMaxDuration = var_380_28
					var_380_22 = var_380_22 + 0.3

					if var_380_28 + var_380_22 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_28 + var_380_22
					end
				end

				arg_377_1.text_.text = var_380_26
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251093", "story_v_out_114251.awb") ~= 0 then
					local var_380_29 = manager.audio:GetVoiceLength("story_v_out_114251", "114251093", "story_v_out_114251.awb") / 1000

					if var_380_29 + var_380_22 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_29 + var_380_22
					end

					if var_380_25.prefab_name ~= "" and arg_377_1.actors_[var_380_25.prefab_name] ~= nil then
						local var_380_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_25.prefab_name].transform, "story_v_out_114251", "114251093", "story_v_out_114251.awb")

						arg_377_1:RecordAudio("114251093", var_380_30)
						arg_377_1:RecordAudio("114251093", var_380_30)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_114251", "114251093", "story_v_out_114251.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_114251", "114251093", "story_v_out_114251.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_31 = var_380_22 + 0.3
			local var_380_32 = math.max(var_380_23, arg_377_1.talkMaxDuration)

			if var_380_22 + 0.3 <= arg_377_1.time_ and arg_377_1.time_ < var_380_31 + var_380_32 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_31) / var_380_32

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_31 + var_380_32 and arg_377_1.time_ < var_380_31 + var_380_32 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play114251094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 114251094
		arg_383_1.duration_ = 7.67

		local var_383_0 = {
			ja = 7.5,
			ko = 7.366,
			zh = 7.666,
			en = 3.433
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play114251095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos10015 = arg_383_1.actors_["10015"].transform.localPosition
				arg_383_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("10015", 4)

				for iter_386_0 = 0, arg_383_1.actors_["10015"].transform.childCount - 1 do
					local var_386_0 = arg_383_1.actors_["10015"].transform:GetChild(iter_386_0)

					if var_386_0.name == "split_1" or not string.find(var_386_0.name, "split") then
						var_386_0.gameObject:SetActive(true)
					else
						var_386_0.gameObject:SetActive(false)
					end
				end
			end

			local var_386_1 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_1 then
				arg_383_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_383_1.time_ - 0) / var_386_1)
			end

			if arg_383_1.time_ >= 0 + var_386_1 and arg_383_1.time_ < 0 + var_386_1 + arg_386_0 then
				arg_383_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_386_2 = arg_383_1.actors_["10018"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_2) and arg_383_1.var_.actorSpriteComps10018 == nil then
				arg_383_1.var_.actorSpriteComps10018 = var_386_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_3 = 0.034

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_3 and not isNil(var_386_2) then
				if arg_383_1.var_.actorSpriteComps10018 then
					for iter_386_1, iter_386_2 in pairs(arg_383_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_386_2 then
							if arg_383_1.isInRecall_ then
								iter_386_2.color = Color.New(Mathf.Lerp(iter_386_2.color.r, arg_383_1.hightColor2.r, (arg_383_1.time_ - 0) / var_386_3), Mathf.Lerp(iter_386_2.color.g, arg_383_1.hightColor2.g, (arg_383_1.time_ - 0) / var_386_3), (Mathf.Lerp(iter_386_2.color.b, arg_383_1.hightColor2.b, (arg_383_1.time_ - 0) / var_386_3)))
							else
								local var_386_4 = Mathf.Lerp(iter_386_2.color.r, 0.5, (arg_383_1.time_ - 0) / var_386_3)

								iter_386_2.color = Color.New(var_386_4, var_386_4, var_386_4)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= 0 + var_386_3 and arg_383_1.time_ < 0 + var_386_3 + arg_386_0 and not isNil(var_386_2) and arg_383_1.var_.actorSpriteComps10018 then
				for iter_386_3, iter_386_4 in pairs(arg_383_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_386_4 then
						iter_386_4.color = arg_383_1.isInRecall_ and (arg_383_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_383_1.var_.actorSpriteComps10018 = nil
			end

			local var_386_5 = arg_383_1.actors_["10015"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_5) and arg_383_1.var_.actorSpriteComps10015 == nil then
				arg_383_1.var_.actorSpriteComps10015 = var_386_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_6 = 0.034

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_6 and not isNil(var_386_5) then
				if arg_383_1.var_.actorSpriteComps10015 then
					for iter_386_5, iter_386_6 in pairs(arg_383_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_386_6 then
							if arg_383_1.isInRecall_ then
								iter_386_6.color = Color.New(Mathf.Lerp(iter_386_6.color.r, arg_383_1.hightColor1.r, (arg_383_1.time_ - 0) / var_386_6), Mathf.Lerp(iter_386_6.color.g, arg_383_1.hightColor1.g, (arg_383_1.time_ - 0) / var_386_6), (Mathf.Lerp(iter_386_6.color.b, arg_383_1.hightColor1.b, (arg_383_1.time_ - 0) / var_386_6)))
							else
								local var_386_7 = Mathf.Lerp(iter_386_6.color.r, 1, (arg_383_1.time_ - 0) / var_386_6)

								iter_386_6.color = Color.New(var_386_7, var_386_7, var_386_7)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= 0 + var_386_6 and arg_383_1.time_ < 0 + var_386_6 + arg_386_0 and not isNil(var_386_5) and arg_383_1.var_.actorSpriteComps10015 then
				for iter_386_7, iter_386_8 in pairs(arg_383_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_386_8 then
						iter_386_8.color = arg_383_1.isInRecall_ and (arg_383_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_383_1.var_.actorSpriteComps10015 = nil
			end

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				local var_386_8 = arg_383_1.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_386_8 then
					arg_383_1.var_.alphaOldValue10015 = var_386_8.alpha
					arg_383_1.var_.characterEffect10015 = var_386_8
				end

				arg_383_1.var_.alphaOldValue10015 = 0
			end

			local var_386_9 = 0.5

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_9 then
				if arg_383_1.var_.characterEffect10015 then
					arg_383_1.var_.characterEffect10015.alpha = Mathf.Lerp(arg_383_1.var_.alphaOldValue10015, 1, (arg_383_1.time_ - 0) / var_386_9)
				end
			end

			if arg_383_1.time_ >= 0 + var_386_9 and arg_383_1.time_ < 0 + var_386_9 + arg_386_0 and arg_383_1.var_.characterEffect10015 then
				arg_383_1.var_.characterEffect10015.alpha = 1
			end

			local var_386_10 = 0
			local var_386_11 = 0.85

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_10 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_12 = arg_383_1:GetWordFromCfg(114251094)
				local var_386_13 = arg_383_1:FormatText(var_386_12.content)

				arg_383_1.text_.text = var_386_13

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_15 = 34 <= 0 and var_386_11 or var_386_11 * (utf8.len(var_386_13) / 34)

				if (34 <= 0 and var_386_11 or var_386_11 * (utf8.len(var_386_13) / 34)) > 0 and var_386_11 < var_386_15 then
					arg_383_1.talkMaxDuration = var_386_15

					if var_386_15 + var_386_10 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_15 + var_386_10
					end
				end

				arg_383_1.text_.text = var_386_13
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251094", "story_v_out_114251.awb") ~= 0 then
					local var_386_16 = manager.audio:GetVoiceLength("story_v_out_114251", "114251094", "story_v_out_114251.awb") / 1000

					if var_386_16 + var_386_10 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_16 + var_386_10
					end

					if var_386_12.prefab_name ~= "" and arg_383_1.actors_[var_386_12.prefab_name] ~= nil then
						local var_386_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_12.prefab_name].transform, "story_v_out_114251", "114251094", "story_v_out_114251.awb")

						arg_383_1:RecordAudio("114251094", var_386_17)
						arg_383_1:RecordAudio("114251094", var_386_17)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_114251", "114251094", "story_v_out_114251.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_114251", "114251094", "story_v_out_114251.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_18 = math.max(var_386_11, arg_383_1.talkMaxDuration)

			if var_386_10 <= arg_383_1.time_ and arg_383_1.time_ < var_386_10 + var_386_18 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_10) / var_386_18

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_10 + var_386_18 and arg_383_1.time_ < var_386_10 + var_386_18 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
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

		arg_383_1:InitPlayNodeList()
	end,
	Play114251095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 114251095
		arg_387_1.duration_ = 16.67

		local var_387_0 = {
			ja = 16.666,
			ko = 14.133,
			zh = 15.566,
			en = 13.466
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play114251096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(arg_387_1.actors_["10018"]) and arg_387_1.var_.actorSpriteComps10018 == nil then
				arg_387_1.var_.actorSpriteComps10018 = arg_387_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_390_0 = 0.034

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 and not isNil(arg_387_1.actors_["10018"]) then
				if arg_387_1.var_.actorSpriteComps10018 then
					for iter_390_0, iter_390_1 in pairs(arg_387_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_390_1 then
							if arg_387_1.isInRecall_ then
								iter_390_1.color = Color.New(Mathf.Lerp(iter_390_1.color.r, arg_387_1.hightColor1.r, (arg_387_1.time_ - 0) / var_390_0), Mathf.Lerp(iter_390_1.color.g, arg_387_1.hightColor1.g, (arg_387_1.time_ - 0) / var_390_0), (Mathf.Lerp(iter_390_1.color.b, arg_387_1.hightColor1.b, (arg_387_1.time_ - 0) / var_390_0)))
							else
								local var_390_1 = Mathf.Lerp(iter_390_1.color.r, 1, (arg_387_1.time_ - 0) / var_390_0)

								iter_390_1.color = Color.New(var_390_1, var_390_1, var_390_1)
							end
						end
					end
				end
			end

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 and not isNil(arg_387_1.actors_["10018"]) and arg_387_1.var_.actorSpriteComps10018 then
				for iter_390_2, iter_390_3 in pairs(arg_387_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_390_3 then
						iter_390_3.color = arg_387_1.isInRecall_ and (arg_387_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_387_1.var_.actorSpriteComps10018 = nil
			end

			local var_390_2 = arg_387_1.actors_["10015"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_2) and arg_387_1.var_.actorSpriteComps10015 == nil then
				arg_387_1.var_.actorSpriteComps10015 = var_390_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_390_3 = 0.034

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_3 and not isNil(var_390_2) then
				if arg_387_1.var_.actorSpriteComps10015 then
					for iter_390_4, iter_390_5 in pairs(arg_387_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_390_5 then
							if arg_387_1.isInRecall_ then
								iter_390_5.color = Color.New(Mathf.Lerp(iter_390_5.color.r, arg_387_1.hightColor2.r, (arg_387_1.time_ - 0) / var_390_3), Mathf.Lerp(iter_390_5.color.g, arg_387_1.hightColor2.g, (arg_387_1.time_ - 0) / var_390_3), (Mathf.Lerp(iter_390_5.color.b, arg_387_1.hightColor2.b, (arg_387_1.time_ - 0) / var_390_3)))
							else
								local var_390_4 = Mathf.Lerp(iter_390_5.color.r, 0.5, (arg_387_1.time_ - 0) / var_390_3)

								iter_390_5.color = Color.New(var_390_4, var_390_4, var_390_4)
							end
						end
					end
				end
			end

			if arg_387_1.time_ >= 0 + var_390_3 and arg_387_1.time_ < 0 + var_390_3 + arg_390_0 and not isNil(var_390_2) and arg_387_1.var_.actorSpriteComps10015 then
				for iter_390_6, iter_390_7 in pairs(arg_387_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_390_7 then
						iter_390_7.color = arg_387_1.isInRecall_ and (arg_387_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_387_1.var_.actorSpriteComps10015 = nil
			end

			local var_390_5 = 0
			local var_390_6 = 1.775

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_5 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_7 = arg_387_1:GetWordFromCfg(114251095)
				local var_390_8 = arg_387_1:FormatText(var_390_7.content)

				arg_387_1.text_.text = var_390_8

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_10 = 71 <= 0 and var_390_6 or var_390_6 * (utf8.len(var_390_8) / 71)

				if (71 <= 0 and var_390_6 or var_390_6 * (utf8.len(var_390_8) / 71)) > 0 and var_390_6 < var_390_10 then
					arg_387_1.talkMaxDuration = var_390_10

					if var_390_10 + var_390_5 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_10 + var_390_5
					end
				end

				arg_387_1.text_.text = var_390_8
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251095", "story_v_out_114251.awb") ~= 0 then
					local var_390_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251095", "story_v_out_114251.awb") / 1000

					if var_390_11 + var_390_5 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_11 + var_390_5
					end

					if var_390_7.prefab_name ~= "" and arg_387_1.actors_[var_390_7.prefab_name] ~= nil then
						local var_390_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_7.prefab_name].transform, "story_v_out_114251", "114251095", "story_v_out_114251.awb")

						arg_387_1:RecordAudio("114251095", var_390_12)
						arg_387_1:RecordAudio("114251095", var_390_12)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_114251", "114251095", "story_v_out_114251.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_114251", "114251095", "story_v_out_114251.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_13 = math.max(var_390_6, arg_387_1.talkMaxDuration)

			if var_390_5 <= arg_387_1.time_ and arg_387_1.time_ < var_390_5 + var_390_13 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_5) / var_390_13

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_5 + var_390_13 and arg_387_1.time_ < var_390_5 + var_390_13 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play114251096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 114251096
		arg_391_1.duration_ = 12.87

		local var_391_0 = {
			ja = 11.166,
			ko = 12.866,
			zh = 9.233,
			en = 10.133
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play114251097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 1.025

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_1 = arg_391_1:GetWordFromCfg(114251096)
				local var_394_2 = arg_391_1:FormatText(var_394_1.content)

				arg_391_1.text_.text = var_394_2

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_4 = 41 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 41)

				if (41 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 41)) > 0 and var_394_0 < var_394_4 then
					arg_391_1.talkMaxDuration = var_394_4

					if var_394_4 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_4 + 0
					end
				end

				arg_391_1.text_.text = var_394_2
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251096", "story_v_out_114251.awb") ~= 0 then
					local var_394_5 = manager.audio:GetVoiceLength("story_v_out_114251", "114251096", "story_v_out_114251.awb") / 1000

					if var_394_5 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + 0
					end

					if var_394_1.prefab_name ~= "" and arg_391_1.actors_[var_394_1.prefab_name] ~= nil then
						local var_394_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_1.prefab_name].transform, "story_v_out_114251", "114251096", "story_v_out_114251.awb")

						arg_391_1:RecordAudio("114251096", var_394_6)
						arg_391_1:RecordAudio("114251096", var_394_6)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_114251", "114251096", "story_v_out_114251.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_114251", "114251096", "story_v_out_114251.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_7 = math.max(var_394_0, arg_391_1.talkMaxDuration)

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_7 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - 0) / var_394_7

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= 0 + var_394_7 and arg_391_1.time_ < 0 + var_394_7 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {}

		arg_391_1:InitPlayNodeList()
	end,
	Play114251097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 114251097
		arg_395_1.duration_ = 13.5

		local var_395_0 = {
			ja = 13.5,
			ko = 11.966,
			zh = 11.5,
			en = 10.2
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play114251098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 1.275

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_1 = arg_395_1:GetWordFromCfg(114251097)
				local var_398_2 = arg_395_1:FormatText(var_398_1.content)

				arg_395_1.text_.text = var_398_2

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_4 = 51 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_2) / 51)

				if (51 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_2) / 51)) > 0 and var_398_0 < var_398_4 then
					arg_395_1.talkMaxDuration = var_398_4

					if var_398_4 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_4 + 0
					end
				end

				arg_395_1.text_.text = var_398_2
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251097", "story_v_out_114251.awb") ~= 0 then
					local var_398_5 = manager.audio:GetVoiceLength("story_v_out_114251", "114251097", "story_v_out_114251.awb") / 1000

					if var_398_5 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_5 + 0
					end

					if var_398_1.prefab_name ~= "" and arg_395_1.actors_[var_398_1.prefab_name] ~= nil then
						local var_398_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_1.prefab_name].transform, "story_v_out_114251", "114251097", "story_v_out_114251.awb")

						arg_395_1:RecordAudio("114251097", var_398_6)
						arg_395_1:RecordAudio("114251097", var_398_6)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_114251", "114251097", "story_v_out_114251.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_114251", "114251097", "story_v_out_114251.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_7 = math.max(var_398_0, arg_395_1.talkMaxDuration)

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_7 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - 0) / var_398_7

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= 0 + var_398_7 and arg_395_1.time_ < 0 + var_398_7 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {}

		arg_395_1:InitPlayNodeList()
	end,
	Play114251098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 114251098
		arg_399_1.duration_ = 5.4

		local var_399_0 = {
			ja = 5.4,
			ko = 4.433,
			zh = 4.6,
			en = 2.666
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play114251099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["10015"]) and arg_399_1.var_.actorSpriteComps10015 == nil then
				arg_399_1.var_.actorSpriteComps10015 = arg_399_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_0 = 0.034

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["10015"]) then
				if arg_399_1.var_.actorSpriteComps10015 then
					for iter_402_0, iter_402_1 in pairs(arg_399_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_402_1 then
							if arg_399_1.isInRecall_ then
								iter_402_1.color = Color.New(Mathf.Lerp(iter_402_1.color.r, arg_399_1.hightColor1.r, (arg_399_1.time_ - 0) / var_402_0), Mathf.Lerp(iter_402_1.color.g, arg_399_1.hightColor1.g, (arg_399_1.time_ - 0) / var_402_0), (Mathf.Lerp(iter_402_1.color.b, arg_399_1.hightColor1.b, (arg_399_1.time_ - 0) / var_402_0)))
							else
								local var_402_1 = Mathf.Lerp(iter_402_1.color.r, 1, (arg_399_1.time_ - 0) / var_402_0)

								iter_402_1.color = Color.New(var_402_1, var_402_1, var_402_1)
							end
						end
					end
				end
			end

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["10015"]) and arg_399_1.var_.actorSpriteComps10015 then
				for iter_402_2, iter_402_3 in pairs(arg_399_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_402_3 then
						iter_402_3.color = arg_399_1.isInRecall_ and (arg_399_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_399_1.var_.actorSpriteComps10015 = nil
			end

			local var_402_2 = arg_399_1.actors_["10018"]

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(var_402_2) and arg_399_1.var_.actorSpriteComps10018 == nil then
				arg_399_1.var_.actorSpriteComps10018 = var_402_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_3 = 0.034

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_3 and not isNil(var_402_2) then
				if arg_399_1.var_.actorSpriteComps10018 then
					for iter_402_4, iter_402_5 in pairs(arg_399_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_402_5 then
							if arg_399_1.isInRecall_ then
								iter_402_5.color = Color.New(Mathf.Lerp(iter_402_5.color.r, arg_399_1.hightColor2.r, (arg_399_1.time_ - 0) / var_402_3), Mathf.Lerp(iter_402_5.color.g, arg_399_1.hightColor2.g, (arg_399_1.time_ - 0) / var_402_3), (Mathf.Lerp(iter_402_5.color.b, arg_399_1.hightColor2.b, (arg_399_1.time_ - 0) / var_402_3)))
							else
								local var_402_4 = Mathf.Lerp(iter_402_5.color.r, 0.5, (arg_399_1.time_ - 0) / var_402_3)

								iter_402_5.color = Color.New(var_402_4, var_402_4, var_402_4)
							end
						end
					end
				end
			end

			if arg_399_1.time_ >= 0 + var_402_3 and arg_399_1.time_ < 0 + var_402_3 + arg_402_0 and not isNil(var_402_2) and arg_399_1.var_.actorSpriteComps10018 then
				for iter_402_6, iter_402_7 in pairs(arg_399_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_402_7 then
						iter_402_7.color = arg_399_1.isInRecall_ and (arg_399_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_399_1.var_.actorSpriteComps10018 = nil
			end

			local var_402_5 = 0
			local var_402_6 = 0.45

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_5 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_7 = arg_399_1:GetWordFromCfg(114251098)
				local var_402_8 = arg_399_1:FormatText(var_402_7.content)

				arg_399_1.text_.text = var_402_8

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_10 = 18 <= 0 and var_402_6 or var_402_6 * (utf8.len(var_402_8) / 18)

				if (18 <= 0 and var_402_6 or var_402_6 * (utf8.len(var_402_8) / 18)) > 0 and var_402_6 < var_402_10 then
					arg_399_1.talkMaxDuration = var_402_10

					if var_402_10 + var_402_5 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_10 + var_402_5
					end
				end

				arg_399_1.text_.text = var_402_8
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251098", "story_v_out_114251.awb") ~= 0 then
					local var_402_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251098", "story_v_out_114251.awb") / 1000

					if var_402_11 + var_402_5 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_11 + var_402_5
					end

					if var_402_7.prefab_name ~= "" and arg_399_1.actors_[var_402_7.prefab_name] ~= nil then
						local var_402_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_7.prefab_name].transform, "story_v_out_114251", "114251098", "story_v_out_114251.awb")

						arg_399_1:RecordAudio("114251098", var_402_12)
						arg_399_1:RecordAudio("114251098", var_402_12)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_114251", "114251098", "story_v_out_114251.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_114251", "114251098", "story_v_out_114251.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_13 = math.max(var_402_6, arg_399_1.talkMaxDuration)

			if var_402_5 <= arg_399_1.time_ and arg_399_1.time_ < var_402_5 + var_402_13 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_5) / var_402_13

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_5 + var_402_13 and arg_399_1.time_ < var_402_5 + var_402_13 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {}

		arg_399_1:InitPlayNodeList()
	end,
	Play114251099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 114251099
		arg_403_1.duration_ = 13.5

		local var_403_0 = {
			ja = 13.5,
			ko = 13.233,
			zh = 11.433,
			en = 13.233
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
				arg_403_0:Play114251100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["10018"]) and arg_403_1.var_.actorSpriteComps10018 == nil then
				arg_403_1.var_.actorSpriteComps10018 = arg_403_1.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_0 = 0.034

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["10018"]) then
				if arg_403_1.var_.actorSpriteComps10018 then
					for iter_406_0, iter_406_1 in pairs(arg_403_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_406_1 then
							if arg_403_1.isInRecall_ then
								iter_406_1.color = Color.New(Mathf.Lerp(iter_406_1.color.r, arg_403_1.hightColor1.r, (arg_403_1.time_ - 0) / var_406_0), Mathf.Lerp(iter_406_1.color.g, arg_403_1.hightColor1.g, (arg_403_1.time_ - 0) / var_406_0), (Mathf.Lerp(iter_406_1.color.b, arg_403_1.hightColor1.b, (arg_403_1.time_ - 0) / var_406_0)))
							else
								local var_406_1 = Mathf.Lerp(iter_406_1.color.r, 1, (arg_403_1.time_ - 0) / var_406_0)

								iter_406_1.color = Color.New(var_406_1, var_406_1, var_406_1)
							end
						end
					end
				end
			end

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["10018"]) and arg_403_1.var_.actorSpriteComps10018 then
				for iter_406_2, iter_406_3 in pairs(arg_403_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_406_3 then
						iter_406_3.color = arg_403_1.isInRecall_ and (arg_403_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_403_1.var_.actorSpriteComps10018 = nil
			end

			local var_406_2 = arg_403_1.actors_["10015"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_2) and arg_403_1.var_.actorSpriteComps10015 == nil then
				arg_403_1.var_.actorSpriteComps10015 = var_406_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_3 = 0.034

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_3 and not isNil(var_406_2) then
				if arg_403_1.var_.actorSpriteComps10015 then
					for iter_406_4, iter_406_5 in pairs(arg_403_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_406_5 then
							if arg_403_1.isInRecall_ then
								iter_406_5.color = Color.New(Mathf.Lerp(iter_406_5.color.r, arg_403_1.hightColor2.r, (arg_403_1.time_ - 0) / var_406_3), Mathf.Lerp(iter_406_5.color.g, arg_403_1.hightColor2.g, (arg_403_1.time_ - 0) / var_406_3), (Mathf.Lerp(iter_406_5.color.b, arg_403_1.hightColor2.b, (arg_403_1.time_ - 0) / var_406_3)))
							else
								local var_406_4 = Mathf.Lerp(iter_406_5.color.r, 0.5, (arg_403_1.time_ - 0) / var_406_3)

								iter_406_5.color = Color.New(var_406_4, var_406_4, var_406_4)
							end
						end
					end
				end
			end

			if arg_403_1.time_ >= 0 + var_406_3 and arg_403_1.time_ < 0 + var_406_3 + arg_406_0 and not isNil(var_406_2) and arg_403_1.var_.actorSpriteComps10015 then
				for iter_406_6, iter_406_7 in pairs(arg_403_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_406_7 then
						iter_406_7.color = arg_403_1.isInRecall_ and (arg_403_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_403_1.var_.actorSpriteComps10015 = nil
			end

			local var_406_5 = 0
			local var_406_6 = 1.075

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_5 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_7 = arg_403_1:GetWordFromCfg(114251099)
				local var_406_8 = arg_403_1:FormatText(var_406_7.content)

				arg_403_1.text_.text = var_406_8

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_10 = 43 <= 0 and var_406_6 or var_406_6 * (utf8.len(var_406_8) / 43)

				if (43 <= 0 and var_406_6 or var_406_6 * (utf8.len(var_406_8) / 43)) > 0 and var_406_6 < var_406_10 then
					arg_403_1.talkMaxDuration = var_406_10

					if var_406_10 + var_406_5 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_10 + var_406_5
					end
				end

				arg_403_1.text_.text = var_406_8
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251099", "story_v_out_114251.awb") ~= 0 then
					local var_406_11 = manager.audio:GetVoiceLength("story_v_out_114251", "114251099", "story_v_out_114251.awb") / 1000

					if var_406_11 + var_406_5 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_11 + var_406_5
					end

					if var_406_7.prefab_name ~= "" and arg_403_1.actors_[var_406_7.prefab_name] ~= nil then
						local var_406_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_7.prefab_name].transform, "story_v_out_114251", "114251099", "story_v_out_114251.awb")

						arg_403_1:RecordAudio("114251099", var_406_12)
						arg_403_1:RecordAudio("114251099", var_406_12)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_114251", "114251099", "story_v_out_114251.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_114251", "114251099", "story_v_out_114251.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_13 = math.max(var_406_6, arg_403_1.talkMaxDuration)

			if var_406_5 <= arg_403_1.time_ and arg_403_1.time_ < var_406_5 + var_406_13 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_5) / var_406_13

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_5 + var_406_13 and arg_403_1.time_ < var_406_5 + var_406_13 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play114251100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 114251100
		arg_407_1.duration_ = 9.17

		local var_407_0 = {
			ja = 9.166,
			ko = 7.433,
			zh = 8.4,
			en = 6.133
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play114251101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos10015 = arg_407_1.actors_["10015"].transform.localPosition
				arg_407_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_407_1:CheckSpriteTmpPos("10015", 4)

				for iter_410_0 = 0, arg_407_1.actors_["10015"].transform.childCount - 1 do
					local var_410_0 = arg_407_1.actors_["10015"].transform:GetChild(iter_410_0)

					if var_410_0.name == "split_4" or not string.find(var_410_0.name, "split") then
						var_410_0.gameObject:SetActive(true)
					else
						var_410_0.gameObject:SetActive(false)
					end
				end
			end

			local var_410_1 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_1 then
				arg_407_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_407_1.time_ - 0) / var_410_1)
			end

			if arg_407_1.time_ >= 0 + var_410_1 and arg_407_1.time_ < 0 + var_410_1 + arg_410_0 then
				arg_407_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_410_2 = arg_407_1.actors_["10015"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_2) and arg_407_1.var_.actorSpriteComps10015 == nil then
				arg_407_1.var_.actorSpriteComps10015 = var_410_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_410_3 = 0.034

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_3 and not isNil(var_410_2) then
				if arg_407_1.var_.actorSpriteComps10015 then
					for iter_410_1, iter_410_2 in pairs(arg_407_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_410_2 then
							if arg_407_1.isInRecall_ then
								iter_410_2.color = Color.New(Mathf.Lerp(iter_410_2.color.r, arg_407_1.hightColor1.r, (arg_407_1.time_ - 0) / var_410_3), Mathf.Lerp(iter_410_2.color.g, arg_407_1.hightColor1.g, (arg_407_1.time_ - 0) / var_410_3), (Mathf.Lerp(iter_410_2.color.b, arg_407_1.hightColor1.b, (arg_407_1.time_ - 0) / var_410_3)))
							else
								local var_410_4 = Mathf.Lerp(iter_410_2.color.r, 1, (arg_407_1.time_ - 0) / var_410_3)

								iter_410_2.color = Color.New(var_410_4, var_410_4, var_410_4)
							end
						end
					end
				end
			end

			if arg_407_1.time_ >= 0 + var_410_3 and arg_407_1.time_ < 0 + var_410_3 + arg_410_0 and not isNil(var_410_2) and arg_407_1.var_.actorSpriteComps10015 then
				for iter_410_3, iter_410_4 in pairs(arg_407_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_410_4 then
						iter_410_4.color = arg_407_1.isInRecall_ and (arg_407_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_407_1.var_.actorSpriteComps10015 = nil
			end

			local var_410_5 = arg_407_1.actors_["10018"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_5) and arg_407_1.var_.actorSpriteComps10018 == nil then
				arg_407_1.var_.actorSpriteComps10018 = var_410_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_410_6 = 0.034

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_6 and not isNil(var_410_5) then
				if arg_407_1.var_.actorSpriteComps10018 then
					for iter_410_5, iter_410_6 in pairs(arg_407_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_410_6 then
							if arg_407_1.isInRecall_ then
								iter_410_6.color = Color.New(Mathf.Lerp(iter_410_6.color.r, arg_407_1.hightColor2.r, (arg_407_1.time_ - 0) / var_410_6), Mathf.Lerp(iter_410_6.color.g, arg_407_1.hightColor2.g, (arg_407_1.time_ - 0) / var_410_6), (Mathf.Lerp(iter_410_6.color.b, arg_407_1.hightColor2.b, (arg_407_1.time_ - 0) / var_410_6)))
							else
								local var_410_7 = Mathf.Lerp(iter_410_6.color.r, 0.5, (arg_407_1.time_ - 0) / var_410_6)

								iter_410_6.color = Color.New(var_410_7, var_410_7, var_410_7)
							end
						end
					end
				end
			end

			if arg_407_1.time_ >= 0 + var_410_6 and arg_407_1.time_ < 0 + var_410_6 + arg_410_0 and not isNil(var_410_5) and arg_407_1.var_.actorSpriteComps10018 then
				for iter_410_7, iter_410_8 in pairs(arg_407_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_410_8 then
						iter_410_8.color = arg_407_1.isInRecall_ and (arg_407_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_407_1.var_.actorSpriteComps10018 = nil
			end

			local var_410_8 = 0
			local var_410_9 = 0.875

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_8 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_10 = arg_407_1:GetWordFromCfg(114251100)
				local var_410_11 = arg_407_1:FormatText(var_410_10.content)

				arg_407_1.text_.text = var_410_11

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_13 = 35 <= 0 and var_410_9 or var_410_9 * (utf8.len(var_410_11) / 35)

				if (35 <= 0 and var_410_9 or var_410_9 * (utf8.len(var_410_11) / 35)) > 0 and var_410_9 < var_410_13 then
					arg_407_1.talkMaxDuration = var_410_13

					if var_410_13 + var_410_8 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_13 + var_410_8
					end
				end

				arg_407_1.text_.text = var_410_11
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251100", "story_v_out_114251.awb") ~= 0 then
					local var_410_14 = manager.audio:GetVoiceLength("story_v_out_114251", "114251100", "story_v_out_114251.awb") / 1000

					if var_410_14 + var_410_8 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_14 + var_410_8
					end

					if var_410_10.prefab_name ~= "" and arg_407_1.actors_[var_410_10.prefab_name] ~= nil then
						local var_410_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_10.prefab_name].transform, "story_v_out_114251", "114251100", "story_v_out_114251.awb")

						arg_407_1:RecordAudio("114251100", var_410_15)
						arg_407_1:RecordAudio("114251100", var_410_15)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_114251", "114251100", "story_v_out_114251.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_114251", "114251100", "story_v_out_114251.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_16 = math.max(var_410_9, arg_407_1.talkMaxDuration)

			if var_410_8 <= arg_407_1.time_ and arg_407_1.time_ < var_410_8 + var_410_16 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_8) / var_410_16

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_8 + var_410_16 and arg_407_1.time_ < var_410_8 + var_410_16 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
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

		arg_407_1:InitPlayNodeList()
	end,
	Play114251101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 114251101
		arg_411_1.duration_ = 8.9

		local var_411_0 = {
			ja = 7.6,
			ko = 8.9,
			zh = 7.033,
			en = 7.8
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play114251102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos10018 = arg_411_1.actors_["10018"].transform.localPosition
				arg_411_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_411_1:CheckSpriteTmpPos("10018", 2)

				for iter_414_0 = 0, arg_411_1.actors_["10018"].transform.childCount - 1 do
					local var_414_0 = arg_411_1.actors_["10018"].transform:GetChild(iter_414_0)

					if var_414_0.name == "split_2" or not string.find(var_414_0.name, "split") then
						var_414_0.gameObject:SetActive(true)
					else
						var_414_0.gameObject:SetActive(false)
					end
				end
			end

			local var_414_1 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_1 then
				arg_411_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (arg_411_1.time_ - 0) / var_414_1)
			end

			if arg_411_1.time_ >= 0 + var_414_1 and arg_411_1.time_ < 0 + var_414_1 + arg_414_0 then
				arg_411_1.actors_["10018"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_414_2 = arg_411_1.actors_["10015"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_2) and arg_411_1.var_.actorSpriteComps10015 == nil then
				arg_411_1.var_.actorSpriteComps10015 = var_414_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_3 = 0.034

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_3 and not isNil(var_414_2) then
				if arg_411_1.var_.actorSpriteComps10015 then
					for iter_414_1, iter_414_2 in pairs(arg_411_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_414_2 then
							if arg_411_1.isInRecall_ then
								iter_414_2.color = Color.New(Mathf.Lerp(iter_414_2.color.r, arg_411_1.hightColor2.r, (arg_411_1.time_ - 0) / var_414_3), Mathf.Lerp(iter_414_2.color.g, arg_411_1.hightColor2.g, (arg_411_1.time_ - 0) / var_414_3), (Mathf.Lerp(iter_414_2.color.b, arg_411_1.hightColor2.b, (arg_411_1.time_ - 0) / var_414_3)))
							else
								local var_414_4 = Mathf.Lerp(iter_414_2.color.r, 0.5, (arg_411_1.time_ - 0) / var_414_3)

								iter_414_2.color = Color.New(var_414_4, var_414_4, var_414_4)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= 0 + var_414_3 and arg_411_1.time_ < 0 + var_414_3 + arg_414_0 and not isNil(var_414_2) and arg_411_1.var_.actorSpriteComps10015 then
				for iter_414_3, iter_414_4 in pairs(arg_411_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_414_4 then
						iter_414_4.color = arg_411_1.isInRecall_ and (arg_411_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_411_1.var_.actorSpriteComps10015 = nil
			end

			local var_414_5 = arg_411_1.actors_["10018"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_5) and arg_411_1.var_.actorSpriteComps10018 == nil then
				arg_411_1.var_.actorSpriteComps10018 = var_414_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_6 = 0.034

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_6 and not isNil(var_414_5) then
				if arg_411_1.var_.actorSpriteComps10018 then
					for iter_414_5, iter_414_6 in pairs(arg_411_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_414_6 then
							if arg_411_1.isInRecall_ then
								iter_414_6.color = Color.New(Mathf.Lerp(iter_414_6.color.r, arg_411_1.hightColor1.r, (arg_411_1.time_ - 0) / var_414_6), Mathf.Lerp(iter_414_6.color.g, arg_411_1.hightColor1.g, (arg_411_1.time_ - 0) / var_414_6), (Mathf.Lerp(iter_414_6.color.b, arg_411_1.hightColor1.b, (arg_411_1.time_ - 0) / var_414_6)))
							else
								local var_414_7 = Mathf.Lerp(iter_414_6.color.r, 1, (arg_411_1.time_ - 0) / var_414_6)

								iter_414_6.color = Color.New(var_414_7, var_414_7, var_414_7)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= 0 + var_414_6 and arg_411_1.time_ < 0 + var_414_6 + arg_414_0 and not isNil(var_414_5) and arg_411_1.var_.actorSpriteComps10018 then
				for iter_414_7, iter_414_8 in pairs(arg_411_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_414_8 then
						iter_414_8.color = arg_411_1.isInRecall_ and (arg_411_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_411_1.var_.actorSpriteComps10018 = nil
			end

			local var_414_8 = 0
			local var_414_9 = 0.6

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_8 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_10 = arg_411_1:GetWordFromCfg(114251101)
				local var_414_11 = arg_411_1:FormatText(var_414_10.content)

				arg_411_1.text_.text = var_414_11

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_13 = 24 <= 0 and var_414_9 or var_414_9 * (utf8.len(var_414_11) / 24)

				if (24 <= 0 and var_414_9 or var_414_9 * (utf8.len(var_414_11) / 24)) > 0 and var_414_9 < var_414_13 then
					arg_411_1.talkMaxDuration = var_414_13

					if var_414_13 + var_414_8 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_13 + var_414_8
					end
				end

				arg_411_1.text_.text = var_414_11
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251101", "story_v_out_114251.awb") ~= 0 then
					local var_414_14 = manager.audio:GetVoiceLength("story_v_out_114251", "114251101", "story_v_out_114251.awb") / 1000

					if var_414_14 + var_414_8 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_14 + var_414_8
					end

					if var_414_10.prefab_name ~= "" and arg_411_1.actors_[var_414_10.prefab_name] ~= nil then
						local var_414_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_10.prefab_name].transform, "story_v_out_114251", "114251101", "story_v_out_114251.awb")

						arg_411_1:RecordAudio("114251101", var_414_15)
						arg_411_1:RecordAudio("114251101", var_414_15)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_114251", "114251101", "story_v_out_114251.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_114251", "114251101", "story_v_out_114251.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_16 = math.max(var_414_9, arg_411_1.talkMaxDuration)

			if var_414_8 <= arg_411_1.time_ and arg_411_1.time_ < var_414_8 + var_414_16 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_8) / var_414_16

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_8 + var_414_16 and arg_411_1.time_ < var_414_8 + var_414_16 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_411_1:InitPlayNodeList()
	end,
	Play114251102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 114251102
		arg_415_1.duration_ = 2.3

		local var_415_0 = {
			ja = 2.3,
			ko = 2.133,
			zh = 1.2,
			en = 0.999999999999
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
				arg_415_0:Play114251103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.var_.moveOldPos10015 = arg_415_1.actors_["10015"].transform.localPosition
				arg_415_1.actors_["10015"].transform.localScale = Vector3.New(1, 1, 1)

				arg_415_1:CheckSpriteTmpPos("10015", 4)

				for iter_418_0 = 0, arg_415_1.actors_["10015"].transform.childCount - 1 do
					local var_418_0 = arg_415_1.actors_["10015"].transform:GetChild(iter_418_0)

					if var_418_0.name == "split_1" or not string.find(var_418_0.name, "split") then
						var_418_0.gameObject:SetActive(true)
					else
						var_418_0.gameObject:SetActive(false)
					end
				end
			end

			local var_418_1 = 0.001

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_1 then
				arg_415_1.actors_["10015"].transform.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos10015, Vector3.New(390, -350, -180), (arg_415_1.time_ - 0) / var_418_1)
			end

			if arg_415_1.time_ >= 0 + var_418_1 and arg_415_1.time_ < 0 + var_418_1 + arg_418_0 then
				arg_415_1.actors_["10015"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_418_2 = arg_415_1.actors_["10015"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(var_418_2) and arg_415_1.var_.actorSpriteComps10015 == nil then
				arg_415_1.var_.actorSpriteComps10015 = var_418_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_3 = 0.034

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_3 and not isNil(var_418_2) then
				if arg_415_1.var_.actorSpriteComps10015 then
					for iter_418_1, iter_418_2 in pairs(arg_415_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_418_2 then
							if arg_415_1.isInRecall_ then
								iter_418_2.color = Color.New(Mathf.Lerp(iter_418_2.color.r, arg_415_1.hightColor1.r, (arg_415_1.time_ - 0) / var_418_3), Mathf.Lerp(iter_418_2.color.g, arg_415_1.hightColor1.g, (arg_415_1.time_ - 0) / var_418_3), (Mathf.Lerp(iter_418_2.color.b, arg_415_1.hightColor1.b, (arg_415_1.time_ - 0) / var_418_3)))
							else
								local var_418_4 = Mathf.Lerp(iter_418_2.color.r, 1, (arg_415_1.time_ - 0) / var_418_3)

								iter_418_2.color = Color.New(var_418_4, var_418_4, var_418_4)
							end
						end
					end
				end
			end

			if arg_415_1.time_ >= 0 + var_418_3 and arg_415_1.time_ < 0 + var_418_3 + arg_418_0 and not isNil(var_418_2) and arg_415_1.var_.actorSpriteComps10015 then
				for iter_418_3, iter_418_4 in pairs(arg_415_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_418_4 then
						iter_418_4.color = arg_415_1.isInRecall_ and (arg_415_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_415_1.var_.actorSpriteComps10015 = nil
			end

			local var_418_5 = arg_415_1.actors_["10018"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(var_418_5) and arg_415_1.var_.actorSpriteComps10018 == nil then
				arg_415_1.var_.actorSpriteComps10018 = var_418_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_6 = 0.034

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_6 and not isNil(var_418_5) then
				if arg_415_1.var_.actorSpriteComps10018 then
					for iter_418_5, iter_418_6 in pairs(arg_415_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_418_6 then
							if arg_415_1.isInRecall_ then
								iter_418_6.color = Color.New(Mathf.Lerp(iter_418_6.color.r, arg_415_1.hightColor2.r, (arg_415_1.time_ - 0) / var_418_6), Mathf.Lerp(iter_418_6.color.g, arg_415_1.hightColor2.g, (arg_415_1.time_ - 0) / var_418_6), (Mathf.Lerp(iter_418_6.color.b, arg_415_1.hightColor2.b, (arg_415_1.time_ - 0) / var_418_6)))
							else
								local var_418_7 = Mathf.Lerp(iter_418_6.color.r, 0.5, (arg_415_1.time_ - 0) / var_418_6)

								iter_418_6.color = Color.New(var_418_7, var_418_7, var_418_7)
							end
						end
					end
				end
			end

			if arg_415_1.time_ >= 0 + var_418_6 and arg_415_1.time_ < 0 + var_418_6 + arg_418_0 and not isNil(var_418_5) and arg_415_1.var_.actorSpriteComps10018 then
				for iter_418_7, iter_418_8 in pairs(arg_415_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_418_8 then
						iter_418_8.color = arg_415_1.isInRecall_ and (arg_415_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_415_1.var_.actorSpriteComps10018 = nil
			end

			local var_418_8 = 0
			local var_418_9 = 0.1

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_8 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_10 = arg_415_1:GetWordFromCfg(114251102)
				local var_418_11 = arg_415_1:FormatText(var_418_10.content)

				arg_415_1.text_.text = var_418_11

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_13 = 4 <= 0 and var_418_9 or var_418_9 * (utf8.len(var_418_11) / 4)

				if (4 <= 0 and var_418_9 or var_418_9 * (utf8.len(var_418_11) / 4)) > 0 and var_418_9 < var_418_13 then
					arg_415_1.talkMaxDuration = var_418_13

					if var_418_13 + var_418_8 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_13 + var_418_8
					end
				end

				arg_415_1.text_.text = var_418_11
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251102", "story_v_out_114251.awb") ~= 0 then
					local var_418_14 = manager.audio:GetVoiceLength("story_v_out_114251", "114251102", "story_v_out_114251.awb") / 1000

					if var_418_14 + var_418_8 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_14 + var_418_8
					end

					if var_418_10.prefab_name ~= "" and arg_415_1.actors_[var_418_10.prefab_name] ~= nil then
						local var_418_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_10.prefab_name].transform, "story_v_out_114251", "114251102", "story_v_out_114251.awb")

						arg_415_1:RecordAudio("114251102", var_418_15)
						arg_415_1:RecordAudio("114251102", var_418_15)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_114251", "114251102", "story_v_out_114251.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_114251", "114251102", "story_v_out_114251.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_16 = math.max(var_418_9, arg_415_1.talkMaxDuration)

			if var_418_8 <= arg_415_1.time_ and arg_415_1.time_ < var_418_8 + var_418_16 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_8) / var_418_16

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_8 + var_418_16 and arg_415_1.time_ < var_418_8 + var_418_16 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
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

		arg_415_1:InitPlayNodeList()
	end,
	Play114251103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 114251103
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play114251104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(arg_419_1.actors_["10015"]) and arg_419_1.var_.actorSpriteComps10015 == nil then
				arg_419_1.var_.actorSpriteComps10015 = arg_419_1.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_422_0 = 0.034

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 and not isNil(arg_419_1.actors_["10015"]) then
				if arg_419_1.var_.actorSpriteComps10015 then
					for iter_422_0, iter_422_1 in pairs(arg_419_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_422_1 then
							if arg_419_1.isInRecall_ then
								iter_422_1.color = Color.New(Mathf.Lerp(iter_422_1.color.r, arg_419_1.hightColor2.r, (arg_419_1.time_ - 0) / var_422_0), Mathf.Lerp(iter_422_1.color.g, arg_419_1.hightColor2.g, (arg_419_1.time_ - 0) / var_422_0), (Mathf.Lerp(iter_422_1.color.b, arg_419_1.hightColor2.b, (arg_419_1.time_ - 0) / var_422_0)))
							else
								local var_422_1 = Mathf.Lerp(iter_422_1.color.r, 0.5, (arg_419_1.time_ - 0) / var_422_0)

								iter_422_1.color = Color.New(var_422_1, var_422_1, var_422_1)
							end
						end
					end
				end
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 and not isNil(arg_419_1.actors_["10015"]) and arg_419_1.var_.actorSpriteComps10015 then
				for iter_422_2, iter_422_3 in pairs(arg_419_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_422_3 then
						iter_422_3.color = arg_419_1.isInRecall_ and (arg_419_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_419_1.var_.actorSpriteComps10015 = nil
			end

			local var_422_2 = 0
			local var_422_3 = 0.525

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_2 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_4 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(114251103).content)

				arg_419_1.text_.text = var_422_4

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_6 = 21 <= 0 and var_422_3 or var_422_3 * (utf8.len(var_422_4) / 21)

				if (21 <= 0 and var_422_3 or var_422_3 * (utf8.len(var_422_4) / 21)) > 0 and var_422_3 < var_422_6 then
					arg_419_1.talkMaxDuration = var_422_6

					if var_422_6 + var_422_2 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_6 + var_422_2
					end
				end

				arg_419_1.text_.text = var_422_4
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_7 = math.max(var_422_3, arg_419_1.talkMaxDuration)

			if var_422_2 <= arg_419_1.time_ and arg_419_1.time_ < var_422_2 + var_422_7 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_2) / var_422_7

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_2 + var_422_7 and arg_419_1.time_ < var_422_2 + var_422_7 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play114251104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 114251104
		arg_423_1.duration_ = 14.9

		local var_423_0 = {
			ja = 7.6,
			ko = 14.9,
			zh = 14.8,
			en = 12.4
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
			arg_423_1.auto_ = false
		end

		function arg_423_1.playNext_(arg_425_0)
			arg_423_1.onStoryFinished_()
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos10018 = arg_423_1.actors_["10018"].transform.localPosition
				arg_423_1.actors_["10018"].transform.localScale = Vector3.New(1, 1, 1)

				arg_423_1:CheckSpriteTmpPos("10018", 2)

				for iter_426_0 = 0, arg_423_1.actors_["10018"].transform.childCount - 1 do
					local var_426_0 = arg_423_1.actors_["10018"].transform:GetChild(iter_426_0)

					if var_426_0.name == "split_2" or not string.find(var_426_0.name, "split") then
						var_426_0.gameObject:SetActive(true)
					else
						var_426_0.gameObject:SetActive(false)
					end
				end
			end

			local var_426_1 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_1 then
				arg_423_1.actors_["10018"].transform.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (arg_423_1.time_ - 0) / var_426_1)
			end

			if arg_423_1.time_ >= 0 + var_426_1 and arg_423_1.time_ < 0 + var_426_1 + arg_426_0 then
				arg_423_1.actors_["10018"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_426_2 = arg_423_1.actors_["10018"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_2) and arg_423_1.var_.actorSpriteComps10018 == nil then
				arg_423_1.var_.actorSpriteComps10018 = var_426_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_426_3 = 0.034

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_3 and not isNil(var_426_2) then
				if arg_423_1.var_.actorSpriteComps10018 then
					for iter_426_1, iter_426_2 in pairs(arg_423_1.var_.actorSpriteComps10018:ToTable()) do
						if iter_426_2 then
							if arg_423_1.isInRecall_ then
								iter_426_2.color = Color.New(Mathf.Lerp(iter_426_2.color.r, arg_423_1.hightColor1.r, (arg_423_1.time_ - 0) / var_426_3), Mathf.Lerp(iter_426_2.color.g, arg_423_1.hightColor1.g, (arg_423_1.time_ - 0) / var_426_3), (Mathf.Lerp(iter_426_2.color.b, arg_423_1.hightColor1.b, (arg_423_1.time_ - 0) / var_426_3)))
							else
								local var_426_4 = Mathf.Lerp(iter_426_2.color.r, 1, (arg_423_1.time_ - 0) / var_426_3)

								iter_426_2.color = Color.New(var_426_4, var_426_4, var_426_4)
							end
						end
					end
				end
			end

			if arg_423_1.time_ >= 0 + var_426_3 and arg_423_1.time_ < 0 + var_426_3 + arg_426_0 and not isNil(var_426_2) and arg_423_1.var_.actorSpriteComps10018 then
				for iter_426_3, iter_426_4 in pairs(arg_423_1.var_.actorSpriteComps10018:ToTable()) do
					if iter_426_4 then
						iter_426_4.color = arg_423_1.isInRecall_ and (arg_423_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_423_1.var_.actorSpriteComps10018 = nil
			end

			local var_426_5 = arg_423_1.actors_["10015"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_5) and arg_423_1.var_.actorSpriteComps10015 == nil then
				arg_423_1.var_.actorSpriteComps10015 = var_426_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_426_6 = 0.034

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_6 and not isNil(var_426_5) then
				if arg_423_1.var_.actorSpriteComps10015 then
					for iter_426_5, iter_426_6 in pairs(arg_423_1.var_.actorSpriteComps10015:ToTable()) do
						if iter_426_6 then
							if arg_423_1.isInRecall_ then
								iter_426_6.color = Color.New(Mathf.Lerp(iter_426_6.color.r, arg_423_1.hightColor2.r, (arg_423_1.time_ - 0) / var_426_6), Mathf.Lerp(iter_426_6.color.g, arg_423_1.hightColor2.g, (arg_423_1.time_ - 0) / var_426_6), (Mathf.Lerp(iter_426_6.color.b, arg_423_1.hightColor2.b, (arg_423_1.time_ - 0) / var_426_6)))
							else
								local var_426_7 = Mathf.Lerp(iter_426_6.color.r, 0.5, (arg_423_1.time_ - 0) / var_426_6)

								iter_426_6.color = Color.New(var_426_7, var_426_7, var_426_7)
							end
						end
					end
				end
			end

			if arg_423_1.time_ >= 0 + var_426_6 and arg_423_1.time_ < 0 + var_426_6 + arg_426_0 and not isNil(var_426_5) and arg_423_1.var_.actorSpriteComps10015 then
				for iter_426_7, iter_426_8 in pairs(arg_423_1.var_.actorSpriteComps10015:ToTable()) do
					if iter_426_8 then
						iter_426_8.color = arg_423_1.isInRecall_ and (arg_423_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_423_1.var_.actorSpriteComps10015 = nil
			end

			local var_426_8 = 0
			local var_426_9 = 1.1

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_8 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_10 = arg_423_1:GetWordFromCfg(114251104)
				local var_426_11 = arg_423_1:FormatText(var_426_10.content)

				arg_423_1.text_.text = var_426_11

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_13 = 43 <= 0 and var_426_9 or var_426_9 * (utf8.len(var_426_11) / 43)

				if (43 <= 0 and var_426_9 or var_426_9 * (utf8.len(var_426_11) / 43)) > 0 and var_426_9 < var_426_13 then
					arg_423_1.talkMaxDuration = var_426_13

					if var_426_13 + var_426_8 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_13 + var_426_8
					end
				end

				arg_423_1.text_.text = var_426_11
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251104", "story_v_out_114251.awb") ~= 0 then
					local var_426_14 = manager.audio:GetVoiceLength("story_v_out_114251", "114251104", "story_v_out_114251.awb") / 1000

					if var_426_14 + var_426_8 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_14 + var_426_8
					end

					if var_426_10.prefab_name ~= "" and arg_423_1.actors_[var_426_10.prefab_name] ~= nil then
						local var_426_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_10.prefab_name].transform, "story_v_out_114251", "114251104", "story_v_out_114251.awb")

						arg_423_1:RecordAudio("114251104", var_426_15)
						arg_423_1:RecordAudio("114251104", var_426_15)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_114251", "114251104", "story_v_out_114251.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_114251", "114251104", "story_v_out_114251.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_16 = math.max(var_426_9, arg_423_1.talkMaxDuration)

			if var_426_8 <= arg_423_1.time_ and arg_423_1.time_ < var_426_8 + var_426_16 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_8) / var_426_16

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_8 + var_426_16 and arg_423_1.time_ < var_426_8 + var_426_16 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10018",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST25",
		"TextureConfig/Background/ST24",
		"TextureConfig/Background/ST24a"
	},
	voices = {
		"story_v_out_114251.awb"
	}
}
