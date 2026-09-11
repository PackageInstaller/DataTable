return {
	Play926082001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 926082001
		arg_1_1.duration_ = 5.37

		local var_1_0 = {
			zh = 5.19933333333333,
			ja = 5.36633333333333
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
				arg_1_0:Play926082002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I20f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I20f")
				var_4_0.name = "I20f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I20f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I20f

				arg_1_1.bgs_.I20f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I20f" then
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

			local var_4_6 = 1.43333333333333

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

			local var_4_9 = "128404"

			if arg_1_1.actors_["128404"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

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

			local var_4_12 = arg_1_1.actors_["128404"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps128404 == nil then
				arg_1_1.var_.actorSpriteComps128404 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps128404 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 0) / var_4_13), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 0) / var_4_13), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 0) / var_4_13)))
							else
								local var_4_14 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 0) / var_4_13)

								iter_4_5.color = Color.New(var_4_14, var_4_14, var_4_14)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 0 + var_4_13 and arg_1_1.time_ < 0 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps128404 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps128404 = nil
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_18 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_18

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_18
						arg_1_1.bgmTxt2_.text = var_4_18
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_3_story_duel", "bgm_activity_4_3_story_duel", "bgm_activity_4_3_story_duel.awb")

				local var_4_21 = manager.audio:GetAudioName("bgm_activity_4_3_story_duel", "bgm_activity_4_3_story_duel")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_22 = 1.43333333333333
			local var_4_23 = 0.4

			if 1.43333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_24 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_24:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_25 = arg_1_1:GetWordFromCfg(926082001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 16 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 16)

				if (16 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 16)) > 0 and var_4_23 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28
					var_4_22 = var_4_22 + 0.3

					if var_4_28 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_22
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082001", "story_v_out_926082.awb") ~= 0 then
					local var_4_29 = manager.audio:GetVoiceLength("story_v_out_926082", "926082001", "story_v_out_926082.awb") / 1000

					if var_4_29 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_22
					end

					if var_4_25.prefab_name ~= "" and arg_1_1.actors_[var_4_25.prefab_name] ~= nil then
						local var_4_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_25.prefab_name].transform, "story_v_out_926082", "926082001", "story_v_out_926082.awb")

						arg_1_1:RecordAudio("926082001", var_4_30)
						arg_1_1:RecordAudio("926082001", var_4_30)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_926082", "926082001", "story_v_out_926082.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_926082", "926082001", "story_v_out_926082.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_31 = var_4_22 + 0.3
			local var_4_32 = math.max(var_4_23, arg_1_1.talkMaxDuration)

			if var_4_22 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_31) / var_4_32

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play926082002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 926082002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play926082003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["128404"]) and arg_9_1.var_.actorSpriteComps128404 == nil then
				arg_9_1.var_.actorSpriteComps128404 = arg_9_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_0 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["128404"]) then
				if arg_9_1.var_.actorSpriteComps128404 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_12_1 then
							if arg_9_1.isInRecall_ then
								iter_12_1.color = Color.New(Mathf.Lerp(iter_12_1.color.r, arg_9_1.hightColor2.r, (arg_9_1.time_ - 0) / var_12_0), Mathf.Lerp(iter_12_1.color.g, arg_9_1.hightColor2.g, (arg_9_1.time_ - 0) / var_12_0), (Mathf.Lerp(iter_12_1.color.b, arg_9_1.hightColor2.b, (arg_9_1.time_ - 0) / var_12_0)))
							else
								local var_12_1 = Mathf.Lerp(iter_12_1.color.r, 0.5, (arg_9_1.time_ - 0) / var_12_0)

								iter_12_1.color = Color.New(var_12_1, var_12_1, var_12_1)
							end
						end
					end
				end
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["128404"]) and arg_9_1.var_.actorSpriteComps128404 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_12_3 then
						iter_12_3.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps128404 = nil
			end

			local var_12_2 = 0
			local var_12_3 = 0.75

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_2 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_4 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(926082002).content)

				arg_9_1.text_.text = var_12_4

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_6 = 30 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 30)

				if (30 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_4) / 30)) > 0 and var_12_3 < var_12_6 then
					arg_9_1.talkMaxDuration = var_12_6

					if var_12_6 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_6 + var_12_2
					end
				end

				arg_9_1.text_.text = var_12_4
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_7 = math.max(var_12_3, arg_9_1.talkMaxDuration)

			if var_12_2 <= arg_9_1.time_ and arg_9_1.time_ < var_12_2 + var_12_7 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_2) / var_12_7

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_2 + var_12_7 and arg_9_1.time_ < var_12_2 + var_12_7 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play926082003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 926082003
		arg_13_1.duration_ = 7.67

		local var_13_0 = {
			zh = 6.3,
			ja = 7.666
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
				arg_13_0:Play926082004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.725

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_1 = arg_13_1:GetWordFromCfg(926082003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 29 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 29)

				if (29 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 29)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082003", "story_v_out_926082.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_926082", "926082003", "story_v_out_926082.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_926082", "926082003", "story_v_out_926082.awb")

						arg_13_1:RecordAudio("926082003", var_16_6)
						arg_13_1:RecordAudio("926082003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_926082", "926082003", "story_v_out_926082.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_926082", "926082003", "story_v_out_926082.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play926082004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 926082004
		arg_17_1.duration_ = 1

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"

			SetActive(arg_17_1.choicesGo_, true)

			for iter_18_0, iter_18_1 in ipairs(arg_17_1.choices_) do
				SetActive(iter_18_1.go, iter_18_0 <= 1)
			end

			arg_17_1.choices_[1].txt.text = arg_17_1:FormatText(StoryChoiceCfg[1331].name)
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play926082005(arg_17_1)
			end

			arg_17_1:RecordChoiceLog(926082004, 1331)
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["128404"]) and arg_17_1.var_.actorSpriteComps128404 == nil then
				arg_17_1.var_.actorSpriteComps128404 = arg_17_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["128404"]) then
				if arg_17_1.var_.actorSpriteComps128404 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["128404"]) and arg_17_1.var_.actorSpriteComps128404 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps128404 = nil
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play926082005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 926082005
		arg_21_1.duration_ = 10.3

		local var_21_0 = {
			zh = 7.666,
			ja = 10.3
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
				arg_21_0:Play926082006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["128404"]) and arg_21_1.var_.actorSpriteComps128404 == nil then
				arg_21_1.var_.actorSpriteComps128404 = arg_21_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["128404"]) then
				if arg_21_1.var_.actorSpriteComps128404 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["128404"]) and arg_21_1.var_.actorSpriteComps128404 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps128404 = nil
			end

			local var_24_2 = arg_21_1.actors_["128404"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos128404 = var_24_2.localPosition
				var_24_2.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("128404", 3)

				for iter_24_4 = 0, var_24_2.childCount - 1 do
					local var_24_3 = var_24_2:GetChild(iter_24_4)

					if var_24_3.name == "split_6" or not string.find(var_24_3.name, "split") then
						var_24_3.gameObject:SetActive(true)
					else
						var_24_3.gameObject:SetActive(false)
					end
				end
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_2.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_21_1.time_ - 0) / var_24_4)
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_24_5 = 0
			local var_24_6 = 0.875

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(926082005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 35 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 35)

				if (35 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 35)) > 0 and var_24_6 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082005", "story_v_out_926082.awb") ~= 0 then
					local var_24_11 = manager.audio:GetVoiceLength("story_v_out_926082", "926082005", "story_v_out_926082.awb") / 1000

					if var_24_11 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_5
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_926082", "926082005", "story_v_out_926082.awb")

						arg_21_1:RecordAudio("926082005", var_24_12)
						arg_21_1:RecordAudio("926082005", var_24_12)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_926082", "926082005", "story_v_out_926082.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_926082", "926082005", "story_v_out_926082.awb")
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
				actorName = "128404",
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
	Play926082006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 926082006
		arg_25_1.duration_ = 7.7

		local var_25_0 = {
			zh = 6.2,
			ja = 7.7
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
				arg_25_0:Play926082007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.85

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:GetWordFromCfg(926082006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 34 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 34)

				if (34 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 34)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082006", "story_v_out_926082.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_926082", "926082006", "story_v_out_926082.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_926082", "926082006", "story_v_out_926082.awb")

						arg_25_1:RecordAudio("926082006", var_28_6)
						arg_25_1:RecordAudio("926082006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_926082", "926082006", "story_v_out_926082.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_926082", "926082006", "story_v_out_926082.awb")
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
	Play926082007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 926082007
		arg_29_1.duration_ = 8.03

		local var_29_0 = {
			zh = 6.5,
			ja = 8.033
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
				arg_29_0:Play926082008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.775

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(926082007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 31 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 31)

				if (31 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 31)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082007", "story_v_out_926082.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_926082", "926082007", "story_v_out_926082.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_926082", "926082007", "story_v_out_926082.awb")

						arg_29_1:RecordAudio("926082007", var_32_6)
						arg_29_1:RecordAudio("926082007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_926082", "926082007", "story_v_out_926082.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_926082", "926082007", "story_v_out_926082.awb")
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
	Play926082008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 926082008
		arg_33_1.duration_ = 1

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"

			SetActive(arg_33_1.choicesGo_, true)

			for iter_34_0, iter_34_1 in ipairs(arg_33_1.choices_) do
				SetActive(iter_34_1.go, iter_34_0 <= 2)
			end

			arg_33_1.choices_[1].txt.text = arg_33_1:FormatText(StoryChoiceCfg[1332].name)
			arg_33_1.choices_[2].txt.text = arg_33_1:FormatText(StoryChoiceCfg[1333].name)
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play926082009(arg_33_1)
			end

			if arg_35_0 == 2 then
				arg_33_0:Play926082009(arg_33_1)
			end

			arg_33_1:RecordChoiceLog(926082008, 1332, 1333)
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["128404"]) and arg_33_1.var_.actorSpriteComps128404 == nil then
				arg_33_1.var_.actorSpriteComps128404 = arg_33_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["128404"]) then
				if arg_33_1.var_.actorSpriteComps128404 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_36_1 then
							if arg_33_1.isInRecall_ then
								iter_36_1.color = Color.New(Mathf.Lerp(iter_36_1.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_0), Mathf.Lerp(iter_36_1.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_0), (Mathf.Lerp(iter_36_1.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_0)))
							else
								local var_36_1 = Mathf.Lerp(iter_36_1.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_0)

								iter_36_1.color = Color.New(var_36_1, var_36_1, var_36_1)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["128404"]) and arg_33_1.var_.actorSpriteComps128404 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps128404 = nil
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play926082009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 926082009
		arg_37_1.duration_ = 3.53

		local var_37_0 = {
			zh = 3.033,
			ja = 3.533
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
				arg_37_0:Play926082010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["128404"]) and arg_37_1.var_.actorSpriteComps128404 == nil then
				arg_37_1.var_.actorSpriteComps128404 = arg_37_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["128404"]) then
				if arg_37_1.var_.actorSpriteComps128404 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								iter_40_1.color = Color.New(Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_0), Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_0), (Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_0)))
							else
								local var_40_1 = Mathf.Lerp(iter_40_1.color.r, 1, (arg_37_1.time_ - 0) / var_40_0)

								iter_40_1.color = Color.New(var_40_1, var_40_1, var_40_1)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["128404"]) and arg_37_1.var_.actorSpriteComps128404 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps128404 = nil
			end

			local var_40_2 = arg_37_1.actors_["128404"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos128404 = var_40_2.localPosition
				var_40_2.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("128404", 3)

				for iter_40_4 = 0, var_40_2.childCount - 1 do
					local var_40_3 = var_40_2:GetChild(iter_40_4)

					if var_40_3.name == "" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_2.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_37_1.time_ - 0) / var_40_4)
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_40_5 = 0
			local var_40_6 = 0.375

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(926082009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 15 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 15)

				if (15 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 15)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082009", "story_v_out_926082.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_926082", "926082009", "story_v_out_926082.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_926082", "926082009", "story_v_out_926082.awb")

						arg_37_1:RecordAudio("926082009", var_40_12)
						arg_37_1:RecordAudio("926082009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_926082", "926082009", "story_v_out_926082.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_926082", "926082009", "story_v_out_926082.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_13 = math.max(var_40_6, arg_37_1.talkMaxDuration)

			if var_40_5 <= arg_37_1.time_ and arg_37_1.time_ < var_40_5 + var_40_13 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_5) / var_40_13

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_5 + var_40_13 and arg_37_1.time_ < var_40_5 + var_40_13 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play926082010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 926082010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play926082011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["128404"]) and arg_41_1.var_.actorSpriteComps128404 == nil then
				arg_41_1.var_.actorSpriteComps128404 = arg_41_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_0 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["128404"]) then
				if arg_41_1.var_.actorSpriteComps128404 then
					for iter_44_0, iter_44_1 in pairs(arg_41_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_44_1 then
							if arg_41_1.isInRecall_ then
								iter_44_1.color = Color.New(Mathf.Lerp(iter_44_1.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_0), Mathf.Lerp(iter_44_1.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_0), (Mathf.Lerp(iter_44_1.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_0)))
							else
								local var_44_1 = Mathf.Lerp(iter_44_1.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_0)

								iter_44_1.color = Color.New(var_44_1, var_44_1, var_44_1)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["128404"]) and arg_41_1.var_.actorSpriteComps128404 then
				for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_44_3 then
						iter_44_3.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps128404 = nil
			end

			local var_44_2 = arg_41_1.actors_["128404"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos128404 = var_44_2.localPosition
				var_44_2.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("128404", 7)

				for iter_44_4 = 0, var_44_2.childCount - 1 do
					local var_44_3 = var_44_2:GetChild(iter_44_4)

					if var_44_3.name == "" or not string.find(var_44_3.name, "split") then
						var_44_3.gameObject:SetActive(true)
					else
						var_44_3.gameObject:SetActive(false)
					end
				end
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_2.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_41_1.time_ - 0) / var_44_4)
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_44_5 = 0
			local var_44_6 = 0.375

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_7 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(926082010).content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 15 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_7) / 15)

				if (15 <= 0 and var_44_6 or var_44_6 * (utf8.len(var_44_7) / 15)) > 0 and var_44_6 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_5 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_5
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_10 = math.max(var_44_6, arg_41_1.talkMaxDuration)

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_10 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_5) / var_44_10

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_5 + var_44_10 and arg_41_1.time_ < var_44_5 + var_44_10 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play926082011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 926082011
		arg_45_1.duration_ = 8.17

		local var_45_0 = {
			zh = 6.766,
			ja = 8.166
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
				arg_45_0:Play926082012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["128404"]) and arg_45_1.var_.actorSpriteComps128404 == nil then
				arg_45_1.var_.actorSpriteComps128404 = arg_45_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["128404"]) then
				if arg_45_1.var_.actorSpriteComps128404 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_48_1 then
							if arg_45_1.isInRecall_ then
								iter_48_1.color = Color.New(Mathf.Lerp(iter_48_1.color.r, arg_45_1.hightColor1.r, (arg_45_1.time_ - 0) / var_48_0), Mathf.Lerp(iter_48_1.color.g, arg_45_1.hightColor1.g, (arg_45_1.time_ - 0) / var_48_0), (Mathf.Lerp(iter_48_1.color.b, arg_45_1.hightColor1.b, (arg_45_1.time_ - 0) / var_48_0)))
							else
								local var_48_1 = Mathf.Lerp(iter_48_1.color.r, 1, (arg_45_1.time_ - 0) / var_48_0)

								iter_48_1.color = Color.New(var_48_1, var_48_1, var_48_1)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["128404"]) and arg_45_1.var_.actorSpriteComps128404 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps128404 = nil
			end

			local var_48_2 = arg_45_1.actors_["128404"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos128404 = var_48_2.localPosition
				var_48_2.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("128404", 3)

				for iter_48_4 = 0, var_48_2.childCount - 1 do
					local var_48_3 = var_48_2:GetChild(iter_48_4)

					if var_48_3.name == "split_4" or not string.find(var_48_3.name, "split") then
						var_48_3.gameObject:SetActive(true)
					else
						var_48_3.gameObject:SetActive(false)
					end
				end
			end

			local var_48_4 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_4 then
				var_48_2.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_45_1.time_ - 0) / var_48_4)
			end

			if arg_45_1.time_ >= 0 + var_48_4 and arg_45_1.time_ < 0 + var_48_4 + arg_48_0 then
				var_48_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_48_5 = 0
			local var_48_6 = 0.625

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_7 = arg_45_1:GetWordFromCfg(926082011)
				local var_48_8 = arg_45_1:FormatText(var_48_7.content)

				arg_45_1.text_.text = var_48_8

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_10 = 25 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 25)

				if (25 <= 0 and var_48_6 or var_48_6 * (utf8.len(var_48_8) / 25)) > 0 and var_48_6 < var_48_10 then
					arg_45_1.talkMaxDuration = var_48_10

					if var_48_10 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_5
					end
				end

				arg_45_1.text_.text = var_48_8
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082011", "story_v_out_926082.awb") ~= 0 then
					local var_48_11 = manager.audio:GetVoiceLength("story_v_out_926082", "926082011", "story_v_out_926082.awb") / 1000

					if var_48_11 + var_48_5 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_5
					end

					if var_48_7.prefab_name ~= "" and arg_45_1.actors_[var_48_7.prefab_name] ~= nil then
						local var_48_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_7.prefab_name].transform, "story_v_out_926082", "926082011", "story_v_out_926082.awb")

						arg_45_1:RecordAudio("926082011", var_48_12)
						arg_45_1:RecordAudio("926082011", var_48_12)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_926082", "926082011", "story_v_out_926082.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_926082", "926082011", "story_v_out_926082.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_13 = math.max(var_48_6, arg_45_1.talkMaxDuration)

			if var_48_5 <= arg_45_1.time_ and arg_45_1.time_ < var_48_5 + var_48_13 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_5) / var_48_13

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_5 + var_48_13 and arg_45_1.time_ < var_48_5 + var_48_13 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play926082012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 926082012
		arg_49_1.duration_ = 6.37

		local var_49_0 = {
			zh = 3.866,
			ja = 6.366
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
				arg_49_0:Play926082013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.475

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:GetWordFromCfg(926082012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 19 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 19)

				if (19 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 19)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082012", "story_v_out_926082.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_926082", "926082012", "story_v_out_926082.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_926082", "926082012", "story_v_out_926082.awb")

						arg_49_1:RecordAudio("926082012", var_52_6)
						arg_49_1:RecordAudio("926082012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_926082", "926082012", "story_v_out_926082.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_926082", "926082012", "story_v_out_926082.awb")
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
	Play926082013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 926082013
		arg_53_1.duration_ = 3.13

		local var_53_0 = {
			zh = 2.333,
			ja = 3.133
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
				arg_53_0:Play926082014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos128404 = arg_53_1.actors_["128404"].transform.localPosition
				arg_53_1.actors_["128404"].transform.localScale = Vector3.New(1, 1, 1)

				arg_53_1:CheckSpriteTmpPos("128404", 3)

				for iter_56_0 = 0, arg_53_1.actors_["128404"].transform.childCount - 1 do
					local var_56_0 = arg_53_1.actors_["128404"].transform:GetChild(iter_56_0)

					if var_56_0.name == "" or not string.find(var_56_0.name, "split") then
						var_56_0.gameObject:SetActive(true)
					else
						var_56_0.gameObject:SetActive(false)
					end
				end
			end

			local var_56_1 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_1 then
				arg_53_1.actors_["128404"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_53_1.time_ - 0) / var_56_1)
			end

			if arg_53_1.time_ >= 0 + var_56_1 and arg_53_1.time_ < 0 + var_56_1 + arg_56_0 then
				arg_53_1.actors_["128404"].transform.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_56_2 = 0
			local var_56_3 = 0.3

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_4 = arg_53_1:GetWordFromCfg(926082013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 12 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 12)

				if (12 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 12)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082013", "story_v_out_926082.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082013", "story_v_out_926082.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_926082", "926082013", "story_v_out_926082.awb")

						arg_53_1:RecordAudio("926082013", var_56_9)
						arg_53_1:RecordAudio("926082013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_926082", "926082013", "story_v_out_926082.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_926082", "926082013", "story_v_out_926082.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_3, arg_53_1.talkMaxDuration)

			if var_56_2 <= arg_53_1.time_ and arg_53_1.time_ < var_56_2 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_2) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_2 + var_56_10 and arg_53_1.time_ < var_56_2 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play926082014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 926082014
		arg_57_1.duration_ = 8.1

		local var_57_0 = {
			zh = 7.43333333333333,
			ja = 8.09933333333333
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
				arg_57_0:Play926082015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if arg_57_1.actors_["10144"] == nil then
				local var_60_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

				if not isNil(var_60_0) then
					local var_60_1 = Object.Instantiate(var_60_0, arg_57_1.canvasGo_.transform)

					var_60_1.transform:SetSiblingIndex(1)

					var_60_1.name = "10144"
					var_60_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_57_1.actors_["10144"] = var_60_1

					if arg_57_1.isInRecall_ then
						for iter_60_0, iter_60_1 in ipairs((var_60_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_60_1.color = arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_60_2 = arg_57_1.actors_["10144"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10144 == nil then
				arg_57_1.var_.actorSpriteComps10144 = var_60_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_3 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.actorSpriteComps10144 then
					for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_60_3 then
							if arg_57_1.isInRecall_ then
								iter_60_3.color = Color.New(Mathf.Lerp(iter_60_3.color.r, arg_57_1.hightColor1.r, (arg_57_1.time_ - 0) / var_60_3), Mathf.Lerp(iter_60_3.color.g, arg_57_1.hightColor1.g, (arg_57_1.time_ - 0) / var_60_3), (Mathf.Lerp(iter_60_3.color.b, arg_57_1.hightColor1.b, (arg_57_1.time_ - 0) / var_60_3)))
							else
								local var_60_4 = Mathf.Lerp(iter_60_3.color.r, 1, (arg_57_1.time_ - 0) / var_60_3)

								iter_60_3.color = Color.New(var_60_4, var_60_4, var_60_4)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.actorSpriteComps10144 then
				for iter_60_4, iter_60_5 in pairs(arg_57_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_60_5 then
						iter_60_5.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps10144 = nil
			end

			local var_60_5 = arg_57_1.actors_["128404"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.actorSpriteComps128404 == nil then
				arg_57_1.var_.actorSpriteComps128404 = var_60_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_6 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_6 and not isNil(var_60_5) then
				if arg_57_1.var_.actorSpriteComps128404 then
					for iter_60_6, iter_60_7 in pairs(arg_57_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_60_7 then
							if arg_57_1.isInRecall_ then
								iter_60_7.color = Color.New(Mathf.Lerp(iter_60_7.color.r, arg_57_1.hightColor2.r, (arg_57_1.time_ - 0) / var_60_6), Mathf.Lerp(iter_60_7.color.g, arg_57_1.hightColor2.g, (arg_57_1.time_ - 0) / var_60_6), (Mathf.Lerp(iter_60_7.color.b, arg_57_1.hightColor2.b, (arg_57_1.time_ - 0) / var_60_6)))
							else
								local var_60_7 = Mathf.Lerp(iter_60_7.color.r, 0.5, (arg_57_1.time_ - 0) / var_60_6)

								iter_60_7.color = Color.New(var_60_7, var_60_7, var_60_7)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_6 and arg_57_1.time_ < 0 + var_60_6 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.actorSpriteComps128404 then
				for iter_60_8, iter_60_9 in pairs(arg_57_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_60_9 then
						iter_60_9.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps128404 = nil
			end

			local var_60_8 = arg_57_1.actors_["128404"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos128404 = var_60_8.localPosition
				var_60_8.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("128404", 7)

				for iter_60_10 = 0, var_60_8.childCount - 1 do
					local var_60_9 = var_60_8:GetChild(iter_60_10)

					if var_60_9.name == "" or not string.find(var_60_9.name, "split") then
						var_60_9.gameObject:SetActive(true)
					else
						var_60_9.gameObject:SetActive(false)
					end
				end
			end

			local var_60_10 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_10 then
				var_60_8.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_57_1.time_ - 0) / var_60_10)
			end

			if arg_57_1.time_ >= 0 + var_60_10 and arg_57_1.time_ < 0 + var_60_10 + arg_60_0 then
				var_60_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_60_11 = "story_item_22201"

			if arg_57_1.actors_.story_item_22201 == nil then
				local var_60_12 = Object.Instantiate(arg_57_1.imageGo_, arg_57_1.canvasGo_.transform)

				var_60_12.transform:SetSiblingIndex(1)

				var_60_12.name = var_60_11

				local var_60_13 = var_60_12:GetComponent(typeof(Image))

				var_60_13.sprite = getSpriteWithoutAtlas("TextureConfig/UIStoryImages/story_item_22201")

				var_60_13:SetNativeSize()

				var_60_12.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_57_1.actors_[var_60_11] = var_60_12
			end

			local var_60_14 = arg_57_1.actors_.story_item_22201.transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPosstory_item_22201 = var_60_14.localPosition
				var_60_14.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("story_item_22201", 3)
			end

			local var_60_15 = 0.8

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_15 then
				var_60_14.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPosstory_item_22201, Vector3.New(0, 0, 0), (arg_57_1.time_ - 0) / var_60_15)
			end

			if arg_57_1.time_ >= 0 + var_60_15 and arg_57_1.time_ < 0 + var_60_15 + arg_60_0 then
				var_60_14.localPosition = Vector3.New(0, 0, 0)
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:AudioAction("play", "effect", "se_story_143", "se_story_143_bell", "")
			end

			local var_60_17 = 0

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_17 + arg_60_0 then
				arg_57_1.allBtn_.enabled = false
			end

			if arg_57_1.time_ >= var_60_17 + 1.38333333333333 and arg_57_1.time_ < var_60_17 + 1.38333333333333 + arg_60_0 then
				arg_57_1.allBtn_.enabled = true
			end

			if arg_57_1.frameCnt_ <= 1 then
				arg_57_1.dialog_:SetActive(false)
			end

			local var_60_18 = 1.23333333333333
			local var_60_19 = 0.55

			if 1.23333333333333 < arg_57_1.time_ and arg_57_1.time_ <= var_60_18 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0

				arg_57_1.dialog_:SetActive(true)

				arg_57_1.dialogCg_.alpha = 0

				local var_60_20 = LeanTween.value(arg_57_1.dialog_, 0, 1, 0.3)

				var_60_20:setOnUpdate(LuaHelper.FloatAction(function(arg_61_0)
					arg_57_1.dialogCg_.alpha = arg_61_0
				end))
				var_60_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_57_1.dialog_)
					var_60_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_57_1.duration_ = arg_57_1.duration_ + 0.3

				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_21 = arg_57_1:GetWordFromCfg(926082014)
				local var_60_22 = arg_57_1:FormatText(var_60_21.content)

				arg_57_1.text_.text = var_60_22

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_24 = 22 <= 0 and var_60_19 or var_60_19 * (utf8.len(var_60_22) / 22)

				if (22 <= 0 and var_60_19 or var_60_19 * (utf8.len(var_60_22) / 22)) > 0 and var_60_19 < var_60_24 then
					arg_57_1.talkMaxDuration = var_60_24
					var_60_18 = var_60_18 + 0.3

					if var_60_24 + var_60_18 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_24 + var_60_18
					end
				end

				arg_57_1.text_.text = var_60_22
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082014", "story_v_out_926082.awb") ~= 0 then
					local var_60_25 = manager.audio:GetVoiceLength("story_v_out_926082", "926082014", "story_v_out_926082.awb") / 1000

					if var_60_25 + var_60_18 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_25 + var_60_18
					end

					if var_60_21.prefab_name ~= "" and arg_57_1.actors_[var_60_21.prefab_name] ~= nil then
						local var_60_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_21.prefab_name].transform, "story_v_out_926082", "926082014", "story_v_out_926082.awb")

						arg_57_1:RecordAudio("926082014", var_60_26)
						arg_57_1:RecordAudio("926082014", var_60_26)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_926082", "926082014", "story_v_out_926082.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_926082", "926082014", "story_v_out_926082.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_27 = var_60_18 + 0.3
			local var_60_28 = math.max(var_60_19, arg_57_1.talkMaxDuration)

			if var_60_18 + 0.3 <= arg_57_1.time_ and arg_57_1.time_ < var_60_27 + var_60_28 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_27) / var_60_28

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_27 + var_60_28 and arg_57_1.time_ < var_60_27 + var_60_28 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "TextureConfig/UIStoryImages/story_item_22201",
				needEase = true,
				actorName = "story_item_22201",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.8,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0, 0),
					endPos = Vector3.New(0, 0, 0),
					easeType = LeanTweenType.easeInQuint
				}
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play926082015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 926082015
		arg_63_1.duration_ = 5.9

		local var_63_0 = {
			zh = 5.833,
			ja = 5.9
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
				arg_63_0:Play926082016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["128404"]) and arg_63_1.var_.actorSpriteComps128404 == nil then
				arg_63_1.var_.actorSpriteComps128404 = arg_63_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_0 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["128404"]) then
				if arg_63_1.var_.actorSpriteComps128404 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_66_1 then
							if arg_63_1.isInRecall_ then
								iter_66_1.color = Color.New(Mathf.Lerp(iter_66_1.color.r, arg_63_1.hightColor1.r, (arg_63_1.time_ - 0) / var_66_0), Mathf.Lerp(iter_66_1.color.g, arg_63_1.hightColor1.g, (arg_63_1.time_ - 0) / var_66_0), (Mathf.Lerp(iter_66_1.color.b, arg_63_1.hightColor1.b, (arg_63_1.time_ - 0) / var_66_0)))
							else
								local var_66_1 = Mathf.Lerp(iter_66_1.color.r, 1, (arg_63_1.time_ - 0) / var_66_0)

								iter_66_1.color = Color.New(var_66_1, var_66_1, var_66_1)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["128404"]) and arg_63_1.var_.actorSpriteComps128404 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_66_3 then
						iter_66_3.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_63_1.var_.actorSpriteComps128404 = nil
			end

			local var_66_2 = arg_63_1.actors_["10144"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.actorSpriteComps10144 == nil then
				arg_63_1.var_.actorSpriteComps10144 = var_66_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_3 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_3 and not isNil(var_66_2) then
				if arg_63_1.var_.actorSpriteComps10144 then
					for iter_66_4, iter_66_5 in pairs(arg_63_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_66_5 then
							if arg_63_1.isInRecall_ then
								iter_66_5.color = Color.New(Mathf.Lerp(iter_66_5.color.r, arg_63_1.hightColor2.r, (arg_63_1.time_ - 0) / var_66_3), Mathf.Lerp(iter_66_5.color.g, arg_63_1.hightColor2.g, (arg_63_1.time_ - 0) / var_66_3), (Mathf.Lerp(iter_66_5.color.b, arg_63_1.hightColor2.b, (arg_63_1.time_ - 0) / var_66_3)))
							else
								local var_66_4 = Mathf.Lerp(iter_66_5.color.r, 0.5, (arg_63_1.time_ - 0) / var_66_3)

								iter_66_5.color = Color.New(var_66_4, var_66_4, var_66_4)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_3 and arg_63_1.time_ < 0 + var_66_3 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.actorSpriteComps10144 then
				for iter_66_6, iter_66_7 in pairs(arg_63_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_66_7 then
						iter_66_7.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_63_1.var_.actorSpriteComps10144 = nil
			end

			local var_66_5 = 0
			local var_66_6 = 0.575

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_5 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_7 = arg_63_1:GetWordFromCfg(926082015)
				local var_66_8 = arg_63_1:FormatText(var_66_7.content)

				arg_63_1.text_.text = var_66_8

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_10 = 23 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 23)

				if (23 <= 0 and var_66_6 or var_66_6 * (utf8.len(var_66_8) / 23)) > 0 and var_66_6 < var_66_10 then
					arg_63_1.talkMaxDuration = var_66_10

					if var_66_10 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_5
					end
				end

				arg_63_1.text_.text = var_66_8
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082015", "story_v_out_926082.awb") ~= 0 then
					local var_66_11 = manager.audio:GetVoiceLength("story_v_out_926082", "926082015", "story_v_out_926082.awb") / 1000

					if var_66_11 + var_66_5 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_11 + var_66_5
					end

					if var_66_7.prefab_name ~= "" and arg_63_1.actors_[var_66_7.prefab_name] ~= nil then
						local var_66_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_7.prefab_name].transform, "story_v_out_926082", "926082015", "story_v_out_926082.awb")

						arg_63_1:RecordAudio("926082015", var_66_12)
						arg_63_1:RecordAudio("926082015", var_66_12)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_926082", "926082015", "story_v_out_926082.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_926082", "926082015", "story_v_out_926082.awb")
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

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play926082016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 926082016
		arg_67_1.duration_ = 6.77

		local var_67_0 = {
			zh = 6.666,
			ja = 6.766
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
				arg_67_0:Play926082017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.8

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:GetWordFromCfg(926082016)
				local var_70_2 = arg_67_1:FormatText(var_70_1.content)

				arg_67_1.text_.text = var_70_2

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_4 = 32 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 32)

				if (32 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_2) / 32)) > 0 and var_70_0 < var_70_4 then
					arg_67_1.talkMaxDuration = var_70_4

					if var_70_4 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_4 + 0
					end
				end

				arg_67_1.text_.text = var_70_2
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082016", "story_v_out_926082.awb") ~= 0 then
					local var_70_5 = manager.audio:GetVoiceLength("story_v_out_926082", "926082016", "story_v_out_926082.awb") / 1000

					if var_70_5 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + 0
					end

					if var_70_1.prefab_name ~= "" and arg_67_1.actors_[var_70_1.prefab_name] ~= nil then
						local var_70_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_1.prefab_name].transform, "story_v_out_926082", "926082016", "story_v_out_926082.awb")

						arg_67_1:RecordAudio("926082016", var_70_6)
						arg_67_1:RecordAudio("926082016", var_70_6)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_926082", "926082016", "story_v_out_926082.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_926082", "926082016", "story_v_out_926082.awb")
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
	Play926082017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 926082017
		arg_71_1.duration_ = 11.77

		local var_71_0 = {
			zh = 8.933,
			ja = 11.766
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
				arg_71_0:Play926082018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 1.05

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_1 = arg_71_1:GetWordFromCfg(926082017)
				local var_74_2 = arg_71_1:FormatText(var_74_1.content)

				arg_71_1.text_.text = var_74_2

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_4 = 42 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 42)

				if (42 <= 0 and var_74_0 or var_74_0 * (utf8.len(var_74_2) / 42)) > 0 and var_74_0 < var_74_4 then
					arg_71_1.talkMaxDuration = var_74_4

					if var_74_4 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_4 + 0
					end
				end

				arg_71_1.text_.text = var_74_2
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082017", "story_v_out_926082.awb") ~= 0 then
					local var_74_5 = manager.audio:GetVoiceLength("story_v_out_926082", "926082017", "story_v_out_926082.awb") / 1000

					if var_74_5 + 0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + 0
					end

					if var_74_1.prefab_name ~= "" and arg_71_1.actors_[var_74_1.prefab_name] ~= nil then
						local var_74_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_1.prefab_name].transform, "story_v_out_926082", "926082017", "story_v_out_926082.awb")

						arg_71_1:RecordAudio("926082017", var_74_6)
						arg_71_1:RecordAudio("926082017", var_74_6)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_926082", "926082017", "story_v_out_926082.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_926082", "926082017", "story_v_out_926082.awb")
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
	Play926082018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 926082018
		arg_75_1.duration_ = 5.9

		local var_75_0 = {
			zh = 5.3,
			ja = 5.9
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
				arg_75_0:Play926082019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos128404 = arg_75_1.actors_["128404"].transform.localPosition
				arg_75_1.actors_["128404"].transform.localScale = Vector3.New(1, 1, 1)

				arg_75_1:CheckSpriteTmpPos("128404", 7)

				for iter_78_0 = 0, arg_75_1.actors_["128404"].transform.childCount - 1 do
					local var_78_0 = arg_75_1.actors_["128404"].transform:GetChild(iter_78_0)

					if var_78_0.name == "split_6" or not string.find(var_78_0.name, "split") then
						var_78_0.gameObject:SetActive(true)
					else
						var_78_0.gameObject:SetActive(false)
					end
				end
			end

			local var_78_1 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_1 then
				arg_75_1.actors_["128404"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_75_1.time_ - 0) / var_78_1)
			end

			if arg_75_1.time_ >= 0 + var_78_1 and arg_75_1.time_ < 0 + var_78_1 + arg_78_0 then
				arg_75_1.actors_["128404"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_78_2 = 0
			local var_78_3 = 0.675

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_2 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, true)
				arg_75_1.iconController_:SetSelectedState("hero")

				arg_75_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_75_1.callingController_:SetSelectedState("normal")

				arg_75_1.keyicon_.color = Color.New(1, 1, 1)
				arg_75_1.icon_.color = Color.New(1, 1, 1)

				local var_78_4 = arg_75_1:GetWordFromCfg(926082018)
				local var_78_5 = arg_75_1:FormatText(var_78_4.content)

				arg_75_1.text_.text = var_78_5

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_7 = 27 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_5) / 27)

				if (27 <= 0 and var_78_3 or var_78_3 * (utf8.len(var_78_5) / 27)) > 0 and var_78_3 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_2
					end
				end

				arg_75_1.text_.text = var_78_5
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082018", "story_v_out_926082.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082018", "story_v_out_926082.awb") / 1000

					if var_78_8 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_2
					end

					if var_78_4.prefab_name ~= "" and arg_75_1.actors_[var_78_4.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_4.prefab_name].transform, "story_v_out_926082", "926082018", "story_v_out_926082.awb")

						arg_75_1:RecordAudio("926082018", var_78_9)
						arg_75_1:RecordAudio("926082018", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_926082", "926082018", "story_v_out_926082.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_926082", "926082018", "story_v_out_926082.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_3, arg_75_1.talkMaxDuration)

			if var_78_2 <= arg_75_1.time_ and arg_75_1.time_ < var_78_2 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_2) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_2 + var_78_10 and arg_75_1.time_ < var_78_2 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play926082019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 926082019
		arg_79_1.duration_ = 6.13

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play926082020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["128404"]) and arg_79_1.var_.actorSpriteComps128404 == nil then
				arg_79_1.var_.actorSpriteComps128404 = arg_79_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_0 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["128404"]) then
				if arg_79_1.var_.actorSpriteComps128404 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["128404"]) and arg_79_1.var_.actorSpriteComps128404 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_82_3 then
						iter_82_3.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_79_1.var_.actorSpriteComps128404 = nil
			end

			local var_82_2 = arg_79_1.actors_.story_item_22201.transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPosstory_item_22201 = var_82_2.localPosition
				var_82_2.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("story_item_22201", 7)
			end

			local var_82_3 = 0.766666666666667

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 then
				var_82_2.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPosstory_item_22201, Vector3.New(0, 0, 0), (arg_79_1.time_ - 0) / var_82_3)
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 then
				var_82_2.localPosition = Vector3.New(0, 0, 0)
			end

			local var_82_4 = arg_79_1.actors_.story_item_22201.transform

			if 0.766666666666667 < arg_79_1.time_ and arg_79_1.time_ <= 0.766666666666667 + arg_82_0 then
				arg_79_1.var_.moveOldPosstory_item_22201 = var_82_4.localPosition
				var_82_4.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("story_item_22201", 7)
			end

			local var_82_5 = 0.1

			if 0.766666666666667 <= arg_79_1.time_ and arg_79_1.time_ < 0.766666666666667 + var_82_5 then
				var_82_4.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPosstory_item_22201, Vector3.New(0, -2000, 0), (arg_79_1.time_ - 0.766666666666667) / var_82_5)
			end

			if arg_79_1.time_ >= 0.766666666666667 + var_82_5 and arg_79_1.time_ < 0.766666666666667 + var_82_5 + arg_82_0 then
				var_82_4.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_82_6 = 0

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.allBtn_.enabled = false
			end

			if arg_79_1.time_ >= var_82_6 + 1.93333333333333 and arg_79_1.time_ < var_82_6 + 1.93333333333333 + arg_82_0 then
				arg_79_1.allBtn_.enabled = true
			end

			if arg_79_1.frameCnt_ <= 1 then
				arg_79_1.dialog_:SetActive(false)
			end

			local var_82_7 = 1.13333333333333
			local var_82_8 = 0.525

			if 1.13333333333333 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0

				arg_79_1.dialog_:SetActive(true)

				arg_79_1.dialogCg_.alpha = 0

				local var_82_9 = LeanTween.value(arg_79_1.dialog_, 0, 1, 0.3)

				var_82_9:setOnUpdate(LuaHelper.FloatAction(function(arg_83_0)
					arg_79_1.dialogCg_.alpha = arg_83_0
				end))
				var_82_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_79_1.dialog_)
					var_82_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_79_1.duration_ = arg_79_1.duration_ + 0.3

				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_10 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(926082019).content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_12 = 21 <= 0 and var_82_8 or var_82_8 * (utf8.len(var_82_10) / 21)

				if (21 <= 0 and var_82_8 or var_82_8 * (utf8.len(var_82_10) / 21)) > 0 and var_82_8 < var_82_12 then
					arg_79_1.talkMaxDuration = var_82_12
					var_82_7 = var_82_7 + 0.3

					if var_82_12 + var_82_7 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_12 + var_82_7
					end
				end

				arg_79_1.text_.text = var_82_10
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_13 = var_82_7 + 0.3
			local var_82_14 = math.max(var_82_8, arg_79_1.talkMaxDuration)

			if var_82_7 + 0.3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_13 + var_82_14 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_13) / var_82_14

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_13 + var_82_14 and arg_79_1.time_ < var_82_13 + var_82_14 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "TextureConfig/UIStoryImages/story_item_22201",
				needEase = true,
				actorName = "story_item_22201",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.766666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 0,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_OUT,
					startPos = Vector3.New(0, 0, 0),
					endPos = Vector3.New(0, 0, 0),
					easeType = LeanTweenType.easeInQuint
				}
			},
			{
				assetPath = "TextureConfig/UIStoryImages/story_item_22201",
				actorName = "story_item_22201",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0.766666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play926082020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 926082020
		arg_85_1.duration_ = 2.53

		local var_85_0 = {
			zh = 1.66633333333333,
			ja = 2.53333333333333
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
				arg_85_0:Play926082021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_9000

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["128404"]) and arg_85_1.var_.actorSpriteComps128404 == nil then
				arg_85_1.var_.actorSpriteComps128404 = arg_85_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_0 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["128404"]) then
				if arg_85_1.var_.actorSpriteComps128404 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_88_1 then
							if arg_85_1.isInRecall_ then
								iter_88_1.color = Color.New(Mathf.Lerp(iter_88_1.color.r, arg_85_1.hightColor1.r, (arg_85_1.time_ - 0) / var_88_0), Mathf.Lerp(iter_88_1.color.g, arg_85_1.hightColor1.g, (arg_85_1.time_ - 0) / var_88_0), (Mathf.Lerp(iter_88_1.color.b, arg_85_1.hightColor1.b, (arg_85_1.time_ - 0) / var_88_0)))
							else
								local var_88_1 = Mathf.Lerp(iter_88_1.color.r, 1, (arg_85_1.time_ - 0) / var_88_0)

								iter_88_1.color = Color.New(var_88_1, var_88_1, var_88_1)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["128404"]) and arg_85_1.var_.actorSpriteComps128404 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_88_3 then
						iter_88_3.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps128404 = nil
			end

			if 0.0666666666666667 < arg_85_1.time_ and arg_85_1.time_ <= 0.0666666666666667 + arg_88_0 then
				local var_88_2 = arg_85_1.var_.effect9009

				if not arg_85_1.var_.effect9009 then
					var_88_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_lightmoment"), manager.ui.mainCamera.transform)
					var_88_2.name = "9009"
					arg_85_1.var_.effect9009 = var_88_2
				else
					var_88_2.transform:SetParent(var_88_9000)
				end

				var_88_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_88_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_88_4 = 0

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.allBtn_.enabled = false
			end

			if arg_85_1.time_ >= var_88_4 + 1.26666666666667 and arg_85_1.time_ < var_88_4 + 1.26666666666667 + arg_88_0 then
				arg_85_1.allBtn_.enabled = true
			end

			if 0.0666666666666667 < arg_85_1.time_ and arg_85_1.time_ <= 0.0666666666666667 + arg_88_0 then
				arg_85_1:AudioAction("play", "effect", "se_story_143", "se_story_143_bell02", "")
			end

			local var_88_6 = arg_85_1.actors_["128404"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos128404 = var_88_6.localPosition
				var_88_6.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("128404", 3)

				for iter_88_4 = 0, var_88_6.childCount - 1 do
					local var_88_7 = var_88_6:GetChild(iter_88_4)

					if var_88_7.name == "split_5" or not string.find(var_88_7.name, "split") then
						var_88_7.gameObject:SetActive(true)
					else
						var_88_7.gameObject:SetActive(false)
					end
				end
			end

			local var_88_8 = 0.1

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_8 then
				var_88_6.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_85_1.time_ - 0) / var_88_8)
			end

			if arg_85_1.time_ >= 0 + var_88_8 and arg_85_1.time_ < 0 + var_88_8 + arg_88_0 then
				var_88_6.localPosition = Vector3.New(-16.1, -362, -375)
			end

			if arg_85_1.frameCnt_ <= 1 then
				arg_85_1.dialog_:SetActive(false)
			end

			local var_88_9 = 0.533333333333333
			local var_88_10 = 0.1

			if 0.533333333333333 < arg_85_1.time_ and arg_85_1.time_ <= var_88_9 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0

				arg_85_1.dialog_:SetActive(true)

				arg_85_1.dialogCg_.alpha = 0

				local var_88_11 = LeanTween.value(arg_85_1.dialog_, 0, 1, 0.3)

				var_88_11:setOnUpdate(LuaHelper.FloatAction(function(arg_89_0)
					arg_85_1.dialogCg_.alpha = arg_89_0
				end))
				var_88_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_85_1.dialog_)
					var_88_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_85_1.duration_ = arg_85_1.duration_ + 0.3

				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_12 = arg_85_1:GetWordFromCfg(926082020)
				local var_88_13 = arg_85_1:FormatText(var_88_12.content)

				arg_85_1.text_.text = var_88_13

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_15 = 3 <= 0 and var_88_10 or var_88_10 * (utf8.len(var_88_13) / 3)

				if (3 <= 0 and var_88_10 or var_88_10 * (utf8.len(var_88_13) / 3)) > 0 and var_88_10 < var_88_15 then
					arg_85_1.talkMaxDuration = var_88_15
					var_88_9 = var_88_9 + 0.3

					if var_88_15 + var_88_9 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_15 + var_88_9
					end
				end

				arg_85_1.text_.text = var_88_13
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082020", "story_v_out_926082.awb") ~= 0 then
					local var_88_16 = manager.audio:GetVoiceLength("story_v_out_926082", "926082020", "story_v_out_926082.awb") / 1000

					if var_88_16 + var_88_9 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_16 + var_88_9
					end

					if var_88_12.prefab_name ~= "" and arg_85_1.actors_[var_88_12.prefab_name] ~= nil then
						local var_88_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_12.prefab_name].transform, "story_v_out_926082", "926082020", "story_v_out_926082.awb")

						arg_85_1:RecordAudio("926082020", var_88_17)
						arg_85_1:RecordAudio("926082020", var_88_17)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_926082", "926082020", "story_v_out_926082.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_926082", "926082020", "story_v_out_926082.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_18 = var_88_9 + 0.3
			local var_88_19 = math.max(var_88_10, arg_85_1.talkMaxDuration)

			if var_88_9 + 0.3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_18 + var_88_19 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_18) / var_88_19

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_18 + var_88_19 and arg_85_1.time_ < var_88_18 + var_88_19 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play926082021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 926082021
		arg_91_1.duration_ = 8.07

		local var_91_0 = {
			zh = 8.066,
			ja = 7.166
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
				arg_91_0:Play926082022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0.775

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_1 = arg_91_1:GetWordFromCfg(926082021)
				local var_94_2 = arg_91_1:FormatText(var_94_1.content)

				arg_91_1.text_.text = var_94_2

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_4 = 31 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 31)

				if (31 <= 0 and var_94_0 or var_94_0 * (utf8.len(var_94_2) / 31)) > 0 and var_94_0 < var_94_4 then
					arg_91_1.talkMaxDuration = var_94_4

					if var_94_4 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_4 + 0
					end
				end

				arg_91_1.text_.text = var_94_2
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082021", "story_v_out_926082.awb") ~= 0 then
					local var_94_5 = manager.audio:GetVoiceLength("story_v_out_926082", "926082021", "story_v_out_926082.awb") / 1000

					if var_94_5 + 0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + 0
					end

					if var_94_1.prefab_name ~= "" and arg_91_1.actors_[var_94_1.prefab_name] ~= nil then
						local var_94_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_1.prefab_name].transform, "story_v_out_926082", "926082021", "story_v_out_926082.awb")

						arg_91_1:RecordAudio("926082021", var_94_6)
						arg_91_1:RecordAudio("926082021", var_94_6)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_926082", "926082021", "story_v_out_926082.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_926082", "926082021", "story_v_out_926082.awb")
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
	Play926082022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 926082022
		arg_95_1.duration_ = 11.67

		local var_95_0 = {
			zh = 8.333,
			ja = 11.666
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play926082023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.925

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:GetWordFromCfg(926082022)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 37 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 37)

				if (37 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 37)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082022", "story_v_out_926082.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_out_926082", "926082022", "story_v_out_926082.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_out_926082", "926082022", "story_v_out_926082.awb")

						arg_95_1:RecordAudio("926082022", var_98_6)
						arg_95_1:RecordAudio("926082022", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_926082", "926082022", "story_v_out_926082.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_926082", "926082022", "story_v_out_926082.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_7 and arg_95_1.time_ < 0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play926082023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 926082023
		arg_99_1.duration_ = 10.2

		local var_99_0 = {
			zh = 7.6,
			ja = 10.2
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
				arg_99_0:Play926082024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.95

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:GetWordFromCfg(926082023)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 38 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 38)

				if (38 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 38)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082023", "story_v_out_926082.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_926082", "926082023", "story_v_out_926082.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_926082", "926082023", "story_v_out_926082.awb")

						arg_99_1:RecordAudio("926082023", var_102_6)
						arg_99_1:RecordAudio("926082023", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_926082", "926082023", "story_v_out_926082.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_926082", "926082023", "story_v_out_926082.awb")
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
	Play926082024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 926082024
		arg_103_1.duration_ = 9.63

		local var_103_0 = {
			zh = 9.633,
			ja = 7.2
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
				arg_103_0:Play926082025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 1.125

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_1 = arg_103_1:GetWordFromCfg(926082024)
				local var_106_2 = arg_103_1:FormatText(var_106_1.content)

				arg_103_1.text_.text = var_106_2

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_4 = 45 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 45)

				if (45 <= 0 and var_106_0 or var_106_0 * (utf8.len(var_106_2) / 45)) > 0 and var_106_0 < var_106_4 then
					arg_103_1.talkMaxDuration = var_106_4

					if var_106_4 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_4 + 0
					end
				end

				arg_103_1.text_.text = var_106_2
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082024", "story_v_out_926082.awb") ~= 0 then
					local var_106_5 = manager.audio:GetVoiceLength("story_v_out_926082", "926082024", "story_v_out_926082.awb") / 1000

					if var_106_5 + 0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + 0
					end

					if var_106_1.prefab_name ~= "" and arg_103_1.actors_[var_106_1.prefab_name] ~= nil then
						local var_106_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_1.prefab_name].transform, "story_v_out_926082", "926082024", "story_v_out_926082.awb")

						arg_103_1:RecordAudio("926082024", var_106_6)
						arg_103_1:RecordAudio("926082024", var_106_6)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_926082", "926082024", "story_v_out_926082.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_926082", "926082024", "story_v_out_926082.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_7 = math.max(var_106_0, arg_103_1.talkMaxDuration)

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_7 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - 0) / var_106_7

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= 0 + var_106_7 and arg_103_1.time_ < 0 + var_106_7 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play926082025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 926082025
		arg_107_1.duration_ = 11.3

		local var_107_0 = {
			zh = 8.5,
			ja = 11.3
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
				arg_107_0:Play926082026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.95

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_1 = arg_107_1:GetWordFromCfg(926082025)
				local var_110_2 = arg_107_1:FormatText(var_110_1.content)

				arg_107_1.text_.text = var_110_2

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_4 = 38 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 38)

				if (38 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_2) / 38)) > 0 and var_110_0 < var_110_4 then
					arg_107_1.talkMaxDuration = var_110_4

					if var_110_4 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_4 + 0
					end
				end

				arg_107_1.text_.text = var_110_2
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082025", "story_v_out_926082.awb") ~= 0 then
					local var_110_5 = manager.audio:GetVoiceLength("story_v_out_926082", "926082025", "story_v_out_926082.awb") / 1000

					if var_110_5 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_5 + 0
					end

					if var_110_1.prefab_name ~= "" and arg_107_1.actors_[var_110_1.prefab_name] ~= nil then
						local var_110_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_1.prefab_name].transform, "story_v_out_926082", "926082025", "story_v_out_926082.awb")

						arg_107_1:RecordAudio("926082025", var_110_6)
						arg_107_1:RecordAudio("926082025", var_110_6)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_926082", "926082025", "story_v_out_926082.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_926082", "926082025", "story_v_out_926082.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_7 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_7

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play926082026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 926082026
		arg_111_1.duration_ = 4.5

		local var_111_0 = {
			zh = 3.9,
			ja = 4.5
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
				arg_111_0:Play926082027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos128404 = arg_111_1.actors_["128404"].transform.localPosition
				arg_111_1.actors_["128404"].transform.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("128404", 3)

				for iter_114_0 = 0, arg_111_1.actors_["128404"].transform.childCount - 1 do
					local var_114_0 = arg_111_1.actors_["128404"].transform:GetChild(iter_114_0)

					if var_114_0.name == "split_2" or not string.find(var_114_0.name, "split") then
						var_114_0.gameObject:SetActive(true)
					else
						var_114_0.gameObject:SetActive(false)
					end
				end
			end

			local var_114_1 = 0.533333333333333

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_1 then
				arg_111_1.actors_["128404"].transform.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos128404, Vector3.New(-289.9, -356, -623.82), (arg_111_1.time_ - 0) / var_114_1)
			end

			if arg_111_1.time_ >= 0 + var_114_1 and arg_111_1.time_ < 0 + var_114_1 + arg_114_0 then
				arg_111_1.actors_["128404"].transform.localPosition = Vector3.New(-289.9, -356, -623.82)
			end

			local var_114_2 = arg_111_1.actors_["128404"].transform

			if 0.533333333333333 < arg_111_1.time_ and arg_111_1.time_ <= 0.533333333333333 + arg_114_0 then
				arg_111_1.var_.moveOldPos128404 = var_114_2.localPosition
				var_114_2.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("128404", 3)

				for iter_114_1 = 0, var_114_2.childCount - 1 do
					local var_114_3 = var_114_2:GetChild(iter_114_1)

					if var_114_3.name == "split_2" or not string.find(var_114_3.name, "split") then
						var_114_3.gameObject:SetActive(true)
					else
						var_114_3.gameObject:SetActive(false)
					end
				end
			end

			local var_114_4 = 0.833333333333333

			if 0.533333333333333 <= arg_111_1.time_ and arg_111_1.time_ < 0.533333333333333 + var_114_4 then
				var_114_2.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos128404, Vector3.New(289.4, -356, -623.82), (arg_111_1.time_ - 0.533333333333333) / var_114_4)
			end

			if arg_111_1.time_ >= 0.533333333333333 + var_114_4 and arg_111_1.time_ < 0.533333333333333 + var_114_4 + arg_114_0 then
				var_114_2.localPosition = Vector3.New(289.4, -356, -623.82)
			end

			local var_114_5 = arg_111_1.actors_["128404"].transform

			if 1.36666666666667 < arg_111_1.time_ and arg_111_1.time_ <= 1.36666666666667 + arg_114_0 then
				arg_111_1.var_.moveOldPos128404 = var_114_5.localPosition
				var_114_5.localScale = Vector3.New(1, 1, 1)

				arg_111_1:CheckSpriteTmpPos("128404", 3)

				for iter_114_2 = 0, var_114_5.childCount - 1 do
					local var_114_6 = var_114_5:GetChild(iter_114_2)

					if var_114_6.name == "split_2" or not string.find(var_114_6.name, "split") then
						var_114_6.gameObject:SetActive(true)
					else
						var_114_6.gameObject:SetActive(false)
					end
				end
			end

			local var_114_7 = 0.666666666665333

			if 1.36666666666667 <= arg_111_1.time_ and arg_111_1.time_ < 1.36666666666667 + var_114_7 then
				var_114_5.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos128404, Vector3.New(-29.4, -356, -623.82), (arg_111_1.time_ - 1.36666666666667) / var_114_7)
			end

			if arg_111_1.time_ >= 1.36666666666667 + var_114_7 and arg_111_1.time_ < 1.36666666666667 + var_114_7 + arg_114_0 then
				var_114_5.localPosition = Vector3.New(-29.4, -356, -623.82)
			end

			local var_114_8 = 0

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_8 + arg_114_0 then
				arg_111_1.allBtn_.enabled = false
			end

			if arg_111_1.time_ >= var_114_8 + 2.16666666666667 and arg_111_1.time_ < var_114_8 + 2.16666666666667 + arg_114_0 then
				arg_111_1.allBtn_.enabled = true
			end

			local var_114_9 = 0
			local var_114_10 = 0.275

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_9 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_11 = arg_111_1:GetWordFromCfg(926082026)
				local var_114_12 = arg_111_1:FormatText(var_114_11.content)

				arg_111_1.text_.text = var_114_12

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_14 = 11 <= 0 and var_114_10 or var_114_10 * (utf8.len(var_114_12) / 11)

				if (11 <= 0 and var_114_10 or var_114_10 * (utf8.len(var_114_12) / 11)) > 0 and var_114_10 < var_114_14 then
					arg_111_1.talkMaxDuration = var_114_14

					if var_114_14 + var_114_9 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_14 + var_114_9
					end
				end

				arg_111_1.text_.text = var_114_12
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082026", "story_v_out_926082.awb") ~= 0 then
					local var_114_15 = manager.audio:GetVoiceLength("story_v_out_926082", "926082026", "story_v_out_926082.awb") / 1000

					if var_114_15 + var_114_9 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_15 + var_114_9
					end

					if var_114_11.prefab_name ~= "" and arg_111_1.actors_[var_114_11.prefab_name] ~= nil then
						local var_114_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_11.prefab_name].transform, "story_v_out_926082", "926082026", "story_v_out_926082.awb")

						arg_111_1:RecordAudio("926082026", var_114_16)
						arg_111_1:RecordAudio("926082026", var_114_16)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_926082", "926082026", "story_v_out_926082.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_926082", "926082026", "story_v_out_926082.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_17 = math.max(var_114_10, arg_111_1.talkMaxDuration)

			if var_114_9 <= arg_111_1.time_ and arg_111_1.time_ < var_114_9 + var_114_17 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_9) / var_114_17

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_9 + var_114_17 and arg_111_1.time_ < var_114_9 + var_114_17 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "128404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.533333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-29.4, -356, -623.82),
					endPos = Vector3.New(-289.9, -356, -623.82),
					easeType = LeanTweenType.pingPong
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "128404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.833333333333333,
				startTime = 0.533333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-289.9, -356, -623.82),
					endPos = Vector3.New(289.4, -356, -623.82),
					easeType = LeanTweenType.pingPong
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "128404",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.666666666665333,
				startTime = 1.36666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(289.4, -356, -623.82),
					endPos = Vector3.New(-29.4, -356, -623.82),
					easeType = LeanTweenType.pingPong
				}
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play926082027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 926082027
		arg_115_1.duration_ = 9.83

		local var_115_0 = {
			zh = 9.266,
			ja = 9.833
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
				arg_115_0:Play926082028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 1.125

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:GetWordFromCfg(926082027)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 45 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 45)

				if (45 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 45)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082027", "story_v_out_926082.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_out_926082", "926082027", "story_v_out_926082.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_out_926082", "926082027", "story_v_out_926082.awb")

						arg_115_1:RecordAudio("926082027", var_118_6)
						arg_115_1:RecordAudio("926082027", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_926082", "926082027", "story_v_out_926082.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_926082", "926082027", "story_v_out_926082.awb")
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
	Play926082028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 926082028
		arg_119_1.duration_ = 6.47

		local var_119_0 = {
			zh = 6.466,
			ja = 5.566
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
				arg_119_0:Play926082029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos128404 = arg_119_1.actors_["128404"].transform.localPosition
				arg_119_1.actors_["128404"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("128404", 3)

				for iter_122_0 = 0, arg_119_1.actors_["128404"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["128404"].transform:GetChild(iter_122_0)

					if var_122_0.name == "split_5" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["128404"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos128404, Vector3.New(-29.4, -356, -632.82), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["128404"].transform.localPosition = Vector3.New(-29.4, -356, -632.82)
			end

			local var_122_2 = 0
			local var_122_3 = 0.5

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_4 = arg_119_1:GetWordFromCfg(926082028)
				local var_122_5 = arg_119_1:FormatText(var_122_4.content)

				arg_119_1.text_.text = var_122_5

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_7 = 20 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_5) / 20)

				if (20 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_5) / 20)) > 0 and var_122_3 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_2
					end
				end

				arg_119_1.text_.text = var_122_5
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082028", "story_v_out_926082.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082028", "story_v_out_926082.awb") / 1000

					if var_122_8 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_2
					end

					if var_122_4.prefab_name ~= "" and arg_119_1.actors_[var_122_4.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_4.prefab_name].transform, "story_v_out_926082", "926082028", "story_v_out_926082.awb")

						arg_119_1:RecordAudio("926082028", var_122_9)
						arg_119_1:RecordAudio("926082028", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_926082", "926082028", "story_v_out_926082.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_926082", "926082028", "story_v_out_926082.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_10 = math.max(var_122_3, arg_119_1.talkMaxDuration)

			if var_122_2 <= arg_119_1.time_ and arg_119_1.time_ < var_122_2 + var_122_10 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_2) / var_122_10

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_2 + var_122_10 and arg_119_1.time_ < var_122_2 + var_122_10 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play926082029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 926082029
		arg_123_1.duration_ = 8.07

		local var_123_0 = {
			zh = 5.5,
			ja = 8.066
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
				arg_123_0:Play926082030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos128404 = arg_123_1.actors_["128404"].transform.localPosition
				arg_123_1.actors_["128404"].transform.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("128404", 3)

				for iter_126_0 = 0, arg_123_1.actors_["128404"].transform.childCount - 1 do
					local var_126_0 = arg_123_1.actors_["128404"].transform:GetChild(iter_126_0)

					if var_126_0.name == "split_4" or not string.find(var_126_0.name, "split") then
						var_126_0.gameObject:SetActive(true)
					else
						var_126_0.gameObject:SetActive(false)
					end
				end
			end

			local var_126_1 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 then
				arg_123_1.actors_["128404"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos128404, Vector3.New(-29.4, -356, -632.82), (arg_123_1.time_ - 0) / var_126_1)
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 then
				arg_123_1.actors_["128404"].transform.localPosition = Vector3.New(-29.4, -356, -632.82)
			end

			local var_126_2 = 0
			local var_126_3 = 0.625

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_4 = arg_123_1:GetWordFromCfg(926082029)
				local var_126_5 = arg_123_1:FormatText(var_126_4.content)

				arg_123_1.text_.text = var_126_5

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_7 = 25 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 25)

				if (25 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_5) / 25)) > 0 and var_126_3 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_2
					end
				end

				arg_123_1.text_.text = var_126_5
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082029", "story_v_out_926082.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082029", "story_v_out_926082.awb") / 1000

					if var_126_8 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_2
					end

					if var_126_4.prefab_name ~= "" and arg_123_1.actors_[var_126_4.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_4.prefab_name].transform, "story_v_out_926082", "926082029", "story_v_out_926082.awb")

						arg_123_1:RecordAudio("926082029", var_126_9)
						arg_123_1:RecordAudio("926082029", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_926082", "926082029", "story_v_out_926082.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_926082", "926082029", "story_v_out_926082.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_3, arg_123_1.talkMaxDuration)

			if var_126_2 <= arg_123_1.time_ and arg_123_1.time_ < var_126_2 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_2) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_2 + var_126_10 and arg_123_1.time_ < var_126_2 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play926082030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 926082030
		arg_127_1.duration_ = 8.07

		local var_127_0 = {
			zh = 7.366,
			ja = 8.066
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
				arg_127_0:Play926082031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["10144"]) and arg_127_1.var_.actorSpriteComps10144 == nil then
				arg_127_1.var_.actorSpriteComps10144 = arg_127_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_0 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["10144"]) then
				if arg_127_1.var_.actorSpriteComps10144 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_130_1 then
							if arg_127_1.isInRecall_ then
								iter_130_1.color = Color.New(Mathf.Lerp(iter_130_1.color.r, arg_127_1.hightColor1.r, (arg_127_1.time_ - 0) / var_130_0), Mathf.Lerp(iter_130_1.color.g, arg_127_1.hightColor1.g, (arg_127_1.time_ - 0) / var_130_0), (Mathf.Lerp(iter_130_1.color.b, arg_127_1.hightColor1.b, (arg_127_1.time_ - 0) / var_130_0)))
							else
								local var_130_1 = Mathf.Lerp(iter_130_1.color.r, 1, (arg_127_1.time_ - 0) / var_130_0)

								iter_130_1.color = Color.New(var_130_1, var_130_1, var_130_1)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["10144"]) and arg_127_1.var_.actorSpriteComps10144 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_130_3 then
						iter_130_3.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps10144 = nil
			end

			local var_130_2 = arg_127_1.actors_["128404"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps128404 == nil then
				arg_127_1.var_.actorSpriteComps128404 = var_130_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_3 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_3 and not isNil(var_130_2) then
				if arg_127_1.var_.actorSpriteComps128404 then
					for iter_130_4, iter_130_5 in pairs(arg_127_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_130_5 then
							if arg_127_1.isInRecall_ then
								iter_130_5.color = Color.New(Mathf.Lerp(iter_130_5.color.r, arg_127_1.hightColor2.r, (arg_127_1.time_ - 0) / var_130_3), Mathf.Lerp(iter_130_5.color.g, arg_127_1.hightColor2.g, (arg_127_1.time_ - 0) / var_130_3), (Mathf.Lerp(iter_130_5.color.b, arg_127_1.hightColor2.b, (arg_127_1.time_ - 0) / var_130_3)))
							else
								local var_130_4 = Mathf.Lerp(iter_130_5.color.r, 0.5, (arg_127_1.time_ - 0) / var_130_3)

								iter_130_5.color = Color.New(var_130_4, var_130_4, var_130_4)
							end
						end
					end
				end
			end

			if arg_127_1.time_ >= 0 + var_130_3 and arg_127_1.time_ < 0 + var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps128404 then
				for iter_130_6, iter_130_7 in pairs(arg_127_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_130_7 then
						iter_130_7.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps128404 = nil
			end

			local var_130_5 = arg_127_1.actors_["128404"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos128404 = var_130_5.localPosition
				var_130_5.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("128404", 7)

				for iter_130_8 = 0, var_130_5.childCount - 1 do
					local var_130_6 = var_130_5:GetChild(iter_130_8)

					if var_130_6.name == "" or not string.find(var_130_6.name, "split") then
						var_130_6.gameObject:SetActive(true)
					else
						var_130_6.gameObject:SetActive(false)
					end
				end
			end

			local var_130_7 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				var_130_5.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_127_1.time_ - 0) / var_130_7)
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				var_130_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_130_8 = arg_127_1.actors_["10144"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10144 = var_130_8.localPosition
				var_130_8.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10144", 3)

				for iter_130_9 = 0, var_130_8.childCount - 1 do
					local var_130_9 = var_130_8:GetChild(iter_130_9)

					if var_130_9.name == "" or not string.find(var_130_9.name, "split") then
						var_130_9.gameObject:SetActive(true)
					else
						var_130_9.gameObject:SetActive(false)
					end
				end
			end

			local var_130_10 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_10 then
				var_130_8.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_127_1.time_ - 0) / var_130_10)
			end

			if arg_127_1.time_ >= 0 + var_130_10 and arg_127_1.time_ < 0 + var_130_10 + arg_130_0 then
				var_130_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_130_11 = 0
			local var_130_12 = 0.775

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_11 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_13 = arg_127_1:GetWordFromCfg(926082030)
				local var_130_14 = arg_127_1:FormatText(var_130_13.content)

				arg_127_1.text_.text = var_130_14

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_16 = 31 <= 0 and var_130_12 or var_130_12 * (utf8.len(var_130_14) / 31)

				if (31 <= 0 and var_130_12 or var_130_12 * (utf8.len(var_130_14) / 31)) > 0 and var_130_12 < var_130_16 then
					arg_127_1.talkMaxDuration = var_130_16

					if var_130_16 + var_130_11 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_16 + var_130_11
					end
				end

				arg_127_1.text_.text = var_130_14
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082030", "story_v_out_926082.awb") ~= 0 then
					local var_130_17 = manager.audio:GetVoiceLength("story_v_out_926082", "926082030", "story_v_out_926082.awb") / 1000

					if var_130_17 + var_130_11 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_17 + var_130_11
					end

					if var_130_13.prefab_name ~= "" and arg_127_1.actors_[var_130_13.prefab_name] ~= nil then
						local var_130_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_13.prefab_name].transform, "story_v_out_926082", "926082030", "story_v_out_926082.awb")

						arg_127_1:RecordAudio("926082030", var_130_18)
						arg_127_1:RecordAudio("926082030", var_130_18)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_926082", "926082030", "story_v_out_926082.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_926082", "926082030", "story_v_out_926082.awb")
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
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
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
	Play926082031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 926082031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play926082032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["10144"]) and arg_131_1.var_.actorSpriteComps10144 == nil then
				arg_131_1.var_.actorSpriteComps10144 = arg_131_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_134_0 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["10144"]) then
				if arg_131_1.var_.actorSpriteComps10144 then
					for iter_134_0, iter_134_1 in pairs(arg_131_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["10144"]) and arg_131_1.var_.actorSpriteComps10144 then
				for iter_134_2, iter_134_3 in pairs(arg_131_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_134_3 then
						iter_134_3.color = arg_131_1.isInRecall_ and (arg_131_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_131_1.var_.actorSpriteComps10144 = nil
			end

			local var_134_2 = 0
			local var_134_3 = 0.225

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_4 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(926082031).content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_6 = 9 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_4) / 9)

				if (9 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_4) / 9)) > 0 and var_134_3 < var_134_6 then
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
	Play926082032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 926082032
		arg_135_1.duration_ = 5.93

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play926082033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10144 = arg_135_1.actors_["10144"].transform.localPosition
				arg_135_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("10144", 7)

				for iter_138_0 = 0, arg_135_1.actors_["10144"].transform.childCount - 1 do
					local var_138_0 = arg_135_1.actors_["10144"].transform:GetChild(iter_138_0)

					if var_138_0.name == "" or not string.find(var_138_0.name, "split") then
						var_138_0.gameObject:SetActive(true)
					else
						var_138_0.gameObject:SetActive(false)
					end
				end
			end

			local var_138_1 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_1 then
				arg_135_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_135_1.time_ - 0) / var_138_1)
			end

			if arg_135_1.time_ >= 0 + var_138_1 and arg_135_1.time_ < 0 + var_138_1 + arg_138_0 then
				arg_135_1.actors_["10144"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.266666666666667 < arg_135_1.time_ and arg_135_1.time_ <= 0.266666666666667 + arg_138_0 then
				arg_135_1:AudioAction("play", "effect", "se_story_143", "se_story_143_cover", "")
			end

			local var_138_3 = "story_item_22202"

			if arg_135_1.actors_.story_item_22202 == nil then
				local var_138_4 = Object.Instantiate(arg_135_1.imageGo_, arg_135_1.canvasGo_.transform)

				var_138_4.transform:SetSiblingIndex(1)

				var_138_4.name = var_138_3

				local var_138_5 = var_138_4:GetComponent(typeof(Image))

				var_138_5.sprite = getSpriteWithoutAtlas("TextureConfig/UIStoryImages/story_item_22202")

				var_138_5:SetNativeSize()

				var_138_4.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_135_1.actors_[var_138_3] = var_138_4
			end

			local var_138_6 = arg_135_1.actors_.story_item_22202.transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPosstory_item_22202 = var_138_6.localPosition
				var_138_6.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("story_item_22202", 3)
			end

			local var_138_7 = 0.6

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				var_138_6.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPosstory_item_22202, Vector3.New(8.07, 12.38, 0), (arg_135_1.time_ - 0) / var_138_7)
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				var_138_6.localPosition = Vector3.New(8.07, 12.38, 0)
			end

			local var_138_8 = 0

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.allBtn_.enabled = false
			end

			if arg_135_1.time_ >= var_138_8 + 1.26666666666667 and arg_135_1.time_ < var_138_8 + 1.26666666666667 + arg_138_0 then
				arg_135_1.allBtn_.enabled = true
			end

			if arg_135_1.frameCnt_ <= 1 then
				arg_135_1.dialog_:SetActive(false)
			end

			local var_138_9 = 0.933333333333333
			local var_138_10 = 0.8

			if 0.933333333333333 < arg_135_1.time_ and arg_135_1.time_ <= var_138_9 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0

				arg_135_1.dialog_:SetActive(true)

				arg_135_1.dialogCg_.alpha = 0

				local var_138_11 = LeanTween.value(arg_135_1.dialog_, 0, 1, 0.3)

				var_138_11:setOnUpdate(LuaHelper.FloatAction(function(arg_139_0)
					arg_135_1.dialogCg_.alpha = arg_139_0
				end))
				var_138_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_135_1.dialog_)
					var_138_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_135_1.duration_ = arg_135_1.duration_ + 0.3

				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_12 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(926082032).content)

				arg_135_1.text_.text = var_138_12

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_14 = 32 <= 0 and var_138_10 or var_138_10 * (utf8.len(var_138_12) / 32)

				if (32 <= 0 and var_138_10 or var_138_10 * (utf8.len(var_138_12) / 32)) > 0 and var_138_10 < var_138_14 then
					arg_135_1.talkMaxDuration = var_138_14
					var_138_9 = var_138_9 + 0.3

					if var_138_14 + var_138_9 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_14 + var_138_9
					end
				end

				arg_135_1.text_.text = var_138_12
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_15 = var_138_9 + 0.3
			local var_138_16 = math.max(var_138_10, arg_135_1.talkMaxDuration)

			if var_138_9 + 0.3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_15 + var_138_16 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_15) / var_138_16

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_15 + var_138_16 and arg_135_1.time_ < var_138_15 + var_138_16 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "TextureConfig/UIStoryImages/story_item_22202",
				needEase = true,
				actorName = "story_item_22202",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.6,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(8.07, 14, 0),
					endPos = Vector3.New(8.07, 12.38, 0),
					easeType = LeanTweenType.easeInCirc
				}
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play926082033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 926082033
		arg_141_1.duration_ = 3.3

		local var_141_0 = {
			zh = 3.3,
			ja = 3.266
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
				arg_141_0:Play926082034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["128404"]) and arg_141_1.var_.actorSpriteComps128404 == nil then
				arg_141_1.var_.actorSpriteComps128404 = arg_141_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_144_0 = 0.2

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["128404"]) then
				if arg_141_1.var_.actorSpriteComps128404 then
					for iter_144_0, iter_144_1 in pairs(arg_141_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_144_1 then
							if arg_141_1.isInRecall_ then
								iter_144_1.color = Color.New(Mathf.Lerp(iter_144_1.color.r, arg_141_1.hightColor1.r, (arg_141_1.time_ - 0) / var_144_0), Mathf.Lerp(iter_144_1.color.g, arg_141_1.hightColor1.g, (arg_141_1.time_ - 0) / var_144_0), (Mathf.Lerp(iter_144_1.color.b, arg_141_1.hightColor1.b, (arg_141_1.time_ - 0) / var_144_0)))
							else
								local var_144_1 = Mathf.Lerp(iter_144_1.color.r, 1, (arg_141_1.time_ - 0) / var_144_0)

								iter_144_1.color = Color.New(var_144_1, var_144_1, var_144_1)
							end
						end
					end
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["128404"]) and arg_141_1.var_.actorSpriteComps128404 then
				for iter_144_2, iter_144_3 in pairs(arg_141_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_144_3 then
						iter_144_3.color = arg_141_1.isInRecall_ and (arg_141_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_141_1.var_.actorSpriteComps128404 = nil
			end

			local var_144_2 = arg_141_1.actors_["128404"].transform

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos128404 = var_144_2.localPosition
				var_144_2.localScale = Vector3.New(1, 1, 1)

				arg_141_1:CheckSpriteTmpPos("128404", 7)

				for iter_144_4 = 0, var_144_2.childCount - 1 do
					local var_144_3 = var_144_2:GetChild(iter_144_4)

					if var_144_3.name == "" or not string.find(var_144_3.name, "split") then
						var_144_3.gameObject:SetActive(true)
					else
						var_144_3.gameObject:SetActive(false)
					end
				end
			end

			local var_144_4 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_4 then
				var_144_2.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_141_1.time_ - 0) / var_144_4)
			end

			if arg_141_1.time_ >= 0 + var_144_4 and arg_141_1.time_ < 0 + var_144_4 + arg_144_0 then
				var_144_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_144_5 = 0
			local var_144_6 = 0.225

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_5 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_7 = arg_141_1:GetWordFromCfg(926082033)
				local var_144_8 = arg_141_1:FormatText(var_144_7.content)

				arg_141_1.text_.text = var_144_8

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_10 = 9 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 9)

				if (9 <= 0 and var_144_6 or var_144_6 * (utf8.len(var_144_8) / 9)) > 0 and var_144_6 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_5
					end
				end

				arg_141_1.text_.text = var_144_8
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082033", "story_v_out_926082.awb") ~= 0 then
					local var_144_11 = manager.audio:GetVoiceLength("story_v_out_926082", "926082033", "story_v_out_926082.awb") / 1000

					if var_144_11 + var_144_5 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_11 + var_144_5
					end

					if var_144_7.prefab_name ~= "" and arg_141_1.actors_[var_144_7.prefab_name] ~= nil then
						local var_144_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_7.prefab_name].transform, "story_v_out_926082", "926082033", "story_v_out_926082.awb")

						arg_141_1:RecordAudio("926082033", var_144_12)
						arg_141_1:RecordAudio("926082033", var_144_12)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_926082", "926082033", "story_v_out_926082.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_926082", "926082033", "story_v_out_926082.awb")
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
				actorName = "128404",
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
	Play926082034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 926082034
		arg_145_1.duration_ = 9.67

		local var_145_0 = {
			zh = 9.5,
			ja = 9.666
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
				arg_145_0:Play926082035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.975

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:GetWordFromCfg(926082034)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 39 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 39)

				if (39 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 39)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082034", "story_v_out_926082.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_926082", "926082034", "story_v_out_926082.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_926082", "926082034", "story_v_out_926082.awb")

						arg_145_1:RecordAudio("926082034", var_148_6)
						arg_145_1:RecordAudio("926082034", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_926082", "926082034", "story_v_out_926082.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_926082", "926082034", "story_v_out_926082.awb")
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
	Play926082035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 926082035
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play926082036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(arg_149_1.actors_["128404"]) and arg_149_1.var_.actorSpriteComps128404 == nil then
				arg_149_1.var_.actorSpriteComps128404 = arg_149_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_152_0 = 0.2

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 and not isNil(arg_149_1.actors_["128404"]) then
				if arg_149_1.var_.actorSpriteComps128404 then
					for iter_152_0, iter_152_1 in pairs(arg_149_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 and not isNil(arg_149_1.actors_["128404"]) and arg_149_1.var_.actorSpriteComps128404 then
				for iter_152_2, iter_152_3 in pairs(arg_149_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_152_3 then
						iter_152_3.color = arg_149_1.isInRecall_ and (arg_149_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_149_1.var_.actorSpriteComps128404 = nil
			end

			local var_152_2 = 0
			local var_152_3 = 0.275

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_2 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_4 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(926082035).content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_6 = 11 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_4) / 11)

				if (11 <= 0 and var_152_3 or var_152_3 * (utf8.len(var_152_4) / 11)) > 0 and var_152_3 < var_152_6 then
					arg_149_1.talkMaxDuration = var_152_6

					if var_152_6 + var_152_2 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_6 + var_152_2
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_7 = math.max(var_152_3, arg_149_1.talkMaxDuration)

			if var_152_2 <= arg_149_1.time_ and arg_149_1.time_ < var_152_2 + var_152_7 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_2) / var_152_7

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_2 + var_152_7 and arg_149_1.time_ < var_152_2 + var_152_7 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play926082036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 926082036
		arg_153_1.duration_ = 1.8

		local var_153_0 = {
			zh = 1.166,
			ja = 1.8
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
				arg_153_0:Play926082037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(arg_153_1.actors_["128404"]) and arg_153_1.var_.actorSpriteComps128404 == nil then
				arg_153_1.var_.actorSpriteComps128404 = arg_153_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_156_0 = 0.2

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 and not isNil(arg_153_1.actors_["128404"]) then
				if arg_153_1.var_.actorSpriteComps128404 then
					for iter_156_0, iter_156_1 in pairs(arg_153_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 and not isNil(arg_153_1.actors_["128404"]) and arg_153_1.var_.actorSpriteComps128404 then
				for iter_156_2, iter_156_3 in pairs(arg_153_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_156_3 then
						iter_156_3.color = arg_153_1.isInRecall_ and (arg_153_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_153_1.var_.actorSpriteComps128404 = nil
			end

			local var_156_2 = 0
			local var_156_3 = 0.05

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_2 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, true)
				arg_153_1.iconController_:SetSelectedState("hero")

				arg_153_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_153_1.callingController_:SetSelectedState("normal")

				arg_153_1.keyicon_.color = Color.New(1, 1, 1)
				arg_153_1.icon_.color = Color.New(1, 1, 1)

				local var_156_4 = arg_153_1:GetWordFromCfg(926082036)
				local var_156_5 = arg_153_1:FormatText(var_156_4.content)

				arg_153_1.text_.text = var_156_5

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_7 = 2 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_5) / 2)

				if (2 <= 0 and var_156_3 or var_156_3 * (utf8.len(var_156_5) / 2)) > 0 and var_156_3 < var_156_7 then
					arg_153_1.talkMaxDuration = var_156_7

					if var_156_7 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_7 + var_156_2
					end
				end

				arg_153_1.text_.text = var_156_5
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082036", "story_v_out_926082.awb") ~= 0 then
					local var_156_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082036", "story_v_out_926082.awb") / 1000

					if var_156_8 + var_156_2 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_2
					end

					if var_156_4.prefab_name ~= "" and arg_153_1.actors_[var_156_4.prefab_name] ~= nil then
						local var_156_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_4.prefab_name].transform, "story_v_out_926082", "926082036", "story_v_out_926082.awb")

						arg_153_1:RecordAudio("926082036", var_156_9)
						arg_153_1:RecordAudio("926082036", var_156_9)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_926082", "926082036", "story_v_out_926082.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_926082", "926082036", "story_v_out_926082.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_10 = math.max(var_156_3, arg_153_1.talkMaxDuration)

			if var_156_2 <= arg_153_1.time_ and arg_153_1.time_ < var_156_2 + var_156_10 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_2) / var_156_10

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_2 + var_156_10 and arg_153_1.time_ < var_156_2 + var_156_10 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play926082037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 926082037
		arg_157_1.duration_ = 5.57

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play926082038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["128404"]) and arg_157_1.var_.actorSpriteComps128404 == nil then
				arg_157_1.var_.actorSpriteComps128404 = arg_157_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_160_0 = 0.2

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["128404"]) then
				if arg_157_1.var_.actorSpriteComps128404 then
					for iter_160_0, iter_160_1 in pairs(arg_157_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_160_1 then
							if arg_157_1.isInRecall_ then
								iter_160_1.color = Color.New(Mathf.Lerp(iter_160_1.color.r, arg_157_1.hightColor2.r, (arg_157_1.time_ - 0) / var_160_0), Mathf.Lerp(iter_160_1.color.g, arg_157_1.hightColor2.g, (arg_157_1.time_ - 0) / var_160_0), (Mathf.Lerp(iter_160_1.color.b, arg_157_1.hightColor2.b, (arg_157_1.time_ - 0) / var_160_0)))
							else
								local var_160_1 = Mathf.Lerp(iter_160_1.color.r, 0.5, (arg_157_1.time_ - 0) / var_160_0)

								iter_160_1.color = Color.New(var_160_1, var_160_1, var_160_1)
							end
						end
					end
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["128404"]) and arg_157_1.var_.actorSpriteComps128404 then
				for iter_160_2, iter_160_3 in pairs(arg_157_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_160_3 then
						iter_160_3.color = arg_157_1.isInRecall_ and (arg_157_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_157_1.var_.actorSpriteComps128404 = nil
			end

			local var_160_2 = arg_157_1.actors_["128404"].transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos128404 = var_160_2.localPosition
				var_160_2.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("128404", 7)

				for iter_160_4 = 0, var_160_2.childCount - 1 do
					local var_160_3 = var_160_2:GetChild(iter_160_4)

					if var_160_3.name == "" or not string.find(var_160_3.name, "split") then
						var_160_3.gameObject:SetActive(true)
					else
						var_160_3.gameObject:SetActive(false)
					end
				end
			end

			local var_160_4 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_4 then
				var_160_2.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_157_1.time_ - 0) / var_160_4)
			end

			if arg_157_1.time_ >= 0 + var_160_4 and arg_157_1.time_ < 0 + var_160_4 + arg_160_0 then
				var_160_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_160_5 = arg_157_1.actors_.story_item_22202.transform

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPosstory_item_22202 = var_160_5.localPosition
				var_160_5.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("story_item_22202", 3)
			end

			local var_160_6 = 0.625

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_6 then
				var_160_5.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPosstory_item_22202, Vector3.New(8.07, 12.38, 0), (arg_157_1.time_ - 0) / var_160_6)
			end

			if arg_157_1.time_ >= 0 + var_160_6 and arg_157_1.time_ < 0 + var_160_6 + arg_160_0 then
				var_160_5.localPosition = Vector3.New(8.07, 12.38, 0)
			end

			local var_160_7 = arg_157_1.actors_.story_item_22202.transform

			if 0.766666666666667 < arg_157_1.time_ and arg_157_1.time_ <= 0.766666666666667 + arg_160_0 then
				arg_157_1.var_.moveOldPosstory_item_22202 = var_160_7.localPosition
				var_160_7.localScale = Vector3.New(1, 1, 1)

				arg_157_1:CheckSpriteTmpPos("story_item_22202", 7)
			end

			local var_160_8 = 0.001

			if 0.766666666666667 <= arg_157_1.time_ and arg_157_1.time_ < 0.766666666666667 + var_160_8 then
				var_160_7.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPosstory_item_22202, Vector3.New(0, -2000, 0), (arg_157_1.time_ - 0.766666666666667) / var_160_8)
			end

			if arg_157_1.time_ >= 0.766666666666667 + var_160_8 and arg_157_1.time_ < 0.766666666666667 + var_160_8 + arg_160_0 then
				var_160_7.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_160_9 = 0

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_9 + arg_160_0 then
				arg_157_1.allBtn_.enabled = false
			end

			if arg_157_1.time_ >= var_160_9 + 0.625 and arg_157_1.time_ < var_160_9 + 0.625 + arg_160_0 then
				arg_157_1.allBtn_.enabled = true
			end

			if arg_157_1.frameCnt_ <= 1 then
				arg_157_1.dialog_:SetActive(false)
			end

			local var_160_10 = 0.566666666666667
			local var_160_11 = 0.625

			if 0.566666666666667 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				arg_157_1.dialog_:SetActive(true)

				arg_157_1.dialogCg_.alpha = 0

				local var_160_12 = LeanTween.value(arg_157_1.dialog_, 0, 1, 0.3)

				var_160_12:setOnUpdate(LuaHelper.FloatAction(function(arg_161_0)
					arg_157_1.dialogCg_.alpha = arg_161_0
				end))
				var_160_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_157_1.dialog_)
					var_160_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_157_1.duration_ = arg_157_1.duration_ + 0.3

				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_13 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(926082037).content)

				arg_157_1.text_.text = var_160_13

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_15 = 25 <= 0 and var_160_11 or var_160_11 * (utf8.len(var_160_13) / 25)

				if (25 <= 0 and var_160_11 or var_160_11 * (utf8.len(var_160_13) / 25)) > 0 and var_160_11 < var_160_15 then
					arg_157_1.talkMaxDuration = var_160_15
					var_160_10 = var_160_10 + 0.3

					if var_160_15 + var_160_10 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_15 + var_160_10
					end
				end

				arg_157_1.text_.text = var_160_13
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_16 = var_160_10 + 0.3
			local var_160_17 = math.max(var_160_11, arg_157_1.talkMaxDuration)

			if var_160_10 + 0.3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_16 + var_160_17 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_16) / var_160_17

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_16 + var_160_17 and arg_157_1.time_ < var_160_16 + var_160_17 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "TextureConfig/UIStoryImages/story_item_22202",
				needEase = true,
				actorName = "story_item_22202",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.625,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 0,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_OUT,
					startPos = Vector3.New(8.07, 14, 0),
					endPos = Vector3.New(8.07, 12.38, 0),
					easeType = LeanTweenType.easeInCirc
				}
			},
			{
				assetPath = "TextureConfig/UIStoryImages/story_item_22202",
				actorName = "story_item_22202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0.766666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play926082038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 926082038
		arg_163_1.duration_ = 4.5

		local var_163_0 = {
			zh = 4.5,
			ja = 3.866
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
				arg_163_0:Play926082039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["128404"]) and arg_163_1.var_.actorSpriteComps128404 == nil then
				arg_163_1.var_.actorSpriteComps128404 = arg_163_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_166_0 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["128404"]) then
				if arg_163_1.var_.actorSpriteComps128404 then
					for iter_166_0, iter_166_1 in pairs(arg_163_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_166_1 then
							if arg_163_1.isInRecall_ then
								iter_166_1.color = Color.New(Mathf.Lerp(iter_166_1.color.r, arg_163_1.hightColor1.r, (arg_163_1.time_ - 0) / var_166_0), Mathf.Lerp(iter_166_1.color.g, arg_163_1.hightColor1.g, (arg_163_1.time_ - 0) / var_166_0), (Mathf.Lerp(iter_166_1.color.b, arg_163_1.hightColor1.b, (arg_163_1.time_ - 0) / var_166_0)))
							else
								local var_166_1 = Mathf.Lerp(iter_166_1.color.r, 1, (arg_163_1.time_ - 0) / var_166_0)

								iter_166_1.color = Color.New(var_166_1, var_166_1, var_166_1)
							end
						end
					end
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["128404"]) and arg_163_1.var_.actorSpriteComps128404 then
				for iter_166_2, iter_166_3 in pairs(arg_163_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_166_3 then
						iter_166_3.color = arg_163_1.isInRecall_ and (arg_163_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_163_1.var_.actorSpriteComps128404 = nil
			end

			local var_166_2 = 0
			local var_166_3 = 0.2

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_128404_split_1")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_4 = arg_163_1:GetWordFromCfg(926082038)
				local var_166_5 = arg_163_1:FormatText(var_166_4.content)

				arg_163_1.text_.text = var_166_5

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_7 = 8 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 8)

				if (8 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 8)) > 0 and var_166_3 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_2
					end
				end

				arg_163_1.text_.text = var_166_5
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082038", "story_v_out_926082.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082038", "story_v_out_926082.awb") / 1000

					if var_166_8 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_2
					end

					if var_166_4.prefab_name ~= "" and arg_163_1.actors_[var_166_4.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_4.prefab_name].transform, "story_v_out_926082", "926082038", "story_v_out_926082.awb")

						arg_163_1:RecordAudio("926082038", var_166_9)
						arg_163_1:RecordAudio("926082038", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_926082", "926082038", "story_v_out_926082.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_926082", "926082038", "story_v_out_926082.awb")
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
	Play926082039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 926082039
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play926082040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["128404"]) and arg_167_1.var_.actorSpriteComps128404 == nil then
				arg_167_1.var_.actorSpriteComps128404 = arg_167_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_170_0 = 0.2

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["128404"]) then
				if arg_167_1.var_.actorSpriteComps128404 then
					for iter_170_0, iter_170_1 in pairs(arg_167_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["128404"]) and arg_167_1.var_.actorSpriteComps128404 then
				for iter_170_2, iter_170_3 in pairs(arg_167_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_170_3 then
						iter_170_3.color = arg_167_1.isInRecall_ and (arg_167_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_167_1.var_.actorSpriteComps128404 = nil
			end

			local var_170_2 = arg_167_1.actors_["128404"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos128404 = var_170_2.localPosition
				var_170_2.localScale = Vector3.New(1, 1, 1)

				arg_167_1:CheckSpriteTmpPos("128404", 7)

				for iter_170_4 = 0, var_170_2.childCount - 1 do
					local var_170_3 = var_170_2:GetChild(iter_170_4)

					if var_170_3.name == "" or not string.find(var_170_3.name, "split") then
						var_170_3.gameObject:SetActive(true)
					else
						var_170_3.gameObject:SetActive(false)
					end
				end
			end

			local var_170_4 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				var_170_2.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_167_1.time_ - 0) / var_170_4)
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				var_170_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_170_5 = 0
			local var_170_6 = 0.75

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_7 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(926082039).content)

				arg_167_1.text_.text = var_170_7

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_9 = 30 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_7) / 30)

				if (30 <= 0 and var_170_6 or var_170_6 * (utf8.len(var_170_7) / 30)) > 0 and var_170_6 < var_170_9 then
					arg_167_1.talkMaxDuration = var_170_9

					if var_170_9 + var_170_5 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_9 + var_170_5
					end
				end

				arg_167_1.text_.text = var_170_7
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_10 = math.max(var_170_6, arg_167_1.talkMaxDuration)

			if var_170_5 <= arg_167_1.time_ and arg_167_1.time_ < var_170_5 + var_170_10 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_5) / var_170_10

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_5 + var_170_10 and arg_167_1.time_ < var_170_5 + var_170_10 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play926082040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 926082040
		arg_171_1.duration_ = 4.4

		local var_171_0 = {
			zh = 3.4,
			ja = 4.4
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
				arg_171_0:Play926082041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["128404"]) and arg_171_1.var_.actorSpriteComps128404 == nil then
				arg_171_1.var_.actorSpriteComps128404 = arg_171_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_174_0 = 0.2

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["128404"]) then
				if arg_171_1.var_.actorSpriteComps128404 then
					for iter_174_0, iter_174_1 in pairs(arg_171_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_174_1 then
							if arg_171_1.isInRecall_ then
								iter_174_1.color = Color.New(Mathf.Lerp(iter_174_1.color.r, arg_171_1.hightColor1.r, (arg_171_1.time_ - 0) / var_174_0), Mathf.Lerp(iter_174_1.color.g, arg_171_1.hightColor1.g, (arg_171_1.time_ - 0) / var_174_0), (Mathf.Lerp(iter_174_1.color.b, arg_171_1.hightColor1.b, (arg_171_1.time_ - 0) / var_174_0)))
							else
								local var_174_1 = Mathf.Lerp(iter_174_1.color.r, 1, (arg_171_1.time_ - 0) / var_174_0)

								iter_174_1.color = Color.New(var_174_1, var_174_1, var_174_1)
							end
						end
					end
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["128404"]) and arg_171_1.var_.actorSpriteComps128404 then
				for iter_174_2, iter_174_3 in pairs(arg_171_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_174_3 then
						iter_174_3.color = arg_171_1.isInRecall_ and (arg_171_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_171_1.var_.actorSpriteComps128404 = nil
			end

			local var_174_2 = arg_171_1.actors_["128404"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos128404 = var_174_2.localPosition
				var_174_2.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("128404", 3)

				for iter_174_4 = 0, var_174_2.childCount - 1 do
					local var_174_3 = var_174_2:GetChild(iter_174_4)

					if var_174_3.name == "split_5" or not string.find(var_174_3.name, "split") then
						var_174_3.gameObject:SetActive(true)
					else
						var_174_3.gameObject:SetActive(false)
					end
				end
			end

			local var_174_4 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				var_174_2.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_171_1.time_ - 0) / var_174_4)
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				var_174_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_174_5 = 0
			local var_174_6 = 0.3

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_5 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_7 = arg_171_1:GetWordFromCfg(926082040)
				local var_174_8 = arg_171_1:FormatText(var_174_7.content)

				arg_171_1.text_.text = var_174_8

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_10 = 12 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 12)

				if (12 <= 0 and var_174_6 or var_174_6 * (utf8.len(var_174_8) / 12)) > 0 and var_174_6 < var_174_10 then
					arg_171_1.talkMaxDuration = var_174_10

					if var_174_10 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_5
					end
				end

				arg_171_1.text_.text = var_174_8
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082040", "story_v_out_926082.awb") ~= 0 then
					local var_174_11 = manager.audio:GetVoiceLength("story_v_out_926082", "926082040", "story_v_out_926082.awb") / 1000

					if var_174_11 + var_174_5 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_11 + var_174_5
					end

					if var_174_7.prefab_name ~= "" and arg_171_1.actors_[var_174_7.prefab_name] ~= nil then
						local var_174_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_7.prefab_name].transform, "story_v_out_926082", "926082040", "story_v_out_926082.awb")

						arg_171_1:RecordAudio("926082040", var_174_12)
						arg_171_1:RecordAudio("926082040", var_174_12)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_926082", "926082040", "story_v_out_926082.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_926082", "926082040", "story_v_out_926082.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_13 = math.max(var_174_6, arg_171_1.talkMaxDuration)

			if var_174_5 <= arg_171_1.time_ and arg_171_1.time_ < var_174_5 + var_174_13 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_5) / var_174_13

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_5 + var_174_13 and arg_171_1.time_ < var_174_5 + var_174_13 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play926082041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 926082041
		arg_175_1.duration_ = 7.27

		local var_175_0 = {
			zh = 4.3,
			ja = 7.266
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
				arg_175_0:Play926082042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.475

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:GetWordFromCfg(926082041)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 19 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 19)

				if (19 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 19)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082041", "story_v_out_926082.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_926082", "926082041", "story_v_out_926082.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_926082", "926082041", "story_v_out_926082.awb")

						arg_175_1:RecordAudio("926082041", var_178_6)
						arg_175_1:RecordAudio("926082041", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_926082", "926082041", "story_v_out_926082.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_926082", "926082041", "story_v_out_926082.awb")
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
	Play926082042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 926082042
		arg_179_1.duration_ = 8.1

		local var_179_0 = {
			zh = 7.6,
			ja = 8.1
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
				arg_179_0:Play926082043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos128404 = arg_179_1.actors_["128404"].transform.localPosition
				arg_179_1.actors_["128404"].transform.localScale = Vector3.New(1, 1, 1)

				arg_179_1:CheckSpriteTmpPos("128404", 3)

				for iter_182_0 = 0, arg_179_1.actors_["128404"].transform.childCount - 1 do
					local var_182_0 = arg_179_1.actors_["128404"].transform:GetChild(iter_182_0)

					if var_182_0.name == "split_5" or not string.find(var_182_0.name, "split") then
						var_182_0.gameObject:SetActive(true)
					else
						var_182_0.gameObject:SetActive(false)
					end
				end
			end

			local var_182_1 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_1 then
				arg_179_1.actors_["128404"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_179_1.time_ - 0) / var_182_1)
			end

			if arg_179_1.time_ >= 0 + var_182_1 and arg_179_1.time_ < 0 + var_182_1 + arg_182_0 then
				arg_179_1.actors_["128404"].transform.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_182_2 = 0
			local var_182_3 = 0.625

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_4 = arg_179_1:GetWordFromCfg(926082042)
				local var_182_5 = arg_179_1:FormatText(var_182_4.content)

				arg_179_1.text_.text = var_182_5

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 25 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 25)

				if (25 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_5) / 25)) > 0 and var_182_3 < var_182_7 then
					arg_179_1.talkMaxDuration = var_182_7

					if var_182_7 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_7 + var_182_2
					end
				end

				arg_179_1.text_.text = var_182_5
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082042", "story_v_out_926082.awb") ~= 0 then
					local var_182_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082042", "story_v_out_926082.awb") / 1000

					if var_182_8 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_8 + var_182_2
					end

					if var_182_4.prefab_name ~= "" and arg_179_1.actors_[var_182_4.prefab_name] ~= nil then
						local var_182_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_4.prefab_name].transform, "story_v_out_926082", "926082042", "story_v_out_926082.awb")

						arg_179_1:RecordAudio("926082042", var_182_9)
						arg_179_1:RecordAudio("926082042", var_182_9)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_926082", "926082042", "story_v_out_926082.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_926082", "926082042", "story_v_out_926082.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_3, arg_179_1.talkMaxDuration)

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_2) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_2 + var_182_10 and arg_179_1.time_ < var_182_2 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play926082043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 926082043
		arg_183_1.duration_ = 7.87

		local var_183_0 = {
			zh = 5.966,
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
				arg_183_0:Play926082044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0.65

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_1 = arg_183_1:GetWordFromCfg(926082043)
				local var_186_2 = arg_183_1:FormatText(var_186_1.content)

				arg_183_1.text_.text = var_186_2

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_4 = 26 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 26)

				if (26 <= 0 and var_186_0 or var_186_0 * (utf8.len(var_186_2) / 26)) > 0 and var_186_0 < var_186_4 then
					arg_183_1.talkMaxDuration = var_186_4

					if var_186_4 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_4 + 0
					end
				end

				arg_183_1.text_.text = var_186_2
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082043", "story_v_out_926082.awb") ~= 0 then
					local var_186_5 = manager.audio:GetVoiceLength("story_v_out_926082", "926082043", "story_v_out_926082.awb") / 1000

					if var_186_5 + 0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + 0
					end

					if var_186_1.prefab_name ~= "" and arg_183_1.actors_[var_186_1.prefab_name] ~= nil then
						local var_186_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_1.prefab_name].transform, "story_v_out_926082", "926082043", "story_v_out_926082.awb")

						arg_183_1:RecordAudio("926082043", var_186_6)
						arg_183_1:RecordAudio("926082043", var_186_6)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_926082", "926082043", "story_v_out_926082.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_926082", "926082043", "story_v_out_926082.awb")
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
	Play926082044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 926082044
		arg_187_1.duration_ = 6.3

		local var_187_0 = {
			zh = 6.266,
			ja = 6.3
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
				arg_187_0:Play926082045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.675

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:GetWordFromCfg(926082044)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 27 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 27)

				if (27 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 27)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082044", "story_v_out_926082.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_926082", "926082044", "story_v_out_926082.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_926082", "926082044", "story_v_out_926082.awb")

						arg_187_1:RecordAudio("926082044", var_190_6)
						arg_187_1:RecordAudio("926082044", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_926082", "926082044", "story_v_out_926082.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_926082", "926082044", "story_v_out_926082.awb")
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
	Play926082045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 926082045
		arg_191_1.duration_ = 7.73

		local var_191_0 = {
			zh = 5.6,
			ja = 7.733
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
				arg_191_0:Play926082046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos128404 = arg_191_1.actors_["128404"].transform.localPosition
				arg_191_1.actors_["128404"].transform.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("128404", 3)

				for iter_194_0 = 0, arg_191_1.actors_["128404"].transform.childCount - 1 do
					local var_194_0 = arg_191_1.actors_["128404"].transform:GetChild(iter_194_0)

					if var_194_0.name == "split_4" or not string.find(var_194_0.name, "split") then
						var_194_0.gameObject:SetActive(true)
					else
						var_194_0.gameObject:SetActive(false)
					end
				end
			end

			local var_194_1 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_1 then
				arg_191_1.actors_["128404"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_191_1.time_ - 0) / var_194_1)
			end

			if arg_191_1.time_ >= 0 + var_194_1 and arg_191_1.time_ < 0 + var_194_1 + arg_194_0 then
				arg_191_1.actors_["128404"].transform.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_194_2 = 0
			local var_194_3 = 0.475

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_2 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_4 = arg_191_1:GetWordFromCfg(926082045)
				local var_194_5 = arg_191_1:FormatText(var_194_4.content)

				arg_191_1.text_.text = var_194_5

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_7 = 19 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 19)

				if (19 <= 0 and var_194_3 or var_194_3 * (utf8.len(var_194_5) / 19)) > 0 and var_194_3 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_2
					end
				end

				arg_191_1.text_.text = var_194_5
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082045", "story_v_out_926082.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082045", "story_v_out_926082.awb") / 1000

					if var_194_8 + var_194_2 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_2
					end

					if var_194_4.prefab_name ~= "" and arg_191_1.actors_[var_194_4.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_4.prefab_name].transform, "story_v_out_926082", "926082045", "story_v_out_926082.awb")

						arg_191_1:RecordAudio("926082045", var_194_9)
						arg_191_1:RecordAudio("926082045", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_926082", "926082045", "story_v_out_926082.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_926082", "926082045", "story_v_out_926082.awb")
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
				actorName = "128404",
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
	Play926082046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 926082046
		arg_195_1.duration_ = 1.97

		local var_195_0 = {
			zh = 1.966,
			ja = 1.666
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
				arg_195_0:Play926082047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["10144"]) and arg_195_1.var_.actorSpriteComps10144 == nil then
				arg_195_1.var_.actorSpriteComps10144 = arg_195_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_0 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["10144"]) then
				if arg_195_1.var_.actorSpriteComps10144 then
					for iter_198_0, iter_198_1 in pairs(arg_195_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["10144"]) and arg_195_1.var_.actorSpriteComps10144 then
				for iter_198_2, iter_198_3 in pairs(arg_195_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_198_3 then
						iter_198_3.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_195_1.var_.actorSpriteComps10144 = nil
			end

			local var_198_2 = arg_195_1.actors_["128404"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps128404 == nil then
				arg_195_1.var_.actorSpriteComps128404 = var_198_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_3 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_3 and not isNil(var_198_2) then
				if arg_195_1.var_.actorSpriteComps128404 then
					for iter_198_4, iter_198_5 in pairs(arg_195_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_195_1.time_ >= 0 + var_198_3 and arg_195_1.time_ < 0 + var_198_3 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps128404 then
				for iter_198_6, iter_198_7 in pairs(arg_195_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_198_7 then
						iter_198_7.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_195_1.var_.actorSpriteComps128404 = nil
			end

			local var_198_5 = arg_195_1.actors_["128404"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos128404 = var_198_5.localPosition
				var_198_5.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("128404", 7)

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
				var_198_5.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_195_1.time_ - 0) / var_198_7)
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				var_198_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_8 = arg_195_1.actors_["10144"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10144 = var_198_8.localPosition
				var_198_8.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10144", 3)

				for iter_198_9 = 0, var_198_8.childCount - 1 do
					local var_198_9 = var_198_8:GetChild(iter_198_9)

					if var_198_9.name == "split_5" or not string.find(var_198_9.name, "split") then
						var_198_9.gameObject:SetActive(true)
					else
						var_198_9.gameObject:SetActive(false)
					end
				end
			end

			local var_198_10 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_10 then
				var_198_8.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_195_1.time_ - 0) / var_198_10)
			end

			if arg_195_1.time_ >= 0 + var_198_10 and arg_195_1.time_ < 0 + var_198_10 + arg_198_0 then
				var_198_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_198_11 = 0
			local var_198_12 = 0.15

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_11 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_13 = arg_195_1:GetWordFromCfg(926082046)
				local var_198_14 = arg_195_1:FormatText(var_198_13.content)

				arg_195_1.text_.text = var_198_14

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_16 = 6 <= 0 and var_198_12 or var_198_12 * (utf8.len(var_198_14) / 6)

				if (6 <= 0 and var_198_12 or var_198_12 * (utf8.len(var_198_14) / 6)) > 0 and var_198_12 < var_198_16 then
					arg_195_1.talkMaxDuration = var_198_16

					if var_198_16 + var_198_11 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_16 + var_198_11
					end
				end

				arg_195_1.text_.text = var_198_14
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082046", "story_v_out_926082.awb") ~= 0 then
					local var_198_17 = manager.audio:GetVoiceLength("story_v_out_926082", "926082046", "story_v_out_926082.awb") / 1000

					if var_198_17 + var_198_11 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_17 + var_198_11
					end

					if var_198_13.prefab_name ~= "" and arg_195_1.actors_[var_198_13.prefab_name] ~= nil then
						local var_198_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_13.prefab_name].transform, "story_v_out_926082", "926082046", "story_v_out_926082.awb")

						arg_195_1:RecordAudio("926082046", var_198_18)
						arg_195_1:RecordAudio("926082046", var_198_18)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_926082", "926082046", "story_v_out_926082.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_926082", "926082046", "story_v_out_926082.awb")
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
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
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
	Play926082047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 926082047
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play926082048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["10144"]) and arg_199_1.var_.actorSpriteComps10144 == nil then
				arg_199_1.var_.actorSpriteComps10144 = arg_199_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_202_0 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["10144"]) then
				if arg_199_1.var_.actorSpriteComps10144 then
					for iter_202_0, iter_202_1 in pairs(arg_199_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_202_1 then
							if arg_199_1.isInRecall_ then
								iter_202_1.color = Color.New(Mathf.Lerp(iter_202_1.color.r, arg_199_1.hightColor2.r, (arg_199_1.time_ - 0) / var_202_0), Mathf.Lerp(iter_202_1.color.g, arg_199_1.hightColor2.g, (arg_199_1.time_ - 0) / var_202_0), (Mathf.Lerp(iter_202_1.color.b, arg_199_1.hightColor2.b, (arg_199_1.time_ - 0) / var_202_0)))
							else
								local var_202_1 = Mathf.Lerp(iter_202_1.color.r, 0.5, (arg_199_1.time_ - 0) / var_202_0)

								iter_202_1.color = Color.New(var_202_1, var_202_1, var_202_1)
							end
						end
					end
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["10144"]) and arg_199_1.var_.actorSpriteComps10144 then
				for iter_202_2, iter_202_3 in pairs(arg_199_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_202_3 then
						iter_202_3.color = arg_199_1.isInRecall_ and (arg_199_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_199_1.var_.actorSpriteComps10144 = nil
			end

			local var_202_2 = 0
			local var_202_3 = 0.3

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_2 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_4 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(926082047).content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_6 = 12 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_4) / 12)

				if (12 <= 0 and var_202_3 or var_202_3 * (utf8.len(var_202_4) / 12)) > 0 and var_202_3 < var_202_6 then
					arg_199_1.talkMaxDuration = var_202_6

					if var_202_6 + var_202_2 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_6 + var_202_2
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_3, arg_199_1.talkMaxDuration)

			if var_202_2 <= arg_199_1.time_ and arg_199_1.time_ < var_202_2 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_2) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_2 + var_202_7 and arg_199_1.time_ < var_202_2 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play926082048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 926082048
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play926082049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos10144 = arg_203_1.actors_["10144"].transform.localPosition
				arg_203_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_203_1:CheckSpriteTmpPos("10144", 7)

				for iter_206_0 = 0, arg_203_1.actors_["10144"].transform.childCount - 1 do
					local var_206_0 = arg_203_1.actors_["10144"].transform:GetChild(iter_206_0)

					if var_206_0.name == "" or not string.find(var_206_0.name, "split") then
						var_206_0.gameObject:SetActive(true)
					else
						var_206_0.gameObject:SetActive(false)
					end
				end
			end

			local var_206_1 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_1 then
				arg_203_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_203_1.time_ - 0) / var_206_1)
			end

			if arg_203_1.time_ >= 0 + var_206_1 and arg_203_1.time_ < 0 + var_206_1 + arg_206_0 then
				arg_203_1.actors_["10144"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_206_2 = 0
			local var_206_3 = 0.725

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_4 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(926082048).content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_6 = 29 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_4) / 29)

				if (29 <= 0 and var_206_3 or var_206_3 * (utf8.len(var_206_4) / 29)) > 0 and var_206_3 < var_206_6 then
					arg_203_1.talkMaxDuration = var_206_6

					if var_206_6 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_6 + var_206_2
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_3, arg_203_1.talkMaxDuration)

			if var_206_2 <= arg_203_1.time_ and arg_203_1.time_ < var_206_2 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_2) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_2 + var_206_7 and arg_203_1.time_ < var_206_2 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	Play926082049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 926082049
		arg_207_1.duration_ = 30.15

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play926082050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if arg_207_1.bgs_.STwhite == nil then
				local var_210_0 = Object.Instantiate(arg_207_1.paintGo_)

				var_210_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_210_0.name = "STwhite"
				var_210_0.transform.parent = arg_207_1.stage_.transform
				var_210_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_207_1.bgs_.STwhite = var_210_0
			end

			if 2.23333333333333 < arg_207_1.time_ and arg_207_1.time_ <= 2.23333333333333 + arg_210_0 then
				local var_210_1 = arg_207_1.bgs_.STwhite

				arg_207_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_210_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_2 = var_210_1:GetComponent("SpriteRenderer")

				if var_210_2 and var_210_2.sprite then
					local var_210_3 = 2 * (var_210_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_210_1.transform.localScale = Vector3.New(var_210_3 / var_210_2.sprite.bounds.size.y < var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x and var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x or var_210_3 / var_210_2.sprite.bounds.size.y, var_210_3 / var_210_2.sprite.bounds.size.y < var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x and var_210_3 * manager.ui.mainCameraCom_.aspect / var_210_2.sprite.bounds.size.x or var_210_3 / var_210_2.sprite.bounds.size.y, 0)
				end

				for iter_210_0, iter_210_1 in pairs(arg_207_1.bgs_) do
					if iter_210_0 ~= "STwhite" then
						iter_210_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 18.1666666666667 < arg_207_1.time_ and arg_207_1.time_ <= 18.1666666666667 + arg_210_0 then
				local var_210_4 = arg_207_1.bgs_.STwhite

				arg_207_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_210_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_5 = var_210_4:GetComponent("SpriteRenderer")

				if var_210_5 and var_210_5.sprite then
					local var_210_6 = 2 * (var_210_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_210_4.transform.localScale = Vector3.New(var_210_6 / var_210_5.sprite.bounds.size.y < var_210_6 * manager.ui.mainCameraCom_.aspect / var_210_5.sprite.bounds.size.x and var_210_6 * manager.ui.mainCameraCom_.aspect / var_210_5.sprite.bounds.size.x or var_210_6 / var_210_5.sprite.bounds.size.y, var_210_6 / var_210_5.sprite.bounds.size.y < var_210_6 * manager.ui.mainCameraCom_.aspect / var_210_5.sprite.bounds.size.x and var_210_6 * manager.ui.mainCameraCom_.aspect / var_210_5.sprite.bounds.size.x or var_210_6 / var_210_5.sprite.bounds.size.y, 0)
				end

				for iter_210_2, iter_210_3 in pairs(arg_207_1.bgs_) do
					if iter_210_2 ~= "STwhite" then
						iter_210_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_210_7 = 16.1666666666667

			if 16.1666666666667 < arg_207_1.time_ and arg_207_1.time_ <= var_210_7 + arg_210_0 then
				arg_207_1.allBtn_.enabled = false
			end

			if arg_207_1.time_ >= var_210_7 + 0.3 and arg_207_1.time_ < var_210_7 + 0.3 + arg_210_0 then
				arg_207_1.allBtn_.enabled = true
			end

			local var_210_8 = 0

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_9 = 2.23333333333333

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_9 then
				local var_210_10 = Color.New(0, 0, 0)

				var_210_10.a = Mathf.Lerp(0, 1, (arg_207_1.time_ - var_210_8) / var_210_9)
				arg_207_1.mask_.color = var_210_10
			end

			if arg_207_1.time_ >= var_210_8 + var_210_9 and arg_207_1.time_ < var_210_8 + var_210_9 + arg_210_0 then
				local var_210_11 = Color.New(0, 0, 0)

				var_210_11.a = 1
				arg_207_1.mask_.color = var_210_11
			end

			local var_210_12 = 2.23333333333333

			if 2.23333333333333 < arg_207_1.time_ and arg_207_1.time_ <= var_210_12 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_13 = 1.33333333333333

			if var_210_12 <= arg_207_1.time_ and arg_207_1.time_ < var_210_12 + var_210_13 then
				local var_210_14 = Color.New(0, 0, 0)

				var_210_14.a = Mathf.Lerp(1, 0, (arg_207_1.time_ - var_210_12) / var_210_13)
				arg_207_1.mask_.color = var_210_14
			end

			if arg_207_1.time_ >= var_210_12 + var_210_13 and arg_207_1.time_ < var_210_12 + var_210_13 + arg_210_0 then
				local var_210_15 = Color.New(0, 0, 0)

				arg_207_1.mask_.enabled = false
				var_210_15.a = 0
				arg_207_1.mask_.color = var_210_15
			end

			local var_210_16 = 17.4

			if 17.4 < arg_207_1.time_ and arg_207_1.time_ <= var_210_16 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_17 = 1.03333333333333

			if var_210_16 <= arg_207_1.time_ and arg_207_1.time_ < var_210_16 + var_210_17 then
				local var_210_18 = Color.New(0, 0, 0)

				var_210_18.a = Mathf.Lerp(0, 1, (arg_207_1.time_ - var_210_16) / var_210_17)
				arg_207_1.mask_.color = var_210_18
			end

			if arg_207_1.time_ >= var_210_16 + var_210_17 and arg_207_1.time_ < var_210_16 + var_210_17 + arg_210_0 then
				local var_210_19 = Color.New(0, 0, 0)

				var_210_19.a = 1
				arg_207_1.mask_.color = var_210_19
			end

			local var_210_20 = 18.4333333333333

			if 18.4333333333333 < arg_207_1.time_ and arg_207_1.time_ <= var_210_20 + arg_210_0 then
				arg_207_1.mask_.enabled = true
				arg_207_1.mask_.raycastTarget = true

				arg_207_1:SetGaussion(false)
			end

			local var_210_21 = 1.4

			if var_210_20 <= arg_207_1.time_ and arg_207_1.time_ < var_210_20 + var_210_21 then
				local var_210_22 = Color.New(0, 0, 0)

				var_210_22.a = Mathf.Lerp(1, 0, (arg_207_1.time_ - var_210_20) / var_210_21)
				arg_207_1.mask_.color = var_210_22
			end

			if arg_207_1.time_ >= var_210_20 + var_210_21 and arg_207_1.time_ < var_210_20 + var_210_21 + arg_210_0 then
				local var_210_23 = Color.New(0, 0, 0)

				arg_207_1.mask_.enabled = false
				var_210_23.a = 0
				arg_207_1.mask_.color = var_210_23
			end

			if 18.1666666666667 < arg_207_1.time_ and arg_207_1.time_ <= 18.1666666666667 + arg_210_0 then
				local var_210_24 = arg_207_1.fswbg_.transform:Find("textbox/adapt/content") or arg_207_1.fswbg_.transform:Find("textbox/content")
				local var_210_25 = arg_207_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_210_26 = var_210_24:GetComponent("RectTransform")

				var_210_24:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_210_26.offsetMin = Vector2.New(0, 0)
				var_210_26.offsetMax = Vector2.New(0, 0)
			end

			if 18.4 < arg_207_1.time_ and arg_207_1.time_ <= 18.4 + arg_210_0 then
				arg_207_1.fswbg_:SetActive(true)
				arg_207_1.dialog_:SetActive(false)

				arg_207_1.fswtw_.percent = 0
				arg_207_1.fswt_.text = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(926082049).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.fswt_)

				arg_207_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_207_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_207_1.fswtw_:SetDirty()

				arg_207_1.typewritterCharCountI18N = 0

				SetActive(arg_207_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_207_1:ShowNextGo(false)
			end

			local var_210_27 = 20.8166666666667

			if 20.8166666666667 < arg_207_1.time_ and arg_207_1.time_ <= var_210_27 + arg_210_0 then
				arg_207_1.var_.oldValueTypewriter = arg_207_1.fswtw_.percent
				arg_207_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				SetActive(arg_207_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_207_1:ShowNextGo(false)
			end

			local var_210_28 = 42
			local var_210_29 = 2.8
			local var_210_30, var_210_31 = arg_207_1:GetPercentByPara(arg_207_1:FormatText(arg_207_1:GetWordFromCfg(926082049).content), 1)

			if var_210_27 < arg_207_1.time_ and arg_207_1.time_ <= var_210_27 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0

				local var_210_32 = var_210_28 <= 0 and var_210_29 or var_210_29 * ((var_210_31 - arg_207_1.typewritterCharCountI18N) / var_210_28)

				if (var_210_28 <= 0 and var_210_29 or var_210_29 * ((var_210_31 - arg_207_1.typewritterCharCountI18N) / var_210_28)) > 0 and var_210_29 < var_210_32 then
					arg_207_1.talkMaxDuration = var_210_32

					if var_210_32 + var_210_27 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_32 + var_210_27
					end
				end
			end

			local var_210_33 = math.max(2.8, arg_207_1.talkMaxDuration)

			if var_210_27 <= arg_207_1.time_ and arg_207_1.time_ < var_210_27 + var_210_33 then
				arg_207_1.fswtw_.percent = Mathf.Lerp(arg_207_1.var_.oldValueTypewriter, var_210_30, (arg_207_1.time_ - var_210_27) / var_210_33)
				arg_207_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_207_1.fswtw_:SetDirty()
			end

			if arg_207_1.time_ >= var_210_27 + var_210_33 and arg_207_1.time_ < var_210_27 + var_210_33 + arg_210_0 then
				arg_207_1.fswtw_.percent = var_210_30

				arg_207_1.fswtw_:SetDirty()
				arg_207_1:ShowNextGo(true)

				arg_207_1.typewritterCharCountI18N = var_210_31
			end

			if 18.45 < arg_207_1.time_ and arg_207_1.time_ <= 18.45 + arg_210_0 then
				arg_207_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_210_36 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_207_1.bgmTxt_.text ~= var_210_36 and arg_207_1.bgmTxt_.text ~= "" then
						if arg_207_1.bgmTxt2_.text ~= "" then
							arg_207_1.bgmTxt_.text = arg_207_1.bgmTxt2_.text
						end

						arg_207_1.bgmTxt2_.text = var_210_36

						arg_207_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_207_1.bgmTxt_.text = var_210_36
						arg_207_1.bgmTxt2_.text = var_210_36
					end

					if arg_207_1.bgmTimer then
						arg_207_1.bgmTimer:Stop()

						arg_207_1.bgmTimer = nil
					end

					if arg_207_1.settingData.show_music_name == 1 then
						arg_207_1.musicController:SetSelectedState("show")
						arg_207_1.musicAnimator_:Play("open", 0, 0)

						if arg_207_1.settingData.music_time ~= 0 then
							arg_207_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_207_1.settingData.music_time), function()
								if arg_207_1 == nil or isNil(arg_207_1.bgmTxt_) then
									return
								end

								arg_207_1.musicController:SetSelectedState("hide")
								arg_207_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 19.8166666666667 < arg_207_1.time_ and arg_207_1.time_ <= 19.8166666666667 + arg_210_0 then
				arg_207_1:AudioAction("play", "music", "bgm_side_daily10", "bgm_side_daily10", "bgm_side_daily10.awb")

				local var_210_39 = manager.audio:GetAudioName("bgm_side_daily10", "bgm_side_daily10")

				if "" ~= "" then
					if arg_207_1.bgmTxt_.text ~= var_210_39 and arg_207_1.bgmTxt_.text ~= "" then
						if arg_207_1.bgmTxt2_.text ~= "" then
							arg_207_1.bgmTxt_.text = arg_207_1.bgmTxt2_.text
						end

						arg_207_1.bgmTxt2_.text = var_210_39

						arg_207_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_207_1.bgmTxt_.text = var_210_39
						arg_207_1.bgmTxt2_.text = var_210_39
					end

					if arg_207_1.bgmTimer then
						arg_207_1.bgmTimer:Stop()

						arg_207_1.bgmTimer = nil
					end

					if arg_207_1.settingData.show_music_name == 1 then
						arg_207_1.musicController:SetSelectedState("show")
						arg_207_1.musicAnimator_:Play("open", 0, 0)

						if arg_207_1.settingData.music_time ~= 0 then
							arg_207_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_207_1.settingData.music_time), function()
								if arg_207_1 == nil or isNil(arg_207_1.bgmTxt_) then
									return
								end

								arg_207_1.musicController:SetSelectedState("hide")
								arg_207_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 18.9166666666667 < arg_207_1.time_ and arg_207_1.time_ <= 18.9166666666667 + arg_210_0 then
				arg_207_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			local var_210_41 = 20.8166666666667
			local var_210_42 = manager.audio:GetVoiceLength("story_v_out_926082", "926082049", "0") / 1000

			if var_210_42 > 0 and 9.333 < var_210_42 and var_210_42 + var_210_41 > arg_207_1.duration_ then
				arg_207_1.duration_ = var_210_42 + var_210_41
			end

			if var_210_41 < arg_207_1.time_ and arg_207_1.time_ <= var_210_41 + arg_210_0 then
				arg_207_1:AudioAction("play", "voice", "story_v_out_926082", "926082049", "0")
			end

			local var_210_44 = 2.23333333333333

			if 2.23333333333333 < arg_207_1.time_ and arg_207_1.time_ <= var_210_44 + arg_210_0 then
				SetActive(arg_207_1.dialog_, false)
				SetActive(arg_207_1.allBtn_.gameObject, false)
				arg_207_1.hideBtnsController_:SetSelectedIndex(1)
				arg_207_1:StopAllVoice()

				arg_207_1.marker = "12334"

				manager.video:Play("SofdecAsset/activity/activity_4_3_08_402501_start.usm", function(arg_213_0)
					arg_207_1.time_ = var_210_44 + 16.1566666668902

					if arg_207_1.state_ == "pause" then
						arg_207_1.state_ = "playing"
					end

					manager.video:Dispose()
				end, nil, nil, function(arg_214_0)
					arg_207_1.state_ = arg_214_0 and "pause" or "playing"
				end)
				manager.video.transform_:SetSiblingIndex(1)
			end

			local var_210_45 = 16.1666666666667

			if var_210_44 <= arg_207_1.time_ and arg_207_1.time_ < var_210_44 + var_210_45 then
				-- block empty
			end

			if arg_207_1.time_ >= var_210_44 + var_210_45 and arg_207_1.time_ < var_210_44 + var_210_45 + arg_210_0 then
				arg_207_1.marker = ""
			end

			local var_210_46 = 18.4

			if 18.4 < arg_207_1.time_ and arg_207_1.time_ <= var_210_46 + arg_210_0 then
				SetActive(arg_207_1.dialog_, false)
				SetActive(arg_207_1.allBtn_.gameObject, true)
				arg_207_1.hideBtnsController_:SetSelectedIndex(0)
				manager.video:Dispose()

				arg_207_1.isInLoopVideo = false
			end

			local var_210_47 = 0.0333333333333314

			if var_210_46 <= arg_207_1.time_ and arg_207_1.time_ < var_210_46 + var_210_47 then
				-- block empty
			end

			if arg_207_1.time_ >= var_210_46 + var_210_47 and arg_207_1.time_ < var_210_46 + var_210_47 + arg_210_0 then
				arg_207_1.marker = ""
			end

			if 2.23333333333333 < arg_207_1.time_ and arg_207_1.time_ <= 2.23333333333333 + arg_210_0 then
				arg_207_1.fswbg_:SetActive(true)
				arg_207_1.dialog_:SetActive(false)

				arg_207_1.fswtw_.percent = 0
				arg_207_1.fswt_.text = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(102).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.fswt_)

				arg_207_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_207_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_207_1.fswtw_:SetDirty()

				arg_207_1.typewritterCharCountI18N = 0

				SetActive(arg_207_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_207_1:ShowNextGo(false)
			end

			if 18.4 < arg_207_1.time_ and arg_207_1.time_ <= 18.4 + arg_210_0 then
				local var_210_48 = arg_207_1.fswbg_.transform:Find("textbox/adapt/content") or arg_207_1.fswbg_.transform:Find("textbox/content")
				local var_210_49 = arg_207_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_210_50 = var_210_48:GetComponent("RectTransform")

				var_210_48:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_210_50.offsetMin = Vector2.New(0, 0)
				var_210_50.offsetMax = Vector2.New(0, 0)
			end

			if 2.23333333333333 < arg_207_1.time_ and arg_207_1.time_ <= 2.23333333333333 + arg_210_0 then
				local var_210_51 = arg_207_1.bgs_.STwhite

				arg_207_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_210_51.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_52 = var_210_51:GetComponent("SpriteRenderer")

				if var_210_52 and var_210_52.sprite then
					local var_210_53 = 2 * (var_210_51.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_210_51.transform.localScale = Vector3.New(var_210_53 / var_210_52.sprite.bounds.size.y < var_210_53 * manager.ui.mainCameraCom_.aspect / var_210_52.sprite.bounds.size.x and var_210_53 * manager.ui.mainCameraCom_.aspect / var_210_52.sprite.bounds.size.x or var_210_53 / var_210_52.sprite.bounds.size.y, var_210_53 / var_210_52.sprite.bounds.size.y < var_210_53 * manager.ui.mainCameraCom_.aspect / var_210_52.sprite.bounds.size.x and var_210_53 * manager.ui.mainCameraCom_.aspect / var_210_52.sprite.bounds.size.x or var_210_53 / var_210_52.sprite.bounds.size.y, 0)
				end

				for iter_210_4, iter_210_5 in pairs(arg_207_1.bgs_) do
					if iter_210_4 ~= "STwhite" then
						iter_210_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 18.5 < arg_207_1.time_ and arg_207_1.time_ <= 18.5 + arg_210_0 then
				local var_210_54 = arg_207_1.bgs_.STwhite

				arg_207_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_210_54.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_210_55 = var_210_54:GetComponent("SpriteRenderer")

				if var_210_55 and var_210_55.sprite then
					local var_210_56 = 2 * (var_210_54.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_210_54.transform.localScale = Vector3.New(var_210_56 / var_210_55.sprite.bounds.size.y < var_210_56 * manager.ui.mainCameraCom_.aspect / var_210_55.sprite.bounds.size.x and var_210_56 * manager.ui.mainCameraCom_.aspect / var_210_55.sprite.bounds.size.x or var_210_56 / var_210_55.sprite.bounds.size.y, var_210_56 / var_210_55.sprite.bounds.size.y < var_210_56 * manager.ui.mainCameraCom_.aspect / var_210_55.sprite.bounds.size.x and var_210_56 * manager.ui.mainCameraCom_.aspect / var_210_55.sprite.bounds.size.x or var_210_56 / var_210_55.sprite.bounds.size.y, 0)
				end

				for iter_210_6, iter_210_7 in pairs(arg_207_1.bgs_) do
					if iter_210_6 ~= "STwhite" then
						iter_210_7.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play926082050 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 926082050
		arg_215_1.duration_ = 8.6

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play926082051(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0.0166666666666667 < arg_215_1.time_ and arg_215_1.time_ <= 0.0166666666666667 + arg_218_0 then
				local var_218_0 = arg_215_1.bgs_.STwhite

				arg_215_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_218_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_1 = var_218_0:GetComponent("SpriteRenderer")

				if var_218_1 and var_218_1.sprite then
					local var_218_2 = 2 * (var_218_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_218_0.transform.localScale = Vector3.New(var_218_2 / var_218_1.sprite.bounds.size.y < var_218_2 * manager.ui.mainCameraCom_.aspect / var_218_1.sprite.bounds.size.x and var_218_2 * manager.ui.mainCameraCom_.aspect / var_218_1.sprite.bounds.size.x or var_218_2 / var_218_1.sprite.bounds.size.y, var_218_2 / var_218_1.sprite.bounds.size.y < var_218_2 * manager.ui.mainCameraCom_.aspect / var_218_1.sprite.bounds.size.x and var_218_2 * manager.ui.mainCameraCom_.aspect / var_218_1.sprite.bounds.size.x or var_218_2 / var_218_1.sprite.bounds.size.y, 0)
				end

				for iter_218_0, iter_218_1 in pairs(arg_215_1.bgs_) do
					if iter_218_0 ~= "STwhite" then
						iter_218_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.fswbg_:SetActive(true)
				arg_215_1.dialog_:SetActive(false)

				arg_215_1.fswtw_.percent = 0
				arg_215_1.fswt_.text = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(926082050).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.fswt_)

				arg_215_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_215_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_215_1.fswtw_:SetDirty()

				arg_215_1.typewritterCharCountI18N = 0

				SetActive(arg_215_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_215_1:ShowNextGo(false)
			end

			local var_218_3 = 0.633333333333336

			if 0.633333333333336 < arg_215_1.time_ and arg_215_1.time_ <= var_218_3 + arg_218_0 then
				arg_215_1.var_.oldValueTypewriter = arg_215_1.fswtw_.percent
				arg_215_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				SetActive(arg_215_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_215_1:ShowNextGo(false)
			end

			local var_218_4 = 38
			local var_218_5 = 2.53333333333333
			local var_218_6, var_218_7 = arg_215_1:GetPercentByPara(arg_215_1:FormatText(arg_215_1:GetWordFromCfg(926082050).content), 1)

			if var_218_3 < arg_215_1.time_ and arg_215_1.time_ <= var_218_3 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				local var_218_8 = var_218_4 <= 0 and var_218_5 or var_218_5 * ((var_218_7 - arg_215_1.typewritterCharCountI18N) / var_218_4)

				if (var_218_4 <= 0 and var_218_5 or var_218_5 * ((var_218_7 - arg_215_1.typewritterCharCountI18N) / var_218_4)) > 0 and var_218_5 < var_218_8 then
					arg_215_1.talkMaxDuration = var_218_8

					if var_218_8 + var_218_3 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_3
					end
				end
			end

			local var_218_9 = math.max(2.53333333333333, arg_215_1.talkMaxDuration)

			if var_218_3 <= arg_215_1.time_ and arg_215_1.time_ < var_218_3 + var_218_9 then
				arg_215_1.fswtw_.percent = Mathf.Lerp(arg_215_1.var_.oldValueTypewriter, var_218_6, (arg_215_1.time_ - var_218_3) / var_218_9)
				arg_215_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_215_1.fswtw_:SetDirty()
			end

			if arg_215_1.time_ >= var_218_3 + var_218_9 and arg_215_1.time_ < var_218_3 + var_218_9 + arg_218_0 then
				arg_215_1.fswtw_.percent = var_218_6

				arg_215_1.fswtw_:SetDirty()
				arg_215_1:ShowNextGo(true)

				arg_215_1.typewritterCharCountI18N = var_218_7
			end

			local var_218_10 = 0.5
			local var_218_11 = manager.audio:GetVoiceLength("story_v_out_926082", "926082050", "0") / 1000

			if var_218_11 > 0 and 8.1 < var_218_11 and var_218_11 + var_218_10 > arg_215_1.duration_ then
				arg_215_1.duration_ = var_218_11 + var_218_10
			end

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 then
				arg_215_1:AudioAction("play", "voice", "story_v_out_926082", "926082050", "0")
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play926082051 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 926082051
		arg_219_1.duration_ = 8.63

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play926082052(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.fswbg_:SetActive(true)
				arg_219_1.dialog_:SetActive(false)

				arg_219_1.fswtw_.percent = 0
				arg_219_1.fswt_.text = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(926082051).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.fswt_)

				arg_219_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_219_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_219_1.fswtw_:SetDirty()

				arg_219_1.typewritterCharCountI18N = 0

				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_0 = 0.194687306880951

			if 0.194687306880951 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.var_.oldValueTypewriter = arg_219_1.fswtw_.percent
				arg_219_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_1 = 42
			local var_222_2 = 2.8
			local var_222_3, var_222_4 = arg_219_1:GetPercentByPara(arg_219_1:FormatText(arg_219_1:GetWordFromCfg(926082051).content), 1)

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				local var_222_5 = var_222_1 <= 0 and var_222_2 or var_222_2 * ((var_222_4 - arg_219_1.typewritterCharCountI18N) / var_222_1)

				if (var_222_1 <= 0 and var_222_2 or var_222_2 * ((var_222_4 - arg_219_1.typewritterCharCountI18N) / var_222_1)) > 0 and var_222_2 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_0
					end
				end
			end

			local var_222_6 = math.max(2.8, arg_219_1.talkMaxDuration)

			if var_222_0 <= arg_219_1.time_ and arg_219_1.time_ < var_222_0 + var_222_6 then
				arg_219_1.fswtw_.percent = Mathf.Lerp(arg_219_1.var_.oldValueTypewriter, var_222_3, (arg_219_1.time_ - var_222_0) / var_222_6)
				arg_219_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_219_1.fswtw_:SetDirty()
			end

			if arg_219_1.time_ >= var_222_0 + var_222_6 and arg_219_1.time_ < var_222_0 + var_222_6 + arg_222_0 then
				arg_219_1.fswtw_.percent = var_222_3

				arg_219_1.fswtw_:SetDirty()
				arg_219_1:ShowNextGo(true)

				arg_219_1.typewritterCharCountI18N = var_222_4
			end

			local var_222_7 = 0.194687306880951
			local var_222_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082051", "0") / 1000

			if var_222_8 > 0 and 8.433 < var_222_8 and var_222_8 + var_222_7 > arg_219_1.duration_ then
				arg_219_1.duration_ = var_222_8 + var_222_7
			end

			if var_222_7 < arg_219_1.time_ and arg_219_1.time_ <= var_222_7 + arg_222_0 then
				arg_219_1:AudioAction("play", "voice", "story_v_out_926082", "926082051", "0")
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play926082052 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 926082052
		arg_223_1.duration_ = 2.63

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play926082053(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.cswbg_:SetActive(true)

				local var_226_0 = arg_223_1.cswt_:GetComponent("RectTransform")

				arg_223_1.cswt_.alignment = UnityEngine.TextAnchor.UpperCenter
				var_226_0.offsetMin = Vector2.New(400, 154.9)
				var_226_0.offsetMax = Vector2.New(-335.4, -171.3)
				arg_223_1.cswt_.text = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(419160).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.cswt_)

				arg_223_1.cswt_.fontSize = 220
				arg_223_1.cswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_223_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_223_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.fswbg_:SetActive(true)
				arg_223_1.dialog_:SetActive(false)

				arg_223_1.fswtw_.percent = 0
				arg_223_1.fswt_.text = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(926082052).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.fswt_)

				arg_223_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_223_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_223_1.fswtw_:SetDirty()

				arg_223_1.typewritterCharCountI18N = 0

				SetActive(arg_223_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_223_1:ShowNextGo(false)
			end

			local var_226_1 = 0.633333333333334

			if 0.633333333333334 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.oldValueTypewriter = arg_223_1.fswtw_.percent
				arg_223_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				SetActive(arg_223_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_223_1:ShowNextGo(false)
			end

			local var_226_2 = 8
			local var_226_3 = 0.533333333333333
			local var_226_4, var_226_5 = arg_223_1:GetPercentByPara(arg_223_1:FormatText(arg_223_1:GetWordFromCfg(926082052).content), 1)

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				local var_226_6 = var_226_2 <= 0 and var_226_3 or var_226_3 * ((var_226_5 - arg_223_1.typewritterCharCountI18N) / var_226_2)

				if (var_226_2 <= 0 and var_226_3 or var_226_3 * ((var_226_5 - arg_223_1.typewritterCharCountI18N) / var_226_2)) > 0 and var_226_3 < var_226_6 then
					arg_223_1.talkMaxDuration = var_226_6

					if var_226_6 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_6 + var_226_1
					end
				end
			end

			local var_226_7 = math.max(0.533333333333333, arg_223_1.talkMaxDuration)

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_7 then
				arg_223_1.fswtw_.percent = Mathf.Lerp(arg_223_1.var_.oldValueTypewriter, var_226_4, (arg_223_1.time_ - var_226_1) / var_226_7)
				arg_223_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_223_1.fswtw_:SetDirty()
			end

			if arg_223_1.time_ >= var_226_1 + var_226_7 and arg_223_1.time_ < var_226_1 + var_226_7 + arg_226_0 then
				arg_223_1.fswtw_.percent = var_226_4

				arg_223_1.fswtw_:SetDirty()
				arg_223_1:ShowNextGo(true)

				arg_223_1.typewritterCharCountI18N = var_226_5
			end

			local var_226_8 = 0.633333333333334
			local var_226_9 = manager.audio:GetVoiceLength("story_v_out_926082", "926082052", "0") / 1000

			if var_226_9 > 0 and 2 < var_226_9 and var_226_9 + var_226_8 > arg_223_1.duration_ then
				arg_223_1.duration_ = var_226_9 + var_226_8
			end

			if var_226_8 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 then
				arg_223_1:AudioAction("play", "voice", "story_v_out_926082", "926082052", "0")
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play926082053 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 926082053
		arg_227_1.duration_ = 11.43

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play926082054(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.fswbg_:SetActive(true)
				arg_227_1.dialog_:SetActive(false)

				arg_227_1.fswtw_.percent = 0
				arg_227_1.fswt_.text = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(926082053).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.fswt_)

				arg_227_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)
				arg_227_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_227_1.fswtw_:SetDirty()

				arg_227_1.typewritterCharCountI18N = 0

				SetActive(arg_227_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_227_1:ShowNextGo(false)
			end

			local var_230_0 = 0.633333333333334

			if 0.633333333333334 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.var_.oldValueTypewriter = arg_227_1.fswtw_.percent
				arg_227_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				SetActive(arg_227_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_227_1:ShowNextGo(false)
			end

			local var_230_1 = 46
			local var_230_2 = 3.06666666666667
			local var_230_3, var_230_4 = arg_227_1:GetPercentByPara(arg_227_1:FormatText(arg_227_1:GetWordFromCfg(926082053).content), 1)

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0

				local var_230_5 = var_230_1 <= 0 and var_230_2 or var_230_2 * ((var_230_4 - arg_227_1.typewritterCharCountI18N) / var_230_1)

				if (var_230_1 <= 0 and var_230_2 or var_230_2 * ((var_230_4 - arg_227_1.typewritterCharCountI18N) / var_230_1)) > 0 and var_230_2 < var_230_5 then
					arg_227_1.talkMaxDuration = var_230_5

					if var_230_5 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + var_230_0
					end
				end
			end

			local var_230_6 = math.max(3.06666666666667, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_6 then
				arg_227_1.fswtw_.percent = Mathf.Lerp(arg_227_1.var_.oldValueTypewriter, var_230_3, (arg_227_1.time_ - var_230_0) / var_230_6)
				arg_227_1.fswt_:GetComponent("Text").color = Color(0, 0, 0)

				arg_227_1.fswtw_:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_6 and arg_227_1.time_ < var_230_0 + var_230_6 + arg_230_0 then
				arg_227_1.fswtw_.percent = var_230_3

				arg_227_1.fswtw_:SetDirty()
				arg_227_1:ShowNextGo(true)

				arg_227_1.typewritterCharCountI18N = var_230_4
			end

			local var_230_7 = 0.533333333333333
			local var_230_8 = manager.audio:GetVoiceLength("story_v_out_926082", "926082053", "0") / 1000

			if var_230_8 > 0 and 10.9 < var_230_8 and var_230_8 + var_230_7 > arg_227_1.duration_ then
				arg_227_1.duration_ = var_230_8 + var_230_7
			end

			if var_230_7 < arg_227_1.time_ and arg_227_1.time_ <= var_230_7 + arg_230_0 then
				arg_227_1:AudioAction("play", "voice", "story_v_out_926082", "926082053", "0")
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play926082054 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 926082054
		arg_231_1.duration_ = 5.18

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play926082055(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.fswbg_:SetActive(false)
				arg_231_1.dialog_:SetActive(false)
				SetActive(arg_231_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_231_1:ShowNextGo(false)
			end

			if 0.0166666666666667 < arg_231_1.time_ and arg_231_1.time_ <= 0.0166666666666667 + arg_234_0 then
				arg_231_1.fswbg_:SetActive(false)
				arg_231_1.dialog_:SetActive(false)
				SetActive(arg_231_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_231_1:ShowNextGo(false)
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_234_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_231_1.bgmTxt_.text ~= var_234_2 and arg_231_1.bgmTxt_.text ~= "" then
						if arg_231_1.bgmTxt2_.text ~= "" then
							arg_231_1.bgmTxt_.text = arg_231_1.bgmTxt2_.text
						end

						arg_231_1.bgmTxt2_.text = var_234_2

						arg_231_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_231_1.bgmTxt_.text = var_234_2
						arg_231_1.bgmTxt2_.text = var_234_2
					end

					if arg_231_1.bgmTimer then
						arg_231_1.bgmTimer:Stop()

						arg_231_1.bgmTimer = nil
					end

					if arg_231_1.settingData.show_music_name == 1 then
						arg_231_1.musicController:SetSelectedState("show")
						arg_231_1.musicAnimator_:Play("open", 0, 0)

						if arg_231_1.settingData.music_time ~= 0 then
							arg_231_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_231_1.settingData.music_time), function()
								if arg_231_1 == nil or isNil(arg_231_1.bgmTxt_) then
									return
								end

								arg_231_1.musicController:SetSelectedState("hide")
								arg_231_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:AudioAction("play", "effect", "se_story_143", "se_story_143_bell03", "")
			end

			local var_234_4 = "104701"

			if arg_231_1.actors_["104701"] == nil then
				local var_234_5 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

				if not isNil(var_234_5) then
					local var_234_6 = Object.Instantiate(var_234_5, arg_231_1.canvasGo_.transform)

					var_234_6.transform:SetSiblingIndex(1)

					var_234_6.name = var_234_4
					var_234_6.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_231_1.actors_[var_234_4] = var_234_6

					if arg_231_1.isInRecall_ then
						for iter_234_0, iter_234_1 in ipairs((var_234_6:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_234_1.color = arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_234_7 = arg_231_1.actors_["104701"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos104701 = var_234_7.localPosition
				var_234_7.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("104701", 3)

				for iter_234_2 = 0, var_234_7.childCount - 1 do
					local var_234_8 = var_234_7:GetChild(iter_234_2)

					if var_234_8.name == "split_4" or not string.find(var_234_8.name, "split") then
						var_234_8.gameObject:SetActive(true)
					else
						var_234_8.gameObject:SetActive(false)
					end
				end
			end

			local var_234_9 = 0.1

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_9 then
				var_234_7.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos104701, Vector3.New(-41, -375, -352.4), (arg_231_1.time_ - 0) / var_234_9)
			end

			if arg_231_1.time_ >= 0 + var_234_9 and arg_231_1.time_ < 0 + var_234_9 + arg_234_0 then
				var_234_7.localPosition = Vector3.New(-41, -375, -352.4)
			end

			local var_234_10 = arg_231_1.actors_["104701"].transform

			if 0.1 < arg_231_1.time_ and arg_231_1.time_ <= 0.1 + arg_234_0 then
				arg_231_1.var_.moveOldPos104701 = var_234_10.localPosition
				var_234_10.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("104701", 3)

				for iter_234_3 = 0, var_234_10.childCount - 1 do
					local var_234_11 = var_234_10:GetChild(iter_234_3)

					if var_234_11.name == "split_4" or not string.find(var_234_11.name, "split") then
						var_234_11.gameObject:SetActive(true)
					else
						var_234_11.gameObject:SetActive(false)
					end
				end
			end

			local var_234_12 = 0.0666666666666667

			if 0.1 <= arg_231_1.time_ and arg_231_1.time_ < 0.1 + var_234_12 then
				var_234_10.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos104701, Vector3.New(-41, -388.2, -352.4), (arg_231_1.time_ - 0.1) / var_234_12)
			end

			if arg_231_1.time_ >= 0.1 + var_234_12 and arg_231_1.time_ < 0.1 + var_234_12 + arg_234_0 then
				var_234_10.localPosition = Vector3.New(-41, -388.2, -352.4)
			end

			local var_234_13 = arg_231_1.actors_["104701"].transform

			if 0.166666666666667 < arg_231_1.time_ and arg_231_1.time_ <= 0.166666666666667 + arg_234_0 then
				arg_231_1.var_.moveOldPos104701 = var_234_13.localPosition
				var_234_13.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("104701", 3)

				for iter_234_4 = 0, var_234_13.childCount - 1 do
					local var_234_14 = var_234_13:GetChild(iter_234_4)

					if var_234_14.name == "split_4" or not string.find(var_234_14.name, "split") then
						var_234_14.gameObject:SetActive(true)
					else
						var_234_14.gameObject:SetActive(false)
					end
				end
			end

			local var_234_15 = 0.001

			if 0.166666666666667 <= arg_231_1.time_ and arg_231_1.time_ < 0.166666666666667 + var_234_15 then
				var_234_13.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos104701, Vector3.New(-41, -375, -352.4), (arg_231_1.time_ - 0.166666666666667) / var_234_15)
			end

			if arg_231_1.time_ >= 0.166666666666667 + var_234_15 and arg_231_1.time_ < 0.166666666666667 + var_234_15 + arg_234_0 then
				var_234_13.localPosition = Vector3.New(-41, -375, -352.4)
			end

			local var_234_16 = 0

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_16 + arg_234_0 then
				arg_231_1.allBtn_.enabled = false
			end

			if arg_231_1.time_ >= var_234_16 + 0.8 and arg_231_1.time_ < var_234_16 + 0.8 + arg_234_0 then
				arg_231_1.allBtn_.enabled = true
			end

			if arg_231_1.frameCnt_ <= 1 then
				arg_231_1.dialog_:SetActive(false)
			end

			local var_234_17 = 0.183333333333333
			local var_234_18 = 0.25

			if 0.183333333333333 < arg_231_1.time_ and arg_231_1.time_ <= var_234_17 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0

				arg_231_1.dialog_:SetActive(true)

				arg_231_1.dialogCg_.alpha = 0

				local var_234_19 = LeanTween.value(arg_231_1.dialog_, 0, 1, 0.3)

				var_234_19:setOnUpdate(LuaHelper.FloatAction(function(arg_236_0)
					arg_231_1.dialogCg_.alpha = arg_236_0
				end))
				var_234_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_231_1.dialog_)
					var_234_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_231_1.duration_ = arg_231_1.duration_ + 0.3

				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, true)
				arg_231_1.iconController_:SetSelectedState("hero")

				arg_231_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_231_1.callingController_:SetSelectedState("normal")

				arg_231_1.keyicon_.color = Color.New(1, 1, 1)
				arg_231_1.icon_.color = Color.New(1, 1, 1)

				local var_234_20 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(926082054).content)

				arg_231_1.text_.text = var_234_20

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_22 = 10 <= 0 and var_234_18 or var_234_18 * (utf8.len(var_234_20) / 10)

				if (10 <= 0 and var_234_18 or var_234_18 * (utf8.len(var_234_20) / 10)) > 0 and var_234_18 < var_234_22 then
					arg_231_1.talkMaxDuration = var_234_22
					var_234_17 = var_234_17 + 0.3

					if var_234_22 + var_234_17 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_22 + var_234_17
					end
				end

				arg_231_1.text_.text = var_234_20
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_23 = var_234_17 + 0.3
			local var_234_24 = math.max(var_234_18, arg_231_1.talkMaxDuration)

			if var_234_17 + 0.3 <= arg_231_1.time_ and arg_231_1.time_ < var_234_23 + var_234_24 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_23) / var_234_24

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_23 + var_234_24 and arg_231_1.time_ < var_234_23 + var_234_24 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "104701",
				changeDisplayLayer = true,
				className = "StoryMoveNode",
				duration = 0.1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				displayLayer = StoryPlayerConst.ACTOR_DISPLAY_LAYER.TOP,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0.245,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-28.04, -1700.12, -265.92),
					endPos = Vector3.New(-41, -375, -352.4),
					easeType = LeanTweenType.notUsed
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "104701",
				changeDisplayLayer = true,
				className = "StoryMoveNode",
				duration = 0.0666666666666667,
				startTime = 0.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				displayLayer = StoryPlayerConst.ACTOR_DISPLAY_LAYER.TOP,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-41, -375, -352.4),
					endPos = Vector3.New(-41, -388.2, -352.4),
					easeType = LeanTweenType.notUsed
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "104701",
				changeDisplayLayer = true,
				className = "StoryMoveNode",
				duration = 0.0166666666666667,
				startTime = 0.166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				displayLayer = StoryPlayerConst.ACTOR_DISPLAY_LAYER.TOP,
				easeData = {
					needAlphaEase = true,
					startAlpha = 1,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-41, -388.2, -352.4),
					endPos = Vector3.New(-41, -375, -352.4),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play926082055 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 926082055
		arg_238_1.duration_ = 10.2

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play926082056(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0.766666666666667 < arg_238_1.time_ and arg_238_1.time_ <= 0.766666666666667 + arg_241_0 and not isNil(arg_238_1.actors_["10144"]) and arg_238_1.var_.actorSpriteComps10144 == nil then
				arg_238_1.var_.actorSpriteComps10144 = arg_238_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_0 = 0.2

			if 0.766666666666667 <= arg_238_1.time_ and arg_238_1.time_ < 0.766666666666667 + var_241_0 and not isNil(arg_238_1.actors_["10144"]) then
				if arg_238_1.var_.actorSpriteComps10144 then
					for iter_241_0, iter_241_1 in pairs(arg_238_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_241_1 then
							if arg_238_1.isInRecall_ then
								iter_241_1.color = Color.New(Mathf.Lerp(iter_241_1.color.r, arg_238_1.hightColor1.r, (arg_238_1.time_ - 0.766666666666667) / var_241_0), Mathf.Lerp(iter_241_1.color.g, arg_238_1.hightColor1.g, (arg_238_1.time_ - 0.766666666666667) / var_241_0), (Mathf.Lerp(iter_241_1.color.b, arg_238_1.hightColor1.b, (arg_238_1.time_ - 0.766666666666667) / var_241_0)))
							else
								local var_241_1 = Mathf.Lerp(iter_241_1.color.r, 1, (arg_238_1.time_ - 0.766666666666667) / var_241_0)

								iter_241_1.color = Color.New(var_241_1, var_241_1, var_241_1)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= 0.766666666666667 + var_241_0 and arg_238_1.time_ < 0.766666666666667 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["10144"]) and arg_238_1.var_.actorSpriteComps10144 then
				for iter_241_2, iter_241_3 in pairs(arg_238_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_241_3 then
						iter_241_3.color = arg_238_1.isInRecall_ and (arg_238_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_238_1.var_.actorSpriteComps10144 = nil
			end

			if 1.23333333333333 < arg_238_1.time_ and arg_238_1.time_ <= 1.23333333333333 + arg_241_0 then
				arg_238_1.cswbg_:SetActive(false)
			end

			if 1.23333333333333 < arg_238_1.time_ and arg_238_1.time_ <= 1.23333333333333 + arg_241_0 then
				local var_241_2 = arg_238_1.bgs_.I20f

				arg_238_1.bgs_.I20f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_241_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_241_3 = var_241_2:GetComponent("SpriteRenderer")

				if var_241_3 and var_241_3.sprite then
					local var_241_4 = 2 * (var_241_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_241_2.transform.localScale = Vector3.New(var_241_4 / var_241_3.sprite.bounds.size.y < var_241_4 * manager.ui.mainCameraCom_.aspect / var_241_3.sprite.bounds.size.x and var_241_4 * manager.ui.mainCameraCom_.aspect / var_241_3.sprite.bounds.size.x or var_241_4 / var_241_3.sprite.bounds.size.y, var_241_4 / var_241_3.sprite.bounds.size.y < var_241_4 * manager.ui.mainCameraCom_.aspect / var_241_3.sprite.bounds.size.x and var_241_4 * manager.ui.mainCameraCom_.aspect / var_241_3.sprite.bounds.size.x or var_241_4 / var_241_3.sprite.bounds.size.y, 0)
				end

				for iter_241_4, iter_241_5 in pairs(arg_238_1.bgs_) do
					if iter_241_4 ~= "I20f" then
						iter_241_5.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_241_5 = 0

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_5 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_6 = 1.23333333333333

			if var_241_5 <= arg_238_1.time_ and arg_238_1.time_ < var_241_5 + var_241_6 then
				local var_241_7 = Color.New(0, 0, 0)

				var_241_7.a = Mathf.Lerp(0, 1, (arg_238_1.time_ - var_241_5) / var_241_6)
				arg_238_1.mask_.color = var_241_7
			end

			if arg_238_1.time_ >= var_241_5 + var_241_6 and arg_238_1.time_ < var_241_5 + var_241_6 + arg_241_0 then
				local var_241_8 = Color.New(0, 0, 0)

				var_241_8.a = 1
				arg_238_1.mask_.color = var_241_8
			end

			local var_241_9 = 1.23333333333333

			if 1.23333333333333 < arg_238_1.time_ and arg_238_1.time_ <= var_241_9 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_10 = 2

			if var_241_9 <= arg_238_1.time_ and arg_238_1.time_ < var_241_9 + var_241_10 then
				local var_241_11 = Color.New(0, 0, 0)

				var_241_11.a = Mathf.Lerp(1, 0, (arg_238_1.time_ - var_241_9) / var_241_10)
				arg_238_1.mask_.color = var_241_11
			end

			if arg_238_1.time_ >= var_241_9 + var_241_10 and arg_238_1.time_ < var_241_9 + var_241_10 + arg_241_0 then
				local var_241_12 = Color.New(0, 0, 0)

				arg_238_1.mask_.enabled = false
				var_241_12.a = 0
				arg_238_1.mask_.color = var_241_12
			end

			if 0.766666666666667 < arg_238_1.time_ and arg_238_1.time_ <= 0.766666666666667 + arg_241_0 then
				arg_238_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_241_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_238_1.bgmTxt_.text ~= var_241_15 and arg_238_1.bgmTxt_.text ~= "" then
						if arg_238_1.bgmTxt2_.text ~= "" then
							arg_238_1.bgmTxt_.text = arg_238_1.bgmTxt2_.text
						end

						arg_238_1.bgmTxt2_.text = var_241_15

						arg_238_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_238_1.bgmTxt_.text = var_241_15
						arg_238_1.bgmTxt2_.text = var_241_15
					end

					if arg_238_1.bgmTimer then
						arg_238_1.bgmTimer:Stop()

						arg_238_1.bgmTimer = nil
					end

					if arg_238_1.settingData.show_music_name == 1 then
						arg_238_1.musicController:SetSelectedState("show")
						arg_238_1.musicAnimator_:Play("open", 0, 0)

						if arg_238_1.settingData.music_time ~= 0 then
							arg_238_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_238_1.settingData.music_time), function()
								if arg_238_1 == nil or isNil(arg_238_1.bgmTxt_) then
									return
								end

								arg_238_1.musicController:SetSelectedState("hide")
								arg_238_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.23333333333333 < arg_238_1.time_ and arg_238_1.time_ <= 1.23333333333333 + arg_241_0 then
				arg_238_1:AudioAction("play", "music", "bgm_side_daily06", "bgm_side_daily06", "bgm_side_daily06.awb")

				local var_241_18 = manager.audio:GetAudioName("bgm_side_daily06", "bgm_side_daily06")

				if "" ~= "" then
					if arg_238_1.bgmTxt_.text ~= var_241_18 and arg_238_1.bgmTxt_.text ~= "" then
						if arg_238_1.bgmTxt2_.text ~= "" then
							arg_238_1.bgmTxt_.text = arg_238_1.bgmTxt2_.text
						end

						arg_238_1.bgmTxt2_.text = var_241_18

						arg_238_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_238_1.bgmTxt_.text = var_241_18
						arg_238_1.bgmTxt2_.text = var_241_18
					end

					if arg_238_1.bgmTimer then
						arg_238_1.bgmTimer:Stop()

						arg_238_1.bgmTimer = nil
					end

					if arg_238_1.settingData.show_music_name == 1 then
						arg_238_1.musicController:SetSelectedState("show")
						arg_238_1.musicAnimator_:Play("open", 0, 0)

						if arg_238_1.settingData.music_time ~= 0 then
							arg_238_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_238_1.settingData.music_time), function()
								if arg_238_1 == nil or isNil(arg_238_1.bgmTxt_) then
									return
								end

								arg_238_1.musicController:SetSelectedState("hide")
								arg_238_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_241_19 = arg_238_1.actors_["104701"].transform

			if 1.23333333333333 < arg_238_1.time_ and arg_238_1.time_ <= 1.23333333333333 + arg_241_0 then
				arg_238_1.var_.moveOldPos104701 = var_241_19.localPosition
				var_241_19.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("104701", 7)

				for iter_241_6 = 0, var_241_19.childCount - 1 do
					local var_241_20 = var_241_19:GetChild(iter_241_6)

					if var_241_20.name == "split_4" or not string.find(var_241_20.name, "split") then
						var_241_20.gameObject:SetActive(true)
					else
						var_241_20.gameObject:SetActive(false)
					end
				end
			end

			local var_241_21 = 0.001

			if 1.23333333333333 <= arg_238_1.time_ and arg_238_1.time_ < 1.23333333333333 + var_241_21 then
				var_241_19.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_238_1.time_ - 1.23333333333333) / var_241_21)
			end

			if arg_238_1.time_ >= 1.23333333333333 + var_241_21 and arg_238_1.time_ < 1.23333333333333 + var_241_21 + arg_241_0 then
				var_241_19.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_238_1.frameCnt_ <= 1 then
				arg_238_1.dialog_:SetActive(false)
			end

			local var_241_22 = 3.03333333333333
			local var_241_23 = 0.575

			if 3.03333333333333 < arg_238_1.time_ and arg_238_1.time_ <= var_241_22 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0

				arg_238_1.dialog_:SetActive(true)

				arg_238_1.dialogCg_.alpha = 0

				local var_241_24 = LeanTween.value(arg_238_1.dialog_, 0, 1, 0.3)

				var_241_24:setOnUpdate(LuaHelper.FloatAction(function(arg_244_0)
					arg_238_1.dialogCg_.alpha = arg_244_0
				end))
				var_241_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_238_1.dialog_)
					var_241_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_238_1.duration_ = arg_238_1.duration_ + 0.3

				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10144_split_4")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_25 = arg_238_1:GetWordFromCfg(926082055)
				local var_241_26 = arg_238_1:FormatText(var_241_25.content)

				arg_238_1.text_.text = var_241_26

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_28 = 23 <= 0 and var_241_23 or var_241_23 * (utf8.len(var_241_26) / 23)

				if (23 <= 0 and var_241_23 or var_241_23 * (utf8.len(var_241_26) / 23)) > 0 and var_241_23 < var_241_28 then
					arg_238_1.talkMaxDuration = var_241_28
					var_241_22 = var_241_22 + 0.3

					if var_241_28 + var_241_22 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_28 + var_241_22
					end
				end

				arg_238_1.text_.text = var_241_26
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082055", "story_v_out_926082.awb") ~= 0 then
					local var_241_29 = manager.audio:GetVoiceLength("story_v_out_926082", "926082055", "story_v_out_926082.awb") / 1000

					if var_241_29 + var_241_22 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_29 + var_241_22
					end

					if var_241_25.prefab_name ~= "" and arg_238_1.actors_[var_241_25.prefab_name] ~= nil then
						local var_241_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_25.prefab_name].transform, "story_v_out_926082", "926082055", "story_v_out_926082.awb")

						arg_238_1:RecordAudio("926082055", var_241_30)
						arg_238_1:RecordAudio("926082055", var_241_30)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_926082", "926082055", "story_v_out_926082.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_926082", "926082055", "story_v_out_926082.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_31 = var_241_22 + 0.3
			local var_241_32 = math.max(var_241_23, arg_238_1.talkMaxDuration)

			if var_241_22 + 0.3 <= arg_238_1.time_ and arg_238_1.time_ < var_241_31 + var_241_32 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_31) / var_241_32

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_31 + var_241_32 and arg_238_1.time_ < var_241_31 + var_241_32 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = false,
				actorName = "104701",
				changeDisplayLayer = true,
				className = "StoryMoveNode",
				duration = 0.0166666666666667,
				startTime = 1.23333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite,
				displayLayer = StoryPlayerConst.ACTOR_DISPLAY_LAYER.NORMAL
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play926082056 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 926082056
		arg_246_1.duration_ = 3.03

		local var_246_0 = {
			zh = 2.533,
			ja = 3.033
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
				arg_246_0:Play926082057(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["128404"]) and arg_246_1.var_.actorSpriteComps128404 == nil then
				arg_246_1.var_.actorSpriteComps128404 = arg_246_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_0 = 0.2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["128404"]) then
				if arg_246_1.var_.actorSpriteComps128404 then
					for iter_249_0, iter_249_1 in pairs(arg_246_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_249_1 then
							if arg_246_1.isInRecall_ then
								iter_249_1.color = Color.New(Mathf.Lerp(iter_249_1.color.r, arg_246_1.hightColor1.r, (arg_246_1.time_ - 0) / var_249_0), Mathf.Lerp(iter_249_1.color.g, arg_246_1.hightColor1.g, (arg_246_1.time_ - 0) / var_249_0), (Mathf.Lerp(iter_249_1.color.b, arg_246_1.hightColor1.b, (arg_246_1.time_ - 0) / var_249_0)))
							else
								local var_249_1 = Mathf.Lerp(iter_249_1.color.r, 1, (arg_246_1.time_ - 0) / var_249_0)

								iter_249_1.color = Color.New(var_249_1, var_249_1, var_249_1)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["128404"]) and arg_246_1.var_.actorSpriteComps128404 then
				for iter_249_2, iter_249_3 in pairs(arg_246_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_249_3 then
						iter_249_3.color = arg_246_1.isInRecall_ and (arg_246_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_246_1.var_.actorSpriteComps128404 = nil
			end

			local var_249_2 = arg_246_1.actors_["10144"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_2) and arg_246_1.var_.actorSpriteComps10144 == nil then
				arg_246_1.var_.actorSpriteComps10144 = var_249_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_3 = 0.2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_3 and not isNil(var_249_2) then
				if arg_246_1.var_.actorSpriteComps10144 then
					for iter_249_4, iter_249_5 in pairs(arg_246_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_249_5 then
							if arg_246_1.isInRecall_ then
								iter_249_5.color = Color.New(Mathf.Lerp(iter_249_5.color.r, arg_246_1.hightColor2.r, (arg_246_1.time_ - 0) / var_249_3), Mathf.Lerp(iter_249_5.color.g, arg_246_1.hightColor2.g, (arg_246_1.time_ - 0) / var_249_3), (Mathf.Lerp(iter_249_5.color.b, arg_246_1.hightColor2.b, (arg_246_1.time_ - 0) / var_249_3)))
							else
								local var_249_4 = Mathf.Lerp(iter_249_5.color.r, 0.5, (arg_246_1.time_ - 0) / var_249_3)

								iter_249_5.color = Color.New(var_249_4, var_249_4, var_249_4)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= 0 + var_249_3 and arg_246_1.time_ < 0 + var_249_3 + arg_249_0 and not isNil(var_249_2) and arg_246_1.var_.actorSpriteComps10144 then
				for iter_249_6, iter_249_7 in pairs(arg_246_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_249_7 then
						iter_249_7.color = arg_246_1.isInRecall_ and (arg_246_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_246_1.var_.actorSpriteComps10144 = nil
			end

			local var_249_5 = arg_246_1.actors_["128404"].transform

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos128404 = var_249_5.localPosition
				var_249_5.localScale = Vector3.New(1, 1, 1)

				arg_246_1:CheckSpriteTmpPos("128404", 3)

				for iter_249_8 = 0, var_249_5.childCount - 1 do
					local var_249_6 = var_249_5:GetChild(iter_249_8)

					if var_249_6.name == "split_4" or not string.find(var_249_6.name, "split") then
						var_249_6.gameObject:SetActive(true)
					else
						var_249_6.gameObject:SetActive(false)
					end
				end
			end

			local var_249_7 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_7 then
				var_249_5.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_246_1.time_ - 0) / var_249_7)
			end

			if arg_246_1.time_ >= 0 + var_249_7 and arg_246_1.time_ < 0 + var_249_7 + arg_249_0 then
				var_249_5.localPosition = Vector3.New(-16.1, -362, -375)
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				local var_249_8 = arg_246_1.actors_["128404"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_249_8 then
					arg_246_1.var_.alphaOldValue128404 = var_249_8.alpha
					arg_246_1.var_.characterEffect128404 = var_249_8
				end

				arg_246_1.var_.alphaOldValue128404 = 0
			end

			local var_249_9 = 0.2

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_9 then
				if arg_246_1.var_.characterEffect128404 then
					arg_246_1.var_.characterEffect128404.alpha = Mathf.Lerp(arg_246_1.var_.alphaOldValue128404, 1, (arg_246_1.time_ - 0) / var_249_9)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_9 and arg_246_1.time_ < 0 + var_249_9 + arg_249_0 and arg_246_1.var_.characterEffect128404 then
				arg_246_1.var_.characterEffect128404.alpha = 1
			end

			local var_249_10 = 0
			local var_249_11 = 0.125

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_10 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				arg_246_1.leftNameTxt_.text = arg_246_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_12 = arg_246_1:GetWordFromCfg(926082056)
				local var_249_13 = arg_246_1:FormatText(var_249_12.content)

				arg_246_1.text_.text = var_249_13

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_15 = 5 <= 0 and var_249_11 or var_249_11 * (utf8.len(var_249_13) / 5)

				if (5 <= 0 and var_249_11 or var_249_11 * (utf8.len(var_249_13) / 5)) > 0 and var_249_11 < var_249_15 then
					arg_246_1.talkMaxDuration = var_249_15

					if var_249_15 + var_249_10 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_15 + var_249_10
					end
				end

				arg_246_1.text_.text = var_249_13
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082056", "story_v_out_926082.awb") ~= 0 then
					local var_249_16 = manager.audio:GetVoiceLength("story_v_out_926082", "926082056", "story_v_out_926082.awb") / 1000

					if var_249_16 + var_249_10 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_16 + var_249_10
					end

					if var_249_12.prefab_name ~= "" and arg_246_1.actors_[var_249_12.prefab_name] ~= nil then
						local var_249_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_12.prefab_name].transform, "story_v_out_926082", "926082056", "story_v_out_926082.awb")

						arg_246_1:RecordAudio("926082056", var_249_17)
						arg_246_1:RecordAudio("926082056", var_249_17)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_926082", "926082056", "story_v_out_926082.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_926082", "926082056", "story_v_out_926082.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_18 = math.max(var_249_11, arg_246_1.talkMaxDuration)

			if var_249_10 <= arg_246_1.time_ and arg_246_1.time_ < var_249_10 + var_249_18 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_10) / var_249_18

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_10 + var_249_18 and arg_246_1.time_ < var_249_10 + var_249_18 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play926082057 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 926082057
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play926082058(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 and not isNil(arg_250_1.actors_["128404"]) and arg_250_1.var_.actorSpriteComps128404 == nil then
				arg_250_1.var_.actorSpriteComps128404 = arg_250_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_253_0 = 0.2

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_0 and not isNil(arg_250_1.actors_["128404"]) then
				if arg_250_1.var_.actorSpriteComps128404 then
					for iter_253_0, iter_253_1 in pairs(arg_250_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_253_1 then
							if arg_250_1.isInRecall_ then
								iter_253_1.color = Color.New(Mathf.Lerp(iter_253_1.color.r, arg_250_1.hightColor2.r, (arg_250_1.time_ - 0) / var_253_0), Mathf.Lerp(iter_253_1.color.g, arg_250_1.hightColor2.g, (arg_250_1.time_ - 0) / var_253_0), (Mathf.Lerp(iter_253_1.color.b, arg_250_1.hightColor2.b, (arg_250_1.time_ - 0) / var_253_0)))
							else
								local var_253_1 = Mathf.Lerp(iter_253_1.color.r, 0.5, (arg_250_1.time_ - 0) / var_253_0)

								iter_253_1.color = Color.New(var_253_1, var_253_1, var_253_1)
							end
						end
					end
				end
			end

			if arg_250_1.time_ >= 0 + var_253_0 and arg_250_1.time_ < 0 + var_253_0 + arg_253_0 and not isNil(arg_250_1.actors_["128404"]) and arg_250_1.var_.actorSpriteComps128404 then
				for iter_253_2, iter_253_3 in pairs(arg_250_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_253_3 then
						iter_253_3.color = arg_250_1.isInRecall_ and (arg_250_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_250_1.var_.actorSpriteComps128404 = nil
			end

			local var_253_2 = 0
			local var_253_3 = 0.15

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_2 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				arg_250_1.leftNameTxt_.text = arg_250_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, true)
				arg_250_1.iconController_:SetSelectedState("hero")

				arg_250_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_250_1.callingController_:SetSelectedState("normal")

				arg_250_1.keyicon_.color = Color.New(1, 1, 1)
				arg_250_1.icon_.color = Color.New(1, 1, 1)

				local var_253_4 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(926082057).content)

				arg_250_1.text_.text = var_253_4

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_6 = 6 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_4) / 6)

				if (6 <= 0 and var_253_3 or var_253_3 * (utf8.len(var_253_4) / 6)) > 0 and var_253_3 < var_253_6 then
					arg_250_1.talkMaxDuration = var_253_6

					if var_253_6 + var_253_2 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_6 + var_253_2
					end
				end

				arg_250_1.text_.text = var_253_4
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_7 = math.max(var_253_3, arg_250_1.talkMaxDuration)

			if var_253_2 <= arg_250_1.time_ and arg_250_1.time_ < var_253_2 + var_253_7 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_2) / var_253_7

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_2 + var_253_7 and arg_250_1.time_ < var_253_2 + var_253_7 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play926082058 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 926082058
		arg_254_1.duration_ = 8.5

		local var_254_0 = {
			zh = 8.5,
			ja = 7.433
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
				arg_254_0:Play926082059(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["128404"]) and arg_254_1.var_.actorSpriteComps128404 == nil then
				arg_254_1.var_.actorSpriteComps128404 = arg_254_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_0 = 0.2

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["128404"]) then
				if arg_254_1.var_.actorSpriteComps128404 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_257_1 then
							if arg_254_1.isInRecall_ then
								iter_257_1.color = Color.New(Mathf.Lerp(iter_257_1.color.r, arg_254_1.hightColor1.r, (arg_254_1.time_ - 0) / var_257_0), Mathf.Lerp(iter_257_1.color.g, arg_254_1.hightColor1.g, (arg_254_1.time_ - 0) / var_257_0), (Mathf.Lerp(iter_257_1.color.b, arg_254_1.hightColor1.b, (arg_254_1.time_ - 0) / var_257_0)))
							else
								local var_257_1 = Mathf.Lerp(iter_257_1.color.r, 1, (arg_254_1.time_ - 0) / var_257_0)

								iter_257_1.color = Color.New(var_257_1, var_257_1, var_257_1)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["128404"]) and arg_254_1.var_.actorSpriteComps128404 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_257_3 then
						iter_257_3.color = arg_254_1.isInRecall_ and (arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_254_1.var_.actorSpriteComps128404 = nil
			end

			local var_257_2 = arg_254_1.actors_["128404"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos128404 = var_257_2.localPosition
				var_257_2.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("128404", 3)

				for iter_257_4 = 0, var_257_2.childCount - 1 do
					local var_257_3 = var_257_2:GetChild(iter_257_4)

					if var_257_3.name == "split_4" or not string.find(var_257_3.name, "split") then
						var_257_3.gameObject:SetActive(true)
					else
						var_257_3.gameObject:SetActive(false)
					end
				end
			end

			local var_257_4 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_4 then
				var_257_2.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_254_1.time_ - 0) / var_257_4)
			end

			if arg_254_1.time_ >= 0 + var_257_4 and arg_254_1.time_ < 0 + var_257_4 + arg_257_0 then
				var_257_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_257_5 = 0
			local var_257_6 = 0.675

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_5 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_7 = arg_254_1:GetWordFromCfg(926082058)
				local var_257_8 = arg_254_1:FormatText(var_257_7.content)

				arg_254_1.text_.text = var_257_8

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_10 = 27 <= 0 and var_257_6 or var_257_6 * (utf8.len(var_257_8) / 27)

				if (27 <= 0 and var_257_6 or var_257_6 * (utf8.len(var_257_8) / 27)) > 0 and var_257_6 < var_257_10 then
					arg_254_1.talkMaxDuration = var_257_10

					if var_257_10 + var_257_5 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_10 + var_257_5
					end
				end

				arg_254_1.text_.text = var_257_8
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082058", "story_v_out_926082.awb") ~= 0 then
					local var_257_11 = manager.audio:GetVoiceLength("story_v_out_926082", "926082058", "story_v_out_926082.awb") / 1000

					if var_257_11 + var_257_5 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_11 + var_257_5
					end

					if var_257_7.prefab_name ~= "" and arg_254_1.actors_[var_257_7.prefab_name] ~= nil then
						local var_257_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_7.prefab_name].transform, "story_v_out_926082", "926082058", "story_v_out_926082.awb")

						arg_254_1:RecordAudio("926082058", var_257_12)
						arg_254_1:RecordAudio("926082058", var_257_12)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_926082", "926082058", "story_v_out_926082.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_926082", "926082058", "story_v_out_926082.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_13 = math.max(var_257_6, arg_254_1.talkMaxDuration)

			if var_257_5 <= arg_254_1.time_ and arg_254_1.time_ < var_257_5 + var_257_13 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_5) / var_257_13

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_5 + var_257_13 and arg_254_1.time_ < var_257_5 + var_257_13 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play926082059 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 926082059
		arg_258_1.duration_ = 1

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"

			SetActive(arg_258_1.choicesGo_, true)

			for iter_259_0, iter_259_1 in ipairs(arg_258_1.choices_) do
				SetActive(iter_259_1.go, iter_259_0 <= 1)
			end

			arg_258_1.choices_[1].txt.text = arg_258_1:FormatText(StoryChoiceCfg[1334].name)
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play926082060(arg_258_1)
			end

			arg_258_1:RecordChoiceLog(926082059, 1334)
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["128404"]) and arg_258_1.var_.actorSpriteComps128404 == nil then
				arg_258_1.var_.actorSpriteComps128404 = arg_258_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_0 = 0.2

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["128404"]) then
				if arg_258_1.var_.actorSpriteComps128404 then
					for iter_261_0, iter_261_1 in pairs(arg_258_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_261_1 then
							if arg_258_1.isInRecall_ then
								iter_261_1.color = Color.New(Mathf.Lerp(iter_261_1.color.r, arg_258_1.hightColor2.r, (arg_258_1.time_ - 0) / var_261_0), Mathf.Lerp(iter_261_1.color.g, arg_258_1.hightColor2.g, (arg_258_1.time_ - 0) / var_261_0), (Mathf.Lerp(iter_261_1.color.b, arg_258_1.hightColor2.b, (arg_258_1.time_ - 0) / var_261_0)))
							else
								local var_261_1 = Mathf.Lerp(iter_261_1.color.r, 0.5, (arg_258_1.time_ - 0) / var_261_0)

								iter_261_1.color = Color.New(var_261_1, var_261_1, var_261_1)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["128404"]) and arg_258_1.var_.actorSpriteComps128404 then
				for iter_261_2, iter_261_3 in pairs(arg_258_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_261_3 then
						iter_261_3.color = arg_258_1.isInRecall_ and (arg_258_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_258_1.var_.actorSpriteComps128404 = nil
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play926082060 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 926082060
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play926082061(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos128404 = arg_262_1.actors_["128404"].transform.localPosition
				arg_262_1.actors_["128404"].transform.localScale = Vector3.New(1, 1, 1)

				arg_262_1:CheckSpriteTmpPos("128404", 7)

				for iter_265_0 = 0, arg_262_1.actors_["128404"].transform.childCount - 1 do
					local var_265_0 = arg_262_1.actors_["128404"].transform:GetChild(iter_265_0)

					if var_265_0.name == "" or not string.find(var_265_0.name, "split") then
						var_265_0.gameObject:SetActive(true)
					else
						var_265_0.gameObject:SetActive(false)
					end
				end
			end

			local var_265_1 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_1 then
				arg_262_1.actors_["128404"].transform.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_262_1.time_ - 0) / var_265_1)
			end

			if arg_262_1.time_ >= 0 + var_265_1 and arg_262_1.time_ < 0 + var_265_1 + arg_265_0 then
				arg_262_1.actors_["128404"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_265_2 = 0
			local var_265_3 = 0.9

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_2 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, true)
				arg_262_1.iconController_:SetSelectedState("hero")

				arg_262_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_262_1.callingController_:SetSelectedState("normal")

				arg_262_1.keyicon_.color = Color.New(1, 1, 1)
				arg_262_1.icon_.color = Color.New(1, 1, 1)

				local var_265_4 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(926082060).content)

				arg_262_1.text_.text = var_265_4

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_6 = 36 <= 0 and var_265_3 or var_265_3 * (utf8.len(var_265_4) / 36)

				if (36 <= 0 and var_265_3 or var_265_3 * (utf8.len(var_265_4) / 36)) > 0 and var_265_3 < var_265_6 then
					arg_262_1.talkMaxDuration = var_265_6

					if var_265_6 + var_265_2 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_6 + var_265_2
					end
				end

				arg_262_1.text_.text = var_265_4
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_7 = math.max(var_265_3, arg_262_1.talkMaxDuration)

			if var_265_2 <= arg_262_1.time_ and arg_262_1.time_ < var_265_2 + var_265_7 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_2) / var_265_7

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_2 + var_265_7 and arg_262_1.time_ < var_265_2 + var_265_7 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
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
	Play926082061 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 926082061
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play926082062(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0.65

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_1 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(926082061).content)

				arg_266_1.text_.text = var_269_1

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_3 = 26 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_1) / 26)

				if (26 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_1) / 26)) > 0 and var_269_0 < var_269_3 then
					arg_266_1.talkMaxDuration = var_269_3

					if var_269_3 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_3 + 0
					end
				end

				arg_266_1.text_.text = var_269_1
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_4 = math.max(var_269_0, arg_266_1.talkMaxDuration)

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_4 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - 0) / var_269_4

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= 0 + var_269_4 and arg_266_1.time_ < 0 + var_269_4 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play926082062 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 926082062
		arg_270_1.duration_ = 6.73

		local var_270_0 = {
			zh = 4.033,
			ja = 6.733
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
			arg_270_1.auto_ = false
		end

		function arg_270_1.playNext_(arg_272_0)
			arg_270_1.onStoryFinished_()
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["10144"]) and arg_270_1.var_.actorSpriteComps10144 == nil then
				arg_270_1.var_.actorSpriteComps10144 = arg_270_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_0 = 0.2

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["10144"]) then
				if arg_270_1.var_.actorSpriteComps10144 then
					for iter_273_0, iter_273_1 in pairs(arg_270_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_273_1 then
							if arg_270_1.isInRecall_ then
								iter_273_1.color = Color.New(Mathf.Lerp(iter_273_1.color.r, arg_270_1.hightColor1.r, (arg_270_1.time_ - 0) / var_273_0), Mathf.Lerp(iter_273_1.color.g, arg_270_1.hightColor1.g, (arg_270_1.time_ - 0) / var_273_0), (Mathf.Lerp(iter_273_1.color.b, arg_270_1.hightColor1.b, (arg_270_1.time_ - 0) / var_273_0)))
							else
								local var_273_1 = Mathf.Lerp(iter_273_1.color.r, 1, (arg_270_1.time_ - 0) / var_273_0)

								iter_273_1.color = Color.New(var_273_1, var_273_1, var_273_1)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["10144"]) and arg_270_1.var_.actorSpriteComps10144 then
				for iter_273_2, iter_273_3 in pairs(arg_270_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_273_3 then
						iter_273_3.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_270_1.var_.actorSpriteComps10144 = nil
			end

			local var_273_2 = arg_270_1.actors_["10144"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos10144 = var_273_2.localPosition
				var_273_2.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("10144", 3)

				for iter_273_4 = 0, var_273_2.childCount - 1 do
					local var_273_3 = var_273_2:GetChild(iter_273_4)

					if var_273_3.name == "split_4" or not string.find(var_273_3.name, "split") then
						var_273_3.gameObject:SetActive(true)
					else
						var_273_3.gameObject:SetActive(false)
					end
				end
			end

			local var_273_4 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				var_273_2.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_270_1.time_ - 0) / var_273_4)
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
				var_273_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_273_5 = 0
			local var_273_6 = 0.4

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_5 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_7 = arg_270_1:GetWordFromCfg(926082062)
				local var_273_8 = arg_270_1:FormatText(var_273_7.content)

				arg_270_1.text_.text = var_273_8

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_10 = 16 <= 0 and var_273_6 or var_273_6 * (utf8.len(var_273_8) / 16)

				if (16 <= 0 and var_273_6 or var_273_6 * (utf8.len(var_273_8) / 16)) > 0 and var_273_6 < var_273_10 then
					arg_270_1.talkMaxDuration = var_273_10

					if var_273_10 + var_273_5 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_10 + var_273_5
					end
				end

				arg_270_1.text_.text = var_273_8
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926082", "926082062", "story_v_out_926082.awb") ~= 0 then
					local var_273_11 = manager.audio:GetVoiceLength("story_v_out_926082", "926082062", "story_v_out_926082.awb") / 1000

					if var_273_11 + var_273_5 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_11 + var_273_5
					end

					if var_273_7.prefab_name ~= "" and arg_270_1.actors_[var_273_7.prefab_name] ~= nil then
						local var_273_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_7.prefab_name].transform, "story_v_out_926082", "926082062", "story_v_out_926082.awb")

						arg_270_1:RecordAudio("926082062", var_273_12)
						arg_270_1:RecordAudio("926082062", var_273_12)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_926082", "926082062", "story_v_out_926082.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_926082", "926082062", "story_v_out_926082.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_13 = math.max(var_273_6, arg_270_1.talkMaxDuration)

			if var_273_5 <= arg_270_1.time_ and arg_270_1.time_ < var_273_5 + var_273_13 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_5) / var_273_13

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_5 + var_273_13 and arg_270_1.time_ < var_273_5 + var_273_13 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
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
	assets = {
		"TextureConfig/Background/I20f",
		"TextureConfig/Background/STwhite",
		"SofdecAsset/activity/activity_4_3_08_402501_start.usm"
	},
	voices = {
		"story_v_out_926082.awb"
	},
	skipMarkers = {
		926082049
	}
}
