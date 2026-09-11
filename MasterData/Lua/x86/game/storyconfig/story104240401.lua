return {
	Play424041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 424041001
		arg_1_1.duration_ = 10.77

		local var_1_0 = {
			zh = 7.066,
			ja = 10.766
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
				arg_1_0:Play424041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I18a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I18a")
				var_4_0.name = "I18a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I18a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I18a

				arg_1_1.bgs_.I18a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I18a" then
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

			if 0.133333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.133333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_12 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_6_story_suspense", "bgm_activity_4_6_story_suspense", "bgm_activity_4_6_story_suspense.awb")

				local var_4_15 = manager.audio:GetAudioName("bgm_activity_4_6_story_suspense", "bgm_activity_4_6_story_suspense")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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

			local var_4_16 = 2
			local var_4_17 = 0.75

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
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

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:GetWordFromCfg(424041001)
				local var_4_20 = arg_1_1:FormatText(var_4_19.content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 30 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 30)

				if (30 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 30)) > 0 and var_4_17 < var_4_22 then
					arg_1_1.talkMaxDuration = var_4_22
					var_4_16 = var_4_16 + 0.3

					if var_4_22 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_20
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041001", "story_v_out_424041.awb") ~= 0 then
					local var_4_23 = manager.audio:GetVoiceLength("story_v_out_424041", "424041001", "story_v_out_424041.awb") / 1000

					if var_4_23 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_16
					end

					if var_4_19.prefab_name ~= "" and arg_1_1.actors_[var_4_19.prefab_name] ~= nil then
						local var_4_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_19.prefab_name].transform, "story_v_out_424041", "424041001", "story_v_out_424041.awb")

						arg_1_1:RecordAudio("424041001", var_4_24)
						arg_1_1:RecordAudio("424041001", var_4_24)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_424041", "424041001", "story_v_out_424041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_424041", "424041001", "story_v_out_424041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_16 + 0.3
			local var_4_26 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play424041002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 424041002
		arg_9_1.duration_ = 6.27

		local var_9_0 = {
			zh = 4.566,
			ja = 6.266
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
				arg_9_0:Play424041003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.65

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_1 = arg_9_1:GetWordFromCfg(424041002)
				local var_12_2 = arg_9_1:FormatText(var_12_1.content)

				arg_9_1.text_.text = var_12_2

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_4 = 26 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 26)

				if (26 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_2) / 26)) > 0 and var_12_0 < var_12_4 then
					arg_9_1.talkMaxDuration = var_12_4

					if var_12_4 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_4 + 0
					end
				end

				arg_9_1.text_.text = var_12_2
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041002", "story_v_out_424041.awb") ~= 0 then
					local var_12_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041002", "story_v_out_424041.awb") / 1000

					if var_12_5 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + 0
					end

					if var_12_1.prefab_name ~= "" and arg_9_1.actors_[var_12_1.prefab_name] ~= nil then
						local var_12_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_1.prefab_name].transform, "story_v_out_424041", "424041002", "story_v_out_424041.awb")

						arg_9_1:RecordAudio("424041002", var_12_6)
						arg_9_1:RecordAudio("424041002", var_12_6)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_424041", "424041002", "story_v_out_424041.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_424041", "424041002", "story_v_out_424041.awb")
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
	Play424041003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 424041003
		arg_13_1.duration_ = 4.9

		local var_13_0 = {
			zh = 2.433,
			ja = 4.9
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
				arg_13_0:Play424041004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1094"] == nil then
				local var_16_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1094")

				if not isNil(var_16_0) then
					local var_16_1 = Object.Instantiate(var_16_0, arg_13_1.canvasGo_.transform)

					var_16_1.transform:SetSiblingIndex(1)

					var_16_1.name = "1094"
					var_16_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_13_1.actors_["1094"] = var_16_1

					if arg_13_1.isInRecall_ then
						for iter_16_0, iter_16_1 in ipairs((var_16_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_16_1.color = arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_16_2 = arg_13_1.actors_["1094"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps1094 == nil then
				arg_13_1.var_.actorSpriteComps1094 = var_16_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_3 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 and not isNil(var_16_2) then
				if arg_13_1.var_.actorSpriteComps1094 then
					for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and not isNil(var_16_2) and arg_13_1.var_.actorSpriteComps1094 then
				for iter_16_4, iter_16_5 in pairs(arg_13_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_16_5 then
						iter_16_5.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps1094 = nil
			end

			local var_16_5 = arg_13_1.actors_["1094"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1094 = var_16_5.localPosition
				var_16_5.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1094", 3)

				for iter_16_6 = 0, var_16_5.childCount - 1 do
					local var_16_6 = var_16_5:GetChild(iter_16_6)

					if var_16_6.name == "split_3" or not string.find(var_16_6.name, "split") then
						var_16_6.gameObject:SetActive(true)
					else
						var_16_6.gameObject:SetActive(false)
					end
				end
			end

			local var_16_7 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_13_1.time_ - 0) / var_16_7)
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -335, -230)
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				local var_16_8 = arg_13_1.actors_["1094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_8 then
					arg_13_1.var_.alphaOldValue1094 = var_16_8.alpha
					arg_13_1.var_.characterEffect1094 = var_16_8
				end

				arg_13_1.var_.alphaOldValue1094 = 0
			end

			local var_16_9 = 0.5

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_9 then
				if arg_13_1.var_.characterEffect1094 then
					arg_13_1.var_.characterEffect1094.alpha = Mathf.Lerp(arg_13_1.var_.alphaOldValue1094, 1, (arg_13_1.time_ - 0) / var_16_9)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_9 and arg_13_1.time_ < 0 + var_16_9 + arg_16_0 and arg_13_1.var_.characterEffect1094 then
				arg_13_1.var_.characterEffect1094.alpha = 1
			end

			local var_16_10 = 0
			local var_16_11 = 0.275

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_12 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_12:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_13 = arg_13_1:GetWordFromCfg(424041003)
				local var_16_14 = arg_13_1:FormatText(var_16_13.content)

				arg_13_1.text_.text = var_16_14

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_16 = 11 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_14) / 11)

				if (11 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_14) / 11)) > 0 and var_16_11 < var_16_16 then
					arg_13_1.talkMaxDuration = var_16_16
					var_16_10 = var_16_10 + 0.3

					if var_16_16 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_14
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041003", "story_v_out_424041.awb") ~= 0 then
					local var_16_17 = manager.audio:GetVoiceLength("story_v_out_424041", "424041003", "story_v_out_424041.awb") / 1000

					if var_16_17 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_10
					end

					if var_16_13.prefab_name ~= "" and arg_13_1.actors_[var_16_13.prefab_name] ~= nil then
						local var_16_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_13.prefab_name].transform, "story_v_out_424041", "424041003", "story_v_out_424041.awb")

						arg_13_1:RecordAudio("424041003", var_16_18)
						arg_13_1:RecordAudio("424041003", var_16_18)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_424041", "424041003", "story_v_out_424041.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_424041", "424041003", "story_v_out_424041.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_19 = var_16_10 + 0.3
			local var_16_20 = math.max(var_16_11, arg_13_1.talkMaxDuration)

			if var_16_10 + 0.3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_19 + var_16_20 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_19) / var_16_20

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_19 + var_16_20 and arg_13_1.time_ < var_16_19 + var_16_20 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play424041004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 424041004
		arg_19_1.duration_ = 5.97

		local var_19_0 = {
			zh = 5.466,
			ja = 5.966
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play424041005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["1094"]) and arg_19_1.var_.actorSpriteComps1094 == nil then
				arg_19_1.var_.actorSpriteComps1094 = arg_19_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_0 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 and not isNil(arg_19_1.actors_["1094"]) then
				if arg_19_1.var_.actorSpriteComps1094 then
					for iter_22_0, iter_22_1 in pairs(arg_19_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_22_1 then
							if arg_19_1.isInRecall_ then
								iter_22_1.color = Color.New(Mathf.Lerp(iter_22_1.color.r, arg_19_1.hightColor2.r, (arg_19_1.time_ - 0) / var_22_0), Mathf.Lerp(iter_22_1.color.g, arg_19_1.hightColor2.g, (arg_19_1.time_ - 0) / var_22_0), (Mathf.Lerp(iter_22_1.color.b, arg_19_1.hightColor2.b, (arg_19_1.time_ - 0) / var_22_0)))
							else
								local var_22_1 = Mathf.Lerp(iter_22_1.color.r, 0.5, (arg_19_1.time_ - 0) / var_22_0)

								iter_22_1.color = Color.New(var_22_1, var_22_1, var_22_1)
							end
						end
					end
				end
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 and not isNil(arg_19_1.actors_["1094"]) and arg_19_1.var_.actorSpriteComps1094 then
				for iter_22_2, iter_22_3 in pairs(arg_19_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_22_3 then
						iter_22_3.color = arg_19_1.isInRecall_ and (arg_19_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_19_1.var_.actorSpriteComps1094 = nil
			end

			local var_22_2 = 0
			local var_22_3 = 0.725

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_2 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_19_1.callingController_:SetSelectedState("normal")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_4 = arg_19_1:GetWordFromCfg(424041004)
				local var_22_5 = arg_19_1:FormatText(var_22_4.content)

				arg_19_1.text_.text = var_22_5

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_7 = 29 <= 0 and var_22_3 or var_22_3 * (utf8.len(var_22_5) / 29)

				if (29 <= 0 and var_22_3 or var_22_3 * (utf8.len(var_22_5) / 29)) > 0 and var_22_3 < var_22_7 then
					arg_19_1.talkMaxDuration = var_22_7

					if var_22_7 + var_22_2 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_7 + var_22_2
					end
				end

				arg_19_1.text_.text = var_22_5
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041004", "story_v_out_424041.awb") ~= 0 then
					local var_22_8 = manager.audio:GetVoiceLength("story_v_out_424041", "424041004", "story_v_out_424041.awb") / 1000

					if var_22_8 + var_22_2 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_8 + var_22_2
					end

					if var_22_4.prefab_name ~= "" and arg_19_1.actors_[var_22_4.prefab_name] ~= nil then
						local var_22_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_4.prefab_name].transform, "story_v_out_424041", "424041004", "story_v_out_424041.awb")

						arg_19_1:RecordAudio("424041004", var_22_9)
						arg_19_1:RecordAudio("424041004", var_22_9)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_424041", "424041004", "story_v_out_424041.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_424041", "424041004", "story_v_out_424041.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_10 = math.max(var_22_3, arg_19_1.talkMaxDuration)

			if var_22_2 <= arg_19_1.time_ and arg_19_1.time_ < var_22_2 + var_22_10 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_2) / var_22_10

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_2 + var_22_10 and arg_19_1.time_ < var_22_2 + var_22_10 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play424041005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 424041005
		arg_23_1.duration_ = 4.07

		local var_23_0 = {
			zh = 3.5,
			ja = 4.066
		}
		local var_23_1 = manager.audio:GetLocalizationFlag()

		if var_23_0[var_23_1] ~= nil then
			arg_23_1.duration_ = var_23_0[var_23_1]
		end

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play424041006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["1094"]) and arg_23_1.var_.actorSpriteComps1094 == nil then
				arg_23_1.var_.actorSpriteComps1094 = arg_23_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_0 = 0.2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["1094"]) then
				if arg_23_1.var_.actorSpriteComps1094 then
					for iter_26_0, iter_26_1 in pairs(arg_23_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_26_1 then
							if arg_23_1.isInRecall_ then
								iter_26_1.color = Color.New(Mathf.Lerp(iter_26_1.color.r, arg_23_1.hightColor1.r, (arg_23_1.time_ - 0) / var_26_0), Mathf.Lerp(iter_26_1.color.g, arg_23_1.hightColor1.g, (arg_23_1.time_ - 0) / var_26_0), (Mathf.Lerp(iter_26_1.color.b, arg_23_1.hightColor1.b, (arg_23_1.time_ - 0) / var_26_0)))
							else
								local var_26_1 = Mathf.Lerp(iter_26_1.color.r, 1, (arg_23_1.time_ - 0) / var_26_0)

								iter_26_1.color = Color.New(var_26_1, var_26_1, var_26_1)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["1094"]) and arg_23_1.var_.actorSpriteComps1094 then
				for iter_26_2, iter_26_3 in pairs(arg_23_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_26_3 then
						iter_26_3.color = arg_23_1.isInRecall_ and (arg_23_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_23_1.var_.actorSpriteComps1094 = nil
			end

			local var_26_2 = arg_23_1.actors_["1094"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1094 = var_26_2.localPosition
				var_26_2.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("1094", 3)

				for iter_26_4 = 0, var_26_2.childCount - 1 do
					local var_26_3 = var_26_2:GetChild(iter_26_4)

					if var_26_3.name == "split_4" then
						var_26_3:SetAsLastSibling()
						var_26_3.gameObject:SetActive(true)

						arg_23_1.var_.actorSpriteSplit1094 = var_26_3.gameObject:GetComponent(typeof(Image))

						arg_23_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_26_4 = 0.5

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				var_26_2.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_23_1.time_ - 0) / var_26_4)

				if arg_23_1.var_.actorSpriteSplit1094 ~= nil then
					arg_23_1.var_.actorSpriteSplit1094:SetAlpha((arg_23_1.time_ - 0) / var_26_4)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				var_26_2.localPosition = Vector3.New(0, -335, -230)

				if arg_23_1.var_.actorSpriteSplit1094 ~= nil then
					arg_23_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_26_5 = 0
			local var_26_6 = 0.375

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_5 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_7 = arg_23_1:GetWordFromCfg(424041005)
				local var_26_8 = arg_23_1:FormatText(var_26_7.content)

				arg_23_1.text_.text = var_26_8

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_10 = 15 <= 0 and var_26_6 or var_26_6 * (utf8.len(var_26_8) / 15)

				if (15 <= 0 and var_26_6 or var_26_6 * (utf8.len(var_26_8) / 15)) > 0 and var_26_6 < var_26_10 then
					arg_23_1.talkMaxDuration = var_26_10

					if var_26_10 + var_26_5 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_10 + var_26_5
					end
				end

				arg_23_1.text_.text = var_26_8
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041005", "story_v_out_424041.awb") ~= 0 then
					local var_26_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041005", "story_v_out_424041.awb") / 1000

					if var_26_11 + var_26_5 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_11 + var_26_5
					end

					if var_26_7.prefab_name ~= "" and arg_23_1.actors_[var_26_7.prefab_name] ~= nil then
						local var_26_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_7.prefab_name].transform, "story_v_out_424041", "424041005", "story_v_out_424041.awb")

						arg_23_1:RecordAudio("424041005", var_26_12)
						arg_23_1:RecordAudio("424041005", var_26_12)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_424041", "424041005", "story_v_out_424041.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_424041", "424041005", "story_v_out_424041.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_13 = math.max(var_26_6, arg_23_1.talkMaxDuration)

			if var_26_5 <= arg_23_1.time_ and arg_23_1.time_ < var_26_5 + var_26_13 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_5) / var_26_13

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_5 + var_26_13 and arg_23_1.time_ < var_26_5 + var_26_13 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
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

		arg_23_1:InitPlayNodeList()
	end,
	Play424041006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 424041006
		arg_27_1.duration_ = 8.77

		local var_27_0 = {
			zh = 6.366,
			ja = 8.766
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
				arg_27_0:Play424041007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1094"]) and arg_27_1.var_.actorSpriteComps1094 == nil then
				arg_27_1.var_.actorSpriteComps1094 = arg_27_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_0 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1094"]) then
				if arg_27_1.var_.actorSpriteComps1094 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_30_1 then
							if arg_27_1.isInRecall_ then
								iter_30_1.color = Color.New(Mathf.Lerp(iter_30_1.color.r, arg_27_1.hightColor2.r, (arg_27_1.time_ - 0) / var_30_0), Mathf.Lerp(iter_30_1.color.g, arg_27_1.hightColor2.g, (arg_27_1.time_ - 0) / var_30_0), (Mathf.Lerp(iter_30_1.color.b, arg_27_1.hightColor2.b, (arg_27_1.time_ - 0) / var_30_0)))
							else
								local var_30_1 = Mathf.Lerp(iter_30_1.color.r, 0.5, (arg_27_1.time_ - 0) / var_30_0)

								iter_30_1.color = Color.New(var_30_1, var_30_1, var_30_1)
							end
						end
					end
				end
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1094"]) and arg_27_1.var_.actorSpriteComps1094 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_30_3 then
						iter_30_3.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_27_1.var_.actorSpriteComps1094 = nil
			end

			local var_30_2 = 0
			local var_30_3 = 0.625

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_2 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_4 = arg_27_1:GetWordFromCfg(424041006)
				local var_30_5 = arg_27_1:FormatText(var_30_4.content)

				arg_27_1.text_.text = var_30_5

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_7 = 25 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_5) / 25)

				if (25 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_5) / 25)) > 0 and var_30_3 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_2 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_2
					end
				end

				arg_27_1.text_.text = var_30_5
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041006", "story_v_out_424041.awb") ~= 0 then
					local var_30_8 = manager.audio:GetVoiceLength("story_v_out_424041", "424041006", "story_v_out_424041.awb") / 1000

					if var_30_8 + var_30_2 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_8 + var_30_2
					end

					if var_30_4.prefab_name ~= "" and arg_27_1.actors_[var_30_4.prefab_name] ~= nil then
						local var_30_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_4.prefab_name].transform, "story_v_out_424041", "424041006", "story_v_out_424041.awb")

						arg_27_1:RecordAudio("424041006", var_30_9)
						arg_27_1:RecordAudio("424041006", var_30_9)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_424041", "424041006", "story_v_out_424041.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_424041", "424041006", "story_v_out_424041.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_10 = math.max(var_30_3, arg_27_1.talkMaxDuration)

			if var_30_2 <= arg_27_1.time_ and arg_27_1.time_ < var_30_2 + var_30_10 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_2) / var_30_10

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_2 + var_30_10 and arg_27_1.time_ < var_30_2 + var_30_10 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play424041007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 424041007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play424041008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0.233333333333333 < arg_31_1.time_ and arg_31_1.time_ <= 0.233333333333333 + arg_34_0 then
				arg_31_1:AudioAction("play", "effect", "se_story_16", "se_story_16_leaves", "")
			end

			local var_34_1 = 0
			local var_34_2 = 0.65

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_3 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(424041007).content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 26 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 26)

				if (26 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 26)) > 0 and var_34_2 < var_34_5 then
					arg_31_1.talkMaxDuration = var_34_5

					if var_34_5 + var_34_1 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + var_34_1
					end
				end

				arg_31_1.text_.text = var_34_3
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_6 = math.max(var_34_2, arg_31_1.talkMaxDuration)

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_6 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_1) / var_34_6

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_1 + var_34_6 and arg_31_1.time_ < var_34_1 + var_34_6 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play424041008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 424041008
		arg_35_1.duration_ = 1.53

		local var_35_0 = {
			zh = 1.066,
			ja = 1.533
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
				arg_35_0:Play424041009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["1094"]) and arg_35_1.var_.actorSpriteComps1094 == nil then
				arg_35_1.var_.actorSpriteComps1094 = arg_35_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_38_0 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["1094"]) then
				if arg_35_1.var_.actorSpriteComps1094 then
					for iter_38_0, iter_38_1 in pairs(arg_35_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_38_1 then
							if arg_35_1.isInRecall_ then
								iter_38_1.color = Color.New(Mathf.Lerp(iter_38_1.color.r, arg_35_1.hightColor1.r, (arg_35_1.time_ - 0) / var_38_0), Mathf.Lerp(iter_38_1.color.g, arg_35_1.hightColor1.g, (arg_35_1.time_ - 0) / var_38_0), (Mathf.Lerp(iter_38_1.color.b, arg_35_1.hightColor1.b, (arg_35_1.time_ - 0) / var_38_0)))
							else
								local var_38_1 = Mathf.Lerp(iter_38_1.color.r, 1, (arg_35_1.time_ - 0) / var_38_0)

								iter_38_1.color = Color.New(var_38_1, var_38_1, var_38_1)
							end
						end
					end
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["1094"]) and arg_35_1.var_.actorSpriteComps1094 then
				for iter_38_2, iter_38_3 in pairs(arg_35_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_38_3 then
						iter_38_3.color = arg_35_1.isInRecall_ and (arg_35_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_35_1.var_.actorSpriteComps1094 = nil
			end

			local var_38_2 = arg_35_1.actors_["1094"].transform

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1094 = var_38_2.localPosition
				var_38_2.localScale = Vector3.New(1, 1, 1)

				arg_35_1:CheckSpriteTmpPos("1094", 3)

				for iter_38_4 = 0, var_38_2.childCount - 1 do
					local var_38_3 = var_38_2:GetChild(iter_38_4)

					if var_38_3.name == "split_1" then
						var_38_3:SetAsLastSibling()
						var_38_3.gameObject:SetActive(true)

						arg_35_1.var_.actorSpriteSplit1094 = var_38_3.gameObject:GetComponent(typeof(Image))

						arg_35_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_38_4 = 0.5

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				var_38_2.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_35_1.time_ - 0) / var_38_4)

				if arg_35_1.var_.actorSpriteSplit1094 ~= nil then
					arg_35_1.var_.actorSpriteSplit1094:SetAlpha((arg_35_1.time_ - 0) / var_38_4)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				var_38_2.localPosition = Vector3.New(0, -335, -230)

				if arg_35_1.var_.actorSpriteSplit1094 ~= nil then
					arg_35_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_38_5 = 0
			local var_38_6 = 0.075

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_5 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_7 = arg_35_1:GetWordFromCfg(424041008)
				local var_38_8 = arg_35_1:FormatText(var_38_7.content)

				arg_35_1.text_.text = var_38_8

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_10 = 3 <= 0 and var_38_6 or var_38_6 * (utf8.len(var_38_8) / 3)

				if (3 <= 0 and var_38_6 or var_38_6 * (utf8.len(var_38_8) / 3)) > 0 and var_38_6 < var_38_10 then
					arg_35_1.talkMaxDuration = var_38_10

					if var_38_10 + var_38_5 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_5
					end
				end

				arg_35_1.text_.text = var_38_8
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041008", "story_v_out_424041.awb") ~= 0 then
					local var_38_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041008", "story_v_out_424041.awb") / 1000

					if var_38_11 + var_38_5 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_11 + var_38_5
					end

					if var_38_7.prefab_name ~= "" and arg_35_1.actors_[var_38_7.prefab_name] ~= nil then
						local var_38_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_7.prefab_name].transform, "story_v_out_424041", "424041008", "story_v_out_424041.awb")

						arg_35_1:RecordAudio("424041008", var_38_12)
						arg_35_1:RecordAudio("424041008", var_38_12)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_424041", "424041008", "story_v_out_424041.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_424041", "424041008", "story_v_out_424041.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_13 = math.max(var_38_6, arg_35_1.talkMaxDuration)

			if var_38_5 <= arg_35_1.time_ and arg_35_1.time_ < var_38_5 + var_38_13 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_5) / var_38_13

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_5 + var_38_13 and arg_35_1.time_ < var_38_5 + var_38_13 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
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

		arg_35_1:InitPlayNodeList()
	end,
	Play424041009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 424041009
		arg_39_1.duration_ = 9

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play424041010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_9000

			if arg_39_1.bgs_.ST0116b == nil then
				local var_42_0 = Object.Instantiate(arg_39_1.paintGo_)

				var_42_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0116b")
				var_42_0.name = "ST0116b"
				var_42_0.transform.parent = arg_39_1.stage_.transform
				var_42_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.bgs_.ST0116b = var_42_0
			end

			if 2 < arg_39_1.time_ and arg_39_1.time_ <= 2 + arg_42_0 then
				local var_42_1 = arg_39_1.bgs_.ST0116b

				arg_39_1.bgs_.ST0116b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_42_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_42_2 = var_42_1:GetComponent("SpriteRenderer")

				if var_42_2 and var_42_2.sprite then
					local var_42_3 = 2 * (var_42_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_42_1.transform.localScale = Vector3.New(var_42_3 / var_42_2.sprite.bounds.size.y < var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x and var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x or var_42_3 / var_42_2.sprite.bounds.size.y, var_42_3 / var_42_2.sprite.bounds.size.y < var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x and var_42_3 * manager.ui.mainCameraCom_.aspect / var_42_2.sprite.bounds.size.x or var_42_3 / var_42_2.sprite.bounds.size.y, 0)
				end

				for iter_42_0, iter_42_1 in pairs(arg_39_1.bgs_) do
					if iter_42_0 ~= "ST0116b" then
						iter_42_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_42_4 = 3.999999999999

			if 3.999999999999 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.allBtn_.enabled = false
			end

			if arg_39_1.time_ >= var_42_4 + 0.3 and arg_39_1.time_ < var_42_4 + 0.3 + arg_42_0 then
				arg_39_1.allBtn_.enabled = true
			end

			local var_42_5 = 0

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_5 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_6 = 2

			if var_42_5 <= arg_39_1.time_ and arg_39_1.time_ < var_42_5 + var_42_6 then
				local var_42_7 = Color.New(0, 0, 0)

				var_42_7.a = Mathf.Lerp(0, 1, (arg_39_1.time_ - var_42_5) / var_42_6)
				arg_39_1.mask_.color = var_42_7
			end

			if arg_39_1.time_ >= var_42_5 + var_42_6 and arg_39_1.time_ < var_42_5 + var_42_6 + arg_42_0 then
				local var_42_8 = Color.New(0, 0, 0)

				var_42_8.a = 1
				arg_39_1.mask_.color = var_42_8
			end

			local var_42_9 = 2

			if 2 < arg_39_1.time_ and arg_39_1.time_ <= var_42_9 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_10 = 2

			if var_42_9 <= arg_39_1.time_ and arg_39_1.time_ < var_42_9 + var_42_10 then
				local var_42_11 = Color.New(0, 0, 0)

				var_42_11.a = Mathf.Lerp(1, 0, (arg_39_1.time_ - var_42_9) / var_42_10)
				arg_39_1.mask_.color = var_42_11
			end

			if arg_39_1.time_ >= var_42_9 + var_42_10 and arg_39_1.time_ < var_42_9 + var_42_10 + arg_42_0 then
				local var_42_12 = Color.New(0, 0, 0)

				arg_39_1.mask_.enabled = false
				var_42_12.a = 0
				arg_39_1.mask_.color = var_42_12
			end

			local var_42_13 = arg_39_1.actors_["1094"]

			if 1.966 < arg_39_1.time_ and arg_39_1.time_ <= 1.966 + arg_42_0 and not isNil(var_42_13) and arg_39_1.var_.actorSpriteComps1094 == nil then
				arg_39_1.var_.actorSpriteComps1094 = var_42_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_42_14 = 0.034

			if 1.966 <= arg_39_1.time_ and arg_39_1.time_ < 1.966 + var_42_14 and not isNil(var_42_13) then
				if arg_39_1.var_.actorSpriteComps1094 then
					for iter_42_2, iter_42_3 in pairs(arg_39_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_42_3 then
							if arg_39_1.isInRecall_ then
								iter_42_3.color = Color.New(Mathf.Lerp(iter_42_3.color.r, arg_39_1.hightColor2.r, (arg_39_1.time_ - 1.966) / var_42_14), Mathf.Lerp(iter_42_3.color.g, arg_39_1.hightColor2.g, (arg_39_1.time_ - 1.966) / var_42_14), (Mathf.Lerp(iter_42_3.color.b, arg_39_1.hightColor2.b, (arg_39_1.time_ - 1.966) / var_42_14)))
							else
								local var_42_15 = Mathf.Lerp(iter_42_3.color.r, 0.5, (arg_39_1.time_ - 1.966) / var_42_14)

								iter_42_3.color = Color.New(var_42_15, var_42_15, var_42_15)
							end
						end
					end
				end
			end

			if arg_39_1.time_ >= 1.966 + var_42_14 and arg_39_1.time_ < 1.966 + var_42_14 + arg_42_0 and not isNil(var_42_13) and arg_39_1.var_.actorSpriteComps1094 then
				for iter_42_4, iter_42_5 in pairs(arg_39_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_42_5 then
						iter_42_5.color = arg_39_1.isInRecall_ and (arg_39_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_39_1.var_.actorSpriteComps1094 = nil
			end

			local var_42_16 = arg_39_1.actors_["1094"].transform

			if 1.966 < arg_39_1.time_ and arg_39_1.time_ <= 1.966 + arg_42_0 then
				arg_39_1.var_.moveOldPos1094 = var_42_16.localPosition
				var_42_16.localScale = Vector3.New(1, 1, 1)

				arg_39_1:CheckSpriteTmpPos("1094", 7)

				for iter_42_6 = 0, var_42_16.childCount - 1 do
					local var_42_17 = var_42_16:GetChild(iter_42_6)

					if var_42_17.name == "" or not string.find(var_42_17.name, "split") then
						var_42_17.gameObject:SetActive(true)
					else
						var_42_17.gameObject:SetActive(false)
					end
				end
			end

			local var_42_18 = 0.001

			if 1.966 <= arg_39_1.time_ and arg_39_1.time_ < 1.966 + var_42_18 then
				var_42_16.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_39_1.time_ - 1.966) / var_42_18)
			end

			if arg_39_1.time_ >= 1.966 + var_42_18 and arg_39_1.time_ < 1.966 + var_42_18 + arg_42_0 then
				var_42_16.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.8 < arg_39_1.time_ and arg_39_1.time_ <= 1.8 + arg_42_0 then
				local var_42_19 = arg_39_1.var_.effectmiwu4602

				if not arg_39_1.var_.effectmiwu4602 then
					var_42_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_fogbank_in"), manager.ui.mainCamera.transform)
					var_42_19.name = "miwu4602"
					arg_39_1.var_.effectmiwu4602 = var_42_19
				else
					var_42_19.transform:SetParent(var_42_9000)
				end

				var_42_19.transform.localPosition = Vector3.New(0, 0, -4.5)
				var_42_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.266666666666667 < arg_39_1.time_ and arg_39_1.time_ <= 0.266666666666667 + arg_42_0 then
				arg_39_1:AudioAction("stop", "effect", "se_story_16", "se_story_16_street_loop", "")
			end

			if 1.7 < arg_39_1.time_ and arg_39_1.time_ <= 1.7 + arg_42_0 then
				arg_39_1:AudioAction("play", "effect", "se_story_side_1058", "se_story_side_1058_forest_loop", "")
			end

			if 4.1 < arg_39_1.time_ and arg_39_1.time_ <= 4.1 + arg_42_0 then
				arg_39_1:AudioAction("play", "effect", "se_story_146", "se_story_146_footstep_mud", "")
			end

			if 1.7 < arg_39_1.time_ and arg_39_1.time_ <= 1.7 + arg_42_0 then
				arg_39_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if arg_39_1.frameCnt_ <= 1 then
				arg_39_1.dialog_:SetActive(false)
			end

			local var_42_25 = 3.999999999999
			local var_42_26 = 1.25

			if 3.999999999999 < arg_39_1.time_ and arg_39_1.time_ <= var_42_25 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_27 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_27:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
					arg_39_1.dialogCg_.alpha = arg_43_0
				end))
				var_42_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_28 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(424041009).content)

				arg_39_1.text_.text = var_42_28

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_30 = 50 <= 0 and var_42_26 or var_42_26 * (utf8.len(var_42_28) / 50)

				if (50 <= 0 and var_42_26 or var_42_26 * (utf8.len(var_42_28) / 50)) > 0 and var_42_26 < var_42_30 then
					arg_39_1.talkMaxDuration = var_42_30
					var_42_25 = var_42_25 + 0.3

					if var_42_30 + var_42_25 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_30 + var_42_25
					end
				end

				arg_39_1.text_.text = var_42_28
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_31 = var_42_25 + 0.3
			local var_42_32 = math.max(var_42_26, arg_39_1.talkMaxDuration)

			if var_42_25 + 0.3 <= arg_39_1.time_ and arg_39_1.time_ < var_42_31 + var_42_32 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_31) / var_42_32

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_31 + var_42_32 and arg_39_1.time_ < var_42_31 + var_42_32 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
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

		arg_39_1:InitPlayNodeList()
	end,
	Play424041010 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 424041010
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play424041011(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0.233333333333333 < arg_45_1.time_ and arg_45_1.time_ <= 0.233333333333333 + arg_48_0 then
				arg_45_1:AudioAction("play", "effect", "se_story_146", "se_story_146_pant_male", "")
			end

			local var_48_1 = 0
			local var_48_2 = 0.95

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(424041010).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 38 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 38)

				if (38 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 38)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play424041011 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 424041011
		arg_49_1.duration_ = 1.8

		local var_49_0 = {
			zh = 0.999999999999,
			ja = 1.8
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
				arg_49_0:Play424041012(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.075

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, true)
				arg_49_1.iconController_:SetSelectedState("hero")

				arg_49_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_49_1.callingController_:SetSelectedState("normal")

				arg_49_1.keyicon_.color = Color.New(1, 1, 1)
				arg_49_1.icon_.color = Color.New(1, 1, 1)

				local var_52_1 = arg_49_1:GetWordFromCfg(424041011)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 3 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 3)

				if (3 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 3)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041011", "story_v_out_424041.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041011", "story_v_out_424041.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_424041", "424041011", "story_v_out_424041.awb")

						arg_49_1:RecordAudio("424041011", var_52_6)
						arg_49_1:RecordAudio("424041011", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_424041", "424041011", "story_v_out_424041.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_424041", "424041011", "story_v_out_424041.awb")
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
	Play424041012 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 424041012
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play424041013(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.8

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

				local var_56_1 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(424041012).content)

				arg_53_1.text_.text = var_56_1

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_3 = 72 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 72)

				if (72 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_1) / 72)) > 0 and var_56_0 < var_56_3 then
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
	Play424041013 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 424041013
		arg_57_1.duration_ = 6.17

		local var_57_0 = {
			zh = 6.166,
			ja = 5.366
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play424041014(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.35

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1395].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, true)
				arg_57_1.iconController_:SetSelectedState("hero")

				arg_57_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_57_1.callingController_:SetSelectedState("normal")

				arg_57_1.keyicon_.color = Color.New(1, 1, 1)
				arg_57_1.icon_.color = Color.New(1, 1, 1)

				local var_60_1 = arg_57_1:GetWordFromCfg(424041013)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 14 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 14)

				if (14 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 14)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041013", "story_v_out_424041.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041013", "story_v_out_424041.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_424041", "424041013", "story_v_out_424041.awb")

						arg_57_1:RecordAudio("424041013", var_60_6)
						arg_57_1:RecordAudio("424041013", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_424041", "424041013", "story_v_out_424041.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_424041", "424041013", "story_v_out_424041.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play424041014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 424041014
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play424041015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0.034 < arg_61_1.time_ and arg_61_1.time_ <= 0.034 + arg_64_0 then
				arg_61_1:AudioAction("play", "effect", "se_story_141", "se_story_141_crawl", "")
			end

			if 0.175 < arg_61_1.time_ and arg_61_1.time_ <= 0.175 + arg_64_0 then
				arg_61_1:AudioAction("play", "effect", "se_story_143", "se_story_143_organic01", "")
			end

			local var_64_2 = 0
			local var_64_3 = 1.175

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_4 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(424041014).content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 47 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_4) / 47)

				if (47 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_4) / 47)) > 0 and var_64_3 < var_64_6 then
					arg_61_1.talkMaxDuration = var_64_6

					if var_64_6 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_6 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_7 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_7 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_7

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_7 and arg_61_1.time_ < var_64_2 + var_64_7 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play424041015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 424041015
		arg_65_1.duration_ = 3.4

		local var_65_0 = {
			zh = 2,
			ja = 3.4
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
				arg_65_0:Play424041016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.225

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:GetWordFromCfg(424041015)
				local var_68_2 = arg_65_1:FormatText(var_68_1.content)

				arg_65_1.text_.text = var_68_2

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_4 = 9 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 9)

				if (9 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_2) / 9)) > 0 and var_68_0 < var_68_4 then
					arg_65_1.talkMaxDuration = var_68_4

					if var_68_4 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_4 + 0
					end
				end

				arg_65_1.text_.text = var_68_2
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041015", "story_v_out_424041.awb") ~= 0 then
					local var_68_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041015", "story_v_out_424041.awb") / 1000

					if var_68_5 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + 0
					end

					if var_68_1.prefab_name ~= "" and arg_65_1.actors_[var_68_1.prefab_name] ~= nil then
						local var_68_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_1.prefab_name].transform, "story_v_out_424041", "424041015", "story_v_out_424041.awb")

						arg_65_1:RecordAudio("424041015", var_68_6)
						arg_65_1:RecordAudio("424041015", var_68_6)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_424041", "424041015", "story_v_out_424041.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_424041", "424041015", "story_v_out_424041.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_7 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_7

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play424041016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 424041016
		arg_69_1.duration_ = 3.97

		local var_69_0 = {
			zh = 3.966,
			ja = 3.633
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
				arg_69_0:Play424041017(arg_69_1)
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

					if var_72_3.name == "split_3" or not string.find(var_72_3.name, "split") then
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

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				local var_72_5 = arg_69_1.actors_["1094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_72_5 then
					arg_69_1.var_.alphaOldValue1094 = var_72_5.alpha
					arg_69_1.var_.characterEffect1094 = var_72_5
				end

				arg_69_1.var_.alphaOldValue1094 = 0
			end

			local var_72_6 = 0.5

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_6 then
				if arg_69_1.var_.characterEffect1094 then
					arg_69_1.var_.characterEffect1094.alpha = Mathf.Lerp(arg_69_1.var_.alphaOldValue1094, 1, (arg_69_1.time_ - 0) / var_72_6)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_6 and arg_69_1.time_ < 0 + var_72_6 + arg_72_0 and arg_69_1.var_.characterEffect1094 then
				arg_69_1.var_.characterEffect1094.alpha = 1
			end

			local var_72_7 = 0
			local var_72_8 = 0.3

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 then
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

				local var_72_9 = arg_69_1:GetWordFromCfg(424041016)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_12 = 12 <= 0 and var_72_8 or var_72_8 * (utf8.len(var_72_10) / 12)

				if (12 <= 0 and var_72_8 or var_72_8 * (utf8.len(var_72_10) / 12)) > 0 and var_72_8 < var_72_12 then
					arg_69_1.talkMaxDuration = var_72_12

					if var_72_12 + var_72_7 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_12 + var_72_7
					end
				end

				arg_69_1.text_.text = var_72_10
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041016", "story_v_out_424041.awb") ~= 0 then
					local var_72_13 = manager.audio:GetVoiceLength("story_v_out_424041", "424041016", "story_v_out_424041.awb") / 1000

					if var_72_13 + var_72_7 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_7
					end

					if var_72_9.prefab_name ~= "" and arg_69_1.actors_[var_72_9.prefab_name] ~= nil then
						local var_72_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_9.prefab_name].transform, "story_v_out_424041", "424041016", "story_v_out_424041.awb")

						arg_69_1:RecordAudio("424041016", var_72_14)
						arg_69_1:RecordAudio("424041016", var_72_14)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_424041", "424041016", "story_v_out_424041.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_424041", "424041016", "story_v_out_424041.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_15 = math.max(var_72_8, arg_69_1.talkMaxDuration)

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_15 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_7) / var_72_15

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_7 + var_72_15 and arg_69_1.time_ < var_72_7 + var_72_15 + arg_72_0 then
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
	Play424041017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 424041017
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play424041018(arg_73_1)
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

			local var_76_2 = arg_73_1.actors_["1094"].transform

			if 0.5 < arg_73_1.time_ and arg_73_1.time_ <= 0.5 + arg_76_0 then
				arg_73_1.var_.moveOldPos1094 = var_76_2.localPosition
				var_76_2.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1094", 7)

				for iter_76_4 = 0, var_76_2.childCount - 1 do
					local var_76_3 = var_76_2:GetChild(iter_76_4)

					if var_76_3.name == "" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.0666666666666667

			if 0.5 <= arg_73_1.time_ and arg_73_1.time_ < 0.5 + var_76_4 then
				var_76_2.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_73_1.time_ - 0.5) / var_76_4)
			end

			if arg_73_1.time_ >= 0.5 + var_76_4 and arg_73_1.time_ < 0.5 + var_76_4 + arg_76_0 then
				var_76_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				local var_76_5 = arg_73_1.actors_["1094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_76_5 then
					arg_73_1.var_.alphaOldValue1094 = var_76_5.alpha
					arg_73_1.var_.characterEffect1094 = var_76_5
				end

				arg_73_1.var_.alphaOldValue1094 = 1
			end

			local var_76_6 = 0.5

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_6 then
				if arg_73_1.var_.characterEffect1094 then
					arg_73_1.var_.characterEffect1094.alpha = Mathf.Lerp(arg_73_1.var_.alphaOldValue1094, 0, (arg_73_1.time_ - 0) / var_76_6)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_6 and arg_73_1.time_ < 0 + var_76_6 + arg_76_0 and arg_73_1.var_.characterEffect1094 then
				arg_73_1.var_.characterEffect1094.alpha = 0
			end

			if 0.5 < arg_73_1.time_ and arg_73_1.time_ <= 0.5 + arg_76_0 then
				local var_76_7 = arg_73_1.actors_["1094"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_76_7 then
					arg_73_1.var_.alphaOldValue1094 = var_76_7.alpha
					arg_73_1.var_.characterEffect1094 = var_76_7
				end

				arg_73_1.var_.alphaOldValue1094 = 0
			end

			local var_76_8 = 0.0666666666666667

			if 0.5 <= arg_73_1.time_ and arg_73_1.time_ < 0.5 + var_76_8 then
				if arg_73_1.var_.characterEffect1094 then
					arg_73_1.var_.characterEffect1094.alpha = Mathf.Lerp(arg_73_1.var_.alphaOldValue1094, 1, (arg_73_1.time_ - 0.5) / var_76_8)
				end
			end

			if arg_73_1.time_ >= 0.5 + var_76_8 and arg_73_1.time_ < 0.5 + var_76_8 + arg_76_0 and arg_73_1.var_.characterEffect1094 then
				arg_73_1.var_.characterEffect1094.alpha = 1
			end

			if 0.034 < arg_73_1.time_ and arg_73_1.time_ <= 0.034 + arg_76_0 then
				arg_73_1:AudioAction("play", "effect", "se_story_128", "se_story_128_magic", "")
			end

			local var_76_10 = 0
			local var_76_11 = 1.025

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_12 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(424041017).content)

				arg_73_1.text_.text = var_76_12

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_14 = 41 <= 0 and var_76_11 or var_76_11 * (utf8.len(var_76_12) / 41)

				if (41 <= 0 and var_76_11 or var_76_11 * (utf8.len(var_76_12) / 41)) > 0 and var_76_11 < var_76_14 then
					arg_73_1.talkMaxDuration = var_76_14

					if var_76_14 + var_76_10 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_10
					end
				end

				arg_73_1.text_.text = var_76_12
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_15 = math.max(var_76_11, arg_73_1.talkMaxDuration)

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_15 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_10) / var_76_15

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_10 + var_76_15 and arg_73_1.time_ < var_76_10 + var_76_15 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0666666666666667,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play424041018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 424041018
		arg_77_1.duration_ = 5.23

		local var_77_0 = {
			zh = 5.233,
			ja = 3.633
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
				arg_77_0:Play424041019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.325

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1395].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(424041018)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 13 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 13)

				if (13 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 13)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041018", "story_v_out_424041.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041018", "story_v_out_424041.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_424041", "424041018", "story_v_out_424041.awb")

						arg_77_1:RecordAudio("424041018", var_80_6)
						arg_77_1:RecordAudio("424041018", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_424041", "424041018", "story_v_out_424041.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_424041", "424041018", "story_v_out_424041.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play424041019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 424041019
		arg_81_1.duration_ = 1.4

		local var_81_0 = {
			zh = 1.4,
			ja = 1.333
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
				arg_81_0:Play424041020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if arg_81_1.actors_["1194"] == nil then
				local var_84_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1194")

				if not isNil(var_84_0) then
					local var_84_1 = Object.Instantiate(var_84_0, arg_81_1.canvasGo_.transform)

					var_84_1.transform:SetSiblingIndex(1)

					var_84_1.name = "1194"
					var_84_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_81_1.actors_["1194"] = var_84_1

					if arg_81_1.isInRecall_ then
						for iter_84_0, iter_84_1 in ipairs((var_84_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_84_1.color = arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_84_2 = arg_81_1.actors_["1194"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps1194 == nil then
				arg_81_1.var_.actorSpriteComps1194 = var_84_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_3 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.actorSpriteComps1194 then
					for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps1194:ToTable()) do
						if iter_84_3 then
							if arg_81_1.isInRecall_ then
								iter_84_3.color = Color.New(Mathf.Lerp(iter_84_3.color.r, arg_81_1.hightColor1.r, (arg_81_1.time_ - 0) / var_84_3), Mathf.Lerp(iter_84_3.color.g, arg_81_1.hightColor1.g, (arg_81_1.time_ - 0) / var_84_3), (Mathf.Lerp(iter_84_3.color.b, arg_81_1.hightColor1.b, (arg_81_1.time_ - 0) / var_84_3)))
							else
								local var_84_4 = Mathf.Lerp(iter_84_3.color.r, 1, (arg_81_1.time_ - 0) / var_84_3)

								iter_84_3.color = Color.New(var_84_4, var_84_4, var_84_4)
							end
						end
					end
				end
			end

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps1194 then
				for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps1194:ToTable()) do
					if iter_84_5 then
						iter_84_5.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps1194 = nil
			end

			local var_84_5 = arg_81_1.actors_["1194"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1194 = var_84_5.localPosition
				var_84_5.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1194", 3)

				for iter_84_6 = 0, var_84_5.childCount - 1 do
					local var_84_6 = var_84_5:GetChild(iter_84_6)

					if var_84_6.name == "split_1" or not string.find(var_84_6.name, "split") then
						var_84_6.gameObject:SetActive(true)
					else
						var_84_6.gameObject:SetActive(false)
					end
				end
			end

			local var_84_7 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				var_84_5.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1194, Vector3.New(-60, -360, -240), (arg_81_1.time_ - 0) / var_84_7)
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				var_84_5.localPosition = Vector3.New(-60, -360, -240)
			end

			local var_84_8 = 0
			local var_84_9 = 0.075

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(424041019)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 3 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 3)

				if (3 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 3)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041019", "story_v_out_424041.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041019", "story_v_out_424041.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_424041", "424041019", "story_v_out_424041.awb")

						arg_81_1:RecordAudio("424041019", var_84_15)
						arg_81_1:RecordAudio("424041019", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_424041", "424041019", "story_v_out_424041.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_424041", "424041019", "story_v_out_424041.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_16 and arg_81_1.time_ < var_84_8 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
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
	Play424041020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 424041020
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play424041021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1094"]) and arg_85_1.var_.actorSpriteComps1094 == nil then
				arg_85_1.var_.actorSpriteComps1094 = arg_85_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_0 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1094"]) then
				if arg_85_1.var_.actorSpriteComps1094 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								iter_88_1.color = Color.New(Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_0), Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_0), (Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_0)))
							else
								local var_88_1 = Mathf.Lerp(iter_88_1.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_0)

								iter_88_1.color = Color.New(var_88_1, var_88_1, var_88_1)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1094"]) and arg_85_1.var_.actorSpriteComps1094 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_88_3 then
						iter_88_3.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps1094 = nil
			end

			local var_88_2 = arg_85_1.actors_["1194"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1194 = var_88_2.localPosition
				var_88_2.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1194", 7)

				for iter_88_4 = 0, var_88_2.childCount - 1 do
					local var_88_3 = var_88_2:GetChild(iter_88_4)

					if var_88_3.name == "" or not string.find(var_88_3.name, "split") then
						var_88_3.gameObject:SetActive(true)
					else
						var_88_3.gameObject:SetActive(false)
					end
				end
			end

			local var_88_4 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 then
				var_88_2.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1194, Vector3.New(0, -2000, 0), (arg_85_1.time_ - 0) / var_88_4)
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 then
				var_88_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.034 < arg_85_1.time_ and arg_85_1.time_ <= 0.034 + arg_88_0 then
				arg_85_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_magic", "")
			end

			local var_88_6 = 0
			local var_88_7 = 1.025

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_8 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(424041020).content)

				arg_85_1.text_.text = var_88_8

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_10 = 41 <= 0 and var_88_7 or var_88_7 * (utf8.len(var_88_8) / 41)

				if (41 <= 0 and var_88_7 or var_88_7 * (utf8.len(var_88_8) / 41)) > 0 and var_88_7 < var_88_10 then
					arg_85_1.talkMaxDuration = var_88_10

					if var_88_10 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_8
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_11 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_11 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_11

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_11 and arg_85_1.time_ < var_88_6 + var_88_11 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1194",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play424041021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 424041021
		arg_89_1.duration_ = 3.3

		local var_89_0 = {
			zh = 2.066,
			ja = 3.3
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
				arg_89_0:Play424041022(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.275

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_1 = arg_89_1:GetWordFromCfg(424041021)
				local var_92_2 = arg_89_1:FormatText(var_92_1.content)

				arg_89_1.text_.text = var_92_2

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_4 = 11 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 11)

				if (11 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_2) / 11)) > 0 and var_92_0 < var_92_4 then
					arg_89_1.talkMaxDuration = var_92_4

					if var_92_4 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_4 + 0
					end
				end

				arg_89_1.text_.text = var_92_2
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041021", "story_v_out_424041.awb") ~= 0 then
					local var_92_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041021", "story_v_out_424041.awb") / 1000

					if var_92_5 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + 0
					end

					if var_92_1.prefab_name ~= "" and arg_89_1.actors_[var_92_1.prefab_name] ~= nil then
						local var_92_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_1.prefab_name].transform, "story_v_out_424041", "424041021", "story_v_out_424041.awb")

						arg_89_1:RecordAudio("424041021", var_92_6)
						arg_89_1:RecordAudio("424041021", var_92_6)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_424041", "424041021", "story_v_out_424041.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_424041", "424041021", "story_v_out_424041.awb")
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
	Play424041022 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 424041022
		arg_93_1.duration_ = 2.7

		local var_93_0 = {
			zh = 2.433,
			ja = 2.7
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
				arg_93_0:Play424041023(arg_93_1)
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
								iter_96_1.color = Color.New(Mathf.Lerp(iter_96_1.color.r, arg_93_1.hightColor1.r, (arg_93_1.time_ - 0) / var_96_0), Mathf.Lerp(iter_96_1.color.g, arg_93_1.hightColor1.g, (arg_93_1.time_ - 0) / var_96_0), (Mathf.Lerp(iter_96_1.color.b, arg_93_1.hightColor1.b, (arg_93_1.time_ - 0) / var_96_0)))
							else
								local var_96_1 = Mathf.Lerp(iter_96_1.color.r, 1, (arg_93_1.time_ - 0) / var_96_0)

								iter_96_1.color = Color.New(var_96_1, var_96_1, var_96_1)
							end
						end
					end
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1094"]) and arg_93_1.var_.actorSpriteComps1094 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_96_3 then
						iter_96_3.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps1094 = nil
			end

			local var_96_2 = arg_93_1.actors_["1094"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1094 = var_96_2.localPosition
				var_96_2.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1094", 3)

				for iter_96_4 = 0, var_96_2.childCount - 1 do
					local var_96_3 = var_96_2:GetChild(iter_96_4)

					if var_96_3.name == "" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				var_96_2.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_93_1.time_ - 0) / var_96_4)
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				var_96_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_96_5 = 0
			local var_96_6 = 0.175

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_7 = arg_93_1:GetWordFromCfg(424041022)
				local var_96_8 = arg_93_1:FormatText(var_96_7.content)

				arg_93_1.text_.text = var_96_8

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 7 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_8) / 7)

				if (7 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_8) / 7)) > 0 and var_96_6 < var_96_10 then
					arg_93_1.talkMaxDuration = var_96_10

					if var_96_10 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_5
					end
				end

				arg_93_1.text_.text = var_96_8
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041022", "story_v_out_424041.awb") ~= 0 then
					local var_96_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041022", "story_v_out_424041.awb") / 1000

					if var_96_11 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_11 + var_96_5
					end

					if var_96_7.prefab_name ~= "" and arg_93_1.actors_[var_96_7.prefab_name] ~= nil then
						local var_96_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_7.prefab_name].transform, "story_v_out_424041", "424041022", "story_v_out_424041.awb")

						arg_93_1:RecordAudio("424041022", var_96_12)
						arg_93_1:RecordAudio("424041022", var_96_12)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_424041", "424041022", "story_v_out_424041.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_424041", "424041022", "story_v_out_424041.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_13 = math.max(var_96_6, arg_93_1.talkMaxDuration)

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_13 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_5) / var_96_13

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_5 + var_96_13 and arg_93_1.time_ < var_96_5 + var_96_13 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play424041023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 424041023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play424041024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1094"]) and arg_97_1.var_.actorSpriteComps1094 == nil then
				arg_97_1.var_.actorSpriteComps1094 = arg_97_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_100_0 = 0.2

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1094"]) then
				if arg_97_1.var_.actorSpriteComps1094 then
					for iter_100_0, iter_100_1 in pairs(arg_97_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_100_1 then
							if arg_97_1.isInRecall_ then
								iter_100_1.color = Color.New(Mathf.Lerp(iter_100_1.color.r, arg_97_1.hightColor2.r, (arg_97_1.time_ - 0) / var_100_0), Mathf.Lerp(iter_100_1.color.g, arg_97_1.hightColor2.g, (arg_97_1.time_ - 0) / var_100_0), (Mathf.Lerp(iter_100_1.color.b, arg_97_1.hightColor2.b, (arg_97_1.time_ - 0) / var_100_0)))
							else
								local var_100_1 = Mathf.Lerp(iter_100_1.color.r, 0.5, (arg_97_1.time_ - 0) / var_100_0)

								iter_100_1.color = Color.New(var_100_1, var_100_1, var_100_1)
							end
						end
					end
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1094"]) and arg_97_1.var_.actorSpriteComps1094 then
				for iter_100_2, iter_100_3 in pairs(arg_97_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_100_3 then
						iter_100_3.color = arg_97_1.isInRecall_ and (arg_97_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_97_1.var_.actorSpriteComps1094 = nil
			end

			local var_100_2 = arg_97_1.actors_["1094"].transform

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos1094 = var_100_2.localPosition
				var_100_2.localScale = Vector3.New(1, 1, 1)

				arg_97_1:CheckSpriteTmpPos("1094", 7)

				for iter_100_4 = 0, var_100_2.childCount - 1 do
					local var_100_3 = var_100_2:GetChild(iter_100_4)

					if var_100_3.name == "" or not string.find(var_100_3.name, "split") then
						var_100_3.gameObject:SetActive(true)
					else
						var_100_3.gameObject:SetActive(false)
					end
				end
			end

			local var_100_4 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_4 then
				var_100_2.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_97_1.time_ - 0) / var_100_4)
			end

			if arg_97_1.time_ >= 0 + var_100_4 and arg_97_1.time_ < 0 + var_100_4 + arg_100_0 then
				var_100_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.034 < arg_97_1.time_ and arg_97_1.time_ <= 0.034 + arg_100_0 then
				arg_97_1:AudioAction("play", "effect", "se_story_146", "se_story_146_footstep_mud", "")
			end

			local var_100_6 = 0
			local var_100_7 = 0.675

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_8 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(424041023).content)

				arg_97_1.text_.text = var_100_8

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 27 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_8) / 27)

				if (27 <= 0 and var_100_7 or var_100_7 * (utf8.len(var_100_8) / 27)) > 0 and var_100_7 < var_100_10 then
					arg_97_1.talkMaxDuration = var_100_10

					if var_100_10 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_8
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_11 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_11 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_11

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_11 and arg_97_1.time_ < var_100_6 + var_100_11 + arg_100_0 then
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
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play424041024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 424041024
		arg_101_1.duration_ = 1.8

		local var_101_0 = {
			zh = 1.4,
			ja = 1.8
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
				arg_101_0:Play424041025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0.075

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1396].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10035_split_1")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_1 = arg_101_1:GetWordFromCfg(424041024)
				local var_104_2 = arg_101_1:FormatText(var_104_1.content)

				arg_101_1.text_.text = var_104_2

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_4 = 3 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 3)

				if (3 <= 0 and var_104_0 or var_104_0 * (utf8.len(var_104_2) / 3)) > 0 and var_104_0 < var_104_4 then
					arg_101_1.talkMaxDuration = var_104_4

					if var_104_4 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_4 + 0
					end
				end

				arg_101_1.text_.text = var_104_2
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041024", "story_v_out_424041.awb") ~= 0 then
					local var_104_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041024", "story_v_out_424041.awb") / 1000

					if var_104_5 + 0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_5 + 0
					end

					if var_104_1.prefab_name ~= "" and arg_101_1.actors_[var_104_1.prefab_name] ~= nil then
						local var_104_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_1.prefab_name].transform, "story_v_out_424041", "424041024", "story_v_out_424041.awb")

						arg_101_1:RecordAudio("424041024", var_104_6)
						arg_101_1:RecordAudio("424041024", var_104_6)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_424041", "424041024", "story_v_out_424041.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_424041", "424041024", "story_v_out_424041.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_7 = math.max(var_104_0, arg_101_1.talkMaxDuration)

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - 0) / var_104_7

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play424041025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 424041025
		arg_105_1.duration_ = 3.33

		local var_105_0 = {
			zh = 3.333,
			ja = 3.3
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
				arg_105_0:Play424041026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.375

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, true)
				arg_105_1.iconController_:SetSelectedState("hero")

				arg_105_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_105_1.callingController_:SetSelectedState("normal")

				arg_105_1.keyicon_.color = Color.New(1, 1, 1)
				arg_105_1.icon_.color = Color.New(1, 1, 1)

				local var_108_1 = arg_105_1:GetWordFromCfg(424041025)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 15 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 15)

				if (15 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 15)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041025", "story_v_out_424041.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041025", "story_v_out_424041.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_424041", "424041025", "story_v_out_424041.awb")

						arg_105_1:RecordAudio("424041025", var_108_6)
						arg_105_1:RecordAudio("424041025", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_424041", "424041025", "story_v_out_424041.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_424041", "424041025", "story_v_out_424041.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play424041026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 424041026
		arg_109_1.duration_ = 1.13

		local var_109_0 = {
			zh = 0.999999999999,
			ja = 1.133
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
				arg_109_0:Play424041027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1094"]) and arg_109_1.var_.actorSpriteComps1094 == nil then
				arg_109_1.var_.actorSpriteComps1094 = arg_109_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_0 = 0.2

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1094"]) then
				if arg_109_1.var_.actorSpriteComps1094 then
					for iter_112_0, iter_112_1 in pairs(arg_109_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_112_1 then
							if arg_109_1.isInRecall_ then
								iter_112_1.color = Color.New(Mathf.Lerp(iter_112_1.color.r, arg_109_1.hightColor1.r, (arg_109_1.time_ - 0) / var_112_0), Mathf.Lerp(iter_112_1.color.g, arg_109_1.hightColor1.g, (arg_109_1.time_ - 0) / var_112_0), (Mathf.Lerp(iter_112_1.color.b, arg_109_1.hightColor1.b, (arg_109_1.time_ - 0) / var_112_0)))
							else
								local var_112_1 = Mathf.Lerp(iter_112_1.color.r, 1, (arg_109_1.time_ - 0) / var_112_0)

								iter_112_1.color = Color.New(var_112_1, var_112_1, var_112_1)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1094"]) and arg_109_1.var_.actorSpriteComps1094 then
				for iter_112_2, iter_112_3 in pairs(arg_109_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_112_3 then
						iter_112_3.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_109_1.var_.actorSpriteComps1094 = nil
			end

			local var_112_2 = arg_109_1.actors_["1094"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1094 = var_112_2.localPosition
				var_112_2.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1094", 3)

				for iter_112_4 = 0, var_112_2.childCount - 1 do
					local var_112_3 = var_112_2:GetChild(iter_112_4)

					if var_112_3.name == "split_3" or not string.find(var_112_3.name, "split") then
						var_112_3.gameObject:SetActive(true)
					else
						var_112_3.gameObject:SetActive(false)
					end
				end
			end

			local var_112_4 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				var_112_2.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_109_1.time_ - 0) / var_112_4)
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				var_112_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_112_5 = 0
			local var_112_6 = 0.05

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_5 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_7 = arg_109_1:GetWordFromCfg(424041026)
				local var_112_8 = arg_109_1:FormatText(var_112_7.content)

				arg_109_1.text_.text = var_112_8

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_10 = 2 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_8) / 2)

				if (2 <= 0 and var_112_6 or var_112_6 * (utf8.len(var_112_8) / 2)) > 0 and var_112_6 < var_112_10 then
					arg_109_1.talkMaxDuration = var_112_10

					if var_112_10 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_5
					end
				end

				arg_109_1.text_.text = var_112_8
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041026", "story_v_out_424041.awb") ~= 0 then
					local var_112_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041026", "story_v_out_424041.awb") / 1000

					if var_112_11 + var_112_5 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_5
					end

					if var_112_7.prefab_name ~= "" and arg_109_1.actors_[var_112_7.prefab_name] ~= nil then
						local var_112_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_7.prefab_name].transform, "story_v_out_424041", "424041026", "story_v_out_424041.awb")

						arg_109_1:RecordAudio("424041026", var_112_12)
						arg_109_1:RecordAudio("424041026", var_112_12)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_424041", "424041026", "story_v_out_424041.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_424041", "424041026", "story_v_out_424041.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_13 = math.max(var_112_6, arg_109_1.talkMaxDuration)

			if var_112_5 <= arg_109_1.time_ and arg_109_1.time_ < var_112_5 + var_112_13 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_5) / var_112_13

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_5 + var_112_13 and arg_109_1.time_ < var_112_5 + var_112_13 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play424041027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 424041027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play424041028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1094"]) and arg_113_1.var_.actorSpriteComps1094 == nil then
				arg_113_1.var_.actorSpriteComps1094 = arg_113_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_116_0 = 0.2

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1094"]) then
				if arg_113_1.var_.actorSpriteComps1094 then
					for iter_116_0, iter_116_1 in pairs(arg_113_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_116_1 then
							if arg_113_1.isInRecall_ then
								iter_116_1.color = Color.New(Mathf.Lerp(iter_116_1.color.r, arg_113_1.hightColor2.r, (arg_113_1.time_ - 0) / var_116_0), Mathf.Lerp(iter_116_1.color.g, arg_113_1.hightColor2.g, (arg_113_1.time_ - 0) / var_116_0), (Mathf.Lerp(iter_116_1.color.b, arg_113_1.hightColor2.b, (arg_113_1.time_ - 0) / var_116_0)))
							else
								local var_116_1 = Mathf.Lerp(iter_116_1.color.r, 0.5, (arg_113_1.time_ - 0) / var_116_0)

								iter_116_1.color = Color.New(var_116_1, var_116_1, var_116_1)
							end
						end
					end
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1094"]) and arg_113_1.var_.actorSpriteComps1094 then
				for iter_116_2, iter_116_3 in pairs(arg_113_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_116_3 then
						iter_116_3.color = arg_113_1.isInRecall_ and (arg_113_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_113_1.var_.actorSpriteComps1094 = nil
			end

			local var_116_2 = arg_113_1.actors_["1094"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1094 = var_116_2.localPosition
				var_116_2.localScale = Vector3.New(1, 1, 1)

				arg_113_1:CheckSpriteTmpPos("1094", 7)

				for iter_116_4 = 0, var_116_2.childCount - 1 do
					local var_116_3 = var_116_2:GetChild(iter_116_4)

					if var_116_3.name == "" or not string.find(var_116_3.name, "split") then
						var_116_3.gameObject:SetActive(true)
					else
						var_116_3.gameObject:SetActive(false)
					end
				end
			end

			local var_116_4 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				var_116_2.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_113_1.time_ - 0) / var_116_4)
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				var_116_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.6 < arg_113_1.time_ and arg_113_1.time_ <= 0.6 + arg_116_0 then
				arg_113_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun03", "")
			end

			local var_116_6 = 0
			local var_116_7 = 1

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_8 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(424041027).content)

				arg_113_1.text_.text = var_116_8

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_10 = 40 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_8) / 40)

				if (40 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_8) / 40)) > 0 and var_116_7 < var_116_10 then
					arg_113_1.talkMaxDuration = var_116_10

					if var_116_10 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_8
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_11 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_11 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_11

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_11 and arg_113_1.time_ < var_116_6 + var_116_11 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
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

		arg_113_1:InitPlayNodeList()
	end,
	Play424041028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 424041028
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play424041029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0.034 < arg_117_1.time_ and arg_117_1.time_ <= 0.034 + arg_120_0 then
				arg_117_1:AudioAction("play", "effect", "se_story_146", "se_story_146_gun_firearm", "")
			end

			local var_120_1 = 0
			local var_120_2 = 1.075

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_3 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_3:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_4 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(424041028).content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_6 = 43 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_4) / 43)

				if (43 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_4) / 43)) > 0 and var_120_2 < var_120_6 then
					arg_117_1.talkMaxDuration = var_120_6
					var_120_1 = var_120_1 + 0.3

					if var_120_6 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_6 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = var_120_1 + 0.3
			local var_120_8 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_7 + var_120_8 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_7) / var_120_8

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_7 + var_120_8 and arg_117_1.time_ < var_120_7 + var_120_8 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play424041029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 424041029
		arg_123_1.duration_ = 2.33

		local var_123_0 = {
			zh = 1.633,
			ja = 2.333
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
				arg_123_0:Play424041030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.2

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_1 = arg_123_1:GetWordFromCfg(424041029)
				local var_126_2 = arg_123_1:FormatText(var_126_1.content)

				arg_123_1.text_.text = var_126_2

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 8 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 8)

				if (8 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_2) / 8)) > 0 and var_126_0 < var_126_4 then
					arg_123_1.talkMaxDuration = var_126_4

					if var_126_4 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_4 + 0
					end
				end

				arg_123_1.text_.text = var_126_2
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041029", "story_v_out_424041.awb") ~= 0 then
					local var_126_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041029", "story_v_out_424041.awb") / 1000

					if var_126_5 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_5 + 0
					end

					if var_126_1.prefab_name ~= "" and arg_123_1.actors_[var_126_1.prefab_name] ~= nil then
						local var_126_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_1.prefab_name].transform, "story_v_out_424041", "424041029", "story_v_out_424041.awb")

						arg_123_1:RecordAudio("424041029", var_126_6)
						arg_123_1:RecordAudio("424041029", var_126_6)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_424041", "424041029", "story_v_out_424041.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_424041", "424041029", "story_v_out_424041.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play424041030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 424041030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play424041031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0.775

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(424041030).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 31 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 31)

				if (31 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 31)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play424041031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 424041031
		arg_131_1.duration_ = 1.53

		local var_131_0 = {
			zh = 1.533,
			ja = 1.366
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
				arg_131_0:Play424041032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1094"]) and arg_131_1.var_.actorSpriteComps1094 == nil then
				arg_131_1.var_.actorSpriteComps1094 = arg_131_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_0 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1094"]) then
				if arg_131_1.var_.actorSpriteComps1094 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_134_1 then
							if arg_131_1.isInRecall_ then
								iter_134_1.color = Color.New(Mathf.Lerp(iter_134_1.color.r, arg_131_1.hightColor1.r, (arg_131_1.time_ - 0) / var_134_0), Mathf.Lerp(iter_134_1.color.g, arg_131_1.hightColor1.g, (arg_131_1.time_ - 0) / var_134_0), (Mathf.Lerp(iter_134_1.color.b, arg_131_1.hightColor1.b, (arg_131_1.time_ - 0) / var_134_0)))
							else
								local var_134_1 = Mathf.Lerp(iter_134_1.color.r, 1, (arg_131_1.time_ - 0) / var_134_0)

								iter_134_1.color = Color.New(var_134_1, var_134_1, var_134_1)
							end
						end
					end
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1094"]) and arg_131_1.var_.actorSpriteComps1094 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_134_3 then
						iter_134_3.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_131_1.var_.actorSpriteComps1094 = nil
			end

			local var_134_2 = arg_131_1.actors_["1094"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1094 = var_134_2.localPosition
				var_134_2.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("1094", 3)

				for iter_134_4 = 0, var_134_2.childCount - 1 do
					local var_134_3 = var_134_2:GetChild(iter_134_4)

					if var_134_3.name == "split_4" or not string.find(var_134_3.name, "split") then
						var_134_3.gameObject:SetActive(true)
					else
						var_134_3.gameObject:SetActive(false)
					end
				end
			end

			local var_134_4 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				var_134_2.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_131_1.time_ - 0) / var_134_4)
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				var_134_2.localPosition = Vector3.New(0, -335, -230)
			end

			local var_134_5 = 0
			local var_134_6 = 0.1

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_5 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_7 = arg_131_1:GetWordFromCfg(424041031)
				local var_134_8 = arg_131_1:FormatText(var_134_7.content)

				arg_131_1.text_.text = var_134_8

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_10 = 4 <= 0 and var_134_6 or var_134_6 * (utf8.len(var_134_8) / 4)

				if (4 <= 0 and var_134_6 or var_134_6 * (utf8.len(var_134_8) / 4)) > 0 and var_134_6 < var_134_10 then
					arg_131_1.talkMaxDuration = var_134_10

					if var_134_10 + var_134_5 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_5
					end
				end

				arg_131_1.text_.text = var_134_8
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041031", "story_v_out_424041.awb") ~= 0 then
					local var_134_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041031", "story_v_out_424041.awb") / 1000

					if var_134_11 + var_134_5 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_11 + var_134_5
					end

					if var_134_7.prefab_name ~= "" and arg_131_1.actors_[var_134_7.prefab_name] ~= nil then
						local var_134_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_7.prefab_name].transform, "story_v_out_424041", "424041031", "story_v_out_424041.awb")

						arg_131_1:RecordAudio("424041031", var_134_12)
						arg_131_1:RecordAudio("424041031", var_134_12)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_424041", "424041031", "story_v_out_424041.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_424041", "424041031", "story_v_out_424041.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_13 = math.max(var_134_6, arg_131_1.talkMaxDuration)

			if var_134_5 <= arg_131_1.time_ and arg_131_1.time_ < var_134_5 + var_134_13 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_5) / var_134_13

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_5 + var_134_13 and arg_131_1.time_ < var_134_5 + var_134_13 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play424041032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 424041032
		arg_135_1.duration_ = 5.67

		local var_135_0 = {
			zh = 5.4,
			ja = 5.666
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
				arg_135_0:Play424041033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1094"]) and arg_135_1.var_.actorSpriteComps1094 == nil then
				arg_135_1.var_.actorSpriteComps1094 = arg_135_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1094"]) then
				if arg_135_1.var_.actorSpriteComps1094 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								iter_138_1.color = Color.New(Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_0), Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_0), (Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_0)))
							else
								local var_138_1 = Mathf.Lerp(iter_138_1.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_0)

								iter_138_1.color = Color.New(var_138_1, var_138_1, var_138_1)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1094"]) and arg_135_1.var_.actorSpriteComps1094 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps1094 = nil
			end

			local var_138_2 = 0
			local var_138_3 = 0.65

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_4 = arg_135_1:GetWordFromCfg(424041032)
				local var_138_5 = arg_135_1:FormatText(var_138_4.content)

				arg_135_1.text_.text = var_138_5

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_7 = 26 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_5) / 26)

				if (26 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_5) / 26)) > 0 and var_138_3 < var_138_7 then
					arg_135_1.talkMaxDuration = var_138_7

					if var_138_7 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_7 + var_138_2
					end
				end

				arg_135_1.text_.text = var_138_5
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041032", "story_v_out_424041.awb") ~= 0 then
					local var_138_8 = manager.audio:GetVoiceLength("story_v_out_424041", "424041032", "story_v_out_424041.awb") / 1000

					if var_138_8 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_2
					end

					if var_138_4.prefab_name ~= "" and arg_135_1.actors_[var_138_4.prefab_name] ~= nil then
						local var_138_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_4.prefab_name].transform, "story_v_out_424041", "424041032", "story_v_out_424041.awb")

						arg_135_1:RecordAudio("424041032", var_138_9)
						arg_135_1:RecordAudio("424041032", var_138_9)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_424041", "424041032", "story_v_out_424041.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_424041", "424041032", "story_v_out_424041.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_10 = math.max(var_138_3, arg_135_1.talkMaxDuration)

			if var_138_2 <= arg_135_1.time_ and arg_135_1.time_ < var_138_2 + var_138_10 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_2) / var_138_10

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_2 + var_138_10 and arg_135_1.time_ < var_138_2 + var_138_10 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play424041033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 424041033
		arg_139_1.duration_ = 1.7

		local var_139_0 = {
			zh = 1.566,
			ja = 1.7
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
				arg_139_0:Play424041034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1094"]) and arg_139_1.var_.actorSpriteComps1094 == nil then
				arg_139_1.var_.actorSpriteComps1094 = arg_139_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1094"]) then
				if arg_139_1.var_.actorSpriteComps1094 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_142_1 then
							if arg_139_1.isInRecall_ then
								iter_142_1.color = Color.New(Mathf.Lerp(iter_142_1.color.r, arg_139_1.hightColor1.r, (arg_139_1.time_ - 0) / var_142_0), Mathf.Lerp(iter_142_1.color.g, arg_139_1.hightColor1.g, (arg_139_1.time_ - 0) / var_142_0), (Mathf.Lerp(iter_142_1.color.b, arg_139_1.hightColor1.b, (arg_139_1.time_ - 0) / var_142_0)))
							else
								local var_142_1 = Mathf.Lerp(iter_142_1.color.r, 1, (arg_139_1.time_ - 0) / var_142_0)

								iter_142_1.color = Color.New(var_142_1, var_142_1, var_142_1)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1094"]) and arg_139_1.var_.actorSpriteComps1094 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps1094 = nil
			end

			local var_142_2 = arg_139_1.actors_["1094"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1094 = var_142_2.localPosition
				var_142_2.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("1094", 3)

				for iter_142_4 = 0, var_142_2.childCount - 1 do
					local var_142_3 = var_142_2:GetChild(iter_142_4)

					if var_142_3.name == "split_3" then
						var_142_3:SetAsLastSibling()
						var_142_3.gameObject:SetActive(true)

						arg_139_1.var_.actorSpriteSplit1094 = var_142_3.gameObject:GetComponent(typeof(Image))

						arg_139_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_142_4 = 0.5

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_4 then
				var_142_2.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_139_1.time_ - 0) / var_142_4)

				if arg_139_1.var_.actorSpriteSplit1094 ~= nil then
					arg_139_1.var_.actorSpriteSplit1094:SetAlpha((arg_139_1.time_ - 0) / var_142_4)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_4 and arg_139_1.time_ < 0 + var_142_4 + arg_142_0 then
				var_142_2.localPosition = Vector3.New(0, -335, -230)

				if arg_139_1.var_.actorSpriteSplit1094 ~= nil then
					arg_139_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_142_5 = 0
			local var_142_6 = 0.125

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_7 = arg_139_1:GetWordFromCfg(424041033)
				local var_142_8 = arg_139_1:FormatText(var_142_7.content)

				arg_139_1.text_.text = var_142_8

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_10 = 5 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_8) / 5)

				if (5 <= 0 and var_142_6 or var_142_6 * (utf8.len(var_142_8) / 5)) > 0 and var_142_6 < var_142_10 then
					arg_139_1.talkMaxDuration = var_142_10

					if var_142_10 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_5
					end
				end

				arg_139_1.text_.text = var_142_8
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041033", "story_v_out_424041.awb") ~= 0 then
					local var_142_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041033", "story_v_out_424041.awb") / 1000

					if var_142_11 + var_142_5 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_11 + var_142_5
					end

					if var_142_7.prefab_name ~= "" and arg_139_1.actors_[var_142_7.prefab_name] ~= nil then
						local var_142_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_7.prefab_name].transform, "story_v_out_424041", "424041033", "story_v_out_424041.awb")

						arg_139_1:RecordAudio("424041033", var_142_12)
						arg_139_1:RecordAudio("424041033", var_142_12)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_424041", "424041033", "story_v_out_424041.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_424041", "424041033", "story_v_out_424041.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_13 = math.max(var_142_6, arg_139_1.talkMaxDuration)

			if var_142_5 <= arg_139_1.time_ and arg_139_1.time_ < var_142_5 + var_142_13 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_5) / var_142_13

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_5 + var_142_13 and arg_139_1.time_ < var_142_5 + var_142_13 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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

		arg_139_1:InitPlayNodeList()
	end,
	Play424041034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 424041034
		arg_143_1.duration_ = 9.4

		local var_143_0 = {
			zh = 6.433,
			ja = 9.4
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
				arg_143_0:Play424041035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1094"]) and arg_143_1.var_.actorSpriteComps1094 == nil then
				arg_143_1.var_.actorSpriteComps1094 = arg_143_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_146_0 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1094"]) then
				if arg_143_1.var_.actorSpriteComps1094 then
					for iter_146_0, iter_146_1 in pairs(arg_143_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_146_1 then
							if arg_143_1.isInRecall_ then
								iter_146_1.color = Color.New(Mathf.Lerp(iter_146_1.color.r, arg_143_1.hightColor2.r, (arg_143_1.time_ - 0) / var_146_0), Mathf.Lerp(iter_146_1.color.g, arg_143_1.hightColor2.g, (arg_143_1.time_ - 0) / var_146_0), (Mathf.Lerp(iter_146_1.color.b, arg_143_1.hightColor2.b, (arg_143_1.time_ - 0) / var_146_0)))
							else
								local var_146_1 = Mathf.Lerp(iter_146_1.color.r, 0.5, (arg_143_1.time_ - 0) / var_146_0)

								iter_146_1.color = Color.New(var_146_1, var_146_1, var_146_1)
							end
						end
					end
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1094"]) and arg_143_1.var_.actorSpriteComps1094 then
				for iter_146_2, iter_146_3 in pairs(arg_143_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_146_3 then
						iter_146_3.color = arg_143_1.isInRecall_ and (arg_143_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_143_1.var_.actorSpriteComps1094 = nil
			end

			local var_146_2 = 0
			local var_146_3 = 0.825

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_4 = arg_143_1:GetWordFromCfg(424041034)
				local var_146_5 = arg_143_1:FormatText(var_146_4.content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 33 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 33)

				if (33 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 33)) > 0 and var_146_3 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_2
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041034", "story_v_out_424041.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_424041", "424041034", "story_v_out_424041.awb") / 1000

					if var_146_8 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_2
					end

					if var_146_4.prefab_name ~= "" and arg_143_1.actors_[var_146_4.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_4.prefab_name].transform, "story_v_out_424041", "424041034", "story_v_out_424041.awb")

						arg_143_1:RecordAudio("424041034", var_146_9)
						arg_143_1:RecordAudio("424041034", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_424041", "424041034", "story_v_out_424041.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_424041", "424041034", "story_v_out_424041.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_10 = math.max(var_146_3, arg_143_1.talkMaxDuration)

			if var_146_2 <= arg_143_1.time_ and arg_143_1.time_ < var_146_2 + var_146_10 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_2) / var_146_10

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_2 + var_146_10 and arg_143_1.time_ < var_146_2 + var_146_10 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play424041035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 424041035
		arg_147_1.duration_ = 1.03

		local var_147_0 = {
			zh = 0.999999999999,
			ja = 1.033
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
				arg_147_0:Play424041036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1094"]) and arg_147_1.var_.actorSpriteComps1094 == nil then
				arg_147_1.var_.actorSpriteComps1094 = arg_147_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_150_0 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1094"]) then
				if arg_147_1.var_.actorSpriteComps1094 then
					for iter_150_0, iter_150_1 in pairs(arg_147_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1094"]) and arg_147_1.var_.actorSpriteComps1094 then
				for iter_150_2, iter_150_3 in pairs(arg_147_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_150_3 then
						iter_150_3.color = arg_147_1.isInRecall_ and (arg_147_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_147_1.var_.actorSpriteComps1094 = nil
			end

			local var_150_2 = arg_147_1.actors_["1094"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1094 = var_150_2.localPosition
				var_150_2.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("1094", 3)

				for iter_150_4 = 0, var_150_2.childCount - 1 do
					local var_150_3 = var_150_2:GetChild(iter_150_4)

					if var_150_3.name == "split_1" then
						var_150_3:SetAsLastSibling()
						var_150_3.gameObject:SetActive(true)

						arg_147_1.var_.actorSpriteSplit1094 = var_150_3.gameObject:GetComponent(typeof(Image))

						arg_147_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_150_4 = 0.5

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_4 then
				var_150_2.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_147_1.time_ - 0) / var_150_4)

				if arg_147_1.var_.actorSpriteSplit1094 ~= nil then
					arg_147_1.var_.actorSpriteSplit1094:SetAlpha((arg_147_1.time_ - 0) / var_150_4)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_4 and arg_147_1.time_ < 0 + var_150_4 + arg_150_0 then
				var_150_2.localPosition = Vector3.New(0, -335, -230)

				if arg_147_1.var_.actorSpriteSplit1094 ~= nil then
					arg_147_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_150_5 = 0
			local var_150_6 = 0.05

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_5 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_7 = arg_147_1:GetWordFromCfg(424041035)
				local var_150_8 = arg_147_1:FormatText(var_150_7.content)

				arg_147_1.text_.text = var_150_8

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_10 = 2 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_8) / 2)

				if (2 <= 0 and var_150_6 or var_150_6 * (utf8.len(var_150_8) / 2)) > 0 and var_150_6 < var_150_10 then
					arg_147_1.talkMaxDuration = var_150_10

					if var_150_10 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_5
					end
				end

				arg_147_1.text_.text = var_150_8
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041035", "story_v_out_424041.awb") ~= 0 then
					local var_150_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041035", "story_v_out_424041.awb") / 1000

					if var_150_11 + var_150_5 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_11 + var_150_5
					end

					if var_150_7.prefab_name ~= "" and arg_147_1.actors_[var_150_7.prefab_name] ~= nil then
						local var_150_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_7.prefab_name].transform, "story_v_out_424041", "424041035", "story_v_out_424041.awb")

						arg_147_1:RecordAudio("424041035", var_150_12)
						arg_147_1:RecordAudio("424041035", var_150_12)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_424041", "424041035", "story_v_out_424041.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_424041", "424041035", "story_v_out_424041.awb")
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

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play424041036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 424041036
		arg_151_1.duration_ = 9.37

		local var_151_0 = {
			zh = 7.9,
			ja = 9.366
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
				arg_151_0:Play424041037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if arg_151_1.bgs_.ST0116 == nil then
				local var_154_0 = Object.Instantiate(arg_151_1.paintGo_)

				var_154_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0116")
				var_154_0.name = "ST0116"
				var_154_0.transform.parent = arg_151_1.stage_.transform
				var_154_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_151_1.bgs_.ST0116 = var_154_0
			end

			if 2 < arg_151_1.time_ and arg_151_1.time_ <= 2 + arg_154_0 then
				local var_154_1 = arg_151_1.bgs_.ST0116

				arg_151_1.bgs_.ST0116.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_154_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_154_2 = var_154_1:GetComponent("SpriteRenderer")

				if var_154_2 and var_154_2.sprite then
					local var_154_3 = 2 * (var_154_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_154_1.transform.localScale = Vector3.New(var_154_3 / var_154_2.sprite.bounds.size.y < var_154_3 * manager.ui.mainCameraCom_.aspect / var_154_2.sprite.bounds.size.x and var_154_3 * manager.ui.mainCameraCom_.aspect / var_154_2.sprite.bounds.size.x or var_154_3 / var_154_2.sprite.bounds.size.y, var_154_3 / var_154_2.sprite.bounds.size.y < var_154_3 * manager.ui.mainCameraCom_.aspect / var_154_2.sprite.bounds.size.x and var_154_3 * manager.ui.mainCameraCom_.aspect / var_154_2.sprite.bounds.size.x or var_154_3 / var_154_2.sprite.bounds.size.y, 0)
				end

				for iter_154_0, iter_154_1 in pairs(arg_151_1.bgs_) do
					if iter_154_0 ~= "ST0116" then
						iter_154_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_154_4 = 3.999999999999

			if 3.999999999999 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.allBtn_.enabled = false
			end

			if arg_151_1.time_ >= var_154_4 + 0.3 and arg_151_1.time_ < var_154_4 + 0.3 + arg_154_0 then
				arg_151_1.allBtn_.enabled = true
			end

			local var_154_5 = 0

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_6 = 2

			if var_154_5 <= arg_151_1.time_ and arg_151_1.time_ < var_154_5 + var_154_6 then
				local var_154_7 = Color.New(0, 0, 0)

				var_154_7.a = Mathf.Lerp(0, 1, (arg_151_1.time_ - var_154_5) / var_154_6)
				arg_151_1.mask_.color = var_154_7
			end

			if arg_151_1.time_ >= var_154_5 + var_154_6 and arg_151_1.time_ < var_154_5 + var_154_6 + arg_154_0 then
				local var_154_8 = Color.New(0, 0, 0)

				var_154_8.a = 1
				arg_151_1.mask_.color = var_154_8
			end

			local var_154_9 = 2

			if 2 < arg_151_1.time_ and arg_151_1.time_ <= var_154_9 + arg_154_0 then
				arg_151_1.mask_.enabled = true
				arg_151_1.mask_.raycastTarget = true

				arg_151_1:SetGaussion(false)
			end

			local var_154_10 = 2

			if var_154_9 <= arg_151_1.time_ and arg_151_1.time_ < var_154_9 + var_154_10 then
				local var_154_11 = Color.New(0, 0, 0)

				var_154_11.a = Mathf.Lerp(1, 0, (arg_151_1.time_ - var_154_9) / var_154_10)
				arg_151_1.mask_.color = var_154_11
			end

			if arg_151_1.time_ >= var_154_9 + var_154_10 and arg_151_1.time_ < var_154_9 + var_154_10 + arg_154_0 then
				local var_154_12 = Color.New(0, 0, 0)

				arg_151_1.mask_.enabled = false
				var_154_12.a = 0
				arg_151_1.mask_.color = var_154_12
			end

			local var_154_13 = arg_151_1.actors_["1094"]

			if 1.98333333333333 < arg_151_1.time_ and arg_151_1.time_ <= 1.98333333333333 + arg_154_0 and not isNil(var_154_13) and arg_151_1.var_.actorSpriteComps1094 == nil then
				arg_151_1.var_.actorSpriteComps1094 = var_154_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_154_14 = 0.0166666666666667

			if 1.98333333333333 <= arg_151_1.time_ and arg_151_1.time_ < 1.98333333333333 + var_154_14 and not isNil(var_154_13) then
				if arg_151_1.var_.actorSpriteComps1094 then
					for iter_154_2, iter_154_3 in pairs(arg_151_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_154_3 then
							if arg_151_1.isInRecall_ then
								iter_154_3.color = Color.New(Mathf.Lerp(iter_154_3.color.r, arg_151_1.hightColor2.r, (arg_151_1.time_ - 1.98333333333333) / var_154_14), Mathf.Lerp(iter_154_3.color.g, arg_151_1.hightColor2.g, (arg_151_1.time_ - 1.98333333333333) / var_154_14), (Mathf.Lerp(iter_154_3.color.b, arg_151_1.hightColor2.b, (arg_151_1.time_ - 1.98333333333333) / var_154_14)))
							else
								local var_154_15 = Mathf.Lerp(iter_154_3.color.r, 0.5, (arg_151_1.time_ - 1.98333333333333) / var_154_14)

								iter_154_3.color = Color.New(var_154_15, var_154_15, var_154_15)
							end
						end
					end
				end
			end

			if arg_151_1.time_ >= 1.98333333333333 + var_154_14 and arg_151_1.time_ < 1.98333333333333 + var_154_14 + arg_154_0 and not isNil(var_154_13) and arg_151_1.var_.actorSpriteComps1094 then
				for iter_154_4, iter_154_5 in pairs(arg_151_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_154_5 then
						iter_154_5.color = arg_151_1.isInRecall_ and (arg_151_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_151_1.var_.actorSpriteComps1094 = nil
			end

			local var_154_16 = arg_151_1.actors_["1094"].transform

			if 1.966 < arg_151_1.time_ and arg_151_1.time_ <= 1.966 + arg_154_0 then
				arg_151_1.var_.moveOldPos1094 = var_154_16.localPosition
				var_154_16.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("1094", 7)

				for iter_154_6 = 0, var_154_16.childCount - 1 do
					local var_154_17 = var_154_16:GetChild(iter_154_6)

					if var_154_17.name == "" or not string.find(var_154_17.name, "split") then
						var_154_17.gameObject:SetActive(true)
					else
						var_154_17.gameObject:SetActive(false)
					end
				end
			end

			local var_154_18 = 0.001

			if 1.966 <= arg_151_1.time_ and arg_151_1.time_ < 1.966 + var_154_18 then
				var_154_16.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_151_1.time_ - 1.966) / var_154_18)
			end

			if arg_151_1.time_ >= 1.966 + var_154_18 and arg_151_1.time_ < 1.966 + var_154_18 + arg_154_0 then
				var_154_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_154_19 = "1047"

			if arg_151_1.actors_["1047"] == nil then
				local var_154_20 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1047")

				if not isNil(var_154_20) then
					local var_154_21 = Object.Instantiate(var_154_20, arg_151_1.canvasGo_.transform)

					var_154_21.transform:SetSiblingIndex(1)

					var_154_21.name = var_154_19
					var_154_21.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_151_1.actors_[var_154_19] = var_154_21

					if arg_151_1.isInRecall_ then
						for iter_154_7, iter_154_8 in ipairs((var_154_21:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_154_8.color = arg_151_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_154_22 = arg_151_1.actors_["1047"].transform

			if 3.8 < arg_151_1.time_ and arg_151_1.time_ <= 3.8 + arg_154_0 then
				arg_151_1.var_.moveOldPos1047 = var_154_22.localPosition
				var_154_22.localScale = Vector3.New(1, 1, 1)

				arg_151_1:CheckSpriteTmpPos("1047", 3)

				for iter_154_9 = 0, var_154_22.childCount - 1 do
					local var_154_23 = var_154_22:GetChild(iter_154_9)

					if var_154_23.name == "split_7" or not string.find(var_154_23.name, "split") then
						var_154_23.gameObject:SetActive(true)
					else
						var_154_23.gameObject:SetActive(false)
					end
				end
			end

			local var_154_24 = 0.001

			if 3.8 <= arg_151_1.time_ and arg_151_1.time_ < 3.8 + var_154_24 then
				var_154_22.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_151_1.time_ - 3.8) / var_154_24)
			end

			if arg_151_1.time_ >= 3.8 + var_154_24 and arg_151_1.time_ < 3.8 + var_154_24 + arg_154_0 then
				var_154_22.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			if 3.8 < arg_151_1.time_ and arg_151_1.time_ <= 3.8 + arg_154_0 then
				local var_154_25 = arg_151_1.actors_["1047"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_154_25 then
					arg_151_1.var_.alphaOldValue1047 = var_154_25.alpha
					arg_151_1.var_.characterEffect1047 = var_154_25
				end
			end

			local var_154_26 = 0.1

			if 3.8 <= arg_151_1.time_ and arg_151_1.time_ < 3.8 + var_154_26 then
				if arg_151_1.var_.characterEffect1047 then
					arg_151_1.var_.characterEffect1047.alpha = Mathf.Lerp(arg_151_1.var_.alphaOldValue1047, 0.6, (arg_151_1.time_ - 3.8) / var_154_26)
				end
			end

			if arg_151_1.time_ >= 3.8 + var_154_26 and arg_151_1.time_ < 3.8 + var_154_26 + arg_154_0 and arg_151_1.var_.characterEffect1047 then
				arg_151_1.var_.characterEffect1047.alpha = 0.6
			end

			if 3.8 < arg_151_1.time_ and arg_151_1.time_ <= 3.8 + arg_154_0 then
				arg_151_1:SetSpriteNiuquEffect("1047", true)
			end

			if 2 < arg_151_1.time_ and arg_151_1.time_ <= 2 + arg_154_0 then
				if arg_151_1.var_.effectmiwu4602 then
					Object.Destroy(arg_151_1.var_.effectmiwu4602)

					arg_151_1.var_.effectmiwu4602 = nil
				end
			end

			if 0.133333333333333 < arg_151_1.time_ and arg_151_1.time_ <= 0.133333333333333 + arg_154_0 then
				arg_151_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if arg_151_1.frameCnt_ <= 1 then
				arg_151_1.dialog_:SetActive(false)
			end

			local var_154_30 = 4
			local var_154_31 = 0.4

			if 4 < arg_151_1.time_ and arg_151_1.time_ <= var_154_30 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0

				arg_151_1.dialog_:SetActive(true)

				arg_151_1.dialogCg_.alpha = 0

				local var_154_32 = LeanTween.value(arg_151_1.dialog_, 0, 1, 0.3)

				var_154_32:setOnUpdate(LuaHelper.FloatAction(function(arg_155_0)
					arg_151_1.dialogCg_.alpha = arg_155_0
				end))
				var_154_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_151_1.dialog_)
					var_154_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_151_1.duration_ = arg_151_1.duration_ + 0.3

				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_33 = arg_151_1:GetWordFromCfg(424041036)
				local var_154_34 = arg_151_1:FormatText(var_154_33.content)

				arg_151_1.text_.text = var_154_34

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_36 = 16 <= 0 and var_154_31 or var_154_31 * (utf8.len(var_154_34) / 16)

				if (16 <= 0 and var_154_31 or var_154_31 * (utf8.len(var_154_34) / 16)) > 0 and var_154_31 < var_154_36 then
					arg_151_1.talkMaxDuration = var_154_36
					var_154_30 = var_154_30 + 0.3

					if var_154_36 + var_154_30 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_36 + var_154_30
					end
				end

				arg_151_1.text_.text = var_154_34
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041036", "story_v_out_424041.awb") ~= 0 then
					local var_154_37 = manager.audio:GetVoiceLength("story_v_out_424041", "424041036", "story_v_out_424041.awb") / 1000

					if var_154_37 + var_154_30 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_37 + var_154_30
					end

					if var_154_33.prefab_name ~= "" and arg_151_1.actors_[var_154_33.prefab_name] ~= nil then
						local var_154_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_33.prefab_name].transform, "story_v_out_424041", "424041036", "story_v_out_424041.awb")

						arg_151_1:RecordAudio("424041036", var_154_38)
						arg_151_1:RecordAudio("424041036", var_154_38)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_424041", "424041036", "story_v_out_424041.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_424041", "424041036", "story_v_out_424041.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_39 = var_154_30 + 0.3
			local var_154_40 = math.max(var_154_31, arg_151_1.talkMaxDuration)

			if var_154_30 + 0.3 <= arg_151_1.time_ and arg_151_1.time_ < var_154_39 + var_154_40 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_39) / var_154_40

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_39 + var_154_40 and arg_151_1.time_ < var_154_39 + var_154_40 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play424041037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 424041037
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play424041038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0.325

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, true)
				arg_157_1.iconController_:SetSelectedState("hero")

				arg_157_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_157_1.callingController_:SetSelectedState("normal")

				arg_157_1.keyicon_.color = Color.New(1, 1, 1)
				arg_157_1.icon_.color = Color.New(1, 1, 1)

				local var_160_1 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(424041037).content)

				arg_157_1.text_.text = var_160_1

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_3 = 13 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 13)

				if (13 <= 0 and var_160_0 or var_160_0 * (utf8.len(var_160_1) / 13)) > 0 and var_160_0 < var_160_3 then
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
	Play424041038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 424041038
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play424041039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1047 = arg_161_1.actors_["1047"].transform.localPosition
				arg_161_1.actors_["1047"].transform.localScale = Vector3.New(1, 1, 1)

				arg_161_1:CheckSpriteTmpPos("1047", 7)

				for iter_164_0 = 0, arg_161_1.actors_["1047"].transform.childCount - 1 do
					local var_164_0 = arg_161_1.actors_["1047"].transform:GetChild(iter_164_0)

					if var_164_0.name == "" or not string.find(var_164_0.name, "split") then
						var_164_0.gameObject:SetActive(true)
					else
						var_164_0.gameObject:SetActive(false)
					end
				end
			end

			local var_164_1 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 then
				arg_161_1.actors_["1047"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1047, Vector3.New(0, -2000, 0), (arg_161_1.time_ - 0) / var_164_1)
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 then
				arg_161_1.actors_["1047"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.034 < arg_161_1.time_ and arg_161_1.time_ <= 0.034 + arg_164_0 then
				arg_161_1:AudioAction("play", "effect", "se_story_146", "se_story_146_car", "")
			end

			local var_164_3 = 0
			local var_164_4 = 1.2

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_5 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(424041038).content)

				arg_161_1.text_.text = var_164_5

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_7 = 48 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_5) / 48)

				if (48 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_5) / 48)) > 0 and var_164_4 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_3 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_3
					end
				end

				arg_161_1.text_.text = var_164_5
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_4, arg_161_1.talkMaxDuration)

			if var_164_3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_3 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_3) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_3 + var_164_8 and arg_161_1.time_ < var_164_3 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
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

		arg_161_1:InitPlayNodeList()
	end,
	Play424041039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 424041039
		arg_165_1.duration_ = 7.67

		local var_165_0 = {
			zh = 4.633,
			ja = 7.666
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
				arg_165_0:Play424041040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1047 = arg_165_1.actors_["1047"].transform.localPosition
				arg_165_1.actors_["1047"].transform.localScale = Vector3.New(1, 1, 1)

				arg_165_1:CheckSpriteTmpPos("1047", 3)

				for iter_168_0 = 0, arg_165_1.actors_["1047"].transform.childCount - 1 do
					local var_168_0 = arg_165_1.actors_["1047"].transform:GetChild(iter_168_0)

					if var_168_0.name == "" or not string.find(var_168_0.name, "split") then
						var_168_0.gameObject:SetActive(true)
					else
						var_168_0.gameObject:SetActive(false)
					end
				end
			end

			local var_168_1 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_1 then
				arg_165_1.actors_["1047"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_165_1.time_ - 0) / var_168_1)
			end

			if arg_165_1.time_ >= 0 + var_168_1 and arg_165_1.time_ < 0 + var_168_1 + arg_168_0 then
				arg_165_1.actors_["1047"].transform.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_168_2 = 0
			local var_168_3 = 0.55

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_2 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_4 = arg_165_1:GetWordFromCfg(424041039)
				local var_168_5 = arg_165_1:FormatText(var_168_4.content)

				arg_165_1.text_.text = var_168_5

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_7 = 22 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_5) / 22)

				if (22 <= 0 and var_168_3 or var_168_3 * (utf8.len(var_168_5) / 22)) > 0 and var_168_3 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_2 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_2
					end
				end

				arg_165_1.text_.text = var_168_5
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041039", "story_v_out_424041.awb") ~= 0 then
					local var_168_8 = manager.audio:GetVoiceLength("story_v_out_424041", "424041039", "story_v_out_424041.awb") / 1000

					if var_168_8 + var_168_2 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_2
					end

					if var_168_4.prefab_name ~= "" and arg_165_1.actors_[var_168_4.prefab_name] ~= nil then
						local var_168_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_4.prefab_name].transform, "story_v_out_424041", "424041039", "story_v_out_424041.awb")

						arg_165_1:RecordAudio("424041039", var_168_9)
						arg_165_1:RecordAudio("424041039", var_168_9)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_424041", "424041039", "story_v_out_424041.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_424041", "424041039", "story_v_out_424041.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_10 = math.max(var_168_3, arg_165_1.talkMaxDuration)

			if var_168_2 <= arg_165_1.time_ and arg_165_1.time_ < var_168_2 + var_168_10 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_2) / var_168_10

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_2 + var_168_10 and arg_165_1.time_ < var_168_2 + var_168_10 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
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

		arg_165_1:InitPlayNodeList()
	end,
	Play424041040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 424041040
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play424041041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.55

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, true)
				arg_169_1.iconController_:SetSelectedState("hero")

				arg_169_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_169_1.callingController_:SetSelectedState("normal")

				arg_169_1.keyicon_.color = Color.New(1, 1, 1)
				arg_169_1.icon_.color = Color.New(1, 1, 1)

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(424041040).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 22 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 22)

				if (22 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 22)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play424041041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 424041041
		arg_173_1.duration_ = 7.37

		local var_173_0 = {
			zh = 7.366,
			ja = 5.4
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
				arg_173_0:Play424041042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1047 = arg_173_1.actors_["1047"].transform.localPosition
				arg_173_1.actors_["1047"].transform.localScale = Vector3.New(1, 1, 1)

				arg_173_1:CheckSpriteTmpPos("1047", 3)

				for iter_176_0 = 0, arg_173_1.actors_["1047"].transform.childCount - 1 do
					local var_176_0 = arg_173_1.actors_["1047"].transform:GetChild(iter_176_0)

					if var_176_0.name == "split_4" or not string.find(var_176_0.name, "split") then
						var_176_0.gameObject:SetActive(true)
					else
						var_176_0.gameObject:SetActive(false)
					end
				end
			end

			local var_176_1 = 0.100000001490116

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_1 then
				arg_173_1.actors_["1047"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_173_1.time_ - 0) / var_176_1)
			end

			if arg_173_1.time_ >= 0 + var_176_1 and arg_173_1.time_ < 0 + var_176_1 + arg_176_0 then
				arg_173_1.actors_["1047"].transform.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_176_2 = 0
			local var_176_3 = 0.75

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_2 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_4 = arg_173_1:GetWordFromCfg(424041041)
				local var_176_5 = arg_173_1:FormatText(var_176_4.content)

				arg_173_1.text_.text = var_176_5

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_7 = 30 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_5) / 30)

				if (30 <= 0 and var_176_3 or var_176_3 * (utf8.len(var_176_5) / 30)) > 0 and var_176_3 < var_176_7 then
					arg_173_1.talkMaxDuration = var_176_7

					if var_176_7 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_7 + var_176_2
					end
				end

				arg_173_1.text_.text = var_176_5
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041041", "story_v_out_424041.awb") ~= 0 then
					local var_176_8 = manager.audio:GetVoiceLength("story_v_out_424041", "424041041", "story_v_out_424041.awb") / 1000

					if var_176_8 + var_176_2 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_8 + var_176_2
					end

					if var_176_4.prefab_name ~= "" and arg_173_1.actors_[var_176_4.prefab_name] ~= nil then
						local var_176_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_4.prefab_name].transform, "story_v_out_424041", "424041041", "story_v_out_424041.awb")

						arg_173_1:RecordAudio("424041041", var_176_9)
						arg_173_1:RecordAudio("424041041", var_176_9)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_424041", "424041041", "story_v_out_424041.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_424041", "424041041", "story_v_out_424041.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_10 = math.max(var_176_3, arg_173_1.talkMaxDuration)

			if var_176_2 <= arg_173_1.time_ and arg_173_1.time_ < var_176_2 + var_176_10 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_2) / var_176_10

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_2 + var_176_10 and arg_173_1.time_ < var_176_2 + var_176_10 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.100000001490116,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play424041042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 424041042
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play424041043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0.034 < arg_177_1.time_ and arg_177_1.time_ <= 0.034 + arg_180_0 then
				arg_177_1:AudioAction("play", "effect", "se_story_136", "se_story_136_carengine", "")
			end

			local var_180_1 = 0
			local var_180_2 = 1.275

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_3 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(424041042).content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 51 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 51)

				if (51 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 51)) > 0 and var_180_2 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_6 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_6 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_6

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_6 and arg_177_1.time_ < var_180_1 + var_180_6 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play424041043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 424041043
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play424041044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.425

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_1 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(424041043).content)

				arg_181_1.text_.text = var_184_1

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_3 = 17 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 17)

				if (17 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_1) / 17)) > 0 and var_184_0 < var_184_3 then
					arg_181_1.talkMaxDuration = var_184_3

					if var_184_3 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_3 + 0
					end
				end

				arg_181_1.text_.text = var_184_1
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_4 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_4 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_4

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_4 and arg_181_1.time_ < 0 + var_184_4 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play424041044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 424041044
		arg_185_1.duration_ = 8.83

		local var_185_0 = {
			zh = 7.033,
			ja = 8.833
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
				arg_185_0:Play424041045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1047 = arg_185_1.actors_["1047"].transform.localPosition
				arg_185_1.actors_["1047"].transform.localScale = Vector3.New(1, 1, 1)

				arg_185_1:CheckSpriteTmpPos("1047", 3)

				for iter_188_0 = 0, arg_185_1.actors_["1047"].transform.childCount - 1 do
					local var_188_0 = arg_185_1.actors_["1047"].transform:GetChild(iter_188_0)

					if var_188_0.name == "split_1" or not string.find(var_188_0.name, "split") then
						var_188_0.gameObject:SetActive(true)
					else
						var_188_0.gameObject:SetActive(false)
					end
				end
			end

			local var_188_1 = 0.1

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 then
				arg_185_1.actors_["1047"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1047, Vector3.New(-38.9, -360, -319.3), (arg_185_1.time_ - 0) / var_188_1)
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 then
				arg_185_1.actors_["1047"].transform.localPosition = Vector3.New(-38.9, -360, -319.3)
			end

			local var_188_2 = 0
			local var_188_3 = 0.8

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_2 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_4 = arg_185_1:GetWordFromCfg(424041044)
				local var_188_5 = arg_185_1:FormatText(var_188_4.content)

				arg_185_1.text_.text = var_188_5

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_7 = 32 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_5) / 32)

				if (32 <= 0 and var_188_3 or var_188_3 * (utf8.len(var_188_5) / 32)) > 0 and var_188_3 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_2
					end
				end

				arg_185_1.text_.text = var_188_5
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041044", "story_v_out_424041.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_424041", "424041044", "story_v_out_424041.awb") / 1000

					if var_188_8 + var_188_2 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_2
					end

					if var_188_4.prefab_name ~= "" and arg_185_1.actors_[var_188_4.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_4.prefab_name].transform, "story_v_out_424041", "424041044", "story_v_out_424041.awb")

						arg_185_1:RecordAudio("424041044", var_188_9)
						arg_185_1:RecordAudio("424041044", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_424041", "424041044", "story_v_out_424041.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_424041", "424041044", "story_v_out_424041.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_3, arg_185_1.talkMaxDuration)

			if var_188_2 <= arg_185_1.time_ and arg_185_1.time_ < var_188_2 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_2) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_2 + var_188_10 and arg_185_1.time_ < var_188_2 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play424041045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 424041045
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play424041046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0.075

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				arg_189_1.leftNameTxt_.text = arg_189_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, true)
				arg_189_1.iconController_:SetSelectedState("hero")

				arg_189_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_189_1.callingController_:SetSelectedState("normal")

				arg_189_1.keyicon_.color = Color.New(1, 1, 1)
				arg_189_1.icon_.color = Color.New(1, 1, 1)

				local var_192_1 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(424041045).content)

				arg_189_1.text_.text = var_192_1

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_3 = 3 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 3)

				if (3 <= 0 and var_192_0 or var_192_0 * (utf8.len(var_192_1) / 3)) > 0 and var_192_0 < var_192_3 then
					arg_189_1.talkMaxDuration = var_192_3

					if var_192_3 + 0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_3 + 0
					end
				end

				arg_189_1.text_.text = var_192_1
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_4 = math.max(var_192_0, arg_189_1.talkMaxDuration)

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_4 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - 0) / var_192_4

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= 0 + var_192_4 and arg_189_1.time_ < 0 + var_192_4 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play424041046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 424041046
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play424041047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0.275

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, true)
				arg_193_1.iconController_:SetSelectedState("hero")

				arg_193_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_193_1.callingController_:SetSelectedState("normal")

				arg_193_1.keyicon_.color = Color.New(1, 1, 1)
				arg_193_1.icon_.color = Color.New(1, 1, 1)

				local var_196_1 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(424041046).content)

				arg_193_1.text_.text = var_196_1

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_3 = 11 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 11)

				if (11 <= 0 and var_196_0 or var_196_0 * (utf8.len(var_196_1) / 11)) > 0 and var_196_0 < var_196_3 then
					arg_193_1.talkMaxDuration = var_196_3

					if var_196_3 + 0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_3 + 0
					end
				end

				arg_193_1.text_.text = var_196_1
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_4 = math.max(var_196_0, arg_193_1.talkMaxDuration)

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - 0) / var_196_4

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play424041047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 424041047
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play424041048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1047 = arg_197_1.actors_["1047"].transform.localPosition
				arg_197_1.actors_["1047"].transform.localScale = Vector3.New(1, 1, 1)

				arg_197_1:CheckSpriteTmpPos("1047", 7)

				for iter_200_0 = 0, arg_197_1.actors_["1047"].transform.childCount - 1 do
					local var_200_0 = arg_197_1.actors_["1047"].transform:GetChild(iter_200_0)

					if var_200_0.name == "split_1" or not string.find(var_200_0.name, "split") then
						var_200_0.gameObject:SetActive(true)
					else
						var_200_0.gameObject:SetActive(false)
					end
				end
			end

			local var_200_1 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_1 then
				arg_197_1.actors_["1047"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1047, Vector3.New(0, -2000, 0), (arg_197_1.time_ - 0) / var_200_1)
			end

			if arg_197_1.time_ >= 0 + var_200_1 and arg_197_1.time_ < 0 + var_200_1 + arg_200_0 then
				arg_197_1.actors_["1047"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				local var_200_2 = arg_197_1.actors_["1047"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_200_2 then
					arg_197_1.var_.alphaOldValue1047 = var_200_2.alpha
					arg_197_1.var_.characterEffect1047 = var_200_2
				end

				arg_197_1.var_.alphaOldValue1047 = 0
			end

			local var_200_3 = 0.1

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 then
				if arg_197_1.var_.characterEffect1047 then
					arg_197_1.var_.characterEffect1047.alpha = Mathf.Lerp(arg_197_1.var_.alphaOldValue1047, 1, (arg_197_1.time_ - 0) / var_200_3)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and arg_197_1.var_.characterEffect1047 then
				arg_197_1.var_.characterEffect1047.alpha = 1
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:SetSpriteNiuquEffect("1047", false)
			end

			if 0.034 < arg_197_1.time_ and arg_197_1.time_ <= 0.034 + arg_200_0 then
				arg_197_1:AudioAction("play", "effect", "se_story_138", "se_story_138_phonebusy", "")
			end

			local var_200_6 = 0
			local var_200_7 = 0.75

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, false)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_8 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(424041047).content)

				arg_197_1.text_.text = var_200_8

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_10 = 30 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_8) / 30)

				if (30 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_8) / 30)) > 0 and var_200_7 < var_200_10 then
					arg_197_1.talkMaxDuration = var_200_10

					if var_200_10 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_10 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_8
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_11 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_11 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_11

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_11 and arg_197_1.time_ < var_200_6 + var_200_11 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play424041048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 424041048
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play424041049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0.475

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, true)
				arg_201_1.iconController_:SetSelectedState("hero")

				arg_201_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_201_1.callingController_:SetSelectedState("normal")

				arg_201_1.keyicon_.color = Color.New(1, 1, 1)
				arg_201_1.icon_.color = Color.New(1, 1, 1)

				local var_204_1 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(424041048).content)

				arg_201_1.text_.text = var_204_1

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_3 = 19 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 19)

				if (19 <= 0 and var_204_0 or var_204_0 * (utf8.len(var_204_1) / 19)) > 0 and var_204_0 < var_204_3 then
					arg_201_1.talkMaxDuration = var_204_3

					if var_204_3 + 0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_3 + 0
					end
				end

				arg_201_1.text_.text = var_204_1
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_4 = math.max(var_204_0, arg_201_1.talkMaxDuration)

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - 0) / var_204_4

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play424041049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 424041049
		arg_205_1.duration_ = 9

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play424041050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 2 < arg_205_1.time_ and arg_205_1.time_ <= 2 + arg_208_0 then
				local var_208_0 = arg_205_1.bgs_.I18a

				arg_205_1.bgs_.I18a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_208_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_208_1 = var_208_0:GetComponent("SpriteRenderer")

				if var_208_1 and var_208_1.sprite then
					local var_208_2 = 2 * (var_208_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_208_0.transform.localScale = Vector3.New(var_208_2 / var_208_1.sprite.bounds.size.y < var_208_2 * manager.ui.mainCameraCom_.aspect / var_208_1.sprite.bounds.size.x and var_208_2 * manager.ui.mainCameraCom_.aspect / var_208_1.sprite.bounds.size.x or var_208_2 / var_208_1.sprite.bounds.size.y, var_208_2 / var_208_1.sprite.bounds.size.y < var_208_2 * manager.ui.mainCameraCom_.aspect / var_208_1.sprite.bounds.size.x and var_208_2 * manager.ui.mainCameraCom_.aspect / var_208_1.sprite.bounds.size.x or var_208_2 / var_208_1.sprite.bounds.size.y, 0)
				end

				for iter_208_0, iter_208_1 in pairs(arg_205_1.bgs_) do
					if iter_208_0 ~= "I18a" then
						iter_208_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_208_3 = 4

			if 4 < arg_205_1.time_ and arg_205_1.time_ <= var_208_3 + arg_208_0 then
				arg_205_1.allBtn_.enabled = false
			end

			if arg_205_1.time_ >= var_208_3 + 0.3 and arg_205_1.time_ < var_208_3 + 0.3 + arg_208_0 then
				arg_205_1.allBtn_.enabled = true
			end

			local var_208_4 = 0

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_5 = 2

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_5 then
				local var_208_6 = Color.New(0, 0, 0)

				var_208_6.a = Mathf.Lerp(0, 1, (arg_205_1.time_ - var_208_4) / var_208_5)
				arg_205_1.mask_.color = var_208_6
			end

			if arg_205_1.time_ >= var_208_4 + var_208_5 and arg_205_1.time_ < var_208_4 + var_208_5 + arg_208_0 then
				local var_208_7 = Color.New(0, 0, 0)

				var_208_7.a = 1
				arg_205_1.mask_.color = var_208_7
			end

			local var_208_8 = 2

			if 2 < arg_205_1.time_ and arg_205_1.time_ <= var_208_8 + arg_208_0 then
				arg_205_1.mask_.enabled = true
				arg_205_1.mask_.raycastTarget = true

				arg_205_1:SetGaussion(false)
			end

			local var_208_9 = 2

			if var_208_8 <= arg_205_1.time_ and arg_205_1.time_ < var_208_8 + var_208_9 then
				local var_208_10 = Color.New(0, 0, 0)

				var_208_10.a = Mathf.Lerp(1, 0, (arg_205_1.time_ - var_208_8) / var_208_9)
				arg_205_1.mask_.color = var_208_10
			end

			if arg_205_1.time_ >= var_208_8 + var_208_9 and arg_205_1.time_ < var_208_8 + var_208_9 + arg_208_0 then
				local var_208_11 = Color.New(0, 0, 0)

				arg_205_1.mask_.enabled = false
				var_208_11.a = 0
				arg_205_1.mask_.color = var_208_11
			end

			local var_208_12 = arg_205_1.actors_["1047"].transform

			if 1.966 < arg_205_1.time_ and arg_205_1.time_ <= 1.966 + arg_208_0 then
				arg_205_1.var_.moveOldPos1047 = var_208_12.localPosition
				var_208_12.localScale = Vector3.New(1, 1, 1)

				arg_205_1:CheckSpriteTmpPos("1047", 7)

				for iter_208_2 = 0, var_208_12.childCount - 1 do
					local var_208_13 = var_208_12:GetChild(iter_208_2)

					if var_208_13.name == "" or not string.find(var_208_13.name, "split") then
						var_208_13.gameObject:SetActive(true)
					else
						var_208_13.gameObject:SetActive(false)
					end
				end
			end

			local var_208_14 = 0.001

			if 1.966 <= arg_205_1.time_ and arg_205_1.time_ < 1.966 + var_208_14 then
				var_208_12.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1047, Vector3.New(0, -2000, 0), (arg_205_1.time_ - 1.966) / var_208_14)
			end

			if arg_205_1.time_ >= 1.966 + var_208_14 and arg_205_1.time_ < 1.966 + var_208_14 + arg_208_0 then
				var_208_12.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.266666666666667 < arg_205_1.time_ and arg_205_1.time_ <= 0.266666666666667 + arg_208_0 then
				arg_205_1:AudioAction("stop", "effect", "se_story_side_1058", "se_story_side_1058_forest_loop", "")
			end

			if 1.66666666666667 < arg_205_1.time_ and arg_205_1.time_ <= 1.66666666666667 + arg_208_0 then
				arg_205_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_valley", "")
			end

			if arg_205_1.frameCnt_ <= 1 then
				arg_205_1.dialog_:SetActive(false)
			end

			local var_208_17 = 4
			local var_208_18 = 0.425

			if 4 < arg_205_1.time_ and arg_205_1.time_ <= var_208_17 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0

				arg_205_1.dialog_:SetActive(true)

				arg_205_1.dialogCg_.alpha = 0

				local var_208_19 = LeanTween.value(arg_205_1.dialog_, 0, 1, 0.3)

				var_208_19:setOnUpdate(LuaHelper.FloatAction(function(arg_209_0)
					arg_205_1.dialogCg_.alpha = arg_209_0
				end))
				var_208_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_205_1.dialog_)
					var_208_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_205_1.duration_ = arg_205_1.duration_ + 0.3

				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, true)
				arg_205_1.iconController_:SetSelectedState("hero")

				arg_205_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_205_1.callingController_:SetSelectedState("normal")

				arg_205_1.keyicon_.color = Color.New(1, 1, 1)
				arg_205_1.icon_.color = Color.New(1, 1, 1)

				local var_208_20 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(424041049).content)

				arg_205_1.text_.text = var_208_20

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_22 = 17 <= 0 and var_208_18 or var_208_18 * (utf8.len(var_208_20) / 17)

				if (17 <= 0 and var_208_18 or var_208_18 * (utf8.len(var_208_20) / 17)) > 0 and var_208_18 < var_208_22 then
					arg_205_1.talkMaxDuration = var_208_22
					var_208_17 = var_208_17 + 0.3

					if var_208_22 + var_208_17 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_22 + var_208_17
					end
				end

				arg_205_1.text_.text = var_208_20
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_23 = var_208_17 + 0.3
			local var_208_24 = math.max(var_208_18, arg_205_1.talkMaxDuration)

			if var_208_17 + 0.3 <= arg_205_1.time_ and arg_205_1.time_ < var_208_23 + var_208_24 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_23) / var_208_24

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_23 + var_208_24 and arg_205_1.time_ < var_208_23 + var_208_24 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play424041050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 424041050
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play424041051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = 1.3

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_1 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(424041050).content)

				arg_211_1.text_.text = var_214_1

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_3 = 52 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 52)

				if (52 <= 0 and var_214_0 or var_214_0 * (utf8.len(var_214_1) / 52)) > 0 and var_214_0 < var_214_3 then
					arg_211_1.talkMaxDuration = var_214_3

					if var_214_3 + 0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_3 + 0
					end
				end

				arg_211_1.text_.text = var_214_1
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_4 = math.max(var_214_0, arg_211_1.talkMaxDuration)

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - 0) / var_214_4

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play424041051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 424041051
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play424041052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0.35

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, true)
				arg_215_1.iconController_:SetSelectedState("hero")

				arg_215_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_215_1.callingController_:SetSelectedState("normal")

				arg_215_1.keyicon_.color = Color.New(1, 1, 1)
				arg_215_1.icon_.color = Color.New(1, 1, 1)

				local var_218_1 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(424041051).content)

				arg_215_1.text_.text = var_218_1

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_3 = 14 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 14)

				if (14 <= 0 and var_218_0 or var_218_0 * (utf8.len(var_218_1) / 14)) > 0 and var_218_0 < var_218_3 then
					arg_215_1.talkMaxDuration = var_218_3

					if var_218_3 + 0 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_3 + 0
					end
				end

				arg_215_1.text_.text = var_218_1
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_4 = math.max(var_218_0, arg_215_1.talkMaxDuration)

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - 0) / var_218_4

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play424041052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 424041052
		arg_219_1.duration_ = 7.3

		local var_219_0 = {
			zh = 5.433,
			ja = 7.3
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
				arg_219_0:Play424041053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.6

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fatherb")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_1 = arg_219_1:GetWordFromCfg(424041052)
				local var_222_2 = arg_219_1:FormatText(var_222_1.content)

				arg_219_1.text_.text = var_222_2

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 24 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 24)

				if (24 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 24)) > 0 and var_222_0 < var_222_4 then
					arg_219_1.talkMaxDuration = var_222_4

					if var_222_4 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_4 + 0
					end
				end

				arg_219_1.text_.text = var_222_2
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041052", "story_v_out_424041.awb") ~= 0 then
					local var_222_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041052", "story_v_out_424041.awb") / 1000

					if var_222_5 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + 0
					end

					if var_222_1.prefab_name ~= "" and arg_219_1.actors_[var_222_1.prefab_name] ~= nil then
						local var_222_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_1.prefab_name].transform, "story_v_out_424041", "424041052", "story_v_out_424041.awb")

						arg_219_1:RecordAudio("424041052", var_222_6)
						arg_219_1:RecordAudio("424041052", var_222_6)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_424041", "424041052", "story_v_out_424041.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_424041", "424041052", "story_v_out_424041.awb")
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
	Play424041053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 424041053
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play424041054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.9

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_1 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(424041053).content)

				arg_223_1.text_.text = var_226_1

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_3 = 36 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 36)

				if (36 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 36)) > 0 and var_226_0 < var_226_3 then
					arg_223_1.talkMaxDuration = var_226_3

					if var_226_3 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_3 + 0
					end
				end

				arg_223_1.text_.text = var_226_1
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_4 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_4

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play424041054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 424041054
		arg_227_1.duration_ = 11.07

		local var_227_0 = {
			zh = 5.8,
			ja = 11.066
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
				arg_227_0:Play424041055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.475

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_1 = arg_227_1:GetWordFromCfg(424041054)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 19 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 19)

				if (19 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 19)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041054", "story_v_out_424041.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041054", "story_v_out_424041.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_out_424041", "424041054", "story_v_out_424041.awb")

						arg_227_1:RecordAudio("424041054", var_230_6)
						arg_227_1:RecordAudio("424041054", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_424041", "424041054", "story_v_out_424041.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_424041", "424041054", "story_v_out_424041.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play424041055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 424041055
		arg_231_1.duration_ = 10.6

		local var_231_0 = {
			zh = 9.133,
			ja = 10.6
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
				arg_231_0:Play424041056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 1.05

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[1397].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fatherb")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_1 = arg_231_1:GetWordFromCfg(424041055)
				local var_234_2 = arg_231_1:FormatText(var_234_1.content)

				arg_231_1.text_.text = var_234_2

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_4 = 42 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 42)

				if (42 <= 0 and var_234_0 or var_234_0 * (utf8.len(var_234_2) / 42)) > 0 and var_234_0 < var_234_4 then
					arg_231_1.talkMaxDuration = var_234_4

					if var_234_4 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_4 + 0
					end
				end

				arg_231_1.text_.text = var_234_2
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041055", "story_v_out_424041.awb") ~= 0 then
					local var_234_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041055", "story_v_out_424041.awb") / 1000

					if var_234_5 + 0 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + 0
					end

					if var_234_1.prefab_name ~= "" and arg_231_1.actors_[var_234_1.prefab_name] ~= nil then
						local var_234_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_1.prefab_name].transform, "story_v_out_424041", "424041055", "story_v_out_424041.awb")

						arg_231_1:RecordAudio("424041055", var_234_6)
						arg_231_1:RecordAudio("424041055", var_234_6)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_424041", "424041055", "story_v_out_424041.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_424041", "424041055", "story_v_out_424041.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_7 = math.max(var_234_0, arg_231_1.talkMaxDuration)

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_7 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - 0) / var_234_7

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= 0 + var_234_7 and arg_231_1.time_ < 0 + var_234_7 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play424041056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 424041056
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play424041057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 1

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(424041056).content)

				arg_235_1.text_.text = var_238_1

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_3 = 40 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 40)

				if (40 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_1) / 40)) > 0 and var_238_0 < var_238_3 then
					arg_235_1.talkMaxDuration = var_238_3

					if var_238_3 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_3 + 0
					end
				end

				arg_235_1.text_.text = var_238_1
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_4 = math.max(var_238_0, arg_235_1.talkMaxDuration)

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_4 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - 0) / var_238_4

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= 0 + var_238_4 and arg_235_1.time_ < 0 + var_238_4 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play424041057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 424041057
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play424041058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.225

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, true)
				arg_239_1.iconController_:SetSelectedState("hero")

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_1 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(424041057).content)

				arg_239_1.text_.text = var_242_1

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_3 = 9 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 9)

				if (9 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_1) / 9)) > 0 and var_242_0 < var_242_3 then
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
	Play424041058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 424041058
		arg_243_1.duration_ = 21.63

		local var_243_0 = {
			zh = 13.666,
			ja = 21.633
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
				arg_243_0:Play424041059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 1.3

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_1 = arg_243_1:GetWordFromCfg(424041058)
				local var_246_2 = arg_243_1:FormatText(var_246_1.content)

				arg_243_1.text_.text = var_246_2

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_4 = 52 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 52)

				if (52 <= 0 and var_246_0 or var_246_0 * (utf8.len(var_246_2) / 52)) > 0 and var_246_0 < var_246_4 then
					arg_243_1.talkMaxDuration = var_246_4

					if var_246_4 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_4 + 0
					end
				end

				arg_243_1.text_.text = var_246_2
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041058", "story_v_out_424041.awb") ~= 0 then
					local var_246_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041058", "story_v_out_424041.awb") / 1000

					if var_246_5 + 0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + 0
					end

					if var_246_1.prefab_name ~= "" and arg_243_1.actors_[var_246_1.prefab_name] ~= nil then
						local var_246_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_1.prefab_name].transform, "story_v_out_424041", "424041058", "story_v_out_424041.awb")

						arg_243_1:RecordAudio("424041058", var_246_6)
						arg_243_1:RecordAudio("424041058", var_246_6)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_424041", "424041058", "story_v_out_424041.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_424041", "424041058", "story_v_out_424041.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_7 = math.max(var_246_0, arg_243_1.talkMaxDuration)

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - 0) / var_246_7

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play424041059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 424041059
		arg_247_1.duration_ = 8.8

		local var_247_0 = {
			zh = 8.8,
			ja = 6.333
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
				arg_247_0:Play424041060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = 1.15

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[1397].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, true)
				arg_247_1.iconController_:SetSelectedState("hero")

				arg_247_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fatherb")

				arg_247_1.callingController_:SetSelectedState("normal")

				arg_247_1.keyicon_.color = Color.New(1, 1, 1)
				arg_247_1.icon_.color = Color.New(1, 1, 1)

				local var_250_1 = arg_247_1:GetWordFromCfg(424041059)
				local var_250_2 = arg_247_1:FormatText(var_250_1.content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 46 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 46)

				if (46 <= 0 and var_250_0 or var_250_0 * (utf8.len(var_250_2) / 46)) > 0 and var_250_0 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + 0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041059", "story_v_out_424041.awb") ~= 0 then
					local var_250_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041059", "story_v_out_424041.awb") / 1000

					if var_250_5 + 0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_5 + 0
					end

					if var_250_1.prefab_name ~= "" and arg_247_1.actors_[var_250_1.prefab_name] ~= nil then
						local var_250_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_1.prefab_name].transform, "story_v_out_424041", "424041059", "story_v_out_424041.awb")

						arg_247_1:RecordAudio("424041059", var_250_6)
						arg_247_1:RecordAudio("424041059", var_250_6)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_424041", "424041059", "story_v_out_424041.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_424041", "424041059", "story_v_out_424041.awb")
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
	Play424041060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 424041060
		arg_251_1.duration_ = 2.03

		local var_251_0 = {
			zh = 1.9,
			ja = 2.033
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
				arg_251_0:Play424041061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.1

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_1 = arg_251_1:GetWordFromCfg(424041060)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 4 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 4)

				if (4 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 4)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041060", "story_v_out_424041.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041060", "story_v_out_424041.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_424041", "424041060", "story_v_out_424041.awb")

						arg_251_1:RecordAudio("424041060", var_254_6)
						arg_251_1:RecordAudio("424041060", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_424041", "424041060", "story_v_out_424041.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_424041", "424041060", "story_v_out_424041.awb")
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
	Play424041061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 424041061
		arg_255_1.duration_ = 9.2

		local var_255_0 = {
			zh = 6.833,
			ja = 9.2
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
				arg_255_0:Play424041062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0.775

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[1397].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, true)
				arg_255_1.iconController_:SetSelectedState("hero")

				arg_255_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fatherb")

				arg_255_1.callingController_:SetSelectedState("normal")

				arg_255_1.keyicon_.color = Color.New(1, 1, 1)
				arg_255_1.icon_.color = Color.New(1, 1, 1)

				local var_258_1 = arg_255_1:GetWordFromCfg(424041061)
				local var_258_2 = arg_255_1:FormatText(var_258_1.content)

				arg_255_1.text_.text = var_258_2

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_4 = 31 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 31)

				if (31 <= 0 and var_258_0 or var_258_0 * (utf8.len(var_258_2) / 31)) > 0 and var_258_0 < var_258_4 then
					arg_255_1.talkMaxDuration = var_258_4

					if var_258_4 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_4 + 0
					end
				end

				arg_255_1.text_.text = var_258_2
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041061", "story_v_out_424041.awb") ~= 0 then
					local var_258_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041061", "story_v_out_424041.awb") / 1000

					if var_258_5 + 0 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_5 + 0
					end

					if var_258_1.prefab_name ~= "" and arg_255_1.actors_[var_258_1.prefab_name] ~= nil then
						local var_258_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_1.prefab_name].transform, "story_v_out_424041", "424041061", "story_v_out_424041.awb")

						arg_255_1:RecordAudio("424041061", var_258_6)
						arg_255_1:RecordAudio("424041061", var_258_6)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_424041", "424041061", "story_v_out_424041.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_424041", "424041061", "story_v_out_424041.awb")
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
	Play424041062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 424041062
		arg_259_1.duration_ = 5

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play424041063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0.85

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(424041062).content)

				arg_259_1.text_.text = var_262_1

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_3 = 34 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 34)

				if (34 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_1) / 34)) > 0 and var_262_0 < var_262_3 then
					arg_259_1.talkMaxDuration = var_262_3

					if var_262_3 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_3 + 0
					end
				end

				arg_259_1.text_.text = var_262_1
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_4 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_4

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play424041063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 424041063
		arg_263_1.duration_ = 5

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play424041064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0.25

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, true)
				arg_263_1.iconController_:SetSelectedState("hero")

				arg_263_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_263_1.callingController_:SetSelectedState("normal")

				arg_263_1.keyicon_.color = Color.New(1, 1, 1)
				arg_263_1.icon_.color = Color.New(1, 1, 1)

				local var_266_1 = arg_263_1:FormatText(arg_263_1:GetWordFromCfg(424041063).content)

				arg_263_1.text_.text = var_266_1

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_3 = 10 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 10)

				if (10 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_1) / 10)) > 0 and var_266_0 < var_266_3 then
					arg_263_1.talkMaxDuration = var_266_3

					if var_266_3 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_3 + 0
					end
				end

				arg_263_1.text_.text = var_266_1
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)
				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_4 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_4 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_4

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_4 and arg_263_1.time_ < 0 + var_266_4 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play424041064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 424041064
		arg_267_1.duration_ = 9.43

		local var_267_0 = {
			zh = 7.366,
			ja = 9.433
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
				arg_267_0:Play424041065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0.5

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, true)
				arg_267_1.iconController_:SetSelectedState("hero")

				arg_267_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_267_1.callingController_:SetSelectedState("normal")

				arg_267_1.keyicon_.color = Color.New(1, 1, 1)
				arg_267_1.icon_.color = Color.New(1, 1, 1)

				local var_270_1 = arg_267_1:GetWordFromCfg(424041064)
				local var_270_2 = arg_267_1:FormatText(var_270_1.content)

				arg_267_1.text_.text = var_270_2

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_4 = 20 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 20)

				if (20 <= 0 and var_270_0 or var_270_0 * (utf8.len(var_270_2) / 20)) > 0 and var_270_0 < var_270_4 then
					arg_267_1.talkMaxDuration = var_270_4

					if var_270_4 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_4 + 0
					end
				end

				arg_267_1.text_.text = var_270_2
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041064", "story_v_out_424041.awb") ~= 0 then
					local var_270_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041064", "story_v_out_424041.awb") / 1000

					if var_270_5 + 0 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_5 + 0
					end

					if var_270_1.prefab_name ~= "" and arg_267_1.actors_[var_270_1.prefab_name] ~= nil then
						local var_270_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_1.prefab_name].transform, "story_v_out_424041", "424041064", "story_v_out_424041.awb")

						arg_267_1:RecordAudio("424041064", var_270_6)
						arg_267_1:RecordAudio("424041064", var_270_6)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_424041", "424041064", "story_v_out_424041.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_424041", "424041064", "story_v_out_424041.awb")
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
	Play424041065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 424041065
		arg_271_1.duration_ = 5

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play424041066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.55

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, true)
				arg_271_1.iconController_:SetSelectedState("hero")

				arg_271_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_271_1.callingController_:SetSelectedState("normal")

				arg_271_1.keyicon_.color = Color.New(1, 1, 1)
				arg_271_1.icon_.color = Color.New(1, 1, 1)

				local var_274_1 = arg_271_1:FormatText(arg_271_1:GetWordFromCfg(424041065).content)

				arg_271_1.text_.text = var_274_1

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_3 = 22 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 22)

				if (22 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_1) / 22)) > 0 and var_274_0 < var_274_3 then
					arg_271_1.talkMaxDuration = var_274_3

					if var_274_3 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_3 + 0
					end
				end

				arg_271_1.text_.text = var_274_1
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_4 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_4

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play424041066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 424041066
		arg_275_1.duration_ = 8.63

		local var_275_0 = {
			zh = 8.066,
			ja = 8.633
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
				arg_275_0:Play424041067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.625

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, true)
				arg_275_1.iconController_:SetSelectedState("hero")

				arg_275_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_275_1.callingController_:SetSelectedState("normal")

				arg_275_1.keyicon_.color = Color.New(1, 1, 1)
				arg_275_1.icon_.color = Color.New(1, 1, 1)

				local var_278_1 = arg_275_1:GetWordFromCfg(424041066)
				local var_278_2 = arg_275_1:FormatText(var_278_1.content)

				arg_275_1.text_.text = var_278_2

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_4 = 25 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 25)

				if (25 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 25)) > 0 and var_278_0 < var_278_4 then
					arg_275_1.talkMaxDuration = var_278_4

					if var_278_4 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_4 + 0
					end
				end

				arg_275_1.text_.text = var_278_2
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041066", "story_v_out_424041.awb") ~= 0 then
					local var_278_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041066", "story_v_out_424041.awb") / 1000

					if var_278_5 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + 0
					end

					if var_278_1.prefab_name ~= "" and arg_275_1.actors_[var_278_1.prefab_name] ~= nil then
						local var_278_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_1.prefab_name].transform, "story_v_out_424041", "424041066", "story_v_out_424041.awb")

						arg_275_1:RecordAudio("424041066", var_278_6)
						arg_275_1:RecordAudio("424041066", var_278_6)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_424041", "424041066", "story_v_out_424041.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_424041", "424041066", "story_v_out_424041.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play424041067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 424041067
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play424041068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 0.525

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_1 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(424041067).content)

				arg_279_1.text_.text = var_282_1

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_3 = 21 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 21)

				if (21 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_1) / 21)) > 0 and var_282_0 < var_282_3 then
					arg_279_1.talkMaxDuration = var_282_3

					if var_282_3 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_3 + 0
					end
				end

				arg_279_1.text_.text = var_282_1
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_4 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_4 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_4

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_4 and arg_279_1.time_ < 0 + var_282_4 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play424041068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 424041068
		arg_283_1.duration_ = 5

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play424041069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 1.15

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, false)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_1 = arg_283_1:FormatText(arg_283_1:GetWordFromCfg(424041068).content)

				arg_283_1.text_.text = var_286_1

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_3 = 46 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 46)

				if (46 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_1) / 46)) > 0 and var_286_0 < var_286_3 then
					arg_283_1.talkMaxDuration = var_286_3

					if var_286_3 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_3 + 0
					end
				end

				arg_283_1.text_.text = var_286_1
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)
				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_4 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_4 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_4

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_4 and arg_283_1.time_ < 0 + var_286_4 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play424041069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 424041069
		arg_287_1.duration_ = 3.87

		local var_287_0 = {
			zh = 2.666,
			ja = 3.866
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
				arg_287_0:Play424041070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.225

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, true)
				arg_287_1.iconController_:SetSelectedState("hero")

				arg_287_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_287_1.callingController_:SetSelectedState("normal")

				arg_287_1.keyicon_.color = Color.New(1, 1, 1)
				arg_287_1.icon_.color = Color.New(1, 1, 1)

				local var_290_1 = arg_287_1:GetWordFromCfg(424041069)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 9 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 9)

				if (9 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 9)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041069", "story_v_out_424041.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041069", "story_v_out_424041.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_out_424041", "424041069", "story_v_out_424041.awb")

						arg_287_1:RecordAudio("424041069", var_290_6)
						arg_287_1:RecordAudio("424041069", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_424041", "424041069", "story_v_out_424041.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_424041", "424041069", "story_v_out_424041.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play424041070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 424041070
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play424041071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0.15

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, true)
				arg_291_1.iconController_:SetSelectedState("hero")

				arg_291_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_291_1.callingController_:SetSelectedState("normal")

				arg_291_1.keyicon_.color = Color.New(1, 1, 1)
				arg_291_1.icon_.color = Color.New(1, 1, 1)

				local var_294_1 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(424041070).content)

				arg_291_1.text_.text = var_294_1

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_3 = 6 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 6)

				if (6 <= 0 and var_294_0 or var_294_0 * (utf8.len(var_294_1) / 6)) > 0 and var_294_0 < var_294_3 then
					arg_291_1.talkMaxDuration = var_294_3

					if var_294_3 + 0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_3 + 0
					end
				end

				arg_291_1.text_.text = var_294_1
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_4 = math.max(var_294_0, arg_291_1.talkMaxDuration)

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - 0) / var_294_4

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play424041071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 424041071
		arg_295_1.duration_ = 2.8

		local var_295_0 = {
			zh = 1.5,
			ja = 2.8
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play424041072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0.175

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, true)
				arg_295_1.iconController_:SetSelectedState("hero")

				arg_295_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_295_1.callingController_:SetSelectedState("normal")

				arg_295_1.keyicon_.color = Color.New(1, 1, 1)
				arg_295_1.icon_.color = Color.New(1, 1, 1)

				local var_298_1 = arg_295_1:GetWordFromCfg(424041071)
				local var_298_2 = arg_295_1:FormatText(var_298_1.content)

				arg_295_1.text_.text = var_298_2

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 7 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 7)

				if (7 <= 0 and var_298_0 or var_298_0 * (utf8.len(var_298_2) / 7)) > 0 and var_298_0 < var_298_4 then
					arg_295_1.talkMaxDuration = var_298_4

					if var_298_4 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_4 + 0
					end
				end

				arg_295_1.text_.text = var_298_2
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041071", "story_v_out_424041.awb") ~= 0 then
					local var_298_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041071", "story_v_out_424041.awb") / 1000

					if var_298_5 + 0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_5 + 0
					end

					if var_298_1.prefab_name ~= "" and arg_295_1.actors_[var_298_1.prefab_name] ~= nil then
						local var_298_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_1.prefab_name].transform, "story_v_out_424041", "424041071", "story_v_out_424041.awb")

						arg_295_1:RecordAudio("424041071", var_298_6)
						arg_295_1:RecordAudio("424041071", var_298_6)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_424041", "424041071", "story_v_out_424041.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_424041", "424041071", "story_v_out_424041.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_0, arg_295_1.talkMaxDuration)

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - 0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play424041072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 424041072
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play424041073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0.1

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_299_1.callingController_:SetSelectedState("normal")

				arg_299_1.keyicon_.color = Color.New(1, 1, 1)
				arg_299_1.icon_.color = Color.New(1, 1, 1)

				local var_302_1 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(424041072).content)

				arg_299_1.text_.text = var_302_1

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_3 = 4 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 4)

				if (4 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_1) / 4)) > 0 and var_302_0 < var_302_3 then
					arg_299_1.talkMaxDuration = var_302_3

					if var_302_3 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_3 + 0
					end
				end

				arg_299_1.text_.text = var_302_1
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_4 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_4 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_4

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_4 and arg_299_1.time_ < 0 + var_302_4 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play424041073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 424041073
		arg_303_1.duration_ = 15.07

		local var_303_0 = {
			zh = 15.066,
			ja = 14.166
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
				arg_303_0:Play424041074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 1.375

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_303_1.callingController_:SetSelectedState("normal")

				arg_303_1.keyicon_.color = Color.New(1, 1, 1)
				arg_303_1.icon_.color = Color.New(1, 1, 1)

				local var_306_1 = arg_303_1:GetWordFromCfg(424041073)
				local var_306_2 = arg_303_1:FormatText(var_306_1.content)

				arg_303_1.text_.text = var_306_2

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_4 = 55 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 55)

				if (55 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 55)) > 0 and var_306_0 < var_306_4 then
					arg_303_1.talkMaxDuration = var_306_4

					if var_306_4 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_4 + 0
					end
				end

				arg_303_1.text_.text = var_306_2
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041073", "story_v_out_424041.awb") ~= 0 then
					local var_306_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041073", "story_v_out_424041.awb") / 1000

					if var_306_5 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + 0
					end

					if var_306_1.prefab_name ~= "" and arg_303_1.actors_[var_306_1.prefab_name] ~= nil then
						local var_306_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_1.prefab_name].transform, "story_v_out_424041", "424041073", "story_v_out_424041.awb")

						arg_303_1:RecordAudio("424041073", var_306_6)
						arg_303_1:RecordAudio("424041073", var_306_6)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_424041", "424041073", "story_v_out_424041.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_424041", "424041073", "story_v_out_424041.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_7 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_7 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_7

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_7 and arg_303_1.time_ < 0 + var_306_7 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play424041074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 424041074
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play424041075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 1.35

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_1 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(424041074).content)

				arg_307_1.text_.text = var_310_1

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_3 = 54 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 54)

				if (54 <= 0 and var_310_0 or var_310_0 * (utf8.len(var_310_1) / 54)) > 0 and var_310_0 < var_310_3 then
					arg_307_1.talkMaxDuration = var_310_3

					if var_310_3 + 0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_3 + 0
					end
				end

				arg_307_1.text_.text = var_310_1
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_4 = math.max(var_310_0, arg_307_1.talkMaxDuration)

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_4 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - 0) / var_310_4

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= 0 + var_310_4 and arg_307_1.time_ < 0 + var_310_4 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play424041075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 424041075
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play424041076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0.675

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
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

				arg_311_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_311_1.callingController_:SetSelectedState("normal")

				arg_311_1.keyicon_.color = Color.New(1, 1, 1)
				arg_311_1.icon_.color = Color.New(1, 1, 1)

				local var_314_1 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(424041075).content)

				arg_311_1.text_.text = var_314_1

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_3 = 27 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 27)

				if (27 <= 0 and var_314_0 or var_314_0 * (utf8.len(var_314_1) / 27)) > 0 and var_314_0 < var_314_3 then
					arg_311_1.talkMaxDuration = var_314_3

					if var_314_3 + 0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_3 + 0
					end
				end

				arg_311_1.text_.text = var_314_1
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_4 = math.max(var_314_0, arg_311_1.talkMaxDuration)

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_4 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - 0) / var_314_4

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= 0 + var_314_4 and arg_311_1.time_ < 0 + var_314_4 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play424041076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 424041076
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play424041077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.625

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_1 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(424041076).content)

				arg_315_1.text_.text = var_318_1

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_3 = 25 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_1) / 25)

				if (25 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_1) / 25)) > 0 and var_318_0 < var_318_3 then
					arg_315_1.talkMaxDuration = var_318_3

					if var_318_3 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_3 + 0
					end
				end

				arg_315_1.text_.text = var_318_1
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_4 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_4 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_4

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_4 and arg_315_1.time_ < 0 + var_318_4 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play424041077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 424041077
		arg_319_1.duration_ = 5.2

		local var_319_0 = {
			zh = 4.733,
			ja = 5.2
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
				arg_319_0:Play424041078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0.275

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[462].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, true)
				arg_319_1.iconController_:SetSelectedState("hero")

				arg_319_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10050")

				arg_319_1.callingController_:SetSelectedState("normal")

				arg_319_1.keyicon_.color = Color.New(1, 1, 1)
				arg_319_1.icon_.color = Color.New(1, 1, 1)

				local var_322_1 = arg_319_1:GetWordFromCfg(424041077)
				local var_322_2 = arg_319_1:FormatText(var_322_1.content)

				arg_319_1.text_.text = var_322_2

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_4 = 11 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 11)

				if (11 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 11)) > 0 and var_322_0 < var_322_4 then
					arg_319_1.talkMaxDuration = var_322_4

					if var_322_4 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_4 + 0
					end
				end

				arg_319_1.text_.text = var_322_2
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041077", "story_v_out_424041.awb") ~= 0 then
					local var_322_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041077", "story_v_out_424041.awb") / 1000

					if var_322_5 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + 0
					end

					if var_322_1.prefab_name ~= "" and arg_319_1.actors_[var_322_1.prefab_name] ~= nil then
						local var_322_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_1.prefab_name].transform, "story_v_out_424041", "424041077", "story_v_out_424041.awb")

						arg_319_1:RecordAudio("424041077", var_322_6)
						arg_319_1:RecordAudio("424041077", var_322_6)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_424041", "424041077", "story_v_out_424041.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_424041", "424041077", "story_v_out_424041.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_7 = math.max(var_322_0, arg_319_1.talkMaxDuration)

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_7 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - 0) / var_322_7

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= 0 + var_322_7 and arg_319_1.time_ < 0 + var_322_7 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play424041078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 424041078
		arg_323_1.duration_ = 5

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play424041079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 1.075

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_1 = arg_323_1:FormatText(arg_323_1:GetWordFromCfg(424041078).content)

				arg_323_1.text_.text = var_326_1

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_3 = 43 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_1) / 43)

				if (43 <= 0 and var_326_0 or var_326_0 * (utf8.len(var_326_1) / 43)) > 0 and var_326_0 < var_326_3 then
					arg_323_1.talkMaxDuration = var_326_3

					if var_326_3 + 0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_3 + 0
					end
				end

				arg_323_1.text_.text = var_326_1
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)
				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_4 = math.max(var_326_0, arg_323_1.talkMaxDuration)

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_4 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - 0) / var_326_4

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= 0 + var_326_4 and arg_323_1.time_ < 0 + var_326_4 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play424041079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 424041079
		arg_327_1.duration_ = 9

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play424041080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if arg_327_1.bgs_.I11o == nil then
				local var_330_0 = Object.Instantiate(arg_327_1.paintGo_)

				var_330_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11o")
				var_330_0.name = "I11o"
				var_330_0.transform.parent = arg_327_1.stage_.transform
				var_330_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_327_1.bgs_.I11o = var_330_0
			end

			if 2 < arg_327_1.time_ and arg_327_1.time_ <= 2 + arg_330_0 then
				local var_330_1 = arg_327_1.bgs_.I11o

				arg_327_1.bgs_.I11o.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_330_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_330_2 = var_330_1:GetComponent("SpriteRenderer")

				if var_330_2 and var_330_2.sprite then
					local var_330_3 = 2 * (var_330_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_330_1.transform.localScale = Vector3.New(var_330_3 / var_330_2.sprite.bounds.size.y < var_330_3 * manager.ui.mainCameraCom_.aspect / var_330_2.sprite.bounds.size.x and var_330_3 * manager.ui.mainCameraCom_.aspect / var_330_2.sprite.bounds.size.x or var_330_3 / var_330_2.sprite.bounds.size.y, var_330_3 / var_330_2.sprite.bounds.size.y < var_330_3 * manager.ui.mainCameraCom_.aspect / var_330_2.sprite.bounds.size.x and var_330_3 * manager.ui.mainCameraCom_.aspect / var_330_2.sprite.bounds.size.x or var_330_3 / var_330_2.sprite.bounds.size.y, 0)
				end

				for iter_330_0, iter_330_1 in pairs(arg_327_1.bgs_) do
					if iter_330_0 ~= "I11o" then
						iter_330_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_330_4 = 4

			if 4 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1.allBtn_.enabled = false
			end

			if arg_327_1.time_ >= var_330_4 + 0.3 and arg_327_1.time_ < var_330_4 + 0.3 + arg_330_0 then
				arg_327_1.allBtn_.enabled = true
			end

			local var_330_5 = 0

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_5 + arg_330_0 then
				arg_327_1.mask_.enabled = true
				arg_327_1.mask_.raycastTarget = true

				arg_327_1:SetGaussion(false)
			end

			local var_330_6 = 2

			if var_330_5 <= arg_327_1.time_ and arg_327_1.time_ < var_330_5 + var_330_6 then
				local var_330_7 = Color.New(0, 0, 0)

				var_330_7.a = Mathf.Lerp(0, 1, (arg_327_1.time_ - var_330_5) / var_330_6)
				arg_327_1.mask_.color = var_330_7
			end

			if arg_327_1.time_ >= var_330_5 + var_330_6 and arg_327_1.time_ < var_330_5 + var_330_6 + arg_330_0 then
				local var_330_8 = Color.New(0, 0, 0)

				var_330_8.a = 1
				arg_327_1.mask_.color = var_330_8
			end

			local var_330_9 = 2

			if 2 < arg_327_1.time_ and arg_327_1.time_ <= var_330_9 + arg_330_0 then
				arg_327_1.mask_.enabled = true
				arg_327_1.mask_.raycastTarget = true

				arg_327_1:SetGaussion(false)
			end

			local var_330_10 = 2

			if var_330_9 <= arg_327_1.time_ and arg_327_1.time_ < var_330_9 + var_330_10 then
				local var_330_11 = Color.New(0, 0, 0)

				var_330_11.a = Mathf.Lerp(1, 0, (arg_327_1.time_ - var_330_9) / var_330_10)
				arg_327_1.mask_.color = var_330_11
			end

			if arg_327_1.time_ >= var_330_9 + var_330_10 and arg_327_1.time_ < var_330_9 + var_330_10 + arg_330_0 then
				local var_330_12 = Color.New(0, 0, 0)

				arg_327_1.mask_.enabled = false
				var_330_12.a = 0
				arg_327_1.mask_.color = var_330_12
			end

			if 0.166666666666667 < arg_327_1.time_ and arg_327_1.time_ <= 0.166666666666667 + arg_330_0 then
				arg_327_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_valley", "")
			end

			if 1.7 < arg_327_1.time_ and arg_327_1.time_ <= 1.7 + arg_330_0 then
				arg_327_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if 0.166666666666667 < arg_327_1.time_ and arg_327_1.time_ <= 0.166666666666667 + arg_330_0 then
				arg_327_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if arg_327_1.frameCnt_ <= 1 then
				arg_327_1.dialog_:SetActive(false)
			end

			local var_330_16 = 4
			local var_330_17 = 1.025

			if 4 < arg_327_1.time_ and arg_327_1.time_ <= var_330_16 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0

				arg_327_1.dialog_:SetActive(true)

				arg_327_1.dialogCg_.alpha = 0

				local var_330_18 = LeanTween.value(arg_327_1.dialog_, 0, 1, 0.3)

				var_330_18:setOnUpdate(LuaHelper.FloatAction(function(arg_331_0)
					arg_327_1.dialogCg_.alpha = arg_331_0
				end))
				var_330_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_327_1.dialog_)
					var_330_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_327_1.duration_ = arg_327_1.duration_ + 0.3

				SetActive(arg_327_1.leftNameGo_, false)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_19 = arg_327_1:FormatText(arg_327_1:GetWordFromCfg(424041079).content)

				arg_327_1.text_.text = var_330_19

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_21 = 41 <= 0 and var_330_17 or var_330_17 * (utf8.len(var_330_19) / 41)

				if (41 <= 0 and var_330_17 or var_330_17 * (utf8.len(var_330_19) / 41)) > 0 and var_330_17 < var_330_21 then
					arg_327_1.talkMaxDuration = var_330_21
					var_330_16 = var_330_16 + 0.3

					if var_330_21 + var_330_16 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_21 + var_330_16
					end
				end

				arg_327_1.text_.text = var_330_19
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)
				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_22 = var_330_16 + 0.3
			local var_330_23 = math.max(var_330_17, arg_327_1.talkMaxDuration)

			if var_330_16 + 0.3 <= arg_327_1.time_ and arg_327_1.time_ < var_330_22 + var_330_23 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_22) / var_330_23

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_22 + var_330_23 and arg_327_1.time_ < var_330_22 + var_330_23 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play424041080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 424041080
		arg_333_1.duration_ = 1.7

		local var_333_0 = {
			zh = 1.466,
			ja = 1.7
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
				arg_333_0:Play424041081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1094"]) and arg_333_1.var_.actorSpriteComps1094 == nil then
				arg_333_1.var_.actorSpriteComps1094 = arg_333_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_336_0 = 0.2

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1094"]) then
				if arg_333_1.var_.actorSpriteComps1094 then
					for iter_336_0, iter_336_1 in pairs(arg_333_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_336_1 then
							if arg_333_1.isInRecall_ then
								iter_336_1.color = Color.New(Mathf.Lerp(iter_336_1.color.r, arg_333_1.hightColor1.r, (arg_333_1.time_ - 0) / var_336_0), Mathf.Lerp(iter_336_1.color.g, arg_333_1.hightColor1.g, (arg_333_1.time_ - 0) / var_336_0), (Mathf.Lerp(iter_336_1.color.b, arg_333_1.hightColor1.b, (arg_333_1.time_ - 0) / var_336_0)))
							else
								local var_336_1 = Mathf.Lerp(iter_336_1.color.r, 1, (arg_333_1.time_ - 0) / var_336_0)

								iter_336_1.color = Color.New(var_336_1, var_336_1, var_336_1)
							end
						end
					end
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1094"]) and arg_333_1.var_.actorSpriteComps1094 then
				for iter_336_2, iter_336_3 in pairs(arg_333_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_336_3 then
						iter_336_3.color = arg_333_1.isInRecall_ and (arg_333_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_333_1.var_.actorSpriteComps1094 = nil
			end

			local var_336_2 = arg_333_1.actors_["1094"].transform

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.var_.moveOldPos1094 = var_336_2.localPosition
				var_336_2.localScale = Vector3.New(1, 1, 1)

				arg_333_1:CheckSpriteTmpPos("1094", 2)

				for iter_336_4 = 0, var_336_2.childCount - 1 do
					local var_336_3 = var_336_2:GetChild(iter_336_4)

					if var_336_3.name == "" or not string.find(var_336_3.name, "split") then
						var_336_3.gameObject:SetActive(true)
					else
						var_336_3.gameObject:SetActive(false)
					end
				end
			end

			local var_336_4 = 0.001

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_4 then
				var_336_2.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1094, Vector3.New(-380, -335, -230), (arg_333_1.time_ - 0) / var_336_4)
			end

			if arg_333_1.time_ >= 0 + var_336_4 and arg_333_1.time_ < 0 + var_336_4 + arg_336_0 then
				var_336_2.localPosition = Vector3.New(-380, -335, -230)
			end

			local var_336_5 = 0
			local var_336_6 = 0.15

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_5 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_7 = arg_333_1:GetWordFromCfg(424041080)
				local var_336_8 = arg_333_1:FormatText(var_336_7.content)

				arg_333_1.text_.text = var_336_8

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_10 = 6 <= 0 and var_336_6 or var_336_6 * (utf8.len(var_336_8) / 6)

				if (6 <= 0 and var_336_6 or var_336_6 * (utf8.len(var_336_8) / 6)) > 0 and var_336_6 < var_336_10 then
					arg_333_1.talkMaxDuration = var_336_10

					if var_336_10 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_10 + var_336_5
					end
				end

				arg_333_1.text_.text = var_336_8
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041080", "story_v_out_424041.awb") ~= 0 then
					local var_336_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041080", "story_v_out_424041.awb") / 1000

					if var_336_11 + var_336_5 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_11 + var_336_5
					end

					if var_336_7.prefab_name ~= "" and arg_333_1.actors_[var_336_7.prefab_name] ~= nil then
						local var_336_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_7.prefab_name].transform, "story_v_out_424041", "424041080", "story_v_out_424041.awb")

						arg_333_1:RecordAudio("424041080", var_336_12)
						arg_333_1:RecordAudio("424041080", var_336_12)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_424041", "424041080", "story_v_out_424041.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_424041", "424041080", "story_v_out_424041.awb")
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

		arg_333_1.nodeConfigList_ = {
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

		arg_333_1:InitPlayNodeList()
	end,
	Play424041081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 424041081
		arg_337_1.duration_ = 2.9

		local var_337_0 = {
			zh = 2.9,
			ja = 2.033
		}
		local var_337_1 = manager.audio:GetLocalizationFlag()

		if var_337_0[var_337_1] ~= nil then
			arg_337_1.duration_ = var_337_0[var_337_1]
		end

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play424041082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if arg_337_1.actors_["10153"] == nil then
				local var_340_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10153")

				if not isNil(var_340_0) then
					local var_340_1 = Object.Instantiate(var_340_0, arg_337_1.canvasGo_.transform)

					var_340_1.transform:SetSiblingIndex(1)

					var_340_1.name = "10153"
					var_340_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_337_1.actors_["10153"] = var_340_1

					if arg_337_1.isInRecall_ then
						for iter_340_0, iter_340_1 in ipairs((var_340_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_340_1.color = arg_337_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_340_2 = arg_337_1.actors_["10153"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.actorSpriteComps10153 == nil then
				arg_337_1.var_.actorSpriteComps10153 = var_340_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_3 = 0.2

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_3 and not isNil(var_340_2) then
				if arg_337_1.var_.actorSpriteComps10153 then
					for iter_340_2, iter_340_3 in pairs(arg_337_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_340_3 then
							if arg_337_1.isInRecall_ then
								iter_340_3.color = Color.New(Mathf.Lerp(iter_340_3.color.r, arg_337_1.hightColor1.r, (arg_337_1.time_ - 0) / var_340_3), Mathf.Lerp(iter_340_3.color.g, arg_337_1.hightColor1.g, (arg_337_1.time_ - 0) / var_340_3), (Mathf.Lerp(iter_340_3.color.b, arg_337_1.hightColor1.b, (arg_337_1.time_ - 0) / var_340_3)))
							else
								local var_340_4 = Mathf.Lerp(iter_340_3.color.r, 1, (arg_337_1.time_ - 0) / var_340_3)

								iter_340_3.color = Color.New(var_340_4, var_340_4, var_340_4)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= 0 + var_340_3 and arg_337_1.time_ < 0 + var_340_3 + arg_340_0 and not isNil(var_340_2) and arg_337_1.var_.actorSpriteComps10153 then
				for iter_340_4, iter_340_5 in pairs(arg_337_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_340_5 then
						iter_340_5.color = arg_337_1.isInRecall_ and (arg_337_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_337_1.var_.actorSpriteComps10153 = nil
			end

			local var_340_5 = arg_337_1.actors_["1094"]

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(var_340_5) and arg_337_1.var_.actorSpriteComps1094 == nil then
				arg_337_1.var_.actorSpriteComps1094 = var_340_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_340_6 = 0.2

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_6 and not isNil(var_340_5) then
				if arg_337_1.var_.actorSpriteComps1094 then
					for iter_340_6, iter_340_7 in pairs(arg_337_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_340_7 then
							if arg_337_1.isInRecall_ then
								iter_340_7.color = Color.New(Mathf.Lerp(iter_340_7.color.r, arg_337_1.hightColor2.r, (arg_337_1.time_ - 0) / var_340_6), Mathf.Lerp(iter_340_7.color.g, arg_337_1.hightColor2.g, (arg_337_1.time_ - 0) / var_340_6), (Mathf.Lerp(iter_340_7.color.b, arg_337_1.hightColor2.b, (arg_337_1.time_ - 0) / var_340_6)))
							else
								local var_340_7 = Mathf.Lerp(iter_340_7.color.r, 0.5, (arg_337_1.time_ - 0) / var_340_6)

								iter_340_7.color = Color.New(var_340_7, var_340_7, var_340_7)
							end
						end
					end
				end
			end

			if arg_337_1.time_ >= 0 + var_340_6 and arg_337_1.time_ < 0 + var_340_6 + arg_340_0 and not isNil(var_340_5) and arg_337_1.var_.actorSpriteComps1094 then
				for iter_340_8, iter_340_9 in pairs(arg_337_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_340_9 then
						iter_340_9.color = arg_337_1.isInRecall_ and (arg_337_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_337_1.var_.actorSpriteComps1094 = nil
			end

			local var_340_8 = arg_337_1.actors_["10153"].transform

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.var_.moveOldPos10153 = var_340_8.localPosition
				var_340_8.localScale = Vector3.New(1, 1, 1)

				arg_337_1:CheckSpriteTmpPos("10153", 4)

				for iter_340_10 = 0, var_340_8.childCount - 1 do
					local var_340_9 = var_340_8:GetChild(iter_340_10)

					if var_340_9.name == "" or not string.find(var_340_9.name, "split") then
						var_340_9.gameObject:SetActive(true)
					else
						var_340_9.gameObject:SetActive(false)
					end
				end
			end

			local var_340_10 = 0.001

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_10 then
				var_340_8.localPosition = Vector3.Lerp(arg_337_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_337_1.time_ - 0) / var_340_10)
			end

			if arg_337_1.time_ >= 0 + var_340_10 and arg_337_1.time_ < 0 + var_340_10 + arg_340_0 then
				var_340_8.localPosition = Vector3.New(400, -395, -330)
			end

			local var_340_11 = 0
			local var_340_12 = 0.25

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_11 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_13 = arg_337_1:GetWordFromCfg(424041081)
				local var_340_14 = arg_337_1:FormatText(var_340_13.content)

				arg_337_1.text_.text = var_340_14

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_16 = 10 <= 0 and var_340_12 or var_340_12 * (utf8.len(var_340_14) / 10)

				if (10 <= 0 and var_340_12 or var_340_12 * (utf8.len(var_340_14) / 10)) > 0 and var_340_12 < var_340_16 then
					arg_337_1.talkMaxDuration = var_340_16

					if var_340_16 + var_340_11 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_16 + var_340_11
					end
				end

				arg_337_1.text_.text = var_340_14
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041081", "story_v_out_424041.awb") ~= 0 then
					local var_340_17 = manager.audio:GetVoiceLength("story_v_out_424041", "424041081", "story_v_out_424041.awb") / 1000

					if var_340_17 + var_340_11 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_17 + var_340_11
					end

					if var_340_13.prefab_name ~= "" and arg_337_1.actors_[var_340_13.prefab_name] ~= nil then
						local var_340_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_337_1.actors_[var_340_13.prefab_name].transform, "story_v_out_424041", "424041081", "story_v_out_424041.awb")

						arg_337_1:RecordAudio("424041081", var_340_18)
						arg_337_1:RecordAudio("424041081", var_340_18)
					else
						arg_337_1:AudioAction("play", "voice", "story_v_out_424041", "424041081", "story_v_out_424041.awb")
					end

					arg_337_1:RecordHistoryTalkVoice("story_v_out_424041", "424041081", "story_v_out_424041.awb")
				end

				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_19 = math.max(var_340_12, arg_337_1.talkMaxDuration)

			if var_340_11 <= arg_337_1.time_ and arg_337_1.time_ < var_340_11 + var_340_19 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_11) / var_340_19

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_11 + var_340_19 and arg_337_1.time_ < var_340_11 + var_340_19 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_337_1:InitPlayNodeList()
	end,
	Play424041082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 424041082
		arg_341_1.duration_ = 1.8

		local var_341_0 = {
			zh = 1.366,
			ja = 1.8
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
				arg_341_0:Play424041083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["1094"]) and arg_341_1.var_.actorSpriteComps1094 == nil then
				arg_341_1.var_.actorSpriteComps1094 = arg_341_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_0 = 0.2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["1094"]) then
				if arg_341_1.var_.actorSpriteComps1094 then
					for iter_344_0, iter_344_1 in pairs(arg_341_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_344_1 then
							if arg_341_1.isInRecall_ then
								iter_344_1.color = Color.New(Mathf.Lerp(iter_344_1.color.r, arg_341_1.hightColor1.r, (arg_341_1.time_ - 0) / var_344_0), Mathf.Lerp(iter_344_1.color.g, arg_341_1.hightColor1.g, (arg_341_1.time_ - 0) / var_344_0), (Mathf.Lerp(iter_344_1.color.b, arg_341_1.hightColor1.b, (arg_341_1.time_ - 0) / var_344_0)))
							else
								local var_344_1 = Mathf.Lerp(iter_344_1.color.r, 1, (arg_341_1.time_ - 0) / var_344_0)

								iter_344_1.color = Color.New(var_344_1, var_344_1, var_344_1)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["1094"]) and arg_341_1.var_.actorSpriteComps1094 then
				for iter_344_2, iter_344_3 in pairs(arg_341_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_344_3 then
						iter_344_3.color = arg_341_1.isInRecall_ and (arg_341_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_341_1.var_.actorSpriteComps1094 = nil
			end

			local var_344_2 = arg_341_1.actors_["10153"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.actorSpriteComps10153 == nil then
				arg_341_1.var_.actorSpriteComps10153 = var_344_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_344_3 = 0.2

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_3 and not isNil(var_344_2) then
				if arg_341_1.var_.actorSpriteComps10153 then
					for iter_344_4, iter_344_5 in pairs(arg_341_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_344_5 then
							if arg_341_1.isInRecall_ then
								iter_344_5.color = Color.New(Mathf.Lerp(iter_344_5.color.r, arg_341_1.hightColor2.r, (arg_341_1.time_ - 0) / var_344_3), Mathf.Lerp(iter_344_5.color.g, arg_341_1.hightColor2.g, (arg_341_1.time_ - 0) / var_344_3), (Mathf.Lerp(iter_344_5.color.b, arg_341_1.hightColor2.b, (arg_341_1.time_ - 0) / var_344_3)))
							else
								local var_344_4 = Mathf.Lerp(iter_344_5.color.r, 0.5, (arg_341_1.time_ - 0) / var_344_3)

								iter_344_5.color = Color.New(var_344_4, var_344_4, var_344_4)
							end
						end
					end
				end
			end

			if arg_341_1.time_ >= 0 + var_344_3 and arg_341_1.time_ < 0 + var_344_3 + arg_344_0 and not isNil(var_344_2) and arg_341_1.var_.actorSpriteComps10153 then
				for iter_344_6, iter_344_7 in pairs(arg_341_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_344_7 then
						iter_344_7.color = arg_341_1.isInRecall_ and (arg_341_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_341_1.var_.actorSpriteComps10153 = nil
			end

			local var_344_5 = arg_341_1.actors_["1094"].transform

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1094 = var_344_5.localPosition
				var_344_5.localScale = Vector3.New(1, 1, 1)

				arg_341_1:CheckSpriteTmpPos("1094", 2)

				for iter_344_8 = 0, var_344_5.childCount - 1 do
					local var_344_6 = var_344_5:GetChild(iter_344_8)

					if var_344_6.name == "" or not string.find(var_344_6.name, "split") then
						var_344_6.gameObject:SetActive(true)
					else
						var_344_6.gameObject:SetActive(false)
					end
				end
			end

			local var_344_7 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_7 then
				var_344_5.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1094, Vector3.New(-380, -335, -230), (arg_341_1.time_ - 0) / var_344_7)
			end

			if arg_341_1.time_ >= 0 + var_344_7 and arg_341_1.time_ < 0 + var_344_7 + arg_344_0 then
				var_344_5.localPosition = Vector3.New(-380, -335, -230)
			end

			local var_344_8 = 0
			local var_344_9 = 0.15

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_8 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_10 = arg_341_1:GetWordFromCfg(424041082)
				local var_344_11 = arg_341_1:FormatText(var_344_10.content)

				arg_341_1.text_.text = var_344_11

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_13 = 6 <= 0 and var_344_9 or var_344_9 * (utf8.len(var_344_11) / 6)

				if (6 <= 0 and var_344_9 or var_344_9 * (utf8.len(var_344_11) / 6)) > 0 and var_344_9 < var_344_13 then
					arg_341_1.talkMaxDuration = var_344_13

					if var_344_13 + var_344_8 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_13 + var_344_8
					end
				end

				arg_341_1.text_.text = var_344_11
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041082", "story_v_out_424041.awb") ~= 0 then
					local var_344_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041082", "story_v_out_424041.awb") / 1000

					if var_344_14 + var_344_8 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_14 + var_344_8
					end

					if var_344_10.prefab_name ~= "" and arg_341_1.actors_[var_344_10.prefab_name] ~= nil then
						local var_344_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_10.prefab_name].transform, "story_v_out_424041", "424041082", "story_v_out_424041.awb")

						arg_341_1:RecordAudio("424041082", var_344_15)
						arg_341_1:RecordAudio("424041082", var_344_15)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_424041", "424041082", "story_v_out_424041.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_424041", "424041082", "story_v_out_424041.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_16 = math.max(var_344_9, arg_341_1.talkMaxDuration)

			if var_344_8 <= arg_341_1.time_ and arg_341_1.time_ < var_344_8 + var_344_16 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_8) / var_344_16

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_8 + var_344_16 and arg_341_1.time_ < var_344_8 + var_344_16 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
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

		arg_341_1:InitPlayNodeList()
	end,
	Play424041083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 424041083
		arg_345_1.duration_ = 8.57

		local var_345_0 = {
			zh = 7.933,
			ja = 8.566
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
				arg_345_0:Play424041084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["10153"]) and arg_345_1.var_.actorSpriteComps10153 == nil then
				arg_345_1.var_.actorSpriteComps10153 = arg_345_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_0 = 0.2

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["10153"]) then
				if arg_345_1.var_.actorSpriteComps10153 then
					for iter_348_0, iter_348_1 in pairs(arg_345_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_348_1 then
							if arg_345_1.isInRecall_ then
								iter_348_1.color = Color.New(Mathf.Lerp(iter_348_1.color.r, arg_345_1.hightColor1.r, (arg_345_1.time_ - 0) / var_348_0), Mathf.Lerp(iter_348_1.color.g, arg_345_1.hightColor1.g, (arg_345_1.time_ - 0) / var_348_0), (Mathf.Lerp(iter_348_1.color.b, arg_345_1.hightColor1.b, (arg_345_1.time_ - 0) / var_348_0)))
							else
								local var_348_1 = Mathf.Lerp(iter_348_1.color.r, 1, (arg_345_1.time_ - 0) / var_348_0)

								iter_348_1.color = Color.New(var_348_1, var_348_1, var_348_1)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["10153"]) and arg_345_1.var_.actorSpriteComps10153 then
				for iter_348_2, iter_348_3 in pairs(arg_345_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_348_3 then
						iter_348_3.color = arg_345_1.isInRecall_ and (arg_345_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_345_1.var_.actorSpriteComps10153 = nil
			end

			local var_348_2 = arg_345_1.actors_["1094"]

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(var_348_2) and arg_345_1.var_.actorSpriteComps1094 == nil then
				arg_345_1.var_.actorSpriteComps1094 = var_348_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_348_3 = 0.2

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_3 and not isNil(var_348_2) then
				if arg_345_1.var_.actorSpriteComps1094 then
					for iter_348_4, iter_348_5 in pairs(arg_345_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_348_5 then
							if arg_345_1.isInRecall_ then
								iter_348_5.color = Color.New(Mathf.Lerp(iter_348_5.color.r, arg_345_1.hightColor2.r, (arg_345_1.time_ - 0) / var_348_3), Mathf.Lerp(iter_348_5.color.g, arg_345_1.hightColor2.g, (arg_345_1.time_ - 0) / var_348_3), (Mathf.Lerp(iter_348_5.color.b, arg_345_1.hightColor2.b, (arg_345_1.time_ - 0) / var_348_3)))
							else
								local var_348_4 = Mathf.Lerp(iter_348_5.color.r, 0.5, (arg_345_1.time_ - 0) / var_348_3)

								iter_348_5.color = Color.New(var_348_4, var_348_4, var_348_4)
							end
						end
					end
				end
			end

			if arg_345_1.time_ >= 0 + var_348_3 and arg_345_1.time_ < 0 + var_348_3 + arg_348_0 and not isNil(var_348_2) and arg_345_1.var_.actorSpriteComps1094 then
				for iter_348_6, iter_348_7 in pairs(arg_345_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_348_7 then
						iter_348_7.color = arg_345_1.isInRecall_ and (arg_345_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_345_1.var_.actorSpriteComps1094 = nil
			end

			local var_348_5 = arg_345_1.actors_["10153"].transform

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos10153 = var_348_5.localPosition
				var_348_5.localScale = Vector3.New(1, 1, 1)

				arg_345_1:CheckSpriteTmpPos("10153", 4)

				for iter_348_8 = 0, var_348_5.childCount - 1 do
					local var_348_6 = var_348_5:GetChild(iter_348_8)

					if var_348_6.name == "" or not string.find(var_348_6.name, "split") then
						var_348_6.gameObject:SetActive(true)
					else
						var_348_6.gameObject:SetActive(false)
					end
				end
			end

			local var_348_7 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_7 then
				var_348_5.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_345_1.time_ - 0) / var_348_7)
			end

			if arg_345_1.time_ >= 0 + var_348_7 and arg_345_1.time_ < 0 + var_348_7 + arg_348_0 then
				var_348_5.localPosition = Vector3.New(400, -395, -330)
			end

			local var_348_8 = 0
			local var_348_9 = 0.75

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_8 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_10 = arg_345_1:GetWordFromCfg(424041083)
				local var_348_11 = arg_345_1:FormatText(var_348_10.content)

				arg_345_1.text_.text = var_348_11

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_13 = 30 <= 0 and var_348_9 or var_348_9 * (utf8.len(var_348_11) / 30)

				if (30 <= 0 and var_348_9 or var_348_9 * (utf8.len(var_348_11) / 30)) > 0 and var_348_9 < var_348_13 then
					arg_345_1.talkMaxDuration = var_348_13

					if var_348_13 + var_348_8 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_13 + var_348_8
					end
				end

				arg_345_1.text_.text = var_348_11
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041083", "story_v_out_424041.awb") ~= 0 then
					local var_348_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041083", "story_v_out_424041.awb") / 1000

					if var_348_14 + var_348_8 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_14 + var_348_8
					end

					if var_348_10.prefab_name ~= "" and arg_345_1.actors_[var_348_10.prefab_name] ~= nil then
						local var_348_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_345_1.actors_[var_348_10.prefab_name].transform, "story_v_out_424041", "424041083", "story_v_out_424041.awb")

						arg_345_1:RecordAudio("424041083", var_348_15)
						arg_345_1:RecordAudio("424041083", var_348_15)
					else
						arg_345_1:AudioAction("play", "voice", "story_v_out_424041", "424041083", "story_v_out_424041.awb")
					end

					arg_345_1:RecordHistoryTalkVoice("story_v_out_424041", "424041083", "story_v_out_424041.awb")
				end

				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_16 = math.max(var_348_9, arg_345_1.talkMaxDuration)

			if var_348_8 <= arg_345_1.time_ and arg_345_1.time_ < var_348_8 + var_348_16 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_8) / var_348_16

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_8 + var_348_16 and arg_345_1.time_ < var_348_8 + var_348_16 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
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
	Play424041084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 424041084
		arg_349_1.duration_ = 4.43

		local var_349_0 = {
			zh = 4.2,
			ja = 4.433
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
				arg_349_0:Play424041085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(arg_349_1.actors_["1094"]) and arg_349_1.var_.actorSpriteComps1094 == nil then
				arg_349_1.var_.actorSpriteComps1094 = arg_349_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_0 = 0.2

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 and not isNil(arg_349_1.actors_["1094"]) then
				if arg_349_1.var_.actorSpriteComps1094 then
					for iter_352_0, iter_352_1 in pairs(arg_349_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_352_1 then
							if arg_349_1.isInRecall_ then
								iter_352_1.color = Color.New(Mathf.Lerp(iter_352_1.color.r, arg_349_1.hightColor1.r, (arg_349_1.time_ - 0) / var_352_0), Mathf.Lerp(iter_352_1.color.g, arg_349_1.hightColor1.g, (arg_349_1.time_ - 0) / var_352_0), (Mathf.Lerp(iter_352_1.color.b, arg_349_1.hightColor1.b, (arg_349_1.time_ - 0) / var_352_0)))
							else
								local var_352_1 = Mathf.Lerp(iter_352_1.color.r, 1, (arg_349_1.time_ - 0) / var_352_0)

								iter_352_1.color = Color.New(var_352_1, var_352_1, var_352_1)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 and not isNil(arg_349_1.actors_["1094"]) and arg_349_1.var_.actorSpriteComps1094 then
				for iter_352_2, iter_352_3 in pairs(arg_349_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_352_3 then
						iter_352_3.color = arg_349_1.isInRecall_ and (arg_349_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_349_1.var_.actorSpriteComps1094 = nil
			end

			local var_352_2 = arg_349_1.actors_["10153"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_2) and arg_349_1.var_.actorSpriteComps10153 == nil then
				arg_349_1.var_.actorSpriteComps10153 = var_352_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_352_3 = 0.2

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_3 and not isNil(var_352_2) then
				if arg_349_1.var_.actorSpriteComps10153 then
					for iter_352_4, iter_352_5 in pairs(arg_349_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_352_5 then
							if arg_349_1.isInRecall_ then
								iter_352_5.color = Color.New(Mathf.Lerp(iter_352_5.color.r, arg_349_1.hightColor2.r, (arg_349_1.time_ - 0) / var_352_3), Mathf.Lerp(iter_352_5.color.g, arg_349_1.hightColor2.g, (arg_349_1.time_ - 0) / var_352_3), (Mathf.Lerp(iter_352_5.color.b, arg_349_1.hightColor2.b, (arg_349_1.time_ - 0) / var_352_3)))
							else
								local var_352_4 = Mathf.Lerp(iter_352_5.color.r, 0.5, (arg_349_1.time_ - 0) / var_352_3)

								iter_352_5.color = Color.New(var_352_4, var_352_4, var_352_4)
							end
						end
					end
				end
			end

			if arg_349_1.time_ >= 0 + var_352_3 and arg_349_1.time_ < 0 + var_352_3 + arg_352_0 and not isNil(var_352_2) and arg_349_1.var_.actorSpriteComps10153 then
				for iter_352_6, iter_352_7 in pairs(arg_349_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_352_7 then
						iter_352_7.color = arg_349_1.isInRecall_ and (arg_349_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_349_1.var_.actorSpriteComps10153 = nil
			end

			local var_352_5 = arg_349_1.actors_["1094"].transform

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos1094 = var_352_5.localPosition
				var_352_5.localScale = Vector3.New(1, 1, 1)

				arg_349_1:CheckSpriteTmpPos("1094", 2)

				for iter_352_8 = 0, var_352_5.childCount - 1 do
					local var_352_6 = var_352_5:GetChild(iter_352_8)

					if var_352_6.name == "split_4" then
						var_352_6:SetAsLastSibling()
						var_352_6.gameObject:SetActive(true)

						arg_349_1.var_.actorSpriteSplit1094 = var_352_6.gameObject:GetComponent(typeof(Image))

						arg_349_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_352_7 = 0.5

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_7 then
				var_352_5.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1094, Vector3.New(-380, -335, -230), (arg_349_1.time_ - 0) / var_352_7)

				if arg_349_1.var_.actorSpriteSplit1094 ~= nil then
					arg_349_1.var_.actorSpriteSplit1094:SetAlpha((arg_349_1.time_ - 0) / var_352_7)
				end
			end

			if arg_349_1.time_ >= 0 + var_352_7 and arg_349_1.time_ < 0 + var_352_7 + arg_352_0 then
				var_352_5.localPosition = Vector3.New(-380, -335, -230)

				if arg_349_1.var_.actorSpriteSplit1094 ~= nil then
					arg_349_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_352_8 = 0
			local var_352_9 = 0.4

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_8 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_10 = arg_349_1:GetWordFromCfg(424041084)
				local var_352_11 = arg_349_1:FormatText(var_352_10.content)

				arg_349_1.text_.text = var_352_11

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_13 = 16 <= 0 and var_352_9 or var_352_9 * (utf8.len(var_352_11) / 16)

				if (16 <= 0 and var_352_9 or var_352_9 * (utf8.len(var_352_11) / 16)) > 0 and var_352_9 < var_352_13 then
					arg_349_1.talkMaxDuration = var_352_13

					if var_352_13 + var_352_8 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_13 + var_352_8
					end
				end

				arg_349_1.text_.text = var_352_11
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041084", "story_v_out_424041.awb") ~= 0 then
					local var_352_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041084", "story_v_out_424041.awb") / 1000

					if var_352_14 + var_352_8 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_14 + var_352_8
					end

					if var_352_10.prefab_name ~= "" and arg_349_1.actors_[var_352_10.prefab_name] ~= nil then
						local var_352_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_10.prefab_name].transform, "story_v_out_424041", "424041084", "story_v_out_424041.awb")

						arg_349_1:RecordAudio("424041084", var_352_15)
						arg_349_1:RecordAudio("424041084", var_352_15)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_424041", "424041084", "story_v_out_424041.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_424041", "424041084", "story_v_out_424041.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_16 = math.max(var_352_9, arg_349_1.talkMaxDuration)

			if var_352_8 <= arg_349_1.time_ and arg_349_1.time_ < var_352_8 + var_352_16 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_8) / var_352_16

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_8 + var_352_16 and arg_349_1.time_ < var_352_8 + var_352_16 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
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

		arg_349_1:InitPlayNodeList()
	end,
	Play424041085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 424041085
		arg_353_1.duration_ = 10.77

		local var_353_0 = {
			zh = 9.833,
			ja = 10.766
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
				arg_353_0:Play424041086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(arg_353_1.actors_["10153"]) and arg_353_1.var_.actorSpriteComps10153 == nil then
				arg_353_1.var_.actorSpriteComps10153 = arg_353_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_0 = 0.2

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 and not isNil(arg_353_1.actors_["10153"]) then
				if arg_353_1.var_.actorSpriteComps10153 then
					for iter_356_0, iter_356_1 in pairs(arg_353_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_356_1 then
							if arg_353_1.isInRecall_ then
								iter_356_1.color = Color.New(Mathf.Lerp(iter_356_1.color.r, arg_353_1.hightColor1.r, (arg_353_1.time_ - 0) / var_356_0), Mathf.Lerp(iter_356_1.color.g, arg_353_1.hightColor1.g, (arg_353_1.time_ - 0) / var_356_0), (Mathf.Lerp(iter_356_1.color.b, arg_353_1.hightColor1.b, (arg_353_1.time_ - 0) / var_356_0)))
							else
								local var_356_1 = Mathf.Lerp(iter_356_1.color.r, 1, (arg_353_1.time_ - 0) / var_356_0)

								iter_356_1.color = Color.New(var_356_1, var_356_1, var_356_1)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 and not isNil(arg_353_1.actors_["10153"]) and arg_353_1.var_.actorSpriteComps10153 then
				for iter_356_2, iter_356_3 in pairs(arg_353_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_356_3 then
						iter_356_3.color = arg_353_1.isInRecall_ and (arg_353_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_353_1.var_.actorSpriteComps10153 = nil
			end

			local var_356_2 = arg_353_1.actors_["1094"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.actorSpriteComps1094 == nil then
				arg_353_1.var_.actorSpriteComps1094 = var_356_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_356_3 = 0.2

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_3 and not isNil(var_356_2) then
				if arg_353_1.var_.actorSpriteComps1094 then
					for iter_356_4, iter_356_5 in pairs(arg_353_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_356_5 then
							if arg_353_1.isInRecall_ then
								iter_356_5.color = Color.New(Mathf.Lerp(iter_356_5.color.r, arg_353_1.hightColor2.r, (arg_353_1.time_ - 0) / var_356_3), Mathf.Lerp(iter_356_5.color.g, arg_353_1.hightColor2.g, (arg_353_1.time_ - 0) / var_356_3), (Mathf.Lerp(iter_356_5.color.b, arg_353_1.hightColor2.b, (arg_353_1.time_ - 0) / var_356_3)))
							else
								local var_356_4 = Mathf.Lerp(iter_356_5.color.r, 0.5, (arg_353_1.time_ - 0) / var_356_3)

								iter_356_5.color = Color.New(var_356_4, var_356_4, var_356_4)
							end
						end
					end
				end
			end

			if arg_353_1.time_ >= 0 + var_356_3 and arg_353_1.time_ < 0 + var_356_3 + arg_356_0 and not isNil(var_356_2) and arg_353_1.var_.actorSpriteComps1094 then
				for iter_356_6, iter_356_7 in pairs(arg_353_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_356_7 then
						iter_356_7.color = arg_353_1.isInRecall_ and (arg_353_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_353_1.var_.actorSpriteComps1094 = nil
			end

			local var_356_5 = arg_353_1.actors_["10153"].transform

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos10153 = var_356_5.localPosition
				var_356_5.localScale = Vector3.New(1, 1, 1)

				arg_353_1:CheckSpriteTmpPos("10153", 4)

				for iter_356_8 = 0, var_356_5.childCount - 1 do
					local var_356_6 = var_356_5:GetChild(iter_356_8)

					if var_356_6.name == "" or not string.find(var_356_6.name, "split") then
						var_356_6.gameObject:SetActive(true)
					else
						var_356_6.gameObject:SetActive(false)
					end
				end
			end

			local var_356_7 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_7 then
				var_356_5.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_353_1.time_ - 0) / var_356_7)
			end

			if arg_353_1.time_ >= 0 + var_356_7 and arg_353_1.time_ < 0 + var_356_7 + arg_356_0 then
				var_356_5.localPosition = Vector3.New(400, -395, -330)
			end

			local var_356_8 = 0
			local var_356_9 = 0.75

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_8 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_10 = arg_353_1:GetWordFromCfg(424041085)
				local var_356_11 = arg_353_1:FormatText(var_356_10.content)

				arg_353_1.text_.text = var_356_11

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_13 = 30 <= 0 and var_356_9 or var_356_9 * (utf8.len(var_356_11) / 30)

				if (30 <= 0 and var_356_9 or var_356_9 * (utf8.len(var_356_11) / 30)) > 0 and var_356_9 < var_356_13 then
					arg_353_1.talkMaxDuration = var_356_13

					if var_356_13 + var_356_8 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_13 + var_356_8
					end
				end

				arg_353_1.text_.text = var_356_11
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041085", "story_v_out_424041.awb") ~= 0 then
					local var_356_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041085", "story_v_out_424041.awb") / 1000

					if var_356_14 + var_356_8 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_14 + var_356_8
					end

					if var_356_10.prefab_name ~= "" and arg_353_1.actors_[var_356_10.prefab_name] ~= nil then
						local var_356_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_10.prefab_name].transform, "story_v_out_424041", "424041085", "story_v_out_424041.awb")

						arg_353_1:RecordAudio("424041085", var_356_15)
						arg_353_1:RecordAudio("424041085", var_356_15)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_424041", "424041085", "story_v_out_424041.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_424041", "424041085", "story_v_out_424041.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_16 = math.max(var_356_9, arg_353_1.talkMaxDuration)

			if var_356_8 <= arg_353_1.time_ and arg_353_1.time_ < var_356_8 + var_356_16 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_8) / var_356_16

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_8 + var_356_16 and arg_353_1.time_ < var_356_8 + var_356_16 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
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
	Play424041086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 424041086
		arg_357_1.duration_ = 3.2

		local var_357_0 = {
			zh = 2.233,
			ja = 3.2
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
				arg_357_0:Play424041087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1094"]) and arg_357_1.var_.actorSpriteComps1094 == nil then
				arg_357_1.var_.actorSpriteComps1094 = arg_357_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_0 = 0.2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1094"]) then
				if arg_357_1.var_.actorSpriteComps1094 then
					for iter_360_0, iter_360_1 in pairs(arg_357_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_360_1 then
							if arg_357_1.isInRecall_ then
								iter_360_1.color = Color.New(Mathf.Lerp(iter_360_1.color.r, arg_357_1.hightColor1.r, (arg_357_1.time_ - 0) / var_360_0), Mathf.Lerp(iter_360_1.color.g, arg_357_1.hightColor1.g, (arg_357_1.time_ - 0) / var_360_0), (Mathf.Lerp(iter_360_1.color.b, arg_357_1.hightColor1.b, (arg_357_1.time_ - 0) / var_360_0)))
							else
								local var_360_1 = Mathf.Lerp(iter_360_1.color.r, 1, (arg_357_1.time_ - 0) / var_360_0)

								iter_360_1.color = Color.New(var_360_1, var_360_1, var_360_1)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1094"]) and arg_357_1.var_.actorSpriteComps1094 then
				for iter_360_2, iter_360_3 in pairs(arg_357_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_360_3 then
						iter_360_3.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_357_1.var_.actorSpriteComps1094 = nil
			end

			local var_360_2 = arg_357_1.actors_["10153"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.actorSpriteComps10153 == nil then
				arg_357_1.var_.actorSpriteComps10153 = var_360_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_360_3 = 0.2

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_3 and not isNil(var_360_2) then
				if arg_357_1.var_.actorSpriteComps10153 then
					for iter_360_4, iter_360_5 in pairs(arg_357_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_360_5 then
							if arg_357_1.isInRecall_ then
								iter_360_5.color = Color.New(Mathf.Lerp(iter_360_5.color.r, arg_357_1.hightColor2.r, (arg_357_1.time_ - 0) / var_360_3), Mathf.Lerp(iter_360_5.color.g, arg_357_1.hightColor2.g, (arg_357_1.time_ - 0) / var_360_3), (Mathf.Lerp(iter_360_5.color.b, arg_357_1.hightColor2.b, (arg_357_1.time_ - 0) / var_360_3)))
							else
								local var_360_4 = Mathf.Lerp(iter_360_5.color.r, 0.5, (arg_357_1.time_ - 0) / var_360_3)

								iter_360_5.color = Color.New(var_360_4, var_360_4, var_360_4)
							end
						end
					end
				end
			end

			if arg_357_1.time_ >= 0 + var_360_3 and arg_357_1.time_ < 0 + var_360_3 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.actorSpriteComps10153 then
				for iter_360_6, iter_360_7 in pairs(arg_357_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_360_7 then
						iter_360_7.color = arg_357_1.isInRecall_ and (arg_357_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_357_1.var_.actorSpriteComps10153 = nil
			end

			local var_360_5 = arg_357_1.actors_["1094"].transform

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1094 = var_360_5.localPosition
				var_360_5.localScale = Vector3.New(1, 1, 1)

				arg_357_1:CheckSpriteTmpPos("1094", 2)

				for iter_360_8 = 0, var_360_5.childCount - 1 do
					local var_360_6 = var_360_5:GetChild(iter_360_8)

					if var_360_6.name == "split_3" then
						var_360_6:SetAsLastSibling()
						var_360_6.gameObject:SetActive(true)

						arg_357_1.var_.actorSpriteSplit1094 = var_360_6.gameObject:GetComponent(typeof(Image))

						arg_357_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_360_7 = 0.5

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_7 then
				var_360_5.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1094, Vector3.New(-380, -335, -230), (arg_357_1.time_ - 0) / var_360_7)

				if arg_357_1.var_.actorSpriteSplit1094 ~= nil then
					arg_357_1.var_.actorSpriteSplit1094:SetAlpha((arg_357_1.time_ - 0) / var_360_7)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_7 and arg_357_1.time_ < 0 + var_360_7 + arg_360_0 then
				var_360_5.localPosition = Vector3.New(-380, -335, -230)

				if arg_357_1.var_.actorSpriteSplit1094 ~= nil then
					arg_357_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_360_8 = 0
			local var_360_9 = 0.275

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_8 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_10 = arg_357_1:GetWordFromCfg(424041086)
				local var_360_11 = arg_357_1:FormatText(var_360_10.content)

				arg_357_1.text_.text = var_360_11

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_13 = 11 <= 0 and var_360_9 or var_360_9 * (utf8.len(var_360_11) / 11)

				if (11 <= 0 and var_360_9 or var_360_9 * (utf8.len(var_360_11) / 11)) > 0 and var_360_9 < var_360_13 then
					arg_357_1.talkMaxDuration = var_360_13

					if var_360_13 + var_360_8 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_13 + var_360_8
					end
				end

				arg_357_1.text_.text = var_360_11
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041086", "story_v_out_424041.awb") ~= 0 then
					local var_360_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041086", "story_v_out_424041.awb") / 1000

					if var_360_14 + var_360_8 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_14 + var_360_8
					end

					if var_360_10.prefab_name ~= "" and arg_357_1.actors_[var_360_10.prefab_name] ~= nil then
						local var_360_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_10.prefab_name].transform, "story_v_out_424041", "424041086", "story_v_out_424041.awb")

						arg_357_1:RecordAudio("424041086", var_360_15)
						arg_357_1:RecordAudio("424041086", var_360_15)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_424041", "424041086", "story_v_out_424041.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_424041", "424041086", "story_v_out_424041.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_16 = math.max(var_360_9, arg_357_1.talkMaxDuration)

			if var_360_8 <= arg_357_1.time_ and arg_357_1.time_ < var_360_8 + var_360_16 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_8) / var_360_16

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_8 + var_360_16 and arg_357_1.time_ < var_360_8 + var_360_16 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
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

		arg_357_1:InitPlayNodeList()
	end,
	Play424041087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 424041087
		arg_361_1.duration_ = 5.53

		local var_361_0 = {
			zh = 2.366,
			ja = 5.533
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
				arg_361_0:Play424041088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["10153"]) and arg_361_1.var_.actorSpriteComps10153 == nil then
				arg_361_1.var_.actorSpriteComps10153 = arg_361_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_0 = 0.2

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["10153"]) then
				if arg_361_1.var_.actorSpriteComps10153 then
					for iter_364_0, iter_364_1 in pairs(arg_361_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_364_1 then
							if arg_361_1.isInRecall_ then
								iter_364_1.color = Color.New(Mathf.Lerp(iter_364_1.color.r, arg_361_1.hightColor1.r, (arg_361_1.time_ - 0) / var_364_0), Mathf.Lerp(iter_364_1.color.g, arg_361_1.hightColor1.g, (arg_361_1.time_ - 0) / var_364_0), (Mathf.Lerp(iter_364_1.color.b, arg_361_1.hightColor1.b, (arg_361_1.time_ - 0) / var_364_0)))
							else
								local var_364_1 = Mathf.Lerp(iter_364_1.color.r, 1, (arg_361_1.time_ - 0) / var_364_0)

								iter_364_1.color = Color.New(var_364_1, var_364_1, var_364_1)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["10153"]) and arg_361_1.var_.actorSpriteComps10153 then
				for iter_364_2, iter_364_3 in pairs(arg_361_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_364_3 then
						iter_364_3.color = arg_361_1.isInRecall_ and (arg_361_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_361_1.var_.actorSpriteComps10153 = nil
			end

			local var_364_2 = arg_361_1.actors_["1094"]

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(var_364_2) and arg_361_1.var_.actorSpriteComps1094 == nil then
				arg_361_1.var_.actorSpriteComps1094 = var_364_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_364_3 = 0.2

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_3 and not isNil(var_364_2) then
				if arg_361_1.var_.actorSpriteComps1094 then
					for iter_364_4, iter_364_5 in pairs(arg_361_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_364_5 then
							if arg_361_1.isInRecall_ then
								iter_364_5.color = Color.New(Mathf.Lerp(iter_364_5.color.r, arg_361_1.hightColor2.r, (arg_361_1.time_ - 0) / var_364_3), Mathf.Lerp(iter_364_5.color.g, arg_361_1.hightColor2.g, (arg_361_1.time_ - 0) / var_364_3), (Mathf.Lerp(iter_364_5.color.b, arg_361_1.hightColor2.b, (arg_361_1.time_ - 0) / var_364_3)))
							else
								local var_364_4 = Mathf.Lerp(iter_364_5.color.r, 0.5, (arg_361_1.time_ - 0) / var_364_3)

								iter_364_5.color = Color.New(var_364_4, var_364_4, var_364_4)
							end
						end
					end
				end
			end

			if arg_361_1.time_ >= 0 + var_364_3 and arg_361_1.time_ < 0 + var_364_3 + arg_364_0 and not isNil(var_364_2) and arg_361_1.var_.actorSpriteComps1094 then
				for iter_364_6, iter_364_7 in pairs(arg_361_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_364_7 then
						iter_364_7.color = arg_361_1.isInRecall_ and (arg_361_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_361_1.var_.actorSpriteComps1094 = nil
			end

			local var_364_5 = arg_361_1.actors_["10153"].transform

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1.var_.moveOldPos10153 = var_364_5.localPosition
				var_364_5.localScale = Vector3.New(1, 1, 1)

				arg_361_1:CheckSpriteTmpPos("10153", 4)

				for iter_364_8 = 0, var_364_5.childCount - 1 do
					local var_364_6 = var_364_5:GetChild(iter_364_8)

					if var_364_6.name == "" or not string.find(var_364_6.name, "split") then
						var_364_6.gameObject:SetActive(true)
					else
						var_364_6.gameObject:SetActive(false)
					end
				end
			end

			local var_364_7 = 0.001

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_7 then
				var_364_5.localPosition = Vector3.Lerp(arg_361_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_361_1.time_ - 0) / var_364_7)
			end

			if arg_361_1.time_ >= 0 + var_364_7 and arg_361_1.time_ < 0 + var_364_7 + arg_364_0 then
				var_364_5.localPosition = Vector3.New(400, -395, -330)
			end

			local var_364_8 = 0
			local var_364_9 = 0.35

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_8 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, true)

				arg_361_1.leftNameTxt_.text = arg_361_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_361_1.leftNameTxt_.transform)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1.leftNameTxt_.text)
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_10 = arg_361_1:GetWordFromCfg(424041087)
				local var_364_11 = arg_361_1:FormatText(var_364_10.content)

				arg_361_1.text_.text = var_364_11

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_13 = 14 <= 0 and var_364_9 or var_364_9 * (utf8.len(var_364_11) / 14)

				if (14 <= 0 and var_364_9 or var_364_9 * (utf8.len(var_364_11) / 14)) > 0 and var_364_9 < var_364_13 then
					arg_361_1.talkMaxDuration = var_364_13

					if var_364_13 + var_364_8 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_13 + var_364_8
					end
				end

				arg_361_1.text_.text = var_364_11
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041087", "story_v_out_424041.awb") ~= 0 then
					local var_364_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041087", "story_v_out_424041.awb") / 1000

					if var_364_14 + var_364_8 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_14 + var_364_8
					end

					if var_364_10.prefab_name ~= "" and arg_361_1.actors_[var_364_10.prefab_name] ~= nil then
						local var_364_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_361_1.actors_[var_364_10.prefab_name].transform, "story_v_out_424041", "424041087", "story_v_out_424041.awb")

						arg_361_1:RecordAudio("424041087", var_364_15)
						arg_361_1:RecordAudio("424041087", var_364_15)
					else
						arg_361_1:AudioAction("play", "voice", "story_v_out_424041", "424041087", "story_v_out_424041.awb")
					end

					arg_361_1:RecordHistoryTalkVoice("story_v_out_424041", "424041087", "story_v_out_424041.awb")
				end

				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_16 = math.max(var_364_9, arg_361_1.talkMaxDuration)

			if var_364_8 <= arg_361_1.time_ and arg_361_1.time_ < var_364_8 + var_364_16 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_8) / var_364_16

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_8 + var_364_16 and arg_361_1.time_ < var_364_8 + var_364_16 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_361_1:InitPlayNodeList()
	end,
	Play424041088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 424041088
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play424041089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["10153"]) and arg_365_1.var_.actorSpriteComps10153 == nil then
				arg_365_1.var_.actorSpriteComps10153 = arg_365_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_368_0 = 0.2

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["10153"]) then
				if arg_365_1.var_.actorSpriteComps10153 then
					for iter_368_0, iter_368_1 in pairs(arg_365_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_368_1 then
							if arg_365_1.isInRecall_ then
								iter_368_1.color = Color.New(Mathf.Lerp(iter_368_1.color.r, arg_365_1.hightColor2.r, (arg_365_1.time_ - 0) / var_368_0), Mathf.Lerp(iter_368_1.color.g, arg_365_1.hightColor2.g, (arg_365_1.time_ - 0) / var_368_0), (Mathf.Lerp(iter_368_1.color.b, arg_365_1.hightColor2.b, (arg_365_1.time_ - 0) / var_368_0)))
							else
								local var_368_1 = Mathf.Lerp(iter_368_1.color.r, 0.5, (arg_365_1.time_ - 0) / var_368_0)

								iter_368_1.color = Color.New(var_368_1, var_368_1, var_368_1)
							end
						end
					end
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["10153"]) and arg_365_1.var_.actorSpriteComps10153 then
				for iter_368_2, iter_368_3 in pairs(arg_365_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_368_3 then
						iter_368_3.color = arg_365_1.isInRecall_ and (arg_365_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_365_1.var_.actorSpriteComps10153 = nil
			end

			local var_368_2 = arg_365_1.actors_["10153"].transform

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos10153 = var_368_2.localPosition
				var_368_2.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("10153", 7)

				for iter_368_4 = 0, var_368_2.childCount - 1 do
					local var_368_3 = var_368_2:GetChild(iter_368_4)

					if var_368_3.name == "" or not string.find(var_368_3.name, "split") then
						var_368_3.gameObject:SetActive(true)
					else
						var_368_3.gameObject:SetActive(false)
					end
				end
			end

			local var_368_4 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_4 then
				var_368_2.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_365_1.time_ - 0) / var_368_4)
			end

			if arg_365_1.time_ >= 0 + var_368_4 and arg_365_1.time_ < 0 + var_368_4 + arg_368_0 then
				var_368_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_368_5 = arg_365_1.actors_["1094"].transform

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1.var_.moveOldPos1094 = var_368_5.localPosition
				var_368_5.localScale = Vector3.New(1, 1, 1)

				arg_365_1:CheckSpriteTmpPos("1094", 7)

				for iter_368_5 = 0, var_368_5.childCount - 1 do
					local var_368_6 = var_368_5:GetChild(iter_368_5)

					if var_368_6.name == "" or not string.find(var_368_6.name, "split") then
						var_368_6.gameObject:SetActive(true)
					else
						var_368_6.gameObject:SetActive(false)
					end
				end
			end

			local var_368_7 = 0.001

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_7 then
				var_368_5.localPosition = Vector3.Lerp(arg_365_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_365_1.time_ - 0) / var_368_7)
			end

			if arg_365_1.time_ >= 0 + var_368_7 and arg_365_1.time_ < 0 + var_368_7 + arg_368_0 then
				var_368_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_368_8 = 0
			local var_368_9 = 0.55

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_8 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, false)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_10 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(424041088).content)

				arg_365_1.text_.text = var_368_10

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_12 = 22 <= 0 and var_368_9 or var_368_9 * (utf8.len(var_368_10) / 22)

				if (22 <= 0 and var_368_9 or var_368_9 * (utf8.len(var_368_10) / 22)) > 0 and var_368_9 < var_368_12 then
					arg_365_1.talkMaxDuration = var_368_12

					if var_368_12 + var_368_8 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_12 + var_368_8
					end
				end

				arg_365_1.text_.text = var_368_10
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_13 = math.max(var_368_9, arg_365_1.talkMaxDuration)

			if var_368_8 <= arg_365_1.time_ and arg_365_1.time_ < var_368_8 + var_368_13 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_8) / var_368_13

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_8 + var_368_13 and arg_365_1.time_ < var_368_8 + var_368_13 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
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

		arg_365_1:InitPlayNodeList()
	end,
	Play424041089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 424041089
		arg_369_1.duration_ = 1.53

		local var_369_0 = {
			zh = 1.366,
			ja = 1.533
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
				arg_369_0:Play424041090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if arg_369_1.actors_["10154"] == nil then
				local var_372_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10154")

				if not isNil(var_372_0) then
					local var_372_1 = Object.Instantiate(var_372_0, arg_369_1.canvasGo_.transform)

					var_372_1.transform:SetSiblingIndex(1)

					var_372_1.name = "10154"
					var_372_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_369_1.actors_["10154"] = var_372_1

					if arg_369_1.isInRecall_ then
						for iter_372_0, iter_372_1 in ipairs((var_372_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_372_1.color = arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_372_2 = arg_369_1.actors_["10154"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps10154 == nil then
				arg_369_1.var_.actorSpriteComps10154 = var_372_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_372_3 = 0.2

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_3 and not isNil(var_372_2) then
				if arg_369_1.var_.actorSpriteComps10154 then
					for iter_372_2, iter_372_3 in pairs(arg_369_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_372_3 then
							if arg_369_1.isInRecall_ then
								iter_372_3.color = Color.New(Mathf.Lerp(iter_372_3.color.r, arg_369_1.hightColor1.r, (arg_369_1.time_ - 0) / var_372_3), Mathf.Lerp(iter_372_3.color.g, arg_369_1.hightColor1.g, (arg_369_1.time_ - 0) / var_372_3), (Mathf.Lerp(iter_372_3.color.b, arg_369_1.hightColor1.b, (arg_369_1.time_ - 0) / var_372_3)))
							else
								local var_372_4 = Mathf.Lerp(iter_372_3.color.r, 1, (arg_369_1.time_ - 0) / var_372_3)

								iter_372_3.color = Color.New(var_372_4, var_372_4, var_372_4)
							end
						end
					end
				end
			end

			if arg_369_1.time_ >= 0 + var_372_3 and arg_369_1.time_ < 0 + var_372_3 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.actorSpriteComps10154 then
				for iter_372_4, iter_372_5 in pairs(arg_369_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_372_5 then
						iter_372_5.color = arg_369_1.isInRecall_ and (arg_369_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_369_1.var_.actorSpriteComps10154 = nil
			end

			local var_372_5 = arg_369_1.actors_["10154"].transform

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1.var_.moveOldPos10154 = var_372_5.localPosition
				var_372_5.localScale = Vector3.New(1, 1, 1)

				arg_369_1:CheckSpriteTmpPos("10154", 2)

				for iter_372_6 = 0, var_372_5.childCount - 1 do
					local var_372_6 = var_372_5:GetChild(iter_372_6)

					if var_372_6.name == "split_3" or not string.find(var_372_6.name, "split") then
						var_372_6.gameObject:SetActive(true)
					else
						var_372_6.gameObject:SetActive(false)
					end
				end
			end

			local var_372_7 = 0.001

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_7 then
				var_372_5.localPosition = Vector3.Lerp(arg_369_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_369_1.time_ - 0) / var_372_7)
			end

			if arg_369_1.time_ >= 0 + var_372_7 and arg_369_1.time_ < 0 + var_372_7 + arg_372_0 then
				var_372_5.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_372_8 = 0
			local var_372_9 = 0.175

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_8 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_10 = arg_369_1:GetWordFromCfg(424041089)
				local var_372_11 = arg_369_1:FormatText(var_372_10.content)

				arg_369_1.text_.text = var_372_11

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_13 = 7 <= 0 and var_372_9 or var_372_9 * (utf8.len(var_372_11) / 7)

				if (7 <= 0 and var_372_9 or var_372_9 * (utf8.len(var_372_11) / 7)) > 0 and var_372_9 < var_372_13 then
					arg_369_1.talkMaxDuration = var_372_13

					if var_372_13 + var_372_8 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_13 + var_372_8
					end
				end

				arg_369_1.text_.text = var_372_11
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041089", "story_v_out_424041.awb") ~= 0 then
					local var_372_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041089", "story_v_out_424041.awb") / 1000

					if var_372_14 + var_372_8 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_14 + var_372_8
					end

					if var_372_10.prefab_name ~= "" and arg_369_1.actors_[var_372_10.prefab_name] ~= nil then
						local var_372_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_369_1.actors_[var_372_10.prefab_name].transform, "story_v_out_424041", "424041089", "story_v_out_424041.awb")

						arg_369_1:RecordAudio("424041089", var_372_15)
						arg_369_1:RecordAudio("424041089", var_372_15)
					else
						arg_369_1:AudioAction("play", "voice", "story_v_out_424041", "424041089", "story_v_out_424041.awb")
					end

					arg_369_1:RecordHistoryTalkVoice("story_v_out_424041", "424041089", "story_v_out_424041.awb")
				end

				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_16 = math.max(var_372_9, arg_369_1.talkMaxDuration)

			if var_372_8 <= arg_369_1.time_ and arg_369_1.time_ < var_372_8 + var_372_16 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_8) / var_372_16

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_8 + var_372_16 and arg_369_1.time_ < var_372_8 + var_372_16 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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
	Play424041090 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 424041090
		arg_373_1.duration_ = 1.37

		local var_373_0 = {
			zh = 1.366,
			ja = 1.333
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
				arg_373_0:Play424041091(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["10153"]) and arg_373_1.var_.actorSpriteComps10153 == nil then
				arg_373_1.var_.actorSpriteComps10153 = arg_373_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_0 = 0.2

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["10153"]) then
				if arg_373_1.var_.actorSpriteComps10153 then
					for iter_376_0, iter_376_1 in pairs(arg_373_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_376_1 then
							if arg_373_1.isInRecall_ then
								iter_376_1.color = Color.New(Mathf.Lerp(iter_376_1.color.r, arg_373_1.hightColor1.r, (arg_373_1.time_ - 0) / var_376_0), Mathf.Lerp(iter_376_1.color.g, arg_373_1.hightColor1.g, (arg_373_1.time_ - 0) / var_376_0), (Mathf.Lerp(iter_376_1.color.b, arg_373_1.hightColor1.b, (arg_373_1.time_ - 0) / var_376_0)))
							else
								local var_376_1 = Mathf.Lerp(iter_376_1.color.r, 1, (arg_373_1.time_ - 0) / var_376_0)

								iter_376_1.color = Color.New(var_376_1, var_376_1, var_376_1)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["10153"]) and arg_373_1.var_.actorSpriteComps10153 then
				for iter_376_2, iter_376_3 in pairs(arg_373_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_376_3 then
						iter_376_3.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_373_1.var_.actorSpriteComps10153 = nil
			end

			local var_376_2 = arg_373_1.actors_["10154"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_2) and arg_373_1.var_.actorSpriteComps10154 == nil then
				arg_373_1.var_.actorSpriteComps10154 = var_376_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_376_3 = 0.2

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_3 and not isNil(var_376_2) then
				if arg_373_1.var_.actorSpriteComps10154 then
					for iter_376_4, iter_376_5 in pairs(arg_373_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_376_5 then
							if arg_373_1.isInRecall_ then
								iter_376_5.color = Color.New(Mathf.Lerp(iter_376_5.color.r, arg_373_1.hightColor2.r, (arg_373_1.time_ - 0) / var_376_3), Mathf.Lerp(iter_376_5.color.g, arg_373_1.hightColor2.g, (arg_373_1.time_ - 0) / var_376_3), (Mathf.Lerp(iter_376_5.color.b, arg_373_1.hightColor2.b, (arg_373_1.time_ - 0) / var_376_3)))
							else
								local var_376_4 = Mathf.Lerp(iter_376_5.color.r, 0.5, (arg_373_1.time_ - 0) / var_376_3)

								iter_376_5.color = Color.New(var_376_4, var_376_4, var_376_4)
							end
						end
					end
				end
			end

			if arg_373_1.time_ >= 0 + var_376_3 and arg_373_1.time_ < 0 + var_376_3 + arg_376_0 and not isNil(var_376_2) and arg_373_1.var_.actorSpriteComps10154 then
				for iter_376_6, iter_376_7 in pairs(arg_373_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_376_7 then
						iter_376_7.color = arg_373_1.isInRecall_ and (arg_373_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_373_1.var_.actorSpriteComps10154 = nil
			end

			local var_376_5 = arg_373_1.actors_["10153"].transform

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1.var_.moveOldPos10153 = var_376_5.localPosition
				var_376_5.localScale = Vector3.New(1, 1, 1)

				arg_373_1:CheckSpriteTmpPos("10153", 4)

				for iter_376_8 = 0, var_376_5.childCount - 1 do
					local var_376_6 = var_376_5:GetChild(iter_376_8)

					if var_376_6.name == "" or not string.find(var_376_6.name, "split") then
						var_376_6.gameObject:SetActive(true)
					else
						var_376_6.gameObject:SetActive(false)
					end
				end
			end

			local var_376_7 = 0.001

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_7 then
				var_376_5.localPosition = Vector3.Lerp(arg_373_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_373_1.time_ - 0) / var_376_7)
			end

			if arg_373_1.time_ >= 0 + var_376_7 and arg_373_1.time_ < 0 + var_376_7 + arg_376_0 then
				var_376_5.localPosition = Vector3.New(400, -395, -330)
			end

			local var_376_8 = 0
			local var_376_9 = 0.075

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_8 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_10 = arg_373_1:GetWordFromCfg(424041090)
				local var_376_11 = arg_373_1:FormatText(var_376_10.content)

				arg_373_1.text_.text = var_376_11

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_13 = 3 <= 0 and var_376_9 or var_376_9 * (utf8.len(var_376_11) / 3)

				if (3 <= 0 and var_376_9 or var_376_9 * (utf8.len(var_376_11) / 3)) > 0 and var_376_9 < var_376_13 then
					arg_373_1.talkMaxDuration = var_376_13

					if var_376_13 + var_376_8 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_13 + var_376_8
					end
				end

				arg_373_1.text_.text = var_376_11
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041090", "story_v_out_424041.awb") ~= 0 then
					local var_376_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041090", "story_v_out_424041.awb") / 1000

					if var_376_14 + var_376_8 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_14 + var_376_8
					end

					if var_376_10.prefab_name ~= "" and arg_373_1.actors_[var_376_10.prefab_name] ~= nil then
						local var_376_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_373_1.actors_[var_376_10.prefab_name].transform, "story_v_out_424041", "424041090", "story_v_out_424041.awb")

						arg_373_1:RecordAudio("424041090", var_376_15)
						arg_373_1:RecordAudio("424041090", var_376_15)
					else
						arg_373_1:AudioAction("play", "voice", "story_v_out_424041", "424041090", "story_v_out_424041.awb")
					end

					arg_373_1:RecordHistoryTalkVoice("story_v_out_424041", "424041090", "story_v_out_424041.awb")
				end

				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_16 = math.max(var_376_9, arg_373_1.talkMaxDuration)

			if var_376_8 <= arg_373_1.time_ and arg_373_1.time_ < var_376_8 + var_376_16 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_8) / var_376_16

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_8 + var_376_16 and arg_373_1.time_ < var_376_8 + var_376_16 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
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
	Play424041091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 424041091
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play424041092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["10153"]) and arg_377_1.var_.actorSpriteComps10153 == nil then
				arg_377_1.var_.actorSpriteComps10153 = arg_377_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_0 = 0.2

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["10153"]) then
				if arg_377_1.var_.actorSpriteComps10153 then
					for iter_380_0, iter_380_1 in pairs(arg_377_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_380_1 then
							if arg_377_1.isInRecall_ then
								iter_380_1.color = Color.New(Mathf.Lerp(iter_380_1.color.r, arg_377_1.hightColor2.r, (arg_377_1.time_ - 0) / var_380_0), Mathf.Lerp(iter_380_1.color.g, arg_377_1.hightColor2.g, (arg_377_1.time_ - 0) / var_380_0), (Mathf.Lerp(iter_380_1.color.b, arg_377_1.hightColor2.b, (arg_377_1.time_ - 0) / var_380_0)))
							else
								local var_380_1 = Mathf.Lerp(iter_380_1.color.r, 0.5, (arg_377_1.time_ - 0) / var_380_0)

								iter_380_1.color = Color.New(var_380_1, var_380_1, var_380_1)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["10153"]) and arg_377_1.var_.actorSpriteComps10153 then
				for iter_380_2, iter_380_3 in pairs(arg_377_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_380_3 then
						iter_380_3.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_377_1.var_.actorSpriteComps10153 = nil
			end

			local var_380_2 = 0
			local var_380_3 = 0.6

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_2 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_4 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(424041091).content)

				arg_377_1.text_.text = var_380_4

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_6 = 24 <= 0 and var_380_3 or var_380_3 * (utf8.len(var_380_4) / 24)

				if (24 <= 0 and var_380_3 or var_380_3 * (utf8.len(var_380_4) / 24)) > 0 and var_380_3 < var_380_6 then
					arg_377_1.talkMaxDuration = var_380_6

					if var_380_6 + var_380_2 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_6 + var_380_2
					end
				end

				arg_377_1.text_.text = var_380_4
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_7 = math.max(var_380_3, arg_377_1.talkMaxDuration)

			if var_380_2 <= arg_377_1.time_ and arg_377_1.time_ < var_380_2 + var_380_7 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_2) / var_380_7

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_2 + var_380_7 and arg_377_1.time_ < var_380_2 + var_380_7 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play424041092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 424041092
		arg_381_1.duration_ = 3.3

		local var_381_0 = {
			zh = 2.633,
			ja = 3.3
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
				arg_381_0:Play424041093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["10154"]) and arg_381_1.var_.actorSpriteComps10154 == nil then
				arg_381_1.var_.actorSpriteComps10154 = arg_381_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_0 = 0.2

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["10154"]) then
				if arg_381_1.var_.actorSpriteComps10154 then
					for iter_384_0, iter_384_1 in pairs(arg_381_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_384_1 then
							if arg_381_1.isInRecall_ then
								iter_384_1.color = Color.New(Mathf.Lerp(iter_384_1.color.r, arg_381_1.hightColor1.r, (arg_381_1.time_ - 0) / var_384_0), Mathf.Lerp(iter_384_1.color.g, arg_381_1.hightColor1.g, (arg_381_1.time_ - 0) / var_384_0), (Mathf.Lerp(iter_384_1.color.b, arg_381_1.hightColor1.b, (arg_381_1.time_ - 0) / var_384_0)))
							else
								local var_384_1 = Mathf.Lerp(iter_384_1.color.r, 1, (arg_381_1.time_ - 0) / var_384_0)

								iter_384_1.color = Color.New(var_384_1, var_384_1, var_384_1)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["10154"]) and arg_381_1.var_.actorSpriteComps10154 then
				for iter_384_2, iter_384_3 in pairs(arg_381_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_384_3 then
						iter_384_3.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_381_1.var_.actorSpriteComps10154 = nil
			end

			local var_384_2 = arg_381_1.actors_["10154"].transform

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1.var_.moveOldPos10154 = var_384_2.localPosition
				var_384_2.localScale = Vector3.New(1, 1, 1)

				arg_381_1:CheckSpriteTmpPos("10154", 2)

				for iter_384_4 = 0, var_384_2.childCount - 1 do
					local var_384_3 = var_384_2:GetChild(iter_384_4)

					if var_384_3.name == "split_3" or not string.find(var_384_3.name, "split") then
						var_384_3.gameObject:SetActive(true)
					else
						var_384_3.gameObject:SetActive(false)
					end
				end
			end

			local var_384_4 = 0.001

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_4 then
				var_384_2.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_381_1.time_ - 0) / var_384_4)
			end

			if arg_381_1.time_ >= 0 + var_384_4 and arg_381_1.time_ < 0 + var_384_4 + arg_384_0 then
				var_384_2.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_384_5 = 0
			local var_384_6 = 0.325

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_5 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_7 = arg_381_1:GetWordFromCfg(424041092)
				local var_384_8 = arg_381_1:FormatText(var_384_7.content)

				arg_381_1.text_.text = var_384_8

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_10 = 13 <= 0 and var_384_6 or var_384_6 * (utf8.len(var_384_8) / 13)

				if (13 <= 0 and var_384_6 or var_384_6 * (utf8.len(var_384_8) / 13)) > 0 and var_384_6 < var_384_10 then
					arg_381_1.talkMaxDuration = var_384_10

					if var_384_10 + var_384_5 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_10 + var_384_5
					end
				end

				arg_381_1.text_.text = var_384_8
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041092", "story_v_out_424041.awb") ~= 0 then
					local var_384_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041092", "story_v_out_424041.awb") / 1000

					if var_384_11 + var_384_5 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_11 + var_384_5
					end

					if var_384_7.prefab_name ~= "" and arg_381_1.actors_[var_384_7.prefab_name] ~= nil then
						local var_384_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_7.prefab_name].transform, "story_v_out_424041", "424041092", "story_v_out_424041.awb")

						arg_381_1:RecordAudio("424041092", var_384_12)
						arg_381_1:RecordAudio("424041092", var_384_12)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_424041", "424041092", "story_v_out_424041.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_424041", "424041092", "story_v_out_424041.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_13 = math.max(var_384_6, arg_381_1.talkMaxDuration)

			if var_384_5 <= arg_381_1.time_ and arg_381_1.time_ < var_384_5 + var_384_13 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_5) / var_384_13

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_5 + var_384_13 and arg_381_1.time_ < var_384_5 + var_384_13 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_381_1:InitPlayNodeList()
	end,
	Play424041093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 424041093
		arg_385_1.duration_ = 4.83

		local var_385_0 = {
			zh = 4.833,
			ja = 4.8
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play424041094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["10153"]) and arg_385_1.var_.actorSpriteComps10153 == nil then
				arg_385_1.var_.actorSpriteComps10153 = arg_385_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_0 = 0.2

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["10153"]) then
				if arg_385_1.var_.actorSpriteComps10153 then
					for iter_388_0, iter_388_1 in pairs(arg_385_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_388_1 then
							if arg_385_1.isInRecall_ then
								iter_388_1.color = Color.New(Mathf.Lerp(iter_388_1.color.r, arg_385_1.hightColor1.r, (arg_385_1.time_ - 0) / var_388_0), Mathf.Lerp(iter_388_1.color.g, arg_385_1.hightColor1.g, (arg_385_1.time_ - 0) / var_388_0), (Mathf.Lerp(iter_388_1.color.b, arg_385_1.hightColor1.b, (arg_385_1.time_ - 0) / var_388_0)))
							else
								local var_388_1 = Mathf.Lerp(iter_388_1.color.r, 1, (arg_385_1.time_ - 0) / var_388_0)

								iter_388_1.color = Color.New(var_388_1, var_388_1, var_388_1)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["10153"]) and arg_385_1.var_.actorSpriteComps10153 then
				for iter_388_2, iter_388_3 in pairs(arg_385_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_388_3 then
						iter_388_3.color = arg_385_1.isInRecall_ and (arg_385_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_385_1.var_.actorSpriteComps10153 = nil
			end

			local var_388_2 = arg_385_1.actors_["10154"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_2) and arg_385_1.var_.actorSpriteComps10154 == nil then
				arg_385_1.var_.actorSpriteComps10154 = var_388_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_388_3 = 0.2

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_3 and not isNil(var_388_2) then
				if arg_385_1.var_.actorSpriteComps10154 then
					for iter_388_4, iter_388_5 in pairs(arg_385_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_388_5 then
							if arg_385_1.isInRecall_ then
								iter_388_5.color = Color.New(Mathf.Lerp(iter_388_5.color.r, arg_385_1.hightColor2.r, (arg_385_1.time_ - 0) / var_388_3), Mathf.Lerp(iter_388_5.color.g, arg_385_1.hightColor2.g, (arg_385_1.time_ - 0) / var_388_3), (Mathf.Lerp(iter_388_5.color.b, arg_385_1.hightColor2.b, (arg_385_1.time_ - 0) / var_388_3)))
							else
								local var_388_4 = Mathf.Lerp(iter_388_5.color.r, 0.5, (arg_385_1.time_ - 0) / var_388_3)

								iter_388_5.color = Color.New(var_388_4, var_388_4, var_388_4)
							end
						end
					end
				end
			end

			if arg_385_1.time_ >= 0 + var_388_3 and arg_385_1.time_ < 0 + var_388_3 + arg_388_0 and not isNil(var_388_2) and arg_385_1.var_.actorSpriteComps10154 then
				for iter_388_6, iter_388_7 in pairs(arg_385_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_388_7 then
						iter_388_7.color = arg_385_1.isInRecall_ and (arg_385_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_385_1.var_.actorSpriteComps10154 = nil
			end

			local var_388_5 = 0
			local var_388_6 = 0.425

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_5 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_7 = arg_385_1:GetWordFromCfg(424041093)
				local var_388_8 = arg_385_1:FormatText(var_388_7.content)

				arg_385_1.text_.text = var_388_8

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_10 = 17 <= 0 and var_388_6 or var_388_6 * (utf8.len(var_388_8) / 17)

				if (17 <= 0 and var_388_6 or var_388_6 * (utf8.len(var_388_8) / 17)) > 0 and var_388_6 < var_388_10 then
					arg_385_1.talkMaxDuration = var_388_10

					if var_388_10 + var_388_5 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_10 + var_388_5
					end
				end

				arg_385_1.text_.text = var_388_8
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041093", "story_v_out_424041.awb") ~= 0 then
					local var_388_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041093", "story_v_out_424041.awb") / 1000

					if var_388_11 + var_388_5 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_11 + var_388_5
					end

					if var_388_7.prefab_name ~= "" and arg_385_1.actors_[var_388_7.prefab_name] ~= nil then
						local var_388_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_7.prefab_name].transform, "story_v_out_424041", "424041093", "story_v_out_424041.awb")

						arg_385_1:RecordAudio("424041093", var_388_12)
						arg_385_1:RecordAudio("424041093", var_388_12)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_424041", "424041093", "story_v_out_424041.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_424041", "424041093", "story_v_out_424041.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_13 = math.max(var_388_6, arg_385_1.talkMaxDuration)

			if var_388_5 <= arg_385_1.time_ and arg_385_1.time_ < var_388_5 + var_388_13 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_5) / var_388_13

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_5 + var_388_13 and arg_385_1.time_ < var_388_5 + var_388_13 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play424041094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 424041094
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play424041095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["10153"]) and arg_389_1.var_.actorSpriteComps10153 == nil then
				arg_389_1.var_.actorSpriteComps10153 = arg_389_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_0 = 0.2

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["10153"]) then
				if arg_389_1.var_.actorSpriteComps10153 then
					for iter_392_0, iter_392_1 in pairs(arg_389_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_392_1 then
							if arg_389_1.isInRecall_ then
								iter_392_1.color = Color.New(Mathf.Lerp(iter_392_1.color.r, arg_389_1.hightColor2.r, (arg_389_1.time_ - 0) / var_392_0), Mathf.Lerp(iter_392_1.color.g, arg_389_1.hightColor2.g, (arg_389_1.time_ - 0) / var_392_0), (Mathf.Lerp(iter_392_1.color.b, arg_389_1.hightColor2.b, (arg_389_1.time_ - 0) / var_392_0)))
							else
								local var_392_1 = Mathf.Lerp(iter_392_1.color.r, 0.5, (arg_389_1.time_ - 0) / var_392_0)

								iter_392_1.color = Color.New(var_392_1, var_392_1, var_392_1)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["10153"]) and arg_389_1.var_.actorSpriteComps10153 then
				for iter_392_2, iter_392_3 in pairs(arg_389_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_392_3 then
						iter_392_3.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_389_1.var_.actorSpriteComps10153 = nil
			end

			local var_392_2 = 0
			local var_392_3 = 0.675

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_2 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, false)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_4 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(424041094).content)

				arg_389_1.text_.text = var_392_4

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_6 = 27 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_4) / 27)

				if (27 <= 0 and var_392_3 or var_392_3 * (utf8.len(var_392_4) / 27)) > 0 and var_392_3 < var_392_6 then
					arg_389_1.talkMaxDuration = var_392_6

					if var_392_6 + var_392_2 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_6 + var_392_2
					end
				end

				arg_389_1.text_.text = var_392_4
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_7 = math.max(var_392_3, arg_389_1.talkMaxDuration)

			if var_392_2 <= arg_389_1.time_ and arg_389_1.time_ < var_392_2 + var_392_7 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_2) / var_392_7

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_2 + var_392_7 and arg_389_1.time_ < var_392_2 + var_392_7 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play424041095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 424041095
		arg_393_1.duration_ = 2.47

		local var_393_0 = {
			zh = 2.466,
			ja = 2.4
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
				arg_393_0:Play424041096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["10154"]) and arg_393_1.var_.actorSpriteComps10154 == nil then
				arg_393_1.var_.actorSpriteComps10154 = arg_393_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_0 = 0.2

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["10154"]) then
				if arg_393_1.var_.actorSpriteComps10154 then
					for iter_396_0, iter_396_1 in pairs(arg_393_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_396_1 then
							if arg_393_1.isInRecall_ then
								iter_396_1.color = Color.New(Mathf.Lerp(iter_396_1.color.r, arg_393_1.hightColor1.r, (arg_393_1.time_ - 0) / var_396_0), Mathf.Lerp(iter_396_1.color.g, arg_393_1.hightColor1.g, (arg_393_1.time_ - 0) / var_396_0), (Mathf.Lerp(iter_396_1.color.b, arg_393_1.hightColor1.b, (arg_393_1.time_ - 0) / var_396_0)))
							else
								local var_396_1 = Mathf.Lerp(iter_396_1.color.r, 1, (arg_393_1.time_ - 0) / var_396_0)

								iter_396_1.color = Color.New(var_396_1, var_396_1, var_396_1)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["10154"]) and arg_393_1.var_.actorSpriteComps10154 then
				for iter_396_2, iter_396_3 in pairs(arg_393_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_396_3 then
						iter_396_3.color = arg_393_1.isInRecall_ and (arg_393_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_393_1.var_.actorSpriteComps10154 = nil
			end

			local var_396_2 = arg_393_1.actors_["10154"].transform

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.var_.moveOldPos10154 = var_396_2.localPosition
				var_396_2.localScale = Vector3.New(1, 1, 1)

				arg_393_1:CheckSpriteTmpPos("10154", 2)

				for iter_396_4 = 0, var_396_2.childCount - 1 do
					local var_396_3 = var_396_2:GetChild(iter_396_4)

					if var_396_3.name == "split_1" then
						var_396_3:SetAsLastSibling()
						var_396_3.gameObject:SetActive(true)

						arg_393_1.var_.actorSpriteSplit10154 = var_396_3.gameObject:GetComponent(typeof(Image))

						arg_393_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_396_4 = 0.5

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_4 then
				var_396_2.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_393_1.time_ - 0) / var_396_4)

				if arg_393_1.var_.actorSpriteSplit10154 ~= nil then
					arg_393_1.var_.actorSpriteSplit10154:SetAlpha((arg_393_1.time_ - 0) / var_396_4)
				end
			end

			if arg_393_1.time_ >= 0 + var_396_4 and arg_393_1.time_ < 0 + var_396_4 + arg_396_0 then
				var_396_2.localPosition = Vector3.New(-375, -338, -538)

				if arg_393_1.var_.actorSpriteSplit10154 ~= nil then
					arg_393_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_396_5 = 0
			local var_396_6 = 0.325

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_5 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_7 = arg_393_1:GetWordFromCfg(424041095)
				local var_396_8 = arg_393_1:FormatText(var_396_7.content)

				arg_393_1.text_.text = var_396_8

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_10 = 13 <= 0 and var_396_6 or var_396_6 * (utf8.len(var_396_8) / 13)

				if (13 <= 0 and var_396_6 or var_396_6 * (utf8.len(var_396_8) / 13)) > 0 and var_396_6 < var_396_10 then
					arg_393_1.talkMaxDuration = var_396_10

					if var_396_10 + var_396_5 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_10 + var_396_5
					end
				end

				arg_393_1.text_.text = var_396_8
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041095", "story_v_out_424041.awb") ~= 0 then
					local var_396_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041095", "story_v_out_424041.awb") / 1000

					if var_396_11 + var_396_5 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_11 + var_396_5
					end

					if var_396_7.prefab_name ~= "" and arg_393_1.actors_[var_396_7.prefab_name] ~= nil then
						local var_396_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_7.prefab_name].transform, "story_v_out_424041", "424041095", "story_v_out_424041.awb")

						arg_393_1:RecordAudio("424041095", var_396_12)
						arg_393_1:RecordAudio("424041095", var_396_12)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_424041", "424041095", "story_v_out_424041.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_424041", "424041095", "story_v_out_424041.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_13 = math.max(var_396_6, arg_393_1.talkMaxDuration)

			if var_396_5 <= arg_393_1.time_ and arg_393_1.time_ < var_396_5 + var_396_13 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_5) / var_396_13

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_5 + var_396_13 and arg_393_1.time_ < var_396_5 + var_396_13 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_393_1:InitPlayNodeList()
	end,
	Play424041096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 424041096
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play424041097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["10154"]) and arg_397_1.var_.actorSpriteComps10154 == nil then
				arg_397_1.var_.actorSpriteComps10154 = arg_397_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_0 = 0.2

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["10154"]) then
				if arg_397_1.var_.actorSpriteComps10154 then
					for iter_400_0, iter_400_1 in pairs(arg_397_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_400_1 then
							if arg_397_1.isInRecall_ then
								iter_400_1.color = Color.New(Mathf.Lerp(iter_400_1.color.r, arg_397_1.hightColor2.r, (arg_397_1.time_ - 0) / var_400_0), Mathf.Lerp(iter_400_1.color.g, arg_397_1.hightColor2.g, (arg_397_1.time_ - 0) / var_400_0), (Mathf.Lerp(iter_400_1.color.b, arg_397_1.hightColor2.b, (arg_397_1.time_ - 0) / var_400_0)))
							else
								local var_400_1 = Mathf.Lerp(iter_400_1.color.r, 0.5, (arg_397_1.time_ - 0) / var_400_0)

								iter_400_1.color = Color.New(var_400_1, var_400_1, var_400_1)
							end
						end
					end
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["10154"]) and arg_397_1.var_.actorSpriteComps10154 then
				for iter_400_2, iter_400_3 in pairs(arg_397_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_400_3 then
						iter_400_3.color = arg_397_1.isInRecall_ and (arg_397_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_397_1.var_.actorSpriteComps10154 = nil
			end

			local var_400_2 = 0
			local var_400_3 = 0.925

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_2 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_4 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(424041096).content)

				arg_397_1.text_.text = var_400_4

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_6 = 37 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_4) / 37)

				if (37 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_4) / 37)) > 0 and var_400_3 < var_400_6 then
					arg_397_1.talkMaxDuration = var_400_6

					if var_400_6 + var_400_2 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_6 + var_400_2
					end
				end

				arg_397_1.text_.text = var_400_4
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_7 = math.max(var_400_3, arg_397_1.talkMaxDuration)

			if var_400_2 <= arg_397_1.time_ and arg_397_1.time_ < var_400_2 + var_400_7 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_2) / var_400_7

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_2 + var_400_7 and arg_397_1.time_ < var_400_2 + var_400_7 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play424041097 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 424041097
		arg_401_1.duration_ = 4.8

		local var_401_0 = {
			zh = 4.066,
			ja = 4.8
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play424041098(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(arg_401_1.actors_["10154"]) and arg_401_1.var_.actorSpriteComps10154 == nil then
				arg_401_1.var_.actorSpriteComps10154 = arg_401_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_404_0 = 0.2

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 and not isNil(arg_401_1.actors_["10154"]) then
				if arg_401_1.var_.actorSpriteComps10154 then
					for iter_404_0, iter_404_1 in pairs(arg_401_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_404_1 then
							if arg_401_1.isInRecall_ then
								iter_404_1.color = Color.New(Mathf.Lerp(iter_404_1.color.r, arg_401_1.hightColor1.r, (arg_401_1.time_ - 0) / var_404_0), Mathf.Lerp(iter_404_1.color.g, arg_401_1.hightColor1.g, (arg_401_1.time_ - 0) / var_404_0), (Mathf.Lerp(iter_404_1.color.b, arg_401_1.hightColor1.b, (arg_401_1.time_ - 0) / var_404_0)))
							else
								local var_404_1 = Mathf.Lerp(iter_404_1.color.r, 1, (arg_401_1.time_ - 0) / var_404_0)

								iter_404_1.color = Color.New(var_404_1, var_404_1, var_404_1)
							end
						end
					end
				end
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 and not isNil(arg_401_1.actors_["10154"]) and arg_401_1.var_.actorSpriteComps10154 then
				for iter_404_2, iter_404_3 in pairs(arg_401_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_404_3 then
						iter_404_3.color = arg_401_1.isInRecall_ and (arg_401_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_401_1.var_.actorSpriteComps10154 = nil
			end

			local var_404_2 = arg_401_1.actors_["10154"].transform

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos10154 = var_404_2.localPosition
				var_404_2.localScale = Vector3.New(1, 1, 1)

				arg_401_1:CheckSpriteTmpPos("10154", 2)

				for iter_404_4 = 0, var_404_2.childCount - 1 do
					local var_404_3 = var_404_2:GetChild(iter_404_4)

					if var_404_3.name == "split_3" or not string.find(var_404_3.name, "split") then
						var_404_3.gameObject:SetActive(true)
					else
						var_404_3.gameObject:SetActive(false)
					end
				end
			end

			local var_404_4 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_4 then
				var_404_2.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_401_1.time_ - 0) / var_404_4)
			end

			if arg_401_1.time_ >= 0 + var_404_4 and arg_401_1.time_ < 0 + var_404_4 + arg_404_0 then
				var_404_2.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_404_5 = 0
			local var_404_6 = 0.45

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_5 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_7 = arg_401_1:GetWordFromCfg(424041097)
				local var_404_8 = arg_401_1:FormatText(var_404_7.content)

				arg_401_1.text_.text = var_404_8

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_10 = 18 <= 0 and var_404_6 or var_404_6 * (utf8.len(var_404_8) / 18)

				if (18 <= 0 and var_404_6 or var_404_6 * (utf8.len(var_404_8) / 18)) > 0 and var_404_6 < var_404_10 then
					arg_401_1.talkMaxDuration = var_404_10

					if var_404_10 + var_404_5 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_10 + var_404_5
					end
				end

				arg_401_1.text_.text = var_404_8
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041097", "story_v_out_424041.awb") ~= 0 then
					local var_404_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041097", "story_v_out_424041.awb") / 1000

					if var_404_11 + var_404_5 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_11 + var_404_5
					end

					if var_404_7.prefab_name ~= "" and arg_401_1.actors_[var_404_7.prefab_name] ~= nil then
						local var_404_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_7.prefab_name].transform, "story_v_out_424041", "424041097", "story_v_out_424041.awb")

						arg_401_1:RecordAudio("424041097", var_404_12)
						arg_401_1:RecordAudio("424041097", var_404_12)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_424041", "424041097", "story_v_out_424041.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_424041", "424041097", "story_v_out_424041.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_13 = math.max(var_404_6, arg_401_1.talkMaxDuration)

			if var_404_5 <= arg_401_1.time_ and arg_401_1.time_ < var_404_5 + var_404_13 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_5) / var_404_13

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_5 + var_404_13 and arg_401_1.time_ < var_404_5 + var_404_13 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play424041098 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 424041098
		arg_405_1.duration_ = 3.4

		local var_405_0 = {
			zh = 3.4,
			ja = 2.933
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play424041099(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(arg_405_1.actors_["1094"]) and arg_405_1.var_.actorSpriteComps1094 == nil then
				arg_405_1.var_.actorSpriteComps1094 = arg_405_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_0 = 0.2

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_0 and not isNil(arg_405_1.actors_["1094"]) then
				if arg_405_1.var_.actorSpriteComps1094 then
					for iter_408_0, iter_408_1 in pairs(arg_405_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_408_1 then
							if arg_405_1.isInRecall_ then
								iter_408_1.color = Color.New(Mathf.Lerp(iter_408_1.color.r, arg_405_1.hightColor1.r, (arg_405_1.time_ - 0) / var_408_0), Mathf.Lerp(iter_408_1.color.g, arg_405_1.hightColor1.g, (arg_405_1.time_ - 0) / var_408_0), (Mathf.Lerp(iter_408_1.color.b, arg_405_1.hightColor1.b, (arg_405_1.time_ - 0) / var_408_0)))
							else
								local var_408_1 = Mathf.Lerp(iter_408_1.color.r, 1, (arg_405_1.time_ - 0) / var_408_0)

								iter_408_1.color = Color.New(var_408_1, var_408_1, var_408_1)
							end
						end
					end
				end
			end

			if arg_405_1.time_ >= 0 + var_408_0 and arg_405_1.time_ < 0 + var_408_0 + arg_408_0 and not isNil(arg_405_1.actors_["1094"]) and arg_405_1.var_.actorSpriteComps1094 then
				for iter_408_2, iter_408_3 in pairs(arg_405_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_408_3 then
						iter_408_3.color = arg_405_1.isInRecall_ and (arg_405_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_405_1.var_.actorSpriteComps1094 = nil
			end

			local var_408_2 = arg_405_1.actors_["10154"]

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 and not isNil(var_408_2) and arg_405_1.var_.actorSpriteComps10154 == nil then
				arg_405_1.var_.actorSpriteComps10154 = var_408_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_408_3 = 0.2

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_3 and not isNil(var_408_2) then
				if arg_405_1.var_.actorSpriteComps10154 then
					for iter_408_4, iter_408_5 in pairs(arg_405_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_408_5 then
							if arg_405_1.isInRecall_ then
								iter_408_5.color = Color.New(Mathf.Lerp(iter_408_5.color.r, arg_405_1.hightColor2.r, (arg_405_1.time_ - 0) / var_408_3), Mathf.Lerp(iter_408_5.color.g, arg_405_1.hightColor2.g, (arg_405_1.time_ - 0) / var_408_3), (Mathf.Lerp(iter_408_5.color.b, arg_405_1.hightColor2.b, (arg_405_1.time_ - 0) / var_408_3)))
							else
								local var_408_4 = Mathf.Lerp(iter_408_5.color.r, 0.5, (arg_405_1.time_ - 0) / var_408_3)

								iter_408_5.color = Color.New(var_408_4, var_408_4, var_408_4)
							end
						end
					end
				end
			end

			if arg_405_1.time_ >= 0 + var_408_3 and arg_405_1.time_ < 0 + var_408_3 + arg_408_0 and not isNil(var_408_2) and arg_405_1.var_.actorSpriteComps10154 then
				for iter_408_6, iter_408_7 in pairs(arg_405_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_408_7 then
						iter_408_7.color = arg_405_1.isInRecall_ and (arg_405_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_405_1.var_.actorSpriteComps10154 = nil
			end

			local var_408_5 = arg_405_1.actors_["1094"].transform

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos1094 = var_408_5.localPosition
				var_408_5.localScale = Vector3.New(1, 1, 1)

				arg_405_1:CheckSpriteTmpPos("1094", 4)

				for iter_408_8 = 0, var_408_5.childCount - 1 do
					local var_408_6 = var_408_5:GetChild(iter_408_8)

					if var_408_6.name == "" or not string.find(var_408_6.name, "split") then
						var_408_6.gameObject:SetActive(true)
					else
						var_408_6.gameObject:SetActive(false)
					end
				end
			end

			local var_408_7 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_7 then
				var_408_5.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_405_1.time_ - 0) / var_408_7)
			end

			if arg_405_1.time_ >= 0 + var_408_7 and arg_405_1.time_ < 0 + var_408_7 + arg_408_0 then
				var_408_5.localPosition = Vector3.New(470, -335, -230)
			end

			local var_408_8 = arg_405_1.actors_["10153"].transform

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.var_.moveOldPos10153 = var_408_8.localPosition
				var_408_8.localScale = Vector3.New(1, 1, 1)

				arg_405_1:CheckSpriteTmpPos("10153", 7)

				for iter_408_9 = 0, var_408_8.childCount - 1 do
					local var_408_9 = var_408_8:GetChild(iter_408_9)

					if var_408_9.name == "" or not string.find(var_408_9.name, "split") then
						var_408_9.gameObject:SetActive(true)
					else
						var_408_9.gameObject:SetActive(false)
					end
				end
			end

			local var_408_10 = 0.001

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_10 then
				var_408_8.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_405_1.time_ - 0) / var_408_10)
			end

			if arg_405_1.time_ >= 0 + var_408_10 and arg_405_1.time_ < 0 + var_408_10 + arg_408_0 then
				var_408_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_408_11 = 0
			local var_408_12 = 0.225

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_11 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_13 = arg_405_1:GetWordFromCfg(424041098)
				local var_408_14 = arg_405_1:FormatText(var_408_13.content)

				arg_405_1.text_.text = var_408_14

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_16 = 9 <= 0 and var_408_12 or var_408_12 * (utf8.len(var_408_14) / 9)

				if (9 <= 0 and var_408_12 or var_408_12 * (utf8.len(var_408_14) / 9)) > 0 and var_408_12 < var_408_16 then
					arg_405_1.talkMaxDuration = var_408_16

					if var_408_16 + var_408_11 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_16 + var_408_11
					end
				end

				arg_405_1.text_.text = var_408_14
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041098", "story_v_out_424041.awb") ~= 0 then
					local var_408_17 = manager.audio:GetVoiceLength("story_v_out_424041", "424041098", "story_v_out_424041.awb") / 1000

					if var_408_17 + var_408_11 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_17 + var_408_11
					end

					if var_408_13.prefab_name ~= "" and arg_405_1.actors_[var_408_13.prefab_name] ~= nil then
						local var_408_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_13.prefab_name].transform, "story_v_out_424041", "424041098", "story_v_out_424041.awb")

						arg_405_1:RecordAudio("424041098", var_408_18)
						arg_405_1:RecordAudio("424041098", var_408_18)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_424041", "424041098", "story_v_out_424041.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_424041", "424041098", "story_v_out_424041.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_19 = math.max(var_408_12, arg_405_1.talkMaxDuration)

			if var_408_11 <= arg_405_1.time_ and arg_405_1.time_ < var_408_11 + var_408_19 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_11) / var_408_19

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_11 + var_408_19 and arg_405_1.time_ < var_408_11 + var_408_19 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
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
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play424041099 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 424041099
		arg_409_1.duration_ = 3.4

		local var_409_0 = {
			zh = 2.966,
			ja = 3.4
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play424041100(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["10153"]) and arg_409_1.var_.actorSpriteComps10153 == nil then
				arg_409_1.var_.actorSpriteComps10153 = arg_409_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_0 = 0.2

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["10153"]) then
				if arg_409_1.var_.actorSpriteComps10153 then
					for iter_412_0, iter_412_1 in pairs(arg_409_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_412_1 then
							if arg_409_1.isInRecall_ then
								iter_412_1.color = Color.New(Mathf.Lerp(iter_412_1.color.r, arg_409_1.hightColor1.r, (arg_409_1.time_ - 0) / var_412_0), Mathf.Lerp(iter_412_1.color.g, arg_409_1.hightColor1.g, (arg_409_1.time_ - 0) / var_412_0), (Mathf.Lerp(iter_412_1.color.b, arg_409_1.hightColor1.b, (arg_409_1.time_ - 0) / var_412_0)))
							else
								local var_412_1 = Mathf.Lerp(iter_412_1.color.r, 1, (arg_409_1.time_ - 0) / var_412_0)

								iter_412_1.color = Color.New(var_412_1, var_412_1, var_412_1)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["10153"]) and arg_409_1.var_.actorSpriteComps10153 then
				for iter_412_2, iter_412_3 in pairs(arg_409_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_412_3 then
						iter_412_3.color = arg_409_1.isInRecall_ and (arg_409_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_409_1.var_.actorSpriteComps10153 = nil
			end

			local var_412_2 = arg_409_1.actors_["1094"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_2) and arg_409_1.var_.actorSpriteComps1094 == nil then
				arg_409_1.var_.actorSpriteComps1094 = var_412_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_412_3 = 0.2

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_3 and not isNil(var_412_2) then
				if arg_409_1.var_.actorSpriteComps1094 then
					for iter_412_4, iter_412_5 in pairs(arg_409_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_412_5 then
							if arg_409_1.isInRecall_ then
								iter_412_5.color = Color.New(Mathf.Lerp(iter_412_5.color.r, arg_409_1.hightColor2.r, (arg_409_1.time_ - 0) / var_412_3), Mathf.Lerp(iter_412_5.color.g, arg_409_1.hightColor2.g, (arg_409_1.time_ - 0) / var_412_3), (Mathf.Lerp(iter_412_5.color.b, arg_409_1.hightColor2.b, (arg_409_1.time_ - 0) / var_412_3)))
							else
								local var_412_4 = Mathf.Lerp(iter_412_5.color.r, 0.5, (arg_409_1.time_ - 0) / var_412_3)

								iter_412_5.color = Color.New(var_412_4, var_412_4, var_412_4)
							end
						end
					end
				end
			end

			if arg_409_1.time_ >= 0 + var_412_3 and arg_409_1.time_ < 0 + var_412_3 + arg_412_0 and not isNil(var_412_2) and arg_409_1.var_.actorSpriteComps1094 then
				for iter_412_6, iter_412_7 in pairs(arg_409_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_412_7 then
						iter_412_7.color = arg_409_1.isInRecall_ and (arg_409_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_409_1.var_.actorSpriteComps1094 = nil
			end

			local var_412_5 = arg_409_1.actors_["10153"].transform

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos10153 = var_412_5.localPosition
				var_412_5.localScale = Vector3.New(1, 1, 1)

				arg_409_1:CheckSpriteTmpPos("10153", 4)

				for iter_412_8 = 0, var_412_5.childCount - 1 do
					local var_412_6 = var_412_5:GetChild(iter_412_8)

					if var_412_6.name == "" or not string.find(var_412_6.name, "split") then
						var_412_6.gameObject:SetActive(true)
					else
						var_412_6.gameObject:SetActive(false)
					end
				end
			end

			local var_412_7 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_7 then
				var_412_5.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_409_1.time_ - 0) / var_412_7)
			end

			if arg_409_1.time_ >= 0 + var_412_7 and arg_409_1.time_ < 0 + var_412_7 + arg_412_0 then
				var_412_5.localPosition = Vector3.New(400, -395, -330)
			end

			local var_412_8 = arg_409_1.actors_["1094"].transform

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.var_.moveOldPos1094 = var_412_8.localPosition
				var_412_8.localScale = Vector3.New(1, 1, 1)

				arg_409_1:CheckSpriteTmpPos("1094", 7)

				for iter_412_9 = 0, var_412_8.childCount - 1 do
					local var_412_9 = var_412_8:GetChild(iter_412_9)

					if var_412_9.name == "" or not string.find(var_412_9.name, "split") then
						var_412_9.gameObject:SetActive(true)
					else
						var_412_9.gameObject:SetActive(false)
					end
				end
			end

			local var_412_10 = 0.001

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_10 then
				var_412_8.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_409_1.time_ - 0) / var_412_10)
			end

			if arg_409_1.time_ >= 0 + var_412_10 and arg_409_1.time_ < 0 + var_412_10 + arg_412_0 then
				var_412_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_412_11 = 0
			local var_412_12 = 0.375

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_11 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_13 = arg_409_1:GetWordFromCfg(424041099)
				local var_412_14 = arg_409_1:FormatText(var_412_13.content)

				arg_409_1.text_.text = var_412_14

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_16 = 15 <= 0 and var_412_12 or var_412_12 * (utf8.len(var_412_14) / 15)

				if (15 <= 0 and var_412_12 or var_412_12 * (utf8.len(var_412_14) / 15)) > 0 and var_412_12 < var_412_16 then
					arg_409_1.talkMaxDuration = var_412_16

					if var_412_16 + var_412_11 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_16 + var_412_11
					end
				end

				arg_409_1.text_.text = var_412_14
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041099", "story_v_out_424041.awb") ~= 0 then
					local var_412_17 = manager.audio:GetVoiceLength("story_v_out_424041", "424041099", "story_v_out_424041.awb") / 1000

					if var_412_17 + var_412_11 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_17 + var_412_11
					end

					if var_412_13.prefab_name ~= "" and arg_409_1.actors_[var_412_13.prefab_name] ~= nil then
						local var_412_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_13.prefab_name].transform, "story_v_out_424041", "424041099", "story_v_out_424041.awb")

						arg_409_1:RecordAudio("424041099", var_412_18)
						arg_409_1:RecordAudio("424041099", var_412_18)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_424041", "424041099", "story_v_out_424041.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_424041", "424041099", "story_v_out_424041.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_19 = math.max(var_412_12, arg_409_1.talkMaxDuration)

			if var_412_11 <= arg_409_1.time_ and arg_409_1.time_ < var_412_11 + var_412_19 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_11) / var_412_19

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_11 + var_412_19 and arg_409_1.time_ < var_412_11 + var_412_19 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
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

		arg_409_1:InitPlayNodeList()
	end,
	Play424041100 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 424041100
		arg_413_1.duration_ = 6.63

		local var_413_0 = {
			zh = 4.9,
			ja = 6.633
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play424041101(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["10154"]) and arg_413_1.var_.actorSpriteComps10154 == nil then
				arg_413_1.var_.actorSpriteComps10154 = arg_413_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_0 = 0.2

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["10154"]) then
				if arg_413_1.var_.actorSpriteComps10154 then
					for iter_416_0, iter_416_1 in pairs(arg_413_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_416_1 then
							if arg_413_1.isInRecall_ then
								iter_416_1.color = Color.New(Mathf.Lerp(iter_416_1.color.r, arg_413_1.hightColor1.r, (arg_413_1.time_ - 0) / var_416_0), Mathf.Lerp(iter_416_1.color.g, arg_413_1.hightColor1.g, (arg_413_1.time_ - 0) / var_416_0), (Mathf.Lerp(iter_416_1.color.b, arg_413_1.hightColor1.b, (arg_413_1.time_ - 0) / var_416_0)))
							else
								local var_416_1 = Mathf.Lerp(iter_416_1.color.r, 1, (arg_413_1.time_ - 0) / var_416_0)

								iter_416_1.color = Color.New(var_416_1, var_416_1, var_416_1)
							end
						end
					end
				end
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["10154"]) and arg_413_1.var_.actorSpriteComps10154 then
				for iter_416_2, iter_416_3 in pairs(arg_413_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_416_3 then
						iter_416_3.color = arg_413_1.isInRecall_ and (arg_413_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_413_1.var_.actorSpriteComps10154 = nil
			end

			local var_416_2 = arg_413_1.actors_["10153"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_2) and arg_413_1.var_.actorSpriteComps10153 == nil then
				arg_413_1.var_.actorSpriteComps10153 = var_416_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_416_3 = 0.2

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_3 and not isNil(var_416_2) then
				if arg_413_1.var_.actorSpriteComps10153 then
					for iter_416_4, iter_416_5 in pairs(arg_413_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_416_5 then
							if arg_413_1.isInRecall_ then
								iter_416_5.color = Color.New(Mathf.Lerp(iter_416_5.color.r, arg_413_1.hightColor2.r, (arg_413_1.time_ - 0) / var_416_3), Mathf.Lerp(iter_416_5.color.g, arg_413_1.hightColor2.g, (arg_413_1.time_ - 0) / var_416_3), (Mathf.Lerp(iter_416_5.color.b, arg_413_1.hightColor2.b, (arg_413_1.time_ - 0) / var_416_3)))
							else
								local var_416_4 = Mathf.Lerp(iter_416_5.color.r, 0.5, (arg_413_1.time_ - 0) / var_416_3)

								iter_416_5.color = Color.New(var_416_4, var_416_4, var_416_4)
							end
						end
					end
				end
			end

			if arg_413_1.time_ >= 0 + var_416_3 and arg_413_1.time_ < 0 + var_416_3 + arg_416_0 and not isNil(var_416_2) and arg_413_1.var_.actorSpriteComps10153 then
				for iter_416_6, iter_416_7 in pairs(arg_413_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_416_7 then
						iter_416_7.color = arg_413_1.isInRecall_ and (arg_413_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_413_1.var_.actorSpriteComps10153 = nil
			end

			local var_416_5 = arg_413_1.actors_["10154"].transform

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos10154 = var_416_5.localPosition
				var_416_5.localScale = Vector3.New(1, 1, 1)

				arg_413_1:CheckSpriteTmpPos("10154", 2)

				for iter_416_8 = 0, var_416_5.childCount - 1 do
					local var_416_6 = var_416_5:GetChild(iter_416_8)

					if var_416_6.name == "split_3" or not string.find(var_416_6.name, "split") then
						var_416_6.gameObject:SetActive(true)
					else
						var_416_6.gameObject:SetActive(false)
					end
				end
			end

			local var_416_7 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_7 then
				var_416_5.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_413_1.time_ - 0) / var_416_7)
			end

			if arg_413_1.time_ >= 0 + var_416_7 and arg_413_1.time_ < 0 + var_416_7 + arg_416_0 then
				var_416_5.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_416_8 = 0
			local var_416_9 = 0.6

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_8 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_10 = arg_413_1:GetWordFromCfg(424041100)
				local var_416_11 = arg_413_1:FormatText(var_416_10.content)

				arg_413_1.text_.text = var_416_11

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_13 = 24 <= 0 and var_416_9 or var_416_9 * (utf8.len(var_416_11) / 24)

				if (24 <= 0 and var_416_9 or var_416_9 * (utf8.len(var_416_11) / 24)) > 0 and var_416_9 < var_416_13 then
					arg_413_1.talkMaxDuration = var_416_13

					if var_416_13 + var_416_8 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_13 + var_416_8
					end
				end

				arg_413_1.text_.text = var_416_11
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041100", "story_v_out_424041.awb") ~= 0 then
					local var_416_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041100", "story_v_out_424041.awb") / 1000

					if var_416_14 + var_416_8 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_14 + var_416_8
					end

					if var_416_10.prefab_name ~= "" and arg_413_1.actors_[var_416_10.prefab_name] ~= nil then
						local var_416_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_10.prefab_name].transform, "story_v_out_424041", "424041100", "story_v_out_424041.awb")

						arg_413_1:RecordAudio("424041100", var_416_15)
						arg_413_1:RecordAudio("424041100", var_416_15)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_424041", "424041100", "story_v_out_424041.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_424041", "424041100", "story_v_out_424041.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_16 = math.max(var_416_9, arg_413_1.talkMaxDuration)

			if var_416_8 <= arg_413_1.time_ and arg_413_1.time_ < var_416_8 + var_416_16 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_8) / var_416_16

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_8 + var_416_16 and arg_413_1.time_ < var_416_8 + var_416_16 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play424041101 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 424041101
		arg_417_1.duration_ = 2.07

		local var_417_0 = {
			zh = 1.866,
			ja = 2.066
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play424041102(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(arg_417_1.actors_["10153"]) and arg_417_1.var_.actorSpriteComps10153 == nil then
				arg_417_1.var_.actorSpriteComps10153 = arg_417_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_0 = 0.2

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 and not isNil(arg_417_1.actors_["10153"]) then
				if arg_417_1.var_.actorSpriteComps10153 then
					for iter_420_0, iter_420_1 in pairs(arg_417_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_420_1 then
							if arg_417_1.isInRecall_ then
								iter_420_1.color = Color.New(Mathf.Lerp(iter_420_1.color.r, arg_417_1.hightColor1.r, (arg_417_1.time_ - 0) / var_420_0), Mathf.Lerp(iter_420_1.color.g, arg_417_1.hightColor1.g, (arg_417_1.time_ - 0) / var_420_0), (Mathf.Lerp(iter_420_1.color.b, arg_417_1.hightColor1.b, (arg_417_1.time_ - 0) / var_420_0)))
							else
								local var_420_1 = Mathf.Lerp(iter_420_1.color.r, 1, (arg_417_1.time_ - 0) / var_420_0)

								iter_420_1.color = Color.New(var_420_1, var_420_1, var_420_1)
							end
						end
					end
				end
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 and not isNil(arg_417_1.actors_["10153"]) and arg_417_1.var_.actorSpriteComps10153 then
				for iter_420_2, iter_420_3 in pairs(arg_417_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_420_3 then
						iter_420_3.color = arg_417_1.isInRecall_ and (arg_417_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_417_1.var_.actorSpriteComps10153 = nil
			end

			local var_420_2 = arg_417_1.actors_["10154"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_2) and arg_417_1.var_.actorSpriteComps10154 == nil then
				arg_417_1.var_.actorSpriteComps10154 = var_420_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_420_3 = 0.2

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_3 and not isNil(var_420_2) then
				if arg_417_1.var_.actorSpriteComps10154 then
					for iter_420_4, iter_420_5 in pairs(arg_417_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_420_5 then
							if arg_417_1.isInRecall_ then
								iter_420_5.color = Color.New(Mathf.Lerp(iter_420_5.color.r, arg_417_1.hightColor2.r, (arg_417_1.time_ - 0) / var_420_3), Mathf.Lerp(iter_420_5.color.g, arg_417_1.hightColor2.g, (arg_417_1.time_ - 0) / var_420_3), (Mathf.Lerp(iter_420_5.color.b, arg_417_1.hightColor2.b, (arg_417_1.time_ - 0) / var_420_3)))
							else
								local var_420_4 = Mathf.Lerp(iter_420_5.color.r, 0.5, (arg_417_1.time_ - 0) / var_420_3)

								iter_420_5.color = Color.New(var_420_4, var_420_4, var_420_4)
							end
						end
					end
				end
			end

			if arg_417_1.time_ >= 0 + var_420_3 and arg_417_1.time_ < 0 + var_420_3 + arg_420_0 and not isNil(var_420_2) and arg_417_1.var_.actorSpriteComps10154 then
				for iter_420_6, iter_420_7 in pairs(arg_417_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_420_7 then
						iter_420_7.color = arg_417_1.isInRecall_ and (arg_417_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_417_1.var_.actorSpriteComps10154 = nil
			end

			local var_420_5 = 0
			local var_420_6 = 0.2

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_5 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_7 = arg_417_1:GetWordFromCfg(424041101)
				local var_420_8 = arg_417_1:FormatText(var_420_7.content)

				arg_417_1.text_.text = var_420_8

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_10 = 8 <= 0 and var_420_6 or var_420_6 * (utf8.len(var_420_8) / 8)

				if (8 <= 0 and var_420_6 or var_420_6 * (utf8.len(var_420_8) / 8)) > 0 and var_420_6 < var_420_10 then
					arg_417_1.talkMaxDuration = var_420_10

					if var_420_10 + var_420_5 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_10 + var_420_5
					end
				end

				arg_417_1.text_.text = var_420_8
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041101", "story_v_out_424041.awb") ~= 0 then
					local var_420_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041101", "story_v_out_424041.awb") / 1000

					if var_420_11 + var_420_5 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_11 + var_420_5
					end

					if var_420_7.prefab_name ~= "" and arg_417_1.actors_[var_420_7.prefab_name] ~= nil then
						local var_420_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_7.prefab_name].transform, "story_v_out_424041", "424041101", "story_v_out_424041.awb")

						arg_417_1:RecordAudio("424041101", var_420_12)
						arg_417_1:RecordAudio("424041101", var_420_12)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_424041", "424041101", "story_v_out_424041.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_424041", "424041101", "story_v_out_424041.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_13 = math.max(var_420_6, arg_417_1.talkMaxDuration)

			if var_420_5 <= arg_417_1.time_ and arg_417_1.time_ < var_420_5 + var_420_13 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_5) / var_420_13

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_5 + var_420_13 and arg_417_1.time_ < var_420_5 + var_420_13 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {}

		arg_417_1:InitPlayNodeList()
	end,
	Play424041102 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 424041102
		arg_421_1.duration_ = 11

		local var_421_0 = {
			zh = 10.066,
			ja = 11
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play424041103(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(arg_421_1.actors_["10154"]) and arg_421_1.var_.actorSpriteComps10154 == nil then
				arg_421_1.var_.actorSpriteComps10154 = arg_421_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_0 = 0.2

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 and not isNil(arg_421_1.actors_["10154"]) then
				if arg_421_1.var_.actorSpriteComps10154 then
					for iter_424_0, iter_424_1 in pairs(arg_421_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_424_1 then
							if arg_421_1.isInRecall_ then
								iter_424_1.color = Color.New(Mathf.Lerp(iter_424_1.color.r, arg_421_1.hightColor1.r, (arg_421_1.time_ - 0) / var_424_0), Mathf.Lerp(iter_424_1.color.g, arg_421_1.hightColor1.g, (arg_421_1.time_ - 0) / var_424_0), (Mathf.Lerp(iter_424_1.color.b, arg_421_1.hightColor1.b, (arg_421_1.time_ - 0) / var_424_0)))
							else
								local var_424_1 = Mathf.Lerp(iter_424_1.color.r, 1, (arg_421_1.time_ - 0) / var_424_0)

								iter_424_1.color = Color.New(var_424_1, var_424_1, var_424_1)
							end
						end
					end
				end
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 and not isNil(arg_421_1.actors_["10154"]) and arg_421_1.var_.actorSpriteComps10154 then
				for iter_424_2, iter_424_3 in pairs(arg_421_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_424_3 then
						iter_424_3.color = arg_421_1.isInRecall_ and (arg_421_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_421_1.var_.actorSpriteComps10154 = nil
			end

			local var_424_2 = arg_421_1.actors_["10153"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_2) and arg_421_1.var_.actorSpriteComps10153 == nil then
				arg_421_1.var_.actorSpriteComps10153 = var_424_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_424_3 = 0.2

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_3 and not isNil(var_424_2) then
				if arg_421_1.var_.actorSpriteComps10153 then
					for iter_424_4, iter_424_5 in pairs(arg_421_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_424_5 then
							if arg_421_1.isInRecall_ then
								iter_424_5.color = Color.New(Mathf.Lerp(iter_424_5.color.r, arg_421_1.hightColor2.r, (arg_421_1.time_ - 0) / var_424_3), Mathf.Lerp(iter_424_5.color.g, arg_421_1.hightColor2.g, (arg_421_1.time_ - 0) / var_424_3), (Mathf.Lerp(iter_424_5.color.b, arg_421_1.hightColor2.b, (arg_421_1.time_ - 0) / var_424_3)))
							else
								local var_424_4 = Mathf.Lerp(iter_424_5.color.r, 0.5, (arg_421_1.time_ - 0) / var_424_3)

								iter_424_5.color = Color.New(var_424_4, var_424_4, var_424_4)
							end
						end
					end
				end
			end

			if arg_421_1.time_ >= 0 + var_424_3 and arg_421_1.time_ < 0 + var_424_3 + arg_424_0 and not isNil(var_424_2) and arg_421_1.var_.actorSpriteComps10153 then
				for iter_424_6, iter_424_7 in pairs(arg_421_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_424_7 then
						iter_424_7.color = arg_421_1.isInRecall_ and (arg_421_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_421_1.var_.actorSpriteComps10153 = nil
			end

			local var_424_5 = 0
			local var_424_6 = 1.35

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_5 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_7 = arg_421_1:GetWordFromCfg(424041102)
				local var_424_8 = arg_421_1:FormatText(var_424_7.content)

				arg_421_1.text_.text = var_424_8

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_10 = 54 <= 0 and var_424_6 or var_424_6 * (utf8.len(var_424_8) / 54)

				if (54 <= 0 and var_424_6 or var_424_6 * (utf8.len(var_424_8) / 54)) > 0 and var_424_6 < var_424_10 then
					arg_421_1.talkMaxDuration = var_424_10

					if var_424_10 + var_424_5 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_10 + var_424_5
					end
				end

				arg_421_1.text_.text = var_424_8
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041102", "story_v_out_424041.awb") ~= 0 then
					local var_424_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041102", "story_v_out_424041.awb") / 1000

					if var_424_11 + var_424_5 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_11 + var_424_5
					end

					if var_424_7.prefab_name ~= "" and arg_421_1.actors_[var_424_7.prefab_name] ~= nil then
						local var_424_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_7.prefab_name].transform, "story_v_out_424041", "424041102", "story_v_out_424041.awb")

						arg_421_1:RecordAudio("424041102", var_424_12)
						arg_421_1:RecordAudio("424041102", var_424_12)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_424041", "424041102", "story_v_out_424041.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_424041", "424041102", "story_v_out_424041.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_13 = math.max(var_424_6, arg_421_1.talkMaxDuration)

			if var_424_5 <= arg_421_1.time_ and arg_421_1.time_ < var_424_5 + var_424_13 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_5) / var_424_13

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_5 + var_424_13 and arg_421_1.time_ < var_424_5 + var_424_13 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play424041103 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 424041103
		arg_425_1.duration_ = 1

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"

			SetActive(arg_425_1.choicesGo_, true)

			for iter_426_0, iter_426_1 in ipairs(arg_425_1.choices_) do
				SetActive(iter_426_1.go, iter_426_0 <= 1)
			end

			arg_425_1.choices_[1].txt.text = arg_425_1:FormatText(StoryChoiceCfg[1480].name)
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play424041104(arg_425_1)
			end

			arg_425_1:RecordChoiceLog(424041103, 1480)
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 and not isNil(arg_425_1.actors_["10154"]) and arg_425_1.var_.actorSpriteComps10154 == nil then
				arg_425_1.var_.actorSpriteComps10154 = arg_425_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_428_0 = 0.2

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_0 and not isNil(arg_425_1.actors_["10154"]) then
				if arg_425_1.var_.actorSpriteComps10154 then
					for iter_428_0, iter_428_1 in pairs(arg_425_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_428_1 then
							if arg_425_1.isInRecall_ then
								iter_428_1.color = Color.New(Mathf.Lerp(iter_428_1.color.r, arg_425_1.hightColor2.r, (arg_425_1.time_ - 0) / var_428_0), Mathf.Lerp(iter_428_1.color.g, arg_425_1.hightColor2.g, (arg_425_1.time_ - 0) / var_428_0), (Mathf.Lerp(iter_428_1.color.b, arg_425_1.hightColor2.b, (arg_425_1.time_ - 0) / var_428_0)))
							else
								local var_428_1 = Mathf.Lerp(iter_428_1.color.r, 0.5, (arg_425_1.time_ - 0) / var_428_0)

								iter_428_1.color = Color.New(var_428_1, var_428_1, var_428_1)
							end
						end
					end
				end
			end

			if arg_425_1.time_ >= 0 + var_428_0 and arg_425_1.time_ < 0 + var_428_0 + arg_428_0 and not isNil(arg_425_1.actors_["10154"]) and arg_425_1.var_.actorSpriteComps10154 then
				for iter_428_2, iter_428_3 in pairs(arg_425_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_428_3 then
						iter_428_3.color = arg_425_1.isInRecall_ and (arg_425_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_425_1.var_.actorSpriteComps10154 = nil
			end

			local var_428_2 = 0

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= var_428_2 + arg_428_0 then
				arg_425_1.allBtn_.enabled = false
			end

			if arg_425_1.time_ >= var_428_2 + 0.5 and arg_425_1.time_ < var_428_2 + 0.5 + arg_428_0 then
				arg_425_1.allBtn_.enabled = true
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play424041104 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 424041104
		arg_429_1.duration_ = 1.67

		local var_429_0 = {
			zh = 1.366,
			ja = 1.666
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play424041105(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 and not isNil(arg_429_1.actors_["10154"]) and arg_429_1.var_.actorSpriteComps10154 == nil then
				arg_429_1.var_.actorSpriteComps10154 = arg_429_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_432_0 = 0.2

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_0 and not isNil(arg_429_1.actors_["10154"]) then
				if arg_429_1.var_.actorSpriteComps10154 then
					for iter_432_0, iter_432_1 in pairs(arg_429_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_432_1 then
							if arg_429_1.isInRecall_ then
								iter_432_1.color = Color.New(Mathf.Lerp(iter_432_1.color.r, arg_429_1.hightColor1.r, (arg_429_1.time_ - 0) / var_432_0), Mathf.Lerp(iter_432_1.color.g, arg_429_1.hightColor1.g, (arg_429_1.time_ - 0) / var_432_0), (Mathf.Lerp(iter_432_1.color.b, arg_429_1.hightColor1.b, (arg_429_1.time_ - 0) / var_432_0)))
							else
								local var_432_1 = Mathf.Lerp(iter_432_1.color.r, 1, (arg_429_1.time_ - 0) / var_432_0)

								iter_432_1.color = Color.New(var_432_1, var_432_1, var_432_1)
							end
						end
					end
				end
			end

			if arg_429_1.time_ >= 0 + var_432_0 and arg_429_1.time_ < 0 + var_432_0 + arg_432_0 and not isNil(arg_429_1.actors_["10154"]) and arg_429_1.var_.actorSpriteComps10154 then
				for iter_432_2, iter_432_3 in pairs(arg_429_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_432_3 then
						iter_432_3.color = arg_429_1.isInRecall_ and (arg_429_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_429_1.var_.actorSpriteComps10154 = nil
			end

			local var_432_2 = arg_429_1.actors_["10154"].transform

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.var_.moveOldPos10154 = var_432_2.localPosition
				var_432_2.localScale = Vector3.New(1, 1, 1)

				arg_429_1:CheckSpriteTmpPos("10154", 2)

				for iter_432_4 = 0, var_432_2.childCount - 1 do
					local var_432_3 = var_432_2:GetChild(iter_432_4)

					if var_432_3.name == "split_5" then
						var_432_3:SetAsLastSibling()
						var_432_3.gameObject:SetActive(true)

						arg_429_1.var_.actorSpriteSplit10154 = var_432_3.gameObject:GetComponent(typeof(Image))

						arg_429_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_432_4 = 0.5

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_4 then
				var_432_2.localPosition = Vector3.Lerp(arg_429_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_429_1.time_ - 0) / var_432_4)

				if arg_429_1.var_.actorSpriteSplit10154 ~= nil then
					arg_429_1.var_.actorSpriteSplit10154:SetAlpha((arg_429_1.time_ - 0) / var_432_4)
				end
			end

			if arg_429_1.time_ >= 0 + var_432_4 and arg_429_1.time_ < 0 + var_432_4 + arg_432_0 then
				var_432_2.localPosition = Vector3.New(-375, -338, -538)

				if arg_429_1.var_.actorSpriteSplit10154 ~= nil then
					arg_429_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_432_5 = 0
			local var_432_6 = 0.175

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= var_432_5 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_7 = arg_429_1:GetWordFromCfg(424041104)
				local var_432_8 = arg_429_1:FormatText(var_432_7.content)

				arg_429_1.text_.text = var_432_8

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_10 = 7 <= 0 and var_432_6 or var_432_6 * (utf8.len(var_432_8) / 7)

				if (7 <= 0 and var_432_6 or var_432_6 * (utf8.len(var_432_8) / 7)) > 0 and var_432_6 < var_432_10 then
					arg_429_1.talkMaxDuration = var_432_10

					if var_432_10 + var_432_5 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_10 + var_432_5
					end
				end

				arg_429_1.text_.text = var_432_8
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041104", "story_v_out_424041.awb") ~= 0 then
					local var_432_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041104", "story_v_out_424041.awb") / 1000

					if var_432_11 + var_432_5 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_11 + var_432_5
					end

					if var_432_7.prefab_name ~= "" and arg_429_1.actors_[var_432_7.prefab_name] ~= nil then
						local var_432_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_7.prefab_name].transform, "story_v_out_424041", "424041104", "story_v_out_424041.awb")

						arg_429_1:RecordAudio("424041104", var_432_12)
						arg_429_1:RecordAudio("424041104", var_432_12)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_424041", "424041104", "story_v_out_424041.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_424041", "424041104", "story_v_out_424041.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_13 = math.max(var_432_6, arg_429_1.talkMaxDuration)

			if var_432_5 <= arg_429_1.time_ and arg_429_1.time_ < var_432_5 + var_432_13 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - var_432_5) / var_432_13

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= var_432_5 + var_432_13 and arg_429_1.time_ < var_432_5 + var_432_13 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_429_1:InitPlayNodeList()
	end,
	Play424041105 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 424041105
		arg_433_1.duration_ = 1.33

		local var_433_0 = {
			zh = 1.333,
			ja = 1.233
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play424041106(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(arg_433_1.actors_["1094"]) and arg_433_1.var_.actorSpriteComps1094 == nil then
				arg_433_1.var_.actorSpriteComps1094 = arg_433_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_436_0 = 0.2

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 and not isNil(arg_433_1.actors_["1094"]) then
				if arg_433_1.var_.actorSpriteComps1094 then
					for iter_436_0, iter_436_1 in pairs(arg_433_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_436_1 then
							if arg_433_1.isInRecall_ then
								iter_436_1.color = Color.New(Mathf.Lerp(iter_436_1.color.r, arg_433_1.hightColor1.r, (arg_433_1.time_ - 0) / var_436_0), Mathf.Lerp(iter_436_1.color.g, arg_433_1.hightColor1.g, (arg_433_1.time_ - 0) / var_436_0), (Mathf.Lerp(iter_436_1.color.b, arg_433_1.hightColor1.b, (arg_433_1.time_ - 0) / var_436_0)))
							else
								local var_436_1 = Mathf.Lerp(iter_436_1.color.r, 1, (arg_433_1.time_ - 0) / var_436_0)

								iter_436_1.color = Color.New(var_436_1, var_436_1, var_436_1)
							end
						end
					end
				end
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 and not isNil(arg_433_1.actors_["1094"]) and arg_433_1.var_.actorSpriteComps1094 then
				for iter_436_2, iter_436_3 in pairs(arg_433_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_436_3 then
						iter_436_3.color = arg_433_1.isInRecall_ and (arg_433_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_433_1.var_.actorSpriteComps1094 = nil
			end

			local var_436_2 = arg_433_1.actors_["10154"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_2) and arg_433_1.var_.actorSpriteComps10154 == nil then
				arg_433_1.var_.actorSpriteComps10154 = var_436_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_436_3 = 0.2

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_3 and not isNil(var_436_2) then
				if arg_433_1.var_.actorSpriteComps10154 then
					for iter_436_4, iter_436_5 in pairs(arg_433_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_436_5 then
							if arg_433_1.isInRecall_ then
								iter_436_5.color = Color.New(Mathf.Lerp(iter_436_5.color.r, arg_433_1.hightColor2.r, (arg_433_1.time_ - 0) / var_436_3), Mathf.Lerp(iter_436_5.color.g, arg_433_1.hightColor2.g, (arg_433_1.time_ - 0) / var_436_3), (Mathf.Lerp(iter_436_5.color.b, arg_433_1.hightColor2.b, (arg_433_1.time_ - 0) / var_436_3)))
							else
								local var_436_4 = Mathf.Lerp(iter_436_5.color.r, 0.5, (arg_433_1.time_ - 0) / var_436_3)

								iter_436_5.color = Color.New(var_436_4, var_436_4, var_436_4)
							end
						end
					end
				end
			end

			if arg_433_1.time_ >= 0 + var_436_3 and arg_433_1.time_ < 0 + var_436_3 + arg_436_0 and not isNil(var_436_2) and arg_433_1.var_.actorSpriteComps10154 then
				for iter_436_6, iter_436_7 in pairs(arg_433_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_436_7 then
						iter_436_7.color = arg_433_1.isInRecall_ and (arg_433_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_433_1.var_.actorSpriteComps10154 = nil
			end

			local var_436_5 = arg_433_1.actors_["1094"].transform

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos1094 = var_436_5.localPosition
				var_436_5.localScale = Vector3.New(1, 1, 1)

				arg_433_1:CheckSpriteTmpPos("1094", 3)

				for iter_436_8 = 0, var_436_5.childCount - 1 do
					local var_436_6 = var_436_5:GetChild(iter_436_8)

					if var_436_6.name == "" or not string.find(var_436_6.name, "split") then
						var_436_6.gameObject:SetActive(true)
					else
						var_436_6.gameObject:SetActive(false)
					end
				end
			end

			local var_436_7 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_7 then
				var_436_5.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1094, Vector3.New(0, -335, -230), (arg_433_1.time_ - 0) / var_436_7)
			end

			if arg_433_1.time_ >= 0 + var_436_7 and arg_433_1.time_ < 0 + var_436_7 + arg_436_0 then
				var_436_5.localPosition = Vector3.New(0, -335, -230)
			end

			local var_436_8 = arg_433_1.actors_["10154"].transform

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos10154 = var_436_8.localPosition
				var_436_8.localScale = Vector3.New(1, 1, 1)

				arg_433_1:CheckSpriteTmpPos("10154", 7)

				for iter_436_9 = 0, var_436_8.childCount - 1 do
					local var_436_9 = var_436_8:GetChild(iter_436_9)

					if var_436_9.name == "" or not string.find(var_436_9.name, "split") then
						var_436_9.gameObject:SetActive(true)
					else
						var_436_9.gameObject:SetActive(false)
					end
				end
			end

			local var_436_10 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_10 then
				var_436_8.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_433_1.time_ - 0) / var_436_10)
			end

			if arg_433_1.time_ >= 0 + var_436_10 and arg_433_1.time_ < 0 + var_436_10 + arg_436_0 then
				var_436_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_436_11 = arg_433_1.actors_["10153"].transform

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos10153 = var_436_11.localPosition
				var_436_11.localScale = Vector3.New(1, 1, 1)

				arg_433_1:CheckSpriteTmpPos("10153", 7)

				for iter_436_10 = 0, var_436_11.childCount - 1 do
					local var_436_12 = var_436_11:GetChild(iter_436_10)

					if var_436_12.name == "" or not string.find(var_436_12.name, "split") then
						var_436_12.gameObject:SetActive(true)
					else
						var_436_12.gameObject:SetActive(false)
					end
				end
			end

			local var_436_13 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_13 then
				var_436_11.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_433_1.time_ - 0) / var_436_13)
			end

			if arg_433_1.time_ >= 0 + var_436_13 and arg_433_1.time_ < 0 + var_436_13 + arg_436_0 then
				var_436_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_436_14 = 0
			local var_436_15 = 0.15

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_14 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_16 = arg_433_1:GetWordFromCfg(424041105)
				local var_436_17 = arg_433_1:FormatText(var_436_16.content)

				arg_433_1.text_.text = var_436_17

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_19 = 6 <= 0 and var_436_15 or var_436_15 * (utf8.len(var_436_17) / 6)

				if (6 <= 0 and var_436_15 or var_436_15 * (utf8.len(var_436_17) / 6)) > 0 and var_436_15 < var_436_19 then
					arg_433_1.talkMaxDuration = var_436_19

					if var_436_19 + var_436_14 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_19 + var_436_14
					end
				end

				arg_433_1.text_.text = var_436_17
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041105", "story_v_out_424041.awb") ~= 0 then
					local var_436_20 = manager.audio:GetVoiceLength("story_v_out_424041", "424041105", "story_v_out_424041.awb") / 1000

					if var_436_20 + var_436_14 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_20 + var_436_14
					end

					if var_436_16.prefab_name ~= "" and arg_433_1.actors_[var_436_16.prefab_name] ~= nil then
						local var_436_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_16.prefab_name].transform, "story_v_out_424041", "424041105", "story_v_out_424041.awb")

						arg_433_1:RecordAudio("424041105", var_436_21)
						arg_433_1:RecordAudio("424041105", var_436_21)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_424041", "424041105", "story_v_out_424041.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_424041", "424041105", "story_v_out_424041.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_22 = math.max(var_436_15, arg_433_1.talkMaxDuration)

			if var_436_14 <= arg_433_1.time_ and arg_433_1.time_ < var_436_14 + var_436_22 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_14) / var_436_22

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_14 + var_436_22 and arg_433_1.time_ < var_436_14 + var_436_22 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
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
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play424041106 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 424041106
		arg_437_1.duration_ = 5

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play424041107(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["1094"]) and arg_437_1.var_.actorSpriteComps1094 == nil then
				arg_437_1.var_.actorSpriteComps1094 = arg_437_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_440_0 = 0.2

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["1094"]) then
				if arg_437_1.var_.actorSpriteComps1094 then
					for iter_440_0, iter_440_1 in pairs(arg_437_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_440_1 then
							if arg_437_1.isInRecall_ then
								iter_440_1.color = Color.New(Mathf.Lerp(iter_440_1.color.r, arg_437_1.hightColor2.r, (arg_437_1.time_ - 0) / var_440_0), Mathf.Lerp(iter_440_1.color.g, arg_437_1.hightColor2.g, (arg_437_1.time_ - 0) / var_440_0), (Mathf.Lerp(iter_440_1.color.b, arg_437_1.hightColor2.b, (arg_437_1.time_ - 0) / var_440_0)))
							else
								local var_440_1 = Mathf.Lerp(iter_440_1.color.r, 0.5, (arg_437_1.time_ - 0) / var_440_0)

								iter_440_1.color = Color.New(var_440_1, var_440_1, var_440_1)
							end
						end
					end
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["1094"]) and arg_437_1.var_.actorSpriteComps1094 then
				for iter_440_2, iter_440_3 in pairs(arg_437_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_440_3 then
						iter_440_3.color = arg_437_1.isInRecall_ and (arg_437_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_437_1.var_.actorSpriteComps1094 = nil
			end

			local var_440_2 = 0
			local var_440_3 = 0.825

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_2 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, true)
				arg_437_1.iconController_:SetSelectedState("hero")

				arg_437_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_437_1.callingController_:SetSelectedState("normal")

				arg_437_1.keyicon_.color = Color.New(1, 1, 1)
				arg_437_1.icon_.color = Color.New(1, 1, 1)

				local var_440_4 = arg_437_1:FormatText(arg_437_1:GetWordFromCfg(424041106).content)

				arg_437_1.text_.text = var_440_4

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_6 = 33 <= 0 and var_440_3 or var_440_3 * (utf8.len(var_440_4) / 33)

				if (33 <= 0 and var_440_3 or var_440_3 * (utf8.len(var_440_4) / 33)) > 0 and var_440_3 < var_440_6 then
					arg_437_1.talkMaxDuration = var_440_6

					if var_440_6 + var_440_2 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_6 + var_440_2
					end
				end

				arg_437_1.text_.text = var_440_4
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)
				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_7 = math.max(var_440_3, arg_437_1.talkMaxDuration)

			if var_440_2 <= arg_437_1.time_ and arg_437_1.time_ < var_440_2 + var_440_7 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_2) / var_440_7

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_2 + var_440_7 and arg_437_1.time_ < var_440_2 + var_440_7 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {}

		arg_437_1:InitPlayNodeList()
	end,
	Play424041107 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 424041107
		arg_441_1.duration_ = 9.97

		local var_441_0 = {
			zh = 9.133,
			ja = 9.966
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
				arg_441_0:Play424041108(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(arg_441_1.actors_["10154"]) and arg_441_1.var_.actorSpriteComps10154 == nil then
				arg_441_1.var_.actorSpriteComps10154 = arg_441_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_444_0 = 0.2

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 and not isNil(arg_441_1.actors_["10154"]) then
				if arg_441_1.var_.actorSpriteComps10154 then
					for iter_444_0, iter_444_1 in pairs(arg_441_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_444_1 then
							if arg_441_1.isInRecall_ then
								iter_444_1.color = Color.New(Mathf.Lerp(iter_444_1.color.r, arg_441_1.hightColor1.r, (arg_441_1.time_ - 0) / var_444_0), Mathf.Lerp(iter_444_1.color.g, arg_441_1.hightColor1.g, (arg_441_1.time_ - 0) / var_444_0), (Mathf.Lerp(iter_444_1.color.b, arg_441_1.hightColor1.b, (arg_441_1.time_ - 0) / var_444_0)))
							else
								local var_444_1 = Mathf.Lerp(iter_444_1.color.r, 1, (arg_441_1.time_ - 0) / var_444_0)

								iter_444_1.color = Color.New(var_444_1, var_444_1, var_444_1)
							end
						end
					end
				end
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 and not isNil(arg_441_1.actors_["10154"]) and arg_441_1.var_.actorSpriteComps10154 then
				for iter_444_2, iter_444_3 in pairs(arg_441_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_444_3 then
						iter_444_3.color = arg_441_1.isInRecall_ and (arg_441_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_441_1.var_.actorSpriteComps10154 = nil
			end

			local var_444_2 = arg_441_1.actors_["10154"].transform

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.var_.moveOldPos10154 = var_444_2.localPosition
				var_444_2.localScale = Vector3.New(1, 1, 1)

				arg_441_1:CheckSpriteTmpPos("10154", 4)

				for iter_444_4 = 0, var_444_2.childCount - 1 do
					local var_444_3 = var_444_2:GetChild(iter_444_4)

					if var_444_3.name == "" or not string.find(var_444_3.name, "split") then
						var_444_3.gameObject:SetActive(true)
					else
						var_444_3.gameObject:SetActive(false)
					end
				end
			end

			local var_444_4 = 0.001

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_4 then
				var_444_2.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos10154, Vector3.New(345, -338, -538), (arg_441_1.time_ - 0) / var_444_4)
			end

			if arg_441_1.time_ >= 0 + var_444_4 and arg_441_1.time_ < 0 + var_444_4 + arg_444_0 then
				var_444_2.localPosition = Vector3.New(345, -338, -538)
			end

			local var_444_5 = arg_441_1.actors_["1094"].transform

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.var_.moveOldPos1094 = var_444_5.localPosition
				var_444_5.localScale = Vector3.New(1, 1, 1)

				arg_441_1:CheckSpriteTmpPos("1094", 2)

				for iter_444_5 = 0, var_444_5.childCount - 1 do
					local var_444_6 = var_444_5:GetChild(iter_444_5)

					if var_444_6.name == "" or not string.find(var_444_6.name, "split") then
						var_444_6.gameObject:SetActive(true)
					else
						var_444_6.gameObject:SetActive(false)
					end
				end
			end

			local var_444_7 = 0.001

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_7 then
				var_444_5.localPosition = Vector3.Lerp(arg_441_1.var_.moveOldPos1094, Vector3.New(-380, -335, -230), (arg_441_1.time_ - 0) / var_444_7)
			end

			if arg_441_1.time_ >= 0 + var_444_7 and arg_441_1.time_ < 0 + var_444_7 + arg_444_0 then
				var_444_5.localPosition = Vector3.New(-380, -335, -230)
			end

			local var_444_8 = 0
			local var_444_9 = 1.025

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_8 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_10 = arg_441_1:GetWordFromCfg(424041107)
				local var_444_11 = arg_441_1:FormatText(var_444_10.content)

				arg_441_1.text_.text = var_444_11

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_13 = 41 <= 0 and var_444_9 or var_444_9 * (utf8.len(var_444_11) / 41)

				if (41 <= 0 and var_444_9 or var_444_9 * (utf8.len(var_444_11) / 41)) > 0 and var_444_9 < var_444_13 then
					arg_441_1.talkMaxDuration = var_444_13

					if var_444_13 + var_444_8 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_13 + var_444_8
					end
				end

				arg_441_1.text_.text = var_444_11
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041107", "story_v_out_424041.awb") ~= 0 then
					local var_444_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041107", "story_v_out_424041.awb") / 1000

					if var_444_14 + var_444_8 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_14 + var_444_8
					end

					if var_444_10.prefab_name ~= "" and arg_441_1.actors_[var_444_10.prefab_name] ~= nil then
						local var_444_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_10.prefab_name].transform, "story_v_out_424041", "424041107", "story_v_out_424041.awb")

						arg_441_1:RecordAudio("424041107", var_444_15)
						arg_441_1:RecordAudio("424041107", var_444_15)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_424041", "424041107", "story_v_out_424041.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_424041", "424041107", "story_v_out_424041.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_16 = math.max(var_444_9, arg_441_1.talkMaxDuration)

			if var_444_8 <= arg_441_1.time_ and arg_441_1.time_ < var_444_8 + var_444_16 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_8) / var_444_16

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_8 + var_444_16 and arg_441_1.time_ < var_444_8 + var_444_16 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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

		arg_441_1:InitPlayNodeList()
	end,
	Play424041108 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 424041108
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play424041109(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["10154"]) and arg_445_1.var_.actorSpriteComps10154 == nil then
				arg_445_1.var_.actorSpriteComps10154 = arg_445_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_448_0 = 0.2

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["10154"]) then
				if arg_445_1.var_.actorSpriteComps10154 then
					for iter_448_0, iter_448_1 in pairs(arg_445_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_448_1 then
							if arg_445_1.isInRecall_ then
								iter_448_1.color = Color.New(Mathf.Lerp(iter_448_1.color.r, arg_445_1.hightColor2.r, (arg_445_1.time_ - 0) / var_448_0), Mathf.Lerp(iter_448_1.color.g, arg_445_1.hightColor2.g, (arg_445_1.time_ - 0) / var_448_0), (Mathf.Lerp(iter_448_1.color.b, arg_445_1.hightColor2.b, (arg_445_1.time_ - 0) / var_448_0)))
							else
								local var_448_1 = Mathf.Lerp(iter_448_1.color.r, 0.5, (arg_445_1.time_ - 0) / var_448_0)

								iter_448_1.color = Color.New(var_448_1, var_448_1, var_448_1)
							end
						end
					end
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["10154"]) and arg_445_1.var_.actorSpriteComps10154 then
				for iter_448_2, iter_448_3 in pairs(arg_445_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_448_3 then
						iter_448_3.color = arg_445_1.isInRecall_ and (arg_445_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_445_1.var_.actorSpriteComps10154 = nil
			end

			local var_448_2 = 0
			local var_448_3 = 1.75

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_2 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, true)
				arg_445_1.iconController_:SetSelectedState("hero")

				arg_445_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_445_1.callingController_:SetSelectedState("normal")

				arg_445_1.keyicon_.color = Color.New(1, 1, 1)
				arg_445_1.icon_.color = Color.New(1, 1, 1)

				local var_448_4 = arg_445_1:FormatText(arg_445_1:GetWordFromCfg(424041108).content)

				arg_445_1.text_.text = var_448_4

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_6 = 66 <= 0 and var_448_3 or var_448_3 * (utf8.len(var_448_4) / 66)

				if (66 <= 0 and var_448_3 or var_448_3 * (utf8.len(var_448_4) / 66)) > 0 and var_448_3 < var_448_6 then
					arg_445_1.talkMaxDuration = var_448_6

					if var_448_6 + var_448_2 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_6 + var_448_2
					end
				end

				arg_445_1.text_.text = var_448_4
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_7 = math.max(var_448_3, arg_445_1.talkMaxDuration)

			if var_448_2 <= arg_445_1.time_ and arg_445_1.time_ < var_448_2 + var_448_7 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_2) / var_448_7

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_2 + var_448_7 and arg_445_1.time_ < var_448_2 + var_448_7 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play424041109 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 424041109
		arg_449_1.duration_ = 6.17

		local var_449_0 = {
			zh = 3.5,
			ja = 6.166
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
				arg_449_0:Play424041110(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(arg_449_1.actors_["1094"]) and arg_449_1.var_.actorSpriteComps1094 == nil then
				arg_449_1.var_.actorSpriteComps1094 = arg_449_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_452_0 = 0.2

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 and not isNil(arg_449_1.actors_["1094"]) then
				if arg_449_1.var_.actorSpriteComps1094 then
					for iter_452_0, iter_452_1 in pairs(arg_449_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 and not isNil(arg_449_1.actors_["1094"]) and arg_449_1.var_.actorSpriteComps1094 then
				for iter_452_2, iter_452_3 in pairs(arg_449_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_452_3 then
						iter_452_3.color = arg_449_1.isInRecall_ and (arg_449_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_449_1.var_.actorSpriteComps1094 = nil
			end

			local var_452_2 = arg_449_1.actors_["1094"].transform

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos1094 = var_452_2.localPosition
				var_452_2.localScale = Vector3.New(1, 1, 1)

				arg_449_1:CheckSpriteTmpPos("1094", 2)

				for iter_452_4 = 0, var_452_2.childCount - 1 do
					local var_452_3 = var_452_2:GetChild(iter_452_4)

					if var_452_3.name == "" or not string.find(var_452_3.name, "split") then
						var_452_3.gameObject:SetActive(true)
					else
						var_452_3.gameObject:SetActive(false)
					end
				end
			end

			local var_452_4 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_4 then
				var_452_2.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1094, Vector3.New(-380, -335, -230), (arg_449_1.time_ - 0) / var_452_4)
			end

			if arg_449_1.time_ >= 0 + var_452_4 and arg_449_1.time_ < 0 + var_452_4 + arg_452_0 then
				var_452_2.localPosition = Vector3.New(-380, -335, -230)
			end

			local var_452_5 = 0
			local var_452_6 = 0.375

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_5 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_7 = arg_449_1:GetWordFromCfg(424041109)
				local var_452_8 = arg_449_1:FormatText(var_452_7.content)

				arg_449_1.text_.text = var_452_8

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_10 = 15 <= 0 and var_452_6 or var_452_6 * (utf8.len(var_452_8) / 15)

				if (15 <= 0 and var_452_6 or var_452_6 * (utf8.len(var_452_8) / 15)) > 0 and var_452_6 < var_452_10 then
					arg_449_1.talkMaxDuration = var_452_10

					if var_452_10 + var_452_5 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_10 + var_452_5
					end
				end

				arg_449_1.text_.text = var_452_8
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041109", "story_v_out_424041.awb") ~= 0 then
					local var_452_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041109", "story_v_out_424041.awb") / 1000

					if var_452_11 + var_452_5 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_11 + var_452_5
					end

					if var_452_7.prefab_name ~= "" and arg_449_1.actors_[var_452_7.prefab_name] ~= nil then
						local var_452_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_7.prefab_name].transform, "story_v_out_424041", "424041109", "story_v_out_424041.awb")

						arg_449_1:RecordAudio("424041109", var_452_12)
						arg_449_1:RecordAudio("424041109", var_452_12)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_424041", "424041109", "story_v_out_424041.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_424041", "424041109", "story_v_out_424041.awb")
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
				actorName = "1094",
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
	Play424041110 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 424041110
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play424041111(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(arg_453_1.actors_["1094"]) and arg_453_1.var_.actorSpriteComps1094 == nil then
				arg_453_1.var_.actorSpriteComps1094 = arg_453_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_456_0 = 0.2

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 and not isNil(arg_453_1.actors_["1094"]) then
				if arg_453_1.var_.actorSpriteComps1094 then
					for iter_456_0, iter_456_1 in pairs(arg_453_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 and not isNil(arg_453_1.actors_["1094"]) and arg_453_1.var_.actorSpriteComps1094 then
				for iter_456_2, iter_456_3 in pairs(arg_453_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_456_3 then
						iter_456_3.color = arg_453_1.isInRecall_ and (arg_453_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_453_1.var_.actorSpriteComps1094 = nil
			end

			local var_456_2 = 0
			local var_456_3 = 0.55

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

				local var_456_4 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(424041110).content)

				arg_453_1.text_.text = var_456_4

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_6 = 22 <= 0 and var_456_3 or var_456_3 * (utf8.len(var_456_4) / 22)

				if (22 <= 0 and var_456_3 or var_456_3 * (utf8.len(var_456_4) / 22)) > 0 and var_456_3 < var_456_6 then
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
	Play424041111 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 424041111
		arg_457_1.duration_ = 9.2

		local var_457_0 = {
			zh = 5.966,
			ja = 9.2
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
				arg_457_0:Play424041112(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0.8

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_1 = arg_457_1:GetWordFromCfg(424041111)
				local var_460_2 = arg_457_1:FormatText(var_460_1.content)

				arg_457_1.text_.text = var_460_2

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_4 = 32 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 32)

				if (32 <= 0 and var_460_0 or var_460_0 * (utf8.len(var_460_2) / 32)) > 0 and var_460_0 < var_460_4 then
					arg_457_1.talkMaxDuration = var_460_4

					if var_460_4 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_4 + 0
					end
				end

				arg_457_1.text_.text = var_460_2
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041111", "story_v_out_424041.awb") ~= 0 then
					local var_460_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041111", "story_v_out_424041.awb") / 1000

					if var_460_5 + 0 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + 0
					end

					if var_460_1.prefab_name ~= "" and arg_457_1.actors_[var_460_1.prefab_name] ~= nil then
						local var_460_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_1.prefab_name].transform, "story_v_out_424041", "424041111", "story_v_out_424041.awb")

						arg_457_1:RecordAudio("424041111", var_460_6)
						arg_457_1:RecordAudio("424041111", var_460_6)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_424041", "424041111", "story_v_out_424041.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_424041", "424041111", "story_v_out_424041.awb")
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
	Play424041112 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 424041112
		arg_461_1.duration_ = 1.57

		local var_461_0 = {
			zh = 1.566,
			ja = 0.999999999999
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
				arg_461_0:Play424041113(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["10154"]) and arg_461_1.var_.actorSpriteComps10154 == nil then
				arg_461_1.var_.actorSpriteComps10154 = arg_461_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_464_0 = 0.2

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["10154"]) then
				if arg_461_1.var_.actorSpriteComps10154 then
					for iter_464_0, iter_464_1 in pairs(arg_461_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["10154"]) and arg_461_1.var_.actorSpriteComps10154 then
				for iter_464_2, iter_464_3 in pairs(arg_461_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_464_3 then
						iter_464_3.color = arg_461_1.isInRecall_ and (arg_461_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_461_1.var_.actorSpriteComps10154 = nil
			end

			local var_464_2 = arg_461_1.actors_["10154"].transform

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.moveOldPos10154 = var_464_2.localPosition
				var_464_2.localScale = Vector3.New(1, 1, 1)

				arg_461_1:CheckSpriteTmpPos("10154", 4)

				for iter_464_4 = 0, var_464_2.childCount - 1 do
					local var_464_3 = var_464_2:GetChild(iter_464_4)

					if var_464_3.name == "split_1" or not string.find(var_464_3.name, "split") then
						var_464_3.gameObject:SetActive(true)
					else
						var_464_3.gameObject:SetActive(false)
					end
				end
			end

			local var_464_4 = 0.001

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_4 then
				var_464_2.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos10154, Vector3.New(345, -338, -538), (arg_461_1.time_ - 0) / var_464_4)
			end

			if arg_461_1.time_ >= 0 + var_464_4 and arg_461_1.time_ < 0 + var_464_4 + arg_464_0 then
				var_464_2.localPosition = Vector3.New(345, -338, -538)
			end

			local var_464_5 = 0
			local var_464_6 = 0.05

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_5 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_7 = arg_461_1:GetWordFromCfg(424041112)
				local var_464_8 = arg_461_1:FormatText(var_464_7.content)

				arg_461_1.text_.text = var_464_8

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_10 = 2 <= 0 and var_464_6 or var_464_6 * (utf8.len(var_464_8) / 2)

				if (2 <= 0 and var_464_6 or var_464_6 * (utf8.len(var_464_8) / 2)) > 0 and var_464_6 < var_464_10 then
					arg_461_1.talkMaxDuration = var_464_10

					if var_464_10 + var_464_5 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_10 + var_464_5
					end
				end

				arg_461_1.text_.text = var_464_8
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041112", "story_v_out_424041.awb") ~= 0 then
					local var_464_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041112", "story_v_out_424041.awb") / 1000

					if var_464_11 + var_464_5 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_11 + var_464_5
					end

					if var_464_7.prefab_name ~= "" and arg_461_1.actors_[var_464_7.prefab_name] ~= nil then
						local var_464_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_7.prefab_name].transform, "story_v_out_424041", "424041112", "story_v_out_424041.awb")

						arg_461_1:RecordAudio("424041112", var_464_12)
						arg_461_1:RecordAudio("424041112", var_464_12)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_424041", "424041112", "story_v_out_424041.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_424041", "424041112", "story_v_out_424041.awb")
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
				actorName = "10154",
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
	Play424041113 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 424041113
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play424041114(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(arg_465_1.actors_["10154"]) and arg_465_1.var_.actorSpriteComps10154 == nil then
				arg_465_1.var_.actorSpriteComps10154 = arg_465_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_468_0 = 0.2

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 and not isNil(arg_465_1.actors_["10154"]) then
				if arg_465_1.var_.actorSpriteComps10154 then
					for iter_468_0, iter_468_1 in pairs(arg_465_1.var_.actorSpriteComps10154:ToTable()) do
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

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 and not isNil(arg_465_1.actors_["10154"]) and arg_465_1.var_.actorSpriteComps10154 then
				for iter_468_2, iter_468_3 in pairs(arg_465_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_468_3 then
						iter_468_3.color = arg_465_1.isInRecall_ and (arg_465_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_465_1.var_.actorSpriteComps10154 = nil
			end

			local var_468_2 = 0
			local var_468_3 = 0.825

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_2 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				arg_465_1.leftNameTxt_.text = arg_465_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_4 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(424041113).content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_6 = 33 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_4) / 33)

				if (33 <= 0 and var_468_3 or var_468_3 * (utf8.len(var_468_4) / 33)) > 0 and var_468_3 < var_468_6 then
					arg_465_1.talkMaxDuration = var_468_6

					if var_468_6 + var_468_2 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_6 + var_468_2
					end
				end

				arg_465_1.text_.text = var_468_4
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_7 = math.max(var_468_3, arg_465_1.talkMaxDuration)

			if var_468_2 <= arg_465_1.time_ and arg_465_1.time_ < var_468_2 + var_468_7 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_2) / var_468_7

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_2 + var_468_7 and arg_465_1.time_ < var_468_2 + var_468_7 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play424041114 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 424041114
		arg_469_1.duration_ = 8.2

		local var_469_0 = {
			zh = 5.566,
			ja = 8.2
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
				arg_469_0:Play424041115(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["10153"]) and arg_469_1.var_.actorSpriteComps10153 == nil then
				arg_469_1.var_.actorSpriteComps10153 = arg_469_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_472_0 = 0.2

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["10153"]) then
				if arg_469_1.var_.actorSpriteComps10153 then
					for iter_472_0, iter_472_1 in pairs(arg_469_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_472_1 then
							if arg_469_1.isInRecall_ then
								iter_472_1.color = Color.New(Mathf.Lerp(iter_472_1.color.r, arg_469_1.hightColor1.r, (arg_469_1.time_ - 0) / var_472_0), Mathf.Lerp(iter_472_1.color.g, arg_469_1.hightColor1.g, (arg_469_1.time_ - 0) / var_472_0), (Mathf.Lerp(iter_472_1.color.b, arg_469_1.hightColor1.b, (arg_469_1.time_ - 0) / var_472_0)))
							else
								local var_472_1 = Mathf.Lerp(iter_472_1.color.r, 1, (arg_469_1.time_ - 0) / var_472_0)

								iter_472_1.color = Color.New(var_472_1, var_472_1, var_472_1)
							end
						end
					end
				end
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["10153"]) and arg_469_1.var_.actorSpriteComps10153 then
				for iter_472_2, iter_472_3 in pairs(arg_469_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_472_3 then
						iter_472_3.color = arg_469_1.isInRecall_ and (arg_469_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_469_1.var_.actorSpriteComps10153 = nil
			end

			local var_472_2 = arg_469_1.actors_["10153"].transform

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.var_.moveOldPos10153 = var_472_2.localPosition
				var_472_2.localScale = Vector3.New(1, 1, 1)

				arg_469_1:CheckSpriteTmpPos("10153", 2)

				for iter_472_4 = 0, var_472_2.childCount - 1 do
					local var_472_3 = var_472_2:GetChild(iter_472_4)

					if var_472_3.name == "" or not string.find(var_472_3.name, "split") then
						var_472_3.gameObject:SetActive(true)
					else
						var_472_3.gameObject:SetActive(false)
					end
				end
			end

			local var_472_4 = 0.001

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_4 then
				var_472_2.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_469_1.time_ - 0) / var_472_4)
			end

			if arg_469_1.time_ >= 0 + var_472_4 and arg_469_1.time_ < 0 + var_472_4 + arg_472_0 then
				var_472_2.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_472_5 = arg_469_1.actors_["1094"].transform

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.var_.moveOldPos1094 = var_472_5.localPosition
				var_472_5.localScale = Vector3.New(1, 1, 1)

				arg_469_1:CheckSpriteTmpPos("1094", 7)

				for iter_472_5 = 0, var_472_5.childCount - 1 do
					local var_472_6 = var_472_5:GetChild(iter_472_5)

					if var_472_6.name == "" or not string.find(var_472_6.name, "split") then
						var_472_6.gameObject:SetActive(true)
					else
						var_472_6.gameObject:SetActive(false)
					end
				end
			end

			local var_472_7 = 0.001

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_7 then
				var_472_5.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_469_1.time_ - 0) / var_472_7)
			end

			if arg_469_1.time_ >= 0 + var_472_7 and arg_469_1.time_ < 0 + var_472_7 + arg_472_0 then
				var_472_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_472_8 = 0
			local var_472_9 = 0.675

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_8 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_10 = arg_469_1:GetWordFromCfg(424041114)
				local var_472_11 = arg_469_1:FormatText(var_472_10.content)

				arg_469_1.text_.text = var_472_11

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_13 = 27 <= 0 and var_472_9 or var_472_9 * (utf8.len(var_472_11) / 27)

				if (27 <= 0 and var_472_9 or var_472_9 * (utf8.len(var_472_11) / 27)) > 0 and var_472_9 < var_472_13 then
					arg_469_1.talkMaxDuration = var_472_13

					if var_472_13 + var_472_8 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_13 + var_472_8
					end
				end

				arg_469_1.text_.text = var_472_11
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041114", "story_v_out_424041.awb") ~= 0 then
					local var_472_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041114", "story_v_out_424041.awb") / 1000

					if var_472_14 + var_472_8 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_14 + var_472_8
					end

					if var_472_10.prefab_name ~= "" and arg_469_1.actors_[var_472_10.prefab_name] ~= nil then
						local var_472_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_10.prefab_name].transform, "story_v_out_424041", "424041114", "story_v_out_424041.awb")

						arg_469_1:RecordAudio("424041114", var_472_15)
						arg_469_1:RecordAudio("424041114", var_472_15)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_424041", "424041114", "story_v_out_424041.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_424041", "424041114", "story_v_out_424041.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_16 = math.max(var_472_9, arg_469_1.talkMaxDuration)

			if var_472_8 <= arg_469_1.time_ and arg_469_1.time_ < var_472_8 + var_472_16 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_8) / var_472_16

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_8 + var_472_16 and arg_469_1.time_ < var_472_8 + var_472_16 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
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

		arg_469_1:InitPlayNodeList()
	end,
	Play424041115 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 424041115
		arg_473_1.duration_ = 2.37

		local var_473_0 = {
			zh = 1.866,
			ja = 2.366
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
				arg_473_0:Play424041116(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(arg_473_1.actors_["10154"]) and arg_473_1.var_.actorSpriteComps10154 == nil then
				arg_473_1.var_.actorSpriteComps10154 = arg_473_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_476_0 = 0.2

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 and not isNil(arg_473_1.actors_["10154"]) then
				if arg_473_1.var_.actorSpriteComps10154 then
					for iter_476_0, iter_476_1 in pairs(arg_473_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_476_1 then
							if arg_473_1.isInRecall_ then
								iter_476_1.color = Color.New(Mathf.Lerp(iter_476_1.color.r, arg_473_1.hightColor1.r, (arg_473_1.time_ - 0) / var_476_0), Mathf.Lerp(iter_476_1.color.g, arg_473_1.hightColor1.g, (arg_473_1.time_ - 0) / var_476_0), (Mathf.Lerp(iter_476_1.color.b, arg_473_1.hightColor1.b, (arg_473_1.time_ - 0) / var_476_0)))
							else
								local var_476_1 = Mathf.Lerp(iter_476_1.color.r, 1, (arg_473_1.time_ - 0) / var_476_0)

								iter_476_1.color = Color.New(var_476_1, var_476_1, var_476_1)
							end
						end
					end
				end
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 and not isNil(arg_473_1.actors_["10154"]) and arg_473_1.var_.actorSpriteComps10154 then
				for iter_476_2, iter_476_3 in pairs(arg_473_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_476_3 then
						iter_476_3.color = arg_473_1.isInRecall_ and (arg_473_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_473_1.var_.actorSpriteComps10154 = nil
			end

			local var_476_2 = arg_473_1.actors_["10153"]

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(var_476_2) and arg_473_1.var_.actorSpriteComps10153 == nil then
				arg_473_1.var_.actorSpriteComps10153 = var_476_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_476_3 = 0.2

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_3 and not isNil(var_476_2) then
				if arg_473_1.var_.actorSpriteComps10153 then
					for iter_476_4, iter_476_5 in pairs(arg_473_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_476_5 then
							if arg_473_1.isInRecall_ then
								iter_476_5.color = Color.New(Mathf.Lerp(iter_476_5.color.r, arg_473_1.hightColor2.r, (arg_473_1.time_ - 0) / var_476_3), Mathf.Lerp(iter_476_5.color.g, arg_473_1.hightColor2.g, (arg_473_1.time_ - 0) / var_476_3), (Mathf.Lerp(iter_476_5.color.b, arg_473_1.hightColor2.b, (arg_473_1.time_ - 0) / var_476_3)))
							else
								local var_476_4 = Mathf.Lerp(iter_476_5.color.r, 0.5, (arg_473_1.time_ - 0) / var_476_3)

								iter_476_5.color = Color.New(var_476_4, var_476_4, var_476_4)
							end
						end
					end
				end
			end

			if arg_473_1.time_ >= 0 + var_476_3 and arg_473_1.time_ < 0 + var_476_3 + arg_476_0 and not isNil(var_476_2) and arg_473_1.var_.actorSpriteComps10153 then
				for iter_476_6, iter_476_7 in pairs(arg_473_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_476_7 then
						iter_476_7.color = arg_473_1.isInRecall_ and (arg_473_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_473_1.var_.actorSpriteComps10153 = nil
			end

			local var_476_5 = arg_473_1.actors_["10154"].transform

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.var_.moveOldPos10154 = var_476_5.localPosition
				var_476_5.localScale = Vector3.New(1, 1, 1)

				arg_473_1:CheckSpriteTmpPos("10154", 4)

				for iter_476_8 = 0, var_476_5.childCount - 1 do
					local var_476_6 = var_476_5:GetChild(iter_476_8)

					if var_476_6.name == "split_1" or not string.find(var_476_6.name, "split") then
						var_476_6.gameObject:SetActive(true)
					else
						var_476_6.gameObject:SetActive(false)
					end
				end
			end

			local var_476_7 = 0.001

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_7 then
				var_476_5.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos10154, Vector3.New(345, -338, -538), (arg_473_1.time_ - 0) / var_476_7)
			end

			if arg_473_1.time_ >= 0 + var_476_7 and arg_473_1.time_ < 0 + var_476_7 + arg_476_0 then
				var_476_5.localPosition = Vector3.New(345, -338, -538)
			end

			local var_476_8 = 0
			local var_476_9 = 0.275

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_8 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_10 = arg_473_1:GetWordFromCfg(424041115)
				local var_476_11 = arg_473_1:FormatText(var_476_10.content)

				arg_473_1.text_.text = var_476_11

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_13 = 11 <= 0 and var_476_9 or var_476_9 * (utf8.len(var_476_11) / 11)

				if (11 <= 0 and var_476_9 or var_476_9 * (utf8.len(var_476_11) / 11)) > 0 and var_476_9 < var_476_13 then
					arg_473_1.talkMaxDuration = var_476_13

					if var_476_13 + var_476_8 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_13 + var_476_8
					end
				end

				arg_473_1.text_.text = var_476_11
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041115", "story_v_out_424041.awb") ~= 0 then
					local var_476_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041115", "story_v_out_424041.awb") / 1000

					if var_476_14 + var_476_8 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_14 + var_476_8
					end

					if var_476_10.prefab_name ~= "" and arg_473_1.actors_[var_476_10.prefab_name] ~= nil then
						local var_476_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_10.prefab_name].transform, "story_v_out_424041", "424041115", "story_v_out_424041.awb")

						arg_473_1:RecordAudio("424041115", var_476_15)
						arg_473_1:RecordAudio("424041115", var_476_15)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_424041", "424041115", "story_v_out_424041.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_424041", "424041115", "story_v_out_424041.awb")
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
				actorName = "10154",
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
	Play424041116 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 424041116
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play424041117(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(arg_477_1.actors_["10154"]) and arg_477_1.var_.actorSpriteComps10154 == nil then
				arg_477_1.var_.actorSpriteComps10154 = arg_477_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_480_0 = 0.2

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 and not isNil(arg_477_1.actors_["10154"]) then
				if arg_477_1.var_.actorSpriteComps10154 then
					for iter_480_0, iter_480_1 in pairs(arg_477_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_480_1 then
							if arg_477_1.isInRecall_ then
								iter_480_1.color = Color.New(Mathf.Lerp(iter_480_1.color.r, arg_477_1.hightColor2.r, (arg_477_1.time_ - 0) / var_480_0), Mathf.Lerp(iter_480_1.color.g, arg_477_1.hightColor2.g, (arg_477_1.time_ - 0) / var_480_0), (Mathf.Lerp(iter_480_1.color.b, arg_477_1.hightColor2.b, (arg_477_1.time_ - 0) / var_480_0)))
							else
								local var_480_1 = Mathf.Lerp(iter_480_1.color.r, 0.5, (arg_477_1.time_ - 0) / var_480_0)

								iter_480_1.color = Color.New(var_480_1, var_480_1, var_480_1)
							end
						end
					end
				end
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 and not isNil(arg_477_1.actors_["10154"]) and arg_477_1.var_.actorSpriteComps10154 then
				for iter_480_2, iter_480_3 in pairs(arg_477_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_480_3 then
						iter_480_3.color = arg_477_1.isInRecall_ and (arg_477_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_477_1.var_.actorSpriteComps10154 = nil
			end

			local var_480_2 = 0
			local var_480_3 = 0.85

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_2 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_4 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(424041116).content)

				arg_477_1.text_.text = var_480_4

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_6 = 34 <= 0 and var_480_3 or var_480_3 * (utf8.len(var_480_4) / 34)

				if (34 <= 0 and var_480_3 or var_480_3 * (utf8.len(var_480_4) / 34)) > 0 and var_480_3 < var_480_6 then
					arg_477_1.talkMaxDuration = var_480_6

					if var_480_6 + var_480_2 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_6 + var_480_2
					end
				end

				arg_477_1.text_.text = var_480_4
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)
				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_7 = math.max(var_480_3, arg_477_1.talkMaxDuration)

			if var_480_2 <= arg_477_1.time_ and arg_477_1.time_ < var_480_2 + var_480_7 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_2) / var_480_7

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_2 + var_480_7 and arg_477_1.time_ < var_480_2 + var_480_7 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play424041117 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 424041117
		arg_481_1.duration_ = 1.7

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play424041118(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(arg_481_1.actors_["10154"]) and arg_481_1.var_.actorSpriteComps10154 == nil then
				arg_481_1.var_.actorSpriteComps10154 = arg_481_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_484_0 = 0.2

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 and not isNil(arg_481_1.actors_["10154"]) then
				if arg_481_1.var_.actorSpriteComps10154 then
					for iter_484_0, iter_484_1 in pairs(arg_481_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_484_1 then
							if arg_481_1.isInRecall_ then
								iter_484_1.color = Color.New(Mathf.Lerp(iter_484_1.color.r, arg_481_1.hightColor1.r, (arg_481_1.time_ - 0) / var_484_0), Mathf.Lerp(iter_484_1.color.g, arg_481_1.hightColor1.g, (arg_481_1.time_ - 0) / var_484_0), (Mathf.Lerp(iter_484_1.color.b, arg_481_1.hightColor1.b, (arg_481_1.time_ - 0) / var_484_0)))
							else
								local var_484_1 = Mathf.Lerp(iter_484_1.color.r, 1, (arg_481_1.time_ - 0) / var_484_0)

								iter_484_1.color = Color.New(var_484_1, var_484_1, var_484_1)
							end
						end
					end
				end
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 and not isNil(arg_481_1.actors_["10154"]) and arg_481_1.var_.actorSpriteComps10154 then
				for iter_484_2, iter_484_3 in pairs(arg_481_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_484_3 then
						iter_484_3.color = arg_481_1.isInRecall_ and (arg_481_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_481_1.var_.actorSpriteComps10154 = nil
			end

			local var_484_2 = arg_481_1.actors_["10154"].transform

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos10154 = var_484_2.localPosition
				var_484_2.localScale = Vector3.New(1, 1, 1)

				arg_481_1:CheckSpriteTmpPos("10154", 4)

				for iter_484_4 = 0, var_484_2.childCount - 1 do
					local var_484_3 = var_484_2:GetChild(iter_484_4)

					if var_484_3.name == "" or not string.find(var_484_3.name, "split") then
						var_484_3.gameObject:SetActive(true)
					else
						var_484_3.gameObject:SetActive(false)
					end
				end
			end

			local var_484_4 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_4 then
				var_484_2.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos10154, Vector3.New(345, -338, -538), (arg_481_1.time_ - 0) / var_484_4)
			end

			if arg_481_1.time_ >= 0 + var_484_4 and arg_481_1.time_ < 0 + var_484_4 + arg_484_0 then
				var_484_2.localPosition = Vector3.New(345, -338, -538)
			end

			local var_484_5 = 0
			local var_484_6 = 0.25

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_5 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_7 = arg_481_1:GetWordFromCfg(424041117)
				local var_484_8 = arg_481_1:FormatText(var_484_7.content)

				arg_481_1.text_.text = var_484_8

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_10 = 10 <= 0 and var_484_6 or var_484_6 * (utf8.len(var_484_8) / 10)

				if (10 <= 0 and var_484_6 or var_484_6 * (utf8.len(var_484_8) / 10)) > 0 and var_484_6 < var_484_10 then
					arg_481_1.talkMaxDuration = var_484_10

					if var_484_10 + var_484_5 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_10 + var_484_5
					end
				end

				arg_481_1.text_.text = var_484_8
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041117", "story_v_out_424041.awb") ~= 0 then
					local var_484_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041117", "story_v_out_424041.awb") / 1000

					if var_484_11 + var_484_5 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_11 + var_484_5
					end

					if var_484_7.prefab_name ~= "" and arg_481_1.actors_[var_484_7.prefab_name] ~= nil then
						local var_484_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_7.prefab_name].transform, "story_v_out_424041", "424041117", "story_v_out_424041.awb")

						arg_481_1:RecordAudio("424041117", var_484_12)
						arg_481_1:RecordAudio("424041117", var_484_12)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_424041", "424041117", "story_v_out_424041.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_424041", "424041117", "story_v_out_424041.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_13 = math.max(var_484_6, arg_481_1.talkMaxDuration)

			if var_484_5 <= arg_481_1.time_ and arg_481_1.time_ < var_484_5 + var_484_13 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_5) / var_484_13

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_5 + var_484_13 and arg_481_1.time_ < var_484_5 + var_484_13 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
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
	Play424041118 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 424041118
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play424041119(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(arg_485_1.actors_["10154"]) and arg_485_1.var_.actorSpriteComps10154 == nil then
				arg_485_1.var_.actorSpriteComps10154 = arg_485_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_488_0 = 0.2

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 and not isNil(arg_485_1.actors_["10154"]) then
				if arg_485_1.var_.actorSpriteComps10154 then
					for iter_488_0, iter_488_1 in pairs(arg_485_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_488_1 then
							if arg_485_1.isInRecall_ then
								iter_488_1.color = Color.New(Mathf.Lerp(iter_488_1.color.r, arg_485_1.hightColor2.r, (arg_485_1.time_ - 0) / var_488_0), Mathf.Lerp(iter_488_1.color.g, arg_485_1.hightColor2.g, (arg_485_1.time_ - 0) / var_488_0), (Mathf.Lerp(iter_488_1.color.b, arg_485_1.hightColor2.b, (arg_485_1.time_ - 0) / var_488_0)))
							else
								local var_488_1 = Mathf.Lerp(iter_488_1.color.r, 0.5, (arg_485_1.time_ - 0) / var_488_0)

								iter_488_1.color = Color.New(var_488_1, var_488_1, var_488_1)
							end
						end
					end
				end
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 and not isNil(arg_485_1.actors_["10154"]) and arg_485_1.var_.actorSpriteComps10154 then
				for iter_488_2, iter_488_3 in pairs(arg_485_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_488_3 then
						iter_488_3.color = arg_485_1.isInRecall_ and (arg_485_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_485_1.var_.actorSpriteComps10154 = nil
			end

			local var_488_2 = 0
			local var_488_3 = 0.525

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_2 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, true)
				arg_485_1.iconController_:SetSelectedState("hero")

				arg_485_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_485_1.callingController_:SetSelectedState("normal")

				arg_485_1.keyicon_.color = Color.New(1, 1, 1)
				arg_485_1.icon_.color = Color.New(1, 1, 1)

				local var_488_4 = arg_485_1:FormatText(arg_485_1:GetWordFromCfg(424041118).content)

				arg_485_1.text_.text = var_488_4

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_6 = 21 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_4) / 21)

				if (21 <= 0 and var_488_3 or var_488_3 * (utf8.len(var_488_4) / 21)) > 0 and var_488_3 < var_488_6 then
					arg_485_1.talkMaxDuration = var_488_6

					if var_488_6 + var_488_2 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_6 + var_488_2
					end
				end

				arg_485_1.text_.text = var_488_4
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_7 = math.max(var_488_3, arg_485_1.talkMaxDuration)

			if var_488_2 <= arg_485_1.time_ and arg_485_1.time_ < var_488_2 + var_488_7 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_2) / var_488_7

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_2 + var_488_7 and arg_485_1.time_ < var_488_2 + var_488_7 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play424041119 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 424041119
		arg_489_1.duration_ = 8.03

		local var_489_0 = {
			zh = 7.133,
			ja = 8.033
		}
		local var_489_1 = manager.audio:GetLocalizationFlag()

		if var_489_0[var_489_1] ~= nil then
			arg_489_1.duration_ = var_489_0[var_489_1]
		end

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play424041120(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.mask_.enabled = true
				arg_489_1.mask_.raycastTarget = true

				arg_489_1:SetGaussion(false)
			end

			local var_492_0 = 2

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_0 then
				local var_492_1 = Color.New(0, 0, 0)

				var_492_1.a = Mathf.Lerp(0, 1, (arg_489_1.time_ - 0) / var_492_0)
				arg_489_1.mask_.color = var_492_1
			end

			if arg_489_1.time_ >= 0 + var_492_0 and arg_489_1.time_ < 0 + var_492_0 + arg_492_0 then
				local var_492_2 = Color.New(0, 0, 0)

				var_492_2.a = 1
				arg_489_1.mask_.color = var_492_2
			end

			local var_492_3 = 2

			if 2 < arg_489_1.time_ and arg_489_1.time_ <= var_492_3 + arg_492_0 then
				arg_489_1.mask_.enabled = true
				arg_489_1.mask_.raycastTarget = true

				arg_489_1:SetGaussion(false)
			end

			local var_492_4 = 2

			if var_492_3 <= arg_489_1.time_ and arg_489_1.time_ < var_492_3 + var_492_4 then
				local var_492_5 = Color.New(0, 0, 0)

				var_492_5.a = Mathf.Lerp(1, 0, (arg_489_1.time_ - var_492_3) / var_492_4)
				arg_489_1.mask_.color = var_492_5
			end

			if arg_489_1.time_ >= var_492_3 + var_492_4 and arg_489_1.time_ < var_492_3 + var_492_4 + arg_492_0 then
				local var_492_6 = Color.New(0, 0, 0)

				arg_489_1.mask_.enabled = false
				var_492_6.a = 0
				arg_489_1.mask_.color = var_492_6
			end

			local var_492_7 = arg_489_1.actors_["10154"].transform

			if 1.966 < arg_489_1.time_ and arg_489_1.time_ <= 1.966 + arg_492_0 then
				arg_489_1.var_.moveOldPos10154 = var_492_7.localPosition
				var_492_7.localScale = Vector3.New(1, 1, 1)

				arg_489_1:CheckSpriteTmpPos("10154", 7)

				for iter_492_0 = 0, var_492_7.childCount - 1 do
					local var_492_8 = var_492_7:GetChild(iter_492_0)

					if var_492_8.name == "" or not string.find(var_492_8.name, "split") then
						var_492_8.gameObject:SetActive(true)
					else
						var_492_8.gameObject:SetActive(false)
					end
				end
			end

			local var_492_9 = 0.001

			if 1.966 <= arg_489_1.time_ and arg_489_1.time_ < 1.966 + var_492_9 then
				var_492_7.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_489_1.time_ - 1.966) / var_492_9)
			end

			if arg_489_1.time_ >= 1.966 + var_492_9 and arg_489_1.time_ < 1.966 + var_492_9 + arg_492_0 then
				var_492_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_492_10 = arg_489_1.actors_["10153"].transform

			if 1.966 < arg_489_1.time_ and arg_489_1.time_ <= 1.966 + arg_492_0 then
				arg_489_1.var_.moveOldPos10153 = var_492_10.localPosition
				var_492_10.localScale = Vector3.New(1, 1, 1)

				arg_489_1:CheckSpriteTmpPos("10153", 7)

				for iter_492_1 = 0, var_492_10.childCount - 1 do
					local var_492_11 = var_492_10:GetChild(iter_492_1)

					if var_492_11.name == "" or not string.find(var_492_11.name, "split") then
						var_492_11.gameObject:SetActive(true)
					else
						var_492_11.gameObject:SetActive(false)
					end
				end
			end

			local var_492_12 = 0.001

			if 1.966 <= arg_489_1.time_ and arg_489_1.time_ < 1.966 + var_492_12 then
				var_492_10.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_489_1.time_ - 1.966) / var_492_12)
			end

			if arg_489_1.time_ >= 1.966 + var_492_12 and arg_489_1.time_ < 1.966 + var_492_12 + arg_492_0 then
				var_492_10.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_489_1.frameCnt_ <= 1 then
				arg_489_1.dialog_:SetActive(false)
			end

			local var_492_13 = 4
			local var_492_14 = 0.425

			if 4 < arg_489_1.time_ and arg_489_1.time_ <= var_492_13 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0

				arg_489_1.dialog_:SetActive(true)

				arg_489_1.dialogCg_.alpha = 0

				local var_492_15 = LeanTween.value(arg_489_1.dialog_, 0, 1, 0.3)

				var_492_15:setOnUpdate(LuaHelper.FloatAction(function(arg_493_0)
					arg_489_1.dialogCg_.alpha = arg_493_0
				end))
				var_492_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_489_1.dialog_)
					var_492_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_489_1.duration_ = arg_489_1.duration_ + 0.3

				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_16 = arg_489_1:GetWordFromCfg(424041119)
				local var_492_17 = arg_489_1:FormatText(var_492_16.content)

				arg_489_1.text_.text = var_492_17

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_19 = 17 <= 0 and var_492_14 or var_492_14 * (utf8.len(var_492_17) / 17)

				if (17 <= 0 and var_492_14 or var_492_14 * (utf8.len(var_492_17) / 17)) > 0 and var_492_14 < var_492_19 then
					arg_489_1.talkMaxDuration = var_492_19
					var_492_13 = var_492_13 + 0.3

					if var_492_19 + var_492_13 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_19 + var_492_13
					end
				end

				arg_489_1.text_.text = var_492_17
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041119", "story_v_out_424041.awb") ~= 0 then
					local var_492_20 = manager.audio:GetVoiceLength("story_v_out_424041", "424041119", "story_v_out_424041.awb") / 1000

					if var_492_20 + var_492_13 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_20 + var_492_13
					end

					if var_492_16.prefab_name ~= "" and arg_489_1.actors_[var_492_16.prefab_name] ~= nil then
						local var_492_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_16.prefab_name].transform, "story_v_out_424041", "424041119", "story_v_out_424041.awb")

						arg_489_1:RecordAudio("424041119", var_492_21)
						arg_489_1:RecordAudio("424041119", var_492_21)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_out_424041", "424041119", "story_v_out_424041.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_out_424041", "424041119", "story_v_out_424041.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_22 = var_492_13 + 0.3
			local var_492_23 = math.max(var_492_14, arg_489_1.talkMaxDuration)

			if var_492_13 + 0.3 <= arg_489_1.time_ and arg_489_1.time_ < var_492_22 + var_492_23 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_22) / var_492_23

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_22 + var_492_23 and arg_489_1.time_ < var_492_22 + var_492_23 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play424041120 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 424041120
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play424041121(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0.825

			if 0 < arg_495_1.time_ and arg_495_1.time_ <= 0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				arg_495_1.leftNameTxt_.text = arg_495_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, true)
				arg_495_1.iconController_:SetSelectedState("hero")

				arg_495_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_495_1.callingController_:SetSelectedState("normal")

				arg_495_1.keyicon_.color = Color.New(1, 1, 1)
				arg_495_1.icon_.color = Color.New(1, 1, 1)

				local var_498_1 = arg_495_1:FormatText(arg_495_1:GetWordFromCfg(424041120).content)

				arg_495_1.text_.text = var_498_1

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_3 = 33 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_1) / 33)

				if (33 <= 0 and var_498_0 or var_498_0 * (utf8.len(var_498_1) / 33)) > 0 and var_498_0 < var_498_3 then
					arg_495_1.talkMaxDuration = var_498_3

					if var_498_3 + 0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_3 + 0
					end
				end

				arg_495_1.text_.text = var_498_1
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_4 = math.max(var_498_0, arg_495_1.talkMaxDuration)

			if 0 <= arg_495_1.time_ and arg_495_1.time_ < 0 + var_498_4 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - 0) / var_498_4

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= 0 + var_498_4 and arg_495_1.time_ < 0 + var_498_4 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play424041121 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 424041121
		arg_499_1.duration_ = 1

		local var_499_0 = {
			zh = 0.999999999999,
			ja = 1
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
				arg_499_0:Play424041122(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 and not isNil(arg_499_1.actors_["1094"]) and arg_499_1.var_.actorSpriteComps1094 == nil then
				arg_499_1.var_.actorSpriteComps1094 = arg_499_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_502_0 = 0.2

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_0 and not isNil(arg_499_1.actors_["1094"]) then
				if arg_499_1.var_.actorSpriteComps1094 then
					for iter_502_0, iter_502_1 in pairs(arg_499_1.var_.actorSpriteComps1094:ToTable()) do
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

			if arg_499_1.time_ >= 0 + var_502_0 and arg_499_1.time_ < 0 + var_502_0 + arg_502_0 and not isNil(arg_499_1.actors_["1094"]) and arg_499_1.var_.actorSpriteComps1094 then
				for iter_502_2, iter_502_3 in pairs(arg_499_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_502_3 then
						iter_502_3.color = arg_499_1.isInRecall_ and (arg_499_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_499_1.var_.actorSpriteComps1094 = nil
			end

			local var_502_2 = arg_499_1.actors_["1094"].transform

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos1094 = var_502_2.localPosition
				var_502_2.localScale = Vector3.New(1, 1, 1)

				arg_499_1:CheckSpriteTmpPos("1094", 4)

				for iter_502_4 = 0, var_502_2.childCount - 1 do
					local var_502_3 = var_502_2:GetChild(iter_502_4)

					if var_502_3.name == "" or not string.find(var_502_3.name, "split") then
						var_502_3.gameObject:SetActive(true)
					else
						var_502_3.gameObject:SetActive(false)
					end
				end
			end

			local var_502_4 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_4 then
				var_502_2.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_499_1.time_ - 0) / var_502_4)
			end

			if arg_499_1.time_ >= 0 + var_502_4 and arg_499_1.time_ < 0 + var_502_4 + arg_502_0 then
				var_502_2.localPosition = Vector3.New(470, -335, -230)
			end

			local var_502_5 = arg_499_1.actors_["10154"].transform

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= 0 + arg_502_0 then
				arg_499_1.var_.moveOldPos10154 = var_502_5.localPosition
				var_502_5.localScale = Vector3.New(1, 1, 1)

				arg_499_1:CheckSpriteTmpPos("10154", 7)

				for iter_502_5 = 0, var_502_5.childCount - 1 do
					local var_502_6 = var_502_5:GetChild(iter_502_5)

					if var_502_6.name == "" or not string.find(var_502_6.name, "split") then
						var_502_6.gameObject:SetActive(true)
					else
						var_502_6.gameObject:SetActive(false)
					end
				end
			end

			local var_502_7 = 0.001

			if 0 <= arg_499_1.time_ and arg_499_1.time_ < 0 + var_502_7 then
				var_502_5.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_499_1.time_ - 0) / var_502_7)
			end

			if arg_499_1.time_ >= 0 + var_502_7 and arg_499_1.time_ < 0 + var_502_7 + arg_502_0 then
				var_502_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_502_8 = 0
			local var_502_9 = 0.05

			if 0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_8 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				arg_499_1.leftNameTxt_.text = arg_499_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_10 = arg_499_1:GetWordFromCfg(424041121)
				local var_502_11 = arg_499_1:FormatText(var_502_10.content)

				arg_499_1.text_.text = var_502_11

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_13 = 2 <= 0 and var_502_9 or var_502_9 * (utf8.len(var_502_11) / 2)

				if (2 <= 0 and var_502_9 or var_502_9 * (utf8.len(var_502_11) / 2)) > 0 and var_502_9 < var_502_13 then
					arg_499_1.talkMaxDuration = var_502_13

					if var_502_13 + var_502_8 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_13 + var_502_8
					end
				end

				arg_499_1.text_.text = var_502_11
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041121", "story_v_out_424041.awb") ~= 0 then
					local var_502_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041121", "story_v_out_424041.awb") / 1000

					if var_502_14 + var_502_8 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_14 + var_502_8
					end

					if var_502_10.prefab_name ~= "" and arg_499_1.actors_[var_502_10.prefab_name] ~= nil then
						local var_502_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_10.prefab_name].transform, "story_v_out_424041", "424041121", "story_v_out_424041.awb")

						arg_499_1:RecordAudio("424041121", var_502_15)
						arg_499_1:RecordAudio("424041121", var_502_15)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_424041", "424041121", "story_v_out_424041.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_424041", "424041121", "story_v_out_424041.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_16 = math.max(var_502_9, arg_499_1.talkMaxDuration)

			if var_502_8 <= arg_499_1.time_ and arg_499_1.time_ < var_502_8 + var_502_16 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_8) / var_502_16

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_8 + var_502_16 and arg_499_1.time_ < var_502_8 + var_502_16 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
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
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	Play424041122 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 424041122
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play424041123(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			if 0 < arg_503_1.time_ and arg_503_1.time_ <= 0 + arg_506_0 and not isNil(arg_503_1.actors_["1094"]) and arg_503_1.var_.actorSpriteComps1094 == nil then
				arg_503_1.var_.actorSpriteComps1094 = arg_503_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_506_0 = 0.2

			if 0 <= arg_503_1.time_ and arg_503_1.time_ < 0 + var_506_0 and not isNil(arg_503_1.actors_["1094"]) then
				if arg_503_1.var_.actorSpriteComps1094 then
					for iter_506_0, iter_506_1 in pairs(arg_503_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_506_1 then
							if arg_503_1.isInRecall_ then
								iter_506_1.color = Color.New(Mathf.Lerp(iter_506_1.color.r, arg_503_1.hightColor2.r, (arg_503_1.time_ - 0) / var_506_0), Mathf.Lerp(iter_506_1.color.g, arg_503_1.hightColor2.g, (arg_503_1.time_ - 0) / var_506_0), (Mathf.Lerp(iter_506_1.color.b, arg_503_1.hightColor2.b, (arg_503_1.time_ - 0) / var_506_0)))
							else
								local var_506_1 = Mathf.Lerp(iter_506_1.color.r, 0.5, (arg_503_1.time_ - 0) / var_506_0)

								iter_506_1.color = Color.New(var_506_1, var_506_1, var_506_1)
							end
						end
					end
				end
			end

			if arg_503_1.time_ >= 0 + var_506_0 and arg_503_1.time_ < 0 + var_506_0 + arg_506_0 and not isNil(arg_503_1.actors_["1094"]) and arg_503_1.var_.actorSpriteComps1094 then
				for iter_506_2, iter_506_3 in pairs(arg_503_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_506_3 then
						iter_506_3.color = arg_503_1.isInRecall_ and (arg_503_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_503_1.var_.actorSpriteComps1094 = nil
			end

			local var_506_2 = 0
			local var_506_3 = 0.875

			if 0 < arg_503_1.time_ and arg_503_1.time_ <= var_506_2 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				arg_503_1.leftNameTxt_.text = arg_503_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_4 = arg_503_1:FormatText(arg_503_1:GetWordFromCfg(424041122).content)

				arg_503_1.text_.text = var_506_4

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_6 = 35 <= 0 and var_506_3 or var_506_3 * (utf8.len(var_506_4) / 35)

				if (35 <= 0 and var_506_3 or var_506_3 * (utf8.len(var_506_4) / 35)) > 0 and var_506_3 < var_506_6 then
					arg_503_1.talkMaxDuration = var_506_6

					if var_506_6 + var_506_2 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_6 + var_506_2
					end
				end

				arg_503_1.text_.text = var_506_4
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_7 = math.max(var_506_3, arg_503_1.talkMaxDuration)

			if var_506_2 <= arg_503_1.time_ and arg_503_1.time_ < var_506_2 + var_506_7 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_2) / var_506_7

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_2 + var_506_7 and arg_503_1.time_ < var_506_2 + var_506_7 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play424041123 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 424041123
		arg_507_1.duration_ = 6.8

		local var_507_0 = {
			zh = 5.933,
			ja = 6.8
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
				arg_507_0:Play424041124(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 and not isNil(arg_507_1.actors_["10153"]) and arg_507_1.var_.actorSpriteComps10153 == nil then
				arg_507_1.var_.actorSpriteComps10153 = arg_507_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_510_0 = 0.2

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_0 and not isNil(arg_507_1.actors_["10153"]) then
				if arg_507_1.var_.actorSpriteComps10153 then
					for iter_510_0, iter_510_1 in pairs(arg_507_1.var_.actorSpriteComps10153:ToTable()) do
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

			if arg_507_1.time_ >= 0 + var_510_0 and arg_507_1.time_ < 0 + var_510_0 + arg_510_0 and not isNil(arg_507_1.actors_["10153"]) and arg_507_1.var_.actorSpriteComps10153 then
				for iter_510_2, iter_510_3 in pairs(arg_507_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_510_3 then
						iter_510_3.color = arg_507_1.isInRecall_ and (arg_507_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_507_1.var_.actorSpriteComps10153 = nil
			end

			local var_510_2 = arg_507_1.actors_["10153"].transform

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= 0 + arg_510_0 then
				arg_507_1.var_.moveOldPos10153 = var_510_2.localPosition
				var_510_2.localScale = Vector3.New(1, 1, 1)

				arg_507_1:CheckSpriteTmpPos("10153", 2)

				for iter_510_4 = 0, var_510_2.childCount - 1 do
					local var_510_3 = var_510_2:GetChild(iter_510_4)

					if var_510_3.name == "" or not string.find(var_510_3.name, "split") then
						var_510_3.gameObject:SetActive(true)
					else
						var_510_3.gameObject:SetActive(false)
					end
				end
			end

			local var_510_4 = 0.001

			if 0 <= arg_507_1.time_ and arg_507_1.time_ < 0 + var_510_4 then
				var_510_2.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_507_1.time_ - 0) / var_510_4)
			end

			if arg_507_1.time_ >= 0 + var_510_4 and arg_507_1.time_ < 0 + var_510_4 + arg_510_0 then
				var_510_2.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_510_5 = 0
			local var_510_6 = 0.85

			if 0 < arg_507_1.time_ and arg_507_1.time_ <= var_510_5 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				arg_507_1.leftNameTxt_.text = arg_507_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_7 = arg_507_1:GetWordFromCfg(424041123)
				local var_510_8 = arg_507_1:FormatText(var_510_7.content)

				arg_507_1.text_.text = var_510_8

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_10 = 34 <= 0 and var_510_6 or var_510_6 * (utf8.len(var_510_8) / 34)

				if (34 <= 0 and var_510_6 or var_510_6 * (utf8.len(var_510_8) / 34)) > 0 and var_510_6 < var_510_10 then
					arg_507_1.talkMaxDuration = var_510_10

					if var_510_10 + var_510_5 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_10 + var_510_5
					end
				end

				arg_507_1.text_.text = var_510_8
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041123", "story_v_out_424041.awb") ~= 0 then
					local var_510_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041123", "story_v_out_424041.awb") / 1000

					if var_510_11 + var_510_5 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_11 + var_510_5
					end

					if var_510_7.prefab_name ~= "" and arg_507_1.actors_[var_510_7.prefab_name] ~= nil then
						local var_510_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_7.prefab_name].transform, "story_v_out_424041", "424041123", "story_v_out_424041.awb")

						arg_507_1:RecordAudio("424041123", var_510_12)
						arg_507_1:RecordAudio("424041123", var_510_12)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_424041", "424041123", "story_v_out_424041.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_424041", "424041123", "story_v_out_424041.awb")
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

		arg_507_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
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
	Play424041124 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 424041124
		arg_511_1.duration_ = 5

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play424041125(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			if 0 < arg_511_1.time_ and arg_511_1.time_ <= 0 + arg_514_0 and not isNil(arg_511_1.actors_["10153"]) and arg_511_1.var_.actorSpriteComps10153 == nil then
				arg_511_1.var_.actorSpriteComps10153 = arg_511_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_514_0 = 0.2

			if 0 <= arg_511_1.time_ and arg_511_1.time_ < 0 + var_514_0 and not isNil(arg_511_1.actors_["10153"]) then
				if arg_511_1.var_.actorSpriteComps10153 then
					for iter_514_0, iter_514_1 in pairs(arg_511_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_514_1 then
							if arg_511_1.isInRecall_ then
								iter_514_1.color = Color.New(Mathf.Lerp(iter_514_1.color.r, arg_511_1.hightColor2.r, (arg_511_1.time_ - 0) / var_514_0), Mathf.Lerp(iter_514_1.color.g, arg_511_1.hightColor2.g, (arg_511_1.time_ - 0) / var_514_0), (Mathf.Lerp(iter_514_1.color.b, arg_511_1.hightColor2.b, (arg_511_1.time_ - 0) / var_514_0)))
							else
								local var_514_1 = Mathf.Lerp(iter_514_1.color.r, 0.5, (arg_511_1.time_ - 0) / var_514_0)

								iter_514_1.color = Color.New(var_514_1, var_514_1, var_514_1)
							end
						end
					end
				end
			end

			if arg_511_1.time_ >= 0 + var_514_0 and arg_511_1.time_ < 0 + var_514_0 + arg_514_0 and not isNil(arg_511_1.actors_["10153"]) and arg_511_1.var_.actorSpriteComps10153 then
				for iter_514_2, iter_514_3 in pairs(arg_511_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_514_3 then
						iter_514_3.color = arg_511_1.isInRecall_ and (arg_511_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_511_1.var_.actorSpriteComps10153 = nil
			end

			local var_514_2 = 0
			local var_514_3 = 1.25

			if 0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_2 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				arg_511_1.leftNameTxt_.text = arg_511_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, true)
				arg_511_1.iconController_:SetSelectedState("hero")

				arg_511_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_511_1.callingController_:SetSelectedState("normal")

				arg_511_1.keyicon_.color = Color.New(1, 1, 1)
				arg_511_1.icon_.color = Color.New(1, 1, 1)

				local var_514_4 = arg_511_1:FormatText(arg_511_1:GetWordFromCfg(424041124).content)

				arg_511_1.text_.text = var_514_4

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_6 = 50 <= 0 and var_514_3 or var_514_3 * (utf8.len(var_514_4) / 50)

				if (50 <= 0 and var_514_3 or var_514_3 * (utf8.len(var_514_4) / 50)) > 0 and var_514_3 < var_514_6 then
					arg_511_1.talkMaxDuration = var_514_6

					if var_514_6 + var_514_2 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_6 + var_514_2
					end
				end

				arg_511_1.text_.text = var_514_4
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)
				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_7 = math.max(var_514_3, arg_511_1.talkMaxDuration)

			if var_514_2 <= arg_511_1.time_ and arg_511_1.time_ < var_514_2 + var_514_7 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_2) / var_514_7

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_2 + var_514_7 and arg_511_1.time_ < var_514_2 + var_514_7 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {}

		arg_511_1:InitPlayNodeList()
	end,
	Play424041125 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 424041125
		arg_515_1.duration_ = 8.73

		local var_515_0 = {
			zh = 6.366,
			ja = 8.733
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
				arg_515_0:Play424041126(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 and not isNil(arg_515_1.actors_["10153"]) and arg_515_1.var_.actorSpriteComps10153 == nil then
				arg_515_1.var_.actorSpriteComps10153 = arg_515_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_518_0 = 0.2

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_0 and not isNil(arg_515_1.actors_["10153"]) then
				if arg_515_1.var_.actorSpriteComps10153 then
					for iter_518_0, iter_518_1 in pairs(arg_515_1.var_.actorSpriteComps10153:ToTable()) do
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

			if arg_515_1.time_ >= 0 + var_518_0 and arg_515_1.time_ < 0 + var_518_0 + arg_518_0 and not isNil(arg_515_1.actors_["10153"]) and arg_515_1.var_.actorSpriteComps10153 then
				for iter_518_2, iter_518_3 in pairs(arg_515_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_518_3 then
						iter_518_3.color = arg_515_1.isInRecall_ and (arg_515_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_515_1.var_.actorSpriteComps10153 = nil
			end

			local var_518_2 = arg_515_1.actors_["10153"].transform

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= 0 + arg_518_0 then
				arg_515_1.var_.moveOldPos10153 = var_518_2.localPosition
				var_518_2.localScale = Vector3.New(1, 1, 1)

				arg_515_1:CheckSpriteTmpPos("10153", 2)

				for iter_518_4 = 0, var_518_2.childCount - 1 do
					local var_518_3 = var_518_2:GetChild(iter_518_4)

					if var_518_3.name == "" or not string.find(var_518_3.name, "split") then
						var_518_3.gameObject:SetActive(true)
					else
						var_518_3.gameObject:SetActive(false)
					end
				end
			end

			local var_518_4 = 0.001

			if 0 <= arg_515_1.time_ and arg_515_1.time_ < 0 + var_518_4 then
				var_518_2.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_515_1.time_ - 0) / var_518_4)
			end

			if arg_515_1.time_ >= 0 + var_518_4 and arg_515_1.time_ < 0 + var_518_4 + arg_518_0 then
				var_518_2.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_518_5 = 0
			local var_518_6 = 0.725

			if 0 < arg_515_1.time_ and arg_515_1.time_ <= var_518_5 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				arg_515_1.leftNameTxt_.text = arg_515_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_7 = arg_515_1:GetWordFromCfg(424041125)
				local var_518_8 = arg_515_1:FormatText(var_518_7.content)

				arg_515_1.text_.text = var_518_8

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_10 = 29 <= 0 and var_518_6 or var_518_6 * (utf8.len(var_518_8) / 29)

				if (29 <= 0 and var_518_6 or var_518_6 * (utf8.len(var_518_8) / 29)) > 0 and var_518_6 < var_518_10 then
					arg_515_1.talkMaxDuration = var_518_10

					if var_518_10 + var_518_5 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_10 + var_518_5
					end
				end

				arg_515_1.text_.text = var_518_8
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041125", "story_v_out_424041.awb") ~= 0 then
					local var_518_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041125", "story_v_out_424041.awb") / 1000

					if var_518_11 + var_518_5 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_11 + var_518_5
					end

					if var_518_7.prefab_name ~= "" and arg_515_1.actors_[var_518_7.prefab_name] ~= nil then
						local var_518_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_7.prefab_name].transform, "story_v_out_424041", "424041125", "story_v_out_424041.awb")

						arg_515_1:RecordAudio("424041125", var_518_12)
						arg_515_1:RecordAudio("424041125", var_518_12)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_424041", "424041125", "story_v_out_424041.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_424041", "424041125", "story_v_out_424041.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_13 = math.max(var_518_6, arg_515_1.talkMaxDuration)

			if var_518_5 <= arg_515_1.time_ and arg_515_1.time_ < var_518_5 + var_518_13 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_5) / var_518_13

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_5 + var_518_13 and arg_515_1.time_ < var_518_5 + var_518_13 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
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
	Play424041126 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 424041126
		arg_519_1.duration_ = 7.5

		local var_519_0 = {
			zh = 4.6,
			ja = 7.5
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
				arg_519_0:Play424041127(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 and not isNil(arg_519_1.actors_["10153"]) and arg_519_1.var_.actorSpriteComps10153 == nil then
				arg_519_1.var_.actorSpriteComps10153 = arg_519_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_522_0 = 0.2

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_0 and not isNil(arg_519_1.actors_["10153"]) then
				if arg_519_1.var_.actorSpriteComps10153 then
					for iter_522_0, iter_522_1 in pairs(arg_519_1.var_.actorSpriteComps10153:ToTable()) do
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

			if arg_519_1.time_ >= 0 + var_522_0 and arg_519_1.time_ < 0 + var_522_0 + arg_522_0 and not isNil(arg_519_1.actors_["10153"]) and arg_519_1.var_.actorSpriteComps10153 then
				for iter_522_2, iter_522_3 in pairs(arg_519_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_522_3 then
						iter_522_3.color = arg_519_1.isInRecall_ and (arg_519_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_519_1.var_.actorSpriteComps10153 = nil
			end

			local var_522_2 = 0
			local var_522_3 = 0.65

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_2 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				arg_519_1.leftNameTxt_.text = arg_519_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, true)
				arg_519_1.iconController_:SetSelectedState("hero")

				arg_519_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_519_1.callingController_:SetSelectedState("normal")

				arg_519_1.keyicon_.color = Color.New(1, 1, 1)
				arg_519_1.icon_.color = Color.New(1, 1, 1)

				local var_522_4 = arg_519_1:GetWordFromCfg(424041126)
				local var_522_5 = arg_519_1:FormatText(var_522_4.content)

				arg_519_1.text_.text = var_522_5

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_7 = 26 <= 0 and var_522_3 or var_522_3 * (utf8.len(var_522_5) / 26)

				if (26 <= 0 and var_522_3 or var_522_3 * (utf8.len(var_522_5) / 26)) > 0 and var_522_3 < var_522_7 then
					arg_519_1.talkMaxDuration = var_522_7

					if var_522_7 + var_522_2 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_7 + var_522_2
					end
				end

				arg_519_1.text_.text = var_522_5
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041126", "story_v_out_424041.awb") ~= 0 then
					local var_522_8 = manager.audio:GetVoiceLength("story_v_out_424041", "424041126", "story_v_out_424041.awb") / 1000

					if var_522_8 + var_522_2 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_8 + var_522_2
					end

					if var_522_4.prefab_name ~= "" and arg_519_1.actors_[var_522_4.prefab_name] ~= nil then
						local var_522_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_4.prefab_name].transform, "story_v_out_424041", "424041126", "story_v_out_424041.awb")

						arg_519_1:RecordAudio("424041126", var_522_9)
						arg_519_1:RecordAudio("424041126", var_522_9)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_424041", "424041126", "story_v_out_424041.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_424041", "424041126", "story_v_out_424041.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_10 = math.max(var_522_3, arg_519_1.talkMaxDuration)

			if var_522_2 <= arg_519_1.time_ and arg_519_1.time_ < var_522_2 + var_522_10 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_2) / var_522_10

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_2 + var_522_10 and arg_519_1.time_ < var_522_2 + var_522_10 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play424041127 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 424041127
		arg_523_1.duration_ = 5.43

		local var_523_0 = {
			zh = 5.066,
			ja = 5.433
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
				arg_523_0:Play424041128(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 and not isNil(arg_523_1.actors_["10153"]) and arg_523_1.var_.actorSpriteComps10153 == nil then
				arg_523_1.var_.actorSpriteComps10153 = arg_523_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_526_0 = 0.2

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_0 and not isNil(arg_523_1.actors_["10153"]) then
				if arg_523_1.var_.actorSpriteComps10153 then
					for iter_526_0, iter_526_1 in pairs(arg_523_1.var_.actorSpriteComps10153:ToTable()) do
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

			if arg_523_1.time_ >= 0 + var_526_0 and arg_523_1.time_ < 0 + var_526_0 + arg_526_0 and not isNil(arg_523_1.actors_["10153"]) and arg_523_1.var_.actorSpriteComps10153 then
				for iter_526_2, iter_526_3 in pairs(arg_523_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_526_3 then
						iter_526_3.color = arg_523_1.isInRecall_ and (arg_523_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_523_1.var_.actorSpriteComps10153 = nil
			end

			local var_526_2 = arg_523_1.actors_["10153"].transform

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.var_.moveOldPos10153 = var_526_2.localPosition
				var_526_2.localScale = Vector3.New(1, 1, 1)

				arg_523_1:CheckSpriteTmpPos("10153", 2)

				for iter_526_4 = 0, var_526_2.childCount - 1 do
					local var_526_3 = var_526_2:GetChild(iter_526_4)

					if var_526_3.name == "" or not string.find(var_526_3.name, "split") then
						var_526_3.gameObject:SetActive(true)
					else
						var_526_3.gameObject:SetActive(false)
					end
				end
			end

			local var_526_4 = 0.001

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_4 then
				var_526_2.localPosition = Vector3.Lerp(arg_523_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_523_1.time_ - 0) / var_526_4)
			end

			if arg_523_1.time_ >= 0 + var_526_4 and arg_523_1.time_ < 0 + var_526_4 + arg_526_0 then
				var_526_2.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_526_5 = 0
			local var_526_6 = 0.675

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_5 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, false)
				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_7 = arg_523_1:GetWordFromCfg(424041127)
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

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041127", "story_v_out_424041.awb") ~= 0 then
					local var_526_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041127", "story_v_out_424041.awb") / 1000

					if var_526_11 + var_526_5 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_11 + var_526_5
					end

					if var_526_7.prefab_name ~= "" and arg_523_1.actors_[var_526_7.prefab_name] ~= nil then
						local var_526_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_7.prefab_name].transform, "story_v_out_424041", "424041127", "story_v_out_424041.awb")

						arg_523_1:RecordAudio("424041127", var_526_12)
						arg_523_1:RecordAudio("424041127", var_526_12)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_424041", "424041127", "story_v_out_424041.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_424041", "424041127", "story_v_out_424041.awb")
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
				actorName = "10153",
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
	Play424041128 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 424041128
		arg_527_1.duration_ = 3.83

		local var_527_0 = {
			zh = 2.533,
			ja = 3.833
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
				arg_527_0:Play424041129(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(arg_527_1.actors_["1094"]) and arg_527_1.var_.actorSpriteComps1094 == nil then
				arg_527_1.var_.actorSpriteComps1094 = arg_527_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_530_0 = 0.2

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_0 and not isNil(arg_527_1.actors_["1094"]) then
				if arg_527_1.var_.actorSpriteComps1094 then
					for iter_530_0, iter_530_1 in pairs(arg_527_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_530_1 then
							if arg_527_1.isInRecall_ then
								iter_530_1.color = Color.New(Mathf.Lerp(iter_530_1.color.r, arg_527_1.hightColor1.r, (arg_527_1.time_ - 0) / var_530_0), Mathf.Lerp(iter_530_1.color.g, arg_527_1.hightColor1.g, (arg_527_1.time_ - 0) / var_530_0), (Mathf.Lerp(iter_530_1.color.b, arg_527_1.hightColor1.b, (arg_527_1.time_ - 0) / var_530_0)))
							else
								local var_530_1 = Mathf.Lerp(iter_530_1.color.r, 1, (arg_527_1.time_ - 0) / var_530_0)

								iter_530_1.color = Color.New(var_530_1, var_530_1, var_530_1)
							end
						end
					end
				end
			end

			if arg_527_1.time_ >= 0 + var_530_0 and arg_527_1.time_ < 0 + var_530_0 + arg_530_0 and not isNil(arg_527_1.actors_["1094"]) and arg_527_1.var_.actorSpriteComps1094 then
				for iter_530_2, iter_530_3 in pairs(arg_527_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_530_3 then
						iter_530_3.color = arg_527_1.isInRecall_ and (arg_527_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_527_1.var_.actorSpriteComps1094 = nil
			end

			local var_530_2 = arg_527_1.actors_["10153"]

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 and not isNil(var_530_2) and arg_527_1.var_.actorSpriteComps10153 == nil then
				arg_527_1.var_.actorSpriteComps10153 = var_530_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_530_3 = 0.2

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_3 and not isNil(var_530_2) then
				if arg_527_1.var_.actorSpriteComps10153 then
					for iter_530_4, iter_530_5 in pairs(arg_527_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_530_5 then
							if arg_527_1.isInRecall_ then
								iter_530_5.color = Color.New(Mathf.Lerp(iter_530_5.color.r, arg_527_1.hightColor2.r, (arg_527_1.time_ - 0) / var_530_3), Mathf.Lerp(iter_530_5.color.g, arg_527_1.hightColor2.g, (arg_527_1.time_ - 0) / var_530_3), (Mathf.Lerp(iter_530_5.color.b, arg_527_1.hightColor2.b, (arg_527_1.time_ - 0) / var_530_3)))
							else
								local var_530_4 = Mathf.Lerp(iter_530_5.color.r, 0.5, (arg_527_1.time_ - 0) / var_530_3)

								iter_530_5.color = Color.New(var_530_4, var_530_4, var_530_4)
							end
						end
					end
				end
			end

			if arg_527_1.time_ >= 0 + var_530_3 and arg_527_1.time_ < 0 + var_530_3 + arg_530_0 and not isNil(var_530_2) and arg_527_1.var_.actorSpriteComps10153 then
				for iter_530_6, iter_530_7 in pairs(arg_527_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_530_7 then
						iter_530_7.color = arg_527_1.isInRecall_ and (arg_527_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_527_1.var_.actorSpriteComps10153 = nil
			end

			local var_530_5 = arg_527_1.actors_["1094"].transform

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.var_.moveOldPos1094 = var_530_5.localPosition
				var_530_5.localScale = Vector3.New(1, 1, 1)

				arg_527_1:CheckSpriteTmpPos("1094", 4)

				for iter_530_8 = 0, var_530_5.childCount - 1 do
					local var_530_6 = var_530_5:GetChild(iter_530_8)

					if var_530_6.name == "" or not string.find(var_530_6.name, "split") then
						var_530_6.gameObject:SetActive(true)
					else
						var_530_6.gameObject:SetActive(false)
					end
				end
			end

			local var_530_7 = 0.001

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_7 then
				var_530_5.localPosition = Vector3.Lerp(arg_527_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_527_1.time_ - 0) / var_530_7)
			end

			if arg_527_1.time_ >= 0 + var_530_7 and arg_527_1.time_ < 0 + var_530_7 + arg_530_0 then
				var_530_5.localPosition = Vector3.New(470, -335, -230)
			end

			local var_530_8 = 0
			local var_530_9 = 0.3

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_8 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_10 = arg_527_1:GetWordFromCfg(424041128)
				local var_530_11 = arg_527_1:FormatText(var_530_10.content)

				arg_527_1.text_.text = var_530_11

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_13 = 12 <= 0 and var_530_9 or var_530_9 * (utf8.len(var_530_11) / 12)

				if (12 <= 0 and var_530_9 or var_530_9 * (utf8.len(var_530_11) / 12)) > 0 and var_530_9 < var_530_13 then
					arg_527_1.talkMaxDuration = var_530_13

					if var_530_13 + var_530_8 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_13 + var_530_8
					end
				end

				arg_527_1.text_.text = var_530_11
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041128", "story_v_out_424041.awb") ~= 0 then
					local var_530_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041128", "story_v_out_424041.awb") / 1000

					if var_530_14 + var_530_8 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_14 + var_530_8
					end

					if var_530_10.prefab_name ~= "" and arg_527_1.actors_[var_530_10.prefab_name] ~= nil then
						local var_530_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_527_1.actors_[var_530_10.prefab_name].transform, "story_v_out_424041", "424041128", "story_v_out_424041.awb")

						arg_527_1:RecordAudio("424041128", var_530_15)
						arg_527_1:RecordAudio("424041128", var_530_15)
					else
						arg_527_1:AudioAction("play", "voice", "story_v_out_424041", "424041128", "story_v_out_424041.awb")
					end

					arg_527_1:RecordHistoryTalkVoice("story_v_out_424041", "424041128", "story_v_out_424041.awb")
				end

				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_16 = math.max(var_530_9, arg_527_1.talkMaxDuration)

			if var_530_8 <= arg_527_1.time_ and arg_527_1.time_ < var_530_8 + var_530_16 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_8) / var_530_16

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_8 + var_530_16 and arg_527_1.time_ < var_530_8 + var_530_16 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {
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

		arg_527_1:InitPlayNodeList()
	end,
	Play424041129 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 424041129
		arg_531_1.duration_ = 2.3

		local var_531_0 = {
			zh = 1.833,
			ja = 2.3
		}
		local var_531_1 = manager.audio:GetLocalizationFlag()

		if var_531_0[var_531_1] ~= nil then
			arg_531_1.duration_ = var_531_0[var_531_1]
		end

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play424041130(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(arg_531_1.actors_["10153"]) and arg_531_1.var_.actorSpriteComps10153 == nil then
				arg_531_1.var_.actorSpriteComps10153 = arg_531_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_534_0 = 0.2

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_0 and not isNil(arg_531_1.actors_["10153"]) then
				if arg_531_1.var_.actorSpriteComps10153 then
					for iter_534_0, iter_534_1 in pairs(arg_531_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_534_1 then
							if arg_531_1.isInRecall_ then
								iter_534_1.color = Color.New(Mathf.Lerp(iter_534_1.color.r, arg_531_1.hightColor1.r, (arg_531_1.time_ - 0) / var_534_0), Mathf.Lerp(iter_534_1.color.g, arg_531_1.hightColor1.g, (arg_531_1.time_ - 0) / var_534_0), (Mathf.Lerp(iter_534_1.color.b, arg_531_1.hightColor1.b, (arg_531_1.time_ - 0) / var_534_0)))
							else
								local var_534_1 = Mathf.Lerp(iter_534_1.color.r, 1, (arg_531_1.time_ - 0) / var_534_0)

								iter_534_1.color = Color.New(var_534_1, var_534_1, var_534_1)
							end
						end
					end
				end
			end

			if arg_531_1.time_ >= 0 + var_534_0 and arg_531_1.time_ < 0 + var_534_0 + arg_534_0 and not isNil(arg_531_1.actors_["10153"]) and arg_531_1.var_.actorSpriteComps10153 then
				for iter_534_2, iter_534_3 in pairs(arg_531_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_534_3 then
						iter_534_3.color = arg_531_1.isInRecall_ and (arg_531_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_531_1.var_.actorSpriteComps10153 = nil
			end

			local var_534_2 = arg_531_1.actors_["1094"]

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 and not isNil(var_534_2) and arg_531_1.var_.actorSpriteComps1094 == nil then
				arg_531_1.var_.actorSpriteComps1094 = var_534_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_534_3 = 0.2

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_3 and not isNil(var_534_2) then
				if arg_531_1.var_.actorSpriteComps1094 then
					for iter_534_4, iter_534_5 in pairs(arg_531_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_534_5 then
							if arg_531_1.isInRecall_ then
								iter_534_5.color = Color.New(Mathf.Lerp(iter_534_5.color.r, arg_531_1.hightColor2.r, (arg_531_1.time_ - 0) / var_534_3), Mathf.Lerp(iter_534_5.color.g, arg_531_1.hightColor2.g, (arg_531_1.time_ - 0) / var_534_3), (Mathf.Lerp(iter_534_5.color.b, arg_531_1.hightColor2.b, (arg_531_1.time_ - 0) / var_534_3)))
							else
								local var_534_4 = Mathf.Lerp(iter_534_5.color.r, 0.5, (arg_531_1.time_ - 0) / var_534_3)

								iter_534_5.color = Color.New(var_534_4, var_534_4, var_534_4)
							end
						end
					end
				end
			end

			if arg_531_1.time_ >= 0 + var_534_3 and arg_531_1.time_ < 0 + var_534_3 + arg_534_0 and not isNil(var_534_2) and arg_531_1.var_.actorSpriteComps1094 then
				for iter_534_6, iter_534_7 in pairs(arg_531_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_534_7 then
						iter_534_7.color = arg_531_1.isInRecall_ and (arg_531_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_531_1.var_.actorSpriteComps1094 = nil
			end

			local var_534_5 = arg_531_1.actors_["10153"].transform

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= 0 + arg_534_0 then
				arg_531_1.var_.moveOldPos10153 = var_534_5.localPosition
				var_534_5.localScale = Vector3.New(1, 1, 1)

				arg_531_1:CheckSpriteTmpPos("10153", 2)

				for iter_534_8 = 0, var_534_5.childCount - 1 do
					local var_534_6 = var_534_5:GetChild(iter_534_8)

					if var_534_6.name == "" or not string.find(var_534_6.name, "split") then
						var_534_6.gameObject:SetActive(true)
					else
						var_534_6.gameObject:SetActive(false)
					end
				end
			end

			local var_534_7 = 0.001

			if 0 <= arg_531_1.time_ and arg_531_1.time_ < 0 + var_534_7 then
				var_534_5.localPosition = Vector3.Lerp(arg_531_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_531_1.time_ - 0) / var_534_7)
			end

			if arg_531_1.time_ >= 0 + var_534_7 and arg_531_1.time_ < 0 + var_534_7 + arg_534_0 then
				var_534_5.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_534_8 = 0
			local var_534_9 = 0.225

			if 0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_8 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				arg_531_1.leftNameTxt_.text = arg_531_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, false)
				arg_531_1.callingController_:SetSelectedState("normal")

				local var_534_10 = arg_531_1:GetWordFromCfg(424041129)
				local var_534_11 = arg_531_1:FormatText(var_534_10.content)

				arg_531_1.text_.text = var_534_11

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_13 = 9 <= 0 and var_534_9 or var_534_9 * (utf8.len(var_534_11) / 9)

				if (9 <= 0 and var_534_9 or var_534_9 * (utf8.len(var_534_11) / 9)) > 0 and var_534_9 < var_534_13 then
					arg_531_1.talkMaxDuration = var_534_13

					if var_534_13 + var_534_8 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_13 + var_534_8
					end
				end

				arg_531_1.text_.text = var_534_11
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041129", "story_v_out_424041.awb") ~= 0 then
					local var_534_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041129", "story_v_out_424041.awb") / 1000

					if var_534_14 + var_534_8 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_14 + var_534_8
					end

					if var_534_10.prefab_name ~= "" and arg_531_1.actors_[var_534_10.prefab_name] ~= nil then
						local var_534_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_531_1.actors_[var_534_10.prefab_name].transform, "story_v_out_424041", "424041129", "story_v_out_424041.awb")

						arg_531_1:RecordAudio("424041129", var_534_15)
						arg_531_1:RecordAudio("424041129", var_534_15)
					else
						arg_531_1:AudioAction("play", "voice", "story_v_out_424041", "424041129", "story_v_out_424041.awb")
					end

					arg_531_1:RecordHistoryTalkVoice("story_v_out_424041", "424041129", "story_v_out_424041.awb")
				end

				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_16 = math.max(var_534_9, arg_531_1.talkMaxDuration)

			if var_534_8 <= arg_531_1.time_ and arg_531_1.time_ < var_534_8 + var_534_16 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_8) / var_534_16

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_8 + var_534_16 and arg_531_1.time_ < var_534_8 + var_534_16 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_531_1:InitPlayNodeList()
	end,
	Play424041130 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 424041130
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play424041131(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			if 0 < arg_535_1.time_ and arg_535_1.time_ <= 0 + arg_538_0 and not isNil(arg_535_1.actors_["10153"]) and arg_535_1.var_.actorSpriteComps10153 == nil then
				arg_535_1.var_.actorSpriteComps10153 = arg_535_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_538_0 = 0.2

			if 0 <= arg_535_1.time_ and arg_535_1.time_ < 0 + var_538_0 and not isNil(arg_535_1.actors_["10153"]) then
				if arg_535_1.var_.actorSpriteComps10153 then
					for iter_538_0, iter_538_1 in pairs(arg_535_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_538_1 then
							if arg_535_1.isInRecall_ then
								iter_538_1.color = Color.New(Mathf.Lerp(iter_538_1.color.r, arg_535_1.hightColor2.r, (arg_535_1.time_ - 0) / var_538_0), Mathf.Lerp(iter_538_1.color.g, arg_535_1.hightColor2.g, (arg_535_1.time_ - 0) / var_538_0), (Mathf.Lerp(iter_538_1.color.b, arg_535_1.hightColor2.b, (arg_535_1.time_ - 0) / var_538_0)))
							else
								local var_538_1 = Mathf.Lerp(iter_538_1.color.r, 0.5, (arg_535_1.time_ - 0) / var_538_0)

								iter_538_1.color = Color.New(var_538_1, var_538_1, var_538_1)
							end
						end
					end
				end
			end

			if arg_535_1.time_ >= 0 + var_538_0 and arg_535_1.time_ < 0 + var_538_0 + arg_538_0 and not isNil(arg_535_1.actors_["10153"]) and arg_535_1.var_.actorSpriteComps10153 then
				for iter_538_2, iter_538_3 in pairs(arg_535_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_538_3 then
						iter_538_3.color = arg_535_1.isInRecall_ and (arg_535_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_535_1.var_.actorSpriteComps10153 = nil
			end

			local var_538_2 = 0
			local var_538_3 = 0.775

			if 0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_2 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				arg_535_1.leftNameTxt_.text = arg_535_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, true)
				arg_535_1.iconController_:SetSelectedState("hero")

				arg_535_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_535_1.callingController_:SetSelectedState("normal")

				arg_535_1.keyicon_.color = Color.New(1, 1, 1)
				arg_535_1.icon_.color = Color.New(1, 1, 1)

				local var_538_4 = arg_535_1:FormatText(arg_535_1:GetWordFromCfg(424041130).content)

				arg_535_1.text_.text = var_538_4

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_6 = 31 <= 0 and var_538_3 or var_538_3 * (utf8.len(var_538_4) / 31)

				if (31 <= 0 and var_538_3 or var_538_3 * (utf8.len(var_538_4) / 31)) > 0 and var_538_3 < var_538_6 then
					arg_535_1.talkMaxDuration = var_538_6

					if var_538_6 + var_538_2 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_6 + var_538_2
					end
				end

				arg_535_1.text_.text = var_538_4
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_7 = math.max(var_538_3, arg_535_1.talkMaxDuration)

			if var_538_2 <= arg_535_1.time_ and arg_535_1.time_ < var_538_2 + var_538_7 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_2) / var_538_7

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_2 + var_538_7 and arg_535_1.time_ < var_538_2 + var_538_7 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play424041131 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 424041131
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play424041132(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 1.05

			if 0 < arg_539_1.time_ and arg_539_1.time_ <= 0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				arg_539_1.leftNameTxt_.text = arg_539_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, true)
				arg_539_1.iconController_:SetSelectedState("hero")

				arg_539_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_539_1.callingController_:SetSelectedState("normal")

				arg_539_1.keyicon_.color = Color.New(1, 1, 1)
				arg_539_1.icon_.color = Color.New(1, 1, 1)

				local var_542_1 = arg_539_1:FormatText(arg_539_1:GetWordFromCfg(424041131).content)

				arg_539_1.text_.text = var_542_1

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_3 = 42 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_1) / 42)

				if (42 <= 0 and var_542_0 or var_542_0 * (utf8.len(var_542_1) / 42)) > 0 and var_542_0 < var_542_3 then
					arg_539_1.talkMaxDuration = var_542_3

					if var_542_3 + 0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_3 + 0
					end
				end

				arg_539_1.text_.text = var_542_1
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_4 = math.max(var_542_0, arg_539_1.talkMaxDuration)

			if 0 <= arg_539_1.time_ and arg_539_1.time_ < 0 + var_542_4 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - 0) / var_542_4

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= 0 + var_542_4 and arg_539_1.time_ < 0 + var_542_4 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play424041132 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 424041132
		arg_543_1.duration_ = 7.17

		local var_543_0 = {
			zh = 6.466,
			ja = 7.166
		}
		local var_543_1 = manager.audio:GetLocalizationFlag()

		if var_543_0[var_543_1] ~= nil then
			arg_543_1.duration_ = var_543_0[var_543_1]
		end

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play424041133(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 and not isNil(arg_543_1.actors_["10153"]) and arg_543_1.var_.actorSpriteComps10153 == nil then
				arg_543_1.var_.actorSpriteComps10153 = arg_543_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_546_0 = 0.2

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_0 and not isNil(arg_543_1.actors_["10153"]) then
				if arg_543_1.var_.actorSpriteComps10153 then
					for iter_546_0, iter_546_1 in pairs(arg_543_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_546_1 then
							if arg_543_1.isInRecall_ then
								iter_546_1.color = Color.New(Mathf.Lerp(iter_546_1.color.r, arg_543_1.hightColor1.r, (arg_543_1.time_ - 0) / var_546_0), Mathf.Lerp(iter_546_1.color.g, arg_543_1.hightColor1.g, (arg_543_1.time_ - 0) / var_546_0), (Mathf.Lerp(iter_546_1.color.b, arg_543_1.hightColor1.b, (arg_543_1.time_ - 0) / var_546_0)))
							else
								local var_546_1 = Mathf.Lerp(iter_546_1.color.r, 1, (arg_543_1.time_ - 0) / var_546_0)

								iter_546_1.color = Color.New(var_546_1, var_546_1, var_546_1)
							end
						end
					end
				end
			end

			if arg_543_1.time_ >= 0 + var_546_0 and arg_543_1.time_ < 0 + var_546_0 + arg_546_0 and not isNil(arg_543_1.actors_["10153"]) and arg_543_1.var_.actorSpriteComps10153 then
				for iter_546_2, iter_546_3 in pairs(arg_543_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_546_3 then
						iter_546_3.color = arg_543_1.isInRecall_ and (arg_543_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_543_1.var_.actorSpriteComps10153 = nil
			end

			local var_546_2 = arg_543_1.actors_["10153"].transform

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= 0 + arg_546_0 then
				arg_543_1.var_.moveOldPos10153 = var_546_2.localPosition
				var_546_2.localScale = Vector3.New(1, 1, 1)

				arg_543_1:CheckSpriteTmpPos("10153", 2)

				for iter_546_4 = 0, var_546_2.childCount - 1 do
					local var_546_3 = var_546_2:GetChild(iter_546_4)

					if var_546_3.name == "" or not string.find(var_546_3.name, "split") then
						var_546_3.gameObject:SetActive(true)
					else
						var_546_3.gameObject:SetActive(false)
					end
				end
			end

			local var_546_4 = 0.001

			if 0 <= arg_543_1.time_ and arg_543_1.time_ < 0 + var_546_4 then
				var_546_2.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos10153, Vector3.New(-400, -395, -330), (arg_543_1.time_ - 0) / var_546_4)
			end

			if arg_543_1.time_ >= 0 + var_546_4 and arg_543_1.time_ < 0 + var_546_4 + arg_546_0 then
				var_546_2.localPosition = Vector3.New(-400, -395, -330)
			end

			local var_546_5 = 0
			local var_546_6 = 0.8

			if 0 < arg_543_1.time_ and arg_543_1.time_ <= var_546_5 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				arg_543_1.leftNameTxt_.text = arg_543_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_7 = arg_543_1:GetWordFromCfg(424041132)
				local var_546_8 = arg_543_1:FormatText(var_546_7.content)

				arg_543_1.text_.text = var_546_8

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_10 = 32 <= 0 and var_546_6 or var_546_6 * (utf8.len(var_546_8) / 32)

				if (32 <= 0 and var_546_6 or var_546_6 * (utf8.len(var_546_8) / 32)) > 0 and var_546_6 < var_546_10 then
					arg_543_1.talkMaxDuration = var_546_10

					if var_546_10 + var_546_5 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_10 + var_546_5
					end
				end

				arg_543_1.text_.text = var_546_8
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041132", "story_v_out_424041.awb") ~= 0 then
					local var_546_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041132", "story_v_out_424041.awb") / 1000

					if var_546_11 + var_546_5 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_11 + var_546_5
					end

					if var_546_7.prefab_name ~= "" and arg_543_1.actors_[var_546_7.prefab_name] ~= nil then
						local var_546_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_7.prefab_name].transform, "story_v_out_424041", "424041132", "story_v_out_424041.awb")

						arg_543_1:RecordAudio("424041132", var_546_12)
						arg_543_1:RecordAudio("424041132", var_546_12)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_out_424041", "424041132", "story_v_out_424041.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_out_424041", "424041132", "story_v_out_424041.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_13 = math.max(var_546_6, arg_543_1.talkMaxDuration)

			if var_546_5 <= arg_543_1.time_ and arg_543_1.time_ < var_546_5 + var_546_13 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_5) / var_546_13

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_5 + var_546_13 and arg_543_1.time_ < var_546_5 + var_546_13 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_543_1:InitPlayNodeList()
	end,
	Play424041133 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 424041133
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play424041134(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			if 0 < arg_547_1.time_ and arg_547_1.time_ <= 0 + arg_550_0 and not isNil(arg_547_1.actors_["10153"]) and arg_547_1.var_.actorSpriteComps10153 == nil then
				arg_547_1.var_.actorSpriteComps10153 = arg_547_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_550_0 = 0.2

			if 0 <= arg_547_1.time_ and arg_547_1.time_ < 0 + var_550_0 and not isNil(arg_547_1.actors_["10153"]) then
				if arg_547_1.var_.actorSpriteComps10153 then
					for iter_550_0, iter_550_1 in pairs(arg_547_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_550_1 then
							if arg_547_1.isInRecall_ then
								iter_550_1.color = Color.New(Mathf.Lerp(iter_550_1.color.r, arg_547_1.hightColor2.r, (arg_547_1.time_ - 0) / var_550_0), Mathf.Lerp(iter_550_1.color.g, arg_547_1.hightColor2.g, (arg_547_1.time_ - 0) / var_550_0), (Mathf.Lerp(iter_550_1.color.b, arg_547_1.hightColor2.b, (arg_547_1.time_ - 0) / var_550_0)))
							else
								local var_550_1 = Mathf.Lerp(iter_550_1.color.r, 0.5, (arg_547_1.time_ - 0) / var_550_0)

								iter_550_1.color = Color.New(var_550_1, var_550_1, var_550_1)
							end
						end
					end
				end
			end

			if arg_547_1.time_ >= 0 + var_550_0 and arg_547_1.time_ < 0 + var_550_0 + arg_550_0 and not isNil(arg_547_1.actors_["10153"]) and arg_547_1.var_.actorSpriteComps10153 then
				for iter_550_2, iter_550_3 in pairs(arg_547_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_550_3 then
						iter_550_3.color = arg_547_1.isInRecall_ and (arg_547_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_547_1.var_.actorSpriteComps10153 = nil
			end

			local var_550_2 = 0
			local var_550_3 = 0.125

			if 0 < arg_547_1.time_ and arg_547_1.time_ <= var_550_2 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				arg_547_1.leftNameTxt_.text = arg_547_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, true)
				arg_547_1.iconController_:SetSelectedState("hero")

				arg_547_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_547_1.callingController_:SetSelectedState("normal")

				arg_547_1.keyicon_.color = Color.New(1, 1, 1)
				arg_547_1.icon_.color = Color.New(1, 1, 1)

				local var_550_4 = arg_547_1:FormatText(arg_547_1:GetWordFromCfg(424041133).content)

				arg_547_1.text_.text = var_550_4

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_6 = 5 <= 0 and var_550_3 or var_550_3 * (utf8.len(var_550_4) / 5)

				if (5 <= 0 and var_550_3 or var_550_3 * (utf8.len(var_550_4) / 5)) > 0 and var_550_3 < var_550_6 then
					arg_547_1.talkMaxDuration = var_550_6

					if var_550_6 + var_550_2 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_6 + var_550_2
					end
				end

				arg_547_1.text_.text = var_550_4
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_7 = math.max(var_550_3, arg_547_1.talkMaxDuration)

			if var_550_2 <= arg_547_1.time_ and arg_547_1.time_ < var_550_2 + var_550_7 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_2) / var_550_7

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_2 + var_550_7 and arg_547_1.time_ < var_550_2 + var_550_7 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play424041134 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 424041134
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play424041135(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0.85

			if 0 < arg_551_1.time_ and arg_551_1.time_ <= 0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, false)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_551_1.iconTrs_.gameObject, false)
				arg_551_1.callingController_:SetSelectedState("normal")

				local var_554_1 = arg_551_1:FormatText(arg_551_1:GetWordFromCfg(424041134).content)

				arg_551_1.text_.text = var_554_1

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_3 = 34 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 34)

				if (34 <= 0 and var_554_0 or var_554_0 * (utf8.len(var_554_1) / 34)) > 0 and var_554_0 < var_554_3 then
					arg_551_1.talkMaxDuration = var_554_3

					if var_554_3 + 0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_3 + 0
					end
				end

				arg_551_1.text_.text = var_554_1
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_4 = math.max(var_554_0, arg_551_1.talkMaxDuration)

			if 0 <= arg_551_1.time_ and arg_551_1.time_ < 0 + var_554_4 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - 0) / var_554_4

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= 0 + var_554_4 and arg_551_1.time_ < 0 + var_554_4 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play424041135 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 424041135
		arg_555_1.duration_ = 3.8

		local var_555_0 = {
			zh = 3.8,
			ja = 3.633
		}
		local var_555_1 = manager.audio:GetLocalizationFlag()

		if var_555_0[var_555_1] ~= nil then
			arg_555_1.duration_ = var_555_0[var_555_1]
		end

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
		end

		function arg_555_1.playNext_(arg_557_0)
			if arg_557_0 == 1 then
				arg_555_0:Play424041136(arg_555_1)
			end
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 and not isNil(arg_555_1.actors_["1094"]) and arg_555_1.var_.actorSpriteComps1094 == nil then
				arg_555_1.var_.actorSpriteComps1094 = arg_555_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_558_0 = 0.2

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_0 and not isNil(arg_555_1.actors_["1094"]) then
				if arg_555_1.var_.actorSpriteComps1094 then
					for iter_558_0, iter_558_1 in pairs(arg_555_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_558_1 then
							if arg_555_1.isInRecall_ then
								iter_558_1.color = Color.New(Mathf.Lerp(iter_558_1.color.r, arg_555_1.hightColor1.r, (arg_555_1.time_ - 0) / var_558_0), Mathf.Lerp(iter_558_1.color.g, arg_555_1.hightColor1.g, (arg_555_1.time_ - 0) / var_558_0), (Mathf.Lerp(iter_558_1.color.b, arg_555_1.hightColor1.b, (arg_555_1.time_ - 0) / var_558_0)))
							else
								local var_558_1 = Mathf.Lerp(iter_558_1.color.r, 1, (arg_555_1.time_ - 0) / var_558_0)

								iter_558_1.color = Color.New(var_558_1, var_558_1, var_558_1)
							end
						end
					end
				end
			end

			if arg_555_1.time_ >= 0 + var_558_0 and arg_555_1.time_ < 0 + var_558_0 + arg_558_0 and not isNil(arg_555_1.actors_["1094"]) and arg_555_1.var_.actorSpriteComps1094 then
				for iter_558_2, iter_558_3 in pairs(arg_555_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_558_3 then
						iter_558_3.color = arg_555_1.isInRecall_ and (arg_555_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_555_1.var_.actorSpriteComps1094 = nil
			end

			local var_558_2 = arg_555_1.actors_["1094"].transform

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= 0 + arg_558_0 then
				arg_555_1.var_.moveOldPos1094 = var_558_2.localPosition
				var_558_2.localScale = Vector3.New(1, 1, 1)

				arg_555_1:CheckSpriteTmpPos("1094", 4)

				for iter_558_4 = 0, var_558_2.childCount - 1 do
					local var_558_3 = var_558_2:GetChild(iter_558_4)

					if var_558_3.name == "" or not string.find(var_558_3.name, "split") then
						var_558_3.gameObject:SetActive(true)
					else
						var_558_3.gameObject:SetActive(false)
					end
				end
			end

			local var_558_4 = 0.001

			if 0 <= arg_555_1.time_ and arg_555_1.time_ < 0 + var_558_4 then
				var_558_2.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_555_1.time_ - 0) / var_558_4)
			end

			if arg_555_1.time_ >= 0 + var_558_4 and arg_555_1.time_ < 0 + var_558_4 + arg_558_0 then
				var_558_2.localPosition = Vector3.New(470, -335, -230)
			end

			local var_558_5 = 0
			local var_558_6 = 0.35

			if 0 < arg_555_1.time_ and arg_555_1.time_ <= var_558_5 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, true)

				arg_555_1.leftNameTxt_.text = arg_555_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_555_1.leftNameTxt_.transform)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1.leftNameTxt_.text)
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_7 = arg_555_1:GetWordFromCfg(424041135)
				local var_558_8 = arg_555_1:FormatText(var_558_7.content)

				arg_555_1.text_.text = var_558_8

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_10 = 14 <= 0 and var_558_6 or var_558_6 * (utf8.len(var_558_8) / 14)

				if (14 <= 0 and var_558_6 or var_558_6 * (utf8.len(var_558_8) / 14)) > 0 and var_558_6 < var_558_10 then
					arg_555_1.talkMaxDuration = var_558_10

					if var_558_10 + var_558_5 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_10 + var_558_5
					end
				end

				arg_555_1.text_.text = var_558_8
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041135", "story_v_out_424041.awb") ~= 0 then
					local var_558_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041135", "story_v_out_424041.awb") / 1000

					if var_558_11 + var_558_5 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_11 + var_558_5
					end

					if var_558_7.prefab_name ~= "" and arg_555_1.actors_[var_558_7.prefab_name] ~= nil then
						local var_558_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_555_1.actors_[var_558_7.prefab_name].transform, "story_v_out_424041", "424041135", "story_v_out_424041.awb")

						arg_555_1:RecordAudio("424041135", var_558_12)
						arg_555_1:RecordAudio("424041135", var_558_12)
					else
						arg_555_1:AudioAction("play", "voice", "story_v_out_424041", "424041135", "story_v_out_424041.awb")
					end

					arg_555_1:RecordHistoryTalkVoice("story_v_out_424041", "424041135", "story_v_out_424041.awb")
				end

				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_13 = math.max(var_558_6, arg_555_1.talkMaxDuration)

			if var_558_5 <= arg_555_1.time_ and arg_555_1.time_ < var_558_5 + var_558_13 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_5) / var_558_13

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_5 + var_558_13 and arg_555_1.time_ < var_558_5 + var_558_13 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {
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

		arg_555_1:InitPlayNodeList()
	end,
	Play424041136 = function(arg_559_0, arg_559_1)
		arg_559_1.time_ = 0
		arg_559_1.frameCnt_ = 0
		arg_559_1.state_ = "playing"
		arg_559_1.curTalkId_ = 424041136
		arg_559_1.duration_ = 5

		SetActive(arg_559_1.tipsGo_, false)

		function arg_559_1.onSingleLineFinish_()
			arg_559_1.onSingleLineUpdate_ = nil
			arg_559_1.onSingleLineFinish_ = nil
			arg_559_1.state_ = "waiting"
		end

		function arg_559_1.playNext_(arg_561_0)
			if arg_561_0 == 1 then
				arg_559_0:Play424041137(arg_559_1)
			end
		end

		function arg_559_1.onSingleLineUpdate_(arg_562_0)
			if 0 < arg_559_1.time_ and arg_559_1.time_ <= 0 + arg_562_0 and not isNil(arg_559_1.actors_["1094"]) and arg_559_1.var_.actorSpriteComps1094 == nil then
				arg_559_1.var_.actorSpriteComps1094 = arg_559_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_562_0 = 0.2

			if 0 <= arg_559_1.time_ and arg_559_1.time_ < 0 + var_562_0 and not isNil(arg_559_1.actors_["1094"]) then
				if arg_559_1.var_.actorSpriteComps1094 then
					for iter_562_0, iter_562_1 in pairs(arg_559_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_562_1 then
							if arg_559_1.isInRecall_ then
								iter_562_1.color = Color.New(Mathf.Lerp(iter_562_1.color.r, arg_559_1.hightColor2.r, (arg_559_1.time_ - 0) / var_562_0), Mathf.Lerp(iter_562_1.color.g, arg_559_1.hightColor2.g, (arg_559_1.time_ - 0) / var_562_0), (Mathf.Lerp(iter_562_1.color.b, arg_559_1.hightColor2.b, (arg_559_1.time_ - 0) / var_562_0)))
							else
								local var_562_1 = Mathf.Lerp(iter_562_1.color.r, 0.5, (arg_559_1.time_ - 0) / var_562_0)

								iter_562_1.color = Color.New(var_562_1, var_562_1, var_562_1)
							end
						end
					end
				end
			end

			if arg_559_1.time_ >= 0 + var_562_0 and arg_559_1.time_ < 0 + var_562_0 + arg_562_0 and not isNil(arg_559_1.actors_["1094"]) and arg_559_1.var_.actorSpriteComps1094 then
				for iter_562_2, iter_562_3 in pairs(arg_559_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_562_3 then
						iter_562_3.color = arg_559_1.isInRecall_ and (arg_559_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_559_1.var_.actorSpriteComps1094 = nil
			end

			local var_562_2 = 0
			local var_562_3 = 0.725

			if 0 < arg_559_1.time_ and arg_559_1.time_ <= var_562_2 + arg_562_0 then
				arg_559_1.talkMaxDuration = 0
				arg_559_1.dialogCg_.alpha = 1

				arg_559_1.dialog_:SetActive(true)
				SetActive(arg_559_1.leftNameGo_, true)

				arg_559_1.leftNameTxt_.text = arg_559_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_559_1.leftNameTxt_.transform)

				arg_559_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_559_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_559_1:RecordName(arg_559_1.leftNameTxt_.text)
				SetActive(arg_559_1.iconTrs_.gameObject, true)
				arg_559_1.iconController_:SetSelectedState("hero")

				arg_559_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_559_1.callingController_:SetSelectedState("normal")

				arg_559_1.keyicon_.color = Color.New(1, 1, 1)
				arg_559_1.icon_.color = Color.New(1, 1, 1)

				local var_562_4 = arg_559_1:FormatText(arg_559_1:GetWordFromCfg(424041136).content)

				arg_559_1.text_.text = var_562_4

				LuaForUtil.ClearLinePrefixSymbol(arg_559_1.text_)

				local var_562_6 = 29 <= 0 and var_562_3 or var_562_3 * (utf8.len(var_562_4) / 29)

				if (29 <= 0 and var_562_3 or var_562_3 * (utf8.len(var_562_4) / 29)) > 0 and var_562_3 < var_562_6 then
					arg_559_1.talkMaxDuration = var_562_6

					if var_562_6 + var_562_2 > arg_559_1.duration_ then
						arg_559_1.duration_ = var_562_6 + var_562_2
					end
				end

				arg_559_1.text_.text = var_562_4
				arg_559_1.typewritter.percent = 0

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(false)
				arg_559_1:RecordContent(arg_559_1.text_.text)
			end

			local var_562_7 = math.max(var_562_3, arg_559_1.talkMaxDuration)

			if var_562_2 <= arg_559_1.time_ and arg_559_1.time_ < var_562_2 + var_562_7 then
				arg_559_1.typewritter.percent = (arg_559_1.time_ - var_562_2) / var_562_7

				arg_559_1.typewritter:SetDirty()
			end

			if arg_559_1.time_ >= var_562_2 + var_562_7 and arg_559_1.time_ < var_562_2 + var_562_7 + arg_562_0 then
				arg_559_1.typewritter.percent = 1

				arg_559_1.typewritter:SetDirty()
				arg_559_1:ShowNextGo(true)
			end
		end

		arg_559_1.nodeConfigList_ = {}

		arg_559_1:InitPlayNodeList()
	end,
	Play424041137 = function(arg_563_0, arg_563_1)
		arg_563_1.time_ = 0
		arg_563_1.frameCnt_ = 0
		arg_563_1.state_ = "playing"
		arg_563_1.curTalkId_ = 424041137
		arg_563_1.duration_ = 4.5

		local var_563_0 = {
			zh = 3.3,
			ja = 4.5
		}
		local var_563_1 = manager.audio:GetLocalizationFlag()

		if var_563_0[var_563_1] ~= nil then
			arg_563_1.duration_ = var_563_0[var_563_1]
		end

		SetActive(arg_563_1.tipsGo_, false)

		function arg_563_1.onSingleLineFinish_()
			arg_563_1.onSingleLineUpdate_ = nil
			arg_563_1.onSingleLineFinish_ = nil
			arg_563_1.state_ = "waiting"
		end

		function arg_563_1.playNext_(arg_565_0)
			if arg_565_0 == 1 then
				arg_563_0:Play424041138(arg_563_1)
			end
		end

		function arg_563_1.onSingleLineUpdate_(arg_566_0)
			local var_566_0 = 0.4

			if 0 < arg_563_1.time_ and arg_563_1.time_ <= 0 + arg_566_0 then
				arg_563_1.talkMaxDuration = 0
				arg_563_1.dialogCg_.alpha = 1

				arg_563_1.dialog_:SetActive(true)
				SetActive(arg_563_1.leftNameGo_, true)

				arg_563_1.leftNameTxt_.text = arg_563_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_563_1.leftNameTxt_.transform)

				arg_563_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_563_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_563_1:RecordName(arg_563_1.leftNameTxt_.text)
				SetActive(arg_563_1.iconTrs_.gameObject, true)
				arg_563_1.iconController_:SetSelectedState("hero")

				arg_563_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_563_1.callingController_:SetSelectedState("normal")

				arg_563_1.keyicon_.color = Color.New(1, 1, 1)
				arg_563_1.icon_.color = Color.New(1, 1, 1)

				local var_566_1 = arg_563_1:GetWordFromCfg(424041137)
				local var_566_2 = arg_563_1:FormatText(var_566_1.content)

				arg_563_1.text_.text = var_566_2

				LuaForUtil.ClearLinePrefixSymbol(arg_563_1.text_)

				local var_566_4 = 16 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_2) / 16)

				if (16 <= 0 and var_566_0 or var_566_0 * (utf8.len(var_566_2) / 16)) > 0 and var_566_0 < var_566_4 then
					arg_563_1.talkMaxDuration = var_566_4

					if var_566_4 + 0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_4 + 0
					end
				end

				arg_563_1.text_.text = var_566_2
				arg_563_1.typewritter.percent = 0

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041137", "story_v_out_424041.awb") ~= 0 then
					local var_566_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041137", "story_v_out_424041.awb") / 1000

					if var_566_5 + 0 > arg_563_1.duration_ then
						arg_563_1.duration_ = var_566_5 + 0
					end

					if var_566_1.prefab_name ~= "" and arg_563_1.actors_[var_566_1.prefab_name] ~= nil then
						local var_566_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_563_1.actors_[var_566_1.prefab_name].transform, "story_v_out_424041", "424041137", "story_v_out_424041.awb")

						arg_563_1:RecordAudio("424041137", var_566_6)
						arg_563_1:RecordAudio("424041137", var_566_6)
					else
						arg_563_1:AudioAction("play", "voice", "story_v_out_424041", "424041137", "story_v_out_424041.awb")
					end

					arg_563_1:RecordHistoryTalkVoice("story_v_out_424041", "424041137", "story_v_out_424041.awb")
				end

				arg_563_1:RecordContent(arg_563_1.text_.text)
			end

			local var_566_7 = math.max(var_566_0, arg_563_1.talkMaxDuration)

			if 0 <= arg_563_1.time_ and arg_563_1.time_ < 0 + var_566_7 then
				arg_563_1.typewritter.percent = (arg_563_1.time_ - 0) / var_566_7

				arg_563_1.typewritter:SetDirty()
			end

			if arg_563_1.time_ >= 0 + var_566_7 and arg_563_1.time_ < 0 + var_566_7 + arg_566_0 then
				arg_563_1.typewritter.percent = 1

				arg_563_1.typewritter:SetDirty()
				arg_563_1:ShowNextGo(true)
			end
		end

		arg_563_1.nodeConfigList_ = {}

		arg_563_1:InitPlayNodeList()
	end,
	Play424041138 = function(arg_567_0, arg_567_1)
		arg_567_1.time_ = 0
		arg_567_1.frameCnt_ = 0
		arg_567_1.state_ = "playing"
		arg_567_1.curTalkId_ = 424041138
		arg_567_1.duration_ = 2.7

		local var_567_0 = {
			zh = 2.466,
			ja = 2.7
		}
		local var_567_1 = manager.audio:GetLocalizationFlag()

		if var_567_0[var_567_1] ~= nil then
			arg_567_1.duration_ = var_567_0[var_567_1]
		end

		SetActive(arg_567_1.tipsGo_, false)

		function arg_567_1.onSingleLineFinish_()
			arg_567_1.onSingleLineUpdate_ = nil
			arg_567_1.onSingleLineFinish_ = nil
			arg_567_1.state_ = "waiting"
		end

		function arg_567_1.playNext_(arg_569_0)
			if arg_569_0 == 1 then
				arg_567_0:Play424041139(arg_567_1)
			end
		end

		function arg_567_1.onSingleLineUpdate_(arg_570_0)
			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 and not isNil(arg_567_1.actors_["1094"]) and arg_567_1.var_.actorSpriteComps1094 == nil then
				arg_567_1.var_.actorSpriteComps1094 = arg_567_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_570_0 = 0.2

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_0 and not isNil(arg_567_1.actors_["1094"]) then
				if arg_567_1.var_.actorSpriteComps1094 then
					for iter_570_0, iter_570_1 in pairs(arg_567_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_570_1 then
							if arg_567_1.isInRecall_ then
								iter_570_1.color = Color.New(Mathf.Lerp(iter_570_1.color.r, arg_567_1.hightColor1.r, (arg_567_1.time_ - 0) / var_570_0), Mathf.Lerp(iter_570_1.color.g, arg_567_1.hightColor1.g, (arg_567_1.time_ - 0) / var_570_0), (Mathf.Lerp(iter_570_1.color.b, arg_567_1.hightColor1.b, (arg_567_1.time_ - 0) / var_570_0)))
							else
								local var_570_1 = Mathf.Lerp(iter_570_1.color.r, 1, (arg_567_1.time_ - 0) / var_570_0)

								iter_570_1.color = Color.New(var_570_1, var_570_1, var_570_1)
							end
						end
					end
				end
			end

			if arg_567_1.time_ >= 0 + var_570_0 and arg_567_1.time_ < 0 + var_570_0 + arg_570_0 and not isNil(arg_567_1.actors_["1094"]) and arg_567_1.var_.actorSpriteComps1094 then
				for iter_570_2, iter_570_3 in pairs(arg_567_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_570_3 then
						iter_570_3.color = arg_567_1.isInRecall_ and (arg_567_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_567_1.var_.actorSpriteComps1094 = nil
			end

			local var_570_2 = arg_567_1.actors_["1094"].transform

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= 0 + arg_570_0 then
				arg_567_1.var_.moveOldPos1094 = var_570_2.localPosition
				var_570_2.localScale = Vector3.New(1, 1, 1)

				arg_567_1:CheckSpriteTmpPos("1094", 4)

				for iter_570_4 = 0, var_570_2.childCount - 1 do
					local var_570_3 = var_570_2:GetChild(iter_570_4)

					if var_570_3.name == "split_3" then
						var_570_3:SetAsLastSibling()
						var_570_3.gameObject:SetActive(true)

						arg_567_1.var_.actorSpriteSplit1094 = var_570_3.gameObject:GetComponent(typeof(Image))

						arg_567_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_570_4 = 0.5

			if 0 <= arg_567_1.time_ and arg_567_1.time_ < 0 + var_570_4 then
				var_570_2.localPosition = Vector3.Lerp(arg_567_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_567_1.time_ - 0) / var_570_4)

				if arg_567_1.var_.actorSpriteSplit1094 ~= nil then
					arg_567_1.var_.actorSpriteSplit1094:SetAlpha((arg_567_1.time_ - 0) / var_570_4)
				end
			end

			if arg_567_1.time_ >= 0 + var_570_4 and arg_567_1.time_ < 0 + var_570_4 + arg_570_0 then
				var_570_2.localPosition = Vector3.New(470, -335, -230)

				if arg_567_1.var_.actorSpriteSplit1094 ~= nil then
					arg_567_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_570_5 = 0
			local var_570_6 = 0.15

			if 0 < arg_567_1.time_ and arg_567_1.time_ <= var_570_5 + arg_570_0 then
				arg_567_1.talkMaxDuration = 0
				arg_567_1.dialogCg_.alpha = 1

				arg_567_1.dialog_:SetActive(true)
				SetActive(arg_567_1.leftNameGo_, true)

				arg_567_1.leftNameTxt_.text = arg_567_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_567_1.leftNameTxt_.transform)

				arg_567_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_567_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_567_1:RecordName(arg_567_1.leftNameTxt_.text)
				SetActive(arg_567_1.iconTrs_.gameObject, false)
				arg_567_1.callingController_:SetSelectedState("normal")

				local var_570_7 = arg_567_1:GetWordFromCfg(424041138)
				local var_570_8 = arg_567_1:FormatText(var_570_7.content)

				arg_567_1.text_.text = var_570_8

				LuaForUtil.ClearLinePrefixSymbol(arg_567_1.text_)

				local var_570_10 = 6 <= 0 and var_570_6 or var_570_6 * (utf8.len(var_570_8) / 6)

				if (6 <= 0 and var_570_6 or var_570_6 * (utf8.len(var_570_8) / 6)) > 0 and var_570_6 < var_570_10 then
					arg_567_1.talkMaxDuration = var_570_10

					if var_570_10 + var_570_5 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_10 + var_570_5
					end
				end

				arg_567_1.text_.text = var_570_8
				arg_567_1.typewritter.percent = 0

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041138", "story_v_out_424041.awb") ~= 0 then
					local var_570_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041138", "story_v_out_424041.awb") / 1000

					if var_570_11 + var_570_5 > arg_567_1.duration_ then
						arg_567_1.duration_ = var_570_11 + var_570_5
					end

					if var_570_7.prefab_name ~= "" and arg_567_1.actors_[var_570_7.prefab_name] ~= nil then
						local var_570_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_567_1.actors_[var_570_7.prefab_name].transform, "story_v_out_424041", "424041138", "story_v_out_424041.awb")

						arg_567_1:RecordAudio("424041138", var_570_12)
						arg_567_1:RecordAudio("424041138", var_570_12)
					else
						arg_567_1:AudioAction("play", "voice", "story_v_out_424041", "424041138", "story_v_out_424041.awb")
					end

					arg_567_1:RecordHistoryTalkVoice("story_v_out_424041", "424041138", "story_v_out_424041.awb")
				end

				arg_567_1:RecordContent(arg_567_1.text_.text)
			end

			local var_570_13 = math.max(var_570_6, arg_567_1.talkMaxDuration)

			if var_570_5 <= arg_567_1.time_ and arg_567_1.time_ < var_570_5 + var_570_13 then
				arg_567_1.typewritter.percent = (arg_567_1.time_ - var_570_5) / var_570_13

				arg_567_1.typewritter:SetDirty()
			end

			if arg_567_1.time_ >= var_570_5 + var_570_13 and arg_567_1.time_ < var_570_5 + var_570_13 + arg_570_0 then
				arg_567_1.typewritter.percent = 1

				arg_567_1.typewritter:SetDirty()
				arg_567_1:ShowNextGo(true)
			end
		end

		arg_567_1.nodeConfigList_ = {
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

		arg_567_1:InitPlayNodeList()
	end,
	Play424041139 = function(arg_571_0, arg_571_1)
		arg_571_1.time_ = 0
		arg_571_1.frameCnt_ = 0
		arg_571_1.state_ = "playing"
		arg_571_1.curTalkId_ = 424041139
		arg_571_1.duration_ = 5

		SetActive(arg_571_1.tipsGo_, false)

		function arg_571_1.onSingleLineFinish_()
			arg_571_1.onSingleLineUpdate_ = nil
			arg_571_1.onSingleLineFinish_ = nil
			arg_571_1.state_ = "waiting"
		end

		function arg_571_1.playNext_(arg_573_0)
			if arg_573_0 == 1 then
				arg_571_0:Play424041140(arg_571_1)
			end
		end

		function arg_571_1.onSingleLineUpdate_(arg_574_0)
			if 0 < arg_571_1.time_ and arg_571_1.time_ <= 0 + arg_574_0 and not isNil(arg_571_1.actors_["1094"]) and arg_571_1.var_.actorSpriteComps1094 == nil then
				arg_571_1.var_.actorSpriteComps1094 = arg_571_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_574_0 = 0.2

			if 0 <= arg_571_1.time_ and arg_571_1.time_ < 0 + var_574_0 and not isNil(arg_571_1.actors_["1094"]) then
				if arg_571_1.var_.actorSpriteComps1094 then
					for iter_574_0, iter_574_1 in pairs(arg_571_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_574_1 then
							if arg_571_1.isInRecall_ then
								iter_574_1.color = Color.New(Mathf.Lerp(iter_574_1.color.r, arg_571_1.hightColor2.r, (arg_571_1.time_ - 0) / var_574_0), Mathf.Lerp(iter_574_1.color.g, arg_571_1.hightColor2.g, (arg_571_1.time_ - 0) / var_574_0), (Mathf.Lerp(iter_574_1.color.b, arg_571_1.hightColor2.b, (arg_571_1.time_ - 0) / var_574_0)))
							else
								local var_574_1 = Mathf.Lerp(iter_574_1.color.r, 0.5, (arg_571_1.time_ - 0) / var_574_0)

								iter_574_1.color = Color.New(var_574_1, var_574_1, var_574_1)
							end
						end
					end
				end
			end

			if arg_571_1.time_ >= 0 + var_574_0 and arg_571_1.time_ < 0 + var_574_0 + arg_574_0 and not isNil(arg_571_1.actors_["1094"]) and arg_571_1.var_.actorSpriteComps1094 then
				for iter_574_2, iter_574_3 in pairs(arg_571_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_574_3 then
						iter_574_3.color = arg_571_1.isInRecall_ and (arg_571_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_571_1.var_.actorSpriteComps1094 = nil
			end

			local var_574_2 = 0
			local var_574_3 = 0.975

			if 0 < arg_571_1.time_ and arg_571_1.time_ <= var_574_2 + arg_574_0 then
				arg_571_1.talkMaxDuration = 0
				arg_571_1.dialogCg_.alpha = 1

				arg_571_1.dialog_:SetActive(true)
				SetActive(arg_571_1.leftNameGo_, true)

				arg_571_1.leftNameTxt_.text = arg_571_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_571_1.leftNameTxt_.transform)

				arg_571_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_571_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_571_1:RecordName(arg_571_1.leftNameTxt_.text)
				SetActive(arg_571_1.iconTrs_.gameObject, true)
				arg_571_1.iconController_:SetSelectedState("hero")

				arg_571_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_571_1.callingController_:SetSelectedState("normal")

				arg_571_1.keyicon_.color = Color.New(1, 1, 1)
				arg_571_1.icon_.color = Color.New(1, 1, 1)

				local var_574_4 = arg_571_1:FormatText(arg_571_1:GetWordFromCfg(424041139).content)

				arg_571_1.text_.text = var_574_4

				LuaForUtil.ClearLinePrefixSymbol(arg_571_1.text_)

				local var_574_6 = 39 <= 0 and var_574_3 or var_574_3 * (utf8.len(var_574_4) / 39)

				if (39 <= 0 and var_574_3 or var_574_3 * (utf8.len(var_574_4) / 39)) > 0 and var_574_3 < var_574_6 then
					arg_571_1.talkMaxDuration = var_574_6

					if var_574_6 + var_574_2 > arg_571_1.duration_ then
						arg_571_1.duration_ = var_574_6 + var_574_2
					end
				end

				arg_571_1.text_.text = var_574_4
				arg_571_1.typewritter.percent = 0

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(false)
				arg_571_1:RecordContent(arg_571_1.text_.text)
			end

			local var_574_7 = math.max(var_574_3, arg_571_1.talkMaxDuration)

			if var_574_2 <= arg_571_1.time_ and arg_571_1.time_ < var_574_2 + var_574_7 then
				arg_571_1.typewritter.percent = (arg_571_1.time_ - var_574_2) / var_574_7

				arg_571_1.typewritter:SetDirty()
			end

			if arg_571_1.time_ >= var_574_2 + var_574_7 and arg_571_1.time_ < var_574_2 + var_574_7 + arg_574_0 then
				arg_571_1.typewritter.percent = 1

				arg_571_1.typewritter:SetDirty()
				arg_571_1:ShowNextGo(true)
			end
		end

		arg_571_1.nodeConfigList_ = {}

		arg_571_1:InitPlayNodeList()
	end,
	Play424041140 = function(arg_575_0, arg_575_1)
		arg_575_1.time_ = 0
		arg_575_1.frameCnt_ = 0
		arg_575_1.state_ = "playing"
		arg_575_1.curTalkId_ = 424041140
		arg_575_1.duration_ = 1.27

		local var_575_0 = {
			zh = 1.1,
			ja = 1.266
		}
		local var_575_1 = manager.audio:GetLocalizationFlag()

		if var_575_0[var_575_1] ~= nil then
			arg_575_1.duration_ = var_575_0[var_575_1]
		end

		SetActive(arg_575_1.tipsGo_, false)

		function arg_575_1.onSingleLineFinish_()
			arg_575_1.onSingleLineUpdate_ = nil
			arg_575_1.onSingleLineFinish_ = nil
			arg_575_1.state_ = "waiting"
		end

		function arg_575_1.playNext_(arg_577_0)
			if arg_577_0 == 1 then
				arg_575_0:Play424041141(arg_575_1)
			end
		end

		function arg_575_1.onSingleLineUpdate_(arg_578_0)
			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 and not isNil(arg_575_1.actors_["1094"]) and arg_575_1.var_.actorSpriteComps1094 == nil then
				arg_575_1.var_.actorSpriteComps1094 = arg_575_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_578_0 = 0.2

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_0 and not isNil(arg_575_1.actors_["1094"]) then
				if arg_575_1.var_.actorSpriteComps1094 then
					for iter_578_0, iter_578_1 in pairs(arg_575_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_578_1 then
							if arg_575_1.isInRecall_ then
								iter_578_1.color = Color.New(Mathf.Lerp(iter_578_1.color.r, arg_575_1.hightColor1.r, (arg_575_1.time_ - 0) / var_578_0), Mathf.Lerp(iter_578_1.color.g, arg_575_1.hightColor1.g, (arg_575_1.time_ - 0) / var_578_0), (Mathf.Lerp(iter_578_1.color.b, arg_575_1.hightColor1.b, (arg_575_1.time_ - 0) / var_578_0)))
							else
								local var_578_1 = Mathf.Lerp(iter_578_1.color.r, 1, (arg_575_1.time_ - 0) / var_578_0)

								iter_578_1.color = Color.New(var_578_1, var_578_1, var_578_1)
							end
						end
					end
				end
			end

			if arg_575_1.time_ >= 0 + var_578_0 and arg_575_1.time_ < 0 + var_578_0 + arg_578_0 and not isNil(arg_575_1.actors_["1094"]) and arg_575_1.var_.actorSpriteComps1094 then
				for iter_578_2, iter_578_3 in pairs(arg_575_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_578_3 then
						iter_578_3.color = arg_575_1.isInRecall_ and (arg_575_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_575_1.var_.actorSpriteComps1094 = nil
			end

			local var_578_2 = arg_575_1.actors_["1094"].transform

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= 0 + arg_578_0 then
				arg_575_1.var_.moveOldPos1094 = var_578_2.localPosition
				var_578_2.localScale = Vector3.New(1, 1, 1)

				arg_575_1:CheckSpriteTmpPos("1094", 4)

				for iter_578_4 = 0, var_578_2.childCount - 1 do
					local var_578_3 = var_578_2:GetChild(iter_578_4)

					if var_578_3.name == "split_1" then
						var_578_3:SetAsLastSibling()
						var_578_3.gameObject:SetActive(true)

						arg_575_1.var_.actorSpriteSplit1094 = var_578_3.gameObject:GetComponent(typeof(Image))

						arg_575_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_578_4 = 0.5

			if 0 <= arg_575_1.time_ and arg_575_1.time_ < 0 + var_578_4 then
				var_578_2.localPosition = Vector3.Lerp(arg_575_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_575_1.time_ - 0) / var_578_4)

				if arg_575_1.var_.actorSpriteSplit1094 ~= nil then
					arg_575_1.var_.actorSpriteSplit1094:SetAlpha((arg_575_1.time_ - 0) / var_578_4)
				end
			end

			if arg_575_1.time_ >= 0 + var_578_4 and arg_575_1.time_ < 0 + var_578_4 + arg_578_0 then
				var_578_2.localPosition = Vector3.New(470, -335, -230)

				if arg_575_1.var_.actorSpriteSplit1094 ~= nil then
					arg_575_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_578_5 = 0
			local var_578_6 = 0.075

			if 0 < arg_575_1.time_ and arg_575_1.time_ <= var_578_5 + arg_578_0 then
				arg_575_1.talkMaxDuration = 0
				arg_575_1.dialogCg_.alpha = 1

				arg_575_1.dialog_:SetActive(true)
				SetActive(arg_575_1.leftNameGo_, true)

				arg_575_1.leftNameTxt_.text = arg_575_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_575_1.leftNameTxt_.transform)

				arg_575_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_575_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_575_1:RecordName(arg_575_1.leftNameTxt_.text)
				SetActive(arg_575_1.iconTrs_.gameObject, false)
				arg_575_1.callingController_:SetSelectedState("normal")

				local var_578_7 = arg_575_1:GetWordFromCfg(424041140)
				local var_578_8 = arg_575_1:FormatText(var_578_7.content)

				arg_575_1.text_.text = var_578_8

				LuaForUtil.ClearLinePrefixSymbol(arg_575_1.text_)

				local var_578_10 = 3 <= 0 and var_578_6 or var_578_6 * (utf8.len(var_578_8) / 3)

				if (3 <= 0 and var_578_6 or var_578_6 * (utf8.len(var_578_8) / 3)) > 0 and var_578_6 < var_578_10 then
					arg_575_1.talkMaxDuration = var_578_10

					if var_578_10 + var_578_5 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_10 + var_578_5
					end
				end

				arg_575_1.text_.text = var_578_8
				arg_575_1.typewritter.percent = 0

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041140", "story_v_out_424041.awb") ~= 0 then
					local var_578_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041140", "story_v_out_424041.awb") / 1000

					if var_578_11 + var_578_5 > arg_575_1.duration_ then
						arg_575_1.duration_ = var_578_11 + var_578_5
					end

					if var_578_7.prefab_name ~= "" and arg_575_1.actors_[var_578_7.prefab_name] ~= nil then
						local var_578_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_575_1.actors_[var_578_7.prefab_name].transform, "story_v_out_424041", "424041140", "story_v_out_424041.awb")

						arg_575_1:RecordAudio("424041140", var_578_12)
						arg_575_1:RecordAudio("424041140", var_578_12)
					else
						arg_575_1:AudioAction("play", "voice", "story_v_out_424041", "424041140", "story_v_out_424041.awb")
					end

					arg_575_1:RecordHistoryTalkVoice("story_v_out_424041", "424041140", "story_v_out_424041.awb")
				end

				arg_575_1:RecordContent(arg_575_1.text_.text)
			end

			local var_578_13 = math.max(var_578_6, arg_575_1.talkMaxDuration)

			if var_578_5 <= arg_575_1.time_ and arg_575_1.time_ < var_578_5 + var_578_13 then
				arg_575_1.typewritter.percent = (arg_575_1.time_ - var_578_5) / var_578_13

				arg_575_1.typewritter:SetDirty()
			end

			if arg_575_1.time_ >= var_578_5 + var_578_13 and arg_575_1.time_ < var_578_5 + var_578_13 + arg_578_0 then
				arg_575_1.typewritter.percent = 1

				arg_575_1.typewritter:SetDirty()
				arg_575_1:ShowNextGo(true)
			end
		end

		arg_575_1.nodeConfigList_ = {
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

		arg_575_1:InitPlayNodeList()
	end,
	Play424041141 = function(arg_579_0, arg_579_1)
		arg_579_1.time_ = 0
		arg_579_1.frameCnt_ = 0
		arg_579_1.state_ = "playing"
		arg_579_1.curTalkId_ = 424041141
		arg_579_1.duration_ = 5

		SetActive(arg_579_1.tipsGo_, false)

		function arg_579_1.onSingleLineFinish_()
			arg_579_1.onSingleLineUpdate_ = nil
			arg_579_1.onSingleLineFinish_ = nil
			arg_579_1.state_ = "waiting"
		end

		function arg_579_1.playNext_(arg_581_0)
			if arg_581_0 == 1 then
				arg_579_0:Play424041142(arg_579_1)
			end
		end

		function arg_579_1.onSingleLineUpdate_(arg_582_0)
			if 0 < arg_579_1.time_ and arg_579_1.time_ <= 0 + arg_582_0 and not isNil(arg_579_1.actors_["1094"]) and arg_579_1.var_.actorSpriteComps1094 == nil then
				arg_579_1.var_.actorSpriteComps1094 = arg_579_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_582_0 = 0.2

			if 0 <= arg_579_1.time_ and arg_579_1.time_ < 0 + var_582_0 and not isNil(arg_579_1.actors_["1094"]) then
				if arg_579_1.var_.actorSpriteComps1094 then
					for iter_582_0, iter_582_1 in pairs(arg_579_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_582_1 then
							if arg_579_1.isInRecall_ then
								iter_582_1.color = Color.New(Mathf.Lerp(iter_582_1.color.r, arg_579_1.hightColor2.r, (arg_579_1.time_ - 0) / var_582_0), Mathf.Lerp(iter_582_1.color.g, arg_579_1.hightColor2.g, (arg_579_1.time_ - 0) / var_582_0), (Mathf.Lerp(iter_582_1.color.b, arg_579_1.hightColor2.b, (arg_579_1.time_ - 0) / var_582_0)))
							else
								local var_582_1 = Mathf.Lerp(iter_582_1.color.r, 0.5, (arg_579_1.time_ - 0) / var_582_0)

								iter_582_1.color = Color.New(var_582_1, var_582_1, var_582_1)
							end
						end
					end
				end
			end

			if arg_579_1.time_ >= 0 + var_582_0 and arg_579_1.time_ < 0 + var_582_0 + arg_582_0 and not isNil(arg_579_1.actors_["1094"]) and arg_579_1.var_.actorSpriteComps1094 then
				for iter_582_2, iter_582_3 in pairs(arg_579_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_582_3 then
						iter_582_3.color = arg_579_1.isInRecall_ and (arg_579_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_579_1.var_.actorSpriteComps1094 = nil
			end

			local var_582_2 = 0
			local var_582_3 = 0.375

			if 0 < arg_579_1.time_ and arg_579_1.time_ <= var_582_2 + arg_582_0 then
				arg_579_1.talkMaxDuration = 0
				arg_579_1.dialogCg_.alpha = 1

				arg_579_1.dialog_:SetActive(true)
				SetActive(arg_579_1.leftNameGo_, true)

				arg_579_1.leftNameTxt_.text = arg_579_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_579_1.leftNameTxt_.transform)

				arg_579_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_579_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_579_1:RecordName(arg_579_1.leftNameTxt_.text)
				SetActive(arg_579_1.iconTrs_.gameObject, true)
				arg_579_1.iconController_:SetSelectedState("hero")

				arg_579_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_579_1.callingController_:SetSelectedState("normal")

				arg_579_1.keyicon_.color = Color.New(1, 1, 1)
				arg_579_1.icon_.color = Color.New(1, 1, 1)

				local var_582_4 = arg_579_1:FormatText(arg_579_1:GetWordFromCfg(424041141).content)

				arg_579_1.text_.text = var_582_4

				LuaForUtil.ClearLinePrefixSymbol(arg_579_1.text_)

				local var_582_6 = 15 <= 0 and var_582_3 or var_582_3 * (utf8.len(var_582_4) / 15)

				if (15 <= 0 and var_582_3 or var_582_3 * (utf8.len(var_582_4) / 15)) > 0 and var_582_3 < var_582_6 then
					arg_579_1.talkMaxDuration = var_582_6

					if var_582_6 + var_582_2 > arg_579_1.duration_ then
						arg_579_1.duration_ = var_582_6 + var_582_2
					end
				end

				arg_579_1.text_.text = var_582_4
				arg_579_1.typewritter.percent = 0

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(false)
				arg_579_1:RecordContent(arg_579_1.text_.text)
			end

			local var_582_7 = math.max(var_582_3, arg_579_1.talkMaxDuration)

			if var_582_2 <= arg_579_1.time_ and arg_579_1.time_ < var_582_2 + var_582_7 then
				arg_579_1.typewritter.percent = (arg_579_1.time_ - var_582_2) / var_582_7

				arg_579_1.typewritter:SetDirty()
			end

			if arg_579_1.time_ >= var_582_2 + var_582_7 and arg_579_1.time_ < var_582_2 + var_582_7 + arg_582_0 then
				arg_579_1.typewritter.percent = 1

				arg_579_1.typewritter:SetDirty()
				arg_579_1:ShowNextGo(true)
			end
		end

		arg_579_1.nodeConfigList_ = {}

		arg_579_1:InitPlayNodeList()
	end,
	Play424041142 = function(arg_583_0, arg_583_1)
		arg_583_1.time_ = 0
		arg_583_1.frameCnt_ = 0
		arg_583_1.state_ = "playing"
		arg_583_1.curTalkId_ = 424041142
		arg_583_1.duration_ = 6.43

		local var_583_0 = {
			zh = 6.433,
			ja = 5.7
		}
		local var_583_1 = manager.audio:GetLocalizationFlag()

		if var_583_0[var_583_1] ~= nil then
			arg_583_1.duration_ = var_583_0[var_583_1]
		end

		SetActive(arg_583_1.tipsGo_, false)

		function arg_583_1.onSingleLineFinish_()
			arg_583_1.onSingleLineUpdate_ = nil
			arg_583_1.onSingleLineFinish_ = nil
			arg_583_1.state_ = "waiting"
		end

		function arg_583_1.playNext_(arg_585_0)
			if arg_585_0 == 1 then
				arg_583_0:Play424041143(arg_583_1)
			end
		end

		function arg_583_1.onSingleLineUpdate_(arg_586_0)
			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 and not isNil(arg_583_1.actors_["1094"]) and arg_583_1.var_.actorSpriteComps1094 == nil then
				arg_583_1.var_.actorSpriteComps1094 = arg_583_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_586_0 = 0.2

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_0 and not isNil(arg_583_1.actors_["1094"]) then
				if arg_583_1.var_.actorSpriteComps1094 then
					for iter_586_0, iter_586_1 in pairs(arg_583_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_586_1 then
							if arg_583_1.isInRecall_ then
								iter_586_1.color = Color.New(Mathf.Lerp(iter_586_1.color.r, arg_583_1.hightColor1.r, (arg_583_1.time_ - 0) / var_586_0), Mathf.Lerp(iter_586_1.color.g, arg_583_1.hightColor1.g, (arg_583_1.time_ - 0) / var_586_0), (Mathf.Lerp(iter_586_1.color.b, arg_583_1.hightColor1.b, (arg_583_1.time_ - 0) / var_586_0)))
							else
								local var_586_1 = Mathf.Lerp(iter_586_1.color.r, 1, (arg_583_1.time_ - 0) / var_586_0)

								iter_586_1.color = Color.New(var_586_1, var_586_1, var_586_1)
							end
						end
					end
				end
			end

			if arg_583_1.time_ >= 0 + var_586_0 and arg_583_1.time_ < 0 + var_586_0 + arg_586_0 and not isNil(arg_583_1.actors_["1094"]) and arg_583_1.var_.actorSpriteComps1094 then
				for iter_586_2, iter_586_3 in pairs(arg_583_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_586_3 then
						iter_586_3.color = arg_583_1.isInRecall_ and (arg_583_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_583_1.var_.actorSpriteComps1094 = nil
			end

			local var_586_2 = arg_583_1.actors_["1094"].transform

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= 0 + arg_586_0 then
				arg_583_1.var_.moveOldPos1094 = var_586_2.localPosition
				var_586_2.localScale = Vector3.New(1, 1, 1)

				arg_583_1:CheckSpriteTmpPos("1094", 4)

				for iter_586_4 = 0, var_586_2.childCount - 1 do
					local var_586_3 = var_586_2:GetChild(iter_586_4)

					if var_586_3.name == "" or not string.find(var_586_3.name, "split") then
						var_586_3.gameObject:SetActive(true)
					else
						var_586_3.gameObject:SetActive(false)
					end
				end
			end

			local var_586_4 = 0.001

			if 0 <= arg_583_1.time_ and arg_583_1.time_ < 0 + var_586_4 then
				var_586_2.localPosition = Vector3.Lerp(arg_583_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_583_1.time_ - 0) / var_586_4)
			end

			if arg_583_1.time_ >= 0 + var_586_4 and arg_583_1.time_ < 0 + var_586_4 + arg_586_0 then
				var_586_2.localPosition = Vector3.New(470, -335, -230)
			end

			local var_586_5 = 0
			local var_586_6 = 0.55

			if 0 < arg_583_1.time_ and arg_583_1.time_ <= var_586_5 + arg_586_0 then
				arg_583_1.talkMaxDuration = 0
				arg_583_1.dialogCg_.alpha = 1

				arg_583_1.dialog_:SetActive(true)
				SetActive(arg_583_1.leftNameGo_, true)

				arg_583_1.leftNameTxt_.text = arg_583_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_583_1.leftNameTxt_.transform)

				arg_583_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_583_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_583_1:RecordName(arg_583_1.leftNameTxt_.text)
				SetActive(arg_583_1.iconTrs_.gameObject, false)
				arg_583_1.callingController_:SetSelectedState("normal")

				local var_586_7 = arg_583_1:GetWordFromCfg(424041142)
				local var_586_8 = arg_583_1:FormatText(var_586_7.content)

				arg_583_1.text_.text = var_586_8

				LuaForUtil.ClearLinePrefixSymbol(arg_583_1.text_)

				local var_586_10 = 22 <= 0 and var_586_6 or var_586_6 * (utf8.len(var_586_8) / 22)

				if (22 <= 0 and var_586_6 or var_586_6 * (utf8.len(var_586_8) / 22)) > 0 and var_586_6 < var_586_10 then
					arg_583_1.talkMaxDuration = var_586_10

					if var_586_10 + var_586_5 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_10 + var_586_5
					end
				end

				arg_583_1.text_.text = var_586_8
				arg_583_1.typewritter.percent = 0

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041142", "story_v_out_424041.awb") ~= 0 then
					local var_586_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041142", "story_v_out_424041.awb") / 1000

					if var_586_11 + var_586_5 > arg_583_1.duration_ then
						arg_583_1.duration_ = var_586_11 + var_586_5
					end

					if var_586_7.prefab_name ~= "" and arg_583_1.actors_[var_586_7.prefab_name] ~= nil then
						local var_586_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_583_1.actors_[var_586_7.prefab_name].transform, "story_v_out_424041", "424041142", "story_v_out_424041.awb")

						arg_583_1:RecordAudio("424041142", var_586_12)
						arg_583_1:RecordAudio("424041142", var_586_12)
					else
						arg_583_1:AudioAction("play", "voice", "story_v_out_424041", "424041142", "story_v_out_424041.awb")
					end

					arg_583_1:RecordHistoryTalkVoice("story_v_out_424041", "424041142", "story_v_out_424041.awb")
				end

				arg_583_1:RecordContent(arg_583_1.text_.text)
			end

			local var_586_13 = math.max(var_586_6, arg_583_1.talkMaxDuration)

			if var_586_5 <= arg_583_1.time_ and arg_583_1.time_ < var_586_5 + var_586_13 then
				arg_583_1.typewritter.percent = (arg_583_1.time_ - var_586_5) / var_586_13

				arg_583_1.typewritter:SetDirty()
			end

			if arg_583_1.time_ >= var_586_5 + var_586_13 and arg_583_1.time_ < var_586_5 + var_586_13 + arg_586_0 then
				arg_583_1.typewritter.percent = 1

				arg_583_1.typewritter:SetDirty()
				arg_583_1:ShowNextGo(true)
			end
		end

		arg_583_1.nodeConfigList_ = {
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

		arg_583_1:InitPlayNodeList()
	end,
	Play424041143 = function(arg_587_0, arg_587_1)
		arg_587_1.time_ = 0
		arg_587_1.frameCnt_ = 0
		arg_587_1.state_ = "playing"
		arg_587_1.curTalkId_ = 424041143
		arg_587_1.duration_ = 5

		SetActive(arg_587_1.tipsGo_, false)

		function arg_587_1.onSingleLineFinish_()
			arg_587_1.onSingleLineUpdate_ = nil
			arg_587_1.onSingleLineFinish_ = nil
			arg_587_1.state_ = "waiting"
		end

		function arg_587_1.playNext_(arg_589_0)
			if arg_589_0 == 1 then
				arg_587_0:Play424041144(arg_587_1)
			end
		end

		function arg_587_1.onSingleLineUpdate_(arg_590_0)
			if 0 < arg_587_1.time_ and arg_587_1.time_ <= 0 + arg_590_0 and not isNil(arg_587_1.actors_["1094"]) and arg_587_1.var_.actorSpriteComps1094 == nil then
				arg_587_1.var_.actorSpriteComps1094 = arg_587_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_590_0 = 0.2

			if 0 <= arg_587_1.time_ and arg_587_1.time_ < 0 + var_590_0 and not isNil(arg_587_1.actors_["1094"]) then
				if arg_587_1.var_.actorSpriteComps1094 then
					for iter_590_0, iter_590_1 in pairs(arg_587_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_590_1 then
							if arg_587_1.isInRecall_ then
								iter_590_1.color = Color.New(Mathf.Lerp(iter_590_1.color.r, arg_587_1.hightColor2.r, (arg_587_1.time_ - 0) / var_590_0), Mathf.Lerp(iter_590_1.color.g, arg_587_1.hightColor2.g, (arg_587_1.time_ - 0) / var_590_0), (Mathf.Lerp(iter_590_1.color.b, arg_587_1.hightColor2.b, (arg_587_1.time_ - 0) / var_590_0)))
							else
								local var_590_1 = Mathf.Lerp(iter_590_1.color.r, 0.5, (arg_587_1.time_ - 0) / var_590_0)

								iter_590_1.color = Color.New(var_590_1, var_590_1, var_590_1)
							end
						end
					end
				end
			end

			if arg_587_1.time_ >= 0 + var_590_0 and arg_587_1.time_ < 0 + var_590_0 + arg_590_0 and not isNil(arg_587_1.actors_["1094"]) and arg_587_1.var_.actorSpriteComps1094 then
				for iter_590_2, iter_590_3 in pairs(arg_587_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_590_3 then
						iter_590_3.color = arg_587_1.isInRecall_ and (arg_587_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_587_1.var_.actorSpriteComps1094 = nil
			end

			if 0.034 < arg_587_1.time_ and arg_587_1.time_ <= 0.034 + arg_590_0 then
				arg_587_1:AudioAction("play", "effect", "se_story_146", "se_story_146_hourglass_sand02", "")
			end

			local var_590_3 = 0
			local var_590_4 = 0.525

			if 0 < arg_587_1.time_ and arg_587_1.time_ <= var_590_3 + arg_590_0 then
				arg_587_1.talkMaxDuration = 0
				arg_587_1.dialogCg_.alpha = 1

				arg_587_1.dialog_:SetActive(true)
				SetActive(arg_587_1.leftNameGo_, false)

				arg_587_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_587_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_587_1:RecordName(arg_587_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_587_1.iconTrs_.gameObject, false)
				arg_587_1.callingController_:SetSelectedState("normal")

				local var_590_5 = arg_587_1:FormatText(arg_587_1:GetWordFromCfg(424041143).content)

				arg_587_1.text_.text = var_590_5

				LuaForUtil.ClearLinePrefixSymbol(arg_587_1.text_)

				local var_590_7 = 21 <= 0 and var_590_4 or var_590_4 * (utf8.len(var_590_5) / 21)

				if (21 <= 0 and var_590_4 or var_590_4 * (utf8.len(var_590_5) / 21)) > 0 and var_590_4 < var_590_7 then
					arg_587_1.talkMaxDuration = var_590_7

					if var_590_7 + var_590_3 > arg_587_1.duration_ then
						arg_587_1.duration_ = var_590_7 + var_590_3
					end
				end

				arg_587_1.text_.text = var_590_5
				arg_587_1.typewritter.percent = 0

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(false)
				arg_587_1:RecordContent(arg_587_1.text_.text)
			end

			local var_590_8 = math.max(var_590_4, arg_587_1.talkMaxDuration)

			if var_590_3 <= arg_587_1.time_ and arg_587_1.time_ < var_590_3 + var_590_8 then
				arg_587_1.typewritter.percent = (arg_587_1.time_ - var_590_3) / var_590_8

				arg_587_1.typewritter:SetDirty()
			end

			if arg_587_1.time_ >= var_590_3 + var_590_8 and arg_587_1.time_ < var_590_3 + var_590_8 + arg_590_0 then
				arg_587_1.typewritter.percent = 1

				arg_587_1.typewritter:SetDirty()
				arg_587_1:ShowNextGo(true)
			end
		end

		arg_587_1.nodeConfigList_ = {}

		arg_587_1:InitPlayNodeList()
	end,
	Play424041144 = function(arg_591_0, arg_591_1)
		arg_591_1.time_ = 0
		arg_591_1.frameCnt_ = 0
		arg_591_1.state_ = "playing"
		arg_591_1.curTalkId_ = 424041144
		arg_591_1.duration_ = 5

		SetActive(arg_591_1.tipsGo_, false)

		function arg_591_1.onSingleLineFinish_()
			arg_591_1.onSingleLineUpdate_ = nil
			arg_591_1.onSingleLineFinish_ = nil
			arg_591_1.state_ = "waiting"
		end

		function arg_591_1.playNext_(arg_593_0)
			if arg_593_0 == 1 then
				arg_591_0:Play424041145(arg_591_1)
			end
		end

		function arg_591_1.onSingleLineUpdate_(arg_594_0)
			local var_594_0 = 0.125

			if 0 < arg_591_1.time_ and arg_591_1.time_ <= 0 + arg_594_0 then
				arg_591_1.talkMaxDuration = 0
				arg_591_1.dialogCg_.alpha = 1

				arg_591_1.dialog_:SetActive(true)
				SetActive(arg_591_1.leftNameGo_, true)

				arg_591_1.leftNameTxt_.text = arg_591_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_591_1.leftNameTxt_.transform)

				arg_591_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_591_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_591_1:RecordName(arg_591_1.leftNameTxt_.text)
				SetActive(arg_591_1.iconTrs_.gameObject, true)
				arg_591_1.iconController_:SetSelectedState("hero")

				arg_591_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_591_1.callingController_:SetSelectedState("normal")

				arg_591_1.keyicon_.color = Color.New(1, 1, 1)
				arg_591_1.icon_.color = Color.New(1, 1, 1)

				local var_594_1 = arg_591_1:FormatText(arg_591_1:GetWordFromCfg(424041144).content)

				arg_591_1.text_.text = var_594_1

				LuaForUtil.ClearLinePrefixSymbol(arg_591_1.text_)

				local var_594_3 = 5 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 5)

				if (5 <= 0 and var_594_0 or var_594_0 * (utf8.len(var_594_1) / 5)) > 0 and var_594_0 < var_594_3 then
					arg_591_1.talkMaxDuration = var_594_3

					if var_594_3 + 0 > arg_591_1.duration_ then
						arg_591_1.duration_ = var_594_3 + 0
					end
				end

				arg_591_1.text_.text = var_594_1
				arg_591_1.typewritter.percent = 0

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(false)
				arg_591_1:RecordContent(arg_591_1.text_.text)
			end

			local var_594_4 = math.max(var_594_0, arg_591_1.talkMaxDuration)

			if 0 <= arg_591_1.time_ and arg_591_1.time_ < 0 + var_594_4 then
				arg_591_1.typewritter.percent = (arg_591_1.time_ - 0) / var_594_4

				arg_591_1.typewritter:SetDirty()
			end

			if arg_591_1.time_ >= 0 + var_594_4 and arg_591_1.time_ < 0 + var_594_4 + arg_594_0 then
				arg_591_1.typewritter.percent = 1

				arg_591_1.typewritter:SetDirty()
				arg_591_1:ShowNextGo(true)
			end
		end

		arg_591_1.nodeConfigList_ = {}

		arg_591_1:InitPlayNodeList()
	end,
	Play424041145 = function(arg_595_0, arg_595_1)
		arg_595_1.time_ = 0
		arg_595_1.frameCnt_ = 0
		arg_595_1.state_ = "playing"
		arg_595_1.curTalkId_ = 424041145
		arg_595_1.duration_ = 10.63

		local var_595_0 = {
			zh = 7.8,
			ja = 10.633
		}
		local var_595_1 = manager.audio:GetLocalizationFlag()

		if var_595_0[var_595_1] ~= nil then
			arg_595_1.duration_ = var_595_0[var_595_1]
		end

		SetActive(arg_595_1.tipsGo_, false)

		function arg_595_1.onSingleLineFinish_()
			arg_595_1.onSingleLineUpdate_ = nil
			arg_595_1.onSingleLineFinish_ = nil
			arg_595_1.state_ = "waiting"
		end

		function arg_595_1.playNext_(arg_597_0)
			if arg_597_0 == 1 then
				arg_595_0:Play424041146(arg_595_1)
			end
		end

		function arg_595_1.onSingleLineUpdate_(arg_598_0)
			local var_598_0 = 1.025

			if 0 < arg_595_1.time_ and arg_595_1.time_ <= 0 + arg_598_0 then
				arg_595_1.talkMaxDuration = 0
				arg_595_1.dialogCg_.alpha = 1

				arg_595_1.dialog_:SetActive(true)
				SetActive(arg_595_1.leftNameGo_, true)

				arg_595_1.leftNameTxt_.text = arg_595_1:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_595_1.leftNameTxt_.transform)

				arg_595_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_595_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_595_1:RecordName(arg_595_1.leftNameTxt_.text)
				SetActive(arg_595_1.iconTrs_.gameObject, true)
				arg_595_1.iconController_:SetSelectedState("hero")

				arg_595_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				arg_595_1.callingController_:SetSelectedState("normal")

				arg_595_1.keyicon_.color = Color.New(1, 1, 1)
				arg_595_1.icon_.color = Color.New(1, 1, 1)

				local var_598_1 = arg_595_1:GetWordFromCfg(424041145)
				local var_598_2 = arg_595_1:FormatText(var_598_1.content)

				arg_595_1.text_.text = var_598_2

				LuaForUtil.ClearLinePrefixSymbol(arg_595_1.text_)

				local var_598_4 = 41 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_2) / 41)

				if (41 <= 0 and var_598_0 or var_598_0 * (utf8.len(var_598_2) / 41)) > 0 and var_598_0 < var_598_4 then
					arg_595_1.talkMaxDuration = var_598_4

					if var_598_4 + 0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_4 + 0
					end
				end

				arg_595_1.text_.text = var_598_2
				arg_595_1.typewritter.percent = 0

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041145", "story_v_out_424041.awb") ~= 0 then
					local var_598_5 = manager.audio:GetVoiceLength("story_v_out_424041", "424041145", "story_v_out_424041.awb") / 1000

					if var_598_5 + 0 > arg_595_1.duration_ then
						arg_595_1.duration_ = var_598_5 + 0
					end

					if var_598_1.prefab_name ~= "" and arg_595_1.actors_[var_598_1.prefab_name] ~= nil then
						local var_598_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_595_1.actors_[var_598_1.prefab_name].transform, "story_v_out_424041", "424041145", "story_v_out_424041.awb")

						arg_595_1:RecordAudio("424041145", var_598_6)
						arg_595_1:RecordAudio("424041145", var_598_6)
					else
						arg_595_1:AudioAction("play", "voice", "story_v_out_424041", "424041145", "story_v_out_424041.awb")
					end

					arg_595_1:RecordHistoryTalkVoice("story_v_out_424041", "424041145", "story_v_out_424041.awb")
				end

				arg_595_1:RecordContent(arg_595_1.text_.text)
			end

			local var_598_7 = math.max(var_598_0, arg_595_1.talkMaxDuration)

			if 0 <= arg_595_1.time_ and arg_595_1.time_ < 0 + var_598_7 then
				arg_595_1.typewritter.percent = (arg_595_1.time_ - 0) / var_598_7

				arg_595_1.typewritter:SetDirty()
			end

			if arg_595_1.time_ >= 0 + var_598_7 and arg_595_1.time_ < 0 + var_598_7 + arg_598_0 then
				arg_595_1.typewritter.percent = 1

				arg_595_1.typewritter:SetDirty()
				arg_595_1:ShowNextGo(true)
			end
		end

		arg_595_1.nodeConfigList_ = {}

		arg_595_1:InitPlayNodeList()
	end,
	Play424041146 = function(arg_599_0, arg_599_1)
		arg_599_1.time_ = 0
		arg_599_1.frameCnt_ = 0
		arg_599_1.state_ = "playing"
		arg_599_1.curTalkId_ = 424041146
		arg_599_1.duration_ = 5

		SetActive(arg_599_1.tipsGo_, false)

		function arg_599_1.onSingleLineFinish_()
			arg_599_1.onSingleLineUpdate_ = nil
			arg_599_1.onSingleLineFinish_ = nil
			arg_599_1.state_ = "waiting"
		end

		function arg_599_1.playNext_(arg_601_0)
			if arg_601_0 == 1 then
				arg_599_0:Play424041147(arg_599_1)
			end
		end

		function arg_599_1.onSingleLineUpdate_(arg_602_0)
			local var_602_0 = 0.3

			if 0 < arg_599_1.time_ and arg_599_1.time_ <= 0 + arg_602_0 then
				arg_599_1.talkMaxDuration = 0
				arg_599_1.dialogCg_.alpha = 1

				arg_599_1.dialog_:SetActive(true)
				SetActive(arg_599_1.leftNameGo_, true)

				arg_599_1.leftNameTxt_.text = arg_599_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_599_1.leftNameTxt_.transform)

				arg_599_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_599_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_599_1:RecordName(arg_599_1.leftNameTxt_.text)
				SetActive(arg_599_1.iconTrs_.gameObject, true)
				arg_599_1.iconController_:SetSelectedState("hero")

				arg_599_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_599_1.callingController_:SetSelectedState("normal")

				arg_599_1.keyicon_.color = Color.New(1, 1, 1)
				arg_599_1.icon_.color = Color.New(1, 1, 1)

				local var_602_1 = arg_599_1:FormatText(arg_599_1:GetWordFromCfg(424041146).content)

				arg_599_1.text_.text = var_602_1

				LuaForUtil.ClearLinePrefixSymbol(arg_599_1.text_)

				local var_602_3 = 12 <= 0 and var_602_0 or var_602_0 * (utf8.len(var_602_1) / 12)

				if (12 <= 0 and var_602_0 or var_602_0 * (utf8.len(var_602_1) / 12)) > 0 and var_602_0 < var_602_3 then
					arg_599_1.talkMaxDuration = var_602_3

					if var_602_3 + 0 > arg_599_1.duration_ then
						arg_599_1.duration_ = var_602_3 + 0
					end
				end

				arg_599_1.text_.text = var_602_1
				arg_599_1.typewritter.percent = 0

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(false)
				arg_599_1:RecordContent(arg_599_1.text_.text)
			end

			local var_602_4 = math.max(var_602_0, arg_599_1.talkMaxDuration)

			if 0 <= arg_599_1.time_ and arg_599_1.time_ < 0 + var_602_4 then
				arg_599_1.typewritter.percent = (arg_599_1.time_ - 0) / var_602_4

				arg_599_1.typewritter:SetDirty()
			end

			if arg_599_1.time_ >= 0 + var_602_4 and arg_599_1.time_ < 0 + var_602_4 + arg_602_0 then
				arg_599_1.typewritter.percent = 1

				arg_599_1.typewritter:SetDirty()
				arg_599_1:ShowNextGo(true)
			end
		end

		arg_599_1.nodeConfigList_ = {}

		arg_599_1:InitPlayNodeList()
	end,
	Play424041147 = function(arg_603_0, arg_603_1)
		arg_603_1.time_ = 0
		arg_603_1.frameCnt_ = 0
		arg_603_1.state_ = "playing"
		arg_603_1.curTalkId_ = 424041147
		arg_603_1.duration_ = 6.17

		local var_603_0 = {
			zh = 4.933,
			ja = 6.166
		}
		local var_603_1 = manager.audio:GetLocalizationFlag()

		if var_603_0[var_603_1] ~= nil then
			arg_603_1.duration_ = var_603_0[var_603_1]
		end

		SetActive(arg_603_1.tipsGo_, false)

		function arg_603_1.onSingleLineFinish_()
			arg_603_1.onSingleLineUpdate_ = nil
			arg_603_1.onSingleLineFinish_ = nil
			arg_603_1.state_ = "waiting"
		end

		function arg_603_1.playNext_(arg_605_0)
			if arg_605_0 == 1 then
				arg_603_0:Play424041148(arg_603_1)
			end
		end

		function arg_603_1.onSingleLineUpdate_(arg_606_0)
			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 and not isNil(arg_603_1.actors_["1094"]) and arg_603_1.var_.actorSpriteComps1094 == nil then
				arg_603_1.var_.actorSpriteComps1094 = arg_603_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_606_0 = 0.2

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_0 and not isNil(arg_603_1.actors_["1094"]) then
				if arg_603_1.var_.actorSpriteComps1094 then
					for iter_606_0, iter_606_1 in pairs(arg_603_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_606_1 then
							if arg_603_1.isInRecall_ then
								iter_606_1.color = Color.New(Mathf.Lerp(iter_606_1.color.r, arg_603_1.hightColor1.r, (arg_603_1.time_ - 0) / var_606_0), Mathf.Lerp(iter_606_1.color.g, arg_603_1.hightColor1.g, (arg_603_1.time_ - 0) / var_606_0), (Mathf.Lerp(iter_606_1.color.b, arg_603_1.hightColor1.b, (arg_603_1.time_ - 0) / var_606_0)))
							else
								local var_606_1 = Mathf.Lerp(iter_606_1.color.r, 1, (arg_603_1.time_ - 0) / var_606_0)

								iter_606_1.color = Color.New(var_606_1, var_606_1, var_606_1)
							end
						end
					end
				end
			end

			if arg_603_1.time_ >= 0 + var_606_0 and arg_603_1.time_ < 0 + var_606_0 + arg_606_0 and not isNil(arg_603_1.actors_["1094"]) and arg_603_1.var_.actorSpriteComps1094 then
				for iter_606_2, iter_606_3 in pairs(arg_603_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_606_3 then
						iter_606_3.color = arg_603_1.isInRecall_ and (arg_603_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_603_1.var_.actorSpriteComps1094 = nil
			end

			local var_606_2 = arg_603_1.actors_["1094"].transform

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= 0 + arg_606_0 then
				arg_603_1.var_.moveOldPos1094 = var_606_2.localPosition
				var_606_2.localScale = Vector3.New(1, 1, 1)

				arg_603_1:CheckSpriteTmpPos("1094", 4)

				for iter_606_4 = 0, var_606_2.childCount - 1 do
					local var_606_3 = var_606_2:GetChild(iter_606_4)

					if var_606_3.name == "split_4" then
						var_606_3:SetAsLastSibling()
						var_606_3.gameObject:SetActive(true)

						arg_603_1.var_.actorSpriteSplit1094 = var_606_3.gameObject:GetComponent(typeof(Image))

						arg_603_1.var_.actorSpriteSplit1094:SetAlpha(0)
					end
				end
			end

			local var_606_4 = 0.5

			if 0 <= arg_603_1.time_ and arg_603_1.time_ < 0 + var_606_4 then
				var_606_2.localPosition = Vector3.Lerp(arg_603_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_603_1.time_ - 0) / var_606_4)

				if arg_603_1.var_.actorSpriteSplit1094 ~= nil then
					arg_603_1.var_.actorSpriteSplit1094:SetAlpha((arg_603_1.time_ - 0) / var_606_4)
				end
			end

			if arg_603_1.time_ >= 0 + var_606_4 and arg_603_1.time_ < 0 + var_606_4 + arg_606_0 then
				var_606_2.localPosition = Vector3.New(470, -335, -230)

				if arg_603_1.var_.actorSpriteSplit1094 ~= nil then
					arg_603_1.var_.actorSpriteSplit1094:SetAlpha(1)
				end
			end

			local var_606_5 = 0
			local var_606_6 = 0.525

			if 0 < arg_603_1.time_ and arg_603_1.time_ <= var_606_5 + arg_606_0 then
				arg_603_1.talkMaxDuration = 0
				arg_603_1.dialogCg_.alpha = 1

				arg_603_1.dialog_:SetActive(true)
				SetActive(arg_603_1.leftNameGo_, true)

				arg_603_1.leftNameTxt_.text = arg_603_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_603_1.leftNameTxt_.transform)

				arg_603_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_603_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_603_1:RecordName(arg_603_1.leftNameTxt_.text)
				SetActive(arg_603_1.iconTrs_.gameObject, false)
				arg_603_1.callingController_:SetSelectedState("normal")

				local var_606_7 = arg_603_1:GetWordFromCfg(424041147)
				local var_606_8 = arg_603_1:FormatText(var_606_7.content)

				arg_603_1.text_.text = var_606_8

				LuaForUtil.ClearLinePrefixSymbol(arg_603_1.text_)

				local var_606_10 = 21 <= 0 and var_606_6 or var_606_6 * (utf8.len(var_606_8) / 21)

				if (21 <= 0 and var_606_6 or var_606_6 * (utf8.len(var_606_8) / 21)) > 0 and var_606_6 < var_606_10 then
					arg_603_1.talkMaxDuration = var_606_10

					if var_606_10 + var_606_5 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_10 + var_606_5
					end
				end

				arg_603_1.text_.text = var_606_8
				arg_603_1.typewritter.percent = 0

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041147", "story_v_out_424041.awb") ~= 0 then
					local var_606_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041147", "story_v_out_424041.awb") / 1000

					if var_606_11 + var_606_5 > arg_603_1.duration_ then
						arg_603_1.duration_ = var_606_11 + var_606_5
					end

					if var_606_7.prefab_name ~= "" and arg_603_1.actors_[var_606_7.prefab_name] ~= nil then
						local var_606_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_603_1.actors_[var_606_7.prefab_name].transform, "story_v_out_424041", "424041147", "story_v_out_424041.awb")

						arg_603_1:RecordAudio("424041147", var_606_12)
						arg_603_1:RecordAudio("424041147", var_606_12)
					else
						arg_603_1:AudioAction("play", "voice", "story_v_out_424041", "424041147", "story_v_out_424041.awb")
					end

					arg_603_1:RecordHistoryTalkVoice("story_v_out_424041", "424041147", "story_v_out_424041.awb")
				end

				arg_603_1:RecordContent(arg_603_1.text_.text)
			end

			local var_606_13 = math.max(var_606_6, arg_603_1.talkMaxDuration)

			if var_606_5 <= arg_603_1.time_ and arg_603_1.time_ < var_606_5 + var_606_13 then
				arg_603_1.typewritter.percent = (arg_603_1.time_ - var_606_5) / var_606_13

				arg_603_1.typewritter:SetDirty()
			end

			if arg_603_1.time_ >= var_606_5 + var_606_13 and arg_603_1.time_ < var_606_5 + var_606_13 + arg_606_0 then
				arg_603_1.typewritter.percent = 1

				arg_603_1.typewritter:SetDirty()
				arg_603_1:ShowNextGo(true)
			end
		end

		arg_603_1.nodeConfigList_ = {
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

		arg_603_1:InitPlayNodeList()
	end,
	Play424041148 = function(arg_607_0, arg_607_1)
		arg_607_1.time_ = 0
		arg_607_1.frameCnt_ = 0
		arg_607_1.state_ = "playing"
		arg_607_1.curTalkId_ = 424041148
		arg_607_1.duration_ = 5

		SetActive(arg_607_1.tipsGo_, false)

		function arg_607_1.onSingleLineFinish_()
			arg_607_1.onSingleLineUpdate_ = nil
			arg_607_1.onSingleLineFinish_ = nil
			arg_607_1.state_ = "waiting"
		end

		function arg_607_1.playNext_(arg_609_0)
			if arg_609_0 == 1 then
				arg_607_0:Play424041149(arg_607_1)
			end
		end

		function arg_607_1.onSingleLineUpdate_(arg_610_0)
			if 0 < arg_607_1.time_ and arg_607_1.time_ <= 0 + arg_610_0 and not isNil(arg_607_1.actors_["1094"]) and arg_607_1.var_.actorSpriteComps1094 == nil then
				arg_607_1.var_.actorSpriteComps1094 = arg_607_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_610_0 = 0.2

			if 0 <= arg_607_1.time_ and arg_607_1.time_ < 0 + var_610_0 and not isNil(arg_607_1.actors_["1094"]) then
				if arg_607_1.var_.actorSpriteComps1094 then
					for iter_610_0, iter_610_1 in pairs(arg_607_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_610_1 then
							if arg_607_1.isInRecall_ then
								iter_610_1.color = Color.New(Mathf.Lerp(iter_610_1.color.r, arg_607_1.hightColor2.r, (arg_607_1.time_ - 0) / var_610_0), Mathf.Lerp(iter_610_1.color.g, arg_607_1.hightColor2.g, (arg_607_1.time_ - 0) / var_610_0), (Mathf.Lerp(iter_610_1.color.b, arg_607_1.hightColor2.b, (arg_607_1.time_ - 0) / var_610_0)))
							else
								local var_610_1 = Mathf.Lerp(iter_610_1.color.r, 0.5, (arg_607_1.time_ - 0) / var_610_0)

								iter_610_1.color = Color.New(var_610_1, var_610_1, var_610_1)
							end
						end
					end
				end
			end

			if arg_607_1.time_ >= 0 + var_610_0 and arg_607_1.time_ < 0 + var_610_0 + arg_610_0 and not isNil(arg_607_1.actors_["1094"]) and arg_607_1.var_.actorSpriteComps1094 then
				for iter_610_2, iter_610_3 in pairs(arg_607_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_610_3 then
						iter_610_3.color = arg_607_1.isInRecall_ and (arg_607_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_607_1.var_.actorSpriteComps1094 = nil
			end

			local var_610_2 = 0
			local var_610_3 = 0.325

			if 0 < arg_607_1.time_ and arg_607_1.time_ <= var_610_2 + arg_610_0 then
				arg_607_1.talkMaxDuration = 0
				arg_607_1.dialogCg_.alpha = 1

				arg_607_1.dialog_:SetActive(true)
				SetActive(arg_607_1.leftNameGo_, true)

				arg_607_1.leftNameTxt_.text = arg_607_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_607_1.leftNameTxt_.transform)

				arg_607_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_607_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_607_1:RecordName(arg_607_1.leftNameTxt_.text)
				SetActive(arg_607_1.iconTrs_.gameObject, true)
				arg_607_1.iconController_:SetSelectedState("hero")

				arg_607_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_607_1.callingController_:SetSelectedState("normal")

				arg_607_1.keyicon_.color = Color.New(1, 1, 1)
				arg_607_1.icon_.color = Color.New(1, 1, 1)

				local var_610_4 = arg_607_1:FormatText(arg_607_1:GetWordFromCfg(424041148).content)

				arg_607_1.text_.text = var_610_4

				LuaForUtil.ClearLinePrefixSymbol(arg_607_1.text_)

				local var_610_6 = 13 <= 0 and var_610_3 or var_610_3 * (utf8.len(var_610_4) / 13)

				if (13 <= 0 and var_610_3 or var_610_3 * (utf8.len(var_610_4) / 13)) > 0 and var_610_3 < var_610_6 then
					arg_607_1.talkMaxDuration = var_610_6

					if var_610_6 + var_610_2 > arg_607_1.duration_ then
						arg_607_1.duration_ = var_610_6 + var_610_2
					end
				end

				arg_607_1.text_.text = var_610_4
				arg_607_1.typewritter.percent = 0

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(false)
				arg_607_1:RecordContent(arg_607_1.text_.text)
			end

			local var_610_7 = math.max(var_610_3, arg_607_1.talkMaxDuration)

			if var_610_2 <= arg_607_1.time_ and arg_607_1.time_ < var_610_2 + var_610_7 then
				arg_607_1.typewritter.percent = (arg_607_1.time_ - var_610_2) / var_610_7

				arg_607_1.typewritter:SetDirty()
			end

			if arg_607_1.time_ >= var_610_2 + var_610_7 and arg_607_1.time_ < var_610_2 + var_610_7 + arg_610_0 then
				arg_607_1.typewritter.percent = 1

				arg_607_1.typewritter:SetDirty()
				arg_607_1:ShowNextGo(true)
			end
		end

		arg_607_1.nodeConfigList_ = {}

		arg_607_1:InitPlayNodeList()
	end,
	Play424041149 = function(arg_611_0, arg_611_1)
		arg_611_1.time_ = 0
		arg_611_1.frameCnt_ = 0
		arg_611_1.state_ = "playing"
		arg_611_1.curTalkId_ = 424041149
		arg_611_1.duration_ = 5

		SetActive(arg_611_1.tipsGo_, false)

		function arg_611_1.onSingleLineFinish_()
			arg_611_1.onSingleLineUpdate_ = nil
			arg_611_1.onSingleLineFinish_ = nil
			arg_611_1.state_ = "waiting"
		end

		function arg_611_1.playNext_(arg_613_0)
			if arg_613_0 == 1 then
				arg_611_0:Play424041150(arg_611_1)
			end
		end

		function arg_611_1.onSingleLineUpdate_(arg_614_0)
			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1.var_.moveOldPos1094 = arg_611_1.actors_["1094"].transform.localPosition
				arg_611_1.actors_["1094"].transform.localScale = Vector3.New(1, 1, 1)

				arg_611_1:CheckSpriteTmpPos("1094", 7)

				for iter_614_0 = 0, arg_611_1.actors_["1094"].transform.childCount - 1 do
					local var_614_0 = arg_611_1.actors_["1094"].transform:GetChild(iter_614_0)

					if var_614_0.name == "" or not string.find(var_614_0.name, "split") then
						var_614_0.gameObject:SetActive(true)
					else
						var_614_0.gameObject:SetActive(false)
					end
				end
			end

			local var_614_1 = 0.001

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_1 then
				arg_611_1.actors_["1094"].transform.localPosition = Vector3.Lerp(arg_611_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_611_1.time_ - 0) / var_614_1)
			end

			if arg_611_1.time_ >= 0 + var_614_1 and arg_611_1.time_ < 0 + var_614_1 + arg_614_0 then
				arg_611_1.actors_["1094"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_614_2 = arg_611_1.actors_["10153"].transform

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= 0 + arg_614_0 then
				arg_611_1.var_.moveOldPos10153 = var_614_2.localPosition
				var_614_2.localScale = Vector3.New(1, 1, 1)

				arg_611_1:CheckSpriteTmpPos("10153", 7)

				for iter_614_1 = 0, var_614_2.childCount - 1 do
					local var_614_3 = var_614_2:GetChild(iter_614_1)

					if var_614_3.name == "" or not string.find(var_614_3.name, "split") then
						var_614_3.gameObject:SetActive(true)
					else
						var_614_3.gameObject:SetActive(false)
					end
				end
			end

			local var_614_4 = 0.001

			if 0 <= arg_611_1.time_ and arg_611_1.time_ < 0 + var_614_4 then
				var_614_2.localPosition = Vector3.Lerp(arg_611_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_611_1.time_ - 0) / var_614_4)
			end

			if arg_611_1.time_ >= 0 + var_614_4 and arg_611_1.time_ < 0 + var_614_4 + arg_614_0 then
				var_614_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.034 < arg_611_1.time_ and arg_611_1.time_ <= 0.034 + arg_614_0 then
				arg_611_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep01", "")
			end

			local var_614_6 = 0
			local var_614_7 = 0.425

			if 0 < arg_611_1.time_ and arg_611_1.time_ <= var_614_6 + arg_614_0 then
				arg_611_1.talkMaxDuration = 0
				arg_611_1.dialogCg_.alpha = 1

				arg_611_1.dialog_:SetActive(true)
				SetActive(arg_611_1.leftNameGo_, false)

				arg_611_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_611_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_611_1:RecordName(arg_611_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_611_1.iconTrs_.gameObject, false)
				arg_611_1.callingController_:SetSelectedState("normal")

				local var_614_8 = arg_611_1:FormatText(arg_611_1:GetWordFromCfg(424041149).content)

				arg_611_1.text_.text = var_614_8

				LuaForUtil.ClearLinePrefixSymbol(arg_611_1.text_)

				local var_614_10 = 17 <= 0 and var_614_7 or var_614_7 * (utf8.len(var_614_8) / 17)

				if (17 <= 0 and var_614_7 or var_614_7 * (utf8.len(var_614_8) / 17)) > 0 and var_614_7 < var_614_10 then
					arg_611_1.talkMaxDuration = var_614_10

					if var_614_10 + var_614_6 > arg_611_1.duration_ then
						arg_611_1.duration_ = var_614_10 + var_614_6
					end
				end

				arg_611_1.text_.text = var_614_8
				arg_611_1.typewritter.percent = 0

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(false)
				arg_611_1:RecordContent(arg_611_1.text_.text)
			end

			local var_614_11 = math.max(var_614_7, arg_611_1.talkMaxDuration)

			if var_614_6 <= arg_611_1.time_ and arg_611_1.time_ < var_614_6 + var_614_11 then
				arg_611_1.typewritter.percent = (arg_611_1.time_ - var_614_6) / var_614_11

				arg_611_1.typewritter:SetDirty()
			end

			if arg_611_1.time_ >= var_614_6 + var_614_11 and arg_611_1.time_ < var_614_6 + var_614_11 + arg_614_0 then
				arg_611_1.typewritter.percent = 1

				arg_611_1.typewritter:SetDirty()
				arg_611_1:ShowNextGo(true)
			end
		end

		arg_611_1.nodeConfigList_ = {
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
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_611_1:InitPlayNodeList()
	end,
	Play424041150 = function(arg_615_0, arg_615_1)
		arg_615_1.time_ = 0
		arg_615_1.frameCnt_ = 0
		arg_615_1.state_ = "playing"
		arg_615_1.curTalkId_ = 424041150
		arg_615_1.duration_ = 5

		SetActive(arg_615_1.tipsGo_, false)

		function arg_615_1.onSingleLineFinish_()
			arg_615_1.onSingleLineUpdate_ = nil
			arg_615_1.onSingleLineFinish_ = nil
			arg_615_1.state_ = "waiting"
		end

		function arg_615_1.playNext_(arg_617_0)
			if arg_617_0 == 1 then
				arg_615_0:Play424041151(arg_615_1)
			end
		end

		function arg_615_1.onSingleLineUpdate_(arg_618_0)
			local var_618_0 = 0.375

			if 0 < arg_615_1.time_ and arg_615_1.time_ <= 0 + arg_618_0 then
				arg_615_1.talkMaxDuration = 0
				arg_615_1.dialogCg_.alpha = 1

				arg_615_1.dialog_:SetActive(true)
				SetActive(arg_615_1.leftNameGo_, true)

				arg_615_1.leftNameTxt_.text = arg_615_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_615_1.leftNameTxt_.transform)

				arg_615_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_615_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_615_1:RecordName(arg_615_1.leftNameTxt_.text)
				SetActive(arg_615_1.iconTrs_.gameObject, true)
				arg_615_1.iconController_:SetSelectedState("hero")

				arg_615_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_615_1.callingController_:SetSelectedState("normal")

				arg_615_1.keyicon_.color = Color.New(1, 1, 1)
				arg_615_1.icon_.color = Color.New(1, 1, 1)

				local var_618_1 = arg_615_1:FormatText(arg_615_1:GetWordFromCfg(424041150).content)

				arg_615_1.text_.text = var_618_1

				LuaForUtil.ClearLinePrefixSymbol(arg_615_1.text_)

				local var_618_3 = 15 <= 0 and var_618_0 or var_618_0 * (utf8.len(var_618_1) / 15)

				if (15 <= 0 and var_618_0 or var_618_0 * (utf8.len(var_618_1) / 15)) > 0 and var_618_0 < var_618_3 then
					arg_615_1.talkMaxDuration = var_618_3

					if var_618_3 + 0 > arg_615_1.duration_ then
						arg_615_1.duration_ = var_618_3 + 0
					end
				end

				arg_615_1.text_.text = var_618_1
				arg_615_1.typewritter.percent = 0

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(false)
				arg_615_1:RecordContent(arg_615_1.text_.text)
			end

			local var_618_4 = math.max(var_618_0, arg_615_1.talkMaxDuration)

			if 0 <= arg_615_1.time_ and arg_615_1.time_ < 0 + var_618_4 then
				arg_615_1.typewritter.percent = (arg_615_1.time_ - 0) / var_618_4

				arg_615_1.typewritter:SetDirty()
			end

			if arg_615_1.time_ >= 0 + var_618_4 and arg_615_1.time_ < 0 + var_618_4 + arg_618_0 then
				arg_615_1.typewritter.percent = 1

				arg_615_1.typewritter:SetDirty()
				arg_615_1:ShowNextGo(true)
			end
		end

		arg_615_1.nodeConfigList_ = {}

		arg_615_1:InitPlayNodeList()
	end,
	Play424041151 = function(arg_619_0, arg_619_1)
		arg_619_1.time_ = 0
		arg_619_1.frameCnt_ = 0
		arg_619_1.state_ = "playing"
		arg_619_1.curTalkId_ = 424041151
		arg_619_1.duration_ = 6.27

		local var_619_0 = {
			zh = 3.833,
			ja = 6.266
		}
		local var_619_1 = manager.audio:GetLocalizationFlag()

		if var_619_0[var_619_1] ~= nil then
			arg_619_1.duration_ = var_619_0[var_619_1]
		end

		SetActive(arg_619_1.tipsGo_, false)

		function arg_619_1.onSingleLineFinish_()
			arg_619_1.onSingleLineUpdate_ = nil
			arg_619_1.onSingleLineFinish_ = nil
			arg_619_1.state_ = "waiting"
		end

		function arg_619_1.playNext_(arg_621_0)
			if arg_621_0 == 1 then
				arg_619_0:Play424041152(arg_619_1)
			end
		end

		function arg_619_1.onSingleLineUpdate_(arg_622_0)
			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 and not isNil(arg_619_1.actors_["10154"]) and arg_619_1.var_.actorSpriteComps10154 == nil then
				arg_619_1.var_.actorSpriteComps10154 = arg_619_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_622_0 = 0.2

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_0 and not isNil(arg_619_1.actors_["10154"]) then
				if arg_619_1.var_.actorSpriteComps10154 then
					for iter_622_0, iter_622_1 in pairs(arg_619_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_622_1 then
							if arg_619_1.isInRecall_ then
								iter_622_1.color = Color.New(Mathf.Lerp(iter_622_1.color.r, arg_619_1.hightColor1.r, (arg_619_1.time_ - 0) / var_622_0), Mathf.Lerp(iter_622_1.color.g, arg_619_1.hightColor1.g, (arg_619_1.time_ - 0) / var_622_0), (Mathf.Lerp(iter_622_1.color.b, arg_619_1.hightColor1.b, (arg_619_1.time_ - 0) / var_622_0)))
							else
								local var_622_1 = Mathf.Lerp(iter_622_1.color.r, 1, (arg_619_1.time_ - 0) / var_622_0)

								iter_622_1.color = Color.New(var_622_1, var_622_1, var_622_1)
							end
						end
					end
				end
			end

			if arg_619_1.time_ >= 0 + var_622_0 and arg_619_1.time_ < 0 + var_622_0 + arg_622_0 and not isNil(arg_619_1.actors_["10154"]) and arg_619_1.var_.actorSpriteComps10154 then
				for iter_622_2, iter_622_3 in pairs(arg_619_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_622_3 then
						iter_622_3.color = arg_619_1.isInRecall_ and (arg_619_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_619_1.var_.actorSpriteComps10154 = nil
			end

			local var_622_2 = arg_619_1.actors_["10154"].transform

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= 0 + arg_622_0 then
				arg_619_1.var_.moveOldPos10154 = var_622_2.localPosition
				var_622_2.localScale = Vector3.New(1, 1, 1)

				arg_619_1:CheckSpriteTmpPos("10154", 3)

				for iter_622_4 = 0, var_622_2.childCount - 1 do
					local var_622_3 = var_622_2:GetChild(iter_622_4)

					if var_622_3.name == "split_1" or not string.find(var_622_3.name, "split") then
						var_622_3.gameObject:SetActive(true)
					else
						var_622_3.gameObject:SetActive(false)
					end
				end
			end

			local var_622_4 = 0.001

			if 0 <= arg_619_1.time_ and arg_619_1.time_ < 0 + var_622_4 then
				var_622_2.localPosition = Vector3.Lerp(arg_619_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_619_1.time_ - 0) / var_622_4)
			end

			if arg_619_1.time_ >= 0 + var_622_4 and arg_619_1.time_ < 0 + var_622_4 + arg_622_0 then
				var_622_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_622_5 = 0
			local var_622_6 = 0.6

			if 0 < arg_619_1.time_ and arg_619_1.time_ <= var_622_5 + arg_622_0 then
				arg_619_1.talkMaxDuration = 0
				arg_619_1.dialogCg_.alpha = 1

				arg_619_1.dialog_:SetActive(true)
				SetActive(arg_619_1.leftNameGo_, true)

				arg_619_1.leftNameTxt_.text = arg_619_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_619_1.leftNameTxt_.transform)

				arg_619_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_619_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_619_1:RecordName(arg_619_1.leftNameTxt_.text)
				SetActive(arg_619_1.iconTrs_.gameObject, false)
				arg_619_1.callingController_:SetSelectedState("normal")

				local var_622_7 = arg_619_1:GetWordFromCfg(424041151)
				local var_622_8 = arg_619_1:FormatText(var_622_7.content)

				arg_619_1.text_.text = var_622_8

				LuaForUtil.ClearLinePrefixSymbol(arg_619_1.text_)

				local var_622_10 = 24 <= 0 and var_622_6 or var_622_6 * (utf8.len(var_622_8) / 24)

				if (24 <= 0 and var_622_6 or var_622_6 * (utf8.len(var_622_8) / 24)) > 0 and var_622_6 < var_622_10 then
					arg_619_1.talkMaxDuration = var_622_10

					if var_622_10 + var_622_5 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_10 + var_622_5
					end
				end

				arg_619_1.text_.text = var_622_8
				arg_619_1.typewritter.percent = 0

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041151", "story_v_out_424041.awb") ~= 0 then
					local var_622_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041151", "story_v_out_424041.awb") / 1000

					if var_622_11 + var_622_5 > arg_619_1.duration_ then
						arg_619_1.duration_ = var_622_11 + var_622_5
					end

					if var_622_7.prefab_name ~= "" and arg_619_1.actors_[var_622_7.prefab_name] ~= nil then
						local var_622_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_619_1.actors_[var_622_7.prefab_name].transform, "story_v_out_424041", "424041151", "story_v_out_424041.awb")

						arg_619_1:RecordAudio("424041151", var_622_12)
						arg_619_1:RecordAudio("424041151", var_622_12)
					else
						arg_619_1:AudioAction("play", "voice", "story_v_out_424041", "424041151", "story_v_out_424041.awb")
					end

					arg_619_1:RecordHistoryTalkVoice("story_v_out_424041", "424041151", "story_v_out_424041.awb")
				end

				arg_619_1:RecordContent(arg_619_1.text_.text)
			end

			local var_622_13 = math.max(var_622_6, arg_619_1.talkMaxDuration)

			if var_622_5 <= arg_619_1.time_ and arg_619_1.time_ < var_622_5 + var_622_13 then
				arg_619_1.typewritter.percent = (arg_619_1.time_ - var_622_5) / var_622_13

				arg_619_1.typewritter:SetDirty()
			end

			if arg_619_1.time_ >= var_622_5 + var_622_13 and arg_619_1.time_ < var_622_5 + var_622_13 + arg_622_0 then
				arg_619_1.typewritter.percent = 1

				arg_619_1.typewritter:SetDirty()
				arg_619_1:ShowNextGo(true)
			end
		end

		arg_619_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_619_1:InitPlayNodeList()
	end,
	Play424041152 = function(arg_623_0, arg_623_1)
		arg_623_1.time_ = 0
		arg_623_1.frameCnt_ = 0
		arg_623_1.state_ = "playing"
		arg_623_1.curTalkId_ = 424041152
		arg_623_1.duration_ = 5

		SetActive(arg_623_1.tipsGo_, false)

		function arg_623_1.onSingleLineFinish_()
			arg_623_1.onSingleLineUpdate_ = nil
			arg_623_1.onSingleLineFinish_ = nil
			arg_623_1.state_ = "waiting"
		end

		function arg_623_1.playNext_(arg_625_0)
			if arg_625_0 == 1 then
				arg_623_0:Play424041153(arg_623_1)
			end
		end

		function arg_623_1.onSingleLineUpdate_(arg_626_0)
			if 0 < arg_623_1.time_ and arg_623_1.time_ <= 0 + arg_626_0 and not isNil(arg_623_1.actors_["10154"]) and arg_623_1.var_.actorSpriteComps10154 == nil then
				arg_623_1.var_.actorSpriteComps10154 = arg_623_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_626_0 = 0.2

			if 0 <= arg_623_1.time_ and arg_623_1.time_ < 0 + var_626_0 and not isNil(arg_623_1.actors_["10154"]) then
				if arg_623_1.var_.actorSpriteComps10154 then
					for iter_626_0, iter_626_1 in pairs(arg_623_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_626_1 then
							if arg_623_1.isInRecall_ then
								iter_626_1.color = Color.New(Mathf.Lerp(iter_626_1.color.r, arg_623_1.hightColor2.r, (arg_623_1.time_ - 0) / var_626_0), Mathf.Lerp(iter_626_1.color.g, arg_623_1.hightColor2.g, (arg_623_1.time_ - 0) / var_626_0), (Mathf.Lerp(iter_626_1.color.b, arg_623_1.hightColor2.b, (arg_623_1.time_ - 0) / var_626_0)))
							else
								local var_626_1 = Mathf.Lerp(iter_626_1.color.r, 0.5, (arg_623_1.time_ - 0) / var_626_0)

								iter_626_1.color = Color.New(var_626_1, var_626_1, var_626_1)
							end
						end
					end
				end
			end

			if arg_623_1.time_ >= 0 + var_626_0 and arg_623_1.time_ < 0 + var_626_0 + arg_626_0 and not isNil(arg_623_1.actors_["10154"]) and arg_623_1.var_.actorSpriteComps10154 then
				for iter_626_2, iter_626_3 in pairs(arg_623_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_626_3 then
						iter_626_3.color = arg_623_1.isInRecall_ and (arg_623_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_623_1.var_.actorSpriteComps10154 = nil
			end

			local var_626_2 = 0
			local var_626_3 = 0.7

			if 0 < arg_623_1.time_ and arg_623_1.time_ <= var_626_2 + arg_626_0 then
				arg_623_1.talkMaxDuration = 0
				arg_623_1.dialogCg_.alpha = 1

				arg_623_1.dialog_:SetActive(true)
				SetActive(arg_623_1.leftNameGo_, true)

				arg_623_1.leftNameTxt_.text = arg_623_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_623_1.leftNameTxt_.transform)

				arg_623_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_623_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_623_1:RecordName(arg_623_1.leftNameTxt_.text)
				SetActive(arg_623_1.iconTrs_.gameObject, true)
				arg_623_1.iconController_:SetSelectedState("hero")

				arg_623_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_623_1.callingController_:SetSelectedState("normal")

				arg_623_1.keyicon_.color = Color.New(1, 1, 1)
				arg_623_1.icon_.color = Color.New(1, 1, 1)

				local var_626_4 = arg_623_1:FormatText(arg_623_1:GetWordFromCfg(424041152).content)

				arg_623_1.text_.text = var_626_4

				LuaForUtil.ClearLinePrefixSymbol(arg_623_1.text_)

				local var_626_6 = 28 <= 0 and var_626_3 or var_626_3 * (utf8.len(var_626_4) / 28)

				if (28 <= 0 and var_626_3 or var_626_3 * (utf8.len(var_626_4) / 28)) > 0 and var_626_3 < var_626_6 then
					arg_623_1.talkMaxDuration = var_626_6

					if var_626_6 + var_626_2 > arg_623_1.duration_ then
						arg_623_1.duration_ = var_626_6 + var_626_2
					end
				end

				arg_623_1.text_.text = var_626_4
				arg_623_1.typewritter.percent = 0

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(false)
				arg_623_1:RecordContent(arg_623_1.text_.text)
			end

			local var_626_7 = math.max(var_626_3, arg_623_1.talkMaxDuration)

			if var_626_2 <= arg_623_1.time_ and arg_623_1.time_ < var_626_2 + var_626_7 then
				arg_623_1.typewritter.percent = (arg_623_1.time_ - var_626_2) / var_626_7

				arg_623_1.typewritter:SetDirty()
			end

			if arg_623_1.time_ >= var_626_2 + var_626_7 and arg_623_1.time_ < var_626_2 + var_626_7 + arg_626_0 then
				arg_623_1.typewritter.percent = 1

				arg_623_1.typewritter:SetDirty()
				arg_623_1:ShowNextGo(true)
			end
		end

		arg_623_1.nodeConfigList_ = {}

		arg_623_1:InitPlayNodeList()
	end,
	Play424041153 = function(arg_627_0, arg_627_1)
		arg_627_1.time_ = 0
		arg_627_1.frameCnt_ = 0
		arg_627_1.state_ = "playing"
		arg_627_1.curTalkId_ = 424041153
		arg_627_1.duration_ = 8.37

		local var_627_0 = {
			zh = 6.666,
			ja = 8.366
		}
		local var_627_1 = manager.audio:GetLocalizationFlag()

		if var_627_0[var_627_1] ~= nil then
			arg_627_1.duration_ = var_627_0[var_627_1]
		end

		SetActive(arg_627_1.tipsGo_, false)

		function arg_627_1.onSingleLineFinish_()
			arg_627_1.onSingleLineUpdate_ = nil
			arg_627_1.onSingleLineFinish_ = nil
			arg_627_1.state_ = "waiting"
		end

		function arg_627_1.playNext_(arg_629_0)
			if arg_629_0 == 1 then
				arg_627_0:Play424041154(arg_627_1)
			end
		end

		function arg_627_1.onSingleLineUpdate_(arg_630_0)
			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 and not isNil(arg_627_1.actors_["10154"]) and arg_627_1.var_.actorSpriteComps10154 == nil then
				arg_627_1.var_.actorSpriteComps10154 = arg_627_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_630_0 = 0.2

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_0 and not isNil(arg_627_1.actors_["10154"]) then
				if arg_627_1.var_.actorSpriteComps10154 then
					for iter_630_0, iter_630_1 in pairs(arg_627_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_630_1 then
							if arg_627_1.isInRecall_ then
								iter_630_1.color = Color.New(Mathf.Lerp(iter_630_1.color.r, arg_627_1.hightColor1.r, (arg_627_1.time_ - 0) / var_630_0), Mathf.Lerp(iter_630_1.color.g, arg_627_1.hightColor1.g, (arg_627_1.time_ - 0) / var_630_0), (Mathf.Lerp(iter_630_1.color.b, arg_627_1.hightColor1.b, (arg_627_1.time_ - 0) / var_630_0)))
							else
								local var_630_1 = Mathf.Lerp(iter_630_1.color.r, 1, (arg_627_1.time_ - 0) / var_630_0)

								iter_630_1.color = Color.New(var_630_1, var_630_1, var_630_1)
							end
						end
					end
				end
			end

			if arg_627_1.time_ >= 0 + var_630_0 and arg_627_1.time_ < 0 + var_630_0 + arg_630_0 and not isNil(arg_627_1.actors_["10154"]) and arg_627_1.var_.actorSpriteComps10154 then
				for iter_630_2, iter_630_3 in pairs(arg_627_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_630_3 then
						iter_630_3.color = arg_627_1.isInRecall_ and (arg_627_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_627_1.var_.actorSpriteComps10154 = nil
			end

			local var_630_2 = arg_627_1.actors_["10154"].transform

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= 0 + arg_630_0 then
				arg_627_1.var_.moveOldPos10154 = var_630_2.localPosition
				var_630_2.localScale = Vector3.New(1, 1, 1)

				arg_627_1:CheckSpriteTmpPos("10154", 3)

				for iter_630_4 = 0, var_630_2.childCount - 1 do
					local var_630_3 = var_630_2:GetChild(iter_630_4)

					if var_630_3.name == "" or not string.find(var_630_3.name, "split") then
						var_630_3.gameObject:SetActive(true)
					else
						var_630_3.gameObject:SetActive(false)
					end
				end
			end

			local var_630_4 = 0.001

			if 0 <= arg_627_1.time_ and arg_627_1.time_ < 0 + var_630_4 then
				var_630_2.localPosition = Vector3.Lerp(arg_627_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_627_1.time_ - 0) / var_630_4)
			end

			if arg_627_1.time_ >= 0 + var_630_4 and arg_627_1.time_ < 0 + var_630_4 + arg_630_0 then
				var_630_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_630_5 = 0
			local var_630_6 = 0.975

			if 0 < arg_627_1.time_ and arg_627_1.time_ <= var_630_5 + arg_630_0 then
				arg_627_1.talkMaxDuration = 0
				arg_627_1.dialogCg_.alpha = 1

				arg_627_1.dialog_:SetActive(true)
				SetActive(arg_627_1.leftNameGo_, true)

				arg_627_1.leftNameTxt_.text = arg_627_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_627_1.leftNameTxt_.transform)

				arg_627_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_627_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_627_1:RecordName(arg_627_1.leftNameTxt_.text)
				SetActive(arg_627_1.iconTrs_.gameObject, false)
				arg_627_1.callingController_:SetSelectedState("normal")

				local var_630_7 = arg_627_1:GetWordFromCfg(424041153)
				local var_630_8 = arg_627_1:FormatText(var_630_7.content)

				arg_627_1.text_.text = var_630_8

				LuaForUtil.ClearLinePrefixSymbol(arg_627_1.text_)

				local var_630_10 = 39 <= 0 and var_630_6 or var_630_6 * (utf8.len(var_630_8) / 39)

				if (39 <= 0 and var_630_6 or var_630_6 * (utf8.len(var_630_8) / 39)) > 0 and var_630_6 < var_630_10 then
					arg_627_1.talkMaxDuration = var_630_10

					if var_630_10 + var_630_5 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_10 + var_630_5
					end
				end

				arg_627_1.text_.text = var_630_8
				arg_627_1.typewritter.percent = 0

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041153", "story_v_out_424041.awb") ~= 0 then
					local var_630_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041153", "story_v_out_424041.awb") / 1000

					if var_630_11 + var_630_5 > arg_627_1.duration_ then
						arg_627_1.duration_ = var_630_11 + var_630_5
					end

					if var_630_7.prefab_name ~= "" and arg_627_1.actors_[var_630_7.prefab_name] ~= nil then
						local var_630_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_627_1.actors_[var_630_7.prefab_name].transform, "story_v_out_424041", "424041153", "story_v_out_424041.awb")

						arg_627_1:RecordAudio("424041153", var_630_12)
						arg_627_1:RecordAudio("424041153", var_630_12)
					else
						arg_627_1:AudioAction("play", "voice", "story_v_out_424041", "424041153", "story_v_out_424041.awb")
					end

					arg_627_1:RecordHistoryTalkVoice("story_v_out_424041", "424041153", "story_v_out_424041.awb")
				end

				arg_627_1:RecordContent(arg_627_1.text_.text)
			end

			local var_630_13 = math.max(var_630_6, arg_627_1.talkMaxDuration)

			if var_630_5 <= arg_627_1.time_ and arg_627_1.time_ < var_630_5 + var_630_13 then
				arg_627_1.typewritter.percent = (arg_627_1.time_ - var_630_5) / var_630_13

				arg_627_1.typewritter:SetDirty()
			end

			if arg_627_1.time_ >= var_630_5 + var_630_13 and arg_627_1.time_ < var_630_5 + var_630_13 + arg_630_0 then
				arg_627_1.typewritter.percent = 1

				arg_627_1.typewritter:SetDirty()
				arg_627_1:ShowNextGo(true)
			end
		end

		arg_627_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_627_1:InitPlayNodeList()
	end,
	Play424041154 = function(arg_631_0, arg_631_1)
		arg_631_1.time_ = 0
		arg_631_1.frameCnt_ = 0
		arg_631_1.state_ = "playing"
		arg_631_1.curTalkId_ = 424041154
		arg_631_1.duration_ = 5

		SetActive(arg_631_1.tipsGo_, false)

		function arg_631_1.onSingleLineFinish_()
			arg_631_1.onSingleLineUpdate_ = nil
			arg_631_1.onSingleLineFinish_ = nil
			arg_631_1.state_ = "waiting"
		end

		function arg_631_1.playNext_(arg_633_0)
			if arg_633_0 == 1 then
				arg_631_0:Play424041155(arg_631_1)
			end
		end

		function arg_631_1.onSingleLineUpdate_(arg_634_0)
			if 0 < arg_631_1.time_ and arg_631_1.time_ <= 0 + arg_634_0 and not isNil(arg_631_1.actors_["10154"]) and arg_631_1.var_.actorSpriteComps10154 == nil then
				arg_631_1.var_.actorSpriteComps10154 = arg_631_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_634_0 = 0.2

			if 0 <= arg_631_1.time_ and arg_631_1.time_ < 0 + var_634_0 and not isNil(arg_631_1.actors_["10154"]) then
				if arg_631_1.var_.actorSpriteComps10154 then
					for iter_634_0, iter_634_1 in pairs(arg_631_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_634_1 then
							if arg_631_1.isInRecall_ then
								iter_634_1.color = Color.New(Mathf.Lerp(iter_634_1.color.r, arg_631_1.hightColor2.r, (arg_631_1.time_ - 0) / var_634_0), Mathf.Lerp(iter_634_1.color.g, arg_631_1.hightColor2.g, (arg_631_1.time_ - 0) / var_634_0), (Mathf.Lerp(iter_634_1.color.b, arg_631_1.hightColor2.b, (arg_631_1.time_ - 0) / var_634_0)))
							else
								local var_634_1 = Mathf.Lerp(iter_634_1.color.r, 0.5, (arg_631_1.time_ - 0) / var_634_0)

								iter_634_1.color = Color.New(var_634_1, var_634_1, var_634_1)
							end
						end
					end
				end
			end

			if arg_631_1.time_ >= 0 + var_634_0 and arg_631_1.time_ < 0 + var_634_0 + arg_634_0 and not isNil(arg_631_1.actors_["10154"]) and arg_631_1.var_.actorSpriteComps10154 then
				for iter_634_2, iter_634_3 in pairs(arg_631_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_634_3 then
						iter_634_3.color = arg_631_1.isInRecall_ and (arg_631_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_631_1.var_.actorSpriteComps10154 = nil
			end

			local var_634_2 = 0
			local var_634_3 = 0.325

			if 0 < arg_631_1.time_ and arg_631_1.time_ <= var_634_2 + arg_634_0 then
				arg_631_1.talkMaxDuration = 0
				arg_631_1.dialogCg_.alpha = 1

				arg_631_1.dialog_:SetActive(true)
				SetActive(arg_631_1.leftNameGo_, true)

				arg_631_1.leftNameTxt_.text = arg_631_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_631_1.leftNameTxt_.transform)

				arg_631_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_631_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_631_1:RecordName(arg_631_1.leftNameTxt_.text)
				SetActive(arg_631_1.iconTrs_.gameObject, true)
				arg_631_1.iconController_:SetSelectedState("hero")

				arg_631_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_631_1.callingController_:SetSelectedState("normal")

				arg_631_1.keyicon_.color = Color.New(1, 1, 1)
				arg_631_1.icon_.color = Color.New(1, 1, 1)

				local var_634_4 = arg_631_1:FormatText(arg_631_1:GetWordFromCfg(424041154).content)

				arg_631_1.text_.text = var_634_4

				LuaForUtil.ClearLinePrefixSymbol(arg_631_1.text_)

				local var_634_6 = 13 <= 0 and var_634_3 or var_634_3 * (utf8.len(var_634_4) / 13)

				if (13 <= 0 and var_634_3 or var_634_3 * (utf8.len(var_634_4) / 13)) > 0 and var_634_3 < var_634_6 then
					arg_631_1.talkMaxDuration = var_634_6

					if var_634_6 + var_634_2 > arg_631_1.duration_ then
						arg_631_1.duration_ = var_634_6 + var_634_2
					end
				end

				arg_631_1.text_.text = var_634_4
				arg_631_1.typewritter.percent = 0

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(false)
				arg_631_1:RecordContent(arg_631_1.text_.text)
			end

			local var_634_7 = math.max(var_634_3, arg_631_1.talkMaxDuration)

			if var_634_2 <= arg_631_1.time_ and arg_631_1.time_ < var_634_2 + var_634_7 then
				arg_631_1.typewritter.percent = (arg_631_1.time_ - var_634_2) / var_634_7

				arg_631_1.typewritter:SetDirty()
			end

			if arg_631_1.time_ >= var_634_2 + var_634_7 and arg_631_1.time_ < var_634_2 + var_634_7 + arg_634_0 then
				arg_631_1.typewritter.percent = 1

				arg_631_1.typewritter:SetDirty()
				arg_631_1:ShowNextGo(true)
			end
		end

		arg_631_1.nodeConfigList_ = {}

		arg_631_1:InitPlayNodeList()
	end,
	Play424041155 = function(arg_635_0, arg_635_1)
		arg_635_1.time_ = 0
		arg_635_1.frameCnt_ = 0
		arg_635_1.state_ = "playing"
		arg_635_1.curTalkId_ = 424041155
		arg_635_1.duration_ = 5

		SetActive(arg_635_1.tipsGo_, false)

		function arg_635_1.onSingleLineFinish_()
			arg_635_1.onSingleLineUpdate_ = nil
			arg_635_1.onSingleLineFinish_ = nil
			arg_635_1.state_ = "waiting"
		end

		function arg_635_1.playNext_(arg_637_0)
			if arg_637_0 == 1 then
				arg_635_0:Play424041156(arg_635_1)
			end
		end

		function arg_635_1.onSingleLineUpdate_(arg_638_0)
			local var_638_0 = 0.95

			if 0 < arg_635_1.time_ and arg_635_1.time_ <= 0 + arg_638_0 then
				arg_635_1.talkMaxDuration = 0
				arg_635_1.dialogCg_.alpha = 1

				arg_635_1.dialog_:SetActive(true)
				SetActive(arg_635_1.leftNameGo_, true)

				arg_635_1.leftNameTxt_.text = arg_635_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_635_1.leftNameTxt_.transform)

				arg_635_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_635_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_635_1:RecordName(arg_635_1.leftNameTxt_.text)
				SetActive(arg_635_1.iconTrs_.gameObject, true)
				arg_635_1.iconController_:SetSelectedState("hero")

				arg_635_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_635_1.callingController_:SetSelectedState("normal")

				arg_635_1.keyicon_.color = Color.New(1, 1, 1)
				arg_635_1.icon_.color = Color.New(1, 1, 1)

				local var_638_1 = arg_635_1:FormatText(arg_635_1:GetWordFromCfg(424041155).content)

				arg_635_1.text_.text = var_638_1

				LuaForUtil.ClearLinePrefixSymbol(arg_635_1.text_)

				local var_638_3 = 38 <= 0 and var_638_0 or var_638_0 * (utf8.len(var_638_1) / 38)

				if (38 <= 0 and var_638_0 or var_638_0 * (utf8.len(var_638_1) / 38)) > 0 and var_638_0 < var_638_3 then
					arg_635_1.talkMaxDuration = var_638_3

					if var_638_3 + 0 > arg_635_1.duration_ then
						arg_635_1.duration_ = var_638_3 + 0
					end
				end

				arg_635_1.text_.text = var_638_1
				arg_635_1.typewritter.percent = 0

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(false)
				arg_635_1:RecordContent(arg_635_1.text_.text)
			end

			local var_638_4 = math.max(var_638_0, arg_635_1.talkMaxDuration)

			if 0 <= arg_635_1.time_ and arg_635_1.time_ < 0 + var_638_4 then
				arg_635_1.typewritter.percent = (arg_635_1.time_ - 0) / var_638_4

				arg_635_1.typewritter:SetDirty()
			end

			if arg_635_1.time_ >= 0 + var_638_4 and arg_635_1.time_ < 0 + var_638_4 + arg_638_0 then
				arg_635_1.typewritter.percent = 1

				arg_635_1.typewritter:SetDirty()
				arg_635_1:ShowNextGo(true)
			end
		end

		arg_635_1.nodeConfigList_ = {}

		arg_635_1:InitPlayNodeList()
	end,
	Play424041156 = function(arg_639_0, arg_639_1)
		arg_639_1.time_ = 0
		arg_639_1.frameCnt_ = 0
		arg_639_1.state_ = "playing"
		arg_639_1.curTalkId_ = 424041156
		arg_639_1.duration_ = 7.1

		local var_639_0 = {
			zh = 6.433,
			ja = 7.1
		}
		local var_639_1 = manager.audio:GetLocalizationFlag()

		if var_639_0[var_639_1] ~= nil then
			arg_639_1.duration_ = var_639_0[var_639_1]
		end

		SetActive(arg_639_1.tipsGo_, false)

		function arg_639_1.onSingleLineFinish_()
			arg_639_1.onSingleLineUpdate_ = nil
			arg_639_1.onSingleLineFinish_ = nil
			arg_639_1.state_ = "waiting"
		end

		function arg_639_1.playNext_(arg_641_0)
			if arg_641_0 == 1 then
				arg_639_0:Play424041157(arg_639_1)
			end
		end

		function arg_639_1.onSingleLineUpdate_(arg_642_0)
			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 and not isNil(arg_639_1.actors_["10154"]) and arg_639_1.var_.actorSpriteComps10154 == nil then
				arg_639_1.var_.actorSpriteComps10154 = arg_639_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_642_0 = 0.2

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_0 and not isNil(arg_639_1.actors_["10154"]) then
				if arg_639_1.var_.actorSpriteComps10154 then
					for iter_642_0, iter_642_1 in pairs(arg_639_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_642_1 then
							if arg_639_1.isInRecall_ then
								iter_642_1.color = Color.New(Mathf.Lerp(iter_642_1.color.r, arg_639_1.hightColor1.r, (arg_639_1.time_ - 0) / var_642_0), Mathf.Lerp(iter_642_1.color.g, arg_639_1.hightColor1.g, (arg_639_1.time_ - 0) / var_642_0), (Mathf.Lerp(iter_642_1.color.b, arg_639_1.hightColor1.b, (arg_639_1.time_ - 0) / var_642_0)))
							else
								local var_642_1 = Mathf.Lerp(iter_642_1.color.r, 1, (arg_639_1.time_ - 0) / var_642_0)

								iter_642_1.color = Color.New(var_642_1, var_642_1, var_642_1)
							end
						end
					end
				end
			end

			if arg_639_1.time_ >= 0 + var_642_0 and arg_639_1.time_ < 0 + var_642_0 + arg_642_0 and not isNil(arg_639_1.actors_["10154"]) and arg_639_1.var_.actorSpriteComps10154 then
				for iter_642_2, iter_642_3 in pairs(arg_639_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_642_3 then
						iter_642_3.color = arg_639_1.isInRecall_ and (arg_639_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_639_1.var_.actorSpriteComps10154 = nil
			end

			local var_642_2 = arg_639_1.actors_["10154"].transform

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= 0 + arg_642_0 then
				arg_639_1.var_.moveOldPos10154 = var_642_2.localPosition
				var_642_2.localScale = Vector3.New(1, 1, 1)

				arg_639_1:CheckSpriteTmpPos("10154", 3)

				for iter_642_4 = 0, var_642_2.childCount - 1 do
					local var_642_3 = var_642_2:GetChild(iter_642_4)

					if var_642_3.name == "" or not string.find(var_642_3.name, "split") then
						var_642_3.gameObject:SetActive(true)
					else
						var_642_3.gameObject:SetActive(false)
					end
				end
			end

			local var_642_4 = 0.001

			if 0 <= arg_639_1.time_ and arg_639_1.time_ < 0 + var_642_4 then
				var_642_2.localPosition = Vector3.Lerp(arg_639_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_639_1.time_ - 0) / var_642_4)
			end

			if arg_639_1.time_ >= 0 + var_642_4 and arg_639_1.time_ < 0 + var_642_4 + arg_642_0 then
				var_642_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_642_5 = 0
			local var_642_6 = 0.875

			if 0 < arg_639_1.time_ and arg_639_1.time_ <= var_642_5 + arg_642_0 then
				arg_639_1.talkMaxDuration = 0
				arg_639_1.dialogCg_.alpha = 1

				arg_639_1.dialog_:SetActive(true)
				SetActive(arg_639_1.leftNameGo_, true)

				arg_639_1.leftNameTxt_.text = arg_639_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_639_1.leftNameTxt_.transform)

				arg_639_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_639_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_639_1:RecordName(arg_639_1.leftNameTxt_.text)
				SetActive(arg_639_1.iconTrs_.gameObject, false)
				arg_639_1.callingController_:SetSelectedState("normal")

				local var_642_7 = arg_639_1:GetWordFromCfg(424041156)
				local var_642_8 = arg_639_1:FormatText(var_642_7.content)

				arg_639_1.text_.text = var_642_8

				LuaForUtil.ClearLinePrefixSymbol(arg_639_1.text_)

				local var_642_10 = 35 <= 0 and var_642_6 or var_642_6 * (utf8.len(var_642_8) / 35)

				if (35 <= 0 and var_642_6 or var_642_6 * (utf8.len(var_642_8) / 35)) > 0 and var_642_6 < var_642_10 then
					arg_639_1.talkMaxDuration = var_642_10

					if var_642_10 + var_642_5 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_10 + var_642_5
					end
				end

				arg_639_1.text_.text = var_642_8
				arg_639_1.typewritter.percent = 0

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041156", "story_v_out_424041.awb") ~= 0 then
					local var_642_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041156", "story_v_out_424041.awb") / 1000

					if var_642_11 + var_642_5 > arg_639_1.duration_ then
						arg_639_1.duration_ = var_642_11 + var_642_5
					end

					if var_642_7.prefab_name ~= "" and arg_639_1.actors_[var_642_7.prefab_name] ~= nil then
						local var_642_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_639_1.actors_[var_642_7.prefab_name].transform, "story_v_out_424041", "424041156", "story_v_out_424041.awb")

						arg_639_1:RecordAudio("424041156", var_642_12)
						arg_639_1:RecordAudio("424041156", var_642_12)
					else
						arg_639_1:AudioAction("play", "voice", "story_v_out_424041", "424041156", "story_v_out_424041.awb")
					end

					arg_639_1:RecordHistoryTalkVoice("story_v_out_424041", "424041156", "story_v_out_424041.awb")
				end

				arg_639_1:RecordContent(arg_639_1.text_.text)
			end

			local var_642_13 = math.max(var_642_6, arg_639_1.talkMaxDuration)

			if var_642_5 <= arg_639_1.time_ and arg_639_1.time_ < var_642_5 + var_642_13 then
				arg_639_1.typewritter.percent = (arg_639_1.time_ - var_642_5) / var_642_13

				arg_639_1.typewritter:SetDirty()
			end

			if arg_639_1.time_ >= var_642_5 + var_642_13 and arg_639_1.time_ < var_642_5 + var_642_13 + arg_642_0 then
				arg_639_1.typewritter.percent = 1

				arg_639_1.typewritter:SetDirty()
				arg_639_1:ShowNextGo(true)
			end
		end

		arg_639_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_639_1:InitPlayNodeList()
	end,
	Play424041157 = function(arg_643_0, arg_643_1)
		arg_643_1.time_ = 0
		arg_643_1.frameCnt_ = 0
		arg_643_1.state_ = "playing"
		arg_643_1.curTalkId_ = 424041157
		arg_643_1.duration_ = 5

		SetActive(arg_643_1.tipsGo_, false)

		function arg_643_1.onSingleLineFinish_()
			arg_643_1.onSingleLineUpdate_ = nil
			arg_643_1.onSingleLineFinish_ = nil
			arg_643_1.state_ = "waiting"
		end

		function arg_643_1.playNext_(arg_645_0)
			if arg_645_0 == 1 then
				arg_643_0:Play424041158(arg_643_1)
			end
		end

		function arg_643_1.onSingleLineUpdate_(arg_646_0)
			if 0 < arg_643_1.time_ and arg_643_1.time_ <= 0 + arg_646_0 and not isNil(arg_643_1.actors_["10154"]) and arg_643_1.var_.actorSpriteComps10154 == nil then
				arg_643_1.var_.actorSpriteComps10154 = arg_643_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_646_0 = 0.2

			if 0 <= arg_643_1.time_ and arg_643_1.time_ < 0 + var_646_0 and not isNil(arg_643_1.actors_["10154"]) then
				if arg_643_1.var_.actorSpriteComps10154 then
					for iter_646_0, iter_646_1 in pairs(arg_643_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_646_1 then
							if arg_643_1.isInRecall_ then
								iter_646_1.color = Color.New(Mathf.Lerp(iter_646_1.color.r, arg_643_1.hightColor2.r, (arg_643_1.time_ - 0) / var_646_0), Mathf.Lerp(iter_646_1.color.g, arg_643_1.hightColor2.g, (arg_643_1.time_ - 0) / var_646_0), (Mathf.Lerp(iter_646_1.color.b, arg_643_1.hightColor2.b, (arg_643_1.time_ - 0) / var_646_0)))
							else
								local var_646_1 = Mathf.Lerp(iter_646_1.color.r, 0.5, (arg_643_1.time_ - 0) / var_646_0)

								iter_646_1.color = Color.New(var_646_1, var_646_1, var_646_1)
							end
						end
					end
				end
			end

			if arg_643_1.time_ >= 0 + var_646_0 and arg_643_1.time_ < 0 + var_646_0 + arg_646_0 and not isNil(arg_643_1.actors_["10154"]) and arg_643_1.var_.actorSpriteComps10154 then
				for iter_646_2, iter_646_3 in pairs(arg_643_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_646_3 then
						iter_646_3.color = arg_643_1.isInRecall_ and (arg_643_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_643_1.var_.actorSpriteComps10154 = nil
			end

			local var_646_2 = 0
			local var_646_3 = 0.975

			if 0 < arg_643_1.time_ and arg_643_1.time_ <= var_646_2 + arg_646_0 then
				arg_643_1.talkMaxDuration = 0
				arg_643_1.dialogCg_.alpha = 1

				arg_643_1.dialog_:SetActive(true)
				SetActive(arg_643_1.leftNameGo_, true)

				arg_643_1.leftNameTxt_.text = arg_643_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_643_1.leftNameTxt_.transform)

				arg_643_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_643_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_643_1:RecordName(arg_643_1.leftNameTxt_.text)
				SetActive(arg_643_1.iconTrs_.gameObject, true)
				arg_643_1.iconController_:SetSelectedState("hero")

				arg_643_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_643_1.callingController_:SetSelectedState("normal")

				arg_643_1.keyicon_.color = Color.New(1, 1, 1)
				arg_643_1.icon_.color = Color.New(1, 1, 1)

				local var_646_4 = arg_643_1:FormatText(arg_643_1:GetWordFromCfg(424041157).content)

				arg_643_1.text_.text = var_646_4

				LuaForUtil.ClearLinePrefixSymbol(arg_643_1.text_)

				local var_646_6 = 39 <= 0 and var_646_3 or var_646_3 * (utf8.len(var_646_4) / 39)

				if (39 <= 0 and var_646_3 or var_646_3 * (utf8.len(var_646_4) / 39)) > 0 and var_646_3 < var_646_6 then
					arg_643_1.talkMaxDuration = var_646_6

					if var_646_6 + var_646_2 > arg_643_1.duration_ then
						arg_643_1.duration_ = var_646_6 + var_646_2
					end
				end

				arg_643_1.text_.text = var_646_4
				arg_643_1.typewritter.percent = 0

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(false)
				arg_643_1:RecordContent(arg_643_1.text_.text)
			end

			local var_646_7 = math.max(var_646_3, arg_643_1.talkMaxDuration)

			if var_646_2 <= arg_643_1.time_ and arg_643_1.time_ < var_646_2 + var_646_7 then
				arg_643_1.typewritter.percent = (arg_643_1.time_ - var_646_2) / var_646_7

				arg_643_1.typewritter:SetDirty()
			end

			if arg_643_1.time_ >= var_646_2 + var_646_7 and arg_643_1.time_ < var_646_2 + var_646_7 + arg_646_0 then
				arg_643_1.typewritter.percent = 1

				arg_643_1.typewritter:SetDirty()
				arg_643_1:ShowNextGo(true)
			end
		end

		arg_643_1.nodeConfigList_ = {}

		arg_643_1:InitPlayNodeList()
	end,
	Play424041158 = function(arg_647_0, arg_647_1)
		arg_647_1.time_ = 0
		arg_647_1.frameCnt_ = 0
		arg_647_1.state_ = "playing"
		arg_647_1.curTalkId_ = 424041158
		arg_647_1.duration_ = 5

		SetActive(arg_647_1.tipsGo_, false)

		function arg_647_1.onSingleLineFinish_()
			arg_647_1.onSingleLineUpdate_ = nil
			arg_647_1.onSingleLineFinish_ = nil
			arg_647_1.state_ = "waiting"
		end

		function arg_647_1.playNext_(arg_649_0)
			if arg_649_0 == 1 then
				arg_647_0:Play424041159(arg_647_1)
			end
		end

		function arg_647_1.onSingleLineUpdate_(arg_650_0)
			local var_650_0 = 1.075

			if 0 < arg_647_1.time_ and arg_647_1.time_ <= 0 + arg_650_0 then
				arg_647_1.talkMaxDuration = 0
				arg_647_1.dialogCg_.alpha = 1

				arg_647_1.dialog_:SetActive(true)
				SetActive(arg_647_1.leftNameGo_, false)

				arg_647_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_647_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_647_1:RecordName(arg_647_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_647_1.iconTrs_.gameObject, false)
				arg_647_1.callingController_:SetSelectedState("normal")

				local var_650_1 = arg_647_1:FormatText(arg_647_1:GetWordFromCfg(424041158).content)

				arg_647_1.text_.text = var_650_1

				LuaForUtil.ClearLinePrefixSymbol(arg_647_1.text_)

				local var_650_3 = 43 <= 0 and var_650_0 or var_650_0 * (utf8.len(var_650_1) / 43)

				if (43 <= 0 and var_650_0 or var_650_0 * (utf8.len(var_650_1) / 43)) > 0 and var_650_0 < var_650_3 then
					arg_647_1.talkMaxDuration = var_650_3

					if var_650_3 + 0 > arg_647_1.duration_ then
						arg_647_1.duration_ = var_650_3 + 0
					end
				end

				arg_647_1.text_.text = var_650_1
				arg_647_1.typewritter.percent = 0

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(false)
				arg_647_1:RecordContent(arg_647_1.text_.text)
			end

			local var_650_4 = math.max(var_650_0, arg_647_1.talkMaxDuration)

			if 0 <= arg_647_1.time_ and arg_647_1.time_ < 0 + var_650_4 then
				arg_647_1.typewritter.percent = (arg_647_1.time_ - 0) / var_650_4

				arg_647_1.typewritter:SetDirty()
			end

			if arg_647_1.time_ >= 0 + var_650_4 and arg_647_1.time_ < 0 + var_650_4 + arg_650_0 then
				arg_647_1.typewritter.percent = 1

				arg_647_1.typewritter:SetDirty()
				arg_647_1:ShowNextGo(true)
			end
		end

		arg_647_1.nodeConfigList_ = {}

		arg_647_1:InitPlayNodeList()
	end,
	Play424041159 = function(arg_651_0, arg_651_1)
		arg_651_1.time_ = 0
		arg_651_1.frameCnt_ = 0
		arg_651_1.state_ = "playing"
		arg_651_1.curTalkId_ = 424041159
		arg_651_1.duration_ = 5

		SetActive(arg_651_1.tipsGo_, false)

		function arg_651_1.onSingleLineFinish_()
			arg_651_1.onSingleLineUpdate_ = nil
			arg_651_1.onSingleLineFinish_ = nil
			arg_651_1.state_ = "waiting"
		end

		function arg_651_1.playNext_(arg_653_0)
			if arg_653_0 == 1 then
				arg_651_0:Play424041160(arg_651_1)
			end
		end

		function arg_651_1.onSingleLineUpdate_(arg_654_0)
			local var_654_0 = 0.625

			if 0 < arg_651_1.time_ and arg_651_1.time_ <= 0 + arg_654_0 then
				arg_651_1.talkMaxDuration = 0
				arg_651_1.dialogCg_.alpha = 1

				arg_651_1.dialog_:SetActive(true)
				SetActive(arg_651_1.leftNameGo_, true)

				arg_651_1.leftNameTxt_.text = arg_651_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_651_1.leftNameTxt_.transform)

				arg_651_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_651_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_651_1:RecordName(arg_651_1.leftNameTxt_.text)
				SetActive(arg_651_1.iconTrs_.gameObject, true)
				arg_651_1.iconController_:SetSelectedState("hero")

				arg_651_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_651_1.callingController_:SetSelectedState("normal")

				arg_651_1.keyicon_.color = Color.New(1, 1, 1)
				arg_651_1.icon_.color = Color.New(1, 1, 1)

				local var_654_1 = arg_651_1:FormatText(arg_651_1:GetWordFromCfg(424041159).content)

				arg_651_1.text_.text = var_654_1

				LuaForUtil.ClearLinePrefixSymbol(arg_651_1.text_)

				local var_654_3 = 25 <= 0 and var_654_0 or var_654_0 * (utf8.len(var_654_1) / 25)

				if (25 <= 0 and var_654_0 or var_654_0 * (utf8.len(var_654_1) / 25)) > 0 and var_654_0 < var_654_3 then
					arg_651_1.talkMaxDuration = var_654_3

					if var_654_3 + 0 > arg_651_1.duration_ then
						arg_651_1.duration_ = var_654_3 + 0
					end
				end

				arg_651_1.text_.text = var_654_1
				arg_651_1.typewritter.percent = 0

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(false)
				arg_651_1:RecordContent(arg_651_1.text_.text)
			end

			local var_654_4 = math.max(var_654_0, arg_651_1.talkMaxDuration)

			if 0 <= arg_651_1.time_ and arg_651_1.time_ < 0 + var_654_4 then
				arg_651_1.typewritter.percent = (arg_651_1.time_ - 0) / var_654_4

				arg_651_1.typewritter:SetDirty()
			end

			if arg_651_1.time_ >= 0 + var_654_4 and arg_651_1.time_ < 0 + var_654_4 + arg_654_0 then
				arg_651_1.typewritter.percent = 1

				arg_651_1.typewritter:SetDirty()
				arg_651_1:ShowNextGo(true)
			end
		end

		arg_651_1.nodeConfigList_ = {}

		arg_651_1:InitPlayNodeList()
	end,
	Play424041160 = function(arg_655_0, arg_655_1)
		arg_655_1.time_ = 0
		arg_655_1.frameCnt_ = 0
		arg_655_1.state_ = "playing"
		arg_655_1.curTalkId_ = 424041160
		arg_655_1.duration_ = 6.7

		local var_655_0 = {
			zh = 5.566,
			ja = 6.7
		}
		local var_655_1 = manager.audio:GetLocalizationFlag()

		if var_655_0[var_655_1] ~= nil then
			arg_655_1.duration_ = var_655_0[var_655_1]
		end

		SetActive(arg_655_1.tipsGo_, false)

		function arg_655_1.onSingleLineFinish_()
			arg_655_1.onSingleLineUpdate_ = nil
			arg_655_1.onSingleLineFinish_ = nil
			arg_655_1.state_ = "waiting"
		end

		function arg_655_1.playNext_(arg_657_0)
			if arg_657_0 == 1 then
				arg_655_0:Play424041161(arg_655_1)
			end
		end

		function arg_655_1.onSingleLineUpdate_(arg_658_0)
			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 and not isNil(arg_655_1.actors_["10154"]) and arg_655_1.var_.actorSpriteComps10154 == nil then
				arg_655_1.var_.actorSpriteComps10154 = arg_655_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_658_0 = 0.2

			if 0 <= arg_655_1.time_ and arg_655_1.time_ < 0 + var_658_0 and not isNil(arg_655_1.actors_["10154"]) then
				if arg_655_1.var_.actorSpriteComps10154 then
					for iter_658_0, iter_658_1 in pairs(arg_655_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_658_1 then
							if arg_655_1.isInRecall_ then
								iter_658_1.color = Color.New(Mathf.Lerp(iter_658_1.color.r, arg_655_1.hightColor1.r, (arg_655_1.time_ - 0) / var_658_0), Mathf.Lerp(iter_658_1.color.g, arg_655_1.hightColor1.g, (arg_655_1.time_ - 0) / var_658_0), (Mathf.Lerp(iter_658_1.color.b, arg_655_1.hightColor1.b, (arg_655_1.time_ - 0) / var_658_0)))
							else
								local var_658_1 = Mathf.Lerp(iter_658_1.color.r, 1, (arg_655_1.time_ - 0) / var_658_0)

								iter_658_1.color = Color.New(var_658_1, var_658_1, var_658_1)
							end
						end
					end
				end
			end

			if arg_655_1.time_ >= 0 + var_658_0 and arg_655_1.time_ < 0 + var_658_0 + arg_658_0 and not isNil(arg_655_1.actors_["10154"]) and arg_655_1.var_.actorSpriteComps10154 then
				for iter_658_2, iter_658_3 in pairs(arg_655_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_658_3 then
						iter_658_3.color = arg_655_1.isInRecall_ and (arg_655_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_655_1.var_.actorSpriteComps10154 = nil
			end

			local var_658_2 = arg_655_1.actors_["10154"].transform

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= 0 + arg_658_0 then
				arg_655_1.var_.moveOldPos10154 = var_658_2.localPosition
				var_658_2.localScale = Vector3.New(1, 1, 1)

				arg_655_1:CheckSpriteTmpPos("10154", 3)

				for iter_658_4 = 0, var_658_2.childCount - 1 do
					local var_658_3 = var_658_2:GetChild(iter_658_4)

					if var_658_3.name == "split_1" or not string.find(var_658_3.name, "split") then
						var_658_3.gameObject:SetActive(true)
					else
						var_658_3.gameObject:SetActive(false)
					end
				end
			end

			local var_658_4 = 0.001

			if 0 <= arg_655_1.time_ and arg_655_1.time_ < 0 + var_658_4 then
				var_658_2.localPosition = Vector3.Lerp(arg_655_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_655_1.time_ - 0) / var_658_4)
			end

			if arg_655_1.time_ >= 0 + var_658_4 and arg_655_1.time_ < 0 + var_658_4 + arg_658_0 then
				var_658_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_658_5 = 0
			local var_658_6 = 0.675

			if 0 < arg_655_1.time_ and arg_655_1.time_ <= var_658_5 + arg_658_0 then
				arg_655_1.talkMaxDuration = 0
				arg_655_1.dialogCg_.alpha = 1

				arg_655_1.dialog_:SetActive(true)
				SetActive(arg_655_1.leftNameGo_, true)

				arg_655_1.leftNameTxt_.text = arg_655_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_655_1.leftNameTxt_.transform)

				arg_655_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_655_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_655_1:RecordName(arg_655_1.leftNameTxt_.text)
				SetActive(arg_655_1.iconTrs_.gameObject, false)
				arg_655_1.callingController_:SetSelectedState("normal")

				local var_658_7 = arg_655_1:GetWordFromCfg(424041160)
				local var_658_8 = arg_655_1:FormatText(var_658_7.content)

				arg_655_1.text_.text = var_658_8

				LuaForUtil.ClearLinePrefixSymbol(arg_655_1.text_)

				local var_658_10 = 27 <= 0 and var_658_6 or var_658_6 * (utf8.len(var_658_8) / 27)

				if (27 <= 0 and var_658_6 or var_658_6 * (utf8.len(var_658_8) / 27)) > 0 and var_658_6 < var_658_10 then
					arg_655_1.talkMaxDuration = var_658_10

					if var_658_10 + var_658_5 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_10 + var_658_5
					end
				end

				arg_655_1.text_.text = var_658_8
				arg_655_1.typewritter.percent = 0

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041160", "story_v_out_424041.awb") ~= 0 then
					local var_658_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041160", "story_v_out_424041.awb") / 1000

					if var_658_11 + var_658_5 > arg_655_1.duration_ then
						arg_655_1.duration_ = var_658_11 + var_658_5
					end

					if var_658_7.prefab_name ~= "" and arg_655_1.actors_[var_658_7.prefab_name] ~= nil then
						local var_658_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_655_1.actors_[var_658_7.prefab_name].transform, "story_v_out_424041", "424041160", "story_v_out_424041.awb")

						arg_655_1:RecordAudio("424041160", var_658_12)
						arg_655_1:RecordAudio("424041160", var_658_12)
					else
						arg_655_1:AudioAction("play", "voice", "story_v_out_424041", "424041160", "story_v_out_424041.awb")
					end

					arg_655_1:RecordHistoryTalkVoice("story_v_out_424041", "424041160", "story_v_out_424041.awb")
				end

				arg_655_1:RecordContent(arg_655_1.text_.text)
			end

			local var_658_13 = math.max(var_658_6, arg_655_1.talkMaxDuration)

			if var_658_5 <= arg_655_1.time_ and arg_655_1.time_ < var_658_5 + var_658_13 then
				arg_655_1.typewritter.percent = (arg_655_1.time_ - var_658_5) / var_658_13

				arg_655_1.typewritter:SetDirty()
			end

			if arg_655_1.time_ >= var_658_5 + var_658_13 and arg_655_1.time_ < var_658_5 + var_658_13 + arg_658_0 then
				arg_655_1.typewritter.percent = 1

				arg_655_1.typewritter:SetDirty()
				arg_655_1:ShowNextGo(true)
			end
		end

		arg_655_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_655_1:InitPlayNodeList()
	end,
	Play424041161 = function(arg_659_0, arg_659_1)
		arg_659_1.time_ = 0
		arg_659_1.frameCnt_ = 0
		arg_659_1.state_ = "playing"
		arg_659_1.curTalkId_ = 424041161
		arg_659_1.duration_ = 5

		SetActive(arg_659_1.tipsGo_, false)

		function arg_659_1.onSingleLineFinish_()
			arg_659_1.onSingleLineUpdate_ = nil
			arg_659_1.onSingleLineFinish_ = nil
			arg_659_1.state_ = "waiting"
		end

		function arg_659_1.playNext_(arg_661_0)
			if arg_661_0 == 1 then
				arg_659_0:Play424041162(arg_659_1)
			end
		end

		function arg_659_1.onSingleLineUpdate_(arg_662_0)
			if 0 < arg_659_1.time_ and arg_659_1.time_ <= 0 + arg_662_0 and not isNil(arg_659_1.actors_["10154"]) and arg_659_1.var_.actorSpriteComps10154 == nil then
				arg_659_1.var_.actorSpriteComps10154 = arg_659_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_662_0 = 0.2

			if 0 <= arg_659_1.time_ and arg_659_1.time_ < 0 + var_662_0 and not isNil(arg_659_1.actors_["10154"]) then
				if arg_659_1.var_.actorSpriteComps10154 then
					for iter_662_0, iter_662_1 in pairs(arg_659_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_662_1 then
							if arg_659_1.isInRecall_ then
								iter_662_1.color = Color.New(Mathf.Lerp(iter_662_1.color.r, arg_659_1.hightColor2.r, (arg_659_1.time_ - 0) / var_662_0), Mathf.Lerp(iter_662_1.color.g, arg_659_1.hightColor2.g, (arg_659_1.time_ - 0) / var_662_0), (Mathf.Lerp(iter_662_1.color.b, arg_659_1.hightColor2.b, (arg_659_1.time_ - 0) / var_662_0)))
							else
								local var_662_1 = Mathf.Lerp(iter_662_1.color.r, 0.5, (arg_659_1.time_ - 0) / var_662_0)

								iter_662_1.color = Color.New(var_662_1, var_662_1, var_662_1)
							end
						end
					end
				end
			end

			if arg_659_1.time_ >= 0 + var_662_0 and arg_659_1.time_ < 0 + var_662_0 + arg_662_0 and not isNil(arg_659_1.actors_["10154"]) and arg_659_1.var_.actorSpriteComps10154 then
				for iter_662_2, iter_662_3 in pairs(arg_659_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_662_3 then
						iter_662_3.color = arg_659_1.isInRecall_ and (arg_659_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_659_1.var_.actorSpriteComps10154 = nil
			end

			local var_662_2 = 0
			local var_662_3 = 0.875

			if 0 < arg_659_1.time_ and arg_659_1.time_ <= var_662_2 + arg_662_0 then
				arg_659_1.talkMaxDuration = 0
				arg_659_1.dialogCg_.alpha = 1

				arg_659_1.dialog_:SetActive(true)
				SetActive(arg_659_1.leftNameGo_, true)

				arg_659_1.leftNameTxt_.text = arg_659_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_659_1.leftNameTxt_.transform)

				arg_659_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_659_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_659_1:RecordName(arg_659_1.leftNameTxt_.text)
				SetActive(arg_659_1.iconTrs_.gameObject, true)
				arg_659_1.iconController_:SetSelectedState("hero")

				arg_659_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_659_1.callingController_:SetSelectedState("normal")

				arg_659_1.keyicon_.color = Color.New(1, 1, 1)
				arg_659_1.icon_.color = Color.New(1, 1, 1)

				local var_662_4 = arg_659_1:FormatText(arg_659_1:GetWordFromCfg(424041161).content)

				arg_659_1.text_.text = var_662_4

				LuaForUtil.ClearLinePrefixSymbol(arg_659_1.text_)

				local var_662_6 = 35 <= 0 and var_662_3 or var_662_3 * (utf8.len(var_662_4) / 35)

				if (35 <= 0 and var_662_3 or var_662_3 * (utf8.len(var_662_4) / 35)) > 0 and var_662_3 < var_662_6 then
					arg_659_1.talkMaxDuration = var_662_6

					if var_662_6 + var_662_2 > arg_659_1.duration_ then
						arg_659_1.duration_ = var_662_6 + var_662_2
					end
				end

				arg_659_1.text_.text = var_662_4
				arg_659_1.typewritter.percent = 0

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(false)
				arg_659_1:RecordContent(arg_659_1.text_.text)
			end

			local var_662_7 = math.max(var_662_3, arg_659_1.talkMaxDuration)

			if var_662_2 <= arg_659_1.time_ and arg_659_1.time_ < var_662_2 + var_662_7 then
				arg_659_1.typewritter.percent = (arg_659_1.time_ - var_662_2) / var_662_7

				arg_659_1.typewritter:SetDirty()
			end

			if arg_659_1.time_ >= var_662_2 + var_662_7 and arg_659_1.time_ < var_662_2 + var_662_7 + arg_662_0 then
				arg_659_1.typewritter.percent = 1

				arg_659_1.typewritter:SetDirty()
				arg_659_1:ShowNextGo(true)
			end
		end

		arg_659_1.nodeConfigList_ = {}

		arg_659_1:InitPlayNodeList()
	end,
	Play424041162 = function(arg_663_0, arg_663_1)
		arg_663_1.time_ = 0
		arg_663_1.frameCnt_ = 0
		arg_663_1.state_ = "playing"
		arg_663_1.curTalkId_ = 424041162
		arg_663_1.duration_ = 1.23

		local var_663_0 = {
			zh = 1.166,
			ja = 1.233
		}
		local var_663_1 = manager.audio:GetLocalizationFlag()

		if var_663_0[var_663_1] ~= nil then
			arg_663_1.duration_ = var_663_0[var_663_1]
		end

		SetActive(arg_663_1.tipsGo_, false)

		function arg_663_1.onSingleLineFinish_()
			arg_663_1.onSingleLineUpdate_ = nil
			arg_663_1.onSingleLineFinish_ = nil
			arg_663_1.state_ = "waiting"
		end

		function arg_663_1.playNext_(arg_665_0)
			if arg_665_0 == 1 then
				arg_663_0:Play424041163(arg_663_1)
			end
		end

		function arg_663_1.onSingleLineUpdate_(arg_666_0)
			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 and not isNil(arg_663_1.actors_["10154"]) and arg_663_1.var_.actorSpriteComps10154 == nil then
				arg_663_1.var_.actorSpriteComps10154 = arg_663_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_666_0 = 0.2

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_0 and not isNil(arg_663_1.actors_["10154"]) then
				if arg_663_1.var_.actorSpriteComps10154 then
					for iter_666_0, iter_666_1 in pairs(arg_663_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_666_1 then
							if arg_663_1.isInRecall_ then
								iter_666_1.color = Color.New(Mathf.Lerp(iter_666_1.color.r, arg_663_1.hightColor1.r, (arg_663_1.time_ - 0) / var_666_0), Mathf.Lerp(iter_666_1.color.g, arg_663_1.hightColor1.g, (arg_663_1.time_ - 0) / var_666_0), (Mathf.Lerp(iter_666_1.color.b, arg_663_1.hightColor1.b, (arg_663_1.time_ - 0) / var_666_0)))
							else
								local var_666_1 = Mathf.Lerp(iter_666_1.color.r, 1, (arg_663_1.time_ - 0) / var_666_0)

								iter_666_1.color = Color.New(var_666_1, var_666_1, var_666_1)
							end
						end
					end
				end
			end

			if arg_663_1.time_ >= 0 + var_666_0 and arg_663_1.time_ < 0 + var_666_0 + arg_666_0 and not isNil(arg_663_1.actors_["10154"]) and arg_663_1.var_.actorSpriteComps10154 then
				for iter_666_2, iter_666_3 in pairs(arg_663_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_666_3 then
						iter_666_3.color = arg_663_1.isInRecall_ and (arg_663_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_663_1.var_.actorSpriteComps10154 = nil
			end

			local var_666_2 = arg_663_1.actors_["10154"].transform

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= 0 + arg_666_0 then
				arg_663_1.var_.moveOldPos10154 = var_666_2.localPosition
				var_666_2.localScale = Vector3.New(1, 1, 1)

				arg_663_1:CheckSpriteTmpPos("10154", 3)

				for iter_666_4 = 0, var_666_2.childCount - 1 do
					local var_666_3 = var_666_2:GetChild(iter_666_4)

					if var_666_3.name == "split_5" then
						var_666_3:SetAsLastSibling()
						var_666_3.gameObject:SetActive(true)

						arg_663_1.var_.actorSpriteSplit10154 = var_666_3.gameObject:GetComponent(typeof(Image))

						arg_663_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_666_4 = 0.5

			if 0 <= arg_663_1.time_ and arg_663_1.time_ < 0 + var_666_4 then
				var_666_2.localPosition = Vector3.Lerp(arg_663_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_663_1.time_ - 0) / var_666_4)

				if arg_663_1.var_.actorSpriteSplit10154 ~= nil then
					arg_663_1.var_.actorSpriteSplit10154:SetAlpha((arg_663_1.time_ - 0) / var_666_4)
				end
			end

			if arg_663_1.time_ >= 0 + var_666_4 and arg_663_1.time_ < 0 + var_666_4 + arg_666_0 then
				var_666_2.localPosition = Vector3.New(-20, -338, -538)

				if arg_663_1.var_.actorSpriteSplit10154 ~= nil then
					arg_663_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_666_5 = 0
			local var_666_6 = 0.1

			if 0 < arg_663_1.time_ and arg_663_1.time_ <= var_666_5 + arg_666_0 then
				arg_663_1.talkMaxDuration = 0
				arg_663_1.dialogCg_.alpha = 1

				arg_663_1.dialog_:SetActive(true)
				SetActive(arg_663_1.leftNameGo_, true)

				arg_663_1.leftNameTxt_.text = arg_663_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_663_1.leftNameTxt_.transform)

				arg_663_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_663_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_663_1:RecordName(arg_663_1.leftNameTxt_.text)
				SetActive(arg_663_1.iconTrs_.gameObject, false)
				arg_663_1.callingController_:SetSelectedState("normal")

				local var_666_7 = arg_663_1:GetWordFromCfg(424041162)
				local var_666_8 = arg_663_1:FormatText(var_666_7.content)

				arg_663_1.text_.text = var_666_8

				LuaForUtil.ClearLinePrefixSymbol(arg_663_1.text_)

				local var_666_10 = 4 <= 0 and var_666_6 or var_666_6 * (utf8.len(var_666_8) / 4)

				if (4 <= 0 and var_666_6 or var_666_6 * (utf8.len(var_666_8) / 4)) > 0 and var_666_6 < var_666_10 then
					arg_663_1.talkMaxDuration = var_666_10

					if var_666_10 + var_666_5 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_10 + var_666_5
					end
				end

				arg_663_1.text_.text = var_666_8
				arg_663_1.typewritter.percent = 0

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041162", "story_v_out_424041.awb") ~= 0 then
					local var_666_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041162", "story_v_out_424041.awb") / 1000

					if var_666_11 + var_666_5 > arg_663_1.duration_ then
						arg_663_1.duration_ = var_666_11 + var_666_5
					end

					if var_666_7.prefab_name ~= "" and arg_663_1.actors_[var_666_7.prefab_name] ~= nil then
						local var_666_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_663_1.actors_[var_666_7.prefab_name].transform, "story_v_out_424041", "424041162", "story_v_out_424041.awb")

						arg_663_1:RecordAudio("424041162", var_666_12)
						arg_663_1:RecordAudio("424041162", var_666_12)
					else
						arg_663_1:AudioAction("play", "voice", "story_v_out_424041", "424041162", "story_v_out_424041.awb")
					end

					arg_663_1:RecordHistoryTalkVoice("story_v_out_424041", "424041162", "story_v_out_424041.awb")
				end

				arg_663_1:RecordContent(arg_663_1.text_.text)
			end

			local var_666_13 = math.max(var_666_6, arg_663_1.talkMaxDuration)

			if var_666_5 <= arg_663_1.time_ and arg_663_1.time_ < var_666_5 + var_666_13 then
				arg_663_1.typewritter.percent = (arg_663_1.time_ - var_666_5) / var_666_13

				arg_663_1.typewritter:SetDirty()
			end

			if arg_663_1.time_ >= var_666_5 + var_666_13 and arg_663_1.time_ < var_666_5 + var_666_13 + arg_666_0 then
				arg_663_1.typewritter.percent = 1

				arg_663_1.typewritter:SetDirty()
				arg_663_1:ShowNextGo(true)
			end
		end

		arg_663_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_663_1:InitPlayNodeList()
	end,
	Play424041163 = function(arg_667_0, arg_667_1)
		arg_667_1.time_ = 0
		arg_667_1.frameCnt_ = 0
		arg_667_1.state_ = "playing"
		arg_667_1.curTalkId_ = 424041163
		arg_667_1.duration_ = 9

		SetActive(arg_667_1.tipsGo_, false)

		function arg_667_1.onSingleLineFinish_()
			arg_667_1.onSingleLineUpdate_ = nil
			arg_667_1.onSingleLineFinish_ = nil
			arg_667_1.state_ = "waiting"
		end

		function arg_667_1.playNext_(arg_669_0)
			if arg_669_0 == 1 then
				arg_667_0:Play424041164(arg_667_1)
			end
		end

		function arg_667_1.onSingleLineUpdate_(arg_670_0)
			if arg_667_1.bgs_.ST0115 == nil then
				local var_670_0 = Object.Instantiate(arg_667_1.paintGo_)

				var_670_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0115")
				var_670_0.name = "ST0115"
				var_670_0.transform.parent = arg_667_1.stage_.transform
				var_670_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_667_1.bgs_.ST0115 = var_670_0
			end

			if 2 < arg_667_1.time_ and arg_667_1.time_ <= 2 + arg_670_0 then
				local var_670_1 = arg_667_1.bgs_.ST0115

				arg_667_1.bgs_.ST0115.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_670_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_670_2 = var_670_1:GetComponent("SpriteRenderer")

				if var_670_2 and var_670_2.sprite then
					local var_670_3 = 2 * (var_670_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_670_1.transform.localScale = Vector3.New(var_670_3 / var_670_2.sprite.bounds.size.y < var_670_3 * manager.ui.mainCameraCom_.aspect / var_670_2.sprite.bounds.size.x and var_670_3 * manager.ui.mainCameraCom_.aspect / var_670_2.sprite.bounds.size.x or var_670_3 / var_670_2.sprite.bounds.size.y, var_670_3 / var_670_2.sprite.bounds.size.y < var_670_3 * manager.ui.mainCameraCom_.aspect / var_670_2.sprite.bounds.size.x and var_670_3 * manager.ui.mainCameraCom_.aspect / var_670_2.sprite.bounds.size.x or var_670_3 / var_670_2.sprite.bounds.size.y, 0)
				end

				for iter_670_0, iter_670_1 in pairs(arg_667_1.bgs_) do
					if iter_670_0 ~= "ST0115" then
						iter_670_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_670_4 = 4

			if 4 < arg_667_1.time_ and arg_667_1.time_ <= var_670_4 + arg_670_0 then
				arg_667_1.allBtn_.enabled = false
			end

			if arg_667_1.time_ >= var_670_4 + 0.3 and arg_667_1.time_ < var_670_4 + 0.3 + arg_670_0 then
				arg_667_1.allBtn_.enabled = true
			end

			local var_670_5 = 0

			if 0 < arg_667_1.time_ and arg_667_1.time_ <= var_670_5 + arg_670_0 then
				arg_667_1.mask_.enabled = true
				arg_667_1.mask_.raycastTarget = true

				arg_667_1:SetGaussion(false)
			end

			local var_670_6 = 2

			if var_670_5 <= arg_667_1.time_ and arg_667_1.time_ < var_670_5 + var_670_6 then
				local var_670_7 = Color.New(0, 0, 0)

				var_670_7.a = Mathf.Lerp(0, 1, (arg_667_1.time_ - var_670_5) / var_670_6)
				arg_667_1.mask_.color = var_670_7
			end

			if arg_667_1.time_ >= var_670_5 + var_670_6 and arg_667_1.time_ < var_670_5 + var_670_6 + arg_670_0 then
				local var_670_8 = Color.New(0, 0, 0)

				var_670_8.a = 1
				arg_667_1.mask_.color = var_670_8
			end

			local var_670_9 = 2

			if 2 < arg_667_1.time_ and arg_667_1.time_ <= var_670_9 + arg_670_0 then
				arg_667_1.mask_.enabled = true
				arg_667_1.mask_.raycastTarget = true

				arg_667_1:SetGaussion(false)
			end

			local var_670_10 = 2

			if var_670_9 <= arg_667_1.time_ and arg_667_1.time_ < var_670_9 + var_670_10 then
				local var_670_11 = Color.New(0, 0, 0)

				var_670_11.a = Mathf.Lerp(1, 0, (arg_667_1.time_ - var_670_9) / var_670_10)
				arg_667_1.mask_.color = var_670_11
			end

			if arg_667_1.time_ >= var_670_9 + var_670_10 and arg_667_1.time_ < var_670_9 + var_670_10 + arg_670_0 then
				local var_670_12 = Color.New(0, 0, 0)

				arg_667_1.mask_.enabled = false
				var_670_12.a = 0
				arg_667_1.mask_.color = var_670_12
			end

			local var_670_13 = arg_667_1.actors_["10154"]

			if 1.98333333333333 < arg_667_1.time_ and arg_667_1.time_ <= 1.98333333333333 + arg_670_0 and not isNil(var_670_13) and arg_667_1.var_.actorSpriteComps10154 == nil then
				arg_667_1.var_.actorSpriteComps10154 = var_670_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_670_14 = 0.0166666666666667

			if 1.98333333333333 <= arg_667_1.time_ and arg_667_1.time_ < 1.98333333333333 + var_670_14 and not isNil(var_670_13) then
				if arg_667_1.var_.actorSpriteComps10154 then
					for iter_670_2, iter_670_3 in pairs(arg_667_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_670_3 then
							if arg_667_1.isInRecall_ then
								iter_670_3.color = Color.New(Mathf.Lerp(iter_670_3.color.r, arg_667_1.hightColor2.r, (arg_667_1.time_ - 1.98333333333333) / var_670_14), Mathf.Lerp(iter_670_3.color.g, arg_667_1.hightColor2.g, (arg_667_1.time_ - 1.98333333333333) / var_670_14), (Mathf.Lerp(iter_670_3.color.b, arg_667_1.hightColor2.b, (arg_667_1.time_ - 1.98333333333333) / var_670_14)))
							else
								local var_670_15 = Mathf.Lerp(iter_670_3.color.r, 0.5, (arg_667_1.time_ - 1.98333333333333) / var_670_14)

								iter_670_3.color = Color.New(var_670_15, var_670_15, var_670_15)
							end
						end
					end
				end
			end

			if arg_667_1.time_ >= 1.98333333333333 + var_670_14 and arg_667_1.time_ < 1.98333333333333 + var_670_14 + arg_670_0 and not isNil(var_670_13) and arg_667_1.var_.actorSpriteComps10154 then
				for iter_670_4, iter_670_5 in pairs(arg_667_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_670_5 then
						iter_670_5.color = arg_667_1.isInRecall_ and (arg_667_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_667_1.var_.actorSpriteComps10154 = nil
			end

			local var_670_16 = arg_667_1.actors_["10154"].transform

			if 1.966 < arg_667_1.time_ and arg_667_1.time_ <= 1.966 + arg_670_0 then
				arg_667_1.var_.moveOldPos10154 = var_670_16.localPosition
				var_670_16.localScale = Vector3.New(1, 1, 1)

				arg_667_1:CheckSpriteTmpPos("10154", 7)

				for iter_670_6 = 0, var_670_16.childCount - 1 do
					local var_670_17 = var_670_16:GetChild(iter_670_6)

					if var_670_17.name == "" or not string.find(var_670_17.name, "split") then
						var_670_17.gameObject:SetActive(true)
					else
						var_670_17.gameObject:SetActive(false)
					end
				end
			end

			local var_670_18 = 0.001

			if 1.966 <= arg_667_1.time_ and arg_667_1.time_ < 1.966 + var_670_18 then
				var_670_16.localPosition = Vector3.Lerp(arg_667_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_667_1.time_ - 1.966) / var_670_18)
			end

			if arg_667_1.time_ >= 1.966 + var_670_18 and arg_667_1.time_ < 1.966 + var_670_18 + arg_670_0 then
				var_670_16.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.133333333333333 < arg_667_1.time_ and arg_667_1.time_ <= 0.133333333333333 + arg_670_0 then
				arg_667_1:AudioAction("stop", "effect", "se_story_142", "se_story_142_amb_city_street", "")
			end

			if 1.6 < arg_667_1.time_ and arg_667_1.time_ <= 1.6 + arg_670_0 then
				arg_667_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_room01", "")
			end

			if 4.3 < arg_667_1.time_ and arg_667_1.time_ <= 4.3 + arg_670_0 then
				arg_667_1:AudioAction("play", "effect", "se_story_144", "se_story_144_door_open", "")
			end

			if 0.133333333333333 < arg_667_1.time_ and arg_667_1.time_ <= 0.133333333333333 + arg_670_0 then
				arg_667_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_670_24 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_667_1.bgmTxt_.text ~= var_670_24 and arg_667_1.bgmTxt_.text ~= "" then
						if arg_667_1.bgmTxt2_.text ~= "" then
							arg_667_1.bgmTxt_.text = arg_667_1.bgmTxt2_.text
						end

						arg_667_1.bgmTxt2_.text = var_670_24

						arg_667_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_667_1.bgmTxt_.text = var_670_24
						arg_667_1.bgmTxt2_.text = var_670_24
					end

					if arg_667_1.bgmTimer then
						arg_667_1.bgmTimer:Stop()

						arg_667_1.bgmTimer = nil
					end

					if arg_667_1.settingData.show_music_name == 1 then
						arg_667_1.musicController:SetSelectedState("show")
						arg_667_1.musicAnimator_:Play("open", 0, 0)

						if arg_667_1.settingData.music_time ~= 0 then
							arg_667_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_667_1.settingData.music_time), function()
								if arg_667_1 == nil or isNil(arg_667_1.bgmTxt_) then
									return
								end

								arg_667_1.musicController:SetSelectedState("hide")
								arg_667_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.6 < arg_667_1.time_ and arg_667_1.time_ <= 1.6 + arg_670_0 then
				arg_667_1:AudioAction("play", "music", "bgm_activity_4_6_story_saddaily", "bgm_activity_4_6_story_saddaily", "bgm_activity_4_6_story_saddaily.awb")

				local var_670_27 = manager.audio:GetAudioName("bgm_activity_4_6_story_saddaily", "bgm_activity_4_6_story_saddaily")

				if "" ~= "" then
					if arg_667_1.bgmTxt_.text ~= var_670_27 and arg_667_1.bgmTxt_.text ~= "" then
						if arg_667_1.bgmTxt2_.text ~= "" then
							arg_667_1.bgmTxt_.text = arg_667_1.bgmTxt2_.text
						end

						arg_667_1.bgmTxt2_.text = var_670_27

						arg_667_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_667_1.bgmTxt_.text = var_670_27
						arg_667_1.bgmTxt2_.text = var_670_27
					end

					if arg_667_1.bgmTimer then
						arg_667_1.bgmTimer:Stop()

						arg_667_1.bgmTimer = nil
					end

					if arg_667_1.settingData.show_music_name == 1 then
						arg_667_1.musicController:SetSelectedState("show")
						arg_667_1.musicAnimator_:Play("open", 0, 0)

						if arg_667_1.settingData.music_time ~= 0 then
							arg_667_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_667_1.settingData.music_time), function()
								if arg_667_1 == nil or isNil(arg_667_1.bgmTxt_) then
									return
								end

								arg_667_1.musicController:SetSelectedState("hide")
								arg_667_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_667_1.frameCnt_ <= 1 then
				arg_667_1.dialog_:SetActive(false)
			end

			local var_670_28 = 4
			local var_670_29 = 0.75

			if 4 < arg_667_1.time_ and arg_667_1.time_ <= var_670_28 + arg_670_0 then
				arg_667_1.talkMaxDuration = 0

				arg_667_1.dialog_:SetActive(true)

				arg_667_1.dialogCg_.alpha = 0

				local var_670_30 = LeanTween.value(arg_667_1.dialog_, 0, 1, 0.3)

				var_670_30:setOnUpdate(LuaHelper.FloatAction(function(arg_673_0)
					arg_667_1.dialogCg_.alpha = arg_673_0
				end))
				var_670_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_667_1.dialog_)
					var_670_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_667_1.duration_ = arg_667_1.duration_ + 0.3

				SetActive(arg_667_1.leftNameGo_, false)

				arg_667_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_667_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_667_1:RecordName(arg_667_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_667_1.iconTrs_.gameObject, false)
				arg_667_1.callingController_:SetSelectedState("normal")

				local var_670_31 = arg_667_1:FormatText(arg_667_1:GetWordFromCfg(424041163).content)

				arg_667_1.text_.text = var_670_31

				LuaForUtil.ClearLinePrefixSymbol(arg_667_1.text_)

				local var_670_33 = 30 <= 0 and var_670_29 or var_670_29 * (utf8.len(var_670_31) / 30)

				if (30 <= 0 and var_670_29 or var_670_29 * (utf8.len(var_670_31) / 30)) > 0 and var_670_29 < var_670_33 then
					arg_667_1.talkMaxDuration = var_670_33
					var_670_28 = var_670_28 + 0.3

					if var_670_33 + var_670_28 > arg_667_1.duration_ then
						arg_667_1.duration_ = var_670_33 + var_670_28
					end
				end

				arg_667_1.text_.text = var_670_31
				arg_667_1.typewritter.percent = 0

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(false)
				arg_667_1:RecordContent(arg_667_1.text_.text)
			end

			local var_670_34 = var_670_28 + 0.3
			local var_670_35 = math.max(var_670_29, arg_667_1.talkMaxDuration)

			if var_670_28 + 0.3 <= arg_667_1.time_ and arg_667_1.time_ < var_670_34 + var_670_35 then
				arg_667_1.typewritter.percent = (arg_667_1.time_ - var_670_34) / var_670_35

				arg_667_1.typewritter:SetDirty()
			end

			if arg_667_1.time_ >= var_670_34 + var_670_35 and arg_667_1.time_ < var_670_34 + var_670_35 + arg_670_0 then
				arg_667_1.typewritter.percent = 1

				arg_667_1.typewritter:SetDirty()
				arg_667_1:ShowNextGo(true)
			end
		end

		arg_667_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_667_1:InitPlayNodeList()
	end,
	Play424041164 = function(arg_675_0, arg_675_1)
		arg_675_1.time_ = 0
		arg_675_1.frameCnt_ = 0
		arg_675_1.state_ = "playing"
		arg_675_1.curTalkId_ = 424041164
		arg_675_1.duration_ = 4.97

		local var_675_0 = {
			zh = 3.233,
			ja = 4.966
		}
		local var_675_1 = manager.audio:GetLocalizationFlag()

		if var_675_0[var_675_1] ~= nil then
			arg_675_1.duration_ = var_675_0[var_675_1]
		end

		SetActive(arg_675_1.tipsGo_, false)

		function arg_675_1.onSingleLineFinish_()
			arg_675_1.onSingleLineUpdate_ = nil
			arg_675_1.onSingleLineFinish_ = nil
			arg_675_1.state_ = "waiting"
		end

		function arg_675_1.playNext_(arg_677_0)
			if arg_677_0 == 1 then
				arg_675_0:Play424041165(arg_675_1)
			end
		end

		function arg_675_1.onSingleLineUpdate_(arg_678_0)
			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 and not isNil(arg_675_1.actors_["10154"]) and arg_675_1.var_.actorSpriteComps10154 == nil then
				arg_675_1.var_.actorSpriteComps10154 = arg_675_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_678_0 = 0.2

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_0 and not isNil(arg_675_1.actors_["10154"]) then
				if arg_675_1.var_.actorSpriteComps10154 then
					for iter_678_0, iter_678_1 in pairs(arg_675_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_678_1 then
							if arg_675_1.isInRecall_ then
								iter_678_1.color = Color.New(Mathf.Lerp(iter_678_1.color.r, arg_675_1.hightColor1.r, (arg_675_1.time_ - 0) / var_678_0), Mathf.Lerp(iter_678_1.color.g, arg_675_1.hightColor1.g, (arg_675_1.time_ - 0) / var_678_0), (Mathf.Lerp(iter_678_1.color.b, arg_675_1.hightColor1.b, (arg_675_1.time_ - 0) / var_678_0)))
							else
								local var_678_1 = Mathf.Lerp(iter_678_1.color.r, 1, (arg_675_1.time_ - 0) / var_678_0)

								iter_678_1.color = Color.New(var_678_1, var_678_1, var_678_1)
							end
						end
					end
				end
			end

			if arg_675_1.time_ >= 0 + var_678_0 and arg_675_1.time_ < 0 + var_678_0 + arg_678_0 and not isNil(arg_675_1.actors_["10154"]) and arg_675_1.var_.actorSpriteComps10154 then
				for iter_678_2, iter_678_3 in pairs(arg_675_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_678_3 then
						iter_678_3.color = arg_675_1.isInRecall_ and (arg_675_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_675_1.var_.actorSpriteComps10154 = nil
			end

			local var_678_2 = arg_675_1.actors_["10154"].transform

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= 0 + arg_678_0 then
				arg_675_1.var_.moveOldPos10154 = var_678_2.localPosition
				var_678_2.localScale = Vector3.New(1, 1, 1)

				arg_675_1:CheckSpriteTmpPos("10154", 2)

				for iter_678_4 = 0, var_678_2.childCount - 1 do
					local var_678_3 = var_678_2:GetChild(iter_678_4)

					if var_678_3.name == "" or not string.find(var_678_3.name, "split") then
						var_678_3.gameObject:SetActive(true)
					else
						var_678_3.gameObject:SetActive(false)
					end
				end
			end

			local var_678_4 = 0.001

			if 0 <= arg_675_1.time_ and arg_675_1.time_ < 0 + var_678_4 then
				var_678_2.localPosition = Vector3.Lerp(arg_675_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_675_1.time_ - 0) / var_678_4)
			end

			if arg_675_1.time_ >= 0 + var_678_4 and arg_675_1.time_ < 0 + var_678_4 + arg_678_0 then
				var_678_2.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_678_5 = 0
			local var_678_6 = 0.5

			if 0 < arg_675_1.time_ and arg_675_1.time_ <= var_678_5 + arg_678_0 then
				arg_675_1.talkMaxDuration = 0
				arg_675_1.dialogCg_.alpha = 1

				arg_675_1.dialog_:SetActive(true)
				SetActive(arg_675_1.leftNameGo_, true)

				arg_675_1.leftNameTxt_.text = arg_675_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_675_1.leftNameTxt_.transform)

				arg_675_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_675_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_675_1:RecordName(arg_675_1.leftNameTxt_.text)
				SetActive(arg_675_1.iconTrs_.gameObject, false)
				arg_675_1.callingController_:SetSelectedState("normal")

				local var_678_7 = arg_675_1:GetWordFromCfg(424041164)
				local var_678_8 = arg_675_1:FormatText(var_678_7.content)

				arg_675_1.text_.text = var_678_8

				LuaForUtil.ClearLinePrefixSymbol(arg_675_1.text_)

				local var_678_10 = 20 <= 0 and var_678_6 or var_678_6 * (utf8.len(var_678_8) / 20)

				if (20 <= 0 and var_678_6 or var_678_6 * (utf8.len(var_678_8) / 20)) > 0 and var_678_6 < var_678_10 then
					arg_675_1.talkMaxDuration = var_678_10

					if var_678_10 + var_678_5 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_10 + var_678_5
					end
				end

				arg_675_1.text_.text = var_678_8
				arg_675_1.typewritter.percent = 0

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041164", "story_v_out_424041.awb") ~= 0 then
					local var_678_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041164", "story_v_out_424041.awb") / 1000

					if var_678_11 + var_678_5 > arg_675_1.duration_ then
						arg_675_1.duration_ = var_678_11 + var_678_5
					end

					if var_678_7.prefab_name ~= "" and arg_675_1.actors_[var_678_7.prefab_name] ~= nil then
						local var_678_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_675_1.actors_[var_678_7.prefab_name].transform, "story_v_out_424041", "424041164", "story_v_out_424041.awb")

						arg_675_1:RecordAudio("424041164", var_678_12)
						arg_675_1:RecordAudio("424041164", var_678_12)
					else
						arg_675_1:AudioAction("play", "voice", "story_v_out_424041", "424041164", "story_v_out_424041.awb")
					end

					arg_675_1:RecordHistoryTalkVoice("story_v_out_424041", "424041164", "story_v_out_424041.awb")
				end

				arg_675_1:RecordContent(arg_675_1.text_.text)
			end

			local var_678_13 = math.max(var_678_6, arg_675_1.talkMaxDuration)

			if var_678_5 <= arg_675_1.time_ and arg_675_1.time_ < var_678_5 + var_678_13 then
				arg_675_1.typewritter.percent = (arg_675_1.time_ - var_678_5) / var_678_13

				arg_675_1.typewritter:SetDirty()
			end

			if arg_675_1.time_ >= var_678_5 + var_678_13 and arg_675_1.time_ < var_678_5 + var_678_13 + arg_678_0 then
				arg_675_1.typewritter.percent = 1

				arg_675_1.typewritter:SetDirty()
				arg_675_1:ShowNextGo(true)
			end
		end

		arg_675_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_675_1:InitPlayNodeList()
	end,
	Play424041165 = function(arg_679_0, arg_679_1)
		arg_679_1.time_ = 0
		arg_679_1.frameCnt_ = 0
		arg_679_1.state_ = "playing"
		arg_679_1.curTalkId_ = 424041165
		arg_679_1.duration_ = 2.13

		local var_679_0 = {
			zh = 1.866,
			ja = 2.133
		}
		local var_679_1 = manager.audio:GetLocalizationFlag()

		if var_679_0[var_679_1] ~= nil then
			arg_679_1.duration_ = var_679_0[var_679_1]
		end

		SetActive(arg_679_1.tipsGo_, false)

		function arg_679_1.onSingleLineFinish_()
			arg_679_1.onSingleLineUpdate_ = nil
			arg_679_1.onSingleLineFinish_ = nil
			arg_679_1.state_ = "waiting"
		end

		function arg_679_1.playNext_(arg_681_0)
			if arg_681_0 == 1 then
				arg_679_0:Play424041166(arg_679_1)
			end
		end

		function arg_679_1.onSingleLineUpdate_(arg_682_0)
			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 and not isNil(arg_679_1.actors_["10153"]) and arg_679_1.var_.actorSpriteComps10153 == nil then
				arg_679_1.var_.actorSpriteComps10153 = arg_679_1.actors_["10153"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_682_0 = 0.2

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_0 and not isNil(arg_679_1.actors_["10153"]) then
				if arg_679_1.var_.actorSpriteComps10153 then
					for iter_682_0, iter_682_1 in pairs(arg_679_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_682_1 then
							if arg_679_1.isInRecall_ then
								iter_682_1.color = Color.New(Mathf.Lerp(iter_682_1.color.r, arg_679_1.hightColor1.r, (arg_679_1.time_ - 0) / var_682_0), Mathf.Lerp(iter_682_1.color.g, arg_679_1.hightColor1.g, (arg_679_1.time_ - 0) / var_682_0), (Mathf.Lerp(iter_682_1.color.b, arg_679_1.hightColor1.b, (arg_679_1.time_ - 0) / var_682_0)))
							else
								local var_682_1 = Mathf.Lerp(iter_682_1.color.r, 1, (arg_679_1.time_ - 0) / var_682_0)

								iter_682_1.color = Color.New(var_682_1, var_682_1, var_682_1)
							end
						end
					end
				end
			end

			if arg_679_1.time_ >= 0 + var_682_0 and arg_679_1.time_ < 0 + var_682_0 + arg_682_0 and not isNil(arg_679_1.actors_["10153"]) and arg_679_1.var_.actorSpriteComps10153 then
				for iter_682_2, iter_682_3 in pairs(arg_679_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_682_3 then
						iter_682_3.color = arg_679_1.isInRecall_ and (arg_679_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_679_1.var_.actorSpriteComps10153 = nil
			end

			local var_682_2 = arg_679_1.actors_["10154"]

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 and not isNil(var_682_2) and arg_679_1.var_.actorSpriteComps10154 == nil then
				arg_679_1.var_.actorSpriteComps10154 = var_682_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_682_3 = 0.2

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_3 and not isNil(var_682_2) then
				if arg_679_1.var_.actorSpriteComps10154 then
					for iter_682_4, iter_682_5 in pairs(arg_679_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_682_5 then
							if arg_679_1.isInRecall_ then
								iter_682_5.color = Color.New(Mathf.Lerp(iter_682_5.color.r, arg_679_1.hightColor2.r, (arg_679_1.time_ - 0) / var_682_3), Mathf.Lerp(iter_682_5.color.g, arg_679_1.hightColor2.g, (arg_679_1.time_ - 0) / var_682_3), (Mathf.Lerp(iter_682_5.color.b, arg_679_1.hightColor2.b, (arg_679_1.time_ - 0) / var_682_3)))
							else
								local var_682_4 = Mathf.Lerp(iter_682_5.color.r, 0.5, (arg_679_1.time_ - 0) / var_682_3)

								iter_682_5.color = Color.New(var_682_4, var_682_4, var_682_4)
							end
						end
					end
				end
			end

			if arg_679_1.time_ >= 0 + var_682_3 and arg_679_1.time_ < 0 + var_682_3 + arg_682_0 and not isNil(var_682_2) and arg_679_1.var_.actorSpriteComps10154 then
				for iter_682_6, iter_682_7 in pairs(arg_679_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_682_7 then
						iter_682_7.color = arg_679_1.isInRecall_ and (arg_679_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_679_1.var_.actorSpriteComps10154 = nil
			end

			local var_682_5 = arg_679_1.actors_["10153"].transform

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= 0 + arg_682_0 then
				arg_679_1.var_.moveOldPos10153 = var_682_5.localPosition
				var_682_5.localScale = Vector3.New(1, 1, 1)

				arg_679_1:CheckSpriteTmpPos("10153", 4)

				for iter_682_8 = 0, var_682_5.childCount - 1 do
					local var_682_6 = var_682_5:GetChild(iter_682_8)

					if var_682_6.name == "" or not string.find(var_682_6.name, "split") then
						var_682_6.gameObject:SetActive(true)
					else
						var_682_6.gameObject:SetActive(false)
					end
				end
			end

			local var_682_7 = 0.001

			if 0 <= arg_679_1.time_ and arg_679_1.time_ < 0 + var_682_7 then
				var_682_5.localPosition = Vector3.Lerp(arg_679_1.var_.moveOldPos10153, Vector3.New(400, -395, -330), (arg_679_1.time_ - 0) / var_682_7)
			end

			if arg_679_1.time_ >= 0 + var_682_7 and arg_679_1.time_ < 0 + var_682_7 + arg_682_0 then
				var_682_5.localPosition = Vector3.New(400, -395, -330)
			end

			local var_682_8 = 0
			local var_682_9 = 0.2

			if 0 < arg_679_1.time_ and arg_679_1.time_ <= var_682_8 + arg_682_0 then
				arg_679_1.talkMaxDuration = 0
				arg_679_1.dialogCg_.alpha = 1

				arg_679_1.dialog_:SetActive(true)
				SetActive(arg_679_1.leftNameGo_, true)

				arg_679_1.leftNameTxt_.text = arg_679_1:FormatText(StoryNameCfg[1387].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_679_1.leftNameTxt_.transform)

				arg_679_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_679_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_679_1:RecordName(arg_679_1.leftNameTxt_.text)
				SetActive(arg_679_1.iconTrs_.gameObject, false)
				arg_679_1.callingController_:SetSelectedState("normal")

				local var_682_10 = arg_679_1:GetWordFromCfg(424041165)
				local var_682_11 = arg_679_1:FormatText(var_682_10.content)

				arg_679_1.text_.text = var_682_11

				LuaForUtil.ClearLinePrefixSymbol(arg_679_1.text_)

				local var_682_13 = 8 <= 0 and var_682_9 or var_682_9 * (utf8.len(var_682_11) / 8)

				if (8 <= 0 and var_682_9 or var_682_9 * (utf8.len(var_682_11) / 8)) > 0 and var_682_9 < var_682_13 then
					arg_679_1.talkMaxDuration = var_682_13

					if var_682_13 + var_682_8 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_13 + var_682_8
					end
				end

				arg_679_1.text_.text = var_682_11
				arg_679_1.typewritter.percent = 0

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041165", "story_v_out_424041.awb") ~= 0 then
					local var_682_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041165", "story_v_out_424041.awb") / 1000

					if var_682_14 + var_682_8 > arg_679_1.duration_ then
						arg_679_1.duration_ = var_682_14 + var_682_8
					end

					if var_682_10.prefab_name ~= "" and arg_679_1.actors_[var_682_10.prefab_name] ~= nil then
						local var_682_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_679_1.actors_[var_682_10.prefab_name].transform, "story_v_out_424041", "424041165", "story_v_out_424041.awb")

						arg_679_1:RecordAudio("424041165", var_682_15)
						arg_679_1:RecordAudio("424041165", var_682_15)
					else
						arg_679_1:AudioAction("play", "voice", "story_v_out_424041", "424041165", "story_v_out_424041.awb")
					end

					arg_679_1:RecordHistoryTalkVoice("story_v_out_424041", "424041165", "story_v_out_424041.awb")
				end

				arg_679_1:RecordContent(arg_679_1.text_.text)
			end

			local var_682_16 = math.max(var_682_9, arg_679_1.talkMaxDuration)

			if var_682_8 <= arg_679_1.time_ and arg_679_1.time_ < var_682_8 + var_682_16 then
				arg_679_1.typewritter.percent = (arg_679_1.time_ - var_682_8) / var_682_16

				arg_679_1.typewritter:SetDirty()
			end

			if arg_679_1.time_ >= var_682_8 + var_682_16 and arg_679_1.time_ < var_682_8 + var_682_16 + arg_682_0 then
				arg_679_1.typewritter.percent = 1

				arg_679_1.typewritter:SetDirty()
				arg_679_1:ShowNextGo(true)
			end
		end

		arg_679_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_679_1:InitPlayNodeList()
	end,
	Play424041166 = function(arg_683_0, arg_683_1)
		arg_683_1.time_ = 0
		arg_683_1.frameCnt_ = 0
		arg_683_1.state_ = "playing"
		arg_683_1.curTalkId_ = 424041166
		arg_683_1.duration_ = 3.23

		local var_683_0 = {
			zh = 2.633,
			ja = 3.233
		}
		local var_683_1 = manager.audio:GetLocalizationFlag()

		if var_683_0[var_683_1] ~= nil then
			arg_683_1.duration_ = var_683_0[var_683_1]
		end

		SetActive(arg_683_1.tipsGo_, false)

		function arg_683_1.onSingleLineFinish_()
			arg_683_1.onSingleLineUpdate_ = nil
			arg_683_1.onSingleLineFinish_ = nil
			arg_683_1.state_ = "waiting"
		end

		function arg_683_1.playNext_(arg_685_0)
			if arg_685_0 == 1 then
				arg_683_0:Play424041167(arg_683_1)
			end
		end

		function arg_683_1.onSingleLineUpdate_(arg_686_0)
			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 and not isNil(arg_683_1.actors_["1094"]) and arg_683_1.var_.actorSpriteComps1094 == nil then
				arg_683_1.var_.actorSpriteComps1094 = arg_683_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_686_0 = 0.2

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_0 and not isNil(arg_683_1.actors_["1094"]) then
				if arg_683_1.var_.actorSpriteComps1094 then
					for iter_686_0, iter_686_1 in pairs(arg_683_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_686_1 then
							if arg_683_1.isInRecall_ then
								iter_686_1.color = Color.New(Mathf.Lerp(iter_686_1.color.r, arg_683_1.hightColor1.r, (arg_683_1.time_ - 0) / var_686_0), Mathf.Lerp(iter_686_1.color.g, arg_683_1.hightColor1.g, (arg_683_1.time_ - 0) / var_686_0), (Mathf.Lerp(iter_686_1.color.b, arg_683_1.hightColor1.b, (arg_683_1.time_ - 0) / var_686_0)))
							else
								local var_686_1 = Mathf.Lerp(iter_686_1.color.r, 1, (arg_683_1.time_ - 0) / var_686_0)

								iter_686_1.color = Color.New(var_686_1, var_686_1, var_686_1)
							end
						end
					end
				end
			end

			if arg_683_1.time_ >= 0 + var_686_0 and arg_683_1.time_ < 0 + var_686_0 + arg_686_0 and not isNil(arg_683_1.actors_["1094"]) and arg_683_1.var_.actorSpriteComps1094 then
				for iter_686_2, iter_686_3 in pairs(arg_683_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_686_3 then
						iter_686_3.color = arg_683_1.isInRecall_ and (arg_683_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_683_1.var_.actorSpriteComps1094 = nil
			end

			local var_686_2 = arg_683_1.actors_["10153"]

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 and not isNil(var_686_2) and arg_683_1.var_.actorSpriteComps10153 == nil then
				arg_683_1.var_.actorSpriteComps10153 = var_686_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_686_3 = 0.2

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_3 and not isNil(var_686_2) then
				if arg_683_1.var_.actorSpriteComps10153 then
					for iter_686_4, iter_686_5 in pairs(arg_683_1.var_.actorSpriteComps10153:ToTable()) do
						if iter_686_5 then
							if arg_683_1.isInRecall_ then
								iter_686_5.color = Color.New(Mathf.Lerp(iter_686_5.color.r, arg_683_1.hightColor2.r, (arg_683_1.time_ - 0) / var_686_3), Mathf.Lerp(iter_686_5.color.g, arg_683_1.hightColor2.g, (arg_683_1.time_ - 0) / var_686_3), (Mathf.Lerp(iter_686_5.color.b, arg_683_1.hightColor2.b, (arg_683_1.time_ - 0) / var_686_3)))
							else
								local var_686_4 = Mathf.Lerp(iter_686_5.color.r, 0.5, (arg_683_1.time_ - 0) / var_686_3)

								iter_686_5.color = Color.New(var_686_4, var_686_4, var_686_4)
							end
						end
					end
				end
			end

			if arg_683_1.time_ >= 0 + var_686_3 and arg_683_1.time_ < 0 + var_686_3 + arg_686_0 and not isNil(var_686_2) and arg_683_1.var_.actorSpriteComps10153 then
				for iter_686_6, iter_686_7 in pairs(arg_683_1.var_.actorSpriteComps10153:ToTable()) do
					if iter_686_7 then
						iter_686_7.color = arg_683_1.isInRecall_ and (arg_683_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_683_1.var_.actorSpriteComps10153 = nil
			end

			local var_686_5 = arg_683_1.actors_["1094"].transform

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 then
				arg_683_1.var_.moveOldPos1094 = var_686_5.localPosition
				var_686_5.localScale = Vector3.New(1, 1, 1)

				arg_683_1:CheckSpriteTmpPos("1094", 4)

				for iter_686_8 = 0, var_686_5.childCount - 1 do
					local var_686_6 = var_686_5:GetChild(iter_686_8)

					if var_686_6.name == "" or not string.find(var_686_6.name, "split") then
						var_686_6.gameObject:SetActive(true)
					else
						var_686_6.gameObject:SetActive(false)
					end
				end
			end

			local var_686_7 = 0.001

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_7 then
				var_686_5.localPosition = Vector3.Lerp(arg_683_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_683_1.time_ - 0) / var_686_7)
			end

			if arg_683_1.time_ >= 0 + var_686_7 and arg_683_1.time_ < 0 + var_686_7 + arg_686_0 then
				var_686_5.localPosition = Vector3.New(470, -335, -230)
			end

			local var_686_8 = arg_683_1.actors_["10153"].transform

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= 0 + arg_686_0 then
				arg_683_1.var_.moveOldPos10153 = var_686_8.localPosition
				var_686_8.localScale = Vector3.New(1, 1, 1)

				arg_683_1:CheckSpriteTmpPos("10153", 7)

				for iter_686_9 = 0, var_686_8.childCount - 1 do
					local var_686_9 = var_686_8:GetChild(iter_686_9)

					if var_686_9.name == "" or not string.find(var_686_9.name, "split") then
						var_686_9.gameObject:SetActive(true)
					else
						var_686_9.gameObject:SetActive(false)
					end
				end
			end

			local var_686_10 = 0.001

			if 0 <= arg_683_1.time_ and arg_683_1.time_ < 0 + var_686_10 then
				var_686_8.localPosition = Vector3.Lerp(arg_683_1.var_.moveOldPos10153, Vector3.New(0, -2000, 0), (arg_683_1.time_ - 0) / var_686_10)
			end

			if arg_683_1.time_ >= 0 + var_686_10 and arg_683_1.time_ < 0 + var_686_10 + arg_686_0 then
				var_686_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_686_11 = 0
			local var_686_12 = 0.2

			if 0 < arg_683_1.time_ and arg_683_1.time_ <= var_686_11 + arg_686_0 then
				arg_683_1.talkMaxDuration = 0
				arg_683_1.dialogCg_.alpha = 1

				arg_683_1.dialog_:SetActive(true)
				SetActive(arg_683_1.leftNameGo_, true)

				arg_683_1.leftNameTxt_.text = arg_683_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_683_1.leftNameTxt_.transform)

				arg_683_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_683_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_683_1:RecordName(arg_683_1.leftNameTxt_.text)
				SetActive(arg_683_1.iconTrs_.gameObject, false)
				arg_683_1.callingController_:SetSelectedState("normal")

				local var_686_13 = arg_683_1:GetWordFromCfg(424041166)
				local var_686_14 = arg_683_1:FormatText(var_686_13.content)

				arg_683_1.text_.text = var_686_14

				LuaForUtil.ClearLinePrefixSymbol(arg_683_1.text_)

				local var_686_16 = 8 <= 0 and var_686_12 or var_686_12 * (utf8.len(var_686_14) / 8)

				if (8 <= 0 and var_686_12 or var_686_12 * (utf8.len(var_686_14) / 8)) > 0 and var_686_12 < var_686_16 then
					arg_683_1.talkMaxDuration = var_686_16

					if var_686_16 + var_686_11 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_16 + var_686_11
					end
				end

				arg_683_1.text_.text = var_686_14
				arg_683_1.typewritter.percent = 0

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041166", "story_v_out_424041.awb") ~= 0 then
					local var_686_17 = manager.audio:GetVoiceLength("story_v_out_424041", "424041166", "story_v_out_424041.awb") / 1000

					if var_686_17 + var_686_11 > arg_683_1.duration_ then
						arg_683_1.duration_ = var_686_17 + var_686_11
					end

					if var_686_13.prefab_name ~= "" and arg_683_1.actors_[var_686_13.prefab_name] ~= nil then
						local var_686_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_683_1.actors_[var_686_13.prefab_name].transform, "story_v_out_424041", "424041166", "story_v_out_424041.awb")

						arg_683_1:RecordAudio("424041166", var_686_18)
						arg_683_1:RecordAudio("424041166", var_686_18)
					else
						arg_683_1:AudioAction("play", "voice", "story_v_out_424041", "424041166", "story_v_out_424041.awb")
					end

					arg_683_1:RecordHistoryTalkVoice("story_v_out_424041", "424041166", "story_v_out_424041.awb")
				end

				arg_683_1:RecordContent(arg_683_1.text_.text)
			end

			local var_686_19 = math.max(var_686_12, arg_683_1.talkMaxDuration)

			if var_686_11 <= arg_683_1.time_ and arg_683_1.time_ < var_686_11 + var_686_19 then
				arg_683_1.typewritter.percent = (arg_683_1.time_ - var_686_11) / var_686_19

				arg_683_1.typewritter:SetDirty()
			end

			if arg_683_1.time_ >= var_686_11 + var_686_19 and arg_683_1.time_ < var_686_11 + var_686_19 + arg_686_0 then
				arg_683_1.typewritter.percent = 1

				arg_683_1.typewritter:SetDirty()
				arg_683_1:ShowNextGo(true)
			end
		end

		arg_683_1.nodeConfigList_ = {
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
				actorName = "10153",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_683_1:InitPlayNodeList()
	end,
	Play424041167 = function(arg_687_0, arg_687_1)
		arg_687_1.time_ = 0
		arg_687_1.frameCnt_ = 0
		arg_687_1.state_ = "playing"
		arg_687_1.curTalkId_ = 424041167
		arg_687_1.duration_ = 4.37

		local var_687_0 = {
			zh = 3.066,
			ja = 4.366
		}
		local var_687_1 = manager.audio:GetLocalizationFlag()

		if var_687_0[var_687_1] ~= nil then
			arg_687_1.duration_ = var_687_0[var_687_1]
		end

		SetActive(arg_687_1.tipsGo_, false)

		function arg_687_1.onSingleLineFinish_()
			arg_687_1.onSingleLineUpdate_ = nil
			arg_687_1.onSingleLineFinish_ = nil
			arg_687_1.state_ = "waiting"
		end

		function arg_687_1.playNext_(arg_689_0)
			if arg_689_0 == 1 then
				arg_687_0:Play424041168(arg_687_1)
			end
		end

		function arg_687_1.onSingleLineUpdate_(arg_690_0)
			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 and not isNil(arg_687_1.actors_["10154"]) and arg_687_1.var_.actorSpriteComps10154 == nil then
				arg_687_1.var_.actorSpriteComps10154 = arg_687_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_690_0 = 0.2

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_0 and not isNil(arg_687_1.actors_["10154"]) then
				if arg_687_1.var_.actorSpriteComps10154 then
					for iter_690_0, iter_690_1 in pairs(arg_687_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_690_1 then
							if arg_687_1.isInRecall_ then
								iter_690_1.color = Color.New(Mathf.Lerp(iter_690_1.color.r, arg_687_1.hightColor1.r, (arg_687_1.time_ - 0) / var_690_0), Mathf.Lerp(iter_690_1.color.g, arg_687_1.hightColor1.g, (arg_687_1.time_ - 0) / var_690_0), (Mathf.Lerp(iter_690_1.color.b, arg_687_1.hightColor1.b, (arg_687_1.time_ - 0) / var_690_0)))
							else
								local var_690_1 = Mathf.Lerp(iter_690_1.color.r, 1, (arg_687_1.time_ - 0) / var_690_0)

								iter_690_1.color = Color.New(var_690_1, var_690_1, var_690_1)
							end
						end
					end
				end
			end

			if arg_687_1.time_ >= 0 + var_690_0 and arg_687_1.time_ < 0 + var_690_0 + arg_690_0 and not isNil(arg_687_1.actors_["10154"]) and arg_687_1.var_.actorSpriteComps10154 then
				for iter_690_2, iter_690_3 in pairs(arg_687_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_690_3 then
						iter_690_3.color = arg_687_1.isInRecall_ and (arg_687_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_687_1.var_.actorSpriteComps10154 = nil
			end

			local var_690_2 = arg_687_1.actors_["1094"]

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 and not isNil(var_690_2) and arg_687_1.var_.actorSpriteComps1094 == nil then
				arg_687_1.var_.actorSpriteComps1094 = var_690_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_690_3 = 0.2

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_3 and not isNil(var_690_2) then
				if arg_687_1.var_.actorSpriteComps1094 then
					for iter_690_4, iter_690_5 in pairs(arg_687_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_690_5 then
							if arg_687_1.isInRecall_ then
								iter_690_5.color = Color.New(Mathf.Lerp(iter_690_5.color.r, arg_687_1.hightColor2.r, (arg_687_1.time_ - 0) / var_690_3), Mathf.Lerp(iter_690_5.color.g, arg_687_1.hightColor2.g, (arg_687_1.time_ - 0) / var_690_3), (Mathf.Lerp(iter_690_5.color.b, arg_687_1.hightColor2.b, (arg_687_1.time_ - 0) / var_690_3)))
							else
								local var_690_4 = Mathf.Lerp(iter_690_5.color.r, 0.5, (arg_687_1.time_ - 0) / var_690_3)

								iter_690_5.color = Color.New(var_690_4, var_690_4, var_690_4)
							end
						end
					end
				end
			end

			if arg_687_1.time_ >= 0 + var_690_3 and arg_687_1.time_ < 0 + var_690_3 + arg_690_0 and not isNil(var_690_2) and arg_687_1.var_.actorSpriteComps1094 then
				for iter_690_6, iter_690_7 in pairs(arg_687_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_690_7 then
						iter_690_7.color = arg_687_1.isInRecall_ and (arg_687_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_687_1.var_.actorSpriteComps1094 = nil
			end

			local var_690_5 = arg_687_1.actors_["10154"].transform

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= 0 + arg_690_0 then
				arg_687_1.var_.moveOldPos10154 = var_690_5.localPosition
				var_690_5.localScale = Vector3.New(1, 1, 1)

				arg_687_1:CheckSpriteTmpPos("10154", 2)

				for iter_690_8 = 0, var_690_5.childCount - 1 do
					local var_690_6 = var_690_5:GetChild(iter_690_8)

					if var_690_6.name == "" or not string.find(var_690_6.name, "split") then
						var_690_6.gameObject:SetActive(true)
					else
						var_690_6.gameObject:SetActive(false)
					end
				end
			end

			local var_690_7 = 0.001

			if 0 <= arg_687_1.time_ and arg_687_1.time_ < 0 + var_690_7 then
				var_690_5.localPosition = Vector3.Lerp(arg_687_1.var_.moveOldPos10154, Vector3.New(-375, -338, -538), (arg_687_1.time_ - 0) / var_690_7)
			end

			if arg_687_1.time_ >= 0 + var_690_7 and arg_687_1.time_ < 0 + var_690_7 + arg_690_0 then
				var_690_5.localPosition = Vector3.New(-375, -338, -538)
			end

			local var_690_8 = 0
			local var_690_9 = 0.375

			if 0 < arg_687_1.time_ and arg_687_1.time_ <= var_690_8 + arg_690_0 then
				arg_687_1.talkMaxDuration = 0
				arg_687_1.dialogCg_.alpha = 1

				arg_687_1.dialog_:SetActive(true)
				SetActive(arg_687_1.leftNameGo_, true)

				arg_687_1.leftNameTxt_.text = arg_687_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_687_1.leftNameTxt_.transform)

				arg_687_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_687_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_687_1:RecordName(arg_687_1.leftNameTxt_.text)
				SetActive(arg_687_1.iconTrs_.gameObject, false)
				arg_687_1.callingController_:SetSelectedState("normal")

				local var_690_10 = arg_687_1:GetWordFromCfg(424041167)
				local var_690_11 = arg_687_1:FormatText(var_690_10.content)

				arg_687_1.text_.text = var_690_11

				LuaForUtil.ClearLinePrefixSymbol(arg_687_1.text_)

				local var_690_13 = 15 <= 0 and var_690_9 or var_690_9 * (utf8.len(var_690_11) / 15)

				if (15 <= 0 and var_690_9 or var_690_9 * (utf8.len(var_690_11) / 15)) > 0 and var_690_9 < var_690_13 then
					arg_687_1.talkMaxDuration = var_690_13

					if var_690_13 + var_690_8 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_13 + var_690_8
					end
				end

				arg_687_1.text_.text = var_690_11
				arg_687_1.typewritter.percent = 0

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041167", "story_v_out_424041.awb") ~= 0 then
					local var_690_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041167", "story_v_out_424041.awb") / 1000

					if var_690_14 + var_690_8 > arg_687_1.duration_ then
						arg_687_1.duration_ = var_690_14 + var_690_8
					end

					if var_690_10.prefab_name ~= "" and arg_687_1.actors_[var_690_10.prefab_name] ~= nil then
						local var_690_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_687_1.actors_[var_690_10.prefab_name].transform, "story_v_out_424041", "424041167", "story_v_out_424041.awb")

						arg_687_1:RecordAudio("424041167", var_690_15)
						arg_687_1:RecordAudio("424041167", var_690_15)
					else
						arg_687_1:AudioAction("play", "voice", "story_v_out_424041", "424041167", "story_v_out_424041.awb")
					end

					arg_687_1:RecordHistoryTalkVoice("story_v_out_424041", "424041167", "story_v_out_424041.awb")
				end

				arg_687_1:RecordContent(arg_687_1.text_.text)
			end

			local var_690_16 = math.max(var_690_9, arg_687_1.talkMaxDuration)

			if var_690_8 <= arg_687_1.time_ and arg_687_1.time_ < var_690_8 + var_690_16 then
				arg_687_1.typewritter.percent = (arg_687_1.time_ - var_690_8) / var_690_16

				arg_687_1.typewritter:SetDirty()
			end

			if arg_687_1.time_ >= var_690_8 + var_690_16 and arg_687_1.time_ < var_690_8 + var_690_16 + arg_690_0 then
				arg_687_1.typewritter.percent = 1

				arg_687_1.typewritter:SetDirty()
				arg_687_1:ShowNextGo(true)
			end
		end

		arg_687_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_687_1:InitPlayNodeList()
	end,
	Play424041168 = function(arg_691_0, arg_691_1)
		arg_691_1.time_ = 0
		arg_691_1.frameCnt_ = 0
		arg_691_1.state_ = "playing"
		arg_691_1.curTalkId_ = 424041168
		arg_691_1.duration_ = 1

		local var_691_0 = {
			zh = 0.999999999999,
			ja = 1
		}
		local var_691_1 = manager.audio:GetLocalizationFlag()

		if var_691_0[var_691_1] ~= nil then
			arg_691_1.duration_ = var_691_0[var_691_1]
		end

		SetActive(arg_691_1.tipsGo_, false)

		function arg_691_1.onSingleLineFinish_()
			arg_691_1.onSingleLineUpdate_ = nil
			arg_691_1.onSingleLineFinish_ = nil
			arg_691_1.state_ = "waiting"
		end

		function arg_691_1.playNext_(arg_693_0)
			if arg_693_0 == 1 then
				arg_691_0:Play424041169(arg_691_1)
			end
		end

		function arg_691_1.onSingleLineUpdate_(arg_694_0)
			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 and not isNil(arg_691_1.actors_["1094"]) and arg_691_1.var_.actorSpriteComps1094 == nil then
				arg_691_1.var_.actorSpriteComps1094 = arg_691_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_694_0 = 0.2

			if 0 <= arg_691_1.time_ and arg_691_1.time_ < 0 + var_694_0 and not isNil(arg_691_1.actors_["1094"]) then
				if arg_691_1.var_.actorSpriteComps1094 then
					for iter_694_0, iter_694_1 in pairs(arg_691_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_694_1 then
							if arg_691_1.isInRecall_ then
								iter_694_1.color = Color.New(Mathf.Lerp(iter_694_1.color.r, arg_691_1.hightColor1.r, (arg_691_1.time_ - 0) / var_694_0), Mathf.Lerp(iter_694_1.color.g, arg_691_1.hightColor1.g, (arg_691_1.time_ - 0) / var_694_0), (Mathf.Lerp(iter_694_1.color.b, arg_691_1.hightColor1.b, (arg_691_1.time_ - 0) / var_694_0)))
							else
								local var_694_1 = Mathf.Lerp(iter_694_1.color.r, 1, (arg_691_1.time_ - 0) / var_694_0)

								iter_694_1.color = Color.New(var_694_1, var_694_1, var_694_1)
							end
						end
					end
				end
			end

			if arg_691_1.time_ >= 0 + var_694_0 and arg_691_1.time_ < 0 + var_694_0 + arg_694_0 and not isNil(arg_691_1.actors_["1094"]) and arg_691_1.var_.actorSpriteComps1094 then
				for iter_694_2, iter_694_3 in pairs(arg_691_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_694_3 then
						iter_694_3.color = arg_691_1.isInRecall_ and (arg_691_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_691_1.var_.actorSpriteComps1094 = nil
			end

			local var_694_2 = arg_691_1.actors_["10154"]

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 and not isNil(var_694_2) and arg_691_1.var_.actorSpriteComps10154 == nil then
				arg_691_1.var_.actorSpriteComps10154 = var_694_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_694_3 = 0.2

			if 0 <= arg_691_1.time_ and arg_691_1.time_ < 0 + var_694_3 and not isNil(var_694_2) then
				if arg_691_1.var_.actorSpriteComps10154 then
					for iter_694_4, iter_694_5 in pairs(arg_691_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_694_5 then
							if arg_691_1.isInRecall_ then
								iter_694_5.color = Color.New(Mathf.Lerp(iter_694_5.color.r, arg_691_1.hightColor2.r, (arg_691_1.time_ - 0) / var_694_3), Mathf.Lerp(iter_694_5.color.g, arg_691_1.hightColor2.g, (arg_691_1.time_ - 0) / var_694_3), (Mathf.Lerp(iter_694_5.color.b, arg_691_1.hightColor2.b, (arg_691_1.time_ - 0) / var_694_3)))
							else
								local var_694_4 = Mathf.Lerp(iter_694_5.color.r, 0.5, (arg_691_1.time_ - 0) / var_694_3)

								iter_694_5.color = Color.New(var_694_4, var_694_4, var_694_4)
							end
						end
					end
				end
			end

			if arg_691_1.time_ >= 0 + var_694_3 and arg_691_1.time_ < 0 + var_694_3 + arg_694_0 and not isNil(var_694_2) and arg_691_1.var_.actorSpriteComps10154 then
				for iter_694_6, iter_694_7 in pairs(arg_691_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_694_7 then
						iter_694_7.color = arg_691_1.isInRecall_ and (arg_691_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_691_1.var_.actorSpriteComps10154 = nil
			end

			local var_694_5 = arg_691_1.actors_["1094"].transform

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= 0 + arg_694_0 then
				arg_691_1.var_.moveOldPos1094 = var_694_5.localPosition
				var_694_5.localScale = Vector3.New(1, 1, 1)

				arg_691_1:CheckSpriteTmpPos("1094", 4)

				for iter_694_8 = 0, var_694_5.childCount - 1 do
					local var_694_6 = var_694_5:GetChild(iter_694_8)

					if var_694_6.name == "" or not string.find(var_694_6.name, "split") then
						var_694_6.gameObject:SetActive(true)
					else
						var_694_6.gameObject:SetActive(false)
					end
				end
			end

			local var_694_7 = 0.001

			if 0 <= arg_691_1.time_ and arg_691_1.time_ < 0 + var_694_7 then
				var_694_5.localPosition = Vector3.Lerp(arg_691_1.var_.moveOldPos1094, Vector3.New(470, -335, -230), (arg_691_1.time_ - 0) / var_694_7)
			end

			if arg_691_1.time_ >= 0 + var_694_7 and arg_691_1.time_ < 0 + var_694_7 + arg_694_0 then
				var_694_5.localPosition = Vector3.New(470, -335, -230)
			end

			local var_694_8 = 0
			local var_694_9 = 0.05

			if 0 < arg_691_1.time_ and arg_691_1.time_ <= var_694_8 + arg_694_0 then
				arg_691_1.talkMaxDuration = 0
				arg_691_1.dialogCg_.alpha = 1

				arg_691_1.dialog_:SetActive(true)
				SetActive(arg_691_1.leftNameGo_, true)

				arg_691_1.leftNameTxt_.text = arg_691_1:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_691_1.leftNameTxt_.transform)

				arg_691_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_691_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_691_1:RecordName(arg_691_1.leftNameTxt_.text)
				SetActive(arg_691_1.iconTrs_.gameObject, false)
				arg_691_1.callingController_:SetSelectedState("normal")

				local var_694_10 = arg_691_1:GetWordFromCfg(424041168)
				local var_694_11 = arg_691_1:FormatText(var_694_10.content)

				arg_691_1.text_.text = var_694_11

				LuaForUtil.ClearLinePrefixSymbol(arg_691_1.text_)

				local var_694_13 = 2 <= 0 and var_694_9 or var_694_9 * (utf8.len(var_694_11) / 2)

				if (2 <= 0 and var_694_9 or var_694_9 * (utf8.len(var_694_11) / 2)) > 0 and var_694_9 < var_694_13 then
					arg_691_1.talkMaxDuration = var_694_13

					if var_694_13 + var_694_8 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_13 + var_694_8
					end
				end

				arg_691_1.text_.text = var_694_11
				arg_691_1.typewritter.percent = 0

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041168", "story_v_out_424041.awb") ~= 0 then
					local var_694_14 = manager.audio:GetVoiceLength("story_v_out_424041", "424041168", "story_v_out_424041.awb") / 1000

					if var_694_14 + var_694_8 > arg_691_1.duration_ then
						arg_691_1.duration_ = var_694_14 + var_694_8
					end

					if var_694_10.prefab_name ~= "" and arg_691_1.actors_[var_694_10.prefab_name] ~= nil then
						local var_694_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_691_1.actors_[var_694_10.prefab_name].transform, "story_v_out_424041", "424041168", "story_v_out_424041.awb")

						arg_691_1:RecordAudio("424041168", var_694_15)
						arg_691_1:RecordAudio("424041168", var_694_15)
					else
						arg_691_1:AudioAction("play", "voice", "story_v_out_424041", "424041168", "story_v_out_424041.awb")
					end

					arg_691_1:RecordHistoryTalkVoice("story_v_out_424041", "424041168", "story_v_out_424041.awb")
				end

				arg_691_1:RecordContent(arg_691_1.text_.text)
			end

			local var_694_16 = math.max(var_694_9, arg_691_1.talkMaxDuration)

			if var_694_8 <= arg_691_1.time_ and arg_691_1.time_ < var_694_8 + var_694_16 then
				arg_691_1.typewritter.percent = (arg_691_1.time_ - var_694_8) / var_694_16

				arg_691_1.typewritter:SetDirty()
			end

			if arg_691_1.time_ >= var_694_8 + var_694_16 and arg_691_1.time_ < var_694_8 + var_694_16 + arg_694_0 then
				arg_691_1.typewritter.percent = 1

				arg_691_1.typewritter:SetDirty()
				arg_691_1:ShowNextGo(true)
			end
		end

		arg_691_1.nodeConfigList_ = {
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

		arg_691_1:InitPlayNodeList()
	end,
	Play424041169 = function(arg_695_0, arg_695_1)
		arg_695_1.time_ = 0
		arg_695_1.frameCnt_ = 0
		arg_695_1.state_ = "playing"
		arg_695_1.curTalkId_ = 424041169
		arg_695_1.duration_ = 5

		SetActive(arg_695_1.tipsGo_, false)

		function arg_695_1.onSingleLineFinish_()
			arg_695_1.onSingleLineUpdate_ = nil
			arg_695_1.onSingleLineFinish_ = nil
			arg_695_1.state_ = "waiting"
		end

		function arg_695_1.playNext_(arg_697_0)
			if arg_697_0 == 1 then
				arg_695_0:Play424041170(arg_695_1)
			end
		end

		function arg_695_1.onSingleLineUpdate_(arg_698_0)
			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 and not isNil(arg_695_1.actors_["1094"]) and arg_695_1.var_.actorSpriteComps1094 == nil then
				arg_695_1.var_.actorSpriteComps1094 = arg_695_1.actors_["1094"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_698_0 = 0.2

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_0 and not isNil(arg_695_1.actors_["1094"]) then
				if arg_695_1.var_.actorSpriteComps1094 then
					for iter_698_0, iter_698_1 in pairs(arg_695_1.var_.actorSpriteComps1094:ToTable()) do
						if iter_698_1 then
							if arg_695_1.isInRecall_ then
								iter_698_1.color = Color.New(Mathf.Lerp(iter_698_1.color.r, arg_695_1.hightColor2.r, (arg_695_1.time_ - 0) / var_698_0), Mathf.Lerp(iter_698_1.color.g, arg_695_1.hightColor2.g, (arg_695_1.time_ - 0) / var_698_0), (Mathf.Lerp(iter_698_1.color.b, arg_695_1.hightColor2.b, (arg_695_1.time_ - 0) / var_698_0)))
							else
								local var_698_1 = Mathf.Lerp(iter_698_1.color.r, 0.5, (arg_695_1.time_ - 0) / var_698_0)

								iter_698_1.color = Color.New(var_698_1, var_698_1, var_698_1)
							end
						end
					end
				end
			end

			if arg_695_1.time_ >= 0 + var_698_0 and arg_695_1.time_ < 0 + var_698_0 + arg_698_0 and not isNil(arg_695_1.actors_["1094"]) and arg_695_1.var_.actorSpriteComps1094 then
				for iter_698_2, iter_698_3 in pairs(arg_695_1.var_.actorSpriteComps1094:ToTable()) do
					if iter_698_3 then
						iter_698_3.color = arg_695_1.isInRecall_ and (arg_695_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_695_1.var_.actorSpriteComps1094 = nil
			end

			local var_698_2 = arg_695_1.actors_["1094"].transform

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 then
				arg_695_1.var_.moveOldPos1094 = var_698_2.localPosition
				var_698_2.localScale = Vector3.New(1, 1, 1)

				arg_695_1:CheckSpriteTmpPos("1094", 7)

				for iter_698_4 = 0, var_698_2.childCount - 1 do
					local var_698_3 = var_698_2:GetChild(iter_698_4)

					if var_698_3.name == "" or not string.find(var_698_3.name, "split") then
						var_698_3.gameObject:SetActive(true)
					else
						var_698_3.gameObject:SetActive(false)
					end
				end
			end

			local var_698_4 = 0.001

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_4 then
				var_698_2.localPosition = Vector3.Lerp(arg_695_1.var_.moveOldPos1094, Vector3.New(0, -2000, 0), (arg_695_1.time_ - 0) / var_698_4)
			end

			if arg_695_1.time_ >= 0 + var_698_4 and arg_695_1.time_ < 0 + var_698_4 + arg_698_0 then
				var_698_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_698_5 = arg_695_1.actors_["10154"].transform

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= 0 + arg_698_0 then
				arg_695_1.var_.moveOldPos10154 = var_698_5.localPosition
				var_698_5.localScale = Vector3.New(1, 1, 1)

				arg_695_1:CheckSpriteTmpPos("10154", 7)

				for iter_698_5 = 0, var_698_5.childCount - 1 do
					local var_698_6 = var_698_5:GetChild(iter_698_5)

					if var_698_6.name == "" or not string.find(var_698_6.name, "split") then
						var_698_6.gameObject:SetActive(true)
					else
						var_698_6.gameObject:SetActive(false)
					end
				end
			end

			local var_698_7 = 0.001

			if 0 <= arg_695_1.time_ and arg_695_1.time_ < 0 + var_698_7 then
				var_698_5.localPosition = Vector3.Lerp(arg_695_1.var_.moveOldPos10154, Vector3.New(0, -2000, 0), (arg_695_1.time_ - 0) / var_698_7)
			end

			if arg_695_1.time_ >= 0 + var_698_7 and arg_695_1.time_ < 0 + var_698_7 + arg_698_0 then
				var_698_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_698_8 = 0
			local var_698_9 = 0.85

			if 0 < arg_695_1.time_ and arg_695_1.time_ <= var_698_8 + arg_698_0 then
				arg_695_1.talkMaxDuration = 0
				arg_695_1.dialogCg_.alpha = 1

				arg_695_1.dialog_:SetActive(true)
				SetActive(arg_695_1.leftNameGo_, false)

				arg_695_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_695_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_695_1:RecordName(arg_695_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_695_1.iconTrs_.gameObject, false)
				arg_695_1.callingController_:SetSelectedState("normal")

				local var_698_10 = arg_695_1:FormatText(arg_695_1:GetWordFromCfg(424041169).content)

				arg_695_1.text_.text = var_698_10

				LuaForUtil.ClearLinePrefixSymbol(arg_695_1.text_)

				local var_698_12 = 34 <= 0 and var_698_9 or var_698_9 * (utf8.len(var_698_10) / 34)

				if (34 <= 0 and var_698_9 or var_698_9 * (utf8.len(var_698_10) / 34)) > 0 and var_698_9 < var_698_12 then
					arg_695_1.talkMaxDuration = var_698_12

					if var_698_12 + var_698_8 > arg_695_1.duration_ then
						arg_695_1.duration_ = var_698_12 + var_698_8
					end
				end

				arg_695_1.text_.text = var_698_10
				arg_695_1.typewritter.percent = 0

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(false)
				arg_695_1:RecordContent(arg_695_1.text_.text)
			end

			local var_698_13 = math.max(var_698_9, arg_695_1.talkMaxDuration)

			if var_698_8 <= arg_695_1.time_ and arg_695_1.time_ < var_698_8 + var_698_13 then
				arg_695_1.typewritter.percent = (arg_695_1.time_ - var_698_8) / var_698_13

				arg_695_1.typewritter:SetDirty()
			end

			if arg_695_1.time_ >= var_698_8 + var_698_13 and arg_695_1.time_ < var_698_8 + var_698_13 + arg_698_0 then
				arg_695_1.typewritter.percent = 1

				arg_695_1.typewritter:SetDirty()
				arg_695_1:ShowNextGo(true)
			end
		end

		arg_695_1.nodeConfigList_ = {
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
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_695_1:InitPlayNodeList()
	end,
	Play424041170 = function(arg_699_0, arg_699_1)
		arg_699_1.time_ = 0
		arg_699_1.frameCnt_ = 0
		arg_699_1.state_ = "playing"
		arg_699_1.curTalkId_ = 424041170
		arg_699_1.duration_ = 4.1

		local var_699_0 = {
			zh = 4.1,
			ja = 2.533
		}
		local var_699_1 = manager.audio:GetLocalizationFlag()

		if var_699_0[var_699_1] ~= nil then
			arg_699_1.duration_ = var_699_0[var_699_1]
		end

		SetActive(arg_699_1.tipsGo_, false)

		function arg_699_1.onSingleLineFinish_()
			arg_699_1.onSingleLineUpdate_ = nil
			arg_699_1.onSingleLineFinish_ = nil
			arg_699_1.state_ = "waiting"
		end

		function arg_699_1.playNext_(arg_701_0)
			if arg_701_0 == 1 then
				arg_699_0:Play424041171(arg_699_1)
			end
		end

		function arg_699_1.onSingleLineUpdate_(arg_702_0)
			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 and not isNil(arg_699_1.actors_["10154"]) and arg_699_1.var_.actorSpriteComps10154 == nil then
				arg_699_1.var_.actorSpriteComps10154 = arg_699_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_702_0 = 0.2

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_0 and not isNil(arg_699_1.actors_["10154"]) then
				if arg_699_1.var_.actorSpriteComps10154 then
					for iter_702_0, iter_702_1 in pairs(arg_699_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_702_1 then
							if arg_699_1.isInRecall_ then
								iter_702_1.color = Color.New(Mathf.Lerp(iter_702_1.color.r, arg_699_1.hightColor1.r, (arg_699_1.time_ - 0) / var_702_0), Mathf.Lerp(iter_702_1.color.g, arg_699_1.hightColor1.g, (arg_699_1.time_ - 0) / var_702_0), (Mathf.Lerp(iter_702_1.color.b, arg_699_1.hightColor1.b, (arg_699_1.time_ - 0) / var_702_0)))
							else
								local var_702_1 = Mathf.Lerp(iter_702_1.color.r, 1, (arg_699_1.time_ - 0) / var_702_0)

								iter_702_1.color = Color.New(var_702_1, var_702_1, var_702_1)
							end
						end
					end
				end
			end

			if arg_699_1.time_ >= 0 + var_702_0 and arg_699_1.time_ < 0 + var_702_0 + arg_702_0 and not isNil(arg_699_1.actors_["10154"]) and arg_699_1.var_.actorSpriteComps10154 then
				for iter_702_2, iter_702_3 in pairs(arg_699_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_702_3 then
						iter_702_3.color = arg_699_1.isInRecall_ and (arg_699_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_699_1.var_.actorSpriteComps10154 = nil
			end

			local var_702_2 = arg_699_1.actors_["10154"].transform

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= 0 + arg_702_0 then
				arg_699_1.var_.moveOldPos10154 = var_702_2.localPosition
				var_702_2.localScale = Vector3.New(1, 1, 1)

				arg_699_1:CheckSpriteTmpPos("10154", 3)

				for iter_702_4 = 0, var_702_2.childCount - 1 do
					local var_702_3 = var_702_2:GetChild(iter_702_4)

					if var_702_3.name == "" or not string.find(var_702_3.name, "split") then
						var_702_3.gameObject:SetActive(true)
					else
						var_702_3.gameObject:SetActive(false)
					end
				end
			end

			local var_702_4 = 0.001

			if 0 <= arg_699_1.time_ and arg_699_1.time_ < 0 + var_702_4 then
				var_702_2.localPosition = Vector3.Lerp(arg_699_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_699_1.time_ - 0) / var_702_4)
			end

			if arg_699_1.time_ >= 0 + var_702_4 and arg_699_1.time_ < 0 + var_702_4 + arg_702_0 then
				var_702_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_702_5 = 0
			local var_702_6 = 0.7

			if 0 < arg_699_1.time_ and arg_699_1.time_ <= var_702_5 + arg_702_0 then
				arg_699_1.talkMaxDuration = 0
				arg_699_1.dialogCg_.alpha = 1

				arg_699_1.dialog_:SetActive(true)
				SetActive(arg_699_1.leftNameGo_, true)

				arg_699_1.leftNameTxt_.text = arg_699_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_699_1.leftNameTxt_.transform)

				arg_699_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_699_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_699_1:RecordName(arg_699_1.leftNameTxt_.text)
				SetActive(arg_699_1.iconTrs_.gameObject, false)
				arg_699_1.callingController_:SetSelectedState("normal")

				local var_702_7 = arg_699_1:GetWordFromCfg(424041170)
				local var_702_8 = arg_699_1:FormatText(var_702_7.content)

				arg_699_1.text_.text = var_702_8

				LuaForUtil.ClearLinePrefixSymbol(arg_699_1.text_)

				local var_702_10 = 28 <= 0 and var_702_6 or var_702_6 * (utf8.len(var_702_8) / 28)

				if (28 <= 0 and var_702_6 or var_702_6 * (utf8.len(var_702_8) / 28)) > 0 and var_702_6 < var_702_10 then
					arg_699_1.talkMaxDuration = var_702_10

					if var_702_10 + var_702_5 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_10 + var_702_5
					end
				end

				arg_699_1.text_.text = var_702_8
				arg_699_1.typewritter.percent = 0

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041170", "story_v_out_424041.awb") ~= 0 then
					local var_702_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041170", "story_v_out_424041.awb") / 1000

					if var_702_11 + var_702_5 > arg_699_1.duration_ then
						arg_699_1.duration_ = var_702_11 + var_702_5
					end

					if var_702_7.prefab_name ~= "" and arg_699_1.actors_[var_702_7.prefab_name] ~= nil then
						local var_702_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_699_1.actors_[var_702_7.prefab_name].transform, "story_v_out_424041", "424041170", "story_v_out_424041.awb")

						arg_699_1:RecordAudio("424041170", var_702_12)
						arg_699_1:RecordAudio("424041170", var_702_12)
					else
						arg_699_1:AudioAction("play", "voice", "story_v_out_424041", "424041170", "story_v_out_424041.awb")
					end

					arg_699_1:RecordHistoryTalkVoice("story_v_out_424041", "424041170", "story_v_out_424041.awb")
				end

				arg_699_1:RecordContent(arg_699_1.text_.text)
			end

			local var_702_13 = math.max(var_702_6, arg_699_1.talkMaxDuration)

			if var_702_5 <= arg_699_1.time_ and arg_699_1.time_ < var_702_5 + var_702_13 then
				arg_699_1.typewritter.percent = (arg_699_1.time_ - var_702_5) / var_702_13

				arg_699_1.typewritter:SetDirty()
			end

			if arg_699_1.time_ >= var_702_5 + var_702_13 and arg_699_1.time_ < var_702_5 + var_702_13 + arg_702_0 then
				arg_699_1.typewritter.percent = 1

				arg_699_1.typewritter:SetDirty()
				arg_699_1:ShowNextGo(true)
			end
		end

		arg_699_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_699_1:InitPlayNodeList()
	end,
	Play424041171 = function(arg_703_0, arg_703_1)
		arg_703_1.time_ = 0
		arg_703_1.frameCnt_ = 0
		arg_703_1.state_ = "playing"
		arg_703_1.curTalkId_ = 424041171
		arg_703_1.duration_ = 5

		SetActive(arg_703_1.tipsGo_, false)

		function arg_703_1.onSingleLineFinish_()
			arg_703_1.onSingleLineUpdate_ = nil
			arg_703_1.onSingleLineFinish_ = nil
			arg_703_1.state_ = "waiting"
		end

		function arg_703_1.playNext_(arg_705_0)
			if arg_705_0 == 1 then
				arg_703_0:Play424041172(arg_703_1)
			end
		end

		function arg_703_1.onSingleLineUpdate_(arg_706_0)
			if 0 < arg_703_1.time_ and arg_703_1.time_ <= 0 + arg_706_0 and not isNil(arg_703_1.actors_["10154"]) and arg_703_1.var_.actorSpriteComps10154 == nil then
				arg_703_1.var_.actorSpriteComps10154 = arg_703_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_706_0 = 0.2

			if 0 <= arg_703_1.time_ and arg_703_1.time_ < 0 + var_706_0 and not isNil(arg_703_1.actors_["10154"]) then
				if arg_703_1.var_.actorSpriteComps10154 then
					for iter_706_0, iter_706_1 in pairs(arg_703_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_706_1 then
							if arg_703_1.isInRecall_ then
								iter_706_1.color = Color.New(Mathf.Lerp(iter_706_1.color.r, arg_703_1.hightColor2.r, (arg_703_1.time_ - 0) / var_706_0), Mathf.Lerp(iter_706_1.color.g, arg_703_1.hightColor2.g, (arg_703_1.time_ - 0) / var_706_0), (Mathf.Lerp(iter_706_1.color.b, arg_703_1.hightColor2.b, (arg_703_1.time_ - 0) / var_706_0)))
							else
								local var_706_1 = Mathf.Lerp(iter_706_1.color.r, 0.5, (arg_703_1.time_ - 0) / var_706_0)

								iter_706_1.color = Color.New(var_706_1, var_706_1, var_706_1)
							end
						end
					end
				end
			end

			if arg_703_1.time_ >= 0 + var_706_0 and arg_703_1.time_ < 0 + var_706_0 + arg_706_0 and not isNil(arg_703_1.actors_["10154"]) and arg_703_1.var_.actorSpriteComps10154 then
				for iter_706_2, iter_706_3 in pairs(arg_703_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_706_3 then
						iter_706_3.color = arg_703_1.isInRecall_ and (arg_703_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_703_1.var_.actorSpriteComps10154 = nil
			end

			local var_706_2 = 0
			local var_706_3 = 0.3

			if 0 < arg_703_1.time_ and arg_703_1.time_ <= var_706_2 + arg_706_0 then
				arg_703_1.talkMaxDuration = 0
				arg_703_1.dialogCg_.alpha = 1

				arg_703_1.dialog_:SetActive(true)
				SetActive(arg_703_1.leftNameGo_, true)

				arg_703_1.leftNameTxt_.text = arg_703_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_703_1.leftNameTxt_.transform)

				arg_703_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_703_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_703_1:RecordName(arg_703_1.leftNameTxt_.text)
				SetActive(arg_703_1.iconTrs_.gameObject, true)
				arg_703_1.iconController_:SetSelectedState("hero")

				arg_703_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_703_1.callingController_:SetSelectedState("normal")

				arg_703_1.keyicon_.color = Color.New(1, 1, 1)
				arg_703_1.icon_.color = Color.New(1, 1, 1)

				local var_706_4 = arg_703_1:FormatText(arg_703_1:GetWordFromCfg(424041171).content)

				arg_703_1.text_.text = var_706_4

				LuaForUtil.ClearLinePrefixSymbol(arg_703_1.text_)

				local var_706_6 = 12 <= 0 and var_706_3 or var_706_3 * (utf8.len(var_706_4) / 12)

				if (12 <= 0 and var_706_3 or var_706_3 * (utf8.len(var_706_4) / 12)) > 0 and var_706_3 < var_706_6 then
					arg_703_1.talkMaxDuration = var_706_6

					if var_706_6 + var_706_2 > arg_703_1.duration_ then
						arg_703_1.duration_ = var_706_6 + var_706_2
					end
				end

				arg_703_1.text_.text = var_706_4
				arg_703_1.typewritter.percent = 0

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(false)
				arg_703_1:RecordContent(arg_703_1.text_.text)
			end

			local var_706_7 = math.max(var_706_3, arg_703_1.talkMaxDuration)

			if var_706_2 <= arg_703_1.time_ and arg_703_1.time_ < var_706_2 + var_706_7 then
				arg_703_1.typewritter.percent = (arg_703_1.time_ - var_706_2) / var_706_7

				arg_703_1.typewritter:SetDirty()
			end

			if arg_703_1.time_ >= var_706_2 + var_706_7 and arg_703_1.time_ < var_706_2 + var_706_7 + arg_706_0 then
				arg_703_1.typewritter.percent = 1

				arg_703_1.typewritter:SetDirty()
				arg_703_1:ShowNextGo(true)
			end
		end

		arg_703_1.nodeConfigList_ = {}

		arg_703_1:InitPlayNodeList()
	end,
	Play424041172 = function(arg_707_0, arg_707_1)
		arg_707_1.time_ = 0
		arg_707_1.frameCnt_ = 0
		arg_707_1.state_ = "playing"
		arg_707_1.curTalkId_ = 424041172
		arg_707_1.duration_ = 4.87

		local var_707_0 = {
			zh = 4.666,
			ja = 4.866
		}
		local var_707_1 = manager.audio:GetLocalizationFlag()

		if var_707_0[var_707_1] ~= nil then
			arg_707_1.duration_ = var_707_0[var_707_1]
		end

		SetActive(arg_707_1.tipsGo_, false)

		function arg_707_1.onSingleLineFinish_()
			arg_707_1.onSingleLineUpdate_ = nil
			arg_707_1.onSingleLineFinish_ = nil
			arg_707_1.state_ = "waiting"
		end

		function arg_707_1.playNext_(arg_709_0)
			if arg_709_0 == 1 then
				arg_707_0:Play424041173(arg_707_1)
			end
		end

		function arg_707_1.onSingleLineUpdate_(arg_710_0)
			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 and not isNil(arg_707_1.actors_["10154"]) and arg_707_1.var_.actorSpriteComps10154 == nil then
				arg_707_1.var_.actorSpriteComps10154 = arg_707_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_710_0 = 0.2

			if 0 <= arg_707_1.time_ and arg_707_1.time_ < 0 + var_710_0 and not isNil(arg_707_1.actors_["10154"]) then
				if arg_707_1.var_.actorSpriteComps10154 then
					for iter_710_0, iter_710_1 in pairs(arg_707_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_710_1 then
							if arg_707_1.isInRecall_ then
								iter_710_1.color = Color.New(Mathf.Lerp(iter_710_1.color.r, arg_707_1.hightColor1.r, (arg_707_1.time_ - 0) / var_710_0), Mathf.Lerp(iter_710_1.color.g, arg_707_1.hightColor1.g, (arg_707_1.time_ - 0) / var_710_0), (Mathf.Lerp(iter_710_1.color.b, arg_707_1.hightColor1.b, (arg_707_1.time_ - 0) / var_710_0)))
							else
								local var_710_1 = Mathf.Lerp(iter_710_1.color.r, 1, (arg_707_1.time_ - 0) / var_710_0)

								iter_710_1.color = Color.New(var_710_1, var_710_1, var_710_1)
							end
						end
					end
				end
			end

			if arg_707_1.time_ >= 0 + var_710_0 and arg_707_1.time_ < 0 + var_710_0 + arg_710_0 and not isNil(arg_707_1.actors_["10154"]) and arg_707_1.var_.actorSpriteComps10154 then
				for iter_710_2, iter_710_3 in pairs(arg_707_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_710_3 then
						iter_710_3.color = arg_707_1.isInRecall_ and (arg_707_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_707_1.var_.actorSpriteComps10154 = nil
			end

			local var_710_2 = arg_707_1.actors_["10154"].transform

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= 0 + arg_710_0 then
				arg_707_1.var_.moveOldPos10154 = var_710_2.localPosition
				var_710_2.localScale = Vector3.New(1, 1, 1)

				arg_707_1:CheckSpriteTmpPos("10154", 3)

				for iter_710_4 = 0, var_710_2.childCount - 1 do
					local var_710_3 = var_710_2:GetChild(iter_710_4)

					if var_710_3.name == "" or not string.find(var_710_3.name, "split") then
						var_710_3.gameObject:SetActive(true)
					else
						var_710_3.gameObject:SetActive(false)
					end
				end
			end

			local var_710_4 = 0.001

			if 0 <= arg_707_1.time_ and arg_707_1.time_ < 0 + var_710_4 then
				var_710_2.localPosition = Vector3.Lerp(arg_707_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_707_1.time_ - 0) / var_710_4)
			end

			if arg_707_1.time_ >= 0 + var_710_4 and arg_707_1.time_ < 0 + var_710_4 + arg_710_0 then
				var_710_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_710_5 = 0
			local var_710_6 = 0.425

			if 0 < arg_707_1.time_ and arg_707_1.time_ <= var_710_5 + arg_710_0 then
				arg_707_1.talkMaxDuration = 0
				arg_707_1.dialogCg_.alpha = 1

				arg_707_1.dialog_:SetActive(true)
				SetActive(arg_707_1.leftNameGo_, true)

				arg_707_1.leftNameTxt_.text = arg_707_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_707_1.leftNameTxt_.transform)

				arg_707_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_707_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_707_1:RecordName(arg_707_1.leftNameTxt_.text)
				SetActive(arg_707_1.iconTrs_.gameObject, false)
				arg_707_1.callingController_:SetSelectedState("normal")

				local var_710_7 = arg_707_1:GetWordFromCfg(424041172)
				local var_710_8 = arg_707_1:FormatText(var_710_7.content)

				arg_707_1.text_.text = var_710_8

				LuaForUtil.ClearLinePrefixSymbol(arg_707_1.text_)

				local var_710_10 = 17 <= 0 and var_710_6 or var_710_6 * (utf8.len(var_710_8) / 17)

				if (17 <= 0 and var_710_6 or var_710_6 * (utf8.len(var_710_8) / 17)) > 0 and var_710_6 < var_710_10 then
					arg_707_1.talkMaxDuration = var_710_10

					if var_710_10 + var_710_5 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_10 + var_710_5
					end
				end

				arg_707_1.text_.text = var_710_8
				arg_707_1.typewritter.percent = 0

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041172", "story_v_out_424041.awb") ~= 0 then
					local var_710_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041172", "story_v_out_424041.awb") / 1000

					if var_710_11 + var_710_5 > arg_707_1.duration_ then
						arg_707_1.duration_ = var_710_11 + var_710_5
					end

					if var_710_7.prefab_name ~= "" and arg_707_1.actors_[var_710_7.prefab_name] ~= nil then
						local var_710_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_707_1.actors_[var_710_7.prefab_name].transform, "story_v_out_424041", "424041172", "story_v_out_424041.awb")

						arg_707_1:RecordAudio("424041172", var_710_12)
						arg_707_1:RecordAudio("424041172", var_710_12)
					else
						arg_707_1:AudioAction("play", "voice", "story_v_out_424041", "424041172", "story_v_out_424041.awb")
					end

					arg_707_1:RecordHistoryTalkVoice("story_v_out_424041", "424041172", "story_v_out_424041.awb")
				end

				arg_707_1:RecordContent(arg_707_1.text_.text)
			end

			local var_710_13 = math.max(var_710_6, arg_707_1.talkMaxDuration)

			if var_710_5 <= arg_707_1.time_ and arg_707_1.time_ < var_710_5 + var_710_13 then
				arg_707_1.typewritter.percent = (arg_707_1.time_ - var_710_5) / var_710_13

				arg_707_1.typewritter:SetDirty()
			end

			if arg_707_1.time_ >= var_710_5 + var_710_13 and arg_707_1.time_ < var_710_5 + var_710_13 + arg_710_0 then
				arg_707_1.typewritter.percent = 1

				arg_707_1.typewritter:SetDirty()
				arg_707_1:ShowNextGo(true)
			end
		end

		arg_707_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_707_1:InitPlayNodeList()
	end,
	Play424041173 = function(arg_711_0, arg_711_1)
		arg_711_1.time_ = 0
		arg_711_1.frameCnt_ = 0
		arg_711_1.state_ = "playing"
		arg_711_1.curTalkId_ = 424041173
		arg_711_1.duration_ = 5

		SetActive(arg_711_1.tipsGo_, false)

		function arg_711_1.onSingleLineFinish_()
			arg_711_1.onSingleLineUpdate_ = nil
			arg_711_1.onSingleLineFinish_ = nil
			arg_711_1.state_ = "waiting"
		end

		function arg_711_1.playNext_(arg_713_0)
			if arg_713_0 == 1 then
				arg_711_0:Play424041174(arg_711_1)
			end
		end

		function arg_711_1.onSingleLineUpdate_(arg_714_0)
			if 0 < arg_711_1.time_ and arg_711_1.time_ <= 0 + arg_714_0 and not isNil(arg_711_1.actors_["10154"]) and arg_711_1.var_.actorSpriteComps10154 == nil then
				arg_711_1.var_.actorSpriteComps10154 = arg_711_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_714_0 = 0.2

			if 0 <= arg_711_1.time_ and arg_711_1.time_ < 0 + var_714_0 and not isNil(arg_711_1.actors_["10154"]) then
				if arg_711_1.var_.actorSpriteComps10154 then
					for iter_714_0, iter_714_1 in pairs(arg_711_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_714_1 then
							if arg_711_1.isInRecall_ then
								iter_714_1.color = Color.New(Mathf.Lerp(iter_714_1.color.r, arg_711_1.hightColor2.r, (arg_711_1.time_ - 0) / var_714_0), Mathf.Lerp(iter_714_1.color.g, arg_711_1.hightColor2.g, (arg_711_1.time_ - 0) / var_714_0), (Mathf.Lerp(iter_714_1.color.b, arg_711_1.hightColor2.b, (arg_711_1.time_ - 0) / var_714_0)))
							else
								local var_714_1 = Mathf.Lerp(iter_714_1.color.r, 0.5, (arg_711_1.time_ - 0) / var_714_0)

								iter_714_1.color = Color.New(var_714_1, var_714_1, var_714_1)
							end
						end
					end
				end
			end

			if arg_711_1.time_ >= 0 + var_714_0 and arg_711_1.time_ < 0 + var_714_0 + arg_714_0 and not isNil(arg_711_1.actors_["10154"]) and arg_711_1.var_.actorSpriteComps10154 then
				for iter_714_2, iter_714_3 in pairs(arg_711_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_714_3 then
						iter_714_3.color = arg_711_1.isInRecall_ and (arg_711_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_711_1.var_.actorSpriteComps10154 = nil
			end

			local var_714_2 = 0
			local var_714_3 = 0.4

			if 0 < arg_711_1.time_ and arg_711_1.time_ <= var_714_2 + arg_714_0 then
				arg_711_1.talkMaxDuration = 0
				arg_711_1.dialogCg_.alpha = 1

				arg_711_1.dialog_:SetActive(true)
				SetActive(arg_711_1.leftNameGo_, true)

				arg_711_1.leftNameTxt_.text = arg_711_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_711_1.leftNameTxt_.transform)

				arg_711_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_711_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_711_1:RecordName(arg_711_1.leftNameTxt_.text)
				SetActive(arg_711_1.iconTrs_.gameObject, true)
				arg_711_1.iconController_:SetSelectedState("hero")

				arg_711_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_711_1.callingController_:SetSelectedState("normal")

				arg_711_1.keyicon_.color = Color.New(1, 1, 1)
				arg_711_1.icon_.color = Color.New(1, 1, 1)

				local var_714_4 = arg_711_1:FormatText(arg_711_1:GetWordFromCfg(424041173).content)

				arg_711_1.text_.text = var_714_4

				LuaForUtil.ClearLinePrefixSymbol(arg_711_1.text_)

				local var_714_6 = 16 <= 0 and var_714_3 or var_714_3 * (utf8.len(var_714_4) / 16)

				if (16 <= 0 and var_714_3 or var_714_3 * (utf8.len(var_714_4) / 16)) > 0 and var_714_3 < var_714_6 then
					arg_711_1.talkMaxDuration = var_714_6

					if var_714_6 + var_714_2 > arg_711_1.duration_ then
						arg_711_1.duration_ = var_714_6 + var_714_2
					end
				end

				arg_711_1.text_.text = var_714_4
				arg_711_1.typewritter.percent = 0

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(false)
				arg_711_1:RecordContent(arg_711_1.text_.text)
			end

			local var_714_7 = math.max(var_714_3, arg_711_1.talkMaxDuration)

			if var_714_2 <= arg_711_1.time_ and arg_711_1.time_ < var_714_2 + var_714_7 then
				arg_711_1.typewritter.percent = (arg_711_1.time_ - var_714_2) / var_714_7

				arg_711_1.typewritter:SetDirty()
			end

			if arg_711_1.time_ >= var_714_2 + var_714_7 and arg_711_1.time_ < var_714_2 + var_714_7 + arg_714_0 then
				arg_711_1.typewritter.percent = 1

				arg_711_1.typewritter:SetDirty()
				arg_711_1:ShowNextGo(true)
			end
		end

		arg_711_1.nodeConfigList_ = {}

		arg_711_1:InitPlayNodeList()
	end,
	Play424041174 = function(arg_715_0, arg_715_1)
		arg_715_1.time_ = 0
		arg_715_1.frameCnt_ = 0
		arg_715_1.state_ = "playing"
		arg_715_1.curTalkId_ = 424041174
		arg_715_1.duration_ = 1.53

		local var_715_0 = {
			zh = 1.533,
			ja = 1.433
		}
		local var_715_1 = manager.audio:GetLocalizationFlag()

		if var_715_0[var_715_1] ~= nil then
			arg_715_1.duration_ = var_715_0[var_715_1]
		end

		SetActive(arg_715_1.tipsGo_, false)

		function arg_715_1.onSingleLineFinish_()
			arg_715_1.onSingleLineUpdate_ = nil
			arg_715_1.onSingleLineFinish_ = nil
			arg_715_1.state_ = "waiting"
		end

		function arg_715_1.playNext_(arg_717_0)
			if arg_717_0 == 1 then
				arg_715_0:Play424041175(arg_715_1)
			end
		end

		function arg_715_1.onSingleLineUpdate_(arg_718_0)
			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 and not isNil(arg_715_1.actors_["10154"]) and arg_715_1.var_.actorSpriteComps10154 == nil then
				arg_715_1.var_.actorSpriteComps10154 = arg_715_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_718_0 = 0.2

			if 0 <= arg_715_1.time_ and arg_715_1.time_ < 0 + var_718_0 and not isNil(arg_715_1.actors_["10154"]) then
				if arg_715_1.var_.actorSpriteComps10154 then
					for iter_718_0, iter_718_1 in pairs(arg_715_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_718_1 then
							if arg_715_1.isInRecall_ then
								iter_718_1.color = Color.New(Mathf.Lerp(iter_718_1.color.r, arg_715_1.hightColor1.r, (arg_715_1.time_ - 0) / var_718_0), Mathf.Lerp(iter_718_1.color.g, arg_715_1.hightColor1.g, (arg_715_1.time_ - 0) / var_718_0), (Mathf.Lerp(iter_718_1.color.b, arg_715_1.hightColor1.b, (arg_715_1.time_ - 0) / var_718_0)))
							else
								local var_718_1 = Mathf.Lerp(iter_718_1.color.r, 1, (arg_715_1.time_ - 0) / var_718_0)

								iter_718_1.color = Color.New(var_718_1, var_718_1, var_718_1)
							end
						end
					end
				end
			end

			if arg_715_1.time_ >= 0 + var_718_0 and arg_715_1.time_ < 0 + var_718_0 + arg_718_0 and not isNil(arg_715_1.actors_["10154"]) and arg_715_1.var_.actorSpriteComps10154 then
				for iter_718_2, iter_718_3 in pairs(arg_715_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_718_3 then
						iter_718_3.color = arg_715_1.isInRecall_ and (arg_715_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_715_1.var_.actorSpriteComps10154 = nil
			end

			local var_718_2 = arg_715_1.actors_["10154"].transform

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= 0 + arg_718_0 then
				arg_715_1.var_.moveOldPos10154 = var_718_2.localPosition
				var_718_2.localScale = Vector3.New(1, 1, 1)

				arg_715_1:CheckSpriteTmpPos("10154", 3)

				for iter_718_4 = 0, var_718_2.childCount - 1 do
					local var_718_3 = var_718_2:GetChild(iter_718_4)

					if var_718_3.name == "" or not string.find(var_718_3.name, "split") then
						var_718_3.gameObject:SetActive(true)
					else
						var_718_3.gameObject:SetActive(false)
					end
				end
			end

			local var_718_4 = 0.001

			if 0 <= arg_715_1.time_ and arg_715_1.time_ < 0 + var_718_4 then
				var_718_2.localPosition = Vector3.Lerp(arg_715_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_715_1.time_ - 0) / var_718_4)
			end

			if arg_715_1.time_ >= 0 + var_718_4 and arg_715_1.time_ < 0 + var_718_4 + arg_718_0 then
				var_718_2.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_718_5 = 0
			local var_718_6 = 0.2

			if 0 < arg_715_1.time_ and arg_715_1.time_ <= var_718_5 + arg_718_0 then
				arg_715_1.talkMaxDuration = 0
				arg_715_1.dialogCg_.alpha = 1

				arg_715_1.dialog_:SetActive(true)
				SetActive(arg_715_1.leftNameGo_, true)

				arg_715_1.leftNameTxt_.text = arg_715_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_715_1.leftNameTxt_.transform)

				arg_715_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_715_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_715_1:RecordName(arg_715_1.leftNameTxt_.text)
				SetActive(arg_715_1.iconTrs_.gameObject, false)
				arg_715_1.callingController_:SetSelectedState("normal")

				local var_718_7 = arg_715_1:GetWordFromCfg(424041174)
				local var_718_8 = arg_715_1:FormatText(var_718_7.content)

				arg_715_1.text_.text = var_718_8

				LuaForUtil.ClearLinePrefixSymbol(arg_715_1.text_)

				local var_718_10 = 8 <= 0 and var_718_6 or var_718_6 * (utf8.len(var_718_8) / 8)

				if (8 <= 0 and var_718_6 or var_718_6 * (utf8.len(var_718_8) / 8)) > 0 and var_718_6 < var_718_10 then
					arg_715_1.talkMaxDuration = var_718_10

					if var_718_10 + var_718_5 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_10 + var_718_5
					end
				end

				arg_715_1.text_.text = var_718_8
				arg_715_1.typewritter.percent = 0

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041174", "story_v_out_424041.awb") ~= 0 then
					local var_718_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041174", "story_v_out_424041.awb") / 1000

					if var_718_11 + var_718_5 > arg_715_1.duration_ then
						arg_715_1.duration_ = var_718_11 + var_718_5
					end

					if var_718_7.prefab_name ~= "" and arg_715_1.actors_[var_718_7.prefab_name] ~= nil then
						local var_718_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_715_1.actors_[var_718_7.prefab_name].transform, "story_v_out_424041", "424041174", "story_v_out_424041.awb")

						arg_715_1:RecordAudio("424041174", var_718_12)
						arg_715_1:RecordAudio("424041174", var_718_12)
					else
						arg_715_1:AudioAction("play", "voice", "story_v_out_424041", "424041174", "story_v_out_424041.awb")
					end

					arg_715_1:RecordHistoryTalkVoice("story_v_out_424041", "424041174", "story_v_out_424041.awb")
				end

				arg_715_1:RecordContent(arg_715_1.text_.text)
			end

			local var_718_13 = math.max(var_718_6, arg_715_1.talkMaxDuration)

			if var_718_5 <= arg_715_1.time_ and arg_715_1.time_ < var_718_5 + var_718_13 then
				arg_715_1.typewritter.percent = (arg_715_1.time_ - var_718_5) / var_718_13

				arg_715_1.typewritter:SetDirty()
			end

			if arg_715_1.time_ >= var_718_5 + var_718_13 and arg_715_1.time_ < var_718_5 + var_718_13 + arg_718_0 then
				arg_715_1.typewritter.percent = 1

				arg_715_1.typewritter:SetDirty()
				arg_715_1:ShowNextGo(true)
			end
		end

		arg_715_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_715_1:InitPlayNodeList()
	end,
	Play424041175 = function(arg_719_0, arg_719_1)
		arg_719_1.time_ = 0
		arg_719_1.frameCnt_ = 0
		arg_719_1.state_ = "playing"
		arg_719_1.curTalkId_ = 424041175
		arg_719_1.duration_ = 12.6

		local var_719_0 = {
			zh = 12.4,
			ja = 12.6
		}
		local var_719_1 = manager.audio:GetLocalizationFlag()

		if var_719_0[var_719_1] ~= nil then
			arg_719_1.duration_ = var_719_0[var_719_1]
		end

		SetActive(arg_719_1.tipsGo_, false)

		function arg_719_1.onSingleLineFinish_()
			arg_719_1.onSingleLineUpdate_ = nil
			arg_719_1.onSingleLineFinish_ = nil
			arg_719_1.state_ = "waiting"
		end

		function arg_719_1.playNext_(arg_721_0)
			if arg_721_0 == 1 then
				arg_719_0:Play424041176(arg_719_1)
			end
		end

		function arg_719_1.onSingleLineUpdate_(arg_722_0)
			if 0 < arg_719_1.time_ and arg_719_1.time_ <= 0 + arg_722_0 then
				arg_719_1.var_.moveOldPos10154 = arg_719_1.actors_["10154"].transform.localPosition
				arg_719_1.actors_["10154"].transform.localScale = Vector3.New(1, 1, 1)

				arg_719_1:CheckSpriteTmpPos("10154", 3)

				for iter_722_0 = 0, arg_719_1.actors_["10154"].transform.childCount - 1 do
					local var_722_0 = arg_719_1.actors_["10154"].transform:GetChild(iter_722_0)

					if var_722_0.name == "" or not string.find(var_722_0.name, "split") then
						var_722_0.gameObject:SetActive(true)
					else
						var_722_0.gameObject:SetActive(false)
					end
				end
			end

			local var_722_1 = 0.001

			if 0 <= arg_719_1.time_ and arg_719_1.time_ < 0 + var_722_1 then
				arg_719_1.actors_["10154"].transform.localPosition = Vector3.Lerp(arg_719_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_719_1.time_ - 0) / var_722_1)
			end

			if arg_719_1.time_ >= 0 + var_722_1 and arg_719_1.time_ < 0 + var_722_1 + arg_722_0 then
				arg_719_1.actors_["10154"].transform.localPosition = Vector3.New(-20, -338, -538)
			end

			local var_722_2 = 0
			local var_722_3 = 1.375

			if 0 < arg_719_1.time_ and arg_719_1.time_ <= var_722_2 + arg_722_0 then
				arg_719_1.talkMaxDuration = 0
				arg_719_1.dialogCg_.alpha = 1

				arg_719_1.dialog_:SetActive(true)
				SetActive(arg_719_1.leftNameGo_, true)

				arg_719_1.leftNameTxt_.text = arg_719_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_719_1.leftNameTxt_.transform)

				arg_719_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_719_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_719_1:RecordName(arg_719_1.leftNameTxt_.text)
				SetActive(arg_719_1.iconTrs_.gameObject, false)
				arg_719_1.callingController_:SetSelectedState("normal")

				local var_722_4 = arg_719_1:GetWordFromCfg(424041175)
				local var_722_5 = arg_719_1:FormatText(var_722_4.content)

				arg_719_1.text_.text = var_722_5

				LuaForUtil.ClearLinePrefixSymbol(arg_719_1.text_)

				local var_722_7 = 55 <= 0 and var_722_3 or var_722_3 * (utf8.len(var_722_5) / 55)

				if (55 <= 0 and var_722_3 or var_722_3 * (utf8.len(var_722_5) / 55)) > 0 and var_722_3 < var_722_7 then
					arg_719_1.talkMaxDuration = var_722_7

					if var_722_7 + var_722_2 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_7 + var_722_2
					end
				end

				arg_719_1.text_.text = var_722_5
				arg_719_1.typewritter.percent = 0

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041175", "story_v_out_424041.awb") ~= 0 then
					local var_722_8 = manager.audio:GetVoiceLength("story_v_out_424041", "424041175", "story_v_out_424041.awb") / 1000

					if var_722_8 + var_722_2 > arg_719_1.duration_ then
						arg_719_1.duration_ = var_722_8 + var_722_2
					end

					if var_722_4.prefab_name ~= "" and arg_719_1.actors_[var_722_4.prefab_name] ~= nil then
						local var_722_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_719_1.actors_[var_722_4.prefab_name].transform, "story_v_out_424041", "424041175", "story_v_out_424041.awb")

						arg_719_1:RecordAudio("424041175", var_722_9)
						arg_719_1:RecordAudio("424041175", var_722_9)
					else
						arg_719_1:AudioAction("play", "voice", "story_v_out_424041", "424041175", "story_v_out_424041.awb")
					end

					arg_719_1:RecordHistoryTalkVoice("story_v_out_424041", "424041175", "story_v_out_424041.awb")
				end

				arg_719_1:RecordContent(arg_719_1.text_.text)
			end

			local var_722_10 = math.max(var_722_3, arg_719_1.talkMaxDuration)

			if var_722_2 <= arg_719_1.time_ and arg_719_1.time_ < var_722_2 + var_722_10 then
				arg_719_1.typewritter.percent = (arg_719_1.time_ - var_722_2) / var_722_10

				arg_719_1.typewritter:SetDirty()
			end

			if arg_719_1.time_ >= var_722_2 + var_722_10 and arg_719_1.time_ < var_722_2 + var_722_10 + arg_722_0 then
				arg_719_1.typewritter.percent = 1

				arg_719_1.typewritter:SetDirty()
				arg_719_1:ShowNextGo(true)
			end
		end

		arg_719_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_719_1:InitPlayNodeList()
	end,
	Play424041176 = function(arg_723_0, arg_723_1)
		arg_723_1.time_ = 0
		arg_723_1.frameCnt_ = 0
		arg_723_1.state_ = "playing"
		arg_723_1.curTalkId_ = 424041176
		arg_723_1.duration_ = 5

		SetActive(arg_723_1.tipsGo_, false)

		function arg_723_1.onSingleLineFinish_()
			arg_723_1.onSingleLineUpdate_ = nil
			arg_723_1.onSingleLineFinish_ = nil
			arg_723_1.state_ = "waiting"
		end

		function arg_723_1.playNext_(arg_725_0)
			if arg_725_0 == 1 then
				arg_723_0:Play424041177(arg_723_1)
			end
		end

		function arg_723_1.onSingleLineUpdate_(arg_726_0)
			if 0 < arg_723_1.time_ and arg_723_1.time_ <= 0 + arg_726_0 and not isNil(arg_723_1.actors_["10154"]) and arg_723_1.var_.actorSpriteComps10154 == nil then
				arg_723_1.var_.actorSpriteComps10154 = arg_723_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_726_0 = 0.2

			if 0 <= arg_723_1.time_ and arg_723_1.time_ < 0 + var_726_0 and not isNil(arg_723_1.actors_["10154"]) then
				if arg_723_1.var_.actorSpriteComps10154 then
					for iter_726_0, iter_726_1 in pairs(arg_723_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_726_1 then
							if arg_723_1.isInRecall_ then
								iter_726_1.color = Color.New(Mathf.Lerp(iter_726_1.color.r, arg_723_1.hightColor2.r, (arg_723_1.time_ - 0) / var_726_0), Mathf.Lerp(iter_726_1.color.g, arg_723_1.hightColor2.g, (arg_723_1.time_ - 0) / var_726_0), (Mathf.Lerp(iter_726_1.color.b, arg_723_1.hightColor2.b, (arg_723_1.time_ - 0) / var_726_0)))
							else
								local var_726_1 = Mathf.Lerp(iter_726_1.color.r, 0.5, (arg_723_1.time_ - 0) / var_726_0)

								iter_726_1.color = Color.New(var_726_1, var_726_1, var_726_1)
							end
						end
					end
				end
			end

			if arg_723_1.time_ >= 0 + var_726_0 and arg_723_1.time_ < 0 + var_726_0 + arg_726_0 and not isNil(arg_723_1.actors_["10154"]) and arg_723_1.var_.actorSpriteComps10154 then
				for iter_726_2, iter_726_3 in pairs(arg_723_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_726_3 then
						iter_726_3.color = arg_723_1.isInRecall_ and (arg_723_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_723_1.var_.actorSpriteComps10154 = nil
			end

			local var_726_2 = 0
			local var_726_3 = 0.75

			if 0 < arg_723_1.time_ and arg_723_1.time_ <= var_726_2 + arg_726_0 then
				arg_723_1.talkMaxDuration = 0
				arg_723_1.dialogCg_.alpha = 1

				arg_723_1.dialog_:SetActive(true)
				SetActive(arg_723_1.leftNameGo_, true)

				arg_723_1.leftNameTxt_.text = arg_723_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_723_1.leftNameTxt_.transform)

				arg_723_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_723_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_723_1:RecordName(arg_723_1.leftNameTxt_.text)
				SetActive(arg_723_1.iconTrs_.gameObject, true)
				arg_723_1.iconController_:SetSelectedState("hero")

				arg_723_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_723_1.callingController_:SetSelectedState("normal")

				arg_723_1.keyicon_.color = Color.New(1, 1, 1)
				arg_723_1.icon_.color = Color.New(1, 1, 1)

				local var_726_4 = arg_723_1:FormatText(arg_723_1:GetWordFromCfg(424041176).content)

				arg_723_1.text_.text = var_726_4

				LuaForUtil.ClearLinePrefixSymbol(arg_723_1.text_)

				local var_726_6 = 30 <= 0 and var_726_3 or var_726_3 * (utf8.len(var_726_4) / 30)

				if (30 <= 0 and var_726_3 or var_726_3 * (utf8.len(var_726_4) / 30)) > 0 and var_726_3 < var_726_6 then
					arg_723_1.talkMaxDuration = var_726_6

					if var_726_6 + var_726_2 > arg_723_1.duration_ then
						arg_723_1.duration_ = var_726_6 + var_726_2
					end
				end

				arg_723_1.text_.text = var_726_4
				arg_723_1.typewritter.percent = 0

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(false)
				arg_723_1:RecordContent(arg_723_1.text_.text)
			end

			local var_726_7 = math.max(var_726_3, arg_723_1.talkMaxDuration)

			if var_726_2 <= arg_723_1.time_ and arg_723_1.time_ < var_726_2 + var_726_7 then
				arg_723_1.typewritter.percent = (arg_723_1.time_ - var_726_2) / var_726_7

				arg_723_1.typewritter:SetDirty()
			end

			if arg_723_1.time_ >= var_726_2 + var_726_7 and arg_723_1.time_ < var_726_2 + var_726_7 + arg_726_0 then
				arg_723_1.typewritter.percent = 1

				arg_723_1.typewritter:SetDirty()
				arg_723_1:ShowNextGo(true)
			end
		end

		arg_723_1.nodeConfigList_ = {}

		arg_723_1:InitPlayNodeList()
	end,
	Play424041177 = function(arg_727_0, arg_727_1)
		arg_727_1.time_ = 0
		arg_727_1.frameCnt_ = 0
		arg_727_1.state_ = "playing"
		arg_727_1.curTalkId_ = 424041177
		arg_727_1.duration_ = 5

		SetActive(arg_727_1.tipsGo_, false)

		function arg_727_1.onSingleLineFinish_()
			arg_727_1.onSingleLineUpdate_ = nil
			arg_727_1.onSingleLineFinish_ = nil
			arg_727_1.state_ = "waiting"
		end

		function arg_727_1.playNext_(arg_729_0)
			if arg_729_0 == 1 then
				arg_727_0:Play424041178(arg_727_1)
			end
		end

		function arg_727_1.onSingleLineUpdate_(arg_730_0)
			local var_730_0 = 1.1

			if 0 < arg_727_1.time_ and arg_727_1.time_ <= 0 + arg_730_0 then
				arg_727_1.talkMaxDuration = 0
				arg_727_1.dialogCg_.alpha = 1

				arg_727_1.dialog_:SetActive(true)
				SetActive(arg_727_1.leftNameGo_, false)

				arg_727_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_727_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_727_1:RecordName(arg_727_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_727_1.iconTrs_.gameObject, false)
				arg_727_1.callingController_:SetSelectedState("normal")

				local var_730_1 = arg_727_1:FormatText(arg_727_1:GetWordFromCfg(424041177).content)

				arg_727_1.text_.text = var_730_1

				LuaForUtil.ClearLinePrefixSymbol(arg_727_1.text_)

				local var_730_3 = 44 <= 0 and var_730_0 or var_730_0 * (utf8.len(var_730_1) / 44)

				if (44 <= 0 and var_730_0 or var_730_0 * (utf8.len(var_730_1) / 44)) > 0 and var_730_0 < var_730_3 then
					arg_727_1.talkMaxDuration = var_730_3

					if var_730_3 + 0 > arg_727_1.duration_ then
						arg_727_1.duration_ = var_730_3 + 0
					end
				end

				arg_727_1.text_.text = var_730_1
				arg_727_1.typewritter.percent = 0

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(false)
				arg_727_1:RecordContent(arg_727_1.text_.text)
			end

			local var_730_4 = math.max(var_730_0, arg_727_1.talkMaxDuration)

			if 0 <= arg_727_1.time_ and arg_727_1.time_ < 0 + var_730_4 then
				arg_727_1.typewritter.percent = (arg_727_1.time_ - 0) / var_730_4

				arg_727_1.typewritter:SetDirty()
			end

			if arg_727_1.time_ >= 0 + var_730_4 and arg_727_1.time_ < 0 + var_730_4 + arg_730_0 then
				arg_727_1.typewritter.percent = 1

				arg_727_1.typewritter:SetDirty()
				arg_727_1:ShowNextGo(true)
			end
		end

		arg_727_1.nodeConfigList_ = {}

		arg_727_1:InitPlayNodeList()
	end,
	Play424041178 = function(arg_731_0, arg_731_1)
		arg_731_1.time_ = 0
		arg_731_1.frameCnt_ = 0
		arg_731_1.state_ = "playing"
		arg_731_1.curTalkId_ = 424041178
		arg_731_1.duration_ = 1.2

		local var_731_0 = {
			zh = 1.2,
			ja = 1.066
		}
		local var_731_1 = manager.audio:GetLocalizationFlag()

		if var_731_0[var_731_1] ~= nil then
			arg_731_1.duration_ = var_731_0[var_731_1]
		end

		SetActive(arg_731_1.tipsGo_, false)

		function arg_731_1.onSingleLineFinish_()
			arg_731_1.onSingleLineUpdate_ = nil
			arg_731_1.onSingleLineFinish_ = nil
			arg_731_1.state_ = "waiting"
			arg_731_1.auto_ = false
		end

		function arg_731_1.playNext_(arg_733_0)
			arg_731_1.onStoryFinished_()
		end

		function arg_731_1.onSingleLineUpdate_(arg_734_0)
			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 and not isNil(arg_731_1.actors_["10154"]) and arg_731_1.var_.actorSpriteComps10154 == nil then
				arg_731_1.var_.actorSpriteComps10154 = arg_731_1.actors_["10154"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_734_0 = 0.2

			if 0 <= arg_731_1.time_ and arg_731_1.time_ < 0 + var_734_0 and not isNil(arg_731_1.actors_["10154"]) then
				if arg_731_1.var_.actorSpriteComps10154 then
					for iter_734_0, iter_734_1 in pairs(arg_731_1.var_.actorSpriteComps10154:ToTable()) do
						if iter_734_1 then
							if arg_731_1.isInRecall_ then
								iter_734_1.color = Color.New(Mathf.Lerp(iter_734_1.color.r, arg_731_1.hightColor1.r, (arg_731_1.time_ - 0) / var_734_0), Mathf.Lerp(iter_734_1.color.g, arg_731_1.hightColor1.g, (arg_731_1.time_ - 0) / var_734_0), (Mathf.Lerp(iter_734_1.color.b, arg_731_1.hightColor1.b, (arg_731_1.time_ - 0) / var_734_0)))
							else
								local var_734_1 = Mathf.Lerp(iter_734_1.color.r, 1, (arg_731_1.time_ - 0) / var_734_0)

								iter_734_1.color = Color.New(var_734_1, var_734_1, var_734_1)
							end
						end
					end
				end
			end

			if arg_731_1.time_ >= 0 + var_734_0 and arg_731_1.time_ < 0 + var_734_0 + arg_734_0 and not isNil(arg_731_1.actors_["10154"]) and arg_731_1.var_.actorSpriteComps10154 then
				for iter_734_2, iter_734_3 in pairs(arg_731_1.var_.actorSpriteComps10154:ToTable()) do
					if iter_734_3 then
						iter_734_3.color = arg_731_1.isInRecall_ and (arg_731_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_731_1.var_.actorSpriteComps10154 = nil
			end

			local var_734_2 = arg_731_1.actors_["10154"].transform

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= 0 + arg_734_0 then
				arg_731_1.var_.moveOldPos10154 = var_734_2.localPosition
				var_734_2.localScale = Vector3.New(1, 1, 1)

				arg_731_1:CheckSpriteTmpPos("10154", 3)

				for iter_734_4 = 0, var_734_2.childCount - 1 do
					local var_734_3 = var_734_2:GetChild(iter_734_4)

					if var_734_3.name == "split_2" then
						var_734_3:SetAsLastSibling()
						var_734_3.gameObject:SetActive(true)

						arg_731_1.var_.actorSpriteSplit10154 = var_734_3.gameObject:GetComponent(typeof(Image))

						arg_731_1.var_.actorSpriteSplit10154:SetAlpha(0)
					end
				end
			end

			local var_734_4 = 0.5

			if 0 <= arg_731_1.time_ and arg_731_1.time_ < 0 + var_734_4 then
				var_734_2.localPosition = Vector3.Lerp(arg_731_1.var_.moveOldPos10154, Vector3.New(-20, -338, -538), (arg_731_1.time_ - 0) / var_734_4)

				if arg_731_1.var_.actorSpriteSplit10154 ~= nil then
					arg_731_1.var_.actorSpriteSplit10154:SetAlpha((arg_731_1.time_ - 0) / var_734_4)
				end
			end

			if arg_731_1.time_ >= 0 + var_734_4 and arg_731_1.time_ < 0 + var_734_4 + arg_734_0 then
				var_734_2.localPosition = Vector3.New(-20, -338, -538)

				if arg_731_1.var_.actorSpriteSplit10154 ~= nil then
					arg_731_1.var_.actorSpriteSplit10154:SetAlpha(1)
				end
			end

			local var_734_5 = 0
			local var_734_6 = 0.075

			if 0 < arg_731_1.time_ and arg_731_1.time_ <= var_734_5 + arg_734_0 then
				arg_731_1.talkMaxDuration = 0
				arg_731_1.dialogCg_.alpha = 1

				arg_731_1.dialog_:SetActive(true)
				SetActive(arg_731_1.leftNameGo_, true)

				arg_731_1.leftNameTxt_.text = arg_731_1:FormatText(StoryNameCfg[1392].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_731_1.leftNameTxt_.transform)

				arg_731_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_731_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_731_1:RecordName(arg_731_1.leftNameTxt_.text)
				SetActive(arg_731_1.iconTrs_.gameObject, false)
				arg_731_1.callingController_:SetSelectedState("normal")

				local var_734_7 = arg_731_1:GetWordFromCfg(424041178)
				local var_734_8 = arg_731_1:FormatText(var_734_7.content)

				arg_731_1.text_.text = var_734_8

				LuaForUtil.ClearLinePrefixSymbol(arg_731_1.text_)

				local var_734_10 = 3 <= 0 and var_734_6 or var_734_6 * (utf8.len(var_734_8) / 3)

				if (3 <= 0 and var_734_6 or var_734_6 * (utf8.len(var_734_8) / 3)) > 0 and var_734_6 < var_734_10 then
					arg_731_1.talkMaxDuration = var_734_10

					if var_734_10 + var_734_5 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_10 + var_734_5
					end
				end

				arg_731_1.text_.text = var_734_8
				arg_731_1.typewritter.percent = 0

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_424041", "424041178", "story_v_out_424041.awb") ~= 0 then
					local var_734_11 = manager.audio:GetVoiceLength("story_v_out_424041", "424041178", "story_v_out_424041.awb") / 1000

					if var_734_11 + var_734_5 > arg_731_1.duration_ then
						arg_731_1.duration_ = var_734_11 + var_734_5
					end

					if var_734_7.prefab_name ~= "" and arg_731_1.actors_[var_734_7.prefab_name] ~= nil then
						local var_734_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_731_1.actors_[var_734_7.prefab_name].transform, "story_v_out_424041", "424041178", "story_v_out_424041.awb")

						arg_731_1:RecordAudio("424041178", var_734_12)
						arg_731_1:RecordAudio("424041178", var_734_12)
					else
						arg_731_1:AudioAction("play", "voice", "story_v_out_424041", "424041178", "story_v_out_424041.awb")
					end

					arg_731_1:RecordHistoryTalkVoice("story_v_out_424041", "424041178", "story_v_out_424041.awb")
				end

				arg_731_1:RecordContent(arg_731_1.text_.text)
			end

			local var_734_13 = math.max(var_734_6, arg_731_1.talkMaxDuration)

			if var_734_5 <= arg_731_1.time_ and arg_731_1.time_ < var_734_5 + var_734_13 then
				arg_731_1.typewritter.percent = (arg_731_1.time_ - var_734_5) / var_734_13

				arg_731_1.typewritter:SetDirty()
			end

			if arg_731_1.time_ >= var_734_5 + var_734_13 and arg_731_1.time_ < var_734_5 + var_734_13 + arg_734_0 then
				arg_731_1.typewritter.percent = 1

				arg_731_1.typewritter:SetDirty()
				arg_731_1:ShowNextGo(true)
			end
		end

		arg_731_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10154",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_731_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I18a",
		"TextureConfig/Background/ST0116b",
		"TextureConfig/Background/ST0116",
		"TextureConfig/Background/I11o",
		"TextureConfig/Background/ST0115"
	},
	voices = {
		"story_v_out_424041.awb"
	}
}
