return {
	Play926061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 926061001
		arg_1_1.duration_ = 6

		local var_1_0 = {
			zh = 5.83333333333333,
			ja = 5.99933333333333
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
				arg_1_0:Play926061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9002
			local var_4_9001
			local var_4_9000

			if arg_1_1.bgs_.ST0114 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0114")
				var_4_0.name = "ST0114"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST0114 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST0114

				arg_1_1.bgs_.ST0114.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST0114" then
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

			local var_4_9 = "10144"

			if arg_1_1.actors_["10144"] == nil then
				local var_4_10 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10144")

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

			local var_4_12 = arg_1_1.actors_["10144"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps10144 == nil then
				arg_1_1.var_.actorSpriteComps10144 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps10144 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_1_1.time_ >= 0 + var_4_13 and arg_1_1.time_ < 0 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps10144 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10144 = nil
			end

			if 0.833333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.833333333333333 + arg_4_0 then
				local var_4_15 = arg_1_1.var_.effect1124

				if not arg_1_1.var_.effect1124 then
					var_4_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_juguangdeng01_in_keep"), manager.ui.mainCamera.transform)
					var_4_15.name = "1124"
					arg_1_1.var_.effect1124 = var_4_15
				else
					var_4_15.transform:SetParent(var_4_9002)
				end

				var_4_15.transform.localPosition = Vector3.New(0, 2.03, 0)
				var_4_15.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_17 = arg_1_1.var_.effect1125

				if not arg_1_1.var_.effect1125 then
					var_4_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heimu_keep"), manager.ui.mainCamera.transform)
					var_4_17.name = "1125"
					arg_1_1.var_.effect1125 = var_4_17
				else
					var_4_17.transform:SetParent(var_4_9001)
				end

				var_4_17.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_17.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_4_19 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_4_8, iter_4_9 in ipairs((var_4_17.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_4_9.transform.localScale = Vector3.New(iter_4_9.transform.localScale.x / var_4_19 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_4_9.transform.localScale.y / var_4_19, iter_4_9.transform.localScale.z)
				end
			end

			local var_4_21 = arg_1_1.actors_["10144"].transform

			if 2.275 < arg_1_1.time_ and arg_1_1.time_ <= 2.275 + arg_4_0 then
				arg_1_1.var_.moveOldPos10144 = var_4_21.localPosition
				var_4_21.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10144", 3)

				for iter_4_10 = 0, var_4_21.childCount - 1 do
					local var_4_22 = var_4_21:GetChild(iter_4_10)

					if var_4_22.name == "split_10" or not string.find(var_4_22.name, "split") then
						var_4_22.gameObject:SetActive(true)
					else
						var_4_22.gameObject:SetActive(false)
					end
				end
			end

			local var_4_23 = 0.001

			if 2.275 <= arg_1_1.time_ and arg_1_1.time_ < 2.275 + var_4_23 then
				var_4_21.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10144, Vector3.New(-8.8, -458.8, -89.4), (arg_1_1.time_ - 2.275) / var_4_23)
			end

			if arg_1_1.time_ >= 2.275 + var_4_23 and arg_1_1.time_ < 2.275 + var_4_23 + arg_4_0 then
				var_4_21.localPosition = Vector3.New(-8.8, -458.8, -89.4)
			end

			if 2.275 < arg_1_1.time_ and arg_1_1.time_ <= 2.275 + arg_4_0 then
				local var_4_24 = arg_1_1.actors_["10144"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_24 then
					arg_1_1.var_.alphaOldValue10144 = var_4_24.alpha
					arg_1_1.var_.characterEffect10144 = var_4_24
				end

				arg_1_1.var_.alphaOldValue10144 = 0
			end

			local var_4_25 = 0.358333333333333

			if 2.275 <= arg_1_1.time_ and arg_1_1.time_ < 2.275 + var_4_25 then
				if arg_1_1.var_.characterEffect10144 then
					arg_1_1.var_.characterEffect10144.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10144, 1, (arg_1_1.time_ - 2.275) / var_4_25)
				end
			end

			if arg_1_1.time_ >= 2.275 + var_4_25 and arg_1_1.time_ < 2.275 + var_4_25 + arg_4_0 and arg_1_1.var_.characterEffect10144 then
				arg_1_1.var_.characterEffect10144.alpha = 1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_28 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_28 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_28

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_28
						arg_1_1.bgmTxt2_.text = var_4_28
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

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_bar", "")
			end

			if 0.833333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.833333333333333 + arg_4_0 then
				local var_4_30 = arg_1_1.var_.effect2323

				if not arg_1_1.var_.effect2323 then
					var_4_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_juguangdeng01_in_keep"), manager.ui.mainCamera.transform)
					var_4_30.name = "2323"
					arg_1_1.var_.effect2323 = var_4_30
				else
					var_4_30.transform:SetParent(var_4_9000)
				end

				var_4_30.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_30.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_32 = 3.23333333333333
			local var_4_33 = 0.275

			if 3.23333333333333 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_34 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_34:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_35 = arg_1_1:GetWordFromCfg(926061001)
				local var_4_36 = arg_1_1:FormatText(var_4_35.content)

				arg_1_1.text_.text = var_4_36

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 11 <= 0 and var_4_33 or var_4_33 * (utf8.len(var_4_36) / 11)

				if (11 <= 0 and var_4_33 or var_4_33 * (utf8.len(var_4_36) / 11)) > 0 and var_4_33 < var_4_38 then
					arg_1_1.talkMaxDuration = var_4_38
					var_4_32 = var_4_32 + 0.3

					if var_4_38 + var_4_32 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_38 + var_4_32
					end
				end

				arg_1_1.text_.text = var_4_36
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061001", "story_v_out_926061.awb") ~= 0 then
					local var_4_39 = manager.audio:GetVoiceLength("story_v_out_926061", "926061001", "story_v_out_926061.awb") / 1000

					if var_4_39 + var_4_32 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_39 + var_4_32
					end

					if var_4_35.prefab_name ~= "" and arg_1_1.actors_[var_4_35.prefab_name] ~= nil then
						local var_4_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_35.prefab_name].transform, "story_v_out_926061", "926061001", "story_v_out_926061.awb")

						arg_1_1:RecordAudio("926061001", var_4_40)
						arg_1_1:RecordAudio("926061001", var_4_40)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_926061", "926061001", "story_v_out_926061.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_926061", "926061001", "story_v_out_926061.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_41 = var_4_32 + 0.3
			local var_4_42 = math.max(var_4_33, arg_1_1.talkMaxDuration)

			if var_4_32 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_41) / var_4_42

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.275,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play926061002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 926061002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play926061003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["10144"]) and arg_8_1.var_.actorSpriteComps10144 == nil then
				arg_8_1.var_.actorSpriteComps10144 = arg_8_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_11_0 = 0.2

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["10144"]) then
				if arg_8_1.var_.actorSpriteComps10144 then
					for iter_11_0, iter_11_1 in pairs(arg_8_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_11_1 then
							if arg_8_1.isInRecall_ then
								iter_11_1.color = Color.New(Mathf.Lerp(iter_11_1.color.r, arg_8_1.hightColor2.r, (arg_8_1.time_ - 0) / var_11_0), Mathf.Lerp(iter_11_1.color.g, arg_8_1.hightColor2.g, (arg_8_1.time_ - 0) / var_11_0), (Mathf.Lerp(iter_11_1.color.b, arg_8_1.hightColor2.b, (arg_8_1.time_ - 0) / var_11_0)))
							else
								local var_11_1 = Mathf.Lerp(iter_11_1.color.r, 0.5, (arg_8_1.time_ - 0) / var_11_0)

								iter_11_1.color = Color.New(var_11_1, var_11_1, var_11_1)
							end
						end
					end
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["10144"]) and arg_8_1.var_.actorSpriteComps10144 then
				for iter_11_2, iter_11_3 in pairs(arg_8_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_11_3 then
						iter_11_3.color = arg_8_1.isInRecall_ and (arg_8_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_8_1.var_.actorSpriteComps10144 = nil
			end

			local var_11_2 = 0
			local var_11_3 = 1.3

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_2 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_4 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(926061002).content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_6 = 52 <= 0 and var_11_3 or var_11_3 * (utf8.len(var_11_4) / 52)

				if (52 <= 0 and var_11_3 or var_11_3 * (utf8.len(var_11_4) / 52)) > 0 and var_11_3 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_2 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_2
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_3, arg_8_1.talkMaxDuration)

			if var_11_2 <= arg_8_1.time_ and arg_8_1.time_ < var_11_2 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_2) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_2 + var_11_7 and arg_8_1.time_ < var_11_2 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play926061003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 926061003
		arg_12_1.duration_ = 8.6

		local var_12_0 = {
			zh = 6.566,
			ja = 8.6
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play926061004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["10144"]) and arg_12_1.var_.actorSpriteComps10144 == nil then
				arg_12_1.var_.actorSpriteComps10144 = arg_12_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_15_0 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["10144"]) then
				if arg_12_1.var_.actorSpriteComps10144 then
					for iter_15_0, iter_15_1 in pairs(arg_12_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_15_1 then
							if arg_12_1.isInRecall_ then
								iter_15_1.color = Color.New(Mathf.Lerp(iter_15_1.color.r, arg_12_1.hightColor1.r, (arg_12_1.time_ - 0) / var_15_0), Mathf.Lerp(iter_15_1.color.g, arg_12_1.hightColor1.g, (arg_12_1.time_ - 0) / var_15_0), (Mathf.Lerp(iter_15_1.color.b, arg_12_1.hightColor1.b, (arg_12_1.time_ - 0) / var_15_0)))
							else
								local var_15_1 = Mathf.Lerp(iter_15_1.color.r, 1, (arg_12_1.time_ - 0) / var_15_0)

								iter_15_1.color = Color.New(var_15_1, var_15_1, var_15_1)
							end
						end
					end
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["10144"]) and arg_12_1.var_.actorSpriteComps10144 then
				for iter_15_2, iter_15_3 in pairs(arg_12_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_15_3 then
						iter_15_3.color = arg_12_1.isInRecall_ and (arg_12_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_12_1.var_.actorSpriteComps10144 = nil
			end

			local var_15_2 = 0
			local var_15_3 = 0.65

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_4 = arg_12_1:GetWordFromCfg(926061003)
				local var_15_5 = arg_12_1:FormatText(var_15_4.content)

				arg_12_1.text_.text = var_15_5

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_7 = 26 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_5) / 26)

				if (26 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_5) / 26)) > 0 and var_15_3 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_2
					end
				end

				arg_12_1.text_.text = var_15_5
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061003", "story_v_out_926061.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_926061", "926061003", "story_v_out_926061.awb") / 1000

					if var_15_8 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_2
					end

					if var_15_4.prefab_name ~= "" and arg_12_1.actors_[var_15_4.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_4.prefab_name].transform, "story_v_out_926061", "926061003", "story_v_out_926061.awb")

						arg_12_1:RecordAudio("926061003", var_15_9)
						arg_12_1:RecordAudio("926061003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_926061", "926061003", "story_v_out_926061.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_926061", "926061003", "story_v_out_926061.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_10 = math.max(var_15_3, arg_12_1.talkMaxDuration)

			if var_15_2 <= arg_12_1.time_ and arg_12_1.time_ < var_15_2 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_2) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_2 + var_15_10 and arg_12_1.time_ < var_15_2 + var_15_10 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play926061004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 926061004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play926061005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["10144"]) and arg_16_1.var_.actorSpriteComps10144 == nil then
				arg_16_1.var_.actorSpriteComps10144 = arg_16_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_19_0 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["10144"]) then
				if arg_16_1.var_.actorSpriteComps10144 then
					for iter_19_0, iter_19_1 in pairs(arg_16_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_19_1 then
							if arg_16_1.isInRecall_ then
								iter_19_1.color = Color.New(Mathf.Lerp(iter_19_1.color.r, arg_16_1.hightColor2.r, (arg_16_1.time_ - 0) / var_19_0), Mathf.Lerp(iter_19_1.color.g, arg_16_1.hightColor2.g, (arg_16_1.time_ - 0) / var_19_0), (Mathf.Lerp(iter_19_1.color.b, arg_16_1.hightColor2.b, (arg_16_1.time_ - 0) / var_19_0)))
							else
								local var_19_1 = Mathf.Lerp(iter_19_1.color.r, 0.5, (arg_16_1.time_ - 0) / var_19_0)

								iter_19_1.color = Color.New(var_19_1, var_19_1, var_19_1)
							end
						end
					end
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["10144"]) and arg_16_1.var_.actorSpriteComps10144 then
				for iter_19_2, iter_19_3 in pairs(arg_16_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_19_3 then
						iter_19_3.color = arg_16_1.isInRecall_ and (arg_16_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_16_1.var_.actorSpriteComps10144 = nil
			end

			local var_19_2 = 0
			local var_19_3 = 0.35

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_4 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(926061004).content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 14 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_4) / 14)

				if (14 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_4) / 14)) > 0 and var_19_3 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_2
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_3, arg_16_1.talkMaxDuration)

			if var_19_2 <= arg_16_1.time_ and arg_16_1.time_ < var_19_2 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_2) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_2 + var_19_7 and arg_16_1.time_ < var_19_2 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play926061005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 926061005
		arg_20_1.duration_ = 5.27

		local var_20_0 = {
			zh = 3.2,
			ja = 5.266
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play926061006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["10144"]) and arg_20_1.var_.actorSpriteComps10144 == nil then
				arg_20_1.var_.actorSpriteComps10144 = arg_20_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_0 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["10144"]) then
				if arg_20_1.var_.actorSpriteComps10144 then
					for iter_23_0, iter_23_1 in pairs(arg_20_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_23_1 then
							if arg_20_1.isInRecall_ then
								iter_23_1.color = Color.New(Mathf.Lerp(iter_23_1.color.r, arg_20_1.hightColor1.r, (arg_20_1.time_ - 0) / var_23_0), Mathf.Lerp(iter_23_1.color.g, arg_20_1.hightColor1.g, (arg_20_1.time_ - 0) / var_23_0), (Mathf.Lerp(iter_23_1.color.b, arg_20_1.hightColor1.b, (arg_20_1.time_ - 0) / var_23_0)))
							else
								local var_23_1 = Mathf.Lerp(iter_23_1.color.r, 1, (arg_20_1.time_ - 0) / var_23_0)

								iter_23_1.color = Color.New(var_23_1, var_23_1, var_23_1)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["10144"]) and arg_20_1.var_.actorSpriteComps10144 then
				for iter_23_2, iter_23_3 in pairs(arg_20_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_23_3 then
						iter_23_3.color = arg_20_1.isInRecall_ and (arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_20_1.var_.actorSpriteComps10144 = nil
			end

			local var_23_2 = 0
			local var_23_3 = 0.325

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_2 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_4 = arg_20_1:GetWordFromCfg(926061005)
				local var_23_5 = arg_20_1:FormatText(var_23_4.content)

				arg_20_1.text_.text = var_23_5

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_7 = 13 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_5) / 13)

				if (13 <= 0 and var_23_3 or var_23_3 * (utf8.len(var_23_5) / 13)) > 0 and var_23_3 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_2
					end
				end

				arg_20_1.text_.text = var_23_5
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061005", "story_v_out_926061.awb") ~= 0 then
					local var_23_8 = manager.audio:GetVoiceLength("story_v_out_926061", "926061005", "story_v_out_926061.awb") / 1000

					if var_23_8 + var_23_2 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_2
					end

					if var_23_4.prefab_name ~= "" and arg_20_1.actors_[var_23_4.prefab_name] ~= nil then
						local var_23_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_4.prefab_name].transform, "story_v_out_926061", "926061005", "story_v_out_926061.awb")

						arg_20_1:RecordAudio("926061005", var_23_9)
						arg_20_1:RecordAudio("926061005", var_23_9)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_926061", "926061005", "story_v_out_926061.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_926061", "926061005", "story_v_out_926061.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_10 = math.max(var_23_3, arg_20_1.talkMaxDuration)

			if var_23_2 <= arg_20_1.time_ and arg_20_1.time_ < var_23_2 + var_23_10 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_2) / var_23_10

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_2 + var_23_10 and arg_20_1.time_ < var_23_2 + var_23_10 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play926061006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 926061006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play926061007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_9001
			local var_27_9000

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["10144"]) and arg_24_1.var_.actorSpriteComps10144 == nil then
				arg_24_1.var_.actorSpriteComps10144 = arg_24_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_27_0 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["10144"]) then
				if arg_24_1.var_.actorSpriteComps10144 then
					for iter_27_0, iter_27_1 in pairs(arg_24_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_27_1 then
							if arg_24_1.isInRecall_ then
								iter_27_1.color = Color.New(Mathf.Lerp(iter_27_1.color.r, arg_24_1.hightColor2.r, (arg_24_1.time_ - 0) / var_27_0), Mathf.Lerp(iter_27_1.color.g, arg_24_1.hightColor2.g, (arg_24_1.time_ - 0) / var_27_0), (Mathf.Lerp(iter_27_1.color.b, arg_24_1.hightColor2.b, (arg_24_1.time_ - 0) / var_27_0)))
							else
								local var_27_1 = Mathf.Lerp(iter_27_1.color.r, 0.5, (arg_24_1.time_ - 0) / var_27_0)

								iter_27_1.color = Color.New(var_27_1, var_27_1, var_27_1)
							end
						end
					end
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["10144"]) and arg_24_1.var_.actorSpriteComps10144 then
				for iter_27_2, iter_27_3 in pairs(arg_24_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_27_3 then
						iter_27_3.color = arg_24_1.isInRecall_ and (arg_24_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_24_1.var_.actorSpriteComps10144 = nil
			end

			local var_27_2 = arg_24_1.actors_["10144"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos10144 = var_27_2.localPosition
				var_27_2.localScale = Vector3.New(1, 1, 1)

				arg_24_1:CheckSpriteTmpPos("10144", 7)

				for iter_27_4 = 0, var_27_2.childCount - 1 do
					local var_27_3 = var_27_2:GetChild(iter_27_4)

					if var_27_3.name == "" or not string.find(var_27_3.name, "split") then
						var_27_3.gameObject:SetActive(true)
					else
						var_27_3.gameObject:SetActive(false)
					end
				end
			end

			local var_27_4 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				var_27_2.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_24_1.time_ - 0) / var_27_4)
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				var_27_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				if arg_24_1.var_.effect1125 then
					Object.Destroy(arg_24_1.var_.effect1125)

					arg_24_1.var_.effect1125 = nil
				end
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				if arg_24_1.var_.effect1124 then
					Object.Destroy(arg_24_1.var_.effect1124)

					arg_24_1.var_.effect1124 = nil
				end
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				local var_27_7 = arg_24_1.var_.effect1122

				if not arg_24_1.var_.effect1122 then
					var_27_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heimu_out"), manager.ui.mainCamera.transform)
					var_27_7.name = "1122"
					arg_24_1.var_.effect1122 = var_27_7
				else
					var_27_7.transform:SetParent(var_27_9001)
				end

				var_27_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_27_7.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_27_9 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_27_5, iter_27_6 in ipairs((var_27_7.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_27_6.transform.localScale = Vector3.New(iter_27_6.transform.localScale.x / var_27_9 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_27_6.transform.localScale.y / var_27_9, iter_27_6.transform.localScale.z)
				end
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				local var_27_11 = arg_24_1.var_.effect1126

				if not arg_24_1.var_.effect1126 then
					var_27_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_juguangdeng01_out"), manager.ui.mainCamera.transform)
					var_27_11.name = "1126"
					arg_24_1.var_.effect1126 = var_27_11
				else
					var_27_11.transform:SetParent(var_27_9000)
				end

				var_27_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_27_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:AudioAction("play", "effect", "se_story_143", "se_story_143_eyeglasses_break", "")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				if arg_24_1.var_.effect2323 then
					Object.Destroy(arg_24_1.var_.effect2323)

					arg_24_1.var_.effect2323 = nil
				end
			end

			if 0.034 < arg_24_1.time_ and arg_24_1.time_ <= 0.034 + arg_27_0 then
				arg_24_1:AudioAction("play", "music", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern.awb")

				local var_27_17 = manager.audio:GetAudioName("bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern")

				if "" ~= "" then
					if arg_24_1.bgmTxt_.text ~= var_27_17 and arg_24_1.bgmTxt_.text ~= "" then
						if arg_24_1.bgmTxt2_.text ~= "" then
							arg_24_1.bgmTxt_.text = arg_24_1.bgmTxt2_.text
						end

						arg_24_1.bgmTxt2_.text = var_27_17

						arg_24_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_24_1.bgmTxt_.text = var_27_17
						arg_24_1.bgmTxt2_.text = var_27_17
					end

					if arg_24_1.bgmTimer then
						arg_24_1.bgmTimer:Stop()

						arg_24_1.bgmTimer = nil
					end

					if arg_24_1.settingData.show_music_name == 1 then
						arg_24_1.musicController:SetSelectedState("show")
						arg_24_1.musicAnimator_:Play("open", 0, 0)

						if arg_24_1.settingData.music_time ~= 0 then
							arg_24_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_24_1.settingData.music_time), function()
								if arg_24_1 == nil or isNil(arg_24_1.bgmTxt_) then
									return
								end

								arg_24_1.musicController:SetSelectedState("hide")
								arg_24_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_27_18 = 0
			local var_27_19 = 0.875

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_18 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_20 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(926061006).content)

				arg_24_1.text_.text = var_27_20

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_22 = 35 <= 0 and var_27_19 or var_27_19 * (utf8.len(var_27_20) / 35)

				if (35 <= 0 and var_27_19 or var_27_19 * (utf8.len(var_27_20) / 35)) > 0 and var_27_19 < var_27_22 then
					arg_24_1.talkMaxDuration = var_27_22

					if var_27_22 + var_27_18 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_22 + var_27_18
					end
				end

				arg_24_1.text_.text = var_27_20
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_23 = math.max(var_27_19, arg_24_1.talkMaxDuration)

			if var_27_18 <= arg_24_1.time_ and arg_24_1.time_ < var_27_18 + var_27_23 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_18) / var_27_23

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_18 + var_27_23 and arg_24_1.time_ < var_27_18 + var_27_23 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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

		arg_24_1:InitPlayNodeList()
	end,
	Play926061007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 926061007
		arg_29_1.duration_ = 6.07

		local var_29_0 = {
			zh = 3.766,
			ja = 6.066
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
				arg_29_0:Play926061008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.actors_["128404"] == nil then
				local var_32_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_32_0) then
					local var_32_1 = Object.Instantiate(var_32_0, arg_29_1.canvasGo_.transform)

					var_32_1.transform:SetSiblingIndex(1)

					var_32_1.name = "128404"
					var_32_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_29_1.actors_["128404"] = var_32_1

					if arg_29_1.isInRecall_ then
						for iter_32_0, iter_32_1 in ipairs((var_32_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_32_1.color = arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_32_2 = arg_29_1.actors_["128404"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps128404 == nil then
				arg_29_1.var_.actorSpriteComps128404 = var_32_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_32_3 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.actorSpriteComps128404 then
					for iter_32_2, iter_32_3 in pairs(arg_29_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_32_3 then
							if arg_29_1.isInRecall_ then
								iter_32_3.color = Color.New(Mathf.Lerp(iter_32_3.color.r, arg_29_1.hightColor1.r, (arg_29_1.time_ - 0) / var_32_3), Mathf.Lerp(iter_32_3.color.g, arg_29_1.hightColor1.g, (arg_29_1.time_ - 0) / var_32_3), (Mathf.Lerp(iter_32_3.color.b, arg_29_1.hightColor1.b, (arg_29_1.time_ - 0) / var_32_3)))
							else
								local var_32_4 = Mathf.Lerp(iter_32_3.color.r, 1, (arg_29_1.time_ - 0) / var_32_3)

								iter_32_3.color = Color.New(var_32_4, var_32_4, var_32_4)
							end
						end
					end
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.actorSpriteComps128404 then
				for iter_32_4, iter_32_5 in pairs(arg_29_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_32_5 then
						iter_32_5.color = arg_29_1.isInRecall_ and (arg_29_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_29_1.var_.actorSpriteComps128404 = nil
			end

			local var_32_5 = arg_29_1.actors_["128404"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos128404 = var_32_5.localPosition
				var_32_5.localScale = Vector3.New(1, 1, 1)

				arg_29_1:CheckSpriteTmpPos("128404", 3)

				for iter_32_6 = 0, var_32_5.childCount - 1 do
					local var_32_6 = var_32_5:GetChild(iter_32_6)

					if var_32_6.name == "" or not string.find(var_32_6.name, "split") then
						var_32_6.gameObject:SetActive(true)
					else
						var_32_6.gameObject:SetActive(false)
					end
				end
			end

			local var_32_7 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_7 then
				var_32_5.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_29_1.time_ - 0) / var_32_7)
			end

			if arg_29_1.time_ >= 0 + var_32_7 and arg_29_1.time_ < 0 + var_32_7 + arg_32_0 then
				var_32_5.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_32_8 = 0
			local var_32_9 = 0.45

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_8 + arg_32_0 then
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

				local var_32_10 = arg_29_1:GetWordFromCfg(926061007)
				local var_32_11 = arg_29_1:FormatText(var_32_10.content)

				arg_29_1.text_.text = var_32_11

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_13 = 18 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 18)

				if (18 <= 0 and var_32_9 or var_32_9 * (utf8.len(var_32_11) / 18)) > 0 and var_32_9 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_8
					end
				end

				arg_29_1.text_.text = var_32_11
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061007", "story_v_out_926061.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_926061", "926061007", "story_v_out_926061.awb") / 1000

					if var_32_14 + var_32_8 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_8
					end

					if var_32_10.prefab_name ~= "" and arg_29_1.actors_[var_32_10.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_10.prefab_name].transform, "story_v_out_926061", "926061007", "story_v_out_926061.awb")

						arg_29_1:RecordAudio("926061007", var_32_15)
						arg_29_1:RecordAudio("926061007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_926061", "926061007", "story_v_out_926061.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_926061", "926061007", "story_v_out_926061.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_9, arg_29_1.talkMaxDuration)

			if var_32_8 <= arg_29_1.time_ and arg_29_1.time_ < var_32_8 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_8) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_8 + var_32_16 and arg_29_1.time_ < var_32_8 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play926061008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 926061008
		arg_33_1.duration_ = 10.43

		local var_33_0 = {
			zh = 8.1,
			ja = 10.433
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
				arg_33_0:Play926061009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.actors_["104701"] == nil then
				local var_36_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

				if not isNil(var_36_0) then
					local var_36_1 = Object.Instantiate(var_36_0, arg_33_1.canvasGo_.transform)

					var_36_1.transform:SetSiblingIndex(1)

					var_36_1.name = "104701"
					var_36_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_33_1.actors_["104701"] = var_36_1

					if arg_33_1.isInRecall_ then
						for iter_36_0, iter_36_1 in ipairs((var_36_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_36_1.color = arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_36_2 = arg_33_1.actors_["104701"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps104701 == nil then
				arg_33_1.var_.actorSpriteComps104701 = var_36_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_3 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.actorSpriteComps104701 then
					for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_36_3 then
							if arg_33_1.isInRecall_ then
								iter_36_3.color = Color.New(Mathf.Lerp(iter_36_3.color.r, arg_33_1.hightColor1.r, (arg_33_1.time_ - 0) / var_36_3), Mathf.Lerp(iter_36_3.color.g, arg_33_1.hightColor1.g, (arg_33_1.time_ - 0) / var_36_3), (Mathf.Lerp(iter_36_3.color.b, arg_33_1.hightColor1.b, (arg_33_1.time_ - 0) / var_36_3)))
							else
								local var_36_4 = Mathf.Lerp(iter_36_3.color.r, 1, (arg_33_1.time_ - 0) / var_36_3)

								iter_36_3.color = Color.New(var_36_4, var_36_4, var_36_4)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.actorSpriteComps104701 then
				for iter_36_4, iter_36_5 in pairs(arg_33_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_36_5 then
						iter_36_5.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_33_1.var_.actorSpriteComps104701 = nil
			end

			local var_36_5 = arg_33_1.actors_["128404"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.actorSpriteComps128404 == nil then
				arg_33_1.var_.actorSpriteComps128404 = var_36_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_6 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_6 and not isNil(var_36_5) then
				if arg_33_1.var_.actorSpriteComps128404 then
					for iter_36_6, iter_36_7 in pairs(arg_33_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_36_7 then
							if arg_33_1.isInRecall_ then
								iter_36_7.color = Color.New(Mathf.Lerp(iter_36_7.color.r, arg_33_1.hightColor2.r, (arg_33_1.time_ - 0) / var_36_6), Mathf.Lerp(iter_36_7.color.g, arg_33_1.hightColor2.g, (arg_33_1.time_ - 0) / var_36_6), (Mathf.Lerp(iter_36_7.color.b, arg_33_1.hightColor2.b, (arg_33_1.time_ - 0) / var_36_6)))
							else
								local var_36_7 = Mathf.Lerp(iter_36_7.color.r, 0.5, (arg_33_1.time_ - 0) / var_36_6)

								iter_36_7.color = Color.New(var_36_7, var_36_7, var_36_7)
							end
						end
					end
				end
			end

			if arg_33_1.time_ >= 0 + var_36_6 and arg_33_1.time_ < 0 + var_36_6 + arg_36_0 and not isNil(var_36_5) and arg_33_1.var_.actorSpriteComps128404 then
				for iter_36_8, iter_36_9 in pairs(arg_33_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_36_9 then
						iter_36_9.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps128404 = nil
			end

			local var_36_8 = arg_33_1.actors_["128404"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos128404 = var_36_8.localPosition
				var_36_8.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("128404", 7)

				for iter_36_10 = 0, var_36_8.childCount - 1 do
					local var_36_9 = var_36_8:GetChild(iter_36_10)

					if var_36_9.name == "" or not string.find(var_36_9.name, "split") then
						var_36_9.gameObject:SetActive(true)
					else
						var_36_9.gameObject:SetActive(false)
					end
				end
			end

			local var_36_10 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_10 then
				var_36_8.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_33_1.time_ - 0) / var_36_10)
			end

			if arg_33_1.time_ >= 0 + var_36_10 and arg_33_1.time_ < 0 + var_36_10 + arg_36_0 then
				var_36_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_36_11 = arg_33_1.actors_["104701"].transform

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos104701 = var_36_11.localPosition
				var_36_11.localScale = Vector3.New(1, 1, 1)

				arg_33_1:CheckSpriteTmpPos("104701", 3)

				for iter_36_11 = 0, var_36_11.childCount - 1 do
					local var_36_12 = var_36_11:GetChild(iter_36_11)

					if var_36_12.name == "" or not string.find(var_36_12.name, "split") then
						var_36_12.gameObject:SetActive(true)
					else
						var_36_12.gameObject:SetActive(false)
					end
				end
			end

			local var_36_13 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_13 then
				var_36_11.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_33_1.time_ - 0) / var_36_13)
			end

			if arg_33_1.time_ >= 0 + var_36_13 and arg_33_1.time_ < 0 + var_36_13 + arg_36_0 then
				var_36_11.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_36_14 = 0
			local var_36_15 = 0.975

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_16 = arg_33_1:GetWordFromCfg(926061008)
				local var_36_17 = arg_33_1:FormatText(var_36_16.content)

				arg_33_1.text_.text = var_36_17

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_19 = 39 <= 0 and var_36_15 or var_36_15 * (utf8.len(var_36_17) / 39)

				if (39 <= 0 and var_36_15 or var_36_15 * (utf8.len(var_36_17) / 39)) > 0 and var_36_15 < var_36_19 then
					arg_33_1.talkMaxDuration = var_36_19

					if var_36_19 + var_36_14 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_19 + var_36_14
					end
				end

				arg_33_1.text_.text = var_36_17
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061008", "story_v_out_926061.awb") ~= 0 then
					local var_36_20 = manager.audio:GetVoiceLength("story_v_out_926061", "926061008", "story_v_out_926061.awb") / 1000

					if var_36_20 + var_36_14 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_20 + var_36_14
					end

					if var_36_16.prefab_name ~= "" and arg_33_1.actors_[var_36_16.prefab_name] ~= nil then
						local var_36_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_16.prefab_name].transform, "story_v_out_926061", "926061008", "story_v_out_926061.awb")

						arg_33_1:RecordAudio("926061008", var_36_21)
						arg_33_1:RecordAudio("926061008", var_36_21)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_926061", "926061008", "story_v_out_926061.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_926061", "926061008", "story_v_out_926061.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_22 = math.max(var_36_15, arg_33_1.talkMaxDuration)

			if var_36_14 <= arg_33_1.time_ and arg_33_1.time_ < var_36_14 + var_36_22 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_14) / var_36_22

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_14 + var_36_22 and arg_33_1.time_ < var_36_14 + var_36_22 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
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
				actorName = "104701",
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
	Play926061009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 926061009
		arg_37_1.duration_ = 4.8

		local var_37_0 = {
			zh = 4.8,
			ja = 4.533
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
				arg_37_0:Play926061010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.actors_["106603"] == nil then
				local var_40_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106603")

				if not isNil(var_40_0) then
					local var_40_1 = Object.Instantiate(var_40_0, arg_37_1.canvasGo_.transform)

					var_40_1.transform:SetSiblingIndex(1)

					var_40_1.name = "106603"
					var_40_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_37_1.actors_["106603"] = var_40_1

					if arg_37_1.isInRecall_ then
						for iter_40_0, iter_40_1 in ipairs((var_40_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_40_1.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_40_2 = arg_37_1.actors_["106603"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps106603 == nil then
				arg_37_1.var_.actorSpriteComps106603 = var_40_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_3 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.actorSpriteComps106603 then
					for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_40_3 then
							if arg_37_1.isInRecall_ then
								iter_40_3.color = Color.New(Mathf.Lerp(iter_40_3.color.r, arg_37_1.hightColor1.r, (arg_37_1.time_ - 0) / var_40_3), Mathf.Lerp(iter_40_3.color.g, arg_37_1.hightColor1.g, (arg_37_1.time_ - 0) / var_40_3), (Mathf.Lerp(iter_40_3.color.b, arg_37_1.hightColor1.b, (arg_37_1.time_ - 0) / var_40_3)))
							else
								local var_40_4 = Mathf.Lerp(iter_40_3.color.r, 1, (arg_37_1.time_ - 0) / var_40_3)

								iter_40_3.color = Color.New(var_40_4, var_40_4, var_40_4)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.actorSpriteComps106603 then
				for iter_40_4, iter_40_5 in pairs(arg_37_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_40_5 then
						iter_40_5.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps106603 = nil
			end

			local var_40_5 = "10115"

			if arg_37_1.actors_["10115"] == nil then
				local var_40_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10115")

				if not isNil(var_40_6) then
					local var_40_7 = Object.Instantiate(var_40_6, arg_37_1.canvasGo_.transform)

					var_40_7.transform:SetSiblingIndex(1)

					var_40_7.name = var_40_5
					var_40_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_37_1.actors_[var_40_5] = var_40_7

					if arg_37_1.isInRecall_ then
						for iter_40_6, iter_40_7 in ipairs((var_40_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_40_7.color = arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_40_8 = arg_37_1.actors_["10115"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10115 == nil then
				arg_37_1.var_.actorSpriteComps10115 = var_40_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_9 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_9 and not isNil(var_40_8) then
				if arg_37_1.var_.actorSpriteComps10115 then
					for iter_40_8, iter_40_9 in pairs(arg_37_1.var_.actorSpriteComps10115:ToTable()) do
						if iter_40_9 then
							if arg_37_1.isInRecall_ then
								iter_40_9.color = Color.New(Mathf.Lerp(iter_40_9.color.r, arg_37_1.hightColor2.r, (arg_37_1.time_ - 0) / var_40_9), Mathf.Lerp(iter_40_9.color.g, arg_37_1.hightColor2.g, (arg_37_1.time_ - 0) / var_40_9), (Mathf.Lerp(iter_40_9.color.b, arg_37_1.hightColor2.b, (arg_37_1.time_ - 0) / var_40_9)))
							else
								local var_40_10 = Mathf.Lerp(iter_40_9.color.r, 0.5, (arg_37_1.time_ - 0) / var_40_9)

								iter_40_9.color = Color.New(var_40_10, var_40_10, var_40_10)
							end
						end
					end
				end
			end

			if arg_37_1.time_ >= 0 + var_40_9 and arg_37_1.time_ < 0 + var_40_9 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.actorSpriteComps10115 then
				for iter_40_10, iter_40_11 in pairs(arg_37_1.var_.actorSpriteComps10115:ToTable()) do
					if iter_40_11 then
						iter_40_11.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_37_1.var_.actorSpriteComps10115 = nil
			end

			local var_40_11 = arg_37_1.actors_["104701"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos104701 = var_40_11.localPosition
				var_40_11.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("104701", 7)

				for iter_40_12 = 0, var_40_11.childCount - 1 do
					local var_40_12 = var_40_11:GetChild(iter_40_12)

					if var_40_12.name == "" or not string.find(var_40_12.name, "split") then
						var_40_12.gameObject:SetActive(true)
					else
						var_40_12.gameObject:SetActive(false)
					end
				end
			end

			local var_40_13 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_13 then
				var_40_11.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_37_1.time_ - 0) / var_40_13)
			end

			if arg_37_1.time_ >= 0 + var_40_13 and arg_37_1.time_ < 0 + var_40_13 + arg_40_0 then
				var_40_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_40_14 = arg_37_1.actors_["106603"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos106603 = var_40_14.localPosition
				var_40_14.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("106603", 3)

				for iter_40_13 = 0, var_40_14.childCount - 1 do
					local var_40_15 = var_40_14:GetChild(iter_40_13)

					if var_40_15.name == "" or not string.find(var_40_15.name, "split") then
						var_40_15.gameObject:SetActive(true)
					else
						var_40_15.gameObject:SetActive(false)
					end
				end
			end

			local var_40_16 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_16 then
				var_40_14.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_37_1.time_ - 0) / var_40_16)
			end

			if arg_37_1.time_ >= 0 + var_40_16 and arg_37_1.time_ < 0 + var_40_16 + arg_40_0 then
				var_40_14.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_40_17 = 0
			local var_40_18 = 0.55

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_17 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_19 = arg_37_1:GetWordFromCfg(926061009)
				local var_40_20 = arg_37_1:FormatText(var_40_19.content)

				arg_37_1.text_.text = var_40_20

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_22 = 22 <= 0 and var_40_18 or var_40_18 * (utf8.len(var_40_20) / 22)

				if (22 <= 0 and var_40_18 or var_40_18 * (utf8.len(var_40_20) / 22)) > 0 and var_40_18 < var_40_22 then
					arg_37_1.talkMaxDuration = var_40_22

					if var_40_22 + var_40_17 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_17
					end
				end

				arg_37_1.text_.text = var_40_20
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061009", "story_v_out_926061.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_926061", "926061009", "story_v_out_926061.awb") / 1000

					if var_40_23 + var_40_17 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_17
					end

					if var_40_19.prefab_name ~= "" and arg_37_1.actors_[var_40_19.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_19.prefab_name].transform, "story_v_out_926061", "926061009", "story_v_out_926061.awb")

						arg_37_1:RecordAudio("926061009", var_40_24)
						arg_37_1:RecordAudio("926061009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_926061", "926061009", "story_v_out_926061.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_926061", "926061009", "story_v_out_926061.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_25 = math.max(var_40_18, arg_37_1.talkMaxDuration)

			if var_40_17 <= arg_37_1.time_ and arg_37_1.time_ < var_40_17 + var_40_25 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_17) / var_40_25

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_17 + var_40_25 and arg_37_1.time_ < var_40_17 + var_40_25 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106603",
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
	Play926061010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 926061010
		arg_41_1.duration_ = 7.67

		local var_41_0 = {
			zh = 6.866,
			ja = 7.666
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
				arg_41_0:Play926061011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if arg_41_1.actors_["106103"] == nil then
				local var_44_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106103")

				if not isNil(var_44_0) then
					local var_44_1 = Object.Instantiate(var_44_0, arg_41_1.canvasGo_.transform)

					var_44_1.transform:SetSiblingIndex(1)

					var_44_1.name = "106103"
					var_44_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_41_1.actors_["106103"] = var_44_1

					if arg_41_1.isInRecall_ then
						for iter_44_0, iter_44_1 in ipairs((var_44_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_44_1.color = arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_44_2 = arg_41_1.actors_["106103"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps106103 == nil then
				arg_41_1.var_.actorSpriteComps106103 = var_44_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_3 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.actorSpriteComps106103 then
					for iter_44_2, iter_44_3 in pairs(arg_41_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.actorSpriteComps106103 then
				for iter_44_4, iter_44_5 in pairs(arg_41_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_44_5 then
						iter_44_5.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_41_1.var_.actorSpriteComps106103 = nil
			end

			local var_44_5 = arg_41_1.actors_["106603"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.actorSpriteComps106603 == nil then
				arg_41_1.var_.actorSpriteComps106603 = var_44_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_44_6 = 0.2

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 and not isNil(var_44_5) then
				if arg_41_1.var_.actorSpriteComps106603 then
					for iter_44_6, iter_44_7 in pairs(arg_41_1.var_.actorSpriteComps106603:ToTable()) do
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

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.actorSpriteComps106603 then
				for iter_44_8, iter_44_9 in pairs(arg_41_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_44_9 then
						iter_44_9.color = arg_41_1.isInRecall_ and (arg_41_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_41_1.var_.actorSpriteComps106603 = nil
			end

			local var_44_8 = arg_41_1.actors_["106603"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos106603 = var_44_8.localPosition
				var_44_8.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("106603", 7)

				for iter_44_10 = 0, var_44_8.childCount - 1 do
					local var_44_9 = var_44_8:GetChild(iter_44_10)

					if var_44_9.name == "" or not string.find(var_44_9.name, "split") then
						var_44_9.gameObject:SetActive(true)
					else
						var_44_9.gameObject:SetActive(false)
					end
				end
			end

			local var_44_10 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_10 then
				var_44_8.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_41_1.time_ - 0) / var_44_10)
			end

			if arg_41_1.time_ >= 0 + var_44_10 and arg_41_1.time_ < 0 + var_44_10 + arg_44_0 then
				var_44_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_44_11 = arg_41_1.actors_["106103"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos106103 = var_44_11.localPosition
				var_44_11.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("106103", 3)

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
				var_44_11.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_41_1.time_ - 0) / var_44_13)
			end

			if arg_41_1.time_ >= 0 + var_44_13 and arg_41_1.time_ < 0 + var_44_13 + arg_44_0 then
				var_44_11.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_44_14 = 0
			local var_44_15 = 0.775

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_16 = arg_41_1:GetWordFromCfg(926061010)
				local var_44_17 = arg_41_1:FormatText(var_44_16.content)

				arg_41_1.text_.text = var_44_17

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_19 = 31 <= 0 and var_44_15 or var_44_15 * (utf8.len(var_44_17) / 31)

				if (31 <= 0 and var_44_15 or var_44_15 * (utf8.len(var_44_17) / 31)) > 0 and var_44_15 < var_44_19 then
					arg_41_1.talkMaxDuration = var_44_19

					if var_44_19 + var_44_14 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_14
					end
				end

				arg_41_1.text_.text = var_44_17
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061010", "story_v_out_926061.awb") ~= 0 then
					local var_44_20 = manager.audio:GetVoiceLength("story_v_out_926061", "926061010", "story_v_out_926061.awb") / 1000

					if var_44_20 + var_44_14 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_20 + var_44_14
					end

					if var_44_16.prefab_name ~= "" and arg_41_1.actors_[var_44_16.prefab_name] ~= nil then
						local var_44_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_16.prefab_name].transform, "story_v_out_926061", "926061010", "story_v_out_926061.awb")

						arg_41_1:RecordAudio("926061010", var_44_21)
						arg_41_1:RecordAudio("926061010", var_44_21)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_926061", "926061010", "story_v_out_926061.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_926061", "926061010", "story_v_out_926061.awb")
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
				actorName = "106603",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "106103",
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
	Play926061011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 926061011
		arg_45_1.duration_ = 2.4

		local var_45_0 = {
			zh = 2.066,
			ja = 2.4
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
				arg_45_0:Play926061012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10144"]) and arg_45_1.var_.actorSpriteComps10144 == nil then
				arg_45_1.var_.actorSpriteComps10144 = arg_45_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_0 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10144"]) then
				if arg_45_1.var_.actorSpriteComps10144 then
					for iter_48_0, iter_48_1 in pairs(arg_45_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10144"]) and arg_45_1.var_.actorSpriteComps10144 then
				for iter_48_2, iter_48_3 in pairs(arg_45_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_48_3 then
						iter_48_3.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_45_1.var_.actorSpriteComps10144 = nil
			end

			local var_48_2 = arg_45_1.actors_["106103"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps106103 == nil then
				arg_45_1.var_.actorSpriteComps106103 = var_48_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_48_3 = 0.2

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.actorSpriteComps106103 then
					for iter_48_4, iter_48_5 in pairs(arg_45_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.actorSpriteComps106103 then
				for iter_48_6, iter_48_7 in pairs(arg_45_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_48_7 then
						iter_48_7.color = arg_45_1.isInRecall_ and (arg_45_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_45_1.var_.actorSpriteComps106103 = nil
			end

			local var_48_5 = arg_45_1.actors_["106103"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos106103 = var_48_5.localPosition
				var_48_5.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("106103", 7)

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
				var_48_5.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_45_1.time_ - 0) / var_48_7)
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				var_48_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_48_8 = arg_45_1.actors_["10144"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos10144 = var_48_8.localPosition
				var_48_8.localScale = Vector3.New(1, 1, 1)

				arg_45_1:CheckSpriteTmpPos("10144", 3)

				for iter_48_9 = 0, var_48_8.childCount - 1 do
					local var_48_9 = var_48_8:GetChild(iter_48_9)

					if var_48_9.name == "split_6" or not string.find(var_48_9.name, "split") then
						var_48_9.gameObject:SetActive(true)
					else
						var_48_9.gameObject:SetActive(false)
					end
				end
			end

			local var_48_10 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_10 then
				var_48_8.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_45_1.time_ - 0) / var_48_10)
			end

			if arg_45_1.time_ >= 0 + var_48_10 and arg_45_1.time_ < 0 + var_48_10 + arg_48_0 then
				var_48_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_48_11 = 0
			local var_48_12 = 0.2

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_11 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_13 = arg_45_1:GetWordFromCfg(926061011)
				local var_48_14 = arg_45_1:FormatText(var_48_13.content)

				arg_45_1.text_.text = var_48_14

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_16 = 8 <= 0 and var_48_12 or var_48_12 * (utf8.len(var_48_14) / 8)

				if (8 <= 0 and var_48_12 or var_48_12 * (utf8.len(var_48_14) / 8)) > 0 and var_48_12 < var_48_16 then
					arg_45_1.talkMaxDuration = var_48_16

					if var_48_16 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_16 + var_48_11
					end
				end

				arg_45_1.text_.text = var_48_14
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061011", "story_v_out_926061.awb") ~= 0 then
					local var_48_17 = manager.audio:GetVoiceLength("story_v_out_926061", "926061011", "story_v_out_926061.awb") / 1000

					if var_48_17 + var_48_11 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_17 + var_48_11
					end

					if var_48_13.prefab_name ~= "" and arg_45_1.actors_[var_48_13.prefab_name] ~= nil then
						local var_48_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_13.prefab_name].transform, "story_v_out_926061", "926061011", "story_v_out_926061.awb")

						arg_45_1:RecordAudio("926061011", var_48_18)
						arg_45_1:RecordAudio("926061011", var_48_18)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_926061", "926061011", "story_v_out_926061.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_926061", "926061011", "story_v_out_926061.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_19 = math.max(var_48_12, arg_45_1.talkMaxDuration)

			if var_48_11 <= arg_45_1.time_ and arg_45_1.time_ < var_48_11 + var_48_19 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_11) / var_48_19

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_11 + var_48_19 and arg_45_1.time_ < var_48_11 + var_48_19 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106103",
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

		arg_45_1:InitPlayNodeList()
	end,
	Play926061012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 926061012
		arg_49_1.duration_ = 8.2

		local var_49_0 = {
			zh = 6.4,
			ja = 8.2
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
				arg_49_0:Play926061013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.775

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:GetWordFromCfg(926061012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 31 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 31)

				if (31 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 31)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061012", "story_v_out_926061.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_926061", "926061012", "story_v_out_926061.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_926061", "926061012", "story_v_out_926061.awb")

						arg_49_1:RecordAudio("926061012", var_52_6)
						arg_49_1:RecordAudio("926061012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_926061", "926061012", "story_v_out_926061.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_926061", "926061012", "story_v_out_926061.awb")
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
	Play926061013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 926061013
		arg_53_1.duration_ = 10.73

		local var_53_0 = {
			zh = 10.433,
			ja = 10.733
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
				arg_53_0:Play926061014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.175

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(926061013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 47 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 47)

				if (47 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 47)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061013", "story_v_out_926061.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_926061", "926061013", "story_v_out_926061.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_926061", "926061013", "story_v_out_926061.awb")

						arg_53_1:RecordAudio("926061013", var_56_6)
						arg_53_1:RecordAudio("926061013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_926061", "926061013", "story_v_out_926061.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_926061", "926061013", "story_v_out_926061.awb")
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
	Play926061014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 926061014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play926061015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10144"]) and arg_57_1.var_.actorSpriteComps10144 == nil then
				arg_57_1.var_.actorSpriteComps10144 = arg_57_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_60_0 = 0.2

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10144"]) then
				if arg_57_1.var_.actorSpriteComps10144 then
					for iter_60_0, iter_60_1 in pairs(arg_57_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_60_1 then
							if arg_57_1.isInRecall_ then
								iter_60_1.color = Color.New(Mathf.Lerp(iter_60_1.color.r, arg_57_1.hightColor2.r, (arg_57_1.time_ - 0) / var_60_0), Mathf.Lerp(iter_60_1.color.g, arg_57_1.hightColor2.g, (arg_57_1.time_ - 0) / var_60_0), (Mathf.Lerp(iter_60_1.color.b, arg_57_1.hightColor2.b, (arg_57_1.time_ - 0) / var_60_0)))
							else
								local var_60_1 = Mathf.Lerp(iter_60_1.color.r, 0.5, (arg_57_1.time_ - 0) / var_60_0)

								iter_60_1.color = Color.New(var_60_1, var_60_1, var_60_1)
							end
						end
					end
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10144"]) and arg_57_1.var_.actorSpriteComps10144 then
				for iter_60_2, iter_60_3 in pairs(arg_57_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_60_3 then
						iter_60_3.color = arg_57_1.isInRecall_ and (arg_57_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_57_1.var_.actorSpriteComps10144 = nil
			end

			local var_60_2 = 0
			local var_60_3 = 0.0329999998211861

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_2 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[1298].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(926061014).content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_6 = 1 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_4) / 1)

				if (1 <= 0 and var_60_3 or var_60_3 * (utf8.len(var_60_4) / 1)) > 0 and var_60_3 < var_60_6 then
					arg_57_1.talkMaxDuration = var_60_6

					if var_60_6 + var_60_2 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_6 + var_60_2
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_3, arg_57_1.talkMaxDuration)

			if var_60_2 <= arg_57_1.time_ and arg_57_1.time_ < var_60_2 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_2) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_2 + var_60_7 and arg_57_1.time_ < var_60_2 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play926061015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 926061015
		arg_61_1.duration_ = 1

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play926061016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["106603"]) and arg_61_1.var_.actorSpriteComps106603 == nil then
				arg_61_1.var_.actorSpriteComps106603 = arg_61_1.actors_["106603"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["106603"]) then
				if arg_61_1.var_.actorSpriteComps106603 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								iter_64_1.color = Color.New(Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor1.r, (arg_61_1.time_ - 0) / var_64_0), Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor1.g, (arg_61_1.time_ - 0) / var_64_0), (Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor1.b, (arg_61_1.time_ - 0) / var_64_0)))
							else
								local var_64_1 = Mathf.Lerp(iter_64_1.color.r, 1, (arg_61_1.time_ - 0) / var_64_0)

								iter_64_1.color = Color.New(var_64_1, var_64_1, var_64_1)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["106603"]) and arg_61_1.var_.actorSpriteComps106603 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_61_1.var_.actorSpriteComps106603 = nil
			end

			local var_64_2 = arg_61_1.actors_["10144"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10144 = var_64_2.localPosition
				var_64_2.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("10144", 7)

				for iter_64_4 = 0, var_64_2.childCount - 1 do
					local var_64_3 = var_64_2:GetChild(iter_64_4)

					if var_64_3.name == "" or not string.find(var_64_3.name, "split") then
						var_64_3.gameObject:SetActive(true)
					else
						var_64_3.gameObject:SetActive(false)
					end
				end
			end

			local var_64_4 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_4 then
				var_64_2.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_61_1.time_ - 0) / var_64_4)
			end

			if arg_61_1.time_ >= 0 + var_64_4 and arg_61_1.time_ < 0 + var_64_4 + arg_64_0 then
				var_64_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_64_5 = arg_61_1.actors_["106603"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos106603 = var_64_5.localPosition
				var_64_5.localScale = Vector3.New(1, 1, 1)

				arg_61_1:CheckSpriteTmpPos("106603", 3)

				for iter_64_5 = 0, var_64_5.childCount - 1 do
					local var_64_6 = var_64_5:GetChild(iter_64_5)

					if var_64_6.name == "split_2" or not string.find(var_64_6.name, "split") then
						var_64_6.gameObject:SetActive(true)
					else
						var_64_6.gameObject:SetActive(false)
					end
				end
			end

			local var_64_7 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 then
				var_64_5.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos106603, Vector3.New(-77.5, -399.1, -303.3), (arg_61_1.time_ - 0) / var_64_7)
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 then
				var_64_5.localPosition = Vector3.New(-77.5, -399.1, -303.3)
			end

			local var_64_8 = 0
			local var_64_9 = 0.05

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_10 = arg_61_1:GetWordFromCfg(926061015)
				local var_64_11 = arg_61_1:FormatText(var_64_10.content)

				arg_61_1.text_.text = var_64_11

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 2 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 2)

				if (2 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 2)) > 0 and var_64_9 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_11
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061015", "story_v_out_926061.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_926061", "926061015", "story_v_out_926061.awb") / 1000

					if var_64_14 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_8
					end

					if var_64_10.prefab_name ~= "" and arg_61_1.actors_[var_64_10.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_10.prefab_name].transform, "story_v_out_926061", "926061015", "story_v_out_926061.awb")

						arg_61_1:RecordAudio("926061015", var_64_15)
						arg_61_1:RecordAudio("926061015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_926061", "926061015", "story_v_out_926061.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_926061", "926061015", "story_v_out_926061.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_16 and arg_61_1.time_ < var_64_8 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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
				assetPath = "",
				actorName = "106603",
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
	Play926061016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 926061016
		arg_65_1.duration_ = 4.33

		local var_65_0 = {
			zh = 3.7,
			ja = 4.333
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
				arg_65_0:Play926061017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10144"]) and arg_65_1.var_.actorSpriteComps10144 == nil then
				arg_65_1.var_.actorSpriteComps10144 = arg_65_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_0 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10144"]) then
				if arg_65_1.var_.actorSpriteComps10144 then
					for iter_68_0, iter_68_1 in pairs(arg_65_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10144"]) and arg_65_1.var_.actorSpriteComps10144 then
				for iter_68_2, iter_68_3 in pairs(arg_65_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_68_3 then
						iter_68_3.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_65_1.var_.actorSpriteComps10144 = nil
			end

			local var_68_2 = arg_65_1.actors_["106603"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps106603 == nil then
				arg_65_1.var_.actorSpriteComps106603 = var_68_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_68_3 = 0.2

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.actorSpriteComps106603 then
					for iter_68_4, iter_68_5 in pairs(arg_65_1.var_.actorSpriteComps106603:ToTable()) do
						if iter_68_5 then
							if arg_65_1.isInRecall_ then
								iter_68_5.color = Color.New(Mathf.Lerp(iter_68_5.color.r, arg_65_1.hightColor2.r, (arg_65_1.time_ - 0) / var_68_3), Mathf.Lerp(iter_68_5.color.g, arg_65_1.hightColor2.g, (arg_65_1.time_ - 0) / var_68_3), (Mathf.Lerp(iter_68_5.color.b, arg_65_1.hightColor2.b, (arg_65_1.time_ - 0) / var_68_3)))
							else
								local var_68_4 = Mathf.Lerp(iter_68_5.color.r, 0.5, (arg_65_1.time_ - 0) / var_68_3)

								iter_68_5.color = Color.New(var_68_4, var_68_4, var_68_4)
							end
						end
					end
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.actorSpriteComps106603 then
				for iter_68_6, iter_68_7 in pairs(arg_65_1.var_.actorSpriteComps106603:ToTable()) do
					if iter_68_7 then
						iter_68_7.color = arg_65_1.isInRecall_ and (arg_65_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_65_1.var_.actorSpriteComps106603 = nil
			end

			local var_68_5 = arg_65_1.actors_["106603"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos106603 = var_68_5.localPosition
				var_68_5.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("106603", 7)

				for iter_68_8 = 0, var_68_5.childCount - 1 do
					local var_68_6 = var_68_5:GetChild(iter_68_8)

					if var_68_6.name == "" or not string.find(var_68_6.name, "split") then
						var_68_6.gameObject:SetActive(true)
					else
						var_68_6.gameObject:SetActive(false)
					end
				end
			end

			local var_68_7 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 then
				var_68_5.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos106603, Vector3.New(0, -2000, 0), (arg_65_1.time_ - 0) / var_68_7)
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 then
				var_68_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_68_8 = arg_65_1.actors_["10144"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos10144 = var_68_8.localPosition
				var_68_8.localScale = Vector3.New(1, 1, 1)

				arg_65_1:CheckSpriteTmpPos("10144", 3)

				for iter_68_9 = 0, var_68_8.childCount - 1 do
					local var_68_9 = var_68_8:GetChild(iter_68_9)

					if var_68_9.name == "split_5" or not string.find(var_68_9.name, "split") then
						var_68_9.gameObject:SetActive(true)
					else
						var_68_9.gameObject:SetActive(false)
					end
				end
			end

			local var_68_10 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_10 then
				var_68_8.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_65_1.time_ - 0) / var_68_10)
			end

			if arg_65_1.time_ >= 0 + var_68_10 and arg_65_1.time_ < 0 + var_68_10 + arg_68_0 then
				var_68_8.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_68_11 = 0
			local var_68_12 = 0.5

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_11 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_13 = arg_65_1:GetWordFromCfg(926061016)
				local var_68_14 = arg_65_1:FormatText(var_68_13.content)

				arg_65_1.text_.text = var_68_14

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_16 = 20 <= 0 and var_68_12 or var_68_12 * (utf8.len(var_68_14) / 20)

				if (20 <= 0 and var_68_12 or var_68_12 * (utf8.len(var_68_14) / 20)) > 0 and var_68_12 < var_68_16 then
					arg_65_1.talkMaxDuration = var_68_16

					if var_68_16 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_16 + var_68_11
					end
				end

				arg_65_1.text_.text = var_68_14
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061016", "story_v_out_926061.awb") ~= 0 then
					local var_68_17 = manager.audio:GetVoiceLength("story_v_out_926061", "926061016", "story_v_out_926061.awb") / 1000

					if var_68_17 + var_68_11 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_17 + var_68_11
					end

					if var_68_13.prefab_name ~= "" and arg_65_1.actors_[var_68_13.prefab_name] ~= nil then
						local var_68_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_13.prefab_name].transform, "story_v_out_926061", "926061016", "story_v_out_926061.awb")

						arg_65_1:RecordAudio("926061016", var_68_18)
						arg_65_1:RecordAudio("926061016", var_68_18)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_926061", "926061016", "story_v_out_926061.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_926061", "926061016", "story_v_out_926061.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_19 = math.max(var_68_12, arg_65_1.talkMaxDuration)

			if var_68_11 <= arg_65_1.time_ and arg_65_1.time_ < var_68_11 + var_68_19 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_11) / var_68_19

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_11 + var_68_19 and arg_65_1.time_ < var_68_11 + var_68_19 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "106603",
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

		arg_65_1:InitPlayNodeList()
	end,
	Play926061017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 926061017
		arg_69_1.duration_ = 12.63

		local var_69_0 = {
			zh = 9.166,
			ja = 12.633
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
				arg_69_0:Play926061018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos10144 = arg_69_1.actors_["10144"].transform.localPosition
				arg_69_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_69_1:CheckSpriteTmpPos("10144", 3)

				for iter_72_0 = 0, arg_69_1.actors_["10144"].transform.childCount - 1 do
					local var_72_0 = arg_69_1.actors_["10144"].transform:GetChild(iter_72_0)

					if var_72_0.name == "split_4" or not string.find(var_72_0.name, "split") then
						var_72_0.gameObject:SetActive(true)
					else
						var_72_0.gameObject:SetActive(false)
					end
				end
			end

			local var_72_1 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_1 then
				arg_69_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_69_1.time_ - 0) / var_72_1)
			end

			if arg_69_1.time_ >= 0 + var_72_1 and arg_69_1.time_ < 0 + var_72_1 + arg_72_0 then
				arg_69_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_72_2 = 0
			local var_72_3 = 1.025

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_4 = arg_69_1:GetWordFromCfg(926061017)
				local var_72_5 = arg_69_1:FormatText(var_72_4.content)

				arg_69_1.text_.text = var_72_5

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 41 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 41)

				if (41 <= 0 and var_72_3 or var_72_3 * (utf8.len(var_72_5) / 41)) > 0 and var_72_3 < var_72_7 then
					arg_69_1.talkMaxDuration = var_72_7

					if var_72_7 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_5
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061017", "story_v_out_926061.awb") ~= 0 then
					local var_72_8 = manager.audio:GetVoiceLength("story_v_out_926061", "926061017", "story_v_out_926061.awb") / 1000

					if var_72_8 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_2
					end

					if var_72_4.prefab_name ~= "" and arg_69_1.actors_[var_72_4.prefab_name] ~= nil then
						local var_72_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_4.prefab_name].transform, "story_v_out_926061", "926061017", "story_v_out_926061.awb")

						arg_69_1:RecordAudio("926061017", var_72_9)
						arg_69_1:RecordAudio("926061017", var_72_9)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_926061", "926061017", "story_v_out_926061.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_926061", "926061017", "story_v_out_926061.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_10 = math.max(var_72_3, arg_69_1.talkMaxDuration)

			if var_72_2 <= arg_69_1.time_ and arg_69_1.time_ < var_72_2 + var_72_10 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_2) / var_72_10

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_2 + var_72_10 and arg_69_1.time_ < var_72_2 + var_72_10 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play926061018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 926061018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play926061019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10144"]) and arg_73_1.var_.actorSpriteComps10144 == nil then
				arg_73_1.var_.actorSpriteComps10144 = arg_73_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10144"]) then
				if arg_73_1.var_.actorSpriteComps10144 then
					for iter_76_0, iter_76_1 in pairs(arg_73_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10144"]) and arg_73_1.var_.actorSpriteComps10144 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_73_1.var_.actorSpriteComps10144 = nil
			end

			local var_76_2 = 0
			local var_76_3 = 0.3

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_4 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(926061018).content)

				arg_73_1.text_.text = var_76_4

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_6 = 12 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 12)

				if (12 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_4) / 12)) > 0 and var_76_3 < var_76_6 then
					arg_73_1.talkMaxDuration = var_76_6

					if var_76_6 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_6 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_4
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_7 and arg_73_1.time_ < var_76_2 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play926061019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 926061019
		arg_77_1.duration_ = 6.87

		local var_77_0 = {
			zh = 6.266,
			ja = 6.866
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
			arg_77_1.auto_ = false
		end

		function arg_77_1.playNext_(arg_79_0)
			arg_77_1.onStoryFinished_()
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10144"]) and arg_77_1.var_.actorSpriteComps10144 == nil then
				arg_77_1.var_.actorSpriteComps10144 = arg_77_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10144"]) then
				if arg_77_1.var_.actorSpriteComps10144 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10144"]) and arg_77_1.var_.actorSpriteComps10144 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_80_3 then
						iter_80_3.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_77_1.var_.actorSpriteComps10144 = nil
			end

			local var_80_2 = arg_77_1.actors_["10144"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10144 = var_80_2.localPosition
				var_80_2.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10144", 3)

				for iter_80_4 = 0, var_80_2.childCount - 1 do
					local var_80_3 = var_80_2:GetChild(iter_80_4)

					if var_80_3.name == "split_6" or not string.find(var_80_3.name, "split") then
						var_80_3.gameObject:SetActive(true)
					else
						var_80_3.gameObject:SetActive(false)
					end
				end
			end

			local var_80_4 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				var_80_2.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_77_1.time_ - 0) / var_80_4)
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				var_80_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_80_5 = 0
			local var_80_6 = 0.725

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_5 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_7 = arg_77_1:GetWordFromCfg(926061019)
				local var_80_8 = arg_77_1:FormatText(var_80_7.content)

				arg_77_1.text_.text = var_80_8

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_10 = 29 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 29)

				if (29 <= 0 and var_80_6 or var_80_6 * (utf8.len(var_80_8) / 29)) > 0 and var_80_6 < var_80_10 then
					arg_77_1.talkMaxDuration = var_80_10

					if var_80_10 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_5
					end
				end

				arg_77_1.text_.text = var_80_8
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926061", "926061019", "story_v_out_926061.awb") ~= 0 then
					local var_80_11 = manager.audio:GetVoiceLength("story_v_out_926061", "926061019", "story_v_out_926061.awb") / 1000

					if var_80_11 + var_80_5 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_11 + var_80_5
					end

					if var_80_7.prefab_name ~= "" and arg_77_1.actors_[var_80_7.prefab_name] ~= nil then
						local var_80_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_7.prefab_name].transform, "story_v_out_926061", "926061019", "story_v_out_926061.awb")

						arg_77_1:RecordAudio("926061019", var_80_12)
						arg_77_1:RecordAudio("926061019", var_80_12)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_926061", "926061019", "story_v_out_926061.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_926061", "926061019", "story_v_out_926061.awb")
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
				actorName = "10144",
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
	assets = {
		"TextureConfig/Background/ST0114"
	},
	voices = {
		"story_v_out_926061.awb"
	}
}
