return {
	Play410041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 410041001
		arg_1_1.duration_ = 5.87

		local var_1_0 = {
			zh = 2.999999999999,
			ja = 5.865999999999
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
				arg_1_0:Play410041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J02f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J02f")
				var_4_0.name = "J02f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J02f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J02f

				arg_1_1.bgs_.J02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J02f" then
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

			local var_4_8 = "10064"

			if arg_1_1.actors_["10064"] == nil then
				local var_4_9 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10064")

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

			local var_4_11 = arg_1_1.actors_["10064"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos10064 = var_4_11.localPosition
				var_4_11.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10064", 3)

				for iter_4_4 = 0, var_4_11.childCount - 1 do
					local var_4_12 = var_4_11:GetChild(iter_4_4)

					if var_4_12.name == "split_3" or not string.find(var_4_12.name, "split") then
						var_4_12.gameObject:SetActive(true)
					else
						var_4_12.gameObject:SetActive(false)
					end
				end
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10064, Vector3.New(0, -570, 192.5), (arg_1_1.time_ - 2) / var_4_13)
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(0, -570, 192.5)
			end

			local var_4_14 = arg_1_1.actors_["10064"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.actorSpriteComps10064 == nil then
				arg_1_1.var_.actorSpriteComps10064 = var_4_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_15 = 0.034

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.actorSpriteComps10064 then
					for iter_4_5, iter_4_6 in pairs(arg_1_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_4_6 then
							if arg_1_1.isInRecall_ then
								iter_4_6.color = Color.New(Mathf.Lerp(iter_4_6.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 2) / var_4_15), Mathf.Lerp(iter_4_6.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 2) / var_4_15), (Mathf.Lerp(iter_4_6.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 2) / var_4_15)))
							else
								local var_4_16 = Mathf.Lerp(iter_4_6.color.r, 1, (arg_1_1.time_ - 2) / var_4_15)

								iter_4_6.color = Color.New(var_4_16, var_4_16, var_4_16)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.actorSpriteComps10064 then
				for iter_4_7, iter_4_8 in pairs(arg_1_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_4_8 then
						iter_4_8.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10064 = nil
			end

			local var_4_17 = 0

			arg_1_1.isInRecall_ = false

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_4_9, iter_4_10 in pairs(arg_1_1.actors_) do
					for iter_4_11, iter_4_12 in ipairs((iter_4_10:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_4_12.color = iter_4_12.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_4_18 = 0.0166666666666667

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_17) / var_4_18)
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
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

			if 1.56666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.56666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown")

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

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.999999999999 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_gun", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_26 = 1.999999999999
			local var_4_27 = 0.075

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_29 = arg_1_1:GetWordFromCfg(410041001)
				local var_4_30 = arg_1_1:FormatText(var_4_29.content)

				arg_1_1.text_.text = var_4_30

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_32 = 3 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 3)

				if (3 <= 0 and var_4_27 or var_4_27 * (utf8.len(var_4_30) / 3)) > 0 and var_4_27 < var_4_32 then
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

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041001", "story_v_out_410041.awb") ~= 0 then
					local var_4_33 = manager.audio:GetVoiceLength("story_v_out_410041", "410041001", "story_v_out_410041.awb") / 1000

					if var_4_33 + var_4_26 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_26
					end

					if var_4_29.prefab_name ~= "" and arg_1_1.actors_[var_4_29.prefab_name] ~= nil then
						local var_4_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_29.prefab_name].transform, "story_v_out_410041", "410041001", "story_v_out_410041.awb")

						arg_1_1:RecordAudio("410041001", var_4_34)
						arg_1_1:RecordAudio("410041001", var_4_34)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_410041", "410041001", "story_v_out_410041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_410041", "410041001", "story_v_out_410041.awb")
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
				actorName = "10064",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play410041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 410041002
		arg_9_1.duration_ = 5.07

		local var_9_0 = {
			zh = 2.433,
			ja = 5.066
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
				arg_9_0:Play410041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.2

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:GetWordFromCfg(410041002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 8 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 8)

				if (8 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 8)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041002", "story_v_out_410041.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_410041", "410041002", "story_v_out_410041.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_410041", "410041002", "story_v_out_410041.awb")

						arg_9_1:RecordAudio("410041002", var_12_6)
						arg_9_1:RecordAudio("410041002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_410041", "410041002", "story_v_out_410041.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_410041", "410041002", "story_v_out_410041.awb")
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
	Play410041003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 410041003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play410041004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10064 = arg_13_1.actors_["10064"].transform.localPosition
				arg_13_1.actors_["10064"].transform.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("10064", 7)

				for iter_16_0 = 0, arg_13_1.actors_["10064"].transform.childCount - 1 do
					local var_16_0 = arg_13_1.actors_["10064"].transform:GetChild(iter_16_0)

					if var_16_0.name == "split_3" or not string.find(var_16_0.name, "split") then
						var_16_0.gameObject:SetActive(true)
					else
						var_16_0.gameObject:SetActive(false)
					end
				end
			end

			local var_16_1 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				arg_13_1.actors_["10064"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10064, Vector3.New(0, -2000, 192.5), (arg_13_1.time_ - 0) / var_16_1)
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 then
				arg_13_1.actors_["10064"].transform.localPosition = Vector3.New(0, -2000, 192.5)
			end

			local var_16_2 = 0
			local var_16_3 = 1.175

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_2 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_4 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(410041003).content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 47 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_4) / 47)

				if (47 <= 0 and var_16_3 or var_16_3 * (utf8.len(var_16_4) / 47)) > 0 and var_16_3 < var_16_6 then
					arg_13_1.talkMaxDuration = var_16_6

					if var_16_6 + var_16_2 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_2
					end
				end

				arg_13_1.text_.text = var_16_4
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_3, arg_13_1.talkMaxDuration)

			if var_16_2 <= arg_13_1.time_ and arg_13_1.time_ < var_16_2 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_2) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_2 + var_16_7 and arg_13_1.time_ < var_16_2 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10064",
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
	Play410041004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 410041004
		arg_17_1.duration_ = 4.17

		local var_17_0 = {
			zh = 1.9,
			ja = 4.166
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
				arg_17_0:Play410041005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10064 = arg_17_1.actors_["10064"].transform.localPosition
				arg_17_1.actors_["10064"].transform.localScale = Vector3.New(1, 1, 1)

				arg_17_1:CheckSpriteTmpPos("10064", 3)

				for iter_20_0 = 0, arg_17_1.actors_["10064"].transform.childCount - 1 do
					local var_20_0 = arg_17_1.actors_["10064"].transform:GetChild(iter_20_0)

					if var_20_0.name == "split_3" or not string.find(var_20_0.name, "split") then
						var_20_0.gameObject:SetActive(true)
					else
						var_20_0.gameObject:SetActive(false)
					end
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["10064"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10064, Vector3.New(0, -570, 192.5), (arg_17_1.time_ - 0) / var_20_1)
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["10064"].transform.localPosition = Vector3.New(0, -570, 192.5)
			end

			local var_20_2 = arg_17_1.actors_["10064"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10064 == nil then
				arg_17_1.var_.actorSpriteComps10064 = var_20_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_3 = 0.034

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.actorSpriteComps10064 then
					for iter_20_1, iter_20_2 in pairs(arg_17_1.var_.actorSpriteComps10064:ToTable()) do
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

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.actorSpriteComps10064 then
				for iter_20_3, iter_20_4 in pairs(arg_17_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_20_4 then
						iter_20_4.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_17_1.var_.actorSpriteComps10064 = nil
			end

			local var_20_5 = 0
			local var_20_6 = 0.125

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_7 = arg_17_1:GetWordFromCfg(410041004)
				local var_20_8 = arg_17_1:FormatText(var_20_7.content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 5 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 5)

				if (5 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_8) / 5)) > 0 and var_20_6 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041004", "story_v_out_410041.awb") ~= 0 then
					local var_20_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041004", "story_v_out_410041.awb") / 1000

					if var_20_11 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_11 + var_20_5
					end

					if var_20_7.prefab_name ~= "" and arg_17_1.actors_[var_20_7.prefab_name] ~= nil then
						local var_20_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_7.prefab_name].transform, "story_v_out_410041", "410041004", "story_v_out_410041.awb")

						arg_17_1:RecordAudio("410041004", var_20_12)
						arg_17_1:RecordAudio("410041004", var_20_12)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_410041", "410041004", "story_v_out_410041.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_410041", "410041004", "story_v_out_410041.awb")
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
				actorName = "10064",
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
	Play410041005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 410041005
		arg_21_1.duration_ = 3

		local var_21_0 = {
			zh = 2.233,
			ja = 3
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
				arg_21_0:Play410041006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10064"]) and arg_21_1.var_.actorSpriteComps10064 == nil then
				arg_21_1.var_.actorSpriteComps10064 = arg_21_1.actors_["10064"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.034

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10064"]) then
				if arg_21_1.var_.actorSpriteComps10064 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_24_1 then
							if arg_21_1.isInRecall_ then
								iter_24_1.color = Color.New(Mathf.Lerp(iter_24_1.color.r, arg_21_1.hightColor2.r, (arg_21_1.time_ - 0) / var_24_0), Mathf.Lerp(iter_24_1.color.g, arg_21_1.hightColor2.g, (arg_21_1.time_ - 0) / var_24_0), (Mathf.Lerp(iter_24_1.color.b, arg_21_1.hightColor2.b, (arg_21_1.time_ - 0) / var_24_0)))
							else
								local var_24_1 = Mathf.Lerp(iter_24_1.color.r, 0.5, (arg_21_1.time_ - 0) / var_24_0)

								iter_24_1.color = Color.New(var_24_1, var_24_1, var_24_1)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10064"]) and arg_21_1.var_.actorSpriteComps10064 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_21_1.var_.actorSpriteComps10064 = nil
			end

			local var_24_2 = 0
			local var_24_3 = 0.25

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1012_split_3")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_4 = arg_21_1:GetWordFromCfg(410041005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 10 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 10)

				if (10 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 10)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041005", "story_v_out_410041.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_410041", "410041005", "story_v_out_410041.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_410041", "410041005", "story_v_out_410041.awb")

						arg_21_1:RecordAudio("410041005", var_24_9)
						arg_21_1:RecordAudio("410041005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_410041", "410041005", "story_v_out_410041.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_410041", "410041005", "story_v_out_410041.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play410041006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 410041006
		arg_25_1.duration_ = 9.3

		local var_25_0 = {
			zh = 2.1,
			ja = 9.3
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
				arg_25_0:Play410041007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10064 = arg_25_1.actors_["10064"].transform.localPosition
				arg_25_1.actors_["10064"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("10064", 3)

				for iter_28_0 = 0, arg_25_1.actors_["10064"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["10064"].transform:GetChild(iter_28_0)

					if var_28_0.name == "split_3" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["10064"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10064, Vector3.New(0, -570, 192.5), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["10064"].transform.localPosition = Vector3.New(0, -570, 192.5)
			end

			local var_28_2 = arg_25_1.actors_["10064"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10064 == nil then
				arg_25_1.var_.actorSpriteComps10064 = var_28_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_28_3 = 0.034

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.actorSpriteComps10064 then
					for iter_28_1, iter_28_2 in pairs(arg_25_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_28_2 then
							if arg_25_1.isInRecall_ then
								iter_28_2.color = Color.New(Mathf.Lerp(iter_28_2.color.r, arg_25_1.hightColor1.r, (arg_25_1.time_ - 0) / var_28_3), Mathf.Lerp(iter_28_2.color.g, arg_25_1.hightColor1.g, (arg_25_1.time_ - 0) / var_28_3), (Mathf.Lerp(iter_28_2.color.b, arg_25_1.hightColor1.b, (arg_25_1.time_ - 0) / var_28_3)))
							else
								local var_28_4 = Mathf.Lerp(iter_28_2.color.r, 1, (arg_25_1.time_ - 0) / var_28_3)

								iter_28_2.color = Color.New(var_28_4, var_28_4, var_28_4)
							end
						end
					end
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.actorSpriteComps10064 then
				for iter_28_3, iter_28_4 in pairs(arg_25_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_28_4 then
						iter_28_4.color = arg_25_1.isInRecall_ and (arg_25_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_25_1.var_.actorSpriteComps10064 = nil
			end

			local var_28_5 = 0
			local var_28_6 = 0.3

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_7 = arg_25_1:GetWordFromCfg(410041006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_10 = 12 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 12)

				if (12 <= 0 and var_28_6 or var_28_6 * (utf8.len(var_28_8) / 12)) > 0 and var_28_6 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_5
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041006", "story_v_out_410041.awb") ~= 0 then
					local var_28_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041006", "story_v_out_410041.awb") / 1000

					if var_28_11 + var_28_5 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_5
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_410041", "410041006", "story_v_out_410041.awb")

						arg_25_1:RecordAudio("410041006", var_28_12)
						arg_25_1:RecordAudio("410041006", var_28_12)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_410041", "410041006", "story_v_out_410041.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_410041", "410041006", "story_v_out_410041.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = math.max(var_28_6, arg_25_1.talkMaxDuration)

			if var_28_5 <= arg_25_1.time_ and arg_25_1.time_ < var_28_5 + var_28_13 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_5) / var_28_13

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_5 + var_28_13 and arg_25_1.time_ < var_28_5 + var_28_13 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10064",
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
	Play410041007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 410041007
		arg_29_1.duration_ = 11.03

		local var_29_0 = {
			zh = 4.466,
			ja = 11.033
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
				arg_29_0:Play410041008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10064"]) and arg_29_1.var_.actorSpriteComps10064 == nil then
				arg_29_1.var_.actorSpriteComps10064 = arg_29_1.actors_["10064"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 0.034

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10064"]) then
				if arg_29_1.var_.actorSpriteComps10064 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_32_1 then
							if arg_29_1.isInRecall_ then
								iter_32_1.color = Color.New(Mathf.Lerp(iter_32_1.color.r, arg_29_1.hightColor2.r, (arg_29_1.time_ - 0) / var_32_0), Mathf.Lerp(iter_32_1.color.g, arg_29_1.hightColor2.g, (arg_29_1.time_ - 0) / var_32_0), (Mathf.Lerp(iter_32_1.color.b, arg_29_1.hightColor2.b, (arg_29_1.time_ - 0) / var_32_0)))
							else
								local var_32_1 = Mathf.Lerp(iter_32_1.color.r, 0.5, (arg_29_1.time_ - 0) / var_32_0)

								iter_32_1.color = Color.New(var_32_1, var_32_1, var_32_1)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10064"]) and arg_29_1.var_.actorSpriteComps10064 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps10064 = nil
			end

			local var_32_2 = 0
			local var_32_3 = 0.55

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_2 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1012_split_3")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_4 = arg_29_1:GetWordFromCfg(410041007)
				local var_32_5 = arg_29_1:FormatText(var_32_4.content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 22 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 22)

				if (22 <= 0 and var_32_3 or var_32_3 * (utf8.len(var_32_5) / 22)) > 0 and var_32_3 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_2
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041007", "story_v_out_410041.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_410041", "410041007", "story_v_out_410041.awb") / 1000

					if var_32_8 + var_32_2 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_2
					end

					if var_32_4.prefab_name ~= "" and arg_29_1.actors_[var_32_4.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_4.prefab_name].transform, "story_v_out_410041", "410041007", "story_v_out_410041.awb")

						arg_29_1:RecordAudio("410041007", var_32_9)
						arg_29_1:RecordAudio("410041007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_410041", "410041007", "story_v_out_410041.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_410041", "410041007", "story_v_out_410041.awb")
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

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play410041008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 410041008
		arg_33_1.duration_ = 2.37

		local var_33_0 = {
			zh = 0.999999999999,
			ja = 2.366
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
				arg_33_0:Play410041009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10064 = arg_33_1.actors_["10064"].transform.localPosition
				arg_33_1.actors_["10064"].transform.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("10064", 3)

				for iter_36_0 = 0, arg_33_1.actors_["10064"].transform.childCount - 1 do
					local var_36_0 = arg_33_1.actors_["10064"].transform:GetChild(iter_36_0)

					if var_36_0.name == "split_3" or not string.find(var_36_0.name, "split") then
						var_36_0.gameObject:SetActive(true)
					else
						var_36_0.gameObject:SetActive(false)
					end
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["10064"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10064, Vector3.New(0, -570, 192.5), (arg_33_1.time_ - 0) / var_36_1)
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["10064"].transform.localPosition = Vector3.New(0, -570, 192.5)
			end

			local var_36_2 = arg_33_1.actors_["10064"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps10064 == nil then
				arg_33_1.var_.actorSpriteComps10064 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 0.034

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps10064 then
					for iter_36_1, iter_36_2 in pairs(arg_33_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_36_2 then
							if arg_33_1.isInRecall_ then
								iter_36_2.color = Color.New(Mathf.Lerp(iter_36_2.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_3), Mathf.Lerp(iter_36_2.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_3), (Mathf.Lerp(iter_36_2.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_3)))
							else
								local var_36_4 = Mathf.Lerp(iter_36_2.color.r, 1, (arg_33_1.time_ - 0) / var_36_3)

								iter_36_2.color = Color.New(var_36_4, var_36_4, var_36_4)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps10064 then
				for iter_36_3, iter_36_4 in pairs(arg_33_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_36_4 then
						iter_36_4.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps10064 = nil
			end

			local var_36_5 = 0
			local var_36_6 = 0.075

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_7 = arg_33_1:GetWordFromCfg(410041008)
				local var_36_8 = arg_33_1:FormatText(var_36_7.content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 3 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 3)

				if (3 <= 0 and var_36_6 or var_36_6 * (utf8.len(var_36_8) / 3)) > 0 and var_36_6 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041008", "story_v_out_410041.awb") ~= 0 then
					local var_36_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041008", "story_v_out_410041.awb") / 1000

					if var_36_11 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_5
					end

					if var_36_7.prefab_name ~= "" and arg_33_1.actors_[var_36_7.prefab_name] ~= nil then
						local var_36_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_7.prefab_name].transform, "story_v_out_410041", "410041008", "story_v_out_410041.awb")

						arg_33_1:RecordAudio("410041008", var_36_12)
						arg_33_1:RecordAudio("410041008", var_36_12)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_410041", "410041008", "story_v_out_410041.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_410041", "410041008", "story_v_out_410041.awb")
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
				actorName = "10064",
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
	Play410041009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 410041009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play410041010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10064 = arg_37_1.actors_["10064"].transform.localPosition
				arg_37_1.actors_["10064"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10064", 7)

				for iter_40_0 = 0, arg_37_1.actors_["10064"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["10064"].transform:GetChild(iter_40_0)

					if var_40_0.name == "split_3" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["10064"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10064, Vector3.New(0, -2000, 192.5), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["10064"].transform.localPosition = Vector3.New(0, -2000, 192.5)
			end

			local var_40_2 = 0
			local var_40_3 = 1.025

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(410041009).content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_6 = 41 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_4) / 41)

				if (41 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_4) / 41)) > 0 and var_40_3 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_7 and arg_37_1.time_ < var_40_2 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10064",
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
	Play410041010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 410041010
		arg_41_1.duration_ = 4.67

		local var_41_0 = {
			zh = 2.5,
			ja = 4.666
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
				arg_41_0:Play410041011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10064 = arg_41_1.actors_["10064"].transform.localPosition
				arg_41_1.actors_["10064"].transform.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10064", 3)

				for iter_44_0 = 0, arg_41_1.actors_["10064"].transform.childCount - 1 do
					local var_44_0 = arg_41_1.actors_["10064"].transform:GetChild(iter_44_0)

					if var_44_0.name == "split_3" or not string.find(var_44_0.name, "split") then
						var_44_0.gameObject:SetActive(true)
					else
						var_44_0.gameObject:SetActive(false)
					end
				end
			end

			local var_44_1 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_1 then
				arg_41_1.actors_["10064"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10064, Vector3.New(0, -570, 192.5), (arg_41_1.time_ - 0) / var_44_1)
			end

			if arg_41_1.time_ >= 0 + var_44_1 and arg_41_1.time_ < 0 + var_44_1 + arg_44_0 then
				arg_41_1.actors_["10064"].transform.localPosition = Vector3.New(0, -570, 192.5)
			end

			local var_44_2 = arg_41_1.actors_["10064"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10064 == nil then
				arg_41_1.var_.actorSpriteComps10064 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 0.034

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps10064 then
					for iter_44_1, iter_44_2 in pairs(arg_41_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_44_2 then
							if arg_41_1.isInRecall_ then
								iter_44_2.color = Color.New(Mathf.Lerp(iter_44_2.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_2.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_2.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_2.color.r, 1, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_2.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps10064 then
				for iter_44_3, iter_44_4 in pairs(arg_41_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_44_4 then
						iter_44_4.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps10064 = nil
			end

			local var_44_5 = 0
			local var_44_6 = 0.125

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_7 = arg_41_1:GetWordFromCfg(410041010)
				local var_44_8 = arg_41_1:FormatText(var_44_7.content)

				arg_41_1.text_.text = var_44_8

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_10 = 5 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 5)

				if (5 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_8) / 5)) > 0 and var_44_6 < var_44_10 then
					arg_41_1.talkMaxDuration = var_44_10

					if var_44_10 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_5
					end
				end

				arg_41_1.text_.text = var_44_8
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041010", "story_v_out_410041.awb") ~= 0 then
					local var_44_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041010", "story_v_out_410041.awb") / 1000

					if var_44_11 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_5
					end

					if var_44_7.prefab_name ~= "" and arg_41_1.actors_[var_44_7.prefab_name] ~= nil then
						local var_44_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_7.prefab_name].transform, "story_v_out_410041", "410041010", "story_v_out_410041.awb")

						arg_41_1:RecordAudio("410041010", var_44_12)
						arg_41_1:RecordAudio("410041010", var_44_12)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_410041", "410041010", "story_v_out_410041.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_410041", "410041010", "story_v_out_410041.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_13 = math.max(var_44_6, arg_41_1.talkMaxDuration)

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_13 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_5) / var_44_13

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_5 + var_44_13 and arg_41_1.time_ < var_44_5 + var_44_13 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10064",
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
	Play410041011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 410041011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play410041012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10064 = arg_45_1.actors_["10064"].transform.localPosition
				arg_45_1.actors_["10064"].transform.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10064", 7)

				for iter_48_0 = 0, arg_45_1.actors_["10064"].transform.childCount - 1 do
					local var_48_0 = arg_45_1.actors_["10064"].transform:GetChild(iter_48_0)

					if var_48_0.name == "split_3" or not string.find(var_48_0.name, "split") then
						var_48_0.gameObject:SetActive(true)
					else
						var_48_0.gameObject:SetActive(false)
					end
				end
			end

			local var_48_1 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_1 then
				arg_45_1.actors_["10064"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10064, Vector3.New(0, -2000, 192.5), (arg_45_1.time_ - 0) / var_48_1)
			end

			if arg_45_1.time_ >= 0 + var_48_1 and arg_45_1.time_ < 0 + var_48_1 + arg_48_0 then
				arg_45_1.actors_["10064"].transform.localPosition = Vector3.New(0, -2000, 192.5)
			end

			local var_48_2 = 0
			local var_48_3 = 1

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(410041011).content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 40 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_4) / 40)

				if (40 <= 0 and var_48_3 or var_48_3 * (utf8.len(var_48_4) / 40)) > 0 and var_48_3 < var_48_6 then
					arg_45_1.talkMaxDuration = var_48_6

					if var_48_6 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_6 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_7 and arg_45_1.time_ < var_48_2 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10064",
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
	Play410041012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 410041012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play410041013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 1.375

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(410041012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 55 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 55)

				if (55 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 55)) > 0 and var_52_0 < var_52_3 then
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
	Play410041013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 410041013
		arg_53_1.duration_ = 2.5

		local var_53_0 = {
			zh = 1.166,
			ja = 2.5
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
				arg_53_0:Play410041014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos10064 = arg_53_1.actors_["10064"].transform.localPosition
				arg_53_1.actors_["10064"].transform.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("10064", 3)

				for iter_56_0 = 0, arg_53_1.actors_["10064"].transform.childCount - 1 do
					local var_56_0 = arg_53_1.actors_["10064"].transform:GetChild(iter_56_0)

					if var_56_0.name == "split_3" or not string.find(var_56_0.name, "split") then
						var_56_0.gameObject:SetActive(true)
					else
						var_56_0.gameObject:SetActive(false)
					end
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["10064"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10064, Vector3.New(0, -570, 192.5), (arg_53_1.time_ - 0) / var_56_1)
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["10064"].transform.localPosition = Vector3.New(0, -570, 192.5)
			end

			local var_56_2 = arg_53_1.actors_["10064"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps10064 == nil then
				arg_53_1.var_.actorSpriteComps10064 = var_56_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_3 = 0.034

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.actorSpriteComps10064 then
					for iter_56_1, iter_56_2 in pairs(arg_53_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_56_2 then
							if arg_53_1.isInRecall_ then
								iter_56_2.color = Color.New(Mathf.Lerp(iter_56_2.color.r, arg_53_1.hightColor1.r, (arg_53_1.time_ - 0) / var_56_3), Mathf.Lerp(iter_56_2.color.g, arg_53_1.hightColor1.g, (arg_53_1.time_ - 0) / var_56_3), (Mathf.Lerp(iter_56_2.color.b, arg_53_1.hightColor1.b, (arg_53_1.time_ - 0) / var_56_3)))
							else
								local var_56_4 = Mathf.Lerp(iter_56_2.color.r, 1, (arg_53_1.time_ - 0) / var_56_3)

								iter_56_2.color = Color.New(var_56_4, var_56_4, var_56_4)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.actorSpriteComps10064 then
				for iter_56_3, iter_56_4 in pairs(arg_53_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_56_4 then
						iter_56_4.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_53_1.var_.actorSpriteComps10064 = nil
			end

			local var_56_5 = 0
			local var_56_6 = 0.125

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_7 = arg_53_1:GetWordFromCfg(410041013)
				local var_56_8 = arg_53_1:FormatText(var_56_7.content)

				arg_53_1.text_.text = var_56_8

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 5 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 5)

				if (5 <= 0 and var_56_6 or var_56_6 * (utf8.len(var_56_8) / 5)) > 0 and var_56_6 < var_56_10 then
					arg_53_1.talkMaxDuration = var_56_10

					if var_56_10 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_5
					end
				end

				arg_53_1.text_.text = var_56_8
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041013", "story_v_out_410041.awb") ~= 0 then
					local var_56_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041013", "story_v_out_410041.awb") / 1000

					if var_56_11 + var_56_5 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_11 + var_56_5
					end

					if var_56_7.prefab_name ~= "" and arg_53_1.actors_[var_56_7.prefab_name] ~= nil then
						local var_56_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_7.prefab_name].transform, "story_v_out_410041", "410041013", "story_v_out_410041.awb")

						arg_53_1:RecordAudio("410041013", var_56_12)
						arg_53_1:RecordAudio("410041013", var_56_12)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_410041", "410041013", "story_v_out_410041.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_410041", "410041013", "story_v_out_410041.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_13 = math.max(var_56_6, arg_53_1.talkMaxDuration)

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_13 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_5) / var_56_13

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_5 + var_56_13 and arg_53_1.time_ < var_56_5 + var_56_13 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10064",
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
	Play410041014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 410041014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play410041015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10064 = arg_57_1.actors_["10064"].transform.localPosition
				arg_57_1.actors_["10064"].transform.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("10064", 7)

				for iter_60_0 = 0, arg_57_1.actors_["10064"].transform.childCount - 1 do
					local var_60_0 = arg_57_1.actors_["10064"].transform:GetChild(iter_60_0)

					if var_60_0.name == "split_3" or not string.find(var_60_0.name, "split") then
						var_60_0.gameObject:SetActive(true)
					else
						var_60_0.gameObject:SetActive(false)
					end
				end
			end

			local var_60_1 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_1 then
				arg_57_1.actors_["10064"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10064, Vector3.New(0, -2000, 192.5), (arg_57_1.time_ - 0) / var_60_1)
			end

			if arg_57_1.time_ >= 0 + var_60_1 and arg_57_1.time_ < 0 + var_60_1 + arg_60_0 then
				arg_57_1.actors_["10064"].transform.localPosition = Vector3.New(0, -2000, 192.5)
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_gunshot", "")
			end

			local var_60_3 = 0
			local var_60_4 = 1.325

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_3 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_5 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(410041014).content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_7 = 53 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_5) / 53)

				if (53 <= 0 and var_60_4 or var_60_4 * (utf8.len(var_60_5) / 53)) > 0 and var_60_4 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_3 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_3
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_8 = math.max(var_60_4, arg_57_1.talkMaxDuration)

			if var_60_3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_3 + var_60_8 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_3) / var_60_8

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_3 + var_60_8 and arg_57_1.time_ < var_60_3 + var_60_8 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10064",
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
	Play410041015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 410041015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play410041016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 1.15

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_1 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(410041015).content)

				arg_61_1.text_.text = var_64_1

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_3 = 46 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 46)

				if (46 <= 0 and var_64_0 or var_64_0 * (utf8.len(var_64_1) / 46)) > 0 and var_64_0 < var_64_3 then
					arg_61_1.talkMaxDuration = var_64_3

					if var_64_3 + 0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_3 + 0
					end
				end

				arg_61_1.text_.text = var_64_1
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_4 = math.max(var_64_0, arg_61_1.talkMaxDuration)

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - 0) / var_64_4

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play410041016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 410041016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play410041017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_gun", "")
			end

			local var_68_1 = 0
			local var_68_2 = 1.325

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(410041016).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 53 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 53)

				if (53 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 53)) > 0 and var_68_2 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_6 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_6 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_6

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_6 and arg_65_1.time_ < var_68_1 + var_68_6 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play410041017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 410041017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play410041018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_0 = 0.5

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				local var_72_1 = Color.New(1, 1, 1)

				var_72_1.a = Mathf.Lerp(1, 0, (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.mask_.color = var_72_1
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				local var_72_2 = Color.New(1, 1, 1)

				arg_69_1.mask_.enabled = false
				var_72_2.a = 0
				arg_69_1.mask_.color = var_72_2
			end

			local var_72_3 = 0
			local var_72_4 = 1.3

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_3 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_5 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_5:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, false)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(410041017).content)

				arg_69_1.text_.text = var_72_6

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_8 = 52 <= 0 and var_72_4 or var_72_4 * (utf8.len(var_72_6) / 52)

				if (52 <= 0 and var_72_4 or var_72_4 * (utf8.len(var_72_6) / 52)) > 0 and var_72_4 < var_72_8 then
					arg_69_1.talkMaxDuration = var_72_8
					var_72_3 = var_72_3 + 0.3

					if var_72_8 + var_72_3 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_3
					end
				end

				arg_69_1.text_.text = var_72_6
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_9 = var_72_3 + 0.3
			local var_72_10 = math.max(var_72_4, arg_69_1.talkMaxDuration)

			if var_72_3 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_9) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_9 + var_72_10 and arg_69_1.time_ < var_72_9 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play410041018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 410041018
		arg_75_1.duration_ = 2.73

		local var_75_0 = {
			zh = 1.5,
			ja = 2.733
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
				arg_75_0:Play410041019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10064 = arg_75_1.actors_["10064"].transform.localPosition
				arg_75_1.actors_["10064"].transform.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("10064", 3)

				for iter_78_0 = 0, arg_75_1.actors_["10064"].transform.childCount - 1 do
					local var_78_0 = arg_75_1.actors_["10064"].transform:GetChild(iter_78_0)

					if var_78_0.name == "split_3" or not string.find(var_78_0.name, "split") then
						var_78_0.gameObject:SetActive(true)
					else
						var_78_0.gameObject:SetActive(false)
					end
				end
			end

			local var_78_1 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_1 then
				arg_75_1.actors_["10064"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10064, Vector3.New(0, -570, 192.5), (arg_75_1.time_ - 0) / var_78_1)
			end

			if arg_75_1.time_ >= 0 + var_78_1 and arg_75_1.time_ < 0 + var_78_1 + arg_78_0 then
				arg_75_1.actors_["10064"].transform.localPosition = Vector3.New(0, -570, 192.5)
			end

			local var_78_2 = arg_75_1.actors_["10064"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps10064 == nil then
				arg_75_1.var_.actorSpriteComps10064 = var_78_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_78_3 = 0.034

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_3 and not isNil(var_78_2) then
				if arg_75_1.var_.actorSpriteComps10064 then
					for iter_78_1, iter_78_2 in pairs(arg_75_1.var_.actorSpriteComps10064:ToTable()) do
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

			if arg_75_1.time_ >= 0 + var_78_3 and arg_75_1.time_ < 0 + var_78_3 + arg_78_0 and not isNil(var_78_2) and arg_75_1.var_.actorSpriteComps10064 then
				for iter_78_3, iter_78_4 in pairs(arg_75_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_78_4 then
						iter_78_4.color = arg_75_1.isInRecall_ and (arg_75_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_75_1.var_.actorSpriteComps10064 = nil
			end

			local var_78_5 = 0
			local var_78_6 = 0.15

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_5 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_7 = arg_75_1:GetWordFromCfg(410041018)
				local var_78_8 = arg_75_1:FormatText(var_78_7.content)

				arg_75_1.text_.text = var_78_8

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_10 = 6 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_8) / 6)

				if (6 <= 0 and var_78_6 or var_78_6 * (utf8.len(var_78_8) / 6)) > 0 and var_78_6 < var_78_10 then
					arg_75_1.talkMaxDuration = var_78_10

					if var_78_10 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_5
					end
				end

				arg_75_1.text_.text = var_78_8
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041018", "story_v_out_410041.awb") ~= 0 then
					local var_78_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041018", "story_v_out_410041.awb") / 1000

					if var_78_11 + var_78_5 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_11 + var_78_5
					end

					if var_78_7.prefab_name ~= "" and arg_75_1.actors_[var_78_7.prefab_name] ~= nil then
						local var_78_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_7.prefab_name].transform, "story_v_out_410041", "410041018", "story_v_out_410041.awb")

						arg_75_1:RecordAudio("410041018", var_78_12)
						arg_75_1:RecordAudio("410041018", var_78_12)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_410041", "410041018", "story_v_out_410041.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_410041", "410041018", "story_v_out_410041.awb")
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
				actorName = "10064",
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
	Play410041019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 410041019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play410041020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10064 = arg_79_1.actors_["10064"].transform.localPosition
				arg_79_1.actors_["10064"].transform.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("10064", 7)

				for iter_82_0 = 0, arg_79_1.actors_["10064"].transform.childCount - 1 do
					local var_82_0 = arg_79_1.actors_["10064"].transform:GetChild(iter_82_0)

					if var_82_0.name == "split_3" or not string.find(var_82_0.name, "split") then
						var_82_0.gameObject:SetActive(true)
					else
						var_82_0.gameObject:SetActive(false)
					end
				end
			end

			local var_82_1 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 then
				arg_79_1.actors_["10064"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10064, Vector3.New(0, -2000, 192.5), (arg_79_1.time_ - 0) / var_82_1)
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 then
				arg_79_1.actors_["10064"].transform.localPosition = Vector3.New(0, -2000, 192.5)
			end

			local var_82_2 = 0
			local var_82_3 = 1.6

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_2 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_4 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(410041019).content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_6 = 64 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_4) / 64)

				if (64 <= 0 and var_82_3 or var_82_3 * (utf8.len(var_82_4) / 64)) > 0 and var_82_3 < var_82_6 then
					arg_79_1.talkMaxDuration = var_82_6

					if var_82_6 + var_82_2 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_2
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_3, arg_79_1.talkMaxDuration)

			if var_82_2 <= arg_79_1.time_ and arg_79_1.time_ < var_82_2 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_2) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_2 + var_82_7 and arg_79_1.time_ < var_82_2 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10064",
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
	Play410041020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 410041020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play410041021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.mask_.enabled = true
				arg_83_1.mask_.raycastTarget = true

				arg_83_1:SetGaussion(false)
			end

			local var_86_0 = 1

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				local var_86_1 = Color.New(1, 1, 1)

				var_86_1.a = Mathf.Lerp(1, 0, (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.mask_.color = var_86_1
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				local var_86_2 = Color.New(1, 1, 1)

				arg_83_1.mask_.enabled = false
				var_86_2.a = 0
				arg_83_1.mask_.color = var_86_2
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:AudioAction("play", "effect", "se_story_side_1094", "se_story_1094_gun", "")
			end

			local var_86_4 = 0
			local var_86_5 = 0.075

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_4 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0

				arg_83_1.dialog_:SetActive(true)

				arg_83_1.dialogCg_.alpha = 0

				local var_86_6 = LeanTween.value(arg_83_1.dialog_, 0, 1, 0.3)

				var_86_6:setOnUpdate(LuaHelper.FloatAction(function(arg_87_0)
					arg_83_1.dialogCg_.alpha = arg_87_0
				end))
				var_86_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_83_1.dialog_)
					var_86_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_83_1.duration_ = arg_83_1.duration_ + 0.3

				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_7 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(410041020).content)

				arg_83_1.text_.text = var_86_7

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_9 = 3 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_7) / 3)

				if (3 <= 0 and var_86_5 or var_86_5 * (utf8.len(var_86_7) / 3)) > 0 and var_86_5 < var_86_9 then
					arg_83_1.talkMaxDuration = var_86_9
					var_86_4 = var_86_4 + 0.3

					if var_86_9 + var_86_4 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_4
					end
				end

				arg_83_1.text_.text = var_86_7
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = var_86_4 + 0.3
			local var_86_11 = math.max(var_86_5, arg_83_1.talkMaxDuration)

			if var_86_4 + 0.3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_10 + var_86_11 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_10) / var_86_11

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_10 + var_86_11 and arg_83_1.time_ < var_86_10 + var_86_11 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play410041021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 410041021
		arg_89_1.duration_ = 9

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play410041022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 2 < arg_89_1.time_ and arg_89_1.time_ <= 2 + arg_92_0 then
				local var_92_0 = arg_89_1.bgs_.J02f

				arg_89_1.bgs_.J02f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_92_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_92_1 = var_92_0:GetComponent("SpriteRenderer")

				if var_92_1 and var_92_1.sprite then
					local var_92_2 = 2 * (var_92_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_92_0.transform.localScale = Vector3.New(var_92_2 / var_92_1.sprite.bounds.size.y < var_92_2 * manager.ui.mainCameraCom_.aspect / var_92_1.sprite.bounds.size.x and var_92_2 * manager.ui.mainCameraCom_.aspect / var_92_1.sprite.bounds.size.x or var_92_2 / var_92_1.sprite.bounds.size.y, var_92_2 / var_92_1.sprite.bounds.size.y < var_92_2 * manager.ui.mainCameraCom_.aspect / var_92_1.sprite.bounds.size.x and var_92_2 * manager.ui.mainCameraCom_.aspect / var_92_1.sprite.bounds.size.x or var_92_2 / var_92_1.sprite.bounds.size.y, 0)
				end

				for iter_92_0, iter_92_1 in pairs(arg_89_1.bgs_) do
					if iter_92_0 ~= "J02f" then
						iter_92_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_92_3 = 0

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_3 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_4 = 2

			if var_92_3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_3 + var_92_4 then
				local var_92_5 = Color.New(0, 0, 0)

				var_92_5.a = Mathf.Lerp(0, 1, (arg_89_1.time_ - var_92_3) / var_92_4)
				arg_89_1.mask_.color = var_92_5
			end

			if arg_89_1.time_ >= var_92_3 + var_92_4 and arg_89_1.time_ < var_92_3 + var_92_4 + arg_92_0 then
				local var_92_6 = Color.New(0, 0, 0)

				var_92_6.a = 1
				arg_89_1.mask_.color = var_92_6
			end

			local var_92_7 = 2

			if 2 < arg_89_1.time_ and arg_89_1.time_ <= var_92_7 + arg_92_0 then
				arg_89_1.mask_.enabled = true
				arg_89_1.mask_.raycastTarget = true

				arg_89_1:SetGaussion(false)
			end

			local var_92_8 = 2

			if var_92_7 <= arg_89_1.time_ and arg_89_1.time_ < var_92_7 + var_92_8 then
				local var_92_9 = Color.New(0, 0, 0)

				var_92_9.a = Mathf.Lerp(1, 0, (arg_89_1.time_ - var_92_7) / var_92_8)
				arg_89_1.mask_.color = var_92_9
			end

			if arg_89_1.time_ >= var_92_7 + var_92_8 and arg_89_1.time_ < var_92_7 + var_92_8 + arg_92_0 then
				local var_92_10 = Color.New(0, 0, 0)

				arg_89_1.mask_.enabled = false
				var_92_10.a = 0
				arg_89_1.mask_.color = var_92_10
			end

			if arg_89_1.frameCnt_ <= 1 then
				arg_89_1.dialog_:SetActive(false)
			end

			local var_92_11 = 3.999999999999
			local var_92_12 = 1.35

			if 3.999999999999 < arg_89_1.time_ and arg_89_1.time_ <= var_92_11 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0

				arg_89_1.dialog_:SetActive(true)

				arg_89_1.dialogCg_.alpha = 0

				local var_92_13 = LeanTween.value(arg_89_1.dialog_, 0, 1, 0.3)

				var_92_13:setOnUpdate(LuaHelper.FloatAction(function(arg_93_0)
					arg_89_1.dialogCg_.alpha = arg_93_0
				end))
				var_92_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_89_1.dialog_)
					var_92_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_89_1.duration_ = arg_89_1.duration_ + 0.3

				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_14 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(410041021).content)

				arg_89_1.text_.text = var_92_14

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_16 = 54 <= 0 and var_92_12 or var_92_12 * (utf8.len(var_92_14) / 54)

				if (54 <= 0 and var_92_12 or var_92_12 * (utf8.len(var_92_14) / 54)) > 0 and var_92_12 < var_92_16 then
					arg_89_1.talkMaxDuration = var_92_16
					var_92_11 = var_92_11 + 0.3

					if var_92_16 + var_92_11 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_16 + var_92_11
					end
				end

				arg_89_1.text_.text = var_92_14
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_17 = var_92_11 + 0.3
			local var_92_18 = math.max(var_92_12, arg_89_1.talkMaxDuration)

			if var_92_11 + 0.3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_17 + var_92_18 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_17) / var_92_18

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_17 + var_92_18 and arg_89_1.time_ < var_92_17 + var_92_18 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play410041022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 410041022
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play410041023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if arg_95_1.actors_["1012"] == nil then
				local var_98_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1012")

				if not isNil(var_98_0) then
					local var_98_1 = Object.Instantiate(var_98_0, arg_95_1.canvasGo_.transform)

					var_98_1.transform:SetSiblingIndex(1)

					var_98_1.name = "1012"
					var_98_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_95_1.actors_["1012"] = var_98_1

					if arg_95_1.isInRecall_ then
						for iter_98_0, iter_98_1 in ipairs((var_98_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_98_1.color = arg_95_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_98_2 = arg_95_1.actors_["1012"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos1012 = var_98_2.localPosition
				var_98_2.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("1012", 4)

				for iter_98_2 = 0, var_98_2.childCount - 1 do
					local var_98_3 = var_98_2:GetChild(iter_98_2)

					if var_98_3.name == "" or not string.find(var_98_3.name, "split") then
						var_98_3.gameObject:SetActive(true)
					else
						var_98_3.gameObject:SetActive(false)
					end
				end
			end

			local var_98_4 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				var_98_2.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_95_1.time_ - 0) / var_98_4)
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				var_98_2.localPosition = Vector3.New(390, -465, 300)
			end

			local var_98_5 = arg_95_1.actors_["1012"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.actorSpriteComps1012 == nil then
				arg_95_1.var_.actorSpriteComps1012 = var_98_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_6 = 0.034

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_6 and not isNil(var_98_5) then
				if arg_95_1.var_.actorSpriteComps1012 then
					for iter_98_3, iter_98_4 in pairs(arg_95_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_98_4 then
							if arg_95_1.isInRecall_ then
								iter_98_4.color = Color.New(Mathf.Lerp(iter_98_4.color.r, arg_95_1.hightColor2.r, (arg_95_1.time_ - 0) / var_98_6), Mathf.Lerp(iter_98_4.color.g, arg_95_1.hightColor2.g, (arg_95_1.time_ - 0) / var_98_6), (Mathf.Lerp(iter_98_4.color.b, arg_95_1.hightColor2.b, (arg_95_1.time_ - 0) / var_98_6)))
							else
								local var_98_7 = Mathf.Lerp(iter_98_4.color.r, 0.5, (arg_95_1.time_ - 0) / var_98_6)

								iter_98_4.color = Color.New(var_98_7, var_98_7, var_98_7)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= 0 + var_98_6 and arg_95_1.time_ < 0 + var_98_6 + arg_98_0 and not isNil(var_98_5) and arg_95_1.var_.actorSpriteComps1012 then
				for iter_98_5, iter_98_6 in pairs(arg_95_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_98_6 then
						iter_98_6.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_95_1.var_.actorSpriteComps1012 = nil
			end

			local var_98_8 = arg_95_1.actors_["10064"].transform

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10064 = var_98_8.localPosition
				var_98_8.localScale = Vector3.New(1, 1, 1)

				arg_95_1:CheckSpriteTmpPos("10064", 2)

				for iter_98_7 = 0, var_98_8.childCount - 1 do
					local var_98_9 = var_98_8:GetChild(iter_98_7)

					if var_98_9.name == "split_3" or not string.find(var_98_9.name, "split") then
						var_98_9.gameObject:SetActive(true)
					else
						var_98_9.gameObject:SetActive(false)
					end
				end
			end

			local var_98_10 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_10 then
				var_98_8.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10064, Vector3.New(-390, -570, 192.5), (arg_95_1.time_ - 0) / var_98_10)
			end

			if arg_95_1.time_ >= 0 + var_98_10 and arg_95_1.time_ < 0 + var_98_10 + arg_98_0 then
				var_98_8.localPosition = Vector3.New(-390, -570, 192.5)
			end

			local var_98_11 = arg_95_1.actors_["10064"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_11) and arg_95_1.var_.actorSpriteComps10064 == nil then
				arg_95_1.var_.actorSpriteComps10064 = var_98_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_98_12 = 0.034

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_12 and not isNil(var_98_11) then
				if arg_95_1.var_.actorSpriteComps10064 then
					for iter_98_8, iter_98_9 in pairs(arg_95_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_98_9 then
							if arg_95_1.isInRecall_ then
								iter_98_9.color = Color.New(Mathf.Lerp(iter_98_9.color.r, arg_95_1.hightColor2.r, (arg_95_1.time_ - 0) / var_98_12), Mathf.Lerp(iter_98_9.color.g, arg_95_1.hightColor2.g, (arg_95_1.time_ - 0) / var_98_12), (Mathf.Lerp(iter_98_9.color.b, arg_95_1.hightColor2.b, (arg_95_1.time_ - 0) / var_98_12)))
							else
								local var_98_13 = Mathf.Lerp(iter_98_9.color.r, 0.5, (arg_95_1.time_ - 0) / var_98_12)

								iter_98_9.color = Color.New(var_98_13, var_98_13, var_98_13)
							end
						end
					end
				end
			end

			if arg_95_1.time_ >= 0 + var_98_12 and arg_95_1.time_ < 0 + var_98_12 + arg_98_0 and not isNil(var_98_11) and arg_95_1.var_.actorSpriteComps10064 then
				for iter_98_10, iter_98_11 in pairs(arg_95_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_98_11 then
						iter_98_11.color = arg_95_1.isInRecall_ and (arg_95_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_95_1.var_.actorSpriteComps10064 = nil
			end

			local var_98_14 = 0
			local var_98_15 = 1.35

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_14 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, false)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_16 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(410041022).content)

				arg_95_1.text_.text = var_98_16

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_18 = 54 <= 0 and var_98_15 or var_98_15 * (utf8.len(var_98_16) / 54)

				if (54 <= 0 and var_98_15 or var_98_15 * (utf8.len(var_98_16) / 54)) > 0 and var_98_15 < var_98_18 then
					arg_95_1.talkMaxDuration = var_98_18

					if var_98_18 + var_98_14 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_18 + var_98_14
					end
				end

				arg_95_1.text_.text = var_98_16
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_19 = math.max(var_98_15, arg_95_1.talkMaxDuration)

			if var_98_14 <= arg_95_1.time_ and arg_95_1.time_ < var_98_14 + var_98_19 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_14) / var_98_19

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_14 + var_98_19 and arg_95_1.time_ < var_98_14 + var_98_19 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410041023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 410041023
		arg_99_1.duration_ = 3.8

		local var_99_0 = {
			zh = 2.633,
			ja = 3.8
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
				arg_99_0:Play410041024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1012 = arg_99_1.actors_["1012"].transform.localPosition
				arg_99_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_99_1:CheckSpriteTmpPos("1012", 4)

				for iter_102_0 = 0, arg_99_1.actors_["1012"].transform.childCount - 1 do
					local var_102_0 = arg_99_1.actors_["1012"].transform:GetChild(iter_102_0)

					if var_102_0.name == "" or not string.find(var_102_0.name, "split") then
						var_102_0.gameObject:SetActive(true)
					else
						var_102_0.gameObject:SetActive(false)
					end
				end
			end

			local var_102_1 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_1 then
				arg_99_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_99_1.time_ - 0) / var_102_1)
			end

			if arg_99_1.time_ >= 0 + var_102_1 and arg_99_1.time_ < 0 + var_102_1 + arg_102_0 then
				arg_99_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_102_2 = arg_99_1.actors_["1012"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_2) and arg_99_1.var_.actorSpriteComps1012 == nil then
				arg_99_1.var_.actorSpriteComps1012 = var_102_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_102_3 = 0.034

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_3 and not isNil(var_102_2) then
				if arg_99_1.var_.actorSpriteComps1012 then
					for iter_102_1, iter_102_2 in pairs(arg_99_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_99_1.time_ >= 0 + var_102_3 and arg_99_1.time_ < 0 + var_102_3 + arg_102_0 and not isNil(var_102_2) and arg_99_1.var_.actorSpriteComps1012 then
				for iter_102_3, iter_102_4 in pairs(arg_99_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_102_4 then
						iter_102_4.color = arg_99_1.isInRecall_ and (arg_99_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_99_1.var_.actorSpriteComps1012 = nil
			end

			local var_102_5 = 0
			local var_102_6 = 0.1

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_5 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_7 = arg_99_1:GetWordFromCfg(410041023)
				local var_102_8 = arg_99_1:FormatText(var_102_7.content)

				arg_99_1.text_.text = var_102_8

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_10 = 4 <= 0 and var_102_6 or var_102_6 * (utf8.len(var_102_8) / 4)

				if (4 <= 0 and var_102_6 or var_102_6 * (utf8.len(var_102_8) / 4)) > 0 and var_102_6 < var_102_10 then
					arg_99_1.talkMaxDuration = var_102_10

					if var_102_10 + var_102_5 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_10 + var_102_5
					end
				end

				arg_99_1.text_.text = var_102_8
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041023", "story_v_out_410041.awb") ~= 0 then
					local var_102_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041023", "story_v_out_410041.awb") / 1000

					if var_102_11 + var_102_5 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_11 + var_102_5
					end

					if var_102_7.prefab_name ~= "" and arg_99_1.actors_[var_102_7.prefab_name] ~= nil then
						local var_102_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_7.prefab_name].transform, "story_v_out_410041", "410041023", "story_v_out_410041.awb")

						arg_99_1:RecordAudio("410041023", var_102_12)
						arg_99_1:RecordAudio("410041023", var_102_12)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_410041", "410041023", "story_v_out_410041.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_410041", "410041023", "story_v_out_410041.awb")
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
				actorName = "1012",
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
	Play410041024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 410041024
		arg_103_1.duration_ = 2.7

		local var_103_0 = {
			zh = 2.7,
			ja = 2.366
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
				arg_103_0:Play410041025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1012 = arg_103_1.actors_["1012"].transform.localPosition
				arg_103_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("1012", 4)

				for iter_106_0 = 0, arg_103_1.actors_["1012"].transform.childCount - 1 do
					local var_106_0 = arg_103_1.actors_["1012"].transform:GetChild(iter_106_0)

					if var_106_0.name == "" or not string.find(var_106_0.name, "split") then
						var_106_0.gameObject:SetActive(true)
					else
						var_106_0.gameObject:SetActive(false)
					end
				end
			end

			local var_106_1 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_1 then
				arg_103_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_103_1.time_ - 0) / var_106_1)
			end

			if arg_103_1.time_ >= 0 + var_106_1 and arg_103_1.time_ < 0 + var_106_1 + arg_106_0 then
				arg_103_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_106_2 = arg_103_1.actors_["1012"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.actorSpriteComps1012 == nil then
				arg_103_1.var_.actorSpriteComps1012 = var_106_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_3 = 0.034

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_3 and not isNil(var_106_2) then
				if arg_103_1.var_.actorSpriteComps1012 then
					for iter_106_1, iter_106_2 in pairs(arg_103_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_106_2 then
							if arg_103_1.isInRecall_ then
								iter_106_2.color = Color.New(Mathf.Lerp(iter_106_2.color.r, arg_103_1.hightColor2.r, (arg_103_1.time_ - 0) / var_106_3), Mathf.Lerp(iter_106_2.color.g, arg_103_1.hightColor2.g, (arg_103_1.time_ - 0) / var_106_3), (Mathf.Lerp(iter_106_2.color.b, arg_103_1.hightColor2.b, (arg_103_1.time_ - 0) / var_106_3)))
							else
								local var_106_4 = Mathf.Lerp(iter_106_2.color.r, 0.5, (arg_103_1.time_ - 0) / var_106_3)

								iter_106_2.color = Color.New(var_106_4, var_106_4, var_106_4)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_3 and arg_103_1.time_ < 0 + var_106_3 + arg_106_0 and not isNil(var_106_2) and arg_103_1.var_.actorSpriteComps1012 then
				for iter_106_3, iter_106_4 in pairs(arg_103_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_106_4 then
						iter_106_4.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_103_1.var_.actorSpriteComps1012 = nil
			end

			local var_106_5 = arg_103_1.actors_["10064"].transform

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos10064 = var_106_5.localPosition
				var_106_5.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("10064", 2)

				for iter_106_5 = 0, var_106_5.childCount - 1 do
					local var_106_6 = var_106_5:GetChild(iter_106_5)

					if var_106_6.name == "split_3" or not string.find(var_106_6.name, "split") then
						var_106_6.gameObject:SetActive(true)
					else
						var_106_6.gameObject:SetActive(false)
					end
				end
			end

			local var_106_7 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 then
				var_106_5.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10064, Vector3.New(-390, -570, 192.5), (arg_103_1.time_ - 0) / var_106_7)
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 then
				var_106_5.localPosition = Vector3.New(-390, -570, 192.5)
			end

			local var_106_8 = arg_103_1.actors_["10064"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_8) and arg_103_1.var_.actorSpriteComps10064 == nil then
				arg_103_1.var_.actorSpriteComps10064 = var_106_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_9 = 0.034

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_9 and not isNil(var_106_8) then
				if arg_103_1.var_.actorSpriteComps10064 then
					for iter_106_6, iter_106_7 in pairs(arg_103_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_106_7 then
							if arg_103_1.isInRecall_ then
								iter_106_7.color = Color.New(Mathf.Lerp(iter_106_7.color.r, arg_103_1.hightColor1.r, (arg_103_1.time_ - 0) / var_106_9), Mathf.Lerp(iter_106_7.color.g, arg_103_1.hightColor1.g, (arg_103_1.time_ - 0) / var_106_9), (Mathf.Lerp(iter_106_7.color.b, arg_103_1.hightColor1.b, (arg_103_1.time_ - 0) / var_106_9)))
							else
								local var_106_10 = Mathf.Lerp(iter_106_7.color.r, 1, (arg_103_1.time_ - 0) / var_106_9)

								iter_106_7.color = Color.New(var_106_10, var_106_10, var_106_10)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_9 and arg_103_1.time_ < 0 + var_106_9 + arg_106_0 and not isNil(var_106_8) and arg_103_1.var_.actorSpriteComps10064 then
				for iter_106_8, iter_106_9 in pairs(arg_103_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_106_9 then
						iter_106_9.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_103_1.var_.actorSpriteComps10064 = nil
			end

			local var_106_11 = 0
			local var_106_12 = 0.1

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_11 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_13 = arg_103_1:GetWordFromCfg(410041024)
				local var_106_14 = arg_103_1:FormatText(var_106_13.content)

				arg_103_1.text_.text = var_106_14

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_16 = 4 <= 0 and var_106_12 or var_106_12 * (utf8.len(var_106_14) / 4)

				if (4 <= 0 and var_106_12 or var_106_12 * (utf8.len(var_106_14) / 4)) > 0 and var_106_12 < var_106_16 then
					arg_103_1.talkMaxDuration = var_106_16

					if var_106_16 + var_106_11 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_16 + var_106_11
					end
				end

				arg_103_1.text_.text = var_106_14
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041024", "story_v_out_410041.awb") ~= 0 then
					local var_106_17 = manager.audio:GetVoiceLength("story_v_out_410041", "410041024", "story_v_out_410041.awb") / 1000

					if var_106_17 + var_106_11 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_17 + var_106_11
					end

					if var_106_13.prefab_name ~= "" and arg_103_1.actors_[var_106_13.prefab_name] ~= nil then
						local var_106_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_13.prefab_name].transform, "story_v_out_410041", "410041024", "story_v_out_410041.awb")

						arg_103_1:RecordAudio("410041024", var_106_18)
						arg_103_1:RecordAudio("410041024", var_106_18)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_410041", "410041024", "story_v_out_410041.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_410041", "410041024", "story_v_out_410041.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_19 = math.max(var_106_12, arg_103_1.talkMaxDuration)

			if var_106_11 <= arg_103_1.time_ and arg_103_1.time_ < var_106_11 + var_106_19 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_11) / var_106_19

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_11 + var_106_19 and arg_103_1.time_ < var_106_11 + var_106_19 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410041025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 410041025
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play410041026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["10064"]) and arg_107_1.var_.actorSpriteComps10064 == nil then
				arg_107_1.var_.actorSpriteComps10064 = arg_107_1.actors_["10064"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_0 = 0.034

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["10064"]) then
				if arg_107_1.var_.actorSpriteComps10064 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps10064:ToTable()) do
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

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["10064"]) and arg_107_1.var_.actorSpriteComps10064 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_110_3 then
						iter_110_3.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_107_1.var_.actorSpriteComps10064 = nil
			end

			local var_110_2 = 0
			local var_110_3 = 0.675

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

				local var_110_4 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(410041025).content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_6 = 27 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_4) / 27)

				if (27 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_4) / 27)) > 0 and var_110_3 < var_110_6 then
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

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play410041026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 410041026
		arg_111_1.duration_ = 4.17

		local var_111_0 = {
			zh = 1.633,
			ja = 4.166
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
				arg_111_0:Play410041027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1012 = arg_111_1.actors_["1012"].transform.localPosition
				arg_111_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("1012", 4)

				for iter_114_0 = 0, arg_111_1.actors_["1012"].transform.childCount - 1 do
					local var_114_0 = arg_111_1.actors_["1012"].transform:GetChild(iter_114_0)

					if var_114_0.name == "split_3" or not string.find(var_114_0.name, "split") then
						var_114_0.gameObject:SetActive(true)
					else
						var_114_0.gameObject:SetActive(false)
					end
				end
			end

			local var_114_1 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 then
				arg_111_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_111_1.time_ - 0) / var_114_1)
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 then
				arg_111_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_114_2 = arg_111_1.actors_["1012"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps1012 == nil then
				arg_111_1.var_.actorSpriteComps1012 = var_114_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_3 = 0.034

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_3 and not isNil(var_114_2) then
				if arg_111_1.var_.actorSpriteComps1012 then
					for iter_114_1, iter_114_2 in pairs(arg_111_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_114_2 then
							if arg_111_1.isInRecall_ then
								iter_114_2.color = Color.New(Mathf.Lerp(iter_114_2.color.r, arg_111_1.hightColor1.r, (arg_111_1.time_ - 0) / var_114_3), Mathf.Lerp(iter_114_2.color.g, arg_111_1.hightColor1.g, (arg_111_1.time_ - 0) / var_114_3), (Mathf.Lerp(iter_114_2.color.b, arg_111_1.hightColor1.b, (arg_111_1.time_ - 0) / var_114_3)))
							else
								local var_114_4 = Mathf.Lerp(iter_114_2.color.r, 1, (arg_111_1.time_ - 0) / var_114_3)

								iter_114_2.color = Color.New(var_114_4, var_114_4, var_114_4)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_3 and arg_111_1.time_ < 0 + var_114_3 + arg_114_0 and not isNil(var_114_2) and arg_111_1.var_.actorSpriteComps1012 then
				for iter_114_3, iter_114_4 in pairs(arg_111_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_114_4 then
						iter_114_4.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_111_1.var_.actorSpriteComps1012 = nil
			end

			local var_114_5 = 0
			local var_114_6 = 0.15

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_7 = arg_111_1:GetWordFromCfg(410041026)
				local var_114_8 = arg_111_1:FormatText(var_114_7.content)

				arg_111_1.text_.text = var_114_8

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_10 = 6 <= 0 and var_114_6 or var_114_6 * (utf8.len(var_114_8) / 6)

				if (6 <= 0 and var_114_6 or var_114_6 * (utf8.len(var_114_8) / 6)) > 0 and var_114_6 < var_114_10 then
					arg_111_1.talkMaxDuration = var_114_10

					if var_114_10 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_5
					end
				end

				arg_111_1.text_.text = var_114_8
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041026", "story_v_out_410041.awb") ~= 0 then
					local var_114_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041026", "story_v_out_410041.awb") / 1000

					if var_114_11 + var_114_5 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_11 + var_114_5
					end

					if var_114_7.prefab_name ~= "" and arg_111_1.actors_[var_114_7.prefab_name] ~= nil then
						local var_114_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_7.prefab_name].transform, "story_v_out_410041", "410041026", "story_v_out_410041.awb")

						arg_111_1:RecordAudio("410041026", var_114_12)
						arg_111_1:RecordAudio("410041026", var_114_12)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_410041", "410041026", "story_v_out_410041.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_410041", "410041026", "story_v_out_410041.awb")
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

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play410041027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 410041027
		arg_115_1.duration_ = 3.57

		local var_115_0 = {
			zh = 1.2,
			ja = 3.566
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
				arg_115_0:Play410041028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos1012 = arg_115_1.actors_["1012"].transform.localPosition
				arg_115_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("1012", 4)

				for iter_118_0 = 0, arg_115_1.actors_["1012"].transform.childCount - 1 do
					local var_118_0 = arg_115_1.actors_["1012"].transform:GetChild(iter_118_0)

					if var_118_0.name == "" or not string.find(var_118_0.name, "split") then
						var_118_0.gameObject:SetActive(true)
					else
						var_118_0.gameObject:SetActive(false)
					end
				end
			end

			local var_118_1 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_1 then
				arg_115_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_115_1.time_ - 0) / var_118_1)
			end

			if arg_115_1.time_ >= 0 + var_118_1 and arg_115_1.time_ < 0 + var_118_1 + arg_118_0 then
				arg_115_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_118_2 = arg_115_1.actors_["1012"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps1012 == nil then
				arg_115_1.var_.actorSpriteComps1012 = var_118_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_3 = 0.034

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_3 and not isNil(var_118_2) then
				if arg_115_1.var_.actorSpriteComps1012 then
					for iter_118_1, iter_118_2 in pairs(arg_115_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_118_2 then
							if arg_115_1.isInRecall_ then
								iter_118_2.color = Color.New(Mathf.Lerp(iter_118_2.color.r, arg_115_1.hightColor2.r, (arg_115_1.time_ - 0) / var_118_3), Mathf.Lerp(iter_118_2.color.g, arg_115_1.hightColor2.g, (arg_115_1.time_ - 0) / var_118_3), (Mathf.Lerp(iter_118_2.color.b, arg_115_1.hightColor2.b, (arg_115_1.time_ - 0) / var_118_3)))
							else
								local var_118_4 = Mathf.Lerp(iter_118_2.color.r, 0.5, (arg_115_1.time_ - 0) / var_118_3)

								iter_118_2.color = Color.New(var_118_4, var_118_4, var_118_4)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_3 and arg_115_1.time_ < 0 + var_118_3 + arg_118_0 and not isNil(var_118_2) and arg_115_1.var_.actorSpriteComps1012 then
				for iter_118_3, iter_118_4 in pairs(arg_115_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_118_4 then
						iter_118_4.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_115_1.var_.actorSpriteComps1012 = nil
			end

			local var_118_5 = arg_115_1.actors_["10064"].transform

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.var_.moveOldPos10064 = var_118_5.localPosition
				var_118_5.localScale = Vector3.New(1, 1, 1)

				arg_115_1:CheckSpriteTmpPos("10064", 2)

				for iter_118_5 = 0, var_118_5.childCount - 1 do
					local var_118_6 = var_118_5:GetChild(iter_118_5)

					if var_118_6.name == "split_3" or not string.find(var_118_6.name, "split") then
						var_118_6.gameObject:SetActive(true)
					else
						var_118_6.gameObject:SetActive(false)
					end
				end
			end

			local var_118_7 = 0.001

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_7 then
				var_118_5.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10064, Vector3.New(-390, -570, 192.5), (arg_115_1.time_ - 0) / var_118_7)
			end

			if arg_115_1.time_ >= 0 + var_118_7 and arg_115_1.time_ < 0 + var_118_7 + arg_118_0 then
				var_118_5.localPosition = Vector3.New(-390, -570, 192.5)
			end

			local var_118_8 = arg_115_1.actors_["10064"]

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(var_118_8) and arg_115_1.var_.actorSpriteComps10064 == nil then
				arg_115_1.var_.actorSpriteComps10064 = var_118_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_118_9 = 0.034

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_9 and not isNil(var_118_8) then
				if arg_115_1.var_.actorSpriteComps10064 then
					for iter_118_6, iter_118_7 in pairs(arg_115_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_118_7 then
							if arg_115_1.isInRecall_ then
								iter_118_7.color = Color.New(Mathf.Lerp(iter_118_7.color.r, arg_115_1.hightColor1.r, (arg_115_1.time_ - 0) / var_118_9), Mathf.Lerp(iter_118_7.color.g, arg_115_1.hightColor1.g, (arg_115_1.time_ - 0) / var_118_9), (Mathf.Lerp(iter_118_7.color.b, arg_115_1.hightColor1.b, (arg_115_1.time_ - 0) / var_118_9)))
							else
								local var_118_10 = Mathf.Lerp(iter_118_7.color.r, 1, (arg_115_1.time_ - 0) / var_118_9)

								iter_118_7.color = Color.New(var_118_10, var_118_10, var_118_10)
							end
						end
					end
				end
			end

			if arg_115_1.time_ >= 0 + var_118_9 and arg_115_1.time_ < 0 + var_118_9 + arg_118_0 and not isNil(var_118_8) and arg_115_1.var_.actorSpriteComps10064 then
				for iter_118_8, iter_118_9 in pairs(arg_115_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_118_9 then
						iter_118_9.color = arg_115_1.isInRecall_ and (arg_115_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_115_1.var_.actorSpriteComps10064 = nil
			end

			local var_118_11 = 0
			local var_118_12 = 0.1

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_11 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_13 = arg_115_1:GetWordFromCfg(410041027)
				local var_118_14 = arg_115_1:FormatText(var_118_13.content)

				arg_115_1.text_.text = var_118_14

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_16 = 4 <= 0 and var_118_12 or var_118_12 * (utf8.len(var_118_14) / 4)

				if (4 <= 0 and var_118_12 or var_118_12 * (utf8.len(var_118_14) / 4)) > 0 and var_118_12 < var_118_16 then
					arg_115_1.talkMaxDuration = var_118_16

					if var_118_16 + var_118_11 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_16 + var_118_11
					end
				end

				arg_115_1.text_.text = var_118_14
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041027", "story_v_out_410041.awb") ~= 0 then
					local var_118_17 = manager.audio:GetVoiceLength("story_v_out_410041", "410041027", "story_v_out_410041.awb") / 1000

					if var_118_17 + var_118_11 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_17 + var_118_11
					end

					if var_118_13.prefab_name ~= "" and arg_115_1.actors_[var_118_13.prefab_name] ~= nil then
						local var_118_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_13.prefab_name].transform, "story_v_out_410041", "410041027", "story_v_out_410041.awb")

						arg_115_1:RecordAudio("410041027", var_118_18)
						arg_115_1:RecordAudio("410041027", var_118_18)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_410041", "410041027", "story_v_out_410041.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_410041", "410041027", "story_v_out_410041.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_19 = math.max(var_118_12, arg_115_1.talkMaxDuration)

			if var_118_11 <= arg_115_1.time_ and arg_115_1.time_ < var_118_11 + var_118_19 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_11) / var_118_19

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_11 + var_118_19 and arg_115_1.time_ < var_118_11 + var_118_19 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410041028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 410041028
		arg_119_1.duration_ = 12.17

		local var_119_0 = {
			zh = 6.333,
			ja = 12.166
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
				arg_119_0:Play410041029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1012 = arg_119_1.actors_["1012"].transform.localPosition
				arg_119_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("1012", 4)

				for iter_122_0 = 0, arg_119_1.actors_["1012"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["1012"].transform:GetChild(iter_122_0)

					if var_122_0.name == "split_3" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_122_2 = arg_119_1.actors_["1012"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps1012 == nil then
				arg_119_1.var_.actorSpriteComps1012 = var_122_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_3 = 0.034

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 and not isNil(var_122_2) then
				if arg_119_1.var_.actorSpriteComps1012 then
					for iter_122_1, iter_122_2 in pairs(arg_119_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_122_2 then
							if arg_119_1.isInRecall_ then
								iter_122_2.color = Color.New(Mathf.Lerp(iter_122_2.color.r, arg_119_1.hightColor1.r, (arg_119_1.time_ - 0) / var_122_3), Mathf.Lerp(iter_122_2.color.g, arg_119_1.hightColor1.g, (arg_119_1.time_ - 0) / var_122_3), (Mathf.Lerp(iter_122_2.color.b, arg_119_1.hightColor1.b, (arg_119_1.time_ - 0) / var_122_3)))
							else
								local var_122_4 = Mathf.Lerp(iter_122_2.color.r, 1, (arg_119_1.time_ - 0) / var_122_3)

								iter_122_2.color = Color.New(var_122_4, var_122_4, var_122_4)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 and not isNil(var_122_2) and arg_119_1.var_.actorSpriteComps1012 then
				for iter_122_3, iter_122_4 in pairs(arg_119_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_122_4 then
						iter_122_4.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_119_1.var_.actorSpriteComps1012 = nil
			end

			local var_122_5 = arg_119_1.actors_["10064"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10064 = var_122_5.localPosition
				var_122_5.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10064", 2)

				for iter_122_5 = 0, var_122_5.childCount - 1 do
					local var_122_6 = var_122_5:GetChild(iter_122_5)

					if var_122_6.name == "split_3" or not string.find(var_122_6.name, "split") then
						var_122_6.gameObject:SetActive(true)
					else
						var_122_6.gameObject:SetActive(false)
					end
				end
			end

			local var_122_7 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 then
				var_122_5.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10064, Vector3.New(-390, -570, 192.5), (arg_119_1.time_ - 0) / var_122_7)
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 then
				var_122_5.localPosition = Vector3.New(-390, -570, 192.5)
			end

			local var_122_8 = arg_119_1.actors_["10064"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_8) and arg_119_1.var_.actorSpriteComps10064 == nil then
				arg_119_1.var_.actorSpriteComps10064 = var_122_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_122_9 = 0.034

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_9 and not isNil(var_122_8) then
				if arg_119_1.var_.actorSpriteComps10064 then
					for iter_122_6, iter_122_7 in pairs(arg_119_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_122_7 then
							if arg_119_1.isInRecall_ then
								iter_122_7.color = Color.New(Mathf.Lerp(iter_122_7.color.r, arg_119_1.hightColor2.r, (arg_119_1.time_ - 0) / var_122_9), Mathf.Lerp(iter_122_7.color.g, arg_119_1.hightColor2.g, (arg_119_1.time_ - 0) / var_122_9), (Mathf.Lerp(iter_122_7.color.b, arg_119_1.hightColor2.b, (arg_119_1.time_ - 0) / var_122_9)))
							else
								local var_122_10 = Mathf.Lerp(iter_122_7.color.r, 0.5, (arg_119_1.time_ - 0) / var_122_9)

								iter_122_7.color = Color.New(var_122_10, var_122_10, var_122_10)
							end
						end
					end
				end
			end

			if arg_119_1.time_ >= 0 + var_122_9 and arg_119_1.time_ < 0 + var_122_9 + arg_122_0 and not isNil(var_122_8) and arg_119_1.var_.actorSpriteComps10064 then
				for iter_122_8, iter_122_9 in pairs(arg_119_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_122_9 then
						iter_122_9.color = arg_119_1.isInRecall_ and (arg_119_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_119_1.var_.actorSpriteComps10064 = nil
			end

			local var_122_11 = 0
			local var_122_12 = 0.8

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_11 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_13 = arg_119_1:GetWordFromCfg(410041028)
				local var_122_14 = arg_119_1:FormatText(var_122_13.content)

				arg_119_1.text_.text = var_122_14

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_16 = 32 <= 0 and var_122_12 or var_122_12 * (utf8.len(var_122_14) / 32)

				if (32 <= 0 and var_122_12 or var_122_12 * (utf8.len(var_122_14) / 32)) > 0 and var_122_12 < var_122_16 then
					arg_119_1.talkMaxDuration = var_122_16

					if var_122_16 + var_122_11 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_16 + var_122_11
					end
				end

				arg_119_1.text_.text = var_122_14
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041028", "story_v_out_410041.awb") ~= 0 then
					local var_122_17 = manager.audio:GetVoiceLength("story_v_out_410041", "410041028", "story_v_out_410041.awb") / 1000

					if var_122_17 + var_122_11 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_17 + var_122_11
					end

					if var_122_13.prefab_name ~= "" and arg_119_1.actors_[var_122_13.prefab_name] ~= nil then
						local var_122_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_13.prefab_name].transform, "story_v_out_410041", "410041028", "story_v_out_410041.awb")

						arg_119_1:RecordAudio("410041028", var_122_18)
						arg_119_1:RecordAudio("410041028", var_122_18)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_410041", "410041028", "story_v_out_410041.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_410041", "410041028", "story_v_out_410041.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_19 = math.max(var_122_12, arg_119_1.talkMaxDuration)

			if var_122_11 <= arg_119_1.time_ and arg_119_1.time_ < var_122_11 + var_122_19 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_11) / var_122_19

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_11 + var_122_19 and arg_119_1.time_ < var_122_11 + var_122_19 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play410041029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 410041029
		arg_123_1.duration_ = 9

		local var_123_0 = {
			zh = 6.866,
			ja = 9
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
				arg_123_0:Play410041030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1012 = arg_123_1.actors_["1012"].transform.localPosition
				arg_123_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("1012", 4)

				for iter_126_0 = 0, arg_123_1.actors_["1012"].transform.childCount - 1 do
					local var_126_0 = arg_123_1.actors_["1012"].transform:GetChild(iter_126_0)

					if var_126_0.name == "split_3" or not string.find(var_126_0.name, "split") then
						var_126_0.gameObject:SetActive(true)
					else
						var_126_0.gameObject:SetActive(false)
					end
				end
			end

			local var_126_1 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				arg_123_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_123_1.time_ - 0) / var_126_1)
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 then
				arg_123_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_126_2 = arg_123_1.actors_["1012"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps1012 == nil then
				arg_123_1.var_.actorSpriteComps1012 = var_126_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_3 = 0.034

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_3 and not isNil(var_126_2) then
				if arg_123_1.var_.actorSpriteComps1012 then
					for iter_126_1, iter_126_2 in pairs(arg_123_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_126_2 then
							if arg_123_1.isInRecall_ then
								iter_126_2.color = Color.New(Mathf.Lerp(iter_126_2.color.r, arg_123_1.hightColor2.r, (arg_123_1.time_ - 0) / var_126_3), Mathf.Lerp(iter_126_2.color.g, arg_123_1.hightColor2.g, (arg_123_1.time_ - 0) / var_126_3), (Mathf.Lerp(iter_126_2.color.b, arg_123_1.hightColor2.b, (arg_123_1.time_ - 0) / var_126_3)))
							else
								local var_126_4 = Mathf.Lerp(iter_126_2.color.r, 0.5, (arg_123_1.time_ - 0) / var_126_3)

								iter_126_2.color = Color.New(var_126_4, var_126_4, var_126_4)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_3 and arg_123_1.time_ < 0 + var_126_3 + arg_126_0 and not isNil(var_126_2) and arg_123_1.var_.actorSpriteComps1012 then
				for iter_126_3, iter_126_4 in pairs(arg_123_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_126_4 then
						iter_126_4.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps1012 = nil
			end

			local var_126_5 = arg_123_1.actors_["10064"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10064 = var_126_5.localPosition
				var_126_5.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("10064", 2)

				for iter_126_5 = 0, var_126_5.childCount - 1 do
					local var_126_6 = var_126_5:GetChild(iter_126_5)

					if var_126_6.name == "split_3" or not string.find(var_126_6.name, "split") then
						var_126_6.gameObject:SetActive(true)
					else
						var_126_6.gameObject:SetActive(false)
					end
				end
			end

			local var_126_7 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				var_126_5.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10064, Vector3.New(-390, -570, 192.5), (arg_123_1.time_ - 0) / var_126_7)
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				var_126_5.localPosition = Vector3.New(-390, -570, 192.5)
			end

			local var_126_8 = arg_123_1.actors_["10064"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_8) and arg_123_1.var_.actorSpriteComps10064 == nil then
				arg_123_1.var_.actorSpriteComps10064 = var_126_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_9 = 0.034

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_9 and not isNil(var_126_8) then
				if arg_123_1.var_.actorSpriteComps10064 then
					for iter_126_6, iter_126_7 in pairs(arg_123_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_126_7 then
							if arg_123_1.isInRecall_ then
								iter_126_7.color = Color.New(Mathf.Lerp(iter_126_7.color.r, arg_123_1.hightColor1.r, (arg_123_1.time_ - 0) / var_126_9), Mathf.Lerp(iter_126_7.color.g, arg_123_1.hightColor1.g, (arg_123_1.time_ - 0) / var_126_9), (Mathf.Lerp(iter_126_7.color.b, arg_123_1.hightColor1.b, (arg_123_1.time_ - 0) / var_126_9)))
							else
								local var_126_10 = Mathf.Lerp(iter_126_7.color.r, 1, (arg_123_1.time_ - 0) / var_126_9)

								iter_126_7.color = Color.New(var_126_10, var_126_10, var_126_10)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_9 and arg_123_1.time_ < 0 + var_126_9 + arg_126_0 and not isNil(var_126_8) and arg_123_1.var_.actorSpriteComps10064 then
				for iter_126_8, iter_126_9 in pairs(arg_123_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_126_9 then
						iter_126_9.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_123_1.var_.actorSpriteComps10064 = nil
			end

			local var_126_11 = 0
			local var_126_12 = 0.875

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_11 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_13 = arg_123_1:GetWordFromCfg(410041029)
				local var_126_14 = arg_123_1:FormatText(var_126_13.content)

				arg_123_1.text_.text = var_126_14

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_16 = 35 <= 0 and var_126_12 or var_126_12 * (utf8.len(var_126_14) / 35)

				if (35 <= 0 and var_126_12 or var_126_12 * (utf8.len(var_126_14) / 35)) > 0 and var_126_12 < var_126_16 then
					arg_123_1.talkMaxDuration = var_126_16

					if var_126_16 + var_126_11 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_16 + var_126_11
					end
				end

				arg_123_1.text_.text = var_126_14
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041029", "story_v_out_410041.awb") ~= 0 then
					local var_126_17 = manager.audio:GetVoiceLength("story_v_out_410041", "410041029", "story_v_out_410041.awb") / 1000

					if var_126_17 + var_126_11 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_17 + var_126_11
					end

					if var_126_13.prefab_name ~= "" and arg_123_1.actors_[var_126_13.prefab_name] ~= nil then
						local var_126_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_13.prefab_name].transform, "story_v_out_410041", "410041029", "story_v_out_410041.awb")

						arg_123_1:RecordAudio("410041029", var_126_18)
						arg_123_1:RecordAudio("410041029", var_126_18)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_410041", "410041029", "story_v_out_410041.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_410041", "410041029", "story_v_out_410041.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_19 = math.max(var_126_12, arg_123_1.talkMaxDuration)

			if var_126_11 <= arg_123_1.time_ and arg_123_1.time_ < var_126_11 + var_126_19 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_11) / var_126_19

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_11 + var_126_19 and arg_123_1.time_ < var_126_11 + var_126_19 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410041030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 410041030
		arg_127_1.duration_ = 9

		local var_127_0 = {
			zh = 4.133,
			ja = 9
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
				arg_127_0:Play410041031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1012 = arg_127_1.actors_["1012"].transform.localPosition
				arg_127_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("1012", 4)

				for iter_130_0 = 0, arg_127_1.actors_["1012"].transform.childCount - 1 do
					local var_130_0 = arg_127_1.actors_["1012"].transform:GetChild(iter_130_0)

					if var_130_0.name == "split_3" or not string.find(var_130_0.name, "split") then
						var_130_0.gameObject:SetActive(true)
					else
						var_130_0.gameObject:SetActive(false)
					end
				end
			end

			local var_130_1 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_1 then
				arg_127_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_127_1.time_ - 0) / var_130_1)
			end

			if arg_127_1.time_ >= 0 + var_130_1 and arg_127_1.time_ < 0 + var_130_1 + arg_130_0 then
				arg_127_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_130_2 = arg_127_1.actors_["1012"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps1012 == nil then
				arg_127_1.var_.actorSpriteComps1012 = var_130_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_3 = 0.034

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_3 and not isNil(var_130_2) then
				if arg_127_1.var_.actorSpriteComps1012 then
					for iter_130_1, iter_130_2 in pairs(arg_127_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_130_2 then
							if arg_127_1.isInRecall_ then
								iter_130_2.color = Color.New(Mathf.Lerp(iter_130_2.color.r, arg_127_1.hightColor1.r, (arg_127_1.time_ - 0) / var_130_3), Mathf.Lerp(iter_130_2.color.g, arg_127_1.hightColor1.g, (arg_127_1.time_ - 0) / var_130_3), (Mathf.Lerp(iter_130_2.color.b, arg_127_1.hightColor1.b, (arg_127_1.time_ - 0) / var_130_3)))
							else
								local var_130_4 = Mathf.Lerp(iter_130_2.color.r, 1, (arg_127_1.time_ - 0) / var_130_3)

								iter_130_2.color = Color.New(var_130_4, var_130_4, var_130_4)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_3 and arg_127_1.time_ < 0 + var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps1012 then
				for iter_130_3, iter_130_4 in pairs(arg_127_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_130_4 then
						iter_130_4.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps1012 = nil
			end

			local var_130_5 = arg_127_1.actors_["10064"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10064 = var_130_5.localPosition
				var_130_5.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10064", 2)

				for iter_130_5 = 0, var_130_5.childCount - 1 do
					local var_130_6 = var_130_5:GetChild(iter_130_5)

					if var_130_6.name == "split_3" or not string.find(var_130_6.name, "split") then
						var_130_6.gameObject:SetActive(true)
					else
						var_130_6.gameObject:SetActive(false)
					end
				end
			end

			local var_130_7 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				var_130_5.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10064, Vector3.New(-390, -570, 192.5), (arg_127_1.time_ - 0) / var_130_7)
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				var_130_5.localPosition = Vector3.New(-390, -570, 192.5)
			end

			local var_130_8 = arg_127_1.actors_["10064"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps10064 == nil then
				arg_127_1.var_.actorSpriteComps10064 = var_130_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_9 = 0.034

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_9 and not isNil(var_130_8) then
				if arg_127_1.var_.actorSpriteComps10064 then
					for iter_130_6, iter_130_7 in pairs(arg_127_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_130_7 then
							if arg_127_1.isInRecall_ then
								iter_130_7.color = Color.New(Mathf.Lerp(iter_130_7.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_9), Mathf.Lerp(iter_130_7.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_9), (Mathf.Lerp(iter_130_7.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_9)))
							else
								local var_130_10 = Mathf.Lerp(iter_130_7.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_9)

								iter_130_7.color = Color.New(var_130_10, var_130_10, var_130_10)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_9 and arg_127_1.time_ < 0 + var_130_9 + arg_130_0 and not isNil(var_130_8) and arg_127_1.var_.actorSpriteComps10064 then
				for iter_130_8, iter_130_9 in pairs(arg_127_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_130_9 then
						iter_130_9.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps10064 = nil
			end

			local var_130_11 = 0
			local var_130_12 = 0.525

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_11 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_13 = arg_127_1:GetWordFromCfg(410041030)
				local var_130_14 = arg_127_1:FormatText(var_130_13.content)

				arg_127_1.text_.text = var_130_14

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_16 = 21 <= 0 and var_130_12 or var_130_12 * (utf8.len(var_130_14) / 21)

				if (21 <= 0 and var_130_12 or var_130_12 * (utf8.len(var_130_14) / 21)) > 0 and var_130_12 < var_130_16 then
					arg_127_1.talkMaxDuration = var_130_16

					if var_130_16 + var_130_11 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_16 + var_130_11
					end
				end

				arg_127_1.text_.text = var_130_14
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041030", "story_v_out_410041.awb") ~= 0 then
					local var_130_17 = manager.audio:GetVoiceLength("story_v_out_410041", "410041030", "story_v_out_410041.awb") / 1000

					if var_130_17 + var_130_11 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_17 + var_130_11
					end

					if var_130_13.prefab_name ~= "" and arg_127_1.actors_[var_130_13.prefab_name] ~= nil then
						local var_130_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_13.prefab_name].transform, "story_v_out_410041", "410041030", "story_v_out_410041.awb")

						arg_127_1:RecordAudio("410041030", var_130_18)
						arg_127_1:RecordAudio("410041030", var_130_18)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_410041", "410041030", "story_v_out_410041.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_410041", "410041030", "story_v_out_410041.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_19 = math.max(var_130_12, arg_127_1.talkMaxDuration)

			if var_130_11 <= arg_127_1.time_ and arg_127_1.time_ < var_130_11 + var_130_19 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_11) / var_130_19

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_11 + var_130_19 and arg_127_1.time_ < var_130_11 + var_130_19 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410041031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 410041031
		arg_131_1.duration_ = 13.87

		local var_131_0 = {
			zh = 7,
			ja = 13.866
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play410041032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1012 = arg_131_1.actors_["1012"].transform.localPosition
				arg_131_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1012", 4)

				for iter_134_0 = 0, arg_131_1.actors_["1012"].transform.childCount - 1 do
					local var_134_0 = arg_131_1.actors_["1012"].transform:GetChild(iter_134_0)

					if var_134_0.name == "split_3" or not string.find(var_134_0.name, "split") then
						var_134_0.gameObject:SetActive(true)
					else
						var_134_0.gameObject:SetActive(false)
					end
				end
			end

			local var_134_1 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_1 then
				arg_131_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_131_1.time_ - 0) / var_134_1)
			end

			if arg_131_1.time_ >= 0 + var_134_1 and arg_131_1.time_ < 0 + var_134_1 + arg_134_0 then
				arg_131_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_134_2 = arg_131_1.actors_["1012"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps1012 == nil then
				arg_131_1.var_.actorSpriteComps1012 = var_134_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_3 = 0.034

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 and not isNil(var_134_2) then
				if arg_131_1.var_.actorSpriteComps1012 then
					for iter_134_1, iter_134_2 in pairs(arg_131_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_134_2 then
							if arg_131_1.isInRecall_ then
								iter_134_2.color = Color.New(Mathf.Lerp(iter_134_2.color.r, arg_131_1.hightColor2.r, (arg_131_1.time_ - 0) / var_134_3), Mathf.Lerp(iter_134_2.color.g, arg_131_1.hightColor2.g, (arg_131_1.time_ - 0) / var_134_3), (Mathf.Lerp(iter_134_2.color.b, arg_131_1.hightColor2.b, (arg_131_1.time_ - 0) / var_134_3)))
							else
								local var_134_4 = Mathf.Lerp(iter_134_2.color.r, 0.5, (arg_131_1.time_ - 0) / var_134_3)

								iter_134_2.color = Color.New(var_134_4, var_134_4, var_134_4)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.actorSpriteComps1012 then
				for iter_134_3, iter_134_4 in pairs(arg_131_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_134_4 then
						iter_134_4.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_131_1.var_.actorSpriteComps1012 = nil
			end

			local var_134_5 = arg_131_1.actors_["10064"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10064 = var_134_5.localPosition
				var_134_5.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10064", 2)

				for iter_134_5 = 0, var_134_5.childCount - 1 do
					local var_134_6 = var_134_5:GetChild(iter_134_5)

					if var_134_6.name == "split_3" or not string.find(var_134_6.name, "split") then
						var_134_6.gameObject:SetActive(true)
					else
						var_134_6.gameObject:SetActive(false)
					end
				end
			end

			local var_134_7 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				var_134_5.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10064, Vector3.New(-390, -570, 192.5), (arg_131_1.time_ - 0) / var_134_7)
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				var_134_5.localPosition = Vector3.New(-390, -570, 192.5)
			end

			local var_134_8 = arg_131_1.actors_["10064"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_8) and arg_131_1.var_.actorSpriteComps10064 == nil then
				arg_131_1.var_.actorSpriteComps10064 = var_134_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_9 = 0.034

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_9 and not isNil(var_134_8) then
				if arg_131_1.var_.actorSpriteComps10064 then
					for iter_134_6, iter_134_7 in pairs(arg_131_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_134_7 then
							if arg_131_1.isInRecall_ then
								iter_134_7.color = Color.New(Mathf.Lerp(iter_134_7.color.r, arg_131_1.hightColor1.r, (arg_131_1.time_ - 0) / var_134_9), Mathf.Lerp(iter_134_7.color.g, arg_131_1.hightColor1.g, (arg_131_1.time_ - 0) / var_134_9), (Mathf.Lerp(iter_134_7.color.b, arg_131_1.hightColor1.b, (arg_131_1.time_ - 0) / var_134_9)))
							else
								local var_134_10 = Mathf.Lerp(iter_134_7.color.r, 1, (arg_131_1.time_ - 0) / var_134_9)

								iter_134_7.color = Color.New(var_134_10, var_134_10, var_134_10)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_9 and arg_131_1.time_ < 0 + var_134_9 + arg_134_0 and not isNil(var_134_8) and arg_131_1.var_.actorSpriteComps10064 then
				for iter_134_8, iter_134_9 in pairs(arg_131_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_134_9 then
						iter_134_9.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_131_1.var_.actorSpriteComps10064 = nil
			end

			local var_134_11 = 0
			local var_134_12 = 0.675

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_11 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_13 = arg_131_1:GetWordFromCfg(410041031)
				local var_134_14 = arg_131_1:FormatText(var_134_13.content)

				arg_131_1.text_.text = var_134_14

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_16 = 27 <= 0 and var_134_12 or var_134_12 * (utf8.len(var_134_14) / 27)

				if (27 <= 0 and var_134_12 or var_134_12 * (utf8.len(var_134_14) / 27)) > 0 and var_134_12 < var_134_16 then
					arg_131_1.talkMaxDuration = var_134_16

					if var_134_16 + var_134_11 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_16 + var_134_11
					end
				end

				arg_131_1.text_.text = var_134_14
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041031", "story_v_out_410041.awb") ~= 0 then
					local var_134_17 = manager.audio:GetVoiceLength("story_v_out_410041", "410041031", "story_v_out_410041.awb") / 1000

					if var_134_17 + var_134_11 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_17 + var_134_11
					end

					if var_134_13.prefab_name ~= "" and arg_131_1.actors_[var_134_13.prefab_name] ~= nil then
						local var_134_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_13.prefab_name].transform, "story_v_out_410041", "410041031", "story_v_out_410041.awb")

						arg_131_1:RecordAudio("410041031", var_134_18)
						arg_131_1:RecordAudio("410041031", var_134_18)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_410041", "410041031", "story_v_out_410041.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_410041", "410041031", "story_v_out_410041.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_19 = math.max(var_134_12, arg_131_1.talkMaxDuration)

			if var_134_11 <= arg_131_1.time_ and arg_131_1.time_ < var_134_11 + var_134_19 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_11) / var_134_19

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_11 + var_134_19 and arg_131_1.time_ < var_134_11 + var_134_19 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_131_1:InitPlayNodeList()
	end,
	Play410041032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 410041032
		arg_135_1.duration_ = 16.23

		local var_135_0 = {
			zh = 10.666,
			ja = 16.233
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
				arg_135_0:Play410041033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 1.5

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:GetWordFromCfg(410041032)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 60 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 60)

				if (60 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 60)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041032", "story_v_out_410041.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_out_410041", "410041032", "story_v_out_410041.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_out_410041", "410041032", "story_v_out_410041.awb")

						arg_135_1:RecordAudio("410041032", var_138_6)
						arg_135_1:RecordAudio("410041032", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_410041", "410041032", "story_v_out_410041.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_410041", "410041032", "story_v_out_410041.awb")
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
	Play410041033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 410041033
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play410041034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["10064"]) and arg_139_1.var_.actorSpriteComps10064 == nil then
				arg_139_1.var_.actorSpriteComps10064 = arg_139_1.actors_["10064"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 0.034

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["10064"]) then
				if arg_139_1.var_.actorSpriteComps10064 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								iter_142_1.color = Color.New(Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_0), Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_0), (Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_0)))
							else
								local var_142_1 = Mathf.Lerp(iter_142_1.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_0)

								iter_142_1.color = Color.New(var_142_1, var_142_1, var_142_1)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["10064"]) and arg_139_1.var_.actorSpriteComps10064 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps10064 = nil
			end

			local var_142_2 = 0
			local var_142_3 = 1.25

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_4 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(410041033).content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_6 = 50 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_4) / 50)

				if (50 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_4) / 50)) > 0 and var_142_3 < var_142_6 then
					arg_139_1.talkMaxDuration = var_142_6

					if var_142_6 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_2
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_3, arg_139_1.talkMaxDuration)

			if var_142_2 <= arg_139_1.time_ and arg_139_1.time_ < var_142_2 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_2) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_2 + var_142_7 and arg_139_1.time_ < var_142_2 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play410041034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 410041034
		arg_143_1.duration_ = 3.07

		local var_143_0 = {
			zh = 3.066,
			ja = 2.5
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
				arg_143_0:Play410041035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1012 = arg_143_1.actors_["1012"].transform.localPosition
				arg_143_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("1012", 4)

				for iter_146_0 = 0, arg_143_1.actors_["1012"].transform.childCount - 1 do
					local var_146_0 = arg_143_1.actors_["1012"].transform:GetChild(iter_146_0)

					if var_146_0.name == "split_1" or not string.find(var_146_0.name, "split") then
						var_146_0.gameObject:SetActive(true)
					else
						var_146_0.gameObject:SetActive(false)
					end
				end
			end

			local var_146_1 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_1 then
				arg_143_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_143_1.time_ - 0) / var_146_1)
			end

			if arg_143_1.time_ >= 0 + var_146_1 and arg_143_1.time_ < 0 + var_146_1 + arg_146_0 then
				arg_143_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_146_2 = arg_143_1.actors_["1012"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.actorSpriteComps1012 == nil then
				arg_143_1.var_.actorSpriteComps1012 = var_146_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_3 = 0.034

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_3 and not isNil(var_146_2) then
				if arg_143_1.var_.actorSpriteComps1012 then
					for iter_146_1, iter_146_2 in pairs(arg_143_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_146_2 then
							if arg_143_1.isInRecall_ then
								iter_146_2.color = Color.New(Mathf.Lerp(iter_146_2.color.r, arg_143_1.hightColor1.r, (arg_143_1.time_ - 0) / var_146_3), Mathf.Lerp(iter_146_2.color.g, arg_143_1.hightColor1.g, (arg_143_1.time_ - 0) / var_146_3), (Mathf.Lerp(iter_146_2.color.b, arg_143_1.hightColor1.b, (arg_143_1.time_ - 0) / var_146_3)))
							else
								local var_146_4 = Mathf.Lerp(iter_146_2.color.r, 1, (arg_143_1.time_ - 0) / var_146_3)

								iter_146_2.color = Color.New(var_146_4, var_146_4, var_146_4)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_3 and arg_143_1.time_ < 0 + var_146_3 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.actorSpriteComps1012 then
				for iter_146_3, iter_146_4 in pairs(arg_143_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_146_4 then
						iter_146_4.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_143_1.var_.actorSpriteComps1012 = nil
			end

			local var_146_5 = 0
			local var_146_6 = 0.25

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_7 = arg_143_1:GetWordFromCfg(410041034)
				local var_146_8 = arg_143_1:FormatText(var_146_7.content)

				arg_143_1.text_.text = var_146_8

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_10 = 10 <= 0 and var_146_6 or var_146_6 * (utf8.len(var_146_8) / 10)

				if (10 <= 0 and var_146_6 or var_146_6 * (utf8.len(var_146_8) / 10)) > 0 and var_146_6 < var_146_10 then
					arg_143_1.talkMaxDuration = var_146_10

					if var_146_10 + var_146_5 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_5
					end
				end

				arg_143_1.text_.text = var_146_8
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041034", "story_v_out_410041.awb") ~= 0 then
					local var_146_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041034", "story_v_out_410041.awb") / 1000

					if var_146_11 + var_146_5 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_11 + var_146_5
					end

					if var_146_7.prefab_name ~= "" and arg_143_1.actors_[var_146_7.prefab_name] ~= nil then
						local var_146_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_7.prefab_name].transform, "story_v_out_410041", "410041034", "story_v_out_410041.awb")

						arg_143_1:RecordAudio("410041034", var_146_12)
						arg_143_1:RecordAudio("410041034", var_146_12)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_410041", "410041034", "story_v_out_410041.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_410041", "410041034", "story_v_out_410041.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_13 = math.max(var_146_6, arg_143_1.talkMaxDuration)

			if var_146_5 <= arg_143_1.time_ and arg_143_1.time_ < var_146_5 + var_146_13 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_5) / var_146_13

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_5 + var_146_13 and arg_143_1.time_ < var_146_5 + var_146_13 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play410041035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 410041035
		arg_147_1.duration_ = 6.67

		local var_147_0 = {
			zh = 6.233,
			ja = 6.666
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
				arg_147_0:Play410041036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1012 = arg_147_1.actors_["1012"].transform.localPosition
				arg_147_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1012", 4)

				for iter_150_0 = 0, arg_147_1.actors_["1012"].transform.childCount - 1 do
					local var_150_0 = arg_147_1.actors_["1012"].transform:GetChild(iter_150_0)

					if var_150_0.name == "split_3" or not string.find(var_150_0.name, "split") then
						var_150_0.gameObject:SetActive(true)
					else
						var_150_0.gameObject:SetActive(false)
					end
				end
			end

			local var_150_1 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_1 then
				arg_147_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_147_1.time_ - 0) / var_150_1)
			end

			if arg_147_1.time_ >= 0 + var_150_1 and arg_147_1.time_ < 0 + var_150_1 + arg_150_0 then
				arg_147_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_150_2 = arg_147_1.actors_["1012"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps1012 == nil then
				arg_147_1.var_.actorSpriteComps1012 = var_150_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_3 = 0.034

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 and not isNil(var_150_2) then
				if arg_147_1.var_.actorSpriteComps1012 then
					for iter_150_1, iter_150_2 in pairs(arg_147_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_150_2 then
							if arg_147_1.isInRecall_ then
								iter_150_2.color = Color.New(Mathf.Lerp(iter_150_2.color.r, arg_147_1.hightColor2.r, (arg_147_1.time_ - 0) / var_150_3), Mathf.Lerp(iter_150_2.color.g, arg_147_1.hightColor2.g, (arg_147_1.time_ - 0) / var_150_3), (Mathf.Lerp(iter_150_2.color.b, arg_147_1.hightColor2.b, (arg_147_1.time_ - 0) / var_150_3)))
							else
								local var_150_4 = Mathf.Lerp(iter_150_2.color.r, 0.5, (arg_147_1.time_ - 0) / var_150_3)

								iter_150_2.color = Color.New(var_150_4, var_150_4, var_150_4)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 and not isNil(var_150_2) and arg_147_1.var_.actorSpriteComps1012 then
				for iter_150_3, iter_150_4 in pairs(arg_147_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_150_4 then
						iter_150_4.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_147_1.var_.actorSpriteComps1012 = nil
			end

			local var_150_5 = arg_147_1.actors_["10064"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos10064 = var_150_5.localPosition
				var_150_5.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10064", 2)

				for iter_150_5 = 0, var_150_5.childCount - 1 do
					local var_150_6 = var_150_5:GetChild(iter_150_5)

					if var_150_6.name == "split_3" or not string.find(var_150_6.name, "split") then
						var_150_6.gameObject:SetActive(true)
					else
						var_150_6.gameObject:SetActive(false)
					end
				end
			end

			local var_150_7 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 then
				var_150_5.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10064, Vector3.New(-390, -570, 192.5), (arg_147_1.time_ - 0) / var_150_7)
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 then
				var_150_5.localPosition = Vector3.New(-390, -570, 192.5)
			end

			local var_150_8 = arg_147_1.actors_["10064"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_8) and arg_147_1.var_.actorSpriteComps10064 == nil then
				arg_147_1.var_.actorSpriteComps10064 = var_150_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_9 = 0.034

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_9 and not isNil(var_150_8) then
				if arg_147_1.var_.actorSpriteComps10064 then
					for iter_150_6, iter_150_7 in pairs(arg_147_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_150_7 then
							if arg_147_1.isInRecall_ then
								iter_150_7.color = Color.New(Mathf.Lerp(iter_150_7.color.r, arg_147_1.hightColor1.r, (arg_147_1.time_ - 0) / var_150_9), Mathf.Lerp(iter_150_7.color.g, arg_147_1.hightColor1.g, (arg_147_1.time_ - 0) / var_150_9), (Mathf.Lerp(iter_150_7.color.b, arg_147_1.hightColor1.b, (arg_147_1.time_ - 0) / var_150_9)))
							else
								local var_150_10 = Mathf.Lerp(iter_150_7.color.r, 1, (arg_147_1.time_ - 0) / var_150_9)

								iter_150_7.color = Color.New(var_150_10, var_150_10, var_150_10)
							end
						end
					end
				end
			end

			if arg_147_1.time_ >= 0 + var_150_9 and arg_147_1.time_ < 0 + var_150_9 + arg_150_0 and not isNil(var_150_8) and arg_147_1.var_.actorSpriteComps10064 then
				for iter_150_8, iter_150_9 in pairs(arg_147_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_150_9 then
						iter_150_9.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps10064 = nil
			end

			local var_150_11 = 0
			local var_150_12 = 0.425

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_11 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_13 = arg_147_1:GetWordFromCfg(410041035)
				local var_150_14 = arg_147_1:FormatText(var_150_13.content)

				arg_147_1.text_.text = var_150_14

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_16 = 17 <= 0 and var_150_12 or var_150_12 * (utf8.len(var_150_14) / 17)

				if (17 <= 0 and var_150_12 or var_150_12 * (utf8.len(var_150_14) / 17)) > 0 and var_150_12 < var_150_16 then
					arg_147_1.talkMaxDuration = var_150_16

					if var_150_16 + var_150_11 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_16 + var_150_11
					end
				end

				arg_147_1.text_.text = var_150_14
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041035", "story_v_out_410041.awb") ~= 0 then
					local var_150_17 = manager.audio:GetVoiceLength("story_v_out_410041", "410041035", "story_v_out_410041.awb") / 1000

					if var_150_17 + var_150_11 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_17 + var_150_11
					end

					if var_150_13.prefab_name ~= "" and arg_147_1.actors_[var_150_13.prefab_name] ~= nil then
						local var_150_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_13.prefab_name].transform, "story_v_out_410041", "410041035", "story_v_out_410041.awb")

						arg_147_1:RecordAudio("410041035", var_150_18)
						arg_147_1:RecordAudio("410041035", var_150_18)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_410041", "410041035", "story_v_out_410041.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_410041", "410041035", "story_v_out_410041.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_19 = math.max(var_150_12, arg_147_1.talkMaxDuration)

			if var_150_11 <= arg_147_1.time_ and arg_147_1.time_ < var_150_11 + var_150_19 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_11) / var_150_19

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_11 + var_150_19 and arg_147_1.time_ < var_150_11 + var_150_19 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play410041036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 410041036
		arg_151_1.duration_ = 2.27

		local var_151_0 = {
			zh = 2.266,
			ja = 1.966
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play410041037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.25

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:GetWordFromCfg(410041036)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 10 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 10)

				if (10 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 10)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041036", "story_v_out_410041.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_410041", "410041036", "story_v_out_410041.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_410041", "410041036", "story_v_out_410041.awb")

						arg_151_1:RecordAudio("410041036", var_154_6)
						arg_151_1:RecordAudio("410041036", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_410041", "410041036", "story_v_out_410041.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_410041", "410041036", "story_v_out_410041.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_0, arg_151_1.talkMaxDuration)

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - 0) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= 0 + var_154_7 and arg_151_1.time_ < 0 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play410041037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 410041037
		arg_155_1.duration_ = 6.57

		local var_155_0 = {
			zh = 3.566,
			ja = 6.566
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
				arg_155_0:Play410041038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1012 = arg_155_1.actors_["1012"].transform.localPosition
				arg_155_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("1012", 4)

				for iter_158_0 = 0, arg_155_1.actors_["1012"].transform.childCount - 1 do
					local var_158_0 = arg_155_1.actors_["1012"].transform:GetChild(iter_158_0)

					if var_158_0.name == "split_4" or not string.find(var_158_0.name, "split") then
						var_158_0.gameObject:SetActive(true)
					else
						var_158_0.gameObject:SetActive(false)
					end
				end
			end

			local var_158_1 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_1 then
				arg_155_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_155_1.time_ - 0) / var_158_1)
			end

			if arg_155_1.time_ >= 0 + var_158_1 and arg_155_1.time_ < 0 + var_158_1 + arg_158_0 then
				arg_155_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_158_2 = arg_155_1.actors_["1012"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps1012 == nil then
				arg_155_1.var_.actorSpriteComps1012 = var_158_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_3 = 0.034

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_3 and not isNil(var_158_2) then
				if arg_155_1.var_.actorSpriteComps1012 then
					for iter_158_1, iter_158_2 in pairs(arg_155_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_155_1.time_ >= 0 + var_158_3 and arg_155_1.time_ < 0 + var_158_3 + arg_158_0 and not isNil(var_158_2) and arg_155_1.var_.actorSpriteComps1012 then
				for iter_158_3, iter_158_4 in pairs(arg_155_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_158_4 then
						iter_158_4.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_155_1.var_.actorSpriteComps1012 = nil
			end

			local var_158_5 = arg_155_1.actors_["10064"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10064 = var_158_5.localPosition
				var_158_5.localScale = Vector3.New(1, 1, 1)

				arg_155_1:CheckSpriteTmpPos("10064", 2)

				for iter_158_5 = 0, var_158_5.childCount - 1 do
					local var_158_6 = var_158_5:GetChild(iter_158_5)

					if var_158_6.name == "split_3" or not string.find(var_158_6.name, "split") then
						var_158_6.gameObject:SetActive(true)
					else
						var_158_6.gameObject:SetActive(false)
					end
				end
			end

			local var_158_7 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 then
				var_158_5.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10064, Vector3.New(-390, -570, 192.5), (arg_155_1.time_ - 0) / var_158_7)
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 then
				var_158_5.localPosition = Vector3.New(-390, -570, 192.5)
			end

			local var_158_8 = arg_155_1.actors_["10064"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_8) and arg_155_1.var_.actorSpriteComps10064 == nil then
				arg_155_1.var_.actorSpriteComps10064 = var_158_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_9 = 0.034

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_9 and not isNil(var_158_8) then
				if arg_155_1.var_.actorSpriteComps10064 then
					for iter_158_6, iter_158_7 in pairs(arg_155_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_158_7 then
							if arg_155_1.isInRecall_ then
								iter_158_7.color = Color.New(Mathf.Lerp(iter_158_7.color.r, arg_155_1.hightColor2.r, (arg_155_1.time_ - 0) / var_158_9), Mathf.Lerp(iter_158_7.color.g, arg_155_1.hightColor2.g, (arg_155_1.time_ - 0) / var_158_9), (Mathf.Lerp(iter_158_7.color.b, arg_155_1.hightColor2.b, (arg_155_1.time_ - 0) / var_158_9)))
							else
								local var_158_10 = Mathf.Lerp(iter_158_7.color.r, 0.5, (arg_155_1.time_ - 0) / var_158_9)

								iter_158_7.color = Color.New(var_158_10, var_158_10, var_158_10)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_9 and arg_155_1.time_ < 0 + var_158_9 + arg_158_0 and not isNil(var_158_8) and arg_155_1.var_.actorSpriteComps10064 then
				for iter_158_8, iter_158_9 in pairs(arg_155_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_158_9 then
						iter_158_9.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_155_1.var_.actorSpriteComps10064 = nil
			end

			local var_158_11 = 0
			local var_158_12 = 0.3

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_11 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_13 = arg_155_1:GetWordFromCfg(410041037)
				local var_158_14 = arg_155_1:FormatText(var_158_13.content)

				arg_155_1.text_.text = var_158_14

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_16 = 12 <= 0 and var_158_12 or var_158_12 * (utf8.len(var_158_14) / 12)

				if (12 <= 0 and var_158_12 or var_158_12 * (utf8.len(var_158_14) / 12)) > 0 and var_158_12 < var_158_16 then
					arg_155_1.talkMaxDuration = var_158_16

					if var_158_16 + var_158_11 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_16 + var_158_11
					end
				end

				arg_155_1.text_.text = var_158_14
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041037", "story_v_out_410041.awb") ~= 0 then
					local var_158_17 = manager.audio:GetVoiceLength("story_v_out_410041", "410041037", "story_v_out_410041.awb") / 1000

					if var_158_17 + var_158_11 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_17 + var_158_11
					end

					if var_158_13.prefab_name ~= "" and arg_155_1.actors_[var_158_13.prefab_name] ~= nil then
						local var_158_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_13.prefab_name].transform, "story_v_out_410041", "410041037", "story_v_out_410041.awb")

						arg_155_1:RecordAudio("410041037", var_158_18)
						arg_155_1:RecordAudio("410041037", var_158_18)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_410041", "410041037", "story_v_out_410041.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_410041", "410041037", "story_v_out_410041.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_19 = math.max(var_158_12, arg_155_1.talkMaxDuration)

			if var_158_11 <= arg_155_1.time_ and arg_155_1.time_ < var_158_11 + var_158_19 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_11) / var_158_19

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_11 + var_158_19 and arg_155_1.time_ < var_158_11 + var_158_19 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410041038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 410041038
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play410041039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1012 = arg_159_1.actors_["1012"].transform.localPosition
				arg_159_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("1012", 7)

				for iter_162_0 = 0, arg_159_1.actors_["1012"].transform.childCount - 1 do
					local var_162_0 = arg_159_1.actors_["1012"].transform:GetChild(iter_162_0)

					if var_162_0.name == "split_3" or not string.find(var_162_0.name, "split") then
						var_162_0.gameObject:SetActive(true)
					else
						var_162_0.gameObject:SetActive(false)
					end
				end
			end

			local var_162_1 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_1 then
				arg_159_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1012, Vector3.New(0, -2000, 300), (arg_159_1.time_ - 0) / var_162_1)
			end

			if arg_159_1.time_ >= 0 + var_162_1 and arg_159_1.time_ < 0 + var_162_1 + arg_162_0 then
				arg_159_1.actors_["1012"].transform.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_162_2 = arg_159_1.actors_["1012"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.actorSpriteComps1012 == nil then
				arg_159_1.var_.actorSpriteComps1012 = var_162_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_3 = 0.034

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_3 and not isNil(var_162_2) then
				if arg_159_1.var_.actorSpriteComps1012 then
					for iter_162_1, iter_162_2 in pairs(arg_159_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_162_2 then
							if arg_159_1.isInRecall_ then
								iter_162_2.color = Color.New(Mathf.Lerp(iter_162_2.color.r, arg_159_1.hightColor2.r, (arg_159_1.time_ - 0) / var_162_3), Mathf.Lerp(iter_162_2.color.g, arg_159_1.hightColor2.g, (arg_159_1.time_ - 0) / var_162_3), (Mathf.Lerp(iter_162_2.color.b, arg_159_1.hightColor2.b, (arg_159_1.time_ - 0) / var_162_3)))
							else
								local var_162_4 = Mathf.Lerp(iter_162_2.color.r, 0.5, (arg_159_1.time_ - 0) / var_162_3)

								iter_162_2.color = Color.New(var_162_4, var_162_4, var_162_4)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_3 and arg_159_1.time_ < 0 + var_162_3 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.actorSpriteComps1012 then
				for iter_162_3, iter_162_4 in pairs(arg_159_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_162_4 then
						iter_162_4.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_159_1.var_.actorSpriteComps1012 = nil
			end

			local var_162_5 = arg_159_1.actors_["10064"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10064 = var_162_5.localPosition
				var_162_5.localScale = Vector3.New(1, 1, 1)

				arg_159_1:CheckSpriteTmpPos("10064", 7)

				for iter_162_5 = 0, var_162_5.childCount - 1 do
					local var_162_6 = var_162_5:GetChild(iter_162_5)

					if var_162_6.name == "split_3" or not string.find(var_162_6.name, "split") then
						var_162_6.gameObject:SetActive(true)
					else
						var_162_6.gameObject:SetActive(false)
					end
				end
			end

			local var_162_7 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				var_162_5.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10064, Vector3.New(0, -2000, 192.5), (arg_159_1.time_ - 0) / var_162_7)
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				var_162_5.localPosition = Vector3.New(0, -2000, 192.5)
			end

			local var_162_8 = arg_159_1.actors_["10064"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_8) and arg_159_1.var_.actorSpriteComps10064 == nil then
				arg_159_1.var_.actorSpriteComps10064 = var_162_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_9 = 0.034

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_9 and not isNil(var_162_8) then
				if arg_159_1.var_.actorSpriteComps10064 then
					for iter_162_6, iter_162_7 in pairs(arg_159_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_162_7 then
							if arg_159_1.isInRecall_ then
								iter_162_7.color = Color.New(Mathf.Lerp(iter_162_7.color.r, arg_159_1.hightColor1.r, (arg_159_1.time_ - 0) / var_162_9), Mathf.Lerp(iter_162_7.color.g, arg_159_1.hightColor1.g, (arg_159_1.time_ - 0) / var_162_9), (Mathf.Lerp(iter_162_7.color.b, arg_159_1.hightColor1.b, (arg_159_1.time_ - 0) / var_162_9)))
							else
								local var_162_10 = Mathf.Lerp(iter_162_7.color.r, 1, (arg_159_1.time_ - 0) / var_162_9)

								iter_162_7.color = Color.New(var_162_10, var_162_10, var_162_10)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_9 and arg_159_1.time_ < 0 + var_162_9 + arg_162_0 and not isNil(var_162_8) and arg_159_1.var_.actorSpriteComps10064 then
				for iter_162_8, iter_162_9 in pairs(arg_159_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_162_9 then
						iter_162_9.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_159_1.var_.actorSpriteComps10064 = nil
			end

			local var_162_11 = 0
			local var_162_12 = 0.8

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_11 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_13 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(410041038).content)

				arg_159_1.text_.text = var_162_13

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_15 = 32 <= 0 and var_162_12 or var_162_12 * (utf8.len(var_162_13) / 32)

				if (32 <= 0 and var_162_12 or var_162_12 * (utf8.len(var_162_13) / 32)) > 0 and var_162_12 < var_162_15 then
					arg_159_1.talkMaxDuration = var_162_15

					if var_162_15 + var_162_11 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_15 + var_162_11
					end
				end

				arg_159_1.text_.text = var_162_13
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_16 = math.max(var_162_12, arg_159_1.talkMaxDuration)

			if var_162_11 <= arg_159_1.time_ and arg_159_1.time_ < var_162_11 + var_162_16 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_11) / var_162_16

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_11 + var_162_16 and arg_159_1.time_ < var_162_11 + var_162_16 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play410041039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 410041039
		arg_163_1.duration_ = 6.2

		local var_163_0 = {
			zh = 3.666,
			ja = 6.2
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
				arg_163_0:Play410041040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1012 = arg_163_1.actors_["1012"].transform.localPosition
				arg_163_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("1012", 4)

				for iter_166_0 = 0, arg_163_1.actors_["1012"].transform.childCount - 1 do
					local var_166_0 = arg_163_1.actors_["1012"].transform:GetChild(iter_166_0)

					if var_166_0.name == "split_1" or not string.find(var_166_0.name, "split") then
						var_166_0.gameObject:SetActive(true)
					else
						var_166_0.gameObject:SetActive(false)
					end
				end
			end

			local var_166_1 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 then
				arg_163_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1012, Vector3.New(390, -465, 300), (arg_163_1.time_ - 0) / var_166_1)
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["1012"].transform.localPosition = Vector3.New(390, -465, 300)
			end

			local var_166_2 = arg_163_1.actors_["1012"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps1012 == nil then
				arg_163_1.var_.actorSpriteComps1012 = var_166_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_3 = 0.034

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.actorSpriteComps1012 then
					for iter_166_1, iter_166_2 in pairs(arg_163_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_166_2 then
							if arg_163_1.isInRecall_ then
								iter_166_2.color = Color.New(Mathf.Lerp(iter_166_2.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 0) / var_166_3), Mathf.Lerp(iter_166_2.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 0) / var_166_3), (Mathf.Lerp(iter_166_2.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 0) / var_166_3)))
							else
								local var_166_4 = Mathf.Lerp(iter_166_2.color.r, 1, (arg_163_1.time_ - 0) / var_166_3)

								iter_166_2.color = Color.New(var_166_4, var_166_4, var_166_4)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.actorSpriteComps1012 then
				for iter_166_3, iter_166_4 in pairs(arg_163_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_166_4 then
						iter_166_4.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps1012 = nil
			end

			local var_166_5 = arg_163_1.actors_["10064"].transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10064 = var_166_5.localPosition
				var_166_5.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10064", 2)

				for iter_166_5 = 0, var_166_5.childCount - 1 do
					local var_166_6 = var_166_5:GetChild(iter_166_5)

					if var_166_6.name == "split_3" or not string.find(var_166_6.name, "split") then
						var_166_6.gameObject:SetActive(true)
					else
						var_166_6.gameObject:SetActive(false)
					end
				end
			end

			local var_166_7 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 then
				var_166_5.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10064, Vector3.New(-390, -570, 192.5), (arg_163_1.time_ - 0) / var_166_7)
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 then
				var_166_5.localPosition = Vector3.New(-390, -570, 192.5)
			end

			local var_166_8 = arg_163_1.actors_["10064"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_8) and arg_163_1.var_.actorSpriteComps10064 == nil then
				arg_163_1.var_.actorSpriteComps10064 = var_166_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_9 = 0.034

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_9 and not isNil(var_166_8) then
				if arg_163_1.var_.actorSpriteComps10064 then
					for iter_166_6, iter_166_7 in pairs(arg_163_1.var_.actorSpriteComps10064:ToTable()) do
						if iter_166_7 then
							if arg_163_1.isInRecall_ then
								iter_166_7.color = Color.New(Mathf.Lerp(iter_166_7.color.r, arg_163_1.hightColor2.r, (arg_163_1.time_ - 0) / var_166_9), Mathf.Lerp(iter_166_7.color.g, arg_163_1.hightColor2.g, (arg_163_1.time_ - 0) / var_166_9), (Mathf.Lerp(iter_166_7.color.b, arg_163_1.hightColor2.b, (arg_163_1.time_ - 0) / var_166_9)))
							else
								local var_166_10 = Mathf.Lerp(iter_166_7.color.r, 0.5, (arg_163_1.time_ - 0) / var_166_9)

								iter_166_7.color = Color.New(var_166_10, var_166_10, var_166_10)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_9 and arg_163_1.time_ < 0 + var_166_9 + arg_166_0 and not isNil(var_166_8) and arg_163_1.var_.actorSpriteComps10064 then
				for iter_166_8, iter_166_9 in pairs(arg_163_1.var_.actorSpriteComps10064:ToTable()) do
					if iter_166_9 then
						iter_166_9.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_163_1.var_.actorSpriteComps10064 = nil
			end

			local var_166_11 = 0
			local var_166_12 = 0.475

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_11 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_13 = arg_163_1:GetWordFromCfg(410041039)
				local var_166_14 = arg_163_1:FormatText(var_166_13.content)

				arg_163_1.text_.text = var_166_14

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_16 = 19 <= 0 and var_166_12 or var_166_12 * (utf8.len(var_166_14) / 19)

				if (19 <= 0 and var_166_12 or var_166_12 * (utf8.len(var_166_14) / 19)) > 0 and var_166_12 < var_166_16 then
					arg_163_1.talkMaxDuration = var_166_16

					if var_166_16 + var_166_11 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_16 + var_166_11
					end
				end

				arg_163_1.text_.text = var_166_14
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041039", "story_v_out_410041.awb") ~= 0 then
					local var_166_17 = manager.audio:GetVoiceLength("story_v_out_410041", "410041039", "story_v_out_410041.awb") / 1000

					if var_166_17 + var_166_11 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_17 + var_166_11
					end

					if var_166_13.prefab_name ~= "" and arg_163_1.actors_[var_166_13.prefab_name] ~= nil then
						local var_166_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_13.prefab_name].transform, "story_v_out_410041", "410041039", "story_v_out_410041.awb")

						arg_163_1:RecordAudio("410041039", var_166_18)
						arg_163_1:RecordAudio("410041039", var_166_18)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_410041", "410041039", "story_v_out_410041.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_410041", "410041039", "story_v_out_410041.awb")
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
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
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
	Play410041040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 410041040
		arg_167_1.duration_ = 9.4

		local var_167_0 = {
			zh = 6.065999999999,
			ja = 9.399999999999
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
				arg_167_0:Play410041041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if arg_167_1.bgs_.ST61a == nil then
				local var_170_0 = Object.Instantiate(arg_167_1.paintGo_)

				var_170_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST61a")
				var_170_0.name = "ST61a"
				var_170_0.transform.parent = arg_167_1.stage_.transform
				var_170_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_167_1.bgs_.ST61a = var_170_0
			end

			if 2 < arg_167_1.time_ and arg_167_1.time_ <= 2 + arg_170_0 then
				local var_170_1 = arg_167_1.bgs_.ST61a

				arg_167_1.bgs_.ST61a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_170_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_170_2 = var_170_1:GetComponent("SpriteRenderer")

				if var_170_2 and var_170_2.sprite then
					local var_170_3 = 2 * (var_170_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_170_1.transform.localScale = Vector3.New(var_170_3 / var_170_2.sprite.bounds.size.y < var_170_3 * manager.ui.mainCameraCom_.aspect / var_170_2.sprite.bounds.size.x and var_170_3 * manager.ui.mainCameraCom_.aspect / var_170_2.sprite.bounds.size.x or var_170_3 / var_170_2.sprite.bounds.size.y, var_170_3 / var_170_2.sprite.bounds.size.y < var_170_3 * manager.ui.mainCameraCom_.aspect / var_170_2.sprite.bounds.size.x and var_170_3 * manager.ui.mainCameraCom_.aspect / var_170_2.sprite.bounds.size.x or var_170_3 / var_170_2.sprite.bounds.size.y, 0)
				end

				for iter_170_0, iter_170_1 in pairs(arg_167_1.bgs_) do
					if iter_170_0 ~= "ST61a" then
						iter_170_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_170_4 = 0

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.mask_.enabled = true
				arg_167_1.mask_.raycastTarget = true

				arg_167_1:SetGaussion(false)
			end

			local var_170_5 = 2

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_5 then
				local var_170_6 = Color.New(0, 0, 0)

				var_170_6.a = Mathf.Lerp(0, 1, (arg_167_1.time_ - var_170_4) / var_170_5)
				arg_167_1.mask_.color = var_170_6
			end

			if arg_167_1.time_ >= var_170_4 + var_170_5 and arg_167_1.time_ < var_170_4 + var_170_5 + arg_170_0 then
				local var_170_7 = Color.New(0, 0, 0)

				var_170_7.a = 1
				arg_167_1.mask_.color = var_170_7
			end

			local var_170_8 = 2

			if 2 < arg_167_1.time_ and arg_167_1.time_ <= var_170_8 + arg_170_0 then
				arg_167_1.mask_.enabled = true
				arg_167_1.mask_.raycastTarget = true

				arg_167_1:SetGaussion(false)
			end

			local var_170_9 = 2

			if var_170_8 <= arg_167_1.time_ and arg_167_1.time_ < var_170_8 + var_170_9 then
				local var_170_10 = Color.New(0, 0, 0)

				var_170_10.a = Mathf.Lerp(1, 0, (arg_167_1.time_ - var_170_8) / var_170_9)
				arg_167_1.mask_.color = var_170_10
			end

			if arg_167_1.time_ >= var_170_8 + var_170_9 and arg_167_1.time_ < var_170_8 + var_170_9 + arg_170_0 then
				local var_170_11 = Color.New(0, 0, 0)

				arg_167_1.mask_.enabled = false
				var_170_11.a = 0
				arg_167_1.mask_.color = var_170_11
			end

			local var_170_12 = "1060"

			if arg_167_1.actors_["1060"] == nil then
				local var_170_13 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1060")

				if not isNil(var_170_13) then
					local var_170_14 = Object.Instantiate(var_170_13, arg_167_1.canvasGo_.transform)

					var_170_14.transform:SetSiblingIndex(1)

					var_170_14.name = var_170_12
					var_170_14.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_167_1.actors_[var_170_12] = var_170_14

					if arg_167_1.isInRecall_ then
						for iter_170_2, iter_170_3 in ipairs((var_170_14:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_170_3.color = arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_170_15 = arg_167_1.actors_["1060"].transform

			if 4 < arg_167_1.time_ and arg_167_1.time_ <= 4 + arg_170_0 then
				arg_167_1.var_.moveOldPos1060 = var_170_15.localPosition
				var_170_15.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("1060", 2)

				for iter_170_4 = 0, var_170_15.childCount - 1 do
					local var_170_16 = var_170_15:GetChild(iter_170_4)

					if var_170_16.name == "" or not string.find(var_170_16.name, "split") then
						var_170_16.gameObject:SetActive(true)
					else
						var_170_16.gameObject:SetActive(false)
					end
				end
			end

			local var_170_17 = 0.001

			if 4 <= arg_167_1.time_ and arg_167_1.time_ < 4 + var_170_17 then
				var_170_15.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_167_1.time_ - 4) / var_170_17)
			end

			if arg_167_1.time_ >= 4 + var_170_17 and arg_167_1.time_ < 4 + var_170_17 + arg_170_0 then
				var_170_15.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_170_18 = "1056"

			if arg_167_1.actors_["1056"] == nil then
				local var_170_19 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1056")

				if not isNil(var_170_19) then
					local var_170_20 = Object.Instantiate(var_170_19, arg_167_1.canvasGo_.transform)

					var_170_20.transform:SetSiblingIndex(1)

					var_170_20.name = var_170_18
					var_170_20.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_167_1.actors_[var_170_18] = var_170_20

					if arg_167_1.isInRecall_ then
						for iter_170_5, iter_170_6 in ipairs((var_170_20:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_170_6.color = arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_170_21 = arg_167_1.actors_["1056"].transform

			if 4 < arg_167_1.time_ and arg_167_1.time_ <= 4 + arg_170_0 then
				arg_167_1.var_.moveOldPos1056 = var_170_21.localPosition
				var_170_21.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("1056", 4)

				for iter_170_7 = 0, var_170_21.childCount - 1 do
					local var_170_22 = var_170_21:GetChild(iter_170_7)

					if var_170_22.name == "" or not string.find(var_170_22.name, "split") then
						var_170_22.gameObject:SetActive(true)
					else
						var_170_22.gameObject:SetActive(false)
					end
				end
			end

			local var_170_23 = 0.001

			if 4 <= arg_167_1.time_ and arg_167_1.time_ < 4 + var_170_23 then
				var_170_21.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_167_1.time_ - 4) / var_170_23)
			end

			if arg_167_1.time_ >= 4 + var_170_23 and arg_167_1.time_ < 4 + var_170_23 + arg_170_0 then
				var_170_21.localPosition = Vector3.New(390, -350, -180)
			end

			local var_170_24 = arg_167_1.actors_["1012"].transform

			if 1.999999999999 < arg_167_1.time_ and arg_167_1.time_ <= 1.999999999999 + arg_170_0 then
				arg_167_1.var_.moveOldPos1012 = var_170_24.localPosition
				var_170_24.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("1012", 7)

				for iter_170_8 = 0, var_170_24.childCount - 1 do
					local var_170_25 = var_170_24:GetChild(iter_170_8)

					if var_170_25.name == "" or not string.find(var_170_25.name, "split") then
						var_170_25.gameObject:SetActive(true)
					else
						var_170_25.gameObject:SetActive(false)
					end
				end
			end

			local var_170_26 = 0.001

			if 1.999999999999 <= arg_167_1.time_ and arg_167_1.time_ < 1.999999999999 + var_170_26 then
				var_170_24.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1012, Vector3.New(0, -2000, 300), (arg_167_1.time_ - 1.999999999999) / var_170_26)
			end

			if arg_167_1.time_ >= 1.999999999999 + var_170_26 and arg_167_1.time_ < 1.999999999999 + var_170_26 + arg_170_0 then
				var_170_24.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_170_27 = arg_167_1.actors_["1060"]

			if 4 < arg_167_1.time_ and arg_167_1.time_ <= 4 + arg_170_0 and not isNil(var_170_27) and arg_167_1.var_.actorSpriteComps1060 == nil then
				arg_167_1.var_.actorSpriteComps1060 = var_170_27:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_28 = 0.034

			if 4 <= arg_167_1.time_ and arg_167_1.time_ < 4 + var_170_28 and not isNil(var_170_27) then
				if arg_167_1.var_.actorSpriteComps1060 then
					for iter_170_9, iter_170_10 in pairs(arg_167_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_170_10 then
							if arg_167_1.isInRecall_ then
								iter_170_10.color = Color.New(Mathf.Lerp(iter_170_10.color.r, arg_167_1.hightColor1.r, (arg_167_1.time_ - 4) / var_170_28), Mathf.Lerp(iter_170_10.color.g, arg_167_1.hightColor1.g, (arg_167_1.time_ - 4) / var_170_28), (Mathf.Lerp(iter_170_10.color.b, arg_167_1.hightColor1.b, (arg_167_1.time_ - 4) / var_170_28)))
							else
								local var_170_29 = Mathf.Lerp(iter_170_10.color.r, 1, (arg_167_1.time_ - 4) / var_170_28)

								iter_170_10.color = Color.New(var_170_29, var_170_29, var_170_29)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 4 + var_170_28 and arg_167_1.time_ < 4 + var_170_28 + arg_170_0 and not isNil(var_170_27) and arg_167_1.var_.actorSpriteComps1060 then
				for iter_170_11, iter_170_12 in pairs(arg_167_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_170_12 then
						iter_170_12.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_167_1.var_.actorSpriteComps1060 = nil
			end

			local var_170_30 = arg_167_1.actors_["1056"]

			if 4 < arg_167_1.time_ and arg_167_1.time_ <= 4 + arg_170_0 and not isNil(var_170_30) and arg_167_1.var_.actorSpriteComps1056 == nil then
				arg_167_1.var_.actorSpriteComps1056 = var_170_30:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_31 = 0.034

			if 4 <= arg_167_1.time_ and arg_167_1.time_ < 4 + var_170_31 and not isNil(var_170_30) then
				if arg_167_1.var_.actorSpriteComps1056 then
					for iter_170_13, iter_170_14 in pairs(arg_167_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_170_14 then
							if arg_167_1.isInRecall_ then
								iter_170_14.color = Color.New(Mathf.Lerp(iter_170_14.color.r, arg_167_1.hightColor2.r, (arg_167_1.time_ - 4) / var_170_31), Mathf.Lerp(iter_170_14.color.g, arg_167_1.hightColor2.g, (arg_167_1.time_ - 4) / var_170_31), (Mathf.Lerp(iter_170_14.color.b, arg_167_1.hightColor2.b, (arg_167_1.time_ - 4) / var_170_31)))
							else
								local var_170_32 = Mathf.Lerp(iter_170_14.color.r, 0.5, (arg_167_1.time_ - 4) / var_170_31)

								iter_170_14.color = Color.New(var_170_32, var_170_32, var_170_32)
							end
						end
					end
				end
			end

			if arg_167_1.time_ >= 4 + var_170_31 and arg_167_1.time_ < 4 + var_170_31 + arg_170_0 and not isNil(var_170_30) and arg_167_1.var_.actorSpriteComps1056 then
				for iter_170_15, iter_170_16 in pairs(arg_167_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_170_16 then
						iter_170_16.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps1056 = nil
			end

			local var_170_33 = arg_167_1.actors_["1060"].transform

			if 2 < arg_167_1.time_ and arg_167_1.time_ <= 2 + arg_170_0 then
				arg_167_1.var_.moveOldPos1060 = var_170_33.localPosition
				var_170_33.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("1060", 7)

				for iter_170_17 = 0, var_170_33.childCount - 1 do
					local var_170_34 = var_170_33:GetChild(iter_170_17)

					if var_170_34.name == "" or not string.find(var_170_34.name, "split") then
						var_170_34.gameObject:SetActive(true)
					else
						var_170_34.gameObject:SetActive(false)
					end
				end
			end

			local var_170_35 = 0.001

			if 2 <= arg_167_1.time_ and arg_167_1.time_ < 2 + var_170_35 then
				var_170_33.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1060, Vector3.New(0, -2000, -40), (arg_167_1.time_ - 2) / var_170_35)
			end

			if arg_167_1.time_ >= 2 + var_170_35 and arg_167_1.time_ < 2 + var_170_35 + arg_170_0 then
				var_170_33.localPosition = Vector3.New(0, -2000, -40)
			end

			local var_170_36 = 1.999999999999

			arg_167_1.isInRecall_ = false

			if var_170_36 < arg_167_1.time_ and arg_167_1.time_ <= var_170_36 + arg_170_0 then
				arg_167_1.screenFilterGo_:SetActive(false)

				for iter_170_18, iter_170_19 in pairs(arg_167_1.actors_) do
					for iter_170_20, iter_170_21 in ipairs((iter_170_19:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_170_21.color = iter_170_21.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_170_37 = 0.0166666666666667

			if var_170_36 <= arg_167_1.time_ and arg_167_1.time_ < var_170_36 + var_170_37 then
				arg_167_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_167_1.time_ - var_170_36) / var_170_37)
			end

			if arg_167_1.time_ >= var_170_36 + var_170_37 and arg_167_1.time_ < var_170_36 + var_170_37 + arg_170_0 then
				arg_167_1.screenFilterEffect_.weight = 0
			end

			local var_170_38 = arg_167_1.actors_["10064"].transform

			if 2 < arg_167_1.time_ and arg_167_1.time_ <= 2 + arg_170_0 then
				arg_167_1.var_.moveOldPos10064 = var_170_38.localPosition
				var_170_38.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("10064", 7)

				for iter_170_22 = 0, var_170_38.childCount - 1 do
					local var_170_39 = var_170_38:GetChild(iter_170_22)

					if var_170_39.name == "split_3" or not string.find(var_170_39.name, "split") then
						var_170_39.gameObject:SetActive(true)
					else
						var_170_39.gameObject:SetActive(false)
					end
				end
			end

			local var_170_40 = 0.001

			if 2 <= arg_167_1.time_ and arg_167_1.time_ < 2 + var_170_40 then
				var_170_38.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10064, Vector3.New(0, -2000, 192.5), (arg_167_1.time_ - 2) / var_170_40)
			end

			if arg_167_1.time_ >= 2 + var_170_40 and arg_167_1.time_ < 2 + var_170_40 + arg_170_0 then
				var_170_38.localPosition = Vector3.New(0, -2000, 192.5)
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_170_43 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_167_1.bgmTxt_.text ~= var_170_43 and arg_167_1.bgmTxt_.text ~= "" then
						if arg_167_1.bgmTxt2_.text ~= "" then
							arg_167_1.bgmTxt_.text = arg_167_1.bgmTxt2_.text
						end

						arg_167_1.bgmTxt2_.text = var_170_43

						arg_167_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_167_1.bgmTxt_.text = var_170_43
						arg_167_1.bgmTxt2_.text = var_170_43
					end

					if arg_167_1.bgmTimer then
						arg_167_1.bgmTimer:Stop()

						arg_167_1.bgmTimer = nil
					end

					if arg_167_1.settingData.show_music_name == 1 then
						arg_167_1.musicController:SetSelectedState("show")
						arg_167_1.musicAnimator_:Play("open", 0, 0)

						if arg_167_1.settingData.music_time ~= 0 then
							arg_167_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_167_1.settingData.music_time), function()
								if arg_167_1 == nil or isNil(arg_167_1.bgmTxt_) then
									return
								end

								arg_167_1.musicController:SetSelectedState("hide")
								arg_167_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_167_1.time_ and arg_167_1.time_ <= 0.3 + arg_170_0 then
				arg_167_1:AudioAction("play", "music", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism.awb")

				local var_170_46 = manager.audio:GetAudioName("bgm_activity_2_8_story_meruism", "bgm_activity_2_8_story_meruism")

				if "" ~= "" then
					if arg_167_1.bgmTxt_.text ~= var_170_46 and arg_167_1.bgmTxt_.text ~= "" then
						if arg_167_1.bgmTxt2_.text ~= "" then
							arg_167_1.bgmTxt_.text = arg_167_1.bgmTxt2_.text
						end

						arg_167_1.bgmTxt2_.text = var_170_46

						arg_167_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_167_1.bgmTxt_.text = var_170_46
						arg_167_1.bgmTxt2_.text = var_170_46
					end

					if arg_167_1.bgmTimer then
						arg_167_1.bgmTimer:Stop()

						arg_167_1.bgmTimer = nil
					end

					if arg_167_1.settingData.show_music_name == 1 then
						arg_167_1.musicController:SetSelectedState("show")
						arg_167_1.musicAnimator_:Play("open", 0, 0)

						if arg_167_1.settingData.music_time ~= 0 then
							arg_167_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_167_1.settingData.music_time), function()
								if arg_167_1 == nil or isNil(arg_167_1.bgmTxt_) then
									return
								end

								arg_167_1.musicController:SetSelectedState("hide")
								arg_167_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_167_1.frameCnt_ <= 1 then
				arg_167_1.dialog_:SetActive(false)
			end

			local var_170_47 = 3.999999999999
			local var_170_48 = 0.225

			if 3.999999999999 < arg_167_1.time_ and arg_167_1.time_ <= var_170_47 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0

				arg_167_1.dialog_:SetActive(true)

				arg_167_1.dialogCg_.alpha = 0

				local var_170_49 = LeanTween.value(arg_167_1.dialog_, 0, 1, 0.3)

				var_170_49:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_167_1.dialogCg_.alpha = arg_173_0
				end))
				var_170_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_167_1.dialog_)
					var_170_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_167_1.duration_ = arg_167_1.duration_ + 0.3

				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_50 = arg_167_1:GetWordFromCfg(410041040)
				local var_170_51 = arg_167_1:FormatText(var_170_50.content)

				arg_167_1.text_.text = var_170_51

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_53 = 9 <= 0 and var_170_48 or var_170_48 * (utf8.len(var_170_51) / 9)

				if (9 <= 0 and var_170_48 or var_170_48 * (utf8.len(var_170_51) / 9)) > 0 and var_170_48 < var_170_53 then
					arg_167_1.talkMaxDuration = var_170_53
					var_170_47 = var_170_47 + 0.3

					if var_170_53 + var_170_47 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_53 + var_170_47
					end
				end

				arg_167_1.text_.text = var_170_51
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041040", "story_v_out_410041.awb") ~= 0 then
					local var_170_54 = manager.audio:GetVoiceLength("story_v_out_410041", "410041040", "story_v_out_410041.awb") / 1000

					if var_170_54 + var_170_47 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_54 + var_170_47
					end

					if var_170_50.prefab_name ~= "" and arg_167_1.actors_[var_170_50.prefab_name] ~= nil then
						local var_170_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_50.prefab_name].transform, "story_v_out_410041", "410041040", "story_v_out_410041.awb")

						arg_167_1:RecordAudio("410041040", var_170_55)
						arg_167_1:RecordAudio("410041040", var_170_55)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_410041", "410041040", "story_v_out_410041.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_410041", "410041040", "story_v_out_410041.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_56 = var_170_47 + 0.3
			local var_170_57 = math.max(var_170_48, arg_167_1.talkMaxDuration)

			if var_170_47 + 0.3 <= arg_167_1.time_ and arg_167_1.time_ < var_170_56 + var_170_57 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_56) / var_170_57

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_56 + var_170_57 and arg_167_1.time_ < var_170_56 + var_170_57 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10064",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play410041041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 410041041
		arg_175_1.duration_ = 8.97

		local var_175_0 = {
			zh = 7.4,
			ja = 8.966
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
				arg_175_0:Play410041042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1060 = arg_175_1.actors_["1060"].transform.localPosition
				arg_175_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_175_1:CheckSpriteTmpPos("1060", 2)

				for iter_178_0 = 0, arg_175_1.actors_["1060"].transform.childCount - 1 do
					local var_178_0 = arg_175_1.actors_["1060"].transform:GetChild(iter_178_0)

					if var_178_0.name == "" or not string.find(var_178_0.name, "split") then
						var_178_0.gameObject:SetActive(true)
					else
						var_178_0.gameObject:SetActive(false)
					end
				end
			end

			local var_178_1 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_1 then
				arg_175_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_175_1.time_ - 0) / var_178_1)
			end

			if arg_175_1.time_ >= 0 + var_178_1 and arg_175_1.time_ < 0 + var_178_1 + arg_178_0 then
				arg_175_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_178_2 = arg_175_1.actors_["1060"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps1060 == nil then
				arg_175_1.var_.actorSpriteComps1060 = var_178_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_178_3 = 0.034

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_3 and not isNil(var_178_2) then
				if arg_175_1.var_.actorSpriteComps1060 then
					for iter_178_1, iter_178_2 in pairs(arg_175_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_178_2 then
							if arg_175_1.isInRecall_ then
								iter_178_2.color = Color.New(Mathf.Lerp(iter_178_2.color.r, arg_175_1.hightColor1.r, (arg_175_1.time_ - 0) / var_178_3), Mathf.Lerp(iter_178_2.color.g, arg_175_1.hightColor1.g, (arg_175_1.time_ - 0) / var_178_3), (Mathf.Lerp(iter_178_2.color.b, arg_175_1.hightColor1.b, (arg_175_1.time_ - 0) / var_178_3)))
							else
								local var_178_4 = Mathf.Lerp(iter_178_2.color.r, 1, (arg_175_1.time_ - 0) / var_178_3)

								iter_178_2.color = Color.New(var_178_4, var_178_4, var_178_4)
							end
						end
					end
				end
			end

			if arg_175_1.time_ >= 0 + var_178_3 and arg_175_1.time_ < 0 + var_178_3 + arg_178_0 and not isNil(var_178_2) and arg_175_1.var_.actorSpriteComps1060 then
				for iter_178_3, iter_178_4 in pairs(arg_175_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_178_4 then
						iter_178_4.color = arg_175_1.isInRecall_ and (arg_175_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_175_1.var_.actorSpriteComps1060 = nil
			end

			local var_178_5 = 0
			local var_178_6 = 0.75

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_5 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_7 = arg_175_1:GetWordFromCfg(410041041)
				local var_178_8 = arg_175_1:FormatText(var_178_7.content)

				arg_175_1.text_.text = var_178_8

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_10 = 30 <= 0 and var_178_6 or var_178_6 * (utf8.len(var_178_8) / 30)

				if (30 <= 0 and var_178_6 or var_178_6 * (utf8.len(var_178_8) / 30)) > 0 and var_178_6 < var_178_10 then
					arg_175_1.talkMaxDuration = var_178_10

					if var_178_10 + var_178_5 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_5
					end
				end

				arg_175_1.text_.text = var_178_8
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041041", "story_v_out_410041.awb") ~= 0 then
					local var_178_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041041", "story_v_out_410041.awb") / 1000

					if var_178_11 + var_178_5 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_11 + var_178_5
					end

					if var_178_7.prefab_name ~= "" and arg_175_1.actors_[var_178_7.prefab_name] ~= nil then
						local var_178_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_7.prefab_name].transform, "story_v_out_410041", "410041041", "story_v_out_410041.awb")

						arg_175_1:RecordAudio("410041041", var_178_12)
						arg_175_1:RecordAudio("410041041", var_178_12)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_410041", "410041041", "story_v_out_410041.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_410041", "410041041", "story_v_out_410041.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_13 = math.max(var_178_6, arg_175_1.talkMaxDuration)

			if var_178_5 <= arg_175_1.time_ and arg_175_1.time_ < var_178_5 + var_178_13 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_5) / var_178_13

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_5 + var_178_13 and arg_175_1.time_ < var_178_5 + var_178_13 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410041042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 410041042
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play410041043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1060"]) and arg_179_1.var_.actorSpriteComps1060 == nil then
				arg_179_1.var_.actorSpriteComps1060 = arg_179_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_0 = 0.034

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1060"]) then
				if arg_179_1.var_.actorSpriteComps1060 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_182_1 then
							if arg_179_1.isInRecall_ then
								iter_182_1.color = Color.New(Mathf.Lerp(iter_182_1.color.r, arg_179_1.hightColor2.r, (arg_179_1.time_ - 0) / var_182_0), Mathf.Lerp(iter_182_1.color.g, arg_179_1.hightColor2.g, (arg_179_1.time_ - 0) / var_182_0), (Mathf.Lerp(iter_182_1.color.b, arg_179_1.hightColor2.b, (arg_179_1.time_ - 0) / var_182_0)))
							else
								local var_182_1 = Mathf.Lerp(iter_182_1.color.r, 0.5, (arg_179_1.time_ - 0) / var_182_0)

								iter_182_1.color = Color.New(var_182_1, var_182_1, var_182_1)
							end
						end
					end
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1060"]) and arg_179_1.var_.actorSpriteComps1060 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_182_3 then
						iter_182_3.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps1060 = nil
			end

			local var_182_2 = 0
			local var_182_3 = 1

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_4 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(410041042).content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_6 = 40 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_4) / 40)

				if (40 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_4) / 40)) > 0 and var_182_3 < var_182_6 then
					arg_179_1.talkMaxDuration = var_182_6

					if var_182_6 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_6 + var_182_2
					end
				end

				arg_179_1.text_.text = var_182_4
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_3, arg_179_1.talkMaxDuration)

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_2) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_2 + var_182_7 and arg_179_1.time_ < var_182_2 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play410041043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 410041043
		arg_183_1.duration_ = 4.87

		local var_183_0 = {
			zh = 4.866,
			ja = 4.1
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
				arg_183_0:Play410041044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1056 = arg_183_1.actors_["1056"].transform.localPosition
				arg_183_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("1056", 4)

				for iter_186_0 = 0, arg_183_1.actors_["1056"].transform.childCount - 1 do
					local var_186_0 = arg_183_1.actors_["1056"].transform:GetChild(iter_186_0)

					if var_186_0.name == "split_1" or not string.find(var_186_0.name, "split") then
						var_186_0.gameObject:SetActive(true)
					else
						var_186_0.gameObject:SetActive(false)
					end
				end
			end

			local var_186_1 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_1 then
				arg_183_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_183_1.time_ - 0) / var_186_1)
			end

			if arg_183_1.time_ >= 0 + var_186_1 and arg_183_1.time_ < 0 + var_186_1 + arg_186_0 then
				arg_183_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_186_2 = arg_183_1.actors_["1056"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.actorSpriteComps1056 == nil then
				arg_183_1.var_.actorSpriteComps1056 = var_186_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_3 = 0.034

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_3 and not isNil(var_186_2) then
				if arg_183_1.var_.actorSpriteComps1056 then
					for iter_186_1, iter_186_2 in pairs(arg_183_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_186_2 then
							if arg_183_1.isInRecall_ then
								iter_186_2.color = Color.New(Mathf.Lerp(iter_186_2.color.r, arg_183_1.hightColor1.r, (arg_183_1.time_ - 0) / var_186_3), Mathf.Lerp(iter_186_2.color.g, arg_183_1.hightColor1.g, (arg_183_1.time_ - 0) / var_186_3), (Mathf.Lerp(iter_186_2.color.b, arg_183_1.hightColor1.b, (arg_183_1.time_ - 0) / var_186_3)))
							else
								local var_186_4 = Mathf.Lerp(iter_186_2.color.r, 1, (arg_183_1.time_ - 0) / var_186_3)

								iter_186_2.color = Color.New(var_186_4, var_186_4, var_186_4)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_3 and arg_183_1.time_ < 0 + var_186_3 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.actorSpriteComps1056 then
				for iter_186_3, iter_186_4 in pairs(arg_183_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_186_4 then
						iter_186_4.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_183_1.var_.actorSpriteComps1056 = nil
			end

			local var_186_5 = 0
			local var_186_6 = 0.65

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_5 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_7 = arg_183_1:GetWordFromCfg(410041043)
				local var_186_8 = arg_183_1:FormatText(var_186_7.content)

				arg_183_1.text_.text = var_186_8

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_10 = 26 <= 0 and var_186_6 or var_186_6 * (utf8.len(var_186_8) / 26)

				if (26 <= 0 and var_186_6 or var_186_6 * (utf8.len(var_186_8) / 26)) > 0 and var_186_6 < var_186_10 then
					arg_183_1.talkMaxDuration = var_186_10

					if var_186_10 + var_186_5 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_5
					end
				end

				arg_183_1.text_.text = var_186_8
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041043", "story_v_out_410041.awb") ~= 0 then
					local var_186_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041043", "story_v_out_410041.awb") / 1000

					if var_186_11 + var_186_5 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_11 + var_186_5
					end

					if var_186_7.prefab_name ~= "" and arg_183_1.actors_[var_186_7.prefab_name] ~= nil then
						local var_186_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_7.prefab_name].transform, "story_v_out_410041", "410041043", "story_v_out_410041.awb")

						arg_183_1:RecordAudio("410041043", var_186_12)
						arg_183_1:RecordAudio("410041043", var_186_12)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_410041", "410041043", "story_v_out_410041.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_410041", "410041043", "story_v_out_410041.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_13 = math.max(var_186_6, arg_183_1.talkMaxDuration)

			if var_186_5 <= arg_183_1.time_ and arg_183_1.time_ < var_186_5 + var_186_13 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_5) / var_186_13

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_5 + var_186_13 and arg_183_1.time_ < var_186_5 + var_186_13 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410041044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 410041044
		arg_187_1.duration_ = 14

		local var_187_0 = {
			zh = 10.633,
			ja = 14
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
				arg_187_0:Play410041045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos1060 = arg_187_1.actors_["1060"].transform.localPosition
				arg_187_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_187_1:CheckSpriteTmpPos("1060", 2)

				for iter_190_0 = 0, arg_187_1.actors_["1060"].transform.childCount - 1 do
					local var_190_0 = arg_187_1.actors_["1060"].transform:GetChild(iter_190_0)

					if var_190_0.name == "split_2" or not string.find(var_190_0.name, "split") then
						var_190_0.gameObject:SetActive(true)
					else
						var_190_0.gameObject:SetActive(false)
					end
				end
			end

			local var_190_1 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_1 then
				arg_187_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_187_1.time_ - 0) / var_190_1)
			end

			if arg_187_1.time_ >= 0 + var_190_1 and arg_187_1.time_ < 0 + var_190_1 + arg_190_0 then
				arg_187_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_190_2 = arg_187_1.actors_["1060"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.actorSpriteComps1060 == nil then
				arg_187_1.var_.actorSpriteComps1060 = var_190_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_3 = 0.034

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_3 and not isNil(var_190_2) then
				if arg_187_1.var_.actorSpriteComps1060 then
					for iter_190_1, iter_190_2 in pairs(arg_187_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_190_2 then
							if arg_187_1.isInRecall_ then
								iter_190_2.color = Color.New(Mathf.Lerp(iter_190_2.color.r, arg_187_1.hightColor1.r, (arg_187_1.time_ - 0) / var_190_3), Mathf.Lerp(iter_190_2.color.g, arg_187_1.hightColor1.g, (arg_187_1.time_ - 0) / var_190_3), (Mathf.Lerp(iter_190_2.color.b, arg_187_1.hightColor1.b, (arg_187_1.time_ - 0) / var_190_3)))
							else
								local var_190_4 = Mathf.Lerp(iter_190_2.color.r, 1, (arg_187_1.time_ - 0) / var_190_3)

								iter_190_2.color = Color.New(var_190_4, var_190_4, var_190_4)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_3 and arg_187_1.time_ < 0 + var_190_3 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.actorSpriteComps1060 then
				for iter_190_3, iter_190_4 in pairs(arg_187_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_190_4 then
						iter_190_4.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_187_1.var_.actorSpriteComps1060 = nil
			end

			local var_190_5 = arg_187_1.actors_["1056"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_5) and arg_187_1.var_.actorSpriteComps1056 == nil then
				arg_187_1.var_.actorSpriteComps1056 = var_190_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_190_6 = 0.034

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_6 and not isNil(var_190_5) then
				if arg_187_1.var_.actorSpriteComps1056 then
					for iter_190_5, iter_190_6 in pairs(arg_187_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_190_6 then
							if arg_187_1.isInRecall_ then
								iter_190_6.color = Color.New(Mathf.Lerp(iter_190_6.color.r, arg_187_1.hightColor2.r, (arg_187_1.time_ - 0) / var_190_6), Mathf.Lerp(iter_190_6.color.g, arg_187_1.hightColor2.g, (arg_187_1.time_ - 0) / var_190_6), (Mathf.Lerp(iter_190_6.color.b, arg_187_1.hightColor2.b, (arg_187_1.time_ - 0) / var_190_6)))
							else
								local var_190_7 = Mathf.Lerp(iter_190_6.color.r, 0.5, (arg_187_1.time_ - 0) / var_190_6)

								iter_190_6.color = Color.New(var_190_7, var_190_7, var_190_7)
							end
						end
					end
				end
			end

			if arg_187_1.time_ >= 0 + var_190_6 and arg_187_1.time_ < 0 + var_190_6 + arg_190_0 and not isNil(var_190_5) and arg_187_1.var_.actorSpriteComps1056 then
				for iter_190_7, iter_190_8 in pairs(arg_187_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_190_8 then
						iter_190_8.color = arg_187_1.isInRecall_ and (arg_187_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_187_1.var_.actorSpriteComps1056 = nil
			end

			local var_190_8 = 0
			local var_190_9 = 1.45

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_10 = arg_187_1:GetWordFromCfg(410041044)
				local var_190_11 = arg_187_1:FormatText(var_190_10.content)

				arg_187_1.text_.text = var_190_11

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_13 = 57 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 57)

				if (57 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 57)) > 0 and var_190_9 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_8
					end
				end

				arg_187_1.text_.text = var_190_11
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041044", "story_v_out_410041.awb") ~= 0 then
					local var_190_14 = manager.audio:GetVoiceLength("story_v_out_410041", "410041044", "story_v_out_410041.awb") / 1000

					if var_190_14 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_14 + var_190_8
					end

					if var_190_10.prefab_name ~= "" and arg_187_1.actors_[var_190_10.prefab_name] ~= nil then
						local var_190_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_10.prefab_name].transform, "story_v_out_410041", "410041044", "story_v_out_410041.awb")

						arg_187_1:RecordAudio("410041044", var_190_15)
						arg_187_1:RecordAudio("410041044", var_190_15)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_410041", "410041044", "story_v_out_410041.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_410041", "410041044", "story_v_out_410041.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_16 = math.max(var_190_9, arg_187_1.talkMaxDuration)

			if var_190_8 <= arg_187_1.time_ and arg_187_1.time_ < var_190_8 + var_190_16 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_8) / var_190_16

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_8 + var_190_16 and arg_187_1.time_ < var_190_8 + var_190_16 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play410041045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 410041045
		arg_191_1.duration_ = 8.73

		local var_191_0 = {
			zh = 7.966,
			ja = 8.733
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
				arg_191_0:Play410041046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1060 = arg_191_1.actors_["1060"].transform.localPosition
				arg_191_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("1060", 2)

				for iter_194_0 = 0, arg_191_1.actors_["1060"].transform.childCount - 1 do
					local var_194_0 = arg_191_1.actors_["1060"].transform:GetChild(iter_194_0)

					if var_194_0.name == "" or not string.find(var_194_0.name, "split") then
						var_194_0.gameObject:SetActive(true)
					else
						var_194_0.gameObject:SetActive(false)
					end
				end
			end

			local var_194_1 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_1 then
				arg_191_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_191_1.time_ - 0) / var_194_1)
			end

			if arg_191_1.time_ >= 0 + var_194_1 and arg_191_1.time_ < 0 + var_194_1 + arg_194_0 then
				arg_191_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_194_2 = arg_191_1.actors_["1060"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps1060 == nil then
				arg_191_1.var_.actorSpriteComps1060 = var_194_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_3 = 0.034

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_3 and not isNil(var_194_2) then
				if arg_191_1.var_.actorSpriteComps1060 then
					for iter_194_1, iter_194_2 in pairs(arg_191_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_194_2 then
							if arg_191_1.isInRecall_ then
								iter_194_2.color = Color.New(Mathf.Lerp(iter_194_2.color.r, arg_191_1.hightColor1.r, (arg_191_1.time_ - 0) / var_194_3), Mathf.Lerp(iter_194_2.color.g, arg_191_1.hightColor1.g, (arg_191_1.time_ - 0) / var_194_3), (Mathf.Lerp(iter_194_2.color.b, arg_191_1.hightColor1.b, (arg_191_1.time_ - 0) / var_194_3)))
							else
								local var_194_4 = Mathf.Lerp(iter_194_2.color.r, 1, (arg_191_1.time_ - 0) / var_194_3)

								iter_194_2.color = Color.New(var_194_4, var_194_4, var_194_4)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_3 and arg_191_1.time_ < 0 + var_194_3 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps1060 then
				for iter_194_3, iter_194_4 in pairs(arg_191_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_194_4 then
						iter_194_4.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_191_1.var_.actorSpriteComps1060 = nil
			end

			local var_194_5 = 0
			local var_194_6 = 0.95

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_7 = arg_191_1:GetWordFromCfg(410041045)
				local var_194_8 = arg_191_1:FormatText(var_194_7.content)

				arg_191_1.text_.text = var_194_8

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_10 = 38 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_8) / 38)

				if (38 <= 0 and var_194_6 or var_194_6 * (utf8.len(var_194_8) / 38)) > 0 and var_194_6 < var_194_10 then
					arg_191_1.talkMaxDuration = var_194_10

					if var_194_10 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_5
					end
				end

				arg_191_1.text_.text = var_194_8
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041045", "story_v_out_410041.awb") ~= 0 then
					local var_194_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041045", "story_v_out_410041.awb") / 1000

					if var_194_11 + var_194_5 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_11 + var_194_5
					end

					if var_194_7.prefab_name ~= "" and arg_191_1.actors_[var_194_7.prefab_name] ~= nil then
						local var_194_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_7.prefab_name].transform, "story_v_out_410041", "410041045", "story_v_out_410041.awb")

						arg_191_1:RecordAudio("410041045", var_194_12)
						arg_191_1:RecordAudio("410041045", var_194_12)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_410041", "410041045", "story_v_out_410041.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_410041", "410041045", "story_v_out_410041.awb")
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
				actorName = "1060",
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
	Play410041046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 410041046
		arg_195_1.duration_ = 7.5

		local var_195_0 = {
			zh = 4.566,
			ja = 7.5
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
				arg_195_0:Play410041047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1056 = arg_195_1.actors_["1056"].transform.localPosition
				arg_195_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("1056", 4)

				for iter_198_0 = 0, arg_195_1.actors_["1056"].transform.childCount - 1 do
					local var_198_0 = arg_195_1.actors_["1056"].transform:GetChild(iter_198_0)

					if var_198_0.name == "split_4" or not string.find(var_198_0.name, "split") then
						var_198_0.gameObject:SetActive(true)
					else
						var_198_0.gameObject:SetActive(false)
					end
				end
			end

			local var_198_1 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_1 then
				arg_195_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_195_1.time_ - 0) / var_198_1)
			end

			if arg_195_1.time_ >= 0 + var_198_1 and arg_195_1.time_ < 0 + var_198_1 + arg_198_0 then
				arg_195_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_198_2 = arg_195_1.actors_["1056"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps1056 == nil then
				arg_195_1.var_.actorSpriteComps1056 = var_198_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_3 = 0.034

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_3 and not isNil(var_198_2) then
				if arg_195_1.var_.actorSpriteComps1056 then
					for iter_198_1, iter_198_2 in pairs(arg_195_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_198_2 then
							if arg_195_1.isInRecall_ then
								iter_198_2.color = Color.New(Mathf.Lerp(iter_198_2.color.r, arg_195_1.hightColor1.r, (arg_195_1.time_ - 0) / var_198_3), Mathf.Lerp(iter_198_2.color.g, arg_195_1.hightColor1.g, (arg_195_1.time_ - 0) / var_198_3), (Mathf.Lerp(iter_198_2.color.b, arg_195_1.hightColor1.b, (arg_195_1.time_ - 0) / var_198_3)))
							else
								local var_198_4 = Mathf.Lerp(iter_198_2.color.r, 1, (arg_195_1.time_ - 0) / var_198_3)

								iter_198_2.color = Color.New(var_198_4, var_198_4, var_198_4)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_3 and arg_195_1.time_ < 0 + var_198_3 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps1056 then
				for iter_198_3, iter_198_4 in pairs(arg_195_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_198_4 then
						iter_198_4.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_195_1.var_.actorSpriteComps1056 = nil
			end

			local var_198_5 = arg_195_1.actors_["1060"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_5) and arg_195_1.var_.actorSpriteComps1060 == nil then
				arg_195_1.var_.actorSpriteComps1060 = var_198_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_6 = 0.034

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_6 and not isNil(var_198_5) then
				if arg_195_1.var_.actorSpriteComps1060 then
					for iter_198_5, iter_198_6 in pairs(arg_195_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_198_6 then
							if arg_195_1.isInRecall_ then
								iter_198_6.color = Color.New(Mathf.Lerp(iter_198_6.color.r, arg_195_1.hightColor2.r, (arg_195_1.time_ - 0) / var_198_6), Mathf.Lerp(iter_198_6.color.g, arg_195_1.hightColor2.g, (arg_195_1.time_ - 0) / var_198_6), (Mathf.Lerp(iter_198_6.color.b, arg_195_1.hightColor2.b, (arg_195_1.time_ - 0) / var_198_6)))
							else
								local var_198_7 = Mathf.Lerp(iter_198_6.color.r, 0.5, (arg_195_1.time_ - 0) / var_198_6)

								iter_198_6.color = Color.New(var_198_7, var_198_7, var_198_7)
							end
						end
					end
				end
			end

			if arg_195_1.time_ >= 0 + var_198_6 and arg_195_1.time_ < 0 + var_198_6 + arg_198_0 and not isNil(var_198_5) and arg_195_1.var_.actorSpriteComps1060 then
				for iter_198_7, iter_198_8 in pairs(arg_195_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_198_8 then
						iter_198_8.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_195_1.var_.actorSpriteComps1060 = nil
			end

			local var_198_8 = 0
			local var_198_9 = 0.525

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_8 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_10 = arg_195_1:GetWordFromCfg(410041046)
				local var_198_11 = arg_195_1:FormatText(var_198_10.content)

				arg_195_1.text_.text = var_198_11

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_13 = 21 <= 0 and var_198_9 or var_198_9 * (utf8.len(var_198_11) / 21)

				if (21 <= 0 and var_198_9 or var_198_9 * (utf8.len(var_198_11) / 21)) > 0 and var_198_9 < var_198_13 then
					arg_195_1.talkMaxDuration = var_198_13

					if var_198_13 + var_198_8 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_13 + var_198_8
					end
				end

				arg_195_1.text_.text = var_198_11
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041046", "story_v_out_410041.awb") ~= 0 then
					local var_198_14 = manager.audio:GetVoiceLength("story_v_out_410041", "410041046", "story_v_out_410041.awb") / 1000

					if var_198_14 + var_198_8 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_14 + var_198_8
					end

					if var_198_10.prefab_name ~= "" and arg_195_1.actors_[var_198_10.prefab_name] ~= nil then
						local var_198_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_10.prefab_name].transform, "story_v_out_410041", "410041046", "story_v_out_410041.awb")

						arg_195_1:RecordAudio("410041046", var_198_15)
						arg_195_1:RecordAudio("410041046", var_198_15)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_410041", "410041046", "story_v_out_410041.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_410041", "410041046", "story_v_out_410041.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_16 = math.max(var_198_9, arg_195_1.talkMaxDuration)

			if var_198_8 <= arg_195_1.time_ and arg_195_1.time_ < var_198_8 + var_198_16 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_8) / var_198_16

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_8 + var_198_16 and arg_195_1.time_ < var_198_8 + var_198_16 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410041047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 410041047
		arg_199_1.duration_ = 7.5

		local var_199_0 = {
			zh = 3.3,
			ja = 7.5
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
				arg_199_0:Play410041048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1060 = arg_199_1.actors_["1060"].transform.localPosition
				arg_199_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_199_1:CheckSpriteTmpPos("1060", 2)

				for iter_202_0 = 0, arg_199_1.actors_["1060"].transform.childCount - 1 do
					local var_202_0 = arg_199_1.actors_["1060"].transform:GetChild(iter_202_0)

					if var_202_0.name == "" or not string.find(var_202_0.name, "split") then
						var_202_0.gameObject:SetActive(true)
					else
						var_202_0.gameObject:SetActive(false)
					end
				end
			end

			local var_202_1 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_1 then
				arg_199_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_199_1.time_ - 0) / var_202_1)
			end

			if arg_199_1.time_ >= 0 + var_202_1 and arg_199_1.time_ < 0 + var_202_1 + arg_202_0 then
				arg_199_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_202_2 = arg_199_1.actors_["1060"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps1060 == nil then
				arg_199_1.var_.actorSpriteComps1060 = var_202_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_3 = 0.034

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 and not isNil(var_202_2) then
				if arg_199_1.var_.actorSpriteComps1060 then
					for iter_202_1, iter_202_2 in pairs(arg_199_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 and not isNil(var_202_2) and arg_199_1.var_.actorSpriteComps1060 then
				for iter_202_3, iter_202_4 in pairs(arg_199_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_202_4 then
						iter_202_4.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_199_1.var_.actorSpriteComps1060 = nil
			end

			local var_202_5 = arg_199_1.actors_["1056"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_5) and arg_199_1.var_.actorSpriteComps1056 == nil then
				arg_199_1.var_.actorSpriteComps1056 = var_202_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_6 = 0.034

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_6 and not isNil(var_202_5) then
				if arg_199_1.var_.actorSpriteComps1056 then
					for iter_202_5, iter_202_6 in pairs(arg_199_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_202_6 then
							if arg_199_1.isInRecall_ then
								iter_202_6.color = Color.New(Mathf.Lerp(iter_202_6.color.r, arg_199_1.hightColor2.r, (arg_199_1.time_ - 0) / var_202_6), Mathf.Lerp(iter_202_6.color.g, arg_199_1.hightColor2.g, (arg_199_1.time_ - 0) / var_202_6), (Mathf.Lerp(iter_202_6.color.b, arg_199_1.hightColor2.b, (arg_199_1.time_ - 0) / var_202_6)))
							else
								local var_202_7 = Mathf.Lerp(iter_202_6.color.r, 0.5, (arg_199_1.time_ - 0) / var_202_6)

								iter_202_6.color = Color.New(var_202_7, var_202_7, var_202_7)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_6 and arg_199_1.time_ < 0 + var_202_6 + arg_202_0 and not isNil(var_202_5) and arg_199_1.var_.actorSpriteComps1056 then
				for iter_202_7, iter_202_8 in pairs(arg_199_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_202_8 then
						iter_202_8.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_199_1.var_.actorSpriteComps1056 = nil
			end

			local var_202_8 = 0
			local var_202_9 = 0.375

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_10 = arg_199_1:GetWordFromCfg(410041047)
				local var_202_11 = arg_199_1:FormatText(var_202_10.content)

				arg_199_1.text_.text = var_202_11

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_13 = 15 <= 0 and var_202_9 or var_202_9 * (utf8.len(var_202_11) / 15)

				if (15 <= 0 and var_202_9 or var_202_9 * (utf8.len(var_202_11) / 15)) > 0 and var_202_9 < var_202_13 then
					arg_199_1.talkMaxDuration = var_202_13

					if var_202_13 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_13 + var_202_8
					end
				end

				arg_199_1.text_.text = var_202_11
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041047", "story_v_out_410041.awb") ~= 0 then
					local var_202_14 = manager.audio:GetVoiceLength("story_v_out_410041", "410041047", "story_v_out_410041.awb") / 1000

					if var_202_14 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_14 + var_202_8
					end

					if var_202_10.prefab_name ~= "" and arg_199_1.actors_[var_202_10.prefab_name] ~= nil then
						local var_202_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_10.prefab_name].transform, "story_v_out_410041", "410041047", "story_v_out_410041.awb")

						arg_199_1:RecordAudio("410041047", var_202_15)
						arg_199_1:RecordAudio("410041047", var_202_15)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_410041", "410041047", "story_v_out_410041.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_410041", "410041047", "story_v_out_410041.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_16 = math.max(var_202_9, arg_199_1.talkMaxDuration)

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_16 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_8) / var_202_16

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_8 + var_202_16 and arg_199_1.time_ < var_202_8 + var_202_16 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410041048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 410041048
		arg_203_1.duration_ = 10.63

		local var_203_0 = {
			zh = 8.1,
			ja = 10.633
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
				arg_203_0:Play410041049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos1060 = arg_203_1.actors_["1060"].transform.localPosition
				arg_203_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("1060", 2)

				for iter_206_0 = 0, arg_203_1.actors_["1060"].transform.childCount - 1 do
					local var_206_0 = arg_203_1.actors_["1060"].transform:GetChild(iter_206_0)

					if var_206_0.name == "" or not string.find(var_206_0.name, "split") then
						var_206_0.gameObject:SetActive(true)
					else
						var_206_0.gameObject:SetActive(false)
					end
				end
			end

			local var_206_1 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_1 then
				arg_203_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_203_1.time_ - 0) / var_206_1)
			end

			if arg_203_1.time_ >= 0 + var_206_1 and arg_203_1.time_ < 0 + var_206_1 + arg_206_0 then
				arg_203_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_206_2 = arg_203_1.actors_["1060"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.actorSpriteComps1060 == nil then
				arg_203_1.var_.actorSpriteComps1060 = var_206_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_206_3 = 0.034

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_3 and not isNil(var_206_2) then
				if arg_203_1.var_.actorSpriteComps1060 then
					for iter_206_1, iter_206_2 in pairs(arg_203_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_206_2 then
							if arg_203_1.isInRecall_ then
								iter_206_2.color = Color.New(Mathf.Lerp(iter_206_2.color.r, arg_203_1.hightColor1.r, (arg_203_1.time_ - 0) / var_206_3), Mathf.Lerp(iter_206_2.color.g, arg_203_1.hightColor1.g, (arg_203_1.time_ - 0) / var_206_3), (Mathf.Lerp(iter_206_2.color.b, arg_203_1.hightColor1.b, (arg_203_1.time_ - 0) / var_206_3)))
							else
								local var_206_4 = Mathf.Lerp(iter_206_2.color.r, 1, (arg_203_1.time_ - 0) / var_206_3)

								iter_206_2.color = Color.New(var_206_4, var_206_4, var_206_4)
							end
						end
					end
				end
			end

			if arg_203_1.time_ >= 0 + var_206_3 and arg_203_1.time_ < 0 + var_206_3 + arg_206_0 and not isNil(var_206_2) and arg_203_1.var_.actorSpriteComps1060 then
				for iter_206_3, iter_206_4 in pairs(arg_203_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_206_4 then
						iter_206_4.color = arg_203_1.isInRecall_ and (arg_203_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_203_1.var_.actorSpriteComps1060 = nil
			end

			local var_206_5 = 0
			local var_206_6 = 1.075

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_7 = arg_203_1:GetWordFromCfg(410041048)
				local var_206_8 = arg_203_1:FormatText(var_206_7.content)

				arg_203_1.text_.text = var_206_8

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_10 = 43 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_8) / 43)

				if (43 <= 0 and var_206_6 or var_206_6 * (utf8.len(var_206_8) / 43)) > 0 and var_206_6 < var_206_10 then
					arg_203_1.talkMaxDuration = var_206_10

					if var_206_10 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_5
					end
				end

				arg_203_1.text_.text = var_206_8
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041048", "story_v_out_410041.awb") ~= 0 then
					local var_206_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041048", "story_v_out_410041.awb") / 1000

					if var_206_11 + var_206_5 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_5
					end

					if var_206_7.prefab_name ~= "" and arg_203_1.actors_[var_206_7.prefab_name] ~= nil then
						local var_206_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_7.prefab_name].transform, "story_v_out_410041", "410041048", "story_v_out_410041.awb")

						arg_203_1:RecordAudio("410041048", var_206_12)
						arg_203_1:RecordAudio("410041048", var_206_12)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_410041", "410041048", "story_v_out_410041.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_410041", "410041048", "story_v_out_410041.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_13 = math.max(var_206_6, arg_203_1.talkMaxDuration)

			if var_206_5 <= arg_203_1.time_ and arg_203_1.time_ < var_206_5 + var_206_13 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_5) / var_206_13

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_5 + var_206_13 and arg_203_1.time_ < var_206_5 + var_206_13 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410041049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 410041049
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play410041050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1060"]) and arg_207_1.var_.actorSpriteComps1060 == nil then
				arg_207_1.var_.actorSpriteComps1060 = arg_207_1.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_210_0 = 0.034

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1060"]) then
				if arg_207_1.var_.actorSpriteComps1060 then
					for iter_210_0, iter_210_1 in pairs(arg_207_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1060"]) and arg_207_1.var_.actorSpriteComps1060 then
				for iter_210_2, iter_210_3 in pairs(arg_207_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_210_3 then
						iter_210_3.color = arg_207_1.isInRecall_ and (arg_207_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_207_1.var_.actorSpriteComps1060 = nil
			end

			local var_210_2 = 0
			local var_210_3 = 1.1

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_2 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_4 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(410041049).content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_6 = 44 <= 0 and var_210_3 or var_210_3 * (utf8.len(var_210_4) / 44)

				if (44 <= 0 and var_210_3 or var_210_3 * (utf8.len(var_210_4) / 44)) > 0 and var_210_3 < var_210_6 then
					arg_207_1.talkMaxDuration = var_210_6

					if var_210_6 + var_210_2 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_2
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_3, arg_207_1.talkMaxDuration)

			if var_210_2 <= arg_207_1.time_ and arg_207_1.time_ < var_210_2 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_2) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_2 + var_210_7 and arg_207_1.time_ < var_210_2 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play410041050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 410041050
		arg_211_1.duration_ = 11.4

		local var_211_0 = {
			zh = 10.266,
			ja = 11.4
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
				arg_211_0:Play410041051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1056 = arg_211_1.actors_["1056"].transform.localPosition
				arg_211_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("1056", 4)

				for iter_214_0 = 0, arg_211_1.actors_["1056"].transform.childCount - 1 do
					local var_214_0 = arg_211_1.actors_["1056"].transform:GetChild(iter_214_0)

					if var_214_0.name == "split_4" or not string.find(var_214_0.name, "split") then
						var_214_0.gameObject:SetActive(true)
					else
						var_214_0.gameObject:SetActive(false)
					end
				end
			end

			local var_214_1 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_1 then
				arg_211_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_211_1.time_ - 0) / var_214_1)
			end

			if arg_211_1.time_ >= 0 + var_214_1 and arg_211_1.time_ < 0 + var_214_1 + arg_214_0 then
				arg_211_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_214_2 = arg_211_1.actors_["1056"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.actorSpriteComps1056 == nil then
				arg_211_1.var_.actorSpriteComps1056 = var_214_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_3 = 0.034

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_3 and not isNil(var_214_2) then
				if arg_211_1.var_.actorSpriteComps1056 then
					for iter_214_1, iter_214_2 in pairs(arg_211_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_214_2 then
							if arg_211_1.isInRecall_ then
								iter_214_2.color = Color.New(Mathf.Lerp(iter_214_2.color.r, arg_211_1.hightColor1.r, (arg_211_1.time_ - 0) / var_214_3), Mathf.Lerp(iter_214_2.color.g, arg_211_1.hightColor1.g, (arg_211_1.time_ - 0) / var_214_3), (Mathf.Lerp(iter_214_2.color.b, arg_211_1.hightColor1.b, (arg_211_1.time_ - 0) / var_214_3)))
							else
								local var_214_4 = Mathf.Lerp(iter_214_2.color.r, 1, (arg_211_1.time_ - 0) / var_214_3)

								iter_214_2.color = Color.New(var_214_4, var_214_4, var_214_4)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_3 and arg_211_1.time_ < 0 + var_214_3 + arg_214_0 and not isNil(var_214_2) and arg_211_1.var_.actorSpriteComps1056 then
				for iter_214_3, iter_214_4 in pairs(arg_211_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_214_4 then
						iter_214_4.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_211_1.var_.actorSpriteComps1056 = nil
			end

			local var_214_5 = 0
			local var_214_6 = 1.225

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_7 = arg_211_1:GetWordFromCfg(410041050)
				local var_214_8 = arg_211_1:FormatText(var_214_7.content)

				arg_211_1.text_.text = var_214_8

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_10 = 49 <= 0 and var_214_6 or var_214_6 * (utf8.len(var_214_8) / 49)

				if (49 <= 0 and var_214_6 or var_214_6 * (utf8.len(var_214_8) / 49)) > 0 and var_214_6 < var_214_10 then
					arg_211_1.talkMaxDuration = var_214_10

					if var_214_10 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_10 + var_214_5
					end
				end

				arg_211_1.text_.text = var_214_8
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041050", "story_v_out_410041.awb") ~= 0 then
					local var_214_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041050", "story_v_out_410041.awb") / 1000

					if var_214_11 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_11 + var_214_5
					end

					if var_214_7.prefab_name ~= "" and arg_211_1.actors_[var_214_7.prefab_name] ~= nil then
						local var_214_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_7.prefab_name].transform, "story_v_out_410041", "410041050", "story_v_out_410041.awb")

						arg_211_1:RecordAudio("410041050", var_214_12)
						arg_211_1:RecordAudio("410041050", var_214_12)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_410041", "410041050", "story_v_out_410041.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_410041", "410041050", "story_v_out_410041.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_13 = math.max(var_214_6, arg_211_1.talkMaxDuration)

			if var_214_5 <= arg_211_1.time_ and arg_211_1.time_ < var_214_5 + var_214_13 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_5) / var_214_13

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_5 + var_214_13 and arg_211_1.time_ < var_214_5 + var_214_13 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410041051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 410041051
		arg_215_1.duration_ = 1.9

		local var_215_0 = {
			zh = 1.433,
			ja = 1.9
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
				arg_215_0:Play410041052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos1060 = arg_215_1.actors_["1060"].transform.localPosition
				arg_215_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("1060", 2)

				for iter_218_0 = 0, arg_215_1.actors_["1060"].transform.childCount - 1 do
					local var_218_0 = arg_215_1.actors_["1060"].transform:GetChild(iter_218_0)

					if var_218_0.name == "split_4" or not string.find(var_218_0.name, "split") then
						var_218_0.gameObject:SetActive(true)
					else
						var_218_0.gameObject:SetActive(false)
					end
				end
			end

			local var_218_1 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_1 then
				arg_215_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_215_1.time_ - 0) / var_218_1)
			end

			if arg_215_1.time_ >= 0 + var_218_1 and arg_215_1.time_ < 0 + var_218_1 + arg_218_0 then
				arg_215_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_218_2 = arg_215_1.actors_["1060"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.actorSpriteComps1060 == nil then
				arg_215_1.var_.actorSpriteComps1060 = var_218_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_3 = 0.034

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_3 and not isNil(var_218_2) then
				if arg_215_1.var_.actorSpriteComps1060 then
					for iter_218_1, iter_218_2 in pairs(arg_215_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_218_2 then
							if arg_215_1.isInRecall_ then
								iter_218_2.color = Color.New(Mathf.Lerp(iter_218_2.color.r, arg_215_1.hightColor1.r, (arg_215_1.time_ - 0) / var_218_3), Mathf.Lerp(iter_218_2.color.g, arg_215_1.hightColor1.g, (arg_215_1.time_ - 0) / var_218_3), (Mathf.Lerp(iter_218_2.color.b, arg_215_1.hightColor1.b, (arg_215_1.time_ - 0) / var_218_3)))
							else
								local var_218_4 = Mathf.Lerp(iter_218_2.color.r, 1, (arg_215_1.time_ - 0) / var_218_3)

								iter_218_2.color = Color.New(var_218_4, var_218_4, var_218_4)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= 0 + var_218_3 and arg_215_1.time_ < 0 + var_218_3 + arg_218_0 and not isNil(var_218_2) and arg_215_1.var_.actorSpriteComps1060 then
				for iter_218_3, iter_218_4 in pairs(arg_215_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_218_4 then
						iter_218_4.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_215_1.var_.actorSpriteComps1060 = nil
			end

			local var_218_5 = arg_215_1.actors_["1056"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_5) and arg_215_1.var_.actorSpriteComps1056 == nil then
				arg_215_1.var_.actorSpriteComps1056 = var_218_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_6 = 0.034

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_6 and not isNil(var_218_5) then
				if arg_215_1.var_.actorSpriteComps1056 then
					for iter_218_5, iter_218_6 in pairs(arg_215_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_218_6 then
							if arg_215_1.isInRecall_ then
								iter_218_6.color = Color.New(Mathf.Lerp(iter_218_6.color.r, arg_215_1.hightColor2.r, (arg_215_1.time_ - 0) / var_218_6), Mathf.Lerp(iter_218_6.color.g, arg_215_1.hightColor2.g, (arg_215_1.time_ - 0) / var_218_6), (Mathf.Lerp(iter_218_6.color.b, arg_215_1.hightColor2.b, (arg_215_1.time_ - 0) / var_218_6)))
							else
								local var_218_7 = Mathf.Lerp(iter_218_6.color.r, 0.5, (arg_215_1.time_ - 0) / var_218_6)

								iter_218_6.color = Color.New(var_218_7, var_218_7, var_218_7)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= 0 + var_218_6 and arg_215_1.time_ < 0 + var_218_6 + arg_218_0 and not isNil(var_218_5) and arg_215_1.var_.actorSpriteComps1056 then
				for iter_218_7, iter_218_8 in pairs(arg_215_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_218_8 then
						iter_218_8.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_215_1.var_.actorSpriteComps1056 = nil
			end

			local var_218_8 = 0
			local var_218_9 = 0.125

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_8 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_10 = arg_215_1:GetWordFromCfg(410041051)
				local var_218_11 = arg_215_1:FormatText(var_218_10.content)

				arg_215_1.text_.text = var_218_11

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_13 = 5 <= 0 and var_218_9 or var_218_9 * (utf8.len(var_218_11) / 5)

				if (5 <= 0 and var_218_9 or var_218_9 * (utf8.len(var_218_11) / 5)) > 0 and var_218_9 < var_218_13 then
					arg_215_1.talkMaxDuration = var_218_13

					if var_218_13 + var_218_8 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_13 + var_218_8
					end
				end

				arg_215_1.text_.text = var_218_11
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041051", "story_v_out_410041.awb") ~= 0 then
					local var_218_14 = manager.audio:GetVoiceLength("story_v_out_410041", "410041051", "story_v_out_410041.awb") / 1000

					if var_218_14 + var_218_8 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_14 + var_218_8
					end

					if var_218_10.prefab_name ~= "" and arg_215_1.actors_[var_218_10.prefab_name] ~= nil then
						local var_218_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_10.prefab_name].transform, "story_v_out_410041", "410041051", "story_v_out_410041.awb")

						arg_215_1:RecordAudio("410041051", var_218_15)
						arg_215_1:RecordAudio("410041051", var_218_15)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_410041", "410041051", "story_v_out_410041.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_410041", "410041051", "story_v_out_410041.awb")
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
				actorName = "1060",
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
	Play410041052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 410041052
		arg_219_1.duration_ = 6.2

		local var_219_0 = {
			zh = 6.2,
			ja = 5.966
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
				arg_219_0:Play410041053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos1056 = arg_219_1.actors_["1056"].transform.localPosition
				arg_219_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_219_1:CheckSpriteTmpPos("1056", 4)

				for iter_222_0 = 0, arg_219_1.actors_["1056"].transform.childCount - 1 do
					local var_222_0 = arg_219_1.actors_["1056"].transform:GetChild(iter_222_0)

					if var_222_0.name == "split_1" or not string.find(var_222_0.name, "split") then
						var_222_0.gameObject:SetActive(true)
					else
						var_222_0.gameObject:SetActive(false)
					end
				end
			end

			local var_222_1 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_1 then
				arg_219_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_219_1.time_ - 0) / var_222_1)
			end

			if arg_219_1.time_ >= 0 + var_222_1 and arg_219_1.time_ < 0 + var_222_1 + arg_222_0 then
				arg_219_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_222_2 = arg_219_1.actors_["1056"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_2) and arg_219_1.var_.actorSpriteComps1056 == nil then
				arg_219_1.var_.actorSpriteComps1056 = var_222_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_3 = 0.034

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_3 and not isNil(var_222_2) then
				if arg_219_1.var_.actorSpriteComps1056 then
					for iter_222_1, iter_222_2 in pairs(arg_219_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_222_2 then
							if arg_219_1.isInRecall_ then
								iter_222_2.color = Color.New(Mathf.Lerp(iter_222_2.color.r, arg_219_1.hightColor1.r, (arg_219_1.time_ - 0) / var_222_3), Mathf.Lerp(iter_222_2.color.g, arg_219_1.hightColor1.g, (arg_219_1.time_ - 0) / var_222_3), (Mathf.Lerp(iter_222_2.color.b, arg_219_1.hightColor1.b, (arg_219_1.time_ - 0) / var_222_3)))
							else
								local var_222_4 = Mathf.Lerp(iter_222_2.color.r, 1, (arg_219_1.time_ - 0) / var_222_3)

								iter_222_2.color = Color.New(var_222_4, var_222_4, var_222_4)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= 0 + var_222_3 and arg_219_1.time_ < 0 + var_222_3 + arg_222_0 and not isNil(var_222_2) and arg_219_1.var_.actorSpriteComps1056 then
				for iter_222_3, iter_222_4 in pairs(arg_219_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_222_4 then
						iter_222_4.color = arg_219_1.isInRecall_ and (arg_219_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_219_1.var_.actorSpriteComps1056 = nil
			end

			local var_222_5 = arg_219_1.actors_["1060"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_5) and arg_219_1.var_.actorSpriteComps1060 == nil then
				arg_219_1.var_.actorSpriteComps1060 = var_222_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_222_6 = 0.034

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_6 and not isNil(var_222_5) then
				if arg_219_1.var_.actorSpriteComps1060 then
					for iter_222_5, iter_222_6 in pairs(arg_219_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_222_6 then
							if arg_219_1.isInRecall_ then
								iter_222_6.color = Color.New(Mathf.Lerp(iter_222_6.color.r, arg_219_1.hightColor2.r, (arg_219_1.time_ - 0) / var_222_6), Mathf.Lerp(iter_222_6.color.g, arg_219_1.hightColor2.g, (arg_219_1.time_ - 0) / var_222_6), (Mathf.Lerp(iter_222_6.color.b, arg_219_1.hightColor2.b, (arg_219_1.time_ - 0) / var_222_6)))
							else
								local var_222_7 = Mathf.Lerp(iter_222_6.color.r, 0.5, (arg_219_1.time_ - 0) / var_222_6)

								iter_222_6.color = Color.New(var_222_7, var_222_7, var_222_7)
							end
						end
					end
				end
			end

			if arg_219_1.time_ >= 0 + var_222_6 and arg_219_1.time_ < 0 + var_222_6 + arg_222_0 and not isNil(var_222_5) and arg_219_1.var_.actorSpriteComps1060 then
				for iter_222_7, iter_222_8 in pairs(arg_219_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_222_8 then
						iter_222_8.color = arg_219_1.isInRecall_ and (arg_219_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_219_1.var_.actorSpriteComps1060 = nil
			end

			local var_222_8 = 0
			local var_222_9 = 0.7

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_8 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_10 = arg_219_1:GetWordFromCfg(410041052)
				local var_222_11 = arg_219_1:FormatText(var_222_10.content)

				arg_219_1.text_.text = var_222_11

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_13 = 28 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_11) / 28)

				if (28 <= 0 and var_222_9 or var_222_9 * (utf8.len(var_222_11) / 28)) > 0 and var_222_9 < var_222_13 then
					arg_219_1.talkMaxDuration = var_222_13

					if var_222_13 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_8
					end
				end

				arg_219_1.text_.text = var_222_11
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041052", "story_v_out_410041.awb") ~= 0 then
					local var_222_14 = manager.audio:GetVoiceLength("story_v_out_410041", "410041052", "story_v_out_410041.awb") / 1000

					if var_222_14 + var_222_8 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_14 + var_222_8
					end

					if var_222_10.prefab_name ~= "" and arg_219_1.actors_[var_222_10.prefab_name] ~= nil then
						local var_222_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_10.prefab_name].transform, "story_v_out_410041", "410041052", "story_v_out_410041.awb")

						arg_219_1:RecordAudio("410041052", var_222_15)
						arg_219_1:RecordAudio("410041052", var_222_15)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_410041", "410041052", "story_v_out_410041.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_410041", "410041052", "story_v_out_410041.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_16 = math.max(var_222_9, arg_219_1.talkMaxDuration)

			if var_222_8 <= arg_219_1.time_ and arg_219_1.time_ < var_222_8 + var_222_16 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_8) / var_222_16

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_8 + var_222_16 and arg_219_1.time_ < var_222_8 + var_222_16 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410041053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 410041053
		arg_223_1.duration_ = 9.6

		local var_223_0 = {
			zh = 8.9,
			ja = 9.6
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
				arg_223_0:Play410041054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos1056 = arg_223_1.actors_["1056"].transform.localPosition
				arg_223_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("1056", 4)

				for iter_226_0 = 0, arg_223_1.actors_["1056"].transform.childCount - 1 do
					local var_226_0 = arg_223_1.actors_["1056"].transform:GetChild(iter_226_0)

					if var_226_0.name == "split_2" or not string.find(var_226_0.name, "split") then
						var_226_0.gameObject:SetActive(true)
					else
						var_226_0.gameObject:SetActive(false)
					end
				end
			end

			local var_226_1 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_1 then
				arg_223_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_223_1.time_ - 0) / var_226_1)
			end

			if arg_223_1.time_ >= 0 + var_226_1 and arg_223_1.time_ < 0 + var_226_1 + arg_226_0 then
				arg_223_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_226_2 = arg_223_1.actors_["1056"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.actorSpriteComps1056 == nil then
				arg_223_1.var_.actorSpriteComps1056 = var_226_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_3 = 0.034

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_3 and not isNil(var_226_2) then
				if arg_223_1.var_.actorSpriteComps1056 then
					for iter_226_1, iter_226_2 in pairs(arg_223_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_226_2 then
							if arg_223_1.isInRecall_ then
								iter_226_2.color = Color.New(Mathf.Lerp(iter_226_2.color.r, arg_223_1.hightColor1.r, (arg_223_1.time_ - 0) / var_226_3), Mathf.Lerp(iter_226_2.color.g, arg_223_1.hightColor1.g, (arg_223_1.time_ - 0) / var_226_3), (Mathf.Lerp(iter_226_2.color.b, arg_223_1.hightColor1.b, (arg_223_1.time_ - 0) / var_226_3)))
							else
								local var_226_4 = Mathf.Lerp(iter_226_2.color.r, 1, (arg_223_1.time_ - 0) / var_226_3)

								iter_226_2.color = Color.New(var_226_4, var_226_4, var_226_4)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_3 and arg_223_1.time_ < 0 + var_226_3 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.actorSpriteComps1056 then
				for iter_226_3, iter_226_4 in pairs(arg_223_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_226_4 then
						iter_226_4.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_223_1.var_.actorSpriteComps1056 = nil
			end

			local var_226_5 = 0
			local var_226_6 = 1.15

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_7 = arg_223_1:GetWordFromCfg(410041053)
				local var_226_8 = arg_223_1:FormatText(var_226_7.content)

				arg_223_1.text_.text = var_226_8

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_10 = 46 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 46)

				if (46 <= 0 and var_226_6 or var_226_6 * (utf8.len(var_226_8) / 46)) > 0 and var_226_6 < var_226_10 then
					arg_223_1.talkMaxDuration = var_226_10

					if var_226_10 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_10 + var_226_5
					end
				end

				arg_223_1.text_.text = var_226_8
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041053", "story_v_out_410041.awb") ~= 0 then
					local var_226_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041053", "story_v_out_410041.awb") / 1000

					if var_226_11 + var_226_5 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_11 + var_226_5
					end

					if var_226_7.prefab_name ~= "" and arg_223_1.actors_[var_226_7.prefab_name] ~= nil then
						local var_226_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_7.prefab_name].transform, "story_v_out_410041", "410041053", "story_v_out_410041.awb")

						arg_223_1:RecordAudio("410041053", var_226_12)
						arg_223_1:RecordAudio("410041053", var_226_12)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_410041", "410041053", "story_v_out_410041.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_410041", "410041053", "story_v_out_410041.awb")
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

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play410041054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 410041054
		arg_227_1.duration_ = 13.2

		local var_227_0 = {
			zh = 8.6,
			ja = 13.2
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
				arg_227_0:Play410041055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1056 = arg_227_1.actors_["1056"].transform.localPosition
				arg_227_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("1056", 4)

				for iter_230_0 = 0, arg_227_1.actors_["1056"].transform.childCount - 1 do
					local var_230_0 = arg_227_1.actors_["1056"].transform:GetChild(iter_230_0)

					if var_230_0.name == "" or not string.find(var_230_0.name, "split") then
						var_230_0.gameObject:SetActive(true)
					else
						var_230_0.gameObject:SetActive(false)
					end
				end
			end

			local var_230_1 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_1 then
				arg_227_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_227_1.time_ - 0) / var_230_1)
			end

			if arg_227_1.time_ >= 0 + var_230_1 and arg_227_1.time_ < 0 + var_230_1 + arg_230_0 then
				arg_227_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_230_2 = arg_227_1.actors_["1056"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_2) and arg_227_1.var_.actorSpriteComps1056 == nil then
				arg_227_1.var_.actorSpriteComps1056 = var_230_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_3 = 0.034

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_3 and not isNil(var_230_2) then
				if arg_227_1.var_.actorSpriteComps1056 then
					for iter_230_1, iter_230_2 in pairs(arg_227_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_230_2 then
							if arg_227_1.isInRecall_ then
								iter_230_2.color = Color.New(Mathf.Lerp(iter_230_2.color.r, arg_227_1.hightColor1.r, (arg_227_1.time_ - 0) / var_230_3), Mathf.Lerp(iter_230_2.color.g, arg_227_1.hightColor1.g, (arg_227_1.time_ - 0) / var_230_3), (Mathf.Lerp(iter_230_2.color.b, arg_227_1.hightColor1.b, (arg_227_1.time_ - 0) / var_230_3)))
							else
								local var_230_4 = Mathf.Lerp(iter_230_2.color.r, 1, (arg_227_1.time_ - 0) / var_230_3)

								iter_230_2.color = Color.New(var_230_4, var_230_4, var_230_4)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 0 + var_230_3 and arg_227_1.time_ < 0 + var_230_3 + arg_230_0 and not isNil(var_230_2) and arg_227_1.var_.actorSpriteComps1056 then
				for iter_230_3, iter_230_4 in pairs(arg_227_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_230_4 then
						iter_230_4.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_227_1.var_.actorSpriteComps1056 = nil
			end

			local var_230_5 = 0
			local var_230_6 = 1.175

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_5 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_7 = arg_227_1:GetWordFromCfg(410041054)
				local var_230_8 = arg_227_1:FormatText(var_230_7.content)

				arg_227_1.text_.text = var_230_8

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_10 = 47 <= 0 and var_230_6 or var_230_6 * (utf8.len(var_230_8) / 47)

				if (47 <= 0 and var_230_6 or var_230_6 * (utf8.len(var_230_8) / 47)) > 0 and var_230_6 < var_230_10 then
					arg_227_1.talkMaxDuration = var_230_10

					if var_230_10 + var_230_5 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_10 + var_230_5
					end
				end

				arg_227_1.text_.text = var_230_8
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041054", "story_v_out_410041.awb") ~= 0 then
					local var_230_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041054", "story_v_out_410041.awb") / 1000

					if var_230_11 + var_230_5 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_11 + var_230_5
					end

					if var_230_7.prefab_name ~= "" and arg_227_1.actors_[var_230_7.prefab_name] ~= nil then
						local var_230_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_7.prefab_name].transform, "story_v_out_410041", "410041054", "story_v_out_410041.awb")

						arg_227_1:RecordAudio("410041054", var_230_12)
						arg_227_1:RecordAudio("410041054", var_230_12)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_410041", "410041054", "story_v_out_410041.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_410041", "410041054", "story_v_out_410041.awb")
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

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play410041055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 410041055
		arg_231_1.duration_ = 13.33

		local var_231_0 = {
			zh = 8.3,
			ja = 13.333
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
				arg_231_0:Play410041056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos1056 = arg_231_1.actors_["1056"].transform.localPosition
				arg_231_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("1056", 4)

				for iter_234_0 = 0, arg_231_1.actors_["1056"].transform.childCount - 1 do
					local var_234_0 = arg_231_1.actors_["1056"].transform:GetChild(iter_234_0)

					if var_234_0.name == "split_1" or not string.find(var_234_0.name, "split") then
						var_234_0.gameObject:SetActive(true)
					else
						var_234_0.gameObject:SetActive(false)
					end
				end
			end

			local var_234_1 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_1 then
				arg_231_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_231_1.time_ - 0) / var_234_1)
			end

			if arg_231_1.time_ >= 0 + var_234_1 and arg_231_1.time_ < 0 + var_234_1 + arg_234_0 then
				arg_231_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_234_2 = arg_231_1.actors_["1056"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.actorSpriteComps1056 == nil then
				arg_231_1.var_.actorSpriteComps1056 = var_234_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_3 = 0.034

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_3 and not isNil(var_234_2) then
				if arg_231_1.var_.actorSpriteComps1056 then
					for iter_234_1, iter_234_2 in pairs(arg_231_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_234_2 then
							if arg_231_1.isInRecall_ then
								iter_234_2.color = Color.New(Mathf.Lerp(iter_234_2.color.r, arg_231_1.hightColor1.r, (arg_231_1.time_ - 0) / var_234_3), Mathf.Lerp(iter_234_2.color.g, arg_231_1.hightColor1.g, (arg_231_1.time_ - 0) / var_234_3), (Mathf.Lerp(iter_234_2.color.b, arg_231_1.hightColor1.b, (arg_231_1.time_ - 0) / var_234_3)))
							else
								local var_234_4 = Mathf.Lerp(iter_234_2.color.r, 1, (arg_231_1.time_ - 0) / var_234_3)

								iter_234_2.color = Color.New(var_234_4, var_234_4, var_234_4)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_3 and arg_231_1.time_ < 0 + var_234_3 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.actorSpriteComps1056 then
				for iter_234_3, iter_234_4 in pairs(arg_231_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_234_4 then
						iter_234_4.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_231_1.var_.actorSpriteComps1056 = nil
			end

			local var_234_5 = 0
			local var_234_6 = 1.125

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_7 = arg_231_1:GetWordFromCfg(410041055)
				local var_234_8 = arg_231_1:FormatText(var_234_7.content)

				arg_231_1.text_.text = var_234_8

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_10 = 45 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_8) / 45)

				if (45 <= 0 and var_234_6 or var_234_6 * (utf8.len(var_234_8) / 45)) > 0 and var_234_6 < var_234_10 then
					arg_231_1.talkMaxDuration = var_234_10

					if var_234_10 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_10 + var_234_5
					end
				end

				arg_231_1.text_.text = var_234_8
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041055", "story_v_out_410041.awb") ~= 0 then
					local var_234_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041055", "story_v_out_410041.awb") / 1000

					if var_234_11 + var_234_5 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_11 + var_234_5
					end

					if var_234_7.prefab_name ~= "" and arg_231_1.actors_[var_234_7.prefab_name] ~= nil then
						local var_234_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_7.prefab_name].transform, "story_v_out_410041", "410041055", "story_v_out_410041.awb")

						arg_231_1:RecordAudio("410041055", var_234_12)
						arg_231_1:RecordAudio("410041055", var_234_12)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_410041", "410041055", "story_v_out_410041.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_410041", "410041055", "story_v_out_410041.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_13 = math.max(var_234_6, arg_231_1.talkMaxDuration)

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_13 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_5) / var_234_13

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_5 + var_234_13 and arg_231_1.time_ < var_234_5 + var_234_13 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410041056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 410041056
		arg_235_1.duration_ = 7.33

		local var_235_0 = {
			zh = 4.066,
			ja = 7.333
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
				arg_235_0:Play410041057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos1060 = arg_235_1.actors_["1060"].transform.localPosition
				arg_235_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("1060", 2)

				for iter_238_0 = 0, arg_235_1.actors_["1060"].transform.childCount - 1 do
					local var_238_0 = arg_235_1.actors_["1060"].transform:GetChild(iter_238_0)

					if var_238_0.name == "" or not string.find(var_238_0.name, "split") then
						var_238_0.gameObject:SetActive(true)
					else
						var_238_0.gameObject:SetActive(false)
					end
				end
			end

			local var_238_1 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_1 then
				arg_235_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_235_1.time_ - 0) / var_238_1)
			end

			if arg_235_1.time_ >= 0 + var_238_1 and arg_235_1.time_ < 0 + var_238_1 + arg_238_0 then
				arg_235_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_238_2 = arg_235_1.actors_["1060"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.actorSpriteComps1060 == nil then
				arg_235_1.var_.actorSpriteComps1060 = var_238_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_3 = 0.034

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_3 and not isNil(var_238_2) then
				if arg_235_1.var_.actorSpriteComps1060 then
					for iter_238_1, iter_238_2 in pairs(arg_235_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_238_2 then
							if arg_235_1.isInRecall_ then
								iter_238_2.color = Color.New(Mathf.Lerp(iter_238_2.color.r, arg_235_1.hightColor1.r, (arg_235_1.time_ - 0) / var_238_3), Mathf.Lerp(iter_238_2.color.g, arg_235_1.hightColor1.g, (arg_235_1.time_ - 0) / var_238_3), (Mathf.Lerp(iter_238_2.color.b, arg_235_1.hightColor1.b, (arg_235_1.time_ - 0) / var_238_3)))
							else
								local var_238_4 = Mathf.Lerp(iter_238_2.color.r, 1, (arg_235_1.time_ - 0) / var_238_3)

								iter_238_2.color = Color.New(var_238_4, var_238_4, var_238_4)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_3 and arg_235_1.time_ < 0 + var_238_3 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.actorSpriteComps1060 then
				for iter_238_3, iter_238_4 in pairs(arg_235_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_238_4 then
						iter_238_4.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_235_1.var_.actorSpriteComps1060 = nil
			end

			local var_238_5 = arg_235_1.actors_["1056"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_5) and arg_235_1.var_.actorSpriteComps1056 == nil then
				arg_235_1.var_.actorSpriteComps1056 = var_238_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_6 = 0.034

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_6 and not isNil(var_238_5) then
				if arg_235_1.var_.actorSpriteComps1056 then
					for iter_238_5, iter_238_6 in pairs(arg_235_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_238_6 then
							if arg_235_1.isInRecall_ then
								iter_238_6.color = Color.New(Mathf.Lerp(iter_238_6.color.r, arg_235_1.hightColor2.r, (arg_235_1.time_ - 0) / var_238_6), Mathf.Lerp(iter_238_6.color.g, arg_235_1.hightColor2.g, (arg_235_1.time_ - 0) / var_238_6), (Mathf.Lerp(iter_238_6.color.b, arg_235_1.hightColor2.b, (arg_235_1.time_ - 0) / var_238_6)))
							else
								local var_238_7 = Mathf.Lerp(iter_238_6.color.r, 0.5, (arg_235_1.time_ - 0) / var_238_6)

								iter_238_6.color = Color.New(var_238_7, var_238_7, var_238_7)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_6 and arg_235_1.time_ < 0 + var_238_6 + arg_238_0 and not isNil(var_238_5) and arg_235_1.var_.actorSpriteComps1056 then
				for iter_238_7, iter_238_8 in pairs(arg_235_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_238_8 then
						iter_238_8.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_235_1.var_.actorSpriteComps1056 = nil
			end

			local var_238_8 = 0
			local var_238_9 = 0.375

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_8 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_10 = arg_235_1:GetWordFromCfg(410041056)
				local var_238_11 = arg_235_1:FormatText(var_238_10.content)

				arg_235_1.text_.text = var_238_11

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_13 = 15 <= 0 and var_238_9 or var_238_9 * (utf8.len(var_238_11) / 15)

				if (15 <= 0 and var_238_9 or var_238_9 * (utf8.len(var_238_11) / 15)) > 0 and var_238_9 < var_238_13 then
					arg_235_1.talkMaxDuration = var_238_13

					if var_238_13 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_13 + var_238_8
					end
				end

				arg_235_1.text_.text = var_238_11
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041056", "story_v_out_410041.awb") ~= 0 then
					local var_238_14 = manager.audio:GetVoiceLength("story_v_out_410041", "410041056", "story_v_out_410041.awb") / 1000

					if var_238_14 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_14 + var_238_8
					end

					if var_238_10.prefab_name ~= "" and arg_235_1.actors_[var_238_10.prefab_name] ~= nil then
						local var_238_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_10.prefab_name].transform, "story_v_out_410041", "410041056", "story_v_out_410041.awb")

						arg_235_1:RecordAudio("410041056", var_238_15)
						arg_235_1:RecordAudio("410041056", var_238_15)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_410041", "410041056", "story_v_out_410041.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_410041", "410041056", "story_v_out_410041.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_16 = math.max(var_238_9, arg_235_1.talkMaxDuration)

			if var_238_8 <= arg_235_1.time_ and arg_235_1.time_ < var_238_8 + var_238_16 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_8) / var_238_16

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_8 + var_238_16 and arg_235_1.time_ < var_238_8 + var_238_16 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play410041057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 410041057
		arg_239_1.duration_ = 11.87

		local var_239_0 = {
			zh = 10.966,
			ja = 11.866
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
				arg_239_0:Play410041058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1060 = arg_239_1.actors_["1060"].transform.localPosition
				arg_239_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_239_1:CheckSpriteTmpPos("1060", 2)

				for iter_242_0 = 0, arg_239_1.actors_["1060"].transform.childCount - 1 do
					local var_242_0 = arg_239_1.actors_["1060"].transform:GetChild(iter_242_0)

					if var_242_0.name == "" or not string.find(var_242_0.name, "split") then
						var_242_0.gameObject:SetActive(true)
					else
						var_242_0.gameObject:SetActive(false)
					end
				end
			end

			local var_242_1 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_1 then
				arg_239_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_239_1.time_ - 0) / var_242_1)
			end

			if arg_239_1.time_ >= 0 + var_242_1 and arg_239_1.time_ < 0 + var_242_1 + arg_242_0 then
				arg_239_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_242_2 = arg_239_1.actors_["1060"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps1060 == nil then
				arg_239_1.var_.actorSpriteComps1060 = var_242_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_3 = 0.034

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_3 and not isNil(var_242_2) then
				if arg_239_1.var_.actorSpriteComps1060 then
					for iter_242_1, iter_242_2 in pairs(arg_239_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_242_2 then
							if arg_239_1.isInRecall_ then
								iter_242_2.color = Color.New(Mathf.Lerp(iter_242_2.color.r, arg_239_1.hightColor1.r, (arg_239_1.time_ - 0) / var_242_3), Mathf.Lerp(iter_242_2.color.g, arg_239_1.hightColor1.g, (arg_239_1.time_ - 0) / var_242_3), (Mathf.Lerp(iter_242_2.color.b, arg_239_1.hightColor1.b, (arg_239_1.time_ - 0) / var_242_3)))
							else
								local var_242_4 = Mathf.Lerp(iter_242_2.color.r, 1, (arg_239_1.time_ - 0) / var_242_3)

								iter_242_2.color = Color.New(var_242_4, var_242_4, var_242_4)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_3 and arg_239_1.time_ < 0 + var_242_3 + arg_242_0 and not isNil(var_242_2) and arg_239_1.var_.actorSpriteComps1060 then
				for iter_242_3, iter_242_4 in pairs(arg_239_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_242_4 then
						iter_242_4.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_239_1.var_.actorSpriteComps1060 = nil
			end

			local var_242_5 = 0
			local var_242_6 = 1.425

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_5 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_7 = arg_239_1:GetWordFromCfg(410041057)
				local var_242_8 = arg_239_1:FormatText(var_242_7.content)

				arg_239_1.text_.text = var_242_8

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_10 = 57 <= 0 and var_242_6 or var_242_6 * (utf8.len(var_242_8) / 57)

				if (57 <= 0 and var_242_6 or var_242_6 * (utf8.len(var_242_8) / 57)) > 0 and var_242_6 < var_242_10 then
					arg_239_1.talkMaxDuration = var_242_10

					if var_242_10 + var_242_5 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_5
					end
				end

				arg_239_1.text_.text = var_242_8
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041057", "story_v_out_410041.awb") ~= 0 then
					local var_242_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041057", "story_v_out_410041.awb") / 1000

					if var_242_11 + var_242_5 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_11 + var_242_5
					end

					if var_242_7.prefab_name ~= "" and arg_239_1.actors_[var_242_7.prefab_name] ~= nil then
						local var_242_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_7.prefab_name].transform, "story_v_out_410041", "410041057", "story_v_out_410041.awb")

						arg_239_1:RecordAudio("410041057", var_242_12)
						arg_239_1:RecordAudio("410041057", var_242_12)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_410041", "410041057", "story_v_out_410041.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_410041", "410041057", "story_v_out_410041.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_13 = math.max(var_242_6, arg_239_1.talkMaxDuration)

			if var_242_5 <= arg_239_1.time_ and arg_239_1.time_ < var_242_5 + var_242_13 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_5) / var_242_13

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_5 + var_242_13 and arg_239_1.time_ < var_242_5 + var_242_13 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410041058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 410041058
		arg_243_1.duration_ = 6.57

		local var_243_0 = {
			zh = 4.533,
			ja = 6.566
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
				arg_243_0:Play410041059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1056 = arg_243_1.actors_["1056"].transform.localPosition
				arg_243_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("1056", 4)

				for iter_246_0 = 0, arg_243_1.actors_["1056"].transform.childCount - 1 do
					local var_246_0 = arg_243_1.actors_["1056"].transform:GetChild(iter_246_0)

					if var_246_0.name == "split_1" or not string.find(var_246_0.name, "split") then
						var_246_0.gameObject:SetActive(true)
					else
						var_246_0.gameObject:SetActive(false)
					end
				end
			end

			local var_246_1 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_1 then
				arg_243_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_243_1.time_ - 0) / var_246_1)
			end

			if arg_243_1.time_ >= 0 + var_246_1 and arg_243_1.time_ < 0 + var_246_1 + arg_246_0 then
				arg_243_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_246_2 = arg_243_1.actors_["1056"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.actorSpriteComps1056 == nil then
				arg_243_1.var_.actorSpriteComps1056 = var_246_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_3 = 0.034

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_3 and not isNil(var_246_2) then
				if arg_243_1.var_.actorSpriteComps1056 then
					for iter_246_1, iter_246_2 in pairs(arg_243_1.var_.actorSpriteComps1056:ToTable()) do
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

			if arg_243_1.time_ >= 0 + var_246_3 and arg_243_1.time_ < 0 + var_246_3 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.actorSpriteComps1056 then
				for iter_246_3, iter_246_4 in pairs(arg_243_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_246_4 then
						iter_246_4.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_243_1.var_.actorSpriteComps1056 = nil
			end

			local var_246_5 = arg_243_1.actors_["1060"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_5) and arg_243_1.var_.actorSpriteComps1060 == nil then
				arg_243_1.var_.actorSpriteComps1060 = var_246_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_6 = 0.034

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_6 and not isNil(var_246_5) then
				if arg_243_1.var_.actorSpriteComps1060 then
					for iter_246_5, iter_246_6 in pairs(arg_243_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_246_6 then
							if arg_243_1.isInRecall_ then
								iter_246_6.color = Color.New(Mathf.Lerp(iter_246_6.color.r, arg_243_1.hightColor2.r, (arg_243_1.time_ - 0) / var_246_6), Mathf.Lerp(iter_246_6.color.g, arg_243_1.hightColor2.g, (arg_243_1.time_ - 0) / var_246_6), (Mathf.Lerp(iter_246_6.color.b, arg_243_1.hightColor2.b, (arg_243_1.time_ - 0) / var_246_6)))
							else
								local var_246_7 = Mathf.Lerp(iter_246_6.color.r, 0.5, (arg_243_1.time_ - 0) / var_246_6)

								iter_246_6.color = Color.New(var_246_7, var_246_7, var_246_7)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_6 and arg_243_1.time_ < 0 + var_246_6 + arg_246_0 and not isNil(var_246_5) and arg_243_1.var_.actorSpriteComps1060 then
				for iter_246_7, iter_246_8 in pairs(arg_243_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_246_8 then
						iter_246_8.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_243_1.var_.actorSpriteComps1060 = nil
			end

			local var_246_8 = 0
			local var_246_9 = 0.575

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_8 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_10 = arg_243_1:GetWordFromCfg(410041058)
				local var_246_11 = arg_243_1:FormatText(var_246_10.content)

				arg_243_1.text_.text = var_246_11

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_13 = 23 <= 0 and var_246_9 or var_246_9 * (utf8.len(var_246_11) / 23)

				if (23 <= 0 and var_246_9 or var_246_9 * (utf8.len(var_246_11) / 23)) > 0 and var_246_9 < var_246_13 then
					arg_243_1.talkMaxDuration = var_246_13

					if var_246_13 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_13 + var_246_8
					end
				end

				arg_243_1.text_.text = var_246_11
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041058", "story_v_out_410041.awb") ~= 0 then
					local var_246_14 = manager.audio:GetVoiceLength("story_v_out_410041", "410041058", "story_v_out_410041.awb") / 1000

					if var_246_14 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_14 + var_246_8
					end

					if var_246_10.prefab_name ~= "" and arg_243_1.actors_[var_246_10.prefab_name] ~= nil then
						local var_246_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_10.prefab_name].transform, "story_v_out_410041", "410041058", "story_v_out_410041.awb")

						arg_243_1:RecordAudio("410041058", var_246_15)
						arg_243_1:RecordAudio("410041058", var_246_15)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_410041", "410041058", "story_v_out_410041.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_410041", "410041058", "story_v_out_410041.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_16 = math.max(var_246_9, arg_243_1.talkMaxDuration)

			if var_246_8 <= arg_243_1.time_ and arg_243_1.time_ < var_246_8 + var_246_16 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_8) / var_246_16

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_8 + var_246_16 and arg_243_1.time_ < var_246_8 + var_246_16 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410041059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 410041059
		arg_247_1.duration_ = 7.2

		local var_247_0 = {
			zh = 3.633,
			ja = 7.2
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
				arg_247_0:Play410041060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1056 = arg_247_1.actors_["1056"].transform.localPosition
				arg_247_1.actors_["1056"].transform.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1056", 4)

				for iter_250_0 = 0, arg_247_1.actors_["1056"].transform.childCount - 1 do
					local var_250_0 = arg_247_1.actors_["1056"].transform:GetChild(iter_250_0)

					if var_250_0.name == "" or not string.find(var_250_0.name, "split") then
						var_250_0.gameObject:SetActive(true)
					else
						var_250_0.gameObject:SetActive(false)
					end
				end
			end

			local var_250_1 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_1 then
				arg_247_1.actors_["1056"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1056, Vector3.New(390, -350, -180), (arg_247_1.time_ - 0) / var_250_1)
			end

			if arg_247_1.time_ >= 0 + var_250_1 and arg_247_1.time_ < 0 + var_250_1 + arg_250_0 then
				arg_247_1.actors_["1056"].transform.localPosition = Vector3.New(390, -350, -180)
			end

			local var_250_2 = arg_247_1.actors_["1056"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_2) and arg_247_1.var_.actorSpriteComps1056 == nil then
				arg_247_1.var_.actorSpriteComps1056 = var_250_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_3 = 0.034

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_3 and not isNil(var_250_2) then
				if arg_247_1.var_.actorSpriteComps1056 then
					for iter_250_1, iter_250_2 in pairs(arg_247_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_250_2 then
							if arg_247_1.isInRecall_ then
								iter_250_2.color = Color.New(Mathf.Lerp(iter_250_2.color.r, arg_247_1.hightColor1.r, (arg_247_1.time_ - 0) / var_250_3), Mathf.Lerp(iter_250_2.color.g, arg_247_1.hightColor1.g, (arg_247_1.time_ - 0) / var_250_3), (Mathf.Lerp(iter_250_2.color.b, arg_247_1.hightColor1.b, (arg_247_1.time_ - 0) / var_250_3)))
							else
								local var_250_4 = Mathf.Lerp(iter_250_2.color.r, 1, (arg_247_1.time_ - 0) / var_250_3)

								iter_250_2.color = Color.New(var_250_4, var_250_4, var_250_4)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 0 + var_250_3 and arg_247_1.time_ < 0 + var_250_3 + arg_250_0 and not isNil(var_250_2) and arg_247_1.var_.actorSpriteComps1056 then
				for iter_250_3, iter_250_4 in pairs(arg_247_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_250_4 then
						iter_250_4.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_247_1.var_.actorSpriteComps1056 = nil
			end

			local var_250_5 = 0
			local var_250_6 = 0.525

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[605].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_7 = arg_247_1:GetWordFromCfg(410041059)
				local var_250_8 = arg_247_1:FormatText(var_250_7.content)

				arg_247_1.text_.text = var_250_8

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_10 = 21 <= 0 and var_250_6 or var_250_6 * (utf8.len(var_250_8) / 21)

				if (21 <= 0 and var_250_6 or var_250_6 * (utf8.len(var_250_8) / 21)) > 0 and var_250_6 < var_250_10 then
					arg_247_1.talkMaxDuration = var_250_10

					if var_250_10 + var_250_5 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_5
					end
				end

				arg_247_1.text_.text = var_250_8
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041059", "story_v_out_410041.awb") ~= 0 then
					local var_250_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041059", "story_v_out_410041.awb") / 1000

					if var_250_11 + var_250_5 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_11 + var_250_5
					end

					if var_250_7.prefab_name ~= "" and arg_247_1.actors_[var_250_7.prefab_name] ~= nil then
						local var_250_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_7.prefab_name].transform, "story_v_out_410041", "410041059", "story_v_out_410041.awb")

						arg_247_1:RecordAudio("410041059", var_250_12)
						arg_247_1:RecordAudio("410041059", var_250_12)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_410041", "410041059", "story_v_out_410041.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_410041", "410041059", "story_v_out_410041.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_13 = math.max(var_250_6, arg_247_1.talkMaxDuration)

			if var_250_5 <= arg_247_1.time_ and arg_247_1.time_ < var_250_5 + var_250_13 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_5) / var_250_13

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_5 + var_250_13 and arg_247_1.time_ < var_250_5 + var_250_13 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1056",
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
	Play410041060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 410041060
		arg_251_1.duration_ = 4.4

		local var_251_0 = {
			zh = 1.833,
			ja = 4.4
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
				arg_251_0:Play410041061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1060 = arg_251_1.actors_["1060"].transform.localPosition
				arg_251_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("1060", 2)

				for iter_254_0 = 0, arg_251_1.actors_["1060"].transform.childCount - 1 do
					local var_254_0 = arg_251_1.actors_["1060"].transform:GetChild(iter_254_0)

					if var_254_0.name == "split_2" or not string.find(var_254_0.name, "split") then
						var_254_0.gameObject:SetActive(true)
					else
						var_254_0.gameObject:SetActive(false)
					end
				end
			end

			local var_254_1 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_1 then
				arg_251_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_251_1.time_ - 0) / var_254_1)
			end

			if arg_251_1.time_ >= 0 + var_254_1 and arg_251_1.time_ < 0 + var_254_1 + arg_254_0 then
				arg_251_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_254_2 = arg_251_1.actors_["1060"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_2) and arg_251_1.var_.actorSpriteComps1060 == nil then
				arg_251_1.var_.actorSpriteComps1060 = var_254_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_3 = 0.034

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_3 and not isNil(var_254_2) then
				if arg_251_1.var_.actorSpriteComps1060 then
					for iter_254_1, iter_254_2 in pairs(arg_251_1.var_.actorSpriteComps1060:ToTable()) do
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

			if arg_251_1.time_ >= 0 + var_254_3 and arg_251_1.time_ < 0 + var_254_3 + arg_254_0 and not isNil(var_254_2) and arg_251_1.var_.actorSpriteComps1060 then
				for iter_254_3, iter_254_4 in pairs(arg_251_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_254_4 then
						iter_254_4.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_251_1.var_.actorSpriteComps1060 = nil
			end

			local var_254_5 = arg_251_1.actors_["1056"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_5) and arg_251_1.var_.actorSpriteComps1056 == nil then
				arg_251_1.var_.actorSpriteComps1056 = var_254_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_6 = 0.034

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_6 and not isNil(var_254_5) then
				if arg_251_1.var_.actorSpriteComps1056 then
					for iter_254_5, iter_254_6 in pairs(arg_251_1.var_.actorSpriteComps1056:ToTable()) do
						if iter_254_6 then
							if arg_251_1.isInRecall_ then
								iter_254_6.color = Color.New(Mathf.Lerp(iter_254_6.color.r, arg_251_1.hightColor2.r, (arg_251_1.time_ - 0) / var_254_6), Mathf.Lerp(iter_254_6.color.g, arg_251_1.hightColor2.g, (arg_251_1.time_ - 0) / var_254_6), (Mathf.Lerp(iter_254_6.color.b, arg_251_1.hightColor2.b, (arg_251_1.time_ - 0) / var_254_6)))
							else
								local var_254_7 = Mathf.Lerp(iter_254_6.color.r, 0.5, (arg_251_1.time_ - 0) / var_254_6)

								iter_254_6.color = Color.New(var_254_7, var_254_7, var_254_7)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 0 + var_254_6 and arg_251_1.time_ < 0 + var_254_6 + arg_254_0 and not isNil(var_254_5) and arg_251_1.var_.actorSpriteComps1056 then
				for iter_254_7, iter_254_8 in pairs(arg_251_1.var_.actorSpriteComps1056:ToTable()) do
					if iter_254_8 then
						iter_254_8.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_251_1.var_.actorSpriteComps1056 = nil
			end

			local var_254_8 = 0
			local var_254_9 = 0.15

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_8 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_10 = arg_251_1:GetWordFromCfg(410041060)
				local var_254_11 = arg_251_1:FormatText(var_254_10.content)

				arg_251_1.text_.text = var_254_11

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_13 = 6 <= 0 and var_254_9 or var_254_9 * (utf8.len(var_254_11) / 6)

				if (6 <= 0 and var_254_9 or var_254_9 * (utf8.len(var_254_11) / 6)) > 0 and var_254_9 < var_254_13 then
					arg_251_1.talkMaxDuration = var_254_13

					if var_254_13 + var_254_8 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_13 + var_254_8
					end
				end

				arg_251_1.text_.text = var_254_11
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041060", "story_v_out_410041.awb") ~= 0 then
					local var_254_14 = manager.audio:GetVoiceLength("story_v_out_410041", "410041060", "story_v_out_410041.awb") / 1000

					if var_254_14 + var_254_8 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_14 + var_254_8
					end

					if var_254_10.prefab_name ~= "" and arg_251_1.actors_[var_254_10.prefab_name] ~= nil then
						local var_254_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_10.prefab_name].transform, "story_v_out_410041", "410041060", "story_v_out_410041.awb")

						arg_251_1:RecordAudio("410041060", var_254_15)
						arg_251_1:RecordAudio("410041060", var_254_15)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_410041", "410041060", "story_v_out_410041.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_410041", "410041060", "story_v_out_410041.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_16 = math.max(var_254_9, arg_251_1.talkMaxDuration)

			if var_254_8 <= arg_251_1.time_ and arg_251_1.time_ < var_254_8 + var_254_16 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_8) / var_254_16

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_8 + var_254_16 and arg_251_1.time_ < var_254_8 + var_254_16 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
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
	Play410041061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 410041061
		arg_255_1.duration_ = 7.5

		local var_255_0 = {
			zh = 4.333,
			ja = 7.5
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
			arg_255_1.auto_ = false
		end

		function arg_255_1.playNext_(arg_257_0)
			arg_255_1.onStoryFinished_()
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1060 = arg_255_1.actors_["1060"].transform.localPosition
				arg_255_1.actors_["1060"].transform.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("1060", 2)

				for iter_258_0 = 0, arg_255_1.actors_["1060"].transform.childCount - 1 do
					local var_258_0 = arg_255_1.actors_["1060"].transform:GetChild(iter_258_0)

					if var_258_0.name == "" or not string.find(var_258_0.name, "split") then
						var_258_0.gameObject:SetActive(true)
					else
						var_258_0.gameObject:SetActive(false)
					end
				end
			end

			local var_258_1 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_1 then
				arg_255_1.actors_["1060"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1060, Vector3.New(-440.94, -430.8, 6.9), (arg_255_1.time_ - 0) / var_258_1)
			end

			if arg_255_1.time_ >= 0 + var_258_1 and arg_255_1.time_ < 0 + var_258_1 + arg_258_0 then
				arg_255_1.actors_["1060"].transform.localPosition = Vector3.New(-440.94, -430.8, 6.9)
			end

			local var_258_2 = arg_255_1.actors_["1060"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_2) and arg_255_1.var_.actorSpriteComps1060 == nil then
				arg_255_1.var_.actorSpriteComps1060 = var_258_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_3 = 0.034

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_3 and not isNil(var_258_2) then
				if arg_255_1.var_.actorSpriteComps1060 then
					for iter_258_1, iter_258_2 in pairs(arg_255_1.var_.actorSpriteComps1060:ToTable()) do
						if iter_258_2 then
							if arg_255_1.isInRecall_ then
								iter_258_2.color = Color.New(Mathf.Lerp(iter_258_2.color.r, arg_255_1.hightColor1.r, (arg_255_1.time_ - 0) / var_258_3), Mathf.Lerp(iter_258_2.color.g, arg_255_1.hightColor1.g, (arg_255_1.time_ - 0) / var_258_3), (Mathf.Lerp(iter_258_2.color.b, arg_255_1.hightColor1.b, (arg_255_1.time_ - 0) / var_258_3)))
							else
								local var_258_4 = Mathf.Lerp(iter_258_2.color.r, 1, (arg_255_1.time_ - 0) / var_258_3)

								iter_258_2.color = Color.New(var_258_4, var_258_4, var_258_4)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_3 and arg_255_1.time_ < 0 + var_258_3 + arg_258_0 and not isNil(var_258_2) and arg_255_1.var_.actorSpriteComps1060 then
				for iter_258_3, iter_258_4 in pairs(arg_255_1.var_.actorSpriteComps1060:ToTable()) do
					if iter_258_4 then
						iter_258_4.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_255_1.var_.actorSpriteComps1060 = nil
			end

			local var_258_5 = 0
			local var_258_6 = 0.5

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_5 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_7 = arg_255_1:GetWordFromCfg(410041061)
				local var_258_8 = arg_255_1:FormatText(var_258_7.content)

				arg_255_1.text_.text = var_258_8

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_10 = 20 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 20)

				if (20 <= 0 and var_258_6 or var_258_6 * (utf8.len(var_258_8) / 20)) > 0 and var_258_6 < var_258_10 then
					arg_255_1.talkMaxDuration = var_258_10

					if var_258_10 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_10 + var_258_5
					end
				end

				arg_255_1.text_.text = var_258_8
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410041", "410041061", "story_v_out_410041.awb") ~= 0 then
					local var_258_11 = manager.audio:GetVoiceLength("story_v_out_410041", "410041061", "story_v_out_410041.awb") / 1000

					if var_258_11 + var_258_5 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_11 + var_258_5
					end

					if var_258_7.prefab_name ~= "" and arg_255_1.actors_[var_258_7.prefab_name] ~= nil then
						local var_258_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_7.prefab_name].transform, "story_v_out_410041", "410041061", "story_v_out_410041.awb")

						arg_255_1:RecordAudio("410041061", var_258_12)
						arg_255_1:RecordAudio("410041061", var_258_12)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_410041", "410041061", "story_v_out_410041.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_410041", "410041061", "story_v_out_410041.awb")
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

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1060",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J02f",
		"TextureConfig/Background/ST61a"
	},
	voices = {
		"story_v_out_410041.awb"
	}
}
