return {
	Play425042001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 425042001
		arg_1_1.duration_ = 3.4

		local var_1_0 = {
			zh = 3.066,
			ja = 3.4
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
				arg_1_0:Play425042002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I07 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I07")
				var_4_0.name = "I07"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I07 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I07

				arg_1_1.bgs_.I07.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I07" then
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

			local var_4_9 = "1012"

			if arg_1_1.actors_["1012"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1012")

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

			local var_4_12 = arg_1_1.actors_["1012"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1012 == nil then
				arg_1_1.var_.actorSpriteComps1012 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps1012 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 2) / var_4_13), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 2) / var_4_13), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 2) / var_4_13)))
							else
								local var_4_14 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 2) / var_4_13)

								iter_4_5.color = Color.New(var_4_14, var_4_14, var_4_14)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1012 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1012 = nil
			end

			local var_4_15 = arg_1_1.actors_["1012"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1012 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1012", 3)

				for iter_4_8 = 0, var_4_15.childCount - 1 do
					local var_4_16 = var_4_15:GetChild(iter_4_8)

					if var_4_16.name == "" or not string.find(var_4_16.name, "split") then
						var_4_16.gameObject:SetActive(true)
					else
						var_4_16.gameObject:SetActive(false)
					end
				end
			end

			local var_4_17 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_17 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1012, Vector3.New(0, -465, 300), (arg_1_1.time_ - 2) / var_4_17)
			end

			if arg_1_1.time_ >= 2 + var_4_17 and arg_1_1.time_ < 2 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(0, -465, 300)
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_142", "se_story_142_amb_commandroom", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 2
			local var_4_26 = 0.075

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(425042001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 3 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 3)

				if (3 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 3)) > 0 and var_4_26 < var_4_31 then
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

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042001", "story_v_out_425042.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_425042", "425042001", "story_v_out_425042.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_425042", "425042001", "story_v_out_425042.awb")

						arg_1_1:RecordAudio("425042001", var_4_33)
						arg_1_1:RecordAudio("425042001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_425042", "425042001", "story_v_out_425042.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_425042", "425042001", "story_v_out_425042.awb")
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
				actorName = "1012",
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
	Play425042002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 425042002
		arg_9_1.duration_ = 8.6

		local var_9_0 = {
			zh = 5.1,
			ja = 8.6
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
				arg_9_0:Play425042003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1012"]) and arg_9_1.var_.actorSpriteComps1012 == nil then
				arg_9_1.var_.actorSpriteComps1012 = arg_9_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_0 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1012"]) then
				if arg_9_1.var_.actorSpriteComps1012 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1012"]) and arg_9_1.var_.actorSpriteComps1012 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_12_3 then
						iter_12_3.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps1012 = nil
			end

			local var_12_2 = 0
			local var_12_3 = 0.65

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_2 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1430].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_4 = arg_9_1:GetWordFromCfg(425042002)
				local var_12_5 = arg_9_1:FormatText(var_12_4.content)

				arg_9_1.text_.text = var_12_5

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_7 = 26 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_5) / 26)

				if (26 <= 0 and var_12_3 or var_12_3 * (utf8.len(var_12_5) / 26)) > 0 and var_12_3 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_2
					end
				end

				arg_9_1.text_.text = var_12_5
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042002", "story_v_out_425042.awb") ~= 0 then
					local var_12_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042002", "story_v_out_425042.awb") / 1000

					if var_12_8 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_8 + var_12_2
					end

					if var_12_4.prefab_name ~= "" and arg_9_1.actors_[var_12_4.prefab_name] ~= nil then
						local var_12_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_4.prefab_name].transform, "story_v_out_425042", "425042002", "story_v_out_425042.awb")

						arg_9_1:RecordAudio("425042002", var_12_9)
						arg_9_1:RecordAudio("425042002", var_12_9)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_425042", "425042002", "story_v_out_425042.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_425042", "425042002", "story_v_out_425042.awb")
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

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play425042003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 425042003
		arg_13_1.duration_ = 4.8

		local var_13_0 = {
			zh = 4.433,
			ja = 4.8
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
				arg_13_0:Play425042004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1012"]) and arg_13_1.var_.actorSpriteComps1012 == nil then
				arg_13_1.var_.actorSpriteComps1012 = arg_13_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_0 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1012"]) then
				if arg_13_1.var_.actorSpriteComps1012 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								iter_16_1.color = Color.New(Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor1.r, (arg_13_1.time_ - 0) / var_16_0), Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor1.g, (arg_13_1.time_ - 0) / var_16_0), (Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor1.b, (arg_13_1.time_ - 0) / var_16_0)))
							else
								local var_16_1 = Mathf.Lerp(iter_16_1.color.r, 1, (arg_13_1.time_ - 0) / var_16_0)

								iter_16_1.color = Color.New(var_16_1, var_16_1, var_16_1)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1012"]) and arg_13_1.var_.actorSpriteComps1012 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_16_3 then
						iter_16_3.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps1012 = nil
			end

			local var_16_2 = arg_13_1.actors_["1012"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1012 = var_16_2.localPosition
				var_16_2.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1012", 3)

				for iter_16_4 = 0, var_16_2.childCount - 1 do
					local var_16_3 = var_16_2:GetChild(iter_16_4)

					if var_16_3.name == "" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_2.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1012, Vector3.New(0, -465, 300), (arg_13_1.time_ - 0) / var_16_4)
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_2.localPosition = Vector3.New(0, -465, 300)
			end

			local var_16_5 = 0
			local var_16_6 = 0.45

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_7 = arg_13_1:GetWordFromCfg(425042003)
				local var_16_8 = arg_13_1:FormatText(var_16_7.content)

				arg_13_1.text_.text = var_16_8

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 18 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 18)

				if (18 <= 0 and var_16_6 or var_16_6 * (utf8.len(var_16_8) / 18)) > 0 and var_16_6 < var_16_10 then
					arg_13_1.talkMaxDuration = var_16_10

					if var_16_10 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_8
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042003", "story_v_out_425042.awb") ~= 0 then
					local var_16_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042003", "story_v_out_425042.awb") / 1000

					if var_16_11 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_5
					end

					if var_16_7.prefab_name ~= "" and arg_13_1.actors_[var_16_7.prefab_name] ~= nil then
						local var_16_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_7.prefab_name].transform, "story_v_out_425042", "425042003", "story_v_out_425042.awb")

						arg_13_1:RecordAudio("425042003", var_16_12)
						arg_13_1:RecordAudio("425042003", var_16_12)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_425042", "425042003", "story_v_out_425042.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_425042", "425042003", "story_v_out_425042.awb")
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
				actorName = "1012",
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
	Play425042004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 425042004
		arg_17_1.duration_ = 4.73

		local var_17_0 = {
			zh = 4.233,
			ja = 4.733
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
				arg_17_0:Play425042005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1012"]) and arg_17_1.var_.actorSpriteComps1012 == nil then
				arg_17_1.var_.actorSpriteComps1012 = arg_17_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_20_0 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1012"]) then
				if arg_17_1.var_.actorSpriteComps1012 then
					for iter_20_0, iter_20_1 in pairs(arg_17_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1012"]) and arg_17_1.var_.actorSpriteComps1012 then
				for iter_20_2, iter_20_3 in pairs(arg_17_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_20_3 then
						iter_20_3.color = arg_17_1.isInRecall_ and (arg_17_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_17_1.var_.actorSpriteComps1012 = nil
			end

			local var_20_2 = 0
			local var_20_3 = 0.425

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1430].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_4 = arg_17_1:GetWordFromCfg(425042004)
				local var_20_5 = arg_17_1:FormatText(var_20_4.content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 17 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 17)

				if (17 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_5) / 17)) > 0 and var_20_3 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042004", "story_v_out_425042.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042004", "story_v_out_425042.awb") / 1000

					if var_20_8 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_2
					end

					if var_20_4.prefab_name ~= "" and arg_17_1.actors_[var_20_4.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_4.prefab_name].transform, "story_v_out_425042", "425042004", "story_v_out_425042.awb")

						arg_17_1:RecordAudio("425042004", var_20_9)
						arg_17_1:RecordAudio("425042004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_425042", "425042004", "story_v_out_425042.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_425042", "425042004", "story_v_out_425042.awb")
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
	Play425042005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 425042005
		arg_21_1.duration_ = 3.4

		local var_21_0 = {
			zh = 2.6,
			ja = 3.4
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
				arg_21_0:Play425042006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["1012"]) and arg_21_1.var_.actorSpriteComps1012 == nil then
				arg_21_1.var_.actorSpriteComps1012 = arg_21_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_0 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["1012"]) then
				if arg_21_1.var_.actorSpriteComps1012 then
					for iter_24_0, iter_24_1 in pairs(arg_21_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["1012"]) and arg_21_1.var_.actorSpriteComps1012 then
				for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_24_3 then
						iter_24_3.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps1012 = nil
			end

			local var_24_2 = arg_21_1.actors_["1012"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1012 = var_24_2.localPosition
				var_24_2.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1012", 3)

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
				var_24_2.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1012, Vector3.New(0, -465, 300), (arg_21_1.time_ - 0) / var_24_4)
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_2.localPosition = Vector3.New(0, -465, 300)
			end

			local var_24_5 = 0
			local var_24_6 = 0.2

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_7 = arg_21_1:GetWordFromCfg(425042005)
				local var_24_8 = arg_21_1:FormatText(var_24_7.content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 8 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 8)

				if (8 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_8) / 8)) > 0 and var_24_6 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042005", "story_v_out_425042.awb") ~= 0 then
					local var_24_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042005", "story_v_out_425042.awb") / 1000

					if var_24_11 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_11 + var_24_5
					end

					if var_24_7.prefab_name ~= "" and arg_21_1.actors_[var_24_7.prefab_name] ~= nil then
						local var_24_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_7.prefab_name].transform, "story_v_out_425042", "425042005", "story_v_out_425042.awb")

						arg_21_1:RecordAudio("425042005", var_24_12)
						arg_21_1:RecordAudio("425042005", var_24_12)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_425042", "425042005", "story_v_out_425042.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_425042", "425042005", "story_v_out_425042.awb")
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
				actorName = "1012",
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
	Play425042006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 425042006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play425042007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1012 = arg_25_1.actors_["1012"].transform.localPosition
				arg_25_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("1012", 7)

				for iter_28_0 = 0, arg_25_1.actors_["1012"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["1012"].transform:GetChild(iter_28_0)

					if var_28_0.name == "" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1012, Vector3.New(0, -2000, 300), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["1012"].transform.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_28_2 = 0
			local var_28_3 = 1.25

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(425042006).content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 50 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_4) / 50)

				if (50 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_4) / 50)) > 0 and var_28_3 < var_28_6 then
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

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play425042007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 425042007
		arg_29_1.duration_ = 7.87

		local var_29_0 = {
			zh = 6.1,
			ja = 7.866
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
				arg_29_0:Play425042008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1012"]) and arg_29_1.var_.actorSpriteComps1012 == nil then
				arg_29_1.var_.actorSpriteComps1012 = arg_29_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1012"]) then
				if arg_29_1.var_.actorSpriteComps1012 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1012"]) and arg_29_1.var_.actorSpriteComps1012 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps1012 = nil
			end

			local var_32_2 = arg_29_1.actors_["1012"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1012 = var_32_2.localPosition
				var_32_2.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1012", 3)

				for iter_32_4 = 0, var_32_2.childCount - 1 do
					local var_32_3 = var_32_2:GetChild(iter_32_4)

					if var_32_3.name == "" or not string.find(var_32_3.name, "split") then
						var_32_3.gameObject:SetActive(true)
					else
						var_32_3.gameObject:SetActive(false)
					end
				end
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_2.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1012, Vector3.New(0, -465, 300), (arg_29_1.time_ - 0) / var_32_4)
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_2.localPosition = Vector3.New(0, -465, 300)
			end

			local var_32_5 = 0
			local var_32_6 = 0.775

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_7 = arg_29_1:GetWordFromCfg(425042007)
				local var_32_8 = arg_29_1:FormatText(var_32_7.content)

				arg_29_1.text_.text = var_32_8

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_10 = 31 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 31)

				if (31 <= 0 and var_32_6 or var_32_6 * (utf8.len(var_32_8) / 31)) > 0 and var_32_6 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_5
					end
				end

				arg_29_1.text_.text = var_32_8
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042007", "story_v_out_425042.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042007", "story_v_out_425042.awb") / 1000

					if var_32_11 + var_32_5 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_5
					end

					if var_32_7.prefab_name ~= "" and arg_29_1.actors_[var_32_7.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_7.prefab_name].transform, "story_v_out_425042", "425042007", "story_v_out_425042.awb")

						arg_29_1:RecordAudio("425042007", var_32_12)
						arg_29_1:RecordAudio("425042007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_425042", "425042007", "story_v_out_425042.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_425042", "425042007", "story_v_out_425042.awb")
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

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play425042008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 425042008
		arg_33_1.duration_ = 13.53

		local var_33_0 = {
			zh = 5.8,
			ja = 13.533
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
				arg_33_0:Play425042009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.7

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(425042008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 28 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 28)

				if (28 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 28)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042008", "story_v_out_425042.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042008", "story_v_out_425042.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_425042", "425042008", "story_v_out_425042.awb")

						arg_33_1:RecordAudio("425042008", var_36_6)
						arg_33_1:RecordAudio("425042008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_425042", "425042008", "story_v_out_425042.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_425042", "425042008", "story_v_out_425042.awb")
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
	Play425042009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 425042009
		arg_37_1.duration_ = 12.5

		local var_37_0 = {
			zh = 9.366,
			ja = 12.5
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
				arg_37_0:Play425042010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1012 = arg_37_1.actors_["1012"].transform.localPosition
				arg_37_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1012", 3)

				for iter_40_0 = 0, arg_37_1.actors_["1012"].transform.childCount - 1 do
					local var_40_0 = arg_37_1.actors_["1012"].transform:GetChild(iter_40_0)

					if var_40_0.name == "" or not string.find(var_40_0.name, "split") then
						var_40_0.gameObject:SetActive(true)
					else
						var_40_0.gameObject:SetActive(false)
					end
				end
			end

			local var_40_1 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_1 then
				arg_37_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1012, Vector3.New(0, -465, 300), (arg_37_1.time_ - 0) / var_40_1)
			end

			if arg_37_1.time_ >= 0 + var_40_1 and arg_37_1.time_ < 0 + var_40_1 + arg_40_0 then
				arg_37_1.actors_["1012"].transform.localPosition = Vector3.New(0, -465, 300)
			end

			local var_40_2 = 0
			local var_40_3 = 0.95

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_2 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_4 = arg_37_1:GetWordFromCfg(425042009)
				local var_40_5 = arg_37_1:FormatText(var_40_4.content)

				arg_37_1.text_.text = var_40_5

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_7 = 38 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 38)

				if (38 <= 0 and var_40_3 or var_40_3 * (utf8.len(var_40_5) / 38)) > 0 and var_40_3 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_2
					end
				end

				arg_37_1.text_.text = var_40_5
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042009", "story_v_out_425042.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042009", "story_v_out_425042.awb") / 1000

					if var_40_8 + var_40_2 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_2
					end

					if var_40_4.prefab_name ~= "" and arg_37_1.actors_[var_40_4.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_4.prefab_name].transform, "story_v_out_425042", "425042009", "story_v_out_425042.awb")

						arg_37_1:RecordAudio("425042009", var_40_9)
						arg_37_1:RecordAudio("425042009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_425042", "425042009", "story_v_out_425042.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_425042", "425042009", "story_v_out_425042.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_3, arg_37_1.talkMaxDuration)

			if var_40_2 <= arg_37_1.time_ and arg_37_1.time_ < var_40_2 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_2) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_2 + var_40_10 and arg_37_1.time_ < var_40_2 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play425042010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 425042010
		arg_41_1.duration_ = 3.23

		local var_41_0 = {
			zh = 3.233,
			ja = 3.1
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
				arg_41_0:Play425042011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if arg_41_1.actors_["1137"] == nil then
				local var_44_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1137")

				if not isNil(var_44_0) then
					local var_44_1 = Object.Instantiate(var_44_0, arg_41_1.canvasGo_.transform)

					var_44_1.transform:SetSiblingIndex(1)

					var_44_1.name = "1137"
					var_44_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_41_1.actors_["1137"] = var_44_1

					if arg_41_1.isInRecall_ then
						for iter_44_0, iter_44_1 in ipairs((var_44_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_44_1.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_44_2 = arg_41_1.actors_["1137"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps1137 == nil then
				arg_41_1.var_.actorSpriteComps1137 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps1137 then
					for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_44_3 then
							if arg_41_1.isInRecall_ then
								iter_44_3.color = Color.New(Mathf.Lerp(iter_44_3.color.r, arg_41_1.hightColor1.r, (arg_41_1.time_ - 0) / var_44_3), Mathf.Lerp(iter_44_3.color.g, arg_41_1.hightColor1.g, (arg_41_1.time_ - 0) / var_44_3), (Mathf.Lerp(iter_44_3.color.b, arg_41_1.hightColor1.b, (arg_41_1.time_ - 0) / var_44_3)))
							else
								local var_44_4 = Mathf.Lerp(iter_44_3.color.r, 1, (arg_41_1.time_ - 0) / var_44_3)

								iter_44_3.color = Color.New(var_44_4, var_44_4, var_44_4)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps1137 then
				for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_44_5 then
						iter_44_5.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps1137 = nil
			end

			local var_44_5 = arg_41_1.actors_["1012"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.actorSpriteComps1012 == nil then
				arg_41_1.var_.actorSpriteComps1012 = var_44_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_6 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 and not isNil(var_44_5) then
				if arg_41_1.var_.actorSpriteComps1012 then
					for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_44_7 then
							if arg_41_1.isInRecall_ then
								iter_44_7.color = Color.New(Mathf.Lerp(iter_44_7.color.r, arg_41_1.hightColor2.r, (arg_41_1.time_ - 0) / var_44_6), Mathf.Lerp(iter_44_7.color.g, arg_41_1.hightColor2.g, (arg_41_1.time_ - 0) / var_44_6), (Mathf.Lerp(iter_44_7.color.b, arg_41_1.hightColor2.b, (arg_41_1.time_ - 0) / var_44_6)))
							else
								local var_44_7 = Mathf.Lerp(iter_44_7.color.r, 0.5, (arg_41_1.time_ - 0) / var_44_6)

								iter_44_7.color = Color.New(var_44_7, var_44_7, var_44_7)
							end
						end
					end
				end
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.actorSpriteComps1012 then
				for iter_44_8, iter_44_9 in pairs(arg_41_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_44_9 then
						iter_44_9.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps1012 = nil
			end

			local var_44_8 = arg_41_1.actors_["1137"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1137 = var_44_8.localPosition
				var_44_8.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1137", 4)

				for iter_44_10 = 0, var_44_8.childCount - 1 do
					local var_44_9 = var_44_8:GetChild(iter_44_10)

					if var_44_9.name == "split_5" or not string.find(var_44_9.name, "split") then
						var_44_9.gameObject:SetActive(true)
					else
						var_44_9.gameObject:SetActive(false)
					end
				end
			end

			local var_44_10 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_10 then
				var_44_8.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_41_1.time_ - 0) / var_44_10)
			end

			if arg_41_1.time_ >= 0 + var_44_10 and arg_41_1.time_ < 0 + var_44_10 + arg_44_0 then
				var_44_8.localPosition = Vector3.New(390, -425, -200)
			end

			local var_44_11 = arg_41_1.actors_["1012"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1012 = var_44_11.localPosition
				var_44_11.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("1012", 2)

				for iter_44_11 = 0, var_44_11.childCount - 1 do
					local var_44_12 = var_44_11:GetChild(iter_44_11)

					if var_44_12.name == "" or not string.find(var_44_12.name, "split") then
						var_44_12.gameObject:SetActive(true)
					else
						var_44_12.gameObject:SetActive(false)
					end
				end
			end

			local var_44_13 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_13 then
				var_44_11.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_41_1.time_ - 0) / var_44_13)
			end

			if arg_41_1.time_ >= 0 + var_44_13 and arg_41_1.time_ < 0 + var_44_13 + arg_44_0 then
				var_44_11.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_44_14 = 0
			local var_44_15 = 0.175

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_16 = arg_41_1:GetWordFromCfg(425042010)
				local var_44_17 = arg_41_1:FormatText(var_44_16.content)

				arg_41_1.text_.text = var_44_17

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_19 = 7 <= 0 and var_44_15 or var_44_15 * (utf8.len(var_44_17) / 7)

				if (7 <= 0 and var_44_15 or var_44_15 * (utf8.len(var_44_17) / 7)) > 0 and var_44_15 < var_44_19 then
					arg_41_1.talkMaxDuration = var_44_19

					if var_44_19 + var_44_14 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_14
					end
				end

				arg_41_1.text_.text = var_44_17
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042010", "story_v_out_425042.awb") ~= 0 then
					local var_44_20 = manager.audio:GetVoiceLength("story_v_out_425042", "425042010", "story_v_out_425042.awb") / 1000

					if var_44_20 + var_44_14 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_20 + var_44_14
					end

					if var_44_16.prefab_name ~= "" and arg_41_1.actors_[var_44_16.prefab_name] ~= nil then
						local var_44_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_16.prefab_name].transform, "story_v_out_425042", "425042010", "story_v_out_425042.awb")

						arg_41_1:RecordAudio("425042010", var_44_21)
						arg_41_1:RecordAudio("425042010", var_44_21)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_425042", "425042010", "story_v_out_425042.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_425042", "425042010", "story_v_out_425042.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_22 = math.max(var_44_15, arg_41_1.talkMaxDuration)

			if var_44_14 <= arg_41_1.time_ and arg_41_1.time_ < var_44_14 + var_44_22 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_14) / var_44_22

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_14 + var_44_22 and arg_41_1.time_ < var_44_14 + var_44_22 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
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

		arg_41_1:InitPlayNodeList()
	end,
	Play425042011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 425042011
		arg_45_1.duration_ = 20.97

		local var_45_0 = {
			zh = 12.066,
			ja = 20.966
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
				arg_45_0:Play425042012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1012"]) and arg_45_1.var_.actorSpriteComps1012 == nil then
				arg_45_1.var_.actorSpriteComps1012 = arg_45_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1012"]) then
				if arg_45_1.var_.actorSpriteComps1012 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1012"]) and arg_45_1.var_.actorSpriteComps1012 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps1012 = nil
			end

			local var_48_2 = arg_45_1.actors_["1137"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps1137 == nil then
				arg_45_1.var_.actorSpriteComps1137 = var_48_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_3 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.actorSpriteComps1137 then
					for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_48_5 then
							if arg_45_1.isInRecall_ then
								iter_48_5.color = Color.New(Mathf.Lerp(iter_48_5.color.r, arg_45_1.hightColor2.r, (arg_45_1.time_ - 0) / var_48_3), Mathf.Lerp(iter_48_5.color.g, arg_45_1.hightColor2.g, (arg_45_1.time_ - 0) / var_48_3), (Mathf.Lerp(iter_48_5.color.b, arg_45_1.hightColor2.b, (arg_45_1.time_ - 0) / var_48_3)))
							else
								local var_48_4 = Mathf.Lerp(iter_48_5.color.r, 0.5, (arg_45_1.time_ - 0) / var_48_3)

								iter_48_5.color = Color.New(var_48_4, var_48_4, var_48_4)
							end
						end
					end
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps1137 then
				for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_48_7 then
						iter_48_7.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps1137 = nil
			end

			local var_48_5 = arg_45_1.actors_["1012"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1012 = var_48_5.localPosition
				var_48_5.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("1012", 2)

				for iter_48_8 = 0, var_48_5.childCount - 1 do
					local var_48_6 = var_48_5:GetChild(iter_48_8)

					if var_48_6.name == "" or not string.find(var_48_6.name, "split") then
						var_48_6.gameObject:SetActive(true)
					else
						var_48_6.gameObject:SetActive(false)
					end
				end
			end

			local var_48_7 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				var_48_5.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_45_1.time_ - 0) / var_48_7)
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				var_48_5.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_48_8 = 0
			local var_48_9 = 1.45

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_8 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_10 = arg_45_1:GetWordFromCfg(425042011)
				local var_48_11 = arg_45_1:FormatText(var_48_10.content)

				arg_45_1.text_.text = var_48_11

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_13 = 58 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 58)

				if (58 <= 0 and var_48_9 or var_48_9 * (utf8.len(var_48_11) / 58)) > 0 and var_48_9 < var_48_13 then
					arg_45_1.talkMaxDuration = var_48_13

					if var_48_13 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_13 + var_48_8
					end
				end

				arg_45_1.text_.text = var_48_11
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042011", "story_v_out_425042.awb") ~= 0 then
					local var_48_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042011", "story_v_out_425042.awb") / 1000

					if var_48_14 + var_48_8 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_14 + var_48_8
					end

					if var_48_10.prefab_name ~= "" and arg_45_1.actors_[var_48_10.prefab_name] ~= nil then
						local var_48_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_10.prefab_name].transform, "story_v_out_425042", "425042011", "story_v_out_425042.awb")

						arg_45_1:RecordAudio("425042011", var_48_15)
						arg_45_1:RecordAudio("425042011", var_48_15)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_425042", "425042011", "story_v_out_425042.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_425042", "425042011", "story_v_out_425042.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_16 = math.max(var_48_9, arg_45_1.talkMaxDuration)

			if var_48_8 <= arg_45_1.time_ and arg_45_1.time_ < var_48_8 + var_48_16 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_8) / var_48_16

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_8 + var_48_16 and arg_45_1.time_ < var_48_8 + var_48_16 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play425042012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 425042012
		arg_49_1.duration_ = 13.13

		local var_49_0 = {
			zh = 10.333,
			ja = 13.133
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
				arg_49_0:Play425042013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos1012 = arg_49_1.actors_["1012"].transform.localPosition
				arg_49_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_49_1:CheckSpriteTmpPos("1012", 2)

				for iter_52_0 = 0, arg_49_1.actors_["1012"].transform.childCount - 1 do
					local var_52_0 = arg_49_1.actors_["1012"].transform:GetChild(iter_52_0)

					if var_52_0.name == "" or not string.find(var_52_0.name, "split") then
						var_52_0.gameObject:SetActive(true)
					else
						var_52_0.gameObject:SetActive(false)
					end
				end
			end

			local var_52_1 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_1 then
				arg_49_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_49_1.time_ - 0) / var_52_1)
			end

			if arg_49_1.time_ >= 0 + var_52_1 and arg_49_1.time_ < 0 + var_52_1 + arg_52_0 then
				arg_49_1.actors_["1012"].transform.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_52_2 = 0
			local var_52_3 = 1.4

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_2 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(425042012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_7 = 56 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 56)

				if (56 <= 0 and var_52_3 or var_52_3 * (utf8.len(var_52_5) / 56)) > 0 and var_52_3 < var_52_7 then
					arg_49_1.talkMaxDuration = var_52_7

					if var_52_7 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_7 + var_52_2
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042012", "story_v_out_425042.awb") ~= 0 then
					local var_52_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042012", "story_v_out_425042.awb") / 1000

					if var_52_8 + var_52_2 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_2
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_out_425042", "425042012", "story_v_out_425042.awb")

						arg_49_1:RecordAudio("425042012", var_52_9)
						arg_49_1:RecordAudio("425042012", var_52_9)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_425042", "425042012", "story_v_out_425042.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_425042", "425042012", "story_v_out_425042.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_10 = math.max(var_52_3, arg_49_1.talkMaxDuration)

			if var_52_2 <= arg_49_1.time_ and arg_49_1.time_ < var_52_2 + var_52_10 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_2) / var_52_10

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_2 + var_52_10 and arg_49_1.time_ < var_52_2 + var_52_10 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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

		arg_49_1:InitPlayNodeList()
	end,
	Play425042013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 425042013
		arg_53_1.duration_ = 5.7

		local var_53_0 = {
			zh = 4.466,
			ja = 5.7
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
				arg_53_0:Play425042014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1012"]) and arg_53_1.var_.actorSpriteComps1012 == nil then
				arg_53_1.var_.actorSpriteComps1012 = arg_53_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_56_0 = 0.2

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1012"]) then
				if arg_53_1.var_.actorSpriteComps1012 then
					for iter_56_0, iter_56_1 in pairs(arg_53_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_56_1 then
							if arg_53_1.isInRecall_ then
								iter_56_1.color = Color.New(Mathf.Lerp(iter_56_1.color.r, arg_53_1.hightColor2.r, (arg_53_1.time_ - 0) / var_56_0), Mathf.Lerp(iter_56_1.color.g, arg_53_1.hightColor2.g, (arg_53_1.time_ - 0) / var_56_0), (Mathf.Lerp(iter_56_1.color.b, arg_53_1.hightColor2.b, (arg_53_1.time_ - 0) / var_56_0)))
							else
								local var_56_1 = Mathf.Lerp(iter_56_1.color.r, 0.5, (arg_53_1.time_ - 0) / var_56_0)

								iter_56_1.color = Color.New(var_56_1, var_56_1, var_56_1)
							end
						end
					end
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1012"]) and arg_53_1.var_.actorSpriteComps1012 then
				for iter_56_2, iter_56_3 in pairs(arg_53_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_56_3 then
						iter_56_3.color = arg_53_1.isInRecall_ and (arg_53_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_53_1.var_.actorSpriteComps1012 = nil
			end

			local var_56_2 = 0
			local var_56_3 = 0.45

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_2 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1430].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, true)
				arg_53_1.iconController_:SetSelectedState("hero")

				arg_53_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_53_1.callingController_:SetSelectedState("normal")

				arg_53_1.keyicon_.color = Color.New(1, 1, 1)
				arg_53_1.icon_.color = Color.New(1, 1, 1)

				local var_56_4 = arg_53_1:GetWordFromCfg(425042013)
				local var_56_5 = arg_53_1:FormatText(var_56_4.content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 18 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 18)

				if (18 <= 0 and var_56_3 or var_56_3 * (utf8.len(var_56_5) / 18)) > 0 and var_56_3 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_2
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042013", "story_v_out_425042.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042013", "story_v_out_425042.awb") / 1000

					if var_56_8 + var_56_2 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_2
					end

					if var_56_4.prefab_name ~= "" and arg_53_1.actors_[var_56_4.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_4.prefab_name].transform, "story_v_out_425042", "425042013", "story_v_out_425042.awb")

						arg_53_1:RecordAudio("425042013", var_56_9)
						arg_53_1:RecordAudio("425042013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_425042", "425042013", "story_v_out_425042.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_425042", "425042013", "story_v_out_425042.awb")
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

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play425042014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 425042014
		arg_57_1.duration_ = 6.67

		local var_57_0 = {
			zh = 4.766,
			ja = 6.666
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
				arg_57_0:Play425042015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["1012"]) and arg_57_1.var_.actorSpriteComps1012 == nil then
				arg_57_1.var_.actorSpriteComps1012 = arg_57_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["1012"]) then
				if arg_57_1.var_.actorSpriteComps1012 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								iter_60_1.color = Color.New(Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor1.r, (arg_57_1.time_ - 0) / var_60_0), Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor1.g, (arg_57_1.time_ - 0) / var_60_0), (Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor1.b, (arg_57_1.time_ - 0) / var_60_0)))
							else
								local var_60_1 = Mathf.Lerp(iter_60_1.color.r, 1, (arg_57_1.time_ - 0) / var_60_0)

								iter_60_1.color = Color.New(var_60_1, var_60_1, var_60_1)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["1012"]) and arg_57_1.var_.actorSpriteComps1012 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_57_1.var_.actorSpriteComps1012 = nil
			end

			local var_60_2 = arg_57_1.actors_["1012"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1012 = var_60_2.localPosition
				var_60_2.localScale = Vector3.New(1, 1, 1)

				arg_57_1:CheckSpriteTmpPos("1012", 2)

				for iter_60_4 = 0, var_60_2.childCount - 1 do
					local var_60_3 = var_60_2:GetChild(iter_60_4)

					if var_60_3.name == "split_4" or not string.find(var_60_3.name, "split") then
						var_60_3.gameObject:SetActive(true)
					else
						var_60_3.gameObject:SetActive(false)
					end
				end
			end

			local var_60_4 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				var_60_2.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_57_1.time_ - 0) / var_60_4)
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				var_60_2.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_60_5 = 0
			local var_60_6 = 0.575

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_7 = arg_57_1:GetWordFromCfg(425042014)
				local var_60_8 = arg_57_1:FormatText(var_60_7.content)

				arg_57_1.text_.text = var_60_8

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_10 = 23 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 23)

				if (23 <= 0 and var_60_6 or var_60_6 * (utf8.len(var_60_8) / 23)) > 0 and var_60_6 < var_60_10 then
					arg_57_1.talkMaxDuration = var_60_10

					if var_60_10 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_5
					end
				end

				arg_57_1.text_.text = var_60_8
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042014", "story_v_out_425042.awb") ~= 0 then
					local var_60_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042014", "story_v_out_425042.awb") / 1000

					if var_60_11 + var_60_5 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_11 + var_60_5
					end

					if var_60_7.prefab_name ~= "" and arg_57_1.actors_[var_60_7.prefab_name] ~= nil then
						local var_60_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_7.prefab_name].transform, "story_v_out_425042", "425042014", "story_v_out_425042.awb")

						arg_57_1:RecordAudio("425042014", var_60_12)
						arg_57_1:RecordAudio("425042014", var_60_12)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_425042", "425042014", "story_v_out_425042.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_425042", "425042014", "story_v_out_425042.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_13 = math.max(var_60_6, arg_57_1.talkMaxDuration)

			if var_60_5 <= arg_57_1.time_ and arg_57_1.time_ < var_60_5 + var_60_13 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_5) / var_60_13

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_5 + var_60_13 and arg_57_1.time_ < var_60_5 + var_60_13 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play425042015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 425042015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play425042016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1012 = arg_61_1.actors_["1012"].transform.localPosition
				arg_61_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1012", 7)

				for iter_64_0 = 0, arg_61_1.actors_["1012"].transform.childCount - 1 do
					local var_64_0 = arg_61_1.actors_["1012"].transform:GetChild(iter_64_0)

					if var_64_0.name == "" or not string.find(var_64_0.name, "split") then
						var_64_0.gameObject:SetActive(true)
					else
						var_64_0.gameObject:SetActive(false)
					end
				end
			end

			local var_64_1 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_1 then
				arg_61_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1012, Vector3.New(0, -2000, 300), (arg_61_1.time_ - 0) / var_64_1)
			end

			if arg_61_1.time_ >= 0 + var_64_1 and arg_61_1.time_ < 0 + var_64_1 + arg_64_0 then
				arg_61_1.actors_["1012"].transform.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_64_2 = arg_61_1.actors_["1137"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1137 = var_64_2.localPosition
				var_64_2.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("1137", 7)

				for iter_64_1 = 0, var_64_2.childCount - 1 do
					local var_64_3 = var_64_2:GetChild(iter_64_1)

					if var_64_3.name == "" or not string.find(var_64_3.name, "split") then
						var_64_3.gameObject:SetActive(true)
					else
						var_64_3.gameObject:SetActive(false)
					end
				end
			end

			local var_64_4 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				var_64_2.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_61_1.time_ - 0) / var_64_4)
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				var_64_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.1 < arg_61_1.time_ and arg_61_1.time_ <= 0.1 + arg_64_0 then
				arg_61_1:AudioAction("play", "effect", "se_story_140", "se_story_140_surround", "")
			end

			local var_64_6 = 0
			local var_64_7 = 0.85

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(425042015).content)

				arg_61_1.text_.text = var_64_8

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_10 = 34 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_8) / 34)

				if (34 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_8) / 34)) > 0 and var_64_7 < var_64_10 then
					arg_61_1.talkMaxDuration = var_64_10

					if var_64_10 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_8
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_11 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_11 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_11

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_11 and arg_61_1.time_ < var_64_6 + var_64_11 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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
				actorName = "1137",
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
	Play425042016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 425042016
		arg_65_1.duration_ = 3.73

		local var_65_0 = {
			zh = 2.3,
			ja = 3.733
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
				arg_65_0:Play425042017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1012"]) and arg_65_1.var_.actorSpriteComps1012 == nil then
				arg_65_1.var_.actorSpriteComps1012 = arg_65_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1012"]) then
				if arg_65_1.var_.actorSpriteComps1012 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_68_1 then
							if arg_65_1.isInRecall_ then
								iter_68_1.color = Color.New(Mathf.Lerp(iter_68_1.color.r, arg_65_1.hightColor1.r, (arg_65_1.time_ - 0) / var_68_0), Mathf.Lerp(iter_68_1.color.g, arg_65_1.hightColor1.g, (arg_65_1.time_ - 0) / var_68_0), (Mathf.Lerp(iter_68_1.color.b, arg_65_1.hightColor1.b, (arg_65_1.time_ - 0) / var_68_0)))
							else
								local var_68_1 = Mathf.Lerp(iter_68_1.color.r, 1, (arg_65_1.time_ - 0) / var_68_0)

								iter_68_1.color = Color.New(var_68_1, var_68_1, var_68_1)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1012"]) and arg_65_1.var_.actorSpriteComps1012 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps1012 = nil
			end

			local var_68_2 = arg_65_1.actors_["1012"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1012 = var_68_2.localPosition
				var_68_2.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("1012", 2)

				for iter_68_4 = 0, var_68_2.childCount - 1 do
					local var_68_3 = var_68_2:GetChild(iter_68_4)

					if var_68_3.name == "" or not string.find(var_68_3.name, "split") then
						var_68_3.gameObject:SetActive(true)
					else
						var_68_3.gameObject:SetActive(false)
					end
				end
			end

			local var_68_4 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				var_68_2.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_65_1.time_ - 0) / var_68_4)
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				var_68_2.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_68_5 = 0
			local var_68_6 = 0.3

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:GetWordFromCfg(425042016)
				local var_68_8 = arg_65_1:FormatText(var_68_7.content)

				arg_65_1.text_.text = var_68_8

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_10 = 12 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 12)

				if (12 <= 0 and var_68_6 or var_68_6 * (utf8.len(var_68_8) / 12)) > 0 and var_68_6 < var_68_10 then
					arg_65_1.talkMaxDuration = var_68_10

					if var_68_10 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_5
					end
				end

				arg_65_1.text_.text = var_68_8
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042016", "story_v_out_425042.awb") ~= 0 then
					local var_68_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042016", "story_v_out_425042.awb") / 1000

					if var_68_11 + var_68_5 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_5
					end

					if var_68_7.prefab_name ~= "" and arg_65_1.actors_[var_68_7.prefab_name] ~= nil then
						local var_68_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_7.prefab_name].transform, "story_v_out_425042", "425042016", "story_v_out_425042.awb")

						arg_65_1:RecordAudio("425042016", var_68_12)
						arg_65_1:RecordAudio("425042016", var_68_12)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_425042", "425042016", "story_v_out_425042.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_425042", "425042016", "story_v_out_425042.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_13 = math.max(var_68_6, arg_65_1.talkMaxDuration)

			if var_68_5 <= arg_65_1.time_ and arg_65_1.time_ < var_68_5 + var_68_13 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_5) / var_68_13

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_5 + var_68_13 and arg_65_1.time_ < var_68_5 + var_68_13 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play425042017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 425042017
		arg_69_1.duration_ = 1.3

		local var_69_0 = {
			zh = 1.3,
			ja = 1
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
				arg_69_0:Play425042018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1137"]) and arg_69_1.var_.actorSpriteComps1137 == nil then
				arg_69_1.var_.actorSpriteComps1137 = arg_69_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_0 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1137"]) then
				if arg_69_1.var_.actorSpriteComps1137 then
					for iter_72_0, iter_72_1 in pairs(arg_69_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1137"]) and arg_69_1.var_.actorSpriteComps1137 then
				for iter_72_2, iter_72_3 in pairs(arg_69_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_72_3 then
						iter_72_3.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_69_1.var_.actorSpriteComps1137 = nil
			end

			local var_72_2 = arg_69_1.actors_["1012"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps1012 == nil then
				arg_69_1.var_.actorSpriteComps1012 = var_72_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_72_3 = 0.2

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.actorSpriteComps1012 then
					for iter_72_4, iter_72_5 in pairs(arg_69_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_72_5 then
							if arg_69_1.isInRecall_ then
								iter_72_5.color = Color.New(Mathf.Lerp(iter_72_5.color.r, arg_69_1.hightColor2.r, (arg_69_1.time_ - 0) / var_72_3), Mathf.Lerp(iter_72_5.color.g, arg_69_1.hightColor2.g, (arg_69_1.time_ - 0) / var_72_3), (Mathf.Lerp(iter_72_5.color.b, arg_69_1.hightColor2.b, (arg_69_1.time_ - 0) / var_72_3)))
							else
								local var_72_4 = Mathf.Lerp(iter_72_5.color.r, 0.5, (arg_69_1.time_ - 0) / var_72_3)

								iter_72_5.color = Color.New(var_72_4, var_72_4, var_72_4)
							end
						end
					end
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.actorSpriteComps1012 then
				for iter_72_6, iter_72_7 in pairs(arg_69_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_72_7 then
						iter_72_7.color = arg_69_1.isInRecall_ and (arg_69_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_69_1.var_.actorSpriteComps1012 = nil
			end

			local var_72_5 = arg_69_1.actors_["1137"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1137 = var_72_5.localPosition
				var_72_5.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("1137", 4)

				for iter_72_8 = 0, var_72_5.childCount - 1 do
					local var_72_6 = var_72_5:GetChild(iter_72_8)

					if var_72_6.name == "split_5" or not string.find(var_72_6.name, "split") then
						var_72_6.gameObject:SetActive(true)
					else
						var_72_6.gameObject:SetActive(false)
					end
				end
			end

			local var_72_7 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_7 then
				var_72_5.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_69_1.time_ - 0) / var_72_7)
			end

			if arg_69_1.time_ >= 0 + var_72_7 and arg_69_1.time_ < 0 + var_72_7 + arg_72_0 then
				var_72_5.localPosition = Vector3.New(390, -425, -200)
			end

			local var_72_8 = 0
			local var_72_9 = 0.125

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_8 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_10 = arg_69_1:GetWordFromCfg(425042017)
				local var_72_11 = arg_69_1:FormatText(var_72_10.content)

				arg_69_1.text_.text = var_72_11

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_13 = 5 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 5)

				if (5 <= 0 and var_72_9 or var_72_9 * (utf8.len(var_72_11) / 5)) > 0 and var_72_9 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_8
					end
				end

				arg_69_1.text_.text = var_72_11
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042017", "story_v_out_425042.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042017", "story_v_out_425042.awb") / 1000

					if var_72_14 + var_72_8 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_8
					end

					if var_72_10.prefab_name ~= "" and arg_69_1.actors_[var_72_10.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_10.prefab_name].transform, "story_v_out_425042", "425042017", "story_v_out_425042.awb")

						arg_69_1:RecordAudio("425042017", var_72_15)
						arg_69_1:RecordAudio("425042017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_425042", "425042017", "story_v_out_425042.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_425042", "425042017", "story_v_out_425042.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_9, arg_69_1.talkMaxDuration)

			if var_72_8 <= arg_69_1.time_ and arg_69_1.time_ < var_72_8 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_8) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_8 + var_72_16 and arg_69_1.time_ < var_72_8 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
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
	Play425042018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 425042018
		arg_73_1.duration_ = 7.37

		local var_73_0 = {
			zh = 3.933,
			ja = 7.366
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
				arg_73_0:Play425042019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1012"]) and arg_73_1.var_.actorSpriteComps1012 == nil then
				arg_73_1.var_.actorSpriteComps1012 = arg_73_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1012"]) then
				if arg_73_1.var_.actorSpriteComps1012 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_76_1 then
							if arg_73_1.isInRecall_ then
								iter_76_1.color = Color.New(Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 0) / var_76_0), Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 0) / var_76_0), (Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 0) / var_76_0)))
							else
								local var_76_1 = Mathf.Lerp(iter_76_1.color.r, 1, (arg_73_1.time_ - 0) / var_76_0)

								iter_76_1.color = Color.New(var_76_1, var_76_1, var_76_1)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1012"]) and arg_73_1.var_.actorSpriteComps1012 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps1012 = nil
			end

			local var_76_2 = arg_73_1.actors_["1137"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps1137 == nil then
				arg_73_1.var_.actorSpriteComps1137 = var_76_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_3 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_3 and not isNil(var_76_2) then
				if arg_73_1.var_.actorSpriteComps1137 then
					for iter_76_4, iter_76_5 in pairs(arg_73_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_76_5 then
							if arg_73_1.isInRecall_ then
								iter_76_5.color = Color.New(Mathf.Lerp(iter_76_5.color.r, arg_73_1.hightColor2.r, (arg_73_1.time_ - 0) / var_76_3), Mathf.Lerp(iter_76_5.color.g, arg_73_1.hightColor2.g, (arg_73_1.time_ - 0) / var_76_3), (Mathf.Lerp(iter_76_5.color.b, arg_73_1.hightColor2.b, (arg_73_1.time_ - 0) / var_76_3)))
							else
								local var_76_4 = Mathf.Lerp(iter_76_5.color.r, 0.5, (arg_73_1.time_ - 0) / var_76_3)

								iter_76_5.color = Color.New(var_76_4, var_76_4, var_76_4)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_3 and arg_73_1.time_ < 0 + var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.actorSpriteComps1137 then
				for iter_76_6, iter_76_7 in pairs(arg_73_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_76_7 then
						iter_76_7.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps1137 = nil
			end

			local var_76_5 = arg_73_1.actors_["1012"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1012 = var_76_5.localPosition
				var_76_5.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("1012", 2)

				for iter_76_8 = 0, var_76_5.childCount - 1 do
					local var_76_6 = var_76_5:GetChild(iter_76_8)

					if var_76_6.name == "" or not string.find(var_76_6.name, "split") then
						var_76_6.gameObject:SetActive(true)
					else
						var_76_6.gameObject:SetActive(false)
					end
				end
			end

			local var_76_7 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				var_76_5.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_73_1.time_ - 0) / var_76_7)
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				var_76_5.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_76_8 = 0
			local var_76_9 = 0.575

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_8 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_10 = arg_73_1:GetWordFromCfg(425042018)
				local var_76_11 = arg_73_1:FormatText(var_76_10.content)

				arg_73_1.text_.text = var_76_11

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_13 = 23 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 23)

				if (23 <= 0 and var_76_9 or var_76_9 * (utf8.len(var_76_11) / 23)) > 0 and var_76_9 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_8
					end
				end

				arg_73_1.text_.text = var_76_11
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042018", "story_v_out_425042.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042018", "story_v_out_425042.awb") / 1000

					if var_76_14 + var_76_8 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_8
					end

					if var_76_10.prefab_name ~= "" and arg_73_1.actors_[var_76_10.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_10.prefab_name].transform, "story_v_out_425042", "425042018", "story_v_out_425042.awb")

						arg_73_1:RecordAudio("425042018", var_76_15)
						arg_73_1:RecordAudio("425042018", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_425042", "425042018", "story_v_out_425042.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_425042", "425042018", "story_v_out_425042.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_16 = math.max(var_76_9, arg_73_1.talkMaxDuration)

			if var_76_8 <= arg_73_1.time_ and arg_73_1.time_ < var_76_8 + var_76_16 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_8) / var_76_16

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_8 + var_76_16 and arg_73_1.time_ < var_76_8 + var_76_16 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play425042019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 425042019
		arg_77_1.duration_ = 3.43

		local var_77_0 = {
			zh = 2.566,
			ja = 3.433
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
				arg_77_0:Play425042020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1137"]) and arg_77_1.var_.actorSpriteComps1137 == nil then
				arg_77_1.var_.actorSpriteComps1137 = arg_77_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1137"]) then
				if arg_77_1.var_.actorSpriteComps1137 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								iter_80_1.color = Color.New(Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor1.r, (arg_77_1.time_ - 0) / var_80_0), Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor1.g, (arg_77_1.time_ - 0) / var_80_0), (Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor1.b, (arg_77_1.time_ - 0) / var_80_0)))
							else
								local var_80_1 = Mathf.Lerp(iter_80_1.color.r, 1, (arg_77_1.time_ - 0) / var_80_0)

								iter_80_1.color = Color.New(var_80_1, var_80_1, var_80_1)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1137"]) and arg_77_1.var_.actorSpriteComps1137 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_80_3 then
						iter_80_3.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps1137 = nil
			end

			local var_80_2 = arg_77_1.actors_["1012"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps1012 == nil then
				arg_77_1.var_.actorSpriteComps1012 = var_80_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_3 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.actorSpriteComps1012 then
					for iter_80_4, iter_80_5 in pairs(arg_77_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_80_5 then
							if arg_77_1.isInRecall_ then
								iter_80_5.color = Color.New(Mathf.Lerp(iter_80_5.color.r, arg_77_1.hightColor2.r, (arg_77_1.time_ - 0) / var_80_3), Mathf.Lerp(iter_80_5.color.g, arg_77_1.hightColor2.g, (arg_77_1.time_ - 0) / var_80_3), (Mathf.Lerp(iter_80_5.color.b, arg_77_1.hightColor2.b, (arg_77_1.time_ - 0) / var_80_3)))
							else
								local var_80_4 = Mathf.Lerp(iter_80_5.color.r, 0.5, (arg_77_1.time_ - 0) / var_80_3)

								iter_80_5.color = Color.New(var_80_4, var_80_4, var_80_4)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.actorSpriteComps1012 then
				for iter_80_6, iter_80_7 in pairs(arg_77_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_80_7 then
						iter_80_7.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps1012 = nil
			end

			local var_80_5 = arg_77_1.actors_["1137"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1137 = var_80_5.localPosition
				var_80_5.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("1137", 4)

				for iter_80_8 = 0, var_80_5.childCount - 1 do
					local var_80_6 = var_80_5:GetChild(iter_80_8)

					if var_80_6.name == "split_4" then
						var_80_6:SetAsLastSibling()
						var_80_6.gameObject:SetActive(true)

						arg_77_1.var_.actorSpriteSplit1137 = var_80_6.gameObject:GetComponent(typeof(Image))

						arg_77_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_80_7 = 0.5

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				var_80_5.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_77_1.time_ - 0) / var_80_7)

				if arg_77_1.var_.actorSpriteSplit1137 ~= nil then
					arg_77_1.var_.actorSpriteSplit1137:SetAlpha((arg_77_1.time_ - 0) / var_80_7)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				var_80_5.localPosition = Vector3.New(390, -425, -200)

				if arg_77_1.var_.actorSpriteSplit1137 ~= nil then
					arg_77_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_80_8 = 0
			local var_80_9 = 0.125

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_10 = arg_77_1:GetWordFromCfg(425042019)
				local var_80_11 = arg_77_1:FormatText(var_80_10.content)

				arg_77_1.text_.text = var_80_11

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 5 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 5)

				if (5 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 5)) > 0 and var_80_9 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_11
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042019", "story_v_out_425042.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042019", "story_v_out_425042.awb") / 1000

					if var_80_14 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_8
					end

					if var_80_10.prefab_name ~= "" and arg_77_1.actors_[var_80_10.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_10.prefab_name].transform, "story_v_out_425042", "425042019", "story_v_out_425042.awb")

						arg_77_1:RecordAudio("425042019", var_80_15)
						arg_77_1:RecordAudio("425042019", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_425042", "425042019", "story_v_out_425042.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_425042", "425042019", "story_v_out_425042.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_8) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_8 + var_80_16 and arg_77_1.time_ < var_80_8 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play425042020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 425042020
		arg_81_1.duration_ = 7.13

		local var_81_0 = {
			zh = 4.5,
			ja = 7.133
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
				arg_81_0:Play425042021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1012"]) and arg_81_1.var_.actorSpriteComps1012 == nil then
				arg_81_1.var_.actorSpriteComps1012 = arg_81_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_0 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1012"]) then
				if arg_81_1.var_.actorSpriteComps1012 then
					for iter_84_0, iter_84_1 in pairs(arg_81_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1012"]) and arg_81_1.var_.actorSpriteComps1012 then
				for iter_84_2, iter_84_3 in pairs(arg_81_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_84_3 then
						iter_84_3.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_81_1.var_.actorSpriteComps1012 = nil
			end

			local var_84_2 = arg_81_1.actors_["1137"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps1137 == nil then
				arg_81_1.var_.actorSpriteComps1137 = var_84_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_84_3 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_3 and not isNil(var_84_2) then
				if arg_81_1.var_.actorSpriteComps1137 then
					for iter_84_4, iter_84_5 in pairs(arg_81_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_81_1.time_ >= 0 + var_84_3 and arg_81_1.time_ < 0 + var_84_3 + arg_84_0 and not isNil(var_84_2) and arg_81_1.var_.actorSpriteComps1137 then
				for iter_84_6, iter_84_7 in pairs(arg_81_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_84_7 then
						iter_84_7.color = arg_81_1.isInRecall_ and (arg_81_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_81_1.var_.actorSpriteComps1137 = nil
			end

			local var_84_5 = arg_81_1.actors_["1012"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1012 = var_84_5.localPosition
				var_84_5.localScale = Vector3.New(1, 1, 1)

				arg_81_1:CheckSpriteTmpPos("1012", 2)

				for iter_84_8 = 0, var_84_5.childCount - 1 do
					local var_84_6 = var_84_5:GetChild(iter_84_8)

					if var_84_6.name == "split_1" or not string.find(var_84_6.name, "split") then
						var_84_6.gameObject:SetActive(true)
					else
						var_84_6.gameObject:SetActive(false)
					end
				end
			end

			local var_84_7 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				var_84_5.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1012, Vector3.New(-390, -465, 300), (arg_81_1.time_ - 0) / var_84_7)
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				var_84_5.localPosition = Vector3.New(-390, -465, 300)
			end

			local var_84_8 = 0
			local var_84_9 = 0.6

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(425042020)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 24 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 24)

				if (24 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 24)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042020", "story_v_out_425042.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042020", "story_v_out_425042.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_425042", "425042020", "story_v_out_425042.awb")

						arg_81_1:RecordAudio("425042020", var_84_15)
						arg_81_1:RecordAudio("425042020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_425042", "425042020", "story_v_out_425042.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_425042", "425042020", "story_v_out_425042.awb")
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
				actorName = "1012",
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
	Play425042021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 425042021
		arg_85_1.duration_ = 3.23

		local var_85_0 = {
			zh = 2.266,
			ja = 3.233
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
				arg_85_0:Play425042022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1137"]) and arg_85_1.var_.actorSpriteComps1137 == nil then
				arg_85_1.var_.actorSpriteComps1137 = arg_85_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_0 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1137"]) then
				if arg_85_1.var_.actorSpriteComps1137 then
					for iter_88_0, iter_88_1 in pairs(arg_85_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1137"]) and arg_85_1.var_.actorSpriteComps1137 then
				for iter_88_2, iter_88_3 in pairs(arg_85_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_88_3 then
						iter_88_3.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_85_1.var_.actorSpriteComps1137 = nil
			end

			local var_88_2 = arg_85_1.actors_["1012"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps1012 == nil then
				arg_85_1.var_.actorSpriteComps1012 = var_88_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_88_3 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_3 and not isNil(var_88_2) then
				if arg_85_1.var_.actorSpriteComps1012 then
					for iter_88_4, iter_88_5 in pairs(arg_85_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_88_5 then
							if arg_85_1.isInRecall_ then
								iter_88_5.color = Color.New(Mathf.Lerp(iter_88_5.color.r, arg_85_1.hightColor2.r, (arg_85_1.time_ - 0) / var_88_3), Mathf.Lerp(iter_88_5.color.g, arg_85_1.hightColor2.g, (arg_85_1.time_ - 0) / var_88_3), (Mathf.Lerp(iter_88_5.color.b, arg_85_1.hightColor2.b, (arg_85_1.time_ - 0) / var_88_3)))
							else
								local var_88_4 = Mathf.Lerp(iter_88_5.color.r, 0.5, (arg_85_1.time_ - 0) / var_88_3)

								iter_88_5.color = Color.New(var_88_4, var_88_4, var_88_4)
							end
						end
					end
				end
			end

			if arg_85_1.time_ >= 0 + var_88_3 and arg_85_1.time_ < 0 + var_88_3 + arg_88_0 and not isNil(var_88_2) and arg_85_1.var_.actorSpriteComps1012 then
				for iter_88_6, iter_88_7 in pairs(arg_85_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_88_7 then
						iter_88_7.color = arg_85_1.isInRecall_ and (arg_85_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_85_1.var_.actorSpriteComps1012 = nil
			end

			local var_88_5 = arg_85_1.actors_["1137"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1137 = var_88_5.localPosition
				var_88_5.localScale = Vector3.New(1, 1, 1)

				arg_85_1:CheckSpriteTmpPos("1137", 4)

				for iter_88_8 = 0, var_88_5.childCount - 1 do
					local var_88_6 = var_88_5:GetChild(iter_88_8)

					if var_88_6.name == "split_5" then
						var_88_6:SetAsLastSibling()
						var_88_6.gameObject:SetActive(true)

						arg_85_1.var_.actorSpriteSplit1137 = var_88_6.gameObject:GetComponent(typeof(Image))

						arg_85_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_88_7 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_7 then
				var_88_5.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_85_1.time_ - 0) / var_88_7)

				if arg_85_1.var_.actorSpriteSplit1137 ~= nil then
					arg_85_1.var_.actorSpriteSplit1137:SetAlpha((arg_85_1.time_ - 0) / var_88_7)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_7 and arg_85_1.time_ < 0 + var_88_7 + arg_88_0 then
				var_88_5.localPosition = Vector3.New(390, -425, -200)

				if arg_85_1.var_.actorSpriteSplit1137 ~= nil then
					arg_85_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_88_8 = 0
			local var_88_9 = 0.25

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_8 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_10 = arg_85_1:GetWordFromCfg(425042021)
				local var_88_11 = arg_85_1:FormatText(var_88_10.content)

				arg_85_1.text_.text = var_88_11

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_13 = 10 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 10)

				if (10 <= 0 and var_88_9 or var_88_9 * (utf8.len(var_88_11) / 10)) > 0 and var_88_9 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_8
					end
				end

				arg_85_1.text_.text = var_88_11
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042021", "story_v_out_425042.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042021", "story_v_out_425042.awb") / 1000

					if var_88_14 + var_88_8 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_8
					end

					if var_88_10.prefab_name ~= "" and arg_85_1.actors_[var_88_10.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_10.prefab_name].transform, "story_v_out_425042", "425042021", "story_v_out_425042.awb")

						arg_85_1:RecordAudio("425042021", var_88_15)
						arg_85_1:RecordAudio("425042021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_425042", "425042021", "story_v_out_425042.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_425042", "425042021", "story_v_out_425042.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_9, arg_85_1.talkMaxDuration)

			if var_88_8 <= arg_85_1.time_ and arg_85_1.time_ < var_88_8 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_8) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_8 + var_88_16 and arg_85_1.time_ < var_88_8 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play425042022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 425042022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play425042023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1012 = arg_89_1.actors_["1012"].transform.localPosition
				arg_89_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1012", 7)

				for iter_92_0 = 0, arg_89_1.actors_["1012"].transform.childCount - 1 do
					local var_92_0 = arg_89_1.actors_["1012"].transform:GetChild(iter_92_0)

					if var_92_0.name == "" or not string.find(var_92_0.name, "split") then
						var_92_0.gameObject:SetActive(true)
					else
						var_92_0.gameObject:SetActive(false)
					end
				end
			end

			local var_92_1 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_1 then
				arg_89_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1012, Vector3.New(0, -2000, 300), (arg_89_1.time_ - 0) / var_92_1)
			end

			if arg_89_1.time_ >= 0 + var_92_1 and arg_89_1.time_ < 0 + var_92_1 + arg_92_0 then
				arg_89_1.actors_["1012"].transform.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_92_2 = arg_89_1.actors_["1137"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1137 = var_92_2.localPosition
				var_92_2.localScale = Vector3.New(1, 1, 1)

				arg_89_1:CheckSpriteTmpPos("1137", 7)

				for iter_92_1 = 0, var_92_2.childCount - 1 do
					local var_92_3 = var_92_2:GetChild(iter_92_1)

					if var_92_3.name == "" or not string.find(var_92_3.name, "split") then
						var_92_3.gameObject:SetActive(true)
					else
						var_92_3.gameObject:SetActive(false)
					end
				end
			end

			local var_92_4 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				var_92_2.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_89_1.time_ - 0) / var_92_4)
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				var_92_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_92_5 = 0
			local var_92_6 = 1.175

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_7 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(425042022).content)

				arg_89_1.text_.text = var_92_7

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 47 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_7) / 47)

				if (47 <= 0 and var_92_6 or var_92_6 * (utf8.len(var_92_7) / 47)) > 0 and var_92_6 < var_92_9 then
					arg_89_1.talkMaxDuration = var_92_9

					if var_92_9 + var_92_5 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_9 + var_92_5
					end
				end

				arg_89_1.text_.text = var_92_7
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_10 = math.max(var_92_6, arg_89_1.talkMaxDuration)

			if var_92_5 <= arg_89_1.time_ and arg_89_1.time_ < var_92_5 + var_92_10 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_5) / var_92_10

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_5 + var_92_10 and arg_89_1.time_ < var_92_5 + var_92_10 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
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
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play425042023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 425042023
		arg_93_1.duration_ = 12.57

		local var_93_0 = {
			zh = 10.833,
			ja = 12.566
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
				arg_93_0:Play425042024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["1012"]) and arg_93_1.var_.actorSpriteComps1012 == nil then
				arg_93_1.var_.actorSpriteComps1012 = arg_93_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_96_0 = 0.2

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["1012"]) then
				if arg_93_1.var_.actorSpriteComps1012 then
					for iter_96_0, iter_96_1 in pairs(arg_93_1.var_.actorSpriteComps1012:ToTable()) do
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

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["1012"]) and arg_93_1.var_.actorSpriteComps1012 then
				for iter_96_2, iter_96_3 in pairs(arg_93_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_96_3 then
						iter_96_3.color = arg_93_1.isInRecall_ and (arg_93_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_93_1.var_.actorSpriteComps1012 = nil
			end

			local var_96_2 = arg_93_1.actors_["1012"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1012 = var_96_2.localPosition
				var_96_2.localScale = Vector3.New(1, 1, 1)

				arg_93_1:CheckSpriteTmpPos("1012", 3)

				for iter_96_4 = 0, var_96_2.childCount - 1 do
					local var_96_3 = var_96_2:GetChild(iter_96_4)

					if var_96_3.name == "split_5" or not string.find(var_96_3.name, "split") then
						var_96_3.gameObject:SetActive(true)
					else
						var_96_3.gameObject:SetActive(false)
					end
				end
			end

			local var_96_4 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				var_96_2.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1012, Vector3.New(0, -465, 300), (arg_93_1.time_ - 0) / var_96_4)
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				var_96_2.localPosition = Vector3.New(0, -465, 300)
			end

			local var_96_5 = 0
			local var_96_6 = 1

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_7 = arg_93_1:GetWordFromCfg(425042023)
				local var_96_8 = arg_93_1:FormatText(var_96_7.content)

				arg_93_1.text_.text = var_96_8

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 40 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_8) / 40)

				if (40 <= 0 and var_96_6 or var_96_6 * (utf8.len(var_96_8) / 40)) > 0 and var_96_6 < var_96_10 then
					arg_93_1.talkMaxDuration = var_96_10

					if var_96_10 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_5
					end
				end

				arg_93_1.text_.text = var_96_8
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042023", "story_v_out_425042.awb") ~= 0 then
					local var_96_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042023", "story_v_out_425042.awb") / 1000

					if var_96_11 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_11 + var_96_5
					end

					if var_96_7.prefab_name ~= "" and arg_93_1.actors_[var_96_7.prefab_name] ~= nil then
						local var_96_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_7.prefab_name].transform, "story_v_out_425042", "425042023", "story_v_out_425042.awb")

						arg_93_1:RecordAudio("425042023", var_96_12)
						arg_93_1:RecordAudio("425042023", var_96_12)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_425042", "425042023", "story_v_out_425042.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_425042", "425042023", "story_v_out_425042.awb")
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
				actorName = "1012",
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
	Play425042024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 425042024
		arg_97_1.duration_ = 12.8

		local var_97_0 = {
			zh = 9,
			ja = 12.8
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
				arg_97_0:Play425042025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0.925

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_1 = arg_97_1:GetWordFromCfg(425042024)
				local var_100_2 = arg_97_1:FormatText(var_100_1.content)

				arg_97_1.text_.text = var_100_2

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_4 = 37 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 37)

				if (37 <= 0 and var_100_0 or var_100_0 * (utf8.len(var_100_2) / 37)) > 0 and var_100_0 < var_100_4 then
					arg_97_1.talkMaxDuration = var_100_4

					if var_100_4 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_4 + 0
					end
				end

				arg_97_1.text_.text = var_100_2
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042024", "story_v_out_425042.awb") ~= 0 then
					local var_100_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042024", "story_v_out_425042.awb") / 1000

					if var_100_5 + 0 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_5 + 0
					end

					if var_100_1.prefab_name ~= "" and arg_97_1.actors_[var_100_1.prefab_name] ~= nil then
						local var_100_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_1.prefab_name].transform, "story_v_out_425042", "425042024", "story_v_out_425042.awb")

						arg_97_1:RecordAudio("425042024", var_100_6)
						arg_97_1:RecordAudio("425042024", var_100_6)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_425042", "425042024", "story_v_out_425042.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_425042", "425042024", "story_v_out_425042.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_0, arg_97_1.talkMaxDuration)

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - 0) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= 0 + var_100_7 and arg_97_1.time_ < 0 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play425042025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 425042025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play425042026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1012"]) and arg_101_1.var_.actorSpriteComps1012 == nil then
				arg_101_1.var_.actorSpriteComps1012 = arg_101_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_104_0 = 0.2

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1012"]) then
				if arg_101_1.var_.actorSpriteComps1012 then
					for iter_104_0, iter_104_1 in pairs(arg_101_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_104_1 then
							if arg_101_1.isInRecall_ then
								iter_104_1.color = Color.New(Mathf.Lerp(iter_104_1.color.r, arg_101_1.hightColor2.r, (arg_101_1.time_ - 0) / var_104_0), Mathf.Lerp(iter_104_1.color.g, arg_101_1.hightColor2.g, (arg_101_1.time_ - 0) / var_104_0), (Mathf.Lerp(iter_104_1.color.b, arg_101_1.hightColor2.b, (arg_101_1.time_ - 0) / var_104_0)))
							else
								local var_104_1 = Mathf.Lerp(iter_104_1.color.r, 0.5, (arg_101_1.time_ - 0) / var_104_0)

								iter_104_1.color = Color.New(var_104_1, var_104_1, var_104_1)
							end
						end
					end
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1012"]) and arg_101_1.var_.actorSpriteComps1012 then
				for iter_104_2, iter_104_3 in pairs(arg_101_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_104_3 then
						iter_104_3.color = arg_101_1.isInRecall_ and (arg_101_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_101_1.var_.actorSpriteComps1012 = nil
			end

			local var_104_2 = arg_101_1.actors_["1012"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1012 = var_104_2.localPosition
				var_104_2.localScale = Vector3.New(1, 1, 1)

				arg_101_1:CheckSpriteTmpPos("1012", 7)

				for iter_104_4 = 0, var_104_2.childCount - 1 do
					local var_104_3 = var_104_2:GetChild(iter_104_4)

					if var_104_3.name == "" or not string.find(var_104_3.name, "split") then
						var_104_3.gameObject:SetActive(true)
					else
						var_104_3.gameObject:SetActive(false)
					end
				end
			end

			local var_104_4 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 then
				var_104_2.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1012, Vector3.New(0, -2000, 300), (arg_101_1.time_ - 0) / var_104_4)
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 then
				var_104_2.localPosition = Vector3.New(0, -2000, 300)
			end

			if 0.1 < arg_101_1.time_ and arg_101_1.time_ <= 0.1 + arg_104_0 then
				arg_101_1:AudioAction("play", "effect", "se_story_147", "se_story_147_clap", "")
			end

			local var_104_6 = 0
			local var_104_7 = 1.05

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_8 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(425042025).content)

				arg_101_1.text_.text = var_104_8

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_10 = 42 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_8) / 42)

				if (42 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_8) / 42)) > 0 and var_104_7 < var_104_10 then
					arg_101_1.talkMaxDuration = var_104_10

					if var_104_10 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_8
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_11 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_11 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_11

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_11 and arg_101_1.time_ < var_104_6 + var_104_11 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
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

		arg_101_1:InitPlayNodeList()
	end,
	Play425042026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 425042026
		arg_105_1.duration_ = 13.27

		local var_105_0 = {
			zh = 9.066,
			ja = 13.266
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
				arg_105_0:Play425042027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1012"]) and arg_105_1.var_.actorSpriteComps1012 == nil then
				arg_105_1.var_.actorSpriteComps1012 = arg_105_1.actors_["1012"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_108_0 = 0.2

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1012"]) then
				if arg_105_1.var_.actorSpriteComps1012 then
					for iter_108_0, iter_108_1 in pairs(arg_105_1.var_.actorSpriteComps1012:ToTable()) do
						if iter_108_1 then
							if arg_105_1.isInRecall_ then
								iter_108_1.color = Color.New(Mathf.Lerp(iter_108_1.color.r, arg_105_1.hightColor1.r, (arg_105_1.time_ - 0) / var_108_0), Mathf.Lerp(iter_108_1.color.g, arg_105_1.hightColor1.g, (arg_105_1.time_ - 0) / var_108_0), (Mathf.Lerp(iter_108_1.color.b, arg_105_1.hightColor1.b, (arg_105_1.time_ - 0) / var_108_0)))
							else
								local var_108_1 = Mathf.Lerp(iter_108_1.color.r, 1, (arg_105_1.time_ - 0) / var_108_0)

								iter_108_1.color = Color.New(var_108_1, var_108_1, var_108_1)
							end
						end
					end
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1012"]) and arg_105_1.var_.actorSpriteComps1012 then
				for iter_108_2, iter_108_3 in pairs(arg_105_1.var_.actorSpriteComps1012:ToTable()) do
					if iter_108_3 then
						iter_108_3.color = arg_105_1.isInRecall_ and (arg_105_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_105_1.var_.actorSpriteComps1012 = nil
			end

			local var_108_2 = arg_105_1.actors_["1012"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1012 = var_108_2.localPosition
				var_108_2.localScale = Vector3.New(1, 1, 1)

				arg_105_1:CheckSpriteTmpPos("1012", 3)

				for iter_108_4 = 0, var_108_2.childCount - 1 do
					local var_108_3 = var_108_2:GetChild(iter_108_4)

					if var_108_3.name == "split_3" or not string.find(var_108_3.name, "split") then
						var_108_3.gameObject:SetActive(true)
					else
						var_108_3.gameObject:SetActive(false)
					end
				end
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_2.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1012, Vector3.New(0, -465, 300), (arg_105_1.time_ - 0) / var_108_4)
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_2.localPosition = Vector3.New(0, -465, 300)
			end

			local var_108_5 = 0
			local var_108_6 = 1.05

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[595].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_7 = arg_105_1:GetWordFromCfg(425042026)
				local var_108_8 = arg_105_1:FormatText(var_108_7.content)

				arg_105_1.text_.text = var_108_8

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_10 = 42 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_8) / 42)

				if (42 <= 0 and var_108_6 or var_108_6 * (utf8.len(var_108_8) / 42)) > 0 and var_108_6 < var_108_10 then
					arg_105_1.talkMaxDuration = var_108_10

					if var_108_10 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_10 + var_108_5
					end
				end

				arg_105_1.text_.text = var_108_8
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042026", "story_v_out_425042.awb") ~= 0 then
					local var_108_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042026", "story_v_out_425042.awb") / 1000

					if var_108_11 + var_108_5 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_5
					end

					if var_108_7.prefab_name ~= "" and arg_105_1.actors_[var_108_7.prefab_name] ~= nil then
						local var_108_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_7.prefab_name].transform, "story_v_out_425042", "425042026", "story_v_out_425042.awb")

						arg_105_1:RecordAudio("425042026", var_108_12)
						arg_105_1:RecordAudio("425042026", var_108_12)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_425042", "425042026", "story_v_out_425042.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_425042", "425042026", "story_v_out_425042.awb")
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
				actorName = "1012",
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
	Play425042027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 425042027
		arg_109_1.duration_ = 19.97

		local var_109_0 = {
			zh = 13.433667,
			ja = 19.966667
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
				arg_109_0:Play425042028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0.966666666666667 < arg_109_1.time_ and arg_109_1.time_ <= 0.966666666666667 + arg_112_0 then
				arg_109_1.var_.moveOldPos1012 = arg_109_1.actors_["1012"].transform.localPosition
				arg_109_1.actors_["1012"].transform.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1012", 7)

				for iter_112_0 = 0, arg_109_1.actors_["1012"].transform.childCount - 1 do
					local var_112_0 = arg_109_1.actors_["1012"].transform:GetChild(iter_112_0)

					if var_112_0.name == "" or not string.find(var_112_0.name, "split") then
						var_112_0.gameObject:SetActive(true)
					else
						var_112_0.gameObject:SetActive(false)
					end
				end
			end

			local var_112_1 = 0.001

			if 0.966666666666667 <= arg_109_1.time_ and arg_109_1.time_ < 0.966666666666667 + var_112_1 then
				arg_109_1.actors_["1012"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1012, Vector3.New(0, -2000, 300), (arg_109_1.time_ - 0.966666666666667) / var_112_1)
			end

			if arg_109_1.time_ >= 0.966666666666667 + var_112_1 and arg_109_1.time_ < 0.966666666666667 + var_112_1 + arg_112_0 then
				arg_109_1.actors_["1012"].transform.localPosition = Vector3.New(0, -2000, 300)
			end

			local var_112_2 = "1033"

			if arg_109_1.actors_["1033"] == nil then
				local var_112_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_112_3) then
					local var_112_4 = Object.Instantiate(var_112_3, arg_109_1.canvasGo_.transform)

					var_112_4.transform:SetSiblingIndex(1)

					var_112_4.name = var_112_2
					var_112_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_109_1.actors_[var_112_2] = var_112_4

					if arg_109_1.isInRecall_ then
						for iter_112_1, iter_112_2 in ipairs((var_112_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_112_2.color = arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_112_5 = arg_109_1.actors_["1033"]

			if 4.200667 < arg_109_1.time_ and arg_109_1.time_ <= 4.200667 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.actorSpriteComps1033 == nil then
				arg_109_1.var_.actorSpriteComps1033 = var_112_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_112_6 = 0.2

			if 4.200667 <= arg_109_1.time_ and arg_109_1.time_ < 4.200667 + var_112_6 and not isNil(var_112_5) then
				if arg_109_1.var_.actorSpriteComps1033 then
					for iter_112_3, iter_112_4 in pairs(arg_109_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_112_4 then
							if arg_109_1.isInRecall_ then
								iter_112_4.color = Color.New(Mathf.Lerp(iter_112_4.color.r, arg_109_1.hightColor1.r, (arg_109_1.time_ - 4.200667) / var_112_6), Mathf.Lerp(iter_112_4.color.g, arg_109_1.hightColor1.g, (arg_109_1.time_ - 4.200667) / var_112_6), (Mathf.Lerp(iter_112_4.color.b, arg_109_1.hightColor1.b, (arg_109_1.time_ - 4.200667) / var_112_6)))
							else
								local var_112_7 = Mathf.Lerp(iter_112_4.color.r, 1, (arg_109_1.time_ - 4.200667) / var_112_6)

								iter_112_4.color = Color.New(var_112_7, var_112_7, var_112_7)
							end
						end
					end
				end
			end

			if arg_109_1.time_ >= 4.200667 + var_112_6 and arg_109_1.time_ < 4.200667 + var_112_6 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.actorSpriteComps1033 then
				for iter_112_5, iter_112_6 in pairs(arg_109_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_112_6 then
						iter_112_6.color = arg_109_1.isInRecall_ and (arg_109_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_109_1.var_.actorSpriteComps1033 = nil
			end

			local var_112_8 = 1.00066666666667

			if 1.00066666666667 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_9 = 0.999333333333332

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_9 then
				local var_112_10 = Color.New(0, 0, 0)

				var_112_10.a = Mathf.Lerp(1, 0, (arg_109_1.time_ - var_112_8) / var_112_9)
				arg_109_1.mask_.color = var_112_10
			end

			if arg_109_1.time_ >= var_112_8 + var_112_9 and arg_109_1.time_ < var_112_8 + var_112_9 + arg_112_0 then
				local var_112_11 = Color.New(0, 0, 0)

				arg_109_1.mask_.enabled = false
				var_112_11.a = 0
				arg_109_1.mask_.color = var_112_11
			end

			local var_112_12 = arg_109_1.actors_["1033"].transform

			if 4.200667 < arg_109_1.time_ and arg_109_1.time_ <= 4.200667 + arg_112_0 then
				arg_109_1.var_.moveOldPos1033 = var_112_12.localPosition
				var_112_12.localScale = Vector3.New(1, 1, 1)

				arg_109_1:CheckSpriteTmpPos("1033", 3)

				for iter_112_7 = 0, var_112_12.childCount - 1 do
					local var_112_13 = var_112_12:GetChild(iter_112_7)

					if var_112_13.name == "split_6" or not string.find(var_112_13.name, "split") then
						var_112_13.gameObject:SetActive(true)
					else
						var_112_13.gameObject:SetActive(false)
					end
				end
			end

			local var_112_14 = 0.001

			if 4.200667 <= arg_109_1.time_ and arg_109_1.time_ < 4.200667 + var_112_14 then
				var_112_12.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_109_1.time_ - 4.200667) / var_112_14)
			end

			if arg_109_1.time_ >= 4.200667 + var_112_14 and arg_109_1.time_ < 4.200667 + var_112_14 + arg_112_0 then
				var_112_12.localPosition = Vector3.New(0, -420, 0)
			end

			local var_112_15 = 0

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_15 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_16 = 1

			if var_112_15 <= arg_109_1.time_ and arg_109_1.time_ < var_112_15 + var_112_16 then
				local var_112_17 = Color.New(0, 0, 0)

				var_112_17.a = Mathf.Lerp(0, 1, (arg_109_1.time_ - var_112_15) / var_112_16)
				arg_109_1.mask_.color = var_112_17
			end

			if arg_109_1.time_ >= var_112_15 + var_112_16 and arg_109_1.time_ < var_112_15 + var_112_16 + arg_112_0 then
				local var_112_18 = Color.New(0, 0, 0)

				var_112_18.a = 1
				arg_109_1.mask_.color = var_112_18
			end

			local var_112_19 = 1.00066666666667

			if 1.00066666666667 < arg_109_1.time_ and arg_109_1.time_ <= var_112_19 + arg_112_0 then
				arg_109_1.timestampController_:SetSelectedState("show")
				arg_109_1.timestampAni_:Play("in")

				arg_109_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST10")

				arg_109_1.timestampColorController_:SetSelectedState("cold")
				arg_109_1.timeColdImg_:SetAlpha(0.031)

				arg_109_1.text_timeText_.text = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(501100).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_timeText_)

				arg_109_1.text_siteText_.text = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(501101).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_siteText_)
			end

			if arg_109_1.time_ >= var_112_19 + 1.999999999999 and arg_109_1.time_ < var_112_19 + 1.999999999999 + arg_112_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_109_1.timestampAni_, "out", function()
					arg_109_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_112_20 = 3.000667

			if 3.000667 < arg_109_1.time_ and arg_109_1.time_ <= var_112_20 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_21 = 1.2

			if var_112_20 <= arg_109_1.time_ and arg_109_1.time_ < var_112_20 + var_112_21 then
				local var_112_22 = Color.New(0, 0, 0)

				var_112_22.a = Mathf.Lerp(0, 1, (arg_109_1.time_ - var_112_20) / var_112_21)
				arg_109_1.mask_.color = var_112_22
			end

			if arg_109_1.time_ >= var_112_20 + var_112_21 and arg_109_1.time_ < var_112_20 + var_112_21 + arg_112_0 then
				local var_112_23 = Color.New(0, 0, 0)

				var_112_23.a = 1
				arg_109_1.mask_.color = var_112_23
			end

			local var_112_24 = 4.200667

			if 4.200667 < arg_109_1.time_ and arg_109_1.time_ <= var_112_24 + arg_112_0 then
				arg_109_1.mask_.enabled = true
				arg_109_1.mask_.raycastTarget = true

				arg_109_1:SetGaussion(false)
			end

			local var_112_25 = 1.2

			if var_112_24 <= arg_109_1.time_ and arg_109_1.time_ < var_112_24 + var_112_25 then
				local var_112_26 = Color.New(0, 0, 0)

				var_112_26.a = Mathf.Lerp(1, 0, (arg_109_1.time_ - var_112_24) / var_112_25)
				arg_109_1.mask_.color = var_112_26
			end

			if arg_109_1.time_ >= var_112_24 + var_112_25 and arg_109_1.time_ < var_112_24 + var_112_25 + arg_112_0 then
				local var_112_27 = Color.New(0, 0, 0)

				arg_109_1.mask_.enabled = false
				var_112_27.a = 0
				arg_109_1.mask_.color = var_112_27
			end

			local var_112_28 = "ST10"

			if arg_109_1.bgs_.ST10 == nil then
				local var_112_29 = Object.Instantiate(arg_109_1.paintGo_)

				var_112_29:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_112_28)
				var_112_29.name = var_112_28
				var_112_29.transform.parent = arg_109_1.stage_.transform
				var_112_29.transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.bgs_[var_112_28] = var_112_29
			end

			if 1.00066666666667 < arg_109_1.time_ and arg_109_1.time_ <= 1.00066666666667 + arg_112_0 then
				local var_112_30 = arg_109_1.bgs_.ST10

				arg_109_1.bgs_.ST10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_112_30.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_112_31 = var_112_30:GetComponent("SpriteRenderer")

				if var_112_31 and var_112_31.sprite then
					local var_112_32 = 2 * (var_112_30.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_112_30.transform.localScale = Vector3.New(var_112_32 / var_112_31.sprite.bounds.size.y < var_112_32 * manager.ui.mainCameraCom_.aspect / var_112_31.sprite.bounds.size.x and var_112_32 * manager.ui.mainCameraCom_.aspect / var_112_31.sprite.bounds.size.x or var_112_32 / var_112_31.sprite.bounds.size.y, var_112_32 / var_112_31.sprite.bounds.size.y < var_112_32 * manager.ui.mainCameraCom_.aspect / var_112_31.sprite.bounds.size.x and var_112_32 * manager.ui.mainCameraCom_.aspect / var_112_31.sprite.bounds.size.x or var_112_32 / var_112_31.sprite.bounds.size.y, 0)
				end

				for iter_112_8, iter_112_9 in pairs(arg_109_1.bgs_) do
					if iter_112_8 ~= "ST10" then
						iter_112_9.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0.366666666666667 < arg_109_1.time_ and arg_109_1.time_ <= 0.366666666666667 + arg_112_0 then
				arg_109_1:AudioAction("stop", "effect", "se_story_142", "se_story_142_amb_commandroom", "")
			end

			if 3.9 < arg_109_1.time_ and arg_109_1.time_ <= 3.9 + arg_112_0 then
				arg_109_1:AudioAction("play", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_109_1.frameCnt_ <= 1 then
				arg_109_1.dialog_:SetActive(false)
			end

			local var_112_35 = 5.400667
			local var_112_36 = 1.075

			if 5.400667 < arg_109_1.time_ and arg_109_1.time_ <= var_112_35 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0

				arg_109_1.dialog_:SetActive(true)

				arg_109_1.dialogCg_.alpha = 0

				local var_112_37 = LeanTween.value(arg_109_1.dialog_, 0, 1, 0.3)

				var_112_37:setOnUpdate(LuaHelper.FloatAction(function(arg_114_0)
					arg_109_1.dialogCg_.alpha = arg_114_0
				end))
				var_112_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_109_1.dialog_)
					var_112_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_109_1.duration_ = arg_109_1.duration_ + 0.3

				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_38 = arg_109_1:GetWordFromCfg(425042027)
				local var_112_39 = arg_109_1:FormatText(var_112_38.content)

				arg_109_1.text_.text = var_112_39

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_41 = 43 <= 0 and var_112_36 or var_112_36 * (utf8.len(var_112_39) / 43)

				if (43 <= 0 and var_112_36 or var_112_36 * (utf8.len(var_112_39) / 43)) > 0 and var_112_36 < var_112_41 then
					arg_109_1.talkMaxDuration = var_112_41
					var_112_35 = var_112_35 + 0.3

					if var_112_41 + var_112_35 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_41 + var_112_35
					end
				end

				arg_109_1.text_.text = var_112_39
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042027", "story_v_out_425042.awb") ~= 0 then
					local var_112_42 = manager.audio:GetVoiceLength("story_v_out_425042", "425042027", "story_v_out_425042.awb") / 1000

					if var_112_42 + var_112_35 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_42 + var_112_35
					end

					if var_112_38.prefab_name ~= "" and arg_109_1.actors_[var_112_38.prefab_name] ~= nil then
						local var_112_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_38.prefab_name].transform, "story_v_out_425042", "425042027", "story_v_out_425042.awb")

						arg_109_1:RecordAudio("425042027", var_112_43)
						arg_109_1:RecordAudio("425042027", var_112_43)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_425042", "425042027", "story_v_out_425042.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_425042", "425042027", "story_v_out_425042.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_44 = var_112_35 + 0.3
			local var_112_45 = math.max(var_112_36, arg_109_1.talkMaxDuration)

			if var_112_35 + 0.3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_44 + var_112_45 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_44) / var_112_45

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_44 + var_112_45 and arg_109_1.time_ < var_112_44 + var_112_45 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1012",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.966666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4.200667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play425042028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 425042028
		arg_116_1.duration_ = 12.2

		local var_116_0 = {
			zh = 9.333,
			ja = 12.2
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play425042029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 1.15

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_1 = arg_116_1:GetWordFromCfg(425042028)
				local var_119_2 = arg_116_1:FormatText(var_119_1.content)

				arg_116_1.text_.text = var_119_2

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_4 = 46 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 46)

				if (46 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 46)) > 0 and var_119_0 < var_119_4 then
					arg_116_1.talkMaxDuration = var_119_4

					if var_119_4 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_4 + 0
					end
				end

				arg_116_1.text_.text = var_119_2
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042028", "story_v_out_425042.awb") ~= 0 then
					local var_119_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042028", "story_v_out_425042.awb") / 1000

					if var_119_5 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + 0
					end

					if var_119_1.prefab_name ~= "" and arg_116_1.actors_[var_119_1.prefab_name] ~= nil then
						local var_119_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_1.prefab_name].transform, "story_v_out_425042", "425042028", "story_v_out_425042.awb")

						arg_116_1:RecordAudio("425042028", var_119_6)
						arg_116_1:RecordAudio("425042028", var_119_6)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_425042", "425042028", "story_v_out_425042.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_425042", "425042028", "story_v_out_425042.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_7 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_7

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play425042029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 425042029
		arg_120_1.duration_ = 12.43

		local var_120_0 = {
			zh = 8.8,
			ja = 12.433
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play425042030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 1.1

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_1 = arg_120_1:GetWordFromCfg(425042029)
				local var_123_2 = arg_120_1:FormatText(var_123_1.content)

				arg_120_1.text_.text = var_123_2

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 44 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 44)

				if (44 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 44)) > 0 and var_123_0 < var_123_4 then
					arg_120_1.talkMaxDuration = var_123_4

					if var_123_4 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_4 + 0
					end
				end

				arg_120_1.text_.text = var_123_2
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042029", "story_v_out_425042.awb") ~= 0 then
					local var_123_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042029", "story_v_out_425042.awb") / 1000

					if var_123_5 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + 0
					end

					if var_123_1.prefab_name ~= "" and arg_120_1.actors_[var_123_1.prefab_name] ~= nil then
						local var_123_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_1.prefab_name].transform, "story_v_out_425042", "425042029", "story_v_out_425042.awb")

						arg_120_1:RecordAudio("425042029", var_123_6)
						arg_120_1:RecordAudio("425042029", var_123_6)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_425042", "425042029", "story_v_out_425042.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_425042", "425042029", "story_v_out_425042.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play425042030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 425042030
		arg_124_1.duration_ = 13

		local var_124_0 = {
			zh = 9.8,
			ja = 13
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play425042031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 1.2

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_1 = arg_124_1:GetWordFromCfg(425042030)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 48 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 48)

				if (48 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 48)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042030", "story_v_out_425042.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042030", "story_v_out_425042.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_out_425042", "425042030", "story_v_out_425042.awb")

						arg_124_1:RecordAudio("425042030", var_127_6)
						arg_124_1:RecordAudio("425042030", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_425042", "425042030", "story_v_out_425042.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_425042", "425042030", "story_v_out_425042.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play425042031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 425042031
		arg_128_1.duration_ = 5.4

		local var_128_0 = {
			zh = 3.2,
			ja = 5.4
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play425042032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0.475

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_1 = arg_128_1:GetWordFromCfg(425042031)
				local var_131_2 = arg_128_1:FormatText(var_131_1.content)

				arg_128_1.text_.text = var_131_2

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_4 = 19 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 19)

				if (19 <= 0 and var_131_0 or var_131_0 * (utf8.len(var_131_2) / 19)) > 0 and var_131_0 < var_131_4 then
					arg_128_1.talkMaxDuration = var_131_4

					if var_131_4 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_4 + 0
					end
				end

				arg_128_1.text_.text = var_131_2
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042031", "story_v_out_425042.awb") ~= 0 then
					local var_131_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042031", "story_v_out_425042.awb") / 1000

					if var_131_5 + 0 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_5 + 0
					end

					if var_131_1.prefab_name ~= "" and arg_128_1.actors_[var_131_1.prefab_name] ~= nil then
						local var_131_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_1.prefab_name].transform, "story_v_out_425042", "425042031", "story_v_out_425042.awb")

						arg_128_1:RecordAudio("425042031", var_131_6)
						arg_128_1:RecordAudio("425042031", var_131_6)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_425042", "425042031", "story_v_out_425042.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_425042", "425042031", "story_v_out_425042.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_7 = math.max(var_131_0, arg_128_1.talkMaxDuration)

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - 0) / var_131_7

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play425042032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 425042032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play425042033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1033 = arg_132_1.actors_["1033"].transform.localPosition
				arg_132_1.actors_["1033"].transform.localScale = Vector3.New(1, 1, 1)

				arg_132_1:CheckSpriteTmpPos("1033", 7)

				for iter_135_0 = 0, arg_132_1.actors_["1033"].transform.childCount - 1 do
					local var_135_0 = arg_132_1.actors_["1033"].transform:GetChild(iter_135_0)

					if var_135_0.name == "" or not string.find(var_135_0.name, "split") then
						var_135_0.gameObject:SetActive(true)
					else
						var_135_0.gameObject:SetActive(false)
					end
				end
			end

			local var_135_1 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_1 then
				arg_132_1.actors_["1033"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_132_1.time_ - 0) / var_135_1)
			end

			if arg_132_1.time_ >= 0 + var_135_1 and arg_132_1.time_ < 0 + var_135_1 + arg_135_0 then
				arg_132_1.actors_["1033"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_135_2 = 0
			local var_135_3 = 1.725

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_2 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_4 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(425042032).content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_6 = 69 <= 0 and var_135_3 or var_135_3 * (utf8.len(var_135_4) / 69)

				if (69 <= 0 and var_135_3 or var_135_3 * (utf8.len(var_135_4) / 69)) > 0 and var_135_3 < var_135_6 then
					arg_132_1.talkMaxDuration = var_135_6

					if var_135_6 + var_135_2 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_2
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_3, arg_132_1.talkMaxDuration)

			if var_135_2 <= arg_132_1.time_ and arg_132_1.time_ < var_135_2 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_2) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_2 + var_135_7 and arg_132_1.time_ < var_135_2 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play425042033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 425042033
		arg_136_1.duration_ = 5.07

		local var_136_0 = {
			zh = 4.033,
			ja = 5.066
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play425042034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.45

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[1432].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Eden")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_1 = arg_136_1:GetWordFromCfg(425042033)
				local var_139_2 = arg_136_1:FormatText(var_139_1.content)

				arg_136_1.text_.text = var_139_2

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 18 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 18)

				if (18 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 18)) > 0 and var_139_0 < var_139_4 then
					arg_136_1.talkMaxDuration = var_139_4

					if var_139_4 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_4 + 0
					end
				end

				arg_136_1.text_.text = var_139_2
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042033", "story_v_out_425042.awb") ~= 0 then
					local var_139_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042033", "story_v_out_425042.awb") / 1000

					if var_139_5 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + 0
					end

					if var_139_1.prefab_name ~= "" and arg_136_1.actors_[var_139_1.prefab_name] ~= nil then
						local var_139_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_1.prefab_name].transform, "story_v_out_425042", "425042033", "story_v_out_425042.awb")

						arg_136_1:RecordAudio("425042033", var_139_6)
						arg_136_1:RecordAudio("425042033", var_139_6)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_425042", "425042033", "story_v_out_425042.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_425042", "425042033", "story_v_out_425042.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play425042034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 425042034
		arg_140_1.duration_ = 1.07

		local var_140_0 = {
			zh = 1.066,
			ja = 0.999999999999
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play425042035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if arg_140_1.actors_["1066"] == nil then
				local var_143_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1066")

				if not isNil(var_143_0) then
					local var_143_1 = Object.Instantiate(var_143_0, arg_140_1.canvasGo_.transform)

					var_143_1.transform:SetSiblingIndex(1)

					var_143_1.name = "1066"
					var_143_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_140_1.actors_["1066"] = var_143_1

					if arg_140_1.isInRecall_ then
						for iter_143_0, iter_143_1 in ipairs((var_143_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_143_1.color = arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_143_2 = arg_140_1.actors_["1066"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.actorSpriteComps1066 == nil then
				arg_140_1.var_.actorSpriteComps1066 = var_143_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_3 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_3 and not isNil(var_143_2) then
				if arg_140_1.var_.actorSpriteComps1066 then
					for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_143_3 then
							if arg_140_1.isInRecall_ then
								iter_143_3.color = Color.New(Mathf.Lerp(iter_143_3.color.r, arg_140_1.hightColor1.r, (arg_140_1.time_ - 0) / var_143_3), Mathf.Lerp(iter_143_3.color.g, arg_140_1.hightColor1.g, (arg_140_1.time_ - 0) / var_143_3), (Mathf.Lerp(iter_143_3.color.b, arg_140_1.hightColor1.b, (arg_140_1.time_ - 0) / var_143_3)))
							else
								local var_143_4 = Mathf.Lerp(iter_143_3.color.r, 1, (arg_140_1.time_ - 0) / var_143_3)

								iter_143_3.color = Color.New(var_143_4, var_143_4, var_143_4)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= 0 + var_143_3 and arg_140_1.time_ < 0 + var_143_3 + arg_143_0 and not isNil(var_143_2) and arg_140_1.var_.actorSpriteComps1066 then
				for iter_143_4, iter_143_5 in pairs(arg_140_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_143_5 then
						iter_143_5.color = arg_140_1.isInRecall_ and (arg_140_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_140_1.var_.actorSpriteComps1066 = nil
			end

			local var_143_5 = arg_140_1.actors_["1066"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1066 = var_143_5.localPosition
				var_143_5.localScale = Vector3.New(1, 1, 1)

				arg_140_1:CheckSpriteTmpPos("1066", 3)

				for iter_143_6 = 0, var_143_5.childCount - 1 do
					local var_143_6 = var_143_5:GetChild(iter_143_6)

					if var_143_6.name == "split_4" or not string.find(var_143_6.name, "split") then
						var_143_6.gameObject:SetActive(true)
					else
						var_143_6.gameObject:SetActive(false)
					end
				end
			end

			local var_143_7 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_7 then
				var_143_5.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1066, Vector3.New(-77.5, -399.1, -303.3), (arg_140_1.time_ - 0) / var_143_7)
			end

			if arg_140_1.time_ >= 0 + var_143_7 and arg_140_1.time_ < 0 + var_143_7 + arg_143_0 then
				var_143_5.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_143_8 = 0
			local var_143_9 = 0.075

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_8 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_10 = arg_140_1:GetWordFromCfg(425042034)
				local var_143_11 = arg_140_1:FormatText(var_143_10.content)

				arg_140_1.text_.text = var_143_11

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 3 <= 0 and var_143_9 or var_143_9 * (utf8.len(var_143_11) / 3)

				if (3 <= 0 and var_143_9 or var_143_9 * (utf8.len(var_143_11) / 3)) > 0 and var_143_9 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_8
					end
				end

				arg_140_1.text_.text = var_143_11
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042034", "story_v_out_425042.awb") ~= 0 then
					local var_143_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042034", "story_v_out_425042.awb") / 1000

					if var_143_14 + var_143_8 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_14 + var_143_8
					end

					if var_143_10.prefab_name ~= "" and arg_140_1.actors_[var_143_10.prefab_name] ~= nil then
						local var_143_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_10.prefab_name].transform, "story_v_out_425042", "425042034", "story_v_out_425042.awb")

						arg_140_1:RecordAudio("425042034", var_143_15)
						arg_140_1:RecordAudio("425042034", var_143_15)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_425042", "425042034", "story_v_out_425042.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_425042", "425042034", "story_v_out_425042.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_9, arg_140_1.talkMaxDuration)

			if var_143_8 <= arg_140_1.time_ and arg_140_1.time_ < var_143_8 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_8) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_8 + var_143_16 and arg_140_1.time_ < var_143_8 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play425042035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 425042035
		arg_144_1.duration_ = 3.43

		local var_144_0 = {
			zh = 2.6,
			ja = 3.433
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play425042036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1066"]) and arg_144_1.var_.actorSpriteComps1066 == nil then
				arg_144_1.var_.actorSpriteComps1066 = arg_144_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_0 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1066"]) then
				if arg_144_1.var_.actorSpriteComps1066 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_147_1 then
							if arg_144_1.isInRecall_ then
								iter_147_1.color = Color.New(Mathf.Lerp(iter_147_1.color.r, arg_144_1.hightColor2.r, (arg_144_1.time_ - 0) / var_147_0), Mathf.Lerp(iter_147_1.color.g, arg_144_1.hightColor2.g, (arg_144_1.time_ - 0) / var_147_0), (Mathf.Lerp(iter_147_1.color.b, arg_144_1.hightColor2.b, (arg_144_1.time_ - 0) / var_147_0)))
							else
								local var_147_1 = Mathf.Lerp(iter_147_1.color.r, 0.5, (arg_144_1.time_ - 0) / var_147_0)

								iter_147_1.color = Color.New(var_147_1, var_147_1, var_147_1)
							end
						end
					end
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1066"]) and arg_144_1.var_.actorSpriteComps1066 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_147_3 then
						iter_147_3.color = arg_144_1.isInRecall_ and (arg_144_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_144_1.var_.actorSpriteComps1066 = nil
			end

			local var_147_2 = 0
			local var_147_3 = 0.3

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_2 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1432].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Eden")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_4 = arg_144_1:GetWordFromCfg(425042035)
				local var_147_5 = arg_144_1:FormatText(var_147_4.content)

				arg_144_1.text_.text = var_147_5

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_7 = 12 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 12)

				if (12 <= 0 and var_147_3 or var_147_3 * (utf8.len(var_147_5) / 12)) > 0 and var_147_3 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_2
					end
				end

				arg_144_1.text_.text = var_147_5
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042035", "story_v_out_425042.awb") ~= 0 then
					local var_147_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042035", "story_v_out_425042.awb") / 1000

					if var_147_8 + var_147_2 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_8 + var_147_2
					end

					if var_147_4.prefab_name ~= "" and arg_144_1.actors_[var_147_4.prefab_name] ~= nil then
						local var_147_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_4.prefab_name].transform, "story_v_out_425042", "425042035", "story_v_out_425042.awb")

						arg_144_1:RecordAudio("425042035", var_147_9)
						arg_144_1:RecordAudio("425042035", var_147_9)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_425042", "425042035", "story_v_out_425042.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_425042", "425042035", "story_v_out_425042.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_10 = math.max(var_147_3, arg_144_1.talkMaxDuration)

			if var_147_2 <= arg_144_1.time_ and arg_144_1.time_ < var_147_2 + var_147_10 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_2) / var_147_10

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_2 + var_147_10 and arg_144_1.time_ < var_147_2 + var_147_10 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play425042036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 425042036
		arg_148_1.duration_ = 8.93

		local var_148_0 = {
			zh = 8.933,
			ja = 8.3
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play425042037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["1066"]) and arg_148_1.var_.actorSpriteComps1066 == nil then
				arg_148_1.var_.actorSpriteComps1066 = arg_148_1.actors_["1066"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_151_0 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["1066"]) then
				if arg_148_1.var_.actorSpriteComps1066 then
					for iter_151_0, iter_151_1 in pairs(arg_148_1.var_.actorSpriteComps1066:ToTable()) do
						if iter_151_1 then
							if arg_148_1.isInRecall_ then
								iter_151_1.color = Color.New(Mathf.Lerp(iter_151_1.color.r, arg_148_1.hightColor1.r, (arg_148_1.time_ - 0) / var_151_0), Mathf.Lerp(iter_151_1.color.g, arg_148_1.hightColor1.g, (arg_148_1.time_ - 0) / var_151_0), (Mathf.Lerp(iter_151_1.color.b, arg_148_1.hightColor1.b, (arg_148_1.time_ - 0) / var_151_0)))
							else
								local var_151_1 = Mathf.Lerp(iter_151_1.color.r, 1, (arg_148_1.time_ - 0) / var_151_0)

								iter_151_1.color = Color.New(var_151_1, var_151_1, var_151_1)
							end
						end
					end
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["1066"]) and arg_148_1.var_.actorSpriteComps1066 then
				for iter_151_2, iter_151_3 in pairs(arg_148_1.var_.actorSpriteComps1066:ToTable()) do
					if iter_151_3 then
						iter_151_3.color = arg_148_1.isInRecall_ and (arg_148_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_148_1.var_.actorSpriteComps1066 = nil
			end

			local var_151_2 = arg_148_1.actors_["1066"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1066 = var_151_2.localPosition
				var_151_2.localScale = Vector3.New(1, 1, 1)

				arg_148_1:CheckSpriteTmpPos("1066", 3)

				for iter_151_4 = 0, var_151_2.childCount - 1 do
					local var_151_3 = var_151_2:GetChild(iter_151_4)

					if var_151_3.name == "split_4" or not string.find(var_151_3.name, "split") then
						var_151_3.gameObject:SetActive(true)
					else
						var_151_3.gameObject:SetActive(false)
					end
				end
			end

			local var_151_4 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_4 then
				var_151_2.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1066, Vector3.New(-77.5, -399.1, -303.3), (arg_148_1.time_ - 0) / var_151_4)
			end

			if arg_148_1.time_ >= 0 + var_151_4 and arg_148_1.time_ < 0 + var_151_4 + arg_151_0 then
				var_151_2.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_151_5 = 0
			local var_151_6 = 0.925

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_7 = arg_148_1:GetWordFromCfg(425042036)
				local var_151_8 = arg_148_1:FormatText(var_151_7.content)

				arg_148_1.text_.text = var_151_8

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_10 = 37 <= 0 and var_151_6 or var_151_6 * (utf8.len(var_151_8) / 37)

				if (37 <= 0 and var_151_6 or var_151_6 * (utf8.len(var_151_8) / 37)) > 0 and var_151_6 < var_151_10 then
					arg_148_1.talkMaxDuration = var_151_10

					if var_151_10 + var_151_5 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_10 + var_151_5
					end
				end

				arg_148_1.text_.text = var_151_8
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042036", "story_v_out_425042.awb") ~= 0 then
					local var_151_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042036", "story_v_out_425042.awb") / 1000

					if var_151_11 + var_151_5 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_11 + var_151_5
					end

					if var_151_7.prefab_name ~= "" and arg_148_1.actors_[var_151_7.prefab_name] ~= nil then
						local var_151_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_7.prefab_name].transform, "story_v_out_425042", "425042036", "story_v_out_425042.awb")

						arg_148_1:RecordAudio("425042036", var_151_12)
						arg_148_1:RecordAudio("425042036", var_151_12)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_425042", "425042036", "story_v_out_425042.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_425042", "425042036", "story_v_out_425042.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_13 = math.max(var_151_6, arg_148_1.talkMaxDuration)

			if var_151_5 <= arg_148_1.time_ and arg_148_1.time_ < var_151_5 + var_151_13 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_5) / var_151_13

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_5 + var_151_13 and arg_148_1.time_ < var_151_5 + var_151_13 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play425042037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 425042037
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play425042038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1066 = arg_152_1.actors_["1066"].transform.localPosition
				arg_152_1.actors_["1066"].transform.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("1066", 7)

				for iter_155_0 = 0, arg_152_1.actors_["1066"].transform.childCount - 1 do
					local var_155_0 = arg_152_1.actors_["1066"].transform:GetChild(iter_155_0)

					if var_155_0.name == "" or not string.find(var_155_0.name, "split") then
						var_155_0.gameObject:SetActive(true)
					else
						var_155_0.gameObject:SetActive(false)
					end
				end
			end

			local var_155_1 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_1 then
				arg_152_1.actors_["1066"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1066, Vector3.New(0, -2000, 0), (arg_152_1.time_ - 0) / var_155_1)
			end

			if arg_152_1.time_ >= 0 + var_155_1 and arg_152_1.time_ < 0 + var_155_1 + arg_155_0 then
				arg_152_1.actors_["1066"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_155_2 = 0
			local var_155_3 = 0.75

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_2 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_4 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(425042037).content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_6 = 30 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_4) / 30)

				if (30 <= 0 and var_155_3 or var_155_3 * (utf8.len(var_155_4) / 30)) > 0 and var_155_3 < var_155_6 then
					arg_152_1.talkMaxDuration = var_155_6

					if var_155_6 + var_155_2 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_6 + var_155_2
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_3, arg_152_1.talkMaxDuration)

			if var_155_2 <= arg_152_1.time_ and arg_152_1.time_ < var_155_2 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_2) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_2 + var_155_7 and arg_152_1.time_ < var_155_2 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1066",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play425042038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 425042038
		arg_156_1.duration_ = 9.47

		local var_156_0 = {
			zh = 9.066,
			ja = 9.466
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play425042039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if arg_156_1.actors_["10156"] == nil then
				local var_159_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10156")

				if not isNil(var_159_0) then
					local var_159_1 = Object.Instantiate(var_159_0, arg_156_1.canvasGo_.transform)

					var_159_1.transform:SetSiblingIndex(1)

					var_159_1.name = "10156"
					var_159_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_156_1.actors_["10156"] = var_159_1

					if arg_156_1.isInRecall_ then
						for iter_159_0, iter_159_1 in ipairs((var_159_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_159_1.color = arg_156_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_159_2 = arg_156_1.actors_["10156"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_2) and arg_156_1.var_.actorSpriteComps10156 == nil then
				arg_156_1.var_.actorSpriteComps10156 = var_159_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_3 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_3 and not isNil(var_159_2) then
				if arg_156_1.var_.actorSpriteComps10156 then
					for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_159_3 then
							if arg_156_1.isInRecall_ then
								iter_159_3.color = Color.New(Mathf.Lerp(iter_159_3.color.r, arg_156_1.hightColor1.r, (arg_156_1.time_ - 0) / var_159_3), Mathf.Lerp(iter_159_3.color.g, arg_156_1.hightColor1.g, (arg_156_1.time_ - 0) / var_159_3), (Mathf.Lerp(iter_159_3.color.b, arg_156_1.hightColor1.b, (arg_156_1.time_ - 0) / var_159_3)))
							else
								local var_159_4 = Mathf.Lerp(iter_159_3.color.r, 1, (arg_156_1.time_ - 0) / var_159_3)

								iter_159_3.color = Color.New(var_159_4, var_159_4, var_159_4)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= 0 + var_159_3 and arg_156_1.time_ < 0 + var_159_3 + arg_159_0 and not isNil(var_159_2) and arg_156_1.var_.actorSpriteComps10156 then
				for iter_159_4, iter_159_5 in pairs(arg_156_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_159_5 then
						iter_159_5.color = arg_156_1.isInRecall_ and (arg_156_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_156_1.var_.actorSpriteComps10156 = nil
			end

			local var_159_5 = arg_156_1.actors_["10156"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos10156 = var_159_5.localPosition
				var_159_5.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("10156", 3)

				for iter_159_6 = 0, var_159_5.childCount - 1 do
					local var_159_6 = var_159_5:GetChild(iter_159_6)

					if var_159_6.name == "" or not string.find(var_159_6.name, "split") then
						var_159_6.gameObject:SetActive(true)
					else
						var_159_6.gameObject:SetActive(false)
					end
				end
			end

			local var_159_7 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 then
				var_159_5.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10156, Vector3.New(0, -390, -210), (arg_156_1.time_ - 0) / var_159_7)
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 then
				var_159_5.localPosition = Vector3.New(0, -390, -210)
			end

			local var_159_8 = 0
			local var_159_9 = 1.025

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_8 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_10 = arg_156_1:GetWordFromCfg(425042038)
				local var_159_11 = arg_156_1:FormatText(var_159_10.content)

				arg_156_1.text_.text = var_159_11

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_13 = 41 <= 0 and var_159_9 or var_159_9 * (utf8.len(var_159_11) / 41)

				if (41 <= 0 and var_159_9 or var_159_9 * (utf8.len(var_159_11) / 41)) > 0 and var_159_9 < var_159_13 then
					arg_156_1.talkMaxDuration = var_159_13

					if var_159_13 + var_159_8 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_13 + var_159_8
					end
				end

				arg_156_1.text_.text = var_159_11
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042038", "story_v_out_425042.awb") ~= 0 then
					local var_159_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042038", "story_v_out_425042.awb") / 1000

					if var_159_14 + var_159_8 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_14 + var_159_8
					end

					if var_159_10.prefab_name ~= "" and arg_156_1.actors_[var_159_10.prefab_name] ~= nil then
						local var_159_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_10.prefab_name].transform, "story_v_out_425042", "425042038", "story_v_out_425042.awb")

						arg_156_1:RecordAudio("425042038", var_159_15)
						arg_156_1:RecordAudio("425042038", var_159_15)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_425042", "425042038", "story_v_out_425042.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_425042", "425042038", "story_v_out_425042.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_16 = math.max(var_159_9, arg_156_1.talkMaxDuration)

			if var_159_8 <= arg_156_1.time_ and arg_156_1.time_ < var_159_8 + var_159_16 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_8) / var_159_16

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_8 + var_159_16 and arg_156_1.time_ < var_159_8 + var_159_16 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play425042039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 425042039
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play425042040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["10156"]) and arg_160_1.var_.actorSpriteComps10156 == nil then
				arg_160_1.var_.actorSpriteComps10156 = arg_160_1.actors_["10156"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_0 = 0.2

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["10156"]) then
				if arg_160_1.var_.actorSpriteComps10156 then
					for iter_163_0, iter_163_1 in pairs(arg_160_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_163_1 then
							if arg_160_1.isInRecall_ then
								iter_163_1.color = Color.New(Mathf.Lerp(iter_163_1.color.r, arg_160_1.hightColor2.r, (arg_160_1.time_ - 0) / var_163_0), Mathf.Lerp(iter_163_1.color.g, arg_160_1.hightColor2.g, (arg_160_1.time_ - 0) / var_163_0), (Mathf.Lerp(iter_163_1.color.b, arg_160_1.hightColor2.b, (arg_160_1.time_ - 0) / var_163_0)))
							else
								local var_163_1 = Mathf.Lerp(iter_163_1.color.r, 0.5, (arg_160_1.time_ - 0) / var_163_0)

								iter_163_1.color = Color.New(var_163_1, var_163_1, var_163_1)
							end
						end
					end
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["10156"]) and arg_160_1.var_.actorSpriteComps10156 then
				for iter_163_2, iter_163_3 in pairs(arg_160_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_163_3 then
						iter_163_3.color = arg_160_1.isInRecall_ and (arg_160_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_160_1.var_.actorSpriteComps10156 = nil
			end

			local var_163_2 = arg_160_1.actors_["10156"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos10156 = var_163_2.localPosition
				var_163_2.localScale = Vector3.New(1, 1, 1)

				arg_160_1:CheckSpriteTmpPos("10156", 7)

				for iter_163_4 = 0, var_163_2.childCount - 1 do
					local var_163_3 = var_163_2:GetChild(iter_163_4)

					if var_163_3.name == "" or not string.find(var_163_3.name, "split") then
						var_163_3.gameObject:SetActive(true)
					else
						var_163_3.gameObject:SetActive(false)
					end
				end
			end

			local var_163_4 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_4 then
				var_163_2.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10156, Vector3.New(0, -2000, 0), (arg_160_1.time_ - 0) / var_163_4)
			end

			if arg_160_1.time_ >= 0 + var_163_4 and arg_160_1.time_ < 0 + var_163_4 + arg_163_0 then
				var_163_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_163_5 = 0
			local var_163_6 = 1.225

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_7 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(425042039).content)

				arg_160_1.text_.text = var_163_7

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_9 = 49 <= 0 and var_163_6 or var_163_6 * (utf8.len(var_163_7) / 49)

				if (49 <= 0 and var_163_6 or var_163_6 * (utf8.len(var_163_7) / 49)) > 0 and var_163_6 < var_163_9 then
					arg_160_1.talkMaxDuration = var_163_9

					if var_163_9 + var_163_5 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_9 + var_163_5
					end
				end

				arg_160_1.text_.text = var_163_7
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_6, arg_160_1.talkMaxDuration)

			if var_163_5 <= arg_160_1.time_ and arg_160_1.time_ < var_163_5 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_5) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_5 + var_163_10 and arg_160_1.time_ < var_163_5 + var_163_10 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play425042040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 425042040
		arg_164_1.duration_ = 14.13

		local var_164_0 = {
			zh = 8.366,
			ja = 14.133
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play425042041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["1033"]) and arg_164_1.var_.actorSpriteComps1033 == nil then
				arg_164_1.var_.actorSpriteComps1033 = arg_164_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_167_0 = 0.2

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["1033"]) then
				if arg_164_1.var_.actorSpriteComps1033 then
					for iter_167_0, iter_167_1 in pairs(arg_164_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_167_1 then
							if arg_164_1.isInRecall_ then
								iter_167_1.color = Color.New(Mathf.Lerp(iter_167_1.color.r, arg_164_1.hightColor1.r, (arg_164_1.time_ - 0) / var_167_0), Mathf.Lerp(iter_167_1.color.g, arg_164_1.hightColor1.g, (arg_164_1.time_ - 0) / var_167_0), (Mathf.Lerp(iter_167_1.color.b, arg_164_1.hightColor1.b, (arg_164_1.time_ - 0) / var_167_0)))
							else
								local var_167_1 = Mathf.Lerp(iter_167_1.color.r, 1, (arg_164_1.time_ - 0) / var_167_0)

								iter_167_1.color = Color.New(var_167_1, var_167_1, var_167_1)
							end
						end
					end
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["1033"]) and arg_164_1.var_.actorSpriteComps1033 then
				for iter_167_2, iter_167_3 in pairs(arg_164_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_167_3 then
						iter_167_3.color = arg_164_1.isInRecall_ and (arg_164_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_164_1.var_.actorSpriteComps1033 = nil
			end

			local var_167_2 = arg_164_1.actors_["1033"].transform

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1033 = var_167_2.localPosition
				var_167_2.localScale = Vector3.New(1, 1, 1)

				arg_164_1:CheckSpriteTmpPos("1033", 3)

				for iter_167_4 = 0, var_167_2.childCount - 1 do
					local var_167_3 = var_167_2:GetChild(iter_167_4)

					if var_167_3.name == "" or not string.find(var_167_3.name, "split") then
						var_167_3.gameObject:SetActive(true)
					else
						var_167_3.gameObject:SetActive(false)
					end
				end
			end

			local var_167_4 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_4 then
				var_167_2.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1033, Vector3.New(0, -420, 0), (arg_164_1.time_ - 0) / var_167_4)
			end

			if arg_164_1.time_ >= 0 + var_167_4 and arg_164_1.time_ < 0 + var_167_4 + arg_167_0 then
				var_167_2.localPosition = Vector3.New(0, -420, 0)
			end

			local var_167_5 = 0
			local var_167_6 = 1.1

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_5 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_7 = arg_164_1:GetWordFromCfg(425042040)
				local var_167_8 = arg_164_1:FormatText(var_167_7.content)

				arg_164_1.text_.text = var_167_8

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_10 = 44 <= 0 and var_167_6 or var_167_6 * (utf8.len(var_167_8) / 44)

				if (44 <= 0 and var_167_6 or var_167_6 * (utf8.len(var_167_8) / 44)) > 0 and var_167_6 < var_167_10 then
					arg_164_1.talkMaxDuration = var_167_10

					if var_167_10 + var_167_5 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_10 + var_167_5
					end
				end

				arg_164_1.text_.text = var_167_8
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042040", "story_v_out_425042.awb") ~= 0 then
					local var_167_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042040", "story_v_out_425042.awb") / 1000

					if var_167_11 + var_167_5 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_11 + var_167_5
					end

					if var_167_7.prefab_name ~= "" and arg_164_1.actors_[var_167_7.prefab_name] ~= nil then
						local var_167_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_7.prefab_name].transform, "story_v_out_425042", "425042040", "story_v_out_425042.awb")

						arg_164_1:RecordAudio("425042040", var_167_12)
						arg_164_1:RecordAudio("425042040", var_167_12)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_425042", "425042040", "story_v_out_425042.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_425042", "425042040", "story_v_out_425042.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_13 = math.max(var_167_6, arg_164_1.talkMaxDuration)

			if var_167_5 <= arg_164_1.time_ and arg_164_1.time_ < var_167_5 + var_167_13 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_5) / var_167_13

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_5 + var_167_13 and arg_164_1.time_ < var_167_5 + var_167_13 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play425042041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 425042041
		arg_168_1.duration_ = 12.17

		local var_168_0 = {
			zh = 7.866,
			ja = 12.166
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play425042042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 1.075

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_1 = arg_168_1:GetWordFromCfg(425042041)
				local var_171_2 = arg_168_1:FormatText(var_171_1.content)

				arg_168_1.text_.text = var_171_2

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 43 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 43)

				if (43 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 43)) > 0 and var_171_0 < var_171_4 then
					arg_168_1.talkMaxDuration = var_171_4

					if var_171_4 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_4 + 0
					end
				end

				arg_168_1.text_.text = var_171_2
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042041", "story_v_out_425042.awb") ~= 0 then
					local var_171_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042041", "story_v_out_425042.awb") / 1000

					if var_171_5 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + 0
					end

					if var_171_1.prefab_name ~= "" and arg_168_1.actors_[var_171_1.prefab_name] ~= nil then
						local var_171_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_1.prefab_name].transform, "story_v_out_425042", "425042041", "story_v_out_425042.awb")

						arg_168_1:RecordAudio("425042041", var_171_6)
						arg_168_1:RecordAudio("425042041", var_171_6)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_425042", "425042041", "story_v_out_425042.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_425042", "425042041", "story_v_out_425042.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_7 = math.max(var_171_0, arg_168_1.talkMaxDuration)

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_7 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - 0) / var_171_7

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= 0 + var_171_7 and arg_168_1.time_ < 0 + var_171_7 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play425042042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 425042042
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play425042043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["1033"]) and arg_172_1.var_.actorSpriteComps1033 == nil then
				arg_172_1.var_.actorSpriteComps1033 = arg_172_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_175_0 = 0.2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["1033"]) then
				if arg_172_1.var_.actorSpriteComps1033 then
					for iter_175_0, iter_175_1 in pairs(arg_172_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_175_1 then
							if arg_172_1.isInRecall_ then
								iter_175_1.color = Color.New(Mathf.Lerp(iter_175_1.color.r, arg_172_1.hightColor2.r, (arg_172_1.time_ - 0) / var_175_0), Mathf.Lerp(iter_175_1.color.g, arg_172_1.hightColor2.g, (arg_172_1.time_ - 0) / var_175_0), (Mathf.Lerp(iter_175_1.color.b, arg_172_1.hightColor2.b, (arg_172_1.time_ - 0) / var_175_0)))
							else
								local var_175_1 = Mathf.Lerp(iter_175_1.color.r, 0.5, (arg_172_1.time_ - 0) / var_175_0)

								iter_175_1.color = Color.New(var_175_1, var_175_1, var_175_1)
							end
						end
					end
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["1033"]) and arg_172_1.var_.actorSpriteComps1033 then
				for iter_175_2, iter_175_3 in pairs(arg_172_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_175_3 then
						iter_175_3.color = arg_172_1.isInRecall_ and (arg_172_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_172_1.var_.actorSpriteComps1033 = nil
			end

			local var_175_2 = 0
			local var_175_3 = 0.425

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_2 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_4 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(425042042).content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_6 = 17 <= 0 and var_175_3 or var_175_3 * (utf8.len(var_175_4) / 17)

				if (17 <= 0 and var_175_3 or var_175_3 * (utf8.len(var_175_4) / 17)) > 0 and var_175_3 < var_175_6 then
					arg_172_1.talkMaxDuration = var_175_6

					if var_175_6 + var_175_2 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_6 + var_175_2
					end
				end

				arg_172_1.text_.text = var_175_4
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_3, arg_172_1.talkMaxDuration)

			if var_175_2 <= arg_172_1.time_ and arg_172_1.time_ < var_175_2 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_2) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_2 + var_175_7 and arg_172_1.time_ < var_175_2 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play425042043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 425042043
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play425042044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 1.15

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, true)
				arg_176_1.iconController_:SetSelectedState("hero")

				arg_176_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_176_1.callingController_:SetSelectedState("normal")

				arg_176_1.keyicon_.color = Color.New(1, 1, 1)
				arg_176_1.icon_.color = Color.New(1, 1, 1)

				local var_179_1 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(425042043).content)

				arg_176_1.text_.text = var_179_1

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_3 = 69 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 69)

				if (69 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 69)) > 0 and var_179_0 < var_179_3 then
					arg_176_1.talkMaxDuration = var_179_3

					if var_179_3 + 0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_3 + 0
					end
				end

				arg_176_1.text_.text = var_179_1
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_4 = math.max(var_179_0, arg_176_1.talkMaxDuration)

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_4 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - 0) / var_179_4

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= 0 + var_179_4 and arg_176_1.time_ < 0 + var_179_4 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play425042044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 425042044
		arg_180_1.duration_ = 4.8

		local var_180_0 = {
			zh = 2.833,
			ja = 4.8
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play425042045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["10156"]) and arg_180_1.var_.actorSpriteComps10156 == nil then
				arg_180_1.var_.actorSpriteComps10156 = arg_180_1.actors_["10156"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_183_0 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["10156"]) then
				if arg_180_1.var_.actorSpriteComps10156 then
					for iter_183_0, iter_183_1 in pairs(arg_180_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_183_1 then
							if arg_180_1.isInRecall_ then
								iter_183_1.color = Color.New(Mathf.Lerp(iter_183_1.color.r, arg_180_1.hightColor1.r, (arg_180_1.time_ - 0) / var_183_0), Mathf.Lerp(iter_183_1.color.g, arg_180_1.hightColor1.g, (arg_180_1.time_ - 0) / var_183_0), (Mathf.Lerp(iter_183_1.color.b, arg_180_1.hightColor1.b, (arg_180_1.time_ - 0) / var_183_0)))
							else
								local var_183_1 = Mathf.Lerp(iter_183_1.color.r, 1, (arg_180_1.time_ - 0) / var_183_0)

								iter_183_1.color = Color.New(var_183_1, var_183_1, var_183_1)
							end
						end
					end
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["10156"]) and arg_180_1.var_.actorSpriteComps10156 then
				for iter_183_2, iter_183_3 in pairs(arg_180_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_183_3 then
						iter_183_3.color = arg_180_1.isInRecall_ and (arg_180_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_180_1.var_.actorSpriteComps10156 = nil
			end

			local var_183_2 = arg_180_1.actors_["1033"].transform

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos1033 = var_183_2.localPosition
				var_183_2.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("1033", 7)

				for iter_183_4 = 0, var_183_2.childCount - 1 do
					local var_183_3 = var_183_2:GetChild(iter_183_4)

					if var_183_3.name == "" or not string.find(var_183_3.name, "split") then
						var_183_3.gameObject:SetActive(true)
					else
						var_183_3.gameObject:SetActive(false)
					end
				end
			end

			local var_183_4 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_4 then
				var_183_2.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_180_1.time_ - 0) / var_183_4)
			end

			if arg_180_1.time_ >= 0 + var_183_4 and arg_180_1.time_ < 0 + var_183_4 + arg_183_0 then
				var_183_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_183_5 = arg_180_1.actors_["10156"].transform

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos10156 = var_183_5.localPosition
				var_183_5.localScale = Vector3.New(1, 1, 1)

				arg_180_1:CheckSpriteTmpPos("10156", 3)

				for iter_183_5 = 0, var_183_5.childCount - 1 do
					local var_183_6 = var_183_5:GetChild(iter_183_5)

					if var_183_6.name == "" or not string.find(var_183_6.name, "split") then
						var_183_6.gameObject:SetActive(true)
					else
						var_183_6.gameObject:SetActive(false)
					end
				end
			end

			local var_183_7 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_7 then
				var_183_5.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10156, Vector3.New(0, -390, -210), (arg_180_1.time_ - 0) / var_183_7)
			end

			if arg_180_1.time_ >= 0 + var_183_7 and arg_180_1.time_ < 0 + var_183_7 + arg_183_0 then
				var_183_5.localPosition = Vector3.New(0, -390, -210)
			end

			local var_183_8 = 0
			local var_183_9 = 0.3

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_8 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_10 = arg_180_1:GetWordFromCfg(425042044)
				local var_183_11 = arg_180_1:FormatText(var_183_10.content)

				arg_180_1.text_.text = var_183_11

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_13 = 12 <= 0 and var_183_9 or var_183_9 * (utf8.len(var_183_11) / 12)

				if (12 <= 0 and var_183_9 or var_183_9 * (utf8.len(var_183_11) / 12)) > 0 and var_183_9 < var_183_13 then
					arg_180_1.talkMaxDuration = var_183_13

					if var_183_13 + var_183_8 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_13 + var_183_8
					end
				end

				arg_180_1.text_.text = var_183_11
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042044", "story_v_out_425042.awb") ~= 0 then
					local var_183_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042044", "story_v_out_425042.awb") / 1000

					if var_183_14 + var_183_8 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_14 + var_183_8
					end

					if var_183_10.prefab_name ~= "" and arg_180_1.actors_[var_183_10.prefab_name] ~= nil then
						local var_183_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_10.prefab_name].transform, "story_v_out_425042", "425042044", "story_v_out_425042.awb")

						arg_180_1:RecordAudio("425042044", var_183_15)
						arg_180_1:RecordAudio("425042044", var_183_15)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_425042", "425042044", "story_v_out_425042.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_425042", "425042044", "story_v_out_425042.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_16 = math.max(var_183_9, arg_180_1.talkMaxDuration)

			if var_183_8 <= arg_180_1.time_ and arg_180_1.time_ < var_183_8 + var_183_16 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_8) / var_183_16

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_8 + var_183_16 and arg_180_1.time_ < var_183_8 + var_183_16 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play425042045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 425042045
		arg_184_1.duration_ = 5.53

		local var_184_0 = {
			zh = 5.533,
			ja = 5.233
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play425042046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.var_.moveOldPos10156 = arg_184_1.actors_["10156"].transform.localPosition
				arg_184_1.actors_["10156"].transform.localScale = Vector3.New(1, 1, 1)

				arg_184_1:CheckSpriteTmpPos("10156", 3)

				for iter_187_0 = 0, arg_184_1.actors_["10156"].transform.childCount - 1 do
					local var_187_0 = arg_184_1.actors_["10156"].transform:GetChild(iter_187_0)

					if var_187_0.name == "" or not string.find(var_187_0.name, "split") then
						var_187_0.gameObject:SetActive(true)
					else
						var_187_0.gameObject:SetActive(false)
					end
				end
			end

			local var_187_1 = 0.001

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_1 then
				arg_184_1.actors_["10156"].transform.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10156, Vector3.New(0, -390, -210), (arg_184_1.time_ - 0) / var_187_1)
			end

			if arg_184_1.time_ >= 0 + var_187_1 and arg_184_1.time_ < 0 + var_187_1 + arg_187_0 then
				arg_184_1.actors_["10156"].transform.localPosition = Vector3.New(0, -390, -210)
			end

			local var_187_2 = 0
			local var_187_3 = 0.625

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_2 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_4 = arg_184_1:GetWordFromCfg(425042045)
				local var_187_5 = arg_184_1:FormatText(var_187_4.content)

				arg_184_1.text_.text = var_187_5

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_7 = 25 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 25)

				if (25 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 25)) > 0 and var_187_3 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_2
					end
				end

				arg_184_1.text_.text = var_187_5
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042045", "story_v_out_425042.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042045", "story_v_out_425042.awb") / 1000

					if var_187_8 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_2
					end

					if var_187_4.prefab_name ~= "" and arg_184_1.actors_[var_187_4.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_4.prefab_name].transform, "story_v_out_425042", "425042045", "story_v_out_425042.awb")

						arg_184_1:RecordAudio("425042045", var_187_9)
						arg_184_1:RecordAudio("425042045", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_425042", "425042045", "story_v_out_425042.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_425042", "425042045", "story_v_out_425042.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_3, arg_184_1.talkMaxDuration)

			if var_187_2 <= arg_184_1.time_ and arg_184_1.time_ < var_187_2 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_2) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_2 + var_187_10 and arg_184_1.time_ < var_187_2 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play425042046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 425042046
		arg_188_1.duration_ = 10.93

		local var_188_0 = {
			zh = 7.866,
			ja = 10.933
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play425042047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if arg_188_1.actors_["1037"] == nil then
				local var_191_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1037")

				if not isNil(var_191_0) then
					local var_191_1 = Object.Instantiate(var_191_0, arg_188_1.canvasGo_.transform)

					var_191_1.transform:SetSiblingIndex(1)

					var_191_1.name = "1037"
					var_191_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_188_1.actors_["1037"] = var_191_1

					if arg_188_1.isInRecall_ then
						for iter_191_0, iter_191_1 in ipairs((var_191_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_191_1.color = arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_191_2 = arg_188_1.actors_["1037"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.actorSpriteComps1037 == nil then
				arg_188_1.var_.actorSpriteComps1037 = var_191_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_3 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_3 and not isNil(var_191_2) then
				if arg_188_1.var_.actorSpriteComps1037 then
					for iter_191_2, iter_191_3 in pairs(arg_188_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_191_3 then
							if arg_188_1.isInRecall_ then
								iter_191_3.color = Color.New(Mathf.Lerp(iter_191_3.color.r, arg_188_1.hightColor1.r, (arg_188_1.time_ - 0) / var_191_3), Mathf.Lerp(iter_191_3.color.g, arg_188_1.hightColor1.g, (arg_188_1.time_ - 0) / var_191_3), (Mathf.Lerp(iter_191_3.color.b, arg_188_1.hightColor1.b, (arg_188_1.time_ - 0) / var_191_3)))
							else
								local var_191_4 = Mathf.Lerp(iter_191_3.color.r, 1, (arg_188_1.time_ - 0) / var_191_3)

								iter_191_3.color = Color.New(var_191_4, var_191_4, var_191_4)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_3 and arg_188_1.time_ < 0 + var_191_3 + arg_191_0 and not isNil(var_191_2) and arg_188_1.var_.actorSpriteComps1037 then
				for iter_191_4, iter_191_5 in pairs(arg_188_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_191_5 then
						iter_191_5.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_188_1.var_.actorSpriteComps1037 = nil
			end

			local var_191_5 = arg_188_1.actors_["10156"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_5) and arg_188_1.var_.actorSpriteComps10156 == nil then
				arg_188_1.var_.actorSpriteComps10156 = var_191_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_191_6 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_6 and not isNil(var_191_5) then
				if arg_188_1.var_.actorSpriteComps10156 then
					for iter_191_6, iter_191_7 in pairs(arg_188_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_191_7 then
							if arg_188_1.isInRecall_ then
								iter_191_7.color = Color.New(Mathf.Lerp(iter_191_7.color.r, arg_188_1.hightColor2.r, (arg_188_1.time_ - 0) / var_191_6), Mathf.Lerp(iter_191_7.color.g, arg_188_1.hightColor2.g, (arg_188_1.time_ - 0) / var_191_6), (Mathf.Lerp(iter_191_7.color.b, arg_188_1.hightColor2.b, (arg_188_1.time_ - 0) / var_191_6)))
							else
								local var_191_7 = Mathf.Lerp(iter_191_7.color.r, 0.5, (arg_188_1.time_ - 0) / var_191_6)

								iter_191_7.color = Color.New(var_191_7, var_191_7, var_191_7)
							end
						end
					end
				end
			end

			if arg_188_1.time_ >= 0 + var_191_6 and arg_188_1.time_ < 0 + var_191_6 + arg_191_0 and not isNil(var_191_5) and arg_188_1.var_.actorSpriteComps10156 then
				for iter_191_8, iter_191_9 in pairs(arg_188_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_191_9 then
						iter_191_9.color = arg_188_1.isInRecall_ and (arg_188_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_188_1.var_.actorSpriteComps10156 = nil
			end

			local var_191_8 = arg_188_1.actors_["1037"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1037 = var_191_8.localPosition
				var_191_8.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("1037", 4)

				for iter_191_10 = 0, var_191_8.childCount - 1 do
					local var_191_9 = var_191_8:GetChild(iter_191_10)

					if var_191_9.name == "" or not string.find(var_191_9.name, "split") then
						var_191_9.gameObject:SetActive(true)
					else
						var_191_9.gameObject:SetActive(false)
					end
				end
			end

			local var_191_10 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_10 then
				var_191_8.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_188_1.time_ - 0) / var_191_10)
			end

			if arg_188_1.time_ >= 0 + var_191_10 and arg_188_1.time_ < 0 + var_191_10 + arg_191_0 then
				var_191_8.localPosition = Vector3.New(390, -430, -55)
			end

			local var_191_11 = arg_188_1.actors_["10156"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos10156 = var_191_11.localPosition
				var_191_11.localScale = Vector3.New(1, 1, 1)

				arg_188_1:CheckSpriteTmpPos("10156", 2)

				for iter_191_11 = 0, var_191_11.childCount - 1 do
					local var_191_12 = var_191_11:GetChild(iter_191_11)

					if var_191_12.name == "" or not string.find(var_191_12.name, "split") then
						var_191_12.gameObject:SetActive(true)
					else
						var_191_12.gameObject:SetActive(false)
					end
				end
			end

			local var_191_13 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_13 then
				var_191_11.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10156, Vector3.New(-390, -390, -210), (arg_188_1.time_ - 0) / var_191_13)
			end

			if arg_188_1.time_ >= 0 + var_191_13 and arg_188_1.time_ < 0 + var_191_13 + arg_191_0 then
				var_191_11.localPosition = Vector3.New(-390, -390, -210)
			end

			local var_191_14 = 0
			local var_191_15 = 1.025

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_14 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_16 = arg_188_1:GetWordFromCfg(425042046)
				local var_191_17 = arg_188_1:FormatText(var_191_16.content)

				arg_188_1.text_.text = var_191_17

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_19 = 41 <= 0 and var_191_15 or var_191_15 * (utf8.len(var_191_17) / 41)

				if (41 <= 0 and var_191_15 or var_191_15 * (utf8.len(var_191_17) / 41)) > 0 and var_191_15 < var_191_19 then
					arg_188_1.talkMaxDuration = var_191_19

					if var_191_19 + var_191_14 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_19 + var_191_14
					end
				end

				arg_188_1.text_.text = var_191_17
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042046", "story_v_out_425042.awb") ~= 0 then
					local var_191_20 = manager.audio:GetVoiceLength("story_v_out_425042", "425042046", "story_v_out_425042.awb") / 1000

					if var_191_20 + var_191_14 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_20 + var_191_14
					end

					if var_191_16.prefab_name ~= "" and arg_188_1.actors_[var_191_16.prefab_name] ~= nil then
						local var_191_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_16.prefab_name].transform, "story_v_out_425042", "425042046", "story_v_out_425042.awb")

						arg_188_1:RecordAudio("425042046", var_191_21)
						arg_188_1:RecordAudio("425042046", var_191_21)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_425042", "425042046", "story_v_out_425042.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_425042", "425042046", "story_v_out_425042.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_22 = math.max(var_191_15, arg_188_1.talkMaxDuration)

			if var_191_14 <= arg_188_1.time_ and arg_188_1.time_ < var_191_14 + var_191_22 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_14) / var_191_22

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_14 + var_191_22 and arg_188_1.time_ < var_191_14 + var_191_22 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play425042047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 425042047
		arg_192_1.duration_ = 10.27

		local var_192_0 = {
			zh = 8.2,
			ja = 10.266
		}
		local var_192_1 = manager.audio:GetLocalizationFlag()

		if var_192_0[var_192_1] ~= nil then
			arg_192_1.duration_ = var_192_0[var_192_1]
		end

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play425042048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0.975

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_1 = arg_192_1:GetWordFromCfg(425042047)
				local var_195_2 = arg_192_1:FormatText(var_195_1.content)

				arg_192_1.text_.text = var_195_2

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_4 = 39 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_2) / 39)

				if (39 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_2) / 39)) > 0 and var_195_0 < var_195_4 then
					arg_192_1.talkMaxDuration = var_195_4

					if var_195_4 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_4 + 0
					end
				end

				arg_192_1.text_.text = var_195_2
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042047", "story_v_out_425042.awb") ~= 0 then
					local var_195_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042047", "story_v_out_425042.awb") / 1000

					if var_195_5 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_5 + 0
					end

					if var_195_1.prefab_name ~= "" and arg_192_1.actors_[var_195_1.prefab_name] ~= nil then
						local var_195_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_1.prefab_name].transform, "story_v_out_425042", "425042047", "story_v_out_425042.awb")

						arg_192_1:RecordAudio("425042047", var_195_6)
						arg_192_1:RecordAudio("425042047", var_195_6)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_425042", "425042047", "story_v_out_425042.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_425042", "425042047", "story_v_out_425042.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_7 = math.max(var_195_0, arg_192_1.talkMaxDuration)

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_7 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - 0) / var_195_7

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= 0 + var_195_7 and arg_192_1.time_ < 0 + var_195_7 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play425042048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 425042048
		arg_196_1.duration_ = 10.37

		local var_196_0 = {
			zh = 7.2,
			ja = 10.366
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play425042049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1037 = arg_196_1.actors_["1037"].transform.localPosition
				arg_196_1.actors_["1037"].transform.localScale = Vector3.New(1, 1, 1)

				arg_196_1:CheckSpriteTmpPos("1037", 4)

				for iter_199_0 = 0, arg_196_1.actors_["1037"].transform.childCount - 1 do
					local var_199_0 = arg_196_1.actors_["1037"].transform:GetChild(iter_199_0)

					if var_199_0.name == "split_6" then
						var_199_0:SetAsLastSibling()
						var_199_0.gameObject:SetActive(true)

						arg_196_1.var_.actorSpriteSplit1037 = var_199_0.gameObject:GetComponent(typeof(Image))

						arg_196_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_199_1 = 0.5

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_1 then
				arg_196_1.actors_["1037"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_196_1.time_ - 0) / var_199_1)

				if arg_196_1.var_.actorSpriteSplit1037 ~= nil then
					arg_196_1.var_.actorSpriteSplit1037:SetAlpha((arg_196_1.time_ - 0) / var_199_1)
				end
			end

			if arg_196_1.time_ >= 0 + var_199_1 and arg_196_1.time_ < 0 + var_199_1 + arg_199_0 then
				arg_196_1.actors_["1037"].transform.localPosition = Vector3.New(390, -430, -55)

				if arg_196_1.var_.actorSpriteSplit1037 ~= nil then
					arg_196_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_199_2 = 0
			local var_199_3 = 0.925

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_2 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_4 = arg_196_1:GetWordFromCfg(425042048)
				local var_199_5 = arg_196_1:FormatText(var_199_4.content)

				arg_196_1.text_.text = var_199_5

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_7 = 37 <= 0 and var_199_3 or var_199_3 * (utf8.len(var_199_5) / 37)

				if (37 <= 0 and var_199_3 or var_199_3 * (utf8.len(var_199_5) / 37)) > 0 and var_199_3 < var_199_7 then
					arg_196_1.talkMaxDuration = var_199_7

					if var_199_7 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_7 + var_199_2
					end
				end

				arg_196_1.text_.text = var_199_5
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042048", "story_v_out_425042.awb") ~= 0 then
					local var_199_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042048", "story_v_out_425042.awb") / 1000

					if var_199_8 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_8 + var_199_2
					end

					if var_199_4.prefab_name ~= "" and arg_196_1.actors_[var_199_4.prefab_name] ~= nil then
						local var_199_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_4.prefab_name].transform, "story_v_out_425042", "425042048", "story_v_out_425042.awb")

						arg_196_1:RecordAudio("425042048", var_199_9)
						arg_196_1:RecordAudio("425042048", var_199_9)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_425042", "425042048", "story_v_out_425042.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_425042", "425042048", "story_v_out_425042.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_10 = math.max(var_199_3, arg_196_1.talkMaxDuration)

			if var_199_2 <= arg_196_1.time_ and arg_196_1.time_ < var_199_2 + var_199_10 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_2) / var_199_10

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_2 + var_199_10 and arg_196_1.time_ < var_199_2 + var_199_10 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play425042049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 425042049
		arg_200_1.duration_ = 8.97

		local var_200_0 = {
			zh = 7.166,
			ja = 8.966
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play425042050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["10156"]) and arg_200_1.var_.actorSpriteComps10156 == nil then
				arg_200_1.var_.actorSpriteComps10156 = arg_200_1.actors_["10156"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_0 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["10156"]) then
				if arg_200_1.var_.actorSpriteComps10156 then
					for iter_203_0, iter_203_1 in pairs(arg_200_1.var_.actorSpriteComps10156:ToTable()) do
						if iter_203_1 then
							if arg_200_1.isInRecall_ then
								iter_203_1.color = Color.New(Mathf.Lerp(iter_203_1.color.r, arg_200_1.hightColor1.r, (arg_200_1.time_ - 0) / var_203_0), Mathf.Lerp(iter_203_1.color.g, arg_200_1.hightColor1.g, (arg_200_1.time_ - 0) / var_203_0), (Mathf.Lerp(iter_203_1.color.b, arg_200_1.hightColor1.b, (arg_200_1.time_ - 0) / var_203_0)))
							else
								local var_203_1 = Mathf.Lerp(iter_203_1.color.r, 1, (arg_200_1.time_ - 0) / var_203_0)

								iter_203_1.color = Color.New(var_203_1, var_203_1, var_203_1)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["10156"]) and arg_200_1.var_.actorSpriteComps10156 then
				for iter_203_2, iter_203_3 in pairs(arg_200_1.var_.actorSpriteComps10156:ToTable()) do
					if iter_203_3 then
						iter_203_3.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_200_1.var_.actorSpriteComps10156 = nil
			end

			local var_203_2 = arg_200_1.actors_["1037"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps1037 == nil then
				arg_200_1.var_.actorSpriteComps1037 = var_203_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_203_3 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_3 and not isNil(var_203_2) then
				if arg_200_1.var_.actorSpriteComps1037 then
					for iter_203_4, iter_203_5 in pairs(arg_200_1.var_.actorSpriteComps1037:ToTable()) do
						if iter_203_5 then
							if arg_200_1.isInRecall_ then
								iter_203_5.color = Color.New(Mathf.Lerp(iter_203_5.color.r, arg_200_1.hightColor2.r, (arg_200_1.time_ - 0) / var_203_3), Mathf.Lerp(iter_203_5.color.g, arg_200_1.hightColor2.g, (arg_200_1.time_ - 0) / var_203_3), (Mathf.Lerp(iter_203_5.color.b, arg_200_1.hightColor2.b, (arg_200_1.time_ - 0) / var_203_3)))
							else
								local var_203_4 = Mathf.Lerp(iter_203_5.color.r, 0.5, (arg_200_1.time_ - 0) / var_203_3)

								iter_203_5.color = Color.New(var_203_4, var_203_4, var_203_4)
							end
						end
					end
				end
			end

			if arg_200_1.time_ >= 0 + var_203_3 and arg_200_1.time_ < 0 + var_203_3 + arg_203_0 and not isNil(var_203_2) and arg_200_1.var_.actorSpriteComps1037 then
				for iter_203_6, iter_203_7 in pairs(arg_200_1.var_.actorSpriteComps1037:ToTable()) do
					if iter_203_7 then
						iter_203_7.color = arg_200_1.isInRecall_ and (arg_200_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_200_1.var_.actorSpriteComps1037 = nil
			end

			local var_203_5 = arg_200_1.actors_["10156"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos10156 = var_203_5.localPosition
				var_203_5.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("10156", 2)

				for iter_203_8 = 0, var_203_5.childCount - 1 do
					local var_203_6 = var_203_5:GetChild(iter_203_8)

					if var_203_6.name == "split_3" then
						var_203_6:SetAsLastSibling()
						var_203_6.gameObject:SetActive(true)

						arg_200_1.var_.actorSpriteSplit10156 = var_203_6.gameObject:GetComponent(typeof(Image))

						arg_200_1.var_.actorSpriteSplit10156:SetAlpha(0)
					end
				end
			end

			local var_203_7 = 0.5

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 then
				var_203_5.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos10156, Vector3.New(-390, -390, -210), (arg_200_1.time_ - 0) / var_203_7)

				if arg_200_1.var_.actorSpriteSplit10156 ~= nil then
					arg_200_1.var_.actorSpriteSplit10156:SetAlpha((arg_200_1.time_ - 0) / var_203_7)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				var_203_5.localPosition = Vector3.New(-390, -390, -210)

				if arg_200_1.var_.actorSpriteSplit10156 ~= nil then
					arg_200_1.var_.actorSpriteSplit10156:SetAlpha(1)
				end
			end

			local var_203_8 = arg_200_1.actors_["1037"].transform

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos1037 = var_203_8.localPosition
				var_203_8.localScale = Vector3.New(1, 1, 1)

				arg_200_1:CheckSpriteTmpPos("1037", 4)

				for iter_203_9 = 0, var_203_8.childCount - 1 do
					local var_203_9 = var_203_8:GetChild(iter_203_9)

					if var_203_9.name == "split_1" then
						var_203_9:SetAsLastSibling()
						var_203_9.gameObject:SetActive(true)

						arg_200_1.var_.actorSpriteSplit1037 = var_203_9.gameObject:GetComponent(typeof(Image))

						arg_200_1.var_.actorSpriteSplit1037:SetAlpha(0)
					end
				end
			end

			local var_203_10 = 0.2

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_10 then
				var_203_8.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1037, Vector3.New(390, -430, -55), (arg_200_1.time_ - 0) / var_203_10)

				if arg_200_1.var_.actorSpriteSplit1037 ~= nil then
					arg_200_1.var_.actorSpriteSplit1037:SetAlpha((arg_200_1.time_ - 0) / var_203_10)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_10 and arg_200_1.time_ < 0 + var_203_10 + arg_203_0 then
				var_203_8.localPosition = Vector3.New(390, -430, -55)

				if arg_200_1.var_.actorSpriteSplit1037 ~= nil then
					arg_200_1.var_.actorSpriteSplit1037:SetAlpha(1)
				end
			end

			local var_203_11 = 0
			local var_203_12 = 0.825

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_11 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_13 = arg_200_1:GetWordFromCfg(425042049)
				local var_203_14 = arg_200_1:FormatText(var_203_13.content)

				arg_200_1.text_.text = var_203_14

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_16 = 33 <= 0 and var_203_12 or var_203_12 * (utf8.len(var_203_14) / 33)

				if (33 <= 0 and var_203_12 or var_203_12 * (utf8.len(var_203_14) / 33)) > 0 and var_203_12 < var_203_16 then
					arg_200_1.talkMaxDuration = var_203_16

					if var_203_16 + var_203_11 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_16 + var_203_11
					end
				end

				arg_200_1.text_.text = var_203_14
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042049", "story_v_out_425042.awb") ~= 0 then
					local var_203_17 = manager.audio:GetVoiceLength("story_v_out_425042", "425042049", "story_v_out_425042.awb") / 1000

					if var_203_17 + var_203_11 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_17 + var_203_11
					end

					if var_203_13.prefab_name ~= "" and arg_200_1.actors_[var_203_13.prefab_name] ~= nil then
						local var_203_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_13.prefab_name].transform, "story_v_out_425042", "425042049", "story_v_out_425042.awb")

						arg_200_1:RecordAudio("425042049", var_203_18)
						arg_200_1:RecordAudio("425042049", var_203_18)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_425042", "425042049", "story_v_out_425042.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_425042", "425042049", "story_v_out_425042.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_19 = math.max(var_203_12, arg_200_1.talkMaxDuration)

			if var_203_11 <= arg_200_1.time_ and arg_200_1.time_ < var_203_11 + var_203_19 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_11) / var_203_19

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_11 + var_203_19 and arg_200_1.time_ < var_203_11 + var_203_19 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play425042050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 425042050
		arg_204_1.duration_ = 9.9

		local var_204_0 = {
			zh = 8.133,
			ja = 9.9
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play425042051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 0.975

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_1 = arg_204_1:GetWordFromCfg(425042050)
				local var_207_2 = arg_204_1:FormatText(var_207_1.content)

				arg_204_1.text_.text = var_207_2

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 39 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 39)

				if (39 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 39)) > 0 and var_207_0 < var_207_4 then
					arg_204_1.talkMaxDuration = var_207_4

					if var_207_4 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_4 + 0
					end
				end

				arg_204_1.text_.text = var_207_2
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042050", "story_v_out_425042.awb") ~= 0 then
					local var_207_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042050", "story_v_out_425042.awb") / 1000

					if var_207_5 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_5 + 0
					end

					if var_207_1.prefab_name ~= "" and arg_204_1.actors_[var_207_1.prefab_name] ~= nil then
						local var_207_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_1.prefab_name].transform, "story_v_out_425042", "425042050", "story_v_out_425042.awb")

						arg_204_1:RecordAudio("425042050", var_207_6)
						arg_204_1:RecordAudio("425042050", var_207_6)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_425042", "425042050", "story_v_out_425042.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_425042", "425042050", "story_v_out_425042.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_7 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_7 and arg_204_1.time_ < 0 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play425042051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 425042051
		arg_208_1.duration_ = 13.4

		local var_208_0 = {
			zh = 12.366,
			ja = 13.4
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play425042052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 1.425

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_1 = arg_208_1:GetWordFromCfg(425042051)
				local var_211_2 = arg_208_1:FormatText(var_211_1.content)

				arg_208_1.text_.text = var_211_2

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_4 = 57 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 57)

				if (57 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 57)) > 0 and var_211_0 < var_211_4 then
					arg_208_1.talkMaxDuration = var_211_4

					if var_211_4 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_4 + 0
					end
				end

				arg_208_1.text_.text = var_211_2
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042051", "story_v_out_425042.awb") ~= 0 then
					local var_211_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042051", "story_v_out_425042.awb") / 1000

					if var_211_5 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + 0
					end

					if var_211_1.prefab_name ~= "" and arg_208_1.actors_[var_211_1.prefab_name] ~= nil then
						local var_211_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_1.prefab_name].transform, "story_v_out_425042", "425042051", "story_v_out_425042.awb")

						arg_208_1:RecordAudio("425042051", var_211_6)
						arg_208_1:RecordAudio("425042051", var_211_6)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_425042", "425042051", "story_v_out_425042.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_425042", "425042051", "story_v_out_425042.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_7 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_7 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_7

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_7 and arg_208_1.time_ < 0 + var_211_7 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play425042052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 425042052
		arg_212_1.duration_ = 3.9

		local var_212_0 = {
			zh = 2.466,
			ja = 3.9
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play425042053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos10156 = arg_212_1.actors_["10156"].transform.localPosition
				arg_212_1.actors_["10156"].transform.localScale = Vector3.New(1, 1, 1)

				arg_212_1:CheckSpriteTmpPos("10156", 2)

				for iter_215_0 = 0, arg_212_1.actors_["10156"].transform.childCount - 1 do
					local var_215_0 = arg_212_1.actors_["10156"].transform:GetChild(iter_215_0)

					if var_215_0.name == "" then
						var_215_0:SetAsLastSibling()
						var_215_0.gameObject:SetActive(true)

						arg_212_1.var_.actorSpriteSplit10156 = var_215_0.gameObject:GetComponent(typeof(Image))

						arg_212_1.var_.actorSpriteSplit10156:SetAlpha(0)
					end
				end
			end

			local var_215_1 = 0.5

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_1 then
				arg_212_1.actors_["10156"].transform.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10156, Vector3.New(-390, -390, -210), (arg_212_1.time_ - 0) / var_215_1)

				if arg_212_1.var_.actorSpriteSplit10156 ~= nil then
					arg_212_1.var_.actorSpriteSplit10156:SetAlpha((arg_212_1.time_ - 0) / var_215_1)
				end
			end

			if arg_212_1.time_ >= 0 + var_215_1 and arg_212_1.time_ < 0 + var_215_1 + arg_215_0 then
				arg_212_1.actors_["10156"].transform.localPosition = Vector3.New(-390, -390, -210)

				if arg_212_1.var_.actorSpriteSplit10156 ~= nil then
					arg_212_1.var_.actorSpriteSplit10156:SetAlpha(1)
				end
			end

			local var_215_2 = 0
			local var_215_3 = 0.35

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_2 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[1433].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_4 = arg_212_1:GetWordFromCfg(425042052)
				local var_215_5 = arg_212_1:FormatText(var_215_4.content)

				arg_212_1.text_.text = var_215_5

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_7 = 14 <= 0 and var_215_3 or var_215_3 * (utf8.len(var_215_5) / 14)

				if (14 <= 0 and var_215_3 or var_215_3 * (utf8.len(var_215_5) / 14)) > 0 and var_215_3 < var_215_7 then
					arg_212_1.talkMaxDuration = var_215_7

					if var_215_7 + var_215_2 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_7 + var_215_2
					end
				end

				arg_212_1.text_.text = var_215_5
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042052", "story_v_out_425042.awb") ~= 0 then
					local var_215_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042052", "story_v_out_425042.awb") / 1000

					if var_215_8 + var_215_2 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_8 + var_215_2
					end

					if var_215_4.prefab_name ~= "" and arg_212_1.actors_[var_215_4.prefab_name] ~= nil then
						local var_215_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_4.prefab_name].transform, "story_v_out_425042", "425042052", "story_v_out_425042.awb")

						arg_212_1:RecordAudio("425042052", var_215_9)
						arg_212_1:RecordAudio("425042052", var_215_9)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_425042", "425042052", "story_v_out_425042.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_425042", "425042052", "story_v_out_425042.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_10 = math.max(var_215_3, arg_212_1.talkMaxDuration)

			if var_215_2 <= arg_212_1.time_ and arg_212_1.time_ < var_215_2 + var_215_10 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_2) / var_215_10

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_2 + var_215_10 and arg_212_1.time_ < var_215_2 + var_215_10 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play425042053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 425042053
		arg_216_1.duration_ = 19.17

		local var_216_0 = {
			zh = 13.199999999999,
			ja = 19.165999999999
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play425042054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 5.399999999999 < arg_216_1.time_ and arg_216_1.time_ <= 5.399999999999 + arg_219_0 then
				arg_216_1.allBtn_.enabled = false
			end

			if arg_216_1.time_ >= 5.399999999999 + 0.3 and arg_216_1.time_ < 5.399999999999 + 0.3 + arg_219_0 then
				arg_216_1.allBtn_.enabled = true
			end

			local var_219_0 = "10127"

			if arg_216_1.actors_["10127"] == nil then
				local var_219_1 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10127")

				if not isNil(var_219_1) then
					local var_219_2 = Object.Instantiate(var_219_1, arg_216_1.canvasGo_.transform)

					var_219_2.transform:SetSiblingIndex(1)

					var_219_2.name = var_219_0
					var_219_2.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_216_1.actors_[var_219_0] = var_219_2

					if arg_216_1.isInRecall_ then
						for iter_219_0, iter_219_1 in ipairs((var_219_2:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_219_1.color = arg_216_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_219_3 = arg_216_1.actors_["10127"]

			if 5.199999999999 < arg_216_1.time_ and arg_216_1.time_ <= 5.199999999999 + arg_219_0 and not isNil(var_219_3) and arg_216_1.var_.actorSpriteComps10127 == nil then
				arg_216_1.var_.actorSpriteComps10127 = var_219_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_219_4 = 0.2

			if 5.199999999999 <= arg_216_1.time_ and arg_216_1.time_ < 5.199999999999 + var_219_4 and not isNil(var_219_3) then
				if arg_216_1.var_.actorSpriteComps10127 then
					for iter_219_2, iter_219_3 in pairs(arg_216_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_219_3 then
							if arg_216_1.isInRecall_ then
								iter_219_3.color = Color.New(Mathf.Lerp(iter_219_3.color.r, arg_216_1.hightColor1.r, (arg_216_1.time_ - 5.199999999999) / var_219_4), Mathf.Lerp(iter_219_3.color.g, arg_216_1.hightColor1.g, (arg_216_1.time_ - 5.199999999999) / var_219_4), (Mathf.Lerp(iter_219_3.color.b, arg_216_1.hightColor1.b, (arg_216_1.time_ - 5.199999999999) / var_219_4)))
							else
								local var_219_5 = Mathf.Lerp(iter_219_3.color.r, 1, (arg_216_1.time_ - 5.199999999999) / var_219_4)

								iter_219_3.color = Color.New(var_219_5, var_219_5, var_219_5)
							end
						end
					end
				end
			end

			if arg_216_1.time_ >= 5.199999999999 + var_219_4 and arg_216_1.time_ < 5.199999999999 + var_219_4 + arg_219_0 and not isNil(var_219_3) and arg_216_1.var_.actorSpriteComps10127 then
				for iter_219_4, iter_219_5 in pairs(arg_216_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_219_5 then
						iter_219_5.color = arg_216_1.isInRecall_ and (arg_216_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_216_1.var_.actorSpriteComps10127 = nil
			end

			local var_219_6 = 0

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_6 + arg_219_0 then
				arg_216_1.mask_.enabled = true
				arg_216_1.mask_.raycastTarget = true

				arg_216_1:SetGaussion(false)
			end

			local var_219_7 = 1

			if var_219_6 <= arg_216_1.time_ and arg_216_1.time_ < var_219_6 + var_219_7 then
				local var_219_8 = Color.New(0, 0, 0)

				var_219_8.a = Mathf.Lerp(0, 1, (arg_216_1.time_ - var_219_6) / var_219_7)
				arg_216_1.mask_.color = var_219_8
			end

			if arg_216_1.time_ >= var_219_6 + var_219_7 and arg_216_1.time_ < var_219_6 + var_219_7 + arg_219_0 then
				local var_219_9 = Color.New(0, 0, 0)

				var_219_9.a = 1
				arg_216_1.mask_.color = var_219_9
			end

			local var_219_10 = 1

			if 1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_10 + arg_219_0 then
				arg_216_1.mask_.enabled = true
				arg_216_1.mask_.raycastTarget = true

				arg_216_1:SetGaussion(false)
			end

			local var_219_11 = 0.999999999999996

			if var_219_10 <= arg_216_1.time_ and arg_216_1.time_ < var_219_10 + var_219_11 then
				local var_219_12 = Color.New(0, 0, 0)

				var_219_12.a = Mathf.Lerp(1, 0, (arg_216_1.time_ - var_219_10) / var_219_11)
				arg_216_1.mask_.color = var_219_12
			end

			if arg_216_1.time_ >= var_219_10 + var_219_11 and arg_216_1.time_ < var_219_10 + var_219_11 + arg_219_0 then
				local var_219_13 = Color.New(0, 0, 0)

				arg_216_1.mask_.enabled = false
				var_219_13.a = 0
				arg_216_1.mask_.color = var_219_13
			end

			local var_219_14 = arg_216_1.actors_["10127"].transform

			if 5.199999999999 < arg_216_1.time_ and arg_216_1.time_ <= 5.199999999999 + arg_219_0 then
				arg_216_1.var_.moveOldPos10127 = var_219_14.localPosition
				var_219_14.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("10127", 3)

				for iter_219_6 = 0, var_219_14.childCount - 1 do
					local var_219_15 = var_219_14:GetChild(iter_219_6)

					if var_219_15.name == "split_1" or not string.find(var_219_15.name, "split") then
						var_219_15.gameObject:SetActive(true)
					else
						var_219_15.gameObject:SetActive(false)
					end
				end
			end

			local var_219_16 = 0.001

			if 5.199999999999 <= arg_216_1.time_ and arg_216_1.time_ < 5.199999999999 + var_219_16 then
				var_219_14.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10127, Vector3.New(0, -387.4, -316.5), (arg_216_1.time_ - 5.199999999999) / var_219_16)
			end

			if arg_216_1.time_ >= 5.199999999999 + var_219_16 and arg_216_1.time_ < 5.199999999999 + var_219_16 + arg_219_0 then
				var_219_14.localPosition = Vector3.New(0, -387.4, -316.5)
			end

			local var_219_17 = arg_216_1.actors_["10156"].transform

			if 1 < arg_216_1.time_ and arg_216_1.time_ <= 1 + arg_219_0 then
				arg_216_1.var_.moveOldPos10156 = var_219_17.localPosition
				var_219_17.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("10156", 7)

				for iter_219_7 = 0, var_219_17.childCount - 1 do
					local var_219_18 = var_219_17:GetChild(iter_219_7)

					if var_219_18.name == "" or not string.find(var_219_18.name, "split") then
						var_219_18.gameObject:SetActive(true)
					else
						var_219_18.gameObject:SetActive(false)
					end
				end
			end

			local var_219_19 = 0.001

			if 1 <= arg_216_1.time_ and arg_216_1.time_ < 1 + var_219_19 then
				var_219_17.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10156, Vector3.New(0, -2000, 0), (arg_216_1.time_ - 1) / var_219_19)
			end

			if arg_216_1.time_ >= 1 + var_219_19 and arg_216_1.time_ < 1 + var_219_19 + arg_219_0 then
				var_219_17.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_219_20 = arg_216_1.actors_["1037"].transform

			if 1 < arg_216_1.time_ and arg_216_1.time_ <= 1 + arg_219_0 then
				arg_216_1.var_.moveOldPos1037 = var_219_20.localPosition
				var_219_20.localScale = Vector3.New(1, 1, 1)

				arg_216_1:CheckSpriteTmpPos("1037", 7)

				for iter_219_8 = 0, var_219_20.childCount - 1 do
					local var_219_21 = var_219_20:GetChild(iter_219_8)

					if var_219_21.name == "" or not string.find(var_219_21.name, "split") then
						var_219_21.gameObject:SetActive(true)
					else
						var_219_21.gameObject:SetActive(false)
					end
				end
			end

			local var_219_22 = 0.001

			if 1 <= arg_216_1.time_ and arg_216_1.time_ < 1 + var_219_22 then
				var_219_20.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1037, Vector3.New(1500, -2000, 0), (arg_216_1.time_ - 1) / var_219_22)
			end

			if arg_216_1.time_ >= 1 + var_219_22 and arg_216_1.time_ < 1 + var_219_22 + arg_219_0 then
				var_219_20.localPosition = Vector3.New(1500, -2000, 0)
			end

			local var_219_23 = 1

			if 1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_23 + arg_219_0 then
				arg_216_1.timestampController_:SetSelectedState("show")
				arg_216_1.timestampAni_:Play("in")

				arg_216_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST18")

				arg_216_1.timestampColorController_:SetSelectedState("hot")
				arg_216_1.timeColdImg_:SetAlpha(0.031)

				arg_216_1.text_timeText_.text = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(501108).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_timeText_)

				arg_216_1.text_siteText_.text = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(501118).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_siteText_)
			end

			if arg_216_1.time_ >= var_219_23 + 1.999999999999 and arg_216_1.time_ < var_219_23 + 1.999999999999 + arg_219_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_216_1.timestampAni_, "out", function()
					arg_216_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_219_24 = 2.999999999999

			if 2.999999999999 < arg_216_1.time_ and arg_216_1.time_ <= var_219_24 + arg_219_0 then
				arg_216_1.mask_.enabled = true
				arg_216_1.mask_.raycastTarget = true

				arg_216_1:SetGaussion(false)
			end

			local var_219_25 = 1.2

			if var_219_24 <= arg_216_1.time_ and arg_216_1.time_ < var_219_24 + var_219_25 then
				local var_219_26 = Color.New(0, 0, 0)

				var_219_26.a = Mathf.Lerp(0, 1, (arg_216_1.time_ - var_219_24) / var_219_25)
				arg_216_1.mask_.color = var_219_26
			end

			if arg_216_1.time_ >= var_219_24 + var_219_25 and arg_216_1.time_ < var_219_24 + var_219_25 + arg_219_0 then
				local var_219_27 = Color.New(0, 0, 0)

				var_219_27.a = 1
				arg_216_1.mask_.color = var_219_27
			end

			local var_219_28 = 4.199999999999

			if 4.199999999999 < arg_216_1.time_ and arg_216_1.time_ <= var_219_28 + arg_219_0 then
				arg_216_1.mask_.enabled = true
				arg_216_1.mask_.raycastTarget = true

				arg_216_1:SetGaussion(false)
			end

			local var_219_29 = 1.2

			if var_219_28 <= arg_216_1.time_ and arg_216_1.time_ < var_219_28 + var_219_29 then
				local var_219_30 = Color.New(0, 0, 0)

				var_219_30.a = Mathf.Lerp(1, 0, (arg_216_1.time_ - var_219_28) / var_219_29)
				arg_216_1.mask_.color = var_219_30
			end

			if arg_216_1.time_ >= var_219_28 + var_219_29 and arg_216_1.time_ < var_219_28 + var_219_29 + arg_219_0 then
				local var_219_31 = Color.New(0, 0, 0)

				arg_216_1.mask_.enabled = false
				var_219_31.a = 0
				arg_216_1.mask_.color = var_219_31
			end

			local var_219_32 = "ST18"

			if arg_216_1.bgs_.ST18 == nil then
				local var_219_33 = Object.Instantiate(arg_216_1.paintGo_)

				var_219_33:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_219_32)
				var_219_33.name = var_219_32
				var_219_33.transform.parent = arg_216_1.stage_.transform
				var_219_33.transform.localPosition = Vector3.New(0, 100, 0)
				arg_216_1.bgs_[var_219_32] = var_219_33
			end

			if 1 < arg_216_1.time_ and arg_216_1.time_ <= 1 + arg_219_0 then
				local var_219_34 = arg_216_1.bgs_.ST18

				arg_216_1.bgs_.ST18.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_219_34.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_219_35 = var_219_34:GetComponent("SpriteRenderer")

				if var_219_35 and var_219_35.sprite then
					local var_219_36 = 2 * (var_219_34.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_219_34.transform.localScale = Vector3.New(var_219_36 / var_219_35.sprite.bounds.size.y < var_219_36 * manager.ui.mainCameraCom_.aspect / var_219_35.sprite.bounds.size.x and var_219_36 * manager.ui.mainCameraCom_.aspect / var_219_35.sprite.bounds.size.x or var_219_36 / var_219_35.sprite.bounds.size.y, var_219_36 / var_219_35.sprite.bounds.size.y < var_219_36 * manager.ui.mainCameraCom_.aspect / var_219_35.sprite.bounds.size.x and var_219_36 * manager.ui.mainCameraCom_.aspect / var_219_35.sprite.bounds.size.x or var_219_36 / var_219_35.sprite.bounds.size.y, 0)
				end

				for iter_219_9, iter_219_10 in pairs(arg_216_1.bgs_) do
					if iter_219_9 ~= "ST18" then
						iter_219_10.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 4.199999999999 < arg_216_1.time_ and arg_216_1.time_ <= 4.199999999999 + arg_219_0 then
				local var_219_37 = arg_216_1.actors_["10127"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_219_37 then
					arg_216_1.var_.alphaOldValue10127 = var_219_37.alpha
					arg_216_1.var_.characterEffect10127 = var_219_37
				end

				arg_216_1.var_.alphaOldValue10127 = 0
			end

			local var_219_38 = 1.2

			if 4.199999999999 <= arg_216_1.time_ and arg_216_1.time_ < 4.199999999999 + var_219_38 then
				if arg_216_1.var_.characterEffect10127 then
					arg_216_1.var_.characterEffect10127.alpha = Mathf.Lerp(arg_216_1.var_.alphaOldValue10127, 1, (arg_216_1.time_ - 4.199999999999) / var_219_38)
				end
			end

			if arg_216_1.time_ >= 4.199999999999 + var_219_38 and arg_216_1.time_ < 4.199999999999 + var_219_38 + arg_219_0 and arg_216_1.var_.characterEffect10127 then
				arg_216_1.var_.characterEffect10127.alpha = 1
			end

			if arg_216_1.frameCnt_ <= 1 then
				arg_216_1.dialog_:SetActive(false)
			end

			local var_219_39 = 5.399999999999
			local var_219_40 = 0.9

			if 5.399999999999 < arg_216_1.time_ and arg_216_1.time_ <= var_219_39 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0

				arg_216_1.dialog_:SetActive(true)

				arg_216_1.dialogCg_.alpha = 0

				local var_219_41 = LeanTween.value(arg_216_1.dialog_, 0, 1, 0.3)

				var_219_41:setOnUpdate(LuaHelper.FloatAction(function(arg_221_0)
					arg_216_1.dialogCg_.alpha = arg_221_0
				end))
				var_219_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_216_1.dialog_)
					var_219_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_216_1.duration_ = arg_216_1.duration_ + 0.3

				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_42 = arg_216_1:GetWordFromCfg(425042053)
				local var_219_43 = arg_216_1:FormatText(var_219_42.content)

				arg_216_1.text_.text = var_219_43

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_45 = 36 <= 0 and var_219_40 or var_219_40 * (utf8.len(var_219_43) / 36)

				if (36 <= 0 and var_219_40 or var_219_40 * (utf8.len(var_219_43) / 36)) > 0 and var_219_40 < var_219_45 then
					arg_216_1.talkMaxDuration = var_219_45
					var_219_39 = var_219_39 + 0.3

					if var_219_45 + var_219_39 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_45 + var_219_39
					end
				end

				arg_216_1.text_.text = var_219_43
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042053", "story_v_out_425042.awb") ~= 0 then
					local var_219_46 = manager.audio:GetVoiceLength("story_v_out_425042", "425042053", "story_v_out_425042.awb") / 1000

					if var_219_46 + var_219_39 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_46 + var_219_39
					end

					if var_219_42.prefab_name ~= "" and arg_216_1.actors_[var_219_42.prefab_name] ~= nil then
						local var_219_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_42.prefab_name].transform, "story_v_out_425042", "425042053", "story_v_out_425042.awb")

						arg_216_1:RecordAudio("425042053", var_219_47)
						arg_216_1:RecordAudio("425042053", var_219_47)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_425042", "425042053", "story_v_out_425042.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_425042", "425042053", "story_v_out_425042.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_48 = var_219_39 + 0.3
			local var_219_49 = math.max(var_219_40, arg_216_1.talkMaxDuration)

			if var_219_39 + 0.3 <= arg_216_1.time_ and arg_216_1.time_ < var_219_48 + var_219_49 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_48) / var_219_49

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_48 + var_219_49 and arg_216_1.time_ < var_219_48 + var_219_49 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 5.199999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10156",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1037",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play425042054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 425042054
		arg_223_1.duration_ = 9.77

		local var_223_0 = {
			zh = 5.766,
			ja = 9.766
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
				arg_223_0:Play425042055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.75

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_1 = arg_223_1:GetWordFromCfg(425042054)
				local var_226_2 = arg_223_1:FormatText(var_226_1.content)

				arg_223_1.text_.text = var_226_2

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_4 = 30 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 30)

				if (30 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_2) / 30)) > 0 and var_226_0 < var_226_4 then
					arg_223_1.talkMaxDuration = var_226_4

					if var_226_4 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_4 + 0
					end
				end

				arg_223_1.text_.text = var_226_2
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042054", "story_v_out_425042.awb") ~= 0 then
					local var_226_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042054", "story_v_out_425042.awb") / 1000

					if var_226_5 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + 0
					end

					if var_226_1.prefab_name ~= "" and arg_223_1.actors_[var_226_1.prefab_name] ~= nil then
						local var_226_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_1.prefab_name].transform, "story_v_out_425042", "425042054", "story_v_out_425042.awb")

						arg_223_1:RecordAudio("425042054", var_226_6)
						arg_223_1:RecordAudio("425042054", var_226_6)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_425042", "425042054", "story_v_out_425042.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_425042", "425042054", "story_v_out_425042.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_7 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_7 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_7

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_7 and arg_223_1.time_ < 0 + var_226_7 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play425042055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 425042055
		arg_227_1.duration_ = 12.87

		local var_227_0 = {
			zh = 7.766,
			ja = 12.866
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
				arg_227_0:Play425042056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(arg_227_1.actors_["1137"]) and arg_227_1.var_.actorSpriteComps1137 == nil then
				arg_227_1.var_.actorSpriteComps1137 = arg_227_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_0 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 and not isNil(arg_227_1.actors_["1137"]) then
				if arg_227_1.var_.actorSpriteComps1137 then
					for iter_230_0, iter_230_1 in pairs(arg_227_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_230_1 then
							if arg_227_1.isInRecall_ then
								iter_230_1.color = Color.New(Mathf.Lerp(iter_230_1.color.r, arg_227_1.hightColor1.r, (arg_227_1.time_ - 0) / var_230_0), Mathf.Lerp(iter_230_1.color.g, arg_227_1.hightColor1.g, (arg_227_1.time_ - 0) / var_230_0), (Mathf.Lerp(iter_230_1.color.b, arg_227_1.hightColor1.b, (arg_227_1.time_ - 0) / var_230_0)))
							else
								local var_230_1 = Mathf.Lerp(iter_230_1.color.r, 1, (arg_227_1.time_ - 0) / var_230_0)

								iter_230_1.color = Color.New(var_230_1, var_230_1, var_230_1)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 and not isNil(arg_227_1.actors_["1137"]) and arg_227_1.var_.actorSpriteComps1137 then
				for iter_230_2, iter_230_3 in pairs(arg_227_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_230_3 then
						iter_230_3.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_227_1.var_.actorSpriteComps1137 = nil
			end

			local var_230_2 = arg_227_1.actors_["10127"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_2) and arg_227_1.var_.actorSpriteComps10127 == nil then
				arg_227_1.var_.actorSpriteComps10127 = var_230_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_230_3 = 0.2

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_3 and not isNil(var_230_2) then
				if arg_227_1.var_.actorSpriteComps10127 then
					for iter_230_4, iter_230_5 in pairs(arg_227_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_230_5 then
							if arg_227_1.isInRecall_ then
								iter_230_5.color = Color.New(Mathf.Lerp(iter_230_5.color.r, arg_227_1.hightColor2.r, (arg_227_1.time_ - 0) / var_230_3), Mathf.Lerp(iter_230_5.color.g, arg_227_1.hightColor2.g, (arg_227_1.time_ - 0) / var_230_3), (Mathf.Lerp(iter_230_5.color.b, arg_227_1.hightColor2.b, (arg_227_1.time_ - 0) / var_230_3)))
							else
								local var_230_4 = Mathf.Lerp(iter_230_5.color.r, 0.5, (arg_227_1.time_ - 0) / var_230_3)

								iter_230_5.color = Color.New(var_230_4, var_230_4, var_230_4)
							end
						end
					end
				end
			end

			if arg_227_1.time_ >= 0 + var_230_3 and arg_227_1.time_ < 0 + var_230_3 + arg_230_0 and not isNil(var_230_2) and arg_227_1.var_.actorSpriteComps10127 then
				for iter_230_6, iter_230_7 in pairs(arg_227_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_230_7 then
						iter_230_7.color = arg_227_1.isInRecall_ and (arg_227_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_227_1.var_.actorSpriteComps10127 = nil
			end

			local var_230_5 = arg_227_1.actors_["1137"].transform

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos1137 = var_230_5.localPosition
				var_230_5.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("1137", 4)

				for iter_230_8 = 0, var_230_5.childCount - 1 do
					local var_230_6 = var_230_5:GetChild(iter_230_8)

					if var_230_6.name == "split_4" or not string.find(var_230_6.name, "split") then
						var_230_6.gameObject:SetActive(true)
					else
						var_230_6.gameObject:SetActive(false)
					end
				end
			end

			local var_230_7 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 then
				var_230_5.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_227_1.time_ - 0) / var_230_7)
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 then
				var_230_5.localPosition = Vector3.New(390, -425, -200)
			end

			local var_230_8 = arg_227_1.actors_["10127"].transform

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos10127 = var_230_8.localPosition
				var_230_8.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("10127", 2)

				for iter_230_9 = 0, var_230_8.childCount - 1 do
					local var_230_9 = var_230_8:GetChild(iter_230_9)

					if var_230_9.name == "split_1" or not string.find(var_230_9.name, "split") then
						var_230_9.gameObject:SetActive(true)
					else
						var_230_9.gameObject:SetActive(false)
					end
				end
			end

			local var_230_10 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_10 then
				var_230_8.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10127, Vector3.New(-390, -387.4, -316.5), (arg_227_1.time_ - 0) / var_230_10)
			end

			if arg_227_1.time_ >= 0 + var_230_10 and arg_227_1.time_ < 0 + var_230_10 + arg_230_0 then
				var_230_8.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_230_11 = 0
			local var_230_12 = 0.925

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_11 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_13 = arg_227_1:GetWordFromCfg(425042055)
				local var_230_14 = arg_227_1:FormatText(var_230_13.content)

				arg_227_1.text_.text = var_230_14

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_16 = 37 <= 0 and var_230_12 or var_230_12 * (utf8.len(var_230_14) / 37)

				if (37 <= 0 and var_230_12 or var_230_12 * (utf8.len(var_230_14) / 37)) > 0 and var_230_12 < var_230_16 then
					arg_227_1.talkMaxDuration = var_230_16

					if var_230_16 + var_230_11 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_16 + var_230_11
					end
				end

				arg_227_1.text_.text = var_230_14
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042055", "story_v_out_425042.awb") ~= 0 then
					local var_230_17 = manager.audio:GetVoiceLength("story_v_out_425042", "425042055", "story_v_out_425042.awb") / 1000

					if var_230_17 + var_230_11 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_17 + var_230_11
					end

					if var_230_13.prefab_name ~= "" and arg_227_1.actors_[var_230_13.prefab_name] ~= nil then
						local var_230_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_13.prefab_name].transform, "story_v_out_425042", "425042055", "story_v_out_425042.awb")

						arg_227_1:RecordAudio("425042055", var_230_18)
						arg_227_1:RecordAudio("425042055", var_230_18)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_425042", "425042055", "story_v_out_425042.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_425042", "425042055", "story_v_out_425042.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_19 = math.max(var_230_12, arg_227_1.talkMaxDuration)

			if var_230_11 <= arg_227_1.time_ and arg_227_1.time_ < var_230_11 + var_230_19 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_11) / var_230_19

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_11 + var_230_19 and arg_227_1.time_ < var_230_11 + var_230_19 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10127",
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
	Play425042056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 425042056
		arg_231_1.duration_ = 6.93

		local var_231_0 = {
			zh = 3.666,
			ja = 6.933
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
				arg_231_0:Play425042057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["10127"]) and arg_231_1.var_.actorSpriteComps10127 == nil then
				arg_231_1.var_.actorSpriteComps10127 = arg_231_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_0 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["10127"]) then
				if arg_231_1.var_.actorSpriteComps10127 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_234_1 then
							if arg_231_1.isInRecall_ then
								iter_234_1.color = Color.New(Mathf.Lerp(iter_234_1.color.r, arg_231_1.hightColor1.r, (arg_231_1.time_ - 0) / var_234_0), Mathf.Lerp(iter_234_1.color.g, arg_231_1.hightColor1.g, (arg_231_1.time_ - 0) / var_234_0), (Mathf.Lerp(iter_234_1.color.b, arg_231_1.hightColor1.b, (arg_231_1.time_ - 0) / var_234_0)))
							else
								local var_234_1 = Mathf.Lerp(iter_234_1.color.r, 1, (arg_231_1.time_ - 0) / var_234_0)

								iter_234_1.color = Color.New(var_234_1, var_234_1, var_234_1)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["10127"]) and arg_231_1.var_.actorSpriteComps10127 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_234_3 then
						iter_234_3.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_231_1.var_.actorSpriteComps10127 = nil
			end

			local var_234_2 = arg_231_1.actors_["1137"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.actorSpriteComps1137 == nil then
				arg_231_1.var_.actorSpriteComps1137 = var_234_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_3 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_3 and not isNil(var_234_2) then
				if arg_231_1.var_.actorSpriteComps1137 then
					for iter_234_4, iter_234_5 in pairs(arg_231_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_234_5 then
							if arg_231_1.isInRecall_ then
								iter_234_5.color = Color.New(Mathf.Lerp(iter_234_5.color.r, arg_231_1.hightColor2.r, (arg_231_1.time_ - 0) / var_234_3), Mathf.Lerp(iter_234_5.color.g, arg_231_1.hightColor2.g, (arg_231_1.time_ - 0) / var_234_3), (Mathf.Lerp(iter_234_5.color.b, arg_231_1.hightColor2.b, (arg_231_1.time_ - 0) / var_234_3)))
							else
								local var_234_4 = Mathf.Lerp(iter_234_5.color.r, 0.5, (arg_231_1.time_ - 0) / var_234_3)

								iter_234_5.color = Color.New(var_234_4, var_234_4, var_234_4)
							end
						end
					end
				end
			end

			if arg_231_1.time_ >= 0 + var_234_3 and arg_231_1.time_ < 0 + var_234_3 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.actorSpriteComps1137 then
				for iter_234_6, iter_234_7 in pairs(arg_231_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_234_7 then
						iter_234_7.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_231_1.var_.actorSpriteComps1137 = nil
			end

			local var_234_5 = arg_231_1.actors_["10127"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos10127 = var_234_5.localPosition
				var_234_5.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("10127", 2)

				for iter_234_8 = 0, var_234_5.childCount - 1 do
					local var_234_6 = var_234_5:GetChild(iter_234_8)

					if var_234_6.name == "split_6" then
						var_234_6:SetAsLastSibling()
						var_234_6.gameObject:SetActive(true)

						arg_231_1.var_.actorSpriteSplit10127 = var_234_6.gameObject:GetComponent(typeof(Image))

						arg_231_1.var_.actorSpriteSplit10127:SetAlpha(0)
					end
				end
			end

			local var_234_7 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_7 then
				var_234_5.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10127, Vector3.New(-390, -387.4, -316.5), (arg_231_1.time_ - 0) / var_234_7)

				if arg_231_1.var_.actorSpriteSplit10127 ~= nil then
					arg_231_1.var_.actorSpriteSplit10127:SetAlpha((arg_231_1.time_ - 0) / var_234_7)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_7 and arg_231_1.time_ < 0 + var_234_7 + arg_234_0 then
				var_234_5.localPosition = Vector3.New(-390, -387.4, -316.5)

				if arg_231_1.var_.actorSpriteSplit10127 ~= nil then
					arg_231_1.var_.actorSpriteSplit10127:SetAlpha(1)
				end
			end

			local var_234_8 = 0
			local var_234_9 = 0.45

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_10 = arg_231_1:GetWordFromCfg(425042056)
				local var_234_11 = arg_231_1:FormatText(var_234_10.content)

				arg_231_1.text_.text = var_234_11

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_13 = 18 <= 0 and var_234_9 or var_234_9 * (utf8.len(var_234_11) / 18)

				if (18 <= 0 and var_234_9 or var_234_9 * (utf8.len(var_234_11) / 18)) > 0 and var_234_9 < var_234_13 then
					arg_231_1.talkMaxDuration = var_234_13

					if var_234_13 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_13 + var_234_8
					end
				end

				arg_231_1.text_.text = var_234_11
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042056", "story_v_out_425042.awb") ~= 0 then
					local var_234_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042056", "story_v_out_425042.awb") / 1000

					if var_234_14 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_14 + var_234_8
					end

					if var_234_10.prefab_name ~= "" and arg_231_1.actors_[var_234_10.prefab_name] ~= nil then
						local var_234_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_10.prefab_name].transform, "story_v_out_425042", "425042056", "story_v_out_425042.awb")

						arg_231_1:RecordAudio("425042056", var_234_15)
						arg_231_1:RecordAudio("425042056", var_234_15)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_425042", "425042056", "story_v_out_425042.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_425042", "425042056", "story_v_out_425042.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_16 = math.max(var_234_9, arg_231_1.talkMaxDuration)

			if var_234_8 <= arg_231_1.time_ and arg_231_1.time_ < var_234_8 + var_234_16 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_8) / var_234_16

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_8 + var_234_16 and arg_231_1.time_ < var_234_8 + var_234_16 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play425042057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 425042057
		arg_235_1.duration_ = 14.83

		local var_235_0 = {
			zh = 9.066,
			ja = 14.833
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
				arg_235_0:Play425042058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 1.275

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_1 = arg_235_1:GetWordFromCfg(425042057)
				local var_238_2 = arg_235_1:FormatText(var_238_1.content)

				arg_235_1.text_.text = var_238_2

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 51 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 51)

				if (51 <= 0 and var_238_0 or var_238_0 * (utf8.len(var_238_2) / 51)) > 0 and var_238_0 < var_238_4 then
					arg_235_1.talkMaxDuration = var_238_4

					if var_238_4 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_4 + 0
					end
				end

				arg_235_1.text_.text = var_238_2
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042057", "story_v_out_425042.awb") ~= 0 then
					local var_238_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042057", "story_v_out_425042.awb") / 1000

					if var_238_5 + 0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + 0
					end

					if var_238_1.prefab_name ~= "" and arg_235_1.actors_[var_238_1.prefab_name] ~= nil then
						local var_238_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_1.prefab_name].transform, "story_v_out_425042", "425042057", "story_v_out_425042.awb")

						arg_235_1:RecordAudio("425042057", var_238_6)
						arg_235_1:RecordAudio("425042057", var_238_6)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_425042", "425042057", "story_v_out_425042.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_425042", "425042057", "story_v_out_425042.awb")
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
	Play425042058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 425042058
		arg_239_1.duration_ = 5.73

		local var_239_0 = {
			zh = 4.166,
			ja = 5.733
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
				arg_239_0:Play425042059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.45

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:GetWordFromCfg(425042058)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 18 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 18)

				if (18 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 18)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042058", "story_v_out_425042.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042058", "story_v_out_425042.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_425042", "425042058", "story_v_out_425042.awb")

						arg_239_1:RecordAudio("425042058", var_242_6)
						arg_239_1:RecordAudio("425042058", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_425042", "425042058", "story_v_out_425042.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_425042", "425042058", "story_v_out_425042.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_7 and arg_239_1.time_ < 0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play425042059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 425042059
		arg_243_1.duration_ = 10.17

		local var_243_0 = {
			zh = 6.1,
			ja = 10.166
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
				arg_243_0:Play425042060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1137"]) and arg_243_1.var_.actorSpriteComps1137 == nil then
				arg_243_1.var_.actorSpriteComps1137 = arg_243_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_0 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1137"]) then
				if arg_243_1.var_.actorSpriteComps1137 then
					for iter_246_0, iter_246_1 in pairs(arg_243_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_246_1 then
							if arg_243_1.isInRecall_ then
								iter_246_1.color = Color.New(Mathf.Lerp(iter_246_1.color.r, arg_243_1.hightColor1.r, (arg_243_1.time_ - 0) / var_246_0), Mathf.Lerp(iter_246_1.color.g, arg_243_1.hightColor1.g, (arg_243_1.time_ - 0) / var_246_0), (Mathf.Lerp(iter_246_1.color.b, arg_243_1.hightColor1.b, (arg_243_1.time_ - 0) / var_246_0)))
							else
								local var_246_1 = Mathf.Lerp(iter_246_1.color.r, 1, (arg_243_1.time_ - 0) / var_246_0)

								iter_246_1.color = Color.New(var_246_1, var_246_1, var_246_1)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1137"]) and arg_243_1.var_.actorSpriteComps1137 then
				for iter_246_2, iter_246_3 in pairs(arg_243_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_246_3 then
						iter_246_3.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_243_1.var_.actorSpriteComps1137 = nil
			end

			local var_246_2 = arg_243_1.actors_["10127"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.actorSpriteComps10127 == nil then
				arg_243_1.var_.actorSpriteComps10127 = var_246_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_246_3 = 0.2

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_3 and not isNil(var_246_2) then
				if arg_243_1.var_.actorSpriteComps10127 then
					for iter_246_4, iter_246_5 in pairs(arg_243_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_246_5 then
							if arg_243_1.isInRecall_ then
								iter_246_5.color = Color.New(Mathf.Lerp(iter_246_5.color.r, arg_243_1.hightColor2.r, (arg_243_1.time_ - 0) / var_246_3), Mathf.Lerp(iter_246_5.color.g, arg_243_1.hightColor2.g, (arg_243_1.time_ - 0) / var_246_3), (Mathf.Lerp(iter_246_5.color.b, arg_243_1.hightColor2.b, (arg_243_1.time_ - 0) / var_246_3)))
							else
								local var_246_4 = Mathf.Lerp(iter_246_5.color.r, 0.5, (arg_243_1.time_ - 0) / var_246_3)

								iter_246_5.color = Color.New(var_246_4, var_246_4, var_246_4)
							end
						end
					end
				end
			end

			if arg_243_1.time_ >= 0 + var_246_3 and arg_243_1.time_ < 0 + var_246_3 + arg_246_0 and not isNil(var_246_2) and arg_243_1.var_.actorSpriteComps10127 then
				for iter_246_6, iter_246_7 in pairs(arg_243_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_246_7 then
						iter_246_7.color = arg_243_1.isInRecall_ and (arg_243_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_243_1.var_.actorSpriteComps10127 = nil
			end

			local var_246_5 = arg_243_1.actors_["1137"].transform

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos1137 = var_246_5.localPosition
				var_246_5.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("1137", 4)

				for iter_246_8 = 0, var_246_5.childCount - 1 do
					local var_246_6 = var_246_5:GetChild(iter_246_8)

					if var_246_6.name == "split_4" or not string.find(var_246_6.name, "split") then
						var_246_6.gameObject:SetActive(true)
					else
						var_246_6.gameObject:SetActive(false)
					end
				end
			end

			local var_246_7 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_7 then
				var_246_5.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_243_1.time_ - 0) / var_246_7)
			end

			if arg_243_1.time_ >= 0 + var_246_7 and arg_243_1.time_ < 0 + var_246_7 + arg_246_0 then
				var_246_5.localPosition = Vector3.New(390, -425, -200)
			end

			local var_246_8 = 0
			local var_246_9 = 0.55

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_8 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_10 = arg_243_1:GetWordFromCfg(425042059)
				local var_246_11 = arg_243_1:FormatText(var_246_10.content)

				arg_243_1.text_.text = var_246_11

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_13 = 22 <= 0 and var_246_9 or var_246_9 * (utf8.len(var_246_11) / 22)

				if (22 <= 0 and var_246_9 or var_246_9 * (utf8.len(var_246_11) / 22)) > 0 and var_246_9 < var_246_13 then
					arg_243_1.talkMaxDuration = var_246_13

					if var_246_13 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_13 + var_246_8
					end
				end

				arg_243_1.text_.text = var_246_11
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042059", "story_v_out_425042.awb") ~= 0 then
					local var_246_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042059", "story_v_out_425042.awb") / 1000

					if var_246_14 + var_246_8 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_14 + var_246_8
					end

					if var_246_10.prefab_name ~= "" and arg_243_1.actors_[var_246_10.prefab_name] ~= nil then
						local var_246_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_10.prefab_name].transform, "story_v_out_425042", "425042059", "story_v_out_425042.awb")

						arg_243_1:RecordAudio("425042059", var_246_15)
						arg_243_1:RecordAudio("425042059", var_246_15)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_425042", "425042059", "story_v_out_425042.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_425042", "425042059", "story_v_out_425042.awb")
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
				actorName = "1137",
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
	Play425042060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 425042060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play425042061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos1137 = arg_247_1.actors_["1137"].transform.localPosition
				arg_247_1.actors_["1137"].transform.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("1137", 7)

				for iter_250_0 = 0, arg_247_1.actors_["1137"].transform.childCount - 1 do
					local var_250_0 = arg_247_1.actors_["1137"].transform:GetChild(iter_250_0)

					if var_250_0.name == "" or not string.find(var_250_0.name, "split") then
						var_250_0.gameObject:SetActive(true)
					else
						var_250_0.gameObject:SetActive(false)
					end
				end
			end

			local var_250_1 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_1 then
				arg_247_1.actors_["1137"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_247_1.time_ - 0) / var_250_1)
			end

			if arg_247_1.time_ >= 0 + var_250_1 and arg_247_1.time_ < 0 + var_250_1 + arg_250_0 then
				arg_247_1.actors_["1137"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_250_2 = arg_247_1.actors_["10127"].transform

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10127 = var_250_2.localPosition
				var_250_2.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10127", 7)

				for iter_250_1 = 0, var_250_2.childCount - 1 do
					local var_250_3 = var_250_2:GetChild(iter_250_1)

					if var_250_3.name == "" or not string.find(var_250_3.name, "split") then
						var_250_3.gameObject:SetActive(true)
					else
						var_250_3.gameObject:SetActive(false)
					end
				end
			end

			local var_250_4 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_4 then
				var_250_2.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10127, Vector3.New(0, -2000, 0), (arg_247_1.time_ - 0) / var_250_4)
			end

			if arg_247_1.time_ >= 0 + var_250_4 and arg_247_1.time_ < 0 + var_250_4 + arg_250_0 then
				var_250_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_250_5 = 0
			local var_250_6 = 0.825

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_7 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(425042060).content)

				arg_247_1.text_.text = var_250_7

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_9 = 33 <= 0 and var_250_6 or var_250_6 * (utf8.len(var_250_7) / 33)

				if (33 <= 0 and var_250_6 or var_250_6 * (utf8.len(var_250_7) / 33)) > 0 and var_250_6 < var_250_9 then
					arg_247_1.talkMaxDuration = var_250_9

					if var_250_9 + var_250_5 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_9 + var_250_5
					end
				end

				arg_247_1.text_.text = var_250_7
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_10 = math.max(var_250_6, arg_247_1.talkMaxDuration)

			if var_250_5 <= arg_247_1.time_ and arg_247_1.time_ < var_250_5 + var_250_10 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_5) / var_250_10

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_5 + var_250_10 and arg_247_1.time_ < var_250_5 + var_250_10 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10127",
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
	Play425042061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 425042061
		arg_251_1.duration_ = 14.07

		local var_251_0 = {
			zh = 7.966,
			ja = 14.066
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
				arg_251_0:Play425042062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(arg_251_1.actors_["10127"]) and arg_251_1.var_.actorSpriteComps10127 == nil then
				arg_251_1.var_.actorSpriteComps10127 = arg_251_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_254_0 = 0.2

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 and not isNil(arg_251_1.actors_["10127"]) then
				if arg_251_1.var_.actorSpriteComps10127 then
					for iter_254_0, iter_254_1 in pairs(arg_251_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_254_1 then
							if arg_251_1.isInRecall_ then
								iter_254_1.color = Color.New(Mathf.Lerp(iter_254_1.color.r, arg_251_1.hightColor1.r, (arg_251_1.time_ - 0) / var_254_0), Mathf.Lerp(iter_254_1.color.g, arg_251_1.hightColor1.g, (arg_251_1.time_ - 0) / var_254_0), (Mathf.Lerp(iter_254_1.color.b, arg_251_1.hightColor1.b, (arg_251_1.time_ - 0) / var_254_0)))
							else
								local var_254_1 = Mathf.Lerp(iter_254_1.color.r, 1, (arg_251_1.time_ - 0) / var_254_0)

								iter_254_1.color = Color.New(var_254_1, var_254_1, var_254_1)
							end
						end
					end
				end
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 and not isNil(arg_251_1.actors_["10127"]) and arg_251_1.var_.actorSpriteComps10127 then
				for iter_254_2, iter_254_3 in pairs(arg_251_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_254_3 then
						iter_254_3.color = arg_251_1.isInRecall_ and (arg_251_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_251_1.var_.actorSpriteComps10127 = nil
			end

			local var_254_2 = arg_251_1.actors_["10127"].transform

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos10127 = var_254_2.localPosition
				var_254_2.localScale = Vector3.New(1, 1, 1)

				arg_251_1:CheckSpriteTmpPos("10127", 2)

				for iter_254_4 = 0, var_254_2.childCount - 1 do
					local var_254_3 = var_254_2:GetChild(iter_254_4)

					if var_254_3.name == "split_2" or not string.find(var_254_3.name, "split") then
						var_254_3.gameObject:SetActive(true)
					else
						var_254_3.gameObject:SetActive(false)
					end
				end
			end

			local var_254_4 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_4 then
				var_254_2.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10127, Vector3.New(-390, -387.4, -316.5), (arg_251_1.time_ - 0) / var_254_4)
			end

			if arg_251_1.time_ >= 0 + var_254_4 and arg_251_1.time_ < 0 + var_254_4 + arg_254_0 then
				var_254_2.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_254_5 = 0
			local var_254_6 = 1.075

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_5 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_7 = arg_251_1:GetWordFromCfg(425042061)
				local var_254_8 = arg_251_1:FormatText(var_254_7.content)

				arg_251_1.text_.text = var_254_8

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_10 = 43 <= 0 and var_254_6 or var_254_6 * (utf8.len(var_254_8) / 43)

				if (43 <= 0 and var_254_6 or var_254_6 * (utf8.len(var_254_8) / 43)) > 0 and var_254_6 < var_254_10 then
					arg_251_1.talkMaxDuration = var_254_10

					if var_254_10 + var_254_5 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_10 + var_254_5
					end
				end

				arg_251_1.text_.text = var_254_8
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042061", "story_v_out_425042.awb") ~= 0 then
					local var_254_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042061", "story_v_out_425042.awb") / 1000

					if var_254_11 + var_254_5 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_11 + var_254_5
					end

					if var_254_7.prefab_name ~= "" and arg_251_1.actors_[var_254_7.prefab_name] ~= nil then
						local var_254_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_7.prefab_name].transform, "story_v_out_425042", "425042061", "story_v_out_425042.awb")

						arg_251_1:RecordAudio("425042061", var_254_12)
						arg_251_1:RecordAudio("425042061", var_254_12)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_425042", "425042061", "story_v_out_425042.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_425042", "425042061", "story_v_out_425042.awb")
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
				actorName = "10127",
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
	Play425042062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 425042062
		arg_255_1.duration_ = 2.53

		local var_255_0 = {
			zh = 2.466,
			ja = 2.533
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
				arg_255_0:Play425042063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["1137"]) and arg_255_1.var_.actorSpriteComps1137 == nil then
				arg_255_1.var_.actorSpriteComps1137 = arg_255_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_0 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["1137"]) then
				if arg_255_1.var_.actorSpriteComps1137 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								iter_258_1.color = Color.New(Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor1.r, (arg_255_1.time_ - 0) / var_258_0), Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor1.g, (arg_255_1.time_ - 0) / var_258_0), (Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor1.b, (arg_255_1.time_ - 0) / var_258_0)))
							else
								local var_258_1 = Mathf.Lerp(iter_258_1.color.r, 1, (arg_255_1.time_ - 0) / var_258_0)

								iter_258_1.color = Color.New(var_258_1, var_258_1, var_258_1)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["1137"]) and arg_255_1.var_.actorSpriteComps1137 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_258_3 then
						iter_258_3.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_255_1.var_.actorSpriteComps1137 = nil
			end

			local var_258_2 = arg_255_1.actors_["10127"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_2) and arg_255_1.var_.actorSpriteComps10127 == nil then
				arg_255_1.var_.actorSpriteComps10127 = var_258_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_3 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_3 and not isNil(var_258_2) then
				if arg_255_1.var_.actorSpriteComps10127 then
					for iter_258_4, iter_258_5 in pairs(arg_255_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_258_5 then
							if arg_255_1.isInRecall_ then
								iter_258_5.color = Color.New(Mathf.Lerp(iter_258_5.color.r, arg_255_1.hightColor2.r, (arg_255_1.time_ - 0) / var_258_3), Mathf.Lerp(iter_258_5.color.g, arg_255_1.hightColor2.g, (arg_255_1.time_ - 0) / var_258_3), (Mathf.Lerp(iter_258_5.color.b, arg_255_1.hightColor2.b, (arg_255_1.time_ - 0) / var_258_3)))
							else
								local var_258_4 = Mathf.Lerp(iter_258_5.color.r, 0.5, (arg_255_1.time_ - 0) / var_258_3)

								iter_258_5.color = Color.New(var_258_4, var_258_4, var_258_4)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_3 and arg_255_1.time_ < 0 + var_258_3 + arg_258_0 and not isNil(var_258_2) and arg_255_1.var_.actorSpriteComps10127 then
				for iter_258_6, iter_258_7 in pairs(arg_255_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_258_7 then
						iter_258_7.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_255_1.var_.actorSpriteComps10127 = nil
			end

			local var_258_5 = arg_255_1.actors_["1137"].transform

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos1137 = var_258_5.localPosition
				var_258_5.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("1137", 4)

				for iter_258_8 = 0, var_258_5.childCount - 1 do
					local var_258_6 = var_258_5:GetChild(iter_258_8)

					if var_258_6.name == "split_5" or not string.find(var_258_6.name, "split") then
						var_258_6.gameObject:SetActive(true)
					else
						var_258_6.gameObject:SetActive(false)
					end
				end
			end

			local var_258_7 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_7 then
				var_258_5.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_255_1.time_ - 0) / var_258_7)
			end

			if arg_255_1.time_ >= 0 + var_258_7 and arg_255_1.time_ < 0 + var_258_7 + arg_258_0 then
				var_258_5.localPosition = Vector3.New(390, -425, -200)
			end

			local var_258_8 = 0
			local var_258_9 = 0.175

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_8 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_10 = arg_255_1:GetWordFromCfg(425042062)
				local var_258_11 = arg_255_1:FormatText(var_258_10.content)

				arg_255_1.text_.text = var_258_11

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_13 = 7 <= 0 and var_258_9 or var_258_9 * (utf8.len(var_258_11) / 7)

				if (7 <= 0 and var_258_9 or var_258_9 * (utf8.len(var_258_11) / 7)) > 0 and var_258_9 < var_258_13 then
					arg_255_1.talkMaxDuration = var_258_13

					if var_258_13 + var_258_8 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_13 + var_258_8
					end
				end

				arg_255_1.text_.text = var_258_11
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042062", "story_v_out_425042.awb") ~= 0 then
					local var_258_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042062", "story_v_out_425042.awb") / 1000

					if var_258_14 + var_258_8 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_14 + var_258_8
					end

					if var_258_10.prefab_name ~= "" and arg_255_1.actors_[var_258_10.prefab_name] ~= nil then
						local var_258_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_10.prefab_name].transform, "story_v_out_425042", "425042062", "story_v_out_425042.awb")

						arg_255_1:RecordAudio("425042062", var_258_15)
						arg_255_1:RecordAudio("425042062", var_258_15)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_425042", "425042062", "story_v_out_425042.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_425042", "425042062", "story_v_out_425042.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_16 = math.max(var_258_9, arg_255_1.talkMaxDuration)

			if var_258_8 <= arg_255_1.time_ and arg_255_1.time_ < var_258_8 + var_258_16 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_8) / var_258_16

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_8 + var_258_16 and arg_255_1.time_ < var_258_8 + var_258_16 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
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
	Play425042063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 425042063
		arg_259_1.duration_ = 11.27

		local var_259_0 = {
			zh = 6.266,
			ja = 11.266
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
				arg_259_0:Play425042064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["10127"]) and arg_259_1.var_.actorSpriteComps10127 == nil then
				arg_259_1.var_.actorSpriteComps10127 = arg_259_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_0 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["10127"]) then
				if arg_259_1.var_.actorSpriteComps10127 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_262_1 then
							if arg_259_1.isInRecall_ then
								iter_262_1.color = Color.New(Mathf.Lerp(iter_262_1.color.r, arg_259_1.hightColor1.r, (arg_259_1.time_ - 0) / var_262_0), Mathf.Lerp(iter_262_1.color.g, arg_259_1.hightColor1.g, (arg_259_1.time_ - 0) / var_262_0), (Mathf.Lerp(iter_262_1.color.b, arg_259_1.hightColor1.b, (arg_259_1.time_ - 0) / var_262_0)))
							else
								local var_262_1 = Mathf.Lerp(iter_262_1.color.r, 1, (arg_259_1.time_ - 0) / var_262_0)

								iter_262_1.color = Color.New(var_262_1, var_262_1, var_262_1)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["10127"]) and arg_259_1.var_.actorSpriteComps10127 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_262_3 then
						iter_262_3.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_259_1.var_.actorSpriteComps10127 = nil
			end

			local var_262_2 = arg_259_1.actors_["1137"]

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.actorSpriteComps1137 == nil then
				arg_259_1.var_.actorSpriteComps1137 = var_262_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_3 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_3 and not isNil(var_262_2) then
				if arg_259_1.var_.actorSpriteComps1137 then
					for iter_262_4, iter_262_5 in pairs(arg_259_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_262_5 then
							if arg_259_1.isInRecall_ then
								iter_262_5.color = Color.New(Mathf.Lerp(iter_262_5.color.r, arg_259_1.hightColor2.r, (arg_259_1.time_ - 0) / var_262_3), Mathf.Lerp(iter_262_5.color.g, arg_259_1.hightColor2.g, (arg_259_1.time_ - 0) / var_262_3), (Mathf.Lerp(iter_262_5.color.b, arg_259_1.hightColor2.b, (arg_259_1.time_ - 0) / var_262_3)))
							else
								local var_262_4 = Mathf.Lerp(iter_262_5.color.r, 0.5, (arg_259_1.time_ - 0) / var_262_3)

								iter_262_5.color = Color.New(var_262_4, var_262_4, var_262_4)
							end
						end
					end
				end
			end

			if arg_259_1.time_ >= 0 + var_262_3 and arg_259_1.time_ < 0 + var_262_3 + arg_262_0 and not isNil(var_262_2) and arg_259_1.var_.actorSpriteComps1137 then
				for iter_262_6, iter_262_7 in pairs(arg_259_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_262_7 then
						iter_262_7.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_259_1.var_.actorSpriteComps1137 = nil
			end

			local var_262_5 = 0
			local var_262_6 = 0.9

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_7 = arg_259_1:GetWordFromCfg(425042063)
				local var_262_8 = arg_259_1:FormatText(var_262_7.content)

				arg_259_1.text_.text = var_262_8

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_10 = 36 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_8) / 36)

				if (36 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_8) / 36)) > 0 and var_262_6 < var_262_10 then
					arg_259_1.talkMaxDuration = var_262_10

					if var_262_10 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_5
					end
				end

				arg_259_1.text_.text = var_262_8
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042063", "story_v_out_425042.awb") ~= 0 then
					local var_262_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042063", "story_v_out_425042.awb") / 1000

					if var_262_11 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_11 + var_262_5
					end

					if var_262_7.prefab_name ~= "" and arg_259_1.actors_[var_262_7.prefab_name] ~= nil then
						local var_262_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_7.prefab_name].transform, "story_v_out_425042", "425042063", "story_v_out_425042.awb")

						arg_259_1:RecordAudio("425042063", var_262_12)
						arg_259_1:RecordAudio("425042063", var_262_12)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_425042", "425042063", "story_v_out_425042.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_425042", "425042063", "story_v_out_425042.awb")
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

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play425042064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 425042064
		arg_263_1.duration_ = 12.97

		local var_263_0 = {
			zh = 12.966,
			ja = 12.266
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play425042065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos10127 = arg_263_1.actors_["10127"].transform.localPosition
				arg_263_1.actors_["10127"].transform.localScale = Vector3.New(1, 1, 1)

				arg_263_1:CheckSpriteTmpPos("10127", 2)

				for iter_266_0 = 0, arg_263_1.actors_["10127"].transform.childCount - 1 do
					local var_266_0 = arg_263_1.actors_["10127"].transform:GetChild(iter_266_0)

					if var_266_0.name == "split_6" then
						var_266_0:SetAsLastSibling()
						var_266_0.gameObject:SetActive(true)

						arg_263_1.var_.actorSpriteSplit10127 = var_266_0.gameObject:GetComponent(typeof(Image))

						arg_263_1.var_.actorSpriteSplit10127:SetAlpha(0)
					end
				end
			end

			local var_266_1 = 0.5

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_1 then
				arg_263_1.actors_["10127"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos10127, Vector3.New(-390, -387.4, -316.5), (arg_263_1.time_ - 0) / var_266_1)

				if arg_263_1.var_.actorSpriteSplit10127 ~= nil then
					arg_263_1.var_.actorSpriteSplit10127:SetAlpha((arg_263_1.time_ - 0) / var_266_1)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_1 and arg_263_1.time_ < 0 + var_266_1 + arg_266_0 then
				arg_263_1.actors_["10127"].transform.localPosition = Vector3.New(-390, -387.4, -316.5)

				if arg_263_1.var_.actorSpriteSplit10127 ~= nil then
					arg_263_1.var_.actorSpriteSplit10127:SetAlpha(1)
				end
			end

			local var_266_2 = 0
			local var_266_3 = 1.35

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_2 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_4 = arg_263_1:GetWordFromCfg(425042064)
				local var_266_5 = arg_263_1:FormatText(var_266_4.content)

				arg_263_1.text_.text = var_266_5

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_7 = 54 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_5) / 54)

				if (54 <= 0 and var_266_3 or var_266_3 * (utf8.len(var_266_5) / 54)) > 0 and var_266_3 < var_266_7 then
					arg_263_1.talkMaxDuration = var_266_7

					if var_266_7 + var_266_2 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_2
					end
				end

				arg_263_1.text_.text = var_266_5
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042064", "story_v_out_425042.awb") ~= 0 then
					local var_266_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042064", "story_v_out_425042.awb") / 1000

					if var_266_8 + var_266_2 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_8 + var_266_2
					end

					if var_266_4.prefab_name ~= "" and arg_263_1.actors_[var_266_4.prefab_name] ~= nil then
						local var_266_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_4.prefab_name].transform, "story_v_out_425042", "425042064", "story_v_out_425042.awb")

						arg_263_1:RecordAudio("425042064", var_266_9)
						arg_263_1:RecordAudio("425042064", var_266_9)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_425042", "425042064", "story_v_out_425042.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_425042", "425042064", "story_v_out_425042.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_10 = math.max(var_266_3, arg_263_1.talkMaxDuration)

			if var_266_2 <= arg_263_1.time_ and arg_263_1.time_ < var_266_2 + var_266_10 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_2) / var_266_10

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_2 + var_266_10 and arg_263_1.time_ < var_266_2 + var_266_10 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play425042065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 425042065
		arg_267_1.duration_ = 5

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play425042066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos1137 = arg_267_1.actors_["1137"].transform.localPosition
				arg_267_1.actors_["1137"].transform.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("1137", 7)

				for iter_270_0 = 0, arg_267_1.actors_["1137"].transform.childCount - 1 do
					local var_270_0 = arg_267_1.actors_["1137"].transform:GetChild(iter_270_0)

					if var_270_0.name == "" or not string.find(var_270_0.name, "split") then
						var_270_0.gameObject:SetActive(true)
					else
						var_270_0.gameObject:SetActive(false)
					end
				end
			end

			local var_270_1 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_1 then
				arg_267_1.actors_["1137"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_267_1.time_ - 0) / var_270_1)
			end

			if arg_267_1.time_ >= 0 + var_270_1 and arg_267_1.time_ < 0 + var_270_1 + arg_270_0 then
				arg_267_1.actors_["1137"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_270_2 = arg_267_1.actors_["10127"].transform

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos10127 = var_270_2.localPosition
				var_270_2.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("10127", 7)

				for iter_270_1 = 0, var_270_2.childCount - 1 do
					local var_270_3 = var_270_2:GetChild(iter_270_1)

					if var_270_3.name == "" or not string.find(var_270_3.name, "split") then
						var_270_3.gameObject:SetActive(true)
					else
						var_270_3.gameObject:SetActive(false)
					end
				end
			end

			local var_270_4 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_4 then
				var_270_2.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10127, Vector3.New(0, -2000, 0), (arg_267_1.time_ - 0) / var_270_4)
			end

			if arg_267_1.time_ >= 0 + var_270_4 and arg_267_1.time_ < 0 + var_270_4 + arg_270_0 then
				var_270_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_270_5 = 0
			local var_270_6 = 1.225

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, false)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_7 = arg_267_1:FormatText(arg_267_1:GetWordFromCfg(425042065).content)

				arg_267_1.text_.text = var_270_7

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_9 = 49 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_7) / 49)

				if (49 <= 0 and var_270_6 or var_270_6 * (utf8.len(var_270_7) / 49)) > 0 and var_270_6 < var_270_9 then
					arg_267_1.talkMaxDuration = var_270_9

					if var_270_9 + var_270_5 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_9 + var_270_5
					end
				end

				arg_267_1.text_.text = var_270_7
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)
				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_10 = math.max(var_270_6, arg_267_1.talkMaxDuration)

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_10 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_5) / var_270_10

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_5 + var_270_10 and arg_267_1.time_ < var_270_5 + var_270_10 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play425042066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 425042066
		arg_271_1.duration_ = 10.57

		local var_271_0 = {
			zh = 3.8,
			ja = 10.566
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
				arg_271_0:Play425042067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(arg_271_1.actors_["1137"]) and arg_271_1.var_.actorSpriteComps1137 == nil then
				arg_271_1.var_.actorSpriteComps1137 = arg_271_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_274_0 = 0.2

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 and not isNil(arg_271_1.actors_["1137"]) then
				if arg_271_1.var_.actorSpriteComps1137 then
					for iter_274_0, iter_274_1 in pairs(arg_271_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_274_1 then
							if arg_271_1.isInRecall_ then
								iter_274_1.color = Color.New(Mathf.Lerp(iter_274_1.color.r, arg_271_1.hightColor1.r, (arg_271_1.time_ - 0) / var_274_0), Mathf.Lerp(iter_274_1.color.g, arg_271_1.hightColor1.g, (arg_271_1.time_ - 0) / var_274_0), (Mathf.Lerp(iter_274_1.color.b, arg_271_1.hightColor1.b, (arg_271_1.time_ - 0) / var_274_0)))
							else
								local var_274_1 = Mathf.Lerp(iter_274_1.color.r, 1, (arg_271_1.time_ - 0) / var_274_0)

								iter_274_1.color = Color.New(var_274_1, var_274_1, var_274_1)
							end
						end
					end
				end
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 and not isNil(arg_271_1.actors_["1137"]) and arg_271_1.var_.actorSpriteComps1137 then
				for iter_274_2, iter_274_3 in pairs(arg_271_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_274_3 then
						iter_274_3.color = arg_271_1.isInRecall_ and (arg_271_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_271_1.var_.actorSpriteComps1137 = nil
			end

			local var_274_2 = arg_271_1.actors_["1137"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos1137 = var_274_2.localPosition
				var_274_2.localScale = Vector3.New(1, 1, 1)

				arg_271_1:CheckSpriteTmpPos("1137", 4)

				for iter_274_4 = 0, var_274_2.childCount - 1 do
					local var_274_3 = var_274_2:GetChild(iter_274_4)

					if var_274_3.name == "split_6" or not string.find(var_274_3.name, "split") then
						var_274_3.gameObject:SetActive(true)
					else
						var_274_3.gameObject:SetActive(false)
					end
				end
			end

			local var_274_4 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_4 then
				var_274_2.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_271_1.time_ - 0) / var_274_4)
			end

			if arg_271_1.time_ >= 0 + var_274_4 and arg_271_1.time_ < 0 + var_274_4 + arg_274_0 then
				var_274_2.localPosition = Vector3.New(390, -425, -200)
			end

			local var_274_5 = 0
			local var_274_6 = 0.35

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_7 = arg_271_1:GetWordFromCfg(425042066)
				local var_274_8 = arg_271_1:FormatText(var_274_7.content)

				arg_271_1.text_.text = var_274_8

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_10 = 14 <= 0 and var_274_6 or var_274_6 * (utf8.len(var_274_8) / 14)

				if (14 <= 0 and var_274_6 or var_274_6 * (utf8.len(var_274_8) / 14)) > 0 and var_274_6 < var_274_10 then
					arg_271_1.talkMaxDuration = var_274_10

					if var_274_10 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_10 + var_274_5
					end
				end

				arg_271_1.text_.text = var_274_8
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042066", "story_v_out_425042.awb") ~= 0 then
					local var_274_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042066", "story_v_out_425042.awb") / 1000

					if var_274_11 + var_274_5 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_11 + var_274_5
					end

					if var_274_7.prefab_name ~= "" and arg_271_1.actors_[var_274_7.prefab_name] ~= nil then
						local var_274_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_7.prefab_name].transform, "story_v_out_425042", "425042066", "story_v_out_425042.awb")

						arg_271_1:RecordAudio("425042066", var_274_12)
						arg_271_1:RecordAudio("425042066", var_274_12)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_425042", "425042066", "story_v_out_425042.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_425042", "425042066", "story_v_out_425042.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_13 = math.max(var_274_6, arg_271_1.talkMaxDuration)

			if var_274_5 <= arg_271_1.time_ and arg_271_1.time_ < var_274_5 + var_274_13 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_5) / var_274_13

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_5 + var_274_13 and arg_271_1.time_ < var_274_5 + var_274_13 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play425042067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 425042067
		arg_275_1.duration_ = 3.17

		local var_275_0 = {
			zh = 2.9,
			ja = 3.166
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
				arg_275_0:Play425042068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["10127"]) and arg_275_1.var_.actorSpriteComps10127 == nil then
				arg_275_1.var_.actorSpriteComps10127 = arg_275_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_0 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["10127"]) then
				if arg_275_1.var_.actorSpriteComps10127 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_278_1 then
							if arg_275_1.isInRecall_ then
								iter_278_1.color = Color.New(Mathf.Lerp(iter_278_1.color.r, arg_275_1.hightColor1.r, (arg_275_1.time_ - 0) / var_278_0), Mathf.Lerp(iter_278_1.color.g, arg_275_1.hightColor1.g, (arg_275_1.time_ - 0) / var_278_0), (Mathf.Lerp(iter_278_1.color.b, arg_275_1.hightColor1.b, (arg_275_1.time_ - 0) / var_278_0)))
							else
								local var_278_1 = Mathf.Lerp(iter_278_1.color.r, 1, (arg_275_1.time_ - 0) / var_278_0)

								iter_278_1.color = Color.New(var_278_1, var_278_1, var_278_1)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["10127"]) and arg_275_1.var_.actorSpriteComps10127 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_278_3 then
						iter_278_3.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_275_1.var_.actorSpriteComps10127 = nil
			end

			local var_278_2 = arg_275_1.actors_["1137"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.actorSpriteComps1137 == nil then
				arg_275_1.var_.actorSpriteComps1137 = var_278_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_3 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_3 and not isNil(var_278_2) then
				if arg_275_1.var_.actorSpriteComps1137 then
					for iter_278_4, iter_278_5 in pairs(arg_275_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_278_5 then
							if arg_275_1.isInRecall_ then
								iter_278_5.color = Color.New(Mathf.Lerp(iter_278_5.color.r, arg_275_1.hightColor2.r, (arg_275_1.time_ - 0) / var_278_3), Mathf.Lerp(iter_278_5.color.g, arg_275_1.hightColor2.g, (arg_275_1.time_ - 0) / var_278_3), (Mathf.Lerp(iter_278_5.color.b, arg_275_1.hightColor2.b, (arg_275_1.time_ - 0) / var_278_3)))
							else
								local var_278_4 = Mathf.Lerp(iter_278_5.color.r, 0.5, (arg_275_1.time_ - 0) / var_278_3)

								iter_278_5.color = Color.New(var_278_4, var_278_4, var_278_4)
							end
						end
					end
				end
			end

			if arg_275_1.time_ >= 0 + var_278_3 and arg_275_1.time_ < 0 + var_278_3 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.actorSpriteComps1137 then
				for iter_278_6, iter_278_7 in pairs(arg_275_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_278_7 then
						iter_278_7.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_275_1.var_.actorSpriteComps1137 = nil
			end

			local var_278_5 = arg_275_1.actors_["10127"].transform

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos10127 = var_278_5.localPosition
				var_278_5.localScale = Vector3.New(1, 1, 1)

				arg_275_1:CheckSpriteTmpPos("10127", 2)

				for iter_278_8 = 0, var_278_5.childCount - 1 do
					local var_278_6 = var_278_5:GetChild(iter_278_8)

					if var_278_6.name == "split_1" or not string.find(var_278_6.name, "split") then
						var_278_6.gameObject:SetActive(true)
					else
						var_278_6.gameObject:SetActive(false)
					end
				end
			end

			local var_278_7 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 then
				var_278_5.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos10127, Vector3.New(-390, -387.4, -316.5), (arg_275_1.time_ - 0) / var_278_7)
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 then
				var_278_5.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_278_8 = 0
			local var_278_9 = 0.25

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_8 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_10 = arg_275_1:GetWordFromCfg(425042067)
				local var_278_11 = arg_275_1:FormatText(var_278_10.content)

				arg_275_1.text_.text = var_278_11

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_13 = 10 <= 0 and var_278_9 or var_278_9 * (utf8.len(var_278_11) / 10)

				if (10 <= 0 and var_278_9 or var_278_9 * (utf8.len(var_278_11) / 10)) > 0 and var_278_9 < var_278_13 then
					arg_275_1.talkMaxDuration = var_278_13

					if var_278_13 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_13 + var_278_8
					end
				end

				arg_275_1.text_.text = var_278_11
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042067", "story_v_out_425042.awb") ~= 0 then
					local var_278_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042067", "story_v_out_425042.awb") / 1000

					if var_278_14 + var_278_8 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_14 + var_278_8
					end

					if var_278_10.prefab_name ~= "" and arg_275_1.actors_[var_278_10.prefab_name] ~= nil then
						local var_278_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_10.prefab_name].transform, "story_v_out_425042", "425042067", "story_v_out_425042.awb")

						arg_275_1:RecordAudio("425042067", var_278_15)
						arg_275_1:RecordAudio("425042067", var_278_15)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_425042", "425042067", "story_v_out_425042.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_425042", "425042067", "story_v_out_425042.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_16 = math.max(var_278_9, arg_275_1.talkMaxDuration)

			if var_278_8 <= arg_275_1.time_ and arg_275_1.time_ < var_278_8 + var_278_16 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_8) / var_278_16

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_8 + var_278_16 and arg_275_1.time_ < var_278_8 + var_278_16 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play425042068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 425042068
		arg_279_1.duration_ = 16.23

		local var_279_0 = {
			zh = 10.633,
			ja = 16.233
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play425042069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 1.4

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_1 = arg_279_1:GetWordFromCfg(425042068)
				local var_282_2 = arg_279_1:FormatText(var_282_1.content)

				arg_279_1.text_.text = var_282_2

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_4 = 56 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 56)

				if (56 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 56)) > 0 and var_282_0 < var_282_4 then
					arg_279_1.talkMaxDuration = var_282_4

					if var_282_4 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_4 + 0
					end
				end

				arg_279_1.text_.text = var_282_2
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042068", "story_v_out_425042.awb") ~= 0 then
					local var_282_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042068", "story_v_out_425042.awb") / 1000

					if var_282_5 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + 0
					end

					if var_282_1.prefab_name ~= "" and arg_279_1.actors_[var_282_1.prefab_name] ~= nil then
						local var_282_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_1.prefab_name].transform, "story_v_out_425042", "425042068", "story_v_out_425042.awb")

						arg_279_1:RecordAudio("425042068", var_282_6)
						arg_279_1:RecordAudio("425042068", var_282_6)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_425042", "425042068", "story_v_out_425042.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_425042", "425042068", "story_v_out_425042.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_7 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_7 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_7

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_7 and arg_279_1.time_ < 0 + var_282_7 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play425042069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 425042069
		arg_283_1.duration_ = 9.37

		local var_283_0 = {
			zh = 9.366,
			ja = 8.666
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play425042070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 1.275

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_1 = arg_283_1:GetWordFromCfg(425042069)
				local var_286_2 = arg_283_1:FormatText(var_286_1.content)

				arg_283_1.text_.text = var_286_2

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_4 = 51 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_2) / 51)

				if (51 <= 0 and var_286_0 or var_286_0 * (utf8.len(var_286_2) / 51)) > 0 and var_286_0 < var_286_4 then
					arg_283_1.talkMaxDuration = var_286_4

					if var_286_4 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_4 + 0
					end
				end

				arg_283_1.text_.text = var_286_2
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042069", "story_v_out_425042.awb") ~= 0 then
					local var_286_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042069", "story_v_out_425042.awb") / 1000

					if var_286_5 + 0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_5 + 0
					end

					if var_286_1.prefab_name ~= "" and arg_283_1.actors_[var_286_1.prefab_name] ~= nil then
						local var_286_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_1.prefab_name].transform, "story_v_out_425042", "425042069", "story_v_out_425042.awb")

						arg_283_1:RecordAudio("425042069", var_286_6)
						arg_283_1:RecordAudio("425042069", var_286_6)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_425042", "425042069", "story_v_out_425042.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_425042", "425042069", "story_v_out_425042.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_7 = math.max(var_286_0, arg_283_1.talkMaxDuration)

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_7 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - 0) / var_286_7

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= 0 + var_286_7 and arg_283_1.time_ < 0 + var_286_7 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play425042070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 425042070
		arg_287_1.duration_ = 3.7

		local var_287_0 = {
			zh = 3.633,
			ja = 3.7
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
				arg_287_0:Play425042071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos10127 = arg_287_1.actors_["10127"].transform.localPosition
				arg_287_1.actors_["10127"].transform.localScale = Vector3.New(1, 1, 1)

				arg_287_1:CheckSpriteTmpPos("10127", 2)

				for iter_290_0 = 0, arg_287_1.actors_["10127"].transform.childCount - 1 do
					local var_290_0 = arg_287_1.actors_["10127"].transform:GetChild(iter_290_0)

					if var_290_0.name == "split_6" then
						var_290_0:SetAsLastSibling()
						var_290_0.gameObject:SetActive(true)

						arg_287_1.var_.actorSpriteSplit10127 = var_290_0.gameObject:GetComponent(typeof(Image))

						arg_287_1.var_.actorSpriteSplit10127:SetAlpha(0)
					end
				end
			end

			local var_290_1 = 0.5

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_1 then
				arg_287_1.actors_["10127"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10127, Vector3.New(-390, -387.4, -316.5), (arg_287_1.time_ - 0) / var_290_1)

				if arg_287_1.var_.actorSpriteSplit10127 ~= nil then
					arg_287_1.var_.actorSpriteSplit10127:SetAlpha((arg_287_1.time_ - 0) / var_290_1)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_1 and arg_287_1.time_ < 0 + var_290_1 + arg_290_0 then
				arg_287_1.actors_["10127"].transform.localPosition = Vector3.New(-390, -387.4, -316.5)

				if arg_287_1.var_.actorSpriteSplit10127 ~= nil then
					arg_287_1.var_.actorSpriteSplit10127:SetAlpha(1)
				end
			end

			local var_290_2 = 0
			local var_290_3 = 0.475

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_2 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_4 = arg_287_1:GetWordFromCfg(425042070)
				local var_290_5 = arg_287_1:FormatText(var_290_4.content)

				arg_287_1.text_.text = var_290_5

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_7 = 19 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 19)

				if (19 <= 0 and var_290_3 or var_290_3 * (utf8.len(var_290_5) / 19)) > 0 and var_290_3 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_2
					end
				end

				arg_287_1.text_.text = var_290_5
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042070", "story_v_out_425042.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042070", "story_v_out_425042.awb") / 1000

					if var_290_8 + var_290_2 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_2
					end

					if var_290_4.prefab_name ~= "" and arg_287_1.actors_[var_290_4.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_4.prefab_name].transform, "story_v_out_425042", "425042070", "story_v_out_425042.awb")

						arg_287_1:RecordAudio("425042070", var_290_9)
						arg_287_1:RecordAudio("425042070", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_425042", "425042070", "story_v_out_425042.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_425042", "425042070", "story_v_out_425042.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_3, arg_287_1.talkMaxDuration)

			if var_290_2 <= arg_287_1.time_ and arg_287_1.time_ < var_290_2 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_2) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_2 + var_290_10 and arg_287_1.time_ < var_290_2 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play425042071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 425042071
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play425042072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["10127"]) and arg_291_1.var_.actorSpriteComps10127 == nil then
				arg_291_1.var_.actorSpriteComps10127 = arg_291_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_0 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["10127"]) then
				if arg_291_1.var_.actorSpriteComps10127 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_294_1 then
							if arg_291_1.isInRecall_ then
								iter_294_1.color = Color.New(Mathf.Lerp(iter_294_1.color.r, arg_291_1.hightColor2.r, (arg_291_1.time_ - 0) / var_294_0), Mathf.Lerp(iter_294_1.color.g, arg_291_1.hightColor2.g, (arg_291_1.time_ - 0) / var_294_0), (Mathf.Lerp(iter_294_1.color.b, arg_291_1.hightColor2.b, (arg_291_1.time_ - 0) / var_294_0)))
							else
								local var_294_1 = Mathf.Lerp(iter_294_1.color.r, 0.5, (arg_291_1.time_ - 0) / var_294_0)

								iter_294_1.color = Color.New(var_294_1, var_294_1, var_294_1)
							end
						end
					end
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["10127"]) and arg_291_1.var_.actorSpriteComps10127 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_294_3 then
						iter_294_3.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_291_1.var_.actorSpriteComps10127 = nil
			end

			local var_294_2 = arg_291_1.actors_["1137"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos1137 = var_294_2.localPosition
				var_294_2.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("1137", 7)

				for iter_294_4 = 0, var_294_2.childCount - 1 do
					local var_294_3 = var_294_2:GetChild(iter_294_4)

					if var_294_3.name == "" or not string.find(var_294_3.name, "split") then
						var_294_3.gameObject:SetActive(true)
					else
						var_294_3.gameObject:SetActive(false)
					end
				end
			end

			local var_294_4 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 then
				var_294_2.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_291_1.time_ - 0) / var_294_4)
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				var_294_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_294_5 = arg_291_1.actors_["10127"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos10127 = var_294_5.localPosition
				var_294_5.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("10127", 7)

				for iter_294_5 = 0, var_294_5.childCount - 1 do
					local var_294_6 = var_294_5:GetChild(iter_294_5)

					if var_294_6.name == "split_6" or not string.find(var_294_6.name, "split") then
						var_294_6.gameObject:SetActive(true)
					else
						var_294_6.gameObject:SetActive(false)
					end
				end
			end

			local var_294_7 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_7 then
				var_294_5.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10127, Vector3.New(0, -2000, 0), (arg_291_1.time_ - 0) / var_294_7)
			end

			if arg_291_1.time_ >= 0 + var_294_7 and arg_291_1.time_ < 0 + var_294_7 + arg_294_0 then
				var_294_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_294_8 = 0
			local var_294_9 = 0.6

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_8 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_10 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(425042071).content)

				arg_291_1.text_.text = var_294_10

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_12 = 24 <= 0 and var_294_9 or var_294_9 * (utf8.len(var_294_10) / 24)

				if (24 <= 0 and var_294_9 or var_294_9 * (utf8.len(var_294_10) / 24)) > 0 and var_294_9 < var_294_12 then
					arg_291_1.talkMaxDuration = var_294_12

					if var_294_12 + var_294_8 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_12 + var_294_8
					end
				end

				arg_291_1.text_.text = var_294_10
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_13 = math.max(var_294_9, arg_291_1.talkMaxDuration)

			if var_294_8 <= arg_291_1.time_ and arg_291_1.time_ < var_294_8 + var_294_13 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_8) / var_294_13

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_8 + var_294_13 and arg_291_1.time_ < var_294_8 + var_294_13 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play425042072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 425042072
		arg_295_1.duration_ = 12.57

		local var_295_0 = {
			zh = 8.166,
			ja = 12.566
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
				arg_295_0:Play425042073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["10127"]) and arg_295_1.var_.actorSpriteComps10127 == nil then
				arg_295_1.var_.actorSpriteComps10127 = arg_295_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_0 = 0.2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["10127"]) then
				if arg_295_1.var_.actorSpriteComps10127 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_298_1 then
							if arg_295_1.isInRecall_ then
								iter_298_1.color = Color.New(Mathf.Lerp(iter_298_1.color.r, arg_295_1.hightColor1.r, (arg_295_1.time_ - 0) / var_298_0), Mathf.Lerp(iter_298_1.color.g, arg_295_1.hightColor1.g, (arg_295_1.time_ - 0) / var_298_0), (Mathf.Lerp(iter_298_1.color.b, arg_295_1.hightColor1.b, (arg_295_1.time_ - 0) / var_298_0)))
							else
								local var_298_1 = Mathf.Lerp(iter_298_1.color.r, 1, (arg_295_1.time_ - 0) / var_298_0)

								iter_298_1.color = Color.New(var_298_1, var_298_1, var_298_1)
							end
						end
					end
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["10127"]) and arg_295_1.var_.actorSpriteComps10127 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_298_3 then
						iter_298_3.color = arg_295_1.isInRecall_ and (arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_295_1.var_.actorSpriteComps10127 = nil
			end

			local var_298_2 = arg_295_1.actors_["10127"].transform

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos10127 = var_298_2.localPosition
				var_298_2.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("10127", 3)

				for iter_298_4 = 0, var_298_2.childCount - 1 do
					local var_298_3 = var_298_2:GetChild(iter_298_4)

					if var_298_3.name == "split_6" or not string.find(var_298_3.name, "split") then
						var_298_3.gameObject:SetActive(true)
					else
						var_298_3.gameObject:SetActive(false)
					end
				end
			end

			local var_298_4 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_4 then
				var_298_2.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10127, Vector3.New(0, -387.4, -316.5), (arg_295_1.time_ - 0) / var_298_4)
			end

			if arg_295_1.time_ >= 0 + var_298_4 and arg_295_1.time_ < 0 + var_298_4 + arg_298_0 then
				var_298_2.localPosition = Vector3.New(0, -387.4, -316.5)
			end

			local var_298_5 = 0
			local var_298_6 = 1.025

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_5 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_7 = arg_295_1:GetWordFromCfg(425042072)
				local var_298_8 = arg_295_1:FormatText(var_298_7.content)

				arg_295_1.text_.text = var_298_8

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_10 = 41 <= 0 and var_298_6 or var_298_6 * (utf8.len(var_298_8) / 41)

				if (41 <= 0 and var_298_6 or var_298_6 * (utf8.len(var_298_8) / 41)) > 0 and var_298_6 < var_298_10 then
					arg_295_1.talkMaxDuration = var_298_10

					if var_298_10 + var_298_5 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_10 + var_298_5
					end
				end

				arg_295_1.text_.text = var_298_8
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042072", "story_v_out_425042.awb") ~= 0 then
					local var_298_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042072", "story_v_out_425042.awb") / 1000

					if var_298_11 + var_298_5 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_11 + var_298_5
					end

					if var_298_7.prefab_name ~= "" and arg_295_1.actors_[var_298_7.prefab_name] ~= nil then
						local var_298_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_7.prefab_name].transform, "story_v_out_425042", "425042072", "story_v_out_425042.awb")

						arg_295_1:RecordAudio("425042072", var_298_12)
						arg_295_1:RecordAudio("425042072", var_298_12)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_425042", "425042072", "story_v_out_425042.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_425042", "425042072", "story_v_out_425042.awb")
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
				actorName = "10127",
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
	Play425042073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 425042073
		arg_299_1.duration_ = 16.73

		local var_299_0 = {
			zh = 11.6,
			ja = 16.733
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
				arg_299_0:Play425042074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 1.4

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:GetWordFromCfg(425042073)
				local var_302_2 = arg_299_1:FormatText(var_302_1.content)

				arg_299_1.text_.text = var_302_2

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_4 = 56 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 56)

				if (56 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 56)) > 0 and var_302_0 < var_302_4 then
					arg_299_1.talkMaxDuration = var_302_4

					if var_302_4 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_4 + 0
					end
				end

				arg_299_1.text_.text = var_302_2
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042073", "story_v_out_425042.awb") ~= 0 then
					local var_302_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042073", "story_v_out_425042.awb") / 1000

					if var_302_5 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + 0
					end

					if var_302_1.prefab_name ~= "" and arg_299_1.actors_[var_302_1.prefab_name] ~= nil then
						local var_302_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_1.prefab_name].transform, "story_v_out_425042", "425042073", "story_v_out_425042.awb")

						arg_299_1:RecordAudio("425042073", var_302_6)
						arg_299_1:RecordAudio("425042073", var_302_6)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_425042", "425042073", "story_v_out_425042.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_425042", "425042073", "story_v_out_425042.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_7 and arg_299_1.time_ < 0 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play425042074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 425042074
		arg_303_1.duration_ = 13.7

		local var_303_0 = {
			zh = 11.033,
			ja = 13.7
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
				arg_303_0:Play425042075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 1.45

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:GetWordFromCfg(425042074)
				local var_306_2 = arg_303_1:FormatText(var_306_1.content)

				arg_303_1.text_.text = var_306_2

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_4 = 58 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 58)

				if (58 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 58)) > 0 and var_306_0 < var_306_4 then
					arg_303_1.talkMaxDuration = var_306_4

					if var_306_4 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_4 + 0
					end
				end

				arg_303_1.text_.text = var_306_2
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042074", "story_v_out_425042.awb") ~= 0 then
					local var_306_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042074", "story_v_out_425042.awb") / 1000

					if var_306_5 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + 0
					end

					if var_306_1.prefab_name ~= "" and arg_303_1.actors_[var_306_1.prefab_name] ~= nil then
						local var_306_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_1.prefab_name].transform, "story_v_out_425042", "425042074", "story_v_out_425042.awb")

						arg_303_1:RecordAudio("425042074", var_306_6)
						arg_303_1:RecordAudio("425042074", var_306_6)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_425042", "425042074", "story_v_out_425042.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_425042", "425042074", "story_v_out_425042.awb")
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
	Play425042075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 425042075
		arg_307_1.duration_ = 2.07

		local var_307_0 = {
			zh = 2.066,
			ja = 2
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
				arg_307_0:Play425042076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["1137"]) and arg_307_1.var_.actorSpriteComps1137 == nil then
				arg_307_1.var_.actorSpriteComps1137 = arg_307_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_0 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["1137"]) then
				if arg_307_1.var_.actorSpriteComps1137 then
					for iter_310_0, iter_310_1 in pairs(arg_307_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_310_1 then
							if arg_307_1.isInRecall_ then
								iter_310_1.color = Color.New(Mathf.Lerp(iter_310_1.color.r, arg_307_1.hightColor1.r, (arg_307_1.time_ - 0) / var_310_0), Mathf.Lerp(iter_310_1.color.g, arg_307_1.hightColor1.g, (arg_307_1.time_ - 0) / var_310_0), (Mathf.Lerp(iter_310_1.color.b, arg_307_1.hightColor1.b, (arg_307_1.time_ - 0) / var_310_0)))
							else
								local var_310_1 = Mathf.Lerp(iter_310_1.color.r, 1, (arg_307_1.time_ - 0) / var_310_0)

								iter_310_1.color = Color.New(var_310_1, var_310_1, var_310_1)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["1137"]) and arg_307_1.var_.actorSpriteComps1137 then
				for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_310_3 then
						iter_310_3.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_307_1.var_.actorSpriteComps1137 = nil
			end

			local var_310_2 = arg_307_1.actors_["10127"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_2) and arg_307_1.var_.actorSpriteComps10127 == nil then
				arg_307_1.var_.actorSpriteComps10127 = var_310_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_3 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_3 and not isNil(var_310_2) then
				if arg_307_1.var_.actorSpriteComps10127 then
					for iter_310_4, iter_310_5 in pairs(arg_307_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_310_5 then
							if arg_307_1.isInRecall_ then
								iter_310_5.color = Color.New(Mathf.Lerp(iter_310_5.color.r, arg_307_1.hightColor2.r, (arg_307_1.time_ - 0) / var_310_3), Mathf.Lerp(iter_310_5.color.g, arg_307_1.hightColor2.g, (arg_307_1.time_ - 0) / var_310_3), (Mathf.Lerp(iter_310_5.color.b, arg_307_1.hightColor2.b, (arg_307_1.time_ - 0) / var_310_3)))
							else
								local var_310_4 = Mathf.Lerp(iter_310_5.color.r, 0.5, (arg_307_1.time_ - 0) / var_310_3)

								iter_310_5.color = Color.New(var_310_4, var_310_4, var_310_4)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= 0 + var_310_3 and arg_307_1.time_ < 0 + var_310_3 + arg_310_0 and not isNil(var_310_2) and arg_307_1.var_.actorSpriteComps10127 then
				for iter_310_6, iter_310_7 in pairs(arg_307_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_310_7 then
						iter_310_7.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_307_1.var_.actorSpriteComps10127 = nil
			end

			local var_310_5 = arg_307_1.actors_["10127"].transform

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos10127 = var_310_5.localPosition
				var_310_5.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("10127", 2)

				for iter_310_8 = 0, var_310_5.childCount - 1 do
					local var_310_6 = var_310_5:GetChild(iter_310_8)

					if var_310_6.name == "split_6" or not string.find(var_310_6.name, "split") then
						var_310_6.gameObject:SetActive(true)
					else
						var_310_6.gameObject:SetActive(false)
					end
				end
			end

			local var_310_7 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_7 then
				var_310_5.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos10127, Vector3.New(-390, -387.4, -316.5), (arg_307_1.time_ - 0) / var_310_7)
			end

			if arg_307_1.time_ >= 0 + var_310_7 and arg_307_1.time_ < 0 + var_310_7 + arg_310_0 then
				var_310_5.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_310_8 = arg_307_1.actors_["1137"].transform

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos1137 = var_310_8.localPosition
				var_310_8.localScale = Vector3.New(1, 1, 1)

				arg_307_1:CheckSpriteTmpPos("1137", 4)

				for iter_310_9 = 0, var_310_8.childCount - 1 do
					local var_310_9 = var_310_8:GetChild(iter_310_9)

					if var_310_9.name == "split_4" or not string.find(var_310_9.name, "split") then
						var_310_9.gameObject:SetActive(true)
					else
						var_310_9.gameObject:SetActive(false)
					end
				end
			end

			local var_310_10 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_10 then
				var_310_8.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_307_1.time_ - 0) / var_310_10)
			end

			if arg_307_1.time_ >= 0 + var_310_10 and arg_307_1.time_ < 0 + var_310_10 + arg_310_0 then
				var_310_8.localPosition = Vector3.New(390, -425, -200)
			end

			local var_310_11 = 0
			local var_310_12 = 0.05

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_11 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_13 = arg_307_1:GetWordFromCfg(425042075)
				local var_310_14 = arg_307_1:FormatText(var_310_13.content)

				arg_307_1.text_.text = var_310_14

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_16 = 2 <= 0 and var_310_12 or var_310_12 * (utf8.len(var_310_14) / 2)

				if (2 <= 0 and var_310_12 or var_310_12 * (utf8.len(var_310_14) / 2)) > 0 and var_310_12 < var_310_16 then
					arg_307_1.talkMaxDuration = var_310_16

					if var_310_16 + var_310_11 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_16 + var_310_11
					end
				end

				arg_307_1.text_.text = var_310_14
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042075", "story_v_out_425042.awb") ~= 0 then
					local var_310_17 = manager.audio:GetVoiceLength("story_v_out_425042", "425042075", "story_v_out_425042.awb") / 1000

					if var_310_17 + var_310_11 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_17 + var_310_11
					end

					if var_310_13.prefab_name ~= "" and arg_307_1.actors_[var_310_13.prefab_name] ~= nil then
						local var_310_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_13.prefab_name].transform, "story_v_out_425042", "425042075", "story_v_out_425042.awb")

						arg_307_1:RecordAudio("425042075", var_310_18)
						arg_307_1:RecordAudio("425042075", var_310_18)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_425042", "425042075", "story_v_out_425042.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_425042", "425042075", "story_v_out_425042.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_19 = math.max(var_310_12, arg_307_1.talkMaxDuration)

			if var_310_11 <= arg_307_1.time_ and arg_307_1.time_ < var_310_11 + var_310_19 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_11) / var_310_19

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_11 + var_310_19 and arg_307_1.time_ < var_310_11 + var_310_19 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1137",
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
	Play425042076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 425042076
		arg_311_1.duration_ = 7.1

		local var_311_0 = {
			zh = 3.766,
			ja = 7.1
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
				arg_311_0:Play425042077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["10127"]) and arg_311_1.var_.actorSpriteComps10127 == nil then
				arg_311_1.var_.actorSpriteComps10127 = arg_311_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_0 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["10127"]) then
				if arg_311_1.var_.actorSpriteComps10127 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_314_1 then
							if arg_311_1.isInRecall_ then
								iter_314_1.color = Color.New(Mathf.Lerp(iter_314_1.color.r, arg_311_1.hightColor1.r, (arg_311_1.time_ - 0) / var_314_0), Mathf.Lerp(iter_314_1.color.g, arg_311_1.hightColor1.g, (arg_311_1.time_ - 0) / var_314_0), (Mathf.Lerp(iter_314_1.color.b, arg_311_1.hightColor1.b, (arg_311_1.time_ - 0) / var_314_0)))
							else
								local var_314_1 = Mathf.Lerp(iter_314_1.color.r, 1, (arg_311_1.time_ - 0) / var_314_0)

								iter_314_1.color = Color.New(var_314_1, var_314_1, var_314_1)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["10127"]) and arg_311_1.var_.actorSpriteComps10127 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_314_3 then
						iter_314_3.color = arg_311_1.isInRecall_ and (arg_311_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_311_1.var_.actorSpriteComps10127 = nil
			end

			local var_314_2 = arg_311_1.actors_["1137"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_2) and arg_311_1.var_.actorSpriteComps1137 == nil then
				arg_311_1.var_.actorSpriteComps1137 = var_314_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_3 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_3 and not isNil(var_314_2) then
				if arg_311_1.var_.actorSpriteComps1137 then
					for iter_314_4, iter_314_5 in pairs(arg_311_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_314_5 then
							if arg_311_1.isInRecall_ then
								iter_314_5.color = Color.New(Mathf.Lerp(iter_314_5.color.r, arg_311_1.hightColor2.r, (arg_311_1.time_ - 0) / var_314_3), Mathf.Lerp(iter_314_5.color.g, arg_311_1.hightColor2.g, (arg_311_1.time_ - 0) / var_314_3), (Mathf.Lerp(iter_314_5.color.b, arg_311_1.hightColor2.b, (arg_311_1.time_ - 0) / var_314_3)))
							else
								local var_314_4 = Mathf.Lerp(iter_314_5.color.r, 0.5, (arg_311_1.time_ - 0) / var_314_3)

								iter_314_5.color = Color.New(var_314_4, var_314_4, var_314_4)
							end
						end
					end
				end
			end

			if arg_311_1.time_ >= 0 + var_314_3 and arg_311_1.time_ < 0 + var_314_3 + arg_314_0 and not isNil(var_314_2) and arg_311_1.var_.actorSpriteComps1137 then
				for iter_314_6, iter_314_7 in pairs(arg_311_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_314_7 then
						iter_314_7.color = arg_311_1.isInRecall_ and (arg_311_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_311_1.var_.actorSpriteComps1137 = nil
			end

			local var_314_5 = arg_311_1.actors_["10127"].transform

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos10127 = var_314_5.localPosition
				var_314_5.localScale = Vector3.New(1, 1, 1)

				arg_311_1:CheckSpriteTmpPos("10127", 2)

				for iter_314_8 = 0, var_314_5.childCount - 1 do
					local var_314_6 = var_314_5:GetChild(iter_314_8)

					if var_314_6.name == "split_1" then
						var_314_6:SetAsLastSibling()
						var_314_6.gameObject:SetActive(true)

						arg_311_1.var_.actorSpriteSplit10127 = var_314_6.gameObject:GetComponent(typeof(Image))

						arg_311_1.var_.actorSpriteSplit10127:SetAlpha(0)
					end
				end
			end

			local var_314_7 = 0.5

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_7 then
				var_314_5.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos10127, Vector3.New(-390, -387.4, -316.5), (arg_311_1.time_ - 0) / var_314_7)

				if arg_311_1.var_.actorSpriteSplit10127 ~= nil then
					arg_311_1.var_.actorSpriteSplit10127:SetAlpha((arg_311_1.time_ - 0) / var_314_7)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_7 and arg_311_1.time_ < 0 + var_314_7 + arg_314_0 then
				var_314_5.localPosition = Vector3.New(-390, -387.4, -316.5)

				if arg_311_1.var_.actorSpriteSplit10127 ~= nil then
					arg_311_1.var_.actorSpriteSplit10127:SetAlpha(1)
				end
			end

			local var_314_8 = 0
			local var_314_9 = 0.425

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_8 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_10 = arg_311_1:GetWordFromCfg(425042076)
				local var_314_11 = arg_311_1:FormatText(var_314_10.content)

				arg_311_1.text_.text = var_314_11

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_13 = 17 <= 0 and var_314_9 or var_314_9 * (utf8.len(var_314_11) / 17)

				if (17 <= 0 and var_314_9 or var_314_9 * (utf8.len(var_314_11) / 17)) > 0 and var_314_9 < var_314_13 then
					arg_311_1.talkMaxDuration = var_314_13

					if var_314_13 + var_314_8 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_13 + var_314_8
					end
				end

				arg_311_1.text_.text = var_314_11
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042076", "story_v_out_425042.awb") ~= 0 then
					local var_314_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042076", "story_v_out_425042.awb") / 1000

					if var_314_14 + var_314_8 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_14 + var_314_8
					end

					if var_314_10.prefab_name ~= "" and arg_311_1.actors_[var_314_10.prefab_name] ~= nil then
						local var_314_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_10.prefab_name].transform, "story_v_out_425042", "425042076", "story_v_out_425042.awb")

						arg_311_1:RecordAudio("425042076", var_314_15)
						arg_311_1:RecordAudio("425042076", var_314_15)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_425042", "425042076", "story_v_out_425042.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_425042", "425042076", "story_v_out_425042.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_16 = math.max(var_314_9, arg_311_1.talkMaxDuration)

			if var_314_8 <= arg_311_1.time_ and arg_311_1.time_ < var_314_8 + var_314_16 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_8) / var_314_16

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_8 + var_314_16 and arg_311_1.time_ < var_314_8 + var_314_16 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play425042077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 425042077
		arg_315_1.duration_ = 15.1

		local var_315_0 = {
			zh = 7.7,
			ja = 15.1
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
				arg_315_0:Play425042078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["1137"]) and arg_315_1.var_.actorSpriteComps1137 == nil then
				arg_315_1.var_.actorSpriteComps1137 = arg_315_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_0 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["1137"]) then
				if arg_315_1.var_.actorSpriteComps1137 then
					for iter_318_0, iter_318_1 in pairs(arg_315_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["1137"]) and arg_315_1.var_.actorSpriteComps1137 then
				for iter_318_2, iter_318_3 in pairs(arg_315_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_318_3 then
						iter_318_3.color = arg_315_1.isInRecall_ and (arg_315_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_315_1.var_.actorSpriteComps1137 = nil
			end

			local var_318_2 = arg_315_1.actors_["10127"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_2) and arg_315_1.var_.actorSpriteComps10127 == nil then
				arg_315_1.var_.actorSpriteComps10127 = var_318_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_318_3 = 0.2

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_3 and not isNil(var_318_2) then
				if arg_315_1.var_.actorSpriteComps10127 then
					for iter_318_4, iter_318_5 in pairs(arg_315_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_318_5 then
							if arg_315_1.isInRecall_ then
								iter_318_5.color = Color.New(Mathf.Lerp(iter_318_5.color.r, arg_315_1.hightColor2.r, (arg_315_1.time_ - 0) / var_318_3), Mathf.Lerp(iter_318_5.color.g, arg_315_1.hightColor2.g, (arg_315_1.time_ - 0) / var_318_3), (Mathf.Lerp(iter_318_5.color.b, arg_315_1.hightColor2.b, (arg_315_1.time_ - 0) / var_318_3)))
							else
								local var_318_4 = Mathf.Lerp(iter_318_5.color.r, 0.5, (arg_315_1.time_ - 0) / var_318_3)

								iter_318_5.color = Color.New(var_318_4, var_318_4, var_318_4)
							end
						end
					end
				end
			end

			if arg_315_1.time_ >= 0 + var_318_3 and arg_315_1.time_ < 0 + var_318_3 + arg_318_0 and not isNil(var_318_2) and arg_315_1.var_.actorSpriteComps10127 then
				for iter_318_6, iter_318_7 in pairs(arg_315_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_318_7 then
						iter_318_7.color = arg_315_1.isInRecall_ and (arg_315_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_315_1.var_.actorSpriteComps10127 = nil
			end

			local var_318_5 = arg_315_1.actors_["1137"].transform

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos1137 = var_318_5.localPosition
				var_318_5.localScale = Vector3.New(1, 1, 1)

				arg_315_1:CheckSpriteTmpPos("1137", 4)

				for iter_318_8 = 0, var_318_5.childCount - 1 do
					local var_318_6 = var_318_5:GetChild(iter_318_8)

					if var_318_6.name == "split_4" or not string.find(var_318_6.name, "split") then
						var_318_6.gameObject:SetActive(true)
					else
						var_318_6.gameObject:SetActive(false)
					end
				end
			end

			local var_318_7 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_7 then
				var_318_5.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_315_1.time_ - 0) / var_318_7)
			end

			if arg_315_1.time_ >= 0 + var_318_7 and arg_315_1.time_ < 0 + var_318_7 + arg_318_0 then
				var_318_5.localPosition = Vector3.New(390, -425, -200)
			end

			local var_318_8 = 0
			local var_318_9 = 0.875

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_8 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_10 = arg_315_1:GetWordFromCfg(425042077)
				local var_318_11 = arg_315_1:FormatText(var_318_10.content)

				arg_315_1.text_.text = var_318_11

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_13 = 33 <= 0 and var_318_9 or var_318_9 * (utf8.len(var_318_11) / 33)

				if (33 <= 0 and var_318_9 or var_318_9 * (utf8.len(var_318_11) / 33)) > 0 and var_318_9 < var_318_13 then
					arg_315_1.talkMaxDuration = var_318_13

					if var_318_13 + var_318_8 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_13 + var_318_8
					end
				end

				arg_315_1.text_.text = var_318_11
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042077", "story_v_out_425042.awb") ~= 0 then
					local var_318_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042077", "story_v_out_425042.awb") / 1000

					if var_318_14 + var_318_8 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_14 + var_318_8
					end

					if var_318_10.prefab_name ~= "" and arg_315_1.actors_[var_318_10.prefab_name] ~= nil then
						local var_318_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_10.prefab_name].transform, "story_v_out_425042", "425042077", "story_v_out_425042.awb")

						arg_315_1:RecordAudio("425042077", var_318_15)
						arg_315_1:RecordAudio("425042077", var_318_15)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_425042", "425042077", "story_v_out_425042.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_425042", "425042077", "story_v_out_425042.awb")
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
				actorName = "1137",
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
	Play425042078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 425042078
		arg_319_1.duration_ = 6.97

		local var_319_0 = {
			zh = 4.7,
			ja = 6.966
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
				arg_319_0:Play425042079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0.6

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_1 = arg_319_1:GetWordFromCfg(425042078)
				local var_322_2 = arg_319_1:FormatText(var_322_1.content)

				arg_319_1.text_.text = var_322_2

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_4 = 24 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 24)

				if (24 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_2) / 24)) > 0 and var_322_0 < var_322_4 then
					arg_319_1.talkMaxDuration = var_322_4

					if var_322_4 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_4 + 0
					end
				end

				arg_319_1.text_.text = var_322_2
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042078", "story_v_out_425042.awb") ~= 0 then
					local var_322_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042078", "story_v_out_425042.awb") / 1000

					if var_322_5 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_5 + 0
					end

					if var_322_1.prefab_name ~= "" and arg_319_1.actors_[var_322_1.prefab_name] ~= nil then
						local var_322_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_1.prefab_name].transform, "story_v_out_425042", "425042078", "story_v_out_425042.awb")

						arg_319_1:RecordAudio("425042078", var_322_6)
						arg_319_1:RecordAudio("425042078", var_322_6)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_425042", "425042078", "story_v_out_425042.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_425042", "425042078", "story_v_out_425042.awb")
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
	Play425042079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 425042079
		arg_323_1.duration_ = 1.23

		local var_323_0 = {
			zh = 1.233,
			ja = 1.2
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
				arg_323_0:Play425042080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["10127"]) and arg_323_1.var_.actorSpriteComps10127 == nil then
				arg_323_1.var_.actorSpriteComps10127 = arg_323_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_0 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["10127"]) then
				if arg_323_1.var_.actorSpriteComps10127 then
					for iter_326_0, iter_326_1 in pairs(arg_323_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_326_1 then
							if arg_323_1.isInRecall_ then
								iter_326_1.color = Color.New(Mathf.Lerp(iter_326_1.color.r, arg_323_1.hightColor1.r, (arg_323_1.time_ - 0) / var_326_0), Mathf.Lerp(iter_326_1.color.g, arg_323_1.hightColor1.g, (arg_323_1.time_ - 0) / var_326_0), (Mathf.Lerp(iter_326_1.color.b, arg_323_1.hightColor1.b, (arg_323_1.time_ - 0) / var_326_0)))
							else
								local var_326_1 = Mathf.Lerp(iter_326_1.color.r, 1, (arg_323_1.time_ - 0) / var_326_0)

								iter_326_1.color = Color.New(var_326_1, var_326_1, var_326_1)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["10127"]) and arg_323_1.var_.actorSpriteComps10127 then
				for iter_326_2, iter_326_3 in pairs(arg_323_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_326_3 then
						iter_326_3.color = arg_323_1.isInRecall_ and (arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_323_1.var_.actorSpriteComps10127 = nil
			end

			local var_326_2 = arg_323_1.actors_["1137"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.actorSpriteComps1137 == nil then
				arg_323_1.var_.actorSpriteComps1137 = var_326_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_3 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_3 and not isNil(var_326_2) then
				if arg_323_1.var_.actorSpriteComps1137 then
					for iter_326_4, iter_326_5 in pairs(arg_323_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_326_5 then
							if arg_323_1.isInRecall_ then
								iter_326_5.color = Color.New(Mathf.Lerp(iter_326_5.color.r, arg_323_1.hightColor2.r, (arg_323_1.time_ - 0) / var_326_3), Mathf.Lerp(iter_326_5.color.g, arg_323_1.hightColor2.g, (arg_323_1.time_ - 0) / var_326_3), (Mathf.Lerp(iter_326_5.color.b, arg_323_1.hightColor2.b, (arg_323_1.time_ - 0) / var_326_3)))
							else
								local var_326_4 = Mathf.Lerp(iter_326_5.color.r, 0.5, (arg_323_1.time_ - 0) / var_326_3)

								iter_326_5.color = Color.New(var_326_4, var_326_4, var_326_4)
							end
						end
					end
				end
			end

			if arg_323_1.time_ >= 0 + var_326_3 and arg_323_1.time_ < 0 + var_326_3 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.actorSpriteComps1137 then
				for iter_326_6, iter_326_7 in pairs(arg_323_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_326_7 then
						iter_326_7.color = arg_323_1.isInRecall_ and (arg_323_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_323_1.var_.actorSpriteComps1137 = nil
			end

			local var_326_5 = arg_323_1.actors_["10127"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos10127 = var_326_5.localPosition
				var_326_5.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("10127", 2)

				for iter_326_8 = 0, var_326_5.childCount - 1 do
					local var_326_6 = var_326_5:GetChild(iter_326_8)

					if var_326_6.name == "split_5" then
						var_326_6:SetAsLastSibling()
						var_326_6.gameObject:SetActive(true)

						arg_323_1.var_.actorSpriteSplit10127 = var_326_6.gameObject:GetComponent(typeof(Image))

						arg_323_1.var_.actorSpriteSplit10127:SetAlpha(0)
					end
				end
			end

			local var_326_7 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_7 then
				var_326_5.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10127, Vector3.New(-390, -387.4, -316.5), (arg_323_1.time_ - 0) / var_326_7)

				if arg_323_1.var_.actorSpriteSplit10127 ~= nil then
					arg_323_1.var_.actorSpriteSplit10127:SetAlpha((arg_323_1.time_ - 0) / var_326_7)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_7 and arg_323_1.time_ < 0 + var_326_7 + arg_326_0 then
				var_326_5.localPosition = Vector3.New(-390, -387.4, -316.5)

				if arg_323_1.var_.actorSpriteSplit10127 ~= nil then
					arg_323_1.var_.actorSpriteSplit10127:SetAlpha(1)
				end
			end

			local var_326_8 = 0
			local var_326_9 = 0.05

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_8 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_10 = arg_323_1:GetWordFromCfg(425042079)
				local var_326_11 = arg_323_1:FormatText(var_326_10.content)

				arg_323_1.text_.text = var_326_11

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_13 = 2 <= 0 and var_326_9 or var_326_9 * (utf8.len(var_326_11) / 2)

				if (2 <= 0 and var_326_9 or var_326_9 * (utf8.len(var_326_11) / 2)) > 0 and var_326_9 < var_326_13 then
					arg_323_1.talkMaxDuration = var_326_13

					if var_326_13 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_13 + var_326_8
					end
				end

				arg_323_1.text_.text = var_326_11
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042079", "story_v_out_425042.awb") ~= 0 then
					local var_326_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042079", "story_v_out_425042.awb") / 1000

					if var_326_14 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_14 + var_326_8
					end

					if var_326_10.prefab_name ~= "" and arg_323_1.actors_[var_326_10.prefab_name] ~= nil then
						local var_326_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_10.prefab_name].transform, "story_v_out_425042", "425042079", "story_v_out_425042.awb")

						arg_323_1:RecordAudio("425042079", var_326_15)
						arg_323_1:RecordAudio("425042079", var_326_15)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_425042", "425042079", "story_v_out_425042.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_425042", "425042079", "story_v_out_425042.awb")
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
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_323_1:InitPlayNodeList()
	end,
	Play425042080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 425042080
		arg_327_1.duration_ = 10.67

		local var_327_0 = {
			zh = 9.3,
			ja = 10.666
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
				arg_327_0:Play425042081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["1137"]) and arg_327_1.var_.actorSpriteComps1137 == nil then
				arg_327_1.var_.actorSpriteComps1137 = arg_327_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_0 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["1137"]) then
				if arg_327_1.var_.actorSpriteComps1137 then
					for iter_330_0, iter_330_1 in pairs(arg_327_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_330_1 then
							if arg_327_1.isInRecall_ then
								iter_330_1.color = Color.New(Mathf.Lerp(iter_330_1.color.r, arg_327_1.hightColor1.r, (arg_327_1.time_ - 0) / var_330_0), Mathf.Lerp(iter_330_1.color.g, arg_327_1.hightColor1.g, (arg_327_1.time_ - 0) / var_330_0), (Mathf.Lerp(iter_330_1.color.b, arg_327_1.hightColor1.b, (arg_327_1.time_ - 0) / var_330_0)))
							else
								local var_330_1 = Mathf.Lerp(iter_330_1.color.r, 1, (arg_327_1.time_ - 0) / var_330_0)

								iter_330_1.color = Color.New(var_330_1, var_330_1, var_330_1)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["1137"]) and arg_327_1.var_.actorSpriteComps1137 then
				for iter_330_2, iter_330_3 in pairs(arg_327_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_330_3 then
						iter_330_3.color = arg_327_1.isInRecall_ and (arg_327_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_327_1.var_.actorSpriteComps1137 = nil
			end

			local var_330_2 = arg_327_1.actors_["10127"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_2) and arg_327_1.var_.actorSpriteComps10127 == nil then
				arg_327_1.var_.actorSpriteComps10127 = var_330_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_330_3 = 0.2

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_3 and not isNil(var_330_2) then
				if arg_327_1.var_.actorSpriteComps10127 then
					for iter_330_4, iter_330_5 in pairs(arg_327_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_330_5 then
							if arg_327_1.isInRecall_ then
								iter_330_5.color = Color.New(Mathf.Lerp(iter_330_5.color.r, arg_327_1.hightColor2.r, (arg_327_1.time_ - 0) / var_330_3), Mathf.Lerp(iter_330_5.color.g, arg_327_1.hightColor2.g, (arg_327_1.time_ - 0) / var_330_3), (Mathf.Lerp(iter_330_5.color.b, arg_327_1.hightColor2.b, (arg_327_1.time_ - 0) / var_330_3)))
							else
								local var_330_4 = Mathf.Lerp(iter_330_5.color.r, 0.5, (arg_327_1.time_ - 0) / var_330_3)

								iter_330_5.color = Color.New(var_330_4, var_330_4, var_330_4)
							end
						end
					end
				end
			end

			if arg_327_1.time_ >= 0 + var_330_3 and arg_327_1.time_ < 0 + var_330_3 + arg_330_0 and not isNil(var_330_2) and arg_327_1.var_.actorSpriteComps10127 then
				for iter_330_6, iter_330_7 in pairs(arg_327_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_330_7 then
						iter_330_7.color = arg_327_1.isInRecall_ and (arg_327_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_327_1.var_.actorSpriteComps10127 = nil
			end

			local var_330_5 = arg_327_1.actors_["1137"].transform

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos1137 = var_330_5.localPosition
				var_330_5.localScale = Vector3.New(1, 1, 1)

				arg_327_1:CheckSpriteTmpPos("1137", 4)

				for iter_330_8 = 0, var_330_5.childCount - 1 do
					local var_330_6 = var_330_5:GetChild(iter_330_8)

					if var_330_6.name == "split_4" or not string.find(var_330_6.name, "split") then
						var_330_6.gameObject:SetActive(true)
					else
						var_330_6.gameObject:SetActive(false)
					end
				end
			end

			local var_330_7 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_7 then
				var_330_5.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_327_1.time_ - 0) / var_330_7)
			end

			if arg_327_1.time_ >= 0 + var_330_7 and arg_327_1.time_ < 0 + var_330_7 + arg_330_0 then
				var_330_5.localPosition = Vector3.New(390, -425, -200)
			end

			local var_330_8 = 0
			local var_330_9 = 1

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_8 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_10 = arg_327_1:GetWordFromCfg(425042080)
				local var_330_11 = arg_327_1:FormatText(var_330_10.content)

				arg_327_1.text_.text = var_330_11

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_13 = 40 <= 0 and var_330_9 or var_330_9 * (utf8.len(var_330_11) / 40)

				if (40 <= 0 and var_330_9 or var_330_9 * (utf8.len(var_330_11) / 40)) > 0 and var_330_9 < var_330_13 then
					arg_327_1.talkMaxDuration = var_330_13

					if var_330_13 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_13 + var_330_8
					end
				end

				arg_327_1.text_.text = var_330_11
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042080", "story_v_out_425042.awb") ~= 0 then
					local var_330_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042080", "story_v_out_425042.awb") / 1000

					if var_330_14 + var_330_8 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_14 + var_330_8
					end

					if var_330_10.prefab_name ~= "" and arg_327_1.actors_[var_330_10.prefab_name] ~= nil then
						local var_330_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_10.prefab_name].transform, "story_v_out_425042", "425042080", "story_v_out_425042.awb")

						arg_327_1:RecordAudio("425042080", var_330_15)
						arg_327_1:RecordAudio("425042080", var_330_15)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_425042", "425042080", "story_v_out_425042.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_425042", "425042080", "story_v_out_425042.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_16 = math.max(var_330_9, arg_327_1.talkMaxDuration)

			if var_330_8 <= arg_327_1.time_ and arg_327_1.time_ < var_330_8 + var_330_16 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_8) / var_330_16

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_8 + var_330_16 and arg_327_1.time_ < var_330_8 + var_330_16 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play425042081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 425042081
		arg_331_1.duration_ = 9.4

		local var_331_0 = {
			zh = 5.033,
			ja = 9.4
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
				arg_331_0:Play425042082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["10127"]) and arg_331_1.var_.actorSpriteComps10127 == nil then
				arg_331_1.var_.actorSpriteComps10127 = arg_331_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_0 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["10127"]) then
				if arg_331_1.var_.actorSpriteComps10127 then
					for iter_334_0, iter_334_1 in pairs(arg_331_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["10127"]) and arg_331_1.var_.actorSpriteComps10127 then
				for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_334_3 then
						iter_334_3.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_331_1.var_.actorSpriteComps10127 = nil
			end

			local var_334_2 = arg_331_1.actors_["1137"]

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(var_334_2) and arg_331_1.var_.actorSpriteComps1137 == nil then
				arg_331_1.var_.actorSpriteComps1137 = var_334_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_3 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_3 and not isNil(var_334_2) then
				if arg_331_1.var_.actorSpriteComps1137 then
					for iter_334_4, iter_334_5 in pairs(arg_331_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_334_5 then
							if arg_331_1.isInRecall_ then
								iter_334_5.color = Color.New(Mathf.Lerp(iter_334_5.color.r, arg_331_1.hightColor2.r, (arg_331_1.time_ - 0) / var_334_3), Mathf.Lerp(iter_334_5.color.g, arg_331_1.hightColor2.g, (arg_331_1.time_ - 0) / var_334_3), (Mathf.Lerp(iter_334_5.color.b, arg_331_1.hightColor2.b, (arg_331_1.time_ - 0) / var_334_3)))
							else
								local var_334_4 = Mathf.Lerp(iter_334_5.color.r, 0.5, (arg_331_1.time_ - 0) / var_334_3)

								iter_334_5.color = Color.New(var_334_4, var_334_4, var_334_4)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= 0 + var_334_3 and arg_331_1.time_ < 0 + var_334_3 + arg_334_0 and not isNil(var_334_2) and arg_331_1.var_.actorSpriteComps1137 then
				for iter_334_6, iter_334_7 in pairs(arg_331_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_334_7 then
						iter_334_7.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_331_1.var_.actorSpriteComps1137 = nil
			end

			local var_334_5 = arg_331_1.actors_["10127"].transform

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.var_.moveOldPos10127 = var_334_5.localPosition
				var_334_5.localScale = Vector3.New(1, 1, 1)

				arg_331_1:CheckSpriteTmpPos("10127", 2)

				for iter_334_8 = 0, var_334_5.childCount - 1 do
					local var_334_6 = var_334_5:GetChild(iter_334_8)

					if var_334_6.name == "split_1" then
						var_334_6:SetAsLastSibling()
						var_334_6.gameObject:SetActive(true)

						arg_331_1.var_.actorSpriteSplit10127 = var_334_6.gameObject:GetComponent(typeof(Image))

						arg_331_1.var_.actorSpriteSplit10127:SetAlpha(0)
					end
				end
			end

			local var_334_7 = 0.333333333333333

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_7 then
				var_334_5.localPosition = Vector3.Lerp(arg_331_1.var_.moveOldPos10127, Vector3.New(-390, -387.4, -316.5), (arg_331_1.time_ - 0) / var_334_7)

				if arg_331_1.var_.actorSpriteSplit10127 ~= nil then
					arg_331_1.var_.actorSpriteSplit10127:SetAlpha((arg_331_1.time_ - 0) / var_334_7)
				end
			end

			if arg_331_1.time_ >= 0 + var_334_7 and arg_331_1.time_ < 0 + var_334_7 + arg_334_0 then
				var_334_5.localPosition = Vector3.New(-390, -387.4, -316.5)

				if arg_331_1.var_.actorSpriteSplit10127 ~= nil then
					arg_331_1.var_.actorSpriteSplit10127:SetAlpha(1)
				end
			end

			local var_334_8 = 0
			local var_334_9 = 0.575

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_8 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_10 = arg_331_1:GetWordFromCfg(425042081)
				local var_334_11 = arg_331_1:FormatText(var_334_10.content)

				arg_331_1.text_.text = var_334_11

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_13 = 23 <= 0 and var_334_9 or var_334_9 * (utf8.len(var_334_11) / 23)

				if (23 <= 0 and var_334_9 or var_334_9 * (utf8.len(var_334_11) / 23)) > 0 and var_334_9 < var_334_13 then
					arg_331_1.talkMaxDuration = var_334_13

					if var_334_13 + var_334_8 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_13 + var_334_8
					end
				end

				arg_331_1.text_.text = var_334_11
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042081", "story_v_out_425042.awb") ~= 0 then
					local var_334_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042081", "story_v_out_425042.awb") / 1000

					if var_334_14 + var_334_8 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_14 + var_334_8
					end

					if var_334_10.prefab_name ~= "" and arg_331_1.actors_[var_334_10.prefab_name] ~= nil then
						local var_334_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_10.prefab_name].transform, "story_v_out_425042", "425042081", "story_v_out_425042.awb")

						arg_331_1:RecordAudio("425042081", var_334_15)
						arg_331_1:RecordAudio("425042081", var_334_15)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_425042", "425042081", "story_v_out_425042.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_425042", "425042081", "story_v_out_425042.awb")
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
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_331_1:InitPlayNodeList()
	end,
	Play425042082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 425042082
		arg_335_1.duration_ = 12.07

		local var_335_0 = {
			zh = 6.833,
			ja = 12.066
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
				arg_335_0:Play425042083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["1137"]) and arg_335_1.var_.actorSpriteComps1137 == nil then
				arg_335_1.var_.actorSpriteComps1137 = arg_335_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_0 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["1137"]) then
				if arg_335_1.var_.actorSpriteComps1137 then
					for iter_338_0, iter_338_1 in pairs(arg_335_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_338_1 then
							if arg_335_1.isInRecall_ then
								iter_338_1.color = Color.New(Mathf.Lerp(iter_338_1.color.r, arg_335_1.hightColor1.r, (arg_335_1.time_ - 0) / var_338_0), Mathf.Lerp(iter_338_1.color.g, arg_335_1.hightColor1.g, (arg_335_1.time_ - 0) / var_338_0), (Mathf.Lerp(iter_338_1.color.b, arg_335_1.hightColor1.b, (arg_335_1.time_ - 0) / var_338_0)))
							else
								local var_338_1 = Mathf.Lerp(iter_338_1.color.r, 1, (arg_335_1.time_ - 0) / var_338_0)

								iter_338_1.color = Color.New(var_338_1, var_338_1, var_338_1)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["1137"]) and arg_335_1.var_.actorSpriteComps1137 then
				for iter_338_2, iter_338_3 in pairs(arg_335_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_338_3 then
						iter_338_3.color = arg_335_1.isInRecall_ and (arg_335_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_335_1.var_.actorSpriteComps1137 = nil
			end

			local var_338_2 = arg_335_1.actors_["10127"]

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(var_338_2) and arg_335_1.var_.actorSpriteComps10127 == nil then
				arg_335_1.var_.actorSpriteComps10127 = var_338_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_338_3 = 0.2

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_3 and not isNil(var_338_2) then
				if arg_335_1.var_.actorSpriteComps10127 then
					for iter_338_4, iter_338_5 in pairs(arg_335_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_338_5 then
							if arg_335_1.isInRecall_ then
								iter_338_5.color = Color.New(Mathf.Lerp(iter_338_5.color.r, arg_335_1.hightColor2.r, (arg_335_1.time_ - 0) / var_338_3), Mathf.Lerp(iter_338_5.color.g, arg_335_1.hightColor2.g, (arg_335_1.time_ - 0) / var_338_3), (Mathf.Lerp(iter_338_5.color.b, arg_335_1.hightColor2.b, (arg_335_1.time_ - 0) / var_338_3)))
							else
								local var_338_4 = Mathf.Lerp(iter_338_5.color.r, 0.5, (arg_335_1.time_ - 0) / var_338_3)

								iter_338_5.color = Color.New(var_338_4, var_338_4, var_338_4)
							end
						end
					end
				end
			end

			if arg_335_1.time_ >= 0 + var_338_3 and arg_335_1.time_ < 0 + var_338_3 + arg_338_0 and not isNil(var_338_2) and arg_335_1.var_.actorSpriteComps10127 then
				for iter_338_6, iter_338_7 in pairs(arg_335_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_338_7 then
						iter_338_7.color = arg_335_1.isInRecall_ and (arg_335_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_335_1.var_.actorSpriteComps10127 = nil
			end

			local var_338_5 = arg_335_1.actors_["1137"].transform

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.var_.moveOldPos1137 = var_338_5.localPosition
				var_338_5.localScale = Vector3.New(1, 1, 1)

				arg_335_1:CheckSpriteTmpPos("1137", 4)

				for iter_338_8 = 0, var_338_5.childCount - 1 do
					local var_338_6 = var_338_5:GetChild(iter_338_8)

					if var_338_6.name == "split_4" or not string.find(var_338_6.name, "split") then
						var_338_6.gameObject:SetActive(true)
					else
						var_338_6.gameObject:SetActive(false)
					end
				end
			end

			local var_338_7 = 0.001

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_7 then
				var_338_5.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_335_1.time_ - 0) / var_338_7)
			end

			if arg_335_1.time_ >= 0 + var_338_7 and arg_335_1.time_ < 0 + var_338_7 + arg_338_0 then
				var_338_5.localPosition = Vector3.New(390, -425, -200)
			end

			local var_338_8 = 0
			local var_338_9 = 0.775

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_8 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_10 = arg_335_1:GetWordFromCfg(425042082)
				local var_338_11 = arg_335_1:FormatText(var_338_10.content)

				arg_335_1.text_.text = var_338_11

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_13 = 31 <= 0 and var_338_9 or var_338_9 * (utf8.len(var_338_11) / 31)

				if (31 <= 0 and var_338_9 or var_338_9 * (utf8.len(var_338_11) / 31)) > 0 and var_338_9 < var_338_13 then
					arg_335_1.talkMaxDuration = var_338_13

					if var_338_13 + var_338_8 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_13 + var_338_8
					end
				end

				arg_335_1.text_.text = var_338_11
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042082", "story_v_out_425042.awb") ~= 0 then
					local var_338_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042082", "story_v_out_425042.awb") / 1000

					if var_338_14 + var_338_8 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_14 + var_338_8
					end

					if var_338_10.prefab_name ~= "" and arg_335_1.actors_[var_338_10.prefab_name] ~= nil then
						local var_338_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_10.prefab_name].transform, "story_v_out_425042", "425042082", "story_v_out_425042.awb")

						arg_335_1:RecordAudio("425042082", var_338_15)
						arg_335_1:RecordAudio("425042082", var_338_15)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_425042", "425042082", "story_v_out_425042.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_425042", "425042082", "story_v_out_425042.awb")
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
				actorName = "1137",
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
	Play425042083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 425042083
		arg_339_1.duration_ = 2.07

		local var_339_0 = {
			zh = 1.633,
			ja = 2.066
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
				arg_339_0:Play425042084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["10127"]) and arg_339_1.var_.actorSpriteComps10127 == nil then
				arg_339_1.var_.actorSpriteComps10127 = arg_339_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_0 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["10127"]) then
				if arg_339_1.var_.actorSpriteComps10127 then
					for iter_342_0, iter_342_1 in pairs(arg_339_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_342_1 then
							if arg_339_1.isInRecall_ then
								iter_342_1.color = Color.New(Mathf.Lerp(iter_342_1.color.r, arg_339_1.hightColor1.r, (arg_339_1.time_ - 0) / var_342_0), Mathf.Lerp(iter_342_1.color.g, arg_339_1.hightColor1.g, (arg_339_1.time_ - 0) / var_342_0), (Mathf.Lerp(iter_342_1.color.b, arg_339_1.hightColor1.b, (arg_339_1.time_ - 0) / var_342_0)))
							else
								local var_342_1 = Mathf.Lerp(iter_342_1.color.r, 1, (arg_339_1.time_ - 0) / var_342_0)

								iter_342_1.color = Color.New(var_342_1, var_342_1, var_342_1)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["10127"]) and arg_339_1.var_.actorSpriteComps10127 then
				for iter_342_2, iter_342_3 in pairs(arg_339_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_342_3 then
						iter_342_3.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_339_1.var_.actorSpriteComps10127 = nil
			end

			local var_342_2 = arg_339_1.actors_["1137"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_2) and arg_339_1.var_.actorSpriteComps1137 == nil then
				arg_339_1.var_.actorSpriteComps1137 = var_342_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_3 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_3 and not isNil(var_342_2) then
				if arg_339_1.var_.actorSpriteComps1137 then
					for iter_342_4, iter_342_5 in pairs(arg_339_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_342_5 then
							if arg_339_1.isInRecall_ then
								iter_342_5.color = Color.New(Mathf.Lerp(iter_342_5.color.r, arg_339_1.hightColor2.r, (arg_339_1.time_ - 0) / var_342_3), Mathf.Lerp(iter_342_5.color.g, arg_339_1.hightColor2.g, (arg_339_1.time_ - 0) / var_342_3), (Mathf.Lerp(iter_342_5.color.b, arg_339_1.hightColor2.b, (arg_339_1.time_ - 0) / var_342_3)))
							else
								local var_342_4 = Mathf.Lerp(iter_342_5.color.r, 0.5, (arg_339_1.time_ - 0) / var_342_3)

								iter_342_5.color = Color.New(var_342_4, var_342_4, var_342_4)
							end
						end
					end
				end
			end

			if arg_339_1.time_ >= 0 + var_342_3 and arg_339_1.time_ < 0 + var_342_3 + arg_342_0 and not isNil(var_342_2) and arg_339_1.var_.actorSpriteComps1137 then
				for iter_342_6, iter_342_7 in pairs(arg_339_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_342_7 then
						iter_342_7.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_339_1.var_.actorSpriteComps1137 = nil
			end

			local var_342_5 = arg_339_1.actors_["10127"].transform

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos10127 = var_342_5.localPosition
				var_342_5.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("10127", 2)

				for iter_342_8 = 0, var_342_5.childCount - 1 do
					local var_342_6 = var_342_5:GetChild(iter_342_8)

					if var_342_6.name == "split_6" then
						var_342_6:SetAsLastSibling()
						var_342_6.gameObject:SetActive(true)

						arg_339_1.var_.actorSpriteSplit10127 = var_342_6.gameObject:GetComponent(typeof(Image))

						arg_339_1.var_.actorSpriteSplit10127:SetAlpha(0)
					end
				end
			end

			local var_342_7 = 0.3

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_7 then
				var_342_5.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos10127, Vector3.New(-390, -387.4, -316.5), (arg_339_1.time_ - 0) / var_342_7)

				if arg_339_1.var_.actorSpriteSplit10127 ~= nil then
					arg_339_1.var_.actorSpriteSplit10127:SetAlpha((arg_339_1.time_ - 0) / var_342_7)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_7 and arg_339_1.time_ < 0 + var_342_7 + arg_342_0 then
				var_342_5.localPosition = Vector3.New(-390, -387.4, -316.5)

				if arg_339_1.var_.actorSpriteSplit10127 ~= nil then
					arg_339_1.var_.actorSpriteSplit10127:SetAlpha(1)
				end
			end

			local var_342_8 = 0
			local var_342_9 = 0.2

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_8 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_10 = arg_339_1:GetWordFromCfg(425042083)
				local var_342_11 = arg_339_1:FormatText(var_342_10.content)

				arg_339_1.text_.text = var_342_11

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_13 = 8 <= 0 and var_342_9 or var_342_9 * (utf8.len(var_342_11) / 8)

				if (8 <= 0 and var_342_9 or var_342_9 * (utf8.len(var_342_11) / 8)) > 0 and var_342_9 < var_342_13 then
					arg_339_1.talkMaxDuration = var_342_13

					if var_342_13 + var_342_8 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_13 + var_342_8
					end
				end

				arg_339_1.text_.text = var_342_11
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042083", "story_v_out_425042.awb") ~= 0 then
					local var_342_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042083", "story_v_out_425042.awb") / 1000

					if var_342_14 + var_342_8 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_14 + var_342_8
					end

					if var_342_10.prefab_name ~= "" and arg_339_1.actors_[var_342_10.prefab_name] ~= nil then
						local var_342_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_10.prefab_name].transform, "story_v_out_425042", "425042083", "story_v_out_425042.awb")

						arg_339_1:RecordAudio("425042083", var_342_15)
						arg_339_1:RecordAudio("425042083", var_342_15)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_425042", "425042083", "story_v_out_425042.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_425042", "425042083", "story_v_out_425042.awb")
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
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.3,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play425042084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 425042084
		arg_343_1.duration_ = 13.03

		local var_343_0 = {
			zh = 5.1,
			ja = 13.033
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
				arg_343_0:Play425042085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(arg_343_1.actors_["1137"]) and arg_343_1.var_.actorSpriteComps1137 == nil then
				arg_343_1.var_.actorSpriteComps1137 = arg_343_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_0 = 0.2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_0 and not isNil(arg_343_1.actors_["1137"]) then
				if arg_343_1.var_.actorSpriteComps1137 then
					for iter_346_0, iter_346_1 in pairs(arg_343_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_343_1.time_ >= 0 + var_346_0 and arg_343_1.time_ < 0 + var_346_0 + arg_346_0 and not isNil(arg_343_1.actors_["1137"]) and arg_343_1.var_.actorSpriteComps1137 then
				for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_346_3 then
						iter_346_3.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_343_1.var_.actorSpriteComps1137 = nil
			end

			local var_346_2 = arg_343_1.actors_["10127"]

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 and not isNil(var_346_2) and arg_343_1.var_.actorSpriteComps10127 == nil then
				arg_343_1.var_.actorSpriteComps10127 = var_346_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_3 = 0.2

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_3 and not isNil(var_346_2) then
				if arg_343_1.var_.actorSpriteComps10127 then
					for iter_346_4, iter_346_5 in pairs(arg_343_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_346_5 then
							if arg_343_1.isInRecall_ then
								iter_346_5.color = Color.New(Mathf.Lerp(iter_346_5.color.r, arg_343_1.hightColor2.r, (arg_343_1.time_ - 0) / var_346_3), Mathf.Lerp(iter_346_5.color.g, arg_343_1.hightColor2.g, (arg_343_1.time_ - 0) / var_346_3), (Mathf.Lerp(iter_346_5.color.b, arg_343_1.hightColor2.b, (arg_343_1.time_ - 0) / var_346_3)))
							else
								local var_346_4 = Mathf.Lerp(iter_346_5.color.r, 0.5, (arg_343_1.time_ - 0) / var_346_3)

								iter_346_5.color = Color.New(var_346_4, var_346_4, var_346_4)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 0 + var_346_3 and arg_343_1.time_ < 0 + var_346_3 + arg_346_0 and not isNil(var_346_2) and arg_343_1.var_.actorSpriteComps10127 then
				for iter_346_6, iter_346_7 in pairs(arg_343_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_346_7 then
						iter_346_7.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_343_1.var_.actorSpriteComps10127 = nil
			end

			local var_346_5 = arg_343_1.actors_["1137"].transform

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.var_.moveOldPos1137 = var_346_5.localPosition
				var_346_5.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("1137", 4)

				for iter_346_8 = 0, var_346_5.childCount - 1 do
					local var_346_6 = var_346_5:GetChild(iter_346_8)

					if var_346_6.name == "split_4" or not string.find(var_346_6.name, "split") then
						var_346_6.gameObject:SetActive(true)
					else
						var_346_6.gameObject:SetActive(false)
					end
				end
			end

			local var_346_7 = 0.001

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_7 then
				var_346_5.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_343_1.time_ - 0) / var_346_7)
			end

			if arg_343_1.time_ >= 0 + var_346_7 and arg_343_1.time_ < 0 + var_346_7 + arg_346_0 then
				var_346_5.localPosition = Vector3.New(390, -425, -200)
			end

			local var_346_8 = 0
			local var_346_9 = 0.6

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_8 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_10 = arg_343_1:GetWordFromCfg(425042084)
				local var_346_11 = arg_343_1:FormatText(var_346_10.content)

				arg_343_1.text_.text = var_346_11

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_13 = 25 <= 0 and var_346_9 or var_346_9 * (utf8.len(var_346_11) / 25)

				if (25 <= 0 and var_346_9 or var_346_9 * (utf8.len(var_346_11) / 25)) > 0 and var_346_9 < var_346_13 then
					arg_343_1.talkMaxDuration = var_346_13

					if var_346_13 + var_346_8 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_13 + var_346_8
					end
				end

				arg_343_1.text_.text = var_346_11
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042084", "story_v_out_425042.awb") ~= 0 then
					local var_346_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042084", "story_v_out_425042.awb") / 1000

					if var_346_14 + var_346_8 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_14 + var_346_8
					end

					if var_346_10.prefab_name ~= "" and arg_343_1.actors_[var_346_10.prefab_name] ~= nil then
						local var_346_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_10.prefab_name].transform, "story_v_out_425042", "425042084", "story_v_out_425042.awb")

						arg_343_1:RecordAudio("425042084", var_346_15)
						arg_343_1:RecordAudio("425042084", var_346_15)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_425042", "425042084", "story_v_out_425042.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_425042", "425042084", "story_v_out_425042.awb")
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
				actorName = "1137",
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
	Play425042085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 425042085
		arg_347_1.duration_ = 2.77

		local var_347_0 = {
			zh = 1,
			ja = 2.766
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
				arg_347_0:Play425042086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["10127"]) and arg_347_1.var_.actorSpriteComps10127 == nil then
				arg_347_1.var_.actorSpriteComps10127 = arg_347_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_0 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["10127"]) then
				if arg_347_1.var_.actorSpriteComps10127 then
					for iter_350_0, iter_350_1 in pairs(arg_347_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_350_1 then
							if arg_347_1.isInRecall_ then
								iter_350_1.color = Color.New(Mathf.Lerp(iter_350_1.color.r, arg_347_1.hightColor1.r, (arg_347_1.time_ - 0) / var_350_0), Mathf.Lerp(iter_350_1.color.g, arg_347_1.hightColor1.g, (arg_347_1.time_ - 0) / var_350_0), (Mathf.Lerp(iter_350_1.color.b, arg_347_1.hightColor1.b, (arg_347_1.time_ - 0) / var_350_0)))
							else
								local var_350_1 = Mathf.Lerp(iter_350_1.color.r, 1, (arg_347_1.time_ - 0) / var_350_0)

								iter_350_1.color = Color.New(var_350_1, var_350_1, var_350_1)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["10127"]) and arg_347_1.var_.actorSpriteComps10127 then
				for iter_350_2, iter_350_3 in pairs(arg_347_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_350_3 then
						iter_350_3.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_347_1.var_.actorSpriteComps10127 = nil
			end

			local var_350_2 = arg_347_1.actors_["1137"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.actorSpriteComps1137 == nil then
				arg_347_1.var_.actorSpriteComps1137 = var_350_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_350_3 = 0.2

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_3 and not isNil(var_350_2) then
				if arg_347_1.var_.actorSpriteComps1137 then
					for iter_350_4, iter_350_5 in pairs(arg_347_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_350_5 then
							if arg_347_1.isInRecall_ then
								iter_350_5.color = Color.New(Mathf.Lerp(iter_350_5.color.r, arg_347_1.hightColor2.r, (arg_347_1.time_ - 0) / var_350_3), Mathf.Lerp(iter_350_5.color.g, arg_347_1.hightColor2.g, (arg_347_1.time_ - 0) / var_350_3), (Mathf.Lerp(iter_350_5.color.b, arg_347_1.hightColor2.b, (arg_347_1.time_ - 0) / var_350_3)))
							else
								local var_350_4 = Mathf.Lerp(iter_350_5.color.r, 0.5, (arg_347_1.time_ - 0) / var_350_3)

								iter_350_5.color = Color.New(var_350_4, var_350_4, var_350_4)
							end
						end
					end
				end
			end

			if arg_347_1.time_ >= 0 + var_350_3 and arg_347_1.time_ < 0 + var_350_3 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.actorSpriteComps1137 then
				for iter_350_6, iter_350_7 in pairs(arg_347_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_350_7 then
						iter_350_7.color = arg_347_1.isInRecall_ and (arg_347_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_347_1.var_.actorSpriteComps1137 = nil
			end

			local var_350_5 = 0
			local var_350_6 = 0.075

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_5 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_7 = arg_347_1:GetWordFromCfg(425042085)
				local var_350_8 = arg_347_1:FormatText(var_350_7.content)

				arg_347_1.text_.text = var_350_8

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_10 = 3 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_8) / 3)

				if (3 <= 0 and var_350_6 or var_350_6 * (utf8.len(var_350_8) / 3)) > 0 and var_350_6 < var_350_10 then
					arg_347_1.talkMaxDuration = var_350_10

					if var_350_10 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_10 + var_350_5
					end
				end

				arg_347_1.text_.text = var_350_8
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042085", "story_v_out_425042.awb") ~= 0 then
					local var_350_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042085", "story_v_out_425042.awb") / 1000

					if var_350_11 + var_350_5 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_11 + var_350_5
					end

					if var_350_7.prefab_name ~= "" and arg_347_1.actors_[var_350_7.prefab_name] ~= nil then
						local var_350_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_7.prefab_name].transform, "story_v_out_425042", "425042085", "story_v_out_425042.awb")

						arg_347_1:RecordAudio("425042085", var_350_12)
						arg_347_1:RecordAudio("425042085", var_350_12)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_425042", "425042085", "story_v_out_425042.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_425042", "425042085", "story_v_out_425042.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_13 = math.max(var_350_6, arg_347_1.talkMaxDuration)

			if var_350_5 <= arg_347_1.time_ and arg_347_1.time_ < var_350_5 + var_350_13 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_5) / var_350_13

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_5 + var_350_13 and arg_347_1.time_ < var_350_5 + var_350_13 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play425042086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 425042086
		arg_351_1.duration_ = 2.07

		local var_351_0 = {
			zh = 2.066,
			ja = 1.733
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
				arg_351_0:Play425042087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["1137"]) and arg_351_1.var_.actorSpriteComps1137 == nil then
				arg_351_1.var_.actorSpriteComps1137 = arg_351_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_0 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["1137"]) then
				if arg_351_1.var_.actorSpriteComps1137 then
					for iter_354_0, iter_354_1 in pairs(arg_351_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_354_1 then
							if arg_351_1.isInRecall_ then
								iter_354_1.color = Color.New(Mathf.Lerp(iter_354_1.color.r, arg_351_1.hightColor1.r, (arg_351_1.time_ - 0) / var_354_0), Mathf.Lerp(iter_354_1.color.g, arg_351_1.hightColor1.g, (arg_351_1.time_ - 0) / var_354_0), (Mathf.Lerp(iter_354_1.color.b, arg_351_1.hightColor1.b, (arg_351_1.time_ - 0) / var_354_0)))
							else
								local var_354_1 = Mathf.Lerp(iter_354_1.color.r, 1, (arg_351_1.time_ - 0) / var_354_0)

								iter_354_1.color = Color.New(var_354_1, var_354_1, var_354_1)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["1137"]) and arg_351_1.var_.actorSpriteComps1137 then
				for iter_354_2, iter_354_3 in pairs(arg_351_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_354_3 then
						iter_354_3.color = arg_351_1.isInRecall_ and (arg_351_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_351_1.var_.actorSpriteComps1137 = nil
			end

			local var_354_2 = arg_351_1.actors_["10127"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_2) and arg_351_1.var_.actorSpriteComps10127 == nil then
				arg_351_1.var_.actorSpriteComps10127 = var_354_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_3 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_3 and not isNil(var_354_2) then
				if arg_351_1.var_.actorSpriteComps10127 then
					for iter_354_4, iter_354_5 in pairs(arg_351_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_354_5 then
							if arg_351_1.isInRecall_ then
								iter_354_5.color = Color.New(Mathf.Lerp(iter_354_5.color.r, arg_351_1.hightColor2.r, (arg_351_1.time_ - 0) / var_354_3), Mathf.Lerp(iter_354_5.color.g, arg_351_1.hightColor2.g, (arg_351_1.time_ - 0) / var_354_3), (Mathf.Lerp(iter_354_5.color.b, arg_351_1.hightColor2.b, (arg_351_1.time_ - 0) / var_354_3)))
							else
								local var_354_4 = Mathf.Lerp(iter_354_5.color.r, 0.5, (arg_351_1.time_ - 0) / var_354_3)

								iter_354_5.color = Color.New(var_354_4, var_354_4, var_354_4)
							end
						end
					end
				end
			end

			if arg_351_1.time_ >= 0 + var_354_3 and arg_351_1.time_ < 0 + var_354_3 + arg_354_0 and not isNil(var_354_2) and arg_351_1.var_.actorSpriteComps10127 then
				for iter_354_6, iter_354_7 in pairs(arg_351_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_354_7 then
						iter_354_7.color = arg_351_1.isInRecall_ and (arg_351_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_351_1.var_.actorSpriteComps10127 = nil
			end

			local var_354_5 = 0
			local var_354_6 = 0.05

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_5 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_7 = arg_351_1:GetWordFromCfg(425042086)
				local var_354_8 = arg_351_1:FormatText(var_354_7.content)

				arg_351_1.text_.text = var_354_8

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_10 = 2 <= 0 and var_354_6 or var_354_6 * (utf8.len(var_354_8) / 2)

				if (2 <= 0 and var_354_6 or var_354_6 * (utf8.len(var_354_8) / 2)) > 0 and var_354_6 < var_354_10 then
					arg_351_1.talkMaxDuration = var_354_10

					if var_354_10 + var_354_5 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_10 + var_354_5
					end
				end

				arg_351_1.text_.text = var_354_8
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042086", "story_v_out_425042.awb") ~= 0 then
					local var_354_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042086", "story_v_out_425042.awb") / 1000

					if var_354_11 + var_354_5 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_11 + var_354_5
					end

					if var_354_7.prefab_name ~= "" and arg_351_1.actors_[var_354_7.prefab_name] ~= nil then
						local var_354_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_7.prefab_name].transform, "story_v_out_425042", "425042086", "story_v_out_425042.awb")

						arg_351_1:RecordAudio("425042086", var_354_12)
						arg_351_1:RecordAudio("425042086", var_354_12)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_425042", "425042086", "story_v_out_425042.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_425042", "425042086", "story_v_out_425042.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_13 = math.max(var_354_6, arg_351_1.talkMaxDuration)

			if var_354_5 <= arg_351_1.time_ and arg_351_1.time_ < var_354_5 + var_354_13 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_5) / var_354_13

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_5 + var_354_13 and arg_351_1.time_ < var_354_5 + var_354_13 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play425042087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 425042087
		arg_355_1.duration_ = 9.77

		local var_355_0 = {
			zh = 8.2,
			ja = 9.766
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
				arg_355_0:Play425042088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["10127"]) and arg_355_1.var_.actorSpriteComps10127 == nil then
				arg_355_1.var_.actorSpriteComps10127 = arg_355_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_0 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["10127"]) then
				if arg_355_1.var_.actorSpriteComps10127 then
					for iter_358_0, iter_358_1 in pairs(arg_355_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_358_1 then
							if arg_355_1.isInRecall_ then
								iter_358_1.color = Color.New(Mathf.Lerp(iter_358_1.color.r, arg_355_1.hightColor1.r, (arg_355_1.time_ - 0) / var_358_0), Mathf.Lerp(iter_358_1.color.g, arg_355_1.hightColor1.g, (arg_355_1.time_ - 0) / var_358_0), (Mathf.Lerp(iter_358_1.color.b, arg_355_1.hightColor1.b, (arg_355_1.time_ - 0) / var_358_0)))
							else
								local var_358_1 = Mathf.Lerp(iter_358_1.color.r, 1, (arg_355_1.time_ - 0) / var_358_0)

								iter_358_1.color = Color.New(var_358_1, var_358_1, var_358_1)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["10127"]) and arg_355_1.var_.actorSpriteComps10127 then
				for iter_358_2, iter_358_3 in pairs(arg_355_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_358_3 then
						iter_358_3.color = arg_355_1.isInRecall_ and (arg_355_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_355_1.var_.actorSpriteComps10127 = nil
			end

			local var_358_2 = arg_355_1.actors_["1137"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_2) and arg_355_1.var_.actorSpriteComps1137 == nil then
				arg_355_1.var_.actorSpriteComps1137 = var_358_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_3 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_3 and not isNil(var_358_2) then
				if arg_355_1.var_.actorSpriteComps1137 then
					for iter_358_4, iter_358_5 in pairs(arg_355_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_358_5 then
							if arg_355_1.isInRecall_ then
								iter_358_5.color = Color.New(Mathf.Lerp(iter_358_5.color.r, arg_355_1.hightColor2.r, (arg_355_1.time_ - 0) / var_358_3), Mathf.Lerp(iter_358_5.color.g, arg_355_1.hightColor2.g, (arg_355_1.time_ - 0) / var_358_3), (Mathf.Lerp(iter_358_5.color.b, arg_355_1.hightColor2.b, (arg_355_1.time_ - 0) / var_358_3)))
							else
								local var_358_4 = Mathf.Lerp(iter_358_5.color.r, 0.5, (arg_355_1.time_ - 0) / var_358_3)

								iter_358_5.color = Color.New(var_358_4, var_358_4, var_358_4)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= 0 + var_358_3 and arg_355_1.time_ < 0 + var_358_3 + arg_358_0 and not isNil(var_358_2) and arg_355_1.var_.actorSpriteComps1137 then
				for iter_358_6, iter_358_7 in pairs(arg_355_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_358_7 then
						iter_358_7.color = arg_355_1.isInRecall_ and (arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_355_1.var_.actorSpriteComps1137 = nil
			end

			local var_358_5 = 0
			local var_358_6 = 1

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_5 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_7 = arg_355_1:GetWordFromCfg(425042087)
				local var_358_8 = arg_355_1:FormatText(var_358_7.content)

				arg_355_1.text_.text = var_358_8

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_10 = 40 <= 0 and var_358_6 or var_358_6 * (utf8.len(var_358_8) / 40)

				if (40 <= 0 and var_358_6 or var_358_6 * (utf8.len(var_358_8) / 40)) > 0 and var_358_6 < var_358_10 then
					arg_355_1.talkMaxDuration = var_358_10

					if var_358_10 + var_358_5 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_10 + var_358_5
					end
				end

				arg_355_1.text_.text = var_358_8
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042087", "story_v_out_425042.awb") ~= 0 then
					local var_358_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042087", "story_v_out_425042.awb") / 1000

					if var_358_11 + var_358_5 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_11 + var_358_5
					end

					if var_358_7.prefab_name ~= "" and arg_355_1.actors_[var_358_7.prefab_name] ~= nil then
						local var_358_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_7.prefab_name].transform, "story_v_out_425042", "425042087", "story_v_out_425042.awb")

						arg_355_1:RecordAudio("425042087", var_358_12)
						arg_355_1:RecordAudio("425042087", var_358_12)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_425042", "425042087", "story_v_out_425042.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_425042", "425042087", "story_v_out_425042.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_13 = math.max(var_358_6, arg_355_1.talkMaxDuration)

			if var_358_5 <= arg_355_1.time_ and arg_355_1.time_ < var_358_5 + var_358_13 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_5) / var_358_13

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_5 + var_358_13 and arg_355_1.time_ < var_358_5 + var_358_13 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play425042088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 425042088
		arg_359_1.duration_ = 8.4

		local var_359_0 = {
			zh = 6.533,
			ja = 8.4
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
				arg_359_0:Play425042089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0.725

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_1 = arg_359_1:GetWordFromCfg(425042088)
				local var_362_2 = arg_359_1:FormatText(var_362_1.content)

				arg_359_1.text_.text = var_362_2

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_4 = 29 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 29)

				if (29 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 29)) > 0 and var_362_0 < var_362_4 then
					arg_359_1.talkMaxDuration = var_362_4

					if var_362_4 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_4 + 0
					end
				end

				arg_359_1.text_.text = var_362_2
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042088", "story_v_out_425042.awb") ~= 0 then
					local var_362_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042088", "story_v_out_425042.awb") / 1000

					if var_362_5 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + 0
					end

					if var_362_1.prefab_name ~= "" and arg_359_1.actors_[var_362_1.prefab_name] ~= nil then
						local var_362_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_1.prefab_name].transform, "story_v_out_425042", "425042088", "story_v_out_425042.awb")

						arg_359_1:RecordAudio("425042088", var_362_6)
						arg_359_1:RecordAudio("425042088", var_362_6)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_425042", "425042088", "story_v_out_425042.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_425042", "425042088", "story_v_out_425042.awb")
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
	Play425042089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 425042089
		arg_363_1.duration_ = 3.2

		local var_363_0 = {
			zh = 3.2,
			ja = 1.7
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
				arg_363_0:Play425042090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["1137"]) and arg_363_1.var_.actorSpriteComps1137 == nil then
				arg_363_1.var_.actorSpriteComps1137 = arg_363_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_0 = 0.2

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["1137"]) then
				if arg_363_1.var_.actorSpriteComps1137 then
					for iter_366_0, iter_366_1 in pairs(arg_363_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_366_1 then
							if arg_363_1.isInRecall_ then
								iter_366_1.color = Color.New(Mathf.Lerp(iter_366_1.color.r, arg_363_1.hightColor1.r, (arg_363_1.time_ - 0) / var_366_0), Mathf.Lerp(iter_366_1.color.g, arg_363_1.hightColor1.g, (arg_363_1.time_ - 0) / var_366_0), (Mathf.Lerp(iter_366_1.color.b, arg_363_1.hightColor1.b, (arg_363_1.time_ - 0) / var_366_0)))
							else
								local var_366_1 = Mathf.Lerp(iter_366_1.color.r, 1, (arg_363_1.time_ - 0) / var_366_0)

								iter_366_1.color = Color.New(var_366_1, var_366_1, var_366_1)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["1137"]) and arg_363_1.var_.actorSpriteComps1137 then
				for iter_366_2, iter_366_3 in pairs(arg_363_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_366_3 then
						iter_366_3.color = arg_363_1.isInRecall_ and (arg_363_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_363_1.var_.actorSpriteComps1137 = nil
			end

			local var_366_2 = arg_363_1.actors_["10127"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_2) and arg_363_1.var_.actorSpriteComps10127 == nil then
				arg_363_1.var_.actorSpriteComps10127 = var_366_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_3 = 0.2

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_3 and not isNil(var_366_2) then
				if arg_363_1.var_.actorSpriteComps10127 then
					for iter_366_4, iter_366_5 in pairs(arg_363_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_366_5 then
							if arg_363_1.isInRecall_ then
								iter_366_5.color = Color.New(Mathf.Lerp(iter_366_5.color.r, arg_363_1.hightColor2.r, (arg_363_1.time_ - 0) / var_366_3), Mathf.Lerp(iter_366_5.color.g, arg_363_1.hightColor2.g, (arg_363_1.time_ - 0) / var_366_3), (Mathf.Lerp(iter_366_5.color.b, arg_363_1.hightColor2.b, (arg_363_1.time_ - 0) / var_366_3)))
							else
								local var_366_4 = Mathf.Lerp(iter_366_5.color.r, 0.5, (arg_363_1.time_ - 0) / var_366_3)

								iter_366_5.color = Color.New(var_366_4, var_366_4, var_366_4)
							end
						end
					end
				end
			end

			if arg_363_1.time_ >= 0 + var_366_3 and arg_363_1.time_ < 0 + var_366_3 + arg_366_0 and not isNil(var_366_2) and arg_363_1.var_.actorSpriteComps10127 then
				for iter_366_6, iter_366_7 in pairs(arg_363_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_366_7 then
						iter_366_7.color = arg_363_1.isInRecall_ and (arg_363_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_363_1.var_.actorSpriteComps10127 = nil
			end

			local var_366_5 = arg_363_1.actors_["1137"].transform

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.var_.moveOldPos1137 = var_366_5.localPosition
				var_366_5.localScale = Vector3.New(1, 1, 1)

				arg_363_1:CheckSpriteTmpPos("1137", 4)

				for iter_366_8 = 0, var_366_5.childCount - 1 do
					local var_366_6 = var_366_5:GetChild(iter_366_8)

					if var_366_6.name == "split_4" or not string.find(var_366_6.name, "split") then
						var_366_6.gameObject:SetActive(true)
					else
						var_366_6.gameObject:SetActive(false)
					end
				end
			end

			local var_366_7 = 0.001

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_7 then
				var_366_5.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_363_1.time_ - 0) / var_366_7)
			end

			if arg_363_1.time_ >= 0 + var_366_7 and arg_363_1.time_ < 0 + var_366_7 + arg_366_0 then
				var_366_5.localPosition = Vector3.New(390, -425, -200)
			end

			local var_366_8 = 0
			local var_366_9 = 0.175

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_8 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_10 = arg_363_1:GetWordFromCfg(425042089)
				local var_366_11 = arg_363_1:FormatText(var_366_10.content)

				arg_363_1.text_.text = var_366_11

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_13 = 7 <= 0 and var_366_9 or var_366_9 * (utf8.len(var_366_11) / 7)

				if (7 <= 0 and var_366_9 or var_366_9 * (utf8.len(var_366_11) / 7)) > 0 and var_366_9 < var_366_13 then
					arg_363_1.talkMaxDuration = var_366_13

					if var_366_13 + var_366_8 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_13 + var_366_8
					end
				end

				arg_363_1.text_.text = var_366_11
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042089", "story_v_out_425042.awb") ~= 0 then
					local var_366_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042089", "story_v_out_425042.awb") / 1000

					if var_366_14 + var_366_8 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_14 + var_366_8
					end

					if var_366_10.prefab_name ~= "" and arg_363_1.actors_[var_366_10.prefab_name] ~= nil then
						local var_366_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_10.prefab_name].transform, "story_v_out_425042", "425042089", "story_v_out_425042.awb")

						arg_363_1:RecordAudio("425042089", var_366_15)
						arg_363_1:RecordAudio("425042089", var_366_15)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_425042", "425042089", "story_v_out_425042.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_425042", "425042089", "story_v_out_425042.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_16 = math.max(var_366_9, arg_363_1.talkMaxDuration)

			if var_366_8 <= arg_363_1.time_ and arg_363_1.time_ < var_366_8 + var_366_16 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_8) / var_366_16

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_8 + var_366_16 and arg_363_1.time_ < var_366_8 + var_366_16 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
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
	Play425042090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 425042090
		arg_367_1.duration_ = 16.7

		local var_367_0 = {
			zh = 12.9,
			ja = 16.7
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
				arg_367_0:Play425042091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["10127"]) and arg_367_1.var_.actorSpriteComps10127 == nil then
				arg_367_1.var_.actorSpriteComps10127 = arg_367_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_0 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["10127"]) then
				if arg_367_1.var_.actorSpriteComps10127 then
					for iter_370_0, iter_370_1 in pairs(arg_367_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_370_1 then
							if arg_367_1.isInRecall_ then
								iter_370_1.color = Color.New(Mathf.Lerp(iter_370_1.color.r, arg_367_1.hightColor1.r, (arg_367_1.time_ - 0) / var_370_0), Mathf.Lerp(iter_370_1.color.g, arg_367_1.hightColor1.g, (arg_367_1.time_ - 0) / var_370_0), (Mathf.Lerp(iter_370_1.color.b, arg_367_1.hightColor1.b, (arg_367_1.time_ - 0) / var_370_0)))
							else
								local var_370_1 = Mathf.Lerp(iter_370_1.color.r, 1, (arg_367_1.time_ - 0) / var_370_0)

								iter_370_1.color = Color.New(var_370_1, var_370_1, var_370_1)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["10127"]) and arg_367_1.var_.actorSpriteComps10127 then
				for iter_370_2, iter_370_3 in pairs(arg_367_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_370_3 then
						iter_370_3.color = arg_367_1.isInRecall_ and (arg_367_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_367_1.var_.actorSpriteComps10127 = nil
			end

			local var_370_2 = arg_367_1.actors_["1137"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_2) and arg_367_1.var_.actorSpriteComps1137 == nil then
				arg_367_1.var_.actorSpriteComps1137 = var_370_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_3 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_3 and not isNil(var_370_2) then
				if arg_367_1.var_.actorSpriteComps1137 then
					for iter_370_4, iter_370_5 in pairs(arg_367_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_370_5 then
							if arg_367_1.isInRecall_ then
								iter_370_5.color = Color.New(Mathf.Lerp(iter_370_5.color.r, arg_367_1.hightColor2.r, (arg_367_1.time_ - 0) / var_370_3), Mathf.Lerp(iter_370_5.color.g, arg_367_1.hightColor2.g, (arg_367_1.time_ - 0) / var_370_3), (Mathf.Lerp(iter_370_5.color.b, arg_367_1.hightColor2.b, (arg_367_1.time_ - 0) / var_370_3)))
							else
								local var_370_4 = Mathf.Lerp(iter_370_5.color.r, 0.5, (arg_367_1.time_ - 0) / var_370_3)

								iter_370_5.color = Color.New(var_370_4, var_370_4, var_370_4)
							end
						end
					end
				end
			end

			if arg_367_1.time_ >= 0 + var_370_3 and arg_367_1.time_ < 0 + var_370_3 + arg_370_0 and not isNil(var_370_2) and arg_367_1.var_.actorSpriteComps1137 then
				for iter_370_6, iter_370_7 in pairs(arg_367_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_370_7 then
						iter_370_7.color = arg_367_1.isInRecall_ and (arg_367_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_367_1.var_.actorSpriteComps1137 = nil
			end

			local var_370_5 = arg_367_1.actors_["10127"].transform

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.var_.moveOldPos10127 = var_370_5.localPosition
				var_370_5.localScale = Vector3.New(1, 1, 1)

				arg_367_1:CheckSpriteTmpPos("10127", 2)

				for iter_370_8 = 0, var_370_5.childCount - 1 do
					local var_370_6 = var_370_5:GetChild(iter_370_8)

					if var_370_6.name == "split_6" or not string.find(var_370_6.name, "split") then
						var_370_6.gameObject:SetActive(true)
					else
						var_370_6.gameObject:SetActive(false)
					end
				end
			end

			local var_370_7 = 0.001

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_7 then
				var_370_5.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10127, Vector3.New(-390, -387.4, -316.5), (arg_367_1.time_ - 0) / var_370_7)
			end

			if arg_367_1.time_ >= 0 + var_370_7 and arg_367_1.time_ < 0 + var_370_7 + arg_370_0 then
				var_370_5.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_370_8 = 0
			local var_370_9 = 1.55

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_8 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_10 = arg_367_1:GetWordFromCfg(425042090)
				local var_370_11 = arg_367_1:FormatText(var_370_10.content)

				arg_367_1.text_.text = var_370_11

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_13 = 62 <= 0 and var_370_9 or var_370_9 * (utf8.len(var_370_11) / 62)

				if (62 <= 0 and var_370_9 or var_370_9 * (utf8.len(var_370_11) / 62)) > 0 and var_370_9 < var_370_13 then
					arg_367_1.talkMaxDuration = var_370_13

					if var_370_13 + var_370_8 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_13 + var_370_8
					end
				end

				arg_367_1.text_.text = var_370_11
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042090", "story_v_out_425042.awb") ~= 0 then
					local var_370_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042090", "story_v_out_425042.awb") / 1000

					if var_370_14 + var_370_8 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_14 + var_370_8
					end

					if var_370_10.prefab_name ~= "" and arg_367_1.actors_[var_370_10.prefab_name] ~= nil then
						local var_370_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_10.prefab_name].transform, "story_v_out_425042", "425042090", "story_v_out_425042.awb")

						arg_367_1:RecordAudio("425042090", var_370_15)
						arg_367_1:RecordAudio("425042090", var_370_15)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_425042", "425042090", "story_v_out_425042.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_425042", "425042090", "story_v_out_425042.awb")
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
				actorName = "10127",
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
	Play425042091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 425042091
		arg_371_1.duration_ = 14.23

		local var_371_0 = {
			zh = 9.533,
			ja = 14.233
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
				arg_371_0:Play425042092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 1.275

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_1 = arg_371_1:GetWordFromCfg(425042091)
				local var_374_2 = arg_371_1:FormatText(var_374_1.content)

				arg_371_1.text_.text = var_374_2

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_4 = 51 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 51)

				if (51 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_2) / 51)) > 0 and var_374_0 < var_374_4 then
					arg_371_1.talkMaxDuration = var_374_4

					if var_374_4 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_4 + 0
					end
				end

				arg_371_1.text_.text = var_374_2
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042091", "story_v_out_425042.awb") ~= 0 then
					local var_374_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042091", "story_v_out_425042.awb") / 1000

					if var_374_5 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_5 + 0
					end

					if var_374_1.prefab_name ~= "" and arg_371_1.actors_[var_374_1.prefab_name] ~= nil then
						local var_374_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_1.prefab_name].transform, "story_v_out_425042", "425042091", "story_v_out_425042.awb")

						arg_371_1:RecordAudio("425042091", var_374_6)
						arg_371_1:RecordAudio("425042091", var_374_6)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_425042", "425042091", "story_v_out_425042.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_425042", "425042091", "story_v_out_425042.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_7 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_7 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_7

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_7 and arg_371_1.time_ < 0 + var_374_7 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play425042092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 425042092
		arg_375_1.duration_ = 3.67

		local var_375_0 = {
			zh = 1.366,
			ja = 3.666
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
				arg_375_0:Play425042093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(arg_375_1.actors_["1137"]) and arg_375_1.var_.actorSpriteComps1137 == nil then
				arg_375_1.var_.actorSpriteComps1137 = arg_375_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_0 = 0.2

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 and not isNil(arg_375_1.actors_["1137"]) then
				if arg_375_1.var_.actorSpriteComps1137 then
					for iter_378_0, iter_378_1 in pairs(arg_375_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_378_1 then
							if arg_375_1.isInRecall_ then
								iter_378_1.color = Color.New(Mathf.Lerp(iter_378_1.color.r, arg_375_1.hightColor1.r, (arg_375_1.time_ - 0) / var_378_0), Mathf.Lerp(iter_378_1.color.g, arg_375_1.hightColor1.g, (arg_375_1.time_ - 0) / var_378_0), (Mathf.Lerp(iter_378_1.color.b, arg_375_1.hightColor1.b, (arg_375_1.time_ - 0) / var_378_0)))
							else
								local var_378_1 = Mathf.Lerp(iter_378_1.color.r, 1, (arg_375_1.time_ - 0) / var_378_0)

								iter_378_1.color = Color.New(var_378_1, var_378_1, var_378_1)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 and not isNil(arg_375_1.actors_["1137"]) and arg_375_1.var_.actorSpriteComps1137 then
				for iter_378_2, iter_378_3 in pairs(arg_375_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_378_3 then
						iter_378_3.color = arg_375_1.isInRecall_ and (arg_375_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_375_1.var_.actorSpriteComps1137 = nil
			end

			local var_378_2 = arg_375_1.actors_["10127"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_2) and arg_375_1.var_.actorSpriteComps10127 == nil then
				arg_375_1.var_.actorSpriteComps10127 = var_378_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_378_3 = 0.2

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_3 and not isNil(var_378_2) then
				if arg_375_1.var_.actorSpriteComps10127 then
					for iter_378_4, iter_378_5 in pairs(arg_375_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_378_5 then
							if arg_375_1.isInRecall_ then
								iter_378_5.color = Color.New(Mathf.Lerp(iter_378_5.color.r, arg_375_1.hightColor2.r, (arg_375_1.time_ - 0) / var_378_3), Mathf.Lerp(iter_378_5.color.g, arg_375_1.hightColor2.g, (arg_375_1.time_ - 0) / var_378_3), (Mathf.Lerp(iter_378_5.color.b, arg_375_1.hightColor2.b, (arg_375_1.time_ - 0) / var_378_3)))
							else
								local var_378_4 = Mathf.Lerp(iter_378_5.color.r, 0.5, (arg_375_1.time_ - 0) / var_378_3)

								iter_378_5.color = Color.New(var_378_4, var_378_4, var_378_4)
							end
						end
					end
				end
			end

			if arg_375_1.time_ >= 0 + var_378_3 and arg_375_1.time_ < 0 + var_378_3 + arg_378_0 and not isNil(var_378_2) and arg_375_1.var_.actorSpriteComps10127 then
				for iter_378_6, iter_378_7 in pairs(arg_375_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_378_7 then
						iter_378_7.color = arg_375_1.isInRecall_ and (arg_375_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_375_1.var_.actorSpriteComps10127 = nil
			end

			local var_378_5 = arg_375_1.actors_["1137"].transform

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.var_.moveOldPos1137 = var_378_5.localPosition
				var_378_5.localScale = Vector3.New(1, 1, 1)

				arg_375_1:CheckSpriteTmpPos("1137", 4)

				for iter_378_8 = 0, var_378_5.childCount - 1 do
					local var_378_6 = var_378_5:GetChild(iter_378_8)

					if var_378_6.name == "" then
						var_378_6:SetAsLastSibling()
						var_378_6.gameObject:SetActive(true)

						arg_375_1.var_.actorSpriteSplit1137 = var_378_6.gameObject:GetComponent(typeof(Image))

						arg_375_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_378_7 = 0.1

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_7 then
				var_378_5.localPosition = Vector3.Lerp(arg_375_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_375_1.time_ - 0) / var_378_7)

				if arg_375_1.var_.actorSpriteSplit1137 ~= nil then
					arg_375_1.var_.actorSpriteSplit1137:SetAlpha((arg_375_1.time_ - 0) / var_378_7)
				end
			end

			if arg_375_1.time_ >= 0 + var_378_7 and arg_375_1.time_ < 0 + var_378_7 + arg_378_0 then
				var_378_5.localPosition = Vector3.New(390, -425, -200)

				if arg_375_1.var_.actorSpriteSplit1137 ~= nil then
					arg_375_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_378_8 = 0
			local var_378_9 = 0.125

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_8 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_10 = arg_375_1:GetWordFromCfg(425042092)
				local var_378_11 = arg_375_1:FormatText(var_378_10.content)

				arg_375_1.text_.text = var_378_11

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_13 = 5 <= 0 and var_378_9 or var_378_9 * (utf8.len(var_378_11) / 5)

				if (5 <= 0 and var_378_9 or var_378_9 * (utf8.len(var_378_11) / 5)) > 0 and var_378_9 < var_378_13 then
					arg_375_1.talkMaxDuration = var_378_13

					if var_378_13 + var_378_8 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_13 + var_378_8
					end
				end

				arg_375_1.text_.text = var_378_11
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042092", "story_v_out_425042.awb") ~= 0 then
					local var_378_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042092", "story_v_out_425042.awb") / 1000

					if var_378_14 + var_378_8 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_14 + var_378_8
					end

					if var_378_10.prefab_name ~= "" and arg_375_1.actors_[var_378_10.prefab_name] ~= nil then
						local var_378_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_10.prefab_name].transform, "story_v_out_425042", "425042092", "story_v_out_425042.awb")

						arg_375_1:RecordAudio("425042092", var_378_15)
						arg_375_1:RecordAudio("425042092", var_378_15)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_425042", "425042092", "story_v_out_425042.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_425042", "425042092", "story_v_out_425042.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_16 = math.max(var_378_9, arg_375_1.talkMaxDuration)

			if var_378_8 <= arg_375_1.time_ and arg_375_1.time_ < var_378_8 + var_378_16 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_8) / var_378_16

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_8 + var_378_16 and arg_375_1.time_ < var_378_8 + var_378_16 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play425042093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 425042093
		arg_379_1.duration_ = 5

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play425042094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos1137 = arg_379_1.actors_["1137"].transform.localPosition
				arg_379_1.actors_["1137"].transform.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("1137", 7)

				for iter_382_0 = 0, arg_379_1.actors_["1137"].transform.childCount - 1 do
					local var_382_0 = arg_379_1.actors_["1137"].transform:GetChild(iter_382_0)

					if var_382_0.name == "" or not string.find(var_382_0.name, "split") then
						var_382_0.gameObject:SetActive(true)
					else
						var_382_0.gameObject:SetActive(false)
					end
				end
			end

			local var_382_1 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_1 then
				arg_379_1.actors_["1137"].transform.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_379_1.time_ - 0) / var_382_1)
			end

			if arg_379_1.time_ >= 0 + var_382_1 and arg_379_1.time_ < 0 + var_382_1 + arg_382_0 then
				arg_379_1.actors_["1137"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_382_2 = arg_379_1.actors_["10127"].transform

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.var_.moveOldPos10127 = var_382_2.localPosition
				var_382_2.localScale = Vector3.New(1, 1, 1)

				arg_379_1:CheckSpriteTmpPos("10127", 7)

				for iter_382_1 = 0, var_382_2.childCount - 1 do
					local var_382_3 = var_382_2:GetChild(iter_382_1)

					if var_382_3.name == "" or not string.find(var_382_3.name, "split") then
						var_382_3.gameObject:SetActive(true)
					else
						var_382_3.gameObject:SetActive(false)
					end
				end
			end

			local var_382_4 = 0.001

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_4 then
				var_382_2.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos10127, Vector3.New(0, -2000, 0), (arg_379_1.time_ - 0) / var_382_4)
			end

			if arg_379_1.time_ >= 0 + var_382_4 and arg_379_1.time_ < 0 + var_382_4 + arg_382_0 then
				var_382_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_382_5 = 0
			local var_382_6 = 0.45

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_5 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_7 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(425042093).content)

				arg_379_1.text_.text = var_382_7

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_9 = 18 <= 0 and var_382_6 or var_382_6 * (utf8.len(var_382_7) / 18)

				if (18 <= 0 and var_382_6 or var_382_6 * (utf8.len(var_382_7) / 18)) > 0 and var_382_6 < var_382_9 then
					arg_379_1.talkMaxDuration = var_382_9

					if var_382_9 + var_382_5 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_9 + var_382_5
					end
				end

				arg_379_1.text_.text = var_382_7
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_10 = math.max(var_382_6, arg_379_1.talkMaxDuration)

			if var_382_5 <= arg_379_1.time_ and arg_379_1.time_ < var_382_5 + var_382_10 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_5) / var_382_10

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_5 + var_382_10 and arg_379_1.time_ < var_382_5 + var_382_10 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10127",
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
	Play425042094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 425042094
		arg_383_1.duration_ = 5.53

		local var_383_0 = {
			zh = 2.7,
			ja = 5.533
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
				arg_383_0:Play425042095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 and not isNil(arg_383_1.actors_["1137"]) and arg_383_1.var_.actorSpriteComps1137 == nil then
				arg_383_1.var_.actorSpriteComps1137 = arg_383_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_386_0 = 0.2

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_0 and not isNil(arg_383_1.actors_["1137"]) then
				if arg_383_1.var_.actorSpriteComps1137 then
					for iter_386_0, iter_386_1 in pairs(arg_383_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_386_1 then
							if arg_383_1.isInRecall_ then
								iter_386_1.color = Color.New(Mathf.Lerp(iter_386_1.color.r, arg_383_1.hightColor1.r, (arg_383_1.time_ - 0) / var_386_0), Mathf.Lerp(iter_386_1.color.g, arg_383_1.hightColor1.g, (arg_383_1.time_ - 0) / var_386_0), (Mathf.Lerp(iter_386_1.color.b, arg_383_1.hightColor1.b, (arg_383_1.time_ - 0) / var_386_0)))
							else
								local var_386_1 = Mathf.Lerp(iter_386_1.color.r, 1, (arg_383_1.time_ - 0) / var_386_0)

								iter_386_1.color = Color.New(var_386_1, var_386_1, var_386_1)
							end
						end
					end
				end
			end

			if arg_383_1.time_ >= 0 + var_386_0 and arg_383_1.time_ < 0 + var_386_0 + arg_386_0 and not isNil(arg_383_1.actors_["1137"]) and arg_383_1.var_.actorSpriteComps1137 then
				for iter_386_2, iter_386_3 in pairs(arg_383_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_386_3 then
						iter_386_3.color = arg_383_1.isInRecall_ and (arg_383_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_383_1.var_.actorSpriteComps1137 = nil
			end

			local var_386_2 = arg_383_1.actors_["1137"].transform

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				arg_383_1.var_.moveOldPos1137 = var_386_2.localPosition
				var_386_2.localScale = Vector3.New(1, 1, 1)

				arg_383_1:CheckSpriteTmpPos("1137", 4)

				for iter_386_4 = 0, var_386_2.childCount - 1 do
					local var_386_3 = var_386_2:GetChild(iter_386_4)

					if var_386_3.name == "split_4" or not string.find(var_386_3.name, "split") then
						var_386_3.gameObject:SetActive(true)
					else
						var_386_3.gameObject:SetActive(false)
					end
				end
			end

			local var_386_4 = 0.001

			if 0 <= arg_383_1.time_ and arg_383_1.time_ < 0 + var_386_4 then
				var_386_2.localPosition = Vector3.Lerp(arg_383_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_383_1.time_ - 0) / var_386_4)
			end

			if arg_383_1.time_ >= 0 + var_386_4 and arg_383_1.time_ < 0 + var_386_4 + arg_386_0 then
				var_386_2.localPosition = Vector3.New(390, -425, -200)
			end

			local var_386_5 = 0
			local var_386_6 = 0.35

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_5 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_7 = arg_383_1:GetWordFromCfg(425042094)
				local var_386_8 = arg_383_1:FormatText(var_386_7.content)

				arg_383_1.text_.text = var_386_8

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_10 = 14 <= 0 and var_386_6 or var_386_6 * (utf8.len(var_386_8) / 14)

				if (14 <= 0 and var_386_6 or var_386_6 * (utf8.len(var_386_8) / 14)) > 0 and var_386_6 < var_386_10 then
					arg_383_1.talkMaxDuration = var_386_10

					if var_386_10 + var_386_5 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_10 + var_386_5
					end
				end

				arg_383_1.text_.text = var_386_8
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042094", "story_v_out_425042.awb") ~= 0 then
					local var_386_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042094", "story_v_out_425042.awb") / 1000

					if var_386_11 + var_386_5 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_11 + var_386_5
					end

					if var_386_7.prefab_name ~= "" and arg_383_1.actors_[var_386_7.prefab_name] ~= nil then
						local var_386_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_7.prefab_name].transform, "story_v_out_425042", "425042094", "story_v_out_425042.awb")

						arg_383_1:RecordAudio("425042094", var_386_12)
						arg_383_1:RecordAudio("425042094", var_386_12)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_425042", "425042094", "story_v_out_425042.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_425042", "425042094", "story_v_out_425042.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_13 = math.max(var_386_6, arg_383_1.talkMaxDuration)

			if var_386_5 <= arg_383_1.time_ and arg_383_1.time_ < var_386_5 + var_386_13 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_5) / var_386_13

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_5 + var_386_13 and arg_383_1.time_ < var_386_5 + var_386_13 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
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
	Play425042095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 425042095
		arg_387_1.duration_ = 5.47

		local var_387_0 = {
			zh = 3.8,
			ja = 5.466
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
				arg_387_0:Play425042096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(arg_387_1.actors_["10127"]) and arg_387_1.var_.actorSpriteComps10127 == nil then
				arg_387_1.var_.actorSpriteComps10127 = arg_387_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_390_0 = 0.2

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_0 and not isNil(arg_387_1.actors_["10127"]) then
				if arg_387_1.var_.actorSpriteComps10127 then
					for iter_390_0, iter_390_1 in pairs(arg_387_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_387_1.time_ >= 0 + var_390_0 and arg_387_1.time_ < 0 + var_390_0 + arg_390_0 and not isNil(arg_387_1.actors_["10127"]) and arg_387_1.var_.actorSpriteComps10127 then
				for iter_390_2, iter_390_3 in pairs(arg_387_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_390_3 then
						iter_390_3.color = arg_387_1.isInRecall_ and (arg_387_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_387_1.var_.actorSpriteComps10127 = nil
			end

			local var_390_2 = arg_387_1.actors_["1137"]

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 and not isNil(var_390_2) and arg_387_1.var_.actorSpriteComps1137 == nil then
				arg_387_1.var_.actorSpriteComps1137 = var_390_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_390_3 = 0.2

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_3 and not isNil(var_390_2) then
				if arg_387_1.var_.actorSpriteComps1137 then
					for iter_390_4, iter_390_5 in pairs(arg_387_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_387_1.time_ >= 0 + var_390_3 and arg_387_1.time_ < 0 + var_390_3 + arg_390_0 and not isNil(var_390_2) and arg_387_1.var_.actorSpriteComps1137 then
				for iter_390_6, iter_390_7 in pairs(arg_387_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_390_7 then
						iter_390_7.color = arg_387_1.isInRecall_ and (arg_387_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_387_1.var_.actorSpriteComps1137 = nil
			end

			local var_390_5 = arg_387_1.actors_["10127"].transform

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= 0 + arg_390_0 then
				arg_387_1.var_.moveOldPos10127 = var_390_5.localPosition
				var_390_5.localScale = Vector3.New(1, 1, 1)

				arg_387_1:CheckSpriteTmpPos("10127", 2)

				for iter_390_8 = 0, var_390_5.childCount - 1 do
					local var_390_6 = var_390_5:GetChild(iter_390_8)

					if var_390_6.name == "split_1" or not string.find(var_390_6.name, "split") then
						var_390_6.gameObject:SetActive(true)
					else
						var_390_6.gameObject:SetActive(false)
					end
				end
			end

			local var_390_7 = 0.001

			if 0 <= arg_387_1.time_ and arg_387_1.time_ < 0 + var_390_7 then
				var_390_5.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos10127, Vector3.New(-390, -387.4, -316.5), (arg_387_1.time_ - 0) / var_390_7)
			end

			if arg_387_1.time_ >= 0 + var_390_7 and arg_387_1.time_ < 0 + var_390_7 + arg_390_0 then
				var_390_5.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_390_8 = 0
			local var_390_9 = 0.55

			if 0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_8 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				arg_387_1.leftNameTxt_.text = arg_387_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_10 = arg_387_1:GetWordFromCfg(425042095)
				local var_390_11 = arg_387_1:FormatText(var_390_10.content)

				arg_387_1.text_.text = var_390_11

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_13 = 22 <= 0 and var_390_9 or var_390_9 * (utf8.len(var_390_11) / 22)

				if (22 <= 0 and var_390_9 or var_390_9 * (utf8.len(var_390_11) / 22)) > 0 and var_390_9 < var_390_13 then
					arg_387_1.talkMaxDuration = var_390_13

					if var_390_13 + var_390_8 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_13 + var_390_8
					end
				end

				arg_387_1.text_.text = var_390_11
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042095", "story_v_out_425042.awb") ~= 0 then
					local var_390_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042095", "story_v_out_425042.awb") / 1000

					if var_390_14 + var_390_8 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_14 + var_390_8
					end

					if var_390_10.prefab_name ~= "" and arg_387_1.actors_[var_390_10.prefab_name] ~= nil then
						local var_390_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_10.prefab_name].transform, "story_v_out_425042", "425042095", "story_v_out_425042.awb")

						arg_387_1:RecordAudio("425042095", var_390_15)
						arg_387_1:RecordAudio("425042095", var_390_15)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_425042", "425042095", "story_v_out_425042.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_425042", "425042095", "story_v_out_425042.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_16 = math.max(var_390_9, arg_387_1.talkMaxDuration)

			if var_390_8 <= arg_387_1.time_ and arg_387_1.time_ < var_390_8 + var_390_16 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_8) / var_390_16

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_8 + var_390_16 and arg_387_1.time_ < var_390_8 + var_390_16 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
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
	Play425042096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 425042096
		arg_391_1.duration_ = 11.53

		local var_391_0 = {
			zh = 7.633,
			ja = 11.533
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
				arg_391_0:Play425042097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = 0.9

			if 0 < arg_391_1.time_ and arg_391_1.time_ <= 0 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				arg_391_1.leftNameTxt_.text = arg_391_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_1 = arg_391_1:GetWordFromCfg(425042096)
				local var_394_2 = arg_391_1:FormatText(var_394_1.content)

				arg_391_1.text_.text = var_394_2

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_4 = 36 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 36)

				if (36 <= 0 and var_394_0 or var_394_0 * (utf8.len(var_394_2) / 36)) > 0 and var_394_0 < var_394_4 then
					arg_391_1.talkMaxDuration = var_394_4

					if var_394_4 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_4 + 0
					end
				end

				arg_391_1.text_.text = var_394_2
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042096", "story_v_out_425042.awb") ~= 0 then
					local var_394_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042096", "story_v_out_425042.awb") / 1000

					if var_394_5 + 0 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_5 + 0
					end

					if var_394_1.prefab_name ~= "" and arg_391_1.actors_[var_394_1.prefab_name] ~= nil then
						local var_394_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_1.prefab_name].transform, "story_v_out_425042", "425042096", "story_v_out_425042.awb")

						arg_391_1:RecordAudio("425042096", var_394_6)
						arg_391_1:RecordAudio("425042096", var_394_6)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_425042", "425042096", "story_v_out_425042.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_425042", "425042096", "story_v_out_425042.awb")
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
	Play425042097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 425042097
		arg_395_1.duration_ = 9.17

		local var_395_0 = {
			zh = 6.033,
			ja = 9.166
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
				arg_395_0:Play425042098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = 0.725

			if 0 < arg_395_1.time_ and arg_395_1.time_ <= 0 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				arg_395_1.leftNameTxt_.text = arg_395_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_1 = arg_395_1:GetWordFromCfg(425042097)
				local var_398_2 = arg_395_1:FormatText(var_398_1.content)

				arg_395_1.text_.text = var_398_2

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_4 = 29 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_2) / 29)

				if (29 <= 0 and var_398_0 or var_398_0 * (utf8.len(var_398_2) / 29)) > 0 and var_398_0 < var_398_4 then
					arg_395_1.talkMaxDuration = var_398_4

					if var_398_4 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_4 + 0
					end
				end

				arg_395_1.text_.text = var_398_2
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042097", "story_v_out_425042.awb") ~= 0 then
					local var_398_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042097", "story_v_out_425042.awb") / 1000

					if var_398_5 + 0 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_5 + 0
					end

					if var_398_1.prefab_name ~= "" and arg_395_1.actors_[var_398_1.prefab_name] ~= nil then
						local var_398_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_1.prefab_name].transform, "story_v_out_425042", "425042097", "story_v_out_425042.awb")

						arg_395_1:RecordAudio("425042097", var_398_6)
						arg_395_1:RecordAudio("425042097", var_398_6)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_425042", "425042097", "story_v_out_425042.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_425042", "425042097", "story_v_out_425042.awb")
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
	Play425042098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 425042098
		arg_399_1.duration_ = 6.2

		local var_399_0 = {
			zh = 6,
			ja = 6.2
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
				arg_399_0:Play425042099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(arg_399_1.actors_["1137"]) and arg_399_1.var_.actorSpriteComps1137 == nil then
				arg_399_1.var_.actorSpriteComps1137 = arg_399_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_0 = 0.2

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_0 and not isNil(arg_399_1.actors_["1137"]) then
				if arg_399_1.var_.actorSpriteComps1137 then
					for iter_402_0, iter_402_1 in pairs(arg_399_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_399_1.time_ >= 0 + var_402_0 and arg_399_1.time_ < 0 + var_402_0 + arg_402_0 and not isNil(arg_399_1.actors_["1137"]) and arg_399_1.var_.actorSpriteComps1137 then
				for iter_402_2, iter_402_3 in pairs(arg_399_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_402_3 then
						iter_402_3.color = arg_399_1.isInRecall_ and (arg_399_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_399_1.var_.actorSpriteComps1137 = nil
			end

			local var_402_2 = arg_399_1.actors_["10127"]

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= 0 + arg_402_0 and not isNil(var_402_2) and arg_399_1.var_.actorSpriteComps10127 == nil then
				arg_399_1.var_.actorSpriteComps10127 = var_402_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_402_3 = 0.2

			if 0 <= arg_399_1.time_ and arg_399_1.time_ < 0 + var_402_3 and not isNil(var_402_2) then
				if arg_399_1.var_.actorSpriteComps10127 then
					for iter_402_4, iter_402_5 in pairs(arg_399_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_399_1.time_ >= 0 + var_402_3 and arg_399_1.time_ < 0 + var_402_3 + arg_402_0 and not isNil(var_402_2) and arg_399_1.var_.actorSpriteComps10127 then
				for iter_402_6, iter_402_7 in pairs(arg_399_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_402_7 then
						iter_402_7.color = arg_399_1.isInRecall_ and (arg_399_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_399_1.var_.actorSpriteComps10127 = nil
			end

			local var_402_5 = 0
			local var_402_6 = 0.475

			if 0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_5 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				arg_399_1.leftNameTxt_.text = arg_399_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_7 = arg_399_1:GetWordFromCfg(425042098)
				local var_402_8 = arg_399_1:FormatText(var_402_7.content)

				arg_399_1.text_.text = var_402_8

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_10 = 19 <= 0 and var_402_6 or var_402_6 * (utf8.len(var_402_8) / 19)

				if (19 <= 0 and var_402_6 or var_402_6 * (utf8.len(var_402_8) / 19)) > 0 and var_402_6 < var_402_10 then
					arg_399_1.talkMaxDuration = var_402_10

					if var_402_10 + var_402_5 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_10 + var_402_5
					end
				end

				arg_399_1.text_.text = var_402_8
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042098", "story_v_out_425042.awb") ~= 0 then
					local var_402_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042098", "story_v_out_425042.awb") / 1000

					if var_402_11 + var_402_5 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_11 + var_402_5
					end

					if var_402_7.prefab_name ~= "" and arg_399_1.actors_[var_402_7.prefab_name] ~= nil then
						local var_402_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_7.prefab_name].transform, "story_v_out_425042", "425042098", "story_v_out_425042.awb")

						arg_399_1:RecordAudio("425042098", var_402_12)
						arg_399_1:RecordAudio("425042098", var_402_12)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_425042", "425042098", "story_v_out_425042.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_425042", "425042098", "story_v_out_425042.awb")
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
	Play425042099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 425042099
		arg_403_1.duration_ = 7.47

		local var_403_0 = {
			zh = 6.466,
			ja = 7.466
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
				arg_403_0:Play425042100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(arg_403_1.actors_["10127"]) and arg_403_1.var_.actorSpriteComps10127 == nil then
				arg_403_1.var_.actorSpriteComps10127 = arg_403_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_0 = 0.2

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_0 and not isNil(arg_403_1.actors_["10127"]) then
				if arg_403_1.var_.actorSpriteComps10127 then
					for iter_406_0, iter_406_1 in pairs(arg_403_1.var_.actorSpriteComps10127:ToTable()) do
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

			if arg_403_1.time_ >= 0 + var_406_0 and arg_403_1.time_ < 0 + var_406_0 + arg_406_0 and not isNil(arg_403_1.actors_["10127"]) and arg_403_1.var_.actorSpriteComps10127 then
				for iter_406_2, iter_406_3 in pairs(arg_403_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_406_3 then
						iter_406_3.color = arg_403_1.isInRecall_ and (arg_403_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_403_1.var_.actorSpriteComps10127 = nil
			end

			local var_406_2 = arg_403_1.actors_["1137"]

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 and not isNil(var_406_2) and arg_403_1.var_.actorSpriteComps1137 == nil then
				arg_403_1.var_.actorSpriteComps1137 = var_406_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_406_3 = 0.2

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_3 and not isNil(var_406_2) then
				if arg_403_1.var_.actorSpriteComps1137 then
					for iter_406_4, iter_406_5 in pairs(arg_403_1.var_.actorSpriteComps1137:ToTable()) do
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

			if arg_403_1.time_ >= 0 + var_406_3 and arg_403_1.time_ < 0 + var_406_3 + arg_406_0 and not isNil(var_406_2) and arg_403_1.var_.actorSpriteComps1137 then
				for iter_406_6, iter_406_7 in pairs(arg_403_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_406_7 then
						iter_406_7.color = arg_403_1.isInRecall_ and (arg_403_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_403_1.var_.actorSpriteComps1137 = nil
			end

			local var_406_5 = arg_403_1.actors_["10127"].transform

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= 0 + arg_406_0 then
				arg_403_1.var_.moveOldPos10127 = var_406_5.localPosition
				var_406_5.localScale = Vector3.New(1, 1, 1)

				arg_403_1:CheckSpriteTmpPos("10127", 2)

				for iter_406_8 = 0, var_406_5.childCount - 1 do
					local var_406_6 = var_406_5:GetChild(iter_406_8)

					if var_406_6.name == "split_6" then
						var_406_6:SetAsLastSibling()
						var_406_6.gameObject:SetActive(true)

						arg_403_1.var_.actorSpriteSplit10127 = var_406_6.gameObject:GetComponent(typeof(Image))

						arg_403_1.var_.actorSpriteSplit10127:SetAlpha(0)
					end
				end
			end

			local var_406_7 = 0.2

			if 0 <= arg_403_1.time_ and arg_403_1.time_ < 0 + var_406_7 then
				var_406_5.localPosition = Vector3.Lerp(arg_403_1.var_.moveOldPos10127, Vector3.New(-390, -387.4, -316.5), (arg_403_1.time_ - 0) / var_406_7)

				if arg_403_1.var_.actorSpriteSplit10127 ~= nil then
					arg_403_1.var_.actorSpriteSplit10127:SetAlpha((arg_403_1.time_ - 0) / var_406_7)
				end
			end

			if arg_403_1.time_ >= 0 + var_406_7 and arg_403_1.time_ < 0 + var_406_7 + arg_406_0 then
				var_406_5.localPosition = Vector3.New(-390, -387.4, -316.5)

				if arg_403_1.var_.actorSpriteSplit10127 ~= nil then
					arg_403_1.var_.actorSpriteSplit10127:SetAlpha(1)
				end
			end

			local var_406_8 = 0
			local var_406_9 = 0.675

			if 0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_8 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				arg_403_1.leftNameTxt_.text = arg_403_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_10 = arg_403_1:GetWordFromCfg(425042099)
				local var_406_11 = arg_403_1:FormatText(var_406_10.content)

				arg_403_1.text_.text = var_406_11

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_13 = 27 <= 0 and var_406_9 or var_406_9 * (utf8.len(var_406_11) / 27)

				if (27 <= 0 and var_406_9 or var_406_9 * (utf8.len(var_406_11) / 27)) > 0 and var_406_9 < var_406_13 then
					arg_403_1.talkMaxDuration = var_406_13

					if var_406_13 + var_406_8 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_13 + var_406_8
					end
				end

				arg_403_1.text_.text = var_406_11
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042099", "story_v_out_425042.awb") ~= 0 then
					local var_406_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042099", "story_v_out_425042.awb") / 1000

					if var_406_14 + var_406_8 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_14 + var_406_8
					end

					if var_406_10.prefab_name ~= "" and arg_403_1.actors_[var_406_10.prefab_name] ~= nil then
						local var_406_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_10.prefab_name].transform, "story_v_out_425042", "425042099", "story_v_out_425042.awb")

						arg_403_1:RecordAudio("425042099", var_406_15)
						arg_403_1:RecordAudio("425042099", var_406_15)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_425042", "425042099", "story_v_out_425042.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_425042", "425042099", "story_v_out_425042.awb")
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
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_403_1:InitPlayNodeList()
	end,
	Play425042100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 425042100
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play425042101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos10127 = arg_407_1.actors_["10127"].transform.localPosition
				arg_407_1.actors_["10127"].transform.localScale = Vector3.New(1, 1, 1)

				arg_407_1:CheckSpriteTmpPos("10127", 7)

				for iter_410_0 = 0, arg_407_1.actors_["10127"].transform.childCount - 1 do
					local var_410_0 = arg_407_1.actors_["10127"].transform:GetChild(iter_410_0)

					if var_410_0.name == "split_6" or not string.find(var_410_0.name, "split") then
						var_410_0.gameObject:SetActive(true)
					else
						var_410_0.gameObject:SetActive(false)
					end
				end
			end

			local var_410_1 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_1 then
				arg_407_1.actors_["10127"].transform.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos10127, Vector3.New(0, -2000, 0), (arg_407_1.time_ - 0) / var_410_1)
			end

			if arg_407_1.time_ >= 0 + var_410_1 and arg_407_1.time_ < 0 + var_410_1 + arg_410_0 then
				arg_407_1.actors_["10127"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_410_2 = arg_407_1.actors_["1137"].transform

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 then
				arg_407_1.var_.moveOldPos1137 = var_410_2.localPosition
				var_410_2.localScale = Vector3.New(1, 1, 1)

				arg_407_1:CheckSpriteTmpPos("1137", 7)

				for iter_410_1 = 0, var_410_2.childCount - 1 do
					local var_410_3 = var_410_2:GetChild(iter_410_1)

					if var_410_3.name == "split_4" or not string.find(var_410_3.name, "split") then
						var_410_3.gameObject:SetActive(true)
					else
						var_410_3.gameObject:SetActive(false)
					end
				end
			end

			local var_410_4 = 0.001

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_4 then
				var_410_2.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_407_1.time_ - 0) / var_410_4)
			end

			if arg_407_1.time_ >= 0 + var_410_4 and arg_407_1.time_ < 0 + var_410_4 + arg_410_0 then
				var_410_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_410_5 = 0
			local var_410_6 = 0.775

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_5 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_7 = arg_407_1:FormatText(arg_407_1:GetWordFromCfg(425042100).content)

				arg_407_1.text_.text = var_410_7

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_9 = 31 <= 0 and var_410_6 or var_410_6 * (utf8.len(var_410_7) / 31)

				if (31 <= 0 and var_410_6 or var_410_6 * (utf8.len(var_410_7) / 31)) > 0 and var_410_6 < var_410_9 then
					arg_407_1.talkMaxDuration = var_410_9

					if var_410_9 + var_410_5 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_9 + var_410_5
					end
				end

				arg_407_1.text_.text = var_410_7
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_10 = math.max(var_410_6, arg_407_1.talkMaxDuration)

			if var_410_5 <= arg_407_1.time_ and arg_407_1.time_ < var_410_5 + var_410_10 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_5) / var_410_10

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_5 + var_410_10 and arg_407_1.time_ < var_410_5 + var_410_10 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1137",
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
	Play425042101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 425042101
		arg_411_1.duration_ = 5.57

		local var_411_0 = {
			zh = 3.166,
			ja = 5.566
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
				arg_411_0:Play425042102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(arg_411_1.actors_["1137"]) and arg_411_1.var_.actorSpriteComps1137 == nil then
				arg_411_1.var_.actorSpriteComps1137 = arg_411_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_0 = 0.2

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 and not isNil(arg_411_1.actors_["1137"]) then
				if arg_411_1.var_.actorSpriteComps1137 then
					for iter_414_0, iter_414_1 in pairs(arg_411_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_414_1 then
							if arg_411_1.isInRecall_ then
								iter_414_1.color = Color.New(Mathf.Lerp(iter_414_1.color.r, arg_411_1.hightColor1.r, (arg_411_1.time_ - 0) / var_414_0), Mathf.Lerp(iter_414_1.color.g, arg_411_1.hightColor1.g, (arg_411_1.time_ - 0) / var_414_0), (Mathf.Lerp(iter_414_1.color.b, arg_411_1.hightColor1.b, (arg_411_1.time_ - 0) / var_414_0)))
							else
								local var_414_1 = Mathf.Lerp(iter_414_1.color.r, 1, (arg_411_1.time_ - 0) / var_414_0)

								iter_414_1.color = Color.New(var_414_1, var_414_1, var_414_1)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 and not isNil(arg_411_1.actors_["1137"]) and arg_411_1.var_.actorSpriteComps1137 then
				for iter_414_2, iter_414_3 in pairs(arg_411_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_414_3 then
						iter_414_3.color = arg_411_1.isInRecall_ and (arg_411_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_411_1.var_.actorSpriteComps1137 = nil
			end

			local var_414_2 = arg_411_1.actors_["1137"].transform

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 then
				arg_411_1.var_.moveOldPos1137 = var_414_2.localPosition
				var_414_2.localScale = Vector3.New(1, 1, 1)

				arg_411_1:CheckSpriteTmpPos("1137", 4)

				for iter_414_4 = 0, var_414_2.childCount - 1 do
					local var_414_3 = var_414_2:GetChild(iter_414_4)

					if var_414_3.name == "split_5" or not string.find(var_414_3.name, "split") then
						var_414_3.gameObject:SetActive(true)
					else
						var_414_3.gameObject:SetActive(false)
					end
				end
			end

			local var_414_4 = 0.001

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_4 then
				var_414_2.localPosition = Vector3.Lerp(arg_411_1.var_.moveOldPos1137, Vector3.New(390, -425, -200), (arg_411_1.time_ - 0) / var_414_4)
			end

			if arg_411_1.time_ >= 0 + var_414_4 and arg_411_1.time_ < 0 + var_414_4 + arg_414_0 then
				var_414_2.localPosition = Vector3.New(390, -425, -200)
			end

			local var_414_5 = 0
			local var_414_6 = 0.225

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_5 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_7 = arg_411_1:GetWordFromCfg(425042101)
				local var_414_8 = arg_411_1:FormatText(var_414_7.content)

				arg_411_1.text_.text = var_414_8

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_10 = 9 <= 0 and var_414_6 or var_414_6 * (utf8.len(var_414_8) / 9)

				if (9 <= 0 and var_414_6 or var_414_6 * (utf8.len(var_414_8) / 9)) > 0 and var_414_6 < var_414_10 then
					arg_411_1.talkMaxDuration = var_414_10

					if var_414_10 + var_414_5 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_10 + var_414_5
					end
				end

				arg_411_1.text_.text = var_414_8
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042101", "story_v_out_425042.awb") ~= 0 then
					local var_414_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042101", "story_v_out_425042.awb") / 1000

					if var_414_11 + var_414_5 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_11 + var_414_5
					end

					if var_414_7.prefab_name ~= "" and arg_411_1.actors_[var_414_7.prefab_name] ~= nil then
						local var_414_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_7.prefab_name].transform, "story_v_out_425042", "425042101", "story_v_out_425042.awb")

						arg_411_1:RecordAudio("425042101", var_414_12)
						arg_411_1:RecordAudio("425042101", var_414_12)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_425042", "425042101", "story_v_out_425042.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_425042", "425042101", "story_v_out_425042.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_13 = math.max(var_414_6, arg_411_1.talkMaxDuration)

			if var_414_5 <= arg_411_1.time_ and arg_411_1.time_ < var_414_5 + var_414_13 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_5) / var_414_13

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_5 + var_414_13 and arg_411_1.time_ < var_414_5 + var_414_13 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
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
	Play425042102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 425042102
		arg_415_1.duration_ = 11.17

		local var_415_0 = {
			zh = 5.333,
			ja = 11.166
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
				arg_415_0:Play425042103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(arg_415_1.actors_["10127"]) and arg_415_1.var_.actorSpriteComps10127 == nil then
				arg_415_1.var_.actorSpriteComps10127 = arg_415_1.actors_["10127"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_0 = 0.2

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_0 and not isNil(arg_415_1.actors_["10127"]) then
				if arg_415_1.var_.actorSpriteComps10127 then
					for iter_418_0, iter_418_1 in pairs(arg_415_1.var_.actorSpriteComps10127:ToTable()) do
						if iter_418_1 then
							if arg_415_1.isInRecall_ then
								iter_418_1.color = Color.New(Mathf.Lerp(iter_418_1.color.r, arg_415_1.hightColor1.r, (arg_415_1.time_ - 0) / var_418_0), Mathf.Lerp(iter_418_1.color.g, arg_415_1.hightColor1.g, (arg_415_1.time_ - 0) / var_418_0), (Mathf.Lerp(iter_418_1.color.b, arg_415_1.hightColor1.b, (arg_415_1.time_ - 0) / var_418_0)))
							else
								local var_418_1 = Mathf.Lerp(iter_418_1.color.r, 1, (arg_415_1.time_ - 0) / var_418_0)

								iter_418_1.color = Color.New(var_418_1, var_418_1, var_418_1)
							end
						end
					end
				end
			end

			if arg_415_1.time_ >= 0 + var_418_0 and arg_415_1.time_ < 0 + var_418_0 + arg_418_0 and not isNil(arg_415_1.actors_["10127"]) and arg_415_1.var_.actorSpriteComps10127 then
				for iter_418_2, iter_418_3 in pairs(arg_415_1.var_.actorSpriteComps10127:ToTable()) do
					if iter_418_3 then
						iter_418_3.color = arg_415_1.isInRecall_ and (arg_415_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_415_1.var_.actorSpriteComps10127 = nil
			end

			local var_418_2 = arg_415_1.actors_["1137"]

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 and not isNil(var_418_2) and arg_415_1.var_.actorSpriteComps1137 == nil then
				arg_415_1.var_.actorSpriteComps1137 = var_418_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_418_3 = 0.2

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_3 and not isNil(var_418_2) then
				if arg_415_1.var_.actorSpriteComps1137 then
					for iter_418_4, iter_418_5 in pairs(arg_415_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_418_5 then
							if arg_415_1.isInRecall_ then
								iter_418_5.color = Color.New(Mathf.Lerp(iter_418_5.color.r, arg_415_1.hightColor2.r, (arg_415_1.time_ - 0) / var_418_3), Mathf.Lerp(iter_418_5.color.g, arg_415_1.hightColor2.g, (arg_415_1.time_ - 0) / var_418_3), (Mathf.Lerp(iter_418_5.color.b, arg_415_1.hightColor2.b, (arg_415_1.time_ - 0) / var_418_3)))
							else
								local var_418_4 = Mathf.Lerp(iter_418_5.color.r, 0.5, (arg_415_1.time_ - 0) / var_418_3)

								iter_418_5.color = Color.New(var_418_4, var_418_4, var_418_4)
							end
						end
					end
				end
			end

			if arg_415_1.time_ >= 0 + var_418_3 and arg_415_1.time_ < 0 + var_418_3 + arg_418_0 and not isNil(var_418_2) and arg_415_1.var_.actorSpriteComps1137 then
				for iter_418_6, iter_418_7 in pairs(arg_415_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_418_7 then
						iter_418_7.color = arg_415_1.isInRecall_ and (arg_415_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_415_1.var_.actorSpriteComps1137 = nil
			end

			local var_418_5 = arg_415_1.actors_["10127"].transform

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.var_.moveOldPos10127 = var_418_5.localPosition
				var_418_5.localScale = Vector3.New(1, 1, 1)

				arg_415_1:CheckSpriteTmpPos("10127", 2)

				for iter_418_8 = 0, var_418_5.childCount - 1 do
					local var_418_6 = var_418_5:GetChild(iter_418_8)

					if var_418_6.name == "split_4" or not string.find(var_418_6.name, "split") then
						var_418_6.gameObject:SetActive(true)
					else
						var_418_6.gameObject:SetActive(false)
					end
				end
			end

			local var_418_7 = 0.001

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_7 then
				var_418_5.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos10127, Vector3.New(-390, -387.4, -316.5), (arg_415_1.time_ - 0) / var_418_7)
			end

			if arg_415_1.time_ >= 0 + var_418_7 and arg_415_1.time_ < 0 + var_418_7 + arg_418_0 then
				var_418_5.localPosition = Vector3.New(-390, -387.4, -316.5)
			end

			local var_418_8 = 0
			local var_418_9 = 0.525

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_8 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_10 = arg_415_1:GetWordFromCfg(425042102)
				local var_418_11 = arg_415_1:FormatText(var_418_10.content)

				arg_415_1.text_.text = var_418_11

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_13 = 21 <= 0 and var_418_9 or var_418_9 * (utf8.len(var_418_11) / 21)

				if (21 <= 0 and var_418_9 or var_418_9 * (utf8.len(var_418_11) / 21)) > 0 and var_418_9 < var_418_13 then
					arg_415_1.talkMaxDuration = var_418_13

					if var_418_13 + var_418_8 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_13 + var_418_8
					end
				end

				arg_415_1.text_.text = var_418_11
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042102", "story_v_out_425042.awb") ~= 0 then
					local var_418_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042102", "story_v_out_425042.awb") / 1000

					if var_418_14 + var_418_8 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_14 + var_418_8
					end

					if var_418_10.prefab_name ~= "" and arg_415_1.actors_[var_418_10.prefab_name] ~= nil then
						local var_418_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_10.prefab_name].transform, "story_v_out_425042", "425042102", "story_v_out_425042.awb")

						arg_415_1:RecordAudio("425042102", var_418_15)
						arg_415_1:RecordAudio("425042102", var_418_15)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_425042", "425042102", "story_v_out_425042.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_425042", "425042102", "story_v_out_425042.awb")
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
				actorName = "10127",
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
	Play425042103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 425042103
		arg_419_1.duration_ = 5.8

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play425042104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_9000

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos1137 = arg_419_1.actors_["1137"].transform.localPosition
				arg_419_1.actors_["1137"].transform.localScale = Vector3.New(1, 1, 1)

				arg_419_1:CheckSpriteTmpPos("1137", 7)

				for iter_422_0 = 0, arg_419_1.actors_["1137"].transform.childCount - 1 do
					local var_422_0 = arg_419_1.actors_["1137"].transform:GetChild(iter_422_0)

					if var_422_0.name == "" or not string.find(var_422_0.name, "split") then
						var_422_0.gameObject:SetActive(true)
					else
						var_422_0.gameObject:SetActive(false)
					end
				end
			end

			local var_422_1 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_1 then
				arg_419_1.actors_["1137"].transform.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_419_1.time_ - 0) / var_422_1)
			end

			if arg_419_1.time_ >= 0 + var_422_1 and arg_419_1.time_ < 0 + var_422_1 + arg_422_0 then
				arg_419_1.actors_["1137"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_422_2 = arg_419_1.actors_["10127"].transform

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos10127 = var_422_2.localPosition
				var_422_2.localScale = Vector3.New(1, 1, 1)

				arg_419_1:CheckSpriteTmpPos("10127", 7)

				for iter_422_1 = 0, var_422_2.childCount - 1 do
					local var_422_3 = var_422_2:GetChild(iter_422_1)

					if var_422_3.name == "" or not string.find(var_422_3.name, "split") then
						var_422_3.gameObject:SetActive(true)
					else
						var_422_3.gameObject:SetActive(false)
					end
				end
			end

			local var_422_4 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_4 then
				var_422_2.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos10127, Vector3.New(0, -2000, 0), (arg_419_1.time_ - 0) / var_422_4)
			end

			if arg_419_1.time_ >= 0 + var_422_4 and arg_419_1.time_ < 0 + var_422_4 + arg_422_0 then
				var_422_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.366666666666667 < arg_419_1.time_ and arg_419_1.time_ <= 0.366666666666667 + arg_422_0 then
				local var_422_5 = arg_419_1.var_.effect10091009

				if not arg_419_1.var_.effect10091009 then
					var_422_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple2"), manager.ui.mainCamera.transform)
					var_422_5.name = "1009"
					arg_419_1.var_.effect10091009 = var_422_5
				else
					var_422_5.transform:SetParent(var_422_9000)
				end

				var_422_5.transform.localPosition = Vector3.New(0, 0.12, -1)
				var_422_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 4.7 < arg_419_1.time_ and arg_419_1.time_ <= 4.7 + arg_422_0 then
				if arg_419_1.var_.effect10091009 then
					Object.Destroy(arg_419_1.var_.effect10091009)

					arg_419_1.var_.effect10091009 = nil
				end
			end

			local var_422_8 = manager.ui.mainCamera.transform

			if 0.366666666666667 < arg_419_1.time_ and arg_419_1.time_ <= 0.366666666666667 + arg_422_0 then
				arg_419_1.var_.shakeOldPos = var_422_8.localPosition
			end

			local var_422_9 = 0.633333333333333

			if 0.366666666666667 <= arg_419_1.time_ and arg_419_1.time_ < 0.366666666666667 + var_422_9 then
				local var_422_10, var_422_11 = math.modf((arg_419_1.time_ - 0.366666666666667) / 0.066)

				var_422_8.localPosition = Vector3.New(var_422_11 * 0.13, var_422_11 * 0.13, var_422_11 * 0.13) + arg_419_1.var_.shakeOldPos
			end

			if arg_419_1.time_ >= 0.366666666666667 + var_422_9 and arg_419_1.time_ < 0.366666666666667 + var_422_9 + arg_422_0 then
				var_422_8.localPosition = arg_419_1.var_.shakeOldPos
			end

			local var_422_12

			if 1 < arg_419_1.time_ and arg_419_1.time_ <= 1 + arg_422_0 then
				local var_422_13 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_422_13 then
					var_422_13.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_422_13.radialBlurScale = 0.3
					var_422_13.radialBlurGradient = 1
					var_422_13.radialBlurIntensity = 0.4

					if var_422_12 then
						var_422_13.radialBlurTarget = var_422_12.transform
					end
				end
			end

			local var_422_14 = 2.174999999998

			if 1 <= arg_419_1.time_ and arg_419_1.time_ < 1 + var_422_14 then
				local var_422_15 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_422_15 then
					var_422_15.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_422_15.radialBlurScale = Mathf.Lerp(0.3, 0.8, (arg_419_1.time_ - 1) / var_422_14)
					var_422_15.radialBlurGradient = Mathf.Lerp(1, 1, (arg_419_1.time_ - 1) / var_422_14)
					var_422_15.radialBlurIntensity = Mathf.Lerp(0.4, 0.8, (arg_419_1.time_ - 1) / var_422_14)
				end
			end

			if arg_419_1.time_ >= 1 + var_422_14 and arg_419_1.time_ < 1 + var_422_14 + arg_422_0 then
				local var_422_16 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_422_16 then
					var_422_16.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_422_16.radialBlurScale = 0.8
					var_422_16.radialBlurGradient = 1
					var_422_16.radialBlurIntensity = 0.8
				end
			end

			if 0.212537501240149 < arg_419_1.time_ and arg_419_1.time_ <= 0.212537501240149 + arg_422_0 then
				arg_419_1:AudioAction("play", "effect", "se_story_147", "se_story_147_electric_shock_01", "")
			end

			if 0.5 < arg_419_1.time_ and arg_419_1.time_ <= 0.5 + arg_422_0 then
				arg_419_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if 0.366666666666667 < arg_419_1.time_ and arg_419_1.time_ <= 0.366666666666667 + arg_422_0 then
				arg_419_1:AudioAction("stop", "effect", "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_422_20 = 0
			local var_422_21 = 1.125

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_20 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_22 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(425042103).content)

				arg_419_1.text_.text = var_422_22

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_24 = 45 <= 0 and var_422_21 or var_422_21 * (utf8.len(var_422_22) / 45)

				if (45 <= 0 and var_422_21 or var_422_21 * (utf8.len(var_422_22) / 45)) > 0 and var_422_21 < var_422_24 then
					arg_419_1.talkMaxDuration = var_422_24

					if var_422_24 + var_422_20 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_24 + var_422_20
					end
				end

				arg_419_1.text_.text = var_422_22
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_25 = math.max(var_422_21, arg_419_1.talkMaxDuration)

			if var_422_20 <= arg_419_1.time_ and arg_419_1.time_ < var_422_20 + var_422_25 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_20) / var_422_25

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_20 + var_422_25 and arg_419_1.time_ < var_422_20 + var_422_25 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10127",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	Play425042104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 425042104
		arg_423_1.duration_ = 10.6

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play425042105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_0 = 1.2

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 then
				local var_426_1 = Color.New(0, 0, 0)

				var_426_1.a = Mathf.Lerp(0, 1, (arg_423_1.time_ - 0) / var_426_0)
				arg_423_1.mask_.color = var_426_1
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 then
				local var_426_2 = Color.New(0, 0, 0)

				var_426_2.a = 1
				arg_423_1.mask_.color = var_426_2
			end

			local var_426_3 = 1.2

			if 1.2 < arg_423_1.time_ and arg_423_1.time_ <= var_426_3 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_4 = 1.2

			if var_426_3 <= arg_423_1.time_ and arg_423_1.time_ < var_426_3 + var_426_4 then
				local var_426_5 = Color.New(0, 0, 0)

				var_426_5.a = Mathf.Lerp(1, 0, (arg_423_1.time_ - var_426_3) / var_426_4)
				arg_423_1.mask_.color = var_426_5
			end

			if arg_423_1.time_ >= var_426_3 + var_426_4 and arg_423_1.time_ < var_426_3 + var_426_4 + arg_426_0 then
				local var_426_6 = Color.New(0, 0, 0)

				arg_423_1.mask_.enabled = false
				var_426_6.a = 0
				arg_423_1.mask_.color = var_426_6
			end

			local var_426_7 = 5.60000033333333

			if 5.60000033333333 < arg_423_1.time_ and arg_423_1.time_ <= var_426_7 + arg_426_0 then
				arg_423_1.allBtn_.enabled = false
			end

			if arg_423_1.time_ >= var_426_7 + 0.3 and arg_423_1.time_ < var_426_7 + 0.3 + arg_426_0 then
				arg_423_1.allBtn_.enabled = true
			end

			local var_426_8 = 1.2

			if 1.2 < arg_423_1.time_ and arg_423_1.time_ <= var_426_8 + arg_426_0 then
				arg_423_1.timestampController_:SetSelectedState("show")
				arg_423_1.timestampAni_:Play("in")

				arg_423_1.timeTicketbgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2402")

				arg_423_1.timestampColorController_:SetSelectedState("cold")
				arg_423_1.timeColdImg_:SetAlpha(0.031)

				arg_423_1.text_timeText_.text = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(501106).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_timeText_)

				arg_423_1.text_siteText_.text = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(501107).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_siteText_)
			end

			if arg_423_1.time_ >= var_426_8 + 1.999999999999 and arg_423_1.time_ < var_426_8 + 1.999999999999 + arg_426_0 then
				AnimatorTools.PlayAnimationWithCallback(arg_423_1.timestampAni_, "out", function()
					arg_423_1.timestampController_:SetSelectedState("hide")
				end)
			end

			local var_426_9 = 3.20000033333333

			if 3.20000033333333 < arg_423_1.time_ and arg_423_1.time_ <= var_426_9 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_10 = 1.2

			if var_426_9 <= arg_423_1.time_ and arg_423_1.time_ < var_426_9 + var_426_10 then
				local var_426_11 = Color.New(0, 0, 0)

				var_426_11.a = Mathf.Lerp(0, 1, (arg_423_1.time_ - var_426_9) / var_426_10)
				arg_423_1.mask_.color = var_426_11
			end

			if arg_423_1.time_ >= var_426_9 + var_426_10 and arg_423_1.time_ < var_426_9 + var_426_10 + arg_426_0 then
				local var_426_12 = Color.New(0, 0, 0)

				var_426_12.a = 1
				arg_423_1.mask_.color = var_426_12
			end

			local var_426_13 = 4.40000033333333

			if 4.40000033333333 < arg_423_1.time_ and arg_423_1.time_ <= var_426_13 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_14 = 1.2

			if var_426_13 <= arg_423_1.time_ and arg_423_1.time_ < var_426_13 + var_426_14 then
				local var_426_15 = Color.New(0, 0, 0)

				var_426_15.a = Mathf.Lerp(1, 0, (arg_423_1.time_ - var_426_13) / var_426_14)
				arg_423_1.mask_.color = var_426_15
			end

			if arg_423_1.time_ >= var_426_13 + var_426_14 and arg_423_1.time_ < var_426_13 + var_426_14 + arg_426_0 then
				local var_426_16 = Color.New(0, 0, 0)

				arg_423_1.mask_.enabled = false
				var_426_16.a = 0
				arg_423_1.mask_.color = var_426_16
			end

			local var_426_17 = "ST2402"

			if arg_423_1.bgs_.ST2402 == nil then
				local var_426_18 = Object.Instantiate(arg_423_1.paintGo_)

				var_426_18:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_426_17)
				var_426_18.name = var_426_17
				var_426_18.transform.parent = arg_423_1.stage_.transform
				var_426_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_423_1.bgs_[var_426_17] = var_426_18
			end

			if 1.2 < arg_423_1.time_ and arg_423_1.time_ <= 1.2 + arg_426_0 then
				local var_426_19 = arg_423_1.bgs_.ST2402

				arg_423_1.bgs_.ST2402.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_426_19.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_426_20 = var_426_19:GetComponent("SpriteRenderer")

				if var_426_20 and var_426_20.sprite then
					local var_426_21 = 2 * (var_426_19.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_426_19.transform.localScale = Vector3.New(var_426_21 / var_426_20.sprite.bounds.size.y < var_426_21 * manager.ui.mainCameraCom_.aspect / var_426_20.sprite.bounds.size.x and var_426_21 * manager.ui.mainCameraCom_.aspect / var_426_20.sprite.bounds.size.x or var_426_21 / var_426_20.sprite.bounds.size.y, var_426_21 / var_426_20.sprite.bounds.size.y < var_426_21 * manager.ui.mainCameraCom_.aspect / var_426_20.sprite.bounds.size.x and var_426_21 * manager.ui.mainCameraCom_.aspect / var_426_20.sprite.bounds.size.x or var_426_21 / var_426_20.sprite.bounds.size.y, 0)
				end

				for iter_426_0, iter_426_1 in pairs(arg_423_1.bgs_) do
					if iter_426_0 ~= "ST2402" then
						iter_426_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:AudioAction("play", "effect", "se_story_141", "se_story_141_unreal", "")
			end

			if 4.3 < arg_423_1.time_ and arg_423_1.time_ <= 4.3 + arg_426_0 then
				arg_423_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_unreal", "")
			end

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 then
				arg_423_1:AudioAction("stop", "effect", "se_story_122_01", "se_story_122_01_dizzy_loop", "")
			end

			if arg_423_1.frameCnt_ <= 1 then
				arg_423_1.dialog_:SetActive(false)
			end

			local var_426_25 = 5.60000033333333
			local var_426_26 = 1.1

			if 5.60000033333333 < arg_423_1.time_ and arg_423_1.time_ <= var_426_25 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0

				arg_423_1.dialog_:SetActive(true)

				arg_423_1.dialogCg_.alpha = 0

				local var_426_27 = LeanTween.value(arg_423_1.dialog_, 0, 1, 0.3)

				var_426_27:setOnUpdate(LuaHelper.FloatAction(function(arg_428_0)
					arg_423_1.dialogCg_.alpha = arg_428_0
				end))
				var_426_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_423_1.dialog_)
					var_426_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_423_1.duration_ = arg_423_1.duration_ + 0.3

				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_28 = arg_423_1:FormatText(arg_423_1:GetWordFromCfg(425042104).content)

				arg_423_1.text_.text = var_426_28

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_30 = 44 <= 0 and var_426_26 or var_426_26 * (utf8.len(var_426_28) / 44)

				if (44 <= 0 and var_426_26 or var_426_26 * (utf8.len(var_426_28) / 44)) > 0 and var_426_26 < var_426_30 then
					arg_423_1.talkMaxDuration = var_426_30
					var_426_25 = var_426_25 + 0.3

					if var_426_30 + var_426_25 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_30 + var_426_25
					end
				end

				arg_423_1.text_.text = var_426_28
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_31 = var_426_25 + 0.3
			local var_426_32 = math.max(var_426_26, arg_423_1.talkMaxDuration)

			if var_426_25 + 0.3 <= arg_423_1.time_ and arg_423_1.time_ < var_426_31 + var_426_32 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_31) / var_426_32

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_31 + var_426_32 and arg_423_1.time_ < var_426_31 + var_426_32 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play425042105 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 425042105
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play425042106(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				local var_433_0 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_433_0 then
					var_433_0.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_433_0.radialBlurScale = 0.8
					var_433_0.radialBlurGradient = 1
					var_433_0.radialBlurIntensity = 0.8

					if nil then
						var_433_0.radialBlurTarget = (nil).transform
					end
				end
			end

			local var_433_1 = 1

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_1 then
				local var_433_2 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_433_2 then
					var_433_2.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_433_2.radialBlurScale = Mathf.Lerp(0.8, 0, (arg_430_1.time_ - 0) / var_433_1)
					var_433_2.radialBlurGradient = Mathf.Lerp(1, 1, (arg_430_1.time_ - 0) / var_433_1)
					var_433_2.radialBlurIntensity = Mathf.Lerp(0.8, 0, (arg_430_1.time_ - 0) / var_433_1)
				end
			end

			if arg_430_1.time_ >= 0 + var_433_1 and arg_430_1.time_ < 0 + var_433_1 + arg_433_0 then
				local var_433_3 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_433_3 then
					var_433_3.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_433_3.radialBlurScale = 0
					var_433_3.radialBlurGradient = 1
					var_433_3.radialBlurIntensity = 0
				end
			end

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 then
				arg_430_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_unreal", "")
			end

			if 0.1 < arg_430_1.time_ and arg_430_1.time_ <= 0.1 + arg_433_0 then
				arg_430_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_wind", "")
			end

			local var_433_6 = 0
			local var_433_7 = 1.125

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_6 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, false)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_8 = arg_430_1:FormatText(arg_430_1:GetWordFromCfg(425042105).content)

				arg_430_1.text_.text = var_433_8

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_10 = 45 <= 0 and var_433_7 or var_433_7 * (utf8.len(var_433_8) / 45)

				if (45 <= 0 and var_433_7 or var_433_7 * (utf8.len(var_433_8) / 45)) > 0 and var_433_7 < var_433_10 then
					arg_430_1.talkMaxDuration = var_433_10

					if var_433_10 + var_433_6 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_10 + var_433_6
					end
				end

				arg_430_1.text_.text = var_433_8
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_11 = math.max(var_433_7, arg_430_1.talkMaxDuration)

			if var_433_6 <= arg_430_1.time_ and arg_430_1.time_ < var_433_6 + var_433_11 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_6) / var_433_11

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_6 + var_433_11 and arg_430_1.time_ < var_433_6 + var_433_11 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play425042106 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 425042106
		arg_434_1.duration_ = 1.77

		local var_434_0 = {
			zh = 1.333,
			ja = 1.766
		}
		local var_434_1 = manager.audio:GetLocalizationFlag()

		if var_434_0[var_434_1] ~= nil then
			arg_434_1.duration_ = var_434_0[var_434_1]
		end

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play425042107(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 and not isNil(arg_434_1.actors_["1137"]) and arg_434_1.var_.actorSpriteComps1137 == nil then
				arg_434_1.var_.actorSpriteComps1137 = arg_434_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_437_0 = 0.2

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 and not isNil(arg_434_1.actors_["1137"]) then
				if arg_434_1.var_.actorSpriteComps1137 then
					for iter_437_0, iter_437_1 in pairs(arg_434_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_437_1 then
							if arg_434_1.isInRecall_ then
								iter_437_1.color = Color.New(Mathf.Lerp(iter_437_1.color.r, arg_434_1.hightColor1.r, (arg_434_1.time_ - 0) / var_437_0), Mathf.Lerp(iter_437_1.color.g, arg_434_1.hightColor1.g, (arg_434_1.time_ - 0) / var_437_0), (Mathf.Lerp(iter_437_1.color.b, arg_434_1.hightColor1.b, (arg_434_1.time_ - 0) / var_437_0)))
							else
								local var_437_1 = Mathf.Lerp(iter_437_1.color.r, 1, (arg_434_1.time_ - 0) / var_437_0)

								iter_437_1.color = Color.New(var_437_1, var_437_1, var_437_1)
							end
						end
					end
				end
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 and not isNil(arg_434_1.actors_["1137"]) and arg_434_1.var_.actorSpriteComps1137 then
				for iter_437_2, iter_437_3 in pairs(arg_434_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_437_3 then
						iter_437_3.color = arg_434_1.isInRecall_ and (arg_434_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_434_1.var_.actorSpriteComps1137 = nil
			end

			local var_437_2 = arg_434_1.actors_["1137"].transform

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.var_.moveOldPos1137 = var_437_2.localPosition
				var_437_2.localScale = Vector3.New(1, 1, 1)

				arg_434_1:CheckSpriteTmpPos("1137", 3)

				for iter_437_4 = 0, var_437_2.childCount - 1 do
					local var_437_3 = var_437_2:GetChild(iter_437_4)

					if var_437_3.name == "split_5" or not string.find(var_437_3.name, "split") then
						var_437_3.gameObject:SetActive(true)
					else
						var_437_3.gameObject:SetActive(false)
					end
				end
			end

			local var_437_4 = 0.001

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_4 then
				var_437_2.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1137, Vector3.New(0, -425, -200), (arg_434_1.time_ - 0) / var_437_4)
			end

			if arg_434_1.time_ >= 0 + var_437_4 and arg_434_1.time_ < 0 + var_437_4 + arg_437_0 then
				var_437_2.localPosition = Vector3.New(0, -425, -200)
			end

			local var_437_5 = 0
			local var_437_6 = 0.1

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_5 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				arg_434_1.leftNameTxt_.text = arg_434_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_7 = arg_434_1:GetWordFromCfg(425042106)
				local var_437_8 = arg_434_1:FormatText(var_437_7.content)

				arg_434_1.text_.text = var_437_8

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_10 = 4 <= 0 and var_437_6 or var_437_6 * (utf8.len(var_437_8) / 4)

				if (4 <= 0 and var_437_6 or var_437_6 * (utf8.len(var_437_8) / 4)) > 0 and var_437_6 < var_437_10 then
					arg_434_1.talkMaxDuration = var_437_10

					if var_437_10 + var_437_5 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_10 + var_437_5
					end
				end

				arg_434_1.text_.text = var_437_8
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042106", "story_v_out_425042.awb") ~= 0 then
					local var_437_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042106", "story_v_out_425042.awb") / 1000

					if var_437_11 + var_437_5 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_11 + var_437_5
					end

					if var_437_7.prefab_name ~= "" and arg_434_1.actors_[var_437_7.prefab_name] ~= nil then
						local var_437_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_434_1.actors_[var_437_7.prefab_name].transform, "story_v_out_425042", "425042106", "story_v_out_425042.awb")

						arg_434_1:RecordAudio("425042106", var_437_12)
						arg_434_1:RecordAudio("425042106", var_437_12)
					else
						arg_434_1:AudioAction("play", "voice", "story_v_out_425042", "425042106", "story_v_out_425042.awb")
					end

					arg_434_1:RecordHistoryTalkVoice("story_v_out_425042", "425042106", "story_v_out_425042.awb")
				end

				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_13 = math.max(var_437_6, arg_434_1.talkMaxDuration)

			if var_437_5 <= arg_434_1.time_ and arg_434_1.time_ < var_437_5 + var_437_13 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_5) / var_437_13

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_5 + var_437_13 and arg_434_1.time_ < var_437_5 + var_437_13 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_434_1:InitPlayNodeList()
	end,
	Play425042107 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 425042107
		arg_438_1.duration_ = 4.03

		local var_438_0 = {
			zh = 3.4,
			ja = 4.033
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play425042108(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if arg_438_1.actors_["10157"] == nil then
				local var_441_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10157")

				if not isNil(var_441_0) then
					local var_441_1 = Object.Instantiate(var_441_0, arg_438_1.canvasGo_.transform)

					var_441_1.transform:SetSiblingIndex(1)

					var_441_1.name = "10157"
					var_441_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_438_1.actors_["10157"] = var_441_1

					if arg_438_1.isInRecall_ then
						for iter_441_0, iter_441_1 in ipairs((var_441_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_441_1.color = arg_438_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_441_2 = arg_438_1.actors_["10157"]

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(var_441_2) and arg_438_1.var_.actorSpriteComps10157 == nil then
				arg_438_1.var_.actorSpriteComps10157 = var_441_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_441_3 = 0.2

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_3 and not isNil(var_441_2) then
				if arg_438_1.var_.actorSpriteComps10157 then
					for iter_441_2, iter_441_3 in pairs(arg_438_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_441_3 then
							if arg_438_1.isInRecall_ then
								iter_441_3.color = Color.New(Mathf.Lerp(iter_441_3.color.r, arg_438_1.hightColor1.r, (arg_438_1.time_ - 0) / var_441_3), Mathf.Lerp(iter_441_3.color.g, arg_438_1.hightColor1.g, (arg_438_1.time_ - 0) / var_441_3), (Mathf.Lerp(iter_441_3.color.b, arg_438_1.hightColor1.b, (arg_438_1.time_ - 0) / var_441_3)))
							else
								local var_441_4 = Mathf.Lerp(iter_441_3.color.r, 1, (arg_438_1.time_ - 0) / var_441_3)

								iter_441_3.color = Color.New(var_441_4, var_441_4, var_441_4)
							end
						end
					end
				end
			end

			if arg_438_1.time_ >= 0 + var_441_3 and arg_438_1.time_ < 0 + var_441_3 + arg_441_0 and not isNil(var_441_2) and arg_438_1.var_.actorSpriteComps10157 then
				for iter_441_4, iter_441_5 in pairs(arg_438_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_441_5 then
						iter_441_5.color = arg_438_1.isInRecall_ and (arg_438_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_438_1.var_.actorSpriteComps10157 = nil
			end

			local var_441_5 = arg_438_1.actors_["1137"]

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(var_441_5) and arg_438_1.var_.actorSpriteComps1137 == nil then
				arg_438_1.var_.actorSpriteComps1137 = var_441_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_441_6 = 0.2

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_6 and not isNil(var_441_5) then
				if arg_438_1.var_.actorSpriteComps1137 then
					for iter_441_6, iter_441_7 in pairs(arg_438_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_441_7 then
							if arg_438_1.isInRecall_ then
								iter_441_7.color = Color.New(Mathf.Lerp(iter_441_7.color.r, arg_438_1.hightColor2.r, (arg_438_1.time_ - 0) / var_441_6), Mathf.Lerp(iter_441_7.color.g, arg_438_1.hightColor2.g, (arg_438_1.time_ - 0) / var_441_6), (Mathf.Lerp(iter_441_7.color.b, arg_438_1.hightColor2.b, (arg_438_1.time_ - 0) / var_441_6)))
							else
								local var_441_7 = Mathf.Lerp(iter_441_7.color.r, 0.5, (arg_438_1.time_ - 0) / var_441_6)

								iter_441_7.color = Color.New(var_441_7, var_441_7, var_441_7)
							end
						end
					end
				end
			end

			if arg_438_1.time_ >= 0 + var_441_6 and arg_438_1.time_ < 0 + var_441_6 + arg_441_0 and not isNil(var_441_5) and arg_438_1.var_.actorSpriteComps1137 then
				for iter_441_8, iter_441_9 in pairs(arg_438_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_441_9 then
						iter_441_9.color = arg_438_1.isInRecall_ and (arg_438_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_438_1.var_.actorSpriteComps1137 = nil
			end

			local var_441_8 = arg_438_1.actors_["10157"].transform

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.var_.moveOldPos10157 = var_441_8.localPosition
				var_441_8.localScale = Vector3.New(1, 1, 1)

				arg_438_1:CheckSpriteTmpPos("10157", 4)

				for iter_441_10 = 0, var_441_8.childCount - 1 do
					local var_441_9 = var_441_8:GetChild(iter_441_10)

					if var_441_9.name == "" or not string.find(var_441_9.name, "split") then
						var_441_9.gameObject:SetActive(true)
					else
						var_441_9.gameObject:SetActive(false)
					end
				end
			end

			local var_441_10 = 0.001

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_10 then
				var_441_8.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos10157, Vector3.New(390, -408, 115), (arg_438_1.time_ - 0) / var_441_10)
			end

			if arg_438_1.time_ >= 0 + var_441_10 and arg_438_1.time_ < 0 + var_441_10 + arg_441_0 then
				var_441_8.localPosition = Vector3.New(390, -408, 115)
			end

			local var_441_11 = arg_438_1.actors_["1137"].transform

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.var_.moveOldPos1137 = var_441_11.localPosition
				var_441_11.localScale = Vector3.New(1, 1, 1)

				arg_438_1:CheckSpriteTmpPos("1137", 2)

				for iter_441_11 = 0, var_441_11.childCount - 1 do
					local var_441_12 = var_441_11:GetChild(iter_441_11)

					if var_441_12.name == "split_5" or not string.find(var_441_12.name, "split") then
						var_441_12.gameObject:SetActive(true)
					else
						var_441_12.gameObject:SetActive(false)
					end
				end
			end

			local var_441_13 = 0.001

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_13 then
				var_441_11.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos1137, Vector3.New(-390, -425, -200), (arg_438_1.time_ - 0) / var_441_13)
			end

			if arg_438_1.time_ >= 0 + var_441_13 and arg_438_1.time_ < 0 + var_441_13 + arg_441_0 then
				var_441_11.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_441_14 = 0
			local var_441_15 = 0.3

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_14 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[1434].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_16 = arg_438_1:GetWordFromCfg(425042107)
				local var_441_17 = arg_438_1:FormatText(var_441_16.content)

				arg_438_1.text_.text = var_441_17

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_19 = 12 <= 0 and var_441_15 or var_441_15 * (utf8.len(var_441_17) / 12)

				if (12 <= 0 and var_441_15 or var_441_15 * (utf8.len(var_441_17) / 12)) > 0 and var_441_15 < var_441_19 then
					arg_438_1.talkMaxDuration = var_441_19

					if var_441_19 + var_441_14 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_19 + var_441_14
					end
				end

				arg_438_1.text_.text = var_441_17
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042107", "story_v_out_425042.awb") ~= 0 then
					local var_441_20 = manager.audio:GetVoiceLength("story_v_out_425042", "425042107", "story_v_out_425042.awb") / 1000

					if var_441_20 + var_441_14 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_20 + var_441_14
					end

					if var_441_16.prefab_name ~= "" and arg_438_1.actors_[var_441_16.prefab_name] ~= nil then
						local var_441_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_16.prefab_name].transform, "story_v_out_425042", "425042107", "story_v_out_425042.awb")

						arg_438_1:RecordAudio("425042107", var_441_21)
						arg_438_1:RecordAudio("425042107", var_441_21)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_425042", "425042107", "story_v_out_425042.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_425042", "425042107", "story_v_out_425042.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_22 = math.max(var_441_15, arg_438_1.talkMaxDuration)

			if var_441_14 <= arg_438_1.time_ and arg_438_1.time_ < var_441_14 + var_441_22 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_14) / var_441_22

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_14 + var_441_22 and arg_438_1.time_ < var_441_14 + var_441_22 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_438_1:InitPlayNodeList()
	end,
	Play425042108 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 425042108
		arg_442_1.duration_ = 4.1

		local var_442_0 = {
			zh = 2.4,
			ja = 4.1
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play425042109(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(arg_442_1.actors_["1137"]) and arg_442_1.var_.actorSpriteComps1137 == nil then
				arg_442_1.var_.actorSpriteComps1137 = arg_442_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_445_0 = 0.2

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_0 and not isNil(arg_442_1.actors_["1137"]) then
				if arg_442_1.var_.actorSpriteComps1137 then
					for iter_445_0, iter_445_1 in pairs(arg_442_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_445_1 then
							if arg_442_1.isInRecall_ then
								iter_445_1.color = Color.New(Mathf.Lerp(iter_445_1.color.r, arg_442_1.hightColor1.r, (arg_442_1.time_ - 0) / var_445_0), Mathf.Lerp(iter_445_1.color.g, arg_442_1.hightColor1.g, (arg_442_1.time_ - 0) / var_445_0), (Mathf.Lerp(iter_445_1.color.b, arg_442_1.hightColor1.b, (arg_442_1.time_ - 0) / var_445_0)))
							else
								local var_445_1 = Mathf.Lerp(iter_445_1.color.r, 1, (arg_442_1.time_ - 0) / var_445_0)

								iter_445_1.color = Color.New(var_445_1, var_445_1, var_445_1)
							end
						end
					end
				end
			end

			if arg_442_1.time_ >= 0 + var_445_0 and arg_442_1.time_ < 0 + var_445_0 + arg_445_0 and not isNil(arg_442_1.actors_["1137"]) and arg_442_1.var_.actorSpriteComps1137 then
				for iter_445_2, iter_445_3 in pairs(arg_442_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_445_3 then
						iter_445_3.color = arg_442_1.isInRecall_ and (arg_442_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_442_1.var_.actorSpriteComps1137 = nil
			end

			local var_445_2 = arg_442_1.actors_["10157"]

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(var_445_2) and arg_442_1.var_.actorSpriteComps10157 == nil then
				arg_442_1.var_.actorSpriteComps10157 = var_445_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_445_3 = 0.2

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_3 and not isNil(var_445_2) then
				if arg_442_1.var_.actorSpriteComps10157 then
					for iter_445_4, iter_445_5 in pairs(arg_442_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_445_5 then
							if arg_442_1.isInRecall_ then
								iter_445_5.color = Color.New(Mathf.Lerp(iter_445_5.color.r, arg_442_1.hightColor2.r, (arg_442_1.time_ - 0) / var_445_3), Mathf.Lerp(iter_445_5.color.g, arg_442_1.hightColor2.g, (arg_442_1.time_ - 0) / var_445_3), (Mathf.Lerp(iter_445_5.color.b, arg_442_1.hightColor2.b, (arg_442_1.time_ - 0) / var_445_3)))
							else
								local var_445_4 = Mathf.Lerp(iter_445_5.color.r, 0.5, (arg_442_1.time_ - 0) / var_445_3)

								iter_445_5.color = Color.New(var_445_4, var_445_4, var_445_4)
							end
						end
					end
				end
			end

			if arg_442_1.time_ >= 0 + var_445_3 and arg_442_1.time_ < 0 + var_445_3 + arg_445_0 and not isNil(var_445_2) and arg_442_1.var_.actorSpriteComps10157 then
				for iter_445_6, iter_445_7 in pairs(arg_442_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_445_7 then
						iter_445_7.color = arg_442_1.isInRecall_ and (arg_442_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_442_1.var_.actorSpriteComps10157 = nil
			end

			local var_445_5 = arg_442_1.actors_["1137"].transform

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.var_.moveOldPos1137 = var_445_5.localPosition
				var_445_5.localScale = Vector3.New(1, 1, 1)

				arg_442_1:CheckSpriteTmpPos("1137", 2)

				for iter_445_8 = 0, var_445_5.childCount - 1 do
					local var_445_6 = var_445_5:GetChild(iter_445_8)

					if var_445_6.name == "split_5" or not string.find(var_445_6.name, "split") then
						var_445_6.gameObject:SetActive(true)
					else
						var_445_6.gameObject:SetActive(false)
					end
				end
			end

			local var_445_7 = 0.001

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_7 then
				var_445_5.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos1137, Vector3.New(-390, -425, -200), (arg_442_1.time_ - 0) / var_445_7)
			end

			if arg_442_1.time_ >= 0 + var_445_7 and arg_442_1.time_ < 0 + var_445_7 + arg_445_0 then
				var_445_5.localPosition = Vector3.New(-390, -425, -200)
			end

			local var_445_8 = 0
			local var_445_9 = 0.175

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_8 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_10 = arg_442_1:GetWordFromCfg(425042108)
				local var_445_11 = arg_442_1:FormatText(var_445_10.content)

				arg_442_1.text_.text = var_445_11

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_13 = 7 <= 0 and var_445_9 or var_445_9 * (utf8.len(var_445_11) / 7)

				if (7 <= 0 and var_445_9 or var_445_9 * (utf8.len(var_445_11) / 7)) > 0 and var_445_9 < var_445_13 then
					arg_442_1.talkMaxDuration = var_445_13

					if var_445_13 + var_445_8 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_13 + var_445_8
					end
				end

				arg_442_1.text_.text = var_445_11
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042108", "story_v_out_425042.awb") ~= 0 then
					local var_445_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042108", "story_v_out_425042.awb") / 1000

					if var_445_14 + var_445_8 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_14 + var_445_8
					end

					if var_445_10.prefab_name ~= "" and arg_442_1.actors_[var_445_10.prefab_name] ~= nil then
						local var_445_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_10.prefab_name].transform, "story_v_out_425042", "425042108", "story_v_out_425042.awb")

						arg_442_1:RecordAudio("425042108", var_445_15)
						arg_442_1:RecordAudio("425042108", var_445_15)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_425042", "425042108", "story_v_out_425042.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_425042", "425042108", "story_v_out_425042.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_16 = math.max(var_445_9, arg_442_1.talkMaxDuration)

			if var_445_8 <= arg_442_1.time_ and arg_442_1.time_ < var_445_8 + var_445_16 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_8) / var_445_16

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_8 + var_445_16 and arg_442_1.time_ < var_445_8 + var_445_16 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_442_1:InitPlayNodeList()
	end,
	Play425042109 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 425042109
		arg_446_1.duration_ = 10.9

		local var_446_0 = {
			zh = 4.933,
			ja = 10.9
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play425042110(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(arg_446_1.actors_["10157"]) and arg_446_1.var_.actorSpriteComps10157 == nil then
				arg_446_1.var_.actorSpriteComps10157 = arg_446_1.actors_["10157"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_449_0 = 0.2

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_0 and not isNil(arg_446_1.actors_["10157"]) then
				if arg_446_1.var_.actorSpriteComps10157 then
					for iter_449_0, iter_449_1 in pairs(arg_446_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_449_1 then
							if arg_446_1.isInRecall_ then
								iter_449_1.color = Color.New(Mathf.Lerp(iter_449_1.color.r, arg_446_1.hightColor1.r, (arg_446_1.time_ - 0) / var_449_0), Mathf.Lerp(iter_449_1.color.g, arg_446_1.hightColor1.g, (arg_446_1.time_ - 0) / var_449_0), (Mathf.Lerp(iter_449_1.color.b, arg_446_1.hightColor1.b, (arg_446_1.time_ - 0) / var_449_0)))
							else
								local var_449_1 = Mathf.Lerp(iter_449_1.color.r, 1, (arg_446_1.time_ - 0) / var_449_0)

								iter_449_1.color = Color.New(var_449_1, var_449_1, var_449_1)
							end
						end
					end
				end
			end

			if arg_446_1.time_ >= 0 + var_449_0 and arg_446_1.time_ < 0 + var_449_0 + arg_449_0 and not isNil(arg_446_1.actors_["10157"]) and arg_446_1.var_.actorSpriteComps10157 then
				for iter_449_2, iter_449_3 in pairs(arg_446_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_449_3 then
						iter_449_3.color = arg_446_1.isInRecall_ and (arg_446_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_446_1.var_.actorSpriteComps10157 = nil
			end

			local var_449_2 = arg_446_1.actors_["1137"]

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(var_449_2) and arg_446_1.var_.actorSpriteComps1137 == nil then
				arg_446_1.var_.actorSpriteComps1137 = var_449_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_449_3 = 0.2

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_3 and not isNil(var_449_2) then
				if arg_446_1.var_.actorSpriteComps1137 then
					for iter_449_4, iter_449_5 in pairs(arg_446_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_449_5 then
							if arg_446_1.isInRecall_ then
								iter_449_5.color = Color.New(Mathf.Lerp(iter_449_5.color.r, arg_446_1.hightColor2.r, (arg_446_1.time_ - 0) / var_449_3), Mathf.Lerp(iter_449_5.color.g, arg_446_1.hightColor2.g, (arg_446_1.time_ - 0) / var_449_3), (Mathf.Lerp(iter_449_5.color.b, arg_446_1.hightColor2.b, (arg_446_1.time_ - 0) / var_449_3)))
							else
								local var_449_4 = Mathf.Lerp(iter_449_5.color.r, 0.5, (arg_446_1.time_ - 0) / var_449_3)

								iter_449_5.color = Color.New(var_449_4, var_449_4, var_449_4)
							end
						end
					end
				end
			end

			if arg_446_1.time_ >= 0 + var_449_3 and arg_446_1.time_ < 0 + var_449_3 + arg_449_0 and not isNil(var_449_2) and arg_446_1.var_.actorSpriteComps1137 then
				for iter_449_6, iter_449_7 in pairs(arg_446_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_449_7 then
						iter_449_7.color = arg_446_1.isInRecall_ and (arg_446_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_446_1.var_.actorSpriteComps1137 = nil
			end

			local var_449_5 = arg_446_1.actors_["10157"].transform

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1.var_.moveOldPos10157 = var_449_5.localPosition
				var_449_5.localScale = Vector3.New(1, 1, 1)

				arg_446_1:CheckSpriteTmpPos("10157", 4)

				for iter_449_8 = 0, var_449_5.childCount - 1 do
					local var_449_6 = var_449_5:GetChild(iter_449_8)

					if var_449_6.name == "split_4" or not string.find(var_449_6.name, "split") then
						var_449_6.gameObject:SetActive(true)
					else
						var_449_6.gameObject:SetActive(false)
					end
				end
			end

			local var_449_7 = 0.001

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_7 then
				var_449_5.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos10157, Vector3.New(390, -408, 115), (arg_446_1.time_ - 0) / var_449_7)
			end

			if arg_446_1.time_ >= 0 + var_449_7 and arg_446_1.time_ < 0 + var_449_7 + arg_449_0 then
				var_449_5.localPosition = Vector3.New(390, -408, 115)
			end

			local var_449_8 = 0
			local var_449_9 = 0.425

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_8 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[1434].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_10 = arg_446_1:GetWordFromCfg(425042109)
				local var_449_11 = arg_446_1:FormatText(var_449_10.content)

				arg_446_1.text_.text = var_449_11

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_13 = 17 <= 0 and var_449_9 or var_449_9 * (utf8.len(var_449_11) / 17)

				if (17 <= 0 and var_449_9 or var_449_9 * (utf8.len(var_449_11) / 17)) > 0 and var_449_9 < var_449_13 then
					arg_446_1.talkMaxDuration = var_449_13

					if var_449_13 + var_449_8 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_13 + var_449_8
					end
				end

				arg_446_1.text_.text = var_449_11
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042109", "story_v_out_425042.awb") ~= 0 then
					local var_449_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042109", "story_v_out_425042.awb") / 1000

					if var_449_14 + var_449_8 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_14 + var_449_8
					end

					if var_449_10.prefab_name ~= "" and arg_446_1.actors_[var_449_10.prefab_name] ~= nil then
						local var_449_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_10.prefab_name].transform, "story_v_out_425042", "425042109", "story_v_out_425042.awb")

						arg_446_1:RecordAudio("425042109", var_449_15)
						arg_446_1:RecordAudio("425042109", var_449_15)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_425042", "425042109", "story_v_out_425042.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_425042", "425042109", "story_v_out_425042.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_16 = math.max(var_449_9, arg_446_1.talkMaxDuration)

			if var_449_8 <= arg_446_1.time_ and arg_446_1.time_ < var_449_8 + var_449_16 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_8) / var_449_16

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_8 + var_449_16 and arg_446_1.time_ < var_449_8 + var_449_16 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	Play425042110 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 425042110
		arg_450_1.duration_ = 5.57

		local var_450_0 = {
			zh = 5.333,
			ja = 5.566
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play425042111(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(arg_450_1.actors_["1137"]) and arg_450_1.var_.actorSpriteComps1137 == nil then
				arg_450_1.var_.actorSpriteComps1137 = arg_450_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_453_0 = 0.2

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_0 and not isNil(arg_450_1.actors_["1137"]) then
				if arg_450_1.var_.actorSpriteComps1137 then
					for iter_453_0, iter_453_1 in pairs(arg_450_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_453_1 then
							if arg_450_1.isInRecall_ then
								iter_453_1.color = Color.New(Mathf.Lerp(iter_453_1.color.r, arg_450_1.hightColor1.r, (arg_450_1.time_ - 0) / var_453_0), Mathf.Lerp(iter_453_1.color.g, arg_450_1.hightColor1.g, (arg_450_1.time_ - 0) / var_453_0), (Mathf.Lerp(iter_453_1.color.b, arg_450_1.hightColor1.b, (arg_450_1.time_ - 0) / var_453_0)))
							else
								local var_453_1 = Mathf.Lerp(iter_453_1.color.r, 1, (arg_450_1.time_ - 0) / var_453_0)

								iter_453_1.color = Color.New(var_453_1, var_453_1, var_453_1)
							end
						end
					end
				end
			end

			if arg_450_1.time_ >= 0 + var_453_0 and arg_450_1.time_ < 0 + var_453_0 + arg_453_0 and not isNil(arg_450_1.actors_["1137"]) and arg_450_1.var_.actorSpriteComps1137 then
				for iter_453_2, iter_453_3 in pairs(arg_450_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_453_3 then
						iter_453_3.color = arg_450_1.isInRecall_ and (arg_450_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_450_1.var_.actorSpriteComps1137 = nil
			end

			local var_453_2 = arg_450_1.actors_["10157"]

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(var_453_2) and arg_450_1.var_.actorSpriteComps10157 == nil then
				arg_450_1.var_.actorSpriteComps10157 = var_453_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_453_3 = 0.2

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_3 and not isNil(var_453_2) then
				if arg_450_1.var_.actorSpriteComps10157 then
					for iter_453_4, iter_453_5 in pairs(arg_450_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_453_5 then
							if arg_450_1.isInRecall_ then
								iter_453_5.color = Color.New(Mathf.Lerp(iter_453_5.color.r, arg_450_1.hightColor2.r, (arg_450_1.time_ - 0) / var_453_3), Mathf.Lerp(iter_453_5.color.g, arg_450_1.hightColor2.g, (arg_450_1.time_ - 0) / var_453_3), (Mathf.Lerp(iter_453_5.color.b, arg_450_1.hightColor2.b, (arg_450_1.time_ - 0) / var_453_3)))
							else
								local var_453_4 = Mathf.Lerp(iter_453_5.color.r, 0.5, (arg_450_1.time_ - 0) / var_453_3)

								iter_453_5.color = Color.New(var_453_4, var_453_4, var_453_4)
							end
						end
					end
				end
			end

			if arg_450_1.time_ >= 0 + var_453_3 and arg_450_1.time_ < 0 + var_453_3 + arg_453_0 and not isNil(var_453_2) and arg_450_1.var_.actorSpriteComps10157 then
				for iter_453_6, iter_453_7 in pairs(arg_450_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_453_7 then
						iter_453_7.color = arg_450_1.isInRecall_ and (arg_450_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_450_1.var_.actorSpriteComps10157 = nil
			end

			local var_453_5 = arg_450_1.actors_["1137"].transform

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.var_.moveOldPos1137 = var_453_5.localPosition
				var_453_5.localScale = Vector3.New(1, 1, 1)

				arg_450_1:CheckSpriteTmpPos("1137", 2)

				for iter_453_8 = 0, var_453_5.childCount - 1 do
					local var_453_6 = var_453_5:GetChild(iter_453_8)

					if var_453_6.name == "split_4" then
						var_453_6:SetAsLastSibling()
						var_453_6.gameObject:SetActive(true)

						arg_450_1.var_.actorSpriteSplit1137 = var_453_6.gameObject:GetComponent(typeof(Image))

						arg_450_1.var_.actorSpriteSplit1137:SetAlpha(0)
					end
				end
			end

			local var_453_7 = 0.5

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_7 then
				var_453_5.localPosition = Vector3.Lerp(arg_450_1.var_.moveOldPos1137, Vector3.New(-390, -425, -200), (arg_450_1.time_ - 0) / var_453_7)

				if arg_450_1.var_.actorSpriteSplit1137 ~= nil then
					arg_450_1.var_.actorSpriteSplit1137:SetAlpha((arg_450_1.time_ - 0) / var_453_7)
				end
			end

			if arg_450_1.time_ >= 0 + var_453_7 and arg_450_1.time_ < 0 + var_453_7 + arg_453_0 then
				var_453_5.localPosition = Vector3.New(-390, -425, -200)

				if arg_450_1.var_.actorSpriteSplit1137 ~= nil then
					arg_450_1.var_.actorSpriteSplit1137:SetAlpha(1)
				end
			end

			local var_453_8 = 0
			local var_453_9 = 0.425

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_8 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_10 = arg_450_1:GetWordFromCfg(425042110)
				local var_453_11 = arg_450_1:FormatText(var_453_10.content)

				arg_450_1.text_.text = var_453_11

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_13 = 17 <= 0 and var_453_9 or var_453_9 * (utf8.len(var_453_11) / 17)

				if (17 <= 0 and var_453_9 or var_453_9 * (utf8.len(var_453_11) / 17)) > 0 and var_453_9 < var_453_13 then
					arg_450_1.talkMaxDuration = var_453_13

					if var_453_13 + var_453_8 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_13 + var_453_8
					end
				end

				arg_450_1.text_.text = var_453_11
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042110", "story_v_out_425042.awb") ~= 0 then
					local var_453_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042110", "story_v_out_425042.awb") / 1000

					if var_453_14 + var_453_8 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_14 + var_453_8
					end

					if var_453_10.prefab_name ~= "" and arg_450_1.actors_[var_453_10.prefab_name] ~= nil then
						local var_453_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_10.prefab_name].transform, "story_v_out_425042", "425042110", "story_v_out_425042.awb")

						arg_450_1:RecordAudio("425042110", var_453_15)
						arg_450_1:RecordAudio("425042110", var_453_15)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_425042", "425042110", "story_v_out_425042.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_425042", "425042110", "story_v_out_425042.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_16 = math.max(var_453_9, arg_450_1.talkMaxDuration)

			if var_453_8 <= arg_450_1.time_ and arg_450_1.time_ < var_453_8 + var_453_16 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_8) / var_453_16

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_8 + var_453_16 and arg_450_1.time_ < var_453_8 + var_453_16 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_450_1:InitPlayNodeList()
	end,
	Play425042111 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 425042111
		arg_454_1.duration_ = 4.9

		local var_454_0 = {
			zh = 3.533,
			ja = 4.9
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play425042112(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = 0.25

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_1 = arg_454_1:GetWordFromCfg(425042111)
				local var_457_2 = arg_454_1:FormatText(var_457_1.content)

				arg_454_1.text_.text = var_457_2

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_4 = 10 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_2) / 10)

				if (10 <= 0 and var_457_0 or var_457_0 * (utf8.len(var_457_2) / 10)) > 0 and var_457_0 < var_457_4 then
					arg_454_1.talkMaxDuration = var_457_4

					if var_457_4 + 0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_4 + 0
					end
				end

				arg_454_1.text_.text = var_457_2
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042111", "story_v_out_425042.awb") ~= 0 then
					local var_457_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042111", "story_v_out_425042.awb") / 1000

					if var_457_5 + 0 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_5 + 0
					end

					if var_457_1.prefab_name ~= "" and arg_454_1.actors_[var_457_1.prefab_name] ~= nil then
						local var_457_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_1.prefab_name].transform, "story_v_out_425042", "425042111", "story_v_out_425042.awb")

						arg_454_1:RecordAudio("425042111", var_457_6)
						arg_454_1:RecordAudio("425042111", var_457_6)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_425042", "425042111", "story_v_out_425042.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_425042", "425042111", "story_v_out_425042.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_7 = math.max(var_457_0, arg_454_1.talkMaxDuration)

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_7 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - 0) / var_457_7

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= 0 + var_457_7 and arg_454_1.time_ < 0 + var_457_7 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play425042112 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 425042112
		arg_458_1.duration_ = 7

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play425042113(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 1 < arg_458_1.time_ and arg_458_1.time_ <= 1 + arg_461_0 then
				local var_461_0 = arg_458_1.bgs_.ST2402

				arg_458_1.bgs_.ST2402.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_461_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_461_1 = var_461_0:GetComponent("SpriteRenderer")

				if var_461_1 and var_461_1.sprite then
					local var_461_2 = 2 * (var_461_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_461_0.transform.localScale = Vector3.New(var_461_2 / var_461_1.sprite.bounds.size.y < var_461_2 * manager.ui.mainCameraCom_.aspect / var_461_1.sprite.bounds.size.x and var_461_2 * manager.ui.mainCameraCom_.aspect / var_461_1.sprite.bounds.size.x or var_461_2 / var_461_1.sprite.bounds.size.y, var_461_2 / var_461_1.sprite.bounds.size.y < var_461_2 * manager.ui.mainCameraCom_.aspect / var_461_1.sprite.bounds.size.x and var_461_2 * manager.ui.mainCameraCom_.aspect / var_461_1.sprite.bounds.size.x or var_461_2 / var_461_1.sprite.bounds.size.y, 0)
				end

				for iter_461_0, iter_461_1 in pairs(arg_458_1.bgs_) do
					if iter_461_0 ~= "ST2402" then
						iter_461_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_461_3 = 2

			if 2 < arg_458_1.time_ and arg_458_1.time_ <= var_461_3 + arg_461_0 then
				arg_458_1.allBtn_.enabled = false
			end

			if arg_458_1.time_ >= var_461_3 + 0.3 and arg_458_1.time_ < var_461_3 + 0.3 + arg_461_0 then
				arg_458_1.allBtn_.enabled = true
			end

			local var_461_4 = 0

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_4 + arg_461_0 then
				arg_458_1.mask_.enabled = true
				arg_458_1.mask_.raycastTarget = true

				arg_458_1:SetGaussion(false)
			end

			local var_461_5 = 1

			if var_461_4 <= arg_458_1.time_ and arg_458_1.time_ < var_461_4 + var_461_5 then
				local var_461_6 = Color.New(0, 0, 0)

				var_461_6.a = Mathf.Lerp(0, 1, (arg_458_1.time_ - var_461_4) / var_461_5)
				arg_458_1.mask_.color = var_461_6
			end

			if arg_458_1.time_ >= var_461_4 + var_461_5 and arg_458_1.time_ < var_461_4 + var_461_5 + arg_461_0 then
				local var_461_7 = Color.New(0, 0, 0)

				var_461_7.a = 1
				arg_458_1.mask_.color = var_461_7
			end

			local var_461_8 = 1

			if 1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_8 + arg_461_0 then
				arg_458_1.mask_.enabled = true
				arg_458_1.mask_.raycastTarget = true

				arg_458_1:SetGaussion(false)
			end

			local var_461_9 = 1

			if var_461_8 <= arg_458_1.time_ and arg_458_1.time_ < var_461_8 + var_461_9 then
				local var_461_10 = Color.New(0, 0, 0)

				var_461_10.a = Mathf.Lerp(1, 0, (arg_458_1.time_ - var_461_8) / var_461_9)
				arg_458_1.mask_.color = var_461_10
			end

			if arg_458_1.time_ >= var_461_8 + var_461_9 and arg_458_1.time_ < var_461_8 + var_461_9 + arg_461_0 then
				local var_461_11 = Color.New(0, 0, 0)

				arg_458_1.mask_.enabled = false
				var_461_11.a = 0
				arg_458_1.mask_.color = var_461_11
			end

			local var_461_12 = arg_458_1.actors_["10157"].transform

			if 1 < arg_458_1.time_ and arg_458_1.time_ <= 1 + arg_461_0 then
				arg_458_1.var_.moveOldPos10157 = var_461_12.localPosition
				var_461_12.localScale = Vector3.New(1, 1, 1)

				arg_458_1:CheckSpriteTmpPos("10157", 7)

				for iter_461_2 = 0, var_461_12.childCount - 1 do
					local var_461_13 = var_461_12:GetChild(iter_461_2)

					if var_461_13.name == "" or not string.find(var_461_13.name, "split") then
						var_461_13.gameObject:SetActive(true)
					else
						var_461_13.gameObject:SetActive(false)
					end
				end
			end

			local var_461_14 = 0.001

			if 1 <= arg_458_1.time_ and arg_458_1.time_ < 1 + var_461_14 then
				var_461_12.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos10157, Vector3.New(0, -2000, 0), (arg_458_1.time_ - 1) / var_461_14)
			end

			if arg_458_1.time_ >= 1 + var_461_14 and arg_458_1.time_ < 1 + var_461_14 + arg_461_0 then
				var_461_12.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_461_15 = arg_458_1.actors_["1137"].transform

			if 1 < arg_458_1.time_ and arg_458_1.time_ <= 1 + arg_461_0 then
				arg_458_1.var_.moveOldPos1137 = var_461_15.localPosition
				var_461_15.localScale = Vector3.New(1, 1, 1)

				arg_458_1:CheckSpriteTmpPos("1137", 7)

				for iter_461_3 = 0, var_461_15.childCount - 1 do
					local var_461_16 = var_461_15:GetChild(iter_461_3)

					if var_461_16.name == "" or not string.find(var_461_16.name, "split") then
						var_461_16.gameObject:SetActive(true)
					else
						var_461_16.gameObject:SetActive(false)
					end
				end
			end

			local var_461_17 = 0.001

			if 1 <= arg_458_1.time_ and arg_458_1.time_ < 1 + var_461_17 then
				var_461_15.localPosition = Vector3.Lerp(arg_458_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_458_1.time_ - 1) / var_461_17)
			end

			if arg_458_1.time_ >= 1 + var_461_17 and arg_458_1.time_ < 1 + var_461_17 + arg_461_0 then
				var_461_15.localPosition = Vector3.New(0, -2000, 0)
			end

			if arg_458_1.frameCnt_ <= 1 then
				arg_458_1.dialog_:SetActive(false)
			end

			local var_461_18 = 2
			local var_461_19 = 0.325

			if 2 < arg_458_1.time_ and arg_458_1.time_ <= var_461_18 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0

				arg_458_1.dialog_:SetActive(true)

				arg_458_1.dialogCg_.alpha = 0

				local var_461_20 = LeanTween.value(arg_458_1.dialog_, 0, 1, 0.3)

				var_461_20:setOnUpdate(LuaHelper.FloatAction(function(arg_462_0)
					arg_458_1.dialogCg_.alpha = arg_462_0
				end))
				var_461_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_458_1.dialog_)
					var_461_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_458_1.duration_ = arg_458_1.duration_ + 0.3

				SetActive(arg_458_1.leftNameGo_, true)

				arg_458_1.leftNameTxt_.text = arg_458_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_458_1.leftNameTxt_.transform)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1.leftNameTxt_.text)
				SetActive(arg_458_1.iconTrs_.gameObject, true)
				arg_458_1.iconController_:SetSelectedState("hero")

				arg_458_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_458_1.callingController_:SetSelectedState("normal")

				arg_458_1.keyicon_.color = Color.New(1, 1, 1)
				arg_458_1.icon_.color = Color.New(1, 1, 1)

				local var_461_21 = arg_458_1:FormatText(arg_458_1:GetWordFromCfg(425042112).content)

				arg_458_1.text_.text = var_461_21

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_23 = 13 <= 0 and var_461_19 or var_461_19 * (utf8.len(var_461_21) / 13)

				if (13 <= 0 and var_461_19 or var_461_19 * (utf8.len(var_461_21) / 13)) > 0 and var_461_19 < var_461_23 then
					arg_458_1.talkMaxDuration = var_461_23
					var_461_18 = var_461_18 + 0.3

					if var_461_23 + var_461_18 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_23 + var_461_18
					end
				end

				arg_458_1.text_.text = var_461_21
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_24 = var_461_18 + 0.3
			local var_461_25 = math.max(var_461_19, arg_458_1.talkMaxDuration)

			if var_461_18 + 0.3 <= arg_458_1.time_ and arg_458_1.time_ < var_461_24 + var_461_25 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_24) / var_461_25

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_24 + var_461_25 and arg_458_1.time_ < var_461_24 + var_461_25 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_458_1:InitPlayNodeList()
	end,
	Play425042113 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 425042113
		arg_464_1.duration_ = 5.3

		local var_464_0 = {
			zh = 4.7,
			ja = 5.3
		}
		local var_464_1 = manager.audio:GetLocalizationFlag()

		if var_464_0[var_464_1] ~= nil then
			arg_464_1.duration_ = var_464_0[var_464_1]
		end

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
		end

		function arg_464_1.playNext_(arg_466_0)
			if arg_466_0 == 1 then
				arg_464_0:Play425042114(arg_464_1)
			end
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 and not isNil(arg_464_1.actors_["1137"]) and arg_464_1.var_.actorSpriteComps1137 == nil then
				arg_464_1.var_.actorSpriteComps1137 = arg_464_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_467_0 = 0.2

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_0 and not isNil(arg_464_1.actors_["1137"]) then
				if arg_464_1.var_.actorSpriteComps1137 then
					for iter_467_0, iter_467_1 in pairs(arg_464_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_467_1 then
							if arg_464_1.isInRecall_ then
								iter_467_1.color = Color.New(Mathf.Lerp(iter_467_1.color.r, arg_464_1.hightColor1.r, (arg_464_1.time_ - 0) / var_467_0), Mathf.Lerp(iter_467_1.color.g, arg_464_1.hightColor1.g, (arg_464_1.time_ - 0) / var_467_0), (Mathf.Lerp(iter_467_1.color.b, arg_464_1.hightColor1.b, (arg_464_1.time_ - 0) / var_467_0)))
							else
								local var_467_1 = Mathf.Lerp(iter_467_1.color.r, 1, (arg_464_1.time_ - 0) / var_467_0)

								iter_467_1.color = Color.New(var_467_1, var_467_1, var_467_1)
							end
						end
					end
				end
			end

			if arg_464_1.time_ >= 0 + var_467_0 and arg_464_1.time_ < 0 + var_467_0 + arg_467_0 and not isNil(arg_464_1.actors_["1137"]) and arg_464_1.var_.actorSpriteComps1137 then
				for iter_467_2, iter_467_3 in pairs(arg_464_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_467_3 then
						iter_467_3.color = arg_464_1.isInRecall_ and (arg_464_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_464_1.var_.actorSpriteComps1137 = nil
			end

			local var_467_2 = arg_464_1.actors_["1137"].transform

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= 0 + arg_467_0 then
				arg_464_1.var_.moveOldPos1137 = var_467_2.localPosition
				var_467_2.localScale = Vector3.New(1, 1, 1)

				arg_464_1:CheckSpriteTmpPos("1137", 3)

				for iter_467_4 = 0, var_467_2.childCount - 1 do
					local var_467_3 = var_467_2:GetChild(iter_467_4)

					if var_467_3.name == "split_4" or not string.find(var_467_3.name, "split") then
						var_467_3.gameObject:SetActive(true)
					else
						var_467_3.gameObject:SetActive(false)
					end
				end
			end

			local var_467_4 = 0.001

			if 0 <= arg_464_1.time_ and arg_464_1.time_ < 0 + var_467_4 then
				var_467_2.localPosition = Vector3.Lerp(arg_464_1.var_.moveOldPos1137, Vector3.New(0, -425, -200), (arg_464_1.time_ - 0) / var_467_4)
			end

			if arg_464_1.time_ >= 0 + var_467_4 and arg_464_1.time_ < 0 + var_467_4 + arg_467_0 then
				var_467_2.localPosition = Vector3.New(0, -425, -200)
			end

			local var_467_5 = 0
			local var_467_6 = 0.4

			if 0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_5 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, true)

				arg_464_1.leftNameTxt_.text = arg_464_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_464_1.leftNameTxt_.transform)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1.leftNameTxt_.text)
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_7 = arg_464_1:GetWordFromCfg(425042113)
				local var_467_8 = arg_464_1:FormatText(var_467_7.content)

				arg_464_1.text_.text = var_467_8

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_10 = 16 <= 0 and var_467_6 or var_467_6 * (utf8.len(var_467_8) / 16)

				if (16 <= 0 and var_467_6 or var_467_6 * (utf8.len(var_467_8) / 16)) > 0 and var_467_6 < var_467_10 then
					arg_464_1.talkMaxDuration = var_467_10

					if var_467_10 + var_467_5 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_10 + var_467_5
					end
				end

				arg_464_1.text_.text = var_467_8
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042113", "story_v_out_425042.awb") ~= 0 then
					local var_467_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042113", "story_v_out_425042.awb") / 1000

					if var_467_11 + var_467_5 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_11 + var_467_5
					end

					if var_467_7.prefab_name ~= "" and arg_464_1.actors_[var_467_7.prefab_name] ~= nil then
						local var_467_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_464_1.actors_[var_467_7.prefab_name].transform, "story_v_out_425042", "425042113", "story_v_out_425042.awb")

						arg_464_1:RecordAudio("425042113", var_467_12)
						arg_464_1:RecordAudio("425042113", var_467_12)
					else
						arg_464_1:AudioAction("play", "voice", "story_v_out_425042", "425042113", "story_v_out_425042.awb")
					end

					arg_464_1:RecordHistoryTalkVoice("story_v_out_425042", "425042113", "story_v_out_425042.awb")
				end

				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_13 = math.max(var_467_6, arg_464_1.talkMaxDuration)

			if var_467_5 <= arg_464_1.time_ and arg_464_1.time_ < var_467_5 + var_467_13 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_5) / var_467_13

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_5 + var_467_13 and arg_464_1.time_ < var_467_5 + var_467_13 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_464_1:InitPlayNodeList()
	end,
	Play425042114 = function(arg_468_0, arg_468_1)
		arg_468_1.time_ = 0
		arg_468_1.frameCnt_ = 0
		arg_468_1.state_ = "playing"
		arg_468_1.curTalkId_ = 425042114
		arg_468_1.duration_ = 5

		SetActive(arg_468_1.tipsGo_, false)

		function arg_468_1.onSingleLineFinish_()
			arg_468_1.onSingleLineUpdate_ = nil
			arg_468_1.onSingleLineFinish_ = nil
			arg_468_1.state_ = "waiting"
		end

		function arg_468_1.playNext_(arg_470_0)
			if arg_470_0 == 1 then
				arg_468_0:Play425042115(arg_468_1)
			end
		end

		function arg_468_1.onSingleLineUpdate_(arg_471_0)
			if 0 < arg_468_1.time_ and arg_468_1.time_ <= 0 + arg_471_0 and not isNil(arg_468_1.actors_["1137"]) and arg_468_1.var_.actorSpriteComps1137 == nil then
				arg_468_1.var_.actorSpriteComps1137 = arg_468_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_471_0 = 0.2

			if 0 <= arg_468_1.time_ and arg_468_1.time_ < 0 + var_471_0 and not isNil(arg_468_1.actors_["1137"]) then
				if arg_468_1.var_.actorSpriteComps1137 then
					for iter_471_0, iter_471_1 in pairs(arg_468_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_471_1 then
							if arg_468_1.isInRecall_ then
								iter_471_1.color = Color.New(Mathf.Lerp(iter_471_1.color.r, arg_468_1.hightColor2.r, (arg_468_1.time_ - 0) / var_471_0), Mathf.Lerp(iter_471_1.color.g, arg_468_1.hightColor2.g, (arg_468_1.time_ - 0) / var_471_0), (Mathf.Lerp(iter_471_1.color.b, arg_468_1.hightColor2.b, (arg_468_1.time_ - 0) / var_471_0)))
							else
								local var_471_1 = Mathf.Lerp(iter_471_1.color.r, 0.5, (arg_468_1.time_ - 0) / var_471_0)

								iter_471_1.color = Color.New(var_471_1, var_471_1, var_471_1)
							end
						end
					end
				end
			end

			if arg_468_1.time_ >= 0 + var_471_0 and arg_468_1.time_ < 0 + var_471_0 + arg_471_0 and not isNil(arg_468_1.actors_["1137"]) and arg_468_1.var_.actorSpriteComps1137 then
				for iter_471_2, iter_471_3 in pairs(arg_468_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_471_3 then
						iter_471_3.color = arg_468_1.isInRecall_ and (arg_468_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_468_1.var_.actorSpriteComps1137 = nil
			end

			local var_471_2 = 0
			local var_471_3 = 0.375

			if 0 < arg_468_1.time_ and arg_468_1.time_ <= var_471_2 + arg_471_0 then
				arg_468_1.talkMaxDuration = 0
				arg_468_1.dialogCg_.alpha = 1

				arg_468_1.dialog_:SetActive(true)
				SetActive(arg_468_1.leftNameGo_, true)

				arg_468_1.leftNameTxt_.text = arg_468_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_468_1.leftNameTxt_.transform)

				arg_468_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_468_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_468_1:RecordName(arg_468_1.leftNameTxt_.text)
				SetActive(arg_468_1.iconTrs_.gameObject, true)
				arg_468_1.iconController_:SetSelectedState("hero")

				arg_468_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_468_1.callingController_:SetSelectedState("normal")

				arg_468_1.keyicon_.color = Color.New(1, 1, 1)
				arg_468_1.icon_.color = Color.New(1, 1, 1)

				local var_471_4 = arg_468_1:FormatText(arg_468_1:GetWordFromCfg(425042114).content)

				arg_468_1.text_.text = var_471_4

				LuaForUtil.ClearLinePrefixSymbol(arg_468_1.text_)

				local var_471_6 = 15 <= 0 and var_471_3 or var_471_3 * (utf8.len(var_471_4) / 15)

				if (15 <= 0 and var_471_3 or var_471_3 * (utf8.len(var_471_4) / 15)) > 0 and var_471_3 < var_471_6 then
					arg_468_1.talkMaxDuration = var_471_6

					if var_471_6 + var_471_2 > arg_468_1.duration_ then
						arg_468_1.duration_ = var_471_6 + var_471_2
					end
				end

				arg_468_1.text_.text = var_471_4
				arg_468_1.typewritter.percent = 0

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(false)
				arg_468_1:RecordContent(arg_468_1.text_.text)
			end

			local var_471_7 = math.max(var_471_3, arg_468_1.talkMaxDuration)

			if var_471_2 <= arg_468_1.time_ and arg_468_1.time_ < var_471_2 + var_471_7 then
				arg_468_1.typewritter.percent = (arg_468_1.time_ - var_471_2) / var_471_7

				arg_468_1.typewritter:SetDirty()
			end

			if arg_468_1.time_ >= var_471_2 + var_471_7 and arg_468_1.time_ < var_471_2 + var_471_7 + arg_471_0 then
				arg_468_1.typewritter.percent = 1

				arg_468_1.typewritter:SetDirty()
				arg_468_1:ShowNextGo(true)
			end
		end

		arg_468_1.nodeConfigList_ = {}

		arg_468_1:InitPlayNodeList()
	end,
	Play425042115 = function(arg_472_0, arg_472_1)
		arg_472_1.time_ = 0
		arg_472_1.frameCnt_ = 0
		arg_472_1.state_ = "playing"
		arg_472_1.curTalkId_ = 425042115
		arg_472_1.duration_ = 9.37

		local var_472_0 = {
			zh = 5.1,
			ja = 9.366
		}
		local var_472_1 = manager.audio:GetLocalizationFlag()

		if var_472_0[var_472_1] ~= nil then
			arg_472_1.duration_ = var_472_0[var_472_1]
		end

		SetActive(arg_472_1.tipsGo_, false)

		function arg_472_1.onSingleLineFinish_()
			arg_472_1.onSingleLineUpdate_ = nil
			arg_472_1.onSingleLineFinish_ = nil
			arg_472_1.state_ = "waiting"
		end

		function arg_472_1.playNext_(arg_474_0)
			if arg_474_0 == 1 then
				arg_472_0:Play425042116(arg_472_1)
			end
		end

		function arg_472_1.onSingleLineUpdate_(arg_475_0)
			if 0 < arg_472_1.time_ and arg_472_1.time_ <= 0 + arg_475_0 and not isNil(arg_472_1.actors_["1137"]) and arg_472_1.var_.actorSpriteComps1137 == nil then
				arg_472_1.var_.actorSpriteComps1137 = arg_472_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_475_0 = 0.2

			if 0 <= arg_472_1.time_ and arg_472_1.time_ < 0 + var_475_0 and not isNil(arg_472_1.actors_["1137"]) then
				if arg_472_1.var_.actorSpriteComps1137 then
					for iter_475_0, iter_475_1 in pairs(arg_472_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_475_1 then
							if arg_472_1.isInRecall_ then
								iter_475_1.color = Color.New(Mathf.Lerp(iter_475_1.color.r, arg_472_1.hightColor1.r, (arg_472_1.time_ - 0) / var_475_0), Mathf.Lerp(iter_475_1.color.g, arg_472_1.hightColor1.g, (arg_472_1.time_ - 0) / var_475_0), (Mathf.Lerp(iter_475_1.color.b, arg_472_1.hightColor1.b, (arg_472_1.time_ - 0) / var_475_0)))
							else
								local var_475_1 = Mathf.Lerp(iter_475_1.color.r, 1, (arg_472_1.time_ - 0) / var_475_0)

								iter_475_1.color = Color.New(var_475_1, var_475_1, var_475_1)
							end
						end
					end
				end
			end

			if arg_472_1.time_ >= 0 + var_475_0 and arg_472_1.time_ < 0 + var_475_0 + arg_475_0 and not isNil(arg_472_1.actors_["1137"]) and arg_472_1.var_.actorSpriteComps1137 then
				for iter_475_2, iter_475_3 in pairs(arg_472_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_475_3 then
						iter_475_3.color = arg_472_1.isInRecall_ and (arg_472_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_472_1.var_.actorSpriteComps1137 = nil
			end

			local var_475_2 = 0
			local var_475_3 = 0.45

			if 0 < arg_472_1.time_ and arg_472_1.time_ <= var_475_2 + arg_475_0 then
				arg_472_1.talkMaxDuration = 0
				arg_472_1.dialogCg_.alpha = 1

				arg_472_1.dialog_:SetActive(true)
				SetActive(arg_472_1.leftNameGo_, true)

				arg_472_1.leftNameTxt_.text = arg_472_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_472_1.leftNameTxt_.transform)

				arg_472_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_472_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_472_1:RecordName(arg_472_1.leftNameTxt_.text)
				SetActive(arg_472_1.iconTrs_.gameObject, false)
				arg_472_1.callingController_:SetSelectedState("normal")

				local var_475_4 = arg_472_1:GetWordFromCfg(425042115)
				local var_475_5 = arg_472_1:FormatText(var_475_4.content)

				arg_472_1.text_.text = var_475_5

				LuaForUtil.ClearLinePrefixSymbol(arg_472_1.text_)

				local var_475_7 = 18 <= 0 and var_475_3 or var_475_3 * (utf8.len(var_475_5) / 18)

				if (18 <= 0 and var_475_3 or var_475_3 * (utf8.len(var_475_5) / 18)) > 0 and var_475_3 < var_475_7 then
					arg_472_1.talkMaxDuration = var_475_7

					if var_475_7 + var_475_2 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_7 + var_475_2
					end
				end

				arg_472_1.text_.text = var_475_5
				arg_472_1.typewritter.percent = 0

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042115", "story_v_out_425042.awb") ~= 0 then
					local var_475_8 = manager.audio:GetVoiceLength("story_v_out_425042", "425042115", "story_v_out_425042.awb") / 1000

					if var_475_8 + var_475_2 > arg_472_1.duration_ then
						arg_472_1.duration_ = var_475_8 + var_475_2
					end

					if var_475_4.prefab_name ~= "" and arg_472_1.actors_[var_475_4.prefab_name] ~= nil then
						local var_475_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_472_1.actors_[var_475_4.prefab_name].transform, "story_v_out_425042", "425042115", "story_v_out_425042.awb")

						arg_472_1:RecordAudio("425042115", var_475_9)
						arg_472_1:RecordAudio("425042115", var_475_9)
					else
						arg_472_1:AudioAction("play", "voice", "story_v_out_425042", "425042115", "story_v_out_425042.awb")
					end

					arg_472_1:RecordHistoryTalkVoice("story_v_out_425042", "425042115", "story_v_out_425042.awb")
				end

				arg_472_1:RecordContent(arg_472_1.text_.text)
			end

			local var_475_10 = math.max(var_475_3, arg_472_1.talkMaxDuration)

			if var_475_2 <= arg_472_1.time_ and arg_472_1.time_ < var_475_2 + var_475_10 then
				arg_472_1.typewritter.percent = (arg_472_1.time_ - var_475_2) / var_475_10

				arg_472_1.typewritter:SetDirty()
			end

			if arg_472_1.time_ >= var_475_2 + var_475_10 and arg_472_1.time_ < var_475_2 + var_475_10 + arg_475_0 then
				arg_472_1.typewritter.percent = 1

				arg_472_1.typewritter:SetDirty()
				arg_472_1:ShowNextGo(true)
			end
		end

		arg_472_1.nodeConfigList_ = {}

		arg_472_1:InitPlayNodeList()
	end,
	Play425042116 = function(arg_476_0, arg_476_1)
		arg_476_1.time_ = 0
		arg_476_1.frameCnt_ = 0
		arg_476_1.state_ = "playing"
		arg_476_1.curTalkId_ = 425042116
		arg_476_1.duration_ = 5.5

		SetActive(arg_476_1.tipsGo_, false)

		function arg_476_1.onSingleLineFinish_()
			arg_476_1.onSingleLineUpdate_ = nil
			arg_476_1.onSingleLineFinish_ = nil
			arg_476_1.state_ = "waiting"
		end

		function arg_476_1.playNext_(arg_478_0)
			if arg_478_0 == 1 then
				arg_476_0:Play425042117(arg_476_1)
			end
		end

		function arg_476_1.onSingleLineUpdate_(arg_479_0)
			local var_479_9000

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				arg_476_1.var_.moveOldPos1137 = arg_476_1.actors_["1137"].transform.localPosition
				arg_476_1.actors_["1137"].transform.localScale = Vector3.New(1, 1, 1)

				arg_476_1:CheckSpriteTmpPos("1137", 7)

				for iter_479_0 = 0, arg_476_1.actors_["1137"].transform.childCount - 1 do
					local var_479_0 = arg_476_1.actors_["1137"].transform:GetChild(iter_479_0)

					if var_479_0.name == "" or not string.find(var_479_0.name, "split") then
						var_479_0.gameObject:SetActive(true)
					else
						var_479_0.gameObject:SetActive(false)
					end
				end
			end

			local var_479_1 = 0.001

			if 0 <= arg_476_1.time_ and arg_476_1.time_ < 0 + var_479_1 then
				arg_476_1.actors_["1137"].transform.localPosition = Vector3.Lerp(arg_476_1.var_.moveOldPos1137, Vector3.New(0, -2000, 0), (arg_476_1.time_ - 0) / var_479_1)
			end

			if arg_476_1.time_ >= 0 + var_479_1 and arg_476_1.time_ < 0 + var_479_1 + arg_479_0 then
				arg_476_1.actors_["1137"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_476_1.time_ and arg_476_1.time_ <= 0 + arg_479_0 then
				local var_479_2 = arg_476_1.var_.effect10092116

				if not arg_476_1.var_.effect10092116 then
					var_479_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_479_2.name = "2116"
					arg_476_1.var_.effect10092116 = var_479_2
				else
					var_479_2.transform:SetParent(var_479_9000)
				end

				var_479_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_479_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.43333333333333 < arg_476_1.time_ and arg_476_1.time_ <= 1.43333333333333 + arg_479_0 then
				if arg_476_1.var_.effect10092116 then
					Object.Destroy(arg_476_1.var_.effect10092116)

					arg_476_1.var_.effect10092116 = nil
				end
			end

			if arg_476_1.frameCnt_ <= 1 then
				arg_476_1.dialog_:SetActive(false)
			end

			local var_479_5 = 0.5
			local var_479_6 = 1.3

			if 0.5 < arg_476_1.time_ and arg_476_1.time_ <= var_479_5 + arg_479_0 then
				arg_476_1.talkMaxDuration = 0

				arg_476_1.dialog_:SetActive(true)

				arg_476_1.dialogCg_.alpha = 0

				local var_479_7 = LeanTween.value(arg_476_1.dialog_, 0, 1, 0.3)

				var_479_7:setOnUpdate(LuaHelper.FloatAction(function(arg_480_0)
					arg_476_1.dialogCg_.alpha = arg_480_0
				end))
				var_479_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_476_1.dialog_)
					var_479_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_476_1.duration_ = arg_476_1.duration_ + 0.3

				SetActive(arg_476_1.leftNameGo_, false)

				arg_476_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_476_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_476_1:RecordName(arg_476_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_476_1.iconTrs_.gameObject, false)
				arg_476_1.callingController_:SetSelectedState("normal")

				local var_479_8 = arg_476_1:FormatText(arg_476_1:GetWordFromCfg(425042116).content)

				arg_476_1.text_.text = var_479_8

				LuaForUtil.ClearLinePrefixSymbol(arg_476_1.text_)

				local var_479_10 = 52 <= 0 and var_479_6 or var_479_6 * (utf8.len(var_479_8) / 52)

				if (52 <= 0 and var_479_6 or var_479_6 * (utf8.len(var_479_8) / 52)) > 0 and var_479_6 < var_479_10 then
					arg_476_1.talkMaxDuration = var_479_10
					var_479_5 = var_479_5 + 0.3

					if var_479_10 + var_479_5 > arg_476_1.duration_ then
						arg_476_1.duration_ = var_479_10 + var_479_5
					end
				end

				arg_476_1.text_.text = var_479_8
				arg_476_1.typewritter.percent = 0

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(false)
				arg_476_1:RecordContent(arg_476_1.text_.text)
			end

			local var_479_11 = var_479_5 + 0.3
			local var_479_12 = math.max(var_479_6, arg_476_1.talkMaxDuration)

			if var_479_5 + 0.3 <= arg_476_1.time_ and arg_476_1.time_ < var_479_11 + var_479_12 then
				arg_476_1.typewritter.percent = (arg_476_1.time_ - var_479_11) / var_479_12

				arg_476_1.typewritter:SetDirty()
			end

			if arg_476_1.time_ >= var_479_11 + var_479_12 and arg_476_1.time_ < var_479_11 + var_479_12 + arg_479_0 then
				arg_476_1.typewritter.percent = 1

				arg_476_1.typewritter:SetDirty()
				arg_476_1:ShowNextGo(true)
			end
		end

		arg_476_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_476_1:InitPlayNodeList()
	end,
	Play425042117 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 425042117
		arg_482_1.duration_ = 14.13

		local var_482_0 = {
			zh = 9.933,
			ja = 14.133
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play425042118(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			if 1 < arg_482_1.time_ and arg_482_1.time_ <= 1 + arg_485_0 then
				local var_485_0 = arg_482_1.bgs_.ST2402

				arg_482_1.bgs_.ST2402.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_485_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_485_1 = var_485_0:GetComponent("SpriteRenderer")

				if var_485_1 and var_485_1.sprite then
					local var_485_2 = 2 * (var_485_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_485_0.transform.localScale = Vector3.New(var_485_2 / var_485_1.sprite.bounds.size.y < var_485_2 * manager.ui.mainCameraCom_.aspect / var_485_1.sprite.bounds.size.x and var_485_2 * manager.ui.mainCameraCom_.aspect / var_485_1.sprite.bounds.size.x or var_485_2 / var_485_1.sprite.bounds.size.y, var_485_2 / var_485_1.sprite.bounds.size.y < var_485_2 * manager.ui.mainCameraCom_.aspect / var_485_1.sprite.bounds.size.x and var_485_2 * manager.ui.mainCameraCom_.aspect / var_485_1.sprite.bounds.size.x or var_485_2 / var_485_1.sprite.bounds.size.y, 0)
				end

				for iter_485_0, iter_485_1 in pairs(arg_482_1.bgs_) do
					if iter_485_0 ~= "ST2402" then
						iter_485_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_485_3 = 3

			if 3 < arg_482_1.time_ and arg_482_1.time_ <= var_485_3 + arg_485_0 then
				arg_482_1.allBtn_.enabled = false
			end

			if arg_482_1.time_ >= var_485_3 + 0.3 and arg_482_1.time_ < var_485_3 + 0.3 + arg_485_0 then
				arg_482_1.allBtn_.enabled = true
			end

			local var_485_4 = 0

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_4 + arg_485_0 then
				arg_482_1.mask_.enabled = true
				arg_482_1.mask_.raycastTarget = true

				arg_482_1:SetGaussion(false)
			end

			local var_485_5 = 1

			if var_485_4 <= arg_482_1.time_ and arg_482_1.time_ < var_485_4 + var_485_5 then
				local var_485_6 = Color.New(0, 0, 0)

				var_485_6.a = Mathf.Lerp(0, 1, (arg_482_1.time_ - var_485_4) / var_485_5)
				arg_482_1.mask_.color = var_485_6
			end

			if arg_482_1.time_ >= var_485_4 + var_485_5 and arg_482_1.time_ < var_485_4 + var_485_5 + arg_485_0 then
				local var_485_7 = Color.New(0, 0, 0)

				var_485_7.a = 1
				arg_482_1.mask_.color = var_485_7
			end

			local var_485_8 = 1

			if 1 < arg_482_1.time_ and arg_482_1.time_ <= var_485_8 + arg_485_0 then
				arg_482_1.mask_.enabled = true
				arg_482_1.mask_.raycastTarget = true

				arg_482_1:SetGaussion(false)
			end

			local var_485_9 = 2

			if var_485_8 <= arg_482_1.time_ and arg_482_1.time_ < var_485_8 + var_485_9 then
				local var_485_10 = Color.New(0, 0, 0)

				var_485_10.a = Mathf.Lerp(1, 0, (arg_482_1.time_ - var_485_8) / var_485_9)
				arg_482_1.mask_.color = var_485_10
			end

			if arg_482_1.time_ >= var_485_8 + var_485_9 and arg_482_1.time_ < var_485_8 + var_485_9 + arg_485_0 then
				local var_485_11 = Color.New(0, 0, 0)

				arg_482_1.mask_.enabled = false
				var_485_11.a = 0
				arg_482_1.mask_.color = var_485_11
			end

			local var_485_12 = arg_482_1.actors_["10157"]

			if 2.8 < arg_482_1.time_ and arg_482_1.time_ <= 2.8 + arg_485_0 and not isNil(var_485_12) and arg_482_1.var_.actorSpriteComps10157 == nil then
				arg_482_1.var_.actorSpriteComps10157 = var_485_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_485_13 = 0.2

			if 2.8 <= arg_482_1.time_ and arg_482_1.time_ < 2.8 + var_485_13 and not isNil(var_485_12) then
				if arg_482_1.var_.actorSpriteComps10157 then
					for iter_485_2, iter_485_3 in pairs(arg_482_1.var_.actorSpriteComps10157:ToTable()) do
						if iter_485_3 then
							if arg_482_1.isInRecall_ then
								iter_485_3.color = Color.New(Mathf.Lerp(iter_485_3.color.r, arg_482_1.hightColor1.r, (arg_482_1.time_ - 2.8) / var_485_13), Mathf.Lerp(iter_485_3.color.g, arg_482_1.hightColor1.g, (arg_482_1.time_ - 2.8) / var_485_13), (Mathf.Lerp(iter_485_3.color.b, arg_482_1.hightColor1.b, (arg_482_1.time_ - 2.8) / var_485_13)))
							else
								local var_485_14 = Mathf.Lerp(iter_485_3.color.r, 1, (arg_482_1.time_ - 2.8) / var_485_13)

								iter_485_3.color = Color.New(var_485_14, var_485_14, var_485_14)
							end
						end
					end
				end
			end

			if arg_482_1.time_ >= 2.8 + var_485_13 and arg_482_1.time_ < 2.8 + var_485_13 + arg_485_0 and not isNil(var_485_12) and arg_482_1.var_.actorSpriteComps10157 then
				for iter_485_4, iter_485_5 in pairs(arg_482_1.var_.actorSpriteComps10157:ToTable()) do
					if iter_485_5 then
						iter_485_5.color = arg_482_1.isInRecall_ and (arg_482_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_482_1.var_.actorSpriteComps10157 = nil
			end

			local var_485_15 = arg_482_1.actors_["10157"].transform

			if 2.8 < arg_482_1.time_ and arg_482_1.time_ <= 2.8 + arg_485_0 then
				arg_482_1.var_.moveOldPos10157 = var_485_15.localPosition
				var_485_15.localScale = Vector3.New(1, 1, 1)

				arg_482_1:CheckSpriteTmpPos("10157", 3)

				for iter_485_6 = 0, var_485_15.childCount - 1 do
					local var_485_16 = var_485_15:GetChild(iter_485_6)

					if var_485_16.name == "split_4" or not string.find(var_485_16.name, "split") then
						var_485_16.gameObject:SetActive(true)
					else
						var_485_16.gameObject:SetActive(false)
					end
				end
			end

			local var_485_17 = 0.001

			if 2.8 <= arg_482_1.time_ and arg_482_1.time_ < 2.8 + var_485_17 then
				var_485_15.localPosition = Vector3.Lerp(arg_482_1.var_.moveOldPos10157, Vector3.New(0, -408, 115), (arg_482_1.time_ - 2.8) / var_485_17)
			end

			if arg_482_1.time_ >= 2.8 + var_485_17 and arg_482_1.time_ < 2.8 + var_485_17 + arg_485_0 then
				var_485_15.localPosition = Vector3.New(0, -408, 115)
			end

			if arg_482_1.frameCnt_ <= 1 then
				arg_482_1.dialog_:SetActive(false)
			end

			local var_485_18 = 3
			local var_485_19 = 0.7

			if 3 < arg_482_1.time_ and arg_482_1.time_ <= var_485_18 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0

				arg_482_1.dialog_:SetActive(true)

				arg_482_1.dialogCg_.alpha = 0

				local var_485_20 = LeanTween.value(arg_482_1.dialog_, 0, 1, 0.3)

				var_485_20:setOnUpdate(LuaHelper.FloatAction(function(arg_486_0)
					arg_482_1.dialogCg_.alpha = arg_486_0
				end))
				var_485_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_482_1.dialog_)
					var_485_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_482_1.duration_ = arg_482_1.duration_ + 0.3

				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[1434].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_21 = arg_482_1:GetWordFromCfg(425042117)
				local var_485_22 = arg_482_1:FormatText(var_485_21.content)

				arg_482_1.text_.text = var_485_22

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_24 = 28 <= 0 and var_485_19 or var_485_19 * (utf8.len(var_485_22) / 28)

				if (28 <= 0 and var_485_19 or var_485_19 * (utf8.len(var_485_22) / 28)) > 0 and var_485_19 < var_485_24 then
					arg_482_1.talkMaxDuration = var_485_24
					var_485_18 = var_485_18 + 0.3

					if var_485_24 + var_485_18 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_24 + var_485_18
					end
				end

				arg_482_1.text_.text = var_485_22
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042117", "story_v_out_425042.awb") ~= 0 then
					local var_485_25 = manager.audio:GetVoiceLength("story_v_out_425042", "425042117", "story_v_out_425042.awb") / 1000

					if var_485_25 + var_485_18 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_25 + var_485_18
					end

					if var_485_21.prefab_name ~= "" and arg_482_1.actors_[var_485_21.prefab_name] ~= nil then
						local var_485_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_21.prefab_name].transform, "story_v_out_425042", "425042117", "story_v_out_425042.awb")

						arg_482_1:RecordAudio("425042117", var_485_26)
						arg_482_1:RecordAudio("425042117", var_485_26)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_425042", "425042117", "story_v_out_425042.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_425042", "425042117", "story_v_out_425042.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_27 = var_485_18 + 0.3
			local var_485_28 = math.max(var_485_19, arg_482_1.talkMaxDuration)

			if var_485_18 + 0.3 <= arg_482_1.time_ and arg_482_1.time_ < var_485_27 + var_485_28 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_27) / var_485_28

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_27 + var_485_28 and arg_482_1.time_ < var_485_27 + var_485_28 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_482_1:InitPlayNodeList()
	end,
	Play425042118 = function(arg_488_0, arg_488_1)
		arg_488_1.time_ = 0
		arg_488_1.frameCnt_ = 0
		arg_488_1.state_ = "playing"
		arg_488_1.curTalkId_ = 425042118
		arg_488_1.duration_ = 15.97

		local var_488_0 = {
			zh = 10.3,
			ja = 15.966
		}
		local var_488_1 = manager.audio:GetLocalizationFlag()

		if var_488_0[var_488_1] ~= nil then
			arg_488_1.duration_ = var_488_0[var_488_1]
		end

		SetActive(arg_488_1.tipsGo_, false)

		function arg_488_1.onSingleLineFinish_()
			arg_488_1.onSingleLineUpdate_ = nil
			arg_488_1.onSingleLineFinish_ = nil
			arg_488_1.state_ = "waiting"
		end

		function arg_488_1.playNext_(arg_490_0)
			if arg_490_0 == 1 then
				arg_488_0:Play425042119(arg_488_1)
			end
		end

		function arg_488_1.onSingleLineUpdate_(arg_491_0)
			local var_491_0 = 1.075

			if 0 < arg_488_1.time_ and arg_488_1.time_ <= 0 + arg_491_0 then
				arg_488_1.talkMaxDuration = 0
				arg_488_1.dialogCg_.alpha = 1

				arg_488_1.dialog_:SetActive(true)
				SetActive(arg_488_1.leftNameGo_, true)

				arg_488_1.leftNameTxt_.text = arg_488_1:FormatText(StoryNameCfg[1434].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_488_1.leftNameTxt_.transform)

				arg_488_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_488_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_488_1:RecordName(arg_488_1.leftNameTxt_.text)
				SetActive(arg_488_1.iconTrs_.gameObject, false)
				arg_488_1.callingController_:SetSelectedState("normal")

				local var_491_1 = arg_488_1:GetWordFromCfg(425042118)
				local var_491_2 = arg_488_1:FormatText(var_491_1.content)

				arg_488_1.text_.text = var_491_2

				LuaForUtil.ClearLinePrefixSymbol(arg_488_1.text_)

				local var_491_4 = 43 <= 0 and var_491_0 or var_491_0 * (utf8.len(var_491_2) / 43)

				if (43 <= 0 and var_491_0 or var_491_0 * (utf8.len(var_491_2) / 43)) > 0 and var_491_0 < var_491_4 then
					arg_488_1.talkMaxDuration = var_491_4

					if var_491_4 + 0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_4 + 0
					end
				end

				arg_488_1.text_.text = var_491_2
				arg_488_1.typewritter.percent = 0

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042118", "story_v_out_425042.awb") ~= 0 then
					local var_491_5 = manager.audio:GetVoiceLength("story_v_out_425042", "425042118", "story_v_out_425042.awb") / 1000

					if var_491_5 + 0 > arg_488_1.duration_ then
						arg_488_1.duration_ = var_491_5 + 0
					end

					if var_491_1.prefab_name ~= "" and arg_488_1.actors_[var_491_1.prefab_name] ~= nil then
						local var_491_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_488_1.actors_[var_491_1.prefab_name].transform, "story_v_out_425042", "425042118", "story_v_out_425042.awb")

						arg_488_1:RecordAudio("425042118", var_491_6)
						arg_488_1:RecordAudio("425042118", var_491_6)
					else
						arg_488_1:AudioAction("play", "voice", "story_v_out_425042", "425042118", "story_v_out_425042.awb")
					end

					arg_488_1:RecordHistoryTalkVoice("story_v_out_425042", "425042118", "story_v_out_425042.awb")
				end

				arg_488_1:RecordContent(arg_488_1.text_.text)
			end

			local var_491_7 = math.max(var_491_0, arg_488_1.talkMaxDuration)

			if 0 <= arg_488_1.time_ and arg_488_1.time_ < 0 + var_491_7 then
				arg_488_1.typewritter.percent = (arg_488_1.time_ - 0) / var_491_7

				arg_488_1.typewritter:SetDirty()
			end

			if arg_488_1.time_ >= 0 + var_491_7 and arg_488_1.time_ < 0 + var_491_7 + arg_491_0 then
				arg_488_1.typewritter.percent = 1

				arg_488_1.typewritter:SetDirty()
				arg_488_1:ShowNextGo(true)
			end
		end

		arg_488_1.nodeConfigList_ = {}

		arg_488_1:InitPlayNodeList()
	end,
	Play425042119 = function(arg_492_0, arg_492_1)
		arg_492_1.time_ = 0
		arg_492_1.frameCnt_ = 0
		arg_492_1.state_ = "playing"
		arg_492_1.curTalkId_ = 425042119
		arg_492_1.duration_ = 4.73

		local var_492_0 = {
			zh = 4.333,
			ja = 4.733
		}
		local var_492_1 = manager.audio:GetLocalizationFlag()

		if var_492_0[var_492_1] ~= nil then
			arg_492_1.duration_ = var_492_0[var_492_1]
		end

		SetActive(arg_492_1.tipsGo_, false)

		function arg_492_1.onSingleLineFinish_()
			arg_492_1.onSingleLineUpdate_ = nil
			arg_492_1.onSingleLineFinish_ = nil
			arg_492_1.state_ = "waiting"
		end

		function arg_492_1.playNext_(arg_494_0)
			if arg_494_0 == 1 then
				arg_492_0:Play425042120(arg_492_1)
			end
		end

		function arg_492_1.onSingleLineUpdate_(arg_495_0)
			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 and not isNil(arg_492_1.actors_["1137"]) and arg_492_1.var_.actorSpriteComps1137 == nil then
				arg_492_1.var_.actorSpriteComps1137 = arg_492_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_495_0 = 0.2

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_0 and not isNil(arg_492_1.actors_["1137"]) then
				if arg_492_1.var_.actorSpriteComps1137 then
					for iter_495_0, iter_495_1 in pairs(arg_492_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_495_1 then
							if arg_492_1.isInRecall_ then
								iter_495_1.color = Color.New(Mathf.Lerp(iter_495_1.color.r, arg_492_1.hightColor1.r, (arg_492_1.time_ - 0) / var_495_0), Mathf.Lerp(iter_495_1.color.g, arg_492_1.hightColor1.g, (arg_492_1.time_ - 0) / var_495_0), (Mathf.Lerp(iter_495_1.color.b, arg_492_1.hightColor1.b, (arg_492_1.time_ - 0) / var_495_0)))
							else
								local var_495_1 = Mathf.Lerp(iter_495_1.color.r, 1, (arg_492_1.time_ - 0) / var_495_0)

								iter_495_1.color = Color.New(var_495_1, var_495_1, var_495_1)
							end
						end
					end
				end
			end

			if arg_492_1.time_ >= 0 + var_495_0 and arg_492_1.time_ < 0 + var_495_0 + arg_495_0 and not isNil(arg_492_1.actors_["1137"]) and arg_492_1.var_.actorSpriteComps1137 then
				for iter_495_2, iter_495_3 in pairs(arg_492_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_495_3 then
						iter_495_3.color = arg_492_1.isInRecall_ and (arg_492_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_492_1.var_.actorSpriteComps1137 = nil
			end

			local var_495_2 = arg_492_1.actors_["1137"].transform

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1.var_.moveOldPos1137 = var_495_2.localPosition
				var_495_2.localScale = Vector3.New(1, 1, 1)

				arg_492_1:CheckSpriteTmpPos("1137", 3)

				for iter_495_4 = 0, var_495_2.childCount - 1 do
					local var_495_3 = var_495_2:GetChild(iter_495_4)

					if var_495_3.name == "split_4" or not string.find(var_495_3.name, "split") then
						var_495_3.gameObject:SetActive(true)
					else
						var_495_3.gameObject:SetActive(false)
					end
				end
			end

			local var_495_4 = 0.001

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_4 then
				var_495_2.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos1137, Vector3.New(0, -425, -200), (arg_492_1.time_ - 0) / var_495_4)
			end

			if arg_492_1.time_ >= 0 + var_495_4 and arg_492_1.time_ < 0 + var_495_4 + arg_495_0 then
				var_495_2.localPosition = Vector3.New(0, -425, -200)
			end

			local var_495_5 = arg_492_1.actors_["10157"].transform

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= 0 + arg_495_0 then
				arg_492_1.var_.moveOldPos10157 = var_495_5.localPosition
				var_495_5.localScale = Vector3.New(1, 1, 1)

				arg_492_1:CheckSpriteTmpPos("10157", 7)

				for iter_495_5 = 0, var_495_5.childCount - 1 do
					local var_495_6 = var_495_5:GetChild(iter_495_5)

					if var_495_6.name == "" or not string.find(var_495_6.name, "split") then
						var_495_6.gameObject:SetActive(true)
					else
						var_495_6.gameObject:SetActive(false)
					end
				end
			end

			local var_495_7 = 0.001

			if 0 <= arg_492_1.time_ and arg_492_1.time_ < 0 + var_495_7 then
				var_495_5.localPosition = Vector3.Lerp(arg_492_1.var_.moveOldPos10157, Vector3.New(0, -2000, 0), (arg_492_1.time_ - 0) / var_495_7)
			end

			if arg_492_1.time_ >= 0 + var_495_7 and arg_492_1.time_ < 0 + var_495_7 + arg_495_0 then
				var_495_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_495_8 = 0
			local var_495_9 = 0.325

			if 0 < arg_492_1.time_ and arg_492_1.time_ <= var_495_8 + arg_495_0 then
				arg_492_1.talkMaxDuration = 0
				arg_492_1.dialogCg_.alpha = 1

				arg_492_1.dialog_:SetActive(true)
				SetActive(arg_492_1.leftNameGo_, true)

				arg_492_1.leftNameTxt_.text = arg_492_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_492_1.leftNameTxt_.transform)

				arg_492_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_492_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_492_1:RecordName(arg_492_1.leftNameTxt_.text)
				SetActive(arg_492_1.iconTrs_.gameObject, false)
				arg_492_1.callingController_:SetSelectedState("normal")

				local var_495_10 = arg_492_1:GetWordFromCfg(425042119)
				local var_495_11 = arg_492_1:FormatText(var_495_10.content)

				arg_492_1.text_.text = var_495_11

				LuaForUtil.ClearLinePrefixSymbol(arg_492_1.text_)

				local var_495_13 = 13 <= 0 and var_495_9 or var_495_9 * (utf8.len(var_495_11) / 13)

				if (13 <= 0 and var_495_9 or var_495_9 * (utf8.len(var_495_11) / 13)) > 0 and var_495_9 < var_495_13 then
					arg_492_1.talkMaxDuration = var_495_13

					if var_495_13 + var_495_8 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_13 + var_495_8
					end
				end

				arg_492_1.text_.text = var_495_11
				arg_492_1.typewritter.percent = 0

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042119", "story_v_out_425042.awb") ~= 0 then
					local var_495_14 = manager.audio:GetVoiceLength("story_v_out_425042", "425042119", "story_v_out_425042.awb") / 1000

					if var_495_14 + var_495_8 > arg_492_1.duration_ then
						arg_492_1.duration_ = var_495_14 + var_495_8
					end

					if var_495_10.prefab_name ~= "" and arg_492_1.actors_[var_495_10.prefab_name] ~= nil then
						local var_495_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_492_1.actors_[var_495_10.prefab_name].transform, "story_v_out_425042", "425042119", "story_v_out_425042.awb")

						arg_492_1:RecordAudio("425042119", var_495_15)
						arg_492_1:RecordAudio("425042119", var_495_15)
					else
						arg_492_1:AudioAction("play", "voice", "story_v_out_425042", "425042119", "story_v_out_425042.awb")
					end

					arg_492_1:RecordHistoryTalkVoice("story_v_out_425042", "425042119", "story_v_out_425042.awb")
				end

				arg_492_1:RecordContent(arg_492_1.text_.text)
			end

			local var_495_16 = math.max(var_495_9, arg_492_1.talkMaxDuration)

			if var_495_8 <= arg_492_1.time_ and arg_492_1.time_ < var_495_8 + var_495_16 then
				arg_492_1.typewritter.percent = (arg_492_1.time_ - var_495_8) / var_495_16

				arg_492_1.typewritter:SetDirty()
			end

			if arg_492_1.time_ >= var_495_8 + var_495_16 and arg_492_1.time_ < var_495_8 + var_495_16 + arg_495_0 then
				arg_492_1.typewritter.percent = 1

				arg_492_1.typewritter:SetDirty()
				arg_492_1:ShowNextGo(true)
			end
		end

		arg_492_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10157",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_492_1:InitPlayNodeList()
	end,
	Play425042120 = function(arg_496_0, arg_496_1)
		arg_496_1.time_ = 0
		arg_496_1.frameCnt_ = 0
		arg_496_1.state_ = "playing"
		arg_496_1.curTalkId_ = 425042120
		arg_496_1.duration_ = 5

		SetActive(arg_496_1.tipsGo_, false)

		function arg_496_1.onSingleLineFinish_()
			arg_496_1.onSingleLineUpdate_ = nil
			arg_496_1.onSingleLineFinish_ = nil
			arg_496_1.state_ = "waiting"
		end

		function arg_496_1.playNext_(arg_498_0)
			if arg_498_0 == 1 then
				arg_496_0:Play425042121(arg_496_1)
			end
		end

		function arg_496_1.onSingleLineUpdate_(arg_499_0)
			if 0 < arg_496_1.time_ and arg_496_1.time_ <= 0 + arg_499_0 and not isNil(arg_496_1.actors_["1137"]) and arg_496_1.var_.actorSpriteComps1137 == nil then
				arg_496_1.var_.actorSpriteComps1137 = arg_496_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_499_0 = 0.2

			if 0 <= arg_496_1.time_ and arg_496_1.time_ < 0 + var_499_0 and not isNil(arg_496_1.actors_["1137"]) then
				if arg_496_1.var_.actorSpriteComps1137 then
					for iter_499_0, iter_499_1 in pairs(arg_496_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_499_1 then
							if arg_496_1.isInRecall_ then
								iter_499_1.color = Color.New(Mathf.Lerp(iter_499_1.color.r, arg_496_1.hightColor2.r, (arg_496_1.time_ - 0) / var_499_0), Mathf.Lerp(iter_499_1.color.g, arg_496_1.hightColor2.g, (arg_496_1.time_ - 0) / var_499_0), (Mathf.Lerp(iter_499_1.color.b, arg_496_1.hightColor2.b, (arg_496_1.time_ - 0) / var_499_0)))
							else
								local var_499_1 = Mathf.Lerp(iter_499_1.color.r, 0.5, (arg_496_1.time_ - 0) / var_499_0)

								iter_499_1.color = Color.New(var_499_1, var_499_1, var_499_1)
							end
						end
					end
				end
			end

			if arg_496_1.time_ >= 0 + var_499_0 and arg_496_1.time_ < 0 + var_499_0 + arg_499_0 and not isNil(arg_496_1.actors_["1137"]) and arg_496_1.var_.actorSpriteComps1137 then
				for iter_499_2, iter_499_3 in pairs(arg_496_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_499_3 then
						iter_499_3.color = arg_496_1.isInRecall_ and (arg_496_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_496_1.var_.actorSpriteComps1137 = nil
			end

			local var_499_2 = 0
			local var_499_3 = 1.2

			if 0 < arg_496_1.time_ and arg_496_1.time_ <= var_499_2 + arg_499_0 then
				arg_496_1.talkMaxDuration = 0
				arg_496_1.dialogCg_.alpha = 1

				arg_496_1.dialog_:SetActive(true)
				SetActive(arg_496_1.leftNameGo_, false)

				arg_496_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_496_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_496_1:RecordName(arg_496_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_496_1.iconTrs_.gameObject, false)
				arg_496_1.callingController_:SetSelectedState("normal")

				local var_499_4 = arg_496_1:FormatText(arg_496_1:GetWordFromCfg(425042120).content)

				arg_496_1.text_.text = var_499_4

				LuaForUtil.ClearLinePrefixSymbol(arg_496_1.text_)

				local var_499_6 = 48 <= 0 and var_499_3 or var_499_3 * (utf8.len(var_499_4) / 48)

				if (48 <= 0 and var_499_3 or var_499_3 * (utf8.len(var_499_4) / 48)) > 0 and var_499_3 < var_499_6 then
					arg_496_1.talkMaxDuration = var_499_6

					if var_499_6 + var_499_2 > arg_496_1.duration_ then
						arg_496_1.duration_ = var_499_6 + var_499_2
					end
				end

				arg_496_1.text_.text = var_499_4
				arg_496_1.typewritter.percent = 0

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(false)
				arg_496_1:RecordContent(arg_496_1.text_.text)
			end

			local var_499_7 = math.max(var_499_3, arg_496_1.talkMaxDuration)

			if var_499_2 <= arg_496_1.time_ and arg_496_1.time_ < var_499_2 + var_499_7 then
				arg_496_1.typewritter.percent = (arg_496_1.time_ - var_499_2) / var_499_7

				arg_496_1.typewritter:SetDirty()
			end

			if arg_496_1.time_ >= var_499_2 + var_499_7 and arg_496_1.time_ < var_499_2 + var_499_7 + arg_499_0 then
				arg_496_1.typewritter.percent = 1

				arg_496_1.typewritter:SetDirty()
				arg_496_1:ShowNextGo(true)
			end
		end

		arg_496_1.nodeConfigList_ = {}

		arg_496_1:InitPlayNodeList()
	end,
	Play425042121 = function(arg_500_0, arg_500_1)
		arg_500_1.time_ = 0
		arg_500_1.frameCnt_ = 0
		arg_500_1.state_ = "playing"
		arg_500_1.curTalkId_ = 425042121
		arg_500_1.duration_ = 11.4

		local var_500_0 = {
			zh = 7.3,
			ja = 11.4
		}
		local var_500_1 = manager.audio:GetLocalizationFlag()

		if var_500_0[var_500_1] ~= nil then
			arg_500_1.duration_ = var_500_0[var_500_1]
		end

		SetActive(arg_500_1.tipsGo_, false)

		function arg_500_1.onSingleLineFinish_()
			arg_500_1.onSingleLineUpdate_ = nil
			arg_500_1.onSingleLineFinish_ = nil
			arg_500_1.state_ = "waiting"
			arg_500_1.auto_ = false
		end

		function arg_500_1.playNext_(arg_502_0)
			arg_500_1.onStoryFinished_()
		end

		function arg_500_1.onSingleLineUpdate_(arg_503_0)
			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 and not isNil(arg_500_1.actors_["1137"]) and arg_500_1.var_.actorSpriteComps1137 == nil then
				arg_500_1.var_.actorSpriteComps1137 = arg_500_1.actors_["1137"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_503_0 = 0.2

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_0 and not isNil(arg_500_1.actors_["1137"]) then
				if arg_500_1.var_.actorSpriteComps1137 then
					for iter_503_0, iter_503_1 in pairs(arg_500_1.var_.actorSpriteComps1137:ToTable()) do
						if iter_503_1 then
							if arg_500_1.isInRecall_ then
								iter_503_1.color = Color.New(Mathf.Lerp(iter_503_1.color.r, arg_500_1.hightColor1.r, (arg_500_1.time_ - 0) / var_503_0), Mathf.Lerp(iter_503_1.color.g, arg_500_1.hightColor1.g, (arg_500_1.time_ - 0) / var_503_0), (Mathf.Lerp(iter_503_1.color.b, arg_500_1.hightColor1.b, (arg_500_1.time_ - 0) / var_503_0)))
							else
								local var_503_1 = Mathf.Lerp(iter_503_1.color.r, 1, (arg_500_1.time_ - 0) / var_503_0)

								iter_503_1.color = Color.New(var_503_1, var_503_1, var_503_1)
							end
						end
					end
				end
			end

			if arg_500_1.time_ >= 0 + var_503_0 and arg_500_1.time_ < 0 + var_503_0 + arg_503_0 and not isNil(arg_500_1.actors_["1137"]) and arg_500_1.var_.actorSpriteComps1137 then
				for iter_503_2, iter_503_3 in pairs(arg_500_1.var_.actorSpriteComps1137:ToTable()) do
					if iter_503_3 then
						iter_503_3.color = arg_500_1.isInRecall_ and (arg_500_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_500_1.var_.actorSpriteComps1137 = nil
			end

			local var_503_2 = arg_500_1.actors_["1137"].transform

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= 0 + arg_503_0 then
				arg_500_1.var_.moveOldPos1137 = var_503_2.localPosition
				var_503_2.localScale = Vector3.New(1, 1, 1)

				arg_500_1:CheckSpriteTmpPos("1137", 3)

				for iter_503_4 = 0, var_503_2.childCount - 1 do
					local var_503_3 = var_503_2:GetChild(iter_503_4)

					if var_503_3.name == "split_6" or not string.find(var_503_3.name, "split") then
						var_503_3.gameObject:SetActive(true)
					else
						var_503_3.gameObject:SetActive(false)
					end
				end
			end

			local var_503_4 = 0.001

			if 0 <= arg_500_1.time_ and arg_500_1.time_ < 0 + var_503_4 then
				var_503_2.localPosition = Vector3.Lerp(arg_500_1.var_.moveOldPos1137, Vector3.New(0, -425, -200), (arg_500_1.time_ - 0) / var_503_4)
			end

			if arg_500_1.time_ >= 0 + var_503_4 and arg_500_1.time_ < 0 + var_503_4 + arg_503_0 then
				var_503_2.localPosition = Vector3.New(0, -425, -200)
			end

			local var_503_5 = 0
			local var_503_6 = 0.675

			if 0 < arg_500_1.time_ and arg_500_1.time_ <= var_503_5 + arg_503_0 then
				arg_500_1.talkMaxDuration = 0
				arg_500_1.dialogCg_.alpha = 1

				arg_500_1.dialog_:SetActive(true)
				SetActive(arg_500_1.leftNameGo_, true)

				arg_500_1.leftNameTxt_.text = arg_500_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_500_1.leftNameTxt_.transform)

				arg_500_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_500_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_500_1:RecordName(arg_500_1.leftNameTxt_.text)
				SetActive(arg_500_1.iconTrs_.gameObject, false)
				arg_500_1.callingController_:SetSelectedState("normal")

				local var_503_7 = arg_500_1:GetWordFromCfg(425042121)
				local var_503_8 = arg_500_1:FormatText(var_503_7.content)

				arg_500_1.text_.text = var_503_8

				LuaForUtil.ClearLinePrefixSymbol(arg_500_1.text_)

				local var_503_10 = 27 <= 0 and var_503_6 or var_503_6 * (utf8.len(var_503_8) / 27)

				if (27 <= 0 and var_503_6 or var_503_6 * (utf8.len(var_503_8) / 27)) > 0 and var_503_6 < var_503_10 then
					arg_500_1.talkMaxDuration = var_503_10

					if var_503_10 + var_503_5 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_10 + var_503_5
					end
				end

				arg_500_1.text_.text = var_503_8
				arg_500_1.typewritter.percent = 0

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_425042", "425042121", "story_v_out_425042.awb") ~= 0 then
					local var_503_11 = manager.audio:GetVoiceLength("story_v_out_425042", "425042121", "story_v_out_425042.awb") / 1000

					if var_503_11 + var_503_5 > arg_500_1.duration_ then
						arg_500_1.duration_ = var_503_11 + var_503_5
					end

					if var_503_7.prefab_name ~= "" and arg_500_1.actors_[var_503_7.prefab_name] ~= nil then
						local var_503_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_500_1.actors_[var_503_7.prefab_name].transform, "story_v_out_425042", "425042121", "story_v_out_425042.awb")

						arg_500_1:RecordAudio("425042121", var_503_12)
						arg_500_1:RecordAudio("425042121", var_503_12)
					else
						arg_500_1:AudioAction("play", "voice", "story_v_out_425042", "425042121", "story_v_out_425042.awb")
					end

					arg_500_1:RecordHistoryTalkVoice("story_v_out_425042", "425042121", "story_v_out_425042.awb")
				end

				arg_500_1:RecordContent(arg_500_1.text_.text)
			end

			local var_503_13 = math.max(var_503_6, arg_500_1.talkMaxDuration)

			if var_503_5 <= arg_500_1.time_ and arg_500_1.time_ < var_503_5 + var_503_13 then
				arg_500_1.typewritter.percent = (arg_500_1.time_ - var_503_5) / var_503_13

				arg_500_1.typewritter:SetDirty()
			end

			if arg_500_1.time_ >= var_503_5 + var_503_13 and arg_500_1.time_ < var_503_5 + var_503_13 + arg_503_0 then
				arg_500_1.typewritter.percent = 1

				arg_500_1.typewritter:SetDirty()
				arg_500_1:ShowNextGo(true)
			end
		end

		arg_500_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1137",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_500_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I07",
		"TextureConfig/Background/ST10",
		"TextureConfig/Background/ST18",
		"TextureConfig/Background/ST2402"
	},
	voices = {
		"story_v_out_425042.awb"
	}
}
