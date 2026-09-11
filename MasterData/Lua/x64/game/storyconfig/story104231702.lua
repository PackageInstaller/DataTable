return {
	Play423172001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423172001
		arg_1_1.duration_ = 6.53

		local var_1_0 = {
			zh = 6.266,
			ja = 6.533
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
				arg_1_0:Play423172002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.I24f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I24f")
				var_4_0.name = "I24f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I24f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I24f

				arg_1_1.bgs_.I24f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I24f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2.025

			if 2.025 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1083"

			if arg_1_1.actors_["1083"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1083")

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

			local var_4_12 = arg_1_1.actors_["1083"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1083 == nil then
				arg_1_1.var_.actorSpriteComps1083 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps1083 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps1083 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps1083 = nil
			end

			local var_4_15 = arg_1_1.actors_["1083"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1083 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1083", 3)

				for iter_4_8 = 0, var_4_15.childCount - 1 do
					local var_4_16 = var_4_15:GetChild(iter_4_8)

					if var_4_16.name == "split_7" or not string.find(var_4_16.name, "split") then
						var_4_16.gameObject:SetActive(true)
					else
						var_4_16.gameObject:SetActive(false)
					end
				end
			end

			local var_4_17 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_17 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_1_1.time_ - 2) / var_4_17)
			end

			if arg_1_1.time_ >= 2 + var_4_17 and arg_1_1.time_ < 2 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(-50, -345, -345)
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				local var_4_18 = arg_1_1.actors_["1083"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_18 then
					arg_1_1.var_.alphaOldValue1083 = var_4_18.alpha
					arg_1_1.var_.characterEffect1083 = var_4_18
				end

				arg_1_1.var_.alphaOldValue1083 = 0
			end

			local var_4_19 = 0.5

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_19 then
				if arg_1_1.var_.characterEffect1083 then
					arg_1_1.var_.characterEffect1083.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue1083, 1, (arg_1_1.time_ - 2) / var_4_19)
				end
			end

			if arg_1_1.time_ >= 2 + var_4_19 and arg_1_1.time_ < 2 + var_4_19 + arg_4_0 and arg_1_1.var_.characterEffect1083 then
				arg_1_1.var_.characterEffect1083.alpha = 1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_20 = arg_1_1.var_.effectchedingzuozhan1

				if not arg_1_1.var_.effectchedingzuozhan1 then
					var_4_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), manager.ui.mainCamera.transform)
					var_4_20.name = "chedingzuozhan1"
					arg_1_1.var_.effectchedingzuozhan1 = var_4_20
				else
					var_4_20.transform:SetParent(var_4_9000)
				end

				var_4_20.transform.localPosition = Vector3.New(0, 0, -2)
				var_4_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_144", "se_story_144_amb_train_roof", "")
			end

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun04", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_26 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_26

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_26
						arg_1_1.bgmTxt2_.text = var_4_26
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous.awb")

				local var_4_29 = manager.audio:GetAudioName("bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_29 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_29

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_29
						arg_1_1.bgmTxt2_.text = var_4_29
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

			local var_4_30 = 2
			local var_4_31 = 0.325

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_32 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_32:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_33 = arg_1_1:GetWordFromCfg(423172001)
				local var_4_34 = arg_1_1:FormatText(var_4_33.content)

				arg_1_1.text_.text = var_4_34

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_36 = 13 <= 0 and var_4_31 or var_4_31 * (utf8.len(var_4_34) / 13)

				if (13 <= 0 and var_4_31 or var_4_31 * (utf8.len(var_4_34) / 13)) > 0 and var_4_31 < var_4_36 then
					arg_1_1.talkMaxDuration = var_4_36
					var_4_30 = var_4_30 + 0.3

					if var_4_36 + var_4_30 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_36 + var_4_30
					end
				end

				arg_1_1.text_.text = var_4_34
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172001", "story_v_out_423172.awb") ~= 0 then
					local var_4_37 = manager.audio:GetVoiceLength("story_v_out_423172", "423172001", "story_v_out_423172.awb") / 1000

					if var_4_37 + var_4_30 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_37 + var_4_30
					end

					if var_4_33.prefab_name ~= "" and arg_1_1.actors_[var_4_33.prefab_name] ~= nil then
						local var_4_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_33.prefab_name].transform, "story_v_out_423172", "423172001", "story_v_out_423172.awb")

						arg_1_1:RecordAudio("423172001", var_4_38)
						arg_1_1:RecordAudio("423172001", var_4_38)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423172", "423172001", "story_v_out_423172.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423172", "423172001", "story_v_out_423172.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_39 = var_4_30 + 0.3
			local var_4_40 = math.max(var_4_31, arg_1_1.talkMaxDuration)

			if var_4_30 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_39) / var_4_40

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083",
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
	Play423172002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423172002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play423172003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(arg_9_1.actors_["1083"]) and arg_9_1.var_.actorSpriteComps1083 == nil then
				arg_9_1.var_.actorSpriteComps1083 = arg_9_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_12_0 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 and not isNil(arg_9_1.actors_["1083"]) then
				if arg_9_1.var_.actorSpriteComps1083 then
					for iter_12_0, iter_12_1 in pairs(arg_9_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 and not isNil(arg_9_1.actors_["1083"]) and arg_9_1.var_.actorSpriteComps1083 then
				for iter_12_2, iter_12_3 in pairs(arg_9_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_12_3 then
						iter_12_3.color = arg_9_1.isInRecall_ and (arg_9_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_9_1.var_.actorSpriteComps1083 = nil
			end

			local var_12_2 = arg_9_1.actors_["1083"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1083 = var_12_2.localPosition
				var_12_2.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("1083", 7)

				for iter_12_4 = 0, var_12_2.childCount - 1 do
					local var_12_3 = var_12_2:GetChild(iter_12_4)

					if var_12_3.name == "" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_9_1.time_ - 0) / var_12_4)
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_12_5 = 0
			local var_12_6 = 1.6

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_7 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(423172002).content)

				arg_9_1.text_.text = var_12_7

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_9 = 56 <= 0 and var_12_6 or var_12_6 * (utf8.len(var_12_7) / 56)

				if (56 <= 0 and var_12_6 or var_12_6 * (utf8.len(var_12_7) / 56)) > 0 and var_12_6 < var_12_9 then
					arg_9_1.talkMaxDuration = var_12_9

					if var_12_9 + var_12_5 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_9 + var_12_5
					end
				end

				arg_9_1.text_.text = var_12_7
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_10 = math.max(var_12_6, arg_9_1.talkMaxDuration)

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_10 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_5) / var_12_10

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_5 + var_12_10 and arg_9_1.time_ < var_12_5 + var_12_10 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play423172003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 423172003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play423172004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.275

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(423172003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 52 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 52)

				if (52 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 52)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play423172004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 423172004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play423172005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.45

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(423172004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 69 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 69)

				if (69 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 69)) > 0 and var_20_0 < var_20_3 then
					arg_17_1.talkMaxDuration = var_20_3

					if var_20_3 + 0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_3 + 0
					end
				end

				arg_17_1.text_.text = var_20_1
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_4 = math.max(var_20_0, arg_17_1.talkMaxDuration)

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - 0) / var_20_4

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play423172005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 423172005
		arg_21_1.duration_ = 6.77

		local var_21_0 = {
			zh = 6.233,
			ja = 6.766
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
				arg_21_0:Play423172006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["3054"] == nil then
				local var_24_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "3054")

				if not isNil(var_24_0) then
					local var_24_1 = Object.Instantiate(var_24_0, arg_21_1.canvasGo_.transform)

					var_24_1.transform:SetSiblingIndex(1)

					var_24_1.name = "3054"
					var_24_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_21_1.actors_["3054"] = var_24_1

					if arg_21_1.isInRecall_ then
						for iter_24_0, iter_24_1 in ipairs((var_24_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_24_1.color = arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_24_2 = arg_21_1.actors_["3054"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps3054 == nil then
				arg_21_1.var_.actorSpriteComps3054 = var_24_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_24_3 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.actorSpriteComps3054 then
					for iter_24_2, iter_24_3 in pairs(arg_21_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_24_3 then
							if arg_21_1.isInRecall_ then
								iter_24_3.color = Color.New(Mathf.Lerp(iter_24_3.color.r, arg_21_1.hightColor1.r, (arg_21_1.time_ - 0) / var_24_3), Mathf.Lerp(iter_24_3.color.g, arg_21_1.hightColor1.g, (arg_21_1.time_ - 0) / var_24_3), (Mathf.Lerp(iter_24_3.color.b, arg_21_1.hightColor1.b, (arg_21_1.time_ - 0) / var_24_3)))
							else
								local var_24_4 = Mathf.Lerp(iter_24_3.color.r, 1, (arg_21_1.time_ - 0) / var_24_3)

								iter_24_3.color = Color.New(var_24_4, var_24_4, var_24_4)
							end
						end
					end
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.actorSpriteComps3054 then
				for iter_24_4, iter_24_5 in pairs(arg_21_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_24_5 then
						iter_24_5.color = arg_21_1.isInRecall_ and (arg_21_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_21_1.var_.actorSpriteComps3054 = nil
			end

			local var_24_5 = arg_21_1.actors_["3054"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos3054 = var_24_5.localPosition
				var_24_5.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("3054", 3)

				for iter_24_6 = 0, var_24_5.childCount - 1 do
					local var_24_6 = var_24_5:GetChild(iter_24_6)

					if var_24_6.name == "split_2" or not string.find(var_24_6.name, "split") then
						var_24_6.gameObject:SetActive(true)
					else
						var_24_6.gameObject:SetActive(false)
					end
				end
			end

			local var_24_7 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_21_1.time_ - 0) / var_24_7)
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0, -275, -280)
			end

			local var_24_8 = 0
			local var_24_9 = 0.65

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(423172005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 26 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 26)

				if (26 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 26)) > 0 and var_24_9 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172005", "story_v_out_423172.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_423172", "423172005", "story_v_out_423172.awb") / 1000

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_out_423172", "423172005", "story_v_out_423172.awb")

						arg_21_1:RecordAudio("423172005", var_24_15)
						arg_21_1:RecordAudio("423172005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_423172", "423172005", "story_v_out_423172.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_423172", "423172005", "story_v_out_423172.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_16 and arg_21_1.time_ < var_24_8 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423172006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 423172006
		arg_25_1.duration_ = 6.53

		local var_25_0 = {
			zh = 6.533,
			ja = 6.233
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
				arg_25_0:Play423172007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos3054 = arg_25_1.actors_["3054"].transform.localPosition
				arg_25_1.actors_["3054"].transform.localScale = Vector3.New(1, 1, 1)

				arg_25_1:CheckSpriteTmpPos("3054", 3)

				for iter_28_0 = 0, arg_25_1.actors_["3054"].transform.childCount - 1 do
					local var_28_0 = arg_25_1.actors_["3054"].transform:GetChild(iter_28_0)

					if var_28_0.name == "" or not string.find(var_28_0.name, "split") then
						var_28_0.gameObject:SetActive(true)
					else
						var_28_0.gameObject:SetActive(false)
					end
				end
			end

			local var_28_1 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_1 then
				arg_25_1.actors_["3054"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_25_1.time_ - 0) / var_28_1)
			end

			if arg_25_1.time_ >= 0 + var_28_1 and arg_25_1.time_ < 0 + var_28_1 + arg_28_0 then
				arg_25_1.actors_["3054"].transform.localPosition = Vector3.New(0, -275, -280)
			end

			local var_28_2 = 0
			local var_28_3 = 0.55

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_2 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_4 = arg_25_1:GetWordFromCfg(423172006)
				local var_28_5 = arg_25_1:FormatText(var_28_4.content)

				arg_25_1.text_.text = var_28_5

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_7 = 22 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 22)

				if (22 <= 0 and var_28_3 or var_28_3 * (utf8.len(var_28_5) / 22)) > 0 and var_28_3 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_2
					end
				end

				arg_25_1.text_.text = var_28_5
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172006", "story_v_out_423172.awb") ~= 0 then
					local var_28_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172006", "story_v_out_423172.awb") / 1000

					if var_28_8 + var_28_2 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_8 + var_28_2
					end

					if var_28_4.prefab_name ~= "" and arg_25_1.actors_[var_28_4.prefab_name] ~= nil then
						local var_28_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_4.prefab_name].transform, "story_v_out_423172", "423172006", "story_v_out_423172.awb")

						arg_25_1:RecordAudio("423172006", var_28_9)
						arg_25_1:RecordAudio("423172006", var_28_9)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_423172", "423172006", "story_v_out_423172.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_423172", "423172006", "story_v_out_423172.awb")
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

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423172007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 423172007
		arg_29_1.duration_ = 5

		local var_29_0 = {
			zh = 5,
			ja = 4.533
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
				arg_29_0:Play423172008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1083"]) and arg_29_1.var_.actorSpriteComps1083 == nil then
				arg_29_1.var_.actorSpriteComps1083 = arg_29_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_0 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1083"]) then
				if arg_29_1.var_.actorSpriteComps1083 then
					for iter_32_0, iter_32_1 in pairs(arg_29_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1083"]) and arg_29_1.var_.actorSpriteComps1083 then
				for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_32_3 then
						iter_32_3.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps1083 = nil
			end

			local var_32_2 = arg_29_1.actors_["3054"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps3054 == nil then
				arg_29_1.var_.actorSpriteComps3054 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps3054 then
					for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps3054 then
				for iter_32_6, iter_32_7 in pairs(arg_29_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_32_7 then
						iter_32_7.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_29_1.var_.actorSpriteComps3054 = nil
			end

			local var_32_5 = arg_29_1.actors_["3054"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos3054 = var_32_5.localPosition
				var_32_5.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("3054", 7)

				for iter_32_8 = 0, var_32_5.childCount - 1 do
					local var_32_6 = var_32_5:GetChild(iter_32_8)

					if var_32_6.name == "" or not string.find(var_32_6.name, "split") then
						var_32_6.gameObject:SetActive(true)
					else
						var_32_6.gameObject:SetActive(false)
					end
				end
			end

			local var_32_7 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos3054, Vector3.New(0, -2000, 0), (arg_29_1.time_ - 0) / var_32_7)
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_32_8 = arg_29_1.actors_["1083"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1083 = var_32_8.localPosition
				var_32_8.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("1083", 3)

				for iter_32_9 = 0, var_32_8.childCount - 1 do
					local var_32_9 = var_32_8:GetChild(iter_32_9)

					if var_32_9.name == "split_7" or not string.find(var_32_9.name, "split") then
						var_32_9.gameObject:SetActive(true)
					else
						var_32_9.gameObject:SetActive(false)
					end
				end
			end

			local var_32_10 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_10 then
				var_32_8.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_29_1.time_ - 0) / var_32_10)
			end

			if arg_29_1.time_ >= 0 + var_32_10 and arg_29_1.time_ < 0 + var_32_10 + arg_32_0 then
				var_32_8.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_32_11 = 0
			local var_32_12 = 0.5

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_13 = arg_29_1:GetWordFromCfg(423172007)
				local var_32_14 = arg_29_1:FormatText(var_32_13.content)

				arg_29_1.text_.text = var_32_14

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_16 = 20 <= 0 and var_32_12 or var_32_12 * (utf8.len(var_32_14) / 20)

				if (20 <= 0 and var_32_12 or var_32_12 * (utf8.len(var_32_14) / 20)) > 0 and var_32_12 < var_32_16 then
					arg_29_1.talkMaxDuration = var_32_16

					if var_32_16 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_16 + var_32_11
					end
				end

				arg_29_1.text_.text = var_32_14
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172007", "story_v_out_423172.awb") ~= 0 then
					local var_32_17 = manager.audio:GetVoiceLength("story_v_out_423172", "423172007", "story_v_out_423172.awb") / 1000

					if var_32_17 + var_32_11 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_17 + var_32_11
					end

					if var_32_13.prefab_name ~= "" and arg_29_1.actors_[var_32_13.prefab_name] ~= nil then
						local var_32_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_13.prefab_name].transform, "story_v_out_423172", "423172007", "story_v_out_423172.awb")

						arg_29_1:RecordAudio("423172007", var_32_18)
						arg_29_1:RecordAudio("423172007", var_32_18)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_423172", "423172007", "story_v_out_423172.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_423172", "423172007", "story_v_out_423172.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_19 = math.max(var_32_12, arg_29_1.talkMaxDuration)

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_19 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_11) / var_32_19

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_11 + var_32_19 and arg_29_1.time_ < var_32_11 + var_32_19 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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

		arg_29_1:InitPlayNodeList()
	end,
	Play423172008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 423172008
		arg_33_1.duration_ = 5.43

		local var_33_0 = {
			zh = 4.566,
			ja = 5.433
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
				arg_33_0:Play423172009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.6

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:GetWordFromCfg(423172008)
				local var_36_2 = arg_33_1:FormatText(var_36_1.content)

				arg_33_1.text_.text = var_36_2

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 24 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 24)

				if (24 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_2) / 24)) > 0 and var_36_0 < var_36_4 then
					arg_33_1.talkMaxDuration = var_36_4

					if var_36_4 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_4 + 0
					end
				end

				arg_33_1.text_.text = var_36_2
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172008", "story_v_out_423172.awb") ~= 0 then
					local var_36_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172008", "story_v_out_423172.awb") / 1000

					if var_36_5 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + 0
					end

					if var_36_1.prefab_name ~= "" and arg_33_1.actors_[var_36_1.prefab_name] ~= nil then
						local var_36_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_1.prefab_name].transform, "story_v_out_423172", "423172008", "story_v_out_423172.awb")

						arg_33_1:RecordAudio("423172008", var_36_6)
						arg_33_1:RecordAudio("423172008", var_36_6)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_423172", "423172008", "story_v_out_423172.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_423172", "423172008", "story_v_out_423172.awb")
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
	Play423172009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 423172009
		arg_37_1.duration_ = 6

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play423172010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1083"]) and arg_37_1.var_.actorSpriteComps1083 == nil then
				arg_37_1.var_.actorSpriteComps1083 = arg_37_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.034

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1083"]) then
				if arg_37_1.var_.actorSpriteComps1083 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_40_1 then
							if arg_37_1.isInRecall_ then
								iter_40_1.color = Color.New(Mathf.Lerp(iter_40_1.color.r, arg_37_1.hightColor2.r, (arg_37_1.time_ - 0) / var_40_0), Mathf.Lerp(iter_40_1.color.g, arg_37_1.hightColor2.g, (arg_37_1.time_ - 0) / var_40_0), (Mathf.Lerp(iter_40_1.color.b, arg_37_1.hightColor2.b, (arg_37_1.time_ - 0) / var_40_0)))
							else
								local var_40_1 = Mathf.Lerp(iter_40_1.color.r, 0.5, (arg_37_1.time_ - 0) / var_40_0)

								iter_40_1.color = Color.New(var_40_1, var_40_1, var_40_1)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1083"]) and arg_37_1.var_.actorSpriteComps1083 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps1083 = nil
			end

			local var_40_2 = arg_37_1.actors_["1083"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1083 = var_40_2.localPosition
				var_40_2.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("1083", 7)

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
				var_40_2.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_37_1.time_ - 0) / var_40_4)
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_40_5

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				local var_40_6 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_40_6 then
					var_40_6.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_40_6.radialBlurScale = 0.6
					var_40_6.radialBlurGradient = 1
					var_40_6.radialBlurIntensity = 1

					if var_40_5 then
						var_40_6.radialBlurTarget = var_40_5.transform
					end
				end
			end

			local var_40_7 = 2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_7 then
				local var_40_8 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_40_8 then
					var_40_8.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_40_8.radialBlurScale = Mathf.Lerp(0.6, 0, (arg_37_1.time_ - 0) / var_40_7)
					var_40_8.radialBlurGradient = Mathf.Lerp(1, 1, (arg_37_1.time_ - 0) / var_40_7)
					var_40_8.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_37_1.time_ - 0) / var_40_7)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_7 and arg_37_1.time_ < 0 + var_40_7 + arg_40_0 then
				local var_40_9 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_40_9 then
					var_40_9.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_40_9.radialBlurScale = 0
					var_40_9.radialBlurGradient = 1
					var_40_9.radialBlurIntensity = 1
				end
			end

			local var_40_10 = 0.0333333333333333

			if 0.0333333333333333 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1.allBtn_.enabled = false
			end

			if arg_37_1.time_ >= var_40_10 + 0.966666666666667 and arg_37_1.time_ < var_40_10 + 0.966666666666667 + arg_40_0 then
				arg_37_1.allBtn_.enabled = true
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_11 = 1
			local var_40_12 = 1.375

			if 1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_13 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_13:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_14 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(423172009).content)

				arg_37_1.text_.text = var_40_14

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_16 = 55 <= 0 and var_40_12 or var_40_12 * (utf8.len(var_40_14) / 55)

				if (55 <= 0 and var_40_12 or var_40_12 * (utf8.len(var_40_14) / 55)) > 0 and var_40_12 < var_40_16 then
					arg_37_1.talkMaxDuration = var_40_16
					var_40_11 = var_40_11 + 0.3

					if var_40_16 + var_40_11 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_16 + var_40_11
					end
				end

				arg_37_1.text_.text = var_40_14
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_17 = var_40_11 + 0.3
			local var_40_18 = math.max(var_40_12, arg_37_1.talkMaxDuration)

			if var_40_11 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_17 + var_40_18 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_17) / var_40_18

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_17 + var_40_18 and arg_37_1.time_ < var_40_17 + var_40_18 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play423172010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 423172010
		arg_43_1.duration_ = 7

		local var_43_0 = {
			zh = 7,
			ja = 4.733
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
				arg_43_0:Play423172011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["3054"]) and arg_43_1.var_.actorSpriteComps3054 == nil then
				arg_43_1.var_.actorSpriteComps3054 = arg_43_1.actors_["3054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_0 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["3054"]) then
				if arg_43_1.var_.actorSpriteComps3054 then
					for iter_46_0, iter_46_1 in pairs(arg_43_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_46_1 then
							if arg_43_1.isInRecall_ then
								iter_46_1.color = Color.New(Mathf.Lerp(iter_46_1.color.r, arg_43_1.hightColor1.r, (arg_43_1.time_ - 0) / var_46_0), Mathf.Lerp(iter_46_1.color.g, arg_43_1.hightColor1.g, (arg_43_1.time_ - 0) / var_46_0), (Mathf.Lerp(iter_46_1.color.b, arg_43_1.hightColor1.b, (arg_43_1.time_ - 0) / var_46_0)))
							else
								local var_46_1 = Mathf.Lerp(iter_46_1.color.r, 1, (arg_43_1.time_ - 0) / var_46_0)

								iter_46_1.color = Color.New(var_46_1, var_46_1, var_46_1)
							end
						end
					end
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["3054"]) and arg_43_1.var_.actorSpriteComps3054 then
				for iter_46_2, iter_46_3 in pairs(arg_43_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_46_3 then
						iter_46_3.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_43_1.var_.actorSpriteComps3054 = nil
			end

			local var_46_2 = arg_43_1.actors_["3054"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos3054 = var_46_2.localPosition
				var_46_2.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("3054", 3)

				for iter_46_4 = 0, var_46_2.childCount - 1 do
					local var_46_3 = var_46_2:GetChild(iter_46_4)

					if var_46_3.name == "" or not string.find(var_46_3.name, "split") then
						var_46_3.gameObject:SetActive(true)
					else
						var_46_3.gameObject:SetActive(false)
					end
				end
			end

			local var_46_4 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				var_46_2.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_43_1.time_ - 0) / var_46_4)
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				var_46_2.localPosition = Vector3.New(0, -275, -280)
			end

			local var_46_5 = 0
			local var_46_6 = 0.675

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_5 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_7 = arg_43_1:GetWordFromCfg(423172010)
				local var_46_8 = arg_43_1:FormatText(var_46_7.content)

				arg_43_1.text_.text = var_46_8

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_10 = 27 <= 0 and var_46_6 or var_46_6 * (utf8.len(var_46_8) / 27)

				if (27 <= 0 and var_46_6 or var_46_6 * (utf8.len(var_46_8) / 27)) > 0 and var_46_6 < var_46_10 then
					arg_43_1.talkMaxDuration = var_46_10

					if var_46_10 + var_46_5 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_5
					end
				end

				arg_43_1.text_.text = var_46_8
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172010", "story_v_out_423172.awb") ~= 0 then
					local var_46_11 = manager.audio:GetVoiceLength("story_v_out_423172", "423172010", "story_v_out_423172.awb") / 1000

					if var_46_11 + var_46_5 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_11 + var_46_5
					end

					if var_46_7.prefab_name ~= "" and arg_43_1.actors_[var_46_7.prefab_name] ~= nil then
						local var_46_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_7.prefab_name].transform, "story_v_out_423172", "423172010", "story_v_out_423172.awb")

						arg_43_1:RecordAudio("423172010", var_46_12)
						arg_43_1:RecordAudio("423172010", var_46_12)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_423172", "423172010", "story_v_out_423172.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_423172", "423172010", "story_v_out_423172.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_13 = math.max(var_46_6, arg_43_1.talkMaxDuration)

			if var_46_5 <= arg_43_1.time_ and arg_43_1.time_ < var_46_5 + var_46_13 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_5) / var_46_13

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_5 + var_46_13 and arg_43_1.time_ < var_46_5 + var_46_13 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play423172011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 423172011
		arg_47_1.duration_ = 10.77

		local var_47_0 = {
			zh = 10.166,
			ja = 10.766
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
				arg_47_0:Play423172012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos3054 = arg_47_1.actors_["3054"].transform.localPosition
				arg_47_1.actors_["3054"].transform.localScale = Vector3.New(1, 1, 1)

				arg_47_1:CheckSpriteTmpPos("3054", 3)

				for iter_50_0 = 0, arg_47_1.actors_["3054"].transform.childCount - 1 do
					local var_50_0 = arg_47_1.actors_["3054"].transform:GetChild(iter_50_0)

					if var_50_0.name == "split_2" or not string.find(var_50_0.name, "split") then
						var_50_0.gameObject:SetActive(true)
					else
						var_50_0.gameObject:SetActive(false)
					end
				end
			end

			local var_50_1 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_1 then
				arg_47_1.actors_["3054"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_47_1.time_ - 0) / var_50_1)
			end

			if arg_47_1.time_ >= 0 + var_50_1 and arg_47_1.time_ < 0 + var_50_1 + arg_50_0 then
				arg_47_1.actors_["3054"].transform.localPosition = Vector3.New(0, -275, -280)
			end

			local var_50_2 = 0
			local var_50_3 = 1.05

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_2 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_4 = arg_47_1:GetWordFromCfg(423172011)
				local var_50_5 = arg_47_1:FormatText(var_50_4.content)

				arg_47_1.text_.text = var_50_5

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_7 = 42 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_5) / 42)

				if (42 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_5) / 42)) > 0 and var_50_3 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_2
					end
				end

				arg_47_1.text_.text = var_50_5
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172011", "story_v_out_423172.awb") ~= 0 then
					local var_50_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172011", "story_v_out_423172.awb") / 1000

					if var_50_8 + var_50_2 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_8 + var_50_2
					end

					if var_50_4.prefab_name ~= "" and arg_47_1.actors_[var_50_4.prefab_name] ~= nil then
						local var_50_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_4.prefab_name].transform, "story_v_out_423172", "423172011", "story_v_out_423172.awb")

						arg_47_1:RecordAudio("423172011", var_50_9)
						arg_47_1:RecordAudio("423172011", var_50_9)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_423172", "423172011", "story_v_out_423172.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_423172", "423172011", "story_v_out_423172.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_10 = math.max(var_50_3, arg_47_1.talkMaxDuration)

			if var_50_2 <= arg_47_1.time_ and arg_47_1.time_ < var_50_2 + var_50_10 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_2) / var_50_10

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_2 + var_50_10 and arg_47_1.time_ < var_50_2 + var_50_10 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423172012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 423172012
		arg_51_1.duration_ = 2.33

		local var_51_0 = {
			zh = 2.333,
			ja = 1.433
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
				arg_51_0:Play423172013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["1083"]) and arg_51_1.var_.actorSpriteComps1083 == nil then
				arg_51_1.var_.actorSpriteComps1083 = arg_51_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_0 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["1083"]) then
				if arg_51_1.var_.actorSpriteComps1083 then
					for iter_54_0, iter_54_1 in pairs(arg_51_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_54_1 then
							if arg_51_1.isInRecall_ then
								iter_54_1.color = Color.New(Mathf.Lerp(iter_54_1.color.r, arg_51_1.hightColor1.r, (arg_51_1.time_ - 0) / var_54_0), Mathf.Lerp(iter_54_1.color.g, arg_51_1.hightColor1.g, (arg_51_1.time_ - 0) / var_54_0), (Mathf.Lerp(iter_54_1.color.b, arg_51_1.hightColor1.b, (arg_51_1.time_ - 0) / var_54_0)))
							else
								local var_54_1 = Mathf.Lerp(iter_54_1.color.r, 1, (arg_51_1.time_ - 0) / var_54_0)

								iter_54_1.color = Color.New(var_54_1, var_54_1, var_54_1)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["1083"]) and arg_51_1.var_.actorSpriteComps1083 then
				for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_54_3 then
						iter_54_3.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_51_1.var_.actorSpriteComps1083 = nil
			end

			local var_54_2 = arg_51_1.actors_["3054"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps3054 == nil then
				arg_51_1.var_.actorSpriteComps3054 = var_54_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_3 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_3 and not isNil(var_54_2) then
				if arg_51_1.var_.actorSpriteComps3054 then
					for iter_54_4, iter_54_5 in pairs(arg_51_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_54_5 then
							if arg_51_1.isInRecall_ then
								iter_54_5.color = Color.New(Mathf.Lerp(iter_54_5.color.r, arg_51_1.hightColor2.r, (arg_51_1.time_ - 0) / var_54_3), Mathf.Lerp(iter_54_5.color.g, arg_51_1.hightColor2.g, (arg_51_1.time_ - 0) / var_54_3), (Mathf.Lerp(iter_54_5.color.b, arg_51_1.hightColor2.b, (arg_51_1.time_ - 0) / var_54_3)))
							else
								local var_54_4 = Mathf.Lerp(iter_54_5.color.r, 0.5, (arg_51_1.time_ - 0) / var_54_3)

								iter_54_5.color = Color.New(var_54_4, var_54_4, var_54_4)
							end
						end
					end
				end
			end

			if arg_51_1.time_ >= 0 + var_54_3 and arg_51_1.time_ < 0 + var_54_3 + arg_54_0 and not isNil(var_54_2) and arg_51_1.var_.actorSpriteComps3054 then
				for iter_54_6, iter_54_7 in pairs(arg_51_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_54_7 then
						iter_54_7.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_51_1.var_.actorSpriteComps3054 = nil
			end

			local var_54_5 = arg_51_1.actors_["3054"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos3054 = var_54_5.localPosition
				var_54_5.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("3054", 2)

				for iter_54_8 = 0, var_54_5.childCount - 1 do
					local var_54_6 = var_54_5:GetChild(iter_54_8)

					if var_54_6.name == "" or not string.find(var_54_6.name, "split") then
						var_54_6.gameObject:SetActive(true)
					else
						var_54_6.gameObject:SetActive(false)
					end
				end
			end

			local var_54_7 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				var_54_5.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos3054, Vector3.New(-390, -275, -280), (arg_51_1.time_ - 0) / var_54_7)
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				var_54_5.localPosition = Vector3.New(-390, -275, -280)
			end

			local var_54_8 = arg_51_1.actors_["1083"].transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1083 = var_54_8.localPosition
				var_54_8.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("1083", 4)

				for iter_54_9 = 0, var_54_8.childCount - 1 do
					local var_54_9 = var_54_8:GetChild(iter_54_9)

					if var_54_9.name == "split_7" or not string.find(var_54_9.name, "split") then
						var_54_9.gameObject:SetActive(true)
					else
						var_54_9.gameObject:SetActive(false)
					end
				end
			end

			local var_54_10 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_10 then
				var_54_8.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1083, Vector3.New(390, -345, -345), (arg_51_1.time_ - 0) / var_54_10)
			end

			if arg_51_1.time_ >= 0 + var_54_10 and arg_51_1.time_ < 0 + var_54_10 + arg_54_0 then
				var_54_8.localPosition = Vector3.New(390, -345, -345)
			end

			local var_54_11 = manager.ui.mainCamera.transform

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.shakeOldPos = var_54_11.localPosition
			end

			local var_54_12 = 0.6

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_12 then
				local var_54_13, var_54_14 = math.modf((arg_51_1.time_ - 0) / 0.066)

				var_54_11.localPosition = Vector3.New(var_54_14 * 0.02, var_54_14 * 0.02, var_54_14 * 0.02) + arg_51_1.var_.shakeOldPos
			end

			if arg_51_1.time_ >= 0 + var_54_12 and arg_51_1.time_ < 0 + var_54_12 + arg_54_0 then
				var_54_11.localPosition = arg_51_1.var_.shakeOldPos
			end

			local var_54_15 = 0

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_15 + arg_54_0 then
				arg_51_1.allBtn_.enabled = false
			end

			if arg_51_1.time_ >= var_54_15 + 0.6 and arg_51_1.time_ < var_54_15 + 0.6 + arg_54_0 then
				arg_51_1.allBtn_.enabled = true
			end

			local var_54_16 = 0
			local var_54_17 = 0.3

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_16 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_18 = arg_51_1:GetWordFromCfg(423172012)
				local var_54_19 = arg_51_1:FormatText(var_54_18.content)

				arg_51_1.text_.text = var_54_19

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_21 = 12 <= 0 and var_54_17 or var_54_17 * (utf8.len(var_54_19) / 12)

				if (12 <= 0 and var_54_17 or var_54_17 * (utf8.len(var_54_19) / 12)) > 0 and var_54_17 < var_54_21 then
					arg_51_1.talkMaxDuration = var_54_21

					if var_54_21 + var_54_16 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_21 + var_54_16
					end
				end

				arg_51_1.text_.text = var_54_19
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172012", "story_v_out_423172.awb") ~= 0 then
					local var_54_22 = manager.audio:GetVoiceLength("story_v_out_423172", "423172012", "story_v_out_423172.awb") / 1000

					if var_54_22 + var_54_16 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_22 + var_54_16
					end

					if var_54_18.prefab_name ~= "" and arg_51_1.actors_[var_54_18.prefab_name] ~= nil then
						local var_54_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_18.prefab_name].transform, "story_v_out_423172", "423172012", "story_v_out_423172.awb")

						arg_51_1:RecordAudio("423172012", var_54_23)
						arg_51_1:RecordAudio("423172012", var_54_23)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_423172", "423172012", "story_v_out_423172.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_423172", "423172012", "story_v_out_423172.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_24 = math.max(var_54_17, arg_51_1.talkMaxDuration)

			if var_54_16 <= arg_51_1.time_ and arg_51_1.time_ < var_54_16 + var_54_24 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_16) / var_54_24

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_16 + var_54_24 and arg_51_1.time_ < var_54_16 + var_54_24 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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

		arg_51_1:InitPlayNodeList()
	end,
	Play423172013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 423172013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play423172014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1083"]) and arg_55_1.var_.actorSpriteComps1083 == nil then
				arg_55_1.var_.actorSpriteComps1083 = arg_55_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_0 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1083"]) then
				if arg_55_1.var_.actorSpriteComps1083 then
					for iter_58_0, iter_58_1 in pairs(arg_55_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_58_1 then
							if arg_55_1.isInRecall_ then
								iter_58_1.color = Color.New(Mathf.Lerp(iter_58_1.color.r, arg_55_1.hightColor2.r, (arg_55_1.time_ - 0) / var_58_0), Mathf.Lerp(iter_58_1.color.g, arg_55_1.hightColor2.g, (arg_55_1.time_ - 0) / var_58_0), (Mathf.Lerp(iter_58_1.color.b, arg_55_1.hightColor2.b, (arg_55_1.time_ - 0) / var_58_0)))
							else
								local var_58_1 = Mathf.Lerp(iter_58_1.color.r, 0.5, (arg_55_1.time_ - 0) / var_58_0)

								iter_58_1.color = Color.New(var_58_1, var_58_1, var_58_1)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1083"]) and arg_55_1.var_.actorSpriteComps1083 then
				for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_58_3 then
						iter_58_3.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_55_1.var_.actorSpriteComps1083 = nil
			end

			local var_58_2 = arg_55_1.actors_["1083"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1083 = var_58_2.localPosition
				var_58_2.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("1083", 7)

				for iter_58_4 = 0, var_58_2.childCount - 1 do
					local var_58_3 = var_58_2:GetChild(iter_58_4)

					if var_58_3.name == "" or not string.find(var_58_3.name, "split") then
						var_58_3.gameObject:SetActive(true)
					else
						var_58_3.gameObject:SetActive(false)
					end
				end
			end

			local var_58_4 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				var_58_2.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_55_1.time_ - 0) / var_58_4)
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				var_58_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_58_5 = arg_55_1.actors_["3054"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos3054 = var_58_5.localPosition
				var_58_5.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("3054", 7)

				for iter_58_5 = 0, var_58_5.childCount - 1 do
					local var_58_6 = var_58_5:GetChild(iter_58_5)

					if var_58_6.name == "" or not string.find(var_58_6.name, "split") then
						var_58_6.gameObject:SetActive(true)
					else
						var_58_6.gameObject:SetActive(false)
					end
				end
			end

			local var_58_7 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 then
				var_58_5.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos3054, Vector3.New(0, -2000, 0), (arg_55_1.time_ - 0) / var_58_7)
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 then
				var_58_5.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:AudioAction("play", "effect", "se_story_141", "se_story_141_foley_cloth", "")
			end

			local var_58_9 = 0
			local var_58_10 = 1.1

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_9 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_11 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(423172013).content)

				arg_55_1.text_.text = var_58_11

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_13 = 46 <= 0 and var_58_10 or var_58_10 * (utf8.len(var_58_11) / 46)

				if (46 <= 0 and var_58_10 or var_58_10 * (utf8.len(var_58_11) / 46)) > 0 and var_58_10 < var_58_13 then
					arg_55_1.talkMaxDuration = var_58_13

					if var_58_13 + var_58_9 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_9
					end
				end

				arg_55_1.text_.text = var_58_11
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_14 = math.max(var_58_10, arg_55_1.talkMaxDuration)

			if var_58_9 <= arg_55_1.time_ and arg_55_1.time_ < var_58_9 + var_58_14 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_9) / var_58_14

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_9 + var_58_14 and arg_55_1.time_ < var_58_9 + var_58_14 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
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
				actorName = "3054",
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
	Play423172014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 423172014
		arg_59_1.duration_ = 2.33

		local var_59_0 = {
			zh = 2.333,
			ja = 2.2
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
				arg_59_0:Play423172015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["3054"]) and arg_59_1.var_.actorSpriteComps3054 == nil then
				arg_59_1.var_.actorSpriteComps3054 = arg_59_1.actors_["3054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_62_0 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["3054"]) then
				if arg_59_1.var_.actorSpriteComps3054 then
					for iter_62_0, iter_62_1 in pairs(arg_59_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_62_1 then
							if arg_59_1.isInRecall_ then
								iter_62_1.color = Color.New(Mathf.Lerp(iter_62_1.color.r, arg_59_1.hightColor1.r, (arg_59_1.time_ - 0) / var_62_0), Mathf.Lerp(iter_62_1.color.g, arg_59_1.hightColor1.g, (arg_59_1.time_ - 0) / var_62_0), (Mathf.Lerp(iter_62_1.color.b, arg_59_1.hightColor1.b, (arg_59_1.time_ - 0) / var_62_0)))
							else
								local var_62_1 = Mathf.Lerp(iter_62_1.color.r, 1, (arg_59_1.time_ - 0) / var_62_0)

								iter_62_1.color = Color.New(var_62_1, var_62_1, var_62_1)
							end
						end
					end
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["3054"]) and arg_59_1.var_.actorSpriteComps3054 then
				for iter_62_2, iter_62_3 in pairs(arg_59_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_62_3 then
						iter_62_3.color = arg_59_1.isInRecall_ and (arg_59_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_59_1.var_.actorSpriteComps3054 = nil
			end

			local var_62_2 = arg_59_1.actors_["3054"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos3054 = var_62_2.localPosition
				var_62_2.localScale = Vector3.New(1, 1, 1)

				arg_59_1:CheckSpriteTmpPos("3054", 3)

				for iter_62_4 = 0, var_62_2.childCount - 1 do
					local var_62_3 = var_62_2:GetChild(iter_62_4)

					if var_62_3.name == "split_2" or not string.find(var_62_3.name, "split") then
						var_62_3.gameObject:SetActive(true)
					else
						var_62_3.gameObject:SetActive(false)
					end
				end
			end

			local var_62_4 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				var_62_2.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_59_1.time_ - 0) / var_62_4)
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				var_62_2.localPosition = Vector3.New(0, -275, -280)
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				local var_62_5 = arg_59_1.actors_["3054"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_62_5 then
					arg_59_1.var_.alphaOldValue3054 = var_62_5.alpha
					arg_59_1.var_.characterEffect3054 = var_62_5
				end

				arg_59_1.var_.alphaOldValue3054 = 0
			end

			local var_62_6 = 0.5

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_6 then
				if arg_59_1.var_.characterEffect3054 then
					arg_59_1.var_.characterEffect3054.alpha = Mathf.Lerp(arg_59_1.var_.alphaOldValue3054, 1, (arg_59_1.time_ - 0) / var_62_6)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_6 and arg_59_1.time_ < 0 + var_62_6 + arg_62_0 and arg_59_1.var_.characterEffect3054 then
				arg_59_1.var_.characterEffect3054.alpha = 1
			end

			local var_62_7 = 0
			local var_62_8 = 0.175

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_7 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_9 = arg_59_1:GetWordFromCfg(423172014)
				local var_62_10 = arg_59_1:FormatText(var_62_9.content)

				arg_59_1.text_.text = var_62_10

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_12 = 7 <= 0 and var_62_8 or var_62_8 * (utf8.len(var_62_10) / 7)

				if (7 <= 0 and var_62_8 or var_62_8 * (utf8.len(var_62_10) / 7)) > 0 and var_62_8 < var_62_12 then
					arg_59_1.talkMaxDuration = var_62_12

					if var_62_12 + var_62_7 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_7
					end
				end

				arg_59_1.text_.text = var_62_10
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172014", "story_v_out_423172.awb") ~= 0 then
					local var_62_13 = manager.audio:GetVoiceLength("story_v_out_423172", "423172014", "story_v_out_423172.awb") / 1000

					if var_62_13 + var_62_7 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_7
					end

					if var_62_9.prefab_name ~= "" and arg_59_1.actors_[var_62_9.prefab_name] ~= nil then
						local var_62_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_9.prefab_name].transform, "story_v_out_423172", "423172014", "story_v_out_423172.awb")

						arg_59_1:RecordAudio("423172014", var_62_14)
						arg_59_1:RecordAudio("423172014", var_62_14)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_423172", "423172014", "story_v_out_423172.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_423172", "423172014", "story_v_out_423172.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_15 = math.max(var_62_8, arg_59_1.talkMaxDuration)

			if var_62_7 <= arg_59_1.time_ and arg_59_1.time_ < var_62_7 + var_62_15 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_7) / var_62_15

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_7 + var_62_15 and arg_59_1.time_ < var_62_7 + var_62_15 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play423172015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 423172015
		arg_63_1.duration_ = 6.4

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play423172016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_9000

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["3054"]) and arg_63_1.var_.actorSpriteComps3054 == nil then
				arg_63_1.var_.actorSpriteComps3054 = arg_63_1.actors_["3054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_66_0 = 0.034

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["3054"]) then
				if arg_63_1.var_.actorSpriteComps3054 then
					for iter_66_0, iter_66_1 in pairs(arg_63_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_66_1 then
							if arg_63_1.isInRecall_ then
								iter_66_1.color = Color.New(Mathf.Lerp(iter_66_1.color.r, arg_63_1.hightColor2.r, (arg_63_1.time_ - 0) / var_66_0), Mathf.Lerp(iter_66_1.color.g, arg_63_1.hightColor2.g, (arg_63_1.time_ - 0) / var_66_0), (Mathf.Lerp(iter_66_1.color.b, arg_63_1.hightColor2.b, (arg_63_1.time_ - 0) / var_66_0)))
							else
								local var_66_1 = Mathf.Lerp(iter_66_1.color.r, 0.5, (arg_63_1.time_ - 0) / var_66_0)

								iter_66_1.color = Color.New(var_66_1, var_66_1, var_66_1)
							end
						end
					end
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["3054"]) and arg_63_1.var_.actorSpriteComps3054 then
				for iter_66_2, iter_66_3 in pairs(arg_63_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_66_3 then
						iter_66_3.color = arg_63_1.isInRecall_ and (arg_63_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_63_1.var_.actorSpriteComps3054 = nil
			end

			local var_66_2 = arg_63_1.actors_["3054"].transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos3054 = var_66_2.localPosition
				var_66_2.localScale = Vector3.New(1, 1, 1)

				arg_63_1:CheckSpriteTmpPos("3054", 7)

				for iter_66_4 = 0, var_66_2.childCount - 1 do
					local var_66_3 = var_66_2:GetChild(iter_66_4)

					if var_66_3.name == "" or not string.find(var_66_3.name, "split") then
						var_66_3.gameObject:SetActive(true)
					else
						var_66_3.gameObject:SetActive(false)
					end
				end
			end

			local var_66_4 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				var_66_2.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos3054, Vector3.New(0, -2000, 0), (arg_63_1.time_ - 0) / var_66_4)
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				var_66_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				local var_66_5 = arg_63_1.var_.effectliechepaohong1

				if not arg_63_1.var_.effectliechepaohong1 then
					var_66_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), manager.ui.mainCamera.transform)
					var_66_5.name = "liechepaohong1"
					arg_63_1.var_.effectliechepaohong1 = var_66_5
				else
					var_66_5.transform:SetParent(var_66_9000)
				end

				var_66_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_66_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_66_7 = 0

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_7 + arg_66_0 then
				arg_63_1.allBtn_.enabled = false
			end

			if arg_63_1.time_ >= var_66_7 + 1.6 and arg_63_1.time_ < var_66_7 + 1.6 + arg_66_0 then
				arg_63_1.allBtn_.enabled = true
			end

			local var_66_8 = manager.ui.mainCamera.transform

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.shakeOldPos = var_66_8.localPosition
			end

			local var_66_9 = 1

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_9 then
				local var_66_10, var_66_11 = math.modf((arg_63_1.time_ - 0) / 0.066)

				var_66_8.localPosition = Vector3.New(var_66_11 * 0.13, var_66_11 * 0.13, var_66_11 * 0.13) + arg_63_1.var_.shakeOldPos
			end

			if arg_63_1.time_ >= 0 + var_66_9 and arg_63_1.time_ < 0 + var_66_9 + arg_66_0 then
				var_66_8.localPosition = arg_63_1.var_.shakeOldPos
			end

			local var_66_12

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				local var_66_13 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_66_13 then
					var_66_13.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_66_13.radialBlurScale = 0
					var_66_13.radialBlurGradient = 1
					var_66_13.radialBlurIntensity = 1

					if var_66_12 then
						var_66_13.radialBlurTarget = var_66_12.transform
					end
				end
			end

			local var_66_14 = 0.1

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_14 then
				local var_66_15 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_66_15 then
					var_66_15.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_66_15.radialBlurScale = Mathf.Lerp(0, 0, (arg_63_1.time_ - 0) / var_66_14)
					var_66_15.radialBlurGradient = Mathf.Lerp(1, 1, (arg_63_1.time_ - 0) / var_66_14)
					var_66_15.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_63_1.time_ - 0) / var_66_14)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_14 and arg_63_1.time_ < 0 + var_66_14 + arg_66_0 then
				local var_66_16 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_66_16 then
					var_66_16.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_66_16.radialBlurScale = 0
					var_66_16.radialBlurGradient = 1
					var_66_16.radialBlurIntensity = 1
				end
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:AudioAction("play", "effect", "se_story_140", "se_story_140_laser", "")
			end

			if arg_63_1.frameCnt_ <= 1 then
				arg_63_1.dialog_:SetActive(false)
			end

			local var_66_18 = 1.4
			local var_66_19 = 1.175

			if 1.4 < arg_63_1.time_ and arg_63_1.time_ <= var_66_18 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0

				arg_63_1.dialog_:SetActive(true)

				arg_63_1.dialogCg_.alpha = 0

				local var_66_20 = LeanTween.value(arg_63_1.dialog_, 0, 1, 0.3)

				var_66_20:setOnUpdate(LuaHelper.FloatAction(function(arg_67_0)
					arg_63_1.dialogCg_.alpha = arg_67_0
				end))
				var_66_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_63_1.dialog_)
					var_66_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_63_1.duration_ = arg_63_1.duration_ + 0.3

				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_21 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(423172015).content)

				arg_63_1.text_.text = var_66_21

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_23 = 47 <= 0 and var_66_19 or var_66_19 * (utf8.len(var_66_21) / 47)

				if (47 <= 0 and var_66_19 or var_66_19 * (utf8.len(var_66_21) / 47)) > 0 and var_66_19 < var_66_23 then
					arg_63_1.talkMaxDuration = var_66_23
					var_66_18 = var_66_18 + 0.3

					if var_66_23 + var_66_18 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_23 + var_66_18
					end
				end

				arg_63_1.text_.text = var_66_21
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_24 = var_66_18 + 0.3
			local var_66_25 = math.max(var_66_19, arg_63_1.talkMaxDuration)

			if var_66_18 + 0.3 <= arg_63_1.time_ and arg_63_1.time_ < var_66_24 + var_66_25 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_24) / var_66_25

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_24 + var_66_25 and arg_63_1.time_ < var_66_24 + var_66_25 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423172016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 423172016
		arg_69_1.duration_ = 12.57

		local var_69_0 = {
			zh = 12.566,
			ja = 11.433
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
				arg_69_0:Play423172017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_9001
			local var_72_9000

			if arg_69_1.bgs_.ST0113a == nil then
				local var_72_0 = Object.Instantiate(arg_69_1.paintGo_)

				var_72_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0113a")
				var_72_0.name = "ST0113a"
				var_72_0.transform.parent = arg_69_1.stage_.transform
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_.ST0113a = var_72_0
			end

			if 1.999999999999 < arg_69_1.time_ and arg_69_1.time_ <= 1.999999999999 + arg_72_0 then
				local var_72_1 = arg_69_1.bgs_.ST0113a

				arg_69_1.bgs_.ST0113a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_72_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_2 = var_72_1:GetComponent("SpriteRenderer")

				if var_72_2 and var_72_2.sprite then
					local var_72_3 = 2 * (var_72_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_72_1.transform.localScale = Vector3.New(var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, var_72_3 / var_72_2.sprite.bounds.size.y < var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x and var_72_3 * manager.ui.mainCameraCom_.aspect / var_72_2.sprite.bounds.size.x or var_72_3 / var_72_2.sprite.bounds.size.y, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "ST0113a" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_4 = 3.999999999999

			if 3.999999999999 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			if arg_69_1.time_ >= var_72_4 + 0.3 and arg_69_1.time_ < var_72_4 + 0.3 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			local var_72_5 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_6 = 2

			if var_72_5 <= arg_69_1.time_ and arg_69_1.time_ < var_72_5 + var_72_6 then
				local var_72_7 = Color.New(0, 0, 0)

				var_72_7.a = Mathf.Lerp(0, 1, (arg_69_1.time_ - var_72_5) / var_72_6)
				arg_69_1.mask_.color = var_72_7
			end

			if arg_69_1.time_ >= var_72_5 + var_72_6 and arg_69_1.time_ < var_72_5 + var_72_6 + arg_72_0 then
				local var_72_8 = Color.New(0, 0, 0)

				var_72_8.a = 1
				arg_69_1.mask_.color = var_72_8
			end

			local var_72_9 = 2

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_9 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_10 = 2

			if var_72_9 <= arg_69_1.time_ and arg_69_1.time_ < var_72_9 + var_72_10 then
				local var_72_11 = Color.New(0, 0, 0)

				var_72_11.a = Mathf.Lerp(1, 0, (arg_69_1.time_ - var_72_9) / var_72_10)
				arg_69_1.mask_.color = var_72_11
			end

			if arg_69_1.time_ >= var_72_9 + var_72_10 and arg_69_1.time_ < var_72_9 + var_72_10 + arg_72_0 then
				local var_72_12 = Color.New(0, 0, 0)

				arg_69_1.mask_.enabled = false
				var_72_12.a = 0
				arg_69_1.mask_.color = var_72_12
			end

			if 2 < arg_69_1.time_ and arg_69_1.time_ <= 2 + arg_72_0 then
				if arg_69_1.var_.effectchedingzuozhan1 then
					Object.Destroy(arg_69_1.var_.effectchedingzuozhan1)

					arg_69_1.var_.effectchedingzuozhan1 = nil
				end
			end

			if 1.999999999999 < arg_69_1.time_ and arg_69_1.time_ <= 1.999999999999 + arg_72_0 then
				local var_72_14 = arg_69_1.var_.effecthuangyuanbaoyu1

				if not arg_69_1.var_.effecthuangyuanbaoyu1 then
					var_72_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy"), manager.ui.mainCamera.transform)
					var_72_14.name = "huangyuanbaoyu1"
					arg_69_1.var_.effecthuangyuanbaoyu1 = var_72_14
				else
					var_72_14.transform:SetParent(var_72_9001)
				end

				var_72_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_72_14.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_72_16 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_72_2, iter_72_3 in ipairs((var_72_14.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_72_3.transform.localScale = Vector3.New(iter_72_3.transform.localScale.x / var_72_16 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_72_3.transform.localScale.y / var_72_16, iter_72_3.transform.localScale.z)
				end
			end

			if 1.999999999999 < arg_69_1.time_ and arg_69_1.time_ <= 1.999999999999 + arg_72_0 then
				local var_72_18 = arg_69_1.var_.effecthuangyuanbaoyu1

				if not arg_69_1.var_.effecthuangyuanbaoyu1 then
					var_72_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rain_heavy"), manager.ui.mainCamera.transform)
					var_72_18.name = "huangyuanbaoyu1"
					arg_69_1.var_.effecthuangyuanbaoyu1 = var_72_18
				else
					var_72_18.transform:SetParent(var_72_9000)
				end

				var_72_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_72_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.333333333333333 < arg_69_1.time_ and arg_69_1.time_ <= 0.333333333333333 + arg_72_0 then
				arg_69_1:AudioAction("stop", "effect", "se_story_144", "se_story_144_amb_train_roof", "")
			end

			if 1.8 < arg_69_1.time_ and arg_69_1.time_ <= 1.8 + arg_72_0 then
				arg_69_1:AudioAction("play", "effect", "se_story_side_1058", "se_story_side_1058_rain_loop", "")
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_22 = 4
			local var_72_23 = 0.525

			if 4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_22 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_24 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_24:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1083_split_4")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_25 = arg_69_1:GetWordFromCfg(423172016)
				local var_72_26 = arg_69_1:FormatText(var_72_25.content)

				arg_69_1.text_.text = var_72_26

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_28 = 21 <= 0 and var_72_23 or var_72_23 * (utf8.len(var_72_26) / 21)

				if (21 <= 0 and var_72_23 or var_72_23 * (utf8.len(var_72_26) / 21)) > 0 and var_72_23 < var_72_28 then
					arg_69_1.talkMaxDuration = var_72_28
					var_72_22 = var_72_22 + 0.3

					if var_72_28 + var_72_22 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_28 + var_72_22
					end
				end

				arg_69_1.text_.text = var_72_26
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172016", "story_v_out_423172.awb") ~= 0 then
					local var_72_29 = manager.audio:GetVoiceLength("story_v_out_423172", "423172016", "story_v_out_423172.awb") / 1000

					if var_72_29 + var_72_22 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_29 + var_72_22
					end

					if var_72_25.prefab_name ~= "" and arg_69_1.actors_[var_72_25.prefab_name] ~= nil then
						local var_72_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_25.prefab_name].transform, "story_v_out_423172", "423172016", "story_v_out_423172.awb")

						arg_69_1:RecordAudio("423172016", var_72_30)
						arg_69_1:RecordAudio("423172016", var_72_30)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_423172", "423172016", "story_v_out_423172.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_423172", "423172016", "story_v_out_423172.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_31 = var_72_22 + 0.3
			local var_72_32 = math.max(var_72_23, arg_69_1.talkMaxDuration)

			if var_72_22 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_31 + var_72_32 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_31) / var_72_32

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_31 + var_72_32 and arg_69_1.time_ < var_72_31 + var_72_32 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play423172017 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 423172017
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play423172018(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 1.7

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(423172017).content)

				arg_75_1.text_.text = var_78_1

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_3 = 68 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 68)

				if (68 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_1) / 68)) > 0 and var_78_0 < var_78_3 then
					arg_75_1.talkMaxDuration = var_78_3

					if var_78_3 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_3 + 0
					end
				end

				arg_75_1.text_.text = var_78_1
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_4 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_4 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_4

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_4 and arg_75_1.time_ < 0 + var_78_4 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play423172018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 423172018
		arg_79_1.duration_ = 7.2

		local var_79_0 = {
			zh = 7.2,
			ja = 6.866
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
				arg_79_0:Play423172019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["1083"]) and arg_79_1.var_.actorSpriteComps1083 == nil then
				arg_79_1.var_.actorSpriteComps1083 = arg_79_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_82_0 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["1083"]) then
				if arg_79_1.var_.actorSpriteComps1083 then
					for iter_82_0, iter_82_1 in pairs(arg_79_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_82_1 then
							if arg_79_1.isInRecall_ then
								iter_82_1.color = Color.New(Mathf.Lerp(iter_82_1.color.r, arg_79_1.hightColor1.r, (arg_79_1.time_ - 0) / var_82_0), Mathf.Lerp(iter_82_1.color.g, arg_79_1.hightColor1.g, (arg_79_1.time_ - 0) / var_82_0), (Mathf.Lerp(iter_82_1.color.b, arg_79_1.hightColor1.b, (arg_79_1.time_ - 0) / var_82_0)))
							else
								local var_82_1 = Mathf.Lerp(iter_82_1.color.r, 1, (arg_79_1.time_ - 0) / var_82_0)

								iter_82_1.color = Color.New(var_82_1, var_82_1, var_82_1)
							end
						end
					end
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["1083"]) and arg_79_1.var_.actorSpriteComps1083 then
				for iter_82_2, iter_82_3 in pairs(arg_79_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_82_3 then
						iter_82_3.color = arg_79_1.isInRecall_ and (arg_79_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_79_1.var_.actorSpriteComps1083 = nil
			end

			local var_82_2 = arg_79_1.actors_["1083"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1083 = var_82_2.localPosition
				var_82_2.localScale = Vector3.New(1, 1, 1)

				arg_79_1:CheckSpriteTmpPos("1083", 3)

				for iter_82_4 = 0, var_82_2.childCount - 1 do
					local var_82_3 = var_82_2:GetChild(iter_82_4)

					if var_82_3.name == "split_4" or not string.find(var_82_3.name, "split") then
						var_82_3.gameObject:SetActive(true)
					else
						var_82_3.gameObject:SetActive(false)
					end
				end
			end

			local var_82_4 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 then
				var_82_2.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_79_1.time_ - 0) / var_82_4)
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 then
				var_82_2.localPosition = Vector3.New(-50, -345, -345)
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				local var_82_5 = arg_79_1.actors_["1083"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_82_5 then
					arg_79_1.var_.alphaOldValue1083 = var_82_5.alpha
					arg_79_1.var_.characterEffect1083 = var_82_5
				end

				arg_79_1.var_.alphaOldValue1083 = 0
			end

			local var_82_6 = 0.5

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_6 then
				if arg_79_1.var_.characterEffect1083 then
					arg_79_1.var_.characterEffect1083.alpha = Mathf.Lerp(arg_79_1.var_.alphaOldValue1083, 1, (arg_79_1.time_ - 0) / var_82_6)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_6 and arg_79_1.time_ < 0 + var_82_6 + arg_82_0 and arg_79_1.var_.characterEffect1083 then
				arg_79_1.var_.characterEffect1083.alpha = 1
			end

			local var_82_7 = 0
			local var_82_8 = 0.4

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_9 = arg_79_1:GetWordFromCfg(423172018)
				local var_82_10 = arg_79_1:FormatText(var_82_9.content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_12 = 16 <= 0 and var_82_8 or var_82_8 * (utf8.len(var_82_10) / 16)

				if (16 <= 0 and var_82_8 or var_82_8 * (utf8.len(var_82_10) / 16)) > 0 and var_82_8 < var_82_12 then
					arg_79_1.talkMaxDuration = var_82_12

					if var_82_12 + var_82_7 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_12 + var_82_7
					end
				end

				arg_79_1.text_.text = var_82_10
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172018", "story_v_out_423172.awb") ~= 0 then
					local var_82_13 = manager.audio:GetVoiceLength("story_v_out_423172", "423172018", "story_v_out_423172.awb") / 1000

					if var_82_13 + var_82_7 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_7
					end

					if var_82_9.prefab_name ~= "" and arg_79_1.actors_[var_82_9.prefab_name] ~= nil then
						local var_82_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_9.prefab_name].transform, "story_v_out_423172", "423172018", "story_v_out_423172.awb")

						arg_79_1:RecordAudio("423172018", var_82_14)
						arg_79_1:RecordAudio("423172018", var_82_14)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_423172", "423172018", "story_v_out_423172.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_423172", "423172018", "story_v_out_423172.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_15 = math.max(var_82_8, arg_79_1.talkMaxDuration)

			if var_82_7 <= arg_79_1.time_ and arg_79_1.time_ < var_82_7 + var_82_15 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_7) / var_82_15

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_7 + var_82_15 and arg_79_1.time_ < var_82_7 + var_82_15 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
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

		arg_79_1:InitPlayNodeList()
	end,
	Play423172019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 423172019
		arg_83_1.duration_ = 5.8

		local var_83_0 = {
			zh = 5.8,
			ja = 5.333
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
				arg_83_0:Play423172020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1083"]) and arg_83_1.var_.actorSpriteComps1083 == nil then
				arg_83_1.var_.actorSpriteComps1083 = arg_83_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1083"]) then
				if arg_83_1.var_.actorSpriteComps1083 then
					for iter_86_0, iter_86_1 in pairs(arg_83_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_86_1 then
							if arg_83_1.isInRecall_ then
								iter_86_1.color = Color.New(Mathf.Lerp(iter_86_1.color.r, arg_83_1.hightColor2.r, (arg_83_1.time_ - 0) / var_86_0), Mathf.Lerp(iter_86_1.color.g, arg_83_1.hightColor2.g, (arg_83_1.time_ - 0) / var_86_0), (Mathf.Lerp(iter_86_1.color.b, arg_83_1.hightColor2.b, (arg_83_1.time_ - 0) / var_86_0)))
							else
								local var_86_1 = Mathf.Lerp(iter_86_1.color.r, 0.5, (arg_83_1.time_ - 0) / var_86_0)

								iter_86_1.color = Color.New(var_86_1, var_86_1, var_86_1)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1083"]) and arg_83_1.var_.actorSpriteComps1083 then
				for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_86_3 then
						iter_86_3.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_83_1.var_.actorSpriteComps1083 = nil
			end

			local var_86_2 = 0
			local var_86_3 = 0.425

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_2 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, true)
				arg_83_1.iconController_:SetSelectedState("hero")

				arg_83_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054_split_1")

				arg_83_1.callingController_:SetSelectedState("normal")

				arg_83_1.keyicon_.color = Color.New(1, 1, 1)
				arg_83_1.icon_.color = Color.New(1, 1, 1)

				local var_86_4 = arg_83_1:GetWordFromCfg(423172019)
				local var_86_5 = arg_83_1:FormatText(var_86_4.content)

				arg_83_1.text_.text = var_86_5

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_7 = 17 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_5) / 17)

				if (17 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_5) / 17)) > 0 and var_86_3 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_2
					end
				end

				arg_83_1.text_.text = var_86_5
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172019", "story_v_out_423172.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_423172", "423172019", "story_v_out_423172.awb") / 1000

					if var_86_8 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_2
					end

					if var_86_4.prefab_name ~= "" and arg_83_1.actors_[var_86_4.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_4.prefab_name].transform, "story_v_out_423172", "423172019", "story_v_out_423172.awb")

						arg_83_1:RecordAudio("423172019", var_86_9)
						arg_83_1:RecordAudio("423172019", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_423172", "423172019", "story_v_out_423172.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_423172", "423172019", "story_v_out_423172.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_3, arg_83_1.talkMaxDuration)

			if var_86_2 <= arg_83_1.time_ and arg_83_1.time_ < var_86_2 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_2) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_2 + var_86_10 and arg_83_1.time_ < var_86_2 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play423172020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 423172020
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play423172021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1083 = arg_87_1.actors_["1083"].transform.localPosition
				arg_87_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("1083", 7)

				for iter_90_0 = 0, arg_87_1.actors_["1083"].transform.childCount - 1 do
					local var_90_0 = arg_87_1.actors_["1083"].transform:GetChild(iter_90_0)

					if var_90_0.name == "" or not string.find(var_90_0.name, "split") then
						var_90_0.gameObject:SetActive(true)
					else
						var_90_0.gameObject:SetActive(false)
					end
				end
			end

			local var_90_1 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_1 then
				arg_87_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_87_1.time_ - 0) / var_90_1)
			end

			if arg_87_1.time_ >= 0 + var_90_1 and arg_87_1.time_ < 0 + var_90_1 + arg_90_0 then
				arg_87_1.actors_["1083"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.166666666666667 < arg_87_1.time_ and arg_87_1.time_ <= 0.166666666666667 + arg_90_0 then
				arg_87_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_gun01", "")
			end

			local var_90_3 = 0
			local var_90_4 = 1.7

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_3 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, false)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_5 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(423172020).content)

				arg_87_1.text_.text = var_90_5

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_7 = 68 <= 0 and var_90_4 or var_90_4 * (utf8.len(var_90_5) / 68)

				if (68 <= 0 and var_90_4 or var_90_4 * (utf8.len(var_90_5) / 68)) > 0 and var_90_4 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_3 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_3
					end
				end

				arg_87_1.text_.text = var_90_5
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_8 = math.max(var_90_4, arg_87_1.talkMaxDuration)

			if var_90_3 <= arg_87_1.time_ and arg_87_1.time_ < var_90_3 + var_90_8 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_3) / var_90_8

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_3 + var_90_8 and arg_87_1.time_ < var_90_3 + var_90_8 + arg_90_0 then
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
	Play423172021 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 423172021
		arg_91_1.duration_ = 10.23

		local var_91_0 = {
			zh = 7.766,
			ja = 10.233
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
				arg_91_0:Play423172022(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos3054 = arg_91_1.actors_["3054"].transform.localPosition
				arg_91_1.actors_["3054"].transform.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("3054", 3)

				for iter_94_0 = 0, arg_91_1.actors_["3054"].transform.childCount - 1 do
					local var_94_0 = arg_91_1.actors_["3054"].transform:GetChild(iter_94_0)

					if var_94_0.name == "split_1" or not string.find(var_94_0.name, "split") then
						var_94_0.gameObject:SetActive(true)
					else
						var_94_0.gameObject:SetActive(false)
					end
				end
			end

			local var_94_1 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_1 then
				arg_91_1.actors_["3054"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_91_1.time_ - 0) / var_94_1)
			end

			if arg_91_1.time_ >= 0 + var_94_1 and arg_91_1.time_ < 0 + var_94_1 + arg_94_0 then
				arg_91_1.actors_["3054"].transform.localPosition = Vector3.New(0, -275, -280)
			end

			local var_94_2 = arg_91_1.actors_["3054"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.actorSpriteComps3054 == nil then
				arg_91_1.var_.actorSpriteComps3054 = var_94_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_3 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 and not isNil(var_94_2) then
				if arg_91_1.var_.actorSpriteComps3054 then
					for iter_94_1, iter_94_2 in pairs(arg_91_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_94_2 then
							if arg_91_1.isInRecall_ then
								iter_94_2.color = Color.New(Mathf.Lerp(iter_94_2.color.r, arg_91_1.hightColor1.r, (arg_91_1.time_ - 0) / var_94_3), Mathf.Lerp(iter_94_2.color.g, arg_91_1.hightColor1.g, (arg_91_1.time_ - 0) / var_94_3), (Mathf.Lerp(iter_94_2.color.b, arg_91_1.hightColor1.b, (arg_91_1.time_ - 0) / var_94_3)))
							else
								local var_94_4 = Mathf.Lerp(iter_94_2.color.r, 1, (arg_91_1.time_ - 0) / var_94_3)

								iter_94_2.color = Color.New(var_94_4, var_94_4, var_94_4)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.actorSpriteComps3054 then
				for iter_94_3, iter_94_4 in pairs(arg_91_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_94_4 then
						iter_94_4.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_91_1.var_.actorSpriteComps3054 = nil
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				local var_94_5 = arg_91_1.actors_["3054"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_94_5 then
					arg_91_1.var_.alphaOldValue3054 = var_94_5.alpha
					arg_91_1.var_.characterEffect3054 = var_94_5
				end

				arg_91_1.var_.alphaOldValue3054 = 0
			end

			local var_94_6 = 0.5

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_6 then
				if arg_91_1.var_.characterEffect3054 then
					arg_91_1.var_.characterEffect3054.alpha = Mathf.Lerp(arg_91_1.var_.alphaOldValue3054, 1, (arg_91_1.time_ - 0) / var_94_6)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_6 and arg_91_1.time_ < 0 + var_94_6 + arg_94_0 and arg_91_1.var_.characterEffect3054 then
				arg_91_1.var_.characterEffect3054.alpha = 1
			end

			local var_94_7 = 0
			local var_94_8 = 0.725

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_7 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_9 = arg_91_1:GetWordFromCfg(423172021)
				local var_94_10 = arg_91_1:FormatText(var_94_9.content)

				arg_91_1.text_.text = var_94_10

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_12 = 29 <= 0 and var_94_8 or var_94_8 * (utf8.len(var_94_10) / 29)

				if (29 <= 0 and var_94_8 or var_94_8 * (utf8.len(var_94_10) / 29)) > 0 and var_94_8 < var_94_12 then
					arg_91_1.talkMaxDuration = var_94_12

					if var_94_12 + var_94_7 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_12 + var_94_7
					end
				end

				arg_91_1.text_.text = var_94_10
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172021", "story_v_out_423172.awb") ~= 0 then
					local var_94_13 = manager.audio:GetVoiceLength("story_v_out_423172", "423172021", "story_v_out_423172.awb") / 1000

					if var_94_13 + var_94_7 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_13 + var_94_7
					end

					if var_94_9.prefab_name ~= "" and arg_91_1.actors_[var_94_9.prefab_name] ~= nil then
						local var_94_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_9.prefab_name].transform, "story_v_out_423172", "423172021", "story_v_out_423172.awb")

						arg_91_1:RecordAudio("423172021", var_94_14)
						arg_91_1:RecordAudio("423172021", var_94_14)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_423172", "423172021", "story_v_out_423172.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_423172", "423172021", "story_v_out_423172.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_15 = math.max(var_94_8, arg_91_1.talkMaxDuration)

			if var_94_7 <= arg_91_1.time_ and arg_91_1.time_ < var_94_7 + var_94_15 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_7) / var_94_15

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_7 + var_94_15 and arg_91_1.time_ < var_94_7 + var_94_15 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423172022 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 423172022
		arg_95_1.duration_ = 6.63

		local var_95_0 = {
			zh = 6.1,
			ja = 6.633
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
				arg_95_0:Play423172023(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.525

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:GetWordFromCfg(423172022)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 21 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 21)

				if (21 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 21)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172022", "story_v_out_423172.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172022", "story_v_out_423172.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_out_423172", "423172022", "story_v_out_423172.awb")

						arg_95_1:RecordAudio("423172022", var_98_6)
						arg_95_1:RecordAudio("423172022", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_423172", "423172022", "story_v_out_423172.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_423172", "423172022", "story_v_out_423172.awb")
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
	Play423172023 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 423172023
		arg_99_1.duration_ = 6.43

		local var_99_0 = {
			zh = 5.4,
			ja = 6.433
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
				arg_99_0:Play423172024(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.475

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_1 = arg_99_1:GetWordFromCfg(423172023)
				local var_102_2 = arg_99_1:FormatText(var_102_1.content)

				arg_99_1.text_.text = var_102_2

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_4 = 19 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 19)

				if (19 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_2) / 19)) > 0 and var_102_0 < var_102_4 then
					arg_99_1.talkMaxDuration = var_102_4

					if var_102_4 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_4 + 0
					end
				end

				arg_99_1.text_.text = var_102_2
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172023", "story_v_out_423172.awb") ~= 0 then
					local var_102_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172023", "story_v_out_423172.awb") / 1000

					if var_102_5 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_5 + 0
					end

					if var_102_1.prefab_name ~= "" and arg_99_1.actors_[var_102_1.prefab_name] ~= nil then
						local var_102_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_1.prefab_name].transform, "story_v_out_423172", "423172023", "story_v_out_423172.awb")

						arg_99_1:RecordAudio("423172023", var_102_6)
						arg_99_1:RecordAudio("423172023", var_102_6)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_423172", "423172023", "story_v_out_423172.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_423172", "423172023", "story_v_out_423172.awb")
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
	Play423172024 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 423172024
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play423172025(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0.034 < arg_103_1.time_ and arg_103_1.time_ <= 0.034 + arg_106_0 then
				arg_103_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep01", "")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				local var_106_1 = arg_103_1.actors_["3054"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_106_1 then
					arg_103_1.var_.alphaOldValue3054 = var_106_1.alpha
					arg_103_1.var_.characterEffect3054 = var_106_1
				end

				arg_103_1.var_.alphaOldValue3054 = 1
			end

			local var_106_2 = 0.5

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 then
				if arg_103_1.var_.characterEffect3054 then
					arg_103_1.var_.characterEffect3054.alpha = Mathf.Lerp(arg_103_1.var_.alphaOldValue3054, 0, (arg_103_1.time_ - 0) / var_106_2)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and arg_103_1.var_.characterEffect3054 then
				arg_103_1.var_.characterEffect3054.alpha = 0
			end

			local var_106_3 = 0
			local var_106_4 = 1.475

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_3 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_5 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(423172024).content)

				arg_103_1.text_.text = var_106_5

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_7 = 59 <= 0 and var_106_4 or var_106_4 * (utf8.len(var_106_5) / 59)

				if (59 <= 0 and var_106_4 or var_106_4 * (utf8.len(var_106_5) / 59)) > 0 and var_106_4 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_3 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_3
					end
				end

				arg_103_1.text_.text = var_106_5
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_8 = math.max(var_106_4, arg_103_1.talkMaxDuration)

			if var_106_3 <= arg_103_1.time_ and arg_103_1.time_ < var_106_3 + var_106_8 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_3) / var_106_8

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_3 + var_106_8 and arg_103_1.time_ < var_106_3 + var_106_8 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play423172025 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 423172025
		arg_107_1.duration_ = 7.53

		local var_107_0 = {
			zh = 7.533,
			ja = 5.733
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
				arg_107_0:Play423172026(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos3054 = arg_107_1.actors_["3054"].transform.localPosition
				arg_107_1.actors_["3054"].transform.localScale = Vector3.New(1, 1, 1)

				arg_107_1:CheckSpriteTmpPos("3054", 3)

				for iter_110_0 = 0, arg_107_1.actors_["3054"].transform.childCount - 1 do
					local var_110_0 = arg_107_1.actors_["3054"].transform:GetChild(iter_110_0)

					if var_110_0.name == "split_1" or not string.find(var_110_0.name, "split") then
						var_110_0.gameObject:SetActive(true)
					else
						var_110_0.gameObject:SetActive(false)
					end
				end
			end

			local var_110_1 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_1 then
				arg_107_1.actors_["3054"].transform.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_107_1.time_ - 0) / var_110_1)
			end

			if arg_107_1.time_ >= 0 + var_110_1 and arg_107_1.time_ < 0 + var_110_1 + arg_110_0 then
				arg_107_1.actors_["3054"].transform.localPosition = Vector3.New(0, -275, -280)
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				local var_110_2 = arg_107_1.actors_["3054"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_110_2 then
					arg_107_1.var_.alphaOldValue3054 = var_110_2.alpha
					arg_107_1.var_.characterEffect3054 = var_110_2
				end

				arg_107_1.var_.alphaOldValue3054 = 0
			end

			local var_110_3 = 0.5

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_3 then
				if arg_107_1.var_.characterEffect3054 then
					arg_107_1.var_.characterEffect3054.alpha = Mathf.Lerp(arg_107_1.var_.alphaOldValue3054, 1, (arg_107_1.time_ - 0) / var_110_3)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_3 and arg_107_1.time_ < 0 + var_110_3 + arg_110_0 and arg_107_1.var_.characterEffect3054 then
				arg_107_1.var_.characterEffect3054.alpha = 1
			end

			local var_110_4 = 0
			local var_110_5 = 0.8

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_4 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_6 = arg_107_1:GetWordFromCfg(423172025)
				local var_110_7 = arg_107_1:FormatText(var_110_6.content)

				arg_107_1.text_.text = var_110_7

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_9 = 32 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 32)

				if (32 <= 0 and var_110_5 or var_110_5 * (utf8.len(var_110_7) / 32)) > 0 and var_110_5 < var_110_9 then
					arg_107_1.talkMaxDuration = var_110_9

					if var_110_9 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_9 + var_110_4
					end
				end

				arg_107_1.text_.text = var_110_7
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172025", "story_v_out_423172.awb") ~= 0 then
					local var_110_10 = manager.audio:GetVoiceLength("story_v_out_423172", "423172025", "story_v_out_423172.awb") / 1000

					if var_110_10 + var_110_4 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_10 + var_110_4
					end

					if var_110_6.prefab_name ~= "" and arg_107_1.actors_[var_110_6.prefab_name] ~= nil then
						local var_110_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_6.prefab_name].transform, "story_v_out_423172", "423172025", "story_v_out_423172.awb")

						arg_107_1:RecordAudio("423172025", var_110_11)
						arg_107_1:RecordAudio("423172025", var_110_11)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_423172", "423172025", "story_v_out_423172.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_423172", "423172025", "story_v_out_423172.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_12 = math.max(var_110_5, arg_107_1.talkMaxDuration)

			if var_110_4 <= arg_107_1.time_ and arg_107_1.time_ < var_110_4 + var_110_12 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_4) / var_110_12

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_4 + var_110_12 and arg_107_1.time_ < var_110_4 + var_110_12 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423172026 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 423172026
		arg_111_1.duration_ = 6.93

		local var_111_0 = {
			zh = 6.933,
			ja = 5.7
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
				arg_111_0:Play423172027(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0.6

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_1 = arg_111_1:GetWordFromCfg(423172026)
				local var_114_2 = arg_111_1:FormatText(var_114_1.content)

				arg_111_1.text_.text = var_114_2

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 24 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 24)

				if (24 <= 0 and var_114_0 or var_114_0 * (utf8.len(var_114_2) / 24)) > 0 and var_114_0 < var_114_4 then
					arg_111_1.talkMaxDuration = var_114_4

					if var_114_4 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_4 + 0
					end
				end

				arg_111_1.text_.text = var_114_2
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172026", "story_v_out_423172.awb") ~= 0 then
					local var_114_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172026", "story_v_out_423172.awb") / 1000

					if var_114_5 + 0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + 0
					end

					if var_114_1.prefab_name ~= "" and arg_111_1.actors_[var_114_1.prefab_name] ~= nil then
						local var_114_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_1.prefab_name].transform, "story_v_out_423172", "423172026", "story_v_out_423172.awb")

						arg_111_1:RecordAudio("423172026", var_114_6)
						arg_111_1:RecordAudio("423172026", var_114_6)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_423172", "423172026", "story_v_out_423172.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_423172", "423172026", "story_v_out_423172.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_0, arg_111_1.talkMaxDuration)

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - 0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= 0 + var_114_7 and arg_111_1.time_ < 0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play423172027 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 423172027
		arg_115_1.duration_ = 6.5

		local var_115_0 = {
			zh = 6.5,
			ja = 4.066
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
				arg_115_0:Play423172028(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.675

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:GetWordFromCfg(423172027)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 27 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 27)

				if (27 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 27)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172027", "story_v_out_423172.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172027", "story_v_out_423172.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_out_423172", "423172027", "story_v_out_423172.awb")

						arg_115_1:RecordAudio("423172027", var_118_6)
						arg_115_1:RecordAudio("423172027", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_423172", "423172027", "story_v_out_423172.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_423172", "423172027", "story_v_out_423172.awb")
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
	Play423172028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 423172028
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play423172029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0.166666666666667 < arg_119_1.time_ and arg_119_1.time_ <= 0.166666666666667 + arg_122_0 then
				arg_119_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_footstep03", "")
			end

			local var_122_1 = arg_119_1.actors_["3054"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos3054 = var_122_1.localPosition
				var_122_1.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("3054", 7)

				for iter_122_0 = 0, var_122_1.childCount - 1 do
					local var_122_2 = var_122_1:GetChild(iter_122_0)

					if var_122_2.name == "split_1" or not string.find(var_122_2.name, "split") then
						var_122_2.gameObject:SetActive(true)
					else
						var_122_2.gameObject:SetActive(false)
					end
				end
			end

			local var_122_3 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_3 then
				var_122_1.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos3054, Vector3.New(0, -2000, 0), (arg_119_1.time_ - 0) / var_122_3)
			end

			if arg_119_1.time_ >= 0 + var_122_3 and arg_119_1.time_ < 0 + var_122_3 + arg_122_0 then
				var_122_1.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_122_4 = 0
			local var_122_5 = 1.75

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_6 = arg_119_1:FormatText(arg_119_1:GetWordFromCfg(423172028).content)

				arg_119_1.text_.text = var_122_6

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_8 = 70 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_6) / 70)

				if (70 <= 0 and var_122_5 or var_122_5 * (utf8.len(var_122_6) / 70)) > 0 and var_122_5 < var_122_8 then
					arg_119_1.talkMaxDuration = var_122_8

					if var_122_8 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_6
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_9 = math.max(var_122_5, arg_119_1.talkMaxDuration)

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_9 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_4) / var_122_9

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_4 + var_122_9 and arg_119_1.time_ < var_122_4 + var_122_9 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423172029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 423172029
		arg_123_1.duration_ = 3.87

		local var_123_0 = {
			zh = 2.1,
			ja = 3.866
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
				arg_123_0:Play423172030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["1083"]) and arg_123_1.var_.actorSpriteComps1083 == nil then
				arg_123_1.var_.actorSpriteComps1083 = arg_123_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_0 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["1083"]) then
				if arg_123_1.var_.actorSpriteComps1083 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["1083"]) and arg_123_1.var_.actorSpriteComps1083 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_126_3 then
						iter_126_3.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_123_1.var_.actorSpriteComps1083 = nil
			end

			local var_126_2 = arg_123_1.actors_["1083"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1083 = var_126_2.localPosition
				var_126_2.localScale = Vector3.New(1, 1, 1)

				arg_123_1:CheckSpriteTmpPos("1083", 4)

				for iter_126_4 = 0, var_126_2.childCount - 1 do
					local var_126_3 = var_126_2:GetChild(iter_126_4)

					if var_126_3.name == "split_7" or not string.find(var_126_3.name, "split") then
						var_126_3.gameObject:SetActive(true)
					else
						var_126_3.gameObject:SetActive(false)
					end
				end
			end

			local var_126_4 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				var_126_2.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1083, Vector3.New(390, -345, -345), (arg_123_1.time_ - 0) / var_126_4)
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				var_126_2.localPosition = Vector3.New(390, -345, -345)
			end

			local var_126_5 = 0
			local var_126_6 = 0.15

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_7 = arg_123_1:GetWordFromCfg(423172029)
				local var_126_8 = arg_123_1:FormatText(var_126_7.content)

				arg_123_1.text_.text = var_126_8

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_10 = 6 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_8) / 6)

				if (6 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_8) / 6)) > 0 and var_126_6 < var_126_10 then
					arg_123_1.talkMaxDuration = var_126_10

					if var_126_10 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_5
					end
				end

				arg_123_1.text_.text = var_126_8
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172029", "story_v_out_423172.awb") ~= 0 then
					local var_126_11 = manager.audio:GetVoiceLength("story_v_out_423172", "423172029", "story_v_out_423172.awb") / 1000

					if var_126_11 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_11 + var_126_5
					end

					if var_126_7.prefab_name ~= "" and arg_123_1.actors_[var_126_7.prefab_name] ~= nil then
						local var_126_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_7.prefab_name].transform, "story_v_out_423172", "423172029", "story_v_out_423172.awb")

						arg_123_1:RecordAudio("423172029", var_126_12)
						arg_123_1:RecordAudio("423172029", var_126_12)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_423172", "423172029", "story_v_out_423172.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_423172", "423172029", "story_v_out_423172.awb")
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

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play423172030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 423172030
		arg_127_1.duration_ = 8.7

		local var_127_0 = {
			zh = 8.7,
			ja = 7.7
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
				arg_127_0:Play423172031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["3054"]) and arg_127_1.var_.actorSpriteComps3054 == nil then
				arg_127_1.var_.actorSpriteComps3054 = arg_127_1.actors_["3054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_0 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["3054"]) then
				if arg_127_1.var_.actorSpriteComps3054 then
					for iter_130_0, iter_130_1 in pairs(arg_127_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["3054"]) and arg_127_1.var_.actorSpriteComps3054 then
				for iter_130_2, iter_130_3 in pairs(arg_127_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_130_3 then
						iter_130_3.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_127_1.var_.actorSpriteComps3054 = nil
			end

			local var_130_2 = arg_127_1.actors_["1083"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps1083 == nil then
				arg_127_1.var_.actorSpriteComps1083 = var_130_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_130_3 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_3 and not isNil(var_130_2) then
				if arg_127_1.var_.actorSpriteComps1083 then
					for iter_130_4, iter_130_5 in pairs(arg_127_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_127_1.time_ >= 0 + var_130_3 and arg_127_1.time_ < 0 + var_130_3 + arg_130_0 and not isNil(var_130_2) and arg_127_1.var_.actorSpriteComps1083 then
				for iter_130_6, iter_130_7 in pairs(arg_127_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_130_7 then
						iter_130_7.color = arg_127_1.isInRecall_ and (arg_127_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_127_1.var_.actorSpriteComps1083 = nil
			end

			local var_130_5 = arg_127_1.actors_["3054"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos3054 = var_130_5.localPosition
				var_130_5.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("3054", 2)

				for iter_130_8 = 0, var_130_5.childCount - 1 do
					local var_130_6 = var_130_5:GetChild(iter_130_8)

					if var_130_6.name == "split_2" or not string.find(var_130_6.name, "split") then
						var_130_6.gameObject:SetActive(true)
					else
						var_130_6.gameObject:SetActive(false)
					end
				end
			end

			local var_130_7 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 then
				var_130_5.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos3054, Vector3.New(-390, -275, -280), (arg_127_1.time_ - 0) / var_130_7)
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 then
				var_130_5.localPosition = Vector3.New(-390, -275, -280)
			end

			local var_130_8 = 0
			local var_130_9 = 0.95

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_10 = arg_127_1:GetWordFromCfg(423172030)
				local var_130_11 = arg_127_1:FormatText(var_130_10.content)

				arg_127_1.text_.text = var_130_11

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_13 = 39 <= 0 and var_130_9 or var_130_9 * (utf8.len(var_130_11) / 39)

				if (39 <= 0 and var_130_9 or var_130_9 * (utf8.len(var_130_11) / 39)) > 0 and var_130_9 < var_130_13 then
					arg_127_1.talkMaxDuration = var_130_13

					if var_130_13 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_8
					end
				end

				arg_127_1.text_.text = var_130_11
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172030", "story_v_out_423172.awb") ~= 0 then
					local var_130_14 = manager.audio:GetVoiceLength("story_v_out_423172", "423172030", "story_v_out_423172.awb") / 1000

					if var_130_14 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_14 + var_130_8
					end

					if var_130_10.prefab_name ~= "" and arg_127_1.actors_[var_130_10.prefab_name] ~= nil then
						local var_130_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_10.prefab_name].transform, "story_v_out_423172", "423172030", "story_v_out_423172.awb")

						arg_127_1:RecordAudio("423172030", var_130_15)
						arg_127_1:RecordAudio("423172030", var_130_15)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_423172", "423172030", "story_v_out_423172.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_423172", "423172030", "story_v_out_423172.awb")
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
				actorName = "3054",
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
	Play423172031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 423172031
		arg_131_1.duration_ = 7.97

		local var_131_0 = {
			zh = 7.966,
			ja = 6.233
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
				arg_131_0:Play423172032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.75

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:GetWordFromCfg(423172031)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 30 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 30)

				if (30 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 30)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172031", "story_v_out_423172.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172031", "story_v_out_423172.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_out_423172", "423172031", "story_v_out_423172.awb")

						arg_131_1:RecordAudio("423172031", var_134_6)
						arg_131_1:RecordAudio("423172031", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_423172", "423172031", "story_v_out_423172.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_423172", "423172031", "story_v_out_423172.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play423172032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 423172032
		arg_135_1.duration_ = 7.2

		local var_135_0 = {
			zh = 6.033,
			ja = 7.2
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
				arg_135_0:Play423172033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["1083"]) and arg_135_1.var_.actorSpriteComps1083 == nil then
				arg_135_1.var_.actorSpriteComps1083 = arg_135_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["1083"]) then
				if arg_135_1.var_.actorSpriteComps1083 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_138_1 then
							if arg_135_1.isInRecall_ then
								iter_138_1.color = Color.New(Mathf.Lerp(iter_138_1.color.r, arg_135_1.hightColor1.r, (arg_135_1.time_ - 0) / var_138_0), Mathf.Lerp(iter_138_1.color.g, arg_135_1.hightColor1.g, (arg_135_1.time_ - 0) / var_138_0), (Mathf.Lerp(iter_138_1.color.b, arg_135_1.hightColor1.b, (arg_135_1.time_ - 0) / var_138_0)))
							else
								local var_138_1 = Mathf.Lerp(iter_138_1.color.r, 1, (arg_135_1.time_ - 0) / var_138_0)

								iter_138_1.color = Color.New(var_138_1, var_138_1, var_138_1)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["1083"]) and arg_135_1.var_.actorSpriteComps1083 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_135_1.var_.actorSpriteComps1083 = nil
			end

			local var_138_2 = arg_135_1.actors_["3054"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps3054 == nil then
				arg_135_1.var_.actorSpriteComps3054 = var_138_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_3 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_3 and not isNil(var_138_2) then
				if arg_135_1.var_.actorSpriteComps3054 then
					for iter_138_4, iter_138_5 in pairs(arg_135_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_138_5 then
							if arg_135_1.isInRecall_ then
								iter_138_5.color = Color.New(Mathf.Lerp(iter_138_5.color.r, arg_135_1.hightColor2.r, (arg_135_1.time_ - 0) / var_138_3), Mathf.Lerp(iter_138_5.color.g, arg_135_1.hightColor2.g, (arg_135_1.time_ - 0) / var_138_3), (Mathf.Lerp(iter_138_5.color.b, arg_135_1.hightColor2.b, (arg_135_1.time_ - 0) / var_138_3)))
							else
								local var_138_4 = Mathf.Lerp(iter_138_5.color.r, 0.5, (arg_135_1.time_ - 0) / var_138_3)

								iter_138_5.color = Color.New(var_138_4, var_138_4, var_138_4)
							end
						end
					end
				end
			end

			if arg_135_1.time_ >= 0 + var_138_3 and arg_135_1.time_ < 0 + var_138_3 + arg_138_0 and not isNil(var_138_2) and arg_135_1.var_.actorSpriteComps3054 then
				for iter_138_6, iter_138_7 in pairs(arg_135_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_138_7 then
						iter_138_7.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps3054 = nil
			end

			local var_138_5 = arg_135_1.actors_["1083"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos1083 = var_138_5.localPosition
				var_138_5.localScale = Vector3.New(1, 1, 1)

				arg_135_1:CheckSpriteTmpPos("1083", 4)

				for iter_138_8 = 0, var_138_5.childCount - 1 do
					local var_138_6 = var_138_5:GetChild(iter_138_8)

					if var_138_6.name == "split_7" or not string.find(var_138_6.name, "split") then
						var_138_6.gameObject:SetActive(true)
					else
						var_138_6.gameObject:SetActive(false)
					end
				end
			end

			local var_138_7 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				var_138_5.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1083, Vector3.New(390, -345, -345), (arg_135_1.time_ - 0) / var_138_7)
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				var_138_5.localPosition = Vector3.New(390, -345, -345)
			end

			local var_138_8 = 0
			local var_138_9 = 0.55

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_10 = arg_135_1:GetWordFromCfg(423172032)
				local var_138_11 = arg_135_1:FormatText(var_138_10.content)

				arg_135_1.text_.text = var_138_11

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_13 = 22 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 22)

				if (22 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 22)) > 0 and var_138_9 < var_138_13 then
					arg_135_1.talkMaxDuration = var_138_13

					if var_138_13 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_8
					end
				end

				arg_135_1.text_.text = var_138_11
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172032", "story_v_out_423172.awb") ~= 0 then
					local var_138_14 = manager.audio:GetVoiceLength("story_v_out_423172", "423172032", "story_v_out_423172.awb") / 1000

					if var_138_14 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_14 + var_138_8
					end

					if var_138_10.prefab_name ~= "" and arg_135_1.actors_[var_138_10.prefab_name] ~= nil then
						local var_138_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_10.prefab_name].transform, "story_v_out_423172", "423172032", "story_v_out_423172.awb")

						arg_135_1:RecordAudio("423172032", var_138_15)
						arg_135_1:RecordAudio("423172032", var_138_15)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_423172", "423172032", "story_v_out_423172.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_423172", "423172032", "story_v_out_423172.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_16 = math.max(var_138_9, arg_135_1.talkMaxDuration)

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_16 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_8) / var_138_16

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_8 + var_138_16 and arg_135_1.time_ < var_138_8 + var_138_16 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
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

		arg_135_1:InitPlayNodeList()
	end,
	Play423172033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 423172033
		arg_139_1.duration_ = 4.03

		local var_139_0 = {
			zh = 4.033,
			ja = 3.5
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
				arg_139_0:Play423172034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["3054"]) and arg_139_1.var_.actorSpriteComps3054 == nil then
				arg_139_1.var_.actorSpriteComps3054 = arg_139_1.actors_["3054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["3054"]) then
				if arg_139_1.var_.actorSpriteComps3054 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["3054"]) and arg_139_1.var_.actorSpriteComps3054 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps3054 = nil
			end

			local var_142_2 = arg_139_1.actors_["1083"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps1083 == nil then
				arg_139_1.var_.actorSpriteComps1083 = var_142_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_3 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_3 and not isNil(var_142_2) then
				if arg_139_1.var_.actorSpriteComps1083 then
					for iter_142_4, iter_142_5 in pairs(arg_139_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_142_5 then
							if arg_139_1.isInRecall_ then
								iter_142_5.color = Color.New(Mathf.Lerp(iter_142_5.color.r, arg_139_1.hightColor2.r, (arg_139_1.time_ - 0) / var_142_3), Mathf.Lerp(iter_142_5.color.g, arg_139_1.hightColor2.g, (arg_139_1.time_ - 0) / var_142_3), (Mathf.Lerp(iter_142_5.color.b, arg_139_1.hightColor2.b, (arg_139_1.time_ - 0) / var_142_3)))
							else
								local var_142_4 = Mathf.Lerp(iter_142_5.color.r, 0.5, (arg_139_1.time_ - 0) / var_142_3)

								iter_142_5.color = Color.New(var_142_4, var_142_4, var_142_4)
							end
						end
					end
				end
			end

			if arg_139_1.time_ >= 0 + var_142_3 and arg_139_1.time_ < 0 + var_142_3 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.actorSpriteComps1083 then
				for iter_142_6, iter_142_7 in pairs(arg_139_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_142_7 then
						iter_142_7.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_139_1.var_.actorSpriteComps1083 = nil
			end

			local var_142_5 = arg_139_1.actors_["3054"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos3054 = var_142_5.localPosition
				var_142_5.localScale = Vector3.New(1, 1, 1)

				arg_139_1:CheckSpriteTmpPos("3054", 2)

				for iter_142_8 = 0, var_142_5.childCount - 1 do
					local var_142_6 = var_142_5:GetChild(iter_142_8)

					if var_142_6.name == "" or not string.find(var_142_6.name, "split") then
						var_142_6.gameObject:SetActive(true)
					else
						var_142_6.gameObject:SetActive(false)
					end
				end
			end

			local var_142_7 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 then
				var_142_5.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos3054, Vector3.New(-390, -275, -280), (arg_139_1.time_ - 0) / var_142_7)
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 then
				var_142_5.localPosition = Vector3.New(-390, -275, -280)
			end

			if 0.034 < arg_139_1.time_ and arg_139_1.time_ <= 0.034 + arg_142_0 then
				arg_139_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_thunder01", "")
			end

			if 0.2 < arg_139_1.time_ and arg_139_1.time_ <= 0.2 + arg_142_0 then
				arg_139_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_142_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_139_1.bgmTxt_.text ~= var_142_11 and arg_139_1.bgmTxt_.text ~= "" then
						if arg_139_1.bgmTxt2_.text ~= "" then
							arg_139_1.bgmTxt_.text = arg_139_1.bgmTxt2_.text
						end

						arg_139_1.bgmTxt2_.text = var_142_11

						arg_139_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_139_1.bgmTxt_.text = var_142_11
						arg_139_1.bgmTxt2_.text = var_142_11
					end

					if arg_139_1.bgmTimer then
						arg_139_1.bgmTimer:Stop()

						arg_139_1.bgmTimer = nil
					end

					if arg_139_1.settingData.show_music_name == 1 then
						arg_139_1.musicController:SetSelectedState("show")
						arg_139_1.musicAnimator_:Play("open", 0, 0)

						if arg_139_1.settingData.music_time ~= 0 then
							arg_139_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_139_1.settingData.music_time), function()
								if arg_139_1 == nil or isNil(arg_139_1.bgmTxt_) then
									return
								end

								arg_139_1.musicController:SetSelectedState("hide")
								arg_139_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_142_12 = 0
			local var_142_13 = 0.3

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_12 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_14 = arg_139_1:GetWordFromCfg(423172033)
				local var_142_15 = arg_139_1:FormatText(var_142_14.content)

				arg_139_1.text_.text = var_142_15

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_17 = 12 <= 0 and var_142_13 or var_142_13 * (utf8.len(var_142_15) / 12)

				if (12 <= 0 and var_142_13 or var_142_13 * (utf8.len(var_142_15) / 12)) > 0 and var_142_13 < var_142_17 then
					arg_139_1.talkMaxDuration = var_142_17

					if var_142_17 + var_142_12 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_17 + var_142_12
					end
				end

				arg_139_1.text_.text = var_142_15
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172033", "story_v_out_423172.awb") ~= 0 then
					local var_142_18 = manager.audio:GetVoiceLength("story_v_out_423172", "423172033", "story_v_out_423172.awb") / 1000

					if var_142_18 + var_142_12 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_18 + var_142_12
					end

					if var_142_14.prefab_name ~= "" and arg_139_1.actors_[var_142_14.prefab_name] ~= nil then
						local var_142_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_14.prefab_name].transform, "story_v_out_423172", "423172033", "story_v_out_423172.awb")

						arg_139_1:RecordAudio("423172033", var_142_19)
						arg_139_1:RecordAudio("423172033", var_142_19)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_423172", "423172033", "story_v_out_423172.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_423172", "423172033", "story_v_out_423172.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_20 = math.max(var_142_13, arg_139_1.talkMaxDuration)

			if var_142_12 <= arg_139_1.time_ and arg_139_1.time_ < var_142_12 + var_142_20 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_12) / var_142_20

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_12 + var_142_20 and arg_139_1.time_ < var_142_12 + var_142_20 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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
	Play423172034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 423172034
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play423172035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["3054"]) and arg_144_1.var_.actorSpriteComps3054 == nil then
				arg_144_1.var_.actorSpriteComps3054 = arg_144_1.actors_["3054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_147_0 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["3054"]) then
				if arg_144_1.var_.actorSpriteComps3054 then
					for iter_147_0, iter_147_1 in pairs(arg_144_1.var_.actorSpriteComps3054:ToTable()) do
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

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["3054"]) and arg_144_1.var_.actorSpriteComps3054 then
				for iter_147_2, iter_147_3 in pairs(arg_144_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_147_3 then
						iter_147_3.color = arg_144_1.isInRecall_ and (arg_144_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_144_1.var_.actorSpriteComps3054 = nil
			end

			local var_147_2 = arg_144_1.actors_["3054"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos3054 = var_147_2.localPosition
				var_147_2.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("3054", 7)

				for iter_147_4 = 0, var_147_2.childCount - 1 do
					local var_147_3 = var_147_2:GetChild(iter_147_4)

					if var_147_3.name == "" or not string.find(var_147_3.name, "split") then
						var_147_3.gameObject:SetActive(true)
					else
						var_147_3.gameObject:SetActive(false)
					end
				end
			end

			local var_147_4 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 then
				var_147_2.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos3054, Vector3.New(0, -2000, 0), (arg_144_1.time_ - 0) / var_147_4)
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 then
				var_147_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_147_5 = arg_144_1.actors_["1083"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1083 = var_147_5.localPosition
				var_147_5.localScale = Vector3.New(1, 1, 1)

				arg_144_1:CheckSpriteTmpPos("1083", 7)

				for iter_147_5 = 0, var_147_5.childCount - 1 do
					local var_147_6 = var_147_5:GetChild(iter_147_5)

					if var_147_6.name == "" or not string.find(var_147_6.name, "split") then
						var_147_6.gameObject:SetActive(true)
					else
						var_147_6.gameObject:SetActive(false)
					end
				end
			end

			local var_147_7 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				var_147_5.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_144_1.time_ - 0) / var_147_7)
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				var_147_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_147_8 = 0
			local var_147_9 = 1.025

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_8 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_10 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(423172034).content)

				arg_144_1.text_.text = var_147_10

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_12 = 41 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_10) / 41)

				if (41 <= 0 and var_147_9 or var_147_9 * (utf8.len(var_147_10) / 41)) > 0 and var_147_9 < var_147_12 then
					arg_144_1.talkMaxDuration = var_147_12

					if var_147_12 + var_147_8 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_12 + var_147_8
					end
				end

				arg_144_1.text_.text = var_147_10
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_13 = math.max(var_147_9, arg_144_1.talkMaxDuration)

			if var_147_8 <= arg_144_1.time_ and arg_144_1.time_ < var_147_8 + var_147_13 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_8) / var_147_13

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_8 + var_147_13 and arg_144_1.time_ < var_147_8 + var_147_13 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
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

		arg_144_1:InitPlayNodeList()
	end,
	Play423172035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 423172035
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play423172036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 1.7

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_1 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(423172035).content)

				arg_148_1.text_.text = var_151_1

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_3 = 68 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_1) / 68)

				if (68 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_1) / 68)) > 0 and var_151_0 < var_151_3 then
					arg_148_1.talkMaxDuration = var_151_3

					if var_151_3 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_3 + 0
					end
				end

				arg_148_1.text_.text = var_151_1
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_4 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_4 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_4

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_4 and arg_148_1.time_ < 0 + var_151_4 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play423172036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 423172036
		arg_152_1.duration_ = 5.47

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play423172037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_9000

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.mask_.enabled = true
				arg_152_1.mask_.raycastTarget = true

				arg_152_1:SetGaussion(false)
			end

			local var_155_0 = 0.1

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 then
				local var_155_1 = Color.New(0, 0, 0)

				var_155_1.a = Mathf.Lerp(0, 1, (arg_152_1.time_ - 0) / var_155_0)
				arg_152_1.mask_.color = var_155_1
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 then
				local var_155_2 = Color.New(0, 0, 0)

				var_155_2.a = 1
				arg_152_1.mask_.color = var_155_2
			end

			local var_155_3 = 0.166666666666667

			if 0.166666666666667 < arg_152_1.time_ and arg_152_1.time_ <= var_155_3 + arg_155_0 then
				arg_152_1.mask_.enabled = true
				arg_152_1.mask_.raycastTarget = false

				arg_152_1:SetGaussion(false)
			end

			local var_155_4 = 0.0666666666666667

			if var_155_3 <= arg_152_1.time_ and arg_152_1.time_ < var_155_3 + var_155_4 then
				local var_155_5 = Color.New(1, 1, 1)

				var_155_5.a = Mathf.Lerp(1, 0, (arg_152_1.time_ - var_155_3) / var_155_4)
				arg_152_1.mask_.color = var_155_5
			end

			if arg_152_1.time_ >= var_155_3 + var_155_4 and arg_152_1.time_ < var_155_3 + var_155_4 + arg_155_0 then
				local var_155_6 = Color.New(1, 1, 1)

				arg_152_1.mask_.enabled = false
				var_155_6.a = 0
				arg_152_1.mask_.color = var_155_6
			end

			local var_155_7 = 0.266666666666667

			if 0.266666666666667 < arg_152_1.time_ and arg_152_1.time_ <= var_155_7 + arg_155_0 then
				arg_152_1.mask_.enabled = true
				arg_152_1.mask_.raycastTarget = false

				arg_152_1:SetGaussion(false)
			end

			local var_155_8 = 0.0666666666666667

			if var_155_7 <= arg_152_1.time_ and arg_152_1.time_ < var_155_7 + var_155_8 then
				local var_155_9 = Color.New(1, 1, 1)

				var_155_9.a = Mathf.Lerp(1, 0, (arg_152_1.time_ - var_155_7) / var_155_8)
				arg_152_1.mask_.color = var_155_9
			end

			if arg_152_1.time_ >= var_155_7 + var_155_8 and arg_152_1.time_ < var_155_7 + var_155_8 + arg_155_0 then
				local var_155_10 = Color.New(1, 1, 1)

				arg_152_1.mask_.enabled = false
				var_155_10.a = 0
				arg_152_1.mask_.color = var_155_10
			end

			local var_155_11 = 0.333333333333333

			if 0.333333333333333 < arg_152_1.time_ and arg_152_1.time_ <= var_155_11 + arg_155_0 then
				arg_152_1.mask_.enabled = true
				arg_152_1.mask_.raycastTarget = false

				arg_152_1:SetGaussion(false)
			end

			local var_155_12 = 0.0666666666666667

			if var_155_11 <= arg_152_1.time_ and arg_152_1.time_ < var_155_11 + var_155_12 then
				local var_155_13 = Color.New(1, 1, 1)

				var_155_13.a = Mathf.Lerp(1, 0, (arg_152_1.time_ - var_155_11) / var_155_12)
				arg_152_1.mask_.color = var_155_13
			end

			if arg_152_1.time_ >= var_155_11 + var_155_12 and arg_152_1.time_ < var_155_11 + var_155_12 + arg_155_0 then
				local var_155_14 = Color.New(1, 1, 1)

				arg_152_1.mask_.enabled = false
				var_155_14.a = 0
				arg_152_1.mask_.color = var_155_14
			end

			local var_155_15 = 0.4

			if 0.4 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1.mask_.enabled = true
				arg_152_1.mask_.raycastTarget = false

				arg_152_1:SetGaussion(false)
			end

			local var_155_16 = 0.0666666666666667

			if var_155_15 <= arg_152_1.time_ and arg_152_1.time_ < var_155_15 + var_155_16 then
				local var_155_17 = Color.New(1, 1, 1)

				var_155_17.a = Mathf.Lerp(1, 0, (arg_152_1.time_ - var_155_15) / var_155_16)
				arg_152_1.mask_.color = var_155_17
			end

			if arg_152_1.time_ >= var_155_15 + var_155_16 and arg_152_1.time_ < var_155_15 + var_155_16 + arg_155_0 then
				local var_155_18 = Color.New(1, 1, 1)

				arg_152_1.mask_.enabled = false
				var_155_18.a = 0
				arg_152_1.mask_.color = var_155_18
			end

			if 0.166666666666667 < arg_152_1.time_ and arg_152_1.time_ <= 0.166666666666667 + arg_155_0 then
				local var_155_19 = arg_152_1.var_.effecthuangyuanshandian

				if not arg_152_1.var_.effecthuangyuanshandian then
					var_155_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), manager.ui.mainCamera.transform)
					var_155_19.name = "huangyuanshandian"
					arg_152_1.var_.effecthuangyuanshandian = var_155_19
				else
					var_155_19.transform:SetParent(var_155_9000)
				end

				var_155_19.transform.localPosition = Vector3.New(0, 0, 0)
				var_155_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.16666666666667 < arg_152_1.time_ and arg_152_1.time_ <= 1.16666666666667 + arg_155_0 then
				if arg_152_1.var_.effecthuangyuanshandian then
					Object.Destroy(arg_152_1.var_.effecthuangyuanshandian)

					arg_152_1.var_.effecthuangyuanshandian = nil
				end
			end

			local var_155_22 = 0

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_22 + arg_155_0 then
				arg_152_1.allBtn_.enabled = false
			end

			if arg_152_1.time_ >= var_155_22 + 0.466666666666667 and arg_152_1.time_ < var_155_22 + 0.466666666666667 + arg_155_0 then
				arg_152_1.allBtn_.enabled = true
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:AudioAction("play", "effect", "se_story_144", "se_story_144_thunder", "")
			end

			if arg_152_1.frameCnt_ <= 1 then
				arg_152_1.dialog_:SetActive(false)
			end

			local var_155_24 = 0.466666666666667
			local var_155_25 = 0.95

			if 0.466666666666667 < arg_152_1.time_ and arg_152_1.time_ <= var_155_24 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0

				arg_152_1.dialog_:SetActive(true)

				arg_152_1.dialogCg_.alpha = 0

				local var_155_26 = LeanTween.value(arg_152_1.dialog_, 0, 1, 0.3)

				var_155_26:setOnUpdate(LuaHelper.FloatAction(function(arg_156_0)
					arg_152_1.dialogCg_.alpha = arg_156_0
				end))
				var_155_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_152_1.dialog_)
					var_155_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_152_1.duration_ = arg_152_1.duration_ + 0.3

				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_27 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(423172036).content)

				arg_152_1.text_.text = var_155_27

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_29 = 38 <= 0 and var_155_25 or var_155_25 * (utf8.len(var_155_27) / 38)

				if (38 <= 0 and var_155_25 or var_155_25 * (utf8.len(var_155_27) / 38)) > 0 and var_155_25 < var_155_29 then
					arg_152_1.talkMaxDuration = var_155_29
					var_155_24 = var_155_24 + 0.3

					if var_155_29 + var_155_24 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_29 + var_155_24
					end
				end

				arg_152_1.text_.text = var_155_27
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_30 = var_155_24 + 0.3
			local var_155_31 = math.max(var_155_25, arg_152_1.talkMaxDuration)

			if var_155_24 + 0.3 <= arg_152_1.time_ and arg_152_1.time_ < var_155_30 + var_155_31 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_30) / var_155_31

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_30 + var_155_31 and arg_152_1.time_ < var_155_30 + var_155_31 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play423172037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 423172037
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play423172038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				local var_161_0 = arg_158_1.var_.effectzuolunshouqiang1

				if not arg_158_1.var_.effectzuolunshouqiang1 then
					var_161_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_161_0.name = "zuolunshouqiang1"
					arg_158_1.var_.effectzuolunshouqiang1 = var_161_0
				else
					var_161_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_161_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_161_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.5 < arg_158_1.time_ and arg_158_1.time_ <= 1.5 + arg_161_0 then
				if arg_158_1.var_.effectzuolunshouqiang1 then
					Object.Destroy(arg_158_1.var_.effectzuolunshouqiang1)

					arg_158_1.var_.effectzuolunshouqiang1 = nil
				end
			end

			local var_161_3 = manager.ui.mainCamera.transform

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.shakeOldPos = var_161_3.localPosition
			end

			local var_161_4 = 0.6

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 then
				local var_161_5, var_161_6 = math.modf((arg_158_1.time_ - 0) / 0.066)

				var_161_3.localPosition = Vector3.New(var_161_6 * 0.02, var_161_6 * 0.02, var_161_6 * 0.02) + arg_158_1.var_.shakeOldPos
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 then
				var_161_3.localPosition = arg_158_1.var_.shakeOldPos
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun07", "")
			end

			local var_161_8 = 0
			local var_161_9 = 0.1

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_8 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_10 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(423172037).content)

				arg_158_1.text_.text = var_161_10

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_12 = 4 <= 0 and var_161_9 or var_161_9 * (utf8.len(var_161_10) / 4)

				if (4 <= 0 and var_161_9 or var_161_9 * (utf8.len(var_161_10) / 4)) > 0 and var_161_9 < var_161_12 then
					arg_158_1.talkMaxDuration = var_161_12

					if var_161_12 + var_161_8 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_12 + var_161_8
					end
				end

				arg_158_1.text_.text = var_161_10
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_13 = math.max(var_161_9, arg_158_1.talkMaxDuration)

			if var_161_8 <= arg_158_1.time_ and arg_158_1.time_ < var_161_8 + var_161_13 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_8) / var_161_13

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_8 + var_161_13 and arg_158_1.time_ < var_161_8 + var_161_13 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play423172038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 423172038
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play423172039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0.733333333333333 < arg_162_1.time_ and arg_162_1.time_ <= 0.733333333333333 + arg_165_0 then
				arg_162_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_down", "")
			end

			local var_165_1 = 0
			local var_165_2 = 1.4

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_3 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(423172038).content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 56 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_3) / 56)

				if (56 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_3) / 56)) > 0 and var_165_2 < var_165_5 then
					arg_162_1.talkMaxDuration = var_165_5

					if var_165_5 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + var_165_1
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_6 = math.max(var_165_2, arg_162_1.talkMaxDuration)

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_6 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_1) / var_165_6

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_1 + var_165_6 and arg_162_1.time_ < var_165_1 + var_165_6 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play423172039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 423172039
		arg_166_1.duration_ = 7.68

		local var_166_0 = {
			zh = 6.875,
			ja = 7.675
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play423172040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if arg_166_1.bgs_.SS2304 == nil then
				local var_169_0 = Object.Instantiate(arg_166_1.paintGo_)

				var_169_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2304")
				var_169_0.name = "SS2304"
				var_169_0.transform.parent = arg_166_1.stage_.transform
				var_169_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.bgs_.SS2304 = var_169_0
			end

			if 2 < arg_166_1.time_ and arg_166_1.time_ <= 2 + arg_169_0 then
				local var_169_1 = arg_166_1.bgs_.SS2304

				arg_166_1.bgs_.SS2304.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_169_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_169_2 = var_169_1:GetComponent("SpriteRenderer")

				if var_169_2 and var_169_2.sprite then
					local var_169_3 = 2 * (var_169_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_169_1.transform.localScale = Vector3.New(var_169_3 / var_169_2.sprite.bounds.size.y < var_169_3 * manager.ui.mainCameraCom_.aspect / var_169_2.sprite.bounds.size.x and var_169_3 * manager.ui.mainCameraCom_.aspect / var_169_2.sprite.bounds.size.x or var_169_3 / var_169_2.sprite.bounds.size.y, var_169_3 / var_169_2.sprite.bounds.size.y < var_169_3 * manager.ui.mainCameraCom_.aspect / var_169_2.sprite.bounds.size.x and var_169_3 * manager.ui.mainCameraCom_.aspect / var_169_2.sprite.bounds.size.x or var_169_3 / var_169_2.sprite.bounds.size.y, 0)
				end

				for iter_169_0, iter_169_1 in pairs(arg_166_1.bgs_) do
					if iter_169_0 ~= "SS2304" then
						iter_169_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_169_4 = 3.775

			if 3.775 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			if arg_166_1.time_ >= var_169_4 + 0.3 and arg_166_1.time_ < var_169_4 + 0.3 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end

			local var_169_5 = 0

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_6 = 2

			if var_169_5 <= arg_166_1.time_ and arg_166_1.time_ < var_169_5 + var_169_6 then
				local var_169_7 = Color.New(0, 0, 0)

				var_169_7.a = Mathf.Lerp(0, 1, (arg_166_1.time_ - var_169_5) / var_169_6)
				arg_166_1.mask_.color = var_169_7
			end

			if arg_166_1.time_ >= var_169_5 + var_169_6 and arg_166_1.time_ < var_169_5 + var_169_6 + arg_169_0 then
				local var_169_8 = Color.New(0, 0, 0)

				var_169_8.a = 1
				arg_166_1.mask_.color = var_169_8
			end

			local var_169_9 = 2

			if 2 < arg_166_1.time_ and arg_166_1.time_ <= var_169_9 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_10 = 2

			if var_169_9 <= arg_166_1.time_ and arg_166_1.time_ < var_169_9 + var_169_10 then
				local var_169_11 = Color.New(0, 0, 0)

				var_169_11.a = Mathf.Lerp(1, 0, (arg_166_1.time_ - var_169_9) / var_169_10)
				arg_166_1.mask_.color = var_169_11
			end

			if arg_166_1.time_ >= var_169_9 + var_169_10 and arg_166_1.time_ < var_169_9 + var_169_10 + arg_169_0 then
				local var_169_12 = Color.New(0, 0, 0)

				arg_166_1.mask_.enabled = false
				var_169_12.a = 0
				arg_166_1.mask_.color = var_169_12
			end

			local var_169_13 = arg_166_1.bgs_.SS2304.transform

			if 2 < arg_166_1.time_ and arg_166_1.time_ <= 2 + arg_169_0 then
				arg_166_1.var_.moveOldPosSS2304 = var_169_13.localPosition
			end

			local var_169_14 = 2

			if 2 <= arg_166_1.time_ and arg_166_1.time_ < 2 + var_169_14 then
				var_169_13.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPosSS2304, Vector3.New(1, 0, 1.2), (arg_166_1.time_ - 2) / var_169_14)
			end

			if arg_166_1.time_ >= 2 + var_169_14 and arg_166_1.time_ < 2 + var_169_14 + arg_169_0 then
				var_169_13.localPosition = Vector3.New(1, 0, 1.2)
			end

			if 1.63333333333333 < arg_166_1.time_ and arg_166_1.time_ <= 1.63333333333333 + arg_169_0 then
				arg_166_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_lfe", "")
			end

			if 1.63333333333333 < arg_166_1.time_ and arg_166_1.time_ <= 1.63333333333333 + arg_169_0 then
				arg_166_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_thunderrain_loop", "")
			end

			if arg_166_1.frameCnt_ <= 1 then
				arg_166_1.dialog_:SetActive(false)
			end

			local var_169_17 = 3.775
			local var_169_18 = 0.225

			if 3.775 < arg_166_1.time_ and arg_166_1.time_ <= var_169_17 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0

				arg_166_1.dialog_:SetActive(true)

				arg_166_1.dialogCg_.alpha = 0

				local var_169_19 = LeanTween.value(arg_166_1.dialog_, 0, 1, 0.3)

				var_169_19:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_166_1.dialogCg_.alpha = arg_170_0
				end))
				var_169_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_166_1.dialog_)
					var_169_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_166_1.duration_ = arg_166_1.duration_ + 0.3

				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_20 = arg_166_1:GetWordFromCfg(423172039)
				local var_169_21 = arg_166_1:FormatText(var_169_20.content)

				arg_166_1.text_.text = var_169_21

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_23 = 9 <= 0 and var_169_18 or var_169_18 * (utf8.len(var_169_21) / 9)

				if (9 <= 0 and var_169_18 or var_169_18 * (utf8.len(var_169_21) / 9)) > 0 and var_169_18 < var_169_23 then
					arg_166_1.talkMaxDuration = var_169_23
					var_169_17 = var_169_17 + 0.3

					if var_169_23 + var_169_17 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_23 + var_169_17
					end
				end

				arg_166_1.text_.text = var_169_21
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172039", "story_v_out_423172.awb") ~= 0 then
					local var_169_24 = manager.audio:GetVoiceLength("story_v_out_423172", "423172039", "story_v_out_423172.awb") / 1000

					if var_169_24 + var_169_17 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_24 + var_169_17
					end

					if var_169_20.prefab_name ~= "" and arg_166_1.actors_[var_169_20.prefab_name] ~= nil then
						local var_169_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_20.prefab_name].transform, "story_v_out_423172", "423172039", "story_v_out_423172.awb")

						arg_166_1:RecordAudio("423172039", var_169_25)
						arg_166_1:RecordAudio("423172039", var_169_25)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_423172", "423172039", "story_v_out_423172.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_423172", "423172039", "story_v_out_423172.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_26 = var_169_17 + 0.3
			local var_169_27 = math.max(var_169_18, arg_166_1.talkMaxDuration)

			if var_169_17 + 0.3 <= arg_166_1.time_ and arg_166_1.time_ < var_169_26 + var_169_27 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_26) / var_169_27

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_26 + var_169_27 and arg_166_1.time_ < var_169_26 + var_169_27 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2304",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(1, 0, 0.7),
					endPos = Vector3.New(1, 0, 1.2),
					easeType = LeanTweenType.easeOutExpo
				}
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play423172040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 423172040
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play423172041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 1.075

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_1 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(423172040).content)

				arg_172_1.text_.text = var_175_1

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_3 = 43 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_1) / 43)

				if (43 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_1) / 43)) > 0 and var_175_0 < var_175_3 then
					arg_172_1.talkMaxDuration = var_175_3

					if var_175_3 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_3 + 0
					end
				end

				arg_172_1.text_.text = var_175_1
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_4 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_4 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_4

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_4 and arg_172_1.time_ < 0 + var_175_4 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play423172041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 423172041
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play423172042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 1.425

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_1 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(423172041).content)

				arg_176_1.text_.text = var_179_1

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_3 = 57 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 57)

				if (57 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 57)) > 0 and var_179_0 < var_179_3 then
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
	Play423172042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 423172042
		arg_180_1.duration_ = 7.67

		local var_180_0 = {
			zh = 7.66666666666667,
			ja = 7.33266666666667
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
				arg_180_0:Play423172043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPosSS2304 = arg_180_1.bgs_.SS2304.transform.localPosition
			end

			local var_183_0 = 3.5

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 then
				arg_180_1.bgs_.SS2304.transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPosSS2304, Vector3.New(0, 1, 10), (arg_180_1.time_ - 0) / var_183_0)
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 then
				arg_180_1.bgs_.SS2304.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_183_1 = 0

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.allBtn_.enabled = false
			end

			if arg_180_1.time_ >= var_183_1 + 3.5 and arg_180_1.time_ < var_183_1 + 3.5 + arg_183_0 then
				arg_180_1.allBtn_.enabled = true
			end

			if arg_180_1.frameCnt_ <= 1 then
				arg_180_1.dialog_:SetActive(false)
			end

			local var_183_2 = 1.96666666666667
			local var_183_3 = 0.45

			if 1.96666666666667 < arg_180_1.time_ and arg_180_1.time_ <= var_183_2 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0

				arg_180_1.dialog_:SetActive(true)

				arg_180_1.dialogCg_.alpha = 0

				local var_183_4 = LeanTween.value(arg_180_1.dialog_, 0, 1, 0.3)

				var_183_4:setOnUpdate(LuaHelper.FloatAction(function(arg_184_0)
					arg_180_1.dialogCg_.alpha = arg_184_0
				end))
				var_183_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_180_1.dialog_)
					var_183_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_180_1.duration_ = arg_180_1.duration_ + 0.3

				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_5 = arg_180_1:GetWordFromCfg(423172042)
				local var_183_6 = arg_180_1:FormatText(var_183_5.content)

				arg_180_1.text_.text = var_183_6

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_8 = 18 <= 0 and var_183_3 or var_183_3 * (utf8.len(var_183_6) / 18)

				if (18 <= 0 and var_183_3 or var_183_3 * (utf8.len(var_183_6) / 18)) > 0 and var_183_3 < var_183_8 then
					arg_180_1.talkMaxDuration = var_183_8
					var_183_2 = var_183_2 + 0.3

					if var_183_8 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_8 + var_183_2
					end
				end

				arg_180_1.text_.text = var_183_6
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172042", "story_v_out_423172.awb") ~= 0 then
					local var_183_9 = manager.audio:GetVoiceLength("story_v_out_423172", "423172042", "story_v_out_423172.awb") / 1000

					if var_183_9 + var_183_2 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_9 + var_183_2
					end

					if var_183_5.prefab_name ~= "" and arg_180_1.actors_[var_183_5.prefab_name] ~= nil then
						local var_183_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_5.prefab_name].transform, "story_v_out_423172", "423172042", "story_v_out_423172.awb")

						arg_180_1:RecordAudio("423172042", var_183_10)
						arg_180_1:RecordAudio("423172042", var_183_10)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_423172", "423172042", "story_v_out_423172.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_423172", "423172042", "story_v_out_423172.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_11 = var_183_2 + 0.3
			local var_183_12 = math.max(var_183_3, arg_180_1.talkMaxDuration)

			if var_183_2 + 0.3 <= arg_180_1.time_ and arg_180_1.time_ < var_183_11 + var_183_12 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_11) / var_183_12

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_11 + var_183_12 and arg_180_1.time_ < var_183_11 + var_183_12 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2304",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.5,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(1, 0, 1.2),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeOutExpo
				}
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play423172043 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 423172043
		arg_186_1.duration_ = 9.8

		local var_186_0 = {
			zh = 9.266,
			ja = 9.8
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play423172044(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0.85

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_1 = arg_186_1:GetWordFromCfg(423172043)
				local var_189_2 = arg_186_1:FormatText(var_189_1.content)

				arg_186_1.text_.text = var_189_2

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_4 = 34 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_2) / 34)

				if (34 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_2) / 34)) > 0 and var_189_0 < var_189_4 then
					arg_186_1.talkMaxDuration = var_189_4

					if var_189_4 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_4 + 0
					end
				end

				arg_186_1.text_.text = var_189_2
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172043", "story_v_out_423172.awb") ~= 0 then
					local var_189_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172043", "story_v_out_423172.awb") / 1000

					if var_189_5 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_5 + 0
					end

					if var_189_1.prefab_name ~= "" and arg_186_1.actors_[var_189_1.prefab_name] ~= nil then
						local var_189_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_1.prefab_name].transform, "story_v_out_423172", "423172043", "story_v_out_423172.awb")

						arg_186_1:RecordAudio("423172043", var_189_6)
						arg_186_1:RecordAudio("423172043", var_189_6)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_423172", "423172043", "story_v_out_423172.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_423172", "423172043", "story_v_out_423172.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_7 = math.max(var_189_0, arg_186_1.talkMaxDuration)

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_7 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - 0) / var_189_7

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= 0 + var_189_7 and arg_186_1.time_ < 0 + var_189_7 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play423172044 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 423172044
		arg_190_1.duration_ = 11.7

		local var_190_0 = {
			zh = 10.4,
			ja = 11.7
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play423172045(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = 0.925

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_1 = arg_190_1:GetWordFromCfg(423172044)
				local var_193_2 = arg_190_1:FormatText(var_193_1.content)

				arg_190_1.text_.text = var_193_2

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_4 = 37 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_2) / 37)

				if (37 <= 0 and var_193_0 or var_193_0 * (utf8.len(var_193_2) / 37)) > 0 and var_193_0 < var_193_4 then
					arg_190_1.talkMaxDuration = var_193_4

					if var_193_4 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_4 + 0
					end
				end

				arg_190_1.text_.text = var_193_2
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172044", "story_v_out_423172.awb") ~= 0 then
					local var_193_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172044", "story_v_out_423172.awb") / 1000

					if var_193_5 + 0 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + 0
					end

					if var_193_1.prefab_name ~= "" and arg_190_1.actors_[var_193_1.prefab_name] ~= nil then
						local var_193_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_1.prefab_name].transform, "story_v_out_423172", "423172044", "story_v_out_423172.awb")

						arg_190_1:RecordAudio("423172044", var_193_6)
						arg_190_1:RecordAudio("423172044", var_193_6)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_423172", "423172044", "story_v_out_423172.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_423172", "423172044", "story_v_out_423172.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_7 = math.max(var_193_0, arg_190_1.talkMaxDuration)

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_7 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - 0) / var_193_7

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= 0 + var_193_7 and arg_190_1.time_ < 0 + var_193_7 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play423172045 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 423172045
		arg_194_1.duration_ = 4.57

		local var_194_0 = {
			zh = 4.233,
			ja = 4.566
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play423172046(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0.425

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_194_1.callingController_:SetSelectedState("normal")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_1 = arg_194_1:GetWordFromCfg(423172045)
				local var_197_2 = arg_194_1:FormatText(var_197_1.content)

				arg_194_1.text_.text = var_197_2

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_4 = 17 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 17)

				if (17 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 17)) > 0 and var_197_0 < var_197_4 then
					arg_194_1.talkMaxDuration = var_197_4

					if var_197_4 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_4 + 0
					end
				end

				arg_194_1.text_.text = var_197_2
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172045", "story_v_out_423172.awb") ~= 0 then
					local var_197_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172045", "story_v_out_423172.awb") / 1000

					if var_197_5 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + 0
					end

					if var_197_1.prefab_name ~= "" and arg_194_1.actors_[var_197_1.prefab_name] ~= nil then
						local var_197_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_1.prefab_name].transform, "story_v_out_423172", "423172045", "story_v_out_423172.awb")

						arg_194_1:RecordAudio("423172045", var_197_6)
						arg_194_1:RecordAudio("423172045", var_197_6)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_423172", "423172045", "story_v_out_423172.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_423172", "423172045", "story_v_out_423172.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_7 = math.max(var_197_0, arg_194_1.talkMaxDuration)

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_7 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - 0) / var_197_7

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= 0 + var_197_7 and arg_194_1.time_ < 0 + var_197_7 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play423172046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 423172046
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play423172047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPosSS2304 = arg_198_1.bgs_.SS2304.transform.localPosition
			end

			local var_201_0 = 2

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				arg_198_1.bgs_.SS2304.transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPosSS2304, Vector3.New(0, 1, 9.5), (arg_198_1.time_ - 0) / var_201_0)
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				arg_198_1.bgs_.SS2304.transform.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_201_1 = 0

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.allBtn_.enabled = false
			end

			if arg_198_1.time_ >= var_201_1 + 2 and arg_198_1.time_ < var_201_1 + 2 + arg_201_0 then
				arg_198_1.allBtn_.enabled = true
			end

			local var_201_2 = 0
			local var_201_3 = 0.85

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_2 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0

				arg_198_1.dialog_:SetActive(true)

				arg_198_1.dialogCg_.alpha = 0

				local var_201_4 = LeanTween.value(arg_198_1.dialog_, 0, 1, 0.3)

				var_201_4:setOnUpdate(LuaHelper.FloatAction(function(arg_202_0)
					arg_198_1.dialogCg_.alpha = arg_202_0
				end))
				var_201_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_198_1.dialog_)
					var_201_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_198_1.duration_ = arg_198_1.duration_ + 0.3

				SetActive(arg_198_1.leftNameGo_, false)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_5 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(423172046).content)

				arg_198_1.text_.text = var_201_5

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_7 = 34 <= 0 and var_201_3 or var_201_3 * (utf8.len(var_201_5) / 34)

				if (34 <= 0 and var_201_3 or var_201_3 * (utf8.len(var_201_5) / 34)) > 0 and var_201_3 < var_201_7 then
					arg_198_1.talkMaxDuration = var_201_7
					var_201_2 = var_201_2 + 0.3

					if var_201_7 + var_201_2 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_7 + var_201_2
					end
				end

				arg_198_1.text_.text = var_201_5
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_8 = var_201_2 + 0.3
			local var_201_9 = math.max(var_201_3, arg_198_1.talkMaxDuration)

			if var_201_2 + 0.3 <= arg_198_1.time_ and arg_198_1.time_ < var_201_8 + var_201_9 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_8) / var_201_9

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_8 + var_201_9 and arg_198_1.time_ < var_201_8 + var_201_9 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2304",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play423172047 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 423172047
		arg_204_1.duration_ = 11.47

		local var_204_0 = {
			zh = 11.466,
			ja = 7.7
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
				arg_204_0:Play423172048(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 1.2

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_1 = arg_204_1:GetWordFromCfg(423172047)
				local var_207_2 = arg_204_1:FormatText(var_207_1.content)

				arg_204_1.text_.text = var_207_2

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 48 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 48)

				if (48 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 48)) > 0 and var_207_0 < var_207_4 then
					arg_204_1.talkMaxDuration = var_207_4

					if var_207_4 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_4 + 0
					end
				end

				arg_204_1.text_.text = var_207_2
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172047", "story_v_out_423172.awb") ~= 0 then
					local var_207_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172047", "story_v_out_423172.awb") / 1000

					if var_207_5 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_5 + 0
					end

					if var_207_1.prefab_name ~= "" and arg_204_1.actors_[var_207_1.prefab_name] ~= nil then
						local var_207_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_1.prefab_name].transform, "story_v_out_423172", "423172047", "story_v_out_423172.awb")

						arg_204_1:RecordAudio("423172047", var_207_6)
						arg_204_1:RecordAudio("423172047", var_207_6)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_423172", "423172047", "story_v_out_423172.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_423172", "423172047", "story_v_out_423172.awb")
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
	Play423172048 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 423172048
		arg_208_1.duration_ = 10

		local var_208_0 = {
			zh = 8.3,
			ja = 10
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
				arg_208_0:Play423172049(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_0 = 1

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 then
				local var_211_1 = Color.New(0, 0, 0)

				var_211_1.a = Mathf.Lerp(0, 1, (arg_208_1.time_ - 0) / var_211_0)
				arg_208_1.mask_.color = var_211_1
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 then
				local var_211_2 = Color.New(0, 0, 0)

				var_211_2.a = 1
				arg_208_1.mask_.color = var_211_2
			end

			local var_211_3 = 1

			if 1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_3 + arg_211_0 then
				arg_208_1.mask_.enabled = true
				arg_208_1.mask_.raycastTarget = true

				arg_208_1:SetGaussion(false)
			end

			local var_211_4 = 1

			if var_211_3 <= arg_208_1.time_ and arg_208_1.time_ < var_211_3 + var_211_4 then
				local var_211_5 = Color.New(0, 0, 0)

				var_211_5.a = Mathf.Lerp(1, 0, (arg_208_1.time_ - var_211_3) / var_211_4)
				arg_208_1.mask_.color = var_211_5
			end

			if arg_208_1.time_ >= var_211_3 + var_211_4 and arg_208_1.time_ < var_211_3 + var_211_4 + arg_211_0 then
				local var_211_6 = Color.New(0, 0, 0)

				arg_208_1.mask_.enabled = false
				var_211_6.a = 0
				arg_208_1.mask_.color = var_211_6
			end

			local var_211_7 = arg_208_1.bgs_.SS2304.transform

			if 1 < arg_208_1.time_ and arg_208_1.time_ <= 1 + arg_211_0 then
				arg_208_1.var_.moveOldPosSS2304 = var_211_7.localPosition
			end

			local var_211_8 = 3.5

			if 1 <= arg_208_1.time_ and arg_208_1.time_ < 1 + var_211_8 then
				var_211_7.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPosSS2304, Vector3.New(0, -0.7, 0), (arg_208_1.time_ - 1) / var_211_8)
			end

			if arg_208_1.time_ >= 1 + var_211_8 and arg_208_1.time_ < 1 + var_211_8 + arg_211_0 then
				var_211_7.localPosition = Vector3.New(0, -0.7, 0)
			end

			local var_211_9 = 2

			if 2 < arg_208_1.time_ and arg_208_1.time_ <= var_211_9 + arg_211_0 then
				arg_208_1.allBtn_.enabled = false
			end

			if arg_208_1.time_ >= var_211_9 + 2.5 and arg_208_1.time_ < var_211_9 + 2.5 + arg_211_0 then
				arg_208_1.allBtn_.enabled = true
			end

			if arg_208_1.frameCnt_ <= 1 then
				arg_208_1.dialog_:SetActive(false)
			end

			local var_211_10 = 2
			local var_211_11 = 0.525

			if 2 < arg_208_1.time_ and arg_208_1.time_ <= var_211_10 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0

				arg_208_1.dialog_:SetActive(true)

				arg_208_1.dialogCg_.alpha = 0

				local var_211_12 = LeanTween.value(arg_208_1.dialog_, 0, 1, 0.3)

				var_211_12:setOnUpdate(LuaHelper.FloatAction(function(arg_212_0)
					arg_208_1.dialogCg_.alpha = arg_212_0
				end))
				var_211_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_208_1.dialog_)
					var_211_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_208_1.duration_ = arg_208_1.duration_ + 0.3

				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_13 = arg_208_1:GetWordFromCfg(423172048)
				local var_211_14 = arg_208_1:FormatText(var_211_13.content)

				arg_208_1.text_.text = var_211_14

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_16 = 21 <= 0 and var_211_11 or var_211_11 * (utf8.len(var_211_14) / 21)

				if (21 <= 0 and var_211_11 or var_211_11 * (utf8.len(var_211_14) / 21)) > 0 and var_211_11 < var_211_16 then
					arg_208_1.talkMaxDuration = var_211_16
					var_211_10 = var_211_10 + 0.3

					if var_211_16 + var_211_10 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_16 + var_211_10
					end
				end

				arg_208_1.text_.text = var_211_14
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172048", "story_v_out_423172.awb") ~= 0 then
					local var_211_17 = manager.audio:GetVoiceLength("story_v_out_423172", "423172048", "story_v_out_423172.awb") / 1000

					if var_211_17 + var_211_10 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_17 + var_211_10
					end

					if var_211_13.prefab_name ~= "" and arg_208_1.actors_[var_211_13.prefab_name] ~= nil then
						local var_211_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_13.prefab_name].transform, "story_v_out_423172", "423172048", "story_v_out_423172.awb")

						arg_208_1:RecordAudio("423172048", var_211_18)
						arg_208_1:RecordAudio("423172048", var_211_18)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_423172", "423172048", "story_v_out_423172.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_423172", "423172048", "story_v_out_423172.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_19 = var_211_10 + 0.3
			local var_211_20 = math.max(var_211_11, arg_208_1.talkMaxDuration)

			if var_211_10 + 0.3 <= arg_208_1.time_ and arg_208_1.time_ < var_211_19 + var_211_20 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_19) / var_211_20

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_19 + var_211_20 and arg_208_1.time_ < var_211_19 + var_211_20 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2304",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 3.5,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, -0.6, 0),
					endPos = Vector3.New(0, -0.7, 0),
					easeType = LeanTweenType.easeOutCubic
				}
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play423172049 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 423172049
		arg_214_1.duration_ = 11.37

		local var_214_0 = {
			zh = 8.466,
			ja = 11.366
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play423172050(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0.975

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_1 = arg_214_1:GetWordFromCfg(423172049)
				local var_217_2 = arg_214_1:FormatText(var_217_1.content)

				arg_214_1.text_.text = var_217_2

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_4 = 39 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 39)

				if (39 <= 0 and var_217_0 or var_217_0 * (utf8.len(var_217_2) / 39)) > 0 and var_217_0 < var_217_4 then
					arg_214_1.talkMaxDuration = var_217_4

					if var_217_4 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_4 + 0
					end
				end

				arg_214_1.text_.text = var_217_2
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172049", "story_v_out_423172.awb") ~= 0 then
					local var_217_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172049", "story_v_out_423172.awb") / 1000

					if var_217_5 + 0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + 0
					end

					if var_217_1.prefab_name ~= "" and arg_214_1.actors_[var_217_1.prefab_name] ~= nil then
						local var_217_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_1.prefab_name].transform, "story_v_out_423172", "423172049", "story_v_out_423172.awb")

						arg_214_1:RecordAudio("423172049", var_217_6)
						arg_214_1:RecordAudio("423172049", var_217_6)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_423172", "423172049", "story_v_out_423172.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_423172", "423172049", "story_v_out_423172.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_7 = math.max(var_217_0, arg_214_1.talkMaxDuration)

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_7 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - 0) / var_217_7

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= 0 + var_217_7 and arg_214_1.time_ < 0 + var_217_7 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play423172050 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 423172050
		arg_218_1.duration_ = 12.47

		local var_218_0 = {
			zh = 10.066,
			ja = 12.466
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play423172051(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0.925

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_1 = arg_218_1:GetWordFromCfg(423172050)
				local var_221_2 = arg_218_1:FormatText(var_221_1.content)

				arg_218_1.text_.text = var_221_2

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_4 = 37 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 37)

				if (37 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_2) / 37)) > 0 and var_221_0 < var_221_4 then
					arg_218_1.talkMaxDuration = var_221_4

					if var_221_4 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_4 + 0
					end
				end

				arg_218_1.text_.text = var_221_2
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172050", "story_v_out_423172.awb") ~= 0 then
					local var_221_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172050", "story_v_out_423172.awb") / 1000

					if var_221_5 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_5 + 0
					end

					if var_221_1.prefab_name ~= "" and arg_218_1.actors_[var_221_1.prefab_name] ~= nil then
						local var_221_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_1.prefab_name].transform, "story_v_out_423172", "423172050", "story_v_out_423172.awb")

						arg_218_1:RecordAudio("423172050", var_221_6)
						arg_218_1:RecordAudio("423172050", var_221_6)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_423172", "423172050", "story_v_out_423172.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_423172", "423172050", "story_v_out_423172.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_7 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_7 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_7

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_7 and arg_218_1.time_ < 0 + var_221_7 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play423172051 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 423172051
		arg_222_1.duration_ = 3.03

		local var_222_0 = {
			zh = 3.033,
			ja = 2.666
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play423172052(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 0.175

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_1 = arg_222_1:GetWordFromCfg(423172051)
				local var_225_2 = arg_222_1:FormatText(var_225_1.content)

				arg_222_1.text_.text = var_225_2

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_4 = 7 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 7)

				if (7 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_2) / 7)) > 0 and var_225_0 < var_225_4 then
					arg_222_1.talkMaxDuration = var_225_4

					if var_225_4 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_4 + 0
					end
				end

				arg_222_1.text_.text = var_225_2
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172051", "story_v_out_423172.awb") ~= 0 then
					local var_225_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172051", "story_v_out_423172.awb") / 1000

					if var_225_5 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_5 + 0
					end

					if var_225_1.prefab_name ~= "" and arg_222_1.actors_[var_225_1.prefab_name] ~= nil then
						local var_225_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_1.prefab_name].transform, "story_v_out_423172", "423172051", "story_v_out_423172.awb")

						arg_222_1:RecordAudio("423172051", var_225_6)
						arg_222_1:RecordAudio("423172051", var_225_6)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_423172", "423172051", "story_v_out_423172.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_423172", "423172051", "story_v_out_423172.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_7 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_7

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play423172052 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 423172052
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play423172053(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0.133333333333333 < arg_226_1.time_ and arg_226_1.time_ <= 0.133333333333333 + arg_229_0 then
				arg_226_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion01", "")
			end

			local var_229_1 = 0
			local var_229_2 = 1.35

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, false)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_3 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(423172052).content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 54 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 54)

				if (54 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 54)) > 0 and var_229_2 < var_229_5 then
					arg_226_1.talkMaxDuration = var_229_5

					if var_229_5 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + var_229_1
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_6 = math.max(var_229_2, arg_226_1.talkMaxDuration)

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_6 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_1) / var_229_6

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_1 + var_229_6 and arg_226_1.time_ < var_229_1 + var_229_6 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play423172053 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 423172053
		arg_230_1.duration_ = 7

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play423172054(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_0 = 1

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 then
				local var_233_1 = Color.New(0, 0, 0)

				var_233_1.a = Mathf.Lerp(0, 1, (arg_230_1.time_ - 0) / var_233_0)
				arg_230_1.mask_.color = var_233_1
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 then
				local var_233_2 = Color.New(0, 0, 0)

				var_233_2.a = 1
				arg_230_1.mask_.color = var_233_2
			end

			local var_233_3 = 1

			if 1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_3 + arg_233_0 then
				arg_230_1.mask_.enabled = true
				arg_230_1.mask_.raycastTarget = true

				arg_230_1:SetGaussion(false)
			end

			local var_233_4 = 1

			if var_233_3 <= arg_230_1.time_ and arg_230_1.time_ < var_233_3 + var_233_4 then
				local var_233_5 = Color.New(0, 0, 0)

				var_233_5.a = Mathf.Lerp(1, 0, (arg_230_1.time_ - var_233_3) / var_233_4)
				arg_230_1.mask_.color = var_233_5
			end

			if arg_230_1.time_ >= var_233_3 + var_233_4 and arg_230_1.time_ < var_233_3 + var_233_4 + arg_233_0 then
				local var_233_6 = Color.New(0, 0, 0)

				arg_230_1.mask_.enabled = false
				var_233_6.a = 0
				arg_230_1.mask_.color = var_233_6
			end

			local var_233_7 = arg_230_1.bgs_.SS2304.transform

			if 1 < arg_230_1.time_ and arg_230_1.time_ <= 1 + arg_233_0 then
				arg_230_1.var_.moveOldPosSS2304 = var_233_7.localPosition
			end

			local var_233_8 = 2.5

			if 1 <= arg_230_1.time_ and arg_230_1.time_ < 1 + var_233_8 then
				var_233_7.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPosSS2304, Vector3.New(1, -1.5, -1.2), (arg_230_1.time_ - 1) / var_233_8)
			end

			if arg_230_1.time_ >= 1 + var_233_8 and arg_230_1.time_ < 1 + var_233_8 + arg_233_0 then
				var_233_7.localPosition = Vector3.New(1, -1.5, -1.2)
			end

			local var_233_9 = 2

			if 2 < arg_230_1.time_ and arg_230_1.time_ <= var_233_9 + arg_233_0 then
				arg_230_1.allBtn_.enabled = false
			end

			if arg_230_1.time_ >= var_233_9 + 1.5 and arg_230_1.time_ < var_233_9 + 1.5 + arg_233_0 then
				arg_230_1.allBtn_.enabled = true
			end

			if arg_230_1.frameCnt_ <= 1 then
				arg_230_1.dialog_:SetActive(false)
			end

			local var_233_10 = 2
			local var_233_11 = 1.175

			if 2 < arg_230_1.time_ and arg_230_1.time_ <= var_233_10 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0

				arg_230_1.dialog_:SetActive(true)

				arg_230_1.dialogCg_.alpha = 0

				local var_233_12 = LeanTween.value(arg_230_1.dialog_, 0, 1, 0.3)

				var_233_12:setOnUpdate(LuaHelper.FloatAction(function(arg_234_0)
					arg_230_1.dialogCg_.alpha = arg_234_0
				end))
				var_233_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_230_1.dialog_)
					var_233_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_230_1.duration_ = arg_230_1.duration_ + 0.3

				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_13 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(423172053).content)

				arg_230_1.text_.text = var_233_13

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_15 = 47 <= 0 and var_233_11 or var_233_11 * (utf8.len(var_233_13) / 47)

				if (47 <= 0 and var_233_11 or var_233_11 * (utf8.len(var_233_13) / 47)) > 0 and var_233_11 < var_233_15 then
					arg_230_1.talkMaxDuration = var_233_15
					var_233_10 = var_233_10 + 0.3

					if var_233_15 + var_233_10 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_15 + var_233_10
					end
				end

				arg_230_1.text_.text = var_233_13
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_16 = var_233_10 + 0.3
			local var_233_17 = math.max(var_233_11, arg_230_1.talkMaxDuration)

			if var_233_10 + 0.3 <= arg_230_1.time_ and arg_230_1.time_ < var_233_16 + var_233_17 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_16) / var_233_17

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_16 + var_233_17 and arg_230_1.time_ < var_233_16 + var_233_17 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "SS2304",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.5,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(1, -1.5, -1),
					endPos = Vector3.New(1, -1.5, -1.2),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play423172054 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 423172054
		arg_236_1.duration_ = 7.8

		local var_236_0 = {
			zh = 7.8,
			ja = 6.6
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play423172055(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0.65

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_1 = arg_236_1:GetWordFromCfg(423172054)
				local var_239_2 = arg_236_1:FormatText(var_239_1.content)

				arg_236_1.text_.text = var_239_2

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_4 = 26 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 26)

				if (26 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 26)) > 0 and var_239_0 < var_239_4 then
					arg_236_1.talkMaxDuration = var_239_4

					if var_239_4 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_4 + 0
					end
				end

				arg_236_1.text_.text = var_239_2
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172054", "story_v_out_423172.awb") ~= 0 then
					local var_239_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172054", "story_v_out_423172.awb") / 1000

					if var_239_5 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + 0
					end

					if var_239_1.prefab_name ~= "" and arg_236_1.actors_[var_239_1.prefab_name] ~= nil then
						local var_239_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_1.prefab_name].transform, "story_v_out_423172", "423172054", "story_v_out_423172.awb")

						arg_236_1:RecordAudio("423172054", var_239_6)
						arg_236_1:RecordAudio("423172054", var_239_6)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_423172", "423172054", "story_v_out_423172.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_423172", "423172054", "story_v_out_423172.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_7 and arg_236_1.time_ < 0 + var_239_7 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play423172055 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 423172055
		arg_240_1.duration_ = 8.43

		local var_240_0 = {
			zh = 8.433,
			ja = 5.2
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play423172056(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = 0.8

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, true)
				arg_240_1.iconController_:SetSelectedState("hero")

				arg_240_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3054")

				arg_240_1.callingController_:SetSelectedState("normal")

				arg_240_1.keyicon_.color = Color.New(1, 1, 1)
				arg_240_1.icon_.color = Color.New(1, 1, 1)

				local var_243_1 = arg_240_1:GetWordFromCfg(423172055)
				local var_243_2 = arg_240_1:FormatText(var_243_1.content)

				arg_240_1.text_.text = var_243_2

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_4 = 32 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 32)

				if (32 <= 0 and var_243_0 or var_243_0 * (utf8.len(var_243_2) / 32)) > 0 and var_243_0 < var_243_4 then
					arg_240_1.talkMaxDuration = var_243_4

					if var_243_4 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_4 + 0
					end
				end

				arg_240_1.text_.text = var_243_2
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172055", "story_v_out_423172.awb") ~= 0 then
					local var_243_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172055", "story_v_out_423172.awb") / 1000

					if var_243_5 + 0 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_5 + 0
					end

					if var_243_1.prefab_name ~= "" and arg_240_1.actors_[var_243_1.prefab_name] ~= nil then
						local var_243_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_1.prefab_name].transform, "story_v_out_423172", "423172055", "story_v_out_423172.awb")

						arg_240_1:RecordAudio("423172055", var_243_6)
						arg_240_1:RecordAudio("423172055", var_243_6)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_423172", "423172055", "story_v_out_423172.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_423172", "423172055", "story_v_out_423172.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_7 = math.max(var_243_0, arg_240_1.talkMaxDuration)

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_7 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - 0) / var_243_7

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= 0 + var_243_7 and arg_240_1.time_ < 0 + var_243_7 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play423172056 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 423172056
		arg_244_1.duration_ = 9.17

		local var_244_0 = {
			zh = 6.766,
			ja = 9.166
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play423172057(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0.425

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_1 = arg_244_1:GetWordFromCfg(423172056)
				local var_247_2 = arg_244_1:FormatText(var_247_1.content)

				arg_244_1.text_.text = var_247_2

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_4 = 17 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 17)

				if (17 <= 0 and var_247_0 or var_247_0 * (utf8.len(var_247_2) / 17)) > 0 and var_247_0 < var_247_4 then
					arg_244_1.talkMaxDuration = var_247_4

					if var_247_4 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_4 + 0
					end
				end

				arg_244_1.text_.text = var_247_2
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172056", "story_v_out_423172.awb") ~= 0 then
					local var_247_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172056", "story_v_out_423172.awb") / 1000

					if var_247_5 + 0 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_5 + 0
					end

					if var_247_1.prefab_name ~= "" and arg_244_1.actors_[var_247_1.prefab_name] ~= nil then
						local var_247_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_1.prefab_name].transform, "story_v_out_423172", "423172056", "story_v_out_423172.awb")

						arg_244_1:RecordAudio("423172056", var_247_6)
						arg_244_1:RecordAudio("423172056", var_247_6)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_423172", "423172056", "story_v_out_423172.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_423172", "423172056", "story_v_out_423172.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_7 = math.max(var_247_0, arg_244_1.talkMaxDuration)

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_7 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - 0) / var_247_7

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= 0 + var_247_7 and arg_244_1.time_ < 0 + var_247_7 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play423172057 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 423172057
		arg_248_1.duration_ = 8.17

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play423172058(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.mask_.enabled = true
				arg_248_1.mask_.raycastTarget = true

				arg_248_1:SetGaussion(false)
			end

			local var_251_0 = 2

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 then
				local var_251_1 = Color.New(0, 0, 0)

				var_251_1.a = Mathf.Lerp(0, 1, (arg_248_1.time_ - 0) / var_251_0)
				arg_248_1.mask_.color = var_251_1
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 then
				local var_251_2 = Color.New(0, 0, 0)

				var_251_2.a = 1
				arg_248_1.mask_.color = var_251_2
			end

			local var_251_3 = 2

			if 2 < arg_248_1.time_ and arg_248_1.time_ <= var_251_3 + arg_251_0 then
				arg_248_1.mask_.enabled = true
				arg_248_1.mask_.raycastTarget = true

				arg_248_1:SetGaussion(false)
			end

			local var_251_4 = 1.5

			if var_251_3 <= arg_248_1.time_ and arg_248_1.time_ < var_251_3 + var_251_4 then
				local var_251_5 = Color.New(0, 0, 0)

				var_251_5.a = Mathf.Lerp(1, 0, (arg_248_1.time_ - var_251_3) / var_251_4)
				arg_248_1.mask_.color = var_251_5
			end

			if arg_248_1.time_ >= var_251_3 + var_251_4 and arg_248_1.time_ < var_251_3 + var_251_4 + arg_251_0 then
				local var_251_6 = Color.New(0, 0, 0)

				arg_248_1.mask_.enabled = false
				var_251_6.a = 0
				arg_248_1.mask_.color = var_251_6
			end

			if 5.06666666666667 < arg_248_1.time_ and arg_248_1.time_ <= 5.06666666666667 + arg_251_0 then
				arg_248_1:AudioAction("play", "effect", "se_story_144", "se_story_144_gun07", "")
			end

			if arg_248_1.frameCnt_ <= 1 then
				arg_248_1.dialog_:SetActive(false)
			end

			local var_251_8 = 3.16666666666667
			local var_251_9 = 2.1

			if 3.16666666666667 < arg_248_1.time_ and arg_248_1.time_ <= var_251_8 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0

				arg_248_1.dialog_:SetActive(true)

				arg_248_1.dialogCg_.alpha = 0

				local var_251_10 = LeanTween.value(arg_248_1.dialog_, 0, 1, 0.3)

				var_251_10:setOnUpdate(LuaHelper.FloatAction(function(arg_252_0)
					arg_248_1.dialogCg_.alpha = arg_252_0
				end))
				var_251_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_248_1.dialog_)
					var_251_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_248_1.duration_ = arg_248_1.duration_ + 0.3

				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_11 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(423172057).content)

				arg_248_1.text_.text = var_251_11

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_13 = 84 <= 0 and var_251_9 or var_251_9 * (utf8.len(var_251_11) / 84)

				if (84 <= 0 and var_251_9 or var_251_9 * (utf8.len(var_251_11) / 84)) > 0 and var_251_9 < var_251_13 then
					arg_248_1.talkMaxDuration = var_251_13
					var_251_8 = var_251_8 + 0.3

					if var_251_13 + var_251_8 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_13 + var_251_8
					end
				end

				arg_248_1.text_.text = var_251_11
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_14 = var_251_8 + 0.3
			local var_251_15 = math.max(var_251_9, arg_248_1.talkMaxDuration)

			if var_251_8 + 0.3 <= arg_248_1.time_ and arg_248_1.time_ < var_251_14 + var_251_15 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_14) / var_251_15

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_14 + var_251_15 and arg_248_1.time_ < var_251_14 + var_251_15 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play423172058 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 423172058
		arg_254_1.duration_ = 6.75

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play423172059(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.mask_.enabled = true
				arg_254_1.mask_.raycastTarget = true

				arg_254_1:SetGaussion(false)
			end

			local var_257_0 = 3

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 then
				local var_257_1 = Color.New(0, 0, 0)

				var_257_1.a = Mathf.Lerp(0, 1, (arg_254_1.time_ - 0) / var_257_0)
				arg_254_1.mask_.color = var_257_1
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 then
				local var_257_2 = Color.New(0, 0, 0)

				var_257_2.a = 1
				arg_254_1.mask_.color = var_257_2
			end

			local var_257_3 = 3

			if 3 < arg_254_1.time_ and arg_254_1.time_ <= var_257_3 + arg_257_0 then
				arg_254_1.mask_.enabled = true
				arg_254_1.mask_.raycastTarget = true

				arg_254_1:SetGaussion(false)
			end

			local var_257_4 = 1

			if var_257_3 <= arg_254_1.time_ and arg_254_1.time_ < var_257_3 + var_257_4 then
				local var_257_5 = Color.New(0, 0, 0)

				var_257_5.a = Mathf.Lerp(1, 0, (arg_254_1.time_ - var_257_3) / var_257_4)
				arg_254_1.mask_.color = var_257_5
			end

			if arg_254_1.time_ >= var_257_3 + var_257_4 and arg_254_1.time_ < var_257_3 + var_257_4 + arg_257_0 then
				local var_257_6 = Color.New(0, 0, 0)

				arg_254_1.mask_.enabled = false
				var_257_6.a = 0
				arg_254_1.mask_.color = var_257_6
			end

			local var_257_7 = "STblack"

			if arg_254_1.bgs_.STblack == nil then
				local var_257_8 = Object.Instantiate(arg_254_1.paintGo_)

				var_257_8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_257_7)
				var_257_8.name = var_257_7
				var_257_8.transform.parent = arg_254_1.stage_.transform
				var_257_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_254_1.bgs_[var_257_7] = var_257_8
			end

			if 3 < arg_254_1.time_ and arg_254_1.time_ <= 3 + arg_257_0 then
				local var_257_9 = arg_254_1.bgs_.STblack

				arg_254_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_257_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_257_10 = var_257_9:GetComponent("SpriteRenderer")

				if var_257_10 and var_257_10.sprite then
					local var_257_11 = 2 * (var_257_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_257_9.transform.localScale = Vector3.New(var_257_11 / var_257_10.sprite.bounds.size.y < var_257_11 * manager.ui.mainCameraCom_.aspect / var_257_10.sprite.bounds.size.x and var_257_11 * manager.ui.mainCameraCom_.aspect / var_257_10.sprite.bounds.size.x or var_257_11 / var_257_10.sprite.bounds.size.y, var_257_11 / var_257_10.sprite.bounds.size.y < var_257_11 * manager.ui.mainCameraCom_.aspect / var_257_10.sprite.bounds.size.x and var_257_11 * manager.ui.mainCameraCom_.aspect / var_257_10.sprite.bounds.size.x or var_257_11 / var_257_10.sprite.bounds.size.y, 0)
				end

				for iter_257_0, iter_257_1 in pairs(arg_254_1.bgs_) do
					if iter_257_0 ~= "STblack" then
						iter_257_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 3 < arg_254_1.time_ and arg_254_1.time_ <= 3 + arg_257_0 then
				arg_254_1.fswbg_:SetActive(true)
				arg_254_1.dialog_:SetActive(false)

				arg_254_1.fswtw_.percent = 0
				arg_254_1.fswt_.text = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(423172058).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.fswt_)

				arg_254_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_254_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_254_1.fswtw_:SetDirty()

				arg_254_1.typewritterCharCountI18N = 0

				SetActive(arg_254_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_254_1:ShowNextGo(false)
			end

			local var_257_12 = 3.01666666666667

			if 3.01666666666667 < arg_254_1.time_ and arg_254_1.time_ <= var_257_12 + arg_257_0 then
				arg_254_1.var_.oldValueTypewriter = arg_254_1.fswtw_.percent

				SetActive(arg_254_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_254_1:ShowNextGo(false)
			end

			local var_257_13 = 56
			local var_257_14 = 3.73333333333333
			local var_257_15, var_257_16 = arg_254_1:GetPercentByPara(arg_254_1:FormatText(arg_254_1:GetWordFromCfg(423172058).content), 1)

			if var_257_12 < arg_254_1.time_ and arg_254_1.time_ <= var_257_12 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0

				local var_257_17 = var_257_13 <= 0 and var_257_14 or var_257_14 * ((var_257_16 - arg_254_1.typewritterCharCountI18N) / var_257_13)

				if (var_257_13 <= 0 and var_257_14 or var_257_14 * ((var_257_16 - arg_254_1.typewritterCharCountI18N) / var_257_13)) > 0 and var_257_14 < var_257_17 then
					arg_254_1.talkMaxDuration = var_257_17

					if var_257_17 + var_257_12 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_17 + var_257_12
					end
				end
			end

			local var_257_18 = math.max(3.73333333333333, arg_254_1.talkMaxDuration)

			if var_257_12 <= arg_254_1.time_ and arg_254_1.time_ < var_257_12 + var_257_18 then
				arg_254_1.fswtw_.percent = Mathf.Lerp(arg_254_1.var_.oldValueTypewriter, var_257_15, (arg_254_1.time_ - var_257_12) / var_257_18)
				arg_254_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_254_1.fswtw_:SetDirty()
			end

			if arg_254_1.time_ >= var_257_12 + var_257_18 and arg_254_1.time_ < var_257_12 + var_257_18 + arg_257_0 then
				arg_254_1.fswtw_.percent = var_257_15

				arg_254_1.fswtw_:SetDirty()
				arg_254_1:ShowNextGo(true)

				arg_254_1.typewritterCharCountI18N = var_257_16
			end

			if 3 < arg_254_1.time_ and arg_254_1.time_ <= 3 + arg_257_0 then
				local var_257_19 = arg_254_1.fswbg_.transform:Find("textbox/adapt/content") or arg_254_1.fswbg_.transform:Find("textbox/content")
				local var_257_20 = arg_254_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_257_21 = var_257_19:GetComponent("RectTransform")

				var_257_19:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_257_21.offsetMin = Vector2.New(0, 0)
				var_257_21.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play423172059 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 423172059
		arg_258_1.duration_ = 8.5

		local var_258_0 = {
			zh = 6.466,
			ja = 8.5
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play423172060(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 1 < arg_258_1.time_ and arg_258_1.time_ <= 1 + arg_261_0 then
				local var_261_0 = arg_258_1.bgs_.ST0113a

				arg_258_1.bgs_.ST0113a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_261_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_261_1 = var_261_0:GetComponent("SpriteRenderer")

				if var_261_1 and var_261_1.sprite then
					local var_261_2 = 2 * (var_261_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_261_0.transform.localScale = Vector3.New(var_261_2 / var_261_1.sprite.bounds.size.y < var_261_2 * manager.ui.mainCameraCom_.aspect / var_261_1.sprite.bounds.size.x and var_261_2 * manager.ui.mainCameraCom_.aspect / var_261_1.sprite.bounds.size.x or var_261_2 / var_261_1.sprite.bounds.size.y, var_261_2 / var_261_1.sprite.bounds.size.y < var_261_2 * manager.ui.mainCameraCom_.aspect / var_261_1.sprite.bounds.size.x and var_261_2 * manager.ui.mainCameraCom_.aspect / var_261_1.sprite.bounds.size.x or var_261_2 / var_261_1.sprite.bounds.size.y, 0)
				end

				for iter_261_0, iter_261_1 in pairs(arg_258_1.bgs_) do
					if iter_261_0 ~= "ST0113a" then
						iter_261_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_261_3 = 0

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_3 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_4 = 1

			if var_261_3 <= arg_258_1.time_ and arg_258_1.time_ < var_261_3 + var_261_4 then
				local var_261_5 = Color.New(0, 0, 0)

				var_261_5.a = Mathf.Lerp(0, 1, (arg_258_1.time_ - var_261_3) / var_261_4)
				arg_258_1.mask_.color = var_261_5
			end

			if arg_258_1.time_ >= var_261_3 + var_261_4 and arg_258_1.time_ < var_261_3 + var_261_4 + arg_261_0 then
				local var_261_6 = Color.New(0, 0, 0)

				var_261_6.a = 1
				arg_258_1.mask_.color = var_261_6
			end

			local var_261_7 = 1

			if 1 < arg_258_1.time_ and arg_258_1.time_ <= var_261_7 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_8 = 1

			if var_261_7 <= arg_258_1.time_ and arg_258_1.time_ < var_261_7 + var_261_8 then
				local var_261_9 = Color.New(0, 0, 0)

				var_261_9.a = Mathf.Lerp(1, 0, (arg_258_1.time_ - var_261_7) / var_261_8)
				arg_258_1.mask_.color = var_261_9
			end

			if arg_258_1.time_ >= var_261_7 + var_261_8 and arg_258_1.time_ < var_261_7 + var_261_8 + arg_261_0 then
				local var_261_10 = Color.New(0, 0, 0)

				arg_258_1.mask_.enabled = false
				var_261_10.a = 0
				arg_258_1.mask_.color = var_261_10
			end

			if 1 < arg_258_1.time_ and arg_258_1.time_ <= 1 + arg_261_0 then
				arg_258_1.fswbg_:SetActive(false)
				arg_258_1.dialog_:SetActive(false)
				SetActive(arg_258_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_258_1:ShowNextGo(false)
			end

			local var_261_11 = arg_258_1.actors_["3054"].transform

			if 2 < arg_258_1.time_ and arg_258_1.time_ <= 2 + arg_261_0 then
				arg_258_1.var_.moveOldPos3054 = var_261_11.localPosition
				var_261_11.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("3054", 3)

				for iter_261_2 = 0, var_261_11.childCount - 1 do
					local var_261_12 = var_261_11:GetChild(iter_261_2)

					if var_261_12.name == "split_1" or not string.find(var_261_12.name, "split") then
						var_261_12.gameObject:SetActive(true)
					else
						var_261_12.gameObject:SetActive(false)
					end
				end
			end

			local var_261_13 = 0.001

			if 2 <= arg_258_1.time_ and arg_258_1.time_ < 2 + var_261_13 then
				var_261_11.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_258_1.time_ - 2) / var_261_13)
			end

			if arg_258_1.time_ >= 2 + var_261_13 and arg_258_1.time_ < 2 + var_261_13 + arg_261_0 then
				var_261_11.localPosition = Vector3.New(0, -275, -280)
			end

			local var_261_14 = arg_258_1.actors_["3054"]

			if 2 < arg_258_1.time_ and arg_258_1.time_ <= 2 + arg_261_0 and not isNil(var_261_14) and arg_258_1.var_.actorSpriteComps3054 == nil then
				arg_258_1.var_.actorSpriteComps3054 = var_261_14:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_15 = 0.2

			if 2 <= arg_258_1.time_ and arg_258_1.time_ < 2 + var_261_15 and not isNil(var_261_14) then
				if arg_258_1.var_.actorSpriteComps3054 then
					for iter_261_3, iter_261_4 in pairs(arg_258_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_261_4 then
							if arg_258_1.isInRecall_ then
								iter_261_4.color = Color.New(Mathf.Lerp(iter_261_4.color.r, arg_258_1.hightColor1.r, (arg_258_1.time_ - 2) / var_261_15), Mathf.Lerp(iter_261_4.color.g, arg_258_1.hightColor1.g, (arg_258_1.time_ - 2) / var_261_15), (Mathf.Lerp(iter_261_4.color.b, arg_258_1.hightColor1.b, (arg_258_1.time_ - 2) / var_261_15)))
							else
								local var_261_16 = Mathf.Lerp(iter_261_4.color.r, 1, (arg_258_1.time_ - 2) / var_261_15)

								iter_261_4.color = Color.New(var_261_16, var_261_16, var_261_16)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= 2 + var_261_15 and arg_258_1.time_ < 2 + var_261_15 + arg_261_0 and not isNil(var_261_14) and arg_258_1.var_.actorSpriteComps3054 then
				for iter_261_5, iter_261_6 in pairs(arg_258_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_261_6 then
						iter_261_6.color = arg_258_1.isInRecall_ and (arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_258_1.var_.actorSpriteComps3054 = nil
			end

			local var_261_17 = 2
			local var_261_18 = 0.325

			if 2 < arg_258_1.time_ and arg_258_1.time_ <= var_261_17 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_19 = arg_258_1:GetWordFromCfg(423172059)
				local var_261_20 = arg_258_1:FormatText(var_261_19.content)

				arg_258_1.text_.text = var_261_20

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_22 = 13 <= 0 and var_261_18 or var_261_18 * (utf8.len(var_261_20) / 13)

				if (13 <= 0 and var_261_18 or var_261_18 * (utf8.len(var_261_20) / 13)) > 0 and var_261_18 < var_261_22 then
					arg_258_1.talkMaxDuration = var_261_22

					if var_261_22 + var_261_17 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_22 + var_261_17
					end
				end

				arg_258_1.text_.text = var_261_20
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172059", "story_v_out_423172.awb") ~= 0 then
					local var_261_23 = manager.audio:GetVoiceLength("story_v_out_423172", "423172059", "story_v_out_423172.awb") / 1000

					if var_261_23 + var_261_17 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_23 + var_261_17
					end

					if var_261_19.prefab_name ~= "" and arg_258_1.actors_[var_261_19.prefab_name] ~= nil then
						local var_261_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_19.prefab_name].transform, "story_v_out_423172", "423172059", "story_v_out_423172.awb")

						arg_258_1:RecordAudio("423172059", var_261_24)
						arg_258_1:RecordAudio("423172059", var_261_24)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_423172", "423172059", "story_v_out_423172.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_423172", "423172059", "story_v_out_423172.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_25 = math.max(var_261_18, arg_258_1.talkMaxDuration)

			if var_261_17 <= arg_258_1.time_ and arg_258_1.time_ < var_261_17 + var_261_25 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_17) / var_261_25

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_17 + var_261_25 and arg_258_1.time_ < var_261_17 + var_261_25 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play423172060 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 423172060
		arg_262_1.duration_ = 14.03

		local var_262_0 = {
			zh = 14.033,
			ja = 11.3
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play423172061(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = 1.15

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_1 = arg_262_1:GetWordFromCfg(423172060)
				local var_265_2 = arg_262_1:FormatText(var_265_1.content)

				arg_262_1.text_.text = var_265_2

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_4 = 46 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_2) / 46)

				if (46 <= 0 and var_265_0 or var_265_0 * (utf8.len(var_265_2) / 46)) > 0 and var_265_0 < var_265_4 then
					arg_262_1.talkMaxDuration = var_265_4

					if var_265_4 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_4 + 0
					end
				end

				arg_262_1.text_.text = var_265_2
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172060", "story_v_out_423172.awb") ~= 0 then
					local var_265_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172060", "story_v_out_423172.awb") / 1000

					if var_265_5 + 0 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_5 + 0
					end

					if var_265_1.prefab_name ~= "" and arg_262_1.actors_[var_265_1.prefab_name] ~= nil then
						local var_265_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_1.prefab_name].transform, "story_v_out_423172", "423172060", "story_v_out_423172.awb")

						arg_262_1:RecordAudio("423172060", var_265_6)
						arg_262_1:RecordAudio("423172060", var_265_6)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_423172", "423172060", "story_v_out_423172.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_423172", "423172060", "story_v_out_423172.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_7 = math.max(var_265_0, arg_262_1.talkMaxDuration)

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_7 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - 0) / var_265_7

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= 0 + var_265_7 and arg_262_1.time_ < 0 + var_265_7 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play423172061 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 423172061
		arg_266_1.duration_ = 12.8

		local var_266_0 = {
			zh = 12.8,
			ja = 10.133
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play423172062(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 1.125

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_1 = arg_266_1:GetWordFromCfg(423172061)
				local var_269_2 = arg_266_1:FormatText(var_269_1.content)

				arg_266_1.text_.text = var_269_2

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_4 = 45 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_2) / 45)

				if (45 <= 0 and var_269_0 or var_269_0 * (utf8.len(var_269_2) / 45)) > 0 and var_269_0 < var_269_4 then
					arg_266_1.talkMaxDuration = var_269_4

					if var_269_4 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_4 + 0
					end
				end

				arg_266_1.text_.text = var_269_2
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172061", "story_v_out_423172.awb") ~= 0 then
					local var_269_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172061", "story_v_out_423172.awb") / 1000

					if var_269_5 + 0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_5 + 0
					end

					if var_269_1.prefab_name ~= "" and arg_266_1.actors_[var_269_1.prefab_name] ~= nil then
						local var_269_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_1.prefab_name].transform, "story_v_out_423172", "423172061", "story_v_out_423172.awb")

						arg_266_1:RecordAudio("423172061", var_269_6)
						arg_266_1:RecordAudio("423172061", var_269_6)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_423172", "423172061", "story_v_out_423172.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_423172", "423172061", "story_v_out_423172.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_7 = math.max(var_269_0, arg_266_1.talkMaxDuration)

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_7 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - 0) / var_269_7

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= 0 + var_269_7 and arg_266_1.time_ < 0 + var_269_7 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play423172062 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 423172062
		arg_270_1.duration_ = 11.7

		local var_270_0 = {
			zh = 11.7,
			ja = 11.366
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
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play423172063(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0.975

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_1 = arg_270_1:GetWordFromCfg(423172062)
				local var_273_2 = arg_270_1:FormatText(var_273_1.content)

				arg_270_1.text_.text = var_273_2

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_4 = 39 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_2) / 39)

				if (39 <= 0 and var_273_0 or var_273_0 * (utf8.len(var_273_2) / 39)) > 0 and var_273_0 < var_273_4 then
					arg_270_1.talkMaxDuration = var_273_4

					if var_273_4 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_4 + 0
					end
				end

				arg_270_1.text_.text = var_273_2
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172062", "story_v_out_423172.awb") ~= 0 then
					local var_273_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172062", "story_v_out_423172.awb") / 1000

					if var_273_5 + 0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_5 + 0
					end

					if var_273_1.prefab_name ~= "" and arg_270_1.actors_[var_273_1.prefab_name] ~= nil then
						local var_273_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_1.prefab_name].transform, "story_v_out_423172", "423172062", "story_v_out_423172.awb")

						arg_270_1:RecordAudio("423172062", var_273_6)
						arg_270_1:RecordAudio("423172062", var_273_6)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_423172", "423172062", "story_v_out_423172.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_423172", "423172062", "story_v_out_423172.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_7 = math.max(var_273_0, arg_270_1.talkMaxDuration)

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_7 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - 0) / var_273_7

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= 0 + var_273_7 and arg_270_1.time_ < 0 + var_273_7 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play423172063 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 423172063
		arg_274_1.duration_ = 13.63

		local var_274_0 = {
			zh = 11.966,
			ja = 13.633
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play423172064(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 1.2

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_1 = arg_274_1:GetWordFromCfg(423172063)
				local var_277_2 = arg_274_1:FormatText(var_277_1.content)

				arg_274_1.text_.text = var_277_2

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_4 = 48 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_2) / 48)

				if (48 <= 0 and var_277_0 or var_277_0 * (utf8.len(var_277_2) / 48)) > 0 and var_277_0 < var_277_4 then
					arg_274_1.talkMaxDuration = var_277_4

					if var_277_4 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_4 + 0
					end
				end

				arg_274_1.text_.text = var_277_2
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172063", "story_v_out_423172.awb") ~= 0 then
					local var_277_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172063", "story_v_out_423172.awb") / 1000

					if var_277_5 + 0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_5 + 0
					end

					if var_277_1.prefab_name ~= "" and arg_274_1.actors_[var_277_1.prefab_name] ~= nil then
						local var_277_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_1.prefab_name].transform, "story_v_out_423172", "423172063", "story_v_out_423172.awb")

						arg_274_1:RecordAudio("423172063", var_277_6)
						arg_274_1:RecordAudio("423172063", var_277_6)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_423172", "423172063", "story_v_out_423172.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_423172", "423172063", "story_v_out_423172.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_7 = math.max(var_277_0, arg_274_1.talkMaxDuration)

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_7 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - 0) / var_277_7

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= 0 + var_277_7 and arg_274_1.time_ < 0 + var_277_7 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play423172064 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 423172064
		arg_278_1.duration_ = 7.37

		local var_278_0 = {
			zh = 7.233,
			ja = 7.366
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play423172065(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0.725

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_1 = arg_278_1:GetWordFromCfg(423172064)
				local var_281_2 = arg_278_1:FormatText(var_281_1.content)

				arg_278_1.text_.text = var_281_2

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_4 = 29 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 29)

				if (29 <= 0 and var_281_0 or var_281_0 * (utf8.len(var_281_2) / 29)) > 0 and var_281_0 < var_281_4 then
					arg_278_1.talkMaxDuration = var_281_4

					if var_281_4 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_4 + 0
					end
				end

				arg_278_1.text_.text = var_281_2
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172064", "story_v_out_423172.awb") ~= 0 then
					local var_281_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172064", "story_v_out_423172.awb") / 1000

					if var_281_5 + 0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + 0
					end

					if var_281_1.prefab_name ~= "" and arg_278_1.actors_[var_281_1.prefab_name] ~= nil then
						local var_281_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_1.prefab_name].transform, "story_v_out_423172", "423172064", "story_v_out_423172.awb")

						arg_278_1:RecordAudio("423172064", var_281_6)
						arg_278_1:RecordAudio("423172064", var_281_6)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_423172", "423172064", "story_v_out_423172.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_423172", "423172064", "story_v_out_423172.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_7 = math.max(var_281_0, arg_278_1.talkMaxDuration)

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_7 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - 0) / var_281_7

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= 0 + var_281_7 and arg_278_1.time_ < 0 + var_281_7 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play423172065 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 423172065
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play423172066(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos3054 = arg_282_1.actors_["3054"].transform.localPosition
				arg_282_1.actors_["3054"].transform.localScale = Vector3.New(1, 1, 1)

				arg_282_1:CheckSpriteTmpPos("3054", 7)

				for iter_285_0 = 0, arg_282_1.actors_["3054"].transform.childCount - 1 do
					local var_285_0 = arg_282_1.actors_["3054"].transform:GetChild(iter_285_0)

					if var_285_0.name == "split_2" or not string.find(var_285_0.name, "split") then
						var_285_0.gameObject:SetActive(true)
					else
						var_285_0.gameObject:SetActive(false)
					end
				end
			end

			local var_285_1 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_1 then
				arg_282_1.actors_["3054"].transform.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos3054, Vector3.New(0, -2000, 0), (arg_282_1.time_ - 0) / var_285_1)
			end

			if arg_282_1.time_ >= 0 + var_285_1 and arg_282_1.time_ < 0 + var_285_1 + arg_285_0 then
				arg_282_1.actors_["3054"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_285_2 = 0
			local var_285_3 = 1.3

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_2 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, false)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_4 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(423172065).content)

				arg_282_1.text_.text = var_285_4

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_6 = 52 <= 0 and var_285_3 or var_285_3 * (utf8.len(var_285_4) / 52)

				if (52 <= 0 and var_285_3 or var_285_3 * (utf8.len(var_285_4) / 52)) > 0 and var_285_3 < var_285_6 then
					arg_282_1.talkMaxDuration = var_285_6

					if var_285_6 + var_285_2 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_6 + var_285_2
					end
				end

				arg_282_1.text_.text = var_285_4
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_7 = math.max(var_285_3, arg_282_1.talkMaxDuration)

			if var_285_2 <= arg_282_1.time_ and arg_282_1.time_ < var_285_2 + var_285_7 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_2) / var_285_7

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_2 + var_285_7 and arg_282_1.time_ < var_285_2 + var_285_7 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play423172066 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 423172066
		arg_286_1.duration_ = 10.1

		local var_286_0 = {
			zh = 10.1,
			ja = 7.3
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play423172067(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos3054 = arg_286_1.actors_["3054"].transform.localPosition
				arg_286_1.actors_["3054"].transform.localScale = Vector3.New(1, 1, 1)

				arg_286_1:CheckSpriteTmpPos("3054", 3)

				for iter_289_0 = 0, arg_286_1.actors_["3054"].transform.childCount - 1 do
					local var_289_0 = arg_286_1.actors_["3054"].transform:GetChild(iter_289_0)

					if var_289_0.name == "split_4" or not string.find(var_289_0.name, "split") then
						var_289_0.gameObject:SetActive(true)
					else
						var_289_0.gameObject:SetActive(false)
					end
				end
			end

			local var_289_1 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_1 then
				arg_286_1.actors_["3054"].transform.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos3054, Vector3.New(0, -275, -280), (arg_286_1.time_ - 0) / var_289_1)
			end

			if arg_286_1.time_ >= 0 + var_289_1 and arg_286_1.time_ < 0 + var_289_1 + arg_289_0 then
				arg_286_1.actors_["3054"].transform.localPosition = Vector3.New(0, -275, -280)
			end

			local var_289_2 = arg_286_1.actors_["3054"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_2) and arg_286_1.var_.actorSpriteComps3054 == nil then
				arg_286_1.var_.actorSpriteComps3054 = var_289_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_3 = 0.2

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_3 and not isNil(var_289_2) then
				if arg_286_1.var_.actorSpriteComps3054 then
					for iter_289_1, iter_289_2 in pairs(arg_286_1.var_.actorSpriteComps3054:ToTable()) do
						if iter_289_2 then
							if arg_286_1.isInRecall_ then
								iter_289_2.color = Color.New(Mathf.Lerp(iter_289_2.color.r, arg_286_1.hightColor1.r, (arg_286_1.time_ - 0) / var_289_3), Mathf.Lerp(iter_289_2.color.g, arg_286_1.hightColor1.g, (arg_286_1.time_ - 0) / var_289_3), (Mathf.Lerp(iter_289_2.color.b, arg_286_1.hightColor1.b, (arg_286_1.time_ - 0) / var_289_3)))
							else
								local var_289_4 = Mathf.Lerp(iter_289_2.color.r, 1, (arg_286_1.time_ - 0) / var_289_3)

								iter_289_2.color = Color.New(var_289_4, var_289_4, var_289_4)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= 0 + var_289_3 and arg_286_1.time_ < 0 + var_289_3 + arg_289_0 and not isNil(var_289_2) and arg_286_1.var_.actorSpriteComps3054 then
				for iter_289_3, iter_289_4 in pairs(arg_286_1.var_.actorSpriteComps3054:ToTable()) do
					if iter_289_4 then
						iter_289_4.color = arg_286_1.isInRecall_ and (arg_286_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_286_1.var_.actorSpriteComps3054 = nil
			end

			local var_289_5 = 0
			local var_289_6 = 0.575

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_5 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_7 = arg_286_1:GetWordFromCfg(423172066)
				local var_289_8 = arg_286_1:FormatText(var_289_7.content)

				arg_286_1.text_.text = var_289_8

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_10 = 23 <= 0 and var_289_6 or var_289_6 * (utf8.len(var_289_8) / 23)

				if (23 <= 0 and var_289_6 or var_289_6 * (utf8.len(var_289_8) / 23)) > 0 and var_289_6 < var_289_10 then
					arg_286_1.talkMaxDuration = var_289_10

					if var_289_10 + var_289_5 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_10 + var_289_5
					end
				end

				arg_286_1.text_.text = var_289_8
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172066", "story_v_out_423172.awb") ~= 0 then
					local var_289_11 = manager.audio:GetVoiceLength("story_v_out_423172", "423172066", "story_v_out_423172.awb") / 1000

					if var_289_11 + var_289_5 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_11 + var_289_5
					end

					if var_289_7.prefab_name ~= "" and arg_286_1.actors_[var_289_7.prefab_name] ~= nil then
						local var_289_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_7.prefab_name].transform, "story_v_out_423172", "423172066", "story_v_out_423172.awb")

						arg_286_1:RecordAudio("423172066", var_289_12)
						arg_286_1:RecordAudio("423172066", var_289_12)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_423172", "423172066", "story_v_out_423172.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_423172", "423172066", "story_v_out_423172.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_13 = math.max(var_289_6, arg_286_1.talkMaxDuration)

			if var_289_5 <= arg_286_1.time_ and arg_286_1.time_ < var_289_5 + var_289_13 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_5) / var_289_13

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_5 + var_289_13 and arg_286_1.time_ < var_289_5 + var_289_13 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play423172067 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 423172067
		arg_290_1.duration_ = 1.87

		local var_290_0 = {
			zh = 1.866,
			ja = 1.733
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play423172068(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0.125

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[1339].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_1 = arg_290_1:GetWordFromCfg(423172067)
				local var_293_2 = arg_290_1:FormatText(var_293_1.content)

				arg_290_1.text_.text = var_293_2

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_4 = 5 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_2) / 5)

				if (5 <= 0 and var_293_0 or var_293_0 * (utf8.len(var_293_2) / 5)) > 0 and var_293_0 < var_293_4 then
					arg_290_1.talkMaxDuration = var_293_4

					if var_293_4 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_4 + 0
					end
				end

				arg_290_1.text_.text = var_293_2
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423172", "423172067", "story_v_out_423172.awb") ~= 0 then
					local var_293_5 = manager.audio:GetVoiceLength("story_v_out_423172", "423172067", "story_v_out_423172.awb") / 1000

					if var_293_5 + 0 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_5 + 0
					end

					if var_293_1.prefab_name ~= "" and arg_290_1.actors_[var_293_1.prefab_name] ~= nil then
						local var_293_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_1.prefab_name].transform, "story_v_out_423172", "423172067", "story_v_out_423172.awb")

						arg_290_1:RecordAudio("423172067", var_293_6)
						arg_290_1:RecordAudio("423172067", var_293_6)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_423172", "423172067", "story_v_out_423172.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_423172", "423172067", "story_v_out_423172.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_7 = math.max(var_293_0, arg_290_1.talkMaxDuration)

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_7 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - 0) / var_293_7

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= 0 + var_293_7 and arg_290_1.time_ < 0 + var_293_7 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play423172068 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 423172068
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play423172069(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos3054 = arg_294_1.actors_["3054"].transform.localPosition
				arg_294_1.actors_["3054"].transform.localScale = Vector3.New(1, 1, 1)

				arg_294_1:CheckSpriteTmpPos("3054", 7)

				for iter_297_0 = 0, arg_294_1.actors_["3054"].transform.childCount - 1 do
					local var_297_0 = arg_294_1.actors_["3054"].transform:GetChild(iter_297_0)

					if var_297_0.name == "split_2" or not string.find(var_297_0.name, "split") then
						var_297_0.gameObject:SetActive(true)
					else
						var_297_0.gameObject:SetActive(false)
					end
				end
			end

			local var_297_1 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_1 then
				arg_294_1.actors_["3054"].transform.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos3054, Vector3.New(0, -2000, 0), (arg_294_1.time_ - 0) / var_297_1)
			end

			if arg_294_1.time_ >= 0 + var_297_1 and arg_294_1.time_ < 0 + var_297_1 + arg_297_0 then
				arg_294_1.actors_["3054"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:AudioAction("play", "effect", "se_story_144", "se_story_144_footstep_rain01", "")
			end

			if 1.46666666666667 < arg_294_1.time_ and arg_294_1.time_ <= 1.46666666666667 + arg_297_0 then
				arg_294_1:AudioAction("play", "effect", "se_story_144", "se_story_144_down", "")
			end

			local var_297_4 = 0
			local var_297_5 = 0.675

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_4 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_6 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(423172068).content)

				arg_294_1.text_.text = var_297_6

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_8 = 27 <= 0 and var_297_5 or var_297_5 * (utf8.len(var_297_6) / 27)

				if (27 <= 0 and var_297_5 or var_297_5 * (utf8.len(var_297_6) / 27)) > 0 and var_297_5 < var_297_8 then
					arg_294_1.talkMaxDuration = var_297_8

					if var_297_8 + var_297_4 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_8 + var_297_4
					end
				end

				arg_294_1.text_.text = var_297_6
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_9 = math.max(var_297_5, arg_294_1.talkMaxDuration)

			if var_297_4 <= arg_294_1.time_ and arg_294_1.time_ < var_297_4 + var_297_9 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_4) / var_297_9

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_4 + var_297_9 and arg_294_1.time_ < var_297_4 + var_297_9 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play423172069 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 423172069
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
			arg_298_1.auto_ = false
		end

		function arg_298_1.playNext_(arg_300_0)
			arg_298_1.onStoryFinished_()
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.725

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_1 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(423172069).content)

				arg_298_1.text_.text = var_301_1

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_3 = 29 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 29)

				if (29 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_1) / 29)) > 0 and var_301_0 < var_301_3 then
					arg_298_1.talkMaxDuration = var_301_3

					if var_301_3 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_3 + 0
					end
				end

				arg_298_1.text_.text = var_301_1
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_4 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_4 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_4

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_4 and arg_298_1.time_ < 0 + var_301_4 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I24f",
		"TextureConfig/Background/ST0113a",
		"TextureConfig/Background/SS2304",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_423172.awb"
	}
}
