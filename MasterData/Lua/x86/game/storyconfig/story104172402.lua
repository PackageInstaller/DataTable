return {
	Play417242001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 417242001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play417242002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 2 + 0.7 and arg_1_1.time_ < 2 + 0.7 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = "I17f"

			if arg_1_1.bgs_.I17f == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_2 = arg_1_1.bgs_.I17f

				arg_1_1.bgs_.I17f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_3 = var_4_2:GetComponent("SpriteRenderer")

				if var_4_3 and var_4_3.sprite then
					local var_4_4 = 2 * (var_4_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_2.transform.localScale = Vector3.New(var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I17f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_sword02", "")
			end

			if 0.02 < arg_1_1.time_ and arg_1_1.time_ <= 0.02 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_13 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_13 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_13

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_13
						arg_1_1.bgmTxt2_.text = var_4_13
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

			local var_4_14 = 2
			local var_4_15 = 1.525

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_14 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_16 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_16:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_17 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(417242001).content)

				arg_1_1.text_.text = var_4_17

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_19 = 61 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 61)

				if (61 <= 0 and var_4_15 or var_4_15 * (utf8.len(var_4_17) / 61)) > 0 and var_4_15 < var_4_19 then
					arg_1_1.talkMaxDuration = var_4_19
					var_4_14 = var_4_14 + 0.3

					if var_4_19 + var_4_14 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_19 + var_4_14
					end
				end

				arg_1_1.text_.text = var_4_17
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_20 = var_4_14 + 0.3
			local var_4_21 = math.max(var_4_15, arg_1_1.talkMaxDuration)

			if var_4_14 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_20 + var_4_21 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_20) / var_4_21

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_20 + var_4_21 and arg_1_1.time_ < var_4_20 + var_4_21 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play417242002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 417242002
		arg_8_1.duration_ = 4.53

		local var_8_0 = {
			zh = 2,
			ja = 4.533
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
				arg_8_0:Play417242003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1034"] == nil then
				local var_11_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1034")

				if not isNil(var_11_0) then
					local var_11_1 = Object.Instantiate(var_11_0, arg_8_1.canvasGo_.transform)

					var_11_1.transform:SetSiblingIndex(1)

					var_11_1.name = "1034"
					var_11_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_8_1.actors_["1034"] = var_11_1

					if arg_8_1.isInRecall_ then
						for iter_11_0, iter_11_1 in ipairs((var_11_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_11_1.color = arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_11_2 = arg_8_1.actors_["1034"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_2) and arg_8_1.var_.actorSpriteComps1034 == nil then
				arg_8_1.var_.actorSpriteComps1034 = var_11_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_3 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_3 and not isNil(var_11_2) then
				if arg_8_1.var_.actorSpriteComps1034 then
					for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps1034:ToTable()) do
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

			if arg_8_1.time_ >= 0 + var_11_3 and arg_8_1.time_ < 0 + var_11_3 + arg_11_0 and not isNil(var_11_2) and arg_8_1.var_.actorSpriteComps1034 then
				for iter_11_4, iter_11_5 in pairs(arg_8_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_11_5 then
						iter_11_5.color = arg_8_1.isInRecall_ and (arg_8_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_8_1.var_.actorSpriteComps1034 = nil
			end

			local var_11_5 = arg_8_1.actors_["1034"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1034 = var_11_5.localPosition
				var_11_5.localScale = Vector3.New(1, 1, 1)

				arg_8_1:CheckSpriteTmpPos("1034", 3)

				for iter_11_6 = 0, var_11_5.childCount - 1 do
					local var_11_6 = var_11_5:GetChild(iter_11_6)

					if var_11_6.name == "split_4" or not string.find(var_11_6.name, "split") then
						var_11_6.gameObject:SetActive(true)
					else
						var_11_6.gameObject:SetActive(false)
					end
				end
			end

			local var_11_7 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				var_11_5.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_8_1.time_ - 0) / var_11_7)
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				var_11_5.localPosition = Vector3.New(0, -331.9, -324)
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_11_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_10 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_10

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_10
						arg_8_1.bgmTxt2_.text = var_11_10
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.4 < arg_8_1.time_ and arg_8_1.time_ <= 0.4 + arg_11_0 then
				arg_8_1:AudioAction("play", "music", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1.awb")

				local var_11_13 = manager.audio:GetAudioName("bgm_activity_3_10_story_scheme_1", "bgm_activity_3_10_story_scheme_1")

				if "" ~= "" then
					if arg_8_1.bgmTxt_.text ~= var_11_13 and arg_8_1.bgmTxt_.text ~= "" then
						if arg_8_1.bgmTxt2_.text ~= "" then
							arg_8_1.bgmTxt_.text = arg_8_1.bgmTxt2_.text
						end

						arg_8_1.bgmTxt2_.text = var_11_13

						arg_8_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_8_1.bgmTxt_.text = var_11_13
						arg_8_1.bgmTxt2_.text = var_11_13
					end

					if arg_8_1.bgmTimer then
						arg_8_1.bgmTimer:Stop()

						arg_8_1.bgmTimer = nil
					end

					if arg_8_1.settingData.show_music_name == 1 then
						arg_8_1.musicController:SetSelectedState("show")
						arg_8_1.musicAnimator_:Play("open", 0, 0)

						if arg_8_1.settingData.music_time ~= 0 then
							arg_8_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_8_1.settingData.music_time), function()
								if arg_8_1 == nil or isNil(arg_8_1.bgmTxt_) then
									return
								end

								arg_8_1.musicController:SetSelectedState("hide")
								arg_8_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_11_14 = 0
			local var_11_15 = 0.275

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_14 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_16 = arg_8_1:GetWordFromCfg(417242002)
				local var_11_17 = arg_8_1:FormatText(var_11_16.content)

				arg_8_1.text_.text = var_11_17

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_19 = 11 <= 0 and var_11_15 or var_11_15 * (utf8.len(var_11_17) / 11)

				if (11 <= 0 and var_11_15 or var_11_15 * (utf8.len(var_11_17) / 11)) > 0 and var_11_15 < var_11_19 then
					arg_8_1.talkMaxDuration = var_11_19

					if var_11_19 + var_11_14 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_19 + var_11_14
					end
				end

				arg_8_1.text_.text = var_11_17
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242002", "story_v_out_417242.awb") ~= 0 then
					local var_11_20 = manager.audio:GetVoiceLength("story_v_out_417242", "417242002", "story_v_out_417242.awb") / 1000

					if var_11_20 + var_11_14 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_20 + var_11_14
					end

					if var_11_16.prefab_name ~= "" and arg_8_1.actors_[var_11_16.prefab_name] ~= nil then
						local var_11_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_16.prefab_name].transform, "story_v_out_417242", "417242002", "story_v_out_417242.awb")

						arg_8_1:RecordAudio("417242002", var_11_21)
						arg_8_1:RecordAudio("417242002", var_11_21)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_417242", "417242002", "story_v_out_417242.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_417242", "417242002", "story_v_out_417242.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_22 = math.max(var_11_15, arg_8_1.talkMaxDuration)

			if var_11_14 <= arg_8_1.time_ and arg_8_1.time_ < var_11_14 + var_11_22 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_14) / var_11_22

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_14 + var_11_22 and arg_8_1.time_ < var_11_14 + var_11_22 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play417242003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 417242003
		arg_14_1.duration_ = 1.87

		local var_14_0 = {
			zh = 1.866,
			ja = 1.4
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play417242004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			if arg_14_1.actors_["10128"] == nil then
				local var_17_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10128")

				if not isNil(var_17_0) then
					local var_17_1 = Object.Instantiate(var_17_0, arg_14_1.canvasGo_.transform)

					var_17_1.transform:SetSiblingIndex(1)

					var_17_1.name = "10128"
					var_17_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_14_1.actors_["10128"] = var_17_1

					if arg_14_1.isInRecall_ then
						for iter_17_0, iter_17_1 in ipairs((var_17_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_17_1.color = arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_17_2 = arg_14_1.actors_["10128"]

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(var_17_2) and arg_14_1.var_.actorSpriteComps10128 == nil then
				arg_14_1.var_.actorSpriteComps10128 = var_17_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_3 = 0.2

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_3 and not isNil(var_17_2) then
				if arg_14_1.var_.actorSpriteComps10128 then
					for iter_17_2, iter_17_3 in pairs(arg_14_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_17_3 then
							if arg_14_1.isInRecall_ then
								iter_17_3.color = Color.New(Mathf.Lerp(iter_17_3.color.r, arg_14_1.hightColor1.r, (arg_14_1.time_ - 0) / var_17_3), Mathf.Lerp(iter_17_3.color.g, arg_14_1.hightColor1.g, (arg_14_1.time_ - 0) / var_17_3), (Mathf.Lerp(iter_17_3.color.b, arg_14_1.hightColor1.b, (arg_14_1.time_ - 0) / var_17_3)))
							else
								local var_17_4 = Mathf.Lerp(iter_17_3.color.r, 1, (arg_14_1.time_ - 0) / var_17_3)

								iter_17_3.color = Color.New(var_17_4, var_17_4, var_17_4)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= 0 + var_17_3 and arg_14_1.time_ < 0 + var_17_3 + arg_17_0 and not isNil(var_17_2) and arg_14_1.var_.actorSpriteComps10128 then
				for iter_17_4, iter_17_5 in pairs(arg_14_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_17_5 then
						iter_17_5.color = arg_14_1.isInRecall_ and (arg_14_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_14_1.var_.actorSpriteComps10128 = nil
			end

			local var_17_5 = arg_14_1.actors_["1034"]

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 and not isNil(var_17_5) and arg_14_1.var_.actorSpriteComps1034 == nil then
				arg_14_1.var_.actorSpriteComps1034 = var_17_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_17_6 = 0.2

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_6 and not isNil(var_17_5) then
				if arg_14_1.var_.actorSpriteComps1034 then
					for iter_17_6, iter_17_7 in pairs(arg_14_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_17_7 then
							if arg_14_1.isInRecall_ then
								iter_17_7.color = Color.New(Mathf.Lerp(iter_17_7.color.r, arg_14_1.hightColor2.r, (arg_14_1.time_ - 0) / var_17_6), Mathf.Lerp(iter_17_7.color.g, arg_14_1.hightColor2.g, (arg_14_1.time_ - 0) / var_17_6), (Mathf.Lerp(iter_17_7.color.b, arg_14_1.hightColor2.b, (arg_14_1.time_ - 0) / var_17_6)))
							else
								local var_17_7 = Mathf.Lerp(iter_17_7.color.r, 0.5, (arg_14_1.time_ - 0) / var_17_6)

								iter_17_7.color = Color.New(var_17_7, var_17_7, var_17_7)
							end
						end
					end
				end
			end

			if arg_14_1.time_ >= 0 + var_17_6 and arg_14_1.time_ < 0 + var_17_6 + arg_17_0 and not isNil(var_17_5) and arg_14_1.var_.actorSpriteComps1034 then
				for iter_17_8, iter_17_9 in pairs(arg_14_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_17_9 then
						iter_17_9.color = arg_14_1.isInRecall_ and (arg_14_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_14_1.var_.actorSpriteComps1034 = nil
			end

			local var_17_8 = arg_14_1.actors_["1034"].transform

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.moveOldPos1034 = var_17_8.localPosition
				var_17_8.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("1034", 2)

				for iter_17_10 = 0, var_17_8.childCount - 1 do
					local var_17_9 = var_17_8:GetChild(iter_17_10)

					if var_17_9.name == "split_4" or not string.find(var_17_9.name, "split") then
						var_17_9.gameObject:SetActive(true)
					else
						var_17_9.gameObject:SetActive(false)
					end
				end
			end

			local var_17_10 = 0.001

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_10 then
				var_17_8.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_14_1.time_ - 0) / var_17_10)
			end

			if arg_14_1.time_ >= 0 + var_17_10 and arg_14_1.time_ < 0 + var_17_10 + arg_17_0 then
				var_17_8.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_17_11 = arg_14_1.actors_["10128"].transform

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= 0 + arg_17_0 then
				arg_14_1.var_.moveOldPos10128 = var_17_11.localPosition
				var_17_11.localScale = Vector3.New(1, 1, 1)

				arg_14_1:CheckSpriteTmpPos("10128", 4)

				for iter_17_11 = 0, var_17_11.childCount - 1 do
					local var_17_12 = var_17_11:GetChild(iter_17_11)

					if var_17_12.name == "" or not string.find(var_17_12.name, "split") then
						var_17_12.gameObject:SetActive(true)
					else
						var_17_12.gameObject:SetActive(false)
					end
				end
			end

			local var_17_13 = 0.001

			if 0 <= arg_14_1.time_ and arg_14_1.time_ < 0 + var_17_13 then
				var_17_11.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_14_1.time_ - 0) / var_17_13)
			end

			if arg_14_1.time_ >= 0 + var_17_13 and arg_14_1.time_ < 0 + var_17_13 + arg_17_0 then
				var_17_11.localPosition = Vector3.New(390, -347, -300)
			end

			local var_17_14 = 0
			local var_17_15 = 0.275

			if 0 < arg_14_1.time_ and arg_14_1.time_ <= var_17_14 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				arg_14_1.leftNameTxt_.text = arg_14_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_16 = arg_14_1:GetWordFromCfg(417242003)
				local var_17_17 = arg_14_1:FormatText(var_17_16.content)

				arg_14_1.text_.text = var_17_17

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_19 = 11 <= 0 and var_17_15 or var_17_15 * (utf8.len(var_17_17) / 11)

				if (11 <= 0 and var_17_15 or var_17_15 * (utf8.len(var_17_17) / 11)) > 0 and var_17_15 < var_17_19 then
					arg_14_1.talkMaxDuration = var_17_19

					if var_17_19 + var_17_14 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_19 + var_17_14
					end
				end

				arg_14_1.text_.text = var_17_17
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242003", "story_v_out_417242.awb") ~= 0 then
					local var_17_20 = manager.audio:GetVoiceLength("story_v_out_417242", "417242003", "story_v_out_417242.awb") / 1000

					if var_17_20 + var_17_14 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_20 + var_17_14
					end

					if var_17_16.prefab_name ~= "" and arg_14_1.actors_[var_17_16.prefab_name] ~= nil then
						local var_17_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_16.prefab_name].transform, "story_v_out_417242", "417242003", "story_v_out_417242.awb")

						arg_14_1:RecordAudio("417242003", var_17_21)
						arg_14_1:RecordAudio("417242003", var_17_21)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_417242", "417242003", "story_v_out_417242.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_417242", "417242003", "story_v_out_417242.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_22 = math.max(var_17_15, arg_14_1.talkMaxDuration)

			if var_17_14 <= arg_14_1.time_ and arg_14_1.time_ < var_17_14 + var_17_22 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_14) / var_17_22

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_14 + var_17_22 and arg_14_1.time_ < var_17_14 + var_17_22 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play417242004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 417242004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play417242005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(arg_18_1.actors_["1034"]) and arg_18_1.var_.actorSpriteComps1034 == nil then
				arg_18_1.var_.actorSpriteComps1034 = arg_18_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_0 = 0.2

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_0 and not isNil(arg_18_1.actors_["1034"]) then
				if arg_18_1.var_.actorSpriteComps1034 then
					for iter_21_0, iter_21_1 in pairs(arg_18_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_21_1 then
							if arg_18_1.isInRecall_ then
								iter_21_1.color = Color.New(Mathf.Lerp(iter_21_1.color.r, arg_18_1.hightColor1.r, (arg_18_1.time_ - 0) / var_21_0), Mathf.Lerp(iter_21_1.color.g, arg_18_1.hightColor1.g, (arg_18_1.time_ - 0) / var_21_0), (Mathf.Lerp(iter_21_1.color.b, arg_18_1.hightColor1.b, (arg_18_1.time_ - 0) / var_21_0)))
							else
								local var_21_1 = Mathf.Lerp(iter_21_1.color.r, 1, (arg_18_1.time_ - 0) / var_21_0)

								iter_21_1.color = Color.New(var_21_1, var_21_1, var_21_1)
							end
						end
					end
				end
			end

			if arg_18_1.time_ >= 0 + var_21_0 and arg_18_1.time_ < 0 + var_21_0 + arg_21_0 and not isNil(arg_18_1.actors_["1034"]) and arg_18_1.var_.actorSpriteComps1034 then
				for iter_21_2, iter_21_3 in pairs(arg_18_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_21_3 then
						iter_21_3.color = arg_18_1.isInRecall_ and (arg_18_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_18_1.var_.actorSpriteComps1034 = nil
			end

			local var_21_2 = arg_18_1.actors_["10128"]

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= 0 + arg_21_0 and not isNil(var_21_2) and arg_18_1.var_.actorSpriteComps10128 == nil then
				arg_18_1.var_.actorSpriteComps10128 = var_21_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_21_3 = 0.2

			if 0 <= arg_18_1.time_ and arg_18_1.time_ < 0 + var_21_3 and not isNil(var_21_2) then
				if arg_18_1.var_.actorSpriteComps10128 then
					for iter_21_4, iter_21_5 in pairs(arg_18_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_21_5 then
							if arg_18_1.isInRecall_ then
								iter_21_5.color = Color.New(Mathf.Lerp(iter_21_5.color.r, arg_18_1.hightColor2.r, (arg_18_1.time_ - 0) / var_21_3), Mathf.Lerp(iter_21_5.color.g, arg_18_1.hightColor2.g, (arg_18_1.time_ - 0) / var_21_3), (Mathf.Lerp(iter_21_5.color.b, arg_18_1.hightColor2.b, (arg_18_1.time_ - 0) / var_21_3)))
							else
								local var_21_4 = Mathf.Lerp(iter_21_5.color.r, 0.5, (arg_18_1.time_ - 0) / var_21_3)

								iter_21_5.color = Color.New(var_21_4, var_21_4, var_21_4)
							end
						end
					end
				end
			end

			if arg_18_1.time_ >= 0 + var_21_3 and arg_18_1.time_ < 0 + var_21_3 + arg_21_0 and not isNil(var_21_2) and arg_18_1.var_.actorSpriteComps10128 then
				for iter_21_6, iter_21_7 in pairs(arg_18_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_21_7 then
						iter_21_7.color = arg_18_1.isInRecall_ and (arg_18_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_18_1.var_.actorSpriteComps10128 = nil
			end

			local var_21_5 = 0
			local var_21_6 = 0.05

			if 0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_5 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				arg_18_1.leftNameTxt_.text = arg_18_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_7 = arg_18_1:FormatText(arg_18_1:GetWordFromCfg(417242004).content)

				arg_18_1.text_.text = var_21_7

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_9 = 2 <= 0 and var_21_6 or var_21_6 * (utf8.len(var_21_7) / 2)

				if (2 <= 0 and var_21_6 or var_21_6 * (utf8.len(var_21_7) / 2)) > 0 and var_21_6 < var_21_9 then
					arg_18_1.talkMaxDuration = var_21_9

					if var_21_9 + var_21_5 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_9 + var_21_5
					end
				end

				arg_18_1.text_.text = var_21_7
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_10 = math.max(var_21_6, arg_18_1.talkMaxDuration)

			if var_21_5 <= arg_18_1.time_ and arg_18_1.time_ < var_21_5 + var_21_10 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_5) / var_21_10

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_5 + var_21_10 and arg_18_1.time_ < var_21_5 + var_21_10 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play417242005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 417242005
		arg_22_1.duration_ = 7.6

		local var_22_0 = {
			zh = 4.1,
			ja = 7.6
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play417242006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			if arg_22_1.actors_["10115"] == nil then
				local var_25_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10115")

				if not isNil(var_25_0) then
					local var_25_1 = Object.Instantiate(var_25_0, arg_22_1.canvasGo_.transform)

					var_25_1.transform:SetSiblingIndex(1)

					var_25_1.name = "10115"
					var_25_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_22_1.actors_["10115"] = var_25_1

					if arg_22_1.isInRecall_ then
						for iter_25_0, iter_25_1 in ipairs((var_25_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_25_1.color = arg_22_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_25_2 = arg_22_1.actors_["10115"]

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 and not isNil(var_25_2) and arg_22_1.var_.actorSpriteComps10115 == nil then
				arg_22_1.var_.actorSpriteComps10115 = var_25_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_25_3 = 0.2

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_3 and not isNil(var_25_2) then
				if arg_22_1.var_.actorSpriteComps10115 then
					for iter_25_2, iter_25_3 in pairs(arg_22_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_25_3 then
							if arg_22_1.isInRecall_ then
								iter_25_3.color = Color.New(Mathf.Lerp(iter_25_3.color.r, arg_22_1.hightColor1.r, (arg_22_1.time_ - 0) / var_25_3), Mathf.Lerp(iter_25_3.color.g, arg_22_1.hightColor1.g, (arg_22_1.time_ - 0) / var_25_3), (Mathf.Lerp(iter_25_3.color.b, arg_22_1.hightColor1.b, (arg_22_1.time_ - 0) / var_25_3)))
							else
								local var_25_4 = Mathf.Lerp(iter_25_3.color.r, 1, (arg_22_1.time_ - 0) / var_25_3)

								iter_25_3.color = Color.New(var_25_4, var_25_4, var_25_4)
							end
						end
					end
				end
			end

			if arg_22_1.time_ >= 0 + var_25_3 and arg_22_1.time_ < 0 + var_25_3 + arg_25_0 and not isNil(var_25_2) and arg_22_1.var_.actorSpriteComps10115 then
				for iter_25_4, iter_25_5 in pairs(arg_22_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_25_5 then
						iter_25_5.color = arg_22_1.isInRecall_ and (arg_22_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_22_1.var_.actorSpriteComps10115 = nil
			end

			local var_25_5 = arg_22_1.actors_["1034"].transform

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPos1034 = var_25_5.localPosition
				var_25_5.localScale = Vector3.New(1, 1, 1)

				arg_22_1:CheckSpriteTmpPos("1034", 7)

				for iter_25_6 = 0, var_25_5.childCount - 1 do
					local var_25_6 = var_25_5:GetChild(iter_25_6)

					if var_25_6.name == "" or not string.find(var_25_6.name, "split") then
						var_25_6.gameObject:SetActive(true)
					else
						var_25_6.gameObject:SetActive(false)
					end
				end
			end

			local var_25_7 = 0.001

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_7 then
				var_25_5.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_22_1.time_ - 0) / var_25_7)
			end

			if arg_22_1.time_ >= 0 + var_25_7 and arg_22_1.time_ < 0 + var_25_7 + arg_25_0 then
				var_25_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_25_8 = arg_22_1.actors_["10128"].transform

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPos10128 = var_25_8.localPosition
				var_25_8.localScale = Vector3.New(1, 1, 1)

				arg_22_1:CheckSpriteTmpPos("10128", 7)

				for iter_25_7 = 0, var_25_8.childCount - 1 do
					local var_25_9 = var_25_8:GetChild(iter_25_7)

					if var_25_9.name == "" or not string.find(var_25_9.name, "split") then
						var_25_9.gameObject:SetActive(true)
					else
						var_25_9.gameObject:SetActive(false)
					end
				end
			end

			local var_25_10 = 0.001

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_10 then
				var_25_8.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_22_1.time_ - 0) / var_25_10)
			end

			if arg_22_1.time_ >= 0 + var_25_10 and arg_22_1.time_ < 0 + var_25_10 + arg_25_0 then
				var_25_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_25_11 = arg_22_1.actors_["10115"].transform

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= 0 + arg_25_0 then
				arg_22_1.var_.moveOldPos10115 = var_25_11.localPosition
				var_25_11.localScale = Vector3.New(1, 1, 1)

				arg_22_1:CheckSpriteTmpPos("10115", 3)

				for iter_25_8 = 0, var_25_11.childCount - 1 do
					local var_25_12 = var_25_11:GetChild(iter_25_8)

					if var_25_12.name == "split_2" or not string.find(var_25_12.name, "split") then
						var_25_12.gameObject:SetActive(true)
					else
						var_25_12.gameObject:SetActive(false)
					end
				end
			end

			local var_25_13 = 0.001

			if 0 <= arg_22_1.time_ and arg_22_1.time_ < 0 + var_25_13 then
				var_25_11.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPos10115, Vector3.New(0, -387.3, -246.2), (arg_22_1.time_ - 0) / var_25_13)
			end

			if arg_22_1.time_ >= 0 + var_25_13 and arg_22_1.time_ < 0 + var_25_13 + arg_25_0 then
				var_25_11.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_25_14 = 0
			local var_25_15 = 0.425

			if 0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_14 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				arg_22_1.leftNameTxt_.text = arg_22_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_16 = arg_22_1:GetWordFromCfg(417242005)
				local var_25_17 = arg_22_1:FormatText(var_25_16.content)

				arg_22_1.text_.text = var_25_17

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_19 = 17 <= 0 and var_25_15 or var_25_15 * (utf8.len(var_25_17) / 17)

				if (17 <= 0 and var_25_15 or var_25_15 * (utf8.len(var_25_17) / 17)) > 0 and var_25_15 < var_25_19 then
					arg_22_1.talkMaxDuration = var_25_19

					if var_25_19 + var_25_14 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_19 + var_25_14
					end
				end

				arg_22_1.text_.text = var_25_17
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242005", "story_v_out_417242.awb") ~= 0 then
					local var_25_20 = manager.audio:GetVoiceLength("story_v_out_417242", "417242005", "story_v_out_417242.awb") / 1000

					if var_25_20 + var_25_14 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_20 + var_25_14
					end

					if var_25_16.prefab_name ~= "" and arg_22_1.actors_[var_25_16.prefab_name] ~= nil then
						local var_25_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_16.prefab_name].transform, "story_v_out_417242", "417242005", "story_v_out_417242.awb")

						arg_22_1:RecordAudio("417242005", var_25_21)
						arg_22_1:RecordAudio("417242005", var_25_21)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_417242", "417242005", "story_v_out_417242.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_417242", "417242005", "story_v_out_417242.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_22 = math.max(var_25_15, arg_22_1.talkMaxDuration)

			if var_25_14 <= arg_22_1.time_ and arg_22_1.time_ < var_25_14 + var_25_22 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_14) / var_25_22

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_14 + var_25_22 and arg_22_1.time_ < var_25_14 + var_25_22 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play417242006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 417242006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play417242007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.var_.moveOldPos10115 = arg_26_1.actors_["10115"].transform.localPosition
				arg_26_1.actors_["10115"].transform.localScale = Vector3.New(1, 1, 1)

				arg_26_1:CheckSpriteTmpPos("10115", 7)

				for iter_29_0 = 0, arg_26_1.actors_["10115"].transform.childCount - 1 do
					local var_29_0 = arg_26_1.actors_["10115"].transform:GetChild(iter_29_0)

					if var_29_0.name == "" or not string.find(var_29_0.name, "split") then
						var_29_0.gameObject:SetActive(true)
					else
						var_29_0.gameObject:SetActive(false)
					end
				end
			end

			local var_29_1 = 0.001

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_1 then
				arg_26_1.actors_["10115"].transform.localPosition = Vector3.Lerp(arg_26_1.var_.moveOldPos10115, Vector3.New(0, -2000, 0), (arg_26_1.time_ - 0) / var_29_1)
			end

			if arg_26_1.time_ >= 0 + var_29_1 and arg_26_1.time_ < 0 + var_29_1 + arg_29_0 then
				arg_26_1.actors_["10115"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_29_2 = 0
			local var_29_3 = 1.15

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_2 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, false)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_4 = arg_26_1:FormatText(arg_26_1:GetWordFromCfg(417242006).content)

				arg_26_1.text_.text = var_29_4

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_6 = 46 <= 0 and var_29_3 or var_29_3 * (utf8.len(var_29_4) / 46)

				if (46 <= 0 and var_29_3 or var_29_3 * (utf8.len(var_29_4) / 46)) > 0 and var_29_3 < var_29_6 then
					arg_26_1.talkMaxDuration = var_29_6

					if var_29_6 + var_29_2 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_6 + var_29_2
					end
				end

				arg_26_1.text_.text = var_29_4
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_3, arg_26_1.talkMaxDuration)

			if var_29_2 <= arg_26_1.time_ and arg_26_1.time_ < var_29_2 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_2) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_2 + var_29_7 and arg_26_1.time_ < var_29_2 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_26_1:InitPlayNodeList()
	end,
	Play417242007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 417242007
		arg_30_1.duration_ = 2.2

		local var_30_0 = {
			zh = 1.166,
			ja = 2.2
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play417242008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["10128"]) and arg_30_1.var_.actorSpriteComps10128 == nil then
				arg_30_1.var_.actorSpriteComps10128 = arg_30_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_33_0 = 0.2

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["10128"]) then
				if arg_30_1.var_.actorSpriteComps10128 then
					for iter_33_0, iter_33_1 in pairs(arg_30_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_33_1 then
							if arg_30_1.isInRecall_ then
								iter_33_1.color = Color.New(Mathf.Lerp(iter_33_1.color.r, arg_30_1.hightColor1.r, (arg_30_1.time_ - 0) / var_33_0), Mathf.Lerp(iter_33_1.color.g, arg_30_1.hightColor1.g, (arg_30_1.time_ - 0) / var_33_0), (Mathf.Lerp(iter_33_1.color.b, arg_30_1.hightColor1.b, (arg_30_1.time_ - 0) / var_33_0)))
							else
								local var_33_1 = Mathf.Lerp(iter_33_1.color.r, 1, (arg_30_1.time_ - 0) / var_33_0)

								iter_33_1.color = Color.New(var_33_1, var_33_1, var_33_1)
							end
						end
					end
				end
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["10128"]) and arg_30_1.var_.actorSpriteComps10128 then
				for iter_33_2, iter_33_3 in pairs(arg_30_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_33_3 then
						iter_33_3.color = arg_30_1.isInRecall_ and (arg_30_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_30_1.var_.actorSpriteComps10128 = nil
			end

			local var_33_2 = arg_30_1.actors_["10128"].transform

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				arg_30_1.var_.moveOldPos10128 = var_33_2.localPosition
				var_33_2.localScale = Vector3.New(1, 1, 1)

				arg_30_1:CheckSpriteTmpPos("10128", 3)

				for iter_33_4 = 0, var_33_2.childCount - 1 do
					local var_33_3 = var_33_2:GetChild(iter_33_4)

					if var_33_3.name == "split_6" or not string.find(var_33_3.name, "split") then
						var_33_3.gameObject:SetActive(true)
					else
						var_33_3.gameObject:SetActive(false)
					end
				end
			end

			local var_33_4 = 0.001

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_4 then
				var_33_2.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos10128, Vector3.New(0, -347, -300), (arg_30_1.time_ - 0) / var_33_4)
			end

			if arg_30_1.time_ >= 0 + var_33_4 and arg_30_1.time_ < 0 + var_33_4 + arg_33_0 then
				var_33_2.localPosition = Vector3.New(0, -347, -300)
			end

			local var_33_5 = 0
			local var_33_6 = 0.2

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_5 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_7 = arg_30_1:GetWordFromCfg(417242007)
				local var_33_8 = arg_30_1:FormatText(var_33_7.content)

				arg_30_1.text_.text = var_33_8

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_10 = 8 <= 0 and var_33_6 or var_33_6 * (utf8.len(var_33_8) / 8)

				if (8 <= 0 and var_33_6 or var_33_6 * (utf8.len(var_33_8) / 8)) > 0 and var_33_6 < var_33_10 then
					arg_30_1.talkMaxDuration = var_33_10

					if var_33_10 + var_33_5 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_10 + var_33_5
					end
				end

				arg_30_1.text_.text = var_33_8
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242007", "story_v_out_417242.awb") ~= 0 then
					local var_33_11 = manager.audio:GetVoiceLength("story_v_out_417242", "417242007", "story_v_out_417242.awb") / 1000

					if var_33_11 + var_33_5 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_11 + var_33_5
					end

					if var_33_7.prefab_name ~= "" and arg_30_1.actors_[var_33_7.prefab_name] ~= nil then
						local var_33_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_7.prefab_name].transform, "story_v_out_417242", "417242007", "story_v_out_417242.awb")

						arg_30_1:RecordAudio("417242007", var_33_12)
						arg_30_1:RecordAudio("417242007", var_33_12)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_417242", "417242007", "story_v_out_417242.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_417242", "417242007", "story_v_out_417242.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_13 = math.max(var_33_6, arg_30_1.talkMaxDuration)

			if var_33_5 <= arg_30_1.time_ and arg_30_1.time_ < var_33_5 + var_33_13 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_5) / var_33_13

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_5 + var_33_13 and arg_30_1.time_ < var_33_5 + var_33_13 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play417242008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 417242008
		arg_34_1.duration_ = 3.07

		local var_34_0 = {
			zh = 1.433,
			ja = 3.066
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play417242009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(arg_34_1.actors_["1034"]) and arg_34_1.var_.actorSpriteComps1034 == nil then
				arg_34_1.var_.actorSpriteComps1034 = arg_34_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_0 = 0.2

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 and not isNil(arg_34_1.actors_["1034"]) then
				if arg_34_1.var_.actorSpriteComps1034 then
					for iter_37_0, iter_37_1 in pairs(arg_34_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_37_1 then
							if arg_34_1.isInRecall_ then
								iter_37_1.color = Color.New(Mathf.Lerp(iter_37_1.color.r, arg_34_1.hightColor1.r, (arg_34_1.time_ - 0) / var_37_0), Mathf.Lerp(iter_37_1.color.g, arg_34_1.hightColor1.g, (arg_34_1.time_ - 0) / var_37_0), (Mathf.Lerp(iter_37_1.color.b, arg_34_1.hightColor1.b, (arg_34_1.time_ - 0) / var_37_0)))
							else
								local var_37_1 = Mathf.Lerp(iter_37_1.color.r, 1, (arg_34_1.time_ - 0) / var_37_0)

								iter_37_1.color = Color.New(var_37_1, var_37_1, var_37_1)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["1034"]) and arg_34_1.var_.actorSpriteComps1034 then
				for iter_37_2, iter_37_3 in pairs(arg_34_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_37_3 then
						iter_37_3.color = arg_34_1.isInRecall_ and (arg_34_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_34_1.var_.actorSpriteComps1034 = nil
			end

			local var_37_2 = arg_34_1.actors_["10128"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_2) and arg_34_1.var_.actorSpriteComps10128 == nil then
				arg_34_1.var_.actorSpriteComps10128 = var_37_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_37_3 = 0.2

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_3 and not isNil(var_37_2) then
				if arg_34_1.var_.actorSpriteComps10128 then
					for iter_37_4, iter_37_5 in pairs(arg_34_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_37_5 then
							if arg_34_1.isInRecall_ then
								iter_37_5.color = Color.New(Mathf.Lerp(iter_37_5.color.r, arg_34_1.hightColor2.r, (arg_34_1.time_ - 0) / var_37_3), Mathf.Lerp(iter_37_5.color.g, arg_34_1.hightColor2.g, (arg_34_1.time_ - 0) / var_37_3), (Mathf.Lerp(iter_37_5.color.b, arg_34_1.hightColor2.b, (arg_34_1.time_ - 0) / var_37_3)))
							else
								local var_37_4 = Mathf.Lerp(iter_37_5.color.r, 0.5, (arg_34_1.time_ - 0) / var_37_3)

								iter_37_5.color = Color.New(var_37_4, var_37_4, var_37_4)
							end
						end
					end
				end
			end

			if arg_34_1.time_ >= 0 + var_37_3 and arg_34_1.time_ < 0 + var_37_3 + arg_37_0 and not isNil(var_37_2) and arg_34_1.var_.actorSpriteComps10128 then
				for iter_37_6, iter_37_7 in pairs(arg_34_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_37_7 then
						iter_37_7.color = arg_34_1.isInRecall_ and (arg_34_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_34_1.var_.actorSpriteComps10128 = nil
			end

			local var_37_5 = arg_34_1.actors_["1034"].transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos1034 = var_37_5.localPosition
				var_37_5.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("1034", 3)

				for iter_37_8 = 0, var_37_5.childCount - 1 do
					local var_37_6 = var_37_5:GetChild(iter_37_8)

					if var_37_6.name == "split_1" or not string.find(var_37_6.name, "split") then
						var_37_6.gameObject:SetActive(true)
					else
						var_37_6.gameObject:SetActive(false)
					end
				end
			end

			local var_37_7 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_7 then
				var_37_5.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_34_1.time_ - 0) / var_37_7)
			end

			if arg_34_1.time_ >= 0 + var_37_7 and arg_34_1.time_ < 0 + var_37_7 + arg_37_0 then
				var_37_5.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_37_8 = arg_34_1.actors_["10128"].transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos10128 = var_37_8.localPosition
				var_37_8.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("10128", 7)

				for iter_37_9 = 0, var_37_8.childCount - 1 do
					local var_37_9 = var_37_8:GetChild(iter_37_9)

					if var_37_9.name == "" or not string.find(var_37_9.name, "split") then
						var_37_9.gameObject:SetActive(true)
					else
						var_37_9.gameObject:SetActive(false)
					end
				end
			end

			local var_37_10 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_10 then
				var_37_8.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_34_1.time_ - 0) / var_37_10)
			end

			if arg_34_1.time_ >= 0 + var_37_10 and arg_34_1.time_ < 0 + var_37_10 + arg_37_0 then
				var_37_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_37_11 = 0
			local var_37_12 = 0.175

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_11 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_13 = arg_34_1:GetWordFromCfg(417242008)
				local var_37_14 = arg_34_1:FormatText(var_37_13.content)

				arg_34_1.text_.text = var_37_14

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_16 = 7 <= 0 and var_37_12 or var_37_12 * (utf8.len(var_37_14) / 7)

				if (7 <= 0 and var_37_12 or var_37_12 * (utf8.len(var_37_14) / 7)) > 0 and var_37_12 < var_37_16 then
					arg_34_1.talkMaxDuration = var_37_16

					if var_37_16 + var_37_11 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_16 + var_37_11
					end
				end

				arg_34_1.text_.text = var_37_14
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242008", "story_v_out_417242.awb") ~= 0 then
					local var_37_17 = manager.audio:GetVoiceLength("story_v_out_417242", "417242008", "story_v_out_417242.awb") / 1000

					if var_37_17 + var_37_11 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_17 + var_37_11
					end

					if var_37_13.prefab_name ~= "" and arg_34_1.actors_[var_37_13.prefab_name] ~= nil then
						local var_37_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_13.prefab_name].transform, "story_v_out_417242", "417242008", "story_v_out_417242.awb")

						arg_34_1:RecordAudio("417242008", var_37_18)
						arg_34_1:RecordAudio("417242008", var_37_18)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_417242", "417242008", "story_v_out_417242.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_417242", "417242008", "story_v_out_417242.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_19 = math.max(var_37_12, arg_34_1.talkMaxDuration)

			if var_37_11 <= arg_34_1.time_ and arg_34_1.time_ < var_37_11 + var_37_19 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_11) / var_37_19

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_11 + var_37_19 and arg_34_1.time_ < var_37_11 + var_37_19 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_34_1:InitPlayNodeList()
	end,
	Play417242009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 417242009
		arg_38_1.duration_ = 2.67

		local var_38_0 = {
			zh = 1.4,
			ja = 2.666
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play417242010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["10128"]) and arg_38_1.var_.actorSpriteComps10128 == nil then
				arg_38_1.var_.actorSpriteComps10128 = arg_38_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_0 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["10128"]) then
				if arg_38_1.var_.actorSpriteComps10128 then
					for iter_41_0, iter_41_1 in pairs(arg_38_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_41_1 then
							if arg_38_1.isInRecall_ then
								iter_41_1.color = Color.New(Mathf.Lerp(iter_41_1.color.r, arg_38_1.hightColor1.r, (arg_38_1.time_ - 0) / var_41_0), Mathf.Lerp(iter_41_1.color.g, arg_38_1.hightColor1.g, (arg_38_1.time_ - 0) / var_41_0), (Mathf.Lerp(iter_41_1.color.b, arg_38_1.hightColor1.b, (arg_38_1.time_ - 0) / var_41_0)))
							else
								local var_41_1 = Mathf.Lerp(iter_41_1.color.r, 1, (arg_38_1.time_ - 0) / var_41_0)

								iter_41_1.color = Color.New(var_41_1, var_41_1, var_41_1)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["10128"]) and arg_38_1.var_.actorSpriteComps10128 then
				for iter_41_2, iter_41_3 in pairs(arg_38_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_41_3 then
						iter_41_3.color = arg_38_1.isInRecall_ and (arg_38_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_38_1.var_.actorSpriteComps10128 = nil
			end

			local var_41_2 = arg_38_1.actors_["1034"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.actorSpriteComps1034 == nil then
				arg_38_1.var_.actorSpriteComps1034 = var_41_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_41_3 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_3 and not isNil(var_41_2) then
				if arg_38_1.var_.actorSpriteComps1034 then
					for iter_41_4, iter_41_5 in pairs(arg_38_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_41_5 then
							if arg_38_1.isInRecall_ then
								iter_41_5.color = Color.New(Mathf.Lerp(iter_41_5.color.r, arg_38_1.hightColor2.r, (arg_38_1.time_ - 0) / var_41_3), Mathf.Lerp(iter_41_5.color.g, arg_38_1.hightColor2.g, (arg_38_1.time_ - 0) / var_41_3), (Mathf.Lerp(iter_41_5.color.b, arg_38_1.hightColor2.b, (arg_38_1.time_ - 0) / var_41_3)))
							else
								local var_41_4 = Mathf.Lerp(iter_41_5.color.r, 0.5, (arg_38_1.time_ - 0) / var_41_3)

								iter_41_5.color = Color.New(var_41_4, var_41_4, var_41_4)
							end
						end
					end
				end
			end

			if arg_38_1.time_ >= 0 + var_41_3 and arg_38_1.time_ < 0 + var_41_3 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.actorSpriteComps1034 then
				for iter_41_6, iter_41_7 in pairs(arg_38_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_41_7 then
						iter_41_7.color = arg_38_1.isInRecall_ and (arg_38_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_38_1.var_.actorSpriteComps1034 = nil
			end

			local var_41_5 = arg_38_1.actors_["1034"].transform

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos1034 = var_41_5.localPosition
				var_41_5.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("1034", 2)

				for iter_41_8 = 0, var_41_5.childCount - 1 do
					local var_41_6 = var_41_5:GetChild(iter_41_8)

					if var_41_6.name == "" or not string.find(var_41_6.name, "split") then
						var_41_6.gameObject:SetActive(true)
					else
						var_41_6.gameObject:SetActive(false)
					end
				end
			end

			local var_41_7 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_7 then
				var_41_5.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos1034, Vector3.New(-390, -331.9, -324), (arg_38_1.time_ - 0) / var_41_7)
			end

			if arg_38_1.time_ >= 0 + var_41_7 and arg_38_1.time_ < 0 + var_41_7 + arg_41_0 then
				var_41_5.localPosition = Vector3.New(-390, -331.9, -324)
			end

			local var_41_8 = arg_38_1.actors_["10128"].transform

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos10128 = var_41_8.localPosition
				var_41_8.localScale = Vector3.New(1, 1, 1)

				arg_38_1:CheckSpriteTmpPos("10128", 4)

				for iter_41_9 = 0, var_41_8.childCount - 1 do
					local var_41_9 = var_41_8:GetChild(iter_41_9)

					if var_41_9.name == "split_2" or not string.find(var_41_9.name, "split") then
						var_41_9.gameObject:SetActive(true)
					else
						var_41_9.gameObject:SetActive(false)
					end
				end
			end

			local var_41_10 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_10 then
				var_41_8.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_38_1.time_ - 0) / var_41_10)
			end

			if arg_38_1.time_ >= 0 + var_41_10 and arg_38_1.time_ < 0 + var_41_10 + arg_41_0 then
				var_41_8.localPosition = Vector3.New(390, -347, -300)
			end

			local var_41_11 = 0
			local var_41_12 = 0.175

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_11 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_13 = arg_38_1:GetWordFromCfg(417242009)
				local var_41_14 = arg_38_1:FormatText(var_41_13.content)

				arg_38_1.text_.text = var_41_14

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_16 = 7 <= 0 and var_41_12 or var_41_12 * (utf8.len(var_41_14) / 7)

				if (7 <= 0 and var_41_12 or var_41_12 * (utf8.len(var_41_14) / 7)) > 0 and var_41_12 < var_41_16 then
					arg_38_1.talkMaxDuration = var_41_16

					if var_41_16 + var_41_11 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_16 + var_41_11
					end
				end

				arg_38_1.text_.text = var_41_14
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242009", "story_v_out_417242.awb") ~= 0 then
					local var_41_17 = manager.audio:GetVoiceLength("story_v_out_417242", "417242009", "story_v_out_417242.awb") / 1000

					if var_41_17 + var_41_11 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_17 + var_41_11
					end

					if var_41_13.prefab_name ~= "" and arg_38_1.actors_[var_41_13.prefab_name] ~= nil then
						local var_41_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_13.prefab_name].transform, "story_v_out_417242", "417242009", "story_v_out_417242.awb")

						arg_38_1:RecordAudio("417242009", var_41_18)
						arg_38_1:RecordAudio("417242009", var_41_18)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_417242", "417242009", "story_v_out_417242.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_417242", "417242009", "story_v_out_417242.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_19 = math.max(var_41_12, arg_38_1.talkMaxDuration)

			if var_41_11 <= arg_38_1.time_ and arg_38_1.time_ < var_41_11 + var_41_19 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_11) / var_41_19

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_11 + var_41_19 and arg_38_1.time_ < var_41_11 + var_41_19 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_38_1:InitPlayNodeList()
	end,
	Play417242010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 417242010
		arg_42_1.duration_ = 3.77

		local var_42_0 = {
			zh = 3.766,
			ja = 3.6
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play417242011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["1034"]) and arg_42_1.var_.actorSpriteComps1034 == nil then
				arg_42_1.var_.actorSpriteComps1034 = arg_42_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_0 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["1034"]) then
				if arg_42_1.var_.actorSpriteComps1034 then
					for iter_45_0, iter_45_1 in pairs(arg_42_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_45_1 then
							if arg_42_1.isInRecall_ then
								iter_45_1.color = Color.New(Mathf.Lerp(iter_45_1.color.r, arg_42_1.hightColor1.r, (arg_42_1.time_ - 0) / var_45_0), Mathf.Lerp(iter_45_1.color.g, arg_42_1.hightColor1.g, (arg_42_1.time_ - 0) / var_45_0), (Mathf.Lerp(iter_45_1.color.b, arg_42_1.hightColor1.b, (arg_42_1.time_ - 0) / var_45_0)))
							else
								local var_45_1 = Mathf.Lerp(iter_45_1.color.r, 1, (arg_42_1.time_ - 0) / var_45_0)

								iter_45_1.color = Color.New(var_45_1, var_45_1, var_45_1)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["1034"]) and arg_42_1.var_.actorSpriteComps1034 then
				for iter_45_2, iter_45_3 in pairs(arg_42_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_45_3 then
						iter_45_3.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_42_1.var_.actorSpriteComps1034 = nil
			end

			local var_45_2 = arg_42_1.actors_["10128"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.actorSpriteComps10128 == nil then
				arg_42_1.var_.actorSpriteComps10128 = var_45_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_3 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_3 and not isNil(var_45_2) then
				if arg_42_1.var_.actorSpriteComps10128 then
					for iter_45_4, iter_45_5 in pairs(arg_42_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_45_5 then
							if arg_42_1.isInRecall_ then
								iter_45_5.color = Color.New(Mathf.Lerp(iter_45_5.color.r, arg_42_1.hightColor2.r, (arg_42_1.time_ - 0) / var_45_3), Mathf.Lerp(iter_45_5.color.g, arg_42_1.hightColor2.g, (arg_42_1.time_ - 0) / var_45_3), (Mathf.Lerp(iter_45_5.color.b, arg_42_1.hightColor2.b, (arg_42_1.time_ - 0) / var_45_3)))
							else
								local var_45_4 = Mathf.Lerp(iter_45_5.color.r, 0.5, (arg_42_1.time_ - 0) / var_45_3)

								iter_45_5.color = Color.New(var_45_4, var_45_4, var_45_4)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= 0 + var_45_3 and arg_42_1.time_ < 0 + var_45_3 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.actorSpriteComps10128 then
				for iter_45_6, iter_45_7 in pairs(arg_42_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_45_7 then
						iter_45_7.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_42_1.var_.actorSpriteComps10128 = nil
			end

			local var_45_5 = arg_42_1.actors_["1034"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos1034 = var_45_5.localPosition
				var_45_5.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("1034", 3)

				for iter_45_8 = 0, var_45_5.childCount - 1 do
					local var_45_6 = var_45_5:GetChild(iter_45_8)

					if var_45_6.name == "" or not string.find(var_45_6.name, "split") then
						var_45_6.gameObject:SetActive(true)
					else
						var_45_6.gameObject:SetActive(false)
					end
				end
			end

			local var_45_7 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_7 then
				var_45_5.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_42_1.time_ - 0) / var_45_7)
			end

			if arg_42_1.time_ >= 0 + var_45_7 and arg_42_1.time_ < 0 + var_45_7 + arg_45_0 then
				var_45_5.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_45_8 = arg_42_1.actors_["10128"].transform

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos10128 = var_45_8.localPosition
				var_45_8.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("10128", 7)

				for iter_45_9 = 0, var_45_8.childCount - 1 do
					local var_45_9 = var_45_8:GetChild(iter_45_9)

					if var_45_9.name == "" or not string.find(var_45_9.name, "split") then
						var_45_9.gameObject:SetActive(true)
					else
						var_45_9.gameObject:SetActive(false)
					end
				end
			end

			local var_45_10 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_10 then
				var_45_8.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_42_1.time_ - 0) / var_45_10)
			end

			if arg_42_1.time_ >= 0 + var_45_10 and arg_42_1.time_ < 0 + var_45_10 + arg_45_0 then
				var_45_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_45_11 = 0
			local var_45_12 = 0.5

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_11 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_13 = arg_42_1:GetWordFromCfg(417242010)
				local var_45_14 = arg_42_1:FormatText(var_45_13.content)

				arg_42_1.text_.text = var_45_14

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_16 = 20 <= 0 and var_45_12 or var_45_12 * (utf8.len(var_45_14) / 20)

				if (20 <= 0 and var_45_12 or var_45_12 * (utf8.len(var_45_14) / 20)) > 0 and var_45_12 < var_45_16 then
					arg_42_1.talkMaxDuration = var_45_16

					if var_45_16 + var_45_11 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_16 + var_45_11
					end
				end

				arg_42_1.text_.text = var_45_14
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242010", "story_v_out_417242.awb") ~= 0 then
					local var_45_17 = manager.audio:GetVoiceLength("story_v_out_417242", "417242010", "story_v_out_417242.awb") / 1000

					if var_45_17 + var_45_11 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_17 + var_45_11
					end

					if var_45_13.prefab_name ~= "" and arg_42_1.actors_[var_45_13.prefab_name] ~= nil then
						local var_45_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_13.prefab_name].transform, "story_v_out_417242", "417242010", "story_v_out_417242.awb")

						arg_42_1:RecordAudio("417242010", var_45_18)
						arg_42_1:RecordAudio("417242010", var_45_18)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_417242", "417242010", "story_v_out_417242.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_417242", "417242010", "story_v_out_417242.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_19 = math.max(var_45_12, arg_42_1.talkMaxDuration)

			if var_45_11 <= arg_42_1.time_ and arg_42_1.time_ < var_45_11 + var_45_19 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_11) / var_45_19

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_11 + var_45_19 and arg_42_1.time_ < var_45_11 + var_45_19 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play417242011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 417242011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play417242012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["1034"]) and arg_46_1.var_.actorSpriteComps1034 == nil then
				arg_46_1.var_.actorSpriteComps1034 = arg_46_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_0 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["1034"]) then
				if arg_46_1.var_.actorSpriteComps1034 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_49_1 then
							if arg_46_1.isInRecall_ then
								iter_49_1.color = Color.New(Mathf.Lerp(iter_49_1.color.r, arg_46_1.hightColor2.r, (arg_46_1.time_ - 0) / var_49_0), Mathf.Lerp(iter_49_1.color.g, arg_46_1.hightColor2.g, (arg_46_1.time_ - 0) / var_49_0), (Mathf.Lerp(iter_49_1.color.b, arg_46_1.hightColor2.b, (arg_46_1.time_ - 0) / var_49_0)))
							else
								local var_49_1 = Mathf.Lerp(iter_49_1.color.r, 0.5, (arg_46_1.time_ - 0) / var_49_0)

								iter_49_1.color = Color.New(var_49_1, var_49_1, var_49_1)
							end
						end
					end
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["1034"]) and arg_46_1.var_.actorSpriteComps1034 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_49_3 then
						iter_49_3.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_46_1.var_.actorSpriteComps1034 = nil
			end

			local var_49_2 = arg_46_1.actors_["1034"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos1034 = var_49_2.localPosition
				var_49_2.localScale = Vector3.New(1, 1, 1)

				arg_46_1:CheckSpriteTmpPos("1034", 7)

				for iter_49_4 = 0, var_49_2.childCount - 1 do
					local var_49_3 = var_49_2:GetChild(iter_49_4)

					if var_49_3.name == "" or not string.find(var_49_3.name, "split") then
						var_49_3.gameObject:SetActive(true)
					else
						var_49_3.gameObject:SetActive(false)
					end
				end
			end

			local var_49_4 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_4 then
				var_49_2.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_46_1.time_ - 0) / var_49_4)
			end

			if arg_46_1.time_ >= 0 + var_49_4 and arg_46_1.time_ < 0 + var_49_4 + arg_49_0 then
				var_49_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_49_5 = 0
			local var_49_6 = 1.625

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_5 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_7 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(417242011).content)

				arg_46_1.text_.text = var_49_7

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_9 = 65 <= 0 and var_49_6 or var_49_6 * (utf8.len(var_49_7) / 65)

				if (65 <= 0 and var_49_6 or var_49_6 * (utf8.len(var_49_7) / 65)) > 0 and var_49_6 < var_49_9 then
					arg_46_1.talkMaxDuration = var_49_9

					if var_49_9 + var_49_5 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_9 + var_49_5
					end
				end

				arg_46_1.text_.text = var_49_7
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_10 = math.max(var_49_6, arg_46_1.talkMaxDuration)

			if var_49_5 <= arg_46_1.time_ and arg_46_1.time_ < var_49_5 + var_49_10 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_5) / var_49_10

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_5 + var_49_10 and arg_46_1.time_ < var_49_5 + var_49_10 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play417242012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 417242012
		arg_50_1.duration_ = 8.67

		local var_50_0 = {
			zh = 7.366,
			ja = 8.666
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play417242013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 4 < arg_50_1.time_ and arg_50_1.time_ <= 4 + arg_53_0 then
				arg_50_1.allBtn_.enabled = false
			end

			if arg_50_1.time_ >= 4 + 0.133333333333333 and arg_50_1.time_ < 4 + 0.133333333333333 + arg_53_0 then
				arg_50_1.allBtn_.enabled = true
			end

			local var_53_0 = "ST73"

			if arg_50_1.bgs_.ST73 == nil then
				local var_53_1 = Object.Instantiate(arg_50_1.paintGo_)

				var_53_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_53_0)
				var_53_1.name = var_53_0
				var_53_1.transform.parent = arg_50_1.stage_.transform
				var_53_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_50_1.bgs_[var_53_0] = var_53_1
			end

			if 2 < arg_50_1.time_ and arg_50_1.time_ <= 2 + arg_53_0 then
				local var_53_2 = arg_50_1.bgs_.ST73

				arg_50_1.bgs_.ST73.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_53_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_53_3 = var_53_2:GetComponent("SpriteRenderer")

				if var_53_3 and var_53_3.sprite then
					local var_53_4 = 2 * (var_53_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_53_2.transform.localScale = Vector3.New(var_53_4 / var_53_3.sprite.bounds.size.y < var_53_4 * manager.ui.mainCameraCom_.aspect / var_53_3.sprite.bounds.size.x and var_53_4 * manager.ui.mainCameraCom_.aspect / var_53_3.sprite.bounds.size.x or var_53_4 / var_53_3.sprite.bounds.size.y, var_53_4 / var_53_3.sprite.bounds.size.y < var_53_4 * manager.ui.mainCameraCom_.aspect / var_53_3.sprite.bounds.size.x and var_53_4 * manager.ui.mainCameraCom_.aspect / var_53_3.sprite.bounds.size.x or var_53_4 / var_53_3.sprite.bounds.size.y, 0)
				end

				for iter_53_0, iter_53_1 in pairs(arg_50_1.bgs_) do
					if iter_53_0 ~= "ST73" then
						iter_53_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_53_5 = 0

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1.mask_.enabled = true
				arg_50_1.mask_.raycastTarget = true

				arg_50_1:SetGaussion(false)
			end

			local var_53_6 = 2

			if var_53_5 <= arg_50_1.time_ and arg_50_1.time_ < var_53_5 + var_53_6 then
				local var_53_7 = Color.New(0, 0, 0)

				var_53_7.a = Mathf.Lerp(0, 1, (arg_50_1.time_ - var_53_5) / var_53_6)
				arg_50_1.mask_.color = var_53_7
			end

			if arg_50_1.time_ >= var_53_5 + var_53_6 and arg_50_1.time_ < var_53_5 + var_53_6 + arg_53_0 then
				local var_53_8 = Color.New(0, 0, 0)

				var_53_8.a = 1
				arg_50_1.mask_.color = var_53_8
			end

			local var_53_9 = 2

			if 2 < arg_50_1.time_ and arg_50_1.time_ <= var_53_9 + arg_53_0 then
				arg_50_1.mask_.enabled = true
				arg_50_1.mask_.raycastTarget = true

				arg_50_1:SetGaussion(false)
			end

			local var_53_10 = 2

			if var_53_9 <= arg_50_1.time_ and arg_50_1.time_ < var_53_9 + var_53_10 then
				local var_53_11 = Color.New(0, 0, 0)

				var_53_11.a = Mathf.Lerp(1, 0, (arg_50_1.time_ - var_53_9) / var_53_10)
				arg_50_1.mask_.color = var_53_11
			end

			if arg_50_1.time_ >= var_53_9 + var_53_10 and arg_50_1.time_ < var_53_9 + var_53_10 + arg_53_0 then
				local var_53_12 = Color.New(0, 0, 0)

				arg_50_1.mask_.enabled = false
				var_53_12.a = 0
				arg_50_1.mask_.color = var_53_12
			end

			local var_53_13 = arg_50_1.actors_["10115"]

			if 3.7 < arg_50_1.time_ and arg_50_1.time_ <= 3.7 + arg_53_0 and not isNil(var_53_13) and arg_50_1.var_.actorSpriteComps10115 == nil then
				arg_50_1.var_.actorSpriteComps10115 = var_53_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_53_14 = 0.2

			if 3.7 <= arg_50_1.time_ and arg_50_1.time_ < 3.7 + var_53_14 and not isNil(var_53_13) then
				if arg_50_1.var_.actorSpriteComps10115 then
					for iter_53_2, iter_53_3 in pairs(arg_50_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_53_3 then
							if arg_50_1.isInRecall_ then
								iter_53_3.color = Color.New(Mathf.Lerp(iter_53_3.color.r, arg_50_1.hightColor1.r, (arg_50_1.time_ - 3.7) / var_53_14), Mathf.Lerp(iter_53_3.color.g, arg_50_1.hightColor1.g, (arg_50_1.time_ - 3.7) / var_53_14), (Mathf.Lerp(iter_53_3.color.b, arg_50_1.hightColor1.b, (arg_50_1.time_ - 3.7) / var_53_14)))
							else
								local var_53_15 = Mathf.Lerp(iter_53_3.color.r, 1, (arg_50_1.time_ - 3.7) / var_53_14)

								iter_53_3.color = Color.New(var_53_15, var_53_15, var_53_15)
							end
						end
					end
				end
			end

			if arg_50_1.time_ >= 3.7 + var_53_14 and arg_50_1.time_ < 3.7 + var_53_14 + arg_53_0 and not isNil(var_53_13) and arg_50_1.var_.actorSpriteComps10115 then
				for iter_53_4, iter_53_5 in pairs(arg_50_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_53_5 then
						iter_53_5.color = arg_50_1.isInRecall_ and (arg_50_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_50_1.var_.actorSpriteComps10115 = nil
			end

			local var_53_16 = arg_50_1.actors_["10115"].transform

			if 3.7 < arg_50_1.time_ and arg_50_1.time_ <= 3.7 + arg_53_0 then
				arg_50_1.var_.moveOldPos10115 = var_53_16.localPosition
				var_53_16.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("10115", 3)

				for iter_53_6 = 0, var_53_16.childCount - 1 do
					local var_53_17 = var_53_16:GetChild(iter_53_6)

					if var_53_17.name == "split_2" or not string.find(var_53_17.name, "split") then
						var_53_17.gameObject:SetActive(true)
					else
						var_53_17.gameObject:SetActive(false)
					end
				end
			end

			local var_53_18 = 0.001

			if 3.7 <= arg_50_1.time_ and arg_50_1.time_ < 3.7 + var_53_18 then
				var_53_16.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10115, Vector3.New(0, -387.3, -246.2), (arg_50_1.time_ - 3.7) / var_53_18)
			end

			if arg_50_1.time_ >= 3.7 + var_53_18 and arg_50_1.time_ < 3.7 + var_53_18 + arg_53_0 then
				var_53_16.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			if 3.7 < arg_50_1.time_ and arg_50_1.time_ <= 3.7 + arg_53_0 then
				local var_53_19 = arg_50_1.actors_["10115"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_53_19 then
					arg_50_1.var_.alphaOldValue10115 = var_53_19.alpha
					arg_50_1.var_.characterEffect10115 = var_53_19
				end

				arg_50_1.var_.alphaOldValue10115 = 0
			end

			local var_53_20 = 0.3

			if 3.7 <= arg_50_1.time_ and arg_50_1.time_ < 3.7 + var_53_20 then
				if arg_50_1.var_.characterEffect10115 then
					arg_50_1.var_.characterEffect10115.alpha = Mathf.Lerp(arg_50_1.var_.alphaOldValue10115, 1, (arg_50_1.time_ - 3.7) / var_53_20)
				end
			end

			if arg_50_1.time_ >= 3.7 + var_53_20 and arg_50_1.time_ < 3.7 + var_53_20 + arg_53_0 and arg_50_1.var_.characterEffect10115 then
				arg_50_1.var_.characterEffect10115.alpha = 1
			end

			if 1.43333333333333 < arg_50_1.time_ and arg_50_1.time_ <= 1.43333333333333 + arg_53_0 then
				arg_50_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if arg_50_1.frameCnt_ <= 1 then
				arg_50_1.dialog_:SetActive(false)
			end

			local var_53_22 = 4
			local var_53_23 = 0.3

			if 4 < arg_50_1.time_ and arg_50_1.time_ <= var_53_22 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0

				arg_50_1.dialog_:SetActive(true)

				arg_50_1.dialogCg_.alpha = 0

				local var_53_24 = LeanTween.value(arg_50_1.dialog_, 0, 1, 0.3)

				var_53_24:setOnUpdate(LuaHelper.FloatAction(function(arg_54_0)
					arg_50_1.dialogCg_.alpha = arg_54_0
				end))
				var_53_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_50_1.dialog_)
					var_53_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_50_1.duration_ = arg_50_1.duration_ + 0.3

				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_25 = arg_50_1:GetWordFromCfg(417242012)
				local var_53_26 = arg_50_1:FormatText(var_53_25.content)

				arg_50_1.text_.text = var_53_26

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_28 = 12 <= 0 and var_53_23 or var_53_23 * (utf8.len(var_53_26) / 12)

				if (12 <= 0 and var_53_23 or var_53_23 * (utf8.len(var_53_26) / 12)) > 0 and var_53_23 < var_53_28 then
					arg_50_1.talkMaxDuration = var_53_28
					var_53_22 = var_53_22 + 0.3

					if var_53_28 + var_53_22 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_28 + var_53_22
					end
				end

				arg_50_1.text_.text = var_53_26
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242012", "story_v_out_417242.awb") ~= 0 then
					local var_53_29 = manager.audio:GetVoiceLength("story_v_out_417242", "417242012", "story_v_out_417242.awb") / 1000

					if var_53_29 + var_53_22 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_29 + var_53_22
					end

					if var_53_25.prefab_name ~= "" and arg_50_1.actors_[var_53_25.prefab_name] ~= nil then
						local var_53_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_25.prefab_name].transform, "story_v_out_417242", "417242012", "story_v_out_417242.awb")

						arg_50_1:RecordAudio("417242012", var_53_30)
						arg_50_1:RecordAudio("417242012", var_53_30)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_417242", "417242012", "story_v_out_417242.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_417242", "417242012", "story_v_out_417242.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_31 = var_53_22 + 0.3
			local var_53_32 = math.max(var_53_23, arg_50_1.talkMaxDuration)

			if var_53_22 + 0.3 <= arg_50_1.time_ and arg_50_1.time_ < var_53_31 + var_53_32 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_31) / var_53_32

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_31 + var_53_32 and arg_50_1.time_ < var_53_31 + var_53_32 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.7,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play417242013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 417242013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play417242014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["10115"]) and arg_56_1.var_.actorSpriteComps10115 == nil then
				arg_56_1.var_.actorSpriteComps10115 = arg_56_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_0 = 0.2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["10115"]) then
				if arg_56_1.var_.actorSpriteComps10115 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_59_1 then
							if arg_56_1.isInRecall_ then
								iter_59_1.color = Color.New(Mathf.Lerp(iter_59_1.color.r, arg_56_1.hightColor2.r, (arg_56_1.time_ - 0) / var_59_0), Mathf.Lerp(iter_59_1.color.g, arg_56_1.hightColor2.g, (arg_56_1.time_ - 0) / var_59_0), (Mathf.Lerp(iter_59_1.color.b, arg_56_1.hightColor2.b, (arg_56_1.time_ - 0) / var_59_0)))
							else
								local var_59_1 = Mathf.Lerp(iter_59_1.color.r, 0.5, (arg_56_1.time_ - 0) / var_59_0)

								iter_59_1.color = Color.New(var_59_1, var_59_1, var_59_1)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["10115"]) and arg_56_1.var_.actorSpriteComps10115 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_59_3 then
						iter_59_3.color = arg_56_1.isInRecall_ and (arg_56_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_56_1.var_.actorSpriteComps10115 = nil
			end

			local var_59_2 = arg_56_1.actors_["10115"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos10115 = var_59_2.localPosition
				var_59_2.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("10115", 7)

				for iter_59_4 = 0, var_59_2.childCount - 1 do
					local var_59_3 = var_59_2:GetChild(iter_59_4)

					if var_59_3.name == "" or not string.find(var_59_3.name, "split") then
						var_59_3.gameObject:SetActive(true)
					else
						var_59_3.gameObject:SetActive(false)
					end
				end
			end

			local var_59_4 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				var_59_2.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10115, Vector3.New(0, -2000, 0), (arg_56_1.time_ - 0) / var_59_4)
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				var_59_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_59_5 = 0
			local var_59_6 = 1.475

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_7 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(417242013).content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 59 <= 0 and var_59_6 or var_59_6 * (utf8.len(var_59_7) / 59)

				if (59 <= 0 and var_59_6 or var_59_6 * (utf8.len(var_59_7) / 59)) > 0 and var_59_6 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_5 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_5
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_6, arg_56_1.talkMaxDuration)

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_5) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_5 + var_59_10 and arg_56_1.time_ < var_59_5 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play417242014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 417242014
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play417242015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 1.45

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, false)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_1 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(417242014).content)

				arg_60_1.text_.text = var_63_1

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_3 = 58 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 58)

				if (58 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_1) / 58)) > 0 and var_63_0 < var_63_3 then
					arg_60_1.talkMaxDuration = var_63_3

					if var_63_3 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_3 + 0
					end
				end

				arg_60_1.text_.text = var_63_1
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_4 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_4

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play417242015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 417242015
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play417242016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0.533333333333333 < arg_64_1.time_ and arg_64_1.time_ <= 0.533333333333333 + arg_67_0 then
				arg_64_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_bag", "")
			end

			local var_67_1 = 0
			local var_67_2 = 1.025

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, false)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_3 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(417242015).content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 41 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 41)

				if (41 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 41)) > 0 and var_67_2 < var_67_5 then
					arg_64_1.talkMaxDuration = var_67_5

					if var_67_5 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_6 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_6 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_6

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_6 and arg_64_1.time_ < var_67_1 + var_67_6 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play417242016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 417242016
		arg_68_1.duration_ = 4.57

		local var_68_0 = {
			zh = 4.066,
			ja = 4.566
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play417242017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["10115"]) and arg_68_1.var_.actorSpriteComps10115 == nil then
				arg_68_1.var_.actorSpriteComps10115 = arg_68_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_0 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["10115"]) then
				if arg_68_1.var_.actorSpriteComps10115 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_71_1 then
							if arg_68_1.isInRecall_ then
								iter_71_1.color = Color.New(Mathf.Lerp(iter_71_1.color.r, arg_68_1.hightColor1.r, (arg_68_1.time_ - 0) / var_71_0), Mathf.Lerp(iter_71_1.color.g, arg_68_1.hightColor1.g, (arg_68_1.time_ - 0) / var_71_0), (Mathf.Lerp(iter_71_1.color.b, arg_68_1.hightColor1.b, (arg_68_1.time_ - 0) / var_71_0)))
							else
								local var_71_1 = Mathf.Lerp(iter_71_1.color.r, 1, (arg_68_1.time_ - 0) / var_71_0)

								iter_71_1.color = Color.New(var_71_1, var_71_1, var_71_1)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["10115"]) and arg_68_1.var_.actorSpriteComps10115 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_71_3 then
						iter_71_3.color = arg_68_1.isInRecall_ and (arg_68_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_68_1.var_.actorSpriteComps10115 = nil
			end

			local var_71_2 = arg_68_1.actors_["10115"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos10115 = var_71_2.localPosition
				var_71_2.localScale = Vector3.New(1, 1, 1)

				arg_68_1:CheckSpriteTmpPos("10115", 3)

				for iter_71_4 = 0, var_71_2.childCount - 1 do
					local var_71_3 = var_71_2:GetChild(iter_71_4)

					if var_71_3.name == "split_6" or not string.find(var_71_3.name, "split") then
						var_71_3.gameObject:SetActive(true)
					else
						var_71_3.gameObject:SetActive(false)
					end
				end
			end

			local var_71_4 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				var_71_2.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10115, Vector3.New(0, -387.3, -246.2), (arg_68_1.time_ - 0) / var_71_4)
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				var_71_2.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_71_5 = 0
			local var_71_6 = 0.525

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_7 = arg_68_1:GetWordFromCfg(417242016)
				local var_71_8 = arg_68_1:FormatText(var_71_7.content)

				arg_68_1.text_.text = var_71_8

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_10 = 21 <= 0 and var_71_6 or var_71_6 * (utf8.len(var_71_8) / 21)

				if (21 <= 0 and var_71_6 or var_71_6 * (utf8.len(var_71_8) / 21)) > 0 and var_71_6 < var_71_10 then
					arg_68_1.talkMaxDuration = var_71_10

					if var_71_10 + var_71_5 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_5
					end
				end

				arg_68_1.text_.text = var_71_8
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242016", "story_v_out_417242.awb") ~= 0 then
					local var_71_11 = manager.audio:GetVoiceLength("story_v_out_417242", "417242016", "story_v_out_417242.awb") / 1000

					if var_71_11 + var_71_5 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_11 + var_71_5
					end

					if var_71_7.prefab_name ~= "" and arg_68_1.actors_[var_71_7.prefab_name] ~= nil then
						local var_71_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_7.prefab_name].transform, "story_v_out_417242", "417242016", "story_v_out_417242.awb")

						arg_68_1:RecordAudio("417242016", var_71_12)
						arg_68_1:RecordAudio("417242016", var_71_12)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_417242", "417242016", "story_v_out_417242.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_417242", "417242016", "story_v_out_417242.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_13 = math.max(var_71_6, arg_68_1.talkMaxDuration)

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_13 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_5) / var_71_13

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_5 + var_71_13 and arg_68_1.time_ < var_71_5 + var_71_13 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play417242017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 417242017
		arg_72_1.duration_ = 4.33

		local var_72_0 = {
			zh = 3.733,
			ja = 4.333
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play417242018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["10128"]) and arg_72_1.var_.actorSpriteComps10128 == nil then
				arg_72_1.var_.actorSpriteComps10128 = arg_72_1.actors_["10128"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_0 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["10128"]) then
				if arg_72_1.var_.actorSpriteComps10128 then
					for iter_75_0, iter_75_1 in pairs(arg_72_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_75_1 then
							if arg_72_1.isInRecall_ then
								iter_75_1.color = Color.New(Mathf.Lerp(iter_75_1.color.r, arg_72_1.hightColor1.r, (arg_72_1.time_ - 0) / var_75_0), Mathf.Lerp(iter_75_1.color.g, arg_72_1.hightColor1.g, (arg_72_1.time_ - 0) / var_75_0), (Mathf.Lerp(iter_75_1.color.b, arg_72_1.hightColor1.b, (arg_72_1.time_ - 0) / var_75_0)))
							else
								local var_75_1 = Mathf.Lerp(iter_75_1.color.r, 1, (arg_72_1.time_ - 0) / var_75_0)

								iter_75_1.color = Color.New(var_75_1, var_75_1, var_75_1)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["10128"]) and arg_72_1.var_.actorSpriteComps10128 then
				for iter_75_2, iter_75_3 in pairs(arg_72_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_75_3 then
						iter_75_3.color = arg_72_1.isInRecall_ and (arg_72_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_72_1.var_.actorSpriteComps10128 = nil
			end

			local var_75_2 = arg_72_1.actors_["10115"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.actorSpriteComps10115 == nil then
				arg_72_1.var_.actorSpriteComps10115 = var_75_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_75_3 = 0.2

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_3 and not isNil(var_75_2) then
				if arg_72_1.var_.actorSpriteComps10115 then
					for iter_75_4, iter_75_5 in pairs(arg_72_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_75_5 then
							if arg_72_1.isInRecall_ then
								iter_75_5.color = Color.New(Mathf.Lerp(iter_75_5.color.r, arg_72_1.hightColor2.r, (arg_72_1.time_ - 0) / var_75_3), Mathf.Lerp(iter_75_5.color.g, arg_72_1.hightColor2.g, (arg_72_1.time_ - 0) / var_75_3), (Mathf.Lerp(iter_75_5.color.b, arg_72_1.hightColor2.b, (arg_72_1.time_ - 0) / var_75_3)))
							else
								local var_75_4 = Mathf.Lerp(iter_75_5.color.r, 0.5, (arg_72_1.time_ - 0) / var_75_3)

								iter_75_5.color = Color.New(var_75_4, var_75_4, var_75_4)
							end
						end
					end
				end
			end

			if arg_72_1.time_ >= 0 + var_75_3 and arg_72_1.time_ < 0 + var_75_3 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.actorSpriteComps10115 then
				for iter_75_6, iter_75_7 in pairs(arg_72_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_75_7 then
						iter_75_7.color = arg_72_1.isInRecall_ and (arg_72_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_72_1.var_.actorSpriteComps10115 = nil
			end

			local var_75_5 = arg_72_1.actors_["10128"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos10128 = var_75_5.localPosition
				var_75_5.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("10128", 4)

				for iter_75_8 = 0, var_75_5.childCount - 1 do
					local var_75_6 = var_75_5:GetChild(iter_75_8)

					if var_75_6.name == "" or not string.find(var_75_6.name, "split") then
						var_75_6.gameObject:SetActive(true)
					else
						var_75_6.gameObject:SetActive(false)
					end
				end
			end

			local var_75_7 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				var_75_5.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10128, Vector3.New(390, -347, -300), (arg_72_1.time_ - 0) / var_75_7)
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				var_75_5.localPosition = Vector3.New(390, -347, -300)
			end

			local var_75_8 = arg_72_1.actors_["10115"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos10115 = var_75_8.localPosition
				var_75_8.localScale = Vector3.New(1, 1, 1)

				arg_72_1:CheckSpriteTmpPos("10115", 2)

				for iter_75_9 = 0, var_75_8.childCount - 1 do
					local var_75_9 = var_75_8:GetChild(iter_75_9)

					if var_75_9.name == "" or not string.find(var_75_9.name, "split") then
						var_75_9.gameObject:SetActive(true)
					else
						var_75_9.gameObject:SetActive(false)
					end
				end
			end

			local var_75_10 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_10 then
				var_75_8.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos10115, Vector3.New(-390, -387.3, -246.2), (arg_72_1.time_ - 0) / var_75_10)
			end

			if arg_72_1.time_ >= 0 + var_75_10 and arg_72_1.time_ < 0 + var_75_10 + arg_75_0 then
				var_75_8.localPosition = Vector3.New(-390, -387.3, -246.2)
			end

			local var_75_11 = 0
			local var_75_12 = 0.425

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_11 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_13 = arg_72_1:GetWordFromCfg(417242017)
				local var_75_14 = arg_72_1:FormatText(var_75_13.content)

				arg_72_1.text_.text = var_75_14

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_16 = 17 <= 0 and var_75_12 or var_75_12 * (utf8.len(var_75_14) / 17)

				if (17 <= 0 and var_75_12 or var_75_12 * (utf8.len(var_75_14) / 17)) > 0 and var_75_12 < var_75_16 then
					arg_72_1.talkMaxDuration = var_75_16

					if var_75_16 + var_75_11 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_16 + var_75_11
					end
				end

				arg_72_1.text_.text = var_75_14
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242017", "story_v_out_417242.awb") ~= 0 then
					local var_75_17 = manager.audio:GetVoiceLength("story_v_out_417242", "417242017", "story_v_out_417242.awb") / 1000

					if var_75_17 + var_75_11 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_17 + var_75_11
					end

					if var_75_13.prefab_name ~= "" and arg_72_1.actors_[var_75_13.prefab_name] ~= nil then
						local var_75_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_13.prefab_name].transform, "story_v_out_417242", "417242017", "story_v_out_417242.awb")

						arg_72_1:RecordAudio("417242017", var_75_18)
						arg_72_1:RecordAudio("417242017", var_75_18)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_417242", "417242017", "story_v_out_417242.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_417242", "417242017", "story_v_out_417242.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_19 = math.max(var_75_12, arg_72_1.talkMaxDuration)

			if var_75_11 <= arg_72_1.time_ and arg_72_1.time_ < var_75_11 + var_75_19 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_11) / var_75_19

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_11 + var_75_19 and arg_72_1.time_ < var_75_11 + var_75_19 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play417242018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 417242018
		arg_76_1.duration_ = 1

		local var_76_0 = {
			zh = 0.999999999999,
			ja = 1
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play417242019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1034"]) and arg_76_1.var_.actorSpriteComps1034 == nil then
				arg_76_1.var_.actorSpriteComps1034 = arg_76_1.actors_["1034"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_0 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1034"]) then
				if arg_76_1.var_.actorSpriteComps1034 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_79_1 then
							if arg_76_1.isInRecall_ then
								iter_79_1.color = Color.New(Mathf.Lerp(iter_79_1.color.r, arg_76_1.hightColor1.r, (arg_76_1.time_ - 0) / var_79_0), Mathf.Lerp(iter_79_1.color.g, arg_76_1.hightColor1.g, (arg_76_1.time_ - 0) / var_79_0), (Mathf.Lerp(iter_79_1.color.b, arg_76_1.hightColor1.b, (arg_76_1.time_ - 0) / var_79_0)))
							else
								local var_79_1 = Mathf.Lerp(iter_79_1.color.r, 1, (arg_76_1.time_ - 0) / var_79_0)

								iter_79_1.color = Color.New(var_79_1, var_79_1, var_79_1)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1034"]) and arg_76_1.var_.actorSpriteComps1034 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_79_3 then
						iter_79_3.color = arg_76_1.isInRecall_ and (arg_76_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_76_1.var_.actorSpriteComps1034 = nil
			end

			local var_79_2 = arg_76_1.actors_["10128"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.actorSpriteComps10128 == nil then
				arg_76_1.var_.actorSpriteComps10128 = var_79_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_3 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.actorSpriteComps10128 then
					for iter_79_4, iter_79_5 in pairs(arg_76_1.var_.actorSpriteComps10128:ToTable()) do
						if iter_79_5 then
							if arg_76_1.isInRecall_ then
								iter_79_5.color = Color.New(Mathf.Lerp(iter_79_5.color.r, arg_76_1.hightColor2.r, (arg_76_1.time_ - 0) / var_79_3), Mathf.Lerp(iter_79_5.color.g, arg_76_1.hightColor2.g, (arg_76_1.time_ - 0) / var_79_3), (Mathf.Lerp(iter_79_5.color.b, arg_76_1.hightColor2.b, (arg_76_1.time_ - 0) / var_79_3)))
							else
								local var_79_4 = Mathf.Lerp(iter_79_5.color.r, 0.5, (arg_76_1.time_ - 0) / var_79_3)

								iter_79_5.color = Color.New(var_79_4, var_79_4, var_79_4)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.actorSpriteComps10128 then
				for iter_79_6, iter_79_7 in pairs(arg_76_1.var_.actorSpriteComps10128:ToTable()) do
					if iter_79_7 then
						iter_79_7.color = arg_76_1.isInRecall_ and (arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_76_1.var_.actorSpriteComps10128 = nil
			end

			local var_79_5 = arg_76_1.actors_["1034"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1034 = var_79_5.localPosition
				var_79_5.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("1034", 3)

				for iter_79_8 = 0, var_79_5.childCount - 1 do
					local var_79_6 = var_79_5:GetChild(iter_79_8)

					if var_79_6.name == "" or not string.find(var_79_6.name, "split") then
						var_79_6.gameObject:SetActive(true)
					else
						var_79_6.gameObject:SetActive(false)
					end
				end
			end

			local var_79_7 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				var_79_5.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1034, Vector3.New(0, -331.9, -324), (arg_76_1.time_ - 0) / var_79_7)
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				var_79_5.localPosition = Vector3.New(0, -331.9, -324)
			end

			local var_79_8 = arg_76_1.actors_["10128"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos10128 = var_79_8.localPosition
				var_79_8.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("10128", 7)

				for iter_79_9 = 0, var_79_8.childCount - 1 do
					local var_79_9 = var_79_8:GetChild(iter_79_9)

					if var_79_9.name == "" or not string.find(var_79_9.name, "split") then
						var_79_9.gameObject:SetActive(true)
					else
						var_79_9.gameObject:SetActive(false)
					end
				end
			end

			local var_79_10 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_10 then
				var_79_8.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10128, Vector3.New(0, -2000, -300), (arg_76_1.time_ - 0) / var_79_10)
			end

			if arg_76_1.time_ >= 0 + var_79_10 and arg_76_1.time_ < 0 + var_79_10 + arg_79_0 then
				var_79_8.localPosition = Vector3.New(0, -2000, -300)
			end

			local var_79_11 = arg_76_1.actors_["10115"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos10115 = var_79_11.localPosition
				var_79_11.localScale = Vector3.New(1, 1, 1)

				arg_76_1:CheckSpriteTmpPos("10115", 7)

				for iter_79_10 = 0, var_79_11.childCount - 1 do
					local var_79_12 = var_79_11:GetChild(iter_79_10)

					if var_79_12.name == "" or not string.find(var_79_12.name, "split") then
						var_79_12.gameObject:SetActive(true)
					else
						var_79_12.gameObject:SetActive(false)
					end
				end
			end

			local var_79_13 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_13 then
				var_79_11.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10115, Vector3.New(0, -2000, 0), (arg_76_1.time_ - 0) / var_79_13)
			end

			if arg_76_1.time_ >= 0 + var_79_13 and arg_76_1.time_ < 0 + var_79_13 + arg_79_0 then
				var_79_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_79_14 = 0
			local var_79_15 = 0.1

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_14 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_16 = arg_76_1:GetWordFromCfg(417242018)
				local var_79_17 = arg_76_1:FormatText(var_79_16.content)

				arg_76_1.text_.text = var_79_17

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_19 = 4 <= 0 and var_79_15 or var_79_15 * (utf8.len(var_79_17) / 4)

				if (4 <= 0 and var_79_15 or var_79_15 * (utf8.len(var_79_17) / 4)) > 0 and var_79_15 < var_79_19 then
					arg_76_1.talkMaxDuration = var_79_19

					if var_79_19 + var_79_14 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_19 + var_79_14
					end
				end

				arg_76_1.text_.text = var_79_17
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242018", "story_v_out_417242.awb") ~= 0 then
					local var_79_20 = manager.audio:GetVoiceLength("story_v_out_417242", "417242018", "story_v_out_417242.awb") / 1000

					if var_79_20 + var_79_14 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_20 + var_79_14
					end

					if var_79_16.prefab_name ~= "" and arg_76_1.actors_[var_79_16.prefab_name] ~= nil then
						local var_79_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_16.prefab_name].transform, "story_v_out_417242", "417242018", "story_v_out_417242.awb")

						arg_76_1:RecordAudio("417242018", var_79_21)
						arg_76_1:RecordAudio("417242018", var_79_21)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_417242", "417242018", "story_v_out_417242.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_417242", "417242018", "story_v_out_417242.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_22 = math.max(var_79_15, arg_76_1.talkMaxDuration)

			if var_79_14 <= arg_76_1.time_ and arg_76_1.time_ < var_79_14 + var_79_22 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_14) / var_79_22

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_14 + var_79_22 and arg_76_1.time_ < var_79_14 + var_79_22 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10128",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play417242019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 417242019
		arg_80_1.duration_ = 9.53

		local var_80_0 = {
			zh = 5.966,
			ja = 9.533
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play417242020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["10115"]) and arg_80_1.var_.actorSpriteComps10115 == nil then
				arg_80_1.var_.actorSpriteComps10115 = arg_80_1.actors_["10115"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_0 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["10115"]) then
				if arg_80_1.var_.actorSpriteComps10115 then
					for iter_83_0, iter_83_1 in pairs(arg_80_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_83_1 then
							if arg_80_1.isInRecall_ then
								iter_83_1.color = Color.New(Mathf.Lerp(iter_83_1.color.r, arg_80_1.hightColor1.r, (arg_80_1.time_ - 0) / var_83_0), Mathf.Lerp(iter_83_1.color.g, arg_80_1.hightColor1.g, (arg_80_1.time_ - 0) / var_83_0), (Mathf.Lerp(iter_83_1.color.b, arg_80_1.hightColor1.b, (arg_80_1.time_ - 0) / var_83_0)))
							else
								local var_83_1 = Mathf.Lerp(iter_83_1.color.r, 1, (arg_80_1.time_ - 0) / var_83_0)

								iter_83_1.color = Color.New(var_83_1, var_83_1, var_83_1)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["10115"]) and arg_80_1.var_.actorSpriteComps10115 then
				for iter_83_2, iter_83_3 in pairs(arg_80_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_83_3 then
						iter_83_3.color = arg_80_1.isInRecall_ and (arg_80_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_80_1.var_.actorSpriteComps10115 = nil
			end

			local var_83_2 = arg_80_1.actors_["1034"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.actorSpriteComps1034 == nil then
				arg_80_1.var_.actorSpriteComps1034 = var_83_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_3 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_3 and not isNil(var_83_2) then
				if arg_80_1.var_.actorSpriteComps1034 then
					for iter_83_4, iter_83_5 in pairs(arg_80_1.var_.actorSpriteComps1034:ToTable()) do
						if iter_83_5 then
							if arg_80_1.isInRecall_ then
								iter_83_5.color = Color.New(Mathf.Lerp(iter_83_5.color.r, arg_80_1.hightColor2.r, (arg_80_1.time_ - 0) / var_83_3), Mathf.Lerp(iter_83_5.color.g, arg_80_1.hightColor2.g, (arg_80_1.time_ - 0) / var_83_3), (Mathf.Lerp(iter_83_5.color.b, arg_80_1.hightColor2.b, (arg_80_1.time_ - 0) / var_83_3)))
							else
								local var_83_4 = Mathf.Lerp(iter_83_5.color.r, 0.5, (arg_80_1.time_ - 0) / var_83_3)

								iter_83_5.color = Color.New(var_83_4, var_83_4, var_83_4)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= 0 + var_83_3 and arg_80_1.time_ < 0 + var_83_3 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.actorSpriteComps1034 then
				for iter_83_6, iter_83_7 in pairs(arg_80_1.var_.actorSpriteComps1034:ToTable()) do
					if iter_83_7 then
						iter_83_7.color = arg_80_1.isInRecall_ and (arg_80_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_80_1.var_.actorSpriteComps1034 = nil
			end

			local var_83_5 = arg_80_1.actors_["1034"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1034 = var_83_5.localPosition
				var_83_5.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("1034", 7)

				for iter_83_8 = 0, var_83_5.childCount - 1 do
					local var_83_6 = var_83_5:GetChild(iter_83_8)

					if var_83_6.name == "" or not string.find(var_83_6.name, "split") then
						var_83_6.gameObject:SetActive(true)
					else
						var_83_6.gameObject:SetActive(false)
					end
				end
			end

			local var_83_7 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 then
				var_83_5.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1034, Vector3.New(0, -2000, 0), (arg_80_1.time_ - 0) / var_83_7)
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 then
				var_83_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_83_8 = arg_80_1.actors_["10115"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos10115 = var_83_8.localPosition
				var_83_8.localScale = Vector3.New(1, 1, 1)

				arg_80_1:CheckSpriteTmpPos("10115", 3)

				for iter_83_9 = 0, var_83_8.childCount - 1 do
					local var_83_9 = var_83_8:GetChild(iter_83_9)

					if var_83_9.name == "" or not string.find(var_83_9.name, "split") then
						var_83_9.gameObject:SetActive(true)
					else
						var_83_9.gameObject:SetActive(false)
					end
				end
			end

			local var_83_10 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_10 then
				var_83_8.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos10115, Vector3.New(0, -387.3, -246.2), (arg_80_1.time_ - 0) / var_83_10)
			end

			if arg_80_1.time_ >= 0 + var_83_10 and arg_80_1.time_ < 0 + var_83_10 + arg_83_0 then
				var_83_8.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_83_11 = 0
			local var_83_12 = 0.9

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_11 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_13 = arg_80_1:GetWordFromCfg(417242019)
				local var_83_14 = arg_80_1:FormatText(var_83_13.content)

				arg_80_1.text_.text = var_83_14

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_16 = 36 <= 0 and var_83_12 or var_83_12 * (utf8.len(var_83_14) / 36)

				if (36 <= 0 and var_83_12 or var_83_12 * (utf8.len(var_83_14) / 36)) > 0 and var_83_12 < var_83_16 then
					arg_80_1.talkMaxDuration = var_83_16

					if var_83_16 + var_83_11 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_16 + var_83_11
					end
				end

				arg_80_1.text_.text = var_83_14
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242019", "story_v_out_417242.awb") ~= 0 then
					local var_83_17 = manager.audio:GetVoiceLength("story_v_out_417242", "417242019", "story_v_out_417242.awb") / 1000

					if var_83_17 + var_83_11 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_17 + var_83_11
					end

					if var_83_13.prefab_name ~= "" and arg_80_1.actors_[var_83_13.prefab_name] ~= nil then
						local var_83_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_13.prefab_name].transform, "story_v_out_417242", "417242019", "story_v_out_417242.awb")

						arg_80_1:RecordAudio("417242019", var_83_18)
						arg_80_1:RecordAudio("417242019", var_83_18)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_417242", "417242019", "story_v_out_417242.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_417242", "417242019", "story_v_out_417242.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_19 = math.max(var_83_12, arg_80_1.talkMaxDuration)

			if var_83_11 <= arg_80_1.time_ and arg_80_1.time_ < var_83_11 + var_83_19 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_11) / var_83_19

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_11 + var_83_19 and arg_80_1.time_ < var_83_11 + var_83_19 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play417242020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 417242020
		arg_84_1.duration_ = 9.1

		local var_84_0 = {
			zh = 8.966,
			ja = 9.1
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play417242021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 1.025

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_1 = arg_84_1:GetWordFromCfg(417242020)
				local var_87_2 = arg_84_1:FormatText(var_87_1.content)

				arg_84_1.text_.text = var_87_2

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 41 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 41)

				if (41 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 41)) > 0 and var_87_0 < var_87_4 then
					arg_84_1.talkMaxDuration = var_87_4

					if var_87_4 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_4 + 0
					end
				end

				arg_84_1.text_.text = var_87_2
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242020", "story_v_out_417242.awb") ~= 0 then
					local var_87_5 = manager.audio:GetVoiceLength("story_v_out_417242", "417242020", "story_v_out_417242.awb") / 1000

					if var_87_5 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + 0
					end

					if var_87_1.prefab_name ~= "" and arg_84_1.actors_[var_87_1.prefab_name] ~= nil then
						local var_87_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_1.prefab_name].transform, "story_v_out_417242", "417242020", "story_v_out_417242.awb")

						arg_84_1:RecordAudio("417242020", var_87_6)
						arg_84_1:RecordAudio("417242020", var_87_6)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_417242", "417242020", "story_v_out_417242.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_417242", "417242020", "story_v_out_417242.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play417242021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 417242021
		arg_88_1.duration_ = 8.07

		local var_88_0 = {
			zh = 6.833,
			ja = 8.066
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play417242022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos10115 = arg_88_1.actors_["10115"].transform.localPosition
				arg_88_1.actors_["10115"].transform.localScale = Vector3.New(1, 1, 1)

				arg_88_1:CheckSpriteTmpPos("10115", 3)

				for iter_91_0 = 0, arg_88_1.actors_["10115"].transform.childCount - 1 do
					local var_91_0 = arg_88_1.actors_["10115"].transform:GetChild(iter_91_0)

					if var_91_0.name == "split_6" or not string.find(var_91_0.name, "split") then
						var_91_0.gameObject:SetActive(true)
					else
						var_91_0.gameObject:SetActive(false)
					end
				end
			end

			local var_91_1 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_1 then
				arg_88_1.actors_["10115"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10115, Vector3.New(0, -387.3, -246.2), (arg_88_1.time_ - 0) / var_91_1)
			end

			if arg_88_1.time_ >= 0 + var_91_1 and arg_88_1.time_ < 0 + var_91_1 + arg_91_0 then
				arg_88_1.actors_["10115"].transform.localPosition = Vector3.New(0, -387.3, -246.2)
			end

			local var_91_2 = 0
			local var_91_3 = 0.725

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_2 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_4 = arg_88_1:GetWordFromCfg(417242021)
				local var_91_5 = arg_88_1:FormatText(var_91_4.content)

				arg_88_1.text_.text = var_91_5

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_7 = 29 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 29)

				if (29 <= 0 and var_91_3 or var_91_3 * (utf8.len(var_91_5) / 29)) > 0 and var_91_3 < var_91_7 then
					arg_88_1.talkMaxDuration = var_91_7

					if var_91_7 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_7 + var_91_2
					end
				end

				arg_88_1.text_.text = var_91_5
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242021", "story_v_out_417242.awb") ~= 0 then
					local var_91_8 = manager.audio:GetVoiceLength("story_v_out_417242", "417242021", "story_v_out_417242.awb") / 1000

					if var_91_8 + var_91_2 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_8 + var_91_2
					end

					if var_91_4.prefab_name ~= "" and arg_88_1.actors_[var_91_4.prefab_name] ~= nil then
						local var_91_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_4.prefab_name].transform, "story_v_out_417242", "417242021", "story_v_out_417242.awb")

						arg_88_1:RecordAudio("417242021", var_91_9)
						arg_88_1:RecordAudio("417242021", var_91_9)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_417242", "417242021", "story_v_out_417242.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_417242", "417242021", "story_v_out_417242.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_10 = math.max(var_91_3, arg_88_1.talkMaxDuration)

			if var_91_2 <= arg_88_1.time_ and arg_88_1.time_ < var_91_2 + var_91_10 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_2) / var_91_10

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_2 + var_91_10 and arg_88_1.time_ < var_91_2 + var_91_10 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10115",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play417242022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 417242022
		arg_92_1.duration_ = 8.57

		local var_92_0 = {
			zh = 5.333,
			ja = 8.566
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
			arg_92_1.auto_ = false
		end

		function arg_92_1.playNext_(arg_94_0)
			arg_92_1.onStoryFinished_()
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.5

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_1 = arg_92_1:GetWordFromCfg(417242022)
				local var_95_2 = arg_92_1:FormatText(var_95_1.content)

				arg_92_1.text_.text = var_95_2

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 20 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 20)

				if (20 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 20)) > 0 and var_95_0 < var_95_4 then
					arg_92_1.talkMaxDuration = var_95_4

					if var_95_4 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_4 + 0
					end
				end

				arg_92_1.text_.text = var_95_2
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_417242", "417242022", "story_v_out_417242.awb") ~= 0 then
					local var_95_5 = manager.audio:GetVoiceLength("story_v_out_417242", "417242022", "story_v_out_417242.awb") / 1000

					if var_95_5 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + 0
					end

					if var_95_1.prefab_name ~= "" and arg_92_1.actors_[var_95_1.prefab_name] ~= nil then
						local var_95_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_1.prefab_name].transform, "story_v_out_417242", "417242022", "story_v_out_417242.awb")

						arg_92_1:RecordAudio("417242022", var_95_6)
						arg_92_1:RecordAudio("417242022", var_95_6)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_417242", "417242022", "story_v_out_417242.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_417242", "417242022", "story_v_out_417242.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I17f",
		"TextureConfig/Background/ST73"
	},
	voices = {
		"story_v_out_417242.awb"
	}
}
