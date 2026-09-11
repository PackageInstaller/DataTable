return {
	Play423082001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 423082001
		arg_1_1.duration_ = 4.97

		local var_1_0 = {
			zh = 4.966,
			ja = 4.866
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
				arg_1_0:Play423082002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I25f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I25f")
				var_4_0.name = "I25f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I25f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I25f

				arg_1_1.bgs_.I25f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I25f" then
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

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
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

			if 0.500666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.500666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous.awb")

				local var_4_24 = manager.audio:GetAudioName("bgm_activity_4_4_story_nervous", "bgm_activity_4_4_story_nervous")

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
			local var_4_26 = 0.4

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(423082001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 16 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 16)

				if (16 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 16)) > 0 and var_4_26 < var_4_31 then
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

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082001", "story_v_out_423082.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_423082", "423082001", "story_v_out_423082.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_423082", "423082001", "story_v_out_423082.awb")

						arg_1_1:RecordAudio("423082001", var_4_33)
						arg_1_1:RecordAudio("423082001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_423082", "423082001", "story_v_out_423082.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_423082", "423082001", "story_v_out_423082.awb")
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
	Play423082002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 423082002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play423082003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_9003
			local var_12_9002
			local var_12_9001
			local var_12_9000

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

			local var_12_5 = manager.ui.mainCamera.transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.shakeOldPos = var_12_5.localPosition
			end

			local var_12_6 = 2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 then
				local var_12_7, var_12_8 = math.modf((arg_9_1.time_ - 0) / 0.066)

				var_12_5.localPosition = Vector3.New(var_12_8 * 0.02, var_12_8 * 0.02, var_12_8 * 0.02) + arg_9_1.var_.shakeOldPos
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 then
				var_12_5.localPosition = arg_9_1.var_.shakeOldPos
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_9 = arg_9_1.var_.effectzhuihuoche1

				if not arg_9_1.var_.effectzhuihuoche1 then
					var_12_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_12_9.name = "zhuihuoche1"
					arg_9_1.var_.effectzhuihuoche1 = var_12_9
				else
					var_12_9.transform:SetParent(var_12_9003)
				end

				var_12_9.transform.localPosition = Vector3.New(-0.2, 0, 0)
				var_12_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_9_1.time_ and arg_9_1.time_ <= 1 + arg_12_0 then
				if arg_9_1.var_.effectzhuihuoche1 then
					Object.Destroy(arg_9_1.var_.effectzhuihuoche1)

					arg_9_1.var_.effectzhuihuoche1 = nil
				end
			end

			if 0.2 < arg_9_1.time_ and arg_9_1.time_ <= 0.2 + arg_12_0 then
				local var_12_12 = arg_9_1.var_.effectzhuihuoche2

				if not arg_9_1.var_.effectzhuihuoche2 then
					var_12_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_12_12.name = "zhuihuoche2"
					arg_9_1.var_.effectzhuihuoche2 = var_12_12
				else
					var_12_12.transform:SetParent(var_12_9002)
				end

				var_12_12.transform.localPosition = Vector3.New(0.5, 0, 0)
				var_12_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.2 < arg_9_1.time_ and arg_9_1.time_ <= 1.2 + arg_12_0 then
				if arg_9_1.var_.effectzhuihuoche2 then
					Object.Destroy(arg_9_1.var_.effectzhuihuoche2)

					arg_9_1.var_.effectzhuihuoche2 = nil
				end
			end

			if 0.4 < arg_9_1.time_ and arg_9_1.time_ <= 0.4 + arg_12_0 then
				local var_12_15 = arg_9_1.var_.effectzhuihuoche3

				if not arg_9_1.var_.effectzhuihuoche3 then
					var_12_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_12_15.name = "zhuihuoche3"
					arg_9_1.var_.effectzhuihuoche3 = var_12_15
				else
					var_12_15.transform:SetParent(var_12_9001)
				end

				var_12_15.transform.localPosition = Vector3.New(1, 0, 0)
				var_12_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.4 < arg_9_1.time_ and arg_9_1.time_ <= 1.4 + arg_12_0 then
				if arg_9_1.var_.effectzhuihuoche3 then
					Object.Destroy(arg_9_1.var_.effectzhuihuoche3)

					arg_9_1.var_.effectzhuihuoche3 = nil
				end
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_18 = arg_9_1.var_.effectaishizhuiche1

				if not arg_9_1.var_.effectaishizhuiche1 then
					var_12_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), manager.ui.mainCamera.transform)
					var_12_18.name = "aishizhuiche1"
					arg_9_1.var_.effectaishizhuiche1 = var_12_18
				else
					var_12_18.transform:SetParent(var_12_9000)
				end

				var_12_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_12_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_gun02", "")
			end

			local var_12_21 = 0
			local var_12_22 = 1.85

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_21 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_23 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(423082002).content)

				arg_9_1.text_.text = var_12_23

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 74 <= 0 and var_12_22 or var_12_22 * (utf8.len(var_12_23) / 74)

				if (74 <= 0 and var_12_22 or var_12_22 * (utf8.len(var_12_23) / 74)) > 0 and var_12_22 < var_12_25 then
					arg_9_1.talkMaxDuration = var_12_25

					if var_12_25 + var_12_21 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_25 + var_12_21
					end
				end

				arg_9_1.text_.text = var_12_23
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_26 = math.max(var_12_22, arg_9_1.talkMaxDuration)

			if var_12_21 <= arg_9_1.time_ and arg_9_1.time_ < var_12_21 + var_12_26 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_21) / var_12_26

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_21 + var_12_26 and arg_9_1.time_ < var_12_21 + var_12_26 + arg_12_0 then
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
	Play423082003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 423082003
		arg_13_1.duration_ = 4.3

		local var_13_0 = {
			zh = 3.966,
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
				arg_13_0:Play423082004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1083"]) and arg_13_1.var_.actorSpriteComps1083 == nil then
				arg_13_1.var_.actorSpriteComps1083 = arg_13_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_0 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1083"]) then
				if arg_13_1.var_.actorSpriteComps1083 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1083"]) and arg_13_1.var_.actorSpriteComps1083 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_16_3 then
						iter_16_3.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_13_1.var_.actorSpriteComps1083 = nil
			end

			local var_16_2 = arg_13_1.actors_["1083"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1083 = var_16_2.localPosition
				var_16_2.localScale = Vector3.New(1, 1, 1)

				arg_13_1:CheckSpriteTmpPos("1083", 3)

				for iter_16_4 = 0, var_16_2.childCount - 1 do
					local var_16_3 = var_16_2:GetChild(iter_16_4)

					if var_16_3.name == "split_3" or not string.find(var_16_3.name, "split") then
						var_16_3.gameObject:SetActive(true)
					else
						var_16_3.gameObject:SetActive(false)
					end
				end
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_2.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_13_1.time_ - 0) / var_16_4)
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_2.localPosition = Vector3.New(-50, -345, -345)
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				local var_16_5 = arg_13_1.actors_["1083"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_5 then
					arg_13_1.var_.alphaOldValue1083 = var_16_5.alpha
					arg_13_1.var_.characterEffect1083 = var_16_5
				end

				arg_13_1.var_.alphaOldValue1083 = 0
			end

			local var_16_6 = 0.6

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 then
				if arg_13_1.var_.characterEffect1083 then
					arg_13_1.var_.characterEffect1083.alpha = Mathf.Lerp(arg_13_1.var_.alphaOldValue1083, 1, (arg_13_1.time_ - 0) / var_16_6)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and arg_13_1.var_.characterEffect1083 then
				arg_13_1.var_.characterEffect1083.alpha = 1
			end

			if arg_13_1.frameCnt_ <= 1 then
				arg_13_1.dialog_:SetActive(false)
			end

			local var_16_7 = 0.4
			local var_16_8 = 0.475

			if 0.4 < arg_13_1.time_ and arg_13_1.time_ <= var_16_7 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0

				arg_13_1.dialog_:SetActive(true)

				arg_13_1.dialogCg_.alpha = 0

				local var_16_9 = LeanTween.value(arg_13_1.dialog_, 0, 1, 0.3)

				var_16_9:setOnUpdate(LuaHelper.FloatAction(function(arg_17_0)
					arg_13_1.dialogCg_.alpha = arg_17_0
				end))
				var_16_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_13_1.dialog_)
					var_16_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_13_1.duration_ = arg_13_1.duration_ + 0.3

				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(423082003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 19 <= 0 and var_16_8 or var_16_8 * (utf8.len(var_16_11) / 19)

				if (19 <= 0 and var_16_8 or var_16_8 * (utf8.len(var_16_11) / 19)) > 0 and var_16_8 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13
					var_16_7 = var_16_7 + 0.3

					if var_16_13 + var_16_7 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_7
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082003", "story_v_out_423082.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_423082", "423082003", "story_v_out_423082.awb") / 1000

					if var_16_14 + var_16_7 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_7
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_423082", "423082003", "story_v_out_423082.awb")

						arg_13_1:RecordAudio("423082003", var_16_15)
						arg_13_1:RecordAudio("423082003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_423082", "423082003", "story_v_out_423082.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_423082", "423082003", "story_v_out_423082.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = var_16_7 + 0.3
			local var_16_17 = math.max(var_16_8, arg_13_1.talkMaxDuration)

			if var_16_7 + 0.3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_16 + var_16_17 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_16) / var_16_17

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_16 + var_16_17 and arg_13_1.time_ < var_16_16 + var_16_17 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play423082004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 423082004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play423082005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["1083"]) and arg_19_1.var_.actorSpriteComps1083 == nil then
				arg_19_1.var_.actorSpriteComps1083 = arg_19_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_22_0 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 and not isNil(arg_19_1.actors_["1083"]) then
				if arg_19_1.var_.actorSpriteComps1083 then
					for iter_22_0, iter_22_1 in pairs(arg_19_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 and not isNil(arg_19_1.actors_["1083"]) and arg_19_1.var_.actorSpriteComps1083 then
				for iter_22_2, iter_22_3 in pairs(arg_19_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_22_3 then
						iter_22_3.color = arg_19_1.isInRecall_ and (arg_19_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_19_1.var_.actorSpriteComps1083 = nil
			end

			local var_22_2 = arg_19_1.actors_["1083"].transform

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.var_.moveOldPos1083 = var_22_2.localPosition
				var_22_2.localScale = Vector3.New(1, 1, 1)

				arg_19_1:CheckSpriteTmpPos("1083", 3)

				for iter_22_4 = 0, var_22_2.childCount - 1 do
					local var_22_3 = var_22_2:GetChild(iter_22_4)

					if var_22_3.name == "split_7" or not string.find(var_22_3.name, "split") then
						var_22_3.gameObject:SetActive(true)
					else
						var_22_3.gameObject:SetActive(false)
					end
				end
			end

			local var_22_4 = 0.001

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				var_22_2.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_19_1.time_ - 0) / var_22_4)
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				var_22_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_22_5 = 0
			local var_22_6 = 0.425

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_5 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, true)
				arg_19_1.iconController_:SetSelectedState("hero")

				arg_19_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_19_1.callingController_:SetSelectedState("normal")

				arg_19_1.keyicon_.color = Color.New(1, 1, 1)
				arg_19_1.icon_.color = Color.New(1, 1, 1)

				local var_22_7 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(423082004).content)

				arg_19_1.text_.text = var_22_7

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_9 = 17 <= 0 and var_22_6 or var_22_6 * (utf8.len(var_22_7) / 17)

				if (17 <= 0 and var_22_6 or var_22_6 * (utf8.len(var_22_7) / 17)) > 0 and var_22_6 < var_22_9 then
					arg_19_1.talkMaxDuration = var_22_9

					if var_22_9 + var_22_5 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_9 + var_22_5
					end
				end

				arg_19_1.text_.text = var_22_7
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_10 = math.max(var_22_6, arg_19_1.talkMaxDuration)

			if var_22_5 <= arg_19_1.time_ and arg_19_1.time_ < var_22_5 + var_22_10 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_5) / var_22_10

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_5 + var_22_10 and arg_19_1.time_ < var_22_5 + var_22_10 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
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

		arg_19_1:InitPlayNodeList()
	end,
	Play423082005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 423082005
		arg_23_1.duration_ = 5

		local var_23_0 = {
			zh = 3.4,
			ja = 5
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
				arg_23_0:Play423082006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["1083"]) and arg_23_1.var_.actorSpriteComps1083 == nil then
				arg_23_1.var_.actorSpriteComps1083 = arg_23_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_0 = 0.2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["1083"]) then
				if arg_23_1.var_.actorSpriteComps1083 then
					for iter_26_0, iter_26_1 in pairs(arg_23_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["1083"]) and arg_23_1.var_.actorSpriteComps1083 then
				for iter_26_2, iter_26_3 in pairs(arg_23_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_26_3 then
						iter_26_3.color = arg_23_1.isInRecall_ and (arg_23_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_23_1.var_.actorSpriteComps1083 = nil
			end

			local var_26_2 = arg_23_1.actors_["1083"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1083 = var_26_2.localPosition
				var_26_2.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("1083", 3)

				for iter_26_4 = 0, var_26_2.childCount - 1 do
					local var_26_3 = var_26_2:GetChild(iter_26_4)

					if var_26_3.name == "split_3" or not string.find(var_26_3.name, "split") then
						var_26_3.gameObject:SetActive(true)
					else
						var_26_3.gameObject:SetActive(false)
					end
				end
			end

			local var_26_4 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_4 then
				var_26_2.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_23_1.time_ - 0) / var_26_4)
			end

			if arg_23_1.time_ >= 0 + var_26_4 and arg_23_1.time_ < 0 + var_26_4 + arg_26_0 then
				var_26_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_26_5 = 0
			local var_26_6 = 0.425

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_5 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_7 = arg_23_1:GetWordFromCfg(423082005)
				local var_26_8 = arg_23_1:FormatText(var_26_7.content)

				arg_23_1.text_.text = var_26_8

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_10 = 17 <= 0 and var_26_6 or var_26_6 * (utf8.len(var_26_8) / 17)

				if (17 <= 0 and var_26_6 or var_26_6 * (utf8.len(var_26_8) / 17)) > 0 and var_26_6 < var_26_10 then
					arg_23_1.talkMaxDuration = var_26_10

					if var_26_10 + var_26_5 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_10 + var_26_5
					end
				end

				arg_23_1.text_.text = var_26_8
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082005", "story_v_out_423082.awb") ~= 0 then
					local var_26_11 = manager.audio:GetVoiceLength("story_v_out_423082", "423082005", "story_v_out_423082.awb") / 1000

					if var_26_11 + var_26_5 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_11 + var_26_5
					end

					if var_26_7.prefab_name ~= "" and arg_23_1.actors_[var_26_7.prefab_name] ~= nil then
						local var_26_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_7.prefab_name].transform, "story_v_out_423082", "423082005", "story_v_out_423082.awb")

						arg_23_1:RecordAudio("423082005", var_26_12)
						arg_23_1:RecordAudio("423082005", var_26_12)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_423082", "423082005", "story_v_out_423082.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_423082", "423082005", "story_v_out_423082.awb")
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
				actorName = "1083",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play423082006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 423082006
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play423082007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(arg_27_1.actors_["1083"]) and arg_27_1.var_.actorSpriteComps1083 == nil then
				arg_27_1.var_.actorSpriteComps1083 = arg_27_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_30_0 = 0.2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 and not isNil(arg_27_1.actors_["1083"]) then
				if arg_27_1.var_.actorSpriteComps1083 then
					for iter_30_0, iter_30_1 in pairs(arg_27_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 and not isNil(arg_27_1.actors_["1083"]) and arg_27_1.var_.actorSpriteComps1083 then
				for iter_30_2, iter_30_3 in pairs(arg_27_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_30_3 then
						iter_30_3.color = arg_27_1.isInRecall_ and (arg_27_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_27_1.var_.actorSpriteComps1083 = nil
			end

			local var_30_2 = 0
			local var_30_3 = 0.6

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_2 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, true)
				arg_27_1.iconController_:SetSelectedState("hero")

				arg_27_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_27_1.callingController_:SetSelectedState("normal")

				arg_27_1.keyicon_.color = Color.New(1, 1, 1)
				arg_27_1.icon_.color = Color.New(1, 1, 1)

				local var_30_4 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(423082006).content)

				arg_27_1.text_.text = var_30_4

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_6 = 24 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_4) / 24)

				if (24 <= 0 and var_30_3 or var_30_3 * (utf8.len(var_30_4) / 24)) > 0 and var_30_3 < var_30_6 then
					arg_27_1.talkMaxDuration = var_30_6

					if var_30_6 + var_30_2 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_6 + var_30_2
					end
				end

				arg_27_1.text_.text = var_30_4
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_7 = math.max(var_30_3, arg_27_1.talkMaxDuration)

			if var_30_2 <= arg_27_1.time_ and arg_27_1.time_ < var_30_2 + var_30_7 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_2) / var_30_7

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_2 + var_30_7 and arg_27_1.time_ < var_30_2 + var_30_7 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play423082007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 423082007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play423082008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_9000

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1083 = arg_31_1.actors_["1083"].transform.localPosition
				arg_31_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_31_1:CheckSpriteTmpPos("1083", 7)

				for iter_34_0 = 0, arg_31_1.actors_["1083"].transform.childCount - 1 do
					local var_34_0 = arg_31_1.actors_["1083"].transform:GetChild(iter_34_0)

					if var_34_0.name == "" or not string.find(var_34_0.name, "split") then
						var_34_0.gameObject:SetActive(true)
					else
						var_34_0.gameObject:SetActive(false)
					end
				end
			end

			local var_34_1 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_1 then
				arg_31_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_31_1.time_ - 0) / var_34_1)
			end

			if arg_31_1.time_ >= 0 + var_34_1 and arg_31_1.time_ < 0 + var_34_1 + arg_34_0 then
				arg_31_1.actors_["1083"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				local var_34_2 = arg_31_1.var_.effectcheliangbaozhahongguang

				if not arg_31_1.var_.effectcheliangbaozhahongguang then
					var_34_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), manager.ui.mainCamera.transform)
					var_34_2.name = "cheliangbaozhahongguang"
					arg_31_1.var_.effectcheliangbaozhahongguang = var_34_2
				else
					var_34_2.transform:SetParent(var_34_9000)
				end

				var_34_2.transform.localPosition = Vector3.New(0, 0, -2)
				var_34_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_34_2.transform.localScale = Vector3.New(var_34_2.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_34_2.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_34_2.transform.localScale.z)
			end

			local var_34_4 = 0
			local var_34_5 = 1.9

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				arg_31_1.dialog_:SetActive(true)

				arg_31_1.dialogCg_.alpha = 0

				local var_34_6 = LeanTween.value(arg_31_1.dialog_, 0, 1, 0.3)

				var_34_6:setOnUpdate(LuaHelper.FloatAction(function(arg_35_0)
					arg_31_1.dialogCg_.alpha = arg_35_0
				end))
				var_34_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_31_1.dialog_)
					var_34_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_31_1.duration_ = arg_31_1.duration_ + 0.3

				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_7 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(423082007).content)

				arg_31_1.text_.text = var_34_7

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_9 = 76 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 76)

				if (76 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 76)) > 0 and var_34_5 < var_34_9 then
					arg_31_1.talkMaxDuration = var_34_9
					var_34_4 = var_34_4 + 0.3

					if var_34_9 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_9 + var_34_4
					end
				end

				arg_31_1.text_.text = var_34_7
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_10 = var_34_4 + 0.3
			local var_34_11 = math.max(var_34_5, arg_31_1.talkMaxDuration)

			if var_34_4 + 0.3 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_11 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_10) / var_34_11

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_10 + var_34_11 and arg_31_1.time_ < var_34_10 + var_34_11 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
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

		arg_31_1:InitPlayNodeList()
	end,
	Play423082008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 423082008
		arg_37_1.duration_ = 6.03

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play423082009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_9000

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				local var_40_1 = Color.New(0.9716981, 0.4364897, 0)

				var_40_1.a = Mathf.Lerp(0, 1, (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.mask_.color = var_40_1
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				local var_40_2 = Color.New(0.9716981, 0.4364897, 0)

				var_40_2.a = 1
				arg_37_1.mask_.color = var_40_2
			end

			local var_40_3 = 0.2

			if 0.2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_4 = 1

			if var_40_3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_3 + var_40_4 then
				local var_40_5 = Color.New(0.9716981, 0.4364897, 0)

				var_40_5.a = Mathf.Lerp(1, 0, (arg_37_1.time_ - var_40_3) / var_40_4)
				arg_37_1.mask_.color = var_40_5
			end

			if arg_37_1.time_ >= var_40_3 + var_40_4 and arg_37_1.time_ < var_40_3 + var_40_4 + arg_40_0 then
				local var_40_6 = Color.New(0.9716981, 0.4364897, 0)

				arg_37_1.mask_.enabled = false
				var_40_6.a = 0
				arg_37_1.mask_.color = var_40_6
			end

			if 0.2 < arg_37_1.time_ and arg_37_1.time_ <= 0.2 + arg_40_0 then
				local var_40_7 = arg_37_1.var_.effectqichezhale1

				if not arg_37_1.var_.effectqichezhale1 then
					var_40_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boom"), manager.ui.mainCamera.transform)
					var_40_7.name = "qichezhale1"
					arg_37_1.var_.effectqichezhale1 = var_40_7
				else
					var_40_7.transform:SetParent(var_40_9000)
				end

				var_40_7.transform.localPosition = Vector3.New(0, 0, 5)
				var_40_7.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_40_9 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_40_10 = var_40_7.transform:GetComponentsInChildren(typeof(Transform), true)

				for iter_40_0, iter_40_1 in ipairs((var_40_10:ToTable())) do
					iter_40_1.transform.localScale = Vector3.New(iter_40_1.transform.localScale.x / var_40_9 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * var_40_10 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_40_1.transform.localScale.y / var_40_9, iter_40_1.transform.localScale.z)
				end
			end

			if 2.7 < arg_37_1.time_ and arg_37_1.time_ <= 2.7 + arg_40_0 then
				if arg_37_1.var_.effectqichezhale1 then
					Object.Destroy(arg_37_1.var_.effectqichezhale1)

					arg_37_1.var_.effectqichezhale1 = nil
				end
			end

			if 0.2 < arg_37_1.time_ and arg_37_1.time_ <= 0.2 + arg_40_0 then
				if arg_37_1.var_.effectaishizhuiche1 then
					Object.Destroy(arg_37_1.var_.effectaishizhuiche1)

					arg_37_1.var_.effectaishizhuiche1 = nil
				end
			end

			local var_40_14 = manager.ui.mainCamera.transform

			if 0.2 < arg_37_1.time_ and arg_37_1.time_ <= 0.2 + arg_40_0 then
				arg_37_1.var_.shakeOldPos = var_40_14.localPosition
			end

			local var_40_15 = 1.5

			if 0.2 <= arg_37_1.time_ and arg_37_1.time_ < 0.2 + var_40_15 then
				local var_40_16, var_40_17 = math.modf((arg_37_1.time_ - 0.2) / 0.066)

				var_40_14.localPosition = Vector3.New(var_40_17 * 0.13, var_40_17 * 0.13, var_40_17 * 0.13) + arg_37_1.var_.shakeOldPos
			end

			if arg_37_1.time_ >= 0.2 + var_40_15 and arg_37_1.time_ < 0.2 + var_40_15 + arg_40_0 then
				var_40_14.localPosition = arg_37_1.var_.shakeOldPos
			end

			if 0.2 < arg_37_1.time_ and arg_37_1.time_ <= 0.2 + arg_40_0 then
				arg_37_1:AudioAction("play", "effect", "se_story_144", "se_story_144_smash", "")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				if arg_37_1.var_.effectcheliangbaozhahongguang then
					Object.Destroy(arg_37_1.var_.effectcheliangbaozhahongguang)

					arg_37_1.var_.effectcheliangbaozhahongguang = nil
				end
			end

			if 0.3 < arg_37_1.time_ and arg_37_1.time_ <= 0.3 + arg_40_0 then
				if arg_37_1.var_.effectaishizhuiche1 then
					Object.Destroy(arg_37_1.var_.effectaishizhuiche1)

					arg_37_1.var_.effectaishizhuiche1 = nil
				end
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_21 = 1.03333333333333
			local var_40_22 = 1.9

			if 1.03333333333333 < arg_37_1.time_ and arg_37_1.time_ <= var_40_21 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_23 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_23:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_24 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(423082008).content)

				arg_37_1.text_.text = var_40_24

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_26 = 76 <= 0 and var_40_22 or var_40_22 * (utf8.len(var_40_24) / 76)

				if (76 <= 0 and var_40_22 or var_40_22 * (utf8.len(var_40_24) / 76)) > 0 and var_40_22 < var_40_26 then
					arg_37_1.talkMaxDuration = var_40_26
					var_40_21 = var_40_21 + 0.3

					if var_40_26 + var_40_21 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_26 + var_40_21
					end
				end

				arg_37_1.text_.text = var_40_24
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_27 = var_40_21 + 0.3
			local var_40_28 = math.max(var_40_22, arg_37_1.talkMaxDuration)

			if var_40_21 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_27 + var_40_28 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_27) / var_40_28

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_27 + var_40_28 and arg_37_1.time_ < var_40_27 + var_40_28 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play423082009 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 423082009
		arg_43_1.duration_ = 4.9

		local var_43_0 = {
			zh = 3.666,
			ja = 4.9
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
				arg_43_0:Play423082010(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1083"]) and arg_43_1.var_.actorSpriteComps1083 == nil then
				arg_43_1.var_.actorSpriteComps1083 = arg_43_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_46_0 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1083"]) then
				if arg_43_1.var_.actorSpriteComps1083 then
					for iter_46_0, iter_46_1 in pairs(arg_43_1.var_.actorSpriteComps1083:ToTable()) do
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

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1083"]) and arg_43_1.var_.actorSpriteComps1083 then
				for iter_46_2, iter_46_3 in pairs(arg_43_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_46_3 then
						iter_46_3.color = arg_43_1.isInRecall_ and (arg_43_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_43_1.var_.actorSpriteComps1083 = nil
			end

			local var_46_2 = arg_43_1.actors_["1083"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1083 = var_46_2.localPosition
				var_46_2.localScale = Vector3.New(1, 1, 1)

				arg_43_1:CheckSpriteTmpPos("1083", 3)

				for iter_46_4 = 0, var_46_2.childCount - 1 do
					local var_46_3 = var_46_2:GetChild(iter_46_4)

					if var_46_3.name == "split_7" or not string.find(var_46_3.name, "split") then
						var_46_3.gameObject:SetActive(true)
					else
						var_46_3.gameObject:SetActive(false)
					end
				end
			end

			local var_46_4 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				var_46_2.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_43_1.time_ - 0) / var_46_4)
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				var_46_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_46_5 = 0
			local var_46_6 = 0.375

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_5 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_7 = arg_43_1:GetWordFromCfg(423082009)
				local var_46_8 = arg_43_1:FormatText(var_46_7.content)

				arg_43_1.text_.text = var_46_8

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_10 = 15 <= 0 and var_46_6 or var_46_6 * (utf8.len(var_46_8) / 15)

				if (15 <= 0 and var_46_6 or var_46_6 * (utf8.len(var_46_8) / 15)) > 0 and var_46_6 < var_46_10 then
					arg_43_1.talkMaxDuration = var_46_10

					if var_46_10 + var_46_5 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_5
					end
				end

				arg_43_1.text_.text = var_46_8
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082009", "story_v_out_423082.awb") ~= 0 then
					local var_46_11 = manager.audio:GetVoiceLength("story_v_out_423082", "423082009", "story_v_out_423082.awb") / 1000

					if var_46_11 + var_46_5 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_11 + var_46_5
					end

					if var_46_7.prefab_name ~= "" and arg_43_1.actors_[var_46_7.prefab_name] ~= nil then
						local var_46_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_7.prefab_name].transform, "story_v_out_423082", "423082009", "story_v_out_423082.awb")

						arg_43_1:RecordAudio("423082009", var_46_12)
						arg_43_1:RecordAudio("423082009", var_46_12)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_423082", "423082009", "story_v_out_423082.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_423082", "423082009", "story_v_out_423082.awb")
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
				actorName = "1083",
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
	Play423082010 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 423082010
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play423082011(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1083"]) and arg_47_1.var_.actorSpriteComps1083 == nil then
				arg_47_1.var_.actorSpriteComps1083 = arg_47_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_50_0 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1083"]) then
				if arg_47_1.var_.actorSpriteComps1083 then
					for iter_50_0, iter_50_1 in pairs(arg_47_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_50_1 then
							if arg_47_1.isInRecall_ then
								iter_50_1.color = Color.New(Mathf.Lerp(iter_50_1.color.r, arg_47_1.hightColor2.r, (arg_47_1.time_ - 0) / var_50_0), Mathf.Lerp(iter_50_1.color.g, arg_47_1.hightColor2.g, (arg_47_1.time_ - 0) / var_50_0), (Mathf.Lerp(iter_50_1.color.b, arg_47_1.hightColor2.b, (arg_47_1.time_ - 0) / var_50_0)))
							else
								local var_50_1 = Mathf.Lerp(iter_50_1.color.r, 0.5, (arg_47_1.time_ - 0) / var_50_0)

								iter_50_1.color = Color.New(var_50_1, var_50_1, var_50_1)
							end
						end
					end
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1083"]) and arg_47_1.var_.actorSpriteComps1083 then
				for iter_50_2, iter_50_3 in pairs(arg_47_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_50_3 then
						iter_50_3.color = arg_47_1.isInRecall_ and (arg_47_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_47_1.var_.actorSpriteComps1083 = nil
			end

			local var_50_2 = 0
			local var_50_3 = 0.325

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_2 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_4 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(423082010).content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_6 = 13 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_4) / 13)

				if (13 <= 0 and var_50_3 or var_50_3 * (utf8.len(var_50_4) / 13)) > 0 and var_50_3 < var_50_6 then
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

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play423082011 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 423082011
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play423082012(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1083 = arg_51_1.actors_["1083"].transform.localPosition
				arg_51_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_51_1:CheckSpriteTmpPos("1083", 7)

				for iter_54_0 = 0, arg_51_1.actors_["1083"].transform.childCount - 1 do
					local var_54_0 = arg_51_1.actors_["1083"].transform:GetChild(iter_54_0)

					if var_54_0.name == "" or not string.find(var_54_0.name, "split") then
						var_54_0.gameObject:SetActive(true)
					else
						var_54_0.gameObject:SetActive(false)
					end
				end
			end

			local var_54_1 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_1 then
				arg_51_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_51_1.time_ - 0) / var_54_1)
			end

			if arg_51_1.time_ >= 0 + var_54_1 and arg_51_1.time_ < 0 + var_54_1 + arg_54_0 then
				arg_51_1.actors_["1083"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.233333333333333 < arg_51_1.time_ and arg_51_1.time_ <= 0.233333333333333 + arg_54_0 then
				arg_51_1:AudioAction("play", "effect", "se_story_140", "se_story_140_footstep_run02", "")
			end

			local var_54_3 = 0
			local var_54_4 = 1.55

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_3 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_5 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(423082011).content)

				arg_51_1.text_.text = var_54_5

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_7 = 62 <= 0 and var_54_4 or var_54_4 * (utf8.len(var_54_5) / 62)

				if (62 <= 0 and var_54_4 or var_54_4 * (utf8.len(var_54_5) / 62)) > 0 and var_54_4 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_3 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_3
					end
				end

				arg_51_1.text_.text = var_54_5
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_8 = math.max(var_54_4, arg_51_1.talkMaxDuration)

			if var_54_3 <= arg_51_1.time_ and arg_51_1.time_ < var_54_3 + var_54_8 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_3) / var_54_8

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_3 + var_54_8 and arg_51_1.time_ < var_54_3 + var_54_8 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
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
	Play423082012 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 423082012
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play423082013(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.65

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(423082012).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 26 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 26)

				if (26 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 26)) > 0 and var_58_0 < var_58_3 then
					arg_55_1.talkMaxDuration = var_58_3

					if var_58_3 + 0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_3 + 0
					end
				end

				arg_55_1.text_.text = var_58_1
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_4 = math.max(var_58_0, arg_55_1.talkMaxDuration)

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - 0) / var_58_4

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play423082013 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 423082013
		arg_59_1.duration_ = 6.43

		local var_59_0 = {
			zh = 5.566,
			ja = 6.433
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
				arg_59_0:Play423082014(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_62_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_59_1.bgmTxt_.text ~= var_62_2 and arg_59_1.bgmTxt_.text ~= "" then
						if arg_59_1.bgmTxt2_.text ~= "" then
							arg_59_1.bgmTxt_.text = arg_59_1.bgmTxt2_.text
						end

						arg_59_1.bgmTxt2_.text = var_62_2

						arg_59_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_59_1.bgmTxt_.text = var_62_2
						arg_59_1.bgmTxt2_.text = var_62_2
					end

					if arg_59_1.bgmTimer then
						arg_59_1.bgmTimer:Stop()

						arg_59_1.bgmTimer = nil
					end

					if arg_59_1.settingData.show_music_name == 1 then
						arg_59_1.musicController:SetSelectedState("show")
						arg_59_1.musicAnimator_:Play("open", 0, 0)

						if arg_59_1.settingData.music_time ~= 0 then
							arg_59_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_59_1.settingData.music_time), function()
								if arg_59_1 == nil or isNil(arg_59_1.bgmTxt_) then
									return
								end

								arg_59_1.musicController:SetSelectedState("hide")
								arg_59_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_62_3 = 0
			local var_62_4 = 0.5

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_3 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_5 = arg_59_1:GetWordFromCfg(423082013)
				local var_62_6 = arg_59_1:FormatText(var_62_5.content)

				arg_59_1.text_.text = var_62_6

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_8 = 20 <= 0 and var_62_4 or var_62_4 * (utf8.len(var_62_6) / 20)

				if (20 <= 0 and var_62_4 or var_62_4 * (utf8.len(var_62_6) / 20)) > 0 and var_62_4 < var_62_8 then
					arg_59_1.talkMaxDuration = var_62_8

					if var_62_8 + var_62_3 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_3
					end
				end

				arg_59_1.text_.text = var_62_6
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082013", "story_v_out_423082.awb") ~= 0 then
					local var_62_9 = manager.audio:GetVoiceLength("story_v_out_423082", "423082013", "story_v_out_423082.awb") / 1000

					if var_62_9 + var_62_3 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_3
					end

					if var_62_5.prefab_name ~= "" and arg_59_1.actors_[var_62_5.prefab_name] ~= nil then
						local var_62_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_5.prefab_name].transform, "story_v_out_423082", "423082013", "story_v_out_423082.awb")

						arg_59_1:RecordAudio("423082013", var_62_10)
						arg_59_1:RecordAudio("423082013", var_62_10)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_423082", "423082013", "story_v_out_423082.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_423082", "423082013", "story_v_out_423082.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_11 = math.max(var_62_4, arg_59_1.talkMaxDuration)

			if var_62_3 <= arg_59_1.time_ and arg_59_1.time_ < var_62_3 + var_62_11 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_3) / var_62_11

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_3 + var_62_11 and arg_59_1.time_ < var_62_3 + var_62_11 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play423082014 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 423082014
		arg_64_1.duration_ = 5.37

		local var_64_0 = {
			zh = 4.166,
			ja = 5.366
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play423082015(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1083"]) and arg_64_1.var_.actorSpriteComps1083 == nil then
				arg_64_1.var_.actorSpriteComps1083 = arg_64_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_0 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1083"]) then
				if arg_64_1.var_.actorSpriteComps1083 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_67_1 then
							if arg_64_1.isInRecall_ then
								iter_67_1.color = Color.New(Mathf.Lerp(iter_67_1.color.r, arg_64_1.hightColor1.r, (arg_64_1.time_ - 0) / var_67_0), Mathf.Lerp(iter_67_1.color.g, arg_64_1.hightColor1.g, (arg_64_1.time_ - 0) / var_67_0), (Mathf.Lerp(iter_67_1.color.b, arg_64_1.hightColor1.b, (arg_64_1.time_ - 0) / var_67_0)))
							else
								local var_67_1 = Mathf.Lerp(iter_67_1.color.r, 1, (arg_64_1.time_ - 0) / var_67_0)

								iter_67_1.color = Color.New(var_67_1, var_67_1, var_67_1)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1083"]) and arg_64_1.var_.actorSpriteComps1083 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_67_3 then
						iter_67_3.color = arg_64_1.isInRecall_ and (arg_64_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_64_1.var_.actorSpriteComps1083 = nil
			end

			local var_67_2 = arg_64_1.actors_["1083"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1083 = var_67_2.localPosition
				var_67_2.localScale = Vector3.New(1, 1, 1)

				arg_64_1:CheckSpriteTmpPos("1083", 3)

				for iter_67_4 = 0, var_67_2.childCount - 1 do
					local var_67_3 = var_67_2:GetChild(iter_67_4)

					if var_67_3.name == "split_6" or not string.find(var_67_3.name, "split") then
						var_67_3.gameObject:SetActive(true)
					else
						var_67_3.gameObject:SetActive(false)
					end
				end
			end

			local var_67_4 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_4 then
				var_67_2.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_64_1.time_ - 0) / var_67_4)
			end

			if arg_64_1.time_ >= 0 + var_67_4 and arg_64_1.time_ < 0 + var_67_4 + arg_67_0 then
				var_67_2.localPosition = Vector3.New(-50, -345, -345)
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_67_7 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_64_1.bgmTxt_.text ~= var_67_7 and arg_64_1.bgmTxt_.text ~= "" then
						if arg_64_1.bgmTxt2_.text ~= "" then
							arg_64_1.bgmTxt_.text = arg_64_1.bgmTxt2_.text
						end

						arg_64_1.bgmTxt2_.text = var_67_7

						arg_64_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_64_1.bgmTxt_.text = var_67_7
						arg_64_1.bgmTxt2_.text = var_67_7
					end

					if arg_64_1.bgmTimer then
						arg_64_1.bgmTimer:Stop()

						arg_64_1.bgmTimer = nil
					end

					if arg_64_1.settingData.show_music_name == 1 then
						arg_64_1.musicController:SetSelectedState("show")
						arg_64_1.musicAnimator_:Play("open", 0, 0)

						if arg_64_1.settingData.music_time ~= 0 then
							arg_64_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_64_1.settingData.music_time), function()
								if arg_64_1 == nil or isNil(arg_64_1.bgmTxt_) then
									return
								end

								arg_64_1.musicController:SetSelectedState("hide")
								arg_64_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.500666666666667 < arg_64_1.time_ and arg_64_1.time_ <= 0.500666666666667 + arg_67_0 then
				arg_64_1:AudioAction("play", "music", "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street.awb")

				local var_67_10 = manager.audio:GetAudioName("bgm_activity_4_4_story_street", "bgm_activity_4_4_story_street")

				if "" ~= "" then
					if arg_64_1.bgmTxt_.text ~= var_67_10 and arg_64_1.bgmTxt_.text ~= "" then
						if arg_64_1.bgmTxt2_.text ~= "" then
							arg_64_1.bgmTxt_.text = arg_64_1.bgmTxt2_.text
						end

						arg_64_1.bgmTxt2_.text = var_67_10

						arg_64_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_64_1.bgmTxt_.text = var_67_10
						arg_64_1.bgmTxt2_.text = var_67_10
					end

					if arg_64_1.bgmTimer then
						arg_64_1.bgmTimer:Stop()

						arg_64_1.bgmTimer = nil
					end

					if arg_64_1.settingData.show_music_name == 1 then
						arg_64_1.musicController:SetSelectedState("show")
						arg_64_1.musicAnimator_:Play("open", 0, 0)

						if arg_64_1.settingData.music_time ~= 0 then
							arg_64_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_64_1.settingData.music_time), function()
								if arg_64_1 == nil or isNil(arg_64_1.bgmTxt_) then
									return
								end

								arg_64_1.musicController:SetSelectedState("hide")
								arg_64_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_67_11 = 0
			local var_67_12 = 0.5

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_13 = arg_64_1:GetWordFromCfg(423082014)
				local var_67_14 = arg_64_1:FormatText(var_67_13.content)

				arg_64_1.text_.text = var_67_14

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_16 = 20 <= 0 and var_67_12 or var_67_12 * (utf8.len(var_67_14) / 20)

				if (20 <= 0 and var_67_12 or var_67_12 * (utf8.len(var_67_14) / 20)) > 0 and var_67_12 < var_67_16 then
					arg_64_1.talkMaxDuration = var_67_16

					if var_67_16 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_16 + var_67_11
					end
				end

				arg_64_1.text_.text = var_67_14
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082014", "story_v_out_423082.awb") ~= 0 then
					local var_67_17 = manager.audio:GetVoiceLength("story_v_out_423082", "423082014", "story_v_out_423082.awb") / 1000

					if var_67_17 + var_67_11 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_17 + var_67_11
					end

					if var_67_13.prefab_name ~= "" and arg_64_1.actors_[var_67_13.prefab_name] ~= nil then
						local var_67_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_13.prefab_name].transform, "story_v_out_423082", "423082014", "story_v_out_423082.awb")

						arg_64_1:RecordAudio("423082014", var_67_18)
						arg_64_1:RecordAudio("423082014", var_67_18)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_423082", "423082014", "story_v_out_423082.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_423082", "423082014", "story_v_out_423082.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_19 = math.max(var_67_12, arg_64_1.talkMaxDuration)

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_19 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_11) / var_67_19

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_11 + var_67_19 and arg_64_1.time_ < var_67_11 + var_67_19 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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

		arg_64_1:InitPlayNodeList()
	end,
	Play423082015 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 423082015
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play423082016(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1083"]) and arg_70_1.var_.actorSpriteComps1083 == nil then
				arg_70_1.var_.actorSpriteComps1083 = arg_70_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_73_0 = 0.2

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1083"]) then
				if arg_70_1.var_.actorSpriteComps1083 then
					for iter_73_0, iter_73_1 in pairs(arg_70_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_73_1 then
							if arg_70_1.isInRecall_ then
								iter_73_1.color = Color.New(Mathf.Lerp(iter_73_1.color.r, arg_70_1.hightColor2.r, (arg_70_1.time_ - 0) / var_73_0), Mathf.Lerp(iter_73_1.color.g, arg_70_1.hightColor2.g, (arg_70_1.time_ - 0) / var_73_0), (Mathf.Lerp(iter_73_1.color.b, arg_70_1.hightColor2.b, (arg_70_1.time_ - 0) / var_73_0)))
							else
								local var_73_1 = Mathf.Lerp(iter_73_1.color.r, 0.5, (arg_70_1.time_ - 0) / var_73_0)

								iter_73_1.color = Color.New(var_73_1, var_73_1, var_73_1)
							end
						end
					end
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1083"]) and arg_70_1.var_.actorSpriteComps1083 then
				for iter_73_2, iter_73_3 in pairs(arg_70_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_73_3 then
						iter_73_3.color = arg_70_1.isInRecall_ and (arg_70_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_70_1.var_.actorSpriteComps1083 = nil
			end

			local var_73_2 = arg_70_1.actors_["1083"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1083 = var_73_2.localPosition
				var_73_2.localScale = Vector3.New(1, 1, 1)

				arg_70_1:CheckSpriteTmpPos("1083", 7)

				for iter_73_4 = 0, var_73_2.childCount - 1 do
					local var_73_3 = var_73_2:GetChild(iter_73_4)

					if var_73_3.name == "" or not string.find(var_73_3.name, "split") then
						var_73_3.gameObject:SetActive(true)
					else
						var_73_3.gameObject:SetActive(false)
					end
				end
			end

			local var_73_4 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 then
				var_73_2.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_70_1.time_ - 0) / var_73_4)
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 then
				var_73_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_73_5 = 0
			local var_73_6 = 1.7

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_7 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(423082015).content)

				arg_70_1.text_.text = var_73_7

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_9 = 68 <= 0 and var_73_6 or var_73_6 * (utf8.len(var_73_7) / 68)

				if (68 <= 0 and var_73_6 or var_73_6 * (utf8.len(var_73_7) / 68)) > 0 and var_73_6 < var_73_9 then
					arg_70_1.talkMaxDuration = var_73_9

					if var_73_9 + var_73_5 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_9 + var_73_5
					end
				end

				arg_70_1.text_.text = var_73_7
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_6, arg_70_1.talkMaxDuration)

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_5) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_5 + var_73_10 and arg_70_1.time_ < var_73_5 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
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

		arg_70_1:InitPlayNodeList()
	end,
	Play423082016 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 423082016
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play423082017(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.65

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_1 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(423082016).content)

				arg_74_1.text_.text = var_77_1

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_3 = 26 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 26)

				if (26 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 26)) > 0 and var_77_0 < var_77_3 then
					arg_74_1.talkMaxDuration = var_77_3

					if var_77_3 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_3 + 0
					end
				end

				arg_74_1.text_.text = var_77_1
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_4 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_4 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_4

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_4 and arg_74_1.time_ < 0 + var_77_4 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play423082017 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 423082017
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play423082018(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.75

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_1 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(423082017).content)

				arg_78_1.text_.text = var_81_1

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_3 = 30 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 30)

				if (30 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 30)) > 0 and var_81_0 < var_81_3 then
					arg_78_1.talkMaxDuration = var_81_3

					if var_81_3 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_3 + 0
					end
				end

				arg_78_1.text_.text = var_81_1
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_4 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_4

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play423082018 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 423082018
		arg_82_1.duration_ = 10.87

		local var_82_0 = {
			zh = 6.733,
			ja = 10.866
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play423082019(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_85_0 = 0.6

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 then
				local var_85_1, var_85_2 = math.modf((arg_82_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_85_2 * 0.13, var_85_2 * 0.13, var_85_2 * 0.13) + arg_82_1.var_.shakeOldPos
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 then
				manager.ui.mainCamera.transform.localPosition = arg_82_1.var_.shakeOldPos
			end

			local var_85_3 = 0

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_3 + arg_85_0 then
				arg_82_1.allBtn_.enabled = false
			end

			if arg_82_1.time_ >= var_85_3 + 0.6 and arg_82_1.time_ < var_85_3 + 0.6 + arg_85_0 then
				arg_82_1.allBtn_.enabled = true
			end

			local var_85_4 = 0
			local var_85_5 = 0.5

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0

				arg_82_1.dialog_:SetActive(true)

				arg_82_1.dialogCg_.alpha = 0

				local var_85_6 = LeanTween.value(arg_82_1.dialog_, 0, 1, 0.3)

				var_85_6:setOnUpdate(LuaHelper.FloatAction(function(arg_86_0)
					arg_82_1.dialogCg_.alpha = arg_86_0
				end))
				var_85_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_82_1.dialog_)
					var_85_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_82_1.duration_ = arg_82_1.duration_ + 0.3

				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_7 = arg_82_1:GetWordFromCfg(423082018)
				local var_85_8 = arg_82_1:FormatText(var_85_7.content)

				arg_82_1.text_.text = var_85_8

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_10 = 20 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_8) / 20)

				if (20 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_8) / 20)) > 0 and var_85_5 < var_85_10 then
					arg_82_1.talkMaxDuration = var_85_10
					var_85_4 = var_85_4 + 0.3

					if var_85_10 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_4
					end
				end

				arg_82_1.text_.text = var_85_8
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082018", "story_v_out_423082.awb") ~= 0 then
					local var_85_11 = manager.audio:GetVoiceLength("story_v_out_423082", "423082018", "story_v_out_423082.awb") / 1000

					if var_85_11 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_11 + var_85_4
					end

					if var_85_7.prefab_name ~= "" and arg_82_1.actors_[var_85_7.prefab_name] ~= nil then
						local var_85_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_7.prefab_name].transform, "story_v_out_423082", "423082018", "story_v_out_423082.awb")

						arg_82_1:RecordAudio("423082018", var_85_12)
						arg_82_1:RecordAudio("423082018", var_85_12)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_423082", "423082018", "story_v_out_423082.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_423082", "423082018", "story_v_out_423082.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_13 = var_85_4 + 0.3
			local var_85_14 = math.max(var_85_5, arg_82_1.talkMaxDuration)

			if var_85_4 + 0.3 <= arg_82_1.time_ and arg_82_1.time_ < var_85_13 + var_85_14 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_13) / var_85_14

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_13 + var_85_14 and arg_82_1.time_ < var_85_13 + var_85_14 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play423082019 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 423082019
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play423082020(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 1.625

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(423082019).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 65 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 65)

				if (65 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 65)) > 0 and var_91_0 < var_91_3 then
					arg_88_1.talkMaxDuration = var_91_3

					if var_91_3 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_3 + 0
					end
				end

				arg_88_1.text_.text = var_91_1
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_4 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_4

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play423082020 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 423082020
		arg_92_1.duration_ = 1.3

		local var_92_0 = {
			zh = 0.999999999999,
			ja = 1.3
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
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play423082021(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1083 = arg_92_1.actors_["1083"].transform.localPosition
				arg_92_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_92_1:CheckSpriteTmpPos("1083", 3)

				for iter_95_0 = 0, arg_92_1.actors_["1083"].transform.childCount - 1 do
					local var_95_0 = arg_92_1.actors_["1083"].transform:GetChild(iter_95_0)

					if var_95_0.name == "split_6" or not string.find(var_95_0.name, "split") then
						var_95_0.gameObject:SetActive(true)
					else
						var_95_0.gameObject:SetActive(false)
					end
				end
			end

			local var_95_1 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_1 then
				arg_92_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_92_1.time_ - 0) / var_95_1)
			end

			if arg_92_1.time_ >= 0 + var_95_1 and arg_92_1.time_ < 0 + var_95_1 + arg_95_0 then
				arg_92_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_95_2 = arg_92_1.actors_["1083"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.actorSpriteComps1083 == nil then
				arg_92_1.var_.actorSpriteComps1083 = var_95_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_95_3 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_3 and not isNil(var_95_2) then
				if arg_92_1.var_.actorSpriteComps1083 then
					for iter_95_1, iter_95_2 in pairs(arg_92_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_95_2 then
							if arg_92_1.isInRecall_ then
								iter_95_2.color = Color.New(Mathf.Lerp(iter_95_2.color.r, arg_92_1.hightColor1.r, (arg_92_1.time_ - 0) / var_95_3), Mathf.Lerp(iter_95_2.color.g, arg_92_1.hightColor1.g, (arg_92_1.time_ - 0) / var_95_3), (Mathf.Lerp(iter_95_2.color.b, arg_92_1.hightColor1.b, (arg_92_1.time_ - 0) / var_95_3)))
							else
								local var_95_4 = Mathf.Lerp(iter_95_2.color.r, 1, (arg_92_1.time_ - 0) / var_95_3)

								iter_95_2.color = Color.New(var_95_4, var_95_4, var_95_4)
							end
						end
					end
				end
			end

			if arg_92_1.time_ >= 0 + var_95_3 and arg_92_1.time_ < 0 + var_95_3 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.actorSpriteComps1083 then
				for iter_95_3, iter_95_4 in pairs(arg_92_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_95_4 then
						iter_95_4.color = arg_92_1.isInRecall_ and (arg_92_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_92_1.var_.actorSpriteComps1083 = nil
			end

			local var_95_5 = 0
			local var_95_6 = 0.05

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1341].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_7 = arg_92_1:GetWordFromCfg(423082020)
				local var_95_8 = arg_92_1:FormatText(var_95_7.content)

				arg_92_1.text_.text = var_95_8

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_10 = 2 <= 0 and var_95_6 or var_95_6 * (utf8.len(var_95_8) / 2)

				if (2 <= 0 and var_95_6 or var_95_6 * (utf8.len(var_95_8) / 2)) > 0 and var_95_6 < var_95_10 then
					arg_92_1.talkMaxDuration = var_95_10

					if var_95_10 + var_95_5 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_5
					end
				end

				arg_92_1.text_.text = var_95_8
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082020", "story_v_out_423082.awb") ~= 0 then
					local var_95_11 = manager.audio:GetVoiceLength("story_v_out_423082", "423082020", "story_v_out_423082.awb") / 1000

					if var_95_11 + var_95_5 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_11 + var_95_5
					end

					if var_95_7.prefab_name ~= "" and arg_92_1.actors_[var_95_7.prefab_name] ~= nil then
						local var_95_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_7.prefab_name].transform, "story_v_out_423082", "423082020", "story_v_out_423082.awb")

						arg_92_1:RecordAudio("423082020", var_95_12)
						arg_92_1:RecordAudio("423082020", var_95_12)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_423082", "423082020", "story_v_out_423082.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_423082", "423082020", "story_v_out_423082.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_13 = math.max(var_95_6, arg_92_1.talkMaxDuration)

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_13 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_5) / var_95_13

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_5 + var_95_13 and arg_92_1.time_ < var_95_5 + var_95_13 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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

		arg_92_1:InitPlayNodeList()
	end,
	Play423082021 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 423082021
		arg_96_1.duration_ = 4.67

		local var_96_0 = {
			zh = 4.666,
			ja = 3.8
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play423082022(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1083 = arg_96_1.actors_["1083"].transform.localPosition
				arg_96_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("1083", 3)

				for iter_99_0 = 0, arg_96_1.actors_["1083"].transform.childCount - 1 do
					local var_99_0 = arg_96_1.actors_["1083"].transform:GetChild(iter_99_0)

					if var_99_0.name == "split_6" or not string.find(var_99_0.name, "split") then
						var_99_0.gameObject:SetActive(true)
					else
						var_99_0.gameObject:SetActive(false)
					end
				end
			end

			local var_99_1 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_1 then
				arg_96_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_96_1.time_ - 0) / var_99_1)
			end

			if arg_96_1.time_ >= 0 + var_99_1 and arg_96_1.time_ < 0 + var_99_1 + arg_99_0 then
				arg_96_1.actors_["1083"].transform.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_99_2 = 0
			local var_99_3 = 0.425

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_4 = arg_96_1:GetWordFromCfg(423082021)
				local var_99_5 = arg_96_1:FormatText(var_99_4.content)

				arg_96_1.text_.text = var_99_5

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 17 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 17)

				if (17 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 17)) > 0 and var_99_3 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_5
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082021", "story_v_out_423082.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_423082", "423082021", "story_v_out_423082.awb") / 1000

					if var_99_8 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_2
					end

					if var_99_4.prefab_name ~= "" and arg_96_1.actors_[var_99_4.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_4.prefab_name].transform, "story_v_out_423082", "423082021", "story_v_out_423082.awb")

						arg_96_1:RecordAudio("423082021", var_99_9)
						arg_96_1:RecordAudio("423082021", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_423082", "423082021", "story_v_out_423082.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_423082", "423082021", "story_v_out_423082.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_3, arg_96_1.talkMaxDuration)

			if var_99_2 <= arg_96_1.time_ and arg_96_1.time_ < var_99_2 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_2) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_2 + var_99_10 and arg_96_1.time_ < var_99_2 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
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

		arg_96_1:InitPlayNodeList()
	end,
	Play423082022 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 423082022
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play423082023(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1083"]) and arg_100_1.var_.actorSpriteComps1083 == nil then
				arg_100_1.var_.actorSpriteComps1083 = arg_100_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_0 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1083"]) then
				if arg_100_1.var_.actorSpriteComps1083 then
					for iter_103_0, iter_103_1 in pairs(arg_100_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_103_1 then
							if arg_100_1.isInRecall_ then
								iter_103_1.color = Color.New(Mathf.Lerp(iter_103_1.color.r, arg_100_1.hightColor2.r, (arg_100_1.time_ - 0) / var_103_0), Mathf.Lerp(iter_103_1.color.g, arg_100_1.hightColor2.g, (arg_100_1.time_ - 0) / var_103_0), (Mathf.Lerp(iter_103_1.color.b, arg_100_1.hightColor2.b, (arg_100_1.time_ - 0) / var_103_0)))
							else
								local var_103_1 = Mathf.Lerp(iter_103_1.color.r, 0.5, (arg_100_1.time_ - 0) / var_103_0)

								iter_103_1.color = Color.New(var_103_1, var_103_1, var_103_1)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1083"]) and arg_100_1.var_.actorSpriteComps1083 then
				for iter_103_2, iter_103_3 in pairs(arg_100_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_103_3 then
						iter_103_3.color = arg_100_1.isInRecall_ and (arg_100_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_100_1.var_.actorSpriteComps1083 = nil
			end

			local var_103_2 = 0
			local var_103_3 = 0.675

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_4 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(423082022).content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_6 = 27 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_4) / 27)

				if (27 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_4) / 27)) > 0 and var_103_3 < var_103_6 then
					arg_100_1.talkMaxDuration = var_103_6

					if var_103_6 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_6 + var_103_2
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_7 = math.max(var_103_3, arg_100_1.talkMaxDuration)

			if var_103_2 <= arg_100_1.time_ and arg_100_1.time_ < var_103_2 + var_103_7 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_2) / var_103_7

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_2 + var_103_7 and arg_100_1.time_ < var_103_2 + var_103_7 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play423082023 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 423082023
		arg_104_1.duration_ = 8.5

		local var_104_0 = {
			zh = 6.5,
			ja = 8.5
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play423082024(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1083 = arg_104_1.actors_["1083"].transform.localPosition
				arg_104_1.actors_["1083"].transform.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1083", 7)

				for iter_107_0 = 0, arg_104_1.actors_["1083"].transform.childCount - 1 do
					local var_107_0 = arg_104_1.actors_["1083"].transform:GetChild(iter_107_0)

					if var_107_0.name == "split_6" or not string.find(var_107_0.name, "split") then
						var_107_0.gameObject:SetActive(true)
					else
						var_107_0.gameObject:SetActive(false)
					end
				end
			end

			local var_107_1 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_1 then
				arg_104_1.actors_["1083"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_104_1.time_ - 0) / var_107_1)
			end

			if arg_104_1.time_ >= 0 + var_107_1 and arg_104_1.time_ < 0 + var_107_1 + arg_107_0 then
				arg_104_1.actors_["1083"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_107_2 = 0
			local var_107_3 = 0.55

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_2 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_4 = arg_104_1:GetWordFromCfg(423082023)
				local var_107_5 = arg_104_1:FormatText(var_107_4.content)

				arg_104_1.text_.text = var_107_5

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_7 = 22 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 22)

				if (22 <= 0 and var_107_3 or var_107_3 * (utf8.len(var_107_5) / 22)) > 0 and var_107_3 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_2
					end
				end

				arg_104_1.text_.text = var_107_5
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082023", "story_v_out_423082.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_423082", "423082023", "story_v_out_423082.awb") / 1000

					if var_107_8 + var_107_2 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_2
					end

					if var_107_4.prefab_name ~= "" and arg_104_1.actors_[var_107_4.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_4.prefab_name].transform, "story_v_out_423082", "423082023", "story_v_out_423082.awb")

						arg_104_1:RecordAudio("423082023", var_107_9)
						arg_104_1:RecordAudio("423082023", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_423082", "423082023", "story_v_out_423082.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_423082", "423082023", "story_v_out_423082.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_3, arg_104_1.talkMaxDuration)

			if var_107_2 <= arg_104_1.time_ and arg_104_1.time_ < var_107_2 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_2) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_2 + var_107_10 and arg_104_1.time_ < var_107_2 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
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

		arg_104_1:InitPlayNodeList()
	end,
	Play423082024 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 423082024
		arg_108_1.duration_ = 12.5

		local var_108_0 = {
			zh = 6.1,
			ja = 12.5
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play423082025(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.65

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_1 = arg_108_1:GetWordFromCfg(423082024)
				local var_111_2 = arg_108_1:FormatText(var_111_1.content)

				arg_108_1.text_.text = var_111_2

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_4 = 26 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 26)

				if (26 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_2) / 26)) > 0 and var_111_0 < var_111_4 then
					arg_108_1.talkMaxDuration = var_111_4

					if var_111_4 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_4 + 0
					end
				end

				arg_108_1.text_.text = var_111_2
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082024", "story_v_out_423082.awb") ~= 0 then
					local var_111_5 = manager.audio:GetVoiceLength("story_v_out_423082", "423082024", "story_v_out_423082.awb") / 1000

					if var_111_5 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + 0
					end

					if var_111_1.prefab_name ~= "" and arg_108_1.actors_[var_111_1.prefab_name] ~= nil then
						local var_111_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_1.prefab_name].transform, "story_v_out_423082", "423082024", "story_v_out_423082.awb")

						arg_108_1:RecordAudio("423082024", var_111_6)
						arg_108_1:RecordAudio("423082024", var_111_6)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_423082", "423082024", "story_v_out_423082.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_423082", "423082024", "story_v_out_423082.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_7 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_7

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_7 and arg_108_1.time_ < 0 + var_111_7 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play423082025 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 423082025
		arg_112_1.duration_ = 19.23

		local var_112_0 = {
			zh = 9.666,
			ja = 19.233
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play423082026(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 1.2

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_1 = arg_112_1:GetWordFromCfg(423082025)
				local var_115_2 = arg_112_1:FormatText(var_115_1.content)

				arg_112_1.text_.text = var_115_2

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 48 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 48)

				if (48 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 48)) > 0 and var_115_0 < var_115_4 then
					arg_112_1.talkMaxDuration = var_115_4

					if var_115_4 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_4 + 0
					end
				end

				arg_112_1.text_.text = var_115_2
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082025", "story_v_out_423082.awb") ~= 0 then
					local var_115_5 = manager.audio:GetVoiceLength("story_v_out_423082", "423082025", "story_v_out_423082.awb") / 1000

					if var_115_5 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + 0
					end

					if var_115_1.prefab_name ~= "" and arg_112_1.actors_[var_115_1.prefab_name] ~= nil then
						local var_115_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_1.prefab_name].transform, "story_v_out_423082", "423082025", "story_v_out_423082.awb")

						arg_112_1:RecordAudio("423082025", var_115_6)
						arg_112_1:RecordAudio("423082025", var_115_6)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_423082", "423082025", "story_v_out_423082.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_423082", "423082025", "story_v_out_423082.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play423082026 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 423082026
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play423082027(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0.775

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_1 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(423082026).content)

				arg_116_1.text_.text = var_119_1

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_3 = 31 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 31)

				if (31 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 31)) > 0 and var_119_0 < var_119_3 then
					arg_116_1.talkMaxDuration = var_119_3

					if var_119_3 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_3 + 0
					end
				end

				arg_116_1.text_.text = var_119_1
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_4 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_4

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play423082027 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 423082027
		arg_120_1.duration_ = 11.6

		local var_120_0 = {
			zh = 5.2,
			ja = 11.6
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
				arg_120_0:Play423082028(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.55

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_1 = arg_120_1:GetWordFromCfg(423082027)
				local var_123_2 = arg_120_1:FormatText(var_123_1.content)

				arg_120_1.text_.text = var_123_2

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 22 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 22)

				if (22 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 22)) > 0 and var_123_0 < var_123_4 then
					arg_120_1.talkMaxDuration = var_123_4

					if var_123_4 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_4 + 0
					end
				end

				arg_120_1.text_.text = var_123_2
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082027", "story_v_out_423082.awb") ~= 0 then
					local var_123_5 = manager.audio:GetVoiceLength("story_v_out_423082", "423082027", "story_v_out_423082.awb") / 1000

					if var_123_5 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + 0
					end

					if var_123_1.prefab_name ~= "" and arg_120_1.actors_[var_123_1.prefab_name] ~= nil then
						local var_123_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_1.prefab_name].transform, "story_v_out_423082", "423082027", "story_v_out_423082.awb")

						arg_120_1:RecordAudio("423082027", var_123_6)
						arg_120_1:RecordAudio("423082027", var_123_6)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_423082", "423082027", "story_v_out_423082.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_423082", "423082027", "story_v_out_423082.awb")
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
	Play423082028 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 423082028
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play423082029(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 1.875

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_1 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(423082028).content)

				arg_124_1.text_.text = var_127_1

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_3 = 75 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 75)

				if (75 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 75)) > 0 and var_127_0 < var_127_3 then
					arg_124_1.talkMaxDuration = var_127_3

					if var_127_3 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_3 + 0
					end
				end

				arg_124_1.text_.text = var_127_1
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_4 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_4

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play423082029 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 423082029
		arg_128_1.duration_ = 6.43

		local var_128_0 = {
			zh = 4.8,
			ja = 6.433
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
				arg_128_0:Play423082030(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1083"]) and arg_128_1.var_.actorSpriteComps1083 == nil then
				arg_128_1.var_.actorSpriteComps1083 = arg_128_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_0 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1083"]) then
				if arg_128_1.var_.actorSpriteComps1083 then
					for iter_131_0, iter_131_1 in pairs(arg_128_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_131_1 then
							if arg_128_1.isInRecall_ then
								iter_131_1.color = Color.New(Mathf.Lerp(iter_131_1.color.r, arg_128_1.hightColor1.r, (arg_128_1.time_ - 0) / var_131_0), Mathf.Lerp(iter_131_1.color.g, arg_128_1.hightColor1.g, (arg_128_1.time_ - 0) / var_131_0), (Mathf.Lerp(iter_131_1.color.b, arg_128_1.hightColor1.b, (arg_128_1.time_ - 0) / var_131_0)))
							else
								local var_131_1 = Mathf.Lerp(iter_131_1.color.r, 1, (arg_128_1.time_ - 0) / var_131_0)

								iter_131_1.color = Color.New(var_131_1, var_131_1, var_131_1)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1083"]) and arg_128_1.var_.actorSpriteComps1083 then
				for iter_131_2, iter_131_3 in pairs(arg_128_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_131_3 then
						iter_131_3.color = arg_128_1.isInRecall_ and (arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_128_1.var_.actorSpriteComps1083 = nil
			end

			local var_131_2 = arg_128_1.actors_["1083"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1083 = var_131_2.localPosition
				var_131_2.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("1083", 3)

				for iter_131_4 = 0, var_131_2.childCount - 1 do
					local var_131_3 = var_131_2:GetChild(iter_131_4)

					if var_131_3.name == "" or not string.find(var_131_3.name, "split") then
						var_131_3.gameObject:SetActive(true)
					else
						var_131_3.gameObject:SetActive(false)
					end
				end
			end

			local var_131_4 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 then
				var_131_2.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_128_1.time_ - 0) / var_131_4)
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 then
				var_131_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_131_5 = 0
			local var_131_6 = 0.525

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_5 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_7 = arg_128_1:GetWordFromCfg(423082029)
				local var_131_8 = arg_128_1:FormatText(var_131_7.content)

				arg_128_1.text_.text = var_131_8

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_10 = 21 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 21)

				if (21 <= 0 and var_131_6 or var_131_6 * (utf8.len(var_131_8) / 21)) > 0 and var_131_6 < var_131_10 then
					arg_128_1.talkMaxDuration = var_131_10

					if var_131_10 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_5
					end
				end

				arg_128_1.text_.text = var_131_8
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082029", "story_v_out_423082.awb") ~= 0 then
					local var_131_11 = manager.audio:GetVoiceLength("story_v_out_423082", "423082029", "story_v_out_423082.awb") / 1000

					if var_131_11 + var_131_5 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_5
					end

					if var_131_7.prefab_name ~= "" and arg_128_1.actors_[var_131_7.prefab_name] ~= nil then
						local var_131_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_7.prefab_name].transform, "story_v_out_423082", "423082029", "story_v_out_423082.awb")

						arg_128_1:RecordAudio("423082029", var_131_12)
						arg_128_1:RecordAudio("423082029", var_131_12)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_423082", "423082029", "story_v_out_423082.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_423082", "423082029", "story_v_out_423082.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_13 = math.max(var_131_6, arg_128_1.talkMaxDuration)

			if var_131_5 <= arg_128_1.time_ and arg_128_1.time_ < var_131_5 + var_131_13 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_5) / var_131_13

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_5 + var_131_13 and arg_128_1.time_ < var_131_5 + var_131_13 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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

		arg_128_1:InitPlayNodeList()
	end,
	Play423082030 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 423082030
		arg_132_1.duration_ = 10.93

		local var_132_0 = {
			zh = 7.766,
			ja = 10.933
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play423082031(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1083"]) and arg_132_1.var_.actorSpriteComps1083 == nil then
				arg_132_1.var_.actorSpriteComps1083 = arg_132_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_135_0 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1083"]) then
				if arg_132_1.var_.actorSpriteComps1083 then
					for iter_135_0, iter_135_1 in pairs(arg_132_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_135_1 then
							if arg_132_1.isInRecall_ then
								iter_135_1.color = Color.New(Mathf.Lerp(iter_135_1.color.r, arg_132_1.hightColor2.r, (arg_132_1.time_ - 0) / var_135_0), Mathf.Lerp(iter_135_1.color.g, arg_132_1.hightColor2.g, (arg_132_1.time_ - 0) / var_135_0), (Mathf.Lerp(iter_135_1.color.b, arg_132_1.hightColor2.b, (arg_132_1.time_ - 0) / var_135_0)))
							else
								local var_135_1 = Mathf.Lerp(iter_135_1.color.r, 0.5, (arg_132_1.time_ - 0) / var_135_0)

								iter_135_1.color = Color.New(var_135_1, var_135_1, var_135_1)
							end
						end
					end
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1083"]) and arg_132_1.var_.actorSpriteComps1083 then
				for iter_135_2, iter_135_3 in pairs(arg_132_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_135_3 then
						iter_135_3.color = arg_132_1.isInRecall_ and (arg_132_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_132_1.var_.actorSpriteComps1083 = nil
			end

			local var_135_2 = 0
			local var_135_3 = 0.775

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_2 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_4 = arg_132_1:GetWordFromCfg(423082030)
				local var_135_5 = arg_132_1:FormatText(var_135_4.content)

				arg_132_1.text_.text = var_135_5

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_7 = 31 <= 0 and var_135_3 or var_135_3 * (utf8.len(var_135_5) / 31)

				if (31 <= 0 and var_135_3 or var_135_3 * (utf8.len(var_135_5) / 31)) > 0 and var_135_3 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_2 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_2
					end
				end

				arg_132_1.text_.text = var_135_5
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082030", "story_v_out_423082.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_423082", "423082030", "story_v_out_423082.awb") / 1000

					if var_135_8 + var_135_2 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_2
					end

					if var_135_4.prefab_name ~= "" and arg_132_1.actors_[var_135_4.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_4.prefab_name].transform, "story_v_out_423082", "423082030", "story_v_out_423082.awb")

						arg_132_1:RecordAudio("423082030", var_135_9)
						arg_132_1:RecordAudio("423082030", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_423082", "423082030", "story_v_out_423082.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_423082", "423082030", "story_v_out_423082.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_3, arg_132_1.talkMaxDuration)

			if var_135_2 <= arg_132_1.time_ and arg_132_1.time_ < var_135_2 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_2) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_2 + var_135_10 and arg_132_1.time_ < var_135_2 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play423082031 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 423082031
		arg_136_1.duration_ = 5.77

		local var_136_0 = {
			zh = 4.833,
			ja = 5.766
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
				arg_136_0:Play423082032(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1083"]) and arg_136_1.var_.actorSpriteComps1083 == nil then
				arg_136_1.var_.actorSpriteComps1083 = arg_136_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_139_0 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1083"]) then
				if arg_136_1.var_.actorSpriteComps1083 then
					for iter_139_0, iter_139_1 in pairs(arg_136_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_139_1 then
							if arg_136_1.isInRecall_ then
								iter_139_1.color = Color.New(Mathf.Lerp(iter_139_1.color.r, arg_136_1.hightColor1.r, (arg_136_1.time_ - 0) / var_139_0), Mathf.Lerp(iter_139_1.color.g, arg_136_1.hightColor1.g, (arg_136_1.time_ - 0) / var_139_0), (Mathf.Lerp(iter_139_1.color.b, arg_136_1.hightColor1.b, (arg_136_1.time_ - 0) / var_139_0)))
							else
								local var_139_1 = Mathf.Lerp(iter_139_1.color.r, 1, (arg_136_1.time_ - 0) / var_139_0)

								iter_139_1.color = Color.New(var_139_1, var_139_1, var_139_1)
							end
						end
					end
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1083"]) and arg_136_1.var_.actorSpriteComps1083 then
				for iter_139_2, iter_139_3 in pairs(arg_136_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_139_3 then
						iter_139_3.color = arg_136_1.isInRecall_ and (arg_136_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_136_1.var_.actorSpriteComps1083 = nil
			end

			local var_139_2 = arg_136_1.actors_["1083"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1083 = var_139_2.localPosition
				var_139_2.localScale = Vector3.New(1, 1, 1)

				arg_136_1:CheckSpriteTmpPos("1083", 3)

				for iter_139_4 = 0, var_139_2.childCount - 1 do
					local var_139_3 = var_139_2:GetChild(iter_139_4)

					if var_139_3.name == "split_2" or not string.find(var_139_3.name, "split") then
						var_139_3.gameObject:SetActive(true)
					else
						var_139_3.gameObject:SetActive(false)
					end
				end
			end

			local var_139_4 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_4 then
				var_139_2.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_136_1.time_ - 0) / var_139_4)
			end

			if arg_136_1.time_ >= 0 + var_139_4 and arg_136_1.time_ < 0 + var_139_4 + arg_139_0 then
				var_139_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_139_5 = 0
			local var_139_6 = 0.475

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_7 = arg_136_1:GetWordFromCfg(423082031)
				local var_139_8 = arg_136_1:FormatText(var_139_7.content)

				arg_136_1.text_.text = var_139_8

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_10 = 19 <= 0 and var_139_6 or var_139_6 * (utf8.len(var_139_8) / 19)

				if (19 <= 0 and var_139_6 or var_139_6 * (utf8.len(var_139_8) / 19)) > 0 and var_139_6 < var_139_10 then
					arg_136_1.talkMaxDuration = var_139_10

					if var_139_10 + var_139_5 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_5
					end
				end

				arg_136_1.text_.text = var_139_8
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082031", "story_v_out_423082.awb") ~= 0 then
					local var_139_11 = manager.audio:GetVoiceLength("story_v_out_423082", "423082031", "story_v_out_423082.awb") / 1000

					if var_139_11 + var_139_5 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_11 + var_139_5
					end

					if var_139_7.prefab_name ~= "" and arg_136_1.actors_[var_139_7.prefab_name] ~= nil then
						local var_139_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_7.prefab_name].transform, "story_v_out_423082", "423082031", "story_v_out_423082.awb")

						arg_136_1:RecordAudio("423082031", var_139_12)
						arg_136_1:RecordAudio("423082031", var_139_12)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_423082", "423082031", "story_v_out_423082.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_423082", "423082031", "story_v_out_423082.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_13 = math.max(var_139_6, arg_136_1.talkMaxDuration)

			if var_139_5 <= arg_136_1.time_ and arg_136_1.time_ < var_139_5 + var_139_13 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_5) / var_139_13

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_5 + var_139_13 and arg_136_1.time_ < var_139_5 + var_139_13 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
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

		arg_136_1:InitPlayNodeList()
	end,
	Play423082032 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 423082032
		arg_140_1.duration_ = 6.93

		local var_140_0 = {
			zh = 4.8,
			ja = 6.933
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
				arg_140_0:Play423082033(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1083"]) and arg_140_1.var_.actorSpriteComps1083 == nil then
				arg_140_1.var_.actorSpriteComps1083 = arg_140_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_143_0 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1083"]) then
				if arg_140_1.var_.actorSpriteComps1083 then
					for iter_143_0, iter_143_1 in pairs(arg_140_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_143_1 then
							if arg_140_1.isInRecall_ then
								iter_143_1.color = Color.New(Mathf.Lerp(iter_143_1.color.r, arg_140_1.hightColor2.r, (arg_140_1.time_ - 0) / var_143_0), Mathf.Lerp(iter_143_1.color.g, arg_140_1.hightColor2.g, (arg_140_1.time_ - 0) / var_143_0), (Mathf.Lerp(iter_143_1.color.b, arg_140_1.hightColor2.b, (arg_140_1.time_ - 0) / var_143_0)))
							else
								local var_143_1 = Mathf.Lerp(iter_143_1.color.r, 0.5, (arg_140_1.time_ - 0) / var_143_0)

								iter_143_1.color = Color.New(var_143_1, var_143_1, var_143_1)
							end
						end
					end
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1083"]) and arg_140_1.var_.actorSpriteComps1083 then
				for iter_143_2, iter_143_3 in pairs(arg_140_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_143_3 then
						iter_143_3.color = arg_140_1.isInRecall_ and (arg_140_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_140_1.var_.actorSpriteComps1083 = nil
			end

			if 0.0666666666666667 < arg_140_1.time_ and arg_140_1.time_ <= 0.0666666666666667 + arg_143_0 then
				arg_140_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_clap", "")
			end

			local var_143_3 = 0
			local var_143_4 = 0.55

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_3 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[1334].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Lauren")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_5 = arg_140_1:GetWordFromCfg(423082032)
				local var_143_6 = arg_140_1:FormatText(var_143_5.content)

				arg_140_1.text_.text = var_143_6

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_8 = 22 <= 0 and var_143_4 or var_143_4 * (utf8.len(var_143_6) / 22)

				if (22 <= 0 and var_143_4 or var_143_4 * (utf8.len(var_143_6) / 22)) > 0 and var_143_4 < var_143_8 then
					arg_140_1.talkMaxDuration = var_143_8

					if var_143_8 + var_143_3 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_8 + var_143_3
					end
				end

				arg_140_1.text_.text = var_143_6
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082032", "story_v_out_423082.awb") ~= 0 then
					local var_143_9 = manager.audio:GetVoiceLength("story_v_out_423082", "423082032", "story_v_out_423082.awb") / 1000

					if var_143_9 + var_143_3 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_3
					end

					if var_143_5.prefab_name ~= "" and arg_140_1.actors_[var_143_5.prefab_name] ~= nil then
						local var_143_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_5.prefab_name].transform, "story_v_out_423082", "423082032", "story_v_out_423082.awb")

						arg_140_1:RecordAudio("423082032", var_143_10)
						arg_140_1:RecordAudio("423082032", var_143_10)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_423082", "423082032", "story_v_out_423082.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_423082", "423082032", "story_v_out_423082.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_11 = math.max(var_143_4, arg_140_1.talkMaxDuration)

			if var_143_3 <= arg_140_1.time_ and arg_140_1.time_ < var_143_3 + var_143_11 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_3) / var_143_11

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_3 + var_143_11 and arg_140_1.time_ < var_143_3 + var_143_11 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play423082033 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 423082033
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play423082034(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.775

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_1 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(423082033).content)

				arg_144_1.text_.text = var_147_1

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_3 = 31 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 31)

				if (31 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 31)) > 0 and var_147_0 < var_147_3 then
					arg_144_1.talkMaxDuration = var_147_3

					if var_147_3 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_3 + 0
					end
				end

				arg_144_1.text_.text = var_147_1
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_4 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_4

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play423082034 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 423082034
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play423082035(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0.825

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_1 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(423082034).content)

				arg_148_1.text_.text = var_151_1

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_3 = 33 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_1) / 33)

				if (33 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_1) / 33)) > 0 and var_151_0 < var_151_3 then
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
	Play423082035 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 423082035
		arg_152_1.duration_ = 6.5

		local var_152_0 = {
			zh = 6.5,
			ja = 6.3
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play423082036(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1083"]) and arg_152_1.var_.actorSpriteComps1083 == nil then
				arg_152_1.var_.actorSpriteComps1083 = arg_152_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_155_0 = 0.2

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1083"]) then
				if arg_152_1.var_.actorSpriteComps1083 then
					for iter_155_0, iter_155_1 in pairs(arg_152_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_155_1 then
							if arg_152_1.isInRecall_ then
								iter_155_1.color = Color.New(Mathf.Lerp(iter_155_1.color.r, arg_152_1.hightColor1.r, (arg_152_1.time_ - 0) / var_155_0), Mathf.Lerp(iter_155_1.color.g, arg_152_1.hightColor1.g, (arg_152_1.time_ - 0) / var_155_0), (Mathf.Lerp(iter_155_1.color.b, arg_152_1.hightColor1.b, (arg_152_1.time_ - 0) / var_155_0)))
							else
								local var_155_1 = Mathf.Lerp(iter_155_1.color.r, 1, (arg_152_1.time_ - 0) / var_155_0)

								iter_155_1.color = Color.New(var_155_1, var_155_1, var_155_1)
							end
						end
					end
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1083"]) and arg_152_1.var_.actorSpriteComps1083 then
				for iter_155_2, iter_155_3 in pairs(arg_152_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_155_3 then
						iter_155_3.color = arg_152_1.isInRecall_ and (arg_152_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_152_1.var_.actorSpriteComps1083 = nil
			end

			local var_155_2 = arg_152_1.actors_["1083"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1083 = var_155_2.localPosition
				var_155_2.localScale = Vector3.New(1, 1, 1)

				arg_152_1:CheckSpriteTmpPos("1083", 3)

				for iter_155_4 = 0, var_155_2.childCount - 1 do
					local var_155_3 = var_155_2:GetChild(iter_155_4)

					if var_155_3.name == "" or not string.find(var_155_3.name, "split") then
						var_155_3.gameObject:SetActive(true)
					else
						var_155_3.gameObject:SetActive(false)
					end
				end
			end

			local var_155_4 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_4 then
				var_155_2.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1083, Vector3.New(-50, -345, -345), (arg_152_1.time_ - 0) / var_155_4)
			end

			if arg_152_1.time_ >= 0 + var_155_4 and arg_152_1.time_ < 0 + var_155_4 + arg_155_0 then
				var_155_2.localPosition = Vector3.New(-50, -345, -345)
			end

			local var_155_5 = 0
			local var_155_6 = 0.75

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_5 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_7 = arg_152_1:GetWordFromCfg(423082035)
				local var_155_8 = arg_152_1:FormatText(var_155_7.content)

				arg_152_1.text_.text = var_155_8

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_10 = 30 <= 0 and var_155_6 or var_155_6 * (utf8.len(var_155_8) / 30)

				if (30 <= 0 and var_155_6 or var_155_6 * (utf8.len(var_155_8) / 30)) > 0 and var_155_6 < var_155_10 then
					arg_152_1.talkMaxDuration = var_155_10

					if var_155_10 + var_155_5 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_5
					end
				end

				arg_152_1.text_.text = var_155_8
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082035", "story_v_out_423082.awb") ~= 0 then
					local var_155_11 = manager.audio:GetVoiceLength("story_v_out_423082", "423082035", "story_v_out_423082.awb") / 1000

					if var_155_11 + var_155_5 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_11 + var_155_5
					end

					if var_155_7.prefab_name ~= "" and arg_152_1.actors_[var_155_7.prefab_name] ~= nil then
						local var_155_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_7.prefab_name].transform, "story_v_out_423082", "423082035", "story_v_out_423082.awb")

						arg_152_1:RecordAudio("423082035", var_155_12)
						arg_152_1:RecordAudio("423082035", var_155_12)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_423082", "423082035", "story_v_out_423082.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_423082", "423082035", "story_v_out_423082.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_13 = math.max(var_155_6, arg_152_1.talkMaxDuration)

			if var_155_5 <= arg_152_1.time_ and arg_152_1.time_ < var_155_5 + var_155_13 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_5) / var_155_13

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_5 + var_155_13 and arg_152_1.time_ < var_155_5 + var_155_13 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
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

		arg_152_1:InitPlayNodeList()
	end,
	Play423082036 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 423082036
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play423082037(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1083"]) and arg_156_1.var_.actorSpriteComps1083 == nil then
				arg_156_1.var_.actorSpriteComps1083 = arg_156_1.actors_["1083"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_159_0 = 0.2

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1083"]) then
				if arg_156_1.var_.actorSpriteComps1083 then
					for iter_159_0, iter_159_1 in pairs(arg_156_1.var_.actorSpriteComps1083:ToTable()) do
						if iter_159_1 then
							if arg_156_1.isInRecall_ then
								iter_159_1.color = Color.New(Mathf.Lerp(iter_159_1.color.r, arg_156_1.hightColor2.r, (arg_156_1.time_ - 0) / var_159_0), Mathf.Lerp(iter_159_1.color.g, arg_156_1.hightColor2.g, (arg_156_1.time_ - 0) / var_159_0), (Mathf.Lerp(iter_159_1.color.b, arg_156_1.hightColor2.b, (arg_156_1.time_ - 0) / var_159_0)))
							else
								local var_159_1 = Mathf.Lerp(iter_159_1.color.r, 0.5, (arg_156_1.time_ - 0) / var_159_0)

								iter_159_1.color = Color.New(var_159_1, var_159_1, var_159_1)
							end
						end
					end
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1083"]) and arg_156_1.var_.actorSpriteComps1083 then
				for iter_159_2, iter_159_3 in pairs(arg_156_1.var_.actorSpriteComps1083:ToTable()) do
					if iter_159_3 then
						iter_159_3.color = arg_156_1.isInRecall_ and (arg_156_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_156_1.var_.actorSpriteComps1083 = nil
			end

			local var_159_2 = arg_156_1.actors_["1083"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1083 = var_159_2.localPosition
				var_159_2.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("1083", 7)

				for iter_159_4 = 0, var_159_2.childCount - 1 do
					local var_159_3 = var_159_2:GetChild(iter_159_4)

					if var_159_3.name == "" or not string.find(var_159_3.name, "split") then
						var_159_3.gameObject:SetActive(true)
					else
						var_159_3.gameObject:SetActive(false)
					end
				end
			end

			local var_159_4 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 then
				var_159_2.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1083, Vector3.New(0, -2000, 0), (arg_156_1.time_ - 0) / var_159_4)
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 then
				var_159_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1 < arg_156_1.time_ and arg_156_1.time_ <= 1 + arg_159_0 then
				arg_156_1:AudioAction("play", "effect", "se_story_122_01", "se_story_122_01_metaldoor", "")
			end

			local var_159_6 = 0
			local var_159_7 = 1.825

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_8 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(423082036).content)

				arg_156_1.text_.text = var_159_8

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_10 = 69 <= 0 and var_159_7 or var_159_7 * (utf8.len(var_159_8) / 69)

				if (69 <= 0 and var_159_7 or var_159_7 * (utf8.len(var_159_8) / 69)) > 0 and var_159_7 < var_159_10 then
					arg_156_1.talkMaxDuration = var_159_10

					if var_159_10 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_6
					end
				end

				arg_156_1.text_.text = var_159_8
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_11 = math.max(var_159_7, arg_156_1.talkMaxDuration)

			if var_159_6 <= arg_156_1.time_ and arg_156_1.time_ < var_159_6 + var_159_11 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_6) / var_159_11

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_6 + var_159_11 and arg_156_1.time_ < var_159_6 + var_159_11 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
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

		arg_156_1:InitPlayNodeList()
	end,
	Play423082037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 423082037
		arg_160_1.duration_ = 8.77

		local var_160_0 = {
			zh = 7.533,
			ja = 8.766
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play423082038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if arg_160_1.actors_["10146"] == nil then
				local var_163_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10146")

				if not isNil(var_163_0) then
					local var_163_1 = Object.Instantiate(var_163_0, arg_160_1.canvasGo_.transform)

					var_163_1.transform:SetSiblingIndex(1)

					var_163_1.name = "10146"
					var_163_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_160_1.actors_["10146"] = var_163_1

					if arg_160_1.isInRecall_ then
						for iter_163_0, iter_163_1 in ipairs((var_163_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_163_1.color = arg_160_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_163_2 = arg_160_1.actors_["10146"]

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(var_163_2) and arg_160_1.var_.actorSpriteComps10146 == nil then
				arg_160_1.var_.actorSpriteComps10146 = var_163_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_163_3 = 0.2

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_3 and not isNil(var_163_2) then
				if arg_160_1.var_.actorSpriteComps10146 then
					for iter_163_2, iter_163_3 in pairs(arg_160_1.var_.actorSpriteComps10146:ToTable()) do
						if iter_163_3 then
							if arg_160_1.isInRecall_ then
								iter_163_3.color = Color.New(Mathf.Lerp(iter_163_3.color.r, arg_160_1.hightColor1.r, (arg_160_1.time_ - 0) / var_163_3), Mathf.Lerp(iter_163_3.color.g, arg_160_1.hightColor1.g, (arg_160_1.time_ - 0) / var_163_3), (Mathf.Lerp(iter_163_3.color.b, arg_160_1.hightColor1.b, (arg_160_1.time_ - 0) / var_163_3)))
							else
								local var_163_4 = Mathf.Lerp(iter_163_3.color.r, 1, (arg_160_1.time_ - 0) / var_163_3)

								iter_163_3.color = Color.New(var_163_4, var_163_4, var_163_4)
							end
						end
					end
				end
			end

			if arg_160_1.time_ >= 0 + var_163_3 and arg_160_1.time_ < 0 + var_163_3 + arg_163_0 and not isNil(var_163_2) and arg_160_1.var_.actorSpriteComps10146 then
				for iter_163_4, iter_163_5 in pairs(arg_160_1.var_.actorSpriteComps10146:ToTable()) do
					if iter_163_5 then
						iter_163_5.color = arg_160_1.isInRecall_ and (arg_160_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_160_1.var_.actorSpriteComps10146 = nil
			end

			local var_163_5 = arg_160_1.actors_["10146"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos10146 = var_163_5.localPosition
				var_163_5.localScale = Vector3.New(1, 1, 1)

				arg_160_1:CheckSpriteTmpPos("10146", 3)

				for iter_163_6 = 0, var_163_5.childCount - 1 do
					local var_163_6 = var_163_5:GetChild(iter_163_6)

					if var_163_6.name == "split_3" or not string.find(var_163_6.name, "split") then
						var_163_6.gameObject:SetActive(true)
					else
						var_163_6.gameObject:SetActive(false)
					end
				end
			end

			local var_163_7 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_7 then
				var_163_5.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10146, Vector3.New(0, -350, -320), (arg_160_1.time_ - 0) / var_163_7)
			end

			if arg_160_1.time_ >= 0 + var_163_7 and arg_160_1.time_ < 0 + var_163_7 + arg_163_0 then
				var_163_5.localPosition = Vector3.New(0, -350, -320)
			end

			local var_163_8 = 0
			local var_163_9 = 0.4

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_8 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_10 = arg_160_1:GetWordFromCfg(423082037)
				local var_163_11 = arg_160_1:FormatText(var_163_10.content)

				arg_160_1.text_.text = var_163_11

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_13 = 16 <= 0 and var_163_9 or var_163_9 * (utf8.len(var_163_11) / 16)

				if (16 <= 0 and var_163_9 or var_163_9 * (utf8.len(var_163_11) / 16)) > 0 and var_163_9 < var_163_13 then
					arg_160_1.talkMaxDuration = var_163_13

					if var_163_13 + var_163_8 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_13 + var_163_8
					end
				end

				arg_160_1.text_.text = var_163_11
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082037", "story_v_out_423082.awb") ~= 0 then
					local var_163_14 = manager.audio:GetVoiceLength("story_v_out_423082", "423082037", "story_v_out_423082.awb") / 1000

					if var_163_14 + var_163_8 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_14 + var_163_8
					end

					if var_163_10.prefab_name ~= "" and arg_160_1.actors_[var_163_10.prefab_name] ~= nil then
						local var_163_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_10.prefab_name].transform, "story_v_out_423082", "423082037", "story_v_out_423082.awb")

						arg_160_1:RecordAudio("423082037", var_163_15)
						arg_160_1:RecordAudio("423082037", var_163_15)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_423082", "423082037", "story_v_out_423082.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_423082", "423082037", "story_v_out_423082.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_16 = math.max(var_163_9, arg_160_1.talkMaxDuration)

			if var_163_8 <= arg_160_1.time_ and arg_160_1.time_ < var_163_8 + var_163_16 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_8) / var_163_16

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_8 + var_163_16 and arg_160_1.time_ < var_163_8 + var_163_16 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10146",
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
	Play423082038 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 423082038
		arg_164_1.duration_ = 13.3

		local var_164_0 = {
			zh = 8.666,
			ja = 13.3
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
				arg_164_0:Play423082039(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 1.05

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_1 = arg_164_1:GetWordFromCfg(423082038)
				local var_167_2 = arg_164_1:FormatText(var_167_1.content)

				arg_164_1.text_.text = var_167_2

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_4 = 42 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 42)

				if (42 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 42)) > 0 and var_167_0 < var_167_4 then
					arg_164_1.talkMaxDuration = var_167_4

					if var_167_4 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_4 + 0
					end
				end

				arg_164_1.text_.text = var_167_2
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082038", "story_v_out_423082.awb") ~= 0 then
					local var_167_5 = manager.audio:GetVoiceLength("story_v_out_423082", "423082038", "story_v_out_423082.awb") / 1000

					if var_167_5 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + 0
					end

					if var_167_1.prefab_name ~= "" and arg_164_1.actors_[var_167_1.prefab_name] ~= nil then
						local var_167_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_1.prefab_name].transform, "story_v_out_423082", "423082038", "story_v_out_423082.awb")

						arg_164_1:RecordAudio("423082038", var_167_6)
						arg_164_1:RecordAudio("423082038", var_167_6)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_423082", "423082038", "story_v_out_423082.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_423082", "423082038", "story_v_out_423082.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_7 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_7 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_7

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_7 and arg_164_1.time_ < 0 + var_167_7 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play423082039 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 423082039
		arg_168_1.duration_ = 12.17

		local var_168_0 = {
			zh = 9,
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
				arg_168_0:Play423082040(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0.925

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_1 = arg_168_1:GetWordFromCfg(423082039)
				local var_171_2 = arg_168_1:FormatText(var_171_1.content)

				arg_168_1.text_.text = var_171_2

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 37 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 37)

				if (37 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 37)) > 0 and var_171_0 < var_171_4 then
					arg_168_1.talkMaxDuration = var_171_4

					if var_171_4 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_4 + 0
					end
				end

				arg_168_1.text_.text = var_171_2
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082039", "story_v_out_423082.awb") ~= 0 then
					local var_171_5 = manager.audio:GetVoiceLength("story_v_out_423082", "423082039", "story_v_out_423082.awb") / 1000

					if var_171_5 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + 0
					end

					if var_171_1.prefab_name ~= "" and arg_168_1.actors_[var_171_1.prefab_name] ~= nil then
						local var_171_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_1.prefab_name].transform, "story_v_out_423082", "423082039", "story_v_out_423082.awb")

						arg_168_1:RecordAudio("423082039", var_171_6)
						arg_168_1:RecordAudio("423082039", var_171_6)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_423082", "423082039", "story_v_out_423082.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_423082", "423082039", "story_v_out_423082.awb")
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
	Play423082040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 423082040
		arg_172_1.duration_ = 5.67

		local var_172_0 = {
			zh = 5.666,
			ja = 5.133
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
			arg_172_1.auto_ = false
		end

		function arg_172_1.playNext_(arg_174_0)
			arg_172_1.onStoryFinished_()
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0.525

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[1338].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_1 = arg_172_1:GetWordFromCfg(423082040)
				local var_175_2 = arg_172_1:FormatText(var_175_1.content)

				arg_172_1.text_.text = var_175_2

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_4 = 21 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 21)

				if (21 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_2) / 21)) > 0 and var_175_0 < var_175_4 then
					arg_172_1.talkMaxDuration = var_175_4

					if var_175_4 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_4 + 0
					end
				end

				arg_172_1.text_.text = var_175_2
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_423082", "423082040", "story_v_out_423082.awb") ~= 0 then
					local var_175_5 = manager.audio:GetVoiceLength("story_v_out_423082", "423082040", "story_v_out_423082.awb") / 1000

					if var_175_5 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + 0
					end

					if var_175_1.prefab_name ~= "" and arg_172_1.actors_[var_175_1.prefab_name] ~= nil then
						local var_175_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_1.prefab_name].transform, "story_v_out_423082", "423082040", "story_v_out_423082.awb")

						arg_172_1:RecordAudio("423082040", var_175_6)
						arg_172_1:RecordAudio("423082040", var_175_6)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_423082", "423082040", "story_v_out_423082.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_423082", "423082040", "story_v_out_423082.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_7 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_7 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_7

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_7 and arg_172_1.time_ < 0 + var_175_7 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I25f"
	},
	voices = {
		"story_v_out_423082.awb"
	}
}
