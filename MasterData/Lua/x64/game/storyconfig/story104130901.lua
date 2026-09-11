return {
	Play413091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 413091001
		arg_1_1.duration_ = 6.8

		local var_1_0 = {
			zh = 5.533,
			ja = 6.8
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
				arg_1_0:Play413091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F08m == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F08m")
				var_4_0.name = "F08m"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F08m = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F08m

				arg_1_1.bgs_.F08m.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F08m" then
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

			local var_4_9 = "10093"

			if arg_1_1.actors_["10093"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10093")

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

			local var_4_12 = arg_1_1.actors_["10093"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10093 = var_4_12.localPosition
				var_4_12.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10093", 3)

				for iter_4_4 = 0, var_4_12.childCount - 1 do
					local var_4_13 = var_4_12:GetChild(iter_4_4)

					if var_4_13.name == "split_3" or not string.find(var_4_13.name, "split") then
						var_4_13.gameObject:SetActive(true)
					else
						var_4_13.gameObject:SetActive(false)
					end
				end
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_1_1.time_ - 1.8) / var_4_14)
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -345, -245)
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				local var_4_15 = arg_1_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_15 then
					arg_1_1.var_.alphaOldValue10093 = var_4_15.alpha
					arg_1_1.var_.characterEffect10093 = var_4_15
				end

				arg_1_1.var_.alphaOldValue10093 = 0
			end

			local var_4_16 = 0.5

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 then
				if arg_1_1.var_.characterEffect10093 then
					arg_1_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10093, 1, (arg_1_1.time_ - 1.8) / var_4_16)
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and arg_1_1.var_.characterEffect10093 then
				arg_1_1.var_.characterEffect10093.alpha = 1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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

			if 0.834 < arg_1_1.time_ and arg_1_1.time_ <= 0.834 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_134_01", "se_story_134_01_crowd02", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 2
			local var_4_25 = 0.375

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(413091001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 15 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 15)

				if (15 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 15)) > 0 and var_4_25 < var_4_30 then
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

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091001", "story_v_out_413091.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_413091", "413091001", "story_v_out_413091.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_413091", "413091001", "story_v_out_413091.awb")

						arg_1_1:RecordAudio("413091001", var_4_32)
						arg_1_1:RecordAudio("413091001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_413091", "413091001", "story_v_out_413091.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_413091", "413091001", "story_v_out_413091.awb")
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
				actorName = "10093",
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
	Play413091002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 413091002
		arg_9_1.duration_ = 6.23

		local var_9_0 = {
			zh = 5.533,
			ja = 6.233
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
				arg_9_0:Play413091003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.8

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(413091002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 32 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 32)

				if (32 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 32)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091002", "story_v_out_413091.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091002", "story_v_out_413091.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_413091", "413091002", "story_v_out_413091.awb")

						arg_9_1:RecordAudio("413091002", var_12_6)
						arg_9_1:RecordAudio("413091002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_413091", "413091002", "story_v_out_413091.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_413091", "413091002", "story_v_out_413091.awb")
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
	Play413091003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 413091003
		arg_13_1.duration_ = 4.37

		local var_13_0 = {
			zh = 4.366,
			ja = 4.033
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
				arg_13_0:Play413091004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10093"]) and arg_13_1.var_.actorSpriteComps10093 == nil then
				arg_13_1.var_.actorSpriteComps10093 = arg_13_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_0 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["10093"]) then
				if arg_13_1.var_.actorSpriteComps10093 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								iter_16_1.color = Color.New(Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor2.r, (arg_13_1.time_ - 0) / var_16_0), Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor2.g, (arg_13_1.time_ - 0) / var_16_0), (Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor2.b, (arg_13_1.time_ - 0) / var_16_0)))
							else
								local var_16_1 = Mathf.Lerp(iter_16_1.color.r, 0.5, (arg_13_1.time_ - 0) / var_16_0)

								iter_16_1.color = Color.New(var_16_1, var_16_1, var_16_1)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["10093"]) and arg_13_1.var_.actorSpriteComps10093 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_16_3 then
						iter_16_3.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps10093 = nil
			end

			local var_16_2 = 0
			local var_16_3 = 0.575

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[994].name)

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

				local var_16_4 = arg_13_1:GetWordFromCfg(413091003)
				local var_16_5 = arg_13_1:FormatText(var_16_4.content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 23 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 23)

				if (23 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_5) / 23)) > 0 and var_16_3 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_2
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091003", "story_v_out_413091.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_413091", "413091003", "story_v_out_413091.awb") / 1000

					if var_16_8 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_2
					end

					if var_16_4.prefab_name ~= "" and arg_13_1.actors_[var_16_4.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_4.prefab_name].transform, "story_v_out_413091", "413091003", "story_v_out_413091.awb")

						arg_13_1:RecordAudio("413091003", var_16_9)
						arg_13_1:RecordAudio("413091003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_413091", "413091003", "story_v_out_413091.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_413091", "413091003", "story_v_out_413091.awb")
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

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play413091004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 413091004
		arg_17_1.duration_ = 6.57

		local var_17_0 = {
			zh = 5.333,
			ja = 6.566
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
				arg_17_0:Play413091005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10093 = arg_17_1.actors_["10093"].transform.localPosition
				arg_17_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10093", 3)

				for iter_20_0 = 0, arg_17_1.actors_["10093"].transform.childCount - 1 do
					local var_20_0 = arg_17_1.actors_["10093"].transform:GetChild(iter_20_0)

					if var_20_0.name == "split_7" or not string.find(var_20_0.name, "split") then
						var_20_0.gameObject:SetActive(true)
					else
						var_20_0.gameObject:SetActive(false)
					end
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_17_1.time_ - 0) / var_20_1)
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_20_2 = arg_17_1.actors_["10093"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10093 == nil then
				arg_17_1.var_.actorSpriteComps10093 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps10093 then
					for iter_20_1, iter_20_2 in pairs(arg_17_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_20_2 then
							if arg_17_1.isInRecall_ then
								iter_20_2.color = Color.New(Mathf.Lerp(iter_20_2.color.r, arg_17_1.hightColor1.r, (arg_17_1.time_ - 0) / var_20_3), Mathf.Lerp(iter_20_2.color.g, arg_17_1.hightColor1.g, (arg_17_1.time_ - 0) / var_20_3), (Mathf.Lerp(iter_20_2.color.b, arg_17_1.hightColor1.b, (arg_17_1.time_ - 0) / var_20_3)))
							else
								local var_20_4 = Mathf.Lerp(iter_20_2.color.r, 1, (arg_17_1.time_ - 0) / var_20_3)

								iter_20_2.color = Color.New(var_20_4, var_20_4, var_20_4)
							end
						end
					end
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10093 then
				for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_20_4 then
						iter_20_4.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps10093 = nil
			end

			local var_20_5 = 0
			local var_20_6 = 0.725

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:GetWordFromCfg(413091004)
				local var_20_8 = arg_17_1:FormatText(var_20_7.content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 29 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 29)

				if (29 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 29)) > 0 and var_20_6 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091004", "story_v_out_413091.awb") ~= 0 then
					local var_20_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091004", "story_v_out_413091.awb") / 1000

					if var_20_11 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_5
					end

					if var_20_7.prefab_name ~= "" and arg_17_1.actors_[var_20_7.prefab_name] ~= nil then
						local var_20_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_7.prefab_name].transform, "story_v_out_413091", "413091004", "story_v_out_413091.awb")

						arg_17_1:RecordAudio("413091004", var_20_12)
						arg_17_1:RecordAudio("413091004", var_20_12)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_413091", "413091004", "story_v_out_413091.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_413091", "413091004", "story_v_out_413091.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_13 = math.max(var_20_6, arg_17_1.talkMaxDuration)

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_13 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_5) / var_20_13

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_5 + var_20_13 and arg_17_1.time_ < var_20_5 + var_20_13 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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

		arg_17_1:InitPlayNodeList()
	end,
	Play413091005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 413091005
		arg_21_1.duration_ = 6.4

		local var_21_0 = {
			zh = 4.533,
			ja = 6.4
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
				arg_21_0:Play413091006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.65

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(413091005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 26 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 26)

				if (26 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 26)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091005", "story_v_out_413091.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091005", "story_v_out_413091.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_413091", "413091005", "story_v_out_413091.awb")

						arg_21_1:RecordAudio("413091005", var_24_6)
						arg_21_1:RecordAudio("413091005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_413091", "413091005", "story_v_out_413091.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_413091", "413091005", "story_v_out_413091.awb")
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
	Play413091006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 413091006
		arg_25_1.duration_ = 5.53

		local var_25_0 = {
			zh = 3.666,
			ja = 5.533
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
				arg_25_0:Play413091007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10093"]) and arg_25_1.var_.actorSpriteComps10093 == nil then
				arg_25_1.var_.actorSpriteComps10093 = arg_25_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_0 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10093"]) then
				if arg_25_1.var_.actorSpriteComps10093 then
					for iter_28_0, iter_28_1 in pairs(arg_25_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10093"]) and arg_25_1.var_.actorSpriteComps10093 then
				for iter_28_2, iter_28_3 in pairs(arg_25_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_28_3 then
						iter_28_3.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_25_1.var_.actorSpriteComps10093 = nil
			end

			local var_28_2 = 0
			local var_28_3 = 0.45

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[994].name)

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

				local var_28_4 = arg_25_1:GetWordFromCfg(413091006)
				local var_28_5 = arg_25_1:FormatText(var_28_4.content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 18 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 18)

				if (18 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 18)) > 0 and var_28_3 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091006", "story_v_out_413091.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_413091", "413091006", "story_v_out_413091.awb") / 1000

					if var_28_8 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_2
					end

					if var_28_4.prefab_name ~= "" and arg_25_1.actors_[var_28_4.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_4.prefab_name].transform, "story_v_out_413091", "413091006", "story_v_out_413091.awb")

						arg_25_1:RecordAudio("413091006", var_28_9)
						arg_25_1:RecordAudio("413091006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_413091", "413091006", "story_v_out_413091.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_413091", "413091006", "story_v_out_413091.awb")
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
	Play413091007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 413091007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play413091008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.775

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(413091007).content)

				arg_29_1.text_.text = var_32_1

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_3 = 31 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 31)

				if (31 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_1) / 31)) > 0 and var_32_0 < var_32_3 then
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
	Play413091008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 413091008
		arg_33_1.duration_ = 2.63

		local var_33_0 = {
			zh = 2.3,
			ja = 2.633
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
				arg_33_0:Play413091009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.225

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[994].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:GetWordFromCfg(413091008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 9 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 9)

				if (9 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 9)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091008", "story_v_out_413091.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091008", "story_v_out_413091.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_413091", "413091008", "story_v_out_413091.awb")

						arg_33_1:RecordAudio("413091008", var_36_6)
						arg_33_1:RecordAudio("413091008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_413091", "413091008", "story_v_out_413091.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_413091", "413091008", "story_v_out_413091.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_7 and arg_33_1.time_ < 0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play413091009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 413091009
		arg_37_1.duration_ = 5.7

		local var_37_0 = {
			zh = 4.1,
			ja = 5.7
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
				arg_37_0:Play413091010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0.65

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[994].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_1 = arg_37_1:GetWordFromCfg(413091009)
				local var_40_2 = arg_37_1:FormatText(var_40_1.content)

				arg_37_1.text_.text = var_40_2

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 26 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 26)

				if (26 <= 0 and var_40_0 or var_40_0 * (utf8.len(var_40_2) / 26)) > 0 and var_40_0 < var_40_4 then
					arg_37_1.talkMaxDuration = var_40_4

					if var_40_4 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_4 + 0
					end
				end

				arg_37_1.text_.text = var_40_2
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091009", "story_v_out_413091.awb") ~= 0 then
					local var_40_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091009", "story_v_out_413091.awb") / 1000

					if var_40_5 + 0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + 0
					end

					if var_40_1.prefab_name ~= "" and arg_37_1.actors_[var_40_1.prefab_name] ~= nil then
						local var_40_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_1.prefab_name].transform, "story_v_out_413091", "413091009", "story_v_out_413091.awb")

						arg_37_1:RecordAudio("413091009", var_40_6)
						arg_37_1:RecordAudio("413091009", var_40_6)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_413091", "413091009", "story_v_out_413091.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_413091", "413091009", "story_v_out_413091.awb")
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
	Play413091010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 413091010
		arg_41_1.duration_ = 7.28

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play413091011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 1 < arg_41_1.time_ and arg_41_1.time_ <= 1 + arg_44_0 then
				arg_41_1.var_.moveOldPos10093 = arg_41_1.actors_["10093"].transform.localPosition
				arg_41_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10093", 7)

				for iter_44_0 = 0, arg_41_1.actors_["10093"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["10093"].transform:GetChild(iter_44_0)

					if var_44_0.name == "" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 1 <= arg_41_1.time_ and arg_41_1.time_ < 1 + var_44_1 then
				arg_41_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_41_1.time_ - 1) / var_44_1)
			end

			if arg_41_1.time_ >= 1 + var_44_1 and arg_41_1.time_ < 1 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_44_2 = arg_41_1.actors_["10093"]

			if 1 < arg_41_1.time_ and arg_41_1.time_ <= 1 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10093 == nil then
				arg_41_1.var_.actorSpriteComps10093 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 2

			if 1 <= arg_41_1.time_ and arg_41_1.time_ < 1 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps10093 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								iter_44_2.color = Color.New(Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 1) / var_44_3), Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 1) / var_44_3), (Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 1) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_2.color.r, 0.5, (arg_41_1.time_ - 1) / var_44_3)

								iter_44_2.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 1 + var_44_3 and arg_41_1.time_ < 1 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10093 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_44_4 then
						iter_44_4.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps10093 = nil
			end

			local var_44_5 = 0

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_6 = 1

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 then
				local var_44_7 = Color.New(0, 0, 0)

				var_44_7.a = Mathf.Lerp(0, 1, (arg_41_1.time_ - var_44_5) / var_44_6)
				arg_41_1.mask_.color = var_44_7
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 then
				local var_44_8 = Color.New(0, 0, 0)

				var_44_8.a = 1
				arg_41_1.mask_.color = var_44_8
			end

			local var_44_9 = 1

			if 1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_9 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_10 = 1.4

			if var_44_9 <= arg_41_1.time_ and arg_41_1.time_ < var_44_9 + var_44_10 then
				local var_44_11 = Color.New(0, 0, 0)

				var_44_11.a = Mathf.Lerp(1, 0, (arg_41_1.time_ - var_44_9) / var_44_10)
				arg_41_1.mask_.color = var_44_11
			end

			if arg_41_1.time_ >= var_44_9 + var_44_10 and arg_41_1.time_ < var_44_9 + var_44_10 + arg_44_0 then
				local var_44_12 = Color.New(0, 0, 0)

				arg_41_1.mask_.enabled = false
				var_44_12.a = 0
				arg_41_1.mask_.color = var_44_12
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_13 = 2.275
			local var_44_14 = 0.725

			if 2.275 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_15 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_15:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_16 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(413091010).content)

				arg_41_1.text_.text = var_44_16

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_18 = 29 <= 0 and var_44_14 or var_44_14 * (utf8.len(var_44_16) / 29)

				if (29 <= 0 and var_44_14 or var_44_14 * (utf8.len(var_44_16) / 29)) > 0 and var_44_14 < var_44_18 then
					arg_41_1.talkMaxDuration = var_44_18
					var_44_13 = var_44_13 + 0.3

					if var_44_18 + var_44_13 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_13
					end
				end

				arg_41_1.text_.text = var_44_16
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_19 = var_44_13 + 0.3
			local var_44_20 = math.max(var_44_14, arg_41_1.talkMaxDuration)

			if var_44_13 + 0.3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_19 + var_44_20 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_19) / var_44_20

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_19 + var_44_20 and arg_41_1.time_ < var_44_19 + var_44_20 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play413091011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 413091011
		arg_47_1.duration_ = 3.53

		local var_47_0 = {
			zh = 3.533,
			ja = 1.6
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
				arg_47_0:Play413091012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10093 = arg_47_1.actors_["10093"].transform.localPosition
				arg_47_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("10093", 3)

				for iter_50_0 = 0, arg_47_1.actors_["10093"].transform.childCount - 1 do
					local var_50_0 = arg_47_1.actors_["10093"].transform:GetChild(iter_50_0)

					if var_50_0.name == "split_3" or not string.find(var_50_0.name, "split") then
						var_50_0.gameObject:SetActive(true)
					else
						var_50_0.gameObject:SetActive(false)
					end
				end
			end

			local var_50_1 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_1 then
				arg_47_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_47_1.time_ - 0) / var_50_1)
			end

			if arg_47_1.time_ >= 0 + var_50_1 and arg_47_1.time_ < 0 + var_50_1 + arg_50_0 then
				arg_47_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				local var_50_2 = arg_47_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_50_2 then
					arg_47_1.var_.alphaOldValue10093 = var_50_2.alpha
					arg_47_1.var_.characterEffect10093 = var_50_2
				end

				arg_47_1.var_.alphaOldValue10093 = 0
			end

			local var_50_3 = 0.0166666666666667

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_3 then
				if arg_47_1.var_.characterEffect10093 then
					arg_47_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_47_1.var_.alphaOldValue10093, 1, (arg_47_1.time_ - 0) / var_50_3)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_3 and arg_47_1.time_ < 0 + var_50_3 + arg_50_0 and arg_47_1.var_.characterEffect10093 then
				arg_47_1.var_.characterEffect10093.alpha = 1
			end

			local var_50_4 = arg_47_1.actors_["10093"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.actorSpriteComps10093 == nil then
				arg_47_1.var_.actorSpriteComps10093 = var_50_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_5 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_5 and not isNil(var_50_4) then
				if arg_47_1.var_.actorSpriteComps10093 then
					for iter_50_1, iter_50_2 in pairs(arg_47_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_50_2 then
							if arg_47_1.isInRecall_ then
								iter_50_2.color = Color.New(Mathf.Lerp(iter_50_2.color.r, arg_47_1.hightColor1.r, (arg_47_1.time_ - 0) / var_50_5), Mathf.Lerp(iter_50_2.color.g, arg_47_1.hightColor1.g, (arg_47_1.time_ - 0) / var_50_5), (Mathf.Lerp(iter_50_2.color.b, arg_47_1.hightColor1.b, (arg_47_1.time_ - 0) / var_50_5)))
							else
								local var_50_6 = Mathf.Lerp(iter_50_2.color.r, 1, (arg_47_1.time_ - 0) / var_50_5)

								iter_50_2.color = Color.New(var_50_6, var_50_6, var_50_6)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_5 and arg_47_1.time_ < 0 + var_50_5 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.actorSpriteComps10093 then
				for iter_50_3, iter_50_4 in pairs(arg_47_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_50_4 then
						iter_50_4.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_47_1.var_.actorSpriteComps10093 = nil
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:SetSpriteNiuquEffect("10093", false)
			end

			local var_50_8 = 0
			local var_50_9 = 0.4

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_8 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_10 = arg_47_1:GetWordFromCfg(413091011)
				local var_50_11 = arg_47_1:FormatText(var_50_10.content)

				arg_47_1.text_.text = var_50_11

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_13 = 16 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 16)

				if (16 <= 0 and var_50_9 or var_50_9 * (utf8.len(var_50_11) / 16)) > 0 and var_50_9 < var_50_13 then
					arg_47_1.talkMaxDuration = var_50_13

					if var_50_13 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_8
					end
				end

				arg_47_1.text_.text = var_50_11
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091011", "story_v_out_413091.awb") ~= 0 then
					local var_50_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091011", "story_v_out_413091.awb") / 1000

					if var_50_14 + var_50_8 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_14 + var_50_8
					end

					if var_50_10.prefab_name ~= "" and arg_47_1.actors_[var_50_10.prefab_name] ~= nil then
						local var_50_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_10.prefab_name].transform, "story_v_out_413091", "413091011", "story_v_out_413091.awb")

						arg_47_1:RecordAudio("413091011", var_50_15)
						arg_47_1:RecordAudio("413091011", var_50_15)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_413091", "413091011", "story_v_out_413091.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_413091", "413091011", "story_v_out_413091.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = math.max(var_50_9, arg_47_1.talkMaxDuration)

			if var_50_8 <= arg_47_1.time_ and arg_47_1.time_ < var_50_8 + var_50_16 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_8) / var_50_16

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_8 + var_50_16 and arg_47_1.time_ < var_50_8 + var_50_16 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
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

		arg_47_1:InitPlayNodeList()
	end,
	Play413091012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 413091012
		arg_51_1.duration_ = 6.33

		local var_51_0 = {
			zh = 3.966,
			ja = 6.333
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
				arg_51_0:Play413091013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["10093"]) and arg_51_1.var_.actorSpriteComps10093 == nil then
				arg_51_1.var_.actorSpriteComps10093 = arg_51_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_0 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["10093"]) then
				if arg_51_1.var_.actorSpriteComps10093 then
					for iter_54_0, iter_54_1 in pairs(arg_51_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_54_1 then
							if arg_51_1.isInRecall_ then
								iter_54_1.color = Color.New(Mathf.Lerp(iter_54_1.color.r, arg_51_1.hightColor2.r, (arg_51_1.time_ - 0) / var_54_0), Mathf.Lerp(iter_54_1.color.g, arg_51_1.hightColor2.g, (arg_51_1.time_ - 0) / var_54_0), (Mathf.Lerp(iter_54_1.color.b, arg_51_1.hightColor2.b, (arg_51_1.time_ - 0) / var_54_0)))
							else
								local var_54_1 = Mathf.Lerp(iter_54_1.color.r, 0.5, (arg_51_1.time_ - 0) / var_54_0)

								iter_54_1.color = Color.New(var_54_1, var_54_1, var_54_1)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["10093"]) and arg_51_1.var_.actorSpriteComps10093 then
				for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_54_3 then
						iter_54_3.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_51_1.var_.actorSpriteComps10093 = nil
			end

			local var_54_2 = 0
			local var_54_3 = 0.525

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_2 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[994].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_4 = arg_51_1:GetWordFromCfg(413091012)
				local var_54_5 = arg_51_1:FormatText(var_54_4.content)

				arg_51_1.text_.text = var_54_5

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_7 = 21 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_5) / 21)

				if (21 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_5) / 21)) > 0 and var_54_3 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_2 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_2
					end
				end

				arg_51_1.text_.text = var_54_5
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091012", "story_v_out_413091.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_413091", "413091012", "story_v_out_413091.awb") / 1000

					if var_54_8 + var_54_2 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_2
					end

					if var_54_4.prefab_name ~= "" and arg_51_1.actors_[var_54_4.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_4.prefab_name].transform, "story_v_out_413091", "413091012", "story_v_out_413091.awb")

						arg_51_1:RecordAudio("413091012", var_54_9)
						arg_51_1:RecordAudio("413091012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_413091", "413091012", "story_v_out_413091.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_413091", "413091012", "story_v_out_413091.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_3, arg_51_1.talkMaxDuration)

			if var_54_2 <= arg_51_1.time_ and arg_51_1.time_ < var_54_2 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_2) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_2 + var_54_10 and arg_51_1.time_ < var_54_2 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play413091013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 413091013
		arg_55_1.duration_ = 8.13

		local var_55_0 = {
			zh = 3.3,
			ja = 8.133
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
				arg_55_0:Play413091014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10093 = arg_55_1.actors_["10093"].transform.localPosition
				arg_55_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10093", 3)

				for iter_58_0 = 0, arg_55_1.actors_["10093"].transform.childCount - 1 do
					local var_58_0 = arg_55_1.actors_["10093"].transform:GetChild(iter_58_0)

					if var_58_0.name == "split_1" or not string.find(var_58_0.name, "split") then
						var_58_0.gameObject:SetActive(true)
					else
						var_58_0.gameObject:SetActive(false)
					end
				end
			end

			local var_58_1 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_1 then
				arg_55_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_55_1.time_ - 0) / var_58_1)
			end

			if arg_55_1.time_ >= 0 + var_58_1 and arg_55_1.time_ < 0 + var_58_1 + arg_58_0 then
				arg_55_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_58_2 = arg_55_1.actors_["10093"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.actorSpriteComps10093 == nil then
				arg_55_1.var_.actorSpriteComps10093 = var_58_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_3 = 2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_3 and not isNil(var_58_2) then
				if arg_55_1.var_.actorSpriteComps10093 then
					for iter_58_1, iter_58_2 in pairs(arg_55_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_58_2 then
							if arg_55_1.isInRecall_ then
								iter_58_2.color = Color.New(Mathf.Lerp(iter_58_2.color.r, arg_55_1.hightColor1.r, (arg_55_1.time_ - 0) / var_58_3), Mathf.Lerp(iter_58_2.color.g, arg_55_1.hightColor1.g, (arg_55_1.time_ - 0) / var_58_3), (Mathf.Lerp(iter_58_2.color.b, arg_55_1.hightColor1.b, (arg_55_1.time_ - 0) / var_58_3)))
							else
								local var_58_4 = Mathf.Lerp(iter_58_2.color.r, 1, (arg_55_1.time_ - 0) / var_58_3)

								iter_58_2.color = Color.New(var_58_4, var_58_4, var_58_4)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_3 and arg_55_1.time_ < 0 + var_58_3 + arg_58_0 and not isNil(var_58_2) and arg_55_1.var_.actorSpriteComps10093 then
				for iter_58_3, iter_58_4 in pairs(arg_55_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_58_4 then
						iter_58_4.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_55_1.var_.actorSpriteComps10093 = nil
			end

			local var_58_5 = 0
			local var_58_6 = 0.425

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_7 = arg_55_1:GetWordFromCfg(413091013)
				local var_58_8 = arg_55_1:FormatText(var_58_7.content)

				arg_55_1.text_.text = var_58_8

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_10 = 17 <= 0 and var_58_6 or var_58_6 * (utf8.len(var_58_8) / 17)

				if (17 <= 0 and var_58_6 or var_58_6 * (utf8.len(var_58_8) / 17)) > 0 and var_58_6 < var_58_10 then
					arg_55_1.talkMaxDuration = var_58_10

					if var_58_10 + var_58_5 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_5
					end
				end

				arg_55_1.text_.text = var_58_8
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091013", "story_v_out_413091.awb") ~= 0 then
					local var_58_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091013", "story_v_out_413091.awb") / 1000

					if var_58_11 + var_58_5 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_11 + var_58_5
					end

					if var_58_7.prefab_name ~= "" and arg_55_1.actors_[var_58_7.prefab_name] ~= nil then
						local var_58_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_7.prefab_name].transform, "story_v_out_413091", "413091013", "story_v_out_413091.awb")

						arg_55_1:RecordAudio("413091013", var_58_12)
						arg_55_1:RecordAudio("413091013", var_58_12)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_413091", "413091013", "story_v_out_413091.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_413091", "413091013", "story_v_out_413091.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_13 = math.max(var_58_6, arg_55_1.talkMaxDuration)

			if var_58_5 <= arg_55_1.time_ and arg_55_1.time_ < var_58_5 + var_58_13 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_5) / var_58_13

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_5 + var_58_13 and arg_55_1.time_ < var_58_5 + var_58_13 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
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

		arg_55_1:InitPlayNodeList()
	end,
	Play413091014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 413091014
		arg_59_1.duration_ = 2.3

		local var_59_0 = {
			zh = 1.133,
			ja = 2.3
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
				arg_59_0:Play413091015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["10093"]) and arg_59_1.var_.actorSpriteComps10093 == nil then
				arg_59_1.var_.actorSpriteComps10093 = arg_59_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_0 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["10093"]) then
				if arg_59_1.var_.actorSpriteComps10093 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["10093"]) and arg_59_1.var_.actorSpriteComps10093 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_62_3 then
						iter_62_3.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_59_1.var_.actorSpriteComps10093 = nil
			end

			local var_62_2 = 0
			local var_62_3 = 0.175

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[994].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_4 = arg_59_1:GetWordFromCfg(413091014)
				local var_62_5 = arg_59_1:FormatText(var_62_4.content)

				arg_59_1.text_.text = var_62_5

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_7 = 7 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 7)

				if (7 <= 0 and var_62_3 or var_62_3 * (utf8.len(var_62_5) / 7)) > 0 and var_62_3 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_2
					end
				end

				arg_59_1.text_.text = var_62_5
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091014", "story_v_out_413091.awb") ~= 0 then
					local var_62_8 = manager.audio:GetVoiceLength("story_v_out_413091", "413091014", "story_v_out_413091.awb") / 1000

					if var_62_8 + var_62_2 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_2
					end

					if var_62_4.prefab_name ~= "" and arg_59_1.actors_[var_62_4.prefab_name] ~= nil then
						local var_62_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_4.prefab_name].transform, "story_v_out_413091", "413091014", "story_v_out_413091.awb")

						arg_59_1:RecordAudio("413091014", var_62_9)
						arg_59_1:RecordAudio("413091014", var_62_9)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_413091", "413091014", "story_v_out_413091.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_413091", "413091014", "story_v_out_413091.awb")
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
	Play413091015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 413091015
		arg_63_1.duration_ = 5.8

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play413091016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos10093 = arg_63_1.actors_["10093"].transform.localPosition
				arg_63_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("10093", 7)

				for iter_66_0 = 0, arg_63_1.actors_["10093"].transform.childCount - 1 do
					local var_66_0 = arg_63_1.actors_["10093"].transform:GetChild(iter_66_0)

					if var_66_0.name == "" or not string.find(var_66_0.name, "split") then
						var_66_0.gameObject:SetActive(true)
					else
						var_66_0.gameObject:SetActive(false)
					end
				end
			end

			local var_66_1 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_1 then
				arg_63_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_63_1.time_ - 0) / var_66_1)
			end

			if arg_63_1.time_ >= 0 + var_66_1 and arg_63_1.time_ < 0 + var_66_1 + arg_66_0 then
				arg_63_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_66_2 = arg_63_1.actors_["10093"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.actorSpriteComps10093 == nil then
				arg_63_1.var_.actorSpriteComps10093 = var_66_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_3 = 0.1

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_3 and not isNil(var_66_2) then
				if arg_63_1.var_.actorSpriteComps10093 then
					for iter_66_1, iter_66_2 in pairs(arg_63_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_66_2 then
							if arg_63_1.isInRecall_ then
								iter_66_2.color = Color.New(Mathf.Lerp(iter_66_2.color.r, arg_63_1.hightColor2.r, (arg_63_1.time_ - 0) / var_66_3), Mathf.Lerp(iter_66_2.color.g, arg_63_1.hightColor2.g, (arg_63_1.time_ - 0) / var_66_3), (Mathf.Lerp(iter_66_2.color.b, arg_63_1.hightColor2.b, (arg_63_1.time_ - 0) / var_66_3)))
							else
								local var_66_4 = Mathf.Lerp(iter_66_2.color.r, 0.5, (arg_63_1.time_ - 0) / var_66_3)

								iter_66_2.color = Color.New(var_66_4, var_66_4, var_66_4)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_3 and arg_63_1.time_ < 0 + var_66_3 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.actorSpriteComps10093 then
				for iter_66_3, iter_66_4 in pairs(arg_63_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_66_4 then
						iter_66_4.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_63_1.var_.actorSpriteComps10093 = nil
			end

			local var_66_5 = manager.ui.mainCamera.transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.shakeOldPos = var_66_5.localPosition
			end

			local var_66_6 = 0.8

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_6 then
				local var_66_7, var_66_8 = math.modf((arg_63_1.time_ - 0) / 0.066)

				var_66_5.localPosition = Vector3.New(var_66_8 * 0.13, var_66_8 * 0.13, var_66_8 * 0.13) + arg_63_1.var_.shakeOldPos
			end

			if arg_63_1.time_ >= 0 + var_66_6 and arg_63_1.time_ < 0 + var_66_6 + arg_66_0 then
				var_66_5.localPosition = arg_63_1.var_.shakeOldPos
			end

			local var_66_9 = 0

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_9 + arg_66_0 then
				arg_63_1.allBtn_.enabled = false
			end

			if arg_63_1.time_ >= var_66_9 + 0.8 and arg_63_1.time_ < var_66_9 + 0.8 + arg_66_0 then
				arg_63_1.allBtn_.enabled = true
			end

			if arg_63_1.frameCnt_ <= 1 then
				arg_63_1.dialog_:SetActive(false)
			end

			local var_66_10 = 0.8
			local var_66_11 = 1.3

			if 0.8 < arg_63_1.time_ and arg_63_1.time_ <= var_66_10 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				arg_63_1.dialog_:SetActive(true)

				arg_63_1.dialogCg_.alpha = 0

				local var_66_12 = LeanTween.value(arg_63_1.dialog_, 0, 1, 0.3)

				var_66_12:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_63_1.dialogCg_.alpha = arg_67_0
				end))
				var_66_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_63_1.dialog_)
					var_66_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_63_1.duration_ = arg_63_1.duration_ + 0.3

				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_13 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(413091015).content)

				arg_63_1.text_.text = var_66_13

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_15 = 52 <= 0 and var_66_11 or var_66_11 * (utf8.len(var_66_13) / 52)

				if (52 <= 0 and var_66_11 or var_66_11 * (utf8.len(var_66_13) / 52)) > 0 and var_66_11 < var_66_15 then
					arg_63_1.talkMaxDuration = var_66_15
					var_66_10 = var_66_10 + 0.3

					if var_66_15 + var_66_10 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_15 + var_66_10
					end
				end

				arg_63_1.text_.text = var_66_13
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_16 = var_66_10 + 0.3
			local var_66_17 = math.max(var_66_11, arg_63_1.talkMaxDuration)

			if var_66_10 + 0.3 <= arg_63_1.time_ and arg_63_1.time_ < var_66_16 + var_66_17 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_16) / var_66_17

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_16 + var_66_17 and arg_63_1.time_ < var_66_16 + var_66_17 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
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

		arg_63_1:InitPlayNodeList()
	end,
	Play413091016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 413091016
		arg_69_1.duration_ = 5.3

		local var_69_0 = {
			zh = 4.2,
			ja = 5.3
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
				arg_69_0:Play413091017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10093 = arg_69_1.actors_["10093"].transform.localPosition
				arg_69_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10093", 3)

				for iter_72_0 = 0, arg_69_1.actors_["10093"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["10093"].transform:GetChild(iter_72_0)

					if var_72_0.name == "split_7" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_72_2 = arg_69_1.actors_["10093"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps10093 == nil then
				arg_69_1.var_.actorSpriteComps10093 = var_72_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_3 = 0.333333333333333

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.actorSpriteComps10093 then
					for iter_72_1, iter_72_2 in pairs(arg_69_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_72_2 then
							if arg_69_1.isInRecall_ then
								iter_72_2.color = Color.New(Mathf.Lerp(iter_72_2.color.r, arg_69_1.hightColor1.r, (arg_69_1.time_ - 0) / var_72_3), Mathf.Lerp(iter_72_2.color.g, arg_69_1.hightColor1.g, (arg_69_1.time_ - 0) / var_72_3), (Mathf.Lerp(iter_72_2.color.b, arg_69_1.hightColor1.b, (arg_69_1.time_ - 0) / var_72_3)))
							else
								local var_72_4 = Mathf.Lerp(iter_72_2.color.r, 1, (arg_69_1.time_ - 0) / var_72_3)

								iter_72_2.color = Color.New(var_72_4, var_72_4, var_72_4)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps10093 then
				for iter_72_3, iter_72_4 in pairs(arg_69_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_72_4 then
						iter_72_4.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps10093 = nil
			end

			local var_72_5 = 0
			local var_72_6 = 0.55

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_7 = arg_69_1:GetWordFromCfg(413091016)
				local var_72_8 = arg_69_1:FormatText(var_72_7.content)

				arg_69_1.text_.text = var_72_8

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_10 = 22 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 22)

				if (22 <= 0 and var_72_6 or var_72_6 * (utf8.len(var_72_8) / 22)) > 0 and var_72_6 < var_72_10 then
					arg_69_1.talkMaxDuration = var_72_10

					if var_72_10 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_5
					end
				end

				arg_69_1.text_.text = var_72_8
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091016", "story_v_out_413091.awb") ~= 0 then
					local var_72_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091016", "story_v_out_413091.awb") / 1000

					if var_72_11 + var_72_5 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_11 + var_72_5
					end

					if var_72_7.prefab_name ~= "" and arg_69_1.actors_[var_72_7.prefab_name] ~= nil then
						local var_72_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_7.prefab_name].transform, "story_v_out_413091", "413091016", "story_v_out_413091.awb")

						arg_69_1:RecordAudio("413091016", var_72_12)
						arg_69_1:RecordAudio("413091016", var_72_12)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_413091", "413091016", "story_v_out_413091.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_413091", "413091016", "story_v_out_413091.awb")
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
				actorName = "10093",
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
	Play413091017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 413091017
		arg_73_1.duration_ = 8.23

		local var_73_0 = {
			zh = 8.233,
			ja = 8.1
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
				arg_73_0:Play413091018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10093"]) and arg_73_1.var_.actorSpriteComps10093 == nil then
				arg_73_1.var_.actorSpriteComps10093 = arg_73_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10093"]) then
				if arg_73_1.var_.actorSpriteComps10093 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10093"]) and arg_73_1.var_.actorSpriteComps10093 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps10093 = nil
			end

			local var_76_2 = 0
			local var_76_3 = 1.075

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[994].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_knightman1")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_4 = arg_73_1:GetWordFromCfg(413091017)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 43 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 43)

				if (43 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 43)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091017", "story_v_out_413091.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_413091", "413091017", "story_v_out_413091.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_out_413091", "413091017", "story_v_out_413091.awb")

						arg_73_1:RecordAudio("413091017", var_76_9)
						arg_73_1:RecordAudio("413091017", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_413091", "413091017", "story_v_out_413091.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_413091", "413091017", "story_v_out_413091.awb")
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
	Play413091018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 413091018
		arg_77_1.duration_ = 7.63

		local var_77_0 = {
			zh = 4.3,
			ja = 7.633
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
				arg_77_0:Play413091019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10093 = arg_77_1.actors_["10093"].transform.localPosition
				arg_77_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10093", 3)

				for iter_80_0 = 0, arg_77_1.actors_["10093"].transform.childCount - 1 do
					local var_80_0 = arg_77_1.actors_["10093"].transform:GetChild(iter_80_0)

					if var_80_0.name == "" or not string.find(var_80_0.name, "split") then
						var_80_0.gameObject:SetActive(true)
					else
						var_80_0.gameObject:SetActive(false)
					end
				end
			end

			local var_80_1 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_1 then
				arg_77_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_77_1.time_ - 0) / var_80_1)
			end

			if arg_77_1.time_ >= 0 + var_80_1 and arg_77_1.time_ < 0 + var_80_1 + arg_80_0 then
				arg_77_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_80_2 = arg_77_1.actors_["10093"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10093 == nil then
				arg_77_1.var_.actorSpriteComps10093 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps10093 then
					for iter_80_1, iter_80_2 in pairs(arg_77_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps10093 then
				for iter_80_3, iter_80_4 in pairs(arg_77_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_80_4 then
						iter_80_4.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps10093 = nil
			end

			local var_80_5 = 0
			local var_80_6 = 0.525

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_7 = arg_77_1:GetWordFromCfg(413091018)
				local var_80_8 = arg_77_1:FormatText(var_80_7.content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 21 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 21)

				if (21 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 21)) > 0 and var_80_6 < var_80_10 then
					arg_77_1.talkMaxDuration = var_80_10

					if var_80_10 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091018", "story_v_out_413091.awb") ~= 0 then
					local var_80_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091018", "story_v_out_413091.awb") / 1000

					if var_80_11 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_5
					end

					if var_80_7.prefab_name ~= "" and arg_77_1.actors_[var_80_7.prefab_name] ~= nil then
						local var_80_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_7.prefab_name].transform, "story_v_out_413091", "413091018", "story_v_out_413091.awb")

						arg_77_1:RecordAudio("413091018", var_80_12)
						arg_77_1:RecordAudio("413091018", var_80_12)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_413091", "413091018", "story_v_out_413091.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_413091", "413091018", "story_v_out_413091.awb")
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
				actorName = "10093",
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
	Play413091019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 413091019
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play413091020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10093 = arg_81_1.actors_["10093"].transform.localPosition
				arg_81_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("10093", 6)

				for iter_84_0 = 0, arg_81_1.actors_["10093"].transform.childCount - 1 do
					local var_84_0 = arg_81_1.actors_["10093"].transform:GetChild(iter_84_0)

					if var_84_0.name == "" or not string.find(var_84_0.name, "split") then
						var_84_0.gameObject:SetActive(true)
					else
						var_84_0.gameObject:SetActive(false)
					end
				end
			end

			local var_84_1 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_1 then
				arg_81_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10093, Vector3.New(1500, -345, -245), (arg_81_1.time_ - 0) / var_84_1)
			end

			if arg_81_1.time_ >= 0 + var_84_1 and arg_81_1.time_ < 0 + var_84_1 + arg_84_0 then
				arg_81_1.actors_["10093"].transform.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_84_2 = arg_81_1.actors_["10093"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10093 == nil then
				arg_81_1.var_.actorSpriteComps10093 = var_84_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_3 = 2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.actorSpriteComps10093 then
					for iter_84_1, iter_84_2 in pairs(arg_81_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_84_2 then
							if arg_81_1.isInRecall_ then
								iter_84_2.color = Color.New(Mathf.Lerp(iter_84_2.color.r, arg_81_1.hightColor2.r, (arg_81_1.time_ - 0) / var_84_3), Mathf.Lerp(iter_84_2.color.g, arg_81_1.hightColor2.g, (arg_81_1.time_ - 0) / var_84_3), (Mathf.Lerp(iter_84_2.color.b, arg_81_1.hightColor2.b, (arg_81_1.time_ - 0) / var_84_3)))
							else
								local var_84_4 = Mathf.Lerp(iter_84_2.color.r, 0.5, (arg_81_1.time_ - 0) / var_84_3)

								iter_84_2.color = Color.New(var_84_4, var_84_4, var_84_4)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps10093 then
				for iter_84_3, iter_84_4 in pairs(arg_81_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_84_4 then
						iter_84_4.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps10093 = nil
			end

			local var_84_5 = 0
			local var_84_6 = 0.825

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

				local var_84_7 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(413091019).content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 33 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_7) / 33)

				if (33 <= 0 and var_84_6 or var_84_6 * (utf8.len(var_84_7) / 33)) > 0 and var_84_6 < var_84_9 then
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
				actorName = "10093",
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
	Play413091020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 413091020
		arg_85_1.duration_ = 5.7

		local var_85_0 = {
			zh = 5.7,
			ja = 2.4
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
				arg_85_0:Play413091021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0.65

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, true)
				arg_85_1.iconController_:SetSelectedState("hero")

				arg_85_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10093_split_3")

				arg_85_1.callingController_:SetSelectedState("normal")

				arg_85_1.keyicon_.color = Color.New(1, 1, 1)
				arg_85_1.icon_.color = Color.New(1, 1, 1)

				local var_88_1 = arg_85_1:GetWordFromCfg(413091020)
				local var_88_2 = arg_85_1:FormatText(var_88_1.content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 26 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 26)

				if (26 <= 0 and var_88_0 or var_88_0 * (utf8.len(var_88_2) / 26)) > 0 and var_88_0 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + 0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091020", "story_v_out_413091.awb") ~= 0 then
					local var_88_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091020", "story_v_out_413091.awb") / 1000

					if var_88_5 + 0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_5 + 0
					end

					if var_88_1.prefab_name ~= "" and arg_85_1.actors_[var_88_1.prefab_name] ~= nil then
						local var_88_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_1.prefab_name].transform, "story_v_out_413091", "413091020", "story_v_out_413091.awb")

						arg_85_1:RecordAudio("413091020", var_88_6)
						arg_85_1:RecordAudio("413091020", var_88_6)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_413091", "413091020", "story_v_out_413091.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_413091", "413091020", "story_v_out_413091.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_7 = math.max(var_88_0, arg_85_1.talkMaxDuration)

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - 0) / var_88_7

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play413091021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 413091021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play413091022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_92_0 = 0.6

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				local var_92_1, var_92_2 = math.modf((arg_89_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_92_2 * 0.13, var_92_2 * 0.13, var_92_2 * 0.13) + arg_89_1.var_.shakeOldPos
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				manager.ui.mainCamera.transform.localPosition = arg_89_1.var_.shakeOldPos
			end

			local var_92_3 = 0

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_3 + arg_92_0 then
				arg_89_1.allBtn_.enabled = false
			end

			if arg_89_1.time_ >= var_92_3 + 0.6 and arg_89_1.time_ < var_92_3 + 0.6 + arg_92_0 then
				arg_89_1.allBtn_.enabled = true
			end

			local var_92_4 = 0
			local var_92_5 = 0.9

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_6 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(413091021).content)

				arg_89_1.text_.text = var_92_6

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_8 = 36 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_6) / 36)

				if (36 <= 0 and var_92_5 or var_92_5 * (utf8.len(var_92_6) / 36)) > 0 and var_92_5 < var_92_8 then
					arg_89_1.talkMaxDuration = var_92_8

					if var_92_8 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_8 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_6
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_9 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_9 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_9

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_9 and arg_89_1.time_ < var_92_4 + var_92_9 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play413091022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 413091022
		arg_93_1.duration_ = 2.53

		local var_93_0 = {
			zh = 2.066,
			ja = 2.533
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
				arg_93_0:Play413091023(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.25

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10093_split_7")

				arg_93_1.callingController_:SetSelectedState("normal")

				arg_93_1.keyicon_.color = Color.New(1, 1, 1)
				arg_93_1.icon_.color = Color.New(1, 1, 1)

				local var_96_1 = arg_93_1:GetWordFromCfg(413091022)
				local var_96_2 = arg_93_1:FormatText(var_96_1.content)

				arg_93_1.text_.text = var_96_2

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_4 = 10 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 10)

				if (10 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_2) / 10)) > 0 and var_96_0 < var_96_4 then
					arg_93_1.talkMaxDuration = var_96_4

					if var_96_4 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_4 + 0
					end
				end

				arg_93_1.text_.text = var_96_2
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091022", "story_v_out_413091.awb") ~= 0 then
					local var_96_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091022", "story_v_out_413091.awb") / 1000

					if var_96_5 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + 0
					end

					if var_96_1.prefab_name ~= "" and arg_93_1.actors_[var_96_1.prefab_name] ~= nil then
						local var_96_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_1.prefab_name].transform, "story_v_out_413091", "413091022", "story_v_out_413091.awb")

						arg_93_1:RecordAudio("413091022", var_96_6)
						arg_93_1:RecordAudio("413091022", var_96_6)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_413091", "413091022", "story_v_out_413091.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_413091", "413091022", "story_v_out_413091.awb")
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
	Play413091023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 413091023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play413091024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:AudioAction("stop", "effect", "se_story_134_01", "se_story_134_01_crowd02", "")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:AudioAction("stop", "effect", "se_story_134_01", "se_story_134_01_crowd02", "")
			end

			local var_100_2 = 0
			local var_100_3 = 0.55

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_4 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(413091023).content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_6 = 22 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_4) / 22)

				if (22 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_4) / 22)) > 0 and var_100_3 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_2
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_3, arg_97_1.talkMaxDuration)

			if var_100_2 <= arg_97_1.time_ and arg_97_1.time_ < var_100_2 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_2) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_2 + var_100_7 and arg_97_1.time_ < var_100_2 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play413091024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 413091024
		arg_101_1.duration_ = 8.57

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play413091025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if arg_101_1.bgs_.ST0603a == nil then
				local var_104_0 = Object.Instantiate(arg_101_1.paintGo_)

				var_104_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0603a")
				var_104_0.name = "ST0603a"
				var_104_0.transform.parent = arg_101_1.stage_.transform
				var_104_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_101_1.bgs_.ST0603a = var_104_0
			end

			if 1.56666666666667 < arg_101_1.time_ and arg_101_1.time_ <= 1.56666666666667 + arg_104_0 then
				local var_104_1 = arg_101_1.bgs_.ST0603a

				arg_101_1.bgs_.ST0603a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_104_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_2 = var_104_1:GetComponent("SpriteRenderer")

				if var_104_2 and var_104_2.sprite then
					local var_104_3 = 2 * (var_104_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_104_1.transform.localScale = Vector3.New(var_104_3 / var_104_2.sprite.bounds.size.y < var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x and var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x or var_104_3 / var_104_2.sprite.bounds.size.y, var_104_3 / var_104_2.sprite.bounds.size.y < var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x and var_104_3 * manager.ui.mainCameraCom_.aspect / var_104_2.sprite.bounds.size.x or var_104_3 / var_104_2.sprite.bounds.size.y, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "ST0603a" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_4 = 3.56666666666667

			if 3.56666666666667 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.allBtn_.enabled = false
			end

			if arg_101_1.time_ >= var_104_4 + 0.3 and arg_101_1.time_ < var_104_4 + 0.3 + arg_104_0 then
				arg_101_1.allBtn_.enabled = true
			end

			local var_104_5 = 0

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_5 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_6 = 1.56666666666667

			if var_104_5 <= arg_101_1.time_ and arg_101_1.time_ < var_104_5 + var_104_6 then
				local var_104_7 = Color.New(0, 0, 0)

				var_104_7.a = Mathf.Lerp(0, 1, (arg_101_1.time_ - var_104_5) / var_104_6)
				arg_101_1.mask_.color = var_104_7
			end

			if arg_101_1.time_ >= var_104_5 + var_104_6 and arg_101_1.time_ < var_104_5 + var_104_6 + arg_104_0 then
				local var_104_8 = Color.New(0, 0, 0)

				var_104_8.a = 1
				arg_101_1.mask_.color = var_104_8
			end

			local var_104_9 = 1.56666666666667

			if 1.56666666666667 < arg_101_1.time_ and arg_101_1.time_ <= var_104_9 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_10 = 2

			if var_104_9 <= arg_101_1.time_ and arg_101_1.time_ < var_104_9 + var_104_10 then
				local var_104_11 = Color.New(0, 0, 0)

				var_104_11.a = Mathf.Lerp(1, 0, (arg_101_1.time_ - var_104_9) / var_104_10)
				arg_101_1.mask_.color = var_104_11
			end

			if arg_101_1.time_ >= var_104_9 + var_104_10 and arg_101_1.time_ < var_104_9 + var_104_10 + arg_104_0 then
				local var_104_12 = Color.New(0, 0, 0)

				arg_101_1.mask_.enabled = false
				var_104_12.a = 0
				arg_101_1.mask_.color = var_104_12
			end

			local var_104_13 = manager.ui.mainCamera.transform

			if 2.5 < arg_101_1.time_ and arg_101_1.time_ <= 2.5 + arg_104_0 then
				arg_101_1.var_.shakeOldPos = var_104_13.localPosition
			end

			local var_104_14 = 0.5

			if 2.5 <= arg_101_1.time_ and arg_101_1.time_ < 2.5 + var_104_14 then
				local var_104_15, var_104_16 = math.modf((arg_101_1.time_ - 2.5) / 0.066)

				var_104_13.localPosition = Vector3.New(var_104_16 * 0.13, var_104_16 * 0.13, var_104_16 * 0.13) + arg_101_1.var_.shakeOldPos
			end

			if arg_101_1.time_ >= 2.5 + var_104_14 and arg_101_1.time_ < 2.5 + var_104_14 + arg_104_0 then
				var_104_13.localPosition = arg_101_1.var_.shakeOldPos
			end

			if 1.56666666666667 < arg_101_1.time_ and arg_101_1.time_ <= 1.56666666666667 + arg_104_0 then
				arg_101_1:AudioAction("play", "effect", "se_story_135_01", "se_story_135_01_footstop", "")
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_18 = 3.56666666666667
			local var_104_19 = 1.4

			if 3.56666666666667 < arg_101_1.time_ and arg_101_1.time_ <= var_104_18 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_20 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_20:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_21 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(413091024).content)

				arg_101_1.text_.text = var_104_21

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_23 = 56 <= 0 and var_104_19 or var_104_19 * (utf8.len(var_104_21) / 56)

				if (56 <= 0 and var_104_19 or var_104_19 * (utf8.len(var_104_21) / 56)) > 0 and var_104_19 < var_104_23 then
					arg_101_1.talkMaxDuration = var_104_23
					var_104_18 = var_104_18 + 0.3

					if var_104_23 + var_104_18 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_23 + var_104_18
					end
				end

				arg_101_1.text_.text = var_104_21
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_24 = var_104_18 + 0.3
			local var_104_25 = math.max(var_104_19, arg_101_1.talkMaxDuration)

			if var_104_18 + 0.3 <= arg_101_1.time_ and arg_101_1.time_ < var_104_24 + var_104_25 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_24) / var_104_25

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_24 + var_104_25 and arg_101_1.time_ < var_104_24 + var_104_25 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play413091025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 413091025
		arg_107_1.duration_ = 2

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play413091026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10093 = arg_107_1.actors_["10093"].transform.localPosition
				arg_107_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("10093", 3)

				for iter_110_0 = 0, arg_107_1.actors_["10093"].transform.childCount - 1 do
					local var_110_0 = arg_107_1.actors_["10093"].transform:GetChild(iter_110_0)

					if var_110_0.name == "split_3" or not string.find(var_110_0.name, "split") then
						var_110_0.gameObject:SetActive(true)
					else
						var_110_0.gameObject:SetActive(false)
					end
				end
			end

			local var_110_1 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_1 then
				arg_107_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_107_1.time_ - 0) / var_110_1)
			end

			if arg_107_1.time_ >= 0 + var_110_1 and arg_107_1.time_ < 0 + var_110_1 + arg_110_0 then
				arg_107_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_110_2 = arg_107_1.actors_["10093"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.actorSpriteComps10093 == nil then
				arg_107_1.var_.actorSpriteComps10093 = var_110_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_3 = 2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_3 and not isNil(var_110_2) then
				if arg_107_1.var_.actorSpriteComps10093 then
					for iter_110_1, iter_110_2 in pairs(arg_107_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_110_2 then
							if arg_107_1.isInRecall_ then
								iter_110_2.color = Color.New(Mathf.Lerp(iter_110_2.color.r, arg_107_1.hightColor1.r, (arg_107_1.time_ - 0) / var_110_3), Mathf.Lerp(iter_110_2.color.g, arg_107_1.hightColor1.g, (arg_107_1.time_ - 0) / var_110_3), (Mathf.Lerp(iter_110_2.color.b, arg_107_1.hightColor1.b, (arg_107_1.time_ - 0) / var_110_3)))
							else
								local var_110_4 = Mathf.Lerp(iter_110_2.color.r, 1, (arg_107_1.time_ - 0) / var_110_3)

								iter_110_2.color = Color.New(var_110_4, var_110_4, var_110_4)
							end
						end
					end
				end
			end

			if arg_107_1.time_ >= 0 + var_110_3 and arg_107_1.time_ < 0 + var_110_3 + arg_110_0 and not isNil(var_110_2) and arg_107_1.var_.actorSpriteComps10093 then
				for iter_110_3, iter_110_4 in pairs(arg_107_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_110_4 then
						iter_110_4.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_107_1.var_.actorSpriteComps10093 = nil
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				local var_110_5 = arg_107_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_110_5 then
					arg_107_1.var_.alphaOldValue10093 = var_110_5.alpha
					arg_107_1.var_.characterEffect10093 = var_110_5
				end

				arg_107_1.var_.alphaOldValue10093 = 0
			end

			local var_110_6 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_6 then
				if arg_107_1.var_.characterEffect10093 then
					arg_107_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_107_1.var_.alphaOldValue10093, 1, (arg_107_1.time_ - 0) / var_110_6)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_6 and arg_107_1.time_ < 0 + var_110_6 + arg_110_0 and arg_107_1.var_.characterEffect10093 then
				arg_107_1.var_.characterEffect10093.alpha = 1
			end

			if arg_107_1.frameCnt_ <= 1 then
				arg_107_1.dialog_:SetActive(false)
			end

			local var_110_7 = 0.333333333333333
			local var_110_8 = 0.1

			if 0.333333333333333 < arg_107_1.time_ and arg_107_1.time_ <= var_110_7 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0

				arg_107_1.dialog_:SetActive(true)

				arg_107_1.dialogCg_.alpha = 0

				local var_110_9 = LeanTween.value(arg_107_1.dialog_, 0, 1, 0.3)

				var_110_9:setOnUpdate(LuaHelper.FloatAction(function(arg_111_0)
					arg_107_1.dialogCg_.alpha = arg_111_0
				end))
				var_110_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_107_1.dialog_)
					var_110_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_107_1.duration_ = arg_107_1.duration_ + 0.3

				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_10 = arg_107_1:GetWordFromCfg(413091025)
				local var_110_11 = arg_107_1:FormatText(var_110_10.content)

				arg_107_1.text_.text = var_110_11

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_13 = 4 <= 0 and var_110_8 or var_110_8 * (utf8.len(var_110_11) / 4)

				if (4 <= 0 and var_110_8 or var_110_8 * (utf8.len(var_110_11) / 4)) > 0 and var_110_8 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13
					var_110_7 = var_110_7 + 0.3

					if var_110_13 + var_110_7 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_7
					end
				end

				arg_107_1.text_.text = var_110_11
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091025", "story_v_out_413091.awb") ~= 0 then
					local var_110_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091025", "story_v_out_413091.awb") / 1000

					if var_110_14 + var_110_7 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_7
					end

					if var_110_10.prefab_name ~= "" and arg_107_1.actors_[var_110_10.prefab_name] ~= nil then
						local var_110_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_10.prefab_name].transform, "story_v_out_413091", "413091025", "story_v_out_413091.awb")

						arg_107_1:RecordAudio("413091025", var_110_15)
						arg_107_1:RecordAudio("413091025", var_110_15)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_413091", "413091025", "story_v_out_413091.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_413091", "413091025", "story_v_out_413091.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_16 = var_110_7 + 0.3
			local var_110_17 = math.max(var_110_8, arg_107_1.talkMaxDuration)

			if var_110_7 + 0.3 <= arg_107_1.time_ and arg_107_1.time_ < var_110_16 + var_110_17 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_16) / var_110_17

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_16 + var_110_17 and arg_107_1.time_ < var_110_16 + var_110_17 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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

		arg_107_1:InitPlayNodeList()
	end,
	Play413091026 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 413091026
		arg_113_1.duration_ = 8.1

		local var_113_0 = {
			zh = 8.1,
			ja = 3.733
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
				arg_113_0:Play413091027(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10093 = arg_113_1.actors_["10093"].transform.localPosition
				arg_113_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10093", 6)

				for iter_116_0 = 0, arg_113_1.actors_["10093"].transform.childCount - 1 do
					local var_116_0 = arg_113_1.actors_["10093"].transform:GetChild(iter_116_0)

					if var_116_0.name == "" or not string.find(var_116_0.name, "split") then
						var_116_0.gameObject:SetActive(true)
					else
						var_116_0.gameObject:SetActive(false)
					end
				end
			end

			local var_116_1 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_1 then
				arg_113_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10093, Vector3.New(1500, -345, -245), (arg_113_1.time_ - 0) / var_116_1)
			end

			if arg_113_1.time_ >= 0 + var_116_1 and arg_113_1.time_ < 0 + var_116_1 + arg_116_0 then
				arg_113_1.actors_["10093"].transform.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_116_2 = "10097"

			if arg_113_1.actors_["10097"] == nil then
				local var_116_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10097")

				if not isNil(var_116_3) then
					local var_116_4 = Object.Instantiate(var_116_3, arg_113_1.canvasGo_.transform)

					var_116_4.transform:SetSiblingIndex(1)

					var_116_4.name = var_116_2
					var_116_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_113_1.actors_[var_116_2] = var_116_4

					if arg_113_1.isInRecall_ then
						for iter_116_1, iter_116_2 in ipairs((var_116_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_116_2.color = arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_116_5 = arg_113_1.actors_["10097"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10097 = var_116_5.localPosition
				var_116_5.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("10097", 3)

				for iter_116_3 = 0, var_116_5.childCount - 1 do
					local var_116_6 = var_116_5:GetChild(iter_116_3)

					if var_116_6.name == "split_2" or not string.find(var_116_6.name, "split") then
						var_116_6.gameObject:SetActive(true)
					else
						var_116_6.gameObject:SetActive(false)
					end
				end
			end

			local var_116_7 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_7 then
				var_116_5.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_113_1.time_ - 0) / var_116_7)
			end

			if arg_113_1.time_ >= 0 + var_116_7 and arg_113_1.time_ < 0 + var_116_7 + arg_116_0 then
				var_116_5.localPosition = Vector3.New(0, -350, -180)
			end

			local var_116_8 = arg_113_1.actors_["10093"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_8) and arg_113_1.var_.actorSpriteComps10093 == nil then
				arg_113_1.var_.actorSpriteComps10093 = var_116_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_9 = 2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_9 and not isNil(var_116_8) then
				if arg_113_1.var_.actorSpriteComps10093 then
					for iter_116_4, iter_116_5 in pairs(arg_113_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_116_5 then
							if arg_113_1.isInRecall_ then
								iter_116_5.color = Color.New(Mathf.Lerp(iter_116_5.color.r, arg_113_1.hightColor2.r, (arg_113_1.time_ - 0) / var_116_9), Mathf.Lerp(iter_116_5.color.g, arg_113_1.hightColor2.g, (arg_113_1.time_ - 0) / var_116_9), (Mathf.Lerp(iter_116_5.color.b, arg_113_1.hightColor2.b, (arg_113_1.time_ - 0) / var_116_9)))
							else
								local var_116_10 = Mathf.Lerp(iter_116_5.color.r, 0.5, (arg_113_1.time_ - 0) / var_116_9)

								iter_116_5.color = Color.New(var_116_10, var_116_10, var_116_10)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_9 and arg_113_1.time_ < 0 + var_116_9 + arg_116_0 and not isNil(var_116_8) and arg_113_1.var_.actorSpriteComps10093 then
				for iter_116_6, iter_116_7 in pairs(arg_113_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_116_7 then
						iter_116_7.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_113_1.var_.actorSpriteComps10093 = nil
			end

			local var_116_11 = arg_113_1.actors_["10097"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_11) and arg_113_1.var_.actorSpriteComps10097 == nil then
				arg_113_1.var_.actorSpriteComps10097 = var_116_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_12 = 2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_12 and not isNil(var_116_11) then
				if arg_113_1.var_.actorSpriteComps10097 then
					for iter_116_8, iter_116_9 in pairs(arg_113_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_116_9 then
							if arg_113_1.isInRecall_ then
								iter_116_9.color = Color.New(Mathf.Lerp(iter_116_9.color.r, arg_113_1.hightColor1.r, (arg_113_1.time_ - 0) / var_116_12), Mathf.Lerp(iter_116_9.color.g, arg_113_1.hightColor1.g, (arg_113_1.time_ - 0) / var_116_12), (Mathf.Lerp(iter_116_9.color.b, arg_113_1.hightColor1.b, (arg_113_1.time_ - 0) / var_116_12)))
							else
								local var_116_13 = Mathf.Lerp(iter_116_9.color.r, 1, (arg_113_1.time_ - 0) / var_116_12)

								iter_116_9.color = Color.New(var_116_13, var_116_13, var_116_13)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_12 and arg_113_1.time_ < 0 + var_116_12 + arg_116_0 and not isNil(var_116_11) and arg_113_1.var_.actorSpriteComps10097 then
				for iter_116_10, iter_116_11 in pairs(arg_113_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_116_11 then
						iter_116_11.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_113_1.var_.actorSpriteComps10097 = nil
			end

			local var_116_14 = 0
			local var_116_15 = 0.6

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_16 = arg_113_1:GetWordFromCfg(413091026)
				local var_116_17 = arg_113_1:FormatText(var_116_16.content)

				arg_113_1.text_.text = var_116_17

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_19 = 24 <= 0 and var_116_15 or var_116_15 * (utf8.len(var_116_17) / 24)

				if (24 <= 0 and var_116_15 or var_116_15 * (utf8.len(var_116_17) / 24)) > 0 and var_116_15 < var_116_19 then
					arg_113_1.talkMaxDuration = var_116_19

					if var_116_19 + var_116_14 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_19 + var_116_14
					end
				end

				arg_113_1.text_.text = var_116_17
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091026", "story_v_out_413091.awb") ~= 0 then
					local var_116_20 = manager.audio:GetVoiceLength("story_v_out_413091", "413091026", "story_v_out_413091.awb") / 1000

					if var_116_20 + var_116_14 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_20 + var_116_14
					end

					if var_116_16.prefab_name ~= "" and arg_113_1.actors_[var_116_16.prefab_name] ~= nil then
						local var_116_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_16.prefab_name].transform, "story_v_out_413091", "413091026", "story_v_out_413091.awb")

						arg_113_1:RecordAudio("413091026", var_116_21)
						arg_113_1:RecordAudio("413091026", var_116_21)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_413091", "413091026", "story_v_out_413091.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_413091", "413091026", "story_v_out_413091.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_22 = math.max(var_116_15, arg_113_1.talkMaxDuration)

			if var_116_14 <= arg_113_1.time_ and arg_113_1.time_ < var_116_14 + var_116_22 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_14) / var_116_22

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_14 + var_116_22 and arg_113_1.time_ < var_116_14 + var_116_22 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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
				actorName = "10097",
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
	Play413091027 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 413091027
		arg_117_1.duration_ = 7.53

		local var_117_0 = {
			zh = 3.1,
			ja = 7.533
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
				arg_117_0:Play413091028(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10097 = arg_117_1.actors_["10097"].transform.localPosition
				arg_117_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10097", 2)

				for iter_120_0 = 0, arg_117_1.actors_["10097"].transform.childCount - 1 do
					local var_120_0 = arg_117_1.actors_["10097"].transform:GetChild(iter_120_0)

					if var_120_0.name == "" or not string.find(var_120_0.name, "split") then
						var_120_0.gameObject:SetActive(true)
					else
						var_120_0.gameObject:SetActive(false)
					end
				end
			end

			local var_120_1 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_1 then
				arg_117_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_117_1.time_ - 0) / var_120_1)
			end

			if arg_117_1.time_ >= 0 + var_120_1 and arg_117_1.time_ < 0 + var_120_1 + arg_120_0 then
				arg_117_1.actors_["10097"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_120_2 = arg_117_1.actors_["10093"].transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10093 = var_120_2.localPosition
				var_120_2.localScale = Vector3.New(1, 1, 1)

				arg_117_1:CheckSpriteTmpPos("10093", 4)

				for iter_120_1 = 0, var_120_2.childCount - 1 do
					local var_120_3 = var_120_2:GetChild(iter_120_1)

					if var_120_3.name == "split_3" or not string.find(var_120_3.name, "split") then
						var_120_3.gameObject:SetActive(true)
					else
						var_120_3.gameObject:SetActive(false)
					end
				end
			end

			local var_120_4 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_4 then
				var_120_2.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_117_1.time_ - 0) / var_120_4)
			end

			if arg_117_1.time_ >= 0 + var_120_4 and arg_117_1.time_ < 0 + var_120_4 + arg_120_0 then
				var_120_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_120_5 = arg_117_1.actors_["10097"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.actorSpriteComps10097 == nil then
				arg_117_1.var_.actorSpriteComps10097 = var_120_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_6 = 2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_6 and not isNil(var_120_5) then
				if arg_117_1.var_.actorSpriteComps10097 then
					for iter_120_2, iter_120_3 in pairs(arg_117_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_120_3 then
							if arg_117_1.isInRecall_ then
								iter_120_3.color = Color.New(Mathf.Lerp(iter_120_3.color.r, arg_117_1.hightColor2.r, (arg_117_1.time_ - 0) / var_120_6), Mathf.Lerp(iter_120_3.color.g, arg_117_1.hightColor2.g, (arg_117_1.time_ - 0) / var_120_6), (Mathf.Lerp(iter_120_3.color.b, arg_117_1.hightColor2.b, (arg_117_1.time_ - 0) / var_120_6)))
							else
								local var_120_7 = Mathf.Lerp(iter_120_3.color.r, 0.5, (arg_117_1.time_ - 0) / var_120_6)

								iter_120_3.color = Color.New(var_120_7, var_120_7, var_120_7)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_6 and arg_117_1.time_ < 0 + var_120_6 + arg_120_0 and not isNil(var_120_5) and arg_117_1.var_.actorSpriteComps10097 then
				for iter_120_4, iter_120_5 in pairs(arg_117_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_120_5 then
						iter_120_5.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_117_1.var_.actorSpriteComps10097 = nil
			end

			local var_120_8 = arg_117_1.actors_["10093"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.actorSpriteComps10093 == nil then
				arg_117_1.var_.actorSpriteComps10093 = var_120_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_120_9 = 2

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_9 and not isNil(var_120_8) then
				if arg_117_1.var_.actorSpriteComps10093 then
					for iter_120_6, iter_120_7 in pairs(arg_117_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_120_7 then
							if arg_117_1.isInRecall_ then
								iter_120_7.color = Color.New(Mathf.Lerp(iter_120_7.color.r, arg_117_1.hightColor1.r, (arg_117_1.time_ - 0) / var_120_9), Mathf.Lerp(iter_120_7.color.g, arg_117_1.hightColor1.g, (arg_117_1.time_ - 0) / var_120_9), (Mathf.Lerp(iter_120_7.color.b, arg_117_1.hightColor1.b, (arg_117_1.time_ - 0) / var_120_9)))
							else
								local var_120_10 = Mathf.Lerp(iter_120_7.color.r, 1, (arg_117_1.time_ - 0) / var_120_9)

								iter_120_7.color = Color.New(var_120_10, var_120_10, var_120_10)
							end
						end
					end
				end
			end

			if arg_117_1.time_ >= 0 + var_120_9 and arg_117_1.time_ < 0 + var_120_9 + arg_120_0 and not isNil(var_120_8) and arg_117_1.var_.actorSpriteComps10093 then
				for iter_120_8, iter_120_9 in pairs(arg_117_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_120_9 then
						iter_120_9.color = arg_117_1.isInRecall_ and (arg_117_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_117_1.var_.actorSpriteComps10093 = nil
			end

			local var_120_11 = 0
			local var_120_12 = 0.225

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_11 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_13 = arg_117_1:GetWordFromCfg(413091027)
				local var_120_14 = arg_117_1:FormatText(var_120_13.content)

				arg_117_1.text_.text = var_120_14

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_16 = 9 <= 0 and var_120_12 or var_120_12 * (utf8.len(var_120_14) / 9)

				if (9 <= 0 and var_120_12 or var_120_12 * (utf8.len(var_120_14) / 9)) > 0 and var_120_12 < var_120_16 then
					arg_117_1.talkMaxDuration = var_120_16

					if var_120_16 + var_120_11 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_16 + var_120_11
					end
				end

				arg_117_1.text_.text = var_120_14
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091027", "story_v_out_413091.awb") ~= 0 then
					local var_120_17 = manager.audio:GetVoiceLength("story_v_out_413091", "413091027", "story_v_out_413091.awb") / 1000

					if var_120_17 + var_120_11 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_17 + var_120_11
					end

					if var_120_13.prefab_name ~= "" and arg_117_1.actors_[var_120_13.prefab_name] ~= nil then
						local var_120_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_13.prefab_name].transform, "story_v_out_413091", "413091027", "story_v_out_413091.awb")

						arg_117_1:RecordAudio("413091027", var_120_18)
						arg_117_1:RecordAudio("413091027", var_120_18)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_413091", "413091027", "story_v_out_413091.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_413091", "413091027", "story_v_out_413091.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_19 = math.max(var_120_12, arg_117_1.talkMaxDuration)

			if var_120_11 <= arg_117_1.time_ and arg_117_1.time_ < var_120_11 + var_120_19 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_11) / var_120_19

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_11 + var_120_19 and arg_117_1.time_ < var_120_11 + var_120_19 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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
				actorName = "10093",
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
	Play413091028 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 413091028
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play413091029(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10093 = arg_121_1.actors_["10093"].transform.localPosition
				arg_121_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10093", 6)

				for iter_124_0 = 0, arg_121_1.actors_["10093"].transform.childCount - 1 do
					local var_124_0 = arg_121_1.actors_["10093"].transform:GetChild(iter_124_0)

					if var_124_0.name == "" or not string.find(var_124_0.name, "split") then
						var_124_0.gameObject:SetActive(true)
					else
						var_124_0.gameObject:SetActive(false)
					end
				end
			end

			local var_124_1 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_1 then
				arg_121_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10093, Vector3.New(1500, -345, -245), (arg_121_1.time_ - 0) / var_124_1)
			end

			if arg_121_1.time_ >= 0 + var_124_1 and arg_121_1.time_ < 0 + var_124_1 + arg_124_0 then
				arg_121_1.actors_["10093"].transform.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_124_2 = arg_121_1.actors_["10097"].transform

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos10097 = var_124_2.localPosition
				var_124_2.localScale = Vector3.New(1, 1, 1)

				arg_121_1:CheckSpriteTmpPos("10097", 6)

				for iter_124_1 = 0, var_124_2.childCount - 1 do
					local var_124_3 = var_124_2:GetChild(iter_124_1)

					if var_124_3.name == "" or not string.find(var_124_3.name, "split") then
						var_124_3.gameObject:SetActive(true)
					else
						var_124_3.gameObject:SetActive(false)
					end
				end
			end

			local var_124_4 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_4 then
				var_124_2.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10097, Vector3.New(1500, -350, -180), (arg_121_1.time_ - 0) / var_124_4)
			end

			if arg_121_1.time_ >= 0 + var_124_4 and arg_121_1.time_ < 0 + var_124_4 + arg_124_0 then
				var_124_2.localPosition = Vector3.New(1500, -350, -180)
			end

			local var_124_5 = arg_121_1.actors_["10093"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.actorSpriteComps10093 == nil then
				arg_121_1.var_.actorSpriteComps10093 = var_124_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_6 = 2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_6 and not isNil(var_124_5) then
				if arg_121_1.var_.actorSpriteComps10093 then
					for iter_124_2, iter_124_3 in pairs(arg_121_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_124_3 then
							if arg_121_1.isInRecall_ then
								iter_124_3.color = Color.New(Mathf.Lerp(iter_124_3.color.r, arg_121_1.hightColor2.r, (arg_121_1.time_ - 0) / var_124_6), Mathf.Lerp(iter_124_3.color.g, arg_121_1.hightColor2.g, (arg_121_1.time_ - 0) / var_124_6), (Mathf.Lerp(iter_124_3.color.b, arg_121_1.hightColor2.b, (arg_121_1.time_ - 0) / var_124_6)))
							else
								local var_124_7 = Mathf.Lerp(iter_124_3.color.r, 0.5, (arg_121_1.time_ - 0) / var_124_6)

								iter_124_3.color = Color.New(var_124_7, var_124_7, var_124_7)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_6 and arg_121_1.time_ < 0 + var_124_6 + arg_124_0 and not isNil(var_124_5) and arg_121_1.var_.actorSpriteComps10093 then
				for iter_124_4, iter_124_5 in pairs(arg_121_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_124_5 then
						iter_124_5.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps10093 = nil
			end

			local var_124_8 = arg_121_1.actors_["10097"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_8) and arg_121_1.var_.actorSpriteComps10097 == nil then
				arg_121_1.var_.actorSpriteComps10097 = var_124_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_124_9 = 2

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_9 and not isNil(var_124_8) then
				if arg_121_1.var_.actorSpriteComps10097 then
					for iter_124_6, iter_124_7 in pairs(arg_121_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_124_7 then
							if arg_121_1.isInRecall_ then
								iter_124_7.color = Color.New(Mathf.Lerp(iter_124_7.color.r, arg_121_1.hightColor2.r, (arg_121_1.time_ - 0) / var_124_9), Mathf.Lerp(iter_124_7.color.g, arg_121_1.hightColor2.g, (arg_121_1.time_ - 0) / var_124_9), (Mathf.Lerp(iter_124_7.color.b, arg_121_1.hightColor2.b, (arg_121_1.time_ - 0) / var_124_9)))
							else
								local var_124_10 = Mathf.Lerp(iter_124_7.color.r, 0.5, (arg_121_1.time_ - 0) / var_124_9)

								iter_124_7.color = Color.New(var_124_10, var_124_10, var_124_10)
							end
						end
					end
				end
			end

			if arg_121_1.time_ >= 0 + var_124_9 and arg_121_1.time_ < 0 + var_124_9 + arg_124_0 and not isNil(var_124_8) and arg_121_1.var_.actorSpriteComps10097 then
				for iter_124_8, iter_124_9 in pairs(arg_121_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_124_9 then
						iter_124_9.color = arg_121_1.isInRecall_ and (arg_121_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_121_1.var_.actorSpriteComps10097 = nil
			end

			local var_124_11 = 0
			local var_124_12 = 1.025

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_11 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_13 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(413091028).content)

				arg_121_1.text_.text = var_124_13

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_15 = 41 <= 0 and var_124_12 or var_124_12 * (utf8.len(var_124_13) / 41)

				if (41 <= 0 and var_124_12 or var_124_12 * (utf8.len(var_124_13) / 41)) > 0 and var_124_12 < var_124_15 then
					arg_121_1.talkMaxDuration = var_124_15

					if var_124_15 + var_124_11 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_15 + var_124_11
					end
				end

				arg_121_1.text_.text = var_124_13
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_16 = math.max(var_124_12, arg_121_1.talkMaxDuration)

			if var_124_11 <= arg_121_1.time_ and arg_121_1.time_ < var_124_11 + var_124_16 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_11) / var_124_16

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_11 + var_124_16 and arg_121_1.time_ < var_124_11 + var_124_16 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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
				actorName = "10097",
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
	Play413091029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 413091029
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play413091030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 1.125

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_1 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(413091029).content)

				arg_125_1.text_.text = var_128_1

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_3 = 45 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 45)

				if (45 <= 0 and var_128_0 or var_128_0 * (utf8.len(var_128_1) / 45)) > 0 and var_128_0 < var_128_3 then
					arg_125_1.talkMaxDuration = var_128_3

					if var_128_3 + 0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_3 + 0
					end
				end

				arg_125_1.text_.text = var_128_1
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_4 = math.max(var_128_0, arg_125_1.talkMaxDuration)

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - 0) / var_128_4

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play413091030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 413091030
		arg_129_1.duration_ = 8.23

		local var_129_0 = {
			zh = 7.333,
			ja = 8.233
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
				arg_129_0:Play413091031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10097 = arg_129_1.actors_["10097"].transform.localPosition
				arg_129_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10097", 2)

				for iter_132_0 = 0, arg_129_1.actors_["10097"].transform.childCount - 1 do
					local var_132_0 = arg_129_1.actors_["10097"].transform:GetChild(iter_132_0)

					if var_132_0.name == "split_3" or not string.find(var_132_0.name, "split") then
						var_132_0.gameObject:SetActive(true)
					else
						var_132_0.gameObject:SetActive(false)
					end
				end
			end

			local var_132_1 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_1 then
				arg_129_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_129_1.time_ - 0) / var_132_1)
			end

			if arg_129_1.time_ >= 0 + var_132_1 and arg_129_1.time_ < 0 + var_132_1 + arg_132_0 then
				arg_129_1.actors_["10097"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_132_2 = arg_129_1.actors_["10093"].transform

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos10093 = var_132_2.localPosition
				var_132_2.localScale = Vector3.New(1, 1, 1)

				arg_129_1:CheckSpriteTmpPos("10093", 7)

				for iter_132_1 = 0, var_132_2.childCount - 1 do
					local var_132_3 = var_132_2:GetChild(iter_132_1)

					if var_132_3.name == "" or not string.find(var_132_3.name, "split") then
						var_132_3.gameObject:SetActive(true)
					else
						var_132_3.gameObject:SetActive(false)
					end
				end
			end

			local var_132_4 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_4 then
				var_132_2.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_129_1.time_ - 0) / var_132_4)
			end

			if arg_129_1.time_ >= 0 + var_132_4 and arg_129_1.time_ < 0 + var_132_4 + arg_132_0 then
				var_132_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_132_5 = arg_129_1.actors_["10097"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.actorSpriteComps10097 == nil then
				arg_129_1.var_.actorSpriteComps10097 = var_132_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_6 = 2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_6 and not isNil(var_132_5) then
				if arg_129_1.var_.actorSpriteComps10097 then
					for iter_132_2, iter_132_3 in pairs(arg_129_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_132_3 then
							if arg_129_1.isInRecall_ then
								iter_132_3.color = Color.New(Mathf.Lerp(iter_132_3.color.r, arg_129_1.hightColor1.r, (arg_129_1.time_ - 0) / var_132_6), Mathf.Lerp(iter_132_3.color.g, arg_129_1.hightColor1.g, (arg_129_1.time_ - 0) / var_132_6), (Mathf.Lerp(iter_132_3.color.b, arg_129_1.hightColor1.b, (arg_129_1.time_ - 0) / var_132_6)))
							else
								local var_132_7 = Mathf.Lerp(iter_132_3.color.r, 1, (arg_129_1.time_ - 0) / var_132_6)

								iter_132_3.color = Color.New(var_132_7, var_132_7, var_132_7)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_6 and arg_129_1.time_ < 0 + var_132_6 + arg_132_0 and not isNil(var_132_5) and arg_129_1.var_.actorSpriteComps10097 then
				for iter_132_4, iter_132_5 in pairs(arg_129_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_132_5 then
						iter_132_5.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_129_1.var_.actorSpriteComps10097 = nil
			end

			local var_132_8 = arg_129_1.actors_["10093"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_8) and arg_129_1.var_.actorSpriteComps10093 == nil then
				arg_129_1.var_.actorSpriteComps10093 = var_132_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_132_9 = 2

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_9 and not isNil(var_132_8) then
				if arg_129_1.var_.actorSpriteComps10093 then
					for iter_132_6, iter_132_7 in pairs(arg_129_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_132_7 then
							if arg_129_1.isInRecall_ then
								iter_132_7.color = Color.New(Mathf.Lerp(iter_132_7.color.r, arg_129_1.hightColor2.r, (arg_129_1.time_ - 0) / var_132_9), Mathf.Lerp(iter_132_7.color.g, arg_129_1.hightColor2.g, (arg_129_1.time_ - 0) / var_132_9), (Mathf.Lerp(iter_132_7.color.b, arg_129_1.hightColor2.b, (arg_129_1.time_ - 0) / var_132_9)))
							else
								local var_132_10 = Mathf.Lerp(iter_132_7.color.r, 0.5, (arg_129_1.time_ - 0) / var_132_9)

								iter_132_7.color = Color.New(var_132_10, var_132_10, var_132_10)
							end
						end
					end
				end
			end

			if arg_129_1.time_ >= 0 + var_132_9 and arg_129_1.time_ < 0 + var_132_9 + arg_132_0 and not isNil(var_132_8) and arg_129_1.var_.actorSpriteComps10093 then
				for iter_132_8, iter_132_9 in pairs(arg_129_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_132_9 then
						iter_132_9.color = arg_129_1.isInRecall_ and (arg_129_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_129_1.var_.actorSpriteComps10093 = nil
			end

			local var_132_11 = 0
			local var_132_12 = 0.7

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_11 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_13 = arg_129_1:GetWordFromCfg(413091030)
				local var_132_14 = arg_129_1:FormatText(var_132_13.content)

				arg_129_1.text_.text = var_132_14

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_16 = 28 <= 0 and var_132_12 or var_132_12 * (utf8.len(var_132_14) / 28)

				if (28 <= 0 and var_132_12 or var_132_12 * (utf8.len(var_132_14) / 28)) > 0 and var_132_12 < var_132_16 then
					arg_129_1.talkMaxDuration = var_132_16

					if var_132_16 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_16 + var_132_11
					end
				end

				arg_129_1.text_.text = var_132_14
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091030", "story_v_out_413091.awb") ~= 0 then
					local var_132_17 = manager.audio:GetVoiceLength("story_v_out_413091", "413091030", "story_v_out_413091.awb") / 1000

					if var_132_17 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_17 + var_132_11
					end

					if var_132_13.prefab_name ~= "" and arg_129_1.actors_[var_132_13.prefab_name] ~= nil then
						local var_132_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_13.prefab_name].transform, "story_v_out_413091", "413091030", "story_v_out_413091.awb")

						arg_129_1:RecordAudio("413091030", var_132_18)
						arg_129_1:RecordAudio("413091030", var_132_18)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_413091", "413091030", "story_v_out_413091.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_413091", "413091030", "story_v_out_413091.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_19 = math.max(var_132_12, arg_129_1.talkMaxDuration)

			if var_132_11 <= arg_129_1.time_ and arg_129_1.time_ < var_132_11 + var_132_19 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_11) / var_132_19

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_11 + var_132_19 and arg_129_1.time_ < var_132_11 + var_132_19 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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
	Play413091031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 413091031
		arg_133_1.duration_ = 3.4

		local var_133_0 = {
			zh = 3.033,
			ja = 3.4
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
				arg_133_0:Play413091032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10093 = arg_133_1.actors_["10093"].transform.localPosition
				arg_133_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_133_1:CheckSpriteTmpPos("10093", 4)

				for iter_136_0 = 0, arg_133_1.actors_["10093"].transform.childCount - 1 do
					local var_136_0 = arg_133_1.actors_["10093"].transform:GetChild(iter_136_0)

					if var_136_0.name == "split_7" or not string.find(var_136_0.name, "split") then
						var_136_0.gameObject:SetActive(true)
					else
						var_136_0.gameObject:SetActive(false)
					end
				end
			end

			local var_136_1 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_1 then
				arg_133_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_133_1.time_ - 0) / var_136_1)
			end

			if arg_133_1.time_ >= 0 + var_136_1 and arg_133_1.time_ < 0 + var_136_1 + arg_136_0 then
				arg_133_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
			end

			local var_136_2 = arg_133_1.actors_["10093"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps10093 == nil then
				arg_133_1.var_.actorSpriteComps10093 = var_136_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_3 = 2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_3 and not isNil(var_136_2) then
				if arg_133_1.var_.actorSpriteComps10093 then
					for iter_136_1, iter_136_2 in pairs(arg_133_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_136_2 then
							if arg_133_1.isInRecall_ then
								iter_136_2.color = Color.New(Mathf.Lerp(iter_136_2.color.r, arg_133_1.hightColor1.r, (arg_133_1.time_ - 0) / var_136_3), Mathf.Lerp(iter_136_2.color.g, arg_133_1.hightColor1.g, (arg_133_1.time_ - 0) / var_136_3), (Mathf.Lerp(iter_136_2.color.b, arg_133_1.hightColor1.b, (arg_133_1.time_ - 0) / var_136_3)))
							else
								local var_136_4 = Mathf.Lerp(iter_136_2.color.r, 1, (arg_133_1.time_ - 0) / var_136_3)

								iter_136_2.color = Color.New(var_136_4, var_136_4, var_136_4)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_3 and arg_133_1.time_ < 0 + var_136_3 + arg_136_0 and not isNil(var_136_2) and arg_133_1.var_.actorSpriteComps10093 then
				for iter_136_3, iter_136_4 in pairs(arg_133_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_136_4 then
						iter_136_4.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_133_1.var_.actorSpriteComps10093 = nil
			end

			local var_136_5 = arg_133_1.actors_["10097"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_5) and arg_133_1.var_.actorSpriteComps10097 == nil then
				arg_133_1.var_.actorSpriteComps10097 = var_136_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_136_6 = 0.2

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_6 and not isNil(var_136_5) then
				if arg_133_1.var_.actorSpriteComps10097 then
					for iter_136_5, iter_136_6 in pairs(arg_133_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_136_6 then
							if arg_133_1.isInRecall_ then
								iter_136_6.color = Color.New(Mathf.Lerp(iter_136_6.color.r, arg_133_1.hightColor2.r, (arg_133_1.time_ - 0) / var_136_6), Mathf.Lerp(iter_136_6.color.g, arg_133_1.hightColor2.g, (arg_133_1.time_ - 0) / var_136_6), (Mathf.Lerp(iter_136_6.color.b, arg_133_1.hightColor2.b, (arg_133_1.time_ - 0) / var_136_6)))
							else
								local var_136_7 = Mathf.Lerp(iter_136_6.color.r, 0.5, (arg_133_1.time_ - 0) / var_136_6)

								iter_136_6.color = Color.New(var_136_7, var_136_7, var_136_7)
							end
						end
					end
				end
			end

			if arg_133_1.time_ >= 0 + var_136_6 and arg_133_1.time_ < 0 + var_136_6 + arg_136_0 and not isNil(var_136_5) and arg_133_1.var_.actorSpriteComps10097 then
				for iter_136_7, iter_136_8 in pairs(arg_133_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_136_8 then
						iter_136_8.color = arg_133_1.isInRecall_ and (arg_133_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_133_1.var_.actorSpriteComps10097 = nil
			end

			local var_136_8 = 0
			local var_136_9 = 0.35

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_8 + arg_136_0 then
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

				local var_136_10 = arg_133_1:GetWordFromCfg(413091031)
				local var_136_11 = arg_133_1:FormatText(var_136_10.content)

				arg_133_1.text_.text = var_136_11

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_13 = 14 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 14)

				if (14 <= 0 and var_136_9 or var_136_9 * (utf8.len(var_136_11) / 14)) > 0 and var_136_9 < var_136_13 then
					arg_133_1.talkMaxDuration = var_136_13

					if var_136_13 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_13 + var_136_8
					end
				end

				arg_133_1.text_.text = var_136_11
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091031", "story_v_out_413091.awb") ~= 0 then
					local var_136_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091031", "story_v_out_413091.awb") / 1000

					if var_136_14 + var_136_8 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_14 + var_136_8
					end

					if var_136_10.prefab_name ~= "" and arg_133_1.actors_[var_136_10.prefab_name] ~= nil then
						local var_136_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_10.prefab_name].transform, "story_v_out_413091", "413091031", "story_v_out_413091.awb")

						arg_133_1:RecordAudio("413091031", var_136_15)
						arg_133_1:RecordAudio("413091031", var_136_15)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_413091", "413091031", "story_v_out_413091.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_413091", "413091031", "story_v_out_413091.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_16 = math.max(var_136_9, arg_133_1.talkMaxDuration)

			if var_136_8 <= arg_133_1.time_ and arg_133_1.time_ < var_136_8 + var_136_16 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_8) / var_136_16

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_8 + var_136_16 and arg_133_1.time_ < var_136_8 + var_136_16 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
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

		arg_133_1:InitPlayNodeList()
	end,
	Play413091032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 413091032
		arg_137_1.duration_ = 12.73

		local var_137_0 = {
			zh = 7.533,
			ja = 12.733
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
				arg_137_0:Play413091033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos10097 = arg_137_1.actors_["10097"].transform.localPosition
				arg_137_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_137_1:CheckSpriteTmpPos("10097", 2)

				for iter_140_0 = 0, arg_137_1.actors_["10097"].transform.childCount - 1 do
					local var_140_0 = arg_137_1.actors_["10097"].transform:GetChild(iter_140_0)

					if var_140_0.name == "" or not string.find(var_140_0.name, "split") then
						var_140_0.gameObject:SetActive(true)
					else
						var_140_0.gameObject:SetActive(false)
					end
				end
			end

			local var_140_1 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_1 then
				arg_137_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_137_1.time_ - 0) / var_140_1)
			end

			if arg_137_1.time_ >= 0 + var_140_1 and arg_137_1.time_ < 0 + var_140_1 + arg_140_0 then
				arg_137_1.actors_["10097"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_140_2 = arg_137_1.actors_["10097"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps10097 == nil then
				arg_137_1.var_.actorSpriteComps10097 = var_140_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_3 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_3 and not isNil(var_140_2) then
				if arg_137_1.var_.actorSpriteComps10097 then
					for iter_140_1, iter_140_2 in pairs(arg_137_1.var_.actorSpriteComps10097:ToTable()) do
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

			if arg_137_1.time_ >= 0 + var_140_3 and arg_137_1.time_ < 0 + var_140_3 + arg_140_0 and not isNil(var_140_2) and arg_137_1.var_.actorSpriteComps10097 then
				for iter_140_3, iter_140_4 in pairs(arg_137_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_140_4 then
						iter_140_4.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_137_1.var_.actorSpriteComps10097 = nil
			end

			local var_140_5 = arg_137_1.actors_["10093"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.actorSpriteComps10093 == nil then
				arg_137_1.var_.actorSpriteComps10093 = var_140_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_140_6 = 0.2

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_6 and not isNil(var_140_5) then
				if arg_137_1.var_.actorSpriteComps10093 then
					for iter_140_5, iter_140_6 in pairs(arg_137_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_140_6 then
							if arg_137_1.isInRecall_ then
								iter_140_6.color = Color.New(Mathf.Lerp(iter_140_6.color.r, arg_137_1.hightColor2.r, (arg_137_1.time_ - 0) / var_140_6), Mathf.Lerp(iter_140_6.color.g, arg_137_1.hightColor2.g, (arg_137_1.time_ - 0) / var_140_6), (Mathf.Lerp(iter_140_6.color.b, arg_137_1.hightColor2.b, (arg_137_1.time_ - 0) / var_140_6)))
							else
								local var_140_7 = Mathf.Lerp(iter_140_6.color.r, 0.5, (arg_137_1.time_ - 0) / var_140_6)

								iter_140_6.color = Color.New(var_140_7, var_140_7, var_140_7)
							end
						end
					end
				end
			end

			if arg_137_1.time_ >= 0 + var_140_6 and arg_137_1.time_ < 0 + var_140_6 + arg_140_0 and not isNil(var_140_5) and arg_137_1.var_.actorSpriteComps10093 then
				for iter_140_7, iter_140_8 in pairs(arg_137_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_140_8 then
						iter_140_8.color = arg_137_1.isInRecall_ and (arg_137_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_137_1.var_.actorSpriteComps10093 = nil
			end

			local var_140_8 = 0
			local var_140_9 = 0.725

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_8 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_10 = arg_137_1:GetWordFromCfg(413091032)
				local var_140_11 = arg_137_1:FormatText(var_140_10.content)

				arg_137_1.text_.text = var_140_11

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_13 = 29 <= 0 and var_140_9 or var_140_9 * (utf8.len(var_140_11) / 29)

				if (29 <= 0 and var_140_9 or var_140_9 * (utf8.len(var_140_11) / 29)) > 0 and var_140_9 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_8
					end
				end

				arg_137_1.text_.text = var_140_11
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091032", "story_v_out_413091.awb") ~= 0 then
					local var_140_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091032", "story_v_out_413091.awb") / 1000

					if var_140_14 + var_140_8 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_14 + var_140_8
					end

					if var_140_10.prefab_name ~= "" and arg_137_1.actors_[var_140_10.prefab_name] ~= nil then
						local var_140_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_10.prefab_name].transform, "story_v_out_413091", "413091032", "story_v_out_413091.awb")

						arg_137_1:RecordAudio("413091032", var_140_15)
						arg_137_1:RecordAudio("413091032", var_140_15)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_413091", "413091032", "story_v_out_413091.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_413091", "413091032", "story_v_out_413091.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_16 = math.max(var_140_9, arg_137_1.talkMaxDuration)

			if var_140_8 <= arg_137_1.time_ and arg_137_1.time_ < var_140_8 + var_140_16 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_8) / var_140_16

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_8 + var_140_16 and arg_137_1.time_ < var_140_8 + var_140_16 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
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

		arg_137_1:InitPlayNodeList()
	end,
	Play413091033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 413091033
		arg_141_1.duration_ = 5.37

		local var_141_0 = {
			zh = 5.366,
			ja = 5.233
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
				arg_141_0:Play413091034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos10093 = arg_141_1.actors_["10093"].transform.localPosition
				arg_141_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("10093", 4)

				for iter_144_0 = 0, arg_141_1.actors_["10093"].transform.childCount - 1 do
					local var_144_0 = arg_141_1.actors_["10093"].transform:GetChild(iter_144_0)

					if var_144_0.name == "split_3" or not string.find(var_144_0.name, "split") then
						var_144_0.gameObject:SetActive(true)
					else
						var_144_0.gameObject:SetActive(false)
					end
				end
			end

			local var_144_1 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_1 then
				arg_141_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_141_1.time_ - 0) / var_144_1)
			end

			if arg_141_1.time_ >= 0 + var_144_1 and arg_141_1.time_ < 0 + var_144_1 + arg_144_0 then
				arg_141_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
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

			local var_144_5 = arg_141_1.actors_["10097"]

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.actorSpriteComps10097 == nil then
				arg_141_1.var_.actorSpriteComps10097 = var_144_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_6 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_6 and not isNil(var_144_5) then
				if arg_141_1.var_.actorSpriteComps10097 then
					for iter_144_5, iter_144_6 in pairs(arg_141_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_144_6 then
							if arg_141_1.isInRecall_ then
								iter_144_6.color = Color.New(Mathf.Lerp(iter_144_6.color.r, arg_141_1.hightColor2.r, (arg_141_1.time_ - 0) / var_144_6), Mathf.Lerp(iter_144_6.color.g, arg_141_1.hightColor2.g, (arg_141_1.time_ - 0) / var_144_6), (Mathf.Lerp(iter_144_6.color.b, arg_141_1.hightColor2.b, (arg_141_1.time_ - 0) / var_144_6)))
							else
								local var_144_7 = Mathf.Lerp(iter_144_6.color.r, 0.5, (arg_141_1.time_ - 0) / var_144_6)

								iter_144_6.color = Color.New(var_144_7, var_144_7, var_144_7)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_6 and arg_141_1.time_ < 0 + var_144_6 + arg_144_0 and not isNil(var_144_5) and arg_141_1.var_.actorSpriteComps10097 then
				for iter_144_7, iter_144_8 in pairs(arg_141_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_144_8 then
						iter_144_8.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_141_1.var_.actorSpriteComps10097 = nil
			end

			local var_144_8 = 0
			local var_144_9 = 0.825

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_8 + arg_144_0 then
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

				local var_144_10 = arg_141_1:GetWordFromCfg(413091033)
				local var_144_11 = arg_141_1:FormatText(var_144_10.content)

				arg_141_1.text_.text = var_144_11

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_13 = 33 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_11) / 33)

				if (33 <= 0 and var_144_9 or var_144_9 * (utf8.len(var_144_11) / 33)) > 0 and var_144_9 < var_144_13 then
					arg_141_1.talkMaxDuration = var_144_13

					if var_144_13 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_13 + var_144_8
					end
				end

				arg_141_1.text_.text = var_144_11
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091033", "story_v_out_413091.awb") ~= 0 then
					local var_144_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091033", "story_v_out_413091.awb") / 1000

					if var_144_14 + var_144_8 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_14 + var_144_8
					end

					if var_144_10.prefab_name ~= "" and arg_141_1.actors_[var_144_10.prefab_name] ~= nil then
						local var_144_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_10.prefab_name].transform, "story_v_out_413091", "413091033", "story_v_out_413091.awb")

						arg_141_1:RecordAudio("413091033", var_144_15)
						arg_141_1:RecordAudio("413091033", var_144_15)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_413091", "413091033", "story_v_out_413091.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_413091", "413091033", "story_v_out_413091.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_16 = math.max(var_144_9, arg_141_1.talkMaxDuration)

			if var_144_8 <= arg_141_1.time_ and arg_141_1.time_ < var_144_8 + var_144_16 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_8) / var_144_16

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_8 + var_144_16 and arg_141_1.time_ < var_144_8 + var_144_16 + arg_144_0 then
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
	Play413091034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 413091034
		arg_145_1.duration_ = 7.5

		local var_145_0 = {
			zh = 7.066,
			ja = 7.5
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
				arg_145_0:Play413091035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10097 = arg_145_1.actors_["10097"].transform.localPosition
				arg_145_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_145_1:CheckSpriteTmpPos("10097", 2)

				for iter_148_0 = 0, arg_145_1.actors_["10097"].transform.childCount - 1 do
					local var_148_0 = arg_145_1.actors_["10097"].transform:GetChild(iter_148_0)

					if var_148_0.name == "split_4" or not string.find(var_148_0.name, "split") then
						var_148_0.gameObject:SetActive(true)
					else
						var_148_0.gameObject:SetActive(false)
					end
				end
			end

			local var_148_1 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_1 then
				arg_145_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_145_1.time_ - 0) / var_148_1)
			end

			if arg_145_1.time_ >= 0 + var_148_1 and arg_145_1.time_ < 0 + var_148_1 + arg_148_0 then
				arg_145_1.actors_["10097"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_148_2 = arg_145_1.actors_["10097"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps10097 == nil then
				arg_145_1.var_.actorSpriteComps10097 = var_148_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_3 = 2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_3 and not isNil(var_148_2) then
				if arg_145_1.var_.actorSpriteComps10097 then
					for iter_148_1, iter_148_2 in pairs(arg_145_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_148_2 then
							if arg_145_1.isInRecall_ then
								iter_148_2.color = Color.New(Mathf.Lerp(iter_148_2.color.r, arg_145_1.hightColor1.r, (arg_145_1.time_ - 0) / var_148_3), Mathf.Lerp(iter_148_2.color.g, arg_145_1.hightColor1.g, (arg_145_1.time_ - 0) / var_148_3), (Mathf.Lerp(iter_148_2.color.b, arg_145_1.hightColor1.b, (arg_145_1.time_ - 0) / var_148_3)))
							else
								local var_148_4 = Mathf.Lerp(iter_148_2.color.r, 1, (arg_145_1.time_ - 0) / var_148_3)

								iter_148_2.color = Color.New(var_148_4, var_148_4, var_148_4)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_3 and arg_145_1.time_ < 0 + var_148_3 + arg_148_0 and not isNil(var_148_2) and arg_145_1.var_.actorSpriteComps10097 then
				for iter_148_3, iter_148_4 in pairs(arg_145_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_148_4 then
						iter_148_4.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_145_1.var_.actorSpriteComps10097 = nil
			end

			local var_148_5 = arg_145_1.actors_["10093"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.actorSpriteComps10093 == nil then
				arg_145_1.var_.actorSpriteComps10093 = var_148_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_148_6 = 0.2

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_6 and not isNil(var_148_5) then
				if arg_145_1.var_.actorSpriteComps10093 then
					for iter_148_5, iter_148_6 in pairs(arg_145_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_148_6 then
							if arg_145_1.isInRecall_ then
								iter_148_6.color = Color.New(Mathf.Lerp(iter_148_6.color.r, arg_145_1.hightColor2.r, (arg_145_1.time_ - 0) / var_148_6), Mathf.Lerp(iter_148_6.color.g, arg_145_1.hightColor2.g, (arg_145_1.time_ - 0) / var_148_6), (Mathf.Lerp(iter_148_6.color.b, arg_145_1.hightColor2.b, (arg_145_1.time_ - 0) / var_148_6)))
							else
								local var_148_7 = Mathf.Lerp(iter_148_6.color.r, 0.5, (arg_145_1.time_ - 0) / var_148_6)

								iter_148_6.color = Color.New(var_148_7, var_148_7, var_148_7)
							end
						end
					end
				end
			end

			if arg_145_1.time_ >= 0 + var_148_6 and arg_145_1.time_ < 0 + var_148_6 + arg_148_0 and not isNil(var_148_5) and arg_145_1.var_.actorSpriteComps10093 then
				for iter_148_7, iter_148_8 in pairs(arg_145_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_148_8 then
						iter_148_8.color = arg_145_1.isInRecall_ and (arg_145_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_145_1.var_.actorSpriteComps10093 = nil
			end

			local var_148_8 = 0
			local var_148_9 = 0.625

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_8 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_10 = arg_145_1:GetWordFromCfg(413091034)
				local var_148_11 = arg_145_1:FormatText(var_148_10.content)

				arg_145_1.text_.text = var_148_11

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_13 = 25 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 25)

				if (25 <= 0 and var_148_9 or var_148_9 * (utf8.len(var_148_11) / 25)) > 0 and var_148_9 < var_148_13 then
					arg_145_1.talkMaxDuration = var_148_13

					if var_148_13 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_13 + var_148_8
					end
				end

				arg_145_1.text_.text = var_148_11
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091034", "story_v_out_413091.awb") ~= 0 then
					local var_148_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091034", "story_v_out_413091.awb") / 1000

					if var_148_14 + var_148_8 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_14 + var_148_8
					end

					if var_148_10.prefab_name ~= "" and arg_145_1.actors_[var_148_10.prefab_name] ~= nil then
						local var_148_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_10.prefab_name].transform, "story_v_out_413091", "413091034", "story_v_out_413091.awb")

						arg_145_1:RecordAudio("413091034", var_148_15)
						arg_145_1:RecordAudio("413091034", var_148_15)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_413091", "413091034", "story_v_out_413091.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_413091", "413091034", "story_v_out_413091.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_16 = math.max(var_148_9, arg_145_1.talkMaxDuration)

			if var_148_8 <= arg_145_1.time_ and arg_145_1.time_ < var_148_8 + var_148_16 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_8) / var_148_16

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_8 + var_148_16 and arg_145_1.time_ < var_148_8 + var_148_16 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
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

		arg_145_1:InitPlayNodeList()
	end,
	Play413091035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 413091035
		arg_149_1.duration_ = 8.3

		local var_149_0 = {
			zh = 5.233,
			ja = 8.3
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
				arg_149_0:Play413091036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.45

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:GetWordFromCfg(413091035)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.text_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_4 = 18 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 18)

				if (18 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_2) / 18)) > 0 and var_152_0 < var_152_4 then
					arg_149_1.talkMaxDuration = var_152_4

					if var_152_4 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_4 + 0
					end
				end

				arg_149_1.text_.text = var_152_2
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091035", "story_v_out_413091.awb") ~= 0 then
					local var_152_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091035", "story_v_out_413091.awb") / 1000

					if var_152_5 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_5 + 0
					end

					if var_152_1.prefab_name ~= "" and arg_149_1.actors_[var_152_1.prefab_name] ~= nil then
						local var_152_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_1.prefab_name].transform, "story_v_out_413091", "413091035", "story_v_out_413091.awb")

						arg_149_1:RecordAudio("413091035", var_152_6)
						arg_149_1:RecordAudio("413091035", var_152_6)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_413091", "413091035", "story_v_out_413091.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_413091", "413091035", "story_v_out_413091.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_7 and arg_149_1.time_ < 0 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play413091036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 413091036
		arg_153_1.duration_ = 5.7

		local var_153_0 = {
			zh = 3.5,
			ja = 5.7
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
				arg_153_0:Play413091037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos10093 = arg_153_1.actors_["10093"].transform.localPosition
				arg_153_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_153_1:CheckSpriteTmpPos("10093", 4)

				for iter_156_0 = 0, arg_153_1.actors_["10093"].transform.childCount - 1 do
					local var_156_0 = arg_153_1.actors_["10093"].transform:GetChild(iter_156_0)

					if var_156_0.name == "split_7" or not string.find(var_156_0.name, "split") then
						var_156_0.gameObject:SetActive(true)
					else
						var_156_0.gameObject:SetActive(false)
					end
				end
			end

			local var_156_1 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_1 then
				arg_153_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_153_1.time_ - 0) / var_156_1)
			end

			if arg_153_1.time_ >= 0 + var_156_1 and arg_153_1.time_ < 0 + var_156_1 + arg_156_0 then
				arg_153_1.actors_["10093"].transform.localPosition = Vector3.New(390, -345, -245)
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

			local var_156_5 = arg_153_1.actors_["10097"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.actorSpriteComps10097 == nil then
				arg_153_1.var_.actorSpriteComps10097 = var_156_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_6 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_6 and not isNil(var_156_5) then
				if arg_153_1.var_.actorSpriteComps10097 then
					for iter_156_5, iter_156_6 in pairs(arg_153_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_156_6 then
							if arg_153_1.isInRecall_ then
								iter_156_6.color = Color.New(Mathf.Lerp(iter_156_6.color.r, arg_153_1.hightColor2.r, (arg_153_1.time_ - 0) / var_156_6), Mathf.Lerp(iter_156_6.color.g, arg_153_1.hightColor2.g, (arg_153_1.time_ - 0) / var_156_6), (Mathf.Lerp(iter_156_6.color.b, arg_153_1.hightColor2.b, (arg_153_1.time_ - 0) / var_156_6)))
							else
								local var_156_7 = Mathf.Lerp(iter_156_6.color.r, 0.5, (arg_153_1.time_ - 0) / var_156_6)

								iter_156_6.color = Color.New(var_156_7, var_156_7, var_156_7)
							end
						end
					end
				end
			end

			if arg_153_1.time_ >= 0 + var_156_6 and arg_153_1.time_ < 0 + var_156_6 + arg_156_0 and not isNil(var_156_5) and arg_153_1.var_.actorSpriteComps10097 then
				for iter_156_7, iter_156_8 in pairs(arg_153_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_156_8 then
						iter_156_8.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_153_1.var_.actorSpriteComps10097 = nil
			end

			local var_156_8 = 0
			local var_156_9 = 0.475

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_8 + arg_156_0 then
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

				local var_156_10 = arg_153_1:GetWordFromCfg(413091036)
				local var_156_11 = arg_153_1:FormatText(var_156_10.content)

				arg_153_1.text_.text = var_156_11

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_13 = 19 <= 0 and var_156_9 or var_156_9 * (utf8.len(var_156_11) / 19)

				if (19 <= 0 and var_156_9 or var_156_9 * (utf8.len(var_156_11) / 19)) > 0 and var_156_9 < var_156_13 then
					arg_153_1.talkMaxDuration = var_156_13

					if var_156_13 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_13 + var_156_8
					end
				end

				arg_153_1.text_.text = var_156_11
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091036", "story_v_out_413091.awb") ~= 0 then
					local var_156_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091036", "story_v_out_413091.awb") / 1000

					if var_156_14 + var_156_8 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_14 + var_156_8
					end

					if var_156_10.prefab_name ~= "" and arg_153_1.actors_[var_156_10.prefab_name] ~= nil then
						local var_156_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_10.prefab_name].transform, "story_v_out_413091", "413091036", "story_v_out_413091.awb")

						arg_153_1:RecordAudio("413091036", var_156_15)
						arg_153_1:RecordAudio("413091036", var_156_15)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_413091", "413091036", "story_v_out_413091.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_413091", "413091036", "story_v_out_413091.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_16 = math.max(var_156_9, arg_153_1.talkMaxDuration)

			if var_156_8 <= arg_153_1.time_ and arg_153_1.time_ < var_156_8 + var_156_16 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_8) / var_156_16

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_8 + var_156_16 and arg_153_1.time_ < var_156_8 + var_156_16 + arg_156_0 then
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
	Play413091037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 413091037
		arg_157_1.duration_ = 7.3

		local var_157_0 = {
			zh = 7.3,
			ja = 5.166
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
				arg_157_0:Play413091038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos10097 = arg_157_1.actors_["10097"].transform.localPosition
				arg_157_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("10097", 2)

				for iter_160_0 = 0, arg_157_1.actors_["10097"].transform.childCount - 1 do
					local var_160_0 = arg_157_1.actors_["10097"].transform:GetChild(iter_160_0)

					if var_160_0.name == "split_4" or not string.find(var_160_0.name, "split") then
						var_160_0.gameObject:SetActive(true)
					else
						var_160_0.gameObject:SetActive(false)
					end
				end
			end

			local var_160_1 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_1 then
				arg_157_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_157_1.time_ - 0) / var_160_1)
			end

			if arg_157_1.time_ >= 0 + var_160_1 and arg_157_1.time_ < 0 + var_160_1 + arg_160_0 then
				arg_157_1.actors_["10097"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_160_2 = arg_157_1.actors_["10097"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps10097 == nil then
				arg_157_1.var_.actorSpriteComps10097 = var_160_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_3 = 2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_3 and not isNil(var_160_2) then
				if arg_157_1.var_.actorSpriteComps10097 then
					for iter_160_1, iter_160_2 in pairs(arg_157_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_160_2 then
							if arg_157_1.isInRecall_ then
								iter_160_2.color = Color.New(Mathf.Lerp(iter_160_2.color.r, arg_157_1.hightColor1.r, (arg_157_1.time_ - 0) / var_160_3), Mathf.Lerp(iter_160_2.color.g, arg_157_1.hightColor1.g, (arg_157_1.time_ - 0) / var_160_3), (Mathf.Lerp(iter_160_2.color.b, arg_157_1.hightColor1.b, (arg_157_1.time_ - 0) / var_160_3)))
							else
								local var_160_4 = Mathf.Lerp(iter_160_2.color.r, 1, (arg_157_1.time_ - 0) / var_160_3)

								iter_160_2.color = Color.New(var_160_4, var_160_4, var_160_4)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_3 and arg_157_1.time_ < 0 + var_160_3 + arg_160_0 and not isNil(var_160_2) and arg_157_1.var_.actorSpriteComps10097 then
				for iter_160_3, iter_160_4 in pairs(arg_157_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_160_4 then
						iter_160_4.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_157_1.var_.actorSpriteComps10097 = nil
			end

			local var_160_5 = arg_157_1.actors_["10093"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.actorSpriteComps10093 == nil then
				arg_157_1.var_.actorSpriteComps10093 = var_160_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_6 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_6 and not isNil(var_160_5) then
				if arg_157_1.var_.actorSpriteComps10093 then
					for iter_160_5, iter_160_6 in pairs(arg_157_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_160_6 then
							if arg_157_1.isInRecall_ then
								iter_160_6.color = Color.New(Mathf.Lerp(iter_160_6.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 0) / var_160_6), Mathf.Lerp(iter_160_6.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 0) / var_160_6), (Mathf.Lerp(iter_160_6.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 0) / var_160_6)))
							else
								local var_160_7 = Mathf.Lerp(iter_160_6.color.r, 0.5, (arg_157_1.time_ - 0) / var_160_6)

								iter_160_6.color = Color.New(var_160_7, var_160_7, var_160_7)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_6 and arg_157_1.time_ < 0 + var_160_6 + arg_160_0 and not isNil(var_160_5) and arg_157_1.var_.actorSpriteComps10093 then
				for iter_160_7, iter_160_8 in pairs(arg_157_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_160_8 then
						iter_160_8.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps10093 = nil
			end

			local var_160_8 = 0
			local var_160_9 = 0.5

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_8 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_10 = arg_157_1:GetWordFromCfg(413091037)
				local var_160_11 = arg_157_1:FormatText(var_160_10.content)

				arg_157_1.text_.text = var_160_11

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_13 = 20 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 20)

				if (20 <= 0 and var_160_9 or var_160_9 * (utf8.len(var_160_11) / 20)) > 0 and var_160_9 < var_160_13 then
					arg_157_1.talkMaxDuration = var_160_13

					if var_160_13 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_13 + var_160_8
					end
				end

				arg_157_1.text_.text = var_160_11
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091037", "story_v_out_413091.awb") ~= 0 then
					local var_160_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091037", "story_v_out_413091.awb") / 1000

					if var_160_14 + var_160_8 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_14 + var_160_8
					end

					if var_160_10.prefab_name ~= "" and arg_157_1.actors_[var_160_10.prefab_name] ~= nil then
						local var_160_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_10.prefab_name].transform, "story_v_out_413091", "413091037", "story_v_out_413091.awb")

						arg_157_1:RecordAudio("413091037", var_160_15)
						arg_157_1:RecordAudio("413091037", var_160_15)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_413091", "413091037", "story_v_out_413091.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_413091", "413091037", "story_v_out_413091.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = math.max(var_160_9, arg_157_1.talkMaxDuration)

			if var_160_8 <= arg_157_1.time_ and arg_157_1.time_ < var_160_8 + var_160_16 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_8) / var_160_16

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_8 + var_160_16 and arg_157_1.time_ < var_160_8 + var_160_16 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
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

		arg_157_1:InitPlayNodeList()
	end,
	Play413091038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 413091038
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play413091039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10093 = arg_161_1.actors_["10093"].transform.localPosition
				arg_161_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10093", 6)

				for iter_164_0 = 0, arg_161_1.actors_["10093"].transform.childCount - 1 do
					local var_164_0 = arg_161_1.actors_["10093"].transform:GetChild(iter_164_0)

					if var_164_0.name == "" or not string.find(var_164_0.name, "split") then
						var_164_0.gameObject:SetActive(true)
					else
						var_164_0.gameObject:SetActive(false)
					end
				end
			end

			local var_164_1 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 then
				arg_161_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10093, Vector3.New(1500, -345, -245), (arg_161_1.time_ - 0) / var_164_1)
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 then
				arg_161_1.actors_["10093"].transform.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_164_2 = arg_161_1.actors_["10097"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10097 = var_164_2.localPosition
				var_164_2.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("10097", 6)

				for iter_164_1 = 0, var_164_2.childCount - 1 do
					local var_164_3 = var_164_2:GetChild(iter_164_1)

					if var_164_3.name == "" or not string.find(var_164_3.name, "split") then
						var_164_3.gameObject:SetActive(true)
					else
						var_164_3.gameObject:SetActive(false)
					end
				end
			end

			local var_164_4 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				var_164_2.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10097, Vector3.New(1500, -350, -180), (arg_161_1.time_ - 0) / var_164_4)
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				var_164_2.localPosition = Vector3.New(1500, -350, -180)
			end

			local var_164_5 = arg_161_1.actors_["10093"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.actorSpriteComps10093 == nil then
				arg_161_1.var_.actorSpriteComps10093 = var_164_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_6 = 2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_6 and not isNil(var_164_5) then
				if arg_161_1.var_.actorSpriteComps10093 then
					for iter_164_2, iter_164_3 in pairs(arg_161_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_164_3 then
							if arg_161_1.isInRecall_ then
								iter_164_3.color = Color.New(Mathf.Lerp(iter_164_3.color.r, arg_161_1.hightColor2.r, (arg_161_1.time_ - 0) / var_164_6), Mathf.Lerp(iter_164_3.color.g, arg_161_1.hightColor2.g, (arg_161_1.time_ - 0) / var_164_6), (Mathf.Lerp(iter_164_3.color.b, arg_161_1.hightColor2.b, (arg_161_1.time_ - 0) / var_164_6)))
							else
								local var_164_7 = Mathf.Lerp(iter_164_3.color.r, 0.5, (arg_161_1.time_ - 0) / var_164_6)

								iter_164_3.color = Color.New(var_164_7, var_164_7, var_164_7)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_6 and arg_161_1.time_ < 0 + var_164_6 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.actorSpriteComps10093 then
				for iter_164_4, iter_164_5 in pairs(arg_161_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_164_5 then
						iter_164_5.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_161_1.var_.actorSpriteComps10093 = nil
			end

			local var_164_8 = arg_161_1.actors_["10097"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.actorSpriteComps10097 == nil then
				arg_161_1.var_.actorSpriteComps10097 = var_164_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_164_9 = 2

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_9 and not isNil(var_164_8) then
				if arg_161_1.var_.actorSpriteComps10097 then
					for iter_164_6, iter_164_7 in pairs(arg_161_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_164_7 then
							if arg_161_1.isInRecall_ then
								iter_164_7.color = Color.New(Mathf.Lerp(iter_164_7.color.r, arg_161_1.hightColor2.r, (arg_161_1.time_ - 0) / var_164_9), Mathf.Lerp(iter_164_7.color.g, arg_161_1.hightColor2.g, (arg_161_1.time_ - 0) / var_164_9), (Mathf.Lerp(iter_164_7.color.b, arg_161_1.hightColor2.b, (arg_161_1.time_ - 0) / var_164_9)))
							else
								local var_164_10 = Mathf.Lerp(iter_164_7.color.r, 0.5, (arg_161_1.time_ - 0) / var_164_9)

								iter_164_7.color = Color.New(var_164_10, var_164_10, var_164_10)
							end
						end
					end
				end
			end

			if arg_161_1.time_ >= 0 + var_164_9 and arg_161_1.time_ < 0 + var_164_9 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.actorSpriteComps10097 then
				for iter_164_8, iter_164_9 in pairs(arg_161_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_164_9 then
						iter_164_9.color = arg_161_1.isInRecall_ and (arg_161_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_161_1.var_.actorSpriteComps10097 = nil
			end

			local var_164_11 = 0
			local var_164_12 = 1.025

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_11 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_13 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(413091038).content)

				arg_161_1.text_.text = var_164_13

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_15 = 41 <= 0 and var_164_12 or var_164_12 * (utf8.len(var_164_13) / 41)

				if (41 <= 0 and var_164_12 or var_164_12 * (utf8.len(var_164_13) / 41)) > 0 and var_164_12 < var_164_15 then
					arg_161_1.talkMaxDuration = var_164_15

					if var_164_15 + var_164_11 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_15 + var_164_11
					end
				end

				arg_161_1.text_.text = var_164_13
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_12, arg_161_1.talkMaxDuration)

			if var_164_11 <= arg_161_1.time_ and arg_161_1.time_ < var_164_11 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_11) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_11 + var_164_16 and arg_161_1.time_ < var_164_11 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
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
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play413091039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 413091039
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play413091040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 1.3

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(413091039).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 52 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 52)

				if (52 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 52)) > 0 and var_168_0 < var_168_3 then
					arg_165_1.talkMaxDuration = var_168_3

					if var_168_3 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_3 + 0
					end
				end

				arg_165_1.text_.text = var_168_1
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_4 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_4

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play413091040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 413091040
		arg_169_1.duration_ = 3.7

		local var_169_0 = {
			zh = 3.1,
			ja = 3.7
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
				arg_169_0:Play413091041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10093 = arg_169_1.actors_["10093"].transform.localPosition
				arg_169_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10093", 2)

				for iter_172_0 = 0, arg_169_1.actors_["10093"].transform.childCount - 1 do
					local var_172_0 = arg_169_1.actors_["10093"].transform:GetChild(iter_172_0)

					if var_172_0.name == "split_5" or not string.find(var_172_0.name, "split") then
						var_172_0.gameObject:SetActive(true)
					else
						var_172_0.gameObject:SetActive(false)
					end
				end
			end

			local var_172_1 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_1 then
				arg_169_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_169_1.time_ - 0) / var_172_1)
			end

			if arg_169_1.time_ >= 0 + var_172_1 and arg_169_1.time_ < 0 + var_172_1 + arg_172_0 then
				arg_169_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_172_2 = arg_169_1.actors_["10097"].transform

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10097 = var_172_2.localPosition
				var_172_2.localScale = Vector3.New(1, 1, 1)

				arg_169_1:CheckSpriteTmpPos("10097", 7)

				for iter_172_1 = 0, var_172_2.childCount - 1 do
					local var_172_3 = var_172_2:GetChild(iter_172_1)

					if var_172_3.name == "split_1" or not string.find(var_172_3.name, "split") then
						var_172_3.gameObject:SetActive(true)
					else
						var_172_3.gameObject:SetActive(false)
					end
				end
			end

			local var_172_4 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				var_172_2.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10097, Vector3.New(0, -2000, -180), (arg_169_1.time_ - 0) / var_172_4)
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				var_172_2.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_172_5 = arg_169_1.actors_["10093"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.actorSpriteComps10093 == nil then
				arg_169_1.var_.actorSpriteComps10093 = var_172_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_6 = 2

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_6 and not isNil(var_172_5) then
				if arg_169_1.var_.actorSpriteComps10093 then
					for iter_172_2, iter_172_3 in pairs(arg_169_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_172_3 then
							if arg_169_1.isInRecall_ then
								iter_172_3.color = Color.New(Mathf.Lerp(iter_172_3.color.r, arg_169_1.hightColor1.r, (arg_169_1.time_ - 0) / var_172_6), Mathf.Lerp(iter_172_3.color.g, arg_169_1.hightColor1.g, (arg_169_1.time_ - 0) / var_172_6), (Mathf.Lerp(iter_172_3.color.b, arg_169_1.hightColor1.b, (arg_169_1.time_ - 0) / var_172_6)))
							else
								local var_172_7 = Mathf.Lerp(iter_172_3.color.r, 1, (arg_169_1.time_ - 0) / var_172_6)

								iter_172_3.color = Color.New(var_172_7, var_172_7, var_172_7)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_6 and arg_169_1.time_ < 0 + var_172_6 + arg_172_0 and not isNil(var_172_5) and arg_169_1.var_.actorSpriteComps10093 then
				for iter_172_4, iter_172_5 in pairs(arg_169_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_172_5 then
						iter_172_5.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_169_1.var_.actorSpriteComps10093 = nil
			end

			local var_172_8 = arg_169_1.actors_["10097"]

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 and not isNil(var_172_8) and arg_169_1.var_.actorSpriteComps10097 == nil then
				arg_169_1.var_.actorSpriteComps10097 = var_172_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_172_9 = 2

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_9 and not isNil(var_172_8) then
				if arg_169_1.var_.actorSpriteComps10097 then
					for iter_172_6, iter_172_7 in pairs(arg_169_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_172_7 then
							if arg_169_1.isInRecall_ then
								iter_172_7.color = Color.New(Mathf.Lerp(iter_172_7.color.r, arg_169_1.hightColor2.r, (arg_169_1.time_ - 0) / var_172_9), Mathf.Lerp(iter_172_7.color.g, arg_169_1.hightColor2.g, (arg_169_1.time_ - 0) / var_172_9), (Mathf.Lerp(iter_172_7.color.b, arg_169_1.hightColor2.b, (arg_169_1.time_ - 0) / var_172_9)))
							else
								local var_172_10 = Mathf.Lerp(iter_172_7.color.r, 0.5, (arg_169_1.time_ - 0) / var_172_9)

								iter_172_7.color = Color.New(var_172_10, var_172_10, var_172_10)
							end
						end
					end
				end
			end

			if arg_169_1.time_ >= 0 + var_172_9 and arg_169_1.time_ < 0 + var_172_9 + arg_172_0 and not isNil(var_172_8) and arg_169_1.var_.actorSpriteComps10097 then
				for iter_172_8, iter_172_9 in pairs(arg_169_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_172_9 then
						iter_172_9.color = arg_169_1.isInRecall_ and (arg_169_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_169_1.var_.actorSpriteComps10097 = nil
			end

			local var_172_11 = 0
			local var_172_12 = 0.375

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_11 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_13 = arg_169_1:GetWordFromCfg(413091040)
				local var_172_14 = arg_169_1:FormatText(var_172_13.content)

				arg_169_1.text_.text = var_172_14

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_16 = 15 <= 0 and var_172_12 or var_172_12 * (utf8.len(var_172_14) / 15)

				if (15 <= 0 and var_172_12 or var_172_12 * (utf8.len(var_172_14) / 15)) > 0 and var_172_12 < var_172_16 then
					arg_169_1.talkMaxDuration = var_172_16

					if var_172_16 + var_172_11 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_16 + var_172_11
					end
				end

				arg_169_1.text_.text = var_172_14
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091040", "story_v_out_413091.awb") ~= 0 then
					local var_172_17 = manager.audio:GetVoiceLength("story_v_out_413091", "413091040", "story_v_out_413091.awb") / 1000

					if var_172_17 + var_172_11 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_17 + var_172_11
					end

					if var_172_13.prefab_name ~= "" and arg_169_1.actors_[var_172_13.prefab_name] ~= nil then
						local var_172_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_13.prefab_name].transform, "story_v_out_413091", "413091040", "story_v_out_413091.awb")

						arg_169_1:RecordAudio("413091040", var_172_18)
						arg_169_1:RecordAudio("413091040", var_172_18)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_413091", "413091040", "story_v_out_413091.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_413091", "413091040", "story_v_out_413091.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_19 = math.max(var_172_12, arg_169_1.talkMaxDuration)

			if var_172_11 <= arg_169_1.time_ and arg_169_1.time_ < var_172_11 + var_172_19 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_11) / var_172_19

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_11 + var_172_19 and arg_169_1.time_ < var_172_11 + var_172_19 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
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
				actorName = "10097",
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
	Play413091041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 413091041
		arg_173_1.duration_ = 10.6

		local var_173_0 = {
			zh = 10.6,
			ja = 7.066
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
				arg_173_0:Play413091042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10097 = arg_173_1.actors_["10097"].transform.localPosition
				arg_173_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("10097", 4)

				for iter_176_0 = 0, arg_173_1.actors_["10097"].transform.childCount - 1 do
					local var_176_0 = arg_173_1.actors_["10097"].transform:GetChild(iter_176_0)

					if var_176_0.name == "split_1" or not string.find(var_176_0.name, "split") then
						var_176_0.gameObject:SetActive(true)
					else
						var_176_0.gameObject:SetActive(false)
					end
				end
			end

			local var_176_1 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_1 then
				arg_173_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_173_1.time_ - 0) / var_176_1)
			end

			if arg_173_1.time_ >= 0 + var_176_1 and arg_173_1.time_ < 0 + var_176_1 + arg_176_0 then
				arg_173_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_176_2 = arg_173_1.actors_["10097"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps10097 == nil then
				arg_173_1.var_.actorSpriteComps10097 = var_176_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_3 = 2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_3 and not isNil(var_176_2) then
				if arg_173_1.var_.actorSpriteComps10097 then
					for iter_176_1, iter_176_2 in pairs(arg_173_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_176_2 then
							if arg_173_1.isInRecall_ then
								iter_176_2.color = Color.New(Mathf.Lerp(iter_176_2.color.r, arg_173_1.hightColor1.r, (arg_173_1.time_ - 0) / var_176_3), Mathf.Lerp(iter_176_2.color.g, arg_173_1.hightColor1.g, (arg_173_1.time_ - 0) / var_176_3), (Mathf.Lerp(iter_176_2.color.b, arg_173_1.hightColor1.b, (arg_173_1.time_ - 0) / var_176_3)))
							else
								local var_176_4 = Mathf.Lerp(iter_176_2.color.r, 1, (arg_173_1.time_ - 0) / var_176_3)

								iter_176_2.color = Color.New(var_176_4, var_176_4, var_176_4)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_3 and arg_173_1.time_ < 0 + var_176_3 + arg_176_0 and not isNil(var_176_2) and arg_173_1.var_.actorSpriteComps10097 then
				for iter_176_3, iter_176_4 in pairs(arg_173_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_176_4 then
						iter_176_4.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_173_1.var_.actorSpriteComps10097 = nil
			end

			local var_176_5 = arg_173_1.actors_["10093"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_5) and arg_173_1.var_.actorSpriteComps10093 == nil then
				arg_173_1.var_.actorSpriteComps10093 = var_176_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_176_6 = 0.2

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_6 and not isNil(var_176_5) then
				if arg_173_1.var_.actorSpriteComps10093 then
					for iter_176_5, iter_176_6 in pairs(arg_173_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_176_6 then
							if arg_173_1.isInRecall_ then
								iter_176_6.color = Color.New(Mathf.Lerp(iter_176_6.color.r, arg_173_1.hightColor2.r, (arg_173_1.time_ - 0) / var_176_6), Mathf.Lerp(iter_176_6.color.g, arg_173_1.hightColor2.g, (arg_173_1.time_ - 0) / var_176_6), (Mathf.Lerp(iter_176_6.color.b, arg_173_1.hightColor2.b, (arg_173_1.time_ - 0) / var_176_6)))
							else
								local var_176_7 = Mathf.Lerp(iter_176_6.color.r, 0.5, (arg_173_1.time_ - 0) / var_176_6)

								iter_176_6.color = Color.New(var_176_7, var_176_7, var_176_7)
							end
						end
					end
				end
			end

			if arg_173_1.time_ >= 0 + var_176_6 and arg_173_1.time_ < 0 + var_176_6 + arg_176_0 and not isNil(var_176_5) and arg_173_1.var_.actorSpriteComps10093 then
				for iter_176_7, iter_176_8 in pairs(arg_173_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_176_8 then
						iter_176_8.color = arg_173_1.isInRecall_ and (arg_173_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_173_1.var_.actorSpriteComps10093 = nil
			end

			local var_176_8 = 0
			local var_176_9 = 0.725

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_10 = arg_173_1:GetWordFromCfg(413091041)
				local var_176_11 = arg_173_1:FormatText(var_176_10.content)

				arg_173_1.text_.text = var_176_11

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_13 = 29 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 29)

				if (29 <= 0 and var_176_9 or var_176_9 * (utf8.len(var_176_11) / 29)) > 0 and var_176_9 < var_176_13 then
					arg_173_1.talkMaxDuration = var_176_13

					if var_176_13 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_13 + var_176_8
					end
				end

				arg_173_1.text_.text = var_176_11
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091041", "story_v_out_413091.awb") ~= 0 then
					local var_176_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091041", "story_v_out_413091.awb") / 1000

					if var_176_14 + var_176_8 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_14 + var_176_8
					end

					if var_176_10.prefab_name ~= "" and arg_173_1.actors_[var_176_10.prefab_name] ~= nil then
						local var_176_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_10.prefab_name].transform, "story_v_out_413091", "413091041", "story_v_out_413091.awb")

						arg_173_1:RecordAudio("413091041", var_176_15)
						arg_173_1:RecordAudio("413091041", var_176_15)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_413091", "413091041", "story_v_out_413091.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_413091", "413091041", "story_v_out_413091.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_16 = math.max(var_176_9, arg_173_1.talkMaxDuration)

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_16 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_8) / var_176_16

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_8 + var_176_16 and arg_173_1.time_ < var_176_8 + var_176_16 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
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

		arg_173_1:InitPlayNodeList()
	end,
	Play413091042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 413091042
		arg_177_1.duration_ = 10.57

		local var_177_0 = {
			zh = 5.5,
			ja = 10.566
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
				arg_177_0:Play413091043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0.5

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_1 = arg_177_1:GetWordFromCfg(413091042)
				local var_180_2 = arg_177_1:FormatText(var_180_1.content)

				arg_177_1.text_.text = var_180_2

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_4 = 20 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 20)

				if (20 <= 0 and var_180_0 or var_180_0 * (utf8.len(var_180_2) / 20)) > 0 and var_180_0 < var_180_4 then
					arg_177_1.talkMaxDuration = var_180_4

					if var_180_4 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_4 + 0
					end
				end

				arg_177_1.text_.text = var_180_2
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091042", "story_v_out_413091.awb") ~= 0 then
					local var_180_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091042", "story_v_out_413091.awb") / 1000

					if var_180_5 + 0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + 0
					end

					if var_180_1.prefab_name ~= "" and arg_177_1.actors_[var_180_1.prefab_name] ~= nil then
						local var_180_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_1.prefab_name].transform, "story_v_out_413091", "413091042", "story_v_out_413091.awb")

						arg_177_1:RecordAudio("413091042", var_180_6)
						arg_177_1:RecordAudio("413091042", var_180_6)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_413091", "413091042", "story_v_out_413091.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_413091", "413091042", "story_v_out_413091.awb")
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
	Play413091043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 413091043
		arg_181_1.duration_ = 7.83

		local var_181_0 = {
			zh = 7.833,
			ja = 7.766
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
				arg_181_0:Play413091044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos10097 = arg_181_1.actors_["10097"].transform.localPosition
				arg_181_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_181_1:CheckSpriteTmpPos("10097", 4)

				for iter_184_0 = 0, arg_181_1.actors_["10097"].transform.childCount - 1 do
					local var_184_0 = arg_181_1.actors_["10097"].transform:GetChild(iter_184_0)

					if var_184_0.name == "split_4" or not string.find(var_184_0.name, "split") then
						var_184_0.gameObject:SetActive(true)
					else
						var_184_0.gameObject:SetActive(false)
					end
				end
			end

			local var_184_1 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_1 then
				arg_181_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_181_1.time_ - 0) / var_184_1)
			end

			if arg_181_1.time_ >= 0 + var_184_1 and arg_181_1.time_ < 0 + var_184_1 + arg_184_0 then
				arg_181_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_184_2 = 0
			local var_184_3 = 0.6

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_2 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_4 = arg_181_1:GetWordFromCfg(413091043)
				local var_184_5 = arg_181_1:FormatText(var_184_4.content)

				arg_181_1.text_.text = var_184_5

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_7 = 24 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 24)

				if (24 <= 0 and var_184_3 or var_184_3 * (utf8.len(var_184_5) / 24)) > 0 and var_184_3 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_2
					end
				end

				arg_181_1.text_.text = var_184_5
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091043", "story_v_out_413091.awb") ~= 0 then
					local var_184_8 = manager.audio:GetVoiceLength("story_v_out_413091", "413091043", "story_v_out_413091.awb") / 1000

					if var_184_8 + var_184_2 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_2
					end

					if var_184_4.prefab_name ~= "" and arg_181_1.actors_[var_184_4.prefab_name] ~= nil then
						local var_184_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_4.prefab_name].transform, "story_v_out_413091", "413091043", "story_v_out_413091.awb")

						arg_181_1:RecordAudio("413091043", var_184_9)
						arg_181_1:RecordAudio("413091043", var_184_9)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_413091", "413091043", "story_v_out_413091.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_413091", "413091043", "story_v_out_413091.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_10 = math.max(var_184_3, arg_181_1.talkMaxDuration)

			if var_184_2 <= arg_181_1.time_ and arg_181_1.time_ < var_184_2 + var_184_10 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_2) / var_184_10

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_2 + var_184_10 and arg_181_1.time_ < var_184_2 + var_184_10 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
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

		arg_181_1:InitPlayNodeList()
	end,
	Play413091044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 413091044
		arg_185_1.duration_ = 4.33

		local var_185_0 = {
			zh = 2.8,
			ja = 4.333
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
				arg_185_0:Play413091045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos10093 = arg_185_1.actors_["10093"].transform.localPosition
				arg_185_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("10093", 2)

				for iter_188_0 = 0, arg_185_1.actors_["10093"].transform.childCount - 1 do
					local var_188_0 = arg_185_1.actors_["10093"].transform:GetChild(iter_188_0)

					if var_188_0.name == "split_5" or not string.find(var_188_0.name, "split") then
						var_188_0.gameObject:SetActive(true)
					else
						var_188_0.gameObject:SetActive(false)
					end
				end
			end

			local var_188_1 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_185_1.time_ - 0) / var_188_1)
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_188_2 = arg_185_1.actors_["10093"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps10093 == nil then
				arg_185_1.var_.actorSpriteComps10093 = var_188_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_3 = 2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_3 and not isNil(var_188_2) then
				if arg_185_1.var_.actorSpriteComps10093 then
					for iter_188_1, iter_188_2 in pairs(arg_185_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_185_1.time_ >= 0 + var_188_3 and arg_185_1.time_ < 0 + var_188_3 + arg_188_0 and not isNil(var_188_2) and arg_185_1.var_.actorSpriteComps10093 then
				for iter_188_3, iter_188_4 in pairs(arg_185_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_188_4 then
						iter_188_4.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_185_1.var_.actorSpriteComps10093 = nil
			end

			local var_188_5 = arg_185_1.actors_["10097"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.actorSpriteComps10097 == nil then
				arg_185_1.var_.actorSpriteComps10097 = var_188_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_188_6 = 2

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_6 and not isNil(var_188_5) then
				if arg_185_1.var_.actorSpriteComps10097 then
					for iter_188_5, iter_188_6 in pairs(arg_185_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_188_6 then
							if arg_185_1.isInRecall_ then
								iter_188_6.color = Color.New(Mathf.Lerp(iter_188_6.color.r, arg_185_1.hightColor2.r, (arg_185_1.time_ - 0) / var_188_6), Mathf.Lerp(iter_188_6.color.g, arg_185_1.hightColor2.g, (arg_185_1.time_ - 0) / var_188_6), (Mathf.Lerp(iter_188_6.color.b, arg_185_1.hightColor2.b, (arg_185_1.time_ - 0) / var_188_6)))
							else
								local var_188_7 = Mathf.Lerp(iter_188_6.color.r, 0.5, (arg_185_1.time_ - 0) / var_188_6)

								iter_188_6.color = Color.New(var_188_7, var_188_7, var_188_7)
							end
						end
					end
				end
			end

			if arg_185_1.time_ >= 0 + var_188_6 and arg_185_1.time_ < 0 + var_188_6 + arg_188_0 and not isNil(var_188_5) and arg_185_1.var_.actorSpriteComps10097 then
				for iter_188_7, iter_188_8 in pairs(arg_185_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_188_8 then
						iter_188_8.color = arg_185_1.isInRecall_ and (arg_185_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_185_1.var_.actorSpriteComps10097 = nil
			end

			local var_188_8 = 0
			local var_188_9 = 0.35

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_8 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_10 = arg_185_1:GetWordFromCfg(413091044)
				local var_188_11 = arg_185_1:FormatText(var_188_10.content)

				arg_185_1.text_.text = var_188_11

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_13 = 14 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 14)

				if (14 <= 0 and var_188_9 or var_188_9 * (utf8.len(var_188_11) / 14)) > 0 and var_188_9 < var_188_13 then
					arg_185_1.talkMaxDuration = var_188_13

					if var_188_13 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_13 + var_188_8
					end
				end

				arg_185_1.text_.text = var_188_11
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091044", "story_v_out_413091.awb") ~= 0 then
					local var_188_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091044", "story_v_out_413091.awb") / 1000

					if var_188_14 + var_188_8 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_14 + var_188_8
					end

					if var_188_10.prefab_name ~= "" and arg_185_1.actors_[var_188_10.prefab_name] ~= nil then
						local var_188_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_10.prefab_name].transform, "story_v_out_413091", "413091044", "story_v_out_413091.awb")

						arg_185_1:RecordAudio("413091044", var_188_15)
						arg_185_1:RecordAudio("413091044", var_188_15)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_413091", "413091044", "story_v_out_413091.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_413091", "413091044", "story_v_out_413091.awb")
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
				actorName = "10093",
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
	Play413091045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 413091045
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play413091046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10093 = arg_189_1.actors_["10093"].transform.localPosition
				arg_189_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10093", 6)

				for iter_192_0 = 0, arg_189_1.actors_["10093"].transform.childCount - 1 do
					local var_192_0 = arg_189_1.actors_["10093"].transform:GetChild(iter_192_0)

					if var_192_0.name == "" or not string.find(var_192_0.name, "split") then
						var_192_0.gameObject:SetActive(true)
					else
						var_192_0.gameObject:SetActive(false)
					end
				end
			end

			local var_192_1 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_1 then
				arg_189_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10093, Vector3.New(1500, -345, -245), (arg_189_1.time_ - 0) / var_192_1)
			end

			if arg_189_1.time_ >= 0 + var_192_1 and arg_189_1.time_ < 0 + var_192_1 + arg_192_0 then
				arg_189_1.actors_["10093"].transform.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_192_2 = arg_189_1.actors_["10097"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos10097 = var_192_2.localPosition
				var_192_2.localScale = Vector3.New(1, 1, 1)

				arg_189_1:CheckSpriteTmpPos("10097", 6)

				for iter_192_1 = 0, var_192_2.childCount - 1 do
					local var_192_3 = var_192_2:GetChild(iter_192_1)

					if var_192_3.name == "" or not string.find(var_192_3.name, "split") then
						var_192_3.gameObject:SetActive(true)
					else
						var_192_3.gameObject:SetActive(false)
					end
				end
			end

			local var_192_4 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				var_192_2.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10097, Vector3.New(1500, -350, -180), (arg_189_1.time_ - 0) / var_192_4)
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				var_192_2.localPosition = Vector3.New(1500, -350, -180)
			end

			local var_192_5 = arg_189_1.actors_["10093"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.actorSpriteComps10093 == nil then
				arg_189_1.var_.actorSpriteComps10093 = var_192_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_6 = 2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_6 and not isNil(var_192_5) then
				if arg_189_1.var_.actorSpriteComps10093 then
					for iter_192_2, iter_192_3 in pairs(arg_189_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_192_3 then
							if arg_189_1.isInRecall_ then
								iter_192_3.color = Color.New(Mathf.Lerp(iter_192_3.color.r, arg_189_1.hightColor2.r, (arg_189_1.time_ - 0) / var_192_6), Mathf.Lerp(iter_192_3.color.g, arg_189_1.hightColor2.g, (arg_189_1.time_ - 0) / var_192_6), (Mathf.Lerp(iter_192_3.color.b, arg_189_1.hightColor2.b, (arg_189_1.time_ - 0) / var_192_6)))
							else
								local var_192_7 = Mathf.Lerp(iter_192_3.color.r, 0.5, (arg_189_1.time_ - 0) / var_192_6)

								iter_192_3.color = Color.New(var_192_7, var_192_7, var_192_7)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_6 and arg_189_1.time_ < 0 + var_192_6 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.actorSpriteComps10093 then
				for iter_192_4, iter_192_5 in pairs(arg_189_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_192_5 then
						iter_192_5.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_189_1.var_.actorSpriteComps10093 = nil
			end

			local var_192_8 = arg_189_1.actors_["10097"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_8) and arg_189_1.var_.actorSpriteComps10097 == nil then
				arg_189_1.var_.actorSpriteComps10097 = var_192_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_192_9 = 2

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_9 and not isNil(var_192_8) then
				if arg_189_1.var_.actorSpriteComps10097 then
					for iter_192_6, iter_192_7 in pairs(arg_189_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_192_7 then
							if arg_189_1.isInRecall_ then
								iter_192_7.color = Color.New(Mathf.Lerp(iter_192_7.color.r, arg_189_1.hightColor2.r, (arg_189_1.time_ - 0) / var_192_9), Mathf.Lerp(iter_192_7.color.g, arg_189_1.hightColor2.g, (arg_189_1.time_ - 0) / var_192_9), (Mathf.Lerp(iter_192_7.color.b, arg_189_1.hightColor2.b, (arg_189_1.time_ - 0) / var_192_9)))
							else
								local var_192_10 = Mathf.Lerp(iter_192_7.color.r, 0.5, (arg_189_1.time_ - 0) / var_192_9)

								iter_192_7.color = Color.New(var_192_10, var_192_10, var_192_10)
							end
						end
					end
				end
			end

			if arg_189_1.time_ >= 0 + var_192_9 and arg_189_1.time_ < 0 + var_192_9 + arg_192_0 and not isNil(var_192_8) and arg_189_1.var_.actorSpriteComps10097 then
				for iter_192_8, iter_192_9 in pairs(arg_189_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_192_9 then
						iter_192_9.color = arg_189_1.isInRecall_ and (arg_189_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_189_1.var_.actorSpriteComps10097 = nil
			end

			local var_192_11 = 0
			local var_192_12 = 1.275

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_11 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_13 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(413091045).content)

				arg_189_1.text_.text = var_192_13

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_15 = 51 <= 0 and var_192_12 or var_192_12 * (utf8.len(var_192_13) / 51)

				if (51 <= 0 and var_192_12 or var_192_12 * (utf8.len(var_192_13) / 51)) > 0 and var_192_12 < var_192_15 then
					arg_189_1.talkMaxDuration = var_192_15

					if var_192_15 + var_192_11 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_15 + var_192_11
					end
				end

				arg_189_1.text_.text = var_192_13
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_16 = math.max(var_192_12, arg_189_1.talkMaxDuration)

			if var_192_11 <= arg_189_1.time_ and arg_189_1.time_ < var_192_11 + var_192_16 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_11) / var_192_16

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_11 + var_192_16 and arg_189_1.time_ < var_192_11 + var_192_16 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
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
				actorName = "10097",
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
	Play413091046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 413091046
		arg_193_1.duration_ = 7.43

		local var_193_0 = {
			zh = 5.366,
			ja = 7.433
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
				arg_193_0:Play413091047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_9000

			if 0.6 < arg_193_1.time_ and arg_193_1.time_ <= 0.6 + arg_196_0 then
				arg_193_1.var_.moveOldPos10093 = arg_193_1.actors_["10093"].transform.localPosition
				arg_193_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_193_1:CheckSpriteTmpPos("10093", 3)

				for iter_196_0 = 0, arg_193_1.actors_["10093"].transform.childCount - 1 do
					local var_196_0 = arg_193_1.actors_["10093"].transform:GetChild(iter_196_0)

					if var_196_0.name == "split_3" or not string.find(var_196_0.name, "split") then
						var_196_0.gameObject:SetActive(true)
					else
						var_196_0.gameObject:SetActive(false)
					end
				end
			end

			local var_196_1 = 0.001

			if 0.6 <= arg_193_1.time_ and arg_193_1.time_ < 0.6 + var_196_1 then
				arg_193_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_193_1.time_ - 0.6) / var_196_1)
			end

			if arg_193_1.time_ >= 0.6 + var_196_1 and arg_193_1.time_ < 0.6 + var_196_1 + arg_196_0 then
				arg_193_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_196_2 = arg_193_1.actors_["10093"]

			if 0.6 < arg_193_1.time_ and arg_193_1.time_ <= 0.6 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps10093 == nil then
				arg_193_1.var_.actorSpriteComps10093 = var_196_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_196_3 = 2

			if 0.6 <= arg_193_1.time_ and arg_193_1.time_ < 0.6 + var_196_3 and not isNil(var_196_2) then
				if arg_193_1.var_.actorSpriteComps10093 then
					for iter_196_1, iter_196_2 in pairs(arg_193_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_196_2 then
							if arg_193_1.isInRecall_ then
								iter_196_2.color = Color.New(Mathf.Lerp(iter_196_2.color.r, arg_193_1.hightColor1.r, (arg_193_1.time_ - 0.6) / var_196_3), Mathf.Lerp(iter_196_2.color.g, arg_193_1.hightColor1.g, (arg_193_1.time_ - 0.6) / var_196_3), (Mathf.Lerp(iter_196_2.color.b, arg_193_1.hightColor1.b, (arg_193_1.time_ - 0.6) / var_196_3)))
							else
								local var_196_4 = Mathf.Lerp(iter_196_2.color.r, 1, (arg_193_1.time_ - 0.6) / var_196_3)

								iter_196_2.color = Color.New(var_196_4, var_196_4, var_196_4)
							end
						end
					end
				end
			end

			if arg_193_1.time_ >= 0.6 + var_196_3 and arg_193_1.time_ < 0.6 + var_196_3 + arg_196_0 and not isNil(var_196_2) and arg_193_1.var_.actorSpriteComps10093 then
				for iter_196_3, iter_196_4 in pairs(arg_193_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_196_4 then
						iter_196_4.color = arg_193_1.isInRecall_ and (arg_193_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_193_1.var_.actorSpriteComps10093 = nil
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				local var_196_5 = arg_193_1.var_.effectjingshi1

				if not arg_193_1.var_.effectjingshi1 then
					var_196_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_196_5.name = "jingshi1"
					arg_193_1.var_.effectjingshi1 = var_196_5
				else
					var_196_5.transform:SetParent(var_196_9000)
				end

				var_196_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_196_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_193_1.time_ and arg_193_1.time_ <= 1 + arg_196_0 then
				if arg_193_1.var_.effectjingshi1 then
					Object.Destroy(arg_193_1.var_.effectjingshi1)

					arg_193_1.var_.effectjingshi1 = nil
				end
			end

			if 0.6 < arg_193_1.time_ and arg_193_1.time_ <= 0.6 + arg_196_0 then
				local var_196_8 = arg_193_1.actors_["10093"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_196_8 then
					arg_193_1.var_.alphaOldValue10093 = var_196_8.alpha
					arg_193_1.var_.characterEffect10093 = var_196_8
				end

				arg_193_1.var_.alphaOldValue10093 = 0
			end

			local var_196_9 = 0.266666666666667

			if 0.6 <= arg_193_1.time_ and arg_193_1.time_ < 0.6 + var_196_9 then
				if arg_193_1.var_.characterEffect10093 then
					arg_193_1.var_.characterEffect10093.alpha = Mathf.Lerp(arg_193_1.var_.alphaOldValue10093, 1, (arg_193_1.time_ - 0.6) / var_196_9)
				end
			end

			if arg_193_1.time_ >= 0.6 + var_196_9 and arg_193_1.time_ < 0.6 + var_196_9 + arg_196_0 and arg_193_1.var_.characterEffect10093 then
				arg_193_1.var_.characterEffect10093.alpha = 1
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_10 = 0.6
			local var_196_11 = 0.525

			if 0.6 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_12 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_12:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_193_1.dialogCg_.alpha = arg_197_0
				end))
				var_196_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_13 = arg_193_1:GetWordFromCfg(413091046)
				local var_196_14 = arg_193_1:FormatText(var_196_13.content)

				arg_193_1.text_.text = var_196_14

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_16 = 21 <= 0 and var_196_11 or var_196_11 * (utf8.len(var_196_14) / 21)

				if (21 <= 0 and var_196_11 or var_196_11 * (utf8.len(var_196_14) / 21)) > 0 and var_196_11 < var_196_16 then
					arg_193_1.talkMaxDuration = var_196_16
					var_196_10 = var_196_10 + 0.3

					if var_196_16 + var_196_10 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_16 + var_196_10
					end
				end

				arg_193_1.text_.text = var_196_14
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091046", "story_v_out_413091.awb") ~= 0 then
					local var_196_17 = manager.audio:GetVoiceLength("story_v_out_413091", "413091046", "story_v_out_413091.awb") / 1000

					if var_196_17 + var_196_10 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_17 + var_196_10
					end

					if var_196_13.prefab_name ~= "" and arg_193_1.actors_[var_196_13.prefab_name] ~= nil then
						local var_196_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_13.prefab_name].transform, "story_v_out_413091", "413091046", "story_v_out_413091.awb")

						arg_193_1:RecordAudio("413091046", var_196_18)
						arg_193_1:RecordAudio("413091046", var_196_18)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_413091", "413091046", "story_v_out_413091.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_413091", "413091046", "story_v_out_413091.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_19 = var_196_10 + 0.3
			local var_196_20 = math.max(var_196_11, arg_193_1.talkMaxDuration)

			if var_196_10 + 0.3 <= arg_193_1.time_ and arg_193_1.time_ < var_196_19 + var_196_20 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_19) / var_196_20

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_19 + var_196_20 and arg_193_1.time_ < var_196_19 + var_196_20 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.6,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play413091047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 413091047
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play413091048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10093 = arg_199_1.actors_["10093"].transform.localPosition
				arg_199_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("10093", 6)

				for iter_202_0 = 0, arg_199_1.actors_["10093"].transform.childCount - 1 do
					local var_202_0 = arg_199_1.actors_["10093"].transform:GetChild(iter_202_0)

					if var_202_0.name == "" or not string.find(var_202_0.name, "split") then
						var_202_0.gameObject:SetActive(true)
					else
						var_202_0.gameObject:SetActive(false)
					end
				end
			end

			local var_202_1 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_1 then
				arg_199_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10093, Vector3.New(1500, -345, -245), (arg_199_1.time_ - 0) / var_202_1)
			end

			if arg_199_1.time_ >= 0 + var_202_1 and arg_199_1.time_ < 0 + var_202_1 + arg_202_0 then
				arg_199_1.actors_["10093"].transform.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_202_2 = arg_199_1.actors_["10093"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps10093 == nil then
				arg_199_1.var_.actorSpriteComps10093 = var_202_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_3 = 2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.actorSpriteComps10093 then
					for iter_202_1, iter_202_2 in pairs(arg_199_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_202_2 then
							if arg_199_1.isInRecall_ then
								iter_202_2.color = Color.New(Mathf.Lerp(iter_202_2.color.r, arg_199_1.hightColor2.r, (arg_199_1.time_ - 0) / var_202_3), Mathf.Lerp(iter_202_2.color.g, arg_199_1.hightColor2.g, (arg_199_1.time_ - 0) / var_202_3), (Mathf.Lerp(iter_202_2.color.b, arg_199_1.hightColor2.b, (arg_199_1.time_ - 0) / var_202_3)))
							else
								local var_202_4 = Mathf.Lerp(iter_202_2.color.r, 0.5, (arg_199_1.time_ - 0) / var_202_3)

								iter_202_2.color = Color.New(var_202_4, var_202_4, var_202_4)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps10093 then
				for iter_202_3, iter_202_4 in pairs(arg_199_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_202_4 then
						iter_202_4.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_199_1.var_.actorSpriteComps10093 = nil
			end

			local var_202_5 = 0
			local var_202_6 = 1.1

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_5 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_7 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(413091047).content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 44 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_7) / 44)

				if (44 <= 0 and var_202_6 or var_202_6 * (utf8.len(var_202_7) / 44)) > 0 and var_202_6 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_5 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_5
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_6, arg_199_1.talkMaxDuration)

			if var_202_5 <= arg_199_1.time_ and arg_199_1.time_ < var_202_5 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_5) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_5 + var_202_10 and arg_199_1.time_ < var_202_5 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
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

		arg_199_1:InitPlayNodeList()
	end,
	Play413091048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 413091048
		arg_203_1.duration_ = 5.67

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play413091049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			if arg_203_1.time_ >= 0 + 0.666666666666667 and arg_203_1.time_ < 0 + 0.666666666666667 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_0 = 0.666666666666667
			local var_206_1 = 1.3

			if 0.666666666666667 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_2 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_2:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_3 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(413091048).content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 52 <= 0 and var_206_1 or var_206_1 * (utf8.len(var_206_3) / 52)

				if (52 <= 0 and var_206_1 or var_206_1 * (utf8.len(var_206_3) / 52)) > 0 and var_206_1 < var_206_5 then
					arg_203_1.talkMaxDuration = var_206_5
					var_206_0 = var_206_0 + 0.3

					if var_206_5 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_6 = var_206_0 + 0.3
			local var_206_7 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 + 0.3 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_7 and arg_203_1.time_ < var_206_6 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play413091049 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 413091049
		arg_209_1.duration_ = 2

		local var_209_0 = {
			zh = 1.999999999999,
			ja = 2
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
				arg_209_0:Play413091050(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos10093 = arg_209_1.actors_["10093"].transform.localPosition
				arg_209_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10093", 3)

				for iter_212_0 = 0, arg_209_1.actors_["10093"].transform.childCount - 1 do
					local var_212_0 = arg_209_1.actors_["10093"].transform:GetChild(iter_212_0)

					if var_212_0.name == "split_5" or not string.find(var_212_0.name, "split") then
						var_212_0.gameObject:SetActive(true)
					else
						var_212_0.gameObject:SetActive(false)
					end
				end
			end

			local var_212_1 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_1 then
				arg_209_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_209_1.time_ - 0) / var_212_1)
			end

			if arg_209_1.time_ >= 0 + var_212_1 and arg_209_1.time_ < 0 + var_212_1 + arg_212_0 then
				arg_209_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_212_2 = arg_209_1.actors_["10097"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos10097 = var_212_2.localPosition
				var_212_2.localScale = Vector3.New(1, 1, 1)

				arg_209_1:CheckSpriteTmpPos("10097", 7)

				for iter_212_1 = 0, var_212_2.childCount - 1 do
					local var_212_3 = var_212_2:GetChild(iter_212_1)

					if var_212_3.name == "split_2" or not string.find(var_212_3.name, "split") then
						var_212_3.gameObject:SetActive(true)
					else
						var_212_3.gameObject:SetActive(false)
					end
				end
			end

			local var_212_4 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_4 then
				var_212_2.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10097, Vector3.New(0, -2000, -180), (arg_209_1.time_ - 0) / var_212_4)
			end

			if arg_209_1.time_ >= 0 + var_212_4 and arg_209_1.time_ < 0 + var_212_4 + arg_212_0 then
				var_212_2.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_212_5 = arg_209_1.actors_["10093"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.actorSpriteComps10093 == nil then
				arg_209_1.var_.actorSpriteComps10093 = var_212_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_6 = 2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_6 and not isNil(var_212_5) then
				if arg_209_1.var_.actorSpriteComps10093 then
					for iter_212_2, iter_212_3 in pairs(arg_209_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_212_3 then
							if arg_209_1.isInRecall_ then
								iter_212_3.color = Color.New(Mathf.Lerp(iter_212_3.color.r, arg_209_1.hightColor1.r, (arg_209_1.time_ - 0) / var_212_6), Mathf.Lerp(iter_212_3.color.g, arg_209_1.hightColor1.g, (arg_209_1.time_ - 0) / var_212_6), (Mathf.Lerp(iter_212_3.color.b, arg_209_1.hightColor1.b, (arg_209_1.time_ - 0) / var_212_6)))
							else
								local var_212_7 = Mathf.Lerp(iter_212_3.color.r, 1, (arg_209_1.time_ - 0) / var_212_6)

								iter_212_3.color = Color.New(var_212_7, var_212_7, var_212_7)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_6 and arg_209_1.time_ < 0 + var_212_6 + arg_212_0 and not isNil(var_212_5) and arg_209_1.var_.actorSpriteComps10093 then
				for iter_212_4, iter_212_5 in pairs(arg_209_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_212_5 then
						iter_212_5.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_209_1.var_.actorSpriteComps10093 = nil
			end

			local var_212_8 = arg_209_1.actors_["10097"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_8) and arg_209_1.var_.actorSpriteComps10097 == nil then
				arg_209_1.var_.actorSpriteComps10097 = var_212_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_212_9 = 2

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_9 and not isNil(var_212_8) then
				if arg_209_1.var_.actorSpriteComps10097 then
					for iter_212_6, iter_212_7 in pairs(arg_209_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_212_7 then
							if arg_209_1.isInRecall_ then
								iter_212_7.color = Color.New(Mathf.Lerp(iter_212_7.color.r, arg_209_1.hightColor2.r, (arg_209_1.time_ - 0) / var_212_9), Mathf.Lerp(iter_212_7.color.g, arg_209_1.hightColor2.g, (arg_209_1.time_ - 0) / var_212_9), (Mathf.Lerp(iter_212_7.color.b, arg_209_1.hightColor2.b, (arg_209_1.time_ - 0) / var_212_9)))
							else
								local var_212_10 = Mathf.Lerp(iter_212_7.color.r, 0.5, (arg_209_1.time_ - 0) / var_212_9)

								iter_212_7.color = Color.New(var_212_10, var_212_10, var_212_10)
							end
						end
					end
				end
			end

			if arg_209_1.time_ >= 0 + var_212_9 and arg_209_1.time_ < 0 + var_212_9 + arg_212_0 and not isNil(var_212_8) and arg_209_1.var_.actorSpriteComps10097 then
				for iter_212_8, iter_212_9 in pairs(arg_209_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_212_9 then
						iter_212_9.color = arg_209_1.isInRecall_ and (arg_209_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_209_1.var_.actorSpriteComps10097 = nil
			end

			local var_212_11 = arg_209_1.actors_["10093"].transform

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.shakeOldPos10093 = var_212_11.localPosition
			end

			local var_212_12 = 0.6

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_12 then
				local var_212_13, var_212_14 = math.modf((arg_209_1.time_ - 0) / 0.066)

				var_212_11.localPosition = Vector3.New(var_212_14 * 0.13, var_212_14 * 0.13, var_212_14 * 0.13) + arg_209_1.var_.shakeOldPos10093
			end

			if arg_209_1.time_ >= 0 + var_212_12 and arg_209_1.time_ < 0 + var_212_12 + arg_212_0 then
				var_212_11.localPosition = arg_209_1.var_.shakeOldPos10093
			end

			local var_212_15 = 0
			local var_212_16 = 0.15

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_15 + arg_212_0 then
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

				local var_212_17 = arg_209_1:GetWordFromCfg(413091049)
				local var_212_18 = arg_209_1:FormatText(var_212_17.content)

				arg_209_1.text_.text = var_212_18

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_20 = 6 <= 0 and var_212_16 or var_212_16 * (utf8.len(var_212_18) / 6)

				if (6 <= 0 and var_212_16 or var_212_16 * (utf8.len(var_212_18) / 6)) > 0 and var_212_16 < var_212_20 then
					arg_209_1.talkMaxDuration = var_212_20

					if var_212_20 + var_212_15 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_20 + var_212_15
					end
				end

				arg_209_1.text_.text = var_212_18
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091049", "story_v_out_413091.awb") ~= 0 then
					local var_212_21 = manager.audio:GetVoiceLength("story_v_out_413091", "413091049", "story_v_out_413091.awb") / 1000

					if var_212_21 + var_212_15 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_21 + var_212_15
					end

					if var_212_17.prefab_name ~= "" and arg_209_1.actors_[var_212_17.prefab_name] ~= nil then
						local var_212_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_17.prefab_name].transform, "story_v_out_413091", "413091049", "story_v_out_413091.awb")

						arg_209_1:RecordAudio("413091049", var_212_22)
						arg_209_1:RecordAudio("413091049", var_212_22)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_413091", "413091049", "story_v_out_413091.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_413091", "413091049", "story_v_out_413091.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_23 = math.max(var_212_16, arg_209_1.talkMaxDuration)

			if var_212_15 <= arg_209_1.time_ and arg_209_1.time_ < var_212_15 + var_212_23 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_15) / var_212_23

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_15 + var_212_23 and arg_209_1.time_ < var_212_15 + var_212_23 + arg_212_0 then
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

		arg_209_1:InitPlayNodeList()
	end,
	Play413091050 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 413091050
		arg_213_1.duration_ = 8.67

		local var_213_0 = {
			zh = 5.633,
			ja = 8.666
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
				arg_213_0:Play413091051(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["10093"]) and arg_213_1.var_.actorSpriteComps10093 == nil then
				arg_213_1.var_.actorSpriteComps10093 = arg_213_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_216_0 = 0.2

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["10093"]) then
				if arg_213_1.var_.actorSpriteComps10093 then
					for iter_216_0, iter_216_1 in pairs(arg_213_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["10093"]) and arg_213_1.var_.actorSpriteComps10093 then
				for iter_216_2, iter_216_3 in pairs(arg_213_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_216_3 then
						iter_216_3.color = arg_213_1.isInRecall_ and (arg_213_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_213_1.var_.actorSpriteComps10093 = nil
			end

			local var_216_2 = 0
			local var_216_3 = 0.5

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_2 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, true)
				arg_213_1.iconController_:SetSelectedState("hero")

				arg_213_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10097_split_2")

				arg_213_1.callingController_:SetSelectedState("normal")

				arg_213_1.keyicon_.color = Color.New(1, 1, 1)
				arg_213_1.icon_.color = Color.New(1, 1, 1)

				local var_216_4 = arg_213_1:GetWordFromCfg(413091050)
				local var_216_5 = arg_213_1:FormatText(var_216_4.content)

				arg_213_1.text_.text = var_216_5

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_7 = 20 <= 0 and var_216_3 or var_216_3 * (utf8.len(var_216_5) / 20)

				if (20 <= 0 and var_216_3 or var_216_3 * (utf8.len(var_216_5) / 20)) > 0 and var_216_3 < var_216_7 then
					arg_213_1.talkMaxDuration = var_216_7

					if var_216_7 + var_216_2 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_7 + var_216_2
					end
				end

				arg_213_1.text_.text = var_216_5
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091050", "story_v_out_413091.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_413091", "413091050", "story_v_out_413091.awb") / 1000

					if var_216_8 + var_216_2 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_2
					end

					if var_216_4.prefab_name ~= "" and arg_213_1.actors_[var_216_4.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_4.prefab_name].transform, "story_v_out_413091", "413091050", "story_v_out_413091.awb")

						arg_213_1:RecordAudio("413091050", var_216_9)
						arg_213_1:RecordAudio("413091050", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_413091", "413091050", "story_v_out_413091.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_413091", "413091050", "story_v_out_413091.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_10 = math.max(var_216_3, arg_213_1.talkMaxDuration)

			if var_216_2 <= arg_213_1.time_ and arg_213_1.time_ < var_216_2 + var_216_10 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_2) / var_216_10

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_2 + var_216_10 and arg_213_1.time_ < var_216_2 + var_216_10 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play413091051 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 413091051
		arg_217_1.duration_ = 6

		local var_217_0 = {
			zh = 6,
			ja = 4.866
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
				arg_217_0:Play413091052(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos10093 = arg_217_1.actors_["10093"].transform.localPosition
				arg_217_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_217_1:CheckSpriteTmpPos("10093", 3)

				for iter_220_0 = 0, arg_217_1.actors_["10093"].transform.childCount - 1 do
					local var_220_0 = arg_217_1.actors_["10093"].transform:GetChild(iter_220_0)

					if var_220_0.name == "split_7" or not string.find(var_220_0.name, "split") then
						var_220_0.gameObject:SetActive(true)
					else
						var_220_0.gameObject:SetActive(false)
					end
				end
			end

			local var_220_1 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_1 then
				arg_217_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_217_1.time_ - 0) / var_220_1)
			end

			if arg_217_1.time_ >= 0 + var_220_1 and arg_217_1.time_ < 0 + var_220_1 + arg_220_0 then
				arg_217_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_220_2 = arg_217_1.actors_["10093"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.actorSpriteComps10093 == nil then
				arg_217_1.var_.actorSpriteComps10093 = var_220_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_220_3 = 2

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_3 and not isNil(var_220_2) then
				if arg_217_1.var_.actorSpriteComps10093 then
					for iter_220_1, iter_220_2 in pairs(arg_217_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_220_2 then
							if arg_217_1.isInRecall_ then
								iter_220_2.color = Color.New(Mathf.Lerp(iter_220_2.color.r, arg_217_1.hightColor1.r, (arg_217_1.time_ - 0) / var_220_3), Mathf.Lerp(iter_220_2.color.g, arg_217_1.hightColor1.g, (arg_217_1.time_ - 0) / var_220_3), (Mathf.Lerp(iter_220_2.color.b, arg_217_1.hightColor1.b, (arg_217_1.time_ - 0) / var_220_3)))
							else
								local var_220_4 = Mathf.Lerp(iter_220_2.color.r, 1, (arg_217_1.time_ - 0) / var_220_3)

								iter_220_2.color = Color.New(var_220_4, var_220_4, var_220_4)
							end
						end
					end
				end
			end

			if arg_217_1.time_ >= 0 + var_220_3 and arg_217_1.time_ < 0 + var_220_3 + arg_220_0 and not isNil(var_220_2) and arg_217_1.var_.actorSpriteComps10093 then
				for iter_220_3, iter_220_4 in pairs(arg_217_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_220_4 then
						iter_220_4.color = arg_217_1.isInRecall_ and (arg_217_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_217_1.var_.actorSpriteComps10093 = nil
			end

			local var_220_5 = 0
			local var_220_6 = 0.75

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_5 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_7 = arg_217_1:GetWordFromCfg(413091051)
				local var_220_8 = arg_217_1:FormatText(var_220_7.content)

				arg_217_1.text_.text = var_220_8

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_10 = 30 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_8) / 30)

				if (30 <= 0 and var_220_6 or var_220_6 * (utf8.len(var_220_8) / 30)) > 0 and var_220_6 < var_220_10 then
					arg_217_1.talkMaxDuration = var_220_10

					if var_220_10 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_10 + var_220_5
					end
				end

				arg_217_1.text_.text = var_220_8
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091051", "story_v_out_413091.awb") ~= 0 then
					local var_220_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091051", "story_v_out_413091.awb") / 1000

					if var_220_11 + var_220_5 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_11 + var_220_5
					end

					if var_220_7.prefab_name ~= "" and arg_217_1.actors_[var_220_7.prefab_name] ~= nil then
						local var_220_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_7.prefab_name].transform, "story_v_out_413091", "413091051", "story_v_out_413091.awb")

						arg_217_1:RecordAudio("413091051", var_220_12)
						arg_217_1:RecordAudio("413091051", var_220_12)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_413091", "413091051", "story_v_out_413091.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_413091", "413091051", "story_v_out_413091.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_13 = math.max(var_220_6, arg_217_1.talkMaxDuration)

			if var_220_5 <= arg_217_1.time_ and arg_217_1.time_ < var_220_5 + var_220_13 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_5) / var_220_13

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_5 + var_220_13 and arg_217_1.time_ < var_220_5 + var_220_13 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
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

		arg_217_1:InitPlayNodeList()
	end,
	Play413091052 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 413091052
		arg_221_1.duration_ = 5.67

		local var_221_0 = {
			zh = 3.3,
			ja = 5.666
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
				arg_221_0:Play413091053(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.45

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
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

				local var_224_1 = arg_221_1:GetWordFromCfg(413091052)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 18 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 18)

				if (18 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 18)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091052", "story_v_out_413091.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091052", "story_v_out_413091.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_413091", "413091052", "story_v_out_413091.awb")

						arg_221_1:RecordAudio("413091052", var_224_6)
						arg_221_1:RecordAudio("413091052", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_413091", "413091052", "story_v_out_413091.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_413091", "413091052", "story_v_out_413091.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play413091053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 413091053
		arg_225_1.duration_ = 2.73

		local var_225_0 = {
			zh = 2.333,
			ja = 2.733
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
				arg_225_0:Play413091054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0.275

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_1 = arg_225_1:GetWordFromCfg(413091053)
				local var_228_2 = arg_225_1:FormatText(var_228_1.content)

				arg_225_1.text_.text = var_228_2

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 11 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 11)

				if (11 <= 0 and var_228_0 or var_228_0 * (utf8.len(var_228_2) / 11)) > 0 and var_228_0 < var_228_4 then
					arg_225_1.talkMaxDuration = var_228_4

					if var_228_4 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_4 + 0
					end
				end

				arg_225_1.text_.text = var_228_2
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091053", "story_v_out_413091.awb") ~= 0 then
					local var_228_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091053", "story_v_out_413091.awb") / 1000

					if var_228_5 + 0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + 0
					end

					if var_228_1.prefab_name ~= "" and arg_225_1.actors_[var_228_1.prefab_name] ~= nil then
						local var_228_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_1.prefab_name].transform, "story_v_out_413091", "413091053", "story_v_out_413091.awb")

						arg_225_1:RecordAudio("413091053", var_228_6)
						arg_225_1:RecordAudio("413091053", var_228_6)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_413091", "413091053", "story_v_out_413091.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_413091", "413091053", "story_v_out_413091.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_0, arg_225_1.talkMaxDuration)

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - 0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= 0 + var_228_7 and arg_225_1.time_ < 0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play413091054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 413091054
		arg_229_1.duration_ = 8.5

		local var_229_0 = {
			zh = 7.866,
			ja = 8.5
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
				arg_229_0:Play413091055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 1.999999999999 < arg_229_1.time_ and arg_229_1.time_ <= 1.999999999999 + arg_232_0 then
				local var_232_0 = arg_229_1.bgs_.F08m

				arg_229_1.bgs_.F08m.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_232_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_232_1 = var_232_0:GetComponent("SpriteRenderer")

				if var_232_1 and var_232_1.sprite then
					local var_232_2 = 2 * (var_232_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_232_0.transform.localScale = Vector3.New(var_232_2 / var_232_1.sprite.bounds.size.y < var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x and var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x or var_232_2 / var_232_1.sprite.bounds.size.y, var_232_2 / var_232_1.sprite.bounds.size.y < var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x and var_232_2 * manager.ui.mainCameraCom_.aspect / var_232_1.sprite.bounds.size.x or var_232_2 / var_232_1.sprite.bounds.size.y, 0)
				end

				for iter_232_0, iter_232_1 in pairs(arg_229_1.bgs_) do
					if iter_232_0 ~= "F08m" then
						iter_232_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_232_3 = 3.999999999999

			if 3.999999999999 < arg_229_1.time_ and arg_229_1.time_ <= var_232_3 + arg_232_0 then
				arg_229_1.allBtn_.enabled = false
			end

			if arg_229_1.time_ >= var_232_3 + 0.3 and arg_229_1.time_ < var_232_3 + 0.3 + arg_232_0 then
				arg_229_1.allBtn_.enabled = true
			end

			local var_232_4 = 0

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_5 = 2

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_5 then
				local var_232_6 = Color.New(0, 0, 0)

				var_232_6.a = Mathf.Lerp(0, 1, (arg_229_1.time_ - var_232_4) / var_232_5)
				arg_229_1.mask_.color = var_232_6
			end

			if arg_229_1.time_ >= var_232_4 + var_232_5 and arg_229_1.time_ < var_232_4 + var_232_5 + arg_232_0 then
				local var_232_7 = Color.New(0, 0, 0)

				var_232_7.a = 1
				arg_229_1.mask_.color = var_232_7
			end

			local var_232_8 = 2

			if 2 < arg_229_1.time_ and arg_229_1.time_ <= var_232_8 + arg_232_0 then
				arg_229_1.mask_.enabled = true
				arg_229_1.mask_.raycastTarget = true

				arg_229_1:SetGaussion(false)
			end

			local var_232_9 = 2

			if var_232_8 <= arg_229_1.time_ and arg_229_1.time_ < var_232_8 + var_232_9 then
				local var_232_10 = Color.New(0, 0, 0)

				var_232_10.a = Mathf.Lerp(1, 0, (arg_229_1.time_ - var_232_8) / var_232_9)
				arg_229_1.mask_.color = var_232_10
			end

			if arg_229_1.time_ >= var_232_8 + var_232_9 and arg_229_1.time_ < var_232_8 + var_232_9 + arg_232_0 then
				local var_232_11 = Color.New(0, 0, 0)

				arg_229_1.mask_.enabled = false
				var_232_11.a = 0
				arg_229_1.mask_.color = var_232_11
			end

			local var_232_12 = arg_229_1.actors_["10093"].transform

			if 2 < arg_229_1.time_ and arg_229_1.time_ <= 2 + arg_232_0 then
				arg_229_1.var_.moveOldPos10093 = var_232_12.localPosition
				var_232_12.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("10093", 7)

				for iter_232_2 = 0, var_232_12.childCount - 1 do
					local var_232_13 = var_232_12:GetChild(iter_232_2)

					if var_232_13.name == "" or not string.find(var_232_13.name, "split") then
						var_232_13.gameObject:SetActive(true)
					else
						var_232_13.gameObject:SetActive(false)
					end
				end
			end

			local var_232_14 = 0.001

			if 2 <= arg_229_1.time_ and arg_229_1.time_ < 2 + var_232_14 then
				var_232_12.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_229_1.time_ - 2) / var_232_14)
			end

			if arg_229_1.time_ >= 2 + var_232_14 and arg_229_1.time_ < 2 + var_232_14 + arg_232_0 then
				var_232_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_232_15 = "10092"

			if arg_229_1.actors_["10092"] == nil then
				local var_232_16 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10092")

				if not isNil(var_232_16) then
					local var_232_17 = Object.Instantiate(var_232_16, arg_229_1.canvasGo_.transform)

					var_232_17.transform:SetSiblingIndex(1)

					var_232_17.name = var_232_15
					var_232_17.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_229_1.actors_[var_232_15] = var_232_17

					if arg_229_1.isInRecall_ then
						for iter_232_3, iter_232_4 in ipairs((var_232_17:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_232_4.color = arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_232_18 = arg_229_1.actors_["10092"].transform

			if 3.8 < arg_229_1.time_ and arg_229_1.time_ <= 3.8 + arg_232_0 then
				arg_229_1.var_.moveOldPos10092 = var_232_18.localPosition
				var_232_18.localScale = Vector3.New(1, 1, 1)

				arg_229_1:CheckSpriteTmpPos("10092", 3)

				for iter_232_5 = 0, var_232_18.childCount - 1 do
					local var_232_19 = var_232_18:GetChild(iter_232_5)

					if var_232_19.name == "split_8" or not string.find(var_232_19.name, "split") then
						var_232_19.gameObject:SetActive(true)
					else
						var_232_19.gameObject:SetActive(false)
					end
				end
			end

			local var_232_20 = 0.001

			if 3.8 <= arg_229_1.time_ and arg_229_1.time_ < 3.8 + var_232_20 then
				var_232_18.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_229_1.time_ - 3.8) / var_232_20)
			end

			if arg_229_1.time_ >= 3.8 + var_232_20 and arg_229_1.time_ < 3.8 + var_232_20 + arg_232_0 then
				var_232_18.localPosition = Vector3.New(0, -300, -295)
			end

			local var_232_21 = arg_229_1.actors_["10092"]

			if 3.8 < arg_229_1.time_ and arg_229_1.time_ <= 3.8 + arg_232_0 and not isNil(var_232_21) and arg_229_1.var_.actorSpriteComps10092 == nil then
				arg_229_1.var_.actorSpriteComps10092 = var_232_21:GetComponentsInChildren(typeof(Image), true)
			end

			local var_232_22 = 2

			if 3.8 <= arg_229_1.time_ and arg_229_1.time_ < 3.8 + var_232_22 and not isNil(var_232_21) then
				if arg_229_1.var_.actorSpriteComps10092 then
					for iter_232_6, iter_232_7 in pairs(arg_229_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_232_7 then
							if arg_229_1.isInRecall_ then
								iter_232_7.color = Color.New(Mathf.Lerp(iter_232_7.color.r, arg_229_1.hightColor1.r, (arg_229_1.time_ - 3.8) / var_232_22), Mathf.Lerp(iter_232_7.color.g, arg_229_1.hightColor1.g, (arg_229_1.time_ - 3.8) / var_232_22), (Mathf.Lerp(iter_232_7.color.b, arg_229_1.hightColor1.b, (arg_229_1.time_ - 3.8) / var_232_22)))
							else
								local var_232_23 = Mathf.Lerp(iter_232_7.color.r, 1, (arg_229_1.time_ - 3.8) / var_232_22)

								iter_232_7.color = Color.New(var_232_23, var_232_23, var_232_23)
							end
						end
					end
				end
			end

			if arg_229_1.time_ >= 3.8 + var_232_22 and arg_229_1.time_ < 3.8 + var_232_22 + arg_232_0 and not isNil(var_232_21) and arg_229_1.var_.actorSpriteComps10092 then
				for iter_232_8, iter_232_9 in pairs(arg_229_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_232_9 then
						iter_232_9.color = arg_229_1.isInRecall_ and (arg_229_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_229_1.var_.actorSpriteComps10092 = nil
			end

			if 3.799999999999 < arg_229_1.time_ and arg_229_1.time_ <= 3.799999999999 + arg_232_0 then
				local var_232_24 = arg_229_1.actors_["10092"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_232_24 then
					arg_229_1.var_.alphaOldValue10092 = var_232_24.alpha
					arg_229_1.var_.characterEffect10092 = var_232_24
				end

				arg_229_1.var_.alphaOldValue10092 = 0
			end

			local var_232_25 = 0.2

			if 3.799999999999 <= arg_229_1.time_ and arg_229_1.time_ < 3.799999999999 + var_232_25 then
				if arg_229_1.var_.characterEffect10092 then
					arg_229_1.var_.characterEffect10092.alpha = Mathf.Lerp(arg_229_1.var_.alphaOldValue10092, 1, (arg_229_1.time_ - 3.799999999999) / var_232_25)
				end
			end

			if arg_229_1.time_ >= 3.799999999999 + var_232_25 and arg_229_1.time_ < 3.799999999999 + var_232_25 + arg_232_0 and arg_229_1.var_.characterEffect10092 then
				arg_229_1.var_.characterEffect10092.alpha = 1
			end

			if arg_229_1.frameCnt_ <= 1 then
				arg_229_1.dialog_:SetActive(false)
			end

			local var_232_26 = 4
			local var_232_27 = 0.475

			if 4 < arg_229_1.time_ and arg_229_1.time_ <= var_232_26 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0

				arg_229_1.dialog_:SetActive(true)

				arg_229_1.dialogCg_.alpha = 0

				local var_232_28 = LeanTween.value(arg_229_1.dialog_, 0, 1, 0.3)

				var_232_28:setOnUpdate(LuaHelper.FloatAction(function(arg_233_0)
					arg_229_1.dialogCg_.alpha = arg_233_0
				end))
				var_232_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_229_1.dialog_)
					var_232_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_229_1.duration_ = arg_229_1.duration_ + 0.3

				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_29 = arg_229_1:GetWordFromCfg(413091054)
				local var_232_30 = arg_229_1:FormatText(var_232_29.content)

				arg_229_1.text_.text = var_232_30

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_32 = 19 <= 0 and var_232_27 or var_232_27 * (utf8.len(var_232_30) / 19)

				if (19 <= 0 and var_232_27 or var_232_27 * (utf8.len(var_232_30) / 19)) > 0 and var_232_27 < var_232_32 then
					arg_229_1.talkMaxDuration = var_232_32
					var_232_26 = var_232_26 + 0.3

					if var_232_32 + var_232_26 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_32 + var_232_26
					end
				end

				arg_229_1.text_.text = var_232_30
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091054", "story_v_out_413091.awb") ~= 0 then
					local var_232_33 = manager.audio:GetVoiceLength("story_v_out_413091", "413091054", "story_v_out_413091.awb") / 1000

					if var_232_33 + var_232_26 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_33 + var_232_26
					end

					if var_232_29.prefab_name ~= "" and arg_229_1.actors_[var_232_29.prefab_name] ~= nil then
						local var_232_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_29.prefab_name].transform, "story_v_out_413091", "413091054", "story_v_out_413091.awb")

						arg_229_1:RecordAudio("413091054", var_232_34)
						arg_229_1:RecordAudio("413091054", var_232_34)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_413091", "413091054", "story_v_out_413091.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_413091", "413091054", "story_v_out_413091.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_35 = var_232_26 + 0.3
			local var_232_36 = math.max(var_232_27, arg_229_1.talkMaxDuration)

			if var_232_26 + 0.3 <= arg_229_1.time_ and arg_229_1.time_ < var_232_35 + var_232_36 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_35) / var_232_36

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_35 + var_232_36 and arg_229_1.time_ < var_232_35 + var_232_36 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play413091055 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 413091055
		arg_235_1.duration_ = 5.63

		local var_235_0 = {
			zh = 4.2,
			ja = 5.633
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
				arg_235_0:Play413091056(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0.5

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:GetWordFromCfg(413091055)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 20 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 20)

				if (20 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 20)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091055", "story_v_out_413091.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091055", "story_v_out_413091.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_out_413091", "413091055", "story_v_out_413091.awb")

						arg_235_1:RecordAudio("413091055", var_238_6)
						arg_235_1:RecordAudio("413091055", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_413091", "413091055", "story_v_out_413091.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_413091", "413091055", "story_v_out_413091.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play413091056 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 413091056
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play413091057(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos10092 = arg_239_1.actors_["10092"].transform.localPosition
				arg_239_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("10092", 6)

				for iter_242_0 = 0, arg_239_1.actors_["10092"].transform.childCount - 1 do
					local var_242_0 = arg_239_1.actors_["10092"].transform:GetChild(iter_242_0)

					if var_242_0.name == "" or not string.find(var_242_0.name, "split") then
						var_242_0.gameObject:SetActive(true)
					else
						var_242_0.gameObject:SetActive(false)
					end
				end
			end

			local var_242_1 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_1 then
				arg_239_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos10092, Vector3.New(1500, -300, -295), (arg_239_1.time_ - 0) / var_242_1)
			end

			if arg_239_1.time_ >= 0 + var_242_1 and arg_239_1.time_ < 0 + var_242_1 + arg_242_0 then
				arg_239_1.actors_["10092"].transform.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_242_2 = arg_239_1.actors_["10092"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps10092 == nil then
				arg_239_1.var_.actorSpriteComps10092 = var_242_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_3 = 2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_3 and not isNil(var_242_2) then
				if arg_239_1.var_.actorSpriteComps10092 then
					for iter_242_1, iter_242_2 in pairs(arg_239_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_242_2 then
							if arg_239_1.isInRecall_ then
								iter_242_2.color = Color.New(Mathf.Lerp(iter_242_2.color.r, arg_239_1.hightColor2.r, (arg_239_1.time_ - 0) / var_242_3), Mathf.Lerp(iter_242_2.color.g, arg_239_1.hightColor2.g, (arg_239_1.time_ - 0) / var_242_3), (Mathf.Lerp(iter_242_2.color.b, arg_239_1.hightColor2.b, (arg_239_1.time_ - 0) / var_242_3)))
							else
								local var_242_4 = Mathf.Lerp(iter_242_2.color.r, 0.5, (arg_239_1.time_ - 0) / var_242_3)

								iter_242_2.color = Color.New(var_242_4, var_242_4, var_242_4)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_3 and arg_239_1.time_ < 0 + var_242_3 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps10092 then
				for iter_242_3, iter_242_4 in pairs(arg_239_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_242_4 then
						iter_242_4.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_239_1.var_.actorSpriteComps10092 = nil
			end

			local var_242_5 = 0
			local var_242_6 = 0.975

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_5 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_7 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(413091056).content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 39 <= 0 and var_242_6 or var_242_6 * (utf8.len(var_242_7) / 39)

				if (39 <= 0 and var_242_6 or var_242_6 * (utf8.len(var_242_7) / 39)) > 0 and var_242_6 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_5 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_5
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_6, arg_239_1.talkMaxDuration)

			if var_242_5 <= arg_239_1.time_ and arg_239_1.time_ < var_242_5 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_5) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_5 + var_242_10 and arg_239_1.time_ < var_242_5 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
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

		arg_239_1:InitPlayNodeList()
	end,
	Play413091057 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 413091057
		arg_243_1.duration_ = 9.63

		local var_243_0 = {
			zh = 4.133,
			ja = 9.633
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
				arg_243_0:Play413091058(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos10092 = arg_243_1.actors_["10092"].transform.localPosition
				arg_243_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("10092", 3)

				for iter_246_0 = 0, arg_243_1.actors_["10092"].transform.childCount - 1 do
					local var_246_0 = arg_243_1.actors_["10092"].transform:GetChild(iter_246_0)

					if var_246_0.name == "split_5" or not string.find(var_246_0.name, "split") then
						var_246_0.gameObject:SetActive(true)
					else
						var_246_0.gameObject:SetActive(false)
					end
				end
			end

			local var_246_1 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_1 then
				arg_243_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_243_1.time_ - 0) / var_246_1)
			end

			if arg_243_1.time_ >= 0 + var_246_1 and arg_243_1.time_ < 0 + var_246_1 + arg_246_0 then
				arg_243_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_246_2 = arg_243_1.actors_["10092"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.actorSpriteComps10092 == nil then
				arg_243_1.var_.actorSpriteComps10092 = var_246_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_3 = 2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_3 and not isNil(var_246_2) then
				if arg_243_1.var_.actorSpriteComps10092 then
					for iter_246_1, iter_246_2 in pairs(arg_243_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_246_2 then
							if arg_243_1.isInRecall_ then
								iter_246_2.color = Color.New(Mathf.Lerp(iter_246_2.color.r, arg_243_1.hightColor1.r, (arg_243_1.time_ - 0) / var_246_3), Mathf.Lerp(iter_246_2.color.g, arg_243_1.hightColor1.g, (arg_243_1.time_ - 0) / var_246_3), (Mathf.Lerp(iter_246_2.color.b, arg_243_1.hightColor1.b, (arg_243_1.time_ - 0) / var_246_3)))
							else
								local var_246_4 = Mathf.Lerp(iter_246_2.color.r, 1, (arg_243_1.time_ - 0) / var_246_3)

								iter_246_2.color = Color.New(var_246_4, var_246_4, var_246_4)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_3 and arg_243_1.time_ < 0 + var_246_3 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.actorSpriteComps10092 then
				for iter_246_3, iter_246_4 in pairs(arg_243_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_246_4 then
						iter_246_4.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_243_1.var_.actorSpriteComps10092 = nil
			end

			local var_246_5 = 0
			local var_246_6 = 0.45

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_5 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_7 = arg_243_1:GetWordFromCfg(413091057)
				local var_246_8 = arg_243_1:FormatText(var_246_7.content)

				arg_243_1.text_.text = var_246_8

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_10 = 18 <= 0 and var_246_6 or var_246_6 * (utf8.len(var_246_8) / 18)

				if (18 <= 0 and var_246_6 or var_246_6 * (utf8.len(var_246_8) / 18)) > 0 and var_246_6 < var_246_10 then
					arg_243_1.talkMaxDuration = var_246_10

					if var_246_10 + var_246_5 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_10 + var_246_5
					end
				end

				arg_243_1.text_.text = var_246_8
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091057", "story_v_out_413091.awb") ~= 0 then
					local var_246_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091057", "story_v_out_413091.awb") / 1000

					if var_246_11 + var_246_5 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_11 + var_246_5
					end

					if var_246_7.prefab_name ~= "" and arg_243_1.actors_[var_246_7.prefab_name] ~= nil then
						local var_246_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_7.prefab_name].transform, "story_v_out_413091", "413091057", "story_v_out_413091.awb")

						arg_243_1:RecordAudio("413091057", var_246_12)
						arg_243_1:RecordAudio("413091057", var_246_12)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_413091", "413091057", "story_v_out_413091.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_413091", "413091057", "story_v_out_413091.awb")
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

		arg_243_1.nodeConfigList_ = {
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

		arg_243_1:InitPlayNodeList()
	end,
	Play413091058 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 413091058
		arg_247_1.duration_ = 5.53

		local var_247_0 = {
			zh = 4.2,
			ja = 5.533
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
				arg_247_0:Play413091059(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 0.525

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_1 = arg_247_1:GetWordFromCfg(413091058)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 21 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 21)

				if (21 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 21)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091058", "story_v_out_413091.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091058", "story_v_out_413091.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_413091", "413091058", "story_v_out_413091.awb")

						arg_247_1:RecordAudio("413091058", var_250_6)
						arg_247_1:RecordAudio("413091058", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_413091", "413091058", "story_v_out_413091.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_413091", "413091058", "story_v_out_413091.awb")
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
	Play413091059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 413091059
		arg_251_1.duration_ = 8.13

		local var_251_0 = {
			zh = 5.5,
			ja = 8.133
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
				arg_251_0:Play413091060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos10092 = arg_251_1.actors_["10092"].transform.localPosition
				arg_251_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("10092", 3)

				for iter_254_0 = 0, arg_251_1.actors_["10092"].transform.childCount - 1 do
					local var_254_0 = arg_251_1.actors_["10092"].transform:GetChild(iter_254_0)

					if var_254_0.name == "split_1_1" or not string.find(var_254_0.name, "split") then
						var_254_0.gameObject:SetActive(true)
					else
						var_254_0.gameObject:SetActive(false)
					end
				end
			end

			local var_254_1 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_1 then
				arg_251_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_251_1.time_ - 0) / var_254_1)
			end

			if arg_251_1.time_ >= 0 + var_254_1 and arg_251_1.time_ < 0 + var_254_1 + arg_254_0 then
				arg_251_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_254_2 = arg_251_1.actors_["10092"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_2) and arg_251_1.var_.actorSpriteComps10092 == nil then
				arg_251_1.var_.actorSpriteComps10092 = var_254_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_3 = 2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_3 and not isNil(var_254_2) then
				if arg_251_1.var_.actorSpriteComps10092 then
					for iter_254_1, iter_254_2 in pairs(arg_251_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_254_2 then
							if arg_251_1.isInRecall_ then
								iter_254_2.color = Color.New(Mathf.Lerp(iter_254_2.color.r, arg_251_1.hightColor1.r, (arg_251_1.time_ - 0) / var_254_3), Mathf.Lerp(iter_254_2.color.g, arg_251_1.hightColor1.g, (arg_251_1.time_ - 0) / var_254_3), (Mathf.Lerp(iter_254_2.color.b, arg_251_1.hightColor1.b, (arg_251_1.time_ - 0) / var_254_3)))
							else
								local var_254_4 = Mathf.Lerp(iter_254_2.color.r, 1, (arg_251_1.time_ - 0) / var_254_3)

								iter_254_2.color = Color.New(var_254_4, var_254_4, var_254_4)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 0 + var_254_3 and arg_251_1.time_ < 0 + var_254_3 + arg_254_0 and not isNil(var_254_2) and arg_251_1.var_.actorSpriteComps10092 then
				for iter_254_3, iter_254_4 in pairs(arg_251_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_254_4 then
						iter_254_4.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_251_1.var_.actorSpriteComps10092 = nil
			end

			local var_254_5 = 0
			local var_254_6 = 0.875

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_5 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_7 = arg_251_1:GetWordFromCfg(413091059)
				local var_254_8 = arg_251_1:FormatText(var_254_7.content)

				arg_251_1.text_.text = var_254_8

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_10 = 35 <= 0 and var_254_6 or var_254_6 * (utf8.len(var_254_8) / 35)

				if (35 <= 0 and var_254_6 or var_254_6 * (utf8.len(var_254_8) / 35)) > 0 and var_254_6 < var_254_10 then
					arg_251_1.talkMaxDuration = var_254_10

					if var_254_10 + var_254_5 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_5
					end
				end

				arg_251_1.text_.text = var_254_8
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091059", "story_v_out_413091.awb") ~= 0 then
					local var_254_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091059", "story_v_out_413091.awb") / 1000

					if var_254_11 + var_254_5 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_11 + var_254_5
					end

					if var_254_7.prefab_name ~= "" and arg_251_1.actors_[var_254_7.prefab_name] ~= nil then
						local var_254_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_7.prefab_name].transform, "story_v_out_413091", "413091059", "story_v_out_413091.awb")

						arg_251_1:RecordAudio("413091059", var_254_12)
						arg_251_1:RecordAudio("413091059", var_254_12)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_413091", "413091059", "story_v_out_413091.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_413091", "413091059", "story_v_out_413091.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_13 = math.max(var_254_6, arg_251_1.talkMaxDuration)

			if var_254_5 <= arg_251_1.time_ and arg_251_1.time_ < var_254_5 + var_254_13 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_5) / var_254_13

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_5 + var_254_13 and arg_251_1.time_ < var_254_5 + var_254_13 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
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

		arg_251_1:InitPlayNodeList()
	end,
	Play413091060 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 413091060
		arg_255_1.duration_ = 5.17

		local var_255_0 = {
			zh = 4.3,
			ja = 5.166
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
				arg_255_0:Play413091061(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.525

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_1 = arg_255_1:GetWordFromCfg(413091060)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 21 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 21)

				if (21 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 21)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091060", "story_v_out_413091.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091060", "story_v_out_413091.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_413091", "413091060", "story_v_out_413091.awb")

						arg_255_1:RecordAudio("413091060", var_258_6)
						arg_255_1:RecordAudio("413091060", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_413091", "413091060", "story_v_out_413091.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_413091", "413091060", "story_v_out_413091.awb")
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
	Play413091061 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 413091061
		arg_259_1.duration_ = 7.37

		local var_259_0 = {
			zh = 4,
			ja = 7.366
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
				arg_259_0:Play413091062(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos10092 = arg_259_1.actors_["10092"].transform.localPosition
				arg_259_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("10092", 3)

				for iter_262_0 = 0, arg_259_1.actors_["10092"].transform.childCount - 1 do
					local var_262_0 = arg_259_1.actors_["10092"].transform:GetChild(iter_262_0)

					if var_262_0.name == "split_2" or not string.find(var_262_0.name, "split") then
						var_262_0.gameObject:SetActive(true)
					else
						var_262_0.gameObject:SetActive(false)
					end
				end
			end

			local var_262_1 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_1 then
				arg_259_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos10092, Vector3.New(0, -300, -295), (arg_259_1.time_ - 0) / var_262_1)
			end

			if arg_259_1.time_ >= 0 + var_262_1 and arg_259_1.time_ < 0 + var_262_1 + arg_262_0 then
				arg_259_1.actors_["10092"].transform.localPosition = Vector3.New(0, -300, -295)
			end

			local var_262_2 = arg_259_1.actors_["10092"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.actorSpriteComps10092 == nil then
				arg_259_1.var_.actorSpriteComps10092 = var_262_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_3 = 2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_3 and not isNil(var_262_2) then
				if arg_259_1.var_.actorSpriteComps10092 then
					for iter_262_1, iter_262_2 in pairs(arg_259_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_262_2 then
							if arg_259_1.isInRecall_ then
								iter_262_2.color = Color.New(Mathf.Lerp(iter_262_2.color.r, arg_259_1.hightColor1.r, (arg_259_1.time_ - 0) / var_262_3), Mathf.Lerp(iter_262_2.color.g, arg_259_1.hightColor1.g, (arg_259_1.time_ - 0) / var_262_3), (Mathf.Lerp(iter_262_2.color.b, arg_259_1.hightColor1.b, (arg_259_1.time_ - 0) / var_262_3)))
							else
								local var_262_4 = Mathf.Lerp(iter_262_2.color.r, 1, (arg_259_1.time_ - 0) / var_262_3)

								iter_262_2.color = Color.New(var_262_4, var_262_4, var_262_4)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_3 and arg_259_1.time_ < 0 + var_262_3 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.actorSpriteComps10092 then
				for iter_262_3, iter_262_4 in pairs(arg_259_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_262_4 then
						iter_262_4.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_259_1.var_.actorSpriteComps10092 = nil
			end

			local var_262_5 = 0
			local var_262_6 = 0.575

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_7 = arg_259_1:GetWordFromCfg(413091061)
				local var_262_8 = arg_259_1:FormatText(var_262_7.content)

				arg_259_1.text_.text = var_262_8

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_10 = 23 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_8) / 23)

				if (23 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_8) / 23)) > 0 and var_262_6 < var_262_10 then
					arg_259_1.talkMaxDuration = var_262_10

					if var_262_10 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_5
					end
				end

				arg_259_1.text_.text = var_262_8
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091061", "story_v_out_413091.awb") ~= 0 then
					local var_262_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091061", "story_v_out_413091.awb") / 1000

					if var_262_11 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_11 + var_262_5
					end

					if var_262_7.prefab_name ~= "" and arg_259_1.actors_[var_262_7.prefab_name] ~= nil then
						local var_262_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_7.prefab_name].transform, "story_v_out_413091", "413091061", "story_v_out_413091.awb")

						arg_259_1:RecordAudio("413091061", var_262_12)
						arg_259_1:RecordAudio("413091061", var_262_12)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_413091", "413091061", "story_v_out_413091.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_413091", "413091061", "story_v_out_413091.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_13 = math.max(var_262_6, arg_259_1.talkMaxDuration)

			if var_262_5 <= arg_259_1.time_ and arg_259_1.time_ < var_262_5 + var_262_13 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_5) / var_262_13

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_5 + var_262_13 and arg_259_1.time_ < var_262_5 + var_262_13 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
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

		arg_259_1:InitPlayNodeList()
	end,
	Play413091062 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 413091062
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play413091063(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos10092 = arg_263_1.actors_["10092"].transform.localPosition
				arg_263_1.actors_["10092"].transform.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("10092", 6)

				for iter_266_0 = 0, arg_263_1.actors_["10092"].transform.childCount - 1 do
					local var_266_0 = arg_263_1.actors_["10092"].transform:GetChild(iter_266_0)

					if var_266_0.name == "" or not string.find(var_266_0.name, "split") then
						var_266_0.gameObject:SetActive(true)
					else
						var_266_0.gameObject:SetActive(false)
					end
				end
			end

			local var_266_1 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_1 then
				arg_263_1.actors_["10092"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10092, Vector3.New(1500, -300, -295), (arg_263_1.time_ - 0) / var_266_1)
			end

			if arg_263_1.time_ >= 0 + var_266_1 and arg_263_1.time_ < 0 + var_266_1 + arg_266_0 then
				arg_263_1.actors_["10092"].transform.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_266_2 = arg_263_1.actors_["10092"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_2) and arg_263_1.var_.actorSpriteComps10092 == nil then
				arg_263_1.var_.actorSpriteComps10092 = var_266_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_266_3 = 2

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_3 and not isNil(var_266_2) then
				if arg_263_1.var_.actorSpriteComps10092 then
					for iter_266_1, iter_266_2 in pairs(arg_263_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_266_2 then
							if arg_263_1.isInRecall_ then
								iter_266_2.color = Color.New(Mathf.Lerp(iter_266_2.color.r, arg_263_1.hightColor2.r, (arg_263_1.time_ - 0) / var_266_3), Mathf.Lerp(iter_266_2.color.g, arg_263_1.hightColor2.g, (arg_263_1.time_ - 0) / var_266_3), (Mathf.Lerp(iter_266_2.color.b, arg_263_1.hightColor2.b, (arg_263_1.time_ - 0) / var_266_3)))
							else
								local var_266_4 = Mathf.Lerp(iter_266_2.color.r, 0.5, (arg_263_1.time_ - 0) / var_266_3)

								iter_266_2.color = Color.New(var_266_4, var_266_4, var_266_4)
							end
						end
					end
				end
			end

			if arg_263_1.time_ >= 0 + var_266_3 and arg_263_1.time_ < 0 + var_266_3 + arg_266_0 and not isNil(var_266_2) and arg_263_1.var_.actorSpriteComps10092 then
				for iter_266_3, iter_266_4 in pairs(arg_263_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_266_4 then
						iter_266_4.color = arg_263_1.isInRecall_ and (arg_263_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_263_1.var_.actorSpriteComps10092 = nil
			end

			local var_266_5 = 0
			local var_266_6 = 1.025

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_5 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, false)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_7 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(413091062).content)

				arg_263_1.text_.text = var_266_7

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_9 = 41 <= 0 and var_266_6 or var_266_6 * (utf8.len(var_266_7) / 41)

				if (41 <= 0 and var_266_6 or var_266_6 * (utf8.len(var_266_7) / 41)) > 0 and var_266_6 < var_266_9 then
					arg_263_1.talkMaxDuration = var_266_9

					if var_266_9 + var_266_5 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_9 + var_266_5
					end
				end

				arg_263_1.text_.text = var_266_7
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_10 = math.max(var_266_6, arg_263_1.talkMaxDuration)

			if var_266_5 <= arg_263_1.time_ and arg_263_1.time_ < var_266_5 + var_266_10 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_5) / var_266_10

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_5 + var_266_10 and arg_263_1.time_ < var_266_5 + var_266_10 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
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

		arg_263_1:InitPlayNodeList()
	end,
	Play413091063 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 413091063
		arg_267_1.duration_ = 5.83

		local var_267_0 = {
			zh = 2.766,
			ja = 5.833
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play413091064(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.4

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[996].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10092_split_6")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_1 = arg_267_1:GetWordFromCfg(413091063)
				local var_270_2 = arg_267_1:FormatText(var_270_1.content)

				arg_267_1.text_.text = var_270_2

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 16 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 16)

				if (16 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 16)) > 0 and var_270_0 < var_270_4 then
					arg_267_1.talkMaxDuration = var_270_4

					if var_270_4 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_4 + 0
					end
				end

				arg_267_1.text_.text = var_270_2
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091063", "story_v_out_413091.awb") ~= 0 then
					local var_270_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091063", "story_v_out_413091.awb") / 1000

					if var_270_5 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + 0
					end

					if var_270_1.prefab_name ~= "" and arg_267_1.actors_[var_270_1.prefab_name] ~= nil then
						local var_270_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_1.prefab_name].transform, "story_v_out_413091", "413091063", "story_v_out_413091.awb")

						arg_267_1:RecordAudio("413091063", var_270_6)
						arg_267_1:RecordAudio("413091063", var_270_6)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_413091", "413091063", "story_v_out_413091.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_413091", "413091063", "story_v_out_413091.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_7 = math.max(var_270_0, arg_267_1.talkMaxDuration)

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_7 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - 0) / var_270_7

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= 0 + var_270_7 and arg_267_1.time_ < 0 + var_270_7 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {}

		arg_267_1:InitPlayNodeList()
	end,
	Play413091064 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 413091064
		arg_271_1.duration_ = 13.17

		local var_271_0 = {
			zh = 8.86666666666667,
			ja = 13.1666666666667
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
				arg_271_0:Play413091065(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if arg_271_1.bgs_.F10g == nil then
				local var_274_0 = Object.Instantiate(arg_271_1.paintGo_)

				var_274_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F10g")
				var_274_0.name = "F10g"
				var_274_0.transform.parent = arg_271_1.stage_.transform
				var_274_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_271_1.bgs_.F10g = var_274_0
			end

			if 1.999999999999 < arg_271_1.time_ and arg_271_1.time_ <= 1.999999999999 + arg_274_0 then
				local var_274_1 = arg_271_1.bgs_.F10g

				arg_271_1.bgs_.F10g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_274_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_274_2 = var_274_1:GetComponent("SpriteRenderer")

				if var_274_2 and var_274_2.sprite then
					local var_274_3 = 2 * (var_274_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_274_1.transform.localScale = Vector3.New(var_274_3 / var_274_2.sprite.bounds.size.y < var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x and var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x or var_274_3 / var_274_2.sprite.bounds.size.y, var_274_3 / var_274_2.sprite.bounds.size.y < var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x and var_274_3 * manager.ui.mainCameraCom_.aspect / var_274_2.sprite.bounds.size.x or var_274_3 / var_274_2.sprite.bounds.size.y, 0)
				end

				for iter_274_0, iter_274_1 in pairs(arg_271_1.bgs_) do
					if iter_274_0 ~= "F10g" then
						iter_274_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_274_4 = 3.999999999999

			if 3.999999999999 < arg_271_1.time_ and arg_271_1.time_ <= var_274_4 + arg_274_0 then
				arg_271_1.allBtn_.enabled = false
			end

			if arg_271_1.time_ >= var_274_4 + 0.3 and arg_271_1.time_ < var_274_4 + 0.3 + arg_274_0 then
				arg_271_1.allBtn_.enabled = true
			end

			local var_274_5 = 0

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_6 = 2

			if var_274_5 <= arg_271_1.time_ and arg_271_1.time_ < var_274_5 + var_274_6 then
				local var_274_7 = Color.New(0, 0, 0)

				var_274_7.a = Mathf.Lerp(0, 1, (arg_271_1.time_ - var_274_5) / var_274_6)
				arg_271_1.mask_.color = var_274_7
			end

			if arg_271_1.time_ >= var_274_5 + var_274_6 and arg_271_1.time_ < var_274_5 + var_274_6 + arg_274_0 then
				local var_274_8 = Color.New(0, 0, 0)

				var_274_8.a = 1
				arg_271_1.mask_.color = var_274_8
			end

			local var_274_9 = 2

			if 2 < arg_271_1.time_ and arg_271_1.time_ <= var_274_9 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_10 = 2

			if var_274_9 <= arg_271_1.time_ and arg_271_1.time_ < var_274_9 + var_274_10 then
				local var_274_11 = Color.New(0, 0, 0)

				var_274_11.a = Mathf.Lerp(1, 0, (arg_271_1.time_ - var_274_9) / var_274_10)
				arg_271_1.mask_.color = var_274_11
			end

			if arg_271_1.time_ >= var_274_9 + var_274_10 and arg_271_1.time_ < var_274_9 + var_274_10 + arg_274_0 then
				local var_274_12 = Color.New(0, 0, 0)

				arg_271_1.mask_.enabled = false
				var_274_12.a = 0
				arg_271_1.mask_.color = var_274_12
			end

			local var_274_13 = arg_271_1.actors_["10092"].transform

			if 1.966 < arg_271_1.time_ and arg_271_1.time_ <= 1.966 + arg_274_0 then
				arg_271_1.var_.moveOldPos10092 = var_274_13.localPosition
				var_274_13.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("10092", 6)

				for iter_274_2 = 0, var_274_13.childCount - 1 do
					local var_274_14 = var_274_13:GetChild(iter_274_2)

					if var_274_14.name == "" or not string.find(var_274_14.name, "split") then
						var_274_14.gameObject:SetActive(true)
					else
						var_274_14.gameObject:SetActive(false)
					end
				end
			end

			local var_274_15 = 0.001

			if 1.966 <= arg_271_1.time_ and arg_271_1.time_ < 1.966 + var_274_15 then
				var_274_13.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10092, Vector3.New(1500, -300, -295), (arg_271_1.time_ - 1.966) / var_274_15)
			end

			if arg_271_1.time_ >= 1.966 + var_274_15 and arg_271_1.time_ < 1.966 + var_274_15 + arg_274_0 then
				var_274_13.localPosition = Vector3.New(1500, -300, -295)
			end

			local var_274_16 = arg_271_1.actors_["10097"].transform

			if 3.8 < arg_271_1.time_ and arg_271_1.time_ <= 3.8 + arg_274_0 then
				arg_271_1.var_.moveOldPos10097 = var_274_16.localPosition
				var_274_16.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("10097", 3)

				for iter_274_3 = 0, var_274_16.childCount - 1 do
					local var_274_17 = var_274_16:GetChild(iter_274_3)

					if var_274_17.name == "split_3" or not string.find(var_274_17.name, "split") then
						var_274_17.gameObject:SetActive(true)
					else
						var_274_17.gameObject:SetActive(false)
					end
				end
			end

			local var_274_18 = 0.001

			if 3.8 <= arg_271_1.time_ and arg_271_1.time_ < 3.8 + var_274_18 then
				var_274_16.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_271_1.time_ - 3.8) / var_274_18)
			end

			if arg_271_1.time_ >= 3.8 + var_274_18 and arg_271_1.time_ < 3.8 + var_274_18 + arg_274_0 then
				var_274_16.localPosition = Vector3.New(0, -350, -180)
			end

			local var_274_19 = arg_271_1.actors_["10092"]

			if 1.966 < arg_271_1.time_ and arg_271_1.time_ <= 1.966 + arg_274_0 and not isNil(var_274_19) and arg_271_1.var_.actorSpriteComps10092 == nil then
				arg_271_1.var_.actorSpriteComps10092 = var_274_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_20 = 0.0166666666666667

			if 1.966 <= arg_271_1.time_ and arg_271_1.time_ < 1.966 + var_274_20 and not isNil(var_274_19) then
				if arg_271_1.var_.actorSpriteComps10092 then
					for iter_274_4, iter_274_5 in pairs(arg_271_1.var_.actorSpriteComps10092:ToTable()) do
						if iter_274_5 then
							if arg_271_1.isInRecall_ then
								iter_274_5.color = Color.New(Mathf.Lerp(iter_274_5.color.r, arg_271_1.hightColor2.r, (arg_271_1.time_ - 1.966) / var_274_20), Mathf.Lerp(iter_274_5.color.g, arg_271_1.hightColor2.g, (arg_271_1.time_ - 1.966) / var_274_20), (Mathf.Lerp(iter_274_5.color.b, arg_271_1.hightColor2.b, (arg_271_1.time_ - 1.966) / var_274_20)))
							else
								local var_274_21 = Mathf.Lerp(iter_274_5.color.r, 0.5, (arg_271_1.time_ - 1.966) / var_274_20)

								iter_274_5.color = Color.New(var_274_21, var_274_21, var_274_21)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= 1.966 + var_274_20 and arg_271_1.time_ < 1.966 + var_274_20 + arg_274_0 and not isNil(var_274_19) and arg_271_1.var_.actorSpriteComps10092 then
				for iter_274_6, iter_274_7 in pairs(arg_271_1.var_.actorSpriteComps10092:ToTable()) do
					if iter_274_7 then
						iter_274_7.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_271_1.var_.actorSpriteComps10092 = nil
			end

			local var_274_22 = arg_271_1.actors_["10097"]

			if 3.8 < arg_271_1.time_ and arg_271_1.time_ <= 3.8 + arg_274_0 and not isNil(var_274_22) and arg_271_1.var_.actorSpriteComps10097 == nil then
				arg_271_1.var_.actorSpriteComps10097 = var_274_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_23 = 2

			if 3.8 <= arg_271_1.time_ and arg_271_1.time_ < 3.8 + var_274_23 and not isNil(var_274_22) then
				if arg_271_1.var_.actorSpriteComps10097 then
					for iter_274_8, iter_274_9 in pairs(arg_271_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_274_9 then
							if arg_271_1.isInRecall_ then
								iter_274_9.color = Color.New(Mathf.Lerp(iter_274_9.color.r, arg_271_1.hightColor1.r, (arg_271_1.time_ - 3.8) / var_274_23), Mathf.Lerp(iter_274_9.color.g, arg_271_1.hightColor1.g, (arg_271_1.time_ - 3.8) / var_274_23), (Mathf.Lerp(iter_274_9.color.b, arg_271_1.hightColor1.b, (arg_271_1.time_ - 3.8) / var_274_23)))
							else
								local var_274_24 = Mathf.Lerp(iter_274_9.color.r, 1, (arg_271_1.time_ - 3.8) / var_274_23)

								iter_274_9.color = Color.New(var_274_24, var_274_24, var_274_24)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= 3.8 + var_274_23 and arg_271_1.time_ < 3.8 + var_274_23 + arg_274_0 and not isNil(var_274_22) and arg_271_1.var_.actorSpriteComps10097 then
				for iter_274_10, iter_274_11 in pairs(arg_271_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_274_11 then
						iter_274_11.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_271_1.var_.actorSpriteComps10097 = nil
			end

			if 3.799999999999 < arg_271_1.time_ and arg_271_1.time_ <= 3.799999999999 + arg_274_0 then
				local var_274_25 = arg_271_1.actors_["10097"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_274_25 then
					arg_271_1.var_.alphaOldValue10097 = var_274_25.alpha
					arg_271_1.var_.characterEffect10097 = var_274_25
				end

				arg_271_1.var_.alphaOldValue10097 = 0
			end

			local var_274_26 = 0.2

			if 3.799999999999 <= arg_271_1.time_ and arg_271_1.time_ < 3.799999999999 + var_274_26 then
				if arg_271_1.var_.characterEffect10097 then
					arg_271_1.var_.characterEffect10097.alpha = Mathf.Lerp(arg_271_1.var_.alphaOldValue10097, 1, (arg_271_1.time_ - 3.799999999999) / var_274_26)
				end
			end

			if arg_271_1.time_ >= 3.799999999999 + var_274_26 and arg_271_1.time_ < 3.799999999999 + var_274_26 + arg_274_0 and arg_271_1.var_.characterEffect10097 then
				arg_271_1.var_.characterEffect10097.alpha = 1
			end

			if arg_271_1.frameCnt_ <= 1 then
				arg_271_1.dialog_:SetActive(false)
			end

			local var_274_27 = 4.16666666666667
			local var_274_28 = 0.475

			if 4.16666666666667 < arg_271_1.time_ and arg_271_1.time_ <= var_274_27 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0

				arg_271_1.dialog_:SetActive(true)

				arg_271_1.dialogCg_.alpha = 0

				local var_274_29 = LeanTween.value(arg_271_1.dialog_, 0, 1, 0.3)

				var_274_29:setOnUpdate(LuaHelper.FloatAction(function(arg_275_0)
					arg_271_1.dialogCg_.alpha = arg_275_0
				end))
				var_274_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_271_1.dialog_)
					var_274_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_271_1.duration_ = arg_271_1.duration_ + 0.3

				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_30 = arg_271_1:GetWordFromCfg(413091064)
				local var_274_31 = arg_271_1:FormatText(var_274_30.content)

				arg_271_1.text_.text = var_274_31

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_33 = 19 <= 0 and var_274_28 or var_274_28 * (utf8.len(var_274_31) / 19)

				if (19 <= 0 and var_274_28 or var_274_28 * (utf8.len(var_274_31) / 19)) > 0 and var_274_28 < var_274_33 then
					arg_271_1.talkMaxDuration = var_274_33
					var_274_27 = var_274_27 + 0.3

					if var_274_33 + var_274_27 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_33 + var_274_27
					end
				end

				arg_271_1.text_.text = var_274_31
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091064", "story_v_out_413091.awb") ~= 0 then
					local var_274_34 = manager.audio:GetVoiceLength("story_v_out_413091", "413091064", "story_v_out_413091.awb") / 1000

					if var_274_34 + var_274_27 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_34 + var_274_27
					end

					if var_274_30.prefab_name ~= "" and arg_271_1.actors_[var_274_30.prefab_name] ~= nil then
						local var_274_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_30.prefab_name].transform, "story_v_out_413091", "413091064", "story_v_out_413091.awb")

						arg_271_1:RecordAudio("413091064", var_274_35)
						arg_271_1:RecordAudio("413091064", var_274_35)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_413091", "413091064", "story_v_out_413091.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_413091", "413091064", "story_v_out_413091.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_36 = var_274_27 + 0.3
			local var_274_37 = math.max(var_274_28, arg_271_1.talkMaxDuration)

			if var_274_27 + 0.3 <= arg_271_1.time_ and arg_271_1.time_ < var_274_36 + var_274_37 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_36) / var_274_37

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_36 + var_274_37 and arg_271_1.time_ < var_274_36 + var_274_37 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10092",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play413091065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 413091065
		arg_277_1.duration_ = 10.7

		local var_277_0 = {
			zh = 5.566,
			ja = 10.7
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
				arg_277_0:Play413091066(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.var_.moveOldPos10097 = arg_277_1.actors_["10097"].transform.localPosition
				arg_277_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_277_1:CheckSpriteTmpPos("10097", 3)

				for iter_280_0 = 0, arg_277_1.actors_["10097"].transform.childCount - 1 do
					local var_280_0 = arg_277_1.actors_["10097"].transform:GetChild(iter_280_0)

					if var_280_0.name == "" or not string.find(var_280_0.name, "split") then
						var_280_0.gameObject:SetActive(true)
					else
						var_280_0.gameObject:SetActive(false)
					end
				end
			end

			local var_280_1 = 0.001

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_1 then
				arg_277_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_277_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_277_1.time_ - 0) / var_280_1)
			end

			if arg_277_1.time_ >= 0 + var_280_1 and arg_277_1.time_ < 0 + var_280_1 + arg_280_0 then
				arg_277_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_280_2 = arg_277_1.actors_["10097"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps10097 == nil then
				arg_277_1.var_.actorSpriteComps10097 = var_280_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_280_3 = 2

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 and not isNil(var_280_2) then
				if arg_277_1.var_.actorSpriteComps10097 then
					for iter_280_1, iter_280_2 in pairs(arg_277_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_280_2 then
							if arg_277_1.isInRecall_ then
								iter_280_2.color = Color.New(Mathf.Lerp(iter_280_2.color.r, arg_277_1.hightColor1.r, (arg_277_1.time_ - 0) / var_280_3), Mathf.Lerp(iter_280_2.color.g, arg_277_1.hightColor1.g, (arg_277_1.time_ - 0) / var_280_3), (Mathf.Lerp(iter_280_2.color.b, arg_277_1.hightColor1.b, (arg_277_1.time_ - 0) / var_280_3)))
							else
								local var_280_4 = Mathf.Lerp(iter_280_2.color.r, 1, (arg_277_1.time_ - 0) / var_280_3)

								iter_280_2.color = Color.New(var_280_4, var_280_4, var_280_4)
							end
						end
					end
				end
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.actorSpriteComps10097 then
				for iter_280_3, iter_280_4 in pairs(arg_277_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_280_4 then
						iter_280_4.color = arg_277_1.isInRecall_ and (arg_277_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_277_1.var_.actorSpriteComps10097 = nil
			end

			local var_280_5 = 0
			local var_280_6 = 0.6

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_5 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_7 = arg_277_1:GetWordFromCfg(413091065)
				local var_280_8 = arg_277_1:FormatText(var_280_7.content)

				arg_277_1.text_.text = var_280_8

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_10 = 24 <= 0 and var_280_6 or var_280_6 * (utf8.len(var_280_8) / 24)

				if (24 <= 0 and var_280_6 or var_280_6 * (utf8.len(var_280_8) / 24)) > 0 and var_280_6 < var_280_10 then
					arg_277_1.talkMaxDuration = var_280_10

					if var_280_10 + var_280_5 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_5
					end
				end

				arg_277_1.text_.text = var_280_8
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091065", "story_v_out_413091.awb") ~= 0 then
					local var_280_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091065", "story_v_out_413091.awb") / 1000

					if var_280_11 + var_280_5 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_11 + var_280_5
					end

					if var_280_7.prefab_name ~= "" and arg_277_1.actors_[var_280_7.prefab_name] ~= nil then
						local var_280_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_7.prefab_name].transform, "story_v_out_413091", "413091065", "story_v_out_413091.awb")

						arg_277_1:RecordAudio("413091065", var_280_12)
						arg_277_1:RecordAudio("413091065", var_280_12)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_out_413091", "413091065", "story_v_out_413091.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_out_413091", "413091065", "story_v_out_413091.awb")
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

		arg_277_1.nodeConfigList_ = {
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

		arg_277_1:InitPlayNodeList()
	end,
	Play413091066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 413091066
		arg_281_1.duration_ = 2

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play413091067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.var_.moveOldPos10097 = arg_281_1.actors_["10097"].transform.localPosition
				arg_281_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_281_1:CheckSpriteTmpPos("10097", 6)

				for iter_284_0 = 0, arg_281_1.actors_["10097"].transform.childCount - 1 do
					local var_284_0 = arg_281_1.actors_["10097"].transform:GetChild(iter_284_0)

					if var_284_0.name == "" or not string.find(var_284_0.name, "split") then
						var_284_0.gameObject:SetActive(true)
					else
						var_284_0.gameObject:SetActive(false)
					end
				end
			end

			local var_284_1 = 0.001

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_1 then
				arg_281_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10097, Vector3.New(1500, -350, -180), (arg_281_1.time_ - 0) / var_284_1)
			end

			if arg_281_1.time_ >= 0 + var_284_1 and arg_281_1.time_ < 0 + var_284_1 + arg_284_0 then
				arg_281_1.actors_["10097"].transform.localPosition = Vector3.New(1500, -350, -180)
			end

			local var_284_2 = arg_281_1.actors_["10097"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps10097 == nil then
				arg_281_1.var_.actorSpriteComps10097 = var_284_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_284_3 = 2

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.actorSpriteComps10097 then
					for iter_284_1, iter_284_2 in pairs(arg_281_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_284_2 then
							if arg_281_1.isInRecall_ then
								iter_284_2.color = Color.New(Mathf.Lerp(iter_284_2.color.r, arg_281_1.hightColor2.r, (arg_281_1.time_ - 0) / var_284_3), Mathf.Lerp(iter_284_2.color.g, arg_281_1.hightColor2.g, (arg_281_1.time_ - 0) / var_284_3), (Mathf.Lerp(iter_284_2.color.b, arg_281_1.hightColor2.b, (arg_281_1.time_ - 0) / var_284_3)))
							else
								local var_284_4 = Mathf.Lerp(iter_284_2.color.r, 0.5, (arg_281_1.time_ - 0) / var_284_3)

								iter_284_2.color = Color.New(var_284_4, var_284_4, var_284_4)
							end
						end
					end
				end
			end

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.actorSpriteComps10097 then
				for iter_284_3, iter_284_4 in pairs(arg_281_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_284_4 then
						iter_284_4.color = arg_281_1.isInRecall_ and (arg_281_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_281_1.var_.actorSpriteComps10097 = nil
			end

			local var_284_5 = 0
			local var_284_6 = 0.175

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_5 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10093_split_3")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_7 = arg_281_1:GetWordFromCfg(413091066)
				local var_284_8 = arg_281_1:FormatText(var_284_7.content)

				arg_281_1.text_.text = var_284_8

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_10 = 7 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 7)

				if (7 <= 0 and var_284_6 or var_284_6 * (utf8.len(var_284_8) / 7)) > 0 and var_284_6 < var_284_10 then
					arg_281_1.talkMaxDuration = var_284_10

					if var_284_10 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_10 + var_284_5
					end
				end

				arg_281_1.text_.text = var_284_8
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091066", "story_v_out_413091.awb") ~= 0 then
					local var_284_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091066", "story_v_out_413091.awb") / 1000

					if var_284_11 + var_284_5 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_11 + var_284_5
					end

					if var_284_7.prefab_name ~= "" and arg_281_1.actors_[var_284_7.prefab_name] ~= nil then
						local var_284_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_7.prefab_name].transform, "story_v_out_413091", "413091066", "story_v_out_413091.awb")

						arg_281_1:RecordAudio("413091066", var_284_12)
						arg_281_1:RecordAudio("413091066", var_284_12)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_413091", "413091066", "story_v_out_413091.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_413091", "413091066", "story_v_out_413091.awb")
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

		arg_281_1.nodeConfigList_ = {
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

		arg_281_1:InitPlayNodeList()
	end,
	Play413091067 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 413091067
		arg_285_1.duration_ = 3.87

		local var_285_0 = {
			zh = 3.166,
			ja = 3.866
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
				arg_285_0:Play413091068(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.var_.moveOldPos10097 = arg_285_1.actors_["10097"].transform.localPosition
				arg_285_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_285_1:CheckSpriteTmpPos("10097", 3)

				for iter_288_0 = 0, arg_285_1.actors_["10097"].transform.childCount - 1 do
					local var_288_0 = arg_285_1.actors_["10097"].transform:GetChild(iter_288_0)

					if var_288_0.name == "split_2" or not string.find(var_288_0.name, "split") then
						var_288_0.gameObject:SetActive(true)
					else
						var_288_0.gameObject:SetActive(false)
					end
				end
			end

			local var_288_1 = 0.001

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_1 then
				arg_285_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_285_1.time_ - 0) / var_288_1)
			end

			if arg_285_1.time_ >= 0 + var_288_1 and arg_285_1.time_ < 0 + var_288_1 + arg_288_0 then
				arg_285_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_288_2 = arg_285_1.actors_["10097"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.actorSpriteComps10097 == nil then
				arg_285_1.var_.actorSpriteComps10097 = var_288_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_288_3 = 2

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 and not isNil(var_288_2) then
				if arg_285_1.var_.actorSpriteComps10097 then
					for iter_288_1, iter_288_2 in pairs(arg_285_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_288_2 then
							if arg_285_1.isInRecall_ then
								iter_288_2.color = Color.New(Mathf.Lerp(iter_288_2.color.r, arg_285_1.hightColor1.r, (arg_285_1.time_ - 0) / var_288_3), Mathf.Lerp(iter_288_2.color.g, arg_285_1.hightColor1.g, (arg_285_1.time_ - 0) / var_288_3), (Mathf.Lerp(iter_288_2.color.b, arg_285_1.hightColor1.b, (arg_285_1.time_ - 0) / var_288_3)))
							else
								local var_288_4 = Mathf.Lerp(iter_288_2.color.r, 1, (arg_285_1.time_ - 0) / var_288_3)

								iter_288_2.color = Color.New(var_288_4, var_288_4, var_288_4)
							end
						end
					end
				end
			end

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.actorSpriteComps10097 then
				for iter_288_3, iter_288_4 in pairs(arg_285_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_288_4 then
						iter_288_4.color = arg_285_1.isInRecall_ and (arg_285_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_285_1.var_.actorSpriteComps10097 = nil
			end

			local var_288_5 = 0
			local var_288_6 = 0.35

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_5 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_7 = arg_285_1:GetWordFromCfg(413091067)
				local var_288_8 = arg_285_1:FormatText(var_288_7.content)

				arg_285_1.text_.text = var_288_8

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_10 = 14 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_8) / 14)

				if (14 <= 0 and var_288_6 or var_288_6 * (utf8.len(var_288_8) / 14)) > 0 and var_288_6 < var_288_10 then
					arg_285_1.talkMaxDuration = var_288_10

					if var_288_10 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_10 + var_288_5
					end
				end

				arg_285_1.text_.text = var_288_8
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091067", "story_v_out_413091.awb") ~= 0 then
					local var_288_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091067", "story_v_out_413091.awb") / 1000

					if var_288_11 + var_288_5 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_11 + var_288_5
					end

					if var_288_7.prefab_name ~= "" and arg_285_1.actors_[var_288_7.prefab_name] ~= nil then
						local var_288_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_7.prefab_name].transform, "story_v_out_413091", "413091067", "story_v_out_413091.awb")

						arg_285_1:RecordAudio("413091067", var_288_12)
						arg_285_1:RecordAudio("413091067", var_288_12)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_413091", "413091067", "story_v_out_413091.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_413091", "413091067", "story_v_out_413091.awb")
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

		arg_285_1.nodeConfigList_ = {
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

		arg_285_1:InitPlayNodeList()
	end,
	Play413091068 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 413091068
		arg_289_1.duration_ = 5.73

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play413091069(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos10097 = arg_289_1.actors_["10097"].transform.localPosition
				arg_289_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_289_1:CheckSpriteTmpPos("10097", 7)

				for iter_292_0 = 0, arg_289_1.actors_["10097"].transform.childCount - 1 do
					local var_292_0 = arg_289_1.actors_["10097"].transform:GetChild(iter_292_0)

					if var_292_0.name == "" or not string.find(var_292_0.name, "split") then
						var_292_0.gameObject:SetActive(true)
					else
						var_292_0.gameObject:SetActive(false)
					end
				end
			end

			local var_292_1 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_1 then
				arg_289_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10097, Vector3.New(0, -2000, -180), (arg_289_1.time_ - 0) / var_292_1)
			end

			if arg_289_1.time_ >= 0 + var_292_1 and arg_289_1.time_ < 0 + var_292_1 + arg_292_0 then
				arg_289_1.actors_["10097"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_292_2 = arg_289_1.actors_["10097"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps10097 == nil then
				arg_289_1.var_.actorSpriteComps10097 = var_292_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_292_3 = 2

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_3 and not isNil(var_292_2) then
				if arg_289_1.var_.actorSpriteComps10097 then
					for iter_292_1, iter_292_2 in pairs(arg_289_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_292_2 then
							if arg_289_1.isInRecall_ then
								iter_292_2.color = Color.New(Mathf.Lerp(iter_292_2.color.r, arg_289_1.hightColor2.r, (arg_289_1.time_ - 0) / var_292_3), Mathf.Lerp(iter_292_2.color.g, arg_289_1.hightColor2.g, (arg_289_1.time_ - 0) / var_292_3), (Mathf.Lerp(iter_292_2.color.b, arg_289_1.hightColor2.b, (arg_289_1.time_ - 0) / var_292_3)))
							else
								local var_292_4 = Mathf.Lerp(iter_292_2.color.r, 0.5, (arg_289_1.time_ - 0) / var_292_3)

								iter_292_2.color = Color.New(var_292_4, var_292_4, var_292_4)
							end
						end
					end
				end
			end

			if arg_289_1.time_ >= 0 + var_292_3 and arg_289_1.time_ < 0 + var_292_3 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.actorSpriteComps10097 then
				for iter_292_3, iter_292_4 in pairs(arg_289_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_292_4 then
						iter_292_4.color = arg_289_1.isInRecall_ and (arg_289_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_289_1.var_.actorSpriteComps10097 = nil
			end

			local var_292_5 = 0

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_5 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_6 = 0.6

			if var_292_5 <= arg_289_1.time_ and arg_289_1.time_ < var_292_5 + var_292_6 then
				local var_292_7 = Color.New(1, 1, 1)

				var_292_7.a = Mathf.Lerp(1, 0, (arg_289_1.time_ - var_292_5) / var_292_6)
				arg_289_1.mask_.color = var_292_7
			end

			if arg_289_1.time_ >= var_292_5 + var_292_6 and arg_289_1.time_ < var_292_5 + var_292_6 + arg_292_0 then
				local var_292_8 = Color.New(1, 1, 1)

				arg_289_1.mask_.enabled = false
				var_292_8.a = 0
				arg_289_1.mask_.color = var_292_8
			end

			if arg_289_1.frameCnt_ <= 1 then
				arg_289_1.dialog_:SetActive(false)
			end

			local var_292_9 = 0.733333333333333
			local var_292_10 = 0.75

			if 0.733333333333333 < arg_289_1.time_ and arg_289_1.time_ <= var_292_9 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				arg_289_1.dialog_:SetActive(true)

				arg_289_1.dialogCg_.alpha = 0

				local var_292_11 = LeanTween.value(arg_289_1.dialog_, 0, 1, 0.3)

				var_292_11:setOnUpdate(LuaHelper.FloatAction(function(arg_293_0)
					arg_289_1.dialogCg_.alpha = arg_293_0
				end))
				var_292_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_289_1.dialog_)
					var_292_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_289_1.duration_ = arg_289_1.duration_ + 0.3

				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_12 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(413091068).content)

				arg_289_1.text_.text = var_292_12

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_14 = 30 <= 0 and var_292_10 or var_292_10 * (utf8.len(var_292_12) / 30)

				if (30 <= 0 and var_292_10 or var_292_10 * (utf8.len(var_292_12) / 30)) > 0 and var_292_10 < var_292_14 then
					arg_289_1.talkMaxDuration = var_292_14
					var_292_9 = var_292_9 + 0.3

					if var_292_14 + var_292_9 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_14 + var_292_9
					end
				end

				arg_289_1.text_.text = var_292_12
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_15 = var_292_9 + 0.3
			local var_292_16 = math.max(var_292_10, arg_289_1.talkMaxDuration)

			if var_292_9 + 0.3 <= arg_289_1.time_ and arg_289_1.time_ < var_292_15 + var_292_16 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_15) / var_292_16

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_15 + var_292_16 and arg_289_1.time_ < var_292_15 + var_292_16 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
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

		arg_289_1:InitPlayNodeList()
	end,
	Play413091069 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 413091069
		arg_295_1.duration_ = 2

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play413091070(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos10093 = arg_295_1.actors_["10093"].transform.localPosition
				arg_295_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("10093", 2)

				for iter_298_0 = 0, arg_295_1.actors_["10093"].transform.childCount - 1 do
					local var_298_0 = arg_295_1.actors_["10093"].transform:GetChild(iter_298_0)

					if var_298_0.name == "split_3" or not string.find(var_298_0.name, "split") then
						var_298_0.gameObject:SetActive(true)
					else
						var_298_0.gameObject:SetActive(false)
					end
				end
			end

			local var_298_1 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_1 then
				arg_295_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_295_1.time_ - 0) / var_298_1)
			end

			if arg_295_1.time_ >= 0 + var_298_1 and arg_295_1.time_ < 0 + var_298_1 + arg_298_0 then
				arg_295_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_298_2 = arg_295_1.actors_["10093"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_2) and arg_295_1.var_.actorSpriteComps10093 == nil then
				arg_295_1.var_.actorSpriteComps10093 = var_298_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_3 = 2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_3 and not isNil(var_298_2) then
				if arg_295_1.var_.actorSpriteComps10093 then
					for iter_298_1, iter_298_2 in pairs(arg_295_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_298_2 then
							if arg_295_1.isInRecall_ then
								iter_298_2.color = Color.New(Mathf.Lerp(iter_298_2.color.r, arg_295_1.hightColor1.r, (arg_295_1.time_ - 0) / var_298_3), Mathf.Lerp(iter_298_2.color.g, arg_295_1.hightColor1.g, (arg_295_1.time_ - 0) / var_298_3), (Mathf.Lerp(iter_298_2.color.b, arg_295_1.hightColor1.b, (arg_295_1.time_ - 0) / var_298_3)))
							else
								local var_298_4 = Mathf.Lerp(iter_298_2.color.r, 1, (arg_295_1.time_ - 0) / var_298_3)

								iter_298_2.color = Color.New(var_298_4, var_298_4, var_298_4)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= 0 + var_298_3 and arg_295_1.time_ < 0 + var_298_3 + arg_298_0 and not isNil(var_298_2) and arg_295_1.var_.actorSpriteComps10093 then
				for iter_298_3, iter_298_4 in pairs(arg_295_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_298_4 then
						iter_298_4.color = arg_295_1.isInRecall_ and (arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_295_1.var_.actorSpriteComps10093 = nil
			end

			local var_298_5 = 0
			local var_298_6 = 0.175

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_5 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_7 = arg_295_1:GetWordFromCfg(413091069)
				local var_298_8 = arg_295_1:FormatText(var_298_7.content)

				arg_295_1.text_.text = var_298_8

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_10 = 7 <= 0 and var_298_6 or var_298_6 * (utf8.len(var_298_8) / 7)

				if (7 <= 0 and var_298_6 or var_298_6 * (utf8.len(var_298_8) / 7)) > 0 and var_298_6 < var_298_10 then
					arg_295_1.talkMaxDuration = var_298_10

					if var_298_10 + var_298_5 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_10 + var_298_5
					end
				end

				arg_295_1.text_.text = var_298_8
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091069", "story_v_out_413091.awb") ~= 0 then
					local var_298_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091069", "story_v_out_413091.awb") / 1000

					if var_298_11 + var_298_5 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_11 + var_298_5
					end

					if var_298_7.prefab_name ~= "" and arg_295_1.actors_[var_298_7.prefab_name] ~= nil then
						local var_298_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_7.prefab_name].transform, "story_v_out_413091", "413091069", "story_v_out_413091.awb")

						arg_295_1:RecordAudio("413091069", var_298_12)
						arg_295_1:RecordAudio("413091069", var_298_12)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_413091", "413091069", "story_v_out_413091.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_413091", "413091069", "story_v_out_413091.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_13 = math.max(var_298_6, arg_295_1.talkMaxDuration)

			if var_298_5 <= arg_295_1.time_ and arg_295_1.time_ < var_298_5 + var_298_13 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_5) / var_298_13

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_5 + var_298_13 and arg_295_1.time_ < var_298_5 + var_298_13 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
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

		arg_295_1:InitPlayNodeList()
	end,
	Play413091070 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 413091070
		arg_299_1.duration_ = 8.33

		local var_299_0 = {
			zh = 8.266,
			ja = 8.333
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
				arg_299_0:Play413091071(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos10097 = arg_299_1.actors_["10097"].transform.localPosition
				arg_299_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("10097", 4)

				for iter_302_0 = 0, arg_299_1.actors_["10097"].transform.childCount - 1 do
					local var_302_0 = arg_299_1.actors_["10097"].transform:GetChild(iter_302_0)

					if var_302_0.name == "split_2" or not string.find(var_302_0.name, "split") then
						var_302_0.gameObject:SetActive(true)
					else
						var_302_0.gameObject:SetActive(false)
					end
				end
			end

			local var_302_1 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_1 then
				arg_299_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_299_1.time_ - 0) / var_302_1)
			end

			if arg_299_1.time_ >= 0 + var_302_1 and arg_299_1.time_ < 0 + var_302_1 + arg_302_0 then
				arg_299_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_302_2 = arg_299_1.actors_["10097"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps10097 == nil then
				arg_299_1.var_.actorSpriteComps10097 = var_302_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_3 = 2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_3 and not isNil(var_302_2) then
				if arg_299_1.var_.actorSpriteComps10097 then
					for iter_302_1, iter_302_2 in pairs(arg_299_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_302_2 then
							if arg_299_1.isInRecall_ then
								iter_302_2.color = Color.New(Mathf.Lerp(iter_302_2.color.r, arg_299_1.hightColor1.r, (arg_299_1.time_ - 0) / var_302_3), Mathf.Lerp(iter_302_2.color.g, arg_299_1.hightColor1.g, (arg_299_1.time_ - 0) / var_302_3), (Mathf.Lerp(iter_302_2.color.b, arg_299_1.hightColor1.b, (arg_299_1.time_ - 0) / var_302_3)))
							else
								local var_302_4 = Mathf.Lerp(iter_302_2.color.r, 1, (arg_299_1.time_ - 0) / var_302_3)

								iter_302_2.color = Color.New(var_302_4, var_302_4, var_302_4)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= 0 + var_302_3 and arg_299_1.time_ < 0 + var_302_3 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps10097 then
				for iter_302_3, iter_302_4 in pairs(arg_299_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_302_4 then
						iter_302_4.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_299_1.var_.actorSpriteComps10097 = nil
			end

			local var_302_5 = arg_299_1.actors_["10093"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_5) and arg_299_1.var_.actorSpriteComps10093 == nil then
				arg_299_1.var_.actorSpriteComps10093 = var_302_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_6 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_6 and not isNil(var_302_5) then
				if arg_299_1.var_.actorSpriteComps10093 then
					for iter_302_5, iter_302_6 in pairs(arg_299_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_302_6 then
							if arg_299_1.isInRecall_ then
								iter_302_6.color = Color.New(Mathf.Lerp(iter_302_6.color.r, arg_299_1.hightColor2.r, (arg_299_1.time_ - 0) / var_302_6), Mathf.Lerp(iter_302_6.color.g, arg_299_1.hightColor2.g, (arg_299_1.time_ - 0) / var_302_6), (Mathf.Lerp(iter_302_6.color.b, arg_299_1.hightColor2.b, (arg_299_1.time_ - 0) / var_302_6)))
							else
								local var_302_7 = Mathf.Lerp(iter_302_6.color.r, 0.5, (arg_299_1.time_ - 0) / var_302_6)

								iter_302_6.color = Color.New(var_302_7, var_302_7, var_302_7)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= 0 + var_302_6 and arg_299_1.time_ < 0 + var_302_6 + arg_302_0 and not isNil(var_302_5) and arg_299_1.var_.actorSpriteComps10093 then
				for iter_302_7, iter_302_8 in pairs(arg_299_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_302_8 then
						iter_302_8.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_299_1.var_.actorSpriteComps10093 = nil
			end

			local var_302_8 = 0
			local var_302_9 = 0.8

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_8 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_10 = arg_299_1:GetWordFromCfg(413091070)
				local var_302_11 = arg_299_1:FormatText(var_302_10.content)

				arg_299_1.text_.text = var_302_11

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_13 = 32 <= 0 and var_302_9 or var_302_9 * (utf8.len(var_302_11) / 32)

				if (32 <= 0 and var_302_9 or var_302_9 * (utf8.len(var_302_11) / 32)) > 0 and var_302_9 < var_302_13 then
					arg_299_1.talkMaxDuration = var_302_13

					if var_302_13 + var_302_8 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_13 + var_302_8
					end
				end

				arg_299_1.text_.text = var_302_11
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091070", "story_v_out_413091.awb") ~= 0 then
					local var_302_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091070", "story_v_out_413091.awb") / 1000

					if var_302_14 + var_302_8 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_14 + var_302_8
					end

					if var_302_10.prefab_name ~= "" and arg_299_1.actors_[var_302_10.prefab_name] ~= nil then
						local var_302_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_10.prefab_name].transform, "story_v_out_413091", "413091070", "story_v_out_413091.awb")

						arg_299_1:RecordAudio("413091070", var_302_15)
						arg_299_1:RecordAudio("413091070", var_302_15)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_413091", "413091070", "story_v_out_413091.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_413091", "413091070", "story_v_out_413091.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_16 = math.max(var_302_9, arg_299_1.talkMaxDuration)

			if var_302_8 <= arg_299_1.time_ and arg_299_1.time_ < var_302_8 + var_302_16 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_8) / var_302_16

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_8 + var_302_16 and arg_299_1.time_ < var_302_8 + var_302_16 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
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

		arg_299_1:InitPlayNodeList()
	end,
	Play413091071 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 413091071
		arg_303_1.duration_ = 5.17

		local var_303_0 = {
			zh = 4.366,
			ja = 5.166
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
				arg_303_0:Play413091072(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.var_.moveOldPos10093 = arg_303_1.actors_["10093"].transform.localPosition
				arg_303_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_303_1:CheckSpriteTmpPos("10093", 2)

				for iter_306_0 = 0, arg_303_1.actors_["10093"].transform.childCount - 1 do
					local var_306_0 = arg_303_1.actors_["10093"].transform:GetChild(iter_306_0)

					if var_306_0.name == "split_5" or not string.find(var_306_0.name, "split") then
						var_306_0.gameObject:SetActive(true)
					else
						var_306_0.gameObject:SetActive(false)
					end
				end
			end

			local var_306_1 = 0.001

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_1 then
				arg_303_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_303_1.time_ - 0) / var_306_1)
			end

			if arg_303_1.time_ >= 0 + var_306_1 and arg_303_1.time_ < 0 + var_306_1 + arg_306_0 then
				arg_303_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_306_2 = arg_303_1.actors_["10093"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_2) and arg_303_1.var_.actorSpriteComps10093 == nil then
				arg_303_1.var_.actorSpriteComps10093 = var_306_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_3 = 2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_3 and not isNil(var_306_2) then
				if arg_303_1.var_.actorSpriteComps10093 then
					for iter_306_1, iter_306_2 in pairs(arg_303_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_306_2 then
							if arg_303_1.isInRecall_ then
								iter_306_2.color = Color.New(Mathf.Lerp(iter_306_2.color.r, arg_303_1.hightColor1.r, (arg_303_1.time_ - 0) / var_306_3), Mathf.Lerp(iter_306_2.color.g, arg_303_1.hightColor1.g, (arg_303_1.time_ - 0) / var_306_3), (Mathf.Lerp(iter_306_2.color.b, arg_303_1.hightColor1.b, (arg_303_1.time_ - 0) / var_306_3)))
							else
								local var_306_4 = Mathf.Lerp(iter_306_2.color.r, 1, (arg_303_1.time_ - 0) / var_306_3)

								iter_306_2.color = Color.New(var_306_4, var_306_4, var_306_4)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= 0 + var_306_3 and arg_303_1.time_ < 0 + var_306_3 + arg_306_0 and not isNil(var_306_2) and arg_303_1.var_.actorSpriteComps10093 then
				for iter_306_3, iter_306_4 in pairs(arg_303_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_306_4 then
						iter_306_4.color = arg_303_1.isInRecall_ and (arg_303_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_303_1.var_.actorSpriteComps10093 = nil
			end

			local var_306_5 = arg_303_1.actors_["10097"]

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 and not isNil(var_306_5) and arg_303_1.var_.actorSpriteComps10097 == nil then
				arg_303_1.var_.actorSpriteComps10097 = var_306_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_306_6 = 0.2

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_6 and not isNil(var_306_5) then
				if arg_303_1.var_.actorSpriteComps10097 then
					for iter_306_5, iter_306_6 in pairs(arg_303_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_306_6 then
							if arg_303_1.isInRecall_ then
								iter_306_6.color = Color.New(Mathf.Lerp(iter_306_6.color.r, arg_303_1.hightColor2.r, (arg_303_1.time_ - 0) / var_306_6), Mathf.Lerp(iter_306_6.color.g, arg_303_1.hightColor2.g, (arg_303_1.time_ - 0) / var_306_6), (Mathf.Lerp(iter_306_6.color.b, arg_303_1.hightColor2.b, (arg_303_1.time_ - 0) / var_306_6)))
							else
								local var_306_7 = Mathf.Lerp(iter_306_6.color.r, 0.5, (arg_303_1.time_ - 0) / var_306_6)

								iter_306_6.color = Color.New(var_306_7, var_306_7, var_306_7)
							end
						end
					end
				end
			end

			if arg_303_1.time_ >= 0 + var_306_6 and arg_303_1.time_ < 0 + var_306_6 + arg_306_0 and not isNil(var_306_5) and arg_303_1.var_.actorSpriteComps10097 then
				for iter_306_7, iter_306_8 in pairs(arg_303_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_306_8 then
						iter_306_8.color = arg_303_1.isInRecall_ and (arg_303_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_303_1.var_.actorSpriteComps10097 = nil
			end

			local var_306_8 = 0
			local var_306_9 = 0.725

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_8 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_10 = arg_303_1:GetWordFromCfg(413091071)
				local var_306_11 = arg_303_1:FormatText(var_306_10.content)

				arg_303_1.text_.text = var_306_11

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_13 = 28 <= 0 and var_306_9 or var_306_9 * (utf8.len(var_306_11) / 28)

				if (28 <= 0 and var_306_9 or var_306_9 * (utf8.len(var_306_11) / 28)) > 0 and var_306_9 < var_306_13 then
					arg_303_1.talkMaxDuration = var_306_13

					if var_306_13 + var_306_8 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_13 + var_306_8
					end
				end

				arg_303_1.text_.text = var_306_11
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091071", "story_v_out_413091.awb") ~= 0 then
					local var_306_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091071", "story_v_out_413091.awb") / 1000

					if var_306_14 + var_306_8 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_14 + var_306_8
					end

					if var_306_10.prefab_name ~= "" and arg_303_1.actors_[var_306_10.prefab_name] ~= nil then
						local var_306_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_10.prefab_name].transform, "story_v_out_413091", "413091071", "story_v_out_413091.awb")

						arg_303_1:RecordAudio("413091071", var_306_15)
						arg_303_1:RecordAudio("413091071", var_306_15)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_413091", "413091071", "story_v_out_413091.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_413091", "413091071", "story_v_out_413091.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_16 = math.max(var_306_9, arg_303_1.talkMaxDuration)

			if var_306_8 <= arg_303_1.time_ and arg_303_1.time_ < var_306_8 + var_306_16 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_8) / var_306_16

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_8 + var_306_16 and arg_303_1.time_ < var_306_8 + var_306_16 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
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

		arg_303_1:InitPlayNodeList()
	end,
	Play413091072 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 413091072
		arg_307_1.duration_ = 8.1

		local var_307_0 = {
			zh = 6.133,
			ja = 8.1
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
				arg_307_0:Play413091073(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos10097 = arg_307_1.actors_["10097"].transform.localPosition
				arg_307_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("10097", 4)

				for iter_310_0 = 0, arg_307_1.actors_["10097"].transform.childCount - 1 do
					local var_310_0 = arg_307_1.actors_["10097"].transform:GetChild(iter_310_0)

					if var_310_0.name == "split_1" or not string.find(var_310_0.name, "split") then
						var_310_0.gameObject:SetActive(true)
					else
						var_310_0.gameObject:SetActive(false)
					end
				end
			end

			local var_310_1 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_1 then
				arg_307_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_307_1.time_ - 0) / var_310_1)
			end

			if arg_307_1.time_ >= 0 + var_310_1 and arg_307_1.time_ < 0 + var_310_1 + arg_310_0 then
				arg_307_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_310_2 = arg_307_1.actors_["10097"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_2) and arg_307_1.var_.actorSpriteComps10097 == nil then
				arg_307_1.var_.actorSpriteComps10097 = var_310_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_3 = 2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_3 and not isNil(var_310_2) then
				if arg_307_1.var_.actorSpriteComps10097 then
					for iter_310_1, iter_310_2 in pairs(arg_307_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_310_2 then
							if arg_307_1.isInRecall_ then
								iter_310_2.color = Color.New(Mathf.Lerp(iter_310_2.color.r, arg_307_1.hightColor1.r, (arg_307_1.time_ - 0) / var_310_3), Mathf.Lerp(iter_310_2.color.g, arg_307_1.hightColor1.g, (arg_307_1.time_ - 0) / var_310_3), (Mathf.Lerp(iter_310_2.color.b, arg_307_1.hightColor1.b, (arg_307_1.time_ - 0) / var_310_3)))
							else
								local var_310_4 = Mathf.Lerp(iter_310_2.color.r, 1, (arg_307_1.time_ - 0) / var_310_3)

								iter_310_2.color = Color.New(var_310_4, var_310_4, var_310_4)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= 0 + var_310_3 and arg_307_1.time_ < 0 + var_310_3 + arg_310_0 and not isNil(var_310_2) and arg_307_1.var_.actorSpriteComps10097 then
				for iter_310_3, iter_310_4 in pairs(arg_307_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_310_4 then
						iter_310_4.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_307_1.var_.actorSpriteComps10097 = nil
			end

			local var_310_5 = arg_307_1.actors_["10093"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_5) and arg_307_1.var_.actorSpriteComps10093 == nil then
				arg_307_1.var_.actorSpriteComps10093 = var_310_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_6 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_6 and not isNil(var_310_5) then
				if arg_307_1.var_.actorSpriteComps10093 then
					for iter_310_5, iter_310_6 in pairs(arg_307_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_310_6 then
							if arg_307_1.isInRecall_ then
								iter_310_6.color = Color.New(Mathf.Lerp(iter_310_6.color.r, arg_307_1.hightColor2.r, (arg_307_1.time_ - 0) / var_310_6), Mathf.Lerp(iter_310_6.color.g, arg_307_1.hightColor2.g, (arg_307_1.time_ - 0) / var_310_6), (Mathf.Lerp(iter_310_6.color.b, arg_307_1.hightColor2.b, (arg_307_1.time_ - 0) / var_310_6)))
							else
								local var_310_7 = Mathf.Lerp(iter_310_6.color.r, 0.5, (arg_307_1.time_ - 0) / var_310_6)

								iter_310_6.color = Color.New(var_310_7, var_310_7, var_310_7)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= 0 + var_310_6 and arg_307_1.time_ < 0 + var_310_6 + arg_310_0 and not isNil(var_310_5) and arg_307_1.var_.actorSpriteComps10093 then
				for iter_310_7, iter_310_8 in pairs(arg_307_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_310_8 then
						iter_310_8.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_307_1.var_.actorSpriteComps10093 = nil
			end

			local var_310_8 = 0
			local var_310_9 = 0.45

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_8 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_10 = arg_307_1:GetWordFromCfg(413091072)
				local var_310_11 = arg_307_1:FormatText(var_310_10.content)

				arg_307_1.text_.text = var_310_11

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_13 = 18 <= 0 and var_310_9 or var_310_9 * (utf8.len(var_310_11) / 18)

				if (18 <= 0 and var_310_9 or var_310_9 * (utf8.len(var_310_11) / 18)) > 0 and var_310_9 < var_310_13 then
					arg_307_1.talkMaxDuration = var_310_13

					if var_310_13 + var_310_8 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_13 + var_310_8
					end
				end

				arg_307_1.text_.text = var_310_11
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091072", "story_v_out_413091.awb") ~= 0 then
					local var_310_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091072", "story_v_out_413091.awb") / 1000

					if var_310_14 + var_310_8 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_14 + var_310_8
					end

					if var_310_10.prefab_name ~= "" and arg_307_1.actors_[var_310_10.prefab_name] ~= nil then
						local var_310_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_10.prefab_name].transform, "story_v_out_413091", "413091072", "story_v_out_413091.awb")

						arg_307_1:RecordAudio("413091072", var_310_15)
						arg_307_1:RecordAudio("413091072", var_310_15)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_413091", "413091072", "story_v_out_413091.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_413091", "413091072", "story_v_out_413091.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_16 = math.max(var_310_9, arg_307_1.talkMaxDuration)

			if var_310_8 <= arg_307_1.time_ and arg_307_1.time_ < var_310_8 + var_310_16 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_8) / var_310_16

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_8 + var_310_16 and arg_307_1.time_ < var_310_8 + var_310_16 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
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

		arg_307_1:InitPlayNodeList()
	end,
	Play413091073 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 413091073
		arg_311_1.duration_ = 12.93

		local var_311_0 = {
			zh = 8.233,
			ja = 12.933
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
				arg_311_0:Play413091074(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos10097 = arg_311_1.actors_["10097"].transform.localPosition
				arg_311_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_311_1:CheckSpriteTmpPos("10097", 4)

				for iter_314_0 = 0, arg_311_1.actors_["10097"].transform.childCount - 1 do
					local var_314_0 = arg_311_1.actors_["10097"].transform:GetChild(iter_314_0)

					if var_314_0.name == "" or not string.find(var_314_0.name, "split") then
						var_314_0.gameObject:SetActive(true)
					else
						var_314_0.gameObject:SetActive(false)
					end
				end
			end

			local var_314_1 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_1 then
				arg_311_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_311_1.time_ - 0) / var_314_1)
			end

			if arg_311_1.time_ >= 0 + var_314_1 and arg_311_1.time_ < 0 + var_314_1 + arg_314_0 then
				arg_311_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_314_2 = arg_311_1.actors_["10097"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_2) and arg_311_1.var_.actorSpriteComps10097 == nil then
				arg_311_1.var_.actorSpriteComps10097 = var_314_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_3 = 2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_3 and not isNil(var_314_2) then
				if arg_311_1.var_.actorSpriteComps10097 then
					for iter_314_1, iter_314_2 in pairs(arg_311_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_314_2 then
							if arg_311_1.isInRecall_ then
								iter_314_2.color = Color.New(Mathf.Lerp(iter_314_2.color.r, arg_311_1.hightColor1.r, (arg_311_1.time_ - 0) / var_314_3), Mathf.Lerp(iter_314_2.color.g, arg_311_1.hightColor1.g, (arg_311_1.time_ - 0) / var_314_3), (Mathf.Lerp(iter_314_2.color.b, arg_311_1.hightColor1.b, (arg_311_1.time_ - 0) / var_314_3)))
							else
								local var_314_4 = Mathf.Lerp(iter_314_2.color.r, 1, (arg_311_1.time_ - 0) / var_314_3)

								iter_314_2.color = Color.New(var_314_4, var_314_4, var_314_4)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= 0 + var_314_3 and arg_311_1.time_ < 0 + var_314_3 + arg_314_0 and not isNil(var_314_2) and arg_311_1.var_.actorSpriteComps10097 then
				for iter_314_3, iter_314_4 in pairs(arg_311_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_314_4 then
						iter_314_4.color = arg_311_1.isInRecall_ and (arg_311_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_311_1.var_.actorSpriteComps10097 = nil
			end

			local var_314_5 = 0
			local var_314_6 = 0.8

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_7 = arg_311_1:GetWordFromCfg(413091073)
				local var_314_8 = arg_311_1:FormatText(var_314_7.content)

				arg_311_1.text_.text = var_314_8

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_10 = 32 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_8) / 32)

				if (32 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_8) / 32)) > 0 and var_314_6 < var_314_10 then
					arg_311_1.talkMaxDuration = var_314_10

					if var_314_10 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_5
					end
				end

				arg_311_1.text_.text = var_314_8
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091073", "story_v_out_413091.awb") ~= 0 then
					local var_314_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091073", "story_v_out_413091.awb") / 1000

					if var_314_11 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_11 + var_314_5
					end

					if var_314_7.prefab_name ~= "" and arg_311_1.actors_[var_314_7.prefab_name] ~= nil then
						local var_314_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_7.prefab_name].transform, "story_v_out_413091", "413091073", "story_v_out_413091.awb")

						arg_311_1:RecordAudio("413091073", var_314_12)
						arg_311_1:RecordAudio("413091073", var_314_12)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_413091", "413091073", "story_v_out_413091.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_413091", "413091073", "story_v_out_413091.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_13 = math.max(var_314_6, arg_311_1.talkMaxDuration)

			if var_314_5 <= arg_311_1.time_ and arg_311_1.time_ < var_314_5 + var_314_13 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_5) / var_314_13

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_5 + var_314_13 and arg_311_1.time_ < var_314_5 + var_314_13 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
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

		arg_311_1:InitPlayNodeList()
	end,
	Play413091074 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 413091074
		arg_315_1.duration_ = 4.9

		local var_315_0 = {
			zh = 4.9,
			ja = 4.833
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
				arg_315_0:Play413091075(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos10093 = arg_315_1.actors_["10093"].transform.localPosition
				arg_315_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("10093", 2)

				for iter_318_0 = 0, arg_315_1.actors_["10093"].transform.childCount - 1 do
					local var_318_0 = arg_315_1.actors_["10093"].transform:GetChild(iter_318_0)

					if var_318_0.name == "split_3" or not string.find(var_318_0.name, "split") then
						var_318_0.gameObject:SetActive(true)
					else
						var_318_0.gameObject:SetActive(false)
					end
				end
			end

			local var_318_1 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_1 then
				arg_315_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_315_1.time_ - 0) / var_318_1)
			end

			if arg_315_1.time_ >= 0 + var_318_1 and arg_315_1.time_ < 0 + var_318_1 + arg_318_0 then
				arg_315_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_318_2 = arg_315_1.actors_["10093"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_2) and arg_315_1.var_.actorSpriteComps10093 == nil then
				arg_315_1.var_.actorSpriteComps10093 = var_318_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_3 = 2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_3 and not isNil(var_318_2) then
				if arg_315_1.var_.actorSpriteComps10093 then
					for iter_318_1, iter_318_2 in pairs(arg_315_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_318_2 then
							if arg_315_1.isInRecall_ then
								iter_318_2.color = Color.New(Mathf.Lerp(iter_318_2.color.r, arg_315_1.hightColor1.r, (arg_315_1.time_ - 0) / var_318_3), Mathf.Lerp(iter_318_2.color.g, arg_315_1.hightColor1.g, (arg_315_1.time_ - 0) / var_318_3), (Mathf.Lerp(iter_318_2.color.b, arg_315_1.hightColor1.b, (arg_315_1.time_ - 0) / var_318_3)))
							else
								local var_318_4 = Mathf.Lerp(iter_318_2.color.r, 1, (arg_315_1.time_ - 0) / var_318_3)

								iter_318_2.color = Color.New(var_318_4, var_318_4, var_318_4)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= 0 + var_318_3 and arg_315_1.time_ < 0 + var_318_3 + arg_318_0 and not isNil(var_318_2) and arg_315_1.var_.actorSpriteComps10093 then
				for iter_318_3, iter_318_4 in pairs(arg_315_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_318_4 then
						iter_318_4.color = arg_315_1.isInRecall_ and (arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_315_1.var_.actorSpriteComps10093 = nil
			end

			local var_318_5 = arg_315_1.actors_["10097"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_5) and arg_315_1.var_.actorSpriteComps10097 == nil then
				arg_315_1.var_.actorSpriteComps10097 = var_318_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_6 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_6 and not isNil(var_318_5) then
				if arg_315_1.var_.actorSpriteComps10097 then
					for iter_318_5, iter_318_6 in pairs(arg_315_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_318_6 then
							if arg_315_1.isInRecall_ then
								iter_318_6.color = Color.New(Mathf.Lerp(iter_318_6.color.r, arg_315_1.hightColor2.r, (arg_315_1.time_ - 0) / var_318_6), Mathf.Lerp(iter_318_6.color.g, arg_315_1.hightColor2.g, (arg_315_1.time_ - 0) / var_318_6), (Mathf.Lerp(iter_318_6.color.b, arg_315_1.hightColor2.b, (arg_315_1.time_ - 0) / var_318_6)))
							else
								local var_318_7 = Mathf.Lerp(iter_318_6.color.r, 0.5, (arg_315_1.time_ - 0) / var_318_6)

								iter_318_6.color = Color.New(var_318_7, var_318_7, var_318_7)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= 0 + var_318_6 and arg_315_1.time_ < 0 + var_318_6 + arg_318_0 and not isNil(var_318_5) and arg_315_1.var_.actorSpriteComps10097 then
				for iter_318_7, iter_318_8 in pairs(arg_315_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_318_8 then
						iter_318_8.color = arg_315_1.isInRecall_ and (arg_315_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_315_1.var_.actorSpriteComps10097 = nil
			end

			local var_318_8 = 0
			local var_318_9 = 0.525

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_8 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_10 = arg_315_1:GetWordFromCfg(413091074)
				local var_318_11 = arg_315_1:FormatText(var_318_10.content)

				arg_315_1.text_.text = var_318_11

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_13 = 21 <= 0 and var_318_9 or var_318_9 * (utf8.len(var_318_11) / 21)

				if (21 <= 0 and var_318_9 or var_318_9 * (utf8.len(var_318_11) / 21)) > 0 and var_318_9 < var_318_13 then
					arg_315_1.talkMaxDuration = var_318_13

					if var_318_13 + var_318_8 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_13 + var_318_8
					end
				end

				arg_315_1.text_.text = var_318_11
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091074", "story_v_out_413091.awb") ~= 0 then
					local var_318_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091074", "story_v_out_413091.awb") / 1000

					if var_318_14 + var_318_8 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_14 + var_318_8
					end

					if var_318_10.prefab_name ~= "" and arg_315_1.actors_[var_318_10.prefab_name] ~= nil then
						local var_318_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_10.prefab_name].transform, "story_v_out_413091", "413091074", "story_v_out_413091.awb")

						arg_315_1:RecordAudio("413091074", var_318_15)
						arg_315_1:RecordAudio("413091074", var_318_15)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_413091", "413091074", "story_v_out_413091.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_413091", "413091074", "story_v_out_413091.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_16 = math.max(var_318_9, arg_315_1.talkMaxDuration)

			if var_318_8 <= arg_315_1.time_ and arg_315_1.time_ < var_318_8 + var_318_16 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_8) / var_318_16

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_8 + var_318_16 and arg_315_1.time_ < var_318_8 + var_318_16 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
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

		arg_315_1:InitPlayNodeList()
	end,
	Play413091075 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 413091075
		arg_319_1.duration_ = 16.87

		local var_319_0 = {
			zh = 13.9,
			ja = 16.866
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
				arg_319_0:Play413091076(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos10097 = arg_319_1.actors_["10097"].transform.localPosition
				arg_319_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("10097", 4)

				for iter_322_0 = 0, arg_319_1.actors_["10097"].transform.childCount - 1 do
					local var_322_0 = arg_319_1.actors_["10097"].transform:GetChild(iter_322_0)

					if var_322_0.name == "split_4" or not string.find(var_322_0.name, "split") then
						var_322_0.gameObject:SetActive(true)
					else
						var_322_0.gameObject:SetActive(false)
					end
				end
			end

			local var_322_1 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_1 then
				arg_319_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_319_1.time_ - 0) / var_322_1)
			end

			if arg_319_1.time_ >= 0 + var_322_1 and arg_319_1.time_ < 0 + var_322_1 + arg_322_0 then
				arg_319_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_322_2 = arg_319_1.actors_["10097"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_2) and arg_319_1.var_.actorSpriteComps10097 == nil then
				arg_319_1.var_.actorSpriteComps10097 = var_322_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_3 = 2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_3 and not isNil(var_322_2) then
				if arg_319_1.var_.actorSpriteComps10097 then
					for iter_322_1, iter_322_2 in pairs(arg_319_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_322_2 then
							if arg_319_1.isInRecall_ then
								iter_322_2.color = Color.New(Mathf.Lerp(iter_322_2.color.r, arg_319_1.hightColor1.r, (arg_319_1.time_ - 0) / var_322_3), Mathf.Lerp(iter_322_2.color.g, arg_319_1.hightColor1.g, (arg_319_1.time_ - 0) / var_322_3), (Mathf.Lerp(iter_322_2.color.b, arg_319_1.hightColor1.b, (arg_319_1.time_ - 0) / var_322_3)))
							else
								local var_322_4 = Mathf.Lerp(iter_322_2.color.r, 1, (arg_319_1.time_ - 0) / var_322_3)

								iter_322_2.color = Color.New(var_322_4, var_322_4, var_322_4)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= 0 + var_322_3 and arg_319_1.time_ < 0 + var_322_3 + arg_322_0 and not isNil(var_322_2) and arg_319_1.var_.actorSpriteComps10097 then
				for iter_322_3, iter_322_4 in pairs(arg_319_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_322_4 then
						iter_322_4.color = arg_319_1.isInRecall_ and (arg_319_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_319_1.var_.actorSpriteComps10097 = nil
			end

			local var_322_5 = arg_319_1.actors_["10093"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_5) and arg_319_1.var_.actorSpriteComps10093 == nil then
				arg_319_1.var_.actorSpriteComps10093 = var_322_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_322_6 = 0.2

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_6 and not isNil(var_322_5) then
				if arg_319_1.var_.actorSpriteComps10093 then
					for iter_322_5, iter_322_6 in pairs(arg_319_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_322_6 then
							if arg_319_1.isInRecall_ then
								iter_322_6.color = Color.New(Mathf.Lerp(iter_322_6.color.r, arg_319_1.hightColor2.r, (arg_319_1.time_ - 0) / var_322_6), Mathf.Lerp(iter_322_6.color.g, arg_319_1.hightColor2.g, (arg_319_1.time_ - 0) / var_322_6), (Mathf.Lerp(iter_322_6.color.b, arg_319_1.hightColor2.b, (arg_319_1.time_ - 0) / var_322_6)))
							else
								local var_322_7 = Mathf.Lerp(iter_322_6.color.r, 0.5, (arg_319_1.time_ - 0) / var_322_6)

								iter_322_6.color = Color.New(var_322_7, var_322_7, var_322_7)
							end
						end
					end
				end
			end

			if arg_319_1.time_ >= 0 + var_322_6 and arg_319_1.time_ < 0 + var_322_6 + arg_322_0 and not isNil(var_322_5) and arg_319_1.var_.actorSpriteComps10093 then
				for iter_322_7, iter_322_8 in pairs(arg_319_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_322_8 then
						iter_322_8.color = arg_319_1.isInRecall_ and (arg_319_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_319_1.var_.actorSpriteComps10093 = nil
			end

			local var_322_8 = 0
			local var_322_9 = 1

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_8 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_10 = arg_319_1:GetWordFromCfg(413091075)
				local var_322_11 = arg_319_1:FormatText(var_322_10.content)

				arg_319_1.text_.text = var_322_11

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_13 = 40 <= 0 and var_322_9 or var_322_9 * (utf8.len(var_322_11) / 40)

				if (40 <= 0 and var_322_9 or var_322_9 * (utf8.len(var_322_11) / 40)) > 0 and var_322_9 < var_322_13 then
					arg_319_1.talkMaxDuration = var_322_13

					if var_322_13 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_13 + var_322_8
					end
				end

				arg_319_1.text_.text = var_322_11
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091075", "story_v_out_413091.awb") ~= 0 then
					local var_322_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091075", "story_v_out_413091.awb") / 1000

					if var_322_14 + var_322_8 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_14 + var_322_8
					end

					if var_322_10.prefab_name ~= "" and arg_319_1.actors_[var_322_10.prefab_name] ~= nil then
						local var_322_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_10.prefab_name].transform, "story_v_out_413091", "413091075", "story_v_out_413091.awb")

						arg_319_1:RecordAudio("413091075", var_322_15)
						arg_319_1:RecordAudio("413091075", var_322_15)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_413091", "413091075", "story_v_out_413091.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_413091", "413091075", "story_v_out_413091.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_16 = math.max(var_322_9, arg_319_1.talkMaxDuration)

			if var_322_8 <= arg_319_1.time_ and arg_319_1.time_ < var_322_8 + var_322_16 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_8) / var_322_16

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_8 + var_322_16 and arg_319_1.time_ < var_322_8 + var_322_16 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
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

		arg_319_1:InitPlayNodeList()
	end,
	Play413091076 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 413091076
		arg_323_1.duration_ = 10.17

		local var_323_0 = {
			zh = 10.166,
			ja = 6.6
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play413091077(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos10093 = arg_323_1.actors_["10093"].transform.localPosition
				arg_323_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("10093", 2)

				for iter_326_0 = 0, arg_323_1.actors_["10093"].transform.childCount - 1 do
					local var_326_0 = arg_323_1.actors_["10093"].transform:GetChild(iter_326_0)

					if var_326_0.name == "split_7" or not string.find(var_326_0.name, "split") then
						var_326_0.gameObject:SetActive(true)
					else
						var_326_0.gameObject:SetActive(false)
					end
				end
			end

			local var_326_1 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_1 then
				arg_323_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_323_1.time_ - 0) / var_326_1)
			end

			if arg_323_1.time_ >= 0 + var_326_1 and arg_323_1.time_ < 0 + var_326_1 + arg_326_0 then
				arg_323_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_326_2 = arg_323_1.actors_["10093"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.actorSpriteComps10093 == nil then
				arg_323_1.var_.actorSpriteComps10093 = var_326_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_3 = 2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_3 and not isNil(var_326_2) then
				if arg_323_1.var_.actorSpriteComps10093 then
					for iter_326_1, iter_326_2 in pairs(arg_323_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_326_2 then
							if arg_323_1.isInRecall_ then
								iter_326_2.color = Color.New(Mathf.Lerp(iter_326_2.color.r, arg_323_1.hightColor1.r, (arg_323_1.time_ - 0) / var_326_3), Mathf.Lerp(iter_326_2.color.g, arg_323_1.hightColor1.g, (arg_323_1.time_ - 0) / var_326_3), (Mathf.Lerp(iter_326_2.color.b, arg_323_1.hightColor1.b, (arg_323_1.time_ - 0) / var_326_3)))
							else
								local var_326_4 = Mathf.Lerp(iter_326_2.color.r, 1, (arg_323_1.time_ - 0) / var_326_3)

								iter_326_2.color = Color.New(var_326_4, var_326_4, var_326_4)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= 0 + var_326_3 and arg_323_1.time_ < 0 + var_326_3 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.actorSpriteComps10093 then
				for iter_326_3, iter_326_4 in pairs(arg_323_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_326_4 then
						iter_326_4.color = arg_323_1.isInRecall_ and (arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_323_1.var_.actorSpriteComps10093 = nil
			end

			local var_326_5 = arg_323_1.actors_["10097"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_5) and arg_323_1.var_.actorSpriteComps10097 == nil then
				arg_323_1.var_.actorSpriteComps10097 = var_326_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_6 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_6 and not isNil(var_326_5) then
				if arg_323_1.var_.actorSpriteComps10097 then
					for iter_326_5, iter_326_6 in pairs(arg_323_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_326_6 then
							if arg_323_1.isInRecall_ then
								iter_326_6.color = Color.New(Mathf.Lerp(iter_326_6.color.r, arg_323_1.hightColor2.r, (arg_323_1.time_ - 0) / var_326_6), Mathf.Lerp(iter_326_6.color.g, arg_323_1.hightColor2.g, (arg_323_1.time_ - 0) / var_326_6), (Mathf.Lerp(iter_326_6.color.b, arg_323_1.hightColor2.b, (arg_323_1.time_ - 0) / var_326_6)))
							else
								local var_326_7 = Mathf.Lerp(iter_326_6.color.r, 0.5, (arg_323_1.time_ - 0) / var_326_6)

								iter_326_6.color = Color.New(var_326_7, var_326_7, var_326_7)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= 0 + var_326_6 and arg_323_1.time_ < 0 + var_326_6 + arg_326_0 and not isNil(var_326_5) and arg_323_1.var_.actorSpriteComps10097 then
				for iter_326_7, iter_326_8 in pairs(arg_323_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_326_8 then
						iter_326_8.color = arg_323_1.isInRecall_ and (arg_323_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_323_1.var_.actorSpriteComps10097 = nil
			end

			local var_326_8 = 0
			local var_326_9 = 1.25

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_8 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_10 = arg_323_1:GetWordFromCfg(413091076)
				local var_326_11 = arg_323_1:FormatText(var_326_10.content)

				arg_323_1.text_.text = var_326_11

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_13 = 50 <= 0 and var_326_9 or var_326_9 * (utf8.len(var_326_11) / 50)

				if (50 <= 0 and var_326_9 or var_326_9 * (utf8.len(var_326_11) / 50)) > 0 and var_326_9 < var_326_13 then
					arg_323_1.talkMaxDuration = var_326_13

					if var_326_13 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_13 + var_326_8
					end
				end

				arg_323_1.text_.text = var_326_11
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091076", "story_v_out_413091.awb") ~= 0 then
					local var_326_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091076", "story_v_out_413091.awb") / 1000

					if var_326_14 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_14 + var_326_8
					end

					if var_326_10.prefab_name ~= "" and arg_323_1.actors_[var_326_10.prefab_name] ~= nil then
						local var_326_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_10.prefab_name].transform, "story_v_out_413091", "413091076", "story_v_out_413091.awb")

						arg_323_1:RecordAudio("413091076", var_326_15)
						arg_323_1:RecordAudio("413091076", var_326_15)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_413091", "413091076", "story_v_out_413091.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_413091", "413091076", "story_v_out_413091.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_16 = math.max(var_326_9, arg_323_1.talkMaxDuration)

			if var_326_8 <= arg_323_1.time_ and arg_323_1.time_ < var_326_8 + var_326_16 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_8) / var_326_16

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_8 + var_326_16 and arg_323_1.time_ < var_326_8 + var_326_16 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
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

		arg_323_1:InitPlayNodeList()
	end,
	Play413091077 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 413091077
		arg_327_1.duration_ = 4.47

		local var_327_0 = {
			zh = 4,
			ja = 4.466
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
				arg_327_0:Play413091078(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0.475

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_1 = arg_327_1:GetWordFromCfg(413091077)
				local var_330_2 = arg_327_1:FormatText(var_330_1.content)

				arg_327_1.text_.text = var_330_2

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_4 = 19 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 19)

				if (19 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 19)) > 0 and var_330_0 < var_330_4 then
					arg_327_1.talkMaxDuration = var_330_4

					if var_330_4 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_4 + 0
					end
				end

				arg_327_1.text_.text = var_330_2
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091077", "story_v_out_413091.awb") ~= 0 then
					local var_330_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091077", "story_v_out_413091.awb") / 1000

					if var_330_5 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + 0
					end

					if var_330_1.prefab_name ~= "" and arg_327_1.actors_[var_330_1.prefab_name] ~= nil then
						local var_330_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_1.prefab_name].transform, "story_v_out_413091", "413091077", "story_v_out_413091.awb")

						arg_327_1:RecordAudio("413091077", var_330_6)
						arg_327_1:RecordAudio("413091077", var_330_6)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_413091", "413091077", "story_v_out_413091.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_413091", "413091077", "story_v_out_413091.awb")
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
	Play413091078 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 413091078
		arg_331_1.duration_ = 14.47

		local var_331_0 = {
			zh = 14.466,
			ja = 11.433
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
				arg_331_0:Play413091079(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos10097 = arg_331_1.actors_["10097"].transform.localPosition
				arg_331_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10097", 4)

				for iter_334_0 = 0, arg_331_1.actors_["10097"].transform.childCount - 1 do
					local var_334_0 = arg_331_1.actors_["10097"].transform:GetChild(iter_334_0)

					if var_334_0.name == "split_3" or not string.find(var_334_0.name, "split") then
						var_334_0.gameObject:SetActive(true)
					else
						var_334_0.gameObject:SetActive(false)
					end
				end
			end

			local var_334_1 = 0.001

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_1 then
				arg_331_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_331_1.time_ - 0) / var_334_1)
			end

			if arg_331_1.time_ >= 0 + var_334_1 and arg_331_1.time_ < 0 + var_334_1 + arg_334_0 then
				arg_331_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_334_2 = arg_331_1.actors_["10097"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_2) and arg_331_1.var_.actorSpriteComps10097 == nil then
				arg_331_1.var_.actorSpriteComps10097 = var_334_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_3 = 2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_3 and not isNil(var_334_2) then
				if arg_331_1.var_.actorSpriteComps10097 then
					for iter_334_1, iter_334_2 in pairs(arg_331_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_334_2 then
							if arg_331_1.isInRecall_ then
								iter_334_2.color = Color.New(Mathf.Lerp(iter_334_2.color.r, arg_331_1.hightColor1.r, (arg_331_1.time_ - 0) / var_334_3), Mathf.Lerp(iter_334_2.color.g, arg_331_1.hightColor1.g, (arg_331_1.time_ - 0) / var_334_3), (Mathf.Lerp(iter_334_2.color.b, arg_331_1.hightColor1.b, (arg_331_1.time_ - 0) / var_334_3)))
							else
								local var_334_4 = Mathf.Lerp(iter_334_2.color.r, 1, (arg_331_1.time_ - 0) / var_334_3)

								iter_334_2.color = Color.New(var_334_4, var_334_4, var_334_4)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= 0 + var_334_3 and arg_331_1.time_ < 0 + var_334_3 + arg_334_0 and not isNil(var_334_2) and arg_331_1.var_.actorSpriteComps10097 then
				for iter_334_3, iter_334_4 in pairs(arg_331_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_334_4 then
						iter_334_4.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_331_1.var_.actorSpriteComps10097 = nil
			end

			local var_334_5 = arg_331_1.actors_["10093"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_5) and arg_331_1.var_.actorSpriteComps10093 == nil then
				arg_331_1.var_.actorSpriteComps10093 = var_334_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_6 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_6 and not isNil(var_334_5) then
				if arg_331_1.var_.actorSpriteComps10093 then
					for iter_334_5, iter_334_6 in pairs(arg_331_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_334_6 then
							if arg_331_1.isInRecall_ then
								iter_334_6.color = Color.New(Mathf.Lerp(iter_334_6.color.r, arg_331_1.hightColor2.r, (arg_331_1.time_ - 0) / var_334_6), Mathf.Lerp(iter_334_6.color.g, arg_331_1.hightColor2.g, (arg_331_1.time_ - 0) / var_334_6), (Mathf.Lerp(iter_334_6.color.b, arg_331_1.hightColor2.b, (arg_331_1.time_ - 0) / var_334_6)))
							else
								local var_334_7 = Mathf.Lerp(iter_334_6.color.r, 0.5, (arg_331_1.time_ - 0) / var_334_6)

								iter_334_6.color = Color.New(var_334_7, var_334_7, var_334_7)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= 0 + var_334_6 and arg_331_1.time_ < 0 + var_334_6 + arg_334_0 and not isNil(var_334_5) and arg_331_1.var_.actorSpriteComps10093 then
				for iter_334_7, iter_334_8 in pairs(arg_331_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_334_8 then
						iter_334_8.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_331_1.var_.actorSpriteComps10093 = nil
			end

			local var_334_8 = 0
			local var_334_9 = 0.95

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_8 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_10 = arg_331_1:GetWordFromCfg(413091078)
				local var_334_11 = arg_331_1:FormatText(var_334_10.content)

				arg_331_1.text_.text = var_334_11

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_13 = 38 <= 0 and var_334_9 or var_334_9 * (utf8.len(var_334_11) / 38)

				if (38 <= 0 and var_334_9 or var_334_9 * (utf8.len(var_334_11) / 38)) > 0 and var_334_9 < var_334_13 then
					arg_331_1.talkMaxDuration = var_334_13

					if var_334_13 + var_334_8 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_13 + var_334_8
					end
				end

				arg_331_1.text_.text = var_334_11
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091078", "story_v_out_413091.awb") ~= 0 then
					local var_334_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091078", "story_v_out_413091.awb") / 1000

					if var_334_14 + var_334_8 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_14 + var_334_8
					end

					if var_334_10.prefab_name ~= "" and arg_331_1.actors_[var_334_10.prefab_name] ~= nil then
						local var_334_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_10.prefab_name].transform, "story_v_out_413091", "413091078", "story_v_out_413091.awb")

						arg_331_1:RecordAudio("413091078", var_334_15)
						arg_331_1:RecordAudio("413091078", var_334_15)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_413091", "413091078", "story_v_out_413091.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_413091", "413091078", "story_v_out_413091.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_16 = math.max(var_334_9, arg_331_1.talkMaxDuration)

			if var_334_8 <= arg_331_1.time_ and arg_331_1.time_ < var_334_8 + var_334_16 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_8) / var_334_16

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_8 + var_334_16 and arg_331_1.time_ < var_334_8 + var_334_16 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {
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

		arg_331_1:InitPlayNodeList()
	end,
	Play413091079 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 413091079
		arg_335_1.duration_ = 8.57

		local var_335_0 = {
			zh = 8.566,
			ja = 7.033
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
				arg_335_0:Play413091080(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos10093 = arg_335_1.actors_["10093"].transform.localPosition
				arg_335_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("10093", 2)

				for iter_338_0 = 0, arg_335_1.actors_["10093"].transform.childCount - 1 do
					local var_338_0 = arg_335_1.actors_["10093"].transform:GetChild(iter_338_0)

					if var_338_0.name == "split_5" or not string.find(var_338_0.name, "split") then
						var_338_0.gameObject:SetActive(true)
					else
						var_338_0.gameObject:SetActive(false)
					end
				end
			end

			local var_338_1 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_1 then
				arg_335_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_335_1.time_ - 0) / var_338_1)
			end

			if arg_335_1.time_ >= 0 + var_338_1 and arg_335_1.time_ < 0 + var_338_1 + arg_338_0 then
				arg_335_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_338_2 = arg_335_1.actors_["10093"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_2) and arg_335_1.var_.actorSpriteComps10093 == nil then
				arg_335_1.var_.actorSpriteComps10093 = var_338_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_3 = 2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_3 and not isNil(var_338_2) then
				if arg_335_1.var_.actorSpriteComps10093 then
					for iter_338_1, iter_338_2 in pairs(arg_335_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_338_2 then
							if arg_335_1.isInRecall_ then
								iter_338_2.color = Color.New(Mathf.Lerp(iter_338_2.color.r, arg_335_1.hightColor1.r, (arg_335_1.time_ - 0) / var_338_3), Mathf.Lerp(iter_338_2.color.g, arg_335_1.hightColor1.g, (arg_335_1.time_ - 0) / var_338_3), (Mathf.Lerp(iter_338_2.color.b, arg_335_1.hightColor1.b, (arg_335_1.time_ - 0) / var_338_3)))
							else
								local var_338_4 = Mathf.Lerp(iter_338_2.color.r, 1, (arg_335_1.time_ - 0) / var_338_3)

								iter_338_2.color = Color.New(var_338_4, var_338_4, var_338_4)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= 0 + var_338_3 and arg_335_1.time_ < 0 + var_338_3 + arg_338_0 and not isNil(var_338_2) and arg_335_1.var_.actorSpriteComps10093 then
				for iter_338_3, iter_338_4 in pairs(arg_335_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_338_4 then
						iter_338_4.color = arg_335_1.isInRecall_ and (arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_335_1.var_.actorSpriteComps10093 = nil
			end

			local var_338_5 = arg_335_1.actors_["10097"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_5) and arg_335_1.var_.actorSpriteComps10097 == nil then
				arg_335_1.var_.actorSpriteComps10097 = var_338_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_6 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_6 and not isNil(var_338_5) then
				if arg_335_1.var_.actorSpriteComps10097 then
					for iter_338_5, iter_338_6 in pairs(arg_335_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_338_6 then
							if arg_335_1.isInRecall_ then
								iter_338_6.color = Color.New(Mathf.Lerp(iter_338_6.color.r, arg_335_1.hightColor2.r, (arg_335_1.time_ - 0) / var_338_6), Mathf.Lerp(iter_338_6.color.g, arg_335_1.hightColor2.g, (arg_335_1.time_ - 0) / var_338_6), (Mathf.Lerp(iter_338_6.color.b, arg_335_1.hightColor2.b, (arg_335_1.time_ - 0) / var_338_6)))
							else
								local var_338_7 = Mathf.Lerp(iter_338_6.color.r, 0.5, (arg_335_1.time_ - 0) / var_338_6)

								iter_338_6.color = Color.New(var_338_7, var_338_7, var_338_7)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= 0 + var_338_6 and arg_335_1.time_ < 0 + var_338_6 + arg_338_0 and not isNil(var_338_5) and arg_335_1.var_.actorSpriteComps10097 then
				for iter_338_7, iter_338_8 in pairs(arg_335_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_338_8 then
						iter_338_8.color = arg_335_1.isInRecall_ and (arg_335_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_335_1.var_.actorSpriteComps10097 = nil
			end

			local var_338_8 = 0
			local var_338_9 = 1.1

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_8 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_10 = arg_335_1:GetWordFromCfg(413091079)
				local var_338_11 = arg_335_1:FormatText(var_338_10.content)

				arg_335_1.text_.text = var_338_11

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_13 = 44 <= 0 and var_338_9 or var_338_9 * (utf8.len(var_338_11) / 44)

				if (44 <= 0 and var_338_9 or var_338_9 * (utf8.len(var_338_11) / 44)) > 0 and var_338_9 < var_338_13 then
					arg_335_1.talkMaxDuration = var_338_13

					if var_338_13 + var_338_8 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_13 + var_338_8
					end
				end

				arg_335_1.text_.text = var_338_11
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091079", "story_v_out_413091.awb") ~= 0 then
					local var_338_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091079", "story_v_out_413091.awb") / 1000

					if var_338_14 + var_338_8 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_14 + var_338_8
					end

					if var_338_10.prefab_name ~= "" and arg_335_1.actors_[var_338_10.prefab_name] ~= nil then
						local var_338_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_10.prefab_name].transform, "story_v_out_413091", "413091079", "story_v_out_413091.awb")

						arg_335_1:RecordAudio("413091079", var_338_15)
						arg_335_1:RecordAudio("413091079", var_338_15)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_413091", "413091079", "story_v_out_413091.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_413091", "413091079", "story_v_out_413091.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_16 = math.max(var_338_9, arg_335_1.talkMaxDuration)

			if var_338_8 <= arg_335_1.time_ and arg_335_1.time_ < var_338_8 + var_338_16 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_8) / var_338_16

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_8 + var_338_16 and arg_335_1.time_ < var_338_8 + var_338_16 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
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

		arg_335_1:InitPlayNodeList()
	end,
	Play413091080 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 413091080
		arg_339_1.duration_ = 17.43

		local var_339_0 = {
			zh = 7.1,
			ja = 17.433
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
				arg_339_0:Play413091081(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos10097 = arg_339_1.actors_["10097"].transform.localPosition
				arg_339_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("10097", 4)

				for iter_342_0 = 0, arg_339_1.actors_["10097"].transform.childCount - 1 do
					local var_342_0 = arg_339_1.actors_["10097"].transform:GetChild(iter_342_0)

					if var_342_0.name == "split_4" or not string.find(var_342_0.name, "split") then
						var_342_0.gameObject:SetActive(true)
					else
						var_342_0.gameObject:SetActive(false)
					end
				end
			end

			local var_342_1 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_1 then
				arg_339_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_339_1.time_ - 0) / var_342_1)
			end

			if arg_339_1.time_ >= 0 + var_342_1 and arg_339_1.time_ < 0 + var_342_1 + arg_342_0 then
				arg_339_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_342_2 = arg_339_1.actors_["10097"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_2) and arg_339_1.var_.actorSpriteComps10097 == nil then
				arg_339_1.var_.actorSpriteComps10097 = var_342_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_3 = 2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_3 and not isNil(var_342_2) then
				if arg_339_1.var_.actorSpriteComps10097 then
					for iter_342_1, iter_342_2 in pairs(arg_339_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_342_2 then
							if arg_339_1.isInRecall_ then
								iter_342_2.color = Color.New(Mathf.Lerp(iter_342_2.color.r, arg_339_1.hightColor1.r, (arg_339_1.time_ - 0) / var_342_3), Mathf.Lerp(iter_342_2.color.g, arg_339_1.hightColor1.g, (arg_339_1.time_ - 0) / var_342_3), (Mathf.Lerp(iter_342_2.color.b, arg_339_1.hightColor1.b, (arg_339_1.time_ - 0) / var_342_3)))
							else
								local var_342_4 = Mathf.Lerp(iter_342_2.color.r, 1, (arg_339_1.time_ - 0) / var_342_3)

								iter_342_2.color = Color.New(var_342_4, var_342_4, var_342_4)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= 0 + var_342_3 and arg_339_1.time_ < 0 + var_342_3 + arg_342_0 and not isNil(var_342_2) and arg_339_1.var_.actorSpriteComps10097 then
				for iter_342_3, iter_342_4 in pairs(arg_339_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_342_4 then
						iter_342_4.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_339_1.var_.actorSpriteComps10097 = nil
			end

			local var_342_5 = arg_339_1.actors_["10093"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_5) and arg_339_1.var_.actorSpriteComps10093 == nil then
				arg_339_1.var_.actorSpriteComps10093 = var_342_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_6 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_6 and not isNil(var_342_5) then
				if arg_339_1.var_.actorSpriteComps10093 then
					for iter_342_5, iter_342_6 in pairs(arg_339_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_342_6 then
							if arg_339_1.isInRecall_ then
								iter_342_6.color = Color.New(Mathf.Lerp(iter_342_6.color.r, arg_339_1.hightColor2.r, (arg_339_1.time_ - 0) / var_342_6), Mathf.Lerp(iter_342_6.color.g, arg_339_1.hightColor2.g, (arg_339_1.time_ - 0) / var_342_6), (Mathf.Lerp(iter_342_6.color.b, arg_339_1.hightColor2.b, (arg_339_1.time_ - 0) / var_342_6)))
							else
								local var_342_7 = Mathf.Lerp(iter_342_6.color.r, 0.5, (arg_339_1.time_ - 0) / var_342_6)

								iter_342_6.color = Color.New(var_342_7, var_342_7, var_342_7)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= 0 + var_342_6 and arg_339_1.time_ < 0 + var_342_6 + arg_342_0 and not isNil(var_342_5) and arg_339_1.var_.actorSpriteComps10093 then
				for iter_342_7, iter_342_8 in pairs(arg_339_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_342_8 then
						iter_342_8.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_339_1.var_.actorSpriteComps10093 = nil
			end

			local var_342_8 = 0
			local var_342_9 = 0.625

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_8 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_10 = arg_339_1:GetWordFromCfg(413091080)
				local var_342_11 = arg_339_1:FormatText(var_342_10.content)

				arg_339_1.text_.text = var_342_11

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_13 = 25 <= 0 and var_342_9 or var_342_9 * (utf8.len(var_342_11) / 25)

				if (25 <= 0 and var_342_9 or var_342_9 * (utf8.len(var_342_11) / 25)) > 0 and var_342_9 < var_342_13 then
					arg_339_1.talkMaxDuration = var_342_13

					if var_342_13 + var_342_8 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_13 + var_342_8
					end
				end

				arg_339_1.text_.text = var_342_11
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091080", "story_v_out_413091.awb") ~= 0 then
					local var_342_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091080", "story_v_out_413091.awb") / 1000

					if var_342_14 + var_342_8 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_14 + var_342_8
					end

					if var_342_10.prefab_name ~= "" and arg_339_1.actors_[var_342_10.prefab_name] ~= nil then
						local var_342_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_10.prefab_name].transform, "story_v_out_413091", "413091080", "story_v_out_413091.awb")

						arg_339_1:RecordAudio("413091080", var_342_15)
						arg_339_1:RecordAudio("413091080", var_342_15)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_413091", "413091080", "story_v_out_413091.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_413091", "413091080", "story_v_out_413091.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_16 = math.max(var_342_9, arg_339_1.talkMaxDuration)

			if var_342_8 <= arg_339_1.time_ and arg_339_1.time_ < var_342_8 + var_342_16 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_8) / var_342_16

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_8 + var_342_16 and arg_339_1.time_ < var_342_8 + var_342_16 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
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

		arg_339_1:InitPlayNodeList()
	end,
	Play413091081 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 413091081
		arg_343_1.duration_ = 4

		local var_343_0 = {
			zh = 3.633,
			ja = 4
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
				arg_343_0:Play413091082(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos10093 = arg_343_1.actors_["10093"].transform.localPosition
				arg_343_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("10093", 2)

				for iter_346_0 = 0, arg_343_1.actors_["10093"].transform.childCount - 1 do
					local var_346_0 = arg_343_1.actors_["10093"].transform:GetChild(iter_346_0)

					if var_346_0.name == "split_1" or not string.find(var_346_0.name, "split") then
						var_346_0.gameObject:SetActive(true)
					else
						var_346_0.gameObject:SetActive(false)
					end
				end
			end

			local var_346_1 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_1 then
				arg_343_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_343_1.time_ - 0) / var_346_1)
			end

			if arg_343_1.time_ >= 0 + var_346_1 and arg_343_1.time_ < 0 + var_346_1 + arg_346_0 then
				arg_343_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_346_2 = arg_343_1.actors_["10093"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_2) and arg_343_1.var_.actorSpriteComps10093 == nil then
				arg_343_1.var_.actorSpriteComps10093 = var_346_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_3 = 2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_3 and not isNil(var_346_2) then
				if arg_343_1.var_.actorSpriteComps10093 then
					for iter_346_1, iter_346_2 in pairs(arg_343_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_346_2 then
							if arg_343_1.isInRecall_ then
								iter_346_2.color = Color.New(Mathf.Lerp(iter_346_2.color.r, arg_343_1.hightColor1.r, (arg_343_1.time_ - 0) / var_346_3), Mathf.Lerp(iter_346_2.color.g, arg_343_1.hightColor1.g, (arg_343_1.time_ - 0) / var_346_3), (Mathf.Lerp(iter_346_2.color.b, arg_343_1.hightColor1.b, (arg_343_1.time_ - 0) / var_346_3)))
							else
								local var_346_4 = Mathf.Lerp(iter_346_2.color.r, 1, (arg_343_1.time_ - 0) / var_346_3)

								iter_346_2.color = Color.New(var_346_4, var_346_4, var_346_4)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_3 and arg_343_1.time_ < 0 + var_346_3 + arg_346_0 and not isNil(var_346_2) and arg_343_1.var_.actorSpriteComps10093 then
				for iter_346_3, iter_346_4 in pairs(arg_343_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_346_4 then
						iter_346_4.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_343_1.var_.actorSpriteComps10093 = nil
			end

			local var_346_5 = arg_343_1.actors_["10097"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_5) and arg_343_1.var_.actorSpriteComps10097 == nil then
				arg_343_1.var_.actorSpriteComps10097 = var_346_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_6 = 0.2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_6 and not isNil(var_346_5) then
				if arg_343_1.var_.actorSpriteComps10097 then
					for iter_346_5, iter_346_6 in pairs(arg_343_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_346_6 then
							if arg_343_1.isInRecall_ then
								iter_346_6.color = Color.New(Mathf.Lerp(iter_346_6.color.r, arg_343_1.hightColor2.r, (arg_343_1.time_ - 0) / var_346_6), Mathf.Lerp(iter_346_6.color.g, arg_343_1.hightColor2.g, (arg_343_1.time_ - 0) / var_346_6), (Mathf.Lerp(iter_346_6.color.b, arg_343_1.hightColor2.b, (arg_343_1.time_ - 0) / var_346_6)))
							else
								local var_346_7 = Mathf.Lerp(iter_346_6.color.r, 0.5, (arg_343_1.time_ - 0) / var_346_6)

								iter_346_6.color = Color.New(var_346_7, var_346_7, var_346_7)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_6 and arg_343_1.time_ < 0 + var_346_6 + arg_346_0 and not isNil(var_346_5) and arg_343_1.var_.actorSpriteComps10097 then
				for iter_346_7, iter_346_8 in pairs(arg_343_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_346_8 then
						iter_346_8.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_343_1.var_.actorSpriteComps10097 = nil
			end

			local var_346_8 = 0
			local var_346_9 = 0.4

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_8 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_10 = arg_343_1:GetWordFromCfg(413091081)
				local var_346_11 = arg_343_1:FormatText(var_346_10.content)

				arg_343_1.text_.text = var_346_11

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_13 = 16 <= 0 and var_346_9 or var_346_9 * (utf8.len(var_346_11) / 16)

				if (16 <= 0 and var_346_9 or var_346_9 * (utf8.len(var_346_11) / 16)) > 0 and var_346_9 < var_346_13 then
					arg_343_1.talkMaxDuration = var_346_13

					if var_346_13 + var_346_8 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_13 + var_346_8
					end
				end

				arg_343_1.text_.text = var_346_11
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091081", "story_v_out_413091.awb") ~= 0 then
					local var_346_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091081", "story_v_out_413091.awb") / 1000

					if var_346_14 + var_346_8 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_14 + var_346_8
					end

					if var_346_10.prefab_name ~= "" and arg_343_1.actors_[var_346_10.prefab_name] ~= nil then
						local var_346_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_10.prefab_name].transform, "story_v_out_413091", "413091081", "story_v_out_413091.awb")

						arg_343_1:RecordAudio("413091081", var_346_15)
						arg_343_1:RecordAudio("413091081", var_346_15)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_413091", "413091081", "story_v_out_413091.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_413091", "413091081", "story_v_out_413091.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_16 = math.max(var_346_9, arg_343_1.talkMaxDuration)

			if var_346_8 <= arg_343_1.time_ and arg_343_1.time_ < var_346_8 + var_346_16 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_8) / var_346_16

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_8 + var_346_16 and arg_343_1.time_ < var_346_8 + var_346_16 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
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

		arg_343_1:InitPlayNodeList()
	end,
	Play413091082 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 413091082
		arg_347_1.duration_ = 12.8

		local var_347_0 = {
			zh = 6.033,
			ja = 12.8
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
				arg_347_0:Play413091083(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos10097 = arg_347_1.actors_["10097"].transform.localPosition
				arg_347_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_347_1:CheckSpriteTmpPos("10097", 4)

				for iter_350_0 = 0, arg_347_1.actors_["10097"].transform.childCount - 1 do
					local var_350_0 = arg_347_1.actors_["10097"].transform:GetChild(iter_350_0)

					if var_350_0.name == "split_2" or not string.find(var_350_0.name, "split") then
						var_350_0.gameObject:SetActive(true)
					else
						var_350_0.gameObject:SetActive(false)
					end
				end
			end

			local var_350_1 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_1 then
				arg_347_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_347_1.time_ - 0) / var_350_1)
			end

			if arg_347_1.time_ >= 0 + var_350_1 and arg_347_1.time_ < 0 + var_350_1 + arg_350_0 then
				arg_347_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_350_2 = arg_347_1.actors_["10097"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.actorSpriteComps10097 == nil then
				arg_347_1.var_.actorSpriteComps10097 = var_350_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_3 = 2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_3 and not isNil(var_350_2) then
				if arg_347_1.var_.actorSpriteComps10097 then
					for iter_350_1, iter_350_2 in pairs(arg_347_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_350_2 then
							if arg_347_1.isInRecall_ then
								iter_350_2.color = Color.New(Mathf.Lerp(iter_350_2.color.r, arg_347_1.hightColor1.r, (arg_347_1.time_ - 0) / var_350_3), Mathf.Lerp(iter_350_2.color.g, arg_347_1.hightColor1.g, (arg_347_1.time_ - 0) / var_350_3), (Mathf.Lerp(iter_350_2.color.b, arg_347_1.hightColor1.b, (arg_347_1.time_ - 0) / var_350_3)))
							else
								local var_350_4 = Mathf.Lerp(iter_350_2.color.r, 1, (arg_347_1.time_ - 0) / var_350_3)

								iter_350_2.color = Color.New(var_350_4, var_350_4, var_350_4)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_3 and arg_347_1.time_ < 0 + var_350_3 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.actorSpriteComps10097 then
				for iter_350_3, iter_350_4 in pairs(arg_347_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_350_4 then
						iter_350_4.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_347_1.var_.actorSpriteComps10097 = nil
			end

			local var_350_5 = arg_347_1.actors_["10093"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_5) and arg_347_1.var_.actorSpriteComps10093 == nil then
				arg_347_1.var_.actorSpriteComps10093 = var_350_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_6 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_6 and not isNil(var_350_5) then
				if arg_347_1.var_.actorSpriteComps10093 then
					for iter_350_5, iter_350_6 in pairs(arg_347_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_350_6 then
							if arg_347_1.isInRecall_ then
								iter_350_6.color = Color.New(Mathf.Lerp(iter_350_6.color.r, arg_347_1.hightColor2.r, (arg_347_1.time_ - 0) / var_350_6), Mathf.Lerp(iter_350_6.color.g, arg_347_1.hightColor2.g, (arg_347_1.time_ - 0) / var_350_6), (Mathf.Lerp(iter_350_6.color.b, arg_347_1.hightColor2.b, (arg_347_1.time_ - 0) / var_350_6)))
							else
								local var_350_7 = Mathf.Lerp(iter_350_6.color.r, 0.5, (arg_347_1.time_ - 0) / var_350_6)

								iter_350_6.color = Color.New(var_350_7, var_350_7, var_350_7)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_6 and arg_347_1.time_ < 0 + var_350_6 + arg_350_0 and not isNil(var_350_5) and arg_347_1.var_.actorSpriteComps10093 then
				for iter_350_7, iter_350_8 in pairs(arg_347_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_350_8 then
						iter_350_8.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_347_1.var_.actorSpriteComps10093 = nil
			end

			local var_350_8 = 0
			local var_350_9 = 0.55

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_8 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_10 = arg_347_1:GetWordFromCfg(413091082)
				local var_350_11 = arg_347_1:FormatText(var_350_10.content)

				arg_347_1.text_.text = var_350_11

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_13 = 22 <= 0 and var_350_9 or var_350_9 * (utf8.len(var_350_11) / 22)

				if (22 <= 0 and var_350_9 or var_350_9 * (utf8.len(var_350_11) / 22)) > 0 and var_350_9 < var_350_13 then
					arg_347_1.talkMaxDuration = var_350_13

					if var_350_13 + var_350_8 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_13 + var_350_8
					end
				end

				arg_347_1.text_.text = var_350_11
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091082", "story_v_out_413091.awb") ~= 0 then
					local var_350_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091082", "story_v_out_413091.awb") / 1000

					if var_350_14 + var_350_8 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_14 + var_350_8
					end

					if var_350_10.prefab_name ~= "" and arg_347_1.actors_[var_350_10.prefab_name] ~= nil then
						local var_350_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_10.prefab_name].transform, "story_v_out_413091", "413091082", "story_v_out_413091.awb")

						arg_347_1:RecordAudio("413091082", var_350_15)
						arg_347_1:RecordAudio("413091082", var_350_15)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_413091", "413091082", "story_v_out_413091.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_413091", "413091082", "story_v_out_413091.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_16 = math.max(var_350_9, arg_347_1.talkMaxDuration)

			if var_350_8 <= arg_347_1.time_ and arg_347_1.time_ < var_350_8 + var_350_16 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_8) / var_350_16

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_8 + var_350_16 and arg_347_1.time_ < var_350_8 + var_350_16 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
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

		arg_347_1:InitPlayNodeList()
	end,
	Play413091083 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 413091083
		arg_351_1.duration_ = 3.93

		local var_351_0 = {
			zh = 3.733,
			ja = 3.933
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play413091084(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos10093 = arg_351_1.actors_["10093"].transform.localPosition
				arg_351_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_351_1:CheckSpriteTmpPos("10093", 2)

				for iter_354_0 = 0, arg_351_1.actors_["10093"].transform.childCount - 1 do
					local var_354_0 = arg_351_1.actors_["10093"].transform:GetChild(iter_354_0)

					if var_354_0.name == "split_4" or not string.find(var_354_0.name, "split") then
						var_354_0.gameObject:SetActive(true)
					else
						var_354_0.gameObject:SetActive(false)
					end
				end
			end

			local var_354_1 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_1 then
				arg_351_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_351_1.time_ - 0) / var_354_1)
			end

			if arg_351_1.time_ >= 0 + var_354_1 and arg_351_1.time_ < 0 + var_354_1 + arg_354_0 then
				arg_351_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_354_2 = arg_351_1.actors_["10093"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_2) and arg_351_1.var_.actorSpriteComps10093 == nil then
				arg_351_1.var_.actorSpriteComps10093 = var_354_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_3 = 2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_3 and not isNil(var_354_2) then
				if arg_351_1.var_.actorSpriteComps10093 then
					for iter_354_1, iter_354_2 in pairs(arg_351_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_354_2 then
							if arg_351_1.isInRecall_ then
								iter_354_2.color = Color.New(Mathf.Lerp(iter_354_2.color.r, arg_351_1.hightColor1.r, (arg_351_1.time_ - 0) / var_354_3), Mathf.Lerp(iter_354_2.color.g, arg_351_1.hightColor1.g, (arg_351_1.time_ - 0) / var_354_3), (Mathf.Lerp(iter_354_2.color.b, arg_351_1.hightColor1.b, (arg_351_1.time_ - 0) / var_354_3)))
							else
								local var_354_4 = Mathf.Lerp(iter_354_2.color.r, 1, (arg_351_1.time_ - 0) / var_354_3)

								iter_354_2.color = Color.New(var_354_4, var_354_4, var_354_4)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= 0 + var_354_3 and arg_351_1.time_ < 0 + var_354_3 + arg_354_0 and not isNil(var_354_2) and arg_351_1.var_.actorSpriteComps10093 then
				for iter_354_3, iter_354_4 in pairs(arg_351_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_354_4 then
						iter_354_4.color = arg_351_1.isInRecall_ and (arg_351_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_351_1.var_.actorSpriteComps10093 = nil
			end

			local var_354_5 = arg_351_1.actors_["10097"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_5) and arg_351_1.var_.actorSpriteComps10097 == nil then
				arg_351_1.var_.actorSpriteComps10097 = var_354_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_6 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_6 and not isNil(var_354_5) then
				if arg_351_1.var_.actorSpriteComps10097 then
					for iter_354_5, iter_354_6 in pairs(arg_351_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_354_6 then
							if arg_351_1.isInRecall_ then
								iter_354_6.color = Color.New(Mathf.Lerp(iter_354_6.color.r, arg_351_1.hightColor2.r, (arg_351_1.time_ - 0) / var_354_6), Mathf.Lerp(iter_354_6.color.g, arg_351_1.hightColor2.g, (arg_351_1.time_ - 0) / var_354_6), (Mathf.Lerp(iter_354_6.color.b, arg_351_1.hightColor2.b, (arg_351_1.time_ - 0) / var_354_6)))
							else
								local var_354_7 = Mathf.Lerp(iter_354_6.color.r, 0.5, (arg_351_1.time_ - 0) / var_354_6)

								iter_354_6.color = Color.New(var_354_7, var_354_7, var_354_7)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= 0 + var_354_6 and arg_351_1.time_ < 0 + var_354_6 + arg_354_0 and not isNil(var_354_5) and arg_351_1.var_.actorSpriteComps10097 then
				for iter_354_7, iter_354_8 in pairs(arg_351_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_354_8 then
						iter_354_8.color = arg_351_1.isInRecall_ and (arg_351_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_351_1.var_.actorSpriteComps10097 = nil
			end

			local var_354_8 = 0
			local var_354_9 = 0.375

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_8 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_10 = arg_351_1:GetWordFromCfg(413091083)
				local var_354_11 = arg_351_1:FormatText(var_354_10.content)

				arg_351_1.text_.text = var_354_11

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_13 = 15 <= 0 and var_354_9 or var_354_9 * (utf8.len(var_354_11) / 15)

				if (15 <= 0 and var_354_9 or var_354_9 * (utf8.len(var_354_11) / 15)) > 0 and var_354_9 < var_354_13 then
					arg_351_1.talkMaxDuration = var_354_13

					if var_354_13 + var_354_8 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_13 + var_354_8
					end
				end

				arg_351_1.text_.text = var_354_11
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091083", "story_v_out_413091.awb") ~= 0 then
					local var_354_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091083", "story_v_out_413091.awb") / 1000

					if var_354_14 + var_354_8 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_14 + var_354_8
					end

					if var_354_10.prefab_name ~= "" and arg_351_1.actors_[var_354_10.prefab_name] ~= nil then
						local var_354_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_10.prefab_name].transform, "story_v_out_413091", "413091083", "story_v_out_413091.awb")

						arg_351_1:RecordAudio("413091083", var_354_15)
						arg_351_1:RecordAudio("413091083", var_354_15)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_413091", "413091083", "story_v_out_413091.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_413091", "413091083", "story_v_out_413091.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_16 = math.max(var_354_9, arg_351_1.talkMaxDuration)

			if var_354_8 <= arg_351_1.time_ and arg_351_1.time_ < var_354_8 + var_354_16 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_8) / var_354_16

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_8 + var_354_16 and arg_351_1.time_ < var_354_8 + var_354_16 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
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

		arg_351_1:InitPlayNodeList()
	end,
	Play413091084 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 413091084
		arg_355_1.duration_ = 12.2

		local var_355_0 = {
			zh = 11.8,
			ja = 12.2
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play413091085(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 then
				arg_355_1.var_.moveOldPos10097 = arg_355_1.actors_["10097"].transform.localPosition
				arg_355_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_355_1:CheckSpriteTmpPos("10097", 4)

				for iter_358_0 = 0, arg_355_1.actors_["10097"].transform.childCount - 1 do
					local var_358_0 = arg_355_1.actors_["10097"].transform:GetChild(iter_358_0)

					if var_358_0.name == "split_2" or not string.find(var_358_0.name, "split") then
						var_358_0.gameObject:SetActive(true)
					else
						var_358_0.gameObject:SetActive(false)
					end
				end
			end

			local var_358_1 = 0.001

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_1 then
				arg_355_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_355_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_355_1.time_ - 0) / var_358_1)
			end

			if arg_355_1.time_ >= 0 + var_358_1 and arg_355_1.time_ < 0 + var_358_1 + arg_358_0 then
				arg_355_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_358_2 = arg_355_1.actors_["10097"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_2) and arg_355_1.var_.actorSpriteComps10097 == nil then
				arg_355_1.var_.actorSpriteComps10097 = var_358_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_3 = 2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_3 and not isNil(var_358_2) then
				if arg_355_1.var_.actorSpriteComps10097 then
					for iter_358_1, iter_358_2 in pairs(arg_355_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_358_2 then
							if arg_355_1.isInRecall_ then
								iter_358_2.color = Color.New(Mathf.Lerp(iter_358_2.color.r, arg_355_1.hightColor1.r, (arg_355_1.time_ - 0) / var_358_3), Mathf.Lerp(iter_358_2.color.g, arg_355_1.hightColor1.g, (arg_355_1.time_ - 0) / var_358_3), (Mathf.Lerp(iter_358_2.color.b, arg_355_1.hightColor1.b, (arg_355_1.time_ - 0) / var_358_3)))
							else
								local var_358_4 = Mathf.Lerp(iter_358_2.color.r, 1, (arg_355_1.time_ - 0) / var_358_3)

								iter_358_2.color = Color.New(var_358_4, var_358_4, var_358_4)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= 0 + var_358_3 and arg_355_1.time_ < 0 + var_358_3 + arg_358_0 and not isNil(var_358_2) and arg_355_1.var_.actorSpriteComps10097 then
				for iter_358_3, iter_358_4 in pairs(arg_355_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_358_4 then
						iter_358_4.color = arg_355_1.isInRecall_ and (arg_355_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_355_1.var_.actorSpriteComps10097 = nil
			end

			local var_358_5 = arg_355_1.actors_["10093"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_5) and arg_355_1.var_.actorSpriteComps10093 == nil then
				arg_355_1.var_.actorSpriteComps10093 = var_358_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_6 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_6 and not isNil(var_358_5) then
				if arg_355_1.var_.actorSpriteComps10093 then
					for iter_358_5, iter_358_6 in pairs(arg_355_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_358_6 then
							if arg_355_1.isInRecall_ then
								iter_358_6.color = Color.New(Mathf.Lerp(iter_358_6.color.r, arg_355_1.hightColor2.r, (arg_355_1.time_ - 0) / var_358_6), Mathf.Lerp(iter_358_6.color.g, arg_355_1.hightColor2.g, (arg_355_1.time_ - 0) / var_358_6), (Mathf.Lerp(iter_358_6.color.b, arg_355_1.hightColor2.b, (arg_355_1.time_ - 0) / var_358_6)))
							else
								local var_358_7 = Mathf.Lerp(iter_358_6.color.r, 0.5, (arg_355_1.time_ - 0) / var_358_6)

								iter_358_6.color = Color.New(var_358_7, var_358_7, var_358_7)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= 0 + var_358_6 and arg_355_1.time_ < 0 + var_358_6 + arg_358_0 and not isNil(var_358_5) and arg_355_1.var_.actorSpriteComps10093 then
				for iter_358_7, iter_358_8 in pairs(arg_355_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_358_8 then
						iter_358_8.color = arg_355_1.isInRecall_ and (arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_355_1.var_.actorSpriteComps10093 = nil
			end

			local var_358_8 = 0
			local var_358_9 = 0.8

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_8 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_10 = arg_355_1:GetWordFromCfg(413091084)
				local var_358_11 = arg_355_1:FormatText(var_358_10.content)

				arg_355_1.text_.text = var_358_11

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_13 = 32 <= 0 and var_358_9 or var_358_9 * (utf8.len(var_358_11) / 32)

				if (32 <= 0 and var_358_9 or var_358_9 * (utf8.len(var_358_11) / 32)) > 0 and var_358_9 < var_358_13 then
					arg_355_1.talkMaxDuration = var_358_13

					if var_358_13 + var_358_8 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_13 + var_358_8
					end
				end

				arg_355_1.text_.text = var_358_11
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091084", "story_v_out_413091.awb") ~= 0 then
					local var_358_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091084", "story_v_out_413091.awb") / 1000

					if var_358_14 + var_358_8 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_14 + var_358_8
					end

					if var_358_10.prefab_name ~= "" and arg_355_1.actors_[var_358_10.prefab_name] ~= nil then
						local var_358_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_10.prefab_name].transform, "story_v_out_413091", "413091084", "story_v_out_413091.awb")

						arg_355_1:RecordAudio("413091084", var_358_15)
						arg_355_1:RecordAudio("413091084", var_358_15)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_413091", "413091084", "story_v_out_413091.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_413091", "413091084", "story_v_out_413091.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_16 = math.max(var_358_9, arg_355_1.talkMaxDuration)

			if var_358_8 <= arg_355_1.time_ and arg_355_1.time_ < var_358_8 + var_358_16 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_8) / var_358_16

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_8 + var_358_16 and arg_355_1.time_ < var_358_8 + var_358_16 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {
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

		arg_355_1:InitPlayNodeList()
	end,
	Play413091085 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 413091085
		arg_359_1.duration_ = 15.63

		local var_359_0 = {
			zh = 11.3,
			ja = 15.633
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play413091086(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0.85

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_1 = arg_359_1:GetWordFromCfg(413091085)
				local var_362_2 = arg_359_1:FormatText(var_362_1.content)

				arg_359_1.text_.text = var_362_2

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_4 = 34 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 34)

				if (34 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 34)) > 0 and var_362_0 < var_362_4 then
					arg_359_1.talkMaxDuration = var_362_4

					if var_362_4 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_4 + 0
					end
				end

				arg_359_1.text_.text = var_362_2
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091085", "story_v_out_413091.awb") ~= 0 then
					local var_362_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091085", "story_v_out_413091.awb") / 1000

					if var_362_5 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + 0
					end

					if var_362_1.prefab_name ~= "" and arg_359_1.actors_[var_362_1.prefab_name] ~= nil then
						local var_362_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_1.prefab_name].transform, "story_v_out_413091", "413091085", "story_v_out_413091.awb")

						arg_359_1:RecordAudio("413091085", var_362_6)
						arg_359_1:RecordAudio("413091085", var_362_6)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_413091", "413091085", "story_v_out_413091.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_413091", "413091085", "story_v_out_413091.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_7 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_7 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_7

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_7 and arg_359_1.time_ < 0 + var_362_7 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play413091086 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 413091086
		arg_363_1.duration_ = 13.93

		local var_363_0 = {
			zh = 8.3,
			ja = 13.933
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play413091087(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos10097 = arg_363_1.actors_["10097"].transform.localPosition
				arg_363_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("10097", 4)

				for iter_366_0 = 0, arg_363_1.actors_["10097"].transform.childCount - 1 do
					local var_366_0 = arg_363_1.actors_["10097"].transform:GetChild(iter_366_0)

					if var_366_0.name == "split_4" or not string.find(var_366_0.name, "split") then
						var_366_0.gameObject:SetActive(true)
					else
						var_366_0.gameObject:SetActive(false)
					end
				end
			end

			local var_366_1 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_1 then
				arg_363_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_363_1.time_ - 0) / var_366_1)
			end

			if arg_363_1.time_ >= 0 + var_366_1 and arg_363_1.time_ < 0 + var_366_1 + arg_366_0 then
				arg_363_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_366_2 = 0
			local var_366_3 = 0.7

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_2 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_4 = arg_363_1:GetWordFromCfg(413091086)
				local var_366_5 = arg_363_1:FormatText(var_366_4.content)

				arg_363_1.text_.text = var_366_5

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_7 = 28 <= 0 and var_366_3 or var_366_3 * (utf8.len(var_366_5) / 28)

				if (28 <= 0 and var_366_3 or var_366_3 * (utf8.len(var_366_5) / 28)) > 0 and var_366_3 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_2 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_2
					end
				end

				arg_363_1.text_.text = var_366_5
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091086", "story_v_out_413091.awb") ~= 0 then
					local var_366_8 = manager.audio:GetVoiceLength("story_v_out_413091", "413091086", "story_v_out_413091.awb") / 1000

					if var_366_8 + var_366_2 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_8 + var_366_2
					end

					if var_366_4.prefab_name ~= "" and arg_363_1.actors_[var_366_4.prefab_name] ~= nil then
						local var_366_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_4.prefab_name].transform, "story_v_out_413091", "413091086", "story_v_out_413091.awb")

						arg_363_1:RecordAudio("413091086", var_366_9)
						arg_363_1:RecordAudio("413091086", var_366_9)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_413091", "413091086", "story_v_out_413091.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_413091", "413091086", "story_v_out_413091.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_10 = math.max(var_366_3, arg_363_1.talkMaxDuration)

			if var_366_2 <= arg_363_1.time_ and arg_363_1.time_ < var_366_2 + var_366_10 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_2) / var_366_10

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_2 + var_366_10 and arg_363_1.time_ < var_366_2 + var_366_10 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
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

		arg_363_1:InitPlayNodeList()
	end,
	Play413091087 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 413091087
		arg_367_1.duration_ = 10.4

		local var_367_0 = {
			zh = 6,
			ja = 10.4
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play413091088(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos10093 = arg_367_1.actors_["10093"].transform.localPosition
				arg_367_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("10093", 2)

				for iter_370_0 = 0, arg_367_1.actors_["10093"].transform.childCount - 1 do
					local var_370_0 = arg_367_1.actors_["10093"].transform:GetChild(iter_370_0)

					if var_370_0.name == "split_7" or not string.find(var_370_0.name, "split") then
						var_370_0.gameObject:SetActive(true)
					else
						var_370_0.gameObject:SetActive(false)
					end
				end
			end

			local var_370_1 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_1 then
				arg_367_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_367_1.time_ - 0) / var_370_1)
			end

			if arg_367_1.time_ >= 0 + var_370_1 and arg_367_1.time_ < 0 + var_370_1 + arg_370_0 then
				arg_367_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_370_2 = arg_367_1.actors_["10093"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_2) and arg_367_1.var_.actorSpriteComps10093 == nil then
				arg_367_1.var_.actorSpriteComps10093 = var_370_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_3 = 2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_3 and not isNil(var_370_2) then
				if arg_367_1.var_.actorSpriteComps10093 then
					for iter_370_1, iter_370_2 in pairs(arg_367_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_370_2 then
							if arg_367_1.isInRecall_ then
								iter_370_2.color = Color.New(Mathf.Lerp(iter_370_2.color.r, arg_367_1.hightColor1.r, (arg_367_1.time_ - 0) / var_370_3), Mathf.Lerp(iter_370_2.color.g, arg_367_1.hightColor1.g, (arg_367_1.time_ - 0) / var_370_3), (Mathf.Lerp(iter_370_2.color.b, arg_367_1.hightColor1.b, (arg_367_1.time_ - 0) / var_370_3)))
							else
								local var_370_4 = Mathf.Lerp(iter_370_2.color.r, 1, (arg_367_1.time_ - 0) / var_370_3)

								iter_370_2.color = Color.New(var_370_4, var_370_4, var_370_4)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= 0 + var_370_3 and arg_367_1.time_ < 0 + var_370_3 + arg_370_0 and not isNil(var_370_2) and arg_367_1.var_.actorSpriteComps10093 then
				for iter_370_3, iter_370_4 in pairs(arg_367_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_370_4 then
						iter_370_4.color = arg_367_1.isInRecall_ and (arg_367_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_367_1.var_.actorSpriteComps10093 = nil
			end

			local var_370_5 = arg_367_1.actors_["10097"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_5) and arg_367_1.var_.actorSpriteComps10097 == nil then
				arg_367_1.var_.actorSpriteComps10097 = var_370_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_6 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_6 and not isNil(var_370_5) then
				if arg_367_1.var_.actorSpriteComps10097 then
					for iter_370_5, iter_370_6 in pairs(arg_367_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_370_6 then
							if arg_367_1.isInRecall_ then
								iter_370_6.color = Color.New(Mathf.Lerp(iter_370_6.color.r, arg_367_1.hightColor2.r, (arg_367_1.time_ - 0) / var_370_6), Mathf.Lerp(iter_370_6.color.g, arg_367_1.hightColor2.g, (arg_367_1.time_ - 0) / var_370_6), (Mathf.Lerp(iter_370_6.color.b, arg_367_1.hightColor2.b, (arg_367_1.time_ - 0) / var_370_6)))
							else
								local var_370_7 = Mathf.Lerp(iter_370_6.color.r, 0.5, (arg_367_1.time_ - 0) / var_370_6)

								iter_370_6.color = Color.New(var_370_7, var_370_7, var_370_7)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= 0 + var_370_6 and arg_367_1.time_ < 0 + var_370_6 + arg_370_0 and not isNil(var_370_5) and arg_367_1.var_.actorSpriteComps10097 then
				for iter_370_7, iter_370_8 in pairs(arg_367_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_370_8 then
						iter_370_8.color = arg_367_1.isInRecall_ and (arg_367_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_367_1.var_.actorSpriteComps10097 = nil
			end

			local var_370_8 = 0
			local var_370_9 = 0.7

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_8 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_10 = arg_367_1:GetWordFromCfg(413091087)
				local var_370_11 = arg_367_1:FormatText(var_370_10.content)

				arg_367_1.text_.text = var_370_11

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_13 = 28 <= 0 and var_370_9 or var_370_9 * (utf8.len(var_370_11) / 28)

				if (28 <= 0 and var_370_9 or var_370_9 * (utf8.len(var_370_11) / 28)) > 0 and var_370_9 < var_370_13 then
					arg_367_1.talkMaxDuration = var_370_13

					if var_370_13 + var_370_8 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_13 + var_370_8
					end
				end

				arg_367_1.text_.text = var_370_11
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091087", "story_v_out_413091.awb") ~= 0 then
					local var_370_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091087", "story_v_out_413091.awb") / 1000

					if var_370_14 + var_370_8 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_14 + var_370_8
					end

					if var_370_10.prefab_name ~= "" and arg_367_1.actors_[var_370_10.prefab_name] ~= nil then
						local var_370_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_10.prefab_name].transform, "story_v_out_413091", "413091087", "story_v_out_413091.awb")

						arg_367_1:RecordAudio("413091087", var_370_15)
						arg_367_1:RecordAudio("413091087", var_370_15)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_413091", "413091087", "story_v_out_413091.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_413091", "413091087", "story_v_out_413091.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_16 = math.max(var_370_9, arg_367_1.talkMaxDuration)

			if var_370_8 <= arg_367_1.time_ and arg_367_1.time_ < var_370_8 + var_370_16 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_8) / var_370_16

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_8 + var_370_16 and arg_367_1.time_ < var_370_8 + var_370_16 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {
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

		arg_367_1:InitPlayNodeList()
	end,
	Play413091088 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 413091088
		arg_371_1.duration_ = 7

		local var_371_0 = {
			zh = 6.566,
			ja = 7
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play413091089(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPos10097 = arg_371_1.actors_["10097"].transform.localPosition
				arg_371_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_371_1:CheckSpriteTmpPos("10097", 4)

				for iter_374_0 = 0, arg_371_1.actors_["10097"].transform.childCount - 1 do
					local var_374_0 = arg_371_1.actors_["10097"].transform:GetChild(iter_374_0)

					if var_374_0.name == "split_4" or not string.find(var_374_0.name, "split") then
						var_374_0.gameObject:SetActive(true)
					else
						var_374_0.gameObject:SetActive(false)
					end
				end
			end

			local var_374_1 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_1 then
				arg_371_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_371_1.time_ - 0) / var_374_1)
			end

			if arg_371_1.time_ >= 0 + var_374_1 and arg_371_1.time_ < 0 + var_374_1 + arg_374_0 then
				arg_371_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_374_2 = arg_371_1.actors_["10097"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_2) and arg_371_1.var_.actorSpriteComps10097 == nil then
				arg_371_1.var_.actorSpriteComps10097 = var_374_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_3 = 2

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_3 and not isNil(var_374_2) then
				if arg_371_1.var_.actorSpriteComps10097 then
					for iter_374_1, iter_374_2 in pairs(arg_371_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_374_2 then
							if arg_371_1.isInRecall_ then
								iter_374_2.color = Color.New(Mathf.Lerp(iter_374_2.color.r, arg_371_1.hightColor1.r, (arg_371_1.time_ - 0) / var_374_3), Mathf.Lerp(iter_374_2.color.g, arg_371_1.hightColor1.g, (arg_371_1.time_ - 0) / var_374_3), (Mathf.Lerp(iter_374_2.color.b, arg_371_1.hightColor1.b, (arg_371_1.time_ - 0) / var_374_3)))
							else
								local var_374_4 = Mathf.Lerp(iter_374_2.color.r, 1, (arg_371_1.time_ - 0) / var_374_3)

								iter_374_2.color = Color.New(var_374_4, var_374_4, var_374_4)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= 0 + var_374_3 and arg_371_1.time_ < 0 + var_374_3 + arg_374_0 and not isNil(var_374_2) and arg_371_1.var_.actorSpriteComps10097 then
				for iter_374_3, iter_374_4 in pairs(arg_371_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_374_4 then
						iter_374_4.color = arg_371_1.isInRecall_ and (arg_371_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_371_1.var_.actorSpriteComps10097 = nil
			end

			local var_374_5 = arg_371_1.actors_["10093"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_5) and arg_371_1.var_.actorSpriteComps10093 == nil then
				arg_371_1.var_.actorSpriteComps10093 = var_374_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_374_6 = 0.2

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_6 and not isNil(var_374_5) then
				if arg_371_1.var_.actorSpriteComps10093 then
					for iter_374_5, iter_374_6 in pairs(arg_371_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_374_6 then
							if arg_371_1.isInRecall_ then
								iter_374_6.color = Color.New(Mathf.Lerp(iter_374_6.color.r, arg_371_1.hightColor2.r, (arg_371_1.time_ - 0) / var_374_6), Mathf.Lerp(iter_374_6.color.g, arg_371_1.hightColor2.g, (arg_371_1.time_ - 0) / var_374_6), (Mathf.Lerp(iter_374_6.color.b, arg_371_1.hightColor2.b, (arg_371_1.time_ - 0) / var_374_6)))
							else
								local var_374_7 = Mathf.Lerp(iter_374_6.color.r, 0.5, (arg_371_1.time_ - 0) / var_374_6)

								iter_374_6.color = Color.New(var_374_7, var_374_7, var_374_7)
							end
						end
					end
				end
			end

			if arg_371_1.time_ >= 0 + var_374_6 and arg_371_1.time_ < 0 + var_374_6 + arg_374_0 and not isNil(var_374_5) and arg_371_1.var_.actorSpriteComps10093 then
				for iter_374_7, iter_374_8 in pairs(arg_371_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_374_8 then
						iter_374_8.color = arg_371_1.isInRecall_ and (arg_371_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_371_1.var_.actorSpriteComps10093 = nil
			end

			local var_374_8 = 0
			local var_374_9 = 0.5

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_8 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_10 = arg_371_1:GetWordFromCfg(413091088)
				local var_374_11 = arg_371_1:FormatText(var_374_10.content)

				arg_371_1.text_.text = var_374_11

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_13 = 20 <= 0 and var_374_9 or var_374_9 * (utf8.len(var_374_11) / 20)

				if (20 <= 0 and var_374_9 or var_374_9 * (utf8.len(var_374_11) / 20)) > 0 and var_374_9 < var_374_13 then
					arg_371_1.talkMaxDuration = var_374_13

					if var_374_13 + var_374_8 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_13 + var_374_8
					end
				end

				arg_371_1.text_.text = var_374_11
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091088", "story_v_out_413091.awb") ~= 0 then
					local var_374_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091088", "story_v_out_413091.awb") / 1000

					if var_374_14 + var_374_8 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_14 + var_374_8
					end

					if var_374_10.prefab_name ~= "" and arg_371_1.actors_[var_374_10.prefab_name] ~= nil then
						local var_374_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_10.prefab_name].transform, "story_v_out_413091", "413091088", "story_v_out_413091.awb")

						arg_371_1:RecordAudio("413091088", var_374_15)
						arg_371_1:RecordAudio("413091088", var_374_15)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_413091", "413091088", "story_v_out_413091.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_413091", "413091088", "story_v_out_413091.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_16 = math.max(var_374_9, arg_371_1.talkMaxDuration)

			if var_374_8 <= arg_371_1.time_ and arg_371_1.time_ < var_374_8 + var_374_16 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_8) / var_374_16

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_8 + var_374_16 and arg_371_1.time_ < var_374_8 + var_374_16 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
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

		arg_371_1:InitPlayNodeList()
	end,
	Play413091089 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 413091089
		arg_375_1.duration_ = 13.3

		local var_375_0 = {
			zh = 9.3,
			ja = 13.3
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play413091090(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos10097 = arg_375_1.actors_["10097"].transform.localPosition
				arg_375_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("10097", 4)

				for iter_378_0 = 0, arg_375_1.actors_["10097"].transform.childCount - 1 do
					local var_378_0 = arg_375_1.actors_["10097"].transform:GetChild(iter_378_0)

					if var_378_0.name == "split_2" or not string.find(var_378_0.name, "split") then
						var_378_0.gameObject:SetActive(true)
					else
						var_378_0.gameObject:SetActive(false)
					end
				end
			end

			local var_378_1 = 0.001

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_1 then
				arg_375_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_375_1.time_ - 0) / var_378_1)
			end

			if arg_375_1.time_ >= 0 + var_378_1 and arg_375_1.time_ < 0 + var_378_1 + arg_378_0 then
				arg_375_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_378_2 = arg_375_1.actors_["10097"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_2) and arg_375_1.var_.actorSpriteComps10097 == nil then
				arg_375_1.var_.actorSpriteComps10097 = var_378_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_3 = 2

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_3 and not isNil(var_378_2) then
				if arg_375_1.var_.actorSpriteComps10097 then
					for iter_378_1, iter_378_2 in pairs(arg_375_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_378_2 then
							if arg_375_1.isInRecall_ then
								iter_378_2.color = Color.New(Mathf.Lerp(iter_378_2.color.r, arg_375_1.hightColor1.r, (arg_375_1.time_ - 0) / var_378_3), Mathf.Lerp(iter_378_2.color.g, arg_375_1.hightColor1.g, (arg_375_1.time_ - 0) / var_378_3), (Mathf.Lerp(iter_378_2.color.b, arg_375_1.hightColor1.b, (arg_375_1.time_ - 0) / var_378_3)))
							else
								local var_378_4 = Mathf.Lerp(iter_378_2.color.r, 1, (arg_375_1.time_ - 0) / var_378_3)

								iter_378_2.color = Color.New(var_378_4, var_378_4, var_378_4)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= 0 + var_378_3 and arg_375_1.time_ < 0 + var_378_3 + arg_378_0 and not isNil(var_378_2) and arg_375_1.var_.actorSpriteComps10097 then
				for iter_378_3, iter_378_4 in pairs(arg_375_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_378_4 then
						iter_378_4.color = arg_375_1.isInRecall_ and (arg_375_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_375_1.var_.actorSpriteComps10097 = nil
			end

			local var_378_5 = 0
			local var_378_6 = 0.875

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_5 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_7 = arg_375_1:GetWordFromCfg(413091089)
				local var_378_8 = arg_375_1:FormatText(var_378_7.content)

				arg_375_1.text_.text = var_378_8

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_10 = 35 <= 0 and var_378_6 or var_378_6 * (utf8.len(var_378_8) / 35)

				if (35 <= 0 and var_378_6 or var_378_6 * (utf8.len(var_378_8) / 35)) > 0 and var_378_6 < var_378_10 then
					arg_375_1.talkMaxDuration = var_378_10

					if var_378_10 + var_378_5 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_5
					end
				end

				arg_375_1.text_.text = var_378_8
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091089", "story_v_out_413091.awb") ~= 0 then
					local var_378_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091089", "story_v_out_413091.awb") / 1000

					if var_378_11 + var_378_5 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_11 + var_378_5
					end

					if var_378_7.prefab_name ~= "" and arg_375_1.actors_[var_378_7.prefab_name] ~= nil then
						local var_378_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_7.prefab_name].transform, "story_v_out_413091", "413091089", "story_v_out_413091.awb")

						arg_375_1:RecordAudio("413091089", var_378_12)
						arg_375_1:RecordAudio("413091089", var_378_12)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_413091", "413091089", "story_v_out_413091.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_413091", "413091089", "story_v_out_413091.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_13 = math.max(var_378_6, arg_375_1.talkMaxDuration)

			if var_378_5 <= arg_375_1.time_ and arg_375_1.time_ < var_378_5 + var_378_13 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_5) / var_378_13

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_5 + var_378_13 and arg_375_1.time_ < var_378_5 + var_378_13 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
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

		arg_375_1:InitPlayNodeList()
	end,
	Play413091090 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 413091090
		arg_379_1.duration_ = 3.67

		local var_379_0 = {
			zh = 3.466,
			ja = 3.666
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play413091091(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos10093 = arg_379_1.actors_["10093"].transform.localPosition
				arg_379_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("10093", 2)

				for iter_382_0 = 0, arg_379_1.actors_["10093"].transform.childCount - 1 do
					local var_382_0 = arg_379_1.actors_["10093"].transform:GetChild(iter_382_0)

					if var_382_0.name == "split_4" or not string.find(var_382_0.name, "split") then
						var_382_0.gameObject:SetActive(true)
					else
						var_382_0.gameObject:SetActive(false)
					end
				end
			end

			local var_382_1 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_1 then
				arg_379_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_379_1.time_ - 0) / var_382_1)
			end

			if arg_379_1.time_ >= 0 + var_382_1 and arg_379_1.time_ < 0 + var_382_1 + arg_382_0 then
				arg_379_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_382_2 = arg_379_1.actors_["10093"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_2) and arg_379_1.var_.actorSpriteComps10093 == nil then
				arg_379_1.var_.actorSpriteComps10093 = var_382_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_3 = 2

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_3 and not isNil(var_382_2) then
				if arg_379_1.var_.actorSpriteComps10093 then
					for iter_382_1, iter_382_2 in pairs(arg_379_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_382_2 then
							if arg_379_1.isInRecall_ then
								iter_382_2.color = Color.New(Mathf.Lerp(iter_382_2.color.r, arg_379_1.hightColor1.r, (arg_379_1.time_ - 0) / var_382_3), Mathf.Lerp(iter_382_2.color.g, arg_379_1.hightColor1.g, (arg_379_1.time_ - 0) / var_382_3), (Mathf.Lerp(iter_382_2.color.b, arg_379_1.hightColor1.b, (arg_379_1.time_ - 0) / var_382_3)))
							else
								local var_382_4 = Mathf.Lerp(iter_382_2.color.r, 1, (arg_379_1.time_ - 0) / var_382_3)

								iter_382_2.color = Color.New(var_382_4, var_382_4, var_382_4)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= 0 + var_382_3 and arg_379_1.time_ < 0 + var_382_3 + arg_382_0 and not isNil(var_382_2) and arg_379_1.var_.actorSpriteComps10093 then
				for iter_382_3, iter_382_4 in pairs(arg_379_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_382_4 then
						iter_382_4.color = arg_379_1.isInRecall_ and (arg_379_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_379_1.var_.actorSpriteComps10093 = nil
			end

			local var_382_5 = arg_379_1.actors_["10097"]

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 and not isNil(var_382_5) and arg_379_1.var_.actorSpriteComps10097 == nil then
				arg_379_1.var_.actorSpriteComps10097 = var_382_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_382_6 = 0.2

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_6 and not isNil(var_382_5) then
				if arg_379_1.var_.actorSpriteComps10097 then
					for iter_382_5, iter_382_6 in pairs(arg_379_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_382_6 then
							if arg_379_1.isInRecall_ then
								iter_382_6.color = Color.New(Mathf.Lerp(iter_382_6.color.r, arg_379_1.hightColor2.r, (arg_379_1.time_ - 0) / var_382_6), Mathf.Lerp(iter_382_6.color.g, arg_379_1.hightColor2.g, (arg_379_1.time_ - 0) / var_382_6), (Mathf.Lerp(iter_382_6.color.b, arg_379_1.hightColor2.b, (arg_379_1.time_ - 0) / var_382_6)))
							else
								local var_382_7 = Mathf.Lerp(iter_382_6.color.r, 0.5, (arg_379_1.time_ - 0) / var_382_6)

								iter_382_6.color = Color.New(var_382_7, var_382_7, var_382_7)
							end
						end
					end
				end
			end

			if arg_379_1.time_ >= 0 + var_382_6 and arg_379_1.time_ < 0 + var_382_6 + arg_382_0 and not isNil(var_382_5) and arg_379_1.var_.actorSpriteComps10097 then
				for iter_382_7, iter_382_8 in pairs(arg_379_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_382_8 then
						iter_382_8.color = arg_379_1.isInRecall_ and (arg_379_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_379_1.var_.actorSpriteComps10097 = nil
			end

			local var_382_8 = 0
			local var_382_9 = 0.325

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_8 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_10 = arg_379_1:GetWordFromCfg(413091090)
				local var_382_11 = arg_379_1:FormatText(var_382_10.content)

				arg_379_1.text_.text = var_382_11

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_13 = 13 <= 0 and var_382_9 or var_382_9 * (utf8.len(var_382_11) / 13)

				if (13 <= 0 and var_382_9 or var_382_9 * (utf8.len(var_382_11) / 13)) > 0 and var_382_9 < var_382_13 then
					arg_379_1.talkMaxDuration = var_382_13

					if var_382_13 + var_382_8 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_13 + var_382_8
					end
				end

				arg_379_1.text_.text = var_382_11
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091090", "story_v_out_413091.awb") ~= 0 then
					local var_382_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091090", "story_v_out_413091.awb") / 1000

					if var_382_14 + var_382_8 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_14 + var_382_8
					end

					if var_382_10.prefab_name ~= "" and arg_379_1.actors_[var_382_10.prefab_name] ~= nil then
						local var_382_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_10.prefab_name].transform, "story_v_out_413091", "413091090", "story_v_out_413091.awb")

						arg_379_1:RecordAudio("413091090", var_382_15)
						arg_379_1:RecordAudio("413091090", var_382_15)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_413091", "413091090", "story_v_out_413091.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_413091", "413091090", "story_v_out_413091.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_16 = math.max(var_382_9, arg_379_1.talkMaxDuration)

			if var_382_8 <= arg_379_1.time_ and arg_379_1.time_ < var_382_8 + var_382_16 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_8) / var_382_16

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_8 + var_382_16 and arg_379_1.time_ < var_382_8 + var_382_16 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
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

		arg_379_1:InitPlayNodeList()
	end,
	Play413091091 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 413091091
		arg_383_1.duration_ = 10.33

		local var_383_0 = {
			zh = 10.333,
			ja = 10.1
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
				arg_383_0:Play413091092(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos10097 = arg_383_1.actors_["10097"].transform.localPosition
				arg_383_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("10097", 4)

				for iter_386_0 = 0, arg_383_1.actors_["10097"].transform.childCount - 1 do
					local var_386_0 = arg_383_1.actors_["10097"].transform:GetChild(iter_386_0)

					if var_386_0.name == "split_4" or not string.find(var_386_0.name, "split") then
						var_386_0.gameObject:SetActive(true)
					else
						var_386_0.gameObject:SetActive(false)
					end
				end
			end

			local var_386_1 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_1 then
				arg_383_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_383_1.time_ - 0) / var_386_1)
			end

			if arg_383_1.time_ >= 0 + var_386_1 and arg_383_1.time_ < 0 + var_386_1 + arg_386_0 then
				arg_383_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_386_2 = arg_383_1.actors_["10097"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_2) and arg_383_1.var_.actorSpriteComps10097 == nil then
				arg_383_1.var_.actorSpriteComps10097 = var_386_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_3 = 2

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_3 and not isNil(var_386_2) then
				if arg_383_1.var_.actorSpriteComps10097 then
					for iter_386_1, iter_386_2 in pairs(arg_383_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_386_2 then
							if arg_383_1.isInRecall_ then
								iter_386_2.color = Color.New(Mathf.Lerp(iter_386_2.color.r, arg_383_1.hightColor1.r, (arg_383_1.time_ - 0) / var_386_3), Mathf.Lerp(iter_386_2.color.g, arg_383_1.hightColor1.g, (arg_383_1.time_ - 0) / var_386_3), (Mathf.Lerp(iter_386_2.color.b, arg_383_1.hightColor1.b, (arg_383_1.time_ - 0) / var_386_3)))
							else
								local var_386_4 = Mathf.Lerp(iter_386_2.color.r, 1, (arg_383_1.time_ - 0) / var_386_3)

								iter_386_2.color = Color.New(var_386_4, var_386_4, var_386_4)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= 0 + var_386_3 and arg_383_1.time_ < 0 + var_386_3 + arg_386_0 and not isNil(var_386_2) and arg_383_1.var_.actorSpriteComps10097 then
				for iter_386_3, iter_386_4 in pairs(arg_383_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_386_4 then
						iter_386_4.color = arg_383_1.isInRecall_ and (arg_383_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_383_1.var_.actorSpriteComps10097 = nil
			end

			local var_386_5 = arg_383_1.actors_["10093"]

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(var_386_5) and arg_383_1.var_.actorSpriteComps10093 == nil then
				arg_383_1.var_.actorSpriteComps10093 = var_386_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_6 = 0.2

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_6 and not isNil(var_386_5) then
				if arg_383_1.var_.actorSpriteComps10093 then
					for iter_386_5, iter_386_6 in pairs(arg_383_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_386_6 then
							if arg_383_1.isInRecall_ then
								iter_386_6.color = Color.New(Mathf.Lerp(iter_386_6.color.r, arg_383_1.hightColor2.r, (arg_383_1.time_ - 0) / var_386_6), Mathf.Lerp(iter_386_6.color.g, arg_383_1.hightColor2.g, (arg_383_1.time_ - 0) / var_386_6), (Mathf.Lerp(iter_386_6.color.b, arg_383_1.hightColor2.b, (arg_383_1.time_ - 0) / var_386_6)))
							else
								local var_386_7 = Mathf.Lerp(iter_386_6.color.r, 0.5, (arg_383_1.time_ - 0) / var_386_6)

								iter_386_6.color = Color.New(var_386_7, var_386_7, var_386_7)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= 0 + var_386_6 and arg_383_1.time_ < 0 + var_386_6 + arg_386_0 and not isNil(var_386_5) and arg_383_1.var_.actorSpriteComps10093 then
				for iter_386_7, iter_386_8 in pairs(arg_383_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_386_8 then
						iter_386_8.color = arg_383_1.isInRecall_ and (arg_383_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_383_1.var_.actorSpriteComps10093 = nil
			end

			local var_386_8 = arg_383_1.actors_["10093"].transform

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos10093 = var_386_8.localPosition
				var_386_8.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("10093", 2)

				for iter_386_9 = 0, var_386_8.childCount - 1 do
					local var_386_9 = var_386_8:GetChild(iter_386_9)

					if var_386_9.name == "split_7" or not string.find(var_386_9.name, "split") then
						var_386_9.gameObject:SetActive(true)
					else
						var_386_9.gameObject:SetActive(false)
					end
				end
			end

			local var_386_10 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_10 then
				var_386_8.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_383_1.time_ - 0) / var_386_10)
			end

			if arg_383_1.time_ >= 0 + var_386_10 and arg_383_1.time_ < 0 + var_386_10 + arg_386_0 then
				var_386_8.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_386_11 = 0
			local var_386_12 = 0.875

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_11 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_13 = arg_383_1:GetWordFromCfg(413091091)
				local var_386_14 = arg_383_1:FormatText(var_386_13.content)

				arg_383_1.text_.text = var_386_14

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_16 = 35 <= 0 and var_386_12 or var_386_12 * (utf8.len(var_386_14) / 35)

				if (35 <= 0 and var_386_12 or var_386_12 * (utf8.len(var_386_14) / 35)) > 0 and var_386_12 < var_386_16 then
					arg_383_1.talkMaxDuration = var_386_16

					if var_386_16 + var_386_11 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_16 + var_386_11
					end
				end

				arg_383_1.text_.text = var_386_14
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091091", "story_v_out_413091.awb") ~= 0 then
					local var_386_17 = manager.audio:GetVoiceLength("story_v_out_413091", "413091091", "story_v_out_413091.awb") / 1000

					if var_386_17 + var_386_11 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_17 + var_386_11
					end

					if var_386_13.prefab_name ~= "" and arg_383_1.actors_[var_386_13.prefab_name] ~= nil then
						local var_386_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_13.prefab_name].transform, "story_v_out_413091", "413091091", "story_v_out_413091.awb")

						arg_383_1:RecordAudio("413091091", var_386_18)
						arg_383_1:RecordAudio("413091091", var_386_18)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_413091", "413091091", "story_v_out_413091.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_413091", "413091091", "story_v_out_413091.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_19 = math.max(var_386_12, arg_383_1.talkMaxDuration)

			if var_386_11 <= arg_383_1.time_ and arg_383_1.time_ < var_386_11 + var_386_19 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_11) / var_386_19

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_11 + var_386_19 and arg_383_1.time_ < var_386_11 + var_386_19 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
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
				actorName = "10093",
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
	Play413091092 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 413091092
		arg_387_1.duration_ = 10.1

		local var_387_0 = {
			zh = 5.466,
			ja = 10.1
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
				arg_387_0:Play413091093(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos10097 = arg_387_1.actors_["10097"].transform.localPosition
				arg_387_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_387_1:CheckSpriteTmpPos("10097", 4)

				for iter_390_0 = 0, arg_387_1.actors_["10097"].transform.childCount - 1 do
					local var_390_0 = arg_387_1.actors_["10097"].transform:GetChild(iter_390_0)

					if var_390_0.name == "split_1" or not string.find(var_390_0.name, "split") then
						var_390_0.gameObject:SetActive(true)
					else
						var_390_0.gameObject:SetActive(false)
					end
				end
			end

			local var_390_1 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_1 then
				arg_387_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_387_1.time_ - 0) / var_390_1)
			end

			if arg_387_1.time_ >= 0 + var_390_1 and arg_387_1.time_ < 0 + var_390_1 + arg_390_0 then
				arg_387_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_390_2 = 0
			local var_390_3 = 0.45

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_2 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_4 = arg_387_1:GetWordFromCfg(413091092)
				local var_390_5 = arg_387_1:FormatText(var_390_4.content)

				arg_387_1.text_.text = var_390_5

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_7 = 18 <= 0 and var_390_3 or var_390_3 * (utf8.len(var_390_5) / 18)

				if (18 <= 0 and var_390_3 or var_390_3 * (utf8.len(var_390_5) / 18)) > 0 and var_390_3 < var_390_7 then
					arg_387_1.talkMaxDuration = var_390_7

					if var_390_7 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_7 + var_390_2
					end
				end

				arg_387_1.text_.text = var_390_5
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091092", "story_v_out_413091.awb") ~= 0 then
					local var_390_8 = manager.audio:GetVoiceLength("story_v_out_413091", "413091092", "story_v_out_413091.awb") / 1000

					if var_390_8 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_8 + var_390_2
					end

					if var_390_4.prefab_name ~= "" and arg_387_1.actors_[var_390_4.prefab_name] ~= nil then
						local var_390_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_4.prefab_name].transform, "story_v_out_413091", "413091092", "story_v_out_413091.awb")

						arg_387_1:RecordAudio("413091092", var_390_9)
						arg_387_1:RecordAudio("413091092", var_390_9)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_413091", "413091092", "story_v_out_413091.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_413091", "413091092", "story_v_out_413091.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_10 = math.max(var_390_3, arg_387_1.talkMaxDuration)

			if var_390_2 <= arg_387_1.time_ and arg_387_1.time_ < var_390_2 + var_390_10 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_2) / var_390_10

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_2 + var_390_10 and arg_387_1.time_ < var_390_2 + var_390_10 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
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

		arg_387_1:InitPlayNodeList()
	end,
	Play413091093 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 413091093
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play413091094(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos10093 = arg_391_1.actors_["10093"].transform.localPosition
				arg_391_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_391_1:CheckSpriteTmpPos("10093", 7)

				for iter_394_0 = 0, arg_391_1.actors_["10093"].transform.childCount - 1 do
					local var_394_0 = arg_391_1.actors_["10093"].transform:GetChild(iter_394_0)

					if var_394_0.name == "split_3" or not string.find(var_394_0.name, "split") then
						var_394_0.gameObject:SetActive(true)
					else
						var_394_0.gameObject:SetActive(false)
					end
				end
			end

			local var_394_1 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_1 then
				arg_391_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_391_1.time_ - 0) / var_394_1)
			end

			if arg_391_1.time_ >= 0 + var_394_1 and arg_391_1.time_ < 0 + var_394_1 + arg_394_0 then
				arg_391_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_394_2 = arg_391_1.actors_["10093"]

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(var_394_2) and arg_391_1.var_.actorSpriteComps10093 == nil then
				arg_391_1.var_.actorSpriteComps10093 = var_394_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_394_3 = 2

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_3 and not isNil(var_394_2) then
				if arg_391_1.var_.actorSpriteComps10093 then
					for iter_394_1, iter_394_2 in pairs(arg_391_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_394_2 then
							if arg_391_1.isInRecall_ then
								iter_394_2.color = Color.New(Mathf.Lerp(iter_394_2.color.r, arg_391_1.hightColor1.r, (arg_391_1.time_ - 0) / var_394_3), Mathf.Lerp(iter_394_2.color.g, arg_391_1.hightColor1.g, (arg_391_1.time_ - 0) / var_394_3), (Mathf.Lerp(iter_394_2.color.b, arg_391_1.hightColor1.b, (arg_391_1.time_ - 0) / var_394_3)))
							else
								local var_394_4 = Mathf.Lerp(iter_394_2.color.r, 1, (arg_391_1.time_ - 0) / var_394_3)

								iter_394_2.color = Color.New(var_394_4, var_394_4, var_394_4)
							end
						end
					end
				end
			end

			if arg_391_1.time_ >= 0 + var_394_3 and arg_391_1.time_ < 0 + var_394_3 + arg_394_0 and not isNil(var_394_2) and arg_391_1.var_.actorSpriteComps10093 then
				for iter_394_3, iter_394_4 in pairs(arg_391_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_394_4 then
						iter_394_4.color = arg_391_1.isInRecall_ and (arg_391_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_391_1.var_.actorSpriteComps10093 = nil
			end

			local var_394_5 = arg_391_1.actors_["10097"]

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 and not isNil(var_394_5) and arg_391_1.var_.actorSpriteComps10097 == nil then
				arg_391_1.var_.actorSpriteComps10097 = var_394_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_394_6 = 0.2

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_6 and not isNil(var_394_5) then
				if arg_391_1.var_.actorSpriteComps10097 then
					for iter_394_5, iter_394_6 in pairs(arg_391_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_394_6 then
							if arg_391_1.isInRecall_ then
								iter_394_6.color = Color.New(Mathf.Lerp(iter_394_6.color.r, arg_391_1.hightColor2.r, (arg_391_1.time_ - 0) / var_394_6), Mathf.Lerp(iter_394_6.color.g, arg_391_1.hightColor2.g, (arg_391_1.time_ - 0) / var_394_6), (Mathf.Lerp(iter_394_6.color.b, arg_391_1.hightColor2.b, (arg_391_1.time_ - 0) / var_394_6)))
							else
								local var_394_7 = Mathf.Lerp(iter_394_6.color.r, 0.5, (arg_391_1.time_ - 0) / var_394_6)

								iter_394_6.color = Color.New(var_394_7, var_394_7, var_394_7)
							end
						end
					end
				end
			end

			if arg_391_1.time_ >= 0 + var_394_6 and arg_391_1.time_ < 0 + var_394_6 + arg_394_0 and not isNil(var_394_5) and arg_391_1.var_.actorSpriteComps10097 then
				for iter_394_7, iter_394_8 in pairs(arg_391_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_394_8 then
						iter_394_8.color = arg_391_1.isInRecall_ and (arg_391_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_391_1.var_.actorSpriteComps10097 = nil
			end

			local var_394_8 = arg_391_1.actors_["10097"].transform

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.var_.moveOldPos10097 = var_394_8.localPosition
				var_394_8.localScale = Vector3.New(1, 1, 1)

				arg_391_1:CheckSpriteTmpPos("10097", 7)

				for iter_394_9 = 0, var_394_8.childCount - 1 do
					local var_394_9 = var_394_8:GetChild(iter_394_9)

					if var_394_9.name == "split_3" or not string.find(var_394_9.name, "split") then
						var_394_9.gameObject:SetActive(true)
					else
						var_394_9.gameObject:SetActive(false)
					end
				end
			end

			local var_394_10 = 0.001

			if 0 <= arg_391_1.time_ and arg_391_1.time_ < 0 + var_394_10 then
				var_394_8.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos10097, Vector3.New(0, -2000, -180), (arg_391_1.time_ - 0) / var_394_10)
			end

			if arg_391_1.time_ >= 0 + var_394_10 and arg_391_1.time_ < 0 + var_394_10 + arg_394_0 then
				var_394_8.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_394_11 = 0
			local var_394_12 = 1.575

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= var_394_11 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_13 = arg_391_1:FormatText(arg_391_1:GetWordFromCfg(413091093).content)

				arg_391_1.text_.text = var_394_13

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_15 = 63 <= 0 and var_394_12 or var_394_12 * (utf8.len(var_394_13) / 63)

				if (63 <= 0 and var_394_12 or var_394_12 * (utf8.len(var_394_13) / 63)) > 0 and var_394_12 < var_394_15 then
					arg_391_1.talkMaxDuration = var_394_15

					if var_394_15 + var_394_11 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_15 + var_394_11
					end
				end

				arg_391_1.text_.text = var_394_13
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_16 = math.max(var_394_12, arg_391_1.talkMaxDuration)

			if var_394_11 <= arg_391_1.time_ and arg_391_1.time_ < var_394_11 + var_394_16 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_11) / var_394_16

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_11 + var_394_16 and arg_391_1.time_ < var_394_11 + var_394_16 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
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
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play413091094 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 413091094
		arg_395_1.duration_ = 5.23

		local var_395_0 = {
			zh = 3.8,
			ja = 5.233
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
				arg_395_0:Play413091095(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.var_.moveOldPos10093 = arg_395_1.actors_["10093"].transform.localPosition
				arg_395_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_395_1:CheckSpriteTmpPos("10093", 2)

				for iter_398_0 = 0, arg_395_1.actors_["10093"].transform.childCount - 1 do
					local var_398_0 = arg_395_1.actors_["10093"].transform:GetChild(iter_398_0)

					if var_398_0.name == "split_4" or not string.find(var_398_0.name, "split") then
						var_398_0.gameObject:SetActive(true)
					else
						var_398_0.gameObject:SetActive(false)
					end
				end
			end

			local var_398_1 = 0.001

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_1 then
				arg_395_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_395_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_395_1.time_ - 0) / var_398_1)
			end

			if arg_395_1.time_ >= 0 + var_398_1 and arg_395_1.time_ < 0 + var_398_1 + arg_398_0 then
				arg_395_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_398_2 = arg_395_1.actors_["10093"]

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 and not isNil(var_398_2) and arg_395_1.var_.actorSpriteComps10093 == nil then
				arg_395_1.var_.actorSpriteComps10093 = var_398_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_398_3 = 2

			if 0 <= arg_395_1.time_ and arg_395_1.time_ < 0 + var_398_3 and not isNil(var_398_2) then
				if arg_395_1.var_.actorSpriteComps10093 then
					for iter_398_1, iter_398_2 in pairs(arg_395_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_398_2 then
							if arg_395_1.isInRecall_ then
								iter_398_2.color = Color.New(Mathf.Lerp(iter_398_2.color.r, arg_395_1.hightColor1.r, (arg_395_1.time_ - 0) / var_398_3), Mathf.Lerp(iter_398_2.color.g, arg_395_1.hightColor1.g, (arg_395_1.time_ - 0) / var_398_3), (Mathf.Lerp(iter_398_2.color.b, arg_395_1.hightColor1.b, (arg_395_1.time_ - 0) / var_398_3)))
							else
								local var_398_4 = Mathf.Lerp(iter_398_2.color.r, 1, (arg_395_1.time_ - 0) / var_398_3)

								iter_398_2.color = Color.New(var_398_4, var_398_4, var_398_4)
							end
						end
					end
				end
			end

			if arg_395_1.time_ >= 0 + var_398_3 and arg_395_1.time_ < 0 + var_398_3 + arg_398_0 and not isNil(var_398_2) and arg_395_1.var_.actorSpriteComps10093 then
				for iter_398_3, iter_398_4 in pairs(arg_395_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_398_4 then
						iter_398_4.color = arg_395_1.isInRecall_ and (arg_395_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_395_1.var_.actorSpriteComps10093 = nil
			end

			local var_398_5 = 0
			local var_398_6 = 0.45

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= var_398_5 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_7 = arg_395_1:GetWordFromCfg(413091094)
				local var_398_8 = arg_395_1:FormatText(var_398_7.content)

				arg_395_1.text_.text = var_398_8

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_10 = 18 <= 0 and var_398_6 or var_398_6 * (utf8.len(var_398_8) / 18)

				if (18 <= 0 and var_398_6 or var_398_6 * (utf8.len(var_398_8) / 18)) > 0 and var_398_6 < var_398_10 then
					arg_395_1.talkMaxDuration = var_398_10

					if var_398_10 + var_398_5 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_10 + var_398_5
					end
				end

				arg_395_1.text_.text = var_398_8
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091094", "story_v_out_413091.awb") ~= 0 then
					local var_398_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091094", "story_v_out_413091.awb") / 1000

					if var_398_11 + var_398_5 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_11 + var_398_5
					end

					if var_398_7.prefab_name ~= "" and arg_395_1.actors_[var_398_7.prefab_name] ~= nil then
						local var_398_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_7.prefab_name].transform, "story_v_out_413091", "413091094", "story_v_out_413091.awb")

						arg_395_1:RecordAudio("413091094", var_398_12)
						arg_395_1:RecordAudio("413091094", var_398_12)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_413091", "413091094", "story_v_out_413091.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_413091", "413091094", "story_v_out_413091.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_13 = math.max(var_398_6, arg_395_1.talkMaxDuration)

			if var_398_5 <= arg_395_1.time_ and arg_395_1.time_ < var_398_5 + var_398_13 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_5) / var_398_13

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_5 + var_398_13 and arg_395_1.time_ < var_398_5 + var_398_13 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end

		arg_395_1.nodeConfigList_ = {
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

		arg_395_1:InitPlayNodeList()
	end,
	Play413091095 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 413091095
		arg_399_1.duration_ = 2.47

		local var_399_0 = {
			zh = 2.466,
			ja = 2.1
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
				arg_399_0:Play413091096(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 then
				arg_399_1.var_.moveOldPos10097 = arg_399_1.actors_["10097"].transform.localPosition
				arg_399_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_399_1:CheckSpriteTmpPos("10097", 4)

				for iter_402_0 = 0, arg_399_1.actors_["10097"].transform.childCount - 1 do
					local var_402_0 = arg_399_1.actors_["10097"].transform:GetChild(iter_402_0)

					if var_402_0.name == "split_3" or not string.find(var_402_0.name, "split") then
						var_402_0.gameObject:SetActive(true)
					else
						var_402_0.gameObject:SetActive(false)
					end
				end
			end

			local var_402_1 = 0.001

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_1 then
				arg_399_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_399_1.time_ - 0) / var_402_1)
			end

			if arg_399_1.time_ >= 0 + var_402_1 and arg_399_1.time_ < 0 + var_402_1 + arg_402_0 then
				arg_399_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_402_2 = arg_399_1.actors_["10097"]

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(var_402_2) and arg_399_1.var_.actorSpriteComps10097 == nil then
				arg_399_1.var_.actorSpriteComps10097 = var_402_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_3 = 2

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_3 and not isNil(var_402_2) then
				if arg_399_1.var_.actorSpriteComps10097 then
					for iter_402_1, iter_402_2 in pairs(arg_399_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_402_2 then
							if arg_399_1.isInRecall_ then
								iter_402_2.color = Color.New(Mathf.Lerp(iter_402_2.color.r, arg_399_1.hightColor1.r, (arg_399_1.time_ - 0) / var_402_3), Mathf.Lerp(iter_402_2.color.g, arg_399_1.hightColor1.g, (arg_399_1.time_ - 0) / var_402_3), (Mathf.Lerp(iter_402_2.color.b, arg_399_1.hightColor1.b, (arg_399_1.time_ - 0) / var_402_3)))
							else
								local var_402_4 = Mathf.Lerp(iter_402_2.color.r, 1, (arg_399_1.time_ - 0) / var_402_3)

								iter_402_2.color = Color.New(var_402_4, var_402_4, var_402_4)
							end
						end
					end
				end
			end

			if arg_399_1.time_ >= 0 + var_402_3 and arg_399_1.time_ < 0 + var_402_3 + arg_402_0 and not isNil(var_402_2) and arg_399_1.var_.actorSpriteComps10097 then
				for iter_402_3, iter_402_4 in pairs(arg_399_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_402_4 then
						iter_402_4.color = arg_399_1.isInRecall_ and (arg_399_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_399_1.var_.actorSpriteComps10097 = nil
			end

			local var_402_5 = arg_399_1.actors_["10093"]

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(var_402_5) and arg_399_1.var_.actorSpriteComps10093 == nil then
				arg_399_1.var_.actorSpriteComps10093 = var_402_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_6 = 0.2

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_6 and not isNil(var_402_5) then
				if arg_399_1.var_.actorSpriteComps10093 then
					for iter_402_5, iter_402_6 in pairs(arg_399_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_402_6 then
							if arg_399_1.isInRecall_ then
								iter_402_6.color = Color.New(Mathf.Lerp(iter_402_6.color.r, arg_399_1.hightColor2.r, (arg_399_1.time_ - 0) / var_402_6), Mathf.Lerp(iter_402_6.color.g, arg_399_1.hightColor2.g, (arg_399_1.time_ - 0) / var_402_6), (Mathf.Lerp(iter_402_6.color.b, arg_399_1.hightColor2.b, (arg_399_1.time_ - 0) / var_402_6)))
							else
								local var_402_7 = Mathf.Lerp(iter_402_6.color.r, 0.5, (arg_399_1.time_ - 0) / var_402_6)

								iter_402_6.color = Color.New(var_402_7, var_402_7, var_402_7)
							end
						end
					end
				end
			end

			if arg_399_1.time_ >= 0 + var_402_6 and arg_399_1.time_ < 0 + var_402_6 + arg_402_0 and not isNil(var_402_5) and arg_399_1.var_.actorSpriteComps10093 then
				for iter_402_7, iter_402_8 in pairs(arg_399_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_402_8 then
						iter_402_8.color = arg_399_1.isInRecall_ and (arg_399_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_399_1.var_.actorSpriteComps10093 = nil
			end

			local var_402_8 = 0
			local var_402_9 = 0.225

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_8 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_10 = arg_399_1:GetWordFromCfg(413091095)
				local var_402_11 = arg_399_1:FormatText(var_402_10.content)

				arg_399_1.text_.text = var_402_11

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_13 = 9 <= 0 and var_402_9 or var_402_9 * (utf8.len(var_402_11) / 9)

				if (9 <= 0 and var_402_9 or var_402_9 * (utf8.len(var_402_11) / 9)) > 0 and var_402_9 < var_402_13 then
					arg_399_1.talkMaxDuration = var_402_13

					if var_402_13 + var_402_8 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_13 + var_402_8
					end
				end

				arg_399_1.text_.text = var_402_11
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091095", "story_v_out_413091.awb") ~= 0 then
					local var_402_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091095", "story_v_out_413091.awb") / 1000

					if var_402_14 + var_402_8 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_14 + var_402_8
					end

					if var_402_10.prefab_name ~= "" and arg_399_1.actors_[var_402_10.prefab_name] ~= nil then
						local var_402_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_10.prefab_name].transform, "story_v_out_413091", "413091095", "story_v_out_413091.awb")

						arg_399_1:RecordAudio("413091095", var_402_15)
						arg_399_1:RecordAudio("413091095", var_402_15)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_413091", "413091095", "story_v_out_413091.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_413091", "413091095", "story_v_out_413091.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_16 = math.max(var_402_9, arg_399_1.talkMaxDuration)

			if var_402_8 <= arg_399_1.time_ and arg_399_1.time_ < var_402_8 + var_402_16 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_8) / var_402_16

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_8 + var_402_16 and arg_399_1.time_ < var_402_8 + var_402_16 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
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

		arg_399_1:InitPlayNodeList()
	end,
	Play413091096 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 413091096
		arg_403_1.duration_ = 7.93

		local var_403_0 = {
			zh = 2.233,
			ja = 7.933
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
				arg_403_0:Play413091097(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos10093 = arg_403_1.actors_["10093"].transform.localPosition
				arg_403_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_403_1:CheckSpriteTmpPos("10093", 2)

				for iter_406_0 = 0, arg_403_1.actors_["10093"].transform.childCount - 1 do
					local var_406_0 = arg_403_1.actors_["10093"].transform:GetChild(iter_406_0)

					if var_406_0.name == "split_7" or not string.find(var_406_0.name, "split") then
						var_406_0.gameObject:SetActive(true)
					else
						var_406_0.gameObject:SetActive(false)
					end
				end
			end

			local var_406_1 = 0.001

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_1 then
				arg_403_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_403_1.time_ - 0) / var_406_1)
			end

			if arg_403_1.time_ >= 0 + var_406_1 and arg_403_1.time_ < 0 + var_406_1 + arg_406_0 then
				arg_403_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_406_2 = arg_403_1.actors_["10093"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_2) and arg_403_1.var_.actorSpriteComps10093 == nil then
				arg_403_1.var_.actorSpriteComps10093 = var_406_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_3 = 2

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_3 and not isNil(var_406_2) then
				if arg_403_1.var_.actorSpriteComps10093 then
					for iter_406_1, iter_406_2 in pairs(arg_403_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_406_2 then
							if arg_403_1.isInRecall_ then
								iter_406_2.color = Color.New(Mathf.Lerp(iter_406_2.color.r, arg_403_1.hightColor1.r, (arg_403_1.time_ - 0) / var_406_3), Mathf.Lerp(iter_406_2.color.g, arg_403_1.hightColor1.g, (arg_403_1.time_ - 0) / var_406_3), (Mathf.Lerp(iter_406_2.color.b, arg_403_1.hightColor1.b, (arg_403_1.time_ - 0) / var_406_3)))
							else
								local var_406_4 = Mathf.Lerp(iter_406_2.color.r, 1, (arg_403_1.time_ - 0) / var_406_3)

								iter_406_2.color = Color.New(var_406_4, var_406_4, var_406_4)
							end
						end
					end
				end
			end

			if arg_403_1.time_ >= 0 + var_406_3 and arg_403_1.time_ < 0 + var_406_3 + arg_406_0 and not isNil(var_406_2) and arg_403_1.var_.actorSpriteComps10093 then
				for iter_406_3, iter_406_4 in pairs(arg_403_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_406_4 then
						iter_406_4.color = arg_403_1.isInRecall_ and (arg_403_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_403_1.var_.actorSpriteComps10093 = nil
			end

			local var_406_5 = arg_403_1.actors_["10097"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_5) and arg_403_1.var_.actorSpriteComps10097 == nil then
				arg_403_1.var_.actorSpriteComps10097 = var_406_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_6 = 0.2

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_6 and not isNil(var_406_5) then
				if arg_403_1.var_.actorSpriteComps10097 then
					for iter_406_5, iter_406_6 in pairs(arg_403_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_406_6 then
							if arg_403_1.isInRecall_ then
								iter_406_6.color = Color.New(Mathf.Lerp(iter_406_6.color.r, arg_403_1.hightColor2.r, (arg_403_1.time_ - 0) / var_406_6), Mathf.Lerp(iter_406_6.color.g, arg_403_1.hightColor2.g, (arg_403_1.time_ - 0) / var_406_6), (Mathf.Lerp(iter_406_6.color.b, arg_403_1.hightColor2.b, (arg_403_1.time_ - 0) / var_406_6)))
							else
								local var_406_7 = Mathf.Lerp(iter_406_6.color.r, 0.5, (arg_403_1.time_ - 0) / var_406_6)

								iter_406_6.color = Color.New(var_406_7, var_406_7, var_406_7)
							end
						end
					end
				end
			end

			if arg_403_1.time_ >= 0 + var_406_6 and arg_403_1.time_ < 0 + var_406_6 + arg_406_0 and not isNil(var_406_5) and arg_403_1.var_.actorSpriteComps10097 then
				for iter_406_7, iter_406_8 in pairs(arg_403_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_406_8 then
						iter_406_8.color = arg_403_1.isInRecall_ and (arg_403_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_403_1.var_.actorSpriteComps10097 = nil
			end

			local var_406_8 = 0
			local var_406_9 = 0.4

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_8 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_10 = arg_403_1:GetWordFromCfg(413091096)
				local var_406_11 = arg_403_1:FormatText(var_406_10.content)

				arg_403_1.text_.text = var_406_11

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_13 = 16 <= 0 and var_406_9 or var_406_9 * (utf8.len(var_406_11) / 16)

				if (16 <= 0 and var_406_9 or var_406_9 * (utf8.len(var_406_11) / 16)) > 0 and var_406_9 < var_406_13 then
					arg_403_1.talkMaxDuration = var_406_13

					if var_406_13 + var_406_8 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_13 + var_406_8
					end
				end

				arg_403_1.text_.text = var_406_11
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091096", "story_v_out_413091.awb") ~= 0 then
					local var_406_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091096", "story_v_out_413091.awb") / 1000

					if var_406_14 + var_406_8 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_14 + var_406_8
					end

					if var_406_10.prefab_name ~= "" and arg_403_1.actors_[var_406_10.prefab_name] ~= nil then
						local var_406_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_10.prefab_name].transform, "story_v_out_413091", "413091096", "story_v_out_413091.awb")

						arg_403_1:RecordAudio("413091096", var_406_15)
						arg_403_1:RecordAudio("413091096", var_406_15)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_413091", "413091096", "story_v_out_413091.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_413091", "413091096", "story_v_out_413091.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_16 = math.max(var_406_9, arg_403_1.talkMaxDuration)

			if var_406_8 <= arg_403_1.time_ and arg_403_1.time_ < var_406_8 + var_406_16 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_8) / var_406_16

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_8 + var_406_16 and arg_403_1.time_ < var_406_8 + var_406_16 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {
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

		arg_403_1:InitPlayNodeList()
	end,
	Play413091097 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 413091097
		arg_407_1.duration_ = 5.5

		local var_407_0 = {
			zh = 5.5,
			ja = 1.999999999999
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
				arg_407_0:Play413091098(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos10097 = arg_407_1.actors_["10097"].transform.localPosition
				arg_407_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_407_1:CheckSpriteTmpPos("10097", 4)

				for iter_410_0 = 0, arg_407_1.actors_["10097"].transform.childCount - 1 do
					local var_410_0 = arg_407_1.actors_["10097"].transform:GetChild(iter_410_0)

					if var_410_0.name == "split_4" or not string.find(var_410_0.name, "split") then
						var_410_0.gameObject:SetActive(true)
					else
						var_410_0.gameObject:SetActive(false)
					end
				end
			end

			local var_410_1 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_1 then
				arg_407_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_407_1.time_ - 0) / var_410_1)
			end

			if arg_407_1.time_ >= 0 + var_410_1 and arg_407_1.time_ < 0 + var_410_1 + arg_410_0 then
				arg_407_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_410_2 = arg_407_1.actors_["10097"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_2) and arg_407_1.var_.actorSpriteComps10097 == nil then
				arg_407_1.var_.actorSpriteComps10097 = var_410_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_410_3 = 2

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_3 and not isNil(var_410_2) then
				if arg_407_1.var_.actorSpriteComps10097 then
					for iter_410_1, iter_410_2 in pairs(arg_407_1.var_.actorSpriteComps10097:ToTable()) do
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

			if arg_407_1.time_ >= 0 + var_410_3 and arg_407_1.time_ < 0 + var_410_3 + arg_410_0 and not isNil(var_410_2) and arg_407_1.var_.actorSpriteComps10097 then
				for iter_410_3, iter_410_4 in pairs(arg_407_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_410_4 then
						iter_410_4.color = arg_407_1.isInRecall_ and (arg_407_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_407_1.var_.actorSpriteComps10097 = nil
			end

			local var_410_5 = arg_407_1.actors_["10093"]

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(var_410_5) and arg_407_1.var_.actorSpriteComps10093 == nil then
				arg_407_1.var_.actorSpriteComps10093 = var_410_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_410_6 = 0.2

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_6 and not isNil(var_410_5) then
				if arg_407_1.var_.actorSpriteComps10093 then
					for iter_410_5, iter_410_6 in pairs(arg_407_1.var_.actorSpriteComps10093:ToTable()) do
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

			if arg_407_1.time_ >= 0 + var_410_6 and arg_407_1.time_ < 0 + var_410_6 + arg_410_0 and not isNil(var_410_5) and arg_407_1.var_.actorSpriteComps10093 then
				for iter_410_7, iter_410_8 in pairs(arg_407_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_410_8 then
						iter_410_8.color = arg_407_1.isInRecall_ and (arg_407_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_407_1.var_.actorSpriteComps10093 = nil
			end

			local var_410_8 = 0
			local var_410_9 = 0.425

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_8 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_10 = arg_407_1:GetWordFromCfg(413091097)
				local var_410_11 = arg_407_1:FormatText(var_410_10.content)

				arg_407_1.text_.text = var_410_11

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_13 = 17 <= 0 and var_410_9 or var_410_9 * (utf8.len(var_410_11) / 17)

				if (17 <= 0 and var_410_9 or var_410_9 * (utf8.len(var_410_11) / 17)) > 0 and var_410_9 < var_410_13 then
					arg_407_1.talkMaxDuration = var_410_13

					if var_410_13 + var_410_8 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_13 + var_410_8
					end
				end

				arg_407_1.text_.text = var_410_11
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091097", "story_v_out_413091.awb") ~= 0 then
					local var_410_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091097", "story_v_out_413091.awb") / 1000

					if var_410_14 + var_410_8 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_14 + var_410_8
					end

					if var_410_10.prefab_name ~= "" and arg_407_1.actors_[var_410_10.prefab_name] ~= nil then
						local var_410_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_10.prefab_name].transform, "story_v_out_413091", "413091097", "story_v_out_413091.awb")

						arg_407_1:RecordAudio("413091097", var_410_15)
						arg_407_1:RecordAudio("413091097", var_410_15)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_413091", "413091097", "story_v_out_413091.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_413091", "413091097", "story_v_out_413091.awb")
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
				actorName = "10097",
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
	Play413091098 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 413091098
		arg_411_1.duration_ = 8.93

		local var_411_0 = {
			zh = 5.966,
			ja = 8.933
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
				arg_411_0:Play413091099(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos10093 = arg_411_1.actors_["10093"].transform.localPosition
				arg_411_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_411_1:CheckSpriteTmpPos("10093", 2)

				for iter_414_0 = 0, arg_411_1.actors_["10093"].transform.childCount - 1 do
					local var_414_0 = arg_411_1.actors_["10093"].transform:GetChild(iter_414_0)

					if var_414_0.name == "split_7" or not string.find(var_414_0.name, "split") then
						var_414_0.gameObject:SetActive(true)
					else
						var_414_0.gameObject:SetActive(false)
					end
				end
			end

			local var_414_1 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_1 then
				arg_411_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_411_1.time_ - 0) / var_414_1)
			end

			if arg_411_1.time_ >= 0 + var_414_1 and arg_411_1.time_ < 0 + var_414_1 + arg_414_0 then
				arg_411_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_414_2 = arg_411_1.actors_["10093"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_2) and arg_411_1.var_.actorSpriteComps10093 == nil then
				arg_411_1.var_.actorSpriteComps10093 = var_414_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_3 = 2

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_3 and not isNil(var_414_2) then
				if arg_411_1.var_.actorSpriteComps10093 then
					for iter_414_1, iter_414_2 in pairs(arg_411_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_414_2 then
							if arg_411_1.isInRecall_ then
								iter_414_2.color = Color.New(Mathf.Lerp(iter_414_2.color.r, arg_411_1.hightColor1.r, (arg_411_1.time_ - 0) / var_414_3), Mathf.Lerp(iter_414_2.color.g, arg_411_1.hightColor1.g, (arg_411_1.time_ - 0) / var_414_3), (Mathf.Lerp(iter_414_2.color.b, arg_411_1.hightColor1.b, (arg_411_1.time_ - 0) / var_414_3)))
							else
								local var_414_4 = Mathf.Lerp(iter_414_2.color.r, 1, (arg_411_1.time_ - 0) / var_414_3)

								iter_414_2.color = Color.New(var_414_4, var_414_4, var_414_4)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= 0 + var_414_3 and arg_411_1.time_ < 0 + var_414_3 + arg_414_0 and not isNil(var_414_2) and arg_411_1.var_.actorSpriteComps10093 then
				for iter_414_3, iter_414_4 in pairs(arg_411_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_414_4 then
						iter_414_4.color = arg_411_1.isInRecall_ and (arg_411_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_411_1.var_.actorSpriteComps10093 = nil
			end

			local var_414_5 = arg_411_1.actors_["10097"]

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(var_414_5) and arg_411_1.var_.actorSpriteComps10097 == nil then
				arg_411_1.var_.actorSpriteComps10097 = var_414_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_6 = 0.2

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_6 and not isNil(var_414_5) then
				if arg_411_1.var_.actorSpriteComps10097 then
					for iter_414_5, iter_414_6 in pairs(arg_411_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_414_6 then
							if arg_411_1.isInRecall_ then
								iter_414_6.color = Color.New(Mathf.Lerp(iter_414_6.color.r, arg_411_1.hightColor2.r, (arg_411_1.time_ - 0) / var_414_6), Mathf.Lerp(iter_414_6.color.g, arg_411_1.hightColor2.g, (arg_411_1.time_ - 0) / var_414_6), (Mathf.Lerp(iter_414_6.color.b, arg_411_1.hightColor2.b, (arg_411_1.time_ - 0) / var_414_6)))
							else
								local var_414_7 = Mathf.Lerp(iter_414_6.color.r, 0.5, (arg_411_1.time_ - 0) / var_414_6)

								iter_414_6.color = Color.New(var_414_7, var_414_7, var_414_7)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= 0 + var_414_6 and arg_411_1.time_ < 0 + var_414_6 + arg_414_0 and not isNil(var_414_5) and arg_411_1.var_.actorSpriteComps10097 then
				for iter_414_7, iter_414_8 in pairs(arg_411_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_414_8 then
						iter_414_8.color = arg_411_1.isInRecall_ and (arg_411_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_411_1.var_.actorSpriteComps10097 = nil
			end

			local var_414_8 = 0
			local var_414_9 = 0.725

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_8 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_10 = arg_411_1:GetWordFromCfg(413091098)
				local var_414_11 = arg_411_1:FormatText(var_414_10.content)

				arg_411_1.text_.text = var_414_11

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_13 = 29 <= 0 and var_414_9 or var_414_9 * (utf8.len(var_414_11) / 29)

				if (29 <= 0 and var_414_9 or var_414_9 * (utf8.len(var_414_11) / 29)) > 0 and var_414_9 < var_414_13 then
					arg_411_1.talkMaxDuration = var_414_13

					if var_414_13 + var_414_8 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_13 + var_414_8
					end
				end

				arg_411_1.text_.text = var_414_11
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091098", "story_v_out_413091.awb") ~= 0 then
					local var_414_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091098", "story_v_out_413091.awb") / 1000

					if var_414_14 + var_414_8 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_14 + var_414_8
					end

					if var_414_10.prefab_name ~= "" and arg_411_1.actors_[var_414_10.prefab_name] ~= nil then
						local var_414_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_10.prefab_name].transform, "story_v_out_413091", "413091098", "story_v_out_413091.awb")

						arg_411_1:RecordAudio("413091098", var_414_15)
						arg_411_1:RecordAudio("413091098", var_414_15)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_413091", "413091098", "story_v_out_413091.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_413091", "413091098", "story_v_out_413091.awb")
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
				actorName = "10093",
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
	Play413091099 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 413091099
		arg_415_1.duration_ = 9

		local var_415_0 = {
			zh = 5.9,
			ja = 9
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
				arg_415_0:Play413091100(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0.8

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_1 = arg_415_1:GetWordFromCfg(413091099)
				local var_418_2 = arg_415_1:FormatText(var_418_1.content)

				arg_415_1.text_.text = var_418_2

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_4 = 32 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_2) / 32)

				if (32 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_2) / 32)) > 0 and var_418_0 < var_418_4 then
					arg_415_1.talkMaxDuration = var_418_4

					if var_418_4 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_4 + 0
					end
				end

				arg_415_1.text_.text = var_418_2
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091099", "story_v_out_413091.awb") ~= 0 then
					local var_418_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091099", "story_v_out_413091.awb") / 1000

					if var_418_5 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_5 + 0
					end

					if var_418_1.prefab_name ~= "" and arg_415_1.actors_[var_418_1.prefab_name] ~= nil then
						local var_418_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_1.prefab_name].transform, "story_v_out_413091", "413091099", "story_v_out_413091.awb")

						arg_415_1:RecordAudio("413091099", var_418_6)
						arg_415_1:RecordAudio("413091099", var_418_6)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_413091", "413091099", "story_v_out_413091.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_413091", "413091099", "story_v_out_413091.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_7 = math.max(var_418_0, arg_415_1.talkMaxDuration)

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_7 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - 0) / var_418_7

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= 0 + var_418_7 and arg_415_1.time_ < 0 + var_418_7 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play413091100 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 413091100
		arg_419_1.duration_ = 6.4

		local var_419_0 = {
			zh = 6,
			ja = 6.4
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
				arg_419_0:Play413091101(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0.75

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_1 = arg_419_1:GetWordFromCfg(413091100)
				local var_422_2 = arg_419_1:FormatText(var_422_1.content)

				arg_419_1.text_.text = var_422_2

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_4 = 30 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 30)

				if (30 <= 0 and var_422_0 or var_422_0 * (utf8.len(var_422_2) / 30)) > 0 and var_422_0 < var_422_4 then
					arg_419_1.talkMaxDuration = var_422_4

					if var_422_4 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_4 + 0
					end
				end

				arg_419_1.text_.text = var_422_2
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091100", "story_v_out_413091.awb") ~= 0 then
					local var_422_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091100", "story_v_out_413091.awb") / 1000

					if var_422_5 + 0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_5 + 0
					end

					if var_422_1.prefab_name ~= "" and arg_419_1.actors_[var_422_1.prefab_name] ~= nil then
						local var_422_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_1.prefab_name].transform, "story_v_out_413091", "413091100", "story_v_out_413091.awb")

						arg_419_1:RecordAudio("413091100", var_422_6)
						arg_419_1:RecordAudio("413091100", var_422_6)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_413091", "413091100", "story_v_out_413091.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_413091", "413091100", "story_v_out_413091.awb")
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
	Play413091101 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 413091101
		arg_423_1.duration_ = 11.5

		local var_423_0 = {
			zh = 11.5,
			ja = 9.966
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
				arg_423_0:Play413091102(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.var_.moveOldPos10093 = arg_423_1.actors_["10093"].transform.localPosition
				arg_423_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_423_1:CheckSpriteTmpPos("10093", 2)

				for iter_426_0 = 0, arg_423_1.actors_["10093"].transform.childCount - 1 do
					local var_426_0 = arg_423_1.actors_["10093"].transform:GetChild(iter_426_0)

					if var_426_0.name == "split_4" or not string.find(var_426_0.name, "split") then
						var_426_0.gameObject:SetActive(true)
					else
						var_426_0.gameObject:SetActive(false)
					end
				end
			end

			local var_426_1 = 0.001

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_1 then
				arg_423_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_423_1.time_ - 0) / var_426_1)
			end

			if arg_423_1.time_ >= 0 + var_426_1 and arg_423_1.time_ < 0 + var_426_1 + arg_426_0 then
				arg_423_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_426_2 = 0
			local var_426_3 = 1.55

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_2 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_4 = arg_423_1:GetWordFromCfg(413091101)
				local var_426_5 = arg_423_1:FormatText(var_426_4.content)

				arg_423_1.text_.text = var_426_5

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_7 = 62 <= 0 and var_426_3 or var_426_3 * (utf8.len(var_426_5) / 62)

				if (62 <= 0 and var_426_3 or var_426_3 * (utf8.len(var_426_5) / 62)) > 0 and var_426_3 < var_426_7 then
					arg_423_1.talkMaxDuration = var_426_7

					if var_426_7 + var_426_2 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_7 + var_426_2
					end
				end

				arg_423_1.text_.text = var_426_5
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091101", "story_v_out_413091.awb") ~= 0 then
					local var_426_8 = manager.audio:GetVoiceLength("story_v_out_413091", "413091101", "story_v_out_413091.awb") / 1000

					if var_426_8 + var_426_2 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_8 + var_426_2
					end

					if var_426_4.prefab_name ~= "" and arg_423_1.actors_[var_426_4.prefab_name] ~= nil then
						local var_426_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_4.prefab_name].transform, "story_v_out_413091", "413091101", "story_v_out_413091.awb")

						arg_423_1:RecordAudio("413091101", var_426_9)
						arg_423_1:RecordAudio("413091101", var_426_9)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_413091", "413091101", "story_v_out_413091.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_413091", "413091101", "story_v_out_413091.awb")
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

		arg_423_1.nodeConfigList_ = {
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

		arg_423_1:InitPlayNodeList()
	end,
	Play413091102 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 413091102
		arg_427_1.duration_ = 9

		local var_427_0 = {
			zh = 5.633,
			ja = 9
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play413091103(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 then
				arg_427_1.var_.moveOldPos10093 = arg_427_1.actors_["10093"].transform.localPosition
				arg_427_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_427_1:CheckSpriteTmpPos("10093", 2)

				for iter_430_0 = 0, arg_427_1.actors_["10093"].transform.childCount - 1 do
					local var_430_0 = arg_427_1.actors_["10093"].transform:GetChild(iter_430_0)

					if var_430_0.name == "split_7" or not string.find(var_430_0.name, "split") then
						var_430_0.gameObject:SetActive(true)
					else
						var_430_0.gameObject:SetActive(false)
					end
				end
			end

			local var_430_1 = 0.001

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_1 then
				arg_427_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_427_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_427_1.time_ - 0) / var_430_1)
			end

			if arg_427_1.time_ >= 0 + var_430_1 and arg_427_1.time_ < 0 + var_430_1 + arg_430_0 then
				arg_427_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_430_2 = 0
			local var_430_3 = 0.525

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_2 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_4 = arg_427_1:GetWordFromCfg(413091102)
				local var_430_5 = arg_427_1:FormatText(var_430_4.content)

				arg_427_1.text_.text = var_430_5

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_7 = 21 <= 0 and var_430_3 or var_430_3 * (utf8.len(var_430_5) / 21)

				if (21 <= 0 and var_430_3 or var_430_3 * (utf8.len(var_430_5) / 21)) > 0 and var_430_3 < var_430_7 then
					arg_427_1.talkMaxDuration = var_430_7

					if var_430_7 + var_430_2 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_7 + var_430_2
					end
				end

				arg_427_1.text_.text = var_430_5
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091102", "story_v_out_413091.awb") ~= 0 then
					local var_430_8 = manager.audio:GetVoiceLength("story_v_out_413091", "413091102", "story_v_out_413091.awb") / 1000

					if var_430_8 + var_430_2 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_8 + var_430_2
					end

					if var_430_4.prefab_name ~= "" and arg_427_1.actors_[var_430_4.prefab_name] ~= nil then
						local var_430_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_4.prefab_name].transform, "story_v_out_413091", "413091102", "story_v_out_413091.awb")

						arg_427_1:RecordAudio("413091102", var_430_9)
						arg_427_1:RecordAudio("413091102", var_430_9)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_413091", "413091102", "story_v_out_413091.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_413091", "413091102", "story_v_out_413091.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_10 = math.max(var_430_3, arg_427_1.talkMaxDuration)

			if var_430_2 <= arg_427_1.time_ and arg_427_1.time_ < var_430_2 + var_430_10 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_2) / var_430_10

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_2 + var_430_10 and arg_427_1.time_ < var_430_2 + var_430_10 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {
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

		arg_427_1:InitPlayNodeList()
	end,
	Play413091103 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 413091103
		arg_431_1.duration_ = 7.2

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play413091104(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			if 0 < arg_431_1.time_ and arg_431_1.time_ <= 0 + arg_434_0 then
				arg_431_1.mask_.enabled = true
				arg_431_1.mask_.raycastTarget = true

				arg_431_1:SetGaussion(false)
			end

			local var_434_0 = 1

			if 0 <= arg_431_1.time_ and arg_431_1.time_ < 0 + var_434_0 then
				local var_434_1 = Color.New(1, 1, 1)

				var_434_1.a = Mathf.Lerp(0, 1, (arg_431_1.time_ - 0) / var_434_0)
				arg_431_1.mask_.color = var_434_1
			end

			if arg_431_1.time_ >= 0 + var_434_0 and arg_431_1.time_ < 0 + var_434_0 + arg_434_0 then
				local var_434_2 = Color.New(1, 1, 1)

				var_434_2.a = 1
				arg_431_1.mask_.color = var_434_2
			end

			local var_434_3 = 1

			if 1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_3 + arg_434_0 then
				arg_431_1.mask_.enabled = true
				arg_431_1.mask_.raycastTarget = true

				arg_431_1:SetGaussion(false)
			end

			local var_434_4 = 1

			if var_434_3 <= arg_431_1.time_ and arg_431_1.time_ < var_434_3 + var_434_4 then
				local var_434_5 = Color.New(1, 1, 1)

				var_434_5.a = Mathf.Lerp(1, 0, (arg_431_1.time_ - var_434_3) / var_434_4)
				arg_431_1.mask_.color = var_434_5
			end

			if arg_431_1.time_ >= var_434_3 + var_434_4 and arg_431_1.time_ < var_434_3 + var_434_4 + arg_434_0 then
				local var_434_6 = Color.New(1, 1, 1)

				arg_431_1.mask_.enabled = false
				var_434_6.a = 0
				arg_431_1.mask_.color = var_434_6
			end

			local var_434_7 = arg_431_1.actors_["10093"].transform

			if 1 < arg_431_1.time_ and arg_431_1.time_ <= 1 + arg_434_0 then
				arg_431_1.var_.moveOldPos10093 = var_434_7.localPosition
				var_434_7.localScale = Vector3.New(1, 1, 1)

				arg_431_1:CheckSpriteTmpPos("10093", 7)

				for iter_434_0 = 0, var_434_7.childCount - 1 do
					local var_434_8 = var_434_7:GetChild(iter_434_0)

					if var_434_8.name == "split_4" or not string.find(var_434_8.name, "split") then
						var_434_8.gameObject:SetActive(true)
					else
						var_434_8.gameObject:SetActive(false)
					end
				end
			end

			local var_434_9 = 0.001

			if 1 <= arg_431_1.time_ and arg_431_1.time_ < 1 + var_434_9 then
				var_434_7.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_431_1.time_ - 1) / var_434_9)
			end

			if arg_431_1.time_ >= 1 + var_434_9 and arg_431_1.time_ < 1 + var_434_9 + arg_434_0 then
				var_434_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_434_10 = arg_431_1.actors_["10097"].transform

			if 1 < arg_431_1.time_ and arg_431_1.time_ <= 1 + arg_434_0 then
				arg_431_1.var_.moveOldPos10097 = var_434_10.localPosition
				var_434_10.localScale = Vector3.New(1, 1, 1)

				arg_431_1:CheckSpriteTmpPos("10097", 7)

				for iter_434_1 = 0, var_434_10.childCount - 1 do
					local var_434_11 = var_434_10:GetChild(iter_434_1)

					if var_434_11.name == "split_3" or not string.find(var_434_11.name, "split") then
						var_434_11.gameObject:SetActive(true)
					else
						var_434_11.gameObject:SetActive(false)
					end
				end
			end

			local var_434_12 = 0.001

			if 1 <= arg_431_1.time_ and arg_431_1.time_ < 1 + var_434_12 then
				var_434_10.localPosition = Vector3.Lerp(arg_431_1.var_.moveOldPos10097, Vector3.New(0, -2000, -180), (arg_431_1.time_ - 1) / var_434_12)
			end

			if arg_431_1.time_ >= 1 + var_434_12 and arg_431_1.time_ < 1 + var_434_12 + arg_434_0 then
				var_434_10.localPosition = Vector3.New(0, -2000, -180)
			end

			if arg_431_1.frameCnt_ <= 1 then
				arg_431_1.dialog_:SetActive(false)
			end

			local var_434_13 = 2.2
			local var_434_14 = 1.175

			if 2.2 < arg_431_1.time_ and arg_431_1.time_ <= var_434_13 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0

				arg_431_1.dialog_:SetActive(true)

				arg_431_1.dialogCg_.alpha = 0

				local var_434_15 = LeanTween.value(arg_431_1.dialog_, 0, 1, 0.3)

				var_434_15:setOnUpdate(LuaHelper.FloatAction(function(arg_435_0)
					arg_431_1.dialogCg_.alpha = arg_435_0
				end))
				var_434_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_431_1.dialog_)
					var_434_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_431_1.duration_ = arg_431_1.duration_ + 0.3

				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_16 = arg_431_1:FormatText(arg_431_1:GetWordFromCfg(413091103).content)

				arg_431_1.text_.text = var_434_16

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_18 = 47 <= 0 and var_434_14 or var_434_14 * (utf8.len(var_434_16) / 47)

				if (47 <= 0 and var_434_14 or var_434_14 * (utf8.len(var_434_16) / 47)) > 0 and var_434_14 < var_434_18 then
					arg_431_1.talkMaxDuration = var_434_18
					var_434_13 = var_434_13 + 0.3

					if var_434_18 + var_434_13 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_18 + var_434_13
					end
				end

				arg_431_1.text_.text = var_434_16
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_19 = var_434_13 + 0.3
			local var_434_20 = math.max(var_434_14, arg_431_1.talkMaxDuration)

			if var_434_13 + 0.3 <= arg_431_1.time_ and arg_431_1.time_ < var_434_19 + var_434_20 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_19) / var_434_20

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_19 + var_434_20 and arg_431_1.time_ < var_434_19 + var_434_20 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_431_1:InitPlayNodeList()
	end,
	Play413091104 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 413091104
		arg_437_1.duration_ = 10.17

		local var_437_0 = {
			zh = 10.166,
			ja = 6.633
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play413091105(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPos10097 = arg_437_1.actors_["10097"].transform.localPosition
				arg_437_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_437_1:CheckSpriteTmpPos("10097", 3)

				for iter_440_0 = 0, arg_437_1.actors_["10097"].transform.childCount - 1 do
					local var_440_0 = arg_437_1.actors_["10097"].transform:GetChild(iter_440_0)

					if var_440_0.name == "split_2" or not string.find(var_440_0.name, "split") then
						var_440_0.gameObject:SetActive(true)
					else
						var_440_0.gameObject:SetActive(false)
					end
				end
			end

			local var_440_1 = 0.001

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_1 then
				arg_437_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_437_1.time_ - 0) / var_440_1)
			end

			if arg_437_1.time_ >= 0 + var_440_1 and arg_437_1.time_ < 0 + var_440_1 + arg_440_0 then
				arg_437_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_440_2 = arg_437_1.actors_["10097"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_2) and arg_437_1.var_.actorSpriteComps10097 == nil then
				arg_437_1.var_.actorSpriteComps10097 = var_440_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_440_3 = 2

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_3 and not isNil(var_440_2) then
				if arg_437_1.var_.actorSpriteComps10097 then
					for iter_440_1, iter_440_2 in pairs(arg_437_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_440_2 then
							if arg_437_1.isInRecall_ then
								iter_440_2.color = Color.New(Mathf.Lerp(iter_440_2.color.r, arg_437_1.hightColor1.r, (arg_437_1.time_ - 0) / var_440_3), Mathf.Lerp(iter_440_2.color.g, arg_437_1.hightColor1.g, (arg_437_1.time_ - 0) / var_440_3), (Mathf.Lerp(iter_440_2.color.b, arg_437_1.hightColor1.b, (arg_437_1.time_ - 0) / var_440_3)))
							else
								local var_440_4 = Mathf.Lerp(iter_440_2.color.r, 1, (arg_437_1.time_ - 0) / var_440_3)

								iter_440_2.color = Color.New(var_440_4, var_440_4, var_440_4)
							end
						end
					end
				end
			end

			if arg_437_1.time_ >= 0 + var_440_3 and arg_437_1.time_ < 0 + var_440_3 + arg_440_0 and not isNil(var_440_2) and arg_437_1.var_.actorSpriteComps10097 then
				for iter_440_3, iter_440_4 in pairs(arg_437_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_440_4 then
						iter_440_4.color = arg_437_1.isInRecall_ and (arg_437_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_437_1.var_.actorSpriteComps10097 = nil
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				local var_440_5 = arg_437_1.actors_["10097"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_440_5 then
					arg_437_1.var_.alphaOldValue10097 = var_440_5.alpha
					arg_437_1.var_.characterEffect10097 = var_440_5
				end

				arg_437_1.var_.alphaOldValue10097 = 0
			end

			local var_440_6 = 0.2

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_6 then
				if arg_437_1.var_.characterEffect10097 then
					arg_437_1.var_.characterEffect10097.alpha = Mathf.Lerp(arg_437_1.var_.alphaOldValue10097, 1, (arg_437_1.time_ - 0) / var_440_6)
				end
			end

			if arg_437_1.time_ >= 0 + var_440_6 and arg_437_1.time_ < 0 + var_440_6 + arg_440_0 and arg_437_1.var_.characterEffect10097 then
				arg_437_1.var_.characterEffect10097.alpha = 1
			end

			local var_440_7 = 0
			local var_440_8 = 0.625

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_7 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_9 = arg_437_1:GetWordFromCfg(413091104)
				local var_440_10 = arg_437_1:FormatText(var_440_9.content)

				arg_437_1.text_.text = var_440_10

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_12 = 25 <= 0 and var_440_8 or var_440_8 * (utf8.len(var_440_10) / 25)

				if (25 <= 0 and var_440_8 or var_440_8 * (utf8.len(var_440_10) / 25)) > 0 and var_440_8 < var_440_12 then
					arg_437_1.talkMaxDuration = var_440_12

					if var_440_12 + var_440_7 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_12 + var_440_7
					end
				end

				arg_437_1.text_.text = var_440_10
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091104", "story_v_out_413091.awb") ~= 0 then
					local var_440_13 = manager.audio:GetVoiceLength("story_v_out_413091", "413091104", "story_v_out_413091.awb") / 1000

					if var_440_13 + var_440_7 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_13 + var_440_7
					end

					if var_440_9.prefab_name ~= "" and arg_437_1.actors_[var_440_9.prefab_name] ~= nil then
						local var_440_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_9.prefab_name].transform, "story_v_out_413091", "413091104", "story_v_out_413091.awb")

						arg_437_1:RecordAudio("413091104", var_440_14)
						arg_437_1:RecordAudio("413091104", var_440_14)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_413091", "413091104", "story_v_out_413091.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_413091", "413091104", "story_v_out_413091.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_15 = math.max(var_440_8, arg_437_1.talkMaxDuration)

			if var_440_7 <= arg_437_1.time_ and arg_437_1.time_ < var_440_7 + var_440_15 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_7) / var_440_15

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_7 + var_440_15 and arg_437_1.time_ < var_440_7 + var_440_15 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
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

		arg_437_1:InitPlayNodeList()
	end,
	Play413091105 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 413091105
		arg_441_1.duration_ = 7.5

		local var_441_0 = {
			zh = 5.266,
			ja = 7.5
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play413091106(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.var_.moveOldPos10097 = arg_441_1.actors_["10097"].transform.localPosition
				arg_441_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_441_1:CheckSpriteTmpPos("10097", 3)

				for iter_444_0 = 0, arg_441_1.actors_["10097"].transform.childCount - 1 do
					local var_444_0 = arg_441_1.actors_["10097"].transform:GetChild(iter_444_0)

					if var_444_0.name == "split_4" or not string.find(var_444_0.name, "split") then
						var_444_0.gameObject:SetActive(true)
					else
						var_444_0.gameObject:SetActive(false)
					end
				end
			end

			local var_444_1 = 0.001

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_1 then
				arg_441_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_441_1.time_ - 0) / var_444_1)
			end

			if arg_441_1.time_ >= 0 + var_444_1 and arg_441_1.time_ < 0 + var_444_1 + arg_444_0 then
				arg_441_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_444_2 = 0
			local var_444_3 = 0.4

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_2 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_4 = arg_441_1:GetWordFromCfg(413091105)
				local var_444_5 = arg_441_1:FormatText(var_444_4.content)

				arg_441_1.text_.text = var_444_5

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_7 = 16 <= 0 and var_444_3 or var_444_3 * (utf8.len(var_444_5) / 16)

				if (16 <= 0 and var_444_3 or var_444_3 * (utf8.len(var_444_5) / 16)) > 0 and var_444_3 < var_444_7 then
					arg_441_1.talkMaxDuration = var_444_7

					if var_444_7 + var_444_2 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_7 + var_444_2
					end
				end

				arg_441_1.text_.text = var_444_5
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091105", "story_v_out_413091.awb") ~= 0 then
					local var_444_8 = manager.audio:GetVoiceLength("story_v_out_413091", "413091105", "story_v_out_413091.awb") / 1000

					if var_444_8 + var_444_2 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_8 + var_444_2
					end

					if var_444_4.prefab_name ~= "" and arg_441_1.actors_[var_444_4.prefab_name] ~= nil then
						local var_444_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_4.prefab_name].transform, "story_v_out_413091", "413091105", "story_v_out_413091.awb")

						arg_441_1:RecordAudio("413091105", var_444_9)
						arg_441_1:RecordAudio("413091105", var_444_9)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_413091", "413091105", "story_v_out_413091.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_413091", "413091105", "story_v_out_413091.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_10 = math.max(var_444_3, arg_441_1.talkMaxDuration)

			if var_444_2 <= arg_441_1.time_ and arg_441_1.time_ < var_444_2 + var_444_10 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_2) / var_444_10

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_2 + var_444_10 and arg_441_1.time_ < var_444_2 + var_444_10 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
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

		arg_441_1:InitPlayNodeList()
	end,
	Play413091106 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 413091106
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play413091107(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.var_.moveOldPos10097 = arg_445_1.actors_["10097"].transform.localPosition
				arg_445_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_445_1:CheckSpriteTmpPos("10097", 7)

				for iter_448_0 = 0, arg_445_1.actors_["10097"].transform.childCount - 1 do
					local var_448_0 = arg_445_1.actors_["10097"].transform:GetChild(iter_448_0)

					if var_448_0.name == "split_3" or not string.find(var_448_0.name, "split") then
						var_448_0.gameObject:SetActive(true)
					else
						var_448_0.gameObject:SetActive(false)
					end
				end
			end

			local var_448_1 = 0.001

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_1 then
				arg_445_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos10097, Vector3.New(0, -2000, -180), (arg_445_1.time_ - 0) / var_448_1)
			end

			if arg_445_1.time_ >= 0 + var_448_1 and arg_445_1.time_ < 0 + var_448_1 + arg_448_0 then
				arg_445_1.actors_["10097"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_448_2 = arg_445_1.actors_["10093"].transform

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.var_.moveOldPos10093 = var_448_2.localPosition
				var_448_2.localScale = Vector3.New(1, 1, 1)

				arg_445_1:CheckSpriteTmpPos("10093", 7)

				for iter_448_1 = 0, var_448_2.childCount - 1 do
					local var_448_3 = var_448_2:GetChild(iter_448_1)

					if var_448_3.name == "split_3" or not string.find(var_448_3.name, "split") then
						var_448_3.gameObject:SetActive(true)
					else
						var_448_3.gameObject:SetActive(false)
					end
				end
			end

			local var_448_4 = 0.001

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_4 then
				var_448_2.localPosition = Vector3.Lerp(arg_445_1.var_.moveOldPos10093, Vector3.New(0, -2000, -180), (arg_445_1.time_ - 0) / var_448_4)
			end

			if arg_445_1.time_ >= 0 + var_448_4 and arg_445_1.time_ < 0 + var_448_4 + arg_448_0 then
				var_448_2.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_448_5 = 0
			local var_448_6 = 0.975

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_5 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_7 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(413091106).content)

				arg_445_1.text_.text = var_448_7

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_9 = 39 <= 0 and var_448_6 or var_448_6 * (utf8.len(var_448_7) / 39)

				if (39 <= 0 and var_448_6 or var_448_6 * (utf8.len(var_448_7) / 39)) > 0 and var_448_6 < var_448_9 then
					arg_445_1.talkMaxDuration = var_448_9

					if var_448_9 + var_448_5 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_9 + var_448_5
					end
				end

				arg_445_1.text_.text = var_448_7
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_10 = math.max(var_448_6, arg_445_1.talkMaxDuration)

			if var_448_5 <= arg_445_1.time_ and arg_445_1.time_ < var_448_5 + var_448_10 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_5) / var_448_10

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_5 + var_448_10 and arg_445_1.time_ < var_448_5 + var_448_10 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {
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
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_445_1:InitPlayNodeList()
	end,
	Play413091107 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 413091107
		arg_449_1.duration_ = 17.87

		local var_449_0 = {
			zh = 9.966,
			ja = 17.866
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
				arg_449_0:Play413091108(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos10097 = arg_449_1.actors_["10097"].transform.localPosition
				arg_449_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_449_1:CheckSpriteTmpPos("10097", 3)

				for iter_452_0 = 0, arg_449_1.actors_["10097"].transform.childCount - 1 do
					local var_452_0 = arg_449_1.actors_["10097"].transform:GetChild(iter_452_0)

					if var_452_0.name == "split_4" or not string.find(var_452_0.name, "split") then
						var_452_0.gameObject:SetActive(true)
					else
						var_452_0.gameObject:SetActive(false)
					end
				end
			end

			local var_452_1 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_1 then
				arg_449_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_449_1.time_ - 0) / var_452_1)
			end

			if arg_449_1.time_ >= 0 + var_452_1 and arg_449_1.time_ < 0 + var_452_1 + arg_452_0 then
				arg_449_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_452_2 = arg_449_1.actors_["10097"]

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(var_452_2) and arg_449_1.var_.actorSpriteComps10097 == nil then
				arg_449_1.var_.actorSpriteComps10097 = var_452_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_452_3 = 2

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_3 and not isNil(var_452_2) then
				if arg_449_1.var_.actorSpriteComps10097 then
					for iter_452_1, iter_452_2 in pairs(arg_449_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_452_2 then
							if arg_449_1.isInRecall_ then
								iter_452_2.color = Color.New(Mathf.Lerp(iter_452_2.color.r, arg_449_1.hightColor1.r, (arg_449_1.time_ - 0) / var_452_3), Mathf.Lerp(iter_452_2.color.g, arg_449_1.hightColor1.g, (arg_449_1.time_ - 0) / var_452_3), (Mathf.Lerp(iter_452_2.color.b, arg_449_1.hightColor1.b, (arg_449_1.time_ - 0) / var_452_3)))
							else
								local var_452_4 = Mathf.Lerp(iter_452_2.color.r, 1, (arg_449_1.time_ - 0) / var_452_3)

								iter_452_2.color = Color.New(var_452_4, var_452_4, var_452_4)
							end
						end
					end
				end
			end

			if arg_449_1.time_ >= 0 + var_452_3 and arg_449_1.time_ < 0 + var_452_3 + arg_452_0 and not isNil(var_452_2) and arg_449_1.var_.actorSpriteComps10097 then
				for iter_452_3, iter_452_4 in pairs(arg_449_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_452_4 then
						iter_452_4.color = arg_449_1.isInRecall_ and (arg_449_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_449_1.var_.actorSpriteComps10097 = nil
			end

			local var_452_5 = 0
			local var_452_6 = 0.475

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_5 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_7 = arg_449_1:GetWordFromCfg(413091107)
				local var_452_8 = arg_449_1:FormatText(var_452_7.content)

				arg_449_1.text_.text = var_452_8

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_10 = 19 <= 0 and var_452_6 or var_452_6 * (utf8.len(var_452_8) / 19)

				if (19 <= 0 and var_452_6 or var_452_6 * (utf8.len(var_452_8) / 19)) > 0 and var_452_6 < var_452_10 then
					arg_449_1.talkMaxDuration = var_452_10

					if var_452_10 + var_452_5 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_10 + var_452_5
					end
				end

				arg_449_1.text_.text = var_452_8
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091107", "story_v_out_413091.awb") ~= 0 then
					local var_452_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091107", "story_v_out_413091.awb") / 1000

					if var_452_11 + var_452_5 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_11 + var_452_5
					end

					if var_452_7.prefab_name ~= "" and arg_449_1.actors_[var_452_7.prefab_name] ~= nil then
						local var_452_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_7.prefab_name].transform, "story_v_out_413091", "413091107", "story_v_out_413091.awb")

						arg_449_1:RecordAudio("413091107", var_452_12)
						arg_449_1:RecordAudio("413091107", var_452_12)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_413091", "413091107", "story_v_out_413091.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_413091", "413091107", "story_v_out_413091.awb")
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
				actorName = "10097",
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
	Play413091108 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 413091108
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play413091109(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(arg_453_1.actors_["10097"]) and arg_453_1.var_.actorSpriteComps10097 == nil then
				arg_453_1.var_.actorSpriteComps10097 = arg_453_1.actors_["10097"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_456_0 = 0.2

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 and not isNil(arg_453_1.actors_["10097"]) then
				if arg_453_1.var_.actorSpriteComps10097 then
					for iter_456_0, iter_456_1 in pairs(arg_453_1.var_.actorSpriteComps10097:ToTable()) do
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

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 and not isNil(arg_453_1.actors_["10097"]) and arg_453_1.var_.actorSpriteComps10097 then
				for iter_456_2, iter_456_3 in pairs(arg_453_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_456_3 then
						iter_456_3.color = arg_453_1.isInRecall_ and (arg_453_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_453_1.var_.actorSpriteComps10097 = nil
			end

			local var_456_2 = 0
			local var_456_3 = 0.95

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_2 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_4 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(413091108).content)

				arg_453_1.text_.text = var_456_4

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_6 = 38 <= 0 and var_456_3 or var_456_3 * (utf8.len(var_456_4) / 38)

				if (38 <= 0 and var_456_3 or var_456_3 * (utf8.len(var_456_4) / 38)) > 0 and var_456_3 < var_456_6 then
					arg_453_1.talkMaxDuration = var_456_6

					if var_456_6 + var_456_2 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_6 + var_456_2
					end
				end

				arg_453_1.text_.text = var_456_4
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_7 = math.max(var_456_3, arg_453_1.talkMaxDuration)

			if var_456_2 <= arg_453_1.time_ and arg_453_1.time_ < var_456_2 + var_456_7 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_2) / var_456_7

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_2 + var_456_7 and arg_453_1.time_ < var_456_2 + var_456_7 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play413091109 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 413091109
		arg_457_1.duration_ = 5.47

		local var_457_0 = {
			zh = 5.466,
			ja = 5.366
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
				arg_457_0:Play413091110(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(arg_457_1.actors_["10093"]) and arg_457_1.var_.actorSpriteComps10093 == nil then
				arg_457_1.var_.actorSpriteComps10093 = arg_457_1.actors_["10093"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_460_0 = 2

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 and not isNil(arg_457_1.actors_["10093"]) then
				if arg_457_1.var_.actorSpriteComps10093 then
					for iter_460_0, iter_460_1 in pairs(arg_457_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_460_1 then
							if arg_457_1.isInRecall_ then
								iter_460_1.color = Color.New(Mathf.Lerp(iter_460_1.color.r, arg_457_1.hightColor1.r, (arg_457_1.time_ - 0) / var_460_0), Mathf.Lerp(iter_460_1.color.g, arg_457_1.hightColor1.g, (arg_457_1.time_ - 0) / var_460_0), (Mathf.Lerp(iter_460_1.color.b, arg_457_1.hightColor1.b, (arg_457_1.time_ - 0) / var_460_0)))
							else
								local var_460_1 = Mathf.Lerp(iter_460_1.color.r, 1, (arg_457_1.time_ - 0) / var_460_0)

								iter_460_1.color = Color.New(var_460_1, var_460_1, var_460_1)
							end
						end
					end
				end
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 and not isNil(arg_457_1.actors_["10093"]) and arg_457_1.var_.actorSpriteComps10093 then
				for iter_460_2, iter_460_3 in pairs(arg_457_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_460_3 then
						iter_460_3.color = arg_457_1.isInRecall_ and (arg_457_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_457_1.var_.actorSpriteComps10093 = nil
			end

			local var_460_2 = arg_457_1.actors_["10097"].transform

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos10097 = var_460_2.localPosition
				var_460_2.localScale = Vector3.New(1, 1, 1)

				arg_457_1:CheckSpriteTmpPos("10097", 4)

				for iter_460_4 = 0, var_460_2.childCount - 1 do
					local var_460_3 = var_460_2:GetChild(iter_460_4)

					if var_460_3.name == "split_3" or not string.find(var_460_3.name, "split") then
						var_460_3.gameObject:SetActive(true)
					else
						var_460_3.gameObject:SetActive(false)
					end
				end
			end

			local var_460_4 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_4 then
				var_460_2.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_457_1.time_ - 0) / var_460_4)
			end

			if arg_457_1.time_ >= 0 + var_460_4 and arg_457_1.time_ < 0 + var_460_4 + arg_460_0 then
				var_460_2.localPosition = Vector3.New(390, -350, -180)
			end

			local var_460_5 = arg_457_1.actors_["10093"].transform

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos10093 = var_460_5.localPosition
				var_460_5.localScale = Vector3.New(1, 1, 1)

				arg_457_1:CheckSpriteTmpPos("10093", 2)

				for iter_460_5 = 0, var_460_5.childCount - 1 do
					local var_460_6 = var_460_5:GetChild(iter_460_5)

					if var_460_6.name == "split_4" or not string.find(var_460_6.name, "split") then
						var_460_6.gameObject:SetActive(true)
					else
						var_460_6.gameObject:SetActive(false)
					end
				end
			end

			local var_460_7 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_7 then
				var_460_5.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_457_1.time_ - 0) / var_460_7)
			end

			if arg_457_1.time_ >= 0 + var_460_7 and arg_457_1.time_ < 0 + var_460_7 + arg_460_0 then
				var_460_5.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_460_8 = 0
			local var_460_9 = 0.525

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_8 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_10 = arg_457_1:GetWordFromCfg(413091109)
				local var_460_11 = arg_457_1:FormatText(var_460_10.content)

				arg_457_1.text_.text = var_460_11

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_13 = 21 <= 0 and var_460_9 or var_460_9 * (utf8.len(var_460_11) / 21)

				if (21 <= 0 and var_460_9 or var_460_9 * (utf8.len(var_460_11) / 21)) > 0 and var_460_9 < var_460_13 then
					arg_457_1.talkMaxDuration = var_460_13

					if var_460_13 + var_460_8 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_13 + var_460_8
					end
				end

				arg_457_1.text_.text = var_460_11
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091109", "story_v_out_413091.awb") ~= 0 then
					local var_460_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091109", "story_v_out_413091.awb") / 1000

					if var_460_14 + var_460_8 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_14 + var_460_8
					end

					if var_460_10.prefab_name ~= "" and arg_457_1.actors_[var_460_10.prefab_name] ~= nil then
						local var_460_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_10.prefab_name].transform, "story_v_out_413091", "413091109", "story_v_out_413091.awb")

						arg_457_1:RecordAudio("413091109", var_460_15)
						arg_457_1:RecordAudio("413091109", var_460_15)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_413091", "413091109", "story_v_out_413091.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_413091", "413091109", "story_v_out_413091.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_16 = math.max(var_460_9, arg_457_1.talkMaxDuration)

			if var_460_8 <= arg_457_1.time_ and arg_457_1.time_ < var_460_8 + var_460_16 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_8) / var_460_16

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_8 + var_460_16 and arg_457_1.time_ < var_460_8 + var_460_16 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
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
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play413091110 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 413091110
		arg_461_1.duration_ = 5.23

		local var_461_0 = {
			zh = 4.133,
			ja = 5.233
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
				arg_461_0:Play413091111(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.moveOldPos10093 = arg_461_1.actors_["10093"].transform.localPosition
				arg_461_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_461_1:CheckSpriteTmpPos("10093", 2)

				for iter_464_0 = 0, arg_461_1.actors_["10093"].transform.childCount - 1 do
					local var_464_0 = arg_461_1.actors_["10093"].transform:GetChild(iter_464_0)

					if var_464_0.name == "split_1" or not string.find(var_464_0.name, "split") then
						var_464_0.gameObject:SetActive(true)
					else
						var_464_0.gameObject:SetActive(false)
					end
				end
			end

			local var_464_1 = 0.001

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_1 then
				arg_461_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_461_1.time_ - 0) / var_464_1)
			end

			if arg_461_1.time_ >= 0 + var_464_1 and arg_461_1.time_ < 0 + var_464_1 + arg_464_0 then
				arg_461_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_464_2 = arg_461_1.actors_["10093"]

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(var_464_2) and arg_461_1.var_.actorSpriteComps10093 == nil then
				arg_461_1.var_.actorSpriteComps10093 = var_464_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_464_3 = 2

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_3 and not isNil(var_464_2) then
				if arg_461_1.var_.actorSpriteComps10093 then
					for iter_464_1, iter_464_2 in pairs(arg_461_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_464_2 then
							if arg_461_1.isInRecall_ then
								iter_464_2.color = Color.New(Mathf.Lerp(iter_464_2.color.r, arg_461_1.hightColor1.r, (arg_461_1.time_ - 0) / var_464_3), Mathf.Lerp(iter_464_2.color.g, arg_461_1.hightColor1.g, (arg_461_1.time_ - 0) / var_464_3), (Mathf.Lerp(iter_464_2.color.b, arg_461_1.hightColor1.b, (arg_461_1.time_ - 0) / var_464_3)))
							else
								local var_464_4 = Mathf.Lerp(iter_464_2.color.r, 1, (arg_461_1.time_ - 0) / var_464_3)

								iter_464_2.color = Color.New(var_464_4, var_464_4, var_464_4)
							end
						end
					end
				end
			end

			if arg_461_1.time_ >= 0 + var_464_3 and arg_461_1.time_ < 0 + var_464_3 + arg_464_0 and not isNil(var_464_2) and arg_461_1.var_.actorSpriteComps10093 then
				for iter_464_3, iter_464_4 in pairs(arg_461_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_464_4 then
						iter_464_4.color = arg_461_1.isInRecall_ and (arg_461_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_461_1.var_.actorSpriteComps10093 = nil
			end

			local var_464_5 = 0
			local var_464_6 = 0.625

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_5 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_7 = arg_461_1:GetWordFromCfg(413091110)
				local var_464_8 = arg_461_1:FormatText(var_464_7.content)

				arg_461_1.text_.text = var_464_8

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_10 = 25 <= 0 and var_464_6 or var_464_6 * (utf8.len(var_464_8) / 25)

				if (25 <= 0 and var_464_6 or var_464_6 * (utf8.len(var_464_8) / 25)) > 0 and var_464_6 < var_464_10 then
					arg_461_1.talkMaxDuration = var_464_10

					if var_464_10 + var_464_5 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_10 + var_464_5
					end
				end

				arg_461_1.text_.text = var_464_8
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091110", "story_v_out_413091.awb") ~= 0 then
					local var_464_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091110", "story_v_out_413091.awb") / 1000

					if var_464_11 + var_464_5 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_11 + var_464_5
					end

					if var_464_7.prefab_name ~= "" and arg_461_1.actors_[var_464_7.prefab_name] ~= nil then
						local var_464_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_7.prefab_name].transform, "story_v_out_413091", "413091110", "story_v_out_413091.awb")

						arg_461_1:RecordAudio("413091110", var_464_12)
						arg_461_1:RecordAudio("413091110", var_464_12)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_413091", "413091110", "story_v_out_413091.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_413091", "413091110", "story_v_out_413091.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_13 = math.max(var_464_6, arg_461_1.talkMaxDuration)

			if var_464_5 <= arg_461_1.time_ and arg_461_1.time_ < var_464_5 + var_464_13 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_5) / var_464_13

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_5 + var_464_13 and arg_461_1.time_ < var_464_5 + var_464_13 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
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

		arg_461_1:InitPlayNodeList()
	end,
	Play413091111 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 413091111
		arg_465_1.duration_ = 8.8

		local var_465_0 = {
			zh = 8.166,
			ja = 8.8
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
				arg_465_0:Play413091112(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 1.05

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_1 = arg_465_1:GetWordFromCfg(413091111)
				local var_468_2 = arg_465_1:FormatText(var_468_1.content)

				arg_465_1.text_.text = var_468_2

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_4 = 42 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_2) / 42)

				if (42 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_2) / 42)) > 0 and var_468_0 < var_468_4 then
					arg_465_1.talkMaxDuration = var_468_4

					if var_468_4 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_4 + 0
					end
				end

				arg_465_1.text_.text = var_468_2
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091111", "story_v_out_413091.awb") ~= 0 then
					local var_468_5 = manager.audio:GetVoiceLength("story_v_out_413091", "413091111", "story_v_out_413091.awb") / 1000

					if var_468_5 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_5 + 0
					end

					if var_468_1.prefab_name ~= "" and arg_465_1.actors_[var_468_1.prefab_name] ~= nil then
						local var_468_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_1.prefab_name].transform, "story_v_out_413091", "413091111", "story_v_out_413091.awb")

						arg_465_1:RecordAudio("413091111", var_468_6)
						arg_465_1:RecordAudio("413091111", var_468_6)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_413091", "413091111", "story_v_out_413091.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_413091", "413091111", "story_v_out_413091.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_7 = math.max(var_468_0, arg_465_1.talkMaxDuration)

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_7 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - 0) / var_468_7

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= 0 + var_468_7 and arg_465_1.time_ < 0 + var_468_7 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play413091112 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 413091112
		arg_469_1.duration_ = 7.9

		local var_469_0 = {
			zh = 6.533,
			ja = 7.9
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play413091113(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.var_.moveOldPos10093 = arg_469_1.actors_["10093"].transform.localPosition
				arg_469_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_469_1:CheckSpriteTmpPos("10093", 2)

				for iter_472_0 = 0, arg_469_1.actors_["10093"].transform.childCount - 1 do
					local var_472_0 = arg_469_1.actors_["10093"].transform:GetChild(iter_472_0)

					if var_472_0.name == "" or not string.find(var_472_0.name, "split") then
						var_472_0.gameObject:SetActive(true)
					else
						var_472_0.gameObject:SetActive(false)
					end
				end
			end

			local var_472_1 = 0.001

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_1 then
				arg_469_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_469_1.time_ - 0) / var_472_1)
			end

			if arg_469_1.time_ >= 0 + var_472_1 and arg_469_1.time_ < 0 + var_472_1 + arg_472_0 then
				arg_469_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_472_2 = arg_469_1.actors_["10093"]

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(var_472_2) and arg_469_1.var_.actorSpriteComps10093 == nil then
				arg_469_1.var_.actorSpriteComps10093 = var_472_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_472_3 = 2

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_3 and not isNil(var_472_2) then
				if arg_469_1.var_.actorSpriteComps10093 then
					for iter_472_1, iter_472_2 in pairs(arg_469_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_472_2 then
							if arg_469_1.isInRecall_ then
								iter_472_2.color = Color.New(Mathf.Lerp(iter_472_2.color.r, arg_469_1.hightColor1.r, (arg_469_1.time_ - 0) / var_472_3), Mathf.Lerp(iter_472_2.color.g, arg_469_1.hightColor1.g, (arg_469_1.time_ - 0) / var_472_3), (Mathf.Lerp(iter_472_2.color.b, arg_469_1.hightColor1.b, (arg_469_1.time_ - 0) / var_472_3)))
							else
								local var_472_4 = Mathf.Lerp(iter_472_2.color.r, 1, (arg_469_1.time_ - 0) / var_472_3)

								iter_472_2.color = Color.New(var_472_4, var_472_4, var_472_4)
							end
						end
					end
				end
			end

			if arg_469_1.time_ >= 0 + var_472_3 and arg_469_1.time_ < 0 + var_472_3 + arg_472_0 and not isNil(var_472_2) and arg_469_1.var_.actorSpriteComps10093 then
				for iter_472_3, iter_472_4 in pairs(arg_469_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_472_4 then
						iter_472_4.color = arg_469_1.isInRecall_ and (arg_469_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_469_1.var_.actorSpriteComps10093 = nil
			end

			local var_472_5 = 0
			local var_472_6 = 0.525

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_5 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_7 = arg_469_1:GetWordFromCfg(413091112)
				local var_472_8 = arg_469_1:FormatText(var_472_7.content)

				arg_469_1.text_.text = var_472_8

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_10 = 21 <= 0 and var_472_6 or var_472_6 * (utf8.len(var_472_8) / 21)

				if (21 <= 0 and var_472_6 or var_472_6 * (utf8.len(var_472_8) / 21)) > 0 and var_472_6 < var_472_10 then
					arg_469_1.talkMaxDuration = var_472_10

					if var_472_10 + var_472_5 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_10 + var_472_5
					end
				end

				arg_469_1.text_.text = var_472_8
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091112", "story_v_out_413091.awb") ~= 0 then
					local var_472_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091112", "story_v_out_413091.awb") / 1000

					if var_472_11 + var_472_5 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_11 + var_472_5
					end

					if var_472_7.prefab_name ~= "" and arg_469_1.actors_[var_472_7.prefab_name] ~= nil then
						local var_472_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_7.prefab_name].transform, "story_v_out_413091", "413091112", "story_v_out_413091.awb")

						arg_469_1:RecordAudio("413091112", var_472_12)
						arg_469_1:RecordAudio("413091112", var_472_12)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_413091", "413091112", "story_v_out_413091.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_413091", "413091112", "story_v_out_413091.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_13 = math.max(var_472_6, arg_469_1.talkMaxDuration)

			if var_472_5 <= arg_469_1.time_ and arg_469_1.time_ < var_472_5 + var_472_13 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_5) / var_472_13

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_5 + var_472_13 and arg_469_1.time_ < var_472_5 + var_472_13 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
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

		arg_469_1:InitPlayNodeList()
	end,
	Play413091113 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 413091113
		arg_473_1.duration_ = 13

		local var_473_0 = {
			zh = 13,
			ja = 5.366
		}
		local var_473_1 = manager.audio:GetLocalizationFlag()

		if var_473_0[var_473_1] ~= nil then
			arg_473_1.duration_ = var_473_0[var_473_1]
		end

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play413091114(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.var_.moveOldPos10097 = arg_473_1.actors_["10097"].transform.localPosition
				arg_473_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_473_1:CheckSpriteTmpPos("10097", 4)

				for iter_476_0 = 0, arg_473_1.actors_["10097"].transform.childCount - 1 do
					local var_476_0 = arg_473_1.actors_["10097"].transform:GetChild(iter_476_0)

					if var_476_0.name == "split_2" or not string.find(var_476_0.name, "split") then
						var_476_0.gameObject:SetActive(true)
					else
						var_476_0.gameObject:SetActive(false)
					end
				end
			end

			local var_476_1 = 0.001

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_1 then
				arg_473_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_473_1.time_ - 0) / var_476_1)
			end

			if arg_473_1.time_ >= 0 + var_476_1 and arg_473_1.time_ < 0 + var_476_1 + arg_476_0 then
				arg_473_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_476_2 = arg_473_1.actors_["10097"]

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(var_476_2) and arg_473_1.var_.actorSpriteComps10097 == nil then
				arg_473_1.var_.actorSpriteComps10097 = var_476_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_476_3 = 2

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_3 and not isNil(var_476_2) then
				if arg_473_1.var_.actorSpriteComps10097 then
					for iter_476_1, iter_476_2 in pairs(arg_473_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_476_2 then
							if arg_473_1.isInRecall_ then
								iter_476_2.color = Color.New(Mathf.Lerp(iter_476_2.color.r, arg_473_1.hightColor1.r, (arg_473_1.time_ - 0) / var_476_3), Mathf.Lerp(iter_476_2.color.g, arg_473_1.hightColor1.g, (arg_473_1.time_ - 0) / var_476_3), (Mathf.Lerp(iter_476_2.color.b, arg_473_1.hightColor1.b, (arg_473_1.time_ - 0) / var_476_3)))
							else
								local var_476_4 = Mathf.Lerp(iter_476_2.color.r, 1, (arg_473_1.time_ - 0) / var_476_3)

								iter_476_2.color = Color.New(var_476_4, var_476_4, var_476_4)
							end
						end
					end
				end
			end

			if arg_473_1.time_ >= 0 + var_476_3 and arg_473_1.time_ < 0 + var_476_3 + arg_476_0 and not isNil(var_476_2) and arg_473_1.var_.actorSpriteComps10097 then
				for iter_476_3, iter_476_4 in pairs(arg_473_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_476_4 then
						iter_476_4.color = arg_473_1.isInRecall_ and (arg_473_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_473_1.var_.actorSpriteComps10097 = nil
			end

			local var_476_5 = arg_473_1.actors_["10093"]

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(var_476_5) and arg_473_1.var_.actorSpriteComps10093 == nil then
				arg_473_1.var_.actorSpriteComps10093 = var_476_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_476_6 = 0.2

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_6 and not isNil(var_476_5) then
				if arg_473_1.var_.actorSpriteComps10093 then
					for iter_476_5, iter_476_6 in pairs(arg_473_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_476_6 then
							if arg_473_1.isInRecall_ then
								iter_476_6.color = Color.New(Mathf.Lerp(iter_476_6.color.r, arg_473_1.hightColor2.r, (arg_473_1.time_ - 0) / var_476_6), Mathf.Lerp(iter_476_6.color.g, arg_473_1.hightColor2.g, (arg_473_1.time_ - 0) / var_476_6), (Mathf.Lerp(iter_476_6.color.b, arg_473_1.hightColor2.b, (arg_473_1.time_ - 0) / var_476_6)))
							else
								local var_476_7 = Mathf.Lerp(iter_476_6.color.r, 0.5, (arg_473_1.time_ - 0) / var_476_6)

								iter_476_6.color = Color.New(var_476_7, var_476_7, var_476_7)
							end
						end
					end
				end
			end

			if arg_473_1.time_ >= 0 + var_476_6 and arg_473_1.time_ < 0 + var_476_6 + arg_476_0 and not isNil(var_476_5) and arg_473_1.var_.actorSpriteComps10093 then
				for iter_476_7, iter_476_8 in pairs(arg_473_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_476_8 then
						iter_476_8.color = arg_473_1.isInRecall_ and (arg_473_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_473_1.var_.actorSpriteComps10093 = nil
			end

			local var_476_8 = 0
			local var_476_9 = 0.7

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_8 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_10 = arg_473_1:GetWordFromCfg(413091113)
				local var_476_11 = arg_473_1:FormatText(var_476_10.content)

				arg_473_1.text_.text = var_476_11

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_13 = 28 <= 0 and var_476_9 or var_476_9 * (utf8.len(var_476_11) / 28)

				if (28 <= 0 and var_476_9 or var_476_9 * (utf8.len(var_476_11) / 28)) > 0 and var_476_9 < var_476_13 then
					arg_473_1.talkMaxDuration = var_476_13

					if var_476_13 + var_476_8 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_13 + var_476_8
					end
				end

				arg_473_1.text_.text = var_476_11
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091113", "story_v_out_413091.awb") ~= 0 then
					local var_476_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091113", "story_v_out_413091.awb") / 1000

					if var_476_14 + var_476_8 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_14 + var_476_8
					end

					if var_476_10.prefab_name ~= "" and arg_473_1.actors_[var_476_10.prefab_name] ~= nil then
						local var_476_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_10.prefab_name].transform, "story_v_out_413091", "413091113", "story_v_out_413091.awb")

						arg_473_1:RecordAudio("413091113", var_476_15)
						arg_473_1:RecordAudio("413091113", var_476_15)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_413091", "413091113", "story_v_out_413091.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_413091", "413091113", "story_v_out_413091.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_16 = math.max(var_476_9, arg_473_1.talkMaxDuration)

			if var_476_8 <= arg_473_1.time_ and arg_473_1.time_ < var_476_8 + var_476_16 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_8) / var_476_16

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_8 + var_476_16 and arg_473_1.time_ < var_476_8 + var_476_16 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
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

		arg_473_1:InitPlayNodeList()
	end,
	Play413091114 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 413091114
		arg_477_1.duration_ = 21.5

		local var_477_0 = {
			zh = 13.5,
			ja = 21.5
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play413091115(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.var_.moveOldPos10097 = arg_477_1.actors_["10097"].transform.localPosition
				arg_477_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_477_1:CheckSpriteTmpPos("10097", 4)

				for iter_480_0 = 0, arg_477_1.actors_["10097"].transform.childCount - 1 do
					local var_480_0 = arg_477_1.actors_["10097"].transform:GetChild(iter_480_0)

					if var_480_0.name == "split_4" or not string.find(var_480_0.name, "split") then
						var_480_0.gameObject:SetActive(true)
					else
						var_480_0.gameObject:SetActive(false)
					end
				end
			end

			local var_480_1 = 0.001

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_1 then
				arg_477_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos10097, Vector3.New(390, -350, -180), (arg_477_1.time_ - 0) / var_480_1)
			end

			if arg_477_1.time_ >= 0 + var_480_1 and arg_477_1.time_ < 0 + var_480_1 + arg_480_0 then
				arg_477_1.actors_["10097"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_480_2 = 0
			local var_480_3 = 0.95

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_2 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_4 = arg_477_1:GetWordFromCfg(413091114)
				local var_480_5 = arg_477_1:FormatText(var_480_4.content)

				arg_477_1.text_.text = var_480_5

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_7 = 38 <= 0 and var_480_3 or var_480_3 * (utf8.len(var_480_5) / 38)

				if (38 <= 0 and var_480_3 or var_480_3 * (utf8.len(var_480_5) / 38)) > 0 and var_480_3 < var_480_7 then
					arg_477_1.talkMaxDuration = var_480_7

					if var_480_7 + var_480_2 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_7 + var_480_2
					end
				end

				arg_477_1.text_.text = var_480_5
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091114", "story_v_out_413091.awb") ~= 0 then
					local var_480_8 = manager.audio:GetVoiceLength("story_v_out_413091", "413091114", "story_v_out_413091.awb") / 1000

					if var_480_8 + var_480_2 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_8 + var_480_2
					end

					if var_480_4.prefab_name ~= "" and arg_477_1.actors_[var_480_4.prefab_name] ~= nil then
						local var_480_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_4.prefab_name].transform, "story_v_out_413091", "413091114", "story_v_out_413091.awb")

						arg_477_1:RecordAudio("413091114", var_480_9)
						arg_477_1:RecordAudio("413091114", var_480_9)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_413091", "413091114", "story_v_out_413091.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_413091", "413091114", "story_v_out_413091.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_10 = math.max(var_480_3, arg_477_1.talkMaxDuration)

			if var_480_2 <= arg_477_1.time_ and arg_477_1.time_ < var_480_2 + var_480_10 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_2) / var_480_10

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_2 + var_480_10 and arg_477_1.time_ < var_480_2 + var_480_10 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
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

		arg_477_1:InitPlayNodeList()
	end,
	Play413091115 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 413091115
		arg_481_1.duration_ = 7.83

		local var_481_0 = {
			zh = 7.833,
			ja = 7.166
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play413091116(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos10093 = arg_481_1.actors_["10093"].transform.localPosition
				arg_481_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_481_1:CheckSpriteTmpPos("10093", 2)

				for iter_484_0 = 0, arg_481_1.actors_["10093"].transform.childCount - 1 do
					local var_484_0 = arg_481_1.actors_["10093"].transform:GetChild(iter_484_0)

					if var_484_0.name == "split_3" or not string.find(var_484_0.name, "split") then
						var_484_0.gameObject:SetActive(true)
					else
						var_484_0.gameObject:SetActive(false)
					end
				end
			end

			local var_484_1 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_1 then
				arg_481_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_481_1.time_ - 0) / var_484_1)
			end

			if arg_481_1.time_ >= 0 + var_484_1 and arg_481_1.time_ < 0 + var_484_1 + arg_484_0 then
				arg_481_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_484_2 = arg_481_1.actors_["10093"]

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(var_484_2) and arg_481_1.var_.actorSpriteComps10093 == nil then
				arg_481_1.var_.actorSpriteComps10093 = var_484_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_484_3 = 2

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_3 and not isNil(var_484_2) then
				if arg_481_1.var_.actorSpriteComps10093 then
					for iter_484_1, iter_484_2 in pairs(arg_481_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_484_2 then
							if arg_481_1.isInRecall_ then
								iter_484_2.color = Color.New(Mathf.Lerp(iter_484_2.color.r, arg_481_1.hightColor1.r, (arg_481_1.time_ - 0) / var_484_3), Mathf.Lerp(iter_484_2.color.g, arg_481_1.hightColor1.g, (arg_481_1.time_ - 0) / var_484_3), (Mathf.Lerp(iter_484_2.color.b, arg_481_1.hightColor1.b, (arg_481_1.time_ - 0) / var_484_3)))
							else
								local var_484_4 = Mathf.Lerp(iter_484_2.color.r, 1, (arg_481_1.time_ - 0) / var_484_3)

								iter_484_2.color = Color.New(var_484_4, var_484_4, var_484_4)
							end
						end
					end
				end
			end

			if arg_481_1.time_ >= 0 + var_484_3 and arg_481_1.time_ < 0 + var_484_3 + arg_484_0 and not isNil(var_484_2) and arg_481_1.var_.actorSpriteComps10093 then
				for iter_484_3, iter_484_4 in pairs(arg_481_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_484_4 then
						iter_484_4.color = arg_481_1.isInRecall_ and (arg_481_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_481_1.var_.actorSpriteComps10093 = nil
			end

			local var_484_5 = arg_481_1.actors_["10097"]

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(var_484_5) and arg_481_1.var_.actorSpriteComps10097 == nil then
				arg_481_1.var_.actorSpriteComps10097 = var_484_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_484_6 = 0.2

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_6 and not isNil(var_484_5) then
				if arg_481_1.var_.actorSpriteComps10097 then
					for iter_484_5, iter_484_6 in pairs(arg_481_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_484_6 then
							if arg_481_1.isInRecall_ then
								iter_484_6.color = Color.New(Mathf.Lerp(iter_484_6.color.r, arg_481_1.hightColor2.r, (arg_481_1.time_ - 0) / var_484_6), Mathf.Lerp(iter_484_6.color.g, arg_481_1.hightColor2.g, (arg_481_1.time_ - 0) / var_484_6), (Mathf.Lerp(iter_484_6.color.b, arg_481_1.hightColor2.b, (arg_481_1.time_ - 0) / var_484_6)))
							else
								local var_484_7 = Mathf.Lerp(iter_484_6.color.r, 0.5, (arg_481_1.time_ - 0) / var_484_6)

								iter_484_6.color = Color.New(var_484_7, var_484_7, var_484_7)
							end
						end
					end
				end
			end

			if arg_481_1.time_ >= 0 + var_484_6 and arg_481_1.time_ < 0 + var_484_6 + arg_484_0 and not isNil(var_484_5) and arg_481_1.var_.actorSpriteComps10097 then
				for iter_484_7, iter_484_8 in pairs(arg_481_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_484_8 then
						iter_484_8.color = arg_481_1.isInRecall_ and (arg_481_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_481_1.var_.actorSpriteComps10097 = nil
			end

			local var_484_8 = 0
			local var_484_9 = 0.95

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_8 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_10 = arg_481_1:GetWordFromCfg(413091115)
				local var_484_11 = arg_481_1:FormatText(var_484_10.content)

				arg_481_1.text_.text = var_484_11

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_13 = 38 <= 0 and var_484_9 or var_484_9 * (utf8.len(var_484_11) / 38)

				if (38 <= 0 and var_484_9 or var_484_9 * (utf8.len(var_484_11) / 38)) > 0 and var_484_9 < var_484_13 then
					arg_481_1.talkMaxDuration = var_484_13

					if var_484_13 + var_484_8 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_13 + var_484_8
					end
				end

				arg_481_1.text_.text = var_484_11
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091115", "story_v_out_413091.awb") ~= 0 then
					local var_484_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091115", "story_v_out_413091.awb") / 1000

					if var_484_14 + var_484_8 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_14 + var_484_8
					end

					if var_484_10.prefab_name ~= "" and arg_481_1.actors_[var_484_10.prefab_name] ~= nil then
						local var_484_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_10.prefab_name].transform, "story_v_out_413091", "413091115", "story_v_out_413091.awb")

						arg_481_1:RecordAudio("413091115", var_484_15)
						arg_481_1:RecordAudio("413091115", var_484_15)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_413091", "413091115", "story_v_out_413091.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_413091", "413091115", "story_v_out_413091.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_16 = math.max(var_484_9, arg_481_1.talkMaxDuration)

			if var_484_8 <= arg_481_1.time_ and arg_481_1.time_ < var_484_8 + var_484_16 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_8) / var_484_16

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_8 + var_484_16 and arg_481_1.time_ < var_484_8 + var_484_16 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
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

		arg_481_1:InitPlayNodeList()
	end,
	Play413091116 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 413091116
		arg_485_1.duration_ = 6.5

		local var_485_0 = {
			zh = 5.833,
			ja = 6.5
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play413091117(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.var_.moveOldPos10093 = arg_485_1.actors_["10093"].transform.localPosition
				arg_485_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_485_1:CheckSpriteTmpPos("10093", 2)

				for iter_488_0 = 0, arg_485_1.actors_["10093"].transform.childCount - 1 do
					local var_488_0 = arg_485_1.actors_["10093"].transform:GetChild(iter_488_0)

					if var_488_0.name == "" or not string.find(var_488_0.name, "split") then
						var_488_0.gameObject:SetActive(true)
					else
						var_488_0.gameObject:SetActive(false)
					end
				end
			end

			local var_488_1 = 0.001

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_1 then
				arg_485_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos10093, Vector3.New(-390, -345, -245), (arg_485_1.time_ - 0) / var_488_1)
			end

			if arg_485_1.time_ >= 0 + var_488_1 and arg_485_1.time_ < 0 + var_488_1 + arg_488_0 then
				arg_485_1.actors_["10093"].transform.localPosition = Vector3.New(-390, -345, -245)
			end

			local var_488_2 = 0
			local var_488_3 = 0.65

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_2 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_4 = arg_485_1:GetWordFromCfg(413091116)
				local var_488_5 = arg_485_1:FormatText(var_488_4.content)

				arg_485_1.text_.text = var_488_5

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_7 = 26 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_5) / 26)

				if (26 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_5) / 26)) > 0 and var_488_3 < var_488_7 then
					arg_485_1.talkMaxDuration = var_488_7

					if var_488_7 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_7 + var_488_2
					end
				end

				arg_485_1.text_.text = var_488_5
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091116", "story_v_out_413091.awb") ~= 0 then
					local var_488_8 = manager.audio:GetVoiceLength("story_v_out_413091", "413091116", "story_v_out_413091.awb") / 1000

					if var_488_8 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_8 + var_488_2
					end

					if var_488_4.prefab_name ~= "" and arg_485_1.actors_[var_488_4.prefab_name] ~= nil then
						local var_488_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_4.prefab_name].transform, "story_v_out_413091", "413091116", "story_v_out_413091.awb")

						arg_485_1:RecordAudio("413091116", var_488_9)
						arg_485_1:RecordAudio("413091116", var_488_9)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_413091", "413091116", "story_v_out_413091.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_413091", "413091116", "story_v_out_413091.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_10 = math.max(var_488_3, arg_485_1.talkMaxDuration)

			if var_488_2 <= arg_485_1.time_ and arg_485_1.time_ < var_488_2 + var_488_10 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_2) / var_488_10

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_2 + var_488_10 and arg_485_1.time_ < var_488_2 + var_488_10 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
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

		arg_485_1:InitPlayNodeList()
	end,
	Play413091117 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 413091117
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play413091118(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.var_.moveOldPos10093 = arg_489_1.actors_["10093"].transform.localPosition
				arg_489_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_489_1:CheckSpriteTmpPos("10093", 6)

				for iter_492_0 = 0, arg_489_1.actors_["10093"].transform.childCount - 1 do
					local var_492_0 = arg_489_1.actors_["10093"].transform:GetChild(iter_492_0)

					if var_492_0.name == "" or not string.find(var_492_0.name, "split") then
						var_492_0.gameObject:SetActive(true)
					else
						var_492_0.gameObject:SetActive(false)
					end
				end
			end

			local var_492_1 = 0.001

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_1 then
				arg_489_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos10093, Vector3.New(1500, -345, -245), (arg_489_1.time_ - 0) / var_492_1)
			end

			if arg_489_1.time_ >= 0 + var_492_1 and arg_489_1.time_ < 0 + var_492_1 + arg_492_0 then
				arg_489_1.actors_["10093"].transform.localPosition = Vector3.New(1500, -345, -245)
			end

			local var_492_2 = arg_489_1.actors_["10097"].transform

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.var_.moveOldPos10097 = var_492_2.localPosition
				var_492_2.localScale = Vector3.New(1, 1, 1)

				arg_489_1:CheckSpriteTmpPos("10097", 7)

				for iter_492_1 = 0, var_492_2.childCount - 1 do
					local var_492_3 = var_492_2:GetChild(iter_492_1)

					if var_492_3.name == "" or not string.find(var_492_3.name, "split") then
						var_492_3.gameObject:SetActive(true)
					else
						var_492_3.gameObject:SetActive(false)
					end
				end
			end

			local var_492_4 = 0.001

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_4 then
				var_492_2.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos10097, Vector3.New(0, -2000, -180), (arg_489_1.time_ - 0) / var_492_4)
			end

			if arg_489_1.time_ >= 0 + var_492_4 and arg_489_1.time_ < 0 + var_492_4 + arg_492_0 then
				var_492_2.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_492_5 = arg_489_1.actors_["10093"]

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(var_492_5) and arg_489_1.var_.actorSpriteComps10093 == nil then
				arg_489_1.var_.actorSpriteComps10093 = var_492_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_492_6 = 2

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_6 and not isNil(var_492_5) then
				if arg_489_1.var_.actorSpriteComps10093 then
					for iter_492_2, iter_492_3 in pairs(arg_489_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_492_3 then
							if arg_489_1.isInRecall_ then
								iter_492_3.color = Color.New(Mathf.Lerp(iter_492_3.color.r, arg_489_1.hightColor2.r, (arg_489_1.time_ - 0) / var_492_6), Mathf.Lerp(iter_492_3.color.g, arg_489_1.hightColor2.g, (arg_489_1.time_ - 0) / var_492_6), (Mathf.Lerp(iter_492_3.color.b, arg_489_1.hightColor2.b, (arg_489_1.time_ - 0) / var_492_6)))
							else
								local var_492_7 = Mathf.Lerp(iter_492_3.color.r, 0.5, (arg_489_1.time_ - 0) / var_492_6)

								iter_492_3.color = Color.New(var_492_7, var_492_7, var_492_7)
							end
						end
					end
				end
			end

			if arg_489_1.time_ >= 0 + var_492_6 and arg_489_1.time_ < 0 + var_492_6 + arg_492_0 and not isNil(var_492_5) and arg_489_1.var_.actorSpriteComps10093 then
				for iter_492_4, iter_492_5 in pairs(arg_489_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_492_5 then
						iter_492_5.color = arg_489_1.isInRecall_ and (arg_489_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_489_1.var_.actorSpriteComps10093 = nil
			end

			local var_492_8 = arg_489_1.actors_["10093"]

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 and not isNil(var_492_8) and arg_489_1.var_.actorSpriteComps10093 == nil then
				arg_489_1.var_.actorSpriteComps10093 = var_492_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_492_9 = 2

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_9 and not isNil(var_492_8) then
				if arg_489_1.var_.actorSpriteComps10093 then
					for iter_492_6, iter_492_7 in pairs(arg_489_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_492_7 then
							if arg_489_1.isInRecall_ then
								iter_492_7.color = Color.New(Mathf.Lerp(iter_492_7.color.r, arg_489_1.hightColor2.r, (arg_489_1.time_ - 0) / var_492_9), Mathf.Lerp(iter_492_7.color.g, arg_489_1.hightColor2.g, (arg_489_1.time_ - 0) / var_492_9), (Mathf.Lerp(iter_492_7.color.b, arg_489_1.hightColor2.b, (arg_489_1.time_ - 0) / var_492_9)))
							else
								local var_492_10 = Mathf.Lerp(iter_492_7.color.r, 0.5, (arg_489_1.time_ - 0) / var_492_9)

								iter_492_7.color = Color.New(var_492_10, var_492_10, var_492_10)
							end
						end
					end
				end
			end

			if arg_489_1.time_ >= 0 + var_492_9 and arg_489_1.time_ < 0 + var_492_9 + arg_492_0 and not isNil(var_492_8) and arg_489_1.var_.actorSpriteComps10093 then
				for iter_492_8, iter_492_9 in pairs(arg_489_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_492_9 then
						iter_492_9.color = arg_489_1.isInRecall_ and (arg_489_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_489_1.var_.actorSpriteComps10093 = nil
			end

			local var_492_11 = 0
			local var_492_12 = 0.95

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_11 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_13 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(413091117).content)

				arg_489_1.text_.text = var_492_13

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_15 = 38 <= 0 and var_492_12 or var_492_12 * (utf8.len(var_492_13) / 38)

				if (38 <= 0 and var_492_12 or var_492_12 * (utf8.len(var_492_13) / 38)) > 0 and var_492_12 < var_492_15 then
					arg_489_1.talkMaxDuration = var_492_15

					if var_492_15 + var_492_11 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_15 + var_492_11
					end
				end

				arg_489_1.text_.text = var_492_13
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_16 = math.max(var_492_12, arg_489_1.talkMaxDuration)

			if var_492_11 <= arg_489_1.time_ and arg_489_1.time_ < var_492_11 + var_492_16 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_11) / var_492_16

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_11 + var_492_16 and arg_489_1.time_ < var_492_11 + var_492_16 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
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
				actorName = "10097",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play413091118 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 413091118
		arg_493_1.duration_ = 11.93

		local var_493_0 = {
			zh = 7.766,
			ja = 11.933
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play413091119(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos10093 = arg_493_1.actors_["10093"].transform.localPosition
				arg_493_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_493_1:CheckSpriteTmpPos("10093", 3)

				for iter_496_0 = 0, arg_493_1.actors_["10093"].transform.childCount - 1 do
					local var_496_0 = arg_493_1.actors_["10093"].transform:GetChild(iter_496_0)

					if var_496_0.name == "split_4" or not string.find(var_496_0.name, "split") then
						var_496_0.gameObject:SetActive(true)
					else
						var_496_0.gameObject:SetActive(false)
					end
				end
			end

			local var_496_1 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_1 then
				arg_493_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos10093, Vector3.New(0, -345, -245), (arg_493_1.time_ - 0) / var_496_1)
			end

			if arg_493_1.time_ >= 0 + var_496_1 and arg_493_1.time_ < 0 + var_496_1 + arg_496_0 then
				arg_493_1.actors_["10093"].transform.localPosition = Vector3.New(0, -345, -245)
			end

			local var_496_2 = arg_493_1.actors_["10093"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_2) and arg_493_1.var_.actorSpriteComps10093 == nil then
				arg_493_1.var_.actorSpriteComps10093 = var_496_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_496_3 = 2

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_3 and not isNil(var_496_2) then
				if arg_493_1.var_.actorSpriteComps10093 then
					for iter_496_1, iter_496_2 in pairs(arg_493_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_496_2 then
							if arg_493_1.isInRecall_ then
								iter_496_2.color = Color.New(Mathf.Lerp(iter_496_2.color.r, arg_493_1.hightColor1.r, (arg_493_1.time_ - 0) / var_496_3), Mathf.Lerp(iter_496_2.color.g, arg_493_1.hightColor1.g, (arg_493_1.time_ - 0) / var_496_3), (Mathf.Lerp(iter_496_2.color.b, arg_493_1.hightColor1.b, (arg_493_1.time_ - 0) / var_496_3)))
							else
								local var_496_4 = Mathf.Lerp(iter_496_2.color.r, 1, (arg_493_1.time_ - 0) / var_496_3)

								iter_496_2.color = Color.New(var_496_4, var_496_4, var_496_4)
							end
						end
					end
				end
			end

			if arg_493_1.time_ >= 0 + var_496_3 and arg_493_1.time_ < 0 + var_496_3 + arg_496_0 and not isNil(var_496_2) and arg_493_1.var_.actorSpriteComps10093 then
				for iter_496_3, iter_496_4 in pairs(arg_493_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_496_4 then
						iter_496_4.color = arg_493_1.isInRecall_ and (arg_493_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_493_1.var_.actorSpriteComps10093 = nil
			end

			local var_496_5 = 0
			local var_496_6 = 0.875

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_5 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_7 = arg_493_1:GetWordFromCfg(413091118)
				local var_496_8 = arg_493_1:FormatText(var_496_7.content)

				arg_493_1.text_.text = var_496_8

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_10 = 35 <= 0 and var_496_6 or var_496_6 * (utf8.len(var_496_8) / 35)

				if (35 <= 0 and var_496_6 or var_496_6 * (utf8.len(var_496_8) / 35)) > 0 and var_496_6 < var_496_10 then
					arg_493_1.talkMaxDuration = var_496_10

					if var_496_10 + var_496_5 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_10 + var_496_5
					end
				end

				arg_493_1.text_.text = var_496_8
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091118", "story_v_out_413091.awb") ~= 0 then
					local var_496_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091118", "story_v_out_413091.awb") / 1000

					if var_496_11 + var_496_5 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_11 + var_496_5
					end

					if var_496_7.prefab_name ~= "" and arg_493_1.actors_[var_496_7.prefab_name] ~= nil then
						local var_496_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_7.prefab_name].transform, "story_v_out_413091", "413091118", "story_v_out_413091.awb")

						arg_493_1:RecordAudio("413091118", var_496_12)
						arg_493_1:RecordAudio("413091118", var_496_12)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_out_413091", "413091118", "story_v_out_413091.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_out_413091", "413091118", "story_v_out_413091.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_13 = math.max(var_496_6, arg_493_1.talkMaxDuration)

			if var_496_5 <= arg_493_1.time_ and arg_493_1.time_ < var_496_5 + var_496_13 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_5) / var_496_13

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_5 + var_496_13 and arg_493_1.time_ < var_496_5 + var_496_13 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
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

		arg_493_1:InitPlayNodeList()
	end,
	Play413091119 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 413091119
		arg_497_1.duration_ = 5.6

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play413091120(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.var_.moveOldPos10093 = arg_497_1.actors_["10093"].transform.localPosition
				arg_497_1.actors_["10093"].transform.localScale = Vector3.New(1, 1, 1)

				arg_497_1:CheckSpriteTmpPos("10093", 7)

				for iter_500_0 = 0, arg_497_1.actors_["10093"].transform.childCount - 1 do
					local var_500_0 = arg_497_1.actors_["10093"].transform:GetChild(iter_500_0)

					if var_500_0.name == "split_4" or not string.find(var_500_0.name, "split") then
						var_500_0.gameObject:SetActive(true)
					else
						var_500_0.gameObject:SetActive(false)
					end
				end
			end

			local var_500_1 = 0.001

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_1 then
				arg_497_1.actors_["10093"].transform.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_497_1.time_ - 0) / var_500_1)
			end

			if arg_497_1.time_ >= 0 + var_500_1 and arg_497_1.time_ < 0 + var_500_1 + arg_500_0 then
				arg_497_1.actors_["10093"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_500_2 = 0

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_2 + arg_500_0 then
				arg_497_1.allBtn_.enabled = false
			end

			if arg_497_1.time_ >= var_500_2 + 0.6 and arg_497_1.time_ < var_500_2 + 0.6 + arg_500_0 then
				arg_497_1.allBtn_.enabled = true
			end

			local var_500_3 = manager.ui.mainCamera.transform

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.var_.shakeOldPos = var_500_3.localPosition
			end

			local var_500_4 = 0.6

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_4 then
				local var_500_5, var_500_6 = math.modf((arg_497_1.time_ - 0) / 0.066)

				var_500_3.localPosition = Vector3.New(var_500_6 * 0.13, var_500_6 * 0.13, var_500_6 * 0.13) + arg_497_1.var_.shakeOldPos
			end

			if arg_497_1.time_ >= 0 + var_500_4 and arg_497_1.time_ < 0 + var_500_4 + arg_500_0 then
				var_500_3.localPosition = arg_497_1.var_.shakeOldPos
			end

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1:AudioAction("play", "effect", "se_story_135_01", "se_story_135_01_shiphit", "")
			end

			if arg_497_1.frameCnt_ <= 1 then
				arg_497_1.dialog_:SetActive(false)
			end

			local var_500_8 = 0.6
			local var_500_9 = 1.075

			if 0.6 < arg_497_1.time_ and arg_497_1.time_ <= var_500_8 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0

				arg_497_1.dialog_:SetActive(true)

				arg_497_1.dialogCg_.alpha = 0

				local var_500_10 = LeanTween.value(arg_497_1.dialog_, 0, 1, 0.3)

				var_500_10:setOnUpdate(LuaHelper.FloatAction(function(arg_501_0)
					arg_497_1.dialogCg_.alpha = arg_501_0
				end))
				var_500_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_497_1.dialog_)
					var_500_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_497_1.duration_ = arg_497_1.duration_ + 0.3

				SetActive(arg_497_1.leftNameGo_, false)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_11 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(413091119).content)

				arg_497_1.text_.text = var_500_11

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_13 = 43 <= 0 and var_500_9 or var_500_9 * (utf8.len(var_500_11) / 43)

				if (43 <= 0 and var_500_9 or var_500_9 * (utf8.len(var_500_11) / 43)) > 0 and var_500_9 < var_500_13 then
					arg_497_1.talkMaxDuration = var_500_13
					var_500_8 = var_500_8 + 0.3

					if var_500_13 + var_500_8 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_13 + var_500_8
					end
				end

				arg_497_1.text_.text = var_500_11
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_14 = var_500_8 + 0.3
			local var_500_15 = math.max(var_500_9, arg_497_1.talkMaxDuration)

			if var_500_8 + 0.3 <= arg_497_1.time_ and arg_497_1.time_ < var_500_14 + var_500_15 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_14) / var_500_15

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_14 + var_500_15 and arg_497_1.time_ < var_500_14 + var_500_15 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {
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

		arg_497_1:InitPlayNodeList()
	end,
	Play413091120 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 413091120
		arg_503_1.duration_ = 7.87

		local var_503_0 = {
			zh = 7.866,
			ja = 7.633
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
				arg_503_0:Play413091121(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 then
				arg_503_1.var_.moveOldPos10097 = arg_503_1.actors_["10097"].transform.localPosition
				arg_503_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_503_1:CheckSpriteTmpPos("10097", 3)

				for iter_506_0 = 0, arg_503_1.actors_["10097"].transform.childCount - 1 do
					local var_506_0 = arg_503_1.actors_["10097"].transform:GetChild(iter_506_0)

					if var_506_0.name == "split_4" or not string.find(var_506_0.name, "split") then
						var_506_0.gameObject:SetActive(true)
					else
						var_506_0.gameObject:SetActive(false)
					end
				end
			end

			local var_506_1 = 0.001

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_1 then
				arg_503_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_503_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_503_1.time_ - 0) / var_506_1)
			end

			if arg_503_1.time_ >= 0 + var_506_1 and arg_503_1.time_ < 0 + var_506_1 + arg_506_0 then
				arg_503_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_506_2 = arg_503_1.actors_["10097"]

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(var_506_2) and arg_503_1.var_.actorSpriteComps10097 == nil then
				arg_503_1.var_.actorSpriteComps10097 = var_506_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_506_3 = 2

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_3 and not isNil(var_506_2) then
				if arg_503_1.var_.actorSpriteComps10097 then
					for iter_506_1, iter_506_2 in pairs(arg_503_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_506_2 then
							if arg_503_1.isInRecall_ then
								iter_506_2.color = Color.New(Mathf.Lerp(iter_506_2.color.r, arg_503_1.hightColor1.r, (arg_503_1.time_ - 0) / var_506_3), Mathf.Lerp(iter_506_2.color.g, arg_503_1.hightColor1.g, (arg_503_1.time_ - 0) / var_506_3), (Mathf.Lerp(iter_506_2.color.b, arg_503_1.hightColor1.b, (arg_503_1.time_ - 0) / var_506_3)))
							else
								local var_506_4 = Mathf.Lerp(iter_506_2.color.r, 1, (arg_503_1.time_ - 0) / var_506_3)

								iter_506_2.color = Color.New(var_506_4, var_506_4, var_506_4)
							end
						end
					end
				end
			end

			if arg_503_1.time_ >= 0 + var_506_3 and arg_503_1.time_ < 0 + var_506_3 + arg_506_0 and not isNil(var_506_2) and arg_503_1.var_.actorSpriteComps10097 then
				for iter_506_3, iter_506_4 in pairs(arg_503_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_506_4 then
						iter_506_4.color = arg_503_1.isInRecall_ and (arg_503_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_503_1.var_.actorSpriteComps10097 = nil
			end

			local var_506_5 = 0
			local var_506_6 = 0.325

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_5 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_7 = arg_503_1:GetWordFromCfg(413091120)
				local var_506_8 = arg_503_1:FormatText(var_506_7.content)

				arg_503_1.text_.text = var_506_8

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_10 = 13 <= 0 and var_506_6 or var_506_6 * (utf8.len(var_506_8) / 13)

				if (13 <= 0 and var_506_6 or var_506_6 * (utf8.len(var_506_8) / 13)) > 0 and var_506_6 < var_506_10 then
					arg_503_1.talkMaxDuration = var_506_10

					if var_506_10 + var_506_5 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_10 + var_506_5
					end
				end

				arg_503_1.text_.text = var_506_8
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091120", "story_v_out_413091.awb") ~= 0 then
					local var_506_11 = manager.audio:GetVoiceLength("story_v_out_413091", "413091120", "story_v_out_413091.awb") / 1000

					if var_506_11 + var_506_5 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_11 + var_506_5
					end

					if var_506_7.prefab_name ~= "" and arg_503_1.actors_[var_506_7.prefab_name] ~= nil then
						local var_506_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_7.prefab_name].transform, "story_v_out_413091", "413091120", "story_v_out_413091.awb")

						arg_503_1:RecordAudio("413091120", var_506_12)
						arg_503_1:RecordAudio("413091120", var_506_12)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_413091", "413091120", "story_v_out_413091.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_413091", "413091120", "story_v_out_413091.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_13 = math.max(var_506_6, arg_503_1.talkMaxDuration)

			if var_506_5 <= arg_503_1.time_ and arg_503_1.time_ < var_506_5 + var_506_13 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_5) / var_506_13

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_5 + var_506_13 and arg_503_1.time_ < var_506_5 + var_506_13 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {
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

		arg_503_1:InitPlayNodeList()
	end,
	Play413091121 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 413091121
		arg_507_1.duration_ = 4.6

		local var_507_0 = {
			zh = 4.6,
			ja = 3.933
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
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play413091122(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.var_.moveOldPos10097 = arg_507_1.actors_["10097"].transform.localPosition
				arg_507_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_507_1:CheckSpriteTmpPos("10097", 2)

				for iter_510_0 = 0, arg_507_1.actors_["10097"].transform.childCount - 1 do
					local var_510_0 = arg_507_1.actors_["10097"].transform:GetChild(iter_510_0)

					if var_510_0.name == "split_4" or not string.find(var_510_0.name, "split") then
						var_510_0.gameObject:SetActive(true)
					else
						var_510_0.gameObject:SetActive(false)
					end
				end
			end

			local var_510_1 = 0.001

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_1 then
				arg_507_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_507_1.time_ - 0) / var_510_1)
			end

			if arg_507_1.time_ >= 0 + var_510_1 and arg_507_1.time_ < 0 + var_510_1 + arg_510_0 then
				arg_507_1.actors_["10097"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_510_2 = arg_507_1.actors_["10093"].transform

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.var_.moveOldPos10093 = var_510_2.localPosition
				var_510_2.localScale = Vector3.New(1, 1, 1)

				arg_507_1:CheckSpriteTmpPos("10093", 4)

				for iter_510_1 = 0, var_510_2.childCount - 1 do
					local var_510_3 = var_510_2:GetChild(iter_510_1)

					if var_510_3.name == "split_5" or not string.find(var_510_3.name, "split") then
						var_510_3.gameObject:SetActive(true)
					else
						var_510_3.gameObject:SetActive(false)
					end
				end
			end

			local var_510_4 = 0.001

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_4 then
				var_510_2.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos10093, Vector3.New(390, -345, -245), (arg_507_1.time_ - 0) / var_510_4)
			end

			if arg_507_1.time_ >= 0 + var_510_4 and arg_507_1.time_ < 0 + var_510_4 + arg_510_0 then
				var_510_2.localPosition = Vector3.New(390, -345, -245)
			end

			local var_510_5 = arg_507_1.actors_["10097"]

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(var_510_5) and arg_507_1.var_.actorSpriteComps10097 == nil then
				arg_507_1.var_.actorSpriteComps10097 = var_510_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_510_6 = 2

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_6 and not isNil(var_510_5) then
				if arg_507_1.var_.actorSpriteComps10097 then
					for iter_510_2, iter_510_3 in pairs(arg_507_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_510_3 then
							if arg_507_1.isInRecall_ then
								iter_510_3.color = Color.New(Mathf.Lerp(iter_510_3.color.r, arg_507_1.hightColor2.r, (arg_507_1.time_ - 0) / var_510_6), Mathf.Lerp(iter_510_3.color.g, arg_507_1.hightColor2.g, (arg_507_1.time_ - 0) / var_510_6), (Mathf.Lerp(iter_510_3.color.b, arg_507_1.hightColor2.b, (arg_507_1.time_ - 0) / var_510_6)))
							else
								local var_510_7 = Mathf.Lerp(iter_510_3.color.r, 0.5, (arg_507_1.time_ - 0) / var_510_6)

								iter_510_3.color = Color.New(var_510_7, var_510_7, var_510_7)
							end
						end
					end
				end
			end

			if arg_507_1.time_ >= 0 + var_510_6 and arg_507_1.time_ < 0 + var_510_6 + arg_510_0 and not isNil(var_510_5) and arg_507_1.var_.actorSpriteComps10097 then
				for iter_510_4, iter_510_5 in pairs(arg_507_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_510_5 then
						iter_510_5.color = arg_507_1.isInRecall_ and (arg_507_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_507_1.var_.actorSpriteComps10097 = nil
			end

			local var_510_8 = arg_507_1.actors_["10093"]

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(var_510_8) and arg_507_1.var_.actorSpriteComps10093 == nil then
				arg_507_1.var_.actorSpriteComps10093 = var_510_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_510_9 = 2

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_9 and not isNil(var_510_8) then
				if arg_507_1.var_.actorSpriteComps10093 then
					for iter_510_6, iter_510_7 in pairs(arg_507_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_510_7 then
							if arg_507_1.isInRecall_ then
								iter_510_7.color = Color.New(Mathf.Lerp(iter_510_7.color.r, arg_507_1.hightColor1.r, (arg_507_1.time_ - 0) / var_510_9), Mathf.Lerp(iter_510_7.color.g, arg_507_1.hightColor1.g, (arg_507_1.time_ - 0) / var_510_9), (Mathf.Lerp(iter_510_7.color.b, arg_507_1.hightColor1.b, (arg_507_1.time_ - 0) / var_510_9)))
							else
								local var_510_10 = Mathf.Lerp(iter_510_7.color.r, 1, (arg_507_1.time_ - 0) / var_510_9)

								iter_510_7.color = Color.New(var_510_10, var_510_10, var_510_10)
							end
						end
					end
				end
			end

			if arg_507_1.time_ >= 0 + var_510_9 and arg_507_1.time_ < 0 + var_510_9 + arg_510_0 and not isNil(var_510_8) and arg_507_1.var_.actorSpriteComps10093 then
				for iter_510_8, iter_510_9 in pairs(arg_507_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_510_9 then
						iter_510_9.color = arg_507_1.isInRecall_ and (arg_507_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_507_1.var_.actorSpriteComps10093 = nil
			end

			local var_510_11 = 0
			local var_510_12 = 0.5

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_11 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_13 = arg_507_1:GetWordFromCfg(413091121)
				local var_510_14 = arg_507_1:FormatText(var_510_13.content)

				arg_507_1.text_.text = var_510_14

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_16 = 21 <= 0 and var_510_12 or var_510_12 * (utf8.len(var_510_14) / 21)

				if (21 <= 0 and var_510_12 or var_510_12 * (utf8.len(var_510_14) / 21)) > 0 and var_510_12 < var_510_16 then
					arg_507_1.talkMaxDuration = var_510_16

					if var_510_16 + var_510_11 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_16 + var_510_11
					end
				end

				arg_507_1.text_.text = var_510_14
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091121", "story_v_out_413091.awb") ~= 0 then
					local var_510_17 = manager.audio:GetVoiceLength("story_v_out_413091", "413091121", "story_v_out_413091.awb") / 1000

					if var_510_17 + var_510_11 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_17 + var_510_11
					end

					if var_510_13.prefab_name ~= "" and arg_507_1.actors_[var_510_13.prefab_name] ~= nil then
						local var_510_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_13.prefab_name].transform, "story_v_out_413091", "413091121", "story_v_out_413091.awb")

						arg_507_1:RecordAudio("413091121", var_510_18)
						arg_507_1:RecordAudio("413091121", var_510_18)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_413091", "413091121", "story_v_out_413091.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_413091", "413091121", "story_v_out_413091.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_19 = math.max(var_510_12, arg_507_1.talkMaxDuration)

			if var_510_11 <= arg_507_1.time_ and arg_507_1.time_ < var_510_11 + var_510_19 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_11) / var_510_19

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_11 + var_510_19 and arg_507_1.time_ < var_510_11 + var_510_19 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
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
				actorName = "10093",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_507_1:InitPlayNodeList()
	end,
	Play413091122 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 413091122
		arg_511_1.duration_ = 15.5

		local var_511_0 = {
			zh = 11.033,
			ja = 15.5
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
				arg_511_0:Play413091123(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 then
				arg_511_1.var_.moveOldPos10097 = arg_511_1.actors_["10097"].transform.localPosition
				arg_511_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_511_1:CheckSpriteTmpPos("10097", 2)

				for iter_514_0 = 0, arg_511_1.actors_["10097"].transform.childCount - 1 do
					local var_514_0 = arg_511_1.actors_["10097"].transform:GetChild(iter_514_0)

					if var_514_0.name == "split_2" or not string.find(var_514_0.name, "split") then
						var_514_0.gameObject:SetActive(true)
					else
						var_514_0.gameObject:SetActive(false)
					end
				end
			end

			local var_514_1 = 0.001

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_1 then
				arg_511_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos10097, Vector3.New(-390, -350, -180), (arg_511_1.time_ - 0) / var_514_1)
			end

			if arg_511_1.time_ >= 0 + var_514_1 and arg_511_1.time_ < 0 + var_514_1 + arg_514_0 then
				arg_511_1.actors_["10097"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_514_2 = arg_511_1.actors_["10097"]

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(var_514_2) and arg_511_1.var_.actorSpriteComps10097 == nil then
				arg_511_1.var_.actorSpriteComps10097 = var_514_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_514_3 = 2

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_3 and not isNil(var_514_2) then
				if arg_511_1.var_.actorSpriteComps10097 then
					for iter_514_1, iter_514_2 in pairs(arg_511_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_514_2 then
							if arg_511_1.isInRecall_ then
								iter_514_2.color = Color.New(Mathf.Lerp(iter_514_2.color.r, arg_511_1.hightColor1.r, (arg_511_1.time_ - 0) / var_514_3), Mathf.Lerp(iter_514_2.color.g, arg_511_1.hightColor1.g, (arg_511_1.time_ - 0) / var_514_3), (Mathf.Lerp(iter_514_2.color.b, arg_511_1.hightColor1.b, (arg_511_1.time_ - 0) / var_514_3)))
							else
								local var_514_4 = Mathf.Lerp(iter_514_2.color.r, 1, (arg_511_1.time_ - 0) / var_514_3)

								iter_514_2.color = Color.New(var_514_4, var_514_4, var_514_4)
							end
						end
					end
				end
			end

			if arg_511_1.time_ >= 0 + var_514_3 and arg_511_1.time_ < 0 + var_514_3 + arg_514_0 and not isNil(var_514_2) and arg_511_1.var_.actorSpriteComps10097 then
				for iter_514_3, iter_514_4 in pairs(arg_511_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_514_4 then
						iter_514_4.color = arg_511_1.isInRecall_ and (arg_511_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_511_1.var_.actorSpriteComps10097 = nil
			end

			local var_514_5 = arg_511_1.actors_["10093"]

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(var_514_5) and arg_511_1.var_.actorSpriteComps10093 == nil then
				arg_511_1.var_.actorSpriteComps10093 = var_514_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_514_6 = 0.2

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_6 and not isNil(var_514_5) then
				if arg_511_1.var_.actorSpriteComps10093 then
					for iter_514_5, iter_514_6 in pairs(arg_511_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_514_6 then
							if arg_511_1.isInRecall_ then
								iter_514_6.color = Color.New(Mathf.Lerp(iter_514_6.color.r, arg_511_1.hightColor2.r, (arg_511_1.time_ - 0) / var_514_6), Mathf.Lerp(iter_514_6.color.g, arg_511_1.hightColor2.g, (arg_511_1.time_ - 0) / var_514_6), (Mathf.Lerp(iter_514_6.color.b, arg_511_1.hightColor2.b, (arg_511_1.time_ - 0) / var_514_6)))
							else
								local var_514_7 = Mathf.Lerp(iter_514_6.color.r, 0.5, (arg_511_1.time_ - 0) / var_514_6)

								iter_514_6.color = Color.New(var_514_7, var_514_7, var_514_7)
							end
						end
					end
				end
			end

			if arg_511_1.time_ >= 0 + var_514_6 and arg_511_1.time_ < 0 + var_514_6 + arg_514_0 and not isNil(var_514_5) and arg_511_1.var_.actorSpriteComps10093 then
				for iter_514_7, iter_514_8 in pairs(arg_511_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_514_8 then
						iter_514_8.color = arg_511_1.isInRecall_ and (arg_511_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_511_1.var_.actorSpriteComps10093 = nil
			end

			local var_514_8 = 0
			local var_514_9 = 0.825

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_8 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_10 = arg_511_1:GetWordFromCfg(413091122)
				local var_514_11 = arg_511_1:FormatText(var_514_10.content)

				arg_511_1.text_.text = var_514_11

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_13 = 33 <= 0 and var_514_9 or var_514_9 * (utf8.len(var_514_11) / 33)

				if (33 <= 0 and var_514_9 or var_514_9 * (utf8.len(var_514_11) / 33)) > 0 and var_514_9 < var_514_13 then
					arg_511_1.talkMaxDuration = var_514_13

					if var_514_13 + var_514_8 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_13 + var_514_8
					end
				end

				arg_511_1.text_.text = var_514_11
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091122", "story_v_out_413091.awb") ~= 0 then
					local var_514_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091122", "story_v_out_413091.awb") / 1000

					if var_514_14 + var_514_8 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_14 + var_514_8
					end

					if var_514_10.prefab_name ~= "" and arg_511_1.actors_[var_514_10.prefab_name] ~= nil then
						local var_514_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_10.prefab_name].transform, "story_v_out_413091", "413091122", "story_v_out_413091.awb")

						arg_511_1:RecordAudio("413091122", var_514_15)
						arg_511_1:RecordAudio("413091122", var_514_15)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_413091", "413091122", "story_v_out_413091.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_413091", "413091122", "story_v_out_413091.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_16 = math.max(var_514_9, arg_511_1.talkMaxDuration)

			if var_514_8 <= arg_511_1.time_ and arg_511_1.time_ < var_514_8 + var_514_16 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_8) / var_514_16

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_8 + var_514_16 and arg_511_1.time_ < var_514_8 + var_514_16 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
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

		arg_511_1:InitPlayNodeList()
	end,
	Play413091123 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 413091123
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play413091124(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(arg_515_1.actors_["10097"]) and arg_515_1.var_.actorSpriteComps10097 == nil then
				arg_515_1.var_.actorSpriteComps10097 = arg_515_1.actors_["10097"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_518_0 = 0.2

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 and not isNil(arg_515_1.actors_["10097"]) then
				if arg_515_1.var_.actorSpriteComps10097 then
					for iter_518_0, iter_518_1 in pairs(arg_515_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_518_1 then
							if arg_515_1.isInRecall_ then
								iter_518_1.color = Color.New(Mathf.Lerp(iter_518_1.color.r, arg_515_1.hightColor2.r, (arg_515_1.time_ - 0) / var_518_0), Mathf.Lerp(iter_518_1.color.g, arg_515_1.hightColor2.g, (arg_515_1.time_ - 0) / var_518_0), (Mathf.Lerp(iter_518_1.color.b, arg_515_1.hightColor2.b, (arg_515_1.time_ - 0) / var_518_0)))
							else
								local var_518_1 = Mathf.Lerp(iter_518_1.color.r, 0.5, (arg_515_1.time_ - 0) / var_518_0)

								iter_518_1.color = Color.New(var_518_1, var_518_1, var_518_1)
							end
						end
					end
				end
			end

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 and not isNil(arg_515_1.actors_["10097"]) and arg_515_1.var_.actorSpriteComps10097 then
				for iter_518_2, iter_518_3 in pairs(arg_515_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_518_3 then
						iter_518_3.color = arg_515_1.isInRecall_ and (arg_515_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_515_1.var_.actorSpriteComps10097 = nil
			end

			local var_518_2 = arg_515_1.actors_["10097"].transform

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos10097 = var_518_2.localPosition
				var_518_2.localScale = Vector3.New(1, 1, 1)

				arg_515_1:CheckSpriteTmpPos("10097", 7)

				for iter_518_4 = 0, var_518_2.childCount - 1 do
					local var_518_3 = var_518_2:GetChild(iter_518_4)

					if var_518_3.name == "split_2" or not string.find(var_518_3.name, "split") then
						var_518_3.gameObject:SetActive(true)
					else
						var_518_3.gameObject:SetActive(false)
					end
				end
			end

			local var_518_4 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_4 then
				var_518_2.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos10097, Vector3.New(0, -2000, -180), (arg_515_1.time_ - 0) / var_518_4)
			end

			if arg_515_1.time_ >= 0 + var_518_4 and arg_515_1.time_ < 0 + var_518_4 + arg_518_0 then
				var_518_2.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_518_5 = arg_515_1.actors_["10093"].transform

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos10093 = var_518_5.localPosition
				var_518_5.localScale = Vector3.New(1, 1, 1)

				arg_515_1:CheckSpriteTmpPos("10093", 7)

				for iter_518_5 = 0, var_518_5.childCount - 1 do
					local var_518_6 = var_518_5:GetChild(iter_518_5)

					if var_518_6.name == "split_3" or not string.find(var_518_6.name, "split") then
						var_518_6.gameObject:SetActive(true)
					else
						var_518_6.gameObject:SetActive(false)
					end
				end
			end

			local var_518_7 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_7 then
				var_518_5.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_515_1.time_ - 0) / var_518_7)
			end

			if arg_515_1.time_ >= 0 + var_518_7 and arg_515_1.time_ < 0 + var_518_7 + arg_518_0 then
				var_518_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_518_8 = 0
			local var_518_9 = 0.75

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_8 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, false)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_10 = arg_515_1:FormatText(arg_515_1:GetWordFromCfg(413091123).content)

				arg_515_1.text_.text = var_518_10

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_12 = 30 <= 0 and var_518_9 or var_518_9 * (utf8.len(var_518_10) / 30)

				if (30 <= 0 and var_518_9 or var_518_9 * (utf8.len(var_518_10) / 30)) > 0 and var_518_9 < var_518_12 then
					arg_515_1.talkMaxDuration = var_518_12

					if var_518_12 + var_518_8 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_12 + var_518_8
					end
				end

				arg_515_1.text_.text = var_518_10
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_13 = math.max(var_518_9, arg_515_1.talkMaxDuration)

			if var_518_8 <= arg_515_1.time_ and arg_515_1.time_ < var_518_8 + var_518_13 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_8) / var_518_13

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_8 + var_518_13 and arg_515_1.time_ < var_518_8 + var_518_13 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
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
				actorName = "10093",
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
	Play413091124 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 413091124
		arg_519_1.duration_ = 5.97

		local var_519_0 = {
			zh = 5.966,
			ja = 4.933
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play413091125(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos10097 = arg_519_1.actors_["10097"].transform.localPosition
				arg_519_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_519_1:CheckSpriteTmpPos("10097", 3)

				for iter_522_0 = 0, arg_519_1.actors_["10097"].transform.childCount - 1 do
					local var_522_0 = arg_519_1.actors_["10097"].transform:GetChild(iter_522_0)

					if var_522_0.name == "split_3" or not string.find(var_522_0.name, "split") then
						var_522_0.gameObject:SetActive(true)
					else
						var_522_0.gameObject:SetActive(false)
					end
				end
			end

			local var_522_1 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_1 then
				arg_519_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10097, Vector3.New(0, -350, -180), (arg_519_1.time_ - 0) / var_522_1)
			end

			if arg_519_1.time_ >= 0 + var_522_1 and arg_519_1.time_ < 0 + var_522_1 + arg_522_0 then
				arg_519_1.actors_["10097"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			local var_522_2 = arg_519_1.actors_["10097"]

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(var_522_2) and arg_519_1.var_.actorSpriteComps10097 == nil then
				arg_519_1.var_.actorSpriteComps10097 = var_522_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_522_3 = 2

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_3 and not isNil(var_522_2) then
				if arg_519_1.var_.actorSpriteComps10097 then
					for iter_522_1, iter_522_2 in pairs(arg_519_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_522_2 then
							if arg_519_1.isInRecall_ then
								iter_522_2.color = Color.New(Mathf.Lerp(iter_522_2.color.r, arg_519_1.hightColor1.r, (arg_519_1.time_ - 0) / var_522_3), Mathf.Lerp(iter_522_2.color.g, arg_519_1.hightColor1.g, (arg_519_1.time_ - 0) / var_522_3), (Mathf.Lerp(iter_522_2.color.b, arg_519_1.hightColor1.b, (arg_519_1.time_ - 0) / var_522_3)))
							else
								local var_522_4 = Mathf.Lerp(iter_522_2.color.r, 1, (arg_519_1.time_ - 0) / var_522_3)

								iter_522_2.color = Color.New(var_522_4, var_522_4, var_522_4)
							end
						end
					end
				end
			end

			if arg_519_1.time_ >= 0 + var_522_3 and arg_519_1.time_ < 0 + var_522_3 + arg_522_0 and not isNil(var_522_2) and arg_519_1.var_.actorSpriteComps10097 then
				for iter_522_3, iter_522_4 in pairs(arg_519_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_522_4 then
						iter_522_4.color = arg_519_1.isInRecall_ and (arg_519_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_519_1.var_.actorSpriteComps10097 = nil
			end

			local var_522_5 = arg_519_1.actors_["10093"].transform

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.var_.moveOldPos10093 = var_522_5.localPosition
				var_522_5.localScale = Vector3.New(1, 1, 1)

				arg_519_1:CheckSpriteTmpPos("10093", 7)

				for iter_522_5 = 0, var_522_5.childCount - 1 do
					local var_522_6 = var_522_5:GetChild(iter_522_5)

					if var_522_6.name == "split_3" or not string.find(var_522_6.name, "split") then
						var_522_6.gameObject:SetActive(true)
					else
						var_522_6.gameObject:SetActive(false)
					end
				end
			end

			local var_522_7 = 0.001

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_7 then
				var_522_5.localPosition = Vector3.Lerp(arg_519_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_519_1.time_ - 0) / var_522_7)
			end

			if arg_519_1.time_ >= 0 + var_522_7 and arg_519_1.time_ < 0 + var_522_7 + arg_522_0 then
				var_522_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_522_8 = 0
			local var_522_9 = 0.3

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_8 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[1001].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_10 = arg_519_1:GetWordFromCfg(413091124)
				local var_522_11 = arg_519_1:FormatText(var_522_10.content)

				arg_519_1.text_.text = var_522_11

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_13 = 12 <= 0 and var_522_9 or var_522_9 * (utf8.len(var_522_11) / 12)

				if (12 <= 0 and var_522_9 or var_522_9 * (utf8.len(var_522_11) / 12)) > 0 and var_522_9 < var_522_13 then
					arg_519_1.talkMaxDuration = var_522_13

					if var_522_13 + var_522_8 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_13 + var_522_8
					end
				end

				arg_519_1.text_.text = var_522_11
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_413091", "413091124", "story_v_out_413091.awb") ~= 0 then
					local var_522_14 = manager.audio:GetVoiceLength("story_v_out_413091", "413091124", "story_v_out_413091.awb") / 1000

					if var_522_14 + var_522_8 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_14 + var_522_8
					end

					if var_522_10.prefab_name ~= "" and arg_519_1.actors_[var_522_10.prefab_name] ~= nil then
						local var_522_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_10.prefab_name].transform, "story_v_out_413091", "413091124", "story_v_out_413091.awb")

						arg_519_1:RecordAudio("413091124", var_522_15)
						arg_519_1:RecordAudio("413091124", var_522_15)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_413091", "413091124", "story_v_out_413091.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_413091", "413091124", "story_v_out_413091.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_16 = math.max(var_522_9, arg_519_1.talkMaxDuration)

			if var_522_8 <= arg_519_1.time_ and arg_519_1.time_ < var_522_8 + var_522_16 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_8) / var_522_16

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_8 + var_522_16 and arg_519_1.time_ < var_522_8 + var_522_16 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {
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
				actorName = "10093",
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
	Play413091125 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 413091125
		arg_523_1.duration_ = 5.6

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
			arg_523_1.auto_ = false
		end

		function arg_523_1.playNext_(arg_525_0)
			arg_523_1.onStoryFinished_()
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.var_.moveOldPos10097 = arg_523_1.actors_["10097"].transform.localPosition
				arg_523_1.actors_["10097"].transform.localScale = Vector3.New(1, 1, 1)

				arg_523_1:CheckSpriteTmpPos("10097", 7)

				for iter_526_0 = 0, arg_523_1.actors_["10097"].transform.childCount - 1 do
					local var_526_0 = arg_523_1.actors_["10097"].transform:GetChild(iter_526_0)

					if var_526_0.name == "" or not string.find(var_526_0.name, "split") then
						var_526_0.gameObject:SetActive(true)
					else
						var_526_0.gameObject:SetActive(false)
					end
				end
			end

			local var_526_1 = 0.001

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_1 then
				arg_523_1.actors_["10097"].transform.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos10097, Vector3.New(0, -2000, -180), (arg_523_1.time_ - 0) / var_526_1)
			end

			if arg_523_1.time_ >= 0 + var_526_1 and arg_523_1.time_ < 0 + var_526_1 + arg_526_0 then
				arg_523_1.actors_["10097"].transform.localPosition = Vector3.New(0, -2000, -180)
			end

			local var_526_2 = arg_523_1.actors_["10093"].transform

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.var_.moveOldPos10093 = var_526_2.localPosition
				var_526_2.localScale = Vector3.New(1, 1, 1)

				arg_523_1:CheckSpriteTmpPos("10093", 7)

				for iter_526_1 = 0, var_526_2.childCount - 1 do
					local var_526_3 = var_526_2:GetChild(iter_526_1)

					if var_526_3.name == "" or not string.find(var_526_3.name, "split") then
						var_526_3.gameObject:SetActive(true)
					else
						var_526_3.gameObject:SetActive(false)
					end
				end
			end

			local var_526_4 = 0.001

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_4 then
				var_526_2.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos10093, Vector3.New(0, -2000, 0), (arg_523_1.time_ - 0) / var_526_4)
			end

			if arg_523_1.time_ >= 0 + var_526_4 and arg_523_1.time_ < 0 + var_526_4 + arg_526_0 then
				var_526_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_526_5 = arg_523_1.actors_["10097"]

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(var_526_5) and arg_523_1.var_.actorSpriteComps10097 == nil then
				arg_523_1.var_.actorSpriteComps10097 = var_526_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_526_6 = 2

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_6 and not isNil(var_526_5) then
				if arg_523_1.var_.actorSpriteComps10097 then
					for iter_526_2, iter_526_3 in pairs(arg_523_1.var_.actorSpriteComps10097:ToTable()) do
						if iter_526_3 then
							if arg_523_1.isInRecall_ then
								iter_526_3.color = Color.New(Mathf.Lerp(iter_526_3.color.r, arg_523_1.hightColor2.r, (arg_523_1.time_ - 0) / var_526_6), Mathf.Lerp(iter_526_3.color.g, arg_523_1.hightColor2.g, (arg_523_1.time_ - 0) / var_526_6), (Mathf.Lerp(iter_526_3.color.b, arg_523_1.hightColor2.b, (arg_523_1.time_ - 0) / var_526_6)))
							else
								local var_526_7 = Mathf.Lerp(iter_526_3.color.r, 0.5, (arg_523_1.time_ - 0) / var_526_6)

								iter_526_3.color = Color.New(var_526_7, var_526_7, var_526_7)
							end
						end
					end
				end
			end

			if arg_523_1.time_ >= 0 + var_526_6 and arg_523_1.time_ < 0 + var_526_6 + arg_526_0 and not isNil(var_526_5) and arg_523_1.var_.actorSpriteComps10097 then
				for iter_526_4, iter_526_5 in pairs(arg_523_1.var_.actorSpriteComps10097:ToTable()) do
					if iter_526_5 then
						iter_526_5.color = arg_523_1.isInRecall_ and (arg_523_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_523_1.var_.actorSpriteComps10097 = nil
			end

			local var_526_8 = arg_523_1.actors_["10093"]

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(var_526_8) and arg_523_1.var_.actorSpriteComps10093 == nil then
				arg_523_1.var_.actorSpriteComps10093 = var_526_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_526_9 = 2

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_9 and not isNil(var_526_8) then
				if arg_523_1.var_.actorSpriteComps10093 then
					for iter_526_6, iter_526_7 in pairs(arg_523_1.var_.actorSpriteComps10093:ToTable()) do
						if iter_526_7 then
							if arg_523_1.isInRecall_ then
								iter_526_7.color = Color.New(Mathf.Lerp(iter_526_7.color.r, arg_523_1.hightColor2.r, (arg_523_1.time_ - 0) / var_526_9), Mathf.Lerp(iter_526_7.color.g, arg_523_1.hightColor2.g, (arg_523_1.time_ - 0) / var_526_9), (Mathf.Lerp(iter_526_7.color.b, arg_523_1.hightColor2.b, (arg_523_1.time_ - 0) / var_526_9)))
							else
								local var_526_10 = Mathf.Lerp(iter_526_7.color.r, 0.5, (arg_523_1.time_ - 0) / var_526_9)

								iter_526_7.color = Color.New(var_526_10, var_526_10, var_526_10)
							end
						end
					end
				end
			end

			if arg_523_1.time_ >= 0 + var_526_9 and arg_523_1.time_ < 0 + var_526_9 + arg_526_0 and not isNil(var_526_8) and arg_523_1.var_.actorSpriteComps10093 then
				for iter_526_8, iter_526_9 in pairs(arg_523_1.var_.actorSpriteComps10093:ToTable()) do
					if iter_526_9 then
						iter_526_9.color = arg_523_1.isInRecall_ and (arg_523_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_523_1.var_.actorSpriteComps10093 = nil
			end

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1:AudioAction("play", "effect", "se_story_side_1039", "se_story_1039_water", "")
			end

			if arg_523_1.frameCnt_ <= 1 then
				arg_523_1.dialog_:SetActive(false)
			end

			local var_526_12 = 0.6
			local var_526_13 = 0.85

			if 0.6 < arg_523_1.time_ and arg_523_1.time_ <= var_526_12 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0

				arg_523_1.dialog_:SetActive(true)

				arg_523_1.dialogCg_.alpha = 0

				local var_526_14 = LeanTween.value(arg_523_1.dialog_, 0, 1, 0.3)

				var_526_14:setOnUpdate(LuaHelper.FloatAction(function(arg_527_0)
					arg_523_1.dialogCg_.alpha = arg_527_0
				end))
				var_526_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_523_1.dialog_)
					var_526_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_523_1.duration_ = arg_523_1.duration_ + 0.3

				SetActive(arg_523_1.leftNameGo_, false)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_15 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(413091125).content)

				arg_523_1.text_.text = var_526_15

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_17 = 34 <= 0 and var_526_13 or var_526_13 * (utf8.len(var_526_15) / 34)

				if (34 <= 0 and var_526_13 or var_526_13 * (utf8.len(var_526_15) / 34)) > 0 and var_526_13 < var_526_17 then
					arg_523_1.talkMaxDuration = var_526_17
					var_526_12 = var_526_12 + 0.3

					if var_526_17 + var_526_12 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_17 + var_526_12
					end
				end

				arg_523_1.text_.text = var_526_15
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_18 = var_526_12 + 0.3
			local var_526_19 = math.max(var_526_13, arg_523_1.talkMaxDuration)

			if var_526_12 + 0.3 <= arg_523_1.time_ and arg_523_1.time_ < var_526_18 + var_526_19 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_18) / var_526_19

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_18 + var_526_19 and arg_523_1.time_ < var_526_18 + var_526_19 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {
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
				actorName = "10093",
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
	assets = {
		"TextureConfig/Background/F08m",
		"TextureConfig/Background/ST0603a",
		"TextureConfig/Background/F10g"
	},
	voices = {
		"story_v_out_413091.awb"
	}
}
